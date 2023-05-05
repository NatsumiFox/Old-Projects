Obj_TitleCard:
		moveq	#0,d0
		move.b	5(a0),d0
		move.w	off_2D69E(pc,d0.w),d1
		jmp	off_2D69E(pc,d1.w)


; ---------------------------------------------------------------------------

off_2D69E:
		dc.w loc_2D6A6-off_2D69E
		dc.w loc_2D76A-off_2D69E
		dc.w loc_2D804-off_2D69E
		dc.w loc_2D856-off_2D69E

loc_2D6A6:
		cmpi.w	#$D01,Current_Zone.w
		beq.s	loc_2D6C2
		cmpi.b	#$E,Current_Zone.w
		blo.s	loc_2D6C8
		cmpi.b	#$12,Current_Zone.w
		bhi.s	loc_2D6C8
		st	$44(a0)


; ---------------------------------------------------------------------------

loc_2D6C2:
		jmp	DeleteObject_This

loc_2D6C8:
		lea	ArtKosM_TitleCardRedAct,a1
		move.w	#-$6000,d2
		jsr	Queue_Kos_Module
		lea	ArtKosM_TitleCardSKZone,a1
		tst.w	S3Active_Flag.w
		bne.s	loc_2D6EA
		lea	ArtKosM_TitleCardS3KZone,a1

loc_2D6EA:
		move.w	#-$5E00,d2
		jsr	Queue_Kos_Module
		lea	ArtKosM_TitleCardNum2,a1
		cmpi.w	#$1600,Current_Zone.w
		beq.s	loc_2D716
		cmpi.w	#$1700,Current_Zone.w
		beq.s	loc_2D716
		tst.b	Current_Act_Secondary.w
		bne.s	loc_2D716
		lea	ArtKosM_TitleCardNum1,a1

loc_2D716:
		move.w	#-$5860,d2
		jsr	Queue_Kos_Module
		lea	off_2DA16(pc),a1
		moveq	#9,d0
		cmpi.w	#$1600,Current_Zone.w
		beq.s	loc_2D746
		moveq	#$D,d0
		cmpi.w	#$1601,Current_Zone.w
		beq.s	loc_2D746
		moveq	#$B,d0
		cmpi.w	#$1700,Current_Zone.w
		beq.s	loc_2D746
		move.b	Current_Zone_Secondary.w,d0


; ---------------------------------------------------------------------------

loc_2D746:
		lsl.w	#2,d0
		movea.l	(a1,d0.w),a1
		move.w	#-$5660,d2
		jsr	Queue_Kos_Module
		move.w	#$5A,$2E(a0)
		clr.w	$32(a0)
		st	$48(a0)
		addq.b	#2,5(a0)
		rts

loc_2D76A:
		tst.b	Kos_Module_Count.w
		bne.w	locret_2D802
		jsr	CreateObjectAfter
		bne.w	locret_2D802
		cmpi.b	#$16,Current_Zone.w
		beq.s	loc_2D79A
		cmpi.w	#$1700,Current_Zone.w
		beq.s	loc_2D79A
		lea	ObjDat2_2DAB4(pc),a2
		moveq	#1,d1
		cmpi.b	#$13,Current_Zone.w
		bhs.s	loc_2D7AC

loc_2D79A:
		lea	ObjDat2_2DA6E(pc),a2
		moveq	#3,d1
		tst.b	$44(a0)
		beq.s	loc_2D7AC
		lea	ObjDat2_2DAA6(pc),a2
		moveq	#0,d1

loc_2D7AC:
		addq.w	#1,$30(a0)
		move.l	(a2)+,(a1)
		move.w	(a2)+,$46(a1)
		move.w	(a2)+,$10(a1)
		move.w	(a2)+,$14(a1)
		move.b	(a2)+,$22(a1)
		move.b	(a2)+,7(a1)
		move.w	(a2)+,d2
		move.b	d2,$28(a1)
		move.b	#$40,4(a1)
		move.l	#Map_TitleCard,$C(a1)
		move.w	a0,$48(a1)
		jsr	CreateObjFromLoader
		dbne	d1,loc_2D7AC
		tst.b	$3E(a0)
		beq.s	loc_2D7FE
		cmpi.b	#6,Current_Zone.w
		bne.s	loc_2D7FE
		moveq	#$25,d0
		jsr	LoadPLC

loc_2D7FE:
		addq.b	#2,5(a0)


; ---------------------------------------------------------------------------

locret_2D802:
		rts


; ---------------------------------------------------------------------------

loc_2D804:
		tst.w	$34(a0)
		beq.s	loc_2D810
		clr.w	$34(a0)
		rts

loc_2D810:
		tst.w	$3E(a0)
		beq.s	loc_2D84C
		clr.l	Timer.w
		clr.w	Ring_Count.w
		clr.w	Total_Rings_Collected.w
		clr.b	Get_Extra_Life_Flag.w
		clr.l	Player2_Timer.w
		clr.w	Player2_Ring_Count.w
		clr.w	Player2_Total_Rings_Collected.w
		st	Update_HUD_Timer.w
		st	Update_HUD_Rings.w
		move.b	#$1E,Object_RAM+$2C.w
		move.b	#$1E,Obj_player_2+$2C.w
		jsr	PlayZoneMusic


; ---------------------------------------------------------------------------

loc_2D84C:
		clr.w	$48(a0)
		addq.b	#2,5(a0)
		rts


; ---------------------------------------------------------------------------

loc_2D856:
		tst.w	$2E(a0)
		beq.s	loc_2D862
		subq.w	#1,$2E(a0)
		rts


; ---------------------------------------------------------------------------

loc_2D862:
		tst.w	$30(a0)
		beq.s	loc_2D86E
		addq.w	#1,$32(a0)
		rts

loc_2D86E:
		tst.b	$44(a0)
		bne.s	loc_2D8DC
		lea	PLC_Spikes,a1
		jsr	RawPLCEnqueue
		jsr	LoadEnemyArt(pc)
		jsr	LoadPLC_AnimalsAndExplosion

loc_2D8DC:
		jmp	DeleteObject_This


; ---------------------------------------------------------------------------

loc_2D8E2:
		movea.w	$48(a0),a1
		move.w	$32(a1),d0
		beq.s	loc_2D90A
		tst.b	4(a0)
		bmi.s	loc_2D8FC
		subq.w	#1,$30(a1)
		jmp	DeleteObject_This


; ---------------------------------------------------------------------------

loc_2D8FC:
		cmp.b	$28(a0),d0
		blo.s	loc_2D920
		subi.w	#$20,$14(a0)
		bra.s	loc_2D920

loc_2D90A:
		move.w	$14(a0),d0
		cmp.w	$46(a0),d0
		beq.s	loc_2D920
		addi.w	#$10,d0
		move.w	d0,$14(a0)
		st	$34(a1)


; ---------------------------------------------------------------------------

loc_2D920:
		move.b	#$70,6(a0)
		jmp	DrawSprite

loc_2D92C:
		move.b	Current_Zone_Secondary.w,d0
		add.b	d0,$22(a0)
		moveq	#$D,d0
		cmpi.w	#$1600,Current_Zone.w
		beq.s	loc_2D952
		moveq	#$11,d0
		cmpi.w	#$1601,Current_Zone.w
		beq.s	loc_2D952
		moveq	#$F,d0
		cmpi.w	#$1700,Current_Zone.w
		bne.s	loc_2D956

loc_2D952:
		move.b	d0,$22(a0)

loc_2D956:
		move.l	#loc_2D95C,(a0)


; ---------------------------------------------------------------------------

loc_2D95C:
		movea.w	$48(a0),a1
		move.w	$32(a1),d0
		beq.s	loc_2D984
		tst.b	4(a0)
		bmi.s	loc_2D976
		subq.w	#1,$30(a1)
		jmp	DeleteObject_This


; ---------------------------------------------------------------------------

loc_2D976:
		cmp.b	$28(a0),d0
		blo.s	loc_2D99A
		addi.w	#$20,$10(a0)
		bra.s	loc_2D99A

loc_2D984:
		move.w	$10(a0),d0
		cmp.w	$46(a0),d0
		beq.s	loc_2D99A
		subi.w	#$10,d0
		move.w	d0,$10(a0)
		st	$34(a1)


; ---------------------------------------------------------------------------

loc_2D99A:
		jmp	DrawSprite

loc_2D9A0:
		move.l	#loc_2D95C,(a0)
		cmpi.b	#$A,Current_Zone.w
		beq.s	loc_2D9BE
		cmpi.b	#$C,Current_Zone.w
		beq.s	loc_2D9BE
		cmpi.w	#$1601,Current_Zone.w
		bne.s	loc_2D95C


; ---------------------------------------------------------------------------

loc_2D9BE:
		movea.w	$48(a0),a1
		subq.w	#1,$30(a1)
		jmp	DeleteObject_This


; ---------------------------------------------------------------------------

loc_2D9CC:
		clr.b	4(a0)
		movea.w	$48(a0),a1
		move.w	$32(a1),d0
		beq.s	loc_2D9FA
		cmpi.w	#$20C,$10(a0)
		blo.s	loc_2D9EC
		subq.w	#1,$30(a1)
		jmp	DeleteObject_This


; ---------------------------------------------------------------------------

loc_2D9EC:
		cmp.b	$28(a0),d0
		blo.s	loc_2DA10
		addi.w	#$20,$10(a0)
		bra.s	loc_2DA10

loc_2D9FA:
		move.w	$10(a0),d0
		cmp.w	$46(a0),d0
		beq.s	loc_2DA10
		subi.w	#$10,d0
		move.w	d0,$10(a0)
		st	$34(a1)


; ---------------------------------------------------------------------------

loc_2DA10:
		jmp	DrawSprite

off_2DA16:
		dc.l ArtKosM_AIZTitleCard

ObjDat2_2DA6E:
		dc.l loc_2D92C
		dc.w $120
		dc.w $260
		dc.w $E0
		dc.b 4
		dc.b $80
		dc.w 3
		dc.l loc_2D95C
		dc.w $17C
		dc.w $2FC
		dc.w $100
		dc.b 3
		dc.b $24
		dc.w 5
		dc.l loc_2D9A0
		dc.w $184
		dc.w $344
		dc.w $120
		dc.b 2
		dc.b $1C
		dc.w 7
		dc.l loc_2D8E2
		dc.w $C0
		dc.w $E0
		dc.w $10
		dc.b 1
		dc.b 0
		dc.w 1

ObjDat2_2DAA6:
		dc.l loc_2D9CC
		dc.w $15C
		dc.w $21C
		dc.w $BC
		dc.b $12
		dc.b $80
		dc.w 1


; ---------------------------------------------------------------------------

ObjDat2_2DAB4:
		dc.l loc_2D95C
		dc.w $C8
		dc.w $188
		dc.w $E8
		dc.b $13
		dc.b $80
		dc.w 1
		dc.l loc_2D95C
		dc.w $128
		dc.w $1E8
		dc.w $E8
		dc.b $14
		dc.b $80
		dc.w 1


; ---------------------------------------------------------------------------
Map_TitleCard:
		dc.w word_2EE3A-Map_TitleCard
		dc.w word_2EE3C-Map_TitleCard
		dc.w word_2EE9E-Map_TitleCard
		dc.w word_2EEAC-Map_TitleCard
		dc.w word_2EEC6-Map_TitleCard
		dc.w word_2EF0A-Map_TitleCard
		dc.w word_2EF3C-Map_TitleCard
		dc.w word_2EF86-Map_TitleCard
		dc.w word_2EFD0-Map_TitleCard
		dc.w word_2F020-Map_TitleCard
		dc.w word_2F046-Map_TitleCard
		dc.w word_2F07E-Map_TitleCard
		dc.w word_2F0BC-Map_TitleCard
		dc.w word_2F0FA-Map_TitleCard
		dc.w word_2F12C-Map_TitleCard
		dc.w word_2F170-Map_TitleCard
		dc.w word_2F1A2-Map_TitleCard
		dc.w word_2F1E6-Map_TitleCard
		dc.w word_2F22A-Map_TitleCard
		dc.w word_2F22A-Map_TitleCard
		dc.w word_2F24A-Map_TitleCard

word_2EE3A:
		dc.w 0

word_2EE3C:
		dc.w $10
		dc.b  $58,   9,	$85, $10, $FF, $E8
		dc.b  $58,   9,	$85, $16,   0,	 0
		dc.b  $90,  $F,	$85,   0, $FF, $E0
		dc.b  $90,  $F,	$85,   0,   0,	 0
		dc.b  $B0,  $F,	$85,   0, $FF, $E0
		dc.b  $B0,  $F,	$85,   0,   0,	 0
		dc.b  $D0,  $F,	$85,   0, $FF, $E0
		dc.b  $D0,  $F,	$85,   0,   0,	 0
		dc.b  $F0,  $F,	$85,   0, $FF, $E0
		dc.b  $F0,  $F,	$85,   0,   0,	 0
		dc.b  $10,  $F,	$85,   0, $FF, $E0
		dc.b  $10,  $F,	$85,   0,   0,	 0
		dc.b  $30,  $F,	$85,   0, $FF, $E0
		dc.b  $30,  $F,	$85,   0,   0,	 0
		dc.b  $50,  $F,	$85,   0, $FF, $E0
		dc.b  $50,  $F,	$85,   0,   0,	 0

word_2EE9E:
		dc.w 2
		dc.b  $10,   9,	$85, $37, $FF, $E4
		dc.b	0,  $F,	$85, $3D, $FF, $F5

word_2EEAC:
		dc.w 4
		dc.b	0,   6,	$85, $31, $FF, $DC
		dc.b	0,  $A,	$85, $28, $FF, $EC
		dc.b	0,   6,	$85, $22,   0,	 4
		dc.b	0,   6,	$85, $1C,   0, $14

word_2EEC6:
		dc.w $B
		dc.b	0,   6,	$85, $4D, $FF, $E0
		dc.b	0,   6,	$85, $22, $FF, $F0
		dc.b	0,   6,	$85, $59,   0,	 0
		dc.b	0,   6,	$85, $1C,   0, $10
		dc.b	0,   2,	$85, $62,   0, $20
		dc.b	0,   2,	$85, $5F,   0, $30
		dc.b	0,   6,	$85, $65,   0, $38
		dc.b	0,   2,	$85, $62,   0, $48
		dc.b	0,   6,	$85, $4D,   0, $50
		dc.b	0,   6,	$85, $22,   0, $60
		dc.b	0,   6,	$85, $53,   0, $70

word_2EF0A:
		dc.w 8
		dc.b	0,   6,	$85, $59, $FF, $F0
		dc.b	0,   6,	$85, $6E,   0,	 0
		dc.b	0,   6,	$85, $53,   0, $10
		dc.b	0,   6,	$85, $62,   0, $20
		dc.b	0,  $A,	$85, $28,   0, $30
		dc.b	0,   6,	$85, $4D,   0, $48
		dc.b	0,   2,	$85, $5F,   0, $58
		dc.b	0,  $E,	$85, $68,   0, $60

word_2EF3C:
		dc.w $C
		dc.b	0,  $A,	$85, $68, $FF, $B8
		dc.b	0,   6,	$85, $4D, $FF, $D0
		dc.b	0,   6,	$85, $71, $FF, $E0
		dc.b	0,   6,	$85, $53, $FF, $F0
		dc.b	0,   2,	$85, $65,   0,	 0
		dc.b	0,   6,	$85, $1C,   0,	 8
		dc.b	0,   6,	$85, $5F,   0, $20
		dc.b	0,   6,	$85, $4D,   0, $30
		dc.b	0,   6,	$85, $71,   0, $40
		dc.b	0,   6,	$85, $59,   0, $50
		dc.b	0,   6,	$85, $1C,   0, $60
		dc.b	0,   6,	$85, $22,   0, $70

word_2EF86:
		dc.w $C
		dc.b	0,   6,	$85, $53, $FF, $C0
		dc.b	0,   6,	$85, $4D, $FF, $D0
		dc.b	0,   6,	$85, $6B, $FF, $E0
		dc.b	0,   6,	$85, $22, $FF, $F0
		dc.b	0,   2,	$85, $65,   0,	 0
		dc.b	0,   6,	$85, $77,   0,	 8
		dc.b	0,   6,	$85, $4D,   0, $18
		dc.b	0,   2,	$85, $68,   0, $28
		dc.b	0,   6,	$85, $22,   0, $38
		dc.b	0,   2,	$85, $65,   0, $48
		dc.b	0,  $E,	$85, $59,   0, $50
		dc.b	0,   6,	$85, $71,   0, $70

word_2EFD0:
		dc.w $D

byte_2EFD2:
		dc.b	0,   6,	$85, $59, $FF, $B8
		dc.b	0,   2,	$85, $68, $FF, $C8
		dc.b	0,   6,	$85, $77, $FF, $D0
		dc.b	0,   2,	$85, $65, $FF, $E0
		dc.b	0,   6,	$85, $22, $FF, $E8
		dc.b	0,   6,	$85, $5F, $FF, $F8
		dc.b	0,   6,	$85, $53,   0, $10
		dc.b	0,   6,	$85, $4D,   0, $20
		dc.b	0,   6,	$85, $71,   0, $30
		dc.b	0,   6,	$85, $71,   0, $40
		dc.b	0,   6,	$85, $1C,   0, $50
		dc.b	0,   6,	$85, $6B,   0, $60
		dc.b	0,   6,	$85, $77,   0, $70

word_2F020:
		dc.w 6

byte_2F022:
		dc.b	0,   2,	$85, $59,   0, $28
		dc.b	0,   6,	$85, $53,   0, $30
		dc.b	0,   6,	$85, $1C,   0, $40
		dc.b	0,   6,	$85, $53,   0, $50
		dc.b	0,   6,	$85, $4D,   0, $60
		dc.b	0,   6,	$85, $5C,   0, $70

word_2F046:
		dc.w 9
		dc.b	0,   2,	$85, $65, $FF, $E0
		dc.b	0,   6,	$85, $4D, $FF, $E8
		dc.b	0,   6,	$85, $6E, $FF, $F8
		dc.b	0,   6,	$85, $22,   0,	 8
		dc.b	0,  $E,	$85, $59,   0, $18
		dc.b	0,   6,	$85, $53,   0, $40
		dc.b	0,   6,	$85, $4D,   0, $50
		dc.b	0,   6,	$85, $68,   0, $60
		dc.b	0,   6,	$85, $1C,   0, $70

word_2F07E:
		dc.w $A
		dc.b	0,  $A,	$85, $59, $FF, $B0
		dc.b	0,   6,	$85, $6E, $FF, $C8
		dc.b	0,   6,	$85, $68, $FF, $D8
		dc.b	0,   6,	$85, $4D, $FF, $E8
		dc.b	0,   6,	$85, $62, $FF, $F8
		dc.b	0,  $A,	$85, $28,   0,	 8
		dc.b	0,  $A,	$85, $28,   0, $20
		dc.b	0,  $A,	$85, $59,   0, $38
		dc.b	0,  $E,	$85, $4D,   0, $58
		dc.b	0,   2,	$85, $56,   0, $78

word_2F0BC:
		dc.w $A
		dc.b	0,   6,	$85, $65, $FF, $E0
		dc.b	0,   6,	$85, $4D, $FF, $F0
		dc.b	0,   6,	$85, $22,   0,	 0
		dc.b	0,   6,	$85, $53,   0, $10
		dc.b	0,  $A,	$85, $28,   0, $20
		dc.b	0,   6,	$85, $5F,   0, $38
		dc.b	0,  $A,	$85, $28,   0, $48
		dc.b	0,   2,	$85, $5C,   0, $60
		dc.b	0,   2,	$85, $59,   0, $68
		dc.b	0,   6,	$85, $65,   0, $70

word_2F0FA:
		dc.w 8

byte_2F0FC:
		dc.b	0,   2,	$85, $59,   0,	 0
		dc.b	0,   6,	$85, $4D,   0,	 8
		dc.b	0,   6,	$85, $62,   0, $18
		dc.b	0,   6,	$85, $4D,   0, $28
		dc.b	0,   6,	$85, $5C,   0, $40
		dc.b	0,   6,	$85, $1C,   0, $50
		dc.b	0,   6,	$85, $1C,   0, $60
		dc.b	0,   6,	$85, $53,   0, $70

word_2F12C:
		dc.w $B
		dc.b	0,   6,	$85, $65, $FF, $B8
		dc.b	0,   6,	$85, $59, $FF, $C8
		dc.b	0,   6,	$85, $77, $FF, $D8
		dc.b	0,   6,	$85, $65, $FF, $F0
		dc.b	0,   6,	$85, $4D,   0,	 0
		dc.b	0,   6,	$85, $22,   0, $10
		dc.b	0,   6,	$85, $53,   0, $20
		dc.b	0,  $E,	$85, $6B,   0, $30
		dc.b	0,   6,	$85, $4D,   0, $50
		dc.b	0,   6,	$85, $5F,   0, $60
		dc.b	0,   6,	$85, $77,   0, $70

word_2F170:
		dc.w 8

byte_2F172:
		dc.b	0,   6,	$85, $53, $FF, $F8
		dc.b	0,   6,	$85, $1C,   0,	 8
		dc.b	0,   6,	$85, $4D,   0, $18
		dc.b	0,   6,	$85, $65,   0, $28
		dc.b	0,   6,	$85, $5F,   0, $38
		dc.b	0,   6,	$85, $1C,   0, $50
		dc.b	0,   6,	$85, $59,   0, $60
		dc.b	0,   6,	$85, $59,   0, $70

word_2F1A2:
		dc.w $B
		dc.b	0,   6,	$85, $6E, $FF, $B0
		dc.b	0,   6,	$85, $59, $FF, $C0
		dc.b	0,   6,	$85, $1C, $FF, $D0
		dc.b	0,   6,	$85, $53, $FF, $E8
		dc.b	0,  $A,	$85, $28, $FF, $F8
		dc.b	0,  $A,	$85, $28,   0, $10
		dc.b	0,  $A,	$85, $5F,   0, $28
		dc.b	0,   6,	$85, $68,   0, $40
		dc.b	0,   6,	$85, $53,   0, $50
		dc.b	0,   6,	$85, $4D,   0, $60
		dc.b	0,   6,	$85, $74,   0, $70

word_2F1E6:
		dc.w $B
		dc.b	0,  $A,	$85, $5F, $FF, $C8
		dc.b	0,   6,	$85, $59, $FF, $E0
		dc.b	0,   6,	$85, $59, $FF, $F0
		dc.b	0,   6,	$85, $1C,   0,	 0
		dc.b	0,   6,	$85, $22,   0, $10
		dc.b	0,   6,	$85, $6B,   0, $28
		dc.b	0,   6,	$85, $4D,   0, $38
		dc.b	0,   2,	$85, $68,   0, $48
		dc.b	0,   6,	$85, $4D,   0, $50
		dc.b	0,   6,	$85, $53,   0, $60
		dc.b	0,   6,	$85, $1C,   0, $70

word_2F22A:
		dc.w 5
		dc.b	0,   6,	$85, $53,   0,	 0
		dc.b	0,  $A,	$85, $28,   0, $10
		dc.b	0,   6,	$85, $5F,   0, $28
		dc.b	0,   6,	$85, $71,   0, $38
		dc.b	0,   6,	$85, $65,   0, $48

word_2F24A:
		dc.w 5
		dc.b	0,   6,	$85, $65,   0,	 0
		dc.b	0,   6,	$85, $6B,   0, $10
		dc.b	0,   6,	$85, $4D,   0, $20
		dc.b	0,   6,	$85, $59,   0, $30
		dc.b	0,   6,	$85, $1C,   0, $40
