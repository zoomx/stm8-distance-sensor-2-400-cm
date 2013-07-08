#ifndef _FLASHMNGR_H_
#define _FLASHMNGR_H_

/*
TODO: check the order of bits if correct
*/
#define PTR_ARR_FULL       (u8)0x01
#define FLASHPTR_WAS_READ  (u8)0x02
#define FLASH_FULL         (u8)0x04
#define FLASH_WAS_READ     (u8)0x08
#define FLASH_NO_SPACE     (u8)0x10
#define OPERATION_REFUSED  (u8)0x20

/*
TODO: check the order of bits if correct
*/
#define INCONSISTENT_ERR      (u8)0x01
#define UNKNOWN_ERR           (u8)0x02
#define INVALID_FLASHPTR_ERR  (u8)0x04
#define PTR_SEC_ERASE_ERR     (u8)0x08
#define FLASH_ERASE_ERR       (u8)0x10
#define DATA_STORE_ERR        (u8)0x20
#define MEMORY_LOCKED_ERR     (u8)0x40

_Bool FlashMngr_Init(void);
_Bool FlashMngr_GetPointer(void);
_Bool FlashMngr_StoreData(u8*, u16);
void FlashMngr_ReadData(void);
_Bool FlashMngr_Erase_Chip(void);
u32 FlashMngr_Get_Free_Space(void);
u8 FlashMngr_GetStatus(void);
u8 FlashMngr_GetErrors(void);

#endif