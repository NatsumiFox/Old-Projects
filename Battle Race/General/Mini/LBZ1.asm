__resize :=	4					; resize routine
__wave :=	6					; wave routine
__waveunlock :=	8					; wave unlock address
__wavelock := 	$C					; wave lock address
__wavespawns :=	$10					; wave spawn data address
__delay :=	$14					; delay for spawn data process
; ---------------------------------------------------------------------------

Mini_LBZ1_Handler:
		move.l	#Mini_LBZ1_WaveUnlock,__waveunlock(a0)
		move.l	#Mini_LBZ1_WaveSpawn,__wavespawns(a0)
		move.l	#Mini_LBZ1_WaveLock,__wavelock(a0)

		clr.l	__resize(a0)			; clear routine and wave
		move.l	#.procenemies,(a0)		; run main routine
		move.w	#2*60,__delay(a0)
; ---------------------------------------------------------------------------

.procenemies	subq.w	#1,__delay(a0)			; check for delay
		bpl.s	.rt2				; branch if positive
		move.l	__wavespawns(a0),a2		; get wave data address to a2

	; process wave spawn table
		moveq	#0,d0
		move.b	(a2)+,d0			; load delay amount to d0
		beq.s	.procunlock			; process unlock if 0
		cmp.b	#$FF,d0				; special case: Check if delay is FF
		bne.s	.normdelay			; branch if not

	; check if all enemies are killed
		tst.b	SpecialEnemyCtr.w		; check if enemy counter is 0
		beq.s	.enemydone			; if so, branch
		rts

	; load normal delay
.normdelay	add.w	d0,d0				; double d0
		add.w	d0,d0				; quadruple d0
		move.w	d0,__delay(a0)			; save as delay

	; load all objects for this period
.loadobj	moveq	#0,d2
		move.b	(a2)+,d2			; load object counter
		bmi.s	.enemydone			; branch if no objects should load

.loadloop	jsr	Create_New_Sprite.w
		bne.s	.fail
		move.l	#Obj_LayoutFixes,(a1)		; load layout fixes object
		move.b	(a2)+,subtype(a1)		; load its subtype

		move.w	Camera_X_pos.w,x_pos(a1)	; set x-pos to camera
		move.w	Camera_Y_pos.w,y_pos(a1)	; set Y-pos to camera
.fail		dbf	d2,.loadloop			; loop for all objs

.enemydone	move.l	a2,__wavespawns(a0)		; save new spawns offset
.rt2		rts

	; process unlock event
.procunlock	bsr.s	.enemydone			;
		move.l	#.waitlock,(a0)			; load new routine

		move.w	__wave(a0),d0			; load wave number
		move.l	__waveunlock(a0),a2		; get wave unlock address to a2
		add.w	d0,d0				; double offset
		jsr	.proclock(pc)			; process lock

		move.l	(a2),(__u_FA92).w		; load final offset
		jsr	Create_New_Sprite.w
		bne.s	.rt0
		move.l	#Obj_IncLevEndXGradual,(a1)
		jsr	Create_New_Sprite.w
		bne.s	.rt0
		move.l	#Obj_DecLevStartXGradual,(a1)

		jsr	Create_New_Sprite.w
		bne.s	.rt0
		move.l	#Mini_LBZ1_SignGO,(a1)
		move.w	#-$580,x_vel(a1)		; load backwards speed
		move.w	#$40,$40(a1)			; load speed modifier
		move.w	#320+32,x_pos(a1)		; save cool x-pos
		move.w	#$40,y_pos(a1)			; save cool y-pos
.rt0		rts
; ---------------------------------------------------------------------------

	; wait until we can lock the screen
.waitlock	move.w	(__u_FA92).w,d0			; get cam max pos to d0
		cmp.w	Camera_X_pos.w,d0		; check if camera matches it
		bne.s	.rt1				; else check resize
		move.w	d0,Camera_min_X_pos.w		; lock camera

		move.l	__wavelock(a0),a2		; get wave lock address to a2
		move.w	__wave(a0),d0			; load wave number
		jsr	.proclock(pc)			; process lock

		addq.w	#4,__Wave(a0)			; increase wave
		move.l	#.procenemies,(a0)		; change routine
		clr.w	__delay(a0)			; clear delay
		clr.b	SpecialEnemyCtr.w		; clear special enemy counters (failsafe)
.rt1		rts
; ---------------------------------------------------------------------------

	; process screen lock or unlock
.proclock	add.w	d0,a2				; offset by d0
		move.w	(a2)+,(__u_FA96).w		; load y-min pos
		bmi.s	.loadsign			; if negative, load eng sigh
		move.w	(a2)+,Camera_target_max_Y_pos.w	; load y-max pos

		jsr	Create_New_Sprite.w
		bne.s	.rts
		move.l	#Obj_DecLevStartYGradual,(a1)
.rts		rts

.loadsign	addq.w	#4,sp				; do not return
		move.w	#$DA0,x_pos(a0)			; set x-pos
		move.w	#$B00,y_pos(a0)			; set y-pos
		jmp	Obj_EndSignControl		; load end sign

; ---------------------------------------------------------------------------
Mini_LBZ1_WaveUnlock:
	dc.w $A80, $A80, $01E0, $0042
	dc.w $900, $B00, $0600, $01E0
	dc.w $920, $B00, $0960, $0600
	dc.w $A40, $AC0, $0D00, $0960
	dc.w -1

Mini_LBZ1_WaveLock:
	dc.w $A60, $A60
	dc.w $B00, $B00
	dc.w $A40, $A40
	dc.w $A40, $A40

Mini_LBZ1_WaveSpawn:
; wave 0
	dc.b 2*60/4, $FF
	dc.b 2*60/4, $00, $18
	dc.b 60/4, $00, $19
	dc.b $FF, $00

; wave 1
	dc.b 1*60/4, $00, $1A
	dc.b 8/4, $00, $1C
	dc.b $FF
	dc.b 8/4, $01, $18, $1B
	dc.b $FF, $00

; wave 2
	dc.b 1*60/4, $00, $1D
	dc.b 1*60/4, $01, $1D, $1E
	dc.b $FF
	dc.b 32/4, $01, $1F, $13
	dc.b 32/4, $01, $1F, $14
	dc.b 32/4, $01, $1F, $15
	dc.b 32/4, $01, $1F, $16
	dc.b 32/4, $01, $1F, $17
	dc.b 32/4, $01, $1F, $13
	dc.b 32/4, $01, $1F, $15
	dc.b 32/4, $01, $1F, $17
	dc.b $FF
	dc.b 16/4, $01, $1F, $19
	dc.b 16/4, $00, $1F
	dc.b 64/4, $00, $1F
	dc.b 16/4, $00, $1F
	dc.b 16/4, $00, $1F
	dc.b 64/4, $00, $1F
	dc.b 16/4, $01, $1F, $1E
	dc.b 16/4, $00, $1F
	dc.b 16/4, $00, $1F
	dc.b $FF, $00

; wave 3
	dc.b 64/4, $00, $21
	dc.b 4/4, $00, $22
	dc.b $FF
	dc.b 16/4, $02, $1E, $14, $16
	dc.b 16/4, $01, $14, $16
	dc.b 28/4, $01, $14, $16
	dc.b 60/4, $00, $18
	dc.b $FF
	dc.b 32/4, $01, $22, $18
	dc.b 32/4, $00, $20
	dc.b 4/4, $00, $23
	dc.b $FF, $00

; wave 4
	dc.b 16/4, $00, $22
	dc.b 16/4, $00, $21
	dc.b $FF
	dc.b 4/4, $01, $18, $1E
	dc.b $FF
	dc.b 64/4, $00, $23
	dc.b 128/4, $00, $20
	dc.b 4/4, $01, $22, $15
	dc.b $FF
	dc.b 4/4, $01, $18, $18
	dc.b $FF
	dc.b 64/4, $01, $24, $13
	dc.b 16/4, $02, $25, $1A, $17
	dc.b $FF
	dc.b 8/4, $01, $20, $18
	dc.b 8/4, $00, $22
	dc.b 4/4, $00, $23
	dc.b $FF, $00
	even
; ---------------------------------------------------------------------------

Obj_RibotSpecial:
		move.w	#$7E,d0
		bclr	#7,subtype(a0)			; check if bit7 is set
		beq.s	.notset				; if not, branch
		move.w	#$5E,d0				; allow the beam go underground a bit
.notset		move.w	d0,$44(a0)			; save as the vertical offset

		move.b	subtype(a0),d0			; get subtype to d0
		move.b	d0,d4				; copy to d4
		and.b	#$7,d4				; get only the bits the Ribot needs

		and.w	#$78,d0				; get settings offset
		lsr.w	#2,d0				; offset properly
		move.w	.table(pc,d0.w),$40(a0)		; load the y-offset for Ribots

		jsr	Create_New_Sprite.w
		bne.s	.rts
		move.l	#Obj_Ribot.code,(a1)		; NAT: Load Ribot
		move.b	d4,subtype(a1)			; get subtype
		move.w	a1,parent(a0)			; save object address

		move.w	x_pos(a0),x_pos(a1)		; copy x-position
		move.w	y_pos(a0),y_pos(a1)		; copy y-position
		move.w	$40(a0),d0			; load offset to d0
		add.w	d0,y_pos(a1)			; offset y-position

		move.w	#$7F10,y_radius(a0)		; set floor collision size
		move.b	#$16,subtype(a0)		; set subtype for the object
		jsr	Obj_StillSprite			; NAT: Initialize this object
		move.l	#.main,(a0)			; run main routine
.rts		rts

.table		dc.w $60, $40, $20, $00, -$20
; ---------------------------------------------------------------------------

	; check if we hit the floor
.main		move.w	x_pos(a0),d3			; get x-pos of object to d3
		move.w	y_pos(a0),d2			; get y-pos of object to d2
		add.w	$44(a0),d2			; offset check pos

		jsr	ObjCheckFloorDistSpecial.w	; check if object has hit the floor
		tst.w	d1				; ''
		bgt.s	.nofloor			; if not, skip
		add.w	d1,y_pos(a0)			; fix position

	; bounce back
		move.w	y_vel(a0),d0			; get y-vel to d0
		asr.w	#1,d0				; get 1/4 of the original speed
		neg.w	d0				; negate it

		cmp.w	#-$40,d0			; check if the speed is very small
		blt.w	.nostop				; if not, skip
		move.l	#.display,(a0)			; ´display only
.nostop		move.w	d0,y_vel(a0)			; change y-velocity otherwise

	; move object and position child
.nofloor	jsr	MoveSprite			; make object fall
		move.w	parent(a0),a1			; get child to a1
		move.w	x_pos(a0),x_pos(a1)		; copy x-position
		move.w	y_pos(a0),y_pos(a1)		; copy y-position
		move.w	$40(a0),d0			; load offset to d0
		add.w	d0,y_pos(a1)			; offset y-position

	; check if the child is alive
.display	move.w	parent(a0),a1			; get child to a1
		cmp.l	#Obj_Ribot.code,(a1)		; check if this is the Ribot still
		bne.s	.break				; if not, break the pillar
		jmp	Sprite_OnScreen_Test.w		; display
; ---------------------------------------------------------------------------

	; when the enemy is defeated, break the pillar
.break		move.l	#Obj_PlatformCollapseWait,d4	; use this routine
		move.l	d4,(a0)				; save as current object routine
		clr.l	x_vel(a0)			; clear speed
		lea	.delays(pc),a4			; load delay table to a4
		jmp	loc_20C38			; run the break routine

.delays		dc.b $01, $04, $08, $0C, $10, $14, $18, $1C
; ---------------------------------------------------------------------------

Mini_LBZ1_SignGO:
		move.l	#.main,(a0)
		move.l	#.map,mappings(a0)
		move.b	#$10,width_pixels(a0)
		move.w	#2*60,$42(a0)			; set new delay
		move.w	#$848C,art_tile(a0)		; laod art tile offset
		move.w	#prio(0),priority(a0)		; set to priority layer 0
		moveq	#$58,d0				; load GO art
		jsr	Load_PLC.w
; ---------------------------------------------------------------------------

.main		move.w	$40(a0),d0			; load x-vel offset to d0
		add.w	d0,x_vel(a0)			; add it to x-vel
		jsr	MoveSprite2.w			; make object fall

		move.w	x_vel(a0),d1			; load x-vel to d1
		tst.w	$40(a0)				; check if offset is positive
		bmi.s	.noneg				; branch if negative
		neg.w	d1				; else negate speed

.noneg		tst.w	d1				; check if speed is same polarity
		bpl.s	.display			; branch if so
		move.l	#.delay,(a0)			; else, delay a bit
; ---------------------------------------------------------------------------

.delay		subq.w	#1,$42(a0)			; check if delay is over
		bpl.s	.display			; if not, branch
		move.l	#.hide,(a0)			; go to hide routine
; ---------------------------------------------------------------------------

.hide		move.w	x_pos(a0),d0			; get x-pso to d0
		add.w	#32,d0				; offset for deadzone
		cmp.w	#320+64,d0			; check if in range
		bhs.s	.delete				; if not, branch

		move.w	$40(a0),d0			; load x-vel offset to d0
		add.w	d0,x_vel(a0)			; add it to x-vel
		jsr	MoveSprite2.w			; make object fall
; ---------------------------------------------------------------------------

.display	btst	#2,V_int_run_count+3.w		; check for bit 2 of v-int frame
		seq	d0				; set if not set
		neg.b	d0				; $FF -> $01
		move.b	d0,mapping_frame(a0)		; set as the frame
		jmp	Draw_Sprite.w			; display

.delete		jmp	Delete_Current_Sprite		; delete
; ---------------------------------------------------------------------------

.map	dc.w .full-.map, .back-.map

.full	dc.w 1
.back =	*+2
	dc.w $7F0E, $0000, $0070
; ---------------------------------------------------------------------------
