
; ===============================================================
; ---------------------------------------------------------------
; SMPS Extension Module
; 2014-2015, Vladikcomper
; ---------------------------------------------------------------
;	* Updated FM channel tracker
;	* Alternative note system
;	* Improved frequency calculation
;	* Portamento support with 4 different modes
; ---------------------------------------------------------------

; WARNING! Memory used overlaps with v_1up_ram_copy

; Extended channel struct
		rsreset
note		rs.w	1
note_target	rs.w	1
note_step	rs.w	1   
slide_mode	rs.b	1
slide_speed	rs.b	1
lastnote	rs.b	1		; last note read from track
noteshift	rs.b	1		; analogue of 22h (frequency displacement index)
note_volume	rs.b	1
note_volume_att	rs.b	1		; volume attenuation
volume_att	rs.b	1		; volume attenuation (effect)
volume_cnt	rs.b	1
volume_relcnt	rs.b	1		; volume reload cnt
freq_fuckbits	rs.b	1		; special flag to fuck frequency

TS_ExtChannelSize	= __RS-note

; Extended SMPS memory usage
		rsset	v_1up_ram_copy
TS_ExtChannels	rs.b	TS_ExtChannelSize*6		; extended RAM for 6 FM channels

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to init extended channels RAM
; ---------------------------------------------------------------

TS_InitExtChannels:
	move.l	a5,-(sp)

	lea	TS_ExtChannels(a6),a5
	moveq	#0,d0
	moveq	#6-1,d1				; number of channels

.clearchannel:
	rept	TS_ExtChannelSize/4	; WARNING: Hidded bug here!
		move.l	d0,(a5)+		; clear channel struct
	endr
	dbf	d1, .clearchannel

	move.l	(sp)+,a5
	rts

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to update FM channel
; ---------------------------------------------------------------

ExtChannelsRAM:                
	dc.w	TS_ExtChannelSize*5
	dc.w	TS_ExtChannelSize*4
	dc.w	TS_ExtChannelSize*3
	dc.w	TS_ExtChannelSize*2
	dc.w	TS_ExtChannelSize
	dc.w	0

; ---------------------------------------------------------------
TS_FM_UpdateChannel:
	move.w	d7,d0
	add.w	d0,d0
	lea	TS_ExtChannels(a6),a3
	adda.w	ExtChannelsRAM(pc,d0),a3

	move.b	slide_speed(a3),d0	; load slide speed
	andi.b	#$7F,d0			; clear bit 7
	beq.s	.NoSlide		; if speed is zero, branch
	jsr	TS_FM_SlideNote		; otherwise, update sliding
.NoSlide:

	tst.b	volume_att(a3)
	beq.s	.NoVolumeEffect
	jsr	TS_VolumeEffect
.NoVolumeEffect:

	subq.b	#1,$E(a5)		; decrease note timer
	beq.s	.LoadNewNote		; if timer has expired, branch

	tst.b	volume_att(a3)
	beq.s	.NoVolumeUpdate
	move.b	note_volume(a3),d0
	; TODOh: Global BGM Volume (default 99)                  !!
	; TODOh: BGM Volume (counted in channel_volume)          !!
	move.b	9(a5),d1                                        ;!!
	bsr	TS_AddVolumes                                   ;!!
	jsr	TS_UpdateChannelVolume
.NoVolumeUpdate:

	jsr	NoteFillUpdate
	jsr	DoModulation
	jmp	FMUpdateFreq

; ---------------------------------------------------------------
.LoadNewNote:
	pea	FMNoteOn
	pea	FMPrepareNote

	bclr	#4,(a5)			; Clear do not attack next note bit
	movea.l	4(a5),a4		; load channel track

.0	moveq	#0,d5
	move.b	(a4)+,d5		; get a byte from track
	cmpi.b	#$E0,d5			; is this a coordination flag?
	blo.s	.1
	move.l	a3,-(sp)
	jsr	TS_CoordFlag		; execute coordinate flag
	move.l	(sp)+,a3
	bra.s	.0			; repeat
	
.1	jsr	TS_FM_NoteOff_SetSlide
	jsr	FMNoteOff		; call NoteOff event
	bclr	#1,(a5)			; clear track at rest bit
	tst.b	d5			; did we get a note?
	bpl.s	.RepeatNote		; if got duration, branch
	jsr	TS_FM_UpdateNote
	move.b	(a4)+,d5		; get a byte from track
	bpl.s	.UpdateDuration		; if this is duration, branch
	subq.w	#1,a4
	jmp	FinishTrackUpdate

; ---------------------------------------------------------------
.RepeatNote:
	move.w	d5,-(sp)		; save duration to stack
	move.b	note(a3),d5
	sub.b	8(a5),d5		; ++ bug fix
	jsr	TS_FM_UpdateNote
	move.w	(sp)+,d5		; load duration from stack

.UpdateDuration:
	jsr	SetDuration
	jmp	FinishTrackUpdate

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to calculate note sliding
; ---------------------------------------------------------------

TS_FM_SlideNote:
	move.w	note_step(a3),d1	; d1 = Note Step
	beq.s	.Ret
	move.w	note(a3),d0		; d0 = Note
	lsl.b	#3,d0			; d0 = Note (fractional format)
	add.w	d1,d0			; d0 = Note + Note Step
	move.w	note_target(a3),d2	; d2 = Target Note
	lsl.b	#3,d2			; d2 = Target Note (fractional format)
	sub.w	d2,d0			; d0 = (Note + Note Step) - Target Note
	eor.w	d0,d1
	bmi.s	.UpdateNote
	clr.w	note_step(a3)		; reset Note Step
	moveq	#0,d0			; set Note to Target Note

.UpdateNote:
	add.w	d2,d0
	lsr.b	#3,d0
	andi.b	#$1F,d0
	move.w	d0,note(a3)

;	btst	#1,(a5)			; is track resting?
;	bne.s	.Ret			; if yes, branch
        jsr	TS_SetNoteFrequency
        move.w	$10(a5),d6		; load frequency stored
	jmp	FMUpdateFreq		; apply it

.Ret	rts

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to set sliding after note off
; ---------------------------------------------------------------

TS_FM_NoteOff_SetSlide:
	tst.b	lastnote(a3)		; was the last note zero?
	beq.s	.Ret			; if yes, branch
	btst	#7,slide_mode(a3)	; is sliding disabled on note off?
	beq.s	.Ret			; if yes, branch
	move.b	slide_speed(a3),d0	; load slide speed
	andi.w	#$7F,d0
	sub.b	#100,d0
	neg.b	d0			; d0 = 100-speed
	add.w	d0,d0
	add.w	d0,d0
	move.w	#$5FFC,d2		; set Target note to $5FFC

	btst	#6,slide_mode(a3)	; is sliding direction up?
	beq.s	.SetSlide		; branch if yes
	neg.w	d0
	moveq	#0,d2			; set Target note to $0000

.SetSlide:
	move.w	d0,note_step(a3)
	move.w	d2,note_target(a3)

.Ret	rts

; ===============================================================
; ---------------------------------------------------------------
; Coordination flag to set key displacement
; ---------------------------------------------------------------

TS_CoordFlag:
	subi.w	#$E0,d5
	add.w	d5,d5
	add.w	d5,d5
	jmp	.FlagsTable(pc,d5.w)

; ===============================================================
.FlagsTable:
	bra.w	cfPanningAMSFMS			; $E0
	bra.w	TS_Flag_SetFrequencyDisp	; $E1	Sets note frequency displacement in special fractional format (TS flag 0EBh)
	bra.w	TS_SetFrequencyFuckBits		; $E2	Special flag to fuck frequency
	bra.w	cfJumpReturn			; $E3
	bra.w	cfFadeInToPrevious		; $E4
	bra.w	cfSetTempoDivider		; $E5
	bra.w	TS_Flag_AlterVolume		; $E6	Alters note volume (TS flag 0E9h)
	bra.w	cfPreventAttack			; $E7
	bra.w	cfNoteFill			; $E8
	bra.w	TS_Flag_AlterNoteDisp		; $E9	Alters note displacement (TS flag 0E8h)
	bra.w	cfSetTempo			; $EA
	bra.w	cfSetTempoMod			; $EB
	bra.w	TS_Flag_SetVolumeSpeed		; $EC	Sets volume speed (TS flag 0EDh)
	bra.w	cfClearPush			; $ED
	bra.w	cfStopSpecialFM4		; $EE
	bra.w	cfSetVoice			; $EF
	bra.w	cfModulation			; $F0
	bra.w	cfEnableModulation		; $F1
	bra.w	cfStopTrack			; $F2
	bra.w	cfSetPSGNoise			; $F3
	bra.w	cfDisableModulation		; $F4
	bra.w	cfSetPSGTone			; $F5
	bra.w	cfJumpTo			; $F6
	bra.w	cfRepeatAtPos			; $F7
	bra.w	cfJumpToGosub			; $F8
	bra.w	cfOpF9				; $F9
	bra.w	TS_Flag_SetPortamentoMode	; $FA	Sets portamento mode (TS flags 0F4h-0F7h)
	bra.w	TS_Flag_SetPortamentoSpeed	; $FB	Sets portamento speed (TS flag 0E3h)
	bra.w	TS_Flag_SetVolume		; $FC	Sets note volume (TS)


; ===============================================================
; ---------------------------------------------------------------
; Coordination flag to alter note displacement
; ---------------------------------------------------------------

TS_SetFrequencyFuckBits:
	move.b	(a4)+,freq_fuckbits(a3)
	rts

; ===============================================================
; ---------------------------------------------------------------
; Coordination flag to alter note displacement
; ---------------------------------------------------------------

TS_Flag_AlterNoteDisp:
	move.b	(a4)+,d0		; is argument zero?
	beq.s	.0			; if yes, branch
	add.b	d0,8(a5)		; othewise, add argument to current displacement
	; TODOh: Overflow checking
	rts

.0	move.b	d0,8(a5)		; if zero, reset displacement
	rts

; ===============================================================
; ---------------------------------------------------------------
; Coordination flag to set note frequency displacement
; ---------------------------------------------------------------

TS_Flag_SetFrequencyDisp:
	move.b	(a4)+,noteshift(a3)
	rts


; ===============================================================
; ---------------------------------------------------------------
; Coordination flag to set portamento mode
; ---------------------------------------------------------------

TS_Flag_SetPortamentoMode:
	move.b	(a4)+,d0
	andi.w	#3,d0
	add.w	d0,d0			; d0 = x*2
	move.w	d0,d1
	lsl.w	#3,d0			; d0 = x*16
	sub.w	d1,d0			; d0 = x*14
	jmp	.0(pc,d0)

; ---------------------------------------------------------------
.0	bclr	#7,slide_speed(a3)	; originally FlagF4
	bclr	#7,slide_mode(a3)
	rts
; ---------------------------------------------------------------
	bset	#7,slide_speed(a3)	; originally FlagF5
	bclr	#7,slide_mode(a3)
	rts
; ---------------------------------------------------------------
	bset	#7,slide_mode(a3)	; originally FlagF6
	bclr	#6,slide_mode(a3)
      	rts
; ---------------------------------------------------------------
	bset	#7,slide_mode(a3)	; originally FlagF7
	bset	#6,slide_mode(a3)
	rts

; ===============================================================
; ---------------------------------------------------------------
; Coordination flag to set portamento speed
; ---------------------------------------------------------------

TS_Flag_SetPortamentoSpeed:
	move.b	(a4)+,d0
	andi.b	#$7F,d0
	move.b	slide_speed(a3),d1
	andi.b	#$80,d1
	or.b	d0,d1
	move.b	d1,slide_speed(a3)
	rts

; ===============================================================
; ---------------------------------------------------------------
; Coordination flag to alter volume
; ---------------------------------------------------------------

TS_Flag_AlterVolume:
	move.b	(a4)+,d0
	beq.s	.0
	add.b	note_volume_att(a3),d0
.0	move.b	d0,note_volume_att(a3)
	;~~
	move.b	volume_relcnt(a3),d1	; is volume effect reload counter zero?
	beq.s	.ret			; if yes, branch
	move.b	d1,volume_cnt(a3)
	tst.b	d0			; is argument zero again?
	beq.s	.1
	add.b	d0,volume_att(a3)
	rts

.1	move.b	d0,volume_att(a3)	; set attenuation to argument
.ret	rts

; ===============================================================
; ---------------------------------------------------------------
; Coordination flag to volume effect speed
; ---------------------------------------------------------------

TS_Flag_SetVolumeSpeed:
	move.b	(a4)+,volume_relcnt(a3)
	rts

; ===============================================================
; ---------------------------------------------------------------
; Coordination flag to set note volume
; ---------------------------------------------------------------

TS_Flag_SetVolume:
	move.b	(a4)+,d0   
	move.b	d0,note_volume(a3)

; ===============================================================
; ---------------------------------------------------------------
; Coordination flag to update channel volume
; ---------------------------------------------------------------
; INPUT:
;	d0 .b	Volume
; ---------------------------------------------------------------

TS_UpdateChannelVolume: 
	btst	#2,(a5)            ; is SFX overriding?
	bne.s	.return            ; if yes, branch
	tst.b	d0
	bne.s	.ConvertVolume
	moveq	#$7F,d0
	bra.s	.SendVolume

.ConvertVolume:
	sub.b	#99,d0
	neg.b	d0			; d0 = 99 - Volume  
	; TODOh: Add Fade out volume
	add.b	volume_att(a3),d0
	bvc.s	.SendVolume
	moveq	#$7F,d0

.SendVolume:
	move.b	d0,d3			; ~~

	moveq	#0,d0
	move.b	$B(a5),d0		; d0 = Voice
	mulu.w	#25,d0			; d0 = Voice*25
	movea.l	v_voice_ptr(a6),a1
	adda.w	d0,a1			; a1 = VoicePtr

	lea	FMInstrumentTLTable(pc),a2
	move.b	(a1)+,d0		; d2 = Feedback/Algo
	andi.w	#7,d0			; d2 = Algo
	move.b	TS_FMSlotMask(pc,d0),d4
	lea	20(a1),a1		; a1 = VoicePtr + TL
	moveq	#3,d5

.sendtlloop:
	move.b	(a2)+,d0
	move.b	(a1)+,d1
	lsr.b	#1,d4		; Is bit set for this operator in the mask?
	bcc.s	.sendtl		; Branch if not
	add.b	d3,d1		; Include additional attenuation
	bvc.s	.sendtl		; ~~
	moveq	#$7F,d1		; ~~

.sendtl:
	jsr	WriteFMIorII(pc)
	dbf	d5,.sendtlloop
.return	rts

; ---------------------------------------------------------------
TS_FMSlotMask:	dc.b 8,	8, 8, 8, $A, $E, $E, $F


; ===============================================================
; ---------------------------------------------------------------
; Subroutine to add volumes
; ---------------------------------------------------------------
; INPUT:
;	d0 .b	Volume 1
;	d1 .b	Volume 2
; OUTPUT:
;	d0 .b	Resulting Volume
; ---------------------------------------------------------------

; Adds volumes (in percents), returns volume (in percents)
TS_AddVolumes:
	sub.b	#99,d0
	neg.b	d0			; d0 = 99 - Volume1
	sub.b	#99,d1
	neg.b	d1			; d1 = 99 - Volume2
	add.b	d1,d0			; d0 = (99 - Volume2) + (99 - Volume1)
	bcc.s	.0
	moveq	#0,d0			; use maximum volume
	bra.s	.1
	
.0	cmp.b	#100,d0			; volume >= 100?
	bcs.s	.1
	moveq	#99,d0			; use minimum volume

.1	sub.b	#99,d0
	neg.b	d0			; d0 = 99 - (99 - Volume2) - (99 - Volume1)
	rts

; ---------------------------------------------------------------
; Adds attenuation to the volume, returns volume (in percents)
TS_AddVolumes2:
	add.b	d1,d0			; d0 = Volume1 + Volume2
	bvc.s	.0
	moveq	#0,d0			; use minimum volume
	rts

.0	cmp.b	#100,d0
	bcs.s	.ret
	moveq	#99,d0			; use maximum volume
.ret	rts


; ===============================================================
; ---------------------------------------------------------------
; Subroutine to perform volume effect
; ---------------------------------------------------------------

TS_VolumeEffect:
	subq.b	#1,volume_cnt(a3)
	bne.s	.ret
	move.b	volume_att(a3),d0
	subq.b	#1,d0
	bpl.s	.0
	addq.b	#2,d0
.0	move.b	d0,volume_att(a3)
	move.b	volume_relcnt(a3),volume_cnt(a3)	; reload volume effect counter
.ret	rts

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to update note
; ---------------------------------------------------------------
; INPUT:
;	d5 .b	Note
; ---------------------------------------------------------------

TS_FM_UpdateNote:
	subi.b	#$80,d5			; subtract $80 from the note
	beq.s	.SetRest		; if note $80, branch
	move.w	d5,-(sp)

	; Add pitch to the not
	add.b	8(a5),d5		; add pitch to note
	; TODOh: Pitch boundary check
	
	tst.b	freq_fuckbits(a3)
	bne.s	.0
	andi.w	#$7F,d5
.0
	jsr	TS_SetTargetNote
	jsr	TS_SetNoteFrequency

	; Update note volume
	move.b	note_volume(a3),d0
	; TODOh: Global BGM Volume (default 99)
	; TODOh: BGM Volume (counted in channel_volume)
	move.b	9(a5),d1
	bsr	TS_AddVolumes
	move.b	note_volume_att(a3),d1
	bsr	TS_AddVolumes2
	jsr	TS_UpdateChannelVolume	; THIS SHOULD BE CALLED FROM INSIDE OTHER FUNCTIONS

	move.w	(sp)+,d5
	move.b	d5,lastnote(a3)
	rts

; ---------------------------------------------------------------
.SetRest
	move.b	d5,lastnote(a3)		; save as last note read
	clr.w	$10(a5)
	bset	#1,(a5)
	rts

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to set target note
; ---------------------------------------------------------------
; INPUT:
;	d5 .b	Pitched Note
; ---------------------------------------------------------------

TS_SetTargetNote:

	; The following code pitches the current note
	moveq	#$20,d1
	move.b	noteshift(a3),d0
	bpl.s	.PitchUp

.PitchDown:
	subq.b	#1,d5		; decrease note
	add.b	d1,d0
	bcc.s	.PitchDown
	sub.b	d1,d0
	bra.s	.PitchDone

.PitchUp:
	sub.b	d1,d0
	bcs.s	.PitchUp_Done
	addq.b	#1,d5		; increase note
	bra.s	.PitchUp

.PitchUp_Done:
	add.b	d1,d0

.PitchDone:
	and.w	#$1F,d0

	move.b	d0,note_target+1(a3)
	move.b	d5,note_target(a3)

	move.b	slide_speed(a3),d0
	andi.w	#$7F,d0
	beq.s	.NoPortamento
	btst	#7,slide_mode(a3)		; does sliding mode works for note off only?
	bne.s	.SetNoteToTarget		; if yes, branch
	tst.b	lastnote(a3)			; ~~ was the last note (not?) zero?
	bne.s	.SetSlide			; ~~ is yes, branch
	btst	#7,slide_speed(a3)
	bne.s	.NoPortamento

.SetSlide:
	sub.b	#100,d0
	move.w	note_target(a3),d2
	sub.w	note(a3),d2			; Target Note < Note ?
	bcs.s	.CalcNoteStep			; if yes, branch
	neg.b	d0				; otherwise, negate byte

.CalcNoteStep:
	ext.w	d0
	asl.w	#5,d0
	move.w	d0,note_step(a3)
	rts

; ---------------------------------------------------------------
.NoPortamento:
	clr.w	note_step(a3)
	
.SetNoteToTarget:
	move.w	note_target(a3),note(a3)	; set Note to Target Note
	rts

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to update note
; ---------------------------------------------------------------

TS_SetNoteFrequency:
	move.b	note(a3),d5

	; Special code to fuck frequency
	move.b	freq_fuckbits(a3),d0
	bne.s	.0
	andi.w	#$7F,d5
	bra.s 	.1
	
.0	move.w	d5,-(sp)
	move.b	9(a5),d0
	jsr	TS_UpdateChannelVolume
	move.w	(sp)+,d5
.1
	moveq	#-1,d4				; d4 = octave
	moveq	#12,d3				; d3 = octave size (in notes)

.SplitNoteAndOctave:
	addq.w	#1,d4
	sub.w	d3,d5
	bcc.s	.SplitNoteAndOctave
	add.w	d3,d5

		buytest	Used_AirHorn
		beq.s	.no
		jsr	RandomNumber
		andi.w	#$F,d0
		subq.w	#8,d0
		add.w	d0,d5

.no
	add.w	d5,d5				; d5 = Note*2
	move.w	FM_Frequencies(pc,d5),d0
	ror.w	#5,d4				; d4 = Octave<<11
	or.w	d4,d0				; d0 = Octave<<11 + Frequency
	move.b	note+1(a3),d3			; d3 = Subnote
	andi.w	#$1F,d3
	lsl.w	#4,d5				; d5 = Note*32
	add.w	d3,d5				; d5 = Note*32 + Subnote
	move.b	FM_PortamentoFreq(pc,d5),d3
	add.w	d3,d0				; d0 = Octave<<11 + Frequency + PortamentoFreq
	move.w	d0,$10(a5)			; save frequency
	rts

; ---------------------------------------------------------------
; FM Frequencies table
; ---------------------------------------------------------------

FM_Frequencies:
	dc.w	$284, $2AA, $2D3, $2FE, $32B, $35B, $38E, $3C4, $3FE, $43B, $47B, $4BF

FM_PortamentoFreq:
	dc.b	0, 1, 2, 4, 5, 6,  7,  8,   $A,  $B,  $C,  $D,  $E,  $10, $11, $12, $13, $14, $16, $17, $18, $19, $1A, $1C, $1D, $1E, $1F, $20, $21, $23, $24, $25
	dc.b	0, 1, 3, 4, 5, 6,  8,  9,   $A,  $B,  $D,  $E,  $F,  $10, $12, $13, $14, $16, $17, $18, $19, $1B, $1C, $1D, $1E, $20, $21, $22, $23, $25, $26, $27
	dc.b	0, 1, 3, 4, 5, 7,  8,  9,   $B,  $C,  $D,  $F,  $10, $11, $13, $14, $15, $17, $18, $1A, $1B, $1C, $1E, $1F, $20, $22, $23, $24, $26, $27, $28, $2A
	dc.b	0, 1, 3, 4, 6, 7,  9,  $A,  $B,  $D,  $E,  $10, $11, $12, $14, $15, $17, $18, $1A, $1B, $1C, $1E, $1F, $21, $22, $24, $25, $26, $28, $29, $2B, $2C
	dc.b	0, 2, 3, 5, 6, 8,  9,  $B,  $C,  $E,  $F,  $11, $12, $14, $15, $17, $18, $1A, $1B, $1D, $1E, $20, $21, $23, $24, $26, $27, $29, $2A, $2C, $2D, $2F
	dc.b	0, 2, 3, 5, 6, 8,  $A, $B,  $D,  $E,  $10, $12, $13, $15, $16, $18, $1A, $1B, $1D, $1E, $20, $22, $23, $25, $26, $28, $2A, $2B, $2D, $2E, $30, $31
	dc.b	0, 2, 3, 5, 7, 8,  $A, $C,  $E,  $F,  $11, $13, $14, $16, $18, $19, $1B, $1D, $1E, $20, $22, $24, $25, $27, $29, $2A, $2C, $2E, $2F, $30, $33, $34
	dc.b	0, 2, 4, 5, 7, 9,  $B, $D,  $E,  $10, $12, $14, $16, $17, $19, $1B, $1D, $1E, $20, $22, $24, $26, $27, $29, $2B, $2D, $2F, $30, $32, $34, $36, $38
	dc.b	0, 2, 4, 6, 8, 9,  $B, $D,  $F,  $11, $13, $15, $17, $19, $1B, $1C, $1E, $20, $22, $24, $26, $28, $2A, $2C, $2E, $2F, $31, $33, $35, $37, $39, $3B
	dc.b	0, 2, 4, 6, 8, $A, $C, $E,  $10, $12, $14, $16, $18, $1A, $1C, $1E, $20, $22, $24, $26, $28, $2A, $2C, $2E, $30, $32, $34, $36, $38, $3A, $3C, $3E
	dc.b	0, 2, 4, 6, 9, $B, $D, $F,  $11, $13, $15, $17, $1A, $1C, $1E, $20, $22, $24, $26, $28, $2B, $2D, $2F, $31, $33, $35, $37, $3A, $3C, $3E, $40, $42
	dc.b	0, 2, 5, 7, 9, $B, $E, $10, $12, $14, $17, $19, $1B, $1D, $20, $22, $24, $26, $29, $2B, $2D, $2F, $32, $34, $36, $38, $3B, $3D, $3F, $41, $44, $46

; ===============================================================
; ---------------------------------------------------------------
; Subroutine to do fade out
; ---------------------------------------------------------------
 
TS_DoFadeOut:
        move.b  v_fadeout_delay(a6),d0  ; Has fadeout delay expired?
        beq.s   @continuefade   ; Branch if yes
        subq.b  #1,v_fadeout_delay(a6)
        rts
; ===========================================================================
 
@continuefade:
        subq.b  #1,v_fadeout_counter(a6)        ; Update fade counter
        beq.w   StopSoundAndMusic       ; Branch if fade is done
        move.b  #3,v_fadeout_delay(a6)  ; Reset fade delay
        lea     v_fm1_track(a6),a5
        lea     TS_ExtChannels(a6),a3
        moveq   #5,d7
 
@fmloop:
        tst.b   (a5)            ; Is track playing?
        bpl.s   @nextfm         ; Branch if not
        subq.b  #1,9(a5)        ; Increase volume attenuation
        bne.s   @sendfmtl       ; Branch if still positive
        bclr    #7,(a5)         ; Stop track
        bra.s   @nextfm
; ===========================================================================
 
@sendfmtl:
        ; Update note volume
        move.b  note_volume(a3),d0
        ; TODOh: Global BGM Volume (default 99)
        ; TODOh: BGM Volume (counted in channel_volume)
        move.b  9(a5),d1
        bsr     TS_AddVolumes
        move.b  note_volume_att(a3),d1
        bsr     TS_AddVolumes2
        jsr     TS_UpdateChannelVolume  ; THIS SHOULD BE CALLED FROM INSIDE OTHER FUNCTIONS
 
@nextfm:
        lea     zTrackSz(a5),a5
        lea     TS_ExtChannelSize(a3),a3
        dbf     d7,@fmloop
 
        moveq   #2,d7
 
@psgloop:
        tst.b   (a5)            ; Is track playing?
        bpl.s   @nextpsg        ; branch if not
        addq.b  #1,9(a5)        ; Increase volume attenuation
        cmpi.b  #$10,9(a5)      ; Is it greater than $F?
        blo.s   @sendpsgvol     ; Branch if not
        bclr    #7,(a5)         ; Stop track
        bra.s   @nextpsg
; ===========================================================================
 
@sendpsgvol:
        move.b  9(a5),d6        ;Store new volume attenuation
        jsr     SetPSGVolume(pc)
 
@nextpsg:
        adda.w  #zTrackSz,a5
        dbf     d7,@psgloop
        rts