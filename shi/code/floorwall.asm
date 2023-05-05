Player_AnglePosRev:
		move.b	$26(a0),d0
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0
		move.b	d0,$26(a0)
		bsr.s	Player_Anglepos
		move.b	$26(a0),d0
		addi.b	#$40,d0
		neg.b	d0
		subi.b	#$40,d0
		move.b	d0,$26(a0)
		rts

Call_Player_AnglePos:
		tst.b	ReverseGravity_Flag.w
		bne.s	Player_AnglePosRev
; ---------------------------------------------------------------------------

Player_AnglePos:
		move.l	Primary_Collision.w,Current_Collision.w
		cmpi.b	#$C,$46(a0)
		beq.s	.collset
		move.l	Secondary_Collision.w,Current_Collision.w

.collset	move.b	$46(a0),d5
		btst	#3,$2A(a0)
		beq.s	.normal			; branch if Player isnt on a plarform

		moveq	#0,d0
		move.b	d0,Player_NextTilt.w
		move.b	d0,Player_CurrentTilt.w	; clear angle
		rts
; ---------------------------------------------------------------------------

.normal		moveq	#3,d0
		move.b	d0,Player_NextTilt.w
		move.b	d0,Player_CurrentTilt.w	; set tilt to 3

		move.b	$26(a0),d0		; get angle
		addi.b	#$20,d0			; add $20
		bpl.s	.blah			; if positive, branch

		move.b	$26(a0),d0		; get angle again
		bpl.s	.positive1		; branch if positive
		subq.b	#1,d0			; sub 1 from the angle
.positive1	addi.b	#$20,d0			; add $20 to the angle
		bra.s	.continue

.blah		move.b	$26(a0),d0		; get angle
		bpl.s	.positive2		; branch if positive
		addq.b	#1,d0			; add 1 to the angle
.positive2	addi.b	#$1F,d0			; add $1F to the angle

.continue	andi.b	#$C0,d0			; get each 90 degree angle (possibly rotated by 45 degrees)
		cmpi.b	#$40,d0
		beq.w	Player_WalkVertL	; branch if 45-135
		cmpi.b	#$80,d0
		beq.w	Player_WalkCeiling	; branch if 135-225
		cmpi.b	#$C0,d0
		beq.w	Player_WalkVertR	; branch if 225-315

		move.w	$14(a0),d2		; get players Y-position
		move.w	$10(a0),d3		; get players X-position

		moveq	#0,d0
		move.b	$1E(a0),d0		; get player height
		ext.w	d0
		add.w	d0,d2			; add to y-pos

		move.b	$1F(a0),d0		; gey players width
		ext.w	d0
		add.w	d0,d3			; add to x-pos

		lea	Player_NextTilt.w,a4
		movea.w	#$10,a3
		move.w	#0,d6			; no xor
		jsr	FindFloor(pc)		; find the floor height
		move.w	d1,-(sp)		; store it

		move.w	$14(a0),d2		; get players Y-position
		move.w	$10(a0),d3		; get players X-position
		moveq	#0,d0
		move.b	$1E(a0),d0		; get player height
		ext.w	d0
		add.w	d0,d2			; add to y-pos

		move.b	$1F(a0),d0		; get players width
		ext.w	d0
		neg.w	d0			; negate
		add.w	d0,d3			; add to x-pos

		lea	Player_CurrentTilt.w,a4
		movea.w	#$10,a3
		move.w	#0,d6			; no xor
		jsr	FindFloor(pc)		; find the floor height
		move.w	(sp)+,d0		; get the stored height

		bsr.w	Player_Angle		; d1 is the selected angle (either d0 or d1)
		tst.w	d1
		beq.s	.rts			; if angle = 0
		bpl.s	.higher			; if angle > 0

		; if angle is < 0
		cmpi.w	#-$E,d1
		blt.s	.rts			; if angle < -14
		add.w	d1,$14(a0)		; add d1 to Y-position
.rts		rts
; ---------------------------------------------------------------------------

.higher		tst.b	$3C(a0)
		bne.s	.1			; branch if stick to convex surfaces?
		move.b	$18(a0),d0		; get x-speed
		bpl.s	.pos			; branch if positive
		neg.b	d0			; negate speed

.pos		addq.b	#4,d0			; add to to?
		cmpi.b	#$E,d0
		blo.s	.nochange		; if ? < 14
		move.b	#$E,d0			; ? = 14

.nochange	cmp.b	d0,d1
		bgt.s	.2

.1		add.w	d1,$14(a0)		; add d1 to Y-pos
		rts
; ---------------------------------------------------------------------------

.2		bset	#1,$2A(a0)		; set in air bit
		bclr	#5,$2A(a0)		; clear pushing bit
		move.b	#1,$21(a0)		; restart animation?
		rts
; ---------------------------------------------------------------------------

Player_Angle:
		move.w	d0,d3			; copy first angle
		move.b	Player_CurrentTilt.w,d2	;
		cmp.w	d0,d1			; compare both angles
		ble.s	.0			; if less than or same, branch

		move.b	Player_NextTilt.w,d2	; set new angle
		move.w	d1,d3			;
		move.w	d0,d1			;

.0		btst	#0,d2
		bne.s	.1
		move.b	d2,d0			; get the angle
		sub.b	$26(a0),d0		; sub current angle
		bpl.s	.pos			; if positive, branch
		neg.b	d0			; negate angle

.pos		cmpi.b	#$20,d0
		bhs.s	.1			; branch if angle is grater than 90
		move.b	d2,$26(a0)
		rts

.1		move.b	$26(a0),d2		; get angle
		addi.b	#$20,d2			; add 90 degrees
		andi.b	#$C0,d2			; and to only 90 degree angles
		move.b	d2,$26(a0)		; store angle
		rts
; ---------------------------------------------------------------------------

Player_WalkVertR:
		move.w	$14(a0),d2		; get players Y-position
		move.w	$10(a0),d3		; get players X-position

		moveq	#0,d0
		move.b	$1F(a0),d0		; get player width
		ext.w	d0
		neg.w	d0			; negate width
		add.w	d0,d2			; add to y-pos

		move.b	$1E(a0),d0		; get players height
		ext.w	d0
		add.w	d0,d3			; add to x-pos

		lea	Player_NextTilt.w,a4
		movea.w	#$10,a3
		move.w	#0,d6			; no xor
		jsr	FindWall(pc)		; find the wall width?
		move.w	d1,-(sp)		; store wall width(?)

		move.w	$14(a0),d2		; get players Y-position
		move.w	$10(a0),d3		; get players X-position

		moveq	#0,d0
		move.b	$1F(a0),d0		; get players width
		ext.w	d0
		add.w	d0,d2			; add to y-pos

		move.b	$1E(a0),d0		; get player height
		ext.w	d0
		add.w	d0,d3			; add to x-pos

		lea	Player_CurrentTilt.w,a4
		movea.w	#$10,a3
		move.w	#0,d6			; no xor
		jsr	FindWall(pc)		; find the wall width?
		move.w	(sp)+,d0		; get stored width(?)

		bsr.w	Player_Angle		; d1 is the selected angle (either d0 or d1)
		tst.w	d1
		beq.s	.rts			; if angle = 0
	;	bpl.s	.higher			; if angle > 0

		; if angle is < 0
.higher		cmpi.w	#-$E,d1
		blt.s	.1			; if angle < -14
		tst.b	$41(a0)
		bne.s	.0			; branch if angle timer isnt 0???
		add.w	d1,$10(a0)		; add d1 to X-position
.rts		rts
; ---------------------------------------------------------------------------

.0		subq.b	#1,$41(a0)		; sub 1 from angle timer?
		move.b	#-$40,$26(a0)		; force angle
		rts
; ---------------------------------------------------------------------------

.1		tst.b	$3C(a0)
		bne.s	.2			; branch if stick to convex surfaces?
		move.b	$1A(a0),d0		; get Y-speed
		bpl.s	.neg			; if positive, branch
		neg.b	d0			; negate

.neg		addq.b	#4,d0			; add 4 to it
		cmpi.b	#$E,d0
		blo.s	.nochange		; branch if <= $E
		move.b	#$E,d0			; else set to $E

.nochange	cmp.b	d0,d1
		bgt.s	.3
.2		add.w	d1,$10(a0)		; add d1 to X-pos
		rts
; ---------------------------------------------------------------------------

.3		bset	#1,$2A(a0)		; set in air bit
		bclr	#5,$2A(a0)		; clear pushing bit
		move.b	#1,$21(a0)		; restart animation?
		rts
; ---------------------------------------------------------------------------

Player_WalkCeiling:
		move.w	$14(a0),d2		; get players Y-position
		move.w	$10(a0),d3		; get players X-position

		moveq	#0,d0
		move.b	$1E(a0),d0		; get player height
		ext.w	d0
		sub.w	d0,d2			; sub from y-pos
		eori.w	#$F,d2			; xor by $F for some reason

		move.b	$1F(a0),d0		; get player height
		ext.w	d0
		add.w	d0,d3			; add to x-pos

		lea	Player_NextTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6		; xor y-flip bit
		jsr	FindFloor(pc)		; find the floor height
		move.w	d1,-(sp)		; store it

		move.w	$14(a0),d2		; get players Y-position
		move.w	$10(a0),d3		; get players X-position

		moveq	#0,d0
		move.b	$1E(a0),d0		; get player height
		ext.w	d0
		sub.w	d0,d2			; sub from y-pos
		eori.w	#$F,d2			; xor by $F for some reason

		move.b	$1F(a0),d0		; get player height
		ext.w	d0
		sub.w	d0,d3			; sub from x-pos

		lea	Player_CurrentTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6		; xor y-flip bit
		jsr	FindFloor(pc)		; find the floor height
		move.w	(sp)+,d0		; get the stored floor height

		bsr.w	Player_Angle		; d1 is the selected angle (either d0 or d1)
		tst.w	d1
		beq.s	.rts			; if angle = 0
		bpl.s	.higher			; if angle > 0

		; if angle is < 0
		cmpi.w	#-$E,d1
		blt.s	.rts			; if angle < -14
		sub.w	d1,$14(a0)		; sub d1 from Y-position
.rts		rts
; ---------------------------------------------------------------------------

.higher		tst.b	$3C(a0)
		bne.s	.0			; branch if stick to convex surfaces?
		move.b	$18(a0),d0		; get x-speed
		bpl.s	.pos			; branch if positive
		neg.b	d0			; negate speed

.pos		addq.b	#4,d0			; add to to?
		cmpi.b	#$E,d0
		blo.s	.nochange		; if ? < 14
		move.b	#$E,d0			; ? = 14

.nochange	cmp.b	d0,d1
		bgt.s	.1
.0		sub.w	d1,$14(a0)		; sub d1 from Y-position
		rts
; ---------------------------------------------------------------------------

.1		bset	#1,$2A(a0)		; set in air bit
		bclr	#5,$2A(a0)		; clear pushing bit
		move.b	#1,$21(a0)		; restart animation?
		rts
; ---------------------------------------------------------------------------

Player_WalkVertL:
		move.w	$14(a0),d2		; get players Y-position
		move.w	$10(a0),d3		; get players X-position

		moveq	#0,d0
		move.b	$1F(a0),d0		; get player height
		ext.w	d0
		sub.w	d0,d2			; sub from y-pos

		move.b	$1E(a0),d0		; get player height
		ext.w	d0
		sub.w	d0,d3			; sub from x-pos
		eori.w	#$F,d3			; xor by $F for some reason

		lea	Player_NextTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6		; xor x-flip bit
		jsr	FindWall(pc)		; find the wall width(?)
		move.w	d1,-(sp)		; store it

		move.w	$14(a0),d2		; get players Y-position
		move.w	$10(a0),d3		; get players X-position

		moveq	#0,d0
		move.b	$1F(a0),d0		; get player height
		ext.w	d0
		add.w	d0,d2			; add to y-pos

		move.b	$1E(a0),d0		; get player height
		ext.w	d0
		sub.w	d0,d3			; sub from x-pos
		eori.w	#$F,d3			; xor by $F for some reason

		lea	Player_CurrentTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6		; xor x-flip bit
		jsr	FindWall(pc)		; find the wall width(?)
		move.w	(sp)+,d0		; get the stored wall width(?)

		bsr.w	Player_Angle		; d1 is the selected angle (either d0 or d1)
		tst.w	d1
		beq.s	.rts			; if angle = 0
		bpl.s	.higher			; if angle > 0

		; if angle is < 0
		cmpi.w	#-$E,d1
		blt.s	.rts			; if angle < -14
		sub.w	d1,$10(a0)		; sub d1 from X-position
.rts		rts
; ---------------------------------------------------------------------------

.higher		tst.b	$3C(a0)
		bne.s	.0			; branch if stick to convex surfaces?
		move.b	$1A(a0),d0		; get Y-speed
		bpl.s	.pos			; if positive, branch
		neg.b	d0			; negate

.pos		addq.b	#4,d0			; add to to?
		cmpi.b	#$E,d0
		blo.s	.nochange		; if ? < 14
		move.b	#$E,d0			; ? = 14

.nochange	cmp.b	d0,d1
		bgt.s	.1
.0		sub.w	d1,$10(a0)		; sub d1 from X-position
		rts
; ---------------------------------------------------------------------------

.1		bset	#1,$2A(a0)		; set in air bit
		bclr	#5,$2A(a0)		; clear pushing bit
		move.b	#1,$21(a0)		; restart animation?
		rts
; ---------------------------------------------------------------------------
; input:
;  d0 = ypos of the chunk
;  d1 = xpos of the chunk
; output:
;  a1 = chunk address
; ---------------------------------------------------------------------------
GetChunkPosBG:
		lea	Level_layout_header.w,a1
		lsr.w	#5,d0
		and.w	Layout_row_index_mask.w,d0
		move.w	$A(a1,d0.w),d0		; BG chunks

		lsr.w	#7,d1
		add.w	d1,d0
		add.w	#Level_layout_header-$FFFF8000,d0
		movea.w	d0,a1
		rts
; ---------------------------------------------------------------------------

GetChunkPosFG:
		lea	Level_layout_header.w,a1
		lsr.w	#5,d0
		and.w	Layout_row_index_mask.w,d0
		move.w	8(a1,d0.w),d0		; BG chunks

		lsr.w	#7,d1
		add.w	d1,d0
		add.w	#Level_layout_header-$FFFF8000,d0
		movea.w	d0,a1
		rts
; ---------------------------------------------------------------------------

GetBlockPosBG:
		lea	Level_layout_header.w,a1
		move.w	d2,d0
		lsr.w	#5,d0
		and.w	Layout_row_index_mask.w,d0
		move.w	$A(a1,d0.w),d0		; BG chunks

		move.w	d3,d1
		lsr.w	#3,d1
		move.w	d1,d4
		lsr.w	#4,d1
		add.w	d1,d0

	; Changed to accomodate direct chunks
		moveq	#0,d1			; prepare $FFFFFFFF to d1
		add.w	#Level_layout_header-$FFFF8000,d0
		movea.w	d0,a1
		move.b	(a1),d1			; get chunk from layout
		add.w	d1,d1			; double its value
		move.w	ChunkAddresses(pc,d1.w),d1

		move.w	d2,d0
		andi.w	#$70,d0
		add.w	d0,d1
		andi.w	#$E,d4
		add.w	d4,d1
		add.l	#ML_Chunks,d1
		movea.l	d1,a1			; get the final block
		rts
; ---------------------------------------------------------------------------

GetBlockPosFG:
		lea	Level_layout_header.w,a1
		move.w	d2,d0
		lsr.w	#5,d0
		and.w	Layout_row_index_mask.w,d0
		move.w	8(a1,d0.w),d0		; FG chunks

		move.w	d3,d1
		lsr.w	#3,d1
		move.w	d1,d4
		lsr.w	#4,d1
		add.w	d1,d0

		moveq	#0,d1			; prepare $FFFFFFFF to d1
		add.w	#Level_layout_header-$FFFF8000,d0
		movea.w	d0,a1
		move.b	(a1),d1			; get chunk from layout
		add.w	d1,d1			; double its value
		move.w	ChunkAddresses(pc,d1.w),d1

		move.w	d2,d0
		andi.w	#$70,d0
		add.w	d0,d1
		andi.w	#$E,d4
		add.w	d4,d1
		add.l	#ML_Chunks,d1
		movea.l	d1,a1			; get the final block
		rts

; ---------------------------------------------------------------------------
ChunkAddresses:
temp =		0			; this rept block creates
		rept $100		; all values between 0 and $8000
			dc.w temp	; in increments of $80
temp = 			temp+$80	; this creates all possible chunk addresses
		endr			; without the initial $FF0000
; ---------------------------------------------------------------------------

FindFloor:
		lea	GetBlockPosFG.w,a5
		tst.b	BG_Layer_Scroll_Timer2+2.w
		beq.s	FindFloor_Common		; do FG only
		bsr.s	FindFloor_Common		; do FG first
		move.b	(a4),1(a4)

		move.w	d1,-(sp)			; store height
		sub.w	Camera_X_Pos_Relative_To_BG.w,d3
		sub.w	Camera_Y_Pos_Relative_To_BG.w,d2
		lea	GetBlockPosBG.w,a5
		bsr.s	FindFloor_Common		; do BG next

		add.w	Camera_X_Pos_Relative_To_BG.w,d3
		add.w	Camera_Y_Pos_Relative_To_BG.w,d2
		move.w	(sp)+,d0			; get earlier stored height to d0

		cmp.w	d0,d1				; compare heights
		ble.s	.rts				; if less or equal, branch
		move.b	1(a4),(a4)
		move.w	d0,d1				; get the FG height instead
.rts		rts
; ---------------------------------------------------------------------------

FindFloor_Common:
		jsr	(a5)			; get block address
		move.w	(a1),d0			; get block from the address
		move.w	d0,d4			; copy value
		andi.w	#$3FF,d0		; mask the block ID
		beq.s	.nocolls		; if 0, branch
		btst	d5,d4			; check if this block has floor collision on current layer
		bne.s	.chkColl		; if does, branch(?)

.nocolls	add.w	a3,d2
		jsr	FindFloor_Common2(pc)
		sub.w	a3,d2
		addi.w	#$10,d1
		rts

.chkColl	movea.l	Current_Collision.w,a2	; get current collision address
		add.w	d0,d0			; double the block value
		move.b	(a2,d0.w),d0		; and then get the collision ID
		andi.w	#$FF,d0			; keep in range of 100
		beq.s	.nocolls		; if null, branch

		lea	AngleArray,a2		; get angles
		move.b	(a2,d0.w),(a4)		; store angle
		lsl.w	#4,d0			; shift left 4 times
		move.w	d3,d1			; copy x-pos

		btst	#$A,d4
		beq.s	.noxflip		; branch if not x-flipped
		not.w	d1
		neg.b	(a4)

.noxflip	btst	#$B,d4
		beq.s	.noyflip		; branch if not y-flipped
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

.noyflip	andi.w	#$F,d1			; keep x-pos within 16 pixels
		add.w	d0,d1			; add collision offset to d1

		lea	HeightMaps,a2
		move.b	(a2,d1.w),d0		; and then get appropriate height value
		ext.w	d0			; extend to word

		eor.w	d6,d4			; xor d4 by something?
		btst	#$B,d4
		beq.s	.noyflip2		; branch if not y-flipped
		neg.w	d0			; negate height

.noyflip2	tst.w	d0
		beq.s	.nocolls		; branch if height = 0
		bmi.s	.negHeight		; branch if height < 0

		; height > 0
		cmpi.b	#$10,d0			; check if full collision
		beq.s	.0			; if so, branch

		move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts				; return some sort of height

.negHeight	move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	.nocolls

.0		sub.w	a3,d2
		jsr	FindFloor_Common2(pc)
		add.w	a3,d2
		subi.w	#$10,d1
		rts
; ---------------------------------------------------------------------------

FindFloor_Common2:
		jsr	(a5)			; get block address
		move.w	(a1),d0			; get block from the address
		move.w	d0,d4			; copy value
		andi.w	#$3FF,d0		; mask the block ID
		beq.s	.nocolls		; if null, branch
		btst	d5,d4			; check if this block has floor collision on current layer
		bne.s	.chkColl		; if does, branch(?)

.nocolls	move.w	#$F,d1
		move.w	d2,d0
		andi.w	#$F,d0
		sub.w	d0,d1
		rts

.chkColl	movea.l	Current_Collision.w,a2	; get current collision address
		add.w	d0,d0			; double the block value
		move.b	(a2,d0.w),d0		; and then get the collision ID
		andi.w	#$FF,d0			; keep in range of 100
		beq.s	.nocolls		; if null, branch

		lea	AngleArray,a2		; get angles
		move.b	(a2,d0.w),(a4)		; store angle
		lsl.w	#4,d0			; shift left 4 times
		move.w	d3,d1			; copy x-post

		btst	#$A,d4
		beq.s	.noxflip		; branch if not x-flipped
		not.w	d1
		neg.b	(a4)

.noxflip	btst	#$B,d4
		beq.s	.noyflip		; branch if not y-flipped
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

.noyflip	andi.w	#$F,d1			; keep x-pos within 16 pixels
		add.w	d0,d1			; add collision offset to d1

		lea	HeightMaps,a2
		move.b	(a2,d1.w),d0		; and then get appropriate height value
		ext.w	d0			; extend to word

		eor.w	d6,d4			; xor d4 by something?
		btst	#$B,d4
		beq.s	.noyflip2		; branch if not y-flipped
		neg.w	d0			; negate height

.noyflip2	tst.w	d0
		beq.s	.nocolls		; branch if height = 0
		bmi.s	.negHeight		; branch if height < 0

		; height > 0
		move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts				; return some sort of height

.negHeight	move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	.nocolls
		not.w	d1
		rts
; ---------------------------------------------------------------------------

ObjFindFloor:	; note: may be incorrect!
		lea	GetBlockPosFG.w,a5
		tst.b	BG_Layer_Scroll_Timer2+2.w
		beq.s	ObjFindFloor_Common		; do only FG
		bsr.s	ObjFindFloor_Common		; do FG first
		move.b	(a4),1(a4)
		move.w	d1,-(sp)

		sub.w	Camera_X_Pos_Relative_To_BG.w,d3
		sub.w	Camera_Y_Pos_Relative_To_BG.w,d2
		lea	GetBlockPosBG.w,a5
		bsr.s	ObjFindFloor_Common		; then do BG

		add.w	Camera_X_Pos_Relative_To_BG.w,d3
		add.w	Camera_Y_Pos_Relative_To_BG.w,d2
		move.w	(sp)+,d0

		cmp.w	d0,d1				; compare heights
		ble.s	.rts				; if less or equal, branch
		move.b	1(a4),(a4)
		move.w	d0,d1				; get the FG height instead
.rts		rts
; ---------------------------------------------------------------------------

ObjFindFloor_Common:
		jsr	(a5)			; get block address
		move.w	(a1),d0			; get block from the address
		move.w	d0,d4			; copy value
		andi.w	#$3FF,d0		; mask the block ID
		beq.s	.nocolls		; if null, branch
		btst	d5,d4			; check if this block has floor collision on current layer
		bne.s	.chkColl		; if does, branch(?)

.nocolls	move.w	#$10,d1
		rts

.chkColl	movea.l	Current_Collision.w,a2	; get current collision address
		add.w	d0,d0			; double the block value
		move.b	(a2,d0.w),d0		; and then get the collision ID
		andi.w	#$FF,d0			; keep in range of 100
		beq.s	.nocolls		; if null, branch

		lea	AngleArray,a2		; get angles
		move.b	(a2,d0.w),(a4)		; store angle
		lsl.w	#4,d0			; shift left 4 times
		move.w	d3,d1			; copy x-post

		btst	#$A,d4
		beq.s	.noxflip		; branch if not x-flipped
		not.w	d1
		neg.b	(a4)

.noxflip	btst	#$B,d4
		beq.s	.noyflip		; branch if not y-flipped
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

.noyflip	andi.w	#$F,d1			; keep x-pos within 16 pixels
		add.w	d0,d1			; add collision offset to d1

		lea	HeightMaps,a2
		move.b	(a2,d1.w),d0		; and then get appropriate height value
		ext.w	d0			; extend to word

		eor.w	d6,d4			; xor d4 by something?
		btst	#$B,d4
		beq.s	.noyflip2		; branch if not y-flipped
		neg.w	d0			; negate height

.noyflip2	tst.w	d0
		beq.s	.nocolls		; branch if height = 0
		bmi.s	.negHeight		; branch if height < 0

		; height > 0
		cmpi.b	#$10,d0			; check if full collision
		beq.s	.0			; if so, branch

		move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts

.negHeight	move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	.nocolls

.0		sub.w	a3,d2
		jsr	FindFloor_Common2(pc)
		add.w	a3,d2
		subi.w	#$10,d1
		rts
; ---------------------------------------------------------------------------

FindWall:
		lea	GetBlockPosFG.w,a5
		tst.b	BG_Layer_Scroll_Timer2+2.w
		beq.s	Findwall_Common			; FG only
		bsr.s	Findwall_Common			; do FG first

		move.b	(a4),1(a4)
		move.w	d1,-(sp)
		move.w	a3,d0
		bpl.s	.0

		eori.w	#$F,d3
		sub.w	Camera_X_Pos_Relative_To_BG.w,d3
		eori.w	#$F,d3
		bra.s	.1

.0		sub.w	Camera_X_Pos_Relative_To_BG.w,d3
.1		sub.w	Camera_Y_Pos_Relative_To_BG.w,d2
		lea	GetBlockPosBG.w,a5
		bsr.s	Findwall_Common			; then do BG

		move.w	a3,d0
		bpl.s	.2
		eori.w	#$F,d3
		add.w	Camera_X_Pos_Relative_To_BG.w,d3
		eori.w	#$F,d3
		bra.s	.3

.2		add.w	Camera_X_Pos_Relative_To_BG.w,d3
.3		add.w	Camera_Y_Pos_Relative_To_BG.w,d2

		move.w	(sp)+,d0
		cmp.w	d0,d1
		ble.s	.rts
		move.b	1(a4),(a4)
		move.w	d0,d1
.rts		rts
; ---------------------------------------------------------------------------

Findwall_Common:
		jsr	(a5)			; get block address
		move.w	(a1),d0			; get block from the address
		move.w	d0,d4			; copy value
		andi.w	#$3FF,d0		; mask the block ID
		beq.s	.nocolls		; if null, branch
		btst	d5,d4			; check if this block has floor collision on current layer
		bne.s	.chkColl		; if does, branch(?)

.nocolls	add.w	a3,d3
		jsr	FindWall_Common2(pc)
		sub.w	a3,d3
		addi.w	#$10,d1
		rts

.chkColl	movea.l	Current_Collision.w,a2	; get current collision address
		add.w	d0,d0			; double the block value
		move.b	(a2,d0.w),d0		; and then get the collision ID
		andi.w	#$FF,d0			; keep in range of 100
		beq.s	.nocolls		; if null, branch

		lea	AngleArray,a2		; get angles
		move.b	(a2,d0.w),(a4)		; store angle
		lsl.w	#4,d0			; shift left 4 times
		move.w	d2,d1			; copy x-post

		btst	#$B,d4
		beq.s	.noyflip		; branch if not y-flipped
		not.w	d1
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

.noyflip	btst	#$A,d4
		beq.s	.noxflip		; branch if not x-flipped
		neg.b	(a4)

.noxflip	andi.w	#$F,d1			; keep x-pos within 16 pixels
		add.w	d0,d1			; add collision offset to d1

		lea	HeightMapsRot,a2
		move.b	(a2,d1.w),d0		; and then get appropriate height value
		ext.w	d0			; extend to word

		eor.w	d6,d4			; xor d4 by something?
		btst	#$A,d4
		beq.s	.noxflip2		; branch if not x-flipped
		neg.w	d0			; negate height

.noxflip2	tst.w	d0
		beq.s	.nocolls		; branch if height = 0
		bmi.s	.negHeight		; branch if height < 0

		; height > 0
		cmpi.b	#$10,d0
		beq.s	.0

		move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts

.negHeight	move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	.nocolls

.0		sub.w	a3,d3
		jsr	FindWall_Common2(pc)
		add.w	a3,d3
		subi.w	#$10,d1
		rts
; ---------------------------------------------------------------------------

FindWall_Common2:
		jsr	(a5)			; get block address
		move.w	(a1),d0			; get block from the address
		move.w	d0,d4			; copy value
		andi.w	#$3FF,d0		; mask the block ID
		beq.s	.nocolls		; if null, branch
		btst	d5,d4			; check if this block has floor collision on current layer
		bne.s	.chkColl		; if does, branch(?)

.nocolls	move.w	#$F,d1
		move.w	d3,d0
		andi.w	#$F,d0
		sub.w	d0,d1
		rts

.chkColl	movea.l	Current_Collision.w,a2	; get current collision address
		add.w	d0,d0			; double the block value
		move.b	(a2,d0.w),d0		; and then get the collision ID
		andi.w	#$FF,d0			; keep in range of 100
		beq.s	.nocolls		; if null, branch

		lea	AngleArray,a2		; get angles
		move.b	(a2,d0.w),(a4)		; store angle
		lsl.w	#4,d0			; shift left 4 times
		move.w	d2,d1			; copy x-post

		btst	#$B,d4
		beq.s	.noyflip		; branch if not y-flipped
		not.w	d1
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

.noyflip	btst	#$A,d4
		beq.s	.noxflip		; branch if not x-flipped
		neg.b	(a4)

.noxflip	andi.w	#$F,d1			; keep x-pos within 16 pixels
		add.w	d0,d1			; add collision offset to d1

		lea	HeightMapsRot,a2
		move.b	(a2,d1.w),d0		; and then get appropriate height value
		ext.w	d0			; extend to word

		eor.w	d6,d4			; xor d4 by something?
		btst	#$A,d4
		beq.s	.noxflip2		; branch if not x-flipped
		neg.w	d0			; negate height

.noxflip2	tst.w	d0
		beq.s	.nocolls		; branch if height = 0
		bmi.s	.negHeight		; branch if height < 0

		; height > 0
		move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts

.negHeight	move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	.nocolls
		not.w	d1
		rts
; ---------------------------------------------------------------------------

CalcRoomInFront:
		move.l	Primary_Collision.w,Current_Collision.w
		cmpi.b	#$C,topsolid(a0)
		beq.s	.collset
		move.l	Secondary_Collision.w,Current_Collision.w

.collset	move.b	lrbsolid(a0),d5		; get lrb solid bits
		move.l	xpos(a0),d3		; get xpos
		move.l	ypos(a0),d2		; get ypos

		move.w	xvel(a0),d1		; get xspeed
		ext.l	d1			; extend it
		asl.l	#8,d1			; shift left
		add.l	d1,d3			; add to xpos

		move.w	yvel(a0),d1		; get yspeed
		tst.b	ReverseGravity_Flag.w
		beq.s	.noreverse		; branch if reversed gravity isnt set
		neg.w	d1			; negate y-speed

.noreverse	ext.l	d1			; extend speed
		asl.l	#8,d1			; shift left
		add.l	d1,d2			; add to y-pos
		swap	d2			;
		swap	d3			; swap x and y pos

		move.b	d0,Player_NextTilt.w	; store angles
		move.b	d0,Player_CurrentTilt.w

		move.b	d0,d1			; copy angle
		addi.b	#$20,d0			; add $20 to the angle
		bpl.s	.positive2		; branch if angle is positive

		move.b	d1,d0			; get angle back
		bpl.s	.positive		; branch if positive
		subq.b	#1,d0			; sub 1 from angle

.positive	addi.b	#$20,d0			; add $20 to the angle
		bra.s	.continue
; ---------------------------------------------------------------------------

.positive2	move.b	d1,d0			; get angle back
		bpl.s	.positive3		; branch if positive
		addq.b	#1,d0			; add 1 to the angle
.positive3	addi.b	#$1F,d0			; add $1F to the angle

.continue	andi.b	#$C0,d0			; get only 90 degree angles
		beq.w	ChkFloorDist2		; if 0, branch
		cmpi.b	#$80,d0
		beq.w	ChkCeilingDist2		; branch if 180 degree angle

		andi.b	#$38,d1
		bne.s	.0
		addq.w	#8,d2

.0		cmpi.b	#$40,d0
		beq.w	ChkWallDist_Left2	; if angle is 90
		bra.w	ChkWallDist_Right2	; else branch if angle is 270

; ---------------------------------------------------------------------------
sub_11FD6:
		tst.b	ReverseGravity_Flag.w
		beq.w	Player_CheckFloor
		bsr.w	CheckCeilingDist_Up
		addi.b	#$40,d3
		neg.b	d3
		subi.b	#$40,d3
		rts

; ---------------------------------------------------------------------------
sub_11FEE:
		tst.b	ReverseGravity_Flag.w
		beq.w	CheckCeilingDist_Up
		bsr.w	Player_CheckFloor
		addi.b	#$40,d3
		neg.b	d3
		subi.b	#$40,d3
		rts

; ---------------------------------------------------------------------------
Sonic_CheckFloorEdge:
		tst.b	ReverseGravity_Flag.w		; check if reverse gravity is active
		beq.w	ChkFloorEdge2			; branch if not active
		bra.w	ChkFloorEdge_RevGravity		; if active, check floor edge with reverse gravity
; ---------------------------------------------------------------------------
; Subroutine to calculate how much space is empty above Players head
; d0 = input angle perpendicular to the spine
; d1 = output about how many pixels are overhead (up to some high enough amount)
; ---------------------------------------------------------------------------

CalcRoomOverHead:
		move.l	Primary_Collision.w,Current_Collision.w
		cmpi.b	#$C,topsolid(a0)
		beq.s	.collset
		move.l	Secondary_Collision.w,Current_Collision.w

.collset	move.b	lrbsolid(a0),d5		; get lrb solid bits
		move.b	d0,Player_NextTilt.w	; store angles
		move.b	d0,Player_CurrentTilt.w

		addi.b	#$20,d0			; add $20 to the angle
		andi.b	#$C0,d0			; get only 90 degree angles

		cmpi.b	#$40,d0
		beq.w	CheckCeilingDist_Left	; if angle is 90
		cmpi.b	#$80,d0
		beq.w	CheckCeilingDist_Up	; if angle is 180
		cmpi.b	#$C0,d0
		beq.w	CheckCeilingDist_Right	; if angle is 270

		; if 0, we go here
; ---------------------------------------------------------------------------
; Subroutine to check if Player is near the floor
; ---------------------------------------------------------------------------
Player_CheckFloor:
		move.l	Primary_Collision.w,Current_Collision.w
		cmpi.b	#$C,topsolid(a0)
		beq.s	.collset
		move.l	Secondary_Collision.w,Current_Collision.w

.collset	move.b	topsolid(a0),d5		; get layer
		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	yrad(a0),d0		; get height
		ext.w	d0
		add.w	d0,d2			; add height to y-pos

		move.b	xrad(a0),d0		; get width
		ext.w	d0
		add.w	d0,d3			; add width to x-pos

		lea	Player_NextTilt.w,a4
		movea.w	#$10,a3
		move.w	#0,d6			; no xor
		jsr	FindFloor(pc)		; find the floor height
		move.w	d1,-(sp)		; store it

		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	yrad(a0),d0		; get height
		ext.w	d0
		add.w	d0,d2			; add height to y-pos

		move.b	xrad(a0),d0		; get width
		ext.w	d0
		sub.w	d0,d3			; sub width from x-pos

		lea	Player_CurrentTilt.w,a4
		movea.w	#$10,a3
		move.w	#0,d6			; no xor
		jsr	FindFloor(pc)		; find the floor height
		move.w	(sp)+,d0		; get stored height
		move.b	#0,d2

Player_ChkFloor_Common:		; note: still unsure what to call this
		move.b	Player_CurrentTilt.w,d3
		cmp.w	d0,d1
		ble.s	.nochange
		move.b	Player_NextTilt.w,d3
		exg	d0,d1

.nochange	btst	#0,d3
		beq.s	.rts
		move.b	d2,d3
.rts		rts
; ---------------------------------------------------------------------------
; Checks a 16x16 block to find solid ground. May check an additional
; 16x16 block up for ceilings.
; d2 = y_pos
; d3 = x_pos
; d5 = ($C, $D) or ($E, $F) - solidity type bit (L/R/B or top)
; returns relevant block ID in (a1)
; returns distance in d1
; returns angle in d3, or zero if angle was odd
; ---------------------------------------------------------------------------

ChkFloorDist:
		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

ChkFloorDist2:
		addi.w	#$A,d2
		lea	Player_NextTilt.w,a4
		movea.w	#$10,a3
		move.w	#0,d6			; no xor
		jsr	FindFloor(pc)		; find the floor height
		move.b	#0,d2

; d2 what to use as angle if (Primary_Angle).w is odd
; returns angle in d3, or value in d2 if angle was odd
ChkFloorDist3:
		move.b	Player_NextTilt.w,d3
		btst	#0,d3
		beq.s	.rts
		move.b	d2,d3
.rts		rts
; ---------------------------------------------------------------------------

sub_F828:
		move.b	xrad(a0),d0		; get width
		ext.w	d0
		add.w	d0,d2			; add width to y-pos

		lea	Player_NextTilt.w,a4
		movea.w	#$10,a3
		clr.w	d6			; no xor
		jsr	FindFloor(pc)		; find the floor height
		clr.b	d2
		bra.s	ChkFloorDist3
; ---------------------------------------------------------------------------

sub_F846:
		move.b	lrbsolid(a0),d5		; get lrb solid bits
		move.w	xpos(a0),d3		; get xpos
		move.w	ypos(a0),d2		; get ypos
		subq.w	#4,d2			; sub 4 from ypos

		move.l	Primary_Collision.w,Current_Collision.w
		cmpi.b	#$D,d5
		beq.s	.collset
		move.l	Secondary_Collision.w,Current_Collision.w

.collset	lea	Player_NextTilt.w,a4
		clr.b	(a4)
		movea.w	#$10,a3
		clr.w	d6			; no xor

		movem.l	a4-a6,-(sp)
		jsr	FindFloor(pc)		; find the floor height
		movem.l	(sp)+,a4-a6

		move.b	Player_NextTilt.w,d3
		btst	#0,d3
		beq.s	.rts
		clr.b	d3
.rts		rts
; ---------------------------------------------------------------------------

ChkFloorEdge:
		move.w	xpos(a0),d3		; get xpos

ChkFloorEdge2:
		move.w	ypos(a0),d2		; get ypos
		moveq	#0,d0
		move.b	yrad(a0),d0		; get height
		ext.w	d0
		add.w	d0,d2			; add height to y-pos

ChkFloorEdge_Part3:
		move.l	Primary_Collision.w,Current_Collision.w
		cmpi.b	#$C,topsolid(a0)
		beq.s	.collset
		move.l	Secondary_Collision.w,Current_Collision.w

.collset	lea	Player_NextTilt.w,a4
		clr.b	(a4)
		movea.w	#$10,a3
		clr.w	d6			; no xor
		move.b	topsolid(a0),d5		; get top solid bits

		movem.l	a4-a6,-(sp)
		jsr	FindFloor(pc)		; find the floor height
		movem.l	(sp)+,a4-a6

		move.b	Player_NextTilt.w,d3
		btst	#0,d3
		beq.s	.rts
		clr.b	d3
.rts		rts
; ---------------------------------------------------------------------------

PlayerOnObjFloorDist:	; check later
		move.w	xpos(a1),d3		; get xpos
		move.w	ypos(a1),d2		; get ypos

		moveq	#0,d0
		move.b	yrad(a1),d0		; get height
		ext.w	d0
		add.w	d0,d2			; add height to y-pos

		move.l	Primary_Collision.w,Current_Collision.w
		cmpi.b	#$C,topsolid(a1)
		beq.s	.collset
		move.l	Secondary_Collision.w,Current_Collision.w

.collset	lea	Player_NextTilt.w,a4
		clr.b	(a4)
		movea.w	#$10,a3
		clr.w	d6			; no xor
		move.b	topsolid(a1),d5		; get top solid bits
		jsr	FindFloor(pc)		; find the floor height

		move.b	Player_NextTilt.w,d3
		btst	#0,d3
		beq.s	.rts
		clr.b	d3
.rts		rts
; ---------------------------------------------------------------------------
; Subroutine checking if an object should interact with the floor
; (objects such as a monitor Sonic bumps from underneath)
; ---------------------------------------------------------------------------

ObjChkFloorDist:
		move.w	xpos(a0),d3		; get xpos

ObjChkFloorDist2:
		move.w	ypos(a0),d2		; get ypos
		move.b	yrad(a0),d0		; get height
		ext.w	d0
		add.w	d0,d2			; add height to y-pos

		lea	Player_NextTilt.w,a4
		clr.b	(a4)
		movea.w	#$10,a3
		clr.w	d6			; no xor
		moveq	#$C,d5			; set layer
		jsr	FindFloor(pc)		; find the floor height

		move.b	Player_NextTilt.w,d3
		btst	#0,d3
		beq.s	.rts
		clr.b	d3
.rts		rts
; ---------------------------------------------------------------------------
; Unused collision check used in S2 to let the HTZ boss fire attack hit the ground
; ---------------------------------------------------------------------------

		move.w	xpos(a1),d3		; get xpos
		move.w	ypos(a1),d2		; get ypos

		move.b	yrad(a1),d0		; get height
		ext.w	d0
		add.w	d0,d2			; add height to y-pos

		lea	Player_NextTilt.w,a4
		clr.b	(a4)
		movea.w	#$10,a3
		clr.w	d6			; no xor
		moveq	#$C,d5			; set layer
		bra.w	FindFloor		; find the floor height
; ---------------------------------------------------------------------------

RingChkFloorDist:
		move.w	xpos(a0),d3		; get xpos
		move.w	ypos(a0),d2		; get ypos

		move.b	yrad(a0),d0		; get height
		ext.w	d0
		add.w	d0,d2			; add height to y-pos

		lea	Player_NextTilt.w,a4
		clr.b	(a4)
		movea.w	#$10,a3
		clr.w	d6			; no xor
		moveq	#$C,d5			; set layer
		jmp	ObjFindFloor(pc)	; find floor
; ---------------------------------------------------------------------------

CheckCeilingDist_Right:
		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	xrad(a0),d0		; get width
		ext.w	d0
		sub.w	d0,d2			; sub height from y-pos

		move.b	yrad(a0),d0		; get height
		ext.w	d0
		add.w	d0,d3			; add height to x-pos

		lea	Player_NextTilt.w,a4
		movea.w	#$10,a3
		clr.w	d6			; no xor
		jsr	FindWall(pc)		; find wall width
		move.w	d1,-(sp)		; store width

		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	xrad(a0),d0		; get width
		ext.w	d0
		add.w	d0,d2			; add height to y-pos

		move.b	yrad(a0),d0		; get height
		ext.w	d0
		add.w	d0,d3			; add height to x-pos

		lea	Player_CurrentTilt.w,a4
		movea.w	#$10,a3
		clr.w	d6			; no xor
		jsr	FindWall(pc)		; find wall width
		move.w	(sp)+,d0		; get stored width

		moveq	#-$40,d2
		bra.w	Player_ChkFloor_Common	; get the angle
; ---------------------------------------------------------------------------

sub_FA1A:
		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	yrad(a0),d0		; get height
		ext.w	d0
		sub.w	d0,d2			; sub height from y-pos

		move.b	xrad(a0),d0		; get width
		ext.w	d0
		add.w	d0,d3			; add width to x-pos

		lea	Player_NextTilt.w,a4
		movea.w	#$10,a3
		clr.w	d6			; no xor
		jsr	FindWall(pc)		; find wall width
		move.w	d1,-(sp)		; store width

		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	yrad(a0),d0		; get height
		ext.w	d0
		add.w	d0,d2			; add height to y-pos

		move.b	xrad(a0),d0		; get width
		ext.w	d0
		add.w	d0,d3			; add width to x-pos

		lea	Player_CurrentTilt.w,a4
		movea.w	#$10,a3
		clr.w	d6			; no xor
		jsr	FindWall(pc)		; find wall width
		move.w	(sp)+,d0		; get stored width

		moveq	#-$40,d2
		bra.w	Player_ChkFloor_Common	; get the angle
; ---------------------------------------------------------------------------

CheckRightWallDist:
		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

ChkWallDist_Right2:
		addi.w	#$A,d3
		lea	Player_NextTilt.w,a4
		movea.w	#$10,a3
		clr.w	d6			; no xor
		jsr	FindWall(pc)		; find wall width
		moveq	#-$40,d2
		bra.w	ChkFloorDist3		; get floor distance
; ---------------------------------------------------------------------------

ChkWallDist2_Right:
		move.b	xrad(a0),d0		; get width
		ext.w	d0
		add.w	d0,d3			; add width to x-pos

		lea	Player_NextTilt.w,a4
		movea.w	#$10,a3
		clr.w	d6			; no xor
		jsr	FindWall(pc)		; find wall width

		moveq	#-$40,d2
		bra.w	ChkFloorDist3		; get floor distance
; ---------------------------------------------------------------------------

ObjChkWallDist_Right:
		add.w	xpos(a0),d3		; add xpos to d3
		move.w	ypos(a0),d2		; get ypos

		lea	Player_NextTilt.w,a4
		clr.b	(a4)
		movea.w	#$10,a3
		clr.w	d6			; no xor
		moveq	#$D,d5			; layer 2(?)
		jsr	FindWall(pc)		; find wall width

		move.b	Player_NextTilt.w,d3
		btst	#0,d3
		beq.s	.rts
		moveq	#-$40,d3
.rts		rts
; ---------------------------------------------------------------------------

CheckCeilingDist_Up:
		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	yrad(a0),d0		; get height
		ext.w	d0
		sub.w	d0,d2			; sub height from y-pos
		eori.w	#$F,d2			; xor $F

		move.b	xrad(a0),d0		; get width
		ext.w	d0
		add.w	d0,d3			; add width to x-pos

		lea	Player_NextTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6		; xor y-flip bit
		jsr	FindFloor(pc)		; find the floor height
		move.w	d1,-(sp)		; store height

		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	yrad(a0),d0		; get height
		ext.w	d0
		sub.w	d0,d2			; sub height from y-pos
		eori.w	#$F,d2			; xor $F

		move.b	xrad(a0),d0		; get width
		ext.w	d0
		sub.w	d0,d3			; sub width from x-pos

		lea	Player_CurrentTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6		; xor y-flip bit
		jsr	FindFloor(pc)		; find the floor height
		move.w	(sp)+,d0		; get stored height

		move.b	#-$80,d2
		bra.w	Player_ChkFloor_Common	; get the angle
; ---------------------------------------------------------------------------

ChkCeilingDist_RevGravity:
		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	yrad(a0),d0		; get height
		ext.w	d0
		sub.w	d0,d2			; sub height from y-pos
		eori.w	#$F,d2			; xor $F

		move.b	xrad(a0),d0		; get width
		ext.w	d0
		subq.w	#2,d0			; sub 2 from width
		add.w	d0,d3			; add width to x-pos

		lea	Player_NextTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6		; xor y-flip bit
		jsr	FindFloor(pc)		; find the floor height
		move.w	d1,-(sp)		; store height

		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	yrad(a0),d0		; get height
		ext.w	d0
		sub.w	d0,d2			; sub height from y-pos
		eori.w	#$F,d2			; xor $F

		move.b	xrad(a0),d0		; get width
		ext.w	d0
		subq.w	#2,d0			; sub 2 from width
		sub.w	d0,d3			; sub width from x-pos

		lea	Player_CurrentTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6		; xor y-flip bit
		jsr	FindFloor(pc)		; find the floor height
		move.w	(sp)+,d0		; get stored height

		moveq	#-$80,d2
		bra.w	Player_ChkFloor_Common	; get the angle
; ---------------------------------------------------------------------------

ChkCeilingDist:
		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

ChkCeilingDist2:
		subi.w	#$A,d2			; sub 10 from ypos
		eori.w	#$F,d2			; xor $F

		lea	Player_NextTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6		; xor y-flip bit
		jsr	FindFloor(pc)		; find the floor height

		moveq	#-$80,d2
		bra.w	ChkFloorDist3		; get the distance
; ---------------------------------------------------------------------------

sub_FBEE:
		move.b	xrad(a0),d0		; get width
		ext.w	d0
		sub.w	d0,d2			; sub width from y-pos
		eori.w	#$F,d2			; xor $F

		lea	Player_NextTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6		; xor y-flip bit
		jsr	FindFloor(pc)		; find the floor height

		moveq	#-$80,d2
		bra.w	ChkFloorDist3		; get the distance
; ---------------------------------------------------------------------------

ObjChkCeilingDist_Up:
		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	yrad(a0),d0		; get height
		ext.w	d0
		sub.w	d0,d2			; sub height from y-pos
		eori.w	#$F,d2			; xor $F

		lea	Player_NextTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6		; xor y-flip bit
		moveq	#$D,d5			; layer 2(?)
		jsr	FindFloor(pc)		; find the floor height

		move.b	Player_NextTilt.w,d3
		btst	#0,d3
		beq.s	.rts
		moveq	#-$80,d3
.rts		rts
; ---------------------------------------------------------------------------

ChkFloorEdge_RevGravity:
		move.w	ypos(a0),d2		; get ypos
		moveq	#0,d0
		move.b	yrad(a0),d0		; get height
		ext.w	d0
		sub.w	d0,d2			; sub height from y-pos
		eori.w	#$F,d2			; xor $F

ChkFloorEdge2_RevGravity:
		move.l	Primary_Collision.w,Current_Collision.w
		cmpi.b	#$C,topsolid(a0)
		beq.s	.collset
		move.l	Secondary_Collision.w,Current_Collision.w

.collset	lea	Player_NextTilt.w,a4
		move.b	#0,(a4)
		movea.w	#-$10,a3
		move.w	#$800,d6		; xor y-flip bit
		move.b	topsolid(a0),d5		; get collision layer

		movem.l	a4-a6,-(sp)
		jsr	FindFloor(pc)		; find the floor height
		movem.l	(sp)+,a4-a6

		move.b	Player_NextTilt.w,d3
		btst	#0,d3
		beq.s	.rts
		clr.b	d3
.rts		rts
; ---------------------------------------------------------------------------

RingRevChkFloorDist:
		move.w	xpos(a0),d3		; get xpos
		move.w	ypos(a0),d2		; get ypos

		move.b	yrad(a0),d0		; get height
		ext.w	d0
		sub.w	d0,d2			; sub height from y-pos
		eori.w	#$F,d2			; xor $F

		lea	Player_NextTilt.w,a4
		clr.b	(a4)
		movea.w	#-$10,a3
		move.w	#$800,d6		; xor y-flip bit
		moveq	#$C,d5			; set to layer 1
		jmp	ObjFindFloor(pc)	; find floor height
; ---------------------------------------------------------------------------

CheckCeilingDist_Left:
		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	xrad(a0),d0		; get width
		ext.w	d0
		sub.w	d0,d2			; sub width from y-pos

		move.b	yrad(a0),d0		; get height
		ext.w	d0
		sub.w	d0,d3			; sub height from x-pos
		eori.w	#$F,d3			; xor $F

		lea	Player_NextTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6		; xor x-flip bit
		jsr	FindWall(pc)		; find wall width
		move.w	d1,-(sp)		; store width

		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	xrad(a0),d0		; get width
		ext.w	d0
		add.w	d0,d2			; add width to y-pos

		move.b	yrad(a0),d0		; get height
		ext.w	d0
		sub.w	d0,d3			; sub height from x-pos
		eori.w	#$F,d3			; xor $F

		lea	Player_CurrentTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6		; xor x-flip bit
		jsr	FindWall(pc)		; find wall width
		move.w	(sp)+,d0		; get stored width

		move.b	#$40,d2
		bra.w	Player_ChkFloor_Common	; get the angle
; ---------------------------------------------------------------------------

sub_FD32:
		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	yrad(a0),d0		; get height
		ext.w	d0
		sub.w	d0,d2			; sub height from y-pos

		move.b	xrad(a0),d0		; get width
		ext.w	d0
		sub.w	d0,d3			; sub width from y-pos
		eori.w	#$F,d3			; xor $F

		lea	Player_NextTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6		; xor x-flip bit
		jsr	FindWall(pc)		; find wall width
		move.w	d1,-(sp)		; store width

		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

		moveq	#0,d0
		move.b	yrad(a0),d0		; get height
		ext.w	d0
		add.w	d0,d2			; add height to y-pos

		move.b	xrad(a0),d0		; get width
		ext.w	d0
		sub.w	d0,d3			; sub width from y-pos
		eori.w	#$F,d3			; xor $F

		lea	Player_CurrentTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6		; xor x-flip bit
		jsr	FindWall(pc)		; find wall width
		move.w	(sp)+,d0		; get stored width

		moveq	#$40,d2
		bra.w	Player_ChkFloor_Common	; get the angle
; ---------------------------------------------------------------------------

ChkWallDist_Left:
		move.w	ypos(a0),d2		; get ypos
		move.w	xpos(a0),d3		; get xpos

ChkWallDist_Left2:
		subi.w	#$A,d3			; sub 10 from xpos
		eori.w	#$F,d3			; xor $F

		lea	Player_NextTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6		; xor x-flip bit
		jsr	FindWall(pc)		; find wall width

		moveq	#$40,d2
		bra.w	ChkFloorDist3		; find floor height
; ---------------------------------------------------------------------------

ChkWallDist2_Left:
		move.b	xrad(a0),d0		; get width
		ext.w	d0
		sub.w	d0,d3			; sub width from y-pos
		eori.w	#$F,d3			; xor $F

		lea	Player_NextTilt.w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6		; xor x-flip bit
		jsr	FindWall(pc)		; find wall width

		moveq	#$40,d2
		bra.w	ChkFloorDist3		; find floor height
; ---------------------------------------------------------------------------

sub_FDEC:
		move.l	Primary_Collision.w,Current_Collision.w
		cmpi.b	#$C,topsolid(a0)
		beq.s	.collset
		move.l	Secondary_Collision.w,Current_Collision.w

.collset	move.w	xpos(a0),d3		; get xpos
		move.w	ypos(a0),d2		; get ypos

		move.b	yrad(a0),d0		; get height
		ext.w	d0
		sub.w	d0,d3			; sub height from x-pos
		eori.w	#$F,d3			; xor $F

		lea	Player_NextTilt.w,a4
		move.b	#0,(a4)
		movea.w	#-$10,a3
		move.w	#$400,d6		; xor x-flip bit
		move.b	lrbsolid(a0),d5		; get layer(?)
		jsr	FindWall(pc)		; find wall width

		move.b	Player_NextTilt.w,d3
		btst	#0,d3
		beq.s	.rts
		moveq	#$40,d3
.rts		rts
; ---------------------------------------------------------------------------

ObjChkWallDist_Left:
		add.w	xpos(a0),d3		; add xpos to d3
		eori.w	#$F,d3			; xor $F

ObjChkWallDist_Left2:
		move.w	ypos(a0),d2		; get ypos
		lea	Player_NextTilt.w,a4
		clr.b	(a4)
		movea.w	#-$10,a3
		move.w	#$400,d6		; xor x-flip bit
		moveq	#$D,d5			; layer 2
		jsr	FindWall(pc)		; find wall width

		move.b	Player_NextTilt.w,d3
		btst	#0,d3
		beq.s	.rts
		moveq	#$40,d3
.rts		rts
; ---------------------------------------------------------------------------
