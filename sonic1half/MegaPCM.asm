
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

	DAC_Entry	$08, Kick, dpcm			; $81	- Kick
	DAC_Entry	$08, Snare, dpcm		; $82	- Snare
	DAC_Entry	$1B, Timpani, dpcm		; $83	- Timpani
	DAC_Entry       $01, Eggman1, pcm+pri            ; $84   - 'Pingas!' voice
	DAC_Entry	$0D, Go, dpcm	           	; $85	- "Go!"
	DAC_Entry	$0D, ComeOn, dpcm	           	; $86	- "Come On!"
	DAC_Entry	$03, Speed, pcm	           	; $87	- Speed Up (CD 510)
	DAC_Entry	$12, Timpani, dpcm		; $88	- Hi-Timpani
	DAC_Entry	$15, Timpani, dpcm		; $89	- Mid-Timpani
	DAC_Entry	$1B, Timpani, dpcm		; $8A	- Mid-Low-Timpani
	DAC_Entry	$1D, Timpani, dpcm		; $8B	- Low-Timpani
	DAC_Entry       $03, Up, pcm+pri               ; $8C   - Sonic CD "Yes!" 1UP.
	
MegaPCM_End:

; ---------------------------------------------------------------
; DAC Samples Files
; ---------------------------------------------------------------

	IncludeDAC	Kick, bin
	IncludeDAC	Snare, bin
	IncludeDAC	Timpani, bin
	  IncludeDAC      Eggman1,wav
      	IncludeDAC	Go, bin
	IncludeDAC	ComeOn, bin
	IncludeDAC	Speed, wav
	IncludeDAC      Up, wav
	
	even
