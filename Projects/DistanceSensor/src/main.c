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
#include "7seg.h"
#include "ds3231m_rtc.h"
#include "flashmngr.h"

/* Defines ---------------------------------------------------------*/


/* CONSTANTS ---------------------------------------------------------------*/

/* DS18B20 ROM codes */
static const u8 ROM_ID1[8] = {0x28, 0x16, 0xAE, 0xBF, 0x3, 0x0, 0x0, 0x89};

/* Global variables ----------------------------------------------------------*/
static s16 temperature = 0;
static u8 buff[16];
static u16 CYCLYC_1S_cnt = 0;
/* FLAGS */
static volatile _Bool FLAG_temp_neg = FALSE;
static volatile _Bool FLAG_temp_read = FALSE;
static volatile _Bool FLAG_dist_samp_read = FALSE;
static volatile _Bool FLAG_dist_valid_calc = FALSE;
static volatile _Bool FLAG_rtc_settime = FALSE;
static volatile _Bool FLAG_ds18b20_err = FALSE;
static volatile _Bool FLAG_spiflash_access = FALSE;
static volatile _Bool FLAG_spiflash_write = TRUE;
static volatile _Bool FLAG_ExtFlashinit_OK = FALSE;
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

void TASK_100mS()
{
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
}  
 
void TASK_1000mS()
{
  u16 temp_frac, temp_intreg, tmp;
  char tempdisp[5];
  DS18B20_Read_Temp(&temperature, ROM_ID1);
  DS3231M_GetTime();
  DS3231M_GetDate();
  //Show hour and minutes on the display
  tempdisp[0] = (char)((u8)((RTC_hour & 0xF0)>>4) + (u8)48);
  tempdisp[1] = (char)((u8)(RTC_hour & 0x0F) + (u8)48);
  tempdisp[2] = (char)((u8)((RTC_min & 0xF0)>>4) + (u8)48);
  tempdisp[3] = (char)((u8)(RTC_min & 0x0F) + (u8)48);
  tempdisp[4] = 0;
  Display_SetScreen(0,  tempdisp, COMMAPOS2);
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
  tempdisp[0] = (char)((u8)((temp_intreg)/10) + (u8)48);
  tempdisp[1] = (char)((u8)((temp_intreg)%10) + (u8)48);
  tempdisp[2] = (char)((u8)temp_frac + (u8)48);
  tempdisp[3] = 'c';
  tempdisp[4] = 0;
  Display_SetScreen(1,  tempdisp, COMMAPOS2);
  FLAG_ds18b20_err = DS18B20_All_convert();    /* issue DS18B20 convert command, to read the results after 1s */

  if((FlashMngr_GetErrors() != 0) && ((CYCLYC_1S_cnt % 2) == 0))
  {
    Display_SetScreen(2, "Er 1", NOCOMMA);
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
  FLAG_temp_read = TRUE;	
}

void Power_FailDetected()
{
  //Wait for any memory operation in progress and then invalidate any other external memory write operations
  FlashMngr_DisableWriteOp();
}

void Power_Good()
{
  //To be called when power good after a power fail detection
  FlashMngr_EnableWriteOp();
}

void main(void)
{
  Config();
  //SevenSegInit();
  //SevenSegRefresh();
  DELAY_US(1000);
  DS18B20_All_init();
  Display_Init();
  //Light all display segments and dots to see eventual display failures
  //Display_SetScreen(0, "8888", COMMAPOS1 | COMMAPOS2 | COMMAPOS3 | COMMAPOS4);
  //Force a display on the screen
  //Display_Cyclic();
  FlashMngr_Init();
  //FLAG_ds18b20_err = DS18B20_Read_ROM_ID(ROM_ID1);
  FLAG_ds18b20_err = DS18B20_All_convert();

  enableInterrupts();
  Cyclic_Start();
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
