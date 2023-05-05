Obj_SuperSonicKnux_Stars:
		move.l	#ArtUnc_SuperSonicKnux_Stars,d1
		move.w	#$F380,d2
		move.w	#$1A0,d3
		jsr	AddQueueDMA
		move.l	#Map_SuperSonicKnux_Stars,$C(a0)
		move.b	#4,4(a0)
		move.w	#$80,8(a0)
		move.b	#$18,7(a0)
		move.b	#$18,6(a0)
		move.w	#$79C,$A(a0)
		btst	#7,Object_RAM+tile.w
		beq.s	loc_1919E
		bset	#7,$A(a0)

loc_1919E:
		move.l	#loc_191A4,(a0)

loc_191A4:
		tst.b	Super_Flag.w
		beq.w	loc_19230
		tst.b	$20(a0)
		beq.s	loc_191B6
		bsr.w	sub_19236


; ---------------------------------------------------------------------------

loc_191B6:
		tst.b	$34(a0)
		beq.s	loc_19200
		subq.b	#1,$24(a0)
		bpl.s	loc_191E8
		move.b	#1,$24(a0)
		addq.b	#1,$22(a0)
		cmpi.b	#6,$22(a0)
		blo.s	loc_191E8
		move.b	#0,$22(a0)
		move.b	#0,$34(a0)
		move.b	#1,$35(a0)
		rts

loc_191E8:
		tst.b	$35(a0)
		bne.s	loc_191FA

loc_191EE:
		move.w	Object_RAM+xpos.w,$10(a0)
		move.w	Object_RAM+ypos.w,$14(a0)


; ---------------------------------------------------------------------------

loc_191FA:
		jmp	DrawSprite

loc_19200:
		tst.b	Object_RAM+$2E.w
		bne.s	loc_19222
		move.w	Object_RAM+$1C.w,d0
		bpl.s	loc_1920E
		neg.w	d0


; ---------------------------------------------------------------------------

loc_1920E:
		cmpi.w	#$800,d0
		blo.s	loc_19222
		move.b	#0,$22(a0)
		move.b	#1,$34(a0)
		bra.s	loc_191EE


; ---------------------------------------------------------------------------

loc_19222:
		move.b	#0,$34(a0)
		move.b	#0,$35(a0)
		rts


; ############### S U B	R O U T	I N E #######################################

loc_19230:
		jmp	DeleteObject_This

sub_19236:
		move.b	#0,$20(a0)
		lea	Object_RAM.w,a2
		moveq	#$F,d5
		move.w	#$488,d4

loc_19246:
		bsr.w	CreateObject
		bne.w	locret_192BE
		move.l	#Obj_SuperSonicKnux_Stars_Timer,(a1)
		move.w	$10(a2),$10(a1)
		move.w	$14(a2),$14(a1)
		move.l	#Map_SuperSonicKnux_Stars2,$C(a1)
		move.w	#$879C,$A(a1)
		move.b	#$84,4(a1)
		move.w	#$380,8(a1)
		move.b	#8,7(a1)
		move.b	#8,6(a1)
		tst.w	d4
		bmi.s	loc_192AE
		move.w	d4,d0
		jsr	GetSine
		move.w	d4,d2
		lsr.w	#8,d2
		asl.w	d2,d0
		asl.w	d2,d1
		move.w	d0,d2
		move.w	d1,d3
		addi.b	#$10,d4
		bhs.s	loc_192AE
		subi.w	#$80,d4
		bhs.s	loc_192AE
		move.w	#$488,d4

loc_192AE:
		move.w	d2,$18(a1)
		move.w	d3,$1A(a1)
		neg.w	d2
		neg.w	d4
		dbf	d5,loc_19246


; End of function sub_19236
; ---------------------------------------------------------------------------

locret_192BE:
		rts


; ---------------------------------------------------------------------------

Obj_SuperSonicKnux_Stars_Timer:
		tst.b	4(a0)
		bmi.s	loc_192CC
		jmp	DeleteObject_This


; ---------------------------------------------------------------------------

loc_192CC:
		addq.b	#1,$22(a0)
		andi.b	#3,$22(a0)
		bsr.w	ObjectMove
		bra.w	DrawSprite

Map_SuperSonicKnux_Stars:
		dc.w word_192F2-Map_SuperSonicKnux_Stars
		dc.w word_192F4-Map_SuperSonicKnux_Stars
		dc.w word_192FC-Map_SuperSonicKnux_Stars
		dc.w word_19316-Map_SuperSonicKnux_Stars
		dc.w word_192FC-Map_SuperSonicKnux_Stars
		dc.w word_192F4-Map_SuperSonicKnux_Stars

Map_SuperSonicKnux_Stars2:
		dc.w word_19330-Map_SuperSonicKnux_Stars2
		dc.w word_19338-Map_SuperSonicKnux_Stars2
		dc.w word_19330-Map_SuperSonicKnux_Stars2
		dc.w word_19340-Map_SuperSonicKnux_Stars2

word_192F2:
		dc.w 0

word_192F4:
		dc.w 1
		dc.b  $F8,   5,	  0,   0, $FF, $F8

word_192FC:
		dc.w 4
		dc.b  $F0,   5,	  0,   4, $FF, $F0
		dc.b  $F0,   5,	  8,   4,   0,	 0
		dc.b	0,   5,	$10,   4, $FF, $F0
		dc.b	0,   5,	$18,   4,   0,	 0

word_19316:
		dc.w 4
		dc.b  $E8,  $A,	  0,   8, $FF, $E8
		dc.b  $E8,  $A,	  8,   8,   0,	 0
		dc.b	0,  $A,	$10,   8, $FF, $E8
		dc.b	0,  $A,	$18,   8,   0,	 0

word_19330:
		dc.w 1
		dc.b  $FC,   0,	  0, $11, $FF, $FC

word_19338:
		dc.w 1
		dc.b  $F8,   5,	  0, $12, $FF, $F8


; ---------------------------------------------------------------------------

word_19340:
		dc.w 1
		dc.b  $F8,   5,	  0, $16, $FF, $F8

Obj_HyperSonic_19348:
		lea	ArtKosM_HyperSonic,a1
		move.w	#$F380,d2
		jsr	Queue_Kos_Module
		lea	(a0),a1
		moveq	#0,d0
		moveq	#0,d2
		moveq	#3,d1

loc_19360:
		move.l	#loc_1937C,(a1)
		move.b	d0,$26(a1)
		addi.b	#$40,d0
		addq.b	#1,d2
		move.b	d2,$24(a1)
		lea	$4A(a1),a1
		dbf	d1,loc_19360

loc_1937C:
		tst.b	Kos_modules_left.w
		beq.s	loc_19384


; ---------------------------------------------------------------------------

locret_19382:
		rts


; ---------------------------------------------------------------------------

loc_19384:
		subq.b	#1,$24(a0)
		bne.s	locret_19382
		move.l	#Map_HyperSonic_1948C,$C(a0)
		move.b	#4,4(a0)
		move.w	#$80,8(a0)
		move.b	#$18,7(a0)
		move.b	#$18,6(a0)
		move.w	#$79C,$A(a0)
		move.b	#6,$22(a0)
		cmpa.w	#Obj_shield&$FFFF,a0
		beq.s	loc_193C4
		move.l	#loc_193EC,(a0)
		bra.s	loc_193EC

loc_193C4:
		move.l	#loc_193CA,(a0)

loc_193CA:
		tst.b	$20(a0)
		beq.s	loc_193EC
		clr.b	$20(a0)
		move.w	Object_RAM+xpos.w,$10(a0)
		move.w	Object_RAM+ypos.w,$14(a0)
		moveq	#2,d2
		bsr.w	HyperSonicSparks_Create
		move.b	#4,Flash_Timer.w

loc_193EC:
		tst.b	Super_Flag.w
		beq.w	loc_19486
		subq.b	#1,$24(a0)
		bpl.s	loc_1941C
		move.b	#1,$24(a0)
		addq.b	#1,$22(a0)
		cmpi.b	#3,$22(a0)
		blo.s	loc_1941C
		move.b	#0,$22(a0)
		moveq	#0,d0
		move.w	d0,$30(a0)
		move.w	d0,$34(a0)

loc_1941C:
		move.b	$26(a0),d0
		addi.b	#-$10,$26(a0)
		jsr	GetSine
		asl.w	#3,d0
		asl.w	#3,d1
		move.w	d0,$18(a0)
		move.w	d1,$1A(a0)
		move.w	$18(a0),d0
		add.w	d0,$30(a0)
		move.w	$1A(a0),d1
		add.w	d1,$34(a0)
		move.b	$30(a0),d2
		ext.w	d2
		btst	#0,Object_RAM+$2A.w
		beq.s	loc_19458
		neg.w	d2

loc_19458:
		move.b	$34(a0),d3
		ext.w	d3
		add.w	Object_RAM+xpos.w,d2
		add.w	Object_RAM+ypos.w,d3
		move.w	d2,$10(a0)
		move.w	d3,$14(a0)
		andi.w	#$7FFF,$A(a0)
		tst.b	Object_RAM+tile.w
		bpl.s	loc_19480
		ori.w	#$8000,$A(a0)


; ---------------------------------------------------------------------------

loc_19480:
		jmp	DrawSprite


; ---------------------------------------------------------------------------

loc_19486:
		jmp	DeleteObject_This

Map_HyperSonic_1948C:
		dc.w word_19498-Map_HyperSonic_1948C
		dc.w word_194A0-Map_HyperSonic_1948C
		dc.w word_194A8-Map_HyperSonic_1948C
		dc.w word_194B6-Map_HyperSonic_1948C
		dc.w word_194BE-Map_HyperSonic_1948C
		dc.w word_194C6-Map_HyperSonic_1948C

word_19498:
		dc.w 1
		dc.b  $F8,   5,	  0,   0, $FF, $F8

word_194A0:
		dc.w 1
		dc.b  $F8,   5,	  0,   4, $FF, $F8

word_194A8:
		dc.w 2
		dc.b  $F0,  $D,	  0,   8, $FF, $F0
		dc.b	0,  $D,	$10,   8, $FF, $F0

word_194B6:
		dc.w 1
		dc.b  $F8,   5,	  0, $10, $FF, $F8

word_194BE:
		dc.w 1
		dc.b  $F4,   6,	  0, $14, $FF, $F8

word_194C6:
		dc.w 1
		dc.b  $F4,  $A,	  0, $1A, $FF, $F4
; ---------------------------------------------------------------------------

Obj_HyperTails_Birds:
		lea	ArtKosM_SuperTailsBirds,a1
		move.w	#$D000,d2
		jsr	Queue_Kos_Module
		lea	(a0),a1
		moveq	#0,d0
		moveq	#3,d1

loc_1A186:
		move.l	#loc_1A19C,(a1)
		move.b	d0,$34(a1)
		addi.b	#$40,d0
		lea	$4A(a1),a1
		dbf	d1,loc_1A186


; ---------------------------------------------------------------------------

loc_1A19C:
		tst.b	Kos_modules_left.w
		beq.s	loc_1A1A4
		rts

loc_1A1A4:
		move.l	#Map_HyperTails_Birds,mappings(a0)
		move.b	#4,4(a0)
		move.w	#$80,8(a0)
		move.b	#8,7(a0)
		move.b	#8,6(a0)
		move.w	#$8680,$A(a0)
		move.w	Object_RAM+xpos.w,$10(a0)
		move.w	Object_RAM+ypos.w,$14(a0)
		subi.w	#$C0,$10(a0)
		subi.w	#$C0,$14(a0)
		move.w	#0,$18(a0)
		move.w	#0,$1A(a0)
		move.l	#loc_1A1F4,(a0)

loc_1A1F4:
		tst.b	Super_Tails_Flag.w
		bne.s	loc_1A226
		moveq	#0,d0
		move.w	d0,Obj_player_2+$10.w
		move.w	d0,Obj_player_2+$14.w
		move.b	d0,Obj_player_2+$20.w
		tst.b	$30(a0)
		beq.s	loc_1A216
		movea.w	$42(a0),a1
		move.b	d0,$2D(a1)

loc_1A216:
		move.b	d0,$30(a0)
		move.b	#$78,$32(a0)
		move.l	#loc_1A276,(a0)

loc_1A226:
		bsr.s	sub_1A292


; ---------------------------------------------------------------------------

loc_1A228:
		bsr.w	sub_1A37A
		addi.b	#2,$34(a0)
		tst.w	$18(a0)
		beq.s	loc_1A248
		bpl.s	loc_1A242
		bset	#0,4(a0)
		bra.s	loc_1A248

loc_1A242:
		bclr	#0,4(a0)

loc_1A248:
		andi.b	#-3,4(a0)
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_1A25A
		ori.b	#2,4(a0)

loc_1A25A:
		subq.b	#1,$24(a0)
		bpl.s	loc_1A270
		move.b	#1,$24(a0)
		addq.b	#1,$22(a0)
		andi.b	#1,$22(a0)


; ---------------------------------------------------------------------------

loc_1A270:
		jmp	DrawSprite


; ############### S U B	R O U T	I N E #######################################

loc_1A276:
		move.w	Object_RAM+xpos.w,d2
		move.w	Object_RAM+ypos.w,d3
		subi.w	#$C0,d2
		subi.w	#$C0,d3
		tst.b	4(a0)
		bmi.s	loc_1A228
		jmp	DeleteObject_This


; ---------------------------------------------------------------------------

sub_1A292:
		tst.b	$30(a0)
		bne.s	loc_1A2D6
		tst.b	$32(a0)
		beq.s	loc_1A2A4
		subq.b	#1,$32(a0)
		bra.s	loc_1A2AC

loc_1A2A4:
		bsr.w	sub_1A3FE
		tst.w	d1
		bne.s	loc_1A2D6

loc_1A2AC:
		move.b	$34(a0),d0
		jsr	GetSine
		asr.w	#3,d0
		asr.w	#4,d1
		move.w	Object_RAM+xpos.w,d2
		move.w	Object_RAM+ypos.w,d3
		subi.w	#$20,d3
		tst.b	ReverseGravity_Flag.w
		beq.s	loc_1A2D0
		addi.w	#$40,d3


; ---------------------------------------------------------------------------

loc_1A2D0:
		add.w	d0,d2
		add.w	d1,d3
		rts

loc_1A2D6:
		movea.w	$42(a0),a1
		move.w	$10(a1),d2
		move.w	$14(a1),d3
		tst.b	4(a1)
		bpl.s	loc_1A30A
		move.w	$10(a0),d0
		sub.w	d2,d0
		addi.w	#$C,d0
		cmpi.w	#$18,d0
		bhs.s	locret_1A31C
		move.w	$14(a0),d1
		sub.w	d3,d1
		addi.w	#$C,d1
		cmpi.w	#$18,d1
		bhs.s	locret_1A31C
		bsr.s	sub_1A31E

loc_1A30A:
		move.b	#0,$2D(a1)
		move.b	#0,$30(a0)
		move.b	#$78,$32(a0)


; End of function sub_1A292
; ############### S U B	R O U T	I N E #######################################

locret_1A31C:
		rts

sub_1A31E:
		move.b	$28(a1),d0
		beq.s	locret_1A330
		andi.b	#$C0,d0
		beq.s	loc_1A332
		cmpi.b	#$C0,d0
		beq.s	loc_1A360


; ---------------------------------------------------------------------------

locret_1A330:
		rts

loc_1A332:
		tst.b	$29(a1)
		beq.s	loc_1A35A
		move.b	$28(a1),$25(a1)
		move.w	#Obj_player_2&$FFFF,d0
		move.b	d0,$1C(a1)
		move.b	#0,$28(a1)
		subq.b	#1,$29(a1)
		bne.s	loc_1A358
		bset	#7,$2A(a1)


; ---------------------------------------------------------------------------

loc_1A358:
		bra.s	loc_1A366


; ---------------------------------------------------------------------------

loc_1A35A:
		jmp	HyperTouch_DestroyEnemy

loc_1A360:
		ori.b	#2,$29(a1)


; End of function sub_1A31E
; ############### S U B	R O U T	I N E #######################################

loc_1A366:
		move.w	$10(a0),Obj_player_2+$10.w
		move.w	$14(a0),Obj_player_2+$14.w
		move.b	#2,Obj_player_2+$20.w
		rts


; ---------------------------------------------------------------------------

sub_1A37A:
		move.w	#$20,d1
		cmp.w	$10(a0),d2
		bge.s	loc_1A392
		neg.w	d1
		tst.w	$18(a0)
		bmi.s	loc_1A39C
		add.w	d1,d1
		add.w	d1,d1
		bra.s	loc_1A39C

loc_1A392:
		tst.w	$18(a0)
		bpl.s	loc_1A39C
		add.w	d1,d1
		add.w	d1,d1

loc_1A39C:
		add.w	d1,$18(a0)
		and.w	Screen_Y_wrap_value.w,d3
		move.w	#$20,d1
		sub.w	$14(a0),d3
		bhs.s	loc_1A3CA
		cmpi.w	#-$500,d3
		ble.s	loc_1A3D0

loc_1A3B4:
		cmpi.w	#-$1000,$1A(a0)
		ble.s	loc_1A3D8


; ---------------------------------------------------------------------------

loc_1A3BC:
		neg.w	d1
		tst.w	$1A(a0)
		bmi.s	loc_1A3E2
		add.w	d1,d1
		add.w	d1,d1
		bra.s	loc_1A3E2

loc_1A3CA:
		cmpi.w	#$500,d3
		bge.s	loc_1A3B4

loc_1A3D0:
		cmpi.w	#$1000,$1A(a0)
		bge.s	loc_1A3BC

loc_1A3D8:
		tst.w	$1A(a0)
		bpl.s	loc_1A3E2
		add.w	d1,d1
		add.w	d1,d1


; End of function sub_1A37A
; ############### S U B	R O U T	I N E #######################################

loc_1A3E2:
		add.w	d1,$1A(a0)
		jsr	ObjectMove
		move.w	AutoScroll_X_SubValue.w,d0
		sub.w	d0,$10(a0)
		move.w	Screen_Y_wrap_value.w,d0
		and.w	d0,$14(a0)
		rts

sub_1A3FE:
		moveq	#0,d1
		lea	Coll_response_list.w,a4
		move.w	(a4)+,d6
		beq.s	locret_1A432
		moveq	#0,d0
		addq.b	#2,Super_RingDrain_Counter.w
		cmp.b	Super_RingDrain_Counter.w,d6
		bhi.s	loc_1A41A
		move.b	#0,Super_RingDrain_Counter.w

loc_1A41A:
		move.b	Super_RingDrain_Counter.w,d0
		sub.w	d0,d6
		lea	(a4,d0.w),a4

loc_1A424:
		movea.w	(a4)+,a1
		move.b	$28(a1),d0
		beq.s	loc_1A42E
		bsr.s	sub_1A434

loc_1A42E:
		subq.w	#2,d6
		bne.s	loc_1A424


; End of function sub_1A3FE
; ############### S U B	R O U T	I N E #######################################

locret_1A432:
		rts

sub_1A434:
		tst.b	4(a1)
		bpl.s	locret_1A44C
		tst.b	$2D(a1)
		bne.s	locret_1A44C
		andi.b	#$C0,d0
		beq.s	loc_1A44E
		cmpi.b	#$C0,d0
		beq.s	loc_1A44E


; ---------------------------------------------------------------------------

locret_1A44C:
		rts


; End of function sub_1A434
; ---------------------------------------------------------------------------

loc_1A44E:
		move.b	#-1,$2D(a1)
		move.w	a1,$42(a0)
		move.b	#1,$30(a0)
		moveq	#1,d1
		moveq	#2,d6
		rts

Map_HyperTails_Birds:
		dc.w word_1A46A-Map_HyperTails_Birds
		dc.w word_1A472-Map_HyperTails_Birds
		dc.w word_1A47A-Map_HyperTails_Birds

word_1A46A:
		dc.w 1
		dc.b  $F8,   5,	  0,   6, $FF, $F8

word_1A472:
		dc.w 1
		dc.b  $F8,   5,	  0,  $A, $FF, $F8


; ---------------------------------------------------------------------------

word_1A47A:
		dc.w 1
		dc.b  $F4,   6,	  0,   0, $FF, $F8
		dc.w 1
		dc.b  $89, $ED,	  0,  $B
		dc.w 1
		dc.b  $8A,   2,	$16,  $D
		dc.w 1
		dc.b  $8A, $1B,	$2C,  $D

Obj_HyperSonicKnux_Trail:
		move.l	#Map_Knuckles,$C(a0)
		cmpi.w	#3,Player_Mode.w
		beq.s	loc_1A4AC
		move.l	#Map_SuperSonic,$C(a0)

loc_1A4AC:
		move.w	#$680,$A(a0)
		move.w	#$100,8(a0)
		move.b	#$18,7(a0)
		move.b	#$18,6(a0)
		move.b	#4,4(a0)
		move.l	#loc_1A4D0,(a0)

loc_1A4D0:
		tst.b	Super_Flag.w
		beq.w	DeleteObject_This
		moveq	#$C,d1
		btst	#0,Level_Frame_Timer+1.w
		beq.s	loc_1A4E4
		moveq	#$14,d1

loc_1A4E4:
		move.w	Sonic_Pos_Record_Index.w,d0
		lea	Position_table.w,a1
		sub.b	d1,d0
		lea	(a1,d0.w),a1
		move.w	(a1)+,$10(a0)
		move.w	(a1)+,$14(a0)
		lea	Position_table_P2.w,a1


; ---------------------------------------------------------------------------

loc_1A4FE:
		move.b	3(a1,d0.w),$A(a0)
		move.b	Object_RAM+$22.w,$22(a0)
		move.b	Object_RAM+4.w,4(a0)
		move.w	Object_RAM+8.w,8(a0)
		bra.w	DrawSprite


; ---------------------------------------------------------------------------
