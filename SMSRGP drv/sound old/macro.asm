; ===========================================================================
; ---------------------------------------------------------------------------
; Some code to generate banks
; ---------------------------------------------------------------------------

__bank :=	8000h

bank		macro
		org	__bank
		phase	8000h
__bank :=	__bank+4000h
	endm

; ===========================================================================
; ---------------------------------------------------------------------------
; Various driver memory structures
; ---------------------------------------------------------------------------

	phase 0
cFlag		ds 1	; ch flags
cVolume		ds 1	; ch volume
cPitch		ds 1	; ch pitch value
cDetune		ds 1	; ch frequency detune
cDuration	ds 1	; ch current duration
cDurStore	ds 1	; ch stored duration
cTrack		ds 2	; ch tracker
cLoopPtr	ds 1	; ch loop stack pos
cLoopStack	ds 2	; ch loop stack (check if enough)
cStackPtr	ds 1	; ch stack pos
cStack		ds 4*2	; ch stack
cIns1		ds 1	; ch inst off 1
cIns2		ds 1	; ch inst off 2
cInsC1		ds 1	; ch inst off 1 copy
cInsC2		ds 1	; ch inst off 2 copy
cNoise =	$	; PSG4 mode
cSize4 =	$+1	; PSG4 size
cFreq		ds 2	; ch freq
cModFreq	ds 2	; ch mod freq
cModPtr		ds 2	; ch mod ptr
cModSpeed	ds 1	; ch mod speed
cModSteps	ds 1	; ch mod steps
cSize =		$	; PSG1-3 size

	phase 0
cfRest		ds 1	; REST
cfSoft		ds 1	; SOFT KEY
cfFreq =	$	; PSG4: USE PSG3 FREQ
cfMod		ds 1	; MOD DIR
cfInt		ds 1	; INTERRUPTED
		ds 1	; 1
		ds 2	; TYPE
cfRun		ds 1	; RUNNING

	phase 0FE00h
dFlag		ds 1	; drv flags. Also fade timer
dVol		ds 1	; master vol
dFade		ds 1	; fading timer
dQueue		ds 3	; music queue
dBank		ds 1	; music bank num
dIns1		ds 2	; instrument pointer 1
dIns2		ds 2	; instrument pointer 2
dTempo		ds 1	; bgm tempo
dTempoAcc	ds 1	; tempo accumulator
dPSG1		ds cSize; PSG1
dPSG2		ds cSize; PSG2
dPSG3		ds cSize; PSG3
dPSG4		ds cSize4; PSG4
dSFXPSG1	ds cSize; SFX PSG1
dSFXPSG2	ds cSize; SFX PSG2
dSFXPSG3	ds cSize; SFX PSG3
dSFXPSG4	ds cSize4; SFX PSG4
dIntTempo	ds 1	; int tempo
dIntTempoAcc	ds 1	; int tempo accumulator
dIntPSG1	ds cSize; Int PSG1
dIntPSG2	ds cSize; Int PSG2
dIntPSG3	ds cSize; Int PSG3
dIntPSG4	ds cSize4; Int PSG4

dCurIns1	ds 2	; current driver instrument (temp)
dCurIns2	ds 2	; current driver instrument (temp)
dSize =		$	; end addr of driver

	phase 2
dfIntRet	ds 1	; INT RETURN
dfInt		ds 1	; INT WAIT
dfFde		ds 1	; FADE ACTIVE
dfFadeT		ds 1	; FADE TYPE
dfPauseA	ds 1	; PAUSE ACTIVATING
dfPause		ds 1	; PAUSE

; ===========================================================================
; ---------------------------------------------------------------------------
; Various driver variables and equates
; ---------------------------------------------------------------------------

ctPSG1 =	080h|10h	; PSG1 type value
ctPSG2 =	0A0h|10h	; PSG2 type value
ctPSG3 =	0C0h|10h	; PSG3 type value
ctPSG4 =	0E0h|10h	; PSG4 type value
PSG =		7Fh		; PSG port num

; ===========================================================================
; ---------------------------------------------------------------------------
; Various driver macros
; ---------------------------------------------------------------------------

QuickCh		macro orig, next
	if (orig&0FF00h)==(next&0FF00h)
	;	ld	iyl, next&0FFh
		db 0FDh,2Eh,next&0FFh
	else
		ld	iy, next
	endif
	endm

dPause		macro
	ld	a,(dFlag)		; load FLAGS
	or	(1<<dfPause)|(1<<dfPauseA); add pause flags
	ld	(dFlag),a		; save FLAGS
	endm

dUnpause	macro
	ld	a,(dFlag)		; load FLAGS
	and	100h-(1<<dfPause)	; remove pause flags
	ld	(dFlag),a		; save FLAGS
	endm

; ===========================================================================
; ---------------------------------------------------------------------------
; Instrument table equates
; ---------------------------------------------------------------------------

	phase 80h
iHold		ds 2	; Hold volume. Offset not changing. Next byte is volume
iStop		ds 2	; Stop note. (Force volume to F). Offset is not changing
iReset		ds 2	; Reset offset position.
iJump		ds 2	; Relative jump. Next byte defines position.

; ===========================================================================
; ---------------------------------------------------------------------------
; Music ID's
; ---------------------------------------------------------------------------

	phase 1
Mus_Stop		ds 1	; stop all music
Mus_FadeOut		ds 1	; fade out music
Mus_Interrupt		ds 1	; interrupt music (starts fade out)
Mus_Restart		ds 1	; restart interrupted music. Starts fade out
; dynamic list starts here
MusFirst =		$	; first music
Mus_Test		ds 1	; test music

	dephase

; ===========================================================================
; ---------------------------------------------------------------------------
; Tracker macros
; ---------------------------------------------------------------------------

	enum Soft=0F0h,nRst=0,Cmf=0E0h,		nGs0=080h,nA0,nAs0,nB0
	enum nC1=084h,nCs1,nD1,nDs1,nE1,nF1,nFs1,nG1,nGs1,nA1,nAs1,nB1
	enum nC2=090h,nCs2,nD2,nDs2,nE2,nF2,nFs2,nG2,nGs2,nA2,nAs2,nB2
	enum nC3=09Ch,nCs3,nD3,nDs3,nE3,nF3,nFs3,nG3,nGs3,nA3,nAs3,nB3
	enum nC4=0A8h,nCs4,nD4,nDs4,nE4,nF4,nFs4,nG4,nGs4,nA4,nAs4,nB4
	enum nC5=0B4h,nCs5,nD5,nDs5,nE5,nF5,nFs5,nG5,nGs5,nA5,nAs5,nB5
	enum nC6=0C0h,nCs6,nD6,nDs6,nE6,nF6,nFs6,nG6,nGs6,nA6,nAs6,nB6
	enum nC7=0CCh,nCs7,nD7,nDs7,nE7,nF7,nFs7,nG7,nGs7,nA7,nAs7,nB7
	enum nC8=0D8h,nCs8		; nCs8 is 0h

	enum ns0=0A0h,ns1,ns2,ns3,ns4,ns5,ns6,ns7


Calls	macro addr
	db 0FFh
	dw addr
	endm

Jump	macro addr
	db 0FEh
	dw addr
	endm

Loope	macro
	db 0FDh
	endm

Loops	macro count
	db 0FCh, count
	endm

Return	macro
	db 0FBh
	endm

PitSet	macro val
	db 0FAh, val
	endm

PitAdd	macro val
	db 0F9h, val
	endm

DetSet	macro val
	db 0F8h, val
	endm

DetAdd	macro val
	db 0F7h, val
	endm

VolSet	macro val
	db 0E0h|val
	endm

VolAdd	macro val
	db 0F6h, val
	endm

Ins1	macro val
	db 0F5h, val
	endm

Ins2	macro val
	db 0F4h, val
	endm

Tempo	macro val
	db 0F3h, val
	endm

ModSet	macro speed, offset, step
	db 0F2h, speed, offset, step
	endm

ModOff	macro
	db 0F1h
	endm

HeadBGM	macro tempo, bank
	db bank|80h, tempo
	endm

HeadCh	macro addr
	dw addr
	endm

HeadIns	macro addr1, addr2
	dw addr1, addr2
	endm

HeadSFX	macro chans
	db chans
	endm

HeadChs	macro addr, type
	db type
	dw addr
	endm

	org 0
