#include "board.h"
#include "softi2c.h"
#include "delay.h"

#define DS3231M_ADR_WR (u8)0xD0
#define DS3231M_ADR_RD (u8)0xD1

/* Toggle SCL line (cycles) number of times to flush out from the slave pending data for transmission */
void DS3231M_Flush(u8 cycles)
{
  I2C_Flush(cycles);
}

/* Read a byte from slave from current memory location */
u8 DS3231M_ReadByte()
{
  u8 tmp_data, slave_ack;
  I2C_Start();
  slave_ack = I2C_WriteByte(DS3231M_ADR_RD);
  if(slave_ack == ACK)
  {
    tmp_data = I2C_ReadByte(NACK);
  }
  I2C_Stop();
  return tmp_data;
}

/* Read a byte from slave from address-adr */
u8 DS3231M_ReadByteAdr(u8 adr)
{
  u8 tmp_data, slave_ack;
  I2C_Start();
  slave_ack = I2C_WriteByte(DS3231M_ADR_WR);
  if(slave_ack == ACK)
  {
    slave_ack = I2C_WriteByte(adr);
	  if(slave_ack == ACK)
	  {
	    I2C_Start();
	    slave_ack = I2C_WriteByte(DS3231M_ADR_RD);
	    if(slave_ack == ACK)
	    {
	      tmp_data = I2C_ReadByte(NACK);
	    }
	  }
  }
  I2C_Stop();
  return tmp_data;
}

/* Read multiple bytes from slave from address-adr into data vector */
void DS3231_ReadBytes(u8 adr, u8* data, u8 size)
{
  u8 slave_ack, i;
  I2C_Start();
  slave_ack = I2C_WriteByte(DS3231M_ADR_WR);
  if(slave_ack == ACK)
  {
    slave_ack = I2C_WriteByte(adr);
	if(slave_ack == ACK)
	{
	  I2C_Start();
	  slave_ack = I2C_WriteByte(DS3231M_ADR_RD);
	  if(slave_ack == ACK)
	  {
	    for(i = 0; i < size - 1; i++)
		{
		  data[i] = I2C_ReadByte(ACK);
		}
		data[size-1] = I2C_ReadByte(NACK);
	  }
	}
  }
  I2C_Stop();
}

/* Write a byte of data to slave at address-adr */
u8 DS3231M_WriteByte(u8 adr, u8 data)
{
  u8 slave_ack;
  I2C_Start();
  slave_ack = I2C_WriteByte(DS3231M_ADR_WR);
  if(!slave_ack) 
  {
    slave_ack = I2C_WriteByte(adr);
	if(!slave_ack)
	{
	  slave_ack = I2C_WriteByte(data);
	}
  }
  I2C_Stop();
  return slave_ack;
}

/* write multiple bytes to slave at address-adr */
u8 DS3231M_WriteBytes(u8 adr, u8* data, u8 size)
{
  u8 slave_ack, i;
  I2C_Start();
  slave_ack = I2C_WriteByte(DS3231M_ADR_WR);
  if(slave_ack == ACK) 
  {
    for(i = 0; i < size; i++)
	{
	  slave_ack = I2C_WriteByte(data[i]);
	  if(slave_ack == NACK) break;
	}
  }
  I2C_Stop();
  return slave_ack;
}

void DS3231M_ReadTimeDate(u8* data)
{
  u8 tmp_data, slave_ack;
  I2C_Start();
  slave_ack = I2C_WriteByte(DS3231M_ADR_WR);
  if(slave_ack == ACK)
  {
    slave_ack = I2C_WriteByte(0x00);  /* Read from register with address 0x00 */
	if(slave_ack == ACK)
	{
	  I2C_Start();
	  slave_ack = I2C_WriteByte(DS3231M_ADR_RD);
	  if(slave_ack == ACK)
	  {
	    tmp_data = I2C_ReadByte(ACK);  /* Read seconds */
		
	  }
	}
  }
  I2C_Stop();
}