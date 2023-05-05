		cpu 68000
		include "sonic3k.macrosetup.asm"	; include a few basic macros
		include "sonic3k.constants.asm"		; include a few basic macros
		include "sonic3k.macros.asm"		; include some simplifying macros and functions
; ---------------------------------------------------------------------------
; Assembly options:

; 'Sonic3_Complete' is set via build scripts to 0 or 1.
; If 1, includes all required Sonic 3 data in order to assemble a smaller version of S3K (with all redundancies removed)

strip_padding = 0|Sonic3_Complete
; If 1, strips all unnecessary padding

Size_of_Snd_driver_guess = $E1C
Size_of_Snd_driver2_guess = $68C
; Approximate size of compressed sound driver. Change when appropriate

Size_of_Snd_Bank1 = $3EFC
; This particular bank has its contents aligned to the end

; Magic value for SRAM location and size
SRAM =		$200000
SRAMsz =	$400
SRAMreg =	$A130F1

SoundID	=	Mus_MiniDEZ2

extra_flags =	1		; extra SMPS flags enable
; ---------------------------------------------------------------------------

StartOfROM:
	if * <> 0
		fatal "StartOfROM was $\{*} but it should be 0"
	endif

Vectors:	dc.l	$FFFF0080,	EntryPoint,	ErrorTrap,	ErrorTrap	; 0
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 4
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 8
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 12
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 16
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 20
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 24
		dc.l	ErrorTrap,	ErrorTrap,	V_Int,		ErrorTrap	; 28
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 32
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 36
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 40
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 44
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 48
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 52
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 56
		dc.l	ErrorTrap,	ErrorTrap,	ErrorTrap,	ErrorTrap	; 60
Header:		dc.b "SEGA GENESIS    "
Copyright:	dc.b "(C)SEGA 1994.JUN"
Domestic_Name:	dc.b "SONIC 3 & KNUCKLES BATTLE RACE - SOUND TEST ROM "
Overseas_Name:	dc.b "SONIC 3 & KNUCKLES BATTLE RACE - SOUND TEST ROM "
Serial_Number:	dc.b "GM MK-1563 -00"
Checksum:	dc.w $DFB3
Input:		dc.b "J               "
ROMStartLoc:	dc.l StartOfROM
ROMEndLoc:	dc.l EndOfROM-1
RAMStartLoc:	dc.l (RAM_start&$FFFFFF)
RAMEndLoc:	dc.l (RAM_start&$FFFFFF)+$FFFF
CartRAM_Info:	dc.w 0
CartRAM_Type:	dc.b %11100000, %00100000
CartRAMStartLoc:dc.l SRAM
CartRAMEndLoc:	dc.l SRAM+SRAMsz-1
Modem_Info:	dc.b "  "
		dc.b "          "
Unknown_Header:	dc.w	0
		dc.b  "      "
		dc.w  0,  0
		dc.l  EndOfROM-1 ; 0	;CHECKLATER (ROM Bank Info)
		dc.b  "        "
KiS2ROM_Info:	dc.b  "RO"
KiS2ROM_Type:	dc.w %10000000100000
KiS2ROMStartLoc:	tribyte $300000
KiS2ROMEndLoc:		tribyte $33FFFF
KiS2ROMStartLoc2:	tribyte $300000
KiS2ROMEndLoc2:		tribyte $33FFFF
Country_Code:	dc.b "JUE             "
; ---------------------------------------------------------------------------
Init:
MemZ80	dc.l Z80_RAM
ReqZ80	dc.l Z80_bus_request
ResZ80	dc.l Z80_reset
DataVDP	dc.l VDP_data_port, VDP_control_port
	dc.w $8000,bytesToLcnt($10000),$100

VDPInitValues:	; values for VDP registers
	dc.b 4		; Command $8004 - HInt off, Enable HV counter read
	dc.b $14	; Command $8114 - Display off, VInt off, DMA on, PAL off
	dc.b $30	; Command $8230 - Scroll A Address $C000
	dc.b $3C	; Command $833C - Window Address $F000
	dc.b 7		; Command $8407 - Scroll B Address $E000
	dc.b $6C	; Command $856C - Sprite Table Addres $D800
	dc.b 0		; Command $8600 - Null
	dc.b 0		; Command $8700 - Background color Pal 0 Color 0
	dc.b 0		; Command $8800 - Null
	dc.b 0		; Command $8900 - Null
	dc.b $FF	; Command $8AFF - Hint timing $FF scanlines
	dc.b 0		; Command $8B00 - Ext Int off, VScroll full, HScroll full
	dc.b $81	; Command $8C81 - 40 cell mode, shadow/highlight off, no interlace
	dc.b $37	; Command $8D37 - HScroll Table Address $DC00
	dc.b 0		; Command $8E00 - Null
	dc.b 1		; Command $8F01 - VDP auto increment 1 byte
	dc.b 1		; Command $9001 - 64x32 cell scroll size
	dc.b 0		; Command $9100 - Window H left side, Base Point 0
	dc.b 0		; Command $9200 - Window V upside, Base Point 0
	dc.b $FF	; Command $93FF - DMA Length Counter $FFFF
	dc.b $FF	; Command $94FF - See above
	dc.b 0		; Command $9500 - DMA Source Address $0
	dc.b 0		; Command $9600 - See above
	dc.b $80	; Command $9700	- See above + VRAM fill mode
VDPInitValues_End:

	dc.l vdpComm($0000,VRAM,DMA)	 ; value for VRAM write mode

Z80StartupCodeBegin:
	dc.w $AF01,$D91F,$1127,$0021,$2600,$F977,$EDB0,$DDE1,$FDE1,$ED47,$ED4F,$D1E1,$F108,$D9C1,$D1E1,$F1F9,$F3ED,$5636,$E9E9
Z80StartupCodeEnd:

	dc.w $8164			; value for VDP display mode
	dc.w $8F02			; value for VDP increment
	dc.l vdpComm($0000,CRAM,WRITE)	; value for CRAM write mode
	dc.l $00000AAA			; CRAM colour
	dc.l vdpComm($0000,VSRAM,WRITE)	; value for VSRAM write mode

	dc.b $9F,$BF,$DF,$FF	; values for PSG channel volumes
; ---------------------------------------------------------------------------

EntryPoint:
		lea	Init(pc),a5		; get init data
		movem.l	(a5)+,a0-a4		; load registers
		movem.w	(a5)+,d5-d7

		move.b	HW_Version-Z80_bus_request(a1),d0; get hardware version
		andi.b	#$F,d0
		beq.s	SkipSecurity 		; branch if hardware has no TMSS
		move.l	Header.w,Security_addr-Z80_bus_request(a1); satisfy the TMSS

SkipSecurity:
		move.w	(a4),d0			; reset VDP latch
		moveq	#0,d0
		movea.l	d0,a6
		move.l	a6,usp			; set usp to $0

		moveq	#VDPInitValues_End-VDPInitValues-1,d1

Init_VDPRegs:
		move.b	(a5)+,d5
		move.w	d5,(a4)
		add.w	d7,d5
		dbf	d1,Init_VDPRegs		; set all 24 registers

		move.l	(a5)+,(a4)		; set VRAM write mode
		move.w	d0,(a3)			; clear the screen
		move.w	d7,(a1)			; stop the Z80
		move.w	d7,(a2)			; reset the Z80

WaitForZ80:
		btst	d0,(a1)			; has the Z80 stopped?
		bne.s	WaitForZ80		; if not, branch
		moveq	#Z80StartupCodeEnd-Z80StartupCodeBegin-1,d2

Init_SoundRAM:
		move.b	(a5)+,(a0)+
		dbf	d2,Init_SoundRAM

		move.w	d0,(a2)
		move.w	d0,(a1)			; start the Z80
		move.w	d7,(a2)			; reset the Z80

Init_ClearRAM:
		move.l	d0,-(a6)		; Clear normal RAM
		dbf	d6,Init_ClearRAM

		move.l	(a5)+,(a4)		; set VDP display mode and increment
		move.l	(a5)+,(a4)		; set VDP to CRAM write
		moveq	#bytesToLcnt($80)-1,d3
		move.l	(a5)+,(a3)		; write first colour

Init_ClearCRAM:
		move.l	d0,(a3)			; Clear CRAM
		dbf	d3,Init_ClearCRAM
		move.l	(a5)+,(a4)
		moveq	#bytesToLcnt($50),d4

Init_ClearVSRAM:
		move.l	d0,(a3)			; Clear VSRAM
		dbf	d4,Init_ClearVSRAM
		moveq	#4-1,d5

Init_InputPSG:
		move.b	(a5)+,PSG_input-VDP_data_port(a3); reset the PSG
		dbf	d5,Init_InputPSG
		move.w	d0,(a2)
		move	#$2700,sr		; set the sr

		move.w	d7,(Z80_bus_request).l
		move.w	d7,(Z80_reset).l	; release Z80 reset
		lea	(z80_SoundDriver).l,a0
		lea	(Z80_RAM).l,a1
		bsr.w	Kos_Decomp
		lea	(Z80_Snd_Driver2).l,a0
		lea	(Z80_RAM+$1300).l,a1
		bsr.w	Kos_Decomp

		move.l	ResZ80.w,a2
		move.l	MemZ80.w,a3		; get Z80 RAM to a3
		lea	Z80_Blank_Dat(pc),a0
		lea	zDataStart(a3),a1
		moveq	#$F,d0

-		move.b	(a0)+,(a1)+
		dbf	d0,-
		btst	#6,HW_Version
		beq.s	+
		move.b	#1,zPalFlag(a3)		; set PAL mode flag
+
		move.w	#0,(a2)			; reset Z80
		moveq	#$40,d0
		move.b	d0,HW_Port_1_Control-Z80_reset(a2)
		move.b	d0,HW_Port_2_Control-Z80_reset(a2)
		move.b	d0,HW_Expansion_Control-Z80_reset(a2)
		move.w	#$100,(a2)		; release reset
	startZ80

		move.l	DataVDP.w,a1		; load VDP data to a1
		move.l	(a0)+,4(a1)		; set mode
		move.w	(a0)+,d0		; load loop count

.text		move.l	(a0)+,(a1)		; save 1 long
		dbf	d0,.text		; loop for all text

		stop	#$2300			; sync
		moveq	#-1,d7			; reset frame count
		move.l	#vdpComm($C104,VRAM,WRITE),d6; prepare command

_play	stopZ80
		move.b	#SoundID,zMusicNumber(a3)	; play sound
	startZ80

_poll	stopZ80
		tst.b	(a3)			; check if music is playing
		beq.s	.nop			; if not, branch
		move.b	zTicksCount+1(a3),d7	; load hi value
		lsl.w	#8,d7
		move.b	zTicksCount(a3),d7	; load lo value
		bra.s	.cont

.nop		move.b	SYNC(a3),d5		; load SYNC
.cont	startZ80

		move.l	d6,4(a1)		; set VDP VRAM WRITE mode
		moveq	#4-1,d0
		move.w	d7,d3

.loop2		move.b	d3,d2			; get next nibble
		andi.w	#%1111,d2		; keep the nibble only
		addq.b	#1,d2			; increment 1 (to skip null)
		move.w	d2,-(sp)		; then store the number on plane
		ror.w	#4,d3			; rotate right four times, to get the next nibble.
						; Also returns d3 to original value
		dbf	d0,.loop2		; loop until full number is done

		moveq	#4-1,d0
.write2		move.w	(sp)+,(a1)		; copy number to VRAM
		dbf	d0,.write2		; write for so many bytes as we need

		move.l	d0,(a1)			; clear 2 tiles
		moveq	#2-1,d0
		move.w	d5,d3

.loop1		move.b	d3,d2			; get next nibble
		andi.w	#%1111,d2		; keep the nibble only
		addq.b	#1,d2			; increment 1 (to skip null)
		move.w	d2,-(sp)		; then store the number on plane
		ror.w	#4,d3			; rotate right four times, to get the next nibble.
						; Also returns d3 to original value
		dbf	d0,.loop1		; loop until full number is done

		moveq	#2-1,d0
.write		move.w	(sp)+,(a1)		; copy number to VRAM
		dbf	d0,.write		; write for so many bytes as we need

		lea	(HW_Port_1_Data).l,a2
		lea	-1.w,a0
		move.b	#0,(a2)			; Poll controller data port
		nop
		nop
		move.b	(a2),d0			; Get controller port data (start/A)
		lsl.b	#2,d0
		andi.b	#$C0,d0
		move.b	#$40,(a2)		; Poll controller data port again
		nop
		nop
		move.b	(a2),d1			; Get controller port data (B/C/Dpad)
		andi.b	#$3F,d1
		or.b	d1,d0			; Fuse together into one controller bit array
		not.b	d0
		move.b	(a0),d1			; Get press button data
		eor.b	d0,d1			; Toggle off buttons that are being held
		move.b	d0,(a0)			; Put raw controller input (for held buttons) in F604/F606
		and.b	d0,d1
		bmi.w	_play			; if negative, play sound

		stop	#$2300			; sync
		bra.w	_poll
; ---------------------------------------------------------------------------

ErrorTrap:
	bra.s	*

V_Int:	stopZ80
		move.b	#-1,(Z80_RAM+PCM_Status).l
	startZ80
		rte

Z80_Blank_Dat:	dc.b  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	dc.l vdpComm($0020,VRAM,WRITE)	 ; value for VRAM write mode
	dc.w (8*16)-1
	dc.l $00000000, $00000000, $00111100, $01100110, $11101110, $11110110, $11001100, $01111000 ; 0
	dc.l $00000000, $00000000, $00011100, $00101100, $00001100, $00011000, $00011000, $01111100 ; 1
	dc.l $00000000, $00000000, $00111000, $01001100, $00001100, $00011000, $00110000, $01111100 ; 2
	dc.l $00000000, $00000000, $01111100, $00001100, $00011000, $00001100, $01001100, $01111000 ; 3
	dc.l $00000000, $00000000, $00011100, $00101100, $01001000, $11111110, $00011000, $00111000 ; 4
	dc.l $00000000, $00000000, $00111100, $00100000, $00111100, $00000110, $01001110, $00111100 ; 5
	dc.l $00000000, $00000000, $00011100, $00110000, $01111000, $11001100, $11001100, $11111000 ; 6
	dc.l $00000000, $00000000, $01111100, $01001100, $00011000, $00110000, $01100000, $11100000 ; 7
	dc.l $00000000, $00000000, $00111100, $01100110, $00111100, $01111000, $11001100, $01111000 ; 8
	dc.l $00000000, $00000000, $00111100, $01100110, $01100110, $00111100, $00001100, $01111000 ; 9
	dc.l $00000000, $00000000, $00001110, $00010110, $00100110, $00111110, $01100110, $11000110 ; A
	dc.l $00000000, $00000000, $00111100, $00100110, $01111100, $01111000, $11001100, $11111000 ; B
	dc.l $00000000, $00000000, $00111100, $01100110, $01100000, $11000000, $11001100, $11111000 ; C
	dc.l $00000000, $00000000, $00111100, $00110110, $01100110, $01100110, $11001100, $11111000 ; D
	dc.l $00000000, $00000000, $00111110, $00110000, $01100000, $01111000, $11000000, $11111100 ; E
	dc.l $00000000, $00000000, $00111110, $01110000, $01100000, $01111100, $11100000, $11100000 ; F

	include "Sound/Test/Kos.asm"
	include "Sound/Z80 Sound Driver.asm"
EndOfROM:
