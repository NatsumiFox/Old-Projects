; ===========================================================================
; ---------------------------------------------------------------------------
; Palette Cycling - Mushroom Hill Zone Act 2
; ---------------------------------------------------------------------------

		subq.w	#$01,(a2)				; decrease first delay timer
		bpl.s	.rts					; if still running, branch

		moveq	#$00,d0					; clear d0
		move.b	$02(a2),d0				; load palette entry position
		addq.b	#2,$02(a2)				; increase for next time
		cmp.b	#2*12,$02(a2)				; check if needs wrapping
		blo.s	.nowrap					; if not, branch
		clr.b	$02(a2)					; reset position

.nowrap		move.w	.paldel(pc,d0.w),(a2)			; load delay
		add.w	d0,d0					; double offset
		move.l	.palctc(pc,d0.w),a0			; load palette pointer data
		lea	$22(a1),a1				; load start of colours to a1

	rept $B
		move.w	(a0)+,(a1)+				; load colors
	endm
		st.b	(EMM_UpdatePal).l			; set to update the palette
.rts		rts						; return

.paldel		dc.w 238, 6, 6, 6, 238, 6, 6, 6, 238, 6, 6, 6
.palctc		dc.l Pal_MHZ02+$0A, .norfal1, .norfal2, .norfal3
		dc.l .fallpal, .falwin1, .falwin2, .falwin3
		dc.l .winterpal, .winnor1, .winnor2, .winnor3
; ===========================================================================

;.normalpal	dc.w $040, $080, $2C0, $6E6, $026, $00A, $04E, $08E, $0EE, $020, $06C
.norfal1	dc.w $042, $062, $2C4, $4E8, $026, $008, $44A, $48C, $2EE, $020, $06C
.norfal2	dc.w $022, $064, $2A8, $4C8, $026, $224, $866, $6A8, $2CC, $022, $08C
.norfal3	dc.w $024, $046, $2AC, $4CA, $026, $242, $C64, $AA6, $4CA, $022, $08E

.fallpal	dc.w $026, $048, $28E, $0CC, $026, $442, $E60, $CA4, $6CC, $022, $08E
.falwin1	dc.w $024, $046, $28C, $0AC, $026, $242, $C60, $8A4, $6CA, $022, $08E
.falwin2	dc.w $024, $246, $2AC, $0AC, $026, $242, $880, $6C4, $6CA, $022, $08E
.falwin3	dc.w $044, $266, $4AC, $2AC, $026, $240, $480, $4C4, $6C8, $022, $08E

.winterpal	dc.w $244, $466, $4AA, $4AC, $026, $220, $280, $0C4, $8C8, $022, $08E
.winnor1	dc.w $244, $464, $4A8, $4AA, $026, $200, $264, $0A8, $6CA, $022, $08C
.winnor2	dc.w $042, $482, $2C4, $6CA, $026, $004, $068, $0AA, $4EA, $020, $08C
.winnor3	dc.w $040, $282, $2C0, $6C8, $026, $008, $04C, $08C, $2EC, $020, $06C
