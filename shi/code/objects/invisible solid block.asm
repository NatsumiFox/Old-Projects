; ---------------------------------------------------------------------------
; These 3 objects are solid, and may hurt player depending on the type. They
; are solid and have any width and height multiple by 8 pixels up to 128 pixels
; ---------------------------------------------------------------------------
Obj_InvisSolidElectricBlk:
		bset	#5,shireact(a0)			; hurt player without lightning shield
		bra.s	Obj_InvisSolidBlock
; ---------------------------------------------------------------------------

Obj_InvisSolidLavaBlk:
		bset	#4,shireact(a0)			; hurt player without fire shield

Obj_InvisSolidBlock:
		move.l	#Map_InvisibleBlock,mappings(a0)
		move.w	#$86BC,tile(a0)
		ori.b	#4,render(a0)
		move.w	#priority4,priority(a0)
		bset	#7,status(a0)

		move.b	subtype(a0),d0			; get subtype
		move.b	d0,d1				; copy it
		andi.w	#$F0,d0				; keep only upper nibble
		addi.w	#$10,d0				; add 1 to it
		lsr.w	#1,d0				; shift right once (divide by 2)
		move.b	d0,width(a0)			; set as the width (each accounts for 8 px)

		andi.w	#$F,d1				; keep only lower nibble
		addq.w	#1,d1				; add 1 to it
		lsl.w	#3,d1				; shift left thrice (multiply by 8)
		move.b	d1,height(a0)			; set as the width (each accounts for 8 px)

		btst	#0,status(a0)
		beq.s	.noxflip			; branch if not x-flipped
		move.l	#Obj_InvisSolidBlock_Xflip,(a0)
		rts

.noxflip	btst	#1,status(a0)
		beq.s	.noyflip			; branch if not y-flipped
		move.l	#Obj_InvisSolidBlock_Yflip,(a0)
		rts
; ---------------------------------------------------------------------------

.noyflip	move.l	#Obj_InvisSolidBlock_Normal,(a0)
Obj_InvisSolidBlock_Normal:
		moveq	#0,d1
		move.b	width(a0),d1			; get object width
		addi.w	#11,d1				; add 11 to it
		moveq	#0,d2
		move.b	height(a0),d2			; get object height
		move.w	d2,d3				; copy it
		addq.w	#1,d3				; add 1 to height
		move.w	xpos(a0),d4			; get xpos
		bsr.w	SolidObj2			; collide with the object

		move.b	status(a0),d6			; get status bitfield
		andi.b	#$18,d6				; get only standing on top bits
		beq.s	.nocolls1			; if null, branch

		move.b	d6,d0				; copy
		andi.b	#8,d0				; get for main player
		beq.s	.chksidekick1			; if not set, branch
		lea	Object_RAM.w,a1			; get player's RAM
		bsr.w	InvisBlock_ChkHurt		; deal elemental damage

.chksidekick1	andi.b	#$10,d6				; get for sidekick
		beq.s	.nocolls1			; if not set, branch
		lea	Obj_player_2.w,a1		; get sidekick's RAM
		bsr.w	InvisBlock_ChkHurt		; deal elemental damage

.nocolls1	move.w	xpos(a0),d0			; get xpos
		andi.w	#$FF80,d0			; keep in chunks
		sub.w	Camera_X_Rough.w,d0		; sub rought camera xpos
		cmpi.w	#$280,d0
		bhi.w	DespawnObject_jmp		; branch if should be unloaded

		tst.w	Debug_Routine.w
		beq.s	.nodisp1			; branch if debug isn't active
		jmp	DrawSprite			; display
.nodisp1	rts
; ---------------------------------------------------------------------------

Obj_InvisSolidBlock_Xflip:
		moveq	#0,d1
		move.b	width(a0),d1			; get object width
		addi.w	#11,d1				; add 11 to it
		moveq	#0,d2
		move.b	height(a0),d2			; get object height
		move.w	d2,d3				; copy it
		addq.w	#1,d3				; add 1 to height
		move.w	xpos(a0),d4			; get xpos
		bsr.w	SolidObj2			; collide with the object

		swap	d6				; high word to low word
		andi.w	#3,d6				; keep only bits 16 and 17
		beq.s	.nocolls2			; if neither set, branch

; this is only ran when player pushes against the object(?)
		move.b	d6,d0				; copy it
		andi.b	#1,d0				; keep only main player bit
		beq.s	.chksidekick2			; if not set, branch
		lea	Object_RAM.w,a1			; get player's RAM
		bsr.w	InvisBlock_ChkHurt		; deal elemental damage

.chksidekick2	andi.b	#2,d6				; keep only sidekick bit
		beq.s	.nocolls2			; if not set, branch
		lea	Obj_player_2.w,a1		; get sidekick's RAM
		bsr.w	InvisBlock_ChkHurt		; deal elemental damage

.nocolls2	move.w	xpos(a0),d0			; get xpos
		andi.w	#$FF80,d0			; keep in chunks
		sub.w	Camera_X_Rough.w,d0		; sub rought camera xpos
		cmpi.w	#$280,d0
		bhi.w	DespawnObject_jmp		; branch if should be unloaded

		tst.w	Debug_Routine.w
		beq.s	.nodisp2			; branch if debug isn't active
		jmp	DrawSprite			; display
.nodisp2	rts
; ---------------------------------------------------------------------------
Obj_InvisSolidBlock_Yflip:
		moveq	#0,d1
		move.b	width(a0),d1			; get object width
		addi.w	#11,d1				; add 11 to it
		moveq	#0,d2
		move.b	height(a0),d2			; get object height
		move.w	d2,d3				; copy it
		addq.w	#1,d3				; add 1 to height
		move.w	xpos(a0),d4			; get xpos
		bsr.w	SolidObj2			; collide with the object

		swap	d6				; high word to low word
		andi.w	#$C,d6				; keep only bits 18 and 19
		beq.s	.nocolls3			; if null, branch

; this is only ran when player hits the bottom(?)
		move.b	d6,d0				; copy it
		andi.b	#4,d0				; keep only main player bit
		beq.s	.chksidekick3			; if not set, branch
		lea	Object_RAM.w,a1			; get player's RAM
		bsr.w	InvisBlock_ChkHurt		; deal elemental damage

.chksidekick3	andi.b	#8,d6				; keep only sidekick bit
		beq.s	.nocolls3			; if not set, branch
		lea	Obj_player_2.w,a1		; get sidekick's RAM
		bsr.w	InvisBlock_ChkHurt		; deal elemental damage

.nocolls3	move.w	xpos(a0),d0			; get xpos
		andi.w	#$FF80,d0			; keep in chunks
		sub.w	Camera_X_Rough.w,d0		; sub rought camera xpos
		cmpi.w	#$280,d0
		bhi.s	DespawnObject_jmp		; branch if should be unloaded

		tst.w	Debug_Routine.w
		beq.s	.nodisp3			; branch if debug isn't active
		jmp	DrawSprite.w			; display
.nodisp3	rts
; ---------------------------------------------------------------------------

InvisBlock_ChkHurt:
		move.b	shireact(a0),d0			; get shield react bits
		bmi.s	.rts				; if negative, no hurt
		andi.b	#$73,d0				; keep only shield bits
		and.b	shistatus(a1),d0		; shields clear bits from d0
		bne.s	.rts				; branch if not 0
		jmp	TryHurtPlayer(pc)		; else hurt the player
.rts		rts

DespawnObject_jmp:
		jmp	DespawnObject.w
; ---------------------------------------------------------------------------
; This objects is solid, and kills the player when interacted with. Ís solid
; and can have any width and height multiple by 8 pixels up to 128 pixels
; ---------------------------------------------------------------------------
Obj_InvisSolidBlkKill:
		move.l	#Map_InvisibleBlock,mappings(a0)
		move.w	#$86BC,tile(a0)
		ori.b	#4,render(a0)
		move.w	#priority4,priority(a0)
		bset	#7,status(a0)

		move.b	subtype(a0),d0			; get subtype
		move.b	d0,d1				; copy it
		andi.w	#$F0,d0				; keep only upper nibble
		addi.w	#$10,d0				; add 1 to it
		lsr.w	#1,d0				; shift right once (divide by 2)
		move.b	d0,width(a0)			; set as the width (each accounts for 8 px)

		andi.w	#$F,d1				; keep only lower nibble
		addq.w	#1,d1				; add 1 to it
		lsl.w	#3,d1				; shift left thrice (multiply by 8)
		move.b	d1,height(a0)			; set as the width (each accounts for 8 px)

		btst	#0,status(a0)
		beq.s	.noxflip			; branch if not x-flipped
		move.l	#.xflip,(a0)
		rts

.noxflip	btst	#1,status(a0)
		beq.s	.noyflip			; branch if not y-flipped
		move.l	#.yflip,(a0)
		rts
; ---------------------------------------------------------------------------

.noyflip	move.l	#.normal,(a0)
.normal		moveq	#0,d1
		move.b	width(a0),d1			; get object width
		addi.w	#11,d1				; add 11 to it
		moveq	#0,d2
		move.b	height(a0),d2			; get object height
		move.w	d2,d3				; copy it
		addq.w	#1,d3				; add 1 to height
		move.w	xpos(a0),d4			; get xpos
		bsr.w	SolidObj2			; collide with the object

		move.b	status(a0),d6			; get status bitfield
		andi.b	#$18,d6				; get only standing on top bits
		beq.s	.nocolls1			; if null, branch

		move.b	d6,d0				; copy
		andi.b	#8,d0				; get for main player
		beq.s	.chksidekick1			; if not set, branch
		lea	Object_RAM.w,a1			; get player's RAM
		bsr.w	InvisBlock_Kill			; kill player

.chksidekick1	andi.b	#$10,d6				; get for sidekick
		beq.s	.nocolls1			; if not set, branch
		lea	Obj_player_2.w,a1		; get sidekick's RAM
		bsr.w	InvisBlock_Kill			; kill player


.nocolls1	move.w	xpos(a0),d0			; get xpos
		andi.w	#$FF80,d0			; keep in chunks
		sub.w	Camera_X_Rough.w,d0		; sub rought camera xpos
		cmpi.w	#$280,d0
		bhi.w	DespawnObject_jmp			; branch if should be unloaded

		tst.w	Debug_Routine.w
		beq.s	.nodisp1			; branch if debug isn't active
		jmp	DrawSprite			; display
.nodisp1	rts
; ---------------------------------------------------------------------------

.xflip		moveq	#0,d1
		move.b	width(a0),d1			; get object width
		addi.w	#11,d1				; add 11 to it
		moveq	#0,d2
		move.b	height(a0),d2			; get object height
		move.w	d2,d3				; copy it
		addq.w	#1,d3				; add 1 to height
		move.w	xpos(a0),d4			; get xpos
		bsr.w	SolidObj2			; collide with the object

		swap	d6				; high word to low word
		andi.w	#3,d6				; keep only bits 16 and 17
		beq.s	.nocolls2			; if neither set, branch

; this is only ran when player pushes against the object(?)
		move.b	d6,d0				; copy it
		andi.b	#1,d0				; keep only main player bit
		beq.s	.chksidekick2			; if not set, branch
		lea	Object_RAM.w,a1			; get player's RAM
		bsr.w	InvisBlock_Kill			; kill player

.chksidekick2	andi.b	#2,d6				; keep only sidekick bit
		beq.s	.nocolls2			; if not set, branch
		lea	Obj_player_2.w,a1		; get sidekick's RAM
		bsr.w	InvisBlock_Kill			; kill player

.nocolls2	move.w	xpos(a0),d0			; get xpos
		andi.w	#$FF80,d0			; keep in chunks
		sub.w	Camera_X_Rough.w,d0		; sub rought camera xpos
		cmpi.w	#$280,d0
		bhi.w	DespawnObject_jmp			; branch if should be unloaded

		tst.w	Debug_Routine.w
		beq.s	.nodisp2			; branch if debug isn't active
		jmp	DrawSprite			; display
.nodisp2	rts
; ---------------------------------------------------------------------------

.yflip		moveq	#0,d1
		move.b	width(a0),d1			; get object width
		addi.w	#11,d1				; add 11 to it
		moveq	#0,d2
		move.b	height(a0),d2			; get object height
		move.w	d2,d3				; copy it
		addq.w	#1,d3				; add 1 to height
		move.w	xpos(a0),d4			; get xpos
		bsr.w	SolidObj2			; collide with the object

		swap	d6				; high word to low word
		andi.w	#$C,d6				; keep only bits 18 and 19
		beq.s	.nocolls3			; if null, branch

; this is only ran when player hits the bottom(?)
		move.b	d6,d0				; copy it
		andi.b	#4,d0				; keep only main player bit
		beq.s	.chksidekick3			; if not set, branch
		lea	Object_RAM.w,a1			; get player's RAM
		bsr.w	InvisBlock_Kill			; kill player

.chksidekick3	andi.b	#8,d6				; keep only sidekick bit
		beq.s	.nocolls3			; if not set, branch
		lea	Obj_player_2.w,a1		; get sidekick's RAM
		bsr.w	InvisBlock_Kill			; kill player

.nocolls3	move.w	xpos(a0),d0			; get xpos
		andi.w	#$FF80,d0			; keep in chunks
		sub.w	Camera_X_Rough.w,d0		; sub rought camera xpos
		cmpi.w	#$280,d0
		bhi.w	DespawnObject_jmp			; branch if should be unloaded

		tst.w	Debug_Routine.w
		beq.s	.nodisp3			; branch if debug isn't active
		jmp	DrawSprite			; display
.nodisp3	rts
; ---------------------------------------------------------------------------

InvisBlock_Kill:
		move.w	d6,-(sp)
		move.l	a0,-(sp)
		movea.l	a1,a0				; put player from a1 to a0
		jsr	KillPlayer2			; kill the player
		movea.l	(sp)+,a0
		move.w	(sp)+,d6
		rts
; ---------------------------------------------------------------------------
Map_InvisibleBlock:	include "levels/common/Invisible Solid Block/map.asm"
; ---------------------------------------------------------------------------
