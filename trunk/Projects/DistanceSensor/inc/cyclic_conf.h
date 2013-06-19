#ifndef _CYCLIC_CONF_H_
#define _CYCLIC_CONF_H_

#include "stm8s.h"

#define TMR_OVF  (u8)2   /* Timer overflow period, integer [ms] (Platform dependent) */

/*
Enable what cyclic flags you need
*/

//#define CYC_50MS
#define CYC_100MS
#define CYC_1S

#endif