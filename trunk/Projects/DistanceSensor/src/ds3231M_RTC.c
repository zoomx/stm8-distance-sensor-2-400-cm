#include "board.h"
#include "softi2c.h"
#include "delay.h"

#define DS3231M_ADR (u8)0xD0
#define nEOSC   (u8)0x80
#define BBSQW   (u8)0x40
#define CONV    (u8)0x20
#define INTCN   (u8)0x04
#define A2IE    (u8)0x02
#define A1IE    (u8)0x01

#define OSF     (u8)0x80
#define EN32KHZ (u8)0x08
#define BSY     (u8)0x04
#define A2F     (u8)0x02
#define A1F     (u8)0x01

u8 RTC_sec = 0;
u8 RTC_min = 0;
u8 RTC_hour = 0;
u8 RTC_day = 0;
u8 RTC_date = 0;
u8 RTC_month = 0;
u8 RTC_year = 0;
s16 RTC_temp = 0;

/* Toggle SCL line (cycles) number of times to flush out from the slave pending data for transmission */
void DS3231M_Flush(u8 cycles)
{
  I2C_Flush(cycles);
}

u8 DS3231M_GetTime(void)
{
  u8 tmp[3], status = 0;
  status = I2C_ReadBytes(tmp, 3, DS3231M_ADR, 0x00);
  if(status)
  {
    RTC_sec = tmp[0];
    RTC_min = tmp[1];
    RTC_hour = tmp[2];
  }
  return status;
}

u8 DS3231M_GetDate(void)
{
  u8 tmp[4], status = 0;
  status = I2C_ReadBytes(tmp, 4, DS3231M_ADR, 0x03);
  if(status)
  {
    RTC_day = tmp[0];
    RTC_date = tmp[1];
    RTC_month = tmp[2];
	  RTC_year = tmp[3];
  }
  return status; 
}

u8 DS3231M_GetTemperature(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 2, DS3231M_ADR, 0x11);
  if(status)
  {
	RTC_temp =  (s16) ((u16)((tmp[0]&0x7F)<<2) | ((tmp[1]>>6)&0x03));
	if(tmp[0] & 0x80) RTC_temp |= 0x8000;
  }
  return status;
}

u8 DS3231M_SetTime(void)
{
  u8 tmp[3], status = 0;
  tmp[0] = RTC_sec;
  tmp[1] = RTC_min;
  tmp[2] = RTC_hour;
  status = I2C_WriteBytes(tmp, 3, DS3231M_ADR, 0x00);
  return status;
}

u8 DS3231M_SetDate(void)
{
  u8 tmp[4], status = 0;
  tmp[0] = RTC_day;
  tmp[1] = RTC_date;
  tmp[2] = RTC_month;
  tmp[3] = RTC_year;
  status = I2C_WriteBytes(tmp, 4, DS3231M_ADR, 0x03);
  return status;
}

/* 0x0E register */
u8 DS3231M_EnableOsc(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
  if(tmp[0] & nEOSC)   //if nEOSC bit is set, reset it
  {
    tmp[0] &= ~nEOSC;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
  }
  return status;
}

u8 DS3231M_DisableOsc(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
  if(!(tmp[0] & nEOSC))  //if nEOSC bit is reset, set it
  {
    tmp[0] |= nEOSC;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
  }
  return status;
}

u8 DS3231M_EnableBBSQW(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
  if(!(tmp[0] & BBSQW))   //if BBSQW bit is reset, set it
  {
    tmp[0] |= BBSQW;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
  }
  return status;
}

u8 DS3231M_DisableBBSQW(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
  if(tmp[0] & BBSQW)  //if BBSQW bit is set, reset it
  {
    tmp[0] &= ~BBSQW;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
  }
  return status;
}

u8 DS3231M_ConvertTemp(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
  if(!(tmp[0] & CONV))   //if CONV bit is reset, set it
  {
    tmp[0] |= CONV;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
  }
  return status;
}

u8 DS3231M_SetINTCN(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
  if(!(tmp[0] & INTCN))   //if INTCN bit is reset, set it
  {
    tmp[0] |= INTCN;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
  }
  return status;
}

u8 DS3231M_ResetINTCN(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
  if(tmp[0] & INTCN)  //if INTCN bit is set, reset it
  {
    tmp[0] &= ~INTCN;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
  }
  return status;
}

u8 DS3231M_EnableAlarm1Intr(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
  if(!(tmp[0] & A1IE))   //if A1IE bit is reset, set it
  {
    tmp[0] |= A1IE;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
  }
  return status;
}

u8 DS3231M_DisableAlarm1Intr(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
  if(tmp[0] & A1IE)  //if A1IE bit is set, reset it
  {
    tmp[0] &= ~A1IE;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
  }
  return status;
}

u8 DS3231M_EnableAlarm2Intr(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
  if(!(tmp[0] & A2IE))   //if A2IE bit is reset, set it
  {
    tmp[0] |= A2IE;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
  }
  return status;
}

u8 DS3231M_DisableAlarm2Intr(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
  if(tmp[0] & A2IE)  //if A2IE bit is set, reset it
  {
    tmp[0] &= ~A2IE;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
  }
  return status;
}

/* 0x0F register */
u8 DS3231M_GetOscStopFlag(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0F);
  if(!status) return 2;
  if(tmp[0] & OSF) return 1;
  else return 0;
}

u8 DS3231M_ResetOscStopFlag(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0F);
  if(tmp[0] & A2IE)  //if A2IE bit is set, reset it
  {
    tmp[0] &= ~A2IE;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0F);
  }
  return status;
}

u8 DS3231M_Enable32KHzOut(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0F);
  if(!(tmp[0] & EN32KHZ))   //if EN32KHZ bit is reset, set it
  {
    tmp[0] |= EN32KHZ;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0F);
  }
  return status;
}

u8 DS3231M_Disable32KHzOut(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0F);
  if(tmp[0] & EN32KHZ)  //if EN32KHZ bit is set, reset it
  {
    tmp[0] &= ~EN32KHZ;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0F);
  }
  return status;
}

u8 DS3231M_ResetAlarm1(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0F);
  if(tmp[0] & A1F)  //if A1F bit is set, reset it
  {
    tmp[0] &= ~A1F;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0F);
  }
  return status;
}

u8 DS3231M_ResetAlarm2(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0F);
  if(tmp[0] & A2F)  //if A2F bit is set, reset it
  {
    tmp[0] &= ~A2F;
    status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0F);
  }
  return status;
}

u8 DS3231M_GetBusyFlag(void)
{
  u8 tmp[2], status = 0;
  status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0F);
  if(!status) return 2;
  if(tmp[0] & BSY) return 1;
  else return 0;
}

/* Read a byte from slave from current memory location */
/*u8 DS3231M_ReadByte()
{
  u8 tmp_data, slave_ack;
  I2C_StartCond();
  slave_ack = I2C_WriteByte(DS3231M_ADR_RD);
  if(slave_ack == ACK)
  {
    tmp_data = I2C_ReadByte(NACK);
  }
  I2C_Stop();
  return tmp_data;
}*/

/* Read a byte from slave from address-adr */
/*u8 DS3231M_ReadByteAdr(u8 adr)
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
}*/

/* Read multiple bytes from slave from address-adr into data vector */
/*void DS3231_ReadBytes(u8 adr, u8* data, u8 size)
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
}*/

/* Write a byte of data to slave at address-adr */
/*u8 DS3231M_WriteByte(u8 adr, u8 data)
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
}*/

/* write multiple bytes to slave at address-adr */
/*u8 DS3231M_WriteBytes(u8 adr, u8* data, u8 size)
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
}*/

/*void DS3231M_ReadTimeDate(u8* data)
{
  u8 tmp_data, slave_ack;
  I2C_Start();
  slave_ack = I2C_WriteByte(DS3231M_ADR_WR);
  if(slave_ack == ACK)
  {
    slave_ack = I2C_WriteByte(0x00);  // Read from register with address 0x00
	  if(slave_ack == ACK)
	  {
	    I2C_Start();
	    slave_ack = I2C_WriteByte(DS3231M_ADR_RD);
	    if(slave_ack == ACK)
	    {
	      tmp_data = I2C_ReadByte(ACK);  // Read seconds
		
	    }
	  }
  }
  I2C_Stop();
}*/
