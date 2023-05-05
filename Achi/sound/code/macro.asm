	opt ae+
	rsset 0
cFlags		rs.b 1		; misc flags for this channel
cType		rs.b 1		; type of this channel
cData		rs.l 1		; data offset
cPanning	rs.b 0		; pan + LFO
cEnvPos		rs.b 1		; envelope offset
cDetune		rs.b 1		; detune (adjust frquency slightly)
cPitch		rs.b 1		; current note offset
cVolume		rs.b 1		; channel volume
cTick		rs.b 1		; tick multiplier
cSample		rs.b 0		; sample ID
cPatch		rs.b 1		; voice ID
cDuration	rs.b 1		; note duration
cLastDur	rs.b 1		; last note duration
cFreq		rs.w 1		; last frequency (PSG/FM)
cModDelay	rs.b 0		; delay before modulation starts
cMod		rs.l 1		; modulation offset
cModFreq	rs.w 1		; frequency of modulation
cModSpeed	rs.b 1		; modulation speed
cModStep	rs.b 1		; number to add/remove per step
cModCount	rs.b 1		; number of steps
cLoop		rs.b 3		; list of loop counters active (note that SFX has 2, while BGM has 4)
cStatPSG4 =	__rs-1		; PSG4 status (PSG3 only!)
cSizeSFX	rs.w 0		; size of each SFX track

cNoteTimeCur	rs.b 1		; frames til note is released
cNoteTimeMain	rs.b 1		; frames til note is released
cStack		rs.b 1		; stack offset of the channel
		rs.b 1		; unused
		rs.l 3		; channel stack
cSize		rs.w 0		; size of each FM/PSG track

; ===========================================================================
; bits for cFlags
	rsset 0
cfbMode		rs.b 0		; set if DAC mode is pitch-based, clear if ID-based
cfbRest		rs.b 1		; set if channel is resting
cfbInt		rs.b 1		; set if interrupted by SFX (music only)
cfbPit		rs.b 1		; set if doing a pitch slide
cfbMod		rs.b 1		; set if modulation is on
cfbCond		rs.b 1		; clear if condition is true (run commands normally)
cfbVol		rs.b 1		; set if outside source has requested volume update for FM or PSG
cfbRun =	$07		; set if channel is active (running)

cfbHold	=	31		; set if note on's are disabled (by sHold)

; ===========================================================================
; bits for cType
ctFM14 =	$00		; FM 1 or 4
ctFM25 =	$01		; FM 2 or 5
ctFM36 =	$02		; FM 3 or 6
ctbPt2 =	$02		; bit part 2 - FM 4-6
ctPt1 =		$00		; part 1 - FM 1-3
ctPt2 =		1<<ctbPt2	; part 2 - FM 4-6

ctFM3 =		ctFM36		; FM3
ctFM4 =		ctFM14|ctPt2	; FM4
ctFM5 =		ctFM25|ctPt2	; FM5

ctbDAC =	$03		; DAC bit
ctDAC1 =	(1<<ctbDAC)|$03	; DAC 1
ctDAC2 =	(1<<ctbDAC)|$03|ctPt2; DAC 2

ctPSG =		$80		; always set when this is PSG channel
ctFreq =	$00		; PSG Frequency/Pitch mode
ctPSG1 =	$00|ctPSG	; PSG 1
ctPSG2 =	$20|ctPSG	; PSG 2
ctPSG3 =	$40|ctPSG	; PSG 3
ctPSG4 =	$60|ctPSG	; PSG 4

; ===========================================================================
; various flags
Mus_DAC =	2		; number of DAC channels
Mus_FM =	5		; number of FM channels
Mus_PSG =	3		; number of PSG channels
Mus_Ch =	Mus_DAC+Mus_FM+Mus_PSG; total number of channels
SFX_FM =	3		; number of FM channels for SFX
SFX_PSG =	3		; number of PSG channels for SFX
SFX_Ch =	SFX_FM+SFX_PSG	; total number of channels for SFX

PatchRegs =	29
PatchSize =	$20		; size of each FM patch
PatchTL =	PatchRegs-4	; location of patch TL levels

; ===========================================================================
; sound driver RAM
	rsset 0
mFlags		rs.b 1		; ring speaker, speedshoes, paused
mPrio		rs.b 1		; sound priority
mPatMus		rs.l 1		; address of patch bank for music
mCueYM		rs.l 1		; address to write YM commands to
mComm		rs.b 8		; communications bytes for the SMPS engine to use
mMasterVolFM	rs.b 0		; FM master volume
mFadeAddr	rs.l 1		; address of the fade code
mTempoMain	rs.b 1		; main tempo
mTempoSpeed	rs.b 1		; speed shoes tempo
mTempo		rs.b 1		; current tempo
mTempoTime	rs.b 1		; tempo timeout
mQueue		rs.b 3		; music/sfx queue
mMasterVolPSG	rs.b 0		; PSG master volume
mSpindash	rs.b 1		; spindash rev counter
mMasterVolDAC	rs.b 0		; DAC master volume
mContCtr	rs.b 1		; continous sfx counter
mContLast	rs.b 1		; last continous sfx
		rs.w 0		; needs to be aligned
mDAC1		rs.b cSize	; DAC 1
mDAC2		rs.b cSize	; DAC 2
mFM1		rs.b cSize	; FM 1
mFM2		rs.b cSize	; FM 2
mFM3		rs.b cSize	; FM 3
mFM4		rs.b cSize	; FM 4
mFM5		rs.b cSize	; FM 5
mPSG1		rs.b cSize	; PSG 1
mPSG2		rs.b cSize	; PSG 2
mPSG3		rs.b cSize	; PSG 3
mSFXDAC		rs.b cSizeSFX	; SFX DAC 1
mSFXFM3		rs.b cSizeSFX	; SFX FM 3
mSFXFM4		rs.b cSizeSFX	; SFX FM 4
mSFXFM5		rs.b cSizeSFX	; SFX FM 5
mSFXPSG1	rs.b cSizeSFX	; SFX PSG 1
mSFXPSG2	rs.b cSizeSFX	; SFX PSG 2
mSFXPSG3	rs.b cSizeSFX	; SFX PSG 3
mSize		rs.w 0		; size of the driver RAM

; ===========================================================================
; bits for mFlags
	rsset 0
mfbRing		rs.b 1		; ring speaker
mfbSpeed	rs.b 1		; speed shoes
mfbWater	rs.b 1		; underwater flag
mfbPAL		rs.b 1		; whether we are using PAL tempo
mfbReqPause	rs.b 1		; set if driver is requested to be paused
mfbReqUnpause	rs.b 1		; set if driver is requested to be unpaused
mfbPaused =	$07		; paused flag

; ===========================================================================
; condition ID's
	rsset 0
dcoT		rs.b 1		; condition true
dcoF		rs.b 1		; condition false
dcoHI		rs.b 1		; condition HI
dcoLS		rs.b 1		; condition LS
dcoHS		rs.b 0		; condition HS
dcoCC		rs.b 1		; condition CC
dcoLO		rs.b 0		; condition LO
dcoCS		rs.b 1		; condition CS
dcoNE		rs.b 1		; condition NE
dcoEQ		rs.b 1		; condition EQ
dcoVC		rs.b 1		; condition VC
dcoVS		rs.b 1		; condition VS
dcoPL		rs.b 1		; condition PL
dcoMI		rs.b 1		; condition MI
dcoGE		rs.b 1		; condition GE
dcoLT		rs.b 1		; condition LT
dcoGT		rs.b 1		; condition GT
dcoLE		rs.b 1		; condition LE

; ===========================================================================
; Emvelope commands (based on S3K)
	rsset $80
eReset		rs.w 1		; 80 - loop back to beginning
eHold		rs.w 1		; 81 - Hold the envelope at current level
eLoop		rs.w 1		; 82 - Loop by the next byte
eStop		rs.w 1		; 83 - Stop current note and envelope

; ===========================================================================
; quickly read a word from odd address. 28 cycles
dREAD_WORD	macro areg, dreg
	move.b	(\areg)+,(sp)
	move.w	(sp),\dreg
	move.b	(\areg),\dreg
    endm

; ===========================================================================
; used to calculate the address of the right patch
dCALC_PATCH	macro off
	lsl.w	#5,d0		; Id * $20
	if narg>0
		add.w	#\off,d0
	endif

	add.w	d0,a1		; and then add it to patch ID
    endm

; ===========================================================================
; some of the wait for YM cue ptr...
dWaitForCueYM	macro
	StartZ80				; start Z80 again
	rept $10/2
		or.l	d0,d0			; wait a little
	endr
    endm

; ===========================================================================
; tells the Z80 to stop, and waits for it to finish stopping (acquire bus)
stopZ80 	macro
		move.w	#$100,Z80_bus_request	; stop the Z80
.loop\@		btst	#0,Z80_bus_request
		bne.s	.loop\@			; loop until it says it's stopped
    endm

; ===========================================================================
; tells the Z80 to start again
startZ80 	macro
		move.w	#0,Z80_bus_request	; start the Z80
    endm

; ===========================================================================
; waits for YM
waitYM        macro reg
.wait\@		move.b	(\reg),d2
		btst	#7,d2
		bne.s	.wait\@
        endm

; ===========================================================================
; Do this when enabling DMA!
Z80DMA_ON	macro
	StopZ80
	WaitZ80
	move.b	#%11000010,$A00000+PCM_FlushSwitch; change "jp  z" to "jp  nz"
	StartZ80
    endm

; ===========================================================================
; Do this when disabling DMA!
Z80DMA_OFF	macro
	StopZ80
	WaitZ80
	move.b	#%11001010,$A00000+PCM_FlushSwitch; change "jp  nz" to "jp  z"
	StartZ80
    endm

; ===========================================================================
; macro for pausing music
SMPS_MUSPAUSE	macro
	jsr	dDoPauseIn
    endm

; ===========================================================================
; macro for unpausing music
SMPS_MUSUNPAUSE	macro
	jsr	dDoPauseOut
    endm

adby	macro long, byte
	dc.l (\byte<<24)|\long
    endm

; ===========================================================================
; used to align with a certain byte
alignby		macro	size,value
	dcb.b \size-(*%\size),\value
    endm

; ===========================================================================
; ptr to SFX. Also resolves SFX name to ID
ptrSFX		macro
__sfx =		$A0
	rept sfx__Last-sfx__First
		dc.l dsfx_\$__sfx
__sfx =		__sfx+1
	endr
    endm

; ===========================================================================
; ptr to music. Also resolves music name to ID
ptrMusic	macro file, sptempo
	rept narg/2
		dc.l ((\sptempo)<<24)|dmus_\file
	shift
	shift
	endr
    endm

; ===========================================================================
; include a SFX file
incSFX		macro
__sfx =		$A0
	rept sfx__Last-sfx__First
	even
dsfx_\$__sfx 	include "sound/SFX/sound\$__sfx\.asm"
__sfx =		__sfx+1
	endr
    endm

; ===========================================================================
; include a Music file
incMus		macro file
	rept narg
	even
dmus_\file 	include "sound/music/\file\.asm"
	shift
	endr
    endm

; ===========================================================================
; include a PCM file
incSWF		macro file
	rept narg
SWF_\file	incbin	"sound/DAC/\file\.swf"
SWFR_\file 	dcb.b	$0018*(($0C00+$100)/$100),$00
	shift
	endr
    endm

; ===========================================================================
; create a pointer to a sample
zdata		macro freq, file, loop
d\file =	__samp
__samp =	__samp+1
	dc.b (SWF_\file&$FF), (((SWF_\file>>$08)&$7F)|$80), ((SWF_\file&$7F8000)>>$0F)
	dc.b ((SWFR_Stop-1)&$FF), ((((SWFR_Stop-1)>>$08)&$7F)|$80), (((SWFR_Stop-1)&$7F8000)>>$0F)
	dc.b (SWF_Stop&$FF), (((SWF_Stop>>$08)&$7F)|$80), ((SWF_Stop&$7F8000)>>$0F)
	dc.b ((SWFR_Stop-1)&$FF), ((((SWFR_Stop-1)>>$08)&$7F)|$80), (((SWFR_Stop-1)&$7F8000)>>$0F)
	dc.w \freq
	dc.w 0
    endm
; ===========================================================================
	opt ae-
