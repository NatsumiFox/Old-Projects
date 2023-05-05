Obj_Explosion:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	.i(pc,d0.w),d1
		jmp	.i(pc,d1.w)

; ---------------------------------------------------------------------------
.i		dc.w .createanimal-.i
		dc.w .playsfx-.i
		dc.w .runani-.i
		dc.w .initobj-.i
; ---------------------------------------------------------------------------

.createanimal	addq.b	#2,routine(a0)			; set to next routine
		jsr	CreateObject			; attempt to create new object
		bne.s	.playsfx			; if failed, play SFX anyway
		move.l	#Obj_Animal,(a1)		; create animal
		move.w	xpos(a0),xpos(a1)		; copy xpos
		move.w	ypos(a0),ypos(a1)		; copy ypos
		move.w	oboff3E(a0),oboff3E(a1)

.playsfx	moveq	#$3D,d0
		jsr	PlaySFX				; play explosion sfx
		addq.b	#2,routine(a0)			; set to next routine

.initobj	move.l	#Map_Explosion,mappings(a0)	; set mappings
		move.w	tile(a0),d0			; get art tile
		andi.w	#$8000,d0			; keep only high bit
		ori.w	#$5A0,d0			; put this object's art offset to d0
		move.w	d0,tile(a0)			; store to art tile again
		move.b	#4,render(a0)			; set to work on level plane
		move.w	#priority1,priority(a0)		; set priority
		move.b	#0,collision(a0)		; set to no collide with player
		move.b	#$C,width(a0)
		move.b	#$C,height(a0)
		move.b	#4-1,anitime(a0)		; set animation time
		move.b	#0,frame(a0)			; clear frame
		move.l	#.runani,(a0)			; set the object

.runani		subq.b	#1,anitime(a0)			; sub 1 from animation timer
		bpl.s	.disp				; if positive, display only
		move.b	#8-1,anitime(a0)		; set animation timer to 8
		addq.b	#1,frame(a0)			; increment frame
		cmpi.b	#5,frame(a0)			; is the frame ID 5?
		beq.w	DeleteObject_This		; if so, delete object
.disp		jmp	DrawSprite			; draw the sprite
; ---------------------------------------------------------------------------

Obj_FireShield_Dissipate:
		move.l	#Map_Explosion,mappings(a0)	; set mappings
		move.w	#$5A0,tile(a0)			; set art tile
		move.b	#4,render(a0)			; set to work on level plane
		move.w	#priority5,priority(a0)		; set priority
		move.b	#$C,width(a0)
		move.b	#$C,height(a0)
		move.b	#4-1,anitime(a0)		; set animation time
		move.b	#1,frame(a0)			; clear frame
		move.l	#.main,(a0)			; set the object

.main		jsr	ObjectMove			; move the object
		subq.b	#1,anitime(a0)			; sub 1 from animation timer
		bpl.s	.disp				; if positive, display only
		move.b	#4-1,anitime(a0)		; set animation timer to 4
		addq.b	#1,frame(a0)			; increment frame
		cmpi.b	#5,frame(a0)			; is the frame ID 5?
		beq.w	DeleteObject_This		; if so, delete object
.disp		jmp	DrawSprite			; draw the sprite
; ---------------------------------------------------------------------------

Obj_DelayedExplo:
		move.l	#Map_Explosion,mappings(a0)	; set mappings
		move.w	#$85A0,tile(a0)			; set art tile
		move.b	#4,render(a0)			; set to work on level plane
		move.w	#priority2,priority(a0)		; set priority
		move.b	#$C,width(a0)
		move.b	#$C,height(a0)
		move.b	#0,frame(a0)			; clear frame
		move.l	#.wait,(a0)			; set the object

.wait		subq.b	#1,anitime(a0)			; sub 1 from anim time
		bmi.s	.initfull			; if negative, branch
		rts

.initfull	move.b	#4-1,anitime(a0)		; set animation time
		move.l	#.main,(a0)			; set to main object

.main		jsr	ObjectMove			; move the object
		subq.b	#1,anitime(a0)			; sub 1 from animation timer
		bpl.s	.disp				; if positive, display only
		move.b	#8-1,anitime(a0)		; set animation timer to 8
		addq.b	#1,frame(a0)			; increment frame
		cmpi.b	#5,frame(a0)			; is the frame ID 5?
		beq.w	DeleteObject_This		; if so, delete object
.disp		jmp	DrawSprite			; draw the sprite

; ---------------------------------------------------------------------------
Map_Explosion:	include "levels/common/Explosion/map.asm"
; ---------------------------------------------------------------------------
