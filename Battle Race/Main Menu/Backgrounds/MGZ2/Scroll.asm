; ===========================================================================
; ---------------------------------------------------------------------------
; Scroll Data - Marble Garden 2
; ---------------------------------------------------------------------------

		move.b	(EMM_SlotID).l,d0			; load display slot
		andi.b	#$01,d0					; get only single bit
		move.b	(EMM_ScrollSlot).l,d1			; load current scroll slot
		eor.b	d1,d0					; switch with scroll slot
		beq.w	SEMGZ02_NoRumble			; if this slot is not displaying, branch

		lea	(EMM_PosY_FG1).l,a0			; load slot 1 Y positions
		lea	(EMM_PosY_BG1).l,a3			; ''
		btst.b	#$00,(EMM_ScrollSlot).l			; are we in slot 1?
		bne.s	SEMGZ02_Slot1				; if so, branch
		lea	(EMM_PosY_FG2).l,a0			; load slot 2 Y positions
		lea	(EMM_PosY_BG2).l,a3			; ''

SEMGZ02_Slot1:
		clr.w	(a0)					; reset Y positions
		clr.w	(a3)					; ''

		subq.w	#$01,(a2)				; decrease timer
		bpl.s	SEMGZ02_NoRumbleTime			; if still running, branch
		move.w	#$0140,(a2)				; reset timer

SEMGZ02_NoRumbleTime:
		move.w	(a2),d0					; load timer
		subi.w	#$0080,d0				; minus end time
		cmpi.w	#$0080,d0				; are we between 0080 and 0100 for rumbling?
		bhi.s	SEMGZ02_NoRumble			; if not rumbling, branch
		move.w	d0,d1					; copy to d1
		andi.w	#$001F,d0				; get within 20 frames
		move.b	SEMGZ02_Rumble(pc,d0.w),d0		; load correct position
		move.w	d0,(a0)					; save as Y scroll position
		move.w	d0,(a3)					; ''

		andi.b	#$0F,d1					; is it time to play an SFX?
		bne.s	SEMGZ02_NoRumble			; if not, branch
		moveq	#$6F,d0					; play rumble sound
		jsr	Play_Sound_2.w				; ''
		bra.s	SEMGZ02_NoRumble			; continue

SEMGZ02_Rumble:	dc.b	$01,$02,$01,$02,$00,$00,$02,$00,$03,$02,$02,$03,$02,$02,$01,$03
		dc.b	$00,$00,$01,$00,$01,$03,$01,$02,$01,$03,$01,$02,$02,$01,$02,$03
		even

SEMGZ02_NoRumble:

	; Doing equates, because AS doesn't like these prefixed
	; before the "(a0)".  Stupid piece of shit...

SEMEGZ02_EQU1	=	(((($1000-$0500)/$40)*4)+$00)
SEMEGZ02_EQU2	=	(((($1000-$0600)/$40)*4)+$00)
SEMEGZ02_EQU3	=	(((($1000-$0700)/$40)*4)+$00)
SEMEGZ02_EQU4	=	(((($1000-$0800)/$40)*4)+$00)

		lea	(EMM_ScrollSpeed).l,a0			; load scroll speed list
		move.w	(a0),d0					; load FG position
		swap	d0					; send to upper word
		move.w	SEMEGZ02_EQU1(a0),d0			; load BG position
		jsr	(WriteScroll-($08*2))			; write it
		move.w	SEMEGZ02_EQU2(a0),d0			; load next BG position
		jsr	(WriteScroll-($08*2))			; write it
		move.w	SEMEGZ02_EQU3(a0),d0			; load next BG position
		jsr	(WriteScroll-($18*2))			; write it
		move.w	SEMEGZ02_EQU4(a0),d0			; load main last bottom BG position for writing...
		jmp	(WriteScroll-($D8*2))

; ===========================================================================
