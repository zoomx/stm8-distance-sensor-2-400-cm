   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  20                     	bsct
  21  0000               L3_temperature:
  22  0000 0000          	dc.w	0
  23                     .bit:	section	.data,bit
  24  0000               L11_FLAG_temp_neg:
  25  0000 00            	dc.b	0
  26  0001               L31_FLAG_dist_samp_read:
  27  0001 00            	dc.b	0
  28  0002               L51_FLAG_dist_valid_calc:
  29  0002 00            	dc.b	0
  30  0003               L71_FLAG_rtc_settime:
  31  0003 00            	dc.b	0
  32  0004               L12_FLAG_ds18b20_err:
  33  0004 00            	dc.b	0
  34  0005               L32_FLAG_spiflash_access:
  35  0005 00            	dc.b	0
  36  0006               L52_FLAG_spiflash_write:
  37  0006 01            	dc.b	1
  38  0007               L72_FLAG_ExtFlashinit_OK:
  39  0007 00            	dc.b	0
  99                     ; 67 void main(void)
  99                     ; 68 {
 101                     .text:	section	.text,new
 102  0000               _main:
 106                     ; 69   Config();
 108  0000 cd0000        	call	_Config
 110                     ; 70   DELAY_US(1000);
 112  0003 ae03e8        	ldw	x,#1000
 114  0006               L01:
 115  0006 5a            	decw	X
 116  0007 26fd          	jrne	L01
 117  0009 9d            	nop	
 119                     ; 81   DS18B20_All_init();
 122  000a cd0000        	call	_DS18B20_All_init
 124                     ; 82   Display_Init();
 126  000d cd0000        	call	_Display_Init
 128                     ; 83   Display_SetBrightness(CAL.Display_Brightness);  
 130  0010 ce000a        	ldw	x,_CAL+10
 131  0013 cd0000        	call	_Display_SetBrightness
 133                     ; 84   FlashMngr_Init();
 135  0016 cd0000        	call	_FlashMngr_Init
 137                     ; 86   FLAG_ds18b20_err = DS18B20_All_convert();
 139  0019 cd0000        	call	_DS18B20_All_convert
 141  001c 4d            	tnz	a
 142  001d 2706          	jreq	L22
 143  001f 72100004      	bset	L12_FLAG_ds18b20_err
 144  0023 2004          	jra	L62
 145  0025               L22:
 146  0025 72110004      	bres	L12_FLAG_ds18b20_err
 147  0029               L62:
 148                     ; 87   OS_Init();
 150  0029 cd0000        	call	_OS_Init
 152                     ; 89   OS_Task_Create(0, TASK_1000mS);
 154  002c ae0000        	ldw	x,#_TASK_1000mS
 155  002f cd00f8        	call	LC002
 156                     ; 90   OS_Task_Create(0, TASK_UARTCommands);
 159  0032 ae0000        	ldw	x,#_TASK_UARTCommands
 160  0035 cd00f8        	call	LC002
 161                     ; 91   OS_Task_Create(0, TASK_LogDataToFlash);
 164  0038 ae0000        	ldw	x,#_TASK_LogDataToFlash
 165  003b cd00f8        	call	LC002
 166                     ; 92   OS_Smsg_Create(smsg_rx_rec);
 168  003e cd0000        	call	__OS_DI_INT
 172  0041 3f03          	clr	_smsg_rx_rec
 175  0043 cd0000        	call	__OS_RI_INT
 177                     ; 94   OS_EI();
 180  0046 9a            	rim	
 182  0047               L36:
 183                     ; 96   OS_Run();
 185  0047 72190000      	bres	__OS_Flags,#4
 188  004b 72160000      	bset	__OS_Flags,#3
 191  004f 35080000      	mov	__OS_Best_Priority,#8
 195  0053 450000        	mov	__OS_CurTask,__OS_LastTask
 196  0056               L76:
 199  0056 b600          	ld	a,__OS_CurTask
 200  0058 a10e          	cp	a,#__OS_Tasks+14
 201  005a 2506          	jrult	L57
 204  005c 35000000      	mov	__OS_CurTask,#__OS_Tasks
 206  0060 2006          	jra	L77
 207  0062               L57:
 210  0062 b600          	ld	a,__OS_CurTask
 211  0064 ab07          	add	a,#7
 212  0066 b700          	ld	__OS_CurTask,a
 213  0068               L77:
 216  0068 cd00eb        	call	LC001
 219  006b 720d000032    	btjf	__OS_State,#6,L17
 221  0070 720e00002d    	btjt	__OS_State,#7,L17
 225  0075 b600          	ld	a,__OS_State
 226  0077 a407          	and	a,#7
 227  0079 b700          	ld	__OS_Temp,a
 228  007b b100          	cp	a,__OS_Best_Priority
 229  007d 2423          	jruge	L17
 234  007f 720700003f    	btjf	__OS_State,#3,L13
 235  0084               L701:
 238  0084 7209000005    	btjf	__OS_State,#4,L311
 240  0089 720b000014    	btjf	__OS_State,#5,L17
 243  008e               L311:
 247  008e 720700000f    	btjf	__OS_State,#3,L17
 250  0093 72180000      	bset	__OS_Flags,#4
 253  0097 450000        	mov	__OS_BestTask,__OS_CurTask
 256  009a b600          	ld	a,__OS_State
 257  009c a407          	and	a,#7
 258  009e b700          	ld	__OS_Best_Priority,a
 261  00a0 2706          	jreq	L37
 264  00a2               L17:
 267  00a2 b600          	ld	a,__OS_CurTask
 268  00a4 b100          	cp	a,__OS_LastTask
 269  00a6 26ae          	jrne	L76
 270  00a8               L37:
 273  00a8 720900009a    	btjf	__OS_Flags,#4,L36
 276  00ad 72170000      	bres	__OS_Flags,#3
 279  00b1 450000        	mov	__OS_CurTask,__OS_BestTask
 282  00b4 450000        	mov	__OS_LastTask,__OS_CurTask
 283  00b7 ad32          	call	LC001
 286  00b9 720d000089    	btjf	__OS_State,#6,L36
 288  00be 720e000084    	btjt	__OS_State,#7,L36
 290  00c3               L13:
 294  00c3 cd0000        	call	__OS_JumpToTask
 300  00c6 905f          	clrw	Y
 305  00c8 b600          	ld	A,__OS_CurTask
 310  00ca 9097          	ld	YL,A
 316  00cc 8a            	push	CC
 321  00cd 320000        	pop	__OS_Temp
 326  00d0 9b            	sim	
 331  00d1 90f6          	ld	A,(Y)
 336  00d3 a4d7          	and	A,#0xD7
 341  00d5 90f7          	ld	(Y),A
 346  00d7 a628          	ld	A,#0x28
 351  00d9 b400          	and	A,__OS_State
 356  00db 90fa          	or	A,(Y)
 361  00dd 90f7          	ld	(Y),A
 366  00df 3b0000        	push	__OS_Temp
 371  00e2 86            	pop	CC
 376  00e3 720600009c    	btjt	__OS_Flags,#3,L701
 379  00e8 cc0047        	jra	L36
 380  00eb               LC001:
 381  00eb ae0000        	ldw	x,#__OS_State
 382  00ee b600          	ld	a,__OS_CurTask
 383  00f0 905f          	clrw	y
 384  00f2 9097          	ld	yl,a
 385  00f4 90f6          	ld	a,(y)
 386  00f6 f7            	ld	(x),a
 387  00f7 81            	ret	
 388  00f8               LC002:
 389  00f8 89            	pushw	x
 390  00f9 4f            	clr	a
 391  00fa cd0000        	call	__OS_Task_Create
 393  00fd 85            	popw	x
 394  00fe 81            	ret	
 431                     ; 99 void TASK_LogDataToFlash()
 431                     ; 100 {
 432                     .text:	section	.text,new
 433  0000               _TASK_LogDataToFlash:
 437  0000               L531:
 438                     ; 103     OS_Delay(CAL.DataLogInterval);
 440  0000 ce0008        	ldw	x,_CAL+8
 441  0003 cd0000        	call	__OS_InitDelay
 445  0006 cd0000        	call	__OS_ReturnSave
 447                     ; 104     buff[0] = (u8)temp_intreg;
 450  0009 450d04        	mov	_buff,L5_temp_intreg
 451                     ; 105     buff[1] = (u8)temp_frac;
 453  000c 450c05        	mov	_buff+1,L7_temp_frac
 454                     ; 106     buff[2] = (u8)RTC_hour;
 456  000f 450006        	mov	_buff+2,_RTC_hour
 457                     ; 107     buff[3] = (u8)RTC_min;
 459  0012 450007        	mov	_buff+3,_RTC_min
 460                     ; 108     buff[4] = (u8)RTC_sec;
 462  0015 450008        	mov	_buff+4,_RTC_sec
 463                     ; 109     buff[5] = (u8)RTC_day;
 465  0018 450009        	mov	_buff+5,_RTC_day
 466                     ; 110     buff[6] = (u8)RTC_month;
 468  001b 45000a        	mov	_buff+6,_RTC_month
 469                     ; 111     buff[7] = (u8)RTC_year;
 471                     ; 112     FlashMngr_StoreData(buff, 8);
 473  001e ae0008        	ldw	x,#8
 474  0021 45000b        	mov	_buff+7,_RTC_year
 475  0024 89            	pushw	x
 476  0025 ae0004        	ldw	x,#_buff
 477  0028 cd0000        	call	_FlashMngr_StoreData
 479  002b 85            	popw	x
 481  002c 20d2          	jra	L531
 621                     ; 116 void TASK_UARTCommands()
 621                     ; 117 {
 622                     .text:	section	.text,new
 623  0000               _TASK_UARTCommands:
 625  0000 5207          	subw	sp,#7
 626       00000007      OFST:	set	7
 629  0002               L162:
 630                     ; 123       OS_Smsg_Wait(smsg_rx_rec, rcvd_message);
 632  0002 cd0000        	call	__OS_EnterWaitMode
 636  0005 b603          	ld	a,_smsg_rx_rec
 637  0007 2702          	jreq	L46
 638  0009 a601          	ld	a,#1
 639  000b               L46:
 640  000b cd0000        	call	__OS_CheckEvent
 645  000e cd0000        	call	__OS_DI_INT
 649  0011 b603          	ld	a,_smsg_rx_rec
 650  0013 2724          	jreq	L562
 654  0015 6b07          	ld	(OFST+0,sp),a
 657  0017 3f03          	clr	_smsg_rx_rec
 660  0019 cd0000        	call	__OS_RI_INT
 662                     ; 125       switch(rcvd_message)
 664  001c 7b07          	ld	a,(OFST+0,sp)
 666                     ; 262 					break;
 667  001e a063          	sub	a,#99
 668  0020 2603cc0120    	jreq	L361
 669  0025 a002          	sub	a,#2
 670  0027 2603cc011a    	jreq	L161
 671  002c a00d          	sub	a,#13
 672  002e 2603cc00e8    	jreq	L764
 673  0033 a002          	sub	a,#2
 674  0035 2707          	jreq	L103
 675  0037 20c9          	jra	L162
 676  0039               L562:
 677                     ; 123       OS_Smsg_Wait(smsg_rx_rec, rcvd_message);
 679  0039 cd0000        	call	__OS_RI_INT
 682  003c 20c4          	jra	L162
 683  003e               L103:
 684                     ; 130 					while(!(UART1->SR & (u8)0x20));
 686  003e 720b5230fb    	btjf	21040,#5,L103
 687                     ; 131                     l_code = UART1->DR;
 689  0043 c65231        	ld	a,21041
 690  0046 6b07          	ld	(OFST+0,sp),a
 691                     ; 132 					switch(l_code)
 694                     ; 177 								 break;
 695  0048 a067          	sub	a,#103
 696  004a 2753          	jreq	L104
 697  004c a00c          	sub	a,#12
 698  004e 26b2          	jrne	L162
 699  0050               L313:
 700                     ; 137 					             while(!(UART1->SR & (u8)0x20));
 702  0050 720b5230fb    	btjf	21040,#5,L313
 703                     ; 138                                  RTC_sec = UART1->DR;
 705  0055 5552310000    	mov	_RTC_sec,21041
 707  005a               L323:
 708                     ; 140 					             while(!(UART1->SR & (u8)0x20));
 710  005a 720b5230fb    	btjf	21040,#5,L323
 711                     ; 141                                  RTC_min = UART1->DR;
 713  005f 5552310000    	mov	_RTC_min,21041
 715  0064               L333:
 716                     ; 143 					             while(!(UART1->SR & (u8)0x20));
 718  0064 720b5230fb    	btjf	21040,#5,L333
 719                     ; 144                                  RTC_hour = UART1->DR;
 721  0069 5552310000    	mov	_RTC_hour,21041
 723  006e               L343:
 724                     ; 146 					             while(!(UART1->SR & (u8)0x20));
 726  006e 720b5230fb    	btjf	21040,#5,L343
 727                     ; 147                                  RTC_day = UART1->DR;
 729  0073 5552310000    	mov	_RTC_day,21041
 731  0078               L353:
 732                     ; 149 					             while(!(UART1->SR & (u8)0x20));
 734  0078 720b5230fb    	btjf	21040,#5,L353
 735                     ; 150                                  RTC_date = UART1->DR;
 737  007d 5552310000    	mov	_RTC_date,21041
 739  0082               L363:
 740                     ; 152 					             while(!(UART1->SR & (u8)0x20));
 742  0082 720b5230fb    	btjf	21040,#5,L363
 743                     ; 153                                  RTC_month = UART1->DR;
 745  0087 5552310000    	mov	_RTC_month,21041
 747  008c               L373:
 748                     ; 155 					             while(!(UART1->SR & (u8)0x20));
 750  008c 720b5230fb    	btjf	21040,#5,L373
 751                     ; 156                                  RTC_year = UART1->DR;
 753  0091 5552310000    	mov	_RTC_year,21041
 754                     ; 157                                  DS3231M_SetTime();
 756  0096 cd0000        	call	_DS3231M_SetTime
 758                     ; 158                                  DS3231M_SetDate();
 760  0099 cd0000        	call	_DS3231M_SetDate
 762                     ; 159 								 break;
 764  009c cc0002        	jra	L162
 765  009f               L104:
 766                     ; 163 								 while(!(UART1->SR & UART1_FLAG_TXE));
 768  009f 720f5230fb    	btjf	21040,#7,L104
 769                     ; 164                                  UART1->DR = RTC_sec;
 771  00a4 5500005231    	mov	21041,_RTC_sec
 773  00a9               L114:
 774                     ; 165 								 while(!(UART1->SR & UART1_FLAG_TXE));
 776  00a9 720f5230fb    	btjf	21040,#7,L114
 777                     ; 166                                  UART1->DR = RTC_min;
 779  00ae 5500005231    	mov	21041,_RTC_min
 781  00b3               L124:
 782                     ; 167 								 while(!(UART1->SR & UART1_FLAG_TXE));
 784  00b3 720f5230fb    	btjf	21040,#7,L124
 785                     ; 168                                  UART1->DR = RTC_hour;
 787  00b8 5500005231    	mov	21041,_RTC_hour
 789  00bd               L134:
 790                     ; 169 								 while(!(UART1->SR & UART1_FLAG_TXE));
 792  00bd 720f5230fb    	btjf	21040,#7,L134
 793                     ; 170                                  UART1->DR = RTC_day;
 795  00c2 5500005231    	mov	21041,_RTC_day
 797  00c7               L144:
 798                     ; 171 								 while(!(UART1->SR & UART1_FLAG_TXE));
 800  00c7 720f5230fb    	btjf	21040,#7,L144
 801                     ; 172                                  UART1->DR = RTC_date;
 803  00cc 5500005231    	mov	21041,_RTC_date
 805  00d1               L154:
 806                     ; 173 								 while(!(UART1->SR & UART1_FLAG_TXE));
 808  00d1 720f5230fb    	btjf	21040,#7,L154
 809                     ; 174                                  UART1->DR = RTC_month;
 811  00d6 5500005231    	mov	21041,_RTC_month
 813  00db               L164:
 814                     ; 175 								 while(!(UART1->SR & UART1_FLAG_TXE));
 816  00db 720f5230fb    	btjf	21040,#7,L164
 817                     ; 176                                  UART1->DR = RTC_year;
 819  00e0 5500005231    	mov	21041,_RTC_year
 820                     ; 177 								 break;
 822  00e5 cc0002        	jra	L162
 823                     ; 180                     break;
 825  00e8               L764:
 826                     ; 185 					while(!(UART1->SR & (u8)0x20));
 828  00e8 720b5230fb    	btjf	21040,#5,L764
 829                     ; 186                     l_code = UART1->DR;
 831  00ed c65231        	ld	a,21041
 832  00f0 6b07          	ld	(OFST+0,sp),a
 833                     ; 187 					switch(l_code)
 836                     ; 203 								 break;
 837  00f2 a064          	sub	a,#100
 838  00f4 2718          	jreq	L551
 839  00f6 a002          	sub	a,#2
 840  00f8 271a          	jreq	L751
 841  00fa a002          	sub	a,#2
 842  00fc 270a          	jreq	L351
 843  00fe a002          	sub	a,#2
 844  0100 26e3          	jrne	L162
 845                     ; 190 					             FlashMngr_GetHeaderSizeToUART(); 
 847  0102 cd0000        	call	_FlashMngr_GetHeaderSizeToUART
 849                     ; 191 					             break;
 851  0105 cc0002        	jra	L162
 852  0108               L351:
 853                     ; 194 					             FlashMngr_ReadHeaderToUART(); 
 855  0108 cd0000        	call	_FlashMngr_ReadHeaderToUART
 857                     ; 195 								 break;
 859  010b cc0002        	jra	L162
 860  010e               L551:
 861                     ; 198 					             FlashMngr_ReadDataToUART(); 
 863  010e cd0000        	call	_FlashMngr_ReadDataToUART
 865                     ; 199 								 break;
 867  0111 cc0002        	jra	L162
 868  0114               L751:
 869                     ; 202 					             FlashMngr_GetOccupiedSpaceToUART(); 
 871  0114 cd0000        	call	_FlashMngr_GetOccupiedSpaceToUART
 873                     ; 203 								 break;
 875  0117 cc0002        	jra	L162
 876                     ; 206 		            break;
 878  011a               L161:
 879                     ; 210 		            FlashMngr_EraseChip(); 
 881  011a cd0000        	call	_FlashMngr_EraseChip
 883                     ; 211 					break;
 885  011d cc0002        	jra	L162
 886  0120               L361:
 887                     ; 215                     u8 l_idx = 0;
 889  0120 6b03          	ld	(OFST-4,sp),a
 890                     ; 216                     UART1_ITConfig(UART1_IT_RXNE, DISABLE);
 892  0122 4b00          	push	#0
 893  0124 ae0255        	ldw	x,#597
 894  0127 cd0000        	call	_UART1_ITConfig
 896  012a 84            	pop	a
 898  012b               L105:
 899                     ; 218 					while(!(UART1->SR & (u8)0x20));
 901  012b 720b5230fb    	btjf	21040,#5,L105
 902                     ; 219                     l_code = UART1->DR;
 904  0130 c65231        	ld	a,21041
 905  0133 6b07          	ld	(OFST+0,sp),a
 906                     ; 220 					switch(l_code)
 909                     ; 257 								 break;
 910  0135 a066          	sub	a,#102
 911  0137 2705          	jreq	L315
 912  0139 4a            	dec	a
 913  013a 275b          	jreq	L761
 914  013c 2072          	jra	L705
 915  013e               L315:
 916                     ; 224                                  while(!(UART1->SR & (u8)0x20));
 918  013e 720b5230fb    	btjf	21040,#5,L315
 919                     ; 225                                  l_size = UART1->DR;
 921  0143 c65231        	ld	a,21041
 922  0146 6b07          	ld	(OFST+0,sp),a
 923                     ; 226                                  tmp = l_size;
 925  0148 6b04          	ld	(OFST-3,sp),a
 927  014a               L325:
 928                     ; 228                                  while(!(UART1->SR & (u8)0x20));
 930  014a 720b5230fb    	btjf	21040,#5,L325
 931                     ; 229                                  l_address = UART1->DR;
 933  014f c65231        	ld	a,21041
 934  0152 5f            	clrw	x
 935  0153 97            	ld	xl,a
 936  0154 1f05          	ldw	(OFST-2,sp),x
 937                     ; 230 					             l_address <<= 8;
 939  0156 7b06          	ld	a,(OFST-1,sp)
 940  0158 6b05          	ld	(OFST-2,sp),a
 941  015a 0f06          	clr	(OFST-1,sp)
 943  015c               L135:
 944                     ; 231 					             while(!(UART1->SR & (u8)0x20));
 946  015c 720b5230fb    	btjf	21040,#5,L135
 947                     ; 232                                  l_address |= UART1->DR;
 949  0161 c65231        	ld	a,21041
 950  0164 5f            	clrw	x
 951  0165 97            	ld	xl,a
 952  0166 01            	rrwa	x,a
 953  0167 1a06          	or	a,(OFST-1,sp)
 954  0169 01            	rrwa	x,a
 955  016a 1a05          	or	a,(OFST-2,sp)
 956  016c 01            	rrwa	x,a
 957  016d 1f05          	ldw	(OFST-2,sp),x
 959  016f 2012          	jra	L735
 960  0171               L545:
 961                     ; 236                                    while(!(UART1->SR & (u8)0x20));
 963  0171 720b5230fb    	btjf	21040,#5,L545
 964                     ; 237                                    buff[l_idx++] = UART1->DR;
 966  0176 7b03          	ld	a,(OFST-4,sp)
 967  0178 0c03          	inc	(OFST-4,sp)
 968  017a 5f            	clrw	x
 969  017b 97            	ld	xl,a
 970  017c c65231        	ld	a,21041
 971  017f e704          	ld	(_buff,x),a
 972                     ; 238                                    l_size--;
 974  0181 0a07          	dec	(OFST+0,sp)
 975  0183               L735:
 976                     ; 234                                  while(l_size > 0)
 978  0183 7b07          	ld	a,(OFST+0,sp)
 979  0185 26ea          	jrne	L545
 980                     ; 240                                  CalibData_Update(l_address, buff, tmp);
 982  0187 7b04          	ld	a,(OFST-3,sp)
 983  0189 88            	push	a
 984  018a ae0004        	ldw	x,#_buff
 985  018d 89            	pushw	x
 986  018e 1e08          	ldw	x,(OFST+1,sp)
 987  0190 cd0000        	call	_CalibData_Update
 989  0193 5b03          	addw	sp,#3
 990                     ; 241 								 break;
 992  0195 2019          	jra	L705
 993  0197               L761:
 994                     ; 251                 adr.word1 = (u16)(&CAL);
 996  0197 ae0000        	ldw	x,#_CAL
 997  019a 1f01          	ldw	(OFST-6,sp),x
 999  019c               L555:
1000                     ; 253 								 while(!(UART1->SR & UART1_FLAG_TXE));
1002  019c 720f5230fb    	btjf	21040,#7,L555
1003                     ; 254                                  UART1->DR = adr.byte1;
1005  01a1 7b01          	ld	a,(OFST-6,sp)
1006  01a3 c75231        	ld	21041,a
1008  01a6               L565:
1009                     ; 255 								 while(!(UART1->SR & UART1_FLAG_TXE));
1011  01a6 720f5230fb    	btjf	21040,#7,L565
1012                     ; 256                                  UART1->DR = adr.byte2;
1014  01ab 7b02          	ld	a,(OFST-5,sp)
1015  01ad c75231        	ld	21041,a
1016                     ; 257 								 break;
1018  01b0               L705:
1019                     ; 261                     UART1_ITConfig(UART1_IT_RXNE, ENABLE);
1021  01b0 4b01          	push	#1
1022  01b2 ae0255        	ldw	x,#597
1023  01b5 cd0000        	call	_UART1_ITConfig
1025  01b8 84            	pop	a
1026                     ; 262 					break;
1028  01b9 cc0002        	jra	L162
1081                     ; 268 void TASK_1000mS()
1081                     ; 269 {
1082                     .text:	section	.text,new
1083  0000               _TASK_1000mS:
1085  0000 5205          	subw	sp,#5
1086       00000005      OFST:	set	5
1089  0002               L706:
1090                     ; 273     OS_Delay(500);      // Wait 1000 ms
1092  0002 ae01f4        	ldw	x,#500
1093  0005 cd0000        	call	__OS_InitDelay
1097  0008 cd0000        	call	__OS_ReturnSave
1099                     ; 274     DS18B20_Read_Temp(&temperature, CAL.ROM_ID1);
1102  000b ae0000        	ldw	x,#_CAL
1103  000e 89            	pushw	x
1104  000f ae0000        	ldw	x,#L3_temperature
1105  0012 cd0000        	call	_DS18B20_Read_Temp
1107  0015 85            	popw	x
1108                     ; 275     DS3231M_GetTime();
1110  0016 cd0000        	call	_DS3231M_GetTime
1112                     ; 276     DS3231M_GetDate();
1114  0019 cd0000        	call	_DS3231M_GetDate
1116                     ; 278     tempdisp[0] = (char)((u8)((RTC_hour & 0xF0)>>4) + (u8)48);
1118  001c b600          	ld	a,_RTC_hour
1119  001e 4e            	swap	a
1120  001f a40f          	and	a,#15
1121  0021 ab30          	add	a,#48
1122  0023 6b01          	ld	(OFST-4,sp),a
1123                     ; 279     tempdisp[1] = (char)((u8)(RTC_hour & 0x0F) + (u8)48);
1125  0025 b600          	ld	a,_RTC_hour
1126  0027 a40f          	and	a,#15
1127  0029 ab30          	add	a,#48
1128  002b 6b02          	ld	(OFST-3,sp),a
1129                     ; 280     tempdisp[2] = (char)((u8)((RTC_min & 0xF0)>>4) + (u8)48);
1131  002d b600          	ld	a,_RTC_min
1132  002f 4e            	swap	a
1133  0030 a40f          	and	a,#15
1134  0032 ab30          	add	a,#48
1135  0034 6b03          	ld	(OFST-2,sp),a
1136                     ; 281     tempdisp[3] = (char)((u8)(RTC_min & 0x0F) + (u8)48);
1138  0036 b600          	ld	a,_RTC_min
1139  0038 a40f          	and	a,#15
1140  003a ab30          	add	a,#48
1141  003c 6b04          	ld	(OFST-1,sp),a
1142                     ; 282     tempdisp[4] = 0;
1144  003e 0f05          	clr	(OFST+0,sp)
1145                     ; 283     Display_SetScreen(0,  tempdisp, COMMAPOS2);
1147  0040 4b02          	push	#2
1148  0042 96            	ldw	x,sp
1149  0043 1c0002        	addw	x,#OFST-3
1150  0046 89            	pushw	x
1151  0047 4f            	clr	a
1152  0048 cd0000        	call	_Display_SetScreen
1154  004b 5b03          	addw	sp,#3
1155                     ; 284     if(temperature < 0)
1157  004d be00          	ldw	x,L3_temperature
1158  004f 2a09          	jrpl	L316
1159                     ; 286       temperature = -(temperature);
1161  0051 50            	negw	x
1162  0052 bf00          	ldw	L3_temperature,x
1163                     ; 287       FLAG_temp_neg = TRUE;
1165  0054 72100000      	bset	L11_FLAG_temp_neg
1167  0058 2004          	jra	L516
1168  005a               L316:
1169                     ; 291       FLAG_temp_neg = FALSE;
1171  005a 72110000      	bres	L11_FLAG_temp_neg
1172  005e               L516:
1173                     ; 293     temp_intreg = (u8)(temperature>>4);
1175  005e 57            	sraw	x
1176  005f 57            	sraw	x
1177  0060 57            	sraw	x
1178  0061 57            	sraw	x
1179  0062 9f            	ld	a,xl
1180  0063 b70d          	ld	L5_temp_intreg,a
1181                     ; 294     temp_frac = (u8)(temperature - (temp_intreg<<4));
1183  0065 a610          	ld	a,#16
1184  0067 42            	mul	x,a
1185  0068 9f            	ld	a,xl
1186  0069 b001          	sub	a,L3_temperature+1
1187  006b 40            	neg	a
1188                     ; 296     temp_frac *= 10;  //(temp_frac * 10) / 16  Scale to [0-9]
1190  006c ae000a        	ldw	x,#10
1191  006f 42            	mul	x,a
1192  0070 9f            	ld	a,xl
1193                     ; 297     temp_frac >>= 4;
1195  0071 4e            	swap	a
1196  0072 a40f          	and	a,#15
1197  0074 b70c          	ld	L7_temp_frac,a
1198                     ; 299     tempdisp[0] = (char)((u8)((temp_intreg)/10) + (u8)48);
1200  0076 5f            	clrw	x
1201  0077 b60d          	ld	a,L5_temp_intreg
1202  0079 97            	ld	xl,a
1203  007a a60a          	ld	a,#10
1204  007c 62            	div	x,a
1205  007d 9f            	ld	a,xl
1206  007e ab30          	add	a,#48
1207  0080 6b01          	ld	(OFST-4,sp),a
1208                     ; 300     tempdisp[1] = (char)((u8)((temp_intreg)%10) + (u8)48);
1210  0082 5f            	clrw	x
1211  0083 b60d          	ld	a,L5_temp_intreg
1212  0085 97            	ld	xl,a
1213  0086 a60a          	ld	a,#10
1214  0088 62            	div	x,a
1215  0089 ab30          	add	a,#48
1216  008b 6b02          	ld	(OFST-3,sp),a
1217                     ; 301     tempdisp[2] = (char)((u8)temp_frac + (u8)48);
1219  008d b60c          	ld	a,L7_temp_frac
1220  008f ab30          	add	a,#48
1221  0091 6b03          	ld	(OFST-2,sp),a
1222                     ; 302     tempdisp[3] = 'c';
1224  0093 a663          	ld	a,#99
1225  0095 6b04          	ld	(OFST-1,sp),a
1226                     ; 303     tempdisp[4] = 0;
1228  0097 0f05          	clr	(OFST+0,sp)
1229                     ; 304     Display_SetScreen(1,  tempdisp, COMMAPOS2);
1231  0099 4b02          	push	#2
1232  009b 96            	ldw	x,sp
1233  009c 1c0002        	addw	x,#OFST-3
1234  009f 89            	pushw	x
1235  00a0 a601          	ld	a,#1
1236  00a2 cd0000        	call	_Display_SetScreen
1238  00a5 5b03          	addw	sp,#3
1239                     ; 305     FLAG_ds18b20_err = DS18B20_All_convert();    /* issue DS18B20 convert command, to read the results after 1s */
1241  00a7 cd0000        	call	_DS18B20_All_convert
1243  00aa 4d            	tnz	a
1244  00ab 2706          	jreq	L241
1245  00ad 72100004      	bset	L12_FLAG_ds18b20_err
1246  00b1 2004          	jra	L641
1247  00b3               L241:
1248  00b3 72110004      	bres	L12_FLAG_ds18b20_err
1249  00b7               L641:
1250                     ; 307     if(FlashMngr_GetErrors() != 0)
1252  00b7 cd0000        	call	_FlashMngr_GetErrors
1254  00ba 4d            	tnz	a
1255  00bb 270d          	jreq	L716
1256                     ; 309       Display_SetScreen(2, "Er 1", NOCOMMA);
1258  00bd 4b00          	push	#0
1259  00bf ae000c        	ldw	x,#L126
1260  00c2 89            	pushw	x
1261  00c3 a602          	ld	a,#2
1262  00c5 cd0000        	call	_Display_SetScreen
1264  00c8 5b03          	addw	sp,#3
1265  00ca               L716:
1266                     ; 312     Display_Cyclic();
1268  00ca cd0000        	call	_Display_Cyclic
1271  00cd cc0002        	jra	L706
1296                     ; 316 void Power_FailDetected()
1296                     ; 317 {
1297                     .text:	section	.text,new
1298  0000               _Power_FailDetected:
1302                     ; 319   FlashMngr_DisableWriteOp();
1304  0000 cd0000        	call	_FlashMngr_DisableWriteOp
1306                     ; 320   Display_SetBrightness(0); 
1308  0003 5f            	clrw	x
1310                     ; 321 }
1313  0004 cc0000        	jp	_Display_SetBrightness
1534                     	xdef	_main
1535                     	xdef	_TASK_LogDataToFlash
1536                     	xdef	_Power_FailDetected
1537                     	xdef	_TASK_1000mS
1538                     	xdef	_TASK_UARTCommands
1539                     	switch	.ubsct
1540  0000               _msg_cb:
1541  0000 000000        	ds.b	3
1542                     	xdef	_msg_cb
1543  0003               _smsg_rx_rec:
1544  0003 00            	ds.b	1
1545                     	xdef	_smsg_rx_rec
1546  0004               _buff:
1547  0004 000000000000  	ds.b	8
1548                     	xdef	_buff
1549  000c               L7_temp_frac:
1550  000c 00            	ds.b	1
1551  000d               L5_temp_intreg:
1552  000d 00            	ds.b	1
1553                     .const:	section	.text
1554  0000               _CAL:
1555  0000 000000000000  	ds.b	12
1556                     	xdef	_CAL
1557                     	xref	_CalibData_Update
1558                     	xref	__OS_InitDelay
1559                     	xref	__OS_Task_Create
1560                     	xref.b	__OS_Tasks
1561                     	xref	_OS_Init
1562                     	xref.b	__OS_LastTask
1563                     	xref.b	__OS_BestTask
1564                     	xref.b	__OS_Best_Priority
1565                     	xref.b	__OS_CurTask
1566                     	xref.b	__OS_State
1567                     	xref.b	__OS_Temp
1568                     	xref.b	__OS_Flags
1569                     	xref	__OS_RI_INT
1570                     	xref	__OS_DI_INT
1571                     	xref	__OS_CheckEvent
1572                     	xref	__OS_EnterWaitMode
1573                     	xref	__OS_ReturnSave
1574                     	xref	__OS_JumpToTask
1575                     	xref	_FlashMngr_DisableWriteOp
1576                     	xref	_FlashMngr_ReadHeaderToUART
1577                     	xref	_FlashMngr_GetHeaderSizeToUART
1578                     	xref	_FlashMngr_GetOccupiedSpaceToUART
1579                     	xref	_FlashMngr_ReadDataToUART
1580                     	xref	_FlashMngr_GetErrors
1581                     	xref	_FlashMngr_EraseChip
1582                     	xref	_FlashMngr_StoreData
1583                     	xref	_FlashMngr_Init
1584                     	xref	_DS3231M_SetDate
1585                     	xref	_DS3231M_SetTime
1586                     	xref	_DS3231M_GetDate
1587                     	xref	_DS3231M_GetTime
1588                     	xref.b	_RTC_year
1589                     	xref.b	_RTC_month
1590                     	xref.b	_RTC_date
1591                     	xref.b	_RTC_day
1592                     	xref.b	_RTC_hour
1593                     	xref.b	_RTC_min
1594                     	xref.b	_RTC_sec
1595                     	xref	_Display_SetBrightness
1596                     	xref	_Display_SetScreen
1597                     	xref	_Display_Cyclic
1598                     	xref	_Display_Init
1599                     	xref	_DS18B20_Read_Temp
1600                     	xref	_DS18B20_All_convert
1601                     	xref	_DS18B20_All_init
1602                     	xref	_Config
1603                     	xref	_UART1_ITConfig
1604  000c               L126:
1605  000c 4572203100    	dc.b	"Er 1",0
1625                     	end
