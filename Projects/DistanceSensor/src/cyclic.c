#include "board.h"
#include "cyclic_conf.h"

#define DELAY_CNT_50MS   (50/TMR_OVF)
#define DELAY_CNT_100MS  (100/TMR_OVF)
#define DELAY_CNT_1S     (1000/TMR_OVF)

#ifdef CYC_50MS 
u8 delay_cnt_50ms = 0;
volatile _Bool CYCLIC_50ms = FALSE;
#endif

#ifdef CYC_100MS
u8 delay_cnt_100ms = 0;
volatile _Bool CYCLIC_100ms = FALSE;
#endif

#ifdef CYC_1S
u16 delay_cnt_1s = 0;
volatile _Bool CYCLIC_1s = FALSE;
#endif


void Cyclic_tick(void)
{
  /* 50mS flag */
  #ifdef CYC_50MS 
  if(CYCLIC_50ms == FALSE) delay_cnt_50ms++;
  if(delay_cnt_50ms >= DELAY_CNT_50MS)
  {
    CYCLIC_50ms = TRUE;
    delay_cnt_50ms = 0; 
  }
  #endif

  /* 100mS flag */
  #ifdef CYC_100MS 
  if(CYCLIC_100ms == FALSE) delay_cnt_100ms++;
  if(delay_cnt_100ms >= DELAY_CNT_100MS)
  {
    CYCLIC_100ms = TRUE;
    delay_cnt_100ms = 0; 
  }
  #endif

  /* 1S flag */
  #ifdef CYC_1S 
  if(CYCLIC_1s == FALSE) delay_cnt_1s++;
  if(delay_cnt_1s >= DELAY_CNT_1S)
  {
    CYCLIC_1s = TRUE;
    delay_cnt_1s = 0; 
  }
  #endif
}