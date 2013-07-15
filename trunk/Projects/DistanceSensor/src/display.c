#include "display_conf.h"
#include "7seg.h"

typedef union
{
  struct
  {
    u16 LeftDigits;
    u16 RightDigits;
  }display16b;
  u32 display32b;
}DisplayData;

static DisplayData Screens[SCREEN_NUM];
static u8 _disp_cnt;
static u8 _disp_curr_scr;

void Display_Init()
{
  u8 i;
  for(i = 0; i < SCREEN_NUM; i++)
  {
    //Clear all screens
    Screens[i].display32b = 0;
  }
  _disp_cnt = 0;
  _disp_curr_scr = 0;
}

void Display_Cyclic()
{
  if(Screens[_disp_curr_scr].display32b != 0)
  {
    SevenSegOut(Screens[_disp_curr_scr].display16b.LeftDigits);
    SevenSegOut(Screens[_disp_curr_scr].display16b.RightDigits);
    SevenSegRefresh();
    _disp_cnt++;
    switch(_disp_curr_scr)
    {
      case 0: { 
                if(_disp_cnt == SCREEN1TIME)
                {
                  _disp_cnt = 0;
                  _disp_curr_scr = 1;
                }
                break;
              }
      case 1: { 
                if(_disp_cnt == SCREEN2TIME)
                {
                  _disp_cnt = 0;
                  _disp_curr_scr = 2;
                }
                break;
              }
      case 2: { 
                if(_disp_cnt == SCREEN3TIME)
                {
                  _disp_cnt = 0;
                  _disp_curr_scr = 0;
                }
                break;
              }
      default: {
                 break;
               }
    }
  }
  else
  {
    _disp_curr_scr++;
    if(_disp_curr_scr == 2) _disp_curr_scr = 0;
  }  
}

void Display_SetScreen32(u8 _scr_num, u32 _scr_val)
{
  Screens[_scr_num].display32b = _scr_val;
}

void Display_SetScreen16(u8 _scr_num, u16 _scr_leftdig, u16 _scr_rightdig)
{
  Screens[_scr_num].display16b.LeftDigits = _scr_leftdig;
  Screens[_scr_num].display16b.RightDigits = _scr_rightdig;
}

void Display_DisableScreen(u8 _scr_num)
{
  Screens[_scr_num].display32b = 0;
}