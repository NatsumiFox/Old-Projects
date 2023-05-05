; ---------------------------------------------------------------------------
	rsreset
Pause_Routine	rs.l 1; current resize routine
Pause_ShHi	rs.l 1; shadow/highlight
Pause_Music	rs.l 1; music selector
Pause_Exit	rs.l 1; Exit pause menu
PauseCount	rs.l 0; number of entries

PauseTextBase	= $400	; base VRAM address of pause menu text
PauseLineWidth	= 20	; width of the text for each line

	rsset 8		; d2 bit order
PauseD2_ShHi	rs.b	1; Shadow/Highlight bit

; ---------------------------------------------------------------------------

PauseMenu:
		move	#$2700,sr		; disable ints
		jsr	ClearDisplay
	; load font
		lea	DebugFont,a0		; get font
		lea	Kos_decomp_buffer.w,a1	; get decomp buffer
		jsr	KosDec			; decompress the art

		moveq	#Pause_Exit,d0
		move.w	#$2000,d1
		moveq	#0,d2

		lea	VDP_data_port,a6
		lea	4(a6),a5
		lea	PauseMenuPtrs(pc),a4
	dma68kToVDP	Kos_decomp_buffer, PauseTextBase*32, $BC0, VRAM; DMA font art

.main		move.b	#6,VInt_Routine.w
		jsr	wait_vsync.w		; wait for v-int
		move	#$2700,sr		; disable ints

		bsr.s	.render
		jsr	Pause_Control(pc)
		bra.s	.main			; keep looping
; ---------------------------------------------------------------------------

.render		pea	.high(pc)		; go here later
		move.w	d0,d7			; copy current cursor position
		subq.w	#4,d7			; get the last line
		bpl.s	.k			; if positive, branch
		add.w	#PauseCount,d7		; go back to the top
.k		bsr.s	.dma			; dma the art

		move.w	d0,d7			; copy current cursor position
		addq.w	#4,d7			; get the next line
		cmp.w	#PauseCount,d7		; check if we are beyond the last entry
		bne.s	.dma			; branch if no
		clr.w	d7			; keep in range

.dma		move.l	(a4,d7.w),(a5)		; set DMA source
		move.l	#$94009300|PauseLineWidth,(a5); set DMA size
		move.w	#$9700,(a5)		; set DMA source high byte
		move.l	PauseMenuComms-PauseMenuPtrs(a4,d7.w),(a5); put final command word and dma!
.rts		rts
; ---------------------------------------------------------------------------

.high	; draw highlighted line
		move.w	d0,d7			; copy current cursor position
		mulu.w	#PauseLineWidth/2,d7	; multiply by our line length
		lea	PauseMenuMap(pc,d7.w),a0; get mappings ptr
		move.l	PauseMenuComms-PauseMenuPtrs(a4,d0.w),d6; get the VDP command
		bclr	#7,d6			; set from DMA to write
		move.l	d6,(a5)			; set VRAM WRITE mode

		moveq	#PauseLineWidth-1,d5	; get loop counter
.loadloop	move.w	(a0)+,d7		; get the next maps word
		or.w	d1,d7			; display on line 2 instead of 1
		move.w	d7,(a6)			; put this into VDP
		dbf	d5,.loadloop		; loop til done
		rts

; ---------------------------------------------------------------------------
PauseMenuMap:
	asc.w $0000,"RESIZE ROUTINE      ",PauseTextBase-1
	asc.w $0000,"SHADOW/HIGHLIGHT    ",PauseTextBase-1
	asc.w $0000,"PLAY SOUND          ",PauseTextBase-1
	asc.w $0000,"EXIT                ",PauseTextBase-1
; ---------------------------------------------------------------------------
		dc.l 0	; do not render
PauseMenuPtrs:
.ptr =	offset(PauseMenuMap)
	rept PauseCount/4
		dc.w $9600|((((.ptr)>>1)&$FF00)>>8),$9500|(((.ptr)>>1)&$FF)
.ptr =	.ptr+(PauseLineWidth*2)
	endr
		dc.l 0	; do not render

PauseMenuComms:
.ptr =	$C004
	rept PauseCount/4
		vdpComm	dc.l,.ptr,VRAM,DMA
.ptr =	.ptr+$80
	endr
; ---------------------------------------------------------------------------

Pause_Control:
		moveq	#0,d7
		move.b	Ctrl_1_Press.w,d7	; get controller input for p1
		or.b	Ctrl_2_Press.w,d7	; or controller input for p2

		btst	#0,d7			; check if up is pressed
		beq.s	.noup			; branch if not pressed
		subq.w	#4,d0			; move 1 up
		bpl.s	.noup			; branch if still positive
		add.w	#PauseCount,d0		; go to the top

.noup		btst	#1,d7			; check if down is pressed
		beq.s	.nodown			; branch if not pressed
		addq.w	#4,d0			; go 1 line below
		cmp.w	#PauseCount,d0		; check if we are beyond the last entry
		bne.s	.nodown			; branch if no
		clr.w	d0			; keep in range

.nodown		lsr.w	#1,d7			; shift out the up/down button presses
		moveq	#0,d5			; set button press 0
		moveq	#6-1,d6			; deal with 6 different button presses
		lea	.buttonids(pc),a0	; get button ID list

.chkloop	lsr.w	#1,d7			; get next button press
		beq.s	.next			; branch if not set
		move.b	(a0),d5			; set the active state

.next		addq.w	#1,a0			; get next pointer
		dbf	d6,.chkloop		; check next presses

		move.w	d0,d7			; copy current cursor position
		muls.w	#7,d7			; multiply 7 times; 7 different routines
		add.w	d5,d7			; add the button press offset
		jmp	.offs(pc,d7.w)		; jump to appropriate code
; ---------------------------------------------------------------------------
.buttonids	dc.b $04, $08, $0C, $10, $14, $18
; ---------------------------------------------------------------------------

.offs
	; RESIZE ROUTINE
	bra.w	.resizerender
	subq.b	#2,d2		; last routine
	rts
	addq.b	#2,d2		; next routine
	rts
	rept 3
		nop
		nop
	endr
	bra.w	.resizeput

	; SHADOW/HIGHLIGHT
	bra.w	.rendershhi
	nop
	nop
	bchg	#PauseD2_ShHi,d2

	rept 3
		nop
		nop
	endr
	bra.w	.setshhi


	; PLAY MUSIC
	bra.w .musplayrender
	bra.w .musplayleft
	bra.w .musplayright
	bra.w .musplayminus10
	bra.w .musplaynegate
	bra.w .musplayplus10
	bra.w .musplayplay

	; EXIT
	rept 3
		rts
		rts
	endr

	rept 3
		nop
		nop
	endr
		addq.w	#4,sp		; do not return to caller
		pea	sub_1AA6E
	if debug=1
		sf	Level_Lag_Crash.w
		pea	PreloadLevelData2
	endif
		jmp	LevelSetup2
; ---------------------------------------------------------------------------
.musplayleft	sub.l	#$10000,d0	; last song
		rts
.musplayright	add.l	#$10000,d0	; next song
		rts
.musplayminus10	sub.l	#$100000,d0	; last song
		rts
.musplayplus10	add.l	#$100000,d0	; next song
		rts
.musplaynegate	bchg	#23,d0		; change the high bit of the sound ID
		rts
.musplayplay	swap	d0
		jsr	PlayMusic.w	; play teh musics
		swap	d0
		rts
.musplayrender	swap	d0
		move.w	d0,d7		; get ID
		swap	d0
		bra.w	RenderNumber	; render the number at d7

; ---------------------------------------------------------------------------
.rendershhi	btst	#PauseD2_ShHi,d2; check if bit is set
		bra.w	RenderBool

.setshhi	lea	.hilodat(pc),a0	; get data ptr
		btst	#PauseD2_ShHi,d2; check if bit is set
		bra.w	PauseVDPComm	; do VDP command

.hilodat	dc.w $8C00|%10000001, $8C00|%10001001
; ---------------------------------------------------------------------------
.resizeput	lea	Debug_RezTbl(pc),a0
		move.w	(a0,d2.w),Dynamic_Resize_Routine.w
		move.w	Debug_CLKtbl-Debug_RezTbl(a0,d2.w),Camera_LockOff.w
		rts
.resizerender	move.w	d2,d7		; get ID
; ---------------------------------------------------------------------------
RenderNumber:
		move.w	d7,d6		; copy number
		and.w	#$F,d6		; keep in range
		add.w	#PauseTextBase,d6; add the letter offset
		move.w	d6,-(sp)	; store to stack

		lsr.w	#4,d7		; get next nibble
		and.w	#$F,d7		; keep in range
		add.w	#PauseTextBase,d7; add the letter offset

		move.l	PauseMenuComms-PauseMenuPtrs(a4,d0.w),d6; get the VDP command
		bclr	#7,d6			; set from DMA to write
		add.l	#PauseLineWidth<<17,d6	; put to correct offset
		move.l	d6,(a5)			; set VRAM WRITE mode

		move.w	d7,(a6)			; store the number
		move.w	(sp)+,(a6)		; store the number
		rts

RenderBool:
		move	sr,d7			; atore ccr for now
		move.l	PauseMenuComms-PauseMenuPtrs(a4,d0.w),d6; get the VDP command
		bclr	#7,d6			; set from DMA to write
		add.l	#PauseLineWidth<<17,d6	; put to correct offset
		move.l	d6,(a5)			; set VRAM WRITE mode

		lea	PauseOnOff(pc),a0	; get the pause menu text
		move	d7,sr			; get ccr back
		beq.s	.off			; branch if off
		addq.w	#6,a0			; get the on data

.off		move.l	(a0)+,(a6)		; get 2 letters
		move.w	(a0),(a6)		; get next letter
		rts
; ---------------------------------------------------------------------------
PauseOnOff:	asc.w $0000,"OFFON ",PauseTextBase-1
; ---------------------------------------------------------------------------
PauseVDPComm:
		beq.s	.off			; branch if off
		move.w	2(a0),(a5)		; set VDP command
		rts

.off		move.w	(a0),(a5)		; set VDP command
		rts
; ---------------------------------------------------------------------------
