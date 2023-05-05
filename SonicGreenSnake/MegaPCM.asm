
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
	DAC_Entry	$0D, Go, dpcm+pri	        ; $8C	- "Go!"  from s3k
	DAC_Entry	$0D, Go, pcm+pri		; $8D   - Unused
        DAC_Entry       $03, Up, pcm+pri                ; $8E   - YES from SCD
        DAC_Entry       $01, Go, pcm+pri		; $8F   - Unused
        DAC_Entry	$04, GunUnknown, pcm+pri	; $90	- Unknown DAC from Gunstar Heroes ; GS
        DAC_Entry	$12, longkick, pcm		; $91	- Bill Walsh College Football 95' - Kick ; EK
        DAC_entry	$08, SegaPCM, pcm+pri		; $92	- Sega PCM
        DAC_Entry	$12, Timpani, dpcm		; $93	- Hi-Timpani
	DAC_Entry	$15, Timpani, dpcm		; $94	- Mid-Timpani
	DAC_Entry	$1B, Timpani, dpcm		; $95	- Mid-Low-Timpani
	DAC_Entry	$1D, Timpani, dpcm		; $96	- Low-Timpani
	DAC_Entry	$01, DanceSnare, pcm		; $97   - Dance snare	; EB
	DAC_Entry	$06, S3Kkick, dpcm		; $98   - Sonic 3 normal kick sample
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
	IncludeDAC	Go, bin			; Sonic 3
	IncludeDAC      Up, wav			; Sonic CD
	IncludeDAC	s3kCrashcymbal, bin	; Sonic 3
	IncludeDAC	s3ksteeldrum, bin	; Sonic 3
	IncludeDAC	Timpani, bin		; Sonic 1
	IncludeDAC	SegaPCM, bin		; Sonic 1
	even

