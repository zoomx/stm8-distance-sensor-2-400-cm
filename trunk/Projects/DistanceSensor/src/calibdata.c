#include "board.h"

void CalibData_Update(u16 address, u8* data, u8 size)
{
  /* Unlock FLASH */
  FLASH->PUKR = FLASH_RASS_KEY1;
  FLASH->PUKR = FLASH_RASS_KEY2;
  
  while(size > 0)
  {
    *(PointerAttr u8*) (u16)address = *data;
    data++;
    address++;
    size--;
  }
  
  /* Lock FLASH */
  FLASH->IAPSR &= (uint8_t)FLASH_MEMTYPE_PROG;
}