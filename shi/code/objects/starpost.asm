Obj_StarPost:
		moveq	#0,d0
		move.b	5(a0),d0
		move.w	off_2CFB6(pc,d0.w),d1
		jmp	off_2CFB6(pc,d1.w)


; ---------------------------------------------------------------------------

off_2CFB6:
		dc.w loc_2CFC0-off_2CFB6
		dc.w loc_2D012-off_2CFB6
		dc.w loc_2D0F8-off_2CFB6
		dc.w loc_2D10A-off_2CFB6
		dc.w loc_2D47E-off_2CFB6

loc_2CFC0:
		addq.b	#2,5(a0)
		move.l	#Map_StarPost,$C(a0)
		move.w	#$5EC,$A(a0)
		move.b	#4,4(a0)
		move.b	#8,7(a0)
		move.b	#$28,6(a0)
		move.w	#$280,8(a0)
		movea.w	$48(a0),a2
		btst	#0,(a2)
		bne.s	loc_2D008
		move.b	Last_Starpole_Hit.w,d1
		andi.b	#$7F,d1
		move.b	$2C(a0),d2
		andi.b	#$7F,d2
		cmp.b	d2,d1
		blo.s	loc_2D012

loc_2D008:
		bset	#0,(a2)
		move.b	#2,$20(a0)


; ############### S U B	R O U T	I N E #######################################

loc_2D012:
		tst.w	Debug_Routine.w
		bne.w	loc_2D0F8
		lea	Object_RAM.w,a3
		move.b	Last_Starpole_Hit.w,d1
		bsr.s	sub_2D028
		bra.w	loc_2D0F8

sub_2D028:
		andi.b	#$7F,d1
		move.b	$2C(a0),d2
		andi.b	#$7F,d2
		cmp.b	d2,d1
		bhs.w	loc_2D0EA
		move.w	$10(a3),d0
		sub.w	$10(a0),d0
		addi.w	#8,d0
		cmpi.w	#$10,d0
		bhs.w	locret_2D0E8
		move.w	$14(a3),d0
		sub.w	$14(a0),d0
		addi.w	#$40,d0
		cmpi.w	#$68,d0
		bhs.w	locret_2D0E8
		moveq	#$63,d0
		jsr	PlaySFX
		jsr	CreateObject
		bne.s	loc_2D0D0
		move.l	#('O'<<24)|Obj_StarPost,(a1)
		move.b	#6,5(a1)
		move.w	$10(a0),$30(a1)
		move.w	$14(a0),$32(a1)
		subi.w	#$14,$32(a1)
		move.l	$C(a0),$C(a1)
		move.w	$A(a0),$A(a1)
		move.b	#4,4(a1)
		move.b	#8,7(a1)
		move.b	#8,6(a1)
		move.w	#$200,8(a1)
		move.b	#2,$22(a1)
		move.w	#$20,$36(a1)
		move.w	a0,parent(a1)

loc_2D0D0:
		move.b	#1,$20(a0)
		bsr.w	sub_2D164
		move.b	#4,5(a0)
		movea.w	$48(a0),a2
		bset	#0,(a2)


; ---------------------------------------------------------------------------

locret_2D0E8:
		rts

loc_2D0EA:
		tst.b	$20(a0)
		bne.s	locret_2D0F6
		move.b	#2,$20(a0)


; End of function sub_2D028
; ---------------------------------------------------------------------------

locret_2D0F6:
		rts


; ---------------------------------------------------------------------------

loc_2D0F8:
		lea	Ani_2D338,a1
		jsr	AnimateSprite
		jmp	ChkDispObjLoaded

loc_2D10A:
		subq.w	#1,$36(a0)
		bpl.s	loc_2D12E
		movea.w	parent(a0),a1
		move.l	(a0),d0
		cmp.l	(a1),d0
		bne.s	loc_2D128
		move.b	#2,$20(a1)
		sf	$22(a1)


; ---------------------------------------------------------------------------

loc_2D128:
		jmp	DeleteObject_This


; ############### S U B	R O U T	I N E #######################################

loc_2D12E:
		move.b	$26(a0),d0
		subi.b	#$10,$26(a0)
		subi.b	#$40,d0
		jsr	GetSine
		muls.w	#$C00,d1
		swap	d1
		add.w	$30(a0),d1
		move.w	d1,$10(a0)
		muls.w	#$C00,d0
		swap	d0
		add.w	$32(a0),d0
		move.w	d0,$14(a0)
		jmp	ChkDispObjLoaded


; End of function sub_2D164
; ############### S U B	R O U T	I N E #######################################

sub_2D164:
		move.b	subtype(a0),Last_Starpole_Hit.w
		move.w	xpos(a0),Saved_Starpole_X_Pos.w
		move.w	ypos(a0),Saved_Starpole_Y_Pos.w


; End of function sub_2D176
; ############### S U B	R O U T	I N E #######################################

sub_2D176:
		move.b	Last_Starpole_Hit.w,Saved_Last_Starpole_Hit.w
		move.w	Object_RAM+topsolid.w,Saved_Player_Layer.w
		move.w	Ring_Count.w,Saved_Ring_Count.w
		move.w	Dynamic_Resize_Routine.w,Saved_Dynamic_Resize_Routine.w
		move.w	Camera_LockOff.w,Saved_Camera_LockOff.w
		move.l	Camera_min_X.w,Saved_Current_Min_X_Pos.w
		move.l	Camera_min_Y.w,Saved_Current_Min_Y_Pos.w
		move.w	Camera_X.w,Saved_Camera_X_Pos.w
		move.w	Camera_Y.w,Saved_Camera_Y_Pos.w
		move.l	Obj_player_2.w,Saved_Obj_Tails.w
		rts

; ---------------------------------------------------------------------------

Load_Starpost_Settings:
		move.b	Saved_Last_Starpole_Hit.w,Last_Starpole_Hit.w; get last starpole ID
		move.w	Saved_Starpole_X_Pos.w,Object_RAM+xpos.w; get the player x-pos
		move.w	Saved_Starpole_Y_Pos.w,Object_RAM+ypos.w; and y-pos
		move.l	Saved_Current_Min_X_Pos.w,Camera_min_X.w
		move.l	Saved_Current_Min_Y_Pos.w,Camera_min_Y.w
		move.l	Saved_Current_Min_X_Pos.w,Camera_target_min_X.w
		move.l	Saved_Current_Min_Y_Pos.w,Camera_target_min_Y.w
		move.w	Saved_Ring_Count.w,Ring_Count.w

		move.w	Saved_Player_Layer.w,Object_RAM+topsolid.w	; get current layer
		move.w	Saved_Dynamic_Resize_Routine.w,Dynamic_Resize_Routine.w; get dynamic resize routine
		move.w	Saved_Camera_LockOff.w,Camera_LockOff.w
		move.w	Saved_Camera_X_Pos.w,Camera_X.w			; get camera positions
		move.w	Saved_Camera_Y_Pos.w,Camera_Y.w			;
		rts
; ---------------------------------------------------------------------------
loc_2D47E:
		move.b	$29(a0),d0
		beq.w	loc_2D50A
		andi.b	#1,d0
		beq.s	loc_2D506
		move.w	#$1500,d1
		move.w	Saved_Ring_Count.w,d0
		subi.w	#$14,d0
		divu.w	#$F,d0
		ext.l	d0
		moveq	#2,d2

		divu.w	d2,d0
		swap	d0
		tst.w	d0
		beq.s	loc_2D4CA
		move.w	#$1400,d1

loc_2D4CA:
		move.w	Ring_Count.w,Saved_Ring_Count.w
		move.b	#0,Last_Starpole_Hit.w
		move.b	#1,Level_Restart_Flag.w
		move.b	Object_RAM+shistatus.w,d0
		andi.b	#$71,d0
		jsr	loc_1BB7E

loc_2D506:
		clr.b	$29(a0)

loc_2D50A:
		addi.w	#$A,$34(a0)
		move.w	$34(a0),d0
		andi.w	#$FF,d0
		jsr	GetSine
		asr.w	#5,d0
		asr.w	#3,d1
		move.w	d1,d3
		move.w	$34(a0),d2
		andi.w	#$3E0,d2
		lsr.w	#5,d2
		moveq	#2,d5
		moveq	#0,d4
		cmpi.w	#$10,d2
		ble.s	loc_2D53A
		neg.w	d1

loc_2D53A:
		andi.w	#$F,d2
		cmpi.w	#8,d2
		ble.s	loc_2D54A
		neg.w	d2
		andi.w	#7,d2

loc_2D54A:
		lsr.w	#1,d2
		beq.s	loc_2D550
		add.w	d1,d4

loc_2D550:
		asl.w	#1,d1
		dbf	d5,loc_2D54A
		asr.w	#4,d4
		add.w	d4,d0
		addq.w	#1,$36(a0)
		move.w	$36(a0),d1
		cmpi.w	#$80,d1
		beq.s	loc_2D574
		bgt.s	loc_2D57A


; ---------------------------------------------------------------------------

loc_2D56A:
		muls.w	d1,d0
		muls.w	d1,d3
		asr.w	#7,d0
		asr.w	#7,d3
		bra.s	loc_2D58C

loc_2D574:
		move.b	#$C0|2,$28(a0)


; ---------------------------------------------------------------------------

loc_2D57A:
		cmpi.w	#$180,d1
		ble.s	loc_2D58C
		neg.w	d1
		addi.w	#$200,d1
		bmi.w	loc_2D5C0
		bra.s	loc_2D56A

loc_2D58C:
		move.w	$30(a0),d2
		add.w	d3,d2
		move.w	d2,$10(a0)
		move.w	$32(a0),d2
		add.w	d0,d2
		move.w	d2,$14(a0)
		addq.b	#1,$23(a0)
		move.b	$23(a0),d0
		andi.w	#6,d0
		lsr.w	#1,d0
		cmpi.b	#3,d0
		bne.s	loc_2D5B6
		moveq	#1,d0


; ---------------------------------------------------------------------------

loc_2D5B6:
		move.b	d0,$22(a0)
		jmp	DispCollObjLoaded


; ---------------------------------------------------------------------------

loc_2D5C0:
		jmp	DeleteObject_This


Ani_2D338:
		dc.w byte_2D33E-Ani_2D338
		dc.w byte_2D341-Ani_2D338
		dc.w byte_2D344-Ani_2D338

byte_2D33E:
		dc.b   $F,   0,	$FF

byte_2D341:
		dc.b   $F,   1,	$FF

byte_2D344:
		dc.b	3,   0,	  4, $FF

Map_StarPost:	include "levels\common\Starpost\map.asm"

Map_2D3AA:
		dc.w word_2D3B0-Map_2D3AA

Map_2D3AC:
		dc.w word_2D3B8-Map_2D3AA
		dc.w word_2D3C0-Map_2D3AA

word_2D3B0:
		dc.w 1
		dc.b  $F8,   5,	  0,   0, $FF, $F8

word_2D3B8:
		dc.w 1
		dc.b  $FC,   0,	  0,   4, $FF, $FC


; ############### S U B	R O U T	I N E #######################################

word_2D3C0:
		dc.w 1
		dc.b  $FC,   0,	  0,   5, $FF, $FC
