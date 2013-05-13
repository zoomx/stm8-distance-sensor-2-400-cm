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
u8 neg_temp_flag = FALSE;
u8 temperature_read_flag = FALSE;
u8 dist_samples_read_flag = FALSE;
u8 dist_plausi_calc_flag = FALSE;
u8 dist_plausi_array_full = FALSE;
u16 tim1_cntr = 0;
u32 period = 0;
u8 time = 50;
s32 distance = 0;
const u16 soundspeed0degC = 3313;   /* speed of sound at 0 degrees Celsius: 331.3m/s 3313dm/s */
const u16 soundspeedkfactor = 606;  /* c_air = 331.3 + 0.606C^-1 * dT_0_C [km/s]v*/
const u8 valid_sample_difference = 20;  /* all valid samples must be within +/- 30mm of each other */
const u8 freq_thrs = 16;
s16 soundspeedkfactorcorrection = 0;
u16 soundspeed = 0;                 /* [dm/s] - tens of centimeters/ s */
u16 rec_dist[32];     /* distance samples */
u8 freq_rec_dist[32];
u8 idx_rec_dist = 0;
u16 dist_plausi = 0;
u16 dist_plausi_array[10];
u8 idx_dist_plausi = 0;
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
  u8 i, j;
  Config();
  DELAY_US(1000);
  DS18B20_init();
  DS18B20_convert();
  for(i = 0; i < 32; i++)
  {
    freq_rec_dist[i] = 0;
  }
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
	    neg_temp_flag = TRUE;
	  }
	  temperature >>= 4;
    soundspeedkfactorcorrection = soundspeedkfactor * temperature;
    soundspeedkfactorcorrection /= 100;  /* convert from km/s to dm/s for compatibility with soundspeed0degC */
    soundspeed = soundspeed0degC + soundspeedkfactorcorrection;
	  DS18B20_convert();
    delay_1s_flag = FALSE;
    temperature_read_flag = TRUE;	
   }
   if(delay_100ms_flag && temperature_read_flag)
   {
     SONAR_TRIG_ON;
     DELAY_US(DELAY_10US);
     SONAR_TRIG_OFF;
     delay_100ms_flag = FALSE;
   }
   if(CAPTURE_new_mes)
   {
     if(temperature_read_flag)
     {
       /* distance[um] = 331.3[m/s] * delta_t[us] */
       distance = (s32)((u32)soundspeed * (u32)CAPTURE_delta);
       distance /= 20000;   /* convert to mm 0-from dm/s to m/s and 000-from us to ms and divide by 2-sound makes twice the distance*/
       if(idx_rec_dist < 32) 
       {
         rec_dist[idx_rec_dist++] = (u16)distance;
       }
       else
       {
         idx_rec_dist = 0;
         dist_samples_read_flag = TRUE;
       }
	   CAPTURE_new_mes = FALSE;
     }
   }
   if(dist_samples_read_flag)
   {
    u32 sum_dist = 0;
    u8 dist_samples = 0;
     for(i = 0; i < 32; i++)
     { 
       for(j = 0; j < 32; j++)
        {
          if(i != j)
          {
            if(rec_dist[i] >= rec_dist[j])
            {
              if((rec_dist[i] - rec_dist[j]) <= (u16)valid_sample_difference)
              {
                freq_rec_dist[i]++;
              }
            }
            else /* rec_distances[i] < rec_distances[j] */
            {
              if((rec_dist[j] - rec_dist[i]) <= (u16)valid_sample_difference)
              {
                freq_rec_dist[i]++;
              }
            }
          }
            
        }
     }
     for(i = 0; i < 32; i++)
     {
       if(freq_rec_dist[i] > (u16)freq_thrs) 
       {
         sum_dist += rec_dist[i];
         dist_samples++;
       }
     }
     if(sum_dist == 0) 
     {    
       dist_plausi = 0;
       dist_plausi_calc_flag = FALSE;
     }
     else 
     {
      dist_plausi = sum_dist / dist_samples;
	  if(idx_dist_plausi < 10) 
	  {
	    dist_plausi_array[idx_dist_plausi] = dist_plausi;
	    idx_dist_plausi++;
	  }
	  else
	  {
	    dist_plausi_array_full = TRUE;
	  }
      dist_plausi_calc_flag = TRUE;
     }
     dist_samples_read_flag = FALSE;
   }
   if(CAPTURE_ovf_err)
   {
     
   }
   if(CAPTURE_no_trig_err)
   {
    
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
