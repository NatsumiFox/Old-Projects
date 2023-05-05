
; ===============================================================
; SONIC STUFF RESEARCH GRO_up SCREEN
; Code and design by Vladikcomper
; ===============================================================

; ---------------------------------------------------------------
; Variables
; ---------------------------------------------------------------

; _vram Base Addresses
__vram_PlaneA	= $C000
__vram_PlaneB	= $C000
__vram_Sprites	= $F800

; _vram Art Locations
__vram_Sonic	= $60
__vram_Title	= $13A0
__vram_Logo_St	= $1960
__vram_Logo_Dyn	= $E000

; _vram Art Patterns
_Pat_Sonic	= (__vram_Sonic/$20)
_Pat_Title	= (__vram_Title/$20)
_Pat_Logo_St	= (__vram_Logo_St/$20)
_Pat_Logo_Dyn	= (__vram_Logo_Dyn/$20)

; _vram Settings
_pal0		= 0		; palette select
_pal1		= 1<<13		;
_pal2		= 2<<13		;
_pal3		= 3<<13		;
_pr		= $8000		; high priority flag

; Object variables
; NOTICE: This screen custom objects format
render	= 1	; b	bitfield
art	= 2	; w	integer
maps	= 4	; l	pointer
xpos	= 8	; w	integer
ypos	= $A	; w	integer
xvel	= $C	; l	16 fixed
yvel	= $10	; l	16 fixed
frame	= $1A	; b	byte
xacc	= $28	; l	16 fixed
yacc	= $2C	; l	16 fixed
xpos2	= $30	; l	16 fixed
ypos2	= $34	; l	16 fixed
timer	= $38	; w	integer
obj	= $3C	; l	pointer

; Joypad button indexes
iStart		equ 	7
iA		equ 	6
iC		equ 	5
iB		equ 	4
iRight		equ 	3
iLeft		equ 	2
iDown		equ 	1
i_up		equ 	0

; Joypad button values
Start		equ 	1<<7
A		equ 	1<<6
C		equ 	1<<5
B		equ 	1<<4
Right		equ 	1<<3
Left		equ 	1<<2
Down		equ 	1<<1
_up		equ 	1

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
ScreenVars	= $FFFFA000	; $C bytes	Screen-specific variables
VBlankSub	= VBlank_Routine; .b		Rotuine ID to execute during VBlank
HScroll		= $FFFFCC00	; $380 bytes	Horizontal scroll data
Objects		= $FFFFD000	; $2000 bytes	Objects RAM
Palette		= $FFFFFB00	; $80 bytes	Actual screen palette

; Object slots
		rsset	Objects
ObjQuad		rs.b	$40
ObjLogo		rs.b	$40
ObjTitle	rs.b	$40
ObjSSRGSonic	rs.b	$40

; Screen private memory
		rsset	ScreenVars
QuadRadius	rs.w	1		; radius
QuadAngle	rs.w	1		; rotation angle (8 fixed)
QuadX		rs.l	1		; X-position (16 fixed)
QuadY		rs.l	1		; Y-position (16 fixed)

; ---------------------------------------------------------------
; Macro to set _vram write access
; ---------------------------------------------------------------
; Arguments:	1 - raw _vram offset
;		2 - destination operand (Optional)
; ---------------------------------------------------------------
_vram	macro
	if (narg=1)
		move.l	#($40000000+((\1&$3FFF)<<16)+((\1&$C000)>>14)),($C00004).l
	else
		move.l	#($40000000+((\1&$3FFF)<<16)+((\1&$C000)>>14)),\2
	endc
	endm

; ---------------------------------------------------------------
; Direct copy data into _vram via DMA
; ---------------------------------------------------------------
; Arguments:	1 - Source Offset
;		2 - Transfer Length (in bytes)
;		3 - Destination
; ---------------------------------------------------------------

write_vram	macro
	move.l	#$94000000+(((\2>>1)&$FF00)<<8)+$9300+((\2>>1)&$FF),(a6)
	move.l	#$96000000+(((\1>>1)&$FF00)<<8)+$9500+((\1>>1)&$FF),(a6)
	move.w	#$9700+((((\1>>1)&$FF0000)>>16)&$7F),(a6)
	move.w	#$4000+(\3&$3FFF),(a6)
	move.w	#$80+((\3&$C000)>>14),-(sp)
	move.w	(sp)+,(a6)
	endm
; ===============================================================


; ===============================================================

SSRG_Screen:

	; Fade out from the previous screen
	moveq	#$FFFFFFE4,d0		; sound ID to for fading out
	jsr	PlaySound	; play this ID
	jsr	ClearPLC		; clear PLC queue
	jsr	Pal_MakeFlash		; fade palette to white
	move	#$2700,sr		; disable interr_upts

	; Clear object RAM ($2000 bytes)
	lea	Objects,a0		; load objects RAM
	moveq	#0,d0
	moveq	#$2000/$40-1,d7		; clear $2000 bytes
.clrobj	move.l	d0,(a0)+		; clear objects data
	move.l	d0,(a0)+		; ...
	move.l	d0,(a0)+		;
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	move.l	d0,(a0)+
	dbf	d7,.clrobj		; repeat for all the objects

	; Set_up VDP for a new screen mode
	lea	VDP_Ctrl,a6
	move.w	#$8004,(a6)		; disable HInt
	move.w	#$8200|(__vram_PlaneA/$400),(a6)		; plane A base
	move.w	#$8400|(__vram_PlaneB/$2000),(a6)	; plane B base
	move.w	#$8ADF,(a6)		; set HInt counter to 223 (dead HInt)
	move.w	#$8720,(a6)		; Backdrop Color: color 0, line 2
	move.w	#$9003,(a6)		; plane size: 128x32 tiles
	move.w	#$8B03,(a6)		; VScroll: full; HScroll: 1px
	move.w	#$8C71,(a6)
	move.w	#$8134,(a6)		; disable display

	; Clear screen
	; NOTICE: We don't use ClearScreen routine here, as this video mode is special
	lea	-4(a6),a5		; a5 = VDP_Data
	moveq	#0,d0
	_vram	__vram_Sprites,(a6)
	move.l	d0,(a5)			; kill sprites

	; Load or generate graphics/art
	moveq	#1,d1			; repeat 2 times
	moveq	#-1,d0			; pixel index: F
	_vram	$20,(a6)		; set _vram location
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

	lea	SSRG_Logo_Bank1,a0	; load Kosinski-compressed SSRG logo art (Bank 1)
	lea	ArtBuffer,a1		; load buffer for decompression
	jsr	KosDec			; decompress it

	write_vram ArtBuffer, $A6A0, __vram_Logo_St	; transfer it to _vram via DMA

	lea	SSRG_Logo_Bank2,a0	; load Kosinski-compressed SSRG logo art (Bank 2)
	lea	ArtBuffer,a1		; load buffer for decompression
	jsr	KosDec			; decompress it

	; Decompress misc data
	lea	SSRG_LogoMaps,a0	; load Kosinski-compressed SSRG logo sprite mappings
	lea	MapsBuffer,a1		; load buffer for decompression
	jsr	KosDec			; decompress it

	; Load screen palettes
	lea	SSRG_Palette,a0		; source address
	lea	Palette,a1		; destination address
	moveq	#$80/4-1,d0		; transfer $80 bytes (the whole palette)
.ldpal	move.l	(a0)+,(a1)+
	dbf	d0,.ldpal

	; Generate auto BG
	lea	VDP_Ctrl,a6		; VDP Control Port
	lea	-4(a6),a5		; VDP Data Port
	_vram	__vram_PlaneA,(a6)	; set start _vram location
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
	lea	ScreenVars,a0
	moveq	#0,d0
	move.l	d0,(a0)+		; QuadRadius and QuadAngle
	move.l	d0,(a0)+		; QuadX
	move.l	d0,(a0)+		; QuadY

	; Init objects
	lea	ObjQuad,a0		; load object RAM
	st.b	(a0)			; mark this slot as used
	move.l	#SSRG_Obj_Quad,obj(a0)	; set_up code pointer to handle this object

	; Prepare the first frame (DISP is off to avoid graphical glitches)
	jsr	SSRG_RunObjects		; run objects
	jsr	SSRG_RenderQuad		; render quad
	move.b	#$16,VBlankSub
	jsr	DelayProgram		; send data to VDP
	move.w	#$8174,VDP_Ctrl		; enable display
	bra.s	SSRG_ScreenLogic

; ===============================================================
; ---------------------------------------------------------------
; SSRG Screen Main Loop
; ---------------------------------------------------------------

SSRG_MainLoop:
	move.b	#$16,VBlankSub
	jsr	DelayProgram

SSRG_ScreenLogic:
	jsr	SSRG_RunObjects		; run objects
	jsr	SSRG_RenderQuad		; render quad
	jsr	BuildSprites		; render object sprites

	tst.b	Joypad|Press		; was the Start button pressed?
	bpl.s	SSRG_MainLoop		; if not, continue running screen
	rts				; return from this screen mode

; ===============================================================

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to run objects
; NOTICE: It uses a different way to execute objects than S1
; ---------------------------------------------------------------

SSRG_RunObjects:
	lea	Objects,a0		; load objects RAM
	moveq	#$7F,d7			; number of slots to do

.loop	tst.b	(a0)			; is this slot occ_upied?
	beq.s	.next			; if not, load next slot
	movea.l	obj(a0),a1		; load object's code offset
	jsr	(a1)			; run that object
.next	lea	$40(a0),a0		; load next object slot
	dbf	d7,.loop		; repeat for all slots
	rts

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
; Subroutines to _update object position
; ---------------------------------------------------------------

Object_MoveXY:
	move.l	yacc(a0),d0
	add.l	d0,yvel(a0)
	move.l	yvel(a0),d0
	add.l	d0,ypos2(a0)
	move.w	ypos2(a0),ypos(a0)

Object_MoveX:
	move.l	xacc(a0),d0
	add.l	d0,xvel(a0)
	move.l	xvel(a0),d0
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
	move.b	QuadAngle,d7
	add.b	#$40,d7
	andi.b	#$3F,d7
	cmpi.b	#$20,d7
	bls.s	.3
	subi.b	#$40,d7
.3:
	; Calculate given angle's SIN and COS
	move.b	d7,d1
	jsr	CalcSine

	; Calculate dX, dY
	move.w	QuadRadius,d4	; d4 = R
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
	move.w	QuadX,d7	; d7 = Xbase
	add.w	d1,d7		; d7 = Xbase+dX
	swap	d7
	move.l	d7,a0		; a0 = Right edge reload pos

	move.w	QuadX,d7	; d7 = Xbase
	sub.w	d1,d7		; d7 = Xbase-dX
	subi.w	#512,d7
	swap	d7
	move.l	d7,a1		; a1 = Left edge reload pos

        ; Calculate number of lines to render for different parts
	lea	HScroll,a4
	move.w	d5,d6
	add.w	d4,d6		; d6 = W+H (Number of lines to render)
	subq.w	#1,d6
	move.w	QuadY,d7	; d7 = Ybase
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
	add.w	QuadX,d0	; d0 = XBase-dY
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
.r_dra2 add.l	d2,d0		; _update pos

	; Calculate left side's pos
	dbf	d5,.l_dra2	; if we're still rendering the current side, branch
	swap	d5		; otherwise, change settings to start rendering another side
	move.l	a3,d3		;
	neg.l	d3		;
	move.l	a1,d1		;
.l_dra2	sub.l	d3,d1		; _update pos

	dbf	d6,.offscreen_loop

	; TODOH: If quad was totally offscreen?

; ----------------------------------
; On-screen rendering (active lines)
; ----------------------------------

.active_init:
	; Calculate start X-pos
	add.w	QuadX,d0	; d0 = XBase-dY
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
	sub.l	d3,d1		; _update pos

	; Calculate right side's pos
	dbf	d4,.r_draw	; if we're still rendering the current side, branch
	swap	d4		; otherwise, change settings to start rendering another side
	move.l	a2,d2		;
	neg.l	d2		;
	move.l	a0,d0		;
.r_draw	move.l	d0,(a5)+
	add.l	d2,d0		; _update pos

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















; ===============================================================
; ---------------------------------------------------------------
; Object that controls quad
; ---------------------------------------------------------------

rotvel	= $20		; w	8 fixed
rotacc	= $22		; w	8 fixed

; ---------------------------------------------------------------

SSRG_Obj_Quad:
	move.w	#$E0,QuadRadius
	move.w	#160,QuadX
	move.w	#96,QuadY
	move.w	#$2000,QuadAngle

; -----------------------
; Quad's intro animation
; -----------------------

	move.w	#+$0258,rotvel(a0)
	move.l	#Quad_Intro,obj(a0)

Quad_Intro:

	; Rotate
	jsr	Quad_Rotate

	; Scale
	move.w	QuadRadius,d0
	subq.w	#3,d0
	cmpi.w	#20,d0
	bhi.s	.0
	moveq	#20,d0
	move.w	QuadAngle,d1
	addi.w	#$0100,d1
	andi.w	#$3E00,d1
	beq.s	.Quad_Intro_Done
.0	move.w	d0,QuadRadius

.1	rts

.Quad_Intro_Done:
	move.w	#20,QuadRadius
	move.w	#$4000,QuadAngle

; ---------------------------------------
; Quad waits for logo and bounces off it
; ---------------------------------------

bumped	= $1F		; b

	; Init bounce physics
	move.l	#+$00003800,yacc(a0)
	move.l	#-$00040000,yvel(a0)
	move.l	#-$0000E000,xvel(a0)
	move.w	#-$0380,rotvel(a0)
	move.w	#+$000C,rotacc(a0)

	; Load Logo object
	lea	ObjLogo,a1
	st.b	(a1)
	move.l	#SSRG_Obj_Logo,obj(a1)

	move.l	#Quad_Bounce,obj(a0)

Quad_Bounce:

	; Wait until quad is bumped
	tst.b	bumped(a0)
	beq.s	.ret

	jsr	Quad_Move
	jsr	Quad_Rotate

	; Check if rotation should stop
	move.w	QuadAngle,d0
	addi.w	#$2000,d0
	andi.w	#$3E00,d0
	bne.s	.rotdone
	clr.w	rotacc(a0)
	clr.w	rotvel(a0)
	andi.w	#$FE00,QuadAngle
.rotdone
	; Check if Y reached
	cmpi.w	#$6C,QuadY
	blo.s	.chkX
	move.w	#$6C,QuadY
	move.l	#-$00014000,yvel(a0)
	moveq	#$FFFFFFBD,d0
	jsr	PlayMusic		; play stomping sound

	; Check if X reached
.chkX	cmpi.w	#$75,QuadX
	bls.s	.Quad_BounceDone
.ret	rts

.Quad_BounceDone:
	; Stop quad and correct its position
	move.w	#$75,QuadX
	move.w	#$6C,QuadY

; ----------------------------
; Set Sonic to appear in quad
; ----------------------------

sceneok	= $1F	; b

	sf.b	sceneok(a0)
	move.l	#Quad_WaitSonic,obj(a0)

Quad_WaitSonic:

	; Wait until scene is ready (logo zooms in)
	tst.b	sceneok(a0)
	bne.s	.0
	rts
.0
	; Set_up new quad data
	move.w	#64,QuadX
	move.w	#104,QuadY
	move.w	#45,QuadRadius
	move.w	#$2000,QuadAngle

	; Create Sonic and SSRG title objects
	lea	ObjSSRGSonic,a1
	st.b	(a1)
	move.l	#SSRG_Obj_Sonic,obj(a1)

	lea	ObjTitle,a1
	st.b	(a1)
	move.l	#SSRG_Obj_Title,obj(a1)

	; Play emerald collecting sound
	moveq	#$FFFFFF93,d0
	jsr	PlayMusic

; -----------------------------
; SSRG logo and title fade out
; -----------------------------

	sf.b	sceneok(a0)
	move.w	#180,timer(a0)
	move.l	#Quad_FadeOutSSRG,obj(a0)

Quad_FadeOutSSRG:

	; Wait until scene is ready
	tst.b	sceneok(a0)
	beq.s	.ret

	; When scene is set_up _up, wait 3 seconds
	jsr	Object_RunTimer
	move.l	#.fade,obj(a0)
	move.w	#32,timer(a0)

	; Fade out SSRG logo and title palette
.fade	subq.w	#1,timer(a0)		; decrease timer
	beq.s	.FadeOut_Done		; if timer expired, branch
	btst	#0,timer+1(a0)
	beq.s	.noskip			; skip code every even frame
.ret	rts

.noskip	lea	Palette+$40,a1		; load palette, row 2
	moveq	#$A,d3			; dest red
	moveq	#$C,d4			; dest green
	moveq	#$E,d5			; dest blue
	moveq	#$40/2-2-1,d6		; do full 2 lines, minus 2 colors
	jmp	SSRG_FadeToColor
.FadeOut_Done:

	; Delete SSRG logo and title objects
	move.l	#DeleteObject,d0
	move.l	d0,objLogo+obj
	move.l	d0,objTitle+obj

; -------------------------------------
; Quad zooms out into the whole screen
; -------------------------------------

	; Init physics
	move.l	#+$00030000,xvel(a0)
	move.l	#+$00004000,yvel(a0)
	moveq	#0,d0
	move.l	d0,yacc(a0)
	move.l	d0,xacc(a0)
	move.w	#$0400,rotvel(a0)
	move.w	#$0,rotacc(a0)

	sf.b	sceneok(a0)
	move.w	#60,timer(a0)
	move.l	#Quad_ZoomOut,obj(a0)

Quad_ZoomOut

	; Wait until scene is ready
	tst.b	sceneok(a0)
	bne.s	.0
.1	rts
.0
	; Move quad, unless it has covered the whole screen
	cmpi.w	#$A0,QuadX
	beq.s	.wtend
	addq.w	#6,QuadRadius

	jsr	Quad_Move
	jmp	Quad_Rotate

        ; Wait some time and end that shit
.wtend	jsr	Object_RunTimer		; wait some time
	ori.b	#$80,Joypad|Press	; PLAYERS IS STARING DA SCREEN DONT WANNA PRESS START? DO IT FOR HIM
	rts


; ===============================================================
; ---------------------------------------------------------------
; Subroutine to apply velocity to quad's angle
; ---------------------------------------------------------------

Quad_Rotate:
	move.w	rotacc(a0),d0
	add.w	d0,rotvel(a0)
	move.w	rotvel(a0),d0
	add.w	d0,QuadAngle
	rts

; ---------------------------------------------------------------
; Subroutines to _update Quad's position
; ---------------------------------------------------------------

Quad_Move:
	move.l	xacc(a0),d0
	add.l	d0,xvel(a0)
	move.l	xvel(a0),d0
	add.l	d0,QuadX

	move.l	yacc(a0),d0
	add.l	d0,yvel(a0)
	move.l	yvel(a0),d0
	add.l	d0,QuadY

	rts

; ===============================================================
; ---------------------------------------------------------------
; SSRG Logo object
; ---------------------------------------------------------------

SSRG_Obj_Logo:
	move.w	#_Pat_Logo_St|_pal2|_pr,art(a0)
	move.l	#MapsBuffer,maps(a0)
	move.w	#$80+320+128,xpos(a0)
	move.w	#$80+$6F,ypos(a0)

; --------------------
; Logo intro sequence
; --------------------

	move.w	#10,timer(a0)		; set timer to 1 second
	move.l	#Logo_Intro,obj(a0)

Logo_Intro:

	; Wait a second before appearence
	jsr	Object_RunTimer

	; Logo rushes in!
	subq.w	#8,xpos(a0)

	; Check if logo has bumped the quad
	cmpi.w	#$80+160+48+8,xpos(a0)	; has logo reached the bump point?
	bne.s	.disp			; if not, branch
	move.l	#-$00044E00,xvel(a0)	; set_up slowdown physics
	move.l	#+$00003E00,xacc(a0)	;
	move.w	xpos(a0),xpos2(a0)	; copy X-coord
	move.l	#.Logo_Slowdown,obj(a0)
	st.b	ObjQuad+bumped		; tell quad that we've bumped
	moveq	#$FFFFFFAC,d0
	jsr	PlayMusic		; play bumping sound

.Logo_Slowdown:
	; Logo slowdowns after the bump
	jsr	Object_MoveX
	tst.w	xvel(a0)		; is velocity nearly zero?
	beq.s	.Logo_IntroDone		; if yes, branch

.disp	jmp	DisplaySprite

.Logo_IntroDone:

; ---------------------------
; The whole screen scales in
; ---------------------------

scene_pos	= $20	; w
scene_dmasrc	= $22	; l

	move.w	#60,timer(a0)		; set timer to 1 second
	clr.w	scene_pos(a0)
	move.l	#$FF0000,scene_dmasrc(a0)
	move.l	#Logo_ScaleScene,obj(a0)

Logo_ScaleScene:
	jsr	DisplaySprite

	; Wait a second first
	jsr	Object_RunTimer

	; Run scaling scene
	move.w	scene_pos(a0),d0
	lea	.SceneData(pc,d0),a2

	move.w	(a2)+,d3		; DATA -> Art pointer / DMA len
	bmi.s	.setart			; if art pointer, branch

	move.l	scene_dmasrc(a0),d0
	move.l	d0,d1			; d1 = Source Address
	ext.l	d3
	add.l	d3,d0			; calculate next DMA source address
	move.l	d0,scene_dmasrc(a0)
	move.w	#__vram_Logo_Dyn,d2	; d2 = Destination Address
	lsr.w	#1,d3			; d3 = DMA length (in words)
	jsr	QueueDMATransfer
	move.w	#_Pat_Logo_Dyn|_pal2|_pr,d3

.setart	move.w	d3,art(a0)

	moveq	#0,d0
	move.b	(a2)+,d0		; DATA -> Logo X-pos
	addi.w	#$80,d0
	move.w	d0,xpos(a0)		; store X-pos

	moveq	#0,d0
	move.b	(a2)+,d0		; DATA -> Logo Y-pos
	addi.w	#$80,d0
	move.w	d0,ypos(a0)		; store Y-pos

	move.b	(a2)+,frame(a0)		; DATA -> Frame

	move.b	(a2)+,QuadX+1		; DATA -> Quad X-pos
	move.b	(a2)+,QuadY+1		; DATA -> Quad Y-pos
	move.b	(a2)+,QuadRadius+1	; DATA -> Quad Radius

	; Set_up next scene
	addq.w	#8,scene_pos(a0)
	cmpi.w	#32*8,scene_pos(a0)	; is this the last frame in scene?
	beq.w	.Logo_ScaleDone		; if yes, branch
	rts

; ---------------------------------------------------------------
.SceneData:
	incbin	"#SSRG\SceneData.bin"

; ---------------------------------------------------------------
.Logo_ScaleDone:

; ------------------
; Logo does nothing
; ------------------

	st.b	ObjQuad+sceneok		; tell quad we're done here
	move.l	#DisplaySprite,obj(a0)
	rts


; ===============================================================
; ---------------------------------------------------------------
; SSRG Sonic object
; ---------------------------------------------------------------

SSRG_Obj_Sonic:

	move.w	#_Pat_Sonic,art(a0)
	move.l	#SSRG_Map_Sonic,maps(a0)
	move.w	#$E8,xpos2(a0)
	move.w	#$13C,ypos2(a0)

; ----------------------
; Sonic appears in quad
; ----------------------

	; Set_up appearence physics
	move.l	#+$00002800,yacc(a0)
	move.l	#-$00010000,xvel(a0)
	move.l	#-$00051000,yvel(a0)
	move.w	#16,timer(a0)
	move.l	#.Appearence,obj(a0)

.Appearence:
	jsr	DisplaySprite

	cmpi.w	#$C1,xpos(a0)		; has Sonic reached $C1 on X-axis?
	beq.s	.stopX			; if yes, branch
	jsr	Object_RunTimer		; create a delay before movement
.moveXY	jmp	Object_MoveXY		; move object with acceleration

.stopX	moveq	#0,d0
	move.l	d0,xvel(a0)		; clear X-velocity
	neg.l	yacc(a0)		; make Sonic rise slightly
	move.l	#.chkY,obj(a0)
	rts

.chkY	jsr	DisplaySprite

	cmpi.w	#$EE,ypos(a0)		; has Sonic reached $EE on Y-axis?
	seq	d0
	tst.w	yvel(a0)		; is Y-vel negative?
	smi	d1
	and.b	d0,d1
	beq.s	.moveXY			; if not, branch

	st.b	objQuad+sceneok		; tell the quad we're ready

; ----------------------------
; Sonic jumps out of the quad
; ----------------------------

	; Set_up jumping physics
	move.l	#-$00020000,xvel(a0)
	move.l	#+$00060000,yvel(a0)
	move.l	#+$00003000,xacc(a0)
	move.l	#-$0000C000,yacc(a0)
	move.l	#.JumpReady,obj(a0)

.JumpReady
	jsr	DisplaySprite

	tst.b	objQuad+sceneok		; is quad awaiting shits to happen?
	beq.s	.0
	rts

.0	cmpi.w	#$C1,xpos(a0)		; has Sonic reached $C1 on X-axis
	scc	d0
	tst.w	yvel(a0)		; is Y-vel negative?
	smi	d1
	and.b	d0,d1
	bne.s	.setjump

.move	jmp	Object_MoveXY		; move object with acceleration

.setjump
	; Set_up jump out physics
	move.l	#+$00040000,xvel(a0)
	moveq	#0,d0
	move.l	d0,xacc(a0)
	move.l	#-$00060000,yvel(a0)
	move.l	#+$00006000,yacc(a0)
	move.l	#.JumpOut,obj(a0)
	ori.w	#_pr,art(a0)

	st.b	objQuad+sceneok		; tell quad to zoom out
	moveq	#$FFFFFFA8,d0
	jsr	PlayMusic		; play ultra sound

.JumpOut:
	jsr	DisplaySprite

	cmpi.w	#$80+224+$60,ypos(a0)
	blo.s	.move
	rts

; ---------------------------------------------------------------
SSRG_Map_Sonic:
	dc.w	2

.xdisp = -$20
.ydisp = -$08

	dc.b	$F
;			YY   WH  Pal   TT   XX
	dc.b	.ydisp+$E0, $0E, $00, $00, $F8+.xdisp
	dc.b	.ydisp+$E0, $0A, $00, $0C, $18+.xdisp
	dc.b	.ydisp+$E8, $05, $00, $15, $30+.xdisp
	dc.b	.ydisp+$F8, $0F, $00, $19, $F8+.xdisp
	dc.b	.ydisp+$F8, $0F, $00, $29, $18+.xdisp
	dc.b	.ydisp+$F8, $02, $00, $39, $38+.xdisp
	dc.b	.ydisp+$18, $04, $00, $3C, $F8+.xdisp
	dc.b	.ydisp+$18, $0F, $00, $3E, $08+.xdisp
	dc.b	.ydisp+$18, $03, $00, $4E, $28+.xdisp
	dc.b	.ydisp+$F8, $0F, $20, $52, $E8+.xdisp
	dc.b	.ydisp+$38, $0F, $20, $62, $10+.xdisp
	dc.b	.ydisp+$20, $0B, $20, $72, $30+.xdisp
	dc.b	.ydisp+$40, $07, $20, $7E, $30+.xdisp
	dc.b	.ydisp+$58, $05, $20, $86, $18+.xdisp
	dc.b	.ydisp+$F8, $0F, $20, $8A, $18+.xdisp
	even

; ===============================================================
; ---------------------------------------------------------------
; Object - SSRG Title
; ---------------------------------------------------------------

SSRG_Obj_Title:
	move.w	#_Pat_Title|_pal3|_pr,art(a0)
	move.l	#SSRG_Map_Title,maps(a0)
	move.w	#24,timer(a0)
	move.w	#$20B,xpos2(a0)
	move.w	#$80+131,ypos(a0)

	; Set_up moving physics
	move.l	#+$00008000,xacc(a0)
	move.l	#-$000E8000,xvel(a0)

	move.l	#.Move,obj(a0)

        ; Move SSRG title object until it stops
.Move	jsr	Object_RunTimer
	jsr 	DisplaySprite
	tst.l	xvel(a0)
	beq.s	.MoveEnd
	jmp	Object_moveX

.MoveEnd:
	move.l	#DisplaySprite,obj(a0)
	rts

; ---------------------------------------------------------------
SSRG_Map_Title:
	dc.w	2

.xdisp = -$50
.ydisp =  $18

	dc.b	6
;			YY   WH  Pal   TT   XX
	dc.b	.ydisp+$E0, $0D, $00, $00, $F8+.xdisp
	dc.b	.ydisp+$E0, $0D, $00, $08, $18+.xdisp
	dc.b	.ydisp+$E0, $0D, $00, $10, $38+.xdisp
	dc.b	.ydisp+$E0, $0D, $00, $18, $58+.xdisp
	dc.b	.ydisp+$E0, $0D, $00, $20, $78+.xdisp
	dc.b	.ydisp+$E0, $09, $00, $28, $98+.xdisp
	even
; ==============================================================











; ==============================================================
; --------------------------------------------------------------
; Palettes
; --------------------------------------------------------------

SSRG_Palette:
	incbin	"#SSRG\Sonic_Pt1.pal"		; row 0
	incbin	"#SSRG\Sonic_Pt2.pal"		; row 1
	incbin	"#SSRG\Logo.pal"		; row 2
	incbin	"#SSRG\Title.pal"		; row 3

; ---------------------------------------------------------------
; Misc data
; ---------------------------------------------------------------

SSRG_LogoMaps:
	incbin	"#SSRG\LogoMaps.bin.kos"
	even

; --------------------------------------------------------------
; Grachics
; --------------------------------------------------------------

SSRG_Art_Sonic:
	incbin	"#SSRG\Sonic.4bpp.nem"
	even

SSRG_Art_Title:
	incbin	"#SSRG\Title.4bpp.nem"
	even

SSRG_Logo_Bank1:
	incbin	"#SSRG\Logo_Bnk1.4bpp.kos"

SSRG_Logo_Bank2:
	incbin	"#SSRG\Logo_Bnk2.4bpp.kos"
	even
