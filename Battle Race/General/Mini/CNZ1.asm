__timer :=	4		; timer for monitor
__dash1 :=	6		; dash for p1
__dash2 :=	7		; dash for p2
__addr :=	$34		; addr for float control
blockmax :=	48		; max count for blocks
__blockst :=	8		; blocks timer
__blocksc :=	$A		; blocks counter
__copy :=	$C		; copy of brock break RAM
; x_pos and y_pos are not free!
; ---------------------------------------------------------------------------

Mini_CNZ1_Handler:
		move.w	#60*2,__timer(a0)		; set initial timers
		addq.w	#1,__blockst(a0)		; reset block timer
		move.w	#blockmax,__blocksc(a0)		; reset blocks counter
		move.l	#.chkstart,(a0)			; start handler

.chkstart	or.b	#$80,Player_1+status.w		; no respawn
		or.b	#$80,Player_2+status.w		; no respawn

		tst.b	Level_started_flag.w		; check if level started
		beq.s	.chktitle
		jsr	Create_New_Sprite.w		; do sprite
		bne.s	.chktitle			; no? ummmm
		move.l	#Obj_CNZMinibossScrollControl,(a1); helper
		move.l	#.chktitle,(a0)			; title handler

.chktitle	tst.l	(Dynamic_object_RAM+$172).w			; check if titlecard is active
		bne.s	.main				; if not, branch
		move.l	#.main,(a0)			; floor handler
		moveq	#$5E,d0
		jsr	Load_PLC.w			; load boss explosions
		clr.w	Ctrl_1_locked.w			; unlock controls

.main		tst.l	__copy(a0)			; check if copy is needed
		beq.s	.nobreak			; if not, branch
		tst.l	(ScrEvents_Routine2).w			; check if free
		bne.s	.nobreak			; if not, branch

		move.w	__copy(a0),(ScrEvents_Routine2).w		; copy position
		move.w	__copy+2(a0),(ScrEvents_3).w	;
		clr.l	__copy(a0)			; clear copy
		lea	0.w,a3				; clear a3
		bsr.w	.break				; do break thing

.nobreak	lea	Player_1.w,a1			; do p1 first
		lea	Shield.w,a2			; get shield 1 anim
		lea	__dash1(a0),a3			; get dash to a3
		lea	Ring_count.w,a4			; get ring count to a4
		move.b	Ctrl_1_pressed_logical.w,d0	; get p1 pressed
		bsr.w	.dash				; check dashing

		lea	Player_2.w,a1			; do p2 then
		lea	Shield_P2.w,a2			; get shield 2 anim
		addq.w	#1,a3				; goto dash 2
		addq.w	#1,a4				; get ring count 2 to a4
		move.b	Ctrl_2_pressed_logical.w,d0	; get p2 pressed
		bsr.w	.dash				; check dashing

.timer		subq.w	#1,__blockst(a0)		; decrease timer
		bne.s	.mon				; if not over, branch

		move.w	__blocksc(a0),d0		; get blocks count to d0
		lsl.w	#4,d0				; *16
		move.w	d0,__blockst(a0)		; reset timer
		cmp.w	#blockmax*16,d0			; check if max count
		beq.s	.mon				; branch if so

		jsr	Create_New_Sprite.w		; create sprite
		bne.s	.mon				; no? whatever
		move.l	#Mini_CNZ1_Block,(a1)		; create block
		move.w	a0,parent(a1)			; save parent

.mon		subq.w	#1,__timer(a0)			; decrement timer
		bne.s	.rts				; if hasn't counted down, branch
		addq.w	#1,__timer(a0)			; in case we fail to do sprite, fix timer

		jsr	Create_New_Sprite.w		; create sprite
		bne.s	.rts				; no? whatever
		move.l	#Mini_CNZ1_FloatMon,(a1)	; create floating monitor
		move.l	#Obj_FloatMonitor,__addr(a1)	;
		move.w	#$60,y_vel(a1)			; move down slowly

		jsr	Random_Number.w			; generate a random number
		add.w	V_int_run_count+2.w,d0		; add randomness
		and.w	#$FC,d0				; get in range
		add.w	#$3240,d0			; offset properly
		move.w	d0,x_pos(a1)			; set xpos
		move.w	#$280,y_pos(a1)			; set y-pos

		jsr	Random_Number.w			; generate a random number
		sub.w	V_int_run_count+2.w,d0		; add randomness
		and.w	#$F,d0				; keep in range
		move.b	.types(pc,d0.w),subtype(a1)	; set subtype

		jsr	Random_Number.w			; generate a random number
		add.w	V_int_run_count+2.w,d0		; add randomness
		and.w	#$3F,d0				; get in range
		add.w	#60*4,d0			; make sure there is at least 5 sec delay
		move.w	d0,__timer(a0)			; save timer
.rts		rts

; ---------------------------------------------------------------------------
.types	dc.b [$A] 3, 4, 4, 2, 2, 1, 1
; ---------------------------------------------------------------------------

.dash		cmp.b	#2,anim(a2)			; check if doing a bounce up (shield animation #2)
		beq.s	.checkdel			; if so, check deleting ground
		clr.b	(a3)				; clear dash flag
		tst.b	anim(a2)			; check if animation is 0
		bne.s	.give				; if not, branch

		tst.b	jumping(a1)			; check if jumping
		beq.s	.hidesh				; if not, branch
		cmp.w	#-$400,y_vel(a1)		; is y speed greater than -400?
		ble.s	.hidesh				; if yes, branch
		tst.b	(a4)				; check if player has no rings
		beq.s	.hidesh				; if so, branch

.give		cmp.w	#Obj_Bubble_Shield_Main&$FFFF,2(a2); check if has shield
		beq.s	.rte				; branch if yes
		jmp	MonitorBR_Bubble_Shield2	; give shield

.hidesh		move.l	#Obj_Insta_Shield,(a2)		; remove shield
		bclr	#6,status_secondary(a1)		; remove shields
.rte		rts

.checkdel	tst.b	(a3)				; check if this flag was set
		bne.s	.rte				; if yes, branch
		st	(a3)				; set it nao

		move.w	x_pos(a1),d3			; copy pos
		move.w	y_pos(a1),d2			;
		add.w	#$10,d2				; go to block below
		move.w	d2,y_pos(a0)			; save
		move.w	d3,x_pos(a0)			;

		jsr	GetFloorPosition_FG.w		; get check if landed on a block
		tst.w	(a1)				; check value
		bne.s	.cont				; branch if yes

		move.w	x_pos(a0),d3			; get x-pos
		add.w	#$20,x_pos(a0)			; go to next block
		and.w	#$1F,d3				; get block offset
		cmp.w	#$10,d3				; check which side is closer
		bge.s	.cont				; if right side is, branch
		sub.w	#$40,x_pos(a0)			; go to the block on the left

.cont		tst.l	(ScrEvents_Routine2).w			; check if free
		bne.s	.nofree				; if not, branch

		move.w	x_pos(a0),(ScrEvents_Routine2).w		; break block here
		move.w	y_pos(a0),(ScrEvents_3).w		;
.break		jsr	CNZMiniboss_BlockExplosion	; cause explosion
		subq.w	#1,__blocksc(a0)		; decrease blocks count
		addq.w	#2,__blockst(a0)		; there is a way to softlock without this
		rts

.nofree		move.w	x_pos(a0),__copy(a0)		; store
		move.w	y_pos(a0),__copy+2(a0)		;
		rts
; ---------------------------------------------------------------------------

Mini_CNZ1_FloatMon:
		move.l	__addr(a0),a1			; get code to run
		jsr	(a1)				; run normal code
		cmp.l	#Mini_CNZ1_FloatMon,(a0)	; check if addr changed
		beq.s	.ckmove				; if not, branch

		move.l	(a0),__addr(a0)			; copy ptr to new location
		move.l	#Mini_CNZ1_FloatMon,(a0)	; reset prt

.ckmove		cmpi.b	#$B,mapping_frame(a0)		; Is monitor broken?
		beq.s	.goup				; if is, branch
		tst.w	y_vel(a0)			; check velocity
		bmi.s	.chk				; if negative, check for delete

		cmp.w	#$2F0,$38(a0)			; check if right pos
		blt.s	.move				; if no, branch
		sub.w	#$08,y_vel(a0)			; decrease velocity
		bpl.s	.move				; if positive, do faster
		move.w	#-$30,y_vel(a0)			; decrease velocity
		bra.s	.move				; if still movin, branch

.goup		sub.w	#$10,y_vel(a0)			; move faster!!!
.chk		cmp.w	#$280,$38(a0)			; check if moved enuff
		blo.s	.del				; yes, branch

.move		move.w	y_vel(a0),d0			; get vel
		ext.l	d0				; extend
		lsl.l	#8,d0				; shift to right pos
		add.l	d0,$38(a0)			; add to y-pos
		rts

.del		jmp	Delete_Current_Sprite.w		; delete monitor
; ---------------------------------------------------------------------------

__btimer =	$48

Mini_CNZ1_Block:
		move.l	#.flicker,(a0)
		move.w	#$0F0F,y_radius(a0)
		move.w	#$0F0F,height_pixels(a0)
		move.l	#.map,mappings(a0)
		move.b	#4,render_flags(a0)
		move.w	#prio(4),priority(a0)
		move.w	#$2B0,y_pos(a0)
		move.w	#60*3,__btimer(a0)
		clr.b	mapping_frame(a0)

		jsr	Random_Number.w			; generate a random number
		add.w	V_int_run_count+2.w,d0		; add randomness
		and.w	#$1E0,d0			; get in range
		add.w	#$3240,d0			; offset properly
		move.w	d0,d3				; copy to d3
		bra.s	.xgot

.findspot	add.w	#5*$20,d3			; go to next block
		cmp.w	#$3380,d3			; check for max pos
		blt.s	.xgot				; if not, branch
		sub.w	#$3380-$3200,d3			; wrap pos

.xgot		move.w	#$300,d2			; load ground level
		jsr	GetFloorPosition_FG.w		; get chunk maps
		tst.w	(a1)				; check value
		bne.s	.findspot			; branch if there is a block

		add.w	#$10,d3				; centre x-pos
		move.w	d3,x_pos(a0)			; save x-pos

.flicker	bsr.s	.parentimer			; fix parent timer
		subq.w	#1,__btimer(a0)			; decrement timer
		beq.w	.drop				; if over, drop

		moveq	#3,d0				; check every 8 frames
		cmp.w	#40,__btimer(a0)		; check timer value
		bgt.s	.notm				; if higher, branch
		moveq	#1,d0				; check every 2 frames

.notm		btst	d0,Level_frame_counter+1.w	; check whether to show
		beq.s	.rts				; if not, branch
.draw		jmp	Draw_Sprite			; if yes, draw

.map	dc.w 2, 8
	dc.b  $00, 1, $42, $A0, -1, -$10
	dc.b  $00, 1, $4A, $A0, -1, -$08
	dc.b  $00, 1, $22, $A0,  0, $00
	dc.b  $00, 1, $2A, $A0,  0, $08
	dc.b -$10, 1, $22, $A0, -1, -$10
	dc.b -$10, 1, $2A, $A0, -1, -$08
	dc.b -$10, 1, $42, $A0,  0, $00
	dc.b -$10, 1, $4A, $A0,  0, $08

.parentimer	move.w	parent(a0),a1			; get parent
		addq.w	#1,__blockst(a1)		; keep timer going
.rts		rts

.drop		move.l	#.fall,(a0)
		clr.l	x_vel(a0)			; clear speed

.fall		bsr.s	.parentimer			; fix parent timer
		moveq	#$1A,d1				; width (MUST BE 1A!!)
		moveq	#$0F,d2				; height1
		moveq	#$10,d3				; height2
		move.w	x_pos(a0),d4			; get x-pos
		jsr	SolidObjectFull.w		; make solid

		jsr	MoveSprite.w			; make fall
		jsr	ObjCheckFloorDist.w		; get floor distance
		tst.w	d1				; we hit ground?
		beq.s	.ground				; If so, branch
		bmi.s	.ground				; if not, return

		move.w	#$370,d1			; prepare max pos
		sub.w	y_pos(a0),d1			; sub y-pos from it
		beq.s	.ground				; If 0, branch
		bpl.s	.draw				; if above 0, branch

.ground		add.w	d1,y_pos(a0)			; fix floor pos
		move.w	parent(a0),a1			; get parent
		addq.w	#1,__blocksc(a1)		; increase number of blocks

		move.w	x_pos(a0),d3			; copy pos
		move.w	y_pos(a0),d2			;
		sub.w	#$10,d3				; adjust pos
		sub.w	#$10,d2				;
		jsr	GetFloorPosition_FG.w		; get chunk maps

		move.w	#$F154,(a1)+			; set block
		move.w	#$F155,(a1)+			;
		add.w	#(8*2)-4,a1			; fix pos
		move.w	#$F155,(a1)+			; set block
		move.w	#$F154,(a1)+			;

	; super awful code to update plane buffer
		asr.w	#2,d3
		andi.w	#$78,d3
		lsl.w	#4,d2
		andi.w	#$E00,d2
		add.w	d3,d2

		or.w	#$4000,d2			; VRAM WRITE
		swap	d2
		move.w	#3,d2				; $Cxxx

		move.l	#$00800000,d1			; get offset to d1
		lea	$C00000,a1			; DATA PORT
		move.w	#$2700,sr			; DO NOT V-INT. BAD, WRONG!

		move.l	d2,4(a1)			; set VRAM
		move.l	#$22A02AA0,(a1)			; save 2 tiles
		move.l	#$42A04AA0,(a1)			;

		add.l	d1,d2				; goto next row
		move.l	d2,4(a1)			; set VRAM
		move.l	#$22A12AA1,(a1)			; save 2 tiles
		move.l	#$42A14AA1,(a1)			;

		add.l	d1,d2				; goto next row
		move.l	d2,4(a1)			; set VRAM
		move.l	#$42A04AA0,(a1)			; save 2 tiles
		move.l	#$22A02AA0,(a1)			;

		add.l	d1,d2				; goto next row
		move.l	d2,4(a1)			; set VRAM
		move.l	#$42A14AA1,(a1)			; save 2 tiles
		move.l	#$22A12AA1,(a1)			;

		move.w	#$2300,sr			; can v-int now
		moveq	#$5D,d0				;
		jsr	Play_Sound_2.w			; play sound effect
		jmp	Delete_Current_Sprite.w		; delete obj
; ---------------------------------------------------------------------------
