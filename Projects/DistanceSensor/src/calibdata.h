#ifndef _CALIBDATA_H
#define _CALIBDATA_H

#include "board.h"

/*
DS18B20 temperature sensor address - 8 u8
Display brightness                 - u16       
Logging enabled                    - u8           
Logging interval                   - u16 (1000 -> 2000mS)
*/

void CalibData_Update(u16, u8*, u8);

#endif /* _CALIBDATA_H */