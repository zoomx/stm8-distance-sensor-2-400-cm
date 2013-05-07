   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
  45                     ; 46 void TIM2_DeInit(void)
  45                     ; 47 {
  47                     .text:	section	.text,new
  48  0000               _TIM2_DeInit:
  52                     ; 49     TIM2->CR1 = (uint8_t)TIM2_CR1_RESET_VALUE;
  54  0000 725f5300      	clr	21248
  55                     ; 50     TIM2->IER = (uint8_t)TIM2_IER_RESET_VALUE;
  57  0004 725f5303      	clr	21251
  58                     ; 51     TIM2->SR2 = (uint8_t)TIM2_SR2_RESET_VALUE;
  60  0008 725f5305      	clr	21253
  61                     ; 54     TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  63  000c 725f530a      	clr	21258
  64                     ; 55     TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  66  0010 725f530b      	clr	21259
  67                     ; 59     TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  69  0014 725f530a      	clr	21258
  70                     ; 60     TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  72  0018 725f530b      	clr	21259
  73                     ; 61     TIM2->CCMR1 = (uint8_t)TIM2_CCMR1_RESET_VALUE;
  75  001c 725f5307      	clr	21255
  76                     ; 62     TIM2->CCMR2 = (uint8_t)TIM2_CCMR2_RESET_VALUE;
  78  0020 725f5308      	clr	21256
  79                     ; 63     TIM2->CCMR3 = (uint8_t)TIM2_CCMR3_RESET_VALUE;
  81  0024 725f5309      	clr	21257
  82                     ; 64     TIM2->CNTRH = (uint8_t)TIM2_CNTRH_RESET_VALUE;
  84  0028 725f530c      	clr	21260
  85                     ; 65     TIM2->CNTRL = (uint8_t)TIM2_CNTRL_RESET_VALUE;
  87  002c 725f530d      	clr	21261
  88                     ; 66     TIM2->PSCR = (uint8_t)TIM2_PSCR_RESET_VALUE;
  90  0030 725f530e      	clr	21262
  91                     ; 67     TIM2->ARRH  = (uint8_t)TIM2_ARRH_RESET_VALUE;
  93  0034 35ff530f      	mov	21263,#255
  94                     ; 68     TIM2->ARRL  = (uint8_t)TIM2_ARRL_RESET_VALUE;
  96  0038 35ff5310      	mov	21264,#255
  97                     ; 69     TIM2->CCR1H = (uint8_t)TIM2_CCR1H_RESET_VALUE;
  99  003c 725f5311      	clr	21265
 100                     ; 70     TIM2->CCR1L = (uint8_t)TIM2_CCR1L_RESET_VALUE;
 102  0040 725f5312      	clr	21266
 103                     ; 71     TIM2->CCR2H = (uint8_t)TIM2_CCR2H_RESET_VALUE;
 105  0044 725f5313      	clr	21267
 106                     ; 72     TIM2->CCR2L = (uint8_t)TIM2_CCR2L_RESET_VALUE;
 108  0048 725f5314      	clr	21268
 109                     ; 73     TIM2->CCR3H = (uint8_t)TIM2_CCR3H_RESET_VALUE;
 111  004c 725f5315      	clr	21269
 112                     ; 74     TIM2->CCR3L = (uint8_t)TIM2_CCR3L_RESET_VALUE;
 114  0050 725f5316      	clr	21270
 115                     ; 75     TIM2->SR1 = (uint8_t)TIM2_SR1_RESET_VALUE;
 117  0054 725f5304      	clr	21252
 118                     ; 76 }
 121  0058 81            	ret
 289                     ; 85 void TIM2_TimeBaseInit( TIM2_Prescaler_TypeDef TIM2_Prescaler,
 289                     ; 86                         uint16_t TIM2_Period)
 289                     ; 87 {
 290                     .text:	section	.text,new
 291  0000               _TIM2_TimeBaseInit:
 293  0000 88            	push	a
 294       00000000      OFST:	set	0
 297                     ; 89     TIM2->PSCR = (uint8_t)(TIM2_Prescaler);
 299  0001 c7530e        	ld	21262,a
 300                     ; 91     TIM2->ARRH = (uint8_t)(TIM2_Period >> 8);
 302  0004 7b04          	ld	a,(OFST+4,sp)
 303  0006 c7530f        	ld	21263,a
 304                     ; 92     TIM2->ARRL = (uint8_t)(TIM2_Period);
 306  0009 7b05          	ld	a,(OFST+5,sp)
 307  000b c75310        	ld	21264,a
 308                     ; 93 }
 311  000e 84            	pop	a
 312  000f 81            	ret
 469                     ; 104 void TIM2_OC1Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 469                     ; 105                   TIM2_OutputState_TypeDef TIM2_OutputState,
 469                     ; 106                   uint16_t TIM2_Pulse,
 469                     ; 107                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 469                     ; 108 {
 470                     .text:	section	.text,new
 471  0000               _TIM2_OC1Init:
 473  0000 89            	pushw	x
 474  0001 88            	push	a
 475       00000001      OFST:	set	1
 478                     ; 110     assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 480                     ; 111     assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 482                     ; 112     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 484                     ; 115     TIM2->CCER1 &= (uint8_t)(~( TIM2_CCER1_CC1E | TIM2_CCER1_CC1P));
 486  0002 c6530a        	ld	a,21258
 487  0005 a4fc          	and	a,#252
 488  0007 c7530a        	ld	21258,a
 489                     ; 117     TIM2->CCER1 |= (uint8_t)((uint8_t)(TIM2_OutputState & TIM2_CCER1_CC1E ) | 
 489                     ; 118                              (uint8_t)(TIM2_OCPolarity & TIM2_CCER1_CC1P));
 491  000a 7b08          	ld	a,(OFST+7,sp)
 492  000c a402          	and	a,#2
 493  000e 6b01          	ld	(OFST+0,sp),a
 494  0010 9f            	ld	a,xl
 495  0011 a401          	and	a,#1
 496  0013 1a01          	or	a,(OFST+0,sp)
 497  0015 ca530a        	or	a,21258
 498  0018 c7530a        	ld	21258,a
 499                     ; 121     TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM)) |
 499                     ; 122                             (uint8_t)TIM2_OCMode);
 501  001b c65307        	ld	a,21255
 502  001e a48f          	and	a,#143
 503  0020 1a02          	or	a,(OFST+1,sp)
 504  0022 c75307        	ld	21255,a
 505                     ; 125     TIM2->CCR1H = (uint8_t)(TIM2_Pulse >> 8);
 507  0025 7b06          	ld	a,(OFST+5,sp)
 508  0027 c75311        	ld	21265,a
 509                     ; 126     TIM2->CCR1L = (uint8_t)(TIM2_Pulse);
 511  002a 7b07          	ld	a,(OFST+6,sp)
 512  002c c75312        	ld	21266,a
 513                     ; 127 }
 516  002f 5b03          	addw	sp,#3
 517  0031 81            	ret
 581                     ; 138 void TIM2_OC2Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 581                     ; 139                   TIM2_OutputState_TypeDef TIM2_OutputState,
 581                     ; 140                   uint16_t TIM2_Pulse,
 581                     ; 141                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 581                     ; 142 {
 582                     .text:	section	.text,new
 583  0000               _TIM2_OC2Init:
 585  0000 89            	pushw	x
 586  0001 88            	push	a
 587       00000001      OFST:	set	1
 590                     ; 144     assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 592                     ; 145     assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 594                     ; 146     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 596                     ; 150     TIM2->CCER1 &= (uint8_t)(~( TIM2_CCER1_CC2E |  TIM2_CCER1_CC2P ));
 598  0002 c6530a        	ld	a,21258
 599  0005 a4cf          	and	a,#207
 600  0007 c7530a        	ld	21258,a
 601                     ; 152     TIM2->CCER1 |= (uint8_t)((uint8_t)(TIM2_OutputState  & TIM2_CCER1_CC2E ) |
 601                     ; 153                         (uint8_t)(TIM2_OCPolarity & TIM2_CCER1_CC2P));
 603  000a 7b08          	ld	a,(OFST+7,sp)
 604  000c a420          	and	a,#32
 605  000e 6b01          	ld	(OFST+0,sp),a
 606  0010 9f            	ld	a,xl
 607  0011 a410          	and	a,#16
 608  0013 1a01          	or	a,(OFST+0,sp)
 609  0015 ca530a        	or	a,21258
 610  0018 c7530a        	ld	21258,a
 611                     ; 157     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM)) | 
 611                     ; 158                             (uint8_t)TIM2_OCMode);
 613  001b c65308        	ld	a,21256
 614  001e a48f          	and	a,#143
 615  0020 1a02          	or	a,(OFST+1,sp)
 616  0022 c75308        	ld	21256,a
 617                     ; 162     TIM2->CCR2H = (uint8_t)(TIM2_Pulse >> 8);
 619  0025 7b06          	ld	a,(OFST+5,sp)
 620  0027 c75313        	ld	21267,a
 621                     ; 163     TIM2->CCR2L = (uint8_t)(TIM2_Pulse);
 623  002a 7b07          	ld	a,(OFST+6,sp)
 624  002c c75314        	ld	21268,a
 625                     ; 164 }
 628  002f 5b03          	addw	sp,#3
 629  0031 81            	ret
 693                     ; 175 void TIM2_OC3Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 693                     ; 176                   TIM2_OutputState_TypeDef TIM2_OutputState,
 693                     ; 177                   uint16_t TIM2_Pulse,
 693                     ; 178                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 693                     ; 179 {
 694                     .text:	section	.text,new
 695  0000               _TIM2_OC3Init:
 697  0000 89            	pushw	x
 698  0001 88            	push	a
 699       00000001      OFST:	set	1
 702                     ; 181     assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 704                     ; 182     assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 706                     ; 183     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 708                     ; 185     TIM2->CCER2 &= (uint8_t)(~( TIM2_CCER2_CC3E  | TIM2_CCER2_CC3P));
 710  0002 c6530b        	ld	a,21259
 711  0005 a4fc          	and	a,#252
 712  0007 c7530b        	ld	21259,a
 713                     ; 187     TIM2->CCER2 |= (uint8_t)((uint8_t)(TIM2_OutputState & TIM2_CCER2_CC3E) |  
 713                     ; 188                              (uint8_t)(TIM2_OCPolarity & TIM2_CCER2_CC3P));
 715  000a 7b08          	ld	a,(OFST+7,sp)
 716  000c a402          	and	a,#2
 717  000e 6b01          	ld	(OFST+0,sp),a
 718  0010 9f            	ld	a,xl
 719  0011 a401          	and	a,#1
 720  0013 1a01          	or	a,(OFST+0,sp)
 721  0015 ca530b        	or	a,21259
 722  0018 c7530b        	ld	21259,a
 723                     ; 191     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM)) |
 723                     ; 192                             (uint8_t)TIM2_OCMode);
 725  001b c65309        	ld	a,21257
 726  001e a48f          	and	a,#143
 727  0020 1a02          	or	a,(OFST+1,sp)
 728  0022 c75309        	ld	21257,a
 729                     ; 195     TIM2->CCR3H = (uint8_t)(TIM2_Pulse >> 8);
 731  0025 7b06          	ld	a,(OFST+5,sp)
 732  0027 c75315        	ld	21269,a
 733                     ; 196     TIM2->CCR3L = (uint8_t)(TIM2_Pulse);
 735  002a 7b07          	ld	a,(OFST+6,sp)
 736  002c c75316        	ld	21270,a
 737                     ; 198 }
 740  002f 5b03          	addw	sp,#3
 741  0031 81            	ret
 934                     ; 210 void TIM2_ICInit(TIM2_Channel_TypeDef TIM2_Channel,
 934                     ; 211                  TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
 934                     ; 212                  TIM2_ICSelection_TypeDef TIM2_ICSelection,
 934                     ; 213                  TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
 934                     ; 214                  uint8_t TIM2_ICFilter)
 934                     ; 215 {
 935                     .text:	section	.text,new
 936  0000               _TIM2_ICInit:
 938  0000 89            	pushw	x
 939       00000000      OFST:	set	0
 942                     ; 217     assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
 944                     ; 218     assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
 946                     ; 219     assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
 948                     ; 220     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
 950                     ; 221     assert_param(IS_TIM2_IC_FILTER_OK(TIM2_ICFilter));
 952                     ; 223     if (TIM2_Channel == TIM2_CHANNEL_1)
 954  0001 9e            	ld	a,xh
 955  0002 4d            	tnz	a
 956  0003 2614          	jrne	L104
 957                     ; 226         TI1_Config((uint8_t)TIM2_ICPolarity,
 957                     ; 227                    (uint8_t)TIM2_ICSelection,
 957                     ; 228                    (uint8_t)TIM2_ICFilter);
 959  0005 7b07          	ld	a,(OFST+7,sp)
 960  0007 88            	push	a
 961  0008 7b06          	ld	a,(OFST+6,sp)
 962  000a 97            	ld	xl,a
 963  000b 7b03          	ld	a,(OFST+3,sp)
 964  000d 95            	ld	xh,a
 965  000e cd0000        	call	L3_TI1_Config
 967  0011 84            	pop	a
 968                     ; 231         TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
 970  0012 7b06          	ld	a,(OFST+6,sp)
 971  0014 cd0000        	call	_TIM2_SetIC1Prescaler
 974  0017 202c          	jra	L304
 975  0019               L104:
 976                     ; 233     else if (TIM2_Channel == TIM2_CHANNEL_2)
 978  0019 7b01          	ld	a,(OFST+1,sp)
 979  001b a101          	cp	a,#1
 980  001d 2614          	jrne	L504
 981                     ; 236         TI2_Config((uint8_t)TIM2_ICPolarity,
 981                     ; 237                    (uint8_t)TIM2_ICSelection,
 981                     ; 238                    (uint8_t)TIM2_ICFilter);
 983  001f 7b07          	ld	a,(OFST+7,sp)
 984  0021 88            	push	a
 985  0022 7b06          	ld	a,(OFST+6,sp)
 986  0024 97            	ld	xl,a
 987  0025 7b03          	ld	a,(OFST+3,sp)
 988  0027 95            	ld	xh,a
 989  0028 cd0000        	call	L5_TI2_Config
 991  002b 84            	pop	a
 992                     ; 241         TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
 994  002c 7b06          	ld	a,(OFST+6,sp)
 995  002e cd0000        	call	_TIM2_SetIC2Prescaler
 998  0031 2012          	jra	L304
 999  0033               L504:
1000                     ; 246         TI3_Config((uint8_t)TIM2_ICPolarity,
1000                     ; 247                    (uint8_t)TIM2_ICSelection,
1000                     ; 248                    (uint8_t)TIM2_ICFilter);
1002  0033 7b07          	ld	a,(OFST+7,sp)
1003  0035 88            	push	a
1004  0036 7b06          	ld	a,(OFST+6,sp)
1005  0038 97            	ld	xl,a
1006  0039 7b03          	ld	a,(OFST+3,sp)
1007  003b 95            	ld	xh,a
1008  003c cd0000        	call	L7_TI3_Config
1010  003f 84            	pop	a
1011                     ; 251         TIM2_SetIC3Prescaler(TIM2_ICPrescaler);
1013  0040 7b06          	ld	a,(OFST+6,sp)
1014  0042 cd0000        	call	_TIM2_SetIC3Prescaler
1016  0045               L304:
1017                     ; 253 }
1020  0045 85            	popw	x
1021  0046 81            	ret
1117                     ; 265 void TIM2_PWMIConfig(TIM2_Channel_TypeDef TIM2_Channel,
1117                     ; 266                      TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
1117                     ; 267                      TIM2_ICSelection_TypeDef TIM2_ICSelection,
1117                     ; 268                      TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
1117                     ; 269                      uint8_t TIM2_ICFilter)
1117                     ; 270 {
1118                     .text:	section	.text,new
1119  0000               _TIM2_PWMIConfig:
1121  0000 89            	pushw	x
1122  0001 89            	pushw	x
1123       00000002      OFST:	set	2
1126                     ; 271     uint8_t icpolarity = (uint8_t)TIM2_ICPOLARITY_RISING;
1128                     ; 272     uint8_t icselection = (uint8_t)TIM2_ICSELECTION_DIRECTTI;
1130                     ; 275     assert_param(IS_TIM2_PWMI_CHANNEL_OK(TIM2_Channel));
1132                     ; 276     assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
1134                     ; 277     assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
1136                     ; 278     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
1138                     ; 281     if (TIM2_ICPolarity != TIM2_ICPOLARITY_FALLING)
1140  0002 9f            	ld	a,xl
1141  0003 a144          	cp	a,#68
1142  0005 2706          	jreq	L754
1143                     ; 283         icpolarity = (uint8_t)TIM2_ICPOLARITY_FALLING;
1145  0007 a644          	ld	a,#68
1146  0009 6b01          	ld	(OFST-1,sp),a
1148  000b 2002          	jra	L164
1149  000d               L754:
1150                     ; 287         icpolarity = (uint8_t)TIM2_ICPOLARITY_RISING;
1152  000d 0f01          	clr	(OFST-1,sp)
1153  000f               L164:
1154                     ; 291     if (TIM2_ICSelection == TIM2_ICSELECTION_DIRECTTI)
1156  000f 7b07          	ld	a,(OFST+5,sp)
1157  0011 a101          	cp	a,#1
1158  0013 2606          	jrne	L364
1159                     ; 293         icselection = (uint8_t)TIM2_ICSELECTION_INDIRECTTI;
1161  0015 a602          	ld	a,#2
1162  0017 6b02          	ld	(OFST+0,sp),a
1164  0019 2004          	jra	L564
1165  001b               L364:
1166                     ; 297         icselection = (uint8_t)TIM2_ICSELECTION_DIRECTTI;
1168  001b a601          	ld	a,#1
1169  001d 6b02          	ld	(OFST+0,sp),a
1170  001f               L564:
1171                     ; 300     if (TIM2_Channel == TIM2_CHANNEL_1)
1173  001f 0d03          	tnz	(OFST+1,sp)
1174  0021 2626          	jrne	L764
1175                     ; 303         TI1_Config((uint8_t)TIM2_ICPolarity, (uint8_t)TIM2_ICSelection,
1175                     ; 304                    (uint8_t)TIM2_ICFilter);
1177  0023 7b09          	ld	a,(OFST+7,sp)
1178  0025 88            	push	a
1179  0026 7b08          	ld	a,(OFST+6,sp)
1180  0028 97            	ld	xl,a
1181  0029 7b05          	ld	a,(OFST+3,sp)
1182  002b 95            	ld	xh,a
1183  002c cd0000        	call	L3_TI1_Config
1185  002f 84            	pop	a
1186                     ; 307         TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1188  0030 7b08          	ld	a,(OFST+6,sp)
1189  0032 cd0000        	call	_TIM2_SetIC1Prescaler
1191                     ; 310         TI2_Config(icpolarity, icselection, TIM2_ICFilter);
1193  0035 7b09          	ld	a,(OFST+7,sp)
1194  0037 88            	push	a
1195  0038 7b03          	ld	a,(OFST+1,sp)
1196  003a 97            	ld	xl,a
1197  003b 7b02          	ld	a,(OFST+0,sp)
1198  003d 95            	ld	xh,a
1199  003e cd0000        	call	L5_TI2_Config
1201  0041 84            	pop	a
1202                     ; 313         TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1204  0042 7b08          	ld	a,(OFST+6,sp)
1205  0044 cd0000        	call	_TIM2_SetIC2Prescaler
1208  0047 2024          	jra	L174
1209  0049               L764:
1210                     ; 318         TI2_Config((uint8_t)TIM2_ICPolarity, (uint8_t)TIM2_ICSelection,
1210                     ; 319                    (uint8_t)TIM2_ICFilter);
1212  0049 7b09          	ld	a,(OFST+7,sp)
1213  004b 88            	push	a
1214  004c 7b08          	ld	a,(OFST+6,sp)
1215  004e 97            	ld	xl,a
1216  004f 7b05          	ld	a,(OFST+3,sp)
1217  0051 95            	ld	xh,a
1218  0052 cd0000        	call	L5_TI2_Config
1220  0055 84            	pop	a
1221                     ; 322         TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1223  0056 7b08          	ld	a,(OFST+6,sp)
1224  0058 cd0000        	call	_TIM2_SetIC2Prescaler
1226                     ; 325         TI1_Config((uint8_t)icpolarity, icselection, (uint8_t)TIM2_ICFilter);
1228  005b 7b09          	ld	a,(OFST+7,sp)
1229  005d 88            	push	a
1230  005e 7b03          	ld	a,(OFST+1,sp)
1231  0060 97            	ld	xl,a
1232  0061 7b02          	ld	a,(OFST+0,sp)
1233  0063 95            	ld	xh,a
1234  0064 cd0000        	call	L3_TI1_Config
1236  0067 84            	pop	a
1237                     ; 328         TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1239  0068 7b08          	ld	a,(OFST+6,sp)
1240  006a cd0000        	call	_TIM2_SetIC1Prescaler
1242  006d               L174:
1243                     ; 330 }
1246  006d 5b04          	addw	sp,#4
1247  006f 81            	ret
1302                     ; 339 void TIM2_Cmd(FunctionalState NewState)
1302                     ; 340 {
1303                     .text:	section	.text,new
1304  0000               _TIM2_Cmd:
1308                     ; 342     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1310                     ; 345     if (NewState != DISABLE)
1312  0000 4d            	tnz	a
1313  0001 2706          	jreq	L125
1314                     ; 347         TIM2->CR1 |= (uint8_t)TIM2_CR1_CEN;
1316  0003 72105300      	bset	21248,#0
1318  0007 2004          	jra	L325
1319  0009               L125:
1320                     ; 351         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_CEN);
1322  0009 72115300      	bres	21248,#0
1323  000d               L325:
1324                     ; 353 }
1327  000d 81            	ret
1406                     ; 369 void TIM2_ITConfig(TIM2_IT_TypeDef TIM2_IT, FunctionalState NewState)
1406                     ; 370 {
1407                     .text:	section	.text,new
1408  0000               _TIM2_ITConfig:
1410  0000 89            	pushw	x
1411       00000000      OFST:	set	0
1414                     ; 372     assert_param(IS_TIM2_IT_OK(TIM2_IT));
1416                     ; 373     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1418                     ; 375     if (NewState != DISABLE)
1420  0001 9f            	ld	a,xl
1421  0002 4d            	tnz	a
1422  0003 2709          	jreq	L365
1423                     ; 378         TIM2->IER |= (uint8_t)TIM2_IT;
1425  0005 9e            	ld	a,xh
1426  0006 ca5303        	or	a,21251
1427  0009 c75303        	ld	21251,a
1429  000c 2009          	jra	L565
1430  000e               L365:
1431                     ; 383         TIM2->IER &= (uint8_t)(~TIM2_IT);
1433  000e 7b01          	ld	a,(OFST+1,sp)
1434  0010 43            	cpl	a
1435  0011 c45303        	and	a,21251
1436  0014 c75303        	ld	21251,a
1437  0017               L565:
1438                     ; 385 }
1441  0017 85            	popw	x
1442  0018 81            	ret
1478                     ; 394 void TIM2_UpdateDisableConfig(FunctionalState NewState)
1478                     ; 395 {
1479                     .text:	section	.text,new
1480  0000               _TIM2_UpdateDisableConfig:
1484                     ; 397     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1486                     ; 400     if (NewState != DISABLE)
1488  0000 4d            	tnz	a
1489  0001 2706          	jreq	L506
1490                     ; 402         TIM2->CR1 |= (uint8_t)TIM2_CR1_UDIS;
1492  0003 72125300      	bset	21248,#1
1494  0007 2004          	jra	L706
1495  0009               L506:
1496                     ; 406         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_UDIS);
1498  0009 72135300      	bres	21248,#1
1499  000d               L706:
1500                     ; 408 }
1503  000d 81            	ret
1561                     ; 418 void TIM2_UpdateRequestConfig(TIM2_UpdateSource_TypeDef TIM2_UpdateSource)
1561                     ; 419 {
1562                     .text:	section	.text,new
1563  0000               _TIM2_UpdateRequestConfig:
1567                     ; 421     assert_param(IS_TIM2_UPDATE_SOURCE_OK(TIM2_UpdateSource));
1569                     ; 424     if (TIM2_UpdateSource != TIM2_UPDATESOURCE_GLOBAL)
1571  0000 4d            	tnz	a
1572  0001 2706          	jreq	L736
1573                     ; 426         TIM2->CR1 |= (uint8_t)TIM2_CR1_URS;
1575  0003 72145300      	bset	21248,#2
1577  0007 2004          	jra	L146
1578  0009               L736:
1579                     ; 430         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_URS);
1581  0009 72155300      	bres	21248,#2
1582  000d               L146:
1583                     ; 432 }
1586  000d 81            	ret
1643                     ; 443 void TIM2_SelectOnePulseMode(TIM2_OPMode_TypeDef TIM2_OPMode)
1643                     ; 444 {
1644                     .text:	section	.text,new
1645  0000               _TIM2_SelectOnePulseMode:
1649                     ; 446     assert_param(IS_TIM2_OPM_MODE_OK(TIM2_OPMode));
1651                     ; 449     if (TIM2_OPMode != TIM2_OPMODE_REPETITIVE)
1653  0000 4d            	tnz	a
1654  0001 2706          	jreq	L176
1655                     ; 451         TIM2->CR1 |= (uint8_t)TIM2_CR1_OPM;
1657  0003 72165300      	bset	21248,#3
1659  0007 2004          	jra	L376
1660  0009               L176:
1661                     ; 455         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_OPM);
1663  0009 72175300      	bres	21248,#3
1664  000d               L376:
1665                     ; 458 }
1668  000d 81            	ret
1736                     ; 489 void TIM2_PrescalerConfig(TIM2_Prescaler_TypeDef Prescaler,
1736                     ; 490                           TIM2_PSCReloadMode_TypeDef TIM2_PSCReloadMode)
1736                     ; 491 {
1737                     .text:	section	.text,new
1738  0000               _TIM2_PrescalerConfig:
1742                     ; 493     assert_param(IS_TIM2_PRESCALER_RELOAD_OK(TIM2_PSCReloadMode));
1744                     ; 494     assert_param(IS_TIM2_PRESCALER_OK(Prescaler));
1746                     ; 497     TIM2->PSCR = (uint8_t)Prescaler;
1748  0000 9e            	ld	a,xh
1749  0001 c7530e        	ld	21262,a
1750                     ; 500     TIM2->EGR = (uint8_t)TIM2_PSCReloadMode;
1752  0004 9f            	ld	a,xl
1753  0005 c75306        	ld	21254,a
1754                     ; 501 }
1757  0008 81            	ret
1815                     ; 512 void TIM2_ForcedOC1Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1815                     ; 513 {
1816                     .text:	section	.text,new
1817  0000               _TIM2_ForcedOC1Config:
1819  0000 88            	push	a
1820       00000000      OFST:	set	0
1823                     ; 515     assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1825                     ; 518     TIM2->CCMR1  =  (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM))  
1825                     ; 519                               | (uint8_t)TIM2_ForcedAction);
1827  0001 c65307        	ld	a,21255
1828  0004 a48f          	and	a,#143
1829  0006 1a01          	or	a,(OFST+1,sp)
1830  0008 c75307        	ld	21255,a
1831                     ; 520 }
1834  000b 84            	pop	a
1835  000c 81            	ret
1871                     ; 531 void TIM2_ForcedOC2Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1871                     ; 532 {
1872                     .text:	section	.text,new
1873  0000               _TIM2_ForcedOC2Config:
1875  0000 88            	push	a
1876       00000000      OFST:	set	0
1879                     ; 534     assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1881                     ; 537     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM))  
1881                     ; 538                             | (uint8_t)TIM2_ForcedAction);
1883  0001 c65308        	ld	a,21256
1884  0004 a48f          	and	a,#143
1885  0006 1a01          	or	a,(OFST+1,sp)
1886  0008 c75308        	ld	21256,a
1887                     ; 539 }
1890  000b 84            	pop	a
1891  000c 81            	ret
1927                     ; 550 void TIM2_ForcedOC3Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1927                     ; 551 {
1928                     .text:	section	.text,new
1929  0000               _TIM2_ForcedOC3Config:
1931  0000 88            	push	a
1932       00000000      OFST:	set	0
1935                     ; 553     assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1937                     ; 556     TIM2->CCMR3  =  (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM))
1937                     ; 557                               | (uint8_t)TIM2_ForcedAction);
1939  0001 c65309        	ld	a,21257
1940  0004 a48f          	and	a,#143
1941  0006 1a01          	or	a,(OFST+1,sp)
1942  0008 c75309        	ld	21257,a
1943                     ; 558 }
1946  000b 84            	pop	a
1947  000c 81            	ret
1983                     ; 567 void TIM2_ARRPreloadConfig(FunctionalState NewState)
1983                     ; 568 {
1984                     .text:	section	.text,new
1985  0000               _TIM2_ARRPreloadConfig:
1989                     ; 570     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1991                     ; 573     if (NewState != DISABLE)
1993  0000 4d            	tnz	a
1994  0001 2706          	jreq	L7201
1995                     ; 575         TIM2->CR1 |= (uint8_t)TIM2_CR1_ARPE;
1997  0003 721e5300      	bset	21248,#7
1999  0007 2004          	jra	L1301
2000  0009               L7201:
2001                     ; 579         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_ARPE);
2003  0009 721f5300      	bres	21248,#7
2004  000d               L1301:
2005                     ; 581 }
2008  000d 81            	ret
2044                     ; 590 void TIM2_OC1PreloadConfig(FunctionalState NewState)
2044                     ; 591 {
2045                     .text:	section	.text,new
2046  0000               _TIM2_OC1PreloadConfig:
2050                     ; 593     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2052                     ; 596     if (NewState != DISABLE)
2054  0000 4d            	tnz	a
2055  0001 2706          	jreq	L1501
2056                     ; 598         TIM2->CCMR1 |= (uint8_t)TIM2_CCMR_OCxPE;
2058  0003 72165307      	bset	21255,#3
2060  0007 2004          	jra	L3501
2061  0009               L1501:
2062                     ; 602         TIM2->CCMR1 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2064  0009 72175307      	bres	21255,#3
2065  000d               L3501:
2066                     ; 604 }
2069  000d 81            	ret
2105                     ; 613 void TIM2_OC2PreloadConfig(FunctionalState NewState)
2105                     ; 614 {
2106                     .text:	section	.text,new
2107  0000               _TIM2_OC2PreloadConfig:
2111                     ; 616     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2113                     ; 619     if (NewState != DISABLE)
2115  0000 4d            	tnz	a
2116  0001 2706          	jreq	L3701
2117                     ; 621         TIM2->CCMR2 |= (uint8_t)TIM2_CCMR_OCxPE;
2119  0003 72165308      	bset	21256,#3
2121  0007 2004          	jra	L5701
2122  0009               L3701:
2123                     ; 625         TIM2->CCMR2 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2125  0009 72175308      	bres	21256,#3
2126  000d               L5701:
2127                     ; 627 }
2130  000d 81            	ret
2166                     ; 636 void TIM2_OC3PreloadConfig(FunctionalState NewState)
2166                     ; 637 {
2167                     .text:	section	.text,new
2168  0000               _TIM2_OC3PreloadConfig:
2172                     ; 639     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2174                     ; 642     if (NewState != DISABLE)
2176  0000 4d            	tnz	a
2177  0001 2706          	jreq	L5111
2178                     ; 644         TIM2->CCMR3 |= (uint8_t)TIM2_CCMR_OCxPE;
2180  0003 72165309      	bset	21257,#3
2182  0007 2004          	jra	L7111
2183  0009               L5111:
2184                     ; 648         TIM2->CCMR3 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2186  0009 72175309      	bres	21257,#3
2187  000d               L7111:
2188                     ; 650 }
2191  000d 81            	ret
2264                     ; 663 void TIM2_GenerateEvent(TIM2_EventSource_TypeDef TIM2_EventSource)
2264                     ; 664 {
2265                     .text:	section	.text,new
2266  0000               _TIM2_GenerateEvent:
2270                     ; 666     assert_param(IS_TIM2_EVENT_SOURCE_OK(TIM2_EventSource));
2272                     ; 669     TIM2->EGR = (uint8_t)TIM2_EventSource;
2274  0000 c75306        	ld	21254,a
2275                     ; 670 }
2278  0003 81            	ret
2314                     ; 681 void TIM2_OC1PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2314                     ; 682 {
2315                     .text:	section	.text,new
2316  0000               _TIM2_OC1PolarityConfig:
2320                     ; 684     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2322                     ; 687     if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2324  0000 4d            	tnz	a
2325  0001 2706          	jreq	L1711
2326                     ; 689         TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC1P;
2328  0003 7212530a      	bset	21258,#1
2330  0007 2004          	jra	L3711
2331  0009               L1711:
2332                     ; 693         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1P);
2334  0009 7213530a      	bres	21258,#1
2335  000d               L3711:
2336                     ; 695 }
2339  000d 81            	ret
2375                     ; 706 void TIM2_OC2PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2375                     ; 707 {
2376                     .text:	section	.text,new
2377  0000               _TIM2_OC2PolarityConfig:
2381                     ; 709     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2383                     ; 712     if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2385  0000 4d            	tnz	a
2386  0001 2706          	jreq	L3121
2387                     ; 714         TIM2->CCER1 |= TIM2_CCER1_CC2P;
2389  0003 721a530a      	bset	21258,#5
2391  0007 2004          	jra	L5121
2392  0009               L3121:
2393                     ; 718         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2P);
2395  0009 721b530a      	bres	21258,#5
2396  000d               L5121:
2397                     ; 720 }
2400  000d 81            	ret
2436                     ; 731 void TIM2_OC3PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2436                     ; 732 {
2437                     .text:	section	.text,new
2438  0000               _TIM2_OC3PolarityConfig:
2442                     ; 734     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2444                     ; 737     if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2446  0000 4d            	tnz	a
2447  0001 2706          	jreq	L5321
2448                     ; 739         TIM2->CCER2 |= (uint8_t)TIM2_CCER2_CC3P;
2450  0003 7212530b      	bset	21259,#1
2452  0007 2004          	jra	L7321
2453  0009               L5321:
2454                     ; 743         TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3P);
2456  0009 7213530b      	bres	21259,#1
2457  000d               L7321:
2458                     ; 745 }
2461  000d 81            	ret
2506                     ; 759 void TIM2_CCxCmd(TIM2_Channel_TypeDef TIM2_Channel, FunctionalState NewState)
2506                     ; 760 {
2507                     .text:	section	.text,new
2508  0000               _TIM2_CCxCmd:
2510  0000 89            	pushw	x
2511       00000000      OFST:	set	0
2514                     ; 762     assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
2516                     ; 763     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2518                     ; 765     if (TIM2_Channel == TIM2_CHANNEL_1)
2520  0001 9e            	ld	a,xh
2521  0002 4d            	tnz	a
2522  0003 2610          	jrne	L3621
2523                     ; 768         if (NewState != DISABLE)
2525  0005 9f            	ld	a,xl
2526  0006 4d            	tnz	a
2527  0007 2706          	jreq	L5621
2528                     ; 770             TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC1E;
2530  0009 7210530a      	bset	21258,#0
2532  000d 202a          	jra	L1721
2533  000f               L5621:
2534                     ; 774             TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
2536  000f 7211530a      	bres	21258,#0
2537  0013 2024          	jra	L1721
2538  0015               L3621:
2539                     ; 778     else if (TIM2_Channel == TIM2_CHANNEL_2)
2541  0015 7b01          	ld	a,(OFST+1,sp)
2542  0017 a101          	cp	a,#1
2543  0019 2610          	jrne	L3721
2544                     ; 781         if (NewState != DISABLE)
2546  001b 0d02          	tnz	(OFST+2,sp)
2547  001d 2706          	jreq	L5721
2548                     ; 783             TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC2E;
2550  001f 7218530a      	bset	21258,#4
2552  0023 2014          	jra	L1721
2553  0025               L5721:
2554                     ; 787             TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
2556  0025 7219530a      	bres	21258,#4
2557  0029 200e          	jra	L1721
2558  002b               L3721:
2559                     ; 793         if (NewState != DISABLE)
2561  002b 0d02          	tnz	(OFST+2,sp)
2562  002d 2706          	jreq	L3031
2563                     ; 795             TIM2->CCER2 |= (uint8_t)TIM2_CCER2_CC3E;
2565  002f 7210530b      	bset	21259,#0
2567  0033 2004          	jra	L1721
2568  0035               L3031:
2569                     ; 799             TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3E);
2571  0035 7211530b      	bres	21259,#0
2572  0039               L1721:
2573                     ; 802 }
2576  0039 85            	popw	x
2577  003a 81            	ret
2622                     ; 824 void TIM2_SelectOCxM(TIM2_Channel_TypeDef TIM2_Channel, TIM2_OCMode_TypeDef TIM2_OCMode)
2622                     ; 825 {
2623                     .text:	section	.text,new
2624  0000               _TIM2_SelectOCxM:
2626  0000 89            	pushw	x
2627       00000000      OFST:	set	0
2630                     ; 827     assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
2632                     ; 828     assert_param(IS_TIM2_OCM_OK(TIM2_OCMode));
2634                     ; 830     if (TIM2_Channel == TIM2_CHANNEL_1)
2636  0001 9e            	ld	a,xh
2637  0002 4d            	tnz	a
2638  0003 2610          	jrne	L1331
2639                     ; 833         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
2641  0005 7211530a      	bres	21258,#0
2642                     ; 836         TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM))
2642                     ; 837                                | (uint8_t)TIM2_OCMode);
2644  0009 c65307        	ld	a,21255
2645  000c a48f          	and	a,#143
2646  000e 1a02          	or	a,(OFST+2,sp)
2647  0010 c75307        	ld	21255,a
2649  0013 2024          	jra	L3331
2650  0015               L1331:
2651                     ; 839     else if (TIM2_Channel == TIM2_CHANNEL_2)
2653  0015 7b01          	ld	a,(OFST+1,sp)
2654  0017 a101          	cp	a,#1
2655  0019 2610          	jrne	L5331
2656                     ; 842         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
2658  001b 7219530a      	bres	21258,#4
2659                     ; 845         TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM))
2659                     ; 846                                 | (uint8_t)TIM2_OCMode);
2661  001f c65308        	ld	a,21256
2662  0022 a48f          	and	a,#143
2663  0024 1a02          	or	a,(OFST+2,sp)
2664  0026 c75308        	ld	21256,a
2666  0029 200e          	jra	L3331
2667  002b               L5331:
2668                     ; 851         TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3E);
2670  002b 7211530b      	bres	21259,#0
2671                     ; 854         TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM))
2671                     ; 855                                 | (uint8_t)TIM2_OCMode);
2673  002f c65309        	ld	a,21257
2674  0032 a48f          	and	a,#143
2675  0034 1a02          	or	a,(OFST+2,sp)
2676  0036 c75309        	ld	21257,a
2677  0039               L3331:
2678                     ; 857 }
2681  0039 85            	popw	x
2682  003a 81            	ret
2716                     ; 866 void TIM2_SetCounter(uint16_t Counter)
2716                     ; 867 {
2717                     .text:	section	.text,new
2718  0000               _TIM2_SetCounter:
2722                     ; 869     TIM2->CNTRH = (uint8_t)(Counter >> 8);
2724  0000 9e            	ld	a,xh
2725  0001 c7530c        	ld	21260,a
2726                     ; 870     TIM2->CNTRL = (uint8_t)(Counter);
2728  0004 9f            	ld	a,xl
2729  0005 c7530d        	ld	21261,a
2730                     ; 872 }
2733  0008 81            	ret
2767                     ; 881 void TIM2_SetAutoreload(uint16_t Autoreload)
2767                     ; 882 {
2768                     .text:	section	.text,new
2769  0000               _TIM2_SetAutoreload:
2773                     ; 885     TIM2->ARRH = (uint8_t)(Autoreload >> 8);
2775  0000 9e            	ld	a,xh
2776  0001 c7530f        	ld	21263,a
2777                     ; 886     TIM2->ARRL = (uint8_t)(Autoreload);
2779  0004 9f            	ld	a,xl
2780  0005 c75310        	ld	21264,a
2781                     ; 888 }
2784  0008 81            	ret
2818                     ; 897 void TIM2_SetCompare1(uint16_t Compare1)
2818                     ; 898 {
2819                     .text:	section	.text,new
2820  0000               _TIM2_SetCompare1:
2824                     ; 900     TIM2->CCR1H = (uint8_t)(Compare1 >> 8);
2826  0000 9e            	ld	a,xh
2827  0001 c75311        	ld	21265,a
2828                     ; 901     TIM2->CCR1L = (uint8_t)(Compare1);
2830  0004 9f            	ld	a,xl
2831  0005 c75312        	ld	21266,a
2832                     ; 903 }
2835  0008 81            	ret
2869                     ; 912 void TIM2_SetCompare2(uint16_t Compare2)
2869                     ; 913 {
2870                     .text:	section	.text,new
2871  0000               _TIM2_SetCompare2:
2875                     ; 915     TIM2->CCR2H = (uint8_t)(Compare2 >> 8);
2877  0000 9e            	ld	a,xh
2878  0001 c75313        	ld	21267,a
2879                     ; 916     TIM2->CCR2L = (uint8_t)(Compare2);
2881  0004 9f            	ld	a,xl
2882  0005 c75314        	ld	21268,a
2883                     ; 918 }
2886  0008 81            	ret
2920                     ; 927 void TIM2_SetCompare3(uint16_t Compare3)
2920                     ; 928 {
2921                     .text:	section	.text,new
2922  0000               _TIM2_SetCompare3:
2926                     ; 930     TIM2->CCR3H = (uint8_t)(Compare3 >> 8);
2928  0000 9e            	ld	a,xh
2929  0001 c75315        	ld	21269,a
2930                     ; 931     TIM2->CCR3L = (uint8_t)(Compare3);
2932  0004 9f            	ld	a,xl
2933  0005 c75316        	ld	21270,a
2934                     ; 933 }
2937  0008 81            	ret
2973                     ; 946 void TIM2_SetIC1Prescaler(TIM2_ICPSC_TypeDef TIM2_IC1Prescaler)
2973                     ; 947 {
2974                     .text:	section	.text,new
2975  0000               _TIM2_SetIC1Prescaler:
2977  0000 88            	push	a
2978       00000000      OFST:	set	0
2981                     ; 949     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC1Prescaler));
2983                     ; 952     TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_ICxPSC))
2983                     ; 953                             | (uint8_t)TIM2_IC1Prescaler);
2985  0001 c65307        	ld	a,21255
2986  0004 a4f3          	and	a,#243
2987  0006 1a01          	or	a,(OFST+1,sp)
2988  0008 c75307        	ld	21255,a
2989                     ; 954 }
2992  000b 84            	pop	a
2993  000c 81            	ret
3029                     ; 966 void TIM2_SetIC2Prescaler(TIM2_ICPSC_TypeDef TIM2_IC2Prescaler)
3029                     ; 967 {
3030                     .text:	section	.text,new
3031  0000               _TIM2_SetIC2Prescaler:
3033  0000 88            	push	a
3034       00000000      OFST:	set	0
3037                     ; 969     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC2Prescaler));
3039                     ; 972     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3039                     ; 973                             | (uint8_t)TIM2_IC2Prescaler);
3041  0001 c65308        	ld	a,21256
3042  0004 a4f3          	and	a,#243
3043  0006 1a01          	or	a,(OFST+1,sp)
3044  0008 c75308        	ld	21256,a
3045                     ; 974 }
3048  000b 84            	pop	a
3049  000c 81            	ret
3085                     ; 986 void TIM2_SetIC3Prescaler(TIM2_ICPSC_TypeDef TIM2_IC3Prescaler)
3085                     ; 987 {
3086                     .text:	section	.text,new
3087  0000               _TIM2_SetIC3Prescaler:
3089  0000 88            	push	a
3090       00000000      OFST:	set	0
3093                     ; 990     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC3Prescaler));
3095                     ; 992     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3095                     ; 993                             | (uint8_t)TIM2_IC3Prescaler);
3097  0001 c65309        	ld	a,21257
3098  0004 a4f3          	and	a,#243
3099  0006 1a01          	or	a,(OFST+1,sp)
3100  0008 c75309        	ld	21257,a
3101                     ; 994 }
3104  000b 84            	pop	a
3105  000c 81            	ret
3157                     ; 1001 uint16_t TIM2_GetCapture1(void)
3157                     ; 1002 {
3158                     .text:	section	.text,new
3159  0000               _TIM2_GetCapture1:
3161  0000 5204          	subw	sp,#4
3162       00000004      OFST:	set	4
3165                     ; 1004     uint16_t tmpccr1 = 0;
3167                     ; 1005     uint8_t tmpccr1l=0, tmpccr1h=0;
3171                     ; 1007     tmpccr1h = TIM2->CCR1H;
3173  0002 c65311        	ld	a,21265
3174  0005 6b02          	ld	(OFST-2,sp),a
3175                     ; 1008     tmpccr1l = TIM2->CCR1L;
3177  0007 c65312        	ld	a,21266
3178  000a 6b01          	ld	(OFST-3,sp),a
3179                     ; 1010     tmpccr1 = (uint16_t)(tmpccr1l);
3181  000c 7b01          	ld	a,(OFST-3,sp)
3182  000e 5f            	clrw	x
3183  000f 97            	ld	xl,a
3184  0010 1f03          	ldw	(OFST-1,sp),x
3185                     ; 1011     tmpccr1 |= (uint16_t)((uint16_t)tmpccr1h << 8);
3187  0012 7b02          	ld	a,(OFST-2,sp)
3188  0014 5f            	clrw	x
3189  0015 97            	ld	xl,a
3190  0016 4f            	clr	a
3191  0017 02            	rlwa	x,a
3192  0018 01            	rrwa	x,a
3193  0019 1a04          	or	a,(OFST+0,sp)
3194  001b 01            	rrwa	x,a
3195  001c 1a03          	or	a,(OFST-1,sp)
3196  001e 01            	rrwa	x,a
3197  001f 1f03          	ldw	(OFST-1,sp),x
3198                     ; 1013     return (uint16_t)tmpccr1;
3200  0021 1e03          	ldw	x,(OFST-1,sp)
3203  0023 5b04          	addw	sp,#4
3204  0025 81            	ret
3256                     ; 1021 uint16_t TIM2_GetCapture2(void)
3256                     ; 1022 {
3257                     .text:	section	.text,new
3258  0000               _TIM2_GetCapture2:
3260  0000 5204          	subw	sp,#4
3261       00000004      OFST:	set	4
3264                     ; 1024     uint16_t tmpccr2 = 0;
3266                     ; 1025     uint8_t tmpccr2l=0, tmpccr2h=0;
3270                     ; 1027     tmpccr2h = TIM2->CCR2H;
3272  0002 c65313        	ld	a,21267
3273  0005 6b02          	ld	(OFST-2,sp),a
3274                     ; 1028     tmpccr2l = TIM2->CCR2L;
3276  0007 c65314        	ld	a,21268
3277  000a 6b01          	ld	(OFST-3,sp),a
3278                     ; 1030     tmpccr2 = (uint16_t)(tmpccr2l);
3280  000c 7b01          	ld	a,(OFST-3,sp)
3281  000e 5f            	clrw	x
3282  000f 97            	ld	xl,a
3283  0010 1f03          	ldw	(OFST-1,sp),x
3284                     ; 1031     tmpccr2 |= (uint16_t)((uint16_t)tmpccr2h << 8);
3286  0012 7b02          	ld	a,(OFST-2,sp)
3287  0014 5f            	clrw	x
3288  0015 97            	ld	xl,a
3289  0016 4f            	clr	a
3290  0017 02            	rlwa	x,a
3291  0018 01            	rrwa	x,a
3292  0019 1a04          	or	a,(OFST+0,sp)
3293  001b 01            	rrwa	x,a
3294  001c 1a03          	or	a,(OFST-1,sp)
3295  001e 01            	rrwa	x,a
3296  001f 1f03          	ldw	(OFST-1,sp),x
3297                     ; 1033     return (uint16_t)tmpccr2;
3299  0021 1e03          	ldw	x,(OFST-1,sp)
3302  0023 5b04          	addw	sp,#4
3303  0025 81            	ret
3355                     ; 1041 uint16_t TIM2_GetCapture3(void)
3355                     ; 1042 {
3356                     .text:	section	.text,new
3357  0000               _TIM2_GetCapture3:
3359  0000 5204          	subw	sp,#4
3360       00000004      OFST:	set	4
3363                     ; 1044     uint16_t tmpccr3 = 0;
3365                     ; 1045     uint8_t tmpccr3l=0, tmpccr3h=0;
3369                     ; 1047     tmpccr3h = TIM2->CCR3H;
3371  0002 c65315        	ld	a,21269
3372  0005 6b02          	ld	(OFST-2,sp),a
3373                     ; 1048     tmpccr3l = TIM2->CCR3L;
3375  0007 c65316        	ld	a,21270
3376  000a 6b01          	ld	(OFST-3,sp),a
3377                     ; 1050     tmpccr3 = (uint16_t)(tmpccr3l);
3379  000c 7b01          	ld	a,(OFST-3,sp)
3380  000e 5f            	clrw	x
3381  000f 97            	ld	xl,a
3382  0010 1f03          	ldw	(OFST-1,sp),x
3383                     ; 1051     tmpccr3 |= (uint16_t)((uint16_t)tmpccr3h << 8);
3385  0012 7b02          	ld	a,(OFST-2,sp)
3386  0014 5f            	clrw	x
3387  0015 97            	ld	xl,a
3388  0016 4f            	clr	a
3389  0017 02            	rlwa	x,a
3390  0018 01            	rrwa	x,a
3391  0019 1a04          	or	a,(OFST+0,sp)
3392  001b 01            	rrwa	x,a
3393  001c 1a03          	or	a,(OFST-1,sp)
3394  001e 01            	rrwa	x,a
3395  001f 1f03          	ldw	(OFST-1,sp),x
3396                     ; 1053     return (uint16_t)tmpccr3;
3398  0021 1e03          	ldw	x,(OFST-1,sp)
3401  0023 5b04          	addw	sp,#4
3402  0025 81            	ret
3436                     ; 1061 uint16_t TIM2_GetCounter(void)
3436                     ; 1062 {
3437                     .text:	section	.text,new
3438  0000               _TIM2_GetCounter:
3440  0000 89            	pushw	x
3441       00000002      OFST:	set	2
3444                     ; 1063      uint16_t tmpcntr = 0;
3446                     ; 1065     tmpcntr =  ((uint16_t)TIM2->CNTRH << 8);
3448  0001 c6530c        	ld	a,21260
3449  0004 5f            	clrw	x
3450  0005 97            	ld	xl,a
3451  0006 4f            	clr	a
3452  0007 02            	rlwa	x,a
3453  0008 1f01          	ldw	(OFST-1,sp),x
3454                     ; 1067     return (uint16_t)( tmpcntr| (uint16_t)(TIM2->CNTRL));
3456  000a c6530d        	ld	a,21261
3457  000d 5f            	clrw	x
3458  000e 97            	ld	xl,a
3459  000f 01            	rrwa	x,a
3460  0010 1a02          	or	a,(OFST+0,sp)
3461  0012 01            	rrwa	x,a
3462  0013 1a01          	or	a,(OFST-1,sp)
3463  0015 01            	rrwa	x,a
3466  0016 5b02          	addw	sp,#2
3467  0018 81            	ret
3491                     ; 1076 TIM2_Prescaler_TypeDef TIM2_GetPrescaler(void)
3491                     ; 1077 {
3492                     .text:	section	.text,new
3493  0000               _TIM2_GetPrescaler:
3497                     ; 1079     return (TIM2_Prescaler_TypeDef)(TIM2->PSCR);
3499  0000 c6530e        	ld	a,21262
3502  0003 81            	ret
3641                     ; 1096 FlagStatus TIM2_GetFlagStatus(TIM2_FLAG_TypeDef TIM2_FLAG)
3641                     ; 1097 {
3642                     .text:	section	.text,new
3643  0000               _TIM2_GetFlagStatus:
3645  0000 89            	pushw	x
3646  0001 89            	pushw	x
3647       00000002      OFST:	set	2
3650                     ; 1098     FlagStatus bitstatus = RESET;
3652                     ; 1099     uint8_t tim2_flag_l = 0, tim2_flag_h = 0;
3656                     ; 1102     assert_param(IS_TIM2_GET_FLAG_OK(TIM2_FLAG));
3658                     ; 1104     tim2_flag_l = (uint8_t)(TIM2->SR1 & (uint8_t)TIM2_FLAG);
3660  0002 9f            	ld	a,xl
3661  0003 c45304        	and	a,21252
3662  0006 6b01          	ld	(OFST-1,sp),a
3663                     ; 1105     tim2_flag_h = (uint8_t)((uint16_t)TIM2_FLAG >> 8);
3665  0008 7b03          	ld	a,(OFST+1,sp)
3666  000a 6b02          	ld	(OFST+0,sp),a
3667                     ; 1107     if ((tim2_flag_l | (uint8_t)(TIM2->SR2 & tim2_flag_h)) != (uint8_t)RESET )
3669  000c c65305        	ld	a,21253
3670  000f 1402          	and	a,(OFST+0,sp)
3671  0011 1a01          	or	a,(OFST-1,sp)
3672  0013 2706          	jreq	L5371
3673                     ; 1109         bitstatus = SET;
3675  0015 a601          	ld	a,#1
3676  0017 6b02          	ld	(OFST+0,sp),a
3678  0019 2002          	jra	L7371
3679  001b               L5371:
3680                     ; 1113         bitstatus = RESET;
3682  001b 0f02          	clr	(OFST+0,sp)
3683  001d               L7371:
3684                     ; 1115     return (FlagStatus)bitstatus;
3686  001d 7b02          	ld	a,(OFST+0,sp)
3689  001f 5b04          	addw	sp,#4
3690  0021 81            	ret
3725                     ; 1132 void TIM2_ClearFlag(TIM2_FLAG_TypeDef TIM2_FLAG)
3725                     ; 1133 {
3726                     .text:	section	.text,new
3727  0000               _TIM2_ClearFlag:
3731                     ; 1135     assert_param(IS_TIM2_CLEAR_FLAG_OK(TIM2_FLAG));
3733                     ; 1138     TIM2->SR1 = (uint8_t)(~((uint8_t)(TIM2_FLAG)));
3735  0000 9f            	ld	a,xl
3736  0001 43            	cpl	a
3737  0002 c75304        	ld	21252,a
3738                     ; 1139     TIM2->SR2 = (uint8_t)(~((uint8_t)((uint8_t)TIM2_FLAG >> 8)));
3740  0005 35ff5305      	mov	21253,#255
3741                     ; 1140 }
3744  0009 81            	ret
3808                     ; 1154 ITStatus TIM2_GetITStatus(TIM2_IT_TypeDef TIM2_IT)
3808                     ; 1155 {
3809                     .text:	section	.text,new
3810  0000               _TIM2_GetITStatus:
3812  0000 88            	push	a
3813  0001 89            	pushw	x
3814       00000002      OFST:	set	2
3817                     ; 1156     ITStatus bitstatus = RESET;
3819                     ; 1157     uint8_t TIM2_itStatus = 0, TIM2_itEnable = 0;
3823                     ; 1160     assert_param(IS_TIM2_GET_IT_OK(TIM2_IT));
3825                     ; 1162     TIM2_itStatus = (uint8_t)(TIM2->SR1 & TIM2_IT);
3827  0002 c45304        	and	a,21252
3828  0005 6b01          	ld	(OFST-1,sp),a
3829                     ; 1164     TIM2_itEnable = (uint8_t)(TIM2->IER & TIM2_IT);
3831  0007 c65303        	ld	a,21251
3832  000a 1403          	and	a,(OFST+1,sp)
3833  000c 6b02          	ld	(OFST+0,sp),a
3834                     ; 1166     if ((TIM2_itStatus != (uint8_t)RESET ) && (TIM2_itEnable != (uint8_t)RESET ))
3836  000e 0d01          	tnz	(OFST-1,sp)
3837  0010 270a          	jreq	L1102
3839  0012 0d02          	tnz	(OFST+0,sp)
3840  0014 2706          	jreq	L1102
3841                     ; 1168         bitstatus = SET;
3843  0016 a601          	ld	a,#1
3844  0018 6b02          	ld	(OFST+0,sp),a
3846  001a 2002          	jra	L3102
3847  001c               L1102:
3848                     ; 1172         bitstatus = RESET;
3850  001c 0f02          	clr	(OFST+0,sp)
3851  001e               L3102:
3852                     ; 1174     return (ITStatus)(bitstatus);
3854  001e 7b02          	ld	a,(OFST+0,sp)
3857  0020 5b03          	addw	sp,#3
3858  0022 81            	ret
3894                     ; 1188 void TIM2_ClearITPendingBit(TIM2_IT_TypeDef TIM2_IT)
3894                     ; 1189 {
3895                     .text:	section	.text,new
3896  0000               _TIM2_ClearITPendingBit:
3900                     ; 1191     assert_param(IS_TIM2_IT_OK(TIM2_IT));
3902                     ; 1194     TIM2->SR1 = (uint8_t)(~TIM2_IT);
3904  0000 43            	cpl	a
3905  0001 c75304        	ld	21252,a
3906                     ; 1195 }
3909  0004 81            	ret
3961                     ; 1214 static void TI1_Config(uint8_t TIM2_ICPolarity,
3961                     ; 1215                        uint8_t TIM2_ICSelection,
3961                     ; 1216                        uint8_t TIM2_ICFilter)
3961                     ; 1217 {
3962                     .text:	section	.text,new
3963  0000               L3_TI1_Config:
3965  0000 89            	pushw	x
3966  0001 88            	push	a
3967       00000001      OFST:	set	1
3970                     ; 1219     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
3972  0002 7211530a      	bres	21258,#0
3973                     ; 1222     TIM2->CCMR1  = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~(uint8_t)( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF )))
3973                     ; 1223                              | (uint8_t)(((TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
3975  0006 7b06          	ld	a,(OFST+5,sp)
3976  0008 97            	ld	xl,a
3977  0009 a610          	ld	a,#16
3978  000b 42            	mul	x,a
3979  000c 9f            	ld	a,xl
3980  000d 1a03          	or	a,(OFST+2,sp)
3981  000f 6b01          	ld	(OFST+0,sp),a
3982  0011 c65307        	ld	a,21255
3983  0014 a40c          	and	a,#12
3984  0016 1a01          	or	a,(OFST+0,sp)
3985  0018 c75307        	ld	21255,a
3986                     ; 1226     if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
3988  001b 0d02          	tnz	(OFST+1,sp)
3989  001d 2706          	jreq	L1602
3990                     ; 1228         TIM2->CCER1 |= TIM2_CCER1_CC1P;
3992  001f 7212530a      	bset	21258,#1
3994  0023 2004          	jra	L3602
3995  0025               L1602:
3996                     ; 1232         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1P);
3998  0025 7213530a      	bres	21258,#1
3999  0029               L3602:
4000                     ; 1235     TIM2->CCER1 |= TIM2_CCER1_CC1E;
4002  0029 7210530a      	bset	21258,#0
4003                     ; 1236 }
4006  002d 5b03          	addw	sp,#3
4007  002f 81            	ret
4059                     ; 1255 static void TI2_Config(uint8_t TIM2_ICPolarity,
4059                     ; 1256                        uint8_t TIM2_ICSelection,
4059                     ; 1257                        uint8_t TIM2_ICFilter)
4059                     ; 1258 {
4060                     .text:	section	.text,new
4061  0000               L5_TI2_Config:
4063  0000 89            	pushw	x
4064  0001 88            	push	a
4065       00000001      OFST:	set	1
4068                     ; 1260     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
4070  0002 7219530a      	bres	21258,#4
4071                     ; 1263     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~(uint8_t)( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF ))) 
4071                     ; 1264                             | (uint8_t)(( (TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
4073  0006 7b06          	ld	a,(OFST+5,sp)
4074  0008 97            	ld	xl,a
4075  0009 a610          	ld	a,#16
4076  000b 42            	mul	x,a
4077  000c 9f            	ld	a,xl
4078  000d 1a03          	or	a,(OFST+2,sp)
4079  000f 6b01          	ld	(OFST+0,sp),a
4080  0011 c65308        	ld	a,21256
4081  0014 a40c          	and	a,#12
4082  0016 1a01          	or	a,(OFST+0,sp)
4083  0018 c75308        	ld	21256,a
4084                     ; 1268     if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4086  001b 0d02          	tnz	(OFST+1,sp)
4087  001d 2706          	jreq	L3112
4088                     ; 1270         TIM2->CCER1 |= TIM2_CCER1_CC2P;
4090  001f 721a530a      	bset	21258,#5
4092  0023 2004          	jra	L5112
4093  0025               L3112:
4094                     ; 1274         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2P);
4096  0025 721b530a      	bres	21258,#5
4097  0029               L5112:
4098                     ; 1278     TIM2->CCER1 |= TIM2_CCER1_CC2E;
4100  0029 7218530a      	bset	21258,#4
4101                     ; 1280 }
4104  002d 5b03          	addw	sp,#3
4105  002f 81            	ret
4157                     ; 1296 static void TI3_Config(uint8_t TIM2_ICPolarity, uint8_t TIM2_ICSelection,
4157                     ; 1297                        uint8_t TIM2_ICFilter)
4157                     ; 1298 {
4158                     .text:	section	.text,new
4159  0000               L7_TI3_Config:
4161  0000 89            	pushw	x
4162  0001 88            	push	a
4163       00000001      OFST:	set	1
4166                     ; 1300     TIM2->CCER2 &=  (uint8_t)(~TIM2_CCER2_CC3E);
4168  0002 7211530b      	bres	21259,#0
4169                     ; 1303     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF))) 
4169                     ; 1304                             | (uint8_t)(( (TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
4171  0006 7b06          	ld	a,(OFST+5,sp)
4172  0008 97            	ld	xl,a
4173  0009 a610          	ld	a,#16
4174  000b 42            	mul	x,a
4175  000c 9f            	ld	a,xl
4176  000d 1a03          	or	a,(OFST+2,sp)
4177  000f 6b01          	ld	(OFST+0,sp),a
4178  0011 c65309        	ld	a,21257
4179  0014 a40c          	and	a,#12
4180  0016 1a01          	or	a,(OFST+0,sp)
4181  0018 c75309        	ld	21257,a
4182                     ; 1308     if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4184  001b 0d02          	tnz	(OFST+1,sp)
4185  001d 2706          	jreq	L5412
4186                     ; 1310         TIM2->CCER2 |= TIM2_CCER2_CC3P;
4188  001f 7212530b      	bset	21259,#1
4190  0023 2004          	jra	L7412
4191  0025               L5412:
4192                     ; 1314         TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3P);
4194  0025 7213530b      	bres	21259,#1
4195  0029               L7412:
4196                     ; 1317     TIM2->CCER2 |= TIM2_CCER2_CC3E;
4198  0029 7210530b      	bset	21259,#0
4199                     ; 1318 }
4202  002d 5b03          	addw	sp,#3
4203  002f 81            	ret
4216                     	xdef	_TIM2_ClearITPendingBit
4217                     	xdef	_TIM2_GetITStatus
4218                     	xdef	_TIM2_ClearFlag
4219                     	xdef	_TIM2_GetFlagStatus
4220                     	xdef	_TIM2_GetPrescaler
4221                     	xdef	_TIM2_GetCounter
4222                     	xdef	_TIM2_GetCapture3
4223                     	xdef	_TIM2_GetCapture2
4224                     	xdef	_TIM2_GetCapture1
4225                     	xdef	_TIM2_SetIC3Prescaler
4226                     	xdef	_TIM2_SetIC2Prescaler
4227                     	xdef	_TIM2_SetIC1Prescaler
4228                     	xdef	_TIM2_SetCompare3
4229                     	xdef	_TIM2_SetCompare2
4230                     	xdef	_TIM2_SetCompare1
4231                     	xdef	_TIM2_SetAutoreload
4232                     	xdef	_TIM2_SetCounter
4233                     	xdef	_TIM2_SelectOCxM
4234                     	xdef	_TIM2_CCxCmd
4235                     	xdef	_TIM2_OC3PolarityConfig
4236                     	xdef	_TIM2_OC2PolarityConfig
4237                     	xdef	_TIM2_OC1PolarityConfig
4238                     	xdef	_TIM2_GenerateEvent
4239                     	xdef	_TIM2_OC3PreloadConfig
4240                     	xdef	_TIM2_OC2PreloadConfig
4241                     	xdef	_TIM2_OC1PreloadConfig
4242                     	xdef	_TIM2_ARRPreloadConfig
4243                     	xdef	_TIM2_ForcedOC3Config
4244                     	xdef	_TIM2_ForcedOC2Config
4245                     	xdef	_TIM2_ForcedOC1Config
4246                     	xdef	_TIM2_PrescalerConfig
4247                     	xdef	_TIM2_SelectOnePulseMode
4248                     	xdef	_TIM2_UpdateRequestConfig
4249                     	xdef	_TIM2_UpdateDisableConfig
4250                     	xdef	_TIM2_ITConfig
4251                     	xdef	_TIM2_Cmd
4252                     	xdef	_TIM2_PWMIConfig
4253                     	xdef	_TIM2_ICInit
4254                     	xdef	_TIM2_OC3Init
4255                     	xdef	_TIM2_OC2Init
4256                     	xdef	_TIM2_OC1Init
4257                     	xdef	_TIM2_TimeBaseInit
4258                     	xdef	_TIM2_DeInit
4277                     	end
