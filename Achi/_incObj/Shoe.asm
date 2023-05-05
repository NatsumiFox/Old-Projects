ShoePal	macro pal
		lea	v_pal_dry+$62.w,a1	; get pal data to a1
		lea	\pal(pc),a2		; get palette to a2

	rept 28/4
		move.l	(a2)+,(a1)+
	endr
		move.w	(a2)+,(a1)+
    endm

ShoePal2_	macro pal
		lea	v_pal_dry+$22.w,a1	; get pal data to a1
		lea	\pal,a2			; get palette to a2

	rept 20/4
		move.l	(a2)+,(a1)+
	endr
    endm

ShoePal2	macro pal
		lea	v_pal_dry+$22.w,a1	; get pal data to a1
		lea	\pal(pc),a2		; get palette to a2

	rept 20/4
		move.l	(a2)+,(a1)+
	endr
    endm

ShFadePal	macro pal
	move.w	ShoeFader(a0),a1		; get the address of the object
	move.l	#\pal,FaderShoeAddr(a1)		; save palette address
    endm

Sh2FadePal	macro pal
	move.w	ShoeFader(a0),a1		; get the address of the object
	move.l	#\pal,FaderSecAddr(a1)		; save palette address
    endm

ShoeLeft =	$2200
ShoeRight =	ShoeLeft+320
ShoeTop =	$300
ShoeBot =	ShoeTop+224

BossColStore =	ObMap		; stored collision type for later use
BossTgtX =	$0A
BossTgtY =	$0E
BossSpeed =	$14
BossChildCt =	obAniFrame	; num of loaded children
BossChild =	obSubtype	; address of child loaded
BossX =		$30
ShoeFader =	$34		; fade object addr
BossY =		$38
BossDelay =	$3C
BossFlash =	$3E
BossSine =	$3F
Parent =	obInertia

	dc.b "this is not how one should code a boss, btw."

BossShoe:
		move.w	#$6400,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#$20,obActWid(a0)
		move.b	#$14,obHeight(a0)
		move.b	#$F,obColType(a0)
		move.b	#10,obColProp(a0) 	; set number of hits to 10

		move.w	obX(a0),BossX(a0)
		move.w	obY(a0),BossY(a0)
		move.w	obY(a0),BossTgtY(a0)
		move.w	#ShoeRight-160,BossTgtX(a0)
		move.w	#$180,BossSpeed(a0)
		clr.b	mComm+6.w		; clear flag

		move.l	#Shoe_Init,(a0)		; set main routine
		move.l	#$0F000000|Map_Shoe,obMap(a0); set mappings
	ShoePal	Pal_Shoe			; load palette
	display	3, a0

		jsr	FindFreeObj		; load object
	;	bpl.s	Shoe_Init		; if failed, branch
		move.l	#ShoePalFader,(a1)	; load the pal fader object
		move.w	a1,ShoeFader(a0)	; save addr
		st	FaderShoeLast(a1)	; set to fake routine

Shoe_Init:
		jsr	ShoeChkClose(pc)	; check if Shoe is near this area
		bhs.w	Shoe_Display		; if not, branch

Shoe_GetAttack:
	ShFadePal Pal_Shoe			; set shoe to normal


@try		jsr	RandomNumber		; get random number
		and.w 	#$E,d0			; only 8 routines
		move.w	@rout(pc,d0.w),d0	; get offset

		cmp.w	FaderShoeLast(a1),d0	; check if we ran this last
		beq.s	@try			; if so, try again
		move.w	d0,FaderShoeLast(a1)	; else save it back
		jmp	Shoe_Target(pc,d0.w)	; jump to routine

@rout	dc.w Shoe_Target-Shoe_Target
	dc.w Shoe_Spikes-Shoe_Target
	dc.w Shoe_CreateArmors-Shoe_Target
	dc.w Shoe_Drop-Shoe_Target
	dc.w Shoe_Target-Shoe_Target
	dc.w Shoe_Drop-Shoe_Target
	dc.w Shoe_Spikes-Shoe_Target
	dc.w Shoe_Target-Shoe_Target
; ===========================================================================
BossTargetCount	= BossChildCt

Shoe_Target:
		jsr	RandomNumber		; get random number
		and.w	#3,d0			; only 0-3
		addq.b	#2,d0			; add 3, so proper range is 2-6
		move.b	d0,BossTargetCount(a0)	; save it as the counter

@position	move.l	#@mvpos,(a0)
		move.w	#$240,BossSpeed(a0)	; set faster speed
		move.w	#ShoeBot-$90,BossTgtY(a0); set rough target y

		move.w	BossX(a0),d1		; get x-pos
		move.w	d1,d2			; copy x-pos
		sub.w	v_player+obX.w,d1	; compare player x-pos to that
		bpl.s	@ahead			; if still positive, we move right

		moveq	#$FFFFFFA0,d3		; set angle
		sub.w	#$20,d2			; move back only by $20px
		cmp.w	#-$80,d1		; check if diff is less than $80px
		blt.s	@done			; if so, branch
		moveq	#$FFFFFF80,d3		; set angle
		sub.w	#$60,d2			; move back by $80px
		bra.s	@done

@ahead		moveq	#$FFFFFFE0,d3		; set angle
		add.w	#$20,d2			; move forward only by $20px
		cmp.w	#$80,d1			; check if diff is less than $80px
		bgt.s	@done			; if so, branch
		moveq	#$00,d3			; set angle
		add.w	#$60,d2			; move back by $80px

@done		move.b	d3,obAngle(a0)		; save angle
		cmp.w	#ShoeLeft+$30,d2	; check if pos is less than leftmost pos
		bge.s	@leok			; if not, bra

		sub.w	#ShoeLeft+$30,d2	; get the difference
		add.w	d2,BossTgtY(a0)		; and move up by that difference
		move.w	#ShoeLeft+$30,BossTgtX(a0); this be target x
		bra.s	@gotx

@leok		cmp.w	#ShoeRight-$30,d2	; check if pos is less than rightmost pos
		ble.s	@riok			; if not, bra

		sub.w	#ShoeRight-$30,d2	; get the difference
		sub.w	d2,BossTgtY(a0)		; and move up by that difference
		move.w	#ShoeRight-$30,d2	; this be target x

@riok		move.w	d2,BossTgtX(a0)		; set target x
@gotx		jsr	RandomNumber		; get random number
		and.w	#$1F,d0			; get only this much
		sub.w	d0,BossTgtY(a0)		; change target

		cmp.w	#ShoeTop+$30,BossTgtY(a0); check if going above top
		bge.s	@mvpos			; if not, brah
		move.w	#ShoeTop+$30,BossTgtY(a0); force a positiob

@mvpos		jsr	ShoeChkClose(pc)	; check if Shoe is near this area
		bhs.w	Shoe_Display		; if not, branch
		subq.b	#1,BossTargetCount(a0)	; check if we still want to home
		bmi.w	Shoe_GetAttack		; no? branch

		move.l	#@slow,(a0)		; slow down and load palette
		move.w	#22,BossDelay(a0)	; set delay
	ShFadePal Pal_ShoeAngry			; load angry pal

@slow		sub.w	#$22,BossSpeed(a0)	; slow down
		bpl.s	@spok			; if positive, branch
		clr.w	BossSpeed(a0)		; force 0 speed

@spok		subq.w	#1,BossDelay(a0)	; decrease delay
		bgt.s	Shoe_Display		; if left, branch
		move.l	#@home,(a0)		; home in
		move.b	#$8F,BossColStore(a0)	; set as harmful
		move.w	#$580,BossSpeed(a0)	; set fast speed
		jsr	ShoeHomeTo(pc)		; calc speed and move for 1 frame
;	sfx	sfx_Teleport,0			; play dashing sfx
		bra.s	Shoe_Display+4

@home		cmp.w	#ShoeBot-$10,BossY(a0)	; check if close to bottom
		bgt.s	@oops			; if not, branch
		cmp.w	#ShoeRight-$10,BossX(a0); check if close to right
		bgt.s	@oops			; if not, branch
		cmp.w	#ShoeLeft+$10,BossX(a0)	; check if close to left
		bgt.s	@dis			; if not, branch

@oops		move.b	#$0F,BossColStore(a0)	; set as not harmful
	ShFadePal Pal_Shoe			; load normal pal
		bra.w	@position

@dis		jsr	BossMove(pc)		; home to sonic
		bra.s	Shoe_Display+4		; skip ShoeMove call
; ===========================================================================

Shoe_Display:
		jsr	ShoeMove(pc)		; get boss movin
		bsr.w	@sway

		jsr	RandomNumber		; get random number
		tst.b	obStatus(a0)
		bmi.w	@destroy
		tst.b	obColType(a0)
		bne.s	@cont
		tst.b	BossFlash(a0)
		bne.s	@flash
		move.b	#32,BossFlash(a0)	; set number of	times for ship to flash
		jsr	RandomNumber		; generate a random number
;	sfx	sfx_Ree,0,0,0			; play boss damage sound
		move.b	d0,mComm+7.w		; play random sample

@flash		lea	v_pal_dry+$62,a1	; get pal data to a1
	rept 32/4
		not.l	(a1)+
	endr

		subq.b	#1,BossFlash(a0)
		bne.s	@skpcoll
@cont		move.b	BossColStore(a0),obColType(a0); save collision type

@skpcoll	move.b	obStatus(a0),d0
		andi.b	#3,d0
		andi.b	#$FC,obRender(a0)
		or.b	d0,obRender(a0)

		tst.b	mComm+6.w		; check if played
		bne.s	@noplay			; if so, bra
		cmp.b	#6,v_player+ObRoutine.w	; check if dead
		blo.s	@noplay			; if not, bra
;	sfx	sfx_Ree,0,0,0			; play boss damage sound
		addq.b	#1,mComm+6.w		; play KYS

@noplay		tst.b	obColType(a0)
		beq.s	@nocoll
		jsr	AddToCollList(pc)
@nocoll	NEXT_OBJ_

@sway		move.b	BossSine(a0),d0
		jsr	CalcSine
		asr.w	#6,d0
		add.w	BossY(a0),d0
		move.w	d0,obY(a0)
		move.w	BossX(a0),obX(a0)
		addq.b	#2,BossSine(a0)
		rts

@destroy	moveq	#100,d0
		bsr.w	AddPoints
		move.w	#$B3,$3C(a0)
		move.l	#@destroyed,(a0)
		bset	#1,obRender(a0)		; flip upsidedown
		move.w	#-$400,ObVelY(a0)	; give vertical speed
		clr.w	ObVelX(a0)		; clear horiz speed
	ShFadePal Pal_ShoeDead			; load dead pal
;	sfx	sfx_Ree,0,0,0			; play boss damage sound
		addq.b	#1,mComm+6.w		; play BYE
		bra.s	@nocoll

@destroyed	jsr	BossMove(pc)		; move boss
		bsr.s	@sway
		add.w	#$28,ObVelY(a0)		; apply gravity

		cmp.w	#ShoeBot+$60,BossY(a0)	; check if low enough
		blt.s	@nocoll			; if not, branch
		move.l	#Signpost,(a0)		; make this a signpost
		move.w	v_player+ObX.w,ObX(a0)	; copy player xp to object xp

		clr.b	obRoutine(a0)		; clear routine
		clr.w	spintime(a0)		; clear spin timer for signpost
		clr.w	sparkletime(a0)		; clear sparkle timer for signpost
		clr.b	$3F(a0)			; clear gta variable

		clr.b	f_lockscreen.w		; not a lock screen
	ShoePal2_ Pal_GHZ+2			; load GHZ palette
	NEXT_OBJ

; ===========================================================================

BossSpikeDist	= BossDelay	; spike distance from boss centre
BossSpikeWait	= BossChild+4	; generic wait timer

Shoe_Spikes:
		move.b	#5,BossTargetCount(a0)	; set counter
@new		clr.w	BossSpikeDist(a0)	; reset dist
		move.w	#$170,BossSpeed(a0)	; set speed
		move.b	#32,BossSpikeWait(a0)	; set some wait time
		move.l	#@track,(a0)		; track player

		jsr	FindFreeObj		; load object
	;	bpl.s	Shoe_Init		; if failed, branch
		move.l	#Spikes,(a1)		; load a spike
		bset	#1,obRender(a1)		; flip sprite
		move.b	#$20,ObSubtype(a1)	; one vertical type
		move.w	a1,BossChild(a0)	; save addr

@track		move.w	#ShoeTop+$20,BossTgtY(a0); save target y-pos
		move.w	v_player+ObX.w,BossTgtX(a0); save target x-pos
		jsr	ShoeMove(pc)		; get boss movin

		move.w	BossSpikeDist(a0),d0	; get dist
		move.w	BossChild(a0),a1	; get vert spike
		move.w	BossY(a0),d2		; get y-pos
		add.w	d0,d2			; add distance

		move.w	BossX(a0),ObX(a1)	; save x-pos
		move.w	d2,ObY(a1)		; save y-pos

		cmp.w	#$16,BossSpikeDist(a0)	; check if right dist
		beq.s	@distok			; if so, bra
		addq.w	#1,BossSpikeDist(a0)	; increase distance

@distok		move.w	v_player+ObX.w,d7	; get sonic pos
		sub.w	BossX(a0),d7		; sub bosses pos
		addq.w	#$08,d7			; sub 8px
		cmp.w	#$10,d7			; check if within $10 px of sunal
		bhs.w	Shoe_Display+4		; if not, branch

		subq.b	#1,BossSpikeWait(a0)	; sub 1 from timer
		bgt.w	Shoe_Display+4		; if nonzero, branch

	ShFadePal Pal_ShoeAngry			; load angry pal
		move.b	#16,BossSpikeWait(a0)	; wait 6 frames
		move.l	#@wait,(a0)		;

@wait		subq.b	#1,BossSpikeWait(a0)	; sub 1 from timer
		bgt.w	Shoe_Display+4		; if nonzero, branch
		move.l	#@wait2,(a0)		; wait more
		move.w	#ShoeTop+$20,BossTgtY(a0); save target y-pos

		move.w	BossChild(a0),a1	; get vert spike
		move.w	#$140,ObVelY(a1)	; give fall speed
		move.l	#SpikesSpeed,(a1)	; use speeding variant
	ShFadePal Pal_Shoe			; load normal pal

@wait2		move.w	BossChild(a0),a1	; get vert spike
		cmp.l	#ShoeSpikeCollide,(a1)	; check if landed
		bne.w	Shoe_Display		; branch if not

		move.w	BossChild+2(a0),a1	; get this object
		cmp.l	#ShoeSpikeCollide,(a1)	; check if loaded correctly
		bne.s	@skipfix		; if no, branch
		move.l	#ShoeSpikeExplode,(a1)	; make it xplode!

@skipfix	move.w	BossChild(a0),BossChild+2(a0); copy ptr
;		sfx	SFX_5D,0		; play "thump" sfx

		subq.b	#1,BossTargetCount(a0)	; sub 1 from target counter
		bgt.w	@new			; if not over, bra

		move.w	BossChild+2(a0),a1	; get this object
		move.l	#ShoeSpikeExplode,(a1)	; make it xplode!
		bra.w	Shoe_GetAttack		; get next attack
; ===========================================================================
BossGoUpRet =	BossChild		; return address for going up code
BossDropCursor = BossChild+4		; address of the cursor obj

Shoe_Drop:
		move.b	#3,BossTargetCount(a0)	; set counter
		move.w	#$180,BossSpeed(a0)	; set going up speed
		move.l	#@ret,BossGoUpRet(a0)	; set return addr
		bra.w	Shoe_GoUp

@gainangle	moveq	#$00,d1			; forwards
		move.w	v_player+ObX.w,d0	; get x-pos
		sub.w	BossX(a0),d0		; sub our x
		bpl.s	@seta			; if positive, bra

		moveq	#-$80,d1		; negate angle
@seta		move.b	d1,ObAngle(a0)		; set angle
		rts

@ret		jsr	FindFreeObj		; load object
	;	bpl.s	Shoe_Init		; if failed, branch
		move.l	#ShoeDropCursor,(a1)	; load drop cursor obj
		move.w	a1,BossDropCursor(a0)	; save addr

		move.l	#@run,(a0)		; run about
		move.w	BossY(a0),BossTgtY(a0)	; set target y-pos

		jsr	RandomNumber		; trusty ol rng
		and.w	#$3F,d0			; large one this time
		add.w	#60*4,d0		; add 2s to it
		move.w	d0,BossDelay(a0)	; set delay

@run		bsr.s	@gainangle		; get angle
		move.w	#$100,BossSpeed(a0)	; set tracker speed

		move.w	v_player+ObX.w,d7	; get player
		sub.w	BossX(a0),d7		; sub bosses pos
		add.w	#$10,d7			; sub $10px
		cmp.w	#$20,d7			; check if within $20 px of player
		bhs.s	@nope			; if not, branch
		clr.w	BossSpeed(a0)		; stop moving

@nope		subq.w	#1,BossDelay(a0)	; check if delay is 0
		bpl.w	Shoe_Display		; if positive, display
	ShFadePal Pal_ShoeAngry			; load angry pal

		move.w	#$240,BossSpeed(a0)	; set tracker speed
		move.b	#$8F,BossColStore(a0)	; set as harmful
		move.l	#@fast,(a0)		; move quickly!

@fast		bsr.w	@gainangle		; get angle
		move.w	BossDropCursor(a0),a1	; get cursor obj

		move.w	ObX(a1),d7		; get cursor pos
		sub.w	BossX(a0),d7		; sub bosses pos
		addq.w	#$08,d7			; sub 8px
		cmp.w	#$10,d7			; check if within $10 px of cursor
		bhs.w	Shoe_Display		; if not, branch

		move.l	#@rise,(a0)		; rise a bit
		addq.b	#8,BossDelay(a0)	; for 8 frames actually
		clr.w	BossSpeed(a0)		; no move
;		sfx	SFX_AD,0		; play "selected" sfx
		move.w	BossDropCursor(a0),a1	; get cursor obj
		move.l	#DropCursorWait,(a1)	; set routine

@rise		subq.w	#3,BossY(a0)		; move up lul
		subq.b	#1,BossDelay(a0)	; remove delay
		bpl.w	Shoe_Display		; branch if no end

		move.l	#@drop,(a0)		; drop!
		move.w	#$4000,BossTgtY(a0)	; set target Y-pos
		move.w	#$300,BossSpeed(a0)	; set absurd speed
		move.b	#$40,ObAngle(a0)	; set angle

@drop		move.w	BossDropCursor(a0),a1	; get cursor obj
		move.w	ObX(a1),BossTgtX(a0)	; copy target x
		add.w	#$38,BossSpeed(a0)	; apply gravity... lol

		jsr	ObjFloorDist		; get floor dist
		tst.w	d1			; checkit
		bpl.w	Shoe_Display		; if not touching floor, branch
		add.w	d1,BossY(a0)		; add to current pos

		move.w	BossDropCursor(a0),a1	; get cursor obj
		jsr	DeleteChild		; delete cursor

		move.l	#@grounded,(a0)		; wait a bit on ground
		addq.b	#8,BossDelay(a0)	; for 8 frames actually
		move.b	#$0F,BossColStore(a0)	; set as not harmful
;		sfx	SFX_5F,0		; play "ground" sfx
	ShFadePal Pal_Shoe			; load normal pal

@grounded	subq.b	#1,BossDelay(a0)	; remove delay
		bpl.w	Shoe_Display+8		; branch if no end (no sway or move!)
		move.b	#-$40,ObAngle(a0)	; set angle

		subq.b	#1,BossTargetCount(a0)	; sub 1 from count
		ble.w	Shoe_GetAttack		; if no left, new attack

		move.w	#$180,BossSpeed(a0)	; set going up speed
		move.l	#@ret,BossGoUpRet(a0)	; set return addr
		bra.s	Shoe_GoUp
; ===========================================================================

ShoeChkClose:
		move.w	BossTgtX(a0),d7		; get target xpos
		sub.w	BossX(a0),d7		; sub bosses pos
		add.w	#$20,d7			; sub $20px
		cmp.w	#$40,d7			; check if within $40 px of target
		bhs.s	@nope			; if not, branch

		move.w	BossTgtY(a0),d7		; and target ypos
		sub.w	BossY(a0),d7		; sub bosses pos
		add.w	#$20,d7			; sub $20px
		cmp.w	#$40,d7			; check if within $40 px of target
@nope		rts				; hs -> not in range, lo -> in range
; ===========================================================================

Shoe_CreateArmors:
		move.w	#$300,BossSpeed(a0)	; set going up speed
		move.l	#Shoe_CreateArmors_Ret,BossGoUpRet(a0); set return addr
; ===========================================================================

Shoe_GoUp:
		clr.w	BossTgtY(a0)		; just move up lol
		cmp.w	#ShoeTop+$30,BossY(a0)	; check if above this point
		ble.s	@spa			; if yes, branch
		move.l	#@moveup,(a0)		; move upwards

@moveup		move.w	BossX(a0),BossTgtX(a0)	; copy x-pos to target
		cmp.w	#ShoeTop+$34,BossY(a0)	; check if above this point
		bge.w	Shoe_Display		; if not, branch
@slo		move.l	#@slow,(a0)		; slow down

@slow		subq.b	#1,BossDelay(a0)	; sub 1 from delay
		bpl.w	Shoe_Display		; if delay left, branch

		move.b	#7,BossDelay(a0)	; reset delay
		move.w	BossX(a0),BossTgtX(a0)	; copy x-pos to target
		lsr	BossSpeed(a0)		; halve speed
		bne.w	Shoe_Display		; if still not stopped, branch

@spa		clr.w	BossSpeed(a0)
		move.l	BossGoUpRet(a0),a1	; get ret addr
		jmp	(a1)			; jump
; ===========================================================================


BossArmorY =	obRoutine	; y-pos of obj
BossArmorSpeed = $2E		; speed of rotation
BossArmorDist =	$36		; distance of Armor's from boss

BsArmorCircleSpeed = $700	; set circle speed
BsArmorShakeTimer = 110		; shake timer
BsArmorShakePalTm = 28		; shake timer after palette switch

Shoe_CreateArmors_Ret:
		move.l	#@spawn,(a0)		; do the spawning sequence
		move.w	BossY(a0),BossArmorY(a0); backup y-pos
		clr.w	BossArmorDist(a0)	; clear distance
		clr.b	BossDelay+1(a0)		; clear bitfield
		move.w	#BsArmorCircleSpeed/6,BossArmorSpeed(a0); set initial speed

		moveq	#0,d3			; reset angle
		moveq	#5,d7			; set child count
		lea	@armorchild(pc),a3	; get child data to a3
		lea	@sett(pc),a4		; load routine to run
		bsr.w	Shoe_LoadChildren	; load children

	ShoePal2 Pal_Armor
		move.l	#Unc_Armor,d1
		move.w	#$430*32,d2
		move.w	#filesize("artunc\armor.unc")/2,d3
		jsr	QueueDMATransfer

@spawn		addq.w	#1,BossArmorDist(a0)	; increase distance
		cmp.w	#$30,BossArmorDist(a0)	; check max dist
		blo.w	Shoe_Display		; if less than, branch
		move.b	BossChildCt(a0),BossDelay(a0); set num of objs

@setmove	jsr	RandomNumber		; get random number
		lea	@posarray(pc),a1	; get tbl
		and.l	#$FFFF,d0		; get only low word
		divu	#7,d0			; divide by 6
		swap	d0			; swap it
		bset	d0,BossDelay+1(a0)	; set and check if used
		bne.s	@setmove		; get new move
		add.w	d0,d0			; double d0
		move.w	(a1,d0.w),d3		; get pos

		jsr	RandomNumber		; get random number
		and.w	#$0F,d0			; get only 256px variants
		add.w	d3,d0			; add main pos to offset
		move.w	d0,BossTgtX(a0)		; set targt pos

		move.w	ObY(a0),BossTgtY(a0)	; set current y-pos as target
		jsr	Shoe_SnapAngle(pc)	; snap angle
		move.l	#@move,(a0)

@move		move.w	BossTgtX(a0),d7		; get target xpos
		sub.w	BossX(a0),d7		; sub bosses pos
		addq.w	#$08,d7			; sub 8px
		cmp.w	#$10,d7			; check if within $10 px of target
		blo.s	@fire			; branch if Shoe is near this area

		move.w	BossArmorY(a0),BossY(a0); force y-pos
		cmp.w	#$200,BossSpeed(a0)	; check max speed
		bhs.w	Shoe_Display		; if is, branch
		add.w	#$10,BossSpeed(a0)	; speed up
		bra.w	Shoe_Display

@fire		move.l	#@fire,(a0)
		move.w	BossArmorY(a0),BossY(a0); force y-pos
		tst.w	BossSpeed(a0)		; check if moving slow enough
		beq.s	@dofire			; if is, fire
		sub.w	#$10,BossSpeed(a0)	; slow down
		bra.w	Shoe_Display

@dofire		subq.b	#1,BossDelay(a0)	; decrease obj count
		bmi.w	@wait			; wait a little
		move.l	#@dofire2,(a0)

@dofire2;	cmp.b	#dSnare,mComm+7.w	; check if DAC is playing a snare
	;	beq.w	Shoe_Display		; if is, wait
		move.l	#@waitsnare,(a0)	; new routine

@waitsnare;	cmp.b	#dSnare,mComm+7.w	; check if DAC is playing a snare
	;	beq.w	Shoe_Display		; if not, wait

		moveq	#0,d0
		move.b	BossChildCt(a0),d0	; get loop ct
		subq.b	#1,d0			; -1 for dbf
		lea	BossChild(a0),a1	; get objects to a1
		moveq	#0,d1			; best angle = 0

@findnext	moveq	#0,d4
		move.b	(a1)+,d4		; get next obj id
		mulu	#size,d4		; multiply by size
		add.w	#v_lvlobjspace,d4	; add RAM offset
		move.w	d4,a2			; get actual addr

		move.b	ObAngle(a2),d2		; get angle of obj
		sub.b	#$20,d2
		cmp.b	#$40,d2			; check range $20-$60
		blo.s	@done			; if is, branch

@nextob		dbf	d0,@findnext		; loop for all slots
		bra.w	Shoe_Display

@done		move.l	#Armor_Fire,(a2)	; set fire routine
		add.w	#BsArmorCircleSpeed/6,BossArmorSpeed(a0); increase speed
		bra.w	@setmove

@wait		move.l	#@waits0,(a0)
	ShFadePal Pal_ShoeAngry
		clr.w	BossArmorDist(a0)	; reset dist
		move.w	#BsArmorShakeTimer-BsArmorShakePalTm,BossDelay(a0); set delay

@waits0		tst.b	BossChildCt(a0)		; check if child num is 0
		beq.w	Shoe_GetAttack		; if is, start new attack

		moveq	#0,d0
		move.b	BossChildCt(a0),d0	; get loop ct
		subq.b	#1,d0			; -1 for dbf
		lea	BossChild(a0),a1	; get objects to a1

@forall		moveq	#0,d4
		move.b	(a1)+,d4		; get next obj id
		mulu	#size,d4		; multiply by size
		add.w	#v_lvlobjspace,d4	; add RAM offset
		move.w	d4,a2			; get actual addr

		tst.w	obVelY(a2)		; check if y-vel is 0
		bne.w	Shoe_Display		; if not, bracnh

		move.l	#Armor_Shake,(a2)	; set routine
		dbf	d0,@forall		; loop for all

@totalspd =	$800	; (speed-1)*$100
		move.l	#@waits1,(a0)
		move.w	#$100,BossArmorDist(a0)	; reset dist

@waits1		add.w	#@totalspd/BsArmorShakeTimer,BossArmorDist(a0); add distance
		subq.w	#1,BossDelay(a0)	; decrease delay
		bne.w	Shoe_Display		; display

		move.l	#@waits2,(a0)
	Sh2FadePal Pal_ArmorAngry		; fade palette for armor
		move.w	#BsArmorShakePalTm,BossDelay(a0); set delay

@waits2		add.w	#@totalspd/BsArmorShakeTimer,BossArmorDist(a0); add distance
		subq.w	#1,BossDelay(a0)	; decrease delay
		bne.w	Shoe_Display		; display

		move.l	#@warmor,(a0)
		clr.w	BossArmorDist(a0)	; clear distance
		clr.b	BossDelay+1(a0)		; clear bitfield
	ShFadePal Pal_Shoe			; set shoe to normal

		moveq	#0,d0
		move.b	BossChildCt(a0),d0	; get child ct
		moveq	#0,d1
		move.w	#BsArmorCircleSpeed,d1	; set initial speed component
		divu	d0,d1			; divide by num of child left
		move.w	d1,BossArmorSpeed(a0)	; set initial speed

@warmor		moveq	#0,d1			; clear angle
		moveq	#0,d2
		move.w	#$100,d2		; set full range

		moveq	#0,d0
		move.b	BossChildCt(a0),d0	; get loop ct
		divu	d0,d2			; divide $100 by num of children

		subq.b	#1,d0			; -1 for dbf
		lea	BossChild(a0),a1	; get objects to a1

@warmor2	moveq	#0,d4
		move.b	(a1)+,d4		; get next obj id
		mulu	#size,d4		; multiply by size
		add.w	#v_lvlobjspace,d4	; add RAM offset
		move.w	d4,a2			; get actual addr

		cmp.l	#Armor_Circle,(a2)	; check if circling now
		bne.w	Shoe_Display		; if not, branch

		move.b	d1,obAngle(a2)		; save angle
		add.b	d2,d1			; add change to d1
		dbf	d0,@warmor2		; loop for all

		move.l	#@spawn,(a0)		; reset to back here
	Sh2FadePal Pal_Armor			; set armor to normal pal
		bra.w	Shoe_Display
; ===========================================================================


@armorchild	dc.l Armor_Init, Map_Armor
		dc.b $0E, $24
	dcprio 4

@sett		move.b	d3,obAngle(a1)		; save new angle
		add.b	#$2A,d3			; increse angle (approx)
		rts

@posarray	dc.w ShoeLeft+$0A, ShoeLeft+$34, ShoeLeft+$5E, ShoeLeft+$89
		dc.w ShoeLeft+$B4, ShoeLeft+$DF, ShoeLeft+$10A
; ===========================================================================

Shoe_LoadChildren:
		move.b	d7,BossChildCt(a0)	; set num of children
		move.l	(a3)+,d4		; load object offset
		move.l	(a3)+,d5		; load mapping offset
		lea	BossChild(a0),a5	; get child list to a5
		move.w	#$430,d6		; set the right tile offset

@chloop		jsr	FindFreeObj		; load object
	;	bpl.s	@end			; if failed, branch
		lea	(a3),a2			; copy list to a2

		move.l	d4,(a1)			; set routine
		move.l	d5,obMap(a1)		; set maps
		move.w	d6,obGfx(a1)		; set VRAM setting
		move.b	(a2)+,obActWid(a1)	; set sprite width
		move.b	(a2)+,obRender(a1)	; set render flags
		move.w	(a2)+,dnext(a1)		; load priority address

		moveq	#0,d0
		move.w	a1,d0			; copy address
		sub.w	#v_lvlobjspace,d0	; sub the offset from it
		divu	#size,d0		; divide by it
		move.b	d0,(a5)+		; save id

		move.w	a0,Parent(a1)		; set parent
		jsr	(a4)			; run custom code
		dbf	d7,@chloop		; load next object

@end		sub.b	d7,BossChildCt(a0)	; sub loop reg from child count (if all loaded, will add 1)
		rts
; ===========================================================================

Map_Shoe:	include	"_maps\Shoe.asm"
		even
Pal_Shoe:	incbin	"artunc/shoe.pal"
Pal_ShoeDead:	incbin	"artunc/shoe dead.pal"
Pal_ShoeAngry:	incbin	"artunc/shoe angry.pal",2
Pal_Armor:	incbin	"artunc/armor.pal"
Pal_ArmorAngry:	incbin	"artunc/armor angry.pal",2

DropMap:	dc.b -8, 5
		dc.w 0, -8

Map_Armor:	dc.b -$10, $0B
		dc.w $2000, -$0C
; ===========================================================================

ShoeDropCursor:
		move.l	#Drop_Track,(a0)
		move.b	#8,obHeight(a0)		; set height to 8
		move.b	#8,obActWid(a1)		; set sprite width
		move.w	#$2430,obGfx(a0)
		move.b	#$24,obRender(a0)
		move.l	#DropMap,ObMap(a0)
	display	1, a0

		move.l	#Unc_Cross,d1
		move.w	#$430*32,d2
		move.w	#filesize("artunc\cross.unc")/2,d3
		jsr	QueueDMATransfer

Drop_Track:
		move.l	v_player+ObX.w,ObX(a0)	; copy pos
		move.l	v_player+ObVelX.w,ObVelX(a0); copy velocitys

	rept 10
		jsr	SpeedToPos
	endr

		move.l	v_player+ObY.w,ObY(a0)	; copy y-pos
		cmp.w	#ShoeLeft+$20,ObX(a0)	; check if left
		bgt.s	@leok			; if no, bra
		move.w	#ShoeLeft+$20,ObX(a0)	; set left

@leok		cmp.w	#ShoeRight-$20,ObX(a0)	; check if right
		blt.s	DropCursorWait		; if no, bra
		move.w	#ShoeRight-$20,ObX(a0)	; set right

DropCursorWait:
		btst	#0,v_vbla_byte.w	; check if even or odd frame
		beq.s	@white			; if something or the other, bra

		move.l	#$444,v_pal_dry+$22.w	; write 2 cols
		move.w	#$666,v_pal_dry+$26.w	; last col
		bra.s	@cunt

@white		move.l	#$0EEE0CCC,v_pal_dry+$22.w; write 2 cols
		move.w	#$888,v_pal_dry+$26.w	; last col

@cunt	NEXT_OBJ
; ===========================================================================
ArmorBounces =	subtype
ArmorTimer =	ob2ndRout

Armor_Init:
		move.w	dnext(a0),a2		; load the display address to a2
	displaydx	a0, a2			; enable display

		move.b	#$80,obColType(a0)	; set coll response
		clr.b	ArmorBounces(a0)	; clear bounces count
		move.l	#Armor_Circle,(a0)
		move.b	#8,obHeight(a0)		; set height to 8

Armor_Circle:
		move.w	Parent(a0),a1		; get parent
		move.w	BossArmorSpeed(a1),d1	; get speed
		move.b	obAngle(a0),d0		; get angle
		add.w	d1,obAngle(a0)		; increase angle
		jsr	CalcSine		; get sine
		move.w	BossArmorDist(a1),d5	; get dist

		muls.w	d5,d1			; mult sine
		asr.l	#8,d1			; keep in reasonable range
		add.w	ObX(a1),d1		; add Shoe pos to d1
		move.w	d1,ObX(a0)		; set x-pos

		muls.w	d5,d0			; mult sine
		asr.l	#8,d0			; keep in reasonable range
		add.w	ObY(a1),d0		; add Shoe pos to d1
		move.w	d0,ObY(a0)		; set y-pos

		jsr	AddToCollList(pc)
	NEXT_OBJ

Armor_Fire:
		clr.b	obRoutine(a0)		; make sure obj doesnt think it was touched
		move.b	#$40,obColType(a0)	; set coll response
		clr.b	ObAngle(a0)		; clear angle
	chdisplay	1, a0			; set layer to a0

		jsr	RandomNumber		; get random
		and.w	#$1F,d0			; get variants
		add.w	#$40-$10,d0		; add angle
		jsr	CalcSine		; get sine

		move.w	Parent(a0),a1		; get parent
		move.w	BossArmorSpeed(a1),d5	; get speed
		muls.w	d5,d1			; mult sine
		asr.l	#8,d1			; keep in reasonable range
		move.w	d1,obVelX(a0)		; towards sonic

		muls.w	d5,d0			; mult cosine
		asr.l	#8,d0			; keep in reasonable range
		move.w	d0,obVelY(a0)		; towards sonic
		move.l	#@move,(a0)		; move skeptic

@move		tst.b	obRoutine(a0)		; has Sonic touched the	object?
		beq.w	@edges			; if not, branch
		clr.b	obRoutine(a0)

		move.w	obY(a0),d2		; get y-pos
		sub.w	v_player+obY.w,d2	; sub player y-pos
		bpl.w	@edges			; if below, dont bounce
		addq.b	#1,ArmorBounces(a0)	; inc bounce count
		move.b	#8,ArmorTimer(a0)	; set timer for collision
;		sfx	SFX_7B,0		; play "bumper" sfx

		cmp.b	#3,ArmorBounces(a0)	; check if hit 3 times
		blo.s	@noex			; if not, branch

		move.w	Parent(a0),a1		; get parent
		subq.b	#1,BossChildCt(a1)	; remove last obj from chain
		lea	BossChild(a1),a2	; get objects to a2

		moveq	#0,d0
		move.b	BossChildCt(a1),d0	; get loop ct
		subq.b	#1,d0			; -1 for dbf
		bmi.s	@clear			; if negative, just clear

		move.w	a2,a3			; copy to a3
		moveq	#0,d1
		move.w	a0,d1			; copy address
		sub.w	#v_lvlobjspace,d1	; sub the offset from it
		divu	#size,d1		; divide by it

@copy		cmp.b	(a3),d1			; check if this is same obj
		bne.s	@cpnor			; if not, bar
		addq.w	#1,a3			; skip over this obj

@cpnor		move.b	(a3)+,(a2)+		; copy slot
		dbf	d0,@copy		; loop

@clear		clr.b	(a2)+			; clear last slot

		move.l	#ExplosionItem,a1	; change object to explosion
		move.l	a1,(a0)			; set routine
		clr.b	obRoutine(a0)		; clear homo counter
		jmp	(a1)

@noex		move.w	obX(a0),d1		; get x-pos
		sub.w	v_player+obX.w,d1	; sub player x-pos
		jsr	CalcAngle
		jsr	CalcSine

		muls.w	#$500,d1
		asr.l	#8,d1
		move.w	d1,obVelX(a0)		; bounce away

		muls.w	#$500,d0
		asr.l	#8,d0
		move.w	d0,obVelY(a0)		; bounce away

@edges		jsr	ObjectFall		; fall down
		cmp.w	#ShoeTop+$0E,ObY(a0)	; check if we are near the top
		bgt.s	@notop			; if not, branch
		beq.s	@netop			; negate speed
		move.w	#ShoeTop+$10,ObY(a0)	; force top pos
@netop		neg.w	obVelY(a0)		; negate angle

@notop		cmp.w	#ShoeLeft+$0A,ObX(a0)	; check if we are near left edge
		bgt.s	@noleft			; if not, branch
		beq.s	@neleft			; negate speed
		move.w	#ShoeLeft+$0C,ObX(a0)	; force left pos
@neleft		neg.w	obVelX(a0)		; negate angle

@noleft		cmp.w	#ShoeRight-$0A,ObX(a0)	; check if we are near left edge
		blt.s	@norite			; if not, branch
		beq.s	@nerite			; negate speed
		move.w	#ShoeRight-$0C,ObX(a0)	; force left pos
@nerite		neg.w	obVelX(a0)		; negate angle

@norite		tst.w	obVelY(a0)		; check if moving down
		bmi.s	@nofloor		; if not, branch
		jsr	ObjFloorDist		; get floor dist
		tst.w	d1			; checkit
		bpl.s	@nofloor		; if not touching floor, branch
		asr	obVelX(a0)		; halve horiz speed

;		sfx	SFX_55,0		; play "bounce" sfx
		move.w	obVelY(a0),d0		; get vertical speed
		asr.w	#1,d0			; halve it
		cmp.w	#$A0,d0			; check if speed is low
		bgt.s	@good			; if higher, branch

		moveq	#0,d0			; clear speed
		clr.w	obVelX(a0)		; ''
;		sfx	SFX_56,0		; play "grounded" sfx
		move.l	#@nocoll,(a0)

@good		neg.w	d0			; negate speed
		move.w	d0,obVelY(a0)		; save speed

@nofloor	subq.b	#1,ArmorTimer(a0)	; decrease timer
		bge.s	@nocoll			; if positive, no collision
		st.b	ArmorTimer(a0)		; make sure it does not decrement below 80

		jsr	AddToCollList(pc)
@nocoll	NEXT_OBJ

Armor_Shake:
		move.b	#BsArmorShakeTimer-1,ArmorTimer(a0); set timer to shake
		move.l	#@shake,(a0)

@shake		move.w	Parent(a0),a1		; get parent
		btst	#0,v_vbla_byte.w	; do only every other frame
		beq.s	@display		; ''
		moveq	#0,d0
		move.b	BossArmorDist(a1),d0	; get dist

		tst.b	obMap(a0)		; check if moving up or down
		seq	obMap(a0)		; flip the flag
		beq.s	@pos			; if not set, branch
		neg.w	d0			; negate speed
@pos		add.w	d0,ObY(a0)		; add to y-pos

@display	subq.b	#1,ArmorTimer(a0)	; sub time
		beq.s	@homein			; if 0, branch
	NEXT_OBJ

@homein		move.w	BossX(a1),d1		; get bosses pos
		move.w	BossY(a1),d2		; get bosses pos
		sub.w	ObX(a0),d1		; sub this xpos
		sub.w	ObY(a0),d2		; sub this ypos
		jsr	CalcAngle		; get target angle
		jsr	CalcSine		; get sine

		move.w	#$220,d5		; get speed
		muls.w	d5,d1			; mult sine
		asr.l	#6,d1			; keep in reasonable range
		move.w	d1,obVelX(a0)		; towards sonic

		muls.w	d5,d0			; mult cosine
		asr.l	#6,d0			; keep in reasonable range
		move.w	d0,obVelY(a0)		; towards sonic

		move.l	#@home,(a0)		; move to boss
		move.b	#$80,obColType(a0)	; make obj harmful
	chdisplay	4, a0			; set layer to a0
;		sfx	SFX_9F,0		; play "drag" sfx

@home		move.w	Parent(a0),a1		; get parent
		jsr	SpeedToPos		; move obj

		move.w	ObX(a0),d1		; get this xpos
		sub.w	BossX(a1),d1		; sub bosses pos
		addq.w	#8,d1			;
		cmp.w	#$10,d1			; check if nearby Shoe
		bhi.s	@disp2			; if not, branch

		move.w	ObY(a0),d1		; get this ypos
		sub.w	BossY(a1),d1		; sub bosses pos
		addq.w	#8,d1			;
		cmp.w	#$10,d1			; check if nearby Shoe
		bhi.s	@disp2			; if not, branch
		move.l	#Armor_Circle,(a0)	; go circling again

@disp2		jsr	AddToCollList(pc)
	NEXT_OBJ
; ===========================================================================

FaderShoeAddr =	obMap		; shoe palette address
FaderSecAddr =	obX		; secondary palette address
FaderShoeLast =	ObY		; last routine shoe ran

ShoePalFader:
		btst	#0,v_vbla_byte.w	; check if even frame
		beq.s	@dosec			; do secondary
		tst.l	FaderShoeAddr(a0)	; check if fade is needed
		beq.s	@noshoe			; if not, bra

		lea	v_pal_dry+$62.w,a1	; get pal data to a1
		move.l	FaderShoeAddr(a0),a2	; get addr of palette
		moveq	#14-1,d7		; get rept count

		tst.w	0(a1)			; check if negated
		bmi.s	@noshoe			; if is, skip

@loop1		bsr.s	@fadecolor		; fade colors
		bne.s	@noshoe			; if not faded, branch
		dbf	d7,@loop1		; loop for all cols

		clr.l	FaderShoeAddr(a0)	; set fade as finished
@noshoe	NEXT_OBJ

@dosec		tst.l	FaderSecAddr(a0)	; check if fade is needed
		beq.s	@nosec			; if not, bra
		lea	v_pal_dry+$22.w,a1	; get pal data to a1
		move.l	FaderSecAddr(a0),a2	; get addr of palette
		moveq	#10-1,d7		; get rept count

@loop2		bsr.s	@fadecolor		; fade colors
		bne.s	@nosec			; if not faded, branch
		dbf	d7,@loop2		; loop for all cols

		clr.l	FaderSecAddr(a0)	; set fade as finished
@nosec	NEXT_OBJ
; ===========================================================================

@fadecolor	moveq	#0,d6			; clear indicator
		move.b	(a2)+,d0		; get blue
		sub.b	(a1),d0			; sub target color
		beq.s	@green			; if same, branch
		bpl.s	@blup			; if need raising, branch

		subq.b	#2,(a1)			; decrease the color
		addq.b	#1,d6			; increase d6
		bra.s	@green

@blup		addq.b	#2,(a1)			; increase the color
		addq.b	#1,d6			; increase d6

@green		addq.w	#1,a1			; skip a byte
		move.b	(a2),d0			; get red and green
		and.b	#$F0,d0			; get only green

		move.b	(a1),d1			; copy color to d1
		and.b	#$F0,d1			; get only green
		sub.b	d1,d0			; get difference between colors
		beq.s	@red			; if same, done
		bpl.s	@grup			; if need raising, branch

		sub.b	#$20,(a1)		; decrease the color
		addq.b	#1,d6			; increase d6
		bra.s	@red

@grup		add.b	#$20,(a1)		; increase the color
		addq.b	#1,d6			; increase d6

@red		move.b	(a2)+,d0		; get red and green
		and.b	#$0F,d0			; get only red

		move.b	(a1),d1			; copy color to d1
		and.b	#$0F,d1			; get only red
		sub.b	d1,d0			; get difference between colors
		beq.s	@end			; if same, done
		bpl.s	@reup			; if need raising, branch

		subq.b	#2,(a1)			; decrease the color
		addq.b	#1,d6			; increase d6
		bra.s	@end

@reup		addq.b	#2,(a1)			; increase the color
		addq.b	#1,d6			; increase d6

@end		addq.w	#1,a1			; skip a byte
		tst.b	d6			; check if d6 = 0
		rts
; ===========================================================================

ShoeSpikeCollide:
		move.b	#$C,obActWid(a0)
		moveq	#$C+$B,d1
		move.w	#$10,d2
		move.w	#$11,d3
		move.w	obX(a0),d4
		jsr	SolidObject
	NEXT_OBJ

ShoeSpikeExplode:
		tst.b	obSolid(a0)		; is Sonic standing on the object?
		beq.s	@load			; if not, branch
		bclr	#3,v_player+obStatus.w	; stop sonic standing on us

@load		move.w	#-$440,ObVelY(a0)	; set vertical speed
		move.w	#$200,ObVelX(a0)	; set horizontal speed
		btst	#2,v_vbla_byte.w	; every 4 frames the direction changes
		beq.s	@dirgot			;
		neg.w	ObVelX(a0)		; negate speed

@dirgot		move.l	#@disp,(a0)		; display
@disp		jsr	ObjectFall		; fall
		cmp.w	#ShoeBot+$30,ObY(a0)	; check if below here
		bge.w	DeleteObject2		; if so, delete

		btst	#0,v_vbla_byte.w	; every other frame we are invisible
		beq.s	@nodp			;
	displayck	4, a0
	NEXT_OBJ

@nodp	undisplayck	a0
	NEXT_OBJ
; ===========================================================================
