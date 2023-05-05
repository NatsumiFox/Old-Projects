; ===========================================================================
; ---------------------------------------------------------------------------
; Swap effect - Box scaling
; ---------------------------------------------------------------------------

MMW_BoxScale:
		move.l	#MMWBS_ScaleIn,(EMM_SwapRout).l		; set next routine
		moveq	#$00,d0					; clear d0
		move.w	d0,(a3)+				; reset normal position
		move.w	#$F480,(a3)+				; reset reverse position
		move.w	d0,(a3)+				; clear odd/even frame flag
		move.w	#-(($10/2)*4),(a3)+			; reset top/bottom sizes
		move.b	d0,(a3)+				; reset direction flag

MMWBSI_NoStop:
		rts						; return

	; --- Scaling the box into screen ---

MMWBS_ScaleIn:
		moveq	#-$80,d4				; set direction to move the box at
		bsr.s	MMWBS_Scale				; perform the scaline operation
		ble.s	MMWBSI_NoStop				; if the scaline isn't finished, branch

	; --- Swapping the V-scroll slot background ---

		lea	(EMM_VScroll).l,a0			; load V-scroll RAM
		move.w	(EMM_ScrollSlot).l,d0			; load scroll slot we're using
		addi.w	#$0100,d0				; advance to next slot
		move.w	d0,d1					; put in both words of the register
		swap	d0					; ''
		move.w	d1,d0					; ''
		moveq	#($E0/04)-1,d1				; set number of scanlines to swap

MMWSW_NextSlot:
		move.l	d0,(a0)+				; fill entire V-scroll with next slot
		move.l	d0,(a0)+				; ''
		move.l	d0,(a0)+				; ''
		move.l	d0,(a0)+				; ''
		dbf	d1,MMWSW_NextSlot			; repeat for all scanlines
		move.l	#MMWBS_ScaleOut,(EMM_SwapRout).l	; set next routine
		rts						; return

	; --- Scaling the box out of the screen ---

MMWBS_ScaleOut:
		move.w	#$0080,d4				; set direction to move the box at
		bsr.s	MMWBS_Scale				; perform the scaline operation
		ble.s	MMWBSO_NoStop				; if the scaline isn't finished, branch
		move.l	#MMWBS_ResetWindow,(EMM_SwapRout).l	; set next swap routine

MMWBSO_NoStop:
		rts						; return

	; --- Resetting the window buffers (Clearing them) --

MMWBS_ResetWindow:
		movea.l	(EMM_WindowSlot).l,a3			; load window buffer
		movea.l	(EMM_WindowPrev).l,a2			; load other window buffer
		moveq	#($E0/$04)-1,d2				; set number of scanlines to copy
		move.l	#$91009200,d0				; prepare window registers

MMWBS_ClearNext:
		move.l	d0,(a2)+				; clear both buffers
		move.l	d0,(a2)+				; ''
		move.l	d0,(a2)+				; ''
		move.l	d0,(a2)+				; ''
		move.l	d0,(a3)+				; ''
		move.l	d0,(a3)+				; ''
		move.l	d0,(a3)+				; ''
		move.l	d0,(a3)+				; ''
		dbf	d2,MMWBS_ClearNext			; repeat til done

		moveq	#$00,d0					; clear d0
		move.l	d0,(EMM_SwapRout).l			; finish swap routine
		move.b	d0,(EMM_RunEffect).l			; set effect as NOT running
		rts						; return

; ---------------------------------------------------------------------------
; Subroutine to perform the box scaling correctly
; ---------------------------------------------------------------------------

MMWBS_Scale:
		movea.l	(EMM_WindowSlot).l,a1			; load window
		move.l	#$92009100,d0				; prepare registers
		move.l	#$92009114,d2				; ''
		move.l	d0,d1					; ''
		move.l	d0,d3					; ''
		move.b	(a3),d1					; load normal position
		sub.w	d4,(a3)+				; increase first position
		move.b	(a3),d0					; load reverse position
		add.w	d4,(a3)+				; decrease second position
		not.w	(a3)+					; change odd/even frame flag
		beq.s	MMWSC_NoSwap				; if we're on an even frame, branch
		exg.l	d0,d1					; swap middle positions
		exg.l	d2,d3					; swap top/bottom positions
		tst.b	$02(a3)					; are we meant to be going backwards now?
		bne.s	MMWSC_Reverse				; if so, branch
		addq.w	#($0010/2),(a3)				; increase top/bottom sizes
		cmpi.w	#($0010/2)*8,(a3)			; have the top/bottom sizes reached together?
		blt.s	MMWSC_NoSwap				; if not, branch
		st.b	$02(a3)					; set flag to go backwards now
		subq.w	#($0010/2),(a3)				; revert last increase

MMWSC_Reverse:
		subq.w	#($0010/2),(a3)				; decrease top/bottom sizes
		cmpi.w	#-(($10/2)*4),(a3)			; have the edges moved back out fully again?
		bne.s	MMWSC_NoSwap				; if not, branch
		addq.w	#($0010/2),(a3)				; revert last decrease
		move.w	d4,d0					; multiply by 3 (this is to revert the last inc/dec, and to perform
		add.w	d4,d4					; '' ..another inc/dec in opposite direction, and to add an extra..
		add.w	d0,d4					; '' ..00.80 to it to keep the odd/even frame in sync with top/bottom)
		add.w	d4,-$06(a3)				; move positions back
		sub.w	d4,-$04(a3)				; ''
		sf.b	$02(a3)					; clear reverse flag
		moveq	#$01,d0					; set non-zero/positive flags
		rts						; return

MMWSC_NoSwap:
		moveq	#($E0/2),d5				; prepare total middle lines to render
		move.w	(a3),d4					; load number of edge scanlines
		ble.s	MMWSC_NoTop				; if there's none to render, branch
		sub.w	d4,d5					; adjust middle section
		sub.w	d4,d5					; '' (twice for bottom edge)

MMWSC_NextTop:
		move.l	d2,(a1)+				; write scanlines
		move.l	d3,(a1)+				; ''
		dbf	d4,MMWSC_NextTop			; repeat for all middle sections

MMWSC_NoTop:
		subq.w	#$01,d5					; minus 1 for dbf
		bmi.s	MMWSC_NoMid				; if there are no lines to write, branch

MMWSC_NextMid:
		move.l	d0,(a1)+				; write scanlines
		move.l	d1,(a1)+				; ''
		dbf	d5,MMWSC_NextMid			; repeat for all middle sections

MMWSC_NoMid:
		move.w	(a3),d4					; load number of edge scanlines
		ble.s	MMWSC_NoBottom				; if there's none to render, branch

MMWSC_NextBottom:
		move.l	d2,(a1)+				; write scanlines
		move.l	d3,(a1)+				; ''
		dbf	d4,MMWSC_NextBottom			; repeat for all middle sections

MMWSC_NoBottom:
		rts						; return

; ===========================================================================