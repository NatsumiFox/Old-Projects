Ree_Header:
	sHeaderInit
	sHeaderTick	$01
	sHeaderCh	$01
	sHeaderSFX	$80, ctbDAC, .DAC1, $00, $00

.DAC1	ssVol	-$40
	sCond	$06, dcoEQ, $01
	sJump	.bye
	sCond	$06, dcoEQ, $02
	sJump	.kys
	sCond	$07, dcoLO, $40
	sJump	.ree2
	sCond	$07, dcoLO, $80
	sJump	.ree3
	sCond	$07, dcoLO, $C0
	sJump	.ree4
	sCondOff

	dc.b dRee1, $27
	sStop

.ree2	dc.b dRee2, $2D
	sStop

.ree3	dc.b dRee3, $24
	sStop

.ree4	dc.b dRee4, $22
	sStop

.bye	dc.b dBye, $20
	sStop

.kys	dc.b dKys, $30
	sStop
