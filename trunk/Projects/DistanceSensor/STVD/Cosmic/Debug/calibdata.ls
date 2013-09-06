   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  81                     ; 9 void CalibData_Update(u16 address, u8* data, u8 size)
  81                     ; 10 {
  83                     .text:	section	.text,new
  84  0000               _CalibData_Update:
  86  0000 89            	pushw	x
  87       00000000      OFST:	set	0
  90                     ; 12   FLASH->PUKR = FLASH_RASS_KEY1;
  92  0001 35565062      	mov	20578,#86
  93                     ; 13   FLASH->PUKR = FLASH_RASS_KEY2;
  95  0005 35ae5062      	mov	20578,#174
  97  0009 201e          	jra	L34
  98  000b               L73:
  99                     ; 17     if(address >= CAL_Base_Address && address < CAL_MAX_Address)
 101  000b 1e01          	ldw	x,(OFST+1,sp)
 102  000d a30000        	cpw	x,#_CAL
 103  0010 251b          	jrult	L54
 105  0012 a3000c        	cpw	x,#_CAL+12
 106  0015 2416          	jruge	L54
 107                     ; 19       *(PointerAttr u8*) (u16)address = *data;
 109  0017 1e05          	ldw	x,(OFST+5,sp)
 110  0019 f6            	ld	a,(x)
 111  001a 1e01          	ldw	x,(OFST+1,sp)
 112  001c f7            	ld	(x),a
 113                     ; 20       data++;
 115  001d 1e05          	ldw	x,(OFST+5,sp)
 116  001f 5c            	incw	x
 117  0020 1f05          	ldw	(OFST+5,sp),x
 118                     ; 21       address++;
 120  0022 1e01          	ldw	x,(OFST+1,sp)
 121  0024 5c            	incw	x
 122  0025 1f01          	ldw	(OFST+1,sp),x
 123                     ; 22       size--;
 125  0027 0a07          	dec	(OFST+7,sp)
 127  0029               L34:
 128                     ; 15   while(size > 0)
 130  0029 7b07          	ld	a,(OFST+7,sp)
 131  002b 26de          	jrne	L73
 132  002d               L54:
 133                     ; 28   FLASH->IAPSR &= (uint8_t)FLASH_MEMTYPE_PROG;
 135  002d 7213505f      	bres	20575,#1
 136                     ; 29 }
 139  0031 85            	popw	x
 140  0032 81            	ret	
 153                     	xdef	_CalibData_Update
 154                     	xref	_CAL
 173                     	end
