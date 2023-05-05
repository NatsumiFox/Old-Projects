; ===========================================================================
; ---------------------------------------------------------------------------
; Pausing/unpausing loop (Old original version)
; ---------------------------------------------------------------------------

Pause_Game:
Pause_Main:
		tst.b	(Life_count).w
		beq.w	Pause_Unpause
		tst.w	(Game_paused).w
		bne.s	+
		lea	(Ctrl_1_pressed).w,a5
		lea	(Ctrl_2_pressed).w,a4
		tst.b	(a5)			; check if start is pressed for p1
		bmi.s	+			; if is, branch
		tst.b	(a4)			; check if start is pressed for p2
		bpl.w	Pause_NoPause		; if not, branch
+
		cmp.w	#$1601,Current_zone_and_act.w	 ;NAT: Check if hpz
		bne.s	.nothpz			; if not, branch
		cmp.b	#6,playmode.w		; check if this is minigame
		bne.s	.nothpz			; if not, branch
		move.b	#$04,(Game_Mode).w		; set game mode top sega screen
		rts

.nothpz
		move.w	#1,(Game_paused).w
	stopZ80
		move.b	#1,(Z80_RAM+zPauseFlag).l; Pause the music
	startZ80
		move.w	#$2700,sr
		move.w	#$9200,($C00004).l	; MJ: move window off-screen
		jsr	LoadPauseArt(pc)	; MJ: load pause art
		jsr	LoadPauseMaps(pc)	; load pause art and maps
		move.w	#$2300,sr
		clr.w	Pause_Selection.w	; clear selection

Pause_Loop:
		move.b	#$10,(V_int_routine).w
		bsr.w	Wait_VSync

		lea	Pause_Selection.w,a3	; get selection RAM
		lea	Pause_P1Sel(pc),a2	; get selection data
		move.b	(a5),d0			; get p1 pressed buttons
		bsr.w	Pause_DoInput		; do input

		addq.w	#1,a3			; p2 selection
		move.b	(a4),d0			; get p1 pressed buttons
		bsr.w	Pause_DoInput		; do input

		move.b	-1(a3),d0		; get p1 selection
		bpl.s	Pause_Loop		; if not accepted, branch
		cmp.b	(a3),d0			; check if they have same selection (and accepted)
		bne.s	Pause_Loop		; if not, branch

		sub.b	#$81,d0			; check for killing
		bmi.s	Pause_ResumeMusic	; if was 0, unpause
		beq.s	Pause_KillPlayers	; if was selected, branch
		move.b	#$04,(Game_Mode).w	; set game mode back to main menu
		moveq	#0,d0
		jsr	Change_Music_Tempo	; slow music down

Pause_ResumeMusic:
	stopZ80
		move.b	#$80,(Z80_RAM+zPauseFlag).l; Unpause music
	startZ80
		move	#$2700,sr		; disable interrupts
	tst.b	(Debug_mode_flag).w	; MJ: is debug mode enabled?
	beq.s	Pause_NoWindow		; MJ: if not, branch and ignore window
	move.w	#$92FB,($C00004).l	; MJ: allow window to display on-screen
		jsr	LoadDebugArt		; MJ: reload debug number back over the pause menu art


Pause_NoWindow:

	;	move.w	#$2700,sr
		jsr	PauseLoadPlaneA(pc)	; load Plane A data back
		move.w	#$2300,sr

Pause_Unpause:
		move.w	#0,(Game_paused).w

Pause_NoPause:
		rts
; ---------------------------------------------------------------------------

Pause_KillPlayers:
		lea	Player_1.w,a0
		jsr	Kill_Character
		lea	Player_2.w,a0
		jsr	Kill_Character
		bra.s	Pause_ResumeMusic
; ---------------------------------------------------------------------------

Pause_DoInput:
		moveq	#0,d7
		btst	#0,d0			; check if up was pressed
		beq.s	.noup			; if not, branch
		and.b	#$7F,(a3)		; get rid of bit7
		move.b	(a3),d7			; get last selection

		subq.b	#1,(a3)			; move selection
		bpl.s	.selart			; if positive, load art
		move.b	#2,(a3)			; force arrow to proper pos
		bra.s	.selart			; load art

.noup		btst	#1,d0			; check if down was pressed
		beq.s	.nodwn			; if not, branch
		and.b	#$7F,(a3)		; get rid of bit7
		move.b	(a3),d7			; get last selection

		addq.b	#1,(a3)			; move selection
		cmp.b	#3,(a3)			; check if out of range
		blt.s	.selart			; if not, load art
		clr.b	(a3)			; force arrow to proper pos
		bra.s	.selart			; load art

.nodwn		tst.b	d0			; check if start was pressed
		bpl.s	.noabc			; if not, branch
		or.b	#$80,(a3)		; set start as pressed
		bra.s	.selart			; load art

.noabc		move.b	(a3),d7			; get last selection
		bpl.s	.selart			; if not confirmed, iupdate
		add.w	#$A,a2			; skip over P1 data
		rts

.selart		move.w	Camera_X_Pos.w,d6		; get xpos
		add.w	#(320-PauseMapW)/2+8,d6		; ideal offset horizontally
		add.w	(a2)+,d6			; add player offset
		lsr.w	#3,d6				; get the tile offset
		and.w	#$3F,d6				; ''

		move.w	Camera_Y_Pos.w,d5		; get ypos
		add.w	#(224-PauseMapH)/2+8,d5		; ideal offset vertically
		lsr.w	#3,d5				; get the tile offset
		move.w	d5,d0				; copy temporarily
		add.w	d7,d5				; add last cursor pos
		add.w	d7,d5				; ''
		and.w	#$1F,d5				; get tile offset
		move.w	d0,d7				; save old d5 to d7

		lea	(VDP_data_port).l,a6
		jsr	PauseCommVDP(pc)		; get commaaaand
		move.l	d0,4(a6)			; set command
		move.w	(a2)+,(a6)			; write first tile

		addq.w	#1,d5				; add 1 to y-pos
		and.w	#$1F,d5				; keep in range
		jsr	PauseCommVDP(pc)		; get commaaaand
		move.l	d0,4(a6)			; set command
		move.w	(a2)+,(a6)			; write second tile

		moveq	#0,d1
		move.b	(a3),d1				; get cursor pos
		bmi.s	.nodis				; if negative, then always display

		move.b	V_int_run_count+3.w,d0		; get frame
		and.b	#7,d0				; do every 4 frames
		bne.s	.nodis				; if not 0, do not disable
		subq.l	#4,a2				; go back to empty

.nodis		move.w	d7,d5				; copy temporarily
		add.w	d1,d5				; add cursor pos
		add.w	d1,d5				; ''
		and.w	#$1F,d5				; get tile offset

		jsr	PauseCommVDP(pc)		; get commaaaand
		move.l	d0,4(a6)			; set command
		move.w	(a2)+,(a6)			; write first tile

		addq.w	#1,d5				; add 1 to y-pos
		and.w	#$1F,d5				; keep in range
		jsr	PauseCommVDP(pc)		; get commaaaand
		move.l	d0,4(a6)			; set command
		move.w	(a2)+,(a6)			; write second tile

		tst.b	(a3)				; check if selected
		bmi.s	.nodis2				; if so, skip

		move.b	V_int_run_count+3.w,d0		; get frame
		and.b	#7,d0				; do every 4 frames
		bne.s	.nodis2				; if not 0, do not disable
		addq.l	#4,a2				; go back to empty
.nodis2		rts
; ---------------------------------------------------------------------------

Pause_P1Sel:	dc.w 0,  $87DA, $87DB, $87D8, $87D9
		dc.w $48, $87DE, $87DF, $87DC, $87DD

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load Plane A mappings back
; ---------------------------------------------------------------------------

PauseLoadPlaneA:
		move.w	Camera_X_Pos.w,d0		; get xpos
		add.w	#(320-PauseMapW)/2+8,d0		; ideal offset horizontally
		and.w	#$FFF0,d0			; keep in range

		move.w	Camera_Y_Pos.w,d1		; get ypos
		add.w	#(224-PauseMapH)/2+8,d1		; ideal offset vertically
		and.w	#$FFF0,d1			; keep in range

		lea	(Plane_buffer).w,a0
		lea	(Block_table).w,a2
		lea	(Level_layout_main).w,a3
		move.w	#$C000,d7
		move.w	#(PauseMapH/8)-1,d2		; counter

.renderloop	movem.w	d0-d2,-(sp)			; push vars in stack
		moveq	#PauseMapW/8,d6			; write whole column thingie
		jsr	Setup_TileColumnDraw		; draw colunns
		movem.w	(sp)+,d0-d2			; pop vars from stack
		add.w	#16,d0				; next tile
		dbf	d2,.renderloop			; render all rows
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load pause menu mappings
; ---------------------------------------------------------------------------
PauseMapW =	$50
PauseMapH =	$30

PauseCommVDP:
		move.w	d6,d0				; copy x-tile
		add.w	d0,d0				; double horiozontal offset
		move.w	d5,d4				; copy y-tile
		lsl.w	#7,d4				; 64x vertical offset
		add.w	d4,d0				; combine them
		or.w	#$4000,d0			; VRAM WRITE
		swap	d0				; swap words
		move.w	#$0003,d0			; $C000 + VRAM WRITE
		rts
; ---------------------------------------------------------------------------

LoadPauseMaps:
		move.w	Camera_X_Pos.w,d6		; get xpos
		add.w	#(320-PauseMapW)/2+8,d6		; ideal offset horizontally
		lsr.w	#3,d6				; get the tile offset
		and.w	#$3F,d6				; ''

		move.w	Camera_Y_Pos.w,d5		; get ypos
		add.w	#(224-PauseMapH)/2+8,d5		; ideal offset vertically
		lsr.w	#3,d5				; get the tile offset
		and.w	#$1F,d5				; ''

		cmp.w	#$40-(PauseMapW/8),d6		; check if we can do it horizontally
		bls.w	.fullhz				; branch if so
		cmp.w	#$20-(PauseMapH/8),d5		; check if we can do it vertically
		bls.s	.fullvz				; branch if so

		jsr	PauseCommVDP(pc)		; calc VDP command
		moveq	#$40,d1				; max cols
		sub.w	d6,d1				; sub the column we are on
		subq.w	#1,d1				; sub 1 for dbf

		move.w	d5,d7				; copy vertical pos to d7
		moveq	#$20,d2				; max rows
		sub.w	d5,d2				; sub the row we are on
		move.w	d2,d5				; get num of rows to do still
		subq.w	#1,d2				; sub 1 for dbf

		lea	PauseMap(pc),a2
		bsr.s	.docols				; do first part

		moveq	#$40,d1				; max cols
		sub.w	d6,d1				; sub the column we are on
		move.w	d1,-(sp)			; get num of cols to do still
		subq.w	#1,d1				; sub 1 for dbf

		moveq	#(PauseMapH/8)-1,d2		; total num of rows
		sub.w	d5,d2				; sub num of rows written
		moveq	#0,d5				; clear vertical offset
		jsr	PauseCommVDP(pc)		; calc VDP command
		bsr.s	.docols				; do first part

		lea	PauseMap(pc),a2
		move.w	(sp),d0				; get the num of done columns
		add.w	d0,d0				; double
		add.w	d0,a2				; add to map offset

		move.w	d7,d5				; copy back the right pos
		moveq	#0,d6				; clear horizontal offset
		jsr	PauseCommVDP(pc)		; calc VDP command
		moveq	#(PauseMapW/8)-1,d1		; num of cells
		sub.w	(sp),d1				; sub num of rows written

		moveq	#$20,d2				; max rows
		sub.w	d7,d2				; sub the row we are on
		move.w	d2,d7				; get num of rows to do still
		subq.w	#1,d2				; sub 1 for dbf
		bsr.s	.docols				; do first part

		moveq	#(PauseMapW/8)-1,d1		; num of cells
		sub.w	(sp)+,d1			; sub num of rows written
		moveq	#(PauseMapH/8)-1,d2		; total num of rows
		sub.w	d7,d2				; sub num of rows written

		moveq	#0,d6				; clear horizontal offset
		moveq	#0,d5				; clear vertical offset
		jsr	PauseCommVDP(pc)		; calc VDP command
		bra.s	.docols				; do first part
; ---------------------------------------------------------------------------

.fullvz		jsr	PauseCommVDP(pc)		; calc VDP command
		moveq	#$40,d1				; max cols
		sub.w	d6,d1				; sub the column we are on
		move.w	d1,d6				; get num of cols to do still
		subq.w	#1,d1				; sub 1 for dbf
		moveq	#(PauseMapH/8)-1,d2		; total num of rows
		lea	PauseMap(pc),a2
		bsr.s	.docols				; do first part

		moveq	#(PauseMapW/8)-1,d1		; num of cells
		moveq	#(PauseMapH/8)-1,d2		; total num of rows
		sub.w	d6,d1				; sub num of rows written

		lea	PauseMap(pc),a2
		add.w	d6,d6				; double d6
		add.w	d6,a2				; add to the mappings offset
		moveq	#0,d6				; clear horizontal offset
		jsr	PauseCommVDP(pc)		; calc VDP command
; ---------------------------------------------------------------------------

.docols		lea	(VDP_data_port).l,a6
		move.l	#$800000,d4			; row increment value

.rowloop	move.l	d0,VDP_control_port-VDP_data_port(a6)
		move.w	d1,d3
		lea	(a2),a1				; copy to a1

.colloop	move.w	(a1)+,(a6)
		dbf	d3,.colloop			; copy one row

		add.l	d4,d0				; move onto next row
		add.w	#(PauseMapW/8)*2,a2		; increment mappings ptr
		dbf	d2,.rowloop			; and copy it
		rts
; ---------------------------------------------------------------------------

.fullhz		cmp.w	#$20-(PauseMapH/8),d5		; check if we can do it vertically
		bls.s	.fullvzhz			; branch if so
		jsr	PauseCommVDP(pc)		; calc VDP command
		moveq	#(PauseMapW/8)-1,d1		; num of cells

		moveq	#$20,d2				; max rows
		sub.w	d5,d2				; sub the row we are on
		move.w	d2,d5				; get num of rows to do still
		subq.w	#1,d2				; sub 1 for dbf
		lea	PauseMap(pc),a1			; mappings
		bsr.s	Plane_Map_To_VRAM		; write map

		moveq	#(PauseMapW/8)-1,d1		; num of cells
		moveq	#(PauseMapH/8)-1,d2		; total num of rows
		sub.w	d5,d2				; sub num of rows written

		moveq	#0,d5				; clear vertical offset
		jsr	PauseCommVDP(pc)		; calc VDP command
		bra.s	Plane_Map_To_VRAM		; write map
; ---------------------------------------------------------------------------

.fullvzhz	jsr	PauseCommVDP(pc)		; calc VDP command
		moveq	#(PauseMapW/8)-1,d1		; num of cells
		moveq	#(PauseMapH/8)-1,d2		; num of rows
		lea	PauseMap(pc),a1			; mappings
		bra.s	Plane_Map_To_VRAM		; write map

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load pause menu art
; ---------------------------------------------------------------------------

LoadPauseArt:
		lea	PauseArt,a0			; pause menu art stuff
		move.w	(a0)+,d3			; get size
		move.w	(a0)+,d2			; destination VRAM
		move.l	a0,d1				; set source addr

		add.w	d3,a0				; align a0 for next write
		add.w	d3,a0				; ''
		bsr.s	Add_To_DMA_Queue		; DMA art

		move.w	(a0)+,d3			; get size
		move.w	(a0)+,d2			; destination VRAM
		move.l	a0,d1				; set source addr
		bra.s	Add_To_DMA_Queue		; DMA art

; ===========================================================================
