#include "board.h"
#include "sst25vf016b75.h"
/*
Every time data is stored in flash memory a pointer to the next free memory location in flash is updated in SECTOR 0.
For this purpose multiple continuous memory locations are used in SECTOR 0 for wear-levelling.
When all these memory locations are occupied, the whole sector is erased and we start over.
Data is meant to be stored as fixed lenght frame.
*/
#define VALID                 (u8)1
#define INVALID               (u8)0
#define PTR_ARR_SEC_ADR       (u32)0x000000   //SECTOR 0
#define PTR_SEC_SIZE          (u16)4096       //SECTOR 0 size
#define FLASH_MAX_ADR         (u32)0x1FFFFF   //MAX addressable flash memory location
#define PTR_ERASED_VAL        (u32)0xFFFFFF   //value of 3 continuous erased flash memory bytes
#define BYTE_ERASED_VAL       (u8)0xFF
#define PTR_ARR_ADR_OFFST     (u16)0          //offset in sector where the flash pointer array is stored
#define PTR_ARR_BASE          (PTR_ARR_SEC_ADR + PTR_ARR_ADR_OFFST)
#define PTR_ARR_LEN           (u8)64          //flash pointer array size (used for wear levelling of the flash)
#define DATA_STORAGE_BASE     (u32)0x001000   //flash data storage address base
#define PTR_SIZE              (u8)3           //flash pointer size in bytes to be stored in PTR_ARR
#define TEST_ERASED_BYTES_NUM (u8)10
#define PTR_ARR_SIZE          (PTR_ARR_LEN * PTR_SIZE)
#define INVALID_ADR(_adr)     (((u32)_adr > FLASH_MAX_ADR) && ((u32)_adr < PTR_ERASED_VAL))   //macro to determine if _adr is an invalid flash memory address (different to the erased value)
#define PTR_OUT_OF_ARR(_adr)  ( _adr >= (PTR_ARR_BASE + PTR_ARR_SIZE))                                     //macro to determine if _adr is out of PTR_ARR

union uu
{
  struct tt
  {
    u8 PTR_ARR_Full      :1;   //set when PTR_ARR is full
    u8 NeedErase         :1;   //set when invalid data is found in PTR_ARR
    u8 UnknownERR        :1;   //CRITICAL: Unknown error
    u8 FlashPtr_was_Read :1;   //set when FlashMngr_GetPointer() function was called and valid flash pointer was returned
    u8 FlashPtr_Invalid  :1;
    u8 Flash_Full        :1;   //set when Flash memory is full, no more data can be stored
    u8 Flash_was_Read    :1;   //set when Flash memory was Read, we assume that that we can erase the chip without data loss
    u8 Flash_no_space    :1;   //set when FlashMngr_StoreData(u8*, u16) function ws called but there was not enough space to store the chunck of data
    u8 PTR_SEC_Erase_ERR :1;   //CRITICAL: erase operation did not pass verification
    u8 Flash_Erase_ERR   :1;   //CRITICAL: erase flash operation did not pass verification
    u8 Data_Store_ERR    :1;   //data storage operation did not pass verification
  }Status_bits;
  u16 Status;
}EXTFLASH;

u8 buffer[PTR_SIZE];
u8 flashimg[32];
ExtFlashAdr flash_ptr;     //address of the next free flash memory location
ExtFlashAdr pointer_adr;   //address of the next flash pointer in the flash pointer array

_Bool FlashMngr_GetPointer(void);

_Bool FlashMngr_Init()
{
  _Bool tmp;
  ExtFlashAdr tmpadr;
  tmpadr.adr32b = PTR_ARR_BASE;
  SST25VF016_Init();
  SST25VF016_Read(tmpadr, flashimg, 32);
  tmp = FlashMngr_GetPointer();
  SST25VF016_Write_Status_Register(0x00); //Unlock SPI flash memory for writing
  flash_ptr.adr32b = DATA_STORAGE_BASE;
  pointer_adr.adr32b = PTR_ARR_BASE;
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
  ExtFlashAdr tmpadr;
  tmpadr.adr32b = PTR_ARR_BASE;
  ptr_old = FlashMngr_ReadPointer(tmpadr);
  if(INVALID_ADR(ptr_old))
  {
    EXTFLASH.Status_bits.FlashPtr_Invalid = 1;
    EXTFLASH.Status_bits.NeedErase = 1;
    return INVALID;
  }
  if(ptr_old == PTR_ERASED_VAL)
  {
    flash_ptr.adr32b = DATA_STORAGE_BASE;
    pointer_adr.adr32b = PTR_ARR_BASE;
    return VALID;
  }
  tmpadr.adr32b = PTR_ARR_BASE + PTR_SIZE;
  for(i = 1; i < PTR_ARR_LEN; i++)
  {
    ptr_new = FlashMngr_ReadPointer(tmpadr);
    if((ptr_new <= ptr_old) || INVALID_ADR(ptr_new)) 
    {
      EXTFLASH.Status_bits.FlashPtr_Invalid = 1;
      EXTFLASH.Status_bits.NeedErase = 1;
      return INVALID;
    }
    if(ptr_new == PTR_ERASED_VAL)
    {
      pointer_adr = tmpadr;    //pointing to the next erased location, flash pointer array not full, at least one free location
      flash_ptr.adr32b = ptr_old;
      EXTFLASH.Status_bits.FlashPtr_was_Read = 1;
      return VALID;
    }
    tmpadr.adr32b += PTR_SIZE;
    ptr_old = ptr_new;
  }
  if(ptr_new > ptr_old)
  {
    flash_ptr.adr32b = ptr_new;
    EXTFLASH.Status_bits.PTR_ARR_Full = 1;
    EXTFLASH.Status_bits.FlashPtr_was_Read = 1;
    return VALID;
  }
  EXTFLASH.Status_bits.UnknownERR = 1;
  return INVALID;
}

_Bool FlashMngr_SavePointer(ExtFlashAdr adr)
{
  u32 tmp;
  ExtFlashAdr tmpadr;
  //if PTR_ARR full then erase PTR_ARR sector
  if(EXTFLASH.Status_bits.PTR_ARR_Full)
  {
    tmpadr.adr32b = PTR_ARR_SEC_ADR;
    SST25VF016_Sector_Erase_4KB(tmpadr);
    //Wait until erase operation is completed
    while(SST25VF016_Read_Status_Register() & STATUS_BUSY);
    //Verify if the Sector was erased
    tmpadr.adr32b = PTR_ARR_BASE;
    if(FlashMngr_ReadPointer(tmpadr) != PTR_ERASED_VAL) 
    {
      EXTFLASH.Status_bits.PTR_SEC_Erase_ERR = 1;
      return FALSE;
    }
    else EXTFLASH.Status_bits.PTR_SEC_Erase_ERR = 0;
    EXTFLASH.Status_bits.PTR_ARR_Full = 0;
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
    EXTFLASH.Status_bits.PTR_ARR_Full = 1;
  }
  //Verify what was written
  tmpadr.adr32b = pointer_adr.adr32b - PTR_SIZE;
  tmp = FlashMngr_ReadPointer(tmpadr);
  if(tmp == adr.adr32b) return TRUE;
  return FALSE;
}

_Bool FlashMngr_StoreData(u8* data, u16 size)
{
  u8 i, tmp;
  if(flash_ptr.adr32b + (size-1) > FLASH_MAX_ADR) 
  {
    EXTFLASH.Status_bits.Flash_no_space = 1;
    return FALSE;
  }
  EXTFLASH.Status_bits.Flash_no_space = 0;
  for(i = 0; i < size; i++)
  {
    SST25VF016_Program_Byte(flash_ptr, data[i]);
    tmp = SST25VF016_Read_Byte(flash_ptr);
    flash_ptr.adr32b++;
    //if what was written wasn't as expected
    if(tmp != data[i])
    {
      EXTFLASH.Status_bits.Data_Store_ERR = 1;
      FlashMngr_SavePointer(flash_ptr);
      return FALSE;
    }
  }
  EXTFLASH.Status_bits.Data_Store_ERR = 0;
  FlashMngr_SavePointer(flash_ptr);
  return TRUE;
}

void FlashMngr_ReadData()
{
  EXTFLASH.Status_bits.Flash_was_Read = 1;
}

_Bool FlashMngr_Erase_Chip()
{
  u8 i, tmp;
  ExtFlashAdr tmpadr;
  //if data in flash memory was read, then we can erase the chip
  if(EXTFLASH.Status_bits.Flash_was_Read)
  {
    SST25VF016_Chip_Erase();
    EXTFLASH.Status_bits.PTR_ARR_Full = 0;
    EXTFLASH.Status_bits.NeedErase = 0;
    EXTFLASH.Status_bits.UnknownERR = 0;
    EXTFLASH.Status_bits.FlashPtr_was_Read = 0;
    EXTFLASH.Status_bits.Flash_Full = 0;
    EXTFLASH.Status_bits.Flash_was_Read = 0;
    EXTFLASH.Status_bits.Flash_no_space = 0;
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
        EXTFLASH.Status_bits.Flash_Erase_ERR = 1;
        tmpadr.adr32b++;
        return FALSE;
      }
    }
    EXTFLASH.Status_bits.Flash_Erase_ERR = 0;
    return TRUE;
  }
  return FALSE;
}



u32 FlashMngr_Get_Free_Space()
{
  s32 tmp;
  tmp = FLASH_MAX_ADR - flash_ptr.adr32b + 1;
  if(tmp < 0) tmp = 0;
  return (u32)(tmp);
}