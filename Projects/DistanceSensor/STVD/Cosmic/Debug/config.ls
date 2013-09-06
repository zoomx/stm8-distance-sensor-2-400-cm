   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  72                     ; 3 void Config()
  72                     ; 4 {
  74                     .text:	section	.text,new
  75  0000               _Config:
  79                     ; 10   CLK_DeInit();
  81  0000 cd0000        	call	_CLK_DeInit
  83                     ; 11   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
  85  0003 a680          	ld	a,#128
  86  0005 cd0000        	call	_CLK_SYSCLKConfig
  88                     ; 12   CLK->ECKR |= 0x01;   /* HSEEN: High speed external crystal oscillator enable */
  90  0008 721050c1      	bset	20673,#0
  92  000c               L32:
  93                     ; 13   while(!(CLK->ECKR & 0x02));  /* HSERDY: High speed external crystal oscillator ready, waint until HSE ready */
  95  000c 720350c1fb    	btjf	20673,#1,L32
  96                     ; 14   CLK->SWCR |= 0x02;   /* set SWEN bit: Switch start/stop */
  98  0011 721250c5      	bset	20677,#1
  99                     ; 15   CLK->SWR = 0xB4;     /* HSE selected as master clock source */
 101  0015 35b450c4      	mov	20676,#180
 103  0019               L33:
 104                     ; 16   while(CLK->SWCR & 0x01);   /* wait until switch busy: SWBSY = 1 */
 106  0019 720050c5fb    	btjt	20677,#0,L33
 107                     ; 26   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);   /* 8bit: for implementing delays */
 109  001e ae0401        	ldw	x,#1025
 110  0021 cd0000        	call	_CLK_PeripheralClockConfig
 112                     ; 27   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);   /* 16bit: for capture of ultrasonic distance pulse width */
 114  0024 ae0701        	ldw	x,#1793
 115  0027 cd0000        	call	_CLK_PeripheralClockConfig
 117                     ; 28   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);   /* 16bit: PWM output for dimming of the display */
 119  002a ae0501        	ldw	x,#1281
 120  002d cd0000        	call	_CLK_PeripheralClockConfig
 122                     ; 30   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);     /* Enable SPI peripheral clock */
 124  0030 ae0101        	ldw	x,#257
 125  0033 cd0000        	call	_CLK_PeripheralClockConfig
 127                     ; 31   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);   /* Enable UART1 peripheral clock */
 129  0036 ae0301        	ldw	x,#769
 130  0039 cd0000        	call	_CLK_PeripheralClockConfig
 132                     ; 34   GPIO_Init(SONAR_TRIG_PORT, SONAR_TRIG_PIN, GPIO_MODE_OUT_PP_LOW_FAST);      /* Sonar trigger pin - output push-pull */
 134  003c 4be0          	push	#224
 135  003e 4b80          	push	#128
 136  0040 ae5005        	ldw	x,#20485
 137  0043 cd0000        	call	_GPIO_Init
 139  0046 85            	popw	x
 140                     ; 35   GPIO_Init(SONAR_TMR_TRIG_PORT, SONAR_TMR_TRIG_PIN, GPIO_MODE_IN_PU_NO_IT);  /* Sonar timer trigger start pin(rising) - input pullup */
 142  0047 4b40          	push	#64
 143  0049 4b04          	push	#4
 144  004b ae500a        	ldw	x,#20490
 145  004e cd0000        	call	_GPIO_Init
 147  0051 85            	popw	x
 148                     ; 36   GPIO_Init(SONAR_TMR_CAP_PORT, SONAR_TMR_CAP_PIN, GPIO_MODE_IN_PU_NO_IT);    /* Sonar timer trigger capture pin(falling) - input pullup */
 150  0052 4b40          	push	#64
 151  0054 4b08          	push	#8
 152  0056 ae500a        	ldw	x,#20490
 153  0059 cd0000        	call	_GPIO_Init
 155  005c 85            	popw	x
 156                     ; 39   GPIO_Init(LED_PORT, LED_PIN, GPIO_MODE_OUT_OD_HIZ_SLOW);
 158  005d 4b90          	push	#144
 159  005f 4b01          	push	#1
 160  0061 ae500f        	ldw	x,#20495
 161  0064 cd0000        	call	_GPIO_Init
 163  0067 85            	popw	x
 164                     ; 42   GPIO_Init(DEBUG_PIN_PORT, DEBUG_PIN_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
 166  0068 4be0          	push	#224
 167  006a 4b10          	push	#16
 168  006c ae5019        	ldw	x,#20505
 169  006f cd0000        	call	_GPIO_Init
 171  0072 85            	popw	x
 172                     ; 45   GPIO_Init(ONEWIREBUS_PORT, ONEWIREBUS_PIN, GPIO_MODE_OUT_OD_HIZ_FAST);
 174  0073 4bb0          	push	#176
 175  0075 4b40          	push	#64
 176  0077 ae5005        	ldw	x,#20485
 177  007a cd0000        	call	_GPIO_Init
 179  007d 85            	popw	x
 180                     ; 48   GPIO_Init(GPIOC, GPIO_PIN_5, GPIO_MODE_OUT_PP_LOW_FAST);   //SCK
 182  007e 4be0          	push	#224
 183  0080 4b20          	push	#32
 184  0082 ae500a        	ldw	x,#20490
 185  0085 cd0000        	call	_GPIO_Init
 187  0088 85            	popw	x
 188                     ; 49   GPIO_Init(GPIOC, GPIO_PIN_6, GPIO_MODE_OUT_PP_LOW_FAST);   //MOSI
 190  0089 4be0          	push	#224
 191  008b 4b40          	push	#64
 192  008d ae500a        	ldw	x,#20490
 193  0090 cd0000        	call	_GPIO_Init
 195  0093 85            	popw	x
 196                     ; 50   GPIO_Init(GPIOC, GPIO_PIN_7, GPIO_MODE_IN_PU_NO_IT);       //MISO
 198  0094 4b40          	push	#64
 199  0096 4b80          	push	#128
 200  0098 ae500a        	ldw	x,#20490
 201  009b cd0000        	call	_GPIO_Init
 203  009e 85            	popw	x
 204                     ; 51   GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST);   //CS
 206  009f 4bf0          	push	#240
 207  00a1 4b10          	push	#16
 208  00a3 ae500a        	ldw	x,#20490
 209  00a6 cd0000        	call	_GPIO_Init
 211  00a9 85            	popw	x
 212                     ; 54   GPIO_Init(DISP_PORT, DISP_SDI_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
 214  00aa 4be0          	push	#224
 215  00ac 4b04          	push	#4
 216  00ae ae500f        	ldw	x,#20495
 217  00b1 cd0000        	call	_GPIO_Init
 219  00b4 85            	popw	x
 220                     ; 55   GPIO_Init(DISP_PORT, DISP_nOE_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
 222  00b5 cd01a7        	call	LC001
 223                     ; 56   GPIO_Init(DISP_PORT, DISP_LE_PIN, GPIO_MODE_OUT_PP_LOW_FAST);    
 225  00b8 4be0          	push	#224
 226  00ba 4b10          	push	#16
 227  00bc ae500f        	ldw	x,#20495
 228  00bf cd0000        	call	_GPIO_Init
 230  00c2 85            	popw	x
 231                     ; 57   GPIO_Init(DISP_PORT, DISP_CLK_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
 233  00c3 4be0          	push	#224
 234  00c5 4b80          	push	#128
 235  00c7 ae500f        	ldw	x,#20495
 236  00ca cd0000        	call	_GPIO_Init
 238  00cd 85            	popw	x
 239                     ; 60   UART1_DeInit();
 241  00ce cd0000        	call	_UART1_DeInit
 243                     ; 61   GPIO_Init(USART_PORT, USART_TX_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
 245  00d1 4be0          	push	#224
 246  00d3 4b20          	push	#32
 247  00d5 ae500f        	ldw	x,#20495
 248  00d8 cd0000        	call	_GPIO_Init
 250  00db 85            	popw	x
 251                     ; 62   GPIO_Init(USART_PORT, USART_RX_PIN, GPIO_MODE_IN_PU_NO_IT);
 253  00dc 4b40          	push	#64
 254  00de 4b40          	push	#64
 255  00e0 ae500f        	ldw	x,#20495
 256  00e3 cd0000        	call	_GPIO_Init
 258  00e6 85            	popw	x
 259                     ; 63   UART1_Init(115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, 
 259                     ; 64                 UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 261  00e7 4b0c          	push	#12
 262  00e9 4b80          	push	#128
 263  00eb 4b00          	push	#0
 264  00ed 4b00          	push	#0
 265  00ef 4b00          	push	#0
 266  00f1 aec200        	ldw	x,#49664
 267  00f4 89            	pushw	x
 268  00f5 ae0001        	ldw	x,#1
 269  00f8 89            	pushw	x
 270  00f9 cd0000        	call	_UART1_Init
 272  00fc 5b09          	addw	sp,#9
 273                     ; 65   UART1_ITConfig(UART1_IT_RXNE, ENABLE);
 275  00fe 4b01          	push	#1
 276  0100 ae0255        	ldw	x,#597
 277  0103 cd0000        	call	_UART1_ITConfig
 279  0106 84            	pop	a
 280                     ; 66   UART1_Cmd(ENABLE);
 282  0107 a601          	ld	a,#1
 283  0109 cd0000        	call	_UART1_Cmd
 285                     ; 69   GPIO_Init(SOFTI2C_PORT, SOFTI2C_SCL_PIN, GPIO_MODE_OUT_OD_HIZ_FAST);
 287  010c 4bb0          	push	#176
 288  010e 4b04          	push	#4
 289  0110 ae5005        	ldw	x,#20485
 290  0113 cd0000        	call	_GPIO_Init
 292  0116 85            	popw	x
 293                     ; 70   GPIO_Init(SOFTI2C_PORT, SOFTI2C_SDA_PIN, GPIO_MODE_OUT_OD_HIZ_FAST);
 295  0117 4bb0          	push	#176
 296  0119 4b08          	push	#8
 297  011b ae5005        	ldw	x,#20485
 298  011e cd0000        	call	_GPIO_Init
 300  0121 85            	popw	x
 301                     ; 74   TIM4_DeInit();
 303  0122 cd0000        	call	_TIM4_DeInit
 305                     ; 75   TIM4_TimeBaseInit(TIM4_PRESCALER_128, 250);                 /* 2MS overflow interval - 500Hz*/
 307  0125 ae07fa        	ldw	x,#2042
 308  0128 cd0000        	call	_TIM4_TimeBaseInit
 310                     ; 76   TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
 312  012b ae0101        	ldw	x,#257
 313  012e cd0000        	call	_TIM4_ITConfig
 315                     ; 77   TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 317  0131 a601          	ld	a,#1
 318  0133 cd0000        	call	_TIM4_ClearITPendingBit
 320                     ; 78   TIM4_Cmd(ENABLE);
 322  0136 a601          	ld	a,#1
 323  0138 cd0000        	call	_TIM4_Cmd
 325                     ; 81   TIM1_DeInit();
 327  013b cd0000        	call	_TIM1_DeInit
 329                     ; 82   TIM1_TimeBaseInit(16, TIM1_COUNTERMODE_UP, 65535, 0x00);     /* 65.536ms overflow period */
 331  013e 4b00          	push	#0
 332  0140 aeffff        	ldw	x,#65535
 333  0143 89            	pushw	x
 334  0144 4b00          	push	#0
 335  0146 ae0010        	ldw	x,#16
 336  0149 cd0000        	call	_TIM1_TimeBaseInit
 338                     ; 84   TIM1->CCER1 &= (u8)(~(0x20)); /* Write CC2P = 0 in TIM1_CCER1 register to validate the polarity (and detect rising edges).*/
 340  014c 721b525c      	bres	21084,#5
 341  0150 5b04          	addw	sp,#4
 342                     ; 85   TIM1->SMCR |= 0x06;  /* Configure the timer in trigger mode by writing SMS = 110 */
 344  0152 c65252        	ld	a,21074
 345  0155 aa06          	or	a,#6
 346  0157 c75252        	ld	21074,a
 347                     ; 86   TIM1->SMCR |= 0x60;  /* TS = 110, 110: Filtered timer input 2 (TI2FP2) */
 349  015a c65252        	ld	a,21074
 350  015d aa60          	or	a,#96
 351  015f c75252        	ld	21074,a
 352                     ; 87   TIM1->CCMR3 |= 0x01;  /* 01: CC3 channel is configured as input, IC3 is mapped on TI3FP3 */
 354  0162 7210525a      	bset	21082,#0
 355                     ; 88   TIM1->CCER2 |= 0x01;  /* CC3E: Capture/compare 3 output enable */
 357  0166 7210525d      	bset	21085,#0
 358                     ; 89   TIM1->CCER2 |= 0x02;  /* CC3P: Capture/compare 3 output polarity, 1: Capture on a falling edge */
 360                     ; 91   TIM1_ITConfig(TIM1_IT_CC3, ENABLE);            /* interrupt on timer capture compare 3 - falling edge of pulse */
 362  016a ae0801        	ldw	x,#2049
 363  016d 7212525d      	bset	21085,#1
 364  0171 cd0000        	call	_TIM1_ITConfig
 366                     ; 92   TIM1_ClearITPendingBit(TIM1_FLAG_CC3);
 368  0174 a608          	ld	a,#8
 369  0176 cd0000        	call	_TIM1_ClearITPendingBit
 371                     ; 93   TIM1_ClearITPendingBit(TIM1_FLAG_CC2);
 373  0179 a604          	ld	a,#4
 374  017b cd0000        	call	_TIM1_ClearITPendingBit
 376                     ; 94   TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
 378  017e a601          	ld	a,#1
 379  0180 cd0000        	call	_TIM1_ClearITPendingBit
 381                     ; 98   TIM2_DeInit();
 383  0183 cd0000        	call	_TIM2_DeInit
 385                     ; 99   TIM2_TimeBaseInit(TIM2_PRESCALER_1, 10000);    // 0.625MS period - 1,6Khz
 387  0186 ae2710        	ldw	x,#10000
 388  0189 89            	pushw	x
 389  018a 4f            	clr	a
 390  018b cd0000        	call	_TIM2_TimeBaseInit
 392  018e 85            	popw	x
 393                     ; 100   TIM2_OC2Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 5000, TIM2_OCPOLARITY_HIGH);  // set duty to 50%
 395  018f 4b00          	push	#0
 396  0191 ae1388        	ldw	x,#5000
 397  0194 89            	pushw	x
 398  0195 ae6011        	ldw	x,#24593
 399  0198 cd0000        	call	_TIM2_OC2Init
 401  019b 5b03          	addw	sp,#3
 402                     ; 101   TIM2_OC2PreloadConfig(ENABLE);
 404  019d a601          	ld	a,#1
 405  019f cd0000        	call	_TIM2_OC2PreloadConfig
 407                     ; 102   TIM2_Cmd(ENABLE);
 409  01a2 a601          	ld	a,#1
 410  01a4 cd0000        	call	_TIM2_Cmd
 412                     ; 103   GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 414                     ; 104 }
 417  01a7               LC001:
 418  01a7 4be0          	push	#224
 419  01a9 4b08          	push	#8
 420  01ab ae500f        	ldw	x,#20495
 421  01ae cd0000        	call	_GPIO_Init
 423  01b1 85            	popw	x
 424  01b2 81            	ret	
 437                     	xdef	_Config
 438                     	xref	_UART1_ITConfig
 439                     	xref	_UART1_Cmd
 440                     	xref	_UART1_Init
 441                     	xref	_UART1_DeInit
 442                     	xref	_TIM4_ClearITPendingBit
 443                     	xref	_TIM4_ITConfig
 444                     	xref	_TIM4_Cmd
 445                     	xref	_TIM4_TimeBaseInit
 446                     	xref	_TIM4_DeInit
 447                     	xref	_TIM2_OC2PreloadConfig
 448                     	xref	_TIM2_Cmd
 449                     	xref	_TIM2_OC2Init
 450                     	xref	_TIM2_TimeBaseInit
 451                     	xref	_TIM2_DeInit
 452                     	xref	_TIM1_ClearITPendingBit
 453                     	xref	_TIM1_ITConfig
 454                     	xref	_TIM1_TimeBaseInit
 455                     	xref	_TIM1_DeInit
 456                     	xref	_GPIO_Init
 457                     	xref	_CLK_SYSCLKConfig
 458                     	xref	_CLK_PeripheralClockConfig
 459                     	xref	_CLK_DeInit
 478                     	end
