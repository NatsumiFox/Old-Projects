; ===========================================================================
; ---------------------------------------------------------------------------
; Swap effect - Level Fall
; ---------------------------------------------------------------------------
MMWL_Terminal =		$C0000		; terminal velocity
MMWL_Gravity =		$3000		; added each frame to speed
MMWL_Floor =		$E00000		; floor position
MMWL_Clip =		-$10000		; the amount of speed after bounce, to stop the effect
; ---------------------------------------------------------------------------

MMW_LevelFall:
		move.l	#MMWL_Fall,EMM_SwapRout		; set next routine
		clr.l	(a3)				; clear velocity
		clr.l	4(a3)				; set at the top of the screen
; ---------------------------------------------------------------------------

MMWL_Fall:
		move.w	(EMM_ScrollSlot).l,d0			; load scroll slot
		swap	d0					; ''
		move.w	(EMM_ScrollSlot).l,d0			; ''
		jsr	BP_SetPlane(pc)				; set the entire plane to this position
		addi.l	#$01000100,d0				; set to other plane

		move.l	(a3),d1					; get velocity to d1
		add.l	#MMWL_Gravity,(a3)			; add gravity to velocity
		cmp.l	#MMWL_Terminal,(a3)			; check for terminal velocity
		ble.s	.nocap					; branch if not hit yet
		move.l	#MMWL_Terminal,(a3)			; set to terminal velocity

.nocap		move.w	4(a3),d2				; load position to d2
		add.l	d1,4(a3)				; add velocity to position
		cmp.l	#MMWL_Floor,4(a3)			; check if we hit the floor
		bls.s	.nofloor				; branch if not

		move.l	(a3),d1					; get the speed again
		asr.l	#1,d1					; halve it
		neg.l	d1					; and negate it
		move.l	d1,(a3)					; save as speed
		move.l	#MMWL_Floor,4(a3)			; make sure we bounce correctly

		cmp.l	#MMWL_Clip,d1				; check if this is low enough speed to just clip
		ble.s	.nofloor				; if not, branch instead
		move.l	#MMWL_End,EMM_SwapRout			; end the effect the next frame

.nofloor	subq.w	#1,d2					; sub for dbf
		bmi.s	.rts					; if negative, branch
		lea	(EMM_VScroll).l,a0			; load V-scroll RAM

		move.w	#$E0-1,d3				; load max scans to d3
		sub.w	d2,d3					; sub real scan from d3
		add.w	d3,d0					; add to vertical pos
		swap	d0					; and BG
		add.w	d3,d0					;
		swap 	d0					; get FG back

.fill		move.l	d0,(a0)+				; fill plane
		dbf	d2,.fill				; loop for all lines
.rts		rts
; ---------------------------------------------------------------------------

MMWL_End:
		move.w	(EMM_ScrollSlot).l,d0			; load scroll slot
		swap	d0					; ''
		move.w	(EMM_ScrollSlot).l,d0			; ''
		addi.l	#$01000100,d0				; set to other plane
		jsr	BP_SetPlane(pc)				; set the entire plane to this position

		clr.l	EMM_SwapRout				; finish swap routine
		clr.b	EMM_RunEffect				; set effect as NOT running
		rts
; ---------------------------------------------------------------------------
