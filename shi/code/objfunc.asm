
AnimateSprite:
		moveq	#0,d0
		move.b	$20(a0),d0
		cmp.b	$21(a0),d0
		beq.s	loc_1AC00
		move.b	d0,$21(a0)
		clr.b	$23(a0)
		clr.b	$24(a0)

loc_1AC00:
		subq.b	#1,$24(a0)
		bhs.s	locret_1AC36
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		move.b	(a1),$24(a0)
		moveq	#0,d1
		move.b	$23(a0),d1
		move.b	1(a1,d1.w),d0
		bmi.s	loc_1AC38

loc_1AC1C:
		move.b	d0,$22(a0)
		move.b	$2A(a0),d1
		andi.b	#3,d1
		andi.b	#-4,4(a0)
		or.b	d1,4(a0)
		addq.b	#1,$23(a0)


; ---------------------------------------------------------------------------

locret_1AC36:
		rts


; ---------------------------------------------------------------------------

loc_1AC38:
		addq.b	#1,d0
		bne.s	loc_1AC48
		move.b	#0,$23(a0)
		move.b	1(a1),d0
		bra.s	loc_1AC1C


; ---------------------------------------------------------------------------

loc_1AC48:
		addq.b	#1,d0
		bne.s	loc_1AC5C
		move.b	2(a1,d1.w),d0
		sub.b	d0,$23(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_1AC1C


; ---------------------------------------------------------------------------

loc_1AC5C:
		addq.b	#1,d0
		bne.s	loc_1AC68
		move.b	2(a1,d1.w),$20(a0)
		rts


; ---------------------------------------------------------------------------

loc_1AC68:
		addq.b	#1,d0
		bne.s	loc_1AC7A
		addq.b	#2,5(a0)
		clr.b	$24(a0)
		addq.b	#1,$23(a0)
		rts


; ---------------------------------------------------------------------------

loc_1AC7A:
		addq.b	#1,d0
		bne.s	locret_1AC86
		move.w	#$7F00,$10(a0)
		rts


; End of function AnimateSprite
; ############### S U B	R O U T	I N E #######################################

locret_1AC86:
		rts

AnimateSprite2:
		moveq	#0,d0
		move.b	$20(a0),d0
		cmp.b	$21(a0),d0
		beq.s	loc_1ACA0
		move.b	d0,$21(a0)
		clr.b	$23(a0)
		clr.b	$24(a0)

loc_1ACA0:
		subq.b	#1,$24(a0)
		bhs.s	locret_1ACDA
		add.w	d0,d0
		adda.w	(a1,d0.w),a1
		moveq	#0,d1
		move.b	$23(a0),d1
		add.w	d1,d1
		move.b	(a1,d1.w),d0
		bmi.s	loc_1ACDC

loc_1ACBA:
		move.b	1(a1,d1.w),$24(a0)
		move.b	d0,$22(a0)
		move.b	$2A(a0),d1
		andi.b	#3,d1
		andi.b	#-4,4(a0)
		or.b	d1,4(a0)
		addq.b	#1,$23(a0)


; ---------------------------------------------------------------------------

locret_1ACDA:
		rts


; ---------------------------------------------------------------------------

loc_1ACDC:
		addq.b	#1,d0
		bne.s	loc_1ACEA
		moveq	#0,d1
		move.b	d1,$23(a0)
		move.b	(a1),d0
		bra.s	loc_1ACBA
; ---------------------------------------------------------------------------

loc_1ACEA:
		addq.b	#1,d0
		bne.s	loc_1AD00
		move.b	1(a1,d1.w),d0
		sub.b	d0,$23(a0)
		add.w	d0,d0
		sub.b	d0,d1
		move.b	(a1,d1.w),d0
		bra.s	loc_1ACBA
; ---------------------------------------------------------------------------

loc_1AD00:
		addq.b	#1,d0
		bne.s	loc_1AD0C
		move.b	1(a1,d1.w),$20(a0)
		rts
; ---------------------------------------------------------------------------

loc_1AD0C:
		addq.b	#1,d0
		bne.s	locret_1AD1E
		addq.b	#2,5(a0)
		clr.b	$24(a0)
		addq.b	#1,$23(a0)

locret_1AD1E:
		rts
; ---------------------------------------------------------------------------

ProcessObjects:
		tst.b	Stop_Referenced_Objs.w
		bne.s	.rts				; if set, dont load objects
		lea	Object_RAM.w,a0			; get object RAM to a0
		cmpi.b	#$C,Object_RAM+routine.w
		beq.s	.normal
		cmpi.b	#6,Object_RAM+routine.w
		bhs.s	.dead				; if player is dead, branch

.normal		moveq	#(Object_RAM_free-Object_RAM)/objsize-1,d7
		bsr.s	.objectsloop
		clr.w	Coll_response_list.w
		moveq	#(Object_RAM_End-Object_RAM_free)/objsize-1,d7

.objectsloop	move.l	(a0),d0				; get object address
		beq.s	.nextobj			; if null, branch
		movea.l	d0,a1				; get object to a1
		jsr	(a1)				; run its code

.nextobj	lea	objsize(a0),a0			; get next object
		dbf	d7,.objectsloop			; keep looping for all objects
.rts		rts
; ---------------------------------------------------------------------------

.dead		moveq	#(Object_RAM_free-Object_RAM)/objsize-1,d7
		bsr.s	.objectsloop
		clr.w	Coll_response_list.w
		moveq	#(Object_RAM_static-Object_RAM_free)/objsize-1,d7
		bsr.s	.disp
		moveq	#(Object_RAM_End-Object_RAM_static)/objsize-1,d7
		bra.s	.objectsloop
; ---------------------------------------------------------------------------

.disp		tst.l	(a0)				; get object address
		beq.s	.nodisp				; if null, branch
		tst.b	render(a0)
		bpl.s	.nodisp				; branch if offscreen
		jsr	DrawSprite(pc)			; else draw the sprite

.nodisp		lea	objsize(a0),a0			; get next object
		dbf	d7,.disp			; keep looping for all objects
		rts
; ---------------------------------------------------------------------------

BuildSprites:
		moveq	#80-1,d7			; do 80 sprite pieces
		moveq	#0,d6				; clear render flags

		lea	Sprite_table_input.w,a5		; get list of sprites to display
		lea	Camera_X_Copy.w,a3		; get camera position for quick access
		lea	Sprite_Attribute_Table.w,a6	; get sprite attribution table

		tst.b	Level_Start_Flag.w
		beq.s	.nextlayer			; branch if should not be showing HUD yet
		jsr	BuildHUD			; build the HUD
		jsr	BuildRings			; build rings

.nextlayer	tst.w	(a5)				; do we have any objects?
		beq.w	.nextlevel			; if not, check next level
		lea	2(a5),a4			; get pointer to objects

.doobj		movea.w	(a4)+,a0			; get address of the object
		andi.b	#$7F,render(a0)			; clear onscreen bit
		move.b	render(a0),d6			; get render flags
		move.w	xpos(a0),d0			; get x-position
		move.w	ypos(a0),d1			; get y-position

		btst	#6,d6				; is bit 6 of render flags set?
		bne.w	.childs				; if so, branch to draw child sprites as well
		btst	#2,d6				; is bit 2 of render flags set?
		beq.s	.onscreen			; if not, branch to draw onscreen as opposed to on level

		moveq	#0,d2
		move.b	width(a0),d2			; get object width
		sub.w	(a3),d0				; sub camera x from object xpos
		move.w	d0,d3				; copy the result
		add.w	d2,d3				; add object width
		bmi.s	.nextobj			; if negative still, this is offscreen, ignore it

		move.w	d0,d3				; copy relative x again
		sub.w	d2,d3				; sub width from relative x
		cmpi.w	#320,d3				; is object offscreen?
		bge.s	.nextobj			; if so, ignore this object

		addi.w	#128,d0				; add this much to relative x
		sub.w	Camera_Y_Copy-Camera_X_Copy(a3),d1; sub camera y from ypos
		move.b	height(a0),d2			; get object height
		add.w	d2,d1				; add height to ypos
		and.w	Screen_Y_wrap_value.w,d1	; and with the Y-wrap value

		move.w	d2,d3				; store height
		add.w	d2,d2				; double height
		addi.w	#224,d2				; add screen height to to d2
		cmp.w	d2,d1				; compare against relative object ypos
		bhs.s	.nextobj			; if offscreen, ignore object

		addi.w	#128,d1				; add this much to relative y
		sub.w	d3,d1				; sub object height from relative y

.onscreen	ori.b	#$80,render(a0)			; set onscreen bit
		tst.w	d7				; check if we should render more sprite pieces
		bmi.s	.nextobj			; if not, branch

		movea.l	mappings(a0),a1			; get mappings address
		moveq	#0,d4				; set amount of sprite pieces to 1
		btst	#5,d6				; test direct sprite flag
		bne.s	.directsprite			; if set, render sprite piece from a1

		move.b	frame(a0),d4			; get mappings frame
		add.w	d4,d4				; double it
		adda.w	(a1,d4.w),a1			; get the final sprite position
		move.w	(a1)+,d4			; get sprite piece amount
		subq.w	#1,d4				; sub 1 from the sprite piece amount
		bmi.s	.nextobj			; if negative, there is 0 sprite pieces. skip.

.directsprite	move.w	tile(a0),d5			; get art tile address
		jsr	DrawSpritePiece(pc)		; render this sprite

.nextobj	subq.w	#2,(a5)				; sub from object count
		bne.w	.doobj				; if there are objects left, branch

.nextlevel	lea	PriorLayerObjs*2(a5),a5		; next priority layer
		cmpa.l	#Sprite_table_input+SpriteTableSize,a5; check if this is the table end?
		blo.w	.nextlayer			; if not, branch
		move.w	d7,d6				; get the amount of sprites left
		bmi.s	.skipclr			; if none were, branch

		moveq	#0,d0				; clear d0
.nullsprites	move.w	d0,(a6)				; clear sprite
		addq.w	#8,a6				; increment to next sprite
		dbf	d7,.nullsprites			; loop until all are done

.skipclr	subi.w	#80-1,d6			; sub 80 from sprite count
		neg.w	d6				; negate
		move.b	d6,Sprite_Count.w		; and then store sprite amount

		; at this point I am not sure what any of this is
		tst.w	Sprite_Draw_Flag.w
		beq.s	.rts
		cmpi.b	#6,Object_RAM+routine.w
		bhs.s	.0				; branch if Sonic is dead
		clr.w	Sprite_Draw_Flag.w

.0		lea	Level_Anim+$C.w,a0
		move.w	#$7C0,d0
		moveq	#79-1,d1

.1		addq.w	#8,a0
		cmp.w	(a0),d0
		dbeq	d1,.1
		bne.s	.rts

		move.w	#1,2(a0)
		clr.w	$A(a0)
		subq.w	#1,d1
		bpl.s	.1
.rts		rts
; ---------------------------------------------------------------------------

.childs		btst	#2,d6				; is bit 2 of render flags set?
		bne.s	.childs2			; if not, don't branch to draw onscreen as opposed to on level

		moveq	#0,d2
		move.b	width(a0),d2			; get object width
		subi.w	#128,d0				; sub this amount from xpos
		move.w	d0,d3				; copy the result
		add.w	d2,d3				; add width to xpos
		bmi.w	.nextobj			; if negative still, this is offscreen, ignore it

		move.w	d0,d3				; copy xpos again
		sub.w	d2,d3				; sub width from xpos
		cmpi.w	#320,d3				; is object offscreen?
		bge.w	.nextobj			; if so, ignore this object
		addi.w	#128,d0				; add 128 back to xpos

		move.b	height(a0),d2			; get object height
		subi.w	#128,d1				; sub this amount from ypos
		move.w	d1,d3				; copy the result
		add.w	d2,d3				; add height to ypos
		bmi.w	.nextobj			; if negative still, this is offscreen, ignore it

		move.w	d1,d3				; copy ypos again
		sub.w	d2,d3				; sub height from ypos
		cmpi.w	#224,d3				; is object offscreen?
		bge.w	.nextobj			; if so, ignore this object
		addi.w	#128,d1				; add 128 back to ypos
		bra.s	.common				; branch
; ---------------------------------------------------------------------------

.childs2	moveq	#0,d2
		move.b	width(a0),d2			; get object width
		sub.w	(a3),d0				; sub camera x from object xpos
		move.w	d0,d3				; copy the result
		add.w	d2,d3				; add width to xpos
		bmi.w	.nextobj			; if negative still, this is offscreen, ignore it

		move.w	d0,d3				; copy xpos again
		sub.w	d2,d3				; sub width from xpos
		cmpi.w	#320,d3				; is object offscreen?
		bge.w	.nextobj			; if so, ignore this object

		addi.w	#128,d0				; add this much to relative x
		sub.w	Camera_Y_Copy-Camera_X_Copy(a3),d1; sub camera y from ypos
		move.b	height(a0),d2			; get object height
		add.w	d2,d1				; add height to ypos
		and.w	Screen_Y_wrap_value.w,d1	; and with the Y-wrap value

		move.w	d2,d3				; store height
		add.w	d2,d2				; double height
		addi.w	#224,d2				; add screen height to to d2
		cmp.w	d2,d1				; compare against relative object ypos
		bhs.w	.nextobj			; if offscreen, ignore object

		addi.w	#128,d1				; add this much to relative y
		sub.w	d3,d1				; sub object height from relative y

.common		ori.b	#$80,render(a0)			; set onscreen bit
		tst.w	d7				; check if we should render more sprite pieces
		bmi.w	.nextobj			; if not, branch

		move.w	tile(a0),d5			; get art tile address
		movea.l	mappings(a0),a2			; get mappings address
		moveq	#0,d4				; set amount of sprite pieces to 1
		move.b	frame(a0),d4			; get mappings frame
		beq.s	.nomap				; branch if o

		add.w	d4,d4				; double it
		lea	(a2),a1				; copy mappings address to a1
		adda.w	(a1,d4.w),a1			; get the final sprite position
		move.w	(a1)+,d4			; get sprite piece amount
		subq.w	#1,d4				; sub 1 from the sprite piece amount
		bmi.s	.nomap				; if negative, there is 0 sprite pieces. skip.

		move.w	d6,d3				; copy render flags elsewher
		jsr	DrawSpritePiece2(pc)		; render this sprite
		move.w	d3,d6				; and copy it back
		tst.w	d7				; check if we should render more sprite pieces
		bmi.w	.nextobj			; if not, branch

.nomap		move.w	childnum(a0),d3			; get number of child sprites
		subq.w	#1,d3				; sub 1 from it
		blo.w	.nextobj			; if less than 0, branch
		lea	childdata(a0),a0		; get the child data to a0

.nextsprite	move.w	(a0)+,d0			; get xpos
		move.w	(a0)+,d1			; get ypos
		btst	#2,d6				; is bit 2 of render flags set?
		beq.s	.onscreen2			; if not, branch to draw onscreen as opposed to on level

		sub.w	(a3),d0				; sub camera x from object xpos
		addi.w	#128,d0				; add 128 to relative x
		sub.w	Camera_Y_Copy-Camera_X_Copy(a3),d1; sub camera y from ypos
		addi.w	#128,d1				; add 128 to relative x
		and.w	Screen_Y_wrap_value.w,d1	; and with the Y-wrap value

.onscreen2	addq.w	#1,a0				; skip unused byte
		moveq	#0,d4				; set amount of sprite pieces to 1
		move.b	(a0)+,d4			; get mappings frame
		add.w	d4,d4				; double it

		lea	(a2),a1				; copy mappings address to a1
		adda.w	(a1,d4.w),a1			; get the final sprite position
		move.w	(a1)+,d4			; get sprite piece amount
		subq.w	#1,d4				; sub 1 from the sprite piece amount
		bmi.s	.nextchild			; if negative, there is 0 sprite pieces. skip.

		move.w	d6,-(sp)			; store render flags
		jsr	DrawSpritePiece2(pc)		; render this sprite
		move.w	(sp)+,d6			; get stored render flags

.nextchild	tst.w	d7				; check if we should render more sprite pieces
		dbmi	d3,.nextsprite			; if so, keep looping
		bra.w	.nextobj

; ---------------------------------------------------------------------------
; input:
; d0 = horizontal offset
; d1 = vertical offset
; d4 = amount of sprite pieces
; d5 = art tile
; d6 = render flags
; d7 = sprite pieces left
; a1 = mappings data address
; a6 = sprite attribution table address
; ---------------------------------------------------------------------------
DrawSpritePiece:
		lsr.b	#1,d6
		blo.s	DrawSpritePiece_FlipX	; branch if X-flipped
		lsr.b	#1,d6
		blo.w	DrawSpritePiece_FlipY	; branch if only Y-flipped

.dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		add.w	d1,d2			; add y-offset to y-position
		move.w	d2,(a6)+		; put the y-pos to table

		move.b	(a1)+,(a6)+		; copy size to table
		addq.w	#1,a6			; add 1 to the table address (skip empty byte)

		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		add.w	d0,d2			; add x-offset to x-position
		andi.w	#$1FF,d2		; keep in range
		bne.s	.0			; branch if 0?
		addq.w	#1,d2			; add 1 to xpos
.0		move.w	d2,(a6)+		; store x-pos to the table

		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,.dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts
; ---------------------------------------------------------------------------

DrawSpritePiece_FlipX:
		lsr.b	#1,d6
		blo.s	DrawSpritePiece_FlipXY	; branch if XY-flipped

.dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		add.w	d1,d2			; add y-offset to y-position
		move.w	d2,(a6)+		; put the y-pos to table

		move.b	(a1)+,d6		; get sprite size
		move.b	d6,(a6)+		; put it to the table
		addq.w	#1,a6			; add 1 to the table address (skip empty byte)

		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		eori.w	#$800,d2		; flip X-flip bit
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		neg.w	d2			; negate it
		move.b	DrawSprPiece_XOffs(pc,d6.w),d6; get x-offset based on sprite size
		sub.w	d6,d2			; sub the offset from x-pos
		add.w	d0,d2			; add x-offset to x-position
		andi.w	#$1FF,d2		; keep in range
		bne.s	.0			; branch if 0?
		addq.w	#1,d2			; add 1 to xpos
.0		move.w	d2,(a6)+		; store x-pos to the table

		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,.dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts

; ---------------------------------------------------------------------------
DrawSprPiece_XOffs:
	dcb.b 4, $08; 4x $08
	dcb.b 4, $10; 4x $10
	dcb.b 4, $18; 4x $18
	dcb.b 4, $20; 4x $20
; ---------------------------------------------------------------------------

DrawSpritePiece_FlipXY:
.dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		neg.w	d2			; negate it

		move.b	(a1),d6			; get sprite size
		move.b	DrawSprPiece_YOffs(pc,d6.w),d6; get y-offset based on sprite size
		sub.w	d6,d2			; sub the offset from y-pos
		add.w	d1,d2			; add y-offset to y-position
		move.w	d2,(a6)+		; put the y-pos to table

		move.b	(a1)+,d6		; get sprite size
		move.b	d6,(a6)+		; put it to the table
		addq.w	#1,a6			; add 1 to the table address (skip empty byte)

		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		eori.w	#$1800,d2		; flip X-flip and y-flip bits
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		neg.w	d2			; negate it
		move.b	DrawSprPiece_XOffs(pc,d6.w),d6; get x-offset based on sprite size
		sub.w	d6,d2			; sub the offset from x-pos
		add.w	d0,d2			; add x-offset to x-position
		andi.w	#$1FF,d2		; keep in range
		bne.s	.0			; branch if 0?
		addq.w	#1,d2			; add 1 to xpos
.0		move.w	d2,(a6)+		; store x-pos to the table

		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,.dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts

; ---------------------------------------------------------------------------
DrawSprPiece_YOffs:
	rept 4	; 4x $08, $10, $18, $20
		dc.b $08, $10, $18, $20
	endr
; ---------------------------------------------------------------------------

DrawSpritePiece_FlipY:
.dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		neg.w	d2			; negate it
		move.b	(a1)+,d6		; get sprite size
		move.b	d6,2(a6)		; put it to the table

		move.b	DrawSprPiece_YOffs(pc,d6.w),d6; get y-offset based on sprite size
		sub.w	d6,d2			; sub the offset from y-pos
		add.w	d1,d2			; add y-offset to y-position
		move.w	d2,(a6)+		; put the y-pos to table

		addq.w	#2,a6			; add 2 to the table address (skip empty byte and sprite size we saved ealier)
		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		eori.w	#$1000,d2		; flip Y-flip bit
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		add.w	d0,d2			; add x-offset to x-position
		andi.w	#$1FF,d2		; keep in range
		bne.s	.0			; branch if 0?
		addq.w	#1,d2			; add 1 to xpos
.0		move.w	d2,(a6)+		; store x-pos to the table

		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,.dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts
; ---------------------------------------------------------------------------
; input:
; d0 = horizontal offset
; d1 = vertical offset
; d4 = amount of sprite pieces
; d5 = art tile
; d6 = render flags
; d7 = sprite pieces left
; a1 = mappings data address
; a6 = sprite attribution table address
; ---------------------------------------------------------------------------

DrawSpritePiece2:
		lsr.b	#1,d6
		blo.s	DrawSpritePiece2_FlipX	; branch if X-flipped
		lsr.b	#1,d6
		blo.w	DrawSpritePiece2_FlipY	; branch if only Y-flipped

.dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		add.w	d1,d2			; add y-offset to y-position

		cmpi.w	#96,d2
		bls.s	.offscreen		; branch if too high offscreen
		cmpi.w	#352,d2
		bhs.s	.offscreen		; branch if too low offscreen
		move.w	d2,(a6)+		; put the y-pos to table

		move.b	(a1)+,(a6)+		; copy size to table
		addq.w	#1,a6			; add 1 to the table address (skip empty byte)

		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		add.w	d0,d2			; add x-offset to x-position
		cmpi.w	#96,d2
		bls.s	.gobacksprite		; branch if too left offscreen
		cmpi.w	#448,d2
		bhs.s	.gobacksprite		; branch if too right offscreen

		move.w	d2,(a6)+		; store x-pos to the table
		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,.dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts

.gobacksprite	subq.w	#6,a6			; sub 6 from sprite table address, to be overwritten later
		dbf	d4,.dopiece		; loop for rest of the sprites
		rts

.offscreen	addq.w	#5,a1			; skip rest of the mappings data
		dbf	d4,.dopiece		; loop for rest of the sprites
		rts
; ---------------------------------------------------------------------------

DrawSpritePiece2_FlipX:
		lsr.b	#1,d6
		blo.s	DrawSpritePiece2_FlipXY	; branch if XY-flipped

.dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		add.w	d1,d2

		cmpi.w	#96,d2
		bls.s	.offscreen		; branch if too high offscreen
		cmpi.w	#352,d2
		bhs.s	.offscreen		; branch if too low offscreen
		move.w	d2,(a6)+		; put the y-pos to table

		move.b	(a1)+,d6		; get sprite size
		move.b	d6,(a6)+		; put it to the table
		addq.w	#1,a6			; add 1 to the table address (skip empty byte)

		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		eori.w	#$800,d2		; flip X-flip bit
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		neg.w	d2			; negate it
		move.b	DrawSprPiece2_XOffs(pc,d6.w),d6; get x-offset based on sprite size
		sub.w	d6,d2			; sub the offset from x-pos
		add.w	d0,d2			; add x-offset to x-position

		cmpi.w	#96,d2
		bls.s	.gobacksprite		; branch if too left offscreen
		cmpi.w	#448,d2
		bhs.s	.gobacksprite		; branch if too right offscreen
		move.w	d2,(a6)+		; put the y-pos to table

		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,.dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts

.gobacksprite	subq.w	#6,a6			; sub 6 from sprite table address, to be overwritten later
		dbf	d4,.dopiece		; loop for rest of the sprites
		rts

.offscreen	addq.w	#5,a1			; skip rest of the mappings data
		dbf	d4,.dopiece		; loop for rest of the sprites
		rts

; ---------------------------------------------------------------------------
DrawSprPiece2_XOffs:
	dcb.b 4, $08; 4x $08
	dcb.b 4, $10; 4x $10
	dcb.b 4, $18; 4x $18
	dcb.b 4, $20; 4x $20
; ---------------------------------------------------------------------------

DrawSpritePiece2_FlipXY:
.dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		neg.w	d2			; negate it

		move.b	(a1),d6			; get sprite size
		move.b	DrawSprPiece2_YOffs(pc,d6.w),d6; get y-offset based on sprite size
		sub.w	d6,d2			; sub the offset from y-pos
		add.w	d1,d2			; add y-offset to y-position

		cmpi.w	#96,d2
		bls.s	.offscreen		; branch if too high offscreen
		cmpi.w	#352,d2
		bhs.s	.offscreen		; branch if too low offscreen
		move.w	d2,(a6)+		; put the y-pos to table

		move.b	(a1)+,d6		; get sprite size
		move.b	d6,(a6)+		; put it to the table
		addq.w	#1,a6			; add 1 to the table address (skip empty byte)

		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		eori.w	#$1800,d2		; flip X-flip and y-flip bits
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		neg.w	d2			; negate it
		move.b	DrawSprPiece2_XOffs(pc,d6.w),d6; get x-offset based on sprite size
		sub.w	d6,d2			; sub the offset from x-pos
		add.w	d0,d2			; add x-offset to x-position

		cmpi.w	#96,d2
		bls.s	.gobacksprite		; branch if too left offscreen
		cmpi.w	#448,d2
		bhs.s	.gobacksprite		; branch if too right offscreen
		move.w	d2,(a6)+		; put the y-pos to table

		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,.dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts

.gobacksprite	subq.w	#6,a6			; sub 6 from sprite table address, to be overwritten later
		dbf	d4,.dopiece		; loop for rest of the sprites
		rts

.offscreen	addq.w	#5,a1			; skip rest of the mappings data
		dbf	d4,.dopiece		; loop for rest of the sprites
		rts

; ---------------------------------------------------------------------------
DrawSprPiece2_YOffs:
	rept 4	; 4x $08, $10, $18, $20
		dc.b $08, $10, $18, $20
	endr
; ---------------------------------------------------------------------------

DrawSpritePiece2_FlipY:
.dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		neg.w	d2			; negate it
		move.b	(a1)+,d6		; get sprite size
		move.b	d6,2(a6)		; put it to the table

		move.b	DrawSprPiece2_YOffs(pc,d6.w),d6; get y-offset based on sprite size
		sub.w	d6,d2			; sub the offset from y-pos
		add.w	d1,d2			; add y-offset to y-position

		cmpi.w	#96,d2
		bls.s	.offscreen		; branch if too high offscreen
		cmpi.w	#352,d2
		bhs.s	.offscreen		; branch if too low offscreen
		move.w	d2,(a6)+		; put the y-pos to table

		addq.w	#2,a6			; add 2 to the table address (skip empty byte and sprite size we saved ealier)
		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		eori.w	#$1000,d2		; flip Y-flip bit
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		add.w	d0,d2			; add x-offset to x-position
		cmpi.w	#96,d2
		bls.s	.gobacksprite		; branch if too left offscreen
		cmpi.w	#448,d2
		bhs.s	.gobacksprite		; branch if too right offscreen

		move.w	d2,(a6)+		; store x-pos to the table
		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,.dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts

.gobacksprite	subq.w	#6,a6			; sub 6 from sprite table address, to be overwritten later
		dbf	d4,.dopiece		; loop for rest of the sprites
		rts

.offscreen	addq.w	#4,a1			; skip rest of the mappings data
		dbf	d4,.dopiece		; loop for rest of the sprites
		rts
; ---------------------------------------------------------------------------

LoadObjects:
		moveq	#0,d0
		move.b	ObjManager_Routine.w,d0		; get manager routine
		jmp	.indx(pc,d0.w)			; jump to appropriate code

; ---------------------------------------------------------------------------
.indx		bra.w	.init				; initialization code
		bra.w	LoadObjects_Main
		bra.w	LoadObjects_Main
; ---------------------------------------------------------------------------

.init		move.l	#Sprite_ListingK,d0		; get S&K sprite listings
		move.l	d0,Object_index_addr.w		; store the address
		addq.b	#4,ObjManager_Routine.w		; use next routine

		moveq	#0,d0
	clearRAM Object_respawn_table, Camera_X_Pos_Diff-Object_respawn_table

.noclear	lea	('X'<<24)|ML_Sprites,a0		; get object layout position array
		move.l	a0,ObjMng_AdrRight.w
		move.l	a0,ObjMng_AdrLeft.w		; store address of the object layout

		lea	Object_respawn_table.w,a3	; get object respawn table

; the following code resets the variables and offsets of the manager so that,
; the objects manager will load the objects directly onscreen (and a little offscreen)
; and corrects all the variables with relevant values. Also makes sure correct amount of
; respawn indexes are skipped to keep enough space for all objects left from the player
		move.w	Camera_X.w,d6			; get camera X-pos
		subi.w	#128,d6				; sub 128 from it
		bhs.s	.noreset			; if higher than 0, branch
		moveq	#0,d6				; reset to 0

.noreset	andi.w	#$FF80,d6			; keep in chunks of 128 pixels
		movea.l	ObjMng_AdrRight.w,a0		; get the address of the objloader

; this seems to load the objects from start of the level until the position behind you
; these objects will no be loaded to RAM, but rather, just skipped over, counting the address of the last loaded object and its respawn index
.chkobjsleft	cmp.w	(a0),d6				; compare object position against d6
		bls.s	.chkdone			; if higher than d6, branch
		addq.w	#6,a0				; next object in list
		addq.w	#1,a3				; next respawn table index
		bra.s	.chkobjsleft			; check next

.chkdone	move.l	a0,ObjMng_AdrRight.w		; store address to load from
		move.w	a3,ObjMng_RespawnRight.w	; and store respawn table

		lea	Object_respawn_table.w,a3	; get respawn index to a3
		movea.l	ObjMng_AdrLeft.w,a0
		subi.w	#128,d6				; sub 128 from Camera X again. This is grossly offscreen,
							; but is done to account for the objects loader later on
		blo.s	.chkdone2			; if this position would be offscreen, it is assumed there are no objects to load

.chkobjsright	cmp.w	(a0),d6				; compare object position against d6
		bls.s	.chkdone2			; if higher than d6, branch
		addq.w	#6,a0				; next object in list
		addq.w	#1,a3				; next respawn table index
		bra.s	.chkobjsright			; check next

.chkdone2	move.l	a0,ObjMng_AdrLeft.w		; store address to load from
		move.w	a3,ObjMng_RespawnLeft.w		; and store respawn table

		move.w	#-1,ObjMgr_Camera_X.w		; reset camera X
		move.w	Camera_Y.w,d0			; get camera y-position
		andi.w	#$FF80,d0			; keep in range
		move.w	d0,ObjMgr_Camera_Y.w		; store it so no unnecesary Y-checks shouldnt be done
; ---------------------------------------------------------------------------

LoadObjects_Main:
		move.w	Camera_Y.w,d1			; get camera Y-pos
		subi.w	#128,d1				; sub 128 pixels from it
		andi.w	#$FF80,d1			; keep in range
		move.w	d1,Camera_Y_Rough.w		; save this

		move.w	Camera_X.w,d1			; get camera X-pos
		subi.w	#128,d1				; sub 128 pixels from it
		andi.w	#$FF80,d1			; keep in range
		move.w	d1,Camera_X_Rough.w		; save this

		movea.l	Object_index_addr.w,a4
		tst.w	Camera_min_Y.w
		bpl.s	.noywrap			; branch if Y-wrapping isnt active
		lea	CreateObj_ChkYWrap(pc),a6	; use check code, that account for Y-wrapping

		move.w	Camera_Y.w,d3			; get camera Y-positon
		andi.w	#$FF80,d3			; keep in range
		move.w	d3,d4				; copy result
		addi.w	#512,d4				; set lower y-boundary
		subi.w	#128,d3				; set upper y-boundary
		bpl.s	.nowrap			; if d3 is positive, branch
		and.w	Screen_Y_wrap_value.w,d3	; wrap d3
		bra.s	.common

.nowrap		move.w	Screen_Y_wrap_value.w,d0	; get vertical wrap value
		addq.w	#1,d0				; add 1 to it
		cmp.w	d0,d4				; compare with lower y-boundary
		bls.s	.setnowrap			; if no below the level either, branch
		and.w	Screen_Y_wrap_value.w,d4	; wrap this value
		bra.s	.common
; ---------------------------------------------------------------------------

.noywrap	move.w	Camera_Y.w,d3			; get camera Y-positon
		andi.w	#$FF80,d3			; keep in range
		move.w	d3,d4				; copy result
		addi.w	#512,d4				; set lower y-boundary
		subi.w	#128,d3				; set upper y-boundary
		bpl.s	.setnowrap			; if still positive, branch
		moveq	#0,d3				; force upper level boundary
.setnowrap	lea	CreateObj_ChkNoWrap(pc),a6	; use check code, that doesnt account for Y-wrapping

.common		move.w	#$FFF,d5
		move.w	Camera_X.w,d6			; get camera x-pos
		andi.w	#$FF80,d6			; keep in ramge
		cmp.w	ObjMgr_Camera_X.w,d6		; check against last range
		beq.w	LoadObjects_Common		; branch if same
		bge.s	LoadObjects_Forward		; if new range is greater than last, branch
; ---------------------------------------------------------------------------

		; else the range is less than.
		move.w	d6,ObjMgr_Camera_X.w		; store the new range
		movea.l	ObjMng_AdrLeft.w,a0		; get the current objects left
		movea.w	ObjMng_RespawnLeft.w,a3		; and appropriate respawn list
		subi.w	#128,d6				; sub 128 from the x-pos
		blo.s	.endload			; if outside level boundary, branch
		jsr	CreateObject(pc)		; attempt to load new object
		bne.s	.endload			; branch if failed

.loadloop	cmp.w	-6(a0),d6			; check if the last object is in range
		bge.s	.endload			; if not, branch
		subq.w	#6,a0				; get the actual object address
		subq.w	#1,a3				; get the actual respawn table address

		jsr	(a6)				; attempt to spawn the object
		bne.s	.loadfail			; branch if we could not load object afterall
		subq.w	#6,a0
		bra.s	.loadloop			; attempt to load new object

.loadfail	addq.w	#6,a0				;
		addq.w	#1,a3				; undo loading an object

.endload	move.l	a0,ObjMng_AdrLeft.w		; store the current object
		move.w	a3,ObjMng_RespawnLeft.w		; and respawn index

		movea.l	ObjMng_AdrRight.w,a0		; get the current objects right
		movea.w	ObjMng_RespawnRight.w,a3	; and appropriate respawn list
		addi.w	#768,d6				; look two chunks forwards

; this counts all the objects that have now moved offscreen
.chkloop	cmp.w	-6(a0),d6			; check if the last object is out of range
		bgt.s	.chkdone			; if is, branch
		subq.w	#6,a0				; get object before this
		subq.w	#1,a3				; and its respawn index
		bra.s	.chkloop			; check next object

.chkdone	move.l	a0,ObjMng_AdrRight.w		; store the current object
		move.w	a3,ObjMng_RespawnRight.w	; and respawn index
		bra.s	LoadObjects_Common		; and branch away!
; ---------------------------------------------------------------------------

LoadObjects_Forward:
		move.w	d6,ObjMgr_Camera_X.w		; store the new range
		movea.l	ObjMng_AdrRight.w,a0		; get the current objects right
		movea.w	ObjMng_RespawnRight.w,a3	; and appropriate respawn list
		addi.w	#640,d6				; look two chunks forwards
		jsr	CreateObject(pc)		; attempt to load new object
		bne.s	.endload			; branch if failed

.loadloop	cmp.w	(a0),d6				; check if the last object is in range
		bls.s	.endload			; if not, branch
		jsr	(a6)				; attempt to spawn the object
		addq.w	#1,a3				; get new respawn index (remember this does not modify CCR)
		beq.s	.loadloop			; branch if we could load objects

.endload	move.l	a0,ObjMng_AdrRight.w		; store the current object
		move.w	a3,ObjMng_RespawnRight.w	; and respawn index

		movea.l	ObjMng_AdrLeft.w,a0		; get the current objects left
		movea.w	ObjMng_RespawnLeft.w,a3		; and appropriate respawn list
		subi.w	#768,d6				; check 1 chunk backwards
		blo.s	.chkdone			; if outside of level, branch

; this counts all the objects that have now moved offscreen
.chkloop	cmp.w	(a0),d6				; check if the last object is out of range
		bls.s	.chkdone			; if is, branch
		addq.w	#6,a0				; get object after this
		addq.w	#1,a3				; and its respawn index
		bra.s	.chkloop			; check next object

.chkdone	move.l	a0,ObjMng_AdrLeft.w		; store the current object
		move.w	a3,ObjMng_RespawnLeft.w		; and respawn index
; ---------------------------------------------------------------------------

LoadObjects_Common:
		move.w	Camera_Y.w,d6			; get camera x-pos
		andi.w	#$FF80,d6			; keep in ramge
		move.w	d6,d3				; copy the value
		cmp.w	ObjMgr_Camera_Y.w,d6		; check against last range
		beq.w	.loadend			; branch if same
		bge.s	.movingdown			; if new range is greater than last, branch
; ---------------------------------------------------------------------------

		; else the range is less than.
		tst.w	Camera_min_Y.w
		bpl.s	.nowrap				; branch if level does not Y-wrap
		tst.w	d6
		bne.s	.mvupwrap
		cmpi.w	#128,ObjMgr_Camera_Y.w
		bne.s	.mvdownwrap

.mvupwrap	subi.w	#128,d3				; look one chunk up
		bpl.s	.ycheck				; branch if still positive
		and.w	Screen_Y_wrap_value.w,d3	; wrap y-pos
		bra.s	.ycheck

.nowrap		subi.w	#128,d3				; look one chunk up
		bmi.w	.loadend
		bra.s	.ycheck
; ---------------------------------------------------------------------------

.movingdown	tst.w	Camera_min_Y.w
		bpl.s	.nowrap2			; branch if level does not Y-wrap
		tst.w	ObjMgr_Camera_Y.w
		bne.s	.mvdownwrap
		cmpi.w	#128,d6
		bne.s	.mvupwrap

.mvdownwrap	addi.w	#384,d3				; look one chunk down
		cmp.w	Screen_Y_wrap_value.w,d3
		blo.s	.ycheck				; if we should now wrap yet
		and.w	Screen_Y_wrap_value.w,d3	; wrap the y-position
		bra.s	.ycheck

.nowrap2	addi.w	#384,d3				; look one chunk down
		cmp.w	Screen_Y_wrap_value.w,d3
		bhi.s	.loadend
; ---------------------------------------------------------------------------

.ycheck		jsr	CreateObject(pc)		; attempt to create an object
		bne.s	.loadend			; if failed, branch
		move.w	d3,d4				; copy y-pos
		addi.w	#128,d4				; look one chunk down
		move.w	#$FFF,d5

		movea.l	ObjMng_AdrLeft.w,a0		; get the current objects left
		movea.w	ObjMng_RespawnLeft.w,a3		; get respawn list left
		move.l	ObjMng_AdrRight.w,d7		; get the current objects right
		sub.l	a0,d7				; sub the left position from right
		beq.s	.loadend			; branch if no objects
		addq.w	#2,a0				; align to obj y

.loadnext	tst.b	(a3)				; has object been loaded?
		bmi.s	.loadfail			; if so, branch

		move.w	(a0),d1				; get objects y-pos
		and.w	d5,d1				; keep it in range of 0-$FFF
		cmp.w	d3,d1
		blo.s	.loadfail			; branch if out of range in top
		cmp.w	d4,d1
		bhi.s	.loadfail			; branch if out of range in bottom

		bset	#7,(a3)				; mark as loaded
		move.w	-2(a0),xpos(a1)			; get x-position
		move.w	(a0),d1				; get y-position
		move.w	d1,d2				; copy it
		and.w	d5,d1				; keep in range
		move.w	d1,ypos(a1)			; store it as the new y-pos

		rol.w	#3,d2				; get X & Y flip bits to start of d2
		andi.w	#3,d2				; keep only X & Y flip bits
		move.b	d2,render(a1)			; store render flags
		move.b	d2,status(a1)			; store status

		move.b	2(a0),d2			; get ID
		add.w	d2,d2
		add.w	d2,d2				; quadruple it
		move.l	(a4,d2.w),(a1)			; get the object ID from listings table

		move.b	3(a0),subtype(a1)		; get object subtype
		move.w	a3,respawn(a1)			; get the respawn index
		jsr	CreateObjFromLoader(pc)		; attempt to load more objects
		bne.s	.loadend			; if none could be loaded, branch

.loadfail	addq.w	#6,a0				; next objects address
		addq.w	#1,a3				; next respawn index
		subq.w	#6,d7				; sub the size of the object
		bne.s	.loadnext			; if there is object remaining, branch
.loadend	move.w	d6,ObjMgr_Camera_Y.w		; store camera Y-pos
		rts
; ---------------------------------------------------------------------------
; unused/dead code
		bset	#7,(a3)				; mark as loaded
		beq.s	CreateObj_Anyway		; if wasn't loaded, load
		addq.w	#6,a0				; increment to address of the next object
		moveq	#0,d1				; ensure that upstream code knows to continue loading
		rts
; ---------------------------------------------------------------------------

CreateObj_Anyway:
		move.w	(a0)+,xpos(a1)			; copy x-position
		move.w	(a0)+,d1			; get y-position
		move.w	d1,d2				; copy it
		andi.w	#$FFF,d1			; filter out unnecessary bits
		move.w	d1,ypos(a1)			; store the new y-pos

		rol.w	#3,d2				; get X & Y flip bits to start of d2
		andi.w	#3,d2				; keep only X & Y flip bits
		move.b	d2,render(a1)			; store render flags
		move.b	d2,status(a1)			; store status

		move.b	(a0)+,d2			; get object ID
		add.w	d2,d2
		add.w	d2,d2				; quadruple it
		move.l	(a4,d2.w),(a1)			; get the object ID from listings table

		move.b	(a0)+,subtype(a1)		; get object subtype
		move.w	a3,respawn(a1)			; get the respawn index
		bra.w	CreateObjFromLoader		; attempt to create a new object
; ---------------------------------------------------------------------------
; subroutine to try and load new objects from object layout files.
; has different code for Y-wrapped and non-Y-Wrapped levels.
;
; input:
; d3 = upper boundary
; d4 = lower boundary
; d5 = Y-position filter bits
; a0 = index of object layout file
; a1 = target object
; a3 = respawn table address
; ---------------------------------------------------------------------------

CreateObj_ChkYWrap:
		tst.b	(a3)				; check if the object is already loaded
		bpl.s	.notloaded			; if not, branch
		addq.w	#6,a0				; increment to address of the next object
		moveq	#0,d1				; ensure that upstream code knows to continue loading
		rts

.notloaded	move.w	(a0)+,d7			; get x-position
		move.w	(a0)+,d1			; get y-position
		move.w	d1,d2				; copy y-position
		bmi.s	.loadnoy			; branch if this object ignore y-checks
		and.w	d5,d1				; keep y-position in range

		cmp.w	d3,d1
		bhs.s	.spawn				; branch if on range from top(?)
		cmp.w	d4,d1
		bls.s	.spawn				; branch if on range from bottom

		addq.w	#2,a0				; increment to address of the next object
		moveq	#0,d1				; ensure that upstream code knows to continue loading
		rts
; ---------------------------------------------------------------------------

.loadnoy	and.w	d5,d1				; keep y-position in range
.spawn		bset	#7,(a3)				; mark as loaded
		move.w	d7,xpos(a1)			; store the new x-pos
		move.w	d1,ypos(a1)			; store the new y-pos

		rol.w	#3,d2				; get X & Y flip bits to start of d2
		andi.w	#3,d2				; keep only X & Y flip bits
		move.b	d2,render(a1)			; store render flags
		move.b	d2,status(a1)			; store status

		move.b	(a0)+,d2			; get object ID
		add.w	d2,d2
		add.w	d2,d2				; quadruple it
		move.l	(a4,d2.w),(a1)			; get the object ID from listings table

		move.b	(a0)+,subtype(a1)		; get object subtype
		move.w	a3,respawn(a1)			; get the respawn index
		bra.s	CreateObjFromLoader		; attempt to create a new object
; ---------------------------------------------------------------------------

CreateObj_ChkNoWrap:
		tst.b	(a3)				; check if the object is already loaded
		bpl.s	.notloaded			; if not, branch
		addq.w	#6,a0				; increment to address of the next object
		moveq	#0,d1				; ensure that upstream code knows to continue loading
		rts

.notloaded	move.w	(a0)+,d7			; get x-position
		move.w	(a0)+,d1			; get y-position
		move.w	d1,d2				; copy y-position
		bmi.s	.loadnoy			; branch if this object ignore y-checks
		and.w	d5,d1				; keep y-position in range

		cmp.w	d3,d1
		blo.s	.outofrange			; branch if out of range from top
		cmp.w	d4,d1
		bls.s	.spawn				; branch if on range from bottom

.outofrange	addq.w	#2,a0				; increment to address of the next object
		moveq	#0,d1				; ensure that upstream code knows to continue loading
		rts
; ---------------------------------------------------------------------------

.loadnoy	and.w	d5,d1				; keep y-position in range
.spawn		bset	#7,(a3)				; mark as loaded
		move.w	d7,xpos(a1)			; store the new x-pos
		move.w	d1,ypos(a1)			; store the new y-pos

		rol.w	#3,d2				; get X & Y flip bits to start of d2
		andi.w	#3,d2				; keep only X & Y flip bits
		move.b	d2,render(a1)			; store render flags
		move.b	d2,status(a1)			; store status

		move.b	(a0)+,d2			; get object ID
		add.w	d2,d2
		add.w	d2,d2				; quadruple it
		move.l	(a4,d2.w),(a1)			; get the object ID from listings table

		move.b	(a0)+,subtype(a1)		; get object subtype
		move.w	a3,respawn(a1)			; get the respawn index
; ---------------------------------------------------------------------------

CreateObjFromLoader:
		subq.w	#1,d0		; not sure what d0 is here, but I can just guess
					; it keeps track of how many objects we have checked
		bmi.s	.rts		; if negative, branch

.chk		lea	objsize(a1),a1	; get next object
		tst.l	(a1)		; test if there is object here
		dbeq	d0,.chk		; if isn't, and more objects are to be done, keep looping.
.rts		rts
; ---------------------------------------------------------------------------

loc_1BB7E:
		lea	Object_RAM_free.w,a1
		moveq	#((Object_RAM_static-Object_RAM_free)/objsize)-1,d1

loc_1BB84:
		lea	objsize(a1),a1
		tst.l	(a1)
		beq.s	loc_1BB98
		move.w	respawn(a1),d0
		beq.s	loc_1BB98
		movea.w	d0,a2
		bclr	#7,(a2)

loc_1BB98:
		dbf	d1,loc_1BB84
		lea	Ring_consumption_count.w,a2
		move.w	(a2)+,d1
		subq.w	#1,d1
		blo.s	locret_1BBBC

loc_1BBA6:
		move.w	(a2)+,d0
		beq.s	loc_1BBA6
		movea.w	d0,a1
		move.w	#-1,(a1)
		clr.w	-2(a2)
		subq.w	#1,Ring_consumption_count.w
		dbf	d1,loc_1BBA6

locret_1BBBC:
		rts
; ---------------------------------------------------------------------------

loc_1BBBE:
		move.w	Camera_X.w,d6
		addi.w	#$400,d6
		andi.w	#$FF80,d6
		cmp.w	ObjMgr_Camera_X.w,d6
		beq.w	locret_1BC5E
		bge.s	loc_1BC1C
		move.w	d6,ObjMgr_Camera_X.w
		movea.l	ObjMng_AdrLeft.w,a1
		movea.w	ObjMng_RespawnLeft.w,a3
		subi.w	#$80,d6
		blo.s	loc_1BBF2

loc_1BBE6:
		cmp.w	-6(a1),d6
		bge.s	loc_1BBF2
		subq.w	#6,a1
		subq.w	#1,a3
		bra.s	loc_1BBE6

loc_1BBF2:
		move.l	a1,ObjMng_AdrLeft.w
		move.w	a3,ObjMng_RespawnLeft.w
		movea.l	ObjMng_AdrRight.w,a1
		movea.w	ObjMng_RespawnRight.w,a3
		addi.w	#$300,d6

loc_1BC06:
		cmp.w	-6(a1),d6
		bgt.s	loc_1BC12
		subq.w	#6,a1
		subq.w	#1,a3
		bra.s	loc_1BC06

loc_1BC12:
		move.l	a1,ObjMng_AdrRight.w
		move.w	a3,ObjMng_RespawnRight.w
		bra.s	locret_1BC5E
; ---------------------------------------------------------------------------

loc_1BC1C:
		move.w	d6,ObjMgr_Camera_X.w
		movea.l	ObjMng_AdrRight.w,a1
		movea.w	ObjMng_RespawnRight.w,a3
		addi.w	#$280,d6

loc_1BC2C:
		cmp.w	(a1),d6
		bls.s	loc_1BC36
		addq.w	#6,a1
		addq.w	#1,a3
		bra.s	loc_1BC2C

loc_1BC36:
		move.l	a1,ObjMng_AdrRight.w
		move.w	a3,ObjMng_RespawnRight.w
		movea.l	ObjMng_AdrLeft.w,a1
		movea.w	ObjMng_RespawnLeft.w,a3
		subi.w	#$300,d6
		blo.s	loc_1BC56

loc_1BC4C:
		cmp.w	(a1),d6
		bls.s	loc_1BC56
		addq.w	#6,a1
		addq.w	#1,a3
		bra.s	loc_1BC4C

loc_1BC56:
		move.l	a1,ObjMng_AdrLeft.w
		move.w	a3,ObjMng_RespawnLeft.w

locret_1BC5E:
		rts
; ---------------------------------------------------------------------------


