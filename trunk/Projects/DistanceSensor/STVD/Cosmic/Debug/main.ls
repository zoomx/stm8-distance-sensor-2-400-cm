   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
  17                     	bsct
  18  0000               _temperature:
  19  0000 0000          	dc.w	0
  20  0002               _tempr:
  21  0002 00000000      	dc.w	0,0
  22  0006               _neg_temp_flag:
  23  0006 00            	dc.b	0
  24  0007               _tim1_cntr:
  25  0007 0000          	dc.w	0
  26  0009               _period:
  27  0009 00000000      	dc.l	0
  28  000d               _time:
  29  000d 32            	dc.b	50
  30  000e               _distance:
  31  000e 00000000      	dc.l	0
  32                     .const:	section	.text
  33  0000               _soundspeed0degC:
  34  0000 0cf1          	dc.w	3313
  35  0002               _soundspeedkfactor:
  36  0002 025e          	dc.w	606
  37                     	bsct
  38  0012               _soundspeedkfactorcorrection:
  39  0012 0000          	dc.w	0
  40  0014               _soundspeed:
  41  0014 0000          	dc.w	0
  86                     	switch	.const
  87  0004               L41:
  88  0004 00010000      	dc.l	65536
  89  0008               L61:
  90  0008 00002710      	dc.l	10000
  91                     ; 56 void main(void)
  91                     ; 57 {
  92                     	scross	off
  93                     .text:	section	.text,new
  94  0000               _main:
  98                     ; 58   Config();
 100  0000 cd0000        	call	_Config
 102                     ; 59   DELAY_US(1000);
 104  0003 ae03e8        	ldw	x,#1000
 106  0006               L6: 
 107  0006 5a             decw X 
 108  0007 26fd           jrne L6 
 109  0009 9d             nop
 111                     ; 60   DS18B20_init();
 114  000a cd0000        	call	_DS18B20_init
 116                     ; 61   DS18B20_convert();
 118  000d cd0000        	call	_DS18B20_convert
 120                     ; 62   enableInterrupts();	
 123  0010 9a            rim
 125  0011               L12:
 126                     ; 66    if(delay_1s_flag == TRUE)
 128  0011 b600          	ld	a,_delay_1s_flag
 129  0013 a101          	cp	a,#1
 130  0015 2640          	jrne	L52
 131                     ; 68     temperature = DS18B20_read_16();
 133  0017 cd0000        	call	_DS18B20_read_16
 135  001a bf00          	ldw	_temperature,x
 136                     ; 69 	  if(temperature >= 0)
 138  001c 9c            	rvf
 139  001d be00          	ldw	x,_temperature
 140  001f 2f04          	jrslt	L72
 141                     ; 71 	    neg_temp_flag = 0;
 143  0021 3f06          	clr	_neg_temp_flag
 145  0023 2009          	jra	L13
 146  0025               L72:
 147                     ; 75 	    temperature = -(temperature);
 149  0025 be00          	ldw	x,_temperature
 150  0027 50            	negw	x
 151  0028 bf00          	ldw	_temperature,x
 152                     ; 76 	    neg_temp_flag = 1;
 154  002a 35010006      	mov	_neg_temp_flag,#1
 155  002e               L13:
 156                     ; 78 	  temperature >>= 4;
 158  002e a604          	ld	a,#4
 159  0030               L01:
 160  0030 3700          	sra	_temperature
 161  0032 3601          	rrc	_temperature+1
 162  0034 4a            	dec	a
 163  0035 26f9          	jrne	L01
 164                     ; 79     soundspeedkfactorcorrection = soundspeedkfactor * temperature;
 166  0037 be00          	ldw	x,_temperature
 167  0039 90ae025e      	ldw	y,#606
 168  003d cd0000        	call	c_imul
 170  0040 bf12          	ldw	_soundspeedkfactorcorrection,x
 171                     ; 80     soundspeedkfactorcorrection /= 100;  /* convert from km/s to dm/s for compatibility with soundspeed0degC */
 173  0042 be12          	ldw	x,_soundspeedkfactorcorrection
 174  0044 a664          	ld	a,#100
 175  0046 cd0000        	call	c_sdivx
 177  0049 bf12          	ldw	_soundspeedkfactorcorrection,x
 178                     ; 81     soundspeed = soundspeed0degC + soundspeedkfactorcorrection;
 180  004b be12          	ldw	x,_soundspeedkfactorcorrection
 181  004d 1c0cf1        	addw	x,#3313
 182  0050 bf14          	ldw	_soundspeed,x
 183                     ; 82 	  DS18B20_convert();
 185  0052 cd0000        	call	_DS18B20_convert
 187                     ; 83     delay_1s_flag = FALSE;	
 189  0055 3f00          	clr	_delay_1s_flag
 190  0057               L52:
 191                     ; 85    if(delay_100ms_flag == TRUE)
 193  0057 b600          	ld	a,_delay_100ms_flag
 194  0059 a101          	cp	a,#1
 195  005b 2611          	jrne	L33
 196                     ; 87      SONAR_TRIG_ON;
 198  005d 721e500a      	bset	20490,#7
 199                     ; 88      DELAY_US(DELAY_10US);
 201  0061 ae0035        	ldw	x,#53
 203  0064               L21: 
 204  0064 5a             decw X 
 205  0065 26fd           jrne L21 
 206  0067 9d             nop
 208                     ; 89      SONAR_TRIG_OFF;
 211  0068 721f500a      	bres	20490,#7
 212                     ; 90      delay_100ms_flag = FALSE;
 214  006c 3f00          	clr	_delay_100ms_flag
 215  006e               L33:
 216                     ; 92    if(CAPTURE_new_mes)
 218  006e 3d00          	tnz	_CAPTURE_new_mes
 219  0070 279f          	jreq	L12
 220                     ; 94      if(CAPTURE_delta != CAPTURE_INVALID_MES)
 222  0072 ae0000        	ldw	x,#_CAPTURE_delta
 223  0075 cd0000        	call	c_ltor
 225  0078 ae0004        	ldw	x,#L41
 226  007b cd0000        	call	c_lcmp
 228  007e 2791          	jreq	L12
 229                     ; 97        distance = soundspeed * CAPTURE_delta;
 231  0080 be14          	ldw	x,_soundspeed
 232  0082 cd0000        	call	c_uitolx
 234  0085 ae0000        	ldw	x,#_CAPTURE_delta
 235  0088 cd0000        	call	c_lmul
 237  008b ae000e        	ldw	x,#_distance
 238  008e cd0000        	call	c_rtol
 240                     ; 98        distance /= 10000;   /* convert to mm 0-from dm/s to m/s and 000-from us to ms*/
 242  0091 ae000e        	ldw	x,#_distance
 243  0094 cd0000        	call	c_ltor
 245  0097 ae0008        	ldw	x,#L61
 246  009a cd0000        	call	c_ldiv
 248  009d ae000e        	ldw	x,#_distance
 249  00a0 cd0000        	call	c_rtol
 251  00a3 ac110011      	jpf	L12
 366                     	xdef	_main
 367                     	xdef	_soundspeed
 368                     	xdef	_soundspeedkfactorcorrection
 369                     	xdef	_soundspeedkfactor
 370                     	xdef	_soundspeed0degC
 371                     	xdef	_distance
 372                     	xdef	_time
 373                     	xdef	_period
 374                     	xdef	_tim1_cntr
 375                     	xdef	_neg_temp_flag
 376                     	xdef	_tempr
 377                     	xdef	_temperature
 378                     	xref	_DS18B20_read_16
 379                     	xref	_DS18B20_convert
 380                     	xref	_DS18B20_init
 381                     	xref	_Config
 382                     	xref.b	_CAPTURE_delta
 383                     	xref.b	_CAPTURE_new_mes
 384                     	xref.b	_delay_1s_flag
 385                     	xref.b	_delay_100ms_flag
 386                     	xref.b	c_x
 405                     	xref	c_ldiv
 406                     	xref	c_rtol
 407                     	xref	c_lmul
 408                     	xref	c_uitolx
 409                     	xref	c_lcmp
 410                     	xref	c_ltor
 411                     	xref	c_sdivx
 412                     	xref	c_imul
 413                     	end
