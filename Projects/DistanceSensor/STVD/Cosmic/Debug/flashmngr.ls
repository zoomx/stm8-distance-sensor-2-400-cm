   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  50                     ; 63 u8 FlashMngr_GetStatus()
  50                     ; 64 {
  52                     .text:	section	.text,new
  53  0000               _FlashMngr_GetStatus:
  57                     ; 65   return EXTFLASH_STAT.Status;
  59  0000 b60c          	ld	a,L3_EXTFLASH_STAT
  62  0002 81            	ret	
  87                     ; 68 u8 FlashMngr_GetErrors()
  87                     ; 69 {
  88                     .text:	section	.text,new
  89  0000               _FlashMngr_GetErrors:
  93                     ; 70   return EXTFLASH_ERR.Error;
  95  0000 b60b          	ld	a,L5_EXTFLASH_ERR
  98  0002 81            	ret	
 151                     ; 73 _Bool FlashMngr_Init()
 151                     ; 74 {
 152                     .text:	section	.text,new
 153  0000               _FlashMngr_Init:
 155  0000 89            	pushw	x
 156       00000002      OFST:	set	2
 159                     ; 78   SST25VF016_Init();
 161  0001 cd0000        	call	_SST25VF016_Init
 163                     ; 79   tmpstatus = SST25VF016_Read_Status_Register();
 165  0004 cd0000        	call	_SST25VF016_Read_Status_Register
 167                     ; 80   flash_ptr.adr32b = DATA_STORAGE_BASE;
 169  0007 ae1000        	ldw	x,#4096
 170  000a bf06          	ldw	L31_flash_ptr+2,x
 171  000c 5f            	clrw	x
 172  000d bf04          	ldw	L31_flash_ptr,x
 173                     ; 81   pointer_adr.adr32b = PTR_ARR_BASE;
 175  000f bf02          	ldw	L51_pointer_adr+2,x
 176  0011 bf00          	ldw	L51_pointer_adr,x
 177                     ; 82   DisableMemOP = FALSE;
 179  0013 72110000      	bres	L7_DisableMemOP
 180                     ; 83   tmp = FlashMngr_GetPointer();
 182  0017 cd0000        	call	_FlashMngr_GetPointer
 184  001a 6b02          	ld	(OFST+0,sp),a
 185                     ; 85   SST25VF016_Write_Status_Register(FLASH_UNLOCK_VAL); 
 187  001c 4f            	clr	a
 188  001d cd0000        	call	_SST25VF016_Write_Status_Register
 190                     ; 87   if(SST25VF016_Read_Status_Register() & (STATUS_BP0 | STATUS_BP1 | STATUS_BP2))
 192  0020 cd0000        	call	_SST25VF016_Read_Status_Register
 194  0023 a51c          	bcp	a,#28
 195  0025 2706          	jreq	L76
 196                     ; 89     EXTFLASH_ERR.Error_bits.Memory_Locked_ERR = 1;
 198  0027 721c000b      	bset	L5_EXTFLASH_ERR,#6
 199                     ; 90     return FALSE;
 201  002b 2008          	jp	L42
 202  002d               L76:
 203                     ; 92   return tmp;
 205  002d 7b02          	ld	a,(OFST+0,sp)
 206  002f 2704          	jreq	L42
 207  0031 a601          	ld	a,#1
 208  0033 2001          	jra	L62
 209  0035               L42:
 211  0035 4f            	clr	a
 212  0036               L62:
 215  0036 85            	popw	x
 216  0037 81            	ret	
 323                     ; 98 u32 FlashMngr_ReadPointer(ExtFlashAdr ptr_adr)
 323                     ; 99 {
 324                     .text:	section	.text,new
 325  0000               _FlashMngr_ReadPointer:
 327  0000 5204          	subw	sp,#4
 328       00000004      OFST:	set	4
 331                     ; 101   ptr.adr32b = 0;
 333  0002 5f            	clrw	x
 334  0003 1f03          	ldw	(OFST-1,sp),x
 335  0005 1f01          	ldw	(OFST-3,sp),x
 336                     ; 102   SST25VF016_Read(ptr_adr, buffer, 3);
 338  0007 ae0003        	ldw	x,#3
 339  000a 89            	pushw	x
 340  000b ae0008        	ldw	x,#L11_buffer
 341  000e 89            	pushw	x
 342  000f 7b0e          	ld	a,(OFST+10,sp)
 343  0011 88            	push	a
 344  0012 7b0e          	ld	a,(OFST+10,sp)
 345  0014 88            	push	a
 346  0015 7b0e          	ld	a,(OFST+10,sp)
 347  0017 88            	push	a
 348  0018 7b0e          	ld	a,(OFST+10,sp)
 349  001a 88            	push	a
 350  001b cd0000        	call	_SST25VF016_Read
 352  001e 5b08          	addw	sp,#8
 353                     ; 103   ptr.adr8b.HighByte = buffer[0];
 355  0020 b608          	ld	a,L11_buffer
 356  0022 6b02          	ld	(OFST-2,sp),a
 357                     ; 104   ptr.adr8b.MidByte = buffer[1];
 359  0024 b609          	ld	a,L11_buffer+1
 360  0026 6b03          	ld	(OFST-1,sp),a
 361                     ; 105   ptr.adr8b.LowByte = buffer[2];
 363  0028 b60a          	ld	a,L11_buffer+2
 364  002a 6b04          	ld	(OFST+0,sp),a
 365                     ; 106   return ptr.adr32b;
 367  002c 96            	ldw	x,sp
 368  002d 5c            	incw	x
 369  002e cd0000        	call	c_ltor
 373  0031 5b04          	addw	sp,#4
 374  0033 81            	ret	
 471                     .const:	section	.text
 472  0000               L24:
 473  0000 00200000      	dc.l	2097152
 474  0004               L44:
 475  0004 00ffffff      	dc.l	16777215
 476                     ; 112 _Bool FlashMngr_GetPointer()
 476                     ; 113 {
 477                     .text:	section	.text,new
 478  0000               _FlashMngr_GetPointer:
 480  0000 5213          	subw	sp,#19
 481       00000013      OFST:	set	19
 484                     ; 114   u32 ptr_old, ptr_new = 0;
 486  0002 5f            	clrw	x
 487  0003 1f0e          	ldw	(OFST-5,sp),x
 488  0005 1f0c          	ldw	(OFST-7,sp),x
 489                     ; 116   s16 imin, imid = 0, imax;
 491  0007 1f0a          	ldw	(OFST-9,sp),x
 492                     ; 118   if(EXTFLASH_ERR.Error_bits.Inconsistent_ERR)
 494  0009 7201000b02    	btjf	L5_EXTFLASH_ERR,#0,L702
 495                     ; 120     return FALSE;
 497  000e 2030          	jp	LC002
 498  0010               L702:
 499                     ; 122   tmpadr.adr32b = PTR_ARR_BASE;
 501  0010 1f12          	ldw	(OFST-1,sp),x
 502  0012 1f10          	ldw	(OFST-3,sp),x
 503                     ; 123   ptr_old = FlashMngr_ReadPointer(tmpadr);
 505  0014 7b13          	ld	a,(OFST+0,sp)
 506  0016 88            	push	a
 507  0017 7b13          	ld	a,(OFST+0,sp)
 508  0019 88            	push	a
 509  001a 7b13          	ld	a,(OFST+0,sp)
 510  001c 88            	push	a
 511  001d 7b13          	ld	a,(OFST+0,sp)
 512  001f 88            	push	a
 513  0020 cd0000        	call	_FlashMngr_ReadPointer
 515  0023 5b04          	addw	sp,#4
 516  0025 96            	ldw	x,sp
 517  0026 5c            	incw	x
 518  0027 cd0000        	call	c_rtol
 520                     ; 124   if(INVALID_ADR(ptr_old))
 522  002a 96            	ldw	x,sp
 523  002b 5c            	incw	x
 524  002c cd0171        	call	LC010
 526  002f 2513          	jrult	L112
 528  0031 96            	ldw	x,sp
 529  0032 5c            	incw	x
 530  0033 cd0157        	call	LC008
 532  0036 240c          	jruge	L112
 533                     ; 126     EXTFLASH_ERR.Error_bits.Invalid_FlashPtr_ERR = 1;
 535  0038               LC004:
 537  0038 7214000b      	bset	L5_EXTFLASH_ERR,#2
 538                     ; 127     EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
 540  003c               LC003:
 543  003c 7210000b      	bset	L5_EXTFLASH_ERR,#0
 544                     ; 128     return FALSE;
 546  0040               LC002:
 550  0040 4f            	clr	a
 552  0041               L45:
 554  0041 5b13          	addw	sp,#19
 555  0043 81            	ret	
 556  0044               L112:
 557                     ; 130   if(ptr_old == PTR_ERASED_VAL)
 559  0044 96            	ldw	x,sp
 560  0045 5c            	incw	x
 561  0046 cd0157        	call	LC008
 563  0049 2642          	jrne	L312
 564                     ; 133     tmpadr.adr32b = DATA_STORAGE_BASE;
 566  004b ae1000        	ldw	x,#4096
 567  004e 1f12          	ldw	(OFST-1,sp),x
 568  0050 5f            	clrw	x
 569  0051 1f10          	ldw	(OFST-3,sp),x
 570                     ; 134     for(i = 0; i < TEST_ERASED_BYTES_NUM; i++)
 572  0053 0f05          	clr	(OFST-14,sp)
 573  0055               L512:
 574                     ; 136       if(SST25VF016_Read_Byte(tmpadr) != BYTE_ERASED_VAL) 
 576  0055 7b13          	ld	a,(OFST+0,sp)
 577  0057 88            	push	a
 578  0058 7b13          	ld	a,(OFST+0,sp)
 579  005a 88            	push	a
 580  005b 7b13          	ld	a,(OFST+0,sp)
 581  005d 88            	push	a
 582  005e 7b13          	ld	a,(OFST+0,sp)
 583  0060 88            	push	a
 584  0061 cd0000        	call	_SST25VF016_Read_Byte
 586  0064 5b04          	addw	sp,#4
 587  0066 4c            	inc	a
 588                     ; 138         EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
 589                     ; 139         return FALSE;
 591  0067 26d3          	jrne	LC003
 592                     ; 141       tmpadr.adr32b++;
 594  0069 96            	ldw	x,sp
 595  006a 1c0010        	addw	x,#OFST-3
 596  006d 4c            	inc	a
 597  006e cd0000        	call	c_lgadc
 599                     ; 134     for(i = 0; i < TEST_ERASED_BYTES_NUM; i++)
 601  0071 0c05          	inc	(OFST-14,sp)
 604  0073 7b05          	ld	a,(OFST-14,sp)
 605  0075 a10a          	cp	a,#10
 606  0077 25dc          	jrult	L512
 607                     ; 143     flash_ptr.adr32b = DATA_STORAGE_BASE;
 609  0079 ae1000        	ldw	x,#4096
 610  007c bf06          	ldw	L31_flash_ptr+2,x
 611  007e 5f            	clrw	x
 612  007f bf04          	ldw	L31_flash_ptr,x
 613                     ; 144     pointer_adr.adr32b = PTR_ARR_BASE;
 615  0081 bf02          	ldw	L51_pointer_adr+2,x
 616  0083 bf00          	ldw	L51_pointer_adr,x
 617                     ; 145     EXTFLASH_STAT.Status_bits.FlashPtr_was_Read = 1;
 619  0085               LC006:
 621  0085 7212000c      	bset	L3_EXTFLASH_STAT,#1
 622                     ; 146     return TRUE;
 624  0089               LC005:
 627  0089 a601          	ld	a,#1
 629  008b 20b4          	jra	L45
 630  008d               L312:
 631                     ; 149   imin = 0;
 633  008d 5f            	clrw	x
 634  008e 1f06          	ldw	(OFST-13,sp),x
 635                     ; 150   imax = PTR_ARR_LEN - 1;
 637  0090 ae0554        	ldw	x,#1364
 639  0093 2050          	jp	LC007
 640  0095               L522:
 641                     ; 153     imid = (imin + imax) / 2;
 643  0095 1e06          	ldw	x,(OFST-13,sp)
 644  0097 72fb08        	addw	x,(OFST-11,sp)
 645  009a a602          	ld	a,#2
 646  009c cd0000        	call	c_sdivx
 648  009f 1f0a          	ldw	(OFST-9,sp),x
 649                     ; 154     tmpadr.adr32b = PTR_ARR_BASE + ((imid) * PTR_SIZE);
 651  00a1 90ae0003      	ldw	y,#3
 652  00a5 cd0000        	call	c_imul
 654  00a8 cd0000        	call	c_itolx
 656  00ab 96            	ldw	x,sp
 657  00ac 1c0010        	addw	x,#OFST-3
 658  00af cd0000        	call	c_rtol
 660                     ; 155     ptr_new = FlashMngr_ReadPointer(tmpadr);
 662  00b2 7b13          	ld	a,(OFST+0,sp)
 663  00b4 88            	push	a
 664  00b5 7b13          	ld	a,(OFST+0,sp)
 665  00b7 88            	push	a
 666  00b8 7b13          	ld	a,(OFST+0,sp)
 667  00ba 88            	push	a
 668  00bb 7b13          	ld	a,(OFST+0,sp)
 669  00bd 88            	push	a
 670  00be cd0000        	call	_FlashMngr_ReadPointer
 672  00c1 5b04          	addw	sp,#4
 673  00c3 96            	ldw	x,sp
 674  00c4 1c000c        	addw	x,#OFST-7
 675  00c7 cd0000        	call	c_rtol
 677                     ; 156     if(ptr_new < PTR_ERASED_VAL) 
 679  00ca 96            	ldw	x,sp
 680  00cb 1c000c        	addw	x,#OFST-7
 681  00ce cd0157        	call	LC008
 683  00d1 2407          	jruge	L532
 684                     ; 158       imin = imid + 1;
 686  00d3 1e0a          	ldw	x,(OFST-9,sp)
 687  00d5 5c            	incw	x
 688  00d6 1f06          	ldw	(OFST-13,sp),x
 690  00d8 200d          	jra	L132
 691  00da               L532:
 692                     ; 162       if(ptr_new == PTR_ERASED_VAL)
 694  00da 96            	ldw	x,sp
 695  00db 1c000c        	addw	x,#OFST-7
 696  00de ad77          	call	LC008
 698  00e0 2605          	jrne	L132
 699                     ; 164         imax = imid - 1;
 701  00e2 1e0a          	ldw	x,(OFST-9,sp)
 702  00e4 5a            	decw	x
 703  00e5               LC007:
 704  00e5 1f08          	ldw	(OFST-11,sp),x
 705  00e7               L132:
 706                     ; 151   while(imax >= imin)
 708  00e7 1e08          	ldw	x,(OFST-11,sp)
 709  00e9 1306          	cpw	x,(OFST-13,sp)
 710  00eb 2ea8          	jrsge	L522
 711                     ; 169   if(ptr_new == PTR_ERASED_VAL)
 713  00ed 96            	ldw	x,sp
 714  00ee 1c000c        	addw	x,#OFST-7
 715  00f1 ad64          	call	LC008
 717  00f3 2642          	jrne	L342
 718                     ; 171     tmpadr.adr32b -= PTR_SIZE;                //position to the element before the erased value
 720  00f5 96            	ldw	x,sp
 721  00f6 1c0010        	addw	x,#OFST-3
 722  00f9 a603          	ld	a,#3
 723  00fb cd0000        	call	c_lgsbc
 725                     ; 172     ptr_new = FlashMngr_ReadPointer(tmpadr);  //read the flash pointer there
 727  00fe 7b13          	ld	a,(OFST+0,sp)
 728  0100 88            	push	a
 729  0101 7b13          	ld	a,(OFST+0,sp)
 730  0103 88            	push	a
 731  0104 7b13          	ld	a,(OFST+0,sp)
 732  0106 88            	push	a
 733  0107 7b13          	ld	a,(OFST+0,sp)
 734  0109 88            	push	a
 735  010a cd0000        	call	_FlashMngr_ReadPointer
 737  010d 5b04          	addw	sp,#4
 738  010f 96            	ldw	x,sp
 739  0110 1c000c        	addw	x,#OFST-7
 740  0113 cd0000        	call	c_rtol
 742                     ; 173     if(INVALID_ADR(ptr_new))
 744  0116 96            	ldw	x,sp
 745  0117 1c000c        	addw	x,#OFST-7
 746  011a ad55          	call	LC010
 748  011c 250b          	jrult	L542
 750  011e 96            	ldw	x,sp
 751  011f 1c000c        	addw	x,#OFST-7
 752  0122 ad33          	call	LC008
 754                     ; 176       EXTFLASH_ERR.Error_bits.Invalid_FlashPtr_ERR = 1;
 755                     ; 177       EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
 756                     ; 178       return FALSE;
 758  0124 2403cc0038    	jrult	LC004
 759  0129               L542:
 760                     ; 181     flash_ptr.adr32b = ptr_new;
 762  0129 1e0e          	ldw	x,(OFST-5,sp)
 763  012b bf06          	ldw	L31_flash_ptr+2,x
 764  012d 1e0c          	ldw	x,(OFST-7,sp)
 765  012f bf04          	ldw	L31_flash_ptr,x
 766                     ; 182     pointer_adr.adr32b = tmpadr.adr32b + PTR_SIZE;
 768  0131 96            	ldw	x,sp
 769  0132 ad2c          	call	LC009
 771                     ; 183     EXTFLASH_STAT.Status_bits.FlashPtr_was_Read = 1;
 772                     ; 184     return TRUE;
 774  0134 cc0085        	jp	LC006
 775  0137               L342:
 776                     ; 187   flash_ptr.adr32b = ptr_new;
 778  0137 1e0e          	ldw	x,(OFST-5,sp)
 779  0139 bf06          	ldw	L31_flash_ptr+2,x
 780  013b 1e0c          	ldw	x,(OFST-7,sp)
 781  013d bf04          	ldw	L31_flash_ptr,x
 782                     ; 188   pointer_adr.adr32b = tmpadr.adr32b + PTR_SIZE;
 784  013f 96            	ldw	x,sp
 785  0140 ad1e          	call	LC009
 787                     ; 189   EXTFLASH_STAT.Status_bits.FlashPtr_was_Read = 1;
 789  0142 7212000c      	bset	L3_EXTFLASH_STAT,#1
 790                     ; 190   if(imid == (PTR_ARR_LEN - 1))
 792  0146 1e0a          	ldw	x,(OFST-9,sp)
 793  0148 a30554        	cpw	x,#1364
 794  014b 2703cc0089    	jrne	LC005
 795                     ; 192     EXTFLASH_STAT.Status_bits.PTR_ARR_Full = 1;
 797  0150 7210000c      	bset	L3_EXTFLASH_STAT,#0
 798                     ; 194   return TRUE;
 800  0154 cc0089        	jp	LC005
 801  0157               LC008:
 802  0157 cd0000        	call	c_ltor
 804  015a ae0004        	ldw	x,#L44
 805  015d cc0000        	jp	c_lcmp
 806  0160               LC009:
 807  0160 1c0010        	addw	x,#OFST-3
 808  0163 cd0000        	call	c_ltor
 810  0166 a603          	ld	a,#3
 811  0168 cd0000        	call	c_ladc
 813  016b ae0000        	ldw	x,#L51_pointer_adr
 814  016e cc0000        	jp	c_rtol
 815  0171               LC010:
 816  0171 cd0000        	call	c_ltor
 818  0174 ae0000        	ldw	x,#L24
 819  0177 cc0000        	jp	c_lcmp
 883                     	switch	.const
 884  0008               L47:
 885  0008 00000fff      	dc.l	4095
 886                     ; 197 _Bool FlashMngr_SavePointer(ExtFlashAdr adr)
 886                     ; 198 {
 887                     .text:	section	.text,new
 888  0000               _FlashMngr_SavePointer:
 890  0000 5208          	subw	sp,#8
 891       00000008      OFST:	set	8
 894                     ; 201   if(EXTFLASH_ERR.Error_bits.Memory_Locked_ERR || DisableMemOP)
 896  0002 720c000b05    	btjt	L5_EXTFLASH_ERR,#6,L103
 898  0007 7201000003    	btjf	L7_DisableMemOP,L772
 899  000c               L103:
 900                     ; 204     EXTFLASH_STAT.Status_bits.Operation_refused = 1;
 901                     ; 205     return FALSE;
 903  000c cc00c3        	jp	L303
 904  000f               L772:
 905                     ; 207   if(EXTFLASH_STAT.Status_bits.FlashPtr_was_Read)
 907  000f 7203000cf8    	btjf	L3_EXTFLASH_STAT,#1,L303
 908                     ; 209     EXTFLASH_STAT.Status_bits.Operation_refused = 0;
 910  0014 721b000c      	bres	L3_EXTFLASH_STAT,#5
 911                     ; 211     if(EXTFLASH_STAT.Status_bits.PTR_ARR_Full)
 913  0018 7201000c4b    	btjf	L3_EXTFLASH_STAT,#0,L503
 914                     ; 213       tmpadr.adr32b = PTR_ARR_BASE;
 916  001d 5f            	clrw	x
 917  001e 1f07          	ldw	(OFST-1,sp),x
 918  0020 1f05          	ldw	(OFST-3,sp),x
 919                     ; 214       SST25VF016_Sector_Erase_4KB(tmpadr);
 921  0022 7b08          	ld	a,(OFST+0,sp)
 922  0024 88            	push	a
 923  0025 7b08          	ld	a,(OFST+0,sp)
 924  0027 88            	push	a
 925  0028 7b08          	ld	a,(OFST+0,sp)
 926  002a 88            	push	a
 927  002b 7b08          	ld	a,(OFST+0,sp)
 928  002d 88            	push	a
 929  002e cd0000        	call	_SST25VF016_Sector_Erase_4KB
 931  0031 5b04          	addw	sp,#4
 933  0033               L113:
 934                     ; 216       while(SST25VF016_Read_Status_Register() & STATUS_BUSY);
 936  0033 cd0000        	call	_SST25VF016_Read_Status_Register
 938  0036 a501          	bcp	a,#1
 939  0038 26f9          	jrne	L113
 940                     ; 218       if(FlashMngr_ReadPointer(tmpadr) != PTR_ERASED_VAL) 
 942  003a 7b08          	ld	a,(OFST+0,sp)
 943  003c 88            	push	a
 944  003d 7b08          	ld	a,(OFST+0,sp)
 945  003f 88            	push	a
 946  0040 7b08          	ld	a,(OFST+0,sp)
 947  0042 88            	push	a
 948  0043 7b08          	ld	a,(OFST+0,sp)
 949  0045 88            	push	a
 950  0046 cd0000        	call	_FlashMngr_ReadPointer
 952  0049 5b04          	addw	sp,#4
 953  004b ae0004        	ldw	x,#L44
 954  004e cd0000        	call	c_lcmp
 956  0051 270c          	jreq	L513
 957                     ; 220         EXTFLASH_ERR.Error_bits.PTR_SEC_Erase_ERR = 1;
 959  0053 7216000b      	bset	L5_EXTFLASH_ERR,#3
 960                     ; 221         EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
 962  0057               LC012:
 964  0057 7210000b      	bset	L5_EXTFLASH_ERR,#0
 965                     ; 222         return FALSE;
 967  005b               LC011:
 971  005b 4f            	clr	a
 973  005c               L001:
 975  005c 5b08          	addw	sp,#8
 976  005e 81            	ret	
 977  005f               L513:
 978                     ; 224       EXTFLASH_STAT.Status_bits.PTR_ARR_Full = 0;
 980  005f 7211000c      	bres	L3_EXTFLASH_STAT,#0
 981                     ; 225       pointer_adr.adr32b = PTR_ARR_BASE;
 983  0063 5f            	clrw	x
 984  0064 bf02          	ldw	L51_pointer_adr+2,x
 985  0066 bf00          	ldw	L51_pointer_adr,x
 986  0068               L503:
 987                     ; 228     SST25VF016_Program_Byte(pointer_adr, adr.adr8b.HighByte);
 989  0068 7b0c          	ld	a,(OFST+4,sp)
 990  006a ad5d          	call	LC014
 992                     ; 230     SST25VF016_Program_Byte(pointer_adr, adr.adr8b.MidByte);
 994  006c 7b0d          	ld	a,(OFST+5,sp)
 995  006e ad59          	call	LC014
 997                     ; 232     SST25VF016_Program_Byte(pointer_adr, adr.adr8b.LowByte);
 999  0070 7b0e          	ld	a,(OFST+6,sp)
1000  0072 ad55          	call	LC014
1002                     ; 235     if(PTR_OUT_OF_ARR(pointer_adr.adr32b))
1004  0074 cd0000        	call	c_ltor
1006  0077 ae0008        	ldw	x,#L47
1007  007a cd0000        	call	c_lcmp
1009  007d 2504          	jrult	L713
1010                     ; 237       EXTFLASH_STAT.Status_bits.PTR_ARR_Full = 1;
1012  007f 7210000c      	bset	L3_EXTFLASH_STAT,#0
1013  0083               L713:
1014                     ; 240     tmpadr.adr32b = pointer_adr.adr32b - PTR_SIZE;
1016  0083 ae0000        	ldw	x,#L51_pointer_adr
1017  0086 cd0000        	call	c_ltor
1019  0089 a603          	ld	a,#3
1020  008b cd0000        	call	c_lsbc
1022  008e 96            	ldw	x,sp
1023  008f 1c0005        	addw	x,#OFST-3
1024  0092 cd0000        	call	c_rtol
1026                     ; 241     tmp = FlashMngr_ReadPointer(tmpadr);
1028  0095 7b08          	ld	a,(OFST+0,sp)
1029  0097 88            	push	a
1030  0098 7b08          	ld	a,(OFST+0,sp)
1031  009a 88            	push	a
1032  009b 7b08          	ld	a,(OFST+0,sp)
1033  009d 88            	push	a
1034  009e 7b08          	ld	a,(OFST+0,sp)
1035  00a0 88            	push	a
1036  00a1 cd0000        	call	_FlashMngr_ReadPointer
1038  00a4 5b04          	addw	sp,#4
1039  00a6 96            	ldw	x,sp
1040  00a7 5c            	incw	x
1041  00a8 cd0000        	call	c_rtol
1043                     ; 242     if(tmp == adr.adr32b) return TRUE;
1045  00ab 96            	ldw	x,sp
1046  00ac 5c            	incw	x
1047  00ad cd0000        	call	c_ltor
1049  00b0 96            	ldw	x,sp
1050  00b1 1c000b        	addw	x,#OFST+3
1051  00b4 cd0000        	call	c_lcmp
1053  00b7 2604          	jrne	L123
1056  00b9 a601          	ld	a,#1
1058  00bb 209f          	jra	L001
1059  00bd               L123:
1060                     ; 244     EXTFLASH_ERR.Error_bits.Data_Store_ERR = 1;
1062  00bd 721a000b      	bset	L5_EXTFLASH_ERR,#5
1063                     ; 245     EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
1064                     ; 246     return FALSE;
1066  00c1 2094          	jp	LC012
1067  00c3               L303:
1068                     ; 249   EXTFLASH_STAT.Status_bits.Operation_refused = 1;
1071  00c3 721a000c      	bset	L3_EXTFLASH_STAT,#5
1072                     ; 250   return FALSE;
1074  00c7 2092          	jp	LC011
1075  00c9               LC014:
1076  00c9 88            	push	a
1077  00ca b603          	ld	a,L51_pointer_adr+3
1078  00cc 88            	push	a
1079  00cd b602          	ld	a,L51_pointer_adr+2
1080  00cf 88            	push	a
1081  00d0 b601          	ld	a,L51_pointer_adr+1
1082  00d2 88            	push	a
1083  00d3 b600          	ld	a,L51_pointer_adr
1084  00d5 88            	push	a
1085  00d6 cd0000        	call	_SST25VF016_Program_Byte
1087  00d9 5b05          	addw	sp,#5
1088                     ; 229     pointer_adr.adr32b++;
1090  00db ae0000        	ldw	x,#L51_pointer_adr
1091  00de a601          	ld	a,#1
1092  00e0 cc0000        	jp	c_lgadc
1163                     ; 253 _Bool FlashMngr_StoreData(u8* data, u16 size)
1163                     ; 254 {
1164                     .text:	section	.text,new
1165  0000               _FlashMngr_StoreData:
1167  0000 89            	pushw	x
1168  0001 89            	pushw	x
1169       00000002      OFST:	set	2
1172                     ; 256   if(EXTFLASH_ERR.Error_bits.Memory_Locked_ERR || DisableMemOP)
1174  0002 720c000b05    	btjt	L5_EXTFLASH_ERR,#6,L753
1176  0007 7201000006    	btjf	L7_DisableMemOP,L553
1177  000c               L753:
1178                     ; 259     EXTFLASH_STAT.Status_bits.Operation_refused = 1;
1180  000c 721a000c      	bset	L3_EXTFLASH_STAT,#5
1181                     ; 260     return FALSE;
1183  0010 2024          	jp	LC015
1184  0012               L553:
1185                     ; 262   if(EXTFLASH_STAT.Status_bits.FlashPtr_was_Read)
1187  0012 7202000c03cc  	btjf	L3_EXTFLASH_STAT,#1,L163
1188                     ; 264     EXTFLASH_STAT.Status_bits.Operation_refused = 0;
1190  001a 721b000c      	bres	L3_EXTFLASH_STAT,#5
1191                     ; 266     if(flash_ptr.adr32b + (size-1) > FLASH_MAX_ADR) 
1193  001e 1e07          	ldw	x,(OFST+5,sp)
1194  0020 5a            	decw	x
1195  0021 cd0000        	call	c_uitolx
1197  0024 ae0004        	ldw	x,#L31_flash_ptr
1198  0027 cd0000        	call	c_ladd
1200  002a ae0000        	ldw	x,#L24
1201  002d cd0000        	call	c_lcmp
1203  0030 2508          	jrult	L363
1204                     ; 268       EXTFLASH_STAT.Status_bits.Flash_no_space = 1;
1206  0032 7218000c      	bset	L3_EXTFLASH_STAT,#4
1207                     ; 269       return FALSE;
1209  0036               LC015:
1213  0036 4f            	clr	a
1215  0037               L611:
1217  0037 5b04          	addw	sp,#4
1218  0039 81            	ret	
1219  003a               L363:
1220                     ; 271     EXTFLASH_STAT.Status_bits.Flash_no_space = 0;
1222  003a 7219000c      	bres	L3_EXTFLASH_STAT,#4
1223                     ; 272     for(i = 0; i < size; i++)
1225  003e 0f02          	clr	(OFST+0,sp)
1227  0040 2053          	jra	L173
1228  0042               L563:
1229                     ; 274       SST25VF016_Program_Byte(flash_ptr, data[i]);
1231  0042 7b03          	ld	a,(OFST+1,sp)
1232  0044 97            	ld	xl,a
1233  0045 7b04          	ld	a,(OFST+2,sp)
1234  0047 1b02          	add	a,(OFST+0,sp)
1235  0049 2401          	jrnc	L601
1236  004b 5c            	incw	x
1237  004c               L601:
1238  004c 02            	rlwa	x,a
1239  004d f6            	ld	a,(x)
1240  004e 88            	push	a
1241  004f b607          	ld	a,L31_flash_ptr+3
1242  0051 88            	push	a
1243  0052 b606          	ld	a,L31_flash_ptr+2
1244  0054 88            	push	a
1245  0055 b605          	ld	a,L31_flash_ptr+1
1246  0057 88            	push	a
1247  0058 b604          	ld	a,L31_flash_ptr
1248  005a 88            	push	a
1249  005b cd0000        	call	_SST25VF016_Program_Byte
1251  005e 5b05          	addw	sp,#5
1252                     ; 276       tmp = SST25VF016_Read_Byte(flash_ptr);
1254  0060 b607          	ld	a,L31_flash_ptr+3
1255  0062 88            	push	a
1256  0063 b606          	ld	a,L31_flash_ptr+2
1257  0065 88            	push	a
1258  0066 b605          	ld	a,L31_flash_ptr+1
1259  0068 88            	push	a
1260  0069 b604          	ld	a,L31_flash_ptr
1261  006b 88            	push	a
1262  006c cd0000        	call	_SST25VF016_Read_Byte
1264  006f 5b04          	addw	sp,#4
1265  0071 6b01          	ld	(OFST-1,sp),a
1266                     ; 277       flash_ptr.adr32b++;
1268  0073 ae0004        	ldw	x,#L31_flash_ptr
1269  0076 a601          	ld	a,#1
1270  0078 cd0000        	call	c_lgadc
1272                     ; 279       if(tmp != data[i])
1274  007b 7b03          	ld	a,(OFST+1,sp)
1275  007d 97            	ld	xl,a
1276  007e 7b04          	ld	a,(OFST+2,sp)
1277  0080 1b02          	add	a,(OFST+0,sp)
1278  0082 2401          	jrnc	L211
1279  0084 5c            	incw	x
1280  0085               L211:
1281  0085 02            	rlwa	x,a
1282  0086 f6            	ld	a,(x)
1283  0087 1101          	cp	a,(OFST-1,sp)
1284  0089 2708          	jreq	L573
1285                     ; 281         EXTFLASH_ERR.Error_bits.Data_Store_ERR = 1;
1287                     ; 282         EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
1289                     ; 283         return FALSE;
1291  008b b60b          	ld	a,L5_EXTFLASH_ERR
1292  008d aa21          	or	a,#33
1293  008f b70b          	ld	L5_EXTFLASH_ERR,a
1294  0091 20a3          	jp	LC015
1295  0093               L573:
1296                     ; 272     for(i = 0; i < size; i++)
1298  0093 0c02          	inc	(OFST+0,sp)
1299  0095               L173:
1302  0095 7b02          	ld	a,(OFST+0,sp)
1303  0097 5f            	clrw	x
1304  0098 97            	ld	xl,a
1305  0099 1307          	cpw	x,(OFST+5,sp)
1306  009b 25a5          	jrult	L563
1307                     ; 286     FlashMngr_SavePointer(flash_ptr);
1309  009d b607          	ld	a,L31_flash_ptr+3
1310  009f 88            	push	a
1311  00a0 b606          	ld	a,L31_flash_ptr+2
1312  00a2 88            	push	a
1313  00a3 b605          	ld	a,L31_flash_ptr+1
1314  00a5 88            	push	a
1315  00a6 b604          	ld	a,L31_flash_ptr
1316  00a8 88            	push	a
1317  00a9 cd0000        	call	_FlashMngr_SavePointer
1319  00ac 5b04          	addw	sp,#4
1320                     ; 287     return TRUE;
1322  00ae a601          	ld	a,#1
1324  00b0 2085          	jra	L611
1325  00b2               L163:
1326                     ; 290   EXTFLASH_STAT.Status_bits.Operation_refused = 1;
1328  00b2 721a000c      	bset	L3_EXTFLASH_STAT,#5
1329                     ; 291   return FALSE;
1331  00b6 cc0036        	jp	LC015
1386                     ; 294 _Bool FlashMngr_EraseChip()
1386                     ; 295 {
1387                     .text:	section	.text,new
1388  0000               _FlashMngr_EraseChip:
1390  0000 5205          	subw	sp,#5
1391       00000005      OFST:	set	5
1394                     ; 298   if(EXTFLASH_ERR.Error_bits.Memory_Locked_ERR || DisableMemOP)
1396  0002 720c000b05    	btjt	L5_EXTFLASH_ERR,#6,L324
1398  0007 7201000003    	btjf	L7_DisableMemOP,L124
1399  000c               L324:
1400                     ; 301     EXTFLASH_STAT.Status_bits.Operation_refused = 1;
1401                     ; 302     return FALSE;
1403  000c cc0098        	jp	L524
1404  000f               L124:
1405                     ; 305   if(EXTFLASH_STAT.Status_bits.Flash_was_Read)
1407  000f 7207000cf8    	btjf	L3_EXTFLASH_STAT,#3,L524
1408                     ; 307     EXTFLASH_STAT.Status_bits.Operation_refused = 0;
1410  0014 721b000c      	bres	L3_EXTFLASH_STAT,#5
1411                     ; 308     SST25VF016_Chip_Erase();
1413  0018 cd0000        	call	_SST25VF016_Chip_Erase
1415                     ; 309     EXTFLASH_STAT.Status = 0;  //Reset status flags
1417  001b 3f0c          	clr	L3_EXTFLASH_STAT
1418                     ; 310     EXTFLASH_ERR.Error = 0;    //Reset error flags
1420  001d 3f0b          	clr	L5_EXTFLASH_ERR
1421                     ; 311     flash_ptr.adr32b = DATA_STORAGE_BASE;
1423  001f ae1000        	ldw	x,#4096
1424  0022 bf06          	ldw	L31_flash_ptr+2,x
1425  0024 5f            	clrw	x
1426  0025 bf04          	ldw	L31_flash_ptr,x
1427                     ; 312     pointer_adr.adr32b = PTR_ARR_BASE;
1429  0027 bf02          	ldw	L51_pointer_adr+2,x
1430  0029 bf00          	ldw	L51_pointer_adr,x
1432  002b               L334:
1433                     ; 315     while(SST25VF016_Read_Status_Register() & STATUS_BUSY);
1435  002b cd0000        	call	_SST25VF016_Read_Status_Register
1437  002e a501          	bcp	a,#1
1438  0030 26f9          	jrne	L334
1439                     ; 317     tmpadr.adr32b = DATA_STORAGE_BASE;
1441  0032 ae1000        	ldw	x,#4096
1442  0035 1f04          	ldw	(OFST-1,sp),x
1443  0037 5f            	clrw	x
1444  0038 1f02          	ldw	(OFST-3,sp),x
1445                     ; 318     for(i = 0; i < TEST_ERASED_BYTES_NUM; i++)
1447  003a 0f01          	clr	(OFST-4,sp)
1448  003c               L734:
1449                     ; 320       if(SST25VF016_Read_Byte(tmpadr) != BYTE_ERASED_VAL) 
1451  003c 7b05          	ld	a,(OFST+0,sp)
1452  003e 88            	push	a
1453  003f 7b05          	ld	a,(OFST+0,sp)
1454  0041 88            	push	a
1455  0042 7b05          	ld	a,(OFST+0,sp)
1456  0044 88            	push	a
1457  0045 7b05          	ld	a,(OFST+0,sp)
1458  0047 88            	push	a
1459  0048 cd0000        	call	_SST25VF016_Read_Byte
1461  004b 5b04          	addw	sp,#4
1462  004d 4c            	inc	a
1463  004e 270c          	jreq	L544
1464                     ; 322         EXTFLASH_ERR.Error_bits.Flash_Erase_ERR = 1;
1466  0050 7218000b      	bset	L5_EXTFLASH_ERR,#4
1467                     ; 323         EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
1469  0054               LC017:
1471  0054 7210000b      	bset	L5_EXTFLASH_ERR,#0
1472                     ; 324         return FALSE;
1474  0058               LC016:
1478  0058 4f            	clr	a
1480  0059               L231:
1482  0059 5b05          	addw	sp,#5
1483  005b 81            	ret	
1484  005c               L544:
1485                     ; 326       tmpadr.adr32b++;
1487  005c 96            	ldw	x,sp
1488  005d 1c0002        	addw	x,#OFST-3
1489  0060 4c            	inc	a
1490  0061 cd0000        	call	c_lgadc
1492                     ; 318     for(i = 0; i < TEST_ERASED_BYTES_NUM; i++)
1494  0064 0c01          	inc	(OFST-4,sp)
1497  0066 7b01          	ld	a,(OFST-4,sp)
1498  0068 a10a          	cp	a,#10
1499  006a 25d0          	jrult	L734
1500                     ; 328     tmpadr.adr32b = PTR_ARR_BASE;
1502  006c 5f            	clrw	x
1503  006d 1f04          	ldw	(OFST-1,sp),x
1504  006f 1f02          	ldw	(OFST-3,sp),x
1505                     ; 330     if(FlashMngr_ReadPointer(tmpadr) != PTR_ERASED_VAL) 
1507  0071 7b05          	ld	a,(OFST+0,sp)
1508  0073 88            	push	a
1509  0074 7b05          	ld	a,(OFST+0,sp)
1510  0076 88            	push	a
1511  0077 7b05          	ld	a,(OFST+0,sp)
1512  0079 88            	push	a
1513  007a 7b05          	ld	a,(OFST+0,sp)
1514  007c 88            	push	a
1515  007d cd0000        	call	_FlashMngr_ReadPointer
1517  0080 5b04          	addw	sp,#4
1518  0082 ae0004        	ldw	x,#L44
1519  0085 cd0000        	call	c_lcmp
1521  0088 2706          	jreq	L744
1522                     ; 332         EXTFLASH_ERR.Error_bits.PTR_SEC_Erase_ERR = 1;
1524  008a 7216000b      	bset	L5_EXTFLASH_ERR,#3
1525                     ; 333         EXTFLASH_ERR.Error_bits.Inconsistent_ERR = 1;
1526                     ; 334         return FALSE;
1528  008e 20c4          	jp	LC017
1529  0090               L744:
1530                     ; 337     EXTFLASH_STAT.Status_bits.FlashPtr_was_Read = 1;
1532  0090 7212000c      	bset	L3_EXTFLASH_STAT,#1
1533                     ; 338     return TRUE;
1535  0094 a601          	ld	a,#1
1537  0096 20c1          	jra	L231
1538  0098               L524:
1539                     ; 341   EXTFLASH_STAT.Status_bits.Operation_refused = 1;
1542  0098 721a000c      	bset	L3_EXTFLASH_STAT,#5
1543                     ; 342   return FALSE;
1545  009c 20ba          	jp	LC016
1581                     ; 345 u32 FlashMngr_GetFreeSpace()
1581                     ; 346 {
1582                     .text:	section	.text,new
1583  0000               _FlashMngr_GetFreeSpace:
1585  0000 5204          	subw	sp,#4
1586       00000004      OFST:	set	4
1589                     ; 348   tmp = FLASH_MAX_ADR - flash_ptr.adr32b + 1;
1591  0002 5f            	clrw	x
1592  0003 bf02          	ldw	c_lreg+2,x
1593  0005 ae0020        	ldw	x,#32
1594  0008 bf00          	ldw	c_lreg,x
1595  000a ae0004        	ldw	x,#L31_flash_ptr
1596  000d cd0000        	call	c_lsub
1598  0010 96            	ldw	x,sp
1599  0011 5c            	incw	x
1600  0012 cd0000        	call	c_rtol
1602                     ; 349   if(tmp < 0) tmp = 0;
1604  0015 7b01          	ld	a,(OFST-3,sp)
1605  0017 2a05          	jrpl	L764
1608  0019 5f            	clrw	x
1609  001a 1f03          	ldw	(OFST-1,sp),x
1610  001c 1f01          	ldw	(OFST-3,sp),x
1611  001e               L764:
1612                     ; 350   return (u32)(tmp);
1614  001e 96            	ldw	x,sp
1615  001f 5c            	incw	x
1616  0020 cd0000        	call	c_ltor
1620  0023 5b04          	addw	sp,#4
1621  0025 81            	ret	
1646                     	switch	.const
1647  000c               L041:
1648  000c 00001000      	dc.l	4096
1649                     ; 353 u32 FlashMngr_GetOccupiedSpace()
1649                     ; 354 {
1650                     .text:	section	.text,new
1651  0000               _FlashMngr_GetOccupiedSpace:
1655                     ; 355   return (u32)(flash_ptr.adr32b - DATA_STORAGE_BASE);
1657  0000 ae0004        	ldw	x,#L31_flash_ptr
1658  0003 cd0000        	call	c_ltor
1660  0006 ae000c        	ldw	x,#L041
1664  0009 cc0000        	jp	c_lsub
1712                     ; 358 void FlashMngr_ReadDataToUART()
1712                     ; 359 {
1713                     .text:	section	.text,new
1714  0000               _FlashMngr_ReadDataToUART:
1716  0000 5208          	subw	sp,#8
1717       00000008      OFST:	set	8
1720                     ; 362   dataSizeToSend = FlashMngr_GetOccupiedSpace();
1722  0002 cd0000        	call	_FlashMngr_GetOccupiedSpace
1724  0005 96            	ldw	x,sp
1725  0006 1c0005        	addw	x,#OFST-3
1726  0009 cd0000        	call	c_rtol
1728                     ; 363   tmp_adr.adr32b = DATA_STORAGE_BASE;
1730  000c ae1000        	ldw	x,#4096
1731  000f 1f03          	ldw	(OFST-5,sp),x
1732  0011 5f            	clrw	x
1733  0012 1f01          	ldw	(OFST-7,sp),x
1735  0014 2029          	jra	L725
1736  0016               L535:
1737                     ; 366     while(!(UART1->SR & UART1_FLAG_TXE));
1739  0016 720f5230fb    	btjf	21040,#7,L535
1740                     ; 367     UART1->DR = SST25VF016_Read_Byte(tmp_adr);
1742  001b 7b04          	ld	a,(OFST-4,sp)
1743  001d 88            	push	a
1744  001e 7b04          	ld	a,(OFST-4,sp)
1745  0020 88            	push	a
1746  0021 7b04          	ld	a,(OFST-4,sp)
1747  0023 88            	push	a
1748  0024 7b04          	ld	a,(OFST-4,sp)
1749  0026 88            	push	a
1750  0027 cd0000        	call	_SST25VF016_Read_Byte
1752  002a 5b04          	addw	sp,#4
1753  002c c75231        	ld	21041,a
1754                     ; 368     tmp_adr.adr32b++;
1756  002f 96            	ldw	x,sp
1757  0030 5c            	incw	x
1758  0031 a601          	ld	a,#1
1759  0033 cd0000        	call	c_lgadc
1761                     ; 364   for(;dataSizeToSend > 0; dataSizeToSend--)
1763  0036 96            	ldw	x,sp
1764  0037 1c0005        	addw	x,#OFST-3
1765  003a a601          	ld	a,#1
1766  003c cd0000        	call	c_lgsbc
1768  003f               L725:
1771  003f 96            	ldw	x,sp
1772  0040 1c0005        	addw	x,#OFST-3
1773  0043 cd0000        	call	c_lzmp
1775  0046 26ce          	jrne	L535
1776                     ; 370   EXTFLASH_STAT.Status_bits.Flash_was_Read = 1;
1778  0048 7216000c      	bset	L3_EXTFLASH_STAT,#3
1779                     ; 371 }
1782  004c 5b08          	addw	sp,#8
1783  004e 81            	ret	
1820                     ; 373 void FlashMngr_GetOccupiedSpaceToUART()
1820                     ; 374 {
1821                     .text:	section	.text,new
1822  0000               _FlashMngr_GetOccupiedSpaceToUART:
1824  0000 5204          	subw	sp,#4
1825       00000004      OFST:	set	4
1828                     ; 376   tmp_val.adr32b = FlashMngr_GetOccupiedSpace();
1830  0002 cd0000        	call	_FlashMngr_GetOccupiedSpace
1832  0005 96            	ldw	x,sp
1833  0006 5c            	incw	x
1834  0007 cd0000        	call	c_rtol
1837  000a               L365:
1838                     ; 378   while(!(UART1->SR & UART1_FLAG_TXE));
1840  000a 720f5230fb    	btjf	21040,#7,L365
1841                     ; 379   UART1->DR = tmp_val.adr8b.Zero;           //send MSB first
1843  000f 7b01          	ld	a,(OFST-3,sp)
1844  0011 c75231        	ld	21041,a
1846  0014               L375:
1847                     ; 380   while(!(UART1->SR & UART1_FLAG_TXE));
1849  0014 720f5230fb    	btjf	21040,#7,L375
1850                     ; 381   UART1->DR = tmp_val.adr8b.HighByte;
1852  0019 7b02          	ld	a,(OFST-2,sp)
1853  001b c75231        	ld	21041,a
1855  001e               L306:
1856                     ; 382   while(!(UART1->SR & UART1_FLAG_TXE));
1858  001e 720f5230fb    	btjf	21040,#7,L306
1859                     ; 383   UART1->DR = tmp_val.adr8b.MidByte;
1861  0023 7b03          	ld	a,(OFST-1,sp)
1862  0025 c75231        	ld	21041,a
1864  0028               L316:
1865                     ; 384   while(!(UART1->SR & UART1_FLAG_TXE));
1867  0028 720f5230fb    	btjf	21040,#7,L316
1868                     ; 385   UART1->DR = tmp_val.adr8b.LowByte;
1870  002d 7b04          	ld	a,(OFST+0,sp)
1871  002f c75231        	ld	21041,a
1872                     ; 386 }
1875  0032 5b04          	addw	sp,#4
1876  0034 81            	ret	
1912                     ; 388 void FlashMngr_GetHeaderSizeToUART()
1912                     ; 389 {
1913                     .text:	section	.text,new
1914  0000               _FlashMngr_GetHeaderSizeToUART:
1916  0000 5204          	subw	sp,#4
1917       00000004      OFST:	set	4
1920                     ; 391   tmp_val.adr32b = PTR_SEC_SIZE;
1922  0002 ae1000        	ldw	x,#4096
1923  0005 1f03          	ldw	(OFST-1,sp),x
1924  0007 5f            	clrw	x
1925  0008 1f01          	ldw	(OFST-3,sp),x
1927  000a               L146:
1928                     ; 392   while(!(UART1->SR & UART1_FLAG_TXE));
1930  000a 720f5230fb    	btjf	21040,#7,L146
1931                     ; 393   UART1->DR = tmp_val.adr8b.Zero;           //send MSB first
1933  000f 7b01          	ld	a,(OFST-3,sp)
1934  0011 c75231        	ld	21041,a
1936  0014               L156:
1937                     ; 394   while(!(UART1->SR & UART1_FLAG_TXE));
1939  0014 720f5230fb    	btjf	21040,#7,L156
1940                     ; 395   UART1->DR = tmp_val.adr8b.HighByte;
1942  0019 7b02          	ld	a,(OFST-2,sp)
1943  001b c75231        	ld	21041,a
1945  001e               L166:
1946                     ; 396   while(!(UART1->SR & UART1_FLAG_TXE));
1948  001e 720f5230fb    	btjf	21040,#7,L166
1949                     ; 397   UART1->DR = tmp_val.adr8b.MidByte;
1951  0023 7b03          	ld	a,(OFST-1,sp)
1952  0025 c75231        	ld	21041,a
1954  0028               L176:
1955                     ; 398   while(!(UART1->SR & UART1_FLAG_TXE));
1957  0028 720f5230fb    	btjf	21040,#7,L176
1958                     ; 399   UART1->DR = tmp_val.adr8b.LowByte;
1960  002d 7b04          	ld	a,(OFST+0,sp)
1961  002f c75231        	ld	21041,a
1962                     ; 400 }
1965  0032 5b04          	addw	sp,#4
1966  0034 81            	ret	
2012                     ; 402 void FlashMngr_ReadHeaderToUART()
2012                     ; 403 {
2013                     .text:	section	.text,new
2014  0000               _FlashMngr_ReadHeaderToUART:
2016  0000 5206          	subw	sp,#6
2017       00000006      OFST:	set	6
2020                     ; 406   dataSizeToSend = PTR_SEC_SIZE;
2022  0002 ae1000        	ldw	x,#4096
2023  0005 1f05          	ldw	(OFST-1,sp),x
2024                     ; 407   tmp_adr.adr32b = PTR_ARR_SEC_ADR;
2026  0007 5f            	clrw	x
2027  0008 1f03          	ldw	(OFST-3,sp),x
2028  000a 1f01          	ldw	(OFST-5,sp),x
2030  000c 2025          	jra	L327
2031  000e               L137:
2032                     ; 410     while(!(UART1->SR & UART1_FLAG_TXE));
2034  000e 720f5230fb    	btjf	21040,#7,L137
2035                     ; 411     UART1->DR = SST25VF016_Read_Byte(tmp_adr);
2037  0013 7b04          	ld	a,(OFST-2,sp)
2038  0015 88            	push	a
2039  0016 7b04          	ld	a,(OFST-2,sp)
2040  0018 88            	push	a
2041  0019 7b04          	ld	a,(OFST-2,sp)
2042  001b 88            	push	a
2043  001c 7b04          	ld	a,(OFST-2,sp)
2044  001e 88            	push	a
2045  001f cd0000        	call	_SST25VF016_Read_Byte
2047  0022 5b04          	addw	sp,#4
2048  0024 c75231        	ld	21041,a
2049                     ; 412     tmp_adr.adr32b++;
2051  0027 96            	ldw	x,sp
2052  0028 5c            	incw	x
2053  0029 a601          	ld	a,#1
2054  002b cd0000        	call	c_lgadc
2056                     ; 408   for(;dataSizeToSend > 0; dataSizeToSend--)
2058  002e 1e05          	ldw	x,(OFST-1,sp)
2059  0030 5a            	decw	x
2060  0031 1f05          	ldw	(OFST-1,sp),x
2061  0033               L327:
2064  0033 1e05          	ldw	x,(OFST-1,sp)
2065  0035 26d7          	jrne	L137
2066                     ; 414 }
2069  0037 5b06          	addw	sp,#6
2070  0039 81            	ret	
2095                     ; 416 void FlashMngr_DisableWriteOp()
2095                     ; 417 {
2096                     .text:	section	.text,new
2097  0000               _FlashMngr_DisableWriteOp:
2101                     ; 418   DisableMemOP = TRUE;
2103  0000 72100000      	bset	L7_DisableMemOP
2104                     ; 419 }
2107  0004 81            	ret	
2132                     ; 421 void FlashMngr_EnableWriteOp()
2132                     ; 422 {
2133                     .text:	section	.text,new
2134  0000               _FlashMngr_EnableWriteOp:
2138                     ; 423   DisableMemOP = FALSE;
2140  0000 72110000      	bres	L7_DisableMemOP
2141                     ; 424 }
2144  0004 81            	ret	
2412                     	xdef	_FlashMngr_EnableWriteOp
2413                     	xdef	_FlashMngr_DisableWriteOp
2414                     	xdef	_FlashMngr_ReadHeaderToUART
2415                     	xdef	_FlashMngr_GetHeaderSizeToUART
2416                     	xdef	_FlashMngr_GetOccupiedSpaceToUART
2417                     	xdef	_FlashMngr_ReadDataToUART
2418                     	xdef	_FlashMngr_GetFreeSpace
2419                     	xdef	_FlashMngr_EraseChip
2420                     	xdef	_FlashMngr_StoreData
2421                     	xdef	_FlashMngr_SavePointer
2422                     	xdef	_FlashMngr_ReadPointer
2423                     	xdef	_FlashMngr_Init
2424                     	xdef	_FlashMngr_GetErrors
2425                     	xdef	_FlashMngr_GetStatus
2426                     	xdef	_FlashMngr_GetOccupiedSpace
2427                     	xdef	_FlashMngr_GetPointer
2428                     	switch	.ubsct
2429  0000               L51_pointer_adr:
2430  0000 00000000      	ds.b	4
2431  0004               L31_flash_ptr:
2432  0004 00000000      	ds.b	4
2433  0008               L11_buffer:
2434  0008 000000        	ds.b	3
2435                     .bit:	section	.data,bit
2436  0000               L7_DisableMemOP:
2437  0000 00            	ds.b	1
2438                     	switch	.ubsct
2439  000b               L5_EXTFLASH_ERR:
2440  000b 00            	ds.b	1
2441  000c               L3_EXTFLASH_STAT:
2442  000c 00            	ds.b	1
2443                     	xref	_SST25VF016_Write_Status_Register
2444                     	xref	_SST25VF016_Chip_Erase
2445                     	xref	_SST25VF016_Sector_Erase_4KB
2446                     	xref	_SST25VF016_Program_Byte
2447                     	xref	_SST25VF016_Read_Status_Register
2448                     	xref	_SST25VF016_Read_Byte
2449                     	xref	_SST25VF016_Read
2450                     	xref	_SST25VF016_Init
2451                     	xref.b	c_lreg
2452                     	xref.b	c_x
2472                     	xref	c_lzmp
2473                     	xref	c_lsub
2474                     	xref	c_ladd
2475                     	xref	c_uitolx
2476                     	xref	c_lsbc
2477                     	xref	c_ladc
2478                     	xref	c_lgsbc
2479                     	xref	c_itolx
2480                     	xref	c_imul
2481                     	xref	c_sdivx
2482                     	xref	c_lgadc
2483                     	xref	c_lcmp
2484                     	xref	c_rtol
2485                     	xref	c_ltor
2486                     	end
