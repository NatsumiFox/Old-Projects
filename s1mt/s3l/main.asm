LevSel_S3_Row:

		cmpi.b	#11,d1	; for first 6 zones, draw 1, 2 and 3
		ble.s	.skip
		move.w	#$11,(a2)	; do 1
		lea	$50(a2),a2	; next row.w
		move.w	#$12,(a2)	; do 2
		lea	$50(a2),a2	; next row.w
		move.w	#$13,(a2)	; do 3
.skip		rts

LevSel_S3_Spec:
		move.w	Music_EnabledChans.w,d1
		moveq	#2,d2
		moveq	#8,d0
		lea	$FF0000+$4A+$50,a0	; get RAM address of the first star

.starloop	move.w	#$1A,(a0)		; draw star to the address
		btst	d2,d1
		beq.s	.no
		move.w	#$1C,(a0)		; draw star to the address
.no		lea	3*$50(a0),a0		; next location
		addq.b	#1,d2
		dbf	d0,.starloop		; loop until 0

		lea	-$50(a0),a0
		move.w	#$1A,(a0)
		btst	d2,d1
		beq.s	.no1
		move.w	#$1C,(a0)

.no1		move.w	#$1A,$FF0000+$24+(25*$50)
		move.w	#$1A,$FF0000+$24+(26*$50)	; sound test stars
rts222		rts

LevelSelect_S3:
		moveq	#Music_LevelSelect,d0
		bsr.w	PlayMusicFade	; fade out music

		bsr.w	ClearPLC
		clr.w	$FFFFFE10.w

		bsr.w	Pal_FadeFrom
		move.b	Current_Character.w,d0
		lsr.b	#1,d0
		move.b	d0,Current_Character.w

		; get data to tables
		move.l	#LevSel_TextData,LS_TextData.w
		move.l	#LevSel_OffsetTable,LS_OffsetTable.w
		move.l	#LevSel_S3_Spec,LS_SpecialScreen.w
		move.l	#LevSel_S3_Row,LS_ExtraRowData.w
		move.l	#LevSel_HighLight,LS_HighLight.w
		move.l	#LevSel_LRTable,LS_LSTable.w
		move.b	#30,LS_MaxSel.w
		move.b	#$E,LS_HighLenght.w
		move.b	#$D,LS_LineLenght.w
		move.w	#0,LevSel_Pos.w
		bsr.w	LoadS3Stuff

		move.w	#0,Sound_test_sound.w
		moveq	#0,d3
		bsr.w	SoundTestDraw
		bsr.w	SoundTestDraw2
		bsr.w	SoundLevelDraw
		lea	AniPLC_SONICMILES,a2
		jsr	AnimateTiles_DoAniPLC

		lea	Pal_SonicTailsS2,a1
		lea	Palette_NTarget.w,a2
		moveq	#$1F,d0
		bsr.w	Loc_Pal

		lea	Pal_SonicTailsS2,a1
		lea	Palette_UTarget.w,a2
		moveq	#$1F,d0
		bsr.w	Loc_Pal

		move.b	#8,VBlank_Routine.w
		bsr.w	DelayProgram
		move.w	$FFFFF60C.w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l			; Turn the display on
		bsr.w	Pal_FadeTo

loc_7C4A:
		move.b	#8,VBlank_Routine.w
		bsr.w	DelayProgram
		move	#$2700,sr
		moveq	#0,d3
		bsr.w	DoHighLight
		bsr.w	DoPlayerSel
		bsr.w	SoundTest
		move.w	#$6000,d3
		bsr.w	DoHighLight
		bsr.w	DoPlayerSel
		bsr.w	SoundLevelDraw
		move	#$2300,sr

		lea	AniPLC_SONICMILES,a2
		bsr.w	AnimateTiles_DoAniPLC
		move.b	($FFFFF605).w,d0
		or.b	($FFFFF607).w,d0
		andi.b	#$80,d0
		beq.s	loc_7C4A

		move.b	Current_Character.w,d0
		add.b	d0,Current_Character.w
		lea	LS_Level_Order(pc),a1
		move.w	LevSel_Pos.w,d0
		add.w	d0,d0
		move.w	(a1,d0.w),$FFFFFE10.w
		bmi.s	.sndsel
		bra.w	PlayLevel

.sndsel		lea	Sound_test_sound,a0
		moveq	#0,d0
		move.b	$FFFFFFE11.w,d0
		adda.w	d0,a0
		move.b	(a0),d0
		add.b	#$E4,d0
		move.b	d0,Music_StoreZoneID.w

		move.b	#2,Music_RequestTypes.w
		move.w	#0,$FFFFFE10.w
		bra.w	loc_7C4A

DLC_PriceList:	dc.l -1, -1, 999, 2000, 150, 300, 0, 750, 75000, 5, 42, 1000000000, 9966, 100000000000, 10000000, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1

DLC_Row:
		movem.l	a0-a2/d0-d5,-(sp)

		move.l	DLC_PriceList(pc,d4.w),d1
		bmi	.ret
		beq	.ret
		move.l	DLC_TransLenghts(pc,d4.w),d6
		move.l	d6,d5

		add.l	d5,d5
		moveq	#$1E,d0
		sub.l	d5,d0
		lea	(a2),a0
		adda.l	d0,a0

		add.l	d5,d5
		move.l	DLC_NumList(pc,d5.w),a2
		move.w	d4,-(sp)
		bsr.w	DLC_PointLoop
		move.w	(sp)+,d4

		lea	DLC_Jump,a2
		lsr.w	#1,d4
		move.w	(a2,d4.w),d0
		bmi.s	.ret

		move.l	Bought_Items.w,d6
		moveq	#$1A,d1
		btst	d0,d6
		bne.s	.draw
		moveq	#0,d1

.draw		move.w	d1,(a0)+

.ret		movem.l	(sp)+,a0-a2/d0-d5
		rts

DLC_TransLenghts:	dc.l  0,  0,    2,    3,   2,   2,  0,   2,     4, 0,  1, 9, 3, 9, 7
DLC_NumList:		dc.l Hud_1, Hud_10, Hud_100, Hud_1000, Hud_10000, Hud_100000, Hud_1000000, Hud_10000000, Hud_100000000, Hud_1000000000, DLC_num

DLC_Currency:	text.b $23,$23,$23,'J',$23,'P',$23,'Y'
		text.b $23,$23,$23,'J',$23,'P',$23,'Y'
		text.b $23,$23,$23,'U',$23,'S',$23,'D'
		text.b $23,$23,$23,'E',$23,'U',$23,'R'

DLC_Spec:
		moveq	#0,d0
		move.b	HW_Version.w,d0
		lsr.w	#3,d0
		lea	DLC_Currency(pc,d0.w),a0
		lea	$FF0000+($50*20)+28,a1
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+

		moveq	#$1A,d1
		buyTest	Bought_ExtCam
		bne.s	.draw
		moveq	#$1C,d1

.draw		move.w	d1,$FF0000+($50*8)+$4A

		moveq	#0,d1
		buyTest	Bought_AltMusic
		beq.s	.draw2
		moveq	#$1C,d1
		buyTest	Used_AltMusic
		beq.s	.draw2
		moveq	#$1A,d1

.draw2		move.w	d1,$FF0000+($50*9)+$4A

		moveq	#0,d1
		buyTest	Bought_AirHorn
		beq.s	.draw3
		moveq	#$1C,d1
		buyTest	Used_AirHorn
		beq.s	.draw3
		moveq	#$1A,d1

.draw3		move.w	d1,$FF0000+($50*14)+$4A

		moveq	#0,d1
		buyTest	Bought_Boobs
		beq.s	.draw4
		moveq	#$1C,d1
		buyTest	Used_Boobs
		beq.s	.draw4
		moveq	#$1A,d1

.draw4		move.w	d1,$FF0000+($50*15)+$4A
		rts

DLCScreen:
		bsr.w	ClearPLC
		bsr.w	Pal_FadeFrom

		; get data to tables
		move.l	#DLC_TextData,LS_TextData.w
		tst.b	HW_Version.w	; are we on a Japanese Mega Drive?
		bmi.s	.noJP			; if not, branch
		move.l	#DLC_TextDataJP,LS_TextData.w

.noJP		move.l	#DLC_OffsetTable,LS_OffsetTable.w
		move.l	#DLC_Spec,LS_SpecialScreen.w
		move.l	#DLC_Row,LS_ExtraRowData.w
		move.l	#DLC_HighLight,LS_HighLight.w
		move.b	#19,LS_MaxSel.w
		move.b	#$30,LS_HighLenght.w
		move.b	#$10,LS_LineLenght.w
		move.w	#0,LevSel_Pos.w
		bsr.w	LoadS3Stuff
		moveq	#0,d1
		bsr.w	BuyItem

	;	bsr.w	SoundTestDraw
	;	bsr.w	SoundTestDraw2
	;	bsr.w	SoundLevelDraw
		lea	AniPLC_SONICMILES,a2
		jsr	AnimateTiles_DoAniPLC

		lea	Pal_SonicTailsS2,a1
		lea	Palette_NTarget.w,a2
		moveq	#$1F,d0
		bsr.w	Loc_Pal

		lea	Pal_SonicTailsS2,a1
		lea	Palette_UTarget.w,a2
		moveq	#$1F,d0
		bsr.w	Loc_Pal

		move.b	#8,VBlank_Routine.w
		bsr.w	DelayProgram
		move.w	$FFFFF60C.w,d0
		ori.b	#$40,d0
		move.w	d0,(VDP_control_port).l			; Turn the display on
		bsr.w	Pal_FadeTo

DLC_loop:
		move.b	#8,VBlank_Routine.w
		bsr.w	DelayProgram
		move	#$2700,sr
		moveq	#0,d3
		bsr.w	DoHighLight
	;	bsr.w	DoPlayerSel
		bsr.w	SoundTest
		move.w	#$6000,d3
		bsr.w	DoHighLight
	;	bsr.w	DoPlayerSel
	;	bsr.w	SoundLevelDraw
		move	#$2300,sr

		lea	AniPLC_SONICMILES,a2
		bsr.w	AnimateTiles_DoAniPLC
		move.b	($FFFFF605).w,d0
		or.b	($FFFFF607).w,d0
		andi.b	#$F0,d0
		beq.s	DLC_loop

		moveq	#0,d5
		move.w	LevSel_Pos.w,d0
		add.w	d0,d0
		move.w	DLC_Jump(pc,d0.w),d5
		bmi.s	.lable
		move.l	Bought_Items.w,d6
		bsr.w	DLC_ConfirmBuy
		bra.s	DLC_loop

.lable		lea	DLC_Jump,a0
		adda.w	d5,a0
		jsr	(a0)
		bra.s	DLC_loop

; new game
DLC_New:
		bsr.w	DLC_new_
		jsr	PlayZoneMusic
; continue game
DLC_Continue:
		addq.l	#4,sp
		rts

; buy a life
DLC_BuyLife:
		bra	DLC_BuyLife_

DLC_BetterGame:
		moveq	#$20,d0
		bra	DLC_GoGameMode

DLC_Boobies:
		bra	DLC_Boobies_

DLC_Sekrit:
		bra	DLC_Sekrit_

DLC_TipDay:
		bra	DLC_TipDay_

BuyExtCam:
		bra	DLC_ExtCam

BuyAltMusic:
		bra	DLC_AltMusic

BuyAirHorn:
		bra	DLC_AirHorn

Cheat_10:
		moveq	#-10,d1
		bra.s	BuyCheat

Cheat_100:
		moveq	#-100,d1
		bra.s	BuyCheat

Cheat_1000:
		move.l	#-1000,d1
		bra.s	BuyCheat

Cheat_100000000:
		move.l	#-100000000,d1
		bra.s	BuyCheat

DLC_Jump:	dc.w DLC_Continue-DLC_Jump, DLC_New-DLC_Jump
		dc.w Bought_Knux, Bought_Tails, Bought_SpinDash, Bought_Shields, BuyExtCam-DLC_Jump, BuyAltMusic-DLC_Jump, Bought_LevSel
		dc.w DLC_TipDay-DLC_Jump, DLC_BuyLife-DLC_Jump, DLC_BetterGame-DLC_Jump, BuyAirHorn-DLC_Jump
		dc.w DLC_Boobies-DLC_Jump, DLC_Sekrit-DLC_Jump
		dc.w Cheat_10-DLC_Jump, Cheat_100-DLC_Jump, Cheat_1000-DLC_Jump, Cheat_100000000-DLC_Jump

BuyCheat:
	SRAMEnable
		tst.b	SRAM_Start+SRAM_GameCompl
		bpl	WaitPayPal
	SRAMDisable
		moveq	#29,d5
		move.l	DCL_Rings.w,d2
		sub.l	d1,d2

		cmpi.l	#1000000000*2,d2
		ble.s	BuyItem
		move.l	#1000000000*2,DCL_Rings.w
		bra.s	BuyItem_

BuyItem:
		sub.l	d1,DCL_Rings.w
BuyItem_:
		pea	DLC_DrawVDP(pc)

		move.l	DCL_Rings.w,d1
		lea	$FF0000+(26*$50)+68,a0
		lea	DLC_num,a2
		moveq	#9,d6

DLC_PointLoop:
		moveq	#0,d2
		move.l	(a2)+,d3

.numloop	sub.l	d3,d1
		bcs.s	.0
		addq.w	#1,d2
		bra.s	.numloop
; ===========================================================================

.0		add.l	d3,d1
		addi.w	#$10,d2
		move.w	d2,(a0)+
		dbf	d6,DLC_PointLoop
		rts

; now send to VDP
DLC_DrawVDP:
		move	#$2700,sr
		lea	VDP_Data_Port,a6
		move.l	#$4D340003,4(a6)
		lea	$FF0000+(26*$50)+66,a0
		moveq	#10/2,d0

.drawLoop	move.l	(a0)+,(a6)
		dbf	d0,.drawLoop

		move.w	LevSel_Pos.w,d0
		lsl.w	#2,d0
		move.l	DLC_VDPPos(pc,d0.w),a0

		move.l	Bought_Items.w,d6
		moveq	#$1A,d1
		btst	d5,d6
		bne.s	.draw
		moveq	#$1C,d1

.draw		move.w	d1,(a0)
.rts		move	#$2300,sr
		rts

DLC_VDPPos:	dc.l 0, 0, $FF0000+(4*$50)+$4A, $FF0000+(5*$50)+$4A, $FF0000+(6*$50)+$4A, $FF0000+(7*$50)+$4A, $FF0000+(8*$50)+$4A, $FF0000+(9*$50)+$4A, $FF0000+(10*$50)+$4A
		dc.l 0, 0, 0, $FF0000+(14*$50)+$4A, 0, 0, 0, 0, 0, 0

DLC_ConfirmBuy:
		btst	d5,d6		;; if bought already
		bne.s	.bought
		moveq	#0,d0
		move.w	LevSel_Pos.w,d0
		lsl.w	#2,d0
		lea	DLC_PriceList,a0
		move.l	(a0,d0.w),d1
		bmi.s	.end

		move.l	DCL_Rings.w,d2
		cmp.l	d1,d2
		blo.s	.error

		bset	d5,d6
		move.l	d6,Bought_Items.w
		bsr	BuyItem

.bought		moveq	#$FFFFFF80+$21,d0
		bsr	PlaySound
		move.l	d6,-(sp)
		lea	Text_Bought,a1
		bsr	LoadTip_
		move.l	(sp)+,d6
		moveq	#0,d0
		rts

.error		moveq	#$FFFFFF80+$19,d0
		bsr	PlaySound
		move.l	d6,-(sp)
		lea	Text_NotEnough,a1
		bsr	LoadTip_
		move.l	(sp)+,d6

.end		moveq	#-1,d0
		rts

DLC_GoGameMode:
		move.w	d0,-(sp)
		moveq	#30,d5
		move.l	Bought_Items.w,d6
		bclr	d5,d6
		bsr	DLC_ConfirmBuy
		bmi.s	.rts
		bclr	#30,d6
		move.l	d6,Bought_Items.w

		move.w	(sp)+,d0
		move.b	d0,$FFFFF600.w
		addq.l	#8,sp
		rts

.rts		addq.l	#2,sp
DLC_AirHorn_rts:
		rts

DLC_AltMusic:
		moveq	#Bought_AltMusic,d5
		move.l	Bought_Items.w,d6
		btst	d5,d6		;; if bought already,
		bne.s	.bought
		bsr	DLC_ConfirmBuy
		bmi.s	DLC_AirHorn_rts
		bset	#Used_AltMusic,d6		; use alt music
		move.l	d6,Bought_Items.w
		jmp	PlayZoneMusic

.bought		moveq	#$1A,d1
		lea	Text_Disable,a1
		bchg	#Used_AltMusic,d6
		beq.s	.draw
		moveq	#$1C,d1
		lea	Text_Enable,a1

.draw		move.w	d1,$FF0000+(9*$50)+$4A
		move.l	d6,Bought_Items.w
		bsr	LoadTip
		jmp	PlayZoneMusic

DLC_AirHorn:
		moveq	#Bought_AirHorn,d5
		move.l	Bought_Items.w,d6
		btst	d5,d6			;; if bought already,
		bne.s	.bought2
		bsr	DLC_ConfirmBuy
		bmi.s	DLC_AirHorn_rts
		bclr	#Used_AirHorn,d6		; use alt music

.bought2	moveq	#$1A,d1
		lea	Text_Disable,a1
		bchg	#Used_AirHorn,d6
		beq.s	.draw2
		moveq	#$1C,d1
		lea	Text_Enable,a1

.draw2		move.w	d1,$FF0000+(14*$50)+$4A
		move.l	d6,Bought_Items.w
		bra	LoadTip

DLC_Boobies_:
		moveq	#Bought_Boobs,d5
		move.l	Bought_Items.w,d6
		btst	d5,d6			;; if bought already,
		bne.s	.bought2
		bsr	DLC_ConfirmBuy
		bmi	DLC_AirHorn_rts
		bclr	#Used_Boobs,d6		; use alt music

.bought2	moveq	#$1A,d1
		lea	Text_Disable,a1
		bchg	#Used_Boobs,d6
		beq.s	.draw2
		moveq	#$1C,d1
		lea	Text_Enable,a1

.draw2		move.w	d1,$FF0000+(15*$50)+$4A
		move.l	d6,Bought_Items.w
		bra	LoadTip

DLC_ExtCam:
		move.l	Bought_Items.w,d6
		moveq	#$1A,d1
		lea	Text_Disable,a1
		bchg	#Bought_ExtCam,d6
		beq.s	.draw
		moveq	#$1C,d1
		lea	Text_Enable,a1

.draw		move.l	d6,Bought_Items.w
		move.w	d1,$FF0000+(8*$50)+$4A
		bsr	LoadTip
		moveq	#$FFFFFF80+$21,d0
		bra	PlaySound

DLC_Sekrit_:
		moveq	#30,d5
		move.l	Bought_Items.w,d6
		bclr	d5,d6
		bsr	DLC_ConfirmBuy
		bmi	DLC_AirHorn_rts
		bclr	#30,d6
		move.l	d6,Bought_Items.w
		bra	DLC_Sekrit__

DLC_new_:
		move.l	#$300,$FFFFFE10.w
DLC_new__:
	SRAMenable
		moveq	#0,d2
		moveq	#100,d1
		moveq	#3,d3
		move.b	d2,Current_Character.w
		move.w	d2,LevSel_Pos.w
		move.l	d1,DCL_Rings.w
		move.l	d2,Bought_Items.w
		move.b	d2,$FFFFFE30.w ; clear lamppost count

		lea	SRAM_Start,a2
		move.b	d2,SRAM_Char(a2)	; move character id to SRAM
		movep.w	d2,SRAM_LastLVL(a2)	; move the level id to last level been at
		move.b	d3,SRAM_Lives(a2)	; move lives amount to SRAM
		move.b	d3,$FFFFFE12.w	; move lives amount to SRAM
		movep.l	d1,SRAM_Rings(a2)	; set rings amount
		movep.l	d2,SRAM_Items(a2)	; set bought items
		move.b	d2,SRAM_GameCompl(a2)	; ckear if game is complete
	SRAMdisable
DLC_rts_690:
		rts

DLC_BuyLife_:
		cmpi.b	#99,$FFFFFE12.w
		blo.s	.buy
		moveq	#$FFFFFF80+$19,d0
		bsr	PlaySound
		lea	Text_AllLives,a1
		bra	LoadTip_

.buy		moveq	#30,d5
		move.l	Bought_Items.w,d6
		bclr	d5,d6
		bsr	DLC_ConfirmBuy
		bmi.s	DLC_rts_690
		bclr	#30,d6
		move.l	d6,Bought_Items.w

		addq.b	#1,$FFFFFE12.w
		moveq	#$FFFFFF8D,d0
		jmp	PlaySample	; play extra life music

DLC_TipDay_:
		moveq	#30,d5
		move.l	Bought_Items.w,d6
		bclr	d5,d6
		bsr	DLC_ConfirmBuy
		bmi.s	DLC_TipDay_rts
		bclr	#30,d6
		move.l	d6,Bought_Items.w

		jsr	RandomNumber
		lsr.w	#7,d1
		andi.l	#$7C,d1
		move.l	DLC_TipList(pc,d1.w),a1

LoadTip:
		bsr.s	LoadTip_init
		; TIP:
		move.l	#$00310026,(a6)
		move.l	#$002D001C,(a6)
		move.w	#0,(a6)
		bra.s	LoadTip_load

LoadTip_init:
		moveq	#0,d6
		moveq	#32,d7
		moveq	#0,d0
		move.b	(a1)+,d6
		sub.b	d6,d7
		lea	VDP_Data_Port,a6
		move.l	#$49060003,4(a6)
		rts

LoadTip_:
		bsr.s	LoadTip_init

LoadTip_load:
.load		move.b	(a1)+,d0
		move.w	d0,(a6)
		dbf	d6,.load

.empty		move.w	#0,(a6)
		dbf	d7,.empty
DLC_TipDay_rts:
		rts

DLC_TipList:	dc.l DLC_TL_Useless, DLC_TL_Debug, DLC_TL_Waste, DLC_TL_Stolen, DLC_TL_GS, DLC_TL_Rings, DLC_TL_SRSBIZ, DLC_TL_amusing
		dc.l DLC_TL_shrek, DLC_TL_TITS, DLC_TL_Wrong, DLC_TL_King, DLC_TL_YOLO, DLC_TL_Weed, DLC_TL_Blank, DLC_TL_Gender
		dc.l DLC_TL_Code, DLC_TL_Markey, DLC_TL_lel, DLC_TL_SHC, DLC_TL_S3k, DLC_TL_LSD, DLC_TL_Internet, DLC_TL_Kikko
		dc.l DLC_TL_MLPDat, DLC_TL_Pay, DLC_TL_Homie, DLC_TL_LGBT, DLC_TL_Dinner, DLC_TL_SGS, DLC_TL_Satan, DLC_TL_Mine

DLC_Source:
		moveq	#30,d5
		move.l	Bought_Items.w,d6
		bclr	d5,d6
		bsr	DLC_ConfirmBuy
		bmi.s	DLC_rts
		bclr	#30,d6
		move.l	d6,Bought_Items.w

		moveq	#$FFFFFF80,d0
		bsr.w	PlaySound
		moveq	#$FFFFFF9A,d0
		bra.w	PlaySample

DLC_Secret:
		moveq	#30,d5
		move.l	Bought_Items.w,d6
		bclr	d5,d6
		bsr	DLC_ConfirmBuy
		bmi.s	DLC_rts
		bclr	#30,d6
		move.l	d6,Bought_Items.w

		move.w	#$703,$FFFFFE10.w
		addq.l	#8,sp
DLC_rts:
		rts

DLC_SoniPlane:
		moveq	#$FFFFFFE5+2,d0
		jsr	PlayMusic
		bra.s	.doRand

.loop
		move.b	#4,VBlank_Routine.w
		bsr.w	DelayProgram		; make sure music fades out correctly
		dbf	d0,.loop

.doRand		jsr	RandomNumber
		lsr.l	#7,d1
		move.w	d1,Music_EnabledChans.w
		lsr.l	#7,d1
		andi.b	#$3F,d1
		moveq	#0,d0
		move.b	d1,d0
		bra.s	.loop

; common routine to load the selection screen
LoadS3Stuff:
		move	#$2700,sr
		lea	(VDP_control_port).l,a6
		move.w	$FFFFF60C.w,d0
		andi.b	#$BF,d0
		move.w	d0,(a6)
		move.w	#$8004,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$8230,(a6)
		move.w	#$8700,(a6)
		move.w	#$8C81,(a6)
		move.w	#$9001,(a6)
		move.w	#$8B00,(a6)
		bsr.w	ClearScreen

		lea	$FFFFAC00.w,a0
		move.l	#(($FFFFB000-$FFFFAC00)/4)-1,d0
		moveq	#0,d1

.clr		move.l	d1,(a0)+
		dbf	d0,.clr

		lea	$FFFFF700.w,a0
		move.l	#(($FFFFF760-$FFFFF700)/4)-1,d0

.clr2		move.l	d1,(a0)+
		dbf	d0,.clr2

		bsr	ClrObjRAM
		clr.w	DMA_Buffer_Start.w			; clear start of the DMA queue
		move.l	#DMA_Buffer_Start,DMA_Buffer_End.w	; reset address pointer of DMA queue
		move.b	#4,VBlank_Routine.w
		bsr.w	DelayProgram		; make sure music fades out correctly

	;	move.b	#$E4,d0
	;	bsr.w	PlaySound	; fade out music

		move	#$2700,sr
		move.l	#$42000000,VDP_control_port
		lea	ArtNem_S22POptions,a0
		bsr.w	NemDec
		move	#$2300,sr

		lea	$FF0000,a1
		lea	(MapEni_S22POptions).l,a0
		move.w	#$6000,d0
		bsr.w	EniDec
		move.b	#4,VBlank_Routine.w
		bsr.w	DelayProgram		; make sure music fades out correctly

		lea	$FF0000,a1
		move.l	#$60000003,d0
		moveq	#$27,d1
		moveq	#$1B,d2
		jsr	ShowVDPGraphics

		lea	$FF0000,a3
		move.w	#($460/2)-1,d1
		moveq	#0,d0

loc_7B2C:
		move.l	d0,(a3)+
		dbf	d1,loc_7B2C	; clear area to make sure it will not be corrupted

		lea	$FF0000,a3
		move.l	LS_TextData.w,a1
		move.l	LS_OffsetTable.w,a5
		move.l	LS_ExtraRowData.w,a4
		moveq	#0,d5
		move.b	LS_LineLenght.w,d5
		moveq	#0,d0
		move.w	(a5)+,d1
		moveq	#0,d4

levsel_drawloop:
		move.w	(a5)+,d3	; get offset
		lea	(a3,d3.w),a2	; set position offset to a2
		moveq	#0,d2		; clear d2
		move.b	(a1)+,d2	; get transfer lenght to d2
		move.w	d2,d3		; copy to d3 (00XX where XX is contents of a1+)

.copy		move.b	(a1)+,d0	; copy next byte
		move.w	d0,(a2)+	; move 00XX to RAM (XX is contents of a1+)
		dbf	d2,.copy	; loop until d2 is 0

		move.w	d5,d2		; check against $D (13 dec)
		sub.w	d3,d2		; get lenght of last transfer
		blo.s	loc_7B70	; I think this means if was longer or same, skip

.fill		move.w	#0,(a2)+
		dbf	d2,.fill	; fill extra space with blank

loc_7B70:
		jsr	(a4)
		addq.l	#4,d4
		dbf	d1,levsel_drawloop; loop for all entries

		move.l	LS_SpecialScreen.w,a1
		jsr	(a1)

		move.b	#4,VBlank_Routine.w
		bsr.w	DelayProgram		; make sure music fades out correctly

		lea	$FF0000,a1
		move.l	#$40000003,d0
		moveq	#$27,d1
		moveq	#$1B,d2
		jmp	ShowVDPGraphics	; finally send to plane mappings

SoundTest:
		move.b	$FFFFF605.w,d1
		andi.b	#3,d1
		bne.s	loc_7E74
		subq.w	#1,LevSel_MoveTimer.w
		bpl.s	LevSel_NoMove		; if cant move

loc_7E74:
		move.w	#$B,LevSel_MoveTimer.w
		moveq	#0,d2
		move.b	LS_MaxSel.w,d2
		move.b	$FFFFF605.w,d1
		andi.b	#3,d1
		beq.s	LevSel_NoMove
		move.w	LevSel_Pos.w,d0
		btst	#0,d1
		beq.s	.noup
		subq.w	#1,d0
		bcc.s	.noup
		move.w	d2,d0
		subq.w	#1,d0

.noup		btst	#1,d1
		beq.s	.noDown
		addq.w	#1,d0
		cmp.w	d2,d0
		bcs.s	.noDown
		moveq	#0,d0

.noDown		move.w	d0,LevSel_Pos.w
ls_null:
		rts
; ---------------------------------------------------------------------------

LevSel_NoMove:
		cmp.l	#LevSel_TextData,LS_TextData.w
		bne.s	ls_null
		cmpi.w	#18,LevSel_Pos.w
		bne.s	.checksound
		lea	Sound_test_sound+1.w,a0
		lea	PlaySound,a1
		moveq	#$CF-$80+10,d2
		moveq	#$80-10,d3
		bra.s	.common

.checksound	cmpi.w	#19,LevSel_Pos.w
		bne.w	LevSel_NotSndTest
		moveq	#$FF-$E3,d2
		moveq	#$FFFFFFE4,d3
		lea	Sound_test_sound.w,a0
		lea	PlayMusicFade,a1

.common		move.b	(a0),d0
		move.b	$FFFFF605.w,d1
		btst	#2,d1
		beq.s	.noLeft
		subq.b	#1,d0
		bpl.s	.noLeft
		add.b	d2,d0

.noLeft		btst	#3,d1
		beq.s	.NoRight
		addq.b	#1,d0
		cmp.b	d2,d0
		blo.s	.NoRight
		sub.b	d2,d0

.NoRight	btst	#6,d1
		beq.s	.noA
		addi.b	#$10,d0
		cmp.b	d2,d0
		blo.s	.noA
		sub.b	d2,d0

.noA		btst	#4,d1
		beq.s	.noB
		subi.b	#$10,d0
		bpl.s	.noB
		add.b	d2,d0

.noB		move.b	d0,(a0)
		btst	#5,d1
		beq.w	ls_null
		move.b	#0,Music_StoreDAC.w
		cmpi.b	#$80-10,d3
		bne.s	.normal
		cmpi.b	#30,d0
		bge.s	.normal
		bset	#7,d0
		bra.w	PlaySample

.normal		tst.b	d0
		bne.s	.play
		moveq	#$FFFFFFE0,d0
		jmp	PlaySound

.play		add.b	d3,d0
		jmp	(a1)

; ---------------------------------------------------------------------------

LevSel_NotSndTest:
		move.b	$FFFFF605.w,d1
		andi.b	#$C,d1
		beq.s	LevSel_NoUDLR

		move.w	LevSel_Pos.w,d0
		move.l	LS_LSTable.w,a1
		move.b	(a1,d0.w),d0
		move.w	d0,LevSel_Pos.w
		bra.s	LevSel_NoUDLR

LevSel_LRTable:	dc.b 21-1,21-1,22-1, 22-1,23-1,23-1, 23-1,24-1,24-1, 25-1,25-1,26-1, 26-1,27-1,27-1, 28-1,28-1,28-1, 29-1,29-1
		dc.b 0, 3, 5, 7, 9, 12, 14, 16, 18-1, 18-1
		even

DLC_LRTable:	dc.b 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21
		even
; ---------------------------------------------------------------------------

LevSel_NoUDLR:
		cmpi.w	#18,LevSel_Pos.w
		bge.s	LevSel_fm
		btst	#5,$FFFFF605.w
		beq.s	locret_7F60
		addq.b	#1,Current_Character.w
		cmpi.b	#3,Current_Character.w
		bcs.s	locret_7F60
		move.b	#0,Current_Character.w

locret_7F60:
		rts

LevSel_fm:
		andi.b	#$70,$FFFFF605.w
		beq.s	locret_7F60

		move.w	#$1A,d1
		move.w	Music_EnabledChans.w,d2
		moveq	#0,d0
		move.w	LevSel_Pos.w,d0
		subi.w	#18,d0
		bchg	d0,d2
		bne.s	.enabled
		move.w	#$1C,d1

.enabled	lea	$FF0000+$4A+$50,a0
		subi.b	#2,d0
		move.l	d0,d3
		mulu.w	#$F0,d0
		adda.l	d0,a0

		cmpi.b	#9,d3
		bne.s	.normal
		lea	-$50(a0),a0

.normal		move.w	d1,(a0)
		move.w	d2,Music_EnabledChans.w

		cmpi.b	#10,d3
		bne.s	locsad
		stopZ80
		move.b	#$7F,($A01FFF).l; pause DAC
		move.b	#$7F,Music_StoreDAC.w
		startZ80

locsad:
		rts

DoHighLight:
		lea	$FF0000,a4
		move.l	LS_HighLight.w,a5
		lea	(VDP_data_port).l,a6
		moveq	#0,d0
		move.w	LevSel_Pos.w,d0
		lsl.w	#2,d0
		lea	(a5,d0.w),a3
		moveq	#0,d0
		move.b	(a3),d0
		mulu.w	#$50,d0
		moveq	#0,d1
		move.b	1(a3),d1
		add.w	d1,d0
		lea	(a4,d0.w),a1
		moveq	#0,d1
		move.b	(a3),d1
		lsl.w	#7,d1
		add.b	1(a3),d1
		addi.w	#$C000,d1
		lsl.l	#2,d1
		lsr.w	#2,d1
		ori.w	#$4000,d1
		swap	d1
		move.l	d1,VDP_control_port-VDP_data_port(a6)
		moveq	#0,d2
		move.b	LS_HighLenght.w,d2

loc_7FB2:
		move.w	(a1)+,d0
		add.w	d3,d0
		move.w	d0,(a6)
		dbf	d2,loc_7FB2
		addq.w	#2,a3
		moveq	#0,d0
		move.b	(a3),d0
		beq.s	.end
		mulu.w	#$50,d0
		moveq	#0,d1
		move.b	1(a3),d1
		add.w	d1,d0
		lea	(a4,d0.w),a1
		moveq	#0,d1
		move.b	(a3),d1
		lsl.w	#7,d1
		add.b	1(a3),d1
		addi.w	#$C000,d1
		lsl.l	#2,d1
		lsr.w	#2,d1
		ori.w	#$4000,d1
		swap	d1
		move.l	d1,VDP_control_port-VDP_data_port(a6)
		move.w	(a1)+,d0
		add.w	d3,d0
		move.w	d0,(a6)
.end		rts

DoPlayerSel:
		cmpi.w	#19,LevSel_Pos.w
		beq.s	SoundTestDraw
		cmpi.w	#18,LevSel_Pos.w
		beq.s	SoundTestDraw2
		bgt.s	locend1

; ---------------------------------------------------------------------------

.doPlayer	move.l	#$419C0003,(VDP_control_port).l
		moveq	#0,d0
		move.b	Current_Character.w,d0
		bra.s	loc_8020

SoundTestDraw2:
		move.l	#$4CA00003,(VDP_control_port).l
		moveq	#0,d0
		move.b	Sound_test_sound+1.w,d0
		bra.s	loc_8020

SoundTestDraw:
		move.l	#$4D200003,(VDP_control_port).l
		moveq	#0,d0
		move.b	Sound_test_sound.w,d0

loc_8020:
		move.b	d0,d2
		lsr.b	#4,d0
		bsr.s	sub_8028
		move.b	d2,d0
; End of function sub_8012


; =============== S U B R O U T I N E =======================================


sub_8028:
		andi.w	#$F,d0
		cmpi.b	#$A,d0
		bcs.s	loc_8036
		addi.b	#4,d0

loc_8036:
		addi.b	#$10,d0
		add.w	d3,d0
		move.w	d0,(a6)
locend1:
		rts
; End of function sub_8028

SoundLevelDraw:
		lea	$FFFFF000+$70,a0
		moveq	#8,d4
		move.l	#$40B80003,d1
		lea	(VDP_data_port).l,a6
		move.w	#20,d5

.loop		move.l	d1,VDP_control_port-VDP_data_port(a6)
		move.w	#0,d3
		cmp.w	LevSel_Pos.w,d5
		bne.s	.go
		move.w	#$6000,d3

.go		move.b	$E(a0),d0
		bsr.s	loc_8020
		move.w	#0,(a6)
		move.w	$E(a0),d0
		bsr.s	loc_8020
		move.w	#0,(a6)
		move.w	$10(a0),d0
		bsr.s	loc_8020

		lea	$30(a0),a0
		addi.l	#$1800000,d1
		addi.w	#1,d5
		dbf	d4,.loop

		subi.l	#$800000-$C0000,d1
		move.l	d1,VDP_control_port-VDP_data_port(a6)

		move.w	#0,d3
		cmp.w	LevSel_Pos.w,d5
		bne.s	.go1
		move.w	#$6000,d3
.go1		move.b	Music_StoreDAC.w,d0
		bra.w	loc_8020

AnimateTiles_DoAniPLC:
		lea	$FFFFF700.w,a3

loc_286E8:

		move.w	(a2)+,d6
		bpl.s	loc_286EE
		rts
; ---------------------------------------------------------------------------

loc_286EE:
		subq.b	#1,(a3)
		bcc.s	loc_28734
		moveq	#0,d0
		move.b	1(a3),d0
		cmp.b	6(a2),d0
		bcs.s	loc_28704
		moveq	#0,d0
		move.b	d0,1(a3)

loc_28704:
		addq.b	#1,1(a3)
		move.b	(a2),(a3)
		bpl.s	loc_28712
		add.w	d0,d0
		move.b	9(a2,d0.w),(a3)

loc_28712:
		move.b	8(a2,d0.w),d0
		lsl.w	#5,d0
		move.w	4(a2),d2
		move.l	(a2),d1
		andi.l	#$FFFFFF,d1
		add.l	d0,d1
		moveq	#0,d3
		move.b	7(a2),d3
		lsl.w	#4,d3
		jsr	QueueDMATransfer

loc_28734:
		move.b	6(a2),d0
		tst.b	(a2)
		bpl.s	loc_2873E
		add.b	d0,d0

loc_2873E:
		addq.b	#1,d0
		andi.w	#$FE,d0
		lea	8(a2,d0.w),a2
		addq.w	#2,a3
		dbf	d6,loc_286EE
		rts

WaitPayPal:
	SRAMDisable
		lea	Text_Connect(pc),a1
		jsr	LoadTip_

		jsr	RandomNumber
		andi.w	#$3C,d1
		moveq	#30-1,d7	; 30 frames of delay
		add.w	d1,d7		; add random offset

.delay		move.b	#8,VBlank_Routine.w
		bsr.w	DelayProgram
		dbf	d7,.delay

		jsr	RandomNumber
		lsr.w	#8,d1
		andi.w	#$C,d1
		move.l	.list(pc,d1.w),a1
		jmp	LoadTip_

.list		dc.l Text_ConnRefused, Text_ConnTimeOut, Text_NoConn, Text_ConnReset


DLC_Sekrit__:
		moveq	#.list2end-.list2-4,d1

.loop		move.b	#8,VBlank_Routine.w
		bsr.w	DelayProgram
		move.b	#8,VBlank_Routine.w
		bsr.w	DelayProgram

		move.l	.list2(pc,d1.w),a1
		jsr	LoadTip_
		subq.w	#4,d1
		bpl.s	.loop
		rts

.list2		dc.l Text_Main4, Text_joke2, Text_joke2, Text_joke2, Text_joke2, Text_joke, Text_joke, Text_joke, Text_joke, Text_joke, Text_joke, Text_joke, Text_joke, Text_Main3, Text_Main2, Text_Main, Text_Beginnin6, Text_Beginnin5, Text_Beginnin4, Text_Beginnin3, Text_Beginnin2, Text_Beginnin
.list2end
