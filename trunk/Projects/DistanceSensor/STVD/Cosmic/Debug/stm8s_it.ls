   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
  17                     	bsct
  18  0000               _delay_cnt_100ms:
  19  0000 00            	dc.b	0
  20  0001               _delay_100ms_flag:
  21  0001 00            	dc.b	0
  22  0002               _delay_cnt_1s:
  23  0002 0000          	dc.w	0
  24  0004               _delay_1s_flag:
  25  0004 00            	dc.b	0
  26  0005               _delay_cnt_50ms:
  27  0005 00            	dc.b	0
  28  0006               _delay_50ms_flag:
  29  0006 00            	dc.b	0
  30  0007               _CAPTURE_new_mes:
  31  0007 00            	dc.b	0
  32  0008               _CAPTURE_delta:
  33  0008 00000000      	dc.l	0
  63                     ; 67 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  63                     ; 68 {
  64                     .text:	section	.text,new
  65  0000               f_NonHandledInterrupt:
  69                     ; 72 }
  72  0000 80            	iret
  94                     ; 80 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  94                     ; 81 {
  95                     .text:	section	.text,new
  96  0000               f_TRAP_IRQHandler:
 100                     ; 85 }
 103  0000 80            	iret
 125                     ; 92 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 125                     ; 93 
 125                     ; 94 {
 126                     .text:	section	.text,new
 127  0000               f_TLI_IRQHandler:
 131                     ; 98 }
 134  0000 80            	iret
 156                     ; 105 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 156                     ; 106 {
 157                     .text:	section	.text,new
 158  0000               f_AWU_IRQHandler:
 162                     ; 110 }
 165  0000 80            	iret
 187                     ; 117 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 187                     ; 118 {
 188                     .text:	section	.text,new
 189  0000               f_CLK_IRQHandler:
 193                     ; 122 }
 196  0000 80            	iret
 219                     ; 129 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 219                     ; 130 {
 220                     .text:	section	.text,new
 221  0000               f_EXTI_PORTA_IRQHandler:
 225                     ; 134 }
 228  0000 80            	iret
 251                     ; 141 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 251                     ; 142 {
 252                     .text:	section	.text,new
 253  0000               f_EXTI_PORTB_IRQHandler:
 257                     ; 146 }
 260  0000 80            	iret
 283                     ; 153 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 283                     ; 154 {
 284                     .text:	section	.text,new
 285  0000               f_EXTI_PORTC_IRQHandler:
 289                     ; 158 }
 292  0000 80            	iret
 315                     ; 165 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 315                     ; 166 {
 316                     .text:	section	.text,new
 317  0000               f_EXTI_PORTD_IRQHandler:
 321                     ; 170 }
 324  0000 80            	iret
 347                     ; 177 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 347                     ; 178 {
 348                     .text:	section	.text,new
 349  0000               f_EXTI_PORTE_IRQHandler:
 353                     ; 182 }
 356  0000 80            	iret
 378                     ; 229 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 378                     ; 230 {
 379                     .text:	section	.text,new
 380  0000               f_SPI_IRQHandler:
 384                     ; 234 }
 387  0000 80            	iret
 411                     ; 241 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 411                     ; 242 {
 412                     .text:	section	.text,new
 413  0000               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 415  0000 8a            	push	cc
 416  0001 84            	pop	a
 417  0002 a4bf          	and	a,#191
 418  0004 88            	push	a
 419  0005 86            	pop	cc
 420  0006 3b0002        	push	c_x+2
 421  0009 be00          	ldw	x,c_x
 422  000b 89            	pushw	x
 423  000c 3b0002        	push	c_y+2
 424  000f be00          	ldw	x,c_y
 425  0011 89            	pushw	x
 428                     ; 247   if(DEBUG_PIN_STATE)
 430  0012 c65010        	ld	a,20496
 431  0015 a502          	bcp	a,#2
 432  0017 2706          	jreq	L151
 433                     ; 248     DEBUG_PIN_OFF;
 435  0019 7213500f      	bres	20495,#1
 437  001d 2004          	jra	L351
 438  001f               L151:
 439                     ; 249   else DEBUG_PIN_ON;
 441  001f 7212500f      	bset	20495,#1
 442  0023               L351:
 443                     ; 250   TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
 445  0023 a601          	ld	a,#1
 446  0025 cd0000        	call	_TIM1_ClearITPendingBit
 448                     ; 251 }
 451  0028 85            	popw	x
 452  0029 bf00          	ldw	c_y,x
 453  002b 320002        	pop	c_y+2
 454  002e 85            	popw	x
 455  002f bf00          	ldw	c_x,x
 456  0031 320002        	pop	c_x+2
 457  0034 80            	iret
 499                     ; 258 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 499                     ; 259 {
 500                     .text:	section	.text,new
 501  0000               f_TIM1_CAP_COM_IRQHandler:
 503       00000009      OFST:	set	9
 504  0000 be02          	ldw	x,c_lreg+2
 505  0002 89            	pushw	x
 506  0003 be00          	ldw	x,c_lreg
 507  0005 89            	pushw	x
 508  0006 5209          	subw	sp,#9
 511                     ; 263   u8 tim1_cc2_flag = FALSE;
 513  0008 0f09          	clr	(OFST+0,sp)
 514                     ; 264   if(TIM1->SR1 & TIM1_IT_CC2)
 516  000a c65255        	ld	a,21077
 517  000d a504          	bcp	a,#4
 518  000f 2708          	jreq	L371
 519                     ; 266     tim1_cc2_flag = TRUE;
 521  0011 a601          	ld	a,#1
 522  0013 6b09          	ld	(OFST+0,sp),a
 523                     ; 267     TIM1->SR1 = (u8)(~(u8)TIM1_IT_CC2);     /* clear TIM1 CC2 interrupt flag */
 525  0015 35fb5255      	mov	21077,#251
 526  0019               L371:
 527                     ; 269   if(TIM1->SR1 & TIM1_IT_CC3 && tim1_cc2_flag && CAPTURE_new_mes == FALSE)
 529  0019 c65255        	ld	a,21077
 530  001c a508          	bcp	a,#8
 531  001e 2604          	jrne	L63
 532  0020 aceb00eb      	jpf	L571
 533  0024               L63:
 535  0024 0d09          	tnz	(OFST+0,sp)
 536  0026 2604          	jrne	L04
 537  0028 aceb00eb      	jpf	L571
 538  002c               L04:
 540  002c 3d07          	tnz	_CAPTURE_new_mes
 541  002e 2704          	jreq	L24
 542  0030 aceb00eb      	jpf	L571
 543  0034               L24:
 544                     ; 271     tmpccr3h = TIM1->CCR3H;
 546  0034 5552690007    	mov	_tmpccr3h,21097
 547                     ; 272     tmpccr3l = TIM1->CCR3L;
 549  0039 55526a0006    	mov	_tmpccr3l,21098
 550                     ; 273     tmpccr3 = (u16)(tmpccr3l);
 552  003e b606          	ld	a,_tmpccr3l
 553  0040 5f            	clrw	x
 554  0041 97            	ld	xl,a
 555  0042 bf04          	ldw	_tmpccr3,x
 556                     ; 274     tmpccr3 |= (u16)((u16)tmpccr3h << 8);
 558  0044 b607          	ld	a,_tmpccr3h
 559  0046 5f            	clrw	x
 560  0047 97            	ld	xl,a
 561  0048 4f            	clr	a
 562  0049 02            	rlwa	x,a
 563  004a 01            	rrwa	x,a
 564  004b ba05          	or	a,_tmpccr3+1
 565  004d 01            	rrwa	x,a
 566  004e ba04          	or	a,_tmpccr3
 567  0050 01            	rrwa	x,a
 568  0051 bf04          	ldw	_tmpccr3,x
 569                     ; 275     tmpccr2h = TIM1->CCR2H;
 571  0053 5552670003    	mov	_tmpccr2h,21095
 572                     ; 276     tmpccr2l = TIM1->CCR2L;
 574  0058 5552680002    	mov	_tmpccr2l,21096
 575                     ; 277     tmpccr2 = (u16)(tmpccr2l);
 577  005d b602          	ld	a,_tmpccr2l
 578  005f 5f            	clrw	x
 579  0060 97            	ld	xl,a
 580  0061 bf00          	ldw	_tmpccr2,x
 581                     ; 278     tmpccr2 |= (u16)((u16)tmpccr2h << 8);
 583  0063 b603          	ld	a,_tmpccr2h
 584  0065 5f            	clrw	x
 585  0066 97            	ld	xl,a
 586  0067 4f            	clr	a
 587  0068 02            	rlwa	x,a
 588  0069 01            	rrwa	x,a
 589  006a ba01          	or	a,_tmpccr2+1
 590  006c 01            	rrwa	x,a
 591  006d ba00          	or	a,_tmpccr2
 592  006f 01            	rrwa	x,a
 593  0070 bf00          	ldw	_tmpccr2,x
 594                     ; 279     CAPTURE_delta = (s32)(tmpccr3) - (s32)(tmpccr2);
 596  0072 be00          	ldw	x,_tmpccr2
 597  0074 cd0000        	call	c_uitolx
 599  0077 96            	ldw	x,sp
 600  0078 1c0005        	addw	x,#OFST-4
 601  007b cd0000        	call	c_rtol
 603  007e be04          	ldw	x,_tmpccr3
 604  0080 cd0000        	call	c_uitolx
 606  0083 96            	ldw	x,sp
 607  0084 1c0005        	addw	x,#OFST-4
 608  0087 cd0000        	call	c_lsub
 610  008a ae0008        	ldw	x,#_CAPTURE_delta
 611  008d cd0000        	call	c_rtol
 613                     ; 280     if(CAPTURE_delta >= 0)
 615  0090 9c            	rvf
 616  0091 9c            	rvf
 617  0092 3d08          	tnz	_CAPTURE_delta
 618  0094 2f13          	jrslt	L771
 619                     ; 282      if(TIM1->SR1 & TIM1_IT_UPDATE)
 621  0096 c65255        	ld	a,21077
 622  0099 a501          	bcp	a,#1
 623  009b 2742          	jreq	L302
 624                     ; 284        CAPTURE_delta = CAPTURE_INVALID_MES;  /* invalid measurement value */
 626  009d ae0000        	ldw	x,#0
 627  00a0 bf0a          	ldw	_CAPTURE_delta+2,x
 628  00a2 ae0001        	ldw	x,#1
 629  00a5 bf08          	ldw	_CAPTURE_delta,x
 630  00a7 2036          	jra	L302
 631  00a9               L771:
 632                     ; 289       CAPTURE_delta = (s32)(65536 - tmpccr2 + tmpccr3); 
 634  00a9 be04          	ldw	x,_tmpccr3
 635  00ab cd0000        	call	c_uitolx
 637  00ae 96            	ldw	x,sp
 638  00af 1c0005        	addw	x,#OFST-4
 639  00b2 cd0000        	call	c_rtol
 641  00b5 be00          	ldw	x,_tmpccr2
 642  00b7 cd0000        	call	c_uitolx
 644  00ba 96            	ldw	x,sp
 645  00bb 1c0001        	addw	x,#OFST-8
 646  00be cd0000        	call	c_rtol
 648  00c1 ae0000        	ldw	x,#0
 649  00c4 bf02          	ldw	c_lreg+2,x
 650  00c6 ae0001        	ldw	x,#1
 651  00c9 bf00          	ldw	c_lreg,x
 652  00cb 96            	ldw	x,sp
 653  00cc 1c0001        	addw	x,#OFST-8
 654  00cf cd0000        	call	c_lsub
 656  00d2 96            	ldw	x,sp
 657  00d3 1c0005        	addw	x,#OFST-4
 658  00d6 cd0000        	call	c_ladd
 660  00d9 ae0008        	ldw	x,#_CAPTURE_delta
 661  00dc cd0000        	call	c_rtol
 663  00df               L302:
 664                     ; 291     CAPTURE_new_mes = TRUE;        /* new distance measurement value */
 666  00df 35010007      	mov	_CAPTURE_new_mes,#1
 667                     ; 292     tim1_cc2_flag = FALSE;
 669                     ; 293     TIM1->SR1 = (u8)(~(u8)TIM1_IT_CC3);     /* clear TIM1 CC3 interrupt flag */
 671  00e3 35f75255      	mov	21077,#247
 672                     ; 294     TIM1->SR1 = (u8)(~(u8)TIM1_IT_UPDATE);  /* clear TIM1 UPDATE interrupt flag */
 674  00e7 35fe5255      	mov	21077,#254
 675  00eb               L571:
 676                     ; 296   TIM1->SR1 = (u8)(~(u8)TIM1_IT_CC3);     /* clear TIM1 CC3 interrupt flag */
 678  00eb 35f75255      	mov	21077,#247
 679                     ; 297 }
 682  00ef 5b09          	addw	sp,#9
 683  00f1 85            	popw	x
 684  00f2 bf00          	ldw	c_lreg,x
 685  00f4 85            	popw	x
 686  00f5 bf02          	ldw	c_lreg+2,x
 687  00f7 80            	iret
 710                     ; 330 INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 710                     ; 331 {
 711                     .text:	section	.text,new
 712  0000               f_TIM2_UPD_OVF_BRK_IRQHandler:
 716                     ; 335 }
 719  0000 80            	iret
 742                     ; 342 INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 742                     ; 343 {
 743                     .text:	section	.text,new
 744  0000               f_TIM2_CAP_COM_IRQHandler:
 748                     ; 347 }
 751  0000 80            	iret
 774                     ; 384 INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 774                     ; 385 {
 775                     .text:	section	.text,new
 776  0000               f_UART1_TX_IRQHandler:
 780                     ; 389 }
 783  0000 80            	iret
 806                     ; 396 INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 806                     ; 397 {
 807                     .text:	section	.text,new
 808  0000               f_UART1_RX_IRQHandler:
 812                     ; 401 }
 815  0000 80            	iret
 837                     ; 409 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 837                     ; 410 {
 838                     .text:	section	.text,new
 839  0000               f_I2C_IRQHandler:
 843                     ; 414 }
 846  0000 80            	iret
 868                     ; 488 INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 868                     ; 489 {
 869                     .text:	section	.text,new
 870  0000               f_ADC1_IRQHandler:
 874                     ; 493 }
 877  0000 80            	iret
 907                     ; 514 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)     /* once every 2MS */
 907                     ; 515 {
 908                     .text:	section	.text,new
 909  0000               f_TIM4_UPD_OVF_IRQHandler:
 911  0000 8a            	push	cc
 912  0001 84            	pop	a
 913  0002 a4bf          	and	a,#191
 914  0004 88            	push	a
 915  0005 86            	pop	cc
 916  0006 3b0002        	push	c_x+2
 917  0009 be00          	ldw	x,c_x
 918  000b 89            	pushw	x
 919  000c 3b0002        	push	c_y+2
 920  000f be00          	ldw	x,c_y
 921  0011 89            	pushw	x
 924                     ; 531   if(delay_1s_flag == FALSE) delay_cnt_1s++;
 926  0012 3d04          	tnz	_delay_1s_flag
 927  0014 2607          	jrne	L572
 930  0016 be02          	ldw	x,_delay_cnt_1s
 931  0018 1c0001        	addw	x,#1
 932  001b bf02          	ldw	_delay_cnt_1s,x
 933  001d               L572:
 934                     ; 532   if(delay_cnt_1s == DELAY_CNT_1S)
 936  001d be02          	ldw	x,_delay_cnt_1s
 937  001f a301f4        	cpw	x,#500
 938  0022 2607          	jrne	L772
 939                     ; 534     delay_1s_flag = TRUE;
 941  0024 35010004      	mov	_delay_1s_flag,#1
 942                     ; 535     delay_cnt_1s = 0; 
 944  0028 5f            	clrw	x
 945  0029 bf02          	ldw	_delay_cnt_1s,x
 946  002b               L772:
 947                     ; 539   if(delay_100ms_flag == FALSE) delay_cnt_100ms++;
 949  002b 3d01          	tnz	_delay_100ms_flag
 950  002d 2602          	jrne	L103
 953  002f 3c00          	inc	_delay_cnt_100ms
 954  0031               L103:
 955                     ; 540   if(delay_cnt_100ms == DELAY_CNT_100MS)
 957  0031 b600          	ld	a,_delay_cnt_100ms
 958  0033 a132          	cp	a,#50
 959  0035 2606          	jrne	L303
 960                     ; 542     delay_100ms_flag = TRUE;
 962  0037 35010001      	mov	_delay_100ms_flag,#1
 963                     ; 543     delay_cnt_100ms = 0; 
 965  003b 3f00          	clr	_delay_cnt_100ms
 966  003d               L303:
 967                     ; 547   if(delay_50ms_flag == FALSE) delay_cnt_50ms++;
 969  003d 3d06          	tnz	_delay_50ms_flag
 970  003f 2602          	jrne	L503
 973  0041 3c05          	inc	_delay_cnt_50ms
 974  0043               L503:
 975                     ; 548   if(delay_cnt_50ms == DELAY_CNT_50MS)
 977  0043 b605          	ld	a,_delay_cnt_50ms
 978  0045 a119          	cp	a,#25
 979  0047 2606          	jrne	L703
 980                     ; 550     delay_50ms_flag = TRUE;
 982  0049 35010006      	mov	_delay_50ms_flag,#1
 983                     ; 551     delay_cnt_50ms = 0; 
 985  004d 3f05          	clr	_delay_cnt_50ms
 986  004f               L703:
 987                     ; 554   TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 989  004f a601          	ld	a,#1
 990  0051 cd0000        	call	_TIM4_ClearITPendingBit
 992                     ; 555 }
 995  0054 85            	popw	x
 996  0055 bf00          	ldw	c_y,x
 997  0057 320002        	pop	c_y+2
 998  005a 85            	popw	x
 999  005b bf00          	ldw	c_x,x
1000  005d 320002        	pop	c_x+2
1001  0060 80            	iret
1024                     ; 563 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1024                     ; 564 {
1025                     .text:	section	.text,new
1026  0000               f_EEPROM_EEC_IRQHandler:
1030                     ; 568 }
1033  0000 80            	iret
1173                     	switch	.ubsct
1174  0000               _tmpccr2:
1175  0000 0000          	ds.b	2
1176                     	xdef	_tmpccr2
1177  0002               _tmpccr2l:
1178  0002 00            	ds.b	1
1179                     	xdef	_tmpccr2l
1180  0003               _tmpccr2h:
1181  0003 00            	ds.b	1
1182                     	xdef	_tmpccr2h
1183  0004               _tmpccr3:
1184  0004 0000          	ds.b	2
1185                     	xdef	_tmpccr3
1186  0006               _tmpccr3l:
1187  0006 00            	ds.b	1
1188                     	xdef	_tmpccr3l
1189  0007               _tmpccr3h:
1190  0007 00            	ds.b	1
1191                     	xdef	_tmpccr3h
1192                     	xdef	_delay_cnt_50ms
1193                     	xdef	_delay_cnt_1s
1194                     	xdef	_delay_cnt_100ms
1195                     	xdef	f_EEPROM_EEC_IRQHandler
1196                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1197                     	xdef	f_ADC1_IRQHandler
1198                     	xdef	f_I2C_IRQHandler
1199                     	xdef	f_UART1_RX_IRQHandler
1200                     	xdef	f_UART1_TX_IRQHandler
1201                     	xdef	f_TIM2_CAP_COM_IRQHandler
1202                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1203                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1204                     	xdef	f_TIM1_CAP_COM_IRQHandler
1205                     	xdef	f_SPI_IRQHandler
1206                     	xdef	f_EXTI_PORTE_IRQHandler
1207                     	xdef	f_EXTI_PORTD_IRQHandler
1208                     	xdef	f_EXTI_PORTC_IRQHandler
1209                     	xdef	f_EXTI_PORTB_IRQHandler
1210                     	xdef	f_EXTI_PORTA_IRQHandler
1211                     	xdef	f_CLK_IRQHandler
1212                     	xdef	f_AWU_IRQHandler
1213                     	xdef	f_TLI_IRQHandler
1214                     	xdef	f_TRAP_IRQHandler
1215                     	xdef	f_NonHandledInterrupt
1216                     	xdef	_CAPTURE_delta
1217                     	xdef	_CAPTURE_new_mes
1218                     	xdef	_delay_1s_flag
1219                     	xdef	_delay_50ms_flag
1220                     	xdef	_delay_100ms_flag
1221                     	xref	_TIM4_ClearITPendingBit
1222                     	xref	_TIM1_ClearITPendingBit
1223                     	xref.b	c_lreg
1224                     	xref.b	c_x
1225                     	xref.b	c_y
1245                     	xref	c_ladd
1246                     	xref	c_lsub
1247                     	xref	c_rtol
1248                     	xref	c_uitolx
1249                     	end
