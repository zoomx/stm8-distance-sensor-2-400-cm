/*#define WAIT_50MS { \
  while(DELAY_50MS_FLAG == FALSE);  \
  DELAY_50MS_FLAG = FALSE;          \
}*/

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

void delay_ms(u16);

//void delay_10us(u8);

#define DELAY_US( loops ) \
        _asm("$N: \n decw X \n jrne $L \n nop", (u16)loops);

