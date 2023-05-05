; variables used by path swapper objects
pathrange =	oboff32; vertical or horizontal width of the hitbox of the path swapper
pathside1 =	oboff34; defines which side path swapper attempts to check next for main player
pathside2 =	oboff35; defines which side path swapper attempts to check next for sidekick
; ---------------------------------------------------------------------------
Obj_PathSwap:
		move.l	#Map_PathSwap,mappings(a0)	; get the special path swapper mappings
		move.w	#$26BC,tile(a0)			; and ring art tile
		ori.b	#4,render(a0)			; render on level
		move.b	#$40,width(a0)
		move.b	#$40,height(a0)
		move.w	#priority5,priority(a0)

		move.b	subtype(a0),d0			; get object subtype
		btst	#2,d0
		beq.s	.isX				; branch if bit 2 not set
		andi.w	#7,d0				; keep in range of 8
		move.b	d0,frame(a0)			; set as mappings frame

		andi.w	#3,d0				; keep in range of 4
		add.w	d0,d0				; double
		move.w	.ranges(pc,d0.w),pathrange(a0)	; get the pathswapper range

		move.w	ypos(a0),d1			; get ypos of this object
		lea	Object_RAM.w,a1
		cmp.w	ypos(a1),d1			; get ypos of Player
		bhs.s	.main1
		move.b	#1,pathside1(a0)

.main1		lea	Obj_player_2.w,a1
		cmp.w	ypos(a1),d1			; get ypos of sidekick
		bhs.s	.side1
		move.b	#1,pathside2(a0)

.side1		move.l	#PathSwap_Y,(a0)		; set to normal object
		bra.w	PathSwap_Y

; ---------------------------------------------------------------------------
.ranges		dc.w $20, $40, $80, $100
; ---------------------------------------------------------------------------

.isX		andi.w	#3,d0				; keep in range of 4
		move.b	d0,frame(a0)			; set as mappings frame
		add.w	d0,d0				; double
		move.w	.ranges(pc,d0.w),pathrange(a0)	; get the pathswapper range

		move.w	xpos(a0),d1			; get xpos of this object
		lea	Object_RAM.w,a1
		cmp.w	xpos(a1),d1			; get xpos of Player
		bhs.s	.main2
		move.b	#1,pathside1(a0)

.main2		lea	Obj_player_2.w,a1
		cmp.w	xpos(a1),d1			; get xpos of sidekick
		bhs.s	.side2
		move.b	#1,pathside2(a0)

.side2		move.l	#PathSwap_X,(a0)

PathSwap_X:
		tst.w	Debug_Routine.w
		bne.w	.debugactive			; branch if debug mode is active

		move.w	xpos(a0),d1			; get current x-pos
		lea	pathside1(a0),a2		; get object flags
		lea	Object_RAM.w,a1			; get main players RAM
		bsr.s	PathSwap_XDo			; do pathswapping code

		lea	Obj_player_2.w,a1		; get sidekicks RAM
		bsr.s	PathSwap_XDo			; do pathswapping code
		jmp	ChkObjLoaded			; delete object if it goes far from camera
.debugactive	jmp	ChkDispObjLoaded		; display object if near camera
; ---------------------------------------------------------------------------

PathSwap_XDo:
		tst.b	(a2)+
		bne.w	PathSwap_XDo2			; branch if we should check left side
		cmp.w	xpos(a1),d1
		bhi.w	locret_1CEF0			; branch if player is to the left of this swapper
		move.b	#1,-1(a2)			; check left side next

		move.w	ypos(a0),d2			; get current y-pos
		move.w	d2,d3				; copy it
		move.w	pathrange(a0),d4		; get range
		sub.w	d4,d2				; sub range from y-pos
		add.w	d4,d3				; add range to y-pos

		move.w	ypos(a1),d4			; get y-pos of Player
		cmp.w	d2,d4
		blt.w	locret_1CEF0			; branch if player is not in range from left
		cmp.w	d3,d4
		bge.w	locret_1CEF0			; branch if player is not in range from right

		move.b	subtype(a0),d0			; get subtype
		bpl.s	.noaircheck			; branch if high bit isnt set
		btst	#1,status(a1)
		bne.w	locret_1CEF0			; branch if player is in air

.noaircheck	move.w	xpos(a1),d2			; get xpos of player
		sub.w	d1,d2				; sub x-pos of this
		bhs.s	.ckrange			; if positive, branch
		neg.w	d2				; negative to positive
.ckrange	cmpi.w	#$40,d2
		bhs.w	locret_1CEF0			; branch if out of range

		btst	#0,render(a0)
		bne.s	.chkplane			; branch if x-flipped
		move.b	#$C,topsolid(a1)
		move.b	#$D,lrbsolid(a1)		; set to layer 1

		btst	#3,d0
		beq.s	.chkplane			; branch if we should go to layer 1
		move.b	#$E,topsolid(a1)
		move.b	#$F,lrbsolid(a1)		; set to layer 2

.chkplane	andi.w	#$7FFF,tile(a1)			; set to low plane
		btst	#5,d0
		beq.w	locret_1CEF0			; branch if we should go to low plane
		ori.w	#$8000,tile(a1)			; set to high plane
		bra.w	locret_1CEF0
; ---------------------------------------------------------------------------

PathSwap_XDo2:
		cmp.w	xpos(a1),d1
		bls.w	locret_1CEF0			; branch if player is to the right of this swapper
		move.b	#0,-1(a2)			; check right side next

		move.w	ypos(a0),d2			; get current y-pos
		move.w	d2,d3				; copy it
		move.w	pathrange(a0),d4		; get range
		sub.w	d4,d2				; sub range from y-pos
		add.w	d4,d3				; add range to y-pos

		move.w	ypos(a1),d4			; get y-pos of Player
		cmp.w	d2,d4
		blt.w	locret_1CEF0			; branch if player is not in range from left
		cmp.w	d3,d4
		bge.w	locret_1CEF0			; branch if player is not in range from right

		move.b	subtype(a0),d0			; get subtype
		bpl.s	.noaircheck			; branch if high bit isnt set
		btst	#1,status(a1)
		bne.w	locret_1CEF0			; branch if player is in air

.noaircheck	move.w	xpos(a1),d2			; get xpos of player
		sub.w	d1,d2				; sub x-pos of this
		bhs.s	.ckrange			; if positive, branch
		neg.w	d2				; negative to positive
.ckrange	cmpi.w	#$40,d2
		bhs.s	locret_1CEF0			; branch if out of range

		btst	#0,render(a0)
		bne.s	.chkplane			; branch if x-flipped
		move.b	#$C,topsolid(a1)
		move.b	#$D,lrbsolid(a1)		; set to layer 1

		btst	#4,d0
		beq.s	.chkplane			; branch if we should go to layer 1
		move.b	#$E,topsolid(a1)
		move.b	#$F,lrbsolid(a1)		; set to layer 2

.chkplane	andi.w	#$7FFF,tile(a1)			; set to low plane
		btst	#6,d0
		beq.s	locret_1CEF0			; branch if we should go to low plane
		ori.w	#$8000,tile(a1)			; set to high plane

locret_1CEF0:
		rts
; ---------------------------------------------------------------------------

PathSwap_Y:
		tst.w	Debug_Routine.w
		bne.w	.debugactive			; branch if debug mode is active

		move.w	ypos(a0),d1			; get current y-pos
		lea	pathside1(a0),a2		; get object flags
		lea	Object_RAM.w,a1			; get main players RAM
		bsr.s	PathSwap_YDo			; do pathswapping code

		lea	Obj_player_2.w,a1		; get sidekicks RAM
		bsr.s	PathSwap_YDo			; do pathswapping code
		jmp	ChkObjLoaded			; delete object if it goes far from camera
.debugactive	jmp	ChkDispObjLoaded		; display object if near camera
; ---------------------------------------------------------------------------

PathSwap_YDo:
		tst.b	(a2)+
		bne.w	PathSwap_YDo2			; branch if we should check upper side
		cmp.w	ypos(a1),d1
		bhi.w	locret_1D058			; branch if player is above of this swapper
		move.b	#1,-1(a2)			; check upper side next

		move.w	xpos(a0),d2			; get current x-pos
		move.w	d2,d3				; copy it
		move.w	pathrange(a0),d4		; get range
		sub.w	d4,d2				; sub range from x-pos
		add.w	d4,d3				; add range to x-pos


		move.w	xpos(a1),d4			; get x-pos of Player
		cmp.w	d2,d4
		blt.w	locret_1D058			; branch if player is not in range from down
		cmp.w	d3,d4
		bge.w	locret_1D058			; branch if player is not in range from up

		move.b	subtype(a0),d0			; get subtype
		bpl.s	.noaircheck			; branch if high bit isnt set
		btst	#1,status(a1)
		bne.w	locret_1D058			; branch if player is in air

.noaircheck	move.w	ypos(a1),d2			; get xpos of player
		sub.w	d1,d2				; sub x-pos of this
		bhs.s	.ckrange			; if positive, branch
		neg.w	d2				; negative to positive
.ckrange	cmpi.w	#$40,d2
		bhs.w	locret_1D058			; branch if out of range

		btst	#0,render(a0)
		bne.s	.chkplane			; branch if x-flipped
		move.b	#$C,topsolid(a1)
		move.b	#$D,lrbsolid(a1)		; set to layer 1

		btst	#3,d0
		beq.s	.chkplane			; branch if we should go to layer 1
		move.b	#$E,topsolid(a1)
		move.b	#$F,lrbsolid(a1)		; set to layer 2

.chkplane	andi.w	#$7FFF,tile(a1)			; set to low plane
		btst	#5,d0
		beq.w	locret_1D058			; branch if we should go to low plane
		ori.w	#$8000,tile(a1)			; set to high plane
		bra.w	locret_1D058
; ---------------------------------------------------------------------------

PathSwap_YDo2:
		cmp.w	ypos(a1),d1
		bls.w	locret_1D058			; branch if player is above of this swapper
		move.b	#0,-1(a2)			; check upper side next

		move.w	xpos(a0),d2			; get current x-pos
		move.w	d2,d3				; copy it
		move.w	pathrange(a0),d4		; get range
		sub.w	d4,d2				; sub range from x-pos
		add.w	d4,d3				; add range to x-pos

		move.w	xpos(a1),d4			; get x-pos of Player
		cmp.w	d2,d4
		blt.w	locret_1D058			; branch if player is not in range from down
		cmp.w	d3,d4
		bge.w	locret_1D058			; branch if player is not in range from up

		move.b	subtype(a0),d0			; get subtype
		bpl.s	.noaircheck			; branch if high bit isnt set
		btst	#1,status(a1)
		bne.w	locret_1D058			; branch if player is in air

.noaircheck	move.w	ypos(a1),d2			; get xpos of player
		sub.w	d1,d2				; sub x-pos of this
		bhs.s	.ckrange			; if positive, branch
		neg.w	d2				; negative to positive
.ckrange	cmpi.w	#$40,d2
		bhs.s	locret_1D058			; branch if out of range

		btst	#0,render(a0)
		bne.s	.chkplane			; branch if x-flipped
		move.b	#$C,topsolid(a1)
		move.b	#$D,lrbsolid(a1)		; set to layer 1

		btst	#4,d0
		beq.s	.chkplane			; branch if we should go to layer 1
		move.b	#$E,topsolid(a1)
		move.b	#$F,lrbsolid(a1)		; set to layer 2

.chkplane	andi.w	#$7FFF,tile(a1)			; set to low plane
		btst	#6,d0
		beq.s	locret_1D058			; branch if we should go to low plane
		ori.w	#$8000,tile(a1)			; set to high plane

locret_1D058:
		rts

; ---------------------------------------------------------------------------
Map_PathSwap:		include "levels/common/Path Swappers/map.asm"
; ---------------------------------------------------------------------------
