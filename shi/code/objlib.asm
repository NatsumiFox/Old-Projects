ObjectFall:
		move.w	xvel(a0),d0		; get x-velocity
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,xpos(a0)		; add to x-pos

		move.w	yvel(a0),d0		; get y-velocity
		addi.w	#$38,yvel(a0)		; apply gravity
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,ypos(a0)		; add to y-pos
		rts
; ---------------------------------------------------------------------------

ObjectMove:
		move.w	xvel(a0),d0		; get x-velocity
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,xpos(a0)		; add to x-pos

		move.w	yvel(a0),d0		; get y-velocity
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,ypos(a0)		; add to y-pos
		rts
; ---------------------------------------------------------------------------

ObjectGravity:
		tst.b	ReverseGravity_Flag.w
		beq.s	ObjectFall		; if reverse gravity isnt active, branch

		; fall up
		move.w	xvel(a0),d0		; get x-velocity
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,xpos(a0)		; add to x-pos

		move.w	yvel(a0),d0		; get y-velocity
		addi.w	#$38,yvel(a0)		; apply gravity
		neg.w	d0			; negate y-velocity
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,ypos(a0)		; add to y-pos
		rts
; ---------------------------------------------------------------------------

ObjectRevMove:
		tst.b	ReverseGravity_Flag.w
		beq.s	ObjectMove		; if reverse gravity isnt active, branch

		; move up
		move.w	xvel(a0),d0		; get x-velocity
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,xpos(a0)		; add to x-pos

		move.w	yvel(a0),d0		; get y-velocity
		neg.w	d0			; negate y-velocity
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,ypos(a0)		; add to y-pos
		rts
; ---------------------------------------------------------------------------

DrawSprite:
		lea	Sprite_table_input.w,a1	; get sprite table
		adda.w	priority(a0),a1		; add priority layer to table offset

.chklayer	cmpi.w	#(PriorLayerObjs-1)*2,(a1); check if this layer is full
		bhs.s	.chknextlayer		; then branch
		addq.w	#2,(a1)			; increment offset in the layer
		adda.w	(a1),a1			; get the address of the offset thing
		move.w	a0,(a1)			; and put this object there
.rts		rts

.chknextlayer	cmpa.w	#Sprite_table_input+priority7,a1
		beq.s	.rts			; branch if last priority layer. RIP this object
		adda.w	#PriorLayerObjs*2,a1	; get next layer address
		bra.s	.chklayer		; branch
; ---------------------------------------------------------------------------
; checks if object should still be spawned. Else despawns it. Also display
ChkDispObjLoaded:
		move.w	xpos(a0),d0			; get current x-pos

ChkDispObjLoaded2:
		andi.w	#$FF80,d0			; keep in range of chunk
		sub.w	Camera_X_Rough.w,d0		; get the chunk position of camera
		cmpi.w	#640,d0
		bhi.s	DespawnObject			; branch if we are far away from the camera
		bra.s	DrawSprite			; render this sprite
; ---------------------------------------------------------------------------
; checks if object should still be spawned. Else despawns it
; Also display and add to collision response list
DispCollObjLoaded:
		move.w	xpos(a0),d0			; get current x-pos

DispCollObjLoaded2:
		andi.w	#$FF80,d0			; keep in range of chunk
		sub.w	Camera_X_Rough.w,d0		; get the chunk position of camera
		cmpi.w	#640,d0
		bhi.s	DespawnObject			; branch if we are far away from the camera
		bsr.s	AddToCollResponseList		; add to collision response list
		bra.s	DrawSprite			; render this sprite

; ---------------------------------------------------------------------------
; checks if object should still be spawned. Else despawns it
; Also display and add to collision response list
DispCollObjLoaded3:
		tst.b	render(a0)			; check render flags
		bpl.s	DespawnObject			; branch if offscreen
		bsr.s	AddToCollResponseList		; add to collision response list
		bra.s	DrawSprite			; render this sprite

; ---------------------------------------------------------------------------
DespawnObject:	unloadthis bra.s	; delete this object and clear spawned status
; ---------------------------------------------------------------------------

AddToCollResponseList:
		lea	Coll_response_list.w,a1
		cmpi.w	#$7E,(a1)		; is the list full?
		bhs.s	.rts			; if is, branch
		addq.w	#2,(a1)			; get new entry
		adda.w	(a1),a1			; get the entry offset
		move.w	a0,(a1)			; put this object to the list
.rts		rts
; ---------------------------------------------------------------------------
; checks if object should still be spawned. Else despawns it.
ChkObjLoaded:
		move.w	xpos(a0),d0			; get current x-pos
		andi.w	#$FF80,d0			; keep in range of chunk
		sub.w	Camera_X_Rough.w,d0		; get the chunk position of camera
		cmpi.w	#640,d0
		bhi.s	DespawnObject			; branch if we are far away from the camera
		rts
; ---------------------------------------------------------------------------

DeleteObject_This:
		movea.l	a0,a1			; copy current object to a1

DeleteObject_a1:
		moveq	#$12-1,d0		; clear $48 bytes
		moveq	#0,d1			; fill with 0
.clr		move.l	d1,(a1)+		; clear RAM
		dbf	d0,.clr			; loop until done

		move.w	d1,(a1)+		; do the 2 bytes remaining
		rts
; ---------------------------------------------------------------------------

CreateObject:
		lea	Object_RAM_free-objsize.w,a1	; get start of object RAM
		moveq	#((Object_RAM_static-Object_RAM_free)/objsize)-1,d0
		bra.s	CreateObject_Common		; get repeat amount and branch

CreateObjectAfter:
		movea.l	a0,a1				; copy object to a1
		move.w	#Object_RAM_static&$FFFF,d0	; get end address
		sub.w	a0,d0				; sub object start address from d0
		lsr.w	#6,d0				; shift 6 times left. Interestingly, it gets exactly how many times 0x4A is in the d0.
		move.b	CreateObject_ObjLeft(pc,d0.w),d0; translate it to the amount of objects left
		bmi.s	locret_1BB14

CreateObject_Common:
		lea	objsize(a1),a1			; get next object
		tst.l	(a1)				; test if there is object here
		dbeq	d0,CreateObject_Common		; if isn't, and more objects are to be done, keep looping.

locret_1BB14:
		rts					; return object address. Or if failure, you can branch off

; ---------------------------------------------------------------------------
; this list just shows the amount of objects left to do.
; is used when loading objects relative to parent object, to get correct dbf amount.
; the list is reversed, smaller object offsets go first.

CreateObject_ObjLeft:
	dc.b  $FF,   0,	  1,   2,   3,	 4,   5,   5,	6,   7,	  8,   9,  $A,	$B,  $B,  $C
	dc.b   $D,  $E,	 $F, $10, $11, $12, $12, $13, $14, $15,	$16, $17, $18, $18, $19, $1A
	dc.b  $1B, $1C,	$1D, $1E, $1E, $1F, $20, $21, $22, $23,	$24, $25, $25, $26, $27, $28
	dc.b  $29, $2A,	$2B, $2B, $2C, $2D, $2E, $2F, $30, $31,	$32, $32, $33, $34, $35, $36
	dc.b  $37, $38,	$38, $39, $3A, $3B, $3C, $3D, $3E, $3E,	$3F, $40, $41, $42, $43, $44
	dc.b  $45, $45,	$46, $47, $48, $49, $4A, $4B, $4B, $4C,	$4D, $4E, $4F, $50, $51, $52
	dc.b  $52, $53,	$54, $55, $56, $57, $58, $58
; ---------------------------------------------------------------------------
; routine to handle object solid evenly from all sides. Does not collide
; with sidekick if they are not rendered
; input:
; d1 = objects width
; d2 = objects sides height
; d3 = objects stand height
; d4 = x-pos of object
; ---------------------------------------------------------------------------
SolidObj:
		lea	Object_RAM.w,a1			; get main player
		moveq	#3,d6				; get main players standing on object bit
		movem.l	d1-d4,-(sp)			; store variables
		bsr.s	SolidObj_Single			; run common code
		movem.l	(sp)+,d1-d4			; get variables back

		lea	Obj_player_2.w,a1		; get sidekick
		tst.b	render(a1)
		bpl.w	locret_1DCB4			; branch if object isnt being displayed
		addq.b	#1,d6				; get sidekicks standing on object bit

SolidObj_Single:
		btst	d6,status(a0)
		beq.w	SolidObj_ChkColls		; branch if player is not standing on this object
		move.w	d1,d2				; copy objects width
		add.w	d2,d2				; double width
		btst	#1,status(a1)
		bne.s	.notontop			; branch if Player is on air

		move.w	xpos(a1),d0			; get xpos of Player
		sub.w	xpos(a0),d0			; sub xpos of the object
		add.w	d1,d0				; add width to d0
		bmi.s	.notontop			; if negative, we are beyond left edge
		cmp.w	d2,d0				; compare with 2x width
		blo.s	.isontop			; branch if we are not beyond right edge

.notontop	bclr	#3,status(a1)			; clear standing on object for Player
		bset	#1,status(a1)			; make player be in air
		bclr	d6,status(a0)			; clear player standing on this object
		moveq	#0,d4
		rts

.isontop	move.w	d4,d2				; copy xpos to d2
		bsr.w	MvPlayerOnPtfm			; move player on the top of the object
		moveq	#0,d4

locret_1DCB4:
		rts
; ---------------------------------------------------------------------------
; routine to handle object solid evenly from all sides. Does still collide
; with sidekick even if they are not rendered
; input:
; d1 = objects width
; d2 = objects sides height
; d3 = objects stand height
; d4 = x-pos of object
; ---------------------------------------------------------------------------
SolidObj2:
		lea	Object_RAM.w,a1			; get main player
		moveq	#3,d6				; get main players standing on object bit
		movem.l	d1-d4,-(sp)			; store variables
		bsr.s	SolidObj2_Single		; run common code
		movem.l	(sp)+,d1-d4			; get variables back
		lea	Obj_player_2.w,a1		; get sidekick
		addq.b	#1,d6				; get sidekicks standing on object bit

SolidObj2_Single:
		btst	d6,status(a0)
		beq.w	SolidObj2_ChkColls		; branch if player is not standing on this object
		move.w	d1,d2				; copy objects width
		add.w	d2,d2				; double width
		btst	#1,status(a1)
		bne.s	.notontop			; branch if Player is on air

		move.w	xpos(a1),d0			; get xpos of Player
		sub.w	xpos(a0),d0			; sub xpos of the object
		add.w	d1,d0				; add width to d0
		bmi.s	.notontop			; if negative, we are beyond left edge
		cmp.w	d2,d0				; compare with 2x width
		blo.s	.isontop			; branch if we are not beyond right edge

.notontop	bclr	#3,status(a1)			; clear standing on object for Player
		bset	#1,status(a1)			; make player be in air
		bclr	d6,status(a0)			; clear player standing on this object
		moveq	#0,d4
		rts

.isontop	move.w	d4,d2				; copy xpos to d2
		bsr.w	MvPlayerOnPtfm			; move player on the top of the object
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------
; routine to handle solid object which is sloped on top, where 1 byte of
; slope data accounts for 2 pixels.
; input:
; d1 = objects width
; d2 = objects sides height
; d3 = objects stand height
; d4 = x-pos of object
; a2 = slope data (heightmap from left to right)
; ---------------------------------------------------------------------------
SolidObj_SlopedDouble:
		lea	Object_RAM.w,a1			; get main player
		moveq	#3,d6				; get main players standing on object bit
		movem.l	d1-d4,-(sp)			; store variables
		bsr.s	SolidObj_SlopedDbl_Single	; run common code
		movem.l	(sp)+,d1-d4			; get variables back
		lea	Obj_player_2.w,a1		; get sidekick
		addq.b	#1,d6				; get sidekicks standing on object bit

SolidObj_SlopedDbl_Single:
		btst	d6,status(a0)
		beq.w	SolidObj_SlopedDbl_ChkColls	; branch if player is not standing on this object
		move.w	d1,d2				; copy objects width
		add.w	d2,d2				; double width
		btst	#1,status(a1)
		bne.s	.notontop			; branch if Player is on air

		move.w	xpos(a1),d0			; get xpos of Player
		sub.w	xpos(a0),d0			; sub xpos of the object
		add.w	d1,d0				; add width to d0
		bmi.s	.notontop			; if negative, we are beyond left edge
		cmp.w	d2,d0				; compare with 2x width
		blo.s	.isontop			; branch if we are not beyond right edge

.notontop	bclr	#3,status(a1)			; clear standing on object for Player
		bset	#1,status(a1)			; make player be in air
		bclr	d6,status(a0)			; clear player standing on this object
		moveq	#0,d4
		rts

.isontop	move.w	d4,d2				; copy xpos to d2
		bsr.w	SolidObj_TopSlopedDbl		; move on top of sloped object
		move.w	d6,d4				; copy on top bit to d4
		addi.b	#17,d4				; add 17 to it
		bset	d4,d6				; set that bit (20 or 21)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------
; unused routine to handle solid object which is sloped on top, where 2 bytes
; account for 2 pixels. both seem to have something to do with the height.
; input:
; d1 = objects width
; d2 = objects sides height
; d3 = objects stand height
; d4 = x-pos of object
; a2 = slope data (heightmap from left to right)
; ---------------------------------------------------------------------------
SolidObj_SlopedHalf:
		lea	Object_RAM.w,a1			; get main player
		moveq	#3,d6				; get main players standing on object bit
		movem.l	d1-d4,-(sp)			; store variables
		bsr.s	SolidObj_SlopedHalf_Single	; run common code
		movem.l	(sp)+,d1-d4			; get variables back
		lea	Obj_player_2.w,a1		; get sidekick
		addq.b	#1,d6				; get sidekicks standing on object bit

SolidObj_SlopedHalf_Single:
		btst	d6,status(a0)
		beq.w	SolidObj_SlopedHalf_ChkColls	; branch if player is not standing on this object
		move.w	d1,d2				; copy objects width
		add.w	d2,d2				; double width
		btst	#1,status(a1)
		bne.s	.notontop			; branch if Player is on air

		move.w	xpos(a1),d0			; get xpos of Player
		sub.w	xpos(a0),d0			; sub xpos of the object
		add.w	d1,d0				; add width to d0
		bmi.s	.notontop			; if negative, we are beyond left edge
		cmp.w	d2,d0				; compare with 2x width
		blo.s	.isontop			; branch if we are not beyond right edge

.notontop	bclr	#3,status(a1)			; clear standing on object for Player
		bset	#1,status(a1)			; make player be in air
		bclr	d6,status(a0)			; clear player standing on this object
		moveq	#0,d4
		rts

.isontop	move.w	d4,d2				; copy xpos to d2
		bsr.w	SolidObj_TopSlopedHalf		; move on top of sloped object
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------
; routine to handle solid object which is sloped on top, where 1 byte of
; slope data accounts for 2 pixels. Only difference to SolidObj_SlopedDouble
; is that player is not put on air when there is no collision.
; d1 = objects width
; d2 = objects sides height
; d3 = objects stand height
; d4 = x-pos of object
; a2 = slope data (heightmap from left to right)
; ---------------------------------------------------------------------------
SolidObj2_SlopedDouble:
		lea	Object_RAM.w,a1			; get main player
		moveq	#3,d6				; get main players standing on object bit
		movem.l	d1-d4,-(sp)			; store variables
		bsr.s	SolidObj2_SlopedDbl_Single	; run common code
		movem.l	(sp)+,d1-d4			; get variables back
		lea	Obj_player_2.w,a1		; get sidekick
		addq.b	#1,d6				; get sidekicks standing on object bit

SolidObj2_SlopedDbl_Single:
		btst	d6,status(a0)
		beq.w	SolidObj_SlopedDbl_ChkColls	; branch if player is not standing on this object
		move.w	d1,d2				; copy objects width
		add.w	d2,d2				; double width
		btst	#1,status(a1)
		bne.s	.notontop			; branch if Player is on air

		move.w	xpos(a1),d0			; get xpos of Player
		sub.w	xpos(a0),d0			; sub xpos of the object
		add.w	d1,d0				; add width to d0
		bmi.s	.notontop			; if negative, we are beyond left edge
		cmp.w	d2,d0				; compare with 2x width
		blo.s	.isontop			; branch if we are not beyond right edge

.notontop	bclr	#3,status(a1)			; clear standing on object for Player
		bclr	d6,status(a0)			; clear player standing on this object
		moveq	#0,d4
		rts

.isontop	move.w	d4,d2				; copy xpos to d2
		bsr.w	SolidObj_TopSlopedDbl		; move on top of sloped object
		move.w	d6,d4				; copy on top bit to d4
		addi.b	#17,d4				; add 17 to it
		bset	d4,d6				; set that bit (20 or 21)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------
; routine to handle object solid evenly from all sides. Instead of calling
; 'MvPlayerOnPtfm' as other routines would, it runs its own code for it.
; input:
; d1 = objects width
; d2 = objects sides height
; d3 = objects stand height
; d4 = x-pos of object
; ---------------------------------------------------------------------------
SolidObj3:
		lea	Object_RAM.w,a1			; get main player
		moveq	#3,d6				; get main players standing on object bit
		movem.l	d1-d4,-(sp)			; store variables
		bsr.s	SolidObj3_Single		; run common code
		movem.l	(sp)+,d1-d4			; get variables back
		lea	Obj_player_2.w,a1		; get sidekick
		addq.b	#1,d6				; get sidekicks standing on object bit

SolidObj3_Single:
		btst	d6,status(a0)
		beq.w	SolidObj3_ChkColls		; branch if player is not standing on this object
		btst	#1,status(a1)
		bne.s	.notontop			; branch if Player is on air

		move.w	xpos(a1),d0			; get xpos of Player
		sub.w	xpos(a0),d0			; sub xpos of the object
		add.w	d1,d0				; add width to d0
		bmi.s	.notontop			; if negative, we are beyond left edge
		add.w	d1,d1				; double object width
		cmp.w	d1,d0				; compare with 2x width
		blo.s	.isontop			; branch if we are not beyond right edge

.notontop	bclr	#3,status(a1)			; clear standing on object for Player
		bset	#1,status(a1)			; make player be in air
		bclr	d6,status(a0)			; clear player standing on this object
		moveq	#0,d4
		rts

.isontop	move.w	ypos(a0),d0			; get xpos of the object
		sub.w	d2,d0				; sub height from the ypos
		add.w	d3,d0				; and then add height to ypos

		moveq	#0,d1
		move.b	yrad(a1),d1			; get y-radius of player to d1
		sub.w	d1,d0				; sub from ypos
		move.w	d0,ypos(a1)			; set it as the ypos of player
		sub.w	xpos(a0),d4			; sub xpos of this object from xpos
		sub.w	d4,xpos(a1)			; sub the result from players xpos
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------
; Routine to check if player is in fact colliding with the object.
; input:
; d1 = objects width
; d2 = objects height
; d3 = objects height(?)
; d4 = x-pos of object
; ---------------------------------------------------------------------------
SolidObj3_ChkColls:
		move.w	xpos(a1),d0			; get xpos of player
		sub.w	xpos(a0),d0			; sub current xpos from d0
		add.w	d1,d0				; add width to d0
		bmi.w	SolObjCom_noColls		; if still negative, we are not colliding (from left)

		move.w	d1,d4				; copy width to d4
		add.w	d4,d4				; double it
		cmp.w	d4,d0				; compare to xpos
		bhi.w	SolObjCom_noColls		; if higher, we are not colliding (from right)

		move.w	ypos(a0),d5			; get ypos of object
		add.w	d3,d5				; add height(?) to ypos
		move.b	yrad(a1),d3			; get y-radius
		ext.w	d3				; extend to word
		add.w	d3,d2				; add the radius to height

		move.w	ypos(a1),d3			; get ypos of player
		sub.w	d5,d3				; sub ypos of obj from d3
		addq.w	#4,d3				; add 4 to d3
		add.w	d2,d3				; add height and yrad to d3
		bmi.w	SolObjCom_noColls		; if negative, we aren't colliding from top

		move.w	d2,d4				; copy d2 to d4
		add.w	d4,d4				; double it
		cmp.w	d4,d3				; compare with d3
		bhs.w	SolObjCom_noColls		; if not colliding from bottom, branch
		bra.w	SolidObjCom			; else we in fact are colliding
; ---------------------------------------------------------------------------
; Routine to check if player is in fact colliding with the object.
; The object's top is sloped, so the height of the slope is accounted for.
; input:
; d1 = objects width
; d2 = objects height
; d4 = x-pos of object
; a2 = slope data (heightmap from left to right)
; ---------------------------------------------------------------------------
SolidObj_SlopedDbl_ChkColls:
		move.w	xpos(a1),d0			; get xpos of player
		sub.w	xpos(a0),d0			; sub current xpos from d0
		add.w	d1,d0				; add width to d0
		bmi.w	SolObjCom_noColls		; if still negative, we are not colliding (from left)

		move.w	d1,d3				; copy width to d3
		add.w	d3,d3				; double it
		cmp.w	d3,d0				; compare to xpos
		bhi.w	SolObjCom_noColls		; if higher, we are not colliding (from right)

		move.w	d0,d5				; copy it d0 to d5
		btst	#0,render(a0)
		beq.s	.noflip				; branch if not x-flipped
		not.w	d5				; logical notation on d5
		add.w	d3,d5				; add double width to d5

.noflip		lsr.w	#1,d5				; shift left once (divide by 2)
		move.b	(a2,d5.w),d3			; get height of this segment
		sub.b	(a2),d3				; sub first byte from the value
		ext.w	d3				; extend to word

		move.w	ypos(a0),d5			; get objects ypos
		sub.w	d3,d5				; sub height from ypos
		move.b	yrad(a1),d3			; get players y-radius
		ext.w	d3				; extend to word
		add.w	d3,d2				; add y-radius to object height

		move.w	ypos(a1),d3			; get ypos of player
		sub.w	d5,d3				; sub d5 from ypos of player
		addq.w	#4,d3				; add 4 to d3
		add.w	d2,d3				; add height and yrad to d3
		bmi.w	SolObjCom_noColls		; if negative, we aren't colliding from top

		move.w	d2,d4				; copy d2 to d4
		add.w	d4,d4				; double it
		cmp.w	d4,d3				; compare with d3
		bhs.w	SolObjCom_noColls		; if not colliding from bottom, branch
		bra.w	SolidObjCom			; else we in fact are colliding
; ---------------------------------------------------------------------------
; Unused routine to check if player is in fact colliding with the object.
; The object's top is sloped, so the height of the slope is accounted for.
; input:
; d1 = objects width
; d4 = x-pos of object
; a2 = slope data (heightmap from left to right)
; ---------------------------------------------------------------------------
SolidObj_SlopedHalf_ChkColls:
		move.w	xpos(a1),d0			; get xpos of player
		sub.w	xpos(a0),d0			; sub current xpos from d0
		add.w	d1,d0				; add width to d0
		bmi.w	SolObjCom_noColls		; if still negative, we are not colliding (from left)

		move.w	d1,d3				; copy width to d3
		add.w	d3,d3				; double it
		cmp.w	d3,d0				; compare to xpos
		bhi.w	SolObjCom_noColls		; if higher, we are not colliding (from right)

		move.w	d0,d5				; copy it d0 to d5
		btst	#0,render(a0)
		beq.s	.noflip				; branch if not x-flipped
		not.w	d5				; logical notation on d5
		add.w	d3,d5				; add double width to d5

.noflip		andi.w	#$FE,d5				; clear the least significant bit (effectively divide by 2)
		move.b	(a2,d5.w),d3			; get height of the object
		move.b	1(a2,d5.w),d2			; get height of the object
		ext.w	d2				; extend to word
		ext.w	d3				; extend to word

		move.w	ypos(a0),d5			; get ypos of object
		sub.w	d3,d5				; sub height from ypos
		move.w	ypos(a1),d3			; get ypos of player
		sub.w	d5,d3				; sub d5 from players ypos

		move.b	yrad(a1),d5			; get players y-radius
		ext.w	d5				; extend to word
		add.w	d5,d3				; add y-radius to d3
		addq.w	#4,d3				; add 4 to d3
		bmi.w	SolObjCom_noColls		; if negative, we aren't colliding from top

		add.w	d5,d2				; add y-radius to height
		move.w	d2,d4				; copy it to d4
		add.w	d5,d4				; add y-radius to d4
		cmp.w	d4,d3				; compare with d3
		bhs.w	SolObjCom_noColls		; if not colliding from bottom, branch
		bra.w	SolidObjCom			; else we in fact are colliding
; ---------------------------------------------------------------------------
; Routine to check if player is in fact colliding with the object.
; input:
; d1 = objects width
; d2 = objects sides height
; d4 = x-pos of object
; ---------------------------------------------------------------------------
SolidObj_ChkColls:
		tst.b	render(a0)
		bpl.w	SolObjCom_noColls		; branch if this object isnt onscreen

SolidObj2_ChkColls:
		move.w	xpos(a1),d0			; get xpos of player
		sub.w	xpos(a0),d0			; sub current xpos from d0
		add.w	d1,d0				; add width to d0
		move.w	d1,d3				; copy width to d3
		add.w	d3,d3				; double it
		cmp.w	d3,d0				; compare to xpos
		bhi.w	SolObjCom_noColls		; if higher, we are not colliding

		tst.b	ReverseGravity_Flag.w
		beq.s	.norev				; branch if reverse gravity isnt active
		move.b	yraddef(a1),d4			; get players default y-radius
		ext.w	d4				; extend to word
		add.w	d2,d4				; add height to y-radius
		move.b	yrad(a1),d3			; get players y-radius
		ext.w	d3				; extend to word
		add.w	d3,d2				; add y-radius to height

		move.w	ypos(a1),d3			; get player ypos to d3
		sub.w	ypos(a0),d3			; sub object ypos from d3
		neg.w	d3				; negate d3
		addq.w	#4,d3				; add 4 to d3
		add.w	d2,d3				; add height to d3
		andi.w	#$FFF,d3			; keep in range
		add.w	d2,d4				; add d2 to d4
		cmp.w	d4,d3				; compare with d3
		bhs.w	SolObjCom_noColls		; if not colliding, branch
		bra.s	SolidObjCom			; else we in fact are colliding

.norev		move.b	yraddef(a1),d4			; get players default y-radius
		ext.w	d4				; extend to word
		add.w	d2,d4				; add height to y-radius
		move.b	yrad(a1),d3			; get players y-radius
		ext.w	d3				; extend to word
		add.w	d3,d2				; add y-radius to height

		move.w	ypos(a1),d3			; get player ypos to d3
		sub.w	ypos(a0),d3			; sub object ypos from d3
		addq.w	#4,d3				; add 4 to d3
		add.w	d2,d3				; add height to d3
		andi.w	#$FFF,d3			; keep in range
		add.w	d2,d4				; add d2 to d4
		cmp.w	d4,d3				; compare with d3
		bhs.w	SolObjCom_noColls		; if not colliding, branch
; we are colliding. continue right here
; ---------------------------------------------------------------------------
; Routine to collide with object. Handles sides, bottom, getting on top,
; crushing, etc.
; input
; d0 = position of object relative to object xpos and width
; d1 = x-radius of the object
; d2 = y-radius of the object(?)
; d3 = position of object relative to object ypos and height
; d4 = height of the object(?)
; d6 = player on top bit
; ---------------------------------------------------------------------------
SolidObjCom:
		tst.b	Carried(a1)
		bmi.w	SolObjCom_noColls		; branch if Sonic is carried
		cmpi.b	#6,routine(a1)
		bhs.w	SolObjCom_Ret			; branch if player is dead
		tst.w	Debug_Routine.w
		bne.w	SolObjCom_Ret			; branch if debug mode is active

		move.w	d0,d5				; copy x-offset
		cmp.w	d0,d1				; check against the "middle" of the obj
		bhs.s	.isleft				; branch if we are left of the middle
		add.w	d1,d1				; double x-radius
		sub.w	d1,d0				; sub that from the x-offset
		move.w	d0,d5				; copy x-offset
		neg.w	d5				; negate offset

.isleft		move.w	d3,d1				; copy y-offset
		cmp.w	d3,d2				; check against the "middle" of the obj
		bhs.s	.isabove			; branch if we are above the middle
		subq.w	#4,d3				; sub 4 from y-radius
		sub.w	d4,d3				; sub height from y-radius
		move.w	d3,d1				; copy y-offset
		neg.w	d1				; negate offset

.isabove	cmp.w	d1,d5
		bhi.w	SolidObjCom_UpDown		; branch if we are in the object less vertically than horizontally(?)
		; not really sure what it does exactly, but it seems to decide whether to collide horizontally or vertically
		; probably to ensure you dont clip to sides when you stand on object, or to bottom when you collide with sides, etc
		cmpi.w	#4,d1
		bls.w	SolidObjCom_UpDown		; I assume this ensures the corners are not solid until some point
; ---------------------------------------------------------------------------
; when this code is ran, we are colliding from the sides of the object
; ---------------------------------------------------------------------------
SolidObjCom_Sides:
		tst.w	d0
		beq.s	.alignplayer			; branch if we are in the middle of the object?
		bmi.s	.chkright			; branch if we are right of the object
; left of the player...
		tst.w	xvel(a1)
		bmi.s	.alignplayer			; branch if player is moving left
		bra.s	.clrxspd			; else player is moving right, branch

.chkright	tst.w	xvel(a1)
		bpl.s	.alignplayer			; branch if player is moving right

.clrxspd	move.w	#0,inertia(a1)			; clear inertia of player
		move.w	#0,xvel(a1)			; clear horizontal velocity of player
		tst.b	unk37(a1)
		bpl.s	.alignplayer
		bset	#6,unk37(a1)
; ---------------------------------------------------------------------------
; this routine makes sure the player isn't inside the object
; ---------------------------------------------------------------------------
.alignplayer	sub.w	d0,xpos(a1)			; align player to the side of the object
		btst	#1,status(a1)
		bne.s	.inair				; branch if player is in air
		move.l	d6,d4				; get standing on top bit to d4
		addq.b	#2,d4				; add 2 to make it pushing bit
		bset	d4,status(a0)			; set pushing bit
		bset	#5,status(a1)			; set pushing bit of player

		move.w	d6,d4				; copy on top bit to d4
		addi.b	#13,d4				; add 13 to it
		bset	d4,d6				; set that bit (16 or 17)
		moveq	#1,d4
		rts

.inair		bsr.s	SolObjCom_ClrPush		; clear pushing bits
		move.w	d6,d4				; copy on top bit to d4
		addi.b	#13,d4				; add 13 to it
		bset	d4,d6				; set that bit (16 or 17)
		moveq	#1,d4
		rts
; ---------------------------------------------------------------------------
; not entirely sure what this would be used for.
; It seems to only rarely change the animation, maybe special cases?
; ---------------------------------------------------------------------------
SolObjCom_noColls:
		move.l	d6,d4				; get standing on top bit to d4
		addq.b	#2,d4				; add 2 to make it pushing bit
		btst	d4,status(a0)			; is player pushing to this object?
		beq.s	SolObjCom_Ret			; branch if not
		cmpi.b	#2,anim(a1)
		beq.s	SolObjCom_ClrPush		; branch if we are rolling
		cmpi.b	#9,anim(a1)
		beq.s	SolObjCom_ClrPush		; branch if we are spindashing
		move.w	#1,anim(a1)			; set to pushing animation

SolObjCom_ClrPush:
		move.l	d6,d4				; get standing on top bit to d4
		addq.b	#2,d4				; add 2 to make it pushing bit
		bclr	d4,status(a0)			; clear pushing bit
		bclr	#5,status(a1)			; clear pushing bit of player

SolObjCom_Ret:
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

SolidObjCom_UpDown:
		tst.w	d3
		bmi.s	SolidObjCom_Below		; branch if player is below the middle of the object
		cmpi.w	#$10,d3				; I dont know why this number specifically
		blo.s	SolidObjCom_Above		; if less than, collide
		bra.s	SolObjCom_noColls
; ---------------------------------------------------------------------------

SolidObjCom_Below:
		btst	#1,status(a1)
		bne.s	.inair				; branch if player is in air
		tst.w	yvel(a1)
		beq.s	.chkcrush			; branch if player is not moving
		bpl.s	.nocrush			; branch if player is moving down
; this next test statement is useless; d3 is always be negative
		tst.w	d3
		bpl.s	.nocrush			; branch if player is above the middle of the object (useless)
		bra.s	.chkrev				; move the player at edge of the object
; ---------------------------------------------------------------------------
; this seems to be ran whenever player is colliding with object from bottom
; (or top in reverse gravity), but player isn't to be crushed.
; It seems to prevent sticking into the objects surface and going inside it.
; d3 is negative by default
; ---------------------------------------------------------------------------
.inair		move.w	#0,inertia(a1)			; clear inertia of player
.chkrev		tst.b	ReverseGravity_Flag.w
		beq.s	.norev				; branch if reverse gravity isn't active
		neg.w	d3				; negate offset(?)

.norev		sub.w	d3,ypos(a1)			; push player below (above in reverse gravit) the object
		move.w	#0,yvel(a1)			; clear vertical velocity of player

.nocrush	tst.b	unk37(a1)
		bpl.s	.setbits
		bset	#5,unk37(a1)

.setbits	move.w	d6,d4				; copy on top bit to d4
		addi.b	#15,d4				; add 15 to it
		bset	d4,d6				; set that bit (18 or 19)
		moveq	#-2,d4
		rts
; ---------------------------------------------------------------------------
; this routine seems to check if player should be killed by crushing.
; likely only works if player is pushed into the object or object pushing into player.
; ---------------------------------------------------------------------------
.chkcrush	btst	#1,status(a1)			; this check is also useless. See 'SolidObjCom_Below'.
		bne.s	.nocrush			; branch if player is in air
		move.w	d0,d4				; get x-offset to d4
		abs.w	d4				; make this value absolute

		cmpi.w	#$10,d4				; probably branches if player is near the edge of object collision
		blo.w	SolidObjCom_Sides		; removing this line seems to confirm it
		move.l	a0,-(sp)			; store current obj
		movea.l	a1,a0				; get player to a0
		jsr	KillPlayer2			; kill the player (curshed?)
		movea.l	(sp)+,a0			; get this object back to a0

		move.w	d6,d4				; copy on top bit to d4
		addi.b	#15,d4				; add 15 to it
		bset	d4,d6				; set that bit (18 or 19)
		moveq	#-2,d4
		rts
; ---------------------------------------------------------------------------

SolidObjCom_Above:
		subq.w	#4,d3				; then go sub y-offset
		moveq	#0,d1

; this next bit ensures the player does not collide with the top when next to the walls
; recalculates object width.
		move.b	width(a0),d1			; get width of object to d1
		move.w	d1,d2				; copy it
		add.w	d2,d2				; double width

		add.w	xpos(a1),d1			; add xpos of player
		sub.w	xpos(a0),d1			; sub xpos of object
		bmi.s	.ret2				; if negative, we are not colliding, branch
		cmp.w	d2,d1
		bhs.s	.ret2				; branch if we are not colliding from right either

		subq.w	#1,ypos(a1)			; sub 1 from ypos
		tst.b	ReverseGravity_Flag.w
		beq.s	.norev				; branch if reverse gravity isn't active
		neg.w	d3				; negate offset
		addq.w	#2,ypos(a1)			; add 2 to ypos

.norev		sub.w	d3,ypos(a1)			; move object above the object (in reverse gravity below)
		tst.w	yvel(a1)
		bmi.s	.ret2				; branch if moving up
		bsr.w	SolidObj_LandOnTop		; place object on top of this object

		move.w	d6,d4				; copy on top bit to d4
		addi.b	#17,d4				; add 17 to it
		bset	d4,d6				; set that bit (20 or 21)
		moveq	#-1,d4
		rts

.ret2		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------
; routine to keep players moving on the platform and following it correctly.
; input
; d3 = height of platform
; d4 = xpos of platform
; ---------------------------------------------------------------------------
MvPlayerOnPtfm:
		tst.b	ReverseGravity_Flag.w
		bne.s	.revgrav			; branch if reverse gravity is active
		move.w	ypos(a0),d0			; get ypos of object
		sub.w	d3,d0				; sub height from ypos
		bra.s	MvPlayer_NoRev

.revgrav	move.w	ypos(a0),d0			; get ypos of object
		add.w	d3,d0				; add height to ypos
		bra.s	MvPlayer_Rev
; ---------------------------------------------------------------------------

		tst.b	ReverseGravity_Flag.w
		beq.s	.norev				; branch if reverse gravity isn't active
		move.w	ypos(a0),d0
		addi.w	#9,d0
		bra.s	MvPlayer_Rev

.norev		move.w	ypos(a0),d0
		subi.w	#9,d0
; ---------------------------------------------------------------------------

MvPlayer_NoRev:
		tst.b	Carried(a1)
		bmi.s	.rts
		cmpi.b	#6,routine(a1)
		bhs.s	.rts				; branch if player is dead
		tst.w	Debug_Routine.w
		bne.s	.rts				; branch if debug is active

		moveq	#0,d1
		move.b	yrad(a1),d1			; get y-radius of player
		sub.w	d1,d0				; sub that from target ypos
		move.w	d0,ypos(a1)			; set that as the y-pos of player

		sub.w	xpos(a0),d2			; sub object xpos from suggested xpos
		sub.w	d2,xpos(a1)			; sub the difference from xpos of player
.rts		rts
; ---------------------------------------------------------------------------

MvPlayer_Rev:
		tst.b	Carried(a1)
		bmi.s	.rts
		cmpi.b	#6,routine(a1)
		bhs.s	.rts				; branch if player is dead
		tst.w	Debug_Routine.w
		bne.s	.rts				; branch if debug is active

		moveq	#0,d1
		move.b	yrad(a1),d1			; get y-radius of player
		add.w	d1,d0				; add that to target ypos
		move.w	d0,ypos(a1)			; set that as the y-pos of player

		sub.w	xpos(a0),d2			; sub object xpos from suggested xpos
		sub.w	d2,xpos(a1)			; sub the difference from xpos of player
.rts		rts
; ---------------------------------------------------------------------------
; subroutine to move player on sloped object
; input:
; d1 = objects width
; d2 = x-pos of object
; a2 = slope data (heightmap from left to right)
; ---------------------------------------------------------------------------
SolidObj_TopSlopedNorm:
		btst	#3,status(a1)
		beq.s	locret_1E280			; branch if player isnt standing on an object
		move.w	xpos(a1),d0			; get players xpos to d0
		sub.w	xpos(a0),d0			; sub objects xpos from d0
		add.w	d1,d0				; add width to d0

		btst	#0,render(a0)
		beq.s	.0				; branch if we are x-flipped
		not.w	d0				; logical notation on d0 (negate-ish)
		add.w	d1,d0				; add width
		add.w	d1,d0				; twice
.0		bra.s	SolidObj_TopSlopedCom
; ---------------------------------------------------------------------------
; subroutine to move player on sloped object where 2 pixels have same height
; input:
; d1 = objects width
; d2 = x-pos of object
; a2 = slope data (heightmap from left to right)
; ---------------------------------------------------------------------------
SolidObj_TopSlopedDbl:
		btst	#3,status(a1)
		beq.s	locret_1E280			; branch if player isnt standing on an object
		move.w	xpos(a1),d0			; get players xpos to d0
		sub.w	xpos(a0),d0			; sub objects xpos from d0
		add.w	d1,d0				; add width to d0
		lsr.w	#1,d0				; shift to right once (divide by 2)

		btst	#0,render(a0)
		beq.s	SolidObj_TopSlopedCom		; branch if we are x-flipped
		not.w	d0				; logical notation on d0 (negate-ish)
		add.w	d1,d0				; add width to it

SolidObj_TopSlopedCom:
		move.b	(a2,d0.w),d1			; get y-offset
		ext.w	d1				; extend to word
		move.w	ypos(a0),d0			; get objects y-pos
		sub.w	d1,d0				; sub y-offset from ypos

		moveq	#0,d1
		move.b	yrad(a1),d1			; get players y-radius
		sub.w	d1,d0				; sub that from y-offset
		move.w	d0,ypos(a1)			; save it to players ypos

		sub.w	xpos(a0),d2			; sub object xpos from suggested xpos
		sub.w	d2,xpos(a1)			; sub the difference from xpos of player

locret_1E280:
		rts
; ---------------------------------------------------------------------------
; unused subroutine to move player on sloped object where 2 pixels have
; same height and each other byte is ignored
; input:
; d1 = objects width
; d2 = x-pos of object
; a2 = slope data (heightmap from left to right)
; ---------------------------------------------------------------------------
SolidObj_TopSlopedHalf:
		btst	#3,status(a1)
		beq.s	locret_1E280			; branch if player isnt standing on an object
		move.w	xpos(a1),d0			; get players xpos to d0
		sub.w	xpos(a0),d0			; sub objects xpos from d0
		add.w	d1,d0				; add width to d0

		btst	#0,render(a0)
		beq.s	.0				; branch if we are x-flipped
		not.w	d0				; logical notation on d0 (negate-ish)
		add.w	d1,d0				; add width to it

.0		andi.w	#$FE,d0				; clear least significant bit
		bra.s	SolidObj_TopSlopedCom
; ---------------------------------------------------------------------------
; input:
; d1 = objects width
; d3 = objects height
; d4 = x-pos of object
; ---------------------------------------------------------------------------
PlatformObj:
		lea	Object_RAM.w,a1			; get main player
		moveq	#3,d6				; get main players standing on object bit
		movem.l	d1-d4,-(sp)			; store variables
		bsr.s	PtfmObj_Single			; run common code
		movem.l	(sp)+,d1-d4			; get variables back
		lea	Obj_player_2.w,a1		; get sidekick
		addq.b	#1,d6				; get sidekicks standing on object bit

PtfmObj_Single:
		btst	d6,status(a0)
		beq.w	PtfmObj_ChkColls2		; branch if player is not standing on this object
		move.w	d1,d2				; copy objects width
		add.w	d2,d2				; double width
		btst	#1,status(a1)
		bne.s	.notontop			; branch if Player is on air

		move.w	xpos(a1),d0			; get xpos of Player
		sub.w	xpos(a0),d0			; sub xpos of the object
		add.w	d1,d0				; add width to d0
		bmi.s	.notontop			; if negative, we are beyond left edge
		cmp.w	d2,d0				; compare with 2x width
		blo.s	.isontop			; branch if we are not beyond right edge

.notontop	bclr	#3,status(a1)			; clear standing on object for Player
		bset	#1,status(a1)			; make player be in air
		bclr	d6,status(a0)			; clear player standing on this object
		moveq	#0,d4
		rts

.isontop	move.w	d4,d2				; copy xpos to d2
		bsr.w	MvPlayerOnPtfm			; move player on the top of the object
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------
; input:
; d1 = objects width
; d2 = objects height
; d3 = objects height(?)
; d4 = x-pos of object
; a2 = slope data (heightmap from left to right)
; ---------------------------------------------------------------------------
PtfmObj_SlopedDouble:
		lea	Object_RAM.w,a1			; get main player
		moveq	#3,d6				; get main players standing on object bit
		movem.l	d1-d4,-(sp)			; store variables
		bsr.s	PtfmObj_Dbl_Single		; run common code
		movem.l	(sp)+,d1-d4			; get variables back
		lea	Obj_player_2.w,a1		; get sidekick
		addq.b	#1,d6				; get sidekicks standing on object bit

PtfmObj_Dbl_Single:
		btst	d6,status(a0)
		beq.w	PtfmObj_ChkDblColls		; branch if player is not standing on this object
		move.w	d1,d2				; copy objects width
		add.w	d2,d2				; double width
		btst	#1,status(a1)
		bne.s	.notontop			; branch if Player is on air

		move.w	xpos(a1),d0			; get xpos of Player
		sub.w	xpos(a0),d0			; sub xpos of the object
		add.w	d1,d0				; add width to d0
		bmi.s	.notontop			; if negative, we are beyond left edge
		cmp.w	d2,d0				; compare with 2x width
		blo.s	.isontop			; branch if we are not beyond right edge

.notontop	bclr	#3,status(a1)			; clear standing on object for Player
		bset	#1,status(a1)			; make player be in air
		bclr	d6,status(a0)			; clear player standing on this object
		moveq	#0,d4
		rts

.isontop	move.w	d4,d2				; copy xpos to d2
		bsr.w	SolidObj_TopSlopedDbl		; move player on the top of the object
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------
; input:
; d1 = objects width
; d2 = objects height
; d3 = objects height(?)
; d4 = x-pos of object
; a2 = slope data (heightmap from left to right)
; ---------------------------------------------------------------------------
PtfmObj_Sloped:
		lea	Object_RAM.w,a1			; get main player
		moveq	#3,d6				; get main players standing on object bit
		movem.l	d1-d4,-(sp)			; store variables
		bsr.s	PtfmObj_Sloped_Single		; run common code
		movem.l	(sp)+,d1-d4			; get variables back
		lea	Obj_player_2.w,a1		; get sidekick
		addq.b	#1,d6				; get sidekicks standing on object bit

PtfmObj_Sloped_Single:
		btst	d6,status(a0)
		beq.w	PtfmObj_ChkSlopedColls		; branch if player is not standing on this object
		move.w	d1,d2				; copy objects width
		add.w	d2,d2				; double width
		btst	#1,status(a1)
		bne.s	.notontop			; branch if Player is on air

		move.w	xpos(a1),d0			; get xpos of Player
		sub.w	xpos(a0),d0			; sub xpos of the object
		add.w	d1,d0				; add width to d0
		bmi.s	.notontop			; if negative, we are beyond left edge
		cmp.w	d2,d0				; compare with 2x width
		blo.s	.isontop			; branch if we are not beyond right edge

.notontop	bclr	#3,status(a1)			; clear standing on object for Player
		bset	#1,status(a1)			; make player be in air
		bclr	d6,status(a0)			; clear player standing on this object
		moveq	#0,d4
		rts

.isontop	move.w	d4,d2				; copy xpos to d2
		bsr.w	SolidObj_TopSlopedNorm		; move player on the top of the object
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------
; input:
; d1 = objects width
; d2 = objects height
; d3 = objects height(?)
; d4 = x-pos of object
; ---------------------------------------------------------------------------
PtfmObj_SlopedHalf:
		lea	Object_RAM.w,a1			; get main player
		moveq	#3,d6				; get main players standing on object bit
		movem.l	d1-d4,-(sp)			; store variables
		bsr.s	PtfmObj_SlopedHalf_Single	; run common code
		movem.l	(sp)+,d1-d4			; get variables back
		lea	Obj_player_2.w,a1		; get sidekick
		addq.b	#1,d6				; get sidekicks standing on object bit

PtfmObj_SlopedHalf_Single:
		btst	d6,status(a0)
		bne.s	.chkontop			; branch if player is standing on this object
		btst	#3,status(a1)
		bne.s	.ret3				; branch if player isn standing on object
		bra.w	PtfmObj_ChkColls2

.chkontop	move.w	d1,d2				; copy objects width
		add.w	d2,d2				; double width
		btst	#1,status(a1)
		bne.s	.notontop			; branch if Player is on air

		move.w	xpos(a1),d0			; get xpos of Player
		sub.w	xpos(a0),d0			; sub xpos of the object
		add.w	d1,d0				; add width to d0
		bmi.s	.notontop			; if negative, we are beyond left edge
		cmp.w	d2,d0				; compare with 2x width
		blo.s	.isontop			; branch if we are not beyond right edge

.notontop	bclr	#3,status(a1)			; clear standing on object for Player
		bset	#1,status(a1)			; make player be in air
		bclr	d6,status(a0)			; clear player standing on this object

.ret3		moveq	#0,d4
		rts

.isontop	move.w	d4,d2				; copy xpos to d2
		bsr.w	MvPlayerOnPtfm			; move player on the top of the object
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------
; input:
; d1 = objects width
; d2 = objects width * 2
; d3 = objects height
; d4 = x-pos of object
; ---------------------------------------------------------------------------
PtfmObj_ChkColls:
		tst.w	yvel(a1)
		bmi.w	locret_1E4D4			; branch if player is moving up
		move.w	xpos(a1),d0			; get xpos of Player
		sub.w	xpos(a0),d0			; sub xpos of the object
		add.w	d1,d0				; add width to d0
		bmi.w	locret_1E4D4			; if negative, we are beyond left edge
		cmp.w	d2,d0				; compare with 2x width
		bhs.w	locret_1E4D4			; branch if we are beyond right edge
		bra.s	PtfmObj_ChkColls_Com
; ---------------------------------------------------------------------------
; input:
; d1 = objects width
; d2 = objects width * 2
; d3 = objects height
; d4 = x-pos of object
; ---------------------------------------------------------------------------
PtfmObj_ChkColls2:
		tst.w	yvel(a1)
		bmi.w	locret_1E4D4			; branch if player is moving up
		move.w	xpos(a1),d0			; get xpos of Player
		sub.w	xpos(a0),d0			; sub xpos of the object
		add.w	d1,d0				; add width to d0
		bmi.w	locret_1E4D4			; if negative, we are beyond left edge
		add.w	d1,d1				; double width
		cmp.w	d1,d0				; compare with 2x width
		bhs.w	locret_1E4D4			; branch if we are beyond right edge

PtfmObj_ChkColls_Com:
		tst.b	ReverseGravity_Flag.w
		bne.w	PtfmObj_ChkColls_Rev		; branch if reverse gravity is active
		move.w	ypos(a0),d0			; get objects ypos
		sub.w	d3,d0				; sub height from it
; continue directly to routine below
; ---------------------------------------------------------------------------
; Routine to check if we should collide with the platform.
; Used by many different kind of platform collision routines
; ---------------------------------------------------------------------------
PtfmObj_ChkColls_YGot:
		move.w	ypos(a1),d2			; get ypos of player
		move.b	yrad(a1),d1			; get y-radius of player
		ext.w	d1				; extend to word
		add.w	d2,d1				; add y-pos to y-radius
		addq.w	#4,d1				; add 4
		sub.w	d1,d0				; sub the result from y-pos
		bhi.w	locret_1E4D4			; branch if positive(?)
		cmpi.w	#-$10,d0
		blo.w	locret_1E4D4			; branch if less than -$10

		tst.b	Carried(a1)
		bmi.w	locret_1E4D4
		cmpi.b	#6,routine(a1)
		bhs.w	locret_1E4D4			; branch if player is ded
		add.w	d0,d2				; add the (negative) thing to ypos
		addq.w	#3,d2				; add 3 to it
		move.w	d2,ypos(a1)			; set as players ypos
; ---------------------------------------------------------------------------
; Routine to clear some variables and place player on top of an object.
; ---------------------------------------------------------------------------
SolidObj_LandOnTop:
		btst	#3,status(a1)
		beq.s	.isstanding			; branch if player is standin on object
		movea.w	interact(a1),a3			; get the object player is standing on
		bclr	d6,status(a3)			; clear its standing on object bit

.isstanding	move.w	a0,interact(a1)			; set this as the object player is standing on
		move.b	#0,angle(a1)			; clear angle
		move.w	#0,yvel(a1)			; clear y-velocity
		move.w	xvel(a1),inertia(a1)		; set x-velocity as inertia
		bset	#3,status(a1)			; set standing on object flag of player
		bset	d6,status(a0)			; set player standing on this object
		bclr	#1,status(a1)			; clear in air bit
		beq.s	locret_1E4D4			; if was clear already, branhc

		move.l	a0,-(sp)			; store this object
		movea.l	a1,a0				; put player in a0
		jsr	Player_ResetOnFloor		; reset variables to touch the floor
		movea.l	(sp)+,a0			; pop this object

locret_1E4D4:
		rts
; ---------------------------------------------------------------------------

PtfmObj_ChkColls_Rev:
		move.w	ypos(a0),d0			; get objects ypos
		add.w	d3,d0				; add height to it
		move.w	ypos(a1),d2			; get ypos of player
		move.b	yrad(a1),d1			; get y-radius of player
		ext.w	d1				; extend to word
		neg.w	d1				; negate radius
		add.w	d2,d1				; add y-pos to negated y-radius
		subq.w	#4,d1				; sub 4
		sub.w	d0,d1				; sub the y-pos from result
		bhi.s	locret_1E4D4			; branch if positive(?)
		cmpi.w	#-$10,d1
		blo.s	locret_1E4D4			; branch if less than -$10

		tst.b	Carried(a1)
		bmi.s	locret_1E4D4
		cmpi.b	#6,routine(a1)
		bhs.s	locret_1E4D4			; branch if player is ded
		sub.w	d1,d2				; sub the thing from ypos
		subq.w	#4,d2				; sub 4
		move.w	d2,ypos(a1)			; set as players ypos
		bra.s	SolidObj_LandOnTop
; ---------------------------------------------------------------------------
; input:
; d1 = objects width
; d2 = objects width * 2
; d3 = objects height
; d4 = x-pos of object
; a2 = slope data (heightmap from left to right)
; ---------------------------------------------------------------------------
PtfmObj_ChkDblColls:
		tst.w	yvel(a1)
		bmi.w	locret_1E4D4			; branch if player is moving up
		move.w	xpos(a1),d0			; get xpos of Player
		sub.w	xpos(a0),d0			; sub xpos of the object
		add.w	d1,d0				; add width to d0
		bmi.s	locret_1E4D4			; if negative, we are beyond left edge
		add.w	d1,d1				; double width
		cmp.w	d1,d0				; compare with 2x width
		bhs.s	locret_1E4D4			; branch if we are beyond right edge

		btst	#0,render(a0)
		beq.s	.noxflip			; branch if not x-flipped
		not.w	d0				; logical notation on d0 (negate-ish)
		add.w	d1,d0				; add doubled width to d0

.noxflip	lsr.w	#1,d0				; halve the offset
		move.b	(a2,d0.w),d3			; get height of the next segment
		ext.w	d3				; extend to word
		move.w	ypos(a0),d0			; get ypos of object
		sub.w	d3,d0				; sub height from ypos
		bra.w	PtfmObj_ChkColls_YGot
; ---------------------------------------------------------------------------
; input:
; d1 = objects width
; d2 = objects width * 2
; d3 = objects height
; d4 = x-pos of object
; a2 = slope data (heightmap from left to right)
; ---------------------------------------------------------------------------
PtfmObj_ChkSlopedColls:
		tst.w	yvel(a1)
		bmi.w	locret_1E4D4			; branch if player is moving up
		move.w	xpos(a1),d0			; get xpos of Player
		sub.w	xpos(a0),d0			; sub xpos of the object
		add.w	d1,d0				; add width to d0
		bmi.w	locret_1E4D4			; if negative, we are beyond left edge
		add.w	d1,d1				; double width
		cmp.w	d1,d0				; compare with 2x width
		bhs.w	locret_1E4D4			; branch if we are beyond right edge

		btst	#0,render(a0)
		beq.s	.noxflip			; branch if not x-flipped
		not.w	d0				; logical notation on d0 (negate-ish)
		add.w	d1,d0				; add doubled width to d0

.noxflip	move.b	(a2,d0.w),d3			; get height of the next segment
		ext.w	d3				; extend to word
		move.w	ypos(a0),d0			; get ypos of object
		sub.w	d3,d0				; sub height from ypos
		bra.w	PtfmObj_ChkColls_YGot
; ---------------------------------------------------------------------------
; Subroutine to put player on floor, if they are colliding with it
; ---------------------------------------------------------------------------
ChkPlayersOnGround:
		lea	Object_RAM.w,a1			; get main player to a1
		btst	#3,status(a0)
		beq.s	.sidekick			; branch if main player is not standing on this object
		jsr	PlayerOnObjFloorDist		; get floor height
		tst.w	d1				; check returned height
		beq.s	.clrflags1			; branch if 0
		bpl.s	.sidekick			; if positive (not on floor) branch

.clrflags1	lea	Object_RAM.w,a1			; get main player to a1
		bclr	#3,status(a1)			; clear player standing on object bit
		bset	#1,status(a1)			; put player on air
		bclr	#3,status(a0)			; clear main player standing on flag

.sidekick	lea	Obj_player_2.w,a1		; get sidekick to a1
		btst	#4,status(a0)
		beq.s	.ret				; branch if sidekick is not standing on this object
		jsr	PlayerOnObjFloorDist		; get floor height
		tst.w	d1				; check returned height
		beq.s	.clrflags2			; branch if 0
		bpl.s	.ret				; if positive (not on floor) branch

.clrflags2	lea	Obj_player_2.w,a1		; get sidekick to a1
		bclr	#3,status(a1)			; clear player standing on object bit
		bset	#1,status(a1)			; put player on air
		bclr	#4,status(a0)			; clear main player standing on flag

.ret		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------
; Subroutine to break objects into fragments
; input:
; a4 = Fragment speeds array
; ---------------------------------------------------------------------------
ObjToFragments:
		moveq	#$59,d0			; prepare breaking SFX
		jsr	PlaySFX.w		; play it
		move.w	#priority1,priority(a0)	; set priority

ObjToFragments2:
		moveq	#0,d0
		move.b	frame(a0),d0		; get object mappings frame
		add.w	d0,d0			; double it
		movea.l	mappings(a0),a3		; get mappings ptr
		adda.w	(a3,d0.w),a3		; get actual pointer

ObjToFragments3:
		move.w	(a3)+,d1		; get sprite count
		subq.w	#1,d1			; sub 1 for dbf

		move.l	(a0),d4			; get object pointer
		move.b	render(a0),d5		; get render flags
		bset	#5,d5			; set raw mappings bit
		movea.l	a0,a1			; copy source object to a1
		bra.s	.firstobj
; ---------------------------------------------------------------------------

.nextobj	jsr	CreateObjectAfter(pc)	; create new object
		bne.s	.rts			; if nonzero, branch
		addq.w	#6,a3			; advance to next mappings position
		move.l	d4,(a1)			; set the object address

		move.w	xpos(a0),xpos(a1)	; copy xpos
		move.w	ypos(a0),ypos(a1)	; copy ypos
		move.w	tile(a0),tile(a1)	; copy tile address
		move.b	priority(a0),priority(a1); copy priority
		move.w	height(a0),height(a1)	; copy height

.firstobj	move.l	a3,mappings(a1)		; set mappings ptr
		move.b	d5,render(a1)		; set render flags
		ori.w	#$8000,tile(a1)		; set to high plane
		move.w	(a4)+,xvel(a1)		; set xvel from array
		move.w	(a4)+,yvel(a1)		; set yvel from array
		dbf	d1,.nextobj		; loop until done
.rts		rts
; ---------------------------------------------------------------------------
