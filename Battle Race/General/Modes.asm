; ===========================================================================
; ---------------------------------------------------------------------------
; Data for processing custom game mode code
; ---------------------------------------------------------------------------

ModeTbl_BattleRace:
		jmp	Process_BoxList(pc)		; $04 MJ: process the box list using Sonic/Tails' positions
		jmp	LevelSize_MainMode(pc)		; $08 NAT: Get level size for main levels
		jmp	UpdateHUD_BattleRace(pc)	; $0C update HUD on battle race
		dc.l	1<<24|HudMap_BattleRace		; $10 HUD mappings + level plc to load
		dc.l	0				; $14
		dc.w	$90, $70			; $18 monitor icon positions
		dc.l	Render_BattleRace		; $1C render sprites
		dc.l	MonitorCon_BattleRace		; $20 monitor contents table
		dc.l	Death_BattleRace		; $24 run special code when player is dead
		dc.l	JumpMove_BattleRace		; $28 run special code when player is about to do a jump move

ModeTbl_TeamMode:
		jmp	ModeProc_TeamMode(pc)		; $04 NAT: Process team mode
		jmp	LevelSize_MainMode(pc)		; $08 NAT: Get level size for main levels
		jmp	UpdateHUD_TeamMode(pc)		; $0C update HUD on team race
		dc.l	0<<24|HudMap_TeamMode		; $10 HUD mappings + level plc to load
		dc.l	0				; $14
		dc.w	$90, $70			; $18 monitor icon positions
		dc.l	Render_BattleRace		; $1C render sprites
		dc.l	MonitorCon_TeamMode		; $20 monitor contents table
		dc.l	Death_TeamMode			; $24 run special code when player is dead
		dc.l	JumpMove_BattleRace		; $28 run special code when player is about to do a jump move

ModeTbl_MiniCNZ1:
		jmp	ModeProc_MiniCNZ1(pc)		; $04 NAT: Process CNZ1
		jmp	LevelSize_MiniCNZ1(pc)		; $08 NAT: Get level size for main levels
		jmp	UpdateHUD_MiniCNZ1(pc)		; $0C update HUD on CNZ1 mini
		dc.l	1<<24|HudMap_MiniCNZ1		; $10 HUD mappings + level plc to load
		dc.l	0				; $14
		dc.w	$89, $70			; $18 monitor icon positions
		dc.l	DD_DrawMonitors			; $1C render sprites
		dc.l	MonitorCon_MiniCNZ1		; $20 monitor contents table
		dc.l	Death_BattleRace		; $24 run special code when player is dead
		dc.l	JumpMove_MiniCNZ1		; $28 run special code when player is about to do a jump move

ModeTbl_MiniDEZ2:
		jmp	ModeProc_MiniSSZ(pc)		; $04 NAT: Process SSZ
		jmp	LevelSize_MiniDEZ2(pc)		; $08 NAT: Get level size for main levels
		jmp	UpdateHUD_MiniSSZ(pc)		; $0C update HUD
		dc.l	3<<24|HudMap_MiniSSZ		; $10 HUD mappings + level plc to load
		dc.l	0				; $14
		dc.w	$90, $70			; $18 monitor icon positions
		dc.l	Render_BattleRace		; $1C render sprites
		dc.l	MonitorCon_BattleRace		; $20 monitor contents table
		dc.l	Death_BattleRace		; $24 run special code when player is dead
		dc.l	JumpMove_BattleRace		; $28 run special code when player is about to do a jump move

ModeTbl_MiniSSZ:
		jmp	ModeProc_MiniSSZ(pc)		; $04 NAT: Process SSZ
		jmp	LevelSize_MiniSSZ(pc)		; $08 NAT: Get level size for main levels
		jmp	UpdateHUD_MiniSSZ(pc)		; $0C update HUD
		dc.l	2<<24|HudMap_MiniSSZ		; $10 HUD mappings + level plc to load
		dc.l	0				; $14
		dc.w	$90, $70			; $18 monitor icon positions
		dc.l	Render_BattleRace		; $1C render sprites
		dc.l	MonitorCon_BattleRace		; $20 monitor contents table
		dc.l	Death_BattleRace		; $24 run special code when player is dead
		dc.l	JumpMove_BattleRace		; $28 run special code when player is about to do a jump move

ModeTbl_MiniAIZ2:
		jmp	ModeProc_MiniAIZ2(pc)		; $04 NAT: Process AIZ2
		jmp	LevelSize_MiniAIZ2(pc)		; $08 NAT: Get level size for main levels
		jmp	UpdateHUD_MiniCNZ1(pc)		; $0C update HUD on CNZ1 mini
		dc.l	1<<24|HudMap_MiniCNZ1		; $10 HUD mappings + level plc to load
		dc.l	0				; $14
		dc.w	$89, $70			; $18 monitor icon positions
		dc.l	DD_DrawMonitors			; $1C render sprites
		dc.l	MonitorCon_MiniCNZ1		; $20 monitor contents table
		dc.l	Death_BattleRace		; $24 run special code when player is dead
		dc.l	JumpMove_BattleRace		; $28 run special code when player is about to do a jump move

ModeTbl_MiniLBZ1:
		jmp	ModeProc_MiniLBZ1(pc)		; $04 NAT: Process LBZ1
		jmp	LevelSize_MiniLBZ1(pc)		; $08 NAT: Get level size for main levels
		jmp	UpdateHUD_BattleRace(pc)	; $0C update HUD on battle race
		dc.l	1<<24|HudMap_BattleRace		; $10 HUD mappings + level plc to load
		dc.l	0				; $14
		dc.w	$90, $70			; $18 monitor icon positions
		dc.l	DD_DrawMonitors			; $1C render sprites
		dc.l	MonitorCon_BattleRace		; $20 monitor contents table
		dc.l	Death_MiniLBZ1			; $24 run special code when player is dead
		dc.l	JumpMove_BattleRace		; $28 run special code when player is about to do a jump move

ModeTbl_MiniHPZ:
		jmp	Camera_Simple(pc)		; $04 NAT: Only process camera
		jmp	LevelSize_MiniHPZ(pc)		; $08 NAT: Get level size for main levels
		rts
		rts					; $0C no HUD at all
		dc.l	0				; $10 HUD mappings
		dc.l	0				; $14
		dc.w	$00, $00			; $18 monitor icon positions
		dc.l	DD_NoPalette			; $1C render no sprites
		dc.l	MonitorCon_BattleRace		; $20 monitor contents table
		dc.l	Death_BattleRace		; $24 run special code when player is dead
		dc.l	JumpMove_BattleRace		; $28 run special code when player is about to do a jump move
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to process CNZ1 mini game
; ---------------------------------------------------------------------------

ModeProc_MiniCNZ1:
		bset	#0,Player_1+status_secondary.w	; make sure pls dont die
		bset	#0,Player_2+status_secondary.w	;
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to process AIZ2 mini game
; ---------------------------------------------------------------------------

ModeProc_MiniAIZ2:
		bsr.s	ModeProc_CheckLevelEnd		; check if level ended
		pea	Camera_Simple(pc)		; NAT: Do a simple camera
; ---------------------------------------------------------------------------
; Subroutine to process level end
; ---------------------------------------------------------------------------

ModeProc_StdLevelEnd_Dead:
		cmp.b	#6,Player_1+routine.w		; check if p1 is alive
		bhs.s	ModeProc_StdLevelEnd		; no, branch
		cmp.b	#6,Player_2+routine.w		; check if p2 is alive
		blo.s	ModeProc_StdLevelEnd.rts	; yes, branch

ModeProc_StdLevelEnd:
		jsr	ChkOnFloorOrDead		; check if done
		bpl.s	.rts				; if not, branch
		jsr	SetLevelWinner			; set level winrar

		jsr	Create_New_Sprite.w		; load new object
		bne.s	.rts				; if failed, jump
		move.l	#Obj_EndSignResults2,(a1)	; set as the end sign

		st	ResultsShown.w			; show results
		st	(End_Of_Level_Flag).w			; set title card as being displayed
.rts		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to process LBZ1 mini game
; ---------------------------------------------------------------------------

ModeProc_MiniLBZ1:
		pea	Process_BoxList(pc)		; process the box list using Sonic/Tails' positions
; ===========================================================================
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check if level has ended
; ---------------------------------------------------------------------------

ModeProc_CheckLevelEnd:
		tst.b	ResultsShown.w			; check results
		beq.s	.rts				; if not shown, ignore
		tst.b	(End_Of_Level_Flag).w			; check if title card is showing
		bne.s	.wait				; if yes, wait
		move.b	#4,Game_mode.w			; go to SEGA
.rts		rts

.wait		addq.w	#4,sp				; pop things from stack
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to process SSZ mini game
; ---------------------------------------------------------------------------

ModeProc_MiniSSZ:
		bsr.s	ModeProc_CheckLevelEnd		; check if level ended
		subq.b	#1,MiniTimer.w			; decrease frame counter
		bpl.s	.proc				; if not completed, branch
		move.b	#60-1,MiniTimer.w		; else, reset frame counter
		subq.w	#1,MiniTimer+1.w		; decrease second counter
		bpl.s	.proc				; if positive still, branch

		clr.w	MiniTimer+1.w			; make sure seconds stay at 0
		move.b	#8,MiniTimer.w			; also constantly redraw HUD
		bsr.s	ModeProc_StdLevelEnd		; process level end

.proc		move.w	Minitimer+1.w,DisplayTimer.w	; copy timer accross
		jmp	Process_BoxList(pc)		; process the box list using Sonic/Tails' positions
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to process Team Mode
; ---------------------------------------------------------------------------

ModeProc_TeamMode:
		tst.b	End_Of_Level_Flag.w		; check if title card is showing
		bne.s	.show				; if yes, do not increase timer
		addq.b	#1,MiniTimer.w			; NAT: Increase timer
		cmp.b	#60,MiniTimer.w			; check for overflow
		bne.s	.show				; if not, skip

		clr.b	MiniTimer.w			; clear frame timer
		addq.w	#1,MiniTimer+1.w		; increase timer

.show	if demorecord
		tst.b	End_Of_Level_Flag.w		; check if title card is showing
		bne.s	.nochange			; if yes, do not track SRAM
		move.l	GhostAddress.w,a0		; load ghost address to a0
		move.b	#$01,($A130F1).l		; switch to SRAM
		btst	#0,Level_frame_counter.w	; check if this is an odd frame
		beq.s	.even				; if not, branch

		move.w	Player_2+x_pos.w,(a0)+		; save x-position to data
		move.w	Player_2+y_pos.w,(a0)+		; save y-position to data
		move.b	Player_2+status.w,(a0)+		; save status to data
		move.b	Player_2+mapping_frame.w,(a0)+	; save mappings to data
		move.b	Tails_tails+render_flags.w,(a0)+; tail status to data
		move.b	Tails_tails+mapping_frame.w,(a0)+; tail mappings to data
		bra.s	.exit

.even		move.w	Player_1+x_pos.w,(a0)+		; save x-position to data
		move.w	Player_1+y_pos.w,(a0)+		; save y-position to data
		move.b	Player_1+status.w,(a0)+		; save status to data
		move.b	Player_1+mapping_frame.w,(a0)+	; save mappings to data

.exit		move.w	MiniTimer+1.w,(a0)+		; save minitimer value
		move.l	a0,GhostAddress.w		; save ghost data back
		move.l	a0,$200000			; save data length to SRAM start
		move.b	#$00,($A130F1).l		; switch to ROM

.nochange
	endif

		move.w	Level_frame_counter.w,d0	; load the level frame counter to d0
		and.w	#3,d0				; get every 2nd frame
		bne.s	.proc				; if its not though, branch
		move.w	MiniTimer+1.w,d0		; load current minitimer value
		cmp.w	DisplayTimer.w,d0		; check if it is same as display timer

		sne	d0				; if not, set d0
		sgt	d1				; if displaytimer is greater, set d1
		sub.b	d1,d0				; sub that twice from d0
		sub.b	d1,d0				; sub that twice from d0

		ext.w	d0				; extend to word
		add.w	d0,DisplayTimer.w		; adjust
.proc		jmp	Process_BoxList(pc)		; process the box list using Sonic/Tails' positions
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to get the 360 distance between player 1 and 2
; ---------------------------------------------------------------------------

FBR_GetPlayerDist:
		move.w	(Player_1+x_pos).w,d1			; MJ6: get X distance
		sub.w	(Player_2+x_pos).w,d1			; MJ6: ''
		move.w	(Player_1+y_pos).w,d2			; MJ6: get Y distance
		sub.w	(Player_2+y_pos).w,d2			; MJ6: ''
		muls.w	d1,d1					; MJ6: square the X and Y distance
		muls.w	d2,d2					; MJ6: ''
		add.l	d1,d2					; MJ6: add them together to get the square direct distance
		bsr.w	CalcRoot				; MJ6: get the square root (line distance in d1 now...)
		move.w	d1,d2					; MJ6: copy distance to d2
		rts						; MJ6: return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check the 360 distances to see if they've crossed the arrow display distances
; ---------------------------------------------------------------------------
ArrowDistShort	= $08	; Short distance before no player wins
ArrowDistLong	= $10	; Long distance before 1 player wins
; ---------------------------------------------------------------------------

FBR_CheckDist:
		move.w	d2,d0					; MJ6: copy distance to d0
		addi.w	#ArrowDistShort,d0			; MJ6: add short distance
		cmpi.w	#ArrowDistShort*2,d0			; MJ6: is the distance below the short distance?
		bhs.s	FBRCD_NoShort				; MJ6: if not, branch
		move.w	d2,(ArrowDist).w			; MJ6: force shortest distance

FBRCD_Short:
		addq.w	#$04,sp					; MJ6: skip return address
		rts						; MJ6: return

FBRCD_NoShort:
		move.w	d2,d0					; MJ6: copy distance to d0
		addi.w	#ArrowDistLong,d0			; MJ6: add long distance
		cmpi.w	#ArrowDistLong*2,d0			; MJ6: is the distance below the long distance?
		blo.s	FBRCD_NoLong				; MJ6: if not, branch
		move.w	d2,(ArrowDist).w			; MJ6: force longest distance
		rts						; MJ6: return (let winner have the icon)

FBRCD_NoLong:
		move.w	(ArrowDist).w,d0			; MJ6: load distance that was set
		addi.w	#ArrowDistShort,d0			; MJ6: add short distance
		cmpi.w	#ArrowDistShort*2,d0			; MJ6: is the distance below the short distance?
		blo.s	FBRCD_Short				; MJ6: if so, branch
		rts						; MJ6: return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to search the box list...
; ---------------------------------------------------------------------------

PBL_Recheck:
		subq.w	#$08,a1					; MJ: move address back to beginning of entry
		move.w	x_pos(a0),d0				; MJ: load X and Y positions
		move.w	y_pos(a0),d1				; MJ: ''
		move.w	d0,d2					; MJ: copy X position
		sub.w	(a1)+,d2				; MJ: subtract start X of box
		cmp.w	(a1)+,d2				; MJ: is the player in the box range on X?
		bcc.s	PBLR_NotSame				; MJ: if not, branch
		move.w	d1,d2					; MJ: copy Y position
		sub.w	(a1)+,d2				; MJ: subtract start Y of box
		cmp.w	(a1)+,d2				; MJ: is the player in the box range on Y? (result on return)
		bcc.s	PBLR_NotSame				; MJ: if not, branch

		btst	#0,(a1)					; check if checking path
		beq.s	PBL_ChkValid				; if not, skip
		btst	#1,(a1)					; check if path 2
		bne.s	PBL_Path2				; if is, branch

		cmp.b	#$C,top_solid_bit(a0)			; check if on path 1
		bne.s	PBLR_NotSame				; if not, branch
		rts

PBL_Path2:
		cmp.b	#$C,top_solid_bit(a0)			; check if on path 1
		beq.s	PBLR_NotSame				; if yes, branch
		rts

PBL_ChkValid:
		cmpi.w	#$E0FF,(a1)				; MJ4: check the angle
		bne.s	PBLR_YesSame				; MJ4: if positive, this isn't the end box marker, so branch

	; the last entry is an end box marker to prevent overflowing, if the player is
	; in this box, then it means it didn't find an actual valid box last time, and
	; needs to check the list again...

PBLR_NotSame:
		move.l	(BoxLoc_Level).w,a1			; MJ: load start of list
		bra.s	PBLR_Start				; MJ: start inside the loop (quicker on looping)

PBLR_NotX:
		addq.w	#$04,a1					; MJ: advance to next entry

PBLR_NotY:
		addq.w	#$02,a1					; MJ: advance to next entry

PBLR_Start:
		move.w	d0,d2					; MJ: copy X position
		sub.w	(a1)+,d2				; MJ: subtract start X of box
		cmp.w	(a1)+,d2				; MJ: is the player in the box range on X?
		bcc.s	PBLR_NotX				; MJ: if not, branch
		move.w	d1,d2					; MJ: copy Y position
		sub.w	(a1)+,d2				; MJ: subtract start Y of box
		cmp.w	(a1)+,d2				; MJ: is the player in the box range on Y? (result on return)
		bcc.s	PBLR_NotY				; MJ: if not, branch

		btst	#0,(a1)					; check if checking path
		beq.s	PBLR_YesSame				; if not, skip
		btst	#1,(a1)					; check if path 2
		bne.s	PBLR_Path2				; if is, branch

		cmp.b	#$C,top_solid_bit(a0)			; check if on path 1
		bne.s	PBLR_NotY				; if not, branch

PBLR_YesSame:
		rts						; MJ: return

PBLR_Path2:
		cmp.b	#$C,top_solid_bit(a0)			; check if on path 1
		beq.s	PBLR_NotY				; if yes, branch
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to run through the box list, and work out which character is ahead/winning
; ---------------------------------------------------------------------------

Process_BoxList:
		pea	Control_BoxEvents(pc)			; MJ: run events for what happens when characters move outside of box and so forth...
		tst.b	(Debug_On).w				; MJ: is debug mode enabled?
		beq.s	FBR_NoDebugCont				; MJ: if not, branch
		move.b	(Ctrl_2_held).w,d0			; MJ: load player 2's controls
		lsr.b	#1,d0					; MJ: shift up into carry
		bcc.s	FBRC_NoUp				; MJ: if up was not held, branch
		subi.w	#$0100,(BoxAngle).w			; MJ: rotate box left

FBRC_NoUp:
		btst	#0,d0					; MJ: check down
		beq.s	FBR_NoDebugCont				; MJ: if down was not held, branch
		addi.w	#$0100,(BoxAngle).w			; MJ: rotate box right

FBR_NoDebugCont:
		lea	(Player_1).w,a0				; MJ: load player 1's object RAM
		move.l	#$7FFFFFFF,d4				; MJ3: set player 1's address to the last position even possible...
		tst.b	(Debug_On).w				; MJ: is debug mode enabled?
		bne.s	.p2					; MJ: if not, branch
		cmpi.b	#$06,routine(a0)			; MJ: is player 2 dying/dead?
		bhs.s	.p2					; MJ: if so, branch
		movea.l	(BoxLoc_Play1).w,a1			; MJ3: load player 1's current list address
		bsr.w	PBL_Recheck				; MJ: recheck the current box before searching the list
		move.l	a1,(BoxLoc_Play1).w			; MJ: store current list address for next frame (save on CPU time)
		move.l	a1,d4					; MJ: store player 1's list address

.p2		lea	(Player_2).w,a0				; MJ: load player 2's object RAM
		movea.l	#$7FFFFFFF,a1				; MJ3: set player 2's address to the last position even possible...
		tst.b	(Debug_On).w				; MJ: is debug mode enabled?
		bne.s	.dead					; MJ: if not, branch
		cmpi.b	#$06,routine(a0)			; MJ: is player 2 dying/dead?
		bhs.s	.dead					; MJ: if so, branch
		movea.l	(BoxLoc_Play2).w,a1			; MJ3: load player 2's current list address
		bsr.w	PBL_Recheck				; MJ: recheck the current box before searching the list
		move.l	a1,(BoxLoc_Play2).w			; MJ: store current list address for next frame (save on CPU time)

.dead		moveq	#$00,d0					; NAT: clear d0
		move.b	d0,(BoxLoopArea).w			; MJ4: set as not inside a loop box
		move.b	d0,(BoxWinner).w			; MJ: set no-one as winning
		move.b	d0,(BoxValidAngle).w			; NAT: set angle not as invalid
		sub.l	a1,d4					; MJ: subtract player 2' list address from player 1's
		bmi.s	FBR_Player1Ahead			; MJ: if negative, branch (player 1 is ahead)
		beq.w	FBR_CheckAhead				; MJ: if matched, branch (both in same box)

	; --- Player 2 ahead ---

FBR_Player2Ahead:
		bsr.w	FBR_GetPlayerDist			; MJ6: get the distance

FBR_Player2Ahead2:
		bsr.w	FBR_CheckDist				; MJ6: check the distances
		cmpi.b	#$06,(Player_2+routine).w		; MJ: is player 2 dying/dead?
		bhs.s	PBLR_No2Win				; MJ: if so, branch
		addq.b	#$02,(BoxWinner).w			; MJ: set winner as player 2
		movea.l	(BoxLoc_Play2).w,a1			; MJ: load player 2's current list address
		bra.s	FBR_GetAngle				; MJ: get the angle

PBLR_No2Win:
		cmpi.b	#$06,(Player_1+routine).w		; MJ: is player 1 dying/dead?
		bhs.W	PBLR_NoWinner				; MJ: if so, branch
		addq.b	#$01,(BoxWinner).w			; MJ: set winner as player 1
		movea.l	(BoxLoc_Play1).w,a1			; MJ: load player 1's current list address
		bra.s	FBR_GetAngle				; MJ: get the angle

	; --- Player 1 ahead ---

FBR_Player1Ahead:
		bsr.w	FBR_GetPlayerDist			; MJ6: get the distance

FBR_Player1Ahead2:
		bsr.w	FBR_CheckDist				; MJ6: check the distances
		cmpi.b	#$06,(Player_1+routine).w		; MJ: is player 1 dying/dead?
		bhs.s	PBLR_No1Win				; MJ: if so, branch
		addq.b	#$01,(BoxWinner).w			; MJ: set winner as player 1
		movea.l	(BoxLoc_Play1).w,a1			; MJ: load player 1's current list address
		bra.s	FBR_GetAngle				; MJ: get the angle

PBLR_No1Win:
		cmpi.b	#$06,(Player_2+routine).w		; MJ: is player2 dying/dead?
		bhs.s	PBLR_NoWinner				; MJ: if so, branch
		addq.b	#$02,(BoxWinner).w			; MJ: set winner as player 2
		movea.l	(BoxLoc_Play2).w,a1			; MJ: load player 2's current list address

	; --- Getting angle for same box... ---

FBR_GetAngle:
		tst.b	(Debug_On).w				; MJ: is debug mode enabled?
		bne.s	FBR_Control				; MJ: if is, branch
		tst.w	-$02(a1)				; MJ4: Check if box is valid (valid height)
		bmi.s	.notvalid				; NAT: If not, branch
		move.l	a1,BoxLoc_Valid.w			; NAT: Set last valid box location

.notvalid	move.w	(a1),d1					; MJ; load angle
		cmpi.w	#$C000,d1				; MJ4: is the angle negative (C000 - FFFF)?
		bcc.s	PBLR_NoWinner				; MJ: if so, this is directionless box (therefore no possible winner)
		move.b	d1,(BoxAngle).w				; MJ: store angle

FBR_Control:
		move.b	(BoxAnglePos).w,d1			; NAT; load previous frame's angle
		rts

PBLR_NoWinner:
		tst.b	(Debug_On).w				; MJ: is debug mode enabled?
		bne.s	FBR_Control				; MJ: if not, branch
		st.b	(BoxValidAngle).w			; NAT: set angle as invalid
		st.b	(BoxAngleFrame).w			; NAT: force angle to something invalid (so that the arrow art updates)

RBLR_NoWinKeepAngle:
	;	sf.b	(BoxWinner).w				; MJ4: set no-one as winning
		rts						; MJ4: return

; ===========================================================================
; ---------------------------------------------------------------------------
; Players are inside the same box, therefore a thorough calculation is to be done
; ---------------------------------------------------------------------------

FBR_CheckAhead:
		cmpa.l	#$7FFFFFFF,a1				; MJ3: are both players in limbo?  Dead?
		beq.s	RBLR_NoWinKeepAngle			; MJ4: ignore calculation...
		bsr.s	FBR_GetAngle				; MJ: get the angle
		move.w	d1,d5					; MJ4: copy angle
		subi.w	#$8000,d5				; MJ4: get only positive
		bmi.s	PBLR_NoLoopBox				; MJ4: if was positive, branch
		cmpi.w	#$4000,d5				; MJ4: is the angle negative (but not 80)?
		bge.s	PBLR_NoWinner				; MJ4: if the so, branch (no possible winner)
		st.b	(BoxLoopArea).w				; MJ4: set loop box flag

PBLR_NoLoopBox:
		andi.w	#$003F,d5				; MJ: get only within 90 degrees
		neg.w	d5					; MJ: convert to negative (quicker than loading this, and subtracting another)

		subq.w	#$08,a1					; MJ: move back to beginning of entry
		lsr.w	#$04,d1					; MJ: align four possible angles to multiples of 4
		andi.w	#$000C,d1				; MJ: ''
		jmp	FBR_Corners(pc,d1.w)			; MJ: run correct routine
FBR_Corners:	bra.w	FBR_TopRight				; MJ: angle 00 - 89 (top right corner)
		bra.w	FBR_BottomRight				; MJ: angle 90 - 179 (bottom right corner)
		bra.w	FBR_BottomLeft				; MJ: angle 180 - 269 (bottom left corner)
						; below...	; MJ: angle 270 - 359 (top left corner)

; ---------------------------------------------------------------------------
; angle 270 - 359 (top left corner)
; ---------------------------------------------------------------------------

FBR_TopLeft:
		move.w	(a1)+,d6				; MJ: load X position
		move.w	(a1),d7					; MJ: load Y position

		lea	(SineTable+$80).w,a1			; MJ: load sinewave table (X sine)

		lea	(Player_1).w,a0				; MJ: load player 1's object RAM
		bsr.w	FBR_ConvertPos				; MJ: convert X position for calculating distance
		move.w	d2,d3					; MJ: store player 1's position
		lea	(Player_2).w,a0				; MJ: load player 2's object RAM
		bsr.w	FBR_ConvertPos				; MJ: convert X position for calculating distance

		sub.w	d3,d2					; MJ6: is player 1 closer to the destination than player 2?
		blt.w	FBR_Player1Ahead2			; MJ: if so, branch
		bne.w	FBR_Player2Ahead2			; MJ: if player 2 is closer, branch
		rts						; MJ: return (drawing)

; ---------------------------------------------------------------------------
; angle 00 - 89 (top right corner)
; ---------------------------------------------------------------------------

FBR_TopRight:
		move.w	(a1)+,d6				; MJ: load X position
		add.w	(a1)+,d6				; MJ: add X range
		move.w	(a1),d7					; MJ: load Y position

		lea	(SineTable).w,a1			; MJ: load sinewave table (X sine)

		lea	(Player_1).w,a0				; MJ: load player 1's object RAM
		bsr.s	FBR_ConvertPos				; MJ: convert Y position for calculating distance
		move.w	d2,d3					; MJ: store player 1's position
		lea	(Player_2).w,a0				; MJ: load player 2's object RAM
		bsr.s	FBR_ConvertPos				; MJ: convert Y position for calculating distance

		sub.w	d3,d2					; MJ6: is player 1 closer to the destination than player 2?
		blt.w	FBR_Player1Ahead2			; MJ: if so, branch
		bne.w	FBR_Player2Ahead2			; MJ: if player 2 is closer, branch
		rts						; MJ: return (drawing)

; ---------------------------------------------------------------------------
; angle 90 - 179 (bottom right corner)
; ---------------------------------------------------------------------------

FBR_BottomRight:
		move.w	(a1)+,d6				; MJ: load X position
		add.w	(a1)+,d6				; MJ: add X range
		move.w	(a1)+,d7				; MJ: load Y position
		add.w	(a1)+,d7				; MJ: add Y range

		lea	(SineTable+$80).w,a1			; MJ: load sinewave table (X sine)

		lea	(Player_1).w,a0				; MJ: load player 1's object RAM
		bsr.s	FBR_ConvertPos				; MJ: convert X position for calculating distance
		move.w	d2,d3					; MJ: store player 1's position
		lea	(Player_2).w,a0				; MJ: load player 2's object RAM
		bsr.s	FBR_ConvertPos				; MJ: convert X position for calculating distance

		sub.w	d3,d2					; MJ6: is player 1 closer to the destination than player 2?
		bgt.w	FBR_Player1Ahead2			; MJ: if so, branch
		bne.w	FBR_Player2Ahead2			; MJ: if player 2 is closer, branch
		rts						; MJ: return (drawing)

; ---------------------------------------------------------------------------
; angle 180 - 269 (bottom left corner)
; ---------------------------------------------------------------------------

FBR_BottomLeft:
		move.w	(a1)+,d6				; MJ: load X position
		move.l	(a1)+,d7				; MJ: load Y position
		add.w	(a1)+,d7				; MJ: add Y range

		lea	(SineTable).w,a1			; MJ: load sinewave table (X sine)

		lea	(Player_1).w,a0				; MJ: load player 1's object RAM
		bsr.s	FBR_ConvertPos				; MJ: convert Y position for calculating distance
		move.w	d2,d3					; MJ: store player 1's position
		lea	(Player_2).w,a0				; MJ: load player 2's object RAM
		bsr.s	FBR_ConvertPos				; MJ: convert Y position for calculating distance

		sub.w	d3,d2					; MJ6: is player 1 closer to the destination than player 2?
		bgt.w	FBR_Player1Ahead2			; MJ: if so, branch
		bne.w	FBR_Player2Ahead2			; MJ: if player 2 is closer, branch
		rts						; MJ: return (drawing)

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to rotate the player's X or Y position such that it's in parallel
; with the correct direction.
; ---------------------------------------------------------------------------

FBR_ConvertPos:

	; --- Getting angle/arctangent between player and corner ---

		move.w	d6,d1					; MJ: get X distance from player to corner
		sub.w	x_pos(a0),d1				; MJ: ''
		move.w	d7,d2					; MJ: get Y distance from player to corner
		sub.w	y_pos(a0),d2				; MJ: ''
		jsr	GetArcTan.w				; MJ: get the angle between the player and the corner first...

	; --- Getting distance between player and corner ---

	;   _________________
	; ,/(X * 2) + (Y * 2) = Distance

		muls.w	d1,d1					; MJ: square the X and Y distance
		muls.w	d2,d2					; MJ: ''
		add.l	d1,d2					; MJ: add them together to get the square direct distance

		bsr.s	CalcRoot				; MJ: get the square root (line distance in d1 now...)

		add.b	d5,d0					; MJ: rotate angle around around
		moveq	#$00,d2					; MJ: clear upper junk
		move.b	d0,d2					; MJ: ''
		add.w	d2,d2					; MJ: multiply by word size
		move.w	(a1,d2.w),d2				; MJ: get new distance
		muls.w	d1,d2					; MJ: multiply by actual distance
		asr.l	#$08,d2					; MJ: get only quotient
		rts						; MJ: return

; ---------------------------------------------------------------------------
; Subroutine to calculate the square root of a longword inside d2
; (result goes as long-word inside d1)
; ---------------------------------------------------------------------------

CalcRoot:
		movem.l	d0/d3-d4,-(sp)				; MJ: store register data
		moveq	#$00,d0					; MJ: clear d0
		moveq	#$00,d4					; MJ: clear d4
		moveq	#($20/2)-1,d3				; MJ: set elements to count (20 bits, 2 each time)
		moveq	#$00,d1					; MJ: reset root value

CR_NextElement:
		add.l	d2,d2					; MJ: rotate two bits from d2 to d0
		addx.l	d0,d0					; MJ: ''
		add.l	d2,d2					; MJ: ''
		addx.l	d0,d0					; MJ: ''
		add.l	d1,d1					; MJ: shift square left
		add.l	d4,d4					; MJ: shift current result left
		addq.l	#$01,d4					; MJ: increase squareroot by 1
		cmp.l	d4,d0					; MJ: subtract from current value
		bcs.s	CR_IncrementRoot			; MJ: if current result is not larger than the input so far, branch
		sub.l	d4,d0					; MJ: restore result (cannot be larger)
		addq.l	#$01,d4					; MJ: decrease squareroot back again (cannot be larger)
		addq.l	#$01,d1					; MJ: increase square by 1
		dbf	d3,CR_NextElement			; MJ: repeat for number of elements
		movem.l	(sp)+,d0/d3-d4				; MJ: restore register data
		rts						; MJ: return

CR_IncrementRoot:
		subq.l	#$01,d4					; MJ: increase squareroot by another 1
		dbf	d3,CR_NextElement			; MJ: repeat for number of elements
		movem.l	(sp)+,d0/d3-d4				; MJ: restore register data
		rts						; MJ: return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control what happens to the characters/screen from the box details
; ---------------------------------------------------------------------------

Control_BoxEvents:
		lea	Player_1.w,a0				; NAT: Load p1 to a0
		lea	Player_2.w,a1				; NAT: Load p2 to a1

		tst.b	(Debug_On).w				; MJ: is debug mode enabled?
		bne.s	CBE_NoDeath				; MJ: if so, branch
		cmp.b	#$81,BossHitMode.w			; NAT: is special boss enabled?
		ble.s	CBE_NoDeath				; NAT: if so, branch
		cmp.b	#$7E,BossHitMode.w			; NAT: is special boss enabled?
		bge.s	CBE_NoDeath				; NAT: if so, branch
		bsr.w	CBE_ControlDeath			; MJ: control death first

CBE_NoDeath:

; ---------------------------------------------------------------------------
; Controlling the camera
; ---------------------------------------------------------------------------

	; some magic code here to correctly get Sonic's and Tails'
	; positions, if  there is some hscroll delay for them
	; since the camera is custom and accomodates both
	; players, it needs to be correctly handled here

		move.w	x_pos(a1),d7			; NAT: Get Tails x-offset to d7.low
		move.b	H_scroll_frame_offset_P2.w,d5	; NAT: Get camera lag offset for Tails
		beq.s	.gottailx			; branch if none
		subq.b	#1,d5				; decrease delay
		move.b	d5,H_scroll_frame_offset_P2.w	; save delay back in

		lsl.b	#2,d5				; multiply by 4
		addq.b	#4,d5				; add 1 to the offset
		move.w	Pos_table_index_P2.w,d6		; get pos table index to d6
		sub.b	d5,d6				; sub the offset from index

		lea	Pos_table_P2.w,a2		; get pos table to a2
		move.w	(a2,d6.w),d7			; get offset from the table to d7
		andi.w	#$7FFF,d7			; keep in range(?)

.gottailx	swap	d7				; load Sonic's positions into low word
		move.w	x_pos(a0),d7			; NAT: Get sonic x-offset to d7.low
		move.b	H_scroll_frame_offset.w,d5	; NAT: Get camera lag offset for Sonic
		beq.s	.gotsonicx			; branch if none
		subq.b	#1,d5				; decrease delay
		move.b	d5,H_scroll_frame_offset.w	; save delay back in

		lsl.b	#2,d5				; multiply by 4
		addq.b	#4,d5				; add 1 to the offset
		move.w	Pos_table_index.w,d6		; get pos table index to d6
		sub.b	d5,d6				; sub the offset from index

		lea	Pos_table.w,a2			; get pos table to a2
		move.w	(a2,d6.w),d7			; get offset from the table to d7
		andi.w	#$7FFF,d7			; keep in range(?)

.gotsonicx; Due to the screen resolution, the X appears to have more leeway
	; than the Y, and so:

	; X will have a 1/10th distance added towards winning player/direction
	; Y will have a 1/8th distance added towards winning player/direction

		moveq	#$00,d3					; MJ: clear d3
		move.b	(BoxAnglePos).w,d3			; MJ: load box angle position being used
		subi.b	#$40,d3					; MJ: rotate angle by 90 degrees
		add.w	d3,d3					; MJ: multiply by size of word
		lea	(SineTable+$01).w,a2			; MJ: load sine wave table
		move.w	-$01(a2,d3.w),d4			; MJ: load Y sine position
		move.w	+$7F(a2,d3.w),d3			; MJ: load X sine position
		asr.w	#$04,d3					; MJ: get fraction of the positions
		asr.w	#$04,d4					; MJ: ''

		cmpi.b	#$06,routine(a0)			; MJ: is player 1 dead/dying?
		blo.s	CBE_NoFollow2				; MJ: if not, branch
		cmpi.b	#$06,routine(a1)			; MJ: is player 2 also dead/dying?
		bhs.s	CBE_FreezeCamera			; MJ: if so, branch
		swap	d7					; get Tails' x-pos into low word
		add.w	d7,d3					; MJ: add player 2's position
		add.w	y_pos(a1),d4				; MJ:  ''
		move.w	d3,(CamFollow_X).w			; MJ: save as camera's position
		move.w	d4,(CamFollow_Y).w			; MJ: ''

CBE_CheckWrap:
		move.w	Screen_Y_wrap_value.w,d5		; NAT: get y-wrap value
		addq.w	#1,d5					; NAT: increase by 1
		move.w	d5,d3					; NAT: copy to d3
		lsr.w	#1,d3					; NAT: Halve it

		sub.w	y_pos(a0),d4				; NAT: sub player 1's y-position from follow pos
		bpl.s	.pos					; NAT: Bramch if positive value
		neg.w	d4					; NAT: negate offset

.pos		cmp.w	d4,d3					; NAT: Check if result is more than the half-y-wrap value
		bhs.s	CBE_FreezeCamera			; NAT: Branch if not
		sub.w	d5,CamFollow_Y.w			; NAT: Otherwise, make the CamFollow be negative

CBE_FreezeCamera:
		rts						; MJ: return

CBE_NoFollow2:
		cmpi.b	#$06,routine(a1)			; MJ: is player 2 dead/dying?
		blo.s	CBE_NoFollow1				; MJ: if not, branch
		add.w	d7,d3					; MJ: add player 1's position
		add.w	y_pos(a0),d4				; MJ: ''
		move.w	d3,(CamFollow_X).w			; MJ: save as camera's position
		move.w	d4,(CamFollow_Y).w			; MJ: ''

		exg	a0,a1					; NAT: swap registers
		bsr.s	CBE_CheckWrap				; NAT: check if wrapping needs to be done
		exg	a0,a1					; NAT: swap registers
		rts						; MJ: return

CBE_NoFollow1:
		move.w	d7,d1					; MJ3: get X and Y distance between player 1 and 2
		move.w	y_pos(a0),d2				; MJ3: ''
		swap	d7					; get Tails' x-pos into low word
		sub.w	d7,d1					; MJ3: ''
		sub.w	y_pos(a1),d2				; MJ3: ''

		move.w	Screen_Y_wrap_value.w,d5		; NAT: get y-wrap value
		lsr.w	#1,d5					; NAT: halve it
		add.w	d2,d5					; NAT: add half of y-diff to y-wrap value
		cmp.w	Screen_Y_wrap_value.w,d5		; NAT: check if diff is more or less than half of y-wrap val
		bcs.s	.nofix					; NAT: If not, do not fix val

		move.w	Screen_Y_wrap_value.w,d5		; NAT: Get y-wrap value
		tst.w	d2					; NAT: Check if diff was positive
		bmi.s	.add					; NAT: If wasn't, do not negate value
		neg.w	d5					; NAT: Negate addition
.add		add.w	d5,d2					; NAT: add Y-wrap value

.nofix		asr.w	#$01,d1					; MJ: get position between them
		asr.w	#$01,d2					; MJ: ''
		move.w	d1,d5					; MJ: get fraction the distances
		move.w	d2,d6					; MJ: ''
		asr.w	#$03,d5					; MJ: ''
		asr.w	#$03,d6					; MJ: ''
		tst.b	(BoxLoopArea).w				; MJ4: are they inside a loop box?
		bne.s	CBE_NoWinner				; MJ4: if so, branch to keep the camera in place
		move.b	(BoxWinner).w,d0			; MJ: load box winner
		beq.s	CBE_NoWinner				; MJ: if no-one is winning, branch and do NOT shift the camera
		subq.b	#$01,d0					; MJ: is player 1 winning?
		beq.s	CBE_Player1Win				; MJ: if so, branch to move towards player 1
		neg.w	d5					; MJ: reverse distance towards player 2
		neg.w	d6					; MJ: ''

CBE_Player1Win:
		add.w	d5,d1					; MJ: move towards winning player
		add.w	d6,d2					; MJ: ''

CBE_NoWinner:
		add.w	d3,d1					; MJ: move the centre distance towards the winning direction by 1/8
		add.w	d4,d2					; MJ: ''
		add.w	d7,d1					; MJ: readd player 2's position
		add.w	y_pos(a1),d2				; MJ: ''
		move.w	d1,(CamFollow_X).w			; MJ: save as camera's position
		move.w	d2,(CamFollow_Y).w			; MJ: ''
		rts						; MJ: return

; ---------------------------------------------------------------------------
; Controlling the death status of the players
; ---------------------------------------------------------------------------

CBE_ControlDeath:
		tst.b	SpawnWait.w				; check if we need to wait for spawn
		bne.s	CBE_WaitOnScr
		cmpi.b	#$06,routine(a0)			; MJ: is player 1 already dead/dying?
		bhs.s	CBE_Return				; MJ: if so, branch
		cmpi.b	#$06,routine(a1)			; MJ: is player 2 already dead/dying?
		bhs.s	CBE_Return				; MJ: if so, branch
		tst.b	(BoxValidAngle).w			; MJ: is the angle invalid?
		bne.s	CBE_KillBoth				; MJ: if so, branch
		moveq	#$02-1,d7				; MJ: set number of players to run
		moveq	#$01,d6

CBE_NextPlayer:
		tst.b	render_flags(a0)			; MJ: is the character off-screen?
		bmi.s	CBE_NoDie				; MJ: if not, branch
		tst.b	(BoxWinner).w				; MJ: is it a draw so far?
		beq.s	CBE_Die					; MJ: if so, branch
		cmp.b	(BoxWinner).w,d6			; MJ: is player 1 winning?
		beq.s	CBE_NoDie				; MJ: if so, branch

CBE_Die:
		jsr	Kill_Character				; MJ: kill the player

CBE_NoDie:
		addq.b	#$01,d6					; MJ: increase player check ID
		exg.l	a0,a1					; MJ: swap player 1/2
		dbf	d7,CBE_NextPlayer			; MJ: repeat again for player 2
		rts						; MJ: return

CBE_KillBoth:
		tst.b	render_flags(a0)			; MJ: is the player 1 off-screen?
		bmi.s	CBE_Return				; MJ: if not, branch
		tst.b	render_flags(a1)			; MJ: is the player 2 off-screen?
		bmi.s	CBE_Return				; MJ: if not, branch
	cmpi.b	#$01,(BoxWinner).w			; MJ5: is player 1 winning?
	beq.s	CBE_KillNo1				; MJ5: if so, branch
		jsr	Kill_Character				; MJ: kill the player

CBE_KillNo1:
	cmpi.b	#$02,(BoxWinner).w			; MJ5: is player 2 winning?
	beq.s	CBE_Return				; MJ5: if so, branch
		exg.l	a0,a1					; MJ: swap player 1/2
		jsr	Kill_Character				; MJ: kill the player
		exg.l	a0,a1					; MJ: swap player 1/2

CBE_Return:
		rts						; MJ: return
; ===========================================================================

CBE_WaitOnScr:
		subq.b	#1,SpawnWait.w				; sub 1 from the wait
		tst.b	render_flags(a0)			; MJ: is the character off-screen?
		bpl.s	.add					; MJ: if so, branch
		tst.b	render_flags(a1)			; MJ: is the character off-screen?
		bmi.s	.rts					; MJ: if not, branch
.add		addq.b	#1,SpawnWait.w				; add 1 to spawn wait timer
.rts		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control tag battle
; ---------------------------------------------------------------------------

Tag_ChgSFX =	$65						; NAT: SFX to play when changing
Tag_DelFrames =	30						; NAT: Num of frames back the other player spawns
Tag_Time =	49*60						; NAT: Num of frames til a player wins
Tag_Cool =	6						; NAT: small cooldown period so the other player can get away
Tag_RangeX =	$34						; NAT: Range of when you hit the other player horiz
Tag_RangeY =	$46						; NAT: Range of when you hit the other player vert

Control_TagBattle:
	if 0=1
		lea	Player_1.w,a0				; NAT: Load p1 to a0
		lea	Player_2.w,a1				; NAT: Load p2 to a1
		cmp.b	#1,TagWinner.w				; NAT: Check if Tails is winrar
		beq.s	.issonic				; NAT: If not, branch
		exg	a0,a1					; NAT: Swap the players round

.issonic	move.w	x_pos(a1),d1				; NAT: get X distance from player to corner
		sub.w	x_pos(a0),d1				; NAT: ''
		move.w	y_pos(a1),d2				; NAT: get Y distance from player to corner
		sub.w	y_pos(a0),d2				; NAT: ''
		jsr	GetArcTan.w				; NAT: get the angle between the player and the corner first...
		sub.b	#$40,d0					; NAT: Convert angle
		move.b	d0,(BoxAngle).w				; NAT; save the resulting angle

		lea	(Player_1).w,a0				; MJ: load player 1's object RAM to a0
		lea	(Player_2).w,a1				; MJ: load player 2's object RAM to a1
		jsr	CBE_NoDeath(pc)				; NAT: Handle camera
		lea	TagTimer.w,a2				; NAT: Get tag timer to a2
		cmp.b	#2,TagWinner.w				; NAT: Check if Tails is winning
		beq.s	.ttag					; NAT: If so, branch
		addq.w	#2,a2					; NAT: Increase tag ptr to tails
		exg	a0,a1					; NAT: Put Sonic into a1

.ttag		cmp.b	#6,5(a0)				; NAT: Check if other played is dead
		bhs.s	.chk					; NAT: Do not decrement timer
		tst.b	TagCool.w				; NAT: Check if tag cooldown is over
		beq.s	.norm					; NAT: If is, branch

.chk		tst.w	(a2)					; NAT: check the timer
		ble.s	.norm					; NAT: If negative, branch
		bra.s	.cont

.norm		subq.w	#1,(a2)					; NAT: decrement tag timer
.cont		bgt.s	CTBL_NoWin				; NAT: Branch if nobody won yet
		bmi.s	.rts					; NAT: If negative, do not kill the player again.
		jsr	Kill_Character				; NAT: kill the player

		jsr	Create_New_Sprite.w			; NAT: Create new sprite
		bne.s	.oops					; NAT: oops
		move.w	a1,a0					; NAT: Copy ptr
		jmp	Boss_Force_End				; NAT: Force mode

.oops		addq.w	#1,(a2)					; NAT: Increase counter (try again new frame)
.rts		rts

CTBL_NoWin:
		tst.b	TagCool.w				; NAT: Check if tag cooldown is over
		beq.s	.nodec					; NAT: If is, branch
		subq.b	#1,TagCool.w				; NAT: Decrement tag cooldown

	; check collision
.nodec		move.w	x_pos(a0),d0				; NAT: get p1 x-pos
		sub.w	x_pos(a1),d0				; NAT: sub p1 x-pos
		add.w	#Tag_RangeX/2,d0			; NAT: Add range constant
		cmp.w	#Tag_RangeX,d0				; NAT: Check if in range
		bhs.s	CTBL_NoRange				; NAT: If not hit, branch

		move.w	y_pos(a0),d0				; NAT: get p1 y-pos
		sub.w	y_pos(a1),d0				; NAT: sub p1 y-pos
		add.w	#Tag_RangeY/2,d0			; NAT: Add range constant
		cmp.w	#Tag_RangeY,d0				; NAT: Check if in range
		bhs.s	CTBL_NoRange				; NAT: If not hit, branch

		tst.b	TagCool.w				; NAT: Check if tag cooldown is over
		bne.s	.reset					; NAT: If not, branch

.isover		eor.b	#3,TagWinner.w				; NAT: Invert tagger
		moveq	#Tag_ChgSFX,d0				; NAT: Get Blue Sphere sfx
		jsr	Play_Sound.w				; NAT: Play sound
.reset		move.b	#Tag_Cool,TagCool.w			; NAT: reset the cooldown

CTBL_NoRange:
		cmp.b	#6,5(a0)				; NAT: Check if pl is dead
		bhs.s	.tagnokill				; NAT: If is, branch
		tst.b	4(a0)					; NAT: check if is visible
		bmi.s	.tagnokill				; NAT: If so, branch
		sub.w	#3*60,(a2)				; NAT: Decrease tag timer
		bmi.s	.nokill					; NAT: if negative, don't kill player
		jmp	Kill_Character				; NAT: Kill player

.nokill		move.w	#1,(a2)					; NAT: else clear
.tagnokill	rts
	endif

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to move camera (simple, average pos)
; ---------------------------------------------------------------------------

Camera_Simple:
		lea	Player_1.w,a0				; NAT: Load p1 to a0
		lea	Player_2.w,a1				; NAT: Load p2 to a1

		cmpi.b	#$06,routine(a0)			; MJ: is player 1 dead/dying?
		blo.s	.nofol2					; MJ: if not, branch
		cmpi.b	#$06,routine(a1)			; MJ: is player 2 also dead/dying?
		bhs.s	.freeze					; MJ: if so, branch
		move.w	x_pos(a1),(CamFollow_X).w		; NAT: save as camera's position
		move.w	y_pos(a1),(CamFollow_Y).w		; NAT: ''
.freeze		rts						; MJ: return

.nofol2		cmpi.b	#$06,routine(a1)			; MJ: is player 2 dead/dying?
		blo.s	.nofol1					; MJ: if not, branch
		move.w	x_pos(a0),(CamFollow_X).w		; NAT: save as camera's position
		move.w	y_pos(a0),(CamFollow_Y).w		; NAT: ''
		rts						; MJ: return

.nofol1		move.w	x_pos(a0),d1				; MJ3: get X and Y distance between player 1 and 2
		move.w	y_pos(a0),d2				; MJ3: ''
		sub.w	x_pos(a1),d1				; MJ3: ''
		sub.w	y_pos(a1),d2				; MJ3: ''

		move.w	d2,d5					; NAT: copy y-diff
		move.w	Screen_Y_wrap_value.w,d6		; NAT: get y-wrap value
		lsr.w	#1,d6					; NAT: halve it
		add.w	d6,d5					; NAT: add half of y-wrap value to y-diff

		cmp.w	Screen_Y_wrap_value.w,d5		; NAT: check if diff is more or less than half of y-wrap val
		bcs.s	.nofix					; NAT: If not, do not fix val

		move.w	Screen_Y_wrap_value.w,d5		; NAT: Get y-wrap value
		tst.w	d2					; NAT: Check if diff was positive
		bmi.s	.add					; NAT: If wasn't, do not negate value
		neg.w	d5					; NAT: Negate addition
.add		add.w	d5,d2					; NAT: add Y-wrap value

.nofix		asr.w	#$01,d1					; MJ: get position between them
		asr.w	#$01,d2					; MJ: ''
		add.w	x_pos(a1),d1				; MJ: readd player 2's position
		add.w	y_pos(a1),d2				; MJ: ''
		move.w	d1,(CamFollow_X).w			; MJ: save as camera's position
		move.w	d2,(CamFollow_Y).w			; MJ: ''
		rts
