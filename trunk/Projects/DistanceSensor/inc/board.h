#ifndef _BOARD_H_
#define _BOARD_H_

#include "stm8s_conf.h"

/*
PC1 - 1Wire Bus
*/

#define ONEWIREBUS_PORT   GPIOB
#define ONEWIREBUS_PIN    GPIO_PIN_6

#define ONEWIREBUS_READ          (ONEWIREBUS_PORT->IDR & ONEWIREBUS_PIN)
#define ONEWIREBUS_INPUT_MODE    (ONEWIREBUS_PORT->DDR &= (uint8_t)(~(ONEWIREBUS_PIN)))
#define ONEWIREBUS_OUTPUT_MODE   (ONEWIREBUS_PORT->DDR |= (uint8_t)ONEWIREBUS_PIN)
#define ONEWIREBUS_CLEAR_OUTPUT  (ONEWIREBUS_PORT->ODR &= ~ONEWIREBUS_PIN)
#define ONEWIREBUS_SET_OUTPUT    (ONEWIREBUS_PORT->ODR |= ONEWIREBUS_PIN)
#define ONEWIREBUS_INPUT_CKECK   (ONEWIREBUS_PORT->IDR & ONEWIREBUS_PIN)

#define LED_PORT  GPIOD 
#define LED_PIN   GPIO_PIN_0

#define LED_ON    (LED_PORT->ODR |= LED_PIN)
#define LED_OFF   (LED_PORT->ODR &= ~LED_PIN)
#define LED_STATE (LED_PORT->IDR & LED_PIN)

#define DEBUG_PIN_PORT  GPIOD
#define DEBUG_PIN_PIN   GPIO_PIN_1

#define DEBUG_PIN_ON    (DEBUG_PIN_PORT->ODR |= DEBUG_PIN_PIN)
#define DEBUG_PIN_OFF   (DEBUG_PIN_PORT->ODR &= ~DEBUG_PIN_PIN)
#define DEBUG_PIN_STATE (DEBUG_PIN_PORT->IDR & DEBUG_PIN_PIN)

#define SONAR_PORT  GPIOC
#define SONAR_TRIG_PIN   GPIO_PIN_7

#define SONAR_TRIG_ON    (SONAR_PORT->ODR |= SONAR_TRIG_PIN)
#define SONAR_TRIG_OFF   (SONAR_PORT->ODR &= ~SONAR_TRIG_PIN)
#define SONAR_TRIG_STATE (SONAR_PORT->IDR & SONAR_TRIG_PIN)

/*---SPI CONFIG---
PB0 - SCK  - OUT
PB1 - MOSI - OUT
PB2 - MISO - IN
PB3 - CSN  - OUT
PB4 - CE   - OUT
-----------------*/

#define BOARD_SCK_1      (GPIOB->ODR |= 0x01) 
#define BOARD_SCK_0      (GPIOB->ODR &= ~0x01)
#define BOARD_MOSI_1     (GPIOB->ODR |= 0x02)
#define BOARD_MOSI_0     (GPIOB->ODR &= ~0x02)
#define BOARD_MISO       (GPIOB->IDR & 0x04)                               
#define BOARD_CSN_1      (GPIOB->ODR |= 0x08) 
#define BOARD_CSN_0      (GPIOB->ODR &= ~0x08)
#define BOARD_CE_1       (GPIOB->ODR |= 0x10)
#define BOARD_CE_0       (GPIOB->ODR &= ~0x10)

/*-7 SEGMENT DISPLAY-*/
#define DISP_SDI_1   (GPIOD->ODR |= GPIO_PIN_2)
#define DISP_SDI_0   (GPIOD->ODR &= ~GPIO_PIN_2)
#define DISP_nOE_1   (GPIOD->ODR |= GPIO_PIN_3)
#define DISP_nOE_0   (GPIOD->ODR &= ~GPIO_PIN_3)
#define DISP_LE_1    (GPIOD->ODR |= GPIO_PIN_4)
#define DISP_LE_0   (GPIOD->ODR &= ~GPIO_PIN_4)
#define DISP_CLK_1   (GPIOD->ODR |= GPIO_PIN_7)
#define DISP_CLK_0   (GPIOD->ODR &= ~GPIO_PIN_7)

#endif