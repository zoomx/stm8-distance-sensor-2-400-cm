#include "board.h"

extern const CAL;

#define SIZEOFCAL (u8)13
#define CAL_Base_Address (u16)(&CAL)
#define CAL_MAX_Address  (u16)(CAL_Base_Address + SIZEOFCAL)

void CalibData_Update(u16 address, u8* data, u8 size)
{
  /* Unlock FLASH */
  FLASH->PUKR = FLASH_RASS_KEY1;
  FLASH->PUKR = FLASH_RASS_KEY2;
  
  while(size > 0)
  {
    if(address >= CAL_Base_Address && address < CAL_MAX_Address)
    {
      *(PointerAttr u8*) (u16)address = *data;
      data++;
      address++;
      size--;
    }
    else break;
  }
  
  /* Lock FLASH */
  FLASH->IAPSR &= (uint8_t)FLASH_MEMTYPE_PROG;
}