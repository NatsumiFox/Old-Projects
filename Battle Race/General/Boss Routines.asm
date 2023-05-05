; ---------------------------------------------------------------------------

Boss_Force_End:		; NAT: Some code here
		move.w	Camera_X_pos.w,d0
		move.w	d0,Camera_target_min_X_pos.w
		move.w	d0,Camera_target_max_X_pos.w
		move.w	d0,Camera_min_X_pos.w
		move.w	d0,Camera_max_X_pos.w
		add.w	#320/2,d0
		move.w	d0,$10(a0)

		move.w	Camera_Y_pos.w,d1
		move.w	d1,Camera_target_min_Y_pos.w
		move.w	d1,Camera_target_max_Y_pos.w
		move.w	d1,Camera_min_Y_pos.w
		move.w	d1,Camera_max_Y_pos.w
		add.w	#224,d1
		move.w	d1,$14(a0)
		jmp	Obj_EndSignControl_HitHUD

Boss_Force_End_3:		; NAT: New screelock method. Uses camera bounds
		move.w	Camera_min_X_pos.w,d0		; get cam min x to d0
		move.w	Camera_max_X_pos.w,d1		; get cam max x to d1

		sub.w	d0,d1				; sub difference
		lsr.w	#1,d1				; halve it
		add.w	d1,d0				; add to min pos
		add.w	#320/2,d0			; offst by screen width
		move.w	d0,$10(a0)			; save as x-pos

		move.w	Camera_target_max_Y_pos.w,d1	; get cam max y pos to d1
		add.w	#224,d1				; add full screen to max
		move.w	d1,$14(a0)			; save as y-pos
		jmp	Obj_EndSignControl_HitHUD	; spawn endsign

Boss_Force_End_2:		; NAT: New screelock method. Please input a1 data
		bsr.s	Boss_Lock_Screen
		move.w	d1,$10(a0)			; save as x-pos
		move.w	d3,$14(a0)			; save as y-pos
		jmp	Obj_EndSignControl

Boss_Lock_Screen:
		move.w	(a1)+,d0			; get min
		move.w	(a1)+,d1			; get max
		move.w	d0,Camera_target_min_X_pos.w
		move.w	d1,Camera_target_max_X_pos.w

		sub.w	d0,d1				; sub min from max
		lsr.w	#1,d1				; halve
		add.w	#320/2,d1			; add half screen to it
		add.w	d0,d1				; add to min

		move.w	(a1)+,d2			; get min
		move.w	(a1)+,d3			; get max
		move.w	d2,Camera_target_min_Y_pos.w
		move.w	d3,Camera_target_max_Y_pos.w

		add.w	#224,d3				; add full screen to max
		jsr	Create_New_Sprite2		; get new sprite
		bne.s	.lazy				; branch if cant
		move.l	#Obj_AlignCam,(a1)		; align camera object
		rts

.lazy		move.w	d0,Camera_min_X_pos.w		; bahh fuck it then
		move.w	d1,Camera_max_X_pos.w
		move.w	d2,Camera_min_Y_pos.w
		rts
; ---------------------------------------------------------------------------

Obj_AlignCam:
.maxspd =	$80000
.addspd =	$C00

		move.l	#.main,(a0)			; NAT: Go to main code
		move.b	H_scroll_amount.w,d0		; get scroll amount
		ext.w	d0				; extend to word
		move.w	d0,4(a0)			; save as left speed
		move.w	d0,8(a0)			; save as right speed

		move.b	V_scroll_amount.w,d0		; get scroll amount
		ext.w	d0				; extend to word
		move.w	d0,$0C(a0)			; save as top speed

	; prepare
.main		move.l	#.addspd,d6			; Prepare speed delta
		move.l	#.maxspd,d5			; prepare max speed
		lea	Camera_min_X_pos.w,a1		; for quick reference
		lea	Camera_target_min_X_pos.w,a2	; for quick reference
		lea	4(a0),a3			; for quick reference
		lea	Camera_X_Pos.w,a4		; for quick reference
		moveq	#3,d4				; max number of locks

	; do left
		move.w	(a4),d1				; get camera x-pos to d1
		move.w	(a1),d0				; Get camera min x-pos to d0
		move.w	(a2)+,d3			; get the target min-x-pos to d3
		move.w	(a3),d2				; get movement speed to d2

		cmp.w	d0,d3				; check if target is above current
		bgt.s	.moveleft			; if not, move
		move.w	d3,(a1)+			; set post
		clr.l	(a3)+				; clear speed
		subq.b	#1,d4				; decrease lock ctr
		bra.s	.doneleft

.moveleft	sub.w	d0,d1				; check if camera is below
		ble.s	.noalignleft			; branch if not
		add.w	d1,d0				; add that to cam min pos

.noalignleft	add.w	d2,d0				; add speed to d0 too
		cmp.w	d3,d0				; check if we are past the right point
		ble.s	.nosnapleft			; if not, branch

		clr.l	(a3)				; clear speed
		move.w	d3,d0				; copy pos
.nosnapleft	move.w	d0,(a1)+			; set pos

		cmp.w	(a4),d0				; check if camera x pos is lagging behind
		blt.s	.nocamleft			; branch if not
		move.w	d0,(a4)				; save as new cam pos

.nocamleft	add.l	d6,(a3)				; increase speed
		cmp.l	(a3)+,d5			; check if moving at max speed
		bgt.s	.doneleft			; if not, branch
		move.l	d5,-4(a3)			; else force max

	; do right
.doneleft	move.w	(a4),d1				; get camera x-pos to d1
		move.w	(a1),d0				; Get camera min x-pos to d0
		move.w	(a2)+,d3			; get the target max-x-pos to d3
		move.w	(a3),d2				; get movement speed to d2

		cmp.w	d0,d3				; check if target is above current
		blt.s	.moveright			; if not, move
		move.w	d3,(a1)+			; set post
		clr.l	(a3)+				; clear speed
		subq.b	#1,d4				; decrease lock ctr
		bra.s	.doneright

.moveright	sub.w	d0,d1				; check if camera is below
		bge.s	.noalignright			; branch if not
		add.w	d1,d0				; add that to cam min pos

.noalignright	sub.w	d2,d0				; sub the speed from screen pos
		cmp.w	d3,d0				; check if we are past the right point
		bge.s	.nosnapright			; if not, branch

		clr.l	(a3)				; clear speed
		move.w	d3,d0				; copy pos
.nosnapright	move.w	d0,(a1)+			; set pos

		cmp.w	(a4),d0				; check if camera x pos is lagging behind
		bgt.s	.nocamright			; branch if not
		move.w	d0,(a4)				; save as new cam pos

.nocamright	add.l	d6,(a3)				; increase speed
		cmp.l	(a3)+,d5			; check if moving at max speed
		bgt.s	.doneright			; if not, branch
		move.l	d5,-4(a3)			; else force max

	; do top
.doneright	addq.w	#4,a4				; get y-pos
		move.w	(a4),d1				; get camera x-pos to d1

		move.w	(a1),d0				; Get camera min y-pos to d0
		move.w	(a2)+,d3			; get the target min-y-pos to d3
		move.w	(a3),d2				; get movement speed to d2

		cmp.w	d0,d3				; check if target is above current
		bgt.s	.movetop			; if not, move
		move.w	d3,(a1)+			; set post
		clr.l	(a3)+				; clear speed
		subq.b	#1,d4				; decrease lock ctr
		bra.s	.donetop

.movetop	sub.w	d0,d1				; check if camera is below
		ble.s	.noaligntop			; branch if not
		add.w	d1,d0				; add that to cam min pos

.noaligntop	add.w	d2,d0				; add speed to d0 too
		cmp.w	d3,d0				; check if we are past the right point
		ble.s	.nosnaptop			; if not, branch

		clr.l	(a3)				; clear speed
		move.w	d3,d0				; copy pos
.nosnaptop	move.w	d0,(a1)+			; set pos

		cmp.w	(a4),d0				; check if camera x pos is lagging behind
		blt.s	.nocamtop			; branch if not
		move.w	d0,(a4)				; save as new cam pos

.nocamtop	add.l	d6,(a3)				; increase speed
		cmp.l	(a3),d5				; check if moving at max speed
		bgt.s	.donetop			; if not, branch
		move.l	d5,(a3)				; else force max

.donetop	tst.b	d4				; check lock count
		bgt.s	Boss_DisableHitMode.rts		; if not fully locked, branch
		jmp	Delete_Current_Sprite.w		; delete this
; ---------------------------------------------------------------------------

Boss_DisableHitMode:
		tst.b	BossHitMode.w			; NAT: check if hit mode is on
		beq.s	.rts				; if it was off, branch
		movem.l	d1-a4,-(sp)			; store shit on stack

		bsr.s	.chkwin				; check winrar
		moveq	#$9C,d0				; play chime kinda sound
		jsr	Play_Sound_2.w
		movem.l	(sp)+,d1-a4			; get shit back
.rts		rts

.chkwin		clr.b	BossHitMode.w			; Clear boss hit mode
		lea	Score.w,a5			; get player 1 score to a1
		lea	Player_1.w,a3			; get player 1 to a3

		move.b	BossHitsP1.w,d1			; get player 1 hits
		sub.b	BossHitsP2.w,d1			; sub player 2 hits
		bmi.s	.p2win				; if player 2 won, branch
		bgt.s	.p1win				; if player 1 won, branch

		bsr.s	.p1win				; if both win, run player 1 before player 2
.p2win		lea	Player_2.w,a3			; get player 2 to a3
		lea	Score+1.w,a5			; get player 2 score to a1

.p1win		move.w	a3,a1				; copy player to a1 too
		moveq	#1,d0				; get the +1 icon
		jsr	MonitorCont_Common		; give monitor effect depending on game mode
.max		moveq	#1,d1				; get the +1 icon
		jmp	MonitorTableAdd			; add to monitor table
; ---------------------------------------------------------------------------

; in:
;   d6 - Hitter ID. 0 = Sonic, 1-$7F - Tails, else neither
;   a5 - Address to hits counter
; out cc:
;   eq - destroyed normally
;   gt - not destroyed
;   lt - not out of hits yet

Boss_HandlePlayerHit:
		bsr.s	Boss_AddPlayerScore

Boss_HandlePlayerHit2:
	; check if we want to destroy boss now
		move.b	(a3)+,d0			; get Sonic score
		sub.b	(a3)+,d0			; sub Tails score
		bpl.s	.abs				; if positive difference, branch
		neg.b	d0				; negate

.abs		cmp.b	(a5),d0				; check if more hits are possible to do,
		bmi.s	.ok				; than leading player wins by, and branch if so
		clr.b	(a5)				; clear hit count
		moveq	#-1,d6				; set CC
		rts

.ok		subq.b	#1,(a5)				; Subtract 1 from ACTUAL hit count
		rts					; set CC
; ---------------------------------------------------------------------------
; in:
;   d6 - Hitter ID. 0 = Sonic, 1-$7F - Tails, else neither

Boss_AddPlayerScore:
		lea	BossHitsP1.w,a4			; get score
		move.w	a4,a3				; and to a3
		tst.b	d6				; check if sanic
		beq.s	.sanic				; if so, branch
		addq.w	#1,a4				; inc to tails
.sanic		addq.b	#1,(a4)				; add score
		rts
; ---------------------------------------------------------------------------

; in:
;   d4 - X-offset of camera
;   d5 - Byte to check if player 1 is on the object
;   d6 - Byte to check if player 2 is on the object

Camera_FixToObj:
		st	Scroll_force_positions.w	;
		move.w	CamFollow_Y.w,Scroll_forced_Y_pos.w; NAT: use camera follow y instead

		move.w	Player_1+x_pos.w,d0		; get player 1 x-pos to d0
		tst.b	d5				; check if on pole
		beq.s	.nop1le				; if not, branch
		move.w	x_pos(a0),d0			; get this x-pos

.nop1le		move.w	Player_2+x_pos.w,d1		; get player 2 x-pos to d1
		tst.b	d6				; check if on pole
		beq.s	.nop2le				; if not, branch
		move.w	x_pos(a0),d1			; get this x-pos

.nop2le		cmp.b	#6,Player_1+routine.w		; NAT: Check if dead
		blo.s	.nodead1			; if not, branch
		move.w	d1,d0				; copy Tails pos

.nodead1	cmp.b	#6,Player_2+routine.w		; NAT: Check if dead
		blo.s	.nodead2			; if not, branch
		move.w	d0,d1				; copy Sonic pos

.nodead2	sub.w	d1,d0				; sub Tails pos from real pos
		asr.w	#1,d0				; halve offset
		add.w	d1,d0				; add pos back
		add.w	d4,d0				; offset sligtly
		move.w	d0,Scroll_forced_X_pos.w	; save pos
		rts
; ---------------------------------------------------------------------------
