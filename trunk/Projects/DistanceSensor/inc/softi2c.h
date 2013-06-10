#ifndef _SOFTI2C_H
#define _SOFTI2C_H

#define ACK   (u8)0
#define NACK  (u8)1

u8 I2C_StartCond(void);
//void I2C_Stop(void);
void I2C_Flush(u8);
u8 I2C_WriteBytes(u8*, u8, u8);
u8 I2C_ReadBytes(u8*, u8, u8);

#endif