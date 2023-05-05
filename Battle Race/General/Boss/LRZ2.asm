
Obj_LRZ_EndBoss:
		lea	.screen(pc),a1
		jsr	Check_CameraInRange
;		btst	#5,OptionsBits.w		; NAT: Check if bosses are on
;		bne.s	.enabled			; if are, branch
		jmp	Boss_Force_End_2		;

; ---------------------------------------------------------------------------
.screen		dc.w $000, $260, $3800, $3A00
		dc.w $3800, $3800, $180, $180
; ---------------------------------------------------------------------------

.enabled
