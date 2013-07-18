/* Includes ------------------------------------------------------------------*/

#include "board.h"

/**
  * @brief  delay for some time in ms unit
  * @caller auto_test
  * @param  n_ms is how many ms of time to delay
  * @retval None
  */
void delay_ms(u16 n_ms)
{
/* Init TIMER 4 */
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);

/* Init TIMER 4 prescaler: / (2^6) = /64 */
  TIM2->PSCR = 6;

/* HSI div by 1 --> Auto-Reload value: 16M / 64 = 1/4M, 1/4M / 1k = 250*/
  TIM2->ARRH = 0;
  TIM2->ARRL = 250;
  
/* Counter value: 2, to compensate the initialization of TIMER*/
    
  TIM2->CNTRH = 0;
  TIM2->CNTRL = 2;

/* clear update flag */
  TIM2->SR1 &= (u8)(~0x01);

/* Enable Counter */
  TIM2->CR1 |= 0x01;

  while(n_ms--)
  {
    while((TIM2->SR1 & 0x01) == 0) ;
    TIM2->SR1 &= (u8)(~0x01);
  }

/* Disable Counter */
  TIM2->CR1 &= (u8)(~0x01);
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
}

/**
  * @brief  delay for some time in 10us unit(partial accurate)
  * @caller auto_test
  * @param n_10us is how many 10us of time to delay
  * @retval None
  */
void delay_10us(u8 n_10us)
{
  /* Counter value: 10, to compensate the initialization of TIMER */
  TIM2->CNTRH = 0;
  TIM2->CNTRL = 10;

  /* clear update flag */
  TIM2->SR1 &= (u8)(~0x01);

  /* Enable Counter */
  TIM2->CR1 |= 0x01;

  while(n_10us--)
  {
    while((TIM2->SR1 & 0x01) == 0) ;
    TIM2->SR1 &= 0xFE;
  }
  /* Disable Counter */
  TIM2->CR1 &= 0xFE;
}
/******************* (C) COPYRIGHT 2010 STMicroelectronics *****END OF FILE****/
