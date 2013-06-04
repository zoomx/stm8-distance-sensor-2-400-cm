#ifndef _SOFTI2C_H
#define _SOFTI2C_H

#define ACK   (u8)1
#define NACK  (u8)0

void I2C_Start(void);
void I2C_Stop(void);
u8 I2C_WriteByte(u8);

#endif