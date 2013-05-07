   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
  17                     .const:	section	.text
  18  0000               _HSIDivFactor:
  19  0000 01            	dc.b	1
  20  0001 02            	dc.b	2
  21  0002 04            	dc.b	4
  22  0003 08            	dc.b	8
  23  0004               _CLKPrescTable:
  24  0004 01            	dc.b	1
  25  0005 02            	dc.b	2
  26  0006 04            	dc.b	4
  27  0007 08            	dc.b	8
  28  0008 0a            	dc.b	10
  29  0009 10            	dc.b	16
  30  000a 14            	dc.b	20
  31  000b 28            	dc.b	40
  60                     ; 66 void CLK_DeInit(void)
  60                     ; 67 {
  62                     .text:	section	.text,new
  63  0000               _CLK_DeInit:
  67                     ; 69     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  69  0000 350150c0      	mov	20672,#1
  70                     ; 70     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  72  0004 725f50c1      	clr	20673
  73                     ; 71     CLK->SWR  = CLK_SWR_RESET_VALUE;
  75  0008 35e150c4      	mov	20676,#225
  76                     ; 72     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  78  000c 725f50c5      	clr	20677
  79                     ; 73     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  81  0010 351850c6      	mov	20678,#24
  82                     ; 74     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  84  0014 35ff50c7      	mov	20679,#255
  85                     ; 75     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  87  0018 35ff50ca      	mov	20682,#255
  88                     ; 76     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  90  001c 725f50c8      	clr	20680
  91                     ; 77     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  93  0020 725f50c9      	clr	20681
  95  0024               L52:
  96                     ; 78     while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
  98  0024 c650c9        	ld	a,20681
  99  0027 a501          	bcp	a,#1
 100  0029 26f9          	jrne	L52
 101                     ; 80     CLK->CCOR = CLK_CCOR_RESET_VALUE;
 103  002b 725f50c9      	clr	20681
 104                     ; 81     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 106  002f 725f50cc      	clr	20684
 107                     ; 82     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 109  0033 725f50cd      	clr	20685
 110                     ; 84 }
 113  0037 81            	ret
 169                     ; 95 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 169                     ; 96 {
 170                     .text:	section	.text,new
 171  0000               _CLK_FastHaltWakeUpCmd:
 175                     ; 99     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 177                     ; 101     if (NewState != DISABLE)
 179  0000 4d            	tnz	a
 180  0001 2706          	jreq	L75
 181                     ; 104         CLK->ICKR |= CLK_ICKR_FHWU;
 183  0003 721450c0      	bset	20672,#2
 185  0007 2004          	jra	L16
 186  0009               L75:
 187                     ; 109         CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 189  0009 721550c0      	bres	20672,#2
 190  000d               L16:
 191                     ; 112 }
 194  000d 81            	ret
 229                     ; 119 void CLK_HSECmd(FunctionalState NewState)
 229                     ; 120 {
 230                     .text:	section	.text,new
 231  0000               _CLK_HSECmd:
 235                     ; 123     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 237                     ; 125     if (NewState != DISABLE)
 239  0000 4d            	tnz	a
 240  0001 2706          	jreq	L101
 241                     ; 128         CLK->ECKR |= CLK_ECKR_HSEEN;
 243  0003 721050c1      	bset	20673,#0
 245  0007 2004          	jra	L301
 246  0009               L101:
 247                     ; 133         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 249  0009 721150c1      	bres	20673,#0
 250  000d               L301:
 251                     ; 136 }
 254  000d 81            	ret
 289                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 289                     ; 144 {
 290                     .text:	section	.text,new
 291  0000               _CLK_HSICmd:
 295                     ; 147     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 297                     ; 149     if (NewState != DISABLE)
 299  0000 4d            	tnz	a
 300  0001 2706          	jreq	L321
 301                     ; 152         CLK->ICKR |= CLK_ICKR_HSIEN;
 303  0003 721050c0      	bset	20672,#0
 305  0007 2004          	jra	L521
 306  0009               L321:
 307                     ; 157         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 309  0009 721150c0      	bres	20672,#0
 310  000d               L521:
 311                     ; 160 }
 314  000d 81            	ret
 349                     ; 167 void CLK_LSICmd(FunctionalState NewState)
 349                     ; 168 {
 350                     .text:	section	.text,new
 351  0000               _CLK_LSICmd:
 355                     ; 171     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 357                     ; 173     if (NewState != DISABLE)
 359  0000 4d            	tnz	a
 360  0001 2706          	jreq	L541
 361                     ; 176         CLK->ICKR |= CLK_ICKR_LSIEN;
 363  0003 721650c0      	bset	20672,#3
 365  0007 2004          	jra	L741
 366  0009               L541:
 367                     ; 181         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 369  0009 721750c0      	bres	20672,#3
 370  000d               L741:
 371                     ; 184 }
 374  000d 81            	ret
 409                     ; 192 void CLK_CCOCmd(FunctionalState NewState)
 409                     ; 193 {
 410                     .text:	section	.text,new
 411  0000               _CLK_CCOCmd:
 415                     ; 196     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 417                     ; 198     if (NewState != DISABLE)
 419  0000 4d            	tnz	a
 420  0001 2706          	jreq	L761
 421                     ; 201         CLK->CCOR |= CLK_CCOR_CCOEN;
 423  0003 721050c9      	bset	20681,#0
 425  0007 2004          	jra	L171
 426  0009               L761:
 427                     ; 206         CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 429  0009 721150c9      	bres	20681,#0
 430  000d               L171:
 431                     ; 209 }
 434  000d 81            	ret
 469                     ; 218 void CLK_ClockSwitchCmd(FunctionalState NewState)
 469                     ; 219 {
 470                     .text:	section	.text,new
 471  0000               _CLK_ClockSwitchCmd:
 475                     ; 222     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 477                     ; 224     if (NewState != DISABLE )
 479  0000 4d            	tnz	a
 480  0001 2706          	jreq	L112
 481                     ; 227         CLK->SWCR |= CLK_SWCR_SWEN;
 483  0003 721250c5      	bset	20677,#1
 485  0007 2004          	jra	L312
 486  0009               L112:
 487                     ; 232         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 489  0009 721350c5      	bres	20677,#1
 490  000d               L312:
 491                     ; 235 }
 494  000d 81            	ret
 530                     ; 245 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 530                     ; 246 {
 531                     .text:	section	.text,new
 532  0000               _CLK_SlowActiveHaltWakeUpCmd:
 536                     ; 249     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 538                     ; 251     if (NewState != DISABLE)
 540  0000 4d            	tnz	a
 541  0001 2706          	jreq	L332
 542                     ; 254         CLK->ICKR |= CLK_ICKR_SWUAH;
 544  0003 721a50c0      	bset	20672,#5
 546  0007 2004          	jra	L532
 547  0009               L332:
 548                     ; 259         CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 550  0009 721b50c0      	bres	20672,#5
 551  000d               L532:
 552                     ; 262 }
 555  000d 81            	ret
 714                     ; 272 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 714                     ; 273 {
 715                     .text:	section	.text,new
 716  0000               _CLK_PeripheralClockConfig:
 718  0000 89            	pushw	x
 719       00000000      OFST:	set	0
 722                     ; 276     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 724                     ; 277     assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 726                     ; 279     if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 728  0001 9e            	ld	a,xh
 729  0002 a510          	bcp	a,#16
 730  0004 2633          	jrne	L123
 731                     ; 281         if (NewState != DISABLE)
 733  0006 0d02          	tnz	(OFST+2,sp)
 734  0008 2717          	jreq	L323
 735                     ; 284             CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 737  000a 7b01          	ld	a,(OFST+1,sp)
 738  000c a40f          	and	a,#15
 739  000e 5f            	clrw	x
 740  000f 97            	ld	xl,a
 741  0010 a601          	ld	a,#1
 742  0012 5d            	tnzw	x
 743  0013 2704          	jreq	L62
 744  0015               L03:
 745  0015 48            	sll	a
 746  0016 5a            	decw	x
 747  0017 26fc          	jrne	L03
 748  0019               L62:
 749  0019 ca50c7        	or	a,20679
 750  001c c750c7        	ld	20679,a
 752  001f 2049          	jra	L723
 753  0021               L323:
 754                     ; 289             CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 756  0021 7b01          	ld	a,(OFST+1,sp)
 757  0023 a40f          	and	a,#15
 758  0025 5f            	clrw	x
 759  0026 97            	ld	xl,a
 760  0027 a601          	ld	a,#1
 761  0029 5d            	tnzw	x
 762  002a 2704          	jreq	L23
 763  002c               L43:
 764  002c 48            	sll	a
 765  002d 5a            	decw	x
 766  002e 26fc          	jrne	L43
 767  0030               L23:
 768  0030 43            	cpl	a
 769  0031 c450c7        	and	a,20679
 770  0034 c750c7        	ld	20679,a
 771  0037 2031          	jra	L723
 772  0039               L123:
 773                     ; 294         if (NewState != DISABLE)
 775  0039 0d02          	tnz	(OFST+2,sp)
 776  003b 2717          	jreq	L133
 777                     ; 297             CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 779  003d 7b01          	ld	a,(OFST+1,sp)
 780  003f a40f          	and	a,#15
 781  0041 5f            	clrw	x
 782  0042 97            	ld	xl,a
 783  0043 a601          	ld	a,#1
 784  0045 5d            	tnzw	x
 785  0046 2704          	jreq	L63
 786  0048               L04:
 787  0048 48            	sll	a
 788  0049 5a            	decw	x
 789  004a 26fc          	jrne	L04
 790  004c               L63:
 791  004c ca50ca        	or	a,20682
 792  004f c750ca        	ld	20682,a
 794  0052 2016          	jra	L723
 795  0054               L133:
 796                     ; 302             CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 798  0054 7b01          	ld	a,(OFST+1,sp)
 799  0056 a40f          	and	a,#15
 800  0058 5f            	clrw	x
 801  0059 97            	ld	xl,a
 802  005a a601          	ld	a,#1
 803  005c 5d            	tnzw	x
 804  005d 2704          	jreq	L24
 805  005f               L44:
 806  005f 48            	sll	a
 807  0060 5a            	decw	x
 808  0061 26fc          	jrne	L44
 809  0063               L24:
 810  0063 43            	cpl	a
 811  0064 c450ca        	and	a,20682
 812  0067 c750ca        	ld	20682,a
 813  006a               L723:
 814                     ; 306 }
 817  006a 85            	popw	x
 818  006b 81            	ret
1006                     ; 319 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
1006                     ; 320 {
1007                     .text:	section	.text,new
1008  0000               _CLK_ClockSwitchConfig:
1010  0000 89            	pushw	x
1011  0001 5204          	subw	sp,#4
1012       00000004      OFST:	set	4
1015                     ; 323     uint16_t DownCounter = CLK_TIMEOUT;
1017  0003 ae0491        	ldw	x,#1169
1018  0006 1f03          	ldw	(OFST-1,sp),x
1019                     ; 324     ErrorStatus Swif = ERROR;
1021                     ; 327     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1023                     ; 328     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1025                     ; 329     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1027                     ; 330     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1029                     ; 333     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1031  0008 c650c3        	ld	a,20675
1032  000b 6b01          	ld	(OFST-3,sp),a
1033                     ; 336     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1035  000d 7b05          	ld	a,(OFST+1,sp)
1036  000f a101          	cp	a,#1
1037  0011 2639          	jrne	L544
1038                     ; 340         CLK->SWCR |= CLK_SWCR_SWEN;
1040  0013 721250c5      	bset	20677,#1
1041                     ; 343         if (ITState != DISABLE)
1043  0017 0d09          	tnz	(OFST+5,sp)
1044  0019 2706          	jreq	L744
1045                     ; 345             CLK->SWCR |= CLK_SWCR_SWIEN;
1047  001b 721450c5      	bset	20677,#2
1049  001f 2004          	jra	L154
1050  0021               L744:
1051                     ; 349             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1053  0021 721550c5      	bres	20677,#2
1054  0025               L154:
1055                     ; 353         CLK->SWR = (uint8_t)CLK_NewClock;
1057  0025 7b06          	ld	a,(OFST+2,sp)
1058  0027 c750c4        	ld	20676,a
1060  002a 2007          	jra	L754
1061  002c               L354:
1062                     ; 357             DownCounter--;
1064  002c 1e03          	ldw	x,(OFST-1,sp)
1065  002e 1d0001        	subw	x,#1
1066  0031 1f03          	ldw	(OFST-1,sp),x
1067  0033               L754:
1068                     ; 355         while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1070  0033 c650c5        	ld	a,20677
1071  0036 a501          	bcp	a,#1
1072  0038 2704          	jreq	L364
1074  003a 1e03          	ldw	x,(OFST-1,sp)
1075  003c 26ee          	jrne	L354
1076  003e               L364:
1077                     ; 360         if (DownCounter != 0)
1079  003e 1e03          	ldw	x,(OFST-1,sp)
1080  0040 2706          	jreq	L564
1081                     ; 362             Swif = SUCCESS;
1083  0042 a601          	ld	a,#1
1084  0044 6b02          	ld	(OFST-2,sp),a
1086  0046 201b          	jra	L174
1087  0048               L564:
1088                     ; 366             Swif = ERROR;
1090  0048 0f02          	clr	(OFST-2,sp)
1091  004a 2017          	jra	L174
1092  004c               L544:
1093                     ; 374         if (ITState != DISABLE)
1095  004c 0d09          	tnz	(OFST+5,sp)
1096  004e 2706          	jreq	L374
1097                     ; 376             CLK->SWCR |= CLK_SWCR_SWIEN;
1099  0050 721450c5      	bset	20677,#2
1101  0054 2004          	jra	L574
1102  0056               L374:
1103                     ; 380             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1105  0056 721550c5      	bres	20677,#2
1106  005a               L574:
1107                     ; 384         CLK->SWR = (uint8_t)CLK_NewClock;
1109  005a 7b06          	ld	a,(OFST+2,sp)
1110  005c c750c4        	ld	20676,a
1111                     ; 388         Swif = SUCCESS;
1113  005f a601          	ld	a,#1
1114  0061 6b02          	ld	(OFST-2,sp),a
1115  0063               L174:
1116                     ; 393     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1118  0063 0d0a          	tnz	(OFST+6,sp)
1119  0065 260c          	jrne	L774
1121  0067 7b01          	ld	a,(OFST-3,sp)
1122  0069 a1e1          	cp	a,#225
1123  006b 2606          	jrne	L774
1124                     ; 395         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1126  006d 721150c0      	bres	20672,#0
1128  0071 201e          	jra	L105
1129  0073               L774:
1130                     ; 397     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1132  0073 0d0a          	tnz	(OFST+6,sp)
1133  0075 260c          	jrne	L305
1135  0077 7b01          	ld	a,(OFST-3,sp)
1136  0079 a1d2          	cp	a,#210
1137  007b 2606          	jrne	L305
1138                     ; 399         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1140  007d 721750c0      	bres	20672,#3
1142  0081 200e          	jra	L105
1143  0083               L305:
1144                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1146  0083 0d0a          	tnz	(OFST+6,sp)
1147  0085 260a          	jrne	L105
1149  0087 7b01          	ld	a,(OFST-3,sp)
1150  0089 a1b4          	cp	a,#180
1151  008b 2604          	jrne	L105
1152                     ; 403         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1154  008d 721150c1      	bres	20673,#0
1155  0091               L105:
1156                     ; 406     return(Swif);
1158  0091 7b02          	ld	a,(OFST-2,sp)
1161  0093 5b06          	addw	sp,#6
1162  0095 81            	ret
1300                     ; 416 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1300                     ; 417 {
1301                     .text:	section	.text,new
1302  0000               _CLK_HSIPrescalerConfig:
1304  0000 88            	push	a
1305       00000000      OFST:	set	0
1308                     ; 420     assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1310                     ; 423     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1312  0001 c650c6        	ld	a,20678
1313  0004 a4e7          	and	a,#231
1314  0006 c750c6        	ld	20678,a
1315                     ; 426     CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1317  0009 c650c6        	ld	a,20678
1318  000c 1a01          	or	a,(OFST+1,sp)
1319  000e c750c6        	ld	20678,a
1320                     ; 428 }
1323  0011 84            	pop	a
1324  0012 81            	ret
1459                     ; 439 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1459                     ; 440 {
1460                     .text:	section	.text,new
1461  0000               _CLK_CCOConfig:
1463  0000 88            	push	a
1464       00000000      OFST:	set	0
1467                     ; 443     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1469                     ; 446     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1471  0001 c650c9        	ld	a,20681
1472  0004 a4e1          	and	a,#225
1473  0006 c750c9        	ld	20681,a
1474                     ; 449     CLK->CCOR |= (uint8_t)CLK_CCO;
1476  0009 c650c9        	ld	a,20681
1477  000c 1a01          	or	a,(OFST+1,sp)
1478  000e c750c9        	ld	20681,a
1479                     ; 452     CLK->CCOR |= CLK_CCOR_CCOEN;
1481  0011 721050c9      	bset	20681,#0
1482                     ; 454 }
1485  0015 84            	pop	a
1486  0016 81            	ret
1551                     ; 464 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1551                     ; 465 {
1552                     .text:	section	.text,new
1553  0000               _CLK_ITConfig:
1555  0000 89            	pushw	x
1556       00000000      OFST:	set	0
1559                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1561                     ; 469     assert_param(IS_CLK_IT_OK(CLK_IT));
1563                     ; 471     if (NewState != DISABLE)
1565  0001 9f            	ld	a,xl
1566  0002 4d            	tnz	a
1567  0003 2719          	jreq	L507
1568                     ; 473         switch (CLK_IT)
1570  0005 9e            	ld	a,xh
1572                     ; 481         default:
1572                     ; 482             break;
1573  0006 a00c          	sub	a,#12
1574  0008 270a          	jreq	L146
1575  000a a010          	sub	a,#16
1576  000c 2624          	jrne	L317
1577                     ; 475         case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1577                     ; 476             CLK->SWCR |= CLK_SWCR_SWIEN;
1579  000e 721450c5      	bset	20677,#2
1580                     ; 477             break;
1582  0012 201e          	jra	L317
1583  0014               L146:
1584                     ; 478         case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1584                     ; 479             CLK->CSSR |= CLK_CSSR_CSSDIE;
1586  0014 721450c8      	bset	20680,#2
1587                     ; 480             break;
1589  0018 2018          	jra	L317
1590  001a               L346:
1591                     ; 481         default:
1591                     ; 482             break;
1593  001a 2016          	jra	L317
1594  001c               L117:
1596  001c 2014          	jra	L317
1597  001e               L507:
1598                     ; 487         switch (CLK_IT)
1600  001e 7b01          	ld	a,(OFST+1,sp)
1602                     ; 495         default:
1602                     ; 496             break;
1603  0020 a00c          	sub	a,#12
1604  0022 270a          	jreq	L746
1605  0024 a010          	sub	a,#16
1606  0026 260a          	jrne	L317
1607                     ; 489         case CLK_IT_SWIF: /* Disable the clock switch interrupt */
1607                     ; 490             CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
1609  0028 721550c5      	bres	20677,#2
1610                     ; 491             break;
1612  002c 2004          	jra	L317
1613  002e               L746:
1614                     ; 492         case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
1614                     ; 493             CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
1616  002e 721550c8      	bres	20680,#2
1617                     ; 494             break;
1618  0032               L317:
1619                     ; 500 }
1622  0032 85            	popw	x
1623  0033 81            	ret
1624  0034               L156:
1625                     ; 495         default:
1625                     ; 496             break;
1627  0034 20fc          	jra	L317
1628  0036               L717:
1629  0036 20fa          	jra	L317
1664                     ; 507 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
1664                     ; 508 {
1665                     .text:	section	.text,new
1666  0000               _CLK_SYSCLKConfig:
1668  0000 88            	push	a
1669       00000000      OFST:	set	0
1672                     ; 511     assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
1674                     ; 513     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
1676  0001 a580          	bcp	a,#128
1677  0003 2614          	jrne	L737
1678                     ; 515         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1680  0005 c650c6        	ld	a,20678
1681  0008 a4e7          	and	a,#231
1682  000a c750c6        	ld	20678,a
1683                     ; 516         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
1685  000d 7b01          	ld	a,(OFST+1,sp)
1686  000f a418          	and	a,#24
1687  0011 ca50c6        	or	a,20678
1688  0014 c750c6        	ld	20678,a
1690  0017 2012          	jra	L147
1691  0019               L737:
1692                     ; 520         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
1694  0019 c650c6        	ld	a,20678
1695  001c a4f8          	and	a,#248
1696  001e c750c6        	ld	20678,a
1697                     ; 521         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
1699  0021 7b01          	ld	a,(OFST+1,sp)
1700  0023 a407          	and	a,#7
1701  0025 ca50c6        	or	a,20678
1702  0028 c750c6        	ld	20678,a
1703  002b               L147:
1704                     ; 524 }
1707  002b 84            	pop	a
1708  002c 81            	ret
1764                     ; 531 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
1764                     ; 532 {
1765                     .text:	section	.text,new
1766  0000               _CLK_SWIMConfig:
1770                     ; 535     assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
1772                     ; 537     if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
1774  0000 4d            	tnz	a
1775  0001 2706          	jreq	L177
1776                     ; 540         CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
1778  0003 721050cd      	bset	20685,#0
1780  0007 2004          	jra	L377
1781  0009               L177:
1782                     ; 545         CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
1784  0009 721150cd      	bres	20685,#0
1785  000d               L377:
1786                     ; 548 }
1789  000d 81            	ret
1813                     ; 557 void CLK_ClockSecuritySystemEnable(void)
1813                     ; 558 {
1814                     .text:	section	.text,new
1815  0000               _CLK_ClockSecuritySystemEnable:
1819                     ; 560     CLK->CSSR |= CLK_CSSR_CSSEN;
1821  0000 721050c8      	bset	20680,#0
1822                     ; 561 }
1825  0004 81            	ret
1850                     ; 569 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
1850                     ; 570 {
1851                     .text:	section	.text,new
1852  0000               _CLK_GetSYSCLKSource:
1856                     ; 571     return((CLK_Source_TypeDef)CLK->CMSR);
1858  0000 c650c3        	ld	a,20675
1861  0003 81            	ret
1924                     ; 579 uint32_t CLK_GetClockFreq(void)
1924                     ; 580 {
1925                     .text:	section	.text,new
1926  0000               _CLK_GetClockFreq:
1928  0000 5209          	subw	sp,#9
1929       00000009      OFST:	set	9
1932                     ; 582     uint32_t clockfrequency = 0;
1934                     ; 583     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
1936                     ; 584     uint8_t tmp = 0, presc = 0;
1940                     ; 587     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
1942  0002 c650c3        	ld	a,20675
1943  0005 6b09          	ld	(OFST+0,sp),a
1944                     ; 589     if (clocksource == CLK_SOURCE_HSI)
1946  0007 7b09          	ld	a,(OFST+0,sp)
1947  0009 a1e1          	cp	a,#225
1948  000b 2641          	jrne	L7401
1949                     ; 591         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
1951  000d c650c6        	ld	a,20678
1952  0010 a418          	and	a,#24
1953  0012 6b09          	ld	(OFST+0,sp),a
1954                     ; 592         tmp = (uint8_t)(tmp >> 3);
1956  0014 0409          	srl	(OFST+0,sp)
1957  0016 0409          	srl	(OFST+0,sp)
1958  0018 0409          	srl	(OFST+0,sp)
1959                     ; 593         presc = HSIDivFactor[tmp];
1961  001a 7b09          	ld	a,(OFST+0,sp)
1962  001c 5f            	clrw	x
1963  001d 97            	ld	xl,a
1964  001e d60000        	ld	a,(_HSIDivFactor,x)
1965  0021 6b09          	ld	(OFST+0,sp),a
1966                     ; 594         clockfrequency = HSI_VALUE / presc;
1968  0023 7b09          	ld	a,(OFST+0,sp)
1969  0025 b703          	ld	c_lreg+3,a
1970  0027 3f02          	clr	c_lreg+2
1971  0029 3f01          	clr	c_lreg+1
1972  002b 3f00          	clr	c_lreg
1973  002d 96            	ldw	x,sp
1974  002e 1c0001        	addw	x,#OFST-8
1975  0031 cd0000        	call	c_rtol
1977  0034 ae2400        	ldw	x,#9216
1978  0037 bf02          	ldw	c_lreg+2,x
1979  0039 ae00f4        	ldw	x,#244
1980  003c bf00          	ldw	c_lreg,x
1981  003e 96            	ldw	x,sp
1982  003f 1c0001        	addw	x,#OFST-8
1983  0042 cd0000        	call	c_ludv
1985  0045 96            	ldw	x,sp
1986  0046 1c0005        	addw	x,#OFST-4
1987  0049 cd0000        	call	c_rtol
1990  004c 201c          	jra	L1501
1991  004e               L7401:
1992                     ; 596     else if ( clocksource == CLK_SOURCE_LSI)
1994  004e 7b09          	ld	a,(OFST+0,sp)
1995  0050 a1d2          	cp	a,#210
1996  0052 260c          	jrne	L3501
1997                     ; 598         clockfrequency = LSI_VALUE;
1999  0054 aef400        	ldw	x,#62464
2000  0057 1f07          	ldw	(OFST-2,sp),x
2001  0059 ae0001        	ldw	x,#1
2002  005c 1f05          	ldw	(OFST-4,sp),x
2004  005e 200a          	jra	L1501
2005  0060               L3501:
2006                     ; 602         clockfrequency = HSE_VALUE;
2008  0060 ae2400        	ldw	x,#9216
2009  0063 1f07          	ldw	(OFST-2,sp),x
2010  0065 ae00f4        	ldw	x,#244
2011  0068 1f05          	ldw	(OFST-4,sp),x
2012  006a               L1501:
2013                     ; 605     return((uint32_t)clockfrequency);
2015  006a 96            	ldw	x,sp
2016  006b 1c0005        	addw	x,#OFST-4
2017  006e cd0000        	call	c_ltor
2021  0071 5b09          	addw	sp,#9
2022  0073 81            	ret
2121                     ; 616 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2121                     ; 617 {
2122                     .text:	section	.text,new
2123  0000               _CLK_AdjustHSICalibrationValue:
2125  0000 88            	push	a
2126       00000000      OFST:	set	0
2129                     ; 620     assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2131                     ; 623     CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2133  0001 c650cc        	ld	a,20684
2134  0004 a4f8          	and	a,#248
2135  0006 1a01          	or	a,(OFST+1,sp)
2136  0008 c750cc        	ld	20684,a
2137                     ; 625 }
2140  000b 84            	pop	a
2141  000c 81            	ret
2165                     ; 636 void CLK_SYSCLKEmergencyClear(void)
2165                     ; 637 {
2166                     .text:	section	.text,new
2167  0000               _CLK_SYSCLKEmergencyClear:
2171                     ; 638     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2173  0000 721150c5      	bres	20677,#0
2174                     ; 639 }
2177  0004 81            	ret
2330                     ; 648 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2330                     ; 649 {
2331                     .text:	section	.text,new
2332  0000               _CLK_GetFlagStatus:
2334  0000 89            	pushw	x
2335  0001 5203          	subw	sp,#3
2336       00000003      OFST:	set	3
2339                     ; 651     uint16_t statusreg = 0;
2341                     ; 652     uint8_t tmpreg = 0;
2343                     ; 653     FlagStatus bitstatus = RESET;
2345                     ; 656     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2347                     ; 659     statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2349  0003 01            	rrwa	x,a
2350  0004 9f            	ld	a,xl
2351  0005 a4ff          	and	a,#255
2352  0007 97            	ld	xl,a
2353  0008 4f            	clr	a
2354  0009 02            	rlwa	x,a
2355  000a 1f01          	ldw	(OFST-2,sp),x
2356  000c 01            	rrwa	x,a
2357                     ; 662     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2359  000d 1e01          	ldw	x,(OFST-2,sp)
2360  000f a30100        	cpw	x,#256
2361  0012 2607          	jrne	L1221
2362                     ; 664         tmpreg = CLK->ICKR;
2364  0014 c650c0        	ld	a,20672
2365  0017 6b03          	ld	(OFST+0,sp),a
2367  0019 202f          	jra	L3221
2368  001b               L1221:
2369                     ; 666     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2371  001b 1e01          	ldw	x,(OFST-2,sp)
2372  001d a30200        	cpw	x,#512
2373  0020 2607          	jrne	L5221
2374                     ; 668         tmpreg = CLK->ECKR;
2376  0022 c650c1        	ld	a,20673
2377  0025 6b03          	ld	(OFST+0,sp),a
2379  0027 2021          	jra	L3221
2380  0029               L5221:
2381                     ; 670     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2383  0029 1e01          	ldw	x,(OFST-2,sp)
2384  002b a30300        	cpw	x,#768
2385  002e 2607          	jrne	L1321
2386                     ; 672         tmpreg = CLK->SWCR;
2388  0030 c650c5        	ld	a,20677
2389  0033 6b03          	ld	(OFST+0,sp),a
2391  0035 2013          	jra	L3221
2392  0037               L1321:
2393                     ; 674     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2395  0037 1e01          	ldw	x,(OFST-2,sp)
2396  0039 a30400        	cpw	x,#1024
2397  003c 2607          	jrne	L5321
2398                     ; 676         tmpreg = CLK->CSSR;
2400  003e c650c8        	ld	a,20680
2401  0041 6b03          	ld	(OFST+0,sp),a
2403  0043 2005          	jra	L3221
2404  0045               L5321:
2405                     ; 680         tmpreg = CLK->CCOR;
2407  0045 c650c9        	ld	a,20681
2408  0048 6b03          	ld	(OFST+0,sp),a
2409  004a               L3221:
2410                     ; 683     if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2412  004a 7b05          	ld	a,(OFST+2,sp)
2413  004c 1503          	bcp	a,(OFST+0,sp)
2414  004e 2706          	jreq	L1421
2415                     ; 685         bitstatus = SET;
2417  0050 a601          	ld	a,#1
2418  0052 6b03          	ld	(OFST+0,sp),a
2420  0054 2002          	jra	L3421
2421  0056               L1421:
2422                     ; 689         bitstatus = RESET;
2424  0056 0f03          	clr	(OFST+0,sp)
2425  0058               L3421:
2426                     ; 693     return((FlagStatus)bitstatus);
2428  0058 7b03          	ld	a,(OFST+0,sp)
2431  005a 5b05          	addw	sp,#5
2432  005c 81            	ret
2478                     ; 703 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
2478                     ; 704 {
2479                     .text:	section	.text,new
2480  0000               _CLK_GetITStatus:
2482  0000 88            	push	a
2483  0001 88            	push	a
2484       00000001      OFST:	set	1
2487                     ; 706     ITStatus bitstatus = RESET;
2489                     ; 709     assert_param(IS_CLK_IT_OK(CLK_IT));
2491                     ; 711     if (CLK_IT == CLK_IT_SWIF)
2493  0002 a11c          	cp	a,#28
2494  0004 2611          	jrne	L7621
2495                     ; 714         if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2497  0006 c450c5        	and	a,20677
2498  0009 a10c          	cp	a,#12
2499  000b 2606          	jrne	L1721
2500                     ; 716             bitstatus = SET;
2502  000d a601          	ld	a,#1
2503  000f 6b01          	ld	(OFST+0,sp),a
2505  0011 2015          	jra	L5721
2506  0013               L1721:
2507                     ; 720             bitstatus = RESET;
2509  0013 0f01          	clr	(OFST+0,sp)
2510  0015 2011          	jra	L5721
2511  0017               L7621:
2512                     ; 726         if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2514  0017 c650c8        	ld	a,20680
2515  001a 1402          	and	a,(OFST+1,sp)
2516  001c a10c          	cp	a,#12
2517  001e 2606          	jrne	L7721
2518                     ; 728             bitstatus = SET;
2520  0020 a601          	ld	a,#1
2521  0022 6b01          	ld	(OFST+0,sp),a
2523  0024 2002          	jra	L5721
2524  0026               L7721:
2525                     ; 732             bitstatus = RESET;
2527  0026 0f01          	clr	(OFST+0,sp)
2528  0028               L5721:
2529                     ; 737     return bitstatus;
2531  0028 7b01          	ld	a,(OFST+0,sp)
2534  002a 85            	popw	x
2535  002b 81            	ret
2571                     ; 747 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
2571                     ; 748 {
2572                     .text:	section	.text,new
2573  0000               _CLK_ClearITPendingBit:
2577                     ; 751     assert_param(IS_CLK_IT_OK(CLK_IT));
2579                     ; 753     if (CLK_IT == (uint8_t)CLK_IT_CSSD)
2581  0000 a10c          	cp	a,#12
2582  0002 2606          	jrne	L1231
2583                     ; 756         CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
2585  0004 721750c8      	bres	20680,#3
2587  0008 2004          	jra	L3231
2588  000a               L1231:
2589                     ; 761         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
2591  000a 721750c5      	bres	20677,#3
2592  000e               L3231:
2593                     ; 764 }
2596  000e 81            	ret
2631                     	xdef	_CLKPrescTable
2632                     	xdef	_HSIDivFactor
2633                     	xdef	_CLK_ClearITPendingBit
2634                     	xdef	_CLK_GetITStatus
2635                     	xdef	_CLK_GetFlagStatus
2636                     	xdef	_CLK_GetSYSCLKSource
2637                     	xdef	_CLK_GetClockFreq
2638                     	xdef	_CLK_AdjustHSICalibrationValue
2639                     	xdef	_CLK_SYSCLKEmergencyClear
2640                     	xdef	_CLK_ClockSecuritySystemEnable
2641                     	xdef	_CLK_SWIMConfig
2642                     	xdef	_CLK_SYSCLKConfig
2643                     	xdef	_CLK_ITConfig
2644                     	xdef	_CLK_CCOConfig
2645                     	xdef	_CLK_HSIPrescalerConfig
2646                     	xdef	_CLK_ClockSwitchConfig
2647                     	xdef	_CLK_PeripheralClockConfig
2648                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
2649                     	xdef	_CLK_FastHaltWakeUpCmd
2650                     	xdef	_CLK_ClockSwitchCmd
2651                     	xdef	_CLK_CCOCmd
2652                     	xdef	_CLK_LSICmd
2653                     	xdef	_CLK_HSICmd
2654                     	xdef	_CLK_HSECmd
2655                     	xdef	_CLK_DeInit
2656                     	xref.b	c_lreg
2657                     	xref.b	c_x
2676                     	xref	c_ltor
2677                     	xref	c_ludv
2678                     	xref	c_rtol
2679                     	end
