ResTai_Header:
	sHeaderInit	; made by Natsumi
	sHeaderPatch	ResTie_Voices
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $06

	sHeaderDAC	ResTai_DAC
	sHeaderFM	ResTie_FM1,	$00, $12
	sHeaderFM	ResTai_FM2,	$0C, $18
	sHeaderFM	ResTai_FM3,	$0C, $18
	sHeaderFM	ResTai_FM4,	$00, $1C
	sHeaderFM	ResTai_FM5,	$0C, $1C
	sHeaderPSG	ResTai_PSG1,	$0C, $02, $00, VolEnv_03
	sHeaderPSG	ResTai_PSG2,	$0C, $02, $00, VolEnv_03
	sHeaderPSG	ResTie_PSG3,	$00, $05, $00, $00

; DAC Data
ResTai_DAC:
	sCall		ResTie_DAC_0
	dc.b dComeOn, $18
	sStop

; FM5 Data
ResTai_FM5:
	saDetune	$03
	sVolEnvPSG	VolEnv_03
	dc.b nRst, $01

; FM2 Data
ResTai_FM2:
.j0	sPatFM		$02
	sPan		spCentre, $00

	ssModZ80	$04, $01, $03, $05
	dc.b nD3, $0E, $06, $07, $07, nRst
	ssModZ80	$01, $01, $0C, $02
	dc.b $28

	ssModZ80	$04, $01, $03, $05
	dc.b nE3, $07, $07, nRst, $06, $07
	ssModZ80	$01, $01, $0C, $02
	dc.b $29

	ssModZ80	$04, $01, $03, $05
	dc.b nE3, $06, nG3, $07
	ssModZ80	$01, $01, $0C, $02
	dc.b nA3, $2F

	dc.b nRst, $07
.voldw	dc.b nA3, $0E, nRst, $06
	saVolFM		$08
	sLoop		$00, $04, .voldw
	dc.b nRst, $02
	sStop

; FM3 Data
ResTai_FM3:
	sPatFM		$02
	sPan		spCentre, $00

	ssModZ80	$02, $01, $04, $04
	dc.b nC3, $0E, $06, $07, nB2, nRst
	ssModZ80	$04, $01, $0F, $02
	dc.b $28

	ssModZ80	$02, $01, $04, $04
	dc.b nD3, $07, $07, nRst, $06, $07
	ssModZ80	$04, $01, $0F, $02
	dc.b $29

	ssModZ80	$02, $01, $04, $04
	dc.b nD3, $06, nE3, $07
	ssModZ80	$04, $01, $0F, $02
	dc.b nG3, $2F

	dc.b nRst, $07
.voldw	dc.b nG3, $0E, nRst, $06
	saVolFM		$08
	sLoop		$00, $04, .voldw
	dc.b nRst, $02
	sStop

; FM4 Data
ResTai_FM4:
	sPatFM		$04
	sPan		spCentre, $00

	ssModZ80	$02, $01, $02, $06
	dc.b nG2, $0E, $06, $07, $07, nRst
	ssModZ80	$01, $01, $0C, $02
	dc.b $28

	ssModZ80	$02, $01, $02, $06
	dc.b nA2, $07, $07, nRst, $06, $07
	ssModZ80	$01, $01, $0C, $02
	dc.b $29

	ssModZ80	$02, $01, $02, $06
	dc.b nA2, $06, nC3, $07
	ssModZ80	$01, $01, $0C, $02
	dc.b nD3, $2F

	dc.b nRst, $07+$0c

	sModOff
	sPatFM		$03
	sPan		spRight, $00
	dc.b nE6, $05, nG6, $05, nC7, $0E
	sPan		spLeft, $00
	dc.b nE6, $05, nG6, $05, nC7, $0E
	sPan		spCentre, $00
	dc.b nE6, $05, nG6, $05, nC7, $0E
	sStop

ResTai_PSG1:
	sCall		ResSon_PSG1_0
	sStop

ResTai_PSG2:
	sCall		ResSon_PSG2_0
	sStop
