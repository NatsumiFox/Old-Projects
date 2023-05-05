; ===========================================================================
; ---------------------------------------------------------------------------
; common swap routines
; ---------------------------------------------------------------------------

SwapCheckInRange:
		move.w	Camera_X_Pos.w,d1		; NAT: Get camera positions
		add.w	#320/2,d1
		move.w	Camera_Y_Pos.w,d2
		add.w	#224/2,d2

		cmp.w	(a2)+,d1			; left edge
		blo.s	.skip
		cmp.w	(a2)+,d1			; right edge
		bhs.s	.skip
		cmp.w	(a2)+,d2			; top edge
		blo.s	.skip
		cmp.w	(a2)+,d2			; bottom edge
		blo.s	SwapToNormal.rts

.skip		addq.w	#4,sp				; do not return
		clr.b	SwapNum.w			; clear swap num

SwapToNormal:
		move.l	BoxLoc_Level.w,d1		; get box location
		cmp.l	a3,d1				; check if already there
		beq.s	.rts				; if so, do not reset(!)

		move.l	a3,BoxLoc_Level.w		; save new box loc and shit
		move.l	a3,BoxLoc_Play1.w
		move.l	a3,BoxLoc_Play2.w
		move.w	d0,SpawnBoxPos.w
.rts		rts

SwapToAlt:
		move.l	BoxLoc_Level.w,d1		; get box location
		cmp.l	a4,d1				; check if already there
		beq.s	.rts				; if so, do not reset(!)

		move.l	a4,BoxLoc_Level.w		; save new box loc and shit
		move.l	a4,BoxLoc_Play1.w
		move.l	a4,BoxLoc_Play2.w
		swap	d0
		move.w	d0,SpawnBoxPos.w
.rts		rts

SwapInArea:
		move.w	Camera_X_Pos.w,d1		; NAT: Get camera positions
		add.w	#320/2,d1
		move.w	Camera_Y_Pos.w,d2
		add.w	#224/2,d2
		move.w	(a2)+,d3			; NAT: get num of boxes

.loop		cmp.w	(a2)+,d1			; left edge
		blo.s	.skip
		cmp.w	(a2),d1				; right edge
		bhs.s	.skip
		cmp.w	2(a2),d2			; top edge
		blo.s	.skip
		cmp.w	4(a2),d2			; bottom edge
		blo.s	.rts

.skip		addq.w	#6,a2				; align
		dbf	d3,.loop			; nat loop til done
		moveq	#0,d1				; z
.rts		tst.w	d1				; set z
		rts					; z = outside, nz = inside

SwapFindNext:
		move.w	Camera_X_Pos.w,d1		; NAT: Get camera positions
		add.w	#320/2,d1
		move.w	Camera_Y_Pos.w,d2
		add.w	#224/2,d2

.loop		move.w	(a2)+,d3			; NAT: get offset
		sub.b	SwapNum.w,d3			; get the current offset
		lea	-2(a2,d3.w),a1			; NAT: a1 = data
		addq.b	#2,SwapNum.w			; NAT: increase swap num

		cmp.w	(a1)+,d1			; left edge
		blo.s	.skip
		cmp.w	(a1)+,d1			; right edge
		bhs.s	.skip
		cmp.w	(a1)+,d2			; top edge
		blo.s	.skip
		cmp.w	(a1)+,d2			; bottom edge
		blo.s	.rts				; branch if inside of it

.skip		dbf	d0,.loop			; nat loop til done
		clr.b	SwapNum.w			; NAT: found none
.rts		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; swap fixes AIZ2
; ---------------------------------------------------------------------------

Swaps_AIZ2:
		cmp.b	#6,Player_2+routine.w		; check if pl2 is dead
		blo.s	.notded				; branch if not dead
		cmp.b	#6,Player_1+routine.w		; check if pl1 is dead
		bhs.s	SwapFindNext.rts		; branch if dead

.notded		lea	SwapList_AIZ2(pc),a2		; NAT: Get swap list to a1
		moveq	#0,d0				; NAT: 1 entry
		tst.b	SwapNum.w			; NAT: check if swap num is 0
		beq.w	SwapFindNext			; NAT: if is, branch
		move.b	SwapNum.w,d0			; NAT: Get swap num
		add.w	-2(a2,d0.w),a2			; NAT: get final address

		move.l	#Ranges_AIZ2,a3
		move.l	#Ranges_AIZS,a4
		move.l	#(Boxes_AIZS-Ranges_AIZS)<<16|(Boxes_AIZ2-Ranges_AIZ2),d0
		jsr	SwapCheckInRange(pc)		; check if we are in area still

		btst	#0,Level_trigger_array.w	; check if button was pressed
		beq.w	SwapToNormal			; if not, branch

		jsr	SwapInArea(pc)			; check if in area
		beq.w	SwapToNormal			; if not, branch
		bra.w	SwapToAlt

SwapList_AIZ2:	dc.w .m0-SwapList_AIZ2	; 2

.m0	binclude "Levels/AIZ/Directions/2s0.dat"

; ===========================================================================
; ---------------------------------------------------------------------------
; swap fixes MGZ1
; ---------------------------------------------------------------------------

Swaps_MGZ1:
		cmp.b	#6,Player_2+routine.w		; check if pl2 is dead
		blo.s	.notded				; branch if not dead
		cmp.b	#6,Player_1+routine.w		; check if pl1 is dead
		bhs.w	SwapFindNext.rts		; branch if dead

.notded		lea	SwapList_MGZ1(pc),a2		; NAT: Get swap list to a1
		moveq	#0,d0				; NAT: 1 entry
		tst.b	SwapNum.w			; NAT: check if swap num is 0
		beq.w	SwapFindNext			; NAT: if is, branch
		move.b	SwapNum.w,d0			; NAT: Get swap num
		add.w	-2(a2,d0.w),a2			; NAT: get final address

		move.l	#Ranges_MGZ1,a3
		move.l	#Ranges_MGZS,a4
		move.l	#(Boxes_MGZS-Ranges_MGZS)<<16|(Boxes_MGZ1-Ranges_MGZ1),d0
		jsr	SwapCheckInRange(pc)		; check if we are in area still

		tst.b	Player_1+$2E.w			; check if player is carried
		bne.w	SwapToNormal			; if is, branch
		tst.b	Player_2+$2E.w			; (only spinner can carry player in this section)
		bne.w	SwapToNormal			; if is, branch

		jsr	SwapInArea(pc)			; check if in area
		beq.w	SwapToNormal			; if not, branch
		bra.w	SwapToAlt

SwapList_MGZ1:	dc.w .m0-SwapList_MGZ1	; 2

.m0	binclude "Levels/MGZ/Directions/1s0.dat"

; ===========================================================================
; ---------------------------------------------------------------------------
; swap fixes MGZ2
; ---------------------------------------------------------------------------

Swaps_MGZ2:
		cmp.b	#6,Player_2+routine.w		; check if pl2 is dead
		blo.s	.notded				; branch if not dead
		cmp.b	#6,Player_1+routine.w		; check if pl1 is dead
		bhs.w	SwapFindNext.rts		; branch if dead

.notded		lea	SwapList_MGZ2(pc),a2		; NAT: Get swap list to a1
		moveq	#5,d0				; NAT: 6 entries
		tst.b	SwapNum.w			; NAT: check if swap num is 0
		beq.w	SwapFindNext			; NAT: if is, branch
		move.b	SwapNum.w,d0			; NAT: Get swap num
		add.w	-2(a2,d0.w),a2			; NAT: get final address

		move.l	#Ranges_MGZ2,a3
		move.l	#Ranges_MGZA,a4
		move.l	#(Boxes_MGZA-Ranges_MGZA)<<16|(Boxes_MGZ2-Ranges_MGZ2),d0
		jsr	SwapCheckInRange(pc)		; check if we are in area still

		cmp.b	#2,SwapNum.w			; check if swaps #0
		beq.s	.othershit			; if so, branch
		cmp.b	#12,SwapNum.w			; check if swaps #5
		beq.s	.platforms			; if so, branch

		tst.b	Player_1+$2E.w			; check if player is carried
		bne.w	SwapToNormal			; if is, branch
		tst.b	Player_2+$2E.w			; (only spinner can carry player in this section)
.doit		bne.w	SwapToNormal			; if is, branch

		jsr	SwapInArea(pc)			; check if in area
		beq.w	SwapToNormal			; if not, branch
		bra.w	SwapToAlt

.othershit	tst.b	Level_trigger_array+$D.w	; check if button was pressed
		bra.s	.doit				; save bytes

.platforms	tst.b	Level_trigger_array+4.w		; check if platforms were activated
		bra.s	.doit				; save bytes

SwapList_MGZ2:	dc.w .m0-SwapList_MGZ2	; 2
		dc.w .m1-SwapList_MGZ2	; 4
		dc.w .m2-SwapList_MGZ2	; 6
		dc.w .m3-SwapList_MGZ2	; 8
		dc.w .m4-SwapList_MGZ2	; 10
		dc.w .m5-SwapList_MGZ2	; 12

.m0	binclude "Levels/MGZ/Directions/2s0.dat"
.m1	binclude "Levels/MGZ/Directions/2s1.dat"
.m2	binclude "Levels/MGZ/Directions/2s2.dat"
.m3	binclude "Levels/MGZ/Directions/2s3.dat"
.m4	binclude "Levels/MGZ/Directions/2s4.dat"
.m5	binclude "Levels/MGZ/Directions/2s5.dat"

; ===========================================================================
; ---------------------------------------------------------------------------
; swap fixes CNZ2
; ---------------------------------------------------------------------------

Swaps_CNZ2:
		cmp.b	#6,Player_2+routine.w		; check if pl2 is dead
		blo.s	.notded				; branch if not dead
		cmp.b	#6,Player_1+routine.w		; check if pl1 is dead
		bhs.w	SwapFindNext.rts		; branch if dead

.notded		lea	SwapList_CNZ2(pc),a2		; NAT: Get swap list to a1
		moveq	#0,d0				; NAT: 1 entry
		tst.b	SwapNum.w			; NAT: check if swap num is 0
		beq.w	SwapFindNext			; NAT: if is, branch
		move.b	SwapNum.w,d0			; NAT: Get swap num
		add.w	-2(a2,d0.w),a2			; NAT: get final address

		move.l	#Ranges_CNZ2,a3
		move.l	#Ranges_CNZB,a4
		move.l	#(Boxes_CNZB-Ranges_CNZB)<<16|(Boxes_CNZ2-Ranges_CNZ2),d0
		jsr	SwapCheckInRange(pc)		; check if we are in area still

		jsr	SwapInArea(pc)			; check if in area
		beq.w	SwapToNormal			; if not, branch

		lea	Player_1.w,a5			; get pl to a0
		cmp.b	#2,BoxWinner.w			; check if winrar
		bne.s	.sunak				; Tiles not winrar
		lea	Player_2.w,a5			; get pl to a0

.sunak		move.w	#$4C0,d1			; get y-pos
		cmp.w	$14(a5),d1			; check if below
		blt.s	.ckbtm				; if so, check bottom

		move.w	#$2D80,d1			; get x-pos
		cmp.w	$10(a5),d1			; check if to right of it
		blt.w	SwapToAlt			; if so, goto alt
		bra.w	SwapToNormal			; else just goto normal

.ckbtm		cmp.w	#$760,$14(a5)			; check if really low
		bgt.w	SwapToAlt			; if so, branch
		rts

SwapList_CNZ2:	dc.w .m0-SwapList_CNZ2	; 2

.m0	binclude "Levels/CNZ/Directions/2s0.dat"

; ===========================================================================
; ---------------------------------------------------------------------------
; swap fixes ICZ1
; ---------------------------------------------------------------------------

Swaps_ICZ1:
		cmp.b	#6,Player_2+routine.w		; check if pl2 is dead
		blo.s	.notded				; branch if not dead
		cmp.b	#6,Player_1+routine.w		; check if pl1 is dead
		bhs.w	SwapFindNext.rts		; branch if dead

.notded		lea	SwapList_ICZ1(pc),a2		; NAT: Get swap list to a1
		moveq	#0,d0				; NAT: 1 entry
		tst.b	SwapNum.w			; NAT: check if swap num is 0
		beq.w	SwapFindNext			; NAT: if is, branch
		move.b	SwapNum.w,d0			; NAT: Get swap num
		add.w	-2(a2,d0.w),a2			; NAT: get final address

		move.l	#Ranges_ICZ1,a3
		move.l	#Ranges_ICZA,a4
		move.l	#(Boxes_ICZA-Ranges_ICZA)<<16|(Boxes_ICZ1-Ranges_ICZ1),d0
		jsr	SwapCheckInRange(pc)		; check if we are in area still

		jsr	SwapInArea(pc)			; check if in area
		beq.w	SwapToNormal			; if not, branch

		btst	#3,Player_1+status.w		; check if standing on obj
		beq.s	.tails				; if no, branch
		move.w	Player_1+interact.w,a1		; get the object player is standing on
		cmp.l	#loc_89F38,(a1)			; check if its the Obj_ICZPathFollowPlatform
		beq.w	SwapToAlt			; if yes, then use alt layout

.tails		btst	#3,Player_2+status.w		; check if standing on obj
		beq.s	.nope				; if no, branch
		move.w	Player_2+interact.w,a1		; get the object player is standing on
		cmp.l	#loc_89F38,(a1)			; check if its the Obj_ICZPathFollowPlatform
		beq.w	SwapToAlt			; if yes, then use alt layout

.nope		bra.w	SwapToNormal

SwapList_ICZ1:	dc.w .m0-SwapList_ICZ1	; 2

.m0	binclude "Levels/ICZ/Directions/1s0.dat"

; ===========================================================================
; ---------------------------------------------------------------------------
; swap fixes LBZ1
; ---------------------------------------------------------------------------

Swaps_LBZ1:
		cmp.b	#6,Player_2+routine.w		; check if pl2 is dead
		blo.s	.notded				; branch if not dead
		cmp.b	#6,Player_1+routine.w		; check if pl1 is dead
		bhs.w	SwapFindNext.rts		; branch if dead

.notded		lea	SwapList_LBZ1(pc),a2		; NAT: Get swap list to a1
		moveq	#1,d0				; NAT: 2 entries
		tst.b	SwapNum.w			; NAT: check if swap num is 0
		beq.w	SwapFindNext			; NAT: if is, branch
		move.b	SwapNum.w,d0			; NAT: Get swap num
		add.w	-2(a2,d0.w),a2			; NAT: get final address

		move.l	#Ranges_LBZ1,a3
		move.l	#Ranges_LBZK,a4
		move.l	#(Boxes_LBZK-Ranges_LBZK)<<16|(Boxes_LBZ1-Ranges_LBZ1),d0
		jsr	SwapCheckInRange(pc)		; check if we are in area still

		cmp.b	#2,SwapNum.w			; check if thingymajigger
		bne.s	.thingi				; if so, branch
		btst	#0,Level_trigger_array.w	; check if switch is pressed
.doit		beq.w	SwapToNormal			; if not, branch
		bra.w	SwapToAlt			; if so, branch

.thingi		cmpi.w	#$A0,Camera_min_Y_pos.w		; check if camera min y is this
		beq.w	SwapToAlt			; if so, is knuckles cutscene
		bra.w	SwapToNormal			; if not, branch

SwapList_LBZ1:	dc.w .m0-SwapList_LBZ1	; 2
		dc.w .m1-SwapList_LBZ1	; 4

.m0	binclude "Levels/LBZ/Directions/1s0.dat"
.m1	binclude "Levels/LBZ/Directions/1s1.dat"

; ===========================================================================
; ---------------------------------------------------------------------------
; swap fixes LBZ2
; ---------------------------------------------------------------------------

Swaps_LBZ2:
		cmp.b	#6,Player_2+routine.w		; check if pl2 is dead
		blo.s	.notded				; branch if not dead
		cmp.b	#6,Player_1+routine.w		; check if pl1 is dead
		bhs.w	SwapFindNext.rts		; branch if dead

.notded		lea	SwapList_LBZ2(pc),a2		; NAT: Get swap list to a1
		moveq	#2,d0				; NAT: 3 entries
		tst.b	SwapNum.w			; NAT: check if swap num is 0
		beq.w	SwapFindNext			; NAT: if is, branch
		move.b	SwapNum.w,d0			; NAT: Get swap num
		add.w	-2(a2,d0.w),a2			; NAT: get final address

		move.l	#Ranges_LBZ2,a3
		move.l	#Ranges_LBZB,a4
		move.l	#(Boxes_LBZB-Ranges_LBZB)<<16|(Boxes_LBZ2-Ranges_LBZ2),d0

		cmp.b	#2,SwapNum.w			; check if second swap
		ble.s	.trigger			; branch if first
		cmp.w	#$2680,Camera_X_Pos.w		; check if past certain point
		bgt.s	.normal				; branch if so
		cmp.w	#$300,Camera_Y_Pos.w		; check if above certain point
		blt.w	.normal				; branch if above

		cmp.w	#$25C0,Camera_X_Pos.w		; check if past certain point
		bgt.s	.rts				; branch if not
		cmp.w	#$600,Camera_Y_Pos.w		; check if above certain point
		bgt.w	SwapToAlt			; branch if below
.rts		rts

.normal		clr.b	SwapNum.w			; clear swap
		bra.w	SwapToNormal			; if above, branch

.trigger	jsr	SwapCheckInRange(pc)		; check if we are in area still
		btst	#0,Level_trigger_array+8.w	; check if switch is pressed
		beq.w	SwapToNormal			; if not, branch
		bra.w	SwapToAlt			; if so, branch

SwapList_LBZ2:	dc.w .m0-SwapList_LBZ2	; 2
		dc.w .m1-SwapList_LBZ2	; 4
		dc.w .m2-SwapList_LBZ2	; 6

.m0	binclude "Levels/LBZ/Directions/2s0.dat"
.m1	binclude "Levels/LBZ/Directions/2s1.dat"
.m2	binclude "Levels/LBZ/Directions/2s2.dat"

; ===========================================================================
; ---------------------------------------------------------------------------
; swap fixes FBZ1
; ---------------------------------------------------------------------------

Swaps_FBZ1:
		cmp.b	#6,Player_2+routine.w		; check if pl2 is dead
		blo.s	.notded				; branch if not dead
		cmp.b	#6,Player_1+routine.w		; check if pl1 is dead
		bhs.w	SwapFindNext.rts		; branch if dead

.notded		lea	SwapList_FBZ1(pc),a2		; NAT: Get swap list to a1
		moveq	#0,d0				; NAT: 1 entry
		tst.b	SwapNum.w			; NAT: check if swap num is 0
		beq.w	SwapFindNext			; NAT: if is, branch
		move.b	SwapNum.w,d0			; NAT: Get swap num
		add.w	-2(a2,d0.w),a2			; NAT: get final address

		move.l	#Ranges_FBZ1,a3
		move.l	#Ranges_FBZA,a4
		move.l	#(Boxes_FBZA-Ranges_FBZA)<<16|(Boxes_FBZ1-Ranges_FBZ1),d0
		jsr	SwapCheckInRange(pc)		; check if we are in area still

		jsr	SwapInArea(pc)			; check if in area
		beq.w	SwapToNormal			; if not, branch

		tst.b	OptionsBits.w			; check if alt mode
		bpl.w	SwapToNormal			; if not, branch
		bra.w	SwapToAlt			; else just goto alt

SwapList_FBZ1:	dc.w .m0-SwapList_FBZ1	; 2

.m0	binclude "Levels/FBZ/Directions/1s0.dat"

; ===========================================================================
; ---------------------------------------------------------------------------
; swap fixes SOZ2
; ---------------------------------------------------------------------------

Swaps_SOZ2:
		cmp.b	#6,Player_2+routine.w		; check if pl2 is dead
		blo.s	.notded				; branch if not dead
		cmp.b	#6,Player_1+routine.w		; check if pl1 is dead
		bhs.w	SwapFindNext.rts		; branch if dead

.notded		lea	SwapList_SOZ1(pc),a2		; NAT: Get swap list to a1
		moveq	#8,d0				; NAT: 8 entries
		tst.b	SwapNum.w			; NAT: check if swap num is 0
		beq.w	SwapFindNext			; NAT: if is, branch
		move.b	SwapNum.w,d0			; NAT: Get swap num
		and.w	#$7F,d0				; clear high bit
		add.w	-2(a2,d0.w),a2			; NAT: get final address

		move.l	#Ranges_SOZ2,a3
		move.l	#Ranges_SOZS,a4
		move.l	#(Boxes_SOZS-Ranges_SOZS)<<16|(Boxes_SOZ2-Ranges_SOZ2),d0
		jsr	SwapCheckInRange(pc)		; check if we are in area still

		move.b	SwapNum.w,d1			; NAT: Get swap num
		cmp.b	#$12,d1				; check if 12
		beq.s	.ckalt				; if so, yes!
		tst.b	OptionsBits.w			; check if alt layout
		bmi.s	.alt				; if so, check whiuch one to change to

		and.w	#$7F,d1				; clear high bit
		move.w	.addr-2(pc,d1.w),a1		; get addr
		tst.b	SwapNum.w			; check if bit set
		bpl.s	.k				; if not, branch
		bset	#0,d1				; set 0 bit

.k		move.b	.value-2(pc,d1.w),d1		; get value
		cmp.b	(a1),d1				; check how much time is left
		blo.s	.seton				; branch if less

		and.b	#$7F,SwapNum.w			; clear bit
		jsr	SwapInArea(pc)			; check if in area
		beq.w	SwapToNormal			; if not, branch
.swalt		bra.w	SwapToAlt

.seton		or.b	#$80,SwapNum.w			; set bit
.area		bra.w	SwapToNormal

.alt		cmp.b	#4,d1				; check if this is the large section
		bne.s	.area				; if not, load normal
		move.l	#Ranges_SOZB,a4			; load new layout
		move.l	#(Boxes_SOZB-Ranges_SOZB)<<16|(Boxes_SOZ2-Ranges_SOZ2),d0
		bra.s	.swalt

.addr		dc.w Level_trigger_array+6, Level_trigger_array+2, Level_trigger_array+3, Level_trigger_array+5
		dc.w Level_trigger_array+7, Level_trigger_array+$A,Level_trigger_array+9,Level_trigger_array+$F
.value		dc.b $20, $18, $7E, $18, $38, $14, $24, $18
		dc.b $20, $18, $2C, $18, $6E, $02, $6E, $02

.ckalt		jsr	SwapInArea(pc)			; check if in area
		beq.w	SwapToNormal			; if not, branch
		tst.b	OptionsBits.w			; check if alt mode
		bpl.w	SwapToNormal			; if not, branch
		bra.w	SwapToAlt			; else just goto alt

SwapList_SOZ1:	dc.w .m0-SwapList_SOZ1	; 2
		dc.w .m1-SwapList_SOZ1	; 4
		dc.w .m2-SwapList_SOZ1	; 6
		dc.w .m3-SwapList_SOZ1	; 8
		dc.w .m4-SwapList_SOZ1	; A
		dc.w .m5-SwapList_SOZ1	; C
		dc.w .m6-SwapList_SOZ1	; E
		dc.w .m7-SwapList_SOZ1	; 10
		dc.w .m9-SwapList_SOZ1	; 12

.m0	binclude "Levels/SOZ/Directions/2s0.dat"
.m1	binclude "Levels/SOZ/Directions/2s1.dat"
.m2	binclude "Levels/SOZ/Directions/2s2.dat"
.m3	binclude "Levels/SOZ/Directions/2s3.dat"
.m4	binclude "Levels/SOZ/Directions/2s4.dat"
.m5	binclude "Levels/SOZ/Directions/2s5.dat"
.m6	binclude "Levels/SOZ/Directions/2s7.dat"	; <- yep, fun mess here
.m7	binclude "Levels/SOZ/Directions/2s8.dat"
.m9	binclude "Levels/SOZ/Directions/2s9.dat"
; ===========================================================================
; ---------------------------------------------------------------------------
; Pan camera up a little in SOZ2
; ---------------------------------------------------------------------------

Obj_PanCamSOZ2:
		cmp.w	#Boxes_SOZS-Ranges_SOZS,SpawnBoxPos.w	; check if we are on special box
		bne.s	.chkdel					; if not, check delete
		move.w	CamFollow_Y.w,d0			; get cam follow Y to d0
		cmp.w	#$110,d0				; check if follow pos is up enough
		bge.s	.chkdel					; if not, check delete

		move.w	Camera_Y_Pos.w,d1			; get camera Y-pos
		add.w	#224/2,d1				; centre on screen
		subq.w	#8,d1					; sub 4 from camera y
		cmp.w	#$80,d1					; check for max
		bge.s	.nocap					; branch if no cap
		move.w	#$80,d1					; setup cap

.nocap		move.w	d1,Scroll_forced_Y_pos.w		; set to scroll force pos
		move.w	CamFollow_X.w,Scroll_forced_X_pos.w	; force x-pos
		st	Scroll_force_positions.w		; activate flag
.chkdel		jmp	Delete_Sprite_If_Not_In_Range.w		; delete if offscreen

; ===========================================================================
; ---------------------------------------------------------------------------
; swap fixes DEZ2
; ---------------------------------------------------------------------------

Obj_ExplodeDEZ2:
		move.w	#prio(0),priority(a0)
		btst	#5,OptionsBits.w		; check if bosses are on
		beq.w	.scrtst				; if not, welp

		lea	Player_1+x_pos.w,a1		; NAT: Get p1 to a1
		cmp.b	#2,BoxWinner.w			; check if Tails winrars
		bne.s	.notiles			; if not, branch
		lea	Player_2+x_pos.w,a1		; get p2 to a1

.notiles	cmp.w	#$340,4(a1)			; check if already above
		bls.w	.expcam				; if so, move camera
		cmp.w	#$35CC,(a1)			; check if in the tub
		bls.s	.scrtst				; if not, check onscreen
		move.l	#.explode,(a0)			; start splodin
		move.w	#$1018,$3A(a0)			; set explosion range

.explode	move.b	V_int_run_count+3.w,d0		; get v-int run ctr to d0
		and.b	#3,d0				; check if the 2 lsb's are set
		bne.s	.noexp				; if so, branch
		moveq	#$B4,d0				; play mine explosion sfx
		jsr	Play_Sound_2.w			;

		lea	Child6_MakeNormalExplosion,a2	; create normal explosion
		jsr	CreateChild6_Simple.w		;
		bne.s	.noexp				; if failed, skip
		move.b	#6,5(a1)			; some weird params
		bset	#7,$A(a1)			;
		jsr	loc_83E90			; set its position

.noexp		move.w	Camera_Y_Pos.w,d0		; get camera y-pos to d0
		add.w	#$80,d0				; make sure the explosion will be onscreen
		cmp.w	y_pos(a0),d0			; check if the camera is above us
		bgt.s	.scrtst				; if not, branch

		move.l	#.delay,(a0)			; just wait until despawn
		st	(ScrEvents_1).w			; apparently, the original game can handle this for us. Nice!
		move.b	#20,$39(a0)			; set some delay to make easier on eyes (and prevent issues)

.delay		subq.b	#1,$39(a0)			; decrease delay
		bpl.s	.scrtst				; branch if not over
		move.l	#.scrtst,(a0)			; quit worrying

		jsr	Create_New_Sprite.w		; create object to move camera
		bne.s	.scrtst				;
		move.l	#Obj_IncLevEndXGradual,(a1)	;
		move.w	#$3680,(__u_FA92).w		; set position to move to

.scrtst		jmp	Sprite_OnScreen_Test
.expcam		move.w	#$3680,Camera_max_X_pos.w	; expand camera
		bra.s	.scrtst

; ===========================================================================
; ---------------------------------------------------------------------------
; Object that runs these swap codes
; ---------------------------------------------------------------------------

Obj_SwapsActivate:
		move.w	Current_zone_and_act.w,d1
		ror.b	#1,d1
		lsr.w	#5,d1
		move.l	.swaprouts(pc,d1.w),a1		; get swap routine
		jsr	(a1)				; run it
		jmp	Delete_Sprite_If_Not_In_Range.w	; a long ass name if you ask me

.swaprouts	dc.l DC_NullRout, Swaps_AIZ2	; AIZ
		dc.l DC_NullRout, DC_NullRout	; HCZ
		dc.l Swaps_MGZ1, Swaps_MGZ2	; MGZ
		dc.l DC_NullRout, Swaps_CNZ2	; CNZ
		dc.l Swaps_FBZ1, DC_NullRout	; FBZ
		dc.l Swaps_ICZ1, DC_NullRout	; ICZ
		dc.l Swaps_LBZ1, Swaps_LBZ2	; LBZ
		dc.l DC_NullRout, DC_NullRout	; MHZ
		dc.l DC_NullRout, Swaps_SOZ2	; SOZ
		dc.l DC_NullRout, DC_NullRout	; LRZ
		dc.l DC_NullRout, DC_NullRout	; SSZ
		dc.l DC_NullRout, DC_NullRout	; DEZ
		dc.l [21] 0
		dc.l Ranges_HPZ			; HPZ
; ===========================================================================
