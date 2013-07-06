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
#include "cyclic.h"
#include "config.h"
#include "delay.h"
#include "ds18b20.h"
#include "7seg.h"
#include "ds3231m_rtc.h"
#include "flashmngr.h"

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

/* CONSTANTS ---------------------------------------------------------------*/
const u16 soundspeed0degC = 3313;       /* speed of sound at 0 degrees Celsius: 331.3m/s 3313dm/s */
const u16 soundspeedkfactor = 606;      /* c_air = 331.3 + 0.606C^-1 * dT_0_C [km/s]v*/
const u8 valid_sample_difference = 20;  /* all valid samples must be within +/- 30mm of each other */
const u8 sensor_calib_value = 106;      /* adjust at 106% of sensor value*/

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
u8 algo_curr_phase = REFCALC_PHASE;
u16 algo_ref_samples[ALGO_NR_REF_SAMPLES];
u8 algo_ref_samples_idx = 0;
u8 algo_groups_ref_samples[ALGO_NR_REF_SAMPLES];
s16 temperature = 0;
s32 distance = 0;
s16 soundspeedkfactorcorrection = 0;
u16 soundspeed = 0;          /* [dm/s] - tens of centimeters/ s */
u16 rec_dist[DIST_SAMP];     /* distance samples */
u8 freq_rec_dist[DIST_SAMP];
u8 idx_rec_dist = 0;
u16 dist_plausi_calib = 0;
u16 DISTANCE_NEW = 0, DISTANCE_OLD = 0;
u8 buff[16];
u8 flash_stat;
u8 ROM_ID2[8];
u16 CYCLYC_1S_cnt = 0;
u32 SPIFlash_pointer = (u32)0x0;
#define SPIFlash_ptr_loc     (u32)0x0
#define SPIFlash_MAX_ADDRESS (u32)0x1FFFFF
/* FLAGS */
volatile _Bool FLAG_temp_neg = FALSE;
volatile _Bool FLAG_temp_read = FALSE;
volatile _Bool FLAG_dist_samp_read = FALSE;
volatile _Bool FLAG_dist_valid_calc = FALSE;
volatile _Bool FLAG_rtc_settime = FALSE;
volatile _Bool FLAG_ds18b20_err = FALSE;
volatile _Bool FLAG_spiflash_access = FALSE;
volatile _Bool FLAG_spiflash_write = FALSE;
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
  SevenSegOut(SymbMinusA | SymbMinusB);
  SevenSegOut(SymbMinusA | SymbMinusB);
  SevenSegRefresh();
  FLAG_ExtFlashinit_OK = FlashMngr_Init();
  //FLAG_ds18b20_err = DS18B20_Read_ROM_ID(ROM_ID1);
  FLAG_ds18b20_err = DS18B20_All_convert();
  for(i = 0; i < ALGO_NR_REF_SAMPLES; i++)
  {
    algo_groups_ref_samples[i] = 0;
  }

  enableInterrupts();
  
  while (1)
  {
   if(FLAG_rtc_settime)
   {
     //DS3231M_SetTime();
     DS3231M_SetDate();
     FLAG_rtc_settime = FALSE;
   }
   if(CYCLIC_1s)
   {
    u16 temp_frac, temp_intreg, tmp;
    //FLAG_ds18b20_err = DS18B20_All_Read_Temp(&temperature);
    DS18B20_Read_Temp(&temperature, ROM_ID1);
    DS3231M_GetTime();
    DS3231M_GetDate();
    //DS3231M_GetTemperature();
    
    if(FLAG_spiflash_access)
    {
      //SST25VF016_Read_ID(buff);
      //SST25VF016_Read_JEDEC_ID(buff);
      //SST25VF016_Read_Status_Register(&flash_stat);
      //SST25VF016_Program_Byte(0x100005, 0x73);
      //SST25VF016_Read(SPIFlash_pointer, buff, 16);
      FLAG_spiflash_access = FALSE;
    }
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
    SevenSegOut(A[(temp_intreg)%10] | B[temp_frac] | SymbComma);
    SevenSegOut(0 | B[(temp_intreg)/10]);
    SevenSegRefresh();
    
    FLAG_ds18b20_err = DS18B20_All_convert();    /* issue DS18B20 convert command, to read the results after 1s */
    if(FLAG_spiflash_write && CYCLYC_1S_cnt >= 60)
    {
      CYCLYC_1S_cnt = 0;
      if(temp_intreg > 35) FLAG_spiflash_write = FALSE; 
      //SST25VF016_Program_Byte(SPIFlash_pointer++, (u8)temp_intreg);
      //SST25VF016_Program_Byte(SPIFlash_pointer++, (u8)RTC_hour);
      //SST25VF016_Program_Byte(SPIFlash_pointer++, (u8)RTC_min);
      //SST25VF016_Program_Byte(SPIFlash_pointer++, (u8)RTC_sec);
    }
    if(CYCLYC_1S_cnt < 65534) CYCLYC_1S_cnt++;
    CYCLIC_1s = FALSE;
    FLAG_temp_read = TRUE;	
   }
   if(CYCLIC_100ms && FLAG_temp_read)
   {
     //SONAR_TRIG_ON;
     //DELAY_US(DELAY_15US);
     //SONAR_TRIG_OFF;
     CYCLIC_100ms = FALSE;
   }
   if(EVENT_cap_new_mes)
   {
     if(FLAG_temp_read)
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
         FLAG_dist_samp_read = TRUE;
       }
       EVENT_cap_new_mes = FALSE;
     }
   }
   if(FLAG_dist_samp_read)
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
      
      FLAG_dist_valid_calc = FALSE;
    }
    else  /* at least one group with minimum size of FREQ_THRS was found */
    {
      DISTANCE_NEW = Med_Calib_Round(l_sum_dist, l_dist_samples);
      FLAG_dist_valid_calc = TRUE;
    }
    FLAG_dist_samp_read = FALSE;
   }
   if(ERROR_cap_ovf)
   {
     
   }
   if(ERROR_cap_no_trig)
   {
    
   }
   if(FLAG_dist_valid_calc)    /* new validated distance measurement arrived */
   {
     LevelReadingAlgo();      /* Level Reading Algorithm */
     FLAG_dist_valid_calc = FALSE;
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
        //FLAG_dist_valid_calc = FALSE;
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
    dist_plausi_calib = dist_plausi;            /* 1595 */
    dist_plausi_calib /= 10;                    /* 159 */
    if((dist_plausi % 10) >= 5)                 /* rounding */
    {
    dist_plausi_calib++;                        /* 160 */
    }
    dist_plausi_calib *= sensor_calib_value;    /* 16960 */
    temp_dist_plausi_calib = dist_plausi_calib;
    dist_plausi_calib /= 100;                   /* 169 */
    if((temp_dist_plausi_calib % 100) >= 50)    /* rounding */
    {
      dist_plausi_calib++;                      /* 170 */
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
