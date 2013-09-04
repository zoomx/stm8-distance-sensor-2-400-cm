   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  49                     ; 53 void _OS_JumpToTask (void)
  49                     ; 54 {
  51                     .text:	section	.text,new
  52  0000               __OS_JumpToTask:
  56                     ; 55     _OS_STORE_SP();
  59  0000 96            	ldw	X,SP
  64  0001 bf1e          	ldw	__OS_SP_Temp,X
  66                     ; 56     _OS_SET_FSR_CUR_TASK();
  70  0003 905f          	clrw	Y
  75  0005 b619          	ld	A,__OS_CurTask
  80  0007 9097          	ld	YL,A
  82                     ; 57     _OS_Restore_TaskSP();
  86  0009 93            	ldw	X,Y
  91  000a ee03          	ldw	X,(3,X)
  96  000c 5d            	tnzw	X
 101  000d 2701          	jreq	SKIP_SP
 106  000f 94            	ldw	SP,X
 111  0010               SKIP_SP:
 113                     ; 58     _OS_SET_PC();
 117  0010 93            	ldw	X,Y
 122  0011 ee01          	ldw	X,(1,X)
 127  0013 89            	pushw	X
 132  0014 81            	ret	
 134                     ; 59 }
 138  0015 81            	ret	
 163                     ; 86 void _OS_ReturnSave (void)
 163                     ; 87 {
 164                     .text:	section	.text,new
 165  0000               __OS_ReturnSave:
 169                     ; 88     _OS_SET_FSR_CUR_TASK();
 172  0000 905f          	clrw	Y
 177  0002 b619          	ld	A,__OS_CurTask
 182  0004 9097          	ld	YL,A
 184                     ; 89     _OS_SAVE_PC();
 188  0006 85            	popw	X
 193  0007 90ef01        	ldw	(1,Y),X
 195                     ; 90     _OS_Store_TaskSP();
 199  000a 96            	ldw	X,SP
 204  000b 90ef03        	ldw	(3,Y),X
 206                     ; 91     _OS_bTaskReady = 1;
 209  000e 7216001a      	bset	__OS_State,#3
 210                     ; 92     _OS_RESTORE_SP();
 213  0012 be1e          	ldw	X,__OS_SP_Temp
 218  0014 94            	ldw	SP,X
 220                     ; 93 }
 224  0015 81            	ret	
 248                     ; 113 void _OS_ReturnNoSave (void)
 248                     ; 114 {
 249                     .text:	section	.text,new
 250  0000               __OS_ReturnNoSave:
 254                     ; 115     _OS_POP();
 257  0000 85            	popw	X
 259                     ; 116     _OS_RESTORE_SP();
 262  0001 be1e          	ldw	X,__OS_SP_Temp
 267  0003 94            	ldw	SP,X
 269                     ; 117 }
 273  0004 81            	ret	
 298                     ; 138 void _OS_EnterWaitMode (void)
 298                     ; 139 {
 299                     .text:	section	.text,new
 300  0000               __OS_EnterWaitMode:
 304                     ; 140     _OS_Temp = 0;
 306  0000 3f1c          	clr	__OS_Temp
 307                     ; 142     _asm(" jp    __OS_ClrReadySetClrCanContinue   ");
 310  0002 cc0000        	jp	__OS_ClrReadySetClrCanContinue
 312                     ; 143 }
 340                     ; 164 void _OS_EnterWaitModeTO (void)
 340                     ; 165 {
 341                     .text:	section	.text,new
 342  0000               __OS_EnterWaitModeTO:
 346                     ; 166     _OS_Temp = 0xFF;
 348  0000 35ff001c      	mov	__OS_Temp,#255
 349                     ; 168     _asm(" jp    __OS_ClrReadySetClrCanContinue   ");
 352  0004 cc0000        	jp	__OS_ClrReadySetClrCanContinue
 354                     ; 169 }
 384                     ; 191 void _OS_ClrReadySetClrCanContinue (void)
 384                     ; 192 {
 385                     .text:	section	.text,new
 386  0000               __OS_ClrReadySetClrCanContinue:
 390                     ; 193     _OS_SET_FSR_CUR_TASK();
 393  0000 905f          	clrw	Y
 398  0002 b619          	ld	A,__OS_CurTask
 403  0004 9097          	ld	YL,A
 405                     ; 194     _OS_SAVE_PC();
 409  0006 85            	popw	X
 414  0007 90ef01        	ldw	(1,Y),X
 416                     ; 195     _OS_PUSH();
 420  000a 89            	pushw	X
 422                     ; 196     _OS_Store_TaskSP2();
 425  000b 96            	ldw	X,SP
 430  000c 1c0002        	addw	X,#2
 435  000f 90ef03        	ldw	(3,Y),X
 437                     ; 198     _OS_Flags.bEventError = 0;
 440  0012 7211001d      	bres	__OS_Flags,#0
 441                     ; 199     _OS_bTaskReady = 0;
 443  0016 7217001a      	bres	__OS_State,#3
 444                     ; 202         if (!_OS_bTaskDelay) _OS_bTaskCanContinue = 0;
 446  001a 7208001a04    	btjt	__OS_State,#4,L17
 449  001f 721b001a      	bres	__OS_State,#5
 450  0023               L17:
 451                     ; 203         if (_OS_Temp & 0x01) _OS_bTaskCanContinue = 1;
 453  0023 7201001c04    	btjf	__OS_Temp,#0,L37
 456  0028 721a001a      	bset	__OS_State,#5
 457  002c               L37:
 458                     ; 206 }
 461  002c 81            	ret	
 501                     ; 242 void _OS_InitDelay (OS_TTIMER_TYPE Delay)
 501                     ; 243 {
 502                     .text:	section	.text,new
 503  0000               __OS_InitDelay:
 505  0000 89            	pushw	x
 506       00000000      OFST:	set	0
 509                     ; 245     _OS_TASK_ATOMIC_WRITE_A(
 511  0001 cd0000        	call	__OS_DI_INT
 515  0004 721b001a      	bres	__OS_State,#5
 519  0008 ad32          	call	LC001
 524  000a a4ef          	and	A,#0xEF
 529  000c 90f7          	ld	(Y),A
 535  000e cd0000        	call	__OS_RI_INT
 537                     ; 250     if (Delay)
 539  0011 1e01          	ldw	x,(OFST+1,sp)
 540  0013 2725          	jreq	L711
 541                     ; 252         Delay ^= (OS_TTIMER_TYPE)-1;
 543  0015 0302          	cpl	(OFST+2,sp)
 544  0017 0301          	cpl	(OFST+1,sp)
 545                     ; 253         Delay ++;
 547  0019 1e01          	ldw	x,(OFST+1,sp)
 548  001b 5c            	incw	x
 549  001c 1f01          	ldw	(OFST+1,sp),x
 550                     ; 254         _OS_CurTask->Timer = Delay;
 552  001e 5f            	clrw	x
 553  001f b619          	ld	a,__OS_CurTask
 554  0021 97            	ld	xl,a
 555  0022 1601          	ldw	y,(OFST+1,sp)
 556  0024 ef05          	ldw	(5,x),y
 557                     ; 255         _OS_TASK_ATOMIC_WRITE_A(_OS_CURTASK_STATE_DELAY_READY_SET());
 559  0026 cd0000        	call	__OS_DI_INT
 564  0029 ad11          	call	LC001
 569  002b aa18          	or	A,#0x18
 574  002d 90f7          	ld	(Y),A
 579  002f cd0000        	call	__OS_RI_INT
 581                     ; 257             _OS_bTaskDelay = 1;
 583  0032 7218001a      	bset	__OS_State,#4
 584                     ; 258             _OS_bTaskReady = 1;
 586  0036 7216001a      	bset	__OS_State,#3
 587  003a               L711:
 588                     ; 261 }
 591  003a 85            	popw	x
 592  003b 81            	ret	
 593  003c               LC001:
 594  003c 905f          	clrw	Y
 596                     ; 245     _OS_TASK_ATOMIC_WRITE_A(
 599  003e b619          	ld	A,__OS_CurTask
 604  0040 9097          	ld	YL,A
 610  0042 90f6          	ld	A,(Y)
 611  0044 81            	ret	
 635                     ; 292 char OS_DI (void)
 635                     ; 293 {
 636                     .text:	section	.text,new
 637  0000               _OS_DI:
 641                     ; 294     _asm("  push    CC  ");
 644  0000 8a            	push	CC
 646                     ; 295     _asm("  sim         ");
 649  0001 9b            	sim	
 651                     ; 296     _asm("  pop     A   ");
 654  0002 84            	pop	A
 656                     ; 297 }
 659  0003 81            	ret	
 683                     ; 302 void _OS_DI_INT (void)
 683                     ; 303 {
 684                     .text:	section	.text,new
 685  0000               __OS_DI_INT:
 689                     ; 304     _asm("  push    CC          ");
 692  0000 8a            	push	CC
 694                     ; 305     _asm("  sim                 ");
 697  0001 9b            	sim	
 699                     ; 306     _asm("  pop     __OS_Temp_I ");
 702  0002 320000        	pop	__OS_Temp_I
 704                     ; 307 }
 707  0005 81            	ret	
 741                     ; 332 void OS_RI (char temp)
 741                     ; 333 {
 742                     .text:	section	.text,new
 743  0000               _OS_RI:
 747                     ; 334     _asm("  push    A       ");
 750  0000 88            	push	A
 752                     ; 335     _asm("  pop     CC      ");
 755  0001 86            	pop	CC
 757                     ; 336 }
 760  0002 81            	ret	
 783                     ; 341 void _OS_RI_INT (void)
 783                     ; 342 {
 784                     .text:	section	.text,new
 785  0000               __OS_RI_INT:
 789                     ; 343     _asm("  push    __OS_Temp_I ");
 792  0000 3b0000        	push	__OS_Temp_I
 794                     ; 344     _asm("  pop     CC          ");
 797  0003 86            	pop	CC
 799                     ; 345 }
 802  0004 81            	ret	
 839                     ; 358 void OS_EnterCriticalSection (void)
 839                     ; 359 {
 840                     .text:	section	.text,new
 841  0000               _OS_EnterCriticalSection:
 843  0000 88            	push	a
 844       00000001      OFST:	set	1
 847                     ; 362     temp = OS_DI();
 849  0001 cd0000        	call	_OS_DI
 851  0004 6b01          	ld	(OFST+0,sp),a
 852                     ; 363     _OS_Flags.bInCriticalSection = 1;
 854  0006 7214001d      	bset	__OS_Flags,#2
 855                     ; 365     _OS_Flags.bI0_CTemp = 0;
 857                     ; 366     if (temp & 0x08) _OS_Flags.bI0_CTemp = 1;
 859  000a a508          	bcp	a,#8
 860  000c 721f001d      	bres	__OS_Flags,#7
 861  0010 2704          	jreq	L112
 864  0012 721e001d      	bset	__OS_Flags,#7
 865  0016               L112:
 866                     ; 368     _OS_Flags.bI1_CTemp = 0;
 868  0016 721d001d      	bres	__OS_Flags,#6
 869                     ; 369     if (temp & 0x20) _OS_Flags.bI1_CTemp = 1;
 871  001a a520          	bcp	a,#32
 872  001c 2704          	jreq	L312
 875  001e 721c001d      	bset	__OS_Flags,#6
 876  0022               L312:
 877                     ; 370 }
 880  0022 84            	pop	a
 881  0023 81            	ret	
 918                     ; 378 void OS_LeaveCriticalSection (void)
 918                     ; 379 {
 919                     .text:	section	.text,new
 920  0000               _OS_LeaveCriticalSection:
 922  0000 88            	push	a
 923       00000001      OFST:	set	1
 926                     ; 381     _OS_Flags.bInCriticalSection = 0;
 928  0001 7215001d      	bres	__OS_Flags,#2
 929                     ; 382     temp = 0;
 931  0005 0f01          	clr	(OFST+0,sp)
 932                     ; 383     if (_OS_Flags.bI0_CTemp) temp |= 0x20;
 934  0007 720f001d06    	btjf	__OS_Flags,#7,L332
 937  000c 7b01          	ld	a,(OFST+0,sp)
 938  000e aa20          	or	a,#32
 939  0010 6b01          	ld	(OFST+0,sp),a
 940  0012               L332:
 941                     ; 384     if (_OS_Flags.bI1_CTemp) temp |= 0x08;
 943  0012 720d001d06    	btjf	__OS_Flags,#6,L532
 946  0017 7b01          	ld	a,(OFST+0,sp)
 947  0019 aa08          	or	a,#8
 948  001b 6b01          	ld	(OFST+0,sp),a
 949  001d               L532:
 950                     ; 385     OS_RI(temp);
 952  001d 7b01          	ld	a,(OFST+0,sp)
 953  001f cd0000        	call	_OS_RI
 955                     ; 386 }
 958  0022 84            	pop	a
 959  0023 81            	ret	
 999                     ; 419 void _OS_CheckEvent (OST_UINT bEvent)
 999                     ; 420 {
1000                     .text:	section	.text,new
1001  0000               __OS_CheckEvent:
1005                     ; 458         _OS_Flags.bTimeout = 0;
1007  0000 721b001d      	bres	__OS_Flags,#5
1008                     ; 460         if (bEvent)
1010  0004 4d            	tnz	a
1011  0005 2721          	jreq	L552
1012                     ; 462             if (_OS_bTaskReady) {
1014  0007 7207001a16    	btjf	__OS_State,#3,L752
1015                     ; 466                     _OS_bTaskDelay = 0; // Clear bDelay in temporary variable _OS_State
1017  000c 7219001a      	bres	__OS_State,#4
1018                     ; 467                     _OS_ATOMIC_WRITE_A(_OS_CURTASK_STATE_DELAY_CLEAR());
1020  0010 cd0000        	call	__OS_DI_INT
1025  0013 905f          	clrw	Y
1030  0015 b619          	ld	A,__OS_CurTask
1035  0017 9097          	ld	YL,A
1041  0019 90f6          	ld	A,(Y)
1046  001b a4ef          	and	A,#0xEF
1051  001d 90f7          	ld	(Y),A
1057                     ; 475                 return;
1060  001f cc0000        	jp	__OS_RI_INT
1061  0022               L752:
1062                     ; 478             _OS_bTaskReady = 1;
1064  0022 7216001a      	bset	__OS_State,#3
1066  0026 2004          	jra	L562
1067  0028               L552:
1068                     ; 481             _OS_bTaskReady = 0;
1070  0028 7217001a      	bres	__OS_State,#3
1071  002c               L562:
1072                     ; 486             if (_OS_bTaskTimeout && _OS_bTaskCanContinue)
1074  002c 7208001a0e    	btjt	__OS_State,#4,L762
1076  0031 720b001a09    	btjf	__OS_State,#5,L762
1077                     ; 488                 _OS_bTaskReady = 1;
1079  0036 7216001a      	bset	__OS_State,#3
1080                     ; 489                 _OS_Flags.bTimeout = 1;
1082  003a 721a001d      	bset	__OS_Flags,#5
1083                     ; 495                 return;
1086  003e 81            	ret	
1087  003f               L762:
1088                     ; 500         _OS_POP();
1091  003f 85            	popw	X
1093                     ; 501         _OS_RESTORE_SP();
1096  0040 be1e          	ldw	X,__OS_SP_Temp
1101  0042 94            	ldw	SP,X
1103                     ; 507 }
1107  0043 81            	ret	
1161                     ; 67 void OS_Init (void)
1161                     ; 68 {
1162                     .text:	section	.text,new
1163  0000               _OS_Init:
1167                     ; 72     *(OS_RAM_NEAR OST_WORD*)&_OS_Flags = 0;
1169  0000 3f1d          	clr	__OS_Flags
1170                     ; 81         _OS_LastTask = (OST_TASK_POINTER) _OS_Tasks + (OS_TASKS - 1);
1173  0002 350f0016      	mov	__OS_LastTask,#__OS_Tasks+14
1174                     ; 326         _OS_Tasks[0].State.bEnable = 0;
1176  0006 721d0001      	bres	__OS_Tasks,#6
1177                     ; 329            _OS_Tasks[1].State.bEnable = 0;
1179  000a 721d0008      	bres	__OS_Tasks+7,#6
1180                     ; 333            _OS_Tasks[2].State.bEnable = 0;
1182  000e 721d000f      	bres	__OS_Tasks+14,#6
1183                     ; 394 }
1186  0012 81            	ret	
1210                     ; 568 void OS_Timer (void)
1210                     ; 569 {
1211                     .text:	section	.text,new
1212  0000               _OS_Timer:
1216                     ; 570     __OS_TimerInline();
1350  0000 720900010b    	btjf	__OS_Tasks,#4,L523
1353  0005 be06          	ldw	x,__OS_Tasks+5
1354  0007 5c            	incw	x
1355  0008 bf06          	ldw	__OS_Tasks+5,x
1356  000a 2604          	jrne	L523
1359  000c 72190001      	bres	__OS_Tasks,#4
1360  0010               L523:
1364  0010 720900080b    	btjf	__OS_Tasks+7,#4,L133
1367  0015 be0d          	ldw	x,__OS_Tasks+12
1368  0017 5c            	incw	x
1369  0018 bf0d          	ldw	__OS_Tasks+12,x
1370  001a 2604          	jrne	L133
1373  001c 72190008      	bres	__OS_Tasks+7,#4
1374  0020               L133:
1378  0020 7209000f0b    	btjf	__OS_Tasks+14,#4,L533
1381  0025 be14          	ldw	x,__OS_Tasks+19
1382  0027 5c            	incw	x
1383  0028 bf14          	ldw	__OS_Tasks+19,x
1384  002a 2604          	jrne	L533
1387  002c 7219000f      	bres	__OS_Tasks+14,#4
1388  0030               L533:
1389                     ; 571 }
1459  0030 81            	ret	
1641                     ; 75     void _OS_Task_Create(OST_WORD priority, OST_CODE_POINTER TaskAddr)
1641                     ; 76     {
1642                     .text:	section	.text,new
1643  0000               __OS_Task_Create:
1645  0000 88            	push	a
1646  0001 88            	push	a
1647       00000001      OFST:	set	1
1650                     ; 79         _OS_Flags.bError = 0;
1652  0002 7213001d      	bres	__OS_Flags,#1
1653                     ; 88         Task = (OST_TASK_POINTER)_OS_Tasks;
1655  0006 a601          	ld	a,#__OS_Tasks
1656  0008 6b01          	ld	(OFST+0,sp),a
1657                     ; 89         _OS_Temp = 0;   
1659  000a 3f1c          	clr	__OS_Temp
1660  000c               L154:
1661                     ; 93             if (!Task->State.bEnable)               // Is descriptor free?
1663  000c 7b01          	ld	a,(OFST+0,sp)
1664  000e 5f            	clrw	x
1665  000f 97            	ld	xl,a
1666  0010 f6            	ld	a,(x)
1667  0011 a540          	bcp	a,#64
1668  0013 262f          	jrne	L754
1669                     ; 95                 ((OST_TASK_STATE*)&priority)->bEnable = 1;
1671  0015 7b02          	ld	a,(OFST+1,sp)
1672                     ; 96                 ((OST_TASK_STATE*)&priority)->bReady = 1;
1674  0017 aa48          	or	a,#72
1675  0019 6b02          	ld	(OFST+1,sp),a
1676                     ; 98                 Task->pTaskPointer = TaskAddr;
1678  001b 5f            	clrw	x
1679  001c 7b01          	ld	a,(OFST+0,sp)
1680  001e 97            	ld	xl,a
1681  001f 1605          	ldw	y,(OFST+4,sp)
1682  0021 ef01          	ldw	(1,x),y
1683                     ; 101                     Task->Timer = 0;
1685  0023 5f            	clrw	x
1686  0024 97            	ld	xl,a
1687  0025 905f          	clrw	y
1688  0027 ef05          	ldw	(5,x),y
1689                     ; 108                 *((OS_TASKS_BANK char*)&Task->State) = priority;
1691  0029 5f            	clrw	x
1692  002a 97            	ld	xl,a
1693  002b 7b02          	ld	a,(OFST+1,sp)
1694  002d f7            	ld	(x),a
1695                     ; 111                 if (Task == _OS_CurTask) *((OS_RAM_NEAR char*)&_OS_State) = priority;
1697  002e 7b01          	ld	a,(OFST+0,sp)
1698  0030 b119          	cp	a,__OS_CurTask
1699  0032 2606          	jrne	L164
1702  0034 7b02          	ld	a,(OFST+1,sp)
1703  0036 b71a          	ld	__OS_State,a
1704  0038 7b01          	ld	a,(OFST+0,sp)
1705  003a               L164:
1706                     ; 123                 Task->nSP_Temp = 0;
1708  003a 5f            	clrw	x
1709  003b 97            	ld	xl,a
1710  003c ef03          	ldw	(3,x),y
1711                     ; 126                 _OS_Flags.bError = 0;
1713  003e 7213001d      	bres	__OS_Flags,#1
1714                     ; 128                 return ;
1716  0042 2012          	jra	L66
1717  0044               L754:
1718                     ; 132             Task ++;
1720  0044 7b01          	ld	a,(OFST+0,sp)
1721  0046 ab07          	add	a,#7
1722  0048 6b01          	ld	(OFST+0,sp),a
1723                     ; 134         } while (++_OS_Temp < OS_TASKS);    
1725  004a 3c1c          	inc	__OS_Temp
1726  004c b61c          	ld	a,__OS_Temp
1727  004e a103          	cp	a,#3
1728  0050 25ba          	jrult	L154
1729                     ; 137         _OS_Flags.bError = 1;
1731  0052 7212001d      	bset	__OS_Flags,#1
1732                     ; 139         return ;
1733  0056               L66:
1736  0056 85            	popw	x
1737  0057 81            	ret	
2067                     	xdef	__OS_ClrReadySetClrCanContinue
2068                     	switch	.ubsct
2069  0000               __OS_Temp_I:
2070  0000 00            	ds.b	1
2071                     	xdef	__OS_Temp_I
2072                     	xdef	_OS_Timer
2073                     	xdef	__OS_InitDelay
2074                     	xdef	__OS_Task_Create
2075  0001               __OS_Tasks:
2076  0001 000000000000  	ds.b	21
2077                     	xdef	__OS_Tasks
2078                     	xdef	_OS_LeaveCriticalSection
2079                     	xdef	_OS_EnterCriticalSection
2080                     	xdef	_OS_Init
2081  0016               __OS_LastTask:
2082  0016 00            	ds.b	1
2083                     	xdef	__OS_LastTask
2084  0017               __OS_BestTask:
2085  0017 00            	ds.b	1
2086                     	xdef	__OS_BestTask
2087  0018               __OS_Best_Priority:
2088  0018 00            	ds.b	1
2089                     	xdef	__OS_Best_Priority
2090  0019               __OS_CurTask:
2091  0019 00            	ds.b	1
2092                     	xdef	__OS_CurTask
2093  001a               __OS_State:
2094  001a 00            	ds.b	1
2095                     	xdef	__OS_State
2096  001b               __OS_TempH:
2097  001b 00            	ds.b	1
2098                     	xdef	__OS_TempH
2099  001c               __OS_Temp:
2100  001c 00            	ds.b	1
2101                     	xdef	__OS_Temp
2102  001d               __OS_Flags:
2103  001d 00            	ds.b	1
2104                     	xdef	__OS_Flags
2105                     	xdef	__OS_RI_INT
2106                     	xdef	__OS_DI_INT
2107                     	xdef	_OS_RI
2108                     	xdef	_OS_DI
2109                     	xdef	__OS_CheckEvent
2110                     	xdef	__OS_EnterWaitModeTO
2111                     	xdef	__OS_EnterWaitMode
2112                     	xdef	__OS_ReturnNoSave
2113                     	xdef	__OS_ReturnSave
2114                     	xdef	__OS_JumpToTask
2115  001e               __OS_SP_Temp:
2116  001e 0000          	ds.b	2
2117                     	xdef	__OS_SP_Temp
2137                     	end
