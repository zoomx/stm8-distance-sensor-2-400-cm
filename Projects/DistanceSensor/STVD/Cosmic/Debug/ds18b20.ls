   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  50                     ; 21 u8 DS18B20_All_init(void)
  50                     ; 22 {
  52                     .text:	section	.text,new
  53  0000               _DS18B20_All_init:
  57                     ; 23   if(!OW_reset()) return 0;
  59  0000 cd0000        	call	_OW_reset
  61  0003 4d            	tnz	a
  62  0004 2601          	jrne	L12
  67  0006 81            	ret	
  68  0007               L12:
  69                     ; 24   OW_write_8(SKIP_ROM);           /* SKIP ROM command - used when only one sensor on bus */
  71  0007 a6cc          	ld	a,#204
  72  0009 cd0000        	call	_OW_write_8
  74                     ; 25   OW_write_8(WRITE_SCRATCHPAD);   /* WRITE SCRATCHPAD command */
  76  000c a64e          	ld	a,#78
  77  000e cd0000        	call	_OW_write_8
  79                     ; 26   OW_write_8(0x00);               /* TH register or User Byte 1 */
  81  0011 4f            	clr	a
  82  0012 cd0000        	call	_OW_write_8
  84                     ; 27   OW_write_8(0x00);               /* TL register or User Byte 2 */
  86  0015 4f            	clr	a
  87  0016 cd0000        	call	_OW_write_8
  89                     ; 28   OW_write_8(0x7F);               /* configuration register: 12 bit resolution - 750ms conversion time */
  91  0019 a67f          	ld	a,#127
  92  001b cd0000        	call	_OW_write_8
  94                     ; 29   return 1;
  96  001e a601          	ld	a,#1
  99  0020 81            	ret	
 125                     ; 35 u8 DS18B20_All_convert(void)
 125                     ; 36 {
 126                     .text:	section	.text,new
 127  0000               _DS18B20_All_convert:
 131                     ; 37   if(!OW_reset()) return 0;
 133  0000 cd0000        	call	_OW_reset
 135  0003 4d            	tnz	a
 136  0004 2601          	jrne	L33
 141  0006 81            	ret	
 142  0007               L33:
 143                     ; 38   OW_write_8(SKIP_ROM);
 145  0007 a6cc          	ld	a,#204
 146  0009 cd0000        	call	_OW_write_8
 148                     ; 39   OW_write_8(CONVERT_T);
 150  000c a644          	ld	a,#68
 151  000e cd0000        	call	_OW_write_8
 153                     ; 40   return 1;
 155  0011 a601          	ld	a,#1
 158  0013 81            	ret	
 206                     ; 51 u8 DS18B20_All_Read_Temp(s16* result)
 206                     ; 52 {
 207                     .text:	section	.text,new
 208  0000               _DS18B20_All_Read_Temp:
 210  0000 89            	pushw	x
 211  0001 89            	pushw	x
 212       00000002      OFST:	set	2
 215                     ; 54   if(!OW_reset()) return 0;
 217  0002 cd0000        	call	_OW_reset
 219  0005 4d            	tnz	a
 223  0006 2725          	jreq	L64
 224                     ; 55   OW_write_8(SKIP_ROM);
 226  0008 a6cc          	ld	a,#204
 227  000a cd0000        	call	_OW_write_8
 229                     ; 56   OW_write_8(READ_SCRATCHPAD);
 231  000d a6be          	ld	a,#190
 232  000f cd0000        	call	_OW_write_8
 234                     ; 57   tmp = OW_read_8();
 236  0012 cd0000        	call	_OW_read_8
 238  0015 5f            	clrw	x
 239  0016 97            	ld	xl,a
 240  0017 1f01          	ldw	(OFST-1,sp),x
 241                     ; 58   tmp |= OW_read_8() << 8;
 243  0019 cd0000        	call	_OW_read_8
 245  001c 5f            	clrw	x
 246  001d 97            	ld	xl,a
 247  001e 7b02          	ld	a,(OFST+0,sp)
 248  0020 01            	rrwa	x,a
 249  0021 1a01          	or	a,(OFST-1,sp)
 250  0023 01            	rrwa	x,a
 251  0024 1f01          	ldw	(OFST-1,sp),x
 252                     ; 59   *result = tmp;
 254  0026 1e03          	ldw	x,(OFST+1,sp)
 255  0028 1601          	ldw	y,(OFST-1,sp)
 256  002a ff            	ldw	(x),y
 257                     ; 60   return 1;
 259  002b a601          	ld	a,#1
 261  002d               L64:
 263  002d 5b04          	addw	sp,#4
 264  002f 81            	ret	
 303                     ; 67 u8 DS18B20_All_Read_Byte(u8* result)
 303                     ; 68 {
 304                     .text:	section	.text,new
 305  0000               _DS18B20_All_Read_Byte:
 307  0000 89            	pushw	x
 308       00000000      OFST:	set	0
 311                     ; 69   if(!OW_reset()) return 0;
 313  0001 cd0000        	call	_OW_reset
 315  0004 4d            	tnz	a
 319  0005 2712          	jreq	L26
 320                     ; 70   OW_write_8(SKIP_ROM);
 322  0007 a6cc          	ld	a,#204
 323  0009 cd0000        	call	_OW_write_8
 325                     ; 71   OW_write_8(READ_SCRATCHPAD);
 327  000c a6be          	ld	a,#190
 328  000e cd0000        	call	_OW_write_8
 330                     ; 72   *result = OW_read_8();
 332  0011 cd0000        	call	_OW_read_8
 334  0014 1e01          	ldw	x,(OFST+1,sp)
 335  0016 f7            	ld	(x),a
 336                     ; 73   return 1;
 338  0017 a601          	ld	a,#1
 340  0019               L26:
 342  0019 85            	popw	x
 343  001a 81            	ret	
 409                     ; 80 u8 DS18B20_Read_Temp(s16* result, u8* ROM_ID)
 409                     ; 81 {
 410                     .text:	section	.text,new
 411  0000               _DS18B20_Read_Temp:
 413  0000 89            	pushw	x
 414  0001 89            	pushw	x
 415       00000002      OFST:	set	2
 418                     ; 83   if(!OW_reset()) return 0;
 420  0002 cd0000        	call	_OW_reset
 422  0005 4d            	tnz	a
 426  0006 2739          	jreq	L201
 427                     ; 84   OW_write_8(MATCH_ROM);
 429  0008 a655          	ld	a,#85
 430  000a cd0000        	call	_OW_write_8
 432                     ; 85   for(i = 0; i < 8; i++)
 434  000d 5f            	clrw	x
 435  000e 1f01          	ldw	(OFST-1,sp),x
 436  0010               L531:
 437                     ; 86     OW_write_8(ROM_ID[i]);
 439  0010 72fb07        	addw	x,(OFST+5,sp)
 440  0013 f6            	ld	a,(x)
 441  0014 cd0000        	call	_OW_write_8
 443                     ; 85   for(i = 0; i < 8; i++)
 445  0017 1e01          	ldw	x,(OFST-1,sp)
 446  0019 5c            	incw	x
 447  001a 1f01          	ldw	(OFST-1,sp),x
 450  001c a30008        	cpw	x,#8
 451  001f 2fef          	jrslt	L531
 452                     ; 87   OW_write_8(READ_SCRATCHPAD);
 454  0021 a6be          	ld	a,#190
 455  0023 cd0000        	call	_OW_write_8
 457                     ; 88   tmp = OW_read_8();
 459  0026 cd0000        	call	_OW_read_8
 461  0029 5f            	clrw	x
 462  002a 97            	ld	xl,a
 463  002b 1f01          	ldw	(OFST-1,sp),x
 464                     ; 89   tmp |= OW_read_8() << 8;
 466  002d cd0000        	call	_OW_read_8
 468  0030 5f            	clrw	x
 469  0031 97            	ld	xl,a
 470  0032 7b02          	ld	a,(OFST+0,sp)
 471  0034 01            	rrwa	x,a
 472  0035 1a01          	or	a,(OFST-1,sp)
 473  0037 01            	rrwa	x,a
 474  0038 1f01          	ldw	(OFST-1,sp),x
 475                     ; 90   *result = tmp;
 477  003a 1e03          	ldw	x,(OFST+1,sp)
 478  003c 1601          	ldw	y,(OFST-1,sp)
 479  003e ff            	ldw	(x),y
 480                     ; 91   return 1;
 482  003f a601          	ld	a,#1
 484  0041               L201:
 486  0041 5b04          	addw	sp,#4
 487  0043 81            	ret	
 535                     ; 99 u8 DS18B20_Read_ROM_ID(u8* ROM_ID)
 535                     ; 100 {
 536                     .text:	section	.text,new
 537  0000               _DS18B20_Read_ROM_ID:
 539  0000 89            	pushw	x
 540  0001 89            	pushw	x
 541       00000002      OFST:	set	2
 544                     ; 102   if(!OW_reset()) return 0;
 546  0002 cd0000        	call	_OW_reset
 548  0005 4d            	tnz	a
 552  0006 271d          	jreq	L411
 553                     ; 103   OW_write_8(READ_ROM);
 555  0008 a633          	ld	a,#51
 556  000a cd0000        	call	_OW_write_8
 558                     ; 104   for(i = 0; i < 8; i++)
 560  000d 5f            	clrw	x
 561  000e 1f01          	ldw	(OFST-1,sp),x
 562  0010               L761:
 563                     ; 105     ROM_ID[i] = OW_read_8();
 565  0010 cd0000        	call	_OW_read_8
 567  0013 1e01          	ldw	x,(OFST-1,sp)
 568  0015 72fb03        	addw	x,(OFST+1,sp)
 569  0018 f7            	ld	(x),a
 570                     ; 104   for(i = 0; i < 8; i++)
 572  0019 1e01          	ldw	x,(OFST-1,sp)
 573  001b 5c            	incw	x
 574  001c 1f01          	ldw	(OFST-1,sp),x
 577  001e a30008        	cpw	x,#8
 578  0021 2fed          	jrslt	L761
 579                     ; 106   return 1;
 581  0023 a601          	ld	a,#1
 583  0025               L411:
 585  0025 5b04          	addw	sp,#4
 586  0027 81            	ret	
 599                     	xdef	_DS18B20_Read_ROM_ID
 600                     	xdef	_DS18B20_Read_Temp
 601                     	xdef	_DS18B20_All_Read_Byte
 602                     	xdef	_DS18B20_All_Read_Temp
 603                     	xdef	_DS18B20_All_convert
 604                     	xdef	_DS18B20_All_init
 605                     	xref	_OW_read_8
 606                     	xref	_OW_write_8
 607                     	xref	_OW_reset
 626                     	end
