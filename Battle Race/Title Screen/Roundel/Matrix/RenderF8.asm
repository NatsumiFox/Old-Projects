; ===========================================================================
; ---------------------------------------------------------------------------
; Roundel rendering matrix (for angle F8)
; ---------------------------------------------------------------------------

RenderF8:	dc.l	SwitchBuffer
		dc.l	AngleF8_0
		dc.l	AngleF8_1
		dc.l	AngleF8_2
		dc.l	AngleF8_3
		dc.l	AngleF8_4
		dc.l	AngleF8_5
		dc.l	AngleF8_6
		dc.l	AngleF8_7
		dc.l	AngleF8_8
		dc.l	AngleF8_9
		dc.l	FinishBuffer

	; --- Render 0 ---

AngleF8_0:
		lea	-$580C(a2),a0
		bsr.w	(VStreamF8-($50*(4*4)))-2
		lea	-$534B(a2),a0
		bsr.w	(VStreamF8-($70*(4*4)))-2
		lea	-$4E8A(a2),a0
		bra.w	(VStreamF8-($90*(4*4)))-2

	; --- Render 1 ---

AngleF8_1:
		lea	-$48E1(a2),a0
		bsr.w	(VStreamF8-($A0*(4*4)))-2
		lea	-$4337(a2),a0
		bsr.w	(VStreamF8-($B0*(4*4)))-2
		lea	-$3C9E(a2),a0
		bra.w	(VStreamF8-($C0*(4*4)))-2

	; --- Render 2 ---

AngleF8_2:
		lea	-$360C(a2),a0
		bsr.w	(VStreamF8-($C0*(4*4)))-2
		lea	-$2F73(a2),a0
		bsr.w	(VStreamF8-($D0*(4*4)))-2
		lea	-$27F1(a2),a0
		bra.w	(VStreamF8-($D0*(4*4)))-2

	; --- Render 3 ---

AngleF8_3:
		lea	-$2248(a2),a0
		bsr.w	(VStreamF8-($E0*(4*4)))-2
		lea	-$1AC6(a2),a0
		bsr.w	(VStreamF8-($E0*(4*4)))-2
		lea	-$1435(a2),a0
		bra.w	(VStreamF8-($E0*(4*4)))-2

	; --- Render 4 ---

AngleF8_4:
		lea	-$0CB3(a2),a0
		bsr.w	(VStreamF8-($E0*(4*4)))-2
		lea	-$0532(a2),a0
		bsr.w	(VStreamF8-($E0*(4*4)))-2
		lea	$0250(a2),a0
		bra.w	(VStreamF8-($E0*(4*4)))-2

	; --- Render 5 ---

AngleF8_5:
		lea	$09D2(a2),a0
		bsr.w	(VStreamF8-($E0*(4*4)))-2
		lea	$1153(a2),a0
		bsr.w	(VStreamF8-($E0*(4*4)))-2
		lea	$18D5(a2),a0
		bra.w	(VStreamF8-($E0*(4*4)))-2

	; --- Render 6 ---

AngleF8_6:
		lea	$1F66(a2),a0
		bsr.w	(VStreamF8-($E0*(4*4)))-2
		lea	$28C0(a2),a0
		bsr.w	(VStreamF8-($D0*(4*4)))-2
		lea	$3042(a2),a0
		bra.w	(VStreamF8-($D0*(4*4)))-2

	; --- Render 7 ---

AngleF8_7:
		lea	$38AB(a2),a0
		bsr.w	(VStreamF8-($C0*(4*4)))-2
		lea	$402D(a2),a0
		bsr.w	(VStreamF8-($C0*(4*4)))-2
		lea	$4897(a2),a0
		bra.w	(VStreamF8-($B0*(4*4)))-2

	; --- Render 8 ---

AngleF8_8:
		lea	$51F0(a2),a0
		bsr.w	(VStreamF8-($A0*(4*4)))-2
		lea	$5A5A(a2),a0
		bsr.w	(VStreamF8-($90*(4*4)))-2
		lea	$649C(a2),a0
		bra.w	(VStreamF8-($70*(4*4)))-2

	; --- Render 9 ---

AngleF8_9:
		lea	$6EDE(a2),a0
		bra.w	(VStreamF8-($50*(4*4)))-2

	; --- Render V-stream code ---

		binclude "Title Screen\Roundel\Matrix\VStreamF8.bin"
VStreamF8:

; ===========================================================================