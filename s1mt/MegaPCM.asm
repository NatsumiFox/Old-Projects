
; ===============================================================
; Mega PCM Driver Include File
; (c) 2012, Vladikcomper
; ===============================================================

; ---------------------------------------------------------------
; Variables used in DAC table
; ---------------------------------------------------------------

; flags
panLR	= $C0
panL	= $80
panR	= $40
pcm	= 0
dpcm	= 4
loop	= 2
pri	= 1

; ---------------------------------------------------------------
; Macros
; ---------------------------------------------------------------

z80word macro Value
	dc.w	((\Value)&$FF)<<8|((\Value)&$FF00)>>8
	endm

DAC_Entry macro Pitch,Offset,Flags
	dc.b	\Flags			; 00h	- Flags
	dc.b	\Pitch			; 01h	- Pitch
	dc.b	(\Offset>>15)&$FF	; 02h	- Start Bank
	dc.b	(\Offset\_End>>15)&$FF	; 03h	- End Bank
	z80word	(\Offset)|$8000		; 04h	- Start Offset (in Start bank)
	z80word	(\Offset\_End-1)|$8000	; 06h	- End Offset (in End bank)
	endm

IncludeDAC macro Name,Extension
\Name:
	if strcmp('\extension','wav')
		incbin	'dac/\Name\.\Extension\',$3A
	else
		incbin	'dac/\Name\.\Extension\'
	endc
\Name\_End:
	endm

; ---------------------------------------------------------------
; Driver's code
; ---------------------------------------------------------------

MegaPCM:
	incbin	'MegaPCM.z80'

; ---------------------------------------------------------------
; DAC Samples Table
; ---------------------------------------------------------------

	DAC_Entry	$05, vecbass2, pcm		; $81	- Vectorman low bass voice (Is not actual DAC in Vectorman)  ; altered a bit ; GS
	DAC_Entry	$04, Streetssnare, pcm		; $82	- Streets of Rage 1 Snare? ; GS
	DAC_Entry	$0A, s3kTightSnare, dpcm	; $83	- s3k Tight Snare
	DAC_Entry	$08, s3kCrashcymbal, dpcm	; $84	- s3k crash cymbal
	DAC_Entry	$08, moon_Clap, pcm		; $85	- MJ's Moonwalker Snare/Clap voice ; may need adjusting on pitch ; GS
	DAC_Entry	$04, Disc_Scratch, pcm+pri	; $86	- Disc scratch - Super adventure Island ; EK
	DAC_Entry	$08, s3ksteeldrum, dpcm		; $87	- s3k steel drum ; may need adjusting on pitch
      	DAC_Entry	$03, s3kTightSnare, dpcm	; $88	- s3k Hi-Tight Snare	; tight snare used instead of Timpani here
	DAC_Entry	$07, s3kTightSnare, dpcm	; $89	- s3k Mid-Tight Snare
	DAC_Entry	$0A, s3kTightSnare, dpcm	; $8A	- s3k Mid-Low-Tight Snare
	DAC_Entry	$0E, s3kTightSnare, dpcm	; $8B	- s3k Low-Tight Snare
	DAC_Entry       $04, portal_lost4, pcm+panLR	; $8C   - Unused
	DAC_Entry       $03, Up, pcm+panLR+pri		; $8D   - YES from SCD
	DAC_Entry       $04, portal_lost2, pcm+panLR	; $8E   - Unused
	DAC_Entry       $04, portal_lost3, pcm+panLR	; $8F   - Unused

        DAC_Entry	$03, GunUnknown, pcm+pri	; $90	- Unknown DAC from Gunstar Heroes ; GS
        DAC_Entry	$12, longkick, pcm		; $91	- Bill Walsh College Football 95' - Kick ; EK
        DAC_entry	$08, SegaPCM, pcm+panLR+pri	; $92	- Sega PCM
        DAC_Entry	$12, Timpani, dpcm		; $93	- Hi-Timpani
	DAC_Entry	$15, Timpani, dpcm		; $94	- Mid-Timpani
	DAC_Entry	$1B, Timpani, dpcm		; $95	- Mid-Low-Timpani
	DAC_Entry	$1D, Timpani, dpcm		; $96	- Low-Timpani
	DAC_Entry	$01, DanceSnare, pcm		; $97   - Dance snare	; EB
	DAC_Entry	$06, S3Kkick, dpcm		; $98   - Sonic 3 normal kick sample
	DAC_Entry	$06, _8F_Sonic3snare, pcm	; $99	- Sonic 3 Snare
	DAC_Entry	$03, _8F_Sonic3snare, pcm	; $9A	- TF2 Nope sound effect
	DAC_Entry	$10, Rhythm_Emotion_, pcm+panLR+pri; $9B - Rhythm Emotion
	DAC_Entry	$04, portal_lost1, pcm+panLR	; $9C - Are you still there?

	; samples used in air horn stuff
	DAC_Entry	$03, horns, pcm			; $81	- air horns
	DAC_Entry	$05, horns, pcm			; $82	- air horns
	DAC_Entry	$07, horns, pcm			; $83	- air horns
	DAC_Entry	$03, scream1, pcm		; $84	- screaming kid 1
	DAC_Entry	$03, scream2, pcm		; $85	- screaming kid 2
	DAC_Entry	$03, scream3, pcm		; $86	- screaming kid 3
	DAC_Entry	$03, scream4, pcm		; $87	- screaming kid 4
	DAC_Entry	$02, horn, pcm			; $88	- air horn
	DAC_Entry	$03, horn, pcm			; $89	- air horn
	DAC_Entry	$04, horn, pcm			; $8A	- air horn
	DAC_Entry	$05, horn, pcm			; $8B	- air horn
	DAC_Entry	$03, lost, pcm+panLR+pri	; $8C	- price is right losing horn
	DAC_Entry	$03, pan, pcm+panLR+pri		; $8D	- smoke weed everyday
	DAC_Entry       $04, portal_found4, pcm+panLR	; $8E   - Unused
	DAC_Entry	$03, gmoverscrean, pcm+panLR+pri; $8F	- kid scream 6
	DAC_Entry	$01, horns, pcm			; $90	- air horns
	DAC_Entry	$01, horn, pcm			; $91	- air horn
	DAC_Entry	$03, spiel, pcm+panLR+pri	; $92	- screaming kid 5
	DAC_Entry	$05, scream1, pcm		; $93	- screaming kid 1
	DAC_Entry	$05, scream2, pcm		; $94	- screaming kid 2
	DAC_Entry	$05, scream3, pcm		; $95	- screaming kid 3
	DAC_Entry	$05, scream4, pcm		; $96	- screaming kid 4
	DAC_Entry	$01, scream1, pcm		; $97	- screaming kid 1
	DAC_Entry	$01, scream2, pcm		; $98	- screaming kid 2
	DAC_Entry	$01, scream3, pcm		; $99	- screaming kid 3
	DAC_Entry	$01, scream4, pcm		; $9A	- screaming kid 4
	DAC_Entry	$10, banana, pcm+panLR+pri	; $9B - lol
	DAC_Entry	$04, portal_lost1, pcm+panLR; $9C - Are you still there?

	DAC_Entry       $04, portal_found3, pcm+panLR; $B9   - Unused
	DAC_Entry       $04, portal_found2, pcm+panLR; $BA   - Unused
	DAC_Entry       $04, portal_found1, pcm+panLR; $BB   - Unused

	DAC_Entry       $04, portal_die4, pcm+panLR+pri	; $BC   - Unused
	DAC_Entry       $04, portal_die3, pcm+panLR+pri	; $BD   - Unused
	DAC_Entry       $04, portal_die2, pcm+panLR+pri	; $BE   - Unused
	DAC_Entry       $04, portal_die1, pcm+panLR+pri	; $BF   - Unused
	DAC_Entry       $04, ground, pcm+panLR+pri	; $C0   - ground wave sound effect
	DAC_Entry       $10, trump, pcm+panLR+pri	; $C1   - donald trump quote
MegaPCM_End:

; ---------------------------------------------------------------
; DAC Samples Files
; ---------------------------------------------------------------
	IncludeDAC	Disc_Scratch, raw	; Super Adventure Island
	IncludeDAC	S3Kkick, bin		; sonic 3
	IncludeDAC	DanceSnare, wav		; not sure
	IncludeDAC	Longkick, raw		; Unknown DAC from Gunstar Heroes
	IncludeDAC	vecbass2, raw		; Vectorman bass
	IncludeDAC	GunUnknown, raw		; Bill Walsh College Football 95'
        IncludeDAC	moon_clap, raw		; MJ's Moonwalker clap/snare sound
	IncludeDAC	s3kTightSnare, bin	; sonic 3
	IncludeDAC	Streetssnare, raw	; streets of Rage
	IncludeDAC      Up, wav			; Sonic CD
	IncludeDAC	_8F_Sonic3snare, raw	; Sonic 3
	IncludeDAC	s3kCrashcymbal, bin	; Sonic 3
	IncludeDAC	s3ksteeldrum, bin	; Sonic 3
	IncludeDAC	Timpani, bin		; Sonic 1

	IncludeDAC	pan, raw		; Smoke Weed
	IncludeDAC	horns, raw		; air horns
	IncludeDAC	horn, raw		; air horn
	IncludeDAC	scream1, raw		; kid scream 1
	IncludeDAC	scream2, raw		; kid scream 2
	IncludeDAC	scream3, raw		; kid scream 3
	IncludeDAC	scream4, raw		; kid scream 4
	IncludeDAC	spiel, raw		; kid scream 5
	IncludeDAC	gmoverscrean, raw	; kid scream 6
	IncludeDAC	lost, raw		; price is right losing horn

	IncludeDAC	portal_lost1, raw	; are you still there?
	IncludeDAC	portal_lost2, raw	; target lost
	IncludeDAC	portal_lost3, raw	; can I help you?
	IncludeDAC	portal_lost4, raw	; searching

	IncludeDAC	portal_found1, raw	; are you still there?
	IncludeDAC	portal_found2, raw	; target lost
	IncludeDAC	portal_found3, raw	; can I help you?
	IncludeDAC	portal_found4, raw	; searching

	IncludeDAC	portal_die1, raw	; are you still there?
	IncludeDAC	portal_die2, raw	; target lost
	IncludeDAC	portal_die3, raw	; can I help you?
	IncludeDAC	portal_die4, raw	; searching

	IncludeDAC	ground, raw
	IncludeDAC	trump, raw
	IncludeDAC	Rhythm_Emotion_, raw	; Gundam Wing (TV)
	IncludeDAC	banana, raw		; Onision I am a banana
	IncludeDAC	SegaPCM, bin		; Sonic 1
	even

