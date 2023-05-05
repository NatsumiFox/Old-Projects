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
cIns1		ds 2	; ch inst ptr 1
cInsC1		ds 2	; ch inst ptr 1 copy
cIns2		ds 2	; ch inst ptr 2
cInsC2		ds 2	; ch inst ptr 2 copy
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

ctOff =		cSize-20h
	if ctOff>4
		warn "SFX channel size too large! it is {cSize}"
	endif

csPSG1 =	080h|10h	; PSG1 sfx value
csPSG2 =	0A0h|10h+ctOff	; PSG2 sfx value
csPSG3 =	0C0h|10h+(ctOff*2); PSG3 sfx value
csPSG4 =	0E0h|10h+(ctOff*3); PSG4 sfx value

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
	db 0F5h
	dw val
	endm

Ins2	macro val
	db 0F4h
	dw val
	endm

Tempo	macro val
	db 0F3h, val
	endm

ModSet	macro speed, offset, first, step
	db 0F2h, speed, offset, step, first
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

HeadSFX	macro chans
	db chans
	endm

HeadChs	macro addr, type
	db type
	dw addr
	endm

	org 0
; ===========================================================================
; ---------------------------------------------------------------------------
; Set channel as muted (38 or 67 cycles)
;
; in:
;   iy - Channel data
; ---------------------------------------------------------------------------

MuteCh		macro
		ld	a,(iy+cFlag)	; 19	; read flags
		bit	cfInt,a		; 8	; check if interrupted
		jp	nz, .nomute	; 10	; if so, return

		and	0F0h		; 7	; get type and volume bit
		or	1Fh		; 7	; or volume level
		out	(PSG),a		; 11	; put to PSG
.nomute
	endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Read tracker code
;
; in:
;   iy - Channel data
; ---------------------------------------------------------------------------

ReadTracker	macro
		ld	d,(iy+cTrack+1)	; 19	; read high byte	; setup: 38 cycles
		ld	e,(iy+cTrack)	; 19	; read low byte

.read		ld	a,(de)		; 7	; read next data	; read: 30 cycles
		inc	de		; 6	; skip this byte
		cp	Cmf-1		; 7	; check if this is a note or delay
		jp	c, .trend	; 10	; if so, return

		ld	hl,.read	; 10	; get tracker addr to hl ; command: 64
		push	hl		; 11	; return here!

		ld	h,TrackCmds>>8	; 7	; get command high byte to h
		add	a,a		; 4	; double (and get rid of msb)
		ld	l,a		; 4	; copy index to c

		ld	c,(hl)		; 7	; load low byte
		inc	l		; 6	; goto high
		ld	h,(hl)		; 7	; load high byte
		ld	l,c		; 4	; copy low byte again
		jp	(hl)		; 4	; jump to command handler
.trend
	endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Update channel frequency (37 or 117 cycles)
;
; in:
;   hl - Channel frequency
;   iy - Channel data
; ---------------------------------------------------------------------------

UpdateFreq	macro	alt
	if "alt"<>""
		ld	a,(ix+cFlag)	; 19	; read flags
	else
		ld	a,(iy+cFlag)	; 19	; read flags
	endif
		bit	cfInt,a		; 8	; check if interrupted
		jp	nz, .nofrequpd	; 10	; if is, return

		and	0E0h		; 7	; get channel bits
		ld	c,a		; 4	; copy to c

		ld	a,l		; 4	; copy low byte
		and	0Fh		; 7	; get only low bits
		or	c		; 4	; add channel to a
		out	(PSG),a		; 11	; and put in PSG

		ld	a,l		; 4	; get low bits again
		and	0F0h		; 7	; get upper nibble
		or	h		; 4	; or high byte

		rrca			; 4	; swap nibbles
		rrca			; 4
		rrca			; 4
		rrca			; 4
;		and	03Fh		; 7	; clear extra bits
		out	(PSG),a		; 11	; and put in PSG
.nofrequpd
	endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Reset channel modulation (181 or 158 cycles)
;
; in:
;   a - modulation pointer high byte
;   iy - Channel data
; ---------------------------------------------------------------------------

ResetMod	macro
		ld	d,a		; 4	; copy to d
		ld	e,(iy+cModPtr)	; 19	; get low byte
		ResetMod2
	endm

ResetMod2	macro
		ld	a,(de)		; 7	; copy speed
		ld	(iy+cModSpeed),a; 19	;
		inc	de		; 6	;
		inc	de		; 6	;
		inc	de		; 6	; skip bytes

		ld	a,(de)		; 7	; copy step count
		ld	(iy+cModSteps),a; 19	;

		xor	a		; 4	; prepare 0
		ld	(iy+cModFreq+1),a; 19	; clear mod freq
		ld	(iy+cModFreq),a	; 19	;

		res	cfMod,(iy+cFlag); 23	; reset mod direction to forwards
	endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Process instrument of a channel
;
; in:
;   bc - Instrument table
;   hl - Pointer to instrument info
;   iy - Channel pointer
;
; out:
;    b - Volume offset
; ---------------------------------------------------------------------------

DoInstrument	macro
		ld	b,(hl)		; 7	; load instrument from RAM
		inc	l		; 4	; setup: 18 cycles
		ld	c,(hl)		; 7	;

.insloop	ld	a,(bc)		; 7	; load data from table	; check: 33 or 50 cycles
		or	a		; 4	; check its value
		jp	p,.volume	; 10	; if positive, it is volume

		cp	iLast		; 7	; check if this is a command
		jp	nc, .volume	; 10	; branch if not

		ld	de,.insloop	; 10	; get loop addr to de	; call routine: 64 cycles
		push	de		; 11	; push addr to stack

		ld	e,a		; 4	; save offset
		ld	d,InstPtrs>>8	; 7	; load table addr
		ex	de,hl		; 4	; swap hl and de

		ld	a,(hl)		; 7	; load low byte
		inc	l		; 6	; goto high
		ld	h,(hl)		; 7	; load high byte
		ld	l,a		; 4	; copy low byte again
		jp	(hl)		; 4	; jump to handler

.volume		inc	bc		; 4	; skip byte	; set vol: 30 cycles
		dec	l		; 4
		ld	(hl),b		; 7	; save address back
		inc	l		; 4	;
		ld	(hl),c		; 7	;
		ld	d,a		; 4	; copy volume to d
	endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Update channel volume (base routine: 151 cycles!!!)
;
; in:
;   iy - Channel data
;
; out:
;    d - Output volume
; ---------------------------------------------------------------------------

UpdateVolume	macro
		ld	a,(dVol)	; 13	; get master volume to a
		add	a,(iy+cVolume)	; 19	; add volume to a

		ld	hl,cIns1	; 10	; get ins 1 to hl
		push	iy		; 15	; put iy to stack
		pop	bc		; 10	; get as bc
		add	hl,bc		; 11	; get correct pointer to hl

		ex	af,af'		; 4	; swap a with a'
		DoInstrument			; do instrument
		ex	af,af'		; 4	; swap a with a'
		add	a,d		; 4	; add d to a

		inc	l		; 4	; go to next byte
		inc	l		; 4	;
		inc	l		; 4	;

		ex	af,af'		; 4	; swap a with a'
		DoInstrument			; do instrument
		ex	af,af'		; 4	; swap a with a'
		add	a,d		; 4	; add d to a

		ld	l,a		; 4	; copy volume to l
		ld	h,VolTable>>8	; 7	; set h to vol tbl
		ld	d,(hl)		; 7	; load volume to d
		ld	a,(iy+cFlag)	; 19	; read flags
	endm
