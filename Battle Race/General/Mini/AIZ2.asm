__wave :=	4		; wave number
__timer :=	6		; timer inbetween waves
__missiles :=	8		; total number of missiles in play
__load :=	9		; if 0, we need to load graphics
__spwnbits :=	$30		; bits for checking what spawn spaces are valid. $08 bytes.
__monctrl :=	$48		; monitor controller
; ---------------------------------------------------------------------------

Mini_AIZ2_Handler:
		move.w	#60*3,__timer(a0)	; initial timer 3s
		move.w	#3,__wave(a0)		; set wave num (intro wave only once)
		clr.b	__missiles(a0)		; no wait for missiles
		move.l	#.procwave,(a0)		; process the wave (no wave)
; ---------------------------------------------------------------------------

	; wait for wave to finish and spawn monitors
.procwave	tst.b	__missiles(a0)		; check if there are no missiles on play
		bne.w	.rts			; if there are, branch
		move.l	#.waitwave,(a0)		; go to waiting for new wave

		tst.b	ResultsShown.w		; check if results are shown
		bne.s	.triggerctrl		; if yes, branch
		jsr	Create_New_Sprite.w	; create new obj
		bne.s	.rts			; if cant load, branch

		move.w	__wave(a0),d0		; load wave ID to d0
		move.w	d0,d1			; copy to d1
		and.w	#3,d1			; check if this is first wave
		bne.s	.rts			; if not, branch

		lsr.w	#2,d0			; divide by 4
		move.b	.wavemonitors-1(pc,d0.w),d1; load monitor count
		bmi.s	.rts			; if none, branch

		move.l	#Mini_AIZ2_MonCtrl,(a1)	; make this object a monitor controller
		move.w	a1,__monctrl(a0)	; save its address
		move.w	d1,subtype(a1)		; save monitor count as subtype

		and.w	#$FFFE,d0		; clear bit0
		move.w	.wavemodelay(pc,d0.w),$44(a1); save delay count
.rts		rts

.wavemonitors	dc.b 2, 0, 1, 0, 2, 0, 1, 0, 0, -1
	even

.wavemodelay	dc.w 60*15, 60*12, 60*8, 60*5, 60*2
; ---------------------------------------------------------------------------

.triggerctrl	move.w	__monctrl(a0),d0	; check if there is monitor controller around
		beq.s	.rts			; if not, branch
		move.w	d0,a1			; get obj to a1
		clr.w	$44(a1)			; clear delay
		rts
; ---------------------------------------------------------------------------

	; wait for wave to start
.waitwave	subq.w	#1,__timer(a0)		; decrease timer
		bne.s	.rts			; if not 0, branch
		move.l	#.procwave,(a0)		; afterwards go wait for wave
		tst.b	ResultsShown.w		; check if results are shown
		bne.w	Mini_AIZ2_Missile.del	; if yes, branch

	; load grapnics
		tst.b	__load(a0)		; check if loaded
		bne.s	.noload			; branch if not
		st	__load(a0)		; set as loaded

		lea	Pal_AIZMiniboss,a1
		jsr	PalLoad_Line1.w		; load miniboss pal
		moveq	#$59,d0
		jsr	Load_PLC.w		; load miniboss gfx

	; initialize wave data
.noload		move.w	__wave(a0),d0		; load wave ID to d0
		addq.w	#1,__wave(a0)		; go to next wave
		cmp.w	#40,__wave(a0)		; check if max wave
		bls.s	.nomax			; if not, branch
		move.w	#40,__wave(a0)		; set to max wave

.nomax		moveq	#0,d1
		move.w	d0,d1			; get wave to d1
		lsr.w	#2,d1			; divide by 4
		mulu.w	#$0A,d1			; multiply by data size

		lea	.wavespawndata(pc),a2	; get wave data to a2
		add.w	d1,a2			; offset by... offset
		lea	__spwnbits(a0),a1	; get destination offset to a1
		move.l	(a2)+,(a1)+		; write all data
		move.l	(a2)+,(a1)+		; write all data

		move.w	(a2)+,__timer(a0)	; load timer value
		move.w	d0,-(sp)		; store value in stack for now
		lsr.w	#1,d0			; halve it

		moveq	#0,d3			;
		move.b	.wavecountdata-1(pc,d0.w),d3; load missile count data for this wave
		move.b	d3,__missiles(a0)	; save missile count in RAM

		subq.w	#1,d3			; decrease total count
		jsr	.spawnmissiles(pc)	; go spawn the missiles
		move.w	(sp)+,d0		; reload wave ID
		rts
; ---------------------------------------------------------------------------

.wavecountdata	dc.b 2, 4, 5, 6, 7, 7, 8, 9, 10, 10, 11, 12, 14, 16, 20, 21	; 8 wave groups
		dc.b 26, 32, 40, 50, 50, 50
		even

.wavespawndata	dc.b %11010111, %01011101, %10111010, %11101011
		dc.b [$04] $FF
		dc.w 60*3		; wave 1

		dc.b %11010111, %01011101, %10111010, %11101011
		dc.b [$04] $FF
		dc.w (60*2)+30		; wave 2-5

		dc.b %10101010, %10101010, %01010101, %01010101
		dc.b [$04] $FF
		dc.w (60*2)+15		; wave 6-9

		dc.b %11000110, %00110001, %10001100, %01100011
		dc.b [$04] $FF
		dc.w 60*2		; wave A-D

		dc.b %10010010, %10010100, %00101001, %01001011
		dc.b %11110111, %10111101, %11101111, %01111011
		dc.w 60+30		; wave E-11

		dc.b %00010001, %00010001, %10001000, %10001000
		dc.b %11011011, %10111011, %11011101, %11011011
		dc.w 60			; wave 12-15

		dc.b %00010001, %00010001, %10001000, %10001000
		dc.b %11011011, %10111011, %11011101, %11011011
		dc.w 60			; wave 16-19

		dc.b %00010001, %00010001, %10001000, %10001000
		dc.b %10101010, %10101010, %10101010, %10101010
		dc.w 60			; wave 1A-1D

		dc.b %00000000, %00000000, %00000000, %00000000
		dc.b %10001000, %10001000, %00010001, %00010001
		dc.w 60			; wave 1E-21

		dc.w [$08/2] $00, 30	; wave 22-25
		dc.w [$08/2] $00, 30	; wave 26-28
; ---------------------------------------------------------------------------

	; initialize object
.spawnmissiles	lea	__spwnbits(a0),a3	; get destination offset to a3

.spmissile	jsr	Create_New_Sprite.w	; create new obj
		bne.s	.sprts			; if cant load, branch
		move.l	#Mini_AIZ2_Missile,(a1)	; set routine
		move.w	a0,parent(a1)		; save this as parent

	; look for position to spawn in
.next		jsr	Random_Number.w		; get random number
		and.w	#$3F,d0			; keep in range
		move.w	d0,d1			; get bit to d1
		and.w	#7,d1			;

		move.w	d0,d2			; get byte to d2
		lsr.w	#3,d2			;
		bset	d1,(a3,d2.w)		; check if the slot is filled (if not, fill)
		bne.s	.next			; branch if filled already

		move.w	d0,d1			; copy row to d1
		and.w	#$20,d1			;
		lsr.w	#4,d1			;
		move.w	.waverowdata(pc,d1.w),y_pos(a1)	; save row data to y_pos

		move.w	d0,d1			; copy column to d1
		and.w	#$1F,d1			;
		add.w	d1,d1			;
		move.w	.wavecoldata(pc,d1.w),x_pos(a1)	; save column data to x_pos

		jsr	Random_Number.w		; get random number
		move.w	__wave(a0),d1		; load wave ID to d1
		lsr.w	#2,d1			; divide by 4
		and.w	#$FE,d1			; clear bit0
		and.w	.wavespread(pc,d1.w),d0	; keep in this range of frames
		move.w	d0,render_flags(a1)	; set delay count

		dbf	d3,.spawnmissiles	; load missile data
.sprts		rts
; ---------------------------------------------------------------------------

.waverowdata	dc.w $420, $3E0
.wavespread	dc.w $1F, $3F, $3F, $7C, $7C, $F0
.wavecoldata	dc.w $1068, $1071, $107A, $1082, $108C, $1094, $109E, $10A8
		dc.w $10B2, $10BC, $10C6, $10D0, $10DA, $10E4, $10EE, $10F8
		dc.w $1102, $110C, $1116, $1120, $112A, $1134, $113C, $1146
		dc.w $1154, $115E, $1163, $116C, $1178, $1180, $1197, $11A0
; ---------------------------------------------------------------------------

Mini_AIZ2_Missile:
		subq.w	#1,render_flags(a0)	; decrease delay
		bpl.s	Mini_AIZ2_Handler.sprts	; if not over, branch

		lea	word_6902A,a1
		jsr	SetUp_ObjAttributes2.w
		move.l	#byte_6914C,$30(a0)
		move.l	#Map_AIZMiniboss,$C(a0)
		move.w	#$8454,$A(a0)
		move.w	#$400,$1A(a0)
		bset	#1,4(a0)		; flip upside down

		move.l	#.fall,(a0)		; goto fall phase
		moveq	#$4D,d0			; play dropping sound
		jsr	Play_Sound_2.w

.fall		cmp.w	#$480,y_pos(a0)		; check if we are close to players
		ble.s	.disp			; if so, no touch
		move.l	#.chkde,(a0)		; change routine to save on cycles

.chkde		cmp.w	#$508,y_pos(a0)		; check if we hit the ground
		bge.s	.destroy		; if so, branch
	;	jsr	Add_SpriteToCollisionResponseList

		lea	Collision_response_list.w,a1; load collision resp list to a1 directly
		addq.w	#2,(a1)			; Count this new entry
		adda.w	(a1),a1			; Offset into right area of list
		move.w	a0,(a1)			; Store RAM address in list

.disp		tst.b	ResultsShown.w		; check if results are shown
		bne.s	.destroy		; if yes, branch
		jsr	Animate_Raw.w		; animate object
		jsr	MoveSprite2.w		; move at constant speed
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

.destroy	addq.w	#4,(ScrShake_Value).w		; increase screen shake timer
		cmp.w	#$40,(ScrShake_Value).w	; check for max time
		blo.s	.nomaxt			; if less, branch
		move.w	#$40,(ScrShake_Value).w	; force max time

.nomaxt		move.w	parent(a0),a1		; Get parent to a1
		subq.b	#1,__missiles(a1)	; decrease its missile count
		jmp	loc_68D70		; run rest of the code
.del		jmp	Delete_Current_Sprite.w	; else, just get rid of me
; ---------------------------------------------------------------------------

Mini_AIZ2_MonCtrl:
		move.l	#.wait,(a0)		; wait to be destroyed
		move.w	subtype(a0),d2		; load subtype as monitor count
		lea	4(a0),a2		; load RAM for addresses

	; create monitors
.monloop	jsr	Create_New_Sprite.w	; create new obj
		bne.w	.rts			; if cant load, branch
		move.l	#Obj_Monitor,(a1)	; make this object a monitor
		move.w	a1,(a2)+		; save monitor RAM

		move.w	#$530,$14(a1)		; set y-pos
		move.b	#2,5(a1)
		move.b	#4,4(a1)
		move.l	#Map_Monitor,$C(a1)
		move.w	#$4C4,$A(a1)
		move.w	#prio(5),8(a1)
		move.w	#$100E,6(a1)
		move.w	#$F0F,y_radius(a1)
		move.b	#4,$3C(a1)
		move.w	#-$500,$1A(a1)
		move.b	#$46,$28(a1)
		move.b	#9,$20(a1)		; random monitor

	; get position for monitor to spawn at
.find		jsr	Random_Number.w		; get random number
		and.w	#7,d0			; keep in range
		bset	d0,__spwnbits(a0)	; check if there is monitor here (and if not, set)
		bne.s	.find			; if yes, find more

		add.w	d0,d0			; double offset
		move.w	.wavemonitpos(pc,d0.w),x_pos(a1); get x-pos
		dbf	d2,.monloop

		moveq	#$44,d0			; play the bounce sound
		jmp	Play_Sound_2.w

.wavemonitpos	dc.w $107E, $10A0, $10C2, $10E4, $1106, $1128, $114A, $116C
; ---------------------------------------------------------------------------

.wait		subq.w	#1,$44(a0)		; decrease delay
		bpl.s	.rts			; if not set, wait
		lea	4(a0),a2		; load RAM for addresses
		move.w	(a2)+,d0		; load first entry

	; destroy all monitors
.loop		move.w	d0,a1			; copy d0 to a1
		cmp.b	#$B,mapping_frame(a1)	; check if destroyed
		bne.s	.nodestroy		; if not, branch
		jsr	Delete_Referenced_Sprite.w; delete it instead
		bra.s	.next			;

.nodestroy	move.l	#Obj_Explosion,(a1)	; set as explosion
		move.b	#2,routine(a1)		; set routine

		moveq	#3,d6			; check Sonic first
		lea	Player_1.w,a3		;
		bsr.s	.unmount		;
		moveq	#4,d6			; check Tails
		lea	Player_2.w,a3		;
		bsr.s	.unmount		;

.next		move.w	(a2)+,d0		; load next RAM address
		bne.s	.loop			; branch if nonzero
		jmp	Delete_Current_Sprite.w	; delete this object

.unmount	btst	d6,status(a1)		; check if player is standin on this
		beq.s	.rts			; if not, branch
		bclr	#3,status(a3)		; stop standing
		bset	#1,status(a3)		; set on air
.rts		rts
; ---------------------------------------------------------------------------
