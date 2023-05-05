; ===========================================================================
; ---------------------------------------------------------------------------
; Roundel rendering matrix (for angle E0)
; ---------------------------------------------------------------------------

RenderE0:	dc.l	SwitchBuffer
		dc.l	AngleE0_0
		dc.l	AngleE0_1
		dc.l	AngleE0_2
		dc.l	AngleE0_3
		dc.l	AngleE0_4
		dc.l	AngleE0_5
		dc.l	AngleE0_6
		dc.l	AngleE0_7
		dc.l	AngleE0_8
		dc.l	AngleE0_9
		dc.l	FinishBuffer

	; --- Render 0 ---

AngleE0_0:
		lea	-$14AF(a2),a0
		bsr.w	(VStreamE0-($50*(4*4)))-2
		lea	-$1A3E(a2),a0
		bsr.w	(VStreamE0-($70*(4*4)))-2
		lea	-$1FCD(a2),a0
		bra.w	(VStreamE0-($90*(4*4)))-2

	; --- Render 1 ---

AngleE0_1:
		lea	-$1FC2(a2),a0
		bsr.w	(VStreamE0-($A0*(4*4)))-2
		lea	-$1FB6(a2),a0
		bsr.w	(VStreamE0-($B0*(4*4)))-2
		lea	-$1FAB(a2),a0
		bra.w	(VStreamE0-($C0*(4*4)))-2

	; --- Render 2 ---

AngleE0_2:
		lea	-$1A05(a2),a0
		bsr.w	(VStreamE0-($C0*(4*4)))-2
		lea	-$19FA(a2),a0
		bsr.w	(VStreamE0-($D0*(4*4)))-2
		lea	-$1544(a2),a0
		bra.w	(VStreamE0-($D0*(4*4)))-2

	; --- Render 3 ---

AngleE0_3:
		lea	-$1539(a2),a0
		bsr.w	(VStreamE0-($E0*(4*4)))-2
		lea	-$0F93(a2),a0
		bsr.w	(VStreamE0-($E0*(4*4)))-2
		lea	-$09EE(a2),a0
		bra.w	(VStreamE0-($E0*(4*4)))-2

	; --- Render 4 ---

AngleE0_4:
		lea	-$0538(a2),a0
		bsr.w	(VStreamE0-($E0*(4*4)))-2
		lea	$006E(a2),a0
		bsr.w	(VStreamE0-($E0*(4*4)))-2
		lea	$0613(a2),a0
		bra.w	(VStreamE0-($E0*(4*4)))-2

	; --- Render 5 ---

AngleE0_5:
		lea	$0AC9(a2),a0
		bsr.w	(VStreamE0-($E0*(4*4)))-2
		lea	$106F(a2),a0
		bsr.w	(VStreamE0-($E0*(4*4)))-2
		lea	$1614(a2),a0
		bra.w	(VStreamE0-($E0*(4*4)))-2

	; --- Render 6 ---

AngleE0_6:
		lea	$1ACA(a2),a0
		bsr.w	(VStreamE0-($E0*(4*4)))-2
		lea	$260A(a2),a0
		bsr.w	(VStreamE0-($D0*(4*4)))-2
		lea	$2AC0(a2),a0
		bra.w	(VStreamE0-($D0*(4*4)))-2

	; --- Render 7 ---

AngleE0_7:
		lea	$3510(a2),a0
		bsr.w	(VStreamE0-($C0*(4*4)))-2
		lea	$3AB5(a2),a0
		bsr.w	(VStreamE0-($C0*(4*4)))-2
		lea	$4505(a2),a0
		bra.w	(VStreamE0-($B0*(4*4)))-2

	; --- Render 8 ---

AngleE0_8:
		lea	$5045(a2),a0
		bsr.w	(VStreamE0-($A0*(4*4)))-2
		lea	$5A95(a2),a0
		bsr.w	(VStreamE0-($90*(4*4)))-2
		lea	$6A80(a2),a0
		bra.w	(VStreamE0-($70*(4*4)))-2

	; --- Render 9 ---

AngleE0_9:
		lea	$7A6A(a2),a0
		bra.w	(VStreamE0-($50*(4*4)))-2

	; --- Render V-stream code ---

		binclude "Title Screen\Roundel\Matrix\VStreamE0.bin"
VStreamE0:

; ===========================================================================