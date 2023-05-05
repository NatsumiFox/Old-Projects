Obj_Bumper:
		move.b	#4,4(a0)
		move.b	#$10,7(a0)
		move.b	#$10,6(a0)
		move.w	#$80,8(a0)

loc_32E0A:
		move.b	#$C0|3,$28(a0)


; ---------------------------------------------------------------------------

loc_32E10:
		move.w	$10(a0),$30(a0)
		move.w	$14(a0),$32(a0)

loc_32E3C:
		move.l	#Map_Bumper,$C(a0)
		move.w	#$4364,$A(a0)
		move.l	#loc_32EAA,(a0)
		move.b	$2C(a0),d0
		beq.s	loc_32EAA
		move.b	d0,$26(a0)
		move.l	#loc_32E7E,(a0)

loc_32E7E:
		move.b	Level_Frame_Timer+1.w,d0
		btst	#0,$2A(a0)
		beq.s	loc_32E8C
		neg.b	d0

loc_32E8C:
		add.b	$26(a0),d0
		jsr	GetSine
		asr.w	#2,d1
		asr.w	#2,d0
		add.w	$30(a0),d1
		add.w	$32(a0),d0
		move.w	d1,$10(a0)
		move.w	d0,$14(a0)

loc_32EAA:
		tst.b	$29(a0)
		beq.s	loc_32EB4
		bsr.w	sub_32F34


; ---------------------------------------------------------------------------

loc_32EB4:
		lea	Ani_33094,a1
		jsr	AnimateSprite
		move.w	$30(a0),d0
		andi.w	#-$80,d0
		sub.w	Camera_X_Rough.w,d0
		cmpi.w	#$280,d0
		bhi.s	loc_32EDE
		jsr	AddToCollResponseList.w
		jmp	DrawSprite

loc_32EDE:
		move.w	$48(a0),d0
		beq.s	loc_32EEA
		movea.w	d0,a2
		bclr	#7,(a2)


; ---------------------------------------------------------------------------

loc_32EEA:
		jmp	DeleteObject_This

loc_32EF0:
		tst.b	$29(a0)
		beq.s	loc_32EF8
		bsr.s	sub_32F34


; ---------------------------------------------------------------------------

loc_32EF8:
		lea	Ani_33094,a1
		jsr	AnimateSprite
		move.w	$14(a0),d0
		andi.w	#-$80,d0
		sub.w	Camera_Y_Rough.w,d0
		cmpi.w	#$200,d0
		bhi.s	loc_32F22
		jsr	AddToCollResponseList.w
		jmp	DrawSprite

loc_32F22:
		move.w	$48(a0),d0
		beq.s	loc_32F2E
		movea.w	d0,a2
		bclr	#7,(a2)


; ############### S U B	R O U T	I N E #######################################

loc_32F2E:
		jmp	DeleteObject_This

sub_32F34:
		lea	Object_RAM.w,a1
		bclr	#0,$29(a0)
		beq.s	loc_32F42
		bsr.s	sub_32F56

loc_32F42:
		lea	Obj_player_2.w,a1
		bclr	#1,$29(a0)
		beq.s	loc_32F50
		bsr.s	sub_32F56


; End of function sub_32F34
; ############### S U B	R O U T	I N E #######################################

loc_32F50:
		clr.b	$29(a0)
		rts

sub_32F56:
		move.w	$10(a0),d1
		move.w	$14(a0),d2
		sub.w	$10(a1),d1
		sub.w	$14(a1),d2
		jsr	GetArcTan

loc_32F6C:
		move.b	Level_Frame_Timer.w,d1
		andi.w	#3,d1
		add.w	d1,d0
		jsr	GetSine
		muls.w	#-$700,d1
		asr.l	#8,d1

loc_32F82:
		move.w	d1,$18(a1)

loc_32F86:
		muls.w	#-$700,d0
		asr.l	#8,d0
		move.w	d0,$1A(a1)
		bset	#1,$2A(a1)

loc_32F96:
		bclr	#4,$2A(a1)
		bclr	#5,$2A(a1)
		clr.b	$40(a1)
		move.b	#1,$20(a0)
		moveq	#-$56,d0
		jsr	PlaySFX
		move.w	$48(a0),d0
		beq.s	loc_32FC4
		movea.w	d0,a2
		cmpi.b	#-$76,(a2)
		bhs.s	locret_32FEE
		addq.b	#1,(a2)

loc_32FC4:
		moveq	#1,d0
		movea.w	a1,a3
		jsr	HUD_AddScore
		jsr	CreateObject
		bne.s	locret_32FEE
		move.l	#Obj_EnemyScore,(a1)
		move.w	$10(a0),$10(a1)
		move.w	$14(a0),$14(a1)
		move.b	#4,$22(a1)


; End of function sub_32F56
; ---------------------------------------------------------------------------

locret_32FEE:
		rts

loc_32FF0:
		tst.b	$29(a0)
		beq.w	loc_3307C
		lea	Object_RAM.w,a1

loc_32FFC:
		bclr	#0,$29(a0)
		beq.s	loc_33006
		bsr.s	sub_3301C

loc_33006:
		lea	Obj_player_2.w,a1
		bclr	#1,$29(a0)
		beq.s	loc_33014
		bsr.s	sub_3301C


; ############### S U B	R O U T	I N E #######################################

loc_33014:
		clr.b	$29(a0)
		bra.w	loc_3307C


; End of function sub_3301C
; ---------------------------------------------------------------------------

sub_3301C:
		move.w	$10(a0),d1
		move.w	$14(a0),d2
		sub.w	$10(a1),d1
		sub.w	$14(a1),d2
		jsr	GetArcTan
		move.b	Level_Frame_Timer.w,d1
		andi.w	#3,d1
		add.w	d1,d0
		jsr	GetSine
		muls.w	#-$700,d1
		asr.l	#8,d1
		move.w	d1,$18(a1)
		muls.w	#-$700,d0
		asr.l	#8,d0
		move.w	d0,$1A(a1)
		bset	#1,$2A(a1)
		bclr	#4,$2A(a1)
		bclr	#5,$2A(a1)
		clr.b	$40(a1)
		move.b	#1,$20(a0)
		moveq	#$7B,d0
		jsr	PlaySFX
		rts


; ---------------------------------------------------------------------------

loc_3307C:
		lea	Ani_33094,a1
		jsr	AnimateSprite
		jsr	AddToCollResponseList.w
		jmp	DrawSprite

Ani_33094:
		dc.w byte_33098-Ani_33094
		dc.w byte_3309B-Ani_33094

byte_33098:
		dc.b   $F,   0,	$FF

byte_3309B:
		dc.b	3,   1,	  0,   1, $FD,	 0,   0

Map_Bumper:
		incbin 'levels/common/bumper/Map.bin'
