   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  22                     .const:	section	.text
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
  34                     	bsct
  35  0000               L3_temperature:
  36  0000 0000          	dc.w	0
  37                     .bit:	section	.data,bit
  38  0000               L11_FLAG_temp_neg:
  39  0000 00            	dc.b	0
  40  0001               L31_FLAG_dist_samp_read:
  41  0001 00            	dc.b	0
  42  0002               L51_FLAG_dist_valid_calc:
  43  0002 00            	dc.b	0
  44  0003               L71_FLAG_rtc_settime:
  45  0003 00            	dc.b	0
  46  0004               L12_FLAG_ds18b20_err:
  47  0004 00            	dc.b	0
  48  0005               L32_FLAG_spiflash_access:
  49  0005 00            	dc.b	0
  50  0006               L52_FLAG_spiflash_write:
  51  0006 01            	dc.b	1
  52  0007               L72_FLAG_ExtFlashinit_OK:
  53  0007 00            	dc.b	0
 111                     ; 69 void main(void)
 111                     ; 70 {
 113                     .text:	section	.text,new
 114  0000               _main:
 118                     ; 71   Config();
 120  0000 cd0000        	call	_Config
 122                     ; 72   DELAY_US(1000);
 124  0003 ae03e8        	ldw	x,#1000
 126  0006               L01:
 127  0006 5a            	decw	X
 128  0007 26fd          	jrne	L01
 129  0009 9d            	nop	
 131                     ; 73   DS18B20_All_init();
 134  000a cd0000        	call	_DS18B20_All_init
 136                     ; 74   Display_Init(); 
 138  000d cd0000        	call	_Display_Init
 140                     ; 75   FlashMngr_Init();
 142  0010 cd0000        	call	_FlashMngr_Init
 144                     ; 77   FLAG_ds18b20_err = DS18B20_All_convert();
 146  0013 cd0000        	call	_DS18B20_All_convert
 148  0016 4d            	tnz	a
 149  0017 2706          	jreq	L02
 150  0019 72100004      	bset	L12_FLAG_ds18b20_err
 151  001d 2004          	jra	L42
 152  001f               L02:
 153  001f 72110004      	bres	L12_FLAG_ds18b20_err
 154  0023               L42:
 155                     ; 78   OS_Init();
 157  0023 cd0000        	call	_OS_Init
 159                     ; 80   OS_Task_Create(0, TASK_1000mS);
 161  0026 ae0000        	ldw	x,#_TASK_1000mS
 162  0029 cd00f2        	call	LC002
 163                     ; 81   OS_Task_Create(0, TASK_UARTCommands);
 166  002c ae0000        	ldw	x,#_TASK_UARTCommands
 167  002f cd00f2        	call	LC002
 168                     ; 82   OS_Task_Create(0, TASK_LogDataToFlash);
 171  0032 ae0000        	ldw	x,#_TASK_LogDataToFlash
 172  0035 cd00f2        	call	LC002
 173                     ; 83   OS_Smsg_Create(smsg_rx_rec);
 175  0038 cd0000        	call	__OS_DI_INT
 179  003b 3f03          	clr	_smsg_rx_rec
 182  003d cd0000        	call	__OS_RI_INT
 184                     ; 85   OS_EI();
 187  0040 9a            	rim	
 189  0041               L36:
 190                     ; 87   OS_Run();
 192  0041 72190000      	bres	__OS_Flags,#4
 195  0045 72160000      	bset	__OS_Flags,#3
 198  0049 35080000      	mov	__OS_Best_Priority,#8
 202  004d 450000        	mov	__OS_CurTask,__OS_LastTask
 203  0050               L76:
 206  0050 b600          	ld	a,__OS_CurTask
 207  0052 a10e          	cp	a,#__OS_Tasks+14
 208  0054 2506          	jrult	L57
 211  0056 35000000      	mov	__OS_CurTask,#__OS_Tasks
 213  005a 2006          	jra	L77
 214  005c               L57:
 217  005c b600          	ld	a,__OS_CurTask
 218  005e ab07          	add	a,#7
 219  0060 b700          	ld	__OS_CurTask,a
 220  0062               L77:
 223  0062 cd00e5        	call	LC001
 226  0065 720d000032    	btjf	__OS_State,#6,L17
 228  006a 720e00002d    	btjt	__OS_State,#7,L17
 232  006f b600          	ld	a,__OS_State
 233  0071 a407          	and	a,#7
 234  0073 b700          	ld	__OS_Temp,a
 235  0075 b100          	cp	a,__OS_Best_Priority
 236  0077 2423          	jruge	L17
 241  0079 720700003f    	btjf	__OS_State,#3,L13
 242  007e               L701:
 245  007e 7209000005    	btjf	__OS_State,#4,L311
 247  0083 720b000014    	btjf	__OS_State,#5,L17
 250  0088               L311:
 254  0088 720700000f    	btjf	__OS_State,#3,L17
 257  008d 72180000      	bset	__OS_Flags,#4
 260  0091 450000        	mov	__OS_BestTask,__OS_CurTask
 263  0094 b600          	ld	a,__OS_State
 264  0096 a407          	and	a,#7
 265  0098 b700          	ld	__OS_Best_Priority,a
 268  009a 2706          	jreq	L37
 271  009c               L17:
 274  009c b600          	ld	a,__OS_CurTask
 275  009e b100          	cp	a,__OS_LastTask
 276  00a0 26ae          	jrne	L76
 277  00a2               L37:
 280  00a2 720900009a    	btjf	__OS_Flags,#4,L36
 283  00a7 72170000      	bres	__OS_Flags,#3
 286  00ab 450000        	mov	__OS_CurTask,__OS_BestTask
 289  00ae 450000        	mov	__OS_LastTask,__OS_CurTask
 290  00b1 ad32          	call	LC001
 293  00b3 720d000089    	btjf	__OS_State,#6,L36
 295  00b8 720e000084    	btjt	__OS_State,#7,L36
 297  00bd               L13:
 301  00bd cd0000        	call	__OS_JumpToTask
 307  00c0 905f          	clrw	Y
 312  00c2 b600          	ld	A,__OS_CurTask
 317  00c4 9097          	ld	YL,A
 323  00c6 8a            	push	CC
 328  00c7 320000        	pop	__OS_Temp
 333  00ca 9b            	sim	
 338  00cb 90f6          	ld	A,(Y)
 343  00cd a4d7          	and	A,#0xD7
 348  00cf 90f7          	ld	(Y),A
 353  00d1 a628          	ld	A,#0x28
 358  00d3 b400          	and	A,__OS_State
 363  00d5 90fa          	or	A,(Y)
 368  00d7 90f7          	ld	(Y),A
 373  00d9 3b0000        	push	__OS_Temp
 378  00dc 86            	pop	CC
 383  00dd 720600009c    	btjt	__OS_Flags,#3,L701
 386  00e2 cc0041        	jra	L36
 387  00e5               LC001:
 388  00e5 ae0000        	ldw	x,#__OS_State
 389  00e8 b600          	ld	a,__OS_CurTask
 390  00ea 905f          	clrw	y
 391  00ec 9097          	ld	yl,a
 392  00ee 90f6          	ld	a,(y)
 393  00f0 f7            	ld	(x),a
 394  00f1 81            	ret	
 395  00f2               LC002:
 396  00f2 89            	pushw	x
 397  00f3 4f            	clr	a
 398  00f4 cd0000        	call	__OS_Task_Create
 400  00f7 85            	popw	x
 401  00f8 81            	ret	
 438                     ; 90 void TASK_LogDataToFlash()
 438                     ; 91 {
 439                     .text:	section	.text,new
 440  0000               _TASK_LogDataToFlash:
 444  0000               L531:
 445                     ; 94     OS_Delay(CAL.DataLogInterval);
 447  0000 ce0008        	ldw	x,_CAL+8
 448  0003 cd0000        	call	__OS_InitDelay
 452  0006 cd0000        	call	__OS_ReturnSave
 454                     ; 95     buff[0] = (u8)temp_intreg;
 457  0009 450d04        	mov	_buff,L5_temp_intreg
 458                     ; 96     buff[1] = (u8)temp_frac;
 460  000c 450c05        	mov	_buff+1,L7_temp_frac
 461                     ; 97     buff[2] = (u8)RTC_hour;
 463  000f 450006        	mov	_buff+2,_RTC_hour
 464                     ; 98     buff[3] = (u8)RTC_min;
 466  0012 450007        	mov	_buff+3,_RTC_min
 467                     ; 99     buff[4] = (u8)RTC_sec;
 469  0015 450008        	mov	_buff+4,_RTC_sec
 470                     ; 100     buff[5] = (u8)RTC_day;
 472  0018 450009        	mov	_buff+5,_RTC_day
 473                     ; 101     buff[6] = (u8)RTC_month;
 475  001b 45000a        	mov	_buff+6,_RTC_month
 476                     ; 102     buff[7] = (u8)RTC_year;
 478                     ; 103     FlashMngr_StoreData(buff, 8);
 480  001e ae0008        	ldw	x,#8
 481  0021 45000b        	mov	_buff+7,_RTC_year
 482  0024 89            	pushw	x
 483  0025 ae0004        	ldw	x,#_buff
 484  0028 cd0000        	call	_FlashMngr_StoreData
 486  002b 85            	popw	x
 488  002c 20d2          	jra	L531
 541                     ; 107 void TASK_1000mS()
 541                     ; 108 {
 542                     .text:	section	.text,new
 543  0000               _TASK_1000mS:
 545  0000 5205          	subw	sp,#5
 546       00000005      OFST:	set	5
 549  0002               L751:
 550                     ; 112     OS_Delay(500);      // Wait 1000 ms
 552  0002 ae01f4        	ldw	x,#500
 553  0005 cd0000        	call	__OS_InitDelay
 557  0008 cd0000        	call	__OS_ReturnSave
 559                     ; 113     DS18B20_Read_Temp(&temperature, CAL.ROM_ID1);
 562  000b ae0000        	ldw	x,#_CAL
 563  000e 89            	pushw	x
 564  000f ae0000        	ldw	x,#L3_temperature
 565  0012 cd0000        	call	_DS18B20_Read_Temp
 567  0015 85            	popw	x
 568                     ; 114     DS3231M_GetTime();
 570  0016 cd0000        	call	_DS3231M_GetTime
 572                     ; 115     DS3231M_GetDate();
 574  0019 cd0000        	call	_DS3231M_GetDate
 576                     ; 117     tempdisp[0] = (char)((u8)((RTC_hour & 0xF0)>>4) + (u8)48);
 578  001c b600          	ld	a,_RTC_hour
 579  001e 4e            	swap	a
 580  001f a40f          	and	a,#15
 581  0021 ab30          	add	a,#48
 582  0023 6b01          	ld	(OFST-4,sp),a
 583                     ; 118     tempdisp[1] = (char)((u8)(RTC_hour & 0x0F) + (u8)48);
 585  0025 b600          	ld	a,_RTC_hour
 586  0027 a40f          	and	a,#15
 587  0029 ab30          	add	a,#48
 588  002b 6b02          	ld	(OFST-3,sp),a
 589                     ; 119     tempdisp[2] = (char)((u8)((RTC_min & 0xF0)>>4) + (u8)48);
 591  002d b600          	ld	a,_RTC_min
 592  002f 4e            	swap	a
 593  0030 a40f          	and	a,#15
 594  0032 ab30          	add	a,#48
 595  0034 6b03          	ld	(OFST-2,sp),a
 596                     ; 120     tempdisp[3] = (char)((u8)(RTC_min & 0x0F) + (u8)48);
 598  0036 b600          	ld	a,_RTC_min
 599  0038 a40f          	and	a,#15
 600  003a ab30          	add	a,#48
 601  003c 6b04          	ld	(OFST-1,sp),a
 602                     ; 121     tempdisp[4] = 0;
 604  003e 0f05          	clr	(OFST+0,sp)
 605                     ; 122     Display_SetScreen(0,  tempdisp, COMMAPOS2);
 607  0040 4b02          	push	#2
 608  0042 96            	ldw	x,sp
 609  0043 1c0002        	addw	x,#OFST-3
 610  0046 89            	pushw	x
 611  0047 4f            	clr	a
 612  0048 cd0000        	call	_Display_SetScreen
 614  004b 5b03          	addw	sp,#3
 615                     ; 123     if(temperature < 0)
 617  004d be00          	ldw	x,L3_temperature
 618  004f 2a09          	jrpl	L361
 619                     ; 125       temperature = -(temperature);
 621  0051 50            	negw	x
 622  0052 bf00          	ldw	L3_temperature,x
 623                     ; 126       FLAG_temp_neg = TRUE;
 625  0054 72100000      	bset	L11_FLAG_temp_neg
 627  0058 2004          	jra	L561
 628  005a               L361:
 629                     ; 130       FLAG_temp_neg = FALSE;
 631  005a 72110000      	bres	L11_FLAG_temp_neg
 632  005e               L561:
 633                     ; 132     temp_intreg = (u8)(temperature>>4);
 635  005e 57            	sraw	x
 636  005f 57            	sraw	x
 637  0060 57            	sraw	x
 638  0061 57            	sraw	x
 639  0062 9f            	ld	a,xl
 640  0063 b70d          	ld	L5_temp_intreg,a
 641                     ; 133     temp_frac = (u8)(temperature - (temp_intreg<<4));
 643  0065 a610          	ld	a,#16
 644  0067 42            	mul	x,a
 645  0068 9f            	ld	a,xl
 646  0069 b001          	sub	a,L3_temperature+1
 647  006b 40            	neg	a
 648                     ; 135     temp_frac *= 10;  //(temp_frac * 10) / 16  Scale to [0-9]
 650  006c ae000a        	ldw	x,#10
 651  006f 42            	mul	x,a
 652  0070 9f            	ld	a,xl
 653                     ; 136     temp_frac >>= 4;
 655  0071 4e            	swap	a
 656  0072 a40f          	and	a,#15
 657  0074 b70c          	ld	L7_temp_frac,a
 658                     ; 138     tempdisp[0] = (char)((u8)((temp_intreg)/10) + (u8)48);
 660  0076 5f            	clrw	x
 661  0077 b60d          	ld	a,L5_temp_intreg
 662  0079 97            	ld	xl,a
 663  007a a60a          	ld	a,#10
 664  007c 62            	div	x,a
 665  007d 9f            	ld	a,xl
 666  007e ab30          	add	a,#48
 667  0080 6b01          	ld	(OFST-4,sp),a
 668                     ; 139     tempdisp[1] = (char)((u8)((temp_intreg)%10) + (u8)48);
 670  0082 5f            	clrw	x
 671  0083 b60d          	ld	a,L5_temp_intreg
 672  0085 97            	ld	xl,a
 673  0086 a60a          	ld	a,#10
 674  0088 62            	div	x,a
 675  0089 ab30          	add	a,#48
 676  008b 6b02          	ld	(OFST-3,sp),a
 677                     ; 140     tempdisp[2] = (char)((u8)temp_frac + (u8)48);
 679  008d b60c          	ld	a,L7_temp_frac
 680  008f ab30          	add	a,#48
 681  0091 6b03          	ld	(OFST-2,sp),a
 682                     ; 141     tempdisp[3] = 'c';
 684  0093 a663          	ld	a,#99
 685  0095 6b04          	ld	(OFST-1,sp),a
 686                     ; 142     tempdisp[4] = 0;
 688  0097 0f05          	clr	(OFST+0,sp)
 689                     ; 143     Display_SetScreen(1,  tempdisp, COMMAPOS2);
 691  0099 4b02          	push	#2
 692  009b 96            	ldw	x,sp
 693  009c 1c0002        	addw	x,#OFST-3
 694  009f 89            	pushw	x
 695  00a0 a601          	ld	a,#1
 696  00a2 cd0000        	call	_Display_SetScreen
 698  00a5 5b03          	addw	sp,#3
 699                     ; 144     FLAG_ds18b20_err = DS18B20_All_convert();    /* issue DS18B20 convert command, to read the results after 1s */
 701  00a7 cd0000        	call	_DS18B20_All_convert
 703  00aa 4d            	tnz	a
 704  00ab 2706          	jreq	L47
 705  00ad 72100004      	bset	L12_FLAG_ds18b20_err
 706  00b1 2004          	jra	L001
 707  00b3               L47:
 708  00b3 72110004      	bres	L12_FLAG_ds18b20_err
 709  00b7               L001:
 710                     ; 146     if(FlashMngr_GetErrors() != 0)
 712  00b7 cd0000        	call	_FlashMngr_GetErrors
 714  00ba 4d            	tnz	a
 715  00bb 270d          	jreq	L761
 716                     ; 148       Display_SetScreen(2, "Er 1", NOCOMMA);
 718  00bd 4b00          	push	#0
 719  00bf ae000c        	ldw	x,#L171
 720  00c2 89            	pushw	x
 721  00c3 a602          	ld	a,#2
 722  00c5 cd0000        	call	_Display_SetScreen
 724  00c8 5b03          	addw	sp,#3
 725  00ca               L761:
 726                     ; 151     Display_SetBrightness(CAL.Display_Brightness);
 728  00ca ce000a        	ldw	x,_CAL+10
 729  00cd cd0000        	call	_Display_SetBrightness
 731                     ; 152     Display_Cyclic();
 733  00d0 cd0000        	call	_Display_Cyclic
 736  00d3 cc0002        	jra	L751
 876                     ; 156 void TASK_UARTCommands()
 876                     ; 157 {
 877                     .text:	section	.text,new
 878  0000               _TASK_UARTCommands:
 880  0000 5207          	subw	sp,#7
 881       00000007      OFST:	set	7
 884  0002               L123:
 885                     ; 163       OS_Smsg_Wait(smsg_rx_rec, rcvd_message);
 887  0002 cd0000        	call	__OS_EnterWaitMode
 891  0005 b603          	ld	a,_smsg_rx_rec
 892  0007 2702          	jreq	L021
 893  0009 a601          	ld	a,#1
 894  000b               L021:
 895  000b cd0000        	call	__OS_CheckEvent
 900  000e cd0000        	call	__OS_DI_INT
 904  0011 b603          	ld	a,_smsg_rx_rec
 905  0013 272e          	jreq	L523
 909  0015 6b07          	ld	(OFST+0,sp),a
 912  0017 3f03          	clr	_smsg_rx_rec
 915  0019 cd0000        	call	__OS_RI_INT
 917                     ; 164       UART1_ITConfig(UART1_IT_RXNE, DISABLE);
 919  001c 4b00          	push	#0
 920  001e ae0255        	ldw	x,#597
 921  0021 cd0000        	call	_UART1_ITConfig
 923  0024 84            	pop	a
 924                     ; 165       switch(rcvd_message)
 926  0025 7b07          	ld	a,(OFST+0,sp)
 928                     ; 306                     break;
 929  0027 a063          	sub	a,#99
 930  0029 2603cc0120    	jreq	L122
 931  002e a002          	sub	a,#2
 932  0030 2603cc011a    	jreq	L712
 933  0035 a00d          	sub	a,#13
 934  0037 2603cc00e8    	jreq	L715
 935  003c a002          	sub	a,#2
 936  003e 2708          	jreq	L143
 937  0040 cc01a7        	jra	L533
 938  0043               L523:
 939                     ; 163       OS_Smsg_Wait(smsg_rx_rec, rcvd_message);
 941  0043 cd0000        	call	__OS_RI_INT
 944  0046 20ba          	jra	L123
 945  0048               L143:
 946                     ; 170                     while(!(UART1->SR & (u8)0x20));
 948  0048 720b5230fb    	btjf	21040,#5,L143
 949                     ; 171                     l_code = UART1->DR;
 951  004d c65231        	ld	a,21041
 952  0050 6b07          	ld	(OFST+0,sp),a
 953                     ; 172                     switch(l_code)
 956                     ; 219                       default: {break;}
 957  0052 a067          	sub	a,#103
 958  0054 2753          	jreq	L144
 959  0056 a00c          	sub	a,#12
 960  0058 26e6          	jrne	L533
 961  005a               L353:
 962                     ; 178                                   while(!(UART1->SR & (u8)0x20));
 964  005a 720b5230fb    	btjf	21040,#5,L353
 965                     ; 179                                   RTC_sec = UART1->DR;
 967  005f 5552310000    	mov	_RTC_sec,21041
 969  0064               L363:
 970                     ; 181                                   while(!(UART1->SR & (u8)0x20));
 972  0064 720b5230fb    	btjf	21040,#5,L363
 973                     ; 182                                   RTC_min = UART1->DR;
 975  0069 5552310000    	mov	_RTC_min,21041
 977  006e               L373:
 978                     ; 184                                   while(!(UART1->SR & (u8)0x20));
 980  006e 720b5230fb    	btjf	21040,#5,L373
 981                     ; 185                                   RTC_hour = UART1->DR;
 983  0073 5552310000    	mov	_RTC_hour,21041
 985  0078               L304:
 986                     ; 187                                   while(!(UART1->SR & (u8)0x20));
 988  0078 720b5230fb    	btjf	21040,#5,L304
 989                     ; 188                                   RTC_day = UART1->DR;
 991  007d 5552310000    	mov	_RTC_day,21041
 993  0082               L314:
 994                     ; 190                                   while(!(UART1->SR & (u8)0x20));
 996  0082 720b5230fb    	btjf	21040,#5,L314
 997                     ; 191                                   RTC_date = UART1->DR;
 999  0087 5552310000    	mov	_RTC_date,21041
1001  008c               L324:
1002                     ; 193                                   while(!(UART1->SR & (u8)0x20));
1004  008c 720b5230fb    	btjf	21040,#5,L324
1005                     ; 194                                   RTC_month = UART1->DR;
1007  0091 5552310000    	mov	_RTC_month,21041
1009  0096               L334:
1010                     ; 196                                   while(!(UART1->SR & (u8)0x20));
1012  0096 720b5230fb    	btjf	21040,#5,L334
1013                     ; 197                                   RTC_year = UART1->DR;
1015  009b 5552310000    	mov	_RTC_year,21041
1016                     ; 198                                   DS3231M_SetTime();
1018  00a0 cd0000        	call	_DS3231M_SetTime
1020                     ; 199                                   DS3231M_SetDate();
1022  00a3 cd0000        	call	_DS3231M_SetDate
1024                     ; 200                                   break;
1026  00a6 cc01a7        	jra	L533
1027  00a9               L144:
1028                     ; 205                                   while(!(UART1->SR & UART1_FLAG_TXE));
1030  00a9 720f5230fb    	btjf	21040,#7,L144
1031                     ; 206                                   UART1->DR = RTC_hour;
1033  00ae 5500005231    	mov	21041,_RTC_hour
1035  00b3               L154:
1036                     ; 207                                   while(!(UART1->SR & UART1_FLAG_TXE));
1038  00b3 720f5230fb    	btjf	21040,#7,L154
1039                     ; 208                                   UART1->DR = RTC_min;
1041  00b8 5500005231    	mov	21041,_RTC_min
1043  00bd               L164:
1044                     ; 209                                   while(!(UART1->SR & UART1_FLAG_TXE));
1046  00bd 720f5230fb    	btjf	21040,#7,L164
1047                     ; 210                                   UART1->DR = RTC_sec;
1049  00c2 5500005231    	mov	21041,_RTC_sec
1051  00c7               L174:
1052                     ; 211                                   while(!(UART1->SR & UART1_FLAG_TXE));
1054  00c7 720f5230fb    	btjf	21040,#7,L174
1055                     ; 212                                   UART1->DR = RTC_date;
1057  00cc 5500005231    	mov	21041,_RTC_date
1059  00d1               L105:
1060                     ; 213                                   while(!(UART1->SR & UART1_FLAG_TXE));
1062  00d1 720f5230fb    	btjf	21040,#7,L105
1063                     ; 214                                   UART1->DR = RTC_month;
1065  00d6 5500005231    	mov	21041,_RTC_month
1067  00db               L115:
1068                     ; 215                                   while(!(UART1->SR & UART1_FLAG_TXE));
1070  00db 720f5230fb    	btjf	21040,#7,L115
1071                     ; 216                                   UART1->DR = RTC_year;
1073  00e0 5500005231    	mov	21041,_RTC_year
1074                     ; 217                                   break;
1076  00e5 cc01a7        	jra	L533
1077                     ; 221                     break;
1079  00e8               L715:
1080                     ; 225                     while(!(UART1->SR & (u8)0x20));
1082  00e8 720b5230fb    	btjf	21040,#5,L715
1083                     ; 226                     l_code = UART1->DR;
1085  00ed c65231        	ld	a,21041
1086  00f0 6b07          	ld	(OFST+0,sp),a
1087                     ; 227                     switch(l_code)
1090                     ; 249                       default: {break;}
1091  00f2 a064          	sub	a,#100
1092  00f4 2718          	jreq	L112
1093  00f6 a002          	sub	a,#2
1094  00f8 271a          	jreq	L312
1095  00fa a002          	sub	a,#2
1096  00fc 270a          	jreq	L702
1097  00fe a002          	sub	a,#2
1098  0100 26e3          	jrne	L533
1099                     ; 231                                   FlashMngr_GetHeaderSizeToUART(); 
1101  0102 cd0000        	call	_FlashMngr_GetHeaderSizeToUART
1103                     ; 232                                   break;
1105  0105 cc01a7        	jra	L533
1106  0108               L702:
1107                     ; 236                                   FlashMngr_ReadHeaderToUART(); 
1109  0108 cd0000        	call	_FlashMngr_ReadHeaderToUART
1111                     ; 237                                   break;
1113  010b cc01a7        	jra	L533
1114  010e               L112:
1115                     ; 241                                   FlashMngr_ReadDataToUART(); 
1117  010e cd0000        	call	_FlashMngr_ReadDataToUART
1119                     ; 242                                   break;
1121  0111 cc01a7        	jra	L533
1122  0114               L312:
1123                     ; 246                                   FlashMngr_GetOccupiedSpaceToUART(); 
1125  0114 cd0000        	call	_FlashMngr_GetOccupiedSpaceToUART
1127                     ; 247                                   break;
1129  0117 cc01a7        	jra	L533
1130                     ; 251                     break;
1132  011a               L712:
1133                     ; 255                     FlashMngr_EraseChip(); 
1135  011a cd0000        	call	_FlashMngr_EraseChip
1137                     ; 256                     break;
1139  011d cc01a7        	jra	L533
1140  0120               L122:
1141                     ; 259                     u8 l_idx = 0;
1143  0120 6b03          	ld	(OFST-4,sp),a
1145  0122               L335:
1146                     ; 261                     while(!(UART1->SR & (u8)0x20));
1148  0122 720b5230fb    	btjf	21040,#5,L335
1149                     ; 262                     l_code = UART1->DR;
1151  0127 c65231        	ld	a,21041
1152  012a 6b07          	ld	(OFST+0,sp),a
1153                     ; 263                     switch(l_code)
1156                     ; 304                       default: {break;}
1157  012c a066          	sub	a,#102
1158  012e 2705          	jreq	L545
1159  0130 4a            	dec	a
1160  0131 275b          	jreq	L522
1161  0133 2072          	jra	L533
1162  0135               L545:
1163                     ; 268                                   while(!(UART1->SR & (u8)0x20));
1165  0135 720b5230fb    	btjf	21040,#5,L545
1166                     ; 269                                   l_size = UART1->DR;
1168  013a c65231        	ld	a,21041
1169  013d 6b07          	ld	(OFST+0,sp),a
1170                     ; 270                                   tmp = l_size;
1172  013f 6b04          	ld	(OFST-3,sp),a
1174  0141               L555:
1175                     ; 272                                   while(!(UART1->SR & (u8)0x20));
1177  0141 720b5230fb    	btjf	21040,#5,L555
1178                     ; 273                                   l_address = UART1->DR;
1180  0146 c65231        	ld	a,21041
1181  0149 5f            	clrw	x
1182  014a 97            	ld	xl,a
1183  014b 1f05          	ldw	(OFST-2,sp),x
1184                     ; 274                                   l_address <<= 8;
1186  014d 7b06          	ld	a,(OFST-1,sp)
1187  014f 6b05          	ld	(OFST-2,sp),a
1188  0151 0f06          	clr	(OFST-1,sp)
1190  0153               L365:
1191                     ; 275                                   while(!(UART1->SR & (u8)0x20));
1193  0153 720b5230fb    	btjf	21040,#5,L365
1194                     ; 276                                   l_address |= UART1->DR;
1196  0158 c65231        	ld	a,21041
1197  015b 5f            	clrw	x
1198  015c 97            	ld	xl,a
1199  015d 01            	rrwa	x,a
1200  015e 1a06          	or	a,(OFST-1,sp)
1201  0160 01            	rrwa	x,a
1202  0161 1a05          	or	a,(OFST-2,sp)
1203  0163 01            	rrwa	x,a
1204  0164 1f05          	ldw	(OFST-2,sp),x
1206  0166 2012          	jra	L175
1207  0168               L775:
1208                     ; 280                                     while(!(UART1->SR & (u8)0x20));
1210  0168 720b5230fb    	btjf	21040,#5,L775
1211                     ; 281                                     buff[l_idx++] = UART1->DR;
1213  016d 7b03          	ld	a,(OFST-4,sp)
1214  016f 0c03          	inc	(OFST-4,sp)
1215  0171 5f            	clrw	x
1216  0172 97            	ld	xl,a
1217  0173 c65231        	ld	a,21041
1218  0176 e704          	ld	(_buff,x),a
1219                     ; 282                                     l_size--;
1221  0178 0a07          	dec	(OFST+0,sp)
1222  017a               L175:
1223                     ; 278                                   while(l_size > 0)
1225  017a 7b07          	ld	a,(OFST+0,sp)
1226  017c 26ea          	jrne	L775
1227                     ; 284                                   CalibData_Update(l_address, buff, tmp);
1229  017e 7b04          	ld	a,(OFST-3,sp)
1230  0180 88            	push	a
1231  0181 ae0004        	ldw	x,#_buff
1232  0184 89            	pushw	x
1233  0185 1e08          	ldw	x,(OFST+1,sp)
1234  0187 cd0000        	call	_CalibData_Update
1236  018a 5b03          	addw	sp,#3
1237                     ; 285                                   break;
1239  018c 2019          	jra	L533
1240  018e               L522:
1241                     ; 296                                   adr.word1 = (u16)(&CAL);
1243  018e ae0000        	ldw	x,#_CAL
1244  0191 1f01          	ldw	(OFST-6,sp),x
1246  0193               L706:
1247                     ; 298                                   while(!(UART1->SR & UART1_FLAG_TXE));
1249  0193 720f5230fb    	btjf	21040,#7,L706
1250                     ; 299                                   UART1->DR = adr.byte1;
1252  0198 7b01          	ld	a,(OFST-6,sp)
1253  019a c75231        	ld	21041,a
1255  019d               L716:
1256                     ; 300                                   while(!(UART1->SR & UART1_FLAG_TXE));
1258  019d 720f5230fb    	btjf	21040,#7,L716
1259                     ; 301                                   UART1->DR = adr.byte2;
1261  01a2 7b02          	ld	a,(OFST-5,sp)
1262  01a4 c75231        	ld	21041,a
1263                     ; 302                                   break;
1265                     ; 306                     break;
1267  01a7               L533:
1268                     ; 309       UART1_ITConfig(UART1_IT_RXNE, ENABLE);
1270  01a7 4b01          	push	#1
1271  01a9 ae0255        	ldw	x,#597
1272  01ac cd0000        	call	_UART1_ITConfig
1274  01af 84            	pop	a
1276  01b0 cc0002        	jra	L123
1301                     ; 313 void Power_FailDetected()
1301                     ; 314 {
1302                     .text:	section	.text,new
1303  0000               _Power_FailDetected:
1307                     ; 316   FlashMngr_DisableWriteOp();
1309  0000 cd0000        	call	_FlashMngr_DisableWriteOp
1311                     ; 317   Display_SetBrightness(0); 
1313  0003 5f            	clrw	x
1315                     ; 318 }
1318  0004 cc0000        	jp	_Display_SetBrightness
1539                     	xdef	_main
1540                     	xdef	_TASK_LogDataToFlash
1541                     	xdef	_Power_FailDetected
1542                     	xdef	_TASK_1000mS
1543                     	xdef	_TASK_UARTCommands
1544                     	switch	.ubsct
1545  0000               _msg_cb:
1546  0000 000000        	ds.b	3
1547                     	xdef	_msg_cb
1548  0003               _smsg_rx_rec:
1549  0003 00            	ds.b	1
1550                     	xdef	_smsg_rx_rec
1551  0004               _buff:
1552  0004 000000000000  	ds.b	8
1553                     	xdef	_buff
1554  000c               L7_temp_frac:
1555  000c 00            	ds.b	1
1556  000d               L5_temp_intreg:
1557  000d 00            	ds.b	1
1558                     	xdef	_CAL
1559                     	xref	_CalibData_Update
1560                     	xref	__OS_InitDelay
1561                     	xref	__OS_Task_Create
1562                     	xref.b	__OS_Tasks
1563                     	xref	_OS_Init
1564                     	xref.b	__OS_LastTask
1565                     	xref.b	__OS_BestTask
1566                     	xref.b	__OS_Best_Priority
1567                     	xref.b	__OS_CurTask
1568                     	xref.b	__OS_State
1569                     	xref.b	__OS_Temp
1570                     	xref.b	__OS_Flags
1571                     	xref	__OS_RI_INT
1572                     	xref	__OS_DI_INT
1573                     	xref	__OS_CheckEvent
1574                     	xref	__OS_EnterWaitMode
1575                     	xref	__OS_ReturnSave
1576                     	xref	__OS_JumpToTask
1577                     	xref	_FlashMngr_DisableWriteOp
1578                     	xref	_FlashMngr_ReadHeaderToUART
1579                     	xref	_FlashMngr_GetHeaderSizeToUART
1580                     	xref	_FlashMngr_GetOccupiedSpaceToUART
1581                     	xref	_FlashMngr_ReadDataToUART
1582                     	xref	_FlashMngr_GetErrors
1583                     	xref	_FlashMngr_EraseChip
1584                     	xref	_FlashMngr_StoreData
1585                     	xref	_FlashMngr_Init
1586                     	xref	_DS3231M_SetDate
1587                     	xref	_DS3231M_SetTime
1588                     	xref	_DS3231M_GetDate
1589                     	xref	_DS3231M_GetTime
1590                     	xref.b	_RTC_year
1591                     	xref.b	_RTC_month
1592                     	xref.b	_RTC_date
1593                     	xref.b	_RTC_day
1594                     	xref.b	_RTC_hour
1595                     	xref.b	_RTC_min
1596                     	xref.b	_RTC_sec
1597                     	xref	_Display_SetBrightness
1598                     	xref	_Display_SetScreen
1599                     	xref	_Display_Cyclic
1600                     	xref	_Display_Init
1601                     	xref	_DS18B20_Read_Temp
1602                     	xref	_DS18B20_All_convert
1603                     	xref	_DS18B20_All_init
1604                     	xref	_Config
1605                     	xref	_UART1_ITConfig
1606                     	switch	.const
1607  000c               L171:
1608  000c 4572203100    	dc.b	"Er 1",0
1628                     	end
