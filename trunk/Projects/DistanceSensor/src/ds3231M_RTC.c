#include "board.h"

#define DS3231M_ADR 0xD0

u8 DS3231M_ReadByte()
{
  u8 tmp;
  I2C_GenerateSTART(ENABLE);
  I2C_Send7bitAddress(DS3231M_ADR, I2C_DIRECTION_RX);
  tmp = I2C_ReceiveData();
  I2C_GenerateSTOP(ENABLE);
  return tmp;
}

u8 DS3231M_ReadByteAdr(u8 _adr)
{
  u8 tmp;
  I2C_GenerateSTART(ENABLE);
  I2C_Send7bitAddress(DS3231M_ADR, I2C_DIRECTION_TX);
  I2C_SendData(_adr);
  I2C_GenerateSTART(ENABLE);
  I2C_Send7bitAddress(DS3231M_ADR, I2C_DIRECTION_RX);
  tmp = I2C_ReceiveData();
  I2C_GenerateSTOP(ENABLE);
  return tmp;
}

void DS3231M_WriteBye(u8 _adr, u8 _data)
{
  I2C_GenerateSTART(ENABLE);
  I2C_Send7bitAddress(DS3231M_ADR, I2C_DIRECTION_TX);
  I2C_SendData(_adr);
  I2C_SendData(_data);
  I2C_GenerateSTOP(ENABLE);
}