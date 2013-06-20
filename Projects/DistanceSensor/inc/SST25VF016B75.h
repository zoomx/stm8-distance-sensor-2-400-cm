#ifndef _SST25VF016B75_H_
#define _SST25VF016B75_H_

void SST25VF016_Init(void);
void SST25VF016_Read(u32, u8*, u16);
void SST25VF016_Read_HS(u32, u8*, u16);
void SST25VF016_Program_Byte(u32, u8);
void SST25VF016_Enable_SY(void);
void SST25VF016_Disable_SY(void);
void SST25VF016_AAI_Word_Program(u32, u8*, u16);
void SST25VF016_Sector_Erase_4KB(u32);
void SST25VF016_Write_Status_Register(u8);
void SST25VF016_Read_JEDEC_ID(u8*);
void SST25VF016_Read_ID(u8*);

#endif