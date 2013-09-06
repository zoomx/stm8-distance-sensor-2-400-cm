   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  51                     ; 53 void _OS_JumpToTask (void)
  51                     ; 54 {
  53                     .text:	section	.text,new
  54  0000               __OS_JumpToTask:
  58                     ; 55     _OS_STORE_SP();
  61  0000 96            	ldw	X,SP
  66  0001 bf1e          	ldw	__OS_SP_Temp,X
  68                     ; 56     _OS_SET_FSR_CUR_TASK();
  72  0003 905f          	clrw	Y
  77  0005 b619          	ld	A,__OS_CurTask
  82  0007 9097          	ld	YL,A
  84                     ; 57     _OS_Restore_TaskSP();
  88  0009 93            	ldw	X,Y
  93  000a ee03          	ldw	X,(3,X)
  98  000c 5d            	tnzw	X
 103  000d 2701          	jreq	SKIP_SP
 108  000f 94            	ldw	SP,X
 113  0010               SKIP_SP:
 115                     ; 58     _OS_SET_PC();
 119  0010 93            	ldw	X,Y
 124  0011 ee01          	ldw	X,(1,X)
 129  0013 89            	pushw	X
 134  0014 81            	ret	
 136                     ; 59 }
 140  0015 81            	ret	
 165                     ; 86 void _OS_ReturnSave (void)
 165                     ; 87 {
 166                     .text:	section	.text,new
 167  0000               __OS_ReturnSave:
 171                     ; 88     _OS_SET_FSR_CUR_TASK();
 174  0000 905f          	clrw	Y
 179  0002 b619          	ld	A,__OS_CurTask
 184  0004 9097          	ld	YL,A
 186                     ; 89     _OS_SAVE_PC();
 190  0006 85            	popw	X
 195  0007 90ef01        	ldw	(1,Y),X
 197                     ; 90     _OS_Store_TaskSP();
 201  000a 96            	ldw	X,SP
 206  000b 90ef03        	ldw	(3,Y),X
 208                     ; 91     _OS_bTaskReady = 1;
 211  000e 7216001a      	bset	__OS_State,#3
 212                     ; 92     _OS_RESTORE_SP();
 215  0012 be1e          	ldw	X,__OS_SP_Temp
 220  0014 94            	ldw	SP,X
 222                     ; 93 }
 226  0015 81            	ret	
 250                     ; 113 void _OS_ReturnNoSave (void)
 250                     ; 114 {
 251                     .text:	section	.text,new
 252  0000               __OS_ReturnNoSave:
 256                     ; 115     _OS_POP();
 259  0000 85            	popw	X
 261                     ; 116     _OS_RESTORE_SP();
 264  0001 be1e          	ldw	X,__OS_SP_Temp
 269  0003 94            	ldw	SP,X
 271                     ; 117 }
 275  0004 81            	ret	
 300                     ; 138 void _OS_EnterWaitMode (void)
 300                     ; 139 {
 301                     .text:	section	.text,new
 302  0000               __OS_EnterWaitMode:
 306                     ; 140     _OS_Temp = 0;
 308  0000 3f1c          	clr	__OS_Temp
 309                     ; 142     _asm(" jp    __OS_ClrReadySetClrCanContinue   ");
 312  0002 cc0000        	jp	__OS_ClrReadySetClrCanContinue
 314                     ; 143 }
 342                     ; 164 void _OS_EnterWaitModeTO (void)
 342                     ; 165 {
 343                     .text:	section	.text,new
 344  0000               __OS_EnterWaitModeTO:
 348                     ; 166     _OS_Temp = 0xFF;
 350  0000 35ff001c      	mov	__OS_Temp,#255
 351                     ; 168     _asm(" jp    __OS_ClrReadySetClrCanContinue   ");
 354  0004 cc0000        	jp	__OS_ClrReadySetClrCanContinue
 356                     ; 169 }
 386                     ; 191 void _OS_ClrReadySetClrCanContinue (void)
 386                     ; 192 {
 387                     .text:	section	.text,new
 388  0000               __OS_ClrReadySetClrCanContinue:
 392                     ; 193     _OS_SET_FSR_CUR_TASK();
 395  0000 905f          	clrw	Y
 400  0002 b619          	ld	A,__OS_CurTask
 405  0004 9097          	ld	YL,A
 407                     ; 194     _OS_SAVE_PC();
 411  0006 85            	popw	X
 416  0007 90ef01        	ldw	(1,Y),X
 418                     ; 195     _OS_PUSH();
 422  000a 89            	pushw	X
 424                     ; 196     _OS_Store_TaskSP2();
 427  000b 96            	ldw	X,SP
 432  000c 1c0002        	addw	X,#2
 437  000f 90ef03        	ldw	(3,Y),X
 439                     ; 198     _OS_Flags.bEventError = 0;
 442  0012 7211001d      	bres	__OS_Flags,#0
 443                     ; 199     _OS_bTaskReady = 0;
 445  0016 7217001a      	bres	__OS_State,#3
 446                     ; 202         if (!_OS_bTaskDelay) _OS_bTaskCanContinue = 0;
 448  001a 7208001a04    	btjt	__OS_State,#4,L17
 451  001f 721b001a      	bres	__OS_State,#5
 452  0023               L17:
 453                     ; 203         if (_OS_Temp & 0x01) _OS_bTaskCanContinue = 1;
 455  0023 7201001c04    	btjf	__OS_Temp,#0,L37
 458  0028 721a001a      	bset	__OS_State,#5
 459  002c               L37:
 460                     ; 206 }
 463  002c 81            	ret	
 503                     ; 242 void _OS_InitDelay (OS_TTIMER_TYPE Delay)
 503                     ; 243 {
 504                     .text:	section	.text,new
 505  0000               __OS_InitDelay:
 507  0000 89            	pushw	x
 508       00000000      OFST:	set	0
 511                     ; 245     _OS_TASK_ATOMIC_WRITE_A(
 513  0001 cd0000        	call	__OS_DI_INT
 517  0004 721b001a      	bres	__OS_State,#5
 521  0008 ad32          	call	LC001
 526  000a a4ef          	and	A,#0xEF
 531  000c 90f7          	ld	(Y),A
 537  000e cd0000        	call	__OS_RI_INT
 539                     ; 250     if (Delay)
 541  0011 1e01          	ldw	x,(OFST+1,sp)
 542  0013 2725          	jreq	L711
 543                     ; 252         Delay ^= (OS_TTIMER_TYPE)-1;
 545  0015 0302          	cpl	(OFST+2,sp)
 546  0017 0301          	cpl	(OFST+1,sp)
 547                     ; 253         Delay ++;
 549  0019 1e01          	ldw	x,(OFST+1,sp)
 550  001b 5c            	incw	x
 551  001c 1f01          	ldw	(OFST+1,sp),x
 552                     ; 254         _OS_CurTask->Timer = Delay;
 554  001e 5f            	clrw	x
 555  001f b619          	ld	a,__OS_CurTask
 556  0021 97            	ld	xl,a
 557  0022 1601          	ldw	y,(OFST+1,sp)
 558  0024 ef05          	ldw	(5,x),y
 559                     ; 255         _OS_TASK_ATOMIC_WRITE_A(_OS_CURTASK_STATE_DELAY_READY_SET());
 561  0026 cd0000        	call	__OS_DI_INT
 566  0029 ad11          	call	LC001
 571  002b aa18          	or	A,#0x18
 576  002d 90f7          	ld	(Y),A
 581  002f cd0000        	call	__OS_RI_INT
 583                     ; 257             _OS_bTaskDelay = 1;
 585  0032 7218001a      	bset	__OS_State,#4
 586                     ; 258             _OS_bTaskReady = 1;
 588  0036 7216001a      	bset	__OS_State,#3
 589  003a               L711:
 590                     ; 261 }
 593  003a 85            	popw	x
 594  003b 81            	ret	
 595  003c               LC001:
 596  003c 905f          	clrw	Y
 598                     ; 245     _OS_TASK_ATOMIC_WRITE_A(
 601  003e b619          	ld	A,__OS_CurTask
 606  0040 9097          	ld	YL,A
 612  0042 90f6          	ld	A,(Y)
 613  0044 81            	ret	
 637                     ; 292 char OS_DI (void)
 637                     ; 293 {
 638                     .text:	section	.text,new
 639  0000               _OS_DI:
 643                     ; 294     _asm("  push    CC  ");
 646  0000 8a            	push	CC
 648                     ; 295     _asm("  sim         ");
 651  0001 9b            	sim	
 653                     ; 296     _asm("  pop     A   ");
 656  0002 84            	pop	A
 658                     ; 297 }
 661  0003 81            	ret	
 685                     ; 302 void _OS_DI_INT (void)
 685                     ; 303 {
 686                     .text:	section	.text,new
 687  0000               __OS_DI_INT:
 691                     ; 304     _asm("  push    CC          ");
 694  0000 8a            	push	CC
 696                     ; 305     _asm("  sim                 ");
 699  0001 9b            	sim	
 701                     ; 306     _asm("  pop     __OS_Temp_I ");
 704  0002 320000        	pop	__OS_Temp_I
 706                     ; 307 }
 709  0005 81            	ret	
 743                     ; 332 void OS_RI (char temp)
 743                     ; 333 {
 744                     .text:	section	.text,new
 745  0000               _OS_RI:
 749                     ; 334     _asm("  push    A       ");
 752  0000 88            	push	A
 754                     ; 335     _asm("  pop     CC      ");
 757  0001 86            	pop	CC
 759                     ; 336 }
 762  0002 81            	ret	
 785                     ; 341 void _OS_RI_INT (void)
 785                     ; 342 {
 786                     .text:	section	.text,new
 787  0000               __OS_RI_INT:
 791                     ; 343     _asm("  push    __OS_Temp_I ");
 794  0000 3b0000        	push	__OS_Temp_I
 796                     ; 344     _asm("  pop     CC          ");
 799  0003 86            	pop	CC
 801                     ; 345 }
 804  0004 81            	ret	
 841                     ; 358 void OS_EnterCriticalSection (void)
 841                     ; 359 {
 842                     .text:	section	.text,new
 843  0000               _OS_EnterCriticalSection:
 845  0000 88            	push	a
 846       00000001      OFST:	set	1
 849                     ; 362     temp = OS_DI();
 851  0001 cd0000        	call	_OS_DI
 853  0004 6b01          	ld	(OFST+0,sp),a
 854                     ; 363     _OS_Flags.bInCriticalSection = 1;
 856  0006 7214001d      	bset	__OS_Flags,#2
 857                     ; 365     _OS_Flags.bI0_CTemp = 0;
 859                     ; 366     if (temp & 0x08) _OS_Flags.bI0_CTemp = 1;
 861  000a a508          	bcp	a,#8
 862  000c 721f001d      	bres	__OS_Flags,#7
 863  0010 2704          	jreq	L112
 866  0012 721e001d      	bset	__OS_Flags,#7
 867  0016               L112:
 868                     ; 368     _OS_Flags.bI1_CTemp = 0;
 870  0016 721d001d      	bres	__OS_Flags,#6
 871                     ; 369     if (temp & 0x20) _OS_Flags.bI1_CTemp = 1;
 873  001a a520          	bcp	a,#32
 874  001c 2704          	jreq	L312
 877  001e 721c001d      	bset	__OS_Flags,#6
 878  0022               L312:
 879                     ; 370 }
 882  0022 84            	pop	a
 883  0023 81            	ret	
 920                     ; 378 void OS_LeaveCriticalSection (void)
 920                     ; 379 {
 921                     .text:	section	.text,new
 922  0000               _OS_LeaveCriticalSection:
 924  0000 88            	push	a
 925       00000001      OFST:	set	1
 928                     ; 381     _OS_Flags.bInCriticalSection = 0;
 930  0001 7215001d      	bres	__OS_Flags,#2
 931                     ; 382     temp = 0;
 933  0005 0f01          	clr	(OFST+0,sp)
 934                     ; 383     if (_OS_Flags.bI0_CTemp) temp |= 0x20;
 936  0007 720f001d06    	btjf	__OS_Flags,#7,L332
 939  000c 7b01          	ld	a,(OFST+0,sp)
 940  000e aa20          	or	a,#32
 941  0010 6b01          	ld	(OFST+0,sp),a
 942  0012               L332:
 943                     ; 384     if (_OS_Flags.bI1_CTemp) temp |= 0x08;
 945  0012 720d001d06    	btjf	__OS_Flags,#6,L532
 948  0017 7b01          	ld	a,(OFST+0,sp)
 949  0019 aa08          	or	a,#8
 950  001b 6b01          	ld	(OFST+0,sp),a
 951  001d               L532:
 952                     ; 385     OS_RI(temp);
 954  001d 7b01          	ld	a,(OFST+0,sp)
 955  001f cd0000        	call	_OS_RI
 957                     ; 386 }
 960  0022 84            	pop	a
 961  0023 81            	ret	
1001                     ; 419 void _OS_CheckEvent (OST_UINT bEvent)
1001                     ; 420 {
1002                     .text:	section	.text,new
1003  0000               __OS_CheckEvent:
1007                     ; 458         _OS_Flags.bTimeout = 0;
1009  0000 721b001d      	bres	__OS_Flags,#5
1010                     ; 460         if (bEvent)
1012  0004 4d            	tnz	a
1013  0005 2721          	jreq	L552
1014                     ; 462             if (_OS_bTaskReady) {
1016  0007 7207001a16    	btjf	__OS_State,#3,L752
1017                     ; 466                     _OS_bTaskDelay = 0; // Clear bDelay in temporary variable _OS_State
1019  000c 7219001a      	bres	__OS_State,#4
1020                     ; 467                     _OS_ATOMIC_WRITE_A(_OS_CURTASK_STATE_DELAY_CLEAR());
1022  0010 cd0000        	call	__OS_DI_INT
1027  0013 905f          	clrw	Y
1032  0015 b619          	ld	A,__OS_CurTask
1037  0017 9097          	ld	YL,A
1043  0019 90f6          	ld	A,(Y)
1048  001b a4ef          	and	A,#0xEF
1053  001d 90f7          	ld	(Y),A
1059                     ; 475                 return;
1062  001f cc0000        	jp	__OS_RI_INT
1063  0022               L752:
1064                     ; 478             _OS_bTaskReady = 1;
1066  0022 7216001a      	bset	__OS_State,#3
1068  0026 2004          	jra	L562
1069  0028               L552:
1070                     ; 481             _OS_bTaskReady = 0;
1072  0028 7217001a      	bres	__OS_State,#3
1073  002c               L562:
1074                     ; 486             if (_OS_bTaskTimeout && _OS_bTaskCanContinue)
1076  002c 7208001a0e    	btjt	__OS_State,#4,L762
1078  0031 720b001a09    	btjf	__OS_State,#5,L762
1079                     ; 488                 _OS_bTaskReady = 1;
1081  0036 7216001a      	bset	__OS_State,#3
1082                     ; 489                 _OS_Flags.bTimeout = 1;
1084  003a 721a001d      	bset	__OS_Flags,#5
1085                     ; 495                 return;
1088  003e 81            	ret	
1089  003f               L762:
1090                     ; 500         _OS_POP();
1093  003f 85            	popw	X
1095                     ; 501         _OS_RESTORE_SP();
1098  0040 be1e          	ldw	X,__OS_SP_Temp
1103  0042 94            	ldw	SP,X
1105                     ; 507 }
1109  0043 81            	ret	
1163                     ; 67 void OS_Init (void)
1163                     ; 68 {
1164                     .text:	section	.text,new
1165  0000               _OS_Init:
1169                     ; 72     *(OS_RAM_NEAR OST_WORD*)&_OS_Flags = 0;
1171  0000 3f1d          	clr	__OS_Flags
1172                     ; 81         _OS_LastTask = (OST_TASK_POINTER) _OS_Tasks + (OS_TASKS - 1);
1175  0002 350f0016      	mov	__OS_LastTask,#__OS_Tasks+14
1176                     ; 326         _OS_Tasks[0].State.bEnable = 0;
1178  0006 721d0001      	bres	__OS_Tasks,#6
1179                     ; 329            _OS_Tasks[1].State.bEnable = 0;
1181  000a 721d0008      	bres	__OS_Tasks+7,#6
1182                     ; 333            _OS_Tasks[2].State.bEnable = 0;
1184  000e 721d000f      	bres	__OS_Tasks+14,#6
1185                     ; 394 }
1188  0012 81            	ret	
1212                     ; 568 void OS_Timer (void)
1212                     ; 569 {
1213                     .text:	section	.text,new
1214  0000               _OS_Timer:
1218                     ; 570     __OS_TimerInline();
1352  0000 720900010b    	btjf	__OS_Tasks,#4,L523
1355  0005 be06          	ldw	x,__OS_Tasks+5
1356  0007 5c            	incw	x
1357  0008 bf06          	ldw	__OS_Tasks+5,x
1358  000a 2604          	jrne	L523
1361  000c 72190001      	bres	__OS_Tasks,#4
1362  0010               L523:
1366  0010 720900080b    	btjf	__OS_Tasks+7,#4,L133
1369  0015 be0d          	ldw	x,__OS_Tasks+12
1370  0017 5c            	incw	x
1371  0018 bf0d          	ldw	__OS_Tasks+12,x
1372  001a 2604          	jrne	L133
1375  001c 72190008      	bres	__OS_Tasks+7,#4
1376  0020               L133:
1380  0020 7209000f0b    	btjf	__OS_Tasks+14,#4,L533
1383  0025 be14          	ldw	x,__OS_Tasks+19
1384  0027 5c            	incw	x
1385  0028 bf14          	ldw	__OS_Tasks+19,x
1386  002a 2604          	jrne	L533
1389  002c 7219000f      	bres	__OS_Tasks+14,#4
1390  0030               L533:
1391                     ; 571 }
1461  0030 81            	ret	
1643                     ; 75     void _OS_Task_Create(OST_WORD priority, OST_CODE_POINTER TaskAddr)
1643                     ; 76     {
1644                     .text:	section	.text,new
1645  0000               __OS_Task_Create:
1647  0000 88            	push	a
1648  0001 88            	push	a
1649       00000001      OFST:	set	1
1652                     ; 79         _OS_Flags.bError = 0;
1654  0002 7213001d      	bres	__OS_Flags,#1
1655                     ; 88         Task = (OST_TASK_POINTER)_OS_Tasks;
1657  0006 a601          	ld	a,#__OS_Tasks
1658  0008 6b01          	ld	(OFST+0,sp),a
1659                     ; 89         _OS_Temp = 0;   
1661  000a 3f1c          	clr	__OS_Temp
1662  000c               L154:
1663                     ; 93             if (!Task->State.bEnable)               // Is descriptor free?
1665  000c 7b01          	ld	a,(OFST+0,sp)
1666  000e 5f            	clrw	x
1667  000f 97            	ld	xl,a
1668  0010 f6            	ld	a,(x)
1669  0011 a540          	bcp	a,#64
1670  0013 262f          	jrne	L754
1671                     ; 95                 ((OST_TASK_STATE*)&priority)->bEnable = 1;
1673  0015 7b02          	ld	a,(OFST+1,sp)
1674                     ; 96                 ((OST_TASK_STATE*)&priority)->bReady = 1;
1676  0017 aa48          	or	a,#72
1677  0019 6b02          	ld	(OFST+1,sp),a
1678                     ; 98                 Task->pTaskPointer = TaskAddr;
1680  001b 5f            	clrw	x
1681  001c 7b01          	ld	a,(OFST+0,sp)
1682  001e 97            	ld	xl,a
1683  001f 1605          	ldw	y,(OFST+4,sp)
1684  0021 ef01          	ldw	(1,x),y
1685                     ; 101                     Task->Timer = 0;
1687  0023 5f            	clrw	x
1688  0024 97            	ld	xl,a
1689  0025 905f          	clrw	y
1690  0027 ef05          	ldw	(5,x),y
1691                     ; 108                 *((OS_TASKS_BANK char*)&Task->State) = priority;
1693  0029 5f            	clrw	x
1694  002a 97            	ld	xl,a
1695  002b 7b02          	ld	a,(OFST+1,sp)
1696  002d f7            	ld	(x),a
1697                     ; 111                 if (Task == _OS_CurTask) *((OS_RAM_NEAR char*)&_OS_State) = priority;
1699  002e 7b01          	ld	a,(OFST+0,sp)
1700  0030 b119          	cp	a,__OS_CurTask
1701  0032 2606          	jrne	L164
1704  0034 7b02          	ld	a,(OFST+1,sp)
1705  0036 b71a          	ld	__OS_State,a
1706  0038 7b01          	ld	a,(OFST+0,sp)
1707  003a               L164:
1708                     ; 123                 Task->nSP_Temp = 0;
1710  003a 5f            	clrw	x
1711  003b 97            	ld	xl,a
1712  003c ef03          	ldw	(3,x),y
1713                     ; 126                 _OS_Flags.bError = 0;
1715  003e 7213001d      	bres	__OS_Flags,#1
1716                     ; 128                 return ;
1718  0042 2012          	jra	L66
1719  0044               L754:
1720                     ; 132             Task ++;
1722  0044 7b01          	ld	a,(OFST+0,sp)
1723  0046 ab07          	add	a,#7
1724  0048 6b01          	ld	(OFST+0,sp),a
1725                     ; 134         } while (++_OS_Temp < OS_TASKS);    
1727  004a 3c1c          	inc	__OS_Temp
1728  004c b61c          	ld	a,__OS_Temp
1729  004e a103          	cp	a,#3
1730  0050 25ba          	jrult	L154
1731                     ; 137         _OS_Flags.bError = 1;
1733  0052 7212001d      	bset	__OS_Flags,#1
1734                     ; 139         return ;
1735  0056               L66:
1738  0056 85            	popw	x
1739  0057 81            	ret	
2069                     	xdef	__OS_ClrReadySetClrCanContinue
2070                     	switch	.ubsct
2071  0000               __OS_Temp_I:
2072  0000 00            	ds.b	1
2073                     	xdef	__OS_Temp_I
2074                     	xdef	_OS_Timer
2075                     	xdef	__OS_InitDelay
2076                     	xdef	__OS_Task_Create
2077  0001               __OS_Tasks:
2078  0001 000000000000  	ds.b	21
2079                     	xdef	__OS_Tasks
2080                     	xdef	_OS_LeaveCriticalSection
2081                     	xdef	_OS_EnterCriticalSection
2082                     	xdef	_OS_Init
2083  0016               __OS_LastTask:
2084  0016 00            	ds.b	1
2085                     	xdef	__OS_LastTask
2086  0017               __OS_BestTask:
2087  0017 00            	ds.b	1
2088                     	xdef	__OS_BestTask
2089  0018               __OS_Best_Priority:
2090  0018 00            	ds.b	1
2091                     	xdef	__OS_Best_Priority
2092  0019               __OS_CurTask:
2093  0019 00            	ds.b	1
2094                     	xdef	__OS_CurTask
2095  001a               __OS_State:
2096  001a 00            	ds.b	1
2097                     	xdef	__OS_State
2098  001b               __OS_TempH:
2099  001b 00            	ds.b	1
2100                     	xdef	__OS_TempH
2101  001c               __OS_Temp:
2102  001c 00            	ds.b	1
2103                     	xdef	__OS_Temp
2104  001d               __OS_Flags:
2105  001d 00            	ds.b	1
2106                     	xdef	__OS_Flags
2107                     	xdef	__OS_RI_INT
2108                     	xdef	__OS_DI_INT
2109                     	xdef	_OS_RI
2110                     	xdef	_OS_DI
2111                     	xdef	__OS_CheckEvent
2112                     	xdef	__OS_EnterWaitModeTO
2113                     	xdef	__OS_EnterWaitMode
2114                     	xdef	__OS_ReturnNoSave
2115                     	xdef	__OS_ReturnSave
2116                     	xdef	__OS_JumpToTask
2117  001e               __OS_SP_Temp:
2118  001e 0000          	ds.b	2
2119                     	xdef	__OS_SP_Temp
2139                     	end
