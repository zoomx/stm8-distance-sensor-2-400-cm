   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
  57                     ; 33 void delay_ms(u16 n_ms)
  57                     ; 34 {
  59                     .text:	section	.text,new
  60  0000               _delay_ms:
  62  0000 89            	pushw	x
  63       00000000      OFST:	set	0
  66                     ; 36   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
  68  0001 ae0501        	ldw	x,#1281
  69  0004 cd0000        	call	_CLK_PeripheralClockConfig
  71                     ; 39   TIM2->PSCR = 6;
  73  0007 3506530e      	mov	21262,#6
  74                     ; 42   TIM2->ARRH = 0;
  76  000b 725f530f      	clr	21263
  77                     ; 43   TIM2->ARRL = 250;
  79  000f 35fa5310      	mov	21264,#250
  80                     ; 47   TIM2->CNTRH = 0;
  82  0013 725f530c      	clr	21260
  83                     ; 48   TIM2->CNTRL = 2;
  85  0017 3502530d      	mov	21261,#2
  86                     ; 51   TIM2->SR1 &= ~0x01;
  88  001b 72115304      	bres	21252,#0
  89                     ; 54   TIM2->CR1 |= 0x01;
  91  001f 72105300      	bset	21248,#0
  93  0023 200b          	jra	L13
  94  0025               L73:
  95                     ; 58     while((TIM2->SR1 & 0x01) == 0) ;
  97  0025 c65304        	ld	a,21252
  98  0028 a501          	bcp	a,#1
  99  002a 27f9          	jreq	L73
 100                     ; 59     TIM2->SR1 &= ~0x01;
 102  002c 72115304      	bres	21252,#0
 103  0030               L13:
 104                     ; 56   while(n_ms--)
 106  0030 1e01          	ldw	x,(OFST+1,sp)
 107  0032 1d0001        	subw	x,#1
 108  0035 1f01          	ldw	(OFST+1,sp),x
 109  0037 1c0001        	addw	x,#1
 110  003a a30000        	cpw	x,#0
 111  003d 26e6          	jrne	L73
 112                     ; 63   TIM2->CR1 &= ~0x01;
 114  003f 72115300      	bres	21248,#0
 115                     ; 64   CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 117  0043 ae0500        	ldw	x,#1280
 118  0046 cd0000        	call	_CLK_PeripheralClockConfig
 120                     ; 65 }
 123  0049 85            	popw	x
 124  004a 81            	ret
 158                     ; 73 void delay_10us(u8 n_10us)
 158                     ; 74 {
 159                     .text:	section	.text,new
 160  0000               _delay_10us:
 162  0000 88            	push	a
 163       00000000      OFST:	set	0
 166                     ; 76   TIM2->CNTRH = 0;
 168  0001 725f530c      	clr	21260
 169                     ; 77   TIM2->CNTRL = 10;
 171  0005 350a530d      	mov	21261,#10
 172                     ; 80   TIM2->SR1 &= ~0x01;
 174  0009 72115304      	bres	21252,#0
 175                     ; 83   TIM2->CR1 |= 0x01;
 177  000d 72105300      	bset	21248,#0
 179  0011 200b          	jra	L36
 180  0013               L17:
 181                     ; 87     while((TIM2->SR1 & 0x01) == 0) ;
 183  0013 c65304        	ld	a,21252
 184  0016 a501          	bcp	a,#1
 185  0018 27f9          	jreq	L17
 186                     ; 88     TIM2->SR1 &= 0xFE;
 188  001a 72115304      	bres	21252,#0
 189  001e               L36:
 190                     ; 85   while(n_10us--)
 192  001e 7b01          	ld	a,(OFST+1,sp)
 193  0020 0a01          	dec	(OFST+1,sp)
 194  0022 4d            	tnz	a
 195  0023 26ee          	jrne	L17
 196                     ; 91   TIM2->CR1 &= 0xFE;
 198  0025 72115300      	bres	21248,#0
 199                     ; 92 }
 202  0029 84            	pop	a
 203  002a 81            	ret
 216                     	xdef	_delay_10us
 217                     	xdef	_delay_ms
 218                     	xref	_CLK_PeripheralClockConfig
 237                     	end
