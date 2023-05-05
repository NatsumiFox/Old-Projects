; ===========================================================================
; ---------------------------------------------------------------------------
; Swap Effect - Bars wipe the screen to a new plane
; ---------------------------------------------------------------------------
MMWBS_BarSize = $14
MMWBS_BarSpeed = 4
MMWBS_WaitTimer = 10
; ---------------------------------------------------------------------------

MMW_BarSwipe:
		move.l	#MMWBS_MoveIn,(EMM_SwapRout).l		; set next routine
		move.l	#$91959200,(a3)+			; set starting bar position (outside screen on right)
		move.w	#((224/2)-MMWBS_BarSize)*4,(a3)+	; set first bar position
		move.w	#-($08*4),(a3)+				; set second bar position (distance from first bar)
		move.b	#MMWBS_WaitTimer-1,(a3)+		; set delay timer
		rts						; return

	; --- Moving the bars onto screen ---

MMWBS_MoveIn:
		subq.b	#$01,$01(a3)				; decrease window's X position into screen
		bmi.s	MMWBS_NoStop				; if it's not passed full screen yet, branch
		move.w	#$9180,(a3)				; keep position at full screen
		move.l	#MMWBS_Delay,(EMM_SwapRout).l		; set next routine

MMWBS_NoStop:
		move.l	(a3)+,d0				; load bar position
		movea.l	(EMM_WindowSlot).l,a1			; load window buffer
		adda.w	(a3)+,a1				; advance to correct position
		moveq	#(((MMWBS_BarSize)/4)*2)-1,d1		; prepare size of both bars

MMWMI_Draw:
		move.l	d0,(a1)+				; set window to display
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		dbf	d1,MMWMI_Draw				; repeat for both bars
		rts						; return

	; --- Delaying for a while ---

MMWBS_Delay:
		subq.b	#$01,$08(a3)				; decrease delay timer
		bpl.s	MMWBD_Wait				; if still running, branch
		move.l	#MMWBS_SwipeOut,(EMM_SwapRout).l	; set next routine

MMWBD_Wait:
		rts						; return

	; --- Swiping the bars outwards ---

MMWBS_SwipeOut:
		lea	(EMM_VScroll).l,a0			; load V-scroll RAM
		move.w	(EMM_ScrollSlot).l,d3			; get scroll slot
		addi.w	#$0100,d3				; advance to next slot
		move.w	d3,d0					; get it in both words of d3
		swap	d3					; ''
		move.w	d0,d3					; ''
		move.l	(a3)+,d0				; load window positions
		move.l	#$91009200,d1				; prepare blank window registers
		movea.l	(EMM_WindowSlot).l,a1			; load window buffer
		subi.w	#(MMWBS_BarSpeed*4),(a3)		; move first bar upwards
		cmpi.w	#-((MMWBS_BarSize+$08)*4),(a3)		; have the bars slided out enough (for double buffering too)
		bgt.s	MMWBO_NoStop				; if not, branch
		moveq	#$00,d4					; clear d4
		move.l	d4,(EMM_SwapRout).l			; finish swap routine
		move.b	d4,(EMM_RunEffect).l			; set effect as NOT running

MMWBO_NoStop:
		adda.w	(a3),a1					; advance to correct window position
		adda.w	(a3)+,a0				; advance to correct V-scroll position
		moveq	#((MMWBS_BarSize)/4)-1,d2		; prepare size of bar

MMWSO_DrawTop:
		move.l	d0,(a1)+				; set window to display
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		dbf	d2,MMWSO_DrawTop			; repeat for both bars
		lea	(a1),a2					; copy end address
		lea	MMWBS_BarSize*4(a0),a0			; skip V-scroll over to the end of the bar

	; Note: $08 is required to clear due to double buffering of the window

	rept	$08
		move.l	d3,(a0)+				; write V-scroll position (draw the slot in)
		move.l	d1,(a2)+				; clear the window
	endm
		addi.w	#(MMWBS_BarSpeed*4)*2,(a3)		; move second bar downwards
		adda.w	(a3),a1					; advance to correct window position
		adda.w	(a3)+,a0				; advance to correct V-scroll position
	rept	$08
		move.l	d3,(a0)+				; write V-scroll position (draw the slot in)
		move.l	d1,(a1)+				; clear the window
	endm
		moveq	#((MMWBS_BarSize)/4)-1,d2		; prepare size of bar

MMWSO_DrawBottom:
		move.l	d0,(a1)+				; set window to display
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		dbf	d2,MMWSO_DrawBottom			; repeat for both bars
		rts						; return

; ===========================================================================