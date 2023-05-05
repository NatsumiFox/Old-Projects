; ===========================================================================
; ---------------------------------------------------------------------------
; Roundel rendering matrix (for angle 10)
; ---------------------------------------------------------------------------

Render10:	dc.l	SwitchBuffer
		dc.l	Angle10_0
		dc.l	Angle10_1
		dc.l	Angle10_2
		dc.l	Angle10_3
		dc.l	Angle10_4
		dc.l	Angle10_5
		dc.l	Angle10_6
		dc.l	Angle10_7
		dc.l	Angle10_8
		dc.l	Angle10_9
		dc.l	FinishBuffer

	; --- Render 0 ---

Angle10_0:
		lea	-$7D48(a2),a0
		bsr.w	(VStream10-($50*(4*4)))-2
		lea	-$701D(a2),a0
		bsr.w	(VStream10-($70*(4*4)))-2
		lea	-$63E1(a2),a0
		bra.w	(VStream10-($90*(4*4)))-2

	; --- Render 1 ---

Angle10_1:
		lea	-$598D(a2),a0
		bsr.w	(VStream10-($A0*(4*4)))-2
		lea	-$5028(a2),a0
		bsr.w	(VStream10-($B0*(4*4)))-2
		lea	-$45D4(a2),a0
		bra.w	(VStream10-($C0*(4*4)))-2

	; --- Render 2 ---

Angle10_2:
		lea	-$3F47(a2),a0
		bsr.w	(VStream10-($C0*(4*4)))-2
		lea	-$35E3(a2),a0
		bsr.w	(VStream10-($D0*(4*4)))-2
		lea	-$2E66(a2),a0
		bra.w	(VStream10-($D0*(4*4)))-2

	; --- Render 3 ---

Angle10_3:
		lea	-$2501(a2),a0
		bsr.w	(VStream10-($E0*(4*4)))-2
		lea	-$1D84(a2),a0
		bsr.w	(VStream10-($E0*(4*4)))-2
		lea	-$16F7(a2),a0
		bra.w	(VStream10-($E0*(4*4)))-2

	; --- Render 4 ---

Angle10_4:
		lea	-$0F7B(a2),a0
		bsr.w	(VStream10-($E0*(4*4)))-2
		lea	-$08EE(a2),a0
		bsr.w	(VStream10-($E0*(4*4)))-2
		lea	-$0261(a2),a0
		bra.w	(VStream10-($E0*(4*4)))-2

	; --- Render 5 ---

Angle10_5:
		lea	$051C(a2),a0
		bsr.w	(VStream10-($E0*(4*4)))-2
		lea	$0BA9(a2),a0
		bsr.w	(VStream10-($E0*(4*4)))-2
		lea	$1236(a2),a0
		bra.w	(VStream10-($E0*(4*4)))-2

	; --- Render 6 ---

Angle10_6:
		lea	$19B3(a2),a0
		bsr.w	(VStream10-($E0*(4*4)))-2
		lea	$1D69(a2),a0
		bsr.w	(VStream10-($D0*(4*4)))-2
		lea	$24E6(a2),a0
		bra.w	(VStream10-($D0*(4*4)))-2

	; --- Render 7 ---

Angle10_7:
		lea	$289B(a2),a0
		bsr.w	(VStream10-($C0*(4*4)))-2
		lea	$2F28(a2),a0
		bsr.w	(VStream10-($C0*(4*4)))-2
		lea	$33CE(a2),a0
		bra.w	(VStream10-($B0*(4*4)))-2

	; --- Render 8 ---

Angle10_8:
		lea	$3783(a2),a0
		bsr.w	(VStream10-($A0*(4*4)))-2
		lea	$3B39(a2),a0
		bsr.w	(VStream10-($90*(4*4)))-2
		lea	$3D07(a2),a0
		bra.w	(VStream10-($70*(4*4)))-2

	; --- Render 9 ---

Angle10_9:
		lea	$3DE5(a2),a0
		bra.w	(VStream10-($50*(4*4)))-2

	; --- Render V-stream code ---

		binclude "Title Screen\Roundel\Matrix\VStream10.bin"
VStream10:

; ===========================================================================