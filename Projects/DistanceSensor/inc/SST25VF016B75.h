#ifndef _SST25VF016B75_H_
#define _SST25VF016B75_H_

/*
TODO: check the order of bits if correct
*/
#define STATUS_BUSY  (u8)0x01
#define STATUS_WEL   (u8)0x02
#define STATUS_BP0   (u8)0x04
#define STATUS_BP1   (u8)0x08
#define STATUS_BP2   (u8)0x10
#define STATUS_BP3   (u8)0x20  //value is "don't care"
#define STATUS_AAI   (u8)0x40
#define STATUS_BPL   (u8)0x80

typedef union
{
  struct
  {
    u8 Zero;
    u8 HighByte;
    u8 MidByte;
    u8 LowByte;
  }adr8b;
  u32 adr32b;
}ExtFlashAdr;


void SST25VF016_Init(void);
void SST25VF016_Read(ExtFlashAdr, u8*, u16);
u8 SST25VF016_Read_Byte(ExtFlashAdr);
void SST25VF016_Read_HS(ExtFlashAdr, u8*, u16);
u8 SST25VF016_Read_Status_Register(void);
void SST25VF016_Program_Byte(ExtFlashAdr, u8);
void SST25VF016_Enable_SY(void);
void SST25VF016_Disable_SY(void);
void SST25VF016_AAI_Word_Program(ExtFlashAdr, u8*, u16);
void SST25VF016_Sector_Erase_4KB(ExtFlashAdr);
void SST25VF016_Block_Erase_32KB(ExtFlashAdr);
void SST25VF016_Block_Erase_64KB(ExtFlashAdr);
void SST25VF016_Chip_Erase(void);
void SST25VF016_Write_Status_Register(u8);
void SST25VF016_Read_JEDEC_ID(u8*);
void SST25VF016_Read_ID(u8*);

#endif