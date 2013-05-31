#include "board.h"
#include "delay.h"

#define DS3231M_ADR 0xD0

void DS3231M_Flush()
{
  u8 i;
  for(i = 0; i < 16; i++)
  {
    I2C_PORT->ODR |= I2C_SCL_PIN;
    DELAY_US(DELAY_6US);
    I2C_PORT->ODR &= ~(I2C_SCL_PIN);
    DELAY_US(DELAY_6US);
  }
}

u8 DS3231M_ReadByte()
{
  u8 tmp;
  while(I2C->SR3 & I2C_SR3_BUSY)
  {
		I2C->CR2 |= I2C_CR2_STOP;                   				// Generate stop here (STOP=1)
    while(I2C->CR2 & I2C_CR2_STOP); 				// Wait until stop is performed
	}
  I2C->CR2 |= I2C_CR2_ACK; 
  //I2C_GenerateSTART(ENABLE);
  /*while (I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT) != SUCCESS);*/   /* wait for EV5 - start condition released */
  I2C->CR2 |= I2C_CR2_START;
  while((I2C->SR1 & I2C_SR1_SB)==0);
  I2C_Send7bitAddress(DS3231M_ADR, I2C_DIRECTION_RX);
  /*while (I2C_CheckEvent(I2C_EVENT_MASTER_RECEIVER_MODE_SELECTED) != SUCCESS);*/   /* wait for EV6 - slave acknowledge masters' address */
  while(!(I2C->SR1 & I2C_SR1_ADDR));
  DELAY_US(DELAY_6US);
  I2C->SR3;
  while (I2C_CheckEvent(I2C_EVENT_MASTER_BYTE_RECEIVED) != SUCCESS);            /* wait for EV7 - byte received from slave */
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