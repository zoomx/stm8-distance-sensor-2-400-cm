#ifndef _DELAY_H_
#define _DELAY_H_

#define DELAY_480US 2560
#define DELAY_70US  373
#define DELAY_410US 2187
#define DELAY_6US   32
#define DELAY_64US  341
#define DELAY_60US  320
#define DELAY_10US  53
#define DELAY_15US  80
#define DELAY_9US   48
#define DELAY_55US  293

#define I2C_DELAY      6    /* 1uS - 5.33 */
#define SCL_SDA_DELAY  8  

#define SPI_CS_LOW_DELAY  12   /* 2uS */

void delay_ms(u16);


#define DELAY_US( loops ) _asm("$N: \n decw X \n jrne $L \n nop", (u16)loops);

#endif