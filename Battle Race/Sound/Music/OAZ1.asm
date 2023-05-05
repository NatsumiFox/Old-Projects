; ===========================================================================
; ---------------------------------------------------------------------------
; Ominous Alcazar Zone - Act 1
; ---------------------------------------------------------------------------
MasterVolOAZ = $04

OAZ1_Header:
		sHeaderInit
		sHeaderPatch	OAZ1MG_Patches
		sHeaderCh	$06, $03
		sHeaderTempo	$01, $A0
		sHeaderDAC	OAZ1_DAC
		sHeaderFM	OAZ1_FM1, $00, $00
		sHeaderFM	OAZ1_FM2, $00, $00
		sHeaderFM	OAZ1_FM3, $00, $00
		sHeaderFM	OAZ1_FM4, $00, $00
		sHeaderFM	OAZ1_FM5, $00, $00
		sHeaderPSG	OAZ1_PSG1, $0C, $00, $00, VolEnv_00
		sHeaderPSG	OAZ1_PSG2, $0C, $00, $00, VolEnv_00
		sHeaderPSG	OAZ1_PSG3, $00, $00, $00, VolEnv_00

; ===========================================================================
; ---------------------------------------------------------------------------
; DAC
; ---------------------------------------------------------------------------

	dc.b	$80,$10
		dc.b	$81							; Snare
		dc.b	$82,$83,$84,$85						; Bongo
		dc.b	$86,$87,$88						; kick/snare/kick+crash
		dc.b	$89							; silent hat
		dc.b	$8A,$8B							; Wood blocks
		dc.b	$8C							; silent block
		dc.b	$8D,$8E							; steel block?
		dc.b	$8F							; clap
		dc.b	$90,$91,$92,$93						; toms
		dc.b	$94,$95,$96,$97						; snares (phil collins kind...)
		dc.b	$98,$99,$9A						; timpanis
		dc.b	$9B							; snare
		dc.b	$9C,$9D,$9E,$9F,$A0,$A1,$A2,$A3,$A4			; CNZ
		dc.b	$A5,$A6,$A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,$B0,$B1	; LBZ
		dc.b	$B2,$B3							; Unused snares (similar to $B0)
		dc.b	$B4,$B5,$B6,$B7						; Act 1 boss/Knuckles (and below)
		dc.b	$B8,$B9
		dc.b	$BA,$BB,$BC,$BD,$BE,$BF,$C0,$C1,$C2,$C3,$C4,$C5,$C6
		sStop

OAZ1_DAC:
		dc.b	$80,$60,$80,$60

OAZ1_DAC_Knocks:
		dc.b	$80,$06,$8C,$06
		sLoop	$00,$03,OAZ1_DAC_Knocks
		dc.b	$80,$06,$8C,$03,$03
		sLoop	$01,$04,OAZ1_DAC_Knocks
		sJump	OAZ1_DAC_StartLoop

OAZ1_DAC_MainLoop:
		sCall	OAZ1_DAC_Intro
		sCall	OAZ1_DAC_Intro
		sCall	OAZ1_DAC_Intro
		sCall	OAZ1_DAC_Intro
		sLoop	$00,$03,OAZ1_DAC_MainLoop

OAZ1_DAC_StartLoop:
		sCall	OAZ1_DAC_Intro
		sCall	OAZ1_DAC_Intro
		sCall	OAZ1_DAC_Intro
		sCall	OAZ1_DAC_Buildup
		sJump	OAZ1_DAC_ChorusLoop

OAZ1_DAC_VerseLoop:
		sCall	OAZ1_DAC_Verse01
		sCall	OAZ1_DAC_Verse02
		sCall	OAZ1_DAC_Verse01B
		sCall	OAZ1_DAC_Verse02B
		sLoop	$00,$02,OAZ1_DAC_VerseLoop

OAZ1_DAC_ChorusLoop:
		sCall	OAZ1_DAC_Chorus01
		sCall	OAZ1_DAC_Chorus02
		sCall	OAZ1_DAC_Chorus03
		sCall	OAZ1_DAC_Chorus02
		sCall	OAZ1_DAC_Chorus01
		sCall	OAZ1_DAC_Chorus02
		sCall	OAZ1_DAC_Chorus03
		sCall	OAZ1_DAC_ChorusEnd
	;	sLoop	$01,$02,OAZ1_DAC_VerseLoop

OAZ1_DAC_VerseLoop2:
		sCall	OAZ1_DAC_Verse01
		sCall	OAZ1_DAC_Verse02
		sCall	OAZ1_DAC_Verse01B
		sCall	OAZ1_DAC_Verse02B
		sLoop	$00,$02,OAZ1_DAC_VerseLoop2
		sCall	OAZ1_DAC_Chorus01
		sCall	OAZ1_DAC_Chorus02
		sCall	OAZ1_DAC_Chorus03
		sCall	OAZ1_DAC_Chorus02
		sCall	OAZ1_DAC_Chorus01
		sCall	OAZ1_DAC_Chorus02
		sCall	OAZ1_DAC_Chorus03
		dc.b	$C9,$06,$8C,$80,$0C,$80,$C9
		sJump	OAZ1_DAC_MainLoop

	; --- Intro ---

OAZ1_DAC_Intro:
		dc.b	dKick
		dc.b	$09
		dc.b	$03
		dc.b	dQuickLooseSnare
		dc.b	$06
		dc.b	dKick
		dc.b	$09
		dc.b	dDanceStyleKick
		dc.b	$03
		dc.b	dKick
		dc.b	$03
		dc.b	$03
		dc.b	dQuickLooseSnare
		dc.b	$06
		dc.b	dKick
		dc.b	$03
		dc.b	dQuickLooseSnare
		dc.b	$03
		sRet

	; --- Buildup to chorus ---

OAZ1_DAC_Buildup:
		sPan	$80,$00
		dc.b	dLowestPowerKickHit,$06
		sPan	$C0,$00
		dc.b	dLowestPowerKickHit,$06
		sPan	$40,$00
		dc.b	dHipHopHitKick,$06
		sPan	$C0,$00
		dc.b	dHipHopHitKick,$06
		sPan	$80,$00
		dc.b	dHipHopHitPowerKick,$06
		sPan	$C0,$00
		dc.b	dHipHopHitPowerKick,$06
		sPan	$40,$00
		dc.b	dPowerKickHit,$06
		sPan	$C0,$00
		dc.b	$A2,$06
		sRet

	; --- Chorus ---

OAZ1_DAC_Chorus01:
		dc.b	$88
		dc.b	$09
		dc.b	dKick
		dc.b	$03
		dc.b	dQuickLooseSnare
		dc.b	$06
		dc.b	dKick
		dc.b	$03
		dc.b	dDanceStyleKick
		dc.b	$06
		dc.b	dKick
		dc.b	$03
		dc.b	dDanceStyleKick
		dc.b	dKick
		dc.b	dQuickLooseSnare
		dc.b	$06
		dc.b	$93
		dc.b	$03
		dc.b	dDanceStyleKick
		dc.b	$03
		sRet

OAZ1_DAC_Chorus02:
		dc.b	dKick
		dc.b	$09
		dc.b	dKick
		dc.b	$03
		dc.b	dQuickLooseSnare
		dc.b	$06
		dc.b	dDanceStyleKick
		dc.b	$03
		dc.b	dKick
		dc.b	$93
		dc.b	dKick
		dc.b	dDanceStyleKick
		dc.b	dKick
		dc.b	dQuickLooseSnare
		dc.b	$06
		dc.b	dBassHey
		dc.b	$06
		sRet

OAZ1_DAC_Chorus03:
		dc.b	dKick
		dc.b	$09
		dc.b	dKick
		dc.b	$03
		dc.b	dQuickLooseSnare
		dc.b	$06
		dc.b	dKick
		dc.b	$03
		dc.b	dDanceStyleKick
		dc.b	$06
		dc.b	dKick
		dc.b	$03
		dc.b	dDanceStyleKick
		dc.b	dKick
		dc.b	dQuickLooseSnare
		dc.b	$06
		dc.b	$93
		dc.b	$03
		dc.b	dDanceStyleKick
		dc.b	$03
		sRet

OAZ1_DAC_ChorusEnd:
		dc.b	$C9,$0C,$C9,$C9,$C9
		sRet

	; --- Verse ---

OAZ1_DAC_Verse01:
		dc.b	$88
		dc.b	$09
		dc.b	dKick
		dc.b	$03
		dc.b	dQuickLooseSnare
		dc.b	$09
		dc.b	dDanceStyleKick
		dc.b	$03
		dc.b	dKick
		dc.b	dDanceStyleKick
		dc.b	dKick
		dc.b	$06
		dc.b	dQuickLooseSnare
		dc.b	$09
		dc.b	dDanceStyleKick
		dc.b	$03
		sRet

OAZ1_DAC_Verse02:
		dc.b	dKick
		dc.b	$09
		dc.b	dKick
		dc.b	$03
		dc.b	dQuickLooseSnare
		dc.b	$09
		dc.b	dDanceStyleKick
		dc.b	$03
		dc.b	dKick
		dc.b	dDanceStyleKick
		dc.b	dKick
		dc.b	$06
		dc.b	dQuickLooseSnare
		dc.b	$06
	;	dc.b	dDanceStyleKick
		dc.b	dPowerKickHit
		dc.b	$06
		sRet

OAZ1_DAC_Verse01B:
		dc.b	dHipHopHitKick
	;	dc.b	$88
		dc.b	$09
		dc.b	dKick
		dc.b	$03
		dc.b	dQuickLooseSnare
		dc.b	$09
		dc.b	dDanceStyleKick
		dc.b	$03
		dc.b	dKick
		dc.b	dDanceStyleKick
		dc.b	dKick
		dc.b	$06
		dc.b	dQuickLooseSnare
		dc.b	$09
		dc.b	dDanceStyleKick
		dc.b	$03
		sRet

OAZ1_DAC_Verse02B:
		dc.b	dKick
		dc.b	$09
		dc.b	dKick
		dc.b	$03
		dc.b	dQuickLooseSnare
		dc.b	$09
		dc.b	dDanceStyleKick
		dc.b	$03
		dc.b	dKick
		dc.b	dDanceStyleKick
		dc.b	dKick
		dc.b	$06
		dc.b	dQuickLooseSnare
		dc.b	$09
		dc.b	dDanceStyleKick
		dc.b	$03
		sRet
; ===========================================================================
; ---------------------------------------------------------------------------
; Amplitude Modulation subroutines
; ---------------------------------------------------------------------------

	; --- 30 ticks amplitude only ---

OAZ1_AM30_Loop:
		saVolFM	$06			; fast out/in
		dc.b	$E7,$01
		saVolFM	$06
		dc.b	$E7,$01
		saVolFM	$FA
		dc.b	$E7,$01
		saVolFM	$FA
		dc.b	$E7,$01

OAZ1_AM30:
		saVolFM	$04			; Slow out/in
		dc.b	$E7,$01
		saVolFM	$04
		dc.b	$E7,$01
		saVolFM	$04
		dc.b	$E7,$01
		saVolFM	$FC
		dc.b	$E7,$01
		saVolFM	$FC
		dc.b	$E7,$01
		saVolFM	$FC
		dc.b	$E7,$01

		sLoop	$00,$05,OAZ1_AM30_Loop

		saVolFM	$06			; just a single one to sync it up to 30
		dc.b	$E7,$01
		saVolFM	$FA
		sRet

	; --- 30 ticks amplitude & panning ---

OAZ1_AMPM30_Loop:
		saVolFM	$06			; fast out/in
		dc.b	$E7,$01
		sPan	$C0,$00
		saVolFM	$06
		dc.b	$E7,$01
		sPan	$80,$00
		saVolFM	$FA
		dc.b	$E7,$01
		saVolFM	$FA
		dc.b	$E7,$01

OAZ1_AMPM30:
		saVolFM	$04			; Slow out/in
		dc.b	$E7,$01
		saVolFM	$04
		dc.b	$E7,$01
		sPan	$C0,$00
		saVolFM	$04
		dc.b	$E7,$01
		sPan	$40,$00
		saVolFM	$FC
		dc.b	$E7,$01
		saVolFM	$FC
		dc.b	$E7,$01
		saVolFM	$FC
		dc.b	$E7,$01

		sLoop	$00,$05,OAZ1_AMPM30_Loop

		saVolFM	$06			; just a single one to sync it up to 30
		dc.b	$E7,$01
		saVolFM	$FA
		sPan	$80,$00
		sRet

	; --- 30 ticks amplitude & panning (reversed/negated side though) ---

OAZ1_AMPM30_NEG_Loop:
		saVolFM	$06			; fast out/in
		dc.b	$E7,$01
		sPan	$C0,$00
		saVolFM	$06
		dc.b	$E7,$01
		sPan	$40,$00
		saVolFM	$FA
		dc.b	$E7,$01
		saVolFM	$FA
		dc.b	$E7,$01

OAZ1_AMPM30_NEG:
		saVolFM	$04			; Slow out/in
		dc.b	$E7,$01
		saVolFM	$04
		dc.b	$E7,$01
		sPan	$C0,$00
		saVolFM	$04
		dc.b	$E7,$01
		sPan	$80,$00
		saVolFM	$FC
		dc.b	$E7,$01
		saVolFM	$FC
		dc.b	$E7,$01
		saVolFM	$FC
		dc.b	$E7,$01

		sLoop	$00,$05,OAZ1_AMPM30_NEG_Loop

		saVolFM	$06			; just a single one to sync it up to 30
		dc.b	$E7,$01
		saVolFM	$FA
		sPan	$40,$00
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 1
; ---------------------------------------------------------------------------

OAZ1_FM1:
		sCall	OAZ1_FM1_Bzow
		sJump	OAZ1_FM1_Start

OAZ1_FM1_MainLoop:
		sCall	OAZ1_FM1_BassIntro
		dc.b	$9C,$12,$A9,$0C,$9C,$06,$A9,$06,$A7
		sCall	OAZ1_FM1_BassIntro
		dc.b	$9C,$12,$A9,$0C,$9C,$06,$A9,$06,$A7

OAZ1_FM1_Start:
		sCall	OAZ1_FM1_BassIntro
		dc.b	$9C,$12,$A9,$0C,$9C,$06,$A9,$06,$A7
		sCall	OAZ1_FM1_BassIntro

OAZ1_FM1_Loop:
		dc.b	$9C,$06,$80,$06
		sLoop	$00,$04,OAZ1_FM1_Loop

		sPatFM	$00
		ssVol	MasterVolOAZ+$04

OAZ1_FM1_LoopChorus:
		sCall	OAZ1_FM1_BassChorus01
		sCall	OAZ1_FM1_BassChorus02
		sCall	OAZ1_FM1_BassChorus01
		sCall	OAZ1_FM1_BassChorusEnd

OAZ1_FM1_LoopVerse:
		sCall	OAZ1_FM1_BassVerse
		dc.b	$A1,$06,$A2,$A1,$9F
		sCall	OAZ1_FM1_BassVerse
		dc.b	$A1,$06,$A3,$A6,$A9
		sCall	OAZ1_FM1_BassVerse
		dc.b	$A1,$06,$A2,$A1,$9F
		sCall	OAZ1_FM1_BassVerse_Single
		dc.b	$A0,$A0,$0C,$80,$06
		dc.b	$B8-$0C,$0C,$B7-$0C,$06,$B4-$0C,$B3-$0C,$0C,$B2-$0C,$06,$AF-$0C

		sLoop	$01,$01,OAZ1_FM1_LoopChorus
		sCall	OAZ1_FM1_BassChorus01
		sCall	OAZ1_FM1_BassChorus02
		sCall	OAZ1_FM1_BassChorus01

	sCall	OAZ1_FM1_BassChorusEnd

	;	sCall	OAZ1_FM1_BassChorus
	;	dc.b	$80,$12
	;	dc.b	$A6,$06
	;	dc.b	$A3,$A1,$9F,$9c

		sJump	OAZ1_FM1_MainLoop

	; --- Verse bass section ---

OAZ1_FM1_BassVerse:
		sCall	OAZ1_FM1_BassVerse_Single
		dc.b	$A0,$A0,$0C,$80,$06

OAZ1_FM1_BassVerse_Single:
		dc.b	$9C,$06,$80,$80,$80
		sRet

	; --- The "bzow" bass intro ---

OAZ1_FM1_Bzow:
		ssVol	MasterVolOAZ+$0C
		sPatFM	$02
		dc.b	$85,$30,$8B,$8A,$85
		sRet

	; --- Normal bass intro ---

OAZ1_FM1_BassIntro:
		ssVol	MasterVolOAZ+$04
		sPatFM	$00
		dc.b	$9C,$0C,$A9,$1E,$A7,$03,$A5
		dc.b	$A3,$12,$AF,$18,$A3,$03,$A3
		dc.b	$A2,$12,$AE,$18,$A0,$03,$9E
		sRet

	; --- Normal bass intro ---

OAZ1_FM1_BassChorus:
		dc.b	$A3,$06,$A2,$A1,$A2,$A3,$A6,$A8,$A9
		sRet

OAZ1_FM1_BassChorus01:
		sCall	OAZ1_FM1_BassChorus
		dc.b	$80,$12
		ssModZ80 $01,$01,$0C,$FF
		dc.b	$AE,$06
		sModOff
		dc.b	$AE,$AC,$A9,$A7
		sRet

OAZ1_FM1_BassChorus02:
		sCall	OAZ1_FM1_BassChorus
		dc.b	$80
		ssModZ80 $01,$01,$0C,$FF
		dc.b	$B2,$06
		sModOff
		dc.b	$B2
		sModOn
		dc.b	$AF,$06
		sModOff
		dc.b	$AE,$AC,$A9,$A6
		sRet

OAZ1_FM1_BassChorusEnd:
		sCall	OAZ1_FM1_BassChorus
		dc.b	$80,$30
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 2
; ---------------------------------------------------------------------------


OAZ1_FM2_MainLoop:
		sCall	OAZ1_FM2_Bell

OAZ1_FM2:
		sCall	OAZ1_FM2_Bell
		sCall	OAZ1_FM2_Bell
		sCall	OAZ1_FM2_Bell
		sJump	OAZ1_FM2_StartLoop

OAZ1_FM2_VerseLoop:
		sCall	OAZ1_FM3_Verse

OAZ1_FM2_StartLoop:
		ssVol	MasterVolOAZ+$0A
		sCall	OAZ1_FM2_GuitarChorus01
		ssVol	MasterVolOAZ+$12
		sCall	OAZ1_FM2_Scratch
		ssVol	MasterVolOAZ+$0A
		sCall	OAZ1_FM2_GuitarChorus02
		ssVol	MasterVolOAZ+$12
		sCall	OAZ1_FM2_Scratch2
		ssVol	MasterVolOAZ+$0A
		sCall	OAZ1_FM2_GuitarChorus01
		ssVol	MasterVolOAZ+$12
		sCall	OAZ1_FM2_Scratch
		ssVol	MasterVolOAZ+$0A
		sCall	OAZ1_FM2_GuitarChorus02
		ssVol	MasterVolOAZ+$12
		sCall	OAZ1_FM2_Scratch3
	;	sLoop	$01,$02,OAZ1_FM2_VerseLoop


		sCall	OAZ1_FM3_Verse

		ssVol	MasterVolOAZ+$0A
		sCall	OAZ1_FM2_GuitarChorus01
		ssVol	MasterVolOAZ+$12
		sCall	OAZ1_FM2_Scratch
		ssVol	MasterVolOAZ+$0A
		sCall	OAZ1_FM2_GuitarChorus02
		ssVol	MasterVolOAZ+$12
		sCall	OAZ1_FM2_Scratch2
		ssVol	MasterVolOAZ+$0A
		sCall	OAZ1_FM2_GuitarChorus01
		ssVol	MasterVolOAZ+$12
		sCall	OAZ1_FM2_Scratch
		ssVol	MasterVolOAZ+$0A
		sCall	OAZ1_FM2_GuitarChorus02
		ssVol	MasterVolOAZ+$12
		sCall	OAZ1_FM2_Scratch4

		sJump	OAZ1_FM2_MainLoop

	; --- The modulating bell intro ---

OAZ1_FM2_Bell:
		ssVol	MasterVolOAZ+$08
		sPatFM	$01

OAZ1_FM2_BellLoop:
		dc.b	$B5,$01
		sCall	OAZ1_AM30
		sLoop	$01,$04,OAZ1_FM2_BellLoop
		sRet

OAZ1_FM2_BellEnd:
		ssVol	MasterVolOAZ+$08
		sPatFM	$01

OAZ1_FM2_BellEndLoop:
		dc.b	$B5,$01
		sCall	OAZ1_AM30
		sLoop	$01,$03,OAZ1_FM2_BellEndLoop
		dc.b	$B5,$01
		sCall	OAZ1_AM30_End
		dc.b	$80,$06
		dc.b	$B5,$01
		sCall	OAZ1_AM30_End
		dc.b	$80,$06
		dc.b	$B5,$01
		sCall	OAZ1_AM30_End
		dc.b	$80,$06
		dc.b	$B5,$01
		sCall	OAZ1_AM30_End
		dc.b	$80,$06
		sRet

OAZ1_AM30_End:
		saVolFM	$04			; Slow out/in
		dc.b	$E7,$01
		saVolFM	$04
		dc.b	$E7,$01
		saVolFM	$04
		dc.b	$E7,$01
		saVolFM	$FC
		dc.b	$E7,$01
		saVolFM	$FC
		dc.b	$E7,$01
		saVolFM	$FC
		sRet

	; --- The guitar chorus ---

OAZ1_FM2_GuitarChorus01:
		sPatFM	$04
		ssModZ80 $01,$01,$EE,$FF
		dc.b	$A4,$0C
		sModOff
		dc.b	$A2,$0C,$A3,$06
		sJump	OAZ1_FM2_GC02

OAZ1_FM2_GuitarChorus02:
		sPatFM	$04
		dc.b	$A2,$06,$A1,$A0,$A1,$A2

OAZ1_FM2_GC02:
		dc.b	$A4,$A7,$A9
		saVolFM	$08
		dc.b	$A7
		saVolFM	$F8
		sRet

	; --- Scratch sounding synth ---

OAZ1_FM2_Scratch:
		sPatFM	$06
		ssModZ80 $01,$01,$60,$FF
		dc.b	$CE,$03,$80,$03,$CC,$03,$03,$80,$CC,$80,$C6,$CC,$80
		ssModZ80 $01,$01,$F4,$FF
		dc.b	$C8
		dc.b	$06
		ssModZ80 $01,$01,$60,$FF
		dc.b	$CC,$03,$80
		sModOff
		sRet

OAZ1_FM2_Scratch2:
		sPatFM	$06
		ssModZ80 $01,$01,$60,$FF
		dc.b	$CE,$03,$80,$03,$CC,$03,$03,$80,$CC,$80,$C6,$CC,$80
		dc.b	$CC,$03,$80
		ssModZ80 $01,$01,$F4,$FF
		dc.b	$C8
		dc.b	$06
		sModOff
		sRet

OAZ1_FM2_Scratch3Loop:
		ssModZ80 $01,$01,$60,$FF
		dc.b	$CE,$03,$80

OAZ1_FM2_Scratch3:
		sPatFM	$06
		ssModZ80 $01,$01,$F4,$FF
		dc.b	$C8
		dc.b	$06
		sLoop	$00,$04,OAZ1_FM2_Scratch3Loop
		sModOff
		sRet

OAZ1_FM2_Scratch4:
		sPatFM	$06
		ssModZ80 $01,$01,$F4,$FF
		dc.b	$C8
		dc.b	$1E
		ssModZ80 $01,$01,$20,$FF
		dc.b	$C0
		dc.b	$0C
		sModOff
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 3
; ---------------------------------------------------------------------------

OAZ1_FM3:
		sCall	OAZ1_FM3_Bell
		sJump	OAZ1_FM3_StartLoop

OAZ1_FM3_MainLoop:
		sModOff
		sPatFM	$03
		ssVol	MasterVolOAZ+$0E
		dc.b	$9D,$30,$A3,$A2,$9D
		dc.b	$9D,$30,$A3,$A2,$9D

OAZ1_FM3_StartLoop:
		sPan	$C0,$00
		sCall	OAZ1_FM3_IntroGuitar
		sJump	OAZ1_FM3_ChorusLoop

OAZ1_FM3_VerseLoop:
	saTranspose $F4
		sCall	OAZ1_FM3_Verse
	saTranspose $0C

OAZ1_FM3_ChorusLoop:
		ssVol	MasterVolOAZ+$14
		sCall	OAZ1_FM3_Sawtooth
		sCall	OAZ1_FM3_Sawtooth
		sCall	OAZ1_FM3_Sawtooth
		sCall	OAZ1_FM3_Sawtooth
		sLoop	$01,$02,OAZ1_FM3_VerseLoop
		sJump	OAZ1_FM3_MainLoop

	; --- The verse section ---

OAZ1_FM3_Verse:
		dc.b	$80,$60,$80,$60,$80,$60,$80,$30

		sPatFM	$03
		ssVol	MasterVolOAZ+$16
		dc.b	$B8,$0C,$B7,$06,$B4,$B3,$0C,$B2,$06,$AF
		sRet

	; --- The modulating bell intro ---

OAZ1_FM3_Bell:
		ssVol	MasterVolOAZ+$0C
		sPatFM	$01
		sPan	$80,$00

		dc.b	$B0,$01
		sCall	OAZ1_AMPM30
		dc.b	$AF,$01
		sCall	OAZ1_AMPM30
		dc.b	$AE,$01
		sCall	OAZ1_AMPM30
		dc.b	$AC,$01
		sJump	OAZ1_AMPM30

OAZ1_FM3_BellEnd:
		ssVol	MasterVolOAZ+$0C
		sPatFM	$01
		sPan	$80,$00

		dc.b	$B0,$01
		sCall	OAZ1_AMPM30
		dc.b	$AF,$01
		sCall	OAZ1_AMPM30
		dc.b	$AE,$01
		sCall	OAZ1_AMPM30

		dc.b	$AC,$01
		sCall	OAZ1_AMPM30_End
		dc.b	$80,$06
		dc.b	$AC,$01
		sCall	OAZ1_AMPM30_End_NEG
		dc.b	$80,$06
		dc.b	$AC,$01
		sCall	OAZ1_AMPM30_End
		dc.b	$80,$06
		dc.b	$AC,$01
		sCall	OAZ1_AMPM30_End_NEG
		dc.b	$80,$06
		sRet

OAZ1_AMPM30_End:
		saVolFM	$04			; Slow out/in
		dc.b	$E7,$01
		saVolFM	$04
		dc.b	$E7,$01
		sPan	$C0,$00
		saVolFM	$04
		dc.b	$E7,$01
		sPan	$40,$00
		saVolFM	$FC
		dc.b	$E7,$01
		saVolFM	$FC
		dc.b	$E7,$01
		saVolFM	$FC
		sRet

OAZ1_AMPM30_End_NEG:
		saVolFM	$04			; Slow out/in
		dc.b	$E7,$01
		saVolFM	$04
		dc.b	$E7,$01
		sPan	$C0,$00
		saVolFM	$04
		dc.b	$E7,$01
		sPan	$80,$00
		saVolFM	$FC
		dc.b	$E7,$01
		saVolFM	$FC
		dc.b	$E7,$01
		saVolFM	$FC
		sRet

	; --- The intro guitar ---

OAZ1_FM3_IntroGuitar:
		sPatFM	$03
		ssVol	MasterVolOAZ+$0E
		dc.b	$9D,$30,$A3,$A2,$9D
		dc.b	$9D,$30,$A3,$A2

		dc.b	$9D,$06,$80,$06
		dc.b	$9D,$06,$80,$06
		dc.b	$9D,$06,$80,$06
		dc.b	$9D,$06,$80,$06
		sRet

	; --- The sawtooth sounding chorus ---

OAZ1_FM3_Sawtooth:
		ssModZ80 $0D,$01,$0C,$06

OAZ1_FM3_Sawtooth_NoMod:
		sPatFM $05
		dc.b	$80,$0C,$C6,$12,$C8,$06,$C6,$C4,$BF,$C1

OAZ1_FM3_SawT_Loop:
		saVolFM	$10
		dc.b	$BF,$03,$C1,$06
		sLoop	$00,$04,OAZ1_FM3_SawT_Loop
		saVolFM	$C0
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 4
; ---------------------------------------------------------------------------

OAZ1_FM4:
		saDetune $F8
		sPan	$80,$00
		sCall	OAZ1_FM1_Bzow
		sJump	OAZ1_FM4_StartLoop


OAZ1_FM4_MainLoop:
		saDetune $08
		sCall	OAZ1_FM3_Bell
		sCall	OAZ1_FM3_Bell

OAZ1_FM4_StartLoop:
		saDetune $08
		sCall	OAZ1_FM3_Bell
		sCall	OAZ1_FM3_Bell
		sJump	OAZ1_FM4_ChorusLoop

OAZ1_FM4_VerseLoop:
		sCall	OAZ1_FM3_Verse

OAZ1_FM4_ChorusLoop:
		ssVol	MasterVolOAZ+$14
		saDetune $FE
		sPan	$C0,$00
		sCall	OAZ1_FM3_Sawtooth_NoMod
		sCall	OAZ1_FM3_Sawtooth_NoMod
		sCall	OAZ1_FM3_Sawtooth_NoMod
		sCall	OAZ1_FM3_Sawtooth_NoMod
		sLoop	$01,$02,OAZ1_FM4_VerseLoop
		sJump	OAZ1_FM4_MainLoop

; ===========================================================================
; ---------------------------------------------------------------------------
; FM 5
; ---------------------------------------------------------------------------

OAZ1_FM5:
		sCall	OAZ1_FM5_Bell
		sJump	OAZ1_FM5_StartLoop

OAZ1_FM5_MainLoop:
		sPatFM	$03
		ssVol	MasterVolOAZ+$0E
		dc.b	$9D,$30,$A3,$A2,$9D
		dc.b	$9D,$30,$A3,$A2,$9D

OAZ1_FM5_StartLoop:
		saDetune $FE
		sPan	$80,$00
		sCall	OAZ1_FM3_IntroGuitar
		sJump	OAZ1_FM5_ChorusLoop

OAZ1_FM5_VerseLoop:
	saTranspose $F4
		sCall	OAZ1_FM3_Verse
	saTranspose $0C

OAZ1_FM5_ChorusLoop:
		saDetune $FD
		sPan	$80,$00
		ssVol	MasterVolOAZ+$08
		sCall	OAZ1_FM2_GuitarChorus01
		ssVol	MasterVolOAZ+$10
		sCall	OAZ1_FM2_Scratch
		ssVol	MasterVolOAZ+$08
		sCall	OAZ1_FM2_GuitarChorus02
		ssVol	MasterVolOAZ+$10
		sCall	OAZ1_FM2_Scratch2
		ssVol	MasterVolOAZ+$08
		sCall	OAZ1_FM2_GuitarChorus01
		ssVol	MasterVolOAZ+$10
		sCall	OAZ1_FM2_Scratch
		ssVol	MasterVolOAZ+$08
		sCall	OAZ1_FM2_GuitarChorus02
		ssVol	MasterVolOAZ+$10
		sCall	OAZ1_FM2_Scratch3
	;	sLoop	$01,$02,OAZ1_FM5_VerseLoop

	saTranspose $F4
		sCall	OAZ1_FM3_Verse
	saTranspose $0C

		saDetune $FD
		sPan	$80,$00
		ssVol	MasterVolOAZ+$08
		sCall	OAZ1_FM2_GuitarChorus01
		ssVol	MasterVolOAZ+$10
		sCall	OAZ1_FM2_Scratch
		ssVol	MasterVolOAZ+$08
		sCall	OAZ1_FM2_GuitarChorus02
		ssVol	MasterVolOAZ+$10
		sCall	OAZ1_FM2_Scratch2
		ssVol	MasterVolOAZ+$08
		sCall	OAZ1_FM2_GuitarChorus01
		ssVol	MasterVolOAZ+$10
		sCall	OAZ1_FM2_Scratch
		ssVol	MasterVolOAZ+$08
		sCall	OAZ1_FM2_GuitarChorus02
		ssVol	MasterVolOAZ+$10
		sCall	OAZ1_FM2_Scratch4

		sJump	OAZ1_FM5_MainLoop

	; --- The modulating bell intro ---

OAZ1_FM5_Bell:
		ssVol	MasterVolOAZ+$0C
		sPatFM	$01
		sPan	$40,$00

		dc.b	$A9,$01
		sCall	OAZ1_AMPM30_NEG
		dc.b	$AF,$01
		sCall	OAZ1_AMPM30_NEG
		dc.b	$AE,$01
		sCall	OAZ1_AMPM30_NEG
		dc.b	$A9,$01
		sJump	OAZ1_AMPM30_NEG

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG 1
; ---------------------------------------------------------------------------

OAZ1_PSG1:
		dc.b	$80,$06

OAZ1_PSG1_StartLoop:
		dc.b	$80,$60
		sLoop	$00,$06,OAZ1_PSG1_StartLoop

		sJump	OAZ1_PSG1_Loop

OAZ1_PSG1_MainLoop:
		ssVol	MasterVolOAZ+$00
		sCall	OAZ1_PSG1_Verse
		sCall	OAZ1_PSG1_Verse
		sCall	OAZ1_PSG1_Verse
		sCall	OAZ1_PSG1_Verse

OAZ1_PSG1_Loop:
		ssVol	MasterVolOAZ+$38
		sCall	OAZ1_PSG1_Sawtooth
		sCall	OAZ1_PSG1_Sawtooth
		sCall	OAZ1_PSG1_Sawtooth
		sCall	OAZ1_PSG1_Sawtooth

		sLoop	$01,$02,OAZ1_PSG1_MainLoop
		dc.b	$80,$60
		dc.b	$80,$60
		sJump	OAZ1_PSG1_StartLoop

	; --- Verse section ---

OAZ1_PSG1_Verse:
		saVolPSG $08

OAZ1_PSG1_VerseLoop:

	dc.b	$80,$30

	;	dc.b	$93+$0C,$03,$91+$0C,$03,$8F+$0C,$03,$8E+$0C,$03
	;	saVolPSG $FF
	;	sLoop	$00,$04,OAZ1_PSG1_VerseLoop
	;	saVolPSG $FC
		dc.b	$80,$30
		sRet

	; --- The sawtooth sounding chorus ---

OAZ1_PSG1_Sawtooth:
		sVolEnvPSG $0D
		dc.b	$80,$0C
		dc.b	$96,$12,$98,$06,$96,$94,$8F,$91

OAZ1_PSG1_SawT_Loop:
		saVolPSG $03
		dc.b	$8F,$03,$91,$06
		sLoop	$00,$04,OAZ1_PSG1_SawT_Loop
		saVolPSG $F8
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG 2
; ---------------------------------------------------------------------------

OAZ1_PSG2:
		dc.b	$80,$06+$03

OAZ1_PSG2_StartLoop:
		dc.b	$80,$60
		sLoop	$00,$06,OAZ1_PSG2_StartLoop
		sJump	OAZ1_PSG2_Loop

OAZ1_PSG2_MainLoop:
		ssVol	MasterVolOAZ+$10
		sCall	OAZ1_PSG1_Verse
		sCall	OAZ1_PSG1_Verse
		sCall	OAZ1_PSG1_Verse
		sCall	OAZ1_PSG1_Verse

OAZ1_PSG2_Loop:
		saDetune $FF
		ssVol	MasterVolOAZ+$48
		sCall	OAZ1_PSG1_Sawtooth
		sCall	OAZ1_PSG1_Sawtooth
		sCall	OAZ1_PSG1_Sawtooth
		sCall	OAZ1_PSG1_Sawtooth
		sLoop	$01,$02,OAZ1_PSG2_MainLoop
		dc.b	$80,$60
		dc.b	$80,$60
		sJump	OAZ1_PSG2_StartLoop

; ===========================================================================
; ---------------------------------------------------------------------------
; PSG 3
; ---------------------------------------------------------------------------

OAZ1_PSG3:
		sNoisePSG $E7
		dc.b	$80,$60,$80,$60
		ssVol	MasterVolOAZ+$04
		sJump	OAZ1_PSG3_Loop

OAZ1_PSG3_MainLoop:
		sCall	OAZ1_PSG3_Intro
		sCall	OAZ1_PSG3_Intro

OAZ1_PSG3_Loop:
		sCall	OAZ1_PSG3_Intro
		sCall	OAZ1_PSG3_Intro
		sCall	OAZ1_PSG3_Chorus
		sLoop	$01,$02,OAZ1_PSG3_Loop
		sJump	OAZ1_PSG3_MainLoop

	; --- Intro hi-hats ---

OAZ1_PSG3_Intro:
		sVolEnvPSG $02
		dc.b	nBb6,$06
		sVolEnvPSG $05
		dc.b	nBb6,$06
		sVolEnvPSG $02
		dc.b	nBb6,$06
		sVolEnvPSG $0C
		dc.b	nBb6,$03
		sVolEnvPSG $02
		dc.b	nBb6,$03
		sLoop	$00,$08,OAZ1_PSG3_Intro
		sRet

	; --- Chorus hi-hats ---

OAZ1_PSG3_Chorus:
		sVolEnvPSG $05
		dc.b	nBb6,$0C
		sVolEnvPSG $02
		dc.b	nBb6,$06,$06,$06,$06,$06,$06
		sLoop	$00,$08,OAZ1_PSG3_Chorus
		sRet

; ===========================================================================
; ---------------------------------------------------------------------------
; Instruments
; ---------------------------------------------------------------------------

OAZ1MG_Patches:

	; 00 - Bass

	dc.b	$03
	dc.b	$00,$00,$00,$00, $18,$18,$18,$18, $00,$00,$00,$06
	dc.b	$12,$0B,$07,$00, $F2,$FF,$FC,$F9, $24,$2C,$3C,$80

	; 01 - Bell like piano for intro

	dc.b	$3A
	dc.b	$61,$31,$14,$31, $9C,$DB,$9C,$DA, $00,$00,$00,$01
	dc.b	$00,$00,$00,$00, $1F,$0F,$0F,$FF, $30,$30,$2C,$80

	; 02 - Bass with a "bzzoowwww" for the intro

	dc.b	$2C
	dc.b	$72,$32,$72,$22, $18,$13,$1B,$13, $08,$00,$08,$08
	dc.b	$07,$00,$06,$03, $1F,$FF,$0F,$0F, $05,$90,$10,$80

	; 03 - Electric guitar for the intro (slightly softer than main chorus' one will be)

	dc.b	$38
	dc.b	$73,$31,$70,$31, $1F,$1F,$1F,$1F, $00,$00,$00,$02
	dc.b	$00,$00,$00,$00, $FF,$FF,$FF,$FF, $14,$26,$20,$80

	; 04 - Electric guitar for the chorus

	dc.b	$38
	dc.b	$73,$32,$71,$32, $1F,$1F,$1F,$1F, $00,$00,$00,$02
	dc.b	$00,$00,$00,$00, $FF,$FF,$FF,$FF, $14,$22,$18,$88

	; 05 - The main almost saw-tooth sounding instrument during the chorus

	dc.b	$3D
	dc.b	$01,$00,$01,$00, $1F,$1F,$1F,$1F, $00,$00,$00,$00
	dc.b	$00,$00,$00,$00, $0F,$0F,$0F,$0F, $20,$88,$88,$88

	; 06 - Scratch instrument

	dc.b	$38
	dc.b	$F6,$32,$92,$93, $1F,$1F,$1F,$0F, $00,$00,$00,$08
	dc.b	$00,$00,$00,$00, $FF,$FF,$FF,$FF, $10,$1C,$1E,$88





	; Patch $00
	; $3B
	; $01, $02, $04, $02,	$18, $1B, $19, $16
	; $1C, $19, $1D, $1F,	$0A, $02, $02, $03
	; $0F, $1F, $1F, $1E,	$26, $1B, $1B, $80
;	spAlgorithm	$03
;	spFeedback	$07
;	spDetune	$00, $00, $00, $00
;	spMultiple	$01, $04, $02, $02
;	spRateScale	$00, $00, $00, $00
;	spAttackRt	$18, $19, $1B, $16
;	spAmpMod	$00, $00, $00, $00
;	spDecayRt	$1C, $1D, $19, $1F
;	spSustainRt	$0A, $02, $02, $03
;	spSustainLv	$00, $01, $01, $01
;	spReleaseRt	$0F, $0F, $0F, $0E
;	spTotalLv	$26, $1B, $1B, $00

; ===========================================================================
