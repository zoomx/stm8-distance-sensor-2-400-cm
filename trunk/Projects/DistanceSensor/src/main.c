/**
  ******************************************************************************
  * @file main.c
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "board.h" 
#include "stm8s_it.h"
#include "cyclic.h"
#include "config.h"
#include "delay.h"
#include "ds18b20.h"
#include "display.h"
#include "ds3231m_rtc.h"
#include "flashmngr.h"

/* Defines ---------------------------------------------------------*/


/* CONSTANTS ---------------------------------------------------------------*/

/* Display character constants */
const u8 SymbComma =   0x80; 
const u16 SymbU =      0x0C70;
const u16 SymbMinusA = 0x0100;
const u16 SymbMinusB = 0x8000;
const u16 A[10] = {0x0E70,0x0840,0x0B30,0x0B50,0x0D40, 0x0750,0x0770,0x0A40,0x0F70,0x0F50};   
const u16 B[10] = {0x700E,0x1002,0xD00C,0xD00A,0xB002, 0xE00A,0xE00E,0x5002,0xF00E,0xF00A};

/* DS18B20 ROM codes */
const u8 ROM_ID1[8] = {0x28, 0x16, 0xAE, 0xBF, 0x3, 0x0, 0x0, 0x89};

/* Global variables ----------------------------------------------------------*/
s16 temperature = 0;
u8 buff[16];
u16 CYCLYC_1S_cnt = 0;
/* FLAGS */
volatile _Bool FLAG_temp_neg = FALSE;
volatile _Bool FLAG_temp_read = FALSE;
volatile _Bool FLAG_dist_samp_read = FALSE;
volatile _Bool FLAG_dist_valid_calc = FALSE;
volatile _Bool FLAG_rtc_settime = FALSE;
volatile _Bool FLAG_ds18b20_err = FALSE;
volatile _Bool FLAG_spiflash_access = FALSE;
volatile _Bool FLAG_spiflash_write = TRUE;
volatile _Bool FLAG_ExtFlashinit_OK = FALSE;
/* Public functions ----------------------------------------------------------*/
/**
  ******************************************************************************
  * @brief Main function.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void main(void)
{
  u8 i;
  Config();
  //SevenSegInit();
  //SevenSegRefresh();
  DELAY_US(1000);
  DS18B20_All_init();
  Display_Init();
  //Light all display segments to check for failures
  Display_SetScreen16(0, A[8] | B[8] | SymbComma, A[8] | B[8] | SymbComma);
  //Force a display on the screen
  Display_Cyclic();
  FlashMngr_Init();
  //FLAG_ds18b20_err = DS18B20_Read_ROM_ID(ROM_ID1);
  FLAG_ds18b20_err = DS18B20_All_convert();

  enableInterrupts();
  
  while (1)
  {
   //test requests coming from UART RX
   if(FLAG_IT_RTC_SET_DATE_TIME)
   {
     //DS3231M_SetTime();
     //DS3231M_SetDate();
     FLAG_IT_RTC_SET_DATE_TIME = FALSE;
   }
   else if(FLAG_IT_FLSH_GET_OCCUPIED_SPC)
   {
     FlashMngr_GetOccupiedSpaceToUART();
     FLAG_IT_FLSH_GET_OCCUPIED_SPC = FALSE;
   }
   else if(FLAG_IT_FLSH_READ_STORED_DATA)
   {
     FlashMngr_ReadDataToUART();
     FLAG_IT_FLSH_READ_STORED_DATA = FALSE;
   }
   else if(FLAG_IT_FLSH_GET_HEADER_SIZE)
   {
     FlashMngr_GetHeaderSizeToUART();
     FLAG_IT_FLSH_GET_HEADER_SIZE = FALSE;
   }
   else if(FLAG_IT_FLSH_READ_HEADER)
   {
     FlashMngr_ReadHeaderToUART();
     FLAG_IT_FLSH_READ_HEADER = FALSE;
   }
   //Cyclic flag to 1 second
   if(CYCLIC_1s)
   {
    u16 temp_frac, temp_intreg, tmp;
    DS18B20_Read_Temp(&temperature, ROM_ID1);
    DS3231M_GetTime();
    DS3231M_GetDate();
    //Show hour and minutes on the display
    Display_SetScreen16(1, A[(u8)(RTC_hour & 0xF0)] | B[(u8)(RTC_hour & 0x0F)], A[(u8)(RTC_min & 0xF0)] | B[(u8)(RTC_min & 0x0F)]);

    if(temperature < 0)
    {
      temperature = -(temperature);
      FLAG_temp_neg = TRUE;
    }
    else 
    {
      FLAG_temp_neg = FALSE;
    }
    temp_intreg = temperature>>4;
    temp_frac = temperature - (temp_intreg<<4);
    temp_frac *= 625;
    tmp = temp_frac % 1000;
    temp_frac /= 1000;
    if(tmp >= 500) temp_frac++;
    Display_SetScreen16(0, A[(temp_intreg)%10] | B[temp_frac] | SymbComma, 0 | B[(temp_intreg)/10]);
    FLAG_ds18b20_err = DS18B20_All_convert();    /* issue DS18B20 convert command, to read the results after 1s */

    if((FlashMngr_GetErrors() != 0) && ((CYCLYC_1S_cnt % 2) == 0))
    {
      Display_SetScreen16(2, SymbMinusA | SymbMinusB, SymbMinusA | SymbMinusB);
    }

    if(FLAG_spiflash_write && CYCLYC_1S_cnt >= 60)
    {
      CYCLYC_1S_cnt = 0;
      buff[0] = (u8)temp_intreg;
      buff[1] = (u8)RTC_hour;
      buff[2] = (u8)RTC_min;
      buff[3] = (u8)RTC_sec;
      FlashMngr_StoreData(buff, 4);
    }
    if(CYCLYC_1S_cnt < 65534) CYCLYC_1S_cnt++;
    //Call Display cyclic function to toggle the different displays
    Display_Cyclic();
    CYCLIC_1s = FALSE;
    FLAG_temp_read = TRUE;	
   }
  }
}
/**
  ******************************************************************************
  * @brief Loop for temporisation
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */

/****************** (c) 2008  STMicroelectronics ******************************/

#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval
  * None
  */
void assert_failed(u8* file, u32 line)
{
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {}
}
#endif

/**
  * @}
  */
