/**
  ******************************************************************************
  * @file     stm8s_it.c
  * @author   MCD Application Team
  * @version  V2.1.0
  * @date     18-November-2011
  * @brief    Main Interrupt Service Routines.
  *           This file provides template for all peripherals interrupt service
  *           routine.
  ******************************************************************************
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "stm8s_it.h"
#include "board.h"
#include "ds18b20.h"

/** @addtogroup Template_Project
  * @{
  */

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/

#define DELAY_CNT_1S  500
#define DELAY_CNT_100MS  50
#define DELAY_CNT_50MS  25
#define CAPTURE_ERR_CNT_THRS 10
#define SENSOR_ALIVE_THRS 1000    /* 1000*2ms = 2000ms */
u8 delay_cnt_100ms = 0;
u8 delay_100ms_flag = FALSE;
u16 delay_cnt_1s = 0;
u8 delay_1s_flag = FALSE;
u8 delay_cnt_50ms = 0;
u8 delay_50ms_flag = FALSE;
u8 CAPTURE_new_mes = FALSE;
u16 CAPTURE_delta = 0;
u8 tmpccr3h;
u8 tmpccr3l;
u16 tmpccr3;
u8 CAPTURE_status = 0;
u8 CAPTURE_ovf_cnt = 0;
u8 CAPTURE_no_trig_cnt = 0;
u8 CAPTURE_no_err_cnt = 0;
u8 CAPTURE_ovf_err = FALSE;
u8 CAPTURE_no_trig_err = FALSE;
u8 CAPTURE_sensor_not_responding_err = FALSE;
u16 sensor_alive_cnt = 0;
/*
  CAPTURE_status = 0   init value timer 1 capture ISR not reached
  CAPTURE_status = 1   CC3 interrupt occured, time between rising and falling edge greater than 65.536ms
  CAPTURE_status = 2   CC3 interrupt occured, no rising edge trigger occured previously
  CAPTURE_status = 3   CC3 interrupt occured, capture ok (no timer overflow, rising edge trigger occured), CAPTURE_new_mes = FALSE
  CAPTURE_status = 4   CC3 interrupt occured, capture ok (no timer overflow, rising edge trigger occured), CAPTURE_new_mes = TRUE
  CAPTURE_status = 5   timer 1 capture occured, CC3 interrupt capture not occured
*/

#ifdef _COSMIC_
/**
  * @brief Dummy Interrupt routine
  * @par Parameters:
  * None
  * @retval
  * None
*/
INTERRUPT_HANDLER(NonHandledInterrupt, 25)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /*_COSMIC_*/

/**
  * @brief TRAP Interrupt routine
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief Top Level Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(TLI_IRQHandler, 0)

{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief Auto Wake Up Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(AWU_IRQHandler, 1)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief Clock Controller Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(CLK_IRQHandler, 2)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief External Interrupt PORTA Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief External Interrupt PORTB Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief External Interrupt PORTC Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief External Interrupt PORTD Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief External Interrupt PORTE Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

#ifdef STM8S903
/**
  * @brief External Interrupt PORTF Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(EXTI_PORTF_IRQHandler, 8)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /*STM8S903*/

#if defined (STM8S208) || defined (STM8AF52Ax)
/**
  * @brief CAN RX Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(CAN_RX_IRQHandler, 8)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief CAN TX Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(CAN_TX_IRQHandler, 9)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /*STM8S208 || STM8AF52Ax */

/**
  * @brief SPI Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(SPI_IRQHandler, 10)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief Timer1 Update/Overflow/Trigger/Break Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  //while(1);
  if(DEBUG_PIN_STATE)
    DEBUG_PIN_OFF;
  else DEBUG_PIN_ON;
  TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
}

/**
  * @brief Timer1 Capture/Compare Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  CAPTURE_status = 5;
  if(TIM1->SR1 & TIM1_IT_CC3)
  {    
    TIM1->CR1 &= ~(0x01);      /* after measurement stop the timer, to be restarted by sonar rising edge */
	  TIM1->CNTRH = 0x00;        /* reset timer */
	  TIM1->CNTRL = 0x00; 
	  sensor_alive_cnt = 0;      /* reset ultrasonic sensor alive watchdog */
    CAPTURE_sensor_not_responding_err = FALSE;
    CAPTURE_status = 4;	
	  if(!(TIM1->SR1 & TIM1_IT_TRIGGER))  
	  {
	    /* if no trigger occured previously */
	    CAPTURE_status = 2;
	    if(CAPTURE_no_trig_cnt < (u8)255) ++CAPTURE_no_trig_cnt; 
	    if(CAPTURE_no_trig_cnt >= (u8)CAPTURE_ERR_CNT_THRS)
	    {
	      CAPTURE_no_err_cnt = 0;
	      CAPTURE_no_trig_err = TRUE;
	    }
	  }
    else if(TIM1->SR1 & TIM1_IT_UPDATE)
	  {
	    /* if we have timer overflow since last trigger - echo out of specification of sonar */
	    CAPTURE_status = 1;
	    if(CAPTURE_ovf_cnt < (u8)255) ++CAPTURE_ovf_cnt;
	    if(CAPTURE_ovf_cnt >= (u8)CAPTURE_ERR_CNT_THRS)
	    {
	      CAPTURE_no_err_cnt = 0;
		    CAPTURE_ovf_err = TRUE;
	    }
	  }
	  else if(CAPTURE_new_mes == FALSE)
    {
      tmpccr3h = TIM1->CCR3H;
      tmpccr3l = TIM1->CCR3L;
      CAPTURE_delta = (u16)(tmpccr3l);
      CAPTURE_delta |= (u16)((u16)tmpccr3h << 8);
      CAPTURE_new_mes = TRUE;    /* new distance measurement value */
	    CAPTURE_status = 3;
    }
	  if(CAPTURE_no_err_cnt < (u8)255)  ++CAPTURE_no_err_cnt;
	  if(CAPTURE_no_err_cnt >= (u8)CAPTURE_ERR_CNT_THRS) 
	  {
	    CAPTURE_ovf_cnt = 0;
	    CAPTURE_no_trig_cnt = 0;
	    CAPTURE_ovf_err = FALSE;
	    CAPTURE_no_trig_err = FALSE;
	  }
	  TIM1->SR1 = (u8)(~(u8)TIM1_IT_UPDATE);     /* clear TIM1 UPDATE interrupt flag */
    TIM1->SR1 = (u8)(~(u8)TIM1_IT_CC3);        /* clear TIM1 CC3 interrupt flag */
	  TIM1->SR1 = (u8)(~(u8)TIM1_IT_TRIGGER);    /* clear TIM1 TRIGGER interrupt flag */
  }
}

#ifdef STM8S903
/**
  * @brief Timer5 Update/Overflow/Break/Trigger Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(TIM5_UPD_OVF_BRK_TRG_IRQHandler, 13)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief Timer5 Capture/Compare Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(TIM5_CAP_COM_IRQHandler, 14)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

#else /*STM8S208, STM8S207, STM8S105 or STM8S103 or STM8AF62Ax or STM8AF52Ax or STM8AF626x */
/**
* @brief Timer2 Update/Overflow/Break Interrupt routine.
* @param  None
* @retval None
*/
INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
{
  /* In order to detect unexpected events during development,
  it is recommended to set a breakpoint on the following instruction.
  */
}

/**
* @brief Timer2 Capture/Compare Interrupt routine.
* @param  None
* @retval None
*/
INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
{
  /* In order to detect unexpected events during development,
  it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /*STM8S903*/

#if defined (STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8S105) || \
    defined(STM8S005) ||  defined (STM8AF62Ax) || defined (STM8AF52Ax) || defined (STM8AF626x)
/**
  * @brief Timer3 Update/Overflow/Break Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief Timer3 Capture/Compare Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /*STM8S208, STM8S207 or STM8S105 or STM8AF62Ax or STM8AF52Ax or STM8AF626x */

#if defined (STM8S208) || defined(STM8S207) || defined(STM8S007) || defined(STM8S103) || \
    defined(STM8S003) ||  defined (STM8AF62Ax) || defined (STM8AF52Ax) || defined (STM8S903)
/**
  * @brief UART1 TX Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief UART1 RX Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
  u8 rx_data = UART1_ReceiveData8();
  UART1_ClearITPendingBit(UART1_IT_RXNE);
}
#endif /*STM8S208 or STM8S207 or STM8S103 or STM8S903 or STM8AF62Ax or STM8AF52Ax */

/**
  * @brief I2C Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(I2C_IRQHandler, 19)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

#if defined(STM8S105) || defined(STM8S005) ||  defined (STM8AF626x)
/**
  * @brief UART2 TX interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief UART2 RX interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /* STM8S105 or STM8AF626x */

#if defined(STM8S207) || defined(STM8S007) || defined(STM8S208) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
/**
  * @brief UART3 TX interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @brief UART3 RX interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /*STM8S208 or STM8S207 or STM8AF52Ax or STM8AF62Ax */

#if defined(STM8S207) || defined(STM8S007) || defined(STM8S208) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
/**
  * @brief ADC2 interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#else /*STM8S105, STM8S103 or STM8S903 or STM8AF626x */
/**
* @brief ADC1 interrupt routine.
* @par Parameters:
* None
* @retval
* None
*/
INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
{
  /* In order to detect unexpected events during development,
  it is recommended to set a breakpoint on the following instruction.
  */
}
#endif /*STM8S208 or STM8S207 or STM8AF52Ax or STM8AF62Ax */

#ifdef STM8S903
/**
  * @brief Timer6 Update/Overflow/Trigger Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(TIM6_UPD_OVF_TRG_IRQHandler, 23)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}
#else /*STM8S208, STM8S207, STM8S105 or STM8S103 or STM8AF52Ax or STM8AF62Ax or STM8AF626x */
/**
* @brief Timer4 Update/Overflow Interrupt routine.
* @param  None
* @retval None
*/
INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)     /* once every 2MS */
{
  /* In order to detect unexpected events during development,
  it is recommended to set a breakpoint on the following instruction.
  */
  //if(GPIOD->IDR & GPIO_PIN_2)  /* 4MS period -> f=250Hz */
  /*{
    DISP_SDI_0;
    DISP_nOE_0;
    DISP_LE_0;
    DISP_CLK_0;
  }
  else
  {
    DISP_SDI_1;
    DISP_nOE_1;
    DISP_LE_1;
    DISP_CLK_1;
  }*/
  /* Ultrasonic sensor alive watchdog */
  if(sensor_alive_cnt < 65535)  sensor_alive_cnt++;   /* to be reset in sensor ISR */
  if(sensor_alive_cnt >= SENSOR_ALIVE_THRS)
  {
    CAPTURE_sensor_not_responding_err = TRUE;
  }
  /*----------------------------------*/
  /* 1S flag */
  
  if(delay_1s_flag == FALSE) delay_cnt_1s++;
  if(delay_cnt_1s >= DELAY_CNT_1S)
  {
    delay_1s_flag = TRUE;
    delay_cnt_1s = 0; 
  }
  /* ------- */
  /* 100mS flag */
  if(delay_100ms_flag == FALSE) delay_cnt_100ms++;
  if(delay_cnt_100ms >= DELAY_CNT_100MS)
  {
    delay_100ms_flag = TRUE;
    delay_cnt_100ms = 0; 
  }
  /* -----------*/
  /* 50mS flag */
  if(delay_50ms_flag == FALSE) delay_cnt_50ms++;
  if(delay_cnt_50ms >= DELAY_CNT_50MS)
  {
    delay_50ms_flag = TRUE;
    delay_cnt_50ms = 0; 
  }
  /* --------- */
  TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
}
#endif /*STM8S903*/

/**
  * @brief Eeprom EEC Interrupt routine.
  * @param  None
  * @retval None
  */
INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
}

/**
  * @}
  */

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/