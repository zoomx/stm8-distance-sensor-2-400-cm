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
#include "7seg.h"

/* Private functions ---------------------------------------------------------*/
#define DIST_SAMP (u8)20
#define FREQ_THRS (u8)(DIST_SAMP/2)
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
const u8 sensor_calib_value = 106;  /* adjust at 106% of sensor value*/
/* Display character constants */
const u8 SymbComma = 0x80;
const u16 SymbU = 0x0C70;
const u16 A[10] = {0x0E70,0x0840,0x0B30,0x0B50,0x0D40, \
                            0x0750,0x0770,0x0A40,0x0F70,0x0F50};   
const u16 B[10] = {0x700E,0x1002,0xD00C,0xD00A,0xB002, \
                            0xE00A,0xE00E,0x5002,0xF00E,0xF00A};
/* --------------------------- */
s16 soundspeedkfactorcorrection = 0;
u16 soundspeed = 0;                 /* [dm/s] - tens of centimeters/ s */
u16 rec_dist[DIST_SAMP];     /* distance samples */
u8 freq_rec_dist[DIST_SAMP];
u8 idx_rec_dist = 0;
u16 dist_plausi = 0;
u16 dist_plausi_calib = 0;
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
  Config();
  DELAY_US(1000);
  DS18B20_init();
  SevenSegInit();
  SevenSegOut(A[5] | B[5]);
  SevenSegRefresh();
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
     DELAY_US(DELAY_15US);
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
       if(idx_rec_dist < DIST_SAMP) 
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
    u8 l_dist_samples = 0;
    u8 i, j;
    for(i = 0; i < DIST_SAMP; i++)
    {
      freq_rec_dist[i] = 0;
    }
    for(i = 0; i < DIST_SAMP; i++)
    { 
      for(j = 0; j < DIST_SAMP; j++)
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
    for(i = 0; i < DIST_SAMP; i++)
    {
      if(freq_rec_dist[i] > FREQ_THRS) 
      {
        sum_dist += rec_dist[i];
        l_dist_samples++;
      }
    }
    if(sum_dist == 0) 
    {    
      dist_plausi = 0;
      dist_plausi_calc_flag = FALSE;
    }
    else 
    {
     dist_plausi = sum_dist / l_dist_samples;
     if(dist_plausi <= 4240)   /* if real measured distance <= 400cm */
     {
       u16 temp_dist_plausi_calib;
       dist_plausi_calib = dist_plausi;       /* 1595 */
       dist_plausi_calib /= 10;               /* 159 */
       if((dist_plausi % 10) >= 5)
       {
        dist_plausi_calib++;                  /* 160 */
       }
       dist_plausi_calib *= 106;              /* 16960 */
       temp_dist_plausi_calib = dist_plausi_calib;
       dist_plausi_calib /= 100;              /* 169 */
       if((temp_dist_plausi_calib % 100) >= 50)
       {
         dist_plausi_calib++;                 /* 170 */
       }
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
