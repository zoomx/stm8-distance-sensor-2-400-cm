   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  60                     ; 4 u8 OW_reset(void)
  60                     ; 5 {
  62                     .text:	section	.text,new
  63  0000               _OW_reset:
  65  0000 88            	push	a
  66       00000001      OFST:	set	1
  69                     ; 7   OW_LOW();                /* master - drive bus low */
  71  0001 721d5005      	bres	20485,#6
  72                     ; 8   DELAY_US(DELAY_480US);   /* master - wait for 480us (H-480,480,640) */
  74  0005 ae0a00        	ldw	x,#2560
  76  0008               L6:
  77  0008 5a            	decw	X
  78  0009 26fd          	jrne	L6
  79  000b 9d            	nop	
  81                     ; 9   OW_HIGH();               /* master - release bus */
  84  000c 721c5005      	bset	20485,#6
  85                     ; 10   DELAY_US(DELAY_70US);    /* master - wait for 70us (I-63,70,78) */
  87  0010 ae0175        	ldw	x,#373
  89  0013               L01:
  90  0013 5a            	decw	X
  91  0014 26fd          	jrne	L01
  92  0016 9d            	nop	
  94                     ; 11   result = OW_READ();
  97  0017 c65006        	ld	a,20486
  98  001a a440          	and	a,#64
  99  001c 6b01          	ld	(OFST+0,sp),a
 100                     ; 12   DELAY_US(DELAY_410US);   /* master - wait for 410us (J-410,410,N/A) */
 102  001e ae088b        	ldw	x,#2187
 104  0021               L21:
 105  0021 5a            	decw	X
 106  0022 26fd          	jrne	L21
 108                     ; 13   OW_HIGH();               /* master - release bus */
 111  0024 721c5005      	bset	20485,#6
 112  0028 9d            	nop	
 113                     ; 14   return (u8)(result == (u8)0);
 115  0029 7b01          	ld	a,(OFST+0,sp)
 116  002b 2603          	jrne	L41
 117  002d 4c            	inc	a
 118  002e 2001          	jra	L61
 119  0030               L41:
 120  0030 4f            	clr	a
 121  0031               L61:
 124  0031 5b01          	addw	sp,#1
 125  0033 81            	ret	
 168                     ; 17 void OW_write_8(u8 data)
 168                     ; 18 {
 169                     .text:	section	.text,new
 170  0000               _OW_write_8:
 172  0000 88            	push	a
 173  0001 88            	push	a
 174       00000001      OFST:	set	1
 177                     ; 20   for(i=0; i<8; i++)
 179  0002 0f01          	clr	(OFST+0,sp)
 180  0004               L15:
 181                     ; 22     if(data & 0x01)
 183  0004 7b02          	ld	a,(OFST+1,sp)
 184  0006 a501          	bcp	a,#1
 185  0008 2717          	jreq	L75
 186                     ; 24       OW_LOW();               /* master - drive bus low */
 188  000a 721d5005      	bres	20485,#6
 189                     ; 25       DELAY_US(DELAY_6US);    /* master - wait 6us (A-5,6,15) */
 191  000e ae0020        	ldw	x,#32
 193  0011               L22:
 194  0011 5a            	decw	X
 195  0012 26fd          	jrne	L22
 196  0014 9d            	nop	
 198                     ; 26       OW_HIGH();              /* master - release bus */
 201  0015 721c5005      	bset	20485,#6
 202                     ; 27       DELAY_US(DELAY_64US);   /* master - wait 64us (B-59,64,N/A) */
 204  0019 ae0155        	ldw	x,#341
 206  001c               L42:
 207  001c 5a            	decw	X
 208  001d 26fd          	jrne	L42
 212  001f 2015          	jra	L16
 213  0021               L75:
 214                     ; 31       OW_LOW();                /* master - drive bus low */
 216  0021 721d5005      	bres	20485,#6
 217                     ; 32       DELAY_US(DELAY_60US);    /* master - wait 60us (C-60,60,120) */
 219  0025 ae0140        	ldw	x,#320
 221  0028               L62:
 222  0028 5a            	decw	X
 223  0029 26fd          	jrne	L62
 224  002b 9d            	nop	
 226                     ; 33       OW_HIGH();               /* master - release bus */
 229  002c 721c5005      	bset	20485,#6
 230                     ; 34       DELAY_US(DELAY_10US);    /* master - wait 10us (D-8,10,N/A) */
 232  0030 ae0035        	ldw	x,#53
 234  0033               L03:
 235  0033 5a            	decw	X
 236  0034 26fd          	jrne	L03
 238  0036               L16:
 239                     ; 36     data >>= 1;
 241  0036 0402          	srl	(OFST+1,sp)
 242                     ; 20   for(i=0; i<8; i++)
 244  0038 0c01          	inc	(OFST+0,sp)
 245  003a 9d            	nop	
 248  003b 7b01          	ld	a,(OFST+0,sp)
 249  003d a108          	cp	a,#8
 250  003f 25c3          	jrult	L15
 251                     ; 38 }
 254  0041 85            	popw	x
 255  0042 81            	ret	
 299                     ; 39 u8 OW_read_8(void)
 299                     ; 40 {
 300                     .text:	section	.text,new
 301  0000               _OW_read_8:
 303  0000 89            	pushw	x
 304       00000002      OFST:	set	2
 307                     ; 42   u8 result = 0;
 309  0001 0f02          	clr	(OFST+0,sp)
 310                     ; 44   for(i=0; i<8; i++)
 312  0003 0f01          	clr	(OFST-1,sp)
 313  0005               L501:
 314                     ; 46     result >>= 1;
 316  0005 0402          	srl	(OFST+0,sp)
 317                     ; 47     OW_LOW();                 /* master - drive bus low */
 319                     ; 48     DELAY_US(DELAY_6US);      /* master - wait 6us (A-5,6,15) */
 321  0007 ae0020        	ldw	x,#32
 322  000a 721d5005      	bres	20485,#6
 324  000e               L43:
 325  000e 5a            	decw	X
 326  000f 26fd          	jrne	L43
 327  0011 9d            	nop	
 329                     ; 49     OW_HIGH();                /* master - release bus */
 332  0012 721c5005      	bset	20485,#6
 333                     ; 50     DELAY_US(DELAY_9US);      /* master - wait 9us (E-5,9,12) */
 335  0016 ae0030        	ldw	x,#48
 337  0019               L63:
 338  0019 5a            	decw	X
 339  001a 26fd          	jrne	L63
 340  001c 9d            	nop	
 342                     ; 51     if(OW_READ())  result |= 0x80;
 345  001d 720d500606    	btjf	20486,#6,L311
 348  0022 7b02          	ld	a,(OFST+0,sp)
 349  0024 aa80          	or	a,#128
 350  0026 6b02          	ld	(OFST+0,sp),a
 351  0028               L311:
 352                     ; 52     DELAY_US(DELAY_55US);     /* master - wait 55us (F-50,55,N/A) */
 354  0028 ae0125        	ldw	x,#293
 356  002b               L04:
 357  002b 5a            	decw	X
 358  002c 26fd          	jrne	L04
 360                     ; 44   for(i=0; i<8; i++)
 363  002e 0c01          	inc	(OFST-1,sp)
 364  0030 9d            	nop	
 367  0031 7b01          	ld	a,(OFST-1,sp)
 368  0033 a108          	cp	a,#8
 369  0035 25ce          	jrult	L501
 370                     ; 54   return (result);
 372  0037 7b02          	ld	a,(OFST+0,sp)
 375  0039 85            	popw	x
 376  003a 81            	ret	
 389                     	xdef	_OW_read_8
 390                     	xdef	_OW_write_8
 391                     	xdef	_OW_reset
 410                     	end
