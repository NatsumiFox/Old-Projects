; ===========================================================================
; ---------------------------------------------------------------------------
; Roundel rendering matrix (for angle 00)
; ---------------------------------------------------------------------------

Render00:	dc.l	SwitchBuffer
		dc.l	Angle00_0
		dc.l	Angle00_1
		dc.l	Angle00_2
		dc.l	Angle00_3
		dc.l	Angle00_4
		dc.l	Angle00_5
		dc.l	Angle00_6
		dc.l	Angle00_7
		dc.l	Angle00_8
		dc.l	Angle00_9
		dc.l	FinishBuffer

	; --- Render 0 ---

Angle00_0:
		lea	-$67E8(a2),a0
		bsr.w	(VStream00-($50*(4*4)))-2
		lea	-$6058(a2),a0
		bsr.w	(VStream00-($70*(4*4)))-2
		lea	-$58C8(a2),a0
		bra.w	(VStream00-($90*(4*4)))-2

	; --- Render 1 ---

Angle00_1:
		lea	-$5140(a2),a0
		bsr.w	(VStream00-($A0*(4*4)))-2
		lea	-$49B8(a2),a0
		bsr.w	(VStream00-($B0*(4*4)))-2
		lea	-$4230(a2),a0
		bra.w	(VStream00-($C0*(4*4)))-2

	; --- Render 2 ---

Angle00_2:
		lea	-$3AB0(a2),a0
		bsr.w	(VStream00-($C0*(4*4)))-2
		lea	-$3328(a2),a0
		bsr.w	(VStream00-($D0*(4*4)))-2
		lea	-$2BA8(a2),a0
		bra.w	(VStream00-($D0*(4*4)))-2

	; --- Render 3 ---

Angle00_3:
		lea	-$2420(a2),a0
		bsr.w	(VStream00-($E0*(4*4)))-2
		lea	-$1CA0(a2),a0
		bsr.w	(VStream00-($E0*(4*4)))-2
		lea	-$1520(a2),a0
		bra.w	(VStream00-($E0*(4*4)))-2

	; --- Render 4 ---

Angle00_4:
		lea	-$0DA0(a2),a0
		bsr.w	(VStream00-($E0*(4*4)))-2
		lea	-$0620(a2),a0
		bsr.w	(VStream00-($E0*(4*4)))-2
		lea	$0160(a2),a0
		bra.w	(VStream00-($E0*(4*4)))-2

	; --- Render 5 ---

Angle00_5:
		lea	$08E0(a2),a0
		bsr.w	(VStream00-($E0*(4*4)))-2
		lea	$1060(a2),a0
		bsr.w	(VStream00-($E0*(4*4)))-2
		lea	$17E0(a2),a0
		bra.w	(VStream00-($E0*(4*4)))-2

	; --- Render 6 ---

Angle00_6:
		lea	$1F60(a2),a0
		bsr.w	(VStream00-($E0*(4*4)))-2
		lea	$26D8(a2),a0
		bsr.w	(VStream00-($D0*(4*4)))-2
		lea	$2E58(a2),a0
		bra.w	(VStream00-($D0*(4*4)))-2

	; --- Render 7 ---

Angle00_7:
		lea	$35D0(a2),a0
		bsr.w	(VStream00-($C0*(4*4)))-2
		lea	$3D50(a2),a0
		bsr.w	(VStream00-($C0*(4*4)))-2
		lea	$44C8(a2),a0
		bra.w	(VStream00-($B0*(4*4)))-2

	; --- Render 8 ---

Angle00_8:
		lea	$4C40(a2),a0
		bsr.w	(VStream00-($A0*(4*4)))-2
		lea	$53B8(a2),a0
		bsr.w	(VStream00-($90*(4*4)))-2
		lea	$5B28(a2),a0
		bra.w	(VStream00-($70*(4*4)))-2

	; --- Render 9 ---

Angle00_9:
		lea	$6298(a2),a0
		bra.w	(VStream00-($50*(4*4)))-2

	; --- Render V-stream code ---

		binclude "Title Screen\Roundel\Matrix\VStream00.bin"
VStream00:

; ===========================================================================