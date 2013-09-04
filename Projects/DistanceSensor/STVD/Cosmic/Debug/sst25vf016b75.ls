   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  51                     ; 39 void SST25VF016_Init(void)
  51                     ; 40 {
  53                     .text:	section	.text,new
  54  0000               _SST25VF016_Init:
  58                     ; 41   SPI_DeInit();
  60  0000 cd0000        	call	_SPI_DeInit
  62                     ; 42   SPI_Init(SPI_FIRSTBIT_MSB, 
  62                     ; 43            SPI_BAUDRATEPRESCALER_32, 
  62                     ; 44            SPI_MODE_MASTER, 
  62                     ; 45            SPI_CLOCKPOLARITY_LOW, 
  62                     ; 46            SPI_CLOCKPHASE_1EDGE, 
  62                     ; 47            SPI_DATADIRECTION_2LINES_FULLDUPLEX, 
  62                     ; 48            SPI_NSS_SOFT, 0x07);
  64  0003 4b07          	push	#7
  65  0005 4b02          	push	#2
  66  0007 4b00          	push	#0
  67  0009 4b00          	push	#0
  68  000b 4b00          	push	#0
  69  000d 4b04          	push	#4
  70  000f ae0020        	ldw	x,#32
  71  0012 cd0000        	call	_SPI_Init
  73  0015 5b06          	addw	sp,#6
  74                     ; 49  SPI_Cmd(ENABLE);
  76  0017 a601          	ld	a,#1
  78                     ; 50 }
  81  0019 cc0000        	jp	_SPI_Cmd
 213                     ; 59 void SST25VF016_Read(ExtFlashAdr addr, u8* buffer, u16 nr_bytes)
 213                     ; 60 {
 214                     .text:	section	.text,new
 215  0000               _SST25VF016_Read:
 217  0000 5203          	subw	sp,#3
 218       00000003      OFST:	set	3
 221                     ; 63   SPI_CS_LOW;
 223  0002 7219500a      	bres	20490,#4
 224                     ; 64   DELAY_US(SPI_CS_LOW_DELAY);
 226  0006 ae000c        	ldw	x,#12
 228  0009               L61:
 229  0009 5a            	decw	X
 230  000a 26fd          	jrne	L61
 231  000c 9d            	nop	
 233                     ; 65   SPI->DR = RD;
 236  000d 35035204      	mov	20996,#3
 238  0011               L111:
 239                     ; 66   while(!(SPI->SR & SPI_SR_RXNE));
 241  0011 72015203fb    	btjf	20995,#0,L111
 242                     ; 67   tmp = SPI->DR;
 244  0016 c65204        	ld	a,20996
 246  0019               L711:
 247                     ; 68   while(!(SPI->SR & SPI_SR_TXE));
 249  0019 72035203fb    	btjf	20995,#1,L711
 250                     ; 69   SPI->DR = addr.adr8b.HighByte;
 252  001e 7b07          	ld	a,(OFST+4,sp)
 253  0020 c75204        	ld	20996,a
 255  0023               L721:
 256                     ; 70   while(!(SPI->SR & SPI_SR_RXNE));
 258  0023 72015203fb    	btjf	20995,#0,L721
 259                     ; 71   tmp = SPI->DR;
 261  0028 c65204        	ld	a,20996
 263  002b               L531:
 264                     ; 72   while(!(SPI->SR & SPI_SR_TXE));
 266  002b 72035203fb    	btjf	20995,#1,L531
 267                     ; 73   SPI->DR = addr.adr8b.MidByte;
 269  0030 7b08          	ld	a,(OFST+5,sp)
 270  0032 c75204        	ld	20996,a
 272  0035               L541:
 273                     ; 74   while(!(SPI->SR & SPI_SR_RXNE));
 275  0035 72015203fb    	btjf	20995,#0,L541
 276                     ; 75   tmp = SPI->DR;
 278  003a c65204        	ld	a,20996
 280  003d               L351:
 281                     ; 76   while(!(SPI->SR & SPI_SR_TXE));
 283  003d 72035203fb    	btjf	20995,#1,L351
 284                     ; 77   SPI->DR = addr.adr8b.LowByte;
 286  0042 7b09          	ld	a,(OFST+6,sp)
 287  0044 c75204        	ld	20996,a
 289  0047               L361:
 290                     ; 78   while(!(SPI->SR & SPI_SR_RXNE));
 292  0047 72015203fb    	btjf	20995,#0,L361
 293                     ; 79   tmp = SPI->DR;
 295  004c c65204        	ld	a,20996
 297  004f               L171:
 298                     ; 80   while(!(SPI->SR & SPI_SR_TXE));
 300  004f 72035203fb    	btjf	20995,#1,L171
 301                     ; 81   for(i = 0; i < nr_bytes; i++)
 303  0054 5f            	clrw	x
 305  0055 201a          	jra	L102
 306  0057               L571:
 307                     ; 83     SPI->DR = DUMMY;   /* dummy byte */
 309  0057 35ff5204      	mov	20996,#255
 311  005b               L112:
 312                     ; 84     while(!(SPI->SR & SPI_SR_RXNE));
 314  005b 72015203fb    	btjf	20995,#0,L112
 315                     ; 85     buffer[i] = SPI->DR;
 317  0060 1e0a          	ldw	x,(OFST+7,sp)
 318  0062 72fb02        	addw	x,(OFST-1,sp)
 319  0065 c65204        	ld	a,20996
 320  0068 f7            	ld	(x),a
 322  0069               L122:
 323                     ; 86     while(!(SPI->SR & SPI_SR_TXE));
 325  0069 72035203fb    	btjf	20995,#1,L122
 326                     ; 81   for(i = 0; i < nr_bytes; i++)
 328  006e 1e02          	ldw	x,(OFST-1,sp)
 329  0070 5c            	incw	x
 330  0071               L102:
 331  0071 1f02          	ldw	(OFST-1,sp),x
 334  0073 130c          	cpw	x,(OFST+9,sp)
 335  0075 25e0          	jrult	L571
 337  0077               L722:
 338                     ; 88   while(SPI->SR & SPI_SR_BSY);
 340  0077 720e5203fb    	btjt	20995,#7,L722
 341                     ; 89   SPI_CS_HIGH;
 343  007c 7218500a      	bset	20490,#4
 344                     ; 90 }
 347  0080 5b03          	addw	sp,#3
 348  0082 81            	ret	
 394                     ; 92 u8 SST25VF016_Read_Byte(ExtFlashAdr addr)
 394                     ; 93 {
 395                     .text:	section	.text,new
 396  0000               _SST25VF016_Read_Byte:
 398  0000 88            	push	a
 399       00000001      OFST:	set	1
 402                     ; 95   SPI_CS_LOW;
 404  0001 7219500a      	bres	20490,#4
 405                     ; 96   DELAY_US(SPI_CS_LOW_DELAY);
 407  0005 ae000c        	ldw	x,#12
 409  0008               L22:
 410  0008 5a            	decw	X
 411  0009 26fd          	jrne	L22
 412  000b 9d            	nop	
 414                     ; 97   SPI->DR = RD;
 417  000c 35035204      	mov	20996,#3
 419  0010               L162:
 420                     ; 98   while(!(SPI->SR & SPI_SR_RXNE));
 422  0010 72015203fb    	btjf	20995,#0,L162
 423                     ; 99   tmp = SPI->DR;
 425  0015 c65204        	ld	a,20996
 427  0018               L762:
 428                     ; 100   while(!(SPI->SR & SPI_SR_TXE));
 430  0018 72035203fb    	btjf	20995,#1,L762
 431                     ; 101   SPI->DR =  addr.adr8b.HighByte;
 433  001d 7b05          	ld	a,(OFST+4,sp)
 434  001f c75204        	ld	20996,a
 436  0022               L772:
 437                     ; 102   while(!(SPI->SR & SPI_SR_RXNE));
 439  0022 72015203fb    	btjf	20995,#0,L772
 440                     ; 103   tmp = SPI->DR;
 442  0027 c65204        	ld	a,20996
 444  002a               L503:
 445                     ; 104   while(!(SPI->SR & SPI_SR_TXE));
 447  002a 72035203fb    	btjf	20995,#1,L503
 448                     ; 105   SPI->DR =  addr.adr8b.MidByte;
 450  002f 7b06          	ld	a,(OFST+5,sp)
 451  0031 c75204        	ld	20996,a
 453  0034               L513:
 454                     ; 106   while(!(SPI->SR & SPI_SR_RXNE));
 456  0034 72015203fb    	btjf	20995,#0,L513
 457                     ; 107   tmp = SPI->DR;
 459  0039 c65204        	ld	a,20996
 461  003c               L323:
 462                     ; 108   while(!(SPI->SR & SPI_SR_TXE));
 464  003c 72035203fb    	btjf	20995,#1,L323
 465                     ; 109   SPI->DR =  addr.adr8b.LowByte;
 467  0041 7b07          	ld	a,(OFST+6,sp)
 468  0043 c75204        	ld	20996,a
 470  0046               L333:
 471                     ; 110   while(!(SPI->SR & SPI_SR_RXNE));
 473  0046 72015203fb    	btjf	20995,#0,L333
 474                     ; 111   tmp = SPI->DR;
 476  004b c65204        	ld	a,20996
 478  004e               L143:
 479                     ; 112   while(!(SPI->SR & SPI_SR_TXE));
 481  004e 72035203fb    	btjf	20995,#1,L143
 482                     ; 113   SPI->DR = DUMMY;   /* dummy byte */
 484  0053 35ff5204      	mov	20996,#255
 486  0057               L153:
 487                     ; 114   while(!(SPI->SR & SPI_SR_RXNE));
 489  0057 72015203fb    	btjf	20995,#0,L153
 490                     ; 115   tmp = SPI->DR;     //Read byte
 492  005c c65204        	ld	a,20996
 493  005f 6b01          	ld	(OFST+0,sp),a
 495  0061               L163:
 496                     ; 116   while(!(SPI->SR & SPI_SR_TXE));
 498  0061 72035203fb    	btjf	20995,#1,L163
 500  0066               L763:
 501                     ; 117   while(SPI->SR & SPI_SR_BSY);
 503  0066 720e5203fb    	btjt	20995,#7,L763
 504                     ; 118   SPI_CS_HIGH;
 506  006b 7218500a      	bset	20490,#4
 507                     ; 119   return tmp;
 511  006f 5b01          	addw	sp,#1
 512  0071 81            	ret	
 585                     ; 130 void SST25VF016_Read_HS(ExtFlashAdr addr, u8* buffer, u16 nr_bytes)
 585                     ; 131 {
 586                     .text:	section	.text,new
 587  0000               _SST25VF016_Read_HS:
 589  0000 5203          	subw	sp,#3
 590       00000003      OFST:	set	3
 593                     ; 134   SPI_CS_LOW;
 595  0002 7219500a      	bres	20490,#4
 596                     ; 135   DELAY_US(SPI_CS_LOW_DELAY);
 598  0006 ae000c        	ldw	x,#12
 600  0009               L62:
 601  0009 5a            	decw	X
 602  000a 26fd          	jrne	L62
 603  000c 9d            	nop	
 605                     ; 136   SPI->DR = RD;
 608  000d 35035204      	mov	20996,#3
 610  0011               L534:
 611                     ; 137   while(!(SPI->SR & SPI_SR_RXNE));
 613  0011 72015203fb    	btjf	20995,#0,L534
 614                     ; 138   tmp = SPI->DR;
 616  0016 c65204        	ld	a,20996
 618  0019               L344:
 619                     ; 139   while(!(SPI->SR & SPI_SR_TXE));
 621  0019 72035203fb    	btjf	20995,#1,L344
 622                     ; 140   SPI->DR = addr.adr8b.HighByte;
 624  001e 7b07          	ld	a,(OFST+4,sp)
 625  0020 c75204        	ld	20996,a
 627  0023               L354:
 628                     ; 141   while(!(SPI->SR & SPI_SR_RXNE));
 630  0023 72015203fb    	btjf	20995,#0,L354
 631                     ; 142   tmp = SPI->DR;
 633  0028 c65204        	ld	a,20996
 635  002b               L164:
 636                     ; 143   while(!(SPI->SR & SPI_SR_TXE));
 638  002b 72035203fb    	btjf	20995,#1,L164
 639                     ; 144   SPI->DR = addr.adr8b.MidByte;
 641  0030 7b08          	ld	a,(OFST+5,sp)
 642  0032 c75204        	ld	20996,a
 644  0035               L174:
 645                     ; 145   while(!(SPI->SR & SPI_SR_RXNE));
 647  0035 72015203fb    	btjf	20995,#0,L174
 648                     ; 146   tmp = SPI->DR;
 650  003a c65204        	ld	a,20996
 652  003d               L774:
 653                     ; 147   while(!(SPI->SR & SPI_SR_TXE));
 655  003d 72035203fb    	btjf	20995,#1,L774
 656                     ; 148   SPI->DR = addr.adr8b.LowByte;
 658  0042 7b09          	ld	a,(OFST+6,sp)
 659  0044 c75204        	ld	20996,a
 661  0047               L705:
 662                     ; 149   while(!(SPI->SR & SPI_SR_RXNE));
 664  0047 72015203fb    	btjf	20995,#0,L705
 665                     ; 150   tmp = SPI->DR;
 667  004c c65204        	ld	a,20996
 669  004f               L515:
 670                     ; 151   while(!(SPI->SR & SPI_SR_TXE));
 672  004f 72035203fb    	btjf	20995,#1,L515
 673                     ; 152   for(i = 0; i < nr_bytes; i++)
 675  0054 5f            	clrw	x
 677  0055 201a          	jra	L525
 678  0057               L125:
 679                     ; 154     SPI->DR = DUMMY;   /* dummy byte */
 681  0057 35ff5204      	mov	20996,#255
 683  005b               L535:
 684                     ; 155     while(!(SPI->SR & SPI_SR_RXNE));
 686  005b 72015203fb    	btjf	20995,#0,L535
 687                     ; 156     buffer[i] = SPI->DR;
 689  0060 1e0a          	ldw	x,(OFST+7,sp)
 690  0062 72fb02        	addw	x,(OFST-1,sp)
 691  0065 c65204        	ld	a,20996
 692  0068 f7            	ld	(x),a
 694  0069               L545:
 695                     ; 157     while(!(SPI->SR & SPI_SR_TXE));
 697  0069 72035203fb    	btjf	20995,#1,L545
 698                     ; 152   for(i = 0; i < nr_bytes; i++)
 700  006e 1e02          	ldw	x,(OFST-1,sp)
 701  0070 5c            	incw	x
 702  0071               L525:
 703  0071 1f02          	ldw	(OFST-1,sp),x
 706  0073 130c          	cpw	x,(OFST+9,sp)
 707  0075 25e0          	jrult	L125
 709  0077               L355:
 710                     ; 159   while(SPI->SR & SPI_SR_BSY);
 712  0077 720e5203fb    	btjt	20995,#7,L355
 713                     ; 160   SPI_CS_HIGH;
 715  007c 7218500a      	bset	20490,#4
 716                     ; 161 }
 719  0080 5b03          	addw	sp,#3
 720  0082 81            	ret	
 775                     ; 170 void SST25VF016_Program_Byte(ExtFlashAdr addr, u8 data)
 775                     ; 171 {
 776                     .text:	section	.text,new
 777  0000               _SST25VF016_Program_Byte:
 779  0000 88            	push	a
 780       00000001      OFST:	set	1
 783                     ; 173   SPI_CS_LOW;
 785  0001 7219500a      	bres	20490,#4
 786                     ; 174   DELAY_US(SPI_CS_LOW_DELAY);
 788  0005 ae000c        	ldw	x,#12
 790  0008               L23:
 791  0008 5a            	decw	X
 792  0009 26fd          	jrne	L23
 793  000b 9d            	nop	
 795                     ; 175   SPI->DR = WR_EN;
 798  000c 35065204      	mov	20996,#6
 800  0010               L116:
 801                     ; 176   while(!(SPI->SR & SPI_SR_RXNE));
 803  0010 72015203fb    	btjf	20995,#0,L116
 804                     ; 177   tmp = SPI->DR;
 806  0015 c65204        	ld	a,20996
 808  0018               L716:
 809                     ; 178   while(!(SPI->SR & SPI_SR_TXE));
 811  0018 72035203fb    	btjf	20995,#1,L716
 812                     ; 179   SPI_CS_HIGH;
 814  001d 7218500a      	bset	20490,#4
 815                     ; 180   DELAY_US(SPI_CS_LOW_DELAY);
 817  0021 ae000c        	ldw	x,#12
 819  0024               L43:
 820  0024 5a            	decw	X
 821  0025 26fd          	jrne	L43
 822  0027 9d            	nop	
 824                     ; 182   SPI_CS_LOW;
 827  0028 7219500a      	bres	20490,#4
 828                     ; 183   DELAY_US(SPI_CS_LOW_DELAY);
 830  002c ae000c        	ldw	x,#12
 832  002f               L63:
 833  002f 5a            	decw	X
 834  0030 26fd          	jrne	L63
 835  0032 9d            	nop	
 837                     ; 184   SPI->DR = BYTE_PROGRAM;
 840  0033 35025204      	mov	20996,#2
 842  0037               L726:
 843                     ; 185   while(!(SPI->SR & SPI_SR_RXNE));
 845  0037 72015203fb    	btjf	20995,#0,L726
 846                     ; 186   tmp = SPI->DR;
 848  003c c65204        	ld	a,20996
 850  003f               L536:
 851                     ; 187   while(!(SPI->SR & SPI_SR_TXE));
 853  003f 72035203fb    	btjf	20995,#1,L536
 854                     ; 188   SPI->DR = addr.adr8b.HighByte;
 856  0044 7b05          	ld	a,(OFST+4,sp)
 857  0046 c75204        	ld	20996,a
 859  0049               L546:
 860                     ; 189   while(!(SPI->SR & SPI_SR_RXNE));
 862  0049 72015203fb    	btjf	20995,#0,L546
 863                     ; 190   tmp = SPI->DR;
 865  004e c65204        	ld	a,20996
 867  0051               L356:
 868                     ; 191   while(!(SPI->SR & SPI_SR_TXE));
 870  0051 72035203fb    	btjf	20995,#1,L356
 871                     ; 192   SPI->DR = addr.adr8b.MidByte;
 873  0056 7b06          	ld	a,(OFST+5,sp)
 874  0058 c75204        	ld	20996,a
 876  005b               L366:
 877                     ; 193   while(!(SPI->SR & SPI_SR_RXNE));
 879  005b 72015203fb    	btjf	20995,#0,L366
 880                     ; 194   tmp = SPI->DR;
 882  0060 c65204        	ld	a,20996
 884  0063               L176:
 885                     ; 195   while(!(SPI->SR & SPI_SR_TXE));
 887  0063 72035203fb    	btjf	20995,#1,L176
 888                     ; 196   SPI->DR = addr.adr8b.LowByte;
 890  0068 7b07          	ld	a,(OFST+6,sp)
 891  006a c75204        	ld	20996,a
 893  006d               L107:
 894                     ; 197   while(!(SPI->SR & SPI_SR_RXNE));
 896  006d 72015203fb    	btjf	20995,#0,L107
 897                     ; 198   tmp = SPI->DR;
 899  0072 c65204        	ld	a,20996
 901  0075               L707:
 902                     ; 199   while(!(SPI->SR & SPI_SR_TXE));
 904  0075 72035203fb    	btjf	20995,#1,L707
 905                     ; 200   SPI->DR = data;
 907  007a 7b08          	ld	a,(OFST+7,sp)
 908  007c c75204        	ld	20996,a
 910  007f               L717:
 911                     ; 201   while(!(SPI->SR & SPI_SR_RXNE));
 913  007f 72015203fb    	btjf	20995,#0,L717
 914                     ; 202   tmp = SPI->DR;
 916  0084 c65204        	ld	a,20996
 918  0087               L527:
 919                     ; 203   while(!(SPI->SR & SPI_SR_TXE));
 921  0087 72035203fb    	btjf	20995,#1,L527
 923  008c               L337:
 924                     ; 204   while(SPI->SR & SPI_SR_BSY);
 926  008c 720e5203fb    	btjt	20995,#7,L337
 927                     ; 205   SPI_CS_HIGH;
 929  0091 7218500a      	bset	20490,#4
 930                     ; 206   DELAY_US(DELAY_15US);
 932  0095 ae0050        	ldw	x,#80
 934  0098               L04:
 935  0098 5a            	decw	X
 936  0099 26fd          	jrne	L04
 937  009b 9d            	nop	
 939                     ; 207 }
 943  009c 84            	pop	a
 944  009d 81            	ret	
 980                     ; 217 void SST25VF016_Enable_SY(void)
 980                     ; 218 {
 981                     .text:	section	.text,new
 982  0000               _SST25VF016_Enable_SY:
 984       00000001      OFST:	set	1
 987                     ; 220   SPI_CS_LOW;
 989  0000 7219500a      	bres	20490,#4
 990                     ; 221   DELAY_US(SPI_CS_LOW_DELAY);
 992  0004 ae000c        	ldw	x,#12
 994  0007               L44:
 995  0007 5a            	decw	X
 996  0008 26fd          	jrne	L44
 997  000a 9d            	nop	
 999                     ; 222   SPI->DR = EN_SY;
1002  000b 35705204      	mov	20996,#112
1004  000f               L167:
1005                     ; 223   while(!(SPI->SR & SPI_SR_RXNE));
1007  000f 72015203fb    	btjf	20995,#0,L167
1008                     ; 224   tmp = SPI->DR;
1010  0014 c65204        	ld	a,20996
1012  0017               L767:
1013                     ; 225   while(!(SPI->SR & SPI_SR_TXE));
1015  0017 72035203fb    	btjf	20995,#1,L767
1017  001c               L577:
1018                     ; 226   while(SPI->SR & SPI_SR_BSY);
1020  001c 720e5203fb    	btjt	20995,#7,L577
1021                     ; 227   SPI_CS_HIGH;
1023  0021 7218500a      	bset	20490,#4
1024                     ; 228 }
1027  0025 81            	ret	
1063                     ; 230 void SST25VF016_Disable_SY(void)
1063                     ; 231 {
1064                     .text:	section	.text,new
1065  0000               _SST25VF016_Disable_SY:
1067       00000001      OFST:	set	1
1070                     ; 233   SPI_CS_LOW;
1072  0000 7219500a      	bres	20490,#4
1073                     ; 234   DELAY_US(SPI_CS_LOW_DELAY);
1075  0004 ae000c        	ldw	x,#12
1077  0007               L05:
1078  0007 5a            	decw	X
1079  0008 26fd          	jrne	L05
1080  000a 9d            	nop	
1082                     ; 235   SPI->DR = DIS_SY;
1085  000b 35805204      	mov	20996,#128
1087  000f               L3201:
1088                     ; 236   while(!(SPI->SR & SPI_SR_RXNE));
1090  000f 72015203fb    	btjf	20995,#0,L3201
1091                     ; 237   tmp = SPI->DR;
1093  0014 c65204        	ld	a,20996
1095  0017               L1301:
1096                     ; 238   while(!(SPI->SR & SPI_SR_TXE));
1098  0017 72035203fb    	btjf	20995,#1,L1301
1100  001c               L7301:
1101                     ; 239   while(SPI->SR & SPI_SR_BSY);
1103  001c 720e5203fb    	btjt	20995,#7,L7301
1104                     ; 240   SPI_CS_HIGH;
1106  0021 7218500a      	bset	20490,#4
1107                     ; 241 }
1110  0025 81            	ret	
1184                     ; 258 void SST25VF016_AAI_Word_Program(ExtFlashAdr addr, u8* data, u16 nr_words)
1184                     ; 259 {
1185                     .text:	section	.text,new
1186  0000               _SST25VF016_AAI_Word_Program:
1188  0000 5203          	subw	sp,#3
1189       00000003      OFST:	set	3
1192                     ; 262   SPI_CS_LOW;
1194  0002 7219500a      	bres	20490,#4
1195                     ; 263   DELAY_US(SPI_CS_LOW_DELAY);
1197  0006 ae000c        	ldw	x,#12
1199  0009               L45:
1200  0009 5a            	decw	X
1201  000a 26fd          	jrne	L45
1202  000c 9d            	nop	
1204                     ; 264   SPI->DR = WR_EN;
1207  000d 35065204      	mov	20996,#6
1209  0011               L5011:
1210                     ; 265   while(!(SPI->SR & SPI_SR_RXNE));
1212  0011 72015203fb    	btjf	20995,#0,L5011
1213                     ; 266   tmp = SPI->DR;
1215  0016 c65204        	ld	a,20996
1217  0019               L3111:
1218                     ; 267   while(!(SPI->SR & SPI_SR_TXE));
1220  0019 72035203fb    	btjf	20995,#1,L3111
1221                     ; 268   SPI_CS_HIGH;
1223  001e 7218500a      	bset	20490,#4
1224                     ; 269   DELAY_US(SPI_CS_LOW_DELAY);
1226  0022 ae000c        	ldw	x,#12
1228  0025               L65:
1229  0025 5a            	decw	X
1230  0026 26fd          	jrne	L65
1231  0028 9d            	nop	
1233                     ; 271   SPI_CS_LOW;
1236  0029 7219500a      	bres	20490,#4
1237                     ; 272   DELAY_US(SPI_CS_LOW_DELAY);
1239  002d ae000c        	ldw	x,#12
1241  0030               L06:
1242  0030 5a            	decw	X
1243  0031 26fd          	jrne	L06
1244  0033 9d            	nop	
1246                     ; 273   SPI->DR = AAI_WORD_PROGRAM;
1249  0034 35ad5204      	mov	20996,#173
1251  0038               L3211:
1252                     ; 274   while(!(SPI->SR & SPI_SR_RXNE));
1254  0038 72015203fb    	btjf	20995,#0,L3211
1255                     ; 275   tmp = SPI->DR;
1257  003d c65204        	ld	a,20996
1259  0040               L1311:
1260                     ; 276   while(!(SPI->SR & SPI_SR_TXE));
1262  0040 72035203fb    	btjf	20995,#1,L1311
1263                     ; 277   SPI->DR = addr.adr8b.HighByte;
1265  0045 7b07          	ld	a,(OFST+4,sp)
1266  0047 c75204        	ld	20996,a
1268  004a               L1411:
1269                     ; 278   while(!(SPI->SR & SPI_SR_RXNE));
1271  004a 72015203fb    	btjf	20995,#0,L1411
1272                     ; 279   tmp = SPI->DR;
1274  004f c65204        	ld	a,20996
1276  0052               L7411:
1277                     ; 280   while(!(SPI->SR & SPI_SR_TXE));
1279  0052 72035203fb    	btjf	20995,#1,L7411
1280                     ; 281   SPI->DR = addr.adr8b.MidByte;
1282  0057 7b08          	ld	a,(OFST+5,sp)
1283  0059 c75204        	ld	20996,a
1285  005c               L7511:
1286                     ; 282   while(!(SPI->SR & SPI_SR_RXNE));
1288  005c 72015203fb    	btjf	20995,#0,L7511
1289                     ; 283   tmp = SPI->DR;
1291  0061 c65204        	ld	a,20996
1293  0064               L5611:
1294                     ; 284   while(!(SPI->SR & SPI_SR_TXE));
1296  0064 72035203fb    	btjf	20995,#1,L5611
1297                     ; 285   SPI->DR = addr.adr8b.LowByte;
1299  0069 7b09          	ld	a,(OFST+6,sp)
1300  006b c75204        	ld	20996,a
1302  006e               L5711:
1303                     ; 286   while(!(SPI->SR & SPI_SR_RXNE));
1305  006e 72015203fb    	btjf	20995,#0,L5711
1306                     ; 287   tmp = SPI->DR;
1308  0073 c65204        	ld	a,20996
1310  0076               L3021:
1311                     ; 288   while(!(SPI->SR & SPI_SR_TXE));
1313  0076 72035203fb    	btjf	20995,#1,L3021
1314                     ; 289   SPI->DR = data[0]; 
1316  007b 1e0a          	ldw	x,(OFST+7,sp)
1317  007d f6            	ld	a,(x)
1318  007e c75204        	ld	20996,a
1320  0081               L3121:
1321                     ; 290   while(!(SPI->SR & SPI_SR_RXNE));
1323  0081 72015203fb    	btjf	20995,#0,L3121
1324                     ; 291   tmp = SPI->DR;
1326  0086 c65204        	ld	a,20996
1328  0089               L1221:
1329                     ; 292   while(!(SPI->SR & SPI_SR_TXE));
1331  0089 72035203fb    	btjf	20995,#1,L1221
1332                     ; 293   SPI->DR = data[1];
1334  008e e601          	ld	a,(1,x)
1335  0090 c75204        	ld	20996,a
1337  0093               L1321:
1338                     ; 294   while(!(SPI->SR & SPI_SR_RXNE));
1340  0093 72015203fb    	btjf	20995,#0,L1321
1341                     ; 295   tmp = SPI->DR;
1343  0098 c65204        	ld	a,20996
1345  009b               L7321:
1346                     ; 296   while(!(SPI->SR & SPI_SR_TXE));
1348  009b 72035203fb    	btjf	20995,#1,L7321
1349                     ; 297   SPI_CS_HIGH;
1351  00a0 7218500a      	bset	20490,#4
1352                     ; 298   DELAY_US(DELAY_15US);
1354  00a4 ae0050        	ldw	x,#80
1356  00a7               L26:
1357  00a7 5a            	decw	X
1358  00a8 26fd          	jrne	L26
1359  00aa 9d            	nop	
1361                     ; 299   for(i = 2; i < nr_words*2;)
1364  00ab ae0002        	ldw	x,#2
1365  00ae 1f01          	ldw	(OFST-2,sp),x
1367  00b0 205b          	jra	L7421
1368  00b2               L3421:
1369                     ; 301     SPI_CS_LOW;
1371  00b2 7219500a      	bres	20490,#4
1372                     ; 302     DELAY_US(SPI_CS_LOW_DELAY);
1374  00b6 ae000c        	ldw	x,#12
1376  00b9               L46:
1377  00b9 5a            	decw	X
1378  00ba 26fd          	jrne	L46
1379  00bc 9d            	nop	
1381                     ; 303     SPI->DR = AAI_WORD_PROGRAM;
1384  00bd 35ad5204      	mov	20996,#173
1386  00c1               L7521:
1387                     ; 304     while(!(SPI->SR & SPI_SR_RXNE));
1389  00c1 72015203fb    	btjf	20995,#0,L7521
1390                     ; 305     tmp = SPI->DR;
1392  00c6 c65204        	ld	a,20996
1394  00c9               L5621:
1395                     ; 306     while(!(SPI->SR & SPI_SR_TXE));
1397  00c9 72035203fb    	btjf	20995,#1,L5621
1398                     ; 307     SPI->DR = data[i++]; 
1400  00ce 1e01          	ldw	x,(OFST-2,sp)
1401  00d0 5c            	incw	x
1402  00d1 1f01          	ldw	(OFST-2,sp),x
1403  00d3 5a            	decw	x
1404  00d4 72fb0a        	addw	x,(OFST+7,sp)
1405  00d7 f6            	ld	a,(x)
1406  00d8 c75204        	ld	20996,a
1408  00db               L5721:
1409                     ; 308     while(!(SPI->SR & SPI_SR_RXNE));
1411  00db 72015203fb    	btjf	20995,#0,L5721
1412                     ; 309     tmp = SPI->DR;
1414  00e0 c65204        	ld	a,20996
1416  00e3               L3031:
1417                     ; 310     while(!(SPI->SR & SPI_SR_TXE));
1419  00e3 72035203fb    	btjf	20995,#1,L3031
1420                     ; 311     SPI->DR = data[i++];
1422  00e8 1e01          	ldw	x,(OFST-2,sp)
1423  00ea 5c            	incw	x
1424  00eb 1f01          	ldw	(OFST-2,sp),x
1425  00ed 5a            	decw	x
1426  00ee 72fb0a        	addw	x,(OFST+7,sp)
1427  00f1 f6            	ld	a,(x)
1428  00f2 c75204        	ld	20996,a
1430  00f5               L3131:
1431                     ; 312     while(!(SPI->SR & SPI_SR_RXNE));
1433  00f5 72015203fb    	btjf	20995,#0,L3131
1434                     ; 313     tmp = SPI->DR;
1436  00fa c65204        	ld	a,20996
1438  00fd               L1231:
1439                     ; 314     while(!(SPI->SR & SPI_SR_TXE));
1441  00fd 72035203fb    	btjf	20995,#1,L1231
1442                     ; 315     SPI_CS_HIGH;
1444  0102 7218500a      	bset	20490,#4
1445                     ; 316     DELAY_US(DELAY_15US);
1447  0106 ae0050        	ldw	x,#80
1449  0109               L66:
1450  0109 5a            	decw	X
1451  010a 26fd          	jrne	L66
1452  010c 9d            	nop	
1455  010d               L7421:
1456                     ; 299   for(i = 2; i < nr_words*2;)
1458  010d 1e0c          	ldw	x,(OFST+9,sp)
1459  010f 58            	sllw	x
1460  0110 1301          	cpw	x,(OFST-2,sp)
1461  0112 229e          	jrugt	L3421
1462                     ; 319   SPI_CS_LOW;
1464  0114 7219500a      	bres	20490,#4
1465                     ; 320   DELAY_US(SPI_CS_LOW_DELAY);
1467  0118 ae000c        	ldw	x,#12
1469  011b               L07:
1470  011b 5a            	decw	X
1471  011c 26fd          	jrne	L07
1472  011e 9d            	nop	
1474                     ; 321   SPI->DR = WR_DIS;    /* Exit AAI mode */
1477  011f 35045204      	mov	20996,#4
1479  0123               L1331:
1480                     ; 322   while(!(SPI->SR & SPI_SR_RXNE));
1482  0123 72015203fb    	btjf	20995,#0,L1331
1483                     ; 323   tmp = SPI->DR;
1485  0128 c65204        	ld	a,20996
1487  012b               L7331:
1488                     ; 324   while(!(SPI->SR & SPI_SR_TXE));
1490  012b 72035203fb    	btjf	20995,#1,L7331
1492  0130               L5431:
1493                     ; 325   while(SPI->SR & SPI_SR_BSY);
1495  0130 720e5203fb    	btjt	20995,#7,L5431
1496                     ; 326   SPI_CS_HIGH;
1498  0135 7218500a      	bset	20490,#4
1499                     ; 327   DELAY_US(DELAY_15US);
1501  0139 ae0050        	ldw	x,#80
1503  013c               L27:
1504  013c 5a            	decw	X
1505  013d 26fd          	jrne	L27
1506  013f 9d            	nop	
1508                     ; 328 }
1512  0140 5b03          	addw	sp,#3
1513  0142 81            	ret	
1559                     ; 339 void SST25VF016_Sector_Erase_4KB(ExtFlashAdr addr)
1559                     ; 340 {
1560                     .text:	section	.text,new
1561  0000               _SST25VF016_Sector_Erase_4KB:
1563  0000 88            	push	a
1564       00000001      OFST:	set	1
1567                     ; 342   SPI_CS_LOW;
1569  0001 7219500a      	bres	20490,#4
1570                     ; 343   DELAY_US(SPI_CS_LOW_DELAY);
1572  0005 ae000c        	ldw	x,#12
1574  0008               L67:
1575  0008 5a            	decw	X
1576  0009 26fd          	jrne	L67
1577  000b 9d            	nop	
1579                     ; 344   SPI->DR = WR_EN;
1582  000c 35065204      	mov	20996,#6
1584  0010               L7731:
1585                     ; 345   while(!(SPI->SR & SPI_SR_RXNE));
1587  0010 72015203fb    	btjf	20995,#0,L7731
1588                     ; 346   tmp = SPI->DR;
1590  0015 c65204        	ld	a,20996
1592  0018               L5041:
1593                     ; 347   while(!(SPI->SR & SPI_SR_TXE));
1595  0018 72035203fb    	btjf	20995,#1,L5041
1596                     ; 348   SPI_CS_HIGH;
1598  001d 7218500a      	bset	20490,#4
1599                     ; 349   DELAY_US(SPI_CS_LOW_DELAY);
1601  0021 ae000c        	ldw	x,#12
1603  0024               L001:
1604  0024 5a            	decw	X
1605  0025 26fd          	jrne	L001
1606  0027 9d            	nop	
1608                     ; 351   SPI_CS_LOW;
1611  0028 7219500a      	bres	20490,#4
1612                     ; 352   DELAY_US(SPI_CS_LOW_DELAY);
1614  002c ae000c        	ldw	x,#12
1616  002f               L201:
1617  002f 5a            	decw	X
1618  0030 26fd          	jrne	L201
1619  0032 9d            	nop	
1621                     ; 353   SPI->DR = SEC_ERASE_4KB;
1624  0033 35205204      	mov	20996,#32
1626  0037               L5141:
1627                     ; 354   while(!(SPI->SR & SPI_SR_RXNE));
1629  0037 72015203fb    	btjf	20995,#0,L5141
1630                     ; 355   tmp = SPI->DR;
1632  003c c65204        	ld	a,20996
1634  003f               L3241:
1635                     ; 356   while(!(SPI->SR & SPI_SR_TXE));
1637  003f 72035203fb    	btjf	20995,#1,L3241
1638                     ; 357   SPI->DR = addr.adr8b.HighByte;
1640  0044 7b05          	ld	a,(OFST+4,sp)
1641  0046 c75204        	ld	20996,a
1643  0049               L3341:
1644                     ; 358   while(!(SPI->SR & SPI_SR_RXNE));
1646  0049 72015203fb    	btjf	20995,#0,L3341
1647                     ; 359   tmp = SPI->DR;
1649  004e c65204        	ld	a,20996
1651  0051               L1441:
1652                     ; 360   while(!(SPI->SR & SPI_SR_TXE));
1654  0051 72035203fb    	btjf	20995,#1,L1441
1655                     ; 361   SPI->DR = addr.adr8b.MidByte;
1657  0056 7b06          	ld	a,(OFST+5,sp)
1658  0058 c75204        	ld	20996,a
1660  005b               L1541:
1661                     ; 362   while(!(SPI->SR & SPI_SR_RXNE));
1663  005b 72015203fb    	btjf	20995,#0,L1541
1664                     ; 363   tmp = SPI->DR;
1666  0060 c65204        	ld	a,20996
1668  0063               L7541:
1669                     ; 364   while(!(SPI->SR & SPI_SR_TXE));
1671  0063 72035203fb    	btjf	20995,#1,L7541
1672                     ; 365   SPI->DR = addr.adr8b.LowByte;
1674  0068 7b07          	ld	a,(OFST+6,sp)
1675  006a c75204        	ld	20996,a
1677  006d               L7641:
1678                     ; 366   while(!(SPI->SR & SPI_SR_RXNE));
1680  006d 72015203fb    	btjf	20995,#0,L7641
1681                     ; 367   tmp = SPI->DR;
1683  0072 c65204        	ld	a,20996
1685  0075               L5741:
1686                     ; 368   while(!(SPI->SR & SPI_SR_TXE));
1688  0075 72035203fb    	btjf	20995,#1,L5741
1690  007a               L3051:
1691                     ; 369   while(SPI->SR & SPI_SR_BSY);
1693  007a 720e5203fb    	btjt	20995,#7,L3051
1694                     ; 370   SPI_CS_HIGH;
1696  007f 7218500a      	bset	20490,#4
1697                     ; 371 }
1700  0083 84            	pop	a
1701  0084 81            	ret	
1747                     ; 386 void SST25VF016_Block_Erase_32KB(ExtFlashAdr addr)
1747                     ; 387 {
1748                     .text:	section	.text,new
1749  0000               _SST25VF016_Block_Erase_32KB:
1751  0000 88            	push	a
1752       00000001      OFST:	set	1
1755                     ; 389   SPI_CS_LOW;
1757  0001 7219500a      	bres	20490,#4
1758                     ; 390   DELAY_US(SPI_CS_LOW_DELAY);
1760  0005 ae000c        	ldw	x,#12
1762  0008               L601:
1763  0008 5a            	decw	X
1764  0009 26fd          	jrne	L601
1765  000b 9d            	nop	
1767                     ; 391   SPI->DR = WR_EN;
1770  000c 35065204      	mov	20996,#6
1772  0010               L5351:
1773                     ; 392   while(!(SPI->SR & SPI_SR_RXNE));
1775  0010 72015203fb    	btjf	20995,#0,L5351
1776                     ; 393   tmp = SPI->DR;
1778  0015 c65204        	ld	a,20996
1780  0018               L3451:
1781                     ; 394   while(!(SPI->SR & SPI_SR_TXE));
1783  0018 72035203fb    	btjf	20995,#1,L3451
1784                     ; 395   SPI_CS_HIGH;
1786  001d 7218500a      	bset	20490,#4
1787                     ; 396   DELAY_US(SPI_CS_LOW_DELAY);
1789  0021 ae000c        	ldw	x,#12
1791  0024               L011:
1792  0024 5a            	decw	X
1793  0025 26fd          	jrne	L011
1794  0027 9d            	nop	
1796                     ; 398   SPI_CS_LOW;
1799  0028 7219500a      	bres	20490,#4
1800                     ; 399   DELAY_US(SPI_CS_LOW_DELAY);
1802  002c ae000c        	ldw	x,#12
1804  002f               L211:
1805  002f 5a            	decw	X
1806  0030 26fd          	jrne	L211
1807  0032 9d            	nop	
1809                     ; 400   SPI->DR = SEC_ERASE_32KB;
1812  0033 35525204      	mov	20996,#82
1814  0037               L3551:
1815                     ; 401   while(!(SPI->SR & SPI_SR_RXNE));
1817  0037 72015203fb    	btjf	20995,#0,L3551
1818                     ; 402   tmp = SPI->DR;
1820  003c c65204        	ld	a,20996
1822  003f               L1651:
1823                     ; 403   while(!(SPI->SR & SPI_SR_TXE));
1825  003f 72035203fb    	btjf	20995,#1,L1651
1826                     ; 404   SPI->DR = addr.adr8b.HighByte;
1828  0044 7b05          	ld	a,(OFST+4,sp)
1829  0046 c75204        	ld	20996,a
1831  0049               L1751:
1832                     ; 405   while(!(SPI->SR & SPI_SR_RXNE));
1834  0049 72015203fb    	btjf	20995,#0,L1751
1835                     ; 406   tmp = SPI->DR;
1837  004e c65204        	ld	a,20996
1839  0051               L7751:
1840                     ; 407   while(!(SPI->SR & SPI_SR_TXE));
1842  0051 72035203fb    	btjf	20995,#1,L7751
1843                     ; 408   SPI->DR = addr.adr8b.MidByte;
1845  0056 7b06          	ld	a,(OFST+5,sp)
1846  0058 c75204        	ld	20996,a
1848  005b               L7061:
1849                     ; 409   while(!(SPI->SR & SPI_SR_RXNE));
1851  005b 72015203fb    	btjf	20995,#0,L7061
1852                     ; 410   tmp = SPI->DR;
1854  0060 c65204        	ld	a,20996
1856  0063               L5161:
1857                     ; 411   while(!(SPI->SR & SPI_SR_TXE));
1859  0063 72035203fb    	btjf	20995,#1,L5161
1860                     ; 412   SPI->DR = addr.adr8b.LowByte;
1862  0068 7b07          	ld	a,(OFST+6,sp)
1863  006a c75204        	ld	20996,a
1865  006d               L5261:
1866                     ; 413   while(!(SPI->SR & SPI_SR_RXNE));
1868  006d 72015203fb    	btjf	20995,#0,L5261
1869                     ; 414   tmp = SPI->DR;
1871  0072 c65204        	ld	a,20996
1873  0075               L3361:
1874                     ; 415   while(!(SPI->SR & SPI_SR_TXE));
1876  0075 72035203fb    	btjf	20995,#1,L3361
1878  007a               L1461:
1879                     ; 416   while(SPI->SR & SPI_SR_BSY);
1881  007a 720e5203fb    	btjt	20995,#7,L1461
1882                     ; 417   SPI_CS_HIGH;
1884  007f 7218500a      	bset	20490,#4
1885                     ; 418 }
1888  0083 84            	pop	a
1889  0084 81            	ret	
1935                     ; 420 void SST25VF016_Block_Erase_64KB(ExtFlashAdr addr)
1935                     ; 421 {
1936                     .text:	section	.text,new
1937  0000               _SST25VF016_Block_Erase_64KB:
1939  0000 88            	push	a
1940       00000001      OFST:	set	1
1943                     ; 423   SPI_CS_LOW;
1945  0001 7219500a      	bres	20490,#4
1946                     ; 424   DELAY_US(SPI_CS_LOW_DELAY);
1948  0005 ae000c        	ldw	x,#12
1950  0008               L611:
1951  0008 5a            	decw	X
1952  0009 26fd          	jrne	L611
1953  000b 9d            	nop	
1955                     ; 425   SPI->DR = WR_EN;
1958  000c 35065204      	mov	20996,#6
1960  0010               L3761:
1961                     ; 426   while(!(SPI->SR & SPI_SR_RXNE));
1963  0010 72015203fb    	btjf	20995,#0,L3761
1964                     ; 427   tmp = SPI->DR;
1966  0015 c65204        	ld	a,20996
1968  0018               L1071:
1969                     ; 428   while(!(SPI->SR & SPI_SR_TXE));
1971  0018 72035203fb    	btjf	20995,#1,L1071
1972                     ; 429   SPI_CS_HIGH;
1974  001d 7218500a      	bset	20490,#4
1975                     ; 430   DELAY_US(SPI_CS_LOW_DELAY);
1977  0021 ae000c        	ldw	x,#12
1979  0024               L021:
1980  0024 5a            	decw	X
1981  0025 26fd          	jrne	L021
1982  0027 9d            	nop	
1984                     ; 432   SPI_CS_LOW;
1987  0028 7219500a      	bres	20490,#4
1988                     ; 433   DELAY_US(SPI_CS_LOW_DELAY);
1990  002c ae000c        	ldw	x,#12
1992  002f               L221:
1993  002f 5a            	decw	X
1994  0030 26fd          	jrne	L221
1995  0032 9d            	nop	
1997                     ; 434   SPI->DR = SEC_ERASE_64KB;
2000  0033 35d85204      	mov	20996,#216
2002  0037               L1171:
2003                     ; 435   while(!(SPI->SR & SPI_SR_RXNE));
2005  0037 72015203fb    	btjf	20995,#0,L1171
2006                     ; 436   tmp = SPI->DR;
2008  003c c65204        	ld	a,20996
2010  003f               L7171:
2011                     ; 437   while(!(SPI->SR & SPI_SR_TXE));
2013  003f 72035203fb    	btjf	20995,#1,L7171
2014                     ; 438   SPI->DR = addr.adr8b.HighByte;
2016  0044 7b05          	ld	a,(OFST+4,sp)
2017  0046 c75204        	ld	20996,a
2019  0049               L7271:
2020                     ; 439   while(!(SPI->SR & SPI_SR_RXNE));
2022  0049 72015203fb    	btjf	20995,#0,L7271
2023                     ; 440   tmp = SPI->DR;
2025  004e c65204        	ld	a,20996
2027  0051               L5371:
2028                     ; 441   while(!(SPI->SR & SPI_SR_TXE));
2030  0051 72035203fb    	btjf	20995,#1,L5371
2031                     ; 442   SPI->DR = addr.adr8b.MidByte;
2033  0056 7b06          	ld	a,(OFST+5,sp)
2034  0058 c75204        	ld	20996,a
2036  005b               L5471:
2037                     ; 443   while(!(SPI->SR & SPI_SR_RXNE));
2039  005b 72015203fb    	btjf	20995,#0,L5471
2040                     ; 444   tmp = SPI->DR;
2042  0060 c65204        	ld	a,20996
2044  0063               L3571:
2045                     ; 445   while(!(SPI->SR & SPI_SR_TXE));
2047  0063 72035203fb    	btjf	20995,#1,L3571
2048                     ; 446   SPI->DR = addr.adr8b.LowByte;
2050  0068 7b07          	ld	a,(OFST+6,sp)
2051  006a c75204        	ld	20996,a
2053  006d               L3671:
2054                     ; 447   while(!(SPI->SR & SPI_SR_RXNE));
2056  006d 72015203fb    	btjf	20995,#0,L3671
2057                     ; 448   tmp = SPI->DR;
2059  0072 c65204        	ld	a,20996
2061  0075               L1771:
2062                     ; 449   while(!(SPI->SR & SPI_SR_TXE));
2064  0075 72035203fb    	btjf	20995,#1,L1771
2066  007a               L7771:
2067                     ; 450   while(SPI->SR & SPI_SR_BSY);
2069  007a 720e5203fb    	btjt	20995,#7,L7771
2070                     ; 451   SPI_CS_HIGH;
2072  007f 7218500a      	bset	20490,#4
2073                     ; 452 }
2076  0083 84            	pop	a
2077  0084 81            	ret	
2113                     ; 461 void SST25VF016_Chip_Erase()
2113                     ; 462 {
2114                     .text:	section	.text,new
2115  0000               _SST25VF016_Chip_Erase:
2117       00000001      OFST:	set	1
2120                     ; 464   SPI_CS_LOW;
2122  0000 7219500a      	bres	20490,#4
2123                     ; 465   DELAY_US(SPI_CS_LOW_DELAY);
2125  0004 ae000c        	ldw	x,#12
2127  0007               L621:
2128  0007 5a            	decw	X
2129  0008 26fd          	jrne	L621
2130  000a 9d            	nop	
2132                     ; 466   SPI->DR = WR_EN;
2135  000b 35065204      	mov	20996,#6
2137  000f               L5202:
2138                     ; 467   while(!(SPI->SR & SPI_SR_RXNE));
2140  000f 72015203fb    	btjf	20995,#0,L5202
2141                     ; 468   tmp = SPI->DR;
2143  0014 c65204        	ld	a,20996
2145  0017               L3302:
2146                     ; 469   while(!(SPI->SR & SPI_SR_TXE));
2148  0017 72035203fb    	btjf	20995,#1,L3302
2149                     ; 470   SPI_CS_HIGH;
2151  001c 7218500a      	bset	20490,#4
2152                     ; 471   DELAY_US(SPI_CS_LOW_DELAY);
2154  0020 ae000c        	ldw	x,#12
2156  0023               L031:
2157  0023 5a            	decw	X
2158  0024 26fd          	jrne	L031
2159  0026 9d            	nop	
2161                     ; 473   SPI_CS_LOW;
2164  0027 7219500a      	bres	20490,#4
2165                     ; 474   DELAY_US(SPI_CS_LOW_DELAY);
2167  002b ae000c        	ldw	x,#12
2169  002e               L231:
2170  002e 5a            	decw	X
2171  002f 26fd          	jrne	L231
2172  0031 9d            	nop	
2174                     ; 475   SPI->DR = CHIP_ERASE;
2177  0032 35605204      	mov	20996,#96
2179  0036               L3402:
2180                     ; 476   while(!(SPI->SR & SPI_SR_RXNE));
2182  0036 72015203fb    	btjf	20995,#0,L3402
2183                     ; 477   tmp = SPI->DR;
2185  003b c65204        	ld	a,20996
2187  003e               L1502:
2188                     ; 478   while(!(SPI->SR & SPI_SR_TXE));
2190  003e 72035203fb    	btjf	20995,#1,L1502
2192  0043               L7502:
2193                     ; 479   while(SPI->SR & SPI_SR_BSY);
2195  0043 720e5203fb    	btjt	20995,#7,L7502
2196                     ; 480   SPI_CS_HIGH;
2198  0048 7218500a      	bset	20490,#4
2199                     ; 481 }
2202  004c 81            	ret	
2247                     ; 494 void SST25VF016_Write_Status_Register(u8 data)
2247                     ; 495 {
2248                     .text:	section	.text,new
2249  0000               _SST25VF016_Write_Status_Register:
2251  0000 88            	push	a
2252  0001 88            	push	a
2253       00000001      OFST:	set	1
2256                     ; 497   SPI_CS_LOW;
2258  0002 7219500a      	bres	20490,#4
2259                     ; 498   DELAY_US(SPI_CS_LOW_DELAY);
2261  0006 ae000c        	ldw	x,#12
2263  0009               L631:
2264  0009 5a            	decw	X
2265  000a 26fd          	jrne	L631
2266  000c 9d            	nop	
2268                     ; 499   SPI->DR = EN_WR_STAT_REG;
2271  000d 35505204      	mov	20996,#80
2273  0011               L1112:
2274                     ; 500   while(!(SPI->SR & SPI_SR_RXNE));
2276  0011 72015203fb    	btjf	20995,#0,L1112
2277                     ; 501   tmp = SPI->DR;
2279  0016 c65204        	ld	a,20996
2281  0019               L7112:
2282                     ; 502   while(!(SPI->SR & SPI_SR_TXE));
2284  0019 72035203fb    	btjf	20995,#1,L7112
2285                     ; 503   SPI_CS_HIGH;
2287  001e 7218500a      	bset	20490,#4
2288                     ; 504   DELAY_US(SPI_CS_LOW_DELAY);
2290  0022 ae000c        	ldw	x,#12
2292  0025               L041:
2293  0025 5a            	decw	X
2294  0026 26fd          	jrne	L041
2295  0028 9d            	nop	
2297                     ; 506   SPI_CS_LOW;
2300  0029 7219500a      	bres	20490,#4
2301                     ; 507   DELAY_US(SPI_CS_LOW_DELAY);
2303  002d ae000c        	ldw	x,#12
2305  0030               L241:
2306  0030 5a            	decw	X
2307  0031 26fd          	jrne	L241
2308  0033 9d            	nop	
2310                     ; 508   SPI->DR = WR_STAT_REG;
2313  0034 35015204      	mov	20996,#1
2315  0038               L7212:
2316                     ; 509   while(!(SPI->SR & SPI_SR_RXNE));
2318  0038 72015203fb    	btjf	20995,#0,L7212
2319                     ; 510   tmp = SPI->DR;
2321  003d c65204        	ld	a,20996
2323  0040               L5312:
2324                     ; 511   while(!(SPI->SR & SPI_SR_TXE));
2326  0040 72035203fb    	btjf	20995,#1,L5312
2327                     ; 512   SPI->DR = data;
2329  0045 7b02          	ld	a,(OFST+1,sp)
2330  0047 c75204        	ld	20996,a
2332  004a               L5412:
2333                     ; 513   while(!(SPI->SR & SPI_SR_RXNE));
2335  004a 72015203fb    	btjf	20995,#0,L5412
2336                     ; 514   tmp = SPI->DR;
2338  004f c65204        	ld	a,20996
2340  0052               L3512:
2341                     ; 515   while(!(SPI->SR & SPI_SR_TXE));
2343  0052 72035203fb    	btjf	20995,#1,L3512
2345  0057               L1612:
2346                     ; 516   while(SPI->SR & SPI_SR_BSY);
2348  0057 720e5203fb    	btjt	20995,#7,L1612
2349                     ; 517   SPI_CS_HIGH;
2351  005c 7218500a      	bset	20490,#4
2352                     ; 518 }
2355  0060 85            	popw	x
2356  0061 81            	ret	
2392                     ; 526 u8 SST25VF016_Read_Status_Register()
2392                     ; 527 {
2393                     .text:	section	.text,new
2394  0000               _SST25VF016_Read_Status_Register:
2396  0000 88            	push	a
2397       00000001      OFST:	set	1
2400                     ; 529   SPI_CS_LOW;
2402  0001 7219500a      	bres	20490,#4
2403                     ; 530   DELAY_US(SPI_CS_LOW_DELAY);
2405  0005 ae000c        	ldw	x,#12
2407  0008               L641:
2408  0008 5a            	decw	X
2409  0009 26fd          	jrne	L641
2410  000b 9d            	nop	
2412                     ; 531   SPI->DR = RD_STAT_REG;
2415  000c 35055204      	mov	20996,#5
2417  0010               L7022:
2418                     ; 532   while(!(SPI->SR & SPI_SR_RXNE));
2420  0010 72015203fb    	btjf	20995,#0,L7022
2421                     ; 533   tmp = SPI->DR;
2423  0015 c65204        	ld	a,20996
2425  0018               L5122:
2426                     ; 534   while(!(SPI->SR & SPI_SR_TXE));
2428  0018 72035203fb    	btjf	20995,#1,L5122
2429                     ; 535   SPI->DR = DUMMY;   //dummy
2431  001d 35ff5204      	mov	20996,#255
2433  0021               L5222:
2434                     ; 536   while(!(SPI->SR & SPI_SR_RXNE));
2436  0021 72015203fb    	btjf	20995,#0,L5222
2437                     ; 537   tmp = SPI->DR;     //read status register
2439  0026 c65204        	ld	a,20996
2440  0029 6b01          	ld	(OFST+0,sp),a
2442  002b               L5322:
2443                     ; 538   while(!(SPI->SR & SPI_SR_TXE));
2445  002b 72035203fb    	btjf	20995,#1,L5322
2447  0030               L3422:
2448                     ; 539   while(SPI->SR & SPI_SR_BSY);
2450  0030 720e5203fb    	btjt	20995,#7,L3422
2451                     ; 540   SPI_CS_HIGH;
2453  0035 7218500a      	bset	20490,#4
2454                     ; 541   return tmp;
2458  0039 5b01          	addw	sp,#1
2459  003b 81            	ret	
2505                     ; 551 void SST25VF016_Read_JEDEC_ID(u8* buffer)
2505                     ; 552 {
2506                     .text:	section	.text,new
2507  0000               _SST25VF016_Read_JEDEC_ID:
2509  0000 89            	pushw	x
2510  0001 88            	push	a
2511       00000001      OFST:	set	1
2514                     ; 554   SPI_CS_LOW;
2516  0002 7219500a      	bres	20490,#4
2517                     ; 555   DELAY_US(SPI_CS_LOW_DELAY);
2519  0006 ae000c        	ldw	x,#12
2521  0009               L251:
2522  0009 5a            	decw	X
2523  000a 26fd          	jrne	L251
2524  000c 9d            	nop	
2526                     ; 556   SPI->DR = RD_JEDEC_ID;
2529  000d 359f5204      	mov	20996,#159
2531  0011               L5722:
2532                     ; 557   while(!(SPI->SR & SPI_SR_RXNE));
2534  0011 72015203fb    	btjf	20995,#0,L5722
2535                     ; 558   tmp = SPI->DR;
2537  0016 c65204        	ld	a,20996
2539  0019               L3032:
2540                     ; 559   while(!(SPI->SR & SPI_SR_TXE));
2542  0019 72035203fb    	btjf	20995,#1,L3032
2543                     ; 560   SPI->DR = DUMMY;   //dummy
2545  001e 35ff5204      	mov	20996,#255
2547  0022               L3132:
2548                     ; 561   while(!(SPI->SR & SPI_SR_RXNE));
2550  0022 72015203fb    	btjf	20995,#0,L3132
2551                     ; 562   buffer[0] = SPI->DR;
2553  0027 1e02          	ldw	x,(OFST+1,sp)
2554  0029 c65204        	ld	a,20996
2555  002c f7            	ld	(x),a
2557  002d               L3232:
2558                     ; 563   while(!(SPI->SR & SPI_SR_TXE));
2560  002d 72035203fb    	btjf	20995,#1,L3232
2561                     ; 564   SPI->DR = DUMMY;   //dummy
2563  0032 35ff5204      	mov	20996,#255
2565  0036               L3332:
2566                     ; 565   while(!(SPI->SR & SPI_SR_RXNE));
2568  0036 72015203fb    	btjf	20995,#0,L3332
2569                     ; 566   buffer[1] = SPI->DR;
2571  003b c65204        	ld	a,20996
2572  003e e701          	ld	(1,x),a
2574  0040               L3432:
2575                     ; 567   while(!(SPI->SR & SPI_SR_TXE));
2577  0040 72035203fb    	btjf	20995,#1,L3432
2578                     ; 568   SPI->DR = DUMMY;   //dummy
2580  0045 35ff5204      	mov	20996,#255
2582  0049               L3532:
2583                     ; 569   while(!(SPI->SR & SPI_SR_RXNE));
2585  0049 72015203fb    	btjf	20995,#0,L3532
2586                     ; 570   buffer[2] = SPI->DR;
2588  004e c65204        	ld	a,20996
2589  0051 e702          	ld	(2,x),a
2591  0053               L3632:
2592                     ; 571   while(!(SPI->SR & SPI_SR_TXE));
2594  0053 72035203fb    	btjf	20995,#1,L3632
2596  0058               L1732:
2597                     ; 572   while(SPI->SR & SPI_SR_BSY);
2599  0058 720e5203fb    	btjt	20995,#7,L1732
2600                     ; 573   SPI_CS_HIGH;
2602  005d 7218500a      	bset	20490,#4
2603                     ; 574 }
2606  0061 5b03          	addw	sp,#3
2607  0063 81            	ret	
2652                     ; 583 void SST25VF016_Read_ID(u8* buffer)
2652                     ; 584 {
2653                     .text:	section	.text,new
2654  0000               _SST25VF016_Read_ID:
2656  0000 89            	pushw	x
2657  0001 88            	push	a
2658       00000001      OFST:	set	1
2661                     ; 586   SPI_CS_LOW;
2663  0002 7219500a      	bres	20490,#4
2664                     ; 587   DELAY_US(SPI_CS_LOW_DELAY);
2666  0006 ae000c        	ldw	x,#12
2668  0009               L651:
2669  0009 5a            	decw	X
2670  000a 26fd          	jrne	L651
2671  000c 9d            	nop	
2673                     ; 588   SPI->DR = RD_ID;
2676  000d 35905204      	mov	20996,#144
2678  0011               L3242:
2679                     ; 589   while(!(SPI->SR & SPI_SR_RXNE));
2681  0011 72015203fb    	btjf	20995,#0,L3242
2682                     ; 590   tmp = SPI->DR;
2684  0016 c65204        	ld	a,20996
2686  0019               L1342:
2687                     ; 591   while(!(SPI->SR & SPI_SR_TXE));
2689  0019 72035203fb    	btjf	20995,#1,L1342
2690                     ; 592   SPI->DR = 0x00;    //address
2692  001e 725f5204      	clr	20996
2694  0022               L1442:
2695                     ; 593   while(!(SPI->SR & SPI_SR_RXNE));
2697  0022 72015203fb    	btjf	20995,#0,L1442
2698                     ; 594   tmp = SPI->DR;
2700  0027 c65204        	ld	a,20996
2702  002a               L7442:
2703                     ; 595   while(!(SPI->SR & SPI_SR_TXE));
2705  002a 72035203fb    	btjf	20995,#1,L7442
2706                     ; 596   SPI->DR = 0x00;   //address
2708  002f 725f5204      	clr	20996
2710  0033               L7542:
2711                     ; 597   while(!(SPI->SR & SPI_SR_RXNE));
2713  0033 72015203fb    	btjf	20995,#0,L7542
2714                     ; 598   tmp = SPI->DR;
2716  0038 c65204        	ld	a,20996
2718  003b               L5642:
2719                     ; 599   while(!(SPI->SR & SPI_SR_TXE));
2721  003b 72035203fb    	btjf	20995,#1,L5642
2722                     ; 600   SPI->DR = 0x00;   //address
2724  0040 725f5204      	clr	20996
2726  0044               L5742:
2727                     ; 601   while(!(SPI->SR & SPI_SR_RXNE)); 
2729  0044 72015203fb    	btjf	20995,#0,L5742
2730                     ; 602   tmp = SPI->DR; 
2732  0049 c65204        	ld	a,20996
2734  004c               L3052:
2735                     ; 603   while(!(SPI->SR & SPI_SR_TXE));
2737  004c 72035203fb    	btjf	20995,#1,L3052
2738                     ; 604   SPI->DR = DUMMY;   //dummy
2740  0051 35ff5204      	mov	20996,#255
2742  0055               L3152:
2743                     ; 605   while(!(SPI->SR & SPI_SR_RXNE));
2745  0055 72015203fb    	btjf	20995,#0,L3152
2746                     ; 606   buffer[0] = SPI->DR;
2748  005a 1e02          	ldw	x,(OFST+1,sp)
2749  005c c65204        	ld	a,20996
2750  005f f7            	ld	(x),a
2752  0060               L3252:
2753                     ; 607   while(!(SPI->SR & SPI_SR_TXE));
2755  0060 72035203fb    	btjf	20995,#1,L3252
2756                     ; 608   SPI->DR = DUMMY;   //dummy
2758  0065 35ff5204      	mov	20996,#255
2760  0069               L3352:
2761                     ; 609   while(!(SPI->SR & SPI_SR_RXNE));
2763  0069 72015203fb    	btjf	20995,#0,L3352
2764                     ; 610   buffer[1] = SPI->DR;
2766  006e c65204        	ld	a,20996
2767  0071 e701          	ld	(1,x),a
2769  0073               L3452:
2770                     ; 611   while(!(SPI->SR & SPI_SR_TXE));
2772  0073 72035203fb    	btjf	20995,#1,L3452
2774  0078               L1552:
2775                     ; 612   while(SPI->SR & SPI_SR_BSY);
2777  0078 720e5203fb    	btjt	20995,#7,L1552
2778                     ; 613   SPI_CS_HIGH;
2780  007d 7218500a      	bset	20490,#4
2781                     ; 614 }
2784  0081 5b03          	addw	sp,#3
2785  0083 81            	ret	
2798                     	xdef	_SST25VF016_Read_ID
2799                     	xdef	_SST25VF016_Read_JEDEC_ID
2800                     	xdef	_SST25VF016_Read_Status_Register
2801                     	xdef	_SST25VF016_Write_Status_Register
2802                     	xdef	_SST25VF016_Chip_Erase
2803                     	xdef	_SST25VF016_Block_Erase_64KB
2804                     	xdef	_SST25VF016_Block_Erase_32KB
2805                     	xdef	_SST25VF016_Sector_Erase_4KB
2806                     	xdef	_SST25VF016_AAI_Word_Program
2807                     	xdef	_SST25VF016_Disable_SY
2808                     	xdef	_SST25VF016_Enable_SY
2809                     	xdef	_SST25VF016_Program_Byte
2810                     	xdef	_SST25VF016_Read_HS
2811                     	xdef	_SST25VF016_Read_Byte
2812                     	xdef	_SST25VF016_Read
2813                     	xdef	_SST25VF016_Init
2814                     	xref	_SPI_Cmd
2815                     	xref	_SPI_Init
2816                     	xref	_SPI_DeInit
2835                     	end
