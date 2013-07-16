#ifndef _DISPLAY_H_
#define _DISPLAY_H_
 
#define NOCOMMA    (u8)0x00
#define COMMAPOS1  (u8)0x01
#define COMMAPOS2  (u8)0x02
#define COMMAPOS3  (u8)0x04
#define COMMAPOS4  (u8)0x08
 
void Display_Init(void);
void Display_Cyclic(void);
void Display_SetScreen32(u8, u32);
void Display_SetScreen16(u8, u16, u16);
void Display_SetScreen(u8, char*, u8);
void Display_DisableScreen(u8);

#endif