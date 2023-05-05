
; =========================================================================
; SMPS Music Previewer
; =========================================================================

	include	'swa.macro.asm'
	include 'vars.asm'

; =========================================================================

	; M68K Vector Table
Vectors:
	dc.l	$FFFE00,	EntryPoint,	Vector02,	Vector03
	dc.l	Vector04,	Vector05,	Vector06,	Vector07
	dc.l	Vector08,	Vector09,	Vector0A,	Vector0B
	dc.l	Vector0C,	Vector0D,	Vector0E,	Vector0F
	dc.l	Vector10,	Vector11,	Vector12,	Vector13
	dc.l	Vector14,	Vector15,	Vector16,	Vector17
	dc.l	Vector18,	Vector19,	Vector1A,	Vector1B
	dc.l	HBlank,		Vector1D,	VBlank,		Vector1F
	dc.l	Vector20,	Vector21,	Vector22,	Vector23
	dc.l	Vector24,	Vector25,	Vector26,	Vector27
	dc.l	Vector28,	Vector29,	Vector2A,	Vector2B
	dc.l	Vector2C,	Vector2D,	Vector2E,	Vector2F
	dc.l	Vector30,	Vector31,	Vector32,	Vector33
	dc.l	Vector34,	Vector35,	Vector36,	Vector37
	dc.l	Vector38,	Vector39,	Vector3A,	Vector3B
	dc.l	Vector3C,	Vector3D,	Vector3E,	Vector3F

	; ROM Header
	dc.b 'SEGA MEGA DRIVE '
	dc.b '(C)VLAD 2013.JAN'
	dc.b 'SWA SMPS MUSIC PREVIEWER                        '
	dc.b 'SWA SMPS MUSIC PREVIEWER                        '
	dc.b '              '
	dc.w $0000		; Chexsum
	dc.b 'J               '
	dc.l $000000,$3FFFFF	; ROM Range
	dc.l $FF0000,$FFFFFF	; RAM Range
	dc.b '    '		; SRAM Storage
	dc.b '    '		;
	dc.b '    '		;
	dc.b '                                                    '
	dc.b 'JUE             '
	

; =========================================================================
; Stantard hardware initalization routine
; =========================================================================

EntryPoint:
		tst.l	($A10008).l	; test port A control
		bne.s	PortA_Ok
		tst.w	($A1000C).l	; test port C control

PortA_Ok	bne.s	PortC_Ok
		lea	SetupValues(pc),a5
		movem.w	(a5)+,d5-d7
		movem.l	(a5)+,a0-a4
		move.b	-$10FF(a1),d0	; get hardware version
		andi.b	#$F,d0
		beq.s	SkipSecurity
		move.l	#'SEGA',$2F00(a1)

SkipSecurity	move.w	(a4),d0		; check	if VDP works
		moveq	#0,d0
		movea.l	d0,a6
		move.l	a6,usp		; set usp to $0
		moveq	#$17,d1

VDPInitLoop	move.b	(a5)+,d5	; add $8000 to value
		move.w	d5,(a4)		; move value to	VDP register
		add.w	d7,d5		; next register
		dbf	d1,VDPInitLoop
		move.l	(a5)+,(a4)
		move.w	d0,(a3)		; clear	the screen
		move.w	d7,(a1)		; stop the Z80
		move.w	d7,(a2)		; reset	the Z80

WaitForZ80	btst	d0,(a1)		; has the Z80 stopped?
		bne.s	WaitForZ80	; if not, branch
		moveq	#$25,d2

Z80InitLoop	move.b	(a5)+,(a0)+
		dbf	d2,Z80InitLoop
		move.w	d0,(a2)
		move.w	d0,(a1)		; start	the Z80
		move.w	d7,(a2)		; reset	the Z80

ClrRAMLoop	move.l	d0,-(a6)
		dbf	d6,ClrRAMLoop	; clear	the entire RAM
		move.l	(a5)+,(a4)	; set VDP display mode and increment
		move.l	(a5)+,(a4)	; set VDP to CRAM write
		moveq	#$1F,d3

ClrCRAMLoop	move.l	d0,(a3)
		dbf	d3,ClrCRAMLoop	; clear	the CRAM
		move.l	(a5)+,(a4)
		moveq	#$13,d4

ClrVDPStuff	move.l	d0,(a3)
		dbf	d4,ClrVDPStuff
		moveq	#3,d5

PSGInitLoop	move.b	(a5)+,$11(a3)	; reset	the PSG
		dbf	d5,PSGInitLoop
		move.w	d0,(a2)
		movem.l	(a6),d0-a6	; clear	all registers
		move	#$2700,sr	; set the sr

PortC_Ok	bra.s	ProgramStart
; ===========================================================================
SetupValues:	dc.w $8000
		dc.w $3FFF
		dc.w $100

		dc.l $A00000		; start	of Z80 RAM
		dc.l $A11100		; Z80 bus request
		dc.l $A11200		; Z80 reset
		dc.l $C00000
		dc.l $C00004		; address for VDP registers

		dc.b 4,	$14, $30, $3C	; values for VDP registers
		dc.b 7,	$6C, 0,	0
		dc.b 0,	0, $FF,	0
		dc.b $81, $37, 0, 1
		dc.b 1,	0, 0, $FF
		dc.b $FF, 0, 0,	$80

		dc.l $40000080

		dc.b $AF, 1, $D9, $1F, $11, $27, 0, $21, $26, 0, $F9, $77 ; Z80	instructions
		dc.b $ED, $B0, $DD, $E1, $FD, $E1, $ED,	$47, $ED, $4F
		dc.b $D1, $E1, $F1, 8, $D9, $C1, $D1, $E1, $F1,	$F9, $F3
		dc.b $ED, $56, $36, $E9, $E9

		dc.w $8104		; value	for VDP	display	mode
		dc.w $8F02		; value	for VDP	increment
		dc.l $C0000000		; value	for CRAM write mode
		dc.l $40000010

		dc.b $9F, $BF, $DF, $FF	; values for PSG channel volumes
; =========================================================================
ProgramStart:
		jmp	Player

; =========================================================================
VSync		st.b	VBlank_Wait
		move	#$2500,sr
	@0:	tst.b	VBlank_Wait
		bne.s	@0
		rts

; =========================================================================
HBlank		rte
VBlank		movem.l	d0-d1/a0-a1,-(sp)
		sf.b	VBlank_Wait

	        ; Read joys
		lea	Joypad,a0
		lea	$A10003,a1
		move.b	#0,(a1)
		nop
		nop
		move.b	(a1),d0
		lsl.b	#2,d0
		andi.b	#$C0,d0
		move.b	#$40,(a1)
		nop
		nop
		move.b	(a1),d1
		andi.b	#$3F,d1
		or.b	d1,d0
		not.b	d0
		move.b	(a0),d1
		eor.b	d0,d1
		move.b	d0,(a0)+
		and.b	d0,d1
		move.b	d1,(a0)+

		movem.l	(sp)+,d0-d1/a0-a1
		rte

; =========================================================================
; ---------------------------------------------------------------------------
; Subroutine to	play a sound or	music track
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PlaySound:
		move.b	d0,($FFFFF00A).w
		rts
; End of function PlaySound

; ---------------------------------------------------------------------------
; Subroutine to	play a special sound/music (E0-E4)
;
; E0 - Fade out
; E1 - Sega
; E2 - Speed up
; E3 - Normal speed
; E4 - Stop
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PlaySound_Special:
		move.b	d0,($FFFFF00B).w
		rts	
; End of function PlaySound_Special

; -------------------------------------------------------------------------
; Subroutine to	load the sound driver
; -------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||


SoundDriverLoad:			; XREF: GameClrRAM; TitleScreen
		nop
		move.w	#$100,d0
		move.w	d0,($A11100).l
		move.w	d0,($A11200).l
		lea	(MegaPCM).l,a0
		lea	($A00000).l,a1
		move.w	#(MegaPCM_End-MegaPCM)-1,d1

	@Load:	move.b	(a0)+,(a1)+
		dbf	d1,@Load
		moveq	#0,d1
		move.w	d1,($A11200).l
		nop
		nop
		nop
		nop
		move.w	d0,($A11200).l
		move.w	d1,($A11100).l
		rts

; =========================================================================

		include	'swa.error.asm'
		include	'swa.megapcm.asm'
		include 'swa.smps.asm'  
		include	'player.asm'
		

Music81:
		even
