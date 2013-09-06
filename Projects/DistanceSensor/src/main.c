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
#include "calibdata.h"
//#include "OSAcfg.h"

/* Defines ---------------------------------------------------------*/


/* CONSTANTS ---------------------------------------------------------------*/

/* Calibration variables */
struct CalibData 
{
  u8 ROM_ID1[8];
  u16 DataLogInterval;
  u16 Display_Brightness;  /* 10000 -> 0% brightness, 0 -> 100% brighness */
};

const struct CalibData CAL = {0x28, 0x16, 0xAE, 0xBF, 0x3, 0x0, 0x0, 0x89, 30000, 3500};

/* Global variables ----------------------------------------------------------*/
static s16 temperature = 0;
static u8 temp_intreg;
static u8 temp_frac;
u8 buff[8];
/* FLAGS */
static volatile _Bool FLAG_temp_neg = FALSE;
static volatile _Bool FLAG_dist_samp_read = FALSE;
static volatile _Bool FLAG_dist_valid_calc = FALSE;
static volatile _Bool FLAG_rtc_settime = FALSE;
static volatile _Bool FLAG_ds18b20_err = FALSE;
static volatile _Bool FLAG_spiflash_access = FALSE;
static volatile _Bool FLAG_spiflash_write = TRUE;
static volatile _Bool FLAG_ExtFlashinit_OK = FALSE;

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
  for(;;)
  {
    OS_Delay(CAL.DataLogInterval);
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
 
void TASK_1000mS()
{
  char tempdisp[5];
  for (;;)
  {
    OS_Delay(500);      // Wait 1000 ms
    DS18B20_Read_Temp(&temperature, CAL.ROM_ID1);
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
    //temp_frac can be [0-15]
    temp_frac *= 10;  //(temp_frac * 10) / 16  Scale to [0-9]
    temp_frac >>= 4;
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
    Display_SetBrightness(CAL.Display_Brightness);
    Display_Cyclic();
    }
}

void TASK_UARTCommands()
{
  OST_SMSG rcvd_message;
  u8 l_size, tmp;
  u16 l_address;
  for (;;)
    {
      OS_Smsg_Wait(smsg_rx_rec, rcvd_message);
      UART1_ITConfig(UART1_IT_RXNE, DISABLE);
      switch(rcvd_message)
      {
        u8 l_code;
        case 't': {  
                    //Receive second UART code
                    while(!(UART1->SR & (u8)0x20));
                    l_code = UART1->DR;
                    switch(l_code)
                    {
                      case 's': { 
                                  /* "ts" : Set Time */
                                  /* Receive date / time information (7bytes) */
                                  //Receive sec
                                  while(!(UART1->SR & (u8)0x20));
                                  RTC_sec = UART1->DR;
                                  //Receive min
                                  while(!(UART1->SR & (u8)0x20));
                                  RTC_min = UART1->DR;
                                  //Receive hour
                                  while(!(UART1->SR & (u8)0x20));
                                  RTC_hour = UART1->DR;
                                  //Receive day
                                  while(!(UART1->SR & (u8)0x20));
                                  RTC_day = UART1->DR;
                                  //Receive date
                                  while(!(UART1->SR & (u8)0x20));
                                  RTC_date = UART1->DR;
                                  //Receive month
                                  while(!(UART1->SR & (u8)0x20));
                                  RTC_month = UART1->DR;
                                  //Receive year
                                  while(!(UART1->SR & (u8)0x20));
                                  RTC_year = UART1->DR;
                                  DS3231M_SetTime();
                                  DS3231M_SetDate();
                                  break;
                                }
                      case 'g': { 
                                  /* "tg" : Get Time */
                                  //Send 6 byte date / time information
                                  while(!(UART1->SR & UART1_FLAG_TXE));
                                  UART1->DR = RTC_hour;
                                  while(!(UART1->SR & UART1_FLAG_TXE));
                                  UART1->DR = RTC_min;
                                  while(!(UART1->SR & UART1_FLAG_TXE));
                                  UART1->DR = RTC_sec;
                                  while(!(UART1->SR & UART1_FLAG_TXE));
                                  UART1->DR = RTC_date;
                                  while(!(UART1->SR & UART1_FLAG_TXE));
                                  UART1->DR = RTC_month;
                                  while(!(UART1->SR & UART1_FLAG_TXE));
                                  UART1->DR = RTC_year;
                                  break;
                                }
                      default: {break;}
                    }
                    break;
                  }
        case 'r': {
                    //Receive second UART code
                    while(!(UART1->SR & (u8)0x20));
                    l_code = UART1->DR;
                    switch(l_code)
                    {
                      case 'j': { 
                                  /* "rj" : Get Header size */
                                  FlashMngr_GetHeaderSizeToUART(); 
                                  break;
                                }
                      case 'h': { 
                                  /* "rh" : Get Header */
                                  FlashMngr_ReadHeaderToUART(); 
                                  break;
                                }
                      case 'd': { 
                                  /* "rd" : Get Logged data */
                                  FlashMngr_ReadDataToUART(); 
                                  break;
                                }
                      case 'f': { 
                                  /* "rf" : Get Free Space */
                                  FlashMngr_GetOccupiedSpaceToUART(); 
                                  break;
                                }
                      default: {break;}
                    }
                    break;
                  }
        case 'e': { 
                    /* "e" : Erase chip */
                    FlashMngr_EraseChip(); 
                    break;
                  }
        case 'c': {
                    u8 l_idx = 0;
                    //Receive second UART code
                    while(!(UART1->SR & (u8)0x20));
                    l_code = UART1->DR;
                    switch(l_code)
                    {
                      case 'f': { 
                                  /* "cf" : flash calibration data */
                                  //Receive size of data to be updated in FLASH
                                  while(!(UART1->SR & (u8)0x20));
                                  l_size = UART1->DR;
                                  tmp = l_size;
                                  //Receive FLASH destination address
                                  while(!(UART1->SR & (u8)0x20));
                                  l_address = UART1->DR;
                                  l_address <<= 8;
                                  while(!(UART1->SR & (u8)0x20));
                                  l_address |= UART1->DR;
                                  //Receive data to be updated in FLASH
                                  while(l_size > 0)
                                  {
                                    while(!(UART1->SR & (u8)0x20));
                                    buff[l_idx++] = UART1->DR;
                                    l_size--;
                                  }
                                  CalibData_Update(l_address, buff, tmp);
                                  break;
                                }
                      case 'g': { 
                                  /* "cg" : get address of structure with calibration data(2byte) */
                                  union {
                                    struct {
                                      u8 byte1;
                                      u8 byte2;
                                    };
                                    u16 word1;
                                  }adr;
                                  adr.word1 = (u16)(&CAL);
                                  //Send 2 byte calibration structure address
                                  while(!(UART1->SR & UART1_FLAG_TXE));
                                  UART1->DR = adr.byte1;
                                  while(!(UART1->SR & UART1_FLAG_TXE));
                                  UART1->DR = adr.byte2;
                                  break;
                                }
                      default: {break;}
                    }
                    break;
                  }
      }
      UART1_ITConfig(UART1_IT_RXNE, ENABLE);
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
