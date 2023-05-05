; ===========================================================================
; ---------------------------------------------------------------------------
; Special Stage Level Select Theme
; ---------------------------------------------------------------------------

SpecialSelect_Header:
	sHeaderInit
	sHeaderPatch	SSL_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $35
	sHeaderDAC	SSL_DAC
	sHeaderFM	SSL_FM1, $00, $02
	sHeaderFM	SSL_FM2, $00, $04
	sHeaderFM	SSL_FM3, $00, $0E
	sHeaderFM	SSL_FM4, $00, $0E
	sHeaderFM	SSL_FM5, $00, $20
	sHeaderPSG	SSL_PSG2, $0C, $03, $00, VolEnv_0C
	sHeaderPSG	SSL_PSG1, $0C, $03, $00, VolEnv_0C
	sHeaderPSG	SSL_PSG3, $00, $03, $00, VolEnv_02

; ===========================================================================
; ---------------------------------------------------------------------------
; DAC
; ---------------------------------------------------------------------------

SSL_DAC:
	dc.b	$80,$18

	; B7 = Kick
	; C7 = Clap
	; C8 = Kick + Clap
	; $8A,$8B
	; 8C
	; $8D,$8E


SSL_DAC_Loop:
	sCall		SSL_DAC_Common
	dc.b $C8,$18
	sCall		SSL_DAC_Common
	dc.b $C8,$06,$8B,$0C,$06

	sLoop		$01,$07,SSL_DAC_Loop

	sCall		SSL_DAC_Common
	dc.b $C8,$18
	sCall		SSL_DAC_Common
	dc.b $C7,$18

	sCall		SSL_DAC_AIZ

SSL_DAC_Loop2:
	sCall		SSL_DAC_Common
	dc.b $C8,$18
	sCall		SSL_DAC_Common
	dc.b $C8,$06,$8B,$0C,$06

	sLoop		$01,$04,SSL_DAC_Loop2

	sJump		SSL_DAC_Loop

	; --- Common starting beat bar ---

SSL_DAC_Common:
	dc.b $B7,$0C,$8C,$06,$06
	dc.b $C8,$0C,$8C
	dc.b $B7,$0C,$8C
	sRet
	; --- A drum section from AIZ ---

SSL_DAC_AIZ:


SSL_Loop10:
	sCall		SSL_Call11
	sLoop		$00, $03, SSL_Loop10
	dc.b dKick, $0C, dHighMetalHit, $06, dLowTom, dKick, $0C, dMidTom
	dc.b $06, dLowMetalHit, dKick, $0C, dHighMetalHit, $06, dLowTom, dKick
	dc.b $0C, dSnare

SSL_Loop11:
	sCall		SSL_Call11
	sLoop		$00, $03, SSL_Loop11
	dc.b dSnare, dSnare, dSnare, dSnare, dKick, dHighTom, dMidTom, dLowTom
	dc.b dKick, dHigherMetalHit, $09, dHigherMetalHit, $02, dHigherMetalHit, $01, dHigherMetalHit
	dc.b $06, dHigherMetalHit, dHigherMetalHit, $12
	sRet

SSL_Call11:
	dc.b dKick, $0C, dHighMetalHit, $06, dLowTom, dKick, $0C, dMidTom
	dc.b $06, dLowMetalHit, dKick, $0C, dHighMetalHit, $06, dLowTom, dKick
	dc.b $0C, dHighTom, $06, dMetalHit
	sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 1
; ---------------------------------------------------------------------------

SSL_FM1:
	dc.b $80,$18

	sPatFM		$00

SSL_FM1_Loop:
	sCall		SSL_Bass1
	sCall		SSL_Bass2
	sLoop		$01,$03,SSL_FM1_Loop
	sCall		SSL_BassEnd
	sLoop		$02,$02,SSL_FM1_Loop

SSL_FM1_LoopOrg:
	dc.b nA2, $12, nE3, nA2, $0C, nG2, $12, nD3
	dc.b nG2, $0C
	sLoop		$01,$07,SSL_FM1_LoopOrg
	dc.b nA2, $12, nE3, nA2, $0C, nG2, $06, $0C
	dc.b nG3, $12, nA3, $0C


SSL_FM1_Loop2:
	sCall		SSL_Bass1
	sCall		SSL_Bass2
	sLoop		$01,$03,SSL_FM1_Loop2
	sCall		SSL_BassEnd
	sJump		SSL_FM1_Loop

	; --- Bass bar 1 ---

SSL_Bass1:
	dc.b $A7,$0F,$80,$03,$A7,$06,$80,$24
	dc.b $A0,$0A,$80,$02,$A2,$0A,$80,$02,$A7,$0A,$80,$02
	sRet
	; --- Bass bar 2 ---

SSL_Bass2:
	dc.b $A5,$0F,$80,$03,$A5,$06,$80,$12,$A5,$03,$80
	dc.b $A0,$0A,$80,$02,$A2,$0A,$80,$02,$A5,$0A,$80,$02,$A2,$0A,$80,$02
	sRet
	; --- Bass double end bar ---

SSL_BassEnd:
	dc.b $A7,$0F,$80,$03,$A7,$06,$80,$0C
	dc.b $A7,$04,$80,$02,$A7,$04,$80,$02
	dc.b $A8,$0C,$A2,$04,$80,$08,$9C,$18
	ssModZ80	$09,$01,$40,$FF
	dc.b $A0,$0C
	dc.b sHold
	sModOff
	dc.b $AC,$0C
	ssModZ80	$09,$01,$FC,$FF
	dc.b $A7,$16
	sModOff
	dc.b $80,$02,$A5,$0C,$80,$A5,$9F
	sRet
; ===========================================================================
; ---------------------------------------------------------------------------
; FM 5
; ---------------------------------------------------------------------------

SSL_FM5:
	dc.b $80,$18

	dc.b $80,$60,$80,$60,$80,$60,$80,$60
	dc.b $80,$60,$80,$60,$80,$60,$80,$60
	dc.b $80,$0C

SSL_FM5_Loop:
	ssVol		$18
	sCall		SSL_FluteStart
	dc.b $B1,$0C
	sPatFM		$05
	sCall		SSL_HornsBar1
	dc.b $80,$0C


	ssVol		$18
	sCall		SSL_FluteStart
	dc.b $B1,$0C
	sPatFM		$05
	sCall		SSL_HornsBar2
	dc.b $80,$0C


	ssVol		$18
	sCall		SSL_FluteStart
	dc.b $B1,$0C
	sPatFM		$05
	sCall		SSL_HornsBar1
	dc.b $80,$0C


	ssVol		$18
	sCall		SSL_FluteStart
	dc.b $B1,$0E,$80,$0A
	sCall		SSL_FluteEnd


	ssVol		$0C	; $1C <- For organ instrument
	sCall		SSL_OrganSection
	dc.b $80,$03

	dc.b $80,$60,$80,$60,$80,$60,$80,$60
	dc.b $80,$60,$80,$60,$80,$60,$80,$60

	ssVol		$1F
	saDetune		$F8

SSL_FM5_LeadLoop:
	dc.b $80,$04
	sCall		SSL_Lead
	dc.b nG5,$30,$80,$30
	sCall		SSL_Lead

	saTranspose	$FE
	dc.b nA5, $0C, nE5, $06, nA5, nRst, nB5, nRst
	dc.b nC6+2, $30, $80, $02
	saTranspose	$02
	sLoop		$01,$02,SSL_FM5_LeadLoop
	sModOff
	saDetune		$00

	sJump		SSL_FM5_Loop

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 2
; ---------------------------------------------------------------------------

SSL_FM2:
	sPatFM		$06
	saTranspose	$F4
	sPan		spCentre, $00
	ssVol		$06
	sCall		SSL_SphereUp
	sJump		SSL_FM2_SpheresStart

SSL_FM2_SpheresMain:
	sPan		spCentre, $00
	ssVol		$02
	sCall		SSL_Sphere

SSL_FM2_SpheresStart:
	saVolFM		$10
	sPan		spCentre, $00
	sCall		SSL_Sphere
	saVolFM		$F0

SSL_FM2_Spheres:
	saVolFM		$04
	sPan		spLeft, $00
	sCall		SSL_Sphere
	saVolFM		$10
	sPan		spCentre, $00
	sCall		SSL_Sphere
	saVolFM		$F0
	saVolFM		$04
	sPan		spRight, $00
	sCall		SSL_Sphere
	saVolFM		$10
	sPan		spCentre, $00
	sCall		SSL_Sphere
	saVolFM		$F0
	sLoop		$01,$02,SSL_FM2_Spheres
	dc.b $80,$60,$80,$60,$80,$48
	sLoop		$02,$02,SSL_FM2_SpheresMain
	sPan		spCentre, $00
	saTranspose	$0C

SSL_FM2_Loop:
	ssVol		$04
	sCall		SSL_FluteStart
	dc.b $B1,$0E,$80,$0A
	sPatFM		$04
	sCall		SSL_HornsBar1


	ssVol		$04
	sCall		SSL_FluteStart
	dc.b $B1,$0E,$80,$0A
	sPatFM		$04
	sCall		SSL_HornsBar2


	ssVol		$04
	sCall		SSL_FluteStart
	dc.b $B1,$0E,$80,$0A
	sPatFM		$04
	sCall		SSL_HornsBar1


	ssVol		$04
	sCall		SSL_FluteStart
	dc.b $B1,$0E,$80,$0A
	sCall		SSL_FluteEnd

	ssVol		$04	; $14 <- For organ instrument
	sCall		SSL_OrganSection
	dc.b $80,$03

	sPatFM		$06
	saTranspose	$F4

SSL_FM2B_SpheresMain:
	sPan		spCentre, $00
	ssVol		$02
	sCall		SSL_Sphere

	saVolFM		$10
	sPan		spCentre, $00
	sCall		SSL_Sphere
	saVolFM		$F0

SSL_FM2B_Spheres:
	saVolFM		$04
	sPan		spLeft, $00
	sCall		SSL_Sphere
	saVolFM		$10
	sPan		spCentre, $00
	sCall		SSL_Sphere
	saVolFM		$F0
	saVolFM		$04
	sPan		spRight, $00
	sCall		SSL_Sphere
	saVolFM		$10
	sPan		spCentre, $00
	sCall		SSL_Sphere
	saVolFM		$F0
	sLoop		$01,$02,SSL_FM2B_Spheres
	dc.b $80,$60,$80,$60,$80,$48
	sLoop		$02,$02,SSL_FM2B_SpheresMain
	sPan		spCentre, $00
	saTranspose	$0C

	ssVol		$17

SSL_FM2_LeadLoop:
	sCall		SSL_Lead
	dc.b nG5,$30,$80,$30
	sCall		SSL_Lead

	saTranspose	$FE
	dc.b nA5, $0C, nE5, $06, nA5, nRst, nB5, nRst
	dc.b nC6+2, $30, $80, $06
	saTranspose	$02
	sLoop		$01,$02,SSL_FM2_LeadLoop
	sModOff
	sJump		SSL_FM2_Loop

SSL_Lead:
	sPatFM		$07
	ssModZ80	$14, $01, $06, $06
	dc.b nA5, $0C, nE5, $06, nA5, nRst, nB5, nRst
	dc.b nC6, $02, sHold, nCs6, sHold, nD6, $08, nCs6
	dc.b $06, nB5, nRst, nA5, $0C, nB5
	sRet
	; --- Single Sphere ---

SSL_Sphere:
	ssModZ80	$01,$01,$41,$00
	dc.b nEb5,$08
	saVolFM		$05
	ssModZ80	$01, $01, $D0, $00
	dc.b nEb5,$04
	saVolFM		$FD
	sRet
	; --- Starting echo spheres ---

SSL_SphereUp:
	ssModZ80	$01,$01,$41,$00
	dc.b nEb5-$10,$06
	dc.b nEb5-$0C,$06
	dc.b nEb5-$08,$06
	dc.b nEb5-$04,$06
	dc.b nEb5,$08
	saVolFM		$05
	ssModZ80	$01, $01, $D0, $00
	dc.b nEb5,$04
	saVolFM		$FD
	sRet
	; --- Flute start bar ---

SSL_FluteStart:
	sPatFM		$01
	ssModZ80	$0E,$01,$30,$FF
	dc.b $B5,$0C
	dc.b sHold
	sModOff
	dc.b $B8,$04,$80,$08

	ssModZ80	$0E,$01,$C0,$FF
	dc.b $B5,$0C
	dc.b sHold
	sModOff
	dc.b $B1,$04,$80,$08

	dc.b $B3,$0C,$80,$06
	dc.b $AE,$0C,$80,$06
	sRet
	; --- Flute End bar ---

SSL_FluteEnd:
	sPatFM		$01
	dc.b $AC,$0C
	ssModZ80	$0D,$01,$E0,$FF
	dc.b $AE,$0C
	dc.b sHold
	sModOff
	dc.b $AC,$06,$80,$06
	ssModZ80	$01,$01,$18,$FF
	dc.b $B8,$04
	dc.b sHold
	sModOff
	dc.b $BA,$0E,$80,$06,$B8,$18
	sRet
	; --- Organ section from blue spheres ---

SSL_OrganSection:
	sPatFM		$02
	dc.b nA6, $66, nA5, $06, nA6, nA5, nA6, $0C
	dc.b nG6, $06, nE6, nD6, $0C, nD6, $02, nE6
	dc.b $04, nD6, $0C, nE6, nD6, nD5, $06, nB4
	dc.b nA4, nG4, nE4, nD4, nE4, nG4, nE4, nG4
	dc.b nA4, nB4, nA4, nB4, nD5, nD5, $03, nE5
	dc.b $09, nD5, $0C, nB4, $06, nA4, nB4, nD5
	dc.b nE5, nD5, nE5, nFs5, nG5, nA5, nB5, nCs6
	dc.b nD6, nCs6, nB5, nG6, nFs6, nE6, nFs6, nE6
	dc.b nD6, nFs6, nE6, nD6, nCs6, $04, nD6, nCs6
	dc.b nB5, $06, nA5, nFs5, nE5, nD5, nCs5, $04
	dc.b nD5, $06, nCs5, $08, nB4, $06, nA4, nG4
	dc.b $0C, nA4, $06, nG4, $0C, nFs4, nE4, nFs4
	dc.b $06, nD4, nE4, nFs4, nG4, nA4, nB4, nG4
	dc.b nA4, nCs5, nD5, nE5, nFs5, nG5, nFs5, nG5
	dc.b $03, nA5, $09, nG5, $06, nE5, $0C, nD5
	dc.b $06, nRst, nE5, nRst, nD5, nA4, nG4, sHold
	dc.b $0C, nFs4, $03, nF4, nE4
	sRet
	; --- Horns bar 1 ---

SSL_HornsBar1:
	ssVol		$18
	dc.b $B8,$07	;,$80,$05
	saVolFM		$18
	dc.b $05
	saVolFM		$E8
	dc.b $BA,$09	;,$80,$03
	saVolFM		$18
	dc.b $03
	saVolFM		$E8
	dc.b $B8,$07	;,$80,$05
	saVolFM		$18
	dc.b $05
	saVolFM		$E8

SSL_HornsEnd:
	dc.b $BF,$12	;,$80,$06
	saVolFM		$18
	dc.b $06
	saVolFM		$E8
	dc.b $BD,$18
	sRet
	; --- Horns bar 2 ---

SSL_HornsBar2:
	ssVol		$18
	dc.b $B8,$06,$BA,$06,$BD,$06,$BF,$06
	saVolFM		$08
	dc.b $06
	saVolFM		$08
	dc.b $06
	saVolFM		$F0
	sJump		SSL_HornsEnd

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 3
; ---------------------------------------------------------------------------

SSL_FM3:
	dc.b $80,$18
	sPan		spRight, $00
	sPatFM		$02

SSL_FM3_Loop:
	sCall		SSL_XyloBar12_Right
	saTranspose	$FE
	sCall		SSL_XyloBar12_Right
	saTranspose	$02
	sLoop		$01,$03,SSL_FM3_Loop
	sCall		SSL_XyloBar1_Right
	saTranspose	$01
	sCall		SSL_XyloBar2_Right
	saTranspose	$02
	sCall		SSL_XyloBar1_Right
	saTranspose	$FE
	sCall		SSL_XyloBar2_Right
	saTranspose	$FF
	sLoop		$02,$02,SSL_FM3_Loop

SSL_FM3_LoopOrg:
	sCall		SSL_XyloBar1_Right
	saTranspose	$FE
	sCall		SSL_XyloBar2_Right
	saTranspose	$02
	sLoop		$01,$08,SSL_FM3_LoopOrg

SSL_FM3_Loop2:
	sCall		SSL_XyloBar12_Right
	saTranspose	$FE
	sCall		SSL_XyloBar12_Right
	saTranspose	$02
	sLoop		$01,$03,SSL_FM3_Loop2
	sCall		SSL_XyloBar1_Right
	saTranspose	$01
	sCall		SSL_XyloBar2_Right
	saTranspose	$02
	sCall		SSL_XyloBar1_Right
	saTranspose	$FE
	sCall		SSL_XyloBar2_Right
	saTranspose	$FF
	sJump		SSL_FM3_Loop

	; --- Xylophone Right bars 1 and 2 together ---

SSL_XyloBar12_Right:
	sCall		SSL_XyloBar1_Right

	; --- Xylophone Right bar 2 ---

SSL_XyloBar2_Right:
	dc.b nCs4, $0C, nA3, $06, nA3, nA3, $0C, nE3, $06, nCs4, nCs4
	sRet
	; --- Xylophone Right bar 2 ---

SSL_XyloBar1_Right:
	dc.b nCs4, $0C, nA3, $06, nE3, nRst, nA3, nRst
	sRet
; ===========================================================================
; ---------------------------------------------------------------------------
; FM 4
; ---------------------------------------------------------------------------

SSL_FM4:
	dc.b $80,$18
	sPan		spLeft, $00
	sPatFM		$02

SSL_FM4_Loop:
	sCall		SSL_XyloBar12_Left
	saTranspose	$FE
	sCall		SSL_XyloBar12_Left
	saTranspose	$02
	sLoop		$01,$03,SSL_FM4_Loop
	sCall		SSL_XyloBar1_Left
	saTranspose	$01
	sCall		SSL_XyloBar2_Left
	saTranspose	$02
	sCall		SSL_XyloBar1_Left
	saTranspose	$FE
	sCall		SSL_XyloBar2_Left
	saTranspose	$FF
	sLoop		$02,$02,SSL_FM4_Loop

SSL_FM4_LoopOrg:
	sCall		SSL_XyloBar1_Left
	saTranspose	$FE
	sCall		SSL_XyloBar2_Left
	saTranspose	$02
	sLoop		$01,$08,SSL_FM4_LoopOrg

SSL_FM4_Loop2:
	sCall		SSL_XyloBar12_Left
	saTranspose	$FE
	sCall		SSL_XyloBar12_Left
	saTranspose	$02
	sLoop		$01,$03,SSL_FM4_Loop2
	sCall		SSL_XyloBar1_Left
	saTranspose	$01
	sCall		SSL_XyloBar2_Left
	saTranspose	$02
	sCall		SSL_XyloBar1_Left
	saTranspose	$FE
	sCall		SSL_XyloBar2_Left
	saTranspose	$FF
	sJump		SSL_FM4_Loop

	; --- Xylophone Left bars 1 and 2 together ---

SSL_XyloBar12_Left:
	sCall		SSL_XyloBar1_Left

	; --- Xylophone Left bar 2 ---

SSL_XyloBar2_Left:
	dc.b nE4, $12, nCs4, $06, nE4, $0C, nA3, $06, nA4, nE4
	sRet
	; --- Xylophone Left bar 2 ---

SSL_XyloBar1_Left:
	dc.b nE4, $0C, nA4, $06, nCs4, nRst, nE4, nRst
	sRet
; ===========================================================================
; ---------------------------------------------------------------------------
; PSG  1
; ---------------------------------------------------------------------------

SSL_PSG1:
	saDetune		$FF
	dc.b $80,$0C
	saVolPSG		$03

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG  2
; ---------------------------------------------------------------------------

SSL_PSG2:
	dc.b $80,$18
	sVolEnvPSG		$05

	saVolPSG		$08

	dc.b $80,$60

SSL_PSG2_Wait:
	dc.b $80,$60
	sLoop		$01,$16,SSL_PSG2_Wait

SSL_PSG2_FadeIn:
	dc.b $A2,$0C,sHold
	saVolPSG		$FF
	sLoop		$01,$08,SSL_PSG2_FadeIn
	dc.b sHold
	dc.b $A2,$60,$A0,$60,$9D,$60,$9B,$48
	dc.b $9B,$06,$9D,$9F,$A0
	dc.b $A2,$48,$A9,$18,$A7,$30,$A4,$18,$A0,$A2,$30,$A3,$A5,$A3

SSL_PSG2_FadeOut:
	dc.b $A2,$0C,sHold
	saVolPSG		$01
	sLoop		$01,$08,SSL_PSG2_FadeOut

	sJump		SSL_PSG2_Wait

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG  3
; ---------------------------------------------------------------------------

SSL_PSG3:
	dc.b $80,$18
	sNoisePSG		$E7

SSL_PSG3_Loop:
	sCall		SSL_PSG3_Hats
	sLoop		$01,$3F,SSL_PSG3_Loop
	dc.b $80,$18
	sJump		SSL_PSG3_Loop

	; --- Hat rythm ---

SSL_PSG3_Hats:
	sVolEnvPSG		$02
	dc.b nBb6,$06,$06
	sVolEnvPSG		$05
	dc.b $06
	sVolEnvPSG		$02
	dc.b $06
	sRet
; ===========================================================================
; ---------------------------------------------------------------------------
; Instruments
; ---------------------------------------------------------------------------

SSL_Patches:

	; 00 - Bass

	dc.b	$38
	dc.b	$70,$10,$70,$10, $DF,$BF,$1F,$1F, $00,$00,$01,$01
	dc.b	$00,$00,$00,$00, $FA,$F5,$F0,$F9, $2E,$3E,$24,$81

	; 01 - Organ/Flute Chord

	dc.b	$34
	dc.b	$58,$54,$32,$32, $1F,$15,$1F,$15, $0C,$03,$0A,$0D
	dc.b	$05,$0A,$04,$09, $1F,$09,$0F,$09, $1E,$90,$10,$92

	; 02 - Wooden Xylophone

	dc.b	$1C
	dc.b	$73,$72,$33,$32, $94,$99,$94,$99, $08,$0A,$08,$0A
	dc.b	$00,$05,$00,$05, $3F,$4F,$3F,$4F, $1E,$90,$19,$90

	; 03 - Organ

	dc.b	$3E
	dc.b	$07,$01,$02,$01, $1F,$1F,$1F,$1F, $0D,$06,$00,$00
	dc.b	$08,$06,$00,$00, $15,$0A,$0A,$0A, $1B,$88,$88,$88

	; 04 - Horn high

	dc.b	$3C
	dc.b	$31,$21,$31,$11, $18,$10,$1B,$10, $0C,$05,$0E,$08
	dc.b	$08,$08,$06,$03, $50,$09,$50,$09, $14,$80,$08,$80

	; 05 - Horn low

	dc.b	$34
	dc.b	$30,$30,$70,$70, $18,$10,$1B,$10, $0F,$05,$0F,$05
	dc.b	$08,$08,$08,$08, $80,$08,$80,$08, $0C,$80,$08,$98

	; 06 - Sphere Sound

	dc.b	$05
	dc.b	$07,$12,$22,$32, $0A,$0F,$0F,$0F, $00,$00,$00,$00
	dc.b	$00,$10,$10,$10, $0F,$0F,$0F,$0F, $21,$90,$90,$90

	; 07 - Blue Sphere's lead instrument

	dc.b	$34
	dc.b	$00,$02,$01,$01, $1F,$1F,$1F,$1F, $10,$06,$06,$06
	dc.b	$01,$06,$06,$06, $35,$1A,$15,$1A, $10,$80,$18,$80

  ; Saxaphone (Experimental)

	dc.b	$34
	dc.b	$44,$44,$34,$32, $1F,$10,$1F,$10, $0C,$03,$0A,$0D
	dc.b	$05,$0A,$04,$09, $1F,$09,$0F,$09, $1C,$90,$14,$94

; ===========================================================================
