errortrap:
EntryPoint:
	if debug=1
		sf	Level_Lag_Crash.w
	endif
		tst.l	HW_Port_1_Control-1
		bne.s	.0
		tst.w	HW_Expansion_Control-1

.0	;	bne.w	Test_LockOn

EntryPoint2:
		move	#$2700,sr
		lea	VDPSetupValues(pc),a5
		movem.w	(a5)+,d5-d7
		movem.l	(a5)+,a0-a4

		move.b	-$10FF(a1),d0
		andi.b	#$F,d0
		beq.s	.noTMSS
		move.l	Header.w,$2F00(a1)

.noTMSS		tst.w	(a4)
		moveq	#0,d0
		movea.l	d0,a6
		move.l	a6,usp

		moveq	#VDPinitRegs_End-VDPinitRegs-1,d1
.setVDPregs	move.b	(a5)+,d5
		move.w	d5,(a4)
		add.w	d7,d5
		dbf	d1,.setVDPregs

		move.l	(a5)+,(a4)
		move.w	d0,(a3)
		move.w	d7,(a1)
		move.w	d7,(a2)
.waitZ80	btst	d0,(a1)
		bne.s	.waitZ80

		moveq	#Z80initCode_End-Z80initCode-1,d2
.loadZ80ROM	move.b	(a5)+,(a0)+
		dbf	d2,.loadZ80ROM

		move.w	d0,(a2)
		move.w	d0,(a1)
		move.w	d7,(a2)
.clearRAM	clr.l	-(a6)
		dbf	d6,.clearRAM

		move.w	(a5),VDP_Reg1_Val.w
		move.l	(a5)+,(a4)
		move.l	(a5)+,(a4)
		moveq	#($80/4)-1,d3
.clearCRAM	move.l	d0,(a3)
		dbf	d3,.clearCRAM

		move.l	(a5)+,(a4)
		moveq	#($50/4)-1,d4
.clearVSRAM	move.l	d0,(a3)
		dbf	d4,.clearVSRAM

		moveq	#4-1,d5
.setPSG		move.b	(a5)+,$11(a3)
		dbf	d5,.setPSG

		move.w	d0,(a2)
		movem.l	(a6),d0-a6
.skipReset	bra.s	Test_LockOn

; ===========================================================================
VDPSetupValues:
		dc.w	$8000, ($10000/4)-1, $100
		dc.l	Z80_RAM, Z80_bus_request, Z80_reset
		dc.l	VDP_data_port, VDP_control_port

VDPinitRegs:	; values for VDP registers
		dc.b 4		; HInt off, Enable HV counter read
		dc.b $34	; V-int enabled, display blanked, DMA enabled, 224 line display
		dc.b $30	; Scroll A Address $C000
		dc.b $20	; Window Address $8000
		dc.b 7		; Scroll B Address $C000
		dc.b $7C	; Sprite Table Addres $F800
		dc.b 0		; Null
		dc.b $20	; Background color Pal 3 Color 0
		dc.b 0		; Null
		dc.b 0		; Null
		dc.b $FF	; Hint timing $FF scanlines
		dc.b 0		; Full-screen horizontal and vertical scrolling
		dc.b $81	; 40 cell mode, shadow/highlight off, no interlace
		dc.b $3C	; HScroll Table Address $F000
		dc.b 0		; Null
		dc.b 2		; VDP auto increment 2 bytes
		dc.b 1		; 64x32 cell scroll size
		dc.b 0		; Window H right side, Base Point 0
		dc.b 0		; Window V upside, Base Point 0
		dc.b $FF	; DMA Length Counter $FFFF
		dc.b $FF	; See above
		dc.b 0		; DMA Source Address $0
		dc.b 0		; See above
		dc.b $80	; Command $9700	- See above + VRAM fill mode
VDPinitRegs_End:

	vdpcomm	dc.l,$0000,VRAM,DMA	; value for VRAM write mode

		; Z80 instructions (not the sound driver; that gets loaded later)
Z80initCode:
		dc.b $AF,   1, $D9, $1F, $11, $27,   0, $21
		dc.b $26,   0, $F9, $77, $ED, $B0, $DD, $E1
		dc.b $FD, $E1, $ED, $47, $ED, $4F, $D1, $E1
		dc.b $F1,   8, $D9, $C1, $D1, $E1, $F1, $F9
		dc.b $F3, $ED, $56, $36, $E9, $E9
Z80initCode_End:

		dc.w $8134		; value for VDP display mode
		dc.w $8F02		; value for VDP increment
	vdpComm	dc.l,$0000,CRAM,WRITE	; value for CRAM write mode
	vdpComm	dc.l,$0000,VSRAM,WRITE	; value for VSRAM write mode

		dc.b $9F,$BF,$DF,$FF	; values for PSG channel volumes
; ---------------------------------------------------------------------------

Test_LockOn:
		move	#$2700,sr
		tst.w	(a4)

		btst	#6,($A1000D).l
		move.w	#$4EF9,VInt_Jmp_Code.w
		move.l	#VInt,VInt_Addr.w
		move.w	#$4EF9,HInt_Jmp_Code.w
		move.l	#HInt,HInt_Addr.w
		move.b	HW_Version,d6
		andi.b	#$C0,d6
		move.b	d6,Graphics_Flags.w	; get hardware version (NTSC/PAL and JP/no JP bits)

		move.w	#$8AFF,Hint_Counter_Reserve.w
	if debug=1
		move.w	#$9101,WindowPlaneReg.w		; enable window plane
	else
		move.w	#$9100,WindowPlaneReg.w		; disable window plane
	endif
		lea	System_Stack.w,sp
		clr.l	VScroll_Factor_FG.w
		clr.l	HScroll_Factor_FG.w
		bsr.w	SndDrvInit
		bsr.w	ControllerInit

		move.b	#$C,GameMode.w
		clr.w	Ring_Count.w
		move.w	#0,Player_Mode.w
		move.l	Header.w,RNG_Seed.w	; reset RNG seed

	if debug=1
		st	Debug_Mode_Flag.w
		st	Slow_Motion_Flag.w
	endif

		Jsr	ClearDisplay(pc)
		addq.b	#2,VInt_Routine.w
		jsr	Wait_VSync.w
		lea	vdp_control_port.l,a6
		lea	-4(a6),a4

		move.l	#$C0000000,(a6)		; CRAM write 0
		move.l	#$666,(a4)		; write the palette
		move.w	#$EEE,(a4)		; write the palette

		; generate mappings
		moveq	#1,d0
		moveq	#28-1,d1
		move.l	#$800000,d2
	vdpComm	move.l,$C000,VRAM,WRITE,d3

.maploop	move.l	d3,(a6)
	rept	40
		move.w	d0,(a4)			; set data to VDP
		addq.w	#1,d0			; add 1 to it
	endr
		add.l	d2,d3
		dbf	d1,.maploop		; loop through all the pieces

		move.w	VDP_Reg1_Val.w,d0
		ori.b	#$40,d0
		move.w	d0,(a6)			; enable display

		lea	InitialText(pc),a0	; get text ptr to a0
		jsr	WriteTextBufInitBig(pc)
		move.w	#$8B03,(a5)
		jsr	PreloadLevelData(pc)

GameLoop:
		move.b	GameMode.w,d0		; get game mode
		andi.w	#$C,d0			;
		movea.l	GameModes(pc,d0.w),a0	; get target routine
		jsr	(a0)			; and branch to it
		bra.s	GameLoop		; request new game mode

; ---------------------------------------------------------------------------
InitialText:	dc.b 4, 138/2, 80, "hi."
		dc.b 1, 7-1, 2, 4, 25/2, 80, 1, 4-1
		dc.b "how are you?",0
		even
GameModes:	dc.l ('H'<<24)|EntryPoint	; 0
		dc.l ('E'<<24)|Ending		; 4
		dc.l ('L'<<24)|ArtKosM_Spikes	; 8
		dc.l ('L'<<24)|Level		; $C
; ---------------------------------------------------------------------------

WriteTextBufInitBig:
		lea	Font_HintsBig(pc),a6
		bra.s	WriteTextBufInit_

WriteTextBufInit:
		lea	Font_Hints(pc),a6

WriteTextBufInit_:
		move	#$2700,sr
		move.w	#320/2,d6		; set width
		move.w	#224,d7			; set height
		lea	$FF0000.l,a1		; get output buffer to a1
		jsr	WriteTextToBuffer	; slot text to output buffer
		move	#$2300,sr

FlushFont:
		lea	vdp_control_port.l,a5
	dma68kToVDP $FF0000,32,40*28*32,VRAM	; dma it
	dma68kToVDP $FF0000,32,40*28*32,VRAM	; dma it
		rts
; ---------------------------------------------------------------------------

SndDrvInit:
		nop
		move.w	#$100,Z80_bus_request
		move.w	#$100,Z80_reset

		lea	Z80_Snd_Driver,a0
		lea	Z80_RAM,a1
		move.w	#$1C00-1,d0
.load		move.b	(a0)+,(a1)+
		dbf	d0,.load

		lea	Z80_RAM+$1C00,a1
		moveq	#16-1,d0		; fill next 16 bytes with 0
		moveq	#0,d1			; changed to write from dreg
.blank		move.b	d1,(a1)+
		dbf	d0,.blank

		btst	#6,Graphics_Flags.w	; is this NTSC Genesis?
		beq.s	.isNTSC			; if is, branch
		move.b	#1,Z80_RAM+$1C02	; set PAL mode

.isNTSC		move.w	#0,Z80_reset
		nop
		nop
		nop
		nop
		move.w	#$100,Z80_reset
	startZ80
		rts
; ---------------------------------------------------------------------------

LoadSecondarySoundDriver:
		move.w	#$100,Z80_bus_request
		move.w	#$100,Z80_reset

		lea	Z80_PCM_Driver,a0
		lea	Z80_RAM,a1
		move.w	#428-1,d0
.load		move.b	(a0)+,(a1)+
		dbf	d0,.load

	; set data
		move.l	#End_Wav_Music,d0
		lea	Z80_RAM+$40,a0
		move.b	d0,(a0)+
		lsr.l	#8,d0
		move.b	d0,(a0)+
		lsr.l	#8,d0
		move.b	d0,(a0)+
		clr.b	(a0)+		; skip 1 byte
		move.b	#8,(a0)+	; timer
		move.b	#1,(a0)+	; start playback

		move.w	#0,Z80_reset
		move.w	#$100,Z80_reset
	startZ80
		rts
; ---------------------------------------------------------------------------
