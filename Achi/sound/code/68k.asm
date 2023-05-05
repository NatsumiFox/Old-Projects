	opt oz+			; enable zero-offset optimization
	opt l.			; local lables are dots
	opt ae+
dRAM =	v_snddriver_ram
; ===========================================================================
dNoteToutHandler	macro
		tst.b	cNoteTimeCur(a5)	; check timer
		beq.s	.endt			; if 0, branch
		subq.b	#1,cNoteTimeCur(a5)	; sub 1 from the delay
		bne.s	.endt			; if not 0, branch
		bset	#cfbRest,(a5)		; set this as rest
    endm
; ===========================================================================
dNoteToutHandler	macro
		tst.b	cNoteTimeCur(a5)	; check timer
		beq.s	.endt			; if 0, branch
		subq.b	#1,cNoteTimeCur(a5)	; sub 1 from the delay
		bne.s	.endt			; if not 0, branch
		bset	#cfbRest,(a5)		; set this as rest
    endm
; ===========================================================================

dNoteToutDAC	macro
	dNoteToutHandler
		tst.b	cData(a5)		; check if we are holding
		bmi.s	.endt			; do not note on if so
		moveq	#0,d0			; play pause sample
		bra.w	dNoteOnDAC2		; play note
.endt
    endm
; ===========================================================================

dNoteToutFM	macro
	dNoteToutHandler
		bsr.w	dKeyOffFM		; do key off
		bra.\0	.next
.endt
    endm
; ===========================================================================

dNoteToutPSG	macro
	dNoteToutHandler
		bsr.w	dMutePSGmus		; mute PSG
		bra.s	.next
.endt
    endm
; ===========================================================================

dPitchSlide	macro type
		move.b	cDetune(a5),d6		; get detune/pitch slide value
		ext.w	d6			; extend to word
		add.w	cFreq(a5),d6		; add frequency

	if \type=111
		move.w	#$700,d0
		and.w	d6,d0
		move.b	d6,d0

		move.w	#$0283,d1
		sub.w	d0,d1
		bcs.s	.0

		add.w	#-$057B,d6
		bra.s	.1

.0		move.w	#$0508,d1
		sub.w	d0,d1
		bcc.s	.1
		add.w	#$057C,a6

.1
	endif

;		btst	#cfbPit,(a5)		; check if doing a pitch slide
;		beq.s	.noslide		; if not, branch
;		move.w	d6,cFreq(a5)		; if so, save the frequency back

;.noslide
    endm
; ===========================================================================

dModulate	macro jump,loop,type
		btst	#cfbMod,(a5)		; check if modulation is active
		beq.s	.noret			; if not, branch
		tst.b	cModDelay(a5)		; check if there is delay left
		beq.s	.started		; if not, branch
		subq.b	#1,cModDelay(a5)	; decrease delay

.noret	if narg>0
		if narg=3
			if type<2
				bclr	#cfbVol,(a5)		; check if volume update is needed and clear bit
				beq.s	.noupdate3		; if not, branch
				jsr	dUpdateVolFM(pc)	; update volume
			.noupdate3:
			endif
			if type>=4
				bclr	#cfbVol,(a5)		; check if volume update is needed and clear bit
				beq.s	.noupdate3		; if not, branch
				jsr	dUpdateVolDAC(pc)	; update volume
			.noupdate3:
			endif
			if \type<>5
				dbf	d7,\loop		; loop for all channels
			endif
		endif
		bra.w	\jump			; jump
	else
		bra.s	.endm
	endif

.started	subq.b	#1,cModSpeed(a5)	; sub 1 from mod speed counter
		bne.s	.noret			; if not finished, branch
		movea.l	cMod(a5),a0		; get modulation offset to a0
		move.b	1(a0),cModSpeed(a5)	; reset modulation speed

		tst.b	cModCount(a5)		; check mod steps count
		bne.s	.norev			; if not reverse yet, branch
		move.b	3(a0),cModCount(a5)	; reset steps counter
		neg.b	cModStep(a5)		; reverse steps num

.norev		subq.b	#1,cModCount(a5)	; sub 1 from the steps counter
		move.b	cModStep(a5),d5		; get step offset
		ext.w	d5			; extend to word

		add.w	cModFreq(a5),d5		; add modulation frequency
		move.w	d5,cModFreq(a5)		; save frequency
		add.w	d5,d6			; add to actual frequency

    endm
; ===========================================================================

dUpdate		macro	lable
		clr.b	cData(a5)		; clear holding flag
		movea.l	cData(a5),a4		; grab data offset
.data		moveq	#0,d5
		move.b	(a4)+,d5		; get a byte from SMPS
		cmpi.b	#$E0,d5			; is this a command?
		blo.s	.notcomm		; if not, branch
		jsr	dCommands(pc)		; resolve the coordination flag
		bra.s	.data
		bra.s	\lable			; go here if dcStop is used
.notcomm
    endm
; ===========================================================================

dProcNote	macro sfx, psg
		move.l	a4,cData(a5)		; set track pointer
		move.b	cLastDur(a5),cDuration(a5); set duration
		move.l	a4,d0			; check if we should allow note ons?
		bmi.s	.endpn			; if not, branch

	if sfx=0
		move.b	cNoteTimeMain(a5),cNoteTimeCur(a5)
	endif
		btst	#cfbMod,(a5)		; check if modulation is on
		beq.s	.env			; if not, branch

		movea.l	cMod(a5),a0		; get modulation address
		move.b	(a0)+,cModDelay(a5)	; set delay
		move.b	(a0)+,cModSpeed(a5)	; set speed
		move.b	(a0)+,cModStep(a5)	; set offset of each step

		move.b	(a0),d0			; get num of steps
		lsr.b	#1,d0			; halve it
		move.b	d0,cModCount(a5)	; set num of steps
		clr.w	cModFreq(a5)		; reset frequency

.env	if psg<>0
		clr.b	cEnvPos(a5)		; clear envelope pos
	endif
.endpn
    endm
; ===========================================================================

dGetFreqDAC	macro
		btst	#cfbMode,(a5)		; check if we are on pitch mode
		bne.s	.pitch			; branch if we are
		move.b	d5,cSample(a5)		; save sample
		bra.s	.cont

.pitch		subi.b	#$80,d5			; sub $80 (notes start on $80)
		bne.s	.noprest		; if was not rest, branch
		moveq	#0,d0			; play stop sample
		bsr.w	dNoteOnDAC2		; do note on
		bra.s	.cont

.noprest	add.b	cPitch(a5),d5		; add pitch offset
		andi.w	#$7F,d5			; keep within $80 notes
		add.w	d5,d5			; each entry is word
		move.w	dFreqDAC-dhOverflowDAC(a6,d5.w),cFreq(a5); set correct frequenc
.cont
    endm
; ===========================================================================

dKeyOnFM	macro
		btst	#cfbRest,(a5)		; check if resting
		bne.s	.k			; if so, do not note on
	if narg=0
		btst	#cfbInt,(a5)		; check if overridden by sfx
		bne.s	.k			; if so, do not note on
	endif

		moveq	#$28,d0			; YM key on
		move.b	cType(a5),d1		; get type
		ori.b	#$F0,d1			; turn all operators on
		bsr.w	WriteYM_Pt1		; turn note on
.k
    endm
; ===========================================================================

dGetFreqPSG	macro
		subi.b	#$81,d5			; sub $81 (notes start on $80)
		bhs.s	.norest			; if not rest, branch
		bset	#cfbRest,(a5)		; set channel to rest
		move.w	#-1,cFreq(a5)		; set null frequency
		jsr	dMutePSGmus(pc)		; mute this PSG channel
		bra.s	.freqgot

.norest		add.b	cPitch(a5),d5		; add pitch offset
		andi.w	#$7F,d5			; keep within $80 notes
		add.w	d5,d5			; each entry is word
		move.w	(a6,d5.w),cFreq(a5)	; set frequency to use
.freqgot
    endm
; ===========================================================================

LoadDualPCM:
		move	#$2700,sr
		move.w	#$0100,$A11100		; request Z80 stop (ON)
		move.w	#$0100,$A11200		; request Z80 reset (OFF)

		lea	DualPCM,a0		; load Z80 ROM data
		lea	$A00000,a1		; load Z80 RAM space address
		move.w	#DualPCM_sz-$01,d1	; set repeat times

.z80		btst	#$00,$A11100		; has the Z80 stopped yet?
		bne.s	.z80			; if not, branch

.load		move.b	(a0)+,(a1)+		; dump Z80 data to Z80 space
		dbf	d1,.load		; repeat til done

		lea	SampleList(pc),a0	; load stop/mute sample address
		lea	$A00000+MuteSample,a1	; load Z80 RAM space where the pointer is to be stored
		move.b	(a0)+,(a1)+		; copy pointer over into Z80
		move.b	(a0)+,(a1)+		; ''
		move.b	(a0)+,(a1)+		; ''
		move.b	(a0)+,(a1)+		; CHG: copy "reverse" pointer over into Z80
		move.b	(a0)+,(a1)+		; ''
		move.b	(a0)+,(a1)+		; ''

		move.w	#$0000,$A11200		; request Z80 reset (ON)
		moveq	#$7F,d1			; set repeat times
		dbf	d1,*			; there's no way of checking for reset, so a manual delay is necessary

		move.w	#$0000,$A11100		; request Z80 stop (OFF)
		move.w	#$0100,$A11200		; request Z80 reset (OFF)
		move	#$2300,sr
		rts
; ===========================================================================

dReqVolUpFM;
		moveq	#1<<cfbVol,d0
.ch =	dRAM+mFM1
	rept Mus_FM
		or.b	d0,.ch.w
.ch =		.ch+cSize
	endr

.ch =	dRAM+mSFXFM3
	rept SFX_FM
		or.b	d0,.ch.w
.ch =		.ch+cSizeSFX
	endr
		rts

UpdateSMPS:
	StopZ802					; CHG: request Z80 stop on
		move.b	$A00000+YM_Buffer,d0		; CHG: load buffer ID
	StartZ80					; CHG: request Z80 stop off

		move.l	#$A00000+YM_Buffer1,dRAM+mCueYM.w; CHG: set the cue address to buffer 1
		tst.b	d0				; CHG: check buffer to use
		bne.s	.gotbuffer			; CHG: if Z80 is reading buffer 2, branch
		move.l	#$A00000+YM_Buffer2,dRAM+mCueYM.w; CHG: set the cue address to buffer 2

.gotbuffer	tst.b	dRAM+mFlags.w		; is music paused?
		bmi.w	dPauseCtrl		; if yes, branch

	; do tempo
		move.b	dRAM+mTempo.w,d0	; get tempo to d0
		add.b	d0,dRAM+mTempoTime.w	; add to accumulator
		bcc.s	.notempo		; if carry clear, branch

.ch =	dRAM+mDAC1+cDuration
	rept Mus_Ch
		addq.b	#1,.ch.w		; add 1 to duration
.ch =		.ch+cSize
	endr

.notempo	tst.b	dRAM+mFadeAddr+1.w	; check if fade is active
		beq.s	.fadeend		; branch if not
		move.l	dRAM+mFadeAddr.w,a1	; get fade address to a1
		addq.l	#3,dRAM+mFadeAddr.w	; increment addr

		moveq	#(1<<cfbVol),d1		; set volume update to d1
		moveq	#0,d0
		move.b	(a1)+,d0		; get fade byte
		bpl.s	.nofadeend		; if fade did not end, branch
		clr.b	dRAM+mFadeAddr+1.w	; clear fade byte
		bra.s	.fadeend

.nofadeend	cmp.b	dRAM+mMasterVolFM.w,d0	; check if volume is same
		beq.s	.fadedac		; bracnh if is
		move.b	d0,dRAM+mMasterVolFM.w	; save volume

.ch =	dRAM+mFM1
	rept Mus_FM
		or.b	d1,.ch.w		; set update vol flag
.ch =		.ch+cSize
	endr

.ch =	dRAM+mSFXFM3
	rept SFX_FM
		or.b	d1,.ch.w		; set update vol flag
.ch =		.ch+cSizeSFX
	endr

.fadedac	move.b	(a1)+,d0		; get dac volume byte
		cmp.b	dRAM+mMasterVolDAC.w,d0	; check if volume is same
		beq.s	.fadepsg		; bracnh if is
		move.b	d0,dRAM+mMasterVolDAC.w	; save volume

.ch =	dRAM+mDAC1
	rept Mus_DAC
		or.b	d1,.ch.w		; set update vol flag
.ch =		.ch+cSize
	endr
		or.b	d1,dRAM+mSFXDAC.w	; set update vol flag

.fadepsg	move.b	(a1)+,d0		; get psg volume byte
		cmp.b	dRAM+mMasterVolPSG.w,d0	; check if volume is same
		beq.s	.fadeend		; bracnh if is
		move.b	d0,dRAM+mMasterVolPSG.w	; save volume

.ch =	dRAM+mPSG1
	rept Mus_PSG
		or.b	d1,.ch.w		; set update vol flag
.ch =		.ch+cSize
	endr

.ch =	dRAM+mSFXPSG1
	rept SFX_PSG
		or.b	d1,.ch.w		; set update vol flag
.ch =		.ch+cSizeSFX
	endr


.fadeend	jsr	dPlaySnd(pc)

	; BGM DAC channels
.noqueue	lea	dhOverflowDAC(pc),a6	; get table for quick access
		lea	dRAM+mDAC1-cSize.w,a5	; get DAC1 RAM to a5
		moveq	#Mus_DAC-1,d7		; 2 DAC channels
; ===========================================================================

dSMPSdoDAC:
		add.w	#cSize,a5		; go to next channel
		tst.b	(a5)			; check if running
		bpl.w	.noupdate		; if not, branch
		subq.b	#1,cDuration(a5)	; sub 1 from note timer
		beq.w	.update			; if timed out, branch
	dNoteToutDAC	 			; handle note timeouts

.mod	dPitchSlide 0
	dModulate dSMPSdoFM, dSMPSdoDAC, 4	; modulate
		bsr.w	dUpdateFreqDAC		; update DAC frequency

.next		bclr	#cfbVol,(a5)		; check if volume update is needed and clear bit
		beq.s	.noupdate		; if not, branch
		bsr.w	dUpdateVolDAC		; update dac volume

.noupdate	dbf	d7,dSMPSdoDAC		; loop for all channels
		jmp	dSMPSdoFM(pc)		; end loop

.update	dUpdate	.noupdate			; update the DAC channel
		tst.b	d5			; check if note or duration
		bpl.s	.timer			; branch if timer only

	dGetFreqDAC				; get frequency
		btst	#cfbPit,(a5)		; check if doing a pitch slide
		beq.s	.nopit			; if not, branch
		move.b	(a4)+,cDetune(a5)	; check next byte

.nopit		move.b	(a4)+,d5		; check next byte
		bpl.s	.timer			; if positive, process a timer too
		subq.w	#1,a4			; if not, then return back
		bra.s	.pcnote			; do some extra clearing

.timer		jsr	dCalcDuration(pc)	; get duration
.pcnote	dProcNote 0, 0				; process note
		bsr.s	dNoteOnDAC		; do note on
		dbf	d7,dSMPSdoDAC		; loop for all channels
		jmp	dSMPSdoFM(pc)		; end loop
; ===========================================================================

dNoteOnDAC:
		tst.b	cData(a5)		; check if we are holding
		bmi.w	dUpdateFreqDAC2		; do not note on if so
		move.b	cSample(a5),d0		; get sample ID
		add.b	cPitch(a5),d0		; add pitch offset
		andi.w	#$7F,d0			; keep within $80 notes

dNoteOnDAC2:
		btst	#cfbInt,(a5)		; is interrupted by SFX?
		bne.w	locret_UpdFreqDAC	; if so, do not note on or update frequency

		add.b	d0,d0			; double ID and get rid of msb
		add.w	d0,d0			; double ID again (quadruple)
		add.w	d0,d0			; and once more
		add.w	d0,d0			; in total, ID*$10
		lea	SampleList(pc),a0	; get sample table to a0
		lea	(a0,d0.w),a0		; get sample data to a0

		lea	$A00000+PCM1_Sample,a1	; load PCM 1 slot address
		lea	$A00000+PCM1_NewRET,a2	; ''
		btst	#ctbPt2,cType(a5)	; check if DAC1
		beq.s	dNoteWriteDAC1		; if is, branch

dNoteWriteDAC2:
		lea	$A00000+PCM2_Sample,a1	; load PCM 2 slot address
		lea	$A00000+PCM2_NewRET,a2	; ''

dNoteWriteDAC1:
	StopZ802
		move.b	(a0)+,(a1)+		; set address of sample
		move.b	(a0)+,(a1)+		; ''
		move.b	(a0)+,(a1)+		; ''
		move.b	(a0)+,(a1)+		; set address of reverse sample
		move.b	(a0)+,(a1)+		; ''
		move.b	(a0)+,(a1)+		; ''
		move.b	(a0)+,(a1)+		; set address of next sample
		move.b	(a0)+,(a1)+		; ''
		move.b	(a0)+,(a1)+		; ''
		move.b	(a0)+,(a1)+		; set address of next reverse sample
		move.b	(a0)+,(a1)+		; ''
		move.b	(a0)+,(a1)+		; ''
		move.b	#%11011010,(a2)		; change "JP NC" to "JP C"
	StartZ80
; ===========================================================================

dUpdateFreqOffDAC:
		move.w	cFreq(a5),d6		; get base frequency

		tst.w	(a0)
		beq.s	dUpdateFreqDAC
		add.w	(a0)+,d6		; add sample frequency
		bra.s	dUpdateFreqDAC

dUpdateFreqDAC2:
		move.w	cFreq(a5),d6

dUpdateFreqDAC:
		btst	#cfbInt,(a5)		; is interrupted by SFX?
		bne.s	locret_UpdFreqDAC	; if so, branch

dUpdateFreqDAC3:
		move.b	cDetune(a5),d0		; get detune value
		ext.w	d0			; extend to word
		add.w	d0,d6			; add to get actual frequency
		move.w	d6,d0			; copy frequency to d0
		smi	d1			; if negative, d1 = $FF

		add.w	#$100,d0		; add to pitch
		muls	#$18,d0			; multiply by $18 ;(
		asr.l	#8,d0			; divide by $100
		move.w	d0,-(sp)		; save to stack

		move.b	(sp),d3			; get high overflow
		move.w	d6,(sp)			; put in frequency
		move.b	(sp),d2			; get high quotient

		addq.w	#2,sp			; fix stack
		btst	#ctbPt2,cType(a5)	; check if DAC1
		beq.s	dFreqDAC1		; if is, branch

	StopZ802
		move.b	d6,$A00000+PCM2_RateDiv+1	; write pitch main dividend
		move.b	d2,$A00000+PCM2_RateQuo+1	; write pitch quotient low
		move.b	d1,$A00000+PCM2_RateQuo+2	; write pitch quotient high

		move.b	d0,$A00000+PCM2_Overflow+1	; write low overflow
		move.b	d3,$A00000+PCM2_Overflow+2	; write high overflow
		move.b	#%11010010,$A00000+PCM_ChangePitch; change "JP C" to "JP NC"
	StartZ80

locret_UpdFreqDAC;
		rts

dFreqDAC1:
	StopZ802
		move.b	d6,$A00000+PCM1_RateDiv+1	; write pitch main dividend
		move.b	d2,$A00000+PCM1_RateQuo+1	; write pitch quotient low
		move.b	d1,$A00000+PCM1_RateQuo+2	; write pitch quotient high

		move.b	d0,$A00000+PCM1_Overflow+1	; write low overflow
		move.b	d3,$A00000+PCM1_Overflow+2	; write high overflow
		move.b	#%11010010,$A00000+PCM_ChangePitch; change "JP C" to "JP NC"
	StartZ80
		rts

; ===========================================================================

dCalcDuration:
		moveq	#0,d0
		moveq	#0,d1
		move.b	cTick(a5),d1		; get tick multiplier

.multiply	add.b	d5,d0			; add duration to d0
		dbf	d1,.multiply		; loop for all ticks

		move.b	d0,cDuration(a5)	; save duration
		move.b	d0,cLastDur(a5)
		rts
; ===========================================================================

dSMPSdoDACSFX:
		add.w	#cSize,a5		; go to next channel
		tst.b	(a5)			; check if running
		bpl.s	.next			; if not, branch
		lea	dhOverflowDAC(pc),a6	; get table for quick access
		subq.b	#1,cDuration(a5)	; sub 1 from note timer
		beq.s	.update			; if timed out, branch

	dPitchSlide 0
	dModulate dSMPSdoFMSFX, dSMPSdoDAC, 5	; modulate
		bsr.w	dUpdateFreqDAC3		; update DAC frequency

.next		bclr	#cfbVol,(a5)		; check if volume update is needed and clear bit
		beq.s	.noupdate		; if not, branch
		bsr.w	dUpdateVolDAC2		; update dac volume
.noupdate	jmp	dSMPSdoFMSFX(pc)	; end loop

.update	dUpdate	.noupdate			; update the DAC channel
		tst.b	d5			; check if note or duration
		bpl.s	.timer			; branch if timer only

	dGetFreqDAC				; get frequency
		btst	#cfbPit,(a5)		; check if doing a pitch slide
		beq.s	.nopit			; if not, branch
		move.b	(a4)+,cDetune(a5)	; check next byte

.nopit		move.b	(a4)+,d5		; check next byte
		bpl.s	.timer			; if positive, process a timer too
		subq.w	#1,a4			; if not, then return back
		bra.s	.pcnote			; do some extra clearing

.timer		jsr	dCalcDuration(pc)	; get duration
.pcnote	dProcNote 1, 0				; process note
		bsr.w	dNoteOnDAC		; do note on
		jmp	dSMPSdoFMSFX(pc)	; end loop
; ===========================================================================

dUpdateVolDAC:
		btst	#cfbInt,(a5)		; check if interrupted
		bne.s	locret_VolDAC		; if is, branch

dUpdateVolDAC2:
		move.b	cVolume(a5),d3		; get volume
		add.b	dRAM+mMasterVolDAC.w,d3	; add master volume
		cmp.b	#$40,d3			; check if max
		blt.s	.gotvol			; if not, branch
		moveq	#$40,d3			; force max vol

.gotvol	StopZ802
		move.b	#%011010010,$A00000+PCM_ChangeVolume; change volume flag

		btst	#ctbPt2,cType(a5)	; check if DAC1
		beq.s	.dac1			; if is, branch
		move.b	d3,$A00000+PCM2_Volume+1; change volume
	StartZ80
		rts

.dac1		move.b	d3,$A00000+PCM1_Volume+1; change volume
	StartZ80

locret_VolDAC:
		rts
; ===========================================================================

dPauseCtrl:
		btst	#mfbReqUnpause,dRAM+mFlags.w
		bne.s	dUnpause		; if unpausing, branch
		btst	#mfbReqPause,dRAM+mFlags.w
		beq.w	locret_UnPause		; if not pausing, remain paused

		bclr	#mfbReqPause,dRAM+mFlags.w
		moveq	#3-1,d3			; 3 FM channel groups
		moveq	#$FFFFFFB4,d0		; YM address to pan flag
		moveq	#0,d1			; no panning or LFO (no sound)

.muteFM		jsr	WriteYM_Pt1(pc)
		jsr	WriteYM_Pt2(pc)
		addq.b	#1,d0
		dbf	d3,.muteFM		; loop for all 3 channel groups

		moveq	#%00000010,d3		; note off
		moveq	#$28,d0			; YM address to key on/off

.note		move.b	d3,d1			; note off for FM3/2/1
		jsr	WriteYM_Pt1(pc)
		addq.b	#4,d1			; note off for FM6/5/4
		jsr	WriteYM_Pt1(pc)
		dbf	d3,.note		; loop for all 3 channel groups

		jsr	dMutePSG(pc)		; mute PSG
		jmp	dMuteDAC(pc)		; mute DAC channel
; ===========================================================================

dUnpause:
		bclr	#mfbReqUnpause,dRAM+mFlags.w
		bclr	#mfbPaused,dRAM+mFlags.w

		moveq	#cSize,d3		; prepare size of each channel
		lea	dRAM+mFM1.w,a5		; prepare RAM address
		moveq	#Mus_FM-1,d4		; prepare num of channels

.musloop	btst	#cfbRun,(a5)		; is channel running?
		beq.s	.skipmus		; if not, branch
		btst	#cfbInt,(a5)		; is channel interrupted?
		bne.s	.skipmus		; if is, branch

		moveq	#$FFFFFFB4,d0		; YM address for Pan/LFO
		move.b	cPanning(a5),d1		; get panning data from channel
		jsr	WriteChYM(pc)

.skipmus	adda.w	d3,a5			; go to next channel
		dbf	d4,.musloop		; loop for all channels

		lea	dRAM+mSFXFM3.w,a5	; prepare RAM address
		moveq	#SFX_FM-1,d4		; prepare num of channels
		moveq	#cSizeSFX,d3		; prepare size of each channel

.sfxloop	btst	#cfbRun,(a5)		; is channel running?
		beq.s	.skipsfx		; if not, branch
		btst	#cfbInt,(a5)		; is channel interrupted?
		bne.s	.skipsfx		; if is, branch

		moveq	#$FFFFFFB4,d0		; YM address for Pan/LFO
		move.b	cPanning(a5),d1		; get panning data from channel
		jsr	WriteChYM(pc)

.skipsfx	adda.w  d3,a5			; go to next channel
		dbf     d4,.sfxloop

		move.b	dRAM+mDAC1+cPanning.w,d1
		or.b	dRAM+mDAC2+cPanning.w,d1
		moveq	#$FFFFFFB4+ctFM36,d0	; YM address to panning on FM6
		jmp	WriteYM_Pt2(pc)

locret_UnPause:
		rts

; ---------------------------------------------------------------------------
; Subroutine to	play a sound or	music track
; ---------------------------------------------------------------------------

dPlaySnd:
		lea	dRAM+mQueue.w,a6	; 2 slots to check
		moveq	#0,d7
		move.b	(a6)+,d7		; get sound ID
		bne.s	.found			; if not 0, sound is queued
		move.b	(a6)+,d7		; get sound ID
		bne.s	.found			; if not 0, sound is queued
		move.b	(a6)+,d7		; get sound ID
		beq.s	locret_UnPause		; if 0, no sound is qeueued for the slot

.found		clr.b	-1(a6)			; empty the slot
		cmpi.b	#sfx_Waterfall,d7
		beq.s	locret_UnPause		; waterfall sfx
		cmpi.b	#MusOff,d7
		blo.w	dPlaySnd_Comm		; commands
		cmpi.b	#SFXoff,d7
		bhs.w	dPlaySnd_SFX		; sfx

; ---------------------------------------------------------------------------
; Play music track
; ---------------------------------------------------------------------------

dPlaySnd_Music:
		jsr	dStopMusic(pc)		; stop previous track playing
		lea	MusicIndex-(MusOff*4)(pc),a4
		add.w	d7,d7			; quadruple ID
		add.w	d7,d7
		move.b	(a4,d7.w),dRAM+mTempoSpeed.w; get speed shoes tempo
		movea.l	(a4,d7.w),a4		; get track pointer

		move.l	a4,a3			; copy track pointer
		addq.w	#4,a4			; skip over the flags section

		moveq	#0,d0
		move.b	1(a3),d0		; get song tempo
		move.b	d0,dRAM+mTempoMain.w	; save as main tempo
		btst	#mfbSpeed,dRAM+mFlags.w	; check if speed shoes is in use
		beq.s	.tempogot		; if not, branch
		move.b	dRAM+mTempoSpeed.w,d0	; get speed shoes tempo instead

.tempogot	move.b	d0,dRAM+mTempo.w	; set the tempo
		clr.b	dRAM+mTempoTime.w	; clear accumulator

		btst	#6,v_megadrive.w	; is this PAL system?
		beq.s	.palgot			; if not, branch
		bset	#mfbPAL,dRAM+mFlags.w	; enable PAL mode

		lea	dTempoPAL(pc),a1	; crab the tempo PAL conversion table to a1
		move.b	(a1,d0.w),dRAM+mTempo.w	; convert tempo

		move.b	dRAM+mTempoMain.w,d0	; copy the normal tempo to d0
		move.b	(a1,d0.w),dRAM+mTempoMain.w; convert tempo
		move.b	dRAM+mTempoSpeed.w,d0	; copy the speedshoes tempo to d0
		move.b	(a1,d0.w),dRAM+mTempoSpeed.w; convert tempo

.palgot		move.b	(a3),d4			; get the tick multiplier
		bpl.s	.tickgot		; if positive, branch
		and.b	#$7F,d4			; keep it positive

.tickgot	moveq	#$FFFFFF00|(1<<cfbRun),d2; set the running flag
		moveq	#$FFFFFFC0,d1		; prepare panning to both speakers
		moveq	#cSize,d6		; prepare size of each track
		moveq	#1,d5			; set timer to 1

		lea	dRAM+mDAC1.w,a1		; start with FM1
		lea	dDACtypeVals(pc),a2	; DAC init type values
		moveq	#2-1,d7			; 2 DAC channels
		moveq	#0,d3			; default PCM frequency

.loopDAC	move.b	d2,(a1)			; set channel running
		bset	#cfbVol,(a1)		; set volume update
		move.b	(a2)+,cType(a1)		; set channel type
		move.b	d4,cTick(a1)		; set tick multiplier
		move.b	d6,cStack(a1)		; set stack address
		move.b	d1,cPanning(a1)		; set panning to both speakers
		move.b	d5,cDuration(a1)	; ensure channel starts immediately.
		move.w	d3,cFreq(a1)		; reset frequency

		moveq	#0,d0
		move.w	(a4)+,d0		; get the channel offset to d0
		add.l	a3,d0			; add song offset to d0
		move.l	d0,cData(a1)		; save it

		clr.b	cVolume(a1)		; clear volume
		move.b	(a4)+,cDetune(a1)	; save detune
		move.b	(a4)+,cSample(a1)	; save sample
		beq.s	.sampmode		; if is 0, use sample mode
		bset	#cfbMode,(a1)		; set to pitch mode

.sampmode	add.w	d6,a1			; next channel
		dbf	d7,.loopDAC		; loop for all 2 DAC channels

		moveq	#0,d7
		move.b	2(a3),d7		; get the FM channel count
		bmi.s	.doPSG			; branch if 0

.loopFM		move.b	d2,(a1)			; set channel running
		move.b	(a2)+,cType(a1)		; set channel type
		move.b	d4,cTick(a1)		; set tick multiplier
		move.b	d6,cStack(a1)		; set stack address
		move.b	d1,cPanning(a1)		; set panning to both speakers
		move.b	d5,cDuration(a1)	; ensure channel starts immediately

		moveq	#0,d0
		move.w	(a4)+,d0		; get the channel offset to d0
		add.l	a3,d0			; add song offset to d0
		move.l	d0,cData(a1)		; save it

		move.w	(a4)+,cPitch(a1)	; get pitch and panning
		adda.w	d6,a1			; next channel
		dbf	d7,.loopFM		; loop for all FM channels

.doPSG		moveq	#0,d7
		move.b	3(a3),d7		; get num of PSG channels
		bmi.s	.intSFX			; if negative, check SFX interrupts
		lea	dPSGtypeVals(pc),a2
		lea	dRAM+mPSG1.w,a1		; start with PSG1
		moveq	#2,d5			; set timer to 2 (match with YM delay)

.loopPSG	move.b	d2,(a1)			; set channel running
		move.b	(a2)+,cType(a1)		; set channel type
		move.b	d4,cTick(a1)		; set tick multiplier
		move.b	d6,cStack(a1)		; set stack address
		move.b	d5,cDuration(a1)	; ensure channel starts immediately

		moveq	#0,d0
		move.w	(a4)+,d0		; get the channel offset to d0
		add.l	a3,d0			; add song offset to d0
		move.l	d0,cData(a1)		; save it

		move.w	(a4)+,cPitch(a1)	; get pitch and panning
		move.b	(a4)+,cDetune(a1)	; detune value
		move.b	(a4)+,cPatch(a1)	; patch ID
		adda.w	d6,a1			; next channel
		dbf	d7,.loopPSG		; loop for all FM channels

.intSFX		move.l	a4,dRAM+mPatMus.w	; set patch offset to end of header

		moveq	#$28,d0			; key on/off
		moveq	#6,d1			; FM6 key off
		jsr	WriteYM_Pt1(pc)

		moveq	#$7F,d1			; $7F (silence)
		moveq	#$42,d0			; FM6 op 1 TL
		jsr	WriteYM_Pt2(pc)

		moveq	#$4A,d0			; FM6 op 2 TL
		jsr	WriteYM_Pt2(pc)

		moveq	#$46,d0			; FM6 op 3 TL
		jsr	WriteYM_Pt2(pc)

		moveq	#$4E,d0			; FM6 op 4 TL
		jsr	WriteYM_Pt2(pc)

		moveq	#$FFFFFFB6,d0		; FM3/6 panning/LFOP
		moveq	#$FFFFFFC0,d1		; prepare panning to both speakers
		jsr	WriteYM_Pt2(pc)

		lea	dSFXoverList(pc),a2	; get list of channels to override
		lea	dRAM+mSFXDAC.w,a1	; start with SFX FM3
		moveq	#SFX_Ch,d7		; prepare number of SFX channels
		moveq	#cSizeSFX,d6		; prepare size of each SFX track

.loopSFX	tst.b	(a1)			; check if channel is in use
		bpl.s	.nextSFX		; if not, skip to next

		moveq	#0,d0
		move.b	cType(a1),d0		; get SFX type
		bmi.s	.SFXPSG			; branch if PSG
		and.w	#ctPt2|$03,d0		; clear the bit DAC1 uses to identify being DAC
		subq.w	#2,d0			; skip FM1 & FM2
		add.w	d0,d0			; each entry is 1 word
		bra.s	.override
; ===========================================================================

.SFXPSG		lsr.b	#4,d0			; shift PSG channel bits in place
.override	movea.w	(a2,d0.w),a0		; get channel RAM offset
		bset	#cfbInt,(a0)		; set interrupted bit

.nextSFX	adda.w	d6,a1			; next channel
		dbf	d7,.loopSFX		; loop for all SFX channels

		lea	dRAM+mFM1.w,a5		; preapre FM1
		moveq	#Mus_FM-1,d4		; prepare number of FM channels

.stopFM		jsr	dKeyOffFM(pc)		; set key off
		adda.w	d6,a5			; next channel
		dbf	d4,.stopFM		; loop for all channels

		moveq	#Mus_PSG-1,d4		; prepare number of PSG channels
.mutePSG	jsr	dMutePSGmus(pc)		; mute PSG
		adda.w	d6,a5			; next channel
		dbf	d4,.mutePSG		; loop for all channels

		addq.w	#4,sp			; do not return to caller
		rts

; ===========================================================================
dDACtypeVals:	dc.b ctDAC1, ctDAC2
dFMtypeVals:	dc.b ctFM14|ctPt1, ctFM25|ctPt1, ctFM36|ctPt1
		dc.b ctFM14|ctPt2, ctFM25|ctPt2, ctFM36|ctPt2
dPSGtypeVals:	dc.b ctPSG1, ctPSG2, ctPSG3
		even
; ===========================================================================
; ---------------------------------------------------------------------------
; Play normal sound effect
; ---------------------------------------------------------------------------

dPlaySnd_SFX:
		cmpi.b	#sfx_Ring,d7		; is ring sound	effect played?
		bne.s	.noring			; if not, branch
		bchg	#mfbRing,dRAM+mFlags.w	; check and switch if ring speaker was left
		beq.s	.noring			; if not, branch
		moveq	#sfx_RingLeft,d7	; switch speaker to left

.noring		lea	SoundIndex-(SFXoff*4)(pc),a0
		move.b	d7,d0			; copy ID (continous sfx)
		add.w	d7,d7			; quadruple ID
		add.w	d7,d7
		movea.l	(a0,d7.w),a4		; get track ptr

		tst.b	(a0,d7.w)		; check SFX type
		bpl.s	.nocont			; if not continous, branch
		move.b	1(a4),dRAM+mContCtr.w	; save counter (num of channels)
		cmp.b	dRAM+mContLast.w,d0	; check if this is the same sfx as last time
		bne.s	.nocont			; if not, branch
		rts

.nocont		move.b	d0,dRAM+mContLast.w	; save as continous sfx (if it actually isn't, will stop the previous one)
		movea.l	a4,a1			; copy to a1

		moveq	#0,d7
		lea	dSFXoverList(pc),a3	; prapre SFX override list
		move.b	(a1)+,d5		; get tick multiplier
		move.b	(a1)+,d7		; get num of channels
		moveq	#cSizeSFX,d6		; prepare channel size

.loopSFX	moveq	#0,d3
		moveq	#1,d2			; delay PSG channels by 2 frames
		move.b	1(a1),d3		; get channel type
		move.b	d3,d4			; duplicate it
		bmi.s	.chPSG			; if is PSG, branch

		and.w	#ctPt2|$03,d3		; clear the bit DAC1 uses to identify being DAC
		subq.w	#2,d3			; skip FM1 and FM2
		add.w	d3,d3			; each entry is 1 word
		movea.w	(a3,d3.w),a5		; get channel RAM

		moveq	#1,d2			; delay FM and DAC channels by 1 frame
		bset	#cfbInt,(a5)		; override channel
		bra.s	.clearCh
; ===========================================================================

.chPSG		lsr.w	#4,d3			; align to correct offset
		movea.w	(a3,d3.w),a5		; get channel RAM
		bset	#cfbInt,(a5)		; override channel

		move.b	d4,d0			; copy channel type
		ori.b	#$1F,d0			; set volume to quiet
		move.b	d0,$C00011		; write to PSG

		cmpi.b	#ctPSG3,d4		; check if is PSG3
		bne.s	.clearCh		; branch if not
		bchg	#5,d0			; change to PSG4
		move.b	d0,$C00011		; mute PSG4

.clearCh	movea.w	dSFXoffList(pc,d3.w),a5	; get SFX channel
		movea.l	a5,a2			; copy ptr

	rept cSizeSFX/4
		clr.l	(a2)+
	endr

	if cSizeSFX&2
		clr.w	(a2)
	endif

		move.w	(a1)+,(a5)		; copy cFlags and cType
		move.b	d5,cTick(a5)		; get tick multiplier

		moveq	#0,d0
		move.w	(a1)+,d0		; get channel offset
		add.l	a4,d0			; add track position
		move.l	d0,cData(a5)		; set track ptr

		move.w	(a1)+,cPitch(a5)	; get pitch and volume
		move.b	d2,cDuration(a5)	; ensure this channel is ran next frame

		tst.b	d4			; check if we are on PSG
		bmi.s	.notFM			; if we are, branch
		move.b	#$C0,d1			; set panning to centre
		move.b	d1,cPanning(a5)		; ''

		moveq	#$FFFFFFB4,d0		; YM reg panning/LFO
		bsr.w	WriteChYM		; if not, branch

		cmp.w	#dRAM+mSFXDAC,a5	; check if DAC
		beq.s	.isDAC			; if so, branch

		moveq	#$F,d1			; instantly release
		moveq	#$FFFFFF80,d0		; YM release rate 1
		bsr.w	WriteChYM		;

		moveq	#$FFFFFF88,d0		; YM release rate 3
		bsr.w	WriteChYM		;

		moveq	#$FFFFFF84,d0		; YM release rate 2
		bsr.w	WriteChYM		;

		moveq	#$FFFFFF8C,d0		; YM release rate 4
		bsr.w	WriteChYM		;

		moveq	#$FFFFFF8C,d0		; YM release rate 4
		bsr.w	WriteChYM		;

		moveq	#$28,d0			; YM key off
		move.b	cType(a5),d1		; get type
		bsr.w	WriteYM_Pt1		; turn note off
		bra.s	.notFM

.isDAC		move.b	#ctDAC2,cType(a5)	; force to DAC2
.notFM		dbf	d7,.loopSFX		; loop for all SFX channels
		rts

; ===========================================================================
dSFXoffList:	dc.w dRAM+mSFXFM3	; FM3
		dc.w dRAM+mSFXDAC	; DAC1
		dc.w dRAM+mSFXFM4	; FM4
		dc.w dRAM+mSFXFM5	; FM5
		dc.w dRAM+mSFXPSG1	; PSG1
		dc.w dRAM+mSFXPSG2	; PSG2
		dc.w dRAM+mSFXPSG3	; PSG3
		dc.w dRAM+mSFXPSG3	; PSG4

dSFXoverList:	dc.w dRAM+mFM3		; FM3
		dc.w dRAM+mDAC2		; DAC1
		dc.w dRAM+mFM4		; FM4
		dc.w dRAM+mFM5		; FM5
		dc.w dRAM+mPSG1		; PSG1
		dc.w dRAM+mPSG2		; PSG2
		dc.w dRAM+mPSG3		; PSG3
		dc.w dRAM+mPSG3		; PSG4
; ===========================================================================

dPlaySnd_Comm:
		add.w	d7,d7			; quadruple ID
		add.w	d7,d7
		jmp	dPlaySnd_Comms-4(pc,d7.w)

; ===========================================================================
dPlaySnd_Comms:
		bra.w	dPlaySnd_Reset
		bra.w	dPlaySnd_Stop
		bra.w	dPlaySnd_ShoesOn
		bra.w	dPlaySnd_ShoesOff
		bra.w	dPlaySnd_ToWater
		bra.w	dPlaySnd_OutWater
		rts
; ===========================================================================

dMuteFM:
		moveq	#2,d3			; key off FM3/6
		moveq	#$28,d0			; key off

.noteoff	move.b	d3,d1			; copy key off to d1
		jsr	WriteYM_Pt1(pc)		; turn key off for FM3/2/1
		addq.b	#4,d1			; next set of channels
		jsr	WriteYM_Pt1(pc)		; turn key off for FM6/5/4
		dbf	d3,.noteoff		; loop for all channels

		moveq	#$40,d0			; prepare TL
		moveq	#$7F,d1			; prepare $7F (silence)
		moveq	#3-1,d4			; groups of channels
.chloop		moveq	#4-1,d3			; 4 operators for channel

.oploop		jsr	WriteYM_Pt1(pc)		; mute part 1 channels
		jsr	WriteYM_Pt2(pc)		; mute part 2 channels
		addq.w	#4,d0			; next operator
		dbf	d3,.oploop		; loop for all ops

		subi.b	#$F,d0			; go back to next channel
		dbf	d4,.chloop		; do for all channels
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Stop music
; ---------------------------------------------------------------------------

dPlaySnd_Stop:
		moveq	#$2B,d0			; FM6 mode (DAC or FM6)
		moveq	#$FFFFFF80,d1		; DAC
		jsr	WriteYM_Pt1(pc)

		moveq	#$27,d0			; FM3/6 frequency and timer settings
		moveq	#0,d1			; timers off
		jsr	WriteYM_Pt1(pc)

		lea	dRAM.w,a0		; prepare RAM to clear
		move.l	mCueYM(a0),d6		; get YM cue
		move.w	#mSize/4-1,d0		; prepare the size
		moveq	#0,d1			; prepare 0

.clear		move.l	d1,(a0)+		; clear a long
		dbf	d0,.clear		; clear entire sound driver

	if mSize&2
		move.w	d1,(a0)			; if there is an extra word, clear it too
	endif

		move.l	d6,dRAM+mCueYM.w	; set YM cue
		jsr	dMuteFM(pc)		; mute FM
		jsr	dMutePSG(pc)		; mute PSG
		jmp	dMuteDAC(pc)		; mute DAC
; ===========================================================================

dStopMusic:
		lea	dRAM.w,a0		; prepare RAM to clear
		move.w	mFlags(a0),d3		; get flags + priority
		move.l	mQueue(a0),d5		; get queue + PSG master vol
		move.l	mCueYM(a0),d6		; get YM cue
		movem.l	mComm(a0),d0-d2		; get communications bytes + fade

	rept	mSFXFM3/4
		clr.l	(a0)+			; clear a long
	endr

	if mSFXFM3&2
		clr.w	(a0)			; if there is an extra word, clear it too
	endif

		move.w	d3,dRAM+mFlags.w	; set flags + priority
		move.l	d5,dRAM+mQueue.w	; set queue + PSG master vol
		move.l	d6,dRAM+mCueYM.w	; set YM cue
		movem.l	d0-d2,dRAM+mComm.w	; set communications bytes + fade

		jsr	dMuteFM(pc)		; mute FM
		jsr	dMutePSG(pc)		; mute PSG
		jmp	dMuteDAC(pc)		; mute DAC

; ===========================================================================
; ---------------------------------------------------------------------------
; Speed	up music
; ---------------------------------------------------------------------------

dPlaySnd_ShoesOn:
		move.b	dRAM+mTempoSpeed.w,dRAM+mTempoTime.w
		move.b	dRAM+mTempoSpeed.w,dRAM+mTempo.w
		bset	#mfbSpeed,dRAM+mFlags.w
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Change music back to normal speed
; ---------------------------------------------------------------------------

dPlaySnd_Reset:
		bsr.s	dPlaySnd_OutWater

dPlaySnd_ShoesOff:
		move.b	dRAM+mTempoMain.w,dRAM+mTempoTime.w
		move.b	dRAM+mTempoMain.w,dRAM+mTempo.w
		bclr	#mfbSpeed,dRAM+mFlags.w
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Enable Underwater mode
; ---------------------------------------------------------------------------
dPlaySnd_ToWater:
		bset	#mfbWater,dRAM+mFlags.w
		jmp	dReqVolUpFM(pc)

; ===========================================================================
; ---------------------------------------------------------------------------
; Disable Underwater mode
; ---------------------------------------------------------------------------
dPlaySnd_OutWater:
		bclr	#mfbWater,dRAM+mFlags.w
		jmp	dReqVolUpFM(pc)

; ===========================================================================
; ---------------------------------------------------------------------------
; FM volume update routine
; ---------------------------------------------------------------------------

dUpdateVolFM:
		btst	#cfbInt,(a5)		; check if interrupted
		bne.s	locret_VolFM		; if is, branch
		move.b	cVolume(a5),d3		; get volume
		add.b	dRAM+mMasterVolFM.w,d3	; add master volume to volume
		bmi.s	locret_VolFM		; if negative, branch

		moveq	#0,d0
		move.b	cPatch(a5),d0		; get patch ID
		move.l	a6,a1			; a6 already contains patch table to use

	dCALC_PATCH
		move.b	(a1),d0			; get algorithm
		add.w	#PatchTL,a1		; go to the TL section

		lea	dOpTLFM(pc),a2
		moveq	#0,d6
		btst	#mfbWater,dRAM+mFlags.w	; test for "Underwater" flag
		beq.s	.uwdone			; skip if not set
		move.b	d0,d6			; copy operator mask
		and.w	#7,d6			; mask out all but the last 3 bits
		add.b	d6,d3			; add this to TL level: carrier
		move.b	d0,d6			; add this to TL level: modulator

.uwdone		moveq	#4-1,d5			; 4 operators
.tlloop		move.b	(a2)+,d0		; get next operator to write to
		move.b	(a1)+,d1		; get next TL value
		bpl.s	.noslot			; if not slot operator, branch

		add.b	d3,d1			; add actual volume to TL
		bmi.s	.slot			; if no overflow, branch
		moveq	#$7F,d1			; force max volume
		bra.s	.slot

.noslot		add.b	d6,d1			; add modulator modifier to TL
.slot		jsr	WriteChYM(pc)		; write volume
.ignore		dbf	d5,.tlloop		; loop for all TL values

locret_VolFM:
		rts

; ===========================================================================
dOpListYM:	dc.b $30, $38, $34, $3C		; Detune, Multiple
		dc.b $50, $58, $54, $5C		; Rate Scale, Attack Rate
		dc.b $60, $68, $64, $6C		; Decay 1 Rate
		dc.b $70, $78, $74, $7C		; Decay 2 Rate
		dc.b $80, $88, $84, $8C		; Decay 1 level, Release Rate
		dc.b $90, $98, $94, $9C		; SSG-EG
dOpTLFM:	dc.b $40, $48, $44, $4C		; Total Level
; ===========================================================================
; ---------------------------------------------------------------------------
; SMPS FM updating routine
; ---------------------------------------------------------------------------

dSMPSdoFMSFX:
		lea	VoiceBank(pc),a6	; get sfx patch address to a6
		moveq	#SFX_FM-1,d7		; prepare number of FM channels

dSMPSnextFMSFX:
		add.w	#cSizeSFX,a5		; go to next channel
		tst.b	(a5)			; check if running
		bpl.w	.noupdate2		; if not, branch
		subq.b	#1,cDuration(a5)	; sub 1 from note timer
		beq.w	.update			; if timed out, branch

	dPitchSlide 1
	dModulate dSMPSdoPSGSFX, dSMPSnextFMSFX, 1
		bsr.w	dUpdateFreqFM3

.next		bclr	#cfbVol,(a5)		; check if volume update is needed and clear bit
		beq.s	.noupdate2		; if not, branch
		jsr	dUpdateVolFM(pc)	; update volume

.noupdate2	dbf	d7,dSMPSnextFMSFX	; loop for all channels
		jmp	dSMPSdoPSGSFX(pc)	; end loop

.update		and.b	#~((1<<cfbRest))&$FF,(a5); stop resting and hold off
	dUpdate	.noupdate2
		jsr	dKeyOffFM2(pc)		; turn key off
		tst.b	d5			; check if note or duration
		bpl.s	.timer			; branch if timer only

		bsr.w	dGetFreqFM		; get frequency
		btst	#cfbPit,(a5)		; check if doing a pitch slide
		beq.s	.nopit			; if not, branch
		move.b	(a4)+,cDetune(a5)	; check next byte

.nopit		move.b	(a4)+,d5		; check next byte
		bpl.s	.timer			; if positive, process a tiemr too
		subq.w	#1,a4			; if not, then return back
		bra.s	.pcnote			; do some extra clearing

.timer		jsr	dCalcDuration(pc)	; get duration
.pcnote	dProcNote 1, 0				; process note
		bsr.w	dUpdateFreqFM
	dKeyOnFM 1

		bclr	#cfbVol,(a5)		; check if volume update is needed and clear bit
		beq.s	.noupdate		; if not, branch
		jsr	dUpdateVolFM(pc)	; update volume

.noupdate	dbf	d7,dSMPSnextFMSFX	; loop for all channels
		jmp	dSMPSdoPSGSFX(pc)	; end loop
; ===========================================================================

dSMPSdoFM:
		move.l	dRAM+mPatMus.w,a6	; get music patch address to a6
		moveq	#Mus_FM-1,d7		; prepare number of FM channels

dSMPSnextFM:
		add.w	#cSize,a5		; go to next channel
		tst.b	(a5)			; check if running
		bpl.w	.noupdate2		; if not, branch
		subq.b	#1,cDuration(a5)	; sub 1 from note timer
		beq.w	.update			; if timed out, branch

	dNoteToutFM.w
	dPitchSlide 1
	dModulate dSMPSdoPSG, dSMPSnextFM, 0
		bsr.w	dUpdateFreqFM2

.next		bclr	#cfbVol,(a5)		; check if volume update is needed and clear bit
		beq.s	.noupdate2		; if not, branch
		jsr	dUpdateVolFM(pc)	; update volume

.noupdate2	dbf	d7,dSMPSnextFM		; loop for all channels
		jmp	dSMPSdoPSG(pc)		; end loop

.update		and.b	#~((1<<cfbRest))&$FF,(a5); stop resting and hold off
	dUpdate	.noupdate2
		jsr	dKeyOffFM(pc)		; turn key off
		tst.b	d5			; check if note or duration
		bpl.s	.timer			; branch if timer only

		bsr.w	dGetFreqFM		; get frequency
		btst	#cfbPit,(a5)		; check if doing a pitch slide
		beq.s	.nopit			; if not, branch
		move.b	(a4)+,cDetune(a5)	; check next byte

.nopit		move.b	(a4)+,d5		; check next byte
		bpl.s	.timer			; if positive, process a tiemr too
		subq.w	#1,a4			; if not, then return back
		bra.s	.pcnote			; do some extra clearing

.timer		jsr	dCalcDuration(pc)	; get duration
.pcnote	dProcNote 0, 0				; process note
		bsr.s	dUpdateFreqFM
	dKeyOnFM
		bclr	#cfbVol,(a5)		; check if volume update is needed and clear bit
		beq.s	.noupdate		; if not, branch
		jsr	dUpdateVolFM(pc)	; update volume

.noupdate	dbf	d7,dSMPSnextFM		; loop for all channels
		jmp	dSMPSdoPSG(pc)		; end loop
; ===========================================================================

dUpdateFreqFM:
		btst	#cfbRest,(a5)		; check if resting
		bne.s	locret_UpdFreqFM	; if we are, never mind
		move.w	cFreq(a5),d6		; get frequency
		beq.s	dUpdFreqFMrest		; if 0, this is a rest note

		btst	#cfbMod,(a5)		; check if modulating
		beq.s	dUpdateFreqFM2		; if not, branch
		add.w	cModFreq(a5),d6		; add modulation frequency

dUpdateFreqFM2:
		btst	#cfbInt,(a5)		; is interrupted by SFX?
		bne.s	locret_UpdFreqFM	; if so, branch

dUpdateFreqFM3:
		move.b	cDetune(a5),d0		; get detune value
		ext.w	d0			; extend to word
		add.w	d0,d6			; add to get actual frequency

		move.w	d6,d1			; copy
		lsr.w	#8,d1			; get the high byte only
		moveq	#$FFFFFFA4,d0		; YM upper byte of frequency
		jsr	WriteChYM(pc)

		move.b	d6,d1			; copy lower byte of frequency
		move.b	#$FFFFFFA0,d0		; YM lower byte of frequency
		jmp	WriteChYM(pc)

dUpdFreqFMrest:
		bset	#cfbRest,(a5)		; set channel as resting

locret_UpdFreqFM:
		rts
; ===========================================================================

dGetFreqFM:
		subi.b	#$80,d5			; sub $80 (notes start on $80)
		bne.s	.norest			; if not rest, branch
		bset	#cfbRest,(a5)		; set as resting
		clr.w	cFreq(a5)		; clear frequency
		rts

.norest		add.b	cPitch(a5),d5		; add pitch offset
		andi.w	#$7F,d5			; keep within $80 notes
		add.w	d5,d5			; each entry is word

		lea	dFreqFM(pc),a0
		move.w	(a0,d5.w),d6		; get correct frequency
		move.w	d6,cFreq(a5)		; store it
		rts
; ===========================================================================

dKeyOffFM:
		btst	#cfbInt,(a5)		; check if overridden by sfx
		bne.s	locret_UpdFreqFM	; if so, do not note off

dKeyOffFM2:
		move.l	a4,d0			; check if soft (sHold)
		bmi.s	locret_UpdFreqFM	; if so, do not note off

		moveq	#$28,d0			; YM key on
		move.b	cType(a5),d1		; get type
		bra.w	WriteYM_Pt1		; turn note off
; ===========================================================================

dWriteYMchnInt:
		btst	#cfbInt,(a5)		; was the channel interrupted?
		bne.s	WriteYM_Pt1_rts		; if was, do not note on
; ===========================================================================

WriteChYM:
		btst	#ctbPt2,cType(a5)	; check if part 1 or 2
		bne.s	WriteChYM2		; if part 2, branch
		add.b	cType(a5),d0		; add channel type
; ===========================================================================

WriteYM_Pt1:
		movem.l	d2/a0,-(sp)		; store register data
		movea.l	dRAM+mCueYM.w,a0	; load Cue pointer
		moveq	#$00,d2			; prepare d2 for YM2612 port address ($4000 - $4001)

	StopZ802				; request Z80 stop "ON"
		move.b	d2,(a0)+		; write YM2612 port address
		move.b	d1,(a0)+		; write YM2612 data
		move.b	d0,(a0)+		; write YM2612 address
		st	(a0)			; set end
	StartZ80				; request Z80 stop "OFF"

		move.l	a0,dRAM+mCueYM.w	; update it
		movem.l	(sp)+,d2/a0		; restore register data

WriteYM_Pt1_rts:
		rts				; return

; ===========================================================================

WriteChYM2:
		move.b	cType(a5),d2		; get type
		bclr	#ctbPt2,d2		; clear part 2 marker
		add.b	d2,d0			; add to data
; ===========================================================================

WriteYM_Pt2:
		movem.l	d2/a0,-(sp)		; store register data
		movea.l	dRAM+mCueYM.w,a0	; load Cue pointer
		moveq	#$02,d2			; prepare d2 for YM2612 port address ($4000 - $4001)

	StopZ802				; request Z80 stop "ON"
		move.b	d2,(a0)+		; write YM2612 port address
		move.b	d1,(a0)+		; write YM2612 data
		move.b	d0,(a0)+		; write YM2612 address
		st	(a0)			; set end
	StartZ80				; request Z80 stop "OFF"

		move.l	a0,dRAM+mCueYM.w	; update it
		movem.l	(sp)+,d2/a0		; restore register data
		rts				; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Note to YM2612 FM frequency conversion table
; ---------------------------------------------------------------------------
;	dc.w   C     C#    D     Eb    E     F     F#    G     G#    A     Bb    B
dFreqFM:dc.w								       $025E; Octave-1 - (80 <- accessible via pitch alteration)
	dc.w $0284,$02AB,$02D3,$02FE,$032D,$035C,$038F,$03C5,$03FF,$043C,$047C,$0A5E; Octave 0 - (81 - 8C)
	dc.w $0A84,$0AAB,$0AD3,$0AFE,$0B2D,$0B5C,$0B8F,$0BC5,$0BFF,$0C3C,$0C7C,$125E; Octave 1 - (8D - 98)
	dc.w $1284,$12AB,$12D3,$12FE,$132D,$135C,$138F,$13C5,$13FF,$143C,$147C,$1A5E; Octave 2 - (99 - A4)
	dc.w $1A84,$1AAB,$1AD3,$1AFE,$1B2D,$1B5C,$1B8F,$1BC5,$1BFF,$1C3C,$1C7C,$225E; Octave 3 - (A5 - B0)
	dc.w $2284,$22AB,$22D3,$22FE,$232D,$235C,$238F,$23C5,$23FF,$243C,$247C,$2A5E; Octave 4 - (B1 - BC)
	dc.w $2A84,$2AAB,$2AD3,$2AFE,$2B2D,$2B5C,$2B8F,$2BC5,$2BFF,$2C3C,$2C7C,$325E; Octave 5 - (BD - C8)
	dc.w $3284,$32AB,$32D3,$32FE,$332D,$335C,$338F,$33C5,$33FF,$343C,$347C,$3A5E; Octave 6 - (c9 - D4)
	dc.w $3A84,$3AAB,$3AD3,$3AFE,$3B2D,$3B5C,$3B8F,$3BC5,$3BFF,$3C3C,$3C7C	    ; Octave 7 - (D5 - DF)
; ===========================================================================
; ---------------------------------------------------------------------------
; Dual PCM overflow table
; ---------------------------------------------------------------------------
	dc.b (-$18)&$FF		; FExx
	dc.b $18		; FFxx
dlOverflowDAC:
	dc.b $18		; 00xx
	dc.b ($18*2)&$FF	; 01xx
	dc.b ($18*3)&$FF	; 02xx
	dc.b ($18*4)&$FF	; 03xx
	dc.b ($18*5)&$FF	; 04xx
	dc.b ($18*6)&$FF	; 05xx
	dc.b ($18*7)&$FF	; 06xx
	dc.b ($18*8)&$FF	; 07xx
	dc.b ($18*9)&$FF	; 08xx
	dc.b ($18*$A)&$FF	; 09xx
	dc.b ($18*$B)&$FF	; 0Axx
	dc.b ($18*$C)&$FF	; 0Bxx
	dc.b ($18*$D)&$FF	; 0Cxx

	dc.b (-$18&$FFFF)>>8	; FExx
	dc.b $18>>8		; FFxx
dhOverflowDAC:
	dc.b $18>>8		; 00xx
	dc.b ($18*2)>>8		; 01xx
	dc.b ($18*3)>>8		; 02xx
	dc.b ($18*4)>>8		; 03xx
	dc.b ($18*5)>>8		; 04xx
	dc.b ($18*6)>>8		; 05xx
	dc.b ($18*7)>>8		; 06xx
	dc.b ($18*8)>>8		; 07xx
	dc.b ($18*9)>>8		; 08xx
	dc.b ($18*$A)>>8	; 09xx
	dc.b ($18*$B)>>8	; 0Axx
	dc.b ($18*$C)>>8	; 0Bxx
	dc.b ($18*$D)>>8	; 0Cxx
	even
; ---------------------------------------------------------------------------
; Note to Dual PCM frequency conversion table
; ---------------------------------------------------------------------------
;	dc.w   C     C#    D     Eb    E     F     F#    G     G#    A     Bb    B
dFreqDAC:dc.w								       $FF00
	dc.w $FF0F,$FF10,$FF11,$FF12,$FF13,$FF14,$FF16,$FF17,$FF19,$FF1B,$FF1D,$FF1F; Octave 0 - (81 - 8C)
        dc.w $FF21,$FF23,$FF25,$FF27,$FF29,$FF2B,$FF2E,$FF31,$FF34,$FF37,$FF3A,$FF3C; Octave 1 - (8D - 98)
        dc.w $FF40,$FF44,$FF48,$FF4C,$FF51,$FF56,$FF5A,$FF60,$FF66,$FF6C,$FF72,$FF7A; Octave 2 - (99 - A4)
        dc.w $FF80,$FF88,$FF90,$FF98,$FFA2,$FFAC,$FFB6,$FFC2,$FFCE,$FFDA,$FFE6,$FFF2; Octave 3 - (A5 - B0)
        dc.w $0000,$0010,$0021,$0032,$0044,$0056,$006B,$0084,$0098,$00B2,$00C8,$00E4; Octave 4 - (B1 - BC)
        dc.w $0104,$0120,$0140,$0162,$0186,$01AC,$01D4,$0200,$022C,$025C,$0290,$02C4; Octave 5 - (BD - C8)
        dc.w $0304,$0340,$0388,$03C8,$0410,$0458,$04A8,$04FC,$FEF2,$FEE6,$FEDA,$FECE; Octave 6 - (C9 - D0)
        dc.w $FEC2,$FEB6,$FEAC,$FEA2,$FE98,$FE90,$FE88,$FE80,$FE7A,$FE72,$FE6C,$FE66; Octave 7 - (D5 - DF)
; ===========================================================================
; ---------------------------------------------------------------------------
; NTSC to PAL tempo conversion LUT
; ---------------------------------------------------------------------------

dTempoPAL:
	dc.b $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
	dc.b $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $03, $04, $06
	dc.b $07, $08, $09, $0A, $0C, $0D, $0E, $0F, $10, $12, $13, $14, $15, $16, $18, $19
	dc.b $1A, $1B, $1C, $1E, $1F, $20, $21, $22, $24, $25, $26, $27, $28, $2A, $2B, $2C
	dc.b $2D, $2E, $30, $31, $32, $33, $34, $36, $37, $38, $39, $3A, $3C, $3D, $3E, $3F
	dc.b $40, $42, $43, $44, $45, $46, $48, $49, $4A, $4B, $4C, $4E, $4F, $50, $51, $52
	dc.b $54, $55, $56, $57, $58, $5A, $5B, $5C, $5D, $5E, $60, $61, $62, $63, $64, $66
	dc.b $67, $68, $69, $6A, $6C, $6D, $6E, $6F, $70, $72, $73, $74, $75, $76, $78, $79
	dc.b $7A, $7B, $7C, $7E, $7F, $80, $81, $82, $84, $85, $86, $87, $88, $8A, $8B, $8C
	dc.b $8D, $8E, $90, $91, $92, $93, $94, $96, $97, $98, $99, $9A, $9C, $9D, $9E, $9F
	dc.b $A0, $A2, $A3, $A4, $A5, $A6, $A8, $A9, $AA, $AB, $AC, $AE, $AF, $B0, $B1, $B2
	dc.b $B4, $B5, $B6, $B7, $B8, $BA, $BB, $BC, $BD, $BE, $C0, $C1, $C2, $C3, $C4, $C6
	dc.b $C7, $C8, $C9, $CA, $CC, $CD, $CE, $CF, $D0, $D2, $D3, $D4, $D5, $D6, $D8, $D9
	dc.b $DA, $DB, $DC, $DE, $DF, $E0, $E1, $E2, $E4, $E5, $E6, $E7, $E8, $EA, $EB, $EC
	dc.b $ED, $EE, $F0, $F1, $F2, $F3, $F4, $F6, $F7, $F8, $F9, $FA, $FC, $FD, $FE, $FF

; ===========================================================================
; ---------------------------------------------------------------------------
; Note to PSG frequency conversion table
; ---------------------------------------------------------------------------
;	dc.w	C     C#    D     Eb    E     F     F#    G     G#    A     Bb    B
dFreqPSG:dc.w $0356,$0326,$02F9,$02CE,$02A5,$0280,$025C,$023A,$021A,$01FB,$01DF,$01C4; Octave 3 - (81 - 8C)
	dc.w  $01AB,$0193,$017D,$0167,$0153,$0140,$012E,$011D,$010D,$00FE,$00EF,$00E2; Octave 4 - (8D - 98)
	dc.w  $00D6,$00C9,$00BE,$00B4,$00A9,$00A0,$0097,$008F,$0087,$007F,$0078,$0071; Octave 5 - (99 - A4)
	dc.w  $006B,$0065,$005F,$005A,$0055,$0050,$004B,$0047,$0043,$0040,$003C,$0039; Octave 6 - (A5 - B0)
	dc.w  $0036,$0033,$0030,$002D,$002B,$0028,$0026,$0024,$0022,$0020,$001F,$001D; Octave 7 - (B1 - BC)
	dc.w  $001B,$001A,$0018,$0017,$0016,$0015,$0013,$0012,$0011		     ; Notes (BD - C5)
	dc.w  $0000								     ; Note (C6)
; ===========================================================================

dMuteDAC:
	StopZ802
		lea	SampleList(pc),a0	; load stop sample address
		lea	$A00000+PCM1_Sample,a1	; MJ: load PCM 1 slot address
		move.b	(a0)+,(a1)+		; CHG: set address of sample
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	(a0)+,(a1)+		; CHG: set address of reverse sample
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	(a0)+,(a1)+		; CHG: set address of sample
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	(a0)+,(a1)+		; CHG: set address of reverse sample
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	#%11001010,$A00000+PCM1_NewRET; MJ: change "JR NZ" to "JR Z"

		lea	SampleList(pc),a0	; load stop sample address
		lea	$A00000+PCM2_Sample,a1	; MJ: load PCM 2 slot address
		move.b	(a0)+,(a1)+		; CHG: set address of sample
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	(a0)+,(a1)+		; CHG: set address of reverse sample
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	(a0)+,(a1)+		; CHG: set address of sample
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	(a0)+,(a1)+		; CHG: set address of reverse sample
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	(a0)+,(a1)+		; CHG: ''
		move.b	#%11001010,$A00000+PCM2_NewRET; MJ: change "JR NZ" to "JR Z"
	StartZ80
		rts
; ===========================================================================

dMutePSG:
		lea	$C00011,a0
		move.b	#ctPSG1|$1F,(a0)	; PSG1 volume to mute
		move.b	#ctPSG2|$1F,(a0)	; PSG2 volume to mute
		move.b	#ctPSG3|$1F,(a0)	; PSG3 volume to mute
		move.b	#ctPSG4|$1F,(a0)	; PSG4 volume to mute
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; SMPS PSG updating routines
; ---------------------------------------------------------------------------

dSMPSdoPSGSFX:
		moveq	#SFX_PSG-1,d7		; prepare number of PSG channels
		lea	dFreqPSG(pc),a6		; quick access here =)

dSMPSnextPSGSFX:
		add.w	#cSizeSFX,a5		; go to next channel
		tst.b	(a5)			; check if running
		bpl.s	.next			; if not, branch
		subq.b	#1,cDuration(a5)	; sub 1 from note timer
		beq.s	.update			; if timed out, branch

	dPitchSlide 0
	dModulate
.endm		bsr.w	dEnvelopePSG
		bsr.w	dUpdateFreqPSG3
.next		dbf	d7,dSMPSnextPSGSFX	; loop for all channels
		jmp	dSMPSend(pc)		; end loop

.update		and.b	#~((1<<cfbRest))&$FF,(a5); stop resting and hold off
	dUpdate	.next
		tst.b	d5			; check if note or duration
		bpl.s	.timer			; branch if timer only
	dGetFreqPSG				; get frequency

		btst	#cfbPit,(a5)		; check if doing a pitch slide
		beq.s	.nopit			; if not, branch
		move.b	(a4)+,cDetune(a5)	; check next byte

.nopit		move.b	(a4)+,d5		; check next byte
		bpl.s	.timer			; if positive, process a tiemr too
		subq.w	#1,a4			; if not, then return back
		bra.s	.pcnote			; do some extra clearing

.timer		jsr	dCalcDuration(pc)	; get duration
.pcnote	dProcNote 1, 1				; process note
		bsr.w	dUpdateFreqPSG
		bsr.w	dUpdateEnvPSG
		dbf	d7,dSMPSnextPSGSFX	; loop for all channels
; ===========================================================================

dSMPSend:
	StopZ802				; request Z80 stop on
		move.l	dRAM+mCueYM.w,a0	; get cue ptr
		st	(a0)			; set end
	StartZ80				; request Z80 stop off
		rts
; ===========================================================================

dSMPSdoPSG:
		moveq	#Mus_PSG-1,d7		; prepare number of PSG channels
		lea	dFreqPSG(pc),a6		; quick access here =)

dSMPSnextPSG:
		add.w	#cSize,a5		; go to next channel
		tst.b	(a5)			; check if running
		bpl.w	.next			; if not, branch
		subq.b	#1,cDuration(a5)	; sub 1 from note timer
		beq.w	.update			; if timed out, branch

	dNoteToutPSG
	dPitchSlide 0
	dModulate
.endm		bsr.w	dEnvelopePSG
		bsr.w	dUpdateFreqPSG2
.next		dbf	d7,dSMPSnextPSG		; loop for all channels
		jmp	dSMPSdoDACSFX(pc)	; end loop

.update		and.b	#~((1<<cfbRest))&$FF,(a5); stop resting and hold off
	dUpdate	.next
		tst.b	d5			; check if note or duration
		bpl.s	.timer			; branch if timer only
	dGetFreqPSG				; get frequency

		btst	#cfbPit,(a5)		; check if doing a pitch slide
		beq.s	.nopit			; if not, branch
		move.b	(a4)+,cDetune(a5)	; check next byte

.nopit		move.b	(a4)+,d5		; check next byte
		bpl.s	.timer			; if positive, process a tiemr too
		subq.w	#1,a4			; if not, then return back
		bra.s	.pcnote			; do some extra clearing

.timer		jsr	dCalcDuration(pc)	; get duration
.pcnote	dProcNote 0, 1				; process note
		bsr.s	dUpdateFreqPSG
		bsr.w	dUpdateEnvPSG
		dbf	d7,dSMPSnextPSG		; loop for all channels
		jmp	dSMPSdoDACSFX(pc)	; end loop
; ===========================================================================

dUpdateFreqPSG:
		move.w	cFreq(a5),d6		; get frequency
		bpl.s	dUpdateFreqPSG2		; if is not a rest, branch
		bset	#cfbRest,(a5)		; set channel to rest
		rts

dUpdateFreqPSG2:
		btst	#cfbInt,(a5)		; is channel interrupted?
		bne.s	locret_dUpdateFreqPSG	; if so, branch

dUpdateFreqPSG3:
		btst	#cfbRest,(a5)		; is channel resting
		bne.s	locret_dUpdateFreqPSG	; if so, branch

		move.b	cDetune(a5),d0		; get note displacement
		ext.w	d0			; extend to word
		add.w	d0,d6			; add it to frequency

		move.b	cType(a5),d0		; get channel type
		cmpi.b	#ctPSG4,d0		; check if we are on PSG4 mode
		bne.s	.notPSG4		; if not, branch
		moveq	#$FFFFFF00|ctPSG3,d0	; write to PSG3

.notPSG4	move.w	d6,d1			; copy frequency
		andi.b	#$F,d1			; get lowest nybble
		or.b	d1,d0			; or the channel to d1

		lsr.w	#4,d6			; skip the first nybble
	;	andi.b	#$3F,d6			; get remaining 6 bits (disabled because of the silly instashield SFX)
		move.b	d0,$C00011		; save frequency
		move.b	d6,$C00011		; ^

locret_dUpdateFreqPSG:
		rts
; ===========================================================================

dUpdateEnvPSG:
		move.b	cVolume(a5),d5		; get volume
		add.b	dRAM+mMasterVolPSG.w,d5	; add master volume
		moveq	#0,d0
		move.b	cPatch(a5),d0		; get patch ID
		beq.s	dUpdateVolPSG2		; if null, update volume
		bra.s	dUpdateEnvPSG2		; continue code below

dEnvelopePSG:
		moveq	#0,d0
		move.b	cPatch(a5),d0		; get patch ID
		beq.s	locret_UpdVolPSG	; if null, do not update
		move.b	cVolume(a5),d5		; get volume
		add.b	dRAM+mMasterVolPSG.w,d5	; add master volume

dUpdateEnvPSG2:
		lea	VolEnvs-4(pc),a0
		add.w	d0,d0
		add.w	d0,d0			; quadruple patch ID
		move.l	(a0,d0.w),a0		; get pointer
		moveq	#0,d1

dUpdateEnvPSG3:
		move.b	cEnvPos(a5),d1		; get envelope data
		move.b	(a0,d1.w),d0		; get next byte in sequence
		bmi.s	dEnvCommand		; if is a command, branch

		addq.b	#1,cEnvPos(a5)		; increase position
		add.b	d0,d5			; add volume from envelope to actual volume
; ===========================================================================

dUpdateVolPSG2:
		cmpi.b	#$F,d5			; check against max volume
		bls.s	dUpdateVolPSG		; if not max yet
		moveq	#$F,d5			; limit volume

dUpdateVolPSG:
		btst	#cfbRest,(a5)		; check if playing rest
		bne.s	locret_UpdVolPSG	; if are, branch
		btst	#cfbInt,(a5)		; check if interrupted by SFX
		bne.s	locret_UpdVolPSG	; if yes, branch
		tst.b	cData(a5)		; check if note is held
		bmi.s	dUpdVolPSGheld		; if is, branch

dUpdVolPSGset:
		or.b	cType(a5),d5		; or channel type
		addi.b	#$10,d5			; set volume bit
		move.b	d5,$C00011		; write command to PSG

locret_UpdVolPSG:
		rts
; ===========================================================================

dUpdVolPSGheld:
		tst.b	cNoteTimeMain(a5)	; is there any note stop timer?
		beq.s	dUpdVolPSGset		; if not, branch
		tst.b	cNoteTimeCur(a5)	; has stopped?
		bne.s	dUpdVolPSGset		; if not, branch
		rts
; ===========================================================================

dMutePSGmus:
		btst	#cfbInt,(a5)		; check if interrupted
		bne.s	locret_MutePSG		; if we are, branch

dMutePSGsfx:
		moveq	#$1F,d0			; mute volume
		or.b	cType(a5),d0		; or the channel type
		move.b	d0,$C00011		; write command to PSG

locret_MutePSG:
		rts
; ===========================================================================

dEnvCommand:
	; WARN; env ID must not be >$40 or this breaks
		jmp	.comm-$80(pc,d0.w)		; jump to appropriate handler

.comm		bra.s	.reset			; 80 - Loop back to beginning
		bra.s	.hold			; 81 - Hold the envelope at current level
		bra.s	.loop			; 82 - Go to position defined by the next byte
	;	bra.s	.stop			; 83 - Stop current note and envelope
; ===========================================================================

.stop		bset	#cfbRest,(a5)
		bra.s	dMutePSGmus
; ===========================================================================

.hold		subq.b	#1,cEnvPos(a5)
		rts
; ===========================================================================

.reset		clr.b	cEnvPos(a5)
		jmp	dUpdateEnvPSG3(pc)
; ===========================================================================

.loop		move.b	1(a0,d1.w),cEnvPos(a5)
		jmp	dUpdateEnvPSG3(pc)
; ===========================================================================
; The reason we use add.b instead of add.w, is to get rid of some bits that
; would make this kind of arbitary jumping way more complex than it needs to be.
; What do we win by doing this? Why, 8 cycles per command! Thats... Not a lot,
; but it may be helpful with speed anyway.
dCommands:
		add.b	d5,d5			; ($E0 * 2) & $FF = $C0
		add.b	d5,d5			; ($E0 * 4) & $FF = $80

		btst	#cfbCond,(a5)		; check condition
		bne.w	.falsecomm		; branch if false
		jmp	.comm-$80(pc,d5.w)	; jump to appropriate handler

; ===========================================================================
.comm	bra.w	dcPan		; E0 - Panning, AMS, FMS (PANAFMS - PAFMS_PAN)
	bra.w	dcsDetune	; E1 - Set channel frequency displacement to xx (DETUNE_SET)
	bra.w	dcsTransp	; E2 - Set channel pitch to xx (TRANSPOSE - TRNSP_SET)
	bra.w	dcaTransp	; E3 - Add xx to channel pitch (TRANSPOSE - TRNSP_ADD)
	bra.w	dcTimeout	; E4 - Stop note after xx frames (NOTE_STOP - NSTOP_NORMAL
	bra.w	dcsTmulCh	; E5 - Set channel tick multiplier to xx (TICK_MULT - TMULT_CUR)
	bra.w	dcsTmul		; E6 - Set global tick multiplier to xx (TICK_MULT - TMULT_ALL)
	bra.w	dcHold		; E7 - Do not allow note on/off for next note (HOLD)
	bra.w	dcaTempo	; E8 - Add xx to music tempo (TEMPO - TEMPO_ADD)
	bra.w	dcsTempo	; E9 - Set music tempo to xx (TEMPO - TEMPO_SET)
	bra.w	dcVoice		; EA - Set patch/voice/sample to xx (INSTRUMENT - INS_N_FM / INS_N_PSG / INS_N_DAC)
	bra.w	dcModOn		; EB - Turn on Modulation (MOD_SET - MODS_ON)
	bra.w	dcModOff	; EC - Turn off Modulation (MOD_SET - MODS_OFF)
	bra.w	dcaVolume	; ED - Add xx to channel volume (VOLUME - VOL_NN_FM / VOL_NN_PSG)
	bra.w	dcsVolume	; EE - Set channel volume to xx (VOLUME - VOL_ABS)
	bra.w	dcsLFO		; EF - Set LFO (SET_LFO - LFO_AMSEN)
	bra.w	dcMod68K	; F0 - Modulation (MOD_SETUP)
	bra.w	dcsFreq		; F1 - Set channel frequency to xxxx (CHFREQ_SET)
	bra.w	dcsModFreq	; F2 - Set channel modulation frequency to xxxx (CHFREQ_SET)
	bra.w	dcNoisePSG	; F3 - PSG waveform to xx (PSG_NOISE - PNOIS_SET)
	bra.w	dcCont		; F4 - Do a continuous SFX loop (CONT_SFX)
	bra.w	dcStop		; F5 - End of channel (TRK_END - TEND_STD)
	bra.w	dcJump		; F6 - Jump to xxxx (GOTO)
	bra.w	dcLoop		; F7 - Loop back to zzzz yy times, xx being the loop index for loop recursion fixing (LOOP)
	bra.w	dcCall		; F8 - Call pattern at xxxx, saving return point (GOSUB)
	bra.w	dcReturn	; F9 - Return (RETURN)
	bra.w	dcsComm		; FA - Set communications byte yy to xx (SET_COMM - SPECIAL)
	bra.w	dcCond		; FB - Get communications byte y, and compare zz with it using condition x (COMM_CONDITION)
	bra.w	dcResetCond	; FC - Reset condition (COND_RESET)
	bra.w	dcSound		; FD - Play another music/sfx (SND_CMD)
	bra.w	dcYM		; FE - YM command (YMCMD)
				; FF - META

.metacall	move.b	(a4)+,d5		; get next byte
		add.w	d5,d5
		add.w	d5,d5			; quadruple
		jmp	.meta(pc,d5.w)		; run code
.falsecomm	jmp	.false-$80(pc,d5.w)	; jump to appropriate handler

.meta	bra.w	dcWriteDAC1	; FF 00 - Play sample xx on DAC1 (PLAY_DAC - DAC1)
	bra.w	dcWriteDAC2	; FF 01 - Play sample xx on DAC2 (PLAY_DAC - DAC2)
	bra.w	dcSampDAC	; FF 02 - Use sample DAC mode (DAC_MODE - DACM_SAMP)
	bra.w	dcPitchDAC	; FF 03 - Use pitch DAC mode (DAC_MODE - DACM_NOTE)
	bra.w	dcSpRev		; FF 04 - Increment spindash rev counter
	bra.w	dcSpReset	; FF 05 - Reset spindash rev counter
	bra.w	dcaTempoPAL	; FF 06 - Add xx to music tempo if in PAL region (TEMPO - TEMPO_ADD_PAL)
	bra.w	dcaTempoNTSC	; FF 07 - Add xx to music tempo if in NTSC region (TEMPO - TEMPO_ADD_NTSC)
	bra.w	dcCondReg	; FF 08 - Get RAM address pointer offset by y, and compare zz with it using condition x (COMM_CONDITION_EXTRA)
	bra.w	dcsPitOff	; FF 09 - Set Pitch Slide mode off (PITCH_SLIDE - PITSLD_OFF)
	bra.w	dcsPitOn	; FF 0A - Set Pitch Slide mode on (PITCH_SLIDE - PITSLD_ON)
	bra.w	dDoPauseIn	; FF 0B
	bra.w	dDoPauseout	; FF 0C
	bra.w	dcaDetune	; FF 0D - Add xx to channel frequency displacement (DETUNE)

.false	bra.w	dcPan		; E0 - Panning, AMS, FMS (PANAFMS - PAFMS_PAN)
	bra.w	dcsDetune	; E1 - Add xx to channel frequency displacement (DETUNE)
	bra.w	dcsTransp	; E2 - Set channel pitch to xx (TRANSPOSE - TRNSP_SET)
	bra.w	dcaTransp	; E3 - Add xx to channel pitch (TRANSPOSE - TRNSP_ADD)
	bra.w	dcTimeout	; E4 - Stop note after xx frames (NOTE_STOP - NSTOP_NORMAL
	bra.w	dcsTmulCh	; E5 - Set channel tick multiplier to xx (TICK_MULT - TMULT_CUR)
	bra.w	dcsTmul		; E6 - Set global tick multiplier to xx (TICK_MULT - TMULT_ALL)
	bra.w	dcHold		; E7 - Do not allow note on/off for next note (HOLD)
	bra.w	dcaTempo	; E8 - Add xx to music tempo (TEMPO - TEMPO_ADD)
	bra.w	dcsTempo	; E9 - Set music tempo to xx (TEMPO - TEMPO_SET)
	bra.w	dcVoice		; EA - Set patch/voice/sample to xx (INSTRUMENT - INS_N_FM / INS_N_PSG / INS_N_DAC)
	rts			; EB - Turn on Modulation (MOD_SET - MODS_ON)
	rts
	rts			; EC - Turn off Modulation (MOD_SET - MODS_OFF)
	rts
	bra.w	dcaVolume	; ED - Add xx to channel volume (VOLUME - VOL_NN_FM / VOL_NN_PSG)
	bra.w	dcsVolume	; EE - Set channel volume to xx (VOLUME - VOL_ABS)
	bra.w	dcsLFO		; EF - Set LFO (SET_LFO - LFO_AMSEN)
	bra.w	dcMod68K	; F0 - Modulation (MOD_SETUP)
	addq.w	#2,a4
	rts			; F1 - Set channel frequency to xxxx (CHFREQ_SET)
	addq.w	#2,a4
	rts			; F2 - Set channel modulation frequency to xxxx (CHFREQ_SET)
	bra.w	dcNoisePSG	; F3 - PSG waveform to xx (PSG_NOISE - PNOIS_SET)
	bra.w	dcCont		; F4 - Do a continuous SFX loop (CONT_SFX)
	rts
	rts			; F5 - End of channel (TRK_END - TEND_STD)
	addq.w	#2,a4
	rts			; F6 - Jump to xxxx (GOTO)
	addq.w	#4,a4
	rts			; F7 - Loop back to zzzz yy times, xx being the loop index for loop recursion fixing (LOOP)
	addq.w	#2,a4
	rts			; F8 - Call pattern at xxxx, saving return point (GOSUB)
	rts
	rts			; F9 - Return (RETURN)
	bra.w	dcsComm		; FA - Set communications byte yy to xx (SET_COMM - SPECIAL)
	bra.w	dcCond		; FB - Get communications byte y, and compare zz with it using condition x (COMM_CONDITION)
	bra.w	dcResetCond	; FC - Reset condition (COND_RESET)
	bra.w	dcSound		; FD - Play another music/sfx (SND_CMD)
	bra.w	dcYM		; E3 - YM command (YMCMD)
	bra.w	.metacall	; FF - META
; ===========================================================================

dcWriteDAC1:	; WARN: Unsafe method! If tracker is playing DAC1, will override it,
		; and DAC1 will in turn override on next note-on!
		moveq	#0,d0
		move.b	(a4)+,d0		; get note to write
		jmp	dNoteWriteDAC1(pc)	; note-on

dcWriteDAC2:	; WARN: Unsafe method! If tracker is playing DAC2, will override it,
		; and DAC2 will in turn override on next note-on!
		moveq	#0,d0
		move.b	(a4)+,d0		; get note to write
		jmp	dNoteWriteDAC2(pc)	; note-on
; ===========================================================================

dcSpRev:
		move.b	dRAM+mSpindash.w,d0	; get spindash rev counter
		addq.b	#1,dRAM+mSpindash.w	; increment rev counter
		add.b	d0,cPitch(a5)		; add to our pitch

		cmp.b	#$C-1,d0		; check against max
		blo.s	.ok			; if not hitting it, branch
		subq.b	#1,dRAM+mSpindash.w	; keep at max of $C
.ok		rts
; ===========================================================================

dcSpReset:
		clr.b	dRAM+mSpindash.w	; reset spindash counter
		rts
; ===========================================================================

dcPan:
		moveq	#$37,d1			; prepare clearing panning bits
		and.b	cPanning(a5),d1		; get LFO settings only
		or.b	(a4)+,d1		; or panning param
		move.b	d1,cPanning(a5)		; save panning value

		moveq	#$FFFFFFB4,d0		; YM reg panning/LFO
		btst	#ctbDAC,cType(a5)	; check if this is a DAC channel
		beq.w	dWriteYMchnInt		; if not, branch

		moveq	#$FFFFFFB4+ctFM36,d0	; pan DAC ch
		jmp	WriteYM_Pt2(pc)
; ===========================================================================

dcaDetune:
		move.b	(a4)+,d0		; get displacement
		add.b	d0,cDetune(a5)		; add to detune value
		rts

dcsDetune:
		move.b	(a4)+,cDetune(a5)	; set to detune value
		rts
; ===========================================================================

dcSampDAC:
		bclr	#cfbMode,(a5)		; sample mode
		rts
; ===========================================================================

dcPitchDAC:
		bset	#cfbMode,(a5)		; pitch mode
		rts
; ===========================================================================

dcsTmulCh:
		move.b	(a4)+,cTick(a5)
		rts
; ===========================================================================

dcsPitOn:
		bset	#cfbPit,(a5)
		rts
; ===========================================================================

dcsPitOff:
		bclr	#cfbPit,(a5)
		clr.b	cDetune(a5)
		clr.b	cData(a5)
		rts
; ===========================================================================

dcsTmul:
		lea	dRAM+mDAC1.w,a0		; get DAC1 to a0
		move.b	(a4)+,d0		; get tick multiplier
		moveq	#cSize,d1		; prepare channel size
		moveq	#Mus_Ch-1,d2		; prepare channel number

.next		move.b	d0,cTick(a0)		; set tick multiplier
		adda.w	d1,a0			; go to next channel
		dbf	d2,.next		; loop for all channels
		rts
; ===========================================================================

dcHold:
		add.l	#1<<cfbHold,a4		; flip the highest bit. Will always set on FM or PSG
		rts				; unless you do two of them in the same note
; ===========================================================================

dcTimeout:
		move.b	(a4),cNoteTimeMain(a5)
		move.b	(a4)+,cNoteTimeCur(a5)
		rts
; ===========================================================================

dcaTransp:
		move.b	(a4)+,d0		; get displacement
		add.b	d0,cPitch(a5)		; add to pitch
		rts

dcsTransp:
		move.b	(a4)+,cPitch(a5)	; set pitch
		rts
; ===========================================================================

dcsTempo:
		moveq	#0,d0
		move.b	(a4)+,d0
		btst	#mfbPAL,dRAM+mFlags.w	; check if PAL mode
		beq.s	.set			; if not, branch

		lea	dTempoPAL(pc),a1	; grab the tempo PAL conversion table to a1
		move.b	(a1,d0.w),dRAM+mTempo.w	; convert and save tempo
		rts

.set		move.b	d0,dRAM+mTempo.w	; set tempo only
		rts

dcaTempoNTSC:
		btst	#mfbPAL,dRAM+mFlags.w	; check if PAL mode
		beq.s	dcaTempo		; if not, branch
		addq.w	#1,a4			; skip over param
		rts

dcaTempoPAL:
		btst	#mfbPAL,dRAM+mFlags.w	; check if PAL mode
		bne.s	dcaTempo		; if is, branch
		addq.w	#1,a4			; skip over param
		rts

dcaTempo:
		move.b	(a4)+,d0		; get tempo
		add.b	d0,dRAM+mTempo.w	; add to tempo
		rts
; ===========================================================================

dcNoisePSG:
		move.b	#ctPSG4,cType(a5)	; make PSG3 control PSG4
		move.b	(a4),cStatPSG4(a5)	; save PSG4 status
		move.b	(a4)+,$C00011		; send to PSG

locret_72E1E:
		rts
; ===========================================================================

dcModOn:
		bset	#cfbMod,(a5)
		rts
; ===========================================================================

dcModOff:
		bclr	#cfbMod,(a5)
		rts
; ===========================================================================

dcSound:
		move.b	(a4)+,dRAM+mQueue.w	; set sound ID

Return_dcSound:
		rts
; ===========================================================================

dcYM:
		move.b	(a4)+,d0		; get register
		move.b	(a4)+,d1		; get value
		btst	#cfbInt,(a5)		; channel overridden?
		bne.s	Return_dcSound		; if so, don't write

		cmp.b	#$30,d0			; register 00-2F?
		blo.w	WriteYM_Pt1		; global registers - write directly to YM port 1
		move.b	d0,d2
		sub.b	#$A8,d2
		cmp.b	#$08,d2			; register A8-AF?
		blo.w	WriteYM_Pt1		; Special FM3 frequencies - no channel
		jmp	WriteChYM(pc)		; write the register (with respective channel bits set)
; ===========================================================================

dcsModFreq:
		move.b	(a4)+,cModFreq(a5)
		move.b	(a4)+,cModFreq+1(a5)
		rts

dcsFreq:
		move.b	(a4)+,cFreq(a5)
		move.b	(a4)+,cFreq+1(a5)
		btst	#ctbDAC,cType(a5)	; check if DAC channel
		bne.s	.rts			; if set, branch

		bclr	#cfbRest,(a5)		; clear resting flag
		tst.w	cFreq(a5)		; check if frequency is 0
		bne.s	.rts			; if not, branch
		bset	#cfbRest,(a5)		; set resting flag
.rts		rts
; ===========================================================================

dcCont:
		subq.b	#1,dRAM+mContCtr.w	; sub 1 from counter
		bpl.s	dcJump			; if positive, keep looping
		clr.b	dRAM+mContLast.w	; clear last continous sfx
		addq.w	#2,a4			; skip over param
		rts
; ===========================================================================

dcCall:
		moveq	#0,d0
		move.b	cStack(a5),d0		; get stack address
		subq.b	#4,d0			; allocate some space here
		move.l	a4,(a5,d0.w)		; save this address there (not return address)
		move.b	d0,cStack(a5)		; save stack address
; ===========================================================================

dcJump:
	dREAD_WORD a4, d0			; read a word into d0
		adda.w	d0,a4			; add offset in d0 to position
		rts
; ===========================================================================

dcLoop:
		moveq	#0,d0
		move.b	(a4)+,d0		; get loop index

		tst.b	cLoop(a5,d0.w)		; check loop count
		bne.s	.loopok			; if not 0, branch
		move.b	2(a4),cLoop(a5,d0.w)	; reset loop count

.loopok		subq.b	#1,cLoop(a5,d0.w)	; sub 1 from loop count
		bne.s	dcJump			; if not 0, jump
		addq.w	#3,a4			; else skip the jump and loop count
		rts
; ===========================================================================

dcMod68K:
		bset	#cfbMod,(a5)		; enable modulation
		move.l	a4,cMod(a5)		; set offset for modulation
		move.b	(a4)+,cModDelay(a5)	; set delay
		move.b	(a4)+,cModSpeed(a5)	; set speed
		move.b	(a4)+,cModStep(a5)	; set step

		move.b	(a4)+,d0		; get step count
		lsr.b	#1,d0			; halve it
		move.b	d0,cModCount(a5)	; save it
		clr.w	cModFreq(a5)		; clear frequency
		rts
; ===========================================================================

dcReturn:
		moveq	#0,d0
		move.b	cStack(a5),d0		; get stack offset
		movea.l	(a5,d0.w),a4		; get new address to return to
		addq.w	#2,a4			; skip over address param
		addq.b	#4,d0			; fix stack address
		move.b	d0,cStack(a5)		; and save it

locret_Return:
		rts
; ===========================================================================

dcVoice:
		moveq	#0,d0
		move.b	(a4)+,d0		; get patch ID
		move.b	d0,cPatch(a5)		; save it

		tst.b	cType(a5)		; check if this is a PSG channel
		bmi.s	locret_Return		; if is, branch
		btst	#ctbDAC,cType(a5)	; check if DAC channel
		bne.s	locret_Return		; if is, branch

		btst	#cfbInt,(a5)		; check if interrupted
		bne.s	locret_Return		; if is, branch
		move.l	a6,a1			; a6 already contains patch table to use
; ===========================================================================

dUpdatePatchFM:
	dCALC_PATCH

		sub.w	#(PatchRegs+1)*2,sp	; advance sp
		move.w	sp,a3			; copy sp to a3

		move.b	(a1)+,d4		; get feedback/algorithm
		move.b	d4,(a3)+		; copy to temp buffer
		move.b	#$B0,(a3)+		; YM algorithm

		lea	dOpListYM(pc),a2
	rept PatchRegs-5
		move.b	(a1)+,(a3)+		; get next value
		move.b	(a2)+,(a3)+		; get next operator
	endr

		move.b	cVolume(a5),d3		; get volume
		add.b	dRAM+mMasterVolFM.w,d3	; add master volume to volume
		moveq	#0,d6

		btst	#mfbWater,dRAM+mFlags.w	; test for "Underwater" flag
		beq.s	.uwdone			; skip if not set
		move.b	d4,d6			; copy operator mask
		and.w	#7,d6			; mask out all but the last 3 bits
		add.b	d6,d3			; add this to TL level: carrier
		move.b	d4,d6			; add this to TL level: modulator
.uwdone		moveq	#4-1,d5			; number of TL operators

.tlloop		move.b	(a1)+,d1		; get total level from patch
		bpl.s	.noslot			; if not slot operator, branch
		add.b	d3,d1			; add actual volume to TL
		bmi.s	.slot			; if volume is ok, branch
		moveq	#$7F,d1			; force to max tl
		bra.s	.slot

.noslot		add.b	d6,d1			; add modulator modifier to TL
.slot		move.b	d1,(a3)+		; save TL value
		move.b	(a2)+,(a3)+		; load total level address
		dbf	d5,.tlloop		; loop for all operators

		bclr	#cfbVol,(a5)		; clear volume update flag
		move.b	cPanning(a5),(a3)+	;
		move.b	#$B4,(a3)+		; YM panning/LFO

		moveq	#0,d2			; write to YM Pt1
		move.b	cType(a5),d3		; get channel type to d3
		btst	#ctbPt2,d3		; check if part 1 or 2
		beq.s	.ptok			; if part 1, branch
		and.b	#3,d3			; aget only channel position
		moveq	#2,d2			; write to YM Pt2

.ptok		move.l	dRAM+mCueYM.w,a0	; load Cue pointer
		move.w	sp,a3			; copy sp to a3
		moveq	#PatchRegs,d1		; set loop counter
	StopZ802

.write		move.b	d2,(a0)+		; write the YM port to access
		move.b	(a3)+,(a0)+		; write YM data

		move.b	(a3)+,d0		; get YM address
		or.b	d3,d0			; or the channel offset
		move.b	d0,(a0)+		; write YM address
		dbf	d1,.write		; write all registers
		st	(a0)			; set end
	StartZ80

		move.l	a0,dRAM+mCueYM.w	; update it
		add.w	#(PatchRegs+1)*2,sp	; reset sp
		rts
; ===========================================================================

dcsVolume:
		move.b	(a4)+,cVolume(a5)	; set the volume
		bset	#cfbVol,(a5)		; set volume update flag
		rts

dcaVolume:
		move.b	(a4)+,d0		; get displacement
		add.b	d0,cVolume(a5)		; add to volume
		bset	#cfbVol,(a5)		; set volume update flag
		rts
; ===========================================================================

dcStop:
		and.b	#(~((1<<cfbrun)))&$FF,(a5); stop running and clear hold flag
		tst.b	cType(a5)		; check if PSG
		bmi.s	.mutePSG		; if is, branchh

		btst	#ctbDAC,cType(a5)	; check if running DAC
		bne.s	.cont			; if we are, do not note off
		jsr	dKeyOffFM(pc)		; turn key off
		bra.s	.cont
; ===========================================================================

.mutePSG	jsr	dMutePSGmus(pc)		; mute PSG
.cont		cmpa.w	#mSFXFM3,a5		; check if this is SFX
		blo.s	.exit			; if it is not, branch

		lea	dSFXoverList(pc),a0
		moveq	#0,d3
		move.b	cType(a5),d3		; get channel type
		bmi.s	.psg			; branch if this is a PSG channel
		move.w	a5,-(sp)		; copy channel ptr

		cmp.b	#ctDAC2,d3		; HACK WARNING!!!!
		bne.s	.notDAC
		lea	dRAM+mDAC2.w,a5		; get DAC2
		bset	#cfbVol,(a5)		; update volume
		bra.s	.dacdone

.notDAC		and.w	#ctPt2|$03,d3		; clear the bit DAC1 uses to identify being DAC
		subq.w	#2,d3			; skip FM1 and FM2
		add.w	d3,d3			; each entry is 1 word
		movea.w	(a0,d3.w),a5		; get channel RAM

.dacdone	tst.b	(a5)			; check if it is running
		bpl.s	.fixch			; if not, branch

		bclr	#cfbInt,(a5)		; channel is not interrupted anymore
		btst	#ctbDAC,cType(a5)	; check if running DAC
		bne.s	.fixch			; if we are, do not note off

		move.l	dRAM+mPatMus.w,a1	; get patch table to a1
		bset	#cfbRest,(a5)		; set channel as resting
		move.b	cPatch(a5),d0		; get patch ID
		jsr	dUpdatePatchFM(pc)	; update patch stuff

.fixch		move.w	(sp)+,a5		; return to correct channel now
.exit		addq.l	#2,(sp)			; go to next channel
		rts

.psg		lsr.b	#4,d3			; shift PSG channel bits in place
		movea.w	(a0,d3.w),a0		; get channel RAM
		bclr	#cfbInt,(a0)		; channel is not interrupted anymore
		bset	#cfbRest,(a0)		; set channel as resting

		cmp.b	#ctPSG4,cType(a0)	; check if this is PSG4
		bne.s	.nonoise		; if not, skip
		move.b	cStatPSG4(a0),$C00011	; else update PSG4

.nonoise	addq.l	#2,(sp)			; go to next channel
		rts
; ===========================================================================

dcsLFO:
		moveq	#0,d0
		move.b	cPatch(a5),d0		; get patch ID
		move.l	a6,a1			; copy voice pointer

	dCALC_PATCH 9
		move.b	(a4),d3			; get operators we want to enable LFO for
		lea	AMSEn_Ops(pc),a2	; get operator list
		moveq	#4-1,d6			; 4 operators in total

.decayloop	move.b	(a1)+,d1		; get next decay value
		move.b	(a2)+,d0		; get the operator to use

		btst	#7,d3			; check if LFO is enabled
		beq.s	.noLFO			; if not, skip
		bset	#7,d1			; enable LFO
		jsr	WriteChYM(pc)		; write to YM

.noLFO		add.b	d3,d3			; eat msb
		dbf	d6,.decayloop		; loop for all decay rates

		move.b	(a4)+,d1		; get the LFO setting
		moveq	#$22,d0			; YM LFO setting
		jsr	WriteYM_Pt1(pc)

		move.b	cPanning(a5),d1		; get panning flag
		andi.b	#$C0,d1			; get only panning bits
		or.b	(a4)+,d1		; get AMS/FMS
		move.b	d1,cPanning(a5)		; save panning

		moveq	#$FFFFFFB4,d0		; YM reg panning/LFO
		jmp	dWriteYMchnInt(pc)

; ---------------------------------------------------------------------------
AMSEn_Ops:	dc.b $60, $68, $64, $6C
; ===========================================================================

dcResetCond:
		bclr	#cfbCond,(a5)		; clear condition
		rts
; ===========================================================================

dcsComm:
		lea	dRAM+mComm.w,a0		; get communications bytes to a0
		moveq	#0,d0
		move.b	(a4)+,d0		; get the flag to use
		move.b	(a4)+,(a0,d0.w)		; save to communications flag
		rts

; ==========================================================================
dcCondRegTable:
	dc.w v_megadrive, dRAM+mFlags		; 0
	dc.w v_air, dRAM+mTempoSpeed		; 2
; ==========================================================================

dcCondReg:
		move.b	(a4)+,d0		; get condition
		move.b	d0,d1			; copy to d1

		and.w	#$F,d0			; get flag only
		add.w	d0,d0			; double d0 for index
		move.w	dcCondRegTable(pc,d0.w),a1; get RAM addr
		move.b	(a1),d0			; read the byte
		bra.s	dcCondCom

dcCond:
		lea	dRAM+mComm.w,a0		; get communications bytes to a0
		move.b	(a4)+,d0		; get condition + number
		move.b	d0,d1			; copy to d1
		and.w	#$F,d0			; get flag only
		move.b	(a0,d0.w),d0		; get value in communications flag to d0

dcCondCom:
		bclr	#cfbCond,(a5)		; set to true
		and.w	#$F0,d1			; get condition only
		lsr.w	#2,d1			; shift 2 bits down (multiple of 4)
		cmp.b	(a4)+,d0		; check the next flag
		jmp	.cond(pc,d1.w)		; then jump to the condition code

; ==========================================================================
.c	macro x
	\x	.false
	rts
     endm

.false		bset	#cfbCond,(a5)		; set to false
.cond	rts		; T
	rts
	.c bra.s	; F
	.c bls.s	; HI
	.c bhi.s	; LS
	.c blo.s	; HS/CC
	.c bhs.s	; LO/CS
	.c beq.s	; NE
	.c bne.s	; EQ
	.c bvs.s	; VC
	.c bvc.s	; VS
	.c bmi.s	; PL
	.c bpl.s	; MI
	.c blt.s	; GE
	.c bge.s	; LT
	.c ble.s	; GT
	.c bgt.s	; LE
; ===========================================================================
	opt oz-				; disable zero-offset optimization
__sfx =		SFXoff
SoundIndex:
		ptrSFX

__mus =		MusOff
MusicIndex:
	ptrMusic GraveYard, $20, Pray, $0B, FishBowl, $1B, Circus, $24
	ptrMusic ActClear, $30, Smiling, $25, GameOver, $04, Egor, $28
	ptrMusic Street, $02, DIS, $28

; ===========================================================================
__samp =	$80
SampleList:
	zdata $0000, Stop, $01		; 80 (THIS IS A REST NOTE, DO NOT EDIT...)
	zdata $0000, Kick, $00		; 81 - Kick
	zdata $0000, LowKick, $00	; 81 - Low Kick
	zdata $0000, Snare, $00		; 82 - Snare
	zdata $0000, Clap, $00		; 83 - Clap
	zdata $0080, Tom, $00		; 84 - High Tom
	zdata $0000, Tom, $00		; 85 - Mid Tom
	zdata $FFC0, Tom, $00		; 86 - Low Tom
	zdata $FFC0, Drum3D, $00	; 87 - Sonic 3D drum high
	zdata $FFA0, Drum3D, $00	; 88 - Sonic 3D drum low
	zdata $0000, Life, $00		; 89 - Extra Life
	zdata $0000, Hidd, $00		; 8A - Hidden Point sfx
	zdata $0000, Hidd, $00	; 8B - G-man is a douche

	zdata $0000, kick_sva, $00	; 8C - Kick
	zdata $0000, snare_sva, $00	; 8D - Snare
	zdata $0000, CRASH, $00		; 8E - CRASH
	zdata $0000, LowSnare, $00	; 8F - Low Snare
	zdata $0000, HatCl, $00		; 90 - Closed Hat
	zdata $0000, HatOp, $00		; 91 - Opened Hat

	zdata $0000, Ree5, $00		; 92 - Shoe Ree's 1
	zdata $0000, Ree2, $00		; 93 - Shoe Ree's 2
	zdata $0000, Ree3, $00		; 94 - Shoe Ree's 3
	zdata $0000, Ree4, $00		; 95 - Shoe Ree's 4
	zdata $0000, Bye, $00		; 97 - Shoe Bye

	include "sound/Patches.asm"	; include universal patch bank
; ---------------------------------------------------------------------------
; PSG instruments used in music
; ---------------------------------------------------------------------------
VolEnvs:	dc.l VolEnv01, VolEnv02, VolEnv03, VolEnv04
		dc.l VolEnv05, VolEnv06, VolEnv07, VolEnv08
		dc.l VolEnv09, VolEnv0A, VolEnv0B, VolEnv0C
		dc.l VolEnv0D, VolEnv0E, VolEnv0F, VolEnv10
		dc.l VolEnv11, VolEnv12, VolEnv13, VolEnv14
		dc.l VolEnv15, VolEnv16, VolEnv17, VolEnv18
		dc.l VolEnv19, VolEnv1A, VolEnv1B;, VolEnv1C

; ===========================================================================
; ---------------------------------------------------------------------------
; Routine to start a fade
; ---------------------------------------------------------------------------

dDoPauseOut:
		movem.l	d0-d2/a1-a2,-(sp)
		lea	dFadeInUnpause(pc),a1
		bsr.s	dDoFade
		movem.l	(sp)+,d0-d2/a1-a2
		rts

dDoPauseIn:
		movem.l	d0-d2/a1-a2,-(sp)
		lea	dFadeOutPause(pc),a1
		bsr.s	dDoFade
		movem.l	(sp)+,d0-d2/a1-a2
		rts

dDoFadeIn:
		lea	dFadeInData(pc),a1
		bra.s	dDoFade

dDoFadeOut:
		lea	dFadeOutData(pc),a1

dDoFade:
		move.b	dRAM+mMasterVolFM.w,d0		; get copy of master vol
		tst.b	dRAM+mFadeAddr+1.w		; check if fade is in progress
		beq.s	.nofade				; if not, branch

		move.l	a1,a2				; copy ptr
		moveq	#-1,d2				; prepare minimal similarity

.find		move.b	(a2),d1				; get next byte
		bpl.s	.search				; if negative, end of list

.nofade		move.l	a1,dRAM+mFadeAddr.w		; save new fade address
		move.b	d0,dRAM+mMasterVolFM.w		; put vol back
		rts

.search		addq.l	#3,a2
		sub.b	d0,d1				; sub actual vol from it
		bpl.s	.abs				; if positive, branch
		neg.b	d1				; negate value

.abs		cmp.b	d2,d1				; check if last value is lower
		bhs.s	.find				; if is, branch

		move.b	d1,d2				; else save value
		move.l	a2,a1				; and position
		bra.s	.find

dFadeOutData:
	dc.b $01, $00, $00, $02, $01, $00, $02, $01, $01, $03, $02, $01
	dc.b $04, $02, $01, $04, $03, $02, $05, $03, $02, $06, $04, $02
	dc.b $07, $05, $03, $09, $06, $03, $0A, $08, $03, $0C, $0A, $03
	dc.b $0E, $0D, $04, $10, $0F, $04, $11, $10, $04, $14, $13, $05
	dc.b $16, $16, $05, $1A, $1A, $05, $1C, $1E, $06, $20, $22, $06
	dc.b $22, $27, $07, $26, $2A, $07, $2C, $2E, $08, $30, $34, $08
	dc.b $34, $39, $09, $3C, $3E, $0A, $40, $3F, $0A, $46, $40, $0B
	dc.b $4C, $40, $0C, $54, $40, $0D, $5C, $40, $0D, $60, $40, $0E
	dc.b $6C, $40, $0E, $74, $40, $0F, $7F, $40, $0F, $FF

dFadeInData:
	dc.b $7E, $40, $0F, $70, $40, $0E, $60, $40, $0D, $50, $3E, $0B
	dc.b $40, $34, $08, $30, $2C, $05, $20, $20, $03, $10, $0E, $01
	dc.b $00, $00, $00, $FF

dFadeOutPause:
	dc.b $01, $00, $00, $01, $00, $00, $02, $01, $00, $02, $02, $01
	dc.b $03, $03, $01, $04, $05, $02, $05, $06, $02, $05, $08, $03
	dc.b $06, $0A, $03, $08, $0C, $04, $09, $0E, $04, $0A, $11, $05
	dc.b $0C, $14, $06, $0D, $18, $06, $0F, $1C, $07, $10, $20, $07
	dc.b $12, $24, $08, $14, $28, $08, $18, $2C, $08, $FF

dFadeInUnpause:
	dc.b $18, $2C, $08, $14, $28, $08, $12, $22, $07, $10, $1E, $07
	dc.b $0E, $1C, $06, $0D, $18, $06, $0C, $14, $05, $0A, $12, $05
	dc.b $09, $10, $05, $08, $0E, $04, $06, $0C, $04, $05, $09, $04
	dc.b $05, $08, $03, $04, $06, $03, $03, $05, $02, $03, $04, $01
	dc.b $02, $03, $01, $01, $00, $00, $00, $00, $00, $FF

MusicList:
	dc.b bgm_DIS, bgm_DIS, bgm_DIS, bgm_DIS
	even
	opt ae-
