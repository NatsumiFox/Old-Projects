; equates for elemental shields
dplcframe =	oboff34
artoff =	oboff38
dplc =		oboff3C
; ---------------------------------------------------------------------------

Obj_Insta_Shield:
		move.l	#Map_InstaShield,mappings(a0)	; set mappings
		move.l	#DPLC_InstaShield,dplc(a0)	; set DPLC
		move.l	#ArtUnc_InstaShield,artoff(a0)	; set art

		move.b	#4,render(a0)			; set render flags
		move.w	#priority1,priority(a0)		; priority level 1
		move.b	#$18,width(a0)			; width
		move.b	#$18,height(a0)			; height
		move.w	#$79C,tile(a0)			; art tile
		move.w	#$F380,vramoff(a0)		; possibly VRAM address

		btst	#7,Object_RAM+tile.w
		beq.s	.nohigh				; branch if main player is on low plane
		bset	#7,tile(a0)			; set to high plane

.nohigh		move.w	#1,anim(a0)			; set animation num
		move.b	#-1,dplcframe(a0)		; reset loaded frame
		move.l	#.main,(a0)			; set object address

.main		movea.w	parent(a0),a2			; get parent's address
		btst	#1,shistatus(a2)
		bne.s	.rts				; branch if invincible

		move.w	xpos(a2),xpos(a0)
		move.w	ypos(a2),ypos(a0)		; get players x and y pos
		move.b	status(a2),status(a0)		; get players status
		andi.b	#1,status(a0)			; only get xflip bit

		tst.b	ReverseGravity_Flag.w
		beq.s	.norev				; branch if reverse gravity isnt active
		ori.b	#2,status(a0)			; flip uside down

.norev		andi.w	#$7FFF,tile(a0)			; clear high plane bit
		tst.w	tile(a2)
		bpl.s	.nohigh2			; branch if parent isn't on high plane
		ori.w	#$8000,tile(a0)			; set high plane bit

.nohigh2	lea	Ani_InstaShield,a1
		jsr	AnimateSprite			; animate this object
		cmpi.b	#7,frame(a0)
		bne.s	.notover			; branch if not end of animation

		tst.b	jumpmove(a2)
		beq.s	.notover			; branch if insta shield attack is over
		move.b	#2,jumpmove(a2)			; set as being over.

.notover	tst.b	frame(a0)
		beq.s	.dplc				; branch if first frame
		cmpi.b	#3,frame(a0)
		bne.s	.display			; branch if not 3rd frame

.dplc		bsr.w	LoadPLC_Shields			; load DPLC's
.display	jmp	DrawSprite			; display
.rts		rts
; ---------------------------------------------------------------------------

Obj_Fire_Shield:
		move.l	#Map_FireShield,mappings(a0)	; set mappings
		move.l	#DPLC_FireShield,dplc(a0)	; set DPLC
		move.l	#ArtUnc_FireShield,artoff(a0)	; set art

		move.b	#4,render(a0)			; set render flags
		move.w	#priority1,priority(a0)		; priority level 1
		move.b	#$18,width(a0)			; width
		move.b	#$18,height(a0)			; height
		move.w	#$79C,tile(a0)			; art tile
		move.w	#$F380,vramoff(a0)		; possibly VRAM address

		btst	#7,Object_RAM+tile.w
		beq.s	.nohigh				; branch if main player is on low plane
		bset	#7,tile(a0)			; set to high plane

.nohigh		move.w	#1,anim(a0)			; set animation num
		move.b	#-1,dplcframe(a0)		; reset loaded frame
		move.l	#.main,(a0)			; set object address

.main		movea.w	parent(a0),a2			; get parent's address
		btst	#1,shistatus(a2)
		bne.w	.rts				; branch if invincible
		cmpi.b	#$1C,anim(a2)
		beq.s	.rts				; branch if players animation is $1C

		btst	#0,shistatus(a2)
		beq.w	FireShield_Destroy		; branch if player doesn't have shield
		btst	#6,status(a2)
		bne.s	FireShield_DestroyUnderwater	; branch if player is underwater

		move.w	xpos(a2),xpos(a0)
		move.w	ypos(a2),ypos(a0)		; get players x and y pos
		tst.b	anim(a0)
		bne.s	.nohigh2			; branch if dashing animation

		move.b	status(a2),status(a0)		; get players status
		andi.b	#1,status(a0)			; only get xflip bit
		tst.b	ReverseGravity_Flag.w
		beq.s	.norev				; branch if reverse gravity isnt active
		ori.b	#2,status(a0)			; flip uside down

.norev		andi.w	#$7FFF,tile(a0)			; clear high plane bit
		tst.w	tile(a2)
		bpl.s	.nohigh2			; branch if parent isn't on high plane
		ori.w	#$8000,tile(a0)			; set high plane bit

.nohigh2	lea	Ani_FireShield,a1
		jsr	AnimateSprite
		move.w	#priority1,priority(a0)		; set priority 1
		cmpi.b	#$F,frame(a0)
		blo.s	.dplc				; branch if should display in front of player
		move.w	#priority4,priority(a0)		; set priority 4

.dplc		bsr.w	LoadPLC_Shields			; load DPLC's
		jmp	DrawSprite			; display
.rts		rts
; ---------------------------------------------------------------------------

FireShield_DestroyUnderwater:
		andi.b	#$8E,shistatus(a2)		; clear all shields
		jsr	CreateObject			; attempt to create an object
		bne.w	FireShield_Destroy		; branch if could not do so
		move.l	#Obj_FireShield_Dissipate,(a1)	; create shield dissipate obj
		move.w	xpos(a0),xpos(a1)		; copy xpos
		move.w	ypos(a0),ypos(a1)		; copy ypos

FireShield_Destroy:
		andi.b	#$8E,shistatus(a2)		; clear all shields
		move.l	#Obj_Insta_Shield,(a0)		; make this shield to be insta shield
		rts
; ---------------------------------------------------------------------------

Obj_Lightning_Shield:
		move.l	#ArtUnc_LightningSparks,d1
		move.w	#$F760,d2
		move.w	#(ArtUnc_LightningSparks_End-ArtUnc_LightningSparks)/2,d3
		jsr	AddQueueDMA			; load lightning shield sparks

		move.l	#Map_LighteningShield,mappings(a0); set mappings
		move.l	#DPLC_LighteningShield,dplc(a0)	; set DPLC
		move.l	#ArtUnc_LightningShield,artoff(a0); set art

		move.b	#4,render(a0)			; set render flags
		move.w	#priority1,priority(a0)		; priority level 1
		move.b	#$18,width(a0)			; width
		move.b	#$18,height(a0)			; height
		move.w	#$79C,tile(a0)			; art tile
		move.w	#$F380,vramoff(a0)		; possibly VRAM address

		btst	#7,Object_RAM+tile.w
		beq.s	.nohigh				; branch if main player is on low plane
		bset	#7,tile(a0)			; set to high plane

.nohigh		move.w	#1,anim(a0)			; set animation num
		move.b	#-1,dplcframe(a0)		; reset loaded frame
		move.l	#.main,(a0)			; set object address

.main		movea.w	parent(a0),a2			; get parent's address
		btst	#1,shistatus(a2)
		bne.w	.rts				; branch if invincible
		cmpi.b	#$1C,anim(a2)
		beq.s	.rts				; branch if players animation is $1C

		btst	#0,shistatus(a2)
		beq.s	Lightning_Destroy		; branch if player doesn't have shield
		btst	#6,status(a2)
		bne.s	Lightning_DestroyUnderwater	; branch if player is underwater

		move.w	xpos(a2),xpos(a0)
		move.w	ypos(a2),ypos(a0)		; get players x and y pos
		move.b	status(a2),status(a0)		; get players status
		andi.b	#1,status(a0)			; only get xflip bit

		tst.b	ReverseGravity_Flag.w
		beq.s	.norev				; branch if reverse gravity isnt active
		ori.b	#2,status(a0)			; flip uside down

.norev		andi.w	#$7FFF,tile(a0)			; clear high plane bit
		tst.w	tile(a2)
		bpl.s	.nohigh2			; branch if parent isn't on high plane
		ori.w	#$8000,tile(a0)			; set high plane bit

.nohigh2	tst.b	anim(a0)
		beq.s	.nosparks			; is double jump state?
		bsr.s	LightningSparks_Create		; create lightning shield sparks
		clr.b	anim(a0)			; create non-doublejump ani

.nosparks	lea	Ani_LightningShield,a1
		jsr	AnimateSprite			; animate

		move.w	#priority1,priority(a0)		; set priority 1
		cmpi.b	#$E,frame(a0)
		blo.s	.dplc				; branch if should display in front of player
		move.w	#priority4,priority(a0)		; set priority 4

.dplc		bsr.w	LoadPLC_Shields			; load DPLC's
		jmp	DrawSprite			; display
.rts		rts
; ---------------------------------------------------------------------------

Lightning_DestroyUnderwater:
		tst.b	PalCycle_Delay.w
		beq.s	LightningShield_FlashWater

Lightning_Destroy:
		andi.b	#$8E,shistatus(a2)		; clear all shields
		move.l	#Obj_Insta_Shield,(a0)		; make this shield to be insta shield
		rts

LightningShield_FlashWater:
		move.l	#LightningShield_Destroy,(a0)
		andi.b	#$8E,shistatus(a2)		; clear all shields

		lea	Water_Pal.w,a1			; get main palette
		lea	Water_Pal_FadeTo.w,a2		; get fade palette
		move.w	#($80/4)-1,d0			; full palette
.fillwhite	move.l	(a1),(a2)+			; copy palette
		move.l	#$EEE0EEE,(a1)+			; fill main one with white
		dbf	d0,.fillwhite			; do until done fully

		move.w	#0,-$40(a1)			; set backdrop to black?
		move.b	#3,anitime(a0)			; set delay
		rts
; ---------------------------------------------------------------------------

LightningSparks_Create:
		moveq	#1,d2

HyperSonicSparks_Create:
		lea	SparkVelocities,a2
		moveq	#4-1,d1				; 4 objects

.load		jsr	CreateObject.w			; try to create an object
		bne.s	.rts				; if failed, branch
		move.l	#Obj_LightningShield_Spark,(a1)
		move.w	xpos(a0),xpos(a1)
		move.w	ypos(a0),ypos(a1)		; copy x and y pos
		move.l	mappings(a0),mappings(a1)	; copy mappings
		move.w	tile(a0),tile(a1)		; copy art tile

		move.b	#4,render(a1)			; set render flags
		move.w	#$80,priority(a1)		; set priority
		move.b	#8,width(a1)			;
		move.b	#8,height(a1)			; set width and height

		move.b	d2,anim(a1)			; set animation ID
		move.w	(a2)+,xvel(a1)			; set xvel
		move.w	(a2)+,yvel(a1)			; set yvel
		dbf	d1,.load			; loop until done
.rts		rts

; ---------------------------------------------------------------------------
SparkVelocities:dc.w -$200, -$200
		dc.w  $200, -$200
		dc.w -$200,  $200
		dc.w  $200,  $200
; ---------------------------------------------------------------------------

Obj_LightningShield_Spark:
		jsr	ObjectMove			; move this object
		addi.w	#$18,yvel(a0)			; apply some gravity
		lea	Ani_LightningShield,a1
		jsr	AnimateSprite			; animate the sprute

		tst.b	routine(a0)
		bne.s	.del				; branch if animation ended
		jmp	DrawSprite			; render
.del		jmp	DeleteObject_This		; get rid of this object
; ---------------------------------------------------------------------------

LightningShield_Destroy:
		subq.b	#1,anitime(a0)
		bpl.s	.rts				; if delay isnt over, branch
		move.l	#Obj_Insta_Shield,(a0)		; make this insta shield

		lea	Water_Pal_FadeTo.w,a1		; get fade to pal
		lea	Water_Pal.w,a2			; get normal pal
		move.w	#($80/4)-1,d0			; full palette
.retpal		move.l	(a1)+,(a2)+			; copy palette back
		dbf	d0,.retpal			; loop until done
.rts		rts
; ---------------------------------------------------------------------------

Obj_Bubble_Shield:
		move.l	#Map_BubbleShield,mappings(a0)	; set mappings
		move.l	#DPLC_BubbleShield,dplc(a0)	; set DPLC
		move.l	#ArtUnc_BubbleShield,artoff(a0)	; set art

		move.b	#4,render(a0)			; set render flags
		move.w	#priority1,priority(a0)		; priority level 1
		move.b	#$18,width(a0)			; width
		move.b	#$18,height(a0)			; height
		move.w	#$79C,tile(a0)			; art tile
		move.w	#$F380,vramoff(a0)		; possibly VRAM address

		btst	#7,Object_RAM+tile.w
		beq.s	.nohigh				; branch if main player is on low plane
		bset	#7,tile(a0)			; set to high plane

.nohigh		move.w	#1,anim(a0)			; set animation num
		move.b	#-1,dplcframe(a0)		; reset loaded frame

		movea.w	parent(a0),a1			; get parent object
		bsr.w	Player_ResetAirTimer
		move.l	#.main,(a0)			; set object address

.main		movea.w	parent(a0),a2			; get parent's address
		btst	#1,shistatus(a2)
		bne.s	.rts				; branch if invincible
		cmpi.b	#$1C,anim(a2)
		beq.s	.rts				; branch if players animation is $1C

		btst	#0,shistatus(a2)
		beq.s	BubbleShield_Destroy		; branch if player doesn't have shield
		move.w	xpos(a2),xpos(a0)
		move.w	ypos(a2),ypos(a0)		; get players x and y pos
		move.b	status(a2),status(a0)		; get players status
		andi.b	#1,status(a0)			; only get xflip bit

		tst.b	ReverseGravity_Flag.w
		beq.s	.norev				; branch if reverse gravity isnt active
		ori.b	#2,status(a0)			; flip uside down

.norev		andi.w	#$7FFF,tile(a0)			; clear high plane bit
		tst.w	tile(a2)
		bpl.s	.nohigh2			; branch if parent isn't on high plane
		ori.w	#$8000,tile(a0)			; set high plane bit

.nohigh2	lea	Ani_BubbleShield,a1
		jsr	AnimateSprite			; animate
		bsr.w	LoadPLC_Shields			; load DPLC's
		jmp	DrawSprite			; display
.rts		rts
; ---------------------------------------------------------------------------

BubbleShield_Destroy:
		andi.b	#$8E,shistatus(a2)		; clear all shields
		move.l	#Obj_Insta_Shield,(a0)		; make this shield to be insta shield
		rts
; ---------------------------------------------------------------------------

LoadPLC_Shields:
		moveq	#0,d0
		move.b	frame(a0),d0		; get current frame
		cmp.b	dplcframe(a0),d0	; compare with last recorded frame
		beq.s	.rts			; branch if same (aka no new frame needs to be loaded)
		move.b	d0,dplcframe(a0)	; store last frame

		movea.l	dplc(a0),a2		; get the DPLC address
		add.w	d0,d0			; double the frame
		adda.w	(a2,d0.w),a2		; get data of DPLC entry

		move.w	(a2)+,d5		; get number of entries
		subq.w	#1,d5			; sub 1 from it
		bmi.s	.rts			; if negative, skip
		move.w	vramoff(a0),d4		; get VRAM address

.load		moveq	#0,d1
		move.w	(a2)+,d1		; get next entry
		move.w	d1,d3			; copy it
		lsr.w	#8,d3			; shift right 8 bits
		andi.w	#$F0,d3			; get only number of tiles
		addi.w	#$10,d3			; add 1 to it

		andi.w	#$FFF,d1		; get only tile offset
		lsl.l	#5,d1			; shift 5 times (to get absolute offset)
		add.l	artoff(a0),d1		; add art address to d1

		move.w	d4,d2			; copy VRAM address
		add.w	d3,d4			; add number of tiles
		add.w	d3,d4			; twice
		jsr	AddQueueDMA		; queue this art.
		dbf	d5,.load
.rts		rts

; ---------------------------------------------------------------------------
Ani_InstaShield:	include "levels/Players/Shields/Ani Insta Shield.asm"
Ani_FireShield:		include "levels/Players/Shields/Ani Fire Shield.asm"
Ani_LightningShield:	include "levels/Players/Shields/Ani Lightning Shield.asm"
Ani_BubbleShield:	include "levels/Players/Shields/Ani Bubble Shield.asm"
Map_FireShield:		include "levels/Players/Shields/Map Fire Shield.asm"
DPLC_FireShield:	include "levels/Players/Shields/DPLC Fire Shield.asm"
Map_LighteningShield:	include "levels/Players/Shields/Map Lightning Shield.asm"
DPLC_LighteningShield:	include "levels/Players/Shields/DPLC Lightning Shield.asm"
Map_BubbleShield:	include "levels/Players/Shields/Map Bubble Shield.asm"
DPLC_BubbleShield:	include "levels/Players/Shields/DPLC Bubble Shield.asm"
Map_InstaShield:	include "levels/Players/Shields/Map Insta Shield.asm"
DPLC_InstaShield:	include "levels/Players/Shields/DPLC Insta Shield.asm"
; ---------------------------------------------------------------------------
