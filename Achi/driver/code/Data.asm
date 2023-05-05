; ===========================================================================
; ---------------------------------------------------------------------------
; Flags section. None of this is required, but I added it here to
; make it easier to debug built ROMS! If you would like easier
; assistance from Natsumi, please keep this section intact!
; ---------------------------------------------------------------------------
	dc.b "AMPS-v1.1 "		; ident str

	if FEATURE_UNDERWATER
		dc.b "UW"		; underwater mode enabled
	endif

	if FEATURE_MODULATION
		dc.b "MO"		; modulation enabled
	endif

	if FEATURE_DACFMVOLENV
		dc.b "VE"		; FM & DAC volume envelope enabled
	endif

	if FEATURE_MODENV
		dc.b "ME"		; modulation envelope enabled
	endif

	if FEATURE_PORTAMENTO
		dc.b "PM"		; portamento enabled
	endif

	if FEATURE_BACKUP
		dc.b "BA"		; backup enabled
	endif

; ===========================================================================
; ---------------------------------------------------------------------------
; Define music and SFX
; ---------------------------------------------------------------------------

	opt oz-				; disable zero-offset optimization
	if safe=0
		nolist			; if in safe mode, list data section.
	endif

__sfx =		SFXoff
__mus =		MusOff
SoundIndex:
	ptrSFX	0, RingRight, RingLeft, RingLoss, Splash, Break
	ptrSFX	0, Jump, Roll, Skid, Bubble, Drown, SpikeHit, Death
	ptrSFX	0, AirDing, Register, Bonus, Shield, Dash, Signpost
	ptrSFX	0, Lamppost, BossHit, Bumper, Spring
	ptrSFX	0, Collapse, BigRing, Smash, Switch, Explode
	ptrSFX	0, BuzzExplode, Basaran, Electricity, Flame, LavaBall
	ptrSFX	0, SpikeMove, Rumble, Door, Stomp, Chain, Saw, Lava

	ptrSFX	0, EnterSS, Goal, ActionBlock, Diamonds, Continue

; SFX with special features
	ptrSFX	$80, PushBlock

; unused SFX
	ptrSFX	0, UnkA2, UnkAB, UnkB8

MusicIndex:
	ptrMusic DIS, $28

mus_Egor = mus_DIS
; ===========================================================================
; ---------------------------------------------------------------------------
; Define samples
; ---------------------------------------------------------------------------

__samp =	$80
SampleList:
	sample $0100, Stop, Stop			; 80 (THIS IS A REST NOTE, DO NOT EDIT...)

; The following samples are for the standard Amen Break
	sample $0100, AmenHatSnare1, AmenHatSnare1l	; 81 - Hat Snare 1
	sample $0100, AmenHatSnare2, AmenHatSnare2l	; 82 - Hat Snare 2
	sample $0100, AmenHatSnare3, AmenHatSnare3l	; 84 - Hat Snare 3
	sample $0100, AmenHatKickLow, AmenHatKickLowl	; 85 - Hat Kick Low
	sample $0100, AmenHatKickHi, AmenHatKickHil	; 86 - Hat Kick High
	sample $0100, AmenLowKick, AmenLowKickl		; 87 - Low Kick
	sample $0100, AmenHat1, AmenHat1l		; 88 - Hat 1
	sample $0100, AmenHat2, AmenHat2l		; 89 - Hat 2
	sample $0100, AmenCrash1, AmenCrash1l		; 8A - Crash 1
	sample $0100, AmenCrash2, AmenCrash2l		; 8B - Crash 2

	sample $0100, Kick, Stop		; 81 - Kick
	sample $0100, LowKick, Stop		; 82 - Low Kick
	sample $0100, Snare, Stop		; 83 - Snare
	sample $00E0, Snare, Stop, LowSnare	; 84 - Low Snare
	sample $0100, Clap, Stop		; 85 - Clap
	sample $0180, Tom, Stop, HiTom		; 86 - High Tom
	sample $0100, Tom, Stop			; 87 - Mid Tom
	sample $00C0, Tom, Stop, LowTom		; 88 - Low Tom
	sample $0080, Tom, Stop, FloorTom	; 89 - Floor Tom

	sample $0100, KcTom, Stop		; 91 - Tom (Knuckles Chaotix)
	sample $00C0, KcTom, Stop, KcLowTom	; 92 - Low Tom (Knuckles Chaotix)
	sample $0080, KcTom, Stop, KcFloorTom	; 93 - Floor Tom (Knuckles Chaotix)
	sample $0100, kcCymbal, Stop		; 94 - Cymbal? (Knuckles Chaotix)
	sample $0100, KcSnare, Stop		; 95 - Snare (Knuckles Chaotix)
	sample $0100, KcTamb, Stop		; 96 - Tambourine? (Knuckles Chaotix)
	sample $0100, Kc87, Stop		; 97 - Not really sure? (Knuckles Chaotix)
	sample $0100, KcCrash, Stop		; 98 - Crash Cymbal (Knuckles Chaotix)
; ===========================================================================
; ---------------------------------------------------------------------------
; Define volume envelopes and their data
; ---------------------------------------------------------------------------

__venv =	$01
VolEnvs:
	volenv 01, 02, 03, 04, 05, 06, 07, 08
	volenv 09, Kc02, Kc05, Kc08
VolEnvs_End:
; ---------------------------------------------------------------------------

vd01:		dc.b $00, $00, $00, $08, $08, $08, $10, $10
		dc.b $10, $18, $18, $18, $20, $20, $20, $28
		dc.b $28, $28, $30, $30, $30, $38, eHold

; Knuckles Chaotix 02
vdKc02:		dc.b $00, $00		; continue to volenv below
		dc.b $00, $10, $20, $30, $40, $7F, eStop

; Knuckles Chaotix 08
vdKc08:		dc.b $10, $08, $00, $00, $08, $08, $10, eHold

vdKc05:		dc.b $18, $00, $08, $08, $08, $10, $18, $20
		dc.b $20, $28, eHold

; 02 and 0A in Ristar
vd02:		dc.b $00, $10, $20, $30, $40, $10, eHold

vd03:		dc.b $00, $00, $08, $08, $10, $10, $18, $18
		dc.b $20, $20, $28, $28, $30, $30, $38, $38
		dc.b eHold

vd04:		dc.b $00, $00, $10, $18, $20, $20, $28, $28
		dc.b $28, $30, eHold

vd05:		dc.b $00, $00, $00, $00, $00, $00, $00, $00
		dc.b $00, $00, $08, $08, $08, $08, $08, $08
		dc.b $08, $08, $08, $08, $08, $08, $08, $08
		dc.b $10, $10, $10, $10, $10, $10, $10, $10
		dc.b $18, $18, $18, $18, $18, $18, $18, $18
		dc.b $20, eHold

vd06:		dc.b $18, $18, $18, $10, $10, $10, $10, $08
		dc.b $08, $08, $00, $00, $00, $00, eHold

vd07:		dc.b $00, $00, $00, $00, $00, $00, $08, $08
		dc.b $08, $08, $08, $10, $10, $10, $10, $10
		dc.b $18, $18, $18, $20, $20, $20, $28, $28
		dc.b $28, $30, $38, eHold

vd08:		dc.b $00, $00, $00, $00, $00, $08, $08, $08
		dc.b $08, $08, $10, $10, $10, $10, $10, $10
		dc.b $18, $18, $18, $18, $18, $20, $20, $20
		dc.b $20, $20, $28, $28, $28, $28, $28, $30
		dc.b $30, $30, $30, $30, $38, $38, $38, eHold

vd09:		dc.b $00, $08, $10, $18, $20, $28, $30, $38
		dc.b $40, $48, $50, $58, $60, $68, $70, $78
		dc.b eHold
; ===========================================================================
; ---------------------------------------------------------------------------
; Define volume envelopes and their data
; ---------------------------------------------------------------------------

		even
__menv =	$01

ModEnvs:
	modenv
ModEnvs_End:
; ---------------------------------------------------------------------------

	if FEATURE_MODENV

	endif

; ===========================================================================
; ---------------------------------------------------------------------------
; Include music, sound effects and voice table
; ---------------------------------------------------------------------------

	include "driver/Voices.asm"	; include universal Voice bank
	opt ae-				; disable automatic evens

sfxaddr	incSFX				; include all sfx
musaddr	incMus				; include all music
musend
; ===========================================================================
; ---------------------------------------------------------------------------
; Include samples and filters
; ---------------------------------------------------------------------------

		align	$8000		; must be aligned to bank... By the way, these are also set in Z80.asm. Be sure to check it out also.
fLog:		incbin "driver/filters/Logarithmic.dat"	; logarithmic filter (no filter)
;fLinear:	incbin "driver/filters/Linear.dat"	; linear filter (no filter)

dacaddr		dcb.b	Z80E_Read*(MaxPitch/$100),$00
SWF_Stop:	dcb.b	$8000-(2*Z80E_Read*(MaxPitch/$100)),$80
SWFR_Stop:	dcb.b	Z80E_Read*(MaxPitch/$100),$00

	incSWF	AmenHatSnare1, AmenHatSnare1l, AmenHatSnare2, AmenHatSnare2l
	incSWF	AmenHatSnare3, AmenHatSnare3l
	incSWF	AmenHat1, AmenHat1l, AmenHat2, AmenHat2l, AmenLowKick, AmenLowKickl
	incSWF	AmenHatKickHi, AmenHatKickHil, AmenHatKickLow, AmenHatKickLowl
	incSWF	AmenCrash1, AmenCrash1l, AmenCrash2, AmenCrash2l

	incSWF	Kick, LowKick, Snare, Clap, Tom
	incSWF	KcTom, KcSnare, KcTamb, Kc87, KcCrash, KcCymbal
	opt ae+				; enable automatic evens
	list				; continue source listing
; ===========================================================================
