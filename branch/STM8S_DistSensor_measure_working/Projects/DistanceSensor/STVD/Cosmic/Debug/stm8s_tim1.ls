   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
  45                     ; 52 void TIM1_DeInit(void)
  45                     ; 53 {
  47                     .text:	section	.text,new
  48  0000               _TIM1_DeInit:
  52                     ; 54     TIM1->CR1  = TIM1_CR1_RESET_VALUE;
  54  0000 725f5250      	clr	21072
  55                     ; 55     TIM1->CR2  = TIM1_CR2_RESET_VALUE;
  57  0004 725f5251      	clr	21073
  58                     ; 56     TIM1->SMCR = TIM1_SMCR_RESET_VALUE;
  60  0008 725f5252      	clr	21074
  61                     ; 57     TIM1->ETR  = TIM1_ETR_RESET_VALUE;
  63  000c 725f5253      	clr	21075
  64                     ; 58     TIM1->IER  = TIM1_IER_RESET_VALUE;
  66  0010 725f5254      	clr	21076
  67                     ; 59     TIM1->SR2  = TIM1_SR2_RESET_VALUE;
  69  0014 725f5256      	clr	21078
  70                     ; 61     TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
  72  0018 725f525c      	clr	21084
  73                     ; 62     TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
  75  001c 725f525d      	clr	21085
  76                     ; 64     TIM1->CCMR1 = 0x01;
  78  0020 35015258      	mov	21080,#1
  79                     ; 65     TIM1->CCMR2 = 0x01;
  81  0024 35015259      	mov	21081,#1
  82                     ; 66     TIM1->CCMR3 = 0x01;
  84  0028 3501525a      	mov	21082,#1
  85                     ; 67     TIM1->CCMR4 = 0x01;
  87  002c 3501525b      	mov	21083,#1
  88                     ; 69     TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
  90  0030 725f525c      	clr	21084
  91                     ; 70     TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
  93  0034 725f525d      	clr	21085
  94                     ; 71     TIM1->CCMR1 = TIM1_CCMR1_RESET_VALUE;
  96  0038 725f5258      	clr	21080
  97                     ; 72     TIM1->CCMR2 = TIM1_CCMR2_RESET_VALUE;
  99  003c 725f5259      	clr	21081
 100                     ; 73     TIM1->CCMR3 = TIM1_CCMR3_RESET_VALUE;
 102  0040 725f525a      	clr	21082
 103                     ; 74     TIM1->CCMR4 = TIM1_CCMR4_RESET_VALUE;
 105  0044 725f525b      	clr	21083
 106                     ; 75     TIM1->CNTRH = TIM1_CNTRH_RESET_VALUE;
 108  0048 725f525e      	clr	21086
 109                     ; 76     TIM1->CNTRL = TIM1_CNTRL_RESET_VALUE;
 111  004c 725f525f      	clr	21087
 112                     ; 77     TIM1->PSCRH = TIM1_PSCRH_RESET_VALUE;
 114  0050 725f5260      	clr	21088
 115                     ; 78     TIM1->PSCRL = TIM1_PSCRL_RESET_VALUE;
 117  0054 725f5261      	clr	21089
 118                     ; 79     TIM1->ARRH  = TIM1_ARRH_RESET_VALUE;
 120  0058 35ff5262      	mov	21090,#255
 121                     ; 80     TIM1->ARRL  = TIM1_ARRL_RESET_VALUE;
 123  005c 35ff5263      	mov	21091,#255
 124                     ; 81     TIM1->CCR1H = TIM1_CCR1H_RESET_VALUE;
 126  0060 725f5265      	clr	21093
 127                     ; 82     TIM1->CCR1L = TIM1_CCR1L_RESET_VALUE;
 129  0064 725f5266      	clr	21094
 130                     ; 83     TIM1->CCR2H = TIM1_CCR2H_RESET_VALUE;
 132  0068 725f5267      	clr	21095
 133                     ; 84     TIM1->CCR2L = TIM1_CCR2L_RESET_VALUE;
 135  006c 725f5268      	clr	21096
 136                     ; 85     TIM1->CCR3H = TIM1_CCR3H_RESET_VALUE;
 138  0070 725f5269      	clr	21097
 139                     ; 86     TIM1->CCR3L = TIM1_CCR3L_RESET_VALUE;
 141  0074 725f526a      	clr	21098
 142                     ; 87     TIM1->CCR4H = TIM1_CCR4H_RESET_VALUE;
 144  0078 725f526b      	clr	21099
 145                     ; 88     TIM1->CCR4L = TIM1_CCR4L_RESET_VALUE;
 147  007c 725f526c      	clr	21100
 148                     ; 89     TIM1->OISR  = TIM1_OISR_RESET_VALUE;
 150  0080 725f526f      	clr	21103
 151                     ; 90     TIM1->EGR   = 0x01; /* TIM1_EGR_UG */
 153  0084 35015257      	mov	21079,#1
 154                     ; 91     TIM1->DTR   = TIM1_DTR_RESET_VALUE;
 156  0088 725f526e      	clr	21102
 157                     ; 92     TIM1->BKR   = TIM1_BKR_RESET_VALUE;
 159  008c 725f526d      	clr	21101
 160                     ; 93     TIM1->RCR   = TIM1_RCR_RESET_VALUE;
 162  0090 725f5264      	clr	21092
 163                     ; 94     TIM1->SR1   = TIM1_SR1_RESET_VALUE;
 165  0094 725f5255      	clr	21077
 166                     ; 95 }
 169  0098 81            	ret
 278                     ; 105 void TIM1_TimeBaseInit(uint16_t TIM1_Prescaler,
 278                     ; 106                        TIM1_CounterMode_TypeDef TIM1_CounterMode,
 278                     ; 107                        uint16_t TIM1_Period,
 278                     ; 108                        uint8_t TIM1_RepetitionCounter)
 278                     ; 109 {
 279                     .text:	section	.text,new
 280  0000               _TIM1_TimeBaseInit:
 282  0000 89            	pushw	x
 283       00000000      OFST:	set	0
 286                     ; 112     assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));
 288                     ; 115     TIM1->ARRH = (uint8_t)(TIM1_Period >> 8);
 290  0001 7b06          	ld	a,(OFST+6,sp)
 291  0003 c75262        	ld	21090,a
 292                     ; 116     TIM1->ARRL = (uint8_t)(TIM1_Period);
 294  0006 7b07          	ld	a,(OFST+7,sp)
 295  0008 c75263        	ld	21091,a
 296                     ; 119     TIM1->PSCRH = (uint8_t)(TIM1_Prescaler >> 8);
 298  000b 9e            	ld	a,xh
 299  000c c75260        	ld	21088,a
 300                     ; 120     TIM1->PSCRL = (uint8_t)(TIM1_Prescaler);
 302  000f 9f            	ld	a,xl
 303  0010 c75261        	ld	21089,a
 304                     ; 123     TIM1->CR1 = (uint8_t)((uint8_t)(TIM1->CR1 & (uint8_t)(~(TIM1_CR1_CMS | TIM1_CR1_DIR)))
 304                     ; 124                            | (uint8_t)(TIM1_CounterMode));
 306  0013 c65250        	ld	a,21072
 307  0016 a48f          	and	a,#143
 308  0018 1a05          	or	a,(OFST+5,sp)
 309  001a c75250        	ld	21072,a
 310                     ; 127     TIM1->RCR = TIM1_RepetitionCounter;
 312  001d 7b08          	ld	a,(OFST+8,sp)
 313  001f c75264        	ld	21092,a
 314                     ; 129 }
 317  0022 85            	popw	x
 318  0023 81            	ret
 603                     ; 150 void TIM1_OC1Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 603                     ; 151                   TIM1_OutputState_TypeDef TIM1_OutputState,
 603                     ; 152                   TIM1_OutputNState_TypeDef TIM1_OutputNState,
 603                     ; 153                   uint16_t TIM1_Pulse,
 603                     ; 154                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 603                     ; 155                   TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
 603                     ; 156                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
 603                     ; 157                   TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
 603                     ; 158 {
 604                     .text:	section	.text,new
 605  0000               _TIM1_OC1Init:
 607  0000 89            	pushw	x
 608  0001 5203          	subw	sp,#3
 609       00000003      OFST:	set	3
 612                     ; 160     assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 614                     ; 161     assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 616                     ; 162     assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
 618                     ; 163     assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 620                     ; 164     assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
 622                     ; 165     assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
 624                     ; 166     assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
 626                     ; 170     TIM1->CCER1 &= (uint8_t)(~( TIM1_CCER1_CC1E | TIM1_CCER1_CC1NE 
 626                     ; 171                                | TIM1_CCER1_CC1P | TIM1_CCER1_CC1NP));
 628  0003 c6525c        	ld	a,21084
 629  0006 a4f0          	and	a,#240
 630  0008 c7525c        	ld	21084,a
 631                     ; 174   TIM1->CCER1 |= (uint8_t)((uint8_t)((uint8_t)(TIM1_OutputState & TIM1_CCER1_CC1E)
 631                     ; 175                                      | (uint8_t)(TIM1_OutputNState & TIM1_CCER1_CC1NE))
 631                     ; 176                            | (uint8_t)( (uint8_t)(TIM1_OCPolarity  & TIM1_CCER1_CC1P)
 631                     ; 177                                         | (uint8_t)(TIM1_OCNPolarity & TIM1_CCER1_CC1NP)));
 633  000b 7b0c          	ld	a,(OFST+9,sp)
 634  000d a408          	and	a,#8
 635  000f 6b03          	ld	(OFST+0,sp),a
 636  0011 7b0b          	ld	a,(OFST+8,sp)
 637  0013 a402          	and	a,#2
 638  0015 1a03          	or	a,(OFST+0,sp)
 639  0017 6b02          	ld	(OFST-1,sp),a
 640  0019 7b08          	ld	a,(OFST+5,sp)
 641  001b a404          	and	a,#4
 642  001d 6b01          	ld	(OFST-2,sp),a
 643  001f 9f            	ld	a,xl
 644  0020 a401          	and	a,#1
 645  0022 1a01          	or	a,(OFST-2,sp)
 646  0024 1a02          	or	a,(OFST-1,sp)
 647  0026 ca525c        	or	a,21084
 648  0029 c7525c        	ld	21084,a
 649                     ; 180     TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_OCM)) | 
 649                     ; 181                             (uint8_t)TIM1_OCMode);
 651  002c c65258        	ld	a,21080
 652  002f a48f          	and	a,#143
 653  0031 1a04          	or	a,(OFST+1,sp)
 654  0033 c75258        	ld	21080,a
 655                     ; 184     TIM1->OISR &= (uint8_t)(~(TIM1_OISR_OIS1 | TIM1_OISR_OIS1N));
 657  0036 c6526f        	ld	a,21103
 658  0039 a4fc          	and	a,#252
 659  003b c7526f        	ld	21103,a
 660                     ; 186     TIM1->OISR |= (uint8_t)((uint8_t)( TIM1_OCIdleState & TIM1_OISR_OIS1 ) | 
 660                     ; 187                             (uint8_t)( TIM1_OCNIdleState & TIM1_OISR_OIS1N ));
 662  003e 7b0e          	ld	a,(OFST+11,sp)
 663  0040 a402          	and	a,#2
 664  0042 6b03          	ld	(OFST+0,sp),a
 665  0044 7b0d          	ld	a,(OFST+10,sp)
 666  0046 a401          	and	a,#1
 667  0048 1a03          	or	a,(OFST+0,sp)
 668  004a ca526f        	or	a,21103
 669  004d c7526f        	ld	21103,a
 670                     ; 190     TIM1->CCR1H = (uint8_t)(TIM1_Pulse >> 8);
 672  0050 7b09          	ld	a,(OFST+6,sp)
 673  0052 c75265        	ld	21093,a
 674                     ; 191     TIM1->CCR1L = (uint8_t)(TIM1_Pulse);
 676  0055 7b0a          	ld	a,(OFST+7,sp)
 677  0057 c75266        	ld	21094,a
 678                     ; 192 }
 681  005a 5b05          	addw	sp,#5
 682  005c 81            	ret
 786                     ; 213 void TIM1_OC2Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 786                     ; 214                   TIM1_OutputState_TypeDef TIM1_OutputState,
 786                     ; 215                   TIM1_OutputNState_TypeDef TIM1_OutputNState,
 786                     ; 216                   uint16_t TIM1_Pulse,
 786                     ; 217                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 786                     ; 218                   TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
 786                     ; 219                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
 786                     ; 220                   TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
 786                     ; 221 {
 787                     .text:	section	.text,new
 788  0000               _TIM1_OC2Init:
 790  0000 89            	pushw	x
 791  0001 5203          	subw	sp,#3
 792       00000003      OFST:	set	3
 795                     ; 223     assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 797                     ; 224     assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 799                     ; 225     assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
 801                     ; 226     assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 803                     ; 227     assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
 805                     ; 228     assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
 807                     ; 229     assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
 809                     ; 233     TIM1->CCER1 &= (uint8_t)(~( TIM1_CCER1_CC2E | TIM1_CCER1_CC2NE | 
 809                     ; 234                                 TIM1_CCER1_CC2P | TIM1_CCER1_CC2NP));
 811  0003 c6525c        	ld	a,21084
 812  0006 a40f          	and	a,#15
 813  0008 c7525c        	ld	21084,a
 814                     ; 238     TIM1->CCER1 |= (uint8_t)((uint8_t)((uint8_t)(TIM1_OutputState & TIM1_CCER1_CC2E  ) | 
 814                     ; 239                              (uint8_t)(TIM1_OutputNState & TIM1_CCER1_CC2NE )) | 
 814                     ; 240                              (uint8_t)((uint8_t)(TIM1_OCPolarity  & TIM1_CCER1_CC2P  ) | 
 814                     ; 241                              (uint8_t)(TIM1_OCNPolarity & TIM1_CCER1_CC2NP )));
 816  000b 7b0c          	ld	a,(OFST+9,sp)
 817  000d a480          	and	a,#128
 818  000f 6b03          	ld	(OFST+0,sp),a
 819  0011 7b0b          	ld	a,(OFST+8,sp)
 820  0013 a420          	and	a,#32
 821  0015 1a03          	or	a,(OFST+0,sp)
 822  0017 6b02          	ld	(OFST-1,sp),a
 823  0019 7b08          	ld	a,(OFST+5,sp)
 824  001b a440          	and	a,#64
 825  001d 6b01          	ld	(OFST-2,sp),a
 826  001f 9f            	ld	a,xl
 827  0020 a410          	and	a,#16
 828  0022 1a01          	or	a,(OFST-2,sp)
 829  0024 1a02          	or	a,(OFST-1,sp)
 830  0026 ca525c        	or	a,21084
 831  0029 c7525c        	ld	21084,a
 832                     ; 244     TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_OCM)) | 
 832                     ; 245                              (uint8_t)TIM1_OCMode);
 834  002c c65259        	ld	a,21081
 835  002f a48f          	and	a,#143
 836  0031 1a04          	or	a,(OFST+1,sp)
 837  0033 c75259        	ld	21081,a
 838                     ; 248     TIM1->OISR &= (uint8_t)(~(TIM1_OISR_OIS2 | TIM1_OISR_OIS2N));
 840  0036 c6526f        	ld	a,21103
 841  0039 a4f3          	and	a,#243
 842  003b c7526f        	ld	21103,a
 843                     ; 250     TIM1->OISR |= (uint8_t)((uint8_t)(TIM1_OISR_OIS2 & TIM1_OCIdleState) | 
 843                     ; 251                             (uint8_t)(TIM1_OISR_OIS2N & TIM1_OCNIdleState));
 845  003e 7b0e          	ld	a,(OFST+11,sp)
 846  0040 a408          	and	a,#8
 847  0042 6b03          	ld	(OFST+0,sp),a
 848  0044 7b0d          	ld	a,(OFST+10,sp)
 849  0046 a404          	and	a,#4
 850  0048 1a03          	or	a,(OFST+0,sp)
 851  004a ca526f        	or	a,21103
 852  004d c7526f        	ld	21103,a
 853                     ; 254     TIM1->CCR2H = (uint8_t)(TIM1_Pulse >> 8);
 855  0050 7b09          	ld	a,(OFST+6,sp)
 856  0052 c75267        	ld	21095,a
 857                     ; 255     TIM1->CCR2L = (uint8_t)(TIM1_Pulse);
 859  0055 7b0a          	ld	a,(OFST+7,sp)
 860  0057 c75268        	ld	21096,a
 861                     ; 257 }
 864  005a 5b05          	addw	sp,#5
 865  005c 81            	ret
 969                     ; 278 void TIM1_OC3Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 969                     ; 279                   TIM1_OutputState_TypeDef TIM1_OutputState,
 969                     ; 280                   TIM1_OutputNState_TypeDef TIM1_OutputNState,
 969                     ; 281                   uint16_t TIM1_Pulse,
 969                     ; 282                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 969                     ; 283                   TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
 969                     ; 284                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
 969                     ; 285                   TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
 969                     ; 286 {
 970                     .text:	section	.text,new
 971  0000               _TIM1_OC3Init:
 973  0000 89            	pushw	x
 974  0001 5203          	subw	sp,#3
 975       00000003      OFST:	set	3
 978                     ; 288     assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 980                     ; 289     assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 982                     ; 290     assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
 984                     ; 291     assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 986                     ; 292     assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
 988                     ; 293     assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
 990                     ; 294     assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
 992                     ; 298     TIM1->CCER2 &= (uint8_t)(~( TIM1_CCER2_CC3E | TIM1_CCER2_CC3NE | 
 992                     ; 299                                 TIM1_CCER2_CC3P | TIM1_CCER2_CC3NP));
 994  0003 c6525d        	ld	a,21085
 995  0006 a4f0          	and	a,#240
 996  0008 c7525d        	ld	21085,a
 997                     ; 302     TIM1->CCER2 |= (uint8_t)((uint8_t)((uint8_t)(TIM1_OutputState  & TIM1_CCER2_CC3E   ) |
 997                     ; 303                              (uint8_t)(TIM1_OutputNState & TIM1_CCER2_CC3NE  )) | 
 997                     ; 304                              (uint8_t)((uint8_t)(TIM1_OCPolarity   & TIM1_CCER2_CC3P   ) | 
 997                     ; 305                              (uint8_t)(TIM1_OCNPolarity  & TIM1_CCER2_CC3NP  )));
 999  000b 7b0c          	ld	a,(OFST+9,sp)
1000  000d a408          	and	a,#8
1001  000f 6b03          	ld	(OFST+0,sp),a
1002  0011 7b0b          	ld	a,(OFST+8,sp)
1003  0013 a402          	and	a,#2
1004  0015 1a03          	or	a,(OFST+0,sp)
1005  0017 6b02          	ld	(OFST-1,sp),a
1006  0019 7b08          	ld	a,(OFST+5,sp)
1007  001b a404          	and	a,#4
1008  001d 6b01          	ld	(OFST-2,sp),a
1009  001f 9f            	ld	a,xl
1010  0020 a401          	and	a,#1
1011  0022 1a01          	or	a,(OFST-2,sp)
1012  0024 1a02          	or	a,(OFST-1,sp)
1013  0026 ca525d        	or	a,21085
1014  0029 c7525d        	ld	21085,a
1015                     ; 308     TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM)) | 
1015                     ; 309                              (uint8_t)TIM1_OCMode);
1017  002c c6525a        	ld	a,21082
1018  002f a48f          	and	a,#143
1019  0031 1a04          	or	a,(OFST+1,sp)
1020  0033 c7525a        	ld	21082,a
1021                     ; 312     TIM1->OISR &= (uint8_t)(~(TIM1_OISR_OIS3 | TIM1_OISR_OIS3N));
1023  0036 c6526f        	ld	a,21103
1024  0039 a4cf          	and	a,#207
1025  003b c7526f        	ld	21103,a
1026                     ; 314     TIM1->OISR |= (uint8_t)((uint8_t)(TIM1_OISR_OIS3 & TIM1_OCIdleState) | 
1026                     ; 315                             (uint8_t)(TIM1_OISR_OIS3N & TIM1_OCNIdleState));
1028  003e 7b0e          	ld	a,(OFST+11,sp)
1029  0040 a420          	and	a,#32
1030  0042 6b03          	ld	(OFST+0,sp),a
1031  0044 7b0d          	ld	a,(OFST+10,sp)
1032  0046 a410          	and	a,#16
1033  0048 1a03          	or	a,(OFST+0,sp)
1034  004a ca526f        	or	a,21103
1035  004d c7526f        	ld	21103,a
1036                     ; 318     TIM1->CCR3H = (uint8_t)(TIM1_Pulse >> 8);
1038  0050 7b09          	ld	a,(OFST+6,sp)
1039  0052 c75269        	ld	21097,a
1040                     ; 319     TIM1->CCR3L = (uint8_t)(TIM1_Pulse);
1042  0055 7b0a          	ld	a,(OFST+7,sp)
1043  0057 c7526a        	ld	21098,a
1044                     ; 321 }
1047  005a 5b05          	addw	sp,#5
1048  005c 81            	ret
1122                     ; 336 void TIM1_OC4Init(TIM1_OCMode_TypeDef TIM1_OCMode,
1122                     ; 337                   TIM1_OutputState_TypeDef TIM1_OutputState,
1122                     ; 338                   uint16_t TIM1_Pulse,
1122                     ; 339                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
1122                     ; 340                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState)
1122                     ; 341 {
1123                     .text:	section	.text,new
1124  0000               _TIM1_OC4Init:
1126  0000 89            	pushw	x
1127  0001 88            	push	a
1128       00000001      OFST:	set	1
1131                     ; 343     assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
1133                     ; 344     assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
1135                     ; 345     assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
1137                     ; 346     assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
1139                     ; 349     TIM1->CCER2 &= (uint8_t)(~(TIM1_CCER2_CC4E | TIM1_CCER2_CC4P));
1141  0002 c6525d        	ld	a,21085
1142  0005 a4cf          	and	a,#207
1143  0007 c7525d        	ld	21085,a
1144                     ; 351     TIM1->CCER2 |= (uint8_t)((uint8_t)(TIM1_OutputState & TIM1_CCER2_CC4E ) |  
1144                     ; 352                              (uint8_t)(TIM1_OCPolarity  & TIM1_CCER2_CC4P ));
1146  000a 7b08          	ld	a,(OFST+7,sp)
1147  000c a420          	and	a,#32
1148  000e 6b01          	ld	(OFST+0,sp),a
1149  0010 9f            	ld	a,xl
1150  0011 a410          	and	a,#16
1151  0013 1a01          	or	a,(OFST+0,sp)
1152  0015 ca525d        	or	a,21085
1153  0018 c7525d        	ld	21085,a
1154                     ; 355     TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_OCM)) | 
1154                     ; 356                             TIM1_OCMode);
1156  001b c6525b        	ld	a,21083
1157  001e a48f          	and	a,#143
1158  0020 1a02          	or	a,(OFST+1,sp)
1159  0022 c7525b        	ld	21083,a
1160                     ; 359     if (TIM1_OCIdleState != TIM1_OCIDLESTATE_RESET)
1162  0025 0d09          	tnz	(OFST+8,sp)
1163  0027 270a          	jreq	L534
1164                     ; 361         TIM1->OISR |= (uint8_t)(~TIM1_CCER2_CC4P);
1166  0029 c6526f        	ld	a,21103
1167  002c aadf          	or	a,#223
1168  002e c7526f        	ld	21103,a
1170  0031 2004          	jra	L734
1171  0033               L534:
1172                     ; 365         TIM1->OISR &= (uint8_t)(~TIM1_OISR_OIS4);
1174  0033 721d526f      	bres	21103,#6
1175  0037               L734:
1176                     ; 369     TIM1->CCR4H = (uint8_t)(TIM1_Pulse >> 8);
1178  0037 7b06          	ld	a,(OFST+5,sp)
1179  0039 c7526b        	ld	21099,a
1180                     ; 370     TIM1->CCR4L = (uint8_t)(TIM1_Pulse);
1182  003c 7b07          	ld	a,(OFST+6,sp)
1183  003e c7526c        	ld	21100,a
1184                     ; 372 }
1187  0041 5b03          	addw	sp,#3
1188  0043 81            	ret
1393                     ; 387 void TIM1_BDTRConfig(TIM1_OSSIState_TypeDef TIM1_OSSIState,
1393                     ; 388                      TIM1_LockLevel_TypeDef TIM1_LockLevel,
1393                     ; 389                      uint8_t TIM1_DeadTime,
1393                     ; 390                      TIM1_BreakState_TypeDef TIM1_Break,
1393                     ; 391                      TIM1_BreakPolarity_TypeDef TIM1_BreakPolarity,
1393                     ; 392                      TIM1_AutomaticOutput_TypeDef TIM1_AutomaticOutput)
1393                     ; 393 {
1394                     .text:	section	.text,new
1395  0000               _TIM1_BDTRConfig:
1397  0000 89            	pushw	x
1398  0001 88            	push	a
1399       00000001      OFST:	set	1
1402                     ; 395     assert_param(IS_TIM1_OSSI_STATE_OK(TIM1_OSSIState));
1404                     ; 396     assert_param(IS_TIM1_LOCK_LEVEL_OK(TIM1_LockLevel));
1406                     ; 397     assert_param(IS_TIM1_BREAK_STATE_OK(TIM1_Break));
1408                     ; 398     assert_param(IS_TIM1_BREAK_POLARITY_OK(TIM1_BreakPolarity));
1410                     ; 399     assert_param(IS_TIM1_AUTOMATIC_OUTPUT_STATE_OK(TIM1_AutomaticOutput));
1412                     ; 401     TIM1->DTR = (uint8_t)(TIM1_DeadTime);
1414  0002 7b06          	ld	a,(OFST+5,sp)
1415  0004 c7526e        	ld	21102,a
1416                     ; 405     TIM1->BKR  =  (uint8_t)((uint8_t)(TIM1_OSSIState | (uint8_t)TIM1_LockLevel)  | 
1416                     ; 406                             (uint8_t)((uint8_t)(TIM1_Break | (uint8_t)TIM1_BreakPolarity)  | 
1416                     ; 407                             (uint8_t)TIM1_AutomaticOutput));
1418  0007 7b07          	ld	a,(OFST+6,sp)
1419  0009 1a08          	or	a,(OFST+7,sp)
1420  000b 1a09          	or	a,(OFST+8,sp)
1421  000d 6b01          	ld	(OFST+0,sp),a
1422  000f 9f            	ld	a,xl
1423  0010 1a02          	or	a,(OFST+1,sp)
1424  0012 1a01          	or	a,(OFST+0,sp)
1425  0014 c7526d        	ld	21101,a
1426                     ; 409 }
1429  0017 5b03          	addw	sp,#3
1430  0019 81            	ret
1632                     ; 423 void TIM1_ICInit(TIM1_Channel_TypeDef TIM1_Channel,
1632                     ; 424                  TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
1632                     ; 425                  TIM1_ICSelection_TypeDef TIM1_ICSelection,
1632                     ; 426                  TIM1_ICPSC_TypeDef TIM1_ICPrescaler,
1632                     ; 427                  uint8_t TIM1_ICFilter)
1632                     ; 428 {
1633                     .text:	section	.text,new
1634  0000               _TIM1_ICInit:
1636  0000 89            	pushw	x
1637       00000000      OFST:	set	0
1640                     ; 431     assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
1642                     ; 432     assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
1644                     ; 433     assert_param(IS_TIM1_IC_SELECTION_OK(TIM1_ICSelection));
1646                     ; 434     assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_ICPrescaler));
1648                     ; 435     assert_param(IS_TIM1_IC_FILTER_OK(TIM1_ICFilter));
1650                     ; 437     if (TIM1_Channel == TIM1_CHANNEL_1)
1652  0001 9e            	ld	a,xh
1653  0002 4d            	tnz	a
1654  0003 2614          	jrne	L766
1655                     ; 440         TI1_Config((uint8_t)TIM1_ICPolarity,
1655                     ; 441                    (uint8_t)TIM1_ICSelection,
1655                     ; 442                    (uint8_t)TIM1_ICFilter);
1657  0005 7b07          	ld	a,(OFST+7,sp)
1658  0007 88            	push	a
1659  0008 7b06          	ld	a,(OFST+6,sp)
1660  000a 97            	ld	xl,a
1661  000b 7b03          	ld	a,(OFST+3,sp)
1662  000d 95            	ld	xh,a
1663  000e cd0000        	call	L3_TI1_Config
1665  0011 84            	pop	a
1666                     ; 444         TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1668  0012 7b06          	ld	a,(OFST+6,sp)
1669  0014 cd0000        	call	_TIM1_SetIC1Prescaler
1672  0017 2046          	jra	L176
1673  0019               L766:
1674                     ; 446     else if (TIM1_Channel == TIM1_CHANNEL_2)
1676  0019 7b01          	ld	a,(OFST+1,sp)
1677  001b a101          	cp	a,#1
1678  001d 2614          	jrne	L376
1679                     ; 449         TI2_Config((uint8_t)TIM1_ICPolarity,
1679                     ; 450                    (uint8_t)TIM1_ICSelection,
1679                     ; 451                    (uint8_t)TIM1_ICFilter);
1681  001f 7b07          	ld	a,(OFST+7,sp)
1682  0021 88            	push	a
1683  0022 7b06          	ld	a,(OFST+6,sp)
1684  0024 97            	ld	xl,a
1685  0025 7b03          	ld	a,(OFST+3,sp)
1686  0027 95            	ld	xh,a
1687  0028 cd0000        	call	L5_TI2_Config
1689  002b 84            	pop	a
1690                     ; 453         TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1692  002c 7b06          	ld	a,(OFST+6,sp)
1693  002e cd0000        	call	_TIM1_SetIC2Prescaler
1696  0031 202c          	jra	L176
1697  0033               L376:
1698                     ; 455     else if (TIM1_Channel == TIM1_CHANNEL_3)
1700  0033 7b01          	ld	a,(OFST+1,sp)
1701  0035 a102          	cp	a,#2
1702  0037 2614          	jrne	L776
1703                     ; 458         TI3_Config((uint8_t)TIM1_ICPolarity,
1703                     ; 459                    (uint8_t)TIM1_ICSelection,
1703                     ; 460                    (uint8_t)TIM1_ICFilter);
1705  0039 7b07          	ld	a,(OFST+7,sp)
1706  003b 88            	push	a
1707  003c 7b06          	ld	a,(OFST+6,sp)
1708  003e 97            	ld	xl,a
1709  003f 7b03          	ld	a,(OFST+3,sp)
1710  0041 95            	ld	xh,a
1711  0042 cd0000        	call	L7_TI3_Config
1713  0045 84            	pop	a
1714                     ; 462         TIM1_SetIC3Prescaler(TIM1_ICPrescaler);
1716  0046 7b06          	ld	a,(OFST+6,sp)
1717  0048 cd0000        	call	_TIM1_SetIC3Prescaler
1720  004b 2012          	jra	L176
1721  004d               L776:
1722                     ; 467         TI4_Config((uint8_t)TIM1_ICPolarity,
1722                     ; 468                    (uint8_t)TIM1_ICSelection,
1722                     ; 469                    (uint8_t)TIM1_ICFilter);
1724  004d 7b07          	ld	a,(OFST+7,sp)
1725  004f 88            	push	a
1726  0050 7b06          	ld	a,(OFST+6,sp)
1727  0052 97            	ld	xl,a
1728  0053 7b03          	ld	a,(OFST+3,sp)
1729  0055 95            	ld	xh,a
1730  0056 cd0000        	call	L11_TI4_Config
1732  0059 84            	pop	a
1733                     ; 471         TIM1_SetIC4Prescaler(TIM1_ICPrescaler);
1735  005a 7b06          	ld	a,(OFST+6,sp)
1736  005c cd0000        	call	_TIM1_SetIC4Prescaler
1738  005f               L176:
1739                     ; 474 }
1742  005f 85            	popw	x
1743  0060 81            	ret
1839                     ; 490 void TIM1_PWMIConfig(TIM1_Channel_TypeDef TIM1_Channel,
1839                     ; 491                      TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
1839                     ; 492                      TIM1_ICSelection_TypeDef TIM1_ICSelection,
1839                     ; 493                      TIM1_ICPSC_TypeDef TIM1_ICPrescaler,
1839                     ; 494                      uint8_t TIM1_ICFilter)
1839                     ; 495 {
1840                     .text:	section	.text,new
1841  0000               _TIM1_PWMIConfig:
1843  0000 89            	pushw	x
1844  0001 89            	pushw	x
1845       00000002      OFST:	set	2
1848                     ; 496     uint8_t icpolarity = TIM1_ICPOLARITY_RISING;
1850                     ; 497     uint8_t icselection = TIM1_ICSELECTION_DIRECTTI;
1852                     ; 500     assert_param(IS_TIM1_PWMI_CHANNEL_OK(TIM1_Channel));
1854                     ; 501     assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
1856                     ; 502     assert_param(IS_TIM1_IC_SELECTION_OK(TIM1_ICSelection));
1858                     ; 503     assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_ICPrescaler));
1860                     ; 506     if (TIM1_ICPolarity != TIM1_ICPOLARITY_FALLING)
1862  0002 9f            	ld	a,xl
1863  0003 a101          	cp	a,#1
1864  0005 2706          	jreq	L157
1865                     ; 508         icpolarity = TIM1_ICPOLARITY_FALLING;
1867  0007 a601          	ld	a,#1
1868  0009 6b01          	ld	(OFST-1,sp),a
1870  000b 2002          	jra	L357
1871  000d               L157:
1872                     ; 512         icpolarity = TIM1_ICPOLARITY_RISING;
1874  000d 0f01          	clr	(OFST-1,sp)
1875  000f               L357:
1876                     ; 516     if (TIM1_ICSelection == TIM1_ICSELECTION_DIRECTTI)
1878  000f 7b07          	ld	a,(OFST+5,sp)
1879  0011 a101          	cp	a,#1
1880  0013 2606          	jrne	L557
1881                     ; 518         icselection = TIM1_ICSELECTION_INDIRECTTI;
1883  0015 a602          	ld	a,#2
1884  0017 6b02          	ld	(OFST+0,sp),a
1886  0019 2004          	jra	L757
1887  001b               L557:
1888                     ; 522         icselection = TIM1_ICSELECTION_DIRECTTI;
1890  001b a601          	ld	a,#1
1891  001d 6b02          	ld	(OFST+0,sp),a
1892  001f               L757:
1893                     ; 525     if (TIM1_Channel == TIM1_CHANNEL_1)
1895  001f 0d03          	tnz	(OFST+1,sp)
1896  0021 2626          	jrne	L167
1897                     ; 528         TI1_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSelection,
1897                     ; 529                    (uint8_t)TIM1_ICFilter);
1899  0023 7b09          	ld	a,(OFST+7,sp)
1900  0025 88            	push	a
1901  0026 7b08          	ld	a,(OFST+6,sp)
1902  0028 97            	ld	xl,a
1903  0029 7b05          	ld	a,(OFST+3,sp)
1904  002b 95            	ld	xh,a
1905  002c cd0000        	call	L3_TI1_Config
1907  002f 84            	pop	a
1908                     ; 532         TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1910  0030 7b08          	ld	a,(OFST+6,sp)
1911  0032 cd0000        	call	_TIM1_SetIC1Prescaler
1913                     ; 535         TI2_Config(icpolarity, icselection, TIM1_ICFilter);
1915  0035 7b09          	ld	a,(OFST+7,sp)
1916  0037 88            	push	a
1917  0038 7b03          	ld	a,(OFST+1,sp)
1918  003a 97            	ld	xl,a
1919  003b 7b02          	ld	a,(OFST+0,sp)
1920  003d 95            	ld	xh,a
1921  003e cd0000        	call	L5_TI2_Config
1923  0041 84            	pop	a
1924                     ; 538         TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1926  0042 7b08          	ld	a,(OFST+6,sp)
1927  0044 cd0000        	call	_TIM1_SetIC2Prescaler
1930  0047 2024          	jra	L367
1931  0049               L167:
1932                     ; 543         TI2_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSelection,
1932                     ; 544                    (uint8_t)TIM1_ICFilter);
1934  0049 7b09          	ld	a,(OFST+7,sp)
1935  004b 88            	push	a
1936  004c 7b08          	ld	a,(OFST+6,sp)
1937  004e 97            	ld	xl,a
1938  004f 7b05          	ld	a,(OFST+3,sp)
1939  0051 95            	ld	xh,a
1940  0052 cd0000        	call	L5_TI2_Config
1942  0055 84            	pop	a
1943                     ; 547         TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1945  0056 7b08          	ld	a,(OFST+6,sp)
1946  0058 cd0000        	call	_TIM1_SetIC2Prescaler
1948                     ; 550         TI1_Config(icpolarity, icselection, TIM1_ICFilter);
1950  005b 7b09          	ld	a,(OFST+7,sp)
1951  005d 88            	push	a
1952  005e 7b03          	ld	a,(OFST+1,sp)
1953  0060 97            	ld	xl,a
1954  0061 7b02          	ld	a,(OFST+0,sp)
1955  0063 95            	ld	xh,a
1956  0064 cd0000        	call	L3_TI1_Config
1958  0067 84            	pop	a
1959                     ; 553         TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1961  0068 7b08          	ld	a,(OFST+6,sp)
1962  006a cd0000        	call	_TIM1_SetIC1Prescaler
1964  006d               L367:
1965                     ; 555 }
1968  006d 5b04          	addw	sp,#4
1969  006f 81            	ret
2024                     ; 563 void TIM1_Cmd(FunctionalState NewState)
2024                     ; 564 {
2025                     .text:	section	.text,new
2026  0000               _TIM1_Cmd:
2030                     ; 566     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2032                     ; 569     if (NewState != DISABLE)
2034  0000 4d            	tnz	a
2035  0001 2706          	jreq	L3101
2036                     ; 571         TIM1->CR1 |= TIM1_CR1_CEN;
2038  0003 72105250      	bset	21072,#0
2040  0007 2004          	jra	L5101
2041  0009               L3101:
2042                     ; 575         TIM1->CR1 &= (uint8_t)(~TIM1_CR1_CEN);
2044  0009 72115250      	bres	21072,#0
2045  000d               L5101:
2046                     ; 577 }
2049  000d 81            	ret
2085                     ; 585 void TIM1_CtrlPWMOutputs(FunctionalState NewState)
2085                     ; 586 {
2086                     .text:	section	.text,new
2087  0000               _TIM1_CtrlPWMOutputs:
2091                     ; 588     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2093                     ; 592     if (NewState != DISABLE)
2095  0000 4d            	tnz	a
2096  0001 2706          	jreq	L5301
2097                     ; 594         TIM1->BKR |= TIM1_BKR_MOE;
2099  0003 721e526d      	bset	21101,#7
2101  0007 2004          	jra	L7301
2102  0009               L5301:
2103                     ; 598         TIM1->BKR &= (uint8_t)(~TIM1_BKR_MOE);
2105  0009 721f526d      	bres	21101,#7
2106  000d               L7301:
2107                     ; 600 }
2110  000d 81            	ret
2217                     ; 619 void TIM1_ITConfig(TIM1_IT_TypeDef  TIM1_IT, FunctionalState NewState)
2217                     ; 620 {
2218                     .text:	section	.text,new
2219  0000               _TIM1_ITConfig:
2221  0000 89            	pushw	x
2222       00000000      OFST:	set	0
2225                     ; 622     assert_param(IS_TIM1_IT_OK(TIM1_IT));
2227                     ; 623     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2229                     ; 625     if (NewState != DISABLE)
2231  0001 9f            	ld	a,xl
2232  0002 4d            	tnz	a
2233  0003 2709          	jreq	L7011
2234                     ; 628         TIM1->IER |= (uint8_t)TIM1_IT;
2236  0005 9e            	ld	a,xh
2237  0006 ca5254        	or	a,21076
2238  0009 c75254        	ld	21076,a
2240  000c 2009          	jra	L1111
2241  000e               L7011:
2242                     ; 633         TIM1->IER &= (uint8_t)(~(uint8_t)TIM1_IT);
2244  000e 7b01          	ld	a,(OFST+1,sp)
2245  0010 43            	cpl	a
2246  0011 c45254        	and	a,21076
2247  0014 c75254        	ld	21076,a
2248  0017               L1111:
2249                     ; 635 }
2252  0017 85            	popw	x
2253  0018 81            	ret
2277                     ; 642 void TIM1_InternalClockConfig(void)
2277                     ; 643 {
2278                     .text:	section	.text,new
2279  0000               _TIM1_InternalClockConfig:
2283                     ; 645     TIM1->SMCR &= (uint8_t)(~TIM1_SMCR_SMS);
2285  0000 c65252        	ld	a,21074
2286  0003 a4f8          	and	a,#248
2287  0005 c75252        	ld	21074,a
2288                     ; 646 }
2291  0008 81            	ret
2408                     ; 664 void TIM1_ETRClockMode1Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2408                     ; 665                               TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2408                     ; 666                               uint8_t ExtTRGFilter)
2408                     ; 667 {
2409                     .text:	section	.text,new
2410  0000               _TIM1_ETRClockMode1Config:
2412  0000 89            	pushw	x
2413       00000000      OFST:	set	0
2416                     ; 669     assert_param(IS_TIM1_EXT_PRESCALER_OK(TIM1_ExtTRGPrescaler));
2418                     ; 670     assert_param(IS_TIM1_EXT_POLARITY_OK(TIM1_ExtTRGPolarity));
2420                     ; 673     TIM1_ETRConfig(TIM1_ExtTRGPrescaler, TIM1_ExtTRGPolarity, ExtTRGFilter);
2422  0001 7b05          	ld	a,(OFST+5,sp)
2423  0003 88            	push	a
2424  0004 9f            	ld	a,xl
2425  0005 97            	ld	xl,a
2426  0006 7b02          	ld	a,(OFST+2,sp)
2427  0008 95            	ld	xh,a
2428  0009 cd0000        	call	_TIM1_ETRConfig
2430  000c 84            	pop	a
2431                     ; 676     TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~(uint8_t)(TIM1_SMCR_SMS | TIM1_SMCR_TS )))
2431                     ; 677                            | (uint8_t)((uint8_t)TIM1_SLAVEMODE_EXTERNAL1 | TIM1_TS_ETRF ));
2433  000d c65252        	ld	a,21074
2434  0010 a488          	and	a,#136
2435  0012 aa77          	or	a,#119
2436  0014 c75252        	ld	21074,a
2437                     ; 678 }
2440  0017 85            	popw	x
2441  0018 81            	ret
2499                     ; 696 void TIM1_ETRClockMode2Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2499                     ; 697                               TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2499                     ; 698                               uint8_t ExtTRGFilter)
2499                     ; 699 {
2500                     .text:	section	.text,new
2501  0000               _TIM1_ETRClockMode2Config:
2503  0000 89            	pushw	x
2504       00000000      OFST:	set	0
2507                     ; 701     assert_param(IS_TIM1_EXT_PRESCALER_OK(TIM1_ExtTRGPrescaler));
2509                     ; 702     assert_param(IS_TIM1_EXT_POLARITY_OK(TIM1_ExtTRGPolarity));
2511                     ; 705     TIM1_ETRConfig(TIM1_ExtTRGPrescaler, TIM1_ExtTRGPolarity, ExtTRGFilter);
2513  0001 7b05          	ld	a,(OFST+5,sp)
2514  0003 88            	push	a
2515  0004 9f            	ld	a,xl
2516  0005 97            	ld	xl,a
2517  0006 7b02          	ld	a,(OFST+2,sp)
2518  0008 95            	ld	xh,a
2519  0009 cd0000        	call	_TIM1_ETRConfig
2521  000c 84            	pop	a
2522                     ; 708     TIM1->ETR |= TIM1_ETR_ECE;
2524  000d 721c5253      	bset	21075,#6
2525                     ; 709 }
2528  0011 85            	popw	x
2529  0012 81            	ret
2585                     ; 727 void TIM1_ETRConfig(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2585                     ; 728                     TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2585                     ; 729                     uint8_t ExtTRGFilter)
2585                     ; 730 {
2586                     .text:	section	.text,new
2587  0000               _TIM1_ETRConfig:
2589  0000 89            	pushw	x
2590       00000000      OFST:	set	0
2593                     ; 732     assert_param(IS_TIM1_EXT_TRG_FILTER_OK(ExtTRGFilter));
2595                     ; 734     TIM1->ETR |= (uint8_t)((uint8_t)(TIM1_ExtTRGPrescaler | (uint8_t)TIM1_ExtTRGPolarity )|
2595                     ; 735                       (uint8_t)ExtTRGFilter );
2597  0001 9f            	ld	a,xl
2598  0002 1a01          	or	a,(OFST+1,sp)
2599  0004 1a05          	or	a,(OFST+5,sp)
2600  0006 ca5253        	or	a,21075
2601  0009 c75253        	ld	21075,a
2602                     ; 736 }
2605  000c 85            	popw	x
2606  000d 81            	ret
2695                     ; 753 void TIM1_TIxExternalClockConfig(TIM1_TIxExternalCLK1Source_TypeDef TIM1_TIxExternalCLKSource,
2695                     ; 754                                  TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
2695                     ; 755                                  uint8_t ICFilter)
2695                     ; 756 {
2696                     .text:	section	.text,new
2697  0000               _TIM1_TIxExternalClockConfig:
2699  0000 89            	pushw	x
2700       00000000      OFST:	set	0
2703                     ; 758     assert_param(IS_TIM1_TIXCLK_SOURCE_OK(TIM1_TIxExternalCLKSource));
2705                     ; 759     assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
2707                     ; 760     assert_param(IS_TIM1_IC_FILTER_OK(ICFilter));
2709                     ; 763     if (TIM1_TIxExternalCLKSource == TIM1_TIXEXTERNALCLK1SOURCE_TI2)
2711  0001 9e            	ld	a,xh
2712  0002 a160          	cp	a,#96
2713  0004 260f          	jrne	L1131
2714                     ; 765         TI2_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSELECTION_DIRECTTI, (uint8_t)ICFilter);
2716  0006 7b05          	ld	a,(OFST+5,sp)
2717  0008 88            	push	a
2718  0009 ae0001        	ldw	x,#1
2719  000c 7b03          	ld	a,(OFST+3,sp)
2720  000e 95            	ld	xh,a
2721  000f cd0000        	call	L5_TI2_Config
2723  0012 84            	pop	a
2725  0013 200d          	jra	L3131
2726  0015               L1131:
2727                     ; 769         TI1_Config((uint8_t)TIM1_ICPolarity, (uint8_t)TIM1_ICSELECTION_DIRECTTI, (uint8_t)ICFilter);
2729  0015 7b05          	ld	a,(OFST+5,sp)
2730  0017 88            	push	a
2731  0018 ae0001        	ldw	x,#1
2732  001b 7b03          	ld	a,(OFST+3,sp)
2733  001d 95            	ld	xh,a
2734  001e cd0000        	call	L3_TI1_Config
2736  0021 84            	pop	a
2737  0022               L3131:
2738                     ; 773     TIM1_SelectInputTrigger((TIM1_TS_TypeDef)TIM1_TIxExternalCLKSource);
2740  0022 7b01          	ld	a,(OFST+1,sp)
2741  0024 cd0000        	call	_TIM1_SelectInputTrigger
2743                     ; 776     TIM1->SMCR |= (uint8_t)(TIM1_SLAVEMODE_EXTERNAL1);
2745  0027 c65252        	ld	a,21074
2746  002a aa07          	or	a,#7
2747  002c c75252        	ld	21074,a
2748                     ; 777 }
2751  002f 85            	popw	x
2752  0030 81            	ret
2837                     ; 789 void TIM1_SelectInputTrigger(TIM1_TS_TypeDef TIM1_InputTriggerSource)
2837                     ; 790 {
2838                     .text:	section	.text,new
2839  0000               _TIM1_SelectInputTrigger:
2841  0000 88            	push	a
2842       00000000      OFST:	set	0
2845                     ; 792     assert_param(IS_TIM1_TRIGGER_SELECTION_OK(TIM1_InputTriggerSource));
2847                     ; 795     TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~TIM1_SMCR_TS)) | (uint8_t)TIM1_InputTriggerSource);
2849  0001 c65252        	ld	a,21074
2850  0004 a48f          	and	a,#143
2851  0006 1a01          	or	a,(OFST+1,sp)
2852  0008 c75252        	ld	21074,a
2853                     ; 796 }
2856  000b 84            	pop	a
2857  000c 81            	ret
2893                     ; 806 void TIM1_UpdateDisableConfig(FunctionalState NewState)
2893                     ; 807 {
2894                     .text:	section	.text,new
2895  0000               _TIM1_UpdateDisableConfig:
2899                     ; 809     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2901                     ; 812     if (NewState != DISABLE)
2903  0000 4d            	tnz	a
2904  0001 2706          	jreq	L1731
2905                     ; 814         TIM1->CR1 |= TIM1_CR1_UDIS;
2907  0003 72125250      	bset	21072,#1
2909  0007 2004          	jra	L3731
2910  0009               L1731:
2911                     ; 818         TIM1->CR1 &= (uint8_t)(~TIM1_CR1_UDIS);
2913  0009 72135250      	bres	21072,#1
2914  000d               L3731:
2915                     ; 820 }
2918  000d 81            	ret
2976                     ; 830 void TIM1_UpdateRequestConfig(TIM1_UpdateSource_TypeDef TIM1_UpdateSource)
2976                     ; 831 {
2977                     .text:	section	.text,new
2978  0000               _TIM1_UpdateRequestConfig:
2982                     ; 833     assert_param(IS_TIM1_UPDATE_SOURCE_OK(TIM1_UpdateSource));
2984                     ; 836     if (TIM1_UpdateSource != TIM1_UPDATESOURCE_GLOBAL)
2986  0000 4d            	tnz	a
2987  0001 2706          	jreq	L3241
2988                     ; 838         TIM1->CR1 |= TIM1_CR1_URS;
2990  0003 72145250      	bset	21072,#2
2992  0007 2004          	jra	L5241
2993  0009               L3241:
2994                     ; 842         TIM1->CR1 &= (uint8_t)(~TIM1_CR1_URS);
2996  0009 72155250      	bres	21072,#2
2997  000d               L5241:
2998                     ; 844 }
3001  000d 81            	ret
3037                     ; 853 void TIM1_SelectHallSensor(FunctionalState NewState)
3037                     ; 854 {
3038                     .text:	section	.text,new
3039  0000               _TIM1_SelectHallSensor:
3043                     ; 856     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3045                     ; 859     if (NewState != DISABLE)
3047  0000 4d            	tnz	a
3048  0001 2706          	jreq	L5441
3049                     ; 861         TIM1->CR2 |= TIM1_CR2_TI1S;
3051  0003 721e5251      	bset	21073,#7
3053  0007 2004          	jra	L7441
3054  0009               L5441:
3055                     ; 865         TIM1->CR2 &= (uint8_t)(~TIM1_CR2_TI1S);
3057  0009 721f5251      	bres	21073,#7
3058  000d               L7441:
3059                     ; 867 }
3062  000d 81            	ret
3119                     ; 878 void TIM1_SelectOnePulseMode(TIM1_OPMode_TypeDef TIM1_OPMode)
3119                     ; 879 {
3120                     .text:	section	.text,new
3121  0000               _TIM1_SelectOnePulseMode:
3125                     ; 881     assert_param(IS_TIM1_OPM_MODE_OK(TIM1_OPMode));
3127                     ; 884     if (TIM1_OPMode != TIM1_OPMODE_REPETITIVE)
3129  0000 4d            	tnz	a
3130  0001 2706          	jreq	L7741
3131                     ; 886         TIM1->CR1 |= TIM1_CR1_OPM;
3133  0003 72165250      	bset	21072,#3
3135  0007 2004          	jra	L1051
3136  0009               L7741:
3137                     ; 890         TIM1->CR1 &= (uint8_t)(~TIM1_CR1_OPM);
3139  0009 72175250      	bres	21072,#3
3140  000d               L1051:
3141                     ; 893 }
3144  000d 81            	ret
3242                     ; 909 void TIM1_SelectOutputTrigger(TIM1_TRGOSource_TypeDef TIM1_TRGOSource)
3242                     ; 910 {
3243                     .text:	section	.text,new
3244  0000               _TIM1_SelectOutputTrigger:
3246  0000 88            	push	a
3247       00000000      OFST:	set	0
3250                     ; 912     assert_param(IS_TIM1_TRGO_SOURCE_OK(TIM1_TRGOSource));
3252                     ; 915     TIM1->CR2 = (uint8_t)((uint8_t)(TIM1->CR2 & (uint8_t)(~TIM1_CR2_MMS)) | 
3252                     ; 916                           (uint8_t) TIM1_TRGOSource);
3254  0001 c65251        	ld	a,21073
3255  0004 a48f          	and	a,#143
3256  0006 1a01          	or	a,(OFST+1,sp)
3257  0008 c75251        	ld	21073,a
3258                     ; 917 }
3261  000b 84            	pop	a
3262  000c 81            	ret
3336                     ; 929 void TIM1_SelectSlaveMode(TIM1_SlaveMode_TypeDef TIM1_SlaveMode)
3336                     ; 930 {
3337                     .text:	section	.text,new
3338  0000               _TIM1_SelectSlaveMode:
3340  0000 88            	push	a
3341       00000000      OFST:	set	0
3344                     ; 933     assert_param(IS_TIM1_SLAVE_MODE_OK(TIM1_SlaveMode));
3346                     ; 936     TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(~TIM1_SMCR_SMS)) |
3346                     ; 937                            (uint8_t)TIM1_SlaveMode);
3348  0001 c65252        	ld	a,21074
3349  0004 a4f8          	and	a,#248
3350  0006 1a01          	or	a,(OFST+1,sp)
3351  0008 c75252        	ld	21074,a
3352                     ; 939 }
3355  000b 84            	pop	a
3356  000c 81            	ret
3392                     ; 947 void TIM1_SelectMasterSlaveMode(FunctionalState NewState)
3392                     ; 948 {
3393                     .text:	section	.text,new
3394  0000               _TIM1_SelectMasterSlaveMode:
3398                     ; 950     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3400                     ; 953     if (NewState != DISABLE)
3402  0000 4d            	tnz	a
3403  0001 2706          	jreq	L3161
3404                     ; 955         TIM1->SMCR |= TIM1_SMCR_MSM;
3406  0003 721e5252      	bset	21074,#7
3408  0007 2004          	jra	L5161
3409  0009               L3161:
3410                     ; 959         TIM1->SMCR &= (uint8_t)(~TIM1_SMCR_MSM);
3412  0009 721f5252      	bres	21074,#7
3413  000d               L5161:
3414                     ; 961 }
3417  000d 81            	ret
3503                     ; 983 void TIM1_EncoderInterfaceConfig(TIM1_EncoderMode_TypeDef TIM1_EncoderMode,
3503                     ; 984                                  TIM1_ICPolarity_TypeDef TIM1_IC1Polarity,
3503                     ; 985                                  TIM1_ICPolarity_TypeDef TIM1_IC2Polarity)
3503                     ; 986 {
3504                     .text:	section	.text,new
3505  0000               _TIM1_EncoderInterfaceConfig:
3507  0000 89            	pushw	x
3508       00000000      OFST:	set	0
3511                     ; 990     assert_param(IS_TIM1_ENCODER_MODE_OK(TIM1_EncoderMode));
3513                     ; 991     assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_IC1Polarity));
3515                     ; 992     assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_IC2Polarity));
3517                     ; 995     if (TIM1_IC1Polarity != TIM1_ICPOLARITY_RISING)
3519  0001 9f            	ld	a,xl
3520  0002 4d            	tnz	a
3521  0003 2706          	jreq	L7561
3522                     ; 997         TIM1->CCER1 |= TIM1_CCER1_CC1P;
3524  0005 7212525c      	bset	21084,#1
3526  0009 2004          	jra	L1661
3527  000b               L7561:
3528                     ; 1001         TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
3530  000b 7213525c      	bres	21084,#1
3531  000f               L1661:
3532                     ; 1004     if (TIM1_IC2Polarity != TIM1_ICPOLARITY_RISING)
3534  000f 0d05          	tnz	(OFST+5,sp)
3535  0011 2706          	jreq	L3661
3536                     ; 1006         TIM1->CCER1 |= TIM1_CCER1_CC2P;
3538  0013 721a525c      	bset	21084,#5
3540  0017 2004          	jra	L5661
3541  0019               L3661:
3542                     ; 1010         TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2P);
3544  0019 721b525c      	bres	21084,#5
3545  001d               L5661:
3546                     ; 1013     TIM1->SMCR = (uint8_t)((uint8_t)(TIM1->SMCR & (uint8_t)(TIM1_SMCR_MSM | TIM1_SMCR_TS))
3546                     ; 1014                            | (uint8_t) TIM1_EncoderMode);
3548  001d c65252        	ld	a,21074
3549  0020 a4f0          	and	a,#240
3550  0022 1a01          	or	a,(OFST+1,sp)
3551  0024 c75252        	ld	21074,a
3552                     ; 1017     TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_CCxS)) 
3552                     ; 1018                             | (uint8_t) CCMR_TIxDirect_Set);
3554  0027 c65258        	ld	a,21080
3555  002a a4fc          	and	a,#252
3556  002c aa01          	or	a,#1
3557  002e c75258        	ld	21080,a
3558                     ; 1019     TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_CCxS))
3558                     ; 1020                             | (uint8_t) CCMR_TIxDirect_Set);
3560  0031 c65259        	ld	a,21081
3561  0034 a4fc          	and	a,#252
3562  0036 aa01          	or	a,#1
3563  0038 c75259        	ld	21081,a
3564                     ; 1022 }
3567  003b 85            	popw	x
3568  003c 81            	ret
3635                     ; 1035 void TIM1_PrescalerConfig(uint16_t Prescaler,
3635                     ; 1036                           TIM1_PSCReloadMode_TypeDef TIM1_PSCReloadMode)
3635                     ; 1037 {
3636                     .text:	section	.text,new
3637  0000               _TIM1_PrescalerConfig:
3639  0000 89            	pushw	x
3640       00000000      OFST:	set	0
3643                     ; 1039     assert_param(IS_TIM1_PRESCALER_RELOAD_OK(TIM1_PSCReloadMode));
3645                     ; 1042     TIM1->PSCRH = (uint8_t)(Prescaler >> 8);
3647  0001 9e            	ld	a,xh
3648  0002 c75260        	ld	21088,a
3649                     ; 1043     TIM1->PSCRL = (uint8_t)(Prescaler);
3651  0005 9f            	ld	a,xl
3652  0006 c75261        	ld	21089,a
3653                     ; 1046     TIM1->EGR = (uint8_t)TIM1_PSCReloadMode;
3655  0009 7b05          	ld	a,(OFST+5,sp)
3656  000b c75257        	ld	21079,a
3657                     ; 1048 }
3660  000e 85            	popw	x
3661  000f 81            	ret
3697                     ; 1061 void TIM1_CounterModeConfig(TIM1_CounterMode_TypeDef TIM1_CounterMode)
3697                     ; 1062 {
3698                     .text:	section	.text,new
3699  0000               _TIM1_CounterModeConfig:
3701  0000 88            	push	a
3702       00000000      OFST:	set	0
3705                     ; 1064     assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));
3707                     ; 1068     TIM1->CR1 = (uint8_t)((uint8_t)(TIM1->CR1 & (uint8_t)((uint8_t)(~TIM1_CR1_CMS) & (uint8_t)(~TIM1_CR1_DIR)))
3707                     ; 1069                           | (uint8_t)TIM1_CounterMode);
3709  0001 c65250        	ld	a,21072
3710  0004 a48f          	and	a,#143
3711  0006 1a01          	or	a,(OFST+1,sp)
3712  0008 c75250        	ld	21072,a
3713                     ; 1070 }
3716  000b 84            	pop	a
3717  000c 81            	ret
3775                     ; 1081 void TIM1_ForcedOC1Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3775                     ; 1082 {
3776                     .text:	section	.text,new
3777  0000               _TIM1_ForcedOC1Config:
3779  0000 88            	push	a
3780       00000000      OFST:	set	0
3783                     ; 1084     assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3785                     ; 1087     TIM1->CCMR1 =  (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_OCM))|
3785                     ; 1088                              (uint8_t)TIM1_ForcedAction);
3787  0001 c65258        	ld	a,21080
3788  0004 a48f          	and	a,#143
3789  0006 1a01          	or	a,(OFST+1,sp)
3790  0008 c75258        	ld	21080,a
3791                     ; 1089 }
3794  000b 84            	pop	a
3795  000c 81            	ret
3831                     ; 1100 void TIM1_ForcedOC2Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3831                     ; 1101 {
3832                     .text:	section	.text,new
3833  0000               _TIM1_ForcedOC2Config:
3835  0000 88            	push	a
3836       00000000      OFST:	set	0
3839                     ; 1103     assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3841                     ; 1106     TIM1->CCMR2  =  (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_OCM))
3841                     ; 1107                               | (uint8_t)TIM1_ForcedAction);
3843  0001 c65259        	ld	a,21081
3844  0004 a48f          	and	a,#143
3845  0006 1a01          	or	a,(OFST+1,sp)
3846  0008 c75259        	ld	21081,a
3847                     ; 1108 }
3850  000b 84            	pop	a
3851  000c 81            	ret
3887                     ; 1120 void TIM1_ForcedOC3Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3887                     ; 1121 {
3888                     .text:	section	.text,new
3889  0000               _TIM1_ForcedOC3Config:
3891  0000 88            	push	a
3892       00000000      OFST:	set	0
3895                     ; 1123     assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3897                     ; 1126     TIM1->CCMR3  =  (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM))  
3897                     ; 1127                               | (uint8_t)TIM1_ForcedAction);
3899  0001 c6525a        	ld	a,21082
3900  0004 a48f          	and	a,#143
3901  0006 1a01          	or	a,(OFST+1,sp)
3902  0008 c7525a        	ld	21082,a
3903                     ; 1128 }
3906  000b 84            	pop	a
3907  000c 81            	ret
3943                     ; 1140 void TIM1_ForcedOC4Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3943                     ; 1141 {
3944                     .text:	section	.text,new
3945  0000               _TIM1_ForcedOC4Config:
3947  0000 88            	push	a
3948       00000000      OFST:	set	0
3951                     ; 1143     assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3953                     ; 1146     TIM1->CCMR4  =  (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_OCM)) 
3953                     ; 1147                               | (uint8_t)TIM1_ForcedAction);
3955  0001 c6525b        	ld	a,21083
3956  0004 a48f          	and	a,#143
3957  0006 1a01          	or	a,(OFST+1,sp)
3958  0008 c7525b        	ld	21083,a
3959                     ; 1148 }
3962  000b 84            	pop	a
3963  000c 81            	ret
3999                     ; 1157 void TIM1_ARRPreloadConfig(FunctionalState NewState)
3999                     ; 1158 {
4000                     .text:	section	.text,new
4001  0000               _TIM1_ARRPreloadConfig:
4005                     ; 1160     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4007                     ; 1163     if (NewState != DISABLE)
4009  0000 4d            	tnz	a
4010  0001 2706          	jreq	L5502
4011                     ; 1165         TIM1->CR1 |= TIM1_CR1_ARPE;
4013  0003 721e5250      	bset	21072,#7
4015  0007 2004          	jra	L7502
4016  0009               L5502:
4017                     ; 1169         TIM1->CR1 &= (uint8_t)(~TIM1_CR1_ARPE);
4019  0009 721f5250      	bres	21072,#7
4020  000d               L7502:
4021                     ; 1171 }
4024  000d 81            	ret
4059                     ; 1180 void TIM1_SelectCOM(FunctionalState NewState)
4059                     ; 1181 {
4060                     .text:	section	.text,new
4061  0000               _TIM1_SelectCOM:
4065                     ; 1183     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4067                     ; 1186     if (NewState != DISABLE)
4069  0000 4d            	tnz	a
4070  0001 2706          	jreq	L7702
4071                     ; 1188         TIM1->CR2 |= TIM1_CR2_COMS;
4073  0003 72145251      	bset	21073,#2
4075  0007 2004          	jra	L1012
4076  0009               L7702:
4077                     ; 1192         TIM1->CR2 &= (uint8_t)(~TIM1_CR2_COMS);
4079  0009 72155251      	bres	21073,#2
4080  000d               L1012:
4081                     ; 1194 }
4084  000d 81            	ret
4120                     ; 1202 void TIM1_CCPreloadControl(FunctionalState NewState)
4120                     ; 1203 {
4121                     .text:	section	.text,new
4122  0000               _TIM1_CCPreloadControl:
4126                     ; 1205     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4128                     ; 1208     if (NewState != DISABLE)
4130  0000 4d            	tnz	a
4131  0001 2706          	jreq	L1212
4132                     ; 1210         TIM1->CR2 |= TIM1_CR2_CCPC;
4134  0003 72105251      	bset	21073,#0
4136  0007 2004          	jra	L3212
4137  0009               L1212:
4138                     ; 1214         TIM1->CR2 &= (uint8_t)(~TIM1_CR2_CCPC);
4140  0009 72115251      	bres	21073,#0
4141  000d               L3212:
4142                     ; 1216 }
4145  000d 81            	ret
4181                     ; 1225 void TIM1_OC1PreloadConfig(FunctionalState NewState)
4181                     ; 1226 {
4182                     .text:	section	.text,new
4183  0000               _TIM1_OC1PreloadConfig:
4187                     ; 1228     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4189                     ; 1231     if (NewState != DISABLE)
4191  0000 4d            	tnz	a
4192  0001 2706          	jreq	L3412
4193                     ; 1233         TIM1->CCMR1 |= TIM1_CCMR_OCxPE;
4195  0003 72165258      	bset	21080,#3
4197  0007 2004          	jra	L5412
4198  0009               L3412:
4199                     ; 1237         TIM1->CCMR1 &= (uint8_t)(~TIM1_CCMR_OCxPE);
4201  0009 72175258      	bres	21080,#3
4202  000d               L5412:
4203                     ; 1239 }
4206  000d 81            	ret
4242                     ; 1248 void TIM1_OC2PreloadConfig(FunctionalState NewState)
4242                     ; 1249 {
4243                     .text:	section	.text,new
4244  0000               _TIM1_OC2PreloadConfig:
4248                     ; 1251     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4250                     ; 1254     if (NewState != DISABLE)
4252  0000 4d            	tnz	a
4253  0001 2706          	jreq	L5612
4254                     ; 1256         TIM1->CCMR2 |= TIM1_CCMR_OCxPE;
4256  0003 72165259      	bset	21081,#3
4258  0007 2004          	jra	L7612
4259  0009               L5612:
4260                     ; 1260         TIM1->CCMR2 &= (uint8_t)(~TIM1_CCMR_OCxPE);
4262  0009 72175259      	bres	21081,#3
4263  000d               L7612:
4264                     ; 1262 }
4267  000d 81            	ret
4303                     ; 1271 void TIM1_OC3PreloadConfig(FunctionalState NewState)
4303                     ; 1272 {
4304                     .text:	section	.text,new
4305  0000               _TIM1_OC3PreloadConfig:
4309                     ; 1274     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4311                     ; 1277     if (NewState != DISABLE)
4313  0000 4d            	tnz	a
4314  0001 2706          	jreq	L7022
4315                     ; 1279         TIM1->CCMR3 |= TIM1_CCMR_OCxPE;
4317  0003 7216525a      	bset	21082,#3
4319  0007 2004          	jra	L1122
4320  0009               L7022:
4321                     ; 1283         TIM1->CCMR3 &= (uint8_t)(~TIM1_CCMR_OCxPE);
4323  0009 7217525a      	bres	21082,#3
4324  000d               L1122:
4325                     ; 1285 }
4328  000d 81            	ret
4364                     ; 1295 void TIM1_OC4PreloadConfig(FunctionalState NewState)
4364                     ; 1296 {
4365                     .text:	section	.text,new
4366  0000               _TIM1_OC4PreloadConfig:
4370                     ; 1298     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4372                     ; 1301     if (NewState != DISABLE)
4374  0000 4d            	tnz	a
4375  0001 2706          	jreq	L1322
4376                     ; 1303         TIM1->CCMR4 |= TIM1_CCMR_OCxPE;
4378  0003 7216525b      	bset	21083,#3
4380  0007 2004          	jra	L3322
4381  0009               L1322:
4382                     ; 1307         TIM1->CCMR4 &= (uint8_t)(~TIM1_CCMR_OCxPE);
4384  0009 7217525b      	bres	21083,#3
4385  000d               L3322:
4386                     ; 1309 }
4389  000d 81            	ret
4424                     ; 1317 void TIM1_OC1FastConfig(FunctionalState NewState)
4424                     ; 1318 {
4425                     .text:	section	.text,new
4426  0000               _TIM1_OC1FastConfig:
4430                     ; 1320     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4432                     ; 1323     if (NewState != DISABLE)
4434  0000 4d            	tnz	a
4435  0001 2706          	jreq	L3522
4436                     ; 1325         TIM1->CCMR1 |= TIM1_CCMR_OCxFE;
4438  0003 72145258      	bset	21080,#2
4440  0007 2004          	jra	L5522
4441  0009               L3522:
4442                     ; 1329         TIM1->CCMR1 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4444  0009 72155258      	bres	21080,#2
4445  000d               L5522:
4446                     ; 1331 }
4449  000d 81            	ret
4484                     ; 1341 void TIM1_OC2FastConfig(FunctionalState NewState)
4484                     ; 1342 {
4485                     .text:	section	.text,new
4486  0000               _TIM1_OC2FastConfig:
4490                     ; 1344     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4492                     ; 1347     if (NewState != DISABLE)
4494  0000 4d            	tnz	a
4495  0001 2706          	jreq	L5722
4496                     ; 1349         TIM1->CCMR2 |= TIM1_CCMR_OCxFE;
4498  0003 72145259      	bset	21081,#2
4500  0007 2004          	jra	L7722
4501  0009               L5722:
4502                     ; 1353         TIM1->CCMR2 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4504  0009 72155259      	bres	21081,#2
4505  000d               L7722:
4506                     ; 1355 }
4509  000d 81            	ret
4544                     ; 1364 void TIM1_OC3FastConfig(FunctionalState NewState)
4544                     ; 1365 {
4545                     .text:	section	.text,new
4546  0000               _TIM1_OC3FastConfig:
4550                     ; 1367     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4552                     ; 1370     if (NewState != DISABLE)
4554  0000 4d            	tnz	a
4555  0001 2706          	jreq	L7132
4556                     ; 1372         TIM1->CCMR3 |= TIM1_CCMR_OCxFE;
4558  0003 7214525a      	bset	21082,#2
4560  0007 2004          	jra	L1232
4561  0009               L7132:
4562                     ; 1376         TIM1->CCMR3 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4564  0009 7215525a      	bres	21082,#2
4565  000d               L1232:
4566                     ; 1378 }
4569  000d 81            	ret
4604                     ; 1387 void TIM1_OC4FastConfig(FunctionalState NewState)
4604                     ; 1388 {
4605                     .text:	section	.text,new
4606  0000               _TIM1_OC4FastConfig:
4610                     ; 1390     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4612                     ; 1393     if (NewState != DISABLE)
4614  0000 4d            	tnz	a
4615  0001 2706          	jreq	L1432
4616                     ; 1395         TIM1->CCMR4 |= TIM1_CCMR_OCxFE;
4618  0003 7214525b      	bset	21083,#2
4620  0007 2004          	jra	L3432
4621  0009               L1432:
4622                     ; 1399         TIM1->CCMR4 &= (uint8_t)(~TIM1_CCMR_OCxFE);
4624  0009 7215525b      	bres	21083,#2
4625  000d               L3432:
4626                     ; 1401 }
4629  000d 81            	ret
4734                     ; 1418 void TIM1_GenerateEvent(TIM1_EventSource_TypeDef TIM1_EventSource)
4734                     ; 1419 {
4735                     .text:	section	.text,new
4736  0000               _TIM1_GenerateEvent:
4740                     ; 1421     assert_param(IS_TIM1_EVENT_SOURCE_OK(TIM1_EventSource));
4742                     ; 1424     TIM1->EGR = (uint8_t)TIM1_EventSource;
4744  0000 c75257        	ld	21079,a
4745                     ; 1425 }
4748  0003 81            	ret
4784                     ; 1436 void TIM1_OC1PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
4784                     ; 1437 {
4785                     .text:	section	.text,new
4786  0000               _TIM1_OC1PolarityConfig:
4790                     ; 1439     assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
4792                     ; 1442     if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
4794  0000 4d            	tnz	a
4795  0001 2706          	jreq	L5242
4796                     ; 1444         TIM1->CCER1 |= TIM1_CCER1_CC1P;
4798  0003 7212525c      	bset	21084,#1
4800  0007 2004          	jra	L7242
4801  0009               L5242:
4802                     ; 1448         TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
4804  0009 7213525c      	bres	21084,#1
4805  000d               L7242:
4806                     ; 1450 }
4809  000d 81            	ret
4845                     ; 1461 void TIM1_OC1NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
4845                     ; 1462 {
4846                     .text:	section	.text,new
4847  0000               _TIM1_OC1NPolarityConfig:
4851                     ; 1464     assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
4853                     ; 1467     if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
4855  0000 4d            	tnz	a
4856  0001 2706          	jreq	L7442
4857                     ; 1469         TIM1->CCER1 |= TIM1_CCER1_CC1NP;
4859  0003 7216525c      	bset	21084,#3
4861  0007 2004          	jra	L1542
4862  0009               L7442:
4863                     ; 1473         TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1NP);
4865  0009 7217525c      	bres	21084,#3
4866  000d               L1542:
4867                     ; 1475 }
4870  000d 81            	ret
4906                     ; 1486 void TIM1_OC2PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
4906                     ; 1487 {
4907                     .text:	section	.text,new
4908  0000               _TIM1_OC2PolarityConfig:
4912                     ; 1489     assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
4914                     ; 1492     if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
4916  0000 4d            	tnz	a
4917  0001 2706          	jreq	L1742
4918                     ; 1494         TIM1->CCER1 |= TIM1_CCER1_CC2P;
4920  0003 721a525c      	bset	21084,#5
4922  0007 2004          	jra	L3742
4923  0009               L1742:
4924                     ; 1498         TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2P);
4926  0009 721b525c      	bres	21084,#5
4927  000d               L3742:
4928                     ; 1500 }
4931  000d 81            	ret
4967                     ; 1510 void TIM1_OC2NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
4967                     ; 1511 {
4968                     .text:	section	.text,new
4969  0000               _TIM1_OC2NPolarityConfig:
4973                     ; 1513     assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
4975                     ; 1516     if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
4977  0000 4d            	tnz	a
4978  0001 2706          	jreq	L3152
4979                     ; 1518         TIM1->CCER1 |= TIM1_CCER1_CC2NP;
4981  0003 721e525c      	bset	21084,#7
4983  0007 2004          	jra	L5152
4984  0009               L3152:
4985                     ; 1522         TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2NP);
4987  0009 721f525c      	bres	21084,#7
4988  000d               L5152:
4989                     ; 1524 }
4992  000d 81            	ret
5028                     ; 1535 void TIM1_OC3PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
5028                     ; 1536 {
5029                     .text:	section	.text,new
5030  0000               _TIM1_OC3PolarityConfig:
5034                     ; 1538     assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
5036                     ; 1541     if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
5038  0000 4d            	tnz	a
5039  0001 2706          	jreq	L5352
5040                     ; 1543         TIM1->CCER2 |= TIM1_CCER2_CC3P;
5042  0003 7212525d      	bset	21085,#1
5044  0007 2004          	jra	L7352
5045  0009               L5352:
5046                     ; 1547         TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3P);
5048  0009 7213525d      	bres	21085,#1
5049  000d               L7352:
5050                     ; 1549 }
5053  000d 81            	ret
5089                     ; 1560 void TIM1_OC3NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
5089                     ; 1561 {
5090                     .text:	section	.text,new
5091  0000               _TIM1_OC3NPolarityConfig:
5095                     ; 1563     assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
5097                     ; 1566     if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
5099  0000 4d            	tnz	a
5100  0001 2706          	jreq	L7552
5101                     ; 1568         TIM1->CCER2 |= TIM1_CCER2_CC3NP;
5103  0003 7216525d      	bset	21085,#3
5105  0007 2004          	jra	L1652
5106  0009               L7552:
5107                     ; 1572         TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3NP);
5109  0009 7217525d      	bres	21085,#3
5110  000d               L1652:
5111                     ; 1574 }
5114  000d 81            	ret
5150                     ; 1584 void TIM1_OC4PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
5150                     ; 1585 {
5151                     .text:	section	.text,new
5152  0000               _TIM1_OC4PolarityConfig:
5156                     ; 1587     assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
5158                     ; 1590     if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
5160  0000 4d            	tnz	a
5161  0001 2706          	jreq	L1062
5162                     ; 1592         TIM1->CCER2 |= TIM1_CCER2_CC4P;
5164  0003 721a525d      	bset	21085,#5
5166  0007 2004          	jra	L3062
5167  0009               L1062:
5168                     ; 1596         TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4P);
5170  0009 721b525d      	bres	21085,#5
5171  000d               L3062:
5172                     ; 1598 }
5175  000d 81            	ret
5220                     ; 1613 void TIM1_CCxCmd(TIM1_Channel_TypeDef TIM1_Channel, FunctionalState NewState)
5220                     ; 1614 {
5221                     .text:	section	.text,new
5222  0000               _TIM1_CCxCmd:
5224  0000 89            	pushw	x
5225       00000000      OFST:	set	0
5228                     ; 1616     assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
5230                     ; 1617     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
5232                     ; 1619     if (TIM1_Channel == TIM1_CHANNEL_1)
5234  0001 9e            	ld	a,xh
5235  0002 4d            	tnz	a
5236  0003 2610          	jrne	L7262
5237                     ; 1622         if (NewState != DISABLE)
5239  0005 9f            	ld	a,xl
5240  0006 4d            	tnz	a
5241  0007 2706          	jreq	L1362
5242                     ; 1624             TIM1->CCER1 |= TIM1_CCER1_CC1E;
5244  0009 7210525c      	bset	21084,#0
5246  000d 2040          	jra	L5362
5247  000f               L1362:
5248                     ; 1628             TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
5250  000f 7211525c      	bres	21084,#0
5251  0013 203a          	jra	L5362
5252  0015               L7262:
5253                     ; 1632     else if (TIM1_Channel == TIM1_CHANNEL_2)
5255  0015 7b01          	ld	a,(OFST+1,sp)
5256  0017 a101          	cp	a,#1
5257  0019 2610          	jrne	L7362
5258                     ; 1635         if (NewState != DISABLE)
5260  001b 0d02          	tnz	(OFST+2,sp)
5261  001d 2706          	jreq	L1462
5262                     ; 1637             TIM1->CCER1 |= TIM1_CCER1_CC2E;
5264  001f 7218525c      	bset	21084,#4
5266  0023 202a          	jra	L5362
5267  0025               L1462:
5268                     ; 1641             TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2E);
5270  0025 7219525c      	bres	21084,#4
5271  0029 2024          	jra	L5362
5272  002b               L7362:
5273                     ; 1644     else if (TIM1_Channel == TIM1_CHANNEL_3)
5275  002b 7b01          	ld	a,(OFST+1,sp)
5276  002d a102          	cp	a,#2
5277  002f 2610          	jrne	L7462
5278                     ; 1647         if (NewState != DISABLE)
5280  0031 0d02          	tnz	(OFST+2,sp)
5281  0033 2706          	jreq	L1562
5282                     ; 1649             TIM1->CCER2 |= TIM1_CCER2_CC3E;
5284  0035 7210525d      	bset	21085,#0
5286  0039 2014          	jra	L5362
5287  003b               L1562:
5288                     ; 1653             TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3E);
5290  003b 7211525d      	bres	21085,#0
5291  003f 200e          	jra	L5362
5292  0041               L7462:
5293                     ; 1659         if (NewState != DISABLE)
5295  0041 0d02          	tnz	(OFST+2,sp)
5296  0043 2706          	jreq	L7562
5297                     ; 1661             TIM1->CCER2 |= TIM1_CCER2_CC4E;
5299  0045 7218525d      	bset	21085,#4
5301  0049 2004          	jra	L5362
5302  004b               L7562:
5303                     ; 1665             TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4E);
5305  004b 7219525d      	bres	21085,#4
5306  004f               L5362:
5307                     ; 1668 }
5310  004f 85            	popw	x
5311  0050 81            	ret
5356                     ; 1681 void TIM1_CCxNCmd(TIM1_Channel_TypeDef TIM1_Channel, FunctionalState NewState)
5356                     ; 1682 {
5357                     .text:	section	.text,new
5358  0000               _TIM1_CCxNCmd:
5360  0000 89            	pushw	x
5361       00000000      OFST:	set	0
5364                     ; 1684     assert_param(IS_TIM1_COMPLEMENTARY_CHANNEL_OK(TIM1_Channel));
5366                     ; 1685     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
5368                     ; 1687     if (TIM1_Channel == TIM1_CHANNEL_1)
5370  0001 9e            	ld	a,xh
5371  0002 4d            	tnz	a
5372  0003 2610          	jrne	L5072
5373                     ; 1690         if (NewState != DISABLE)
5375  0005 9f            	ld	a,xl
5376  0006 4d            	tnz	a
5377  0007 2706          	jreq	L7072
5378                     ; 1692             TIM1->CCER1 |= TIM1_CCER1_CC1NE;
5380  0009 7214525c      	bset	21084,#2
5382  000d 202a          	jra	L3172
5383  000f               L7072:
5384                     ; 1696             TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1NE);
5386  000f 7215525c      	bres	21084,#2
5387  0013 2024          	jra	L3172
5388  0015               L5072:
5389                     ; 1699     else if (TIM1_Channel == TIM1_CHANNEL_2)
5391  0015 7b01          	ld	a,(OFST+1,sp)
5392  0017 a101          	cp	a,#1
5393  0019 2610          	jrne	L5172
5394                     ; 1702         if (NewState != DISABLE)
5396  001b 0d02          	tnz	(OFST+2,sp)
5397  001d 2706          	jreq	L7172
5398                     ; 1704             TIM1->CCER1 |= TIM1_CCER1_CC2NE;
5400  001f 721c525c      	bset	21084,#6
5402  0023 2014          	jra	L3172
5403  0025               L7172:
5404                     ; 1708             TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2NE);
5406  0025 721d525c      	bres	21084,#6
5407  0029 200e          	jra	L3172
5408  002b               L5172:
5409                     ; 1714         if (NewState != DISABLE)
5411  002b 0d02          	tnz	(OFST+2,sp)
5412  002d 2706          	jreq	L5272
5413                     ; 1716             TIM1->CCER2 |= TIM1_CCER2_CC3NE;
5415  002f 7214525d      	bset	21085,#2
5417  0033 2004          	jra	L3172
5418  0035               L5272:
5419                     ; 1720             TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3NE);
5421  0035 7215525d      	bres	21085,#2
5422  0039               L3172:
5423                     ; 1723 }
5426  0039 85            	popw	x
5427  003a 81            	ret
5472                     ; 1747 void TIM1_SelectOCxM(TIM1_Channel_TypeDef TIM1_Channel, TIM1_OCMode_TypeDef TIM1_OCMode)
5472                     ; 1748 {
5473                     .text:	section	.text,new
5474  0000               _TIM1_SelectOCxM:
5476  0000 89            	pushw	x
5477       00000000      OFST:	set	0
5480                     ; 1750     assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
5482                     ; 1751     assert_param(IS_TIM1_OCM_OK(TIM1_OCMode));
5484                     ; 1753     if (TIM1_Channel == TIM1_CHANNEL_1)
5486  0001 9e            	ld	a,xh
5487  0002 4d            	tnz	a
5488  0003 2610          	jrne	L3572
5489                     ; 1756         TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
5491  0005 7211525c      	bres	21084,#0
5492                     ; 1759         TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_OCM)) 
5492                     ; 1760                                 | (uint8_t)TIM1_OCMode);
5494  0009 c65258        	ld	a,21080
5495  000c a48f          	and	a,#143
5496  000e 1a02          	or	a,(OFST+2,sp)
5497  0010 c75258        	ld	21080,a
5499  0013 203a          	jra	L5572
5500  0015               L3572:
5501                     ; 1762     else if (TIM1_Channel == TIM1_CHANNEL_2)
5503  0015 7b01          	ld	a,(OFST+1,sp)
5504  0017 a101          	cp	a,#1
5505  0019 2610          	jrne	L7572
5506                     ; 1765         TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2E);
5508  001b 7219525c      	bres	21084,#4
5509                     ; 1768         TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_OCM))
5509                     ; 1769                                 | (uint8_t)TIM1_OCMode);
5511  001f c65259        	ld	a,21081
5512  0022 a48f          	and	a,#143
5513  0024 1a02          	or	a,(OFST+2,sp)
5514  0026 c75259        	ld	21081,a
5516  0029 2024          	jra	L5572
5517  002b               L7572:
5518                     ; 1771     else if (TIM1_Channel == TIM1_CHANNEL_3)
5520  002b 7b01          	ld	a,(OFST+1,sp)
5521  002d a102          	cp	a,#2
5522  002f 2610          	jrne	L3672
5523                     ; 1774         TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3E);
5525  0031 7211525d      	bres	21085,#0
5526                     ; 1777         TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_OCM)) 
5526                     ; 1778                                 | (uint8_t)TIM1_OCMode);
5528  0035 c6525a        	ld	a,21082
5529  0038 a48f          	and	a,#143
5530  003a 1a02          	or	a,(OFST+2,sp)
5531  003c c7525a        	ld	21082,a
5533  003f 200e          	jra	L5572
5534  0041               L3672:
5535                     ; 1783         TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4E);
5537  0041 7219525d      	bres	21085,#4
5538                     ; 1786         TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_OCM)) 
5538                     ; 1787                                 | (uint8_t)TIM1_OCMode);
5540  0045 c6525b        	ld	a,21083
5541  0048 a48f          	and	a,#143
5542  004a 1a02          	or	a,(OFST+2,sp)
5543  004c c7525b        	ld	21083,a
5544  004f               L5572:
5545                     ; 1789 }
5548  004f 85            	popw	x
5549  0050 81            	ret
5583                     ; 1798 void TIM1_SetCounter(uint16_t Counter)
5583                     ; 1799 {
5584                     .text:	section	.text,new
5585  0000               _TIM1_SetCounter:
5589                     ; 1801     TIM1->CNTRH = (uint8_t)(Counter >> 8);
5591  0000 9e            	ld	a,xh
5592  0001 c7525e        	ld	21086,a
5593                     ; 1802     TIM1->CNTRL = (uint8_t)(Counter);
5595  0004 9f            	ld	a,xl
5596  0005 c7525f        	ld	21087,a
5597                     ; 1804 }
5600  0008 81            	ret
5634                     ; 1813 void TIM1_SetAutoreload(uint16_t Autoreload)
5634                     ; 1814 {
5635                     .text:	section	.text,new
5636  0000               _TIM1_SetAutoreload:
5640                     ; 1817     TIM1->ARRH = (uint8_t)(Autoreload >> 8);
5642  0000 9e            	ld	a,xh
5643  0001 c75262        	ld	21090,a
5644                     ; 1818     TIM1->ARRL = (uint8_t)(Autoreload);
5646  0004 9f            	ld	a,xl
5647  0005 c75263        	ld	21091,a
5648                     ; 1820 }
5651  0008 81            	ret
5685                     ; 1829 void TIM1_SetCompare1(uint16_t Compare1)
5685                     ; 1830 {
5686                     .text:	section	.text,new
5687  0000               _TIM1_SetCompare1:
5691                     ; 1832     TIM1->CCR1H = (uint8_t)(Compare1 >> 8);
5693  0000 9e            	ld	a,xh
5694  0001 c75265        	ld	21093,a
5695                     ; 1833     TIM1->CCR1L = (uint8_t)(Compare1);
5697  0004 9f            	ld	a,xl
5698  0005 c75266        	ld	21094,a
5699                     ; 1835 }
5702  0008 81            	ret
5736                     ; 1844 void TIM1_SetCompare2(uint16_t Compare2)
5736                     ; 1845 {
5737                     .text:	section	.text,new
5738  0000               _TIM1_SetCompare2:
5742                     ; 1847     TIM1->CCR2H = (uint8_t)(Compare2 >> 8);
5744  0000 9e            	ld	a,xh
5745  0001 c75267        	ld	21095,a
5746                     ; 1848     TIM1->CCR2L = (uint8_t)(Compare2);
5748  0004 9f            	ld	a,xl
5749  0005 c75268        	ld	21096,a
5750                     ; 1850 }
5753  0008 81            	ret
5787                     ; 1859 void TIM1_SetCompare3(uint16_t Compare3)
5787                     ; 1860 {
5788                     .text:	section	.text,new
5789  0000               _TIM1_SetCompare3:
5793                     ; 1862     TIM1->CCR3H = (uint8_t)(Compare3 >> 8);
5795  0000 9e            	ld	a,xh
5796  0001 c75269        	ld	21097,a
5797                     ; 1863     TIM1->CCR3L = (uint8_t)(Compare3);
5799  0004 9f            	ld	a,xl
5800  0005 c7526a        	ld	21098,a
5801                     ; 1865 }
5804  0008 81            	ret
5838                     ; 1874 void TIM1_SetCompare4(uint16_t Compare4)
5838                     ; 1875 {
5839                     .text:	section	.text,new
5840  0000               _TIM1_SetCompare4:
5844                     ; 1877     TIM1->CCR4H = (uint8_t)(Compare4 >> 8);
5846  0000 9e            	ld	a,xh
5847  0001 c7526b        	ld	21099,a
5848                     ; 1878     TIM1->CCR4L = (uint8_t)(Compare4);
5850  0004 9f            	ld	a,xl
5851  0005 c7526c        	ld	21100,a
5852                     ; 1879 }
5855  0008 81            	ret
5891                     ; 1892 void TIM1_SetIC1Prescaler(TIM1_ICPSC_TypeDef TIM1_IC1Prescaler)
5891                     ; 1893 {
5892                     .text:	section	.text,new
5893  0000               _TIM1_SetIC1Prescaler:
5895  0000 88            	push	a
5896       00000000      OFST:	set	0
5899                     ; 1895     assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC1Prescaler));
5901                     ; 1898     TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_ICxPSC)) 
5901                     ; 1899                             | (uint8_t)TIM1_IC1Prescaler);
5903  0001 c65258        	ld	a,21080
5904  0004 a4f3          	and	a,#243
5905  0006 1a01          	or	a,(OFST+1,sp)
5906  0008 c75258        	ld	21080,a
5907                     ; 1901 }
5910  000b 84            	pop	a
5911  000c 81            	ret
5947                     ; 1913 void TIM1_SetIC2Prescaler(TIM1_ICPSC_TypeDef TIM1_IC2Prescaler)
5947                     ; 1914 {
5948                     .text:	section	.text,new
5949  0000               _TIM1_SetIC2Prescaler:
5951  0000 88            	push	a
5952       00000000      OFST:	set	0
5955                     ; 1917     assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC2Prescaler));
5957                     ; 1920     TIM1->CCMR2 = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~TIM1_CCMR_ICxPSC))
5957                     ; 1921                             | (uint8_t)TIM1_IC2Prescaler);
5959  0001 c65259        	ld	a,21081
5960  0004 a4f3          	and	a,#243
5961  0006 1a01          	or	a,(OFST+1,sp)
5962  0008 c75259        	ld	21081,a
5963                     ; 1922 }
5966  000b 84            	pop	a
5967  000c 81            	ret
6003                     ; 1935 void TIM1_SetIC3Prescaler(TIM1_ICPSC_TypeDef TIM1_IC3Prescaler)
6003                     ; 1936 {
6004                     .text:	section	.text,new
6005  0000               _TIM1_SetIC3Prescaler:
6007  0000 88            	push	a
6008       00000000      OFST:	set	0
6011                     ; 1939     assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC3Prescaler));
6013                     ; 1942     TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~TIM1_CCMR_ICxPSC)) | 
6013                     ; 1943                             (uint8_t)TIM1_IC3Prescaler);
6015  0001 c6525a        	ld	a,21082
6016  0004 a4f3          	and	a,#243
6017  0006 1a01          	or	a,(OFST+1,sp)
6018  0008 c7525a        	ld	21082,a
6019                     ; 1944 }
6022  000b 84            	pop	a
6023  000c 81            	ret
6059                     ; 1956 void TIM1_SetIC4Prescaler(TIM1_ICPSC_TypeDef TIM1_IC4Prescaler)
6059                     ; 1957 {
6060                     .text:	section	.text,new
6061  0000               _TIM1_SetIC4Prescaler:
6063  0000 88            	push	a
6064       00000000      OFST:	set	0
6067                     ; 1960     assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC4Prescaler));
6069                     ; 1963     TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~TIM1_CCMR_ICxPSC)) |
6069                     ; 1964                             (uint8_t)TIM1_IC4Prescaler);
6071  0001 c6525b        	ld	a,21083
6072  0004 a4f3          	and	a,#243
6073  0006 1a01          	or	a,(OFST+1,sp)
6074  0008 c7525b        	ld	21083,a
6075                     ; 1965 }
6078  000b 84            	pop	a
6079  000c 81            	ret
6131                     ; 1972 uint16_t TIM1_GetCapture1(void)
6131                     ; 1973 {
6132                     .text:	section	.text,new
6133  0000               _TIM1_GetCapture1:
6135  0000 5204          	subw	sp,#4
6136       00000004      OFST:	set	4
6139                     ; 1976     uint16_t tmpccr1 = 0;
6141                     ; 1977     uint8_t tmpccr1l=0, tmpccr1h=0;
6145                     ; 1979     tmpccr1h = TIM1->CCR1H;
6147  0002 c65265        	ld	a,21093
6148  0005 6b02          	ld	(OFST-2,sp),a
6149                     ; 1980     tmpccr1l = TIM1->CCR1L;
6151  0007 c65266        	ld	a,21094
6152  000a 6b01          	ld	(OFST-3,sp),a
6153                     ; 1982     tmpccr1 = (uint16_t)(tmpccr1l);
6155  000c 7b01          	ld	a,(OFST-3,sp)
6156  000e 5f            	clrw	x
6157  000f 97            	ld	xl,a
6158  0010 1f03          	ldw	(OFST-1,sp),x
6159                     ; 1983     tmpccr1 |= (uint16_t)((uint16_t)tmpccr1h << 8);
6161  0012 7b02          	ld	a,(OFST-2,sp)
6162  0014 5f            	clrw	x
6163  0015 97            	ld	xl,a
6164  0016 4f            	clr	a
6165  0017 02            	rlwa	x,a
6166  0018 01            	rrwa	x,a
6167  0019 1a04          	or	a,(OFST+0,sp)
6168  001b 01            	rrwa	x,a
6169  001c 1a03          	or	a,(OFST-1,sp)
6170  001e 01            	rrwa	x,a
6171  001f 1f03          	ldw	(OFST-1,sp),x
6172                     ; 1985     return (uint16_t)tmpccr1;
6174  0021 1e03          	ldw	x,(OFST-1,sp)
6177  0023 5b04          	addw	sp,#4
6178  0025 81            	ret
6230                     ; 1993 uint16_t TIM1_GetCapture2(void)
6230                     ; 1994 {
6231                     .text:	section	.text,new
6232  0000               _TIM1_GetCapture2:
6234  0000 5204          	subw	sp,#4
6235       00000004      OFST:	set	4
6238                     ; 1997     uint16_t tmpccr2 = 0;
6240                     ; 1998     uint8_t tmpccr2l=0, tmpccr2h=0;
6244                     ; 2000     tmpccr2h = TIM1->CCR2H;
6246  0002 c65267        	ld	a,21095
6247  0005 6b02          	ld	(OFST-2,sp),a
6248                     ; 2001     tmpccr2l = TIM1->CCR2L;
6250  0007 c65268        	ld	a,21096
6251  000a 6b01          	ld	(OFST-3,sp),a
6252                     ; 2003     tmpccr2 = (uint16_t)(tmpccr2l);
6254  000c 7b01          	ld	a,(OFST-3,sp)
6255  000e 5f            	clrw	x
6256  000f 97            	ld	xl,a
6257  0010 1f03          	ldw	(OFST-1,sp),x
6258                     ; 2004     tmpccr2 |= (uint16_t)((uint16_t)tmpccr2h << 8);
6260  0012 7b02          	ld	a,(OFST-2,sp)
6261  0014 5f            	clrw	x
6262  0015 97            	ld	xl,a
6263  0016 4f            	clr	a
6264  0017 02            	rlwa	x,a
6265  0018 01            	rrwa	x,a
6266  0019 1a04          	or	a,(OFST+0,sp)
6267  001b 01            	rrwa	x,a
6268  001c 1a03          	or	a,(OFST-1,sp)
6269  001e 01            	rrwa	x,a
6270  001f 1f03          	ldw	(OFST-1,sp),x
6271                     ; 2006     return (uint16_t)tmpccr2;
6273  0021 1e03          	ldw	x,(OFST-1,sp)
6276  0023 5b04          	addw	sp,#4
6277  0025 81            	ret
6329                     ; 2014 uint16_t TIM1_GetCapture3(void)
6329                     ; 2015 {
6330                     .text:	section	.text,new
6331  0000               _TIM1_GetCapture3:
6333  0000 5204          	subw	sp,#4
6334       00000004      OFST:	set	4
6337                     ; 2017     uint16_t tmpccr3 = 0;
6339                     ; 2018     uint8_t tmpccr3l=0, tmpccr3h=0;
6343                     ; 2020     tmpccr3h = TIM1->CCR3H;
6345  0002 c65269        	ld	a,21097
6346  0005 6b02          	ld	(OFST-2,sp),a
6347                     ; 2021     tmpccr3l = TIM1->CCR3L;
6349  0007 c6526a        	ld	a,21098
6350  000a 6b01          	ld	(OFST-3,sp),a
6351                     ; 2023     tmpccr3 = (uint16_t)(tmpccr3l);
6353  000c 7b01          	ld	a,(OFST-3,sp)
6354  000e 5f            	clrw	x
6355  000f 97            	ld	xl,a
6356  0010 1f03          	ldw	(OFST-1,sp),x
6357                     ; 2024     tmpccr3 |= (uint16_t)((uint16_t)tmpccr3h << 8);
6359  0012 7b02          	ld	a,(OFST-2,sp)
6360  0014 5f            	clrw	x
6361  0015 97            	ld	xl,a
6362  0016 4f            	clr	a
6363  0017 02            	rlwa	x,a
6364  0018 01            	rrwa	x,a
6365  0019 1a04          	or	a,(OFST+0,sp)
6366  001b 01            	rrwa	x,a
6367  001c 1a03          	or	a,(OFST-1,sp)
6368  001e 01            	rrwa	x,a
6369  001f 1f03          	ldw	(OFST-1,sp),x
6370                     ; 2026     return (uint16_t)tmpccr3;
6372  0021 1e03          	ldw	x,(OFST-1,sp)
6375  0023 5b04          	addw	sp,#4
6376  0025 81            	ret
6428                     ; 2034 uint16_t TIM1_GetCapture4(void)
6428                     ; 2035 {
6429                     .text:	section	.text,new
6430  0000               _TIM1_GetCapture4:
6432  0000 5204          	subw	sp,#4
6433       00000004      OFST:	set	4
6436                     ; 2037     uint16_t tmpccr4 = 0;
6438                     ; 2038     uint8_t tmpccr4l=0, tmpccr4h=0;
6442                     ; 2040     tmpccr4h = TIM1->CCR4H;
6444  0002 c6526b        	ld	a,21099
6445  0005 6b02          	ld	(OFST-2,sp),a
6446                     ; 2041     tmpccr4l = TIM1->CCR4L;
6448  0007 c6526c        	ld	a,21100
6449  000a 6b01          	ld	(OFST-3,sp),a
6450                     ; 2043     tmpccr4 = (uint16_t)(tmpccr4l);
6452  000c 7b01          	ld	a,(OFST-3,sp)
6453  000e 5f            	clrw	x
6454  000f 97            	ld	xl,a
6455  0010 1f03          	ldw	(OFST-1,sp),x
6456                     ; 2044     tmpccr4 |= (uint16_t)((uint16_t)tmpccr4h << 8);
6458  0012 7b02          	ld	a,(OFST-2,sp)
6459  0014 5f            	clrw	x
6460  0015 97            	ld	xl,a
6461  0016 4f            	clr	a
6462  0017 02            	rlwa	x,a
6463  0018 01            	rrwa	x,a
6464  0019 1a04          	or	a,(OFST+0,sp)
6465  001b 01            	rrwa	x,a
6466  001c 1a03          	or	a,(OFST-1,sp)
6467  001e 01            	rrwa	x,a
6468  001f 1f03          	ldw	(OFST-1,sp),x
6469                     ; 2046     return (uint16_t)tmpccr4;
6471  0021 1e03          	ldw	x,(OFST-1,sp)
6474  0023 5b04          	addw	sp,#4
6475  0025 81            	ret
6509                     ; 2054 uint16_t TIM1_GetCounter(void)
6509                     ; 2055 {
6510                     .text:	section	.text,new
6511  0000               _TIM1_GetCounter:
6513  0000 89            	pushw	x
6514       00000002      OFST:	set	2
6517                     ; 2056   uint16_t tmpcntr = 0;
6519                     ; 2058   tmpcntr = ((uint16_t)TIM1->CNTRH << 8);
6521  0001 c6525e        	ld	a,21086
6522  0004 5f            	clrw	x
6523  0005 97            	ld	xl,a
6524  0006 4f            	clr	a
6525  0007 02            	rlwa	x,a
6526  0008 1f01          	ldw	(OFST-1,sp),x
6527                     ; 2061     return (uint16_t)(tmpcntr | (uint16_t)(TIM1->CNTRL));
6529  000a c6525f        	ld	a,21087
6530  000d 5f            	clrw	x
6531  000e 97            	ld	xl,a
6532  000f 01            	rrwa	x,a
6533  0010 1a02          	or	a,(OFST+0,sp)
6534  0012 01            	rrwa	x,a
6535  0013 1a01          	or	a,(OFST-1,sp)
6536  0015 01            	rrwa	x,a
6539  0016 5b02          	addw	sp,#2
6540  0018 81            	ret
6574                     ; 2069 uint16_t TIM1_GetPrescaler(void)
6574                     ; 2070 {
6575                     .text:	section	.text,new
6576  0000               _TIM1_GetPrescaler:
6578  0000 89            	pushw	x
6579       00000002      OFST:	set	2
6582                     ; 2071    uint16_t temp = 0;
6584                     ; 2073    temp = ((uint16_t)TIM1->PSCRH << 8);
6586  0001 c65260        	ld	a,21088
6587  0004 5f            	clrw	x
6588  0005 97            	ld	xl,a
6589  0006 4f            	clr	a
6590  0007 02            	rlwa	x,a
6591  0008 1f01          	ldw	(OFST-1,sp),x
6592                     ; 2076     return (uint16_t)( temp | (uint16_t)(TIM1->PSCRL));
6594  000a c65261        	ld	a,21089
6595  000d 5f            	clrw	x
6596  000e 97            	ld	xl,a
6597  000f 01            	rrwa	x,a
6598  0010 1a02          	or	a,(OFST+0,sp)
6599  0012 01            	rrwa	x,a
6600  0013 1a01          	or	a,(OFST-1,sp)
6601  0015 01            	rrwa	x,a
6604  0016 5b02          	addw	sp,#2
6605  0018 81            	ret
6779                     ; 2097 FlagStatus TIM1_GetFlagStatus(TIM1_FLAG_TypeDef TIM1_FLAG)
6779                     ; 2098 {
6780                     .text:	section	.text,new
6781  0000               _TIM1_GetFlagStatus:
6783  0000 89            	pushw	x
6784  0001 89            	pushw	x
6785       00000002      OFST:	set	2
6788                     ; 2099     FlagStatus bitstatus = RESET;
6790                     ; 2100     uint8_t tim1_flag_l = 0, tim1_flag_h = 0;
6794                     ; 2103     assert_param(IS_TIM1_GET_FLAG_OK(TIM1_FLAG));
6796                     ; 2105     tim1_flag_l = (uint8_t)(TIM1->SR1 & (uint8_t)TIM1_FLAG);
6798  0002 9f            	ld	a,xl
6799  0003 c45255        	and	a,21077
6800  0006 6b01          	ld	(OFST-1,sp),a
6801                     ; 2106     tim1_flag_h = (uint8_t)((uint16_t)TIM1_FLAG >> 8);
6803  0008 7b03          	ld	a,(OFST+1,sp)
6804  000a 6b02          	ld	(OFST+0,sp),a
6805                     ; 2108     if ((tim1_flag_l | (uint8_t)(TIM1->SR2 & tim1_flag_h)) != 0)
6807  000c c65256        	ld	a,21078
6808  000f 1402          	and	a,(OFST+0,sp)
6809  0011 1a01          	or	a,(OFST-1,sp)
6810  0013 2706          	jreq	L5643
6811                     ; 2110         bitstatus = SET;
6813  0015 a601          	ld	a,#1
6814  0017 6b02          	ld	(OFST+0,sp),a
6816  0019 2002          	jra	L7643
6817  001b               L5643:
6818                     ; 2114         bitstatus = RESET;
6820  001b 0f02          	clr	(OFST+0,sp)
6821  001d               L7643:
6822                     ; 2116     return (FlagStatus)(bitstatus);
6824  001d 7b02          	ld	a,(OFST+0,sp)
6827  001f 5b04          	addw	sp,#4
6828  0021 81            	ret
6863                     ; 2137 void TIM1_ClearFlag(TIM1_FLAG_TypeDef TIM1_FLAG)
6863                     ; 2138 {
6864                     .text:	section	.text,new
6865  0000               _TIM1_ClearFlag:
6867  0000 89            	pushw	x
6868       00000000      OFST:	set	0
6871                     ; 2140     assert_param(IS_TIM1_CLEAR_FLAG_OK(TIM1_FLAG));
6873                     ; 2143     TIM1->SR1 = (uint8_t)(~(uint8_t)(TIM1_FLAG));
6875  0001 9f            	ld	a,xl
6876  0002 43            	cpl	a
6877  0003 c75255        	ld	21077,a
6878                     ; 2144     TIM1->SR2 = (uint8_t)((uint8_t)(~((uint8_t)((uint16_t)TIM1_FLAG >> 8))) & 
6878                     ; 2145                           (uint8_t)0x1E);
6880  0006 7b01          	ld	a,(OFST+1,sp)
6881  0008 43            	cpl	a
6882  0009 a41e          	and	a,#30
6883  000b c75256        	ld	21078,a
6884                     ; 2146 }
6887  000e 85            	popw	x
6888  000f 81            	ret
6952                     ; 2162 ITStatus TIM1_GetITStatus(TIM1_IT_TypeDef TIM1_IT)
6952                     ; 2163 {
6953                     .text:	section	.text,new
6954  0000               _TIM1_GetITStatus:
6956  0000 88            	push	a
6957  0001 89            	pushw	x
6958       00000002      OFST:	set	2
6961                     ; 2164     ITStatus bitstatus = RESET;
6963                     ; 2165     uint8_t TIM1_itStatus = 0, TIM1_itEnable = 0;
6967                     ; 2168     assert_param(IS_TIM1_GET_IT_OK(TIM1_IT));
6969                     ; 2170     TIM1_itStatus = (uint8_t)(TIM1->SR1 & (uint8_t)TIM1_IT);
6971  0002 c45255        	and	a,21077
6972  0005 6b01          	ld	(OFST-1,sp),a
6973                     ; 2172     TIM1_itEnable = (uint8_t)(TIM1->IER & (uint8_t)TIM1_IT);
6975  0007 c65254        	ld	a,21076
6976  000a 1403          	and	a,(OFST+1,sp)
6977  000c 6b02          	ld	(OFST+0,sp),a
6978                     ; 2174     if ((TIM1_itStatus != (uint8_t)RESET ) && (TIM1_itEnable != (uint8_t)RESET ))
6980  000e 0d01          	tnz	(OFST-1,sp)
6981  0010 270a          	jreq	L1453
6983  0012 0d02          	tnz	(OFST+0,sp)
6984  0014 2706          	jreq	L1453
6985                     ; 2176         bitstatus = SET;
6987  0016 a601          	ld	a,#1
6988  0018 6b02          	ld	(OFST+0,sp),a
6990  001a 2002          	jra	L3453
6991  001c               L1453:
6992                     ; 2180         bitstatus = RESET;
6994  001c 0f02          	clr	(OFST+0,sp)
6995  001e               L3453:
6996                     ; 2182     return (ITStatus)(bitstatus);
6998  001e 7b02          	ld	a,(OFST+0,sp)
7001  0020 5b03          	addw	sp,#3
7002  0022 81            	ret
7038                     ; 2199 void TIM1_ClearITPendingBit(TIM1_IT_TypeDef TIM1_IT)
7038                     ; 2200 {
7039                     .text:	section	.text,new
7040  0000               _TIM1_ClearITPendingBit:
7044                     ; 2202     assert_param(IS_TIM1_IT_OK(TIM1_IT));
7046                     ; 2205     TIM1->SR1 = (uint8_t)(~(uint8_t)TIM1_IT);
7048  0000 43            	cpl	a
7049  0001 c75255        	ld	21077,a
7050                     ; 2206 }
7053  0004 81            	ret
7105                     ; 2224 static void TI1_Config(uint8_t TIM1_ICPolarity,
7105                     ; 2225                        uint8_t TIM1_ICSelection,
7105                     ; 2226                        uint8_t TIM1_ICFilter)
7105                     ; 2227 {
7106                     .text:	section	.text,new
7107  0000               L3_TI1_Config:
7109  0000 89            	pushw	x
7110  0001 88            	push	a
7111       00000001      OFST:	set	1
7114                     ; 2230     TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
7116  0002 7211525c      	bres	21084,#0
7117                     ; 2233     TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF ))) | 
7117                     ; 2234                             (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
7119  0006 7b06          	ld	a,(OFST+5,sp)
7120  0008 97            	ld	xl,a
7121  0009 a610          	ld	a,#16
7122  000b 42            	mul	x,a
7123  000c 9f            	ld	a,xl
7124  000d 1a03          	or	a,(OFST+2,sp)
7125  000f 6b01          	ld	(OFST+0,sp),a
7126  0011 c65258        	ld	a,21080
7127  0014 a40c          	and	a,#12
7128  0016 1a01          	or	a,(OFST+0,sp)
7129  0018 c75258        	ld	21080,a
7130                     ; 2237     if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7132  001b 0d02          	tnz	(OFST+1,sp)
7133  001d 2706          	jreq	L1163
7134                     ; 2239         TIM1->CCER1 |= TIM1_CCER1_CC1P;
7136  001f 7212525c      	bset	21084,#1
7138  0023 2004          	jra	L3163
7139  0025               L1163:
7140                     ; 2243         TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
7142  0025 7213525c      	bres	21084,#1
7143  0029               L3163:
7144                     ; 2247     TIM1->CCER1 |=  TIM1_CCER1_CC1E;
7146  0029 7210525c      	bset	21084,#0
7147                     ; 2248 }
7150  002d 5b03          	addw	sp,#3
7151  002f 81            	ret
7203                     ; 2266 static void TI2_Config(uint8_t TIM1_ICPolarity,
7203                     ; 2267                        uint8_t TIM1_ICSelection,
7203                     ; 2268                        uint8_t TIM1_ICFilter)
7203                     ; 2269 {
7204                     .text:	section	.text,new
7205  0000               L5_TI2_Config:
7207  0000 89            	pushw	x
7208  0001 88            	push	a
7209       00000001      OFST:	set	1
7212                     ; 2271     TIM1->CCER1 &=  (uint8_t)(~TIM1_CCER1_CC2E);
7214  0002 7219525c      	bres	21084,#4
7215                     ; 2274     TIM1->CCMR2  = (uint8_t)((uint8_t)(TIM1->CCMR2 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF ))) 
7215                     ; 2275                             | (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
7217  0006 7b06          	ld	a,(OFST+5,sp)
7218  0008 97            	ld	xl,a
7219  0009 a610          	ld	a,#16
7220  000b 42            	mul	x,a
7221  000c 9f            	ld	a,xl
7222  000d 1a03          	or	a,(OFST+2,sp)
7223  000f 6b01          	ld	(OFST+0,sp),a
7224  0011 c65259        	ld	a,21081
7225  0014 a40c          	and	a,#12
7226  0016 1a01          	or	a,(OFST+0,sp)
7227  0018 c75259        	ld	21081,a
7228                     ; 2277     if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7230  001b 0d02          	tnz	(OFST+1,sp)
7231  001d 2706          	jreq	L3463
7232                     ; 2279         TIM1->CCER1 |= TIM1_CCER1_CC2P;
7234  001f 721a525c      	bset	21084,#5
7236  0023 2004          	jra	L5463
7237  0025               L3463:
7238                     ; 2283         TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC2P);
7240  0025 721b525c      	bres	21084,#5
7241  0029               L5463:
7242                     ; 2286     TIM1->CCER1 |=  TIM1_CCER1_CC2E;
7244  0029 7218525c      	bset	21084,#4
7245                     ; 2287 }
7248  002d 5b03          	addw	sp,#3
7249  002f 81            	ret
7301                     ; 2305 static void TI3_Config(uint8_t TIM1_ICPolarity,
7301                     ; 2306                        uint8_t TIM1_ICSelection,
7301                     ; 2307                        uint8_t TIM1_ICFilter)
7301                     ; 2308 {
7302                     .text:	section	.text,new
7303  0000               L7_TI3_Config:
7305  0000 89            	pushw	x
7306  0001 88            	push	a
7307       00000001      OFST:	set	1
7310                     ; 2310     TIM1->CCER2 &=  (uint8_t)(~TIM1_CCER2_CC3E);
7312  0002 7211525d      	bres	21085,#0
7313                     ; 2313     TIM1->CCMR3 = (uint8_t)((uint8_t)(TIM1->CCMR3 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF))) 
7313                     ; 2314                             | (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
7315  0006 7b06          	ld	a,(OFST+5,sp)
7316  0008 97            	ld	xl,a
7317  0009 a610          	ld	a,#16
7318  000b 42            	mul	x,a
7319  000c 9f            	ld	a,xl
7320  000d 1a03          	or	a,(OFST+2,sp)
7321  000f 6b01          	ld	(OFST+0,sp),a
7322  0011 c6525a        	ld	a,21082
7323  0014 a40c          	and	a,#12
7324  0016 1a01          	or	a,(OFST+0,sp)
7325  0018 c7525a        	ld	21082,a
7326                     ; 2317     if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7328  001b 0d02          	tnz	(OFST+1,sp)
7329  001d 2706          	jreq	L5763
7330                     ; 2319         TIM1->CCER2 |= TIM1_CCER2_CC3P;
7332  001f 7212525d      	bset	21085,#1
7334  0023 2004          	jra	L7763
7335  0025               L5763:
7336                     ; 2323         TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC3P);
7338  0025 7213525d      	bres	21085,#1
7339  0029               L7763:
7340                     ; 2326     TIM1->CCER2 |=  TIM1_CCER2_CC3E;
7342  0029 7210525d      	bset	21085,#0
7343                     ; 2327 }
7346  002d 5b03          	addw	sp,#3
7347  002f 81            	ret
7399                     ; 2346 static void TI4_Config(uint8_t TIM1_ICPolarity,
7399                     ; 2347                        uint8_t TIM1_ICSelection,
7399                     ; 2348                        uint8_t TIM1_ICFilter)
7399                     ; 2349 {
7400                     .text:	section	.text,new
7401  0000               L11_TI4_Config:
7403  0000 89            	pushw	x
7404  0001 88            	push	a
7405       00000001      OFST:	set	1
7408                     ; 2352     TIM1->CCER2 &=  (uint8_t)(~TIM1_CCER2_CC4E);
7410  0002 7219525d      	bres	21085,#4
7411                     ; 2355     TIM1->CCMR4 = (uint8_t)((uint8_t)(TIM1->CCMR4 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF )))
7411                     ; 2356                             | (uint8_t)(( (TIM1_ICSelection)) | ((uint8_t)( TIM1_ICFilter << 4))));
7413  0006 7b06          	ld	a,(OFST+5,sp)
7414  0008 97            	ld	xl,a
7415  0009 a610          	ld	a,#16
7416  000b 42            	mul	x,a
7417  000c 9f            	ld	a,xl
7418  000d 1a03          	or	a,(OFST+2,sp)
7419  000f 6b01          	ld	(OFST+0,sp),a
7420  0011 c6525b        	ld	a,21083
7421  0014 a40c          	and	a,#12
7422  0016 1a01          	or	a,(OFST+0,sp)
7423  0018 c7525b        	ld	21083,a
7424                     ; 2359     if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7426  001b 0d02          	tnz	(OFST+1,sp)
7427  001d 2706          	jreq	L7273
7428                     ; 2361         TIM1->CCER2 |= TIM1_CCER2_CC4P;
7430  001f 721a525d      	bset	21085,#5
7432  0023 2004          	jra	L1373
7433  0025               L7273:
7434                     ; 2365         TIM1->CCER2 &= (uint8_t)(~TIM1_CCER2_CC4P);
7436  0025 721b525d      	bres	21085,#5
7437  0029               L1373:
7438                     ; 2369     TIM1->CCER2 |=  TIM1_CCER2_CC4E;
7440  0029 7218525d      	bset	21085,#4
7441                     ; 2370 }
7444  002d 5b03          	addw	sp,#3
7445  002f 81            	ret
7458                     	xdef	_TIM1_ClearITPendingBit
7459                     	xdef	_TIM1_GetITStatus
7460                     	xdef	_TIM1_ClearFlag
7461                     	xdef	_TIM1_GetFlagStatus
7462                     	xdef	_TIM1_GetPrescaler
7463                     	xdef	_TIM1_GetCounter
7464                     	xdef	_TIM1_GetCapture4
7465                     	xdef	_TIM1_GetCapture3
7466                     	xdef	_TIM1_GetCapture2
7467                     	xdef	_TIM1_GetCapture1
7468                     	xdef	_TIM1_SetIC4Prescaler
7469                     	xdef	_TIM1_SetIC3Prescaler
7470                     	xdef	_TIM1_SetIC2Prescaler
7471                     	xdef	_TIM1_SetIC1Prescaler
7472                     	xdef	_TIM1_SetCompare4
7473                     	xdef	_TIM1_SetCompare3
7474                     	xdef	_TIM1_SetCompare2
7475                     	xdef	_TIM1_SetCompare1
7476                     	xdef	_TIM1_SetAutoreload
7477                     	xdef	_TIM1_SetCounter
7478                     	xdef	_TIM1_SelectOCxM
7479                     	xdef	_TIM1_CCxNCmd
7480                     	xdef	_TIM1_CCxCmd
7481                     	xdef	_TIM1_OC4PolarityConfig
7482                     	xdef	_TIM1_OC3NPolarityConfig
7483                     	xdef	_TIM1_OC3PolarityConfig
7484                     	xdef	_TIM1_OC2NPolarityConfig
7485                     	xdef	_TIM1_OC2PolarityConfig
7486                     	xdef	_TIM1_OC1NPolarityConfig
7487                     	xdef	_TIM1_OC1PolarityConfig
7488                     	xdef	_TIM1_GenerateEvent
7489                     	xdef	_TIM1_OC4FastConfig
7490                     	xdef	_TIM1_OC3FastConfig
7491                     	xdef	_TIM1_OC2FastConfig
7492                     	xdef	_TIM1_OC1FastConfig
7493                     	xdef	_TIM1_OC4PreloadConfig
7494                     	xdef	_TIM1_OC3PreloadConfig
7495                     	xdef	_TIM1_OC2PreloadConfig
7496                     	xdef	_TIM1_OC1PreloadConfig
7497                     	xdef	_TIM1_CCPreloadControl
7498                     	xdef	_TIM1_SelectCOM
7499                     	xdef	_TIM1_ARRPreloadConfig
7500                     	xdef	_TIM1_ForcedOC4Config
7501                     	xdef	_TIM1_ForcedOC3Config
7502                     	xdef	_TIM1_ForcedOC2Config
7503                     	xdef	_TIM1_ForcedOC1Config
7504                     	xdef	_TIM1_CounterModeConfig
7505                     	xdef	_TIM1_PrescalerConfig
7506                     	xdef	_TIM1_EncoderInterfaceConfig
7507                     	xdef	_TIM1_SelectMasterSlaveMode
7508                     	xdef	_TIM1_SelectSlaveMode
7509                     	xdef	_TIM1_SelectOutputTrigger
7510                     	xdef	_TIM1_SelectOnePulseMode
7511                     	xdef	_TIM1_SelectHallSensor
7512                     	xdef	_TIM1_UpdateRequestConfig
7513                     	xdef	_TIM1_UpdateDisableConfig
7514                     	xdef	_TIM1_SelectInputTrigger
7515                     	xdef	_TIM1_TIxExternalClockConfig
7516                     	xdef	_TIM1_ETRConfig
7517                     	xdef	_TIM1_ETRClockMode2Config
7518                     	xdef	_TIM1_ETRClockMode1Config
7519                     	xdef	_TIM1_InternalClockConfig
7520                     	xdef	_TIM1_ITConfig
7521                     	xdef	_TIM1_CtrlPWMOutputs
7522                     	xdef	_TIM1_Cmd
7523                     	xdef	_TIM1_PWMIConfig
7524                     	xdef	_TIM1_ICInit
7525                     	xdef	_TIM1_BDTRConfig
7526                     	xdef	_TIM1_OC4Init
7527                     	xdef	_TIM1_OC3Init
7528                     	xdef	_TIM1_OC2Init
7529                     	xdef	_TIM1_OC1Init
7530                     	xdef	_TIM1_TimeBaseInit
7531                     	xdef	_TIM1_DeInit
7550                     	end
