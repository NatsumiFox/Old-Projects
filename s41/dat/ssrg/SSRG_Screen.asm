
; ===============================================================
; SONIC STUFF RESEARCH GROUP SCREEN
; Code and design by Vladikcomper
; ===============================================================

; ---------------------------------------------------------------
; Variables
; ---------------------------------------------------------------

; VRAM Base Addresses
_VRAM_PlaneA	= $C000
_VRAM_PlaneB	= $C000
_VRAM_Sprites	= $F800

; VRAM Art Locations
_VRAM_Sonic	= $60
_VRAM_Title	= $13A0
_VRAM_Logo_St	= $1960
_VRAM_Logo_Dyn	= $E000

; VRAM Art Patterns
_Pat_Sonic	= (_VRAM_Sonic/$20)
_Pat_Title	= (_VRAM_Title/$20)
_Pat_Logo_St	= (_VRAM_Logo_St/$20)
_Pat_Logo_Dyn	= (_VRAM_Logo_Dyn/$20)

; VRAM Settings
_pal0		= 0		; palette select
_pal1		= 1<<13		;
_pal2		= 2<<13		;
_pal3		= 3<<13		;
_pr		= $8000		; high priority flag

; Object variables
xvel_s	= $18	; l	16 fixed
yvel_s	= $1C	; l	16 fixed
xacc	= $24	; l	16 fixed
yacc	= $28	; l	16 fixed
xpos2	= $3C	; l	16 fixed
ypos2	= $30	; l	16 fixed
timer	= $34	; w	integer

; Joypad button indexes
iStart		equ 	7
iA		equ 	6
iC		equ 	5
iB		equ 	4
iRight		equ 	3
iLeft		equ 	2
iDown		equ 	1
iUp		equ 	0

; Joypad button values
Start		equ 	1<<7
A		equ 	1<<6
C		equ 	1<<5
B		equ 	1<<4
Right		equ 	1<<3
Left		equ 	1<<2
Down		equ 	1<<1
Up		equ 	1

; Joypad states
Held		equ	0
Press		equ	1


; ---------------------------------------------------------------
; Memory addresses
; ---------------------------------------------------------------

; System Ports
VDP_Data	= $C00000
VDP_Ctrl	= $C00004

; Joypad virtual ports
SonicControl	= $FFFFF602
Joypad		= $FFFFF604

; Maincore misc variables
ArtBuffer	= $FF0000	; $9B00 bytes	Buffer used to store decompressed art
MapsBuffer	= $FFFF9B00	; $200 bytes	Buffer used to store decompressed sprite mappings
ScreenVars	= $FFFFFF90	; $C bytes	Screen-specific variables
VBlankSub	= $FFFFF62A	; .b		Rotuine ID to execute during VBlank
HScroll		= $FFFFE000	; $380 bytes	Horizontal scroll data
Objects		= $FFFFB000	; $2000 bytes	Objects RAM
Palette		= $FFFFFC00	; $80 bytes	Actual screen palette

; Object slots
		rsset	Objects
ObjQuad		rs.b	$4A
ObjLogo		rs.b	$4A
ObjTitle	rs.b	$4A
ObjSSRGSonic	rs.b	$4A

; Screen private memory
		rsset	ScreenVars
QuadRadius	rs.w	1		; radius
QuadAngle	rs.w	1		; rotation angle (8 fixed)
QuadX		rs.l	1		; X-position (16 fixed)
QuadY		rs.l	1		; Y-position (16 fixed)

; ===============================================================
SSRG:
	; Fade out from the previous screen
	jsr	ClearPLC.w		; clear PLC queue
	jsr	PalFadeDo_ToWhite.w	; fade palette to white
	di				; disable interrupts

	move.w	#($4A*8)/4,d0
	moveq	#0,d1
	lea	Objects.w,a0
.clr	move.l	d1,(a0)+
	dbf	d0,.clr

	; Setup VDP for a new screen mode
	move.l	VDP_Control_Port.w,a6
	move.w	#$8004,(a6)		; disable HInt
	move.w	#$8200|(_VRAM_PlaneA/$400),(a6)		; plane A base
	move.w	#$8400|(_VRAM_PlaneB/$2000),(a6)	; plane B base
	move.w	#$8ADF,(a6)		; set HInt counter to 223 (dead HInt)
	move.w	#$8720,(a6)		; Backdrop Color: color 0, line 2
	move.w	#$9003,(a6)		; plane size: 128x32 tiles
	move.w	#$8B03,(a6)		; VScroll: full; HScroll: 1px
	move.w	#$8134,(a6)		; disable display

	; Clear screen
	; NOTICE: We don't use ClearScreen routine here, as this video mode is special
	lea	-4(a6),a5		; a5 = VDP_Data
	moveq	#0,d0
	vdpcomm	move.l,_VRAM_Sprites,VRAM,WRITE,(a6)
	move.l	d0,(a5)			; kill sprites

	; Load or generate graphics/art
	moveq	#1,d1			; repeat 2 times
	moveq	#-1,d0			; pixel index: F

	vdpcomm	move.l,$20,VRAM,WRITE,(a6)
.ldtile	move.l	d0,(a5)			; create a solid tile (used for quad)
	move.l	d0,(a5)			;
	move.l	d0,(a5)			;
	move.l	d0,(a5)			;
	move.l	d0,(a5)			;
	move.l	d0,(a5)			;
	move.l	d0,(a5)			;
	move.l	d0,(a5)			;
	move.l	#$EEEEEEEE,d0		; pixel index: E
	dbf	d1,.ldtile		; create another tile

	lea	SSRG_Art_Sonic,a0	; load Nemesis-compressed Sonic's art
	jsr	NemDec			; decompress it
	lea	SSRG_Art_Title,a0	; load Nemesis-compressed SSRG title
	jsr	NemDec			; decompress it

	lea	SSRG_Logo_Bank1(pc),a0	; load Kosinski-compressed SSRG logo art (Bank 1)
	lea	ArtBuffer,a1		; load buffer for decompression
	jsr	KosDec			; decompress it
	move.l	VDP_Control_Port.w,a5	; VDP Control Port
	dma68kToVDP ArtBuffer,_VRAM_Logo_St,$A6A0,VRAM	; transfer it to VRAM via DMA

	lea	SSRG_Logo_Bank2(pc),a0	; load Kosinski-compressed SSRG logo art (Bank 2)
	lea	ArtBuffer,a1		; load buffer for decompression
	jsr	KosDec			; decompress it

	; Decompress misc data
	lea	SSRG_LogoMaps(pc),a0	; load Kosinski-compressed SSRG logo sprite mappings
	lea	MapsBuffer.w,a1		; load buffer for decompression
	jsr	KosDec			; decompress it

	; Load screen palettes
	lea	SSRG_Palette(pc),a0	; source address
	lea	Palette.w,a1		; destination address
	moveq	#$80/4-1,d0		; transfer $80 bytes (the whole palette)
.ldpal	move.l	(a0)+,(a1)+
	dbf	d0,.ldpal

	; Generate auto BG
	move.l	VDP_Control_Port.w,a6	; VDP Control Port
	lea	-4(a6),a5		; VDP Data Port
	vdpcomm	move.l,_VRAM_PlaneA,VRAM,WRITE,(a6)
	moveq	#224/8-1,d6		; number of lines to do
	move.l	#$E001E001,d0		; pattern #0 (blue)
	move.l	#$60016001,d1		; pattern #1 (blue hi)
	move.l	#$60026002,d2		; pattern #2 (white)

.line	moveq	#16,d3			; number of times to repeat pattern #0
.pat0	move.l	d0,(a5)			; draw pattern #0
	dbf	d3,.pat0		; repeat
	moveq	#14,d3			; number of times to repeat pattern #1
.pat1	move.l	d1,(a5)			; draw pattern #1
	dbf	d3,.pat1		; repeat
	moveq	#31,d3			; number of times to repeat pattern #2
.pat2	move.l	d2,(a5)			; draw pattern #2
	dbf	d3,.pat2		; repeat
	dbf	d6,.line		; repeat to cover the whole screen

	; Clear screen RAM ($C bytes)
	lea	ScreenVars.w,a0
	moveq	#0,d0
	move.l	d0,(a0)+		; QuadRadius and QuadAngle
	move.l	d0,(a0)+		; QuadX
	move.l	d0,(a0)+		; QuadY

	; Init objects
	lea	ObjQuad.w,a0		; load object RAM
	move.l	#SSRG_Obj_Quad,(a0)	; setup code pointer to handle this object

	; Prepare the first frame (DISP is off to avoid graphical glitches)
	jsr	ProcessObjects		; run objects
	jsr	SSRG_RenderQuad(pc)	; render quad

	rept 2
		move.b	#$16,VBlankSub.w
		jsr	VSync.w			; send data to VDP
		lea	Objects.w,a0
		jsr	ProcessObjects		; run objects
		jsr	SSRG_RenderQuad(pc)	; render quad
		jsr	BuildSprites		; render object sprites
	endr

	move.w	#$8174,VDP_Ctrl		; enable display

; ===============================================================
; ---------------------------------------------------------------
; SSRG Screen Main Loop
; ---------------------------------------------------------------

SSRG_MainLoop:
	move.b	#$16,VBlankSub.w
	jsr	VSync.w
	jsr	S1_SndDrv

SSRG_ScreenLogic:
	lea	Objects.w,a0
	jsr	ProcessObjects		; run objects
	jsr	SSRG_RenderQuad(pc)	; render quad
	jsr	BuildSprites		; render object sprites

	tst.b	Joypad|Press.w		; was the Start button pressed?
	bpl.s	SSRG_MainLoop		; if not, continue running screen

	; de-Setup VDP
	move.l	VDP_Control_Port.w,a6
	move.w	#$8004,(a6)		; disable HInt
	move.w	#$8400|($E000/$2000),(a6); plane B base
	move.w	#$8700,(a6)		; Backdrop Color: color 0, line 0
	move.w	#$9001,(a6)		; plane size: 64x32 tiles
	move.w	#$8B00,(a6)		; VScroll: full; HScroll: full
	move.w	#$8134,(a6)		; disable display
	vdpcomm move.l,$F000,VRAM,WRITE,(a6)
		move.w	#0,-4(a6)
	rts				; return from this screen mode

; ---------------------------------------------------------------
; Routine to hold object execution unless timer expires
; ---------------------------------------------------------------

Object_RunTimer:
	tst.w	timer(a0)
	beq.s	.ret
	subq.w	#1,timer(a0)
	addq.w	#4,sp
.ret	rts


; ---------------------------------------------------------------
; Subroutines to update object position
; ---------------------------------------------------------------

Object_MoveXY:
	move.l	yacc(a0),d0
	add.l	d0,yvel_s(a0)
	move.l	yvel_s(a0),d0
	add.l	d0,ypos2(a0)
	move.w	ypos2(a0),ypos(a0)

Object_MoveX:
	move.l	xacc(a0),d0
	add.l	d0,xvel_s(a0)
	move.l	xvel_s(a0),d0
	add.l	d0,xpos2(a0)
	move.w	xpos2(a0),xpos(a0)
	rts
; ===============================================================
; ---------------------------------------------------------------
; Subroutine to render the quad
; Uses Blast Processing
; ---------------------------------------------------------------

_OptRound = 1	; set to 1 for more blast processing

round	macro
	if _OptRound
		bcc.s	.sk\@
		addq.w	#1,\1
.sk\@:
	endc
	endm

; ---------------------------------------------------------------
SSRG_RenderQuad:
	; Calculate the angle
	move.b	QuadAngle.w,d7
	add.b	#$40,d7
	andi.b	#$3F,d7
	cmpi.b	#$20,d7
	bls.s	.3
	subi.b	#$40,d7
.3:
	; Calculate given angle's SIN and COS
	move.b	d7,d0
	jsr	GetSine.w

	; Calculate dX, dY
	move.w	QuadRadius.w,d4	; d4 = R
	muls.w	d4,d0		; d0 = sin * R (8 fixed)
	asr.l	#8,d0		; d0 = dY
	round	d0
	muls.w	d4,d1		; d1 = cos * R (8 fixed)
	asr.l	#8,d1		; d1 = dX
	round	d1

	; Calculate W, H
	move.w	d1,d4		; d4 = dX
	sub.w	d0,d4		; d4 = dX-dY = H (lines to do #1)
	move.w	d1,d5		; d5 = dX
	add.w	d0,d5		; d5 = dX+dY = W (lines to do #2)

	; TODOH: Calc Tan and Cotan below instead of H/W for better accuracy

	; Calculate H/W (Val1)
	;tst.w	d5
	beq.s	.0		; if W = 0, run away, or THE WORLD WILL FUCKIN EXPLODE, trust me
	moveq	#0,d2
	move.w	d4,d2		; d2 = H
	lsl.l	#8,d2		; d2 = H (8 fixed)
	divu.w	d5,d2		; d2 = H/W (8 fixed)
	swap	d2
	clr.w	d2
	lsr.l	#8,d2		; d2 = H/W (16 fixed)
	move.l	d2,a3

	; Calculate W/H (Val2)
	tst.w	d4
	beq.s	.1		; if H = 0, run away, or THE WORLD WILL FUCKIN EXPLODE, trust me
.0	moveq	#0,d3
	move.w	d5,d3		; d3 = W
	lsl.l	#8,d3		; d3 = W (8 fixed)
	divu.w	d4,d3		; d3 = W/H (8 fixed)
	swap	d3
	clr.w	d3
	lsr.l	#8,d3		; d3 = W/H (16 fixed)
	move.l	d3,a2
.1
	; Prepare W/H iterators
	swap	d4		; d4 = H -
	move.w	d5,d4		; d4 = H W
	move.l	d4,d5
	swap	d5		; d5 = W H

	; Calculate X positions of Right and Left side's edges
	move.w	QuadX.w,d7	; d7 = Xbase
	add.w	d1,d7		; d7 = Xbase+dX
	swap	d7
	move.l	d7,a0		; a0 = Right edge reload pos

	move.w	QuadX.w,d7	; d7 = Xbase
	sub.w	d1,d7		; d7 = Xbase-dX
	subi.w	#512,d7
	swap	d7
	move.l	d7,a1		; a1 = Left edge reload pos

        ; Calculate number of lines to render for different parts
	lea	HScroll.w,a4
	move.w	d5,d6
	add.w	d4,d6		; d6 = W+H (Number of lines to render)
	subq.w	#1,d6
	move.w	QuadY.w,d7	; d7 = Ybase
	sub.w	d1,d7		; d7 = Ybase-dX (Number of empty lines from top)
	bmi.s	.offscreen_init	; if we have offscreen lines, branch

; ---------------------------------
; On-screen rendering (empty lines)
; ---------------------------------

	; Calculate number of lines to do in active loop
	move.w	#224,d1		; d1 = 224
	sub.w	d7,d1
	subq.w	#1,d1
	cmp.w	d6,d1
	bhi.s	.2
	move.w	d1,d6
.2
	move.l	#$FF000100,d1	; this scrolling value makes Sonic head's top unmasked
	subq.w	#1,d7
	bmi.s	.active_init

.topfill_loop:
	move.l	d1,(a4)+
	dbf	d7,.topfill_loop

	bra.s	.active_init	; go to active rendering loop

; -----------------------------------
; Off-screen rendering (active lines)
; -----------------------------------

.offscreen_init:

	; Calculate number of lines to do
	neg.w	d7		; d7 = -d7

	; Calculate start X-pos
	add.w	QuadX.w,d0	; d0 = XBase-dY
	swap	d0
	clr.w	d0
	move.l	d0,d1
	subi.l	#512<<16,d1

.offscreen_loop:

	; Check if we're still in offscreen area
	dbf	d7,.offscreen_do
	bra.s	.active_init2;active_loop

.offscreen_do:
	; Calculate right side's pos
	dbf	d4,.r_dra2	; if we're still rendering the current side, branch
	swap	d4		; otherwise, change settings to start rendering another side
	move.l	a2,d2		;
	neg.l	d2		;
	move.l	a0,d0		;
.r_dra2 add.l	d2,d0		; update pos

	; Calculate left side's pos
	dbf	d5,.l_dra2	; if we're still rendering the current side, branch
	swap	d5		; otherwise, change settings to start rendering another side
	move.l	a3,d3		;
	neg.l	d3		;
	move.l	a1,d1		;
.l_dra2	sub.l	d3,d1		; update pos

	dbf	d6,.offscreen_loop

	; TODOH: If quad was totally offscreen?

; ----------------------------------
; On-screen rendering (active lines)
; ----------------------------------

.active_init:
	; Calculate start X-pos
	add.w	QuadX.w,d0	; d0 = XBase-dY
	swap	d0
	clr.w	d0
	move.l	d0,d1
	subi.l	#512<<16,d1

.active_init2:
	; Init regs
	lea	2(a4),a5	; HSRAM position for Plane B

	; Calculate how many lines we can do...
	cmpi.w	#223,d6		; more than 224 lines to go?
	bls.s	.active_loop	; if nay, branchie
	move.w	#223,d6		; reset counter to 224

.active_loop:
	; Calculate left side's pos
	dbf	d5,.l_draw	; if we're still rendering the current side, branch
	swap	d5		; otherwise, change settings to start rendering another side
	move.l	a3,d3		;
	neg.l	d3		;
	move.l	a1,d1		;
.l_draw	move.l	d1,(a4)+
	sub.l	d3,d1		; update pos

	; Calculate right side's pos
	dbf	d4,.r_draw	; if we're still rendering the current side, branch
	swap	d4		; otherwise, change settings to start rendering another side
	move.l	a2,d2		;
	neg.l	d2		;
	move.l	a0,d0		;
.r_draw	move.l	d0,(a5)+
	add.l	d2,d0		; update pos
	dbf	d6,.active_loop

; -----------------------------------
; On-screen rendering (empty lines 2)
; -----------------------------------

	moveq	#0,d1
	move.w	#HScroll+224*4,d0
	cmpa.w	d0,a4		; have we filled all the array shitz?
	beq.s	.done		; if yes, branch

.botfill_loop:
	move.l	d1,(a4)+
	cmpa.w	d0,a4
	bne.s	.botfill_loop

.done	rts

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to fade to color
; ---------------------------------------------------------------
; INPUT:
;	a1	Source palette
;	d3	Destination color - Red
;	d4	Destination color - Green
;	d5	Destination color - Blue
;	d6	Number of colors to do minus one
; ---------------------------------------------------------------

SSRG_FadeToColor:
	move.b	(a1),d0			; load blue
	cmp.b	d5,d0			; compare it to destination blue
	beq.s	.setb			; if it equals, branch
	blo.s	.incb			; if lower, branch
	subq.b	#2+2,d0			; decrease blue
.incb	addq.b	#2,d0			; increase blue
.setb	move.b	d0,(a1)+		; save new blue

	move.b	(a1),d0			; load green and red
	move.b	d0,d1
	lsr.b	#4,d1			; get green
	cmp.b	d4,d1			; compare it to destination green
	beq.s	.setg			; if it equals, branch
	blo.s	.incg			; if lower, branch
	subi.b	#$20+$20,d0		; decrease green
.incg	addi.b	#$20,d0			; increase green
.setg
	move.b	d0,d1
	andi.b	#$F,d1			; get red
	cmp.b	d3,d1			; compare it to destination red
	beq.s	.setr			; if it equals, branch
	blo.s	.incr			; if lower, branch
	subq.b	#2+2,d0			; decrease red
.incr	addq.b	#2,d0			; increase red
.setr
	move.b	d0,(a1)+		; save new green and red
	dbf	d6,SSRG_FadeToColor	; repeat for all the colors
	rts
; ===============================================================
; ---------------------------------------------------------------
; Object that controls quad
; ---------------------------------------------------------------

rotvel	= $40		; w	8 fixed
rotacc	= $42		; w	8 fixed

; ---------------------------------------------------------------

SSRG_Obj_Quad:
	move.w	#$E0,QuadRadius.w
	move.w	#160,QuadX.w
	move.w	#96,QuadY.w
	move.w	#$2000,QuadAngle.w

; -----------------------
; Quad's intro animation
; -----------------------

	move.w	#+$0258,rotvel(a0)
	move.l	#Quad_Intro,(a0)

Quad_Intro:

	; Rotate
	jsr	Quad_Rotate(pc)

	; Scale
	move.w	QuadRadius.w,d0
	subq.w	#3,d0
	cmpi.w	#20,d0
	bhi.s	.0
	moveq	#20,d0
	move.w	QuadAngle.w,d1
	addi.w	#$0100,d1
	andi.w	#$3E00,d1
	beq.s	.Quad_Intro_Done
.0	move.w	d0,QuadRadius.w

.1	rts

.Quad_Intro_Done:
	move.w	#20,QuadRadius.w
	move.w	#$4000,QuadAngle.w

; ---------------------------------------
; Quad waits for logo and bounces off it
; ---------------------------------------

bumped	= $46		; b

	; Init bounce physics
	move.l	#+$00003800,yacc(a0)
	move.l	#-$00040000,yvel_s(a0)
	move.l	#-$0000E000,xvel_s(a0)
	move.w	#-$0380,rotvel(a0)
	move.w	#+$000C,rotacc(a0)

	; Load Logo object
	lea	ObjLogo.w,a1
	move.l	#SSRG_Obj_Logo,(a1)

	move.l	#Quad_Bounce,(a0)
	clr.b	bumped(a0)

Quad_Bounce:

	; Wait until quad is bumped
	tst.b	bumped(a0)
	beq.s	.ret

	jsr	Quad_Move(pc)
	jsr	Quad_Rotate(pc)

	; Check if rotation should stop
	move.w	QuadAngle.w,d0
	addi.w	#$2000,d0
	andi.w	#$3E00,d0
	bne.s	.rotdone
	clr.w	rotacc(a0)
	clr.w	rotvel(a0)
	andi.w	#$FE00,QuadAngle.w
.rotdone
	; Check if Y reached
	cmpi.w	#$6C,QuadY.w
	blo.s	.chkX
	move.w	#$6C,QuadY.w
	move.l	#-$00014000,yvel_s(a0)
	move.b	#$BD,($FFFFF00B).w	; play stomping sound

	; Check if X reached
.chkX	cmpi.w	#$75,QuadX.w
	bls.s	.Quad_BounceDone
.ret	rts

.Quad_BounceDone:
	; Stop quad and correct its position
	move.w	#$75,QuadX.w
	move.w	#$6C,QuadY.w

; ----------------------------
; Set Sonic to appear in quad
; ----------------------------

sceneok	= $46	; b

	sf.b	sceneok(a0)
	move.l	#Quad_WaitSonic,(a0)

Quad_WaitSonic:

	; Wait until scene is ready (logo zooms in)
	tst.b	sceneok(a0)
	bne.s	.0
	rts
.0
	; Setup new quad data
	move.w	#64,QuadX.w
	move.w	#104,QuadY.w
	move.w	#45,QuadRadius.w
	move.w	#$2000,QuadAngle.w

	; Create Sonic and SSRG title objects
	move.l	#SSRG_Obj_Sonic,ObjSSRGSonic.w
	move.l	#SSRG_Obj_Title,ObjTitle.w

	; Play emerald collecting sound
	move.b	#$95,($FFFFF00A).w

; -----------------------------
; SSRG logo and title fade out
; -----------------------------

	sf.b	sceneok(a0)
	move.w	#180,timer(a0)
	move.l	#Quad_FadeOutSSRG,(a0)

Quad_FadeOutSSRG:
	; Wait until scene is ready
	tst.b	sceneok(a0)
	beq.s	.ret

	; When scene is setup up, wait 3 seconds
	jsr	Object_RunTimer(pc)
	move.l	#.fade,(a0)
	move.w	#32,timer(a0)

	; Fade out SSRG logo and title palette
.fade	subq.w	#1,timer(a0)		; decrease timer
	beq.s	.FadeOut_Done		; if timer expired, branch
	btst	#0,timer+1(a0)
	beq.s	.noskip			; skip code every even frame
.ret	rts

.noskip	lea	Palette+$40.w,a1	; load palette, row 2
	moveq	#$A,d3			; dest red
	moveq	#$C,d4			; dest green
	moveq	#$E,d5			; dest blue
	moveq	#$40/2-2-1,d6		; do full 2 lines, minus 2 colors
	jmp	SSRG_FadeToColor(pc)

.FadeOut_Done:
	; Delete SSRG logo and title objects
	move.l	#DeleteObject,d0
	move.l	d0,objLogo.w
	move.l	d0,objTitle.w

; -------------------------------------
; Quad zooms out into the whole screen
; -------------------------------------

	; Init physics
	move.l	#+$00030000,xvel_s(a0)
	move.l	#+$00004000,yvel_s(a0)
	moveq	#0,d0
	move.l	d0,yacc(a0)
	move.l	d0,xacc(a0)
	move.w	#$0400,rotvel(a0)
	move.w	d0,rotacc(a0)

	sf.b	sceneok(a0)
	move.w	#60,timer(a0)
	move.l	#Quad_ZoomOut,(a0)

Quad_ZoomOut
	; Wait until scene is ready
	tst.b	sceneok(a0)
	bne.s	.0
.1	rts

.0	; Move quad, unless it has covered the whole screen
	cmpi.w	#$A0,QuadX.w
	beq.s	.wtend
	addq.w	#6,QuadRadius.w

	jsr	Quad_Move(pc)
	jmp	Quad_Rotate(pc)

        ; Wait some time and end that shit
.wtend	jsr	Object_RunTimer(pc)	; wait some time
	ori.b	#$80,Joypad|Press.w	; PLAYERS IS STARING DA SCREEN DONT WANNA PRESS START? DO IT FOR HIM
	rts

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to apply velocity to quad's angle
; ---------------------------------------------------------------

Quad_Rotate:
	move.w	rotacc(a0),d0
	add.w	d0,rotvel(a0)
	move.w	rotvel(a0),d0
	add.w	d0,QuadAngle.w
	rts

; ---------------------------------------------------------------
; Subroutines to update Quad's position
; ---------------------------------------------------------------

Quad_Move:
	move.l	xacc(a0),d0
	add.l	d0,xvel_s(a0)
	move.l	xvel_s(a0),d0
	add.l	d0,QuadX.w

	move.l	yacc(a0),d0
	add.l	d0,yvel_s(a0)
	move.l	yvel_s(a0),d0
	add.l	d0,QuadY.w
	rts

; ===============================================================
; ---------------------------------------------------------------
; SSRG Logo object
; ---------------------------------------------------------------

SSRG_Obj_Logo:
	move.w	#_Pat_Logo_St|_pal2|_pr,tile(a0)
	move.l	#MapsBuffer,map(a0)
	move.w	#$80+320+128,xpos(a0)
	move.w	#$80+$6F,ypos(a0)

; --------------------
; Logo intro sequence
; --------------------

	move.w	#10,timer(a0)		; set timer to 1 second
	move.l	#Logo_Intro,(a0)

Logo_Intro:
	; Wait a second before appearence
	jsr	Object_RunTimer(pc)

	; Logo rushes in!
	subq.w	#8,xpos(a0)

	; Check if logo has bumped the quad
	cmpi.w	#$80+160+48+8,xpos(a0)	; has logo reached the bump point?
	bne.s	.disp			; if not, branch
	move.l	#-$00044E00,xvel_s(a0)	; setup slowdown physics
	move.l	#+$00003E00,xacc(a0)	;
	move.w	xpos(a0),xpos2(a0)	; copy X-coord
	move.l	#.Logo_Slowdown,(a0)
	st.b	ObjQuad+bumped.w	; tell quad that we've bumped
	move.b	#$AC,($FFFFF00B).w	; play bumping sound

.Logo_Slowdown:
	; Logo slowdowns after the bump
	jsr	Object_MoveX(pc)
	tst.w	xvel_s(a0)		; is velocity nearly zero?
	beq.s	.Logo_IntroDone		; if yes, branch

.disp	jmp	DisplayObj

.Logo_IntroDone:

; ---------------------------
; The whole screen scales in
; ---------------------------

scene_pos	= $40	; w
scene_dmasrc	= $42	; l

	move.w	#60,timer(a0)		; set timer to 1 second
	clr.w	scene_pos(a0)
	move.l	#$FF0000,scene_dmasrc(a0)
	move.l	#Logo_ScaleScene,(a0)

Logo_ScaleScene:
	jsr	DisplayObj

	; Wait a second first
	jsr	Object_RunTimer(pc)

	; Run scaling scene
	move.w	scene_pos(a0),d0
	lea	.SceneData(pc,d0.w),a2

	move.w	(a2)+,d3		; DATA -> Art pointer / DMA len
	bmi.s	.setart			; if art pointer, branch

	move.l	scene_dmasrc(a0),d0
	move.l	d0,d1			; d1 = Source Address
	ext.l	d3
	add.l	d3,d0			; calculate next DMA source address
	move.l	d0,scene_dmasrc(a0)
	move.w	#_VRAM_Logo_Dyn,d2	; d2 = Destination Address
	lsr.w	#1,d3			; d3 = DMA length (in words)
	jsr	QueueDMA.w
	move.w	#_Pat_Logo_Dyn|_pal2|_pr,d3

.setart	move.w	d3,tile(a0)

	moveq	#0,d0
	move.b	(a2)+,d0		; DATA -> Logo X-pos
	addi.w	#$80,d0
	move.w	d0,xpos(a0)		; store X-pos

	moveq	#0,d0
	move.b	(a2)+,d0		; DATA -> Logo Y-pos
	addi.w	#$80,d0
	move.w	d0,ypos(a0)		; store Y-pos

	move.b	(a2)+,frame(a0)		; DATA -> Frame

	move.b	(a2)+,QuadX+1.w		; DATA -> Quad X-pos
	move.b	(a2)+,QuadY+1.w		; DATA -> Quad Y-pos
	move.b	(a2)+,QuadRadius+1.w	; DATA -> Quad Radius

	; Setup next scene
	addq.w	#8,scene_pos(a0)
	cmpi.w	#32*8,scene_pos(a0)	; is this the last frame in scene?
	beq.w	.Logo_ScaleDone		; if yes, branch
	rts

; ---------------------------------------------------------------
.SceneData:
	incbin	"dat\ssrg\SceneData.bin"

; ---------------------------------------------------------------
.Logo_ScaleDone:

; ------------------
; Logo does nothing
; ------------------

	st.b	ObjQuad+sceneok.w	; tell quad we're done here
	move.l	#DisplayObj,(a0)
	rts


; ===============================================================
; ---------------------------------------------------------------
; SSRG Sonic object
; ---------------------------------------------------------------

SSRG_Obj_Sonic:

	move.w	#_Pat_Sonic,tile(a0)
	move.l	#SSRG_Map_Sonic,map(a0)
	move.w	#$E8,xpos2(a0)
	move.w	#$13C,ypos2(a0)

; ----------------------
; Sonic appears in quad
; ----------------------

	; Setup appearence physics
	move.l	#+$00002800,yacc(a0)
	move.l	#-$00010000,xvel_s(a0)
	move.l	#-$00051000,yvel_s(a0)
	move.w	#16,timer(a0)
	move.l	#.Appearence,(a0)

.Appearence:
	jsr	DisplayObj

	cmpi.w	#$C1,xpos(a0)		; has Sonic reached $C1 on X-axis?
	beq.s	.stopX			; if yes, branch
	jsr	Object_RunTimer(pc)	; create a delay before movement
.moveXY	jmp	Object_MoveXY(pc)	; move object with acceleration

.stopX	moveq	#0,d0
	move.l	d0,xvel_s(a0)		; clear X-velocity
	neg.l	yacc(a0)		; make Sonic rise slightly
	move.l	#.chkY,(a0)
	rts

.chkY	jsr	DisplayObj

	cmpi.w	#$EE,ypos(a0)		; has Sonic reached $EE on Y-axis?
	seq	d0
	tst.w	yvel_s(a0)		; is Y-vel negative?
	smi	d1
	and.b	d0,d1
	beq.s	.moveXY			; if not, branch

	st.b	objQuad+sceneok.w	; tell the quad we're ready

; ----------------------------
; Sonic jumps out of the quad
; ----------------------------

	; Setup jumping physics
	move.l	#-$00020000,xvel_s(a0)
	move.l	#+$00060000,yvel_s(a0)
	move.l	#+$00003000,xacc(a0)
	move.l	#-$0000C000,yacc(a0)
	move.l	#.JumpReady,(a0)

.JumpReady
	jsr	DisplayObj

	tst.b	objQuad+sceneok.w	; is quad awaiting shits to happen?
	beq.s	.0
	rts

.0	cmpi.w	#$C1,xpos(a0)		; has Sonic reached $C1 on X-axis
	scc	d0
	tst.w	yvel_s(a0)		; is Y-vel negative?
	smi	d1
	and.b	d0,d1
	bne.s	.setjump

.move	jmp	Object_MoveXY(pc)	; move object with acceleration

.setjump
	; Setup jump out physics
	move.l	#+$00040000,xvel_s(a0)
	moveq	#0,d0
	move.l	d0,xacc(a0)
	move.l	#-$00060000,yvel_s(a0)
	move.l	#+$00006000,yacc(a0)
	move.l	#.JumpOut,(a0)
	ori.w	#_pr,tile(a0)

	st.b	objQuad+sceneok.w	; tell quad to zoom out
	move.b	#$A8,($FFFFF00B).w	; play ultra sound

.JumpOut:
	jsr	DisplayObj

	cmpi.w	#$80+224+$60,ypos(a0)
	blo.s	.move
	rts

; ---------------------------------------------------------------
SSRG_Map_Sonic:
	dc.w	2

.xdisp = -$20
.ydisp = -$08

	dc.w	$F
;			YY   WH  Pal   TT   XX
	dc.b	.ydisp+$E0, $0E, $00, $00, $FF, $F8+.xdisp
	dc.b	.ydisp+$E0, $0A, $00, $0C, $FF, $18+.xdisp
	dc.b	.ydisp+$E8, $05, $00, $15, $00, $30+.xdisp
	dc.b	.ydisp+$F8, $0F, $00, $19, $FF, $F8+.xdisp
	dc.b	.ydisp+$F8, $0F, $00, $29, $FF, $18+.xdisp
	dc.b	.ydisp+$F8, $02, $00, $39, $00, $38+.xdisp
	dc.b	.ydisp+$18, $04, $00, $3C, $FF, $F8+.xdisp
	dc.b	.ydisp+$18, $0F, $00, $3E, $FF, $08+.xdisp
	dc.b	.ydisp+$18, $03, $00, $4E, $00, $28+.xdisp
	dc.b	.ydisp+$F8, $0F, $20, $52, $FF, $E8+.xdisp
	dc.b	.ydisp+$38, $0F, $20, $62, $FF, $10+.xdisp
	dc.b	.ydisp+$20, $0B, $20, $72, $00, $30+.xdisp
	dc.b	.ydisp+$40, $07, $20, $7E, $00, $30+.xdisp
	dc.b	.ydisp+$58, $05, $20, $86, $FF, $18+.xdisp
	dc.b	.ydisp+$F8, $0F, $20, $8A, $FF, $18+.xdisp

; ===============================================================
; ---------------------------------------------------------------
; Object - SSRG Title
; ---------------------------------------------------------------

SSRG_Obj_Title:
	move.w	#_Pat_Title|_pal3|_pr,tile(a0)
	move.l	#SSRG_Map_Title,map(a0)
	move.w	#24,timer(a0)
	move.w	#$20B,xpos2(a0)
	move.w	#$80+131,ypos(a0)

	; Setup moving physics
	move.l	#+$00008000,xacc(a0)
	move.l	#-$000E8000,xvel_s(a0)
	move.l	#.Move,(a0)

        ; Move SSRG title object until it stops
.Move	jsr	Object_RunTimer(pc)
	jsr 	DisplayObj
	tst.l	xvel_s(a0)
	beq.s	.MoveEnd
	jmp	Object_moveX(pc)

.MoveEnd:
	move.l	#DisplayObj,(a0)
	rts
; ---------------------------------------------------------------
SSRG_Map_Title:
	dc.w	2

.xdisp = -$50
.ydisp =  $18

	dc.w	6
;			YY   WH  Pal   TT   XX
	dc.b	.ydisp+$E0, $0D, $00, $00, $FF, $F8+.xdisp
	dc.b	.ydisp+$E0, $0D, $00, $08, $FF, $18+.xdisp
	dc.b	.ydisp+$E0, $0D, $00, $10, $FF, $38+.xdisp
	dc.b	.ydisp+$E0, $0D, $00, $18, $00, $58+.xdisp
	dc.b	.ydisp+$E0, $0D, $00, $20, $00, $78+.xdisp
	dc.b	.ydisp+$E0, $09, $00, $28, $00, $98+.xdisp
; ==============================================================
; --------------------------------------------------------------
; Palettes
; --------------------------------------------------------------

SSRG_Palette:
	incbin	"dat\ssrg\Sonic_Pt1.pal"	; row 0
	incbin	"dat\ssrg\Sonic_Pt2.pal"	; row 1
	incbin	"dat\ssrg\Logo.pal"		; row 2
	incbin	"dat\ssrg\Title.pal"		; row 3

; ---------------------------------------------------------------
; Misc data
; ---------------------------------------------------------------

SSRG_LogoMaps:
	incbin	"dat\ssrg\LogoMaps.kos"
	even
