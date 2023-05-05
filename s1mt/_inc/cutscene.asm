; ===========================================================================
; ---------------------------------------------------------------------------
; Main control object for cutscenes
; ---------------------------------------------------------------------------
;   	        move.w  ($FFFFD008).w,X_Pos(a0)
;               move.w  ($FFFFD00C).w,Y_Pos(a0)
Map_Textbox:    include "_maps/texbox.asm"
		even
Map_Textboxchar: include "_maps/texboxchar.asm"
		even
Lag_Time:	equ	$98
Obj_Custscene:
	        move.w	($FFFFFE10).w,d0
		lsl.b	#6,d0
		lsr.w	#4,d0
		move.w	d0,d2
		add.w	d0,d0
		add.w	d2,d0
		move.w	Custscene_Zone(pc,d0.w),d0
		jmp	Custscene_Zone(pc,d0.w)
Custscene_Zone: dc.w Cutscene_GHZ1-Custscene_Zone

Cutscene_GHZ1:
                move.b	Subtype(a0),d0       ; move object subtype to d0
		move.w	Cutscene_GHZ1_sub(pc,d0.w),d1 ; load index to d1
		jmp	Cutscene_GHZ1_sub(pc,d1.w)    ; jump to index table
Cutscene_GHZ1_sub: dc.w Cutscene_GHZ1_0-Cutscene_GHZ1_sub
		   dc.w Cutscene_GHZ1_1-Cutscene_GHZ1_sub
		   dc.w Cutscene_GHZ1_2-Cutscene_GHZ1_sub
                   dc.w Cutscene_GHZ1_3-Cutscene_GHZ1_sub
                   dc.w Cutscene_GHZ1_4-Cutscene_GHZ1_sub
GHZ_end:
		rts
Cutscene_GHZ1_0:    ; main control object
		move.b	routine(a0),d0       ; move object state to d0
		move.w	Cutscene_GHZ1_0_sta(pc,d0.w),d1 ; load index to d1
		jsr	Cutscene_GHZ1_0_sta(pc,d1.w)    ; jump to index table
		tst.b	(Game_Display_TextBox).w
		beq.s   GHZ_end
		jmp     Displaysprite
Cutscene_GHZ1_0_sta: dc.w Cutscene_GHZ1_0_0-Cutscene_GHZ1_0_sta
                dc.w Cutscene_GHZ1_0_1-Cutscene_GHZ1_0_sta
                dc.w Cutscene_GHZ1_0_2-Cutscene_GHZ1_0_sta
                dc.w Cutscene_GHZ1_0_3-Cutscene_GHZ1_0_sta
                dc.w Cutscene_GHZ1_0_4-Cutscene_GHZ1_0_sta
                dc.w Cutscene_GHZ1_0_5-Cutscene_GHZ1_0_sta
                dc.w Cutscene_GHZ1_0_6-Cutscene_GHZ1_0_sta
Cutscene_GHZ1_0_0:
                moveq	#$23,d0
		jsr	LoadPLC		; load boss patterns
                clr.b   (Sonic_Boss_Moveset).w
                clr.l   (Cut_StoreCharID).w
	        move.b  #1,($FFFFF7CC).w
                clr.b   ($FFFFF603).w
                move.b  #8,($FFFFF602).w
	        addq.b  #2,routine(a0)
	        move.l	#GHZ1Text1,d1
		move.w	#$3200,d2
		move.w	#$1B80,d3
		jsr	(QueueDMATransfer).l
Cutscene_GHZ1_0_1:
		cmpi.w  #$120,($FFFFD000+X_Pos).w
        	bcs.s   GHZ_end
		addq.b  #2,routine(a0)
		move.l	#Map_TextBox,4(a0)
		move.w	#$130,X_Pos2(a0)
		move.w	#$98,X_Pos(a0)
		move.w	#$8190,Art_Tile(a0)
		move.b  #0,Anim_Frame(a0)
		move.w  #Lag_Time,(Game_freeze_textbox).w
		move.b  #1,(Game_Display_TextBox).w
                jsr     Singleobjload
        	bne.s	@q
                move.b  #6,(a1)
                move.b  #6,Subtype(a1)
@q              jsr     Singleobjload
        	bne.s	@a
                move.b  #6,(a1)
                move.b  #8,Subtype(a1)
@a		rts
Cutscene_GHZ1_0_2:
                tst.b	(Game_Display_TextBox).w
		bne.w   GHZ_end
                addq.b  #2,routine(a0)
Cutscene_GHZ1_0_3:
                move.b  #8,($FFFFF602).w
                cmpi.w  #$1F0,($FFFFD000+X_Pos).w
        	bcs.s   Cutscene_GHZ1_0_0_1
        	move.w  #$810,($FFFFF602).w
        	btst	#1,($FFFFD000+Status).w
		beq.s	@c
        	move.w  #$1800,($FFFFF602).w
@c        	cmpi.w  #$250,($FFFFD000+X_Pos).w
        	bcs.s   Cutscene_GHZ1_0_0_1
        	move.w  #$800,($FFFFF602).w
Cutscene_GHZ1_0_0_1:
	        cmpi.w  #$2B0,($FFFFF700).w
        	bcs.w   GHZ_end
		addq.b  #2,routine(a0)
Cutscene_GHZ1_0_4:
		cmpi.w  #$500,($FFFFF700).w
        	bcs.w   GHZ_end
        	jsr     Singleobjload
        	bne.w	GHZ_end
                move.b  #6,(a1)
                move.b  #2,Subtype(a1)
                addq.b  #2,routine(a0)
Cutscene_GHZ1_0_5:
                tst.b   ($FFFFF7CC).w
        	beq.w   GHZ_end
                move.b  #8,($FFFFF602).w
	        cmpi.w  #$650,($FFFFD000+Inertia).w
		bcc.w   GHZ_end
		move.w  #$650,($FFFFD000+Inertia).w
		addq.b  #2,routine(a0)
Cutscene_GHZ1_0_6:
	        cmpi.w  #$980,($FFFFF700).w
        	bcs.w   @c
        	move.w  #$120,($FFFFF726).w
        	move.b  #8,($FFFFF602).w
		cmpi.w  #$100,($FFFFD000+Inertia).w
		bgt.s   @c
		move.w  #$650,($FFFFD000+Inertia).w
@c		rts
Cutscene_GHZ1_3:
	        tst.b	(Game_Display_TextBox).w
		beq.s   @c
		jsr     Displaysprite
@c	        move.b	routine(a0),d0       ; move object state to d0
		move.w	Cutscene_GHZ1_3_sta(pc,d0.w),d1 ; load index to d1
		jmp	Cutscene_GHZ1_3_sta(pc,d1.w)    ; jump to index table
Cutscene_GHZ1_3_sta: dc.w Cutscene_GHZ1_3_0-Cutscene_GHZ1_3_sta
		     dc.w Cutscene_GHZ1_3_1-Cutscene_GHZ1_3_sta
		     dc.w Cutscene_GHZ1_3_2-Cutscene_GHZ1_3_sta
		     dc.w Cutscene_GHZ1_3_3-Cutscene_GHZ1_3_sta
		     dc.w Cutscene_GHZ1_3_4-Cutscene_GHZ1_3_sta
		     dc.w Cutscene_GHZ1_3_5-Cutscene_GHZ1_3_sta
		     dc.w Cutscene_GHZ1_3_6-Cutscene_GHZ1_3_sta
Cutscene_GHZ1_3_0:
	        addq.b  #2,routine(a0)
		move.l	#Map_TextBox,4(a0)
		move.w	#$130,X_Pos2(a0)
		move.w	#$138,X_Pos(a0)
		move.w	#$8190,Art_Tile(a0)
		move.b  #1,Anim_Frame(a0)  
Cutscene_GHZ1_3_1:
	        tst.w	(Game_freeze_textbox).w
		bne.w   GHZ_end
		clr.b   (Game_Display_TextBox).w
		addq.b  #2,routine(a0)
	        move.l	#GHZ1Text2,d1
	 	move.w	#$3200,d2
		move.w	#$1B80,d3
		jsr	(QueueDMATransfer).l
Cutscene_GHZ1_3_2:
                cmpi.w  #$640,($FFFFF700).w
        	bcs.w   Cutscene_GHZ1_3_6
        	andi.b	#$80,($FFFFF604).w ; is	Start button pressed?
		bne.w	Cutscene_GHZ1_3_6	; if not, branch
		move.w  #Lag_Time,(Game_freeze_textbox).w
		move.b  #1,(Game_Display_TextBox).w
		addq.b  #2,routine(a0)
		move.b  (Current_Character).w,(Cut_StoreCharID).w
		move.w  #$400,($FFFFD000+Inertia).w
Cutscene_GHZ1_3_3:
	        cmpi.w	#1,(Game_freeze_textbox).w
		bgt.w   Cutscene_GHZ1_3_6
		andi.b	#$80,($FFFFF604).w ; is	Start button pressed?
		bne.w	Cutscene_GHZ1_3_6	; if not, branch
		addq.b  #2,routine(a0)
		move.l	#GHZ1Text3,d1
	 	move.w	#$3200,d2
		move.w	#$1B80,d3
		jsr	(QueueDMATransfer).l
		move.w  #Lag_Time,(Game_freeze_textbox).w
		move.b  #3,(Cut_StoreCharID).w
Cutscene_GHZ1_3_4:
	        cmpi.w	#1,(Game_freeze_textbox).w
		bgt.s   Cutscene_GHZ1_3_6
		andi.b	#$80,($FFFFF604).w ; is	Start button pressed?
		bne.s	Cutscene_GHZ1_3_6	; if not, branch
		addq.b  #2,routine(a0)
		move.l	#GHZ1Text4,d1
	 	move.w	#$3200,d2
		move.w	#$1B80,d3
		jsr	(QueueDMATransfer).l
		move.w  #Lag_Time,(Game_freeze_textbox).w
		move.b  #4,(Cut_StoreCharID).w
		clr.b   ($FFFFF7CC).w
Cutscene_GHZ1_3_5:
                move.b  #1,(Game_Display_TextBox).w
	        tst.w	(Game_freeze_textbox).w
		bne.s   Cutscene_GHZ1_3_6
		clr.b   (Game_Display_TextBox).w
		andi.b	#$80,($FFFFF604).w ; is	Start button pressed?
		bne.s	Cutscene_GHZ1_3_6	; if not, branch
		addq.b  #2,routine(a0)
		move.l	#GHZ1Text5,d1
	 	move.w	#$3200,d2
		move.w	#$1B80,d3
		jsr	(QueueDMATransfer).l
		move.b  (Current_Character).w,(Cut_StoreCharID).w
Cutscene_GHZ1_3_6:
		rts
Cutscene_GHZ1_4:
                move.b	routine(a0),d0       ; move object state to d0
		move.w	Cutscene_GHZ1_4_sta(pc,d0.w),d1 ; load index to d1
		jsr	Cutscene_GHZ1_4_sta(pc,d1.w)    ; jump to index table
		tst.b	(Game_Display_TextBox).w
		beq.w   GHZ_end
		jmp     Displaysprite
Cutscene_GHZ1_4_sta: dc.w Cutscene_GHZ1_4_0-Cutscene_GHZ1_4_sta
                dc.w Cutscene_GHZ1_4_1-Cutscene_GHZ1_4_sta
                dc.w Cutscene_GHZ1_4_2-Cutscene_GHZ1_4_sta
Cutscene_GHZ1_4_0:
		addq.b  #2,routine(a0)
		move.l	#Map_TextBoxchar,4(a0)
		move.w	#$F8,X_Pos2(a0)
		move.w	#$90,X_Pos(a0)
		move.w	#$8680,Art_Tile(a0)
		move.b  (Current_Character).w,Anim_Frame(a0)
Cutscene_GHZ1_4_1:
                cmpi.w  #$640,($FFFFF700).w
        	bcs.w   Cutscene_GHZ1_4_3
        	addq.b  #2,routine(a0)
Cutscene_GHZ1_4_2:
                move.b  (Cut_StoreCharID).w,Anim_Frame(a0)
Cutscene_GHZ1_4_3:
		rts
Cutscene_GHZ1_1:
                move.b	routine(a0),d0       ; move object state to d0
		move.w	Cutscene_GHZ1_1_sta(pc,d0.w),d1 ; load index to d1
		jmp	Cutscene_GHZ1_1_sta(pc,d1.w)    ; jump to index table
Cutscene_GHZ1_1_sta: dc.w Cutscene_GHZ1_1_0-Cutscene_GHZ1_1_sta
                dc.w Cutscene_GHZ1_1_1-Cutscene_GHZ1_1_sta
                dc.w Cutscene_GHZ1_1_2-Cutscene_GHZ1_1_sta
                dc.w Cutscene_GHZ1_1_3-Cutscene_GHZ1_1_sta
Cutscene_GHZ1_1_0:
		move.w  #$4E0,X_Pos(a0)
                move.w  #$E0,Y_Pos(a0)
	        lea	(Obj3D_ObjData).l,a2
		movea.l	a0,a1
		moveq	#2,d1
		bra.s	Cutscene_GHZ1_1_0_2
; ===========================================================================

Cutscene_GHZ1_1_0_1:
		jsr	SingleObjLoad2
		bne.s	Cutscene_GHZ1_1_0_3
Cutscene_GHZ1_1_0_2:
  		move.b	(a2)+,routine(a1)
		move.b	#6,(a1)
                move.b	#2,Subtype(a1)
		move.w	X_Pos(a0),X_Pos(a1)
		move.w	Y_Pos(a0),Y_Pos(a1)
		move.l	#Map_Eggman,4(a1)
		move.w	#$400,Art_Tile(a1)
		move.b	#4,Render_Flags(a1)
		move.b	#$20,X_Visible(a1)
		move.b	#3,Priority(a1)
		move.b	(a2)+,Anim(a1)
		move.l	a0,Off34(a1)
		dbf	d1,Cutscene_GHZ1_1_0_1	; repeat sequence 2 more times
Cutscene_GHZ1_1_0_3:
		move.b	#4,Coll2(a0)	; set number of	hits to	8
		move.b	#$F,Coll(a0)
		move.b  #1,status(a0)
Cutscene_GHZ1_1_1:
		moveq	#0,d0
		move.b	routine2(a0),d0
		move.w	Cutscene_GHZ1_1_1_sta(pc,d0.w),d1
		jsr	Cutscene_GHZ1_1_1_sta(pc,d1.w)
		lea	(Ani_Eggman).l,a1
		jsr	AnimateSprite
		move.b	status(a0),d0
		andi.b	#3,d0
		andi.b	#$FC,Render_Flags(a0)
		or.b	d0,Render_Flags(a0)
		jmp	DisplaySprite
Cutscene_GHZ1_1_1_sta:  dc.w Cutscene_GHZ1_1_1_0-Cutscene_GHZ1_1_1_sta
                dc.w Cutscene_GHZ1_1_1_1-Cutscene_GHZ1_1_1_sta
                dc.w Cutscene_GHZ1_1_1_2-Cutscene_GHZ1_1_1_sta
Cutscene_GHZ1_1_1_0:
	        move.b	#4,Coll2(a0)	; set number of	hits to	8
		move.w  #$E0,Y_Pos(a0)
		move.w  ($FFFFF700).w,d0
		addi.w  #$E0,d0
		cmp.w   X_Pos(a0),d0
		bcs.s   @e
                addq.w  #8,X_Pos(a0)
                tst.b   ($FFFFF7CC).w
                beq.s   Cutscene_GHZ1_1_1_0c
                addq.w  #6,X_Pos(a0)
                bra.s   Cutscene_GHZ1_1_1_0c
@e 		addq.b  #2,routine2(a0)
                bra.s   Cutscene_GHZ1_1_1_0c
Cutscene_GHZ1_1_1_1:
		move.w  #$E0,Y_Pos(a0)
		move.w  ($FFFFF700).w,X_Pos(a0)
		addi.w  #$E0,X_Pos(a0)
Cutscene_GHZ1_1_1_0c:
	        subq.b  #1,Off3C(a0)
		bne.s   Cutscene_GHZ1_1_1_0_1
		move.b  #$80,Off3C(a0)
		jsr	SingleObjLoad
		bne.s	Cutscene_GHZ1_1_1_0_1
		move.b	#6,(a1)	; load missile object
		move.w	X_Pos(a0),X_Pos(a1)
		move.w	Y_Pos(a0),Y_Pos(a1)
		move.b  #4,Subtype(a1)
		move.w	#$20,Y_Vel(a1)	; move missile downwards
Cutscene_GHZ1_1_1_0_1:
		move.b	Off3F(a0),d0
		jsr	(CalcSine).l
		asr.w	#6,d0
		add.w	Y_Pos(a0),d0
		move.w	d0,Y_Pos(a0)
		addq.b	#2,Off3F(a0)
		tst.b	status(a0)
		bmi.w	Cutscene_GHZ1_1_1_0_5
		tst.b	Coll(a0)
		bne.w	Cutscene_GHZ1_1_1_0_4
		tst.b	Off3E(a0)
		bne.w	Cutscene_GHZ1_1_1_0_2
		move.b	#$20,Off3E(a0)	; set number of	times for ship to flash
		move.w	#$AC,d0
		jsr	(PlaySound_Special).l ;	play boss damage sound
		move.b  #$50,Off3C(a0)
Cutscene_GHZ1_1_1_0_2:
		lea	($FFFFFB22).w,a1 ; load	2nd pallet, 2nd	entry
		moveq	#0,d0		; move 0 (black) to d0
		tst.w	(a1)
		bne.s	Cutscene_GHZ1_1_1_0_3
		move.w	#$EEE,d0	; move 0EEE (white) to d0
Cutscene_GHZ1_1_1_0_3:
		move.w	d0,(a1)		; load colour stored in	d0
		subq.b	#1,Off3E(a0)
		bne.s	Cutscene_GHZ1_1_1_0_4
		move.b	#$F,Coll(a0)
Cutscene_GHZ1_1_1_0_4:
	        rts
Cutscene_GHZ1_1_1_0_5:				; XREF: loc_177E6
		moveq	#100,d0
		jsr	AddPoints
		move.b	#4,routine2(a0)
		move.w	#$20,Off3C(a0)
		rts
Cutscene_GHZ1_1_1_2:
		jsr	BossDefeated
		move.b  #1,(Cut_Over_Flag).w
@r		move.w  ($FFFFF700).w,d0
		subi.w  #$40,d0
		cmp.w   X_Pos(a0),d0
		bcs.s   Cutscene_GHZ1_1_1_3
		move.w  #Lag_Time,(Game_freeze_textbox).w
	;	move.b  #1,(Game_Display_TextBox).w
		clr.b   (Sonic_Boss_Moveset).w
		move.w	#$800,($FFFFF760).w ; Sonic's top speed
		move.w	#$700,($FFFFD000+Inertia).w ; Sonic's top speed
		move.b  #1,($FFFFF7CC).w
		clr.w	Off3C(a0)
GHZ1cut_Del:
		jmp     Deleteobject
Cutscene_GHZ1_1_1_3:
		rts
Cutscene_GHZ1_1_2:
                cmpi.w  #$700,($FFFFF700).w
        	bcs.w   @c
                tst.b   (Sonic_Boss_Moveset).w
        	beq.s   GHZ1cut_Del
@c		moveq	#0,d0
		moveq	#1,d1
		movea.l	Off34(a0),a1
		move.b	routine2(a1),d0
		subq.b	#4,d0
	;	bne.s	Cutscene_GHZ1_1_2_0
	;	cmpi.w	#$700,$30(a1)
	;	bne.s	Cutscene_GHZ1_1_2_1
	;	moveq	#4,d1

Cutscene_GHZ1_1_2_0:
		subq.b	#6,d0
		bmi.s	Cutscene_GHZ1_1_2_1
		moveq	#$A,d1
		bra.s	Cutscene_GHZ1_1_2_3
; ===========================================================================

Cutscene_GHZ1_1_2_1:
		tst.b	Coll(a1)
		bne.s	Cutscene_GHZ1_1_2_2
		moveq	#5,d1
		bra.s	Cutscene_GHZ1_1_2_3
; ===========================================================================

Cutscene_GHZ1_1_2_2:
		cmpi.b	#4,($FFFFD000+Routine).w
		bcs.s	Cutscene_GHZ1_1_2_3
		moveq	#4,d1

Cutscene_GHZ1_1_2_3:
		move.b	d1,Anim(a0)
		subq.b	#2,d0
		bne.s	Cutscene_GHZ1_1_2_4
		move.b	#6,Anim(a0)
		tst.b	Render_Flags(a0)
		bpl.s	Cutscene_GHZ1_1_2_5

Cutscene_GHZ1_1_2_4:
		bra.s	Cutscene_GHZ1_1_3_3
; ===========================================================================

Cutscene_GHZ1_1_2_5:
		jmp	DeleteObject

Cutscene_GHZ1_1_3:
                cmpi.w  #$700,($FFFFF700).w
        	bcs.w   @c
                tst.b   (Sonic_Boss_Moveset).w
        	beq.s   Cutscene_GHZ1_1_2_5
@c	        move.b	#7,Anim(a0)
		movea.l	Off34(a0),a1
		cmpi.b	#$C,routine2(a1)
		bne.s	Cutscene_GHZ1_1_3_0
		move.b	#$B,Anim(a0)
		tst.b	Render_Flags(a0)
		bpl.s	Cutscene_GHZ1_1_3_2
		bra.s	Cutscene_GHZ1_1_3_1
; ===========================================================================

Cutscene_GHZ1_1_3_0:
		move.w	X_Vel(a1),d0
		beq.s	Cutscene_GHZ1_1_3_1
		move.b	#8,Anim(a0)

Cutscene_GHZ1_1_3_1:
		bra.s	Cutscene_GHZ1_1_3_3
; ===========================================================================

Cutscene_GHZ1_1_3_2:
		jmp	DeleteObject
; ===========================================================================

Cutscene_GHZ1_1_3_3:				; XREF: Obj3D_FaceDisp; Obj3D_FlameDisp
		movea.l	Off34(a0),a1
		move.w	X_Pos(a1),X_Pos(a0)
		move.w	Y_Pos(a1),Y_Pos(a0)
		move.b	status(a1),status(a0)
		lea	(Ani_Eggman).l,a1
		jsr	AnimateSprite
		move.b	status(a0),d0
		andi.b	#3,d0
		andi.b	#$FC,Render_Flags(a0)
		or.b	d0,Render_Flags(a0)
		jmp	DisplaySprite
Cutscene_GHZ1_2:
                moveq	#0,d0
		move.b	routine(a0),d0       ; move object state to d0
		move.w	Cutscene_GHZ1_2_sta(pc,d0.w),d1 ; load index to d1
		jmp	Cutscene_GHZ1_2_sta(pc,d1.w)    ; jump to index table
Cutscene_GHZ1_2_sta: dc.w Cutscene_GHZ1_2_0-Cutscene_GHZ1_2_sta
                dc.w Cutscene_GHZ1_2_1-Cutscene_GHZ1_2_sta
Cutscene_GHZ1_2_0:
	        addq.b	#2,routine(a0)
		move.l	#Map_obj23,4(a0)
		move.w	#$2444,Art_Tile(a0)
		move.b	#4,Render_Flags(a0)
		move.b	#3,Priority(a0)
		move.b	#8,X_Visible(a0)
		andi.b	#3,status(a0)
		move.b	#$87,Coll(a0)
		move.b	#1,Anim(a0)
		move.w  #-$400,Y_Vel(a0)
		move.w  #$480,X_Vel(a0)
Cutscene_GHZ1_2_1:
	        tst.b   (Cut_Over_Flag).w
        	bne.s   Cutscene_GHZ1_2_2
		jsr	Objectfall
		jsr	ObjHitFloor
		tst.w	d1
		bpl.s	Cutscene_GHZ1_2_3
Cutscene_GHZ1_2_2:
	;	subq.w  #4,X_Pos(a0)
		clr.l   X_Vel(a0)
		move.b  #$3F,(a0)
		clr.b   routine(a0)
		addq.w  #4,X_Pos(a0)
		jmp     Obj3F
Cutscene_GHZ1_2_3:
		move.w  ($FFFFF700).w,d0
		subi.w  #$10,d0
		cmp.w   X_Pos(a0),d0
		bcs.s   @a
		jmp     Deleteobject
@a		lea	(Ani_obj23).l,a1
		jsr	AnimateSprite
		jmp	DisplaySprite