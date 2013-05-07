
#include "stm8s_conf.h"
#include "board.h"

void Config()
{
  /* Fmaster = 16MHz */
  CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);
  
  /* Enable peripheral clock */
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);   /* 8bit: for implementing delays */
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);   /* 16bit: for capture of ultrasonic distance pulse width */
  //CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);   /* used for delays */

  /* PD0 - output open drain low - LED */
  GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_OD_HIZ_SLOW);
  
  /* PD1 - output push pull low - Debug Pin*/
  GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);
  
  /* output open drain high - 1 Wire bus -released */
  GPIO_Init(ONEWIREBUS_PORT, ONEWIREBUS_PIN, GPIO_MODE_OUT_OD_HIZ_FAST);

  /* Software SPI pin init - RFM70 */
  GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
  GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);
  GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);    
  GPIO_Init(GPIOB, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
  GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
  
  /* Sonar Pin init */  
  //GPIO_Init(GPIOC, GPIO_PIN_6, GPIO_MODE_OUT_PP_LOW_FAST);
  GPIO_Init(GPIOC, GPIO_PIN_7, GPIO_MODE_OUT_PP_LOW_FAST);
  GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);

  /* TIMER4 configuration */
  TIM4_DeInit();
  TIM4_TimeBaseInit(TIM4_PRESCALER_128, 250);                 /* 2MS overflow interval - 500Hz*/
  TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
  TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
  TIM4_Cmd(ENABLE);

  /* TIMER1 configuration */
  TIM1_DeInit();
  TIM1_TimeBaseInit(16, TIM1_COUNTERMODE_UP, 65535, 0x00);     /* 65.536ms overflow period */
  TIM1_ICInit(TIM1_CHANNEL_2, TIM1_ICPOLARITY_RISING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00);    /* PC2 */
  TIM1_ICInit(TIM1_CHANNEL_3, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00);     /* PC3 */
  TIM1_ITConfig(TIM1_IT_CC3, ENABLE);            /* interrupt on timer capture compare 3 - falling edge of pulse */
  TIM1_ClearITPendingBit(TIM1_FLAG_CC3);
  TIM1_ClearITPendingBit(TIM1_FLAG_CC2);
  TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
  TIM1_Cmd(ENABLE);
}