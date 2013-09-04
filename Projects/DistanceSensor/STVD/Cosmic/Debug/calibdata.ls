   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  78                     ; 3 void CalibData_Update(u16 address, u8* data, u8 size)
  78                     ; 4 {
  80                     .text:	section	.text,new
  81  0000               _CalibData_Update:
  83  0000 89            	pushw	x
  84       00000000      OFST:	set	0
  87                     ; 6   FLASH->PUKR = FLASH_RASS_KEY1;
  89  0001 35565062      	mov	20578,#86
  90                     ; 7   FLASH->PUKR = FLASH_RASS_KEY2;
  92  0005 35ae5062      	mov	20578,#174
  94  0009 2012          	jra	L34
  95  000b               L73:
  96                     ; 11     *(PointerAttr u8*) (u16)address = *data;
  98  000b 1e05          	ldw	x,(OFST+5,sp)
  99  000d f6            	ld	a,(x)
 100  000e 1e01          	ldw	x,(OFST+1,sp)
 101  0010 f7            	ld	(x),a
 102                     ; 12     data++;
 104  0011 1e05          	ldw	x,(OFST+5,sp)
 105  0013 5c            	incw	x
 106  0014 1f05          	ldw	(OFST+5,sp),x
 107                     ; 13     address++;
 109  0016 1e01          	ldw	x,(OFST+1,sp)
 110  0018 5c            	incw	x
 111  0019 1f01          	ldw	(OFST+1,sp),x
 112                     ; 14     size--;
 114  001b 0a07          	dec	(OFST+7,sp)
 115  001d               L34:
 116                     ; 9   while(size > 0)
 118  001d 7b07          	ld	a,(OFST+7,sp)
 119  001f 26ea          	jrne	L73
 120                     ; 18   FLASH->IAPSR &= (uint8_t)FLASH_MEMTYPE_PROG;
 122  0021 7213505f      	bres	20575,#1
 123                     ; 19 }
 126  0025 85            	popw	x
 127  0026 81            	ret	
 140                     	xdef	_CalibData_Update
 159                     	end
