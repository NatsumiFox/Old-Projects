; ===========================================================================
; ---------------------------------------------------------------------------
; Roundel rendering matrix (for angle F0)
; ---------------------------------------------------------------------------

RenderF0:	dc.l	SwitchBuffer
		dc.l	AngleF0_0
		dc.l	AngleF0_1
		dc.l	AngleF0_2
		dc.l	AngleF0_3
		dc.l	AngleF0_4
		dc.l	AngleF0_5
		dc.l	AngleF0_6
		dc.l	AngleF0_7
		dc.l	AngleF0_8
		dc.l	AngleF0_9
		dc.l	FinishBuffer

	; --- Render 0 ---

AngleF0_0:
		lea	-$446D(a2),a0
		bsr.w	(VStreamF0-($50*(4*4)))-2
		lea	-$427B(a2),a0
		bsr.w	(VStreamF0-($70*(4*4)))-2
		lea	-$4179(a2),a0
		bra.w	(VStreamF0-($90*(4*4)))-2

	; --- Render 1 ---

AngleF0_1:
		lea	-$3DAE(a2),a0
		bsr.w	(VStreamF0-($A0*(4*4)))-2
		lea	-$38F4(a2),a0
		bsr.w	(VStreamF0-($B0*(4*4)))-2
		lea	-$3529(a2),a0
		bra.w	(VStreamF0-($C0*(4*4)))-2

	; --- Render 2 ---

AngleF0_2:
		lea	-$2E96(a2),a0
		bsr.w	(VStreamF0-($C0*(4*4)))-2
		lea	-$29DC(a2),a0
		bsr.w	(VStreamF0-($D0*(4*4)))-2
		lea	-$2349(a2),a0
		bra.w	(VStreamF0-($D0*(4*4)))-2

	; --- Render 3 ---

AngleF0_3:
		lea	-$1F7E(a2),a0
		bsr.w	(VStreamF0-($E0*(4*4)))-2
		lea	-$17FB(a2),a0
		bsr.w	(VStreamF0-($E0*(4*4)))-2
		lea	-$1168(a2),a0
		bra.w	(VStreamF0-($E0*(4*4)))-2

	; --- Render 4 ---

AngleF0_4:
		lea	-$09E5(a2),a0
		bsr.w	(VStreamF0-($E0*(4*4)))-2
		lea	-$0352(a2),a0
		bsr.w	(VStreamF0-($E0*(4*4)))-2
		lea	$0341(a2),a0
		bra.w	(VStreamF0-($E0*(4*4)))-2

	; --- Render 5 ---

AngleF0_5:
		lea	$0AC4(a2),a0
		bsr.w	(VStreamF0-($E0*(4*4)))-2
		lea	$1157(a2),a0
		bsr.w	(VStreamF0-($E0*(4*4)))-2
		lea	$18DA(a2),a0
		bra.w	(VStreamF0-($E0*(4*4)))-2

	; --- Render 6 ---

AngleF0_6:
		lea	$1F6D(a2),a0
		bsr.w	(VStreamF0-($E0*(4*4)))-2
		lea	$28C9(a2),a0
		bsr.w	(VStreamF0-($D0*(4*4)))-2
		lea	$304C(a2),a0
		bra.w	(VStreamF0-($D0*(4*4)))-2

	; --- Render 7 ---

AngleF0_7:
		lea	$39A8(a2),a0
		bsr.w	(VStreamF0-($C0*(4*4)))-2
		lea	$412B(a2),a0
		bsr.w	(VStreamF0-($C0*(4*4)))-2
		lea	$4A86(a2),a0
		bra.w	(VStreamF0-($B0*(4*4)))-2

	; --- Render 8 ---

AngleF0_8:
		lea	$54D2(a2),a0
		bsr.w	(VStreamF0-($A0*(4*4)))-2
		lea	$5E2E(a2),a0
		bsr.w	(VStreamF0-($90*(4*4)))-2
		lea	$6B42(a2),a0
		bra.w	(VStreamF0-($70*(4*4)))-2

	; --- Render 9 ---

AngleF0_9:
		lea	$7766(a2),a0
		bra.w	(VStreamF0-($50*(4*4)))-2

	; --- Render V-stream code ---

		binclude "Title Screen\Roundel\Matrix\VStreamF0.bin"
VStreamF0:

; ===========================================================================