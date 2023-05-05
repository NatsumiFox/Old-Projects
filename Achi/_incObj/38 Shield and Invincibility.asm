; ---------------------------------------------------------------------------
; Object 38 - shield and invincibility stars
; ---------------------------------------------------------------------------

ShieldItem:
		move.l	#Map_Shield,obMap(a0)
		move.b	#4,obRender(a0)
	display		1, a0
		move.b	#$10,obActWid(a0)
		move.w	#vram_shi/32,obGfx(a0)	; shield specific code
		move.l	#Shi_Shield,(a0)

Shi_Shield:	; Routine 2
		tst.b	(v_invinc).w	; does Sonic have invincibility?
		bne.s	@remove		; if yes, branch
		tst.b	(v_shield).w	; does Sonic have shield?
		beq.s	@delete		; if not, branch

		tst.b	$3F(a0)		; check if shield gfx is loaded
		bne.s	@loaded		; if is, brach
		st	$3F(a0)		; set shield gfx flag

		move.l	#Nem_Shield,d1
		move.w	#vram_shi,d2
		move.w	#$200,d3
		jsr	QueueDMATransfer

@loaded		move.w	(v_player+obX).w,obX(a0)
		move.w	(v_player+obY).w,obY(a0)
		move.b	(v_player+obStatus).w,obStatus(a0)
		lea	(Ani_Shield).l,a1
		jsr	(AnimateSprite).l

@remove:
		clr.b	$3F(a0)		; clear shield gfx flag
	NEXT_OBJ

	@delete:
		jsr	(DeleteObject).l
	NEXT_OBJ
; ===========================================================================

Shi_Stars:	; Routine 4
		move.l	#Nem_Stars,d1
		move.w	#vram_shi,d2
		move.w	#$240,d3
		jsr	QueueDMATransfer

		move.l	#Map_Shield,obMap(a0)
		move.b	#4,obRender(a0)
	display		1, a0
		move.b	#$10,obActWid(a0)
		move.w	#vram_shi/32,obGfx(a0)
		move.l	#@main,(a0)

@main		tst.b	(v_invinc).w		; does Sonic have invincibility?
		beq.s	Shi_Start_Delete	; if not, branch
		move.w	(v_trackpos).w,d0	; get index value for tracking data
		move.b	obAnim(a0),d1
		subq.b	#1,d1

@trail:
		lsl.b	#3,d1		; multiply animation number by 8
		move.b	d1,d2
		add.b	d1,d1
		add.b	d2,d1		; multiply by 3
		addq.b	#4,d1
		sub.b	d1,d0
		move.b	$30(a0),d1
		sub.b	d1,d0		; use earlier tracking data to create trail
		addq.b	#4,d1
		cmpi.b	#$18,d1
		bcs.s	@a
		moveq	#0,d1

	@a:
		move.b	d1,$30(a0)

	@b:
		lea	(v_tracksonic).w,a1
		add.w	d0,a1
		move.w	(a1)+,obX(a0)
		move.w	(a1)+,obY(a0)
		move.b	(v_player+obStatus).w,obStatus(a0)
		lea	(Ani_Shield).l,a1
		jsr	(AnimateSprite).l
	NEXT_OBJ
; ===========================================================================

Shi_Start_Delete:
		jsr	(DeleteObject).l
	NEXT_OBJ
