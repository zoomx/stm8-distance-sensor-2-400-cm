   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  59                     ; 4 void SevenSegInit()
  59                     ; 5 {
  61                     .text:	section	.text,new
  62  0000               _SevenSegInit:
  64  0000 88            	push	a
  65       00000001      OFST:	set	1
  68                     ; 7  DISP_SDI_1;
  70  0001 7214500f      	bset	20495,#2
  71                     ; 8  for(i = 0; i < 32; i++)
  73  0005 0f01          	clr	(OFST+0,sp)
  74  0007               L72:
  75                     ; 10   DISP_CLK_1;
  77  0007 721e500f      	bset	20495,#7
  78                     ; 11   DELAY_US(DELAY_6US);
  80  000b ae0020        	ldw	x,#32
  82  000e               L6:
  83  000e 5a            	decw	X
  84  000f 26fd          	jrne	L6
  85  0011 9d            	nop	
  87                     ; 12   DISP_CLK_0;
  90  0012 721f500f      	bres	20495,#7
  91                     ; 13   DELAY_US(DELAY_6US);
  93  0016 ae0020        	ldw	x,#32
  95  0019               L01:
  96  0019 5a            	decw	X
  97  001a 26fd          	jrne	L01
  99                     ; 8  for(i = 0; i < 32; i++)
 102  001c 0c01          	inc	(OFST+0,sp)
 103  001e 9d            	nop	
 106  001f 7b01          	ld	a,(OFST+0,sp)
 107  0021 a120          	cp	a,#32
 108  0023 25e2          	jrult	L72
 109                     ; 15  DELAY_US(DELAY_6US);
 111  0025 ae0020        	ldw	x,#32
 113  0028               L21:
 114  0028 5a            	decw	X
 115  0029 26fd          	jrne	L21
 116  002b 9d            	nop	
 118                     ; 16  DISP_LE_1;
 121  002c 7218500f      	bset	20495,#4
 122                     ; 17  DELAY_US(DELAY_6US);
 124  0030 ae0020        	ldw	x,#32
 126  0033               L41:
 127  0033 5a            	decw	X
 128  0034 26fd          	jrne	L41
 129  0036 9d            	nop	
 131                     ; 18  DISP_LE_0;
 134  0037 7219500f      	bres	20495,#4
 135                     ; 19 }
 138  003b 84            	pop	a
 139  003c 81            	ret	
 192                     ; 20 void SevenSegOut(u16 number)
 192                     ; 21 {
 193                     .text:	section	.text,new
 194  0000               _SevenSegOut:
 196  0000 89            	pushw	x
 197  0001 5203          	subw	sp,#3
 198       00000003      OFST:	set	3
 201                     ; 22  u16 tmp = 0x8000;
 203  0003 ae8000        	ldw	x,#32768
 204  0006 1f01          	ldw	(OFST-2,sp),x
 205                     ; 24  DISP_CLK_0;
 207  0008 721f500f      	bres	20495,#7
 208                     ; 25  for(i = 0; i < 16; i++)
 210  000c 0f03          	clr	(OFST+0,sp)
 211  000e               L36:
 212                     ; 27   DISP_SDI_0;
 214  000e 7215500f      	bres	20495,#2
 215                     ; 28   if(number & tmp) {
 217  0012 1e04          	ldw	x,(OFST+1,sp)
 218  0014 01            	rrwa	x,a
 219  0015 1402          	and	a,(OFST-1,sp)
 220  0017 01            	rrwa	x,a
 221  0018 1401          	and	a,(OFST-2,sp)
 222  001a 01            	rrwa	x,a
 223  001b 5d            	tnzw	x
 224  001c 2704          	jreq	L17
 225                     ; 29    DISP_SDI_1;
 227  001e 7214500f      	bset	20495,#2
 228  0022               L17:
 229                     ; 31   DELAY_US(DELAY_6US);
 231  0022 ae0020        	ldw	x,#32
 233  0025               L02:
 234  0025 5a            	decw	X
 235  0026 26fd          	jrne	L02
 236  0028 9d            	nop	
 238                     ; 32   DISP_CLK_1;
 241  0029 721e500f      	bset	20495,#7
 242                     ; 33   DELAY_US(DELAY_6US);
 244  002d ae0020        	ldw	x,#32
 246  0030               L22:
 247  0030 5a            	decw	X
 248  0031 26fd          	jrne	L22
 249  0033 9d            	nop	
 251                     ; 34   DISP_CLK_0;
 254  0034 721f500f      	bres	20495,#7
 255                     ; 35   DELAY_US(DELAY_6US);
 257  0038 ae0020        	ldw	x,#32
 259  003b               L42:
 260  003b 5a            	decw	X
 261  003c 26fd          	jrne	L42
 263                     ; 36   tmp >>= 1;
 266  003e 0401          	srl	(OFST-2,sp)
 267  0040 0602          	rrc	(OFST-1,sp)
 268                     ; 25  for(i = 0; i < 16; i++)
 270  0042 0c03          	inc	(OFST+0,sp)
 271  0044 9d            	nop	
 274  0045 7b03          	ld	a,(OFST+0,sp)
 275  0047 a110          	cp	a,#16
 276  0049 25c3          	jrult	L36
 277                     ; 38 }
 280  004b 5b05          	addw	sp,#5
 281  004d 81            	ret	
 304                     ; 40 void SevenSegRefresh()
 304                     ; 41 {
 305                     .text:	section	.text,new
 306  0000               _SevenSegRefresh:
 310                     ; 42  DISP_LE_0;
 312  0000 7219500f      	bres	20495,#4
 313                     ; 43  DELAY_US(DELAY_6US);
 315  0004 ae0020        	ldw	x,#32
 317  0007               L03:
 318  0007 5a            	decw	X
 319  0008 26fd          	jrne	L03
 320  000a 9d            	nop	
 322                     ; 44  DISP_LE_1;
 325  000b 7218500f      	bset	20495,#4
 326                     ; 45  DELAY_US(DELAY_6US);
 328  000f ae0020        	ldw	x,#32
 330  0012               L23:
 331  0012 5a            	decw	X
 332  0013 26fd          	jrne	L23
 333  0015 9d            	nop	
 335                     ; 46  DISP_LE_0;
 338  0016 7219500f      	bres	20495,#4
 339                     ; 47 }
 342  001a 81            	ret	
 355                     	xdef	_SevenSegRefresh
 356                     	xdef	_SevenSegOut
 357                     	xdef	_SevenSegInit
 376                     	end
