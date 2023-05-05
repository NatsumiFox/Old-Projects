; =============================================================================================
; Project Name:		invs
; Created:		21st December 2011
; ---------------------------------------------------------------------------------------------
; ASM'd using S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================

invs_Header:
	smpsHeaderVoice	invs_Voices
	smpsHeaderChan	$06,	$03
	smpsHeaderTempo	$02,	$03

	smpsHeaderDAC	invs_DAC
	smpsHeaderFM	invs_FM1,	smpsPitch05hi,	$00
	smpsHeaderFM	invs_FM2,	smpsPitch02hi,	$00
	smpsHeaderFM	invs_FM3,	smpsPitch04hi,	$00
	smpsHeaderFM	invs_FM4,	smpsPitch05hi,	$00
	smpsHeaderFM	invs_FM5,	smpsPitch06hi,	$00
	smpsHeaderPSG	invs_PSG1,	smpsPitch04lo,	$00,	$00
	smpsHeaderPSG	invs_PSG2,	smpsPitch04lo,	$00,	$00
	smpsHeaderPSG	invs_PSG3,	smpsPitch00,	$00,	$00

; DAC Data
invs_DAC:
	dc.b		nRst,	$0F,	$03,	dSnare,	$03,	dSnare,	$04,	dSnare
	dc.b		$02,	dSnare,	$01,	dSnare,	$02,	dSnare,	$02,	$85
	dc.b		$05,	dKick,	$02,	dSnare,	$07,	dKick,	$03,	dKick
	dc.b		$04,	dSnare,	$04,	dKick,	$03,	dKick,	$05,	dKick
	dc.b		$02,	dSnare,	$04,	dKick,	$01,	dSnare,	$02,	dKick
	dc.b		$04,	dKick,	$03,	dSnare,	$04,	dKick,	$03,	dKick
	dc.b		$06,	dKick,	$01,	dSnare,	$07,	dKick,	$04,	dKick
	dc.b		$03,	dSnare,	$04,	dKick,	$03,	dKick,	$06,	dKick
	dc.b		$02,	dSnare,	$03,	dKick,	$02,	dSnare,	$02,	dKick
	dc.b		$03,	dKick,	$04,	dSnare,	$03,	dSnare,	$02,	dSnare
	dc.b		$02,	$85,	$05,	dKick,	$02,	dSnare,	$08,	dKick
	dc.b		$04,	dKick,	$03,	dSnare,	$04,	dKick,	$03,	dKick
	dc.b		$06,	dKick,	$01,	dSnare,	$04,	dKick,	$02,	dSnare
	dc.b		$01,	dKick,	$04,	dKick,	$03,	dSnare,	$04,	dKick
	dc.b		$04,	dKick,	$05,	dKick,	$02,	dSnare,	$07,	dKick
	dc.b		$03,	dKick,	$04,	dSnare,	$03,	dKick,	$04,	dKick
	dc.b		$05,	dKick,	$02,	dSnare,	$03,	dKick,	$02,	dSnare
	dc.b		$02,	dKick,	$03,	dKick,	$04,	dSnare,	$03,	dSnare
	dc.b		$02,	dSnare,	$02,	$85,	$05,	dKick,	$02,	dSnare
	dc.b		$07,	dKick,	$04,	dKick,	$03,	dSnare,	$04,	dKick
	dc.b		$03,	dKick,	$06,	dKick,	$01,	dSnare,	$04,	dKick
	dc.b		$02,	dSnare,	$01,	dKick,	$04,	dKick,	$03,	dSnare
	dc.b		$04,	dKick,	$03,	dKick,	$06,	dKick,	$02,	dSnare
	dc.b		$07,	dKick,	$03,	dKick,	$04,	dSnare,	$03,	dKick
	dc.b		$04,	dKick,	$05,	dKick,	$02,	dSnare,	$03,	dKick
	dc.b		$02,	dSnare,	$02,	dKick,	$03,	dKick,	$04,	dSnare
	dc.b		$03,	dSnare,	$02,	dSnare,	$02,	$85,	$05,	dKick
	dc.b		$02,	dSnare,	$07,	dKick,	$04,	dKick,	$03,	dSnare
	dc.b		$04,	dKick,	$03,	dKick,	$06,	dKick,	$01,	dSnare
	dc.b		$04,	dKick,	$01,	dSnare,	$02,	dKick,	$04,	dKick
	dc.b		$03,	dSnare,	$04,	dKick,	$03,	dKick,	$06,	dKick
	dc.b		$01,	dSnare,	$08,	dKick,	$03,	dKick,	$04,	dSnare
	dc.b		$03,	dKick,	$04,	dKick,	$05,	dKick,	$02,	dSnare
	dc.b		$03,	dKick,	$02,	dSnare,	$02,	dKick,	$03,	dKick
	dc.b		$04,	dSnare,	$03,	dSnare,	$02,	dSnare,	$02,	$85
	dc.b		$05,	dKick,	$02,	dSnare,	$07,	dKick,	$03,	dKick
	dc.b		$04,	dSnare,	$04,	dKick,	$03,	dKick,	$05,	dKick
	dc.b		$02,	dSnare,	$04,	dKick,	$01,	dSnare,	$02,	dKick
	dc.b		$04,	dKick,	$03,	dSnare,	$04,	dKick,	$03,	dKick
	dc.b		$06,	dKick,	$01,	dSnare,	$07,	dKick,	$04,	dKick
	dc.b		$04,	dSnare,	$03,	dKick,	$04,	dKick,	$05,	dKick
	dc.b		$02,	dSnare,	$03,	dKick,	$02,	dSnare,	$02,	dKick
	dc.b		$03,	dKick,	$04,	dSnare,	$03,	dSnare,	$02,	dSnare
	dc.b		$02,	$85,	$05,	dKick,	$02,	dSnare,	$07,	dKick
	dc.b		$03,	dKick,	$04,	dSnare,	$04,	dKick,	$03,	dKick
	dc.b		$05,	dKick,	$02,	dSnare,	$04,	dKick,	$01,	dSnare
	dc.b		$02,	dKick,	$04,	dKick,	$03,	dSnare,	$04,	dKick
	dc.b		$03,	dKick,	$06,	dKick,	$01,	dSnare,	$07,	dKick
	dc.b		$04,	dKick,	$03,	dSnare,	$04,	dKick,	$04,	dKick
	dc.b		$05,	dKick,	$02,	dSnare,	$03,	dKick,	$02,	dSnare
	dc.b		$02,	dKick,	$03,	dKick,	$04,	dSnare,	$03,	dSnare
	dc.b		$02,	dSnare,	$02,	$85,	$05,	dKick,	$02,	dSnare
	dc.b		$07,	dKick,	$03,	dKick,	$04,	dSnare,	$04,	dKick
	dc.b		$03,	dKick,	$05,	dKick,	$02,	dSnare,	$04,	dKick
	dc.b		$01,	dSnare,	$02,	dKick,	$04,	dKick,	$03,	dSnare
	dc.b		$04,	dKick,	$03,	dKick,	$05,	dKick,	$02,	dSnare
	dc.b		$07,	dKick,	$04,	dKick,	$03,	dSnare,	$04,	dKick
	dc.b		$04,	dKick,	$05,	dKick,	$01,	dSnare,	$04,	dKick
	dc.b		$02,	dSnare,	$02,	dKick,	$03,	dKick,	$04,	dSnare
	dc.b		$03,	dSnare,	$02,	dSnare,	$02,	$85,	$05,	dKick
	dc.b		$02,	dSnare,	$07,	dKick,	$03,	dKick,	$04,	dSnare
	dc.b		$03,	dKick,	$04,	dKick,	$05,	dKick,	$02,	dSnare
	dc.b		$03,	dKick,	$02,	dSnare,	$02,	dKick,	$03,	dKick
	dc.b		$04,	dSnare,	$04,	dKick,	$03,	dKick,	$05,	dKick
	dc.b		$02,	dSnare,	$07,	dKick,	$04,	dKick,	$03,	dSnare
	dc.b		$04,	dKick,	$03,	dKick,	$06,	dKick,	$01,	dSnare
	dc.b		$04,	dKick,	$02,	dSnare,	$01,	dKick,	$04,	dKick
	dc.b		$04,	dSnare,	$03,	dSnare,	$02,	dSnare,	$02,	$85
	dc.b		$05,	dKick,	$02,	dSnare,	$07,	dKick,	$03,	dKick
	dc.b		$04,	dSnare,	$03,	dKick,	$04,	dKick,	$05,	dKick
	dc.b		$02,	dSnare,	$03,	dKick,	$02,	dSnare,	$02,	dKick
	dc.b		$04,	dKick,	$03,	dSnare,	$03,	dKick
	smpsStop

; FM1 Data
invs_FM1:
	dc.b		nRst,	$0E
	smpsFMvoice	$00
	smpsPan		panCentre,	$00
	dc.b		$01,	$11
	smpsAlterVol	$0E
	dc.b		nA0,	$07
	smpsAlterVol	$01
	dc.b		nFs0,	$03
	smpsAlterVol	$FF
	dc.b		nE0,	$04
	smpsAlterVol	$01
	dc.b		nA0,	$03
	smpsAlterVol	$FF
	dc.b		nFs0,	$04,	nD0,	$04
	smpsAlterVol	$01
	dc.b		nE0,	$0C,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$06,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nD1,	$02,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nD1,	$02,	nRst,	$02,	nD1,	$01,	nRst,	$02
	dc.b		nCs1,	$07,	nA0,	$04
	smpsAlterVol	$01
	dc.b		nE0,	$03,	nFs0,	$02,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nA0,	$05,	nRst,	$02,	nB0,	$16,	nRst,	$0A
	smpsAlterVol	$01
	dc.b		nA0,	$06,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nFs0,	$03,	nE0,	$05,	nA0,	$04,	nFs0,	$03
	smpsAlterVol	$01
	dc.b		nD0,	$04,	nE0,	$0C,	nRst,	$02,	nD1,	$07
	dc.b		nD1,	$02,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$01,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nD1,	$02,	nRst,	$02,	nCs1,	$06,	nA0,	$04
	dc.b		nE0,	$03,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nFs0,	$01,	nRst,	$02,	nA0,	$05,	nRst,	$02
	dc.b		nB0,	$16,	nRst,	$0A,	nA0,	$07
	smpsAlterVol	$01
	dc.b		nFs0,	$04
	smpsAlterVol	$FF
	dc.b		nE0,	$03
	smpsAlterVol	$01
	dc.b		nA0,	$04
	smpsAlterVol	$FF
	dc.b		nFs0,	$03,	nD0,	$04
	smpsAlterVol	$01
	dc.b		nE0,	$0C,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$07
	smpsAlterVol	$01
	dc.b		nD1,	$02,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nD1,	$03,	nRst,	$01,	nD1,	$02,	nRst,	$01
	dc.b		nCs1,	$08,	nA0,	$03
	smpsAlterVol	$01
	dc.b		nE0,	$03,	nRst,	$01,	nFs0,	$01,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nA0,	$05,	nRst,	$02,	nB0,	$16,	nRst,	$0A
	smpsAlterVol	$01
	dc.b		nA0,	$07
	smpsAlterVol	$FF
	dc.b		nFs0,	$03,	nE0,	$04,	nA0,	$04,	nFs0,	$03
	smpsAlterVol	$01
	dc.b		nD0,	$04,	nE0,	$0C,	nRst,	$02,	nD1,	$07
	dc.b		nD1,	$02,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nD1,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nD1,	$02,	nRst,	$01,	nCs1,	$07,	nA0,	$04
	dc.b		nE0,	$03,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nFs0,	$01,	nRst,	$02,	nA0,	$05,	nRst,	$02
	dc.b		nB0,	$16,	nRst,	$0A,	nA0,	$07
	smpsAlterVol	$01
	dc.b		nFs0,	$03,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE0,	$03
	smpsAlterVol	$01
	dc.b		nA0,	$03
	smpsAlterVol	$FF
	dc.b		nFs0,	$04,	nD0,	$04
	smpsAlterVol	$01
	dc.b		nE0,	$0C,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$07
	smpsAlterVol	$01
	dc.b		nD1,	$02,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nD1,	$02,	nRst,	$02,	nD1,	$02,	nRst,	$01
	dc.b		nCs1,	$07,	nA0,	$04
	smpsAlterVol	$01
	dc.b		nE0,	$03,	nFs0,	$02,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nA0,	$05,	nRst,	$02,	nB0,	$16,	nRst,	$0A
	smpsAlterVol	$01
	dc.b		nA0,	$06,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nFs0,	$03,	nE0,	$04,	nA0,	$03,	nFs0,	$04
	smpsAlterVol	$01
	dc.b		nD0,	$04,	nE0,	$0C,	nRst,	$02,	nD1,	$06
	dc.b		nRst,	$01,	nD1,	$01,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nD1,	$01,	nRst,	$02,	nCs1,	$07,	nA0,	$03
	dc.b		nRst,	$01,	nE0,	$03
	smpsAlterVol	$FF
	dc.b		nFs0,	$02,	nRst,	$02,	nA0,	$05,	nRst,	$02
	dc.b		nB0,	$16,	nRst,	$0A,	nA0,	$07
	smpsAlterVol	$01
	dc.b		nFs0,	$03
	smpsAlterVol	$FF
	dc.b		nE0,	$04
	smpsAlterVol	$01
	dc.b		nA0,	$03
	smpsAlterVol	$FF
	dc.b		nFs0,	$04,	nD0,	$04
	smpsAlterVol	$01
	dc.b		nE0,	$0C,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$06,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nD1,	$01,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$02,	nRst,	$02,	nD1,	$01,	nRst,	$02
	dc.b		nCs1,	$07,	nA0,	$04
	smpsAlterVol	$01
	dc.b		nE0,	$02,	nRst,	$01,	nFs0,	$02,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nA0,	$05,	nRst,	$02,	nB0,	$15,	nRst,	$0B
	smpsAlterVol	$01
	dc.b		nA0,	$06,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nFs0,	$03,	nE0,	$04,	nA0,	$03,	nFs0,	$04
	smpsAlterVol	$01
	dc.b		nD0,	$03,	nE0,	$0D,	nRst,	$01,	nD1,	$07
	dc.b		nD1,	$02,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nD1,	$01,	nRst,	$02,	nCs1,	$07,	nA0,	$03
	dc.b		nRst,	$01,	nE0,	$03
	smpsAlterVol	$FF
	dc.b		nFs0,	$02,	nRst,	$02,	nA0,	$05,	nRst,	$02
	dc.b		nB0,	$16,	nRst,	$0A,	nA0,	$07
	smpsAlterVol	$01
	dc.b		nFs0,	$03
	smpsAlterVol	$FF
	dc.b		nE0,	$04
	smpsAlterVol	$01
	dc.b		nA0,	$03
	smpsAlterVol	$FF
	dc.b		nFs0,	$04,	nD0,	$03
	smpsAlterVol	$01
	dc.b		nE0,	$0D,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nD1,	$07,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nD1,	$01,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$02,	nRst,	$01,	nD1,	$02
	smpsStop

; FM2 Data
invs_FM2:
	dc.b		nRst,	$0E
	smpsFMvoice	$00
	smpsPan		panCentre,	$00
	dc.b		$01,	$11
	smpsAlterVol	$10
	dc.b		nA0,	$01,	nRst,	$01,	nA0,	$02,	nRst,	$01
	dc.b		nA0,	$02,	nRst,	$02,	nA0,	$01
	smpsAlterVol	$FF
	dc.b		nA0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nFs0,	$02,	nRst,	$01,	nFs0,	$06,	nRst,	$02
	dc.b		nE0,	$02,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE0,	$01,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nE0,	$01,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nE0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nE0,	$01,	nRst,	$01,	nD0,	$03,	nRst,	$02
	dc.b		nD0,	$02,	nRst,	$01,	nD1,	$04
	smpsAlterVol	$FF
	dc.b		nD0,	$01,	nRst,	$01,	nD0,	$01
	smpsAlterVol	$01
	dc.b		nD0,	$02,	nA0,	$01,	nRst,	$01,	nA0,	$02
	dc.b		nRst,	$02,	nA0,	$02,	nRst,	$01,	nA0,	$01
	dc.b		nRst,	$01,	nA0,	$02,	nRst,	$01,	nFs0,	$02
	dc.b		nRst,	$02,	nFs0,	$05,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nG0,	$02,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nG0,	$01,	nRst,	$01,	nG0,	$02,	nRst,	$02
	dc.b		nG0,	$01,	nRst,	$02,	nG0,	$01,	nRst,	$01
	dc.b		nE0,	$04,	nRst,	$01,	nE0,	$02,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nE1,	$03
	smpsAlterVol	$01
	dc.b		nE0,	$01,	nRst,	$01,	nE0,	$02
	smpsAlterVol	$FF
	dc.b		nE0,	$02,	nA0,	$01,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nA0,	$02,	nRst,	$01,	nA0,	$02,	nRst,	$01
	dc.b		nA0,	$01,	nRst,	$01,	nA0,	$04,	nRst,	$01
	dc.b		nFs0,	$02,	nRst,	$02,	nFs0,	$05,	nRst,	$02
	dc.b		nE0,	$02,	nRst,	$01,	nE0,	$01,	nRst,	$01
	dc.b		nE0,	$02,	nRst,	$02,	nE0,	$01,	nRst,	$02
	dc.b		nE0,	$01,	nRst,	$01,	nD0,	$03,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nD1,	$03,	nD0,	$01,	nRst,	$01,	nD0,	$02
	smpsAlterVol	$FF
	dc.b		nD0,	$02,	nA0,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nA0,	$02,	nRst,	$02,	nA0,	$02,	nRst,	$01
	dc.b		nA0,	$01,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nA0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nFs0,	$01,	nRst,	$02,	nFs0,	$06,	nRst,	$01
	dc.b		nG0,	$03,	nRst,	$01,	nG0,	$01,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nG0,	$01,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nG0,	$02,	nRst,	$02,	nG0,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE0,	$04,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nE0,	$02,	nRst,	$01,	nE1,	$03,	nRst,	$01
	dc.b		nE0,	$01
	smpsAlterVol	$FF
	dc.b		nE0,	$02
	smpsAlterVol	$01
	dc.b		nE0,	$02,	nA0,	$01,	nRst,	$01,	nA0,	$02
	dc.b		nRst,	$01,	nA0,	$02,	nRst,	$02,	nA0,	$01
	dc.b		nRst,	$01
	smpsAlterVol	$FF
	dc.b		nA0,	$01,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nFs0,	$02,	nRst,	$02,	nFs0,	$05,	nRst,	$02
	dc.b		nE0,	$02,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE0,	$01,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nE0,	$02,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nE0,	$01,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nE0,	$01,	nRst,	$01,	nD0,	$03,	nRst,	$02
	dc.b		nD0,	$02,	nRst,	$02,	nD1,	$03
	smpsAlterVol	$FF
	dc.b		nD0,	$01,	nRst,	$01,	nD0,	$02
	smpsAlterVol	$01
	dc.b		nD0,	$01,	nA0,	$01,	nRst,	$01,	nA0,	$02
	dc.b		nRst,	$02,	nA0,	$02,	nRst,	$01,	nA0,	$01
	dc.b		nRst,	$01,	nA0,	$02,	nRst,	$02,	nFs0,	$01
	dc.b		nRst,	$02,	nFs0,	$06,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nG0,	$03,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nG0,	nRst,	$01,	nG0,	$02,	nRst,	$02,	nG0
	dc.b		$02,	nRst,	$02,	nG0,	nRst,	$01,	nE0,	$04
	dc.b		nRst,	$01,	nE0,	$03,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE1,	$03,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nE0,	$01,	nE0,	$02
	smpsAlterVol	$FF
	dc.b		nE0,	$02,	nA0,	$01,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nA0,	$02,	nRst,	$01,	nA0,	$02,	nRst,	$02
	dc.b		nA0,	$01,	nA0,	$02,	nRst,	$02,	nFs0,	$02
	dc.b		nRst,	$02,	nFs0,	$05,	nRst,	$02,	nE0,	$02
	dc.b		nRst,	$01,	nE0,	$01,	nRst,	$01,	nE0,	$02
	dc.b		nRst,	$02,	nE0,	$01,	nRst,	$02,	nE0,	$01
	dc.b		nRst,	$01,	nD0,	$03,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nD1,	$03,	nD0,	$01,	nRst,	$01,	nD0,	$02
	smpsAlterVol	$FF
	dc.b		nD0,	$01,	nA0,	$01,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nA0,	$02,	nRst,	$02,	nA0,	$02,	nRst,	$01
	dc.b		nA0,	$01,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nA0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nFs0,	$01,	nRst,	$02,	nFs0,	$05,	nRst,	$02
	dc.b		nG0,	$03,	nRst,	$01,	nG0,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nG0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nG0,	$02,	nRst,	$01,	nG0,	$01,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE0,	$04,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nE0,	$02,	nRst,	$01,	nE1,	$03,	nE0,	$02
	smpsAlterVol	$FF
	dc.b		nE0,	$02
	smpsAlterVol	$01
	dc.b		nE0,	$02,	nA0,	$01,	nRst,	$01,	nA0,	$02
	dc.b		nRst,	$01,	nA0,	$02,	nRst,	$02,	nA0,	$01
	dc.b		nRst,	$01
	smpsAlterVol	$FF
	dc.b		nA0,	$01,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nFs0,	$02,	nRst,	$01,	nFs0,	$06,	nRst,	$02
	dc.b		nE0,	$02,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE0,	$01,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nE0,	$02,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nE0,	$01,	nRst,	$01,	nD0,	$03,	nRst,	$02
	dc.b		nD0,	$02,	nRst,	$02,	nD1,	$03
	smpsAlterVol	$FF
	dc.b		nD0,	$01,	nRst,	$01,	nD0,	$02
	smpsAlterVol	$01
	dc.b		nD0,	$01,	nA0,	$01,	nRst,	$01,	nA0,	$02
	dc.b		nRst,	$02,	nA0,	$02,	nRst,	$01,	nA0,	$01
	dc.b		nRst,	$01,	nA0,	$02,	nRst,	$01,	nFs0,	$02
	dc.b		nRst,	$02,	nFs0,	$05,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nG0,	$03,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nG0,	nRst,	$01,	nG0,	$02,	nRst,	$02,	nG0
	dc.b		$01,	nRst,	$02,	nG0,	$01,	nRst,	$01,	nE0
	dc.b		$04,	nRst,	$01,	nE0,	$03,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE1,	$03
	smpsAlterVol	$01
	dc.b		nE0,	$01,	nRst,	$01,	nE0,	$02
	smpsAlterVol	$FF
	dc.b		nE0,	$02,	nA0,	$01,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nA0,	$02,	nRst,	$01,	nA0,	$02,	nRst,	$02
	dc.b		nA0,	$01,	nA0,	$02,	nRst,	$02,	nFs0,	$01
	dc.b		nRst,	$02,	nFs0,	$06,	nRst,	$02,	nE0,	$02
	dc.b		nRst,	$01,	nE0,	$01,	nRst,	$01,	nE0,	$02
	dc.b		nRst,	$01,	nE0,	$02,	nRst,	$02,	nE0,	$01
	dc.b		nRst,	$01,	nD0,	$03,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD0,	$02,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nD1,	$04,	nD0,	$01,	nRst,	$01,	nD0,	$01
	smpsAlterVol	$FF
	dc.b		nD0,	$02,	nA0,	$01,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nA0,	$02,	nRst,	$02,	nA0,	$02,	nRst,	$01
	dc.b		nA0,	$01,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nA0,	$02,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nFs0,	$02,	nRst,	$02,	nFs0,	$05,	nRst,	$02
	dc.b		nG0,	$03,	nRst,	$01,	nG0,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nG0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nG0,	$01,	nRst,	$02,	nG0,	$01,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE0,	$04,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nE0,	$03,	nRst,	$01,	nE1,	$03,	nE0,	$01
	dc.b		nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE0,	$02
	smpsAlterVol	$01
	dc.b		nE0,	$02,	nA0,	$01,	nRst,	$01,	nA0,	$02
	dc.b		nRst,	$01,	nA0,	$02,	nRst,	$01,	nA0,	$01
	dc.b		nRst,	$01
	smpsAlterVol	$FF
	dc.b		nA0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nFs0,	$01,	nRst,	$02,	nFs0,	$06,	nRst,	$02
	dc.b		nE0,	$02,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE0,	$01,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nE0,	$01,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nE0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nE0,	$01,	nRst,	$01,	nD0,	$03,	nRst,	$02
	dc.b		nD0,	$02,	nRst,	$01,	nD1,	$04
	smpsAlterVol	$FF
	dc.b		nD0,	$01,	nRst,	$01,	nD0,	$01
	smpsAlterVol	$01
	dc.b		nD0,	$02,	nA0,	$01,	nRst,	$01,	nA0,	$02
	dc.b		nRst,	$01,	nA0,	$03,	nRst,	$01,	nA0,	$01
	dc.b		nRst,	$01,	nA0,	$02,	nRst,	$01,	nFs0,	$02
	dc.b		nRst,	$02,	nFs0,	$05,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nG0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nG0,	nRst,	$01,	nG0,	$02,	nRst,	$02,	nG0
	dc.b		$01,	nRst,	$02,	nG0,	$01,	nRst,	$01,	nE0
	dc.b		$04,	nRst,	$01,	nE0,	$02,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nE1,	$03
	smpsAlterVol	$01
	dc.b		nE0,	$01,	nRst,	$01,	nE0,	$02
	smpsAlterVol	$FF
	dc.b		nE0,	$02,	nA0,	$01
	smpsAlterVol	$01
	dc.b		nA0,	$02,	nRst,	$02,	nA0,	$02,	nRst,	$02
	dc.b		nA0,	$01,	nA0,	$02,	nRst,	$02,	nFs0,	$01
	dc.b		nRst,	$02,	nFs0,	$06,	nRst,	$01,	nE0,	$03
	dc.b		nRst,	$01,	nE0,	$01,	nRst,	$01,	nE0,	$01
	dc.b		nRst,	$02,	nE0,	$02,	nRst,	$02,	nE0,	$01
	dc.b		nD0,	$04,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD0,	$02,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nD1,	$04,	nD0,	$01,	nRst,	$01,	nD0,	$01
	smpsAlterVol	$FF
	dc.b		nD0,	$02,	nA0,	$01,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nA0,	$02,	nRst,	$01,	nA0,	$03,	nRst,	$01
	dc.b		nA0,	$01,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nA0,	$02,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nFs0,	$02,	nRst,	$02,	nFs0,	$05,	nRst,	$02
	dc.b		nG0,	$02,	nRst,	$01,	nG0,	$01,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nG0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nG0,	$01,	nRst,	$02,	nG0,	$01,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE0,	$03,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nE0,	$02,	nRst,	$02,	nE1,	$03,	nE0,	$01
	dc.b		nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE0,	$02
	smpsAlterVol	$01
	dc.b		nE0,	$02,	nA0,	$01,	nA0,	$02,	nRst,	$02
	dc.b		nA0,	$02,	nRst,	$01,	nA0,	$01,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nA0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nFs0,	$01,	nRst,	$02,	nFs0,	$06,	nRst,	$01
	dc.b		nE0,	$03,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE0,	$01,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nE0,	$01,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nE0,	$02,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nE0,	$01,	nD0,	$04,	nRst,	$02,	nD0,	$02
	dc.b		nRst,	$01,	nD1,	$03,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nD0,	$01,	nD0,	$02
	smpsAlterVol	$01
	dc.b		nD0,	$02
	smpsStop

; FM3 Data
invs_FM3:
	dc.b		nRst,	$0E
	smpsFMvoice	$00
	smpsPan		panLeft,	$00
	dc.b		$01,	$11
	smpsAlterVol	$1F
	dc.b		nA1,	$07,	nFs1,	$03
	smpsAlterVol	$FF
	dc.b		nE1,	$04
	smpsAlterVol	$01
	dc.b		nA1,	$03,	nFs1,	$04,	nD1,	$03,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nE1,	$13,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$0A
	smpsAlterVol	$FF
	dc.b		nCs2,	$07
	smpsAlterVol	$02
	dc.b		nA1,	$04
	smpsAlterVol	$FF
	dc.b		nE1,	$02,	nRst,	$01,	nFs1,	$02,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nA1,	$09,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nD1,	$02,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$06,	nRst,	$01
	smpsAlterVol	$02
	dc.b		nB0,	$11,	nRst,	$01
	smpsAlterVol	$FE
	dc.b		nA1,	$07,	nFs1,	$03,	nE1,	$05,	nA1,	$04
	smpsAlterVol	$01
	dc.b		nFs1,	$03
	smpsAlterVol	$FF
	dc.b		nD1,	$04
	smpsAlterVol	$02
	dc.b		nE1,	$13,	nRst,	$02,	nD1,	$0A,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nCs2,	$07,	nA1,	$03,	nE1,	$03,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nFs1,	$01,	nRst,	$02,	nA1,	$09,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$01,	nRst,	$02,	nD1,	$06,	nRst,	$01
	dc.b		nB0,	$12,	nA1,	$07,	nFs1,	$04
	smpsAlterVol	$FF
	dc.b		nE1,	$03
	smpsAlterVol	$01
	dc.b		nA1,	$04,	nFs1,	$03,	nD1,	$04
	smpsAlterVol	$01
	dc.b		nE1,	$13,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$0A
	smpsAlterVol	$FF
	dc.b		nCs2,	$07,	nRst,	$01
	smpsAlterVol	$02
	dc.b		nA1,	$03
	smpsAlterVol	$FF
	dc.b		nE1,	$03,	nRst,	$01,	nFs1,	$01,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nA1,	$09,	nRst,	$02
	smpsAlterVol	$01
	dc.b		nD1,	$01,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$06,	nRst,	$01
	smpsAlterVol	$02
	dc.b		nB0,	$12
	smpsAlterVol	$FE
	dc.b		nA1,	$07,	nFs1,	$03,	nE1,	$04,	nA1,	$03
	dc.b		nRst,	$01
	smpsAlterVol	$01
	dc.b		nFs1,	$03
	smpsAlterVol	$FF
	dc.b		nD1,	$04
	smpsAlterVol	$02
	dc.b		nE1,	$13,	nRst,	$02,	nD1,	$0A
	smpsAlterVol	$FF
	dc.b		nCs2,	$07,	nRst,	$01,	nA1,	$03,	nE1,	$03
	dc.b		nRst,	$01
	smpsAlterVol	$01
	dc.b		nFs1,	$01,	nRst,	$02,	nA1,	$09,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$01,	nRst,	$02,	nD1,	$06,	nRst,	$01
	dc.b		nB0,	$12,	nA1,	$07,	nFs1,	$03,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nE1,	$03
	smpsAlterVol	$01
	dc.b		nA1,	$03,	nFs1,	$04,	nD1,	$03
	smpsAlterVol	$01
	dc.b		nE1,	$14,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$0A
	smpsAlterVol	$FF
	dc.b		nCs2,	$07
	smpsAlterVol	$02
	dc.b		nA1,	$04
	smpsAlterVol	$FF
	dc.b		nE1,	$03,	nFs1,	$02,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nA1,	$09,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nD1,	$02,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$06,	nRst,	$01
	smpsAlterVol	$02
	dc.b		nB0,	$11,	nRst,	$01
	smpsAlterVol	$FE
	dc.b		nA1,	$07,	nFs1,	$03,	nE1,	$04,	nA1,	$03
	smpsAlterVol	$01
	dc.b		nFs1,	$04
	smpsAlterVol	$FF
	dc.b		nD1,	$04
	smpsAlterVol	$02
	dc.b		nE1,	$13,	nRst,	$02,	nD1,	$0A
	smpsAlterVol	$FF
	dc.b		nCs2,	$07,	nA1,	$04,	nE1,	$03
	smpsAlterVol	$01
	dc.b		nFs1,	$02,	nRst,	$02,	nA1,	$09,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$01,	nRst,	$02,	nD1,	$06,	nRst,	$01
	dc.b		nB0,	$11,	nRst,	$01,	nA1,	$07,	nFs1,	$03
	smpsAlterVol	$FF
	dc.b		nE1,	$04
	smpsAlterVol	$01
	dc.b		nA1,	$03,	nFs1,	$04,	nD1,	$03
	smpsAlterVol	$01
	dc.b		nE1,	$13,	nRst,	$03
	smpsAlterVol	$FF
	dc.b		nD1,	$0A
	smpsAlterVol	$FF
	dc.b		nCs2,	$07
	smpsAlterVol	$02
	dc.b		nA1,	$04
	smpsAlterVol	$FF
	dc.b		nE1,	$02,	nRst,	$01,	nFs1,	$02,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nA1,	$09,	nRst,	$01
	smpsAlterVol	$01
	dc.b		nD1,	$02,	nRst,	$02
	smpsAlterVol	$FF
	dc.b		nD1,	$06,	nRst,	$01
	smpsAlterVol	$02
	dc.b		nB0,	$11,	nRst,	$01
	smpsAlterVol	$FE
	dc.b		nA1,	$07,	nFs1,	$03,	nE1,	$04,	nA1,	$03
	smpsAlterVol	$01
	dc.b		nFs1,	$04
	smpsAlterVol	$FF
	dc.b		nD1,	$03,	nRst,	$01
	smpsAlterVol	$02
	dc.b		nE1,	$13,	nRst,	$02,	nD1,	$0A
	smpsAlterVol	$FF
	dc.b		nCs2,	$07,	nA1,	$04,	nE1,	$03
	smpsAlterVol	$01
	dc.b		nFs1,	$02,	nRst,	$02,	nA1,	$09,	nRst,	$01
	smpsAlterVol	$FF
	dc.b		nD1,	$02,	nRst,	$02,	nD1,	$05,	nRst,	$02
	dc.b		nB0,	$11,	nRst,	$01,	nA1,	$07,	nFs1,	$03
	smpsAlterVol	$FF
	dc.b		nE1,	$04
	smpsAlterVol	$01
	dc.b		nA1,	$03,	nFs1,	$04,	nD1,	$03
	smpsAlterVol	$01
	dc.b		nE1,	$13,	nRst,	$03
	smpsAlterVol	$FF
	dc.b		nD1,	$0A
	smpsStop

; FM4 Data
invs_FM4:
	dc.b		nRst,	$0E
	smpsFMvoice	$00
	smpsPan		panRight,	$00
	dc.b		$01,	$18
	smpsAlterVol	$1F
	dc.b		nA0,	$02,	nRst,	$08,	nA0,	$03,	nRst,	$0F
	dc.b		nA0,	$02,	nRst,	$09,	nA0,	$0C,	nRst,	$1A
	dc.b		nG0,	$02,	nRst,	$02,	nG0,	$06,	nRst,	$01
	dc.b		nE0,	$11,	nRst,	$08,	nA0,	$02,	nRst,	$0A
	dc.b		nA0,	$02,	nRst,	$0F,	nA0,	$03,	nRst,	$08
	dc.b		nA0,	$0C,	nRst,	$1B,	nG0,	$02,	nRst,	$01
	dc.b		nG0,	$06,	nRst,	$01,	nE0,	$12,	nRst,	$07
	dc.b		nA0,	$02,	nRst,	$09,	nA0,	$02,	nRst,	$0F
	dc.b		nA0,	$02,	nRst,	$09,	nA0,	$0C,	nRst,	$1B
	dc.b		nG0,	$02,	nRst,	$01,	nG0,	$06,	nRst,	$01
	dc.b		nE0,	$12,	nRst,	$07,	nA0,	$02,	nRst,	$09
	dc.b		nA0,	$02,	nRst,	$0F,	nA0,	$02,	nRst,	$09
	dc.b		nA0,	$0C,	nRst,	$1B,	nG0,	$02,	nRst,	$01
	dc.b		nG0,	$06,	nRst,	$01,	nE0,	$12,	nRst,	$07
	dc.b		nA0,	$02,	nRst,	$08,	nA0,	$03,	nRst,	$0F
	dc.b		nA0,	$02,	nRst,	$09,	nA0,	$0C,	nRst,	$1B
	dc.b		nG0,	$01,	nRst,	$02,	nG0,	$06,	nRst,	$01
	dc.b		nE0,	$11,	nRst,	$08,	nA0,	$02,	nRst,	$08
	dc.b		nA0,	$03,	nRst,	$0F,	nA0,	$02,	nRst,	$09
	dc.b		nA0,	$0C,	nRst,	$1B,	nG0,	$02,	nRst,	$01
	dc.b		nG0,	$06,	nRst,	$01,	nE0,	$11,	nRst,	$08
	dc.b		nA0,	$02,	nRst,	$08,	nA0,	$03,	nRst,	$0F
	dc.b		nA0,	$02,	nRst,	$09,	nA0,	$0C,	nRst,	$1B
	dc.b		nG0,	$01,	nRst,	$02,	nG0,	$06,	nRst,	$01
	dc.b		nE0,	$11,	nRst,	$08,	nA0,	$02,	nRst,	$08
	dc.b		nA0,	$03,	nRst,	$0F,	nA0,	$02,	nRst,	$08
	dc.b		nA0,	$0D,	nRst,	$1A,	nG0,	$02,	nRst,	$02
	dc.b		nG0,	$05,	nRst,	$02,	nE0,	$11,	nRst,	$08
	dc.b		nA0,	$02,	nRst,	$08,	nA0,	$03,	nRst,	$0F
	dc.b		nA0,	$02,	nRst,	$09,	nA0,	$0A
	smpsStop

; FM5 Data
invs_FM5:
	dc.b		nRst,	$0E
	smpsFMvoice	$00
	smpsPan		panLeft,	$00
	dc.b		$01,	$11
	smpsAlterVol	$25
	dc.b		nE1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$01
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$01
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$01
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$01
	dc.b		nD1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$02
	dc.b		nD1,	$01,	nCs1,	$02,	nB0,	$02,	nA1,	$02
	dc.b		nRst,	$03,	nB1,	$02,	nA1,	$02,	nRst,	$03
	dc.b		nB1,	$02,	nA1,	$02,	nE1,	$02,	nCs1,	$01
	dc.b		nB0,	$02,	nA0,	$02,	nE1,	$01,	nCs1,	$02
	dc.b		nB0,	$03,	nA0,	$02,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$01,	nA0,	$02,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$02,	nE1,	$01,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$02,	nE1,	$01,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$02,	nE1,	$01,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$02,	nE1,	$01,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$02,	nE0,	$02,	nFs0,	$01
	dc.b		nG0,	$02,	nA0,	$02,	nFs0,	$02,	nG0,	$01
	dc.b		nA0,	$02,	nB0,	$02,	nG0,	$02,	nA0,	$01
	dc.b		nB0,	$02,	nCs1,	$02,	nA0,	$02,	nB0,	$01
	dc.b		nCs1,	$02,	nD1,	$02,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$01,	nA0,	$02,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$01,	nA0,	$02,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$01,	nA0,	$02,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$02,	nE1,	$01,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$02,	nE1,	$01,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$02,	nE1,	$01,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$02,	nD1,	$01,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$02,	nD1,	$02,	nCs1,	$01
	dc.b		nB0,	$02,	nA1,	$02,	nRst,	$03,	nB1,	$02
	dc.b		nA1,	$02,	nRst,	$03,	nB1,	$02,	nA1,	$02
	dc.b		nE1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$01
	dc.b		nD1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$01
	dc.b		nD1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$01
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$01
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$01,	nCs1,	$02,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$01,	nCs1,	$02,	nB0,	$02,	nA0,	$02
	dc.b		nE0,	$01,	nFs0,	$02,	nG0,	$02,	nA0,	$02
	dc.b		nFs0,	$01,	nG0,	$02,	nA0,	$02,	nB0,	$02
	dc.b		nG0,	$02,	nA0,	$01,	nB0,	$02,	nCs1,	$02
	dc.b		nA0,	$01,	nB0,	$02,	nCs1,	$02,	nD1,	$02
	dc.b		nE1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$01
	dc.b		nD1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$01
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$01
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$01
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$01,	nCs1,	$02,	nB0,	$02,	nA0,	$02
	dc.b		nD1,	$01,	nCs1,	$02,	nB0,	$02,	nA0,	$02
	dc.b		nD1,	$01,	nCs1,	$02,	nB0,	$02,	nA1,	$02
	dc.b		nRst,	$03,	nB1,	$02,	nA1,	$02,	nRst,	$03
	dc.b		nB1,	$02,	nA1,	$02,	nE1,	$02,	nCs1,	$01
	dc.b		nB0,	$02,	nA0,	$02,	nE1,	$02,	nCs1,	$01
	dc.b		nB0,	$02,	nA0,	$02,	nE1,	$02,	nCs1,	$01
	dc.b		nB0,	$02,	nA0,	$02,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$01,	nA0,	$02,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$01,	nA0,	$02,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$01,	nA0,	$02,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$01,	nA0,	$02,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$01,	nA0,	$02,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$02,	nE0,	$01,	nFs0,	$02
	dc.b		nG0,	$02,	nA0,	$02,	nFs0,	$01,	nG0,	$02
	dc.b		nA0,	$02,	nB0,	$02,	nG0,	$01,	nA0,	$02
	dc.b		nB0,	$02,	nCs1,	$02,	nA0,	$01,	nB0,	$02
	dc.b		nCs1,	$02,	nD1,	$02,	nE1,	$02,	nCs1,	$01
	dc.b		nB0,	$02,	nA0,	$02,	nE1,	$01,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$02,	nE1,	$02,	nCs1,	$01
	dc.b		nB0,	$02,	nA0,	$02,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$01,	nA0,	$02,	nD1,	$02,	nCs1,	$01
	dc.b		nB0,	$02,	nA0,	$02,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$01,	nA0,	$02,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$01,	nA0,	$02,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$01,	nA0,	$02,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$01,	nA0,	$02,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nE1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$02,	nD1,	$01,	nCs1,	$02
	dc.b		nB0,	$02,	nA0,	$01,	nD1,	$02,	nCs1,	$02
	dc.b		nB0,	$02,	nA1,	$02,	nRst,	$03,	nB1,	$02
	dc.b		nA1,	$02,	nRst,	$03,	nB1,	$02,	nA1,	$02
	dc.b		nE1,	$01,	nCs1,	$02,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$01,	nCs1,	$02,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$01
	dc.b		nE1,	$02,	nCs1,	$02,	nB0,	$02,	nA0,	$01
	dc.b		nE0,	$02,	nFs0,	$02,	nG0,	$02,	nA0,	$01
	dc.b		nFs0,	$02,	nG0,	$02,	nA0,	$02,	nB0,	$01
	dc.b		nG0,	$02,	nA0,	$02,	nB0,	$02,	nCs1,	$02
	dc.b		nA0,	$01,	nB0,	$02,	nCs1,	$02,	nD1,	$02
	dc.b		nE1,	$01,	nCs1,	$02,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$01,	nCs1,	$02,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nE1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$02,	nB0,	$01,	nA0,	$02
	dc.b		nD1,	$02,	nCs1,	$01,	nB0,	$02,	nA0,	$02
	smpsStop

; PSG1 Data
invs_PSG1:
	smpsStop

; PSG2 Data
invs_PSG2:
	smpsStop

; PSG3 Data
invs_PSG3:
	smpsPSGform	$E7
	dc.b		nRst,	$0F,	$14
	smpsPSGvoice	$02
	smpsSetVol	$02
	dc.b		nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03,	nA6,	$04,	nA6,	$03,	nA6,	$04
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsPSGvoice	$01
	dc.b		nA6,	$03
	smpsPSGvoice	$02
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03,	nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03,	nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$02,	nA6,	$02
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsPSGvoice	$01
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsPSGvoice	$02
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$07
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03,	nA6,	$05,	nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03,	nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04
	smpsPSGvoice	$01
	dc.b		nA6,	$03
	smpsPSGvoice	$02
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04,	nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04,	nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$02,	nA6,	$02,	nA6,	$03
	smpsPSGvoice	$01
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsPSGvoice	$02
	dc.b		nA6,	$03,	nA6,	$08,	nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04,	nA6,	$03
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsPSGvoice	$01
	dc.b		nA6,	$03
	smpsPSGvoice	$02
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04,	nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$02,	nA6,	$02
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsPSGvoice	$01
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsPSGvoice	$02
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$07
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03,	nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04
	smpsPSGvoice	$01
	dc.b		nA6,	$03
	smpsPSGvoice	$02
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03,	nA6,	$04,	nA6,	$03,	nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04,	nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$02,	nA6,	$02,	nA6,	$03
	smpsPSGvoice	$01
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsPSGvoice	$02
	dc.b		nA6,	$03,	nA6,	$07,	nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$03,	nA6,	$04
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsPSGvoice	$01
	dc.b		nA6,	$03
	smpsPSGvoice	$02
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$04,	nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$02,	nA6,	$02
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsPSGvoice	$01
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsPSGvoice	$02
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$07
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03,	nA6,	$04,	nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04
	smpsPSGvoice	$01
	dc.b		nA6,	$03
	smpsPSGvoice	$02
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03,	nA6,	$04,	nA6,	$03,	nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04,	nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$02,	nA6,	$02,	nA6,	$03
	smpsPSGvoice	$01
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsPSGvoice	$02
	dc.b		nA6,	$03,	nA6,	$07,	nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03,	nA6,	$04,	nA6,	$03,	nA6,	$04
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$03,	nA6,	$04,	nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsPSGvoice	$01
	dc.b		nA6,	$03
	smpsPSGvoice	$02
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03,	nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$03,	nA6,	$04,	nA6,	$02,	nA6,	$02
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsPSGvoice	$01
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsPSGvoice	$02
	smpsSetVol	$01
	dc.b		nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$07
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03,	nA6,	$04,	nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$04,	nA6,	$03,	nA6,	$03
	smpsPSGvoice	$01
	dc.b		nA6,	$04
	smpsPSGvoice	$02
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03,	nA6,	$04,	nA6,	$03,	nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03,	nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6,	$03,	nA6,	$04,	nA6,	$03,	nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$02,	nA6,	$01,	nA6,	$04
	smpsPSGvoice	$01
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsPSGvoice	$02
	dc.b		nA6,	$03,	nA6,	$07,	nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03,	nA6,	$04,	nA6,	$03,	nA6,	$04
	dc.b		nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsSetVol	$01
	dc.b		nA6,	$03,	nA6,	$04,	nA6,	$04,	nA6,	$03
	smpsSetVol	$FF
	dc.b		nA6,	$04
	smpsPSGvoice	$01
	dc.b		nA6,	$03
	smpsPSGvoice	$02
	smpsSetVol	$01
	dc.b		nA6,	$04
	smpsSetVol	$FF
	dc.b		nA6
	smpsStop

invs_Voices:
	dc.b		;			Voice 00
	even
