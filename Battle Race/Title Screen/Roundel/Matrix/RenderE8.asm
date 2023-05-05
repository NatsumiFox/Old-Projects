; ===========================================================================
; ---------------------------------------------------------------------------
; Roundel rendering matrix (for angle E8)
; ---------------------------------------------------------------------------

RenderE8:	dc.l	SwitchBuffer
		dc.l	AngleE8_0
		dc.l	AngleE8_1
		dc.l	AngleE8_2
		dc.l	AngleE8_3
		dc.l	AngleE8_4
		dc.l	AngleE8_5
		dc.l	AngleE8_6
		dc.l	AngleE8_7
		dc.l	AngleE8_8
		dc.l	AngleE8_9
		dc.l	FinishBuffer

	; --- Render 0 ---

AngleE8_0:
		lea	-$2D08(a2),a0
		bsr.w	(VStreamE8-($50*(4*4)))-2
		lea	-$2FC6(a2),a0
		bsr.w	(VStreamE8-($70*(4*4)))-2
		lea	-$3195(a2),a0
		bra.w	(VStreamE8-($90*(4*4)))-2

	; --- Render 1 ---

AngleE8_1:
		lea	-$2FAA(a2),a0
		bsr.w	(VStreamE8-($A0*(4*4)))-2
		lea	-$2DBE(a2),a0
		bsr.w	(VStreamE8-($B0*(4*4)))-2
		lea	-$2AE3(a2),a0
		bra.w	(VStreamE8-($C0*(4*4)))-2

	; --- Render 2 ---

AngleE8_2:
		lea	-$253F(a2),a0
		bsr.w	(VStreamE8-($C0*(4*4)))-2
		lea	-$2354(a2),a0
		bsr.w	(VStreamE8-($D0*(4*4)))-2
		lea	-$1CBF(a2),a0
		bra.w	(VStreamE8-($D0*(4*4)))-2

	; --- Render 3 ---

AngleE8_3:
		lea	-$1AD4(a2),a0
		bsr.w	(VStreamE8-($E0*(4*4)))-2
		lea	-$1440(a2),a0
		bsr.w	(VStreamE8-($E0*(4*4)))-2
		lea	-$0DAB(a2),a0
		bra.w	(VStreamE8-($E0*(4*4)))-2

	; --- Render 4 ---

AngleE8_4:
		lea	-$0807(a2),a0
		bsr.w	(VStreamE8-($E0*(4*4)))-2
		lea	-$0172(a2),a0
		bsr.w	(VStreamE8-($E0*(4*4)))-2
		lea	$0522(a2),a0
		bra.w	(VStreamE8-($E0*(4*4)))-2

	; --- Render 5 ---

AngleE8_5:
		lea	$0AC6(a2),a0
		bsr.w	(VStreamE8-($E0*(4*4)))-2
		lea	$115B(a2),a0
		bsr.w	(VStreamE8-($E0*(4*4)))-2
		lea	$17EF(a2),a0
		bra.w	(VStreamE8-($E0*(4*4)))-2

	; --- Render 6 ---

AngleE8_6:
		lea	$1D94(a2),a0
		bsr.w	(VStreamE8-($E0*(4*4)))-2
		lea	$27E2(a2),a0
		bsr.w	(VStreamE8-($D0*(4*4)))-2
		lea	$2E76(a2),a0
		bra.w	(VStreamE8-($D0*(4*4)))-2

	; --- Render 7 ---

AngleE8_7:
		lea	$38C4(a2),a0
		bsr.w	(VStreamE8-($C0*(4*4)))-2
		lea	$3F58(a2),a0
		bsr.w	(VStreamE8-($C0*(4*4)))-2
		lea	$49A6(a2),a0
		bra.w	(VStreamE8-($B0*(4*4)))-2

	; --- Render 8 ---

AngleE8_8:
		lea	$53F4(a2),a0
		bsr.w	(VStreamE8-($A0*(4*4)))-2
		lea	$5E42(a2),a0
		bsr.w	(VStreamE8-($90*(4*4)))-2
		lea	$6D39(a2),a0
		bra.w	(VStreamE8-($70*(4*4)))-2

	; --- Render 9 ---

AngleE8_9:
		lea	$7B40(a2),a0
		bra.w	(VStreamE8-($50*(4*4)))-2

	; --- Render V-stream code ---

		binclude "Title Screen\Roundel\Matrix\VStreamE8.bin"
VStreamE8:

; ===========================================================================