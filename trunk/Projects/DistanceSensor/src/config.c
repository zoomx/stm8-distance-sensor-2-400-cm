
#include "stm8s_conf.h"
#include "board.h"

void Config()
{
  /* Fmaster = 16MHz */
  //CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);
  //CLK_HSECmd(ENABLE);
  //CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
  /* Automatic clock switching from HSI/8 to HSE */
  CLK_DeInit();
  CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
  CLK->ECKR |= 0x01;   /* HSEEN: High speed external crystal oscillator enable */
  while(!(CLK->ECKR & 0x02));  /* HSERDY: High speed external crystal oscillator ready, waint until HSE ready */
  CLK->SWCR |= 0x02;   /* set SWEN bit: Switch start/stop */
  CLK->SWR = 0xB4;     /* HSE selected as master clock source */
  while(CLK->SWCR & 0x01);   /* wait until switch busy: SWBSY = 1 */
  /* Alternative to try
     CLK_LSICmd(ENABLE);
     CLK_SYSCLKDivConfig(CLK_SYSCLKDiv_1);
     CLK_SYSCLKSourceConfig(CLK_SYSCLKSource_LSI);
     CLK_SYSCLKSourceSwitchCmd(ENABLE);
     while (((CLK->SWCR)& 0x01)==0x01); */
  
  /* Enable peripheral clock */
  //CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);   /* 8bit: for implementing delays */
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);   /* 16bit: for capture of ultrasonic distance pulse width */
  //CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);   /* used for delays */

  /* Sonar Pin init */  
  GPIO_Init(GPIOC, GPIO_PIN_7, GPIO_MODE_OUT_PP_LOW_FAST);
  GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);

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

  /* TIMER4 configuration */
  TIM4_DeInit();
  TIM4_TimeBaseInit(TIM4_PRESCALER_128, 250);                 /* 2MS overflow interval - 500Hz*/
  TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
  TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
  TIM4_Cmd(ENABLE);

  /* TIMER1 configuration */
  TIM1_DeInit();
  TIM1_TimeBaseInit(16, TIM1_COUNTERMODE_UP, 65535, 0x00);     /* 65.536ms overflow period */
  //TIM1->CCMR1 |= 0x02;  /* 10: CC1 channel is configured as input, IC1 is mapped on TI2FP1, to link the TIM1_CCR1 register to the TI2 input write the CC1S bits to 10 in the TIM1_CCMR1 register. This configures the channel in input mode and the TIM1_CCR1 register becomes read-only */
  /*TIM1->CCMR1 = 0;*/  /* Program the required input filter duration for the signal to be connected to the timer. This is done for each TIi input using the ICiF bits in the TIM1_CCMRi registers */
  /*TIM1->CCER1 = 0;*/  /* Select the edge of the active transition on the TI1 channel by writing the CC1P bit to 0 in the TIM1_CCER1 register (rising edge in this case).*/
  /*TIM1->CCMR1 = 0;*/  /* Program the input prescaler so the prescaler is disabled (write the IC1PS bits to 00 in the TIM1_CCMR1 register). */
  //TIM1->CCER1 |= 0x01;  /* CC1E: Capture/compare 1 output enable, This bit determines if a capture of the counter value can be made in the input capture/compare */
  /* If needed, enable the related interrupt request by setting the CC1IE bit in the TIM1_IER register */
  //TIM1->CCMR3 |= 0x01;  /* 01: CC3 channel is configured as input, IC3 is mapped on TI3FP3 */
  //TIM1->CCER2 |= 0x01;  /* CC3E: Capture/compare 3 output enable */
  //TIM1->CCER2 |= 0x02;  /* CC3P: Capture/compare 3 output polarity, 1: Capture on a falling edge */
  /*TIM1_ICInit(TIM1_CHANNEL_2, TIM1_ICPOLARITY_RISING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00);*/    /* PC2 */
  /*TIM1_ICInit(TIM1_CHANNEL_3, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00);*/     /* PC3 */
  /* Trigger reset mode */
  TIM1->CCER1 &= ~(0x20); /* Write CC2P = 0 in TIM1_CCER1 register to validate the polarity (and detect rising edges).*/
  TIM1->SMCR |= 0x04;  /* SMS = 100, Reset mode - Rising edge of the selected trigger signal (TRGI) re-initializes the counter */
  TIM1->SMCR |= 0x60;  /* TS = 110, 110: Filtered timer input 2 (TI2FP2) */
  TIM1->CCMR3 |= 0x01;  /* 01: CC3 channel is configured as input, IC3 is mapped on TI3FP3 */
  TIM1->CCER2 |= 0x01;  /* CC3E: Capture/compare 3 output enable */
  TIM1->CCER2 |= 0x02;  /* CC3P: Capture/compare 3 output polarity, 1: Capture on a falling edge */

  TIM1_ITConfig(TIM1_IT_CC3, ENABLE);            /* interrupt on timer capture compare 3 - falling edge of pulse */
  TIM1_ClearITPendingBit(TIM1_FLAG_CC3);
  TIM1_ClearITPendingBit(TIM1_FLAG_CC2);
  TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
  TIM1_Cmd(ENABLE);
}