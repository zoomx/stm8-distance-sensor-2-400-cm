/**
  ******************************************************************************
  * @file main.c
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "board.h" 
#include "stm8s_it.h"
#include "config.h"
#include "delay.h"
#include "ds18b20.h"
#include "display.h"
#include "7seg.h"
#include "ds3231m_rtc.h"
#include "flashmngr.h"
#include "osa\osa.h"
//#include "OSAcfg.h"

/* Defines ---------------------------------------------------------*/


/* CONSTANTS ---------------------------------------------------------------*/

/* DS18B20 ROM codes */
static const u8 ROM_ID1[8] = {0x28, 0x16, 0xAE, 0xBF, 0x3, 0x0, 0x0, 0x89};

/* Global variables ----------------------------------------------------------*/
static s16 temperature = 0;
static u16 display_bright = 3500;   //display brightness to 25%
/* FLAGS */
static volatile _Bool FLAG_temp_neg = FALSE;
static volatile _Bool FLAG_dist_samp_read = FALSE;
static volatile _Bool FLAG_dist_valid_calc = FALSE;
static volatile _Bool FLAG_rtc_settime = FALSE;
static volatile _Bool FLAG_ds18b20_err = FALSE;
static volatile _Bool FLAG_spiflash_access = FALSE;
static volatile _Bool FLAG_spiflash_write = TRUE;
static volatile _Bool FLAG_ExtFlashinit_OK = FALSE;
static u8 temp_intreg;
static u8 temp_frac;

OST_SMSG    smsg_rx_rec;
OST_MSG_CB  msg_cb;
/* Public functions ----------------------------------------------------------*/

void TASK_UARTCommands(void);
void TASK_1000mS(void);
void Power_FailDetected(void);
void TASK_LogDataToFlash(void);
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
  Config();
  DELAY_US(1000);
  DS18B20_All_init();
  Display_Init();
  Display_SetBrightness(display_bright);  
  FlashMngr_Init();
  //FLAG_ds18b20_err = DS18B20_Read_ROM_ID(ROM_ID1);
  FLAG_ds18b20_err = DS18B20_All_convert();
  OS_Init();
  // Create task
  OS_Task_Create(0, TASK_1000mS);
  OS_Task_Create(0, TASK_UARTCommands);
  OS_Task_Create(0, TASK_LogDataToFlash);
  OS_Smsg_Create(smsg_rx_rec);
  //enableInterrupts();
  OS_EI();
  // Run scheduler
  OS_Run();
}

void TASK_LogDataToFlash()
{
  u8 buff[8];
  for(;;)
  {
    OS_Delay(30000);    // once every 60sec
    buff[0] = (u8)temp_intreg;
    buff[1] = (u8)temp_frac;
    buff[2] = (u8)RTC_hour;
    buff[3] = (u8)RTC_min;
    buff[4] = (u8)RTC_sec;
    buff[5] = (u8)RTC_day;
    buff[6] = (u8)RTC_month;
    buff[7] = (u8)RTC_year;
    FlashMngr_StoreData(buff, 8);
  }
}

void TASK_UARTCommands()
{
  OST_SMSG rcvd_message;
  for (;;)
    {
      OS_Smsg_Wait(smsg_rx_rec, rcvd_message);
  
      switch(rcvd_message)
      {
        case 't': {
                     //DS3231M_SetTime();
                     //DS3231M_SetDate();
                     break;
                   }

        case 'd': {FlashMngr_ReadDataToUART(); break;}

        case 's': {FlashMngr_GetOccupiedSpaceToUART(); break;}

        case 'r': {FlashMngr_GetHeaderSizeToUART(); break;}

        case 'h': {FlashMngr_ReadHeaderToUART(); break;}

        case 'a': {FlashMngr_EraseChip(); break;}
      }
    }
}  
 
void TASK_1000mS()
{
  //u16 l_temp_frac, tmp;
  char tempdisp[5];
  for (;;)
  {
    OS_Delay(500);      // Wait 1000 ms
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
    temp_intreg = (u8)(temperature>>4);
    temp_frac = (u8)(temperature - (temp_intreg<<4));
    //l_temp_frac *= 625;
    //temp_frac can be [0-15]
    temp_frac *= 10;  //(temp_frac * 10) / 16  Scale to [0-9]
    temp_frac >>= 4;
    //tmp = l_temp_frac % 1000;
    //l_temp_frac /= 1000;
    //if(tmp >= 500) l_temp_frac++;
	  //Show temperature on the display
    tempdisp[0] = (char)((u8)((temp_intreg)/10) + (u8)48);
    tempdisp[1] = (char)((u8)((temp_intreg)%10) + (u8)48);
    tempdisp[2] = (char)((u8)temp_frac + (u8)48);
    tempdisp[3] = 'c';
    tempdisp[4] = 0;
    Display_SetScreen(1,  tempdisp, COMMAPOS2);
    FLAG_ds18b20_err = DS18B20_All_convert();    /* issue DS18B20 convert command, to read the results after 1s */

    if(FlashMngr_GetErrors() != 0)
    {
      Display_SetScreen(2, "Er 1", NOCOMMA);
    }
    //Call Display cyclic function to toggle the different displays
    Display_Cyclic();
    }
}

void Power_FailDetected()
{
  //Wait for any memory operation in progress and then invalidate any other external memory write operations
  FlashMngr_DisableWriteOp();
  Display_SetBrightness(0); 
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
