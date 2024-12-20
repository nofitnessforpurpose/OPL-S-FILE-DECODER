# OPL S-File Decoder
OPL <a href="https://en.wikipedia.org/wiki/SREC_(file_format)">Motorola S File</a> To Machine Code Convertor

This <a href="https://en.wikipedia.org/wiki/Psion_Organiser">Psion Orgnaiser II</a> <a href="https://en.wikipedia.org/wiki/Open_Programming_Language">OPL progam</a> converts the XA.EXE Motorola S-File 6303 Cross Assembler ouptut .HEX files and converts them to machine code.

<div align="center">
  <div style="display: flex; align-items: flex-start;">
  <img src="https://github.com/nofitnessforpurpose/OPL-S-FILE-DECODER/blob/main/images/ReadSFile.png?raw=true" width="400px" alt="NotFitForPurpose Contraption 01. Image copyright (c) 20 December 2024 nofitnessforpurpose All Rights Reserved">
  </div>
</div>
<BR>

[![Organiser](https://img.shields.io/badge/gadget-Organiser_II-blueviolet.svg?%3D&style=flat-square)](https://en.wikipedia.org/wiki/Psion_Organiser)
[![GitHub License](https://img.shields.io/github/license/nofitnessforpurpose/OPL-S-FILE-DECODER?style=flat-square)](https://github.com/nofitnessforpurpose/TopSlotCase/blob/main/LICENSE)
[![Maintenance](https://img.shields.io/badge/maintained%3F-yes-green.svg?style=flat-square)](https://github.com/nofitnessforpurpose/TopSlotCase/graphs/commit-activity)
![GitHub repo size](https://img.shields.io/github/repo-size/nofitnessforpurpose/OPL-S-FILE-DECODER?style=flat-square)

<br>  

## Use Case
Presented in this repository is RDSFILE$ which takes XA.EXE assembler output HEX files, or other Motorola S File format Hex files, and processes them into the necessary binay 
representation in a string ready for use within OPL. Thus maintaining the link with the source .ASM file. It is only necessary to add the .HEX file to the distribution and provide 
the routine with the name of the .HEX file to the routine (see note on file names below):

The example below shows a typical usage scenario. 

```BASIC
RDSFILE:
REM Wrapper to read a Motorola S File

LOCAL b$(255) : REM Will hold machine code

b$ = RDSFILE$:("A:HEXFNAME")
USR(ADDR(b$) + 1, 0)
```

The routine RDSFILE$ (Read-S-File) processes the Motorola S file and returns to the calling routine a machine code string.

The following trivial beep example is processed by the Cross Assembler XA.EXE to create beep.hex, using the command:

```
XA.EXE -o beep beemp.asm
```

The (trivial) source assembly file beep.asm is shown below:

```
; beep.asm
; Converted from https://www.jaapsch.net/psion/mctutor1.htm
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
          rts             ; Return (to OPL).  
;  
	.end  
```

Which produces the following SREC Hex file beep.hex which has been copied to the Organiser II devices A: drive as beephex:

beephex

```
S00600004844521B  
S10600003F0D3974  
S9030000FC  
```

<BR>
The following will read the 'beephex' file and decode 3 code bytes, to cause the device to sound the internal alarm:

```BASIC
RDSFILE:
REM Wrapper to read a Motorola S File

LOCAL b$(255) : REM Will hold machine code

b$ = RDSFILE$:("A:beephex")
USR(ADDR(b$) + 1, 0)
```

<BR>

## Discussion  
It will be seen that there exists overhead within the Hex file in the example case, that is not insignificant. As a result this process is less suited to small code footprints.  
However, once the code becomes reasonably complex the overhead is less problematic and typically no more than CONV$: and associated programatic storage impose without the added benefits.

The generic <a href="https://www.jaapsch.net/psion/mctutor1.htm">CONV$:()</a> routine frequently used to hold hexadecimal values of machine code programs typically requires transcription, often manual, from assembler output or hand coding.
This process is frequently error prone, especially in the case of manual transcription and breaks the link with assembly source code.

Use of the Assembler PAK, which captures TRAP events, requires on device use which makes code maintence more challenging than using the Cross Assembler XA.EXE.

The RDSFILE$ uility performs checksum calculation and aborts if the source Hex file is detected to be degraded.

OPL code does not have to be re-translated if assembler code is updated and additional source verification could readily be added to the S0 record.
<BR>

## Limitations  
- Only Motorola S-19 16 bit (2 byte) format files are decoded  
- Assembler output must define all memory space bytes and be in contigous memory order  
  (no gaps, all memory bytes explicitly defined)

<BR>

## Considerations
The convertor code does not attempt to detect if code contained in the Hexadecimal .ASM file is valid.  
Invalid code raising a TRAP may result in data loss or degredation to hardware.  
The Organiser 2 file system does not permit file extentions. File names are 8 characters long, starting with the letter A through Z.
See Notes below.  

<BR>

## Questions / Discussion
See <a target="_blank" rel="noopener noreferrer" href="https://www.organiser2.com/"> Organiser 2 Hardware </a> forum, though see note below first.


<BR>

## Please note:  
All information is For Indication only.
No association, affiliation, recommendation, suitability, fitness for purpose should be assumed or is implied.
Registered trademarks are owned by their respective registrants.
