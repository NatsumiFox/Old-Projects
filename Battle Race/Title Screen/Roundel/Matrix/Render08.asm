; ===========================================================================
; ---------------------------------------------------------------------------
; Roundel rendering matrix (for angle 08)
; ---------------------------------------------------------------------------

Render08:	dc.l	SwitchBuffer
		dc.l	Angle08_0
		dc.l	Angle08_1
		dc.l	Angle08_2
		dc.l	Angle08_3
		dc.l	Angle08_4
		dc.l	Angle08_5
		dc.l	Angle08_6
		dc.l	Angle08_7
		dc.l	Angle08_8
		dc.l	Angle08_9
		dc.l	FinishBuffer

	; --- Render 0 ---

Angle08_0:
		lea	-$74F2(a2),a0
		bsr.w	(VStream08-($50*(4*4)))-2
		lea	-$6A93(a2),a0
		bsr.w	(VStream08-($70*(4*4)))-2
		lea	-$6035(a2),a0
		bra.w	(VStream08-($90*(4*4)))-2

	; --- Render 1 ---

Angle08_1:
		lea	-$57BF(a2),a0
		bsr.w	(VStream08-($A0*(4*4)))-2
		lea	-$4E59(a2),a0
		bsr.w	(VStream08-($B0*(4*4)))-2
		lea	-$45E2(a2),a0
		bra.w	(VStream08-($C0*(4*4)))-2

	; --- Render 2 ---

Angle08_2:
		lea	-$3E64(a2),a0
		bsr.w	(VStream08-($C0*(4*4)))-2
		lea	-$35EE(a2),a0
		bsr.w	(VStream08-($D0*(4*4)))-2
		lea	-$2E6F(a2),a0
		bra.w	(VStream08-($D0*(4*4)))-2

	; --- Render 3 ---

Angle08_3:
		lea	-$2509(a2),a0
		bsr.w	(VStream08-($E0*(4*4)))-2
		lea	-$1D8A(a2),a0
		bsr.w	(VStream08-($E0*(4*4)))-2
		lea	-$16FC(a2),a0
		bra.w	(VStream08-($E0*(4*4)))-2

	; --- Render 4 ---

Angle08_4:
		lea	-$0F7E(a2),a0
		bsr.w	(VStream08-($E0*(4*4)))-2
		lea	-$07FF(a2),a0
		bsr.w	(VStream08-($E0*(4*4)))-2
		lea	-$0081(a2),a0
		bra.w	(VStream08-($E0*(4*4)))-2

	; --- Render 5 ---

Angle08_5:
		lea	$06FE(a2),a0
		bsr.w	(VStream08-($E0*(4*4)))-2
		lea	$0E7C(a2),a0
		bsr.w	(VStream08-($E0*(4*4)))-2
		lea	$150B(a2),a0
		bra.w	(VStream08-($E0*(4*4)))-2

	; --- Render 6 ---

Angle08_6:
		lea	$1C89(a2),a0
		bsr.w	(VStream08-($E0*(4*4)))-2
		lea	$2310(a2),a0
		bsr.w	(VStream08-($D0*(4*4)))-2
		lea	$299E(a2),a0
		bra.w	(VStream08-($D0*(4*4)))-2

	; --- Render 7 ---

Angle08_7:
		lea	$3025(a2),a0
		bsr.w	(VStream08-($C0*(4*4)))-2
		lea	$37A3(a2),a0
		bsr.w	(VStream08-($C0*(4*4)))-2
		lea	$3D3A(a2),a0
		bra.w	(VStream08-($B0*(4*4)))-2

	; --- Render 8 ---

Angle08_8:
		lea	$42D0(a2),a0
		bsr.w	(VStream08-($A0*(4*4)))-2
		lea	$4867(a2),a0
		bsr.w	(VStream08-($90*(4*4)))-2
		lea	$4D06(a2),a0
		bra.w	(VStream08-($70*(4*4)))-2

	; --- Render 9 ---

Angle08_9:
		lea	$51A4(a2),a0
		bra.w	(VStream08-($50*(4*4)))-2

	; --- Render V-stream code ---

		binclude "Title Screen\Roundel\Matrix\VStream08.bin"
VStream08:

; ===========================================================================