   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  68                     ; 22 void I2C_Flush(u8 cycles)
  68                     ; 23 {
  70                     .text:	section	.text,new
  71  0000               _I2C_Flush:
  73  0000 88            	push	a
  74  0001 88            	push	a
  75       00000001      OFST:	set	1
  78                     ; 25   for(i = 0; i < cycles; i++)
  80  0002 0f01          	clr	(OFST+0,sp)
  82  0004 2018          	jra	L73
  83  0006               L33:
  84                     ; 27     SCL_LOW;
  86  0006 72155005      	bres	20485,#2
  87                     ; 28     DELAY_US(DELAY_6US);  /*2uS*/
  89  000a ae0020        	ldw	x,#32
  91  000d               L6:
  92  000d 5a            	decw	X
  93  000e 26fd          	jrne	L6
  94  0010 9d            	nop	
  96                     ; 29     SCL_HIGH;
  99  0011 72145005      	bset	20485,#2
 100                     ; 30     DELAY_US(DELAY_6US);  /*2uS*/
 102  0015 ae0020        	ldw	x,#32
 104  0018               L01:
 105  0018 5a            	decw	X
 106  0019 26fd          	jrne	L01
 107  001b 9d            	nop	
 109                     ; 25   for(i = 0; i < cycles; i++)
 112  001c 0c01          	inc	(OFST+0,sp)
 113  001e               L73:
 116  001e 7b01          	ld	a,(OFST+0,sp)
 117  0020 1102          	cp	a,(OFST+1,sp)
 118  0022 25e2          	jrult	L33
 119                     ; 32 }
 122  0024 85            	popw	x
 123  0025 81            	ret	
 157                     ; 37 void write_scl(u8 x)
 157                     ; 38 {
 158                     .text:	section	.text,new
 159  0000               _write_scl:
 163                     ; 39       if(x)
 165  0000 4d            	tnz	a
 166  0001 270a          	jreq	L16
 167                     ; 41         SCL_HIGH;
 169  0003 72145005      	bset	20485,#2
 171  0007               L56:
 172                     ; 43 	    while(!SCL_READ);
 174  0007 72055006fb    	btjf	20486,#2,L56
 177  000c 81            	ret	
 178  000d               L16:
 179                     ; 47         SCL_LOW; 
 181  000d 72155005      	bres	20485,#2
 182                     ; 49 }
 185  0011 81            	ret	
 209                     ; 53 u8 I2C_StartCond(void)
 209                     ; 54 {
 210                     .text:	section	.text,new
 211  0000               _I2C_StartCond:
 215                     ; 55   SDA_LOW;
 217  0000 72175005      	bres	20485,#3
 218                     ; 56   DELAY_US(I2C_DELAY);
 220  0004 ae0006        	ldw	x,#6
 222  0007               L61:
 223  0007 5a            	decw	X
 224  0008 26fd          	jrne	L61
 225  000a 9d            	nop	
 227                     ; 58   write_scl(0);	
 230  000b 4f            	clr	a
 231  000c cd0000        	call	_write_scl
 233                     ; 59   DELAY_US(I2C_DELAY);
 235  000f ae0006        	ldw	x,#6
 237  0012               L22:
 238  0012 5a            	decw	X
 239  0013 26fd          	jrne	L22
 240  0015 9d            	nop	
 242                     ; 60   return 1;  
 245  0016 a601          	ld	a,#1
 248  0018 81            	ret	
 271                     ; 65 void toggle_scl(void) 
 271                     ; 66 {
 272                     .text:	section	.text,new
 273  0000               _toggle_scl:
 277                     ; 67   if(SCL_READ)
 279  0000 7205500605    	btjf	20486,#2,L311
 280                     ; 69     SCL_LOW;
 282  0005 72155005      	bres	20485,#2
 284                     ; 76 }
 287  0009 81            	ret	
 288  000a               L311:
 289                     ; 73     SCL_HIGH;
 291  000a 72145005      	bset	20485,#2
 293  000e               L121:
 294                     ; 74     while(!SCL_READ);
 296  000e 72055006fb    	btjf	20486,#2,L121
 298  0013 81            	ret	
 342                     ; 82 u8 I2C_WriteByte(u8 data)
 342                     ; 83 {
 343                     .text:	section	.text,new
 344  0000               _I2C_WriteByte:
 346  0000 88            	push	a
 347  0001 88            	push	a
 348       00000001      OFST:	set	1
 351                     ; 85   for (bit = 0; bit < 8; bit++) 
 353  0002 0f01          	clr	(OFST+0,sp)
 354  0004               L741:
 355                     ; 87     if((data & 0x80) != 0)
 357  0004 7b02          	ld	a,(OFST+1,sp)
 358  0006 2a06          	jrpl	L551
 359                     ; 89 	  SDA_HIGH;
 361  0008 72165005      	bset	20485,#3
 363  000c 2004          	jra	L751
 364  000e               L551:
 365                     ; 93 	  SDA_LOW;
 367  000e 72175005      	bres	20485,#3
 368  0012               L751:
 369                     ; 95     toggle_scl();//goes high
 371  0012 cd0000        	call	_toggle_scl
 373                     ; 96     DELAY_US(I2C_DELAY);
 375  0015 ae0006        	ldw	x,#6
 377  0018               L23:
 378  0018 5a            	decw	X
 379  0019 26fd          	jrne	L23
 380  001b 9d            	nop	
 382                     ; 97     toggle_scl();//goes low
 385  001c cd0000        	call	_toggle_scl
 387                     ; 98     data <<= 1;
 389  001f 0802          	sll	(OFST+1,sp)
 390                     ; 99     DELAY_US(I2C_DELAY);
 392  0021 ae0006        	ldw	x,#6
 394  0024               L63:
 395  0024 5a            	decw	X
 396  0025 26fd          	jrne	L63
 398                     ; 85   for (bit = 0; bit < 8; bit++) 
 401  0027 0c01          	inc	(OFST+0,sp)
 402  0029 9d            	nop	
 405  002a 7b01          	ld	a,(OFST+0,sp)
 406  002c a108          	cp	a,#8
 407  002e 25d4          	jrult	L741
 408                     ; 102   SDA_HIGH;
 410  0030 72165005      	bset	20485,#3
 411                     ; 103   toggle_scl(); //goes high for the 9th clock
 413  0034 cd0000        	call	_toggle_scl
 415                     ; 105   if(SDA_READ)
 417  0037 7207500603    	btjf	20486,#3,L161
 418                     ; 107     return 0;			
 420  003c 4f            	clr	a
 422  003d 2013          	jra	L05
 423  003f               L161:
 424                     ; 109   DELAY_US(I2C_DELAY);
 426  003f ae0006        	ldw	x,#6
 428  0042               L24:
 429  0042 5a            	decw	X
 430  0043 26fd          	jrne	L24
 431  0045 9d            	nop	
 433                     ; 111   toggle_scl(); //end of byte with acknowledgment. 
 436  0046 cd0000        	call	_toggle_scl
 438                     ; 112   DELAY_US(I2C_DELAY); 
 440  0049 ae0006        	ldw	x,#6
 442  004c               L64:
 443  004c 5a            	decw	X
 444  004d 26fd          	jrne	L64
 445  004f 9d            	nop	
 447                     ; 113   return 1;
 450  0050 a601          	ld	a,#1
 452  0052               L05:
 454  0052 85            	popw	x
 455  0053 81            	ret	
 527                     ; 122 u8 I2C_ReadByte(u8* rcvdata, u8 bytes, u8 index)
 527                     ; 123 {
 528                     .text:	section	.text,new
 529  0000               _I2C_ReadByte:
 531  0000 89            	pushw	x
 532  0001 89            	pushw	x
 533       00000002      OFST:	set	2
 536                     ; 124   u8 byte = 0;
 538  0002 0f01          	clr	(OFST-1,sp)
 539                     ; 125   u8 bit = 0;
 541                     ; 127   SDA_HIGH;
 543  0004 72165005      	bset	20485,#3
 544                     ; 128   for (bit = 0; bit < 8; bit++) 
 546  0008 0f02          	clr	(OFST+0,sp)
 547  000a               L122:
 548                     ; 130     toggle_scl();//goes high
 550  000a cd0000        	call	_toggle_scl
 552                     ; 131     if(SDA_READ)
 554  000d 7207500613    	btjf	20486,#3,L722
 555                     ; 133 	  byte |= (u8)((1 << (7- bit)));
 557  0012 a607          	ld	a,#7
 558  0014 1002          	sub	a,(OFST+0,sp)
 559  0016 5f            	clrw	x
 560  0017 97            	ld	xl,a
 561  0018 a601          	ld	a,#1
 562  001a 5d            	tnzw	x
 563  001b 2704          	jreq	L65
 564  001d               L06:
 565  001d 48            	sll	a
 566  001e 5a            	decw	x
 567  001f 26fc          	jrne	L06
 568  0021               L65:
 569  0021 1a01          	or	a,(OFST-1,sp)
 570  0023 6b01          	ld	(OFST-1,sp),a
 571  0025               L722:
 572                     ; 135     DELAY_US(I2C_DELAY);
 574  0025 ae0006        	ldw	x,#6
 576  0028               L26:
 577  0028 5a            	decw	X
 578  0029 26fd          	jrne	L26
 579  002b 9d            	nop	
 581                     ; 136     toggle_scl();//goes low
 584  002c cd0000        	call	_toggle_scl
 586                     ; 137     DELAY_US(I2C_DELAY);
 588  002f ae0006        	ldw	x,#6
 590  0032               L66:
 591  0032 5a            	decw	X
 592  0033 26fd          	jrne	L66
 594                     ; 128   for (bit = 0; bit < 8; bit++) 
 597  0035 0c02          	inc	(OFST+0,sp)
 598  0037 9d            	nop	
 601  0038 7b02          	ld	a,(OFST+0,sp)
 602  003a a108          	cp	a,#8
 603  003c 25cc          	jrult	L122
 604                     ; 139   rcvdata[index] = byte;
 606  003e 7b03          	ld	a,(OFST+1,sp)
 607  0040 97            	ld	xl,a
 608  0041 7b04          	ld	a,(OFST+2,sp)
 609  0043 1b08          	add	a,(OFST+6,sp)
 610  0045 2401          	jrnc	L07
 611  0047 5c            	incw	x
 612  0048               L07:
 613  0048 02            	rlwa	x,a
 614  0049 7b01          	ld	a,(OFST-1,sp)
 615  004b f7            	ld	(x),a
 616                     ; 140   if(index < (bytes-1))
 618  004c 5f            	clrw	x
 619  004d 7b07          	ld	a,(OFST+5,sp)
 620  004f 97            	ld	xl,a
 621  0050 5a            	decw	x
 622  0051 7b08          	ld	a,(OFST+6,sp)
 623  0053 905f          	clrw	y
 624  0055 9097          	ld	yl,a
 625  0057 90bf00        	ldw	c_y,y
 626  005a b300          	cpw	x,c_y
 627  005c 2d1d          	jrsle	L132
 628                     ; 142     SDA_LOW;
 630  005e 72175005      	bres	20485,#3
 631                     ; 143     toggle_scl(); //goes high for the 9th clock
 633  0062 cd0000        	call	_toggle_scl
 635                     ; 144     DELAY_US(I2C_DELAY);
 637  0065 ae0006        	ldw	x,#6
 639  0068               L47:
 640  0068 5a            	decw	X
 641  0069 26fd          	jrne	L47
 642  006b 9d            	nop	
 644                     ; 146     toggle_scl(); //end of byte with acknowledgment. 
 647  006c cd0000        	call	_toggle_scl
 649                     ; 148     SDA_HIGH;
 651  006f 72165005      	bset	20485,#3
 652                     ; 149     DELAY_US(I2C_DELAY);
 654  0073 ae0006        	ldw	x,#6
 656  0076               L001:
 657  0076 5a            	decw	X
 658  0077 26fd          	jrne	L001
 662  0079 2017          	jra	L332
 663  007b               L132:
 664                     ; 153     SDA_HIGH;
 666  007b 72165005      	bset	20485,#3
 667                     ; 154     toggle_scl(); //goes high for the 9th clock
 669  007f cd0000        	call	_toggle_scl
 671                     ; 155     DELAY_US(I2C_DELAY);
 673  0082 ae0006        	ldw	x,#6
 675  0085               L401:
 676  0085 5a            	decw	X
 677  0086 26fd          	jrne	L401
 678  0088 9d            	nop	
 680                     ; 157     toggle_scl(); //end of byte with acknowledgment. 
 683  0089 cd0000        	call	_toggle_scl
 685                     ; 159     DELAY_US(I2C_DELAY);
 687  008c ae0006        	ldw	x,#6
 689  008f               L011:
 690  008f 5a            	decw	X
 691  0090 26fd          	jrne	L011
 693  0092               L332:
 694  0092 9d            	nop	
 695                     ; 161   return 1;
 697  0093 a601          	ld	a,#1
 700  0095 5b04          	addw	sp,#4
 701  0097 81            	ret	
 785                     ; 171 u8 I2C_WriteBytes(u8* indata, u8 bytes, u8 slave_adr, u8 slave_reg)
 785                     ; 172 {
 786                     .text:	section	.text,new
 787  0000               _I2C_WriteBytes:
 789  0000 89            	pushw	x
 790  0001 89            	pushw	x
 791       00000002      OFST:	set	2
 794                     ; 173 	u8 index, ack = 0;
 796  0002 0f01          	clr	(OFST-1,sp)
 797                     ; 175 	if(!I2C_StartCond())
 799  0004 cd0000        	call	_I2C_StartCond
 801  0007 4d            	tnz	a
 802                     ; 177 		return 0;
 805  0008 2708          	jreq	L231
 806                     ; 179 	if(!I2C_WriteByte((u8)(slave_adr | WRITE)))
 808  000a 7b08          	ld	a,(OFST+6,sp)
 809  000c cd0000        	call	_I2C_WriteByte
 811  000f 4d            	tnz	a
 812  0010 2603          	jrne	L103
 813                     ; 181 		return 0;	
 816  0012               L231:
 818  0012 5b04          	addw	sp,#4
 819  0014 81            	ret	
 820  0015               L103:
 821                     ; 183 	if(!I2C_WriteByte(slave_reg))
 823  0015 7b09          	ld	a,(OFST+7,sp)
 824  0017 cd0000        	call	_I2C_WriteByte
 826  001a 4d            	tnz	a
 827                     ; 185       return 0;	
 830  001b 27f5          	jreq	L231
 831                     ; 187 	for(index = 0; index < bytes; index++)
 833  001d 0f02          	clr	(OFST+0,sp)
 835  001f 2029          	jra	L113
 836  0021               L503:
 837                     ; 189 		 ack = I2C_WriteByte(indata[index]);
 839  0021 7b03          	ld	a,(OFST+1,sp)
 840  0023 97            	ld	xl,a
 841  0024 7b04          	ld	a,(OFST+2,sp)
 842  0026 1b02          	add	a,(OFST+0,sp)
 843  0028 2401          	jrnc	L421
 844  002a 5c            	incw	x
 845  002b               L421:
 846  002b 02            	rlwa	x,a
 847  002c f6            	ld	a,(x)
 848  002d cd0000        	call	_I2C_WriteByte
 850  0030 6b01          	ld	(OFST-1,sp),a
 851                     ; 190 		 if(!ack)
 853  0032 2614          	jrne	L513
 854                     ; 192 			break;	
 855  0034               L313:
 856                     ; 196 	write_scl(1);
 858  0034 a601          	ld	a,#1
 859  0036 cd0000        	call	_write_scl
 861                     ; 197 	DELAY_US(SCL_SDA_DELAY);
 863  0039 ae0008        	ldw	x,#8
 865  003c               L031:
 866  003c 5a            	decw	X
 867  003d 26fd          	jrne	L031
 869                     ; 198 	SDA_HIGH;
 872  003f 72165005      	bset	20485,#3
 873  0043 9d            	nop	
 874                     ; 199 	return ack;
 876  0044 7b01          	ld	a,(OFST-1,sp)
 878  0046 20ca          	jra	L231
 879  0048               L513:
 880                     ; 187 	for(index = 0; index < bytes; index++)
 882  0048 0c02          	inc	(OFST+0,sp)
 883  004a               L113:
 886  004a 7b02          	ld	a,(OFST+0,sp)
 887  004c 1107          	cp	a,(OFST+5,sp)
 888  004e 25d1          	jrult	L503
 889  0050 20e2          	jra	L313
 973                     ; 209 u8 I2C_ReadBytes(u8* data, u8 bytes, u8 slave_adr, u8 slave_reg)
 973                     ; 210 {
 974                     .text:	section	.text,new
 975  0000               _I2C_ReadBytes:
 977  0000 89            	pushw	x
 978  0001 89            	pushw	x
 979       00000002      OFST:	set	2
 982                     ; 211   u8 index, success = 0;
 984  0002 0f01          	clr	(OFST-1,sp)
 985                     ; 212   if(!I2C_StartCond())
 987  0004 cd0000        	call	_I2C_StartCond
 989  0007 4d            	tnz	a
 990                     ; 214     return 0;
 993  0008 2708          	jreq	L261
 994                     ; 216   if(!I2C_WriteByte((u8)(slave_adr | WRITE)))
 996  000a 7b08          	ld	a,(OFST+6,sp)
 997  000c cd0000        	call	_I2C_WriteByte
 999  000f 4d            	tnz	a
1000  0010 2603          	jrne	L363
1001                     ; 218     return 0;	
1004  0012               L261:
1006  0012 5b04          	addw	sp,#4
1007  0014 81            	ret	
1008  0015               L363:
1009                     ; 220   if(!I2C_WriteByte(slave_reg))
1011  0015 7b09          	ld	a,(OFST+7,sp)
1012  0017 cd0000        	call	_I2C_WriteByte
1014  001a 4d            	tnz	a
1015                     ; 222     return 0;	
1018  001b 27f5          	jreq	L261
1019                     ; 224   write_scl(1);
1021  001d a601          	ld	a,#1
1022  001f cd0000        	call	_write_scl
1024                     ; 225 	DELAY_US(SCL_SDA_DELAY);
1026  0022 ae0008        	ldw	x,#8
1028  0025               L641:
1029  0025 5a            	decw	X
1030  0026 26fd          	jrne	L641
1031  0028 9d            	nop	
1033                     ; 226 	SDA_HIGH;
1036  0029 72165005      	bset	20485,#3
1037                     ; 227   if(!I2C_StartCond())
1039  002d cd0000        	call	_I2C_StartCond
1041  0030 4d            	tnz	a
1042                     ; 229     return 0;
1045  0031 27df          	jreq	L261
1046                     ; 231   if(!I2C_WriteByte((u8)(slave_adr | READ)))
1048  0033 7b08          	ld	a,(OFST+6,sp)
1049  0035 aa01          	or	a,#1
1050  0037 cd0000        	call	_I2C_WriteByte
1052  003a 4d            	tnz	a
1053                     ; 233     return 0;	
1056  003b 27d5          	jreq	L261
1057                     ; 235   for(index = 0; index < bytes; index++)
1059  003d 0f02          	clr	(OFST+0,sp)
1061  003f 2024          	jra	L773
1062  0041               L373:
1063                     ; 237     success = I2C_ReadByte(data, bytes, index);
1065  0041 88            	push	a
1066  0042 7b08          	ld	a,(OFST+6,sp)
1067  0044 88            	push	a
1068  0045 1e05          	ldw	x,(OFST+3,sp)
1069  0047 cd0000        	call	_I2C_ReadByte
1071  004a 85            	popw	x
1072  004b 6b01          	ld	(OFST-1,sp),a
1073                     ; 238     if(!success)
1075  004d 2614          	jrne	L304
1076                     ; 240       break; 
1077  004f               L104:
1078                     ; 244   write_scl(1);
1080  004f a601          	ld	a,#1
1081  0051 cd0000        	call	_write_scl
1083                     ; 245   DELAY_US(SCL_SDA_DELAY);
1085  0054 ae0008        	ldw	x,#8
1087  0057               L061:
1088  0057 5a            	decw	X
1089  0058 26fd          	jrne	L061
1091                     ; 246   SDA_HIGH;
1094  005a 72165005      	bset	20485,#3
1095  005e 9d            	nop	
1096                     ; 247   return success;
1098  005f 7b01          	ld	a,(OFST-1,sp)
1100  0061 20af          	jra	L261
1101  0063               L304:
1102                     ; 235   for(index = 0; index < bytes; index++)
1104  0063 0c02          	inc	(OFST+0,sp)
1105  0065               L773:
1108  0065 7b02          	ld	a,(OFST+0,sp)
1109  0067 1107          	cp	a,(OFST+5,sp)
1110  0069 25d6          	jrult	L373
1111  006b 20e2          	jra	L104
1124                     	xdef	_I2C_ReadBytes
1125                     	xdef	_I2C_WriteBytes
1126                     	xdef	_I2C_ReadByte
1127                     	xdef	_I2C_WriteByte
1128                     	xdef	_toggle_scl
1129                     	xdef	_I2C_StartCond
1130                     	xdef	_write_scl
1131                     	xdef	_I2C_Flush
1132                     	xref.b	c_y
1151                     	end
