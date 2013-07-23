#include "board.h"
#include "delay.h"

void SevenSegInit()
{
 u8 i;
 DISP_SDI_1;
 for(i = 0; i < 32; i++)
 {
  DISP_CLK_1;
  DELAY_US(DELAY_6US);
  DISP_CLK_0;
  DELAY_US(DELAY_6US);
 }
 DELAY_US(DELAY_6US);
 DISP_LE_1;
 DELAY_US(DELAY_6US);
 DISP_LE_0;
}
void SevenSegOut(u16 number)
{
 u16 tmp = 0x8000;
 u8 i;
 DISP_CLK_0;
 for(i = 0; i < 16; i++)
 {
  DISP_SDI_0;
  if(number & tmp) {
   DISP_SDI_1;
  }
  DELAY_US(DELAY_6US);
  DISP_CLK_1;
  DELAY_US(DELAY_6US);
  DISP_CLK_0;
  DELAY_US(DELAY_6US);
  tmp >>= 1;
 }
}

void SevenSegRefresh()
{
 DISP_LE_0;
 DELAY_US(DELAY_6US);
 DISP_LE_1;
 DELAY_US(DELAY_6US);
 DISP_LE_0;
}