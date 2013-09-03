#include "stm8s_flash.h"


void CalibData_Update(u16 address, u8* data, u8 size)
{
  FLASH_Unlock(FLASH_MEMTYPE_PROG);
  
  while(size > 0)
  {
    FLASH_ProgramByte(address, *data);
    data++;
    address++;
    size--;
  }
  
  FLASH_Lock(FLASH_MEMTYPE_PROG);
}