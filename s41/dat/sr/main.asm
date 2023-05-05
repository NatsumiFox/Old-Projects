; ===========================================================================
; ---------------------------------------------------------------------------
; Sonic Retro Screen Mode for Sonic 1
; ---------------------------------------------------------------------------
; Coded By:		Marc Gordon (AKA Cinossu)
; Last Modified:	27/01/2008
; ---------------------------------------------------------------------------
; Important pieces of code to edit:
;
; Line 64	-	Music # to play
; Line 88	-	Number of frames to wait until screen auto-exits
; Line 106	-	Jump to title screen at exit
; ---------------------------------------------------------------------------
; main object variables.
	rsset 0		; set __rs to 0
		rs.l 1; $00 ; long ; object ID. Is actually direct address of the object in ROM.
render		rs.b 1; $04 ; byte ; flags used to render the object, but BuildSprites. See Status.
rtn		rs.b 1; $05 ; byte ; routine ID of the object, usually multiple of 2. Not necessary for many objects in S3K anymore. see ID.
height		rs.b 1; $06 ; byte ; height of the object in pixels.
width		rs.b 1; $07 ; byte ; width of the object in pixels.
prio		rs.w 1; $08 ; word ; priority of the object. Multiple of $80 ($80 = 1, $380 = 7)
tile		rs.w 1; $0A ; word ; tile setup to display. Usually known as Art_Tile.
map		rs.l 1; $0C ; long ; ROM offset of the mappings.
xpos		rs.l 1; $10 ; long ; the horizontal pixel and subpixel coordinate of the object. Some objects only use first word
ypos		rs.l 1; $14 ; long ; the vertical pixel and subpixel coordinate of the object. Some objects only use first word
xvel		rs.w 1; $18 ; word ; the horizontal speed of an object in moving objects.
yvel		rs.w 1; $1A ; word ; the vertical speed of an object in moving objects.
inertia		rs.w 1; $1C
yrad		rs.b 1; $1E ; byte ; the vertical radius of an object
xrad		rs.b 1; $1F ; byte ; the horizontal radius of an object
anim		rs.b 1; $20 ; byte ; animation ID of an object
anilast		rs.b 1; $21 ; byte ; animation ID for last frame. If not same as anim, animation starts from the start.
frame		rs.b 1; $22 ; byte ; mappings frame to use. Animation routines will write the frame to use next.
anioff		rs.b 1; $23 ; byte ; animation offset. Next animation data will be read from this offset
anitime		rs.w 1; $24 ; byte ; time until next animation frame should be shown.
angle		rs.w 1; $26 ; word ; angle of the object in scale of 0-255
coll		rs.b 1; $28 ; byte ; type of the objects collision. 2 high bits determine type, rest of the bits determine size. 0 = no collision
col2		rs.b 1; $29 ; byte ; secondary counter. Bosses use this as the hit counters. Some objects may have other uses
stat		rs.b 1; $2A ; byte ; few bits describing things about the object. Few of these bits are transferred to render as well, namely flip bits.
	rsset $34
dplc_lastfr	rs.l 1; $34 ; byte ; last frame loaded with DPLC
dplc_art	rs.l 1; $38 ; long ; the art pointer for this DPLC
dplc_dplc	rs.l 1; $3C ; long ; the DPLC pointer for this DPLC
dplc_vram	rs.w 1; $40 ; word ; the VRAM pointer for this DPLC
parent		rs.w 1; $42 ; word ; the parent of this object

; offsets used by child sprites
childnum	= $16		; $16 ; word ; number of child sprites
childdata	= childnum+2	; $18 ; data of child sprites. See below

	rsset 0
child_x		rs.w 1; word ; x-offset of the child sprite
child_y		rs.w 1; word ; y-offset of the child sprite
		rs.b 1; unused
child_frm	rs.b 1; byte ; mappings frame of the child sprite
child_sz	rs.b 0; size of a single child sprite

; ===========================================================================
; ---------------------------------------------------------------------------
; Sonic Retro Screen Mode
; ---------------------------------------------------------------------------

SRetro:
		move.b	#S3Dat-ROMdat,-4.w

	; the reason we have to do is, because MED overwrites this region with whatever
	; and then the code in Sonic 3's NemDec queue thinks there are entries to load
	; it instead loads garbage, may cause RAM overflow, make the game crash
	; or just load garbage or blank shit. So yes, remember to call this routine
	; fucking 2 hours debugging to find out this was the cause
	; fuck my life guys, fuck my life.
	; never occurs on emulators because on hard reset shit is cleared, and in
	; soft reset I skip this splash screen. Fucking wonderful, isn't it? >_>
		jsr	ClearPLC	; CLEAR PLC!!! IMPORTANT, DO NOT REMOVE

		lea	S1_Z80Drv,a0
		jsr	S1_SndDrvLoad
		move.l	#$380000,$FFFFFFC4.w
		jsr	S1_SndDrv
		jsr	ClearScreen.w
		lea	$FF0000,a1
		lea	Kos_SR,a0 			; load Sonic Retro Logo patterns
		jsr	KosDec_
		lea	Kos_SR_Emerald,a0 		; load Sonic Retro Emerald patterns
		jsr	KosDec_

		move.l	VDP_Control_Port.w,a5
	vdpcomm move.l,2,CRAM,WRITE,(a5)
		move.l	#0,-4(a5)
	dma68kToVDP $FF0000,$0000,($AA0+$1C80),VRAM

		lea	$ABFF0000,a1
		lea	Map_SR(pc),a0
		jsr	EniDec.w

		move.l	#$3F00,$FFFFF626.w
		jsr	PalFill_Black.w
		move.b	#$16,($FFFFF62A).w		;
		jsr	VSync.w				; update palette
	di

		lea	$ABFF0000,a1
	vdpcomm	move.l,$C000,VRAM,WRITE,d0
		moveq	#320/8-1,d1
		moveq	#224/8-1,d2
		jsr	MapToPlane.w

		lea	$FFFFFB00.w,a1
		move.l	a1,$FFFFFBFC.w
		clr.w	(a1)

		clr.w	$FFFFFE10.w
		clr.b	$FFFFF711.w	; do not render hud or rings
		clr.w	$FFFFFFD8.w

		lea	$FFFFAC00.w,a1
		moveq	#0,d0
		move.w	#($D000-$AC00)/4-1,d1
.clr		move.l	d0,(a1)+
		dbf	d1,.clr

		lea	$FFFFF000.w,a1
		move.w	#$600/4-1,d1
.clr2		move.l	d0,(a1)+
		dbf	d1,.clr2

		lea	Pal_SR(pc),a1
		lea	$FFFFFC80.w,a2
		jsr	LoadPal_2Lines(pc)

		move.l	#ObjSR_JapanText,$FFFFB000+($4A*0).w
		move.l	#ObjSR_Emerald,$FFFFB000+($4A*1).w

		jsr	RandomNumber.w
		andi.w	#$0C,d0
		jsr	SRetroOffs(pc,d0.w)
		jsr	ResetSpriteList

	rept 2
		bsr.s	SR_RunFrame
	endr

		move.b	#$94,($FFFFF00A).w		; play music
		jsr	PalFade_InBlack.w
		move.w	#$340,$FFFFF614.w

SRetro_Loop:
		bsr.s	SR_RunFrame
		tst.w	$FFFFF614.w
		beq.s	SRetro_Exit
		tst.b	($FFFFF605).w
		bpl.s	SRetro_Loop

SRetro_Exit:
		move.b	#$E4,($FFFFF00A).w		; stop music
		bsr.s	SR_RunFrame
		move.b	#SKROM/$080000,$A130FB
		jsr	PalFade_OutBlack.w
		jmp	SSRG(pc)
; ---------------------------------------------------------------------------

SRetroOffs:
		bra.w	SR_Spike
		bra.w	SR_KnuxPush
		bra.w	SR_Glitch
		bra.w	SR_Blue

SR_RunFrame:
		move.b	#$16,($FFFFF62A).w
		jsr	VSync.w
		lea	$FFFFB000.w,a0
		jsr	ProcessObjects
		jsr	BuildSprites
		jmp	S1_SndDrv

LoadPal_2Lines:
	rept $20/4
		move.l	(a1)+,(a2)+
	endr

LoadPal_Line:
	rept $20/4
		move.l	(a1)+,(a2)+
	endr
		rts

; ---------------------------------------------------------------------------
SR_Glitch:
		move.l	#ObjSR_SonicWave,$FFFFB000+($4A*2).w
		move.l	#ObjSR_SonicGlitch,$FFFFB000+($4A*3).w
		lea	Pal_Sonic,a1
		bra.s	LoadPal_Line

SR_Blue:
		move.l	#ObjSR_TailsWave,$FFFFB000+($4A*2).w
		move.l	#$E620E84,2-(4*16)(a2)
		move.w	#$C40,16*2(a2)
		lea	Pal_Sonic,a1
		bra.s	LoadPal_Line

SR_Pal_SonicKnux:
		lea	Pal_Sonic,a1
		bsr.s	LoadPal_Line
		add.w	#Pal_Knuckles-(Pal_Sonic+(16*2)),a1
		bra.s	LoadPal_Line

SR_KnuxPush:
		move.b	#SKROM/$080000,$A130F7
		move.b	#SKROM/$080000+2,$A130FB
		move.l	#ObjSR_EmeraldHalves,$FFFFB000+($4A*1).w
		move.l	#ObjSR_KnuxPush,$FFFFB000+($4A*2).w
		bra.s	SR_Pal_SonicKnux

SR_Spike:
		bsr.s	SR_Pal_SonicKnux
		move.l	#ObjSR_Spike,$FFFFB000+($4A*2).w
		move.l	#ObjSR_SonicSpike,$FFFFB000+($4A*3).w
		move.l	#ObjSR_Dust,$FFFFB000+($4A*4).w
		move.w	#$B000+($4A*3),$FFFFB000+($4A*4)+parent.w
	vdpcomm move.l,$2720,VRAM,WRITE,(a5)
		lea	Nem_SpikesSprings,a0
		jmp	NemDec.w

; ===========================================================================
Map_SR:		incbin "dat/sr/logo.map.eni"
Pal_SR:		incbin "dat/sr/sr.pal"

; ===========================================================================
SR_DelObj:
		jmp	DeleteObject

; ---------------------------------------------------------------------------
; child loader routine
; ---------------------------------------------------------------------------
SR_SetChildDat:
		move.l	(sp)+,a1		; load offset to read from
		lea	childnum(a0),a2		; get offset to write to
		move.w	(a1)+,d0		; get number of children
		move.w	d0,(a2)+		; save number of children
		subq.w	#1,d0			; get for dbf
		bcs.s	.done			; if borrow was set, 0 children

.copy		move.l	(a1)+,(a2)+		; copy x and y-positions
		move.w	(a1)+,(a2)+		; copy frame and null byte
		dbf	d0,.copy		; copy until all entries are copied
.done		jmp	(a1)			; then return execution
; ---------------------------------------------------------------------------
; Emerald
; ---------------------------------------------------------------------------

ObjSR_EmeraldHalves:
		bsr.s	SR_SetChildDat
	dc.w 2
	dc.w  $61, $112, 3
	dc.w $1E0, $102, 2

		bsr.s	SR_LoadObjDat		; load generic object data
	dc.b $40, 1
.xoff	dc.w $193, $102, 7*$80, $20E4
	dc.l Map_SR_Emerald, DisplayObj

ObjSR_Emerald:
		bsr.s	SR_LoadObjDat		; load generic object data
	dc.b 0, 0
	dc.w $193, $102, 7*$80, $20E4
	dc.l Map_SR_Emerald, DisplayObj

; ---------------------------------------------------------------------------
; Misc objects
; ---------------------------------------------------------------------------

ObjSR_SonicGlitch:
		pea	ObjSR_SG_DoMap(pc)
		move.l	#$20010,Scalers.w
		move.w	#$90,$48(a0)
		bsr.s	SR_LoadObjDat		; load generic object data
	dc.b 0, 0
	dc.w $192-$60, $DE-$40, 2*$80, 0
	dc.l Scalers, ObjSR_SG_Init

ObjSR_Spike:
		bsr.s	SR_LoadObjDat		; load generic object data
	dc.b 0, 4
	dc.w $1D0, $104, 3*$80, $4139
	dc.l Map_Spikes, DisplayObj
; ---------------------------------------------------------------------------
; object loader routine
; ---------------------------------------------------------------------------
SR_LoadObjDat:
		move.l	(sp)+,a1		; load offset to read from
		move.b	(a1)+,render(a0)	; load render flags
		move.b	(a1)+,frame(a0)		; load frame number
		move.w	(a1)+,xpos(a0)		; load x-position
		move.w	(a1)+,ypos(a0)		; load y-position
		move.l	(a1)+,prio(a0)		; load priority and tile
		move.l	(a1)+,map(a0)		; load mappings ptr
		move.l	(a1)+,a1		; load routine to run
		move.l	a1,(a0)			; save as the object address
		jmp	(a1)			; and execute!

; ---------------------------------------------------------------------------
; Japan Text on Logo
; ---------------------------------------------------------------------------
ObjSR_JapanText:
		bsr.s	SR_LoadObjDat		; load generic object data
	dc.b 0, 0
	dc.w $124, $FF, 7*$80, 0
	dc.l Map_SR_JP, DisplayObj

ObjSR_SpikeWait:
		subq.w	#1,$48(a0)
		bmi.s	.k
		rts

.k		move.l	#.move,(a0)
.move		subq.w	#2,xpos(a0)
		cmp.w	#$1B0,xpos(a0)
		bgt.s	ObjSR_Disp
		move.l	#DisplayObj,(a0)

ObjSR_Disp:
		jmp	DisplayObj

ObjSR_SG_Init:
		subq.w	#1,$48(a0)
		bpl.s	ObjSR_SG_RTS
		cmp.w	#-9,$48(a0)
		bgt.s	ObjSR_Disp
		move.w	#7,$48(a0)

	; generate maps
ObjSR_SG_DoMap:
		lea	Scalers+4.w,a1
		moveq	#16-1,d2

.loop		jsr	RandomNumber.w
		andi.w	#$7F0F,d0
		move.w	d0,(a1)+

		jsr	RandomNumber.w
		andi.w	#$60FF,d0
		move.w	d0,d1
		andi.w	#$6000,d1
		cmp.w	#$6000,d1
		bne.s	.ok
		bclr	#13,d0
.ok		move.w	d0,(a1)+

		jsr	RandomNumber.w
		andi.w	#$007F,d0
		move.w	d0,(a1)+
		dbf	d2,.loop

ObjSR_SG_RTS:
		rts

; ---------------------------------------------------------------------------
; Sonic and Knuckles in Spike cutscene
; ---------------------------------------------------------------------------
ObjSR_SS_Init:
		move.w	#60*2,$48(a0)		; delay before start
		move.l	#ObjSR_SS_Wait,(a0)

ObjSR_SS_Wait:
		subq.w	#1,$48(a0)
		bmi.s	ObjSR_SS_Main
		rts

ObjSR_SS_Main:
		move.l	#.main,(a0)
		move.l	#ObjSR_SpikeWait,-$4A(a0)
		move.w	#40,-2(a0)
.main		cmp.w	#$158,xpos(a0)
		blt.s	.move
		move.b	#1,anim(a0)
		move.l	#.slow,(a0)

.slow		sub.w	#$40,xvel(a0)
		cmp.w	#$194,xpos(a0)
		blt.s	.move

		move.l	#.fall,(a0)
		clr.w	xvel(a0)
		move.w	#-$700,yvel(a0)
		move.b	#2,anim(a0)

.fall		addi.w	#$38,yvel(a0)
		cmp.w	#$170,ypos(a0)
		blt.s	.move
		move.l	#ObjSR_SS_Knux,(a0)

.move		jsr	ObjMove
		lea	AniSR_Sonic(pc),a1

ObjSR_AnimateDPLC:
		jsr	AnimatePlayer
		jsr	LoadDPLC
		jmp	DisplayObj

ObjSR_KnuxAni:
		st	$FFFFEF3A.w		; mask sprites
		lea	AniKnuckles+$100000,a1
		bra.s	ObjSR_AnimateDPLC

ObjSR_TailsAni:
		lea	AniTails,a1
		bra.s	ObjSR_AnimateDPLC

ObjSR_SW_Init:
		subq.w	#1,$48(a0)
		bpl.s	.ani
		cmp.w	#-8,$48(a0)
		bgt.s	ObjSR_SW_RTS
		move.w	#8,$48(a0)

		lea	Pal_Knuckles,a1
		lea	$FFFFFC40.w,a2
		jmp	LoadPal_Line(pc)

.ani		lea	AniSonic+$200000,a1
		bra.s	ObjSR_AnimateDPLC

ObjSR_KnPu:
		st	$FFFFEF3A.w		; mask sprites
		subq.b	#1,$49(a0)		; sub 1 from timer
		bpl.s	.move			; if positive, move
		cmp.b	#-15,$49(a0)		; check if we are at low bound
		bgt.s	.disp			; if not, display
		move.b	#10-1,$49(a0)		; reset timer

.move		sub.l	#$5556,xpos(a0)		; sub 0.25 from offset
		cmp.w	#$193+$28,xpos(a0)	; check x-position
		bgt.s	.disp			; branch if we are not finished
		move.w	#$193+$28,xpos(a0)	; set the x-position to exact
		pea	.setani(pc)		; set animation after running ani scripts

.disp		move.w	xpos(a0),d0		; get x-position of this object
		sub.w	#$28,d0			; move in front of the object
		move.w	d0,$FFFFB04A+childdata+child_sz+child_x.w; save as emerald child 2 x-position
.ani		lea	AniSR_Knux(pc),a1
		bra.w	ObjSR_AnimateDPLC

.setani		move.w	#$500,anim(a0)		; set animation
		move.l	#ObjSR_KnuxAni,(a0)	; display this obj
ObjSR_SW_RTS:
		rts

; ---------------------------------------------------------------------------
AniSR_Sonic:
		dc.w AniSRC_Run-AniSR_Sonic, AniSRS_Skid-AniSR_Sonic, AniSRS_Death-AniSR_Sonic

AniSR_Knux:
		dc.w AniSRK_Jump2-AniSR_Knux, AniSRS_Skid-AniSR_Sonic, AniSRK_Laugh-AniSR_Knux
		dc.w AniSRK_Push-AniSR_Knux

AniSRS_Skid:	dc.b 3, $9D, $9E, $9F, $A0, $FD, 0
AniSRS_Death:	dc.b $20, $A7, $FF
AniSRK_Laugh:	dc.b 7, $1C, $1D, $1E, $1F, $FE, 2
AniSRK_Jump2:	dc.b 3, $08, $04, $08, $05, $08, $06, $08, $07, $FF
AniSRC_Jump2:	dc.b 3, $9A, $96, $9A, $97, $9A, $98, $9A, $99, $FF
AniSRC_Run:	dc.b 3, $21, $22, $23, $24, $FF
AniSRK_Push:	dc.b 8, $CE, $CF, $D0, $D1, $FF
		even
; ---------------------------------------------------------------------------

ObjSR_K_Wait:
		move.w	#30,$48(a0)		; delay before start
		move.l	#.wait,(a0)

.wait		subq.w	#1,$48(a0)
		bmi.s	ObjSR_K_Main
		rts

ObjSR_K_Main:
		move.l	#.main,(a0)
.main		cmp.w	#$E0,ypos(a0)
		bge.s	.move
		move.l	#.mvback,(a0)

.mvback		sub.w	#$20,xvel(a0)
		cmp.w	#$1AC,xpos(a0)
		bge.s	.move
		move.l	#.waitstop,(a0)

.waitstop	add.w	#$20,xvel(a0)
		cmp.w	#$198,xpos(a0)
		ble.s	ObjSR_SS_KnuxLaugh

.move		jsr	ObjFall

ObjSR_SS_KnuxDisp:
		lea	AniSR_Knux(pc),a1
		jsr	AnimatePlayer
		lea	ObjSR_SS_Knux_Offs(pc),a2
		jsr	$536B6
		jmp	DisplayObj

ObjSR_SS_KnuxLaugh:
		move.b	#2,anim(a0)
		bra.s	ObjSR_SS_KnuxDisp

ObjSR_KnWait:
		st	$FFFFEF3A.w		; mask sprites
		subq.w	#1,$48(a0)
		bmi.s	.done
		rts

.done		move.l	#ObjSR_KnPu,(a0)
		rts

ObjSR_SS_Knux:
		move.w	#-$508,yvel(a0)
		bsr.s	SR_LoadDPLCObjDat	; load DPLC'd object data
	dc.b 0, 0
	dc.w $1D0, $100, 2*$80, $6680, $D000
ObjSR_SS_Knux_Offs:
	dc.l $182DC6, $16430E, $164016, ObjSR_K_Wait

ObjSR_SonicSpike:
		move.w	#$600,xvel(a0)
		bsr.s	SR_LoadDPLCObjDat	; load DPLC'd object data
	dc.b 0, 0
	dc.w $40, $100, 2*$80, $4680, $D000
	dc.l ArtUnc_Sonic_, DPLC_Sonic, Map_Sonic, ObjSR_SS_Init

; ---------------------------------------------------------------------------
; Knuckles in Emerald push cutscene
; ---------------------------------------------------------------------------
ObjSR_KnuxPush:
		move.w	#2*60,$48(a0)
		bsr.s	SR_LoadDPLCObjDat	; load DPLC'd object data
	dc.b 1, 3
	dc.w $208, $100, 3*$80, $6680, $D000
	dc.l ArtUnc_Knux+$100000, PLC_Knuckles+$100000, Map_Knuckles+$100000, ObjSR_KnWait

; ---------------------------------------------------------------------------
; DPLC object loader routine
; ---------------------------------------------------------------------------
SR_LoadDPLCObjDat:
		st	anilast(a0)		; clear last animation
		st	dplc_lastfr(a0)		; clear last frame

		move.l	(sp)+,a1		; load offset to read from
		move.b	(a1)+,stat(a0)		; load status flags
		move.b	(a1)+,anim(a0)		; load animation number
		move.w	(a1)+,xpos(a0)		; load x-position
		move.w	(a1)+,ypos(a0)		; load y-position
		move.l	(a1)+,prio(a0)		; load priority and tile
		move.w	(a1)+,dplc_vram(a0)	; load VRAM pointer
		move.l	(a1)+,dplc_art(a0)	; load art pointer
		move.l	(a1)+,dplc_dplc(a0)	; load DPLC pointer
		move.l	(a1)+,map(a0)		; load mappings ptr
		move.l	(a1)+,a1		; load routine to run
		move.l	a1,(a0)			; save as the object address
		jmp	(a1)			; and execute!

; ---------------------------------------------------------------------------
; Sonic in glitch cutscene
; ---------------------------------------------------------------------------
ObjSR_SonicWave:
		move.w	#$90,$48(a0)
		bsr.s	SR_LoadDPLCObjDat	; load DPLC'd object data
	dc.b 1, $13
	dc.w $192, $DE, 2*$80, $4680, $D000
	dc.l ArtUnc_Sonic_, DPLC_Sonic, Map_Sonic, ObjSR_SW_Init

ObjSR_TailsWave:
		bsr.s	SR_LoadDPLCObjDat	; load DPLC'd object data
	dc.b 1, $13
	dc.w $192, $E2, 2*$80, $4680, $D000
	dc.l ArtUnc_Tails_, DPLC_Tails, Map_Tails, ObjSR_TailsAni

; ---------------------------------------------------------------------------
; Dash dust
; ---------------------------------------------------------------------------
ObjSR_Dust:
		bsr.s	SR_LoadDPLCObjDat		; load generic object data
	dc.b 0, 0
	dc.w 0, 0, 1*$80, $47E0, $FC00
	dc.l ArtUnc_Dust, DPLC_Dust, Map_Dust, ObjSR_D_Wait

ObjSR_D_Skiddust:
		move.w	parent(a0),a2		; get parent obj
		lea	Ani_Dust,a1
		jsr	AnimateObj

		tst.b	rtn(a0)
		bne.w	SR_DelObj
		bra.s	ObjSR_D_Display

ObjSR_D_Wait:
		move.w	parent(a0),a2		; get parent obj
		cmp.b	#1,anim(a2)		; check if we are skidding
		beq.s	ObjSR_D_Skid		; enable skidding
		clr.b	frame(a0)		; clear frame

ObjSR_D_Display:
		jsr	LoadDPLC
		jmp	DisplayObj

ObjSR_D_Skid:
		move.b	#$15,frame(a0)
		subq.b	#1,$49(a0)
		bpl.s	ObjSR_D_Display
		move.b	#4-1,$49(a0)
		jsr	LoadObject		; load object
		bne.s	ObjSR_D_Display		; if couldnt, branch

		move.l	xpos(a2),xpos(a1)
		move.l	ypos(a2),ypos(a1)
		add.w	#$10,ypos(a1)
		move.b	#3,anim(a1)

		move.l	map(a0),map(a1)
		move.b	render(a0),render(a1)
		move.l	prio(a0),prio(a1)
		move.w	parent(a0),parent(a1)
		move.w	dplc_vram(a0),dplc_vram(a1)
		move.l	dplc_art(a0),dplc_art(a1)
		move.l	dplc_dplc(a0),dplc_dplc(a1)

		move.l	#ObjSR_D_Skiddust,(a1)
		bra.s	ObjSR_D_Display
; ===========================================================================
; ---------------------------------------------------------------------------
; Sonic Retro Logo Object Mappings
; ---------------------------------------------------------------------------

; Japan Text on Logo Mappings
Map_SR_JP:
	dc.w .0-Map_SR_JP
.0	dc.w 3
	dc.b 0, $E, 0, $C0, 0, 0
	dc.b 0, $E, 0, $CC, 0, $20
	dc.b 0, $E, 0, $D8, 0, $40

; Emerald Mappings
Map_SR_Emerald:
	dc.w .0-Map_SR_Emerald, .1-Map_SR_Emerald, .2-Map_SR_Emerald, .mask-Map_SR_Emerald

.0	dc.w 4
	dc.b $F0, $F, 0, 0, $FF, $E0
	dc.b $F0, $F, 0, $10, 0, 0
	dc.b 8, 8, 0, $20, $FF, $C8
	dc.b 8, 8, 8, $20, 0, $20

.1	dc.w 4
	dc.b 0, $D, 0, $45, $FF, $E0
	dc.b 0, $D, 0, $4D, 0, 0
	dc.b 8, 8, 0, $20, $FF, $C8
	dc.b 8, 8, 8, $20, 0, $20

.2	dc.w 3
	dc.b $F0, $F, 0, $23, $FF, $E0
	dc.b $F0, $F, 0, $33, 0, 0
	dc.b $10, 4, 0, $43, $FF, $F8

; this is a masked sprite, used in Knuckles push version. Hides the emerald bottom.
.mask	dc.w 2
	dc.w 1, $7C0-$20E4, 0	; sprite to activate mask
	dc.w 1, -$20E4, 0	; sprite that masks

; ===========================================================================
; EOF
