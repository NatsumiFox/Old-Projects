; ===========================================================================
; ---------------------------------------------------------------------------
; CPU Player Routine
; --- Inputs ----------------------------------------------------------------
; a2 = Player data
; a3 = CPU Controller RAM
; ---------------------------------------------------------------------------
;  %SACBRLDU
CPU_S = %10000000
CPU_A = %01000000
CPU_C = %00100000
CPU_B = %00010000
CPU_R = %00001000
CPU_L = %00000100
CPU_D = %00000010
CPU_U = %00000001
CPU_MAXSTEPS	=	$0004
; ---------------------------------------------------------------------------

SS_CPU:
		cmpi.b	#SS_GAMESTART-$20,(ESS_GameStart).w	; is it time for the CPU to start?
		bcc.s	SSC_Return				; if not, branch

		pea	(a1)					; store a1

		movea.l	ESS_Layout(a2),a1			; load layout address
		move.w	ESS_LayoutYX(a2),d4			; load layout position
		move.w	#$1F1F,d6				; prepare layout wrapping mechanism
		move.b	ESS_Direction(a2),d0			; load direction
		tst.b	ESS_Move(a2)				; is the player moving forwards?
		bpl.s	SSC_NoReverse				; if so, branch
		addq.b	#$04,d0					; reverse direction

SSC_NoReverse:
		andi.w	#$0006,d0				; get only the direction
		lea	(SP_Directions).l,a0			; load direction list
		adda.w	d0,a0					; advance to correct direction

		move.l	ESS_RoutCPU(a2),d0			; load routine
		bne.s	SSC_ValidRoutine			; if a routine has been set, branch
		move.l	#SSC_Startup,d0				; set starting routine
		move.l	d0,ESS_RoutCPU(a2)			; ''
		st.b	ESS_SphereDest(a2)			; set no destination sphere
		move.b	#$04-1,ESS_Count01(a2)			; set starting counter (check four directions)

SSC_ValidRoutine:
		moveq	#$00,d7					; reset button presses
		move.w	d7,(a3)					; ''
		move.l	d0,a4					; set address
		jsr	(a4)					; run routine
		move.b	(a3),d1					; load currently held buttons
		eor.b	d7,d1					; disable the buttons that are already held
		move.b	d7,(a3)					; save all held buttons
		and.b	d7,d1					; get only the newly pressed buttons
		move.b	d1,$01(a3)				; save all pressed buttons
		move.l	(sp)+,a1				; restore a1
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Startup routine - Finding the nearest blue sphere it can see and pointing to it
; ---------------------------------------------------------------------------

SSC_Startup:

	; --- Near checker ---
	; This won't be needed if the sphere rendering routine
	; lists are arranged such that the middle sphere is rendered
	; first...

	; Leave this in for now...

		move.w	(a0),d2					; get distance infront
		move.w	d2,d1					; check sphere infront
		add.w	d4,d1					; ''
		bsr.w	SSC_CheckBlue				; ''
		beq.s	SSCS_FoundNear				; if there's a blue sphere, branch
		move.w	d2,d1					; check sphere two steps infront
		add.w	d2,d1					; ''
		add.w	d4,d1					; ''
		bsr.w	SSC_CheckBlue				; ''
		bne.s	SSCS_NoNear				; if no blue sphere, branch

SSCS_FoundNear:
		move.w	d1,ESS_SphereNear(a2)			; set as nearest sphere

SSCS_NoNear:

	; --- --- --- --- --- ---

		tst.w	ESS_SphereNear(a2)			; has a blue sphere been found?
		bmi.w	SSCS_Rotate				; if not, branch

		; Distance away from current destination

		moveq	#$FF,d2					; set current distance to maximum (in-case there is no current sphere)
		move.b	ESS_SphereDest(a2),d0			; check Y distance
		bmi.s	SSCS_NewDest				; if there's none set, then the new one is automatically closer
		move.b	ESS_LayoutY(a2),d1			; '' (check Y)
		bsr.w	SSC_GetDistTurn				; ''
		move.w	d1,d2					; store 
		move.b	ESS_SphereDest+$01(a2),d0		; check X distance
		move.b	ESS_LayoutX(a2),d1			; ''
		bsr.w	SSC_GetDistTurn				; ''
		add.w	d1,d2					; get total distance

SSCS_NewDest:

		; Distance away from new destination

		move.b	ESS_SphereNear(a2),d0			; check Y distance
		move.b	ESS_LayoutY(a2),d1			; ''
		bsr.w	SSC_GetDistTurn				; ''
		move.w	d1,d3					; store 
		move.b	ESS_SphereNear+$01(a2),d0		; check X distance
		move.b	ESS_LayoutX(a2),d1			; ''
		bsr.w	SSC_GetDistTurn				; ''
		add.w	d1,d3					; get total distance

		; Checking which is closer

		cmp.w	d3,d2					; is the new position closer?
		bcs.s	SSCS_Rotate				; if not, branch
		move.w	ESS_SphereNear(a2),ESS_SphereDest(a2)	; set new destination
		cmp.b	#$03,d3					; is the new distance really close?  (as in just like 1-2 places away)
		bls.s	SSCS_GetDirection			; if so, branch to just use this direction right now...

	; --- Rotate stage around ---

SSCS_Rotate:
		move.w	ESS_RotatePos(a2),d0			; load full rotation position (need the fraction to be taken into account)
		andi.w	#$0780,d0				; load rotation position
		bne.s	SSCS_NoRotate				; if the CPU is still rotating, branch
		move.b	(ESS_GameStart).w,d0			; load game timer
		andi.b	#$1F,d0					; checking for delaying the rotation process
		bne.s	SSCS_NoRotate				; if the timer hasn't delayed enough, branch
		subq.b	#$01,ESS_Count01(a2)			; decrease direction counter
		bmi.s	SSCS_GetDirection			; if we've finished counting, branch
		ori.b	#CPU_R,d7				; press right

SSCS_NoRotate:
		rts						; return

	; --- Destination has been found ---

SSCS_GetDirection:
		tst.b	ESS_SphereDest(a2)			; is there a destination to go to?
		bpl.s	SSCS_ValidDest				; if so, branch
		move.l	#SSC_Roam,ESS_RoutCPU(a2)		; set to roam around
		rts						; return

SSCS_ValidDest:
		moveq	#$00,d2					; set initial rotation to upwards
		move.b	ESS_SphereDest(a2),d0			; check Y distance
		move.b	ESS_LayoutY(a2),d1			; ''
		bsr.w	SSC_GetDist				; ''
		bmi.s	SSCS_DistUpwards			; if the destination is above, branch
		addq.b	#$04,d2					; rotate direction to downwards

SSCS_DistUpwards:
		move.w	d1,d4					; store distance
		moveq	#$06,d3					; set initial rotation to left
		move.b	ESS_SphereDest+$01(a2),d0		; check X distance
		move.b	ESS_LayoutX(a2),d1			; ''
		bsr.w	SSC_GetDist				; ''
		bmi.s	SSCS_DistLeft				; if the destination is to the left, branch
		subq.b	#$04,d3					; rotate direction to right

SSCS_DistLeft:
		cmp.w	d1,d4					; is the X distance longer than the Y distance?
		bpl.s	SSCS_LongerY				; if not, branch
		move.w	d3,d2					; set to use X direcition

SSCS_LongerY:
		move.b	d2,ESS_DirectDest(a2)			; store destination direction
		move.l	#SSC_StartDirection,ESS_RoutCPU(a2)	; set next routine

	; --- Rotating player around to face the new direcition ---

SSC_StartDirection:
		move.w	ESS_RotatePos(a2),d0			; load full rotation position (need the fraction to be taken into account)
		andi.w	#$0780,d0				; load rotation position
		bne.s	SSCSD_NoRotate				; if the CPU is still rotating, branch
		move.b	(ESS_GameStart).w,d0			; load game timer
		andi.b	#$1F,d0					; checking for delaying the rotation process
		bne.s	SSCSD_NoRotate				; if the timer hasn't delayed enough, branch
		move.b	ESS_DirectDest(a2),d0			; load current direction
		sub.b	ESS_Direction(a2),d0			; minus best direction
		andi.w	#$0006,d0				; wrap rotation
		bne.s	SSCSD_Continue				; if we haven't reached the destination, branch
		move.l	#SSC_GoTo,ESS_RoutCPU(a2)		; set next routine
		rts						; return

SSCSD_Continue:
		addq.b	#$02,d0					; rotate so that left rotation will be negative
		andi.w	#$0006,d0				; wrap rotation
		ori.b	#CPU_R,d7				; press right
		subq.b	#$02,d0					; rotate back
		bpl.s	SSCSD_NoRotate				; if we're rotating right, branch
		moveq	#CPU_L,d7				; press left

SSCSD_NoRotate:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to get the distance between two layout positions
; --- inputs ----------------------------------------------------------------
; d0.b = Position 1
; d1.b = Position 2
; --- outputs ---------------------------------------------------------------
; d0.w = Distance either way
; d1.w = Positive distance only
; ---------------------------------------------------------------------------

SSC_GetDistX:
		btst.b	#$01,ESS_Direction(a2)			; is the player facing along the X axis?
		beq.s	SSC_GetDistTurn				; if not, branch (include turn count)

SSC_GetDist:
		sub.b	d1,d0					; get distance between the players
		addi.b	#$10,d0					; ensure if the position is on the negative side, it's converted to negative
		andi.w	#$001F,d0				; ''
		subi.w	#$0010,d0				; ''
		move.w	d0,d1					; ''
		bpl.s	SSC_GD_Pos				; if positive, branch
		neg.w	d1					; convert to positive
		tst.w	d0					; recheck d0 (for polarity checking/absolute equal)

SSC_GD_Pos:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to get the distance between two layout positions (add 1 for turning)
; --- inputs ----------------------------------------------------------------
; d0.b = Position 1
; d1.b = Position 2
; --- outputs ---------------------------------------------------------------
; d0.w = Distance either way
; d1.w = Positive distance only (plus 1 for turning if required)
; ---------------------------------------------------------------------------

SSC_GetDistY:
		btst.b	#$01,ESS_Direction(a2)			; is the player facing along the Y axis?
		beq.s	SSC_GetDist				; if so, branch (no turn count)

SSC_GetDistTurn:
		sub.b	d1,d0					; get distance between the players
		addi.b	#$10,d0					; ensure if the position is on the negative side, it's converted to negative
		andi.w	#$001F,d0				; ''
		subi.w	#$0010,d0				; ''
		move.w	d0,d1					; ''
		bpl.s	SSC_GDT_Pos				; if positive, branch
		neg.w	d1					; convert to positive

SSC_GDT_Turning:
		addq.w	#$01,d1					; add 1 for turning (must be since negative is always non-zero)
		tst.w	d0					; recheck d0 (for polarity checking/absolute equal)
		rts						; return

SSC_GDT_Pos:
		bne.s	SSC_GDT_Turning				; if it's not zero, branch for turning
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check if a player has passed a sphere's central point
; ---------------------------------------------------------------------------

SSC_CheckPassed:
		move.w	ESS_FloorPos(a2),d0			; load floor position
		andi.w	#$0700,d0				; get only within a squares' position
		lsr.w	#$03,d0					; align with MSB of byte
		ext.w	d0					; extend sign
		asr.b	#$05,d0					; align correctly
		tst.w	ESS_FloorSpeed(a2)			; is the player moving forwards?
		bpl.s	SSC_CP_NoRev				; if not, branch
		neg.b	d0					; reverse position

SSC_CP_NoRev:
		tst.b	d0					; is the player a step passed the sphere?
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check a sphere at a specific spot to see if it's landable
; --- inputs ----------------------------------------------------------------
; d1.w = location
; ---------------------------------------------------------------------------

SSC_CheckLand:
		and.w	d6,d1					; keep layout in range
		move.b	(a1,d1.w),d0				; load sphere
		andi.b	#$07,d0					; get only the display type
		cmpi.b	#$01,d0					; is this a star bumper?
		beq.s	SSC_CL_NoLand				; if so, branch
		cmpi.b	#$04,d0					; is this a collected sphere?
		blo.s	SSC_CL_YesLand				; if not, branch

SSC_CL_NoLand:
		andi.b	#%11011,ccr				; clear Z flag (non-zero)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check a sphere at a specific spot to see if it's a collectable blue/orange
; --- inputs ----------------------------------------------------------------
; d1.w = location
; ---------------------------------------------------------------------------

SSC_CheckBlue:
		and.w	d6,d1					; keep layout in range
		move.b	(a1,d1.w),d0				; load sphere
		andi.b	#$07,d0					; get only the display type
		subq.b	#$02,d0					; minus blue
		cmpi.b	#$03-1,d0				; is the sphere blue/orange (or grey)?
		bhi.s	SSC_CL_NoLand				; if not, branch

SSC_CL_YesLand:
		ori.b	#%00100,ccr				; set Z flag (zero)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check a sphere at a specific spot to see if it's a collectable blue/orange
; Or just collected
; --- inputs ----------------------------------------------------------------
; d1.w = location
; ---------------------------------------------------------------------------

SSC_CheckBlueRed:
		and.w	d6,d1					; keep layout in range
		move.b	(a1,d1.w),d0				; load sphere
		andi.b	#$07,d0					; get only the display type
		subq.b	#$02,d0					; minus blue
		bmi.s	SSC_CL_NoLand				; if it's a blank or a star bumper, branch
		ori.b	#%00100,ccr				; set Z flag (zero)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to roam about the level (until a blue sphere can be seen)
; ---------------------------------------------------------------------------

SSC_Roam:
	move.w	#$00AE,(Normal_palette+$40).w

		bsr.s	SSC_CheckRecording			; perform record checking

		bsr.w	SSC_CheckPassed				; has the player passed the current sphere?
		bgt.s	SSCR_NoQuickJump			; if so, branch (don't bother jumping over it now)
		move.w	d4,d1
		bsr.w	SSC_CheckLand
		beq.s	SSCR_NoQuickJump
		ori.b	#CPU_B,d7				; jump over the sphere

SSCR_NoQuickJump:
		tst.b	(a4,d4.w)				; has the CPU been in this spot before?
		bpl.s	SSCR_NoDesparate			; if not, branch
		move.l	#SSC_DesperateRoam,ESS_RoutCPU(a2)	; set to run desperate routine
		rts						; return

SSCR_NoDesparate:
		move.w	(a0),d1					; get two steps ahead
		add.w	d1,d1					; ''
		add.w	d4,d1					; ''
		bsr.w	SSC_CheckLand				; is it landable?
		beq.s	SSCR_NoBlockAhead			; if so, branch
		add.w	(a0),d1					; check one step further
		bsr.w	SSC_CheckLand				; ''
		beq.s	SSCR_NoBlockAhead			; if so, branch (can jump over the one/single)

		moveq	#$00,d5					; set to use default distance
		bsr.w	SSCR_StrictRight			; detect left then right
		bne.s	SSCR_NoBlockAhead			; if a direction was found, branch
		bsr.w	SSCR_StrictLeft				; detect left then right
		bne.s	SSCR_NoBlockAhead			; if a direction was found, branch

	ori.b	#CPU_B,d7

SSCR_NoBlockAhead:
		rts						; return


; ---------------------------------------------------------------------------
; Subroutine to check recorded spheres (if applicable)
; ---------------------------------------------------------------------------

SSC_CheckRecording:
		move.w	d4,d1					; load current layout address
		and.w	d6,d1					; keep within the layout
		lea	$40(a1),a4				; load the memory layout
		btst.b	#$00,(a4,d1.w)				; has the CPU attempted to get to a sphere from this spot?
		bne.s	SSCR_IgnoreRecording			; if so, branch to ignore recording (it could not get there the last time, so it won't get there now)

		move.w	ESS_SphereFarDest(a2),d1		; was a far away sphere recorded?
		bmi.s	SSCR_NoGoTo				; if not, branch

SSCR_FoundSphere:
		move.w	d1,ESS_SphereDest(a2)			; set to goto the far away sphere next
		st.b	ESS_SphereFarDest(a2)			; clear far away record
		move.l	#SSC_Goto,ESS_RoutCPU(a2)		; set routine
		bra.w	SSC_GoTo				; run the routine right away (I see no harm in this instance)

SSCR_NoGoTo:
		move.w	ESS_SphereNear(a2),d1			; load near sphere
		bpl.s	SSCR_FoundSphere			; if a sphere was noticed on-screen, branch
		rts						; return

SSCR_IgnoreRecording:
		st.b	ESS_SphereDest(a2)			; set no destination spheres (likely can't get to them yet)
		st.b	ESS_SphereFarDest(a2)			; ''
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to roam more aggressively in desperation
; ---------------------------------------------------------------------------

SSC_DesperateRoam:

	move.w	#$000E,(Normal_palette+$40).w

		bsr.s	SSC_CheckRecording			; perform record checking

		move.w	(a0),d2
		bsr.s	SSC_CheckPath
		cmpi.w	#$0002,d5
		blo.s	SSCDR_NoForwards

		bsr.w	SSC_CheckPassed				; has the player passed the current sphere?
		bgt.s	SSCDR_CheckNextJump			; if so, branch (don't bother jumping over it now)
		move.w	d4,d1
		bsr.w	SSC_CheckLand
		beq.s	SSCDR_NoQuickJump
		ori.b	#CPU_B,d7				; jump over the sphere
		rts

SSCDR_CheckNextJump:
		move.w	d4,d1
		add.w	(a0),d1
		bsr.w	SSC_CheckLand
		beq.s	SSCDR_NoQuickJump

		add.w	(a0),d1
		bsr.w	SSC_CheckLand
		beq.s	SSCDR_NoBumper
		cmpi.b	#$01,d0
		bne.s	SSCDR_NoBumper
		move.b	ESS_FloorPos(a0),d0
		subq.b	#$07,d0
		andi.b	#$07,d0
		bne.s	SSCDR_NoQuickJump

SSCDR_NoBumper:
		ori.b	#CPU_B,d7				; jump over the sphere

SSCDR_NoQuickJump:
		rts

SSCDR_NoForwards:
		move.w	-$02(a0),d2
		bsr.s	SSC_CheckPath
		cmpi.w	#$0002,d5
		blo.s	SSCDR_NoLeft
		ori.b	#CPU_L,d7
		rts

SSCDR_NoLeft:
		move.w	$02(a0),d2
		bsr.s	SSC_CheckPath
		cmpi.w	#$0002,d5
		blo.s	SSCDR_NoRight
		ori.b	#CPU_R,d7
		rts

SSCDR_NoRight:
		rts














; ===========================================================================
; ---------------------------------------------------------------------------
; Checking a path line to see how many spots are empty (four steps away)
; ---------------------------------------------------------------------------

SSC_CheckPath:
		moveq	#$04-1,d3				; set number of steps to check
		moveq	#$00,d5					; reset land counter
		move.w	d4,d1					; load current position

SSCCP_NextPath:
		add.w	d2,d1					; move towards direciton/path
		bsr.w	SSC_CheckLand				; check current step
		bne.s	SSCCP_NoPath				; if we cannot land on it, branch
		addq.w	#$01,d5					; increase land counter

SSCCP_NoPath:
		dbf	d3,SSCCP_NextPath			; repeat for number of steps
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to go to a destination (where a blue sphere exists)
; ---------------------------------------------------------------------------

SSC_GoTo:
	move.w	#$00E0,(Normal_palette+$40).w
		moveq	#2+2,d3					; set distance to record far away spheres by
		bsr.w	SSC_RecordFar				; check for a far away sphere and record it for later

	; --- Just checking if there's a closer sphere first ---

	move.w	ESS_SphereNear(a2),d1			; load new destination
	bmi.s	SSCGT_NoNew				; if there is no new destination, branch
	cmp.w	ESS_SphereDest(a2),d1			; are we already heading towards this sphere?
	beq.s	SSCGT_NoNew				; if so, branch
	bsr.w	SSC_CheckBlue				; is there a blue sphere there?  (Should be, or else it wouldn't be in ESS_Sphere, but whatever, just in-case)
	bne.s	SSCGT_NoNew				; if not, branch

	moveq	#$FF,d2					; set current distance to maximum (in-case there is no current sphere)
	move.b	ESS_SphereDest(a2),d0			; check Y distance (include turn count if moving along X)
	move.b	ESS_LayoutY(a2),d1			; ''
	bsr.w	SSC_GetDistY				; ''
	move.w	d1,d2					; store 
	move.b	ESS_SphereDest+$01(a2),d0		; check X distance (include turn count if moving along Y)
	move.b	ESS_LayoutX(a2),d1			; ''
	bsr.w	SSC_GetDistX				; ''
	add.w	d1,d2					; get total distance

		; Distance away from new destination

	move.b	ESS_SphereNear(a2),d0			; check Y distance (include turn count if moving along X)
	move.b	ESS_LayoutY(a2),d1			; ''
	bsr.w	SSC_GetDistY				; ''
	move.w	d1,d3					; store 
	move.b	ESS_SphereNear+$01(a2),d0		; check X distance (include turn count if moving along Y)
	move.b	ESS_LayoutX(a2),d1			; ''
	bsr.w	SSC_GetDistX				; ''
	add.w	d1,d3					; get total distance

		; Checking which is closer

	cmp.w	d3,d2					; is the new position closer?
	bls.s	SSCGT_NoNew				; if not, branch
	move.w	ESS_SphereNear(a2),ESS_SphereDest(a2)	; set new destination

	btst.b	#$00,ESS_Point(a2)			; is the stage rotating?
	bne.s	SSCGT_NoNew				; if so, branch
	sf.b	ESS_Point(a2)				; clear the pointing/direction (left/right might have been pressed while it was heading towards the other sphere)

SSCGT_NoNew:
	move.b	ESS_Point(a2),(ESS_Debug06).w
	move.w	ESS_SphereDest(a2),(ESS_Debug04).w

	; --- Checking if a sphere has been collected, or if the destination was collected ---

		move.w	d4,d1					; check sphere at current location
		bsr.w	SSC_CheckBlue				; is it a blue sphere?
		bne.s	SSCGT_NoBlue				; if not, branch
		st.b	ESS_SphereDest(a2)			; clear the destination sphere (since we've collected a nearer blue apparently)
		move.l	#SSC_NextTo,ESS_RoutCPU(a2)		; set to run the "next-to" routine to follow other blues around this one
		rts						; return

SSCGT_NoBlue:
		move.w	ESS_SphereDest(a2),d1			; check sphere at destination
		bsr.w	SSC_CheckBlue				; is it still a blue sphere?
		beq.s	SSCGT_StillBlue				; if so, branch
		st.b	ESS_SphereDest(a2)			; clear the destination sphere (since it's gone now)
		move.l	#SSC_Roam,ESS_RoutCPU(a2)		; set to run the roaming routine (finding another sphere)
		rts						; return

SSC_GT_Direct:	bra.w	SSC_GT_Up				; North
		bra.w	SSC_GT_Right				; East
		bra.w	SSC_GT_Down				; South
		bra.w	SSC_GT_Left				; West

SSCGT_StillBlue:
		move.b	ESS_Direction(a2),d0			; load direction
		andi.w	#$0006,d0				; wrap it
		add.w	d0,d0					; multiply by size of word
		jsr	SSC_GT_Direct(pc,d0.w)			; run direction routine first to collect correct direction data

	tst.b	ESS_Move(a2)				; is the player moving backwards?
	bpl.s	SSCGT_NoReverse				; if not, branch
	ori.b	#CPU_U,d7				; press up

SSCGT_NoReverse:

	; --- Now the standard movement/goto/checks ---

		bsr.w	SSC_CheckPassed				; has the player passed the current sphere?
		bgt.s	SSCGT_NoJumpQuick			; if so, branch (don't bother jumping over it now)
		move.w	d4,d1					; check the current position, is it a land-able position?
		bsr.w	SSC_CheckLand				; ''
		beq.s	SSCGT_NoJumpQuick			; if so, branch	
		ori.b	#CPU_B,d7				; perform a quick jump...

SSCGT_NoJumpQuick:
		move.b	(a0),d2					; load layout direction/movement
		move.b	REG00.w,d0				; check Y distance
		move.b	REG01.w,d1				; ''
		bsr.w	SSC_GetDist				; ''
		beq.w	SSCGT_ReachedY				; if we've reached the correct Y, branch
		bpl.s	SSCGT_DownCheck				; if the distance is below us, branch
		addi.b	#$80,d2					; reverse direction check (cannot use neg since an $80 negated = $80...)

SSCGT_DownCheck:
		tst.b	d2					; is the layout direction facing the same way?  (are we moving towards the sphere)
		bpl.s	SSCGT_CorrectWay			; if so, branch

	; --- Moving away from the sphere Y ---

	; Turn around here...

		move.b	REG02.w,d0				; check X distance
		move.b	REG03.w,d1				; ''
		bsr.w	SSC_GetDist				; ''
		bpl.s	SSCGT_AroundRight			; if the sphere is to the right, branch

		moveq	#$02,d5
		bsr.w	SSCGT_DetectLeft
		rts						; return

SSCGT_AroundRight:

		moveq	#$02,d5
		bsr.w	SSCGT_DetectRight
		rts						; return

	; --- Moving towards the sphere on Y ---

SSCGT_CorrectWay:
		move.w	d1,d2					; keep a copy of the Y distance
		move.w	(a0),d1					; load sphere location ahead
		add.w	d4,d1					; ''
		bsr.w	SSC_CheckLand				; is the spot land-able?
		beq.s	SSCGT_NoAvoid				; if so, branch
		move.w	d2,d5					; load positive distance
		move.w	(a0),d3					; load direction ahead
		bsr.w	SSC_CheckDir				; check ahead
		bne.s	SSCGT_CheckMemory			; if there were no spots ahead, branch

		; --- Bumper jump check... ---
		; Because the bumper is an instant bump
		; as soon as you touch it, the quick jump
		; needs to be made BEFORE landing on the step.
		; This below will ensure that.
		; --- --- --- --- --- --- ---

		move.w	(a0),d1					; load sphere location ahead
		add.w	d4,d1					; ''
		and.w	d6,d1					; keep within the layout
		move.b	(a1,d1.w),d0				; ''
		andi.b	#$07,d0					; ''
		cmpi.b	#$01,d0					; is this a star bumper?
		bne.s	SSCGT_NoBumper				; if not, branch (normal check)
		move.b	ESS_FloorPos(a2),d0			; load current position
		andi.b	#$07,d0					; ''
		btst.l	#$00,d2					; is there an odd number of steps to land on the turning point?
		beq.s	SSCGT_DoJump				; if not, branch do normal jump now
		cmpi.b	#$03,d0					; are we at the last position before moving to the next step?
		beq.s	SSCGT_DoJump				; if so, branch (do the jump now before we touch the bumper)
		rts						; return

SSCGT_NoBumper:
		; --- --- --- --- --- --- ---

		btst.l	#$00,d2					; is there an odd number of steps to land on the turning point?
		bne.s	SSCGT_NoAvoid				; if so, branch to skip jumping (will jump on next step probably via "JumpQuick")

SSCGT_DoJump:
		ori.b	#CPU_B,d7				; jump over the sphere

SSCGT_NoAvoid:
		rts						; return

SSCGT_CheckMemory:
		tst.b	ESS_Changed(a2)				; has the layout position recently changed?
		beq.s	SSCGT_NoJump				; if not, branch
		move.w	d4,d1					; load current position
		and.w	d6,d1					; ''
		lea	$40(a1),a4				; load memory layout
		bset.b	#$00,(a4,d1.w)				; mark this spot as "I've attempted here before"
		beq.s	SSCGT_NoJump				; if it wasn't already set like that, branch
	;sf.b	(a4,d1.w)
		st.b	ESS_SphereDest(a2)			; clear ALL destination spheres that were recorded
		st.b	ESS_SphereFarDest(a2)			; ''
		move.l	#SSC_Roam,ESS_RoutCPU(a2)		; set to roam about next

SSCGT_NoJump:
		move.b	REG02.w,d0				; check X distance
		move.b	REG03.w,d1				; ''
		bsr.w	SSC_GetDist				; ''
		bpl.s	SSCGT_CheckRight

	; --- Check turning left ---

SSCGT_CheckLeft:
		move.w	d1,d5					; load positive distance
		bsr.s	SSCGT_DetectLeft			; detect left then right
		bne.s	SSCGT_FoundLeft				; if a direction was found, branch

	; Not sure what to do, I guess you can't win, the only thing to do is perhaps to keep jumping?

		ori.b	#CPU_B,d7				; jump over the sphere

SSCGT_FoundLeft:
		rts						; return

	; --- Check turning right ---

SSCGT_CheckRight:
		move.w	d1,d5					; load positive distance
		bsr.s	SSCGT_DetectRight			; detect right then left
		bne.s	SSCGT_FoundRight			; if a direction was found, branch

	; Not sure what to do, I guess you can't win, the only thing to do is perhaps to keep jumping?

		ori.b	#CPU_B,d7				; jump over the sphere

SSCGT_FoundRight:
		rts						; return

	; --- When reached the Y axis, now turning towards the X ---

SSCGT_ReachedY:
		move.b	REG02.w,d0				; check X distance
		move.b	REG03.w,d1				; ''
		bsr.w	SSC_GetDist				; ''
		bpl.s	SSCGT_TurnRight				; if the sphere is to the right, branch
		ori.b	#CPU_L,d7				; press left
		rts						; return

SSCGT_TurnRight:
		ori.b	#CPU_R,d7				; press right
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Checking the left and then right
; --- inputs ----------------------------------------------------------------
; d5.w = Positive distance away from destination
; ---------------------------------------------------------------------------

SSCGT_DetectLeft:
		move.w	-$02(a0),d3				; load direction left
		bsr.w	SSC_CheckDir				; check the left side first
		bne.s	SSC_CL_NoTurnLeft			; if there were no spots to the left, branch
		ori.b	#CPU_L,d7				; press left
		rts						; return

SSC_CL_NoTurnLeft:
		move.w	$02(a0),d3				; load direction right
		bsr.w	SSC_CheckDir				; check the right side first
		bne.s	SSC_CL_NoTurnRight			; if there were no spots to the right, branch
		ori.b	#CPU_R,d7				; press right
		rts						; return

SSC_CL_NoTurnRight:
		ori.b	#%00100,ccr				; set zero flag
		rts						; return

; ---------------------------------------------------------------------------
; Checking the right and then left
; --- inputs ----------------------------------------------------------------
; d5.w = Positive distance away from destination
; ---------------------------------------------------------------------------

SSCGT_DetectRight:
		move.w	$02(a0),d3				; load direction right
		bsr.s	SSC_CheckDir				; check the right side first
		bne.s	SSC_CR_NoTurnRight			; if there were no spots to the right, branch
		ori.b	#CPU_R,d7				; press right
		rts						; return

SSC_CR_NoTurnRight:
		move.w	-$02(a0),d3				; load direction left
		bsr.s	SSC_CheckDir				; check the left side first
		bne.s	SSC_CR_NoTurnLeft			; if there were no spots to the left, branch
		ori.b	#CPU_L,d7				; press left
		rts						; return

SSC_CR_NoTurnLeft:
		ori.b	#%00100,ccr				; set zero flag
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Left/Right checking, this is a stricter version, there must be at least one
; landable spot right away to allow the turning, or else it will immediately
; fail...
; ---------------------------------------------------------------------------
; Checking the left and then right
; --- inputs ----------------------------------------------------------------
; d5.w = Positive distance away from destination
; ---------------------------------------------------------------------------

SSCR_StrictLeft:
		move.w	-$02(a0),d3				; load direction left
		bsr.s	SSC_CheckDir				; check the left side first
		cmpi.w	#$0001,d2				; was at least the first spot blank?
		bhi.s	SSCR_SL_NoTurnLeft			; if not, branch
		ori.b	#CPU_L,d7				; press left
		rts						; return

SSCR_SL_NoTurnLeft:
		move.w	$02(a0),d3				; load direction right
		bsr.s	SSC_CheckDir				; check the right side first
		cmpi.w	#$0001,d2				; was at least the first spot blank?
		bhi.s	SSCR_SL_NoTurnRight			; if not, branch
		ori.b	#CPU_R,d7				; press right
		rts						; return

SSCR_SL_NoTurnRight:
		ori.b	#%00100,ccr				; set zero flag
		rts						; return

; ---------------------------------------------------------------------------
; Checking the right and then left
; --- inputs ----------------------------------------------------------------
; d5.w = Positive distance away from destination
; ---------------------------------------------------------------------------

SSCR_StrictRight:
		move.w	$02(a0),d3				; load direction right
		bsr.s	SSC_CheckDir				; check the right side first
		cmpi.w	#$0001,d2				; was at least the first spot blank?
		bhi.s	SSCR_SR_NoTurnRight			; if not, branch
		ori.b	#CPU_R,d7				; press right
		rts						; return

SSCR_SR_NoTurnRight:
		move.w	-$02(a0),d3				; load direction left
		bsr.s	SSC_CheckDir				; check the left side first
		cmpi.w	#$0001,d2				; was at least the first spot blank?
		bhi.s	SSCR_SR_NoTurnLeft			; if not, branch
		ori.b	#CPU_L,d7				; press left
		rts						; return

SSCR_SR_NoTurnLeft:
		ori.b	#%00100,ccr				; set zero flag
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check a single direction to see if there is a landing spot
; somewhere...
; --- inputs ----------------------------------------------------------------
; d3.w = layout direction adding (to be loaded from (a0) in whatever way)
; d5.w = Positive distance away from destination
; --- outputs ---------------------------------------------------------------
; d2.w = Number of steps away where you can land
; ---------------------------------------------------------------------------

SSC_CheckDir:
		moveq	#$01,d2					; reset distance counter
		cmpi.w	#CPU_MAXSTEPS,d5			; is the distance more than 4 steps away?
		bhs.s	SSC_CD_NoDest				; if so, branch
		tst.w	d5					; is there a valid distance to use?
		beq.s	SSC_CD_NoDest				; if not, we are already on the same axis, so branch

	; --- Normal check ---

SSC_CD_SearchDir:
		move.w	d3,d1					; load direction
		muls.w	d2,d1					; get distance
		add.w	d4,d1					; add current position
		bsr.w	SSC_CheckLand				; is the spot land-able?
		beq.s	SSC_CD_TurnDir				; if so, branch
		addq.w	#$01,d2					; increase distance
		cmp.w	d5,d2					; have we reached the final destination?
		ble.s	SSC_CD_SearchDir			; if not, branch

SSC_CD_TooFar:
		andi.b	#%11011,ccr				; clear Z flag (set non-zero)

SSC_CD_TurnDir:
		rts						; return

	; --- Maximum distance ---
	; Setting a maximum distance check of 4
	; If we are already on the same axis but have to turn away to turn
	; around or whatever, then 4 steps are checked automatically.
	; --- --- --- --- ---

SSC_CD_NoDest:
		move.w	d3,d1					; load direction
		muls.w	d2,d1					; get distance
		add.w	d4,d1					; add current position
		bsr.w	SSC_CheckLand				; is the spot land-able?
		beq.s	SSC_CD_TurnDir				; if so, branch
		addq.w	#$01,d2					; increase distance
		cmp.w	#CPU_MAXSTEPS,d2			; have we reached the final destination?
		ble.s	SSC_CD_NoDest				; if not, branch
		andi.b	#%11011,ccr				; clear Z flag (set non-zero)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Direction collection routines
; ---------------------------------------------------------------------------

	; --- Going north ---

SSC_GT_Up:
		move.b	ESS_SphereDest(a2),REG00.w
		move.b	ESS_LayoutY(a2),REG01.w
		move.b	ESS_SphereDest+$01(a2),REG02.w
		move.b	ESS_LayoutX(a2),REG03.w
		rts

	; --- Going east ---

SSC_GT_Right:
		move.b	ESS_SphereDest+$01(a2),REG00.w
		move.b	ESS_LayoutX(a2),REG01.w
		move.b	ESS_SphereDest(a2),REG02.w
		move.b	ESS_LayoutY(a2),REG03.w
		rts

	; --- Going south ---

SSC_GT_Down:
		move.b	ESS_SphereDest(a2),REG00.w
		move.b	ESS_LayoutY(a2),REG01.w
		move.b	ESS_LayoutX(a2),REG02.w
		move.b	ESS_SphereDest+$01(a2),REG03.w
		rts

	; --- Going west ---

SSC_GT_Left:
		move.b	ESS_SphereDest+$01(a2),REG00.w
		move.b	ESS_LayoutX(a2),REG01.w
		move.b	ESS_LayoutY(a2),REG02.w
		move.b	ESS_SphereDest(a2),REG03.w
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to keep a record of a far away sphere it might have seen
; --- inputs ----------------------------------------------------------------
; d3.w = Distance away the sphere has to be minimum to record it
; ---------------------------------------------------------------------------

SSC_RecordFar:
		tst.w	ESS_SphereFar(a2)			; is there a sphere to follow?
		bmi.s	SSCRF_NoRemember			; if not, branch
		move.b	ESS_SphereFar(a2),d0			; get Y distance
		move.b	ESS_LayoutY(a2),d1			; ''
		bsr.w	SSC_GetDistY				; ''
		move.w	d1,d2					; store Y distance
		move.b	ESS_SphereFar+$01(a2),d0		; get X distance
		move.b	ESS_LayoutX(a2),d1			; ''
		bsr.w	SSC_GetDistX				; ''
		add.w	d1,d2					; add X distance to Y
		cmp.w	d3,d2					; is it far away enough?
		bls.s	SSCRF_NoRemember			; if not, branch (only save ones far enough away)
		move.w	ESS_SphereFar(a2),ESS_SphereFarDest(a2)	; set destination

SSCRF_NoRemember:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to following a loop of blues until they're all gone
; ---------------------------------------------------------------------------

SSC_NextTo:
	move.w	#$0E00,(Normal_palette+$40).w
	tst.b	(ESS_Trap).w
	beq.s	SSC_NoTrap
	move	#$2700,sr
	bra.w	*

SSC_NoTrap:

	; --- Saving on-screen spheres seen for after the next-to's are gone ---

		move.w	#3+3,d3					; set distance to record far away spheres by
		bsr.s	SSC_RecordFar				; record far away spheres
		tst.w	ESS_SphereNear(a2)			; has a near sphere been found?
		bmi.s	SSCNT_NoClose				; if not, branch
		move.w	ESS_SphereNear(a2),ESS_SphereDest(a2)	; set to go to the near sphere

SSCNT_NoClose:

	; --- Checking to go right ---

		move.w	$02(a0),d1				; load sphere to the right
		add.w	d4,d1					; ''
		bsr.w	SSC_CheckBlue				; is it a blue sphere?
		bne.s	SSCNT_NoRight				; if not, branch

		; These checks may seem strange, but there may be a
		; loop of rings if we had gone forwards or left.  Where
		; going right would just end in a line (see the CNZ
		; stage 03 for an example)

		move.w	$02(a0),d1				; check the sphere above this one
		add.w	(a0),d1					; ''
		add.w	d4,d1					; ''
		bsr.w	SSC_CheckBlueRed			; is it a blue/red sphere?
		beq.s	SSCNT_Right				; if so, branch
		move.w	(a0),d1					; check the sphere directly above
		add.w	d4,d1					; ''
		bsr.w	SSC_CheckBlue				; is it a blue sphere?
		bne.s	SSCNT_DoLeft				; if not, branch
		add.w	-$02(a0),d1				; check the left/top shere
		bsr.w	SSC_CheckBlueRed			; is it a blue/red sphere?
		beq.s	SSCNT_Forwards				; if so, branch

SSCNT_DoLeft:
		move.w	-$02(a0),d1				; check the sphere to the left
		add.w	d4,d1					; ''
		bsr.w	SSC_CheckBlue				; is it a blue sphere?
		bne.s	SSCNT_Right				; if not, branch
		add.w	$04(a0),d1				; check the sphere below this one
		bsr.w	SSC_CheckBlueRed			; is it a blue/red sphere?
		beq.s	SSCNT_Left				; if so, branch

SSCNT_Right:
		ori.b	#CPU_R,d7				; press right
		rts						; return

SSCNT_NoRight:

	; --- Checking to go forwards ---

		move.w	(a0),d1					; load sphere above
		add.w	d4,d1					; ''
		bsr.w	SSC_CheckBlue				; is it a blue sphere?
		bne.s	SSCNT_NoForwards			; if not, branch

		; Checking to see if going left would result in
		; a ring loop rather than forwards

		add.w	-$02(a0),d1				; check the sphere to the left of the above
		bsr.w	SSC_CheckBlueRed			; is it a blue/red sphere?
		beq.s	SSCNT_Forwards				; if so, branch
		move.w	-$02(a0),d1				; check the sphere to the left
		add.w	d4,d1					; ''
		bsr.w	SSC_CheckBlue				; is it a blue sphere?
		bne.s	SSCNT_Forwards				; if not, branch
		add.w	$04(a0),d1				; check the sphere below this one
		bsr.w	SSC_CheckBlueRed			; is it a blue/red sphere?
		beq.s	SSCNT_Left				; if so, branch

SSCNT_Forwards:
		rts						; return

SSCNT_NoForwards:

	; --- Checking to go left ---

		move.w	-$02(a0),d1				; load sphere to the left
		add.w	d4,d1					; ''
		bsr.w	SSC_CheckBlue				; is it a blue sphere?
		bne.s	SSCNT_NoLeft				; if not, branch

SSCNT_Left:
		ori.b	#CPU_L,d7				; press left
		rts						; return

SSCNT_NoLeft:

	; --- Since the last sphere collected can end in a dead-end, check if we should turn ---

		move.w	(a0),d1					; load sphere above
		add.w	d4,d1					; ''
		bsr.w	SSC_CheckLand				; is it landable?
		beq.s	SSCNT_LandOK				; if so, branch
		ori.b	#CPU_L,d7				; press left
		move.w	-$02(a0),d1				; load sphere to the left
		add.w	d4,d1					; ''
		bsr.w	SSC_CheckLand				; is it landable?
		beq.s	SSCNT_LandOK				; if so, branch
		andi.b	#~CPU_L,d7				; remove left press
		ori.b	#CPU_R,d7				; press right instead
		move.w	$02(a0),d1				; load sphere to the right
		add.w	d4,d1					; ''
		bsr.w	SSC_CheckLand				; is it landable?
		beq.s	SSCNT_LandOK				; if so, branch
		andi.b	#~CPU_R,d7				; remove right press

SSCNT_LandOK:

	; --- Next-to spheres are now gone, no follow an on-screen if one exists ---

		move.w	d4,d1					; check current sphere
		bsr.w	SSC_CheckBlue				; has this sphere turned into a ring yet?
		beq.s	SSCNT_Return				; if not, branch (since the closest blues will still be on-screen, must wait til ring change)

		move.w	ESS_SphereDest(a2),d1			; load the near sphere that was remembered
		bmi.s	SSCNT_NoNear				; if there was no near sphere, branch
		bsr.w	SSC_CheckBlue				; is the sphere there still blue?
		beq.s	SSCNT_GoTo				; if so, branch (probably wasn't part of a ring loop we just changed)

SSCNT_NoNear:
		move.w	ESS_SphereFarDest(a2),d1		; load the far aware sphere that was remembered
		bmi.s	SSCNT_NoFar				; if there was no far sphere, branch
		bsr.w	SSC_CheckBlue				; is the sphere there still blue?
		bne.s	SSCNT_NoFar				; if not, branch (probably collected by now)
		move.w	d1,ESS_SphereDest(a2)			; set destination to the far away one we found

SSCNT_GoTo:
		st.b	ESS_SphereFarDest(a2)			; set no far away sphere anymore
		move.l	#SSC_GoTo,ESS_RoutCPU(a2)		; set routine
		rts						; return

SSCNT_NoFar:
		move.l	#SSC_Roam,ESS_RoutCPU(a2)		; set routine to roam about

SSCNT_Return:
		rts						; return

; ===========================================================================



















