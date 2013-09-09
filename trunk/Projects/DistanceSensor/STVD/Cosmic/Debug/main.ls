   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  22                     .CALIB:	section	.text
  23  0000               _CAL:
  24  0000 28            	dc.b	40
  25  0001 16            	dc.b	22
  26  0002 ae            	dc.b	174
  27  0003 bf            	dc.b	191
  28  0004 03            	dc.b	3
  29  0005 00            	dc.b	0
  30  0006 00            	dc.b	0
  31  0007 89            	dc.b	137
  32  0008 7530          	dc.w	30000
  33  000a 0dac          	dc.w	3500
  34  000c 00            	dc.b	0
  35  000d 00            	dc.b	0
  36                     	bsct
  37  0000               L3_temperature:
  38  0000 0000          	dc.w	0
  39                     .bit:	section	.data,bit
  40  0000               L11_FLAG_temp_neg:
  41  0000 00            	dc.b	0
  42  0001               L31_FLAG_dist_samp_read:
  43  0001 00            	dc.b	0
  44  0002               L51_FLAG_dist_valid_calc:
  45  0002 00            	dc.b	0
  46  0003               L71_FLAG_rtc_settime:
  47  0003 00            	dc.b	0
  48  0004               L12_FLAG_ds18b20_err:
  49  0004 00            	dc.b	0
  50  0005               L32_FLAG_spiflash_access:
  51  0005 00            	dc.b	0
  52  0006               L52_FLAG_spiflash_write:
  53  0006 01            	dc.b	1
  54  0007               L72_FLAG_ExtFlashinit_OK:
  55  0007 00            	dc.b	0
 113                     ; 75 void main(void)
 113                     ; 76 {
 115                     .text:	section	.text,new
 116  0000               _main:
 120                     ; 77   Config();
 122  0000 cd0000        	call	_Config
 124                     ; 78   DELAY_US(1000);
 126  0003 ae03e8        	ldw	x,#1000
 128  0006               L01:
 129  0006 5a            	decw	X
 130  0007 26fd          	jrne	L01
 131  0009 9d            	nop	
 133                     ; 79   DS18B20_All_init();
 136  000a cd0000        	call	_DS18B20_All_init
 138                     ; 80   Display_Init(); 
 140  000d cd0000        	call	_Display_Init
 142                     ; 81   FlashMngr_Init();
 144  0010 cd0000        	call	_FlashMngr_Init
 146                     ; 83   FLAG_ds18b20_err = DS18B20_All_convert();
 148  0013 cd0000        	call	_DS18B20_All_convert
 150  0016 4d            	tnz	a
 151  0017 2706          	jreq	L02
 152  0019 72100004      	bset	L12_FLAG_ds18b20_err
 153  001d 2004          	jra	L42
 154  001f               L02:
 155  001f 72110004      	bres	L12_FLAG_ds18b20_err
 156  0023               L42:
 157                     ; 84   OS_Init();
 159  0023 cd0000        	call	_OS_Init
 161                     ; 86   OS_Task_Create(0, TASK_1000mS);
 163  0026 ae0000        	ldw	x,#_TASK_1000mS
 164  0029 cd00f2        	call	LC002
 165                     ; 87   OS_Task_Create(0, TASK_UARTCommands);
 168  002c ae0000        	ldw	x,#_TASK_UARTCommands
 169  002f cd00f2        	call	LC002
 170                     ; 88   OS_Task_Create(0, TASK_LogDataToFlash);
 173  0032 ae0000        	ldw	x,#_TASK_LogDataToFlash
 174  0035 cd00f2        	call	LC002
 175                     ; 89   OS_Smsg_Create(smsg_rx_rec);
 177  0038 cd0000        	call	__OS_DI_INT
 181  003b 3f03          	clr	_smsg_rx_rec
 184  003d cd0000        	call	__OS_RI_INT
 186                     ; 91   OS_EI();
 189  0040 9a            	rim	
 191  0041               L36:
 192                     ; 93   OS_Run();
 194  0041 72190000      	bres	__OS_Flags,#4
 197  0045 72160000      	bset	__OS_Flags,#3
 200  0049 35080000      	mov	__OS_Best_Priority,#8
 204  004d 450000        	mov	__OS_CurTask,__OS_LastTask
 205  0050               L76:
 208  0050 b600          	ld	a,__OS_CurTask
 209  0052 a10e          	cp	a,#__OS_Tasks+14
 210  0054 2506          	jrult	L57
 213  0056 35000000      	mov	__OS_CurTask,#__OS_Tasks
 215  005a 2006          	jra	L77
 216  005c               L57:
 219  005c b600          	ld	a,__OS_CurTask
 220  005e ab07          	add	a,#7
 221  0060 b700          	ld	__OS_CurTask,a
 222  0062               L77:
 225  0062 cd00e5        	call	LC001
 228  0065 720d000032    	btjf	__OS_State,#6,L17
 230  006a 720e00002d    	btjt	__OS_State,#7,L17
 234  006f b600          	ld	a,__OS_State
 235  0071 a407          	and	a,#7
 236  0073 b700          	ld	__OS_Temp,a
 237  0075 b100          	cp	a,__OS_Best_Priority
 238  0077 2423          	jruge	L17
 243  0079 720700003f    	btjf	__OS_State,#3,L13
 244  007e               L701:
 247  007e 7209000005    	btjf	__OS_State,#4,L311
 249  0083 720b000014    	btjf	__OS_State,#5,L17
 252  0088               L311:
 256  0088 720700000f    	btjf	__OS_State,#3,L17
 259  008d 72180000      	bset	__OS_Flags,#4
 262  0091 450000        	mov	__OS_BestTask,__OS_CurTask
 265  0094 b600          	ld	a,__OS_State
 266  0096 a407          	and	a,#7
 267  0098 b700          	ld	__OS_Best_Priority,a
 270  009a 2706          	jreq	L37
 273  009c               L17:
 276  009c b600          	ld	a,__OS_CurTask
 277  009e b100          	cp	a,__OS_LastTask
 278  00a0 26ae          	jrne	L76
 279  00a2               L37:
 282  00a2 720900009a    	btjf	__OS_Flags,#4,L36
 285  00a7 72170000      	bres	__OS_Flags,#3
 288  00ab 450000        	mov	__OS_CurTask,__OS_BestTask
 291  00ae 450000        	mov	__OS_LastTask,__OS_CurTask
 292  00b1 ad32          	call	LC001
 295  00b3 720d000089    	btjf	__OS_State,#6,L36
 297  00b8 720e000084    	btjt	__OS_State,#7,L36
 299  00bd               L13:
 303  00bd cd0000        	call	__OS_JumpToTask
 309  00c0 905f          	clrw	Y
 314  00c2 b600          	ld	A,__OS_CurTask
 319  00c4 9097          	ld	YL,A
 325  00c6 8a            	push	CC
 330  00c7 320000        	pop	__OS_Temp
 335  00ca 9b            	sim	
 340  00cb 90f6          	ld	A,(Y)
 345  00cd a4d7          	and	A,#0xD7
 350  00cf 90f7          	ld	(Y),A
 355  00d1 a628          	ld	A,#0x28
 360  00d3 b400          	and	A,__OS_State
 365  00d5 90fa          	or	A,(Y)
 370  00d7 90f7          	ld	(Y),A
 375  00d9 3b0000        	push	__OS_Temp
 380  00dc 86            	pop	CC
 385  00dd 720600009c    	btjt	__OS_Flags,#3,L701
 388  00e2 cc0041        	jra	L36
 389  00e5               LC001:
 390  00e5 ae0000        	ldw	x,#__OS_State
 391  00e8 b600          	ld	a,__OS_CurTask
 392  00ea 905f          	clrw	y
 393  00ec 9097          	ld	yl,a
 394  00ee 90f6          	ld	a,(y)
 395  00f0 f7            	ld	(x),a
 396  00f1 81            	ret	
 397  00f2               LC002:
 398  00f2 89            	pushw	x
 399  00f3 4f            	clr	a
 400  00f4 cd0000        	call	__OS_Task_Create
 402  00f7 85            	popw	x
 403  00f8 81            	ret	
 440                     ; 96 void TASK_LogDataToFlash()
 440                     ; 97 {
 441                     .text:	section	.text,new
 442  0000               _TASK_LogDataToFlash:
 446  0000               L531:
 447                     ; 100     OS_Delay(CAL.DataLogInterval);
 449  0000 ce0008        	ldw	x,_CAL+8
 450  0003 cd0000        	call	__OS_InitDelay
 454  0006 cd0000        	call	__OS_ReturnSave
 456                     ; 101     if(CAL.EnableLogging == 0x01)
 459  0009 c6000c        	ld	a,_CAL+12
 460  000c 4a            	dec	a
 461  000d 26f1          	jrne	L531
 462                     ; 103       buff[0] = (u8)temp_intreg;
 464  000f 450d04        	mov	_buff,L5_temp_intreg
 465                     ; 104       buff[1] = (u8)temp_frac;
 467  0012 450c05        	mov	_buff+1,L7_temp_frac
 468                     ; 105       buff[2] = (u8)RTC_hour;
 470  0015 450006        	mov	_buff+2,_RTC_hour
 471                     ; 106       buff[3] = (u8)RTC_min;
 473  0018 450007        	mov	_buff+3,_RTC_min
 474                     ; 107       buff[4] = (u8)RTC_sec;
 476  001b 450008        	mov	_buff+4,_RTC_sec
 477                     ; 108       buff[5] = (u8)RTC_day;
 479  001e 450009        	mov	_buff+5,_RTC_day
 480                     ; 109       buff[6] = (u8)RTC_month;
 482  0021 45000a        	mov	_buff+6,_RTC_month
 483                     ; 110       buff[7] = (u8)RTC_year;
 485                     ; 111       FlashMngr_StoreData(buff, 8);
 487  0024 ae0008        	ldw	x,#8
 488  0027 45000b        	mov	_buff+7,_RTC_year
 489  002a 89            	pushw	x
 490  002b ae0004        	ldw	x,#_buff
 491  002e cd0000        	call	_FlashMngr_StoreData
 493  0031 85            	popw	x
 494  0032 20cc          	jra	L531
 547                     ; 116 void TASK_1000mS()
 547                     ; 117 {
 548                     .text:	section	.text,new
 549  0000               _TASK_1000mS:
 551  0000 5205          	subw	sp,#5
 552       00000005      OFST:	set	5
 555  0002               L161:
 556                     ; 121     OS_Delay(500);      // Wait 1000 ms
 558  0002 ae01f4        	ldw	x,#500
 559  0005 cd0000        	call	__OS_InitDelay
 563  0008 cd0000        	call	__OS_ReturnSave
 565                     ; 122     DS18B20_Read_Temp(&temperature, CAL.ROM_ID1);
 568  000b ae0000        	ldw	x,#_CAL
 569  000e 89            	pushw	x
 570  000f ae0000        	ldw	x,#L3_temperature
 571  0012 cd0000        	call	_DS18B20_Read_Temp
 573  0015 85            	popw	x
 574                     ; 123     DS3231M_GetTime();
 576  0016 cd0000        	call	_DS3231M_GetTime
 578                     ; 124     DS3231M_GetDate();
 580  0019 cd0000        	call	_DS3231M_GetDate
 582                     ; 126     tempdisp[0] = (char)((u8)((RTC_hour & 0xF0)>>4) + (u8)48);
 584  001c b600          	ld	a,_RTC_hour
 585  001e 4e            	swap	a
 586  001f a40f          	and	a,#15
 587  0021 ab30          	add	a,#48
 588  0023 6b01          	ld	(OFST-4,sp),a
 589                     ; 127     tempdisp[1] = (char)((u8)(RTC_hour & 0x0F) + (u8)48);
 591  0025 b600          	ld	a,_RTC_hour
 592  0027 a40f          	and	a,#15
 593  0029 ab30          	add	a,#48
 594  002b 6b02          	ld	(OFST-3,sp),a
 595                     ; 128     tempdisp[2] = (char)((u8)((RTC_min & 0xF0)>>4) + (u8)48);
 597  002d b600          	ld	a,_RTC_min
 598  002f 4e            	swap	a
 599  0030 a40f          	and	a,#15
 600  0032 ab30          	add	a,#48
 601  0034 6b03          	ld	(OFST-2,sp),a
 602                     ; 129     tempdisp[3] = (char)((u8)(RTC_min & 0x0F) + (u8)48);
 604  0036 b600          	ld	a,_RTC_min
 605  0038 a40f          	and	a,#15
 606  003a ab30          	add	a,#48
 607  003c 6b04          	ld	(OFST-1,sp),a
 608                     ; 130     tempdisp[4] = 0;
 610  003e 0f05          	clr	(OFST+0,sp)
 611                     ; 131     Display_SetScreen(0,  tempdisp, COMMAPOS2);
 613  0040 4b02          	push	#2
 614  0042 96            	ldw	x,sp
 615  0043 1c0002        	addw	x,#OFST-3
 616  0046 89            	pushw	x
 617  0047 4f            	clr	a
 618  0048 cd0000        	call	_Display_SetScreen
 620  004b 5b03          	addw	sp,#3
 621                     ; 132     if(temperature < 0)
 623  004d be00          	ldw	x,L3_temperature
 624  004f 2a09          	jrpl	L561
 625                     ; 134       temperature = -(temperature);
 627  0051 50            	negw	x
 628  0052 bf00          	ldw	L3_temperature,x
 629                     ; 135       FLAG_temp_neg = TRUE;
 631  0054 72100000      	bset	L11_FLAG_temp_neg
 633  0058 2004          	jra	L761
 634  005a               L561:
 635                     ; 139       FLAG_temp_neg = FALSE;
 637  005a 72110000      	bres	L11_FLAG_temp_neg
 638  005e               L761:
 639                     ; 141     temp_intreg = (u8)(temperature>>4);
 641  005e 57            	sraw	x
 642  005f 57            	sraw	x
 643  0060 57            	sraw	x
 644  0061 57            	sraw	x
 645  0062 9f            	ld	a,xl
 646  0063 b70d          	ld	L5_temp_intreg,a
 647                     ; 142     temp_frac = (u8)(temperature - (temp_intreg<<4));
 649  0065 a610          	ld	a,#16
 650  0067 42            	mul	x,a
 651  0068 9f            	ld	a,xl
 652  0069 b001          	sub	a,L3_temperature+1
 653  006b 40            	neg	a
 654                     ; 144     temp_frac *= 10;  //(temp_frac * 10) / 16  Scale to [0-9]
 656  006c ae000a        	ldw	x,#10
 657  006f 42            	mul	x,a
 658  0070 9f            	ld	a,xl
 659                     ; 145     temp_frac >>= 4;
 661  0071 4e            	swap	a
 662  0072 a40f          	and	a,#15
 663  0074 b70c          	ld	L7_temp_frac,a
 664                     ; 147     tempdisp[0] = (char)((u8)((temp_intreg)/10) + (u8)48);
 666  0076 5f            	clrw	x
 667  0077 b60d          	ld	a,L5_temp_intreg
 668  0079 97            	ld	xl,a
 669  007a a60a          	ld	a,#10
 670  007c 62            	div	x,a
 671  007d 9f            	ld	a,xl
 672  007e ab30          	add	a,#48
 673  0080 6b01          	ld	(OFST-4,sp),a
 674                     ; 148     tempdisp[1] = (char)((u8)((temp_intreg)%10) + (u8)48);
 676  0082 5f            	clrw	x
 677  0083 b60d          	ld	a,L5_temp_intreg
 678  0085 97            	ld	xl,a
 679  0086 a60a          	ld	a,#10
 680  0088 62            	div	x,a
 681  0089 ab30          	add	a,#48
 682  008b 6b02          	ld	(OFST-3,sp),a
 683                     ; 149     tempdisp[2] = (char)((u8)temp_frac + (u8)48);
 685  008d b60c          	ld	a,L7_temp_frac
 686  008f ab30          	add	a,#48
 687  0091 6b03          	ld	(OFST-2,sp),a
 688                     ; 150     tempdisp[3] = 'c';
 690  0093 a663          	ld	a,#99
 691  0095 6b04          	ld	(OFST-1,sp),a
 692                     ; 151     tempdisp[4] = 0;
 694  0097 0f05          	clr	(OFST+0,sp)
 695                     ; 152     Display_SetScreen(1,  tempdisp, COMMAPOS2);
 697  0099 4b02          	push	#2
 698  009b 96            	ldw	x,sp
 699  009c 1c0002        	addw	x,#OFST-3
 700  009f 89            	pushw	x
 701  00a0 a601          	ld	a,#1
 702  00a2 cd0000        	call	_Display_SetScreen
 704  00a5 5b03          	addw	sp,#3
 705                     ; 153     FLAG_ds18b20_err = DS18B20_All_convert();    /* issue DS18B20 convert command, to read the results after 1s */
 707  00a7 cd0000        	call	_DS18B20_All_convert
 709  00aa 4d            	tnz	a
 710  00ab 2706          	jreq	L47
 711  00ad 72100004      	bset	L12_FLAG_ds18b20_err
 712  00b1 2004          	jra	L001
 713  00b3               L47:
 714  00b3 72110004      	bres	L12_FLAG_ds18b20_err
 715  00b7               L001:
 716                     ; 155     if(FlashMngr_GetErrors() != 0)
 718  00b7 cd0000        	call	_FlashMngr_GetErrors
 720  00ba 4d            	tnz	a
 721  00bb 270d          	jreq	L171
 722                     ; 157       Display_SetScreen(2, "Er 1", NOCOMMA);
 724  00bd 4b00          	push	#0
 725  00bf ae000e        	ldw	x,#L371
 726  00c2 89            	pushw	x
 727  00c3 a602          	ld	a,#2
 728  00c5 cd0000        	call	_Display_SetScreen
 730  00c8 5b03          	addw	sp,#3
 731  00ca               L171:
 732                     ; 160     Display_SetBrightness(CAL.Display_Brightness);
 734  00ca ce000a        	ldw	x,_CAL+10
 735  00cd cd0000        	call	_Display_SetBrightness
 737                     ; 161     Display_Cyclic();
 739  00d0 cd0000        	call	_Display_Cyclic
 742  00d3 cc0002        	jra	L161
 882                     ; 165 void TASK_UARTCommands()
 882                     ; 166 {
 883                     .text:	section	.text,new
 884  0000               _TASK_UARTCommands:
 886  0000 5207          	subw	sp,#7
 887       00000007      OFST:	set	7
 890  0002               L323:
 891                     ; 172       OS_Smsg_Wait(smsg_rx_rec, rcvd_message);
 893  0002 cd0000        	call	__OS_EnterWaitMode
 897  0005 b603          	ld	a,_smsg_rx_rec
 898  0007 2702          	jreq	L021
 899  0009 a601          	ld	a,#1
 900  000b               L021:
 901  000b cd0000        	call	__OS_CheckEvent
 906  000e cd0000        	call	__OS_DI_INT
 910  0011 b603          	ld	a,_smsg_rx_rec
 911  0013 272e          	jreq	L723
 915  0015 6b07          	ld	(OFST+0,sp),a
 918  0017 3f03          	clr	_smsg_rx_rec
 921  0019 cd0000        	call	__OS_RI_INT
 923                     ; 173       UART1_ITConfig(UART1_IT_RXNE, DISABLE);
 925  001c 4b00          	push	#0
 926  001e ae0255        	ldw	x,#597
 927  0021 cd0000        	call	_UART1_ITConfig
 929  0024 84            	pop	a
 930                     ; 174       switch(rcvd_message)
 932  0025 7b07          	ld	a,(OFST+0,sp)
 934                     ; 315                     break;
 935  0027 a063          	sub	a,#99
 936  0029 2603cc0120    	jreq	L322
 937  002e a002          	sub	a,#2
 938  0030 2603cc011a    	jreq	L122
 939  0035 a00d          	sub	a,#13
 940  0037 2603cc00e8    	jreq	L125
 941  003c a002          	sub	a,#2
 942  003e 2708          	jreq	L343
 943  0040 cc01a7        	jra	L733
 944  0043               L723:
 945                     ; 172       OS_Smsg_Wait(smsg_rx_rec, rcvd_message);
 947  0043 cd0000        	call	__OS_RI_INT
 950  0046 20ba          	jra	L323
 951  0048               L343:
 952                     ; 179                     while(!(UART1->SR & (u8)0x20));
 954  0048 720b5230fb    	btjf	21040,#5,L343
 955                     ; 180                     l_code = UART1->DR;
 957  004d c65231        	ld	a,21041
 958  0050 6b07          	ld	(OFST+0,sp),a
 959                     ; 181                     switch(l_code)
 962                     ; 228                       default: {break;}
 963  0052 a067          	sub	a,#103
 964  0054 2753          	jreq	L344
 965  0056 a00c          	sub	a,#12
 966  0058 26e6          	jrne	L733
 967  005a               L553:
 968                     ; 187                                   while(!(UART1->SR & (u8)0x20));
 970  005a 720b5230fb    	btjf	21040,#5,L553
 971                     ; 188                                   RTC_sec = UART1->DR;
 973  005f 5552310000    	mov	_RTC_sec,21041
 975  0064               L563:
 976                     ; 190                                   while(!(UART1->SR & (u8)0x20));
 978  0064 720b5230fb    	btjf	21040,#5,L563
 979                     ; 191                                   RTC_min = UART1->DR;
 981  0069 5552310000    	mov	_RTC_min,21041
 983  006e               L573:
 984                     ; 193                                   while(!(UART1->SR & (u8)0x20));
 986  006e 720b5230fb    	btjf	21040,#5,L573
 987                     ; 194                                   RTC_hour = UART1->DR;
 989  0073 5552310000    	mov	_RTC_hour,21041
 991  0078               L504:
 992                     ; 196                                   while(!(UART1->SR & (u8)0x20));
 994  0078 720b5230fb    	btjf	21040,#5,L504
 995                     ; 197                                   RTC_day = UART1->DR;
 997  007d 5552310000    	mov	_RTC_day,21041
 999  0082               L514:
1000                     ; 199                                   while(!(UART1->SR & (u8)0x20));
1002  0082 720b5230fb    	btjf	21040,#5,L514
1003                     ; 200                                   RTC_date = UART1->DR;
1005  0087 5552310000    	mov	_RTC_date,21041
1007  008c               L524:
1008                     ; 202                                   while(!(UART1->SR & (u8)0x20));
1010  008c 720b5230fb    	btjf	21040,#5,L524
1011                     ; 203                                   RTC_month = UART1->DR;
1013  0091 5552310000    	mov	_RTC_month,21041
1015  0096               L534:
1016                     ; 205                                   while(!(UART1->SR & (u8)0x20));
1018  0096 720b5230fb    	btjf	21040,#5,L534
1019                     ; 206                                   RTC_year = UART1->DR;
1021  009b 5552310000    	mov	_RTC_year,21041
1022                     ; 207                                   DS3231M_SetTime();
1024  00a0 cd0000        	call	_DS3231M_SetTime
1026                     ; 208                                   DS3231M_SetDate();
1028  00a3 cd0000        	call	_DS3231M_SetDate
1030                     ; 209                                   break;
1032  00a6 cc01a7        	jra	L733
1033  00a9               L344:
1034                     ; 214                                   while(!(UART1->SR & UART1_FLAG_TXE));
1036  00a9 720f5230fb    	btjf	21040,#7,L344
1037                     ; 215                                   UART1->DR = RTC_hour;
1039  00ae 5500005231    	mov	21041,_RTC_hour
1041  00b3               L354:
1042                     ; 216                                   while(!(UART1->SR & UART1_FLAG_TXE));
1044  00b3 720f5230fb    	btjf	21040,#7,L354
1045                     ; 217                                   UART1->DR = RTC_min;
1047  00b8 5500005231    	mov	21041,_RTC_min
1049  00bd               L364:
1050                     ; 218                                   while(!(UART1->SR & UART1_FLAG_TXE));
1052  00bd 720f5230fb    	btjf	21040,#7,L364
1053                     ; 219                                   UART1->DR = RTC_sec;
1055  00c2 5500005231    	mov	21041,_RTC_sec
1057  00c7               L374:
1058                     ; 220                                   while(!(UART1->SR & UART1_FLAG_TXE));
1060  00c7 720f5230fb    	btjf	21040,#7,L374
1061                     ; 221                                   UART1->DR = RTC_date;
1063  00cc 5500005231    	mov	21041,_RTC_date
1065  00d1               L305:
1066                     ; 222                                   while(!(UART1->SR & UART1_FLAG_TXE));
1068  00d1 720f5230fb    	btjf	21040,#7,L305
1069                     ; 223                                   UART1->DR = RTC_month;
1071  00d6 5500005231    	mov	21041,_RTC_month
1073  00db               L315:
1074                     ; 224                                   while(!(UART1->SR & UART1_FLAG_TXE));
1076  00db 720f5230fb    	btjf	21040,#7,L315
1077                     ; 225                                   UART1->DR = RTC_year;
1079  00e0 5500005231    	mov	21041,_RTC_year
1080                     ; 226                                   break;
1082  00e5 cc01a7        	jra	L733
1083                     ; 230                     break;
1085  00e8               L125:
1086                     ; 234                     while(!(UART1->SR & (u8)0x20));
1088  00e8 720b5230fb    	btjf	21040,#5,L125
1089                     ; 235                     l_code = UART1->DR;
1091  00ed c65231        	ld	a,21041
1092  00f0 6b07          	ld	(OFST+0,sp),a
1093                     ; 236                     switch(l_code)
1096                     ; 258                       default: {break;}
1097  00f2 a064          	sub	a,#100
1098  00f4 2718          	jreq	L312
1099  00f6 a002          	sub	a,#2
1100  00f8 271a          	jreq	L512
1101  00fa a002          	sub	a,#2
1102  00fc 270a          	jreq	L112
1103  00fe a002          	sub	a,#2
1104  0100 26e3          	jrne	L733
1105                     ; 240                                   FlashMngr_GetHeaderSizeToUART(); 
1107  0102 cd0000        	call	_FlashMngr_GetHeaderSizeToUART
1109                     ; 241                                   break;
1111  0105 cc01a7        	jra	L733
1112  0108               L112:
1113                     ; 245                                   FlashMngr_ReadHeaderToUART(); 
1115  0108 cd0000        	call	_FlashMngr_ReadHeaderToUART
1117                     ; 246                                   break;
1119  010b cc01a7        	jra	L733
1120  010e               L312:
1121                     ; 250                                   FlashMngr_ReadDataToUART(); 
1123  010e cd0000        	call	_FlashMngr_ReadDataToUART
1125                     ; 251                                   break;
1127  0111 cc01a7        	jra	L733
1128  0114               L512:
1129                     ; 255                                   FlashMngr_GetOccupiedSpaceToUART(); 
1131  0114 cd0000        	call	_FlashMngr_GetOccupiedSpaceToUART
1133                     ; 256                                   break;
1135  0117 cc01a7        	jra	L733
1136                     ; 260                     break;
1138  011a               L122:
1139                     ; 264                     FlashMngr_EraseChip(); 
1141  011a cd0000        	call	_FlashMngr_EraseChip
1143                     ; 265                     break;
1145  011d cc01a7        	jra	L733
1146  0120               L322:
1147                     ; 268                     u8 l_idx = 0;
1149  0120 6b03          	ld	(OFST-4,sp),a
1151  0122               L535:
1152                     ; 270                     while(!(UART1->SR & (u8)0x20));
1154  0122 720b5230fb    	btjf	21040,#5,L535
1155                     ; 271                     l_code = UART1->DR;
1157  0127 c65231        	ld	a,21041
1158  012a 6b07          	ld	(OFST+0,sp),a
1159                     ; 272                     switch(l_code)
1162                     ; 313                       default: {break;}
1163  012c a066          	sub	a,#102
1164  012e 2705          	jreq	L745
1165  0130 4a            	dec	a
1166  0131 275b          	jreq	L722
1167  0133 2072          	jra	L733
1168  0135               L745:
1169                     ; 277                                   while(!(UART1->SR & (u8)0x20));
1171  0135 720b5230fb    	btjf	21040,#5,L745
1172                     ; 278                                   l_size = UART1->DR;
1174  013a c65231        	ld	a,21041
1175  013d 6b07          	ld	(OFST+0,sp),a
1176                     ; 279                                   tmp = l_size;
1178  013f 6b04          	ld	(OFST-3,sp),a
1180  0141               L755:
1181                     ; 281                                   while(!(UART1->SR & (u8)0x20));
1183  0141 720b5230fb    	btjf	21040,#5,L755
1184                     ; 282                                   l_address = UART1->DR;
1186  0146 c65231        	ld	a,21041
1187  0149 5f            	clrw	x
1188  014a 97            	ld	xl,a
1189  014b 1f05          	ldw	(OFST-2,sp),x
1190                     ; 283                                   l_address <<= 8;
1192  014d 7b06          	ld	a,(OFST-1,sp)
1193  014f 6b05          	ld	(OFST-2,sp),a
1194  0151 0f06          	clr	(OFST-1,sp)
1196  0153               L565:
1197                     ; 284                                   while(!(UART1->SR & (u8)0x20));
1199  0153 720b5230fb    	btjf	21040,#5,L565
1200                     ; 285                                   l_address |= UART1->DR;
1202  0158 c65231        	ld	a,21041
1203  015b 5f            	clrw	x
1204  015c 97            	ld	xl,a
1205  015d 01            	rrwa	x,a
1206  015e 1a06          	or	a,(OFST-1,sp)
1207  0160 01            	rrwa	x,a
1208  0161 1a05          	or	a,(OFST-2,sp)
1209  0163 01            	rrwa	x,a
1210  0164 1f05          	ldw	(OFST-2,sp),x
1212  0166 2012          	jra	L375
1213  0168               L106:
1214                     ; 289                                     while(!(UART1->SR & (u8)0x20));
1216  0168 720b5230fb    	btjf	21040,#5,L106
1217                     ; 290                                     buff[l_idx++] = UART1->DR;
1219  016d 7b03          	ld	a,(OFST-4,sp)
1220  016f 0c03          	inc	(OFST-4,sp)
1221  0171 5f            	clrw	x
1222  0172 97            	ld	xl,a
1223  0173 c65231        	ld	a,21041
1224  0176 e704          	ld	(_buff,x),a
1225                     ; 291                                     l_size--;
1227  0178 0a07          	dec	(OFST+0,sp)
1228  017a               L375:
1229                     ; 287                                   while(l_size > 0)
1231  017a 7b07          	ld	a,(OFST+0,sp)
1232  017c 26ea          	jrne	L106
1233                     ; 293                                   CalibData_Update(l_address, buff, tmp);
1235  017e 7b04          	ld	a,(OFST-3,sp)
1236  0180 88            	push	a
1237  0181 ae0004        	ldw	x,#_buff
1238  0184 89            	pushw	x
1239  0185 1e08          	ldw	x,(OFST+1,sp)
1240  0187 cd0000        	call	_CalibData_Update
1242  018a 5b03          	addw	sp,#3
1243                     ; 294                                   break;
1245  018c 2019          	jra	L733
1246  018e               L722:
1247                     ; 305                                   adr.word1 = (u16)(&CAL);
1249  018e ae0000        	ldw	x,#_CAL
1250  0191 1f01          	ldw	(OFST-6,sp),x
1252  0193               L116:
1253                     ; 307                                   while(!(UART1->SR & UART1_FLAG_TXE));
1255  0193 720f5230fb    	btjf	21040,#7,L116
1256                     ; 308                                   UART1->DR = adr.byte1;
1258  0198 7b01          	ld	a,(OFST-6,sp)
1259  019a c75231        	ld	21041,a
1261  019d               L126:
1262                     ; 309                                   while(!(UART1->SR & UART1_FLAG_TXE));
1264  019d 720f5230fb    	btjf	21040,#7,L126
1265                     ; 310                                   UART1->DR = adr.byte2;
1267  01a2 7b02          	ld	a,(OFST-5,sp)
1268  01a4 c75231        	ld	21041,a
1269                     ; 311                                   break;
1271                     ; 315                     break;
1273  01a7               L733:
1274                     ; 318       UART1_ITConfig(UART1_IT_RXNE, ENABLE);
1276  01a7 4b01          	push	#1
1277  01a9 ae0255        	ldw	x,#597
1278  01ac cd0000        	call	_UART1_ITConfig
1280  01af 84            	pop	a
1282  01b0 cc0002        	jra	L323
1307                     ; 322 void Power_FailDetected()
1307                     ; 323 {
1308                     .text:	section	.text,new
1309  0000               _Power_FailDetected:
1313                     ; 325   FlashMngr_DisableWriteOp();
1315  0000 cd0000        	call	_FlashMngr_DisableWriteOp
1317                     ; 326   Display_SetBrightness(0); 
1319  0003 5f            	clrw	x
1321                     ; 327 }
1324  0004 cc0000        	jp	_Display_SetBrightness
1559                     	xdef	_main
1560                     	xdef	_TASK_LogDataToFlash
1561                     	xdef	_Power_FailDetected
1562                     	xdef	_TASK_1000mS
1563                     	xdef	_TASK_UARTCommands
1564                     	switch	.ubsct
1565  0000               _msg_cb:
1566  0000 000000        	ds.b	3
1567                     	xdef	_msg_cb
1568  0003               _smsg_rx_rec:
1569  0003 00            	ds.b	1
1570                     	xdef	_smsg_rx_rec
1571  0004               _buff:
1572  0004 000000000000  	ds.b	8
1573                     	xdef	_buff
1574  000c               L7_temp_frac:
1575  000c 00            	ds.b	1
1576  000d               L5_temp_intreg:
1577  000d 00            	ds.b	1
1578                     	xdef	_CAL
1579                     	xref	_CalibData_Update
1580                     	xref	__OS_InitDelay
1581                     	xref	__OS_Task_Create
1582                     	xref.b	__OS_Tasks
1583                     	xref	_OS_Init
1584                     	xref.b	__OS_LastTask
1585                     	xref.b	__OS_BestTask
1586                     	xref.b	__OS_Best_Priority
1587                     	xref.b	__OS_CurTask
1588                     	xref.b	__OS_State
1589                     	xref.b	__OS_Temp
1590                     	xref.b	__OS_Flags
1591                     	xref	__OS_RI_INT
1592                     	xref	__OS_DI_INT
1593                     	xref	__OS_CheckEvent
1594                     	xref	__OS_EnterWaitMode
1595                     	xref	__OS_ReturnSave
1596                     	xref	__OS_JumpToTask
1597                     	xref	_FlashMngr_DisableWriteOp
1598                     	xref	_FlashMngr_ReadHeaderToUART
1599                     	xref	_FlashMngr_GetHeaderSizeToUART
1600                     	xref	_FlashMngr_GetOccupiedSpaceToUART
1601                     	xref	_FlashMngr_ReadDataToUART
1602                     	xref	_FlashMngr_GetErrors
1603                     	xref	_FlashMngr_EraseChip
1604                     	xref	_FlashMngr_StoreData
1605                     	xref	_FlashMngr_Init
1606                     	xref	_DS3231M_SetDate
1607                     	xref	_DS3231M_SetTime
1608                     	xref	_DS3231M_GetDate
1609                     	xref	_DS3231M_GetTime
1610                     	xref.b	_RTC_year
1611                     	xref.b	_RTC_month
1612                     	xref.b	_RTC_date
1613                     	xref.b	_RTC_day
1614                     	xref.b	_RTC_hour
1615                     	xref.b	_RTC_min
1616                     	xref.b	_RTC_sec
1617                     	xref	_Display_SetBrightness
1618                     	xref	_Display_SetScreen
1619                     	xref	_Display_Cyclic
1620                     	xref	_Display_Init
1621                     	xref	_DS18B20_Read_Temp
1622                     	xref	_DS18B20_All_convert
1623                     	xref	_DS18B20_All_init
1624                     	xref	_Config
1625                     	xref	_UART1_ITConfig
1626                     	switch	.CALIB
1627  000e               L371:
1628  000e 4572203100    	dc.b	"Er 1",0
1648                     	end
