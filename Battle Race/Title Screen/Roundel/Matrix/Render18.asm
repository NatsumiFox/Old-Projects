; ===========================================================================
; ---------------------------------------------------------------------------
; Roundel rendering matrix (for angle 18)
; ---------------------------------------------------------------------------

Render18:	dc.l	SwitchBuffer
		dc.l	Angle18_0
		dc.l	Angle18_1
		dc.l	Angle18_2
		dc.l	Angle18_3
		dc.l	Angle18_4
		dc.l	Angle18_5
		dc.l	Angle18_6
		dc.l	Angle18_7
		dc.l	Angle18_8
		dc.l	Angle18_9
		dc.l	FinishBuffer

	; --- Render 0 ---

Angle18_0:
		lea	-$7FFE(a2),a0
		bsr.w	(VStream18-($50*(4*4)))-2
		lea	-$71E5(a2),a0
		bsr.w	(VStream18-($70*(4*4)))-2
		lea	-$62DC(a2),a0
		bra.w	(VStream18-($90*(4*4)))-2

	; --- Render 1 ---

Angle18_1:
		lea	-$588A(a2),a0
		bsr.w	(VStream18-($A0*(4*4)))-2
		lea	-$4E38(a2),a0
		bsr.w	(VStream18-($B0*(4*4)))-2
		lea	-$43E6(a2),a0
		bra.w	(VStream18-($C0*(4*4)))-2

	; --- Render 2 ---

Angle18_2:
		lea	-$3D5A(a2),a0
		bsr.w	(VStream18-($C0*(4*4)))-2
		lea	-$3308(a2),a0
		bsr.w	(VStream18-($D0*(4*4)))-2
		lea	-$2D6C(a2),a0
		bra.w	(VStream18-($D0*(4*4)))-2

	; --- Render 3 ---

Angle18_3:
		lea	-$231A(a2),a0
		bsr.w	(VStream18-($E0*(4*4)))-2
		lea	-$1C8E(a2),a0
		bsr.w	(VStream18-($E0*(4*4)))-2
		lea	-$1603(a2),a0
		bra.w	(VStream18-($E0*(4*4)))-2

	; --- Render 4 ---

Angle18_4:
		lea	-$1067(a2),a0
		bsr.w	(VStream18-($E0*(4*4)))-2
		lea	-$09DC(a2),a0
		bsr.w	(VStream18-($E0*(4*4)))-2
		lea	-$0350(a2),a0
		bra.w	(VStream18-($E0*(4*4)))-2

	; --- Render 5 ---

Angle18_5:
		lea	$024B(a2),a0
		bsr.w	(VStream18-($E0*(4*4)))-2
		lea	$08D7(a2),a0
		bsr.w	(VStream18-($E0*(4*4)))-2
		lea	$0F62(a2),a0
		bra.w	(VStream18-($E0*(4*4)))-2

	; --- Render 6 ---

Angle18_6:
		lea	$14FE(a2),a0
		bsr.w	(VStream18-($E0*(4*4)))-2
		lea	$17C3(a2),a0
		bsr.w	(VStream18-($D0*(4*4)))-2
		lea	$1D5E(a2),a0
		bra.w	(VStream18-($D0*(4*4)))-2

	; --- Render 7 ---

Angle18_7:
		lea	$1F33(a2),a0
		bsr.w	(VStream18-($C0*(4*4)))-2
		lea	$25BF(a2),a0
		bsr.w	(VStream18-($C0*(4*4)))-2
		lea	$2794(a2),a0
		bra.w	(VStream18-($B0*(4*4)))-2

	; --- Render 8 ---

Angle18_8:
		lea	$2969(a2),a0
		bsr.w	(VStream18-($A0*(4*4)))-2
		lea	$2C2E(a2),a0
		bsr.w	(VStream18-($90*(4*4)))-2
		lea	$294C(a2),a0
		bra.w	(VStream18-($70*(4*4)))-2

	; --- Render 9 ---

Angle18_9:
		lea	$284A(a2),a0
		bra.w	(VStream18-($50*(4*4)))-2

	; --- Render V-stream code ---

		binclude "Title Screen\Roundel\Matrix\VStream18.bin"
VStream18:

; ===========================================================================