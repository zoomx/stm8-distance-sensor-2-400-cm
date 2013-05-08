   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
  57                     ; 28 u8 OW_reset(void)
  57                     ; 29 {
  59                     .text:	section	.text,new
  60  0000               _OW_reset:
  62  0000 88            	push	a
  63       00000001      OFST:	set	1
  66                     ; 32   OW_LOW();                /* master - drive bus low */
  68  0001 721d5005      	bres	20485,#6
  69                     ; 33   DELAY_US(DELAY_480US);   /* master - wait for 480us (H-480,480,640) */
  71  0005 ae0a00        	ldw	x,#2560
  73  0008               L6: 
  74  0008 5a             decw X 
  75  0009 26fd           jrne L6 
  76  000b 9d             nop
  78                     ; 34   OW_HIGH();
  81  000c 721c5005      	bset	20485,#6
  82                     ; 36   DELAY_US(DELAY_70US);    /* master - wait for 70us (I-63,70,78) */
  84  0010 ae0175        	ldw	x,#373
  86  0013               L01: 
  87  0013 5a             decw X 
  88  0014 26fd           jrne L01 
  89  0016 9d             nop
  91                     ; 37   result = OW_READ();
  94  0017 c65006        	ld	a,20486
  95  001a a440          	and	a,#64
  96  001c 6b01          	ld	(OFST+0,sp),a
  97                     ; 38   DELAY_US(DELAY_410US);   /* master - wait for 410us (J-410,410,N/A) */
  99  001e ae088b        	ldw	x,#2187
 101  0021               L21: 
 102  0021 5a             decw X 
 103  0022 26fd           jrne L21 
 104  0024 9d             nop
 106                     ; 39   OW_HIGH();               /* master - release bus */
 109  0025 721c5005      	bset	20485,#6
 110                     ; 41   return result;
 112  0029 7b01          	ld	a,(OFST+0,sp)
 115  002b 5b01          	addw	sp,#1
 116  002d 81            	ret
 159                     ; 44 void OW_write_8(u8 data)
 159                     ; 45 {
 160                     .text:	section	.text,new
 161  0000               _OW_write_8:
 163  0000 88            	push	a
 164  0001 88            	push	a
 165       00000001      OFST:	set	1
 168                     ; 47   for(i=0; i<8; i++)
 170  0002 0f01          	clr	(OFST+0,sp)
 171  0004               L15:
 172                     ; 49     if(data & 0x01)
 174  0004 7b02          	ld	a,(OFST+1,sp)
 175  0006 a501          	bcp	a,#1
 176  0008 2718          	jreq	L75
 177                     ; 51 	  OW_LOW();               /* master - drive bus low */
 179  000a 721d5005      	bres	20485,#6
 180                     ; 52 	  DELAY_US(DELAY_6US);    /* master - wait 6us (A-5,6,15) */
 182  000e ae0020        	ldw	x,#32
 184  0011               L61: 
 185  0011 5a             decw X 
 186  0012 26fd           jrne L61 
 187  0014 9d             nop
 189                     ; 53 	  OW_HIGH();              /* master - release bus */
 192  0015 721c5005      	bset	20485,#6
 193                     ; 54 	  DELAY_US(DELAY_64US);   /* master - wait 64us (B-59,64,N/A) */
 195  0019 ae0155        	ldw	x,#341
 197  001c               L02: 
 198  001c 5a             decw X 
 199  001d 26fd           jrne L02 
 200  001f 9d             nop
 204  0020 2016          	jra	L16
 205  0022               L75:
 206                     ; 58 	  OW_LOW();                /* master - drive bus low */
 208  0022 721d5005      	bres	20485,#6
 209                     ; 59 	  DELAY_US(DELAY_60US);    /* master - wait 60us (C-60,60,120) */
 211  0026 ae0140        	ldw	x,#320
 213  0029               L22: 
 214  0029 5a             decw X 
 215  002a 26fd           jrne L22 
 216  002c 9d             nop
 218                     ; 60 	  OW_HIGH();               /* master - release bus */
 221  002d 721c5005      	bset	20485,#6
 222                     ; 61 	  DELAY_US(DELAY_10US);    /* master - wait 10us (D-8,10,N/A) */
 224  0031 ae0035        	ldw	x,#53
 226  0034               L42: 
 227  0034 5a             decw X 
 228  0035 26fd           jrne L42 
 229  0037 9d             nop
 231  0038               L16:
 232                     ; 63     data >>= 1;
 234  0038 0402          	srl	(OFST+1,sp)
 235                     ; 47   for(i=0; i<8; i++)
 237  003a 0c01          	inc	(OFST+0,sp)
 240  003c 7b01          	ld	a,(OFST+0,sp)
 241  003e a108          	cp	a,#8
 242  0040 25c2          	jrult	L15
 243                     ; 65 }
 246  0042 85            	popw	x
 247  0043 81            	ret
 291                     ; 66 u8 OW_read_8(void)
 291                     ; 67 {
 292                     .text:	section	.text,new
 293  0000               _OW_read_8:
 295  0000 89            	pushw	x
 296       00000002      OFST:	set	2
 299                     ; 69   u8 result = 0;
 301  0001 0f02          	clr	(OFST+0,sp)
 302                     ; 71   for(i=0; i<8; i++)
 304  0003 0f01          	clr	(OFST-1,sp)
 305  0005               L501:
 306                     ; 73     result >>= 1;
 308  0005 0402          	srl	(OFST+0,sp)
 309                     ; 74 	  OW_LOW();                 /* master - drive bus low */
 311  0007 721d5005      	bres	20485,#6
 312                     ; 75 	  DELAY_US(DELAY_6US);      /* master - wait 6us (A-5,6,15) */
 314  000b ae0020        	ldw	x,#32
 316  000e               L03: 
 317  000e 5a             decw X 
 318  000f 26fd           jrne L03 
 319  0011 9d             nop
 321                     ; 76 	  OW_HIGH();                /* master - release bus */
 324  0012 721c5005      	bset	20485,#6
 325                     ; 77 	  DELAY_US(DELAY_9US);       /* master - wait 9us (E-5,9,12) */
 327  0016 ae0030        	ldw	x,#48
 329  0019               L23: 
 330  0019 5a             decw X 
 331  001a 26fd           jrne L23 
 332  001c 9d             nop
 334                     ; 78     if(OW_READ())  result |= 0x80;
 337  001d c65006        	ld	a,20486
 338  0020 a540          	bcp	a,#64
 339  0022 2706          	jreq	L311
 342  0024 7b02          	ld	a,(OFST+0,sp)
 343  0026 aa80          	or	a,#128
 344  0028 6b02          	ld	(OFST+0,sp),a
 345  002a               L311:
 346                     ; 79     DELAY_US(DELAY_55US);     /* master - wait 55us (F-50,55,N/A) */
 348  002a ae0125        	ldw	x,#293
 350  002d               L43: 
 351  002d 5a             decw X 
 352  002e 26fd           jrne L43 
 353  0030 9d             nop
 355                     ; 71   for(i=0; i<8; i++)
 358  0031 0c01          	inc	(OFST-1,sp)
 361  0033 7b01          	ld	a,(OFST-1,sp)
 362  0035 a108          	cp	a,#8
 363  0037 25cc          	jrult	L501
 364                     ; 81   return (result);
 366  0039 7b02          	ld	a,(OFST+0,sp)
 369  003b 85            	popw	x
 370  003c 81            	ret
 406                     ; 84 void DS18B20_init(void)
 406                     ; 85 {
 407                     .text:	section	.text,new
 408  0000               _DS18B20_init:
 410  0000 88            	push	a
 411       00000001      OFST:	set	1
 414                     ; 86   u8 stat = OW_reset();
 416  0001 cd0000        	call	_OW_reset
 418  0004 6b01          	ld	(OFST+0,sp),a
 419                     ; 87   OW_write_8(SKIP_ROM_COMMAND);   /* SKIP ROM command - used when only one sensor on bus */
 421  0006 a6cc          	ld	a,#204
 422  0008 cd0000        	call	_OW_write_8
 424                     ; 88   OW_write_8(WRITE_SCRATCHPAD_COMMAND);   /* WRITE SCRATCHPAD command */
 426  000b a64e          	ld	a,#78
 427  000d cd0000        	call	_OW_write_8
 429                     ; 89   OW_write_8(0x00);   /* TH register or User Byte 1 */
 431  0010 4f            	clr	a
 432  0011 cd0000        	call	_OW_write_8
 434                     ; 90   OW_write_8(0x00);   /* TL register or User Byte 2 */
 436  0014 4f            	clr	a
 437  0015 cd0000        	call	_OW_write_8
 439                     ; 91   OW_write_8(0x7F);   /* configuration register: 12 bit resolution - 750ms conversion time */
 441  0018 a67f          	ld	a,#127
 442  001a cd0000        	call	_OW_write_8
 444                     ; 92 }
 447  001d 84            	pop	a
 448  001e 81            	ret
 473                     ; 94 void DS18B20_convert(void)
 473                     ; 95 {
 474                     .text:	section	.text,new
 475  0000               _DS18B20_convert:
 479                     ; 96   OW_reset();
 481  0000 cd0000        	call	_OW_reset
 483                     ; 97   OW_write_8(SKIP_ROM_COMMAND);
 485  0003 a6cc          	ld	a,#204
 486  0005 cd0000        	call	_OW_write_8
 488                     ; 98   OW_write_8(CONVERT_T_COMMAND);
 490  0008 a644          	ld	a,#68
 491  000a cd0000        	call	_OW_write_8
 493                     ; 99 }
 496  000d 81            	ret
 533                     ; 101 s16 DS18B20_read_16(void)
 533                     ; 102 {
 534                     .text:	section	.text,new
 535  0000               _DS18B20_read_16:
 537  0000 89            	pushw	x
 538       00000002      OFST:	set	2
 541                     ; 104   OW_reset();
 543  0001 cd0000        	call	_OW_reset
 545                     ; 105   OW_write_8(SKIP_ROM_COMMAND);
 547  0004 a6cc          	ld	a,#204
 548  0006 cd0000        	call	_OW_write_8
 550                     ; 106   OW_write_8(READ_SCRATCHPAD_COMMAND);
 552  0009 a6be          	ld	a,#190
 553  000b cd0000        	call	_OW_write_8
 555                     ; 107   res = OW_read_8();
 557  000e cd0000        	call	_OW_read_8
 559  0011 5f            	clrw	x
 560  0012 97            	ld	xl,a
 561  0013 1f01          	ldw	(OFST-1,sp),x
 562                     ; 108   res |= OW_read_8() << 8;
 564  0015 cd0000        	call	_OW_read_8
 566  0018 5f            	clrw	x
 567  0019 97            	ld	xl,a
 568  001a 4f            	clr	a
 569  001b 02            	rlwa	x,a
 570  001c 01            	rrwa	x,a
 571  001d 1a02          	or	a,(OFST+0,sp)
 572  001f 01            	rrwa	x,a
 573  0020 1a01          	or	a,(OFST-1,sp)
 574  0022 01            	rrwa	x,a
 575  0023 1f01          	ldw	(OFST-1,sp),x
 576                     ; 109   return (s16)res;
 578  0025 1e01          	ldw	x,(OFST-1,sp)
 581  0027 5b02          	addw	sp,#2
 582  0029 81            	ret
 608                     ; 111 u8 DS18B20_read_8(void)
 608                     ; 112 {
 609                     .text:	section	.text,new
 610  0000               _DS18B20_read_8:
 614                     ; 113   OW_reset();
 616  0000 cd0000        	call	_OW_reset
 618                     ; 114   OW_write_8(SKIP_ROM_COMMAND);
 620  0003 a6cc          	ld	a,#204
 621  0005 cd0000        	call	_OW_write_8
 623                     ; 115   OW_write_8(READ_SCRATCHPAD_COMMAND);
 625  0008 a6be          	ld	a,#190
 626  000a cd0000        	call	_OW_write_8
 628                     ; 116   return OW_read_8();
 630  000d cd0000        	call	_OW_read_8
 634  0010 81            	ret
 647                     	xdef	_OW_read_8
 648                     	xdef	_OW_write_8
 649                     	xdef	_DS18B20_read_8
 650                     	xdef	_DS18B20_read_16
 651                     	xdef	_DS18B20_convert
 652                     	xdef	_DS18B20_init
 653                     	xdef	_OW_reset
 672                     	end
