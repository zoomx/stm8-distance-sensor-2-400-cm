#ifndef _DS18B20_H_
#define _DS18B20_H_

#include "stm8s.h"

#define OW_IN()     ONEWIREBUS_INPUT_MODE              /* input mode */
#define OW_OUT()    ONEWIREBUS_OUTPUT_MODE             /* output mode */
#define OW_LOW()    ONEWIREBUS_CLEAR_OUTPUT            /* drive 1-wire bus low */
#define OW_HIGH()   ONEWIREBUS_SET_OUTPUT              /* release 1-wire bus */
#define OW_READ()   ONEWIREBUS_INPUT_CKECK             /* read 1-wire bus */

u8 OW_reset(void);
void OW_write(u8);
u8 OW_read(void);
void DS18B20_init(void);
void DS18B20_convert(void);
s16 DS18B20_read_16(void);
u8 DS18B20_read_8(void);

#endif
