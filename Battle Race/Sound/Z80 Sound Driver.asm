; ---------------------------------------------------------------------------
; ===========================================================================
; ¦                                                                         ¦
; ¦                             SONIC&K SOUND DRIVER                        ¦
; ¦                         Modified SMPS Z80 Type 2 DAC                    ¦
; ¦                                                                         ¦
; ===========================================================================
; Disassembled by MarkeyJester
; Routines, pointers and stuff by Linncaki
; Thoroughly commented and improved (including optional bugfixes) by Flamewing
; ===========================================================================
; Constants
; ===========================================================================

; Set this to 1 to fix some bugs in the driver.
fix_sndbugs =		1
uw_mode =		0

; Function to make a little endian (z80) pointer
k68z80Pointer function addr,((((addr&$7FFF)+$8000)<<8)&$FF00)+(((addr&$7FFF)+$8000)>>8)

little_endian function x,(x)<<8&$FF00|(x)>>8&$FF

startBank macro {INTLABEL}
	align	$8000
__LABEL__ label *
soundBankStart := __LABEL__
soundBankName := "__LABEL__"
    endm

DebugSoundbanks := 1

finishBank macro
	if * > soundBankStart + $8000
		fatal "soundBank \{soundBankName} must fit in $8000 bytes but was $\{*-soundBankStart}. Try moving something to the other bank."
	elseif (DebugSoundbanks<>0)&&(MOMPASS=1)
		message "soundBank \{soundBankName} has $\{$8000+soundBankStart-*} bytes free at end."
	endif
    endm

; macro to declare an entry in an offset table rooted at a bank
offsetBankTableEntry macro ptr
	dc.ATTRIBUTE k68z80Pointer(ptr-soundBankStart)
    endm

	include "sound/DAC.asm"			; special DAC table implementation
	include "sound/Music.asm"		; macros for music including
	include "sound/smps2asm.asm"

; ===========================================================================
; Music Banks
; ===========================================================================
		align0 $10

z80_SoundDriverStart:

; ---------------------------------------------------------------------------
zTrack STRUCT DOTS
	; Playback control bits:
	; 	0 (01h)		Noise channel (PSG) or FM3 special mode (FM)
	; 	1 (02h)		Do not attack next note
	; 	2 (04h)		SFX is overriding this track
	; 	3 (08h)		'Alternate frequency mode' flag
	; 	4 (10h)		'Track is resting' flag
	; 	5 (20h)		'Pitch slide' flag
	; 	6 (40h)		'Sustain frequency' flag -- prevents frequency from changing again for the lifetime of the track
	; 	7 (80h)		Track is playing
	PlaybackControl:	ds.b 1	; S&K: 0
	; Voice control bits:
	; 	0-1    		FM channel assignment bits (00 = FM1 or FM4, 01 = FM2 or FM5, 10 = FM3 or FM6/DAC, 11 = invalid)
	; 	2 (04h)		For FM/DAC channels, selects if reg/data writes are bound for part II (set) or part I (unset)
	; 	3 (08h)		Unknown/unused
	; 	4 (10h)		Unknown/unused
	; 	5-6    		PSG Channel assignment bits (00 = PSG1, 01 = PSG2, 10 = PSG3, 11 = Noise)
	; 	7 (80h)		PSG track if set, FM or DAC track otherwise
	VoiceControl:		ds.b 1	; S&K: 1
	TempoDivider:		ds.b 1	; S&K: 2
	DataPointerLow:		ds.b 1	; S&K: 3
	DataPointerHigh:	ds.b 1	; S&K: 4
	Transpose:			ds.b 1	; S&K: 5
	Volume:				ds.b 1	; S&K: 6
	ModulationCtrl:		ds.b 1	; S&K: 7		; Modulation is on if nonzero. If only bit 7 is set, then it is normal modulation; otherwise, this-1 is index on modulation envelope pointer table
	VoiceIndex:			ds.b 1	; S&K: 8		; FM instrument/PSG voice
	StackPointer:		ds.b 1	; S&K: 9		; For call subroutine coordination flag
	AMSFMSPan:			ds.b 1	; S&K: 0Ah
	DurationTimeout:	ds.b 1	; S&K: 0Bh
	SavedDuration:		ds.b 1	; S&K: 0Ch		; Already multiplied by timing divisor
	; ---------------------------------
	; Alternate names for same offset:
	SavedDAC:					; S&K: 0Dh		; For DAC channel
	FreqLow:			ds.b 1	; S&K: 0Dh		; For FM/PSG channels
	; ---------------------------------
	FreqHigh:			ds.b 1	; S&K: 0Eh		; For FM/PSG channels
	VoiceSongID:		ds.b 1	; S&K: 0Fh		; For using voices from a different song
	Detune:			ds.b 1	; S&K: 10h	; In S&K, some places used 11h instead of 10h
	PSGSustain:		ds.b 1	; S&K: 11h		; added to separate it from the damn rest note (stupid driver)
					ds.b 5	; S&K: 12h-16h	; Unused
	VolEnv:				ds.b 1	; S&K: 17h		; Used for dynamic volume adjustments
	; ---------------------------------
	; Alternate names for same offsets:
	FMVolEnv:					; S&K: 18h
	HaveSSGEGFlag:		ds.b 1	; S&K: 18h		; For FM channels, if track has SSG-EG data
	FMVolEnvMask:				; S&K: 19h
	SSGEGPointerLow:	ds.b 1	; S&K: 19h		; For FM channels, custom SSG-EG data pointer
	PSGNoise:					; S&K: 1Ah
	SSGEGPointerHigh:	ds.b 1	; S&K: 1Ah		; For FM channels, custom SSG-EG data pointer
	; ---------------------------------
	FeedbackAlgo:		ds.b 1	; S&K: 1Bh
	TLPtrLow:			ds.b 1	; S&K: 1Ch
	TLPtrHigh:			ds.b 1	; S&K: 1Dh
	NoteFillTimeout:	ds.b 1	; S&K: 1Eh
	NoteFillMaster:		ds.b 1	; S&K: 1Fh
	ModulationPtrLow:	ds.b 1	; S&K: 20h
	ModulationPtrHigh:	ds.b 1	; S&K: 21h
	; ---------------------------------
	; Alternate names for same offset:
	ModulationValLow:			; S&K: 22h
	ModEnvSens:			ds.b 1	; S&K: 22h
	; ---------------------------------
	ModulationValHigh:	ds.b 1	; S&K: 23h
	ModulationWait:		ds.b 1	; S&K: 24h
	; ---------------------------------
	; Alternate names for same offset:
	ModulationSpeed:			; S&K: 25h
	ModEnvIndex:		ds.b 1	; S&K: 25h
	; ---------------------------------
	ModulationDelta:	ds.b 1	; S&K: 26h
	ModulationSteps:	ds.b 1	; S&K: 27h
	LoopCounters:		ds.b 2	; S&K: 28h		; Might overflow into the following data
	VoicesLow:			ds.b 1	; S&K: 2Ah		; Low byte of pointer to track's voices, used only if zUpdatingSFX is set
	VoicesHigh:			ds.b 1	; S&K: 2Bh		; High byte of pointer to track's voices, used only if zUpdatingSFX is set
	Stack_top:			ds.b 4	; S&K: 2Ch-2Fh	; Track stack; can be used by LoopCounters
zTrack ENDSTRUCT
; ---------------------------------------------------------------------------
; equates: standard (for Genesis games) addresses in the memory map
z80_stack =	$1300		; this is where we fit Z80 stack
zYM2612_A0 =	$4000
zYM2612_D0 =	$4001
zYM2612_A1 =	$4002
zYM2612_D1 =	$4003
zBankRegister =	$6000
zPSG =		$7F11
zROMWindow =	$8000
; ---------------------------------------------------------------------------
; z80 RAM:
PCM_Buffer =	$1F00
zDataStart =	$1B50
		phase zDataStart
zSpecFM3Freqs		ds.b 8
zSpecFM3FreqsSFX	ds.b 8
PCM_Status:		ds.b 1		; 0 = read & write, 1 = write only, -1 = run tracker
			ds.b 2

zPalFlag:		ds.b 1
zPalDblUpdCounter:	ds.b 1
zSoundQueue0:		ds.b 1
zSoundQueue1:		ds.b 1
zSoundQueue2:		ds.b 1
zTempoSpeedup:		ds.b 1
zNextSound:		ds.b 1
; The following 3 variables are used for M68K input
zMusicNumber:		ds.b 1	; Play_Sound
zSFXNumber0:		ds.b 1	; Play_Sound_2
zSFXNumber1:		ds.b 1	; Play_Sound_2
	shared zMusicNumber,zSFXNumber0,zSFXNumber1
zFadeOutTimeout:	ds.b 1
zFadeDelay:		ds.b 1
zFadeDelayTimeout:	ds.b 1
zPauseFlag:		ds.b 1
zHaltFlag:		ds.b 1
zFM3Settings:		ds.b 1	; Set twice, never read (is read in Z80 Type 1 for YM timer-related purposes)
zTempoAccumulator:	ds.b 1

SYNC:			ds.b 1		; NAT: New

unk_1C15		ds.b 1	; Set twice, never read
zFadeToPrevFlag:	ds.b 1
unk_1C17:		ds.b 1	; Set once, never read
unk_1C18:		ds.b 1	; Set twice, never read
zUpdatingSFX:		ds.b 1
			ds.b $A	; unused
zCurrentTempo:		ds.b 1
zContinuousSFX:		ds.b 1
zContinuousSFXFlag:	ds.b 1
zSpindashRev:		ds.b 1
zRingSpeaker:		ds.b 1
zFadeInTimeout:		ds.b 1
zVoiceTblPtrSave:	ds.b 2	; For 1-up
zCurrentTempoSave:	ds.b 1	; For 1-up
zSongBankSave:		ds.b 1	; For 1-up
zTempoSpeedupSave:	ds.b 1	; For 1-up
zSpeedupTimeout:	ds.b 1
			ds.b 1	; bit 7 = 1 if playing, 0 if not; remaining 7 bits are index into DAC tables (1-based)
zContSFXLoopCnt:	ds.b 1	; Used as a loop counter for continuous SFX
zSFXSaveIndex:		ds.b 1
zSongPosition:		ds.b 2
zTrackInitPos:		ds.b 2	; 2 bytes
zVoiceTblPtr:		ds.b 2	; 2 bytes
zSFXVoiceTblPtr:	ds.b 2	; 2 bytes
zSFXTempoDivider:	ds.b 1
			ds.b 2	; unused
zSongBank:		ds.b 1	; Bits 15 to 22 of M68K bank address
PlaySegaPCMFlag:	ds.b 1
; Now starts song and SFX z80 RAM
; Max number of music channels: 6 FM + 3 PSG or 1 DAC + 5 FM + 3 PSG
zTracksStart:
zSongFM6_DAC:	zTrack
zSongFM1:		zTrack
zSongFM2:		zTrack
zSongFM3:		zTrack
zSongFM4:		zTrack
zSongFM5:		zTrack
zSongPSG1:		zTrack
zSongPSG2:		zTrack
zSongPSG3:		zTrack
zTracksEnd:
; This is RAM for backup of songs (when 1-up jingle is playing)
; and for SFX channels. Note these two overlap.
; Max number of SFX channels: 4 FM + 3 PSG
zTracksSFXStart:
zSFX_FM3:		zTrack
zSFX_FM4:		zTrack
zSFX_FM5:		zTrack
zSFX_FM6:		zTrack
zSFX_PSG1:		zTrack
zSFX_PSG2:		zTrack
zSFX_PSG3:		zTrack
zTracksSFXEnd:

		phase zTracksSFXStart
zTracksSaveStart:
zSaveSongDAC:	zTrack
zSaveSongFM1:	zTrack
zSaveSongFM2:	zTrack
zSaveSongFM3:	zTrack
zSaveSongFM4:	zTrack
zSaveSongFM5:	zTrack
zSaveSongPSG1:	zTrack
zSaveSongPSG2:	zTrack
zSaveSongPSG3:	zTrack
zTracksSaveEnd:
	if * > PCM_Buffer	; Don't declare more space than the RAM can contain!
		fatal "The RAM variable declarations are too large. It's \{*-PCM_Buffer}h bytes past the end of Z80 RAM."
	endif
		dephase
; ---------------------------------------------------------------------------
		!org z80_SoundDriverStart
z80_SoundDriver:
		save
		!org	0							; z80 Align, handled by the build process
		CPU Z80
		listing purecode
; ---------------------------------------------------------------------------
MusID__First			= 01h
MusID_1UP				= 20h
MusID_Emerald			= 2Bh
MusID__End				= 33h
SndID__First			= MusID__End
SndID_Ring				= SndID__First
SndID_Spindash			= 0ABh
SndID__FirstContinuous	= 0BCh
SndID__End				= 0E0h
FadeID__First			= 0E1h
FadeID__End				= 0E6h
SndID_StopSega			= 0FEh
SndID_Sega				= 0FFh
; ---------------------------------------------------------------------------
NoteRest				= 080h
FirstCoordFlag			= 0E0h
; ---------------------------------------------------------------------------
zID_MusicPointers = 0
zID_SFXPointers = 2
zID_ModEnvPointers = 4
zID_VolEnvPointers = 6
; ---------------------------------------------------------------------------

; ===========================================================================
; Macros
; ===========================================================================
bankswitch1 macro
	ld	hl, zBankRegister
	ld	(hl), a
	rept 7
		rrca
		ld	(hl), a
	endm
	xor	a
	ld	(hl), a
    endm

bankswitch2 macro
	ld	hl, zBankRegister
	ld	(hl), a
	rept 7
		rra
		ld	(hl), a
	endm
	xor	a
	ld	(hl), a
    endm

bankswitch3 macro
	ld	b, 8

.bankloop:
	ld	(zBankRegister), a
	rrca
	djnz	.bankloop
	xor	a
	ld	(zBankRegister), a
    endm

bankswitchToMusic macro
	ld	a, (zSongBank)
	bankswitch2
    endm

; macro to make a certain error message clearer should you happen to get it...
rsttarget macro {INTLABEL}
	if ($&7)||($>38h)
		fatal "Function __LABEL__ is at 0\{$}h, but must be at a multiple of 8 bytes <= 38h to be used with the rst instruction."
	endif
	if "__LABEL__"<>""
__LABEL__ label $
	endif
    endm

; function to turn a 68k address into a word the Z80 can use to access it
zmake68kPtr function addr,zROMWindow+(addr&7FFFh)

; function to turn a 68k address into a bank byte
zmake68kBank function addr,(((addr&3F8000h)/zROMWindow))
; ---------------------------------------------------------------------------
; ===========================================================================
; Entry Point
; ===========================================================================

; EntryPoint:
		di						; Disable interrupts
		ld	sp, z80_stack				; set the stack pointer to 0x2000 (end of z80 RAM)
		jp	zInitAudioDriver

; =============== S U B	R O U T	I N E =======================================
;
; Gets the correct pointer to pointer table for the data type in question
; (music, sfx, voices, etc.).
;
; Input:  c    ID for data type.
; Output: hl   Master pointer table for	index
;         af'  Trashed
;         b    Trashed

; sub_8
	align	8
GetPointerTable:	rsttarget
		ld	hl, z80_SoundDriverPointers		; Load pointer table
		ld	b, 0					; b = 0
		add	hl, bc					; Add offset into pointer table
		ex	af, af'					; Back up af
		ld	a, (hl)					; Read low byte of pointer into a
		inc	hl
		ld	h, (hl)					; Read high byte of pointer into h
		ld	l, a					; Put low byte of pointer into l
		ex	af, af'					; Restore af
		ret

; =============== S U B	R O U T	I N E =======================================
;
; Reads	an offset into a pointer table and returns dereferenced pointer.
;
;
; Input:  a    Index into pointer table
;	      hl   Pointer to pointer table
; Output: hl   Selected	pointer	in pointer table
;         bc   Trashed

; sub_18
	align	8
PointerTableOffset:	rsttarget
		ld	c, a					; c = index into pointer table
		ld	b, 0					; b = 0
		add	hl, bc					; hl += bc
		add	hl, bc					; hl += bc
		jp	ReadPointer				; 10 clock cycles, 3 bytes

; =============== S U B	R O U T	I N E =======================================
;
; Dereferences a pointer.
;
; Input:  hl	Pointer
; output: hl	Equal to what that was being pointed to by hl

; loc_20
	align	8
ReadPointer:	rsttarget
		ld	a, (hl)					; Read low byte of pointer into a
		inc	hl
		ld	h, (hl)					; Read high byte of pointer into h
		ld	l, a					; Put low byte of pointer into l
		ret

; ---------------------------------------------------------------------------
; There is room for two more 'rsttarget's here
; ---------------------------------------------------------------------------

	align	8

	align	38h
; =============== S U B	R O U T	I N E =======================================
;
; This subroutine is called every V-Int. After it is processed, the z80
; returns to the digital audio loop to continue playing DAC samples.
;
; If the SEGA PCM is being played, it disables interrupts -- this means that
; this procedure will NOT be called while the SEGA PCM is playing.
;
;zsub_38
zVInt:	rsttarget
		push	bc
		push	de
		push	hl
		push	ix
		ex	af, af'
		push	af

.doupdate:
		call	zUpdateEverything			; Update all tracks
		ld	a, (zPalFlag)				; Get PAL flag
		or	a					; Is it set?
		jr	z, .not_pal				; Branch if not (NTSC)
		ld	a, (zPalDblUpdCounter)			; Get PAL double-update timeout counter
		or	a					; Is it zero?
		jr	nz, .pal_timer				; Branch if not
		ld	a, 5					; Set it back to 5...
		ld	(zPalDblUpdCounter), a			; ... and save it
		jp	.doupdate				; Go again

.pal_timer:
		dec	a					; Decrease PAL double-update timeout counter
		ld	(zPalDblUpdCounter), a			; Store it

.not_pal:
		ld	a, i					; Get index of playing DAC sample
		and	7Fh					; Strip 'DAC playing' bit
		ld	c, a					; c = a
		ld	b, 0					; Sign extend c to bc
		ld	hl, DAC_Banks				; Make hl point to DAC bank table
		add	hl, bc					; Offset into entry for current sample
		ld	a, (hl)					; Get bank index
		bankswitch1					; Switch to current DAC sample's bank

	; the PCM routine needs the register the be already set
		ld	a, 2Ah					; DAC channel register
		ld	(zYM2612_A0), a				; Send to YM2612

		xor	a					; set a to 0
		ld	(PCM_Status),a				; save status

		pop	af
		ex	af, af'
		pop	ix
		pop	hl
		pop	de
		pop	bc
		ret
; ---------------------------------------------------------------------------
;loc_85
zInitAudioDriver:
		im	2

	; The following instruction block keeps the z80 in a tight loop.
		ld	c, 0					; c = 0
.loop:
		ld	b, 0					; b = 0
		djnz	$					; Loop in this instruction, decrementing b each iteration, until b = 0
		dec	c					; c--
		jr	z, .loop				; Loop if c = 0

		call	zMusicStop				; Stop all music
		ld	a, zmake68kBank(MusBnk2)		; Set song bank to second music bank (default value)
		ld	(zSongBank), a				; Store it

		xor	a					; a = 0
		ld	(zSpindashRev), a			; Reset spindash rev
		ld	i, a					; Clear current DAC sample index
		ld	(PlaySegaPCMFlag), a			; Clear the Sega sound flag
		ld	(zRingSpeaker), a			; Make rings play on left speaker

		ld	a, 5					; Set PAL double-update counter to 5
		ld	(zPalDblUpdCounter), a			; (that is, do not double-update for 5 frames)

; ---------------------------------------------------------------------------
; Plays digital audio on the DAC, if any is queued. The z80 will be stuck in
; this function unless an interrupt occurs (that is, V-Int); after the V-Int
; is processed, the z80 will return back here.
; ---------------------------------------------------------------------------

PCM_CheckExecute	macro
	ld	a,(PCM_Status)	; 13			; load PCM status to a
	or	a		; 4			; check the value
	jp	p, .skip	; 10			; if positive, do not run tracker
	rst	zVInt		; a lot			; run tracker (v-int routine)
.skip
	endm

zPlayDigitalAudio:
		ld	a, 2Bh					; DAC enable/disable register
		ld	c, 0					; Value to disable DAC
		call	zWriteFMI				; Send YM2612 command

.idle		ld	a, i					; load DAC number requested
		jp	nz, .run				; branch if nonzero

		PCM_CheckExecute				; check what we need to execute
		jr	.idle					; keep loopin!
; ---------------------------------------------------------------------------

.run		ld	b, a					; back up in b
		or	80h					; set bit7 to indicate dac is playing
		ld	i, a					; save back into 1

		ld	a, b					; load original sample back
		ld	hl, zmake68kPtr(DacBank1)-2		; load offset into hl
		rst	PointerTableOffset			; hl is now pointer for dac data

		ld	a, 2Bh					; DAC enable/disable register
		ld	c, 80h					; Value to enable DAC
		call	zWriteFMI				; Send YM2612 command

		ld	a, 2Ah					; DAC channel register
		ld	(zYM2612_A0), a				; Send to YM2612
		ld	a, (hl)					; load DAC rate to a

	; load the length of the sample to de
		inc	hl
		ld	e, (hl)
		inc	hl
		ld	d, (hl)

	; load sample address
		inc	hl
		ld	c, (hl)
		inc	hl
		ld	b, (hl)

		db 0DDh, 2Eh, 1	; ld ixl, 1			; prepare 1 in ixl
		ld	hl, PCM_Buffer				; load PCM buffer location to hl
		exx						; swap registers

		ld	c,a					; store DAC rate in c'
		ld	h, .lut>>8				; load upper byte of dac table to h
		ld	de, PCM_Buffer				; load PCM buffer location to de
		exx						; swap registers

		ex	af, af'
		ld	a, 80h					; initialize accumulator to 80h
		ex	af, af'
		jp	.sampleloop
; ---------------------------------------------------------------------------
; JMan2050's DAC decode lookup table
; ---------------------------------------------------------------------------
	align 100h	; NAT: This table must be aligned to 100h bytes!!!
.lut		db	   0,  1,   2,   4,   8,  10h,  20h,  40h
		db	 80h, -1,  -2,  -4,  -8, -10h, -20h, -40h
; ---------------------------------------------------------------------------
; GOAL 293
; REGISTERS	318 318
; BC - sample address
; DE - Sample length
; HL - PCM buffer write
; A' - DPCM accumulator
; C' - DPCM rate
; DE' - PCM buffer read
; HL' - DPCM LUT
; ---------------------------------------------------------------------------

.readbyte	macro
	ld	a,(bc)			; 7		; load byte of sample data
	ld	(hl),a			; 7		; save it out immediately
	inc	bc			; 6		; increase sample position
	inc	l			; 4	; 24	; increase buffer pos
    endm

.readhi		macro
	ld	a,(de)			; 7		; load byte from buffer
	rlca				; 4
	rlca				; 4
	rlca				; 4
	rlca				; 4
	and	0Fh			; 7	; 30	; a is now the high nibble from buffer, except in low nibble
    endm

.readlo		macro
	ld	a,(de)			; 7		; load byte from buffer
	inc	e			; 4		; increase buffer pos
	and	0Fh			; 7	; 18	; a is now the low nibble from buffer
    endm

.accumulate	macro
	ld	l,a			; 4		; copy a into l (making hl the right byte in lut)
	ex	af, af'			; 4		; load accumulator to a
	add	a,(hl)			; 7		; add LUT value to a
	ld	(zYM2612_D0), a		; 13		; write it to the YM port
	ex	af, af'			; 4	; 32	; swap back for later
    endm

.delay		macro
	ld	b, c			; 4		; load delay counter to b
	djnz	$			; 8 + b*13	; loop here to delay the processor
    endm
; ---------------------------------------------------------------------------

.sampleloop	db 0DDh, 2Ch	; inc ixl	; 8		; increase read byte count
		jp	z, .writeonly3		; 10		; if overflowed, read 1 byte at a time
		PCM_CheckExecute		; 27		; check what we need to execute
		jp	nz, .writeonly		; 10	; 55	; if nonzero, write PCM only

.writeread	.readbyte			; 24		; read byte from the ROM
		exx				; 4	; 28	; swap registers

		.readhi				; 30		; read the high nibble of sample
		.accumulate			; 32	; 62	; write the next byte into YM2612 and accumulate it

.delay1		.delay				; 12		; process delay
		exx				; 4	; 16	; swap registers

		PCM_CheckExecute		; 27		; check what we need to execute
		jp	nz, .writeonly2		; 10	; 37	; if nonzero, write PCM only

.writeread2	.readbyte			; 24		; read byte from the ROM
		dec	de			; 6		; decrement sample size
		exx				; 4	; 34	; swap registers

		.readlo				; 18		; read the low nibble of sample
		.accumulate			; 32	; 50	; write the next byte into YM2612 and accumulate it

.delay2		.delay				; 12		; process delay
		exx				; 4	; 16	; swap registers
; ---------------------------------------------------------------------------

.sampcheck	ld	a, i			; 7		; load sample index to a
		jp	p, .run			; 10	; 17	; if positive, new sample is requested

		add	a,d			; 4		; add sample position into a (high byte), and check for overflow
		jp	nc, .sampleloop		; 10	; 14	; if sample is not yet finished, branch

		xor	a					; clear a
		ld	i, a					; set no sample playing
		jp	zPlayDigitalAudio			; go idle
; ---------------------------------------------------------------------------

.writeonly3	PCM_CheckExecute		; 27		; check what we need to execute
		jp	nz, .writeonly		; 10	; 37	; if nonzero, write PCM only

.writeonly	ld	a,2			; 7		; prepare 0 into a
		db 0DDh, 0BDh	; cp ixl	; 8		; check if the value is already this
		jp	z, .waitread		; 10		; if no more bytes, wait until dma is over
		exx				; 4	; 29	; swap registers

		.readhi				; 30		; read the high nibble of sample
		.accumulate			; 32	; 62	; write the next byte into YM2612 and accumulate it

.delay5		.delay				; 12		; process delay
		exx				; 4	; 16	; swap registers

		db 0DDh, 2Dh	; dec ixl	; 8		; decrease read byte count
		PCM_CheckExecute		; 27	; 35	; check what we need to execute

.writeonly2	dec	de			; 6		; decrement sample size
		db 0DDh, 2Dh	; dec ixl	; 8		; decrease read byte count
		exx				; 4	; 18	; swap registers

		.readlo				; 18		; read the low nibble of sample
		.accumulate			; 32	; 50	; write the next byte into YM2612 and accumulate it

.delay6		.delay				; 12		; process delay
		exx				; 4		; swap registers
		jp	.sampcheck		; 10	; 26
; ---------------------------------------------------------------------------

.waitread	PCM_CheckExecute		; 27		; check what we need to execute
		jp	z, .writeread		; 10	; 37	; if nonzero, write PCM only
		jp	.waitread		; 10		; wait longer
; =============== S U B	R O U T	I N E =======================================
;
; Writes a reg/data pair to part I or II
;
; Input:  a    Value for register
;         c    Value for data
;         ix   Pointer to track RAM

;sub_AF
zWriteFMIorII:
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		ret	nz					; Is so, quit
		bit	2, (ix+zTrack.PlaybackControl)		; Is SFX overriding this track?
		ret	nz					; Return if yes

		add	a, (ix+zTrack.VoiceControl)		; Add the channel bits to the register address
		bit	2, (ix+zTrack.VoiceControl)		; Is this the DAC channel or FM4 or FM5 or FM6?
		jr	nz, zWriteFMII_reduced			; If yes, write reg/data pair to part II;
								; otherwise, write reg/data pair as is to part I.

; =============== S U B	R O U T	I N E =======================================
;
; Writes a reg/data pair to part I
;
; Input:  a    Value for register
;         c    Value for data

;sub_C2
zWriteFMI:
		ld	(zYM2612_A0), a					; Select YM2612 register
		nop									; Wait
		ld	a, c							; a = data to send
		ld	(zYM2612_D0), a					; Send data to register
		ret
; ---------------------------------------------------------------------------

;loc_CB
zWriteFMII_reduced:
		sub	4								; Strip 'bound to part II regs' bit
; ---------------------------------------------------------------------------

; =============== S U B	R O U T	I N E =======================================
;
; Writes a reg/data pair to part II
;
; Input:  a    Value for register
;         c    Value for data

;sub_CD
zWriteFMII:
		ld	(zYM2612_A1), a					; Select YM2612 register
		nop									; Wait
		ld	a, c							; a = data to send
		ld	(zYM2612_D1), a					; Send data to register
		ret
; End of function zWriteFMII

; ---------------------------------------------------------------------------
; ===========================================================================
; DAC BANKS
; ===========================================================================
; Note: this table has a dummy first entry for the case when there is no DAC
; sample being played -- the code still results in a valid bank switch, and
; does not need to worry about special cases.
DAC_Banks:
	dacbk 81, 81, 82_83_84_85, 82_83_84_85, 82_83_84_85, 82_83_84_85, 86, 87
	dacbk 88, 89, 8A_8B, 8A_8B, 8C, 8D_8E, 8D_8E, 8F
	dacbk 90_91_92_93, 90_91_92_93, 90_91_92_93, 90_91_92_93, 94_95_96_97, 94_95_96_97, 94_95_96_97, 94_95_96_97
	dacbk 98_99_9A, 98_99_9A, 98_99_9A, 9B, 9C, 9D, 9E, 9F
	dacbk A0, A1, A2, A3, A4, A5, A6, A7
	dacbk A8, A9, AA, AB, AC, AD_AE, AD_AE, AF_B0
	dacbk AF_B0, B1, B2_B3, B2_B3, B4_C1_C2_C3_C4, B5, B6, B7
	dacbk B8_B9, B8_B9, BA, BB, BC, BD, BE, BF
	dacbk C0, B4_C1_C2_C3_C4, B4_C1_C2_C3_C4, B4_C1_C2_C3_C4, B4_C1_C2_C3_C4, B2_B3, B2_B3;, B2_B3

	dacbk Clap, ClapKick, Scratch

; =============== S U B	R O U T	I N E =======================================
;
;sub_11B
zUpdateEverything:
		call	zPauseUnpause				; Pause/unpause according to M68K input
		call	zUpdateSFXTracks			; Do SFX tracks

;loc_121
zUpdateMusic:
		call	TempoWait					; Delay song tracks as appropriate for main tempo mod
		call	zDoMusicFadeOut				; Check if music should be faded out and fade if needed
		call	zDoMusicFadeIn				; Check if music should be faded in and fade if needed

.check_fade_in:
		ld	a, (zFadeToPrevFlag)			; Get fade-to-previous flag
		cp	0FFh							; Is it 0FFh?
		jr	z, .update_music				; Branch if yes
		ld	hl, zMusicNumber				; Point hl to M68K input
		ld	e, (hl)							; e = next song to play
		inc	hl								; Advance pointer
		ld	d, (hl)							; d = next SFX to play
		inc	hl								; Advance pointer
		ld	a, (hl)							; a = next SFX to play
		or	d								; Combine bits of a and d
		or	e								; Is anything in the play queue?
		jr	z, .update_music				; Branch if not
		call	zFillSoundQueue				; Transfer M68K input
		call	zCycleSoundQueue			; Cycle queue and play first entry
		call	zCycleSoundQueue			; Cycle queue and play second entry
		call	zCycleSoundQueue			; Cycle queue and play third entry

.update_music:
		ld	a, (zSongBank)					; Get bank ID for music
		bankswitch2							; Bank switch to it
		xor	a								; a = 0
		ld	(zUpdatingSFX), a				; Updating music
		ld	a, (zFadeToPrevFlag)			; Get fade-to-previous flag
		cp	0FFh							; Is it 0FFh?
		call	z, zFadeInToPrevious		; Fade to previous if yes
		ld	ix, zSongFM6_DAC				; ix = FM6/DAC track RAM
		bit	7, (ix+zTrack.PlaybackControl)	; Is FM6/DAC track playing?
		call	nz, zUpdateDACTrack			; Branch if yes
		ld	b, (zTracksEnd-zSongFM1)/zTrack.len	; Number of tracks
		ld	ix, zSongFM1					; ix = FM1 track RAM
		jr	zTrackUpdLoop					; Play all tracks

; =============== S U B	R O U T	I N E =======================================
;
;sub_19E
zUpdateSFXTracks:
		ld	a, 1							; a = 1
		ld	(zUpdatingSFX), a				; Updating SFX
		ld	a, zmake68kBank(SndBank)		; Get SFX bank ID
		bankswitch2							; Bank switch to SFX
		ld	ix, zTracksSFXStart				; ix = start of SFX track RAM
		ld	b, (zTracksSFXEnd-zTracksSFXStart)/zTrack.len	; Number of channels

zTrackUpdLoop:
		push	bc							; Save bc
		bit	7, (ix+zTrack.PlaybackControl)	; Is track playing?
		call	nz, zUpdateFMorPSGTrack		; Call routine if yes
		ld	de, zTrack.len					; Spacing between tracks
		add	ix, de							; Advance to next track
		pop	bc								; Restore bc
		djnz	zTrackUpdLoop				; Loop for all tracks

	if extra_flags==1
		ld	a,(SYNC)
		or	a
		jp	nz, cfFreeze
	endif

		ld	a, (zTempoSpeedup)				; Get tempo speed-up value
		or	a								; Is music sped up?
		ret	z								; Return if not
		ld	a, (zSpeedupTimeout)			; Get extra tempo timeout
		or	a								; Has it expired?
		jp	nz, .no_dbl_update				; Branch if not
		ld	a, (zTempoSpeedup)				; Get master tempo speed-up value
		ld	(zSpeedupTimeout), a			; Reset extra tempo timeout to it
		jp	zUpdateMusic					; Update music again
; ---------------------------------------------------------------------------
.no_dbl_update:
		dec	a								; Decrement timeout...
		ld	(zSpeedupTimeout), a			; ... then store new value
		ret
; End of function zUpdateSFXTracks


; =============== S U B	R O U T	I N E =======================================
; Updates FM or PSG track.
;
;sub_1E9
zUpdateFMorPSGTrack:
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG channel?
		jp	nz, zUpdatePSGTrack				; Branch if yes
		dec	(ix+zTrack.DurationTimeout)		; Run note timer
		jr	nz, .note_going					; Branch if note hasn't expired yet
		call	zGetNextNote				; Get next note for FM track
		bit	4, (ix+zTrack.PlaybackControl)	; Is track resting?
		ret	nz								; Return if yes
		call	zPrepareModulation			; Initialize modulation
		call	zUpdateFreq					; Add frequency displacement to frequency
		call	zDoModulation				; Apply modulation
		call	zFMSendFreq					; Send frequency to YM2612
		jp	zFMNoteOn						; Note on on all operators
; ---------------------------------------------------------------------------
.note_going:
	bit	0,(ix+zTrack.PSGSustain)			; MJ: is the track in sustain mode?
	ret	nz						; MJ: if so, return
		bit	4, (ix+zTrack.PlaybackControl)	; Is track resting?
		ret	nz								; Return if yes
		call	zDoFMVolEnv					; Do FM volume envelope effects for track
		ld	a, (ix+zTrack.NoteFillTimeout)	; Get note fill timeout
		or	a								; Is timeout either not running or expired?
		jr	z, .keep_going					; Branch if yes
		dec	(ix+zTrack.NoteFillTimeout)		; Update note fill timeout
		jp	z, zKeyOffIfActive				; Send key off if needed

.keep_going:
		call	zUpdateFreq					; Add frequency displacement to frequency
		bit	6, (ix+zTrack.PlaybackControl)	; Is 'sustain frequency' bit set?
		ret	nz								; Return if yes
		call	zDoModulation				; Apply modulation then fall through
		; Fall through to next function
; End of function zUpdateFMorPSGTrack


; =============== S U B	R O U T	I N E =======================================
; Uploads track's frequency to YM2612.
;
; Input:   ix    Pointer to track RAM
;          hl    Frequency to upload
;          de    For FM3 in special mode, pointer to extra FM3 frequency data (never correctly set)
; Output:  a     Trashed
;          bc    Trashed
;          hl    Trashed
;          de    Increased by 8
;
;sub_22B
zFMSendFreq:
		bit	2, (ix+zTrack.PlaybackControl)	; Is SFX overriding this track?
		ret	nz								; Return if yes
		bit	0, (ix+zTrack.PlaybackControl)	; Is track in special mode (FM3 only)?
		jp	nz, .special_mode				; Branch if yes

.not_fm3:
		ld	a, 0A4h							; Command to update frequency MSB
		ld	c, h							; High byte of frequency
		call	zWriteFMIorII				; Send it to YM2612
		ld	a, 0A0h							; Command to update frequency LSB
		ld	c, l							; Low byte of frequency
		jp	zWriteFMIorII					; Send it to YM2612
; ---------------------------------------------------------------------------
.special_mode:
		ld	a, (ix+zTrack.VoiceControl)		; a = voice control byte
		cp	2								; Is this FM3?
		jr	nz, .not_fm3					; Branch if not
		call	zGetSpecialFM3DataPointer	; de = pointer to saved FM3 frequency shifts
		ld	b, zSpecialFreqCommands_End-zSpecialFreqCommands	; Number of entries
		ld	hl, zSpecialFreqCommands		; Lookup table

		; DANGER! de is unset here, and could be pointing anywhere! Luckily,
		; only reads are performed from it.
.loop:
		push	bc							; Save bc
		ld	a, (hl)							; a = register selector
		inc	hl								; Advance pointer
		push	hl							; Save hl
		ex	de, hl							; Exchange de and hl
		ld	c, (hl)							; Get byte from whatever the hell de was pointing to
		inc	hl								; Advance pointer
		ld	b, (hl)							; Get byte from whatever the hell de was pointing to
		inc	hl								; Advance pointer
		ex	de, hl							; Exchange de and hl
		ld	l, (ix+zTrack.FreqLow)			; l = low byte of track frequency
		ld	h, (ix+zTrack.FreqHigh)			; h = high byte of track frequency
		add	hl, bc							; hl = full frequency for operator
		push	af							; Save af
		ld	c, h							; High byte of frequency
		call	zWriteFMI					; Sent it to YM2612
		pop	af								; Restore af
		sub	4								; Move on to frequency LSB
		ld	c, l							; Low byte of frequency
		call	zWriteFMI					; Sent it to YM2612
		pop	hl								; Restore hl
		pop	bc								; Restore bc
		djnz	.loop						; Loop for all operators
		ret
; End of function zFMSendFreq

; ---------------------------------------------------------------------------
;loc_272
zSpecialFreqCommands:
		db 0ADh								; Operator 4 frequency MSB
		db 0AEh								; Operator 3 frequency MSB
		db 0ACh								; Operator 2 frequency MSB
		db 0A6h								; Operator 1 frequency MSB
zSpecialFreqCommands_End

; =============== S U B	R O U T	I N E =======================================
;
zGetSpecialFM3DataPointer:
		ld	de, zSpecFM3Freqs				; de = pointer to saved FM3 frequency shifts
		ld	a, (zUpdatingSFX)				; Get flag
		or	a								; Is this a SFX track?
		ret	z								; Return if not
		ld	de, zSpecFM3FreqsSFX				; de = pointer to saved FM3 frequency shifts
		ret
; End of function zGetSpecialFM3DataPointer


; =============== S U B	R O U T	I N E =======================================
; Gets next note from the track's data stream. If any coordination flags are
; found, they are handled and then the function keeps looping until a note is
; found.
;
; Input:   ix    Pointer to track's RAM
; Output:  de    Pointer to current position on track data
;          hl    Note frequency
;          All others possibly trashed due to coordination flags
;
;sub_277
zGetNextNote:
		ld	e, (ix+zTrack.DataPointerLow)	; e = low byte of track data pointer
		ld	d, (ix+zTrack.DataPointerHigh)	; d = high byte of track data pointer
		res	1, (ix+zTrack.PlaybackControl)	; Clear 'do not attack next note' flag
		res	4, (ix+zTrack.PlaybackControl)	; Clear 'track is at rest' flag

;loc_285
zGetNextNote_cont:
		ld	a, (de)							; Get next byte from track
		inc	de								; Advance pointer
		cp	FirstCoordFlag					; Is it a coordination flag?
		jp	nc, zHandleFMorPSGCoordFlag		; Branch if yes
		ex	af, af'							; Save af
		call	zKeyOffIfActive				; Kill note
		ex	af, af'							; Restore af
		bit	3, (ix+zTrack.PlaybackControl)	; Is alternate frequency mode flag set?
		jp	nz, zAltFreqMode				; Branch if yes
		or	a								; Is this a duration?
		jp	p, zStoreDuration				; Branch if yes
		sub	81h								; Make the note into a 0-based index
		jp	p, .got_note					; Branch if it is a note and not a rest
		call	zRestTrack					; Put track at rest
		jr	zGetNoteDuration
; ---------------------------------------------------------------------------
.got_note:
		add	a, (ix+zTrack.Transpose)		; Add in transposition
		ld	hl, zPSGFrequencies				; PSG frequency lookup table
		push	af							; Save af
		rst	PointerTableOffset				; hl = frequency value for note
		pop	af								; Restore af
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		jr	nz, zGotNoteFreq				; Branch if yes
		push	de							; Save de
		ld	d, 8							; Each octave above the first adds this to frequency high bits
		ld	e, 0Ch							; 12 notes per octave
		ex	af, af'							; Exchange af with af'
		xor	a								; Clear a (which will clear a')

.loop:
		ex	af, af'							; Exchange af with af'
		sub	e								; Subtract 1 octave from the note
		jr	c, .got_displacement			; If this is less than zero, we are done
		ex	af, af'							; Exchange af with af'
		add	a, d							; One octave up
		jr	.loop							; Loop
; ---------------------------------------------------------------------------
.got_displacement:
		add	a, e							; Add 1 octave back (so note index is positive)
		ld	hl, zFMFrequencies				; FM first octave frequency lookup table
		rst	PointerTableOffset				; hl = frequency of the note on the first octave
		ex	af, af'							; Exchange af with af'
		or	h								; a = high bits of frequency (including octave bits, which were in a)
		ld	h, a							; h = high bits of frequency (including octave bits)
		pop	de								; Restore de

;loc_2CE
zGotNoteFreq:
		ld	(ix+zTrack.FreqLow), l			; Store low byte of note frequency
		ld	(ix+zTrack.FreqHigh), h			; Store high byte of note frequency

;loc_2D4
zGetNoteDuration:
		ld	a, (de)							; Get duration from the track
		or	a								; Is it an actual duration?
		jp	p, zGotNoteDuration				; Branch if yes
		jr	zFinishTrackUpdate
; ---------------------------------------------------------------------------
;loc_2E8
;zAlternateSMPS
zAltFreqMode:
		; Setting bit 3 on zTrack.PlaybackControl puts the song in a weird mode.
		;
		; This weird mode has literal frequencies and durations on the track.
		; Each byte on the track is either a coordination flag (0E0h to 0FFh) or
		; the high byte of a frequency. For the latter case, the following byte
		; is then the low byte of this same frequency.
		; If the frequency is nonzero, the (sign extended) key displacement is
		; simply *added* to this frequency.
		; After the frequency, there is then a byte that is unused.
		; Finally, there is a raw duration byte following.
		;
		; To put the track in this mode, coord. flag 0FDh can be used; if the
		; parameter byte is 1, the mode is toggled on. To turn the mode off,
		; coord. flag 0FDh can be used with a parameter != 1.
		ld	h, a							; h = byte from track
		ld	a, (de)							; a = next byte from track
		inc	de								; Advance pointer
		ld	l, a							; l = last byte read from track
		or	h								; Is hl nonzero?
		jr	z, .got_zero					; Branch if not
		ld	a, (ix+zTrack.Transpose)		; a = transposition

		ld	c, a							; bc = sign extension of key displacement
		rla									; Carry contains sign of key displacement
		sbc	a, a							; a = 0 or -1 if carry is 0 or 1
		ld	b, a							; bc = sign extension of key displacement
		add	hl, bc							; hl += key displacement

.got_zero:
		ld	(ix+zTrack.FreqLow), l			; Store low byte of note frequency
		ld	(ix+zTrack.FreqHigh), h			; Store high byte of note frequency

;loc_306
zGetRawDuration:
		ld	a, (de)							; Get raw duration from track

;loc_307
zGotNoteDuration:
		inc	de								; Advance to next byte in track

;loc_308
zStoreDuration:
		call	zComputeNoteDuration		; Multiply note by tempo divider
		ld	(ix+zTrack.SavedDuration), a	; Store it for next note

;loc_30E
zFinishTrackUpdate:
	if extra_flags==1
		ld	hl,SYNC
		ld	a,(hl)
		or	a
		jp	z, .nosync
		dec	(hl)
.nosync
	endif

		ld	(ix+zTrack.DataPointerLow), e	; Save low byte of current location in song
		ld	(ix+zTrack.DataPointerHigh), d	; Save high byte of current location in song
		ld	a, (ix+zTrack.SavedDuration)	; Get current saved duration
		ld	(ix+zTrack.DurationTimeout), a	; Set it as duration timeout
		bit	1, (ix+zTrack.PlaybackControl)	; Is 'do not attack next note' flag set?
		ret	nz								; Return if yes
		xor	a								; Clear a
		ld	(ix+zTrack.ModulationSpeed), a	; Clear modulation speed
		ld	(ix+zTrack.ModulationValLow), a	; Clear low byte of accumulated modulation
		ld	(ix+zTrack.VolEnv), a			; Reset volume envelope
		ld	a, (ix+zTrack.NoteFillMaster)	; Get master note fill
		ld	(ix+zTrack.NoteFillTimeout), a	; Set note fill timeout
		ret
; End of function zGetNextNote


; =============== S U B	R O U T	I N E =======================================
; This routine multiplies the note duration by the tempo divider. This can
; easily overflow, as the result is stored in a byte.
;
; Input:   a    Note duration
; Output:  a    Final note duration
;          b    zero
;          c    Damaged
;sub_330
zComputeNoteDuration:
		ld	b, (ix+zTrack.TempoDivider)		; Get tempo divider for this track
		dec	b								; Make it into a loop counter
		ret	z								; Return if it was 1
		ld	c, a							; c = a

.loop:
		add	a, c							; a += c
		djnz	.loop						; Loop
		ret
; ---------------------------------------------------------------------------
;loc_342
zFMNoteOn:
		ld	a, (ix+zTrack.FreqLow)			; Get low byte of note frequency
		or	(ix+zTrack.FreqHigh)			; Is the note frequency zero?
		ret	z								; Return if yes
		ld	a, (ix+zTrack.PlaybackControl)	; Get playback control byte for track

		and	16h								; Is either bit 4 ("track at rest") or 2 ("SFX overriding this track") or bit 1 ("do not attack next note") set?
		ret	nz								; Return if yes
		ld	a, (ix+zTrack.VoiceControl)		; Get voice control byte from track
		or	0F0h							; We want only the FM channel assignment bits
		ld	c, a							; Key on for all operators
		ld	a, 28h							; Select key on/of register
		jp	zWriteFMI						; Send command to YM2612
; ---------------------------------------------------------------------------

; =============== S U B	R O U T	I N E =======================================
; Writes reg/data pair to register 28h (key on/off) if track active
;
; Input:   ix   Track data
; Output:  a    Damaged
;          c    Damaged
;sub_35B
zKeyOffIfActive:
		ld	a, (ix+zTrack.PlaybackControl)	; Get playback control byte for track
		and	6								; Is either bit 1 ("do not attack next note") or 2 ("SFX overriding this track") set?
		ret	nz								; Return if yes
; End of function zKeyOffIfActive

; =============== S U B	R O U T	I N E =======================================
; Writes reg/data pair to register 28h (key on/off)
;
; Input:   ix   Track data
; Output:  a    Damaged
;          c    Damaged
;loc_361
zKeyOff:
		ld	c, (ix+zTrack.VoiceControl)		; Get voice control byte for track (this will turn off all operators as high nibble = 0)
		bit	7, c							; Is this a PSG track?
		ret	nz								; Return if yes
; End of function zKeyOff

; =============== S U B	R O U T	I N E =======================================
; Writes reg/data pair to register 28h (key on/off)
;
; Input:   c    Data to write
; Output:  a    Damaged
;loc_367
zKeyOnOff:
		ld	a, 28h							; Write to KEY ON/OFF port
		res	6, (ix+zTrack.PlaybackControl)	; From Dyna Brothers 2, but in a better place; clear flag to sustain frequency
		jp	zWriteFMI						; Send it
; End of function zKeyOnOff

; =============== S U B	R O U T	I N E =======================================
; Performs volume envelope effects in FM channels.
;
; Input:   ix    Pointer to track RAM
; Output:  a     Trashed
;          bc    Trashed
;          de    Trashed
;          hl    Trashed
;
;sub_36D
;zDoFMFlutter
zDoFMVolEnv:
		ld	a, (ix+zTrack.FMVolEnv)			; Get FM volume envelope
		or	a								; Is it zero?
		ret	z								; Return if yes
		ret	m								; Return if it is actually the custom SSG-EG flag
		dec	a								; Make a into an index
		ld	c, zID_VolEnvPointers			; Value for volume envelope pointer table
		rst	GetPointerTable					; hl = pointer to volume envelope table
		rst	PointerTableOffset				; hl = pointer to volume envelope for track
		call	zDoVolEnv					; a = new volume envelope
		ld	h, (ix+zTrack.TLPtrHigh)			; h = high byte to TL data pointer
		ld	l, (ix+zTrack.TLPtrLow)			; l = low byte to TL data pointer
		ld	de, zFMInstrumentTLTable		; de = pointer to FM TL register table
		ld	b, zFMInstrumentTLTable_End-zFMInstrumentTLTable	; Number of entries
		ld	c, (ix+zTrack.FMVolEnvMask)		; c = envelope bitmask

.loop:
		push	af							; Save af
		sra	c								; Divide c by 2
		push	bc							; Save bc
		jr	nc, .skip_reg					; Branch if c bit shifted was zero
		add	a, (hl)							; Add TL value to volume envelope
		and	7Fh								; Strip sign bit
		ld	c, a							; c = TL + volume envelope
		ld	a, (de)							; a = YM2612 register
		call	zWriteFMIorII				; Send TL data to YM2612

.skip_reg:
		pop	bc								; Restore bc
		inc	de								; Advance to next YM2612 register
		inc	hl								; Advance to next TL value
		pop	af								; Restore af
		djnz	.loop						; Loop for all registers
		ret
; End of function zDoFMVolEnv

; =============== S U B	R O U T	I N E =======================================
; Initializes normal modulation.
;
; Input:   ix    Pointer to track's RAM
; Output:  de    If modulation control has bit 7 set and track is to attack next note, pointer to modulation steps in track RAM
;          hl    If modulation control has bit 7 set and track is to attack next note, pointer to modulation steps in track data
;
;sub_39E
zPrepareModulation:
		bit	7, (ix+zTrack.ModulationCtrl)	; Is modulation on?
		ret	z								; Return if not
		bit	1, (ix+zTrack.PlaybackControl)	; Is 'do not attack next note' bit set?
		ret	nz								; Return if yes
		ld	e, (ix+zTrack.ModulationPtrLow)	; e = low byte of pointer to modulation data
		ld	d, (ix+zTrack.ModulationPtrHigh)	; d = high byte of pointer to modulation data
		push	ix							; Save ix
		pop	hl								; hl = pointer to track data
		ld	b, 0							; b = 0
		ld	c, zTrack.ModulationWait		; c = offset in track RAM for modulation data
		add	hl, bc							; hl = pointer to modulation data in track RAM
		ex	de, hl							; Exchange de and hl
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		ld	a, (hl)							; a = number of modulation steps
		srl	a								; Divide by 2
		ld	(de), a							; Store in track RAM
		xor	a								; a = 0
		ld	(ix+zTrack.ModulationValLow), a	; Clear low byte of accumulated modulation
		ld	(ix+zTrack.ModulationValHigh), a	; Clear high byte of accumulated modulation
		ret
; End of function zPrepareModulation

; =============== S U B	R O U T	I N E =======================================
; Applies modulation.
;
; Input:   ix    Pointer to track's RAM
;          hl    Note frequency
; Output:
;    If modulation control is 80h (normal modulation):
;          hl    Final note frequency
;          de    Pointer to modulation data in track RAM
;          iy    Pointer to modulation data in track RAM
;          bc    Unmodulated note frequency
;
;    If modulation control is nonzero and not 80h (modulation envelope effects):
;
;
;sub_3C9

zNoMod:
		xor	a
		ld	(ix+zTrack.ModulationValLow),a
		ld	(ix+zTrack.ModulationValHigh),a
		ret

zDoModulation:
		ld	a, (ix+zTrack.ModulationCtrl)	; Get modulation control byte
		or	a								; Is modulation active?
		ret	z								; Return if not
		cp	80h								; Is modulation control 80h?
		jr	nz, zDoModEnvelope				; Branch if not
		dec	(ix+zTrack.ModulationWait)		; Decrement modulation wait
		jr	nz,zNoMod							; Return if nonzero
		inc	(ix+zTrack.ModulationWait)		; Increase it back to 1 for next frame
		push	hl							; Save hl
		ld	l, (ix+zTrack.ModulationValLow)	; l = low byte of accumulated modulation
		ld	h, (ix+zTrack.ModulationValHigh)	; h = high byte of accumulated modulation
		; In non-Type 2 DAC versions of SMPS Z80, the following four instructions were below the 'jr nz'
		; which could lead to a bug where iy isn't initialised, but still used as a pointer.
		ld	e, (ix+zTrack.ModulationPtrLow)	; e = low byte of modulation data pointer
		ld	d, (ix+zTrack.ModulationPtrHigh)	; d = high byte of modulation data pointer
		push	de							; Save de
		pop	iy								; iy = pointer to modulation data
		dec	(ix+zTrack.ModulationSpeed)		; Decrement modulation speed
		jr	nz, .mod_sustain				; Branch if nonzero
		ld	a, (iy+1)						; Get original modulation speed
		ld	(ix+zTrack.ModulationSpeed), a	; Reset modulation speed timeout
		ld	a, (ix+zTrack.ModulationDelta)	; Get modulation delta per step
		ld	c, a							; c = modulation delta per step

		rla									; Carry contains sign of delta
		sbc	a, a							; a = 0 or -1 if carry is 0 or 1
		ld	b, a							; bc = sign extension of delta
		add	hl, bc							; hl += bc
		ld	(ix+zTrack.ModulationValLow), l	; Store low byte of accumulated modulation
		ld	(ix+zTrack.ModulationValHigh), h	; Store high byte of accumulated modulation

.mod_sustain:
		pop	bc								; bc = note frequency
		add	hl, bc							; hl = modulated note frequency
		dec	(ix+zTrack.ModulationSteps)		; Reduce number of modulation steps
		ret	nz								; Return if nonzero
		ld	a, (iy+3)						; Get number of steps from track data
		ld	(ix+zTrack.ModulationSteps), a	; Reset modulation steps in track RAM
		ld	a, (ix+zTrack.ModulationDelta)	; Load modulation delta
		neg									; Change its sign
		ld	(ix+zTrack.ModulationDelta), a	; Store it back
		ret
; ---------------------------------------------------------------------------
;loc_41A
;zDoFrequencyFlutter
zDoModEnvelope:
		dec	a								; Convert into pointer table index
		ex	de, hl							; Exchange de and hl; de = note frequency
		ld	c, zID_ModEnvPointers			; Value for modulation envelope pointer table
		rst	GetPointerTable					; hl = pointer to modulation envelope pointer table
		rst	PointerTableOffset				; hl = modulation envelope pointer for modulation control byte
		jr	zDoModEnvelope_cont
; ---------------------------------------------------------------------------
;zFreqFlutterSetIndex
zModEnvSetIndex:
		ld	(ix+zTrack.ModEnvIndex), a		; Set new modulation envelope index

;loc_425
;zDoFrequencyFlutter_cont
zDoModEnvelope_cont:
		push	hl							; Save hl
		ld	c, (ix+zTrack.ModEnvIndex)		; c = modulation envelope index
		ld	b, 0							; b = 0
		add	hl, bc							; Offset into modulation envelope table

		ld	c, l
		ld	b, h
		ld	a, (bc)							; a = new modulation envelope value
		pop	hl								; Restore hl
		bit	7, a							; Is modulation envelope negative?
		jp	z, zlocPositiveModEnvMod		; Branch if not
		cp	82h								; Is it 82h?
		jr	z, zlocChangeModEnvIndex		; Branch if yes
		cp	80h								; Is it 80h?
		jr	z, zlocResetModEnvMod			; Branch if yes
		cp	84h								; Is it 84h?
		jr	z, zlocModEnvIncMultiplier		; Branch if yes
		ld	h, 0FFh							; h = 0FFh
		jr	nc, zlocApplyModEnvMod			; Branch if more than 84h
		set	6, (ix+zTrack.PlaybackControl)	; Set 'sustain frequency' bit
		pop	hl								; Tamper with return location so as to not return to caller
		ret
; ---------------------------------------------------------------------------
;loc_449
;zlocChangeFlutterIndex
zlocChangeModEnvIndex:
		inc	bc								; Increment bc
		ld	a, (bc)							; Use it as a pointer??? Getting bytes from code region?
		jr	zModEnvSetIndex					; Set position to nonsensical value
; ---------------------------------------------------------------------------
;loc_44D
;zlocResetFlutterMod
zlocResetModEnvMod:
		xor	a								; a = 0
		jr	zModEnvSetIndex					; Reset position for modulation envelope
; ---------------------------------------------------------------------------
;loc_450
;zlocFlutterIncMultiplier
zlocModEnvIncMultiplier:
		inc	bc								; Increment bc
		ld	a, (bc)							; Use it as a pointer??? Getting bytes from code region?
		add	a, (ix+zTrack.ModEnvSens)		; Add envelope sensibility to a...
		ld	(ix+zTrack.ModEnvSens), a		; ... then store new value
		inc	(ix+zTrack.ModEnvIndex)			; Advance envelope modulation...
		inc	(ix+zTrack.ModEnvIndex)			; ... twice.
		jr	zDoModEnvelope_cont
; ---------------------------------------------------------------------------
;loc_460
;zlocPositiveFlutterMod
zlocPositiveModEnvMod:
		ld	h, 0							; h = 0

;loc_462
;zlocApplyFlutterMod
zlocApplyModEnvMod:
		ld	l, a							; hl = sign extension of modulation value
		ld	b, (ix+zTrack.ModEnvSens)		; Fetch envelope sensibility
		inc	b								; Increment it (minimum 1)
		ex	de, hl							; Swap hl and de; hl = note frequency

.loop:
		add	hl, de							; hl += de
		djnz	.loop						; Make hl = note frequency + b * de
		inc	(ix+zTrack.ModEnvIndex)			; Advance modulation envelope
		ret
; End of function zDoModulation

; =============== S U B	R O U T	I N E =======================================
; Adds the current frequency displacement (signed) to note frequency.
;
; Input:   ix    Track RAM
; Output:  hl    Shifted frequency
;          a     Damaged
;          bc    Damaged
;
;sub_46F
;zDoPitchSlide
zUpdateFreq:
		ld	h, (ix+zTrack.FreqHigh)			; h = high byte of note frequency
		ld	l, (ix+zTrack.FreqLow)			; l = low byte of note frequency

		ld	a, (ix+zTrack.Detune)			; a = detune
		ld	c, a							; bc = sign extension of frequency displacement
		rla									; Carry contains sign of frequency displacement
		sbc	a, a							; a = 0 or -1 if carry is 0 or 1
		ld	b, a							; bc = sign extension of frequency displacement

		add	hl, bc							; Add to frequency
		ret
; End of function zUpdateFreq

; =============== S U B	R O U T	I N E =======================================
; Gets offset for requested FM instrument.
;
;sub_483
zGetFMInstrumentPointer:
		ld	hl, (zVoiceTblPtr)				; hl = pointer to voice table
		ld	a, (zUpdatingSFX)				; Get flag
		or	a								; Is this a SFX track?
		jr	z, zGetFMInstrumentOffset		; Branch if not
		ld	l, (ix+zTrack.VoicesLow)		; l = low byte of track's voice pointer
		ld	h, (ix+zTrack.VoicesHigh)		; h = high byte of track's voice pointer

;loc_492
zGetFMInstrumentOffset:
		xor	a								; a = 0
		or	b								; Is FM instrument the first one (zero)?
		ret	z								; Return if so
		ld	de, 25							; Size of each FM instrument

.loop:
		add	hl, de							; Advance pointer to next instrument
		djnz	.loop						; Loop until instrument offset is found
		ret
; End of function zGetFMInstrumentPointer

; ---------------------------------------------------------------------------
;loc_49C
zFMInstrumentRegTable:
		db 0B0h								; Feedback/Algorithm
zFMInstrumentOperatorTable:
		db  30h								; Detune/multiple operator 1
		db  38h								; Detune/multiple operator 3
		db  34h								; Detune/multiple operator 2
		db  3Ch								; Detune/multiple operator 4
zFMInstrumentRSARTable:
		db  50h								; Rate scaling/attack rate operator 1
		db  58h								; Rate scaling/attack rate operator 3
		db  54h								; Rate scaling/attack rate operator 2
		db  5Ch								; Rate scaling/attack rate operator 4
zFMInstrumentAMD1RTable:
		db  60h								; Amplitude modulation/first decay rate operator 1
		db  68h								; Amplitude modulation/first decay rate operator 3
		db  64h								; Amplitude modulation/first decay rate operator 2
		db  6Ch								; Amplitude modulation/first decay rate operator 4
zFMInstrumentD2RTable:
		db  70h								; Secondary decay rate operator 1
		db  78h								; Secondary decay rate operator 3
		db  74h								; Secondary decay rate operator 2
		db  7Ch								; Secondary decay rate operator 4
zFMInstrumentD1LRRTable:
		db  80h								; Secondary amplitude/release rate operator 1
		db  88h								; Secondary amplitude/release rate operator 3
		db  84h								; Secondary amplitude/release rate operator 2
		db  8Ch								; Secondary amplitude/release rate operator 4
zFMInstrumentOperatorTable_End
;loc_4B1
zFMInstrumentTLTable:
		db  40h								; Total level operator 1
		db  48h								; Total level operator 3
		db  44h								; Total level operator 2
		db  4Ch								; Total level operator 4
zFMInstrumentTLTable_End
;loc_4B5
zFMInstrumentSSGEGTable:
		db  90h								; SSG-EG operator 1
		db  98h								; SSG-EG operator 3
		db  94h								; SSG-EG operator 2
		db  9Ch								; SSG-EG operator 4
zFMInstrumentSSGEGTable_End

; =============== S U B	R O U T	I N E =======================================
; Subroutine to send FM instrument data to YM2612 chip.
;
;sub_4B9
zSendFMInstrument:
		ld	de, zFMInstrumentRegTable		; de = pointer to register output table
		ld	c, (ix+zTrack.AMSFMSPan)		; Send track AMS/FMS/panning
		ld	a, 0B4h							; Select AMS/FMS/panning register
		call	zWriteFMIorII				; Set track data
		call	zSendFMInstrData			; Send data to register
		ld	(ix+zTrack.FeedbackAlgo), a		; Save current feedback/algorithm

	if 0==1;fix_sndbugs
		; Start with detune/multiplier operators
		ld	b, zFMInstrumentRSARTable-zFMInstrumentOperatorTable	; Number of commands to issue

.loop1:
		call	zSendFMInstrData			; Send FM instrument data
		djnz	.loop1						; Loop

		; Now for rate scaling/attack rate. The attack rate must be 1Fh if using
		; SSG-EG, which is the reason for the split.
		ld	b, zFMInstrumentAMD1RTable-zFMInstrumentRSARTable	; Number of commands to issue

.loop2:
		call	zSendFMInstrDataRSAR		; Send FM instrument data
		djnz	.loop2						; Loop

		; Finalize with all the other operators.
		ld	b, zFMInstrumentOperatorTable_End-zFMInstrumentAMD1RTable	; Number of commands to issue

.loop3:
		call	zSendFMInstrData			; Send FM instrument data
		djnz	.loop3						; Loop
	else
		; DANGER! The following code ignores the fact that SSG-EG mode must be
		; used with maximum (1Fh) attack rate or output is officially undefined.
		; Setting voices with SSG-EG enabled then has the potential effect of
		; weird sound, even in real hardware.

		ld	b, zFMInstrumentOperatorTable_End-zFMInstrumentOperatorTable	; Number of commands to issue

.loop:
		call	zSendFMInstrData			; Send FM instrument data
		djnz	.loop							; Loop
	endif
		ld	(ix+zTrack.TLPtrLow), l			; Save low byte of pointer to (not yet uploaded) TL data
		ld	(ix+zTrack.TLPtrHigh), h		; Save high byte of pointer to (not yet uploaded) TL data
		jp	zSendTL							; Send TL data
; End of function zSendFMInstrument

; =============== S U B	R O U T	I N E =======================================
; Sends FM instrument data to YM2612.
;
; Input:   ix    Track data
;          hl    Pointer to instrument data
;          de    Pointer to register selector table
; Output:   a    Value written to the register
;           c    Value written to the register
;
;sub_4DA
zSendFMInstrData:
		ld	a, (de)							; Get register output
		inc	de								; Advance pointer
		ld	c, (hl)							; Get value from instrument RAM
		inc	hl								; Advance pointer

		jp	zWriteFMIorII					; Write track data
; End of function zSendFMInstrData

	if 0==1;fix_sndbugs
zSendFMInstrDataRSAR:
		ld	a, (ix+zTrack.HaveSSGEGFlag)	; Get custom SSG-EG flag
		or	a								; Does track have custom SSG-EG data?
		jp	p, zSendFMInstrData				; Branch if not
		ld	a, (hl)							; Get value from instrument RAM
		inc	hl								; Advance pointer
		or 1Fh								; Set AR to maximum
		ld	c, a							; c = RS/AR for operator
		ld	a, (de)							; Get register output
		inc	de								; Advance pointer
		jp	zWriteFMIorII					; Write track data
	endif

; =============== S U B	R O U T	I N E =======================================
; Rotates sound queue and clears last entry. Then plays the popped sound from
; the queue.
;loc_4E2
zCycleSoundQueue:
		ld	a, (zSoundQueue0)				; Get first item in sound queue
		ld	(zNextSound), a					; Save into next sound variable
		ld	a, (zSoundQueue1)				; Get second item in queue
		ld	(zSoundQueue0), a				; Move to first spot
		ld	a, (zSoundQueue2)				; Get third item in queue
		ld	(zSoundQueue1), a				; Move to second spot
		xor	a								; a = 0
		ld	(zSoundQueue2), a				; Clear third spot in queue
		ld	a, (zNextSound)					; a = next sound to play
; End of function zCycleSoundQueue

; ===========================================================================
; Type Check
; ===========================================================================
; 1-32, DC = Music
; 33-DB, DD-DF = SFX
; E1-E6 = Fade Effects
; FF = SEGA Scream

; TypeCheck:
;sub_4FB
zPlaySoundByIndex:
		cp	MusID__End						; Is this a music?
		jp	c, zPlayMusic					; Branch if yes
		cp	SndID__End						; Is this a sound effect?
		jp	c, zPlaySound_CheckRing			; Branch if yes
		cp	FadeID__First					; Is it before the first fade effect?
		jp	c, zMusicFade					; Branch if yes
		cp	FadeID__End						; Is this after the last fade effect?
		jp	nc, zMusicStop					; Branch if yes
		sub	FadeID__First					; If none of the checks passed, do fade effects.
		ld	hl, zFadeEffects				; hl = switch table pointer
		rst	PointerTableOffset				; Get address of function that handles the fade effect
		jp	(hl)							; Handle fade effect
; End of function zPlaySoundByIndex
; ---------------------------------------------------------------------------
;loc_524
zFadeEffects:
		dw	zFadeOutMusic					; E1h
		dw	zMusicFade						; E2h
		dw	zPSGSilenceAll					; E3h
		dw	zStopSFX						; E4h
		dw	zFadeOutMusic					; E5h
; ---------------------------------------------------------------------------
;sub_52E
zStopSFX:
		ld	ix, zTracksSFXStart				; ix = pointer to SFX track memory
		ld	b, (zTracksSFXEnd-zTracksSFXStart)/zTrack.len	; Number of channels
		ld	a, 1							; a = 1
		ld	(zUpdatingSFX), a				; Set flag to update SFX

.loop:
		push	bc							; Save bc
		bit	7, (ix+zTrack.PlaybackControl)	; Is track playing?
		call	nz, zSilenceStopTrack		; Branch if yes
		ld	de, zTrack.len					; Spacing between tracks
		add	ix, de							; ix = pointer to next track
		pop	bc								; Restore bc
		djnz	.loop						; Loop for each track
		jp	zClearNextSound

; =============== S U B	R O U T	I N E =======================================
; Writes hl to stack twice and stops track, silencing it. The two hl pushes
; will be counteracted by cfSilenceStopTrack.
;
;sub_54D
zSilenceStopTrack:
		push	hl							; Save hl...
		push	hl							; ... twice
		jp	cfSilenceStopTrack				; Silence FM channel and stop track
; End of function zSilenceStopTrack
; ---------------------------------------------------------------------------

;loc_558
zPlayMusic:
		sub	MusID__First								; Remap index from 1h-32h to 0h-31h (see also credits music, above)
		ret	m								; Return if negative (id = 0)
		push	af							; Save af

zPlayMusic_DoFade:
		call	zMusicFade					; Stop all music

;loc_5DE
zBGMLoad:
		pop	af								; Restore af
		push	af							; Then save it back again
		ld	hl, z80_MusicBanks				; hl = table of music banks
		; The following block adds the music index to the table address as a 16-bit offset
		add	a, l							; a += l
		ld	l, a							; l = low byte of offset into music entry
		adc	a, h							; a += h, plus 1 if a + l overflowed the 8-bit register
		sub	l								; Now, a = high byte of offset into music entry
		ld	h, a							; hl is the offset to the music bank

		ld	a, (hl)							; Get bank for the song to play
		ld	(zSongBank), a					; Save the song's bank...
		bankswitch2							; ... then bank switch to it
		ld	a, 0B6h							; Set Panning / AMS / FMS
		ld	(zYM2612_A1), a					; Write destination address to YM2612 address register
		nop
		ld	a, 0C0h							; default Panning / AMS / FMS settings (only stereo L/R enabled)
		ld	(zYM2612_D1), a					; Write to YM2612 data register
		pop	af								; Restore af
		ld	c, zID_MusicPointers			; c = 4 (music pointer table)
		rst	GetPointerTable					; hl = pointer table for music pointers
		rst	PointerTableOffset				; hl = pointer to song data
		push	hl							; Save hl...
		push	hl							; ... twice
		rst	ReadPointer						; Dereference pointer, so that hl = pointer to voice table
		ld	(zVoiceTblPtr), hl				; Store voice table pointer
		pop	hl								; Restore hl to pointer to song data
		pop	iy								; Also set iy = pointer to song data
		ld	a, (iy+5)						; Main tempo value
		ld	(zTempoAccumulator), a			; Set starting accumulator value
		ld	(zCurrentTempo), a				; Store current song tempo
		ld	de, 6							; Offset into DAC pointer
		add	hl, de							; hl = pointer to DAC pointer
		ld	(zSongPosition), hl				; Save it to RAM
		ld	hl, zFMDACInitBytes				; Load pointer to init data
		ld	(zTrackInitPos), hl				; Save it to RAM
		ld	de, zTracksStart				; de = pointer to track RAM
		ld	b, (iy+2)						; b = number of FM + DAC channels
		ld	a, (iy+4)						; a = tempo divider

.fm_dac_loop:
		push	bc							; Save bc (gets damaged by ldi instructions)
		ld	hl, (zTrackInitPos)				; Restore saved position for init bytes
		ldi									; *de++ = *hl++	(copy initial playback control)
		ldi									; *de++ = *hl++	(copy channel assignment bits)
		ld	(de), a							; Copy tempo divider
		inc	de								; Advance pointer
		ld	(zTrackInitPos), hl				; Save current position in channel assignment bits
		ld	hl, (zSongPosition)				; Load current position in BGM data
		ldi									; *de++ = *hl++ (copy track address low byte)
		ldi									; *de++ = *hl++ (copy track address high byte)
		ldi									; *de++ = *hl++ (default key offset)
		ldi									; *de++ = *hl++ (track default volume)
		ld	(zSongPosition), hl				; Store current position in BGM data
		call	zInitFMDACTrack				; Init the remainder of the track RAM
		pop	bc								; Restore bc
		djnz	.fm_dac_loop				; Loop for all tracks (stored in b)

		ld	a, (iy+3)						; Get number of PSG tracks
		or	a								; Do we have any PSG channels?
		jp	z, zClearNextSound				; Branch if not
		ld	b, a							; b = number of PSG tracks
		ld	hl, zPSGInitBytes				; Load pointer to init data
		ld	(zTrackInitPos), hl				; Save it to RAM
		ld	de, zSongPSG1					; de = pointer to RAM for song PSG tracks
		ld	a, (iy+4)						; a = tempo divider

.psg_loop:
		push	bc							; Save bc (gets damaged by ldi instructions)
		ld	hl, (zTrackInitPos)				; Restore saved position for init bytes
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		ld	(de), a							; Copy tempo divider
		inc	de								; Advance pointer
		ld	(zTrackInitPos), hl				; Save current position in channel assignment bits
		ld	hl, (zSongPosition)				; Load current position in BGM data
		ld	bc, 6							; Copy 6 bytes
		ldir								; while (bc-- > 0) *de++ = *hl++; (copy track address, default key offset, default volume, modulation control, default PSG tone)
		ld	(zSongPosition), hl				; Store current position in BGM data
		call	zZeroFillTrackRAM			; Init the remainder of the track RAM
		pop	bc								; Restore bc
		djnz	.psg_loop					; Loop for all tracks (stored in b)

; =============== S U B	R O U T	I N E =======================================
; Clears next sound to play.
;sub_690
zClearNextSound:
		xor	a
		ld	(zNextSound), a
		ret
; End of function zClearNextSound
; ---------------------------------------------------------------------------
;loc_695
; FM/DAC channel assignment bits
; The first byte in every pair (always 80h) is default value for playback control bits.
; The second byte in every pair goes as follows:
; The first is for DAC; then 0, 1, 2 then 4, 5, 6 for the FM channels (the missing 3
; is the gap between part I and part II for YM2612 port writes).
zFMDACInitBytes:
		db   80h,   6
		db   80h,   0
		db   80h,   1
		db   80h,   2
		db   80h,   4
		db   80h,   5

;loc_6A3
; Default values for PSG tracks
; The first byte in every pair (always 80h) is default value for playback control bits.
; The second byte in every pair is the default values for PSG tracks.
zPSGInitBytes:
		db   80h, 80h
		db   80h, 0A0h
		db   80h, 0C0h
; ---------------------------------------------------------------------------
;loc_6A9

	; MJ: SFX list, these SFX use notes on the final octave, so in the sound test
	; they end up off the piano board, this code below will set a flag for these
	; SFX, this flag will not affect the sound itself, but it'll set a flag that
	; the sound test will read, and the sound test will nudge the note down an octave.

zOctaveList:	db	037h						; MJ: Hurt by spikes
		db	03Ch						; MJ: Spin attack (this stops playing before it goes off, but I'm keeping it here anyway)
		db	06Ah						; MJ: Unused special stage exit
		db	080h						; MJ: ICZ ice spikes destroyed
		db	09Dh						; MJ: LRZ missile launch
		db	0ABh						; MJ: Spindash
		db	0C8h						; MJ: water/sand/snow sounds
zOctaveFlag:	db	000h						; MJ: end of list marker (this is cleared before the loop, so it's OK to use as an end marker =3)

zPlaySound_CheckRing:
		ld	b,a						; MJ: store ID in a
		xor	a						; MJ: clear octave flag
		ld	(zOctaveFlag),a					; MJ: ''
		ld	hl,zOctaveList					; MJ: load octave list
		ld	a,(hl)						; MJ: load entry
		inc	hl						; MJ: advance to next byte

zPSX_NextOctave:
		cp	b						; MJ: does it match the ID required?
		jr	nz,zPSX_NoOctave				; MJ: if not, branch
		ld	a,00000010b					; MJ: enable octave flag
		ld	(zOctaveFlag),a					; MJ: ''
		jr	zPSFX_YesOctave					; MJ: finish loop

zPSX_NoOctave:
		ld	a,(hl)						; MJ: load entry
		inc	hl						; MJ: advance to next byte
		or	a						; MJ: is this the end of the list?
		jr	nz,zPSX_NextOctave

zPSFX_YesOctave:
		ld	a,b						; MJ: restore ID to a again



		sub	SndID__First					; Make it a 0-based index
		or	a								; Is it the ring sound?
		jp	nz, zPlaySound_Bankswitch		; Branch if not
		ld	a, (zRingSpeaker)				; Get speaker on which ring sound is played
		xor	1								; Toggle bit 0
		ld	(zRingSpeaker), a				; Save it

;loc_6B7
zPlaySound_Bankswitch:

		ex	af, af'							; Save af
		ld	a, zmake68kBank(SndBank)		; Load SFX sound bank address
		bankswitch2							; Bank switch to it
		xor	a								; a = 0
		ld	c, zID_SFXPointers				; SFX table index
		ld	(zUpdatingSFX), a				; Clear flag to update SFX
		ex	af, af'							; Restore af
		cp	SndID_Spindash-SndID__First		; Is this the spindash sound?
		jp	z, zPlaySound					; Branch if yes
		cp	SndID__FirstContinuous-SndID__First	; Is this before sound 0BCh?
		jp	c, zPlaySound_Normal			; Branch if yes
		push	af							; Save af
		ld	b, a							; b = sound index
		ld	a, (zContinuousSFX)			; Load last continuous SFX played
		sub	b					; Is this the same continuous sound that was playing?
		jp	nz, zPlaySound_NotCont			; Branch if not
		ld	a, 80h					; a = 80h
		ld	(zContinuousSFXFlag), a			; Flag continuous SFX as being extended
		rst	GetPointerTable				; hl = pointer to SFX data table
		pop	af					; Restore af

		rst	PointerTableOffset			; hl = pointer to SFX data
		inc	hl					; Skip low byte of voice pointer
		inc	hl					; Skip high byte of voice pointer
		inc	hl					; Skip timing divisor
		ld	a, (hl)					; Get number of SFX tracks
		ld	(zContSFXLoopCnt), a			; Save it to RAM (loop counter for continuous SFX)
		jp	zClearNextSound
; ---------------------------------------------------------------------------
;loc_6FB
zPlaySound_NotCont:
		xor	a								; a = 0
		ld	(zContinuousSFXFlag), a			; Clear continue continuous SFX flag
		pop	af								; Restore af
		ld	(zContinuousSFX), a				; Store SFX index
		jp	zPlaySound
; ---------------------------------------------------------------------------
;loc_706
zPlaySound_Normal:
		push	af							; Save af
		xor	a								; a = 0
		ld	(zSpindashRev), a				; Reset spindash rev
		pop	af							; Restore af

;loc_70C
zPlaySound:
		rst	GetPointerTable				; hl = pointer to SFX data table
		rst	PointerTableOffset			; hl = pointer to SFX data
		push	hl					; Save hl
		rst	ReadPointer				; hl = voice table pointer
		ld	(zSFXVoiceTblPtr), hl			; Save to RAM

		pop	hl					; hl = pointer to SFX data
		push	hl					; Save it again
		pop	iy					; iy = pointer to SFX data
		ld	a, (iy+2)				; a = tempo divider
		ld	(zSFXTempoDivider), a			; Save to RAM
		ld	de, 4					; de = 4
		add	hl, de					; hl = pointer to SFX track data
		ld	b, (iy+3)				; b = number of tracks (FM + PSG) used by SFX
		ld	a, b					; Copy to a
		ld	(zContSFXLoopCnt), a			; Save to RAM (loop counter for continuous SFX)

;loc_72C
zSFXTrackInitLoop:
		push	bc							; Save bc; damaged by ldi instructions below
		push	hl							; Save hl
		inc	hl								; hl = pointer to channel identifier
		ld	c, (hl)							; c = channel identifier
		call	zGetSFXChannelPointers		; Get track pointers for track RAM (ix) and overridden song track (hl)
		set	2, (hl)							; Set 'SFX is overriding this track' bit
		push	ix							; Save pointer to SFX track data in RAM

		pop	de							; de = pointer to SFX track data in RAM (unless you consider the above effectively dead code)
		pop	hl							; hl = pointer to SFX track data
		ldi									; *de++ = *hl++ (initial playback control)
		ld	a, (de)							; Get the voice control byte from track RAM (to deal with SFX already there)
		cp	2								; Is this FM3?
		call	z, zFM3NormalMode			; Set FM3 to normal mode if so
		ldi									; *de++ = *hl++ (copy channel identifier)
		ld	a, (zSFXTempoDivider)			; Get SFX tempo divider
		ld	(de), a							; Store it to RAM
		inc	de								; Advance pointer
		ldi									; *de++ = *hl++ (low byte of channel data pointer)
		ldi									; *de++ = *hl++ (high byte of channel data pointer)
		ldi									; *de++ = *hl++ (key displacement)
		ldi									; *de++ = *hl++ (channel volume)
		call	zInitFMDACTrack				; Init the remainder of the track RAM

		ld	a,(zOctaveFlag)					; MJ: load the octave setting
		ld	(ix+zTrack.PSGSustain),a			; MJ: save to the channel

		push	hl							; Save hl
		ld	hl, (zSFXVoiceTblPtr)			; hl = pointer to voice data

		ld	(ix+zTrack.VoicesLow), l		; Low byte of voice pointer
		ld	(ix+zTrack.VoicesHigh), h		; High byte of voice pointer
		call	zKeyOffIfActive				; Kill channel notes
		bit	7, (ix+zTrack.VoiceControl)		; Is this an FM track?
		call	z, zFMClearSSGEGOps			; If so, clear SSG-EG operators for track's channels
		pop		hl							; Restore hl
		pop		bc							; Restore bc
		djnz	zSFXTrackInitLoop			; Loop for all SFX tracks
		jp	zClearNextSound

; =============== S U B	R O U T	I N E =======================================
;
;sub_78F
zGetSFXChannelPointers:
		bit	7, c							; Is this a PSG track?
		jr	nz, .is_psg						; Branch if yes
		ld	a, c							; a = c
		bit	2, a							; Is this FM4, FM5 or FM6?
		jr	z, .get_ptrs					; Branch if not
		dec	a								; Remove gap between FM3 and FM4+
		jr	.get_ptrs
; ---------------------------------------------------------------------------
.is_psg:
		call	zSilencePSGChannel			; Silence channel at ix
		ld	a, c							; a = channel identifier
		; Shift high 3 bits to low bits so that we can convert it to a table index
		rlca
		rlca
		rlca
		and	7
		add	a, 2							; Compensate for subtraction below

.get_ptrs:
		sub	2								; Start table at FM3
		ld	(zSFXSaveIndex), a				; Save index of overridden channel
		push	af							; Save af
		ld	hl, zSFXChannelData				; Pointer table for track RAM
		rst	PointerTableOffset				; hl = track RAM
		push	hl							; Save hl
		pop	ix								; ix = track RAM
		pop	af								; Restore af
		; This is where there is code in other drivers to load the special SFX
		; channel pointers to iy
		ld	hl, zSFXOverriddenChannel		; Pointer table for the overridden music track
		jp	PointerTableOffset				; hl = RAM destination to mark as overridden
; End of function zGetSFXChannelPointers


; =============== S U B	R O U T	I N E =======================================
;
;sub_7C5
zInitFMDACTrack:
		ex	af, af'							; Save af
		xor	a								; a = 0
		ld	(de), a							; Set modulation to inactive
		inc	de								; Advance to next byte
		ld	(de), a							; Set FM instrument/PSG tone to zero too
		inc	de								; Advance to next byte again
		ex	af, af'							; Restore af

;loc_7CC
zZeroFillTrackRAM:
		ex	de, hl							; Exchange the contents of de and hl
		ld	(hl), zTrack.len				; Call subroutine stack pointer
		inc	hl								; Advance to next byte
		ld	(hl), 0C0h						; default Panning / AMS / FMS settings (only stereo L/R enabled)
		inc	hl								; Advance to next byte
		ld	(hl), 1							; Current note duration timeout

		ld	b, zTrack.len-zTrack.DurationTimeout-1	; Loop counter

.loop:
		inc	hl								; Advance to next byte
		ld	(hl), 0							; Put 0 into this byte
		djnz	.loop						; Loop until end of track

		inc	hl								; Make hl point to next track
		ex	de, hl							; Exchange the contents of de and hl
		ret
; End of function zInitFMDACTrack
; ---------------------------------------------------------------------------
;zloc_7DF
zSFXChannelData:
		dw  zSFX_FM3						; FM3
		dw  zSFX_FM4						; FM4
		dw  zSFX_FM5						; FM5
		dw  zSFX_FM6						; FM6 or DAC
		dw  zSFX_PSG1						; PSG1
		dw  zSFX_PSG2						; PSG2
		dw  zSFX_PSG3						; PSG3
		dw  zSFX_PSG3						; PSG3/Noise
;zloc_7EF
zSFXOverriddenChannel:
		dw  zSongFM3						; FM3
		dw  zSongFM4						; FM4
		dw  zSongFM5						; FM5
		dw  zSongFM6_DAC					; FM6 or DAC
		dw  zSongPSG1						; PSG1
		dw  zSongPSG2						; PSG2
		dw  zSongPSG3						; PSG3
		dw  zSongPSG3						; PSG3/Noise

; =============== S U B	R O U T	I N E =======================================
; Pauses/unpauses sound.
;
;sub_7FF
zPauseUnpause:
		ld	hl, zPauseFlag					; hl = pointer to pause flag
		ld	a, (hl)							; a = pause flag
		or	a								; Is sound driver paused?
		ret	z								; Return if not
		jp	m, .unpause						; Branch if pause flag is negative (unpause)
		pop	de								; Pop return value from the stack, so that a 'ret' will go back to zVInt
		dec	a								; Decrease a
		ret	nz								; Return if nonzero
		ld	(hl), 2							; Set pause flag to 2 (i.e., stay paused but don't pause again)
		jp	zPauseAudio						; Pause all but FM6/DAC
; ---------------------------------------------------------------------------
.unpause:
		xor	a								; a = 0
		ld	(hl), a							; Clear pause flag
		ld	a, (zFadeOutTimeout)			; Get fade timeout
		or	a								; Is it zero?
		jp	nz, zMusicStop					; Stop all music if not
		ld	ix, zSongFM1					; Start with FM1 track
		ld	b, (zSongPSG1-zSongFM1)/zTrack.len	; Number of FM tracks

.fm_loop:
		ld	a, (zHaltFlag)					; Get halt flag
		or	a								; Is song halted?
		jr	nz, .set_pan					; Branch if yes
		bit	7, (ix+zTrack.PlaybackControl)	; Is track playing?
		jr	z, .skip_fm_track				; Branch if not

.set_pan:
		ld	c, (ix+zTrack.AMSFMSPan)		; Get track AMS/FMS/panning
		ld	a, 0B4h							; Command to select AMS/FMS/panning register
		call	zWriteFMIorII				; Write data to YM2612

.skip_fm_track:
		ld	de, zTrack.len					; Spacing between tracks
		add	ix, de							; Advance to next track
		djnz	.fm_loop					; Loop for all tracks

		ld	ix, zTracksSFXStart				; Start at the start of SFX track data
		ld	b, (zTracksSFXEnd-zTracksSFXStart)/zTrack.len	; Number of tracks
.psg_loop:
		bit	7, (ix+zTrack.PlaybackControl)	; Is track playing?
		jr	z, .skip_psg_track				; Branch if not
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		jr	nz, .skip_psg_track				; Branch if yes
		ld	c, (ix+zTrack.AMSFMSPan)		; Get track AMS/FMS/panning
		ld	a, 0B4h							; Command to select AMS/FMS/panning register
		call	zWriteFMIorII				; Write data to YM2612

.skip_psg_track:
		ld	de, zTrack.len					; Spacing between tracks
		add	ix, de							; Go to next track
		djnz	.psg_loop					; Loop for all tracks

		ret
; End of function zPauseUnpause

; =============== S U B	R O U T	I N E =======================================
; Fades out music.
;sub_85C
zFadeOutMusic:
		ld	a, 28h							; a = 28h
		ld	(zFadeOutTimeout), a			; Set fade timeout to this (start fading out music)
		ld	a, 6							; a = 6
		ld	(zFadeDelayTimeout), a			; Set fade delay timeout
		ld	(zFadeDelay), a					; Set fade delay and fall through

; =============== S U B	R O U T	I N E =======================================
; Halts FM6/DAC, PSG1, PSG2, PSG3.
;sub_869
zHaltDACPSG:
		xor	a								; a = 0
		ld	(zSongFM6_DAC), a				; Halt FM6/DAC
		ld	(zSongPSG3), a					; Halt PSG3
		ld	(zSongPSG1), a					; Halt PSG1
		ld	(zSongPSG2), a					; Halt PSG2
		jp	zPSGSilenceAll
; End of function zHaltDACPSG


; =============== S U B	R O U T	I N E =======================================
; Fade out music slowly.
;
;sub_879
zDoMusicFadeOut:
		ld	hl, zFadeOutTimeout				; hl = pointer to fade timeout
		ld	a, (hl)							; a = fade counter
		or	a								; Is fade counter zero?
		ret	z								; Return if yes
		call	m, zHaltDACPSG				; Kill DAC and PSG channels if negative
		res	7, (hl)							; Clear sign bit
		ld	a, (zFadeDelayTimeout)			; Get fade delay timeout
		dec	a								; Decrement it
		jr	z, .timer_expired				; Branch if it zero now
		ld	(zFadeDelayTimeout), a			; Store it back
		ret
; ---------------------------------------------------------------------------
.timer_expired:
		ld	a, (zFadeDelay)					; Get fade delay
		ld	(zFadeDelayTimeout), a			; Restore counter to initial value
		ld	hl, zFadeOutTimeout				; (hl) = fade timeout
		dec	(hl)							; Decrement it
		jp	z, zMusicStop					; Stop all music if it is zero
		ld	a, (zSongBank)					; a = current music bank ID
		bankswitch2							; Bank switch to music bank
		ld	ix, zTracksStart				; ix = pointer to track RAM
		ld	b, (zSongPSG1-zTracksStart)/zTrack.len	; Number of FM+DAC tracks

.loop:
		inc	(ix+zTrack.Volume)				; Decrease volume
		jp	p, .chk_change_volume			; If still positive, branch
		dec	(ix+zTrack.Volume)				; Increase it back to minimum volume (127)
		jr	.next_track
; ---------------------------------------------------------------------------
.chk_change_volume:
		bit	7, (ix+zTrack.PlaybackControl)	; Is track still playing?
		jr	z, .next_track					; Branch if not
		bit	2, (ix+zTrack.PlaybackControl)	; Is SFX overriding track?
		jr	nz, .next_track					; Branch if yes
		push	bc							; Save bc
		call	zSendTL						; Send new volume
		pop	bc								; Restore bc

.next_track:
		ld	de, zTrack.len					; Spacing between tracks
		add	ix, de							; Advance to next track
		djnz	.loop						; Loop for all tracks
		ret
; End of function zDoMusicFadeOut


; =============== S U B	R O U T	I N E =======================================
; Fades music in.
;
;sub_8DF
zDoMusicFadeIn:
		ld	a, (zFadeInTimeout)				; Get fading timeout
		or	a								; Is music being faded?
		ret	z								; Return if not
		ld	a, (zSongBank)					; Get current music bank
		bankswitch2							; Bank switch to music
		ld	hl, zFadeDelay					; Get fade delay
		dec	(hl)							; Decrement it
		ret	nz								; Return if it is not yet zero
		ld	a, (zFadeDelayTimeout)			; Get current fade delay timeout
		ld	(zFadeDelay), a					; Reset to starting fade delay
		ld	b, (zSongPSG1-zSongFM1)/zTrack.len	; Number of FM tracks
		ld	ix, zSongFM1					; ix = start of FM1 RAM
		ld	de, zTrack.len					; Spacing between tracks

.fm_loop:
		dec	(ix+zTrack.Volume)				; Increase track volume
		push	bc							; Save bc
		call	zSendTL						; Send new volume
		pop	bc								; Restore bc
		add	ix, de							; Advance to next track
		djnz	.fm_loop					; Loop for all tracks

		ld	hl, zFadeInTimeout				; Get fading timeout
		dec	(hl)							; Decrement it
		ret	nz								; Return if still fading
		ld	b, (zTracksEnd-zSongPSG1)/zTrack.len	; Number of PSG tracks
		ld	ix, zSongPSG1					; ix = start of PSG RAM
		ld	de, zTrack.len					; Spacing between tracks

.psg_loop:
		res	2, (ix+zTrack.PlaybackControl)	; Clear 'SFX is overriding' bit
		add	ix, de							; Advance to next track
		djnz	.psg_loop					; Loop for all tracks

		ld	ix, zSongFM6_DAC				; ix = start of DAC/FM6 RAM
		res	2, (ix+zTrack.PlaybackControl)	; Clear 'SFX is overriding' bit
		ret
; End of function zDoMusicFadeIn


; =============== S U B	R O U T	I N E =======================================
; Wipes music data and fades all FM, PSG and DAC channels.
;sub_944

zMusicStop:
		xor	a		; NAT: Only reset tempo here.	; a = 0
		ld	(zTempoSpeedup), a				; Fade in normal speed

zMusicFade:
		; The following block sets to zero the z80 RAM from 1C0Dh to 1FD4h
		ld	hl, zFadeOutTimeout				; Starting source address for copy
		ld	de, zFadeDelay					; Starting destination address for copy
		ld	bc, zTracksSaveEnd-zFadeDelay	; Length of copy
		ld	(hl), 0							; Initial value of zero
		ldir								; while (--length) *de++ = *hl++

	;	xor	a		; NAT: Do not reset tempo here.	; a = 0
	;	ld	(zTempoSpeedup), a				; Fade in normal speed

		ld	ix, zFMDACInitBytes				; Initialization data for channels
		ld	b, (zSongPSG1-zSongFM6_DAC)/zTrack.len	; Number of FM channels

.loop:
		push	bc							; Save bc for loop
		call	zFMSilenceChannel			; Silence track's channel
		call	zFMClearSSGEGOps			; Clears the SSG-EG operators for this channel
		inc	ix								; Go to next channel byte
		inc	ix								; But skip the 80h
		pop	bc								; Restore bc for loop counter
		djnz	.loop						; Loop while b > 0

		xor	a								; a = 0
		ld	(zFadeOutTimeout), a			; Set fade timeout to zero... again
		call	zPSGSilenceAll				; Silence PSG
		ld	c, 0							; Write a zero...
		ld	a, 2Bh							; ... to DAC enable register
		call	zWriteFMI					; Disable DAC

;loc_979
zFM3NormalMode:
		ld	c, 0							; FM3 mode: normal mode
		ld	a, 27h							; FM3 special settings
		call	zWriteFMI					; Set it
		jp	zClearNextSound
; End of function zMusicFade

; =============== S U B	R O U T	I N E =======================================
; Sets the SSG-EG registers (90h+) for all operators on this track to 0.
;
; Input:  ix    Pointer to track RAM
; Output: a     Damaged
;         b     Damaged
;         c     Damaged
;sub_986
zFMClearSSGEGOps:
		ld	a, 90h							; Set SSG-EG registers...
		ld	c, 0							; ... set to zero (as docs say it should)...
		jp	zFMOperatorWriteLoop			; ... for all operators of this track's channel
; End of function zFMClearSSGEGOps

; =============== S U B	R O U T	I N E =======================================
; Pauses all audio.
;loc_98D
zPauseAudio:
		push	bc							; Save bc
		push	af							; Save af
		ld	b, (zSongFM4-zSongFM1)/zTrack.len	; FM1/FM2/FM3
		ld	a, 0B4h							; Command to select AMS/FMS/panning register (FM1)
		ld	c, 0							; AMS=FMS=panning=0

.loop1:
		push	af							; Save af
		call	zWriteFMI					; Write reg/data pair to YM2612
		pop	af								; Restore af
		inc	a								; Advance to next channel
		djnz	.loop1						; Loop for all channels

		ld	b, (zSongPSG1-zSongFM4)/zTrack.len	; FM4 and FM5, but not FM6
		ld	a, 0B4h							; Command to select AMS/FMS/panning register

.loop2:
		push	af							; Save af
		call	zWriteFMII					; Write reg/data pair to YM2612
		pop	af								; Restore af
		inc	a								; Advance to next channel
		djnz	.loop2						; Loop for all channels

		ld	c, 0							; Note off for all operators
		ld	b, (zSongPSG1-zSongFM1)/zTrack.len+1	; 5 FM channels + 1 gap between FM3 and FM4
		ld	a, 28h							; Command to send note on/off

.loop3:
		push	af							; Save af
		call	zWriteFMI					; Write reg/data pair to YM2612
		inc	c								; Next channel
		pop	af								; Restore af
		djnz	.loop3						; Loop for all channels

		pop	af								; Restore af
		pop	bc								; restore bc and fall through

; =============== S U B	R O U T	I N E =======================================
; Silences all PSG channels, including the noise channel.
;
; Output: a    Damaged
;sub_9BC
zPSGSilenceAll:
		push	bc							; Save bc
		ld	b, (zTracksEnd-zSongPSG1)/zTrack.len+1	; Loop 4 times: 3 PSG channels + noise channel
		ld	a, 9Fh							; Command to silence PSG1

.loop:
		ld	(zPSG), a						; Write command
		add	a, 20h							; Next channel
		djnz	.loop						; Loop for all PSG channels
		pop	bc								; Restore bc
		jp	zClearNextSound
; End of function zPSGSilenceAll


; =============== S U B	R O U T	I N E =======================================
; Tempo works as divisions of the 60Hz clock (there is a fix supplied for
; PAL that "kind of" keeps it on track.) Every time the internal music clock
; does NOT overflow, it will update. So a tempo of 80h will update every
; other frame, or 30 times a second.
;sub_9CC:

zTempoCtrl =	$+1
TempoWait:
		ld	a,0					; MJ: load tempo control
		or	a					; MJ: check tempo direction
		jp	p,zTW_Inc				; MJ: if positve, branch
		neg	a					; MJ: convert tempo to positive
		add	a,a					; MJ: multiply by 2
		ld	b,a					; MJ: copy to b
		ld	a, (zCurrentTempo)			; Get current tempo value
		sub	a,b					; MJ: reduce tempo
		jr	nc,zTW_NoCap				; MJ: if it didn't overflow, branch
		xor	a					; MJ: force tempo to maximum
		jr	zTW_NoCap				; MJ: continue

zTW_Inc:
		add	a,a					; MJ: multiply by 2
		ld	b,a					; MJ: copy to b
		ld	a, (zCurrentTempo)			; Get current tempo value
		add	a,b					; MJ: increase tempo
		jr	nc,zTW_NoCap				; MJ: if it didn't overflow, branch
		sbc	a,a					; MJ: convert to FF

zTW_NoCap:
		ld	hl, zTempoAccumulator			; hl = pointer to tempo accumulator
		add	a, (hl)							; a += tempo accumulator
		ld	(hl), a							; Store it as new accumulator value

	if extra_flags==1
		jr	nc, .delay
	else
		ret	nc								; If the addition did not overflow, return
	endif

		ld	hl, zTracksStart+zTrack.DurationTimeout	; Duration timeout of first track
		ld	de, zTrack.len					; Spacing between tracks
		ld	b, (zTracksEnd-zTracksStart)/zTrack.len	; Number of tracks

.loop:
		inc	(hl)							; Delay notes another frame
		add	hl, de							; Advance to next track
		djnz	.loop						; Loop for all channels
		ret

	if extra_flags==1
.delay		ld	hl,zDoTicks		; NAT: load tick flag to hl
		xor	a			; clear a
		or	a, (hl)			; check if 0
		ret	nz			; if not, return

		inc	hl
		inc	(hl)			; increment
		ret	nz			; if no carry, return

		inc	hl
		inc	(hl)			; increase second byte
		ret
	endif

zDoTicks:	db 0
zTicksCount:	dw 0

; =============== S U B	R O U T	I N E =======================================
; Copies over M68K input to the sound queue and clears the input variables
;sub_9E2
zFillSoundQueue:
		ld	hl, zMusicNumber				; M68K input
		ld	de, zSoundQueue0				; Sound queue
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		xor	a								; a = 0
		dec	hl								; Point to zSFXNumber1
		ld	(hl), a							; Clear it
		dec	hl								; Point to zSFXNumber0
		ld	(hl), a							; Clear it
		dec	hl								; Point to zMusicNumber
		ld	(hl), a							; Clear it
		ret
; End of function zFillSoundQueue


; =============== S U B	R O U T	I N E =======================================
; Sets D1L to minimum, RR to maximum and TL to minimum amplitude for all
; operators on this track's channel, then sends note off for the same channel.
;
; Input:  ix    Pointer to track RAM
; Output: a     Damaged
;         b     Damaged
;         c     Damaged
;sub_9F6
zFMSilenceChannel:
		call	zSetMaxRelRate
		ld	a, 40h							; Set total level...
		ld	c, 7Fh							; ... to minimum envelope amplitude...
		call	zFMOperatorWriteLoop		; ... for all operators of this track's channel
		ld	c, (ix+zTrack.VoiceControl)		; Send key off
		jp	zKeyOnOff						; This does not safeguard against PSG tracks, making cfSilenceStopTrack dangerous (and zStopSFX even more so)
; End of function zFMSilenceChannel


; =============== S U B	R O U T	I N E =======================================
; Sets D1L to minimum and RR to maximum for all operators on this track's
; channel.
;
; Input:  ix    Pointer to track RAM
; Output: a     Damaged
;         b     Damaged
;         c     Damaged
;sub_A06
;zSetFMMinD1LRR
zSetMaxRelRate:
		ld	a, 80h							; Set D1L to minimum and RR to maximum...
		ld	c, 0FFh							; ... for all operators on this track's channel (fall through)
; End of function zSetMaxRelRate


; =============== S U B	R O U T	I N E =======================================
; Loops through all of a channel's operators and sets them to the desired value.
;
; Input:  ix    Pointer to track RAM
;         a     YM2612 register to write to
;         c     Value to write to register
; Output: b     Damaged
;sub_A0A
zFMOperatorWriteLoop:
		ld	b, 4							; Loop 4 times

.loop:
		push	af							; Save af
		call	zWriteFMIorII				; Write to part I or II, as appropriate
		pop	af								; Restore af
		add	a, 4							; a += 4
		djnz	.loop						; Loop
		ret
; End of function zFMOperatorWriteLoop
; ---------------------------------------------------------------------------

; =============== S U B	R O U T	I N E =======================================
; Performs massive restoration and starts fade in of previous music.
;
;sub_A20
zFadeInToPrevious:
		xor	a								; a = 0
		ld	(zFadeToPrevFlag), a			; Clear fade-to-prev flag
		ld	a, (zCurrentTempoSave)			; Get saved current tempo
		ld	(zCurrentTempo), a				; Restore it
		ld	a, (zTempoSpeedupSave)			; Get saved tempo speed-up
		ld	(zTempoSpeedup), a				; Restore it
		ld	hl, (zVoiceTblPtrSave)			; Get saved voice pointer
		ld	(zVoiceTblPtr), hl				; Restore it
		ld	a, (zSongBankSave)				; Get saved song bank ID
		ld	(zSongBank), a					; Restore it
		bankswitch2							; Bank switch to previous song's bank
		ld	hl, zTracksSaveStart			; Start of saved track data
		ld	de, zTracksStart				; Start of track data
		ld	bc, zTracksSaveEnd-zTracksSaveStart	; Number of bytes to copy
		ldir								; while (bc-- > 0) *de++ = *hl++;

		ld	hl, zSongFM6_DAC.PlaybackControl
		ld	a, 84h							; a = 'track is playing' and 'track is resting' flags
		or	(hl)							; Add in track playback control bits
		ld	(hl), a							; Save everything
		ld	ix, zSongFM1					; ix = pointer to FM1 track RAM
		ld	b, (zTracksEnd-zSongFM1)/zTrack.len	; Number of FM+PSG tracks

.loop:
		ld	a, (ix+zTrack.PlaybackControl)	; a = track playback control
		or	84h								; Set 'track is playing' and 'track is resting' flags
		ld	(ix+zTrack.PlaybackControl), a	; Set new value
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		jp	nz, .skip_track					; Branch if yes
		res	2, (ix+zTrack.PlaybackControl)	; Clear 'SFX is overriding track' flag
		ld	a, (ix+zTrack.Volume)			; Get track volume
		add	a, 40h							; Lower volume by 40h
		ld	(ix+zTrack.Volume), a			; Store new volume
		ld	a, (ix+zTrack.VoiceIndex)		; a = FM instrument
		push	bc							; Save bc
		ld	b, a							; b = FM instrument
		call	zGetFMInstrumentPointer		; hl = pointer to instrument data
		call	zSendFMInstrument			; Send instrument
		pop	bc								; Restore bc

.skip_track:
		ld	de, zTrack.len					; Spacing between tracks
		add	ix, de							; ix = pointer to next track
		djnz	.loop						; Loop for all tracks

		ld	a, 40h							; a = 40h
		ld	(zFadeInTimeout), a				; Start fade
		ld	a, 2							; a = 2
		ld	(zFadeDelayTimeout), a			; Set fade delay timeout
		ld	(zFadeDelay), a					; Set fade delay
		ret
; End of function zFadeInToPrevious
; ---------------------------------------------------------------------------
;loc_AA5
zPSGFrequencies:
		; This table starts with 12 notes not in S1 or S2:
		dw 3FFh,3FFh,3FFh,3FFh,3FFh,3FFh,3FFh,3FFh,3FFh,3F7h,3BEh,388h
		; The following notes are present on S1 and S2 too:
		dw 356h,326h,2F9h,2CEh,2A5h,280h,25Ch,23Ah,21Ah,1FBh,1DFh,1C4h
		dw 1ABh,193h,17Dh,167h,153h,140h,12Eh,11Dh,10Dh,0FEh,0EFh,0E2h
		dw 0D6h,0C9h,0BEh,0B4h,0A9h,0A0h,097h,08Fh,087h,07Fh,078h,071h
		dw 06Bh,065h,05Fh,05Ah,055h,050h,04Bh,047h,043h,040h,03Ch,039h
		dw 036h,033h,030h,02Dh,02Bh,028h,026h,024h,022h,020h,01Fh,01Dh
		dw 01Bh,01Ah,018h,017h,016h,015h,013h,012h,011h,010h,000h,000h
		; Then, it falls through to the 12 base notes from FM octaves.
;loc_B4D
zFMFrequencies:
		dw 284h,2ABh,2D3h,2FEh,32Dh,35Ch,38Fh,3C5h,3FFh,43Ch,47Ch,4C0h
; ---------------------------------------------------------------------------
; ===========================================================================
; MUSIC BANKS
; ===========================================================================
z80_MusicBanks:
		domusic	musbk		; create banks


; =============== S U B	R O U T	I N E =======================================
;
;sub_B98
zUpdateDACTrack:
		dec	(ix+zTrack.DurationTimeout)		; Advance track duration timer
		ret	nz								; Return if note is still going
		ld	e, (ix+zTrack.DataPointerLow)	; e = low byte of track data pointer
		ld	d, (ix+zTrack.DataPointerHigh)	; d = high byte of track data pointer

;loc_BA2
zUpdateDACTrack_cont:
		ld	a, (de)							; Get next byte from track
		inc	de								; Advance pointer
		cp	FirstCoordFlag					; Is it a coordination flag?
		jp	nc, zHandleDACCoordFlag			; Branch if yes
		or	a								; Is it a note?
		jp	m, .got_sample					; Branch if yes
		dec	de								; We got a duration, so go back to it
		ld	a, (ix+zTrack.SavedDAC)			; Reuse previous DAC sample

.got_sample:
		ld	(ix+zTrack.SavedDAC), a			; Store new DAC sample
		cp	NoteRest						; Is it a rest?
		jp	z, zUpdateDACTrack_GetDuration	; Branch if yes
		res	7, a							; Clear bit 7
		push	de							; Save de
		ex	af, af'							; Save af
		call	zKeyOffIfActive				; Kill note (will do nothing if 'do not attack' is on)
		call	zFM3NormalMode				; Set FM3 to normal mode
		ex	af, af'							; Restore af
		ld	ix, zSongFM6_DAC					; ix = pointer to DAC track data
		bit	2, (ix+zTrack.PlaybackControl)	; Is SFX overriding DAC channel?
		jp	nz, .dont_play					; Branch if yes
		ld	i, a						; Queue DAC sample

.dont_play:
		pop	de								; Restore de

zUpdateDACTrack_GetDuration:
		ld	a, (de)							; Get note duration
		inc	de								; Advance pointer
		or	a								; Is it a duration?
		jp	p, zStoreDuration				; Branch if yes
		dec	de								; Put the byte back to the stream
		jp	zFinishTrackUpdate
; ---------------------------------------------------------------------------
;loc_BE3
zHandleDACCoordFlag:
		ld	hl, loc_BE9						; hl = desired return address
		jp	zHandleCoordFlag
; ---------------------------------------------------------------------------
loc_BE9:
		inc	de								; Advance to next byte in track
		jp	zUpdateDACTrack_cont			; Continue processing DAC track
; ---------------------------------------------------------------------------
;loc_BED
zHandleFMorPSGCoordFlag:
		ld	hl, loc_BF9						; hl = desired return address

;loc_BF0
zHandleCoordFlag:
		push	hl							; Set return location (ret) to location stored in hl
		sub	FirstCoordFlag					; Make it a zero-based index
		ld	hl, zCoordFlagSwitchTable		; Load switch table into hl
		rst	PointerTableOffset				; hl = pointer to target location
		ld	a, (de)							; a = coordination flag parameter
		jp	(hl)							; Indirect jump to coordination flag handler
; End of function zUpdateDACTrack
; ---------------------------------------------------------------------------
loc_BF9:
		inc	de								; Advance to next byte in track
		jp	zGetNextNote_cont				; Continue processing FM/PSG track
; ---------------------------------------------------------------------------
;loc_BFD
zCoordFlagSwitchTable:
		dw cfPanningAMSFMS					; 0E0h
		dw cfDetune							; 0E1h
		dw cfFadeInToPrevious				; 0E2h
		dw cfSilenceStopTrack				; 0E3h
		dw cfSetVolume						; 0E4h
		dw cfChangeVolume2					; 0E5h
		dw cfChangeVolume					; 0E6h
		dw cfPreventAttack					; 0E7h
		dw cfNoteFill						; 0E8h
		dw cfSpindashRev					; 0E9h
		dw cfPlayDACSample					; 0EAh
		dw cfConditionalJump				; 0EBh
		dw cfChangePSGVolume				; 0ECh
		dw cfSetKey							; 0EDh
		dw cfSendFMI						; 0EEh
		dw cfSetVoice						; 0EFh
		dw cfModulation						; 0F0h
		dw cfAlterModulation				; 0F1h
		dw cfStopTrack						; 0F2h
		dw cfSetPSGNoise					; 0F3h
		dw cfSetModulation					; 0F4h
		dw cfSetPSGVolEnv					; 0F5h
		dw cfJumpTo							; 0F6h
		dw cfRepeatAtPos					; 0F7h
		dw cfJumpToGosub					; 0F8h
		dw cfJumpReturn						; 0F9h
		dw cfDisableModulation				; 0FAh
		dw cfChangeTransposition			; 0FBh
		dw cfLoopContinuousSFX				; 0FCh
		dw cfToggleAltFreqMode				; 0FDh
		dw cfFM3SpecialMode					; 0FEh
		dw cfMetaCF							; 0FFh
;loc_C3D
zExtraCoordFlagSwitchTable:
		dw cfSetTempo						; 0FFh 00h
		dw cfPlaySoundByIndex				; 0FFh 01h
		dw cfHaltSound						; 0FFh 02h
		dw cfCopyData						; 0FFh 03h
		dw cfSetTempoDivider				; 0FFh 04h
		dw cfSetSSGEG						; 0FFh 05h
		dw cfFMVolEnv						; 0FFh 06h
		dw cfResetSpindashRev				; 0FFh 07h

	if extra_flags==1
		dw cfFreeze					; freeze flag
		dw cfSync					; sync
		dw cfTickStop					; stop tick counter
	endif
; =============== S U B	R O U T	I N E =======================================
; Sets a new DAC sample for play.
;
; Has one parameter, the index (1-based) of the DAC sample to play.
;
;sub_C4D
cfPlayDACSample:
		ld	i, a					; Set next DAC sample to the parameter byte
		ret
; End of function cfPlayDACSample


; =============== S U B	R O U T	I N E =======================================
; Sets panning for track. By accident, you can sometimes set AMS and FMS
; flags -- but only if the bits in question were zero.
;
; Has one parameter byte, the AMS/FMS/panning bits.
;
;sub_C51
cfPanningAMSFMS:
		ld	c, 3Fh							; Mask for all but panning

zDoChangePan:
		ld	a, (ix+zTrack.AMSFMSPan)		; Get current AMS/FMS/panning
		and	c								; Mask out L+R
		push	de							; Store de
		ex	de, hl							; Exchange de and hl
		or	(hl)							; Mask in the new panning; may also add AMS/FMS
		ld	(ix+zTrack.AMSFMSPan), a		; Store new value in track RAM
		ld	c, a							; c = new AMS/FMS/panning
		ld	a, 0B4h							; a = YM2612 register to write to
		call	zWriteFMIorII				; Set new panning/AMS/FMS
		pop	de								; Restore de
		ret
; End of function cfPanningAMSFMS

; =============== S U B	R O U T	I N E =======================================
; Performs an escalating transposition ("revving") of the track.
;
; The saved value for the spindash rev is reset to zero every time a "normal"
; SFX is played (i.e., not a continuous SFX and not the spindash sound).
; Every time this function is called, the spindash rev value is added to the
; track key offset; unless this sum is exactly 10h, then the spindash rev is
; further increased by 1 for future calls.
;
; Has no parameter bytes.
;
;sub_C65
cfSpindashRev:
		ld	hl, zSpindashRev				; hl = pointer to escalating transposition
		ld	a, (hl)							; a = value of escalating transposition
		add	a, (ix+zTrack.Transpose)		; Add in current track transposition
		ld	(ix+zTrack.Transpose), a		; Store result as new track transposition
		cp	10h								; Is the current transposition 10h?
		jp	z, .skip_rev					; Branch if yes
		inc	(hl)							; Otherwise, increase escalating transposition

.skip_rev:
		dec	de								; Put parameter byte back
		ret
; End of function cfSpindashRev


; =============== S U B	R O U T	I N E =======================================
; Sets frequency displacement (signed). The final note frequency is shifted
; by this value.
;
; Has one parameter byte, the new frequency displacement.
;
;sub_C77 cfAlterNoteFreq
cfDetune:
		ld	(ix+zTrack.Detune), a	; Set detuned
		ret
; End of function cfDetune


; =============== S U B	R O U T	I N E =======================================
; Fade in to previous song.
;
; Has one parameter byte. If the parameter byte if FFh, the engine will fade
; to the previous song. If the parameter byte is equal to 29h (1-Up ID - 1),
; the driver will prevent new music or SFX from playing as long as the 1-Up
; music is playing (but will not clear the M68K queue). For all other values,
; the queue will work as normal, but no fade-in will be done.
;
;sub_C7B
cfFadeInToPrevious:
		ld	(zFadeToPrevFlag), a
		ret
; End of function cfFadeInToPrevious

; =============== S U B	R O U T	I N E =======================================
; Silences FM channel and stops track. Expanded form of coord. flag 0F2h.
;
; Technically, it has a parameter byte, but it is irrelevant and unused.
;
;loc_C7F
cfSilenceStopTrack:
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		call	z, zFMSilenceChannel		; If so, don't mess with the YM2612
		jp	cfStopTrack
; End of function cfSilenceStopTrack

; =============== S U B	R O U T	I N E =======================================
; Sets track volume.
;
; Has one parameter byte, the volume.
;
; For FM tracks, this is a 7-bit value from 0 (lowest volume) to 127 (highest
; volume). The value is XOR'ed with 7Fh before being sent, then stripped of the
; sign bit. The volume change takes effect immediately.
;
; For PSG tracks, this is a 4-bit value ranging from 8 (lowest volume) to 78h
; (highest volume). The value is shifted 3 bits to the right, XOR'ed with 0Fh
; and AND'ed with 0Fh before being uploaded, so the sign bit and the lower 3
; bits are discarded.
;
;loc_C85
cfSetVolume:
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG channel?
		jr	z, .not_psg						; Branch if not
		; The following code gets bits 3, 4, 5 and 6 from the parameter byte,
		; puts them in positions 0 to 3 and inverts them, discarding all other
		; bits in the parameter byte.
		; Shift the parameter byte 3 bits to the right
		srl	a
		srl	a
		srl	a
		xor	0Fh								; Invert lower nibble's bits
		and	0Fh								; Clear out high nibble
		jp	zStoreTrackVolume
; ---------------------------------------------------------------------------
.not_psg:
		xor	7Fh								; Invert parameter byte (except irrelevant sign bit)
		and	7Fh								; Strip sign bit
		ld	(ix+zTrack.Volume), a			; Set as new track volume
		jr	zSendTL							; Begin using new volume immediately

; =============== S U B	R O U T	I N E =======================================
; Change track volume for a FM track.
;
; Has two parameter bytes: the first byte is ignored, the second is the signed
; change in volume. Positive lowers volume, negative increases it.
;
;loc_CA1
cfChangeVolume2:
		inc	de								; Advance pointer
		ld	a, (de)							; Get change in volume then fall-through


; =============== S U B	R O U T	I N E =======================================
; Change track volume for a FM track.
;
; Has one parameter byte, the signed change in volume. Positive lowers volume,
; negative increases it.
;
;loc_CA3
cfChangeVolume:
		; S2 places this check further down (and S1 lacks it altogether),
		; allowing PSG channels to change their volume. This means the
		; likes of S2's SFX $F0 will sound different in this driver
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		ret	nz								; Return if yes
		add	a, (ix+zTrack.Volume)			; Add in track's current volume
		jp	p, .set_vol						; Branch if result is still positive
		jp	pe, .underflow					; Branch if addition overflowed into more than 127 positive
		xor	a								; Set maximum volume
		jp	.set_vol
; ---------------------------------------------------------------------------
.underflow:
		ld	a, 7Fh							; Set minimum volume

.set_vol:
		ld	(ix+zTrack.Volume), a			; Store new volume

; =============== S U B	R O U T	I N E =======================================
; Subroutine to send TL information to YM2612.
;
;sub_CBA
zSendTL:
		push	de							; Save de
		ld	de, zFMInstrumentTLTable		; de = pointer to FM TL register table
		ld	l, (ix+zTrack.TLPtrLow)			; l = low byte of pointer to instrument's TL data
		ld	h, (ix+zTrack.TLPtrHigh)		; h = high byte of pointer to instrument's TL data
	if uw_mode==1		; NAT: do underwater mode
		push	hl
		ld	bc,zFMInstrumentTLTable-zFMInstrumentRegTable
		add	hl, bc		; jump back to get feedback/algo
		ld	a,(hl)		; load it
		pop	hl

		ld	bc,.noslot+1	; load pos
		ld	(bc),a		; save byte

		and	7		; mast out all but 3 last bits
		ld	bc,.sslot+1	; load pos
		ld	(bc),a		; save byte
	endif

		ld	b, zFMInstrumentTLTable_End-zFMInstrumentTLTable	; Number of entries

.loop:
		ld	a, (hl)							; a = register data
		or	a								; Is it positive?

	if uw_mode==0
		jp	p, .slot				; Branch if yes
		add	a, (ix+zTrack.Volume)			; Add track's volume to it

	else
		jp	p, .noslot				; Branch if yes
		add	a, (ix+zTrack.Volume)			; Add track's volume to it
.sslot		add	a,0		; load dynamically
		jp	.slot

.noslot		add	a,0		; NAT: load dynamically

	endif
.skip_track_vol:
.slot		and	7Fh								; Strip sign bit


		ld	c, a							; c = new volume for operator
		ld	a, (de)							; a = register write command
		call	zWriteFMIorII				; Send it to YM2612
		inc	de								; Advance pointer
		inc	hl								; Advance pointer
		djnz	.loop						; Loop

		pop	de								; Restore de
		ret
; End of function zSendTL

; =============== S U B	R O U T	I N E =======================================
; Prevents next note from attacking.
;
; Has no parameter bytes.
;
;loc_CDB
cfPreventAttack:
		set	1, (ix+zTrack.PlaybackControl)	; Set flag to prevent attack
		dec	de								; Put parameter byte back
		ret

; =============== S U B	R O U T	I N E =======================================
; Sets the note fill.
;
; Has one parameter byte, the new note fill. This value is multiplied by the
; tempo divider, and so may overflow.
;
;loc_CE1
cfNoteFill:
		call	zComputeNoteDuration		; Multiply note fill by tempo divider
		ld	(ix+zTrack.NoteFillTimeout), a	; Store result into note fill timeout
		ld	(ix+zTrack.NoteFillMaster), a	; Store master copy of note fill
		ret

; =============== S U B	R O U T	I N E =======================================
; Jump timeout. Shares the same loop counters as coord. flag 0E7h, so it has
; to be coordinated with these. Each time this coord. flag is encountered, it
; tests if the associated loop counter is 1. If it is, it will jump to the
; target location and the loop counter will be set to zero; otherwise, nothing
; happens.
;
; Has 3 parameter bytes: a loop counter index (identical to that of coord. flag
; 0E7h), and a 2-byte jump target.
;
;loc_CEB
cfConditionalJump:
		inc	de								; Advance track pointer
		add	a, zTrack.LoopCounters			; Add offset into loop counters
		ld	c, a							; c = offset of current loop counter
		ld	b, 0							; bc = sign-extended offset to current loop counter
		push	ix							; Save track RAM pointer
		pop	hl								; hl = pointer to track RAM
		add	hl, bc							; hl = pointer in RAM to current loop counter
		ld	a, (hl)							; a = value of current loop counter
		dec	a								; Decrement loop counter (note: value is not saved!)
		jp	z, .do_jump						; Branch if result is zero
		inc	de								; Skip another byte
		ret
; ---------------------------------------------------------------------------
.do_jump:
		xor	a								; a = 0
		ld	(hl), a							; Clear loop counter
		jp	cfJumpTo

; =============== S U B	R O U T	I N E =======================================
; Change PSG volume. Has no effect on FM or DAC channels.
;
; Has one parameter byte, the change in volume. The value is signed, but any
; result greater than 0Fh (or lower than 0) will result in no output.
;
;loc_D01
cfChangePSGVolume:
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG channel?
		ret	z								; Return if not
		res	4, (ix+zTrack.PlaybackControl)	; Clear 'track is resting' flag
		dec	(ix+zTrack.VolEnv)				; Decrement envelope index
		add	a, (ix+zTrack.Volume)			; Add track's current volume
		cp	0Fh								; Is it 0Fh or more?
		jp	c, zStoreTrackVolume			; Branch if not
		ld	a, 0Fh							; Limit to 0Fh (silence)

;loc_D17
zStoreTrackVolume:
		ld	(ix+zTrack.Volume), a			; Store new volume
		ret

; =============== S U B	R O U T	I N E =======================================
; Changes the track's key displacement.
;
; There is a single parameter byte, the new track key offset + 40h (that is,
; 40h is subtracted from the parameter byte before the key displacement is set)
;
;loc_D1B
cfSetKey:
		sub	40h								; Subtract 40h from key displacement
		ld	(ix+zTrack.Transpose), a		; Store result as new transposition
		ret

; =============== S U B	R O U T	I N E =======================================
; Sends an FM command to the YM2612. The command is sent to part I, so not all
; registers can be set using this coord. flag (in particular, channels FM4,
; FM5 and FM6 cannot (in general) be affected).
;
; Has 2 parameter bytes: a 1-byte register selector and a 1-byte register data.
;
;loc_D21
cfSendFMI:
		call	zGetFMParams				; Get parameters for FM command
		jp	zWriteFMI						; Send it to YM2612

;loc_D28
zGetFMParams:
		ex	de, hl							; Exchange de and hl
		ld	a, (hl)							; Get YM2612 register selector
		inc	hl								; Advance pointer
		ld	c, (hl)							; Get YM2612 register data
		ex	de, hl							; Exchange back de and hl
		ret
; End of function cfSendFMI

; =============== S U B	R O U T	I N E =======================================
; Change current instrument (FM), tone (PSG) or sample (DAC).
;
; Has either a single positive parameter byte or a pair of parameter bytes of
; which the first is negative.
;
; If positive, the first parameter byte is the index of voice to use.
;
; If negative, and on a PSG track, then the first parameter byte is the index
; of voice to use while the second parameter byte is ignored.
;
; If negative and on a FM or DAC track, the first parameter byte is 80h + index
; of voice to use, while the second parameter byte is 7Fh + index of song whose
; voice bank is to be used (here, the AIZ1 song is index 1, not zero).
;
; The uploading of an FM instrument is irrelevant for the DAC.
;
;loc_D2E
cfSetVoice:
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		jr	nz, zSetVoicePSG				; Branch if yes
		call	zSetMaxRelRate				; Set minimum D1L/RR for channel
		ld	a, (de)							; Get voice index
		ld	(ix+zTrack.VoiceIndex), a		; Store to track RAM
		or	a								; Is it negative?
		jp	p, zSetVoiceUpload				; Branch if not
		inc	de								; Advance pointer
		ld	a, (de)							; Get song ID whose bank is desired
		ld	(ix+zTrack.VoiceSongID), a		; Store to track RAM and fall-through

; =============== S U B	R O U T	I N E =======================================
; Uploads the FM instrument from another song's voice bank.
;
;sub_D44
zSetVoiceUploadAlter:
		push	de							; Save de
		ld	a, (ix+zTrack.VoiceSongID)		; Get saved song ID for instrument data
		sub	81h								; Convert it to a zero-based index
		ld	c, zID_MusicPointers			; Value for music pointer table
		rst	GetPointerTable					; hl = pointer to music pointer table
		rst	PointerTableOffset				; hl = pointer to music data
		rst	ReadPointer						; hl = pointer to music voice data
		ld	a, (ix+zTrack.VoiceIndex)		; Get voice index
		and	7Fh								; Strip sign bit
		ld	b, a							; b = voice index
		call	zGetFMInstrumentOffset		; hl = pointer to voice data
		jr	zSetVoiceDoUpload
; ---------------------------------------------------------------------------
;loc_D5A
zSetVoiceUpload:
		push	de							; Save de
		ld	b, a							; b = instrument index
		call	zGetFMInstrumentPointer		; hl = pointer to instrument data

zSetVoiceDoUpload:
		call	zSendFMInstrument			; Upload instrument data to YM2612
		pop	de								; Restore de
		ret
; End of function cfSetVoice
; ---------------------------------------------------------------------------
;loc_D64:
zSetVoicePSG:
		or	a								; Is the voice index positive?
		jp	p, cfStoreNewVoice				; Branch if yes
		inc	de								; Otherwise, advance song data pointer
		jp	cfStoreNewVoice

; =============== S U B	R O U T	I N E =======================================
; Turns on modulation on the channel.
;
; Has four 1-byte parameters: delay before modulation starts, modulation speed,
; modulation change per step, number of steps in modulation.
;
;loc_D6D
cfModulation:
		ld	(ix+zTrack.ModulationPtrLow), e		; Store low byte of modulation data pointer
		ld	(ix+zTrack.ModulationPtrHigh), d	; Store high byte of modulation data pointer
		ld	(ix+zTrack.ModulationCtrl), 80h	; Toggle modulation on
		inc	de								; Advance pointer...
		inc	de								; ... again...
		inc	de								; ... and again.
		ret

; =============== S U B	R O U T	I N E =======================================
; Sets modulation status according to parameter bytes.
;
; Has 2 1-byte parameters: the first byte is the new modulation state for PSG
; tracks, while the second byte is the new modulation state for FM tracks.
;
;loc_D7B
cfAlterModulation:
		inc	de								; Advance track pointer
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		jr	nz, cfSetModulation				; Branch if yes
		ld	a, (de)							; Get new modulation status

; =============== S U B	R O U T	I N E =======================================
; Sets modulation status.
;
; Has one parameter byte, the new modulation status.
;
;loc_D83
cfSetModulation:
		ld	(ix+zTrack.ModulationCtrl), a	; Set modulation status
		ret

; =============== S U B	R O U T	I N E =======================================
; Stops the current track.
;
; Technically, it has a parameter byte, but it is irrelevant and unused.
;
;loc_D87
cfStopTrack:
		res	7, (ix+zTrack.PlaybackControl)	; Clear 'track playing' flag
		call	zKeyOffIfActive				; Send key off for track channel
		ld	c, (ix+zTrack.VoiceControl)		; c = voice control bits
		push	ix							; Save track pointer
		call	zGetSFXChannelPointers		; ix = track pointer, hl = overridden track pointer
		ld	a, (zUpdatingSFX)				; Get flag
		or	a								; Are we updating SFX?
		jp	z, zStopCleanExit				; Exit if not

		push	hl							; Save hl
		ld	hl, (zVoiceTblPtr)				; hl = pointer to voice table
		pop	ix								; ix = overridden track's pointer
		res	2, (ix+zTrack.PlaybackControl)	; Clear 'SFX is overriding' bit
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG channel?
		jr	nz, zStopPSGTrack				; Branch if yes
		bit	7, (ix+zTrack.PlaybackControl)	; Is 'track playing' bit set?
		jr	z, zStopCleanExit				; Exit if not
		ld	a, 2							; a = 2 (FM3)
		cp	(ix+zTrack.VoiceControl)		; Is this track for FM3?
		jr	nz, .not_fm3					; Branch if not
		ld	a, 4Fh							; FM3 settings: special mode, enable and load A/B
		bit	0, (ix+zTrack.PlaybackControl)	; Is FM3 in special mode?
		jr	nz, .do_fm3_settings			; Branch if yes
		and	0Fh								; FM3 settings: normal mode, enable and load A/B

.do_fm3_settings:
		call	zWriteFM3Settings			; Set the above FM3 settings

.not_fm3:
		ld	a, (ix+zTrack.VoiceIndex)		; Get FM instrument
		or	a								; Is it positive?
		jp	p, .switch_to_music				; Branch if yes
		call	zSetVoiceUploadAlter		; Upload the voice from another song's voice bank
		jr	.send_ssg_eg
; ---------------------------------------------------------------------------
.switch_to_music:
		ld	b, a							; b = FM instrument
		push	hl							; Save hl
		bankswitchToMusic					; Bank switch to song bank
		pop	hl								; Restore hl
		call	zGetFMInstrumentOffset		; hl = pointer to instrument data
		call	zSendFMInstrument			; Send FM instrument
		ld	a, zmake68kBank(SndBank)		; Get SFX bank
		bankswitch2							; Bank switch to it
		ld	a, (ix+zTrack.HaveSSGEGFlag)	; Get custom SSG-EG flag
		or	a								; Does track have custom SSG-EG data?
		jp	p, zStopCleanExit				; Exit if not
		ld	e, (ix+zTrack.SSGEGPointerLow)	; e = low byte of pointer to SSG-EG data
		ld	d, (ix+zTrack.SSGEGPointerHigh)	; d = high byte of pointer to SSG-EG data

.send_ssg_eg:
		call	zSendSSGEGData				; Upload custom SSG-EG data

;loc_E22
zStopCleanExit:
		pop	ix								; Restore ix
		pop	hl								; Pop return value from stack
		pop	hl								; Pop another return value from stack
		ret
; ---------------------------------------------------------------------------
;loc_E27
zStopPSGTrack:
		bit	0, (ix+zTrack.PlaybackControl)	; Is this a noise channel?
		jr	z, zStopCleanExit				; Exit if not
		ld	a, (ix+zTrack.PSGNoise)			; Get track's PSG noise setting
		or	a								; Is it an actual noise?
		jp	p, .skip_command				; Branch if not
		ld	(zPSG), a						; Send it to PSG

.skip_command:
		jr	zStopCleanExit

; =============== S U B	R O U T	I N E =======================================
; Change PSG noise to parameter, and silences PSG3 channel.
;
; Has one parameter byte: if zero, the channel is changed back to a normal PSG
; channel and the noise is silenced; if non-zero, it must be in the 0E0h-0E7h
; range, and sets the noise type to use (and sets the channel as being a noise
; channel).
;
;loc_E39
cfSetPSGNoise:
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		ret	z								; Return if not
		ld	(ix+zTrack.PSGNoise), a			; Store to track RAM
		set	0, (ix+zTrack.PlaybackControl)	; Mark PSG track as being noise
		or	a								; Test noise value
		ld	a, 0DFh							; Command to silence PSG3
		jr	nz, .skip_noise_silence			; If nonzero, branch
		res	0, (ix+zTrack.PlaybackControl)	; Otherwise, mark track as not being a noise channel
		ld	a, 0FFh							; Command to silence the noise channel

.skip_noise_silence:
		bit	2, (ix+zTrack.PlaybackControl)	; Is SFX overriding this track?
		ret	nz								; Return if yes
		ld	(zPSG), a						; Execute it
		ld	a, (de)							; Get PSG noise value
		ld	(zPSG), a						; Send command to PSG
		ret

; =============== S U B	R O U T	I N E =======================================
; Set PSG tone.
;
; Has one parameter byte, the new PSG tone to use.
;
;loc_E58
;cfSetPSGTone
cfSetPSGVolEnv:
		bit	7, (ix+zTrack.VoiceControl)		; Is this a PSG track?
		ret	z								; Return if not

;loc_E5D
cfStoreNewVoice:
		ld	(ix+zTrack.VoiceIndex), a		; Store voice
		ret

; =============== S U B	R O U T	I N E =======================================
; Jump to specified location.
;
; Has a 2-byte parameter, indicating target location for jump.
;
;loc_E61
cfJumpTo:
		ex	de, hl							; Exchange de and hl
		ld	e, (hl)							; e = low byte of target location
		inc	hl								; Advance pointer
		ld	d, (hl)							; d = high byte of target location
		dec	de								; Put destination byte back
		ret

; =============== S U B	R O U T	I N E =======================================
; Loop section of music.
;
; Has four parameter bytes: a loop counter index (exactly like coord. flag 0EBh),
; a repeat count, and a 2-byte jump target.
;
;loc_E67
cfRepeatAtPos:
		inc	de								; Advance track pointer
		add	a, zTrack.LoopCounters			; Add offset into loop counters
		ld	c, a							; c = offset of current loop counter
		ld	b, 0							; bc = sign-extended offset to current loop counter
		push	ix							; Save track RAM pointer
		pop	hl								; hl = pointer to track RAM
		add	hl, bc							; hl = pointer in RAM to current loop counter
		ld	a, (hl)							; a = value of current loop counter
		or	a								; Is loop counter zero?
		jr	nz, .run_counter				; Branch if not
		ld	a, (de)							; Get repeat counter
		ld	(hl), a							; Reset loop counter to it

.run_counter:
		inc	de								; Advance track pointer
		dec	(hl)							; Decrement loop counter
		jp	nz, cfJumpTo					; Loop if it is nonzero
		inc	de								; Advance track pointer
		ret

; =============== S U B	R O U T	I N E =======================================
; Call subroutine. Stores current location on track-specific stack so that
; coord. flag 0F9h can be used to return to current location.
;
; Has one 2-byte parameter, the target subroutine's address.
;
;loc_E7E
cfJumpToGosub:
		ld	c, a							; c = low byte of target address
		inc	de								; Advance track pointer
		ld	a, (de)							; a = high byte of target address
		ld	b, a							; bc = target address
		push	bc							; Save bc
		push	ix							; Save ix
		pop	hl								; hl = pointer to track RAM
		dec	(ix+zTrack.StackPointer)		; Decrement track stack pointer
		ld	c, (ix+zTrack.StackPointer)		; c = track stack pointer
		dec	(ix+zTrack.StackPointer)		; Decrement track stack pointer again
		ld	b, 0							; b = 0
		add	hl, bc							; hl = offset of high byte of return address
		ld	(hl), d							; Store high byte of return address
		dec	hl								; Move pointer to target location
		ld	(hl), e							; Store low byte of return address
		pop	de								; de = jump target address
		dec	de								; Put back the byte
		ret

; =============== S U B	R O U T	I N E =======================================
; Returns from subroutine call. Does NOT check for stack overflows!
;
; Has no parameter bytes.
;
;loc_E98
cfJumpReturn:
		push	ix							; Save track RAM address
		pop	hl								; hl = pointer to track RAM
		ld	c, (ix+zTrack.StackPointer)		; c = offset to top of return stack
		ld	b, 0							; b = 0
		add	hl, bc							; hl = pointer to top of return stack
		ld	e, (hl)							; e = low byte of return address
		inc	hl								; Advance pointer
		ld	d, (hl)							; de = return address
		inc	(ix+zTrack.StackPointer)		; Pop byte from return stack
		inc	(ix+zTrack.StackPointer)		; Pop byte from return stack
		ret

; =============== S U B	R O U T	I N E =======================================
; Clears sign bit of modulation control, disabling normal modulation.
;
; Has no parameter bytes.
;
;loc_EAB
cfDisableModulation:
		res	7, (ix+zTrack.ModulationCtrl)	; Clear bit 7 of modulation control
		dec	de								; Put byte back
		ret

; =============== S U B	R O U T	I N E =======================================
; Adds a signed value to channel key displacement.
;
; Has one parameter byte, the change in channel key displacement.
;
;loc_EB1 cfAddKey
cfChangeTransposition:
		add	a, (ix+zTrack.Transpose)		; Add current transposition to parameter
		ld	(ix+zTrack.Transpose), a		; Store result as new transposition
		ret

; =============== S U B	R O U T	I N E =======================================
; If a continuous SFX is playing, it will continue playing from target address.
; A loop counter is decremented (it is initialized to number of SFX tracks)
; for continuous SFX; if the result is zero, the continuous SFX will be flagged
; to stop.
; Non-continuous SFX do not loop.
;
; Has a 2-byte parameter, the jump target address.
;
;loc_EB8
cfLoopContinuousSFX:
		ld	a, (zContinuousSFXFlag)			; Get 'continuous sound effect' flag
		cp	80h					; Is it equal to 80h?
		jp	z, .run_counter				; Branch if yes
		xor	a					; a = 0
		ld	(zContinuousSFX), a			; Clear last continuous SFX played
		inc	de					; Skip a byte
		ret
; ---------------------------------------------------------------------------
.run_counter:
		ld	hl, zContSFXLoopCnt			; Get number loops to perform
		dec	(hl)					; Decrement it...
		jp	nz, cfJumpTo				; If result is non-zero, jump to target address
		xor	a					; a = 0
		ld	(zContinuousSFXFlag), a			; Clear continuous sound effect flag
		jp	cfJumpTo				; Jump to target address

; =============== S U B	R O U T	I N E =======================================
; Toggles alternate frequency mode according to parameter.
;
; Has a single byte parameter: is 1, enables alternate frequency mode, otherwise
; disables it.
;
;loc_EDA
;cfToggleAlternateSMPS
cfToggleAltFreqMode:
		or	a								; Is parameter equal to 0?
		jr	z, .stop_altfreq_mode			; Branch if so
		set	3, (ix+zTrack.PlaybackControl)	; Start alternate frequency mode for track
		ret
; ---------------------------------------------------------------------------
.stop_altfreq_mode:
		res	3, (ix+zTrack.PlaybackControl)	; Stop alternate frequency mode for track
		ret

; =============== S U B	R O U T	I N E =======================================
; If current track is FM3, it is put into special mode. The function is weird,
; and may not work correctly (subject to verification).
;
; It has 4 1-byte parameters: all of them are indexes into a lookup table of
; unknown purpose, and must be in the 0-7 range. It is possible that this
; lookup table held frequencies (or frequency shifts) for FM3 and its operators
; in special mode.
;
;loc_EE8
cfFM3SpecialMode:
		ld	a, (ix+zTrack.VoiceControl)		; Get track's voice control
		cp	2								; Is this FM3?
		jr	nz, zTrackSkip3bytes			; Branch if not
		set	0, (ix+zTrack.PlaybackControl)	; Put FM3 in special mode
		ex	de, hl							; Exchange de and hl
		call	zGetSpecialFM3DataPointer	; de = pointer to saved FM3 frequency shifts
		ld	b, 4							; Loop counter: 4 parameter bytes

		; DANGER! The following code will trash the Z80 code due to failed
		; initialization of de. At the start of the function, hl was a pointer
		; to the coord. flag switch table entry that had the address of this
		; function; after 'ex	de, hl', now de is this pointer.
		; After the code below, the targets of the last few coord. flag handlers
		; will be overwritten by the nonsensical numbers at the lookup table.
.loop:
		push	bc							; Save bc
		ld	a, (hl)							; Get parameter byte
		inc	hl								; Advance pointer
		push	hl							; Save hl
		ld	hl, zFM3FreqShiftTable			; hl = pointer to lookup table
		add	a, a							; Multiply a by 2
		ld	c, a							; c = a
		ld	b, 0							; b = 0
		add	hl, bc							; hl = offset into lookup table
		ldi									; *de++ = *hl++
		ldi									; *de++ = *hl++
		pop	hl								; Restore hl
		pop	bc								; Restore bc
		djnz	.loop						; Loop for all parameters

		ex	de, hl							; Exchange back de and hl
		dec	de								; Put back last byte
		ld	a, 4Fh							; FM3 settings: special mode, enable and load A/B

; =============== S U B	R O U T	I N E =======================================
; Set up FM3 special settings
;
; Input:   a    Settings for FM3
; Output:  c    Damaged
;sub_F11
zWriteFM3Settings:
		ld	c, a							; c = FM3 settings
		ld	a, 27h							; Write data to FM3 settings register
		jp	zWriteFMI						; Do it
; End of function zWriteFM3Settings

; =============== S U B	R O U T	I N E =======================================
; Eats 3 bytes from the song.
zTrackSkip3bytes:
		inc	de								; Advance pointer...
		inc	de								; ... again...
		inc	de								; ... and again.
		ret
; ---------------------------------------------------------------------------
; Frequency shift data used in cfFM3SpecialMode, above. That function, as well
; as zFMSendFreq, use invalid addresses for read and write (respectively), so
; that this data is improperly used.
;loc_F1F
zFM3FreqShiftTable:
		dw    0, 132h, 18Eh, 1E4h, 234h, 27Eh, 2C2h, 2F0h

; =============== S U B	R O U T	I N E =======================================
; Meta coordination flag: the first parameter byte is an index into an extra
; coord. flag handler table.
;
; Has at least one parameter byte, the index into the jump table.
;
;loc_F2F
cfMetaCF:
		ld	hl, zExtraCoordFlagSwitchTable	; Load extra coordination flag switch table
		rst	PointerTableOffset				; hl = jump target for parameter
		inc	de								; Advance track pointer
		ld	a, (de)							; Get another parameter byte
		jp	(hl)							; Jump to coordination flag handler

; =============== S U B	R O U T	I N E =======================================
; Sets current tempo to parameter byte.
;
; Has one parameter byte, the new value for current tempo.
;
;loc_F36
cfSetTempo:
		ld	(zCurrentTempo), a				; Set current tempo to parameter
		ret

; =============== S U B	R O U T	I N E =======================================
; Plays another song or SFX.
;
; Has one parameter byte, the ID of what is to be played.
;
; DO NOT USE THIS TO PLAY THE SEGA PCM! It tampers with the stack pointer, and
; will wreak havok with the track update.
;
;loc_F3A:
cfPlaySoundByIndex:
		push	ix							; Save track pointer
		call	zPlaySoundByIndex			; Play sound specified by parameter
		pop	ix								; Restore track pointer
		ret

; =============== S U B	R O U T	I N E =======================================
; Halts or resumes all tracks according to parameter.
;
; Has one parameter byte, which is zero to resume all tracks and non-zero to
; halt them.
;
;loc_F42
cfHaltSound:
		ld	(zHaltFlag), a					; Set new mute flag
		or	a								; Is it set now?
		jr	z, .resume						; Branch if not
		push	ix							; Save ix
		push	de							; Save de
		ld	ix, zTracksStart				; Start of song RAM
		ld	b, (zTracksEnd-zTracksStart)/zTrack.len	; Number of tracks
		ld	de, zTrack.len					; Spacing between tracks

.loop1:
		res	7, (ix+zTrack.PlaybackControl)	; Clear 'track is playing' bit
		call	zKeyOff						; Stop current note
		add	ix, de							; Advance to next track
		djnz	.loop1						; Loop for all tracks
		pop	de								; Restore de
		pop	ix								; Restore ix
		jp	zPSGSilenceAll
; ---------------------------------------------------------------------------
.resume:
		push	ix							; Save ix
		push	de							; Save de
		ld	ix, zTracksStart				; Start of song RAM
		ld	b, (zTracksEnd-zTracksStart)/zTrack.len	; Number of tracks
		ld	de, zTrack.len					; Spacing between tracks

.loop2:
		set	7, (ix+zTrack.PlaybackControl)	; Set 'track is playing' bit
		add	ix, de							; Advance to next track
		djnz	.loop2						; Loop for all tracks
		pop	de								; Restore de
		pop	ix								; Restore ix
		ret

; =============== S U B	R O U T	I N E =======================================
; Copies data from selected location to current track. Playback will continue
; after the last byte copied.
;
; Has 3 parameter bytes, a 2-byte pointer to data to be copied and a 1-byte
; number of bytes to copy. The data is copied to the track's byte stream,
; starting after the parameters of this coord. flag, and will overwrite the data
; that what was there before. This likely will not work unless the song/SFX was
; copied to Z80 RAM in the first place.
;
;loc_F7D
cfCopyData:
		ex	de, hl							; Exchange de and hl
		ld	e, (hl)							; e = low byte of pointer to new song data
		inc	hl								; Advance track pointer
		ld	d, (hl)							; d = high byte of pointer to new song data
		inc	hl								; Advance track pointer
		ld	c, (hl)							; c = number of bytes to copy
		ld	b, 0							; b = 0
		inc	hl								; Advance track pointer
		ex	de, hl							; Exchange back de and hl
		ldir								; while (bc-- > 0) *de++ = *hl++;
		dec	de								; Put back last byte
		ret

; =============== S U B	R O U T	I N E =======================================
; Sets tempo divider for all tracks. Does not take effect until the next note
; duration is set.
;
; Has one parameter, the new tempo divider.
;
;loc_F8B
cfSetTempoDivider:
		bit	7,a					; check if tempo divider is negative
		jr	z, .pos					; branch if it is positive
		and	7Fh					; clear msb
		ld	(ix+zTrack.TempoDivider),a		; set channel tempo divider only
		ret

.pos		ld	b, (zTracksEnd-zTracksStart)/zTrack.len	; Number of tracks
		ld	hl, zTracksStart+zTrack.TempoDivider	; Want to change tempo dividers

.loop:
		push	bc							; Save bc
		ld	bc, zTrack.len					; Spacing between tracks
		ld	(hl), a							; Set tempo divider for track
		add	hl, bc							; Advance to next track
		pop	bc								; Restore bc
		djnz	.loop
		ret

; =============== S U B	R O U T	I N E =======================================
; Sets SSG-EG data for current track.
;
; Has 4 parameter bytes, the operator parameters for SSG-EG data desired.
;
;loc_F9A
cfSetSSGEG:
		ld	(ix+zTrack.HaveSSGEGFlag), 80h	; Set custom SSG-EG data flag
		ld	(ix+zTrack.SSGEGPointerLow), e	; Save low byte of SSG-EG data pointer
		ld	(ix+zTrack.SSGEGPointerHigh), d	; Save high byte of SSG-EG data pointer

; =============== S U B	R O U T	I N E =======================================
; Sends SSG-EG data pointed to by de to appropriate registers in YM2612.
;
;sub_FA4
zSendSSGEGData:
		; DANGER! The following code ignores the fact that SSG-EG mode must be
		; used with maximum (1Fh) attack rate or output is officially undefined.
		; This has the potential effect of weird sound, even in real hardware.
;	if fix_sndbugs
		; This fix is even better than what is done in Ristar's sound driver:
		; we preserve rate scaling, whereas that driver sets it to 0.
;		ld	l, (ix+zTrack.TLPtrLow)			; l = low byte of pointer to TL data
;		ld	h, (ix+zTrack.TLPtrHigh)		; hl = pointer to TL data
;		ld	bc, zFMInstrumentTLTable-zFMInstrumentRSARTable		; bc = -10h
;		add	hl, bc							; hl = pointer to RS/AR data
;		push	hl							; Save hl (**)
;	endif
		ld	hl, zFMInstrumentSSGEGTable		; hl = pointer to registers for SSG-EG data
		ld	b, zFMInstrumentSSGEGTable_End-zFMInstrumentSSGEGTable	; Number of entries

.loop:
		ld	a, (de)							; Get data to sent to SSG-EG register
		inc	de								; Advance pointer
		ld	c, a							; c = data to send
		ld	a, (hl)							; a = register to send to
;	if fix_sndbugs
;		call	zWriteFMIorII				; Send data to correct channel
;		ex	(sp), hl						; Save hl, hl = pointer to RS/AR data (see line marked (**) above)
;		ld	a, (hl)							; a = RS/AR value for operator
;		inc	hl								; Advance pointer
;		ex	(sp), hl						; Save hl, hl = pointer to registers for SSG-EG data
;		or	1Fh								; Set AR to maximum, but keep RS intact
;		ld	c, a							; c = RS/AR
;		ld	a, (hl)							; a = register to send to
;		sub	40h								; Convert into command to set RS/AR
;	endif
		inc	hl								; Advance pointer
		call	zWriteFMIorII				; Send data to correct channel
		djnz	.loop						; Loop for all registers
;	if fix_sndbugs
;		pop	hl								; Remove from stack (see line marked (**) above)
;	endif
		dec	de								; Rewind data pointer a bit
		ret
; End of function zSendSSGEGData

; =============== S U B	R O U T	I N E =======================================
; Starts or controls FM volume envelope effects, according to the parameters.
;
; Has two parameter bytes: the first is a (1-based) index into the PSG envelope
; table indicating how the envelope should go, while the second is a bitmask
; indicating which operators should be affected (in the form %00004231) for
; the current channel.
;
;loc_FB5
;cfFMFlutter
cfFMVolEnv:
		ld	(ix+zTrack.FMVolEnv), a			; Store envelope index
		inc	de								; Advance track pointer
		ld	a, (de)							; Get envelope mask
		ld	(ix+zTrack.FMVolEnvMask), a		; Store envelope bitmask
		ret

; =============== S U B	R O U T	I N E =======================================
; Resets spindash rev counter.
;
; Has no parameter bytes.
;
;loc_FBE
cfResetSpindashRev:
		xor	a								; a = 0
		ld	(zSpindashRev), a				; Reset spindash rev
		dec	de								; Put byte back
		ret

; =============== S U B	R O U T	I N E =======================================
; Updates a PSG track.
;
; Input:   ix    Pointer to track RAM
;
;loc_FC4
zUpdatePSGTrack:
		dec	(ix+zTrack.DurationTimeout)		; Run note timer

		jr	nz, .note_going					; Branch if note hasn't expired yet
	res	0,(ix+zTrack.PSGSustain)			; MJ: clear sustain flag
		call	zGetNextNote				; Get next note for PSG track
		bit	4, (ix+zTrack.PlaybackControl)	; Is track resting?
		ret	nz								; Return if yes
		call	zPrepareModulation			; Initialize modulation
		jr	.skip_fill
; ---------------------------------------------------------------------------
.note_going:
		ld	a, (ix+zTrack.NoteFillTimeout)	; Get note fill
		or	a								; Has timeout expired?
		jr	z, .skip_fill					; Branch if yes
		dec	(ix+zTrack.NoteFillTimeout)		; Update note fill
		jp	z, zRestTrack					; Put PSG track at rest if needed

.skip_fill:
		call	zUpdateFreq					; Add frequency displacement to frequency
		call	zDoModulation				; Do modulation
		bit	2, (ix+zTrack.PlaybackControl)	; Is SFX overriding this track?
		ret	nz								; Return if yes		FEE3
		ld	c, (ix+zTrack.VoiceControl)		; c = voice control byte
		ld	a, l					; a = low byte of new frequency			E3
		and	0Fh					; Get only lower nibble				0E
		or	c					; OR in PSG channel bits			.3
		ld	(zPSG), a				; Send to PSG, latching register
		ld	a, l					; a = low byte of new frequency			E3
		and	0F0h					; Get high nibble now				E0
		or	h					; OR in the high byte of the new frequency	FE
		; Swap nibbles
		rrca
		rrca
		rrca
		rrca
		ld	(zPSG), a				; Send to PSG, to latched register		EF
		ld	a, (ix+zTrack.VoiceIndex)		; Get PSG tone
		or	a								; Test if it is zero
		ld	c, 0							; c = 0
		jr	z, .no_volenv					; Branch if no PSG tone
		dec	a								; Make it into a 0-based index
		ld	c, zID_VolEnvPointers			; Value for volume envelope pointer table
		rst	GetPointerTable					; hl = pointer to volume envelope table
		rst	PointerTableOffset				; hl = pointer to volume envelope for track
		call	zDoVolEnv					; Get new volume envelope
		ld	c, a							; c = new volume envelope

.no_volenv:
		bit	4, (ix+zTrack.PlaybackControl)	; Is track resting?
		ret	nz								; Return if yes
	bit	0,(ix+zTrack.PSGSustain)		; MJ: is the track sustaining?
	ret	nz					; MJ: if so, return
		ld	a, (ix+zTrack.Volume)			; Get track volume
		add	a, c							; Add volume envelope to it
		bit	4, a							; Is bit 4 set?
		jr	z, .no_underflow				; Branch if not
		ld	a, 0Fh							; Set silence on PSG track

.no_underflow:
		or	(ix+zTrack.VoiceControl)		; Mask in the PSG channel bits
		add	a, 10h							; Flag to latch volume
		bit	0, (ix+zTrack.PlaybackControl)	; Is this a noise channel?

		jr	z, .not_noise					; Branch if not
		add	a, 20h							; Change to noise channel
.not_noise:
		ld	(zPSG), a						; Set noise channel volume
		ret
; ---------------------------------------------------------------------------
;loc_1037
;zDoFlutterSetValue
zDoVolEnvSetValue:
		ld	(ix+zTrack.VolEnv), a			; Set new value for PSG envelope index and fall through

; =============== S U B	R O U T	I N E =======================================
; Get next PSG volume envelope value.
;
; Input:   ix    Pointer to track RAM
;          hl    Pointer to current PSG volume envelope
; Output:  a     New volume envelope value
;          bc    Trashed
;
;sub_103A
;zDoFlutter
zDoVolEnv:
		push	hl							; Save hl
		ld	c, (ix+zTrack.VolEnv)			; Get current PSG envelope index
		ld	b, 0							; b = 0
		add	hl, bc							; Offset into PSG envelope table

		ld	c, l
		ld	b, h
		ld	a, (bc)							; a = PSG volume envelope

		pop	hl								; Restore hl
		bit	7, a							; Is it a terminator?
		jr	z, zDoVolEnvAdvance				; Branch if not
		cp	83h								; Is it a command to put PSG channel to rest?
		jr	z, zDoVolEnvFullRest			; Branch if yes
		cp	81h								; Is it a command to set rest flag on PSG channel?
		jr	z, zDoVolEnvRest				; Branch if yes
		cp	80h								; Is it a command to reset envelope?
		jr	z, zDoVolEnvReset				; Branch if yes

		inc	bc								; Increment envelope index
		ld	a, (bc)							; Get value from wherever the hell bc is pointing to
		jr	zDoVolEnvSetValue				; Use this as new envelope index
; ---------------------------------------------------------------------------
;loc_1057
;zDoFlutterFullRest
zDoVolEnvFullRest:
		pop	hl								; Pop return value from stack (causes a 'ret' to return to caller of zUpdatePSGTrack)
		jp	zRestTrack						; Put track at rest
; ---------------------------------------------------------------------------
;loc_105F
;zDoFlutterReset
zDoVolEnvReset:
		xor	a								; a = 0
		jr	zDoVolEnvSetValue
; ---------------------------------------------------------------------------
;loc_1062
;zDoFlutterRest
zDoVolEnvRest:
		pop	hl								; Pop return value from stack (causes a 'ret' to return to caller of zUpdatePSGTrack)
	;	set	4, (ix+zTrack.PlaybackControl)	; Set 'track is resting' bit
	set	0,(ix+zTrack.PSGSustain)		; MJ: set the track as sustaining <- Natsumi note: This works correctly for FM as well
		ret									; Do NOT silence PSG channel
; ---------------------------------------------------------------------------
;loc_1068
;zDoFlutterAdvance
zDoVolEnvAdvance:
		inc	(ix+zTrack.VolEnv)				; Advance envelope
		ret
; End of function zDoVolEnv


; =============== S U B	R O U T	I N E =======================================
;
;sub_106C
zRestTrack:
		set	4, (ix+zTrack.PlaybackControl)	; Set 'track is resting' bit
		bit	2, (ix+zTrack.PlaybackControl)	; Is SFX overriding this track?
		ret	nz								; Return if so
; End of function zRestTrack


; =============== S U B	R O U T	I N E =======================================
;
;sub_1075
zSilencePSGChannel:
		ld	a, 1Fh							; Set volume to zero on PSG channel
		add	a, (ix+zTrack.VoiceControl)		; Add in the PSG channel selector
		or	a								; Is it an actual PSG channel?
		ret	p								; Return if not
		ld	(zPSG), a						; Silence this channel

		cp	0DFh							; Was this PSG3?
		ret	nz								; Return if not
		ld	a, 0FFh							; Command to silence Noise channel
		ld	(zPSG), a						; Do it
		ret

; =============== S U B	R O U T	I N E =======================================
;
; Plays the SEGA PCM sound. The z80 will be "stuck" in this function (as it
; disables interrupts) until either of the following conditions hold:
;
;	(1)	The SEGA PCM is fully played
;	(2)	The next song to play is 0FEh (SndID_StopSega)
;loc_1126
	if 0==1
zPlaySEGAPCM:
		xor	a								; a = 0
		ld	(PlaySegaPCMFlag), a			; Clear flag
		ld	a, 2Bh							; DAC enable/disable register
		ld	(zYM2612_A0), a					; Select the register
		nop									; Delay
		ld	a, 80h							; Value to enable DAC
		ld	(zYM2612_D0), a					; Enable DAC
		ld	a, zmake68kBank(SEGA_PCM)		; a = sound bank index
		bankswitch3							; Bank switch to sound bank
		ld	hl, zmake68kPtr(SEGA_PCM)		; hl = pointer to SEGA PCM
		ld	de, SEGA_PCM_End-SEGA_PCM		; de = length of SEGA PCM
		ld	a, 2Ah							; DAC channel register
		ld	(zYM2612_A0), a					; Send to YM2612
		nop									; Delay

.loop:
		ld	a, (hl)							; a = next byte of SEGA PCM
		ld	(zYM2612_D0), a					; Send to DAC
		ld	a, (zMusicNumber)				; Check next song number
		cp	SndID_StopSega					; Is it the command to stop playing SEGA PCM?
		jr	z, .done						; Break the loop if yes
		nop
		nop

		ld	b, 0Ch							; Loop counter
		djnz	$							; Loop in this instruction, decrementing b each iteration, until b = 0

		inc	hl								; Advance to next byte of SEGA PCM
		dec	de								; Mark one byte as being done
		ld	a, d							; a = d
		or	e								; Is length zero?
		jr	nz, .loop						; Loop if not

.done:
		jp	zPlayDigitalAudio				; Go back to normal DAC code
	endif
; ---------------------------------------------------------------------------

	if extra_flags==1
cfFreeze:
		xor	a
		ld	(0),a			; clear 0th byte
		jr	$			; freeze cpu
; ---------------------------------------------------------------------------

cfSync:
		ld	(SYNC),a		; load sync
		ret
; ---------------------------------------------------------------------------

cfTickStop:
		dec	de
		or	a, 0FFh			; load a with $FF
		ld	(zDoTicks),a		; set value to $FF
		ret
	endif
; ---------------------------------------------------------------------------

ModEnv09:	db 0, -1, -1, -2, -2, -3, -3, -4, -4, -4, -3, -2, -1, 0, 0, 1
		db 2, 2, 3, 4, 5, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3
		db 82h, 10h		; jump back to start of 2nd line

	if $ > 1300h
		fatal "Your Z80 code won't fit before its tables. It's \{$-1300h}h bytes past the start of music data \{1300h}h"
	endif

	if MOMPASS=2
		message "Z80 sound driver is \{$}h bytes in size, with \{1300h-$}h bytes free"
	endif
z80_SoundDriverEnd:

		restore
		padding off
		!org		z80_SoundDriver+Size_of_Snd_driver_guess

		align0 $10

Z80_Snd_Driver2:
; ---------------------------------------------------------------------------
		save
		CPU Z80
		listing purecode
		!org	1300h						; z80 Align, handled by the build process

; ---------------------------------------------------------------------------
; ===========================================================================
; Pointers
; ===========================================================================

z80_SoundDriverPointers:
		dw	z80_MusicPointers
		dw	z80_SFXPointers
		dw	z80_ModEnvPointers
		dw	z80_VolEnvPointers
; ---------------------------------------------------------------------------
; ===========================================================================
; Modulation Envelope Pointers
; ===========================================================================
;z80_FreqFlutterPointers
z80_ModEnvPointers:
		dw ModEnv00, ModEnv01, ModEnv02, ModEnv03
		dw ModEnv04, ModEnv05, ModEnv06, ModEnv07
		dw ModEnv09	; Natsumi (DEZ2 Mini)

ModEnv01:	db    0
ModEnv00:	db    1,   2,   1,   0,0FFh,0FEh,0FDh,0FCh,0FDh,0FEh,0FFh, 83h
ModEnv02:	db    0,   0,   0,   0, 13h, 26h, 39h, 4Ch, 5Fh, 72h, 7Fh, 72h, 83h
ModEnv03:	db    1,   2,   3,   2,   1,   0,0FFh,0FEh,0FDh,0FEh,0FFh,   0, 82h,   0
ModEnv04:	db    0,   0,   1,   3,   1,   0,0FFh,0FDh,0FFh,   0, 82h,   2
ModEnv05:	db    0,   0,   0,   0,   0, 0Ah, 14h, 1Eh, 14h, 0Ah,   0,0F6h,0ECh,0E2h,0ECh,0F6h
        	db  82h,   4
ModEnv06:	db    0,   0,   0,   0, 16h, 2Ch, 42h, 2Ch, 16h,   0,0EAh,0D4h,0BEh,0D4h,0EAh, 82h
        	db    3
ModEnv07:	db    1,   2,   3,   4,   3,   2,   1,   0,0FFh,0FEh,0FDh,0FCh,0FDh,0FEh,0FFh,   0
        	db  82h,   1

; ---------------------------------------------------------------------------
; ===========================================================================
; Volume Envelope Pointers
; ===========================================================================
;z80_PSGTonePointers
z80_VolEnvPointers:
		dw VolEnv00,VolEnv01,VolEnv02,VolEnv03,VolEnv04,VolEnv05
		dw VolEnv06,VolEnv07,VolEnv08,VolEnv09,VolEnv0A,VolEnv0B
		dw VolEnv0C,VolEnv0D,VolEnv0E,VolEnv0F,VolEnv10,VolEnv11
		dw VolEnv12,VolEnv13,VolEnv14,VolEnv15,VolEnv16,VolEnv17
		dw VolEnv18,VolEnv19,VolEnv1A,VolEnv1B,VolEnv1C,VolEnv1D
		dw VolEnv1E,VolEnv1F,VolEnv20,VolEnv21,VolEnv22,VolEnv23
		dw VolEnv24,VolEnv25,VolEnv26

VolEnv00:	db    2, 83h

VolEnv0E:
VolEnv01:	db    0,   2,   4,   6,   8, 10h, 83h

VolEnv02:	db    2,   1,   0,   0,   1,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2
		db    2,   3,   3,   3,   4,   4,   4,   5, 81h

VolEnv03:	db    0,   0,   2,   3,   4,   4,   5,   5,   5,   6,   6, 81h

VolEnv04:	db    3,   0,   1,   1,   1,   2,   3,   4,   4,   5, 81h

VolEnv05:	db    0,   0,   1,   1,   2,   3,   4,   5,   5,   6,   8,   7,   7,   6, 81h

VolEnv06:	db    1, 0Ch,   3, 0Fh,   2,   7,   3, 0Fh, 80h

VolEnv07:	db    0,   0,   0,   2,   3,   3,   4,   5,   6,   7,   8,   9, 0Ah, 0Bh, 0Eh, 0Fh
		db  83h

VolEnv08:	db    3,   2,   1,   1,   0,   0,   1,   2,   3,   4, 81h

VolEnv09:	db    1,   0,   0,   0,   0,   1,   1,   1,   2,   2,   2,   3,   3,   3,   3,   4
		db    4,   4,   5,   5, 81h

VolEnv0A:	db  10h, 20h, 30h, 40h, 30h, 20h, 10h,   0,0F0h, 80h

VolEnv0B:	db    0,   0,   1,   1,   3,   3,   4,   5, 83h

VolEnv0C:	db    0, 81h

VolEnv0D:	db    2, 83h

VolEnv0F:	db    9,   9,   9,   8,   8,   8,   7,   7,   7,   6,   6,   6,   5,   5,   5,   4
		db    4,   4,   3,   3,   3,   2,   2,   2,   1,   1,   1,   0,   0,   0, 81h

VolEnv10:	db    1,   1,   1,   0,   0,   0, 81h

VolEnv11:	db    3,   0,   1,   1,   1,   2,   3,   4,   4,   5, 81h

VolEnv12:	db    0,   0,   1,   1,   2,   3,   4,   5,   5,   6,   8,   7,   7,   6, 81h

VolEnv13:	db  0Ah,   5,   0,   4,   8, 83h

VolEnv14:	db    0,   0,   0,   2,   3,   3,   4,   5,   6,   7,   8,   9, 0Ah, 0Bh, 0Eh, 0Fh
		db  83h

VolEnv15:	db    3,   2,   1,   1,   0,   0,   1,   2,   3,   4, 81h

VolEnv16:	db    1,   0,   0,   0,   0,   1,   1,   1,   2,   2,   2,   3,   3,   3,   3,   4
		db    4,   4,   5,   5, 81h

VolEnv17:	db  10h, 20h, 30h, 40h, 30h, 20h, 10h,   0, 10h, 20h, 30h, 40h, 30h, 20h, 10h,   0
		db  10h, 20h, 30h, 40h, 30h, 20h, 10h,   0, 80h

VolEnv18:	db    0,   0,   1,   1,   3,   3,   4,   5, 83h

VolEnv19:	db    0,   2,   4,   6,   8, 16h, 83h

VolEnv1A:	db    0,   0,   1,   1,   3,   3,   4,   5, 83h

VolEnv1B:	db    4,   4,   4,   4,   3,   3,   3,   3,   2,   2,   2,   2,   1,   1,   1,   1
		db  83h

VolEnv1C:	db    0,   0,   0,   0,   1,   1,   1,   1,   2,   2,   2,   2,   3,   3,   3,   3
		db    4,   4,   4,   4,   5,   5,   5,   5,   6,   6,   6,   6,   7,   7,   7,   7
		db    8,   8,   8,   8,   9,   9,   9,   9, 0Ah, 0Ah, 0Ah, 0Ah, 81h

VolEnv1D:	db    0, 0Ah, 83h

VolEnv1E:	db    0,   2,   4, 81h

VolEnv1F:	db  30h, 20h, 10h,   0,   0,   0,   0,   0,   8, 10h, 20h, 30h, 81h

VolEnv20:	db    0,   4,   4,   4,   4,   4,   4,   4,   4,   4,   4,   6,   6,   6,   8,   8
		db  0Ah, 83h

VolEnv21:	db    0,   2,   3,   4,   6,   7, 81h

VolEnv22:	db    2,   1,   0,   0,   0,   2,   4,   7, 81h

VolEnv23:	db  0Fh,   1,   5, 83h

VolEnv24:	db    8,   6,   2,   3,   4,   5,   6,   7,   8,   9, 0Ah, 0Bh, 0Ch, 0Dh, 0Eh, 0Fh
		db  10h, 83h

VolEnv25:	db    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   1,   1,   1,   1,   1,   1
		db    1,   1,   1,   1,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   3,   3
		db    3,   3,   3,   3,   3,   3,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4
		db    4,   4,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   6,   6,   6,   6
		db    6,   6,   6,   6,   6,   6,   7,   7,   7,   7,   7,   7,   7,   7,   7,   7
		db    8,   8,   8,   8,   8,   8,   8,   8,   8,   8,   9,   9,   9,   9,   9,   9
		db    9,   9, 83h

VolEnv26:	db    0,   2,   2,   2,   3,   3,   3,   4,   4,   4,   5,   5, 83h

; ---------------------------------------------------------------------------


; ===========================================================================
; Music Pointers
; ===========================================================================

z80_MusicPointers:
		domusic	muspt		; create pointers
; ---------------------------------------------------------------------------
; ===========================================================================
; SFX Pointers
; ===========================================================================

z80_SFXPointers:
		dw	zmake68kPtr(Sound_33),zmake68kPtr(Sound_34),zmake68kPtr(Sound_35),zmake68kPtr(Sound_36)
		dw	zmake68kPtr(Sound_37),zmake68kPtr(Sound_38),zmake68kPtr(Sound_39),zmake68kPtr(Sound_3A)
		dw	zmake68kPtr(Sound_3B),zmake68kPtr(Sound_3C),zmake68kPtr(Sound_3D),zmake68kPtr(Sound_3E)
		dw	zmake68kPtr(Sound_3F)

		dw	zmake68kPtr(Sound_40),zmake68kPtr(Sound_41),zmake68kPtr(Sound_42),zmake68kPtr(Sound_43)
		dw	zmake68kPtr(Sound_44),zmake68kPtr(Sound_45),zmake68kPtr(Sound_46),zmake68kPtr(Sound_47)
		dw	zmake68kPtr(Sound_48),zmake68kPtr(Sound_49),zmake68kPtr(Sound_4A),zmake68kPtr(Sound_4B)
		dw	zmake68kPtr(Sound_4C),zmake68kPtr(Sound_4D),zmake68kPtr(Sound_4E),zmake68kPtr(Sound_4F)

		dw	zmake68kPtr(Sound_50),zmake68kPtr(Sound_51),zmake68kPtr(Sound_52),zmake68kPtr(Sound_53)
		dw	zmake68kPtr(Sound_54),zmake68kPtr(Sound_55),zmake68kPtr(Sound_56),zmake68kPtr(Sound_57)
		dw	zmake68kPtr(Sound_58),zmake68kPtr(Sound_59),zmake68kPtr(Sound_5A),zmake68kPtr(Sound_5B)
		dw	zmake68kPtr(Sound_5C),zmake68kPtr(Sound_5D),zmake68kPtr(Sound_5E),zmake68kPtr(Sound_5F)

		dw	zmake68kPtr(Sound_60),zmake68kPtr(Sound_61),zmake68kPtr(Sound_62),zmake68kPtr(Sound_63)
		dw	zmake68kPtr(Sound_64),zmake68kPtr(Sound_65),zmake68kPtr(Sound_66),zmake68kPtr(Sound_67)
		dw	zmake68kPtr(Sound_68),zmake68kPtr(Sound_69),zmake68kPtr(Sound_6A),zmake68kPtr(Sound_6B)
		dw	zmake68kPtr(Sound_6C),zmake68kPtr(Sound_6D),zmake68kPtr(Sound_6E),zmake68kPtr(Sound_6F)

		dw	zmake68kPtr(Sound_70),zmake68kPtr(Sound_71),zmake68kPtr(Sound_72),zmake68kPtr(Sound_73)
		dw	zmake68kPtr(Sound_74),zmake68kPtr(Sound_75),zmake68kPtr(Sound_76),zmake68kPtr(Sound_77)
		dw	zmake68kPtr(Sound_78),zmake68kPtr(Sound_79),zmake68kPtr(Sound_7A),zmake68kPtr(Sound_7B)
		dw	zmake68kPtr(Sound_7C),zmake68kPtr(Sound_7D),zmake68kPtr(Sound_7E),zmake68kPtr(Sound_7F)

		dw	zmake68kPtr(Sound_80),zmake68kPtr(Sound_81),zmake68kPtr(Sound_82),zmake68kPtr(Sound_83)
		dw	zmake68kPtr(Sound_84),zmake68kPtr(Sound_85),zmake68kPtr(Sound_86),zmake68kPtr(Sound_87)
		dw	zmake68kPtr(Sound_88),zmake68kPtr(Sound_89),zmake68kPtr(Sound_8A),zmake68kPtr(Sound_8B)
		dw	zmake68kPtr(Sound_8C),zmake68kPtr(Sound_8D),zmake68kPtr(Sound_8E),zmake68kPtr(Sound_8F)

		dw	zmake68kPtr(Sound_90),zmake68kPtr(Sound_91),zmake68kPtr(Sound_92),zmake68kPtr(Sound_93)
		dw	zmake68kPtr(Sound_94),zmake68kPtr(Sound_95),zmake68kPtr(Sound_96),zmake68kPtr(Sound_97)
		dw	zmake68kPtr(Sound_98),zmake68kPtr(Sound_99),zmake68kPtr(Sound_9A),zmake68kPtr(Sound_9B)
		dw	zmake68kPtr(Sound_9C),zmake68kPtr(Sound_9D),zmake68kPtr(Sound_9E),zmake68kPtr(Sound_9F)

		dw	zmake68kPtr(Sound_A0),zmake68kPtr(Sound_A1),zmake68kPtr(Sound_A2),zmake68kPtr(Sound_A3)
		dw	zmake68kPtr(Sound_A4),zmake68kPtr(Sound_A5),zmake68kPtr(Sound_A6),zmake68kPtr(Sound_A7)
		dw	zmake68kPtr(Sound_A8),zmake68kPtr(Sound_A9),zmake68kPtr(Sound_AA),zmake68kPtr(Sound_AB)
		dw	zmake68kPtr(Sound_AC),zmake68kPtr(Sound_AD),zmake68kPtr(Sound_AE),zmake68kPtr(Sound_AF)

		dw	zmake68kPtr(Sound_B0),zmake68kPtr(Sound_B1),zmake68kPtr(Sound_B2),zmake68kPtr(Sound_B3)
		dw	zmake68kPtr(Sound_B4),zmake68kPtr(Sound_B5),zmake68kPtr(Sound_B6),zmake68kPtr(Sound_B7)
		dw	zmake68kPtr(Sound_B8),zmake68kPtr(Sound_B9),zmake68kPtr(Sound_BA),zmake68kPtr(Sound_BB)
		dw	zmake68kPtr(Sound_BC),zmake68kPtr(Sound_BD),zmake68kPtr(Sound_BE),zmake68kPtr(Sound_BF)

		dw	zmake68kPtr(Sound_C0),zmake68kPtr(Sound_C1),zmake68kPtr(Sound_C2),zmake68kPtr(Sound_C3)
		dw	zmake68kPtr(Sound_C4),zmake68kPtr(Sound_C5),zmake68kPtr(Sound_C6),zmake68kPtr(Sound_C7)
		dw	zmake68kPtr(Sound_C8),zmake68kPtr(Sound_C9),zmake68kPtr(Sound_CA),zmake68kPtr(Sound_CB)
		dw	zmake68kPtr(Sound_CC),zmake68kPtr(Sound_CD),zmake68kPtr(Sound_CE),zmake68kPtr(Sound_CF)

		dw	zmake68kPtr(Sound_D0),zmake68kPtr(Sound_D1),zmake68kPtr(Sound_D2),zmake68kPtr(Sound_D3)
		dw	zmake68kPtr(Sound_D4),zmake68kPtr(Sound_D5),zmake68kPtr(Sound_D6),zmake68kPtr(Sound_D7)
		dw	zmake68kPtr(Sound_D8),zmake68kPtr(Sound_D9),zmake68kPtr(Sound_DA),zmake68kPtr(Sound_DB)
		dw	zmake68kPtr(Sound_DB),zmake68kPtr(Sound_DB),zmake68kPtr(Sound_DB),zmake68kPtr(Sound_DB)
; ---------------------------------------------------------------------------
; ===========================================================================
; FM Universal Voice Bank
; ===========================================================================
	align 17D8h

z80_UniVoiceBank:
	; Synth Bass 2
	    db  3Ch,   1,   0,   0,   0, 1Fh, 1Fh, 15h, 1Fh, 11h, 0Dh, 12h,   5
		db         7,   4,   9,   2, 55h, 3Ah, 25h, 1Ah, 1Ah, 80h,   7, 80h				; 0
	; Trumpet 1
	    db  3Dh,   1,   1,   1,   1, 94h, 19h, 19h, 19h, 0Fh, 0Dh, 0Dh, 0Dh
		db         7,   4,   4,   4, 25h, 1Ah, 1Ah, 1Ah, 15h, 80h, 80h, 80h				; 25
	; Slap Bass 2
	    db    3,   0,0D7h, 33h,   2, 5Fh, 9Fh, 5Fh, 1Fh, 13h, 0Fh, 0Ah, 0Ah
		db       10h, 0Fh,   2,   9, 35h, 15h, 25h, 1Ah, 13h, 16h, 15h, 80h				; 50
	; Synth Bass 1
	    db  34h, 70h, 72h, 31h, 31h, 1Fh, 1Fh, 1Fh, 1Fh, 10h,   6,   6,   6
		db         1,   6,   6,   6, 35h, 1Ah, 15h, 1Ah, 10h, 83h, 18h, 83h				; 75
	; Bell Synth 1
	    db  3Eh, 77h, 71h, 32h, 31h, 1Fh, 1Fh, 1Fh, 1Fh, 0Dh,   6,   0,   0
		db         8,   6,   0,   0, 15h, 0Ah, 0Ah, 0Ah, 1Bh, 80h, 80h, 80h				; 100
	; Bell Synth 2
	    db  34h, 33h, 41h, 7Eh, 74h, 5Bh, 9Fh, 5Fh, 1Fh,   4,   7,   7,   8
		db         0,   0,   0,   0,0FFh,0FFh,0EFh,0FFh, 23h, 80h, 29h, 87h				; 125
	; Synth Brass 1
	    db  3Ah,   1,   7, 31h, 71h, 8Eh, 8Eh, 8Dh, 53h, 0Eh, 0Eh, 0Eh,   3
		db         0,   0,   0,   7, 1Fh,0FFh, 1Fh, 0Fh, 18h, 28h, 27h, 80h				; 150
	; Synth like Bassoon
	    db  3Ch, 32h, 32h, 71h, 42h, 1Fh, 18h, 1Fh, 1Eh,   7, 1Fh,   7, 1Fh
		db         0,   0,   0,   0, 1Fh, 0Fh, 1Fh, 0Fh, 1Eh, 80h, 0Ch, 80h				; 175
	; Bell Horn type thing
	    db  3Ch, 71h, 72h, 3Fh, 34h, 8Dh, 52h, 9Fh, 1Fh,   9,   0,   0, 0Dh
		db         0,   0,   0,   0, 23h,   8,   2,0F7h, 15h, 80h, 1Dh, 87h				; 200
	; Synth Bass 3
	    db  3Dh,   1,   1,   0,   0, 8Eh, 52h, 14h, 4Ch,   8,   8, 0Eh,   3
		db         0,   0,   0,   0, 1Fh, 1Fh, 1Fh, 1Fh, 1Bh, 80h, 80h, 9Bh				; 225
	; Synth Trumpet
	    db  3Ah,   1,   1,   1,   2, 8Dh,   7,   7, 52h,   9,   0,   0,   3
		db         1,   2,   2,   0, 52h,   2,   2, 28h, 18h, 22h, 18h, 80h				; 250
	; Wood Block
	    db  3Ch, 36h, 31h, 76h, 71h, 94h, 9Fh, 96h, 9Fh, 12h,   0, 14h, 0Fh
		db         4, 0Ah,   4, 0Dh, 2Fh, 0Fh, 4Fh, 2Fh, 33h, 80h, 1Ah, 80h				; 275
	; Tubular Bell
	    db  34h, 33h, 41h, 7Eh, 74h, 5Bh, 9Fh, 5Fh, 1Fh,   4,   7,   7,   8
		db         0,   0,   0,   0,0FFh,0FFh,0EFh,0FFh, 23h, 90h, 29h, 97h				; 300
	; Strike Bass
	    db  38h, 63h, 31h, 31h, 31h, 10h, 13h, 1Ah, 1Bh, 0Eh,   0,   0,   0
		db         0,   0,   0,   0, 3Fh, 0Fh, 0Fh, 0Fh, 1Ah, 19h, 1Ah, 80h				; 325
	; Elec Piano
	    db  3Ah, 31h, 25h, 73h, 41h, 5Fh, 1Fh, 1Fh, 9Ch,   8,   5,   4,   5
		db         3,   4,   2,   2, 2Fh, 2Fh, 1Fh, 2Fh, 29h, 27h, 1Fh, 80h				; 350
	; Bright Piano
	    db    4, 71h, 41h, 31h, 31h, 12h, 12h, 12h, 12h,   0,   0,   0,   0
		db         0,   0,   0,   0, 0Fh, 0Fh, 0Fh, 0Fh, 23h, 80h, 23h, 80h				; 375
	; Church Bell
	    db  14h, 75h, 72h, 35h, 32h, 9Fh, 9Fh, 9Fh, 9Fh,   5,   5,   0, 0Ah
		db         5,   5,   7,   5, 2Fh,0FFh, 0Fh, 2Fh, 1Eh, 80h, 14h, 80h				; 400
	; Synth Brass 2
	    db  3Dh,   1,   0,   1,   2, 12h, 1Fh, 1Fh, 14h,   7,   2,   2, 0Ah
		db         5,   5,   5,   5, 2Fh, 2Fh, 2Fh,0AFh, 1Ch, 80h, 82h, 80h				; 425
	; Bell Piano
	    db  1Ch, 73h, 72h, 33h, 32h, 94h, 99h, 94h, 99h,   8, 0Ah,   8, 0Ah
		db         0,   5,   0,   5, 3Fh, 4Fh, 3Fh, 4Fh, 1Eh, 80h, 19h, 80h				; 450
	; Wet Wood Bass
	    db  31h, 33h,   1,   0,   0, 9Fh, 1Fh, 1Fh, 1Fh, 0Dh, 0Ah, 0Ah, 0Ah
		db       0Ah,   7,   7,   7,0FFh,0AFh,0AFh,0AFh, 1Eh, 1Eh, 1Eh, 80h				; 475
	; Silent Bass
	    db  3Ah, 70h, 76h, 30h, 71h, 1Fh, 95h, 1Fh, 1Fh, 0Eh, 0Fh,   5, 0Ch
		db         7,   6,   6,   7, 2Fh, 4Fh, 1Fh, 5Fh, 21h, 12h, 28h, 80h				; 500
	; Picked Bass
	    db  28h, 71h,   0, 30h,   1, 1Fh, 1Fh, 1Dh, 1Fh, 13h, 13h,   6,   5
		db         3,   3,   2,   5, 4Fh, 4Fh, 2Fh, 3Fh, 0Eh, 14h, 1Eh, 80h				; 525
	; Xylophone
	    db  3Eh, 38h,   1, 7Ah, 34h, 59h,0D9h, 5Fh, 9Ch, 0Fh,   4, 0Fh, 0Ah
		db         2,   2,   5,   5,0AFh,0AFh, 66h, 66h, 28h, 80h,0A3h, 80h				; 550
	; Sine Flute
	    db  39h, 32h, 31h, 72h, 71h, 1Fh, 1Fh, 1Fh, 1Fh,   0,   0,   0,   0
		db         0,   0,   0,   0, 0Fh, 0Fh, 0Fh, 0Fh, 1Bh, 32h, 28h, 80h				; 575
	; Pipe Organ
	    db    7, 34h, 74h, 32h, 71h, 1Fh, 1Fh, 1Fh, 1Fh, 0Ah, 0Ah,   5,   3
		db         0,   0,   0,   0, 3Fh, 3Fh, 2Fh, 2Fh, 8Ah, 8Ah, 80h, 80h				; 600
	; Synth Brass 2
	    db  3Ah, 31h, 37h, 31h, 31h, 8Dh, 8Dh, 8Eh, 53h, 0Eh, 0Eh, 0Eh,   3
		db         0,   0,   0,   0, 1Fh,0FFh, 1Fh, 0Fh, 17h, 28h, 26h, 80h				; 625
	; Harpsichord
	    db  3Bh, 3Ah, 31h, 71h, 74h,0DFh, 1Fh, 1Fh,0DFh,   0, 0Ah, 0Ah,   5
		db         0,   5,   5,   3, 0Fh, 5Fh, 1Fh, 5Fh, 32h, 1Eh, 0Fh, 80h				; 650
	; Metallic Bass
	    db    5,   4,   1,   2,   4, 8Dh, 1Fh, 15h, 52h,   6,   0,   0,   4
		db         2,   8,   0,   0, 1Fh, 0Fh, 0Fh, 2Fh, 16h, 90h, 84h, 8Ch				; 675
	; Alternate Metallic Bass
	    db  2Ch, 71h, 74h, 32h, 32h, 1Fh, 12h, 1Fh, 12h,   0, 0Ah,   0, 0Ah
		db         0,   0,   0,   0, 0Fh, 1Fh, 0Fh, 1Fh, 16h, 80h, 17h, 80h				; 700
	; Backdropped Metallic Bass
	    db  3Ah,   1,   7,   1,   1, 8Eh, 8Eh, 8Dh, 53h, 0Eh, 0Eh, 0Eh,   3
		db         0,   0,   0,   7, 1Fh,0FFh, 1Fh, 0Fh, 18h, 28h, 27h, 8Fh				; 725
	; Sine like Bell
	    db  36h, 7Ah, 32h, 51h, 11h, 1Fh, 1Fh, 59h, 1Ch, 0Ah, 0Dh,   6, 0Ah
		db         7,   0,   2,   2,0AFh, 5Fh, 5Fh, 5Fh, 1Eh, 8Bh, 81h, 80h				; 750
	; Synth like Metallic with Small Bell
	    db  3Ch, 71h, 72h, 3Fh, 34h, 8Dh, 52h, 9Fh, 1Fh,   9,   0,   0, 0Dh
		db         0,   0,   0,   0, 23h,   8,   2,0F7h, 15h, 85h, 1Dh, 8Ah				; 775
	; Nice Synth like lead
	    db  3Eh, 77h, 71h, 32h, 31h, 1Fh, 1Fh, 1Fh, 1Fh, 0Dh,   6,   0,   0
		db         8,   6,   0,   0, 15h, 0Ah, 0Ah, 0Ah, 1Bh, 8Fh, 8Fh, 8Fh				; 800
	; Rock Organ
	    db    7, 34h, 74h, 32h, 71h, 1Fh, 1Fh, 1Fh, 1Fh, 0Ah, 0Ah,   5,   3
		db         0,   0,   0,   0, 3Fh, 3Fh, 2Fh, 2Fh, 8Ah, 8Ah, 8Ah, 8Ah				; 825
	; Strike like Slap Bass
	    db  20h, 36h, 35h, 30h, 31h,0DFh,0DFh, 9Fh, 9Fh,   7,   6,   9,   6
		db         7,   6,   6,   8, 20h, 10h, 10h,0F8h, 19h, 37h, 13h, 80h				; 850

	if $ > zDataStart
		fatal "Your Z80 tables won't fit before its variables. It's \{$-zDataStart}h bytes past the start of the variables, at \{zDataStart}h"
	endif


z80_SoundDriverPointersEnd:
; ---------------------------------------------------------------------------
; ===========================================================================
; END OF SOUND DRIVER
; ===========================================================================
		restore
		padding off
		!org		Z80_Snd_Driver2+Size_of_Snd_driver2_guess

Z80_Snd_Driver_End:
		align0 $10

; ===========================================================================
; ---------------------------------------------------------------------------
; Include all music and SFX banks
; ---------------------------------------------------------------------------

; ===========================================================================
; Sound Bank
; ===========================================================================
SndBank:			startBank

SEGA_PCM:;	binclude "Sound/Sega PCM.bin"
SEGA_PCM_End
Snd_MGZ1:		include	"Sound/Music/MGZ1.asm"
Snd_MGZ2:		include	"Sound/Music/MGZ2.asm"
Snd_LBZ2:		include	"Sound/Music/LBZ2.asm"
Snd_LBZ1:		include	"Sound/Music/LBZ1.asm"
Snd_ICZ2:		include	"Sound/Music/ICZ2.asm"
Snd_ICZ1:		include	"Sound/Music/ICZ1.asm"
Snd_AIZ1:		include	"Sound/Music/AIZ1.asm"
Snd_AIZ2:		include	"Sound/Music/AIZ2.asm"
Snd_MiniAIZ:		include	"Sound/Music/AIZ2 Mini Game.asm"
Snd_DEZ1:		include	"Sound/Music/DEZ1.asm"
Snd_DEZ2:		include	"Sound/Music/DEZ2.asm"
Snd_MiniDEZ2:		include "Sound/Music/DEZ2 Mini.asm"

SndBank_Align:
	org soundBankStart+($DE30-$8000)
;		align 2
Sound_33:	binclude "Sound/SFX/33.bin"
Sound_34:	binclude "Sound/SFX/34.bin"
Sound_35:	binclude "Sound/SFX/35.bin"
Sound_36:	binclude "Sound/SFX/36.bin"
Sound_37:	binclude "Sound/SFX/37.bin"
Sound_38:	binclude "Sound/SFX/38.bin"
Sound_39:	binclude "Sound/SFX/39.bin"
Sound_3A:	binclude "Sound/SFX/3A.bin"
Sound_3B:	binclude "Sound/SFX/3B.bin"
Sound_3C:	binclude "Sound/SFX/3C.bin"
Sound_3D:	binclude "Sound/SFX/3D.bin"
Sound_3E:	binclude "Sound/SFX/3E.bin"
Sound_3F:	binclude "Sound/SFX/3F.bin"
Sound_40:	binclude "Sound/SFX/40.bin"
Sound_41:	binclude "Sound/SFX/41.bin"
Sound_42:	binclude "Sound/SFX/42.bin"
Sound_43:	binclude "Sound/SFX/43.bin"
Sound_44:	binclude "Sound/SFX/44.bin"
Sound_45:	binclude "Sound/SFX/45.bin"
Sound_46:	binclude "Sound/SFX/46.bin"
Sound_47:	binclude "Sound/SFX/47.bin"
Sound_48:	binclude "Sound/SFX/48.bin"
Sound_49:	binclude "Sound/SFX/49.bin"
Sound_4A:	binclude "Sound/SFX/4A.bin"
Sound_4B:	binclude "Sound/SFX/4B.bin"
Sound_4C:	binclude "Sound/SFX/4C.bin"
Sound_4D:	binclude "Sound/SFX/4D.bin"
Sound_4E:	binclude "Sound/SFX/4E.bin"
Sound_4F:	binclude "Sound/SFX/4F.bin"
Sound_50:	binclude "Sound/SFX/50.bin"
Sound_51:	binclude "Sound/SFX/51.bin"
Sound_52:	binclude "Sound/SFX/52.bin"
Sound_53:	binclude "Sound/SFX/53.bin"
Sound_54:	binclude "Sound/SFX/54.bin"
Sound_55:	binclude "Sound/SFX/55.bin"
Sound_56:	binclude "Sound/SFX/56.bin"
Sound_57:	binclude "Sound/SFX/57.bin"
Sound_58:	binclude "Sound/SFX/58.bin"
Sound_59:	binclude "Sound/SFX/59.bin"
Sound_5A:	binclude "Sound/SFX/5A.bin"
Sound_5B:	binclude "Sound/SFX/5B.bin"
Sound_5C:	binclude "Sound/SFX/5C.bin"
Sound_5D:	binclude "Sound/SFX/5D.bin"
Sound_5E:	binclude "Sound/SFX/5E.bin"
Sound_5F:	binclude "Sound/SFX/5F.bin"
Sound_60:	binclude "Sound/SFX/60.bin"
Sound_61:	binclude "Sound/SFX/61.bin"
Sound_62:	binclude "Sound/SFX/62.bin"
Sound_63:	binclude "Sound/SFX/63.bin"
Sound_64:	binclude "Sound/SFX/64.bin"
Sound_65:	binclude "Sound/SFX/65.bin"
Sound_66:	binclude "Sound/SFX/66.bin"
Sound_67:	binclude "Sound/SFX/67.bin"
Sound_68:	binclude "Sound/SFX/68.bin"
Sound_69:	binclude "Sound/SFX/69.bin"
Sound_6A:	binclude "Sound/SFX/6A.bin"
Sound_6B:	binclude "Sound/SFX/6B.bin"
Sound_6C:	binclude "Sound/SFX/6C.bin"
Sound_6D:	binclude "Sound/SFX/6D.bin"
Sound_6E:	binclude "Sound/SFX/6E.bin"
Sound_6F:	binclude "Sound/SFX/6F.bin"
Sound_70:	binclude "Sound/SFX/70.bin"
Sound_71:	binclude "Sound/SFX/71.bin"
Sound_72:	binclude "Sound/SFX/72.bin"
Sound_73:	binclude "Sound/SFX/73.bin"
Sound_74:	binclude "Sound/SFX/74.bin"
Sound_75:	binclude "Sound/SFX/75.bin"
Sound_76:	binclude "Sound/SFX/76.bin"
Sound_77:	binclude "Sound/SFX/77.bin"
Sound_78:	binclude "Sound/SFX/78.bin"
Sound_79:	binclude "Sound/SFX/79.bin"
Sound_7A:	binclude "Sound/SFX/7A.bin"
Sound_7B:	binclude "Sound/SFX/7B.bin"
Sound_7C:	binclude "Sound/SFX/7C.bin"
Sound_7D:	binclude "Sound/SFX/7D.bin"
Sound_7E:	binclude "Sound/SFX/7E.bin"
Sound_7F:	binclude "Sound/SFX/7F.bin"
Sound_80:	binclude "Sound/SFX/80.bin"
Sound_81:	binclude "Sound/SFX/81.bin"
Sound_82:	binclude "Sound/SFX/82.bin"
Sound_83:	binclude "Sound/SFX/83.bin"
Sound_84:	binclude "Sound/SFX/84.bin"
Sound_85:	binclude "Sound/SFX/85.bin"
Sound_86:	binclude "Sound/SFX/86.bin"
Sound_87:	binclude "Sound/SFX/87.bin"
Sound_88:	binclude "Sound/SFX/88.bin"
Sound_89:	binclude "Sound/SFX/89.bin"
Sound_8A:	binclude "Sound/SFX/8A.bin"
Sound_8B:	binclude "Sound/SFX/8B.bin"
Sound_8C:	binclude "Sound/SFX/8C.bin"
Sound_8D:	binclude "Sound/SFX/8D.bin"
Sound_8E:	binclude "Sound/SFX/8E.bin"
Sound_8F:	binclude "Sound/SFX/8F.bin"
Sound_90:	binclude "Sound/SFX/90.bin"
Sound_91:	binclude "Sound/SFX/91.bin"
Sound_92:	binclude "Sound/SFX/92.bin"
Sound_93:	binclude "Sound/SFX/93.bin"
Sound_94:	binclude "Sound/SFX/94.bin"
Sound_95:	binclude "Sound/SFX/95.bin"
Sound_96:	binclude "Sound/SFX/96.bin"
Sound_97:	binclude "Sound/SFX/97.bin"
Sound_98:	binclude "Sound/SFX/98.bin"
Sound_99:	binclude "Sound/SFX/99.bin"
Sound_9A:	binclude "Sound/SFX/9A.bin"
Sound_9B:	binclude "Sound/SFX/9B.bin"
Sound_9C:	binclude "Sound/SFX/9C.bin"
Sound_9D:	binclude "Sound/SFX/9D.bin"
Sound_9E:	binclude "Sound/SFX/9E.bin"
Sound_9F:	binclude "Sound/SFX/9F.bin"
Sound_A0:	binclude "Sound/SFX/A0.bin"
Sound_A1:	binclude "Sound/SFX/A1.bin"
Sound_A2:	binclude "Sound/SFX/A2.bin"
Sound_A3:	binclude "Sound/SFX/A3.bin"
Sound_A4:	binclude "Sound/SFX/A4.bin"
Sound_A5:	binclude "Sound/SFX/A5.bin"
Sound_A6:	binclude "Sound/SFX/A6.bin"
Sound_A7:	binclude "Sound/SFX/A7.bin"
Sound_A8:	binclude "Sound/SFX/A8.bin"
Sound_A9:	binclude "Sound/SFX/A9.bin"
Sound_AA:	binclude "Sound/SFX/AA.bin"
Sound_AB:	binclude "Sound/SFX/AB.bin"
Sound_AC:	binclude "Sound/SFX/AC.bin"
Sound_AD:	binclude "Sound/SFX/AD.bin"
Sound_AE:	binclude "Sound/SFX/AE.bin"
Sound_AF:	binclude "Sound/SFX/AF.bin"
Sound_B0:	binclude "Sound/SFX/B0.bin"
Sound_B1:	binclude "Sound/SFX/B1.bin"
Sound_B2:	binclude "Sound/SFX/B2.bin"
Sound_B3:	binclude "Sound/SFX/B3.bin"
Sound_B4:	binclude "Sound/SFX/B4.bin"
Sound_B5:	binclude "Sound/SFX/B5.bin"
Sound_B6:	binclude "Sound/SFX/B6.bin"
Sound_B7:	binclude "Sound/SFX/B7.bin"
Sound_B8:	binclude "Sound/SFX/B8.bin"
Sound_B9:	binclude "Sound/SFX/B9.bin"
Sound_BA:	binclude "Sound/SFX/BA.bin"
Sound_BB:	binclude "Sound/SFX/BB.bin"
Sound_BC:	binclude "Sound/SFX/BC.bin"
Sound_BD:	binclude "Sound/SFX/BD.bin"
Sound_BE:	binclude "Sound/SFX/BE.bin"
Sound_BF:	binclude "Sound/SFX/BF.bin"
Sound_C0:	binclude "Sound/SFX/C0.bin"
Sound_C1:	binclude "Sound/SFX/C1.bin"
Sound_C2:	binclude "Sound/SFX/C2.bin"
Sound_C3:	binclude "Sound/SFX/C3.bin"
Sound_C4:	binclude "Sound/SFX/C4.bin"
Sound_C5:	binclude "Sound/SFX/C5.bin"
Sound_C6:	binclude "Sound/SFX/C6.bin"
Sound_C7:	binclude "Sound/SFX/C7.bin"
Sound_C8:	binclude "Sound/SFX/C8.bin"
Sound_C9:	binclude "Sound/SFX/C9.bin"
Sound_CA:	binclude "Sound/SFX/CA.bin"
Sound_CB:	binclude "Sound/SFX/CB.bin"
Sound_CC:	binclude "Sound/SFX/CC.bin"
Sound_CD:	binclude "Sound/SFX/CD.bin"
Sound_CE:	binclude "Sound/SFX/CE.bin"
Sound_CF:	binclude "Sound/SFX/CF.bin"
Sound_D0:	binclude "Sound/SFX/D0.bin"
Sound_D1:	binclude "Sound/SFX/D1.bin"
Sound_D2:	binclude "Sound/SFX/D2.bin"
Sound_D3:	binclude "Sound/SFX/D3.bin"
Sound_D4:	binclude "Sound/SFX/D4.bin"
Sound_D5:	binclude "Sound/SFX/D5.bin"
Sound_D6:	binclude "Sound/SFX/D6.bin"
Sound_D7:	binclude "Sound/SFX/D7.bin"
Sound_D8:	binclude "Sound/SFX/D8.bin"
Sound_D9:	binclude "Sound/SFX/D9.bin"
Sound_DA:	binclude "Sound/SFX/DA.bin"
Sound_DB:	binclude "Sound/SFX/DB.bin"
;Snd_GameOver:		include	"Sound/Music/Game Over.asm"
Snd_Invic:		include	"Sound/Music/Invincible.asm"

	if MOMPASS=1
		message "SndBank has $\{Sound_33-SndBank_Align} bytes free in the middle."
	endif
	finishBank

; ---------------------------------------------------------------------------
; Music Bank 1
; ---------------------------------------------------------------------------
MusBnk1:	startBank
Snd_FBZ1:		include	"Sound/Music/FBZ1.asm"
Snd_FBZ2:		include	"Sound/Music/FBZ2.asm"
Snd_MHZ1:		include	"Sound/Music/MHZ1.asm"
Snd_MHZ2:		include	"Sound/Music/MHZ2.asm"
Snd_SOZ1:		include	"Sound/Music/SOZ1.asm"
Snd_SOZ2:		include	"Sound/Music/SOZ2.asm"
Snd_LRZ1:		include	"Sound/Music/LRZ1.asm"
Snd_LRZ2:		include	"Sound/Music/LRZ2.asm"
Snd_SSZ:		include	"Sound/Music/SSZ.asm"
Snd_MiniSSZ:		include	"Sound/Music/SSZ Mini Game.asm"
Snd_CNZ1:		include	"Sound/Music/CNZ1.asm"
Snd_CNZ2:		include	"Sound/Music/CNZ2.asm"
Snd_MiniCNZ:		include	"Sound/Music/CNZ1 Mini Game.asm"
Snd_HCZ1:		include	"Sound/Music/HCZ1.asm"
Snd_HCZ2:		include	"Sound/Music/HCZ2.asm"
	finishBank
; ---------------------------------------------------------------------------
; Music Bank 2
; ---------------------------------------------------------------------------
MusBnk2:	startBank
Snd_Options:		include "Sound/Music/Options.asm"
Snd_MainMenu:		include	"Sound/Music/Main Menu.asm"
Snd_Boss:		include	"Sound/Music/Zone Boss.asm"
Snd_Minib_S3:		include	"Sound/Music/Miniboss S3.asm"
Snd_Minib_SK:		include	"Sound/Music/Miniboss.asm"
Snd_ResultsSonic:	include	"Sound/Music/Results Sonic.asm"
Snd_ResultsTie:		include	"Sound/Music/Results Tie.asm"
Snd_ResultsTails:	include	"Sound/Music/Results Tails.asm"
Snd_Drown:		include	"Sound/Music/Countdown.asm"
Snd_DataSelect:		include	"Sound/Music/Menu.asm"
Snd_SpecialSelect:	include "Sound/Music/Special Stage Select.asm"
Snd_Null:
Snd_Continue:		include	"Sound/Music/Continue.asm"
Snd_FinalBoss:		include	"Sound/Music/Final Boss.asm"
Snd_Knux:		include	"Sound/Music/Knuckles.asm"
Snd_KnuxS3:		include	"Sound/Music/Knuckles S3.asm"
Snd_InvicS3:		include	"Sound/Music/Invincibility S3.asm"
Snd_Credits:		include	"Sound/Music/Credits Egor.asm"
Snd_OAZ1:		include	"Sound/Music/OAZ1.asm"
Snd_TitleScreen:	include	"Sound/Music/Title Screen.asm"
Snd_SpecialStage:	include	"Sound/Music/Special Stage.asm"
Snd_MiniLBZ:		include "Sound/Music/LBZ1 Mini Game.asm"
;Snd_Competiton:	include	"Sound/Music/Competition Menu.asm"
;Snd_DDZ:		include	"Sound/Music/DDZ.asm"
;Snd_SKCredits:		include "Sound/Music/Credits.asm"
;Snd_S3Credits:		include	"Sound/Music/Sonic 3 Credits.asm"
;Snd_GumBonus:		include	"Sound/Music/Gum Ball Machine.asm"
;Snd_1UP:		include	"Sound/Music/1UP.asm"
;Snd_1UPS3:		include	"Sound/Music/1UP S3.asm"
;Snd_PresSega:		include	"Sound/Music/Game Complete.asm"
;Snd_Emerald:		include	"Sound/Music/Chaos Emerald.asm"
;Snd_PachBonus:		include	"Sound/Music/Pachinko.asm"
;Snd_SlotBonus:		include	"Sound/Music/Slots.asm"
;Snd_Title:		include	"Sound/Music/Title.asm"
	finishBank
