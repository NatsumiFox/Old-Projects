soundA9_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, ctbDAC, .dac1, $00, $00

.dac1	ssVol	-$20
	sModePitchDAC
	sVoice	dHidden
	sCond	7, dcoEQ, $01
	sJump	.1
	sCond	7, dcoEQ, $02
	sJump	.2
	sCond	7, dcoEQ, $03
	sJump	.3
	sCond	7, dcoEQ, $04
	sJump	.4
	sCondOff

	dc.b nE4, $2C
	sStop

.4	dc.b nC4, $40
	sStop

.3	dc.b nA3, $50
	sStop

.2	dc.b nFs3, $60
	sStop

.1	dc.b nD3, $70
	sStop
