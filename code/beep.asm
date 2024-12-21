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
; Standard includes bundled with PSION ORGANISER II CROSS ASSEMBLER
;
#include "osvars.inc"		; Contains the MKII operating system variables.
#include "oseror.inc"		; Contains all the operating system errors.
#include "oshead.inc"		; Contains constants and macros for the MKII operating system.
#include "swi.inc"		; Contains the MK2 SWI's. (Software Interrupt Vectors)

; Default config options
;
	.org 000		; Sets address assembly will start (or continue)
	.radix 10		; Sets the default base used by the assembler
;
; Code start
;
start:
        	OS BZ$ALRM      ; Call the ROM routine that sounds an alarm call.
                         	; This instruction is sometimes referred to as SWI 0D.
		rts            	; Return (to OPL).
;
	.end
