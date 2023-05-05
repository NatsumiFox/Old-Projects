	opt op+
	opt w-
	opt m+
	opt l.
	include "mac.asm"

; ===========================================================================
Maincode	section org(0)
		rts
		rts
		dc.l EntryPoint, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l HBlank
		bra.w	offset(*)
		dc.l VBlank
; ===========================================================================

DMALEN =	GFXX*GFXY*16

VBlank2:
	dmaVDP2 Graphics+DMALEN, DMALEN, DMALEN, VRAM, $8200|($A000/$400)	; dma graphics to VRAM
		move.w	#VBlank3,VBlank+2.w
		rte

VBlank4:
	dmaVDP2 Graphics+DMALEN, (DMALEN*3), DMALEN, VRAM, $8200|($C000/$400)	; dma graphics to VRAM
		move.w	#VBlank1,VBlank+2.w
		rte

VBlank3:
	dmaVDP	Graphics, DMALEN*2, DMALEN, VRAM	; dma graphics to VRAM
		move.w	#VBlank4,VBlank+2.w
		rte

VBlank1:
	dmaVDP	Graphics, $0000, DMALEN, VRAM		; dma graphics to VRAM
		move.w	#VBlank2,VBlank+2.w
HBlank:
		rte

ErrorTrap:
	vdpcomm	move.l,0,CRAM,WRITE,(a6)
		bra.s	Error2

; ===========================================================================
	cnop 0,$0100
Console:	dc.b "SEGA   NATSUMI"
Error2:		move.w	#$E,-4(a6)
		bra.s	offset(*)
		dc.b "2017/09/15"
		dc.b "SEGA MEGA DRIVE 3D PROTOTYPE                    "
		dc.b "SEGA MEGA DRIVE 3D PROTOTYPE                    "
; ===========================================================================
; ---------------------------------------------------------------------------
; textures section
; ---------------------------------------------------------------------------

Wall1:		incbin "graphics/wall1.unc"

	cnop 0,$7F80
; ===========================================================================

; ===========================================================================
; ---------------------------------------------------------------------------
; plane mappings for double buffered output
; ---------------------------------------------------------------------------
PlaneMap	macro off
.x =		0
.y =		0
.d =		0
	rept 64*GFXY*2
		dc.w (.x*GFXY)+.y+(.d<<12)+\off

.x		= (.x+1)&$3F

		if .x=0
			if .d=0
.y =				.y+1
			else
.y =				.y-1
			endif

		; if .y == 12, aka last line, flip .d and fix .y to 11
			if (.y=GFXY)
.d =				1
.y =				GFXY-1
			endif
		endif
	endr

	rept 28-(GFXY*2)
		dcb.w 64, GFXX*GFXY*2
	endr
    endm

PlaneA3D1:
	PlaneMap 0

PlaneA3D2:
	PlaneMap GFXX*GFXY

; ===========================================================================
VDPregs:	dc.w $8004, $8154, $8230, $8320
		dc.w $8407, $8570, $8600, $8700
		dc.w $8800, $8900, $8A00, $8B00
		dc.w $8C00, $8D3F, $8E00, $8F02
		dc.w $9001, $9100, $9200, $93FF
		dc.w $94FF, $9500, $9600, $9780

; ===========================================================================
EntryPoint:
		lea	Stack,sp		; set stack ptr
		lea	Z80_Bus_Request,a1
		move.w  #$100,(a1)
		move.b	HW_Version-Z80_bus_request(a1),d0; get hardware version	; 4
		andi.b	#$F,d0			; is this TMSS MD?
		beq.s	.skip			; if not, skip
		move.l	Console.w,TMSS_Addr-Z80_bus_request(a1)	; do TMSS

.skip		lea	VDP_Control_Port,a6
		lea	-4(a6),a5
		tst.w	(a6)

	fillVRAM 0,0,$10000,1		; fill VRAM with blank

		lea	VDPregs(pc),a1		; get register setup
		moveq	#$B-1,d0

.loop		move.l	(a1)+,(a6)		; move 2 register settings per move
		dbf	d0,.loop		; loop until 0

	vdpComm	move.l,0,CRAM,WRITE,(a6)	; CRAM WRITE to $0000
		lea	MirrorPal,a0		; get palette
	rept 32/4
		move.l	(a0)+,(a5)		; write pal data
	endr

	dmaVDP PlaneA3D1, $A000, 28*$80, VRAM	; load tiles maps to planeA1
	dmaVDP PlaneA3D2, $C000, 28*$80, VRAM	; load tiles maps to planeA2

	; fille PlaneB with blank tiles
.tile =		GFXX*GFXY*2
		move.l	#.tile|(.tile<<16),d0
		move.w	#$1000/32-1,d1
	vdpcomm	move.l,$E000,VRAM,WRITE,(a6)

.fill	rept 32/4
		move.l	d0,(a5)			; write map
	endr
		dbf	d1,.fill

		move.w	#$8F40,(a6)
	vdpcomm	move.l,$8000,VRAM,WRITE,(a6)
		move.l	#$00AF00AF,d0
		moveq	#28-1,d1

.planew		move.l	d0,(a5)
		dbf	d1,.planew

		move.w	#$8F02,(a6)
		move.l	#$4EF80000|VBlank4,VBlank.w; set v-blank addr
		move.w	#$8174,(a6)		; enable h-ints
		clr.l	CamX.w
		clr.l	CamY.w
		clr.l	CamA.w

MainLoop:
		stop	#$2300
		cmp.w	#VBlank3,VBlank+2.w	; check if vblank3
		beq.s	.ok			; if not, branch
		cmp.w	#VBlank1,VBlank+2.w	; check if vblank1
		bne.s	MainLoop		; if not, branch

.ok	;	move.w	#$9101,(a6)
		jsr	Render3D(pc)		; render 3D
		bsr.s	DoControls		; process controls
		jsr	Process3D(pc)		; process 3D
	;	move.w	#$9100,(a6)
		bra.s	MainLoop

; ---------------------------------------------------------------------------
; control code
; ---------------------------------------------------------------------------

DoControls:
		lea	ButtonHeld.w,a0
		lea	HW_Port_1_Data,a1
		move.b	#0,(a1)
		or.l	d0,d0
		move.b	(a1),d0
		lsl.b	#2,d0
		andi.b	#$C0,d0
		move.b	#$40,(a1)
		or.l	d0,d0
		move.b	(a1),d1
		andi.b	#$3F,d1
		or.b	d1,d0
		not.b	d0
		move.b	(a0),d1
		eor.b	d0,d1
		move.b	d0,(a0)+
		and.b	d0,d1
		move.b	d1,(a0)+

		btst	#0,ButtonHeld.w		; check if holding up
		beq.s	.notup			; if not, branch
		addq.w	#4,CamY.w		; increase Y

.notup		btst	#1,ButtonHeld.w		; check if holding down
		beq.s	.notdwn			; if not, branch
		subq.w	#4,CamY.w		; decrease Y

.notdwn		btst	#2,ButtonHeld.w		; check if holding left
		beq.s	.notleft		; if not, branch
		subq.w	#4,CamX.w		; decrease X

.notleft	btst	#3,ButtonHeld.w		; check if holding right
		beq.s	.notright		; if not, branch
		addq.w	#4,CamX.w		; increase X

.notright	btst	#6,ButtonHeld.w		; check if holding A
		beq.s	.notA			; if not, branch
		add.w	#4*4,CamA.w		; increase A
		and.w	#$FF*4,CamA.w		; keep in 256 degree angle

.notA		btst	#5,ButtonHeld.w		; check if holding C
		beq.s	.notC			; if not, branch
		sub.w	#4*4,CamA.w		; decrease A
		and.w	#$FF*4,CamA.w		; keep in 256 degree angle

.notC		rts

; ---------------------------------------------------------------------------
; data section
; ---------------------------------------------------------------------------
MirrorPal:	incbin "graphics/3D.pal"

Layout:
.row =	GFXY*8
	; 0-128 x 0-128
	dc.w Wall1, 0	; wall at 0x-128x
	; 128-256 x 0-128
	dc.w 0, 0
	; 0-128 x 128-256
	dc.w 0, 0
	; 128-256 x 128-256
	dc.w 0, 0
;	dc.w Wall1, 0	; wall at 128x-256x

; ---------------------------------------------------------------------------
; process the 3D graphics here
; ---------------------------------------------------------------------------
	include "graphics/scales.asm"

		incbin "misc/sinewave.bin"
		incbin "misc/sinewave.bin"
		incbin "misc/sinewave.bin"
Sine:		incbin "misc/sinewave.bin"
		incbin "misc/sinewave.bin"
		incbin "misc/sinewave.bin"

TextureLUT:
.x = 0
	rept 128
		dc.w .x
.x =		.x+88
	endr

Process3D:
		move.b	#4-1,Counter.w
		move.w	CamA.w,d0		; get camera angle
		lea	Sine(pc),a2		; get sine table to a2
		sub.w	#64*4,d0		; sub 64 angles
		andi.w	#$03FC,d0		; keep within the table
		adda.w	d0,a2			; advance to correct sinewave entry

		moveq	#128-1,d7		; set repeat count
		lea	TextureLUT(pc),a3	; get texture LUT to a3
		lea	DrawArray(pc),a0	; get draw array to a0+
		lea	RenderData,a1		; get render data to a1
		lea	Layout(pc),a4		; put layout into a4
		lea	AssRAM.w,a5

.linesloop	move.w	#128-1,d6		; reset distance
		move.l	CamX.w,d5		; get x-position
		move.l	CamY.w,d4		; get y-position

		move.l	d5,d0
		swap	d0
		and.w	#$FF80,d0
		move.w	d0,(a5)			; save to ASSRAM

		move.l	d4,d0
		swap	d0
		and.w	#$FF80,d0
		move.w	d0,2(a5)		; save to ASSRAM

		move.l  $40*4(a2),d3		; load y-offset
		move.l  (a2)+,d2		; load x-offset
		lsl.l	#8,d3
		lsl.l	#8,d2

		moveq	#64,d0
		sub.w	d7,d0
		bpl.s	.noneg
		neg.w	d0

.noneg	;	lsl.l	#7,d0
;		add.l	d0,d3
;		add.l	d0,d2

.distloop	add.l	d2,d5			; increase x-pos
		add.l	d3,d4			; increase y-pos

		move.l	d5,d0			; copy x to d0
		swap	d0			; get low word
		move.w	d0,d1			; copy to d1 (for later)
		and.w	#$FF80,d0		; check if this is a seam of a wall
		cmp.w	(a5),d0			; check ASSRAM
		beq.s	.chky			; if not in seam, check y

	; calculate layout position
		move.w	d0,(a5)			; update ASSRAM
		move.l	d4,d0			; copy y to d0
		swap	d0			; swap offset

	if LayoutX<5
		andi.w	#((1<<LayoutX)-1)*$80,d0; keep in range
		andi.w	#((1<<LayoutY)-1)*$80,d1; keep in range
		lsr.w	#LayoutX,d1		; shift x-pos in place
		add.w	d0,d1			; add y-pos (unshifted) to x-pos
		lsr.w	#5-LayoutX,d1		; x is multiple of 4
	;	and.w	#$FFFC,d1

	elseif LayoutX>5
		andi.l	#((1<<LayoutX)-1)*$80,d0; keep in range
		andi.l	#((1<<LayoutY)-1)*$80,d1; keep in range
		lsl.l	#LayoutX-5,d0		; shift y-pos in place
		add.l	d0,d1			; add y-pos to x-pos (unshifted)
		lsr.l	#5,d1			; x is multiple of 4
	endif

		move.w	(a4,d1.w),d0		; get the art for layout
		beq.s	.chky			; if there is nothing here, branch

		move.l	d4,d1			; copy y to d1
		swap	d1
		and.w	#$7F,d1
		add.w	d1,d1
		add.w	(a3,d1.w),d0		; add offset to art
		bra.s	.gotit

.chky
.noy		dbf	d6,.distloop		; do the dist loop

.gotit		add.w	d6,d6			; double distance
		add.w	d6,d6			; double distance
		move.l	(a0,d6.w),(a1)+		; set routine to run
		move.w	d0,(a1)+		; set art data
		dbf	d7,.linesloop		; do for all lines
		rts

; ---------------------------------------------------------------------------
; render the 3D graphics here
; ---------------------------------------------------------------------------
Render3D:
		lea	RenderData,a5		; render routine addresses
		lea	Graphics,a4		; put graphics to a4
		moveq	#0,d7

	rept GFXX-1
		rept 3
			move.l	(a5)+,a1	; get the next rendering setting
			move.w	(a5)+,a3	; get the next line address
			jsr	(a1)		; render line appropriately
		endr

		move.l	(a5)+,a1		; get the next rendering setting
		move.w	(a5)+,a3		; get the next line address
		jsr	(a1)			; render line appropriately
		add.w	#(GFXY*32)-4,a4
	endr

	rept 3
		move.l	(a5)+,a1		; get the next rendering setting
		move.w	(a5)+,a3		; get the next line address
		jsr	(a1)			; render line appropriately
	endr

		move.l	(a5)+,a1		; get the next rendering setting
		move.w	(a5)+,a3		; get the next line address
		jmp	(a1)			; render line appropriately

	opt oz+
		include "graphics/codes.asm"
	opt oz-
EndOfRom:	END
