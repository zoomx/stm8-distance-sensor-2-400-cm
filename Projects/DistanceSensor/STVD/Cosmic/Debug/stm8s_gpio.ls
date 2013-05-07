   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
 111                     ; 47 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 111                     ; 48 {
 113                     .text:	section	.text,new
 114  0000               _GPIO_DeInit:
 118                     ; 49     GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 120  0000 7f            	clr	(x)
 121                     ; 50     GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 123  0001 6f02          	clr	(2,x)
 124                     ; 51     GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 126  0003 6f03          	clr	(3,x)
 127                     ; 52     GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 129  0005 6f04          	clr	(4,x)
 130                     ; 53 }
 133  0007 81            	ret
 373                     ; 65 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 373                     ; 66 {
 374                     .text:	section	.text,new
 375  0000               _GPIO_Init:
 377  0000 89            	pushw	x
 378       00000000      OFST:	set	0
 381                     ; 71     assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 383                     ; 72     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 385                     ; 75   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 387  0001 7b05          	ld	a,(OFST+5,sp)
 388  0003 43            	cpl	a
 389  0004 e404          	and	a,(4,x)
 390  0006 e704          	ld	(4,x),a
 391                     ; 81     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 393  0008 7b06          	ld	a,(OFST+6,sp)
 394  000a a580          	bcp	a,#128
 395  000c 271d          	jreq	L771
 396                     ; 83         if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 398  000e 7b06          	ld	a,(OFST+6,sp)
 399  0010 a510          	bcp	a,#16
 400  0012 2706          	jreq	L102
 401                     ; 85             GPIOx->ODR |= (uint8_t)GPIO_Pin;
 403  0014 f6            	ld	a,(x)
 404  0015 1a05          	or	a,(OFST+5,sp)
 405  0017 f7            	ld	(x),a
 407  0018 2007          	jra	L302
 408  001a               L102:
 409                     ; 89             GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 411  001a 1e01          	ldw	x,(OFST+1,sp)
 412  001c 7b05          	ld	a,(OFST+5,sp)
 413  001e 43            	cpl	a
 414  001f f4            	and	a,(x)
 415  0020 f7            	ld	(x),a
 416  0021               L302:
 417                     ; 92         GPIOx->DDR |= (uint8_t)GPIO_Pin;
 419  0021 1e01          	ldw	x,(OFST+1,sp)
 420  0023 e602          	ld	a,(2,x)
 421  0025 1a05          	or	a,(OFST+5,sp)
 422  0027 e702          	ld	(2,x),a
 424  0029 2009          	jra	L502
 425  002b               L771:
 426                     ; 97         GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 428  002b 1e01          	ldw	x,(OFST+1,sp)
 429  002d 7b05          	ld	a,(OFST+5,sp)
 430  002f 43            	cpl	a
 431  0030 e402          	and	a,(2,x)
 432  0032 e702          	ld	(2,x),a
 433  0034               L502:
 434                     ; 104     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 436  0034 7b06          	ld	a,(OFST+6,sp)
 437  0036 a540          	bcp	a,#64
 438  0038 270a          	jreq	L702
 439                     ; 106         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 441  003a 1e01          	ldw	x,(OFST+1,sp)
 442  003c e603          	ld	a,(3,x)
 443  003e 1a05          	or	a,(OFST+5,sp)
 444  0040 e703          	ld	(3,x),a
 446  0042 2009          	jra	L112
 447  0044               L702:
 448                     ; 110         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 450  0044 1e01          	ldw	x,(OFST+1,sp)
 451  0046 7b05          	ld	a,(OFST+5,sp)
 452  0048 43            	cpl	a
 453  0049 e403          	and	a,(3,x)
 454  004b e703          	ld	(3,x),a
 455  004d               L112:
 456                     ; 117     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 458  004d 7b06          	ld	a,(OFST+6,sp)
 459  004f a520          	bcp	a,#32
 460  0051 270a          	jreq	L312
 461                     ; 119         GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 463  0053 1e01          	ldw	x,(OFST+1,sp)
 464  0055 e604          	ld	a,(4,x)
 465  0057 1a05          	or	a,(OFST+5,sp)
 466  0059 e704          	ld	(4,x),a
 468  005b 2009          	jra	L512
 469  005d               L312:
 470                     ; 123         GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 472  005d 1e01          	ldw	x,(OFST+1,sp)
 473  005f 7b05          	ld	a,(OFST+5,sp)
 474  0061 43            	cpl	a
 475  0062 e404          	and	a,(4,x)
 476  0064 e704          	ld	(4,x),a
 477  0066               L512:
 478                     ; 125 }
 481  0066 85            	popw	x
 482  0067 81            	ret
 528                     ; 135 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 528                     ; 136 {
 529                     .text:	section	.text,new
 530  0000               _GPIO_Write:
 532  0000 89            	pushw	x
 533       00000000      OFST:	set	0
 536                     ; 137     GPIOx->ODR = PortVal;
 538  0001 7b05          	ld	a,(OFST+5,sp)
 539  0003 1e01          	ldw	x,(OFST+1,sp)
 540  0005 f7            	ld	(x),a
 541                     ; 138 }
 544  0006 85            	popw	x
 545  0007 81            	ret
 592                     ; 148 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 592                     ; 149 {
 593                     .text:	section	.text,new
 594  0000               _GPIO_WriteHigh:
 596  0000 89            	pushw	x
 597       00000000      OFST:	set	0
 600                     ; 150     GPIOx->ODR |= (uint8_t)PortPins;
 602  0001 f6            	ld	a,(x)
 603  0002 1a05          	or	a,(OFST+5,sp)
 604  0004 f7            	ld	(x),a
 605                     ; 151 }
 608  0005 85            	popw	x
 609  0006 81            	ret
 656                     ; 161 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 656                     ; 162 {
 657                     .text:	section	.text,new
 658  0000               _GPIO_WriteLow:
 660  0000 89            	pushw	x
 661       00000000      OFST:	set	0
 664                     ; 163     GPIOx->ODR &= (uint8_t)(~PortPins);
 666  0001 7b05          	ld	a,(OFST+5,sp)
 667  0003 43            	cpl	a
 668  0004 f4            	and	a,(x)
 669  0005 f7            	ld	(x),a
 670                     ; 164 }
 673  0006 85            	popw	x
 674  0007 81            	ret
 721                     ; 174 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 721                     ; 175 {
 722                     .text:	section	.text,new
 723  0000               _GPIO_WriteReverse:
 725  0000 89            	pushw	x
 726       00000000      OFST:	set	0
 729                     ; 176     GPIOx->ODR ^= (uint8_t)PortPins;
 731  0001 f6            	ld	a,(x)
 732  0002 1805          	xor	a,	(OFST+5,sp)
 733  0004 f7            	ld	(x),a
 734                     ; 177 }
 737  0005 85            	popw	x
 738  0006 81            	ret
 776                     ; 185 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 776                     ; 186 {
 777                     .text:	section	.text,new
 778  0000               _GPIO_ReadOutputData:
 782                     ; 187     return ((uint8_t)GPIOx->ODR);
 784  0000 f6            	ld	a,(x)
 787  0001 81            	ret
 824                     ; 196 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 824                     ; 197 {
 825                     .text:	section	.text,new
 826  0000               _GPIO_ReadInputData:
 830                     ; 198     return ((uint8_t)GPIOx->IDR);
 832  0000 e601          	ld	a,(1,x)
 835  0002 81            	ret
 903                     ; 207 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 903                     ; 208 {
 904                     .text:	section	.text,new
 905  0000               _GPIO_ReadInputPin:
 907  0000 89            	pushw	x
 908       00000000      OFST:	set	0
 911                     ; 209     return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
 913  0001 e601          	ld	a,(1,x)
 914  0003 1405          	and	a,(OFST+5,sp)
 917  0005 85            	popw	x
 918  0006 81            	ret
 996                     ; 219 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
 996                     ; 220 {
 997                     .text:	section	.text,new
 998  0000               _GPIO_ExternalPullUpConfig:
1000  0000 89            	pushw	x
1001       00000000      OFST:	set	0
1004                     ; 222     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
1006                     ; 223     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1008                     ; 225     if (NewState != DISABLE) /* External Pull-Up Set*/
1010  0001 0d06          	tnz	(OFST+6,sp)
1011  0003 2708          	jreq	L374
1012                     ; 227         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
1014  0005 e603          	ld	a,(3,x)
1015  0007 1a05          	or	a,(OFST+5,sp)
1016  0009 e703          	ld	(3,x),a
1018  000b 2009          	jra	L574
1019  000d               L374:
1020                     ; 230         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
1022  000d 1e01          	ldw	x,(OFST+1,sp)
1023  000f 7b05          	ld	a,(OFST+5,sp)
1024  0011 43            	cpl	a
1025  0012 e403          	and	a,(3,x)
1026  0014 e703          	ld	(3,x),a
1027  0016               L574:
1028                     ; 232 }
1031  0016 85            	popw	x
1032  0017 81            	ret
1045                     	xdef	_GPIO_ExternalPullUpConfig
1046                     	xdef	_GPIO_ReadInputPin
1047                     	xdef	_GPIO_ReadOutputData
1048                     	xdef	_GPIO_ReadInputData
1049                     	xdef	_GPIO_WriteReverse
1050                     	xdef	_GPIO_WriteLow
1051                     	xdef	_GPIO_WriteHigh
1052                     	xdef	_GPIO_Write
1053                     	xdef	_GPIO_Init
1054                     	xdef	_GPIO_DeInit
1073                     	end
