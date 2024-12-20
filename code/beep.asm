/****************************************************************/
/*								*/
/*	Beep   							*/
/*	(c) NoFitnessForPurpose					*/
/*								*/
/*								*/
/*		Rev 0.10	20/12/2024			*/
/*								*/
/****************************************************************/
;
#include "osvars.inc"
#include "oseror.inc"
#include "oshead.inc"			
#include "swi.inc"

	.org 000
	.radix 10
;
;
start:
        	OS BZ$ALRM      ; Call the ROM routine that sounds an alarm call.
                         	; This instruction is sometimes referred to as SWI 0D.
		rts            	; Return (to OPL).
;
	.end
