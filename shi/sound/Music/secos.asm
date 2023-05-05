woimagic_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	woimagic_Voices
	smpsHeaderChan	$07, $03
	smpsHeaderTempo	$01, $60
	smpsHeaderDAC	woimagic_DAC
	smpsHeaderFM	woimagic_FM1, $00, $00
	smpsHeaderFM	woimagic_FM6, $00, $00
	smpsHeaderFM	woimagic_FM3, $00, $00
	smpsHeaderFM	woimagic_FM4, $00, $00
	smpsHeaderFM	woimagic_FM5, $00, $00
	smpsHeaderFM	woimagic_FM2, $F4, $00
	smpsHeaderPSG	woimagic_PSG1, $DC, $00, $00, $00
	smpsHeaderPSG	woimagic_PSG2, $DC, $00, $00, $00
	smpsHeaderPSG	woimagic_PSG3, $DC, $00, $00, $00

woimagic_Voices:
	; Voice $00
	; $2D
	; $51, $61, $56, $64,	$2F, $2F, $2F, $2F
	; $0F, $0F, $0F, $0F,	$02, $02, $02, $02
	smpsVcAlgorithm	$05
	smpsVcFeedback	$05
	smpsVcDetune	$06, $05, $06, $05
	smpsVcCoarseFreq	$04, $06, $01, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$0F, $0F, $0F, $0F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0F, $0F, $0F, $0F
	smpsVcDecayRate2	$02, $02, $02, $02
	smpsVcDecayLevel	$03, $03, $03, $03
	smpsVcReleaseRate	$0B, $0B, $0A, $0F
	smpsVcTotalLevel	$00, $00, $00, $6B

	; Voice $01
	; $35
	; $22, $01, $01, $30,	$1C, $1B, $1B, $1C
	; $0E, $0F, $0E, $0A,	$01, $01, $01, $01
	smpsVcAlgorithm	$05
	smpsVcFeedback	$06
	smpsVcDetune	$03, $00, $00, $02
	smpsVcCoarseFreq	$00, $01, $01, $02
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1C, $1B, $1B, $1C
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $0E, $0F, $0E
	smpsVcDecayRate2	$01, $01, $01, $01
	smpsVcDecayLevel	$06, $06, $06, $07
	smpsVcReleaseRate	$0F, $0C, $0F, $0F
	smpsVcTotalLevel	$00, $00, $00, $30

	; Voice $02
	; $04
	; $2A, $11, $2A, $21,	$57, $57, $57, $57
	; $0A, $0C, $0C, $0F,	$01, $01, $01, $01
	smpsVcAlgorithm	$04
	smpsVcFeedback	$00
	smpsVcDetune	$02, $02, $01, $02
	smpsVcCoarseFreq	$01, $0A, $01, $0A
	smpsVcRateScale	$01, $01, $01, $01
	smpsVcAttackRate	$17, $17, $17, $17
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0F, $0C, $0C, $0A
	smpsVcDecayRate2	$01, $01, $01, $01
	smpsVcDecayLevel	$04, $04, $04, $04
	smpsVcReleaseRate	$07, $0B, $06, $0C
	smpsVcTotalLevel	$00, $40, $00, $20

	; Voice $03
	; $04
	; $2A, $11, $2A, $21,	$0C, $0C, $0C, $0C
	; $0A, $0C, $0C, $0F,	$01, $01, $01, $01
	smpsVcAlgorithm	$04
	smpsVcFeedback	$00
	smpsVcDetune	$02, $02, $01, $02
	smpsVcCoarseFreq	$01, $0A, $01, $0A
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$0C, $0C, $0C, $0C
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0F, $0C, $0C, $0A
	smpsVcDecayRate2	$01, $01, $01, $01
	smpsVcDecayLevel	$03, $03, $03, $03
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $40, $00, $20

woimagic_DAC:
	smpsStop

woimagic_FM1:
	smpsSetVol -(($02*4)+$10)&$7F
	smpsSetvoice	$00

woimagic_Loop1:
woimagic_Jump1:
	dc.b nAb2, $06, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3
	smpsLoop	$00, $08, woimagic_Loop1

woimagic_Loop2:
	dc.b nEb2, $06, nBb2, nCs3, nF3, nG3, nBb3, nCs4
	dc.b nF4, nG4, nBb4, nCs5, nF5, nCs2, nAb2, nB2
	dc.b nEb3, nE3, nAb3, nB3, nEb4, nE4, nAb4, nB4
	dc.b nEb5
	smpsLoop	$00, $04, woimagic_Loop2
	smpsJump	woimagic_Jump1

woimagic_FM2:
	smpsSetVol -(($01*4)+$10)&$7F
	smpsSetvoice	$01

woimagic_Loop3:
woimagic_Jump2:
	dc.b nAb3, $18, nEb4, nB4, nA4, nCs4, nFs3, nAb3
	dc.b $18, nEb4, nB4, nFs4, nCs4, nFs3
	smpsLoop	$00, $04, woimagic_Loop3

woimagic_Loop4:
	dc.b nEb3, $18, nBb3, nG4, nCs3, nB3, nEb4
	smpsLoop	$00, $04, woimagic_Loop4
	smpsJump	woimagic_Jump2

woimagic_FM3:
	smpsSetVol -(($01*4)+$10)&$7F
	smpsSetvoice	$02

woimagic_Jump3:
	smpsCall	woimagic_Call1
	smpsPan	 panRight, $00
	dc.b nEb4, $0C
	smpsFMAlterVol	$04
	dc.b nEb4, $0C
	smpsFMAlterVol	$FC
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	smpsPan	 panCentre, $00
	smpsFMAlterVol	$04
	dc.b nB4, $0C
	smpsFMAlterVol	$04
	dc.b nB4, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nE5, $0C
	smpsFMAlterVol	$04
	dc.b nE5, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsPan	 panRight, $00
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	dc.b nAb5, $0C
	smpsFMAlterVol	$04
	dc.b nAb5, $0C
	smpsFMAlterVol	$FC
	smpsPan	 panCentre, $00
	smpsFMAlterVol	$04
	dc.b nFs5, $0C
	smpsFMAlterVol	$04
	dc.b nFs5, $0C
	smpsFMAlterVol	$FC
	dc.b nE5, $0C
	smpsFMAlterVol	$04
	dc.b nE5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsCall	woimagic_Call1
	smpsPan	 panRight, $00
	dc.b nEb4, $0C
	smpsFMAlterVol	$04
	dc.b nEb4, $0C
	smpsFMAlterVol	$FC
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	smpsPan	 panCentre, $00
	smpsFMAlterVol	$04
	dc.b nB4, $0C
	smpsFMAlterVol	$04
	dc.b nB4, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nE5, $0C
	smpsFMAlterVol	$04
	dc.b nE5, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsPan	 panRight, $00
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	dc.b nAb5, $0C
	smpsFMAlterVol	$04
	dc.b nAb5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nFs5, $0C
	smpsFMAlterVol	$04
	dc.b nFs5, $0C
	smpsFMAlterVol	$FC
	dc.b nA5, $0C
	smpsFMAlterVol	$04
	dc.b nA5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nA5, $0C
	smpsFMAlterVol	$04
	dc.b nA5, $0C
	smpsFMAlterVol	$FC
	dc.b nA5, $0C
	smpsFMAlterVol	$04
	dc.b nA5, $0C
	smpsFMAlterVol	$FC

woimagic_Loop5:
	smpsPan	 panRight, $00
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	dc.b nD5, $0C
	smpsFMAlterVol	$04
	dc.b nD5, $0C
	smpsFMAlterVol	$FC
	smpsLoop	$00, $04, woimagic_Loop5
	smpsJump	woimagic_Jump3

woimagic_Call1:
	smpsPan	 panRight, $00
	dc.b nEb4, $0C
	smpsFMAlterVol	$04
	dc.b nEb4, $0C
	smpsFMAlterVol	$FC
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nB4, $0C
	smpsFMAlterVol	$04
	dc.b nB4, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nE5, $0C
	smpsFMAlterVol	$04
	dc.b nE5, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsPan	 panRight, $00
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	dc.b nB4, $0C
	smpsFMAlterVol	$04
	dc.b nB4, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nAb4, $0C
	smpsFMAlterVol	$04
	dc.b nAb4, $0C
	smpsFMAlterVol	$FC
	dc.b nA4, $0C
	smpsFMAlterVol	$04
	dc.b nA4, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nEb4, $0C
	smpsFMAlterVol	$04
	dc.b nEb4, $0C
	smpsFMAlterVol	$FC
	dc.b nEb4, $0C
	smpsFMAlterVol	$04
	dc.b nEb4, $0C
	smpsFMAlterVol	$FC
	smpsReturn

woimagic_FM4:
	smpsSetvoice	$02
	smpsSetVol -(($02*4)+$10)&$7F
	dc.b nRst, $06
	smpsAlterPitch	$F4

woimagic_Jump4:
	smpsCall	woimagic_Call2
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nEb4, $0C
	smpsFMAlterVol	$04
	dc.b nEb4, $0C
	smpsFMAlterVol	$FC
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nB4, $0C
	smpsFMAlterVol	$04
	dc.b nB4, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsPan	 panRight, $00
	dc.b nE5, $0C
	smpsFMAlterVol	$04
	dc.b nE5, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	dc.b nAb5, $0C
	smpsFMAlterVol	$04
	dc.b nAb5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nFs5, $0C
	smpsFMAlterVol	$04
	dc.b nFs5, $0C
	smpsFMAlterVol	$FC
	dc.b nE5, $0C
	smpsFMAlterVol	$04
	dc.b nE5, $0C
	smpsFMAlterVol	$FC
	smpsPan	 panRight, $00
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsCall	woimagic_Call2
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nEb4, $0C
	smpsFMAlterVol	$04
	dc.b nEb4, $0C
	smpsFMAlterVol	$FC
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nB4, $0C
	smpsFMAlterVol	$04
	dc.b nB4, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsPan	 panRight, $00
	dc.b nE5, $0C
	smpsFMAlterVol	$04
	dc.b nE5, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	dc.b nAb5, $0C
	smpsFMAlterVol	$04
	dc.b nAb5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nFs5, $0C
	smpsFMAlterVol	$04
	dc.b nFs5, $0C
	smpsFMAlterVol	$FC
	dc.b nA5, $0C
	smpsFMAlterVol	$04
	dc.b nA5, $0C
	smpsFMAlterVol	$FC
	smpsPan	 panRight, $00
	dc.b nA5, $0C
	smpsFMAlterVol	$04
	dc.b nA5, $0C
	smpsFMAlterVol	$FC
	dc.b nA5, $0C
	smpsFMAlterVol	$04
	dc.b nA5, $0C
	smpsFMAlterVol	$FC

woimagic_Loop6:
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsPan	 panRight, $00
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	dc.b nD5, $0C
	smpsFMAlterVol	$04
	dc.b nD5, $0C
	smpsFMAlterVol	$FC
	smpsLoop	$00, $04, woimagic_Loop6
	smpsJump	woimagic_Jump4

woimagic_Call2:
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nEb4, $0C
	smpsFMAlterVol	$04
	dc.b nEb4, $0C
	smpsFMAlterVol	$FC
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nB4, $0C
	smpsFMAlterVol	$04
	dc.b nB4, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsPan	 panRight, $00
	dc.b nE5, $0C
	smpsFMAlterVol	$04
	dc.b nE5, $0C
	smpsFMAlterVol	$FC
	dc.b nCs5, $0C
	smpsFMAlterVol	$04
	dc.b nCs5, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nEb5, $0C
	smpsFMAlterVol	$04
	dc.b nEb5, $0C
	smpsFMAlterVol	$FC
	dc.b nB4, $0C
	smpsFMAlterVol	$04
	dc.b nB4, $0C
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nAb4, $0C
	smpsFMAlterVol	$04
	dc.b nAb4, $0C
	smpsFMAlterVol	$FC
	dc.b nA4, $0C
	smpsFMAlterVol	$04
	dc.b nA4, $0C
	smpsFMAlterVol	$FC
	smpsPan	 panRight, $00
	dc.b nEb4, $0C
	smpsFMAlterVol	$04
	dc.b nEb4, $0C
	smpsFMAlterVol	$FC
	dc.b nEb4, $0C
	smpsFMAlterVol	$04
	dc.b nEb4, $0C
	smpsFMAlterVol	$FC
	smpsReturn

woimagic_FM5:
	smpsSetvoice	$03
	smpsSetVol -(($04*4)+$10)&$7F
	dc.b nRst, $09

woimagic_Jump5:
	smpsCall	woimagic_Call3
	smpsPan	 panRight, $00
	dc.b nEb5, $06, nEb4, nEb5, nEb4, nB4, $06, nB3
	dc.b nB4, nB3
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nAb4, $06, nAb3, nAb4, nAb3, nA4, $06, nA3
	dc.b nA4, nA3
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nEb4, $06, nEb3, nEb4, nEb3, nEb4, $06, nEb3
	dc.b nEb4, nEb3
	smpsCall	woimagic_Call3
	smpsPan	 panRight, $00
	dc.b nEb5, $06, nEb4, nEb5, nEb4, nAb5, $06, nAb4
	dc.b nAb5, nAb4
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nFs5, $06, nFs4, nFs5, nFs4, nE5, $06, nE4
	dc.b nE5, nE4
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nEb5, $06, nEb4, nEb5, nEb4, nCs5, $06, nCs4
	dc.b nCs5, nCs4
	smpsCall	woimagic_Call3
	smpsPan	 panRight, $00
	dc.b nEb5, $06, nEb4, nEb5, nEb4, nB4, $06, nB3
	dc.b nB4, nB3
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nAb4, $06, nAb3, nAb4, nAb3, nA4, $06, nA3
	dc.b nA4, nA3
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nEb4, $06, nEb3, nEb4, nEb3, nEb4, $06, nEb3
	dc.b nEb4, nEb3
	smpsCall	woimagic_Call3
	smpsPan	 panRight, $00
	dc.b nEb5, $06, nEb4, nEb5, nEb4, nAb5, $06, nAb4
	dc.b nAb5, nAb4
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nFs5, $06, nFs4, nFs5, nFs4, nA5, $06, nA4
	dc.b nA5, nA4
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nA5, $06, nA4, nA5, nA4, nA5, $06, nA4
	dc.b nA5, nA4

woimagic_Loop7:
	smpsPan	 panRight, $00
	dc.b nEb5, $06, nEb4, nEb5, nEb4, nEb5, $06, nEb4
	dc.b nEb5, nEb4
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nEb5, $06, nEb4, nEb5, nEb4, nCs5, $06, nCs4
	dc.b nCs5, nCs4
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nCs5, $06, nCs4, nCs5, nCs4, nD5, $06, nD4
	dc.b nD5, nD4
	smpsLoop	$00, $04, woimagic_Loop7
	smpsJump	woimagic_Jump5

woimagic_Call3:
	smpsPan	 panRight, $00
	dc.b nEb4, $06, nEb3, nEb4, nEb3, nEb5, $06, nEb4
	dc.b nEb5, nEb4
	smpsFMAlterVol	$04
	smpsPan	 panCentre, $00
	dc.b nB4, $06, nB3, nB4, nB3, nCs5, $06, nCs4
	dc.b nCs5, nCs4
	smpsFMAlterVol	$FC
	smpsPan	 panLeft, $00
	dc.b nE5, $06, nE4, nE5, nE4, nCs5, $06, nCs4
	dc.b nCs5, nCs4
	smpsReturn

woimagic_FM6:
	smpsSetvoice	$00
	smpsSetVol -(($03*4)+$10)&$7F
	dc.b nRst, $08
	smpsJump	woimagic_Jump1

woimagic_PSG1:
	smpsSetVol -($03)&$7F
	smpsPSGvoice	 sTone_28

woimagic_Loop8:
woimagic_Jump6:
	dc.b nAb5, $30, smpsNoAttack, $18, nFs5, $30, nA5, $18
	dc.b nAb5, $30, smpsNoAttack, $18, nA5, nB5, nA5
	smpsLoop	$00, $04, woimagic_Loop8
	dc.b nF5, $0C, nG5, $04, nF5, nEb5, nF5, $0C
	dc.b nG5, nAb5, nBb5, nB5, nBb5, $04, nB5, nBb5
	dc.b nAb5, $0C, nG5, nAb5, nBb5, nAb5, nG5, $04
	dc.b nAb5, nG5, nF5, $0C, nEb5, nF5, nG5, nF5
	dc.b nEb5, $04, nF5, nEb5, nCs5, $0C, nB4, nCs5
	dc.b nEb5, nEb5, nF5, $04, nEb5, nCs5, nEb5, $0C
	dc.b nF5, nG5, nAb5, nBb5, nAb5, $04, nBb5, nAb5
	dc.b nG5, $0C, nF5, nG5, nAb5, nG5, nF5, $04
	dc.b nG5, nF5, nEb5, $0C, nCs5, nEb5, nF5, nEb5
	dc.b nCs5, $04, nEb5, nCs5, nB4, $0C, nA4, nB4
	dc.b nCs5
	smpsJump	woimagic_Jump6

woimagic_PSG2:
	smpsSetVol -($03)&$7F
	smpsPSGvoice	 sTone_28

woimagic_Loop9:
woimagic_Jump7:
	dc.b nEb5, $30, smpsNoAttack, $18, nCs5, $30, nE5, $18
	dc.b nEb5, $30, smpsNoAttack, $18, nE5, nFs5, nE5
	smpsLoop	$00, $04, woimagic_Loop9
	smpsPSGAlterVol	$04
	dc.b nRst, $07, nF5, $0C, nG5, $04, nF5, nEb5
	dc.b nF5, $0C, nG5, nAb5, nBb5, nB5, nBb5, $04
	dc.b nB5, nBb5, nAb5, $0C, nG5, nAb5, nBb5, nAb5
	dc.b nG5, $04, nAb5, nG5, nF5, $0C, nEb5, nF5
	dc.b nG5, nF5, nEb5, $04, nF5, nEb5, nCs5, $0C
	dc.b nB4, nCs5, nEb5, $05
	smpsPSGAlterVol	$FC
	dc.b nG5, $0C, nAb5, $04, nG5, nF5, nG5, $0C
	dc.b nAb5, nBb5, nB5, nCs6, nB5, $04, nCs6, nB5
	dc.b nBb5, $0C, nAb5, nBb5, nB5, nBb5, nAb5, $04
	dc.b nBb5, nAb5, nG5, $0C, nF5, nG5, nAb5, nG5
	dc.b nF5, $04, nG5, nF5, nEb5, $0C, nCs5, nEb5
	dc.b nE5
	smpsJump	woimagic_Jump7

woimagic_PSG3:
	smpsPSGvoice	 sTone_28
	smpsAlterNote	$03
	smpsSetVol -($04)&$7F
	dc.b nRst, $09
	smpsJump	woimagic_Jump6
