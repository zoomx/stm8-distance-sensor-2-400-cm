#include "board.h"
#include "sst25vf016b75.h"
/*
Every time data is stored in flash memory a pointer to the next free memory location in flash is updated in SECTOR 0.
For this purpose multiple continuous memory locations are used in SECTOR 0 for wear-levelling.
When all these memory locations are occupied, the whole sector is erased and we start over.
Data is meant to be stored as fixed lenght frame.
*/

#define FLASH_UNLOCK_VAL      (u8)0x00
#define PTR_ARR_SEC_ADR       (u32)0x000000   //SECTOR 0
#define PTR_SEC_SIZE          (u16)4096       //SECTOR 0 size
#define FLASH_MAX_ADR         (u32)0x1FFFFF   //MAX addressable flash memory location
#define PTR_ERASED_VAL        (u32)0xFFFFFF   //value of 3 continuous erased flash memory bytes
#define BYTE_ERASED_VAL       (u8)0xFF
#define PTR_ARR_ADR_OFFST     (u16)0          //offset in sector where the flash pointer array is stored
#define PTR_ARR_BASE          (PTR_ARR_SEC_ADR + PTR_ARR_ADR_OFFST)
#define PTR_ARR_LEN           (u8)1365        //make use of whole sector 0 size, 1365*3=4095 - flash pointer array size (used for wear levelling of the flash)
#define DATA_STORAGE_BASE     (u32)0x001000   //flash data storage address base
#define PTR_SIZE              (u8)3           //flash pointer size in bytes to be stored in PTR_ARR
#define TEST_ERASED_BYTES_NUM (u8)10
#define PTR_ARR_SIZE          (PTR_ARR_LEN * PTR_SIZE)
#define INVALID_ADR(_adr)     (((u32)_adr > FLASH_MAX_ADR) && ((u32)_adr < PTR_ERASED_VAL))   //macro to determine if _adr is an invalid flash memory address (different to the erased value)
#define PTR_OUT_OF_ARR(_adr)  ( _adr >= (PTR_ARR_BASE + PTR_ARR_SIZE))                                     //macro to determine if _adr is out of PTR_ARR

static union
{
  struct
  {
    u8 PTR_ARR_Full      :1;   //set when PTR_ARR is full
    u8 FlashPtr_was_Read :1;   //set when FlashMngr_GetPointer() function was called and valid flash pointer was returned
    u8 Flash_Full        :1;   //set when Flash memory is full, no more data can be stored
    u8 Flash_was_Read    :1;   //set when Flash memory was Read, we assume that that we can erase the chip without data loss
    u8 Flash_no_space    :1;   //set when FlashMngr_StoreData(u8*, u16) function was called but there was not enough space to store the chunk of data
    u8 Operation_refused :1;   //operation refused by flash manager because the flash pointer was no read successfully or at all, or because of other errors
  }Status_bits;
  u8 Status;
}EXTFLASH_STAT;

static union
{
  struct
  {
    u8 Inconsistent_ERR     :1;   //set when invalid data is found in PTR_ARR
    u8 Unknown_ERR          :1;   //CRITICAL: Unknown error
    u8 Invalid_FlashPtr_ERR :1;   //CRITICAL: Invalid Flash pointer address
    u8 PTR_SEC_Erase_ERR    :1;   //CRITICAL: erase operation did not pass verification
    u8 Flash_Erase_ERR      :1;   //CRITICAL: erase flash operation did not pass verification
    u8 Data_Store_ERR       :1;   //data storage operation did not pass verification
    u8 Memory_Locked_ERR    :1;   //CRITICAL: memory patially or fully locked
  }Error_bits;
  u8 Error;
}EXTFLASH_ERR;

static _Bool DisableMemOP;
static u8 buffer[PTR_SIZE];
static ExtFlashAdr flash_ptr;     //address of the next free flash memory location
static ExtFlashAdr pointer_adr;   //address of the next flash pointer in the flash pointer array

_Bool FlashMngr_GetPointer(void);
u32 FlashMngr_GetOccupiedSpace(void);

u8 FlashMngr_GetStatus()
{
  return EXTFLASH_STAT.Status;
}

u8 FlashMngr_GetErrors()
{
  return EXTFLASH_ERR.Error;
}

_Bool FlashMngr_Init()
{
  _Bool tmp;
  u8 tmpstatus; 
  ExtFlashAdr tmpadr;
  SST25VF016_Init();
  tmpstatus = SST25VF016_Read_Status_Register();
  flash_ptr.adr32b = DATA_STORAGE_BASE;
  pointer_adr.adr32b = PTR_ARR_BASE;
  DisableMemOP = FALSE;
  tmp = FlashMngr_GetPointer();
  //Unlock SPI flash memory for writing
  SST25VF016_Write_Status_Register(FLASH_UNLOCK_VAL); 
  //Check if memory was unlocked
  if(SST25VF016_Read_Status_Register() & (STATUS_BP0 | STATUS_BP1 | STATUS_BP2))
  {
    EXTFLASH_ERR.Error_bits.Memory_Locked_ERR = 1;
    return FALSE;
  }
  return tmp;
}

/*
Internal primitive to read 3 bytes of data from a specified memory address and pack them to an u32
*/
u32 FlashMngr_ReadPointer(ExtFlashAdr ptr_adr)
{
  ExtFlashAdr ptr;
  ptr.adr32b = 0;
  SST25VF016_Read(ptr_adr, buffer, 3);
  ptr.adr8b.HighByte = buffer[0];
  ptr.adr8b.MidByte = buffer[1];
  ptr.adr8b.LowByte = buffer[2];
  return ptr.adr32b;
}

/*
  Get next free Flash memory location
*/
_Bool FlashMngr_GetPointer()
{
  u32 ptr_old, ptr_new;
  u8 i;
  s16 imin, imid, imax;
  ExtFlashAdr tmpadr;
  if(EXTFLASH_ERR.Error_bits.Inconsistent_ERR)
  {
    return FALSE;
  }
  tmpadr.adr32b = PTR_ARR_BASE;
  ptr_old = FlashMngr_ReadPointer(tmpadr);
  if(INVALID_ADR(ptr_old))
  {
    EXTFLASH_ERR.Error_bits.Invalid_FlashPtr_ERR = 1;
    EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
    return FALSE;
  }
  if(ptr_old == PTR_ERASED_VAL)
  {
    //Check if data storage space is empty
    tmpadr.adr32b = DATA_STORAGE_BASE;
    for(i = 0; i < TEST_ERASED_BYTES_NUM; i++)
    {
      if(SST25VF016_Read_Byte(tmpadr) != BYTE_ERASED_VAL) 
      {
        EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
        return FALSE;
      }
      tmpadr.adr32b++;
    }
    flash_ptr.adr32b = DATA_STORAGE_BASE;
    pointer_adr.adr32b = PTR_ARR_BASE;
    EXTFLASH_STAT.Status_bits.FlashPtr_was_Read = 1;
    return TRUE;
  }
  //Binary Search of the last written address (which is < 0xFFFFFF (PTR_ERASED_VAL))
  imin = 0;
  imax = PTR_ARR_LEN - 1;
  while(imax >= imin)
  {
    imid = (imin + imax) / 2;
    tmpadr.adr32b = PTR_ARR_BASE + ((imid) * PTR_SIZE);
    ptr_new = FlashMngr_ReadPointer(tmpadr);
    if(ptr_new < PTR_ERASED_VAL) 
    {
      imin = imid + 1;
    }
    else 
    {
      if(ptr_new == PTR_ERASED_VAL)
      {
        imax = imid - 1;
      }
    }
  }
  //imid is pointing to the first occurence of 0xFFFFFF or the element before it (if we reach this point, the element before is < 0xFFFFFF)
  if(ptr_new == PTR_ERASED_VAL)
  {
    tmpadr.adr32b -= PTR_SIZE;                //position to the element before the erased value
    ptr_new = FlashMngr_ReadPointer(tmpadr);  //read the flash pointer there
    if(INVALID_ADR(ptr_new))
    {
      //if flash pointer address is invalid
      EXTFLASH_ERR.Error_bits.Invalid_FlashPtr_ERR = 1;
      EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
      return FALSE;
    }
    //if flash pointer address is valid
    flash_ptr.adr32b = ptr_new;
    pointer_adr.adr32b = tmpadr.adr32b + PTR_SIZE;
    EXTFLASH_STAT.Status_bits.FlashPtr_was_Read = 1;
    return TRUE;
  }
  //if returned flash pointer is < 0xFFFFFF (PTR_ERASED_VAL)
  flash_ptr.adr32b = ptr_new;
  pointer_adr.adr32b = tmpadr.adr32b + PTR_SIZE;
  EXTFLASH_STAT.Status_bits.FlashPtr_was_Read = 1;
  if(imid == (PTR_ARR_LEN - 1))
  {
    EXTFLASH_STAT.Status_bits.PTR_ARR_Full = 1;
  }
  return TRUE;
}

_Bool FlashMngr_SavePointer(ExtFlashAdr adr)
{
  u32 tmp;
  ExtFlashAdr tmpadr;
  if(EXTFLASH_ERR.Error_bits.Memory_Locked_ERR || DisableMemOP)
  {
    //Operation refused, memory locked error
    EXTFLASH_STAT.Status_bits.Operation_refused = 1;
    return FALSE;
  }
  if(EXTFLASH_STAT.Status_bits.FlashPtr_was_Read)
  {
    EXTFLASH_STAT.Status_bits.Operation_refused = 0;
    //if PTR_ARR full then erase PTR_ARR sector and set pointer_adr to PTR_ARR_BASE
    if(EXTFLASH_STAT.Status_bits.PTR_ARR_Full)
    {
      tmpadr.adr32b = PTR_ARR_BASE;
      SST25VF016_Sector_Erase_4KB(tmpadr);
      //Wait until erase operation is completed
      while(SST25VF016_Read_Status_Register() & STATUS_BUSY);
      //Verify if the Sector was erased
      if(FlashMngr_ReadPointer(tmpadr) != PTR_ERASED_VAL) 
      {
        EXTFLASH_ERR.Error_bits.PTR_SEC_Erase_ERR = 1;
        EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
        return FALSE;
      }
      EXTFLASH_STAT.Status_bits.PTR_ARR_Full = 0;
      pointer_adr.adr32b = PTR_ARR_BASE;
    }
    //Write pointer to next free location
    SST25VF016_Program_Byte(pointer_adr, adr.adr8b.HighByte);
    pointer_adr.adr32b++;
    SST25VF016_Program_Byte(pointer_adr, adr.adr8b.MidByte);
    pointer_adr.adr32b++;
    SST25VF016_Program_Byte(pointer_adr, adr.adr8b.LowByte);
    pointer_adr.adr32b++;
    //Set PTR_ARR_Full flag if array full
    if(PTR_OUT_OF_ARR(pointer_adr.adr32b))
    {
      EXTFLASH_STAT.Status_bits.PTR_ARR_Full = 1;
    }
    //Verify what was written
    tmpadr.adr32b = pointer_adr.adr32b - PTR_SIZE;
    tmp = FlashMngr_ReadPointer(tmpadr);
    if(tmp == adr.adr32b) return TRUE;
    //if stored pointer is altered
    EXTFLASH_ERR.Error_bits.Data_Store_ERR = 1;
    EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
    return FALSE;
  }
  //Operation refused by flash manager, no valid flash poiner was read, or flash pointer was not read at all
  EXTFLASH_STAT.Status_bits.Operation_refused = 1;
  return FALSE;
}

_Bool FlashMngr_StoreData(u8* data, u16 size)
{
  u8 i, tmp;
  if(EXTFLASH_ERR.Error_bits.Memory_Locked_ERR || DisableMemOP)
  {
    //Operation refused, memory locked error
    EXTFLASH_STAT.Status_bits.Operation_refused = 1;
    return FALSE;
  }
  if(EXTFLASH_STAT.Status_bits.FlashPtr_was_Read)
  {
    EXTFLASH_STAT.Status_bits.Operation_refused = 0;
    //verify that we have enough free space in flash memory to write the requested data
    if(flash_ptr.adr32b + (size-1) > FLASH_MAX_ADR) 
    {
      EXTFLASH_STAT.Status_bits.Flash_no_space = 1;
      return FALSE;
    }
    EXTFLASH_STAT.Status_bits.Flash_no_space = 0;
    for(i = 0; i < size; i++)
    {
      SST25VF016_Program_Byte(flash_ptr, data[i]);
      //verify was was actually written
      tmp = SST25VF016_Read_Byte(flash_ptr);
      flash_ptr.adr32b++;
      //if what was written wasn't as expected
      if(tmp != data[i])
      {
        EXTFLASH_ERR.Error_bits.Data_Store_ERR = 1;
        EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
        return FALSE;
      }
    }
    FlashMngr_SavePointer(flash_ptr);
    return TRUE;
  }
  //Operation refused by flash manager, no valid flash poiner was read, or flash pointer was not read at all
  EXTFLASH_STAT.Status_bits.Operation_refused = 1;
  return FALSE;
}

_Bool FlashMngr_EraseChip()
{
  u8 i, tmp;
  ExtFlashAdr tmpadr;
  if(EXTFLASH_ERR.Error_bits.Memory_Locked_ERR || DisableMemOP)
  {
    //Operation refused, memory locked error
    EXTFLASH_STAT.Status_bits.Operation_refused = 1;
    return FALSE;
  }
  //if data in flash memory was read, then we can erase the chip
  if(EXTFLASH_STAT.Status_bits.Flash_was_Read)
  {
    EXTFLASH_STAT.Status_bits.Operation_refused = 0;
    SST25VF016_Chip_Erase();
    EXTFLASH_STAT.Status = 0;  //Reset status flags
    EXTFLASH_ERR.Error = 0;    //Reset error flags
    flash_ptr.adr32b = DATA_STORAGE_BASE;
    pointer_adr.adr32b = PTR_ARR_BASE;

    //Wait until chip erase is complete
    while(SST25VF016_Read_Status_Register() & STATUS_BUSY);
    //Verify if the chip was erased, test first TEST_ERASED_BYTES_NUM bytes starting from DATA_STORAGE_BASE
    tmpadr.adr32b = DATA_STORAGE_BASE;
    for(i = 0; i < TEST_ERASED_BYTES_NUM; i++)
    {
      if(SST25VF016_Read_Byte(tmpadr) != BYTE_ERASED_VAL) 
      {
        EXTFLASH_ERR.Error_bits.Flash_Erase_ERR = 1;
        EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
        return FALSE;
      }
      tmpadr.adr32b++;
    }
    tmpadr.adr32b = PTR_ARR_BASE;
    //Test first pointer address from PTR_ARR_BASE (3 bytes)
    if(FlashMngr_ReadPointer(tmpadr) != PTR_ERASED_VAL) 
      {
        EXTFLASH_ERR.Error_bits.PTR_SEC_Erase_ERR = 1;
        EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
        return FALSE;
      }
    //Flash pointer is known and valid
    EXTFLASH_STAT.Status_bits.FlashPtr_was_Read = 1;
    return TRUE;
  }
  //Operation refused, Flash was not Read before erase request
  EXTFLASH_STAT.Status_bits.Operation_refused = 1;
  return FALSE;
}

u32 FlashMngr_GetFreeSpace()
{
  s32 tmp;
  tmp = FLASH_MAX_ADR - flash_ptr.adr32b + 1;
  if(tmp < 0) tmp = 0;
  return (u32)(tmp);
}

u32 FlashMngr_GetOccupiedSpace()
{
  return (u32)(flash_ptr.adr32b - DATA_STORAGE_BASE - 1);
}

void FlashMngr_ReadDataToUART()
{
  ExtFlashAdr tmp_adr;
  u32 dataSizeToSend;
  dataSizeToSend = FlashMngr_GetOccupiedSpace();
  tmp_adr.adr32b = DATA_STORAGE_BASE;
  for(;dataSizeToSend > 0; dataSizeToSend--)
  {
    while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
    UART1_SendData8(SST25VF016_Read_Byte(tmp_adr));
    tmp_adr.adr32b++;
  }
  EXTFLASH_STAT.Status_bits.Flash_was_Read = 1;
}

void FlashMngr_GetOccupiedSpaceToUART()
{
  ExtFlashAdr tmp_val;
  tmp_val.adr32b = FlashMngr_GetOccupiedSpace();
  
  while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
  UART1_SendData8(tmp_val.adr8b.Zero);           //send MSB first
  while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
  UART1_SendData8(tmp_val.adr8b.HighByte);
  while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
  UART1_SendData8(tmp_val.adr8b.MidByte);
  while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
  UART1_SendData8(tmp_val.adr8b.LowByte);
}

void FlashMngr_GetHeaderSizeToUART()
{
  ExtFlashAdr tmp_val;
  tmp_val.adr32b = PTR_SEC_SIZE;
  while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
  UART1_SendData8(tmp_val.adr8b.Zero);           //send MSB first
  while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
  UART1_SendData8(tmp_val.adr8b.HighByte);
  while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
  UART1_SendData8(tmp_val.adr8b.MidByte);
  while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
  UART1_SendData8(tmp_val.adr8b.LowByte);
}

void FlashMngr_ReadHeaderToUART()
{
  ExtFlashAdr tmp_adr;
  u16 dataSizeToSend;
  dataSizeToSend = PTR_SEC_SIZE;
  tmp_adr.adr32b = PTR_ARR_SEC_ADR;
  for(;dataSizeToSend > 0; dataSizeToSend--)
  {
    while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
    UART1_SendData8(SST25VF016_Read_Byte(tmp_adr));
    tmp_adr.adr32b++;
  }
}

void FlashMngr_DisableWriteOp()
{
  DisableMemOP = TRUE;
}

void FlashMngr_EnableWriteOp()
{
  DisableMemOP = FALSE;
}