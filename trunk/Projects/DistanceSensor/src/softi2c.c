#include "board.h"
#include "delay.h"

#define SDA_HIGH  (SOFTI2C_PORT->ODR |= SOFTI2C_SDA_PIN)
#define SDA_LOW   (SOFTI2C_PORT->ODR &= ~SOFTI2C_SDA_PIN)
#define SCL_HIGH  (SOFTI2C_PORT->ODR |= SOFTI2C_SCL_PIN)
#define SCL_LOW   (SOFTI2C_PORT->ODR &= ~SOFTI2C_SCL_PIN)
#define SDA_READ  (SOFTI2C_PORT->IDR & SOFTI2C_SDA_PIN)
#define SCL_READ  (SOFTI2C_PORT->IDR & SOFTI2C_SCL_PIN)

/*
  A HIGH to LOW transition on the SDA line while SCL is
  HIGH is one such unique case. This situation indicates a
  START condition.
  */
#define I2C_START() (SCL_HIGH; DELAY_US(DELAY_6US); SDA_LOW; DELAY_US(DELAY_6US))
/*
  A LOW to HIGH transition on the SDA line while SCL is
  HIGH defines a STOP condition.
  */
#define I2C_STOP()  (SDA_LOW; DELAY_US(DELAY_6US); SCL_HIGH; DELAY_USDELAY_6US); SDA_HIGH; DELAY_US(DELAY_6US))

/*
The data on the SDA line must be stable during the HIGH
period of the clock. The HIGH or LOW state of the data line
can only change when the clock signal on the SCL line is
LOW
*/

void I2C_Start()
{
  /*
  A HIGH to LOW transition on the SDA line while SCL is
  HIGH is one such unique case. This situation indicates a
  START condition.
  */
  DELAY_US(DELAY_6US);
  SCL_HIGH;
  DELAY_US(DELAY_6US); 
  SDA_LOW;
  DELAY_US(DELAY_6US); 
}

void I2C_Stop()
{
  /*
  A LOW to HIGH transition on the SDA line while SCL is
  HIGH defines a STOP condition.
  */
  DELAY_US(DELAY_6US);
  SDA_LOW;
  DELAY_US(DELAY_6US);  /*2uS*/
  SCL_HIGH;
  DELAY_US(DELAY_6US);  /*2uS*/
  SDA_HIGH;
  DELAY_US(DELAY_6US);  /*2uS*/
}

void I2C_Flush(u8 cycles)
{
  u8 i;
  for(i = 0; i < cycles; i++)
  {
    SCL_LOW;
	  DELAY_US(DELAY_6US);  /*2uS*/
	  SCL_HIGH;
	  DELAY_US(DELAY_6US);  /*2uS*/
  }
}

u8 I2C_WriteByte(u8 data)
{
  u8 i, tmp;
  SCL_LOW;
  DELAY_US(DELAY_6US);
  for(i = 0; i < 8; i++)  /* send 8 bits of data */
  {
    if(data & 0x80)
	  {
      SDA_HIGH;	
	  }
	  else
	  {
	    SDA_LOW;
	  }
	  DELAY_US(DELAY_6US);
	  SCL_HIGH;
	  DELAY_US(DELAY_6US);
	  SCL_LOW;
	  DELAY_US(DELAY_6US);
    data <<= 1;
  }
  SDA_HIGH;
  DELAY_US(DELAY_6US);
  SCL_HIGH;
  DELAY_US(DELAY_6US);
  tmp = SDA_READ;  /* read slave acknowledge: 0-slave ACK, 1-slave NACK */
  SCL_LOW;
  DELAY_US(DELAY_6US);
  return tmp;  /* 0-slave ACK, 1-slave NACK */
}

u8 I2C_ReadByte(u8 ack)
{
  u8 data = 0x00;
  u8 i;
  for(i = 0; i < 8; i++)
  {
    SCL_LOW;
	  DELAY_US(DELAY_6US);
	  SCL_HIGH;
	  DELAY_US(DELAY_6US);
	  if(SDA_READ) data |= (0x80 >> i);
  }
  SCL_LOW;
  DELAY_US(DELAY_6US);
  if(ack) 
  {
   SDA_LOW;
  }
  else 
  {
    SDA_HIGH;
  }
  DELAY_US(DELAY_6US);
  SCL_HIGH;
  DELAY_US(DELAY_6US);
  //SCL_LOW;
  //DELAY_US(DELAY_6US);
  return data;
}