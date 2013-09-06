   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  62                     ; 11 void delay_ms(u16 n_ms)
  62                     ; 12 {
  64                     .text:	section	.text,new
  65  0000               _delay_ms:
  67  0000 89            	pushw	x
  68       00000000      OFST:	set	0
  71                     ; 14   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
  73  0001 ae0501        	ldw	x,#1281
  74  0004 cd0000        	call	_CLK_PeripheralClockConfig
  76                     ; 17   TIM2->PSCR = 6;
  78  0007 3506530e      	mov	21262,#6
  79                     ; 20   TIM2->ARRH = 0;
  81  000b 725f530f      	clr	21263
  82                     ; 21   TIM2->ARRL = 250;
  84  000f 35fa5310      	mov	21264,#250
  85                     ; 25   TIM2->CNTRH = 0;
  87  0013 725f530c      	clr	21260
  88                     ; 26   TIM2->CNTRL = 2;
  90  0017 3502530d      	mov	21261,#2
  91                     ; 29   TIM2->SR1 &= (u8)(~0x01);
  93  001b 72115304      	bres	21252,#0
  94                     ; 32   TIM2->CR1 |= 0x01;
  96  001f 72105300      	bset	21248,#0
  98  0023 2009          	jra	L13
  99  0025               L73:
 100                     ; 36     while((TIM2->SR1 & 0x01) == 0) ;
 102  0025 72015304fb    	btjf	21252,#0,L73
 103                     ; 37     TIM2->SR1 &= (u8)(~0x01);
 105  002a 72115304      	bres	21252,#0
 106  002e               L13:
 107                     ; 34   while(n_ms--)
 109  002e 1e01          	ldw	x,(OFST+1,sp)
 110  0030 5a            	decw	x
 111  0031 1f01          	ldw	(OFST+1,sp),x
 112  0033 5c            	incw	x
 113  0034 26ef          	jrne	L73
 114                     ; 41   TIM2->CR1 &= (u8)(~0x01);
 116  0036 72115300      	bres	21248,#0
 117                     ; 42   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 119  003a ae0500        	ldw	x,#1280
 120  003d cd0000        	call	_CLK_PeripheralClockConfig
 122                     ; 43 }
 125  0040 85            	popw	x
 126  0041 81            	ret	
 160                     ; 51 void delay_10us(u8 n_10us)
 160                     ; 52 {
 161                     .text:	section	.text,new
 162  0000               _delay_10us:
 164  0000 88            	push	a
 165       00000000      OFST:	set	0
 168                     ; 54   TIM2->CNTRH = 0;
 170  0001 725f530c      	clr	21260
 171                     ; 55   TIM2->CNTRL = 10;
 173  0005 350a530d      	mov	21261,#10
 174                     ; 58   TIM2->SR1 &= (u8)(~0x01);
 176  0009 72115304      	bres	21252,#0
 177                     ; 61   TIM2->CR1 |= 0x01;
 179  000d 72105300      	bset	21248,#0
 181  0011 2009          	jra	L36
 182  0013               L17:
 183                     ; 65     while((TIM2->SR1 & 0x01) == 0) ;
 185  0013 72015304fb    	btjf	21252,#0,L17
 186                     ; 66     TIM2->SR1 &= 0xFE;
 188  0018 72115304      	bres	21252,#0
 189  001c               L36:
 190                     ; 63   while(n_10us--)
 192  001c 7b01          	ld	a,(OFST+1,sp)
 193  001e 0a01          	dec	(OFST+1,sp)
 194  0020 4d            	tnz	a
 195  0021 26f0          	jrne	L17
 196                     ; 69   TIM2->CR1 &= 0xFE;
 198  0023 72115300      	bres	21248,#0
 199                     ; 70 }
 202  0027 84            	pop	a
 203  0028 81            	ret	
 216                     	xdef	_delay_10us
 217                     	xdef	_delay_ms
 218                     	xref	_CLK_PeripheralClockConfig
 237                     	end
