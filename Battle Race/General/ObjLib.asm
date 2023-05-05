Obj_WaitOffscreen:
		clr.l	$C(a0)
		bset	#2,4(a0)
		move.b	#$20,7(a0)
		move.b	#$20,6(a0)
		move.w	#prio(0),priority(a0)
		move.l	(sp)+,$34(a0)
		move.l	#loc_85AD2,(a0)

loc_85AD2:
		tst.b	4(a0)
		bmi.s	loc_85B02
		move.w	$10(a0),d0
		andi.w	#-$80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Sprite_ChkRespawn
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

loc_85B02:
		move.l	$34(a0),(a0)			; Restore normal object operation when onscreen
		rts
; ---------------------------------------------------------------------------

Refresh_ChildPosWait:
		jsr	Refresh_ChildPosition.w

Wait_Draw:
		bsr.s	Obj_Wait
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Obj_Wait:
		subq.w	#1,$2E(a0)
		bpl.s	CheckRightMusicTrack.rts
		movea.l	$34(a0),a1
		jmp	(a1)
; ---------------------------------------------------------------------------

CheckRightMusicTrack:
		tst.b	(Boss_flag).w			; NAT: Check if boss is active
		bne.s	.rts				; if is, ignore all music
		tst.b	(End_Of_Level_Flag).w			; check if level end is active
		beq.s	CheckRightMusicTrack2		; if so, blah
.rts		rts
; ---------------------------------------------------------------------------

Obj_PlayLevelMusic:
		moveq	#0,d0
		lea	(Apparent_zone_and_act).w,a1
		move.b	(a1)+,d0
		add.b	d0,d0
		add.b	(a1),d0
		lea	(LevelMusic_Playlist).l,a2
		move.b	(a2,d0.w),d0
		move.w	d0,(Level_music).w
; ---------------------------------------------------------------------------

CheckRightMusicTrack2:
		movem.l	a2/a3,-(sp)
		lea	Player_1.w,a2
		lea	Player_2.w,a3

		moveq	#0,d0				; no speed shoes
		moveq	#Mus_Drown,d1			; drowning theme
		cmp.b	#6,5(a2)			; check if ded
		bhi.s	.ded1				; if so, branch
		cmp.b	#$C,air_left(a2)		; check if drowning
		ble.s	.playmus			; if so, play music

.ded1		cmp.b	#6,5(a3)			; check if ded
		bhi.s	.ded2				; if so, branch
		cmp.b	#$C,air_left(a3)		; check if drowning
		ble.s	.playmus			; if so, play music

.ded2		tst.b	speed_shoes_timer(a2)		; check speed shoes
		bne.s	.sson				; if is active, branch
		tst.b	speed_shoes_timer(a3)		; check speed shoes
		beq.s	.ssno				; if is not active, branch

.sson		moveq	#8,d0				; yes speed shoes
.ssno		moveq	#Mus_Invic,d1			; SK music
		cmp.b	#7,Current_Zone.w		; >=MHZ
		bge.s	.skin
		cmp.b	#4,Current_Zone.w		; ==FBZ
		beq.s	.skin
		moveq	#Mus_InvicS3,d1			; S3 music

.skin		tst.b	invincibility_timer(a2)		; check invin time
		bne.s	.playmus			; if yes, branch
		tst.b	invincibility_timer(a3)		; check invin time
		bne.s	.playmus			; if yes, branch
		move.w	Level_music.w,d1		; get level music

.playmus	movem.l	(sp)+,a2/a3
		jsr	Change_Music_Tempo.w		; update music tempo

		cmp.b	Level_music.w,d1		; use high byte because
		beq.s	CopyWordData_2.rts		; low byte is used by actual level music
		move.b	d1,Level_music.w		; set the new music
		move.w	d1,d0				; copy music from d1 to d0 (for play_sound)
		jmp	Play_Sound.w

; ---------------------------------------------------------------------------
Child6_IncLevX:	dc.w 0
		dc.l Obj_IncLevEndXGradual
Child6_DecLevX:	dc.w 0
		dc.l Obj_DecLevStartXGradual
Child6_DecLevY:	dc.w 0
		dc.l Obj_DecLevStartYGradual
Child6_IncLevY:	dc.w 0
		dc.l Obj_IncLevEndYGradual
; ---------------------------------------------------------------------------
Child6_CreateBossExplosion:
		dc.w 0
		dc.l Obj_CreateBossExplosion
		dc.w 0
PLC_83D64:	dc.w 0
		dc.l ArtNem_BossExplosion
		dc.w $A000
Pal_CutsceneKnux1:	binclude "General/Sprites/Knuckles/Cutscene/Pal.bin"
			even
; ---------------------------------------------------------------------------

CopyWordData_7:
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
; ---------------------------------------------------------------------------

CopyWordData_6:
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
; ---------------------------------------------------------------------------

CopyWordData_5:
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
; ---------------------------------------------------------------------------

CopyWordData_4:
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
; ---------------------------------------------------------------------------

CopyWordData_3:
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
; ---------------------------------------------------------------------------

CopyWordData_2:
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
		movea.w	(a1)+,a3
		move.w	(a2)+,(a3)+
.rts		rts
; ---------------------------------------------------------------------------

Sprite_OnScreen_Test:
		move.w	$10(a0),d0

Sprite_OnScreen_Test2:
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Sprite_ChkRespawn
		bra.w	Draw_Sprite
; ---------------------------------------------------------------------------

Delete_Sprite_If_Not_In_Range:
		move.w	$10(a0),d0
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	Sprite_ChkRespawn
		rts
; ---------------------------------------------------------------------------

Sprite_ChkRespawn:
		move.w	respawn_addr(a0),d0
		beq.s	Delete_Current_Sprite
		movea.w	d0,a2
		bclr	#7,(a2)
; ---------------------------------------------------------------------------

Delete_Current_Sprite:
		movea.l	a0,a1
; ---------------------------------------------------------------------------

Delete_Referenced_Sprite:
		moveq	#$11,d0
		moveq	#0,d1

loc_1ABBC:
		move.l	d1,(a1)+
		dbf	d0,loc_1ABBC
		move.w	d1,(a1)+
		rts
; ---------------------------------------------------------------------------

loc_1B662:
		move.w	$10(a0),d0

loc_1B666:
		andi.w	#$FF80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	Sprite_ChkRespawn
		bsr.s	Add_SpriteToCollisionResponseList
		bra.s	Draw_Sprite
; ---------------------------------------------------------------------------

Check_AddToCollisionList:
		tst.b	$28(a0)				; NAT: If obj has no collision, do not collide
		beq.s	Add_SpriteToCollisionResponseList.locret
; ---------------------------------------------------------------------------

Add_SpriteToCollisionResponseList:
		lea	(Collision_response_list).w,a1
		cmpi.w	#$7E,(a1)			; Is list full?
		bhs.s	.locret				; If so, return
		addq.w	#2,(a1)				; Count this new entry
		adda.w	(a1),a1				; Offset into right area of list
		move.w	a0,(a1)				; Store RAM address in list
.locret		rts
; ---------------------------------------------------------------------------

Draw_And_Touch_Sprite:
		bsr.s	Add_SpriteToCollisionResponseList
; ---------------------------------------------------------------------------

Draw_Sprite:
		move.w	8(a0),a1		; NAT: Optimization
		cmp.w	#Sprite_table_input,a1
		bhs.s	loc_1ABCE
		jmp	ERROR_InvalidPriorityPtr.l

loc_1ABCE:
		cmpi.w	#prlayersize-2,(a1)
		bhs.s	loc_1ABDC
		addq.w	#2,(a1)
		adda.w	(a1),a1
		move.w	a0,(a1)

locret_1ABDA:
		rts
; ---------------------------------------------------------------------------

loc_1ABDC:
		cmpa.w	#Sprite_table_input+(7*prlayersize),a1
		beq.s	locret_1ABDA
		adda.w	#prlayersize,a1
		bra.s	loc_1ABCE
; ---------------------------------------------------------------------------

Child_Draw_Sprite:
		movea.w	$46(a0),a1
		btst	#7,$2A(a1)
		bne.s	Go_Delete_Sprite
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Child_DrawTouch_Sprite:
		movea.w	$46(a0),a1
		btst	#7,$2A(a1)
		bne.s	Go_Delete_Sprite
		bsr.w	Add_SpriteToCollisionResponseList
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Child_CheckParent:
		movea.w	$46(a0),a1
		btst	#7,$2A(a1)
		bne.w	Go_Delete_Sprite
		rts
; ---------------------------------------------------------------------------

Child_AddToTouchList:
		movea.w	$46(a0),a1
		btst	#7,$2A(a1)
		bne.s	Go_Delete_Sprite
		bra.w	Add_SpriteToCollisionResponseList
; ---------------------------------------------------------------------------

Child_Remember_Draw_Sprite:
		movea.w	$46(a0),a1
		btst	#7,$2A(a1)
		bne.s	loc_84984
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

loc_84984:
		bsr.s	Remove_From_TrackingSlot
; ---------------------------------------------------------------------------

Go_Delete_Sprite_3:
		bset	#4,$38(a0)
; ---------------------------------------------------------------------------

Go_Delete_Sprite:
		move.l	#Delete_Current_Sprite,(a0)
		bset	#7,$2A(a0)
		rts
; ---------------------------------------------------------------------------

Child_Draw_Sprite2:
		movea.w	$46(a0),a1
		btst	#4,$38(a1)
		bne.s	Go_Delete_Sprite_2
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Child_DrawTouch_Sprite2:
		movea.w	$46(a0),a1
		btst	#4,$38(a1)
		bne.s	Go_Delete_Sprite_2
		btst	#7,$2A(a1)
		bne.w	Draw_Sprite
		bsr.w	Add_SpriteToCollisionResponseList
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Go_Delete_Sprite_2:
		move.l	#Delete_Current_Sprite,(a0)
		bset	#4,$38(a0)
		rts
; ---------------------------------------------------------------------------

Sprite_CheckDeleteSlotted:
		move.w	$10(a0),d0
		andi.w	#-$80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		blo.w	Draw_Sprite
; ---------------------------------------------------------------------------

Go_Delete_SpriteSlotted:
		move.w	respawn_addr(a0),d0
		beq.s	Go_Delete_SpriteSlotted2
		movea.w	d0,a2
		bclr	#7,(a2)

Go_Delete_SpriteSlotted2:
		move.l	#Delete_Current_Sprite,(a0)
		bset	#7,$2A(a0)
; ---------------------------------------------------------------------------

Remove_From_TrackingSlot:
		move.b	$3B(a0),d0
		movea.w	$3C(a0),a1
		bclr	d0,(a1)
		rts
; ---------------------------------------------------------------------------

Go_Delete_SpriteSlotted3:
		move.l	#Delete_Current_Sprite,(a0)
		bra.s	Remove_From_TrackingSlot
; ---------------------------------------------------------------------------

Sprite_CheckDeleteTouchSlotted:
		tst.b	$2A(a0)
		bmi.s	Go_Delete_SpriteSlotted3
		move.w	$10(a0),d0
		andi.w	#-$80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	Go_Delete_SpriteSlotted
		bsr.w	Add_SpriteToCollisionResponseList
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Sprite_CheckDelete:
		move.w	$10(a0),d0
		andi.w	#-$80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	loc_85088
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

loc_85088:
		move.w	respawn_addr(a0),d0
		beq.s	loc_85094
		movea.w	d0,a2
		bclr	#7,(a2)

loc_85094:
		bset	#7,$2A(a0)
		move.l	#Delete_Current_Sprite,(a0)
		rts
; ---------------------------------------------------------------------------

Sprite_CheckDelete2:
		move.w	$10(a0),d0
		andi.w	#-$80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.s	loc_850BA
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

loc_850BA:
		move.w	respawn_addr(a0),d0
		beq.s	loc_850C6
		movea.w	d0,a2
		bclr	#7,(a2)

loc_850C6:
		bset	#4,$38(a0)
		move.l	#Delete_Current_Sprite,(a0)
		rts
; ---------------------------------------------------------------------------

Sprite_CheckDeleteXY:
		move.w	$10(a0),d0
		andi.w	#-$80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Go_Delete_Sprite
		move.w	$14(a0),d0
		sub.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		cmpi.w	#$200,d0
		bhi.w	Go_Delete_Sprite
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Sprite_CheckDeleteTouchXY:
		move.w	$10(a0),d0
		andi.w	#-$80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Go_Delete_Sprite
		move.w	$14(a0),d0
		sub.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		cmpi.w	#$200,d0
		bhi.w	Go_Delete_Sprite
		bsr.w	Add_SpriteToCollisionResponseList
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Obj_FlickerMove:
		jsr	MoveSprite.w
		move.w	$10(a0),d0
		andi.w	#-$80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	Go_Delete_Sprite_3
		move.w	$14(a0),d0
		sub.w	(Camera_Y_pos).w,d0
		addi.w	#$80,d0
		cmpi.w	#$200,d0
		bhi.w	Go_Delete_Sprite_3
		bchg	#6,$38(a0)
		beq.w	locret_8506E
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Sprite_CheckDeleteTouch:
		move.w	$10(a0),d0
		andi.w	#-$80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_85088
		bsr.w	Add_SpriteToCollisionResponseList
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Sprite_CheckDeleteTouch2:
		move.w	$10(a0),d0
		andi.w	#-$80,d0
		sub.w	(Camera_X_pos_coarse_back).w,d0
		cmpi.w	#$280,d0
		bhi.w	loc_850BA
		bsr.w	Add_SpriteToCollisionResponseList
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Check_PlayerInRange:
		moveq	#0,d0
		lea	(Player_2).w,a2
		move.w	$10(a2),d1
		move.w	$14(a2),d2
		move.w	$10(a0),d3
		move.w	$14(a0),d4
		add.w	(a1)+,d3
		move.w	d3,d5
		add.w	(a1)+,d5
		add.w	(a1)+,d4
		move.w	d4,d6
		add.w	(a1)+,d6
		bsr.s	sub_8592C
		swap	d0
		lea	(Player_1).w,a2
		move.w	$10(a2),d1
		move.w	$14(a2),d2
; ---------------------------------------------------------------------------

sub_8592C:
		cmp.w	d3,d1
		blo.s	locret_8593E
		cmp.w	d5,d1
		bhs.s	locret_8593E
		cmp.w	d4,d2
		blo.s	locret_8593E
		cmp.w	d6,d2
		bhs.s	locret_8593E
		move.w	a2,d0

locret_8593E:
		rts
; ---------------------------------------------------------------------------

Displace_PlayerOffObject:
		move.b	$2A(a0),d0
		andi.b	#$18,d0
		beq.s	locret_85988
		bclr	#3,$2A(a0)
		beq.s	loc_85970
		lea	(Player_1).w,a1
		bclr	#3,$2A(a1)
		bset	#1,$2A(a1)

loc_85970:
		bclr	#4,$2A(a0)
		beq.s	locret_85988
		lea	(Player_2).w,a1
		bclr	#3,$2A(a1)
		bset	#1,$2A(a1)

locret_85988:
		rts
; ---------------------------------------------------------------------------

Run_PalRotationScript:
		tst.b	(Update_PalRotation_Flag).w
		bne.s	locret_85A00
		lea	(PalRotation_Data).w,a1

loc_85994:
		move.w	(a1),d0			; Palette displacement
		beq.s	locret_85A00
		subq.b	#1,2(a1)		; Rotation delay
		bpl.s	loc_859CA
		movea.l	4(a1),a2		; Address of palette copy array in a2
		movea.w	(a2),a3			; Palette destination in a3
		movea.l	a2,a4
		adda.w	d0,a4
		move.w	(a4),d1
		bpl.s	loc_859B0
		bsr.w	sub_859CE

loc_859B0:
		moveq	#0,d2
		move.b	2(a2),d2		; Number of colors to change

loc_859B6:
		move.w	(a4)+,(a3)+
		dbf	d2,loc_859B6
		move.w	(a4)+,d0
		move.b	d0,2(a1)
		move.l	a4,d0
		move.l	a2,d1
		sub.l	d1,d0
		move.w	d0,(a1)

loc_859CA:
		addq.w	#8,a1
		bra.s	loc_85994
; ---------------------------------------------------------------------------

sub_859CE:
		move.b	3(a2),d2

loc_859D2:
		beq.s	loc_859FC
		neg.w	d1
		jmp	loc_859D2(pc,d1.w)

; ---------------------------------------------------------------------------
		bra.w	loc_859E2
		bra.w	loc_85A02
; ---------------------------------------------------------------------------

loc_859E2:
		addq.b	#1,3(a1)		; Add one to counter
		cmp.b	3(a1),d2		; Compare with max counter
		bhi.s	loc_859FC
		move.w	2(a4),d2
		adda.w	d2,a2
		move.l	a2,4(a1)		; Load new script after counter has finished
		movea.w	(a2),a3
		clr.w	2(a1)

loc_859FC:
		movea.l	a2,a4			; Start from the beginning of the rotation
		addq.l	#4,a4

locret_85A00:
		rts
; ---------------------------------------------------------------------------

loc_85A02:
		addq.b	#1,3(a1)
		cmp.b	3(a1),d2
		bhi.s	loc_859FC		; Wait for counter to finish
		movea.l	(__u_FADA).w,a2
		move.l	a1,-(sp)
		jsr	(a2)				; Run custom routine
		movea.l	(sp)+,a1
		addq.w	#4,sp
		bra.s	loc_859CA
; ---------------------------------------------------------------------------

PalLoad_Line1tgt:
		lea	(Target_palette_line_2).w,a2
		bra.s	PalLoad_Line1.s

PalLoad_Line1:
		lea	(Normal_palette_line_2).w,a2
.s		moveq	#7,d0

loc_85946:
		move.l	(a1)+,(a2)+
		dbf	d0,loc_85946
		rts
; ---------------------------------------------------------------------------

HurtCharacter_Directly:
		movea.l	a0,a2
		movea.l	a1,a0
		jsr	(HurtCharacter).l
		movea.l	a2,a0
		rts
; ---------------------------------------------------------------------------

MoveWaitTouch:	; MoveWaitTouch
		bsr.s	MoveSprite2
		jsr	Obj_Wait.w
		jmp	Draw_And_Touch_Sprite.w
; ---------------------------------------------------------------------------

Swing_MoveWaitNoFall:
		jsr	Swing_UpAndDown.w
		bsr.s	MoveSprite2
		jmp	Obj_Wait.w
; ---------------------------------------------------------------------------

Move_WaitNoFall:
		pea	Obj_Wait.w
; ---------------------------------------------------------------------------
; Subroutine translating object speed to update object position
; This moves the object horizontally and vertically
; but does not apply gravity to it
; ---------------------------------------------------------------------------

MoveSprite2:
		move.w	x_vel(a0),d0	; load horizontal speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,x_pos(a0)	; add to x-axis position	; note this affects the subpixel position x_sub(a0) = 2+x_pos(a0)
		move.w	y_vel(a0),d0	; load vertical speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,y_pos(a0)	; add to y-axis position	; note this affects the subpixel position y_sub(a0) = 2+y_pos(a0)
		rts
; ---------------------------------------------------------------------------

MoveSprite_TestGravity2:
		tst.b	(Reverse_gravity_flag).w
		beq.s	MoveSprite2

;MoveSprite_ReverseGravity2:
		move.w	x_vel(a0),d0	; load horizontal speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,x_pos(a0)	; add to x-axis position	; note this affects the subpixel position x_sub(a0) = 2+x_pos(a0)
		move.w	y_vel(a0),d0	; load vertical speed
		neg.w	d0		; reverse it
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,y_pos(a0)	; add to y-axis position	; note this affects the subpixel position y_sub(a0) = 2+y_pos(a0)
		rts
; ---------------------------------------------------------------------------

AnimateRaw_DrawTouch:
		jsr	Animate_RawMultiDelay.w
		jmp	Draw_And_Touch_Sprite.w
; ---------------------------------------------------------------------------

AnimateRaw_MoveChkDel:
		jsr	Animate_Raw.w

MoveChkDel:
		bsr.s	MoveSprite
		jmp	Sprite_CheckDeleteXY.w
; ---------------------------------------------------------------------------

MoveTouchChkDel:
		pea	Sprite_CheckDeleteTouchXY.w
; ---------------------------------------------------------------------------
; Subroutine to make an object move and fall downward increasingly fast
; This moves the object horizontally and vertically
; and also applies gravity to its speed
; ---------------------------------------------------------------------------

MoveSprite:
		move.w	x_vel(a0),d0	; load x speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,x_pos(a0)	; add x speed to x position	; note this affects the subpixel position x_sub(a0) = 2+x_pos(a0)
		move.w	y_vel(a0),d0	; load y speed
		addi.w	#$38,y_vel(a0)	; increase vertical speed (apply gravity)
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,y_pos(a0)	; add old y speed to y position	; note this affects the subpixel position y_sub(a0) = 2+y_pos(a0)
		rts
; ---------------------------------------------------------------------------

MoveSprite_TestGravity:
		tst.b	(Reverse_gravity_flag).w
		beq.s	MoveSprite

;MoveSprite_ReverseGravity:
		move.w	x_vel(a0),d0	; load x speed
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,x_pos(a0)	; add x speed to x position	; note this affects the subpixel position x_sub(a0) = 2+x_pos(a0)
		move.w	y_vel(a0),d0	; load y speed
		addi.w	#$38,y_vel(a0)	; increase vertical speed (apply gravity)
		neg.w	d0		; reverse it
		ext.l	d0
		lsl.l	#8,d0		; shift velocity to line up with the middle 16 bits of the 32-bit position
		add.l	d0,y_pos(a0)	; add old y speed to y position	; note this affects the subpixel position y_sub(a0) = 2+y_pos(a0)
		rts
; ---------------------------------------------------------------------------

SetUp_ObjAttributesSlotted:
		moveq	#0,d0
		move.w	(a1)+,d1		; Maximum number of objects that can be made in this array
		move.w	d1,d2
		move.w	(a1)+,d3		; Base VRAM offset of object
		move.w	(a1)+,d4		; Amount to add to base VRAM offset for each slot
		moveq	#0,d5
		move.w	(a1)+,d5		; Index of slot array to use
		lea	(__u_FA9A).w,a2
		adda.w	d5,a2			; Get the address of the array to use
		move.b	(a2),d5
		beq.s	loc_84FE4		; If array is clear, just make the object

loc_84FBC:
		lsr.b	#1,d5			; Check slot (each bit)
		bcc.s	loc_84FE4		; If clear, make object
		addq.w	#1,d0			; Increment bit number
		add.w	d4,d3			; Add VRAM offset
		dbf	d1,loc_84FBC		; Repeat max times
		moveq	#0,d0
		move.l	d0,(a0)
		move.l	d0,$10(a0)
		move.l	d0,$14(a0)
		move.b	d0,$2C(a0)
		move.b	d0,4(a0)
		move.w	d0,$2A(a0)		; If no open slots, then destroy this object period
		addq.w	#8,sp
		rts
; ---------------------------------------------------------------------------

loc_84FE4:
		bset	d0,(a2)			; Turn this slot on
		move.b	d0,$3B(a0)
		move.w	a2,$3C(a0)		; Keep track of slot address and bit number
		move.w	d3,$A(a0)		; Use correct VRAM offset
		move.l	(a1)+,$C(a0)	; Mapping address
		move.w	(a1)+,8(a0)		; Priority
		move.b	(a1)+,7(a0)		; Width
		move.b	(a1)+,6(a0)		; Height
		move.b	(a1)+,$22(a0)	; Frame number
		move.b	(a1)+,$28(a0)	; Collision number
		bset	#2,$2A(a0)		; Turn object slotting on
		move.b	#-1,$3A(a0)		; CHECKLATER
		bset	#2,4(a0)		; Use screen coordinates
		addq.b	#2,5(a0)		; Next routine
		rts
; ---------------------------------------------------------------------------

Set_IndexedVelocity:
		moveq	#0,d1
		move.b	$2C(a0),d1
		add.w	d1,d1
		add.w	d1,d0
		lea	Obj_VelocityIndex(pc,d0.w),a1
		move.w	(a1)+,$18(a0)
		move.w	(a1)+,$1A(a0)
		btst	#0,4(a0)
		beq.s	locret_852F2
		neg.w	$18(a0)

locret_852F2:
		rts

; ---------------------------------------------------------------------------
Obj_VelocityIndex:dc.w  $FF00, $FF00
		dc.w   $100, $FF00
		dc.w  $FE00, $FE00
		dc.w   $200, $FE00
		dc.w  $FD00, $FE00
		dc.w   $300, $FE00
		dc.w  $FE00, $FE00
		dc.w	  0, $FE00
		dc.w  $FC00, $FD00
		dc.w   $400, $FD00
		dc.w   $300, $FD00
		dc.w  $FC00, $FD00
		dc.w   $400, $FD00
		dc.w  $FE00, $FE00
		dc.w   $200, $FE00
		dc.w	  0, $FF00
		dc.w  $FFC0, $F900
		dc.w  $FF80, $F900
		dc.w  $FE80, $F900
		dc.w  $FF00, $F900
		dc.w  $FE00, $F900
		dc.w  $FD80, $F900
		dc.w  $FD00, $F900
		dc.w	  0, $FF00
		dc.w  $FF00, $FF00
		dc.w   $100, $FF00
		dc.w  $FE00, $FF00
		dc.w   $200, $FF00
		dc.w  $FE00, $FE00
		dc.w   $200, $FE00
		dc.w  $FD00, $FE00
		dc.w   $300, $FE00
		dc.w  $FD00, $FD00
		dc.w   $300, $FD00
		dc.w  $FC00, $FD00
		dc.w   $400, $FD00
		dc.w  $FE00, $FD00
		dc.w   $200, $FD00
; ---------------------------------------------------------------------------

MoveSprite_AtAngleLookup:
		moveq	#0,d0
		move.b	$3C(a0),d0
		move.w	d0,d1
		andi.w	#$3F,d0
		lsr.w	#5,d1
		andi.w	#6,d1
		movea.w	$46(a0),a1
		lea	$40(a2),a3
		move.w	$10(a1),d2
		move.w	$14(a1),d3
		move.w	d0,d4
		not.w	d4
		move.w	AtAngle_LookupIndex(pc,d1.w),d1
		jsr	AtAngle_LookupIndex(pc,d1.w)
		add.w	d5,d2
		add.w	d6,d3
		move.w	d2,$10(a0)
		move.w	d3,$14(a0)
		rts

; ---------------------------------------------------------------------------
AtAngle_LookupIndex:	dc.w AtAngle_00_3F-AtAngle_LookupIndex
		dc.w AtAngle_40_7F-AtAngle_LookupIndex
		dc.w AtAngle_80_BF-AtAngle_LookupIndex
		dc.w AtAngle_C0_FF-AtAngle_LookupIndex
; ---------------------------------------------------------------------------

AtAngle_00_3F:
		moveq	#0,d5
		move.b	(a2,d0.w),d5
		moveq	#0,d6
		move.b	(a3,d4.w),d6
		rts
; ---------------------------------------------------------------------------

AtAngle_40_7F:
		moveq	#0,d5
		move.b	(a3,d4.w),d5
		moveq	#0,d6
		move.b	(a2,d0.w),d6
		neg.w	d6
		rts
; ---------------------------------------------------------------------------

AtAngle_80_BF:
		moveq	#0,d5
		move.b	(a2,d0.w),d5
		neg.w	d5
		moveq	#0,d6
		move.b	(a3,d4.w),d6
		neg.w	d6
		rts
; ---------------------------------------------------------------------------

AtAngle_C0_FF:
		moveq	#0,d5
		move.b	(a3,d4.w),d5
		neg.w	d5
		moveq	#0,d6
		move.b	(a2,d0.w),d6
		rts
; ---------------------------------------------------------------------------

MoveSprite_CircularSimple:
		move.b	$3C(a0),d0
		jsr	GetSineCosine.w
		swap	d0
		clr.w	d0
		swap	d1
		clr.w	d1
		asr.l	d2,d0
		asr.l	d2,d1
		movea.w	$46(a0),a1
		move.l	$10(a1),d2
		move.l	$14(a1),d3
		add.l	d0,d2
		add.l	d1,d3
		move.l	d2,$10(a0)
		move.l	d3,$14(a0)
		rts
; ---------------------------------------------------------------------------

Set_VelocityXTrackSonic:
		lea	(Player_1).w,a1
		bsr.s	Find_OtherObject
		bclr	#0,4(a0)
		tst.w	d0
		beq.s	loc_85430
		neg.w	d4
		bset	#0,4(a0)

loc_85430:
		move.w	d4,$18(a0)
		rts
; ---------------------------------------------------------------------------

Find_OtherObject:
		moveq	#0,d0			; d0 = 0 if other object is left of calling object, 2 if right of it
		moveq	#0,d1			; d1 = 0 if other object is above calling object, 2 if below it
		move.w	$10(a0),d2
		sub.w	$10(a1),d2
		bpl.s	loc_84BAE
		neg.w	d2
		addq.w	#2,d0

loc_84BAE:
		moveq	#0,d1
		move.w	$14(a0),d3
		sub.w	$14(a1),d3
		bpl.s	locret_84BBE
		neg.w	d3
		addq.w	#2,d1

locret_84BBE:
		rts
; ---------------------------------------------------------------------------

MoveSprite_LightGravity:
		moveq	#$20,d1

MoveSprite_CustomGravity:
		move.w	$18(a0),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,$10(a0)
		move.w	$1A(a0),d0
		add.w	d1,$1A(a0)
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,$14(a0)
		rts
; ---------------------------------------------------------------------------

Change_FlipXWithVelocity:
		bclr	#0,4(a0)
		tst.w	$18(a0)
		bmi.s	locret_84B80
		bset	#0,4(a0)

locret_84B80:
		rts
; ---------------------------------------------------------------------------

Find_SonicTails:
		moveq	#0,d0			; d0 = 0 if Sonic/Tails is left of object, 2 if right of object
		moveq	#0,d1			; d1 = 0 if Sonic/Tails is above object, 2 if below object
		lea	(Player_1).w,a1
		move.w	$10(a0),d2
		sub.w	$10(a1),d2
		bpl.s	loc_84B2E
		neg.w	d2
		addq.w	#2,d0

loc_84B2E:
		lea	(Player_2).w,a2
		move.w	$10(a0),d3
		sub.w	$10(a2),d3
		bpl.s	loc_84B40
		neg.w	d3
		addq.w	#2,d1

loc_84B40:
		cmp.w	d3,d2
		bls.s	loc_84B4A
		movea.l	a2,a1
		move.w	d1,d0
		move.w	d3,d2

loc_84B4A:
		moveq	#0,d1
		move.w	$14(a0),d3
		sub.w	$14(a1),d3
		bpl.s	locret_84B5A
		neg.w	d3
		addq.w	#2,d1

locret_84B5A:
		rts
; ---------------------------------------------------------------------------

Find_SonicTails_2:
		moveq	#$80,d0			; d0 = 0 if Sonic/Tails is left of object, 2 if right of object
		lea	(Player_1).w,a1		; NAT: Some special shit because I can!
		btst	#5,$2A(a1)
		beq.s	loc2_84B2E
		bclr	#7,d0

		move.w	$10(a0),d2
		sub.w	$10(a1),d2
		bpl.s	loc2_84B2E
		neg.w	d2
		addq.w	#1,d0

loc2_84B2E:
		lea	(Player_2).w,a2
		btst	#5,$2A(a2)
		beq.s	loc2_84B40
		bclr	#7,d0

		move.w	$10(a0),d3
		sub.w	$10(a2),d3
		bpl.s	loc2_84B40
		neg.w	d3
		addq.w	#2,d0

loc2_84B40:
		cmp.w	d3,d2
		bls.s	loc2_84B4A
		movea.l	a2,a1
		move.w	d3,d2

loc2_84B4A:
		rts
; ---------------------------------------------------------------------------

Swing_Setup1:
		move.w	#$C0,d0
		move.w	d0,$3E(a0)
		move.w	d0,$1A(a0)
		move.w	#$10,$40(a0)
		bclr	#0,$38(a0)
		rts
; ---------------------------------------------------------------------------

Swing_UpAndDown_Count:
		bsr.s	Swing_UpAndDown
		tst.w	d3
		beq.s	locret_84888
		move.b	$39(a0),d2
		subq.b	#1,d2
		move.b	d2,$39(a0)
		bmi.s	loc_84886
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_84886:
		moveq	#1,d0

locret_84888:
		rts
; ---------------------------------------------------------------------------

Swing_UpAndDown:
		move.w	$40(a0),d0	; Acceleration
		move.w	$1A(a0),d1	; Velocity
		move.w	$3E(a0),d2	; Maximum acceleration before "swinging"
		moveq	#0,d3
		btst	#0,$38(a0)
		bne.s	loc_84812
		neg.w	d0		; Apply upward acceleration
		add.w	d0,d1
		neg.w	d2
		cmp.w	d2,d1
		bgt.s	loc_84824
		bset	#0,$38(a0)
		neg.w	d0
		neg.w	d2
		moveq	#1,d3

loc_84812:
		add.w	d0,d1		; Apply downward acceleration
		cmp.w	d2,d1
		blt.s	loc_84824
		bclr	#0,$38(a0)
		neg.w	d0
		add.w	d0,d1
		moveq	#1,d3

loc_84824:
		move.w	d1,$1A(a0)
		rts
; ---------------------------------------------------------------------------

Swing_LeftAndRight:
		move.w	$3C(a0),d0
		move.w	$18(a0),d1
		move.w	$3A(a0),d2
		moveq	#0,d3
		btst	#3,$38(a0)
		bne.s	loc_84856
		neg.w	d0
		add.w	d0,d1
		neg.w	d2
		cmp.w	d2,d1
		bgt.s	loc_84868
		bset	#3,$38(a0)
		neg.w	d0
		neg.w	d2
		moveq	#1,d3

loc_84856:
		add.w	d0,d1
		cmp.w	d2,d1
		blt.s	loc_84868
		bclr	#3,$38(a0)
		neg.w	d0
		add.w	d0,d1
		moveq	#1,d3

loc_84868:
		move.w	d1,$18(a0)
		rts
; ---------------------------------------------------------------------------

Gradual_SwingOffset:
		move.l	$2E(a0),d2
		tst.b	$36(a0)
		beq.s	loc_465F6
		neg.l	d1
		add.l	d2,$32(a0)		; Moving up and then down. Reset speed/direction when center point is reached going down
		bmi.s	loc_4660E
		move.l	d0,$2E(a0)		; Reset initial speed (positive) to move downwards
		clr.l	$32(a0)
		clr.b	$36(a0)
		bra.s	loc_46612
; ---------------------------------------------------------------------------

loc_465F6:
		add.l	d2,$32(a0)		; Moving down and then up. Reset speed/direction when center point is reached going up
		bmi.s	loc_465FE
		bne.s	loc_4660E

loc_465FE:
		neg.l	d0			; Reverse direction to move upwards when speed has reached

loc_46600:
		move.l	d0,$2E(a0)	; Reset initial speed (negative)

loc_46604:
		clr.l	$32(a0)
		st	$36(a0)
		bra.s	loc_46612
; ---------------------------------------------------------------------------

loc_4660E:
		sub.l	d1,$2E(a0)	; Apply speed

loc_46612:
		move.w	$32(a0),d0	; Get final offset for us by calling object
		rts
; ---------------------------------------------------------------------------

SetUp_ObjAttributes:
		move.l	(a1)+,$C(a0)			; Mappings location

SetUp_ObjAttributes2:
		move.w	(a1)+,$A(a0)			; VRAM offset

SetUp_ObjAttributes3:
		move.w	(a1)+,8(a0)			; Priority
		move.b	(a1)+,7(a0)			; Width
		move.b	(a1)+,6(a0)			; Height
		move.b	(a1)+,$22(a0)			; Mappings frame
		move.b	(a1)+,$28(a0)			; Collision Number
		bset	#2,4(a0)			; Object uses world coordinates
		addq.b	#2,5(a0)			; Increase routine counter

locret_8405E:	; sub_85E52
		rts
; ---------------------------------------------------------------------------

CreateChild1_Normal:
		moveq	#0,d2				; Includes positional offset data
		move.w	(a2)+,d6

loc_84064:
		jsr	Create_New_Sprite3.w
		bne.s	locret_840AE
		move.w	a0,$46(a1)			; Parent RAM address into $46
		move.l	$C(a0),$C(a1)
		move.w	$A(a0),$A(a1)			; Mappings and VRAM offset copied from parent object
		move.l	(a2)+,(a1)			; Object address
		move.b	d2,$2C(a1)			; Index of child object (done sequentially for each object)
		move.w	$10(a0),d0
		move.b	(a2)+,d1			; X Positional offset
		move.b	d1,$42(a1)			; $42 has the X offset
		ext.w	d1
		add.w	d1,d0
		move.w	d0,$10(a1)			; Apply offset to new position
		move.w	$14(a0),d0
		move.b	(a2)+,d1			; Same as above for Y
		move.b	d1,$43(a1)			; $43 has the Y offset
		ext.w	d1
		add.w	d1,d0
		move.w	d0,$14(a1)			; Apply offset
		addq.w	#2,d2				; Add 2 to index
		dbf	d6,loc_84064			; Loop
		moveq	#0,d0

locret_840AE:
		rts
; ---------------------------------------------------------------------------

CreateChild3_NormalRepeated:
		moveq	#0,d2; Same as Child creation routine 1, except it repeats one object several times rather than different objects sequentially
		move.w	(a2)+,d6

loc_84118:
		movea.l	a2,a3
		jsr	Create_New_Sprite3.w
		bne.s	locret_84164
		move.w	a0,$46(a1)
		move.l	$C(a0),$C(a1)
		move.w	$A(a0),$A(a1)
		move.l	(a3)+,(a1)
		move.b	d2,$2C(a1)
		move.w	$10(a0),d0
		move.b	(a3)+,d1
		move.b	d1,$42(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,$10(a1)
		move.w	$14(a0),d0
		move.b	(a3)+,d1
		move.b	d1,$43(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,$14(a1)
		addq.w	#2,d2
		dbf	d6,loc_84118
		moveq	#0,d0

locret_84164:
		rts
; ---------------------------------------------------------------------------

CreateChild6_Simple:
		moveq	#0,d2; Simple child creation routine, merely creates x number of the same object at the parent's position
		move.w	(a2)+,d6

loc_84224:
		jsr	Create_New_Sprite3.w
		bne.s	locret_84256
		move.w	a0,$46(a1)
		move.l	$C(a0),$C(a1)
		move.w	$A(a0),$A(a1)
		move.l	(a2),(a1)
		move.b	d2,$2C(a1)
		move.w	$10(a0),$10(a1)
		move.w	$14(a0),$14(a1)
		addq.w	#2,d2
		dbf	d6,loc_84224
		moveq	#0,d0


locret_84256:
		rts
; ---------------------------------------------------------------------------

CreateChild4_LinkListRepeated:
		movea.l	a0,a3; Creates a linked object list. Previous object address is in $46, while next object in list is at $44
		moveq	#0,d2
		move.w	(a2)+,d6

loc_8416C:
		jsr	Create_New_Sprite3.w
		bne.s	locret_841A4
		move.w	a3,$46(a1)
		move.w	a1,$44(a3)
		movea.l	a1,a3
		move.l	$C(a0),$C(a1)
		move.w	$A(a0),$A(a1)
		move.l	(a2),(a1)
		move.b	d2,$2C(a1)
		move.w	$10(a0),$10(a1)
		move.w	$14(a0),$14(a1)
		addq.w	#2,d2
		dbf	d6,loc_8416C
		moveq	#0,d0

locret_841A4:
		rts
; ---------------------------------------------------------------------------

Refresh_ChildPosition:
		movea.w	$46(a0),a1
		move.w	$10(a1),d0
		move.b	$42(a0),d1
		ext.w	d1
		add.w	d1,d0
		move.w	d0,$10(a0)
		move.w	$14(a1),d0
		move.b	$43(a0),d1
		ext.w	d1
		add.w	d1,d0
		move.w	d0,$14(a0)
		rts
; ---------------------------------------------------------------------------

Refresh_ChildPositionAdjusted:
		movea.w	$46(a0),a1
		move.w	$10(a1),d0
		move.b	$42(a0),d1
		ext.w	d1
		bclr	#0,4(a0)
		btst	#0,4(a1)
		beq.s	loc_843D2
		neg.w	d1
		bset	#0,4(a0)

loc_843D2:
		add.w	d1,d0
		move.w	d0,$10(a0)
		move.w	$14(a1),d0
		move.b	$43(a0),d1
		ext.w	d1
		bclr	#1,4(a0)
		btst	#1,4(a1)
		beq.s	loc_843F8
		neg.w	d1
		bset	#1,4(a0)

loc_843F8:
		add.w	d1,d0
		move.w	d0,$14(a0)
		rts
; ---------------------------------------------------------------------------

Move_AnimateRaw_Wait:
		jsr	MoveSprite2.w

loc_85652:
		bsr.s	Animate_Raw
		jmp	Obj_Wait.w
; ---------------------------------------------------------------------------

MoveFall_AnimateRaw:
		jsr	MoveSprite.w
		bra.s	Animate_Raw
; ---------------------------------------------------------------------------

Move_AnimateRaw:
		jsr	MoveSprite2.w
		bra.s	Animate_Raw
; ---------------------------------------------------------------------------

MoveSlowFall_AnimateRaw:
		jsr	MoveSprite_LightGravity.w
; ---------------------------------------------------------------------------

Animate_Raw:
		movea.l	$30(a0),a1
; ---------------------------------------------------------------------------

Animate_RawNoSST:
		subq.b	#1,$24(a0)
		bpl.s	locret_84426
		moveq	#0,d0
		move.b	$23(a0),d0
		addq.w	#1,d0
		move.b	d0,$23(a0)
		moveq	#0,d1
		move.b	1(a1,d0.w),d1
		bmi.s	loc_84428
		move.b	(a1),$24(a0)
		move.b	d1,$22(a0)

locret_84426:
		rts
; ---------------------------------------------------------------------------

loc_84428:
		neg.b	d1
		jsr	loc_8442E+2(pc,d1.w)

loc_8442E:
		clr.b	$23(a0)
		rts

; ---------------------------------------------------------------------------
		bra.w	AnimateRaw_Restart		; FC
		bra.w	AnimateRaw_Jump			; F8
		bra.w	AnimateRaw_CustomCode		; F4
; ---------------------------------------------------------------------------

AnimateRaw_Jump:
		move.b	2(a1,d0.w),d1
		ext.w	d1
		lea	(a1,d1.w),a1
		move.l	a1,$30(a0)

AnimateRaw_Restart:
		move.b	1(a1),$22(a0)
		move.b	(a1),$24(a0)
		rts
; ---------------------------------------------------------------------------

AnimateRaw_CustomCode:
		clr.b	$24(a0)
		movea.l	$34(a0),a1
		jmp	(a1)
; ---------------------------------------------------------------------------

Animate_RawCheckResult:
		movea.l	$30(a0),a1
; ---------------------------------------------------------------------------

Animate_RawNoSSTCheckResult:
		subq.b	#1,$24(a0)
		bpl.s	loc_8453E
		moveq	#0,d0
		move.b	$23(a0),d0
		addq.w	#1,d0
		move.b	d0,$23(a0)
		lea	1(a1,d0.w),a2
		moveq	#0,d1
		move.b	(a2)+,d1
		cmpi.b	#-1,d1
		beq.s	loc_84542
		move.b	(a1),$24(a0)
		move.b	d1,$22(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_8453E:
		moveq	#0,d2
		rts
; ---------------------------------------------------------------------------

loc_84542:
		move.b	(a2)+,d1
		neg.b	d1
		jsr	loc_8454E(pc,d1.w)
		clr.b	$23(a0)

loc_8454E:
		moveq	#-1,d2
		rts

; ---------------------------------------------------------------------------
		bra.w	loc_8456A
		bra.w	loc_8455E
		bra.w	loc_84576
; ---------------------------------------------------------------------------

loc_8455E:
		move.b	(a2)+,d1
		ext.w	d1
		lea	(a1,d1.w),a1
		move.l	a1,$30(a0)

loc_8456A:
		move.b	1(a1),$22(a0)
		move.b	(a1),$24(a0)
		rts
; ---------------------------------------------------------------------------

loc_84576:
		clr.b	$24(a0)
		movea.l	$34(a0),a1
		jmp	(a1)
; ---------------------------------------------------------------------------

Set_Raw_Animation:
		move.l	a1,$30(a0)
		clr.b	$23(a0)
		clr.b	$24(a0)
		rts
; ---------------------------------------------------------------------------

Stop_Object:
		clr.w	$18(a1)
		clr.w	$1A(a1)
		clr.w	$1C(a1)
		rts
; ---------------------------------------------------------------------------

Animate_RawMultiDelay:
		movea.l	$30(a0),a1
; ---------------------------------------------------------------------------

Animate_RawNoSSTMultiDelay:
		subq.b	#1,$24(a0)
		bpl.s	loc_845C8
		moveq	#0,d0
		move.b	$23(a0),d0
		addq.w	#2,d0
		move.b	d0,$23(a0)
		moveq	#0,d1
		move.b	(a1,d0.w),d1
		bmi.s	loc_845CC
		move.b	d1,$22(a0)
		move.b	1(a1,d0.w),$24(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_845C8:
		moveq	#0,d2
		rts
; ---------------------------------------------------------------------------

loc_845CC:
		neg.b	d1
		jsr	loc_845D2+2(pc,d1.w)

loc_845D2:
		clr.b	$23(a0)
		rts

; ---------------------------------------------------------------------------
		bra.w	loc_845F2
		bra.w	loc_845E4
		bra.w	loc_84600
; ---------------------------------------------------------------------------

loc_845E4:
		move.b	1(a1,d0.w),d1
		ext.w	d1
		lea	(a1,d1.w),a1
		move.l	a1,$30(a0)

loc_845F2:
		move.b	(a1),$22(a0)
		move.b	1(a1),$24(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_84600:
		clr.b	$24(a0)
		movea.l	$34(a0),a1
		jsr	(a1)
		moveq	#-1,d2
		rts
; ---------------------------------------------------------------------------

Animate_RawMultiDelayFlipX:
		movea.l	$30(a0),a1
; ---------------------------------------------------------------------------

Animate_RawNoSSTMultiDelayFlipX:
		subq.b	#1,$24(a0)
		bpl.s	loc_84646
		moveq	#0,d0
		move.b	$23(a0),d0
		addq.w	#2,d0
		move.b	d0,$23(a0)
		moveq	#0,d1
		move.b	(a1,d0.w),d1
		bmi.s	loc_845CC
		bclr	#6,d1
		beq.s	loc_84638
		bchg	#0,4(a0)

loc_84638:
		move.b	d1,$22(a0)
		move.b	1(a1,d0.w),$24(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_84646:
		moveq	#0,d2
		rts
; ---------------------------------------------------------------------------

Animate_RawGetFaster:
		movea.l	$30(a0),a1
		bset	#5,$38(a0)
		bne.s	loc_84714
		move.b	(a1),$2E(a0)
		clr.b	$2F(a0)

loc_84714:
		subq.b	#1,$24(a0)
		bpl.s	loc_8474C
		move.b	$2E(a0),d2
		moveq	#0,d0
		move.b	$23(a0),d0
		addq.b	#1,d0
		move.b	2(a1,d0.w),d1
		bpl.s	loc_8473C
		moveq	#0,d0
		move.b	2(a1),d1
		tst.b	d2
		beq.s	loc_84750
		subq.b	#1,d2
		move.b	d2,$2E(a0)

loc_8473C:
		move.b	d0,$23(a0)
		move.b	d1,$22(a0)
		move.b	d2,$24(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_8474C:
		moveq	#0,d2
		rts
; ---------------------------------------------------------------------------

loc_84750:
		move.b	d0,$23(a0)
		move.b	d1,$22(a0)
		move.b	d2,$24(a0)
		move.b	$2F(a0),d0
		addq.b	#1,d0
		move.b	d0,$2F(a0)
		cmp.b	1(a1),d0
		blo.s	loc_8477C
		bclr	#5,$38(a0)
		clr.b	$2F(a0)
		movea.l	$34(a0),a2
		jsr	(a2)

loc_8477C:
		moveq	#-1,d2
		rts
; ---------------------------------------------------------------------------

Animate_Raw2MultiDelay:
		movea.l	$30(a0),a1
; ---------------------------------------------------------------------------

Animate_Raw2NoSSTMultiDelay:
		subq.b	#1,$24(a0)
		bpl.s	loc_846BA
		moveq	#0,d0
		move.b	$23(a0),d0
		addq.w	#2,d0
		move.b	d0,$23(a0)
		lea	(a1,d0.w),a2
		moveq	#0,d1
		move.b	(a2)+,d1
		cmpi.b	#-1,d1
		beq.s	loc_846BE
		move.b	d1,$22(a0)
		move.b	1(a1,d0.w),$24(a0)
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_846BA:
		moveq	#0,d2
		rts
; ---------------------------------------------------------------------------

loc_846BE:
		move.b	(a2)+,d1
		neg.b	d1
		jsr	loc_846C6+2(pc,d1.w)

loc_846C6:
		clr.b	$23(a0)
		rts

; ---------------------------------------------------------------------------
		bra.w	loc_846E4
		bra.w	loc_846D8
		bra.w	loc_846F2
; ---------------------------------------------------------------------------

loc_846D8:
		move.b	(a2)+,d1
		ext.w	d1
		lea	(a1,d1.w),a1
		move.l	a1,$30(a0)

loc_846E4:
		move.b	(a1),$22(a0)
		move.b	1(a1),$24(a0)
		moveq	#-1,d2
		rts
; ---------------------------------------------------------------------------

loc_846F2:
		clr.b	$24(a0)
		movea.l	$34(a0),a1
		jsr	(a1)
		moveq	#-1,d2
		rts
; ---------------------------------------------------------------------------

ObjHitFloor_DoRoutine:
		tst.w	$1A(a0)
		bmi.s	locret_848AA
		jsr	ObjCheckFloorDist.w
		tst.w	d1
		bmi.s	loc_848AC
		beq.s	loc_848AC

locret_848AA:
		rts
; ---------------------------------------------------------------------------

loc_848AC:
		add.w	d1,$14(a0)
		movea.l	$34(a0),a1
		jmp	(a1)
; ---------------------------------------------------------------------------

ObjHitFloor2_DoRoutine:
		move.w	$18(a0),d3
		ext.l	d3
		lsl.l	#8,d3
		add.l	$10(a0),d3
		swap	d3
		jsr	ObjCheckFloorDist2.w
		cmpi.w	#-1,d1
		blt.s	loc_848DE
		cmpi.w	#$C,d1
		bge.s	loc_848DE
		add.w	d1,$14(a0)
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_848DE:
		movea.l	$34(a0),a1
		jsr	(a1)
		moveq	#1,d0
		rts
; ---------------------------------------------------------------------------

Child_Draw_Sprite_FlickerMove:
		movea.w	$46(a0),a1
		btst	#7,$2A(a1)
		bne.s	loc_849D8
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

loc_849D8:
		bset	#7,$2A(a0)
		move.l	#Obj_FlickerMove,(a0)
		clr.b	$28(a0)
		jsr	Set_IndexedVelocity.w
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Child_Draw_Sprite2_FlickerMove:
		movea.w	$46(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_849D8
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Child_DrawTouch_Sprite_FlickerMove:
		movea.w	$46(a0),a1
		btst	#7,$2A(a1)
		bne.s	loc_849D8
		jsr	Add_SpriteToCollisionResponseList.w
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Child_DrawTouch_Sprite2_FlickerMove:
		movea.w	$46(a0),a1
		btst	#4,$38(a1)
		bne.s	loc_849D8
		btst	#7,$2A(a1)
		beq.s	loc_84A3C
		bset	#7,$2A(a0)
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

loc_84A3C:
		jsr	Add_SpriteToCollisionResponseList.w
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Check_PlayerAttack:
		btst	#1,$2B(a1)
		bne.s	loc_85822
		cmpi.b	#9,$20(a1)
		beq.s	loc_85822
		cmpi.b	#2,$20(a1)
		beq.s	loc_85822

Check_SonicAttack:
		moveq	#0,d0
		rts
loc_85822:
		moveq	#1,d0
		rts
; ---------------------------------------------------------------------------

Check_PlayerCollision:
		move.b	$29(a0),d0
		beq.s	locret_8588E
		clr.b	$29(a0)
		andi.w	#3,d0
		add.w	d0,d0
		lea	word_85890(pc),a1
		movea.w	(a1,d0.w),a1
		move.w	a1,$44(a0)
		moveq	#1,d1

locret_8588E:
		rts

; ---------------------------------------------------------------------------
word_85890:	dc.w $B000, $B000, $B04A, $B04A
; ---------------------------------------------------------------------------

Animate_Sprite:
		moveq	#0,d0
		move.b	$20(a0),d0
		cmp.b	$21(a0),d0
		beq.s	loc_1AC00
		move.b	d0,$21(a0)
		clr.b	$23(a0)
		clr.b	$24(a0)

loc_1AC00:
		subq.b	#1,$24(a0)
		bcc.s	locret_1AC36
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

locret_1AC36:
		rts
; ---------------------------------------------------------------------------

loc_1AC38:
		addq.b	#1,d0			; Code FF - Repeat animation from beginning
		bne.s	loc_1AC48
		move.b	#0,$23(a0)
		move.b	1(a1),d0
		bra.s	loc_1AC1C
; ---------------------------------------------------------------------------

loc_1AC48:
		addq.b	#1,d0			; Code FE - Repeat animation from earlier point
		bne.s	loc_1AC5C
		move.b	2(a1,d1.w),d0
		sub.b	d0,$23(a0)
		sub.b	d0,d1
		move.b	1(a1,d1.w),d0
		bra.s	loc_1AC1C
; ---------------------------------------------------------------------------

loc_1AC5C:
		addq.b	#1,d0			; Code FD - Start new animation
		bne.s	loc_1AC68
		move.b	2(a1,d1.w),$20(a0)
		rts
; ---------------------------------------------------------------------------

loc_1AC68:
		addq.b	#1,d0			; Code FC - Increment routine counter
		bne.s	loc_1AC7A
		addq.b	#2,5(a0)
		clr.b	$24(a0)
		addq.b	#1,$23(a0)
		rts
; ---------------------------------------------------------------------------

loc_1AC7A:
		addq.b	#1,d0			; Code FB - Delete
		bne.s	locret_1AC86
		move.w	#$7F00,$10(a0)
; ---------------------------------------------------------------------------

locret_1AC86:
		rts
; ---------------------------------------------------------------------------

Animate_SpriteIrregularDelay:
		moveq	#0,d0
		move.b	$20(a0),d0
		cmp.b	$21(a0),d0
		beq.s	loc_1ACA0
		move.b	d0,$21(a0)
		clr.b	$23(a0)
		clr.b	$24(a0)

loc_1ACA0:
		subq.b	#1,$24(a0)
		bcc.s	locret_1ACDA
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
; ---------------------------------------------------------------------------

locret_1AD1E:
		rts
; ---------------------------------------------------------------------------

BossDefeated_StopTimer:
		clr.b	(Update_HUD_timer).w
; ---------------------------------------------------------------------------

BossDefeated:
		move.w	#$3F,$2E(a0)
		moveq	#$64,d0
		jsr	(HUD_AddToScore).l
		bclr	#7,4(a0)
		rts
; ---------------------------------------------------------------------------

sub_24280:
		tst.b	$34(a1)
		bne.s	locret_242B4

HurtPlayerIgnoreInvul:
		btst	#1,$2B(a1)
		bne.s	locret_242B4
		cmpi.b	#4,5(a1)
		bhs.s	locret_242B4
		move.l	$14(a1),d3
		move.w	$1A(a1),d0
		ext.l	d0
		asl.l	#8,d0
		sub.l	d0,d3
		move.l	d3,$14(a1)
		movea.l	a0,a2
		movea.l	a1,a0
		jsr	(HurtCharacter).l
		movea.l	a2,a0

locret_242B4:
		rts
; ---------------------------------------------------------------------------

Restore_PlayerControl:
		lea	(Player_1).w,a1

Restore_PlayerControl2:
		clr.b	$2E(a1)
		bclr	#1,$2A(a1)
		move.w	#$505,$20(a1)
		clr.b	$23(a1)
		clr.b	$24(a1)
		rts
; ---------------------------------------------------------------------------

Create_New_Sprite3:
		movea.l	a0,a1
		move.w	#Level_object_RAM,d0
		sub.w	a0,d0
		lsr.w	#6,d0
		move.b	byte_1BB16(pc,d0.w),d0
		bpl.s	loc_1BB0A
		rts
; ---------------------------------------------------------------------------

Create_New_Sprite:
		lea	(Dynamic_object_RAM).w,a1
		moveq	#90-1,d0

loc_1BB0A:
		lea	next_object(a1),a1
		tst.l	(a1)
		dbeq	d0,loc_1BB0A

locret_1BB14:
		rts

; ---------------------------------------------------------------------------
byte_1BB16:
	dc.b  -1,   0,   1,   2,   3,   4,   5,   5,   6,   7,   8,   9,  $A,  $B,  $B,  $C,  $D,  $E,  $F, $10
	dc.b $11, $12, $12, $13, $14, $15, $16, $17, $18, $18, $19, $1A, $1B, $1C, $1D, $1E, $1E, $1F, $20, $21
	dc.b $22, $23, $24, $25, $25, $26, $27, $28, $29, $2A, $2B, $2B, $2C, $2D, $2E, $2F, $30, $31, $32, $32
	dc.b $33, $34, $35, $36, $37, $38, $38, $39, $3A, $3B, $3C, $3D, $3E, $3E, $3F, $40, $41, $42, $43, $44
	dc.b $45, $45, $46, $47, $48, $49, $4A, $4B, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $52, $53, $54, $55
	dc.b $56, $57, $58, $58
; ---------------------------------------------------------------------------

SolidObjectFull:
		lea	(Player_1).w,a1
		moveq	#3,d6
		movem.l	d1-d4,-(sp)
		bsr.s	sub_1DC74
		movem.l	(sp)+,d1-d4

.tails		lea	(Player_2).w,a1
		addq.b	#1,d6
; ---------------------------------------------------------------------------

sub_1DC74:
		btst	d6,$2A(a0)
		beq.w	loc_1DF88
		move.w	d1,d2
		add.w	d2,d2
		btst	#1,$2A(a1)
		bne.s	loc_1DC98
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.s	loc_1DC98
		cmp.w	d2,d0
		blo.s	loc_1DCAC

loc_1DC98:
		bclr	#3,$2A(a1)
		bset	#1,$2A(a1)
		bclr	d6,$2A(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1DCAC:
		move.w	d4,d2
		bsr.w	MvSonicOnPtfm
		moveq	#0,d4

locret_1DCB4:
		rts
; ---------------------------------------------------------------------------

SolidObjectFull2:
		lea	(Player_1).w,a1
		moveq	#3,d6
		movem.l	d1-d4,-(sp)
		bsr.s	SolidObjectFull2_1P
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#1,d6
; ---------------------------------------------------------------------------

SolidObjectFull2_1P:
		btst	d6,$2A(a0)
		beq.w	loc_1DF88		; SolidObject_cont
		move.w	d1,d2
		add.w	d2,d2
		btst	#1,$2A(a1)
		bne.s	loc_1DCF0
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.s	loc_1DCF0
		cmp.w	d2,d0
		blo.s	loc_1DD04

loc_1DCF0:

		bclr	#3,$2A(a1)
		bset	#1,$2A(a1)
		bclr	d6,$2A(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1DD04:
		move.w	d4,d2
		bsr.w	MvSonicOnPtfm
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

sub_1DD0E:
		lea	(Player_1).w,a1
		moveq	#3,d6
		movem.l	d1-d4,-(sp)
		bsr.s	sub_1DD24
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#1,d6
; ---------------------------------------------------------------------------

sub_1DD24:
		btst	d6,$2A(a0)
		beq.w	loc_1DECE
		move.w	d1,d2
		add.w	d2,d2
		btst	#1,$2A(a1)
		bne.s	loc_1DD48
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.s	loc_1DD48
		cmp.w	d2,d0
		blo.s	loc_1DD5C

loc_1DD48:
		bclr	#3,$2A(a1)
		bset	#1,$2A(a1)
		bclr	d6,$2A(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1DD5C:
		move.w	d4,d2
		bsr.w	SolidObjSloped2
		move.w	d6,d4
		addi.b	#$11,d4
		bset	d4,d6
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

sub_1DDC6:
		lea	(Player_1).w,a1
		moveq	#3,d6
		movem.l	d1-d4,-(sp)
		bsr.s	sub_1DDDC
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#1,d6
; ---------------------------------------------------------------------------

sub_1DDDC:
		btst	d6,$2A(a0)
		beq.w	loc_1DECE
		move.w	d1,d2
		add.w	d2,d2
		btst	#1,$2A(a1)
		bne.s	loc_1DE00
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.s	loc_1DE00
		cmp.w	d2,d0
		blo.s	loc_1DE0E

loc_1DE00:

		bclr	#3,$2A(a1)
		bclr	d6,$2A(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1DE0E:
		move.w	d4,d2
		bsr.w	SolidObjSloped2
		move.w	d6,d4
		addi.b	#$11,d4
		bset	d4,d6
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

SolidObjectFull_Offset:
		lea	(Player_1).w,a1
		moveq	#3,d6
		movem.l	d1-d4,-(sp)
		bsr.s	sub_1DE36
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#1,d6
; ---------------------------------------------------------------------------

sub_1DE36:
		btst	d6,$2A(a0)
		beq.w	loc_1DE8C
		btst	#1,$2A(a1)
		bne.s	loc_1DE58
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.s	loc_1DE58
		add.w	d1,d1
		cmp.w	d1,d0
		blo.s	loc_1DE6C

loc_1DE58:
		bclr	#3,$2A(a1)
		bset	#1,$2A(a1)
		bclr	d6,$2A(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1DE6C:
		move.w	$14(a0),d0
		sub.w	d2,d0
		add.w	d3,d0
		moveq	#0,d1
		move.b	$1E(a1),d1
		sub.w	d1,d0
		move.w	d0,$14(a1)
		sub.w	$10(a0),d4
		sub.w	d4,$10(a1)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1DE8C:
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.w	loc_1E0A2
		move.w	d1,d4
		add.w	d4,d4
		cmp.w	d4,d0
		bhi.w	loc_1E0A2
		move.w	$14(a0),d5
		add.w	d3,d5
		move.b	$1E(a1),d3
		ext.w	d3
		add.w	d3,d2
		move.w	$14(a1),d3
		sub.w	d5,d3
		addq.w	#4,d3
		add.w	d2,d3
		bmi.w	loc_1E0A2
		move.w	d2,d4
		add.w	d4,d4
		cmp.w	d4,d3
		bhs.w	loc_1E0A2
		bra.w	loc_1DFFE
; ---------------------------------------------------------------------------

loc_1DECE:
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.w	loc_1E0A2
		move.w	d1,d3
		add.w	d3,d3
		cmp.w	d3,d0
		bhi.w	loc_1E0A2
		move.w	d0,d5
		btst	#0,4(a0)
		beq.s	loc_1DEF4
		not.w	d5
		add.w	d3,d5

loc_1DEF4:
		lsr.w	#1,d5
		move.b	(a2,d5.w),d3
		sub.b	(a2),d3
		ext.w	d3
		move.w	$14(a0),d5
		sub.w	d3,d5
		move.b	$1E(a1),d3
		ext.w	d3
		add.w	d3,d2
		move.w	$14(a1),d3
		sub.w	d5,d3
		addq.w	#4,d3
		add.w	d2,d3
		bmi.w	loc_1E0A2
		move.w	d2,d4
		add.w	d4,d4
		cmp.w	d4,d3
		bhs.w	loc_1E0A2
		bra.w	loc_1DFFE
; ---------------------------------------------------------------------------

loc_1DF28:
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.w	loc_1E0A2
		move.w	d1,d3
		add.w	d3,d3
		cmp.w	d3,d0
		bhi.w	loc_1E0A2
		move.w	d0,d5
		btst	#0,4(a0)
		beq.s	loc_1DF4E
		not.w	d5
		add.w	d3,d5

loc_1DF4E:
		andi.w	#-2,d5
		move.b	(a2,d5.w),d3
		move.b	1(a2,d5.w),d2
		ext.w	d2
		ext.w	d3
		move.w	$14(a0),d5
		sub.w	d3,d5
		move.w	$14(a1),d3
		sub.w	d5,d3
		move.b	$1E(a1),d5
		ext.w	d5
		add.w	d5,d3
		addq.w	#4,d3
		bmi.w	loc_1E0A2
		add.w	d5,d2
		move.w	d2,d4
		add.w	d5,d4
		cmp.w	d4,d3
		bhs.w	loc_1E0A2
		bra.w	loc_1DFFE
; ---------------------------------------------------------------------------

loc_1DF88:
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		move.w	d1,d3
		add.w	d3,d3
		cmp.w	d3,d0
		bhi.w	loc_1E0A2
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_1DFD6
		move.b	$44(a1),d4
		ext.w	d4
		add.w	d2,d4
		move.b	$1E(a1),d3
		ext.w	d3
		add.w	d3,d2
		move.w	$14(a1),d3
		sub.w	$14(a0),d3
		neg.w	d3
		addq.w	#4,d3
		add.w	d2,d3
		andi.w	#$FFF,d3
		add.w	d2,d4
		cmp.w	d4,d3
		bhs.w	loc_1E0A2
		bra.s	loc_1DFFE
; ---------------------------------------------------------------------------

loc_1DFD6:
		move.b	$44(a1),d4
		ext.w	d4
		add.w	d2,d4
		move.b	$1E(a1),d3
		ext.w	d3
		add.w	d3,d2
		move.w	$14(a1),d3
		sub.w	$14(a0),d3
		addq.w	#4,d3
		add.w	d2,d3
		andi.w	#$FFF,d3
		add.w	d2,d4
		cmp.w	d4,d3
		bhs.w	loc_1E0A2

loc_1DFFE:
		tst.b	$2E(a1)
		bmi.w	loc_1E0A2
		cmpi.b	#6,5(a1)
		bhs.w	loc_1E0D0
		tst.b	(Debug_On).w
		bne.w	loc_1E0D0
		move.w	d0,d5
		cmp.w	d0,d1
		bhs.s	loc_1E026
		add.w	d1,d1
		sub.w	d1,d0
		move.w	d0,d5
		neg.w	d5

loc_1E026:
		move.w	d3,d1
		cmp.w	d3,d2
		bhs.s	loc_1E034
		subq.w	#4,d3
		sub.w	d4,d3
		move.w	d3,d1
		neg.w	d1

loc_1E034:
		cmp.w	d1,d5
		bhi.w	loc_1E0D4
		cmpi.w	#4,d1
		bls.w	loc_1E0D4

loc_1E042:
		tst.w	d0
		beq.s	loc_1E06E
		bmi.s	loc_1E050
		tst.w	$18(a1)
		bmi.s	loc_1E06E
		bra.s	loc_1E056
; ---------------------------------------------------------------------------

loc_1E050:
		tst.w	$18(a1)
		bpl.s	loc_1E06E

loc_1E056:
		move.w	#0,$1C(a1)
		move.w	#0,$18(a1)
		tst.b	$37(a1)
		bpl.s	loc_1E06E
		bset	#6,$37(a1)

loc_1E06E:
		sub.w	d0,$10(a1)
		btst	#1,$2A(a1)
		bne.s	loc_1E094
		move.l	d6,d4
		addq.b	#2,d4
		bset	d4,$2A(a0)
		bset	#5,$2A(a1)
		move.w	d6,d4
		addi.b	#$D,d4
		bset	d4,d6
		moveq	#1,d4
		rts
; ---------------------------------------------------------------------------

loc_1E094:
		bsr.s	sub_1E0C2
		move.w	d6,d4
		addi.b	#$D,d4
		bset	d4,d6
		moveq	#1,d4
		rts
; ---------------------------------------------------------------------------

loc_1E0A2:
		move.l	d6,d4
		addq.b	#2,d4
		btst	d4,$2A(a0)
		beq.s	loc_1E0D0
		cmpi.b	#2,$20(a1)
		beq.s	sub_1E0C2
		cmpi.b	#9,$20(a1)
		beq.s	sub_1E0C2
		move.w	#1,$20(a1)
; ---------------------------------------------------------------------------

sub_1E0C2:
		move.l	d6,d4
		addq.b	#2,d4
		bclr	d4,$2A(a0)
		bclr	#5,$2A(a1)

loc_1E0D0:
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1E0D4:
		tst.w	d3
		bmi.s	loc_1E0E0
		cmpi.w	#$10,d3
		blo.s	loc_1E154
		bra.s	loc_1E0A2
; ---------------------------------------------------------------------------

loc_1E0E0:
		btst	#1,$2A(a1)
		bne.s	loc_1E0F6
		tst.w	$1A(a1)
		beq.s	loc_1E126
		bpl.s	loc_1E10E
		tst.w	d3
		bpl.s	loc_1E10E
		bra.s	loc_1E0FC
; ---------------------------------------------------------------------------

loc_1E0F6:
		move.w	#0,$1C(a1)

loc_1E0FC:
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_1E104
		neg.w	d3

loc_1E104:
		sub.w	d3,$14(a1)
		move.w	#0,$1A(a1)

loc_1E10E:

		tst.b	$37(a1)
		bpl.s	loc_1E11A
		bset	#5,$37(a1)

loc_1E11A:
		move.w	d6,d4
		addi.b	#$F,d4
		bset	d4,d6
		moveq	#-2,d4
		rts
; ---------------------------------------------------------------------------

loc_1E126:
		btst	#1,$2A(a1)
		bne.s	loc_1E10E
		move.w	d0,d4
		bpl.s	loc_1E134
		neg.w	d4

loc_1E134:
		cmpi.w	#$10,d4
		blo.w	loc_1E042
		move.l	a0,-(sp)
		movea.l	a1,a0
		jsr	(Kill_Character).l
		movea.l	(sp)+,a0
		move.w	d6,d4
		addi.b	#$F,d4
		bset	d4,d6
		moveq	#-2,d4
		rts
; ---------------------------------------------------------------------------

loc_1E154:
		subq.w	#4,d3
		moveq	#0,d1
		move.b	7(a0),d1
		move.w	d1,d2
		add.w	d2,d2
		add.w	$10(a1),d1
		sub.w	$10(a0),d1
		bmi.s	loc_1E198
		cmp.w	d2,d1
		bhs.s	loc_1E198
		subq.w	#1,$14(a1)
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_1E17E
		neg.w	d3
		addq.w	#2,$14(a1)

loc_1E17E:
		sub.w	d3,$14(a1)
		tst.w	$1A(a1)
		bmi.s	loc_1E198
		bsr.w	RideObject_SetRide
		move.w	d6,d4
		addi.b	#$11,d4
		bset	d4,d6
		moveq	#-1,d4
		rts
; ---------------------------------------------------------------------------

loc_1E198:
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

MvSonicOnPtfm:
		tst.b	(Reverse_gravity_flag).w
		bne.s	loc_1E1AA
		move.w	$14(a0),d0
		sub.w	d3,d0
		bra.s	loc_1E1CA
; ---------------------------------------------------------------------------

loc_1E1AA:
		move.w	$14(a0),d0
		add.w	d3,d0
		bra.s	loc_1E1F4
; ---------------------------------------------------------------------------

loc_1E1CA:
		tst.b	$2E(a1)
		bmi.s	locret_1E1F2
		cmpi.b	#6,5(a1)
		bhs.s	locret_1E1F2
		tst.b	(Debug_On).w
		bne.s	locret_1E1F2
		moveq	#0,d1
		move.b	$1E(a1),d1
		sub.w	d1,d0
		move.w	d0,$14(a1)
		sub.w	$10(a0),d2
		sub.w	d2,$10(a1)

locret_1E1F2:
		rts
; ---------------------------------------------------------------------------

loc_1E1F4:
		tst.b	$2E(a1)
		bmi.s	locret_1E21C
		cmpi.b	#6,5(a1)
		bhs.s	locret_1E21C
		tst.b	(Debug_On).w
		bne.s	locret_1E21C
		moveq	#0,d1
		move.b	$1E(a1),d1

loc_1E20E:
		add.w	d1,d0
		move.w	d0,$14(a1)
		sub.w	$10(a0),d2
		sub.w	d2,$10(a1)

locret_1E21C:
		rts
; ---------------------------------------------------------------------------

SolidObjSloped:
		btst	#3,$2A(a1)
		beq.s	locret_1E280
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		btst	#0,4(a0)
		beq.s	loc_1E23E
		not.w	d0
		add.w	d1,d0
		add.w	d1,d0

loc_1E23E:
		bra.s	loc_1E260
; ---------------------------------------------------------------------------

SolidObjSloped2:
		btst	#3,$2A(a1)
		beq.s	locret_1E280
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		lsr.w	#1,d0
		btst	#0,4(a0)
		beq.s	loc_1E260
		not.w	d0
		add.w	d1,d0

loc_1E260:
		move.b	(a2,d0.w),d1
		ext.w	d1
		move.w	$14(a0),d0
		sub.w	d1,d0
		moveq	#0,d1
		move.b	$1E(a1),d1
		sub.w	d1,d0
		move.w	d0,$14(a1)
		sub.w	$10(a0),d2
		sub.w	d2,$10(a1)

locret_1E280:
		rts
; ---------------------------------------------------------------------------

SolidObjSloped4:
		btst	#3,$2A(a1)
		beq.s	locret_1E280
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		btst	#0,4(a0)
		beq.s	loc_1E2A0
		not.w	d0
		add.w	d1,d0

loc_1E2A0:
		andi.w	#-2,d0
		bra.s	loc_1E260
; ---------------------------------------------------------------------------

SolidObjectTop:
		lea	(Player_1).w,a1
		moveq	#3,d6
		movem.l	d1-d4,-(sp)
		bsr.s	sub_1E2BC
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#1,d6
; ---------------------------------------------------------------------------

sub_1E2BC:
		btst	d6,$2A(a0)
		beq.w	loc_1E42E
		move.w	d1,d2
		add.w	d2,d2
		btst	#1,$2A(a1)
		bne.s	loc_1E2E0
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.s	loc_1E2E0
		cmp.w	d2,d0
		blo.s	loc_1E2F4

loc_1E2E0:
		bclr	#3,$2A(a1)
		bset	#1,$2A(a1)
		bclr	d6,$2A(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1E2F4:
		move.w	d4,d2
		bsr.w	MvSonicOnPtfm
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

SolidObjectTopSloped2:
		lea	(Player_1).w,a1
		moveq	#3,d6
		movem.l	d1-d4,-(sp)
		bsr.s	sub_1E314
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#1,d6
; ---------------------------------------------------------------------------

sub_1E314:
		btst	d6,$2A(a0)
		beq.w	SolidObjCheckSloped2
		move.w	d1,d2
		add.w	d2,d2
		btst	#1,$2A(a1)
		bne.s	loc_1E338
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.s	loc_1E338
		cmp.w	d2,d0
		blo.s	loc_1E34C

loc_1E338:
		bclr	#3,$2A(a1)
		bset	#1,$2A(a1)
		bclr	d6,$2A(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1E34C:
		move.w	d4,d2
		bsr.w	SolidObjSloped2
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

SolidObjectTopSloped:
		lea	(Player_1).w,a1
		moveq	#3,d6
		movem.l	d1-d4,-(sp)
		bsr.s	sub_1E36C
		movem.l	(sp)+,d1-d4
		lea	(Player_2).w,a1
		addq.b	#1,d6
; ---------------------------------------------------------------------------

sub_1E36C:
		btst	d6,$2A(a0)
		beq.w	SolidObjCheckSloped
		move.w	d1,d2
		add.w	d2,d2
		btst	#1,$2A(a1)
		bne.s	loc_1E390
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.s	loc_1E390
		cmp.w	d2,d0
		blo.s	loc_1E3A4

loc_1E390:

		bclr	#3,$2A(a1)
		bset	#1,$2A(a1)
		bclr	d6,$2A(a0)
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1E3A4:
		move.w	d4,d2
		bsr.w	SolidObjSloped
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

sub_1E410:
		tst.w	$1A(a1)
		bmi.w	locret_1E4D4
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.w	locret_1E4D4
		cmp.w	d2,d0
		bhs.w	locret_1E4D4
		bra.s	loc_1E44C
; ---------------------------------------------------------------------------

loc_1E42E:
		tst.w	$1A(a1)
		bmi.w	locret_1E4D4
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.w	locret_1E4D4
		add.w	d1,d1
		cmp.w	d1,d0
		bhs.w	locret_1E4D4

loc_1E44C:
		tst.b	(Reverse_gravity_flag).w
		bne.w	loc_1E4D6
		move.w	$14(a0),d0
		sub.w	d3,d0

loc_1E45A:
		move.w	$14(a1),d2
		move.b	$1E(a1),d1
		ext.w	d1
		add.w	d2,d1
		addq.w	#4,d1
		sub.w	d1,d0
		bhi.w	locret_1E4D4
		cmpi.w	#-$10,d0
		blo.w	locret_1E4D4
		tst.b	$2E(a1)
		bmi.w	locret_1E4D4
		cmpi.b	#6,5(a1)
		bhs.w	locret_1E4D4
		add.w	d0,d2
		addq.w	#3,d2
		move.w	d2,$14(a1)
; ---------------------------------------------------------------------------

RideObject_SetRide:
		btst	#3,$2A(a1)
		beq.s	loc_1E4A0
		movea.w	$42(a1),a3
		bclr	d6,$2A(a3)

loc_1E4A0:
		move.w	a0,$42(a1)
		clr.b	$26(a1)
		clr.w	$1A(a1)
		move.w	$18(a1),$1C(a1)
		bset	#3,$2A(a1)
		bset	d6,$2A(a0)
		bclr	#1,$2A(a1)
		beq.s	locret_1E4D4
		move.l	a0,-(sp)
		movea.l	a1,a0
		jsr	(Player_TouchFloor).l
		movea.l	(sp)+,a0

locret_1E4D4:
		rts
; ---------------------------------------------------------------------------

loc_1E4D6:
		move.w	$14(a0),d0
		add.w	d3,d0
		move.w	$14(a1),d2
		move.b	$1E(a1),d1
		ext.w	d1
		neg.w	d1
		add.w	d2,d1
		subq.w	#4,d1
		sub.w	d0,d1
		bhi.s	locret_1E4D4
		cmpi.w	#-$10,d1
		blo.s	locret_1E4D4
		tst.b	$2E(a1)
		bmi.s	locret_1E4D4
		cmpi.b	#6,5(a1)
		bhs.s	locret_1E4D4
		sub.w	d1,d2
		subq.w	#4,d2
		move.w	d2,$14(a1)
		bra.s	RideObject_SetRide
; ---------------------------------------------------------------------------

SolidObjCheckSloped2:
		tst.w	$1A(a1)
		bmi.w	locret_1E4D4
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.s	locret_1E4D4
		add.w	d1,d1
		cmp.w	d1,d0
		bhs.s	locret_1E4D4
		btst	#0,4(a0)
		beq.s	loc_1E534
		not.w	d0
		add.w	d1,d0

loc_1E534:
		lsr.w	#1,d0
		move.b	(a2,d0.w),d3
		ext.w	d3
		move.w	$14(a0),d0
		sub.w	d3,d0
		bra.w	loc_1E45A
; ---------------------------------------------------------------------------

SolidObjCheckSloped:
		tst.w	$1A(a1)
		bmi.w	locret_1E4D4
		move.w	$10(a1),d0
		sub.w	$10(a0),d0
		add.w	d1,d0
		bmi.w	locret_1E4D4
		add.w	d1,d1
		cmp.w	d1,d0
		bhs.w	locret_1E4D4
		btst	#0,4(a0)
		beq.s	loc_1E570
		not.w	d0
		add.w	d1,d0

loc_1E570:
		move.b	(a2,d0.w),d3
		ext.w	d3
		move.w	$14(a0),d0
		sub.w	d3,d0
		bra.w	loc_1E45A
; ---------------------------------------------------------------------------

CheckPlayerReleaseFromObj:
		lea	(Player_1).w,a1
		btst	#3,$2A(a0)
		beq.s	loc_1E5AE
		jsr	(SonicOnObjHitFloor).l
		tst.w	d1
		beq.s	loc_1E598
		bpl.s	loc_1E5AE

loc_1E598:
		lea	(Player_1).w,a1
		bclr	#3,$2A(a1)
		bset	#1,$2A(a1)
		bclr	#3,$2A(a0)

loc_1E5AE:
		lea	(Player_2).w,a1
		btst	#4,$2A(a0)
		beq.s	loc_1E5DC
		jsr	(SonicOnObjHitFloor).l
		tst.w	d1
		beq.s	loc_1E5C6
		bpl.s	loc_1E5DC

loc_1E5C6:
		lea	(Player_2).w,a1
		bclr	#3,$2A(a1)
		bset	#1,$2A(a1)
		bclr	#4,$2A(a0)

loc_1E5DC:
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

FindFloor:
		lea	GetFloorPosition_FG(pc),a5
		tst.b	(BG_Collision).w
		beq.s	sub_F264
		bsr.s	sub_F264
		move.b	(a4),1(a4)
		move.w	d1,-(sp)
		sub.w	(BG_Offset_X).w,d3
		sub.w	(BG_Offset_Y).w,d2
		lea	GetFloorPosition_BG(pc),a5
		bsr.s	sub_F264
		add.w	(BG_Offset_X).w,d3
		add.w	(BG_Offset_Y).w,d2
		move.w	(sp)+,d0
		cmp.w	d0,d1
		ble.s	locret_F262
		move.b	1(a4),(a4)
		move.w	d0,d1

locret_F262:
		rts
; ---------------------------------------------------------------------------

sub_F264:
		jsr	(a5)			; Find floor block
		move.w	(a1),d0			; get block ID
		move.w	d0,d4			; copy it
		andi.w	#$3FF,d0		; get only ID (throw away other bits)
		beq.s	loc_F274		; if 0, branch (special case)
		btst	d5,d4			; check if block has collision
		bne.s	loc_F282		; if yes, get offset

loc_F274:
		add.w	a3,d2			; add distance offset
		bsr.w	sub_F30C		; find if block above or below has something
		sub.w	a3,d2			; get that block's offset
		addi.w	#$10,d1			; add $10 (the distance is added to returned value, indicating we checked the next block)
		rts
; ---------------------------------------------------------------------------

loc_F282:
		movea.l	(Collision_addr).w,a2
		add.w	d0,d0
		move.b	(a2,d0.w),d0
		andi.w	#$FF,d0
		beq.s	loc_F274
		movea.l	(ColArrayAngle).w,a2				; MJ: Now dynamic
		move.b	(a2,d0.w),(a4)
		lsl.w	#4,d0
		move.w	d3,d1
		btst	#$A,d4
		beq.s	loc_F2AA
		not.w	d1
		neg.b	(a4)

loc_F2AA:
		btst	#$B,d4
		beq.s	loc_F2BA
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

loc_F2BA:
		andi.w	#$F,d1
		add.w	d0,d1
		movea.l	(ColArrayNorm).w,a2				; MJ: Now dynamic
		move.b	(a2,d1.w),d0			; d0 contains height of the block
		ext.w	d0				; extend to word
		eor.w	d6,d4				; exclusive or bits with special value (supplied by caller(s))
		btst	#$B,d4				; check if block is upside-down
		beq.s	loc_F2D6			; if not, branch
		neg.w	d0				; negate the y-offset

loc_F2D6:
		tst.w	d0				; check value in d0
		beq.s	loc_F274			; if 0 (no collision), check block that is below (maybe?)
		bmi.s	loc_F2F2			; if less than 0 (upside-down block), branch
		cmpi.b	#$10,d0				; check if $10 (full block)
		beq.s	loc_F2FE			; if yes, branch
		move.w	d2,d1				; copy y-position to d1
		andi.w	#$F,d1				; keep in range of a block
		add.w	d1,d0				; add it to d0
		move.w	#$F,d1				; get full block size - 1 to d1
		sub.w	d0,d1				; sub the resulting value from d1.
		rts
; ---------------------------------------------------------------------------

loc_F2F2:
		move.w	d2,d1				; copy y-position to d1
		andi.w	#$F,d1				; keep in range of a block
		add.w	d1,d0				; add the (negative) block height to d0
		bpl.w	loc_F274			; if positive, check the block below

loc_F2FE:
		sub.w	a3,d2				; sub the block offset from y-position
		bsr.s	sub_F30C			; check next block
		add.w	a3,d2				; fix y-pos
		subi.w	#$10,d1				; indicate we checked the previous block (above?)
		rts
; ---------------------------------------------------------------------------

sub_F30C:
		jsr	(a5)				; Find floor block
		move.w	(a1),d0				; get block ID
		move.w	d0,d4				; copy it
		andi.w	#$3FF,d0			; get only ID (throw away other bits)
		beq.s	loc_F31C			; if 0, branch (special case)
		btst	d5,d4				; check if block has collision
		bne.s	loc_F32A			; if yes, get offset

loc_F31C:
		move.w	#$F,d1				; get full block size - 1 to d1
		move.w	d2,d0				; copy y-position to d1
		andi.w	#$F,d0				; keep in range of a block
		sub.w	d0,d1				; sub the resulting value from d1.
		rts
; ---------------------------------------------------------------------------

loc_F32A:
		movea.l	(Collision_addr).w,a2
		add.w	d0,d0
		move.b	(a2,d0.w),d0
		andi.w	#$FF,d0
		beq.s	loc_F31C
		movea.l	(ColArrayAngle).w,a2				; MJ: Now dynamic
		move.b	(a2,d0.w),(a4)
		lsl.w	#4,d0
		move.w	d3,d1
		btst	#$A,d4
		beq.s	loc_F352
		not.w	d1
		neg.b	(a4)

loc_F352:
		btst	#$B,d4
		beq.s	loc_F362
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

loc_F362:
		andi.w	#$F,d1
		add.w	d0,d1
		movea.l	(ColArrayNorm).w,a2				; MJ: Now dynamic
		move.b	(a2,d1.w),d0
		ext.w	d0
		eor.w	d6,d4
		btst	#$B,d4
		beq.s	loc_F37E
		neg.w	d0

loc_F37E:
		tst.w	d0
		beq.s	loc_F31C
		bmi.s	loc_F394
		move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts
; ---------------------------------------------------------------------------

loc_F394:
		move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	loc_F31C
		not.w	d1
		rts
; ---------------------------------------------------------------------------

loc_F3A4:
		lea	GetFloorPosition_FG(pc),a5
		tst.b	(BG_Collision).w
		beq.s	sub_F3DE
		bsr.s	sub_F3DE
		move.b	(a4),1(a4)
		move.w	d1,-(sp)
		sub.w	(BG_Offset_X).w,d3
		sub.w	(BG_Offset_Y).w,d2
		lea	GetFloorPosition_BG(pc),a5
		bsr.s	sub_F3DE
		add.w	(BG_Offset_X).w,d3
		add.w	(BG_Offset_Y).w,d2
		move.w	(sp)+,d0
		cmp.w	d0,d1
		ble.s	locret_F3DC
		move.b	1(a4),(a4)
		move.w	d0,d1

locret_F3DC:
		rts
; ---------------------------------------------------------------------------

sub_F3DE:

		jsr	(a5)
		move.w	(a1),d0
		move.w	d0,d4
		andi.w	#$3FF,d0
		beq.s	loc_F3EE
		btst	d5,d4
		bne.s	loc_F3F4

loc_F3EE:
		move.w	#$10,d1
		rts
; ---------------------------------------------------------------------------

loc_F3F4:
		movea.l	(Collision_addr).w,a2
		add.w	d0,d0
		move.b	(a2,d0.w),d0
		andi.w	#$FF,d0
		beq.s	loc_F3EE
		movea.l	(ColArrayAngle).w,a2				; MJ: Now dynamic
		move.b	(a2,d0.w),(a4)
		lsl.w	#4,d0
		move.w	d3,d1
		btst	#$A,d4
		beq.s	loc_F41C
		not.w	d1
		neg.b	(a4)

loc_F41C:
		btst	#$B,d4
		beq.s	loc_F42C
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

loc_F42C:
		andi.w	#$F,d1
		add.w	d0,d1
		movea.l	(ColArrayNorm).w,a2				; MJ: Now dynamic
		move.b	(a2,d1.w),d0
		ext.w	d0
		eor.w	d6,d4
		btst	#$B,d4
		beq.s	loc_F448
		neg.w	d0

loc_F448:
		tst.w	d0
		beq.s	loc_F3EE
		bmi.s	loc_F464
		cmpi.b	#$10,d0
		beq.s	loc_F470
		move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts
; ---------------------------------------------------------------------------

loc_F464:
		move.w	d2,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	loc_F3EE

loc_F470:
		sub.w	a3,d2
		bsr.w	sub_F30C
		add.w	a3,d2
		subi.w	#$10,d1
		rts
; ---------------------------------------------------------------------------

FindWall:
		lea	GetFloorPosition_FG(pc),a5
		tst.b	(BG_Collision).w
		beq.s	sub_F4DC
		bsr.s	sub_F4DC
		move.b	(a4),1(a4)
		move.w	d1,-(sp)
		move.w	a3,d0
		bpl.s	loc_F4A4
		eori.w	#$F,d3
		sub.w	(BG_Offset_X).w,d3
		eori.w	#$F,d3
		bra.s	loc_F4A8
; ---------------------------------------------------------------------------

loc_F4A4:
		sub.w	(BG_Offset_X).w,d3

loc_F4A8:
		sub.w	(BG_Offset_Y).w,d2
		lea	GetFloorPosition_BG(pc),a5
		bsr.s	sub_F4DC
		move.w	a3,d0
		bpl.s	loc_F4C6
		eori.w	#$F,d3
		add.w	(BG_Offset_X).w,d3
		eori.w	#$F,d3
		bra.s	loc_F4CA
; ---------------------------------------------------------------------------

loc_F4C6:
		add.w	(BG_Offset_X).w,d3

loc_F4CA:
		add.w	(BG_Offset_Y).w,d2
		move.w	(sp)+,d0
		cmp.w	d0,d1
		ble.s	locret_F4DA
		move.b	1(a4),(a4)
		move.w	d0,d1

locret_F4DA:
		rts
; ---------------------------------------------------------------------------

sub_F4DC:
		jsr	(a5)
		move.w	(a1),d0
		move.w	d0,d4
		andi.w	#$3FF,d0
		beq.s	loc_F4EC
		btst	d5,d4
		bne.s	loc_F4FA

loc_F4EC:
		add.w	a3,d3
		bsr.w	sub_F584
		sub.w	a3,d3
		addi.w	#$10,d1
		rts
; ---------------------------------------------------------------------------

loc_F4FA:
		movea.l	(Collision_addr).w,a2
		add.w	d0,d0
		move.b	(a2,d0.w),d0
		andi.w	#$FF,d0
		beq.s	loc_F4EC
		movea.l	(ColArrayAngle).w,a2				; MJ: Now dynamic
		move.b	(a2,d0.w),(a4)
		lsl.w	#4,d0
		move.w	d2,d1
		btst	#$B,d4
		beq.s	loc_F52A
		not.w	d1
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

loc_F52A:
		btst	#$A,d4
		beq.s	loc_F532
		neg.b	(a4)

loc_F532:
		andi.w	#$F,d1
		add.w	d0,d1
		movea.l	(ColArrayRot).w,a2				; MJ: Now dynamic
		move.b	(a2,d1.w),d0
		ext.w	d0
		eor.w	d6,d4
		btst	#$A,d4
		beq.s	loc_F54E
		neg.w	d0

loc_F54E:
		tst.w	d0
		beq.s	loc_F4EC
		bmi.s	loc_F56A
		cmpi.b	#$10,d0
		beq.s	loc_F576
		move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts
; ---------------------------------------------------------------------------

loc_F56A:
		move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	loc_F4EC

loc_F576:
		sub.w	a3,d3
		bsr.s	sub_F584
		add.w	a3,d3
		subi.w	#$10,d1
		rts
; ---------------------------------------------------------------------------

sub_F584:
		jsr	(a5)
		move.w	(a1),d0
		move.w	d0,d4
		andi.w	#$3FF,d0
		beq.s	loc_F594
		btst	d5,d4
		bne.s	loc_F5A2

loc_F594:
		move.w	#$F,d1
		move.w	d3,d0
		andi.w	#$F,d0
		sub.w	d0,d1
		rts
; ---------------------------------------------------------------------------

loc_F5A2:
		movea.l	(Collision_addr).w,a2
		add.w	d0,d0
		move.b	(a2,d0.w),d0
		andi.w	#$FF,d0
		beq.s	loc_F594
		movea.l	(ColArrayAngle).w,a2				; MJ: Now dynamic
		move.b	(a2,d0.w),(a4)
		lsl.w	#4,d0
		move.w	d2,d1
		btst	#$B,d4
		beq.s	loc_F5D2
		not.w	d1
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

loc_F5D2:
		btst	#$A,d4
		beq.s	loc_F5DA
		neg.b	(a4)

loc_F5DA:
		andi.w	#$F,d1
		add.w	d0,d1
		movea.l	(ColArrayRot).w,a2				; MJ: Now dynamic
		move.b	(a2,d1.w),d0
		ext.w	d0
		eor.w	d6,d4
		btst	#$A,d4
		beq.s	loc_F5F6
		neg.w	d0

loc_F5F6:
		tst.w	d0
		beq.s	loc_F594
		bmi.s	loc_F60C
		move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts
; ---------------------------------------------------------------------------

loc_F60C:
		move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	loc_F594
		not.w	d1
		rts
; ---------------------------------------------------------------------------

sub_F61C:
		tst.w	(Competition_mode).w
		bne.w	sub_F6B4
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$C,$46(a0)
		beq.s	loc_F638
		move.l	(Secondary_collision_addr).w,(Collision_addr).w

loc_F638:
		move.b	$47(a0),d5
		move.l	$10(a0),d3
		move.l	$14(a0),d2
		move.w	$18(a0),d1
		ext.l	d1
		asl.l	#8,d1
		add.l	d1,d3
		move.w	$1A(a0),d1
		tst.b	(Reverse_gravity_flag).w
		beq.s	loc_F65A
		neg.w	d1

loc_F65A:
		ext.l	d1
		asl.l	#8,d1
		add.l	d1,d2
		swap	d2
		swap	d3

loc_F664:
		move.b	d0,(Primary_Angle).w
		move.b	d0,(Secondary_Angle).w
		move.b	d0,d1
		addi.b	#$20,d0
		bpl.s	loc_F680
		move.b	d1,d0
		bpl.s	loc_F67A
		subq.b	#1,d0

loc_F67A:
		addi.b	#$20,d0
		bra.s	loc_F68A
; ---------------------------------------------------------------------------

loc_F680:
		move.b	d1,d0
		bpl.s	loc_F686
		addq.b	#1,d0

loc_F686:
		addi.b	#$1F,d0

loc_F68A:
		andi.b	#$C0,d0
		beq.w	CheckFloorDist_Part2
		cmpi.b	#$80,d0
		beq.w	CheckCeilingDist_Part2
		tst.w	(Competition_mode).w
		bne.s	loc_F6A8
		andi.b	#$38,d1
		bne.s	loc_F6A8
		addq.w	#8,d2

loc_F6A8:
		cmpi.b	#$40,d0
		beq.w	loc_FDA8
		bra.w	loc_FA88
; ---------------------------------------------------------------------------

sub_F6B4:
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$C,$46(a0)
		beq.s	loc_F6C8
		move.l	(Secondary_collision_addr).w,(Collision_addr).w

loc_F6C8:
		move.b	$47(a0),d5
		move.l	$10(a0),d3
		move.l	$14(a0),d2
		move.w	$18(a0),d1
		ext.l	d1
		asl.l	#8,d1
		add.l	d1,d3
		move.w	$1A(a0),d1
		ext.l	d1
		asl.l	#8,d1
		add.l	d1,d2
		swap	d2
		swap	d3
		move.b	d0,(Primary_Angle).w
		move.b	d0,(Secondary_Angle).w
		move.b	d0,d1
		addi.b	#$20,d0
		bpl.s	loc_F708
		move.b	d1,d0
		bpl.s	loc_F702
		subq.b	#1,d0

loc_F702:
		addi.b	#$20,d0
		bra.s	loc_F712
; ---------------------------------------------------------------------------

loc_F708:
		move.b	d1,d0
		bpl.s	loc_F70E
		addq.b	#1,d0

loc_F70E:
		addi.b	#$1F,d0

loc_F712:
		andi.b	#$C0,d0
		beq.w	sub_F828
		cmpi.b	#$80,d0
		beq.w	sub_FBEE
		cmpi.b	#$40,d0
		beq.w	loc_FDC8
		bra.w	loc_FAA4
; ---------------------------------------------------------------------------
	; a bit of unused/dead code here
CheckCeilingDist:
		move.w	$14(a0),d2
		move.w	$10(a0),d3
; loc_FBCE:
CheckCeilingDist_Part2:
		subi.w	#$A,d2
		eori.w	#$F,d2
		lea	(Primary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		jsr	FindFloor.w
		move.b	#-$80,d2
		jmp	loc_F81A.w
; ---------------------------------------------------------------------------

; CheckFloorDist:
		move.w	y_pos(a0),d2
		move.w	x_pos(a0),d3

; Checks a 16x16 block to find solid ground. May check an additional
; 16x16 block up for ceilings.
; d2 = y_pos
; d3 = x_pos
; d5 = ($c,$d) or ($e,$f) - solidity type bit (L/R/B or top)
; returns relevant block ID in (a1)
; returns distance in d1
; returns angle in d3, or zero if angle was odd
; loc_F802:
CheckFloorDist_Part2:
		addi.w	#$A,d2
		lea	(Primary_Angle).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		bsr.w	FindFloor
		move.b	#0,d2

; d2 what to use as angle if (Primary_Angle).w is odd
; returns angle in d3, or value in d2 if angle was odd
loc_F81A:
		move.b	(Primary_Angle).w,d3
		btst	#0,d3
		beq.s	locret_F826
		move.b	d2,d3

locret_F826:
		rts
; ---------------------------------------------------------------------------

sub_F828:
		move.b	$1F(a0),d0
		ext.w	d0
		add.w	d0,d2
		lea	(Primary_Angle).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		bsr.w	FindFloor
		move.b	#0,d2
		bra.s	loc_F81A
; ---------------------------------------------------------------------------

sub_F846:
		move.w	$10(a0),d3
		move.w	$14(a0),d2
		subq.w	#4,d2
		move.l	(Primary_collision_addr).w,(Collision_addr).w
		cmpi.b	#$D,$47(a0)
		beq.s	loc_F864
		move.l	(Secondary_collision_addr).w,(Collision_addr).w

loc_F864:
		lea	(Primary_Angle).w,a4
		move.b	#0,(a4)
		movea.w	#$10,a3
		move.w	#0,d6
		move.b	$47(a0),d5
		movem.l	a4-a6,-(sp)
		bsr.w	FindFloor
		movem.l	(sp)+,a4-a6
		move.b	(Primary_Angle).w,d3
		btst	#0,d3
		beq.s	locret_F892
		move.b	#0,d3

locret_F892:
		rts
; ---------------------------------------------------------------------------
; Subroutine checking if an object should interact with the floor
; (objects such as a monitor Sonic bumps from underneath)
; ---------------------------------------------------------------------------

ObjCheckFloorDist:
		move.w	x_pos(a0),d3

ObjCheckFloorDist2:
		move.w	y_pos(a0),d2		; Get object position
		move.b	y_radius(a0),d0		; Get object height
		ext.w	d0
		add.w	d0,d2

ObjCheckFloorDistSpecial:
		lea	(Primary_Angle).w,a4
		move.b	#0,(a4)
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$C,d5
		bsr.w	FindFloor
		move.b	(Primary_Angle).w,d3
		btst	#0,d3
		beq.s	locret_F96C
		move.b	#0,d3

locret_F96C:
		rts
; ---------------------------------------------------------------------------

;FireCheckFloorDist:
		move.w	x_pos(a1),d3
		move.w	y_pos(a1),d2
		move.b	y_radius(a1),d0
		ext.w	d0
		add.w	d0,d2
		lea	(Primary_Angle).w,a4
		move.b	#0,(a4)
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$C,d5
		bra.w	FindFloor
; ---------------------------------------------------------------------------

sub_FA1A:
		move.w	$14(a0),d2
		move.w	$10(a0),d3
		moveq	#0,d0
		move.b	$1E(a0),d0
		ext.w	d0
		sub.w	d0,d2
		move.b	$1F(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(Primary_Angle).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		bsr.w	FindWall
		move.w	d1,-(sp)
		move.w	$14(a0),d2
		move.w	$10(a0),d3
		moveq	#0,d0
		move.b	$1E(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	$1F(a0),d0

loc_FA5C:
		ext.w	d0
		add.w	d0,d3
		lea	(Secondary_Angle).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		bsr.w	FindWall
		move.w	(sp)+,d0
		move.b	#-$40,d2
; ---------------------------------------------------------------------------

loc_F7E2:
		move.b	(Secondary_Angle).w,d3
		cmp.w	d0,d1
		ble.s	loc_F7F0
		move.b	(Primary_Angle).w,d3
		exg	d0,d1

loc_F7F0:
		btst	#0,d3
		beq.s	locret_F7F8
		move.b	d2,d3

locret_F7F8:
		rts
; ---------------------------------------------------------------------------

ObjHitWall_DoRoutine:
		bsr.s	ObjCheckRightWallDist
		tst.w	d1
		bmi.s	loc_848F4
		rts

loc_848F4:
		add.w	d1,$10(a0)
		movea.l	$34(a0),a1
		jmp	(a1)
; ---------------------------------------------------------------------------

ObjCheckRightWallDist:
		add.w	$10(a0),d3
		move.w	$14(a0),d2
		lea	(Primary_Angle).w,a4
		move.b	#0,(a4)
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$D,d5
		bsr.w	FindWall
		move.b	(Primary_Angle).w,d3
		btst	#0,d3
		beq.s	locret_FAF0
		move.b	#-$40,d3

locret_FAF0:
		rts
; ---------------------------------------------------------------------------

CheckRightWallDist:
		move.w	$14(a0),d2
		move.w	$10(a0),d3
		tst.w	(Competition_mode).w
		bne.s	loc_FAA4

loc_FA88:
		addi.w	#$A,d3
		lea	(Primary_Angle).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		jsr	FindWall.w
		move.b	#-$40,d2
		jmp	loc_F81A.w
; ---------------------------------------------------------------------------

loc_FAA4:
		move.b	$1F(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(Primary_Angle).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		jsr	FindWall.w
		move.b	#-$40,d2
		jmp	loc_F81A.w
; ---------------------------------------------------------------------------

sub_FB5A:
		move.w	$14(a0),d2
		move.w	$10(a0),d3
		moveq	#0,d0
		move.b	$1E(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		move.b	$1F(a0),d0
		ext.w	d0
		subq.w	#2,d0
		add.w	d0,d3
		lea	(Primary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		bsr.w	FindFloor
		move.w	d1,-(sp)
		move.w	$14(a0),d2
		move.w	$10(a0),d3
		moveq	#0,d0
		move.b	$1E(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		move.b	$1F(a0),d0
		ext.w	d0
		subq.w	#2,d0
		sub.w	d0,d3
		lea	(Secondary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		bsr.w	FindFloor
		move.w	(sp)+,d0
		move.b	#-$80,d2
		bra.w	loc_F7E2
; ---------------------------------------------------------------------------

sub_FBEE:
		move.b	$1F(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		lea	(Primary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		bsr.w	FindFloor
		move.b	#-$80,d2
		bra.w	loc_F81A
; ---------------------------------------------------------------------------

ObjCheckCeilingDist:
		move.w	$14(a0),d2
		move.w	$10(a0),d3
		moveq	#0,d0
		move.b	$1E(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		lea	(Primary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		moveq	#$D,d5
		bsr.w	FindFloor
		move.b	(Primary_Angle).w,d3
		btst	#0,d3
		beq.s	locret_FC48
		move.b	#-$80,d3

locret_FC48:
		rts
; ---------------------------------------------------------------------------

sub_FCA0:
		move.w	$10(a0),d3
		move.w	$14(a0),d2
		move.b	$1E(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		lea	(Primary_Angle).w,a4
		move.b	#0,(a4)
		movea.w	#-$10,a3
		move.w	#$800,d6
		moveq	#$C,d5
		bra.w	loc_F3A4
; ---------------------------------------------------------------------------

sub_FD32:
		move.w	$14(a0),d2
		move.w	$10(a0),d3
		moveq	#0,d0
		move.b	$1E(a0),d0
		ext.w	d0
		sub.w	d0,d2
		move.b	$1F(a0),d0
		ext.w	d0
		sub.w	d0,d3
		eori.w	#$F,d3
		lea	(Primary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6
		bsr.w	FindWall
		move.w	d1,-(sp)
		move.w	$14(a0),d2
		move.w	$10(a0),d3
		moveq	#0,d0
		move.b	$1E(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	$1F(a0),d0
		ext.w	d0
		sub.w	d0,d3
		eori.w	#$F,d3
		lea	(Secondary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6
		bsr.w	FindWall
		move.w	(sp)+,d0
		move.b	#$40,d2
		bra.w	loc_F7E2
; ---------------------------------------------------------------------------

ObjHitWall2_DoRoutine:
		bsr.s	ObjCheckLeftWallDist
		tst.w	d1
		bmi.s	loc_8490A
.rts		rts

loc_8490A:
		add.w	d1,$10(a0)
		movea.l	$34(a0),a1
		jmp	(a1)
; ---------------------------------------------------------------------------

ObjCheckLeftWallDist:
		add.w	$10(a0),d3
		eori.w	#$F,d3	; this was not here in S1/S2, resulting in a bug

ObjCheckLeftWallDist_Part2:
		move.w	$14(a0),d2
		lea	(Primary_Angle).w,a4
		move.b	#0,(a4)
		movea.w	#-$10,a3
		move.w	#$400,d6
		moveq	#$D,d5
		bsr.w	FindWall
		move.b	(Primary_Angle).w,d3
		btst	#0,d3
		beq.s	locret_FE6C
		move.b	#$40,d3

locret_FE6C:
		rts
; ---------------------------------------------------------------------------

CheckLeftWallDist:
		move.w	$14(a0),d2
		move.w	$10(a0),d3
		tst.w	(Competition_mode).w
		bne.s	loc_FDC8

loc_FDA8:
		subi.w	#$A,d3
		eori.w	#$F,d3
		lea	(Primary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6
		jsr	FindWall.w
		move.b	#$40,d2
		jmp	loc_F81A.w
; ---------------------------------------------------------------------------

loc_FDC8:
		move.b	$1F(a0),d0
		ext.w	d0
		sub.w	d0,d3
		eori.w	#$F,d3
		lea	(Primary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6
		jsr	FindWall.w
		move.b	#$40,d2
		jmp	loc_F81A.w
; ---------------------------------------------------------------------------

LoadPalette:

		lea	(PalPoint).l,a1
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2
		movea.w	(a1)+,a3
		adda.w	#$80,a3
		move.w	(a1)+,d7

loc_3DD2:
		move.l	(a2)+,(a3)+
		dbf	d7,loc_3DD2
		rts
; ---------------------------------------------------------------------------

LoadPalette_Immediate:
		lea	(PalPoint).l,a1
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2
		movea.w	(a1)+,a3
		move.w	(a1)+,d7

loc_3DEA:
		move.l	(a2)+,(a3)+
		dbf	d7,loc_3DEA
		rts
; ---------------------------------------------------------------------------

LoadPalette2:
		lea	(PalPoint).l,a1
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2
		movea.w	(a1)+,a3
		suba.w	#Normal_palette-Target_water_palette,a3	; NAT: Fixed equation
		move.w	(a1)+,d7

loc_3E06:
		move.l	(a2)+,(a3)+
		dbf	d7,loc_3E06
		rts
; ---------------------------------------------------------------------------

LoadPalette2_Immediate:
		lea	(PalPoint).l,a1
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2
		movea.w	(a1)+,a3
		suba.w	#Normal_palette-Water_palette,a3	; NAT: Fixed equation
		move.w	(a1)+,d7

loc_3E22:
		move.l	(a2)+,(a3)+
		dbf	d7,loc_3E22
		rts
; ---------------------------------------------------------------------------

sub_85D6A:
		st	Boss_flag.w

loc_85D70:
		move.w	#$78,$2E(a0)

loc_85D7E:
		move.w	(Camera_min_Y_pos).w,(__u_FA96).w
		move.w	(Camera_target_max_Y_pos).w,(__u_FA98).w
		move.w	(Camera_min_X_pos).w,(__u_FA94).w
		move.w	(Camera_max_X_pos).w,(__u_FA92).w
		move.w	(a1)+,(__u_FAB0).w
		move.w	(a1)+,(__u_FAB2).w
		move.w	(a1)+,(__u_FAB4).w
		move.w	(a1)+,(__u_FAB6).w
		rts
; ---------------------------------------------------------------------------

loc_85CA4:
		btst	#0,$27(a0)
		bne.s	loc_85CC6
		subq.w	#1,$2E(a0)
		bpl.s	loc_85CC6
		move.b	$26(a0),d0
		move.b	d0,(Level_music+$1).w
		jsr	Play_Sound.w
		bset	#0,$27(a0)

loc_85CC6:
		btst	#1,$27(a0)
		bne.s	loc_85D06
		move.w	(Camera_Y_pos).w,d0
		tst.b	$27(a0)
		bmi.s	loc_85CE6
		cmp.w	(__u_FAB0).w,d0
		bhs.s	loc_85CF2
		move.w	d0,(Camera_min_Y_pos).w
		bra.w	loc_85D06
; ---------------------------------------------------------------------------

loc_85CE6:
		move.w	(__u_FAB2).w,d1
		addi.w	#$60,d1
		cmp.w	d1,d0
		bhi.s	loc_85D06

loc_85CF2:
		bset	#1,$27(a0)
		move.w	(__u_FAB0).w,(Camera_min_Y_pos).w
		move.w	(__u_FAB2).w,d0
		move.w	d0,(Camera_target_max_Y_pos).w

loc_85D06:
		btst	#2,$27(a0)
		bne.s	loc_85D48
		move.w	(Camera_X_pos).w,d0
		btst	#6,$27(a0)
		bne.s	loc_85D28
		cmp.w	(__u_FAB4).w,d0
		bhs.s	loc_85D36
		move.w	d0,(Camera_min_X_pos).w
		bra.w	loc_85D48
; ---------------------------------------------------------------------------

loc_85D28:
		cmp.w	(__u_FAB6).w,d0
		bls.s	loc_85D36
		move.w	d0,(Camera_max_X_pos).w
		bra.w	loc_85D48
; ---------------------------------------------------------------------------

loc_85D36:
		bset	#2,$27(a0)
		move.w	(__u_FAB4).w,(Camera_min_X_pos).w
		move.w	(__u_FAB6).w,(Camera_max_X_pos).w

loc_85D48:
		move.b	$27(a0),d0
		andi.b	#7,d0
		cmpi.b	#7,d0
		bne.s	StartNewLevel.rts
		clr.b	$27(a0)
		clr.w	$1C(a0)
		clr.b	$26(a0)
		movea.l	$34(a0),a1
		jmp	(a1)
; ---------------------------------------------------------------------------

StartNewLevel:
		move.w	d0,(Current_zone_and_act).w
		move.w	d0,(Apparent_zone_and_act).w
		st	(Restart_level_flag).w
		clr.b	(Last_star_post_hit).w
.rts		rts
; ---------------------------------------------------------------------------

Player_Load_PLC:
		move.l	a0,-(sp)
		lea	(Player_1).w,a0
		moveq	#0,d0
		move.b	$38(a0),d0
		lsl.w	#2,d0
		movea.l	off_85FB8(pc,d0.w),a1
		jsr	(a1)
		movea.l	(sp)+,a0
		rts

; ---------------------------------------------------------------------------
off_85FB8:	dc.l Sonic_Load_PLC, Tails_Load_PLC, Knuckles_Load_PLC
; ---------------------------------------------------------------------------

Player_Load_PLC2:
		move.l	a0,-(sp)
		movea.l	a1,a0
		tst.l	(a0)
		beq.s	loc_85FDA
		moveq	#0,d0
		move.b	$38(a0),d0
		lsl.w	#2,d0
		movea.l	off_85FB8(pc,d0.w),a1
		jsr	(a1)

loc_85FDA:
		movea.l	(sp)+,a0
		rts
; ---------------------------------------------------------------------------

Perform_DPLC:
		moveq	#0,d0
		move.b	$22(a0),d0		; Get the frame number
		cmp.b	$3A(a0),d0		; If frame number remains the same as before, don't do anything
		beq.s	locret_8506E
		move.b	d0,$3A(a0)
		movea.l	(a2)+,a3		; Source address of art
		move.w	$A(a0),d4
		andi.w	#$7FF,d4		; Isolate tile location offset
		lsl.w	#5,d4			; Convert to VRAM address
		movea.l	(a2)+,a2		; Address of DPLC script
		add.w	d0,d0
		adda.w	(a2,d0.w),a2		; Apply offset to script
		move.w	(a2)+,d5		; Get number of DMA transactions
		moveq	#0,d3

loc_8504A:
		move.w	(a2)+,d3		; Art source offset
		move.l	d3,d1
		andi.w	#$FFF0,d1		; Isolate all but lower 4 bits
		add.w	d1,d1
		add.l	a3,d1			; Get final source address of art
		move.w	d4,d2			; Destination VRAM address
		andi.w	#$F,d3
		addq.w	#1,d3
		lsl.w	#4,d3			; d3 is the total number of words to transfer (maximum 16 tiles per transaction)
		add.w	d3,d4
		add.w	d3,d4
		bsr.s	Add_To_DMA_Queue	; Add to queue
		dbf	d5,loc_8504A		; Keep going

locret_8506E:
		rts
; ---------------------------------------------------------------------------
; Adds art to the DMA queue
; Inputs:
; d1 = source address
; d2 = destination VRAM address
; d3 = number of words to transfer
; ---------------------------------------------------------------------------

Add_To_DMA_Queue:
	if Sonic3_Complete
		btst	#23,d1
		bne.s	Add_To_DMA_Queue_Do
		movem.l	d4-d5,-(sp)
		movem.l	d1-d3,-(sp)
		move.l	d1,d4
		andi.l	#$FFFF,d3
		add.w	d3,d3
		add.l	d3,d4
		subq.l	#1,d4			; get address of last byte to be DMAed
		andi.l	#$FE0000,d1
		andi.l	#$FE0000,d4
		cmp.l	d1,d4			; has a $20000-byte (128kb) boundary been crossed?
		bne.s	Add_To_DMA_Queue2	; if it has, branch
		movem.l	(sp)+,d1-d3
		movem.l	(sp)+,d4-d5
		bra.s	Add_To_DMA_Queue_Do	; otherwise, proceed normally

Add_To_DMA_Queue2:
		movem.l	(sp),d1-d3
		move.l	d4,d3
		sub.l	d1,d3
		move.w	d3,d5
		lsr.w	#1,d3			; get length of first DMA
		bsr.s	Add_To_DMA_Queue_Do
		movem.l	(sp)+,d1-d3
		move.l	d4,d1			; get source address for second DMA
		add.w	d5,d2			; get destination address for second DMA
		lsr.w	#1,d5
		sub.w	d5,d3			; get length of second DMA
		movem.l	(sp)+,d4-d5

Add_To_DMA_Queue_Do:
	endif

		movea.w	(DMA_queue_slot).w,a1
		cmpa.w	#DMA_queue_slot,a1	; is the queue full?
		beq.s	Add_To_DMA_Queue_Done	; if it is, return

		move.w	#$9300,d0
		move.b	d3,d0
		move.w	d0,(a1)+		; command to specify transfer length in words & $00FF

		move.w	#$9400,d0
		lsr.w	#8,d3
		move.b	d3,d0
		move.w	d0,(a1)+		; command to specify transfer length in words & $FF00

		move.w	#$9500,d0
		lsr.l	#1,d1
		move.b	d1,d0
		move.w	d0,(a1)+		; command to specify transfer source & $0001FE

		move.w	#$9600,d0
		lsr.l	#8,d1
		move.b	d1,d0
		move.w	d0,(a1)+		; command to specify transfer source & $01FE00

		move.w	#$9700,d0
		lsr.l	#8,d1
		andi.b	#$7F,d1			; this instruction safely allows source to be in RAM; S2's lacks this
		move.b	d1,d0
		move.w	d0,(a1)+		; command to specify transfer source & $FE0000

		andi.l	#$FFFF,d2
		lsl.l	#2,d2
		lsr.w	#2,d2
		swap	d2
		ori.l	#vdpComm($0000,VRAM,DMA),d2
		move.l	d2,(a1)+		; command to specify transfer destination and begin DMA

		move.w	a1,(DMA_queue_slot).w	; set new free slot address
		cmpa.w	#DMA_queue_slot,a1	; has the end of the queue been reached?
		beq.s	Add_To_DMA_Queue_Done	; if it has, branch
		clr.w	(a1)			; place stop token at the end of the queue

Add_To_DMA_Queue_Done:
		rts
; ---------------------------------------------------------------------------
; Clears the Nemesis decompression queue and its associated variables
; ---------------------------------------------------------------------------

Clear_KosM_Queue:
		lea	Kos_module_queue.w,a2

	if Kos_module_queue_size&2
		clr.w	(a2)+
	endif

	rept Kos_module_queue_size/4
		clr.l	(a2)+
	endm
		rts
; ---------------------------------------------------------------------------
; Adds pattern load requests to the Nemesis decompression queue
; Input: d0 = ID of the PLC to load
; ---------------------------------------------------------------------------

Load_PLC_Raw:
		movem.l	a1-a2,-(sp)		; NAT: Custom routines
		bra.s	Load_PLC.common
; ---------------------------------------------------------------------------

Load_PLC_2:
		movem.l	a1-a2,-(sp)
		bsr.s	Clear_KosM_Queue
		bra.s	Load_PLC.x
; ---------------------------------------------------------------------------

Load_PLC:
		movem.l	a1-a2,-(sp)
.x		lea	Offs_PLC.l,a1
		add.w	d0,d0
		move.w	(a1,d0.w),d0
		lea	(a1,d0.w),a1

.common		lea	Kos_module_queue.w,a2
		move.w	(a1)+,d6		; get piece count
		bmi.s	.done
		tst.l	(a2)			; is the first slot free?
		beq.s	.queue			; if yes, branch

.findFreeSlot	addq.w	#6,a2			; otherwise check the next slot
		tst.l	(a2)			; is the current slot in the queue free?
		bne.s	.findFreeSlot		; if no, branch
		bra.s	.queuePieces
; ---------------------------------------------------------------------------

.queue		move.l	(a1)+,d0		; get address
		move.w	(a1)+,d2		; get VRAM
		move.l	a1,-(sp)		; store a1

		move.l	d0,a1			; copy a1 from d0
		bsr.w	Process_Kos_Module_Queue_Init; init this one now
		move.l	(sp)+,a1		; get a1 back

		addq.w	#6,a2			; go to the next slot
		subq.w	#1,d6			; decrease count
		bmi.s	.done			; branc if completed

.queuePieces	move.l	(a1)+,(a2)+		; store compressed data location
		move.w	(a1)+,(a2)+		; store destination in VRAM
		dbf	d6,.queuePieces

.done	; NAT: TEMPORARY
	;	tst.w	Kos_module_Error.w	; NAT: Check if we loaded too many plc's
	;	bne.s	.error			; branch if error

		movem.l	(sp)+,a1-a2
		rts

.error;		trap	#0			; we trigger trap0
; ---------------------------------------------------------------------------
; Adds Kosinski-compressed data to the decompression queue
; Inputs:
; a1 = compressed data address
; a2 = decompression destination in RAM
; ---------------------------------------------------------------------------

Queue_Kos:
	move.w	(Kos_decomp_queue_count).w,d0
	lsl.w	#3,d0
	lea	(Kos_decomp_queue).w,a3
	move.l	a1,(a3,d0.w)			; store source
	move.l	a2,4(a3,d0.w)			; store destination
	addq.w	#1,(Kos_decomp_queue_count).w
	rts
; ---------------------------------------------------------------------------
; Adds a Kosinski Moduled archive to the module queue
; Inputs:
; a1 = address of the archive
; d2 = destination in VRAM
; ---------------------------------------------------------------------------

Queue_Kos_Module:
	lea	(Kos_module_queue).w,a2
	tst.l	(a2)				; is the first slot free?
	beq.w	Process_Kos_Module_Queue_Init	; if it is, branch

.findFreeSlot:
	addq.w	#6,a2				; otherwise, check next slot
	tst.l	(a2)
	bne.s	.findFreeSlot

	move.l	a1,(a2)+			; store source address
	move.w	d2,(a2)+			; store destination VRAM address
	rts
; ---------------------------------------------------------------------------
; Processes the first module on the queue
; ---------------------------------------------------------------------------

Process_Kos_Module_Queue:
	tst.b	(Kos_modules_left).w
	beq.s	.done
	bmi.s	.decompressionStarted

	cmpi.w	#4,(Kos_decomp_queue_count).w
	bcc.s	.done				; branch if the Kosinski decompression queue is full
	movea.l (Kos_module_queue).w,a1
	lea	(Kos_decomp_buffer).w,a2
	jsr	Queue_Kos.w			; add current module to decompression queue
	ori.b	#$80,(Kos_modules_left).w	; and set bit to signify decompression in progress
.done	rts
; ---------------------------------------------------------------------------

.decompressionStarted:
	tst.w	(Kos_decomp_queue_count).w
	bne.s	.done				; branch if the decompression isn't complete

	; otherwise, DMA the decompressed data to VRAM
	andi.b	#$7F,(Kos_modules_left).w
	move.w	#$800,d3
	subq.b	#1,(Kos_modules_left).w
	bne.s	.skip				; branch if it isn't the last module
	move.w	(Kos_last_module_size).w,d3

.skip	move.w	(Kos_module_destination).w,d2
	move.w	d2,d0
	add.w	d3,d0
	add.w	d3,d0
	move.w	d0,(Kos_module_destination).w	; set new destination
	move.l	(Kos_module_queue).w,d0
	move.l	(Kos_decomp_queue).w,d1
	sub.l	d1,d0
	andi.l	#$F,d0
	add.l	d0,d1				; round to the nearest $10 boundary
	move.l	d1,(Kos_module_queue).w 	; and set new source
	move.l	#Kos_decomp_buffer,d1
	jsr	Add_To_DMA_Queue.w
	tst.b	(Kos_modules_left).w
	bne.s	.done				; return if this wasn't the last module
	lea	(Kos_module_queue).w,a0
	lea	(Kos_module_queue+6).w,a1

	rept (Kos_module_queue_size-6)/4
		move.l	(a1)+,(a0)+		; otherwise, shift all entries up
	endm

	if (Kos_module_queue_size-6)&2
		move.w	(a1)+,(a0)+
	endif

	moveq	#0,d0
	move.l	d0,(a0)+			; and mark the last slot as free
	move.w	d0,(a0)+
	move.l	(Kos_module_queue).w,d0
	beq.w	.done				; return if the queue is now empty
	movea.l d0,a1
	move.w	(Kos_module_destination).w,d2
; ---------------------------------------------------------------------------
; Initializes processing of the first module on the queue
; ---------------------------------------------------------------------------

Process_Kos_Module_Queue_Init:
	move.w	(a1)+,d3			; get uncompressed size
	cmpi.w	#$A000,d3
	bne.s	.gotsize
	move.w	#$8000,d3			; $A000 means $8000 for some reason

.gotsize:
	lsr.w	#1,d3
	move.w	d3,d0
	rol.w	#5,d0
	andi.w	#$1F,d0				 ; get number of complete modules
	move.b	d0,(Kos_modules_left).w
	andi.w	#$7FF,d3			; get size of last module in words
	bne.s	.gotleftover			; branch if it's non-zero
	subq.b	#1,(Kos_modules_left).w 	; otherwise decrement the number of modules
	move.w	#$800,d3			; and take the size of the last module to be $800 words

.gotleftover:
	move.w	d3,(Kos_last_module_size).w
	move.w	d2,(Kos_module_destination).w
	move.l	a1,(Kos_module_queue).w
	addq.b	#1,(Kos_modules_left).w		; store total number of modules
	rts
; ---------------------------------------------------------------------------

Clear_Switches:
		lea	(Level_trigger_array).w,a1
		moveq	#7,d0

loc_4F8FE:
		clr.l	(a1)+
		dbf	d0,loc_4F8FE
		rts
; ---------------------------------------------------------------------------

ShakeScreen_Setup:
		move.w	(ScrShake_Offset).w,(ScrShake_Offset_Prev).w
		moveq	#0,d1
		move.w	(ScrShake_Value).w,d0
		beq.s	loc_4F406
		bmi.s	loc_4F3FA
		subq.w	#1,d0				; If EECC is positive, then it's a timed screen shake
		move.w	d0,(ScrShake_Value).w
		move.b	ScreenShakeArray(pc,d0.w),d1
		ext.w	d1
		bra.s	loc_4F406
; ---------------------------------------------------------------------------

loc_4F3FA:
		move.w	(Level_frame_counter).w,d0	; If EECC is negative, it's a constant screen shake
		andi.w	#$3F,d0
		move.b	ScreenShakeArray2(pc,d0.w),d1

loc_4F406:
		move.w	d1,(ScrShake_Offset).w
		rts
; ---------------------------------------------------------------------------

ShakeScreen_BG:
		move.w	(ScrShake_Value_BG).w,d0
		beq.s	locret_4F422
		subq.w	#1,d0
		move.w	d0,(ScrShake_Value_BG).w
		move.b	ScreenShakeArray(pc,d0.w),d0
		ext.w	d0
		add.w	d0,(Camera_X_pos_copy).w

locret_4F422:
		rts

; ---------------------------------------------------------------------------
ScreenShakeArray:	dc.b 1,$FF,1,$FF,2,$FE,2,$FE,3,$FD,3,$FD,4,$FC,4,$FC,5,$FB,5,$FB
ScreenShakeArray2:     dc.b   1,  2,  1,  3,  1,  2,  2,  1,  2,  3,  1,  2,  1,  2,  0,  0
		dc.b   2,  0,  3,  2,  2,  3,  2,  2,  1,  3,  0,  0,  1,  0,  1,  3
		dc.b   1,  2,  1,  3,  1,  2,  2,  1,  2,  3,  1,  2,  1,  2,  0,  0
		dc.b   2,  0,  3,  2,  2,  3,  2,  2,  1,  3,  0,  0,  1,  0,  1,  3
		dc.w     1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    0,    0,    0,    0
		dc.w     0,    0,    0,    0,    0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
		dc.w $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    0
		dc.w     0,    0,    0,    0,    0,    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1
		dc.w     1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    0,    0,    0,    0
		dc.w     0,    0,    0,    0,    0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
		dc.w $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    0
		dc.w     0,    0,    0,    0,    0,    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1
		dc.w     1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    0,    0,    0,    0
		dc.w     0,    0,    0,    0,    0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
		dc.w $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    0
		dc.w     0,    0,    0,    0,    0,    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1
		dc.w     1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    0,    0,    0,    0
		dc.w     0,    0,    0,    0,    0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
		dc.w $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    0
		dc.w     0,    0,    0,    0,    0,    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1
		dc.w     1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    0,    0,    0,    0
		dc.w     0,    0,    0,    0,    0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
		dc.w     0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    1,    1,    1,    1,    1
		dc.w     1,    0,    0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    1,    1,    1
		dc.w     1,    1,    1,    0,    0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    1
		dc.w     1,    1,    1,    1,    1,    0,$FFFF,$FFFE,$FFFE,$FFFF,    0,    2,    2,    2,    2,    0
		dc.w     0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    1,    1,    1,    1,    1
		dc.w     1,    0,    0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    1,    1,    1
; ---------------------------------------------------------------------------
; Generates a pseudo-random number in d0
; ---------------------------------------------------------------------------

Random_Number:
		move.l	(RNG_seed).w,d1
		tst.w	d1
		bne.s	+
		move.l	#$2A6D365B,d1		; reset seed if needed
+
		move.l	d1,d0
		asl.l	#2,d1
		add.l	d0,d1
		asl.l	#3,d1
		add.l	d0,d1
		move.w	d1,d0
		swap	d1
		add.w	d1,d0
		move.w	d0,d1
		swap	d1
		move.l	d1,(RNG_seed).w
		rts
; ---------------------------------------------------------------------------
; Calculates the arctangent of y/x and returns it in d0 (360 degrees = 256)
; Inputs: d1 = input x, d2 = input y
; ---------------------------------------------------------------------------

GetArcTan:
		movem.l	d3-d4,-(sp)
		moveq	#0,d3
		moveq	#0,d4
		move.w	d1,d3
		move.w	d2,d4
		or.w	d3,d4
		beq.s	GetArcTan_Zero		; special case when both x and y are zero
		move.w	d2,d4
		tst.w	d3
		bpl.s	+
		neg.w	d3
+
		tst.w	d4
		bpl.s	+
		neg.w	d4
+
		cmp.w	d3,d4
		bhs.s	+			; if |y| >= |x|
		lsl.l	#8,d4
		divu.w	d3,d4
		moveq	#0,d0
		move.b	ArcTanTable(pc,d4.w),d0
		bra.s	++
+
		lsl.l	#8,d3
		divu.w	d4,d3
		moveq	#$40,d0
		sub.b	ArcTanTable(pc,d3.w),d0	; arctan(y/x) = 90 - arctan(x/y)
+
		tst.w	d1
		bpl.s	+
		neg.w	d0
		addi.w	#$80,d0			; place angle in appropriate quadrant
+
		tst.w	d2
		bpl.s	+
		neg.w	d0
		addi.w	#$100,d0		; place angle in appropriate quadrant
+
		movem.l	(sp)+,d3-d4
		rts
; ---------------------------------------------------------------------------

GetArcTan_Zero:
		move.w	#$40,d0			; angle = 90 degrees
		movem.l	(sp)+,d3-d4
		rts

; ---------------------------------------------------------------------------
ArcTanTable:	binclude "Levels/Misc/arctan.bin"
		even
; ---------------------------------------------------------------------------
; Calculates the sine and cosine of the angle in d0 (360 degrees = 256)
; Returns the sine in d0 and the cosine in d1 (both multiplied by $100)
; ---------------------------------------------------------------------------

GetSineCosine:
		andi.w	#$FF,d0
		addq.w	#8,d0
		add.w	d0,d0
		move.w	SineTable+$80-16(pc,d0.w),d1
		move.w	SineTable-16(pc,d0.w),d0
		rts

; ---------------------------------------------------------------------------
SineTable:	binclude "Levels/Misc/sine.bin"
		even
; ---------------------------------------------------------------------------

GetFloorPosition_BG:
		lea	(Level_layout_header).w,a1
		move.w	d2,d0
		lsr.w	#5,d0
		and.w	(Layout_row_index_mask).w,d0
		move.w	$A(a1,d0.w),d0
		move.w	d3,d1
		lsr.w	#3,d1
		move.w	d1,d4
		lsr.w	#4,d1
		add.w	d1,d0
		moveq	#-1,d1
		clr.w	d1
		movea.w	d0,a1
		move.b	(a1),d1
		add.w	d1,d1
		move.w	ChunkAddrArray(pc,d1.w),d1
		move.w	d2,d0
		andi.w	#$70,d0
		add.w	d0,d1
		andi.w	#$E,d4
		add.w	d4,d1
		movea.l	d1,a1
		rts
; ---------------------------------------------------------------------------

GetFloorPosition_FG:
		lea	(Level_layout_header).w,a1
		move.w	d2,d0
		lsr.w	#5,d0
		and.w	(Layout_row_index_mask).w,d0
		move.w	8(a1,d0.w),d0
		move.w	d3,d1
		lsr.w	#3,d1
		move.w	d1,d4
		lsr.w	#4,d1
		add.w	d1,d0
		moveq	#-1,d1
		clr.w	d1
		movea.w	d0,a1
		move.b	(a1),d1
		add.w	d1,d1
		move.w	ChunkAddrArray(pc,d1.w),d1
		move.w	d2,d0
		andi.w	#$70,d0
		add.w	d0,d1
		andi.w	#$E,d4
		add.w	d4,d1
		movea.l	d1,a1
		rts
; ---------------------------------------------------------------------------
ChunkAddrArray:	dc.w	 0,  $80, $100,	$180, $200, $280, $300,	$380, $400, $480, $500,	$580, $600, $680, $700,	$780
		dc.w  $800, $880, $900,	$980, $A00, $A80, $B00,	$B80, $C00, $C80, $D00,	$D80, $E00, $E80, $F00,	$F80
		dc.w $1000,$1080,$1100,$1180,$1200,$1280,$1300,$1380,$1400,$1480,$1500,$1580,$1600,$1680,$1700,$1780
		dc.w $1800,$1880,$1900,$1980,$1A00,$1A80,$1B00,$1B80,$1C00,$1C80,$1D00,$1D80,$1E00,$1E80,$1F00,$1F80
		dc.w $2000,$2080,$2100,$2180,$2200,$2280,$2300,$2380,$2400,$2480,$2500,$2580,$2600,$2680,$2700,$2780
		dc.w $2800,$2880,$2900,$2980,$2A00,$2A80,$2B00,$2B80,$2C00,$2C80,$2D00,$2D80,$2E00,$2E80,$2F00,$2F80
		dc.w $3000,$3080,$3100,$3180,$3200,$3280,$3300,$3380,$3400,$3480,$3500,$3580,$3600,$3680,$3700,$3780
		dc.w $3800,$3880,$3900,$3980,$3A00,$3A80,$3B00,$3B80,$3C00,$3C80,$3D00,$3D80,$3E00,$3E80,$3F00,$3F80
		dc.w $4000,$4080,$4100,$4180,$4200,$4280,$4300,$4380,$4400,$4480,$4500,$4580,$4600,$4680,$4700,$4780
		dc.w $4800,$4880,$4900,$4980,$4A00,$4A80,$4B00,$4B80,$4C00,$4C80,$4D00,$4D80,$4E00,$4E80,$4F00,$4F80
		dc.w $5000,$5080,$5100,$5180,$5200,$5280,$5300,$5380,$5400,$5480,$5500,$5580,$5600,$5680,$5700,$5780
		dc.w $5800,$5880,$5900,$5980,$5A00,$5A80,$5B00,$5B80,$5C00,$5C80,$5D00,$5D80,$5E00,$5E80,$5F00,$5F80
		dc.w $6000,$6080,$6100,$6180,$6200,$6280,$6300,$6380,$6400,$6480,$6500,$6580,$6600,$6680,$6700,$6780
		dc.w $6800,$6880,$6900,$6980,$6A00,$6A80,$6B00,$6B80,$6C00,$6C80,$6D00,$6D80,$6E00,$6E80,$6F00,$6F80
		dc.w $7000,$7080,$7100,$7180,$7200,$7280,$7300,$7380,$7400,$7480,$7500,$7580,$7600,$7680,$7700,$7780
		dc.w $7800,$7880,$7900,$7980,$7A00,$7A80,$7B00,$7B80,$7C00,$7C80,$7D00,$7D80,$7E00,$7E80,$7F00,$7F80
; ---------------------------------------------------------------------------

		message "Lib ends at $\{*}!"
