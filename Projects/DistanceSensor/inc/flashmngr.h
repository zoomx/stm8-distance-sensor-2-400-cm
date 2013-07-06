#ifndef _FLASHMNGR_H_
#define _FLASHMNGR_H_

_Bool FlashMngr_Init(void);
_Bool FlashMngr_StoreData(u8*, u16);
void FlashMngr_ReadData(void);
_Bool FlashMngr_Erase_Chip(void);
u32 FlashMngr_Get_Free_Space(void);

#endif