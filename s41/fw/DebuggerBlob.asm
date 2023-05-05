; For all the "unhandled" vectors.
;ErrorTrap:
;	nop
;	nop
;	bra.s	ErrorTrap

; These get called from the binary blob. Do not edit them, or move them
; relative to the binary blobs below.
	jmp	(KosDec).w
	nop
	jmp	(EniDec).w
	nop

; This is the terminal code and graphics, plus the disassembler and the plane
; mappings for the debugger.
	incbin "fw/Part1.bin"

WHITE EQU 0<<13
BLUE  EQU 1<<13
RED   EQU 2<<13
GREEN EQU 3<<13
; Strings are word arrays: length followed by characters. You can change the
; length, but do NOT change the number of characters! The wasted space is the
; price to pay for a binary blob...
; The high byte of each word used for a character is the palette line to use:
fwstr	macro color, str
	dc.w strlen(\2)

.lc = 0
	rept strlen(\2)
.cc		substr .lc+1,.lc+1,\2
		dc.w \color|'\.cc'
.lc =		.lc+1
	endr
	endm

HackerName:	fwstr RED,"NATSUMI    "
EMailmsg:	fwstr BLUE,"SSRG/Retro/IRC private message   "

; Do not move or add padding between the code that follows. The debugger is
; split into these many parts because asm68k sucks.
BusErrorMsg:
	incbin "fw/Part2.bin"

BusError:
	incbin "fw/Part3.bin"

AddressError:
	incbin "fw/Part4.bin"

TraceError:
	incbin "fw/Part5.bin"

SpuriousException:
	incbin "fw/Part6.bin"

ZeroDivideError:
	incbin "fw/Part7.bin"

CHKExceptionError:
	incbin "fw/Part8.bin"

TRAPVError:
	incbin "fw/Part9.bin"

IllegalInstrError:
	incbin "fw/PartA.bin"

PrivilegeViolation:
	incbin "fw/PartB.bin"

LineAEmulation:
	incbin "fw/PartC.bin"

LineFEmulation:
	incbin "fw/PartD.bin"

TrapVector:
	incbin "fw/PartE.bin"

; Edit this to something sensible. One suggestion is the SVN revision.
RevisionNumber:
	dc.w	1
	incbin "fw/PartF.bin"

