byte_23F74:
		dc.b $10
		dc.b $10
		dc.b $20
		dc.b $10
		dc.b $30
		dc.b $10
		dc.b $40
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b $20
		dc.b $10
		dc.b $30
		dc.b $10
		dc.b $40

Obj_Spikes:
		ori.b	#4,4(a0)
		move.w	#$200,8(a0)
		move.b	$2C(a0),d0
		andi.w	#$F0,d0
		lsr.w	#3,d0
		lea	byte_23F74(pc,d0.w),a1
		move.b	(a1)+,7(a0)
		move.b	(a1)+,6(a0)
		move.l	#loc_24090,(a0)
		move.l	#Map_Spikes,$C(a0)
		move.w	#$53C,$A(a0)

loc_23FD0:
		lsr.w	#1,d0
		move.b	d0,$22(a0)
		cmpi.b	#4,d0
		blo.s	loc_23FE8
		move.l	#loc_240E2,(a0)
		move.w	#$534,$A(a0)

loc_23FE8:
		move.b	$2A(a0),d0
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_23FF6
		eori.b	#2,d0

loc_23FF6:
		andi.b	#2,d0
		beq.s	loc_24002
		move.l	#loc_2413E,(a0)


; ---------------------------------------------------------------------------

loc_24002:
		move.w	#$20,$3C(a0)
		move.w	$10(a0),$30(a0)
		move.w	$14(a0),$32(a0)
		move.b	$2C(a0),d0
		andi.b	#$F,d0
		add.b	d0,d0
		move.b	d0,$2C(a0)
		rts


; ---------------------------------------------------------------------------

byte_24024:
		dc.b   $C,  $C,	$18,  $C, $24,	$C, $30,  $C,  $C,  $C,	 $C, $18,  $C, $24,  $C, $30


loc_24090:
		bsr.w	sub_242B6
		moveq	#0,d1
		move.b	7(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	6(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	$10(a0),d4
		bsr.w	SolidObj
		move.b	$2A(a0),d6
		andi.b	#$18,d6
		beq.s	loc_240D8
		move.b	d6,d0
		andi.b	#8,d0
		beq.s	loc_240CA
		lea	Object_RAM.w,a1
		bsr.w	TryHurtPlayer

loc_240CA:
		andi.b	#$10,d6
		beq.s	loc_240D8
		lea	Obj_player_2.w,a1
		bsr.w	TryHurtPlayer


; ---------------------------------------------------------------------------

loc_240D8:
		move.w	$30(a0),d0
		jmp	ChkDispObjLoaded2

loc_240E2:
		bsr.w	sub_242B6
		moveq	#0,d1
		move.b	7(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	6(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	$10(a0),d4
		bsr.w	SolidObj
		swap	d6
		andi.w	#3,d6
		beq.s	loc_24134
		move.b	d6,d0
		andi.b	#1,d0
		beq.s	loc_24120
		lea	Object_RAM.w,a1
		bsr.w	TryHurtPlayer
		bclr	#5,$2A(a0)

loc_24120:
		andi.b	#2,d6
		beq.s	loc_24134
		lea	Obj_player_2.w,a1
		bsr.w	TryHurtPlayer
		bclr	#6,$2A(a0)


; ---------------------------------------------------------------------------

loc_24134:
		move.w	$30(a0),d0
		jmp	ChkDispObjLoaded2

loc_2413E:
		bsr.w	sub_242B6
		moveq	#0,d1
		move.b	7(a0),d1
		addi.w	#$B,d1
		moveq	#0,d2
		move.b	6(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	$10(a0),d4
		bsr.w	SolidObj
		swap	d6
		andi.w	#$C,d6
		beq.s	loc_24184
		move.b	d6,d0
		andi.b	#4,d0
		beq.s	loc_24176
		lea	Object_RAM.w,a1
		bsr.w	TryHurtPlayer

loc_24176:
		andi.b	#8,d6
		beq.s	loc_24184
		lea	Obj_player_2.w,a1
		bsr.w	TryHurtPlayer


; ---------------------------------------------------------------------------

loc_24184:
		move.w	$30(a0),d0
		jmp	ChkDispObjLoaded2

loc_2418E:
		bsr.w	sub_243BA
		moveq	#0,d1
		move.b	7(a0),d1
		addi.w	#7,d1
		moveq	#0,d2
		move.b	6(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	$10(a0),d4
		bsr.w	SolidObj
		move.b	$2A(a0),d6
		andi.b	#$18,d6
		beq.s	loc_241D6
		move.b	d6,d0
		andi.b	#8,d0
		beq.s	loc_241C8
		lea	Object_RAM.w,a1
		bsr.w	TryHurtPlayer

loc_241C8:
		andi.b	#$10,d6
		beq.s	loc_241D6
		lea	Obj_player_2.w,a1
		bsr.w	TryHurtPlayer


; ---------------------------------------------------------------------------

loc_241D6:
		jmp	DrawSprite

loc_241DC:
		bsr.w	sub_243BA
		moveq	#0,d1
		move.b	7(a0),d1
		addi.w	#7,d1
		moveq	#0,d2
		move.b	6(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	$10(a0),d4
		bsr.w	SolidObj
		swap	d6
		andi.w	#3,d6
		beq.s	loc_2422E
		move.b	d6,d0
		andi.b	#1,d0
		beq.s	loc_2421A
		lea	Object_RAM.w,a1
		bsr.w	TryHurtPlayer
		bclr	#5,$2A(a0)

loc_2421A:
		andi.b	#2,d6
		beq.s	loc_2422E
		lea	Obj_player_2.w,a1
		bsr.w	TryHurtPlayer
		bclr	#6,$2A(a0)


; ---------------------------------------------------------------------------

loc_2422E:
		jmp	DrawSprite

loc_24234:
		bsr.w	sub_243BA
		moveq	#0,d1
		move.b	7(a0),d1
		addi.w	#7,d1
		moveq	#0,d2
		move.b	6(a0),d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	$10(a0),d4
		bsr.w	SolidObj
		swap	d6
		andi.w	#$C,d6
		beq.s	loc_2427A
		move.b	d6,d0
		andi.b	#4,d0
		beq.s	loc_2426C
		lea	Object_RAM.w,a1
		bsr.w	TryHurtPlayer

loc_2426C:
		andi.b	#8,d6
		beq.s	loc_2427A
		lea	Obj_player_2.w,a1
		bsr.w	TryHurtPlayer


; ############### S U B	R O U T	I N E #######################################

loc_2427A:
		jmp	DrawSprite
; ---------------------------------------------------------------------------

TryHurtPlayer:
		btst	#1,shistatus(a1)
		bne.s	.rts		; branch if player is invincible
		tst.b	invultime(a1)
		bne.s	.rts		; branch if player is invulnerable
		cmpi.b	#4,routine(a1)
		bhs.s	.rts		; branch if player is hurt or dead

		move.l	ypos(a1),d3
		move.w	yvel(a1),d0
		ext.l	d0
		asl.l	#8,d0
		sub.l	d0,d3
		move.l	d3,ypos(a1)

		movea.l	a0,a2
		movea.l	a1,a0
		jsr	HurtPlayer2
		movea.l	a2,a0
.rts		rts
; ---------------------------------------------------------------------------

sub_242B6:
		moveq	#0,d0
		move.b	$2C(a0),d0
		move.w	off_242C4(pc,d0.w),d1
		jmp	off_242C4(pc,d1.w)


; ---------------------------------------------------------------------------

off_242C4:
		dc.w locret_242CC-off_242C4
		dc.w loc_242CE-off_242C4
		dc.w loc_242E2-off_242C4
		dc.w loc_24356-off_242C4


; ---------------------------------------------------------------------------

locret_242CC:
		rts


; ---------------------------------------------------------------------------

loc_242CE:
		bsr.w	sub_242F6
		moveq	#0,d0
		move.b	$34(a0),d0
		add.w	$32(a0),d0
		move.w	d0,$14(a0)
		rts


; ############### S U B	R O U T	I N E #######################################

loc_242E2:
		bsr.w	sub_242F6
		moveq	#0,d0
		move.b	$34(a0),d0
		add.w	$30(a0),d0
		move.w	d0,$10(a0)
		rts


; ---------------------------------------------------------------------------

sub_242F6:
		tst.w	$38(a0)
		beq.s	loc_24312
		subq.w	#1,$38(a0)
		bne.s	locret_24354
		tst.b	4(a0)
		bpl.s	locret_24354
		moveq	#$52,d0
		jsr	PlaySFX
		bra.s	locret_24354


; ---------------------------------------------------------------------------

loc_24312:
		tst.w	$36(a0)
		beq.s	loc_24334
		subi.w	#$800,$34(a0)
		bhs.s	locret_24354
		move.w	#0,$34(a0)
		move.w	#0,$36(a0)
		move.w	#$3C,$38(a0)
		bra.s	locret_24354

loc_24334:
		addi.w	#$800,$34(a0)
		cmpi.w	#$2000,$34(a0)
		blo.s	locret_24354
		move.w	#$2000,$34(a0)
		move.w	#1,$36(a0)
		move.w	#$3C,$38(a0)


; End of function sub_242F6
; ---------------------------------------------------------------------------

locret_24354:
		rts

loc_24356:
		move.b	$2A(a0),d3
		andi.b	#$60,d3
		beq.s	loc_2437C
		move.w	$10(a0),d2
		lea	Object_RAM.w,a1
		move.b	$3E(a0),d0
		moveq	#5,d6
		bsr.s	sub_2438A
		lea	Obj_player_2.w,a1
		move.b	$3F(a0),d0
		moveq	#6,d6
		bsr.s	sub_2438A


; ############### S U B	R O U T	I N E #######################################

loc_2437C:
		move.b	Object_RAM+$2A.w,$3E(a0)
		move.b	Obj_player_2+$2A.w,$3F(a0)
		rts

sub_2438A:
		btst	d6,d3
		beq.s	locret_243B8
		cmp.w	$10(a1),d2
		blo.s	locret_243B8
		btst	#5,d0
		beq.s	locret_243B8
		subq.w	#1,$3A(a0)
		bpl.s	locret_243B8
		move.w	#$10,$3A(a0)
		tst.w	$3C(a0)
		beq.s	locret_243B8
		subq.w	#1,$3C(a0)
		addq.w	#1,$10(a0)
		addq.w	#1,$10(a1)


; End of function sub_2438A
; ############### S U B	R O U T	I N E #######################################

locret_243B8:
		rts


; End of function sub_243BA
; ---------------------------------------------------------------------------

sub_243BA:
		moveq	#0,d0
		move.b	$2C(a0),d0
		move.w	word_243C8(pc,d0.w),d1
		jmp	word_243C8(pc,d1.w)


; ---------------------------------------------------------------------------

word_243C8:
		dc.w locret_242CC-word_243C8
		dc.w loc_243CE-word_243C8
		dc.w loc_243E2-word_243C8


; ---------------------------------------------------------------------------

loc_243CE:
		bsr.w	sub_243F6
		moveq	#0,d0
		move.b	$34(a0),d0
		add.w	$32(a0),d0
		move.w	d0,$14(a0)
		rts


; ############### S U B	R O U T	I N E #######################################

loc_243E2:
		bsr.w	sub_243F6
		moveq	#0,d0
		move.b	$34(a0),d0
		add.w	$30(a0),d0
		move.w	d0,$10(a0)
		rts


; ---------------------------------------------------------------------------

sub_243F6:
		tst.w	$38(a0)
		beq.s	loc_24412
		subq.w	#1,$38(a0)
		bne.s	locret_24454
		tst.b	4(a0)
		bpl.s	locret_24454
		moveq	#$52,d0
		jsr	PlaySFX
		bra.s	locret_24454


; ---------------------------------------------------------------------------

loc_24412:
		tst.w	$36(a0)
		beq.s	loc_24434
		subi.w	#$800,$34(a0)
		bhs.s	locret_24454
		move.w	#0,$34(a0)
		move.w	#0,$36(a0)
		move.w	#$3C,$38(a0)
		bra.s	locret_24454

loc_24434:
		addi.w	#$800,$34(a0)
		cmpi.w	#$1800,$34(a0)
		blo.s	locret_24454
		move.w	#$1800,$34(a0)
		move.w	#1,$36(a0)
		move.w	#$3C,$38(a0)


; End of function sub_243F6
; ---------------------------------------------------------------------------

locret_24454:
		rts

Map_Spikes:	include 'levels\common\Spikes\map.asm'
