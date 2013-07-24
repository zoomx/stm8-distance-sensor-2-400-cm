#include "board.h"
#include "display_conf.h"
//#include "display.h"
#include "7seg.h"

#define NOCOMMA    (u8)0x00
#define COMMAPOS1  (u8)0x01
#define COMMAPOS2  (u8)0x02
#define COMMAPOS3  (u8)0x04
#define COMMAPOS4  (u8)0x08

/* Display character constants */
static const u8 SymbCommaA =   0x0080;
static const u8 SymbCommaB =   0x0001;
static const u16 SymbU =      0x0C70;
static const u16 SymbMinusA = 0x0100;
static const u16 SymbMinusB = 0x8000;
static const u16 SymbSpace  = 0x0000;
static const u16 Char_A_A = 0x0FE0;
static const u16 Char_A_B = 0xF006;
static const u16 Char_C_A = 0x0630;
static const u16 Char_C_B = 0x600C;
static const u16 Char_E_A = 0x0730;
static const u16 Char_E_B = 0xE00C;
static const u16 Char_F_A = 0x0720;
static const u16 Char_F_B = 0xE004;
static const u16 Char_H_A = 0x0D60;
static const u16 Char_H_B = 0xB006;
static const u16 Char_I_A = 0x0840;
static const u16 Char_I_B = 0x1002;
static const u16 Char_J_A = 0x0850;
static const u16 Char_J_B = 0x100A;
static const u16 Char_L_A = 0x0430;
static const u16 Char_L_B = 0x200C;
static const u16 Char_P_A = 0x0F20;
static const u16 Char_P_B = 0xF004;
static const u16 Char_U_A = 0x0C70;
static const u16 Char_U_B = 0x300E;
static const u16 Char_b_A = 0x0570;
static const u16 Char_b_B = 0xA00E;
static const u16 Char_c_A = 0x0130;
static const u16 Char_c_B = 0x800C;
static const u16 Char_d_A = 0x0970;
static const u16 Char_d_B = 0x900E;
static const u16 Char_h_A = 0x0560;
static const u16 Char_h_B = 0xA006;
static const u16 Char_i_A = 0x0040;
static const u16 Char_i_B = 0x0002;
static const u16 Char_l_A = 0x0420;
static const u16 Char_l_B = 0x2004;
static const u16 Char_n_A = 0x0160;
static const u16 Char_n_B = 0x8006;
static const u16 Char_o_A = 0x0170;
static const u16 Char_o_B = 0x800E;
static const u16 Char_u_A = 0x0070;
static const u16 Char_u_B = 0x000E;
static const u16 A[10] = {0x0E70,0x0840,0x0B30,0x0B50,0x0D40, 0x0750,0x0770,0x0A40,0x0F70,0x0F50};   
static const u16 B[10] = {0x700E,0x1002,0xD00C,0xD00A,0xB002, 0xE00A,0xE00E,0x5002,0xF00E,0xF00A};

typedef union
{
  struct
  {
    u16 LeftDigits;
    u16 RightDigits;
  }display16b;
  u32 display32b;
}DisplayData;

static DisplayData Screen[SCREEN_NUM];
static const u8 ScreenTime[SCREEN_NUM] = {2, 2, 1};
static u8 _disp_cnt;
static u8 _disp_curr_scr;
static _Bool FLAG_ScreensArrayEmpty;

void Display_Init()
{
  u8 i;
  for(i = 0; i < SCREEN_NUM; i++)
  {
    //Clear all screens
    Screen[i].display32b = 0;
  }
  _disp_cnt = 0;
  _disp_curr_scr = 0;
  FLAG_ScreensArrayEmpty = TRUE;
  SevenSegInit();
  SevenSegRefresh();
}

void Display_Cyclic()
{
  if( !FLAG_ScreensArrayEmpty )
  {
    //position _disp_curr_scr to the next screen that contains data
	while(Screen[_disp_curr_scr].display32b == 0)
	{
	  _disp_curr_scr++;
	  if(_disp_curr_scr == SCREEN_NUM) 
	  {
	    _disp_curr_scr = 0;
      }
	}
	//Update current screen on the display
    SevenSegOut(Screen[_disp_curr_scr].display16b.RightDigits);
    SevenSegOut(Screen[_disp_curr_scr].display16b.LeftDigits);
    SevenSegRefresh();
	//increment display time counter
    _disp_cnt++;
	//check if current screen reached the wanted display time
	if(_disp_cnt == ScreenTime[_disp_curr_scr])
	{
	  _disp_cnt = 0;
	  _disp_curr_scr++;
	  if(_disp_curr_scr == SCREEN_NUM) 
	  {
	    _disp_curr_scr = 0;
      }
	}
  }
}

void Display_SetScreen32(u8 _scr_num, u32 _scr_val)
{
  Screen[_scr_num].display32b = _scr_val;
  FLAG_ScreensArrayEmpty = FALSE;
}

void Display_SetScreen16(u8 _scr_num, u16 _scr_leftdig, u16 _scr_rightdig)
{
  Screen[_scr_num].display16b.LeftDigits = _scr_leftdig;
  Screen[_scr_num].display16b.RightDigits = _scr_rightdig;
  FLAG_ScreensArrayEmpty = FALSE;
}

void Display_MapCharToPos(u8 _scr_num, u8 pos, u16* A_val, u16* B_val)
{
  switch(pos)
  {
    case 0: {Screen[_scr_num].display16b.LeftDigits = *A_val; break;}
  
    case 1: {Screen[_scr_num].display16b.LeftDigits |= *B_val; break;}
  
    case 2: {Screen[_scr_num].display16b.RightDigits = *A_val; break;}
  
    case 3: {Screen[_scr_num].display16b.RightDigits |= *B_val; break;}
  }
}
/*
u8 _scr_num - screen number into which display data is put
char* _scr_val - data to be converted and put into the corresponding screen
u8 commapos - the four lower bits are taken into account, a bit set means comma to be set at the respective position
*/
void Display_SetScreen(u8 _scr_num, char* _scr_val, u8 commapos)
{
  u8 i;
  for(i = 0; i < 4; i++)
  {
    if(*_scr_val != 0)
    {
      if((*_scr_val) < 48)
      {
        switch(*_scr_val)
        {
          case '-': { Display_MapCharToPos(_scr_num, i, &SymbMinusA, &SymbMinusB); break; }
  
          case ' ': { Display_MapCharToPos(_scr_num, i, &SymbSpace, &SymbSpace); break; }
        }
      }
      else if((*_scr_val) < 58)
      {
        Display_MapCharToPos(_scr_num, i, &A[*_scr_val - 48], &B[*_scr_val - 48]);
      }
      else
      {
        switch(*_scr_val)
        {
          case 'A': { Display_MapCharToPos(_scr_num, i, &Char_A_A, &Char_A_B); break; }
  
          case 'C': { Display_MapCharToPos(_scr_num, i, &Char_C_A, &Char_C_B); break; }
  
          case 'E': { Display_MapCharToPos(_scr_num, i, &Char_E_A, &Char_E_B); break; }
  
          case 'F': { Display_MapCharToPos(_scr_num, i, &Char_F_A, &Char_F_B); break; }
  
          case 'H': { Display_MapCharToPos(_scr_num, i, &Char_H_A, &Char_H_B); break; }
  
          case 'I': { Display_MapCharToPos(_scr_num, i, &Char_I_A, &Char_I_B); break; }
  
          case 'J': { Display_MapCharToPos(_scr_num, i, &Char_J_A, &Char_J_B); break; }
  
          case 'L': { Display_MapCharToPos(_scr_num, i, &Char_L_A, &Char_L_B); break; }
  
          case 'P': { Display_MapCharToPos(_scr_num, i, &Char_P_A, &Char_P_B); break; }
  
          case 'U': { Display_MapCharToPos(_scr_num, i, &Char_U_A, &Char_U_B); break; }
  
          case 'b': { Display_MapCharToPos(_scr_num, i, &Char_b_A, &Char_b_B); break; }

          case 'c': { Display_MapCharToPos(_scr_num, i, &Char_c_A, &Char_c_B); break; }
  
          case 'd': { Display_MapCharToPos(_scr_num, i, &Char_d_A, &Char_d_B); break; }
  
          case 'h': { Display_MapCharToPos(_scr_num, i, &Char_h_A, &Char_h_B); break; }

          case 'i': { Display_MapCharToPos(_scr_num, i, &Char_i_A, &Char_i_B); break; }
       
          case 'l':	{ Display_MapCharToPos(_scr_num, i, &Char_l_A, &Char_l_B); break; }

          case 'n': { Display_MapCharToPos(_scr_num, i, &Char_n_A, &Char_n_B); break; }		

          case 'o': { Display_MapCharToPos(_scr_num, i, &Char_o_A, &Char_o_B); break; }	
 
          case 'u': { Display_MapCharToPos(_scr_num, i, &Char_u_A, &Char_u_B); break; } 
        }
      }
    }
  _scr_val++;
  }
  if(commapos & COMMAPOS1) Screen[_scr_num].display16b.LeftDigits |= SymbCommaA;
  if(commapos & COMMAPOS2) Screen[_scr_num].display16b.LeftDigits |= SymbCommaB;
  if(commapos & COMMAPOS3) Screen[_scr_num].display16b.RightDigits |= SymbCommaA;
  if(commapos & COMMAPOS4) Screen[_scr_num].display16b.RightDigits |= SymbCommaB;
  
  FLAG_ScreensArrayEmpty = FALSE;
}

void Display_DisableScreen(u8 _scr_num)
{
  u8 i;
  Screen[_scr_num].display32b = 0;
  //Verify if Screen array is empty
  FLAG_ScreensArrayEmpty = TRUE;
  for(i = 0; i < SCREEN_NUM; i++)
  {
    if(Screen[i].display32b != 0)
	{
	  FLAG_ScreensArrayEmpty = FALSE;
	  break;
	}
  }
}
/*
Display brightness: 0-0% 5000-50% 10000-100%
*/
void Display_SetBrightness(u16 dimmval)
{
  TIM2_SetCompare2(dimmval);
}