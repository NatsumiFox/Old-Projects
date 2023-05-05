; ===========================================================================
; ---------------------------------------------------------------------------
; PSG pitch table
; ---------------------------------------------------------------------------
	align 100h		; MUST BE ALIGNED
PitchTable:
;	dw  C    C#   D    D#   E    F    F#   G    G#   A    A#   B
	dw 					   3FFh,3F7h,3BEh,388h
	dw 356h,326h,2F9h,2CEh,2A5h,280h,25Ch,23Ah,21Ah,1FBh,1DFh,1C4h
	dw 1ABh,193h,17Dh,167h,153h,140h,12Eh,11Dh,10Dh,0FEh,0EFh,0E2h
	dw 0D6h,0C9h,0BEh,0B4h,0A9h,0A0h,097h,08Fh,087h,07Fh,078h,071h
	dw 06Bh,065h,05Fh,05Ah,055h,050h,04Bh,047h,043h,040h,03Ch,039h
	dw 036h,033h,030h,02Dh,02Bh,028h,026h,024h,022h,020h,01Fh,01Dh
	dw 01Bh,01Ah,018h,017h,016h,015h,013h,012h,011h,010h,00Fh,00Eh
	dw 00Dh,00Ch,00Bh,00Ah,009h,008h,007h,006h,005h,004h,003h,002h
	dw 001h,000h

; ===========================================================================
; ---------------------------------------------------------------------------
; Sound Driver main code
; ---------------------------------------------------------------------------

SoundDriver:
	; check pause state
		ld	a,(dFlag)		; load flags
		or	a			; check for pause
		jp	p, .nopause		; if no, branch

		bit	dfPauseA,a		; check if we are just pausing
		ret	z			; if not, return
		res	dfPauseA,a		; clear just pausing flag
		ld	(dFlag),a		; save flags back
		jp	MutePSG			; stop channels

	; check queue
.nopause	ld	hl,dQueue		; get queue addr to hl
		ld	a,(hl)			; get value
		or	a			; check if 0
		jp	nz, .sound		; branch if not

		inc	hl			; go to next byte
		ld	a,(hl)			; get value
		or	a			; check if 0
		jp	nz, .sound		; branch if not

		inc	hl			; go to next byte
		ld	a,(hl)			; get value
		or	a			; check if 0
		jp	z, .nosound		; branch if so

.sound		ld	(hl),0			; clear slot
		call	PlaySound		; play a sound

.nosound; do volume fade
		ld	a,(dFlag)		; load flags
		bit	dfFde,a			; check if fading
		jp	z, .nofade		; if not, branch

		ld	hl,dFade		; get fade timer to hl
		dec	(hl)			; decrease timer
		jp	nz, .nofade		; if nonzero, branch

		dec	hl			; align to dVol
		bit	dfFadeT,a		; check fade direction
		jp	z, .fadeout		; branch if fading out

		ld	a,(hl)			; load volume
		or	a			; check value
		jr	z, .maxvol		; if 0, branch
		dec	(hl)			; decrement volume
		jp	.fadetime		; set timer

.maxvol		ld	hl,dFlag		; get flags to hl
		res	dfFde,(hl)		; reset fade flag
		jp	.nofade

.fadeout	ld	a,(hl)			; load volume
		cp	0Fh			; check if it is max
		jp	nz, .addvol		; if no, branch

		ld	hl,dFlag		; get flags to hl
		res	dfFde,(hl)		; reset fade flag
		bit	dfInt,(hl)		; check interrupt status
		jp	z, .stop		; if none, jump

	; handle interrupts
		bit	dfIntRet,(hl)		; check if we need to return music
		jp	z, .noret		; if not, branch

		ld	de,dTempo		; get Tempo as destination
		ld	hl,dIntTempo		; get Tempo Int as source
		call	LoadInt			; call ldi loop

		ld	hl,dFlag		; get flags to hl
		set	dfFde,(hl)		; enable fade flag
		set	dfFadeT,(hl)		; fade in immediately

		ld	a,1			; prepare 1
		ld	(dFade),a		; fade next frame
		jp	.nofade

.noret		ld	hl,dTempo		; get Tempo as source
		ld	de,dIntTempo		; get Tempo Int as destination
		call	LoadInt			; call ldi loop

.stop		call	Cmd_Stop2		; stop music
		jp	.nofade

.addvol		inc	(hl)			; increment volume
.fadetime	ld	a,(hl)			; get volume again
		add	a,a			; double a
		inc	hl			; align to dFade
		ld	(hl),a			; save timer

.nofade		ld	iy,dSFXPSG1		; load PSG1 to iy
		ld	a,(iy+(dTempo-dSFXPSG1)); load tempo
		add	a,(iy+(dTempoAcc-dSFXPSG1)); add accumulator
		ld	(iy+(dTempoAcc-dSFXPSG1)),a; save accumulator
		jp	nc, .chs		; if no overflow, branch

		inc	(iy+cDuration-cSize4)		; increment delay
		inc	(iy+cDuration-cSize4-cSize)	;
		inc	(iy+cDuration-cSize4-(cSize*2))	;
		inc	(iy+cDuration-cSize4-(cSize*3))	;

	; process music
.ch		macro type
		ld	a,(iy+cFlag)		; load flags
		or	a			; chk flag
		jp	p, .norun		; if not active, branch

	if type==4
		call	ProcChannel4		; process PSG4 channel
	else
		call	ProcChannel		; process normal channel
	endif

.norun
	endm

.chs		ld	a,(dBank)		; load bank
		ld	(0FFFFh),a		; set bank

		ld	hl,Inst1SFX		; load SFX instruments
		ld	(dCurIns1),hl
		ld	hl,Inst2SFX
		ld	(dCurIns2),hl

	.ch 1					; process it
	QuickCh	dSFXPSG1, dSFXPSG2		; goto SFX PSG2
	.ch 2					; process it
	QuickCh	dSFXPSG2, dSFXPSG3		; goto SFX PSG3
	.ch 3					; process it
	QuickCh	dSFXPSG3, dSFXPSG4		; goto SFX PSG4
	.ch 4					; process it

		ld	hl,(dIns1)		; load instruments
		ld	(dCurIns1),hl
		ld	hl,(dIns2)
		ld	(dCurIns2),hl

	QuickCh	dSFXPSG4, dPSG1			; goto PSG1
	.ch 1					; process it
	QuickCh	dPSG1, dPSG2			; goto PSG2
	.ch 2					; process it
	QuickCh	dPSG2, dPSG3			; goto PSG3
	.ch 3					; process it
	QuickCh	dPSG3, dPSG4			; goto PSG4
	.ch 4					; process it
		ret

; ===========================================================================
; ---------------------------------------------------------------------------
; Play music or sfx
;
; in:
;    a - Sound ID
; ---------------------------------------------------------------------------

PlaySound:
		ld	b,0			; clear c
		cp	MusFirst		; check if this is music
		jp	nc, .music		; if no carry, do music

		add	a,a			; double offset
		ld	hl,CommandPtrs-2	; get command pointer
		ld	c,a			; copy a to b
		add	hl,bc			; get real offset

		ld	a,(hl)			; load low byte
		inc	hl			; goto high
		ld	h,(hl)			; load high byte

		ld	l,a			; copy low byte again
		jp	(hl)			; jump to handler

.music		ld	hl,MusicPtrs-(MusFirst*2); get music pointer
		ld	c,a			; copy a to b
		add	hl,bc			; get real offset
		add	hl,bc			;

		ld	a,(hl)			; load low byte
		inc	hl			; goto high
		ld	h,(hl)			; load high byte
		ld	l,a			; copy low byte again

		ld	a,(hl)			; load first byte
		inc	hl			; skip first byte
		or	a			; check value
		jp	p, .sfx			; do SFX

		and	7Fh			; keep in range
		ld	(dBank),a		; set bank!

		ld	a,(hl)			; load next byte
		inc	hl			;
		ld	(dTempo),a		; copy tempo
		xor	a			; clear accumulator
		ld	(dTempoAcc),a		;

		ld	iy,dPSG1-cSize		; get channel to hl
		ld	ix,.initd		; get channel ínit data to de
		ld	de,cSize		; get size to hl
		ld	b,4			; 4 channels

.loop		ld	a,(ix)			; load first data
		inc	ix			; go to next byte
		add	iy,de			; go to next channel

		ld	(iy+cFlag),a		; load init byte
		ld	a,(hl)			; load addr byte
		ld	(iy+cTrack),a		; save
		inc	hl			; skip byte
		ld	a,(hl)			; load addr byte
		ld	(iy+cTrack+1),a		; save
		inc	hl			; skip byte

		ld	(iy+cDuration),1	; reset duration to 1
		ld	(iy+cLoopPtr),cLoopStack-1; reset loop stack
		ld	(iy+cStackPtr),cStack	; reset stack

		xor	a			; prepae 0
		ld	(iy+cVolume),a		; reset volume
		ld	(iy+cPitch),a		; reset pitch
		ld	(iy+cDetune),a		; reset detune
		ld	(iy+cIns1),a		; reset instructions
		ld	(iy+cInsC1),a		;
		ld	(iy+cIns2),a		;
		ld	(iy+cInsC2),a		;
		call	MuteCh			; mute channel too
		djnz	.loop			; loop

		ld	de,dIns1		; get instrument 1 data
		ldi				; copy the instrument tables
		ldi
		ldi
		ldi
		ret

.initd	db ctPSG1, ctPSG2, ctPSG3, ctPSG4

.sfx		ld	b,a			; copy loop count
.loops		ld	a,(hl)			; get type
		ld	c,a			; copy
		and	60h			; keep in range

		ld	e,a			; copy offset to a
		ld	d,0			; clear b

		ld	iy,dSFXPSG1		; get SFX PSG1 as base
		add	iy,de			; add offset to channel
		ld	ix,dPSG1		; get SFX PSG1 as base
		add	ix,de			; add offset to channel

		set	cfInt,(ix+cFlag)	; interrupt channel
		ld	(iy+cFlag),c		; save flag value

		inc	hl			; skip over first byte
		ld	a,(hl)			; load addr byte
		ld	(iy+cTrack),a		; save
		inc	hl			; skip byte
		ld	a,(hl)			; load addr byte
		ld	(iy+cTrack+1),a		; save
		inc	hl			; skip byte

		ld	(iy+cDuration),1	; reset duration to 1
		ld	(iy+cLoopPtr),cLoopStack-1; reset loop stack
		ld	(iy+cStackPtr),cStack	; reset stack

		xor	a			; prepae 0
		ld	(iy+cVolume),a		; reset volume
		ld	(iy+cPitch),a		; reset pitch
		ld	(iy+cDetune),a		; reset detune
		ld	(iy+cIns1),a		; reset instructions
		ld	(iy+cInsC1),a		;
		ld	(iy+cIns2),a		;
		ld	(iy+cInsC2),a		;
		call	MuteCh			; mute channel too
		djnz	.loops			; loop for all chans
		ret

; ===========================================================================
; ---------------------------------------------------------------------------
; Music Commands
; ---------------------------------------------------------------------------

CommandPtrs:	dw Cmd_Stop		; 01 - Stop music
		dw Cmd_Fade		; 02 - Fade out music
		dw Cmd_Int		; 03 - Interrupt music
		dw Cmd_Restart		; 04 - Restart music
; ---------------------------------------------------------------------------

Cmd_Stop:
		xor	a			; prepare 0
		ld	(dVol),a		; reset volume

Cmd_Stop2:
.ch2		macro type
		ld	(iy+cFlag),a		; clear flags
.nostop
	endm

		xor	a			; prepare 0
		ld	iy,dPSG1		; load PSG1 to iy
	.ch2					; process it
	QuickCh	dPSG1, dPSG2			; goto PSG2
	.ch2					; process it
	QuickCh	dPSG2, dPSG3			; goto PSG3
	.ch2					; process it
	QuickCh	dPSG3, dPSG4			; goto PSG4
	.ch2					; process it

	QuickCh	dPSG4, dSFXPSG1			; goto SFX PSG1
	.ch2					; process it
	QuickCh	dSFXPSG1, dSFXPSG2		; goto SFX PSG2
	.ch2					; process it
	QuickCh	dSFXPSG2, dSFXPSG3		; goto SFX PSG3
	.ch2					; process it
	QuickCh	dSFXPSG3, dSFXPSG4		; goto SFX PSG4
	.ch2					; process it

MutePSG:
		ld	a,ctPSG1|0Fh		; prepare PSG1 channel
		ld	b,20h			; go to next channel
		out	(PSG),a			; mute all channels

	rept 3
		add	a,b			; goto next channel
		out	(PSG),a			; mute
	endm
		ret
; ---------------------------------------------------------------------------

Cmd_Fade:
		ld	hl,dFlag		; get flags to hl
		set	dfFde,(hl)		; enable fading
		res	dfFadeT,(hl)		; fade out

		ld	a,1			; prepare 1
		ld	(dFade),a		; reset fade timer
		ret
; ---------------------------------------------------------------------------

Cmd_Int:
		call	Cmd_Fade		; fade out music
		set	dfInt,(hl)		; interrupt music after fade out
		res	dfIntRet,(hl)		; do not restart
		ret
; ---------------------------------------------------------------------------

Cmd_Restart:
		call	Cmd_Fade		; fade out music
		set	dfInt,(hl)		; interrupt music after fade out
		set	dfIntRet,(hl)		; restart music
		ret

; ===========================================================================
; ---------------------------------------------------------------------------
; Process PSG4 channel
;
; in:
;    a - Channel flags
;   iy - Channel data
; ---------------------------------------------------------------------------

ProcChannel4:	; check track type: 33, 64 or 74 cycles
		dec	(iy+cDuration)	; 23	; decrease duration
		jp	nz, .notrack	; 10	; if 0, read tracker
		call	ReadTracker	; 17	; run tracker

		or	a		; 4	; check the value
		jp	nz, .norest	; 10	; if 0, branch
		call	MuteCh		; 17	; mute channel	; set rest 40 cycles (+37 or 67)
		set	cfRest,(iy+cFlag); 23	; set as resting
		jp	.chktimer	; 10

.norest		jp	p, .timer	; 10	; branch if positive

		or	040h		; 7	; add base to note ; get note: 107 or 140 cycles
		out	(PSG),a		; 11	; put to PSG
		ld	(iy+cNoise),a	; 19	; save noise mode for later
		and	3		; 7	; get in range

		res	cfRest,(iy+cFlag); 23	; clear resting
		res	cfFreq,(iy+cFlag); 23	; clear freq flag
		cp	3		; 7	; check if a == 3
		jp	nz, .chktimer	; 10	; if not, branch
		set	cfFreq,(iy+cFlag); 23	; set freq flag

.chktimer	ld	a,(de)		; 7	; load next byte ; check timer type: 21 or 50 cycles
		or	a		; 4	; check its value	; not including setting timer
		jp	p, .timer2	; 10	; if positive, this is a timer too

		ld	a,(iy+cDurStore); 19	; copy stored duration
		jp	.timer3		; 10	;

.timer2		inc	de		; 6	; increment tracker
.timer		ld	(iy+cDurStore),a; 19	; save backup
.timer3		ld	(iy+cDuration),a; 19	; save as duration

		ld	(iy+cTrack),e	; 19	; save low byte of addr ; finish up: 67 or 163
		ld	(iy+cTrack+1),d	; 19	; save high byte of addr

		bit	cfSoft,(iy+cFlag); 20	; check if this is soft key
		jp	nz, .nokey	; 10	; branch if soft key

		ld	a,(iy+cInsC1)	; 19	; copy ins 1 off
		ld	(iy+cIns1),a	; 19	;

		ld	a,(iy+cInsC2)	; 19	; copy ins 2 off
		ld	(iy+cIns2),a	; 19	;

.nokey		ld	a,(iy+cFlag)	; 19	; read flags
.notrack	bit	cfRest,a	; 8	; check if resting	; update vol: cycles
		ret	nz		; 11/5	; if so, return		; 19, 39, 93, 123 or 130

		call	UpdateVolume	; 17	; update channel volume
		bit	cfInt,a		; 8	; check if interrupted
		ret	nz		; 11/5	; if so, return

		bit	cfFreq,a	; 8	; check if using PSG3 freq
		jp	z,.volume	; 10	; if not, jump

		bit	cfInt,(iy+cFlag-cSize); 20; check if PSG3 is interrupted
		jp	z,.volume	; 10	; if so, return
		ld	b,0Fh		; 7	; set to mute

.volume		and	0F0h		; 7	; get volume and type flags
		or	b		; 4	; add b
		out	(PSG),a		; 11	; and put in PSG
		ret			; 10

; ===========================================================================
; ---------------------------------------------------------------------------
; Process normal channel
;
; in:
;    a - Channel flags
;   iy - Channel data
; ---------------------------------------------------------------------------

ProcChannel:	; check track type: 33, 64 or 74 cycles
		dec	(iy+cDuration)	; 23	; decrease duration
		jp	nz, .notrack	; 10	; if 0, read tracker
		call	ReadTracker	; 17	; run tracker

		or	a		; 4	; check the value
		jp	nz, .norest	; 10	; if 0, branch

		call	MuteCh		; 17	; mute channel	; 50 cycles  (+37 or 67)
		set	cfRest,(iy+cFlag); 23	; set as resting
		jp	.chktimer	; 10

.norest		jp	p, .timerp	; 10	; branch if positive

		res	cfRest,(iy+cFlag); 20	; clear resting	; read freq: 156 cycles
		add	a,(iy+cPitch)	; 19	; add pitch
		add	a,a		; 4	; double note (and get rid of msb)

		ld	h,PitchTable>>8	; 7	; get pitch table high byte to h
		ld	l,a		; 4	; load l with pitch offset

		ld	c,(hl)		; 7	; load frequency
		inc	l		; 4	;
		ld	b,(hl)		; 7	;

		ld	a,(iy+cDetune)	; 19	; load detune to a
		ld	l,a		; 4	; copy detune to l
		add	a,a		; 4	; double detune
		sbc	a,a		; 4	; sub with carry (a is 0 of FF)
		ld	h,a		; 4	; load to h
		add	hl,bc		; 11	; add frequency to detune

		ld	(iy+cFreq),l	; 19	; save low byte
		ld	(iy+cFreq+1),h	; 19	; save high byte

.chktimer	ld	a,(de)		; 7	; load next byte ; check timer type: 21 or 50 cycles
		or	a		; 4	; check its value	; not including setting timer
		jp	p, .timer2	; 10	; if positive, this is a timer too

		ld	a,(iy+cDurStore); 19	; copy stored duration
		jp	.timer3		; 10	;

.timerp		ld	l,(iy+cFreq)	; 19	; load frequency (because we update it)
		ld	h,(iy+cFreq+1)	; 19	;
		jp	.timer		; 10

.timer2		inc	de		; 6	; increment tracker
.timer		ld	(iy+cDurStore),a; 19	; save backup
.timer3		ld	(iy+cDuration),a; 19	; save as duration

		ld	(iy+cTrack),e	; 19	; save low byte of addr	; soft and addr: 68, 177 or 204
		ld	(iy+cTrack+1),d	; 19	; save high byte of addr ; (+181 or 158 for last case)

		bit	cfSoft,(iy+cFlag); 20	; check if this is soft key
		jp	nz, .nokey	; 10	; branch if soft key

		ld	a,(iy+cInsC1)	; 19	; copy ins 1 off
		ld	(iy+cIns1),a	; 19	;
		ld	a,(iy+cInsC2)	; 19	; copy ins 2 off
		ld	(iy+cIns2),a	; 19	;

		ld	a,(iy+cModPtr+1); 19	; load high byte of ptr to a
		or	a		; 4	; check if 0
		jp	z, .nokey	; 10	; if is, branch

		call	ResetMod	; 17	; reset modulation
		jp	.nomfreq	; 10	; secretly, mod freq is reset, so we ignore it

.nokey		ld	a,(iy+cModPtr+1); 19	; check if we are modulating
		or	a		; 4	; mod freq: 33 or 82 cycles
		jp	nz, .nomfreq	; 10	; if not, branch

		ld	b,(iy+cModFreq+1); 19	; load mod freq to bc
		ld	c,(iy+cModFreq)	; 19	;
		add	hl,bc		; 11	; add to actual pitch

.nomfreq	call	UpdateFreq	; 17	; update frequency	; update freq: 21 cycles
		ld	a,(iy+cFlag)	; 4	; read flags		; (+38 or 117 cycles)
.notrack	bit	cfRest,a	; 8	; check if resting	; check mod: 19, 46 or 79 cycles
		ret	nz		; 11/5	; if so, return

		ld	a,(iy+cModPtr+1); 19	; get modulation pointer high byte
		or	a		; 4	; check if 0
		jp	z, .nomod	; 10	; if is, modulation is inactive
		dec	(iy+cModSpeed)	; 23	; decrease speed count
		jp	nz, .nomod	; 10	; if not timed out, jump

		ld	h,a		; 4	; copy a as the high byte ; various: 94 or 97 cycles
		ld	l,(iy+cModPtr)	; 19	; and get low byte

		ld	a,(hl)		; 7	; load speed counter
		inc	hl		; 6	;
		ld	(iy+cModSpeed),a; 19	; save speed counter

		ld	a,(hl)		; 7	; load offset to a
		bit	cfMod,(iy+cFlag); 20	; check mod direction
		jr	z, .nob		; 12/7	; branch if forwards
		neg			; 8	; negate direction

.nob		ld	c,a		; 4	; copy offset to c	; get mod freq: 107 cycles
		add	a,a		; 4	; double offset
		sbc	a,a		; 4	; sub with carry (a is 0 of FF)
		ld	b,a		; 4	; load to b

		ex	de,hl		; 4	; swap mod ptr to de
		ld	h,(iy+cModFreq+1); 19	; get mod freq high ptr to h
		ld	l,(iy+cModFreq)	; 19	; get mod freq low ptr to l

		add	hl,bc		; 11	; offset mod freq by bc
		ld	(iy+cModFreq+1),h; 19	; save mod frequ back to RAM
		ld	(iy+cModFreq),l	; 19	;

		ld	b,(iy+cFreq+1)	; 19	; get mod freq high ptr to b ; update freq: 66 cyles
		ld	c,(iy+cFreq)	; 19	; get mod freq low ptr to c	; (+38 or 117 cycles)
		add	hl,bc		; 11	; offset mod freq by real freq
		call	UpdateFreq	; 17	; update channel frequency

		dec	(iy+cModSteps)	; 23	; decrement modulation steps	; 33 or 110 cycles
		jp	nz, .nomod	; 10	; if steps left, branch

		inc	de		; 6	; get to last byte
		ld	a,(de)		; 7	; load step counter
		ld	(iy+cModSteps),a; 19	; reset step counter! Finally

		ld	a,(iy+cFlag)	; 19	; get flas to a
		xor	1<<cfMod	; 7	; flip mod direction
		ld	(iy+cFlag),a	; 19	; save back

.nomod		call	UpdateVolume	; 17	; update channel volume		; 36 or 62 cycles
		bit	cfInt,a		; 8	; check if interrupted
		ret	nz		; 11/5	; if so, return

		and	0F0h		; 7	; get volume and type flags
		or	b		; 4	; add b
		out	(PSG),a		; 11	; and put in PSG
		ret			; 10

; ===========================================================================
; ---------------------------------------------------------------------------
; Reset channel modulation (181 or 158 cycles)
;
; in:
;   a - modulation pointer high byte
;   iy - Channel data
; ---------------------------------------------------------------------------

ResetMod:
		ld	d,a		; 4	; copy to d
		ld	e,(iy+cModPtr)	; 19	; get low byte


ResetMod2:
		ld	a,(de)		; 7	; copy speed
		ld	(iy+cModSpeed),a; 19	;
		inc	de		; 6	;
		inc	de		; 6	; skip byte

		ld	a,(de)		; 7	; copy step
		srl	a		; 8	; halve it
		ld	(iy+cModSteps),a; 19	;

		xor	a		; 4	; prepare 0
		ld	(iy+cModFreq+1),a; 19	; clear mod freq
		ld	(iy+cModFreq),a	; 19	; clear mod freq

		res	cfMod,(iy+cFlag); 23	; reset mod direction to forwards
		ret			; 10

; ===========================================================================
; ---------------------------------------------------------------------------
; Set channel as muted (38 or 67 cycles)
;
; in:
;   iy - Channel data
; ---------------------------------------------------------------------------

MuteCh:
		ld	a,(iy+cFlag)	; 19	; read flags
		bit	cfInt,a		; 8	; check if interrupted
		ret	nz		; 11/5	; if so, return

		and	0F0h		; 7	; get type and volume bit
		or	1Fh		; 7	; or volume level
		out	(PSG),a		; 11	; put to PSG
		ret			; 10

; ===========================================================================
; ---------------------------------------------------------------------------
; Update channel frequency (38 or 117 cycles)
;
; in:
;   hl - Channel frequency
;   iy - Channel data
; ---------------------------------------------------------------------------

UpdateFreq:
		ld	a,(iy+cFlag)	; 19	; get type
		bit	cfInt,a		; 8	; check if interrupted
		ret	nz		; 11/5	; if is, return

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
		ret			; 10

; ===========================================================================
; ---------------------------------------------------------------------------
; Update channel volume (base routine 251 or 254 or 255 cycles)
;
; in:
;   iy - Channel data
;
; out:
;    b - Volume
; ---------------------------------------------------------------------------

UpdateVolume:
		ld	a,(dVol)	; 13	; get master volume to a
		add	a,(iy+cVolume)	; 19	; add volume to a

		ld	hl,cIns1	; 10	; get ins 1 to hl
		push	iy		; 15	; put iy to stack
		pop	bc		; 10	; get as bc
		add	hl,bc		; 11	; add bc

		ld	de,(dCurIns1)	; 20	; get instrument 1 to de
		ex	af,af'		; 4	; swap a with a'
		call	DoInstrument	; 17	; do instrument
		ex	af,af'		; 4	; swap a with a'
		add	a,b		; 4	; add b to a

		inc	hl		; 6	; go to next byte :V
		ld	de,(dCurIns2)	; 20	; get instrument 1 to de

		ex	af,af'		; 4	; swap a with a'
		call	DoInstrument	; 17	; do instrument
		ex	af,af'		; 4	; swap a with a'
		add	a,b		; 4	; add b to a

		cp	0Fh		; 7	; check if max volume
		jp	m, .nounder	; 10	; if positive, branch
		ld	b,0Fh		; 7	; load max volume to b
		ld	a,(iy+cFlag)	; 19	; read flags
		ret			; 10

.nounder	jp	c, .noover	; 10	; branch if... Something?
		xor	a		; 4	; force minumum
.noover		ld	b,a		; 4	; copy to b
		ld	a,(iy+cFlag)	; 19	; read flags
		ret

; ===========================================================================
; ---------------------------------------------------------------------------
; Update channel volume
;
; in:
;   de - Instrument table
;   hl - Pointer to instrument
;   iy - Channel pointer
;
; out:
;    b - Volume offset
; ---------------------------------------------------------------------------

DoInstrument:
		ld	c,(hl)		; 7	; load offset		; setup: 29 cycles
		ex	de,hl		; 4	; swap de and hl
		ld	b,0		; 7	; bc = offset
		add	hl,bc		; 11	; hl = data

.loop		ld	a,(hl)		; 7	; load data		; check: 33 or 50 cycles
		or	a		; 4	; check value
		jp	p, .volume	; 10	; if positive, branch

		cp	0A0h		; 7	; check if this is a command
		jr	nc, .volume	; 10	; branch if not

		ld	bc,.loop	; 10	; get loop addr to bc	; call routine: 92 cycles
		push	bc		; 11	; push addr to stack
		push	hl		; 11	; push hl to stack too

		ld	hl,InstPtrs-80h	; 10	; get commands pointer
		ld	c,a		; 4	; load offset
		ld	b,0		; 7	;
		add	hl,bc		; 11	; get real offset

		ld	a,(hl)		; 7	; load low byte
		inc	hl		; 6	; goto high
		ld	h,(hl)		; 7	; load high byte
		ld	l,a		; 4	; copy low byte again
		jp	(hl)		; 4	; jump to handler

.volume		ex	de,hl		; 4	; swap de and hl	; set vol: 26 cycles
		inc	(hl)		; 11	; increment offset
		ld	b,a		; 4	; copy volume to b
		ret			; 7
; ---------------------------------------------------------------------------

InstPtrs:
		dw Ci_Hold			; 80 - hold volume
		dw Ci_Stop			; 82 - Stop note
		dw Ci_Reset			; 84 - Reset offset
		dw Ci_Jump			; 86 - Jump to offset
; ---------------------------------------------------------------------------

Ci_Hold:	; 44 cycles
		pop	hl		; 10	; get hl back from stack
		inc	hl		; 6	; get next byte
		ld	b,(hl)		; 7	; load volume
		pop	hl		; 10	; do not return
		ex	de,hl		; 4	; swap de and hl
		ret			; 7

Ci_Stop:	; 91 cycles (+37 or 67 cycles)
		set	cfRest,(iy+cFlag); 23	; set resting
		call	MuteCh		; 17	; mute channel
		pop	hl		; 10	; pop return address
		pop	hl		; 10	; and again
		pop	hl		; 10	; and again
		pop	hl		; 10	; and again
		ex	de,hl		; 4	; swap de and hl
		ret			; 7

Ci_Reset:	; 104 cycles
		pop	hl		; 10	; get hl back from stack
		ex	de,hl		; 4	; swap de and hl
		inc	hl		; 6	; get to the copy byte
		inc	hl		; 6	;
		ld	a,(hl)		; 7	; load its value
		ld	c,a		; 4	; copy to c

		dec	hl		; 6	; get to the normal byte
		dec	hl		; 6	;
		sub	(hl)		; 7	; sub original value
		ld	(hl),c		; 7	; save offset

		ld	c,a		; 4	; copy offset to c
		add	a,a		; 4	; double a
		sbc	a,a		; 4	; 0 or FF
		ld	b,a		; 4	; copy to b

		ex	de,hl		; 4	; swap de and hl
		add	hl,bc		; 11	; fix offset
		ret			; 10

Ci_Jump:	; 80 cycles
		pop	hl		; 10	; get hl back from stack
		ex	de,hl		; 4	; swap de and hl

		ld	a,(de)		; 7	; load offset from table
		ld	c,a		; 4	; copy to c
		sub	(hl)		; 7	; sub current value
		ld	(hl),c		; 7	; save offset

		ld	c,a		; 4	; copy offset to c
		add	a,a		; 4	; double a
		sbc	a,a		; 4	; 0 or FF
		ld	b,a		; 4	; copy to b

		ex	de,hl		; 4	; swap de and hl
		add	hl,bc		; 11	; fix offset
		ret			; 10

; ===========================================================================
; ---------------------------------------------------------------------------
; Read tracker code
;
; in:
;   iy - Channel data
; ---------------------------------------------------------------------------

ReadTracker:
		ld	d,(iy+cTrack+1)	; 19	; read high byte	; setup: 38 cycles
		ld	e,(iy+cTrack)	; 19	; read low byte

.read		ld	a,(de)		; 7	; read next data	; read: 25 or 31
		inc	de		; 6	; skip this byte
		cp	Cmf-1		; 7	; check if this is a note or delay
		ret	c		; 11/5	; if so, return

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
; ---------------------------------------------------------------------------

	align (Cmf<<1)&0FFh	; MUST BE ALIGNED

TrackCmds:
	dw 10h dup (Cm_VolSet)		; Ex - Set volume
	dw Cm_Soft			; F0 - Soft key
	dw Cm_ModOff			; F1 - Disable mod
	dw Cm_ModSet			; F2 - Set mod
	dw Cm_Tempo			; F3 - Set tempo
	dw Cm_Ins2			; F4 - Set instruemnt 1
	dw Cm_Ins1			; F5 - Set instruemnt 2
	dw Cm_VolAdd			; F6 - Add volume
	dw Cm_DetAdd			; F7 - Add detune
	dw Cm_DetSet			; F8 - Set detune
	dw Cm_PitAdd			; F9 - Add detune
	dw Cm_PitSet			; FA - Set detune
	dw Cm_Return			; FB - Return
	dw Cm_LoopStart			; FC - Loop Start
	dw Cm_LoopEnd			; FD - Loop End
	dw Cm_Jump			; FE - Jump
	dw Cm_Call			; FF - Call

; ===========================================================================
; ---------------------------------------------------------------------------
; List of tracker commands
; ---------------------------------------------------------------------------

Cm_Soft:	; soft: 55 cycles
		ld	a,(iy+cFlag)	; 19	; get flas to a
		xor	1<<cfSoft	; 7	; flip soft flag
		ld	(iy+cFlag),a	; 19	; save back
		ret			; 10

Cm_ModOff:	; modoff: 33 cycles
		xor	a		; 4	; clear a
		ld	(iy+cModPtr),a	; 19	; clear high byte of addr
		ret			; 10

Cm_ModSet:	; modset: 71+158 = 229 cycles
		ld	(iy+cModPtr),e	; 19	; copy low byte to addr
		ld	(iy+cModPtr+1),d; 19	; copy high byte to addr
		call	ResetMod2	; 17	; reset modulation

		inc	de		; 6	; skip over param
		ret			; 10

Cm_Tempo:	; tempo: 36 cycles
		ld	a,(de)		; 7	; load tempo
		inc	de		; 6	;
		ld	(dTempo),a	; 13	; save tempo
		ret			; 10

Cm_Ins1:	; instrument 1: 61 cycles
		ld	a,(de)		; 7	; load offset
		inc	de		; 6	;
		ld	(iy+cIns1),a	; 19	; save offset
		ld	(iy+cInsC1),a	; 19	;
		ret			; 10

Cm_Ins2:	; instrument 1: 61 cycles
		ld	a,(de)		; 7	; load offset
		inc	de		; 6	;
		ld	(iy+cIns2),a	; 19	; save offset
		ld	(iy+cInsC2),a	; 19	;
		ret			; 10

Cm_VolSet:	; volset: 44 cycles
		srl	a		; 8	; halve (because of silly Z80)
		and	0Fh		; 7	; keep volume in range
		ld	(iy+cVolume),a	; 19	; save volume
		ret			; 10

Cm_VolAdd:	; voladd: 61 cycles
		ld	a,(de)		; 7	; load value
		add	a,(iy+cVolume)	; 19	; add volume to it
		inc	de		; 6	;
		ld	(iy+cVolume),a	; 19	; save back
		ret			; 10

Cm_DetAdd:	; detadd: 61 cycles
		ld	a,(de)		; 7	; load value
		inc	de		; 6	;
		add	a,(iy+cDetune)	; 19	; add detune to it
		ld	(iy+cDetune),a	; 19	; save back
		ret			; 10

Cm_DetSet:	; detset: 42 cycles
		ld	a,(de)		; 7	; load value
		inc	de		; 6	;
		ld	(iy+cDetune),a	; 19	; save it
		ret			; 10

Cm_PitAdd:	; pitadd: 61 cycles
		ld	a,(de)		; 7	; load value
		inc	de		; 6	;
		add	a,(iy+cPitch)	; 19	; add pitch to it
		ld	(iy+cPitch),a	; 19	; save back
		ret			; 10

Cm_PitSet:	; pitset: 42 cycles
		ld	a,(de)		; 7	; load value
		inc	de		; 6	;
		ld	(iy+cPitch),a	; 19	; save it
		ret			; 10

Cm_Return:	; return setup: 82 cycles
		dec	(iy+cStackPtr)	; 23	; decrement stack
		dec	(iy+cStackPtr)	; 23	;

		ld	a,(iy+cStackPtr); 19	; load stack ptr to a
		cp	cStack		; 7	; check if stack is dry
		jp	c, .stop	; 10	; if yes, stop channel

		push	iy		; 15	; copy iy to hl
		pop	hl		; 10	; return routine: 77 cycles

		ld	b,0		; 7	; load 0
		ld	c,a		; 4	; copy stack ptr to c
		add	hl,bc		; 11	; offset by ptr

		ld	d,(hl)		; 7	; load high byte
		inc	hl		; 6	;
		ld	e,(hl)		; 7	; load low byte
		ret			; 10

.stop		call	MuteCh		; 17	; mute ch	; check sfx: 112 or 117 (+37 or 67)
		xor	a		; 4	; clear a
		ld	(iy+cFlag),a	; 19	; stop ch
		pop	hl		; 10	; return to main loop
		pop	hl		; 10	;

		ld	hl,(-dSFXPSG1)&0FFFFh; 10; get first SFX channel to hl
		push	iy		; 15	; copy iy to bc
		pop	bc		; 10	;

		add	hl,bc		; 11	; check if this is a SFX channel
		ret	nc		; 11/5	; return if music

		ld	bc,(-((cSize*3)+cSize4))&0FFFFh; 10	; check int: 70
		push	iy		; 15	; store original iy for now
		add	iy,bc		; 15	; get the music channel this SFX is interrupting

		bit	cfRun,(iy+cFlag); 20	; check if running
		jp	z, .pop		; 10	; if not, do not fix!!!
		res	cfInt,(iy+cFlag); 23	; reset interrupt status

		ld	a,(iy+cFlag)	; 19	; load channel flags	; chk psg4: 63 or 68 cycles
		and	0F0h		; 7	; get type bits
		cp	ctPSG4		; 7	; check if this is PSG4
		jr	z,.psg4		; 12/7	; if so, branch

	; update interrupted channel frequency (channel will do volume)
		ld	l,(iy+cFreq)	; 19	; load frequency to hl
		ld	h,(iy+cFreq+1)	; 19	; update freq: 88 or 137 cycles (+38 or 117 cycles)

		ld	a,(iy+cModPtr+1); 19	; check if we are modulating
		or	a		; 4	;
		jp	nz, .nomod	; 10	; if not, branch

		ld	b,(iy+cModFreq+1); 19	; load mod freq to bc
		ld	c,(iy+cModFreq)	; 19	;
		add	hl,bc		; 11	; add to actual pitch

.nomod		call	UpdateFreq	; 17	; update frequency
.pop		pop	iy		; 14	; aaaand get iy back (just in case!)
		ret			; 10

	; update PSG type		; 54 cycles
.psg4		ld	a,(iy+cNoise)	; 19	; load noise setting
		out	(PSG),a		; 11	; put to PSG
		pop	iy		; 14	; aaaand get iy back (just in case!)
		ret			; 10

Cm_LoopStart:	; loop start: 218 cycles
		inc	(iy+cLoopPtr)	; 23	; increment loop stack
		push	iy		; 15	; copy iy to hl
		pop	bc		; 10	;

		ld	h,0		; 7	; load 0
		ld	l,(iy+cLoopPtr)	; 19	; load loop stack ptr to l
		add	hl,bc		; 11	; offset by ptr

		ld	a,(de)		; 7	; load loop count
		inc	de		; 6	;
		ld	(hl),a		; 7	; save loop count

		ld	h,0		; 7	; load 0
		ld	l,(iy+cStackPtr); 19	; load stack ptr to l
		add	hl,bc		; 11	; offset by ptr

		ld	(hl),d		; 7	; save high byte
		inc	hl		; 6	;
		ld	(hl),e		; 7	; save low byte

		inc	(iy+cStackPtr)	; 23	; increment stack
		inc	(iy+cStackPtr)	; 23	;
		ret			; 10

Cm_LoopEnd:	; loop end setup: 83 cycles
		push	iy		; 15	; copy iy to hl
		pop	bc		; 10	;
		ld	h,0		; 7	; load 0
		ld	l,(iy+cLoopPtr)	; 19	; load loop stack ptr to l
		add	hl,bc		; 11	; offset by ptr

		dec	(hl)		; 11	; decrement loop count
		jp	z, .endl	; 10	; if 0, end of loop

		ld	h,0		; 7	; load 0	; loop do: 73 cycles
		ld	l,(iy+cStackPtr); 19	; load stack ptr to l
		add	hl,bc		; 11	; offset by ptr

		dec	hl		; 6	; get the last data
		ld	e,(hl)		; 7	; load low byte first
		dec	hl		; 6	;
		ld	d,(hl)		; 7	; load high byte
		ret			; 10

.endl		dec	(iy+cStackPtr)	; 23	; decrement stack
		dec	(iy+cStackPtr)	; 23	; loop remove: 79 cycles
		dec	(iy+cLoopPtr)	; 23	;
		ret			; 10

Cm_Jump:	; jump: 40 cycles
		ex	de,hl		; 4 	; swap loaded address as current
		ld	e,(hl)		; 7	; load low byte
		inc	hl		; 6	;
		ld	d,(hl)		; 7	; load high byte
		ret			; 19

Cm_Call:	; call: 176 cycles
		push	iy		; 15	; copy iy to hl
		pop	hl		; 10	;
		ld	b,0		; 7	; load 0
		ld	c,(iy+cStackPtr); 19	; load stack ptr to c
		add	hl,bc		; 11	; offset by ptr

		ex	de,hl		; 4	; swap loaded address as current
		ld	c,(hl)		; 7	; load low byte
		inc	hl		; 6	;
		ld	b,(hl)		; 7	; load high byte
		inc	hl		; 6	;

		ex	de,hl		; 4	; swap loaded address as current
		ld	(hl),d		; 7	; save high byte
		inc	hl		; 6	;
		ld	(hl),e		; 7	; save low byte

		inc	(iy+cStackPtr)	; 23	; increment stack
		inc	(iy+cStackPtr)	; 23	;

		ld	d,b		; 4	; copy bc to de
		ld	e,c		; 4	;
		ret			; 10

; ===========================================================================
; ---------------------------------------------------------------------------
; Routine to quickly copy data from source to destination
; ---------------------------------------------------------------------------

LoadInt:
	rept (cSize*3)+cSize4+2
		ldi
	endm
		ret
