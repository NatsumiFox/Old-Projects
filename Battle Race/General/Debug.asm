; ===========================================================================
; ---------------------------------------------------------------------------
; Debug control
; ---------------------------------------------------------------------------

Debug_Control:
		moveq	#$00,d0					; MJ: clear speeds
		move.w	d0,x_vel(a0)				; MJ: ''
		move.w	d0,y_vel(a0)				; MJ: ''
		move.w	d0,ground_vel(a0)			; MJ: ''
		move.w	d0,interact(a0)				; MJ: set as not standing on an object
		move.b	status(a0),d0				; MJ: force as in-air walking mode
		andi.b	#%11111001,d0				; MJ: ''
		ori.b	#%00000010,d0				; MJ: ''
		move.b	d0,status(a0)				; MJ: ''
		move.b	#$05,anim(a0)				; MJ: set animation to standing
		move.b	#$02,routine(a0)			; MJ: set to normal (in-case they're dying or something)
		tst.b	render_flags(a0)			; MJ: is the player on screen?
		bmi.s	DC_NoForceScreen			; MJ: if so, branch
		move.w	(Camera_x_pos).w,d0			; MJ: move player to centre of screen on X
		addi.w	#(320/2),d0				; MJ: ''
		move.w	d0,x_pos(a0)				; MJ: ''
		move.w	(Camera_y_pos).w,d0			; MJ: move player to centre of screen on Y
		addi.w	#(224/2),d0				; MJ: ''
		move.w	d0,y_pos(a0)				; MJ: ''

DC_NoForceScreen:
		lea	(Debug_BoxPlay2).w,a4			; MJ: load player 2's storage address and routine
		move.l	#Draw_Sprite,a3				; MJ: ''
		cmpa.w	#Player_1,a0				; MJ: are we editing player 1?
		bne.s	DC_Player2				; MJ: if not, branch
		lea	(Debug_BoxPlay1).w,a4			; MJ: load player 1's storage address and routine
		move.l	#DC_Main,a3				; MJ: ''

		lea	(Player_2).w,a1				; MJ: load player 2's object RAM
		move.w	x_pos(a0),d1				; MJ: get X distance from player to player
		sub.w	x_pos(a1),d1				; MJ: ''
		move.w	y_pos(a0),d2				; MJ: get Y distance from player to player
		sub.w	y_pos(a1),d2				; MJ: ''
		jsr	GetArcTan.w				; MJ: get the angle between the player and the corner first...
		move.b	d0,(Debug_Angle).w			; MJ: ''
		sf.b	(Debug_Angle+$01).w			; MJ: ''

		move.w	d1,d0					; MJ: get X position
		asr.w	#$01,d0					; MJ: ''
		add.w	x_pos(a1),d0				; MJ: ''
		move.w	d0,(Debug_PosX).w			; MJ: ''
		move.w	d2,d0					; MJ: get Y position
		asr.w	#$01,d0					; MJ: ''
		add.w	y_pos(a1),d0				; MJ: ''
		move.w	d0,(Debug_PosY).w			; MJ: ''
		moveq	#$00,d0					; MJ: clear speeds
		move.l	d0,(Debug_Speed).w			; MJ: ''

	;   _________________
	; ,/(X * 2) + (Y * 2) = Distance

		muls.w	d1,d1					; MJ: square the X and Y distance
		muls.w	d2,d2					; MJ: ''
		add.l	d1,d2					; MJ: add them together to get the square direct distance
		bsr.w	CalcRoot				; MJ: get the square root (line distance)
		asr.w	#$01,d1					; MJ: divide by 2 (from centre to player)
		move.w	d1,(Debug_Dist).w			; MJ: ''

DC_Player2:
		cmpi.l	#Obj_Sonic,(a0)				; MJ: is the player "Sonic"?
		bne.s	DC_NoSonPLC				; MJ: if not, branch
		move.b	#$BA,mapping_frame(a0)			; MJ: load Sonic's standing frame
		jsr	Sonic_Load_PLC				; MJ: ''

DC_NoSonPLC:
		cmpi.l	#Obj_Tails,(a0)				; MJ: is the player "Tails"?
		bne.s	DC_NoTaiPLC				; MJ: if not, branch
		move.b	#$AD,mapping_frame(a0)			; MJ: load Tails' standing frame
		jsr	Tails_Load_PLC				; MJ: ''

DC_NoTaiPLC:
		cmpi.l	#Obj_Knuckles,(a0)			; MJ: is the player "Knuckles"?
		bne.s	DC_NoKnuPLC				; MJ: if not, branch
		move.b	#$56,mapping_frame(a0)			; MJ: load Knuckles' standing frame
		jsr	Knuckles_Load_PLC			; MJ: ''

DC_NoKnuPLC:
		moveq	#0,d1
		jsr	DC_NewObject(pc)			; NAT: Get new obj handler
		move.l	(a0),(a4)				; MJ: store object routine
		move.l	a3,(a0)					; MJ: set new routine
		jmp	(a3)					; MJ: run routine

; ---------------------------------------------------------------------------
; main control routine itself
; ---------------------------------------------------------------------------

DC_Main:
		move.w	Debug_Obj.w,a1				; NAT: Get object
		btst.b	#$04,(Ctrl_1_Pressed).w			; MJ: has B been pressed?
		beq.s	DC_NoB					; MJ: if not, branch
		clr.b	(Debug_On).w				; MJ: disable placement mode
		move.l	(Debug_BoxPlay1).w,(Player_1).w		; MJ: restore object routines
		move.l	(Debug_BoxPlay2).w,(Player_2).w		; MJ: ''
		jsr	Delete_Referenced_Sprite.w		; NAT: Remove the object we were holding
		jmp	Draw_Sprite.w				; MJ: save object for display

DC_NoB:
		move.b	(Ctrl_2_Pressed).w,d4			; NAT: load player controls
		lsr.b	#3,d4					; NAT: shift left into carry
		bcc.s	DC_TNoLeft				; NAT: If not pressed, branch
		subq.b	#1,anim(a1)				; NAT: decrease subtype
		bpl.s	DC_TNoLeft				; NAT: If positive, branch
		move.b	#9,anim(a1)				; NAT: Reset it

DC_TNoLeft:
		lsr.b	#1,d4					; NAT: shift right into carry
		bcc.s	DC_TNoRight				; NAT: If not pressed, branch
		addq.b	#1,anim(a1)				; NAT: increase subtype
		cmp.b	#9,anim(a1)				; NAT: Check fo max
		bls.s	DC_TNoRight				; NAT: If ok, branch
		clr.b	anim(a1)				; NAT: Reset it

DC_TNoRight:
		and.b	#%0011,d4				; NAT: Check B or C
		beq.s	DC_TNoABC				; NAT: If none pressed, branch
		move.l	#Obj_FloatMonitor,(a1)			; NAT: Give the object correct routine
		clr.w	$40(a1)
		move.w	x_pos(a1),$44(a1)
		move.w	y_pos(a1),$38(a1)
		move.b	anim(a1),d1				; NAT: Copy animation
		jsr	DC_NewObject(pc)			; NAT: Just get a new object reference

DC_TNoABC:
		move.l	#$00004000,d3				; MJ: set speed to 1/4 pixel
		move.b	(Ctrl_1_Held).w,d4			; MJ: load player controls
		btst.b	#$06,(Ctrl_2_Held).w			; MJ: is "A" being held on player 2?
		beq.s	DC_TNoPixelMove				; MJ: if not, branch
		move.b	(Ctrl_1_Pressed).w,d4			; MJ: use pressed buttons instead (for slow "per pixel" movements)
		move.l	#$00010000,d3				; MJ: set speed to 1 pixel (since it's "pressed" controls, this will only work one frame)

DC_TNoPixelMove:
		move.b	d4,d5					; MJ: copy D-pad buttons to d5
		lsl.b	#$03,d5					; MJ: ''

	; --- distance ---

		add.b	d4,d4					; MJ: get button 'A'
		bpl.s	DC_Rotate				; MJ: if it wasn't pressed, branch
		add.b	d5,d5					; MJ: get button 'Right'
		bpl.s	DC_NoAR					; MJ: if it wasn't pressed, branch
		addq.w	#$02,(Debug_Dist).w			; MJ: expand distance

DC_NoAR:
		add.b	d5,d5					; MJ: get button 'Left'
		bpl.s	DC_NoAL					; MJ: if it wasn't pressed, branch
		subq.w	#$02,(Debug_Dist).w			; MJ: contract distance

DC_NoAL:
		bra.s	DC_ResetSpeed				; MJ: continue

	; --- rotation ---

DC_Rotate:
		add.b	d4,d4					; MJ: get button 'C'
		bpl.s	DC_Move					; MJ: if it wasn't pressed, branch
		add.b	d5,d5					; MJ: get button 'Right'
		bpl.s	DC_NoCR					; MJ: if it wasn't pressed, branch
		addq.b	#$02,(Debug_Angle).w

DC_NoCR:
		add.b	d5,d5					; MJ: get button 'Left'
		bpl.s	DC_NoCL					; MJ: if it wasn't pressed, branch
		subq.b	#$02,(Debug_Angle).w

DC_NoCL:
		bra.s	DC_ResetSpeed				; MJ: continue

	; --- movement ---

DC_Move
		andi.b	#%01111000,d5				; MJ: are any d-pad buttons being held?
		beq.s	DC_ResetSpeed				; MJ: if not, branch
		addi.l	d3,(Debug_Speed).w			; MJ: increase speed
		cmpi.w	#$0010,(Debug_Speed).w			; MJ: is it moving at maximum speed?
		blt.s	DCM_NoLimit				; MJ: if not, branch
		move.l	#$00100000,(Debug_Speed).w		; MJ: force at maximum speed

DCM_NoLimit:
		move.l	(Debug_Speed).w,d4			; MJ: load speed
		add.b	d5,d5					; MJ: get button 'Right'
		bpl.s	DC_NoR					; MJ: if it wasn't pressed, branch
		add.l	d4,(Debug_PosX).w			; MJ: move right

DC_NoR:
		add.b	d5,d5					; MJ: get button 'Left'
		bpl.s	DC_NoL					; MJ: if it wasn't pressed, branch
		sub.l	d4,(Debug_PosX).w			; MJ: move left

DC_NoL:
		add.b	d5,d5					; MJ: get button 'Down'
		bpl.s	DC_NoD					; MJ: if it wasn't pressed, branch
		add.l	d4,(Debug_PosY).w			; MJ: move down

DC_NoD:
		add.b	d5,d5					; MJ: get button 'Up'
		bpl.s	DC_Final				; MJ: if it wasn't pressed, branch
		sub.l	d4,(Debug_PosY).w			; MJ: move up
		bra.s	DC_Final				; MJ: continue

	; --- reset movement speed ---

DC_ResetSpeed:
		moveq	#$00,d0					; MJ: clear speed
		move.l	d0,(Debug_Speed).w			; MJ: ''

	; --- final control ---

DC_Final:
		pea	(Draw_Sprite).l
		move.b	anim(a1),d0				; map = anim+1
		addq.b	#1,d0
		move.b	d0,mapping_frame(a1)
		move.l	#Draw_Sprite,(a1)			; NAT: Only draw
		tst.b	anim(a1)				; NAT: Check if anim = 0
		bne.s	DC_SetPositions				; NAT: If not, branch
		move.l	#DC_NullRout,(a1)			; NAT: Do not draw

; ---------------------------------------------------------------------------
; setting the camera and player positions correctly
; ---------------------------------------------------------------------------

DC_SetPositions:
		moveq	#$00,d0					; MJ: clear d0
		move.b	(Debug_Angle).w,d0			; MJ: load angle
		lea	(SineTable+$01).w,a2			; MJ: load sinewave table address
		add.w	d0,d0					; MJ: multiply by size of word
		move.w	-$01(a2,d0.w),d1			; MJ: load Y sine position
		move.w	+$7F(a2,d0.w),d0			; MJ: load X sine position

		move.w	(Debug_PosX).w,d3			; MJ: load debug centre position
		move.w	(Debug_PosY).w,d4			; MJ: ''
		move.w	(Debug_Dist).w,d2			; MJ: multiply positions by distance
		muls.w	d2,d0					; MJ: ''
		muls.w	d2,d1					; MJ: ''
		asr.l	#$08,d0					; MJ: get only quotient
		asr.l	#$08,d1					; MJ: ''

		movem.w	d0-d1,-(sp)				; MJ: store positions
		lea	(a0),a2					; MJ: get player 1 position first
		bsr.s	DCSP_SetPlayer				; MJ: ''
		move.w	x_pos(a2),x_pos(a1)			; NAT: Copy positions
		move.w	y_pos(a2),y_pos(a1)			;
		movem.w	(sp)+,d0-d1				; MJ: restore positions
		neg.w	d0					; MJ: reverse sinewave position to other side
		neg.w	d1					; MJ: ''
		lea	(Player_2).w,a2				; MJ: get player 2 position

DCSP_SetPlayer:
		add.w	d3,d0					; MJ: add centre position
		add.w	d4,d1					; MJ: ''
		move.w	d0,x_pos(a2)				; MJ: save to player
		move.w	d1,y_pos(a2)				; MJ: ''
		rts						; MJ: return

; ---------------------------------------------------------------------------
; get new object reference
; ---------------------------------------------------------------------------

DC_NewObject:
		jsr	Create_New_Sprite.w			; NAT: create obj
		move.b	d1,anim(a1)				; NAT: Save anim
		move.b	#4,render_flags(a1)
		move.l	#Map_FloatMonitor,mappings(a1)
		move.w	#prio(0),priority(a1)
		move.w	#$0C0F,y_radius(a1)
		move.w	#$130E,height_pixels(a1)
		clr.w	respawn_addr(a1)
		clr.w	art_tile(a1)
		move.b	#$79,collision_flags(a1)
		move.b	#2,routine(a1)
		move.w	a1,Debug_Obj.w				; NAT: Save addr

DC_NullRout:
		rts
