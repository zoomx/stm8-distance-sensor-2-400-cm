#ifndef _BOARD_H_
#define _BOARD_H_

#include "stm8s_conf.h"

/* 1Wire Bus 
PB6: Port B6
*/
#define ONEWIREBUS_PORT   GPIOB
#define ONEWIREBUS_PIN    GPIO_PIN_6

#define ONEWIREBUS_READ          (ONEWIREBUS_PORT->IDR & ONEWIREBUS_PIN)
#define ONEWIREBUS_INPUT_MODE    (ONEWIREBUS_PORT->DDR &= (uint8_t)(~(ONEWIREBUS_PIN)))
#define ONEWIREBUS_OUTPUT_MODE   (ONEWIREBUS_PORT->DDR |= (uint8_t)ONEWIREBUS_PIN)
#define ONEWIREBUS_CLEAR_OUTPUT  (ONEWIREBUS_PORT->ODR &= ~ONEWIREBUS_PIN)
#define ONEWIREBUS_SET_OUTPUT    (ONEWIREBUS_PORT->ODR |= ONEWIREBUS_PIN)
#define ONEWIREBUS_INPUT_CKECK   (ONEWIREBUS_PORT->IDR & ONEWIREBUS_PIN)

/* Board LED
PD0: Port D0 / Timer 1 - break input / Configurable clock output [AFR5]
*/
#define LED_PORT  GPIOD 
#define LED_PIN   GPIO_PIN_0

#define LED_ON    (LED_PORT->ODR |= LED_PIN)
#define LED_OFF   (LED_PORT->ODR &= ~LED_PIN)
#define LED_STATE (LED_PORT->IDR & LED_PIN)

/* Hardware test pin 
PF4: Port F4
*/
#define DEBUG_PIN_PORT  GPIOF
#define DEBUG_PIN_PIN   GPIO_PIN_4

#define DEBUG_PIN_ON    (DEBUG_PIN_PORT->ODR |= DEBUG_PIN_PIN)
#define DEBUG_PIN_OFF   (DEBUG_PIN_PORT->ODR &= ~DEBUG_PIN_PIN)
#define DEBUG_PIN_STATE (DEBUG_PIN_PORT->IDR & DEBUG_PIN_PIN)

/* Sonar trigger pin 
PB7: Port B7
Sonar capture pins:
PC2: Port C2 / Timer 1 - channel 2
PC3: Port C3 / Timer 1 - channel 3
*/
#define SONAR_TRIG_PORT  GPIOB
#define SONAR_TRIG_PIN   GPIO_PIN_7
#define SONAR_TMR_TRIG_PORT GPIOC
#define SONAR_TMR_TRIG_PIN  GPIO_PIN_2
#define SONAR_TMR_CAP_PORT  GPIOC
#define SONAR_TMR_CAP_PIN   GPIO_PIN_3
#define SONAR_TRIG_ON    (SONAR_PORT->ODR |= SONAR_TRIG_PIN)
#define SONAR_TRIG_OFF   (SONAR_PORT->ODR &= ~SONAR_TRIG_PIN)
#define SONAR_TRIG_STATE (SONAR_PORT->IDR & SONAR_TRIG_PIN)

/* Software SPI CONFIG
PB0 - SCK  - OUT
PB1 - MOSI - OUT
PB2 - MISO - IN
PB3 - CSN  - OUT
PB4 - CE   - OUT
-----------------*/
/*#define BOARD_SCK_1      (GPIOB->ODR |= GPIO_PIN_0) 
#define BOARD_SCK_0      (GPIOB->ODR &= ~GPIO_PIN_0)
#define BOARD_MOSI_1     (GPIOB->ODR |= GPIO_PIN_1)
#define BOARD_MOSI_0     (GPIOB->ODR &= ~GPIO_PIN_1)
#define BOARD_MISO       (GPIOB->IDR & GPIO_PIN_2)                               
#define BOARD_CSN_1      (GPIOB->ODR |= GPIO_PIN_3) 
#define BOARD_CSN_0      (GPIOB->ODR &= ~GPIO_PIN_3)
#define BOARD_CE_1       (GPIOB->ODR |= GPIO_PIN_4)
#define BOARD_CE_0       (GPIOB->ODR &= ~GPIO_PIN_4)*/

/* Hardware I2C CONFIG
PB5: Port B5 / I2C data
PB4: Port B4 / I2C clock
*/

/* Harware SPI CONFIG
PE5: Port E5 / SPI master/slave select (SPI NSS)
PC5: Port C5 / SPI clock
PC6: Port C6 / SPI MOSI
PC7: Port C7 / SPI MISO
*/

/*-7 SEGMENT DISPLAY-
PD2: Port D2 / Timer 2 - channel 3[AFR1]
PD3: Port D3 / Timer 2 - channel 2/ADC external trigger
PD4: Port D4 / Timer 2 - channel 1/BEEP output
PD7: Port D7 / Top level interrupt / Timer 1 -channel 4 [AFR6]
*/
#define DISP_PORT     GPIOD
#define DISP_SDI_PIN  GPIO_PIN_2
#define DISP_nOE_PIN  GPIO_PIN_3
#define DISP_LE_PIN   GPIO_PIN_4
#define DISP_CLK_PIN  GPIO_PIN_7

#define DISP_SDI_1   (DISP_PORT->ODR |= DISP_SDI_PIN)
#define DISP_SDI_0   (DISP_PORT->ODR &= ~DISP_SDI_PIN)
#define DISP_nOE_1   (DISP_PORT->ODR |= DISP_nOE_PIN)
#define DISP_nOE_0   (DISP_PORT->ODR &= ~DISP_nOE_PIN)
#define DISP_LE_1    (DISP_PORT->ODR |= DISP_LE_PIN)
#define DISP_LE_0   (DISP_PORT->ODR &= ~DISP_LE_PIN)
#define DISP_CLK_1   (DISP_PORT->ODR |= DISP_CLK_PIN)
#define DISP_CLK_0   (DISP_PORT->ODR &= ~DISP_CLK_PIN)

#endif