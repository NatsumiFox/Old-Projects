; ===========================================================================
; ---------------------------------------------------------------------------
; SFX sound banks
; ---------------------------------------------------------------------------

Inst1SFX:

Inst2SFX:
	db iHold, 00h
; ===========================================================================
; ---------------------------------------------------------------------------
; Music headers
; ---------------------------------------------------------------------------

MusicPtrs:
	dw Hd_Test, Hd_SFX4, Hd_SFX3, Hd_SFX2, Hd_SFX
; ---------------------------------------------------------------------------

Hd_Test:
	HeadBGM		80h, 2
	HeadCh		Test_PSG1
	HeadCh		Test_PSG2
	HeadCh		Test_PSG3
	HeadCh		Test_PSG4
	HeadIns		Test_Ins, Test_Ins

Hd_SFX:
	HeadSFX		1
	HeadChs		SFX_PSG1, ctPSG1

Hd_SFX2:
	HeadSFX		2
	HeadChs		SFX_PSG2, ctPSG2
	HeadChs		SFX_PSG3, ctPSG3

Hd_SFX3:
	HeadSFX		2
	HeadChs		SFX_PSG1, ctPSG1
	HeadChs		SFX_PSG3, ctPSG3
	HeadChs		SFX_PSG4, ctPSG4

Hd_SFX4:
	HeadSFX		4
	HeadChs		SFX_PSG1, ctPSG1
	HeadChs		SFX_PSG2, ctPSG2
	HeadChs		SFX_PSG3, ctPSG3
	HeadChs		SFX_PSG4, ctPSG4

; ===========================================================================
; ---------------------------------------------------------------------------
; SFX data
; ---------------------------------------------------------------------------

SFX_PSG1:
SFX_PSG3:
SFX_PSG2:
	VolSet	00h
	ModSet	01h, 01h, 04h
	db nE3, 10h
	Return

SFX_PSG4:
	VolSet	06h
	Loops	04h
	db ns7, 02h, nRst, 02h
	Loope
	Return
