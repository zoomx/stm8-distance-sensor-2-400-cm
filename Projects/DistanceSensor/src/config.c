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
  //CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, ENABLE);     /* Enable I2C peripheral clock */
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);     /* Enable SPI peripheral clock */
  CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);   /* Enable UART1 peripheral clock */

  /* Sonar Pin init */  
  GPIO_Init(SONAR_TRIG_PORT, SONAR_TRIG_PIN, GPIO_MODE_OUT_PP_LOW_FAST);      /* Sonar trigger pin - output push-pull */
  GPIO_Init(SONAR_TMR_TRIG_PORT, SONAR_TMR_TRIG_PIN, GPIO_MODE_IN_PU_NO_IT);  /* Sonar timer trigger start pin(rising) - input pullup */
  GPIO_Init(SONAR_TMR_CAP_PORT, SONAR_TMR_CAP_PIN, GPIO_MODE_IN_PU_NO_IT);    /* Sonar timer trigger capture pin(falling) - input pullup */

  /* Output open drain low - LED */
  GPIO_Init(LED_PORT, LED_PIN, GPIO_MODE_OUT_OD_HIZ_SLOW);
  
  /* Output push pull low - Hardware Test Pin*/
  GPIO_Init(DEBUG_PIN_PORT, DEBUG_PIN_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
  
  /* output open drain high - 1 Wire bus -released */
  GPIO_Init(ONEWIREBUS_PORT, ONEWIREBUS_PIN, GPIO_MODE_OUT_OD_HIZ_FAST);

  /* Hardware SPI pin init */
  GPIO_Init(GPIOC, GPIO_PIN_5, GPIO_MODE_OUT_PP_LOW_FAST);   //SCK
  GPIO_Init(GPIOC, GPIO_PIN_6, GPIO_MODE_OUT_PP_LOW_FAST);   //MOSI
  GPIO_Init(GPIOC, GPIO_PIN_7, GPIO_MODE_IN_PU_NO_IT);       //MISO
  GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST);   //CS

  /* Display Interface */
  GPIO_Init(DISP_PORT, DISP_SDI_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
  GPIO_Init(DISP_PORT, DISP_nOE_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
  GPIO_Init(DISP_PORT, DISP_LE_PIN, GPIO_MODE_OUT_PP_LOW_FAST);    
  GPIO_Init(DISP_PORT, DISP_CLK_PIN, GPIO_MODE_OUT_PP_LOW_FAST);

  /* UART1 Configuration */
  UART1_DeInit();
  GPIO_Init(USART_PORT, USART_TX_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
  GPIO_Init(USART_PORT, USART_RX_PIN, GPIO_MODE_IN_PU_NO_IT);
  UART1_Init(9600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, 
                UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
  UART1_ITConfig(UART1_IT_RXNE, ENABLE);
  UART1_Cmd(ENABLE);

  /* Software I2C Pin Configuration */
  GPIO_Init(SOFTI2C_PORT, SOFTI2C_SCL_PIN, GPIO_MODE_OUT_OD_HIZ_FAST);
  GPIO_Init(SOFTI2C_PORT, SOFTI2C_SDA_PIN, GPIO_MODE_OUT_OD_HIZ_FAST);


  /* TIMER4 configuration */
  TIM4_DeInit();
  TIM4_TimeBaseInit(TIM4_PRESCALER_128, 250);                 /* 2MS overflow interval - 500Hz*/
  TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
  TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
  TIM4_Cmd(ENABLE);

  /* TIMER1 configuration */
  TIM1_DeInit();
  TIM1_TimeBaseInit(16, TIM1_COUNTERMODE_UP, 65535, 0x00);     /* 65.536ms overflow period */
  /* Trigger standard mode */
  TIM1->CCER1 &= (u8)(~(0x20)); /* Write CC2P = 0 in TIM1_CCER1 register to validate the polarity (and detect rising edges).*/
  TIM1->SMCR |= 0x06;  /* Configure the timer in trigger mode by writing SMS = 110 */
  TIM1->SMCR |= 0x60;  /* TS = 110, 110: Filtered timer input 2 (TI2FP2) */
  TIM1->CCMR3 |= 0x01;  /* 01: CC3 channel is configured as input, IC3 is mapped on TI3FP3 */
  TIM1->CCER2 |= 0x01;  /* CC3E: Capture/compare 3 output enable */
  TIM1->CCER2 |= 0x02;  /* CC3P: Capture/compare 3 output polarity, 1: Capture on a falling edge */

  TIM1_ITConfig(TIM1_IT_CC3, ENABLE);            /* interrupt on timer capture compare 3 - falling edge of pulse */
  TIM1_ClearITPendingBit(TIM1_FLAG_CC3);
  TIM1_ClearITPendingBit(TIM1_FLAG_CC2);
  TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
  //TIM1_Cmd(ENABLE);   /* Timer1 start by trigger */
}