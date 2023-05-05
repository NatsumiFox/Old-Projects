; ===========================================================================
; ---------------------------------------------------------------------------
; Deform scanlines correctly using a list
; ---------------------------------------------------------------------------

DeformScroll:
		lea	(H_scroll_buffer).w,a2			; load H-scroll buffer
		move.w	(Camera_Y_pos_BG_copy).w,d6		; load Y position
		move.l	(Camera_X_pos_copy).w,d1		; prepare FG X position
		neg.l	d1					; reverse position
		moveq	#-$01,d0				; prepare d0 as RAM address

DS_FindStart:
		move.w	(a0)+,d0				; load scroll speed address
		beq.s	DS_Last					; if the list is finished, branch
		movea.l	d0,a1					; set scroll speed address
		sub.w	(a0)+,d6				; subtract size
		bpl.s	DS_FindStart				; if we haven't reached the start, branch
		neg.w	d6					; get remaining size
		sub.w	d6,d7					; subtract from total screen size
		bmi.s	DS_EndSection				; if the screen is finished, branch

DS_NextSection:
		subq.w	#$01,d6					; convert for dbf
		move.w	(a1),d1					; load X position

DS_NextScanline:
		move.l	d1,(a2)+				; save scroll position
		dbf	d6,DS_NextScanline			; repeat for all scanlines
		move.w	(a0)+,d0				; load scroll speed address
		beq.s	DS_Last					; if the list is finished, branch
		movea.l	d0,a1					; set scroll speed address
		move.w	(a0)+,d6				; load size

DS_CheckSection:
		sub.w	d6,d7					; subtract from total screen size
		bpl.s	DS_NextSection				; if the screen is not finished, branch

DS_EndSection:
		add.w	d6,d7					; get remaining screen size and use that instead

DS_Last:
		subq.w	#$01,d7					; convert for dbf
		bmi.s	DS_Finish				; if finished, branch
		move.w	(a1),d1					; load X position

DS_LastScanlines:
		move.l	d1,(a2)+				; save scroll position
		dbf	d7,DS_LastScanlines			; repeat for all scanlines

DS_Finish:
		rts						; return

; ===========================================================================