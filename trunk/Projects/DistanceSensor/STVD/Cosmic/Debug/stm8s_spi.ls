   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  48                     ; 44 void SPI_DeInit(void)
  48                     ; 45 {
  50                     .text:	section	.text,new
  51  0000               _SPI_DeInit:
  55                     ; 46     SPI->CR1    = SPI_CR1_RESET_VALUE;
  57  0000 725f5200      	clr	20992
  58                     ; 47     SPI->CR2    = SPI_CR2_RESET_VALUE;
  60  0004 725f5201      	clr	20993
  61                     ; 48     SPI->ICR    = SPI_ICR_RESET_VALUE;
  63  0008 725f5202      	clr	20994
  64                     ; 49     SPI->SR     = SPI_SR_RESET_VALUE;
  66  000c 35025203      	mov	20995,#2
  67                     ; 50     SPI->CRCPR  = SPI_CRCPR_RESET_VALUE;
  69  0010 35075205      	mov	20997,#7
  70                     ; 51 }
  73  0014 81            	ret	
 389                     ; 72 void SPI_Init(SPI_FirstBit_TypeDef FirstBit, SPI_BaudRatePrescaler_TypeDef BaudRatePrescaler, SPI_Mode_TypeDef Mode, SPI_ClockPolarity_TypeDef ClockPolarity, SPI_ClockPhase_TypeDef ClockPhase, SPI_DataDirection_TypeDef Data_Direction, SPI_NSS_TypeDef Slave_Management, uint8_t CRCPolynomial)
 389                     ; 73 {
 390                     .text:	section	.text,new
 391  0000               _SPI_Init:
 393  0000 89            	pushw	x
 394  0001 88            	push	a
 395       00000001      OFST:	set	1
 398                     ; 75     assert_param(IS_SPI_FIRSTBIT_OK(FirstBit));
 400                     ; 76     assert_param(IS_SPI_BAUDRATE_PRESCALER_OK(BaudRatePrescaler));
 402                     ; 77     assert_param(IS_SPI_MODE_OK(Mode));
 404                     ; 78     assert_param(IS_SPI_POLARITY_OK(ClockPolarity));
 406                     ; 79     assert_param(IS_SPI_PHASE_OK(ClockPhase));
 408                     ; 80     assert_param(IS_SPI_DATA_DIRECTION_OK(Data_Direction));
 410                     ; 81     assert_param(IS_SPI_SLAVEMANAGEMENT_OK(Slave_Management));
 412                     ; 82     assert_param(IS_SPI_CRC_POLYNOMIAL_OK(CRCPolynomial));
 414                     ; 85     SPI->CR1 = (uint8_t)((uint8_t)((uint8_t)FirstBit | BaudRatePrescaler) |
 414                     ; 86                     (uint8_t)((uint8_t)ClockPolarity | ClockPhase));
 416  0002 7b07          	ld	a,(OFST+6,sp)
 417  0004 1a08          	or	a,(OFST+7,sp)
 418  0006 6b01          	ld	(OFST+0,sp),a
 419  0008 9f            	ld	a,xl
 420  0009 1a02          	or	a,(OFST+1,sp)
 421  000b 1a01          	or	a,(OFST+0,sp)
 422  000d c75200        	ld	20992,a
 423                     ; 89     SPI->CR2 = (uint8_t)((uint8_t)(Data_Direction) | (uint8_t)(Slave_Management));
 425  0010 7b09          	ld	a,(OFST+8,sp)
 426  0012 1a0a          	or	a,(OFST+9,sp)
 427  0014 c75201        	ld	20993,a
 428                     ; 91     if (Mode == SPI_MODE_MASTER)
 430  0017 7b06          	ld	a,(OFST+5,sp)
 431  0019 a104          	cp	a,#4
 432  001b 2606          	jrne	L302
 433                     ; 93         SPI->CR2 |= (uint8_t)SPI_CR2_SSI;
 435  001d 72105201      	bset	20993,#0
 437  0021 2004          	jra	L502
 438  0023               L302:
 439                     ; 97         SPI->CR2 &= (uint8_t)~(SPI_CR2_SSI);
 441  0023 72115201      	bres	20993,#0
 442  0027               L502:
 443                     ; 101     SPI->CR1 |= (uint8_t)(Mode);
 445  0027 c65200        	ld	a,20992
 446  002a 1a06          	or	a,(OFST+5,sp)
 447  002c c75200        	ld	20992,a
 448                     ; 104     SPI->CRCPR = (uint8_t)CRCPolynomial;
 450  002f 7b0b          	ld	a,(OFST+10,sp)
 451  0031 c75205        	ld	20997,a
 452                     ; 105 }
 455  0034 5b03          	addw	sp,#3
 456  0036 81            	ret	
 511                     ; 113 void SPI_Cmd(FunctionalState NewState)
 511                     ; 114 {
 512                     .text:	section	.text,new
 513  0000               _SPI_Cmd:
 517                     ; 116     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 519                     ; 118     if (NewState != DISABLE)
 521  0000 4d            	tnz	a
 522  0001 2705          	jreq	L532
 523                     ; 120         SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
 525  0003 721c5200      	bset	20992,#6
 528  0007 81            	ret	
 529  0008               L532:
 530                     ; 124         SPI->CR1 &= (uint8_t)(~SPI_CR1_SPE); /* Disable the SPI peripheral*/
 532  0008 721d5200      	bres	20992,#6
 533                     ; 126 }
 536  000c 81            	ret	
 645                     ; 135 void SPI_ITConfig(SPI_IT_TypeDef SPI_IT, FunctionalState NewState)
 645                     ; 136 {
 646                     .text:	section	.text,new
 647  0000               _SPI_ITConfig:
 649  0000 89            	pushw	x
 650  0001 88            	push	a
 651       00000001      OFST:	set	1
 654                     ; 137     uint8_t itpos = 0;
 656                     ; 139     assert_param(IS_SPI_CONFIG_IT_OK(SPI_IT));
 658                     ; 140     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 660                     ; 143     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)SPI_IT & (uint8_t)0x0F));
 662  0002 9e            	ld	a,xh
 663  0003 a40f          	and	a,#15
 664  0005 5f            	clrw	x
 665  0006 97            	ld	xl,a
 666  0007 a601          	ld	a,#1
 667  0009 5d            	tnzw	x
 668  000a 2704          	jreq	L41
 669  000c               L61:
 670  000c 48            	sll	a
 671  000d 5a            	decw	x
 672  000e 26fc          	jrne	L61
 673  0010               L41:
 674  0010 6b01          	ld	(OFST+0,sp),a
 675                     ; 145     if (NewState != DISABLE)
 677  0012 0d03          	tnz	(OFST+2,sp)
 678  0014 2707          	jreq	L113
 679                     ; 147         SPI->ICR |= itpos; /* Enable interrupt*/
 681  0016 c65202        	ld	a,20994
 682  0019 1a01          	or	a,(OFST+0,sp)
 684  001b 2004          	jra	L313
 685  001d               L113:
 686                     ; 151         SPI->ICR &= (uint8_t)(~itpos); /* Disable interrupt*/
 688  001d 43            	cpl	a
 689  001e c45202        	and	a,20994
 690  0021               L313:
 691  0021 c75202        	ld	20994,a
 692                     ; 153 }
 695  0024 5b03          	addw	sp,#3
 696  0026 81            	ret	
 730                     ; 159 void SPI_SendData(uint8_t Data)
 730                     ; 160 {
 731                     .text:	section	.text,new
 732  0000               _SPI_SendData:
 736                     ; 161     SPI->DR = Data; /* Write in the DR register the data to be sent*/
 738  0000 c75204        	ld	20996,a
 739                     ; 162 }
 742  0003 81            	ret	
 765                     ; 169 uint8_t SPI_ReceiveData(void)
 765                     ; 170 {
 766                     .text:	section	.text,new
 767  0000               _SPI_ReceiveData:
 771                     ; 171     return ((uint8_t)SPI->DR); /* Return the data in the DR register*/
 773  0000 c65204        	ld	a,20996
 776  0003 81            	ret	
 812                     ; 180 void SPI_NSSInternalSoftwareCmd(FunctionalState NewState)
 812                     ; 181 {
 813                     .text:	section	.text,new
 814  0000               _SPI_NSSInternalSoftwareCmd:
 818                     ; 183     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 820                     ; 185     if (NewState != DISABLE)
 822  0000 4d            	tnz	a
 823  0001 2705          	jreq	L163
 824                     ; 187         SPI->CR2 |= SPI_CR2_SSI; /* Set NSS pin internally by software*/
 826  0003 72105201      	bset	20993,#0
 829  0007 81            	ret	
 830  0008               L163:
 831                     ; 191         SPI->CR2 &= (uint8_t)(~SPI_CR2_SSI); /* Reset NSS pin internally by software*/
 833  0008 72115201      	bres	20993,#0
 834                     ; 193 }
 837  000c 81            	ret	
 860                     ; 200 void SPI_TransmitCRC(void)
 860                     ; 201 {
 861                     .text:	section	.text,new
 862  0000               _SPI_TransmitCRC:
 866                     ; 202     SPI->CR2 |= SPI_CR2_CRCNEXT; /* Enable the CRC transmission*/
 868  0000 72185201      	bset	20993,#4
 869                     ; 203 }
 872  0004 81            	ret	
 908                     ; 211 void SPI_CalculateCRCCmd(FunctionalState NewState)
 908                     ; 212 {
 909                     .text:	section	.text,new
 910  0000               _SPI_CalculateCRCCmd:
 914                     ; 214     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 916                     ; 216     if (NewState != DISABLE)
 918  0000 4d            	tnz	a
 919  0001 2705          	jreq	L314
 920                     ; 218         SPI->CR2 |= SPI_CR2_CRCEN; /* Enable the CRC calculation*/
 922  0003 721a5201      	bset	20993,#5
 925  0007 81            	ret	
 926  0008               L314:
 927                     ; 222         SPI->CR2 &= (uint8_t)(~SPI_CR2_CRCEN); /* Disable the CRC calculation*/
 929  0008 721b5201      	bres	20993,#5
 930                     ; 224 }
 933  000c 81            	ret	
 997                     ; 231 uint8_t SPI_GetCRC(SPI_CRC_TypeDef SPI_CRC)
 997                     ; 232 {
 998                     .text:	section	.text,new
 999  0000               _SPI_GetCRC:
1001  0000 88            	push	a
1002       00000001      OFST:	set	1
1005                     ; 233     uint8_t crcreg = 0;
1007                     ; 236     assert_param(IS_SPI_CRC_OK(SPI_CRC));
1009                     ; 238     if (SPI_CRC != SPI_CRC_RX)
1011  0001 4d            	tnz	a
1012  0002 2705          	jreq	L154
1013                     ; 240         crcreg = SPI->TXCRCR;  /* Get the Tx CRC register*/
1015  0004 c65207        	ld	a,20999
1017  0007 2003          	jra	L354
1018  0009               L154:
1019                     ; 244         crcreg = SPI->RXCRCR; /* Get the Rx CRC register*/
1021  0009 c65206        	ld	a,20998
1022  000c               L354:
1023                     ; 248     return crcreg;
1027  000c 5b01          	addw	sp,#1
1028  000e 81            	ret	
1053                     ; 256 void SPI_ResetCRC(void)
1053                     ; 257 {
1054                     .text:	section	.text,new
1055  0000               _SPI_ResetCRC:
1059                     ; 260     SPI_CalculateCRCCmd(ENABLE);
1061  0000 a601          	ld	a,#1
1062  0002 cd0000        	call	_SPI_CalculateCRCCmd
1064                     ; 263     SPI_Cmd(ENABLE);
1066  0005 a601          	ld	a,#1
1068                     ; 264 }
1071  0007 cc0000        	jp	_SPI_Cmd
1095                     ; 271 uint8_t SPI_GetCRCPolynomial(void)
1095                     ; 272 {
1096                     .text:	section	.text,new
1097  0000               _SPI_GetCRCPolynomial:
1101                     ; 273     return SPI->CRCPR; /* Return the CRC polynomial register */
1103  0000 c65205        	ld	a,20997
1106  0003 81            	ret	
1162                     ; 281 void SPI_BiDirectionalLineConfig(SPI_Direction_TypeDef SPI_Direction)
1162                     ; 282 {
1163                     .text:	section	.text,new
1164  0000               _SPI_BiDirectionalLineConfig:
1168                     ; 284     assert_param(IS_SPI_DIRECTION_OK(SPI_Direction));
1170                     ; 286     if (SPI_Direction != SPI_DIRECTION_RX)
1172  0000 4d            	tnz	a
1173  0001 2705          	jreq	L325
1174                     ; 288         SPI->CR2 |= SPI_CR2_BDOE; /* Set the Tx only mode*/
1176  0003 721c5201      	bset	20993,#6
1179  0007 81            	ret	
1180  0008               L325:
1181                     ; 292         SPI->CR2 &= (uint8_t)(~SPI_CR2_BDOE); /* Set the Rx only mode*/
1183  0008 721d5201      	bres	20993,#6
1184                     ; 294 }
1187  000c 81            	ret	
1308                     ; 304 FlagStatus SPI_GetFlagStatus(SPI_Flag_TypeDef SPI_FLAG)
1308                     ; 305 {
1309                     .text:	section	.text,new
1310  0000               _SPI_GetFlagStatus:
1312  0000 88            	push	a
1313       00000001      OFST:	set	1
1316                     ; 306     FlagStatus status = RESET;
1318                     ; 308     assert_param(IS_SPI_FLAGS_OK(SPI_FLAG));
1320                     ; 311     if ((SPI->SR & (uint8_t)SPI_FLAG) != (uint8_t)RESET)
1322  0001 c45203        	and	a,20995
1323  0004 2702          	jreq	L306
1324                     ; 313         status = SET; /* SPI_FLAG is set */
1326  0006 a601          	ld	a,#1
1328  0008               L306:
1329                     ; 317         status = RESET; /* SPI_FLAG is reset*/
1331                     ; 321     return status;
1335  0008 5b01          	addw	sp,#1
1336  000a 81            	ret	
1371                     ; 339 void SPI_ClearFlag(SPI_Flag_TypeDef SPI_FLAG)
1371                     ; 340 {
1372                     .text:	section	.text,new
1373  0000               _SPI_ClearFlag:
1377                     ; 341     assert_param(IS_SPI_CLEAR_FLAGS_OK(SPI_FLAG));
1379                     ; 343     SPI->SR = (uint8_t)(~SPI_FLAG);
1381  0000 43            	cpl	a
1382  0001 c75203        	ld	20995,a
1383                     ; 344 }
1386  0004 81            	ret	
1468                     ; 359 ITStatus SPI_GetITStatus(SPI_IT_TypeDef SPI_IT)
1468                     ; 360 {
1469                     .text:	section	.text,new
1470  0000               _SPI_GetITStatus:
1472  0000 88            	push	a
1473  0001 89            	pushw	x
1474       00000002      OFST:	set	2
1477                     ; 361     ITStatus pendingbitstatus = RESET;
1479                     ; 362     uint8_t itpos = 0;
1481                     ; 363     uint8_t itmask1 = 0;
1483                     ; 364     uint8_t itmask2 = 0;
1485                     ; 365     uint8_t enablestatus = 0;
1487                     ; 366     assert_param(IS_SPI_GET_IT_OK(SPI_IT));
1489                     ; 368     itpos = (uint8_t)((uint8_t)1 << ((uint8_t)SPI_IT & (uint8_t)0x0F));
1491  0002 a40f          	and	a,#15
1492  0004 5f            	clrw	x
1493  0005 97            	ld	xl,a
1494  0006 a601          	ld	a,#1
1495  0008 5d            	tnzw	x
1496  0009 2704          	jreq	L45
1497  000b               L65:
1498  000b 48            	sll	a
1499  000c 5a            	decw	x
1500  000d 26fc          	jrne	L65
1501  000f               L45:
1502  000f 6b01          	ld	(OFST-1,sp),a
1503                     ; 371     itmask1 = (uint8_t)((uint8_t)SPI_IT >> (uint8_t)4);
1505  0011 7b03          	ld	a,(OFST+1,sp)
1506  0013 4e            	swap	a
1507  0014 a40f          	and	a,#15
1508  0016 6b02          	ld	(OFST+0,sp),a
1509                     ; 373     itmask2 = (uint8_t)((uint8_t)1 << itmask1);
1511  0018 5f            	clrw	x
1512  0019 97            	ld	xl,a
1513  001a a601          	ld	a,#1
1514  001c 5d            	tnzw	x
1515  001d 2704          	jreq	L06
1516  001f               L26:
1517  001f 48            	sll	a
1518  0020 5a            	decw	x
1519  0021 26fc          	jrne	L26
1520  0023               L06:
1521                     ; 375     enablestatus = (uint8_t)((uint8_t)SPI->SR & itmask2);
1523  0023 c45203        	and	a,20995
1524  0026 6b02          	ld	(OFST+0,sp),a
1525                     ; 377     if (((SPI->ICR & itpos) != RESET) && enablestatus)
1527  0028 c65202        	ld	a,20994
1528  002b 1501          	bcp	a,(OFST-1,sp)
1529  002d 2708          	jreq	L766
1531  002f 7b02          	ld	a,(OFST+0,sp)
1532  0031 2704          	jreq	L766
1533                     ; 380         pendingbitstatus = SET;
1535  0033 a601          	ld	a,#1
1537  0035 2001          	jra	L176
1538  0037               L766:
1539                     ; 385         pendingbitstatus = RESET;
1541  0037 4f            	clr	a
1542  0038               L176:
1543                     ; 388     return  pendingbitstatus;
1547  0038 5b03          	addw	sp,#3
1548  003a 81            	ret	
1593                     ; 404 void SPI_ClearITPendingBit(SPI_IT_TypeDef SPI_IT)
1593                     ; 405 {
1594                     .text:	section	.text,new
1595  0000               _SPI_ClearITPendingBit:
1597  0000 88            	push	a
1598       00000001      OFST:	set	1
1601                     ; 406     uint8_t itpos = 0;
1603                     ; 407     assert_param(IS_SPI_CLEAR_IT_OK(SPI_IT));
1605                     ; 412     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)(SPI_IT & (uint8_t)0xF0) >> 4));
1607  0001 4e            	swap	a
1608  0002 a40f          	and	a,#15
1609  0004 5f            	clrw	x
1610  0005 97            	ld	xl,a
1611  0006 a601          	ld	a,#1
1612  0008 5d            	tnzw	x
1613  0009 2704          	jreq	L66
1614  000b               L07:
1615  000b 48            	sll	a
1616  000c 5a            	decw	x
1617  000d 26fc          	jrne	L07
1618  000f               L66:
1619                     ; 414     SPI->SR = (uint8_t)(~itpos);
1621  000f 43            	cpl	a
1622  0010 c75203        	ld	20995,a
1623                     ; 416 }
1626  0013 84            	pop	a
1627  0014 81            	ret	
1640                     	xdef	_SPI_ClearITPendingBit
1641                     	xdef	_SPI_GetITStatus
1642                     	xdef	_SPI_ClearFlag
1643                     	xdef	_SPI_GetFlagStatus
1644                     	xdef	_SPI_BiDirectionalLineConfig
1645                     	xdef	_SPI_GetCRCPolynomial
1646                     	xdef	_SPI_ResetCRC
1647                     	xdef	_SPI_GetCRC
1648                     	xdef	_SPI_CalculateCRCCmd
1649                     	xdef	_SPI_TransmitCRC
1650                     	xdef	_SPI_NSSInternalSoftwareCmd
1651                     	xdef	_SPI_ReceiveData
1652                     	xdef	_SPI_SendData
1653                     	xdef	_SPI_ITConfig
1654                     	xdef	_SPI_Cmd
1655                     	xdef	_SPI_Init
1656                     	xdef	_SPI_DeInit
1675                     	end
