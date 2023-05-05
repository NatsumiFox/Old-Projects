; ==============================================================================
; ------------------------------------------------------------------------------
; Equates and macros
; ------------------------------------------------------------------------------

	rsset 0
LS_cVol			rs.b 4					; channel volume (1 per operator)
LS_cChannel		rs.b 1					; channel bits
LS_cPtr			rs.w 1					; pointer to channel tracker
LS_cFlags		rs.b 1					; various flags and key mask
LS_cDelay		rs.b 1					; tracker delay
LS_cFreq		rs.w 1					; channel frequency
LS_cLoop		rs.b 1					; loop counter
LS_cVibStr		rs.w 1					; vibrato pointer store
LS_cVolStr		rs.w 1					; volume pointer store
LS_cVibPtr		rs.b 6					; vibrato pointer
LS_cVolPtr		rs.b 6					; volume pointer
LS_cSize		rs.b 0					; channel size

	rsset 0
LS_Queue		rs.b 1					; queued sound
LS_FM1			rs.b LS_cSize				; FM 1 data
LS_FM2			rs.b LS_cSize				; FM 2 data
LS_FM3			rs.b LS_cSize				; FM 3 data
LS_cEnd			rs.b 0					; debug
; ==============================================================================
; ------------------------------------------------------------------------------
; Mute hardware and initialize status
; ------------------------------------------------------------------------------

		di						; disable interrupts
		im	1					; set interrupt mode to 1

		ld	sp,2000h				; load stack address
		ld	hl,4000h				; load YM register port to hl
		ld	de,4001h				; load YM data port to de
; ------------------------------------------------------------------------------

		ld	b, 4					; set loop counter to 4
		ld	a, 9Fh					; set volume to max for PSG1

.silencePSG
		ld	(7F11h), a				; write to PSG port
		zadd	a, 20h					; go to next channel
		djnz	.silencePSG				; loop for every channel
; ------------------------------------------------------------------------------

		ld	b, 3					; set loop counter for 3 channels
		ld	c, 0B4h					; FM1 PANNING
		ld	ix,4002h				; load port 2 to ix
		xor	a					; PAN NONE

.setpanning
		ld	(hl),c					; FMX PANNING (port 1)
		ld	(de),a					; set panning to none
		ld	(ix+0),c				; FMX PANNING (port 2)
		ld	(ix+1),a				; set panning to none

		inc	c					; go to next channel
		djnz	.setpanning				; loop for all channels
; ------------------------------------------------------------------------------

	; intialize Timer A, max avg load may be 5227 cycles, a fairly safe cycle count is ~7000
.timera =	37Ch						; prepare timer A update rate, see calculations below

		ld	(hl),24h				; TIMER A MSB
		ld	a,.timera>>2				; load timer value
		ld	(de),a					; send to port 1
		ld	(hl),25h				; TIMER A LSB
		ld	a,.timera&3				; load timer value
		ld	(de),a					; send to port 1

; ms =		18 * (1024 - timera) / 1000			= 2.38
; Hz =		1000 / ms					= 420.88
; upf =		Hz / 60						= 7.01
; cycles =	3579545 / Hz					= 8505
; ------------------------------------------------------------------------------

		ld	a,0
		ld	(LS_Queue),a				; set sound queue

	; intialize channels
		xor	a					; clear a
		ld	(LS_FM1+LS_cChannel),a			; save into FM1
		inc	a					; load 1 into a
		ld	(LS_FM2+LS_cChannel),a			; save into FM2
		inc	a					; load 2 into a
		ld	(LS_FM3+LS_cChannel),a			; save into FM3

		ld	bc,LS_sNull				; set a to 0
		ld	(LS_FM1+LS_cPtr),bc			; set to null routine
		ld	(LS_FM2+LS_cPtr),bc			;
		ld	(LS_FM3+LS_cPtr),bc			;

	if *<LS_cEnd
		inform 2,"Not enough room for channel data"
	endif
; ==============================================================================
; ------------------------------------------------------------------------------
; Main loop for z80
; ------------------------------------------------------------------------------

LS_MainLoop:	; 69
		ld	(hl),27h			; 10	; TIMERS
		ld	a,%00010101			; 7	; prepare value to a
		ld	(de),a				; 7	; send to YM port 1
		exx					; 4	; swap register pairs
; ------------------------------------------------------------------------------

	; handle sound queue
		ld	hl,LS_Queue			; 10	; load sound queue pointer to hl
		ld	a,(hl)				; 7	; load the sound queue to a
		ld	(hl),0				; 10	; clear queue
		zor	a				; 4	; decrement queue value
		jpz	LS_Trackers			; 10	; branch if underflowed
; ------------------------------------------------------------------------------

		; 421
		ld	hl,LS_Sounds-4			; 10	; load sounds array to hl
		zadd	a,a				; 4	; multiply a by 4
		zadd	a,a				; 4	;

		zadd	a,l				; 4	; add low byte to a
		ld	l,a				; 4	; copy back to l
		ld	a,0				; 7	; clear a
		adc	a,h				; 4	; add h and carry to a
		ld	h,a				; 4	; copy back to h

		ld	e,(hl)				; 7	; load channel address to de
		inc	hl				; 6	;
		ld	d,(hl)				; 7	;
		inc	hl				; 6	;
		xor	a				; 4	; clear a

	rept 4
		ld	(de),a				; 7	; clear all volumes
		inc	de				; 6	;
	endr

		inc	de				; 6	; skip channel type
		ld	a,(hl)				; 7	; copy channel tracker address
		ld	(de),a				; 7	;
		inc	de				; 6	;
		inc	hl				; 6	;
		ld	a,(hl)				; 7	;
		ld	(de),a				; 7	;
		inc	de				; 6	;

		ex	de,hl				; 4	; swap channel data to hl
		ld	(hl),0F0h			; 10	; set flags to default
		inc	hl				; 6	;
		ld	(hl),1				; 10	; set initial delay to 1
		inc	hl				; 6	;

		xor	a				; 4	; clear a
		ld	(hl),a				; 7	; clear frequency
		inc	hl				; 6	;
		ld	(hl),a				; 7	;
		inc	hl				; 6	;
		ld	(hl),a				; 7	; clear loop counter
		inc	hl				; 6	;

		ld	de,LS_ioNull			; 7	; load the null envelope address to de

	rept 3
		ld	(hl),e				; 7	; reset stored vibrato & volume envelopes
		inc	hl				; 6	; and also the current vibrato envelope
		ld	(hl),d				; 7	;
		inc	hl				; 6	;
	endr

	rept 4
		ld	(hl),a				; 7	; clear extra variables
	endr

		ld	(hl),e				; 7	; reset current volume envelope
		inc	hl				; 6	;
		ld	(hl),d				; 7	;
		inc	hl				; 6	;

	rept 4
		ld	(hl),a				; 7	; clear extra variables
	endr
; ------------------------------------------------------------------------------

	; handle trackers
LS_Trackers:
		ld	iy,LS_FM1			; 24	; load FM1 data to iy
		call	LS_Channel			; 1694	; execute channel
		ld	iy,LS_FM2			; 24	; load FM2 data to iy
		call	LS_Channel			; 1694	; execute channel
		ld	iy,LS_FM3			; 24	; load FM3 data to iy
		call	LS_Channel			; 1694	; execute channel

	;	exx					; 4	; swap register pairs
	;	inc	l				; 4	; set hl to 4002
	;	inc	l				; 4	;
	;	inc	e				; 4	; set de to 4003
	;	inc	e				; 4	;
	;	exx					; 4	; swap register pairs

	;	ld	iy,LS_FM4			; 24	; load FM4 data to iy
	;	call	LS_HandleVolume			; 796	; execute envelopes
	;	ld	iy,LS_FM5			; 24	; load FM5 data to iy
	;	call	LS_HandleVolume			; 796	; execute envelopes
	;	ld	iy,LS_FM6			; 24	; load FM6 data to iy
	;	call	LS_HandleVolume			; 796	; execute envelopes

	;	exx					; 4	; swap register pairs
	;	dec	l				; 4	; set hl to 4000
	;	dec	l				; 4	;
	;	dec	e				; 4	; set de to 4001
	;	dec	e				; 4	;
	;	exx					; 4	; swap register pairs
; ------------------------------------------------------------------------------

		exx					; 4	; swap register pairs

.wait
	; wait for Timer A
		bit	0,(hl)				; 12	; check if timer a has overflowed
		jpnz	LS_MainLoop			; 10	; run again if so
		jp	.wait				; 10	; if not, wait more
; ==============================================================================
; ------------------------------------------------------------------------------
; Table for command pointers
; ------------------------------------------------------------------------------

	cnop 0,$E0
	if $E0<>*
		inform 2, "LS_CommTable must be at $E0, but was at *!"
	endif
LS_CommTable:
		dw LS_Vol1, LS_Vol2, LS_Vol3, LS_Vol4		; $F0-$F3
		dw LS_VolAll					; $F4
		dw LS_VolTab					; $F5
		dw LS_VibTab					; $F6
		dw LS_Voice					; $F7
		dw LS_Soft					; $F8
		dw LS_Flags					; $F9
		dw 0, 0						; $FA-$FB
		dw LS_SpecialPan				; $FC
		dw LS_Jump					; $FD
		dw LS_Loop					; $FE
		dw LS_Stop					; $FF
; ==============================================================================
; ------------------------------------------------------------------------------
; Table for note frequencies
; ------------------------------------------------------------------------------

	cnop 0,$100
LS_NoteFreq:
	dw 025Eh,0284h,02ABh,02D3h,02FEh,032Dh,035Ch,038Fh,03C5h,03FFh,043Ch,047Ch
	dw 0A5Eh,0A84h,0AABh,0AD3h,0AFEh,0B2Dh,0B5Ch,0B8Fh,0BC5h,0BFFh,0C3Ch,0C7Ch
	dw 125Eh,1284h,12ABh,12D3h,12FEh,132Dh,135Ch,138Fh,13C5h,13FFh,143Ch,147Ch
	dw 1A5Eh,1A84h,1AABh,1AD3h,1AFEh,1B2Dh,1B5Ch,1B8Fh,1BC5h,1BFFh,1C3Ch,1C7Ch
	dw 225Eh,2284h,22ABh,22D3h,22FEh,232Dh,235Ch,238Fh,23C5h,23FFh,243Ch,247Ch
	dw 2A5Eh,2A84h,2AABh,2AD3h,2AFEh,2B2Dh,2B5Ch,2B8Fh,2BC5h,2BFFh,2C3Ch,2C7Ch
	dw 325Eh,3284h,32ABh,32D3h,32FEh,332Dh,335Ch,338Fh,33C5h,33FFh,343Ch,347Ch
	dw 3A5Eh,3A84h,3AABh,3AD3h,3AFEh,3B2Dh,3B5Ch,3B8Fh,3BC5h,3BFFh,3C3Ch,3C7Ch
; ==============================================================================
; ------------------------------------------------------------------------------
; Table for sounds
; ------------------------------------------------------------------------------

LS_Sounds:
.sound		macro pointer, tracker
	dw \pointer, \tracker
    endm

	.sound	LS_FM1, LS_sReveal_FM1				; $01 - Reveal sound
	.sound	LS_FM1, LS_sLogo_FM1				; $02 - Logo sound
	.sound	LS_FM3, LS_sLightning_FM23			; $03 - Lightning left
	.sound	LS_FM2, LS_sLightning_FM23			; $04 - Lightning right
	.sound	LS_FM1, LS_sCycle_FM1				; $05 - Cycle sound
	.sound	LS_FM2, LS_sType_FM2				; $06 - Type sound
	.sound	LS_FM1, LS_sGHZ_FM1				; $07 - GHZ music
; ==============================================================================
; ------------------------------------------------------------------------------
; Routine for executing a channel
; ------------------------------------------------------------------------------

LS_Channel:	; 33
		dec	(iy+LS_cDelay)			; 23	; decrement delay
		jpnz	LS_HandleVolume			; 10	; if not 0, skip tracker
; ==============================================================================
; ------------------------------------------------------------------------------
; Routine for executing a tracker
; ------------------------------------------------------------------------------
		; 38
		ld	e,(iy+LS_cPtr)			; 19	; load channel address
		ld	d,(iy+LS_cPtr+1)		; 19	;

LS_Commands:	; 27 or 138
		ld	a,(de)				; 7	; load the next byte
		inc	de				; 6	;
		zor	a				; 4	; check if positive
		jpm	.chkcommand			; 10	; if negative, check command and note
; ------------------------------------------------------------------------------

		ld	b,0				; 7	; clear b
		ld	c,a				; 4	; load byte to c
		ld	hl,LS_RegCvtTbl			; 10	; load register conversion table to hl
		zadd	hl,bc				; 11	; add offset to the table

		ld	a,(hl)				; 7	; load the register
		exx					; 4	; swap registers
		ld	(hl),a				; 7	; save into command port
		exx					; 4	; swap registers

		ld	a,(de)				; 7	; load the value from tracker
		inc	de				; 6	;
		exx					; 4	; swap registers
		ld	(de),a				; 7	; send value
		exx					; 4	; swap registers again
		jp	LS_Commands			; 10	; do next command
; ------------------------------------------------------------------------------

.chkcommand	; 19 or 77
		cp	lCommandFirst			; 7	; check if this is a command
		jrc	.note				; 12/7	; branch if not

		zadd	a,a				; 4	; double a and discard msb
		ld	c,a				; 4	; load a to c
		ld	b,LS_CommTable>>8		; 7	; set command table to b

		ld	a,(bc)				; 7	; load low byte to l
		ld	l,a				; 4	;
		inc	bc				; 6	;
		ld	a,(bc)				; 7	; load high byte to h
		ld	h,a				; 4	;
		jp	(hl)				; 7	; jump to instruction
; ------------------------------------------------------------------------------

.note		; 202
		zadd	a,a				; 4	; double offset and ditch msb
		ld	c,a				; 4	; load note offset to c
		ld	b,LS_NoteFreq>>8		; 7	; set note frequency table to b

		ld	a,(bc)				; 7	; load frequency low byte to a
		inc	bc				; 6	;
		ld	(iy+LS_cFreq),a			; 19	; save to channel
		ld	a,(bc)				; 7	; load frequency high byte to a
		ld	(iy+LS_cFreq+1),a		; 19	;

		ld	a,(de)				; 7	; load delay from tracker
		inc	de				; 6	;
; ------------------------------------------------------------------------------

		ld	(iy+LS_cDelay),a		; 19	; save new delay
		call	LS_CommandEnd			; 17	; enable key last
		exx					; 4	; swap registers

		ld	(hl),28h			; 10	; KEY
		ld	a,(iy+LS_cFlags)		; 19	; load flags to a
		zand	0F0h				; 7	; get only key flags
		zor	(iy+LS_cChannel)		; 19	; OR channel type
		ld	(de),a				; 7	; send value into data port
		exx					; 4	; swap registers
		ret					; 10
; ------------------------------------------------------------------------------

LS_CommandEnd:; 68 or 432
		ld	(iy+LS_cPtr),e			; 19	; save channel address
		ld	(iy+LS_cPtr+1),d		; 19	;

		bit	0,(iy+LS_cFlags)		; 20	; check if soft key is on
		jpnz	LS_HandleVolume			; 10	; branch if ye

		exx					; 4	; swap registers
		ld	(hl),28h			; 10	; KEY
		ld	a,(iy+LS_cChannel)		; 19	; load channel type, all operators off
		ld	(de),a				; 7	; send value into data port
		exx					; 4	; swap registers

		ld	a,(iy+LS_cVolStr)		; 19	; copy stored volume pointer to normal
		ld	(iy+LS_cVolPtr),a		; 19	;
		ld	a,(iy+LS_cVolStr+1)		; 19	; copy stored volume pointer to normal
		ld	(iy+LS_cVolPtr+1),a		; 19	;

		ld	a,(iy+LS_cVibStr)		; 19	; copy stored vibrato pointer to normal
		ld	(iy+LS_cVibPtr),a		; 19	;
		ld	a,(iy+LS_cVibStr+1)		; 19	; copy stored vibrato pointer to normal
		ld	(iy+LS_cVibPtr+1),a		; 19	;

		xor	a				; 4	; clear a
		ld	(iy+LS_cVolPtr+3),a		; 19	; clear variables
		ld	(iy+LS_cVolPtr+4),a		; 19	;
		ld	(iy+LS_cVolPtr+5),a		; 19	;
		inc	a				; 4	; load 1 to a
		ld	(iy+LS_cVolPtr+2),a		; 19	; save as the delay

		xor	a				; 4	; clear a
		ld	(iy+LS_cVibPtr+3),a		; 19	; clear variables
		ld	(iy+LS_cVibPtr+4),a		; 19	;
		ld	(iy+LS_cVibPtr+5),a		; 19	;
		inc	a				; 4	; load 1 to a
		ld	(iy+LS_cVibPtr+2),a		; 19	; save as the delay
; ==============================================================================
; ------------------------------------------------------------------------------
; Routine for handling volume
; ------------------------------------------------------------------------------

LS_HandleVolume:; 143
		ld	a,iyh				; 8	; load channel high byte to ix
		ld	ixh,a				; 8	;
		ld	a,iyl				; 8	; load channel low byte to a
		zadd	a,LS_cVolPtr			; 7	; add volume data offset
		ld	ixl,a				; 8	; load finally to ixl
		call	LS_HandlEnv			; 17	; run evenlope processor
		ld	d,a				; 4	; copy offset into d

		push	iy				; 15	; put iy into stack
		pop	hl				; 10	; pop as hl
		ex	af,af				; 4	; store af away
		ld	b,4				; 7	; loop for every volume level

		exx					; 4	; switch register pairs
		ld	a,(iy+LS_cChannel)		; 19	; load channel id to a
		zadd	040h				; 7	; add TOTAL LEVEL register to a
		ld	c,4				; 7	; prepare next channel offset to c
		jp	.first				; 10	; go to first iteration code
; ------------------------------------------------------------------------------

.nextvolume	; 311 to 327
		exx					; 4	; switch register pairs
		ld	a,b				; 4	; load TL level command to a
		zadd	a,c				; 4	; go to next TL level

.first
		ld	(hl),a				; 7	; load into command port
		ld	b,a				; 4	; save it back to b

		exx					; 4	; swap regs
		ld	a,(hl)				; 7	; load value from voice
		inc	hl				; 6	;

		zor	a				; 4	; check if a is negative
		jpp	*+3				; 10	; if not, skip
		zadd	a,d				; 4	; add volume offset

		exx					; 4	; swap regs
		ld	(de),a				; 7	; load value into data port
		exx					; 4	; switch register pairs
		djnz	.nextvolume			; 13/8	; go to next volume
; ==============================================================================
; ------------------------------------------------------------------------------
; Routine for handling vibrato
; ------------------------------------------------------------------------------
		; 289 or 293
		ld	a,iyh				; 8	; load channel high byte to ix
		ld	ixh,a				; 8	;
		ld	a,iyl				; 8	; load channel low byte to a
		zadd	a,LS_cVibPtr			; 7	; add vibrato data offset
		ld	ixl,a				; 8	; load finally to ixl
		call	LS_HandlEnv			; 17	; run evenlope processor

		ld	e,a				; 4	; copy offset into e
		zor	a				; 4	; check if its a negative value
		ld	a,-1				; 7	; set a to -1
		jpm	.neg				; 10	; if was negative, branch
		xor	a				; 4	; set a to 0

.neg
		ld	d,a				; 4	; copy a to d
; ------------------------------------------------------------------------------

		ld	l,(iy+LS_cFreq)			; 19	; load frequency to hl
		ld	h,(iy+LS_cFreq+1)		; 19	;
		zadd	hl,de				; 11	; add frequency offset to hl

		ld	(iy+LS_cFreq),l			; 19	; save frequency back to the channel!
		ld	(iy+LS_cFreq+1),h		; 19	;
; ------------------------------------------------------------------------------

		push	hl				; 11	; push into stack
		exx					; 4	; swap register sounds
		pop	bc				; 10	; get it into bc

		ld	a,(iy+LS_cChannel)		; 19	; load channel id to a
		zadd	a,0A4h				; 7	; FREQUENCY MSB
		ld	(hl),a				; 7	; load into command port
		ex	af,af				; 4	; swap into af'

		ld	a,b				; 4	; load frequency MSB to a
		ld	(de),a				; 7	; load value into data port

		ex	af,af				; 4	; swap into af
		res	2,a				; 8	; FREQUENCY LSB
		ld	(hl),a				; 7	; load into command port

		ld	a,c				; 4	; load frequency MSB to a
		ld	(de),a				; 7	; load value into data port
		exx					; 4	; switch register pairs
		ret					; 10
; ==============================================================================
; ------------------------------------------------------------------------------
; Stop command
; ------------------------------------------------------------------------------

LS_Stop:	; 35
		dec	de				; 6	; go back to the command
		res	0,(iy+LS_cFlags)		; 19	; disable soft key
		jp	LS_CommandEnd			; 10	; end tracker read
; ==============================================================================
; ------------------------------------------------------------------------------
; Soft key command
; ------------------------------------------------------------------------------

LS_Soft:	; 55
		ld	a,(iy+LS_cFlags)		; 19	; load flags to a
		xor	1				; 7	; flip soft flag
		ld	(iy+LS_cFlags),a		; 19	; save back
		jp	LS_Commands			; 10	; run next command
; ==============================================================================
; ------------------------------------------------------------------------------
; Set flags command
; ------------------------------------------------------------------------------

LS_Flags:	; 42
		ld	a,(de)				; 7	; load the next byte from tracker
		inc	de				; 6	;
		ld	(iy+LS_cFlags),a		; 19	; save back
		jp	LS_Commands			; 10	; run next command
; ==============================================================================
; ------------------------------------------------------------------------------
; Loop command
; ------------------------------------------------------------------------------

LS_Loop:	; 96, 93 or 110
		ld	a,(iy+LS_cLoop)			; 19	; load current loop counter to a
		zor	a				; 4	; check if 0
		jrz	.is0				; 12/7	; if not, branch
; ------------------------------------------------------------------------------

.not0
		inc	de				; 6	; skip loop counter
		dec	(iy+LS_cLoop)			; 23	; decrement loop counter
		jrnz	LS_Jump				; 12/7	; if not 0, jump again
		inc	de				; 6	; skip jump pointer
		inc	de				; 6	;
		jp	LS_Commands			; 10	; run next command
; ------------------------------------------------------------------------------

.is0
		ld	a,(de)				; 7	; load loop counter into a
		inc	de				; 6	;
		ld	(iy+LS_cLoop),a			; 19	; save loop counter
; ==============================================================================
; ------------------------------------------------------------------------------
; Jump command
; ------------------------------------------------------------------------------

LS_Jump:	; 34
		ex	de,hl				; 4	; swap de and hl
		ld	e,(hl)				; 7	; load low byte to e
		inc	hl				; 6	;
		ld	d,(hl)				; 7	; load high byte to d
		jp	LS_Commands			; 10	; run next command
; ==============================================================================
; ------------------------------------------------------------------------------
; Volume add commands
; ------------------------------------------------------------------------------

LS_Vol1:	; 61
		ld	a,(de)				; 7	; load volume offset to a
		inc	de				; 6	;
		zadd	a,(iy+LS_cVol)			; 19	; add volume operator 1 to a
		ld	(iy+LS_cVol),a			; 19	; save it back to
		jp	LS_Commands			; 10	; run next command
; ------------------------------------------------------------------------------

LS_Vol2:	; 61
		ld	a,(de)				; 7	; load volume offset to a
		inc	de				; 6	;
		zadd	a,(iy+LS_cVol+1)		; 19	; add volume operator 2 to a
		ld	(iy+LS_cVol+1),a		; 19	; save it back to
		jp	LS_Commands			; 10	; run next command
; ------------------------------------------------------------------------------

LS_Vol3:	; 61
		ld	a,(de)				; 7	; load volume offset to a
		inc	de				; 6	;
		zadd	a,(iy+LS_cVol+2)		; 19	; add volume operator 3 to a
		ld	(iy+LS_cVol+2),a		; 19	; save it back to
		jp	LS_Commands			; 10	; run next command
; ------------------------------------------------------------------------------

LS_Vol4:	; 61
		ld	a,(de)				; 7	; load volume offset to a
		inc	de				; 6	;
		zadd	a,(iy+LS_cVol+3)		; 19	; add volume operator 4 to a
		ld	(iy+LS_cVol+3),a		; 19	; save it back to
		jp	LS_Commands			; 10	; run next command
; ==============================================================================
; ------------------------------------------------------------------------------
; Volume add command to every operator
; ------------------------------------------------------------------------------

LS_VolAll:	; 148
		ld	a,(de)				; 7	; load volume offset from tracker
		inc	de				; 6	;
		ld	b,a				; 4	; copy to b

		push	iy				; 15	; put iy into stack
		pop	hl				; 10	; pop as hl

	rept 4
		ld	a,(hl)				; 7	; load channel volume to a
		zor	a				; 4	; check if positive
		jpp	*+4				; 10	; branch if yes

		zadd	a,b				; 4	; add volume offset to a
		ld	(hl),a				; 7	; copy volume back to channel
		inc	hl				; 6	; go to next volume level
	endr
		jp	LS_Commands			; 10	; run next command
; ==============================================================================
; ------------------------------------------------------------------------------
; Volume table load command
; ------------------------------------------------------------------------------

LS_VolTab:	; 258
		ld	b,0				; 7	; clear b
		ld	a,(de)				; 7	; load voice id to a
		inc	de				; 6	;
		zadd	a,a				; 4	; double a
		ld	c,a				; 4	; load to c

		ld	hl,LS_VolumeTable		; 10	; load volume table to hl
		zadd	hl,bc				; 11	; add offset to the table

		ld	a,(hl)				; 7	; load low byte of table to a
		ld	(iy+LS_cVolStr),a		; 19	; save low byte to channel
		inc	hl				; 6	;

		ld	a,(hl)				; 7	; load high byte of table to a
		ld	(iy+LS_cVolStr+1),a		; 19	; save high byte to channel
		jp	LS_Commands			; 10	; run next command
; ==============================================================================
; ------------------------------------------------------------------------------
; Vibrato table load command
; ------------------------------------------------------------------------------

LS_VibTab:	; 258
		ld	b,0				; 7	; clear b
		ld	a,(de)				; 7	; load voice id to a
		inc	de				; 6	;
		zadd	a,a				; 4	; double a
		ld	c,a				; 4	; load to c

		ld	hl,LS_VibratoTable		; 10	; load vibrato table to hl
		zadd	hl,bc				; 11	; add offset to the table

		ld	a,(hl)				; 7	; load low byte of table to a
		ld	(iy+LS_cVibStr),a		; 19	; save low byte to channel
		inc	hl				; 6	;

		ld	a,(hl)				; 7	; load high byte of table to a
		ld	(iy+LS_cVibStr+1),a		; 19	; save high byte to channel
		jp	LS_Commands			; 10	; run next command
; ==============================================================================
; ------------------------------------------------------------------------------
; Special panning for lightning sound
; ------------------------------------------------------------------------------

LS_SpecialPan:; 86
		ld	a,(iy+LS_cChannel)		; 19	; load channel type to a
		ld	b,a				; 4	; copy a to b temporarily
		ex	af,af				; 4	; swap af with af'

		ld	a,b				; 4	; copy a back
		rrca					; 4	; rotate 2 bits
		rrca					; 4	;
		ex	af,af				; 4	; swap af with af'

		exx					; 4	; switch register pairs
		zadd	a,0B4h				; 7	; add algorith/feedback to channel
		ld	(hl),a				; 7	; load into command port

		ex	af,af				; 4	; swap af with af'
		ld	(de),a				; 7	; load value into data port
		exx					; 4	; switch register pairs
		jp	LS_Commands			; 10	; run next command
; ==============================================================================
; ------------------------------------------------------------------------------
; Voice load command
; ------------------------------------------------------------------------------

LS_Voice:	; 1278
		ld	b,0				; 7	; clear b
		ld	a,(de)				; 7	; load voice id to a
		inc	de				; 6	;
		zadd	a,a				; 4	; double a
		ld	c,a				; 4	; load to c

		ld	hl,LS_VoiceTable		; 10	; load voice table to hl
		zadd	hl,bc				; 11	; add offset to the table

		ld	a,(hl)				; 7	; load low byte to a
		inc	hl				; 6	;
		ld	h,(hl)				; 7	; load high byte to h
		ld	l,a				; 4	; copy a to l
; ------------------------------------------------------------------------------

		push	iy				; 15	; put iy into stack
		pop	bc				; 10	; pop as bc

	rept 4
		ld	a,(hl)				; 7	; load voice table to a
		inc	hl				; 6	;
		ld	(bc),a				; 7	; save into channel
		inc	bc				; 6	;
	endr
; ------------------------------------------------------------------------------

		push	hl				; 11	; save into stack
		exx					; 4	; swap register pair
		pop	bc				; 10	; load into bc
		exx					; 4	; swap regs

		ld	a,(iy+LS_cChannel)		; 19	; load channel id to a
		ld	b,a				; 4	; copy to b
; ------------------------------------------------------------------------------

.loadreg	macro reg	; 46
	rept narg
		ld	a,b				; 4	; copy channel type to a
		exx					; 4	; swap regs back
		zadd	a,\reg				; 7	; add register to a

		ld	(hl),a				; 7	; load value into command port
		ld	a,(bc)				; 7	; load value from voice
		inc	bc				; 6	;
		ld	(de),a				; 7	; load value into data port
		exx					; 4	; swap regs
	shift
	endr
    endm
; ------------------------------------------------------------------------------

	; write all teh registers to YM
	.loadreg 0B0h, 0B4h				; 92	; algo & feedback & panning
	.loadreg 030h, 034h, 038h, 03Ch			; 184	; detune & multiple
	.loadreg 050h, 054h, 058h, 05Ch			; 184	; ratescale & attackrate
	.loadreg 060h, 064h, 068h, 06Ch			; 184	; sustainrate & ampmod
	.loadreg 070h, 074h, 078h, 07Ch			; 184	; decayrt
	.loadreg 080h, 084h, 088h, 08Ch			; 184	; sustainlv & releasert
		jp	LS_Commands			; 10	; run next command
; ==============================================================================
; ------------------------------------------------------------------------------
; Total level registers
; ------------------------------------------------------------------------------

LS_TotalLevel:
		dc.b 040h, 044h, 048h, 04Ch			; FM1
		dc.b 041h, 045h, 049h, 04Dh			; FM2
		dc.b 042h, 046h, 04Ah, 04Eh			; FM3
; ==============================================================================
; ------------------------------------------------------------------------------
; Routine for handling envelopes
; ------------------------------------------------------------------------------

LS_HandlEnv:	; 59 or 223+
		dec	(ix+2)				; 23	; decrement delay
		jrz	.env				; 12/7	; if 0, do envelope
		ld	a,(ix+3)			; 19	; load last value
		ret					; 10
; ------------------------------------------------------------------------------

.env
		ld	e,(ix+0)			; 19	; load low byte to e
		ld	d,(ix+1)			; 19	; load low byte to d

.nextbyte
		ld	a,(de)				; 7	; load next byte
		inc	de				; 6	;

		cp	0FCh				; 7	; check if this is a command
		jrc	.delay				; 12/7	; branch if not
; ------------------------------------------------------------------------------

		zand	3h				; 7	; get command offset
		zadd	a,a				; 4	; double a
		zadd	.commands&$FF			; 7	; add commands table low byte
		ld	c,a				; 4	; copy it to c

		ld	a,0				; 7	; clear a
		adc	.commands>>8			; 7	; add high byte with carry
		ld	b,a				; 4	; copy to b

		ld	a,(bc)				; 7	; load low byte to l
		ld	l,a				; 4	;
		inc	bc				; 6	;
		ld	a,(bc)				; 7	; load high byte to h
		ld	h,a				; 4	;
		jp	(hl)				; 4	; jump to command
; ------------------------------------------------------------------------------

.delay
		ld	(ix+2),a			; 19	; save as delay
		ld	a,(de)				; 7	; load next byte
		zadd	a,(ix+4)			; 19	; add value offset
		ld	(ix+3),a			; 19	; save as value

		inc	de				; 6	;
		ld	(ix+0),e			; 19	; save tracker address
		ld	(ix+1),d			; 19	;
		ret					; 10
; ==============================================================================
; ------------------------------------------------------------------------------
; Envelope commands list
; ------------------------------------------------------------------------------

.commands
		dw .offs					; $FC
		dw .jump					; $FD
		dw .loop					; $FE
		dw .stop					; $FF
; ==============================================================================
; ------------------------------------------------------------------------------
; Envelope command to stop envelope into last entry
; ------------------------------------------------------------------------------

.stop		; 33
		xor	a				; 4	; no offset
		ld	(ix+3),a			; 19	; clear last value
		ret					; 10
; ==============================================================================
; ------------------------------------------------------------------------------
; Envelope command to add to value offset
; ------------------------------------------------------------------------------

.offs		; 61
		ld	a,(de)				; 7	; load offset from envelope
		inc	de				; 6	;
		zadd	a,(ix+4)			; 19	; add previous offset to it
		ld	(ix+4),a			; 19	; save it back as offset
		jp	.nextbyte			; 10	; run next command
; ==============================================================================
; ------------------------------------------------------------------------------
; Envelope command to loop envelope
; ------------------------------------------------------------------------------

.loop
		ld	a,(ix+5)			; 19	; load current loop counter to a
		zor	a				; 4	; check if 0
		jrz	.is0				; 12/7	; if yes, branch
; ------------------------------------------------------------------------------

		inc	de				; 6	; skip loop counter
		dec	(ix+5)				; 23	; decrement loop counter
		jrnz	.jump				; 12/7	; if not 0, jump again
		inc	de				; 6	; skip jump pointer
		inc	de				; 6	;
		jp	.nextbyte			; 10	; run next command
; ------------------------------------------------------------------------------

.is0
		ld	a,(de)				; 7	; load loop counter into a
		inc	de				; 6	;
		ld	(ix+5),a			; 19	; save loop counter
; ==============================================================================
; ------------------------------------------------------------------------------
; Envelope command to jump to offset
; ------------------------------------------------------------------------------

.jump		; 34
		ex	de,hl				; 4	; swap de and hl
		ld	e,(hl)				; 7	; load low byte to e
		inc	hl				; 6	;
		ld	d,(hl)				; 7	; load high byte to d
		jp	.nextbyte			; 10	; run next command
; ==============================================================================
; ------------------------------------------------------------------------------
; YM command macros
; ------------------------------------------------------------------------------

; macro for YM Total Level command
lyTL		macro channel, operator, value
	dc.b $00+((\channel-1)*4)+(\operator-1), \value
    endm

; macro for YM Detune & Multiple command
lyDM		macro channel, operator, value
	dc.b $0C+((\channel-1)*4)+(\operator-1), \value
    endm

; macro for YM Rate Scale & Attack Rate command
lyRSAR		macro channel, operator, value
	dc.b $18+((\channel-1)*4)+(\operator-1), \value
    endm

; macro for YM Sustain Rate & Amplitude Modulation command
lySR		macro channel, operator, value
	dc.b $24+((\channel-1)*4)+(\operator-1), \value
    endm

; macro for YM Decay Rate command
lyDR		macro channel, operator, value
	dc.b $30+((\channel-1)*4)+(\operator-1), \value
    endm

; macro for YM Sustain Level & Release Rate command
lySLRR		macro channel, operator, value
	dc.b $3C+((\channel-1)*4)+(\operator-1), \value
    endm

; macro for YM SSG-EG command
lySSGEG		macro channel, operator, value
	dc.b $48+((\channel-1)*4)+(\operator-1), \value
    endm

; macro for YM Feedback & Algorithm command
lyFA		macro channel, value
	dc.b $5A+(\channel-1), \value
    endm

; macro for YM Panninig & LFO Sensitivity command
lyPAN		macro channel, value
	dc.b $5D+(\channel-1), \value
    endm

; macro for YM Frequency LSB command
lyFRL		macro channel, value
	dc.b $54+(\channel-1), \value
    endm

; macro for YM Frequency MSB command
lyFRM		macro channel, value
	dc.b $57+(\channel-1), \value
    endm

; macro for YM Frequency command
lyFR		macro channel, value
	lyFRL	\channel, \value&$FF
	lyFRM	\channel, \value>>8
    endm

; macro for YM CH3 Frequency LSB command
lyFR3L		macro operator, value
	if \operator=1
		dc.b $56, \value

	else
		dc.b $60+(\operator-2), \value
	endif
    endm

; macro for YM CH3 Frequency MSB command
lyFR3M		macro operator, value
	if \operator=1
		dc.b $59, \value

	else
		dc.b $63+(\operator-2), \value
	endif
    endm

; macro for YM CH3 Frequency command
lyFR3		macro operator, value
	lyFR3L	\operator, \value&$FF
	lyFR3M	\operator, \value>>8
    endm

; macro for YM LFO command
lyLFO		macro value
	dc.b $66, \value
    endm

; macro for YM Key command
lyKey		macro value
	dc.b $67, \value
    endm

; macro for YM Timer B command
lyTB		macro value
	dc.b $68, \value
    endm

; macro for YM Timer A LSB command
lyTAL		macro value
	dc.b $69, \value
    endm

; macro for YM Timer A MSB command
lyTAM		macro value
	dc.b $6A, \value
    endm

; macro for YM Timer A command
lyTA		macro value
	lyTAL	\value&3
	lyTAM	\value>>2
    endm
; ==============================================================================
; ------------------------------------------------------------------------------
; YM register conversion table
; ------------------------------------------------------------------------------

LS_RegCvtTbl:
		db 40h,  44h,  48h,  4Ch			; CH1 TOTAL LEVEL
		db 41h,  45h,  49h,  4Dh			; CH2 TOTAL LEVEL
		db 42h,  46h,  4Ah,  4Eh			; CH3 TOTAL LEVEL

		db 30h,  34h,  38h,  3Ch			; CH1 DETUNE & MULTIPLE
		db 31h,  35h,  39h,  3Dh			; CH2 DETUNE & MULTIPLE
		db 32h,  36h,  3Ah,  3Eh			; CH3 DETUNE & MULTIPLE

		db 50h,  54h,  58h,  5Ch			; CH1 RATE SCALE & ATTACK RATE
		db 51h,  55h,  59h,  5Dh			; CH2 RATE SCALE & ATTACK RATE
		db 52h,  56h,  5Ah,  5Eh			; CH3 RATE SCALE & ATTACK RATE

		db 60h,  64h,  68h,  6Ch			; CH1 SUSTAIN RATE & AMP MOD
		db 61h,  65h,  69h,  6Dh			; CH2 SUSTAIN RATE & AMP MOD
		db 62h,  66h,  6Ah,  6Eh			; CH3 SUSTAIN RATE & AMP MOD

		db 70h,  74h,  78h,  7Ch			; CH1 DECAY RATE
		db 71h,  75h,  79h,  7Dh			; CH2 DECAY RATE
		db 72h,  76h,  7Ah,  7Eh			; CH3 DECAY RATE

		db 80h,  84h,  88h,  8Ch			; CH1 SUSTAIN LEVEL & RELEASE RATE
		db 81h,  85h,  89h,  8Dh			; CH1 SUSTAIN LEVEL & RELEASE RATE
		db 82h,  86h,  8Ah,  8Eh			; CH1 SUSTAIN LEVEL & RELEASE RATE

		db 90h,  94h,  98h,  9Ch			; CH1 SSG-EG
		db 91h,  95h,  99h,  9Dh			; CH1 SSG-EG
		db 92h,  96h,  9Ah,  9Eh			; CH1 SSG-EG

		db 0A0h, 0A1h, 0A2h				; FREQUENCY LSB
		db 0A4h, 0A5h, 0A6h				; FREQUENCY MSB
		db 0B0h, 0B2h, 0B3h				; FEEDBACK, ALGORITHM
		db 0B4h, 0B5h, 0B6h				; PANNING, LFO SENSITIVITY

		db 0A8h, 0A9h, 0AAh				; CH3 FREQUENCY LSB
		db 0ACh, 0ADh, 0AEh				; CH3 FREQUENCY MSB
		db 022h						; LFO
		db 028h						; KEY
		db 026h						; TIMER B
		db 024h, 25h					; TIMER A LSB & MSB
; ==============================================================================
; ------------------------------------------------------------------------------
; Sound macros
; ------------------------------------------------------------------------------

lCommandFirst =	$F0

; macro to stop channel
lStop		macro
	dc.b $FF
    endm

; macro to loop in a spot for some time
lLoop		macro count, pos
	dc.b $FE, \count-1
	dw \pos
    endm

; macro to jump to a specific spot
lJump		macro pos
	dc.b $FD
	dw \pos
    endm

; macro to jump to add offset to envelope value
lOffset		macro offs
	dc.b $FC, \offs
    endm

; macro for special panning
lSpecPan	macro
	dc.b $FC
    endm

; macro to set channel flags and key mask
lFlags		macro flags
	dc.b $F9, \flags
    endm

; command to disable note-on behavior
lSoft =		$F8

; macro to load a voice into channel
lVoice		macro id
	dc.b $F7, \id
    endm

; macro to set the vibrato table address based on the id
lVibTab		macro id
	dc.b $F6, \id
    endm

; macro to set the volume table address based on the id
lVolTab		macro id
	dc.b $F5, \id
    endm

; macro to change volume for every operator
lVolAll		macro vol
	dc.b $F4, \vol
    endm

; macro to change the channel volume
lVol		macro op, vol
	dc.b $F0+(\op-1), \vol
    endm
; ==============================================================================
; ------------------------------------------------------------------------------
; Note equates
; ------------------------------------------------------------------------------

; this macro is created to emulate enum in AS
enum		macro lable
	rept narg
\lable =	_num
_num =		_num+1
	shift
	endr
    endm

_num =		81h
	enum nC0,nCs0,nD0,nDs0,nE0,nF0,nFs0,nG0,nGs0,nA0,nAs0,nB0	; $8C
	enum nC1,nCs1,nD1,nDs1,nE1,nF1,nFs1,nG1,nGs1,nA1,nAs1,nB1	; $98
	enum nC2,nCs2,nD2,nDs2,nE2,nF2,nFs2,nG2,nGs2,nA2,nAs2,nB2	; $A4
	enum nC3,nCs3,nD3,nDs3,nE3,nF3,nFs3,nG3,nGs3,nA3,nAs3,nB3	; $B0
	enum nC4,nCs4,nD4,nDs4,nE4,nF4,nFs4,nG4,nGs4,nA4,nAs4,nB4	; $BC
	enum nC5,nCs5,nD5,nDs5,nE5,nF5,nFs5,nG5,nGs5,nA5,nAs5,nB5	; $C8
	enum nC6,nCs6,nD6,nDs6,nE6,nF6,nFs6,nG6,nGs6,nA6,nAs6,nB6	; $D4
	enum nC7,nCs7,nD7,nDs7,nE7,nF7,nFs7,nG7,nGs7,nA7,nAs7,nB7	; $E0
; ==============================================================================
; ------------------------------------------------------------------------------
; Lightning sound
; ------------------------------------------------------------------------------

LS_sLightning_FM23:
	lVoice		$02
	lSpecPan
	lVibTab		$01
	db nA3, $03, nA2, $03, nGs3, $03, nGs2, $03
	db nG3, $03, nG2, $03, nFs3, $03, nFs2, $03
	db nF3, $03, nF2, $03, nE3, $03, nE2, $03
	db nDs3, $03, nDs2, $03, nD3, $03, nD2, $03
	db nCs3, $03, nCs2, $03, nC3, $03, nC2, $03
	db nB2, $03, nB1, $03, nAs2, $03, nAs1, $03
	lVol		4, -$02

.loop
	lVol		4, $0E
	db nC3, $03, nC2, $03, nB2, $03, nB1, $03
	db nAs2, $03, nAs1, $03, nA2, $03, nA1, $03
	db nGs2, $03, nGs1, $03, nG2, $03, nG1, $03
	db nFs2, $03, nFs1, $03, nF2, $03, nF1, $03
	db nE2, $03, nE1, $03, nDs2, $03, nDs1, $03
	db nD2, $03, nD1, $03, nCs2, $03, nCs1, $03
	lLoop		5, .loop
	lStop
; ==============================================================================
; ------------------------------------------------------------------------------
; Cycle sound
; ------------------------------------------------------------------------------

LS_sCycle_FM1:
	lVoice		$00
	lVibTab		$02
	lVolTab		$01

.loop
	rept 2
		db nF3, $60
		lVolAll		$1A
		lVol		2, -$05
		db nFs3, $40
		lVolAll		-$1A
		lVol		2, $05
		lVol		1, $01
	endr
	lVol		2, $01
	lLoop		$07, .loop

	lVibTab		$03
	lVolTab		$02
	db nF3, $B4
	lStop
; ==============================================================================
; ------------------------------------------------------------------------------
; Reveal sound
; ------------------------------------------------------------------------------

LS_sReveal_FM1:
	lVoice		$03
	lVibTab		$04
	db nCs2, $0B, nF2, $0B, nB2, $0B, nCs3, $0B
	lVolAll		-$04
	lVol		1, $04

.loop
	db nCs2, $0B, nF2, $0B, nB2, $0B, nCs3, $0B
	lVol		1, $03
	lVolAll		$04
	lLoop		12, .loop

LS_sNull:
	lStop
; ==============================================================================
; ------------------------------------------------------------------------------
; Logo sound
; ------------------------------------------------------------------------------

LS_sLogo_FM1:
	lVoice		$01
	db nC1, $02, lSoft, nC2, $02, nCs1, $02, nCs2, $02, nD1, $02, nD2, $02, nDs1, $02, nDs2, $02
	db nE1, $02, nE2, $02, nF1, $02, nF2, $02, nFs1, $02, nFs2, $02, nG1, $02, nG2, $02
	db nGs1, $02, nGs2, $02, nA1, $02, nA2, $02, nAs1, $02, nAs2, $02, nB1, $02, nB2, $02
	db nC2, $02, nC3, $02, nCs2, $02, nCs3, $02, nD2, $02, nD3, $02, nDs2, $02, nDs3, $02
	db nE2, $02, nE3, $02, nF2, $02, nF3, $02, nFs2, $02, nFs3, $02, nG2, $02, nG3, $02
	db nGs2, $02, nGs3, $02, nA2, $02, nA3, $02, nAs2, $02, nAs3, $02, nB2, $02, nB3, $02
	db nC3, $02, nC4, $02, nCs3, $02, nCs4, $02, nD3, $02, nD4, $02, nDs3, $02, nDs4, $02
	db nE3, $02, nE4, $02, nF3, $02, nF4, $02, nFs3, $02, nFs4, $02, nG3, $02, nG4, $02
	db nGs3, $02, nGs4, $02, nA3, $02, nA4, $02, nAs3, $02, nAs4, $02, nB3, $02, nB4, $02, lSoft

.loop
	db nC4, $02, lSoft, nC5, $02, nB3, $02, nB4, $02, nAs3, $02, nAs4, $02, nA3, $02, nA4, $02
	db nGs3, $02, nGs4, $02, nG3, $02, nG4, $02, nFs3, $02, nFs4, $02, nF3, $02, nF4, $02
	db nE3, $02, nE4, $02, nDs3, $02, nDs4, $02, nD3, $02, nD4, $02, nCs3, $02, nCs4, $02
	db nC3, $02, nC4, $02, nB2, $02, nB3, $02, nAs2, $02, nAs3, $02, nA2, $02, nA3, $02
	db nGs2, $02, nGs3, $02, nG2, $02, nG3, $02, nFs2, $02, nFs3, $02, nF2, $02, nF3, $02
	db nE2, $02, nE3, $02, nDs2, $02, nDs3, $02, nD2, $02, nD3, $02, nCs2, $02, nCs3, $02, lSoft
	lVol		4, $04
	lLoop		12, .loop
	lStop
; ==============================================================================
; ------------------------------------------------------------------------------
; Typing sound
; ------------------------------------------------------------------------------

LS_sType_FM2:
	lVoice		$04

.loop
	db nG0, $06, nE0, $0C, nAs0, $12
	lLoop		4, .loop
	lStop
; ==============================================================================
; ------------------------------------------------------------------------------
; Green Hill Zone remix
; ------------------------------------------------------------------------------

LS_sGHZ_FM1:
	lVoice		$05
	lVolAll		$12
	lVibTab		$05
;	lVolTab		$01
	lyPAN		1, $40

	db nA5, $2C, nF5, $2C, nA5, $2C, nF5, $2C, nB5, $2C, nG5, $2C, nB5, $2C
	db nG5, $2C, nC6, $2C, nA5, $2C, nC6, $2C, nA5, $2C, nD6, $2C, nB5, $2C
	db nD6, $2C, nB5, $2C

.loop0
	lyPAN		1, $80
	db nE6, $2C
	lyPAN		1, $40
	db nC6, $2C
	lVolAll		$01
	lLoop		$0D, .loop0

	db nE6, $1E
	lyKey		0, $00
	db nC0, $5E
	lyPAN		1, $C0

.delay0
	dc.b nC0, $C0
	lLoop		12, .delay0

	lVoice		$06
	lVolAll		$06
	db nC5, $58, nA4, $B0, nC5, $58, nB4, $B0
	db nC5, $58, nB4, $B0, nG4, $84, lSoft, nG4, $84, nG4, $84, nG4, $84, lSoft
	db nA4, $58, nE5, $58, nD5, $B0, nC5, $58
	db nB4, $B0, nC5, $58, nB4, $B0
	db nG4, $9A, lSoft, nG4, $9A, nG4, $9A, nG4, $9A, lSoft, nC5, $58
	db nA4, $B0, nC5, $58, nB4, $B0, nC5, $58
	db nB4, $B0, nG4, $84, lSoft, nG4, $84, nG4, $84, nG4, $84, lSoft
	db nA4, $58, nA4, $58, nF4, $B0, nA4, $58
	db nG4, $B0, nA4, $58, nG4, $B0

	db nC4, $84, lSoft, nC4, $84, nC4, $84, nC4, $84, lSoft

	db nC5, $58, nA4, $B0, nC5, $58, nB4, $B0
	db nC5, $58, nB4, $B0, nG4, $84, lSoft, nG4, $84, nG4, $84, nG4, $84, lSoft
	db nA4, $58, nE5, $58, nD5, $B0, nC5, $58
	db nB4, $B0, nC5, $58, nB4, $B0
	db nG4, $9A, lSoft, nG4, $9A, nG4, $9A, nG4, $9A, lSoft, nC5, $58
	db nA4, $B0, nC5, $58, nB4, $B0, nC5, $58
	db nB4, $B0, nG4, $84, lSoft, nG4, $84, nG4, $84, nG4, $84, lSoft
	db nA4, $58, nA4, $58, nF4, $B0, nA4, $58
	db nG4, $B0, nA4, $58, nG4, $B0

	db nC4, $58, nC4, $58, nE4, $58
	lStop
; ==============================================================================
; ------------------------------------------------------------------------------
; Voice table data
; ------------------------------------------------------------------------------

LS_VoiceTable:
		dw LS_vCycle					; $00
		dw LS_vLogo					; $01
		dw LS_vLightning				; $02
		dw LS_vReveal					; $03
		dw LS_vType					; $04
		dw LS_vGHZ2					; $05
		dw LS_vGHZ6					; $06
; ------------------------------------------------------------------------------

LS_vGHZ2:
		db $18, $80, $80, $80				; totallevel
		db $36, $C0					; algo & feedback & panning
		db $0F, $01, $01, $01				; detune & multiple
		db $1F, $1F, $1F, $1F				; ratescale & attackrate
		db $12, $11, $0E, $00				; sustainrate & ampmod
		db $00, $0A, $07, $09				; decayrt
		db $FF, $0F, $1F, $0F				; sustainlv & releasert
; ------------------------------------------------------------------------------

LS_vGHZ6:
		db $23, $23, $80, $80				; totallevel
		db $04, $C0					; algo & feedback & panning
		db $72, $32, $42, $32				; detune & multiple
		db $12, $12, $12, $12				; ratescale & attackrate
		db $00, $00, $08, $08				; sustainrate & ampmod
		db $00, $00, $08, $08				; decayrt
		db $0F, $1F, $0F, $1F				; sustainlv & releasert
; ------------------------------------------------------------------------------

LS_vCycle:
		db $20, $10, $87, $83				; totallevel
		db $14, $C0					; algo & feedback & panning
		db $15, $12, $03, $11				; detune & multiple
		db $10, $1F, $18, $10				; ratescale & attackrate
		db $10, $16, $0C, $00				; sustainrate & ampmod
		db $02, $02, $02, $02				; decayrt
		db $2F, $2F, $FF, $3F				; sustainlv & releasert
; ------------------------------------------------------------------------------

LS_vLogo:
		db $20, $26, $20, $83				; totallevel
		db $38, $C0					; algo & feedback & panning
		db $07, $04, $01, $01				; detune & multiple
		db $1F, $1F, $1F, $1F				; ratescale & attackrate
		db $00, $00, $00, $00				; sustainrate & ampmod
		db $00, $00, $00, $00				; decayrt
		db $0F, $0F, $0F, $0F				; sustainlv & releasert
; ------------------------------------------------------------------------------

LS_vLightning:
		db $14, $04, $08, $83				; totallevel
		db $3B, $C0					; algo & feedback & panning
		db $00, $01, $0A, $02				; detune & multiple
		db $1F, $1F, $1F, $1F				; ratescale & attackrate
		db $00, $00, $00, $00				; sustainrate & ampmod
		db $00, $00, $00, $00				; decayrt
		db $0F, $0F, $0F, $0F				; sustainlv & releasert
; ------------------------------------------------------------------------------

LS_vReveal:
		db $1A, $92, $8A, $8A				; totallevel
		db $3D, $C0					; algo & feedback & panning
		db $38, $52, $58, $34				; detune & multiple
		db $1F, $1F, $1F, $1F				; ratescale & attackrate
		db $1F, $1F, $1F, $1F				; sustainrate & ampmod
		db $00, $00, $00, $00				; decayrt
		db $0F, $0F, $0F, $0F				; sustainlv & releasert
; ------------------------------------------------------------------------------

LS_vType:
		db $00, $00, $5B, $80				; totallevel
		db $20, $C0					; algo & feedback & panning
		db $7C, $70, $7F, $7F				; detune & multiple
		db $1F, $1F, $1F, $1F				; ratescale & attackrate
		db $00, $00, $00, $1F				; sustainrate & ampmod
		db $00, $00, $00, $16				; decayrt
		db $F0, $F0, $F0, $0F				; sustainlv & releasert
; ==============================================================================
; ------------------------------------------------------------------------------
; Volume table data
; ------------------------------------------------------------------------------

LS_VolumeTable:
		dw LS_ioNull					; $00
		dw LS_oCycle1					; $01
		dw LS_oCycle2					; $02
; ------------------------------------------------------------------------------

LS_ioNull:
	db $F0, $00
	lStop
; ------------------------------------------------------------------------------

LS_oCycle1:
	db $04, $00, $03, $06
	lJump		LS_oCycle1
; ------------------------------------------------------------------------------

LS_oCycle2:
	db $04, $00, $03, $06
	db $04, $00, $03, $06
	lOffset		$01
	lJump		LS_oCycle2
; ==============================================================================
; ------------------------------------------------------------------------------
; Vibrato table data
; ------------------------------------------------------------------------------

LS_VibratoTable:
		dw LS_ioNull					; $00
		dw LS_iLightning1				; $01
		dw LS_iCycle1					; $02
		dw LS_iCycle2					; $03
		dw LS_iReveal					; $04
		dw LS_iTest					; $05
; ------------------------------------------------------------------------------

LS_iCycle1:
	db $01, -$02
	lLoop		$06, LS_iCycle1
	lOffset		-$01
	lLoop		$08, LS_iCycle1
; ------------------------------------------------------------------------------

LS_iCycle2:
	db $08, -$06, $10, $06, $08, -$06
	lOffset		-$02
	lJump		LS_iCycle2
; ------------------------------------------------------------------------------

LS_iLightning1:
	db $01, $00, $01, -$80, $01, -$50, $01, $00
	lStop
; ------------------------------------------------------------------------------

LS_iReveal:
	db $02, $06, $04, -$06, $02, $06
	lJump		LS_iReveal
; ------------------------------------------------------------------------------

LS_iTest:
	db $04, $02, $03, -$02, $03, $02, $04, -$02
	lJump		LS_iTest
; ------------------------------------------------------------------------------
