/**
  ******************************************************************************
  * @file main.c
  * @brief Adjustable LED blinking speed using STM8S-DISCOVERY touch sensing key
  * Application example.
  * @author STMicroelectronics - MCD Application Team
  * @version V1.0.0
  * @date 25-NOV-2011
  ******************************************************************************
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
	* FOR MORE INFORMATION PLEASE READ CAREFULLY THE LICENSE AGREEMENT FILE LOCATED 
  * IN THE ROOT DIRECTORY OF THIS FIRMWARE PACKAGE.
  *
  * <h2><center>&copy; COPYRIGHT 2008 STMicroelectronics</center></h2>
  * @image html logo.bmp
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "board.h" 
#include "stm8s_it.h"
#include "config.h"
#include "delay.h"
#include "ds18b20.h"

/* Private functions ---------------------------------------------------------*/
/* Global variables ----------------------------------------------------------*/
s16 temperature = 0;
float tempr = 0.0;
u8 neg_temp_flag = 0;
u16 tim1_cntr = 0;
u32 period = 0;
u8 time = 50;
s32 distance = 0;
const u16 soundspeed0degC = 3313;   /* speed of sound at 0 degrees Celsius: 331.3m/s 3313dm/s */
const u16 soundspeedkfactor = 606;  /* c_air = 331.3 + 0.606C^-1 * dT_0_C [km/s]v*/
s16 soundspeedkfactorcorrection = 0;
u16 soundspeed = 0;                 /* [dm/s] - tens of centimeters/ s */
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
  Config();
  DELAY_US(1000);
  DS18B20_init();
  DS18B20_convert();
  enableInterrupts();	

  while (1)
  {
   if(delay_1s_flag == TRUE)
   {
    temperature = DS18B20_read_16();
	  if(temperature >= 0)
    {
	    neg_temp_flag = 0;
	  }
	  else 
	  {
	    temperature = -(temperature);
	    neg_temp_flag = 1;
	  }
	  temperature >>= 4;
    soundspeedkfactorcorrection = soundspeedkfactor * temperature;
    soundspeedkfactorcorrection /= 100;  /* convert from km/s to dm/s for compatibility with soundspeed0degC */
    soundspeed = soundspeed0degC + soundspeedkfactorcorrection;
	  DS18B20_convert();
    delay_1s_flag = FALSE;	
   }
   if(delay_100ms_flag == TRUE)
   {
     SONAR_TRIG_ON;
     DELAY_US(DELAY_10US);
     SONAR_TRIG_OFF;
     delay_100ms_flag = FALSE;
   }
   if(CAPTURE_new_mes)
   {
     if(CAPTURE_delta != CAPTURE_INVALID_MES)
     {
       /* distance[um] = 331.3[m/s] * delta_t[us] */
       distance = soundspeed * CAPTURE_delta;
       distance /= 10000;   /* convert to mm 0-from dm/s to m/s and 000-from us to ms*/
     }
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
