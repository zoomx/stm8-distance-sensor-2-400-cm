   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
  59                     ; 5 void Config()
  59                     ; 6 {
  61                     .text:	section	.text,new
  62  0000               _Config:
  66                     ; 8   CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);
  68  0000 4f            	clr	a
  69  0001 cd0000        	call	_CLK_SYSCLKConfig
  71                     ; 11   CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, ENABLE);
  73  0004 ae0101        	ldw	x,#257
  74  0007 cd0000        	call	_CLK_PeripheralClockConfig
  76                     ; 12   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);   /* 8bit: for implementing delays */
  78  000a ae0401        	ldw	x,#1025
  79  000d cd0000        	call	_CLK_PeripheralClockConfig
  81                     ; 13   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, ENABLE);   /* 16bit: for capture of ultrasonic distance pulse width */
  83  0010 ae0701        	ldw	x,#1793
  84  0013 cd0000        	call	_CLK_PeripheralClockConfig
  86                     ; 17   GPIO_Init(GPIOD, GPIO_PIN_0, GPIO_MODE_OUT_OD_HIZ_SLOW);
  88  0016 4b90          	push	#144
  89  0018 4b01          	push	#1
  90  001a ae500f        	ldw	x,#20495
  91  001d cd0000        	call	_GPIO_Init
  93  0020 85            	popw	x
  94                     ; 20   GPIO_Init(GPIOD, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);
  96  0021 4be0          	push	#224
  97  0023 4b02          	push	#2
  98  0025 ae500f        	ldw	x,#20495
  99  0028 cd0000        	call	_GPIO_Init
 101  002b 85            	popw	x
 102                     ; 23   GPIO_Init(ONEWIREBUS_PORT, ONEWIREBUS_PIN, GPIO_MODE_OUT_OD_HIZ_FAST);
 104  002c 4bb0          	push	#176
 105  002e 4b40          	push	#64
 106  0030 ae5005        	ldw	x,#20485
 107  0033 cd0000        	call	_GPIO_Init
 109  0036 85            	popw	x
 110                     ; 26   GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST);
 112  0037 4be0          	push	#224
 113  0039 4b01          	push	#1
 114  003b ae5005        	ldw	x,#20485
 115  003e cd0000        	call	_GPIO_Init
 117  0041 85            	popw	x
 118                     ; 27   GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);
 120  0042 4be0          	push	#224
 121  0044 4b02          	push	#2
 122  0046 ae5005        	ldw	x,#20485
 123  0049 cd0000        	call	_GPIO_Init
 125  004c 85            	popw	x
 126                     ; 28   GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);    
 128  004d 4b00          	push	#0
 129  004f 4b04          	push	#4
 130  0051 ae5005        	ldw	x,#20485
 131  0054 cd0000        	call	_GPIO_Init
 133  0057 85            	popw	x
 134                     ; 29   GPIO_Init(GPIOB, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 136  0058 4be0          	push	#224
 137  005a 4b08          	push	#8
 138  005c ae5005        	ldw	x,#20485
 139  005f cd0000        	call	_GPIO_Init
 141  0062 85            	popw	x
 142                     ; 30   GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
 144  0063 4be0          	push	#224
 145  0065 4b10          	push	#16
 146  0067 ae5005        	ldw	x,#20485
 147  006a cd0000        	call	_GPIO_Init
 149  006d 85            	popw	x
 150                     ; 34   GPIO_Init(GPIOC, GPIO_PIN_7, GPIO_MODE_OUT_PP_LOW_FAST);
 152  006e 4be0          	push	#224
 153  0070 4b80          	push	#128
 154  0072 ae500a        	ldw	x,#20490
 155  0075 cd0000        	call	_GPIO_Init
 157  0078 85            	popw	x
 158                     ; 35   GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);
 160  0079 4b40          	push	#64
 161  007b 4b04          	push	#4
 162  007d ae500a        	ldw	x,#20490
 163  0080 cd0000        	call	_GPIO_Init
 165  0083 85            	popw	x
 166                     ; 36   GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
 168  0084 4b40          	push	#64
 169  0086 4b08          	push	#8
 170  0088 ae500a        	ldw	x,#20490
 171  008b cd0000        	call	_GPIO_Init
 173  008e 85            	popw	x
 174                     ; 39   TIM4_DeInit();
 176  008f cd0000        	call	_TIM4_DeInit
 178                     ; 40   TIM4_TimeBaseInit(TIM4_PRESCALER_128, 250);                 /* 2MS overflow interval - 500Hz*/
 180  0092 ae07fa        	ldw	x,#2042
 181  0095 cd0000        	call	_TIM4_TimeBaseInit
 183                     ; 41   TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
 185  0098 ae0101        	ldw	x,#257
 186  009b cd0000        	call	_TIM4_ITConfig
 188                     ; 42   TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 190  009e a601          	ld	a,#1
 191  00a0 cd0000        	call	_TIM4_ClearITPendingBit
 193                     ; 43   TIM4_Cmd(ENABLE);
 195  00a3 a601          	ld	a,#1
 196  00a5 cd0000        	call	_TIM4_Cmd
 198                     ; 46   TIM1_DeInit();
 200  00a8 cd0000        	call	_TIM1_DeInit
 202                     ; 47   TIM1_TimeBaseInit(16, TIM1_COUNTERMODE_UP, 65535, 0x00);     /* 65.536ms overflow period */
 204  00ab 4b00          	push	#0
 205  00ad aeffff        	ldw	x,#65535
 206  00b0 89            	pushw	x
 207  00b1 4b00          	push	#0
 208  00b3 ae0010        	ldw	x,#16
 209  00b6 cd0000        	call	_TIM1_TimeBaseInit
 211  00b9 5b04          	addw	sp,#4
 212                     ; 48   TIM1_ICInit(TIM1_CHANNEL_2, TIM1_ICPOLARITY_RISING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00);    /* PC2 */
 214  00bb 4b00          	push	#0
 215  00bd 4b00          	push	#0
 216  00bf 4b01          	push	#1
 217  00c1 ae0100        	ldw	x,#256
 218  00c4 cd0000        	call	_TIM1_ICInit
 220  00c7 5b03          	addw	sp,#3
 221                     ; 49   TIM1_ICInit(TIM1_CHANNEL_3, TIM1_ICPOLARITY_FALLING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV1, 0x00);     /* PC3 */
 223  00c9 4b00          	push	#0
 224  00cb 4b00          	push	#0
 225  00cd 4b01          	push	#1
 226  00cf ae0201        	ldw	x,#513
 227  00d2 cd0000        	call	_TIM1_ICInit
 229  00d5 5b03          	addw	sp,#3
 230                     ; 50   TIM1_ITConfig(TIM1_IT_CC3, ENABLE);            /* interrupt on timer capture compare 3 - falling edge of pulse */
 232  00d7 ae0801        	ldw	x,#2049
 233  00da cd0000        	call	_TIM1_ITConfig
 235                     ; 51   TIM1_ClearITPendingBit(TIM1_FLAG_CC3);
 237  00dd a608          	ld	a,#8
 238  00df cd0000        	call	_TIM1_ClearITPendingBit
 240                     ; 52   TIM1_ClearITPendingBit(TIM1_FLAG_CC2);
 242  00e2 a604          	ld	a,#4
 243  00e4 cd0000        	call	_TIM1_ClearITPendingBit
 245                     ; 53   TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
 247  00e7 a601          	ld	a,#1
 248  00e9 cd0000        	call	_TIM1_ClearITPendingBit
 250                     ; 54   TIM1_Cmd(ENABLE);
 252  00ec a601          	ld	a,#1
 253  00ee cd0000        	call	_TIM1_Cmd
 255                     ; 55 }
 258  00f1 81            	ret
 271                     	xdef	_Config
 272                     	xref	_TIM4_ClearITPendingBit
 273                     	xref	_TIM4_ITConfig
 274                     	xref	_TIM4_Cmd
 275                     	xref	_TIM4_TimeBaseInit
 276                     	xref	_TIM4_DeInit
 277                     	xref	_TIM1_ClearITPendingBit
 278                     	xref	_TIM1_ITConfig
 279                     	xref	_TIM1_Cmd
 280                     	xref	_TIM1_ICInit
 281                     	xref	_TIM1_TimeBaseInit
 282                     	xref	_TIM1_DeInit
 283                     	xref	_GPIO_Init
 284                     	xref	_CLK_SYSCLKConfig
 285                     	xref	_CLK_PeripheralClockConfig
 304                     	end
