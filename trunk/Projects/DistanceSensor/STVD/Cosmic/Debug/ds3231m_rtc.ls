   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  20                     	bsct
  21  0000               _RTC_sec:
  22  0000 00            	dc.b	0
  23  0001               _RTC_min:
  24  0001 00            	dc.b	0
  25  0002               _RTC_hour:
  26  0002 00            	dc.b	0
  27  0003               _RTC_day:
  28  0003 00            	dc.b	0
  29  0004               _RTC_date:
  30  0004 00            	dc.b	0
  31  0005               _RTC_month:
  32  0005 00            	dc.b	0
  33  0006               _RTC_year:
  34  0006 00            	dc.b	0
  35  0007               _RTC_temp:
  36  0007 0000          	dc.w	0
  77                     ; 29 void DS3231M_Flush(u8 cycles)
  77                     ; 30 {
  79                     .text:	section	.text,new
  80  0000               _DS3231M_Flush:
  84                     ; 31   I2C_Flush(cycles);
  87                     ; 32 }
  90  0000 cc0000        	jp	_I2C_Flush
 138                     ; 34 u8 DS3231M_GetTime(void)
 138                     ; 35 {
 139                     .text:	section	.text,new
 140  0000               _DS3231M_GetTime:
 142  0000 5204          	subw	sp,#4
 143       00000004      OFST:	set	4
 146                     ; 36   u8 tmp[3], status = 0;
 148                     ; 37   status = I2C_ReadBytes(tmp, 3, DS3231M_ADR, 0x00);
 150  0002 4b00          	push	#0
 151  0004 4bd0          	push	#208
 152  0006 4b03          	push	#3
 153  0008 96            	ldw	x,sp
 154  0009 1c0005        	addw	x,#OFST+1
 155  000c cd0000        	call	_I2C_ReadBytes
 157  000f 5b03          	addw	sp,#3
 158  0011 6b01          	ld	(OFST-3,sp),a
 159                     ; 38   if(status)
 161  0013 270e          	jreq	L15
 162                     ; 40     RTC_sec = tmp[0];
 164  0015 7b02          	ld	a,(OFST-2,sp)
 165  0017 b700          	ld	_RTC_sec,a
 166                     ; 41     RTC_min = tmp[1];
 168  0019 7b03          	ld	a,(OFST-1,sp)
 169  001b b701          	ld	_RTC_min,a
 170                     ; 42     RTC_hour = tmp[2];
 172  001d 7b04          	ld	a,(OFST+0,sp)
 173  001f b702          	ld	_RTC_hour,a
 174  0021 7b01          	ld	a,(OFST-3,sp)
 175  0023               L15:
 176                     ; 44   return status;
 180  0023 5b04          	addw	sp,#4
 181  0025 81            	ret	
 230                     ; 47 u8 DS3231M_GetDate(void)
 230                     ; 48 {
 231                     .text:	section	.text,new
 232  0000               _DS3231M_GetDate:
 234  0000 5205          	subw	sp,#5
 235       00000005      OFST:	set	5
 238                     ; 49   u8 tmp[4], status = 0;
 240                     ; 50   status = I2C_ReadBytes(tmp, 4, DS3231M_ADR, 0x03);
 242  0002 4b03          	push	#3
 243  0004 4bd0          	push	#208
 244  0006 4b04          	push	#4
 245  0008 96            	ldw	x,sp
 246  0009 1c0005        	addw	x,#OFST+0
 247  000c cd0000        	call	_I2C_ReadBytes
 249  000f 5b03          	addw	sp,#3
 250  0011 6b01          	ld	(OFST-4,sp),a
 251                     ; 51   if(status)
 253  0013 2712          	jreq	L57
 254                     ; 53     RTC_day = tmp[0];
 256  0015 7b02          	ld	a,(OFST-3,sp)
 257  0017 b703          	ld	_RTC_day,a
 258                     ; 54     RTC_date = tmp[1];
 260  0019 7b03          	ld	a,(OFST-2,sp)
 261  001b b704          	ld	_RTC_date,a
 262                     ; 55     RTC_month = tmp[2];
 264  001d 7b04          	ld	a,(OFST-1,sp)
 265  001f b705          	ld	_RTC_month,a
 266                     ; 56 	  RTC_year = tmp[3];
 268  0021 7b05          	ld	a,(OFST+0,sp)
 269  0023 b706          	ld	_RTC_year,a
 270  0025 7b01          	ld	a,(OFST-4,sp)
 271  0027               L57:
 272                     ; 58   return status; 
 276  0027 5b05          	addw	sp,#5
 277  0029 81            	ret	
 324                     ; 61 u8 DS3231M_GetTemperature(void)
 324                     ; 62 {
 325                     .text:	section	.text,new
 326  0000               _DS3231M_GetTemperature:
 328  0000 5205          	subw	sp,#5
 329       00000005      OFST:	set	5
 332                     ; 63   u8 tmp[2], status = 0;
 334                     ; 64   status = I2C_ReadBytes(tmp, 2, DS3231M_ADR, 0x11);
 336  0002 4b11          	push	#17
 337  0004 4bd0          	push	#208
 338  0006 4b02          	push	#2
 339  0008 96            	ldw	x,sp
 340  0009 1c0007        	addw	x,#OFST+2
 341  000c cd0000        	call	_I2C_ReadBytes
 343  000f 5b03          	addw	sp,#3
 344  0011 6b03          	ld	(OFST-2,sp),a
 345                     ; 65   if(status)
 347  0013 2723          	jreq	L121
 348                     ; 67 	RTC_temp =  (s16) ((u16)((tmp[0]&0x7F)<<2) | ((tmp[1]>>6)&0x03));
 350  0015 7b05          	ld	a,(OFST+0,sp)
 351  0017 4e            	swap	a
 352  0018 a40c          	and	a,#12
 353  001a 44            	srl	a
 354  001b 44            	srl	a
 355  001c 5f            	clrw	x
 356  001d 97            	ld	xl,a
 357  001e 1f01          	ldw	(OFST-4,sp),x
 358  0020 7b04          	ld	a,(OFST-1,sp)
 359  0022 a47f          	and	a,#127
 360  0024 97            	ld	xl,a
 361  0025 a604          	ld	a,#4
 362  0027 42            	mul	x,a
 363  0028 01            	rrwa	x,a
 364  0029 1a02          	or	a,(OFST-3,sp)
 365  002b 01            	rrwa	x,a
 366  002c 1a01          	or	a,(OFST-4,sp)
 367  002e 01            	rrwa	x,a
 368  002f bf07          	ldw	_RTC_temp,x
 369                     ; 68 	if(tmp[0] & 0x80) RTC_temp = -RTC_temp;
 371  0031 7b04          	ld	a,(OFST-1,sp)
 372  0033 2a03          	jrpl	L121
 375  0035 50            	negw	x
 376  0036 bf07          	ldw	_RTC_temp,x
 377  0038               L121:
 378                     ; 70   return status;
 380  0038 7b03          	ld	a,(OFST-2,sp)
 383  003a 5b05          	addw	sp,#5
 384  003c 81            	ret	
 432                     ; 73 u8 DS3231M_SetTime(void)
 432                     ; 74 {
 433                     .text:	section	.text,new
 434  0000               _DS3231M_SetTime:
 436  0000 5204          	subw	sp,#4
 437       00000004      OFST:	set	4
 440                     ; 75   u8 tmp[3], status = 0;
 442                     ; 76   tmp[0] = RTC_sec;
 444  0002 b600          	ld	a,_RTC_sec
 445  0004 6b02          	ld	(OFST-2,sp),a
 446                     ; 77   tmp[1] = RTC_min;
 448  0006 b601          	ld	a,_RTC_min
 449  0008 6b03          	ld	(OFST-1,sp),a
 450                     ; 78   tmp[2] = RTC_hour;
 452  000a b602          	ld	a,_RTC_hour
 453  000c 6b04          	ld	(OFST+0,sp),a
 454                     ; 79   status = I2C_WriteBytes(tmp, 3, DS3231M_ADR, 0x00);
 456  000e 4b00          	push	#0
 457  0010 4bd0          	push	#208
 458  0012 4b03          	push	#3
 459  0014 96            	ldw	x,sp
 460  0015 1c0005        	addw	x,#OFST+1
 461  0018 cd0000        	call	_I2C_WriteBytes
 463  001b 5b07          	addw	sp,#7
 464                     ; 80   return status;
 468  001d 81            	ret	
 517                     ; 83 u8 DS3231M_SetDate(void)
 517                     ; 84 {
 518                     .text:	section	.text,new
 519  0000               _DS3231M_SetDate:
 521  0000 5205          	subw	sp,#5
 522       00000005      OFST:	set	5
 525                     ; 85   u8 tmp[4], status = 0;
 527                     ; 86   tmp[0] = RTC_day;
 529  0002 b603          	ld	a,_RTC_day
 530  0004 6b02          	ld	(OFST-3,sp),a
 531                     ; 87   tmp[1] = RTC_date;
 533  0006 b604          	ld	a,_RTC_date
 534  0008 6b03          	ld	(OFST-2,sp),a
 535                     ; 88   tmp[2] = RTC_month;
 537  000a b605          	ld	a,_RTC_month
 538  000c 6b04          	ld	(OFST-1,sp),a
 539                     ; 89   tmp[3] = RTC_year;
 541  000e b606          	ld	a,_RTC_year
 542  0010 6b05          	ld	(OFST+0,sp),a
 543                     ; 90   status = I2C_WriteBytes(tmp, 4, DS3231M_ADR, 0x03);
 545  0012 4b03          	push	#3
 546  0014 4bd0          	push	#208
 547  0016 4b04          	push	#4
 548  0018 96            	ldw	x,sp
 549  0019 1c0005        	addw	x,#OFST+0
 550  001c cd0000        	call	_I2C_WriteBytes
 552  001f 5b08          	addw	sp,#8
 553                     ; 91   return status;
 557  0021 81            	ret	
 603                     ; 95 u8 DS3231M_EnableOsc(void)
 603                     ; 96 {
 604                     .text:	section	.text,new
 605  0000               _DS3231M_EnableOsc:
 607  0000 5203          	subw	sp,#3
 608       00000003      OFST:	set	3
 611                     ; 97   u8 tmp[2], status = 0;
 613                     ; 98   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
 615  0002 4b0e          	push	#14
 616  0004 4bd0          	push	#208
 617  0006 4b01          	push	#1
 618  0008 96            	ldw	x,sp
 619  0009 1c0005        	addw	x,#OFST+2
 620  000c cd0000        	call	_I2C_ReadBytes
 622  000f 5b03          	addw	sp,#3
 623  0011 6b01          	ld	(OFST-2,sp),a
 624                     ; 99   if(tmp[0] & nEOSC)   //if nEOSC bit is set, reset it
 626  0013 7b02          	ld	a,(OFST-1,sp)
 627  0015 2a15          	jrpl	L312
 628                     ; 101     tmp[0] &= (u8)(~nEOSC);
 630  0017 a47f          	and	a,#127
 631  0019 6b02          	ld	(OFST-1,sp),a
 632                     ; 102     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
 634  001b 4b0e          	push	#14
 635  001d 4bd0          	push	#208
 636  001f 4b01          	push	#1
 637  0021 96            	ldw	x,sp
 638  0022 1c0005        	addw	x,#OFST+2
 639  0025 cd0000        	call	_I2C_WriteBytes
 641  0028 5b03          	addw	sp,#3
 642  002a 6b01          	ld	(OFST-2,sp),a
 643  002c               L312:
 644                     ; 104   return status;
 646  002c 7b01          	ld	a,(OFST-2,sp)
 649  002e 5b03          	addw	sp,#3
 650  0030 81            	ret	
 696                     ; 107 u8 DS3231M_DisableOsc(void)
 696                     ; 108 {
 697                     .text:	section	.text,new
 698  0000               _DS3231M_DisableOsc:
 700  0000 5203          	subw	sp,#3
 701       00000003      OFST:	set	3
 704                     ; 109   u8 tmp[2], status = 0;
 706                     ; 110   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
 708  0002 4b0e          	push	#14
 709  0004 4bd0          	push	#208
 710  0006 4b01          	push	#1
 711  0008 96            	ldw	x,sp
 712  0009 1c0005        	addw	x,#OFST+2
 713  000c cd0000        	call	_I2C_ReadBytes
 715  000f 5b03          	addw	sp,#3
 716  0011 6b01          	ld	(OFST-2,sp),a
 717                     ; 111   if(!(tmp[0] & nEOSC))  //if nEOSC bit is reset, set it
 719  0013 7b02          	ld	a,(OFST-1,sp)
 720  0015 2b15          	jrmi	L732
 721                     ; 113     tmp[0] |= nEOSC;
 723  0017 aa80          	or	a,#128
 724  0019 6b02          	ld	(OFST-1,sp),a
 725                     ; 114     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
 727  001b 4b0e          	push	#14
 728  001d 4bd0          	push	#208
 729  001f 4b01          	push	#1
 730  0021 96            	ldw	x,sp
 731  0022 1c0005        	addw	x,#OFST+2
 732  0025 cd0000        	call	_I2C_WriteBytes
 734  0028 5b03          	addw	sp,#3
 735  002a 6b01          	ld	(OFST-2,sp),a
 736  002c               L732:
 737                     ; 116   return status;
 739  002c 7b01          	ld	a,(OFST-2,sp)
 742  002e 5b03          	addw	sp,#3
 743  0030 81            	ret	
 790                     ; 119 u8 DS3231M_EnableBBSQW(void)
 790                     ; 120 {
 791                     .text:	section	.text,new
 792  0000               _DS3231M_EnableBBSQW:
 794  0000 5203          	subw	sp,#3
 795       00000003      OFST:	set	3
 798                     ; 121   u8 tmp[2], status = 0;
 800                     ; 122   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
 802  0002 4b0e          	push	#14
 803  0004 4bd0          	push	#208
 804  0006 4b01          	push	#1
 805  0008 96            	ldw	x,sp
 806  0009 1c0005        	addw	x,#OFST+2
 807  000c cd0000        	call	_I2C_ReadBytes
 809  000f 5b03          	addw	sp,#3
 810  0011 6b01          	ld	(OFST-2,sp),a
 811                     ; 123   if(!(tmp[0] & BBSQW))   //if BBSQW bit is reset, set it
 813  0013 7b02          	ld	a,(OFST-1,sp)
 814  0015 a540          	bcp	a,#64
 815  0017 2615          	jrne	L362
 816                     ; 125     tmp[0] |= BBSQW;
 818  0019 aa40          	or	a,#64
 819  001b 6b02          	ld	(OFST-1,sp),a
 820                     ; 126     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
 822  001d 4b0e          	push	#14
 823  001f 4bd0          	push	#208
 824  0021 4b01          	push	#1
 825  0023 96            	ldw	x,sp
 826  0024 1c0005        	addw	x,#OFST+2
 827  0027 cd0000        	call	_I2C_WriteBytes
 829  002a 5b03          	addw	sp,#3
 830  002c 6b01          	ld	(OFST-2,sp),a
 831  002e               L362:
 832                     ; 128   return status;
 834  002e 7b01          	ld	a,(OFST-2,sp)
 837  0030 5b03          	addw	sp,#3
 838  0032 81            	ret	
 885                     ; 131 u8 DS3231M_DisableBBSQW(void)
 885                     ; 132 {
 886                     .text:	section	.text,new
 887  0000               _DS3231M_DisableBBSQW:
 889  0000 5203          	subw	sp,#3
 890       00000003      OFST:	set	3
 893                     ; 133   u8 tmp[2], status = 0;
 895                     ; 134   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
 897  0002 4b0e          	push	#14
 898  0004 4bd0          	push	#208
 899  0006 4b01          	push	#1
 900  0008 96            	ldw	x,sp
 901  0009 1c0005        	addw	x,#OFST+2
 902  000c cd0000        	call	_I2C_ReadBytes
 904  000f 5b03          	addw	sp,#3
 905  0011 6b01          	ld	(OFST-2,sp),a
 906                     ; 135   if(tmp[0] & BBSQW)  //if BBSQW bit is set, reset it
 908  0013 7b02          	ld	a,(OFST-1,sp)
 909  0015 a540          	bcp	a,#64
 910  0017 2715          	jreq	L703
 911                     ; 137     tmp[0] &= (u8)(~BBSQW);
 913  0019 a4bf          	and	a,#191
 914  001b 6b02          	ld	(OFST-1,sp),a
 915                     ; 138     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
 917  001d 4b0e          	push	#14
 918  001f 4bd0          	push	#208
 919  0021 4b01          	push	#1
 920  0023 96            	ldw	x,sp
 921  0024 1c0005        	addw	x,#OFST+2
 922  0027 cd0000        	call	_I2C_WriteBytes
 924  002a 5b03          	addw	sp,#3
 925  002c 6b01          	ld	(OFST-2,sp),a
 926  002e               L703:
 927                     ; 140   return status;
 929  002e 7b01          	ld	a,(OFST-2,sp)
 932  0030 5b03          	addw	sp,#3
 933  0032 81            	ret	
 980                     ; 143 u8 DS3231M_ConvertTemp(void)
 980                     ; 144 {
 981                     .text:	section	.text,new
 982  0000               _DS3231M_ConvertTemp:
 984  0000 5203          	subw	sp,#3
 985       00000003      OFST:	set	3
 988                     ; 145   u8 tmp[2], status = 0;
 990                     ; 146   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
 992  0002 4b0e          	push	#14
 993  0004 4bd0          	push	#208
 994  0006 4b01          	push	#1
 995  0008 96            	ldw	x,sp
 996  0009 1c0005        	addw	x,#OFST+2
 997  000c cd0000        	call	_I2C_ReadBytes
 999  000f 5b03          	addw	sp,#3
1000  0011 6b01          	ld	(OFST-2,sp),a
1001                     ; 147   if(!(tmp[0] & CONV))   //if CONV bit is reset, set it
1003  0013 7b02          	ld	a,(OFST-1,sp)
1004  0015 a520          	bcp	a,#32
1005  0017 2615          	jrne	L333
1006                     ; 149     tmp[0] |= CONV;
1008  0019 aa20          	or	a,#32
1009  001b 6b02          	ld	(OFST-1,sp),a
1010                     ; 150     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
1012  001d 4b0e          	push	#14
1013  001f 4bd0          	push	#208
1014  0021 4b01          	push	#1
1015  0023 96            	ldw	x,sp
1016  0024 1c0005        	addw	x,#OFST+2
1017  0027 cd0000        	call	_I2C_WriteBytes
1019  002a 5b03          	addw	sp,#3
1020  002c 6b01          	ld	(OFST-2,sp),a
1021  002e               L333:
1022                     ; 152   return status;
1024  002e 7b01          	ld	a,(OFST-2,sp)
1027  0030 5b03          	addw	sp,#3
1028  0032 81            	ret	
1074                     ; 155 u8 DS3231M_SetINTCN(void)
1074                     ; 156 {
1075                     .text:	section	.text,new
1076  0000               _DS3231M_SetINTCN:
1078  0000 5203          	subw	sp,#3
1079       00000003      OFST:	set	3
1082                     ; 157   u8 tmp[2], status = 0;
1084                     ; 158   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
1086  0002 4b0e          	push	#14
1087  0004 4bd0          	push	#208
1088  0006 4b01          	push	#1
1089  0008 96            	ldw	x,sp
1090  0009 1c0005        	addw	x,#OFST+2
1091  000c cd0000        	call	_I2C_ReadBytes
1093  000f 5b03          	addw	sp,#3
1094  0011 6b01          	ld	(OFST-2,sp),a
1095                     ; 159   if(!(tmp[0] & INTCN))   //if INTCN bit is reset, set it
1097  0013 7b02          	ld	a,(OFST-1,sp)
1098  0015 a504          	bcp	a,#4
1099  0017 2615          	jrne	L753
1100                     ; 161     tmp[0] |= INTCN;
1102  0019 aa04          	or	a,#4
1103  001b 6b02          	ld	(OFST-1,sp),a
1104                     ; 162     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
1106  001d 4b0e          	push	#14
1107  001f 4bd0          	push	#208
1108  0021 4b01          	push	#1
1109  0023 96            	ldw	x,sp
1110  0024 1c0005        	addw	x,#OFST+2
1111  0027 cd0000        	call	_I2C_WriteBytes
1113  002a 5b03          	addw	sp,#3
1114  002c 6b01          	ld	(OFST-2,sp),a
1115  002e               L753:
1116                     ; 164   return status;
1118  002e 7b01          	ld	a,(OFST-2,sp)
1121  0030 5b03          	addw	sp,#3
1122  0032 81            	ret	
1168                     ; 167 u8 DS3231M_ResetINTCN(void)
1168                     ; 168 {
1169                     .text:	section	.text,new
1170  0000               _DS3231M_ResetINTCN:
1172  0000 5203          	subw	sp,#3
1173       00000003      OFST:	set	3
1176                     ; 169   u8 tmp[2], status = 0;
1178                     ; 170   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
1180  0002 4b0e          	push	#14
1181  0004 4bd0          	push	#208
1182  0006 4b01          	push	#1
1183  0008 96            	ldw	x,sp
1184  0009 1c0005        	addw	x,#OFST+2
1185  000c cd0000        	call	_I2C_ReadBytes
1187  000f 5b03          	addw	sp,#3
1188  0011 6b01          	ld	(OFST-2,sp),a
1189                     ; 171   if(tmp[0] & INTCN)  //if INTCN bit is set, reset it
1191  0013 7b02          	ld	a,(OFST-1,sp)
1192  0015 a504          	bcp	a,#4
1193  0017 2715          	jreq	L304
1194                     ; 173     tmp[0] &= (u8)(~INTCN);
1196  0019 a4fb          	and	a,#251
1197  001b 6b02          	ld	(OFST-1,sp),a
1198                     ; 174     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
1200  001d 4b0e          	push	#14
1201  001f 4bd0          	push	#208
1202  0021 4b01          	push	#1
1203  0023 96            	ldw	x,sp
1204  0024 1c0005        	addw	x,#OFST+2
1205  0027 cd0000        	call	_I2C_WriteBytes
1207  002a 5b03          	addw	sp,#3
1208  002c 6b01          	ld	(OFST-2,sp),a
1209  002e               L304:
1210                     ; 176   return status;
1212  002e 7b01          	ld	a,(OFST-2,sp)
1215  0030 5b03          	addw	sp,#3
1216  0032 81            	ret	
1263                     ; 179 u8 DS3231M_EnableAlarm1Intr(void)
1263                     ; 180 {
1264                     .text:	section	.text,new
1265  0000               _DS3231M_EnableAlarm1Intr:
1267  0000 5203          	subw	sp,#3
1268       00000003      OFST:	set	3
1271                     ; 181   u8 tmp[2], status = 0;
1273                     ; 182   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
1275  0002 4b0e          	push	#14
1276  0004 4bd0          	push	#208
1277  0006 4b01          	push	#1
1278  0008 96            	ldw	x,sp
1279  0009 1c0005        	addw	x,#OFST+2
1280  000c cd0000        	call	_I2C_ReadBytes
1282  000f 5b03          	addw	sp,#3
1283  0011 6b01          	ld	(OFST-2,sp),a
1284                     ; 183   if(!(tmp[0] & A1IE))   //if A1IE bit is reset, set it
1286  0013 7b02          	ld	a,(OFST-1,sp)
1287  0015 a501          	bcp	a,#1
1288  0017 2615          	jrne	L724
1289                     ; 185     tmp[0] |= A1IE;
1291  0019 aa01          	or	a,#1
1292  001b 6b02          	ld	(OFST-1,sp),a
1293                     ; 186     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
1295  001d 4b0e          	push	#14
1296  001f 4bd0          	push	#208
1297  0021 4b01          	push	#1
1298  0023 96            	ldw	x,sp
1299  0024 1c0005        	addw	x,#OFST+2
1300  0027 cd0000        	call	_I2C_WriteBytes
1302  002a 5b03          	addw	sp,#3
1303  002c 6b01          	ld	(OFST-2,sp),a
1304  002e               L724:
1305                     ; 188   return status;
1307  002e 7b01          	ld	a,(OFST-2,sp)
1310  0030 5b03          	addw	sp,#3
1311  0032 81            	ret	
1358                     ; 191 u8 DS3231M_DisableAlarm1Intr(void)
1358                     ; 192 {
1359                     .text:	section	.text,new
1360  0000               _DS3231M_DisableAlarm1Intr:
1362  0000 5203          	subw	sp,#3
1363       00000003      OFST:	set	3
1366                     ; 193   u8 tmp[2], status = 0;
1368                     ; 194   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
1370  0002 4b0e          	push	#14
1371  0004 4bd0          	push	#208
1372  0006 4b01          	push	#1
1373  0008 96            	ldw	x,sp
1374  0009 1c0005        	addw	x,#OFST+2
1375  000c cd0000        	call	_I2C_ReadBytes
1377  000f 5b03          	addw	sp,#3
1378  0011 6b01          	ld	(OFST-2,sp),a
1379                     ; 195   if(tmp[0] & A1IE)  //if A1IE bit is set, reset it
1381  0013 7b02          	ld	a,(OFST-1,sp)
1382  0015 a501          	bcp	a,#1
1383  0017 2715          	jreq	L354
1384                     ; 197     tmp[0] &= (u8)(~A1IE);
1386  0019 a4fe          	and	a,#254
1387  001b 6b02          	ld	(OFST-1,sp),a
1388                     ; 198     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
1390  001d 4b0e          	push	#14
1391  001f 4bd0          	push	#208
1392  0021 4b01          	push	#1
1393  0023 96            	ldw	x,sp
1394  0024 1c0005        	addw	x,#OFST+2
1395  0027 cd0000        	call	_I2C_WriteBytes
1397  002a 5b03          	addw	sp,#3
1398  002c 6b01          	ld	(OFST-2,sp),a
1399  002e               L354:
1400                     ; 200   return status;
1402  002e 7b01          	ld	a,(OFST-2,sp)
1405  0030 5b03          	addw	sp,#3
1406  0032 81            	ret	
1453                     ; 203 u8 DS3231M_EnableAlarm2Intr(void)
1453                     ; 204 {
1454                     .text:	section	.text,new
1455  0000               _DS3231M_EnableAlarm2Intr:
1457  0000 5203          	subw	sp,#3
1458       00000003      OFST:	set	3
1461                     ; 205   u8 tmp[2], status = 0;
1463                     ; 206   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
1465  0002 4b0e          	push	#14
1466  0004 4bd0          	push	#208
1467  0006 4b01          	push	#1
1468  0008 96            	ldw	x,sp
1469  0009 1c0005        	addw	x,#OFST+2
1470  000c cd0000        	call	_I2C_ReadBytes
1472  000f 5b03          	addw	sp,#3
1473  0011 6b01          	ld	(OFST-2,sp),a
1474                     ; 207   if(!(tmp[0] & A2IE))   //if A2IE bit is reset, set it
1476  0013 7b02          	ld	a,(OFST-1,sp)
1477  0015 a502          	bcp	a,#2
1478  0017 2615          	jrne	L774
1479                     ; 209     tmp[0] |= A2IE;
1481  0019 aa02          	or	a,#2
1482  001b 6b02          	ld	(OFST-1,sp),a
1483                     ; 210     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
1485  001d 4b0e          	push	#14
1486  001f 4bd0          	push	#208
1487  0021 4b01          	push	#1
1488  0023 96            	ldw	x,sp
1489  0024 1c0005        	addw	x,#OFST+2
1490  0027 cd0000        	call	_I2C_WriteBytes
1492  002a 5b03          	addw	sp,#3
1493  002c 6b01          	ld	(OFST-2,sp),a
1494  002e               L774:
1495                     ; 212   return status;
1497  002e 7b01          	ld	a,(OFST-2,sp)
1500  0030 5b03          	addw	sp,#3
1501  0032 81            	ret	
1548                     ; 215 u8 DS3231M_DisableAlarm2Intr(void)
1548                     ; 216 {
1549                     .text:	section	.text,new
1550  0000               _DS3231M_DisableAlarm2Intr:
1552  0000 5203          	subw	sp,#3
1553       00000003      OFST:	set	3
1556                     ; 217   u8 tmp[2], status = 0;
1558                     ; 218   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0E);
1560  0002 4b0e          	push	#14
1561  0004 4bd0          	push	#208
1562  0006 4b01          	push	#1
1563  0008 96            	ldw	x,sp
1564  0009 1c0005        	addw	x,#OFST+2
1565  000c cd0000        	call	_I2C_ReadBytes
1567  000f 5b03          	addw	sp,#3
1568  0011 6b01          	ld	(OFST-2,sp),a
1569                     ; 219   if(tmp[0] & A2IE)  //if A2IE bit is set, reset it
1571  0013 7b02          	ld	a,(OFST-1,sp)
1572  0015 a502          	bcp	a,#2
1573  0017 2715          	jreq	L325
1574                     ; 221     tmp[0] &= (u8)(~A2IE);
1576  0019 a4fd          	and	a,#253
1577  001b 6b02          	ld	(OFST-1,sp),a
1578                     ; 222     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0E);
1580  001d 4b0e          	push	#14
1581  001f 4bd0          	push	#208
1582  0021 4b01          	push	#1
1583  0023 96            	ldw	x,sp
1584  0024 1c0005        	addw	x,#OFST+2
1585  0027 cd0000        	call	_I2C_WriteBytes
1587  002a 5b03          	addw	sp,#3
1588  002c 6b01          	ld	(OFST-2,sp),a
1589  002e               L325:
1590                     ; 224   return status;
1592  002e 7b01          	ld	a,(OFST-2,sp)
1595  0030 5b03          	addw	sp,#3
1596  0032 81            	ret	
1642                     ; 228 u8 DS3231M_GetOscStopFlag(void)
1642                     ; 229 {
1643                     .text:	section	.text,new
1644  0000               _DS3231M_GetOscStopFlag:
1646  0000 5203          	subw	sp,#3
1647       00000003      OFST:	set	3
1650                     ; 230   u8 tmp[2], status = 0;
1652                     ; 231   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0F);
1654  0002 4b0f          	push	#15
1655  0004 4bd0          	push	#208
1656  0006 4b01          	push	#1
1657  0008 96            	ldw	x,sp
1658  0009 1c0004        	addw	x,#OFST+1
1659  000c cd0000        	call	_I2C_ReadBytes
1661  000f 5b03          	addw	sp,#3
1662  0011 6b03          	ld	(OFST+0,sp),a
1663                     ; 232   if(!status) return 2;
1665  0013 2604          	jrne	L745
1668  0015 a602          	ld	a,#2
1670  0017 2006          	jra	L241
1671  0019               L745:
1672                     ; 233   if(tmp[0] & OSF) return 1;
1674  0019 7b01          	ld	a,(OFST-2,sp)
1675  001b 2a05          	jrpl	L155
1678  001d a601          	ld	a,#1
1680  001f               L241:
1682  001f 5b03          	addw	sp,#3
1683  0021 81            	ret	
1684  0022               L155:
1685                     ; 234   else return 0;
1687  0022 4f            	clr	a
1689  0023 20fa          	jra	L241
1736                     ; 237 u8 DS3231M_ResetOscStopFlag(void)
1736                     ; 238 {
1737                     .text:	section	.text,new
1738  0000               _DS3231M_ResetOscStopFlag:
1740  0000 5203          	subw	sp,#3
1741       00000003      OFST:	set	3
1744                     ; 239   u8 tmp[2], status = 0;
1746                     ; 240   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0F);
1748  0002 4b0f          	push	#15
1749  0004 4bd0          	push	#208
1750  0006 4b01          	push	#1
1751  0008 96            	ldw	x,sp
1752  0009 1c0005        	addw	x,#OFST+2
1753  000c cd0000        	call	_I2C_ReadBytes
1755  000f 5b03          	addw	sp,#3
1756  0011 6b01          	ld	(OFST-2,sp),a
1757                     ; 241   if(tmp[0] & A2IE)  //if A2IE bit is set, reset it
1759  0013 7b02          	ld	a,(OFST-1,sp)
1760  0015 a502          	bcp	a,#2
1761  0017 2715          	jreq	L775
1762                     ; 243     tmp[0] &= (u8)(~A2IE);
1764  0019 a4fd          	and	a,#253
1765  001b 6b02          	ld	(OFST-1,sp),a
1766                     ; 244     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0F);
1768  001d 4b0f          	push	#15
1769  001f 4bd0          	push	#208
1770  0021 4b01          	push	#1
1771  0023 96            	ldw	x,sp
1772  0024 1c0005        	addw	x,#OFST+2
1773  0027 cd0000        	call	_I2C_WriteBytes
1775  002a 5b03          	addw	sp,#3
1776  002c 6b01          	ld	(OFST-2,sp),a
1777  002e               L775:
1778                     ; 246   return status;
1780  002e 7b01          	ld	a,(OFST-2,sp)
1783  0030 5b03          	addw	sp,#3
1784  0032 81            	ret	
1831                     ; 249 u8 DS3231M_Enable32KHzOut(void)
1831                     ; 250 {
1832                     .text:	section	.text,new
1833  0000               _DS3231M_Enable32KHzOut:
1835  0000 5203          	subw	sp,#3
1836       00000003      OFST:	set	3
1839                     ; 251   u8 tmp[2], status = 0;
1841                     ; 252   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0F);
1843  0002 4b0f          	push	#15
1844  0004 4bd0          	push	#208
1845  0006 4b01          	push	#1
1846  0008 96            	ldw	x,sp
1847  0009 1c0005        	addw	x,#OFST+2
1848  000c cd0000        	call	_I2C_ReadBytes
1850  000f 5b03          	addw	sp,#3
1851  0011 6b01          	ld	(OFST-2,sp),a
1852                     ; 253   if(!(tmp[0] & EN32KHZ))   //if EN32KHZ bit is reset, set it
1854  0013 7b02          	ld	a,(OFST-1,sp)
1855  0015 a508          	bcp	a,#8
1856  0017 2615          	jrne	L326
1857                     ; 255     tmp[0] |= EN32KHZ;
1859  0019 aa08          	or	a,#8
1860  001b 6b02          	ld	(OFST-1,sp),a
1861                     ; 256     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0F);
1863  001d 4b0f          	push	#15
1864  001f 4bd0          	push	#208
1865  0021 4b01          	push	#1
1866  0023 96            	ldw	x,sp
1867  0024 1c0005        	addw	x,#OFST+2
1868  0027 cd0000        	call	_I2C_WriteBytes
1870  002a 5b03          	addw	sp,#3
1871  002c 6b01          	ld	(OFST-2,sp),a
1872  002e               L326:
1873                     ; 258   return status;
1875  002e 7b01          	ld	a,(OFST-2,sp)
1878  0030 5b03          	addw	sp,#3
1879  0032 81            	ret	
1926                     ; 261 u8 DS3231M_Disable32KHzOut(void)
1926                     ; 262 {
1927                     .text:	section	.text,new
1928  0000               _DS3231M_Disable32KHzOut:
1930  0000 5203          	subw	sp,#3
1931       00000003      OFST:	set	3
1934                     ; 263   u8 tmp[2], status = 0;
1936                     ; 264   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0F);
1938  0002 4b0f          	push	#15
1939  0004 4bd0          	push	#208
1940  0006 4b01          	push	#1
1941  0008 96            	ldw	x,sp
1942  0009 1c0005        	addw	x,#OFST+2
1943  000c cd0000        	call	_I2C_ReadBytes
1945  000f 5b03          	addw	sp,#3
1946  0011 6b01          	ld	(OFST-2,sp),a
1947                     ; 265   if(tmp[0] & EN32KHZ)  //if EN32KHZ bit is set, reset it
1949  0013 7b02          	ld	a,(OFST-1,sp)
1950  0015 a508          	bcp	a,#8
1951  0017 2715          	jreq	L746
1952                     ; 267     tmp[0] &= (u8)(~EN32KHZ);
1954  0019 a4f7          	and	a,#247
1955  001b 6b02          	ld	(OFST-1,sp),a
1956                     ; 268     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0F);
1958  001d 4b0f          	push	#15
1959  001f 4bd0          	push	#208
1960  0021 4b01          	push	#1
1961  0023 96            	ldw	x,sp
1962  0024 1c0005        	addw	x,#OFST+2
1963  0027 cd0000        	call	_I2C_WriteBytes
1965  002a 5b03          	addw	sp,#3
1966  002c 6b01          	ld	(OFST-2,sp),a
1967  002e               L746:
1968                     ; 270   return status;
1970  002e 7b01          	ld	a,(OFST-2,sp)
1973  0030 5b03          	addw	sp,#3
1974  0032 81            	ret	
2021                     ; 273 u8 DS3231M_ResetAlarm1(void)
2021                     ; 274 {
2022                     .text:	section	.text,new
2023  0000               _DS3231M_ResetAlarm1:
2025  0000 5203          	subw	sp,#3
2026       00000003      OFST:	set	3
2029                     ; 275   u8 tmp[2], status = 0;
2031                     ; 276   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0F);
2033  0002 4b0f          	push	#15
2034  0004 4bd0          	push	#208
2035  0006 4b01          	push	#1
2036  0008 96            	ldw	x,sp
2037  0009 1c0005        	addw	x,#OFST+2
2038  000c cd0000        	call	_I2C_ReadBytes
2040  000f 5b03          	addw	sp,#3
2041  0011 6b01          	ld	(OFST-2,sp),a
2042                     ; 277   if(tmp[0] & A1F)  //if A1F bit is set, reset it
2044  0013 7b02          	ld	a,(OFST-1,sp)
2045  0015 a501          	bcp	a,#1
2046  0017 2715          	jreq	L376
2047                     ; 279     tmp[0] &= (u8)(~A1F);
2049  0019 a4fe          	and	a,#254
2050  001b 6b02          	ld	(OFST-1,sp),a
2051                     ; 280     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0F);
2053  001d 4b0f          	push	#15
2054  001f 4bd0          	push	#208
2055  0021 4b01          	push	#1
2056  0023 96            	ldw	x,sp
2057  0024 1c0005        	addw	x,#OFST+2
2058  0027 cd0000        	call	_I2C_WriteBytes
2060  002a 5b03          	addw	sp,#3
2061  002c 6b01          	ld	(OFST-2,sp),a
2062  002e               L376:
2063                     ; 282   return status;
2065  002e 7b01          	ld	a,(OFST-2,sp)
2068  0030 5b03          	addw	sp,#3
2069  0032 81            	ret	
2116                     ; 285 u8 DS3231M_ResetAlarm2(void)
2116                     ; 286 {
2117                     .text:	section	.text,new
2118  0000               _DS3231M_ResetAlarm2:
2120  0000 5203          	subw	sp,#3
2121       00000003      OFST:	set	3
2124                     ; 287   u8 tmp[2], status = 0;
2126                     ; 288   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0F);
2128  0002 4b0f          	push	#15
2129  0004 4bd0          	push	#208
2130  0006 4b01          	push	#1
2131  0008 96            	ldw	x,sp
2132  0009 1c0005        	addw	x,#OFST+2
2133  000c cd0000        	call	_I2C_ReadBytes
2135  000f 5b03          	addw	sp,#3
2136  0011 6b01          	ld	(OFST-2,sp),a
2137                     ; 289   if(tmp[0] & A2F)  //if A2F bit is set, reset it
2139  0013 7b02          	ld	a,(OFST-1,sp)
2140  0015 a502          	bcp	a,#2
2141  0017 2715          	jreq	L717
2142                     ; 291     tmp[0] &= (u8)(~A2F);
2144  0019 a4fd          	and	a,#253
2145  001b 6b02          	ld	(OFST-1,sp),a
2146                     ; 292     status = I2C_WriteBytes(tmp, 1, DS3231M_ADR, 0x0F);
2148  001d 4b0f          	push	#15
2149  001f 4bd0          	push	#208
2150  0021 4b01          	push	#1
2151  0023 96            	ldw	x,sp
2152  0024 1c0005        	addw	x,#OFST+2
2153  0027 cd0000        	call	_I2C_WriteBytes
2155  002a 5b03          	addw	sp,#3
2156  002c 6b01          	ld	(OFST-2,sp),a
2157  002e               L717:
2158                     ; 294   return status;
2160  002e 7b01          	ld	a,(OFST-2,sp)
2163  0030 5b03          	addw	sp,#3
2164  0032 81            	ret	
2210                     ; 297 u8 DS3231M_GetBusyFlag(void)
2210                     ; 298 {
2211                     .text:	section	.text,new
2212  0000               _DS3231M_GetBusyFlag:
2214  0000 5203          	subw	sp,#3
2215       00000003      OFST:	set	3
2218                     ; 299   u8 tmp[2], status = 0;
2220                     ; 300   status = I2C_ReadBytes(tmp, 1, DS3231M_ADR, 0x0F);
2222  0002 4b0f          	push	#15
2223  0004 4bd0          	push	#208
2224  0006 4b01          	push	#1
2225  0008 96            	ldw	x,sp
2226  0009 1c0004        	addw	x,#OFST+1
2227  000c cd0000        	call	_I2C_ReadBytes
2229  000f 5b03          	addw	sp,#3
2230  0011 6b03          	ld	(OFST+0,sp),a
2231                     ; 301   if(!status) return 2;
2233  0013 2604          	jrne	L347
2236  0015 a602          	ld	a,#2
2238  0017 2008          	jra	L602
2239  0019               L347:
2240                     ; 302   if(tmp[0] & BSY) return 1;
2242  0019 7b01          	ld	a,(OFST-2,sp)
2243  001b a504          	bcp	a,#4
2244  001d 2705          	jreq	L547
2247  001f a601          	ld	a,#1
2249  0021               L602:
2251  0021 5b03          	addw	sp,#3
2252  0023 81            	ret	
2253  0024               L547:
2254                     ; 303   else return 0;
2256  0024 4f            	clr	a
2258  0025 20fa          	jra	L602
2345                     	xdef	_DS3231M_GetBusyFlag
2346                     	xdef	_DS3231M_ResetAlarm2
2347                     	xdef	_DS3231M_ResetAlarm1
2348                     	xdef	_DS3231M_Disable32KHzOut
2349                     	xdef	_DS3231M_Enable32KHzOut
2350                     	xdef	_DS3231M_ResetOscStopFlag
2351                     	xdef	_DS3231M_GetOscStopFlag
2352                     	xdef	_DS3231M_DisableAlarm2Intr
2353                     	xdef	_DS3231M_EnableAlarm2Intr
2354                     	xdef	_DS3231M_DisableAlarm1Intr
2355                     	xdef	_DS3231M_EnableAlarm1Intr
2356                     	xdef	_DS3231M_ResetINTCN
2357                     	xdef	_DS3231M_SetINTCN
2358                     	xdef	_DS3231M_ConvertTemp
2359                     	xdef	_DS3231M_DisableBBSQW
2360                     	xdef	_DS3231M_EnableBBSQW
2361                     	xdef	_DS3231M_DisableOsc
2362                     	xdef	_DS3231M_EnableOsc
2363                     	xdef	_DS3231M_SetDate
2364                     	xdef	_DS3231M_SetTime
2365                     	xdef	_DS3231M_GetTemperature
2366                     	xdef	_DS3231M_GetDate
2367                     	xdef	_DS3231M_GetTime
2368                     	xdef	_DS3231M_Flush
2369                     	xdef	_RTC_temp
2370                     	xdef	_RTC_year
2371                     	xdef	_RTC_month
2372                     	xdef	_RTC_date
2373                     	xdef	_RTC_day
2374                     	xdef	_RTC_hour
2375                     	xdef	_RTC_min
2376                     	xdef	_RTC_sec
2377                     	xref	_I2C_ReadBytes
2378                     	xref	_I2C_WriteBytes
2379                     	xref	_I2C_Flush
2398                     	end
