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
#include "ds3231m_rtc.h"

void DisplayDIST(u16);
void SendDIST_UART(u16);
u16 Med_Calib_Round(u32, u8);
void LevelReadingAlgo(void);

/* Defines ---------------------------------------------------------*/
#define DIST_SAMP           (u8)20
#define FREQ_THRS           (u8)(DIST_SAMP/2)
#define REFCALC_PHASE       (u8)1
#define DIST_VALID_PHASE    (u8)2
#define ALGO_NR_REF_SAMPLES (u8)6
/* Global variables ----------------------------------------------------------*/
u8 algo_curr_phase = REFCALC_PHASE;
u16 algo_ref_samples[ALGO_NR_REF_SAMPLES];
u8 algo_ref_samples_idx = 0;
u8 algo_groups_ref_samples[ALGO_NR_REF_SAMPLES];
s16 temperature = 0;
u8 flg_TEMP_neg = FALSE;
u8 flg_TEMP_read = FALSE;
u8 flg_DIST_samples_read = FALSE;
u8 flg_DIST_valid_calc = FALSE;
u8 flg_RTC_settime = FALSE;
s32 distance = 0;
const u16 soundspeed0degC = 3313;   /* speed of sound at 0 degrees Celsius: 331.3m/s 3313dm/s */
const u16 soundspeedkfactor = 606;  /* c_air = 331.3 + 0.606C^-1 * dT_0_C [km/s]v*/
const u8 valid_sample_difference = 20;  /* all valid samples must be within +/- 30mm of each other */
const u8 sensor_calib_value = 106;  /* adjust at 106% of sensor value*/
/* Display character constants */
const u8 SymbComma = 0x80; 
const u16 SymbU = 0x0C70;
const u16 SymbMinusA = 0x0100;
const u16 SymbMinusB = 0x8000;
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
u16 dist_plausi_calib = 0;
u16 DISTANCE_NEW = 0, DISTANCE_OLD = 0;
u8 RTCdata[10];
u8 RTCdataidx = 0;
u8 RTCadr[4] = {0x00, 0x01, 0x02, 0x03};
volatile u8 RTCSetMin=0, RTCSetHour=0;
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
  DS18B20_init();
  SevenSegOut(SymbMinusA | SymbMinusB);
  SevenSegOut(SymbMinusA | SymbMinusB);
  SevenSegRefresh();
  DS18B20_convert();
  //DS3231M_Flush(10);
  for(i = 0; i < ALGO_NR_REF_SAMPLES; i++)
  {
    algo_groups_ref_samples[i] = 0;
  }

  enableInterrupts();	
  
  while (1)
  {
   if(flg_RTC_settime)
   {
     //DS3231M_SetTime();
    DS3231M_SetDate();
     flg_RTC_settime = FALSE;
   }
   if(flg_DELAY_1s)
   {
    temperature = DS18B20_read_16();
    DS3231M_GetTime();
    DS3231M_GetDate();
    DS3231M_GetTemperature();
	  if(temperature >= 0)
    {
	    flg_TEMP_neg = 0;
	  }
	  else 
	  {
	    temperature = -(temperature);
	    flg_TEMP_neg = TRUE;
	  }
	  temperature >>= 4;
    soundspeedkfactorcorrection = soundspeedkfactor * temperature;
    soundspeedkfactorcorrection /= 100;  /* convert from km/s to dm/s for compatibility with soundspeed0degC */
    soundspeed = soundspeed0degC + soundspeedkfactorcorrection;
	  DS18B20_convert();     /* issue DS18B20 convert command, to read the results after 1s */
    flg_DELAY_1s = FALSE;
    flg_TEMP_read = TRUE;	
   }
   if(flg_DELAY_100ms && flg_TEMP_read)
   {
     SONAR_TRIG_ON;
     DELAY_US(DELAY_15US);
     SONAR_TRIG_OFF;
     flg_DELAY_100ms = FALSE;
   }
   if(CAPTURE_new_mes)
   {
     if(flg_TEMP_read)
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
         flg_DIST_samples_read = TRUE;
       }
	   CAPTURE_new_mes = FALSE;
     }
   }
   if(flg_DIST_samples_read)
   {
    u32 l_sum_dist = 0;
    u8 l_dist_samples = 0;
    u8 i, j;
    /* Reset group size vector */
    for(i = 0; i < DIST_SAMP; i++)
    {
      freq_rec_dist[i] = 0;
    }
    /*-------------------------*/
    /* Calculate group sizes */
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
          else // rec_distances[i] < rec_distances[j] 
          {
            if((rec_dist[j] - rec_dist[i]) <= (u16)valid_sample_difference)
            {
              freq_rec_dist[i]++;
            }
          }
        }
      }
    }
    /*----------------------------------------------------------------------*/
    /* Add distance samples that have groups of minimum size of FREQ_THRS */
    for(l_sum_dist = 0, l_dist_samples = 0,i = 0; i < DIST_SAMP; i++)
    {
      if(freq_rec_dist[i] > FREQ_THRS) 
      {
        l_sum_dist += rec_dist[i];
        l_dist_samples++;
      }
    }
    if(l_sum_dist == 0)   /* no group had minimum size of FREQ_THRS */
    {    
      
      flg_DIST_valid_calc = FALSE;
    }
    else  /* at least one group with minimum size of FREQ_THRS was found */
    {
      DISTANCE_NEW = Med_Calib_Round(l_sum_dist, l_dist_samples);
      flg_DIST_valid_calc = TRUE;
    }
    flg_DIST_samples_read = FALSE;
   }
   if(CAPTURE_ovf_err)
   {
     
   }
   if(CAPTURE_no_trig_err)
   {
    
   }
   if(flg_DIST_valid_calc)    /* new validated distance measurement arrived */
   {
     LevelReadingAlgo();      /* Level Reading Algorithm */
     flg_DIST_valid_calc = FALSE;
   }
  }
}
void LevelReadingAlgo()
{
  if(algo_curr_phase == REFCALC_PHASE)    /* if a reference calculation is requiered */
  {
    if(algo_ref_samples_idx < 6)
    {
      algo_ref_samples[algo_ref_samples_idx++] = dist_plausi_calib;
    }
    else
    {
      u8 l_i, l_j, l_dist_samples;
      u32 l_sum_dist; 
      for(l_i = 0; l_i < ALGO_NR_REF_SAMPLES; l_i++)
      { 
        for(l_j = 0; l_j < ALGO_NR_REF_SAMPLES; l_j++)
        {
          if(l_i != l_j)
          {
            if(algo_ref_samples[l_i] >= algo_ref_samples[l_j])
            {
              if((algo_ref_samples[l_i] - algo_ref_samples[l_j]) <= (u16)2)
              {
                algo_groups_ref_samples[l_i]++;
              }
            }
            else /* rec_distances[i] < rec_distances[j] */
            {
              if((algo_ref_samples[l_j] - algo_ref_samples[l_i]) <= (u16)2)
              {
                algo_groups_ref_samples[l_i]++;
              }
            }
          }
        }
      }
      /* Add distance samples that have groups of minimum size of FREQ_THRS */
      for(l_sum_dist = 0, l_dist_samples = 0,l_i = 0; l_i < ALGO_NR_REF_SAMPLES; l_i++)
      {
        if(algo_groups_ref_samples[l_i] > 3) 
        {
          l_sum_dist += algo_ref_samples[l_i];
          l_dist_samples++;
        }
      }
      if(l_sum_dist == 0)   /* no group had minimum size of FREQ_THRS */
      {    
        /* Calculate reference again */
        algo_ref_samples_idx = 0; 
        //dist_plausi = 0;
        //flg_DIST_valid_calc = FALSE;
      }
      else
      {
        DISTANCE_NEW = DISTANCE_OLD = (u16)(l_sum_dist / l_dist_samples);
        DisplayDIST(DISTANCE_NEW);
        algo_curr_phase = DIST_VALID_PHASE;
      }
    }
  }
  else if(algo_curr_phase == DIST_VALID_PHASE)
  {
    u8 flg_dist_var_too_high = FALSE;
    DISTANCE_NEW = dist_plausi_calib;
    DisplayDIST(DISTANCE_NEW);
    if(DISTANCE_NEW > DISTANCE_OLD)
    {
      if(DISTANCE_NEW - DISTANCE_OLD > 3) 
      {
        flg_dist_var_too_high = TRUE;
      }
    } 
    else
    {
      if(DISTANCE_OLD - DISTANCE_NEW > 3)
      {
        flg_dist_var_too_high = TRUE;
      }
    }
    if(flg_dist_var_too_high)
    {
      algo_curr_phase = REFCALC_PHASE;
      algo_ref_samples_idx = 0;
      SevenSegOut(SymbMinusA | SymbMinusB);
      SevenSegOut(SymbMinusA | SymbMinusB);
      SevenSegRefresh();
    }
    DISTANCE_OLD = DISTANCE_NEW;
  }
}
void DisplayDIST(u16 distance)
{
  u8 disp[4];
  /* Prepare data and display on screen */
  disp[3] = (u8)(distance % 10);
  distance /= 10;
  disp[2] = (u8)(distance % 10);
  distance /= 10;
  disp[1] = (u8)(distance);
  disp[0] = 0;
  SevenSegOut(A[disp[2]] | B[disp[3]]);
  SevenSegOut(0 | B[disp[1]]);
  SevenSegRefresh();
}

void SendDIST_UART(u16 distance)
{
  /* Send validated and calibrated distance measurement through UART */
  while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
  UART1_SendData8((u8)((distance << 8) >> 8));  /* send LSB first */
  while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
  UART1_SendData8((u8)(distance >> 8));         /* send MSB second */
  while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
  UART1_SendData8((u8)',');                     /* put commas between values to be compatible with a csv file */
}

u16 Med_Calib_Round(u32 sum_dist, u8 dist_samples)
{
  u16 dist_plausi;
  dist_plausi = (u16)(sum_dist / dist_samples);
  if(dist_plausi <= 4240)   /* if real measured distance <= 400cm */
  {
    u16 temp_dist_plausi_calib;
    dist_plausi_calib = dist_plausi;       /* 1595 */
    dist_plausi_calib /= 10;               /* 159 */
    if((dist_plausi % 10) >= 5)            /* rounding */
    {
    dist_plausi_calib++;                  /* 160 */
    }
    dist_plausi_calib *= 106;              /* 16960 */
    temp_dist_plausi_calib = dist_plausi_calib;
    dist_plausi_calib /= 100;              /* 169 */
    if((temp_dist_plausi_calib % 100) >= 50)  /* rounding */
    {
      dist_plausi_calib++;                 /* 170 */
    }
    SendDIST_UART(dist_plausi_calib);
    //DisplayDIST(dist_plausi_calib);
    return dist_plausi_calib;
  }
  return 0;
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
