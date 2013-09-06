   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  22                     	bsct
  23  0000               L3_CAPTURE_delta:
  24  0000 0000          	dc.w	0
  25  0002               L5_CAPTURE_status:
  26  0002 00            	dc.b	0
  27  0003               L7_CAPTURE_ovf_cnt:
  28  0003 00            	dc.b	0
  29  0004               L11_CAPTURE_no_trig_cnt:
  30  0004 00            	dc.b	0
  31  0005               L31_CAPTURE_no_err_cnt:
  32  0005 00            	dc.b	0
  33  0006               L51_sensor_alive_cnt:
  34  0006 0000          	dc.w	0
  35  0008               L32_Power_fail_tmr:
  36  0008 00            	dc.b	0
  37                     .bit:	section	.data,bit
  38  0000               L52_EVENT_cap_new_mes:
  39  0000 00            	dc.b	0
  40  0001               L72_ERROR_cap_ovf:
  41  0001 00            	dc.b	0
  42  0002               L13_ERROR_cap_no_trig:
  43  0002 00            	dc.b	0
  44  0003               L33_ERROR_cap_sens_not_resp:
  45  0003 00            	dc.b	0
  46  0004               L53_POWER_timer_en:
  47  0004 00            	dc.b	0
  48  0005               _FLAG_IT_RTC_SET_DATE_TIME:
  49  0005 00            	dc.b	0
  50  0006               _FLAG_IT_FLSH_READ_STORED_DATA:
  51  0006 00            	dc.b	0
  52  0007               _FLAG_IT_FLSH_GET_OCCUPIED_SPC:
  53  0007 00            	dc.b	0
  54  0008               _FLAG_IT_FLSH_GET_HEADER_SIZE:
  55  0008 00            	dc.b	0
  56  0009               _FLAG_IT_FLSH_READ_HEADER:
  57  0009 00            	dc.b	0
  87                     ; 86 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  87                     ; 87 {
  88                     .text:	section	.text,new
  89  0000               f_NonHandledInterrupt:
  93                     ; 91 }
  96  0000 80            	iret	
 118                     ; 99 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
 118                     ; 100 {
 119                     .text:	section	.text,new
 120  0000               f_TRAP_IRQHandler:
 124                     ; 104 }
 127  0000 80            	iret	
 149                     ; 111 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 149                     ; 112 
 149                     ; 113 {
 150                     .text:	section	.text,new
 151  0000               f_TLI_IRQHandler:
 155                     ; 117 }
 158  0000 80            	iret	
 180                     ; 124 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 180                     ; 125 {
 181                     .text:	section	.text,new
 182  0000               f_AWU_IRQHandler:
 186                     ; 129 }
 189  0000 80            	iret	
 211                     ; 136 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 211                     ; 137 {
 212                     .text:	section	.text,new
 213  0000               f_CLK_IRQHandler:
 217                     ; 141 }
 220  0000 80            	iret	
 245                     ; 148 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 245                     ; 149 {
 246                     .text:	section	.text,new
 247  0000               f_EXTI_PORTA_IRQHandler:
 249  0000 8a            	push	cc
 250  0001 84            	pop	a
 251  0002 a4bf          	and	a,#191
 252  0004 88            	push	a
 253  0005 86            	pop	cc
 254  0006 3b0002        	push	c_x+2
 255  0009 be00          	ldw	x,c_x
 256  000b 89            	pushw	x
 257  000c 3b0002        	push	c_y+2
 258  000f be00          	ldw	x,c_y
 259  0011 89            	pushw	x
 262                     ; 153   if(!POWER_timer_en) 
 264  0012 7200000407    	btjt	L53_POWER_timer_en,L521
 265                     ; 155     Power_FailDetected();
 267  0017 cd0000        	call	_Power_FailDetected
 269                     ; 156     POWER_timer_en = TRUE;
 271  001a 72100004      	bset	L53_POWER_timer_en
 272  001e               L521:
 273                     ; 158 }
 276  001e 85            	popw	x
 277  001f bf00          	ldw	c_y,x
 278  0021 320002        	pop	c_y+2
 279  0024 85            	popw	x
 280  0025 bf00          	ldw	c_x,x
 281  0027 320002        	pop	c_x+2
 282  002a 80            	iret	
 305                     ; 165 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 305                     ; 166 {
 306                     .text:	section	.text,new
 307  0000               f_EXTI_PORTB_IRQHandler:
 311                     ; 170 }
 314  0000 80            	iret	
 337                     ; 177 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 337                     ; 178 {
 338                     .text:	section	.text,new
 339  0000               f_EXTI_PORTC_IRQHandler:
 343                     ; 182 }
 346  0000 80            	iret	
 369                     ; 189 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 369                     ; 190 {
 370                     .text:	section	.text,new
 371  0000               f_EXTI_PORTD_IRQHandler:
 375                     ; 194 }
 378  0000 80            	iret	
 401                     ; 201 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 401                     ; 202 {
 402                     .text:	section	.text,new
 403  0000               f_EXTI_PORTE_IRQHandler:
 407                     ; 206 }
 410  0000 80            	iret	
 432                     ; 253 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 432                     ; 254 {
 433                     .text:	section	.text,new
 434  0000               f_SPI_IRQHandler:
 438                     ; 258 }
 441  0000 80            	iret	
 465                     ; 265 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 465                     ; 266 {
 466                     .text:	section	.text,new
 467  0000               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 469  0000 8a            	push	cc
 470  0001 84            	pop	a
 471  0002 a4bf          	and	a,#191
 472  0004 88            	push	a
 473  0005 86            	pop	cc
 474  0006 3b0002        	push	c_x+2
 475  0009 be00          	ldw	x,c_x
 476  000b 89            	pushw	x
 477  000c 3b0002        	push	c_y+2
 478  000f be00          	ldw	x,c_y
 479  0011 89            	pushw	x
 482                     ; 271   if(DEBUG_PIN_STATE)
 484  0012 7209501a06    	btjf	20506,#4,L702
 485                     ; 272     DEBUG_PIN_OFF;
 487  0017 72195019      	bres	20505,#4
 489  001b 2004          	jra	L112
 490  001d               L702:
 491                     ; 273   else DEBUG_PIN_ON;
 493  001d 72185019      	bset	20505,#4
 494  0021               L112:
 495                     ; 274   TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
 497  0021 a601          	ld	a,#1
 498  0023 cd0000        	call	_TIM1_ClearITPendingBit
 500                     ; 275 }
 503  0026 85            	popw	x
 504  0027 bf00          	ldw	c_y,x
 505  0029 320002        	pop	c_y+2
 506  002c 85            	popw	x
 507  002d bf00          	ldw	c_x,x
 508  002f 320002        	pop	c_x+2
 509  0032 80            	iret	
 532                     ; 282 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 532                     ; 283 {
 533                     .text:	section	.text,new
 534  0000               f_TIM1_CAP_COM_IRQHandler:
 538                     ; 341 }
 541  0000 80            	iret	
 564                     ; 374 INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 564                     ; 375 {
 565                     .text:	section	.text,new
 566  0000               f_TIM2_UPD_OVF_BRK_IRQHandler:
 570                     ; 379 }
 573  0000 80            	iret	
 596                     ; 386 INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 596                     ; 387 {
 597                     .text:	section	.text,new
 598  0000               f_TIM2_CAP_COM_IRQHandler:
 602                     ; 391 }
 605  0000 80            	iret	
 628                     ; 428 INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 628                     ; 429 {
 629                     .text:	section	.text,new
 630  0000               f_UART1_TX_IRQHandler:
 634                     ; 433 }
 637  0000 80            	iret	
 673                     ; 440 INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 673                     ; 441 {
 674                     .text:	section	.text,new
 675  0000               f_UART1_RX_IRQHandler:
 677       00000001      OFST:	set	1
 678  0000 88            	push	a
 681                     ; 445   u8 rx_data = (u8)UART1->DR;
 683  0001 c65231        	ld	a,21041
 684  0004 6b01          	ld	(OFST+0,sp),a
 685                     ; 454   OS_Smsg_Send_I(smsg_rx_rec, (OST_SMSG)rx_data);
 687  0006 72110000      	bres	__OS_Flags,#0
 690  000a 3d00          	tnz	_smsg_rx_rec
 691  000c 2704          	jreq	L572
 694  000e 72100000      	bset	__OS_Flags,#0
 695  0012               L572:
 698  0012 b700          	ld	_smsg_rx_rec,a
 699                     ; 457 }
 702  0014 84            	pop	a
 703  0015 80            	iret	
 725                     ; 465 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 725                     ; 466 {
 726                     .text:	section	.text,new
 727  0000               f_I2C_IRQHandler:
 731                     ; 470 }
 734  0000 80            	iret	
 756                     ; 544 INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 756                     ; 545 {
 757                     .text:	section	.text,new
 758  0000               f_ADC1_IRQHandler:
 762                     ; 549 }
 765  0000 80            	iret	
 793                     ; 570 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)     /* once every 2MS */
 793                     ; 571 {
 794                     .text:	section	.text,new
 795  0000               f_TIM4_UPD_OVF_IRQHandler:
 797  0000 8a            	push	cc
 798  0001 84            	pop	a
 799  0002 a4bf          	and	a,#191
 800  0004 88            	push	a
 801  0005 86            	pop	cc
 802  0006 3b0002        	push	c_x+2
 803  0009 be00          	ldw	x,c_x
 804  000b 89            	pushw	x
 805  000c 3b0002        	push	c_y+2
 806  000f be00          	ldw	x,c_y
 807  0011 89            	pushw	x
 810                     ; 576   if(POWER_timer_en)
 812  0012 7201000417    	btjf	L53_POWER_timer_en,L723
 813                     ; 578     if(Power_fail_tmr < 255) Power_fail_tmr++;
 815  0017 b608          	ld	a,L32_Power_fail_tmr
 816  0019 a1ff          	cp	a,#255
 817  001b 2404          	jruge	L133
 820  001d 3c08          	inc	L32_Power_fail_tmr
 821  001f b608          	ld	a,L32_Power_fail_tmr
 822  0021               L133:
 823                     ; 579     if(Power_fail_tmr >= 10) 
 825  0021 a10a          	cp	a,#10
 826  0023 2509          	jrult	L723
 827                     ; 581       Power_fail_tmr = 0;
 829  0025 3f08          	clr	L32_Power_fail_tmr
 830                     ; 582       POWER_timer_en = FALSE;
 832  0027 72110004      	bres	L53_POWER_timer_en
 833                     ; 584       WWDG_SWReset();
 835  002b cd0000        	call	_WWDG_SWReset
 837  002e               L723:
 838                     ; 597   OS_Timer();
 840  002e cd0000        	call	_OS_Timer
 842                     ; 598   TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 844  0031 a601          	ld	a,#1
 845  0033 cd0000        	call	_TIM4_ClearITPendingBit
 847                     ; 599 }
 850  0036 85            	popw	x
 851  0037 bf00          	ldw	c_y,x
 852  0039 320002        	pop	c_y+2
 853  003c 85            	popw	x
 854  003d bf00          	ldw	c_x,x
 855  003f 320002        	pop	c_x+2
 856  0042 80            	iret	
 879                     ; 607 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 879                     ; 608 {
 880                     .text:	section	.text,new
 881  0000               f_EEPROM_EEC_IRQHandler:
 885                     ; 612 }
 888  0000 80            	iret	
1072                     	xref	_Power_FailDetected
1073                     	xref.b	_smsg_rx_rec
1074                     	xref	_OS_Timer
1075                     	xref.b	__OS_Flags
1076                     	xdef	f_EEPROM_EEC_IRQHandler
1077                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1078                     	xdef	f_ADC1_IRQHandler
1079                     	xdef	f_I2C_IRQHandler
1080                     	xdef	f_UART1_RX_IRQHandler
1081                     	xdef	f_UART1_TX_IRQHandler
1082                     	xdef	f_TIM2_CAP_COM_IRQHandler
1083                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1084                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1085                     	xdef	f_TIM1_CAP_COM_IRQHandler
1086                     	xdef	f_SPI_IRQHandler
1087                     	xdef	f_EXTI_PORTE_IRQHandler
1088                     	xdef	f_EXTI_PORTD_IRQHandler
1089                     	xdef	f_EXTI_PORTC_IRQHandler
1090                     	xdef	f_EXTI_PORTB_IRQHandler
1091                     	xdef	f_EXTI_PORTA_IRQHandler
1092                     	xdef	f_CLK_IRQHandler
1093                     	xdef	f_AWU_IRQHandler
1094                     	xdef	f_TLI_IRQHandler
1095                     	xdef	f_TRAP_IRQHandler
1096                     	xdef	f_NonHandledInterrupt
1097                     	xdef	_FLAG_IT_FLSH_READ_HEADER
1098                     	xdef	_FLAG_IT_FLSH_GET_HEADER_SIZE
1099                     	xdef	_FLAG_IT_FLSH_GET_OCCUPIED_SPC
1100                     	xdef	_FLAG_IT_FLSH_READ_STORED_DATA
1101                     	xdef	_FLAG_IT_RTC_SET_DATE_TIME
1102                     	xref	_WWDG_SWReset
1103                     	xref	_TIM4_ClearITPendingBit
1104                     	xref	_TIM1_ClearITPendingBit
1105                     	xref.b	c_x
1106                     	xref.b	c_y
1125                     	end
