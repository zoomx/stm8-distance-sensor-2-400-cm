   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.13 - 06 Dec 2012
   3                     ; Generator (Limited) V4.3.9 - 06 Dec 2012
   4                     ; Optimizer V4.3.8 - 06 Dec 2012
  68                     ; 47 void WWDG_Init(uint8_t Counter, uint8_t WindowValue)
  68                     ; 48 {
  70                     .text:	section	.text,new
  71  0000               _WWDG_Init:
  73  0000 89            	pushw	x
  74       00000000      OFST:	set	0
  77                     ; 50     assert_param(IS_WWDG_WINDOWLIMITVALUE_OK(WindowValue));
  79                     ; 52     WWDG->WR = WWDG_WR_RESET_VALUE;
  81  0001 357f50d2      	mov	20690,#127
  82                     ; 53     WWDG->CR = (uint8_t)((uint8_t)(WWDG_CR_WDGA | WWDG_CR_T6) | (uint8_t)Counter);
  84  0005 9e            	ld	a,xh
  85  0006 aac0          	or	a,#192
  86  0008 c750d1        	ld	20689,a
  87                     ; 54     WWDG->WR = (uint8_t)((uint8_t)(~WWDG_CR_WDGA) & (uint8_t)(WWDG_CR_T6 | WindowValue));
  89  000b 7b02          	ld	a,(OFST+2,sp)
  90  000d a47f          	and	a,#127
  91  000f aa40          	or	a,#64
  92  0011 c750d2        	ld	20690,a
  93                     ; 55 }
  96  0014 85            	popw	x
  97  0015 81            	ret	
 131                     ; 63 void WWDG_SetCounter(uint8_t Counter)
 131                     ; 64 {
 132                     .text:	section	.text,new
 133  0000               _WWDG_SetCounter:
 137                     ; 67     assert_param(IS_WWDG_COUNTERVALUE_OK(Counter));
 139                     ; 71   WWDG->CR = (uint8_t)(Counter & (uint8_t)BIT_MASK);
 141  0000 a47f          	and	a,#127
 142  0002 c750d1        	ld	20689,a
 143                     ; 73 }
 146  0005 81            	ret	
 169                     ; 82 uint8_t WWDG_GetCounter(void)
 169                     ; 83 {
 170                     .text:	section	.text,new
 171  0000               _WWDG_GetCounter:
 175                     ; 84     return(WWDG->CR);
 177  0000 c650d1        	ld	a,20689
 180  0003 81            	ret	
 203                     ; 92 void WWDG_SWReset(void)
 203                     ; 93 {
 204                     .text:	section	.text,new
 205  0000               _WWDG_SWReset:
 209                     ; 94     WWDG->CR = WWDG_CR_WDGA; /* Activate WWDG, with clearing T6 */
 211  0000 358050d1      	mov	20689,#128
 212                     ; 95 }
 215  0004 81            	ret	
 250                     ; 104 void WWDG_SetWindowValue(uint8_t WindowValue)
 250                     ; 105 {
 251                     .text:	section	.text,new
 252  0000               _WWDG_SetWindowValue:
 256                     ; 107     assert_param(IS_WWDG_WINDOWLIMITVALUE_OK(WindowValue));
 258                     ; 109     WWDG->WR = (uint8_t)((uint8_t)(~WWDG_CR_WDGA) & (uint8_t)(WWDG_CR_T6 | WindowValue));
 260  0000 a47f          	and	a,#127
 261  0002 aa40          	or	a,#64
 262  0004 c750d2        	ld	20690,a
 263                     ; 110 }
 266  0007 81            	ret	
 279                     	xdef	_WWDG_SetWindowValue
 280                     	xdef	_WWDG_SWReset
 281                     	xdef	_WWDG_GetCounter
 282                     	xdef	_WWDG_SetCounter
 283                     	xdef	_WWDG_Init
 302                     	end
