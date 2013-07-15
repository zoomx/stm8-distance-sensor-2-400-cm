#ifndef _DISPLAY_H_
#define _DISPLAY_H_
 
void Display_Init(void);
void Display_Cyclic(void);
void Display_SetScreen32(u8, u32);
void Display_SetScreen16(u8, u16, u16);
void Display_DisableScreen(u8);

#endif