#ifndef _CYCLIC_H_
#define _CYCLIC_H_

#include "stm8s.h"
#include "cyclic_conf.h"

void Cyclic_tick(void);

#ifdef CYC_50MS
extern volatile _Bool CYCLIC_50ms;
#endif
#ifdef CYC_100MS
extern volatile _Bool CYCLIC_100ms;
#endif
#ifdef CYC_1S
extern volatile _Bool CYCLIC_1s;
#endif

#endif