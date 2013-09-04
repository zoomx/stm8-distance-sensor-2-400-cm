   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  70                     ; 3 void Config()
  70                     ; 4 {
  72                     .text:	section	.text,new
  73  0000               _Config:
  77                     ; 10   CLK_DeInit();
  79  0000 cd0000        	call	_CLK_DeInit
  81                     ; 11   CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
  83  0003 a680          	ld	a,#128
  84  0005 cd0000        	call	_CLK_SYSCLKConfig
  86                     ; 12   CLK->ECKR |= 0x01;   /* HSEEN: High speed external crystal oscillator enable */
  88  0008 721050c1      	bset	20673,#0
  90  000c               L32:
  91                     ; 13   while(!(CLK->ECKR & 0x02));  /* HSERDY: High speed external crystal oscillator ready, waint until HSE ready */
  93  000c 720350c1fb    	btjf	20673,#1,L32
  94                     ; 14   CLK->SWCR |= 0x02;   /* set SWEN bit: Switch start/stop */
  96  0011 721250c5      	bset	20677,#1
  97                     ; 15   CLK->SWR = 0xB4;     /* HSE selected as master clock source */
  99  0015 35b450c4      	mov	20676,#180
 101  0019               L33:
 102                     ; 16   while(CLK->SWCR & 0x01);   /* wait until switch busy: SWBSY = 1 */
 104  0019 720050c5fb    	btjt	20677,#0,L33
 105                     ; 26   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);   /* 8bit: for implementing delays */
 107  001e ae0401        	ldw	x,#1025
 108  0021 cd0000        	call	_CLK_PeripheralClockConfig
 110                     ; 27   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);   /* 16bit: for capture of ultrasonic distance pulse width */
 112  0024 ae0701        	ldw	x,#1793
 113  0027 cd0000        	call	_CLK_PeripheralClockConfig
 115                     ; 28   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);   /* 16bit: PWM output for dimming of the display */
 117  002a ae0501        	ldw	x,#1281
 118  002d cd0000        	call	_CLK_PeripheralClockConfig
 120                     ; 30   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);     /* Enable SPI peripheral clock */
 122  0030 ae0101        	ldw	x,#257
 123  0033 cd0000        	call	_CLK_PeripheralClockConfig
 125                     ; 31   CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);   /* Enable UART1 peripheral clock */
 127  0036 ae0301        	ldw	x,#769
 128  0039 cd0000        	call	_CLK_PeripheralClockConfig
 130                     ; 34   GPIO_Init(SONAR_TRIG_PORT, SONAR_TRIG_PIN, GPIO_MODE_OUT_PP_LOW_FAST);      /* Sonar trigger pin - output push-pull */
 132  003c 4be0          	push	#224
 133  003e 4b80          	push	#128
 134  0040 ae5005        	ldw	x,#20485
 135  0043 cd0000        	call	_GPIO_Init
 137  0046 85            	popw	x
 138                     ; 35   GPIO_Init(SONAR_TMR_TRIG_PORT, SONAR_TMR_TRIG_PIN, GPIO_MODE_IN_PU_NO_IT);  /* Sonar timer trigger start pin(rising) - input pullup */
 140  0047 4b40          	push	#64
 141  0049 4b04          	push	#4
 142  004b ae500a        	ldw	x,#20490
 143  004e cd0000        	call	_GPIO_Init
 145  0051 85            	popw	x
 146                     ; 36   GPIO_Init(SONAR_TMR_CAP_PORT, SONAR_TMR_CAP_PIN, GPIO_MODE_IN_PU_NO_IT);    /* Sonar timer trigger capture pin(falling) - input pullup */
 148  0052 4b40          	push	#64
 149  0054 4b08          	push	#8
 150  0056 ae500a        	ldw	x,#20490
 151  0059 cd0000        	call	_GPIO_Init
 153  005c 85            	popw	x
 154                     ; 39   GPIO_Init(LED_PORT, LED_PIN, GPIO_MODE_OUT_OD_HIZ_SLOW);
 156  005d 4b90          	push	#144
 157  005f 4b01          	push	#1
 158  0061 ae500f        	ldw	x,#20495
 159  0064 cd0000        	call	_GPIO_Init
 161  0067 85            	popw	x
 162                     ; 42   GPIO_Init(DEBUG_PIN_PORT, DEBUG_PIN_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
 164  0068 4be0          	push	#224
 165  006a 4b10          	push	#16
 166  006c ae5019        	ldw	x,#20505
 167  006f cd0000        	call	_GPIO_Init
 169  0072 85            	popw	x
 170                     ; 45   GPIO_Init(ONEWIREBUS_PORT, ONEWIREBUS_PIN, GPIO_MODE_OUT_OD_HIZ_FAST);
 172  0073 4bb0          	push	#176
 173  0075 4b40          	push	#64
 174  0077 ae5005        	ldw	x,#20485
 175  007a cd0000        	call	_GPIO_Init
 177  007d 85            	popw	x
 178                     ; 48   GPIO_Init(GPIOC, GPIO_PIN_5, GPIO_MODE_OUT_PP_LOW_FAST);   //SCK
 180  007e 4be0          	push	#224
 181  0080 4b20          	push	#32
 182  0082 ae500a        	ldw	x,#20490
 183  0085 cd0000        	call	_GPIO_Init
 185  0088 85            	popw	x
 186                     ; 49   GPIO_Init(GPIOC, GPIO_PIN_6, GPIO_MODE_OUT_PP_LOW_FAST);   //MOSI
 188  0089 4be0          	push	#224
 189  008b 4b40          	push	#64
 190  008d ae500a        	ldw	x,#20490
 191  0090 cd0000        	call	_GPIO_Init
 193  0093 85            	popw	x
 194                     ; 50   GPIO_Init(GPIOC, GPIO_PIN_7, GPIO_MODE_IN_PU_NO_IT);       //MISO
 196  0094 4b40          	push	#64
 197  0096 4b80          	push	#128
 198  0098 ae500a        	ldw	x,#20490
 199  009b cd0000        	call	_GPIO_Init
 201  009e 85            	popw	x
 202                     ; 51   GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST);   //CS
 204  009f 4bf0          	push	#240
 205  00a1 4b10          	push	#16
 206  00a3 ae500a        	ldw	x,#20490
 207  00a6 cd0000        	call	_GPIO_Init
 209  00a9 85            	popw	x
 210                     ; 54   GPIO_Init(DISP_PORT, DISP_SDI_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
 212  00aa 4be0          	push	#224
 213  00ac 4b04          	push	#4
 214  00ae ae500f        	ldw	x,#20495
 215  00b1 cd0000        	call	_GPIO_Init
 217  00b4 85            	popw	x
 218                     ; 55   GPIO_Init(DISP_PORT, DISP_nOE_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
 220  00b5 cd01a7        	call	LC001
 221                     ; 56   GPIO_Init(DISP_PORT, DISP_LE_PIN, GPIO_MODE_OUT_PP_LOW_FAST);    
 223  00b8 4be0          	push	#224
 224  00ba 4b10          	push	#16
 225  00bc ae500f        	ldw	x,#20495
 226  00bf cd0000        	call	_GPIO_Init
 228  00c2 85            	popw	x
 229                     ; 57   GPIO_Init(DISP_PORT, DISP_CLK_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
 231  00c3 4be0          	push	#224
 232  00c5 4b80          	push	#128
 233  00c7 ae500f        	ldw	x,#20495
 234  00ca cd0000        	call	_GPIO_Init
 236  00cd 85            	popw	x
 237                     ; 60   UART1_DeInit();
 239  00ce cd0000        	call	_UART1_DeInit
 241                     ; 61   GPIO_Init(USART_PORT, USART_TX_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
 243  00d1 4be0          	push	#224
 244  00d3 4b20          	push	#32
 245  00d5 ae500f        	ldw	x,#20495
 246  00d8 cd0000        	call	_GPIO_Init
 248  00db 85            	popw	x
 249                     ; 62   GPIO_Init(USART_PORT, USART_RX_PIN, GPIO_MODE_IN_PU_NO_IT);
 251  00dc 4b40          	push	#64
 252  00de 4b40          	push	#64
 253  00e0 ae500f        	ldw	x,#20495
 254  00e3 cd0000        	call	_GPIO_Init
 256  00e6 85            	popw	x
 257                     ; 63   UART1_Init(115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, 
 257                     ; 64                 UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 259  00e7 4b0c          	push	#12
 260  00e9 4b80          	push	#128
 261  00eb 4b00          	push	#0
 262  00ed 4b00          	push	#0
 263  00ef 4b00          	push	#0
 264  00f1 aec200        	ldw	x,#49664
 265  00f4 89            	pushw	x
 266  00f5 ae0001        	ldw	x,#1
 267  00f8 89            	pushw	x
 268  00f9 cd0000        	call	_UART1_Init
 270  00fc 5b09          	addw	sp,#9
 271                     ; 65   UART1_ITConfig(UART1_IT_RXNE, ENABLE);
 273  00fe 4b01          	push	#1
 274  0100 ae0255        	ldw	x,#597
 275  0103 cd0000        	call	_UART1_ITConfig
 277  0106 84            	pop	a
 278                     ; 66   UART1_Cmd(ENABLE);
 280  0107 a601          	ld	a,#1
 281  0109 cd0000        	call	_UART1_Cmd
 283                     ; 69   GPIO_Init(SOFTI2C_PORT, SOFTI2C_SCL_PIN, GPIO_MODE_OUT_OD_HIZ_FAST);
 285  010c 4bb0          	push	#176
 286  010e 4b04          	push	#4
 287  0110 ae5005        	ldw	x,#20485
 288  0113 cd0000        	call	_GPIO_Init
 290  0116 85            	popw	x
 291                     ; 70   GPIO_Init(SOFTI2C_PORT, SOFTI2C_SDA_PIN, GPIO_MODE_OUT_OD_HIZ_FAST);
 293  0117 4bb0          	push	#176
 294  0119 4b08          	push	#8
 295  011b ae5005        	ldw	x,#20485
 296  011e cd0000        	call	_GPIO_Init
 298  0121 85            	popw	x
 299                     ; 74   TIM4_DeInit();
 301  0122 cd0000        	call	_TIM4_DeInit
 303                     ; 75   TIM4_TimeBaseInit(TIM4_PRESCALER_128, 250);                 /* 2MS overflow interval - 500Hz*/
 305  0125 ae07fa        	ldw	x,#2042
 306  0128 cd0000        	call	_TIM4_TimeBaseInit
 308                     ; 76   TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
 310  012b ae0101        	ldw	x,#257
 311  012e cd0000        	call	_TIM4_ITConfig
 313                     ; 77   TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 315  0131 a601          	ld	a,#1
 316  0133 cd0000        	call	_TIM4_ClearITPendingBit
 318                     ; 78   TIM4_Cmd(ENABLE);
 320  0136 a601          	ld	a,#1
 321  0138 cd0000        	call	_TIM4_Cmd
 323                     ; 81   TIM1_DeInit();
 325  013b cd0000        	call	_TIM1_DeInit
 327                     ; 82   TIM1_TimeBaseInit(16, TIM1_COUNTERMODE_UP, 65535, 0x00);     /* 65.536ms overflow period */
 329  013e 4b00          	push	#0
 330  0140 aeffff        	ldw	x,#65535
 331  0143 89            	pushw	x
 332  0144 4b00          	push	#0
 333  0146 ae0010        	ldw	x,#16
 334  0149 cd0000        	call	_TIM1_TimeBaseInit
 336                     ; 84   TIM1->CCER1 &= (u8)(~(0x20)); /* Write CC2P = 0 in TIM1_CCER1 register to validate the polarity (and detect rising edges).*/
 338  014c 721b525c      	bres	21084,#5
 339  0150 5b04          	addw	sp,#4
 340                     ; 85   TIM1->SMCR |= 0x06;  /* Configure the timer in trigger mode by writing SMS = 110 */
 342  0152 c65252        	ld	a,21074
 343  0155 aa06          	or	a,#6
 344  0157 c75252        	ld	21074,a
 345                     ; 86   TIM1->SMCR |= 0x60;  /* TS = 110, 110: Filtered timer input 2 (TI2FP2) */
 347  015a c65252        	ld	a,21074
 348  015d aa60          	or	a,#96
 349  015f c75252        	ld	21074,a
 350                     ; 87   TIM1->CCMR3 |= 0x01;  /* 01: CC3 channel is configured as input, IC3 is mapped on TI3FP3 */
 352  0162 7210525a      	bset	21082,#0
 353                     ; 88   TIM1->CCER2 |= 0x01;  /* CC3E: Capture/compare 3 output enable */
 355  0166 7210525d      	bset	21085,#0
 356                     ; 89   TIM1->CCER2 |= 0x02;  /* CC3P: Capture/compare 3 output polarity, 1: Capture on a falling edge */
 358                     ; 91   TIM1_ITConfig(TIM1_IT_CC3, ENABLE);            /* interrupt on timer capture compare 3 - falling edge of pulse */
 360  016a ae0801        	ldw	x,#2049
 361  016d 7212525d      	bset	21085,#1
 362  0171 cd0000        	call	_TIM1_ITConfig
 364                     ; 92   TIM1_ClearITPendingBit(TIM1_FLAG_CC3);
 366  0174 a608          	ld	a,#8
 367  0176 cd0000        	call	_TIM1_ClearITPendingBit
 369                     ; 93   TIM1_ClearITPendingBit(TIM1_FLAG_CC2);
 371  0179 a604          	ld	a,#4
 372  017b cd0000        	call	_TIM1_ClearITPendingBit
 374                     ; 94   TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
 376  017e a601          	ld	a,#1
 377  0180 cd0000        	call	_TIM1_ClearITPendingBit
 379                     ; 98   TIM2_DeInit();
 381  0183 cd0000        	call	_TIM2_DeInit
 383                     ; 99   TIM2_TimeBaseInit(TIM2_PRESCALER_1, 10000);    // 0.625MS period - 1,6Khz
 385  0186 ae2710        	ldw	x,#10000
 386  0189 89            	pushw	x
 387  018a 4f            	clr	a
 388  018b cd0000        	call	_TIM2_TimeBaseInit
 390  018e 85            	popw	x
 391                     ; 100   TIM2_OC2Init(TIM2_OCMODE_PWM1, TIM2_OUTPUTSTATE_ENABLE, 5000, TIM2_OCPOLARITY_HIGH);  // set duty to 50%
 393  018f 4b00          	push	#0
 394  0191 ae1388        	ldw	x,#5000
 395  0194 89            	pushw	x
 396  0195 ae6011        	ldw	x,#24593
 397  0198 cd0000        	call	_TIM2_OC2Init
 399  019b 5b03          	addw	sp,#3
 400                     ; 101   TIM2_OC2PreloadConfig(ENABLE);
 402  019d a601          	ld	a,#1
 403  019f cd0000        	call	_TIM2_OC2PreloadConfig
 405                     ; 102   TIM2_Cmd(ENABLE);
 407  01a2 a601          	ld	a,#1
 408  01a4 cd0000        	call	_TIM2_Cmd
 410                     ; 103   GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 412                     ; 104 }
 415  01a7               LC001:
 416  01a7 4be0          	push	#224
 417  01a9 4b08          	push	#8
 418  01ab ae500f        	ldw	x,#20495
 419  01ae cd0000        	call	_GPIO_Init
 421  01b1 85            	popw	x
 422  01b2 81            	ret	
 435                     	xdef	_Config
 436                     	xref	_UART1_ITConfig
 437                     	xref	_UART1_Cmd
 438                     	xref	_UART1_Init
 439                     	xref	_UART1_DeInit
 440                     	xref	_TIM4_ClearITPendingBit
 441                     	xref	_TIM4_ITConfig
 442                     	xref	_TIM4_Cmd
 443                     	xref	_TIM4_TimeBaseInit
 444                     	xref	_TIM4_DeInit
 445                     	xref	_TIM2_OC2PreloadConfig
 446                     	xref	_TIM2_Cmd
 447                     	xref	_TIM2_OC2Init
 448                     	xref	_TIM2_TimeBaseInit
 449                     	xref	_TIM2_DeInit
 450                     	xref	_TIM1_ClearITPendingBit
 451                     	xref	_TIM1_ITConfig
 452                     	xref	_TIM1_TimeBaseInit
 453                     	xref	_TIM1_DeInit
 454                     	xref	_GPIO_Init
 455                     	xref	_CLK_SYSCLKConfig
 456                     	xref	_CLK_PeripheralClockConfig
 457                     	xref	_CLK_DeInit
 476                     	end
