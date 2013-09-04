   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  20                     	bsct
  21  0000               L3_CAPTURE_delta:
  22  0000 0000          	dc.w	0
  23  0002               L5_CAPTURE_status:
  24  0002 00            	dc.b	0
  25  0003               L7_CAPTURE_ovf_cnt:
  26  0003 00            	dc.b	0
  27  0004               L11_CAPTURE_no_trig_cnt:
  28  0004 00            	dc.b	0
  29  0005               L31_CAPTURE_no_err_cnt:
  30  0005 00            	dc.b	0
  31  0006               L51_sensor_alive_cnt:
  32  0006 0000          	dc.w	0
  33  0008               L32_Power_fail_tmr:
  34  0008 00            	dc.b	0
  35                     .bit:	section	.data,bit
  36  0000               L52_EVENT_cap_new_mes:
  37  0000 00            	dc.b	0
  38  0001               L72_ERROR_cap_ovf:
  39  0001 00            	dc.b	0
  40  0002               L13_ERROR_cap_no_trig:
  41  0002 00            	dc.b	0
  42  0003               L33_ERROR_cap_sens_not_resp:
  43  0003 00            	dc.b	0
  44  0004               L53_POWER_timer_en:
  45  0004 00            	dc.b	0
  46  0005               _FLAG_IT_RTC_SET_DATE_TIME:
  47  0005 00            	dc.b	0
  48  0006               _FLAG_IT_FLSH_READ_STORED_DATA:
  49  0006 00            	dc.b	0
  50  0007               _FLAG_IT_FLSH_GET_OCCUPIED_SPC:
  51  0007 00            	dc.b	0
  52  0008               _FLAG_IT_FLSH_GET_HEADER_SIZE:
  53  0008 00            	dc.b	0
  54  0009               _FLAG_IT_FLSH_READ_HEADER:
  55  0009 00            	dc.b	0
  85                     ; 86 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  85                     ; 87 {
  86                     .text:	section	.text,new
  87  0000               f_NonHandledInterrupt:
  91                     ; 91 }
  94  0000 80            	iret	
 116                     ; 99 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
 116                     ; 100 {
 117                     .text:	section	.text,new
 118  0000               f_TRAP_IRQHandler:
 122                     ; 104 }
 125  0000 80            	iret	
 147                     ; 111 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 147                     ; 112 
 147                     ; 113 {
 148                     .text:	section	.text,new
 149  0000               f_TLI_IRQHandler:
 153                     ; 117 }
 156  0000 80            	iret	
 178                     ; 124 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 178                     ; 125 {
 179                     .text:	section	.text,new
 180  0000               f_AWU_IRQHandler:
 184                     ; 129 }
 187  0000 80            	iret	
 209                     ; 136 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 209                     ; 137 {
 210                     .text:	section	.text,new
 211  0000               f_CLK_IRQHandler:
 215                     ; 141 }
 218  0000 80            	iret	
 243                     ; 148 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 243                     ; 149 {
 244                     .text:	section	.text,new
 245  0000               f_EXTI_PORTA_IRQHandler:
 247  0000 8a            	push	cc
 248  0001 84            	pop	a
 249  0002 a4bf          	and	a,#191
 250  0004 88            	push	a
 251  0005 86            	pop	cc
 252  0006 3b0002        	push	c_x+2
 253  0009 be00          	ldw	x,c_x
 254  000b 89            	pushw	x
 255  000c 3b0002        	push	c_y+2
 256  000f be00          	ldw	x,c_y
 257  0011 89            	pushw	x
 260                     ; 153   if(!POWER_timer_en) 
 262  0012 7200000407    	btjt	L53_POWER_timer_en,L521
 263                     ; 155     Power_FailDetected();
 265  0017 cd0000        	call	_Power_FailDetected
 267                     ; 156     POWER_timer_en = TRUE;
 269  001a 72100004      	bset	L53_POWER_timer_en
 270  001e               L521:
 271                     ; 158 }
 274  001e 85            	popw	x
 275  001f bf00          	ldw	c_y,x
 276  0021 320002        	pop	c_y+2
 277  0024 85            	popw	x
 278  0025 bf00          	ldw	c_x,x
 279  0027 320002        	pop	c_x+2
 280  002a 80            	iret	
 303                     ; 165 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 303                     ; 166 {
 304                     .text:	section	.text,new
 305  0000               f_EXTI_PORTB_IRQHandler:
 309                     ; 170 }
 312  0000 80            	iret	
 335                     ; 177 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 335                     ; 178 {
 336                     .text:	section	.text,new
 337  0000               f_EXTI_PORTC_IRQHandler:
 341                     ; 182 }
 344  0000 80            	iret	
 367                     ; 189 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 367                     ; 190 {
 368                     .text:	section	.text,new
 369  0000               f_EXTI_PORTD_IRQHandler:
 373                     ; 194 }
 376  0000 80            	iret	
 399                     ; 201 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 399                     ; 202 {
 400                     .text:	section	.text,new
 401  0000               f_EXTI_PORTE_IRQHandler:
 405                     ; 206 }
 408  0000 80            	iret	
 430                     ; 253 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 430                     ; 254 {
 431                     .text:	section	.text,new
 432  0000               f_SPI_IRQHandler:
 436                     ; 258 }
 439  0000 80            	iret	
 463                     ; 265 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 463                     ; 266 {
 464                     .text:	section	.text,new
 465  0000               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 467  0000 8a            	push	cc
 468  0001 84            	pop	a
 469  0002 a4bf          	and	a,#191
 470  0004 88            	push	a
 471  0005 86            	pop	cc
 472  0006 3b0002        	push	c_x+2
 473  0009 be00          	ldw	x,c_x
 474  000b 89            	pushw	x
 475  000c 3b0002        	push	c_y+2
 476  000f be00          	ldw	x,c_y
 477  0011 89            	pushw	x
 480                     ; 271   if(DEBUG_PIN_STATE)
 482  0012 7209501a06    	btjf	20506,#4,L702
 483                     ; 272     DEBUG_PIN_OFF;
 485  0017 72195019      	bres	20505,#4
 487  001b 2004          	jra	L112
 488  001d               L702:
 489                     ; 273   else DEBUG_PIN_ON;
 491  001d 72185019      	bset	20505,#4
 492  0021               L112:
 493                     ; 274   TIM1_ClearITPendingBit(TIM1_IT_UPDATE);
 495  0021 a601          	ld	a,#1
 496  0023 cd0000        	call	_TIM1_ClearITPendingBit
 498                     ; 275 }
 501  0026 85            	popw	x
 502  0027 bf00          	ldw	c_y,x
 503  0029 320002        	pop	c_y+2
 504  002c 85            	popw	x
 505  002d bf00          	ldw	c_x,x
 506  002f 320002        	pop	c_x+2
 507  0032 80            	iret	
 530                     ; 282 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 530                     ; 283 {
 531                     .text:	section	.text,new
 532  0000               f_TIM1_CAP_COM_IRQHandler:
 536                     ; 341 }
 539  0000 80            	iret	
 562                     ; 374 INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 562                     ; 375 {
 563                     .text:	section	.text,new
 564  0000               f_TIM2_UPD_OVF_BRK_IRQHandler:
 568                     ; 379 }
 571  0000 80            	iret	
 594                     ; 386 INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 594                     ; 387 {
 595                     .text:	section	.text,new
 596  0000               f_TIM2_CAP_COM_IRQHandler:
 600                     ; 391 }
 603  0000 80            	iret	
 626                     ; 428 INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 626                     ; 429 {
 627                     .text:	section	.text,new
 628  0000               f_UART1_TX_IRQHandler:
 632                     ; 433 }
 635  0000 80            	iret	
 671                     ; 440 INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 671                     ; 441 {
 672                     .text:	section	.text,new
 673  0000               f_UART1_RX_IRQHandler:
 675       00000001      OFST:	set	1
 676  0000 88            	push	a
 679                     ; 445   u8 rx_data = (u8)UART1->DR;
 681  0001 c65231        	ld	a,21041
 682  0004 6b01          	ld	(OFST+0,sp),a
 683                     ; 454   OS_Smsg_Send_I(smsg_rx_rec, (OST_SMSG)rx_data);
 685  0006 72110000      	bres	__OS_Flags,#0
 688  000a 3d00          	tnz	_smsg_rx_rec
 689  000c 2704          	jreq	L572
 692  000e 72100000      	bset	__OS_Flags,#0
 693  0012               L572:
 696  0012 b700          	ld	_smsg_rx_rec,a
 697                     ; 457 }
 700  0014 84            	pop	a
 701  0015 80            	iret	
 723                     ; 465 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 723                     ; 466 {
 724                     .text:	section	.text,new
 725  0000               f_I2C_IRQHandler:
 729                     ; 470 }
 732  0000 80            	iret	
 754                     ; 544 INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 754                     ; 545 {
 755                     .text:	section	.text,new
 756  0000               f_ADC1_IRQHandler:
 760                     ; 549 }
 763  0000 80            	iret	
 791                     ; 570 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)     /* once every 2MS */
 791                     ; 571 {
 792                     .text:	section	.text,new
 793  0000               f_TIM4_UPD_OVF_IRQHandler:
 795  0000 8a            	push	cc
 796  0001 84            	pop	a
 797  0002 a4bf          	and	a,#191
 798  0004 88            	push	a
 799  0005 86            	pop	cc
 800  0006 3b0002        	push	c_x+2
 801  0009 be00          	ldw	x,c_x
 802  000b 89            	pushw	x
 803  000c 3b0002        	push	c_y+2
 804  000f be00          	ldw	x,c_y
 805  0011 89            	pushw	x
 808                     ; 576   if(POWER_timer_en)
 810  0012 7201000417    	btjf	L53_POWER_timer_en,L723
 811                     ; 578     if(Power_fail_tmr < 255) Power_fail_tmr++;
 813  0017 b608          	ld	a,L32_Power_fail_tmr
 814  0019 a1ff          	cp	a,#255
 815  001b 2404          	jruge	L133
 818  001d 3c08          	inc	L32_Power_fail_tmr
 819  001f b608          	ld	a,L32_Power_fail_tmr
 820  0021               L133:
 821                     ; 579     if(Power_fail_tmr >= 10) 
 823  0021 a10a          	cp	a,#10
 824  0023 2509          	jrult	L723
 825                     ; 581       Power_fail_tmr = 0;
 827  0025 3f08          	clr	L32_Power_fail_tmr
 828                     ; 582       POWER_timer_en = FALSE;
 830  0027 72110004      	bres	L53_POWER_timer_en
 831                     ; 584       WWDG_SWReset();
 833  002b cd0000        	call	_WWDG_SWReset
 835  002e               L723:
 836                     ; 597   OS_Timer();
 838  002e cd0000        	call	_OS_Timer
 840                     ; 598   TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 842  0031 a601          	ld	a,#1
 843  0033 cd0000        	call	_TIM4_ClearITPendingBit
 845                     ; 599 }
 848  0036 85            	popw	x
 849  0037 bf00          	ldw	c_y,x
 850  0039 320002        	pop	c_y+2
 851  003c 85            	popw	x
 852  003d bf00          	ldw	c_x,x
 853  003f 320002        	pop	c_x+2
 854  0042 80            	iret	
 877                     ; 607 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 877                     ; 608 {
 878                     .text:	section	.text,new
 879  0000               f_EEPROM_EEC_IRQHandler:
 883                     ; 612 }
 886  0000 80            	iret	
1070                     	xref	_Power_FailDetected
1071                     	xref.b	_smsg_rx_rec
1072                     	xref	_OS_Timer
1073                     	xref.b	__OS_Flags
1074                     	xdef	f_EEPROM_EEC_IRQHandler
1075                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1076                     	xdef	f_ADC1_IRQHandler
1077                     	xdef	f_I2C_IRQHandler
1078                     	xdef	f_UART1_RX_IRQHandler
1079                     	xdef	f_UART1_TX_IRQHandler
1080                     	xdef	f_TIM2_CAP_COM_IRQHandler
1081                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1082                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1083                     	xdef	f_TIM1_CAP_COM_IRQHandler
1084                     	xdef	f_SPI_IRQHandler
1085                     	xdef	f_EXTI_PORTE_IRQHandler
1086                     	xdef	f_EXTI_PORTD_IRQHandler
1087                     	xdef	f_EXTI_PORTC_IRQHandler
1088                     	xdef	f_EXTI_PORTB_IRQHandler
1089                     	xdef	f_EXTI_PORTA_IRQHandler
1090                     	xdef	f_CLK_IRQHandler
1091                     	xdef	f_AWU_IRQHandler
1092                     	xdef	f_TLI_IRQHandler
1093                     	xdef	f_TRAP_IRQHandler
1094                     	xdef	f_NonHandledInterrupt
1095                     	xdef	_FLAG_IT_FLSH_READ_HEADER
1096                     	xdef	_FLAG_IT_FLSH_GET_HEADER_SIZE
1097                     	xdef	_FLAG_IT_FLSH_GET_OCCUPIED_SPC
1098                     	xdef	_FLAG_IT_FLSH_READ_STORED_DATA
1099                     	xdef	_FLAG_IT_RTC_SET_DATE_TIME
1100                     	xref	_WWDG_SWReset
1101                     	xref	_TIM4_ClearITPendingBit
1102                     	xref	_TIM1_ClearITPendingBit
1103                     	xref.b	c_x
1104                     	xref.b	c_y
1123                     	end
