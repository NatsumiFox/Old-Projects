; ===========================================================================
; ---------------------------------------------------------------------------
; Screen Events
; ---------------------------------------------------------------------------

OAZ1_ScreenInit:
		clr.w	(ScrEvents_D).w
		jsr	Reset_TileOffsetPositionActual
		jmp	Refresh_PlaneFull

OAZ1_ScreenEvent:
		lea	(Camera_X_pos_copy).w,a6		; load X position RAM data
		lea	(Camera_X_pos_rounded).w,a5		; load X XOR RAM data (previous position)
		move.w	(Camera_Y_pos_copy).w,d1		; load Y position
		moveq	#$10-1,d6				; set normal number of blocks to draw in a column

		move.w	d1,d0					; load Y position to d0
		subi.w	#OAZ1_FloorPos,d0			; minus floor start position
		bmi.s	OAZ1_SE_DrawSide			; if the screen isn't that low, branch
		lsr.w	#$04,d0					; divide by 10 (size of block)
		sub.w	d0,d6					; minus Y size of column
		subq.w	#$01,d6					; minus 1 probably a dbf thing...
		ble.s	OAZ1_SE_NoSide				; if there are not columns to render, branch

OAZ1_SE_DrawSide:
		jsr	Draw_TileColumn				; draw the left/right column of blocks

OAZ1_SE_NoSide:

		lea	(Camera_Y_pos_copy).w,a6		; load Y position RAM data
		lea	(Camera_Y_pos_rounded).w,a5		; load Y XOR RAM data (previous position)
		move.w	(Camera_X_pos_copy).w,d1		; load X position
		moveq	#$16-1,d6				; set normal number of blocks to draw in a row
		move.w	(a6),d0					; load Y position
		cmpi.w	#OAZ1_FloorPos,d0			; has the screen reached the bottom floor area?
		blt.s	OAZ1_SE_NoFloor				; if not, branch
		cmpi.w	#OAZ1_FloorPos+224,d0			; is the screen low enough for the bricks to be rendered above?
		bge.s	OAZ1_SE_Floor				; if so, branch (allow the bricks to render fully the same as going down)
		cmp.w	(a5),d0					; is the screen moving down?
		bmi.s	OAZ1_SE_NoFloor				; if moving upwards instead, branch

OAZ1_SE_Floor:
		moveq	#$21-1,d6				; set mazimum number of blocks to draw in a row
		moveq	#$00,d1					; set to render at X position 0

OAZ1_SE_NoFloor:
		jmp	Draw_TileRow				; draw the top/bottom row of blocks

; ===========================================================================
