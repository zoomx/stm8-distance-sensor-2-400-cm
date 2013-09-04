   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  60                     ; 11 void delay_ms(u16 n_ms)
  60                     ; 12 {
  62                     .text:	section	.text,new
  63  0000               _delay_ms:
  65  0000 89            	pushw	x
  66       00000000      OFST:	set	0
  69                     ; 14   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
  71  0001 ae0501        	ldw	x,#1281
  72  0004 cd0000        	call	_CLK_PeripheralClockConfig
  74                     ; 17   TIM2->PSCR = 6;
  76  0007 3506530e      	mov	21262,#6
  77                     ; 20   TIM2->ARRH = 0;
  79  000b 725f530f      	clr	21263
  80                     ; 21   TIM2->ARRL = 250;
  82  000f 35fa5310      	mov	21264,#250
  83                     ; 25   TIM2->CNTRH = 0;
  85  0013 725f530c      	clr	21260
  86                     ; 26   TIM2->CNTRL = 2;
  88  0017 3502530d      	mov	21261,#2
  89                     ; 29   TIM2->SR1 &= (u8)(~0x01);
  91  001b 72115304      	bres	21252,#0
  92                     ; 32   TIM2->CR1 |= 0x01;
  94  001f 72105300      	bset	21248,#0
  96  0023 2009          	jra	L13
  97  0025               L73:
  98                     ; 36     while((TIM2->SR1 & 0x01) == 0) ;
 100  0025 72015304fb    	btjf	21252,#0,L73
 101                     ; 37     TIM2->SR1 &= (u8)(~0x01);
 103  002a 72115304      	bres	21252,#0
 104  002e               L13:
 105                     ; 34   while(n_ms--)
 107  002e 1e01          	ldw	x,(OFST+1,sp)
 108  0030 5a            	decw	x
 109  0031 1f01          	ldw	(OFST+1,sp),x
 110  0033 5c            	incw	x
 111  0034 26ef          	jrne	L73
 112                     ; 41   TIM2->CR1 &= (u8)(~0x01);
 114  0036 72115300      	bres	21248,#0
 115                     ; 42   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 117  003a ae0500        	ldw	x,#1280
 118  003d cd0000        	call	_CLK_PeripheralClockConfig
 120                     ; 43 }
 123  0040 85            	popw	x
 124  0041 81            	ret	
 158                     ; 51 void delay_10us(u8 n_10us)
 158                     ; 52 {
 159                     .text:	section	.text,new
 160  0000               _delay_10us:
 162  0000 88            	push	a
 163       00000000      OFST:	set	0
 166                     ; 54   TIM2->CNTRH = 0;
 168  0001 725f530c      	clr	21260
 169                     ; 55   TIM2->CNTRL = 10;
 171  0005 350a530d      	mov	21261,#10
 172                     ; 58   TIM2->SR1 &= (u8)(~0x01);
 174  0009 72115304      	bres	21252,#0
 175                     ; 61   TIM2->CR1 |= 0x01;
 177  000d 72105300      	bset	21248,#0
 179  0011 2009          	jra	L36
 180  0013               L17:
 181                     ; 65     while((TIM2->SR1 & 0x01) == 0) ;
 183  0013 72015304fb    	btjf	21252,#0,L17
 184                     ; 66     TIM2->SR1 &= 0xFE;
 186  0018 72115304      	bres	21252,#0
 187  001c               L36:
 188                     ; 63   while(n_10us--)
 190  001c 7b01          	ld	a,(OFST+1,sp)
 191  001e 0a01          	dec	(OFST+1,sp)
 192  0020 4d            	tnz	a
 193  0021 26f0          	jrne	L17
 194                     ; 69   TIM2->CR1 &= 0xFE;
 196  0023 72115300      	bres	21248,#0
 197                     ; 70 }
 200  0027 84            	pop	a
 201  0028 81            	ret	
 214                     	xdef	_delay_10us
 215                     	xdef	_delay_ms
 216                     	xref	_CLK_PeripheralClockConfig
 235                     	end
