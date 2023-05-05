ResSon_Header:
	sHeaderInit	; made by Natsumi
	sHeaderPatchUniv
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $06

	sHeaderDAC	ResSon_DAC
	sHeaderFM	ResSon_FM1,	$00, $12
	sHeaderFM	ResSon_FM2,	$0C, $16
	sHeaderFM	ResSon_FM3,	$0C, $16
	sHeaderFM	ResSon_FM4,	$0C, $16
	sHeaderFM	ResSon_FM5,	$0C, $1A
	sHeaderPSG	ResSon_PSG1,	$0C, $02, $00, VolEnv_03
	sHeaderPSG	ResSon_PSG2,	$0C, $02, $00, VolEnv_03
	sHeaderPSG	ResTie_PSG3,	$00, $05, $00, $00

; DAC Data
ResSon_DAC:
	sCall		ResTie_DAC_0
	dc.b dWoo, $18
	sStop

; FM1 Data
ResSon_FM1:
	sPatFM		$15
	sJump		ResTie_FM1_0

; FM2 Data
ResSon_FM2:
	sPatFM		$08
	saDetune	$03
	sPan		spCentre, $00

.j0	dc.b nD3, $0E, $06, $07, $07, nRst, nD3, $08
	saVolFM		$08

.voldw1	dc.b nD3, $06, nRst, $02
	saVolFM		$04
	sLoop		$00, $04, .voldw1
	saVolFM		-$08-(4*4)

	dc.b nE3, $07, $07, nRst, $06, $07, $09
	saVolFM		$08

.voldw2	dc.b nE3, $06, nRst, $02
	saVolFM		$04
	sLoop		$00, $04, .voldw2
	saVolFM		-$08-(4*4)

	dc.b nE3, $06, nG3, $07, nA3, $0F
	saVolFM		$08

.voldw3	dc.b nA3, $06, nRst, $02
	saVolFM		$04
	sLoop		$00, $04, .voldw3
	saVolFM		-$08-(4*4)

	dc.b nRst, $07
.voldw4	dc.b nA3, $0E, nRst, $06
	saVolFM		$08
	sLoop		$00, $04, .voldw4
	dc.b nRst, $02
	sStop

; FM3 Data
ResSon_FM3:
	saDetune	$FF
	sPatFM		$01
	sPan		spCentre, $00
	dc.b nC3, $0E, $06, $07, nB2, nRst, nB2, $08
	saVolFM		$08

.voldw1	dc.b nB2, $06, nRst, $02
	saVolFM		$04
	sLoop		$00, $04, .voldw1
	saVolFM		-$08-(4*4)

	dc.b nD3, $07, $07, nRst, $06, $07, $09
	saVolFM		$08

.voldw2	dc.b nD3, $06, nRst, $02
	saVolFM		$04
	sLoop		$00, $04, .voldw2
	saVolFM		-$08-(4*4)

	dc.b nD3, $06, nE3, $07, nG3, $0F
	saVolFM		$08

.voldw3	dc.b nG3, $06, nRst, $02
	saVolFM		$04
	sLoop		$00, $04, .voldw3
	saVolFM		-$08-(4*4)

	dc.b nRst, $07
.voldw4	dc.b nG3, $0E, nRst, $06
	saVolFM		$08
	sLoop		$00, $04, .voldw4
	dc.b nRst, $02
	sStop

; FM4 Data
ResSon_FM4:
	saDetune	$01
	sPatFM		$01
	sPan		spCentre, $00
	dc.b nG2, $0E, $06, $07, $07, nRst, nG2, $08
	saVolFM		$08

.voldw1	dc.b nG2, $06, nRst, $02
	saVolFM		$04
	sLoop		$00, $04, .voldw1
	saVolFM		-$08-(4*4)

	dc.b nA2, $07, $07, nRst, $06, $07, $09
	saVolFM		$08

.voldw2	dc.b nA2, $06, nRst, $02
	saVolFM		$04
	sLoop		$00, $04, .voldw2
	saVolFM		-$08-(4*4)

	dc.b nA2, $06, nC3, $07, nD3, $0F
	saVolFM		$08

.voldw3	dc.b nD3, $06, nRst, $02
	saVolFM		$04
	sLoop		$00, $04, .voldw3
	saVolFM		-$08-(4*4)

	dc.b nRst, $07
.voldw4	dc.b nD3, $0E, nRst, $06
	saVolFM		$08
	sLoop		$00, $04, .voldw4
	dc.b nRst, $02
	sStop

; FM5 Data
ResSon_FM5:
	sPan		spCentre, $00
	sVolEnvPSG	VolEnv_03
	dc.b nRst, $01
	sPatFM		$01
	sJump		ResSon_FM2.j0

; PSG1 Data
ResSon_PSG1:
	sCall		ResSon_PSG1_0
	saVolPSG	-$07
	ssModZ80	$06, $01, $10, $FF
	dc.b nA1, $14
	sModOff
	dc.b nA0, $08
	sStop

ResSon_PSG1_0:
	dc.b nA1, $0E, $06, $07, $07, nRst, nA1, $6C, $06, nBb1, $07, nB1
	dc.b $36
	saVolPSG	$02
	dc.b nA1, $0E, nRst, $06
	saVolPSG	$03
	dc.b nA1, $0E, nRst, $06
	saVolPSG	$04
	dc.b nA1, $0E, nRst, $06, nA1, $0E
	sRet

; PSG2 Data
ResSon_PSG2:
	sCall		ResSon_PSG2_0
	saVolPSG	-$04
	ssModZ80	$06, $01, $10, $FF
	dc.b nE2, $14
	sModOff
	dc.b nA1, $08
	sStop

ResSon_PSG2_0:
	dc.b nB1, $0E, $06, $07, nA1, nRst, nD2, $28, nB1, $07, nC2, nCs2
	dc.b $06, nD2, $07, $29, $06, nEb2, $07, nE2, $2F, nRst, $07
	saVolPSG	$02
	dc.b nE2, $0E, nRst, $06
	saVolPSG	$03
	dc.b nE2, $0E, nRst, $06
	saVolPSG	$04
	dc.b nE2, $0D, nRst, $07, nE2, $0D
	sRet

; PSG3 Data
ResSon_PSG3:
	sNoisePSG	$E7
	dc.b nRst, $0E, nBb6

ResSon_Loop04:
	dc.b $0D, $0E, $0D
	sVolEnvPSG	VolEnv_04
	dc.b $0E
	sVolEnvPSG	VolEnv_01
	sLoop		$00, $03, ResSon_Loop04
	dc.b $0D, $0E, $0D
	sStop

