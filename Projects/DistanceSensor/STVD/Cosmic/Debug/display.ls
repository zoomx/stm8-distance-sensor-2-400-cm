   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  20                     .const:	section	.text
  21  0000               L3_SymbCommaA:
  22  0000 80            	dc.b	128
  23  0001               L5_SymbCommaB:
  24  0001 01            	dc.b	1
  25  0002               L7_SymbU:
  26  0002 0c70          	dc.w	3184
  27  0004               L11_SymbMinusA:
  28  0004 0100          	dc.w	256
  29  0006               L31_SymbMinusB:
  30  0006 8000          	dc.w	-32768
  31  0008               L51_SymbSpace:
  32  0008 0000          	dc.w	0
  33  000a               L71_Char_E_A:
  34  000a 0730          	dc.w	1840
  35  000c               L12_Char_E_B:
  36  000c e00c          	dc.w	-8180
  37  000e               L32_Char_c_A:
  38  000e 0130          	dc.w	304
  39  0010               L52_Char_c_B:
  40  0010 800c          	dc.w	-32756
  41  0012               L72_A:
  42  0012 0e70          	dc.w	3696
  43  0014 0840          	dc.w	2112
  44  0016 0b30          	dc.w	2864
  45  0018 0b50          	dc.w	2896
  46  001a 0d40          	dc.w	3392
  47  001c 0750          	dc.w	1872
  48  001e 0770          	dc.w	1904
  49  0020 0a40          	dc.w	2624
  50  0022 0f70          	dc.w	3952
  51  0024 0f50          	dc.w	3920
  52  0026               L13_B:
  53  0026 700e          	dc.w	28686
  54  0028 1002          	dc.w	4098
  55  002a d00c          	dc.w	-12276
  56  002c d00a          	dc.w	-12278
  57  002e b002          	dc.w	-20478
  58  0030 e00a          	dc.w	-8182
  59  0032 e00e          	dc.w	-8178
  60  0034 5002          	dc.w	20482
  61  0036 f00e          	dc.w	-4082
  62  0038 f00a          	dc.w	-4086
  63  003a               L53_ScreenTime:
  64  003a 02            	dc.b	2
  65  003b 02            	dc.b	2
  66  003c 01            	dc.b	1
 112                     ; 90 void Display_Init()
 112                     ; 91 {
 114                     .text:	section	.text,new
 115  0000               _Display_Init:
 117  0000 88            	push	a
 118       00000001      OFST:	set	1
 121                     ; 93   for(i = 0; i < SCREEN_NUM; i++)
 123  0001 4f            	clr	a
 124  0002 6b01          	ld	(OFST+0,sp),a
 125  0004               L17:
 126                     ; 96     Screen[i].display32b = 0;
 128  0004 97            	ld	xl,a
 129  0005 a604          	ld	a,#4
 130  0007 42            	mul	x,a
 131  0008 4f            	clr	a
 132  0009 e705          	ld	(L33_Screen+3,x),a
 133  000b e704          	ld	(L33_Screen+2,x),a
 134  000d e703          	ld	(L33_Screen+1,x),a
 135  000f e702          	ld	(L33_Screen,x),a
 136                     ; 93   for(i = 0; i < SCREEN_NUM; i++)
 138  0011 0c01          	inc	(OFST+0,sp)
 141  0013 7b01          	ld	a,(OFST+0,sp)
 142  0015 a103          	cp	a,#3
 143  0017 25eb          	jrult	L17
 144                     ; 98   _disp_cnt = 0;
 146  0019 3f01          	clr	L73__disp_cnt
 147                     ; 99   _disp_curr_scr = 0;
 149  001b 3f00          	clr	L14__disp_curr_scr
 150                     ; 100   FLAG_ScreensArrayEmpty = TRUE;
 152  001d 72100000      	bset	L34_FLAG_ScreensArrayEmpty
 153                     ; 101   SevenSegInit();
 155  0021 cd0000        	call	_SevenSegInit
 157                     ; 102   SevenSegRefresh();
 159  0024 cd0000        	call	_SevenSegRefresh
 161                     ; 103 }
 164  0027 84            	pop	a
 165  0028 81            	ret	
 195                     ; 105 void Display_Cyclic()
 195                     ; 106 {
 196                     .text:	section	.text,new
 197  0000               _Display_Cyclic:
 201                     ; 107   if( !FLAG_ScreensArrayEmpty )
 203  0000 7200000040    	btjt	L34_FLAG_ScreensArrayEmpty,L701
 205  0005 200a          	jra	L311
 206  0007               L111:
 207                     ; 112 	  _disp_curr_scr++;
 209  0007 3c00          	inc	L14__disp_curr_scr
 210                     ; 113 	  if(_disp_curr_scr == SCREEN_NUM) 
 212  0009 b600          	ld	a,L14__disp_curr_scr
 213  000b a103          	cp	a,#3
 214  000d 2602          	jrne	L311
 215                     ; 115 	    _disp_curr_scr = 0;
 217  000f 3f00          	clr	L14__disp_curr_scr
 218  0011               L311:
 219                     ; 110 	while(Screen[_disp_curr_scr].display32b == 0)
 221  0011 ad33          	call	LC001
 222  0013 1c0002        	addw	x,#L33_Screen
 223  0016 cd0000        	call	c_lzmp
 225  0019 27ec          	jreq	L111
 226                     ; 119     SevenSegOut(Screen[_disp_curr_scr].display16b.RightDigits);
 228  001b ad29          	call	LC001
 229  001d ee04          	ldw	x,(L33_Screen+2,x)
 230  001f cd0000        	call	_SevenSegOut
 232                     ; 120     SevenSegOut(Screen[_disp_curr_scr].display16b.LeftDigits);
 234  0022 ad22          	call	LC001
 235  0024 ee02          	ldw	x,(L33_Screen,x)
 236  0026 cd0000        	call	_SevenSegOut
 238                     ; 121     SevenSegRefresh();
 240  0029 cd0000        	call	_SevenSegRefresh
 242                     ; 123     _disp_cnt++;
 244  002c 3c01          	inc	L73__disp_cnt
 245                     ; 125 	if(_disp_cnt == ScreenTime[_disp_curr_scr])
 247  002e 5f            	clrw	x
 248  002f b600          	ld	a,L14__disp_curr_scr
 249  0031 97            	ld	xl,a
 250  0032 d6003a        	ld	a,(L53_ScreenTime,x)
 251  0035 b101          	cp	a,L73__disp_cnt
 252  0037 260c          	jrne	L701
 253                     ; 127 	  _disp_cnt = 0;
 255  0039 3f01          	clr	L73__disp_cnt
 256                     ; 128 	  _disp_curr_scr++;
 258  003b 3c00          	inc	L14__disp_curr_scr
 259                     ; 129 	  if(_disp_curr_scr == SCREEN_NUM) 
 261  003d b600          	ld	a,L14__disp_curr_scr
 262  003f a103          	cp	a,#3
 263  0041 2602          	jrne	L701
 264                     ; 131 	    _disp_curr_scr = 0;
 266  0043 3f00          	clr	L14__disp_curr_scr
 267  0045               L701:
 268                     ; 135 }
 271  0045 81            	ret	
 272  0046               LC001:
 273  0046 b600          	ld	a,L14__disp_curr_scr
 274  0048 97            	ld	xl,a
 275  0049 a604          	ld	a,#4
 276  004b 42            	mul	x,a
 277  004c 81            	ret	
 323                     ; 137 void Display_SetScreen32(u8 _scr_num, u32 _scr_val)
 323                     ; 138 {
 324                     .text:	section	.text,new
 325  0000               _Display_SetScreen32:
 327  0000 88            	push	a
 328       00000000      OFST:	set	0
 331                     ; 139   Screen[_scr_num].display32b = _scr_val;
 333  0001 97            	ld	xl,a
 334  0002 a604          	ld	a,#4
 335  0004 42            	mul	x,a
 336  0005 7b07          	ld	a,(OFST+7,sp)
 337  0007 e705          	ld	(L33_Screen+3,x),a
 338  0009 7b06          	ld	a,(OFST+6,sp)
 339  000b e704          	ld	(L33_Screen+2,x),a
 340  000d 7b05          	ld	a,(OFST+5,sp)
 341  000f e703          	ld	(L33_Screen+1,x),a
 342  0011 7b04          	ld	a,(OFST+4,sp)
 343  0013 e702          	ld	(L33_Screen,x),a
 344                     ; 140   FLAG_ScreensArrayEmpty = FALSE;
 346                     ; 141 }
 349  0015 84            	pop	a
 350  0016 72110000      	bres	L34_FLAG_ScreensArrayEmpty
 351  001a 81            	ret	
 406                     ; 143 void Display_SetScreen16(u8 _scr_num, u16 _scr_leftdig, u16 _scr_rightdig)
 406                     ; 144 {
 407                     .text:	section	.text,new
 408  0000               _Display_SetScreen16:
 410  0000 88            	push	a
 411       00000000      OFST:	set	0
 414                     ; 145   Screen[_scr_num].display16b.LeftDigits = _scr_leftdig;
 416  0001 97            	ld	xl,a
 417  0002 a604          	ld	a,#4
 418  0004 42            	mul	x,a
 419  0005 1604          	ldw	y,(OFST+4,sp)
 420  0007 ef02          	ldw	(L33_Screen,x),y
 421                     ; 146   Screen[_scr_num].display16b.RightDigits = _scr_rightdig;
 423  0009 7b01          	ld	a,(OFST+1,sp)
 424  000b 97            	ld	xl,a
 425  000c a604          	ld	a,#4
 426  000e 42            	mul	x,a
 427  000f 1606          	ldw	y,(OFST+6,sp)
 428  0011 ef04          	ldw	(L33_Screen+2,x),y
 429                     ; 147   FLAG_ScreensArrayEmpty = FALSE;
 431                     ; 148 }
 434  0013 84            	pop	a
 435  0014 72110000      	bres	L34_FLAG_ScreensArrayEmpty
 436  0018 81            	ret	
 501                     ; 150 void Display_MapCharToPos(u8 _scr_num, u8 pos, u16* A_val, u16* B_val)
 501                     ; 151 {
 502                     .text:	section	.text,new
 503  0000               _Display_MapCharToPos:
 505  0000 89            	pushw	x
 506       00000000      OFST:	set	0
 509                     ; 152   switch(pos)
 511  0001 9f            	ld	a,xl
 513                     ; 160     case 3: {Screen[_scr_num].display16b.RightDigits |= *B_val; break;}
 514  0002 4d            	tnz	a
 515  0003 270b          	jreq	L571
 516  0005 4a            	dec	a
 517  0006 271a          	jreq	L771
 518  0008 4a            	dec	a
 519  0009 272f          	jreq	L102
 520  000b 4a            	dec	a
 521  000c 273e          	jreq	L302
 522  000e 2052          	jra	L142
 523  0010               L571:
 524                     ; 154     case 0: {Screen[_scr_num].display16b.LeftDigits = *A_val; break;}
 526  0010 1e05          	ldw	x,(OFST+5,sp)
 527  0012 7b01          	ld	a,(OFST+1,sp)
 528  0014 905f          	clrw	y
 529  0016 9097          	ld	yl,a
 530  0018 9058          	sllw	y
 531  001a 9058          	sllw	y
 532  001c fe            	ldw	x,(x)
 533  001d 90ef02        	ldw	(L33_Screen,y),x
 536  0020 2040          	jra	L142
 537  0022               L771:
 538                     ; 156     case 1: {Screen[_scr_num].display16b.LeftDigits |= *B_val; break;}
 540  0022 7b01          	ld	a,(OFST+1,sp)
 541  0024 97            	ld	xl,a
 542  0025 a604          	ld	a,#4
 543  0027 1607          	ldw	y,(OFST+7,sp)
 544  0029 42            	mul	x,a
 545  002a 90fe          	ldw	y,(y)
 546  002c 9001          	rrwa	y,a
 547  002e ea03          	or	a,(L33_Screen+1,x)
 548  0030 9001          	rrwa	y,a
 549  0032 ea02          	or	a,(L33_Screen,x)
 550  0034 9001          	rrwa	y,a
 551  0036 ef02          	ldw	(L33_Screen,x),y
 554  0038 2028          	jra	L142
 555  003a               L102:
 556                     ; 158     case 2: {Screen[_scr_num].display16b.RightDigits = *A_val; break;}
 558  003a 1e05          	ldw	x,(OFST+5,sp)
 559  003c 7b01          	ld	a,(OFST+1,sp)
 560  003e 905f          	clrw	y
 561  0040 9097          	ld	yl,a
 562  0042 9058          	sllw	y
 563  0044 9058          	sllw	y
 564  0046 fe            	ldw	x,(x)
 565  0047 90ef04        	ldw	(L33_Screen+2,y),x
 568  004a 2016          	jra	L142
 569  004c               L302:
 570                     ; 160     case 3: {Screen[_scr_num].display16b.RightDigits |= *B_val; break;}
 572  004c 7b01          	ld	a,(OFST+1,sp)
 573  004e 97            	ld	xl,a
 574  004f a604          	ld	a,#4
 575  0051 1607          	ldw	y,(OFST+7,sp)
 576  0053 42            	mul	x,a
 577  0054 90fe          	ldw	y,(y)
 578  0056 9001          	rrwa	y,a
 579  0058 ea05          	or	a,(L33_Screen+3,x)
 580  005a 9001          	rrwa	y,a
 581  005c ea04          	or	a,(L33_Screen+2,x)
 582  005e 9001          	rrwa	y,a
 583  0060 ef04          	ldw	(L33_Screen+2,x),y
 586  0062               L142:
 587                     ; 162 }
 590  0062 85            	popw	x
 591  0063 81            	ret	
 667                     ; 168 void Display_SetScreen(u8 _scr_num, char* _scr_val, u8 commapos)
 667                     ; 169 {
 668                     .text:	section	.text,new
 669  0000               _Display_SetScreen:
 671  0000 88            	push	a
 672  0001 88            	push	a
 673       00000001      OFST:	set	1
 676                     ; 171   for(i = 0; i < 4; i++)
 678  0002 0f01          	clr	(OFST+0,sp)
 679  0004               L503:
 680                     ; 173     if(*_scr_val != 0)
 682  0004 1e05          	ldw	x,(OFST+4,sp)
 683  0006 f6            	ld	a,(x)
 684  0007 275f          	jreq	L313
 685                     ; 175       if((*_scr_val) < 48)
 687  0009 a130          	cp	a,#48
 688  000b 2417          	jruge	L513
 689                     ; 177         switch(*_scr_val)
 692                     ; 181           case ' ': { Display_MapCharToPos(_scr_num, i, &SymbSpace, &SymbSpace); break; }
 693  000d a020          	sub	a,#32
 694  000f 270d          	jreq	L542
 695  0011 a00d          	sub	a,#13
 696  0013 2653          	jrne	L313
 697                     ; 179           case '-': { Display_MapCharToPos(_scr_num, i, &SymbMinusA, &SymbMinusB); break; }
 699  0015 ae0006        	ldw	x,#L31_SymbMinusB
 700  0018 89            	pushw	x
 701  0019 ae0004        	ldw	x,#L11_SymbMinusA
 705  001c 203c          	jp	LC002
 706  001e               L542:
 707                     ; 181           case ' ': { Display_MapCharToPos(_scr_num, i, &SymbSpace, &SymbSpace); break; }
 709  001e ae0008        	ldw	x,#L51_SymbSpace
 710  0021 89            	pushw	x
 714  0022 2036          	jp	LC002
 716  0024               L513:
 717                     ; 184       else if((*_scr_val) < 58)
 719  0024 a13a          	cp	a,#58
 720  0026 2418          	jruge	L523
 721                     ; 186         Display_MapCharToPos(_scr_num, i, &A[*_scr_val - 48], &B[*_scr_val - 48]);
 723  0028 5f            	clrw	x
 724  0029 97            	ld	xl,a
 725  002a 58            	sllw	x
 726  002b 1d0060        	subw	x,#96
 727  002e 1c0026        	addw	x,#L13_B
 728  0031 89            	pushw	x
 729  0032 1e07          	ldw	x,(OFST+6,sp)
 730  0034 f6            	ld	a,(x)
 731  0035 5f            	clrw	x
 732  0036 97            	ld	xl,a
 733  0037 58            	sllw	x
 734  0038 1d0060        	subw	x,#96
 735  003b 1c0012        	addw	x,#L72_A
 738  003e 201a          	jp	LC002
 739  0040               L523:
 740                     ; 190         switch(*_scr_val)
 743                     ; 218           case 'c': { Display_MapCharToPos(_scr_num, i, &Char_c_A, &Char_c_B); break; }
 744  0040 a045          	sub	a,#69
 745  0042 2706          	jreq	L742
 746  0044 a01e          	sub	a,#30
 747  0046 270b          	jreq	L152
 748  0048 201e          	jra	L313
 749  004a               L742:
 750                     ; 198           case 'E': { Display_MapCharToPos(_scr_num, i, &Char_E_A, &Char_E_B); break; }
 752  004a ae000c        	ldw	x,#L12_Char_E_B
 753  004d 89            	pushw	x
 754  004e ae000a        	ldw	x,#L71_Char_E_A
 758  0051 2007          	jp	LC002
 759  0053               L152:
 760                     ; 218           case 'c': { Display_MapCharToPos(_scr_num, i, &Char_c_A, &Char_c_B); break; }
 762  0053 ae0010        	ldw	x,#L52_Char_c_B
 763  0056 89            	pushw	x
 764  0057 ae000e        	ldw	x,#L32_Char_c_A
 766  005a               LC002:
 767  005a 89            	pushw	x
 768  005b 7b05          	ld	a,(OFST+4,sp)
 769  005d 97            	ld	xl,a
 770  005e 7b06          	ld	a,(OFST+5,sp)
 771  0060 95            	ld	xh,a
 772  0061 cd0000        	call	_Display_MapCharToPos
 773  0064 5b04          	addw	sp,#4
 776  0066 1e05          	ldw	x,(OFST+4,sp)
 777  0068               L313:
 778                     ; 238   _scr_val++;
 780  0068 5c            	incw	x
 781  0069 1f05          	ldw	(OFST+4,sp),x
 782                     ; 171   for(i = 0; i < 4; i++)
 784  006b 0c01          	inc	(OFST+0,sp)
 787  006d 7b01          	ld	a,(OFST+0,sp)
 788  006f a104          	cp	a,#4
 789  0071 2591          	jrult	L503
 790                     ; 240   if(commapos & COMMAPOS1) Screen[_scr_num].display16b.LeftDigits |= SymbCommaA;
 792  0073 7b07          	ld	a,(OFST+6,sp)
 793  0075 a501          	bcp	a,#1
 794  0077 270c          	jreq	L533
 797  0079 7b02          	ld	a,(OFST+1,sp)
 798  007b ad3c          	call	LC003
 799  007d e603          	ld	a,(L33_Screen+1,x)
 800  007f aa80          	or	a,#128
 801  0081 e703          	ld	(L33_Screen+1,x),a
 802  0083 7b07          	ld	a,(OFST+6,sp)
 803  0085               L533:
 804                     ; 241   if(commapos & COMMAPOS2) Screen[_scr_num].display16b.LeftDigits |= SymbCommaB;
 806  0085 a502          	bcp	a,#2
 807  0087 270c          	jreq	L733
 810  0089 7b02          	ld	a,(OFST+1,sp)
 811  008b ad2c          	call	LC003
 812  008d e603          	ld	a,(L33_Screen+1,x)
 813  008f aa01          	or	a,#1
 814  0091 e703          	ld	(L33_Screen+1,x),a
 815  0093 7b07          	ld	a,(OFST+6,sp)
 816  0095               L733:
 817                     ; 242   if(commapos & COMMAPOS3) Screen[_scr_num].display16b.RightDigits |= SymbCommaA;
 819  0095 a504          	bcp	a,#4
 820  0097 270c          	jreq	L143
 823  0099 7b02          	ld	a,(OFST+1,sp)
 824  009b ad1c          	call	LC003
 825  009d e605          	ld	a,(L33_Screen+3,x)
 826  009f aa80          	or	a,#128
 827  00a1 e705          	ld	(L33_Screen+3,x),a
 828  00a3 7b07          	ld	a,(OFST+6,sp)
 829  00a5               L143:
 830                     ; 243   if(commapos & COMMAPOS4) Screen[_scr_num].display16b.RightDigits |= SymbCommaB;
 832  00a5 a508          	bcp	a,#8
 833  00a7 270a          	jreq	L343
 836  00a9 7b02          	ld	a,(OFST+1,sp)
 837  00ab ad0c          	call	LC003
 838  00ad e605          	ld	a,(L33_Screen+3,x)
 839  00af aa01          	or	a,#1
 840  00b1 e705          	ld	(L33_Screen+3,x),a
 841  00b3               L343:
 842                     ; 245   FLAG_ScreensArrayEmpty = FALSE;
 844  00b3 72110000      	bres	L34_FLAG_ScreensArrayEmpty
 845                     ; 246 }
 848  00b7 85            	popw	x
 849  00b8 81            	ret	
 850  00b9               LC003:
 851  00b9 97            	ld	xl,a
 852  00ba a604          	ld	a,#4
 853  00bc 42            	mul	x,a
 854  00bd 81            	ret	
 900                     ; 248 void Display_DisableScreen(u8 _scr_num)
 900                     ; 249 {
 901                     .text:	section	.text,new
 902  0000               _Display_DisableScreen:
 904  0000 88            	push	a
 905       00000001      OFST:	set	1
 908                     ; 251   Screen[_scr_num].display32b = 0;
 910  0001 97            	ld	xl,a
 911  0002 a604          	ld	a,#4
 912  0004 42            	mul	x,a
 913  0005 4f            	clr	a
 914  0006 e705          	ld	(L33_Screen+3,x),a
 915  0008 e704          	ld	(L33_Screen+2,x),a
 916  000a e703          	ld	(L33_Screen+1,x),a
 917  000c e702          	ld	(L33_Screen,x),a
 918                     ; 253   FLAG_ScreensArrayEmpty = TRUE;
 920  000e 72100000      	bset	L34_FLAG_ScreensArrayEmpty
 921                     ; 254   for(i = 0; i < SCREEN_NUM; i++)
 923  0012 6b01          	ld	(OFST+0,sp),a
 924  0014               L763:
 925                     ; 256     if(Screen[i].display32b != 0)
 927  0014 97            	ld	xl,a
 928  0015 a604          	ld	a,#4
 929  0017 42            	mul	x,a
 930  0018 1c0002        	addw	x,#L33_Screen
 931  001b cd0000        	call	c_lzmp
 933  001e 2706          	jreq	L573
 934                     ; 258 	  FLAG_ScreensArrayEmpty = FALSE;
 936  0020 72110000      	bres	L34_FLAG_ScreensArrayEmpty
 937                     ; 259 	  break;
 939  0024 2008          	jra	L373
 940  0026               L573:
 941                     ; 254   for(i = 0; i < SCREEN_NUM; i++)
 943  0026 0c01          	inc	(OFST+0,sp)
 946  0028 7b01          	ld	a,(OFST+0,sp)
 947  002a a103          	cp	a,#3
 948  002c 25e6          	jrult	L763
 949  002e               L373:
 950                     ; 262 }
 953  002e 84            	pop	a
 954  002f 81            	ret	
 990                     ; 266 void Display_SetBrightness(u16 dimmval)
 990                     ; 267 {
 991                     .text:	section	.text,new
 992  0000               _Display_SetBrightness:
 996                     ; 268   TIM2_SetCompare2(dimmval);
 999                     ; 269 }
1002  0000 cc0000        	jp	_TIM2_SetCompare2
1223                     	xdef	_Display_SetBrightness
1224                     	xdef	_Display_DisableScreen
1225                     	xdef	_Display_SetScreen
1226                     	xdef	_Display_MapCharToPos
1227                     	xdef	_Display_SetScreen16
1228                     	xdef	_Display_SetScreen32
1229                     	xdef	_Display_Cyclic
1230                     	xdef	_Display_Init
1231                     .bit:	section	.data,bit
1232  0000               L34_FLAG_ScreensArrayEmpty:
1233  0000 00            	ds.b	1
1234                     	switch	.ubsct
1235  0000               L14__disp_curr_scr:
1236  0000 00            	ds.b	1
1237  0001               L73__disp_cnt:
1238  0001 00            	ds.b	1
1239  0002               L33_Screen:
1240  0002 000000000000  	ds.b	12
1241                     	xref	_SevenSegInit
1242                     	xref	_SevenSegRefresh
1243                     	xref	_SevenSegOut
1244                     	xref	_TIM2_SetCompare2
1264                     	xref	c_lzmp
1265                     	end
