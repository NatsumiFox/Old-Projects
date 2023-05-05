
; ---------------------------------------------------------------
; Init program
; ---------------------------------------------------------------
  
Player:
	; init joypads
	moveq	#$40,d0
	move.b	d0,$A10009
	move.b	d0,$A1000B
	move.b	d0,$A1000D


; ---------------------------------------------------------------
; Setup SMPS
; ---------------------------------------------------------------

	jsr	SoundDriverLoad

	moveq	#$FFFFFFE4,d0
	jsr	PlaySound	; Reset SMPS
	jsr	UpdateMusic	; Force SMPS process
	moveq	#$FFFFFF81,d0
	jsr	PlaySound
	
; ---------------------------------------------------------------
; Player initialization
; ---------------------------------------------------------------

	lea	VDP_Data,a5	; a5 = VDP_Data
	lea	4(a5),a6	; a6 = VDP_Ctrl

	; Setup VPD regs
	move.w	#$8200|(PlaneA/$400),(a6)	; Plane A base
	move.w	#$8300|(PlaneB/$2000),(a6)	; Plane B base
	move.w	#$8D00|(HSRAM/$400),(a6)	; HSRAM base
	move.w	#$8700,(a6)	; backdrop color
	move.w	#$8B00,(a6)	; VScr:full, HScr:full
	move.w	#$8C81,(a6)	; H40
	move.w	#$8F02,(a6)	; increment $02 
	
	; Load palette
	cram	$00,(a6)
	move.l	#$00000EEE,(a5)
	
	; Reset HSRAM
	moveq	#0,d0
	vram	HSRAM,(a6)
	move.l	d0,(a5)

	; Load player font
	lea	Font,a0		; a0 = Gfx
	vram	FontBase,(a6)
	move.w	#95*8-1,d0	; d0 = Rownum-1
	moveq	#1,d1		; d1 = 1Mask
	moveq	#0,d2		; d2 = 0Mask

@DrawRow:
	move.b	(a0)+,d3	; d3 = 1bpp row
	moveq	#7,d4
	moveq	#0,d5		; d5 = 4bpp row

@DrawPixel:
	rol.b	d3
	bcc	@0Mask		; if pixel 0
	or.l	d1,d5
	bra	@MaskR
@0Mask:	or.l	d2,d5
@MaskR:	rol.l	#4,d1
	rol.l	#4,d2
	dbf	d4,@DrawPixel	; repeat for 8 pixels

	move.l	d5,(a5)		; output row of 8 pixels
	dbf	d0,@DrawRow

	move.w	#$8174,(a6)

; ---------------------------------------------------------------
; Player main loop
; ---------------------------------------------------------------

Player_MainLoop:
	jsr	VSync

	; Update sounds
	movem.l	d0-a6,-(sp)
	jsr	UpdateMusic
	movem.l	(sp)+,d0-a6
	
	; Draw debug info
	lea	@Interface,a1

@UpdateInterface:
        tst.w	(a1)			; end of list reached?
        bmi.s	Player_MainLoop		; if yes, branch

	move.l	(a1)+,(a6)		; load VDP location

	move.w	(a1)+,d2		; load string block size
	lea	(a1),a0			; load string
	jsr	Player_DrawString
	adda.w	d2,a1

	move.w	(a1)+,d2		; load value size
	bmi.s	@UpdateInterface	; if it's not present, branch
	movea.l	(a1)+,a0
@val	move.b	(a0)+,d0
	jsr	Player_DrawNumber
	dbf	d2,@val
	
	bra.s	@UpdateInterface

; --------------------------------------------------------------- 
FM1	= 0
FM2	= 1
FM3	= 2
FM4	= 3
FM5	= 4
FM6	= 5
byte	= 1
word	= 2

chanram	macro	id,var
	dc.l	v_snddriver_ram+v_fm1_track+zTrackSz*\id+\var
	endm

chanram_x	macro	id,var
	dc.l	v_snddriver_ram+TS_ExtChannels+TS_ExtChannelSize*\id+\var
	endm

cstr	macro	str
	dc.w	@end\@-*-2
	dc.b	\str,0
	even
@end\@
	endm

_setpos	macro	pos
@ScrPos	set	\pos
	endm

dcpos	macro
	dcvram	@ScrPos
	endm

_break	macro
@ScrPos	set	@ScrPos+$80
	endm
	

dram	macro	str, addr, size
	dcpos
	cstr	\str
	dc.w	\size-1
	dc.l	v_snddriver_ram+\addr
	_break
	endm
	
dstr	macro	str
	dcpos
	cstr	\str
	dc.w	-1
	_break
	endm

dchan	macro	str, id, var, size
	dcpos
	cstr	\str
	dc.w	\size-1
	chanram	\id, \var
	_break
	endm

dchan_x	macro	str, id, var, size
	dcpos
	cstr	\str
	dc.w	\size-1
	chanram_x	\id, \var
	_break
	endm

; ---------------------------------------------------------------
@Interface:
	_setpos	PlaneB+2+$80

	dstr	'------ FM1 ------'
	dchan_x	'note:        ', FM1, note, word
	dchan_x	'note_target: ', FM1, note_target, word
	dchan_x	'note_step:   ', FM1, note_step, word
	dchan_x	'slide:       ', FM1, slide_mode, word
	dchan_x	'lastnote:    ', FM1, lastnote, byte
	dchan_x	'volume_note: ', FM1, note_volume, byte
	dchan   'volume_chan: ', FM1, 9, byte
	_break

	dstr	'------ FM2 ------'
	dchan_x	'note:        ', FM2, note, word
	dchan_x	'note_target: ', FM2, note_target, word
	dchan_x	'note_step:   ', FM2, note_step, word
	dchan_x	'slide:       ', FM2, slide_mode, word
	dchan_x	'lastnote:    ', FM2, lastnote, byte
	dchan_x	'volume_note: ', FM2, note_volume, byte
	dchan   'volume_chan: ', FM2, 9, byte
	_break

	dstr	'------ FM3 ------'
	dchan_x	'note:        ', FM3, note, word
	dchan_x	'note_target: ', FM3, note_target, word
	dchan_x	'note_step:   ', FM3, note_step, word
	dchan_x	'slide:       ', FM3, slide_mode, word
	dchan_x	'lastnote:    ', FM3, lastnote, byte
	dchan_x	'volume_note: ', FM3, note_volume, byte
	dchan   'volume_chan: ', FM3, 9, byte
	_break

	_setpos	PlaneB+40+2+$80

	dstr	'------ FM4 ------'
	dchan_x	'note:        ', FM4, note, word
	dchan_x	'note_target: ', FM4, note_target, word
	dchan_x	'note_step:   ', FM4, note_step, word
	dchan_x	'slide:       ', FM4, slide_mode, word
	dchan_x	'lastnote:    ', FM4, lastnote, byte
	dchan_x	'volume_note: ', FM4, note_volume, byte
	dchan   'volume_chan: ', FM4, 9, byte
	_break

	dstr	'------ FM5 ------'
	dchan_x	'note:        ', FM5, note, word
	dchan_x	'note_target: ', FM5, note_target, word
	dchan_x	'note_step:   ', FM5, note_step, word
	dchan_x	'slide:       ', FM5, slide_mode, word
	dchan_x	'lastnote:    ', FM5, lastnote, byte
	dchan_x	'volume_note: ', FM5, note_volume, byte
	dchan   'volume_chan: ', FM5, 9, byte
	_break

	dstr	'------ FM6 ------'
	dchan_x	'note:        ', FM6, note, word
	dchan_x	'note_target: ', FM6, note_target, word
	dchan_x	'note_step:   ', FM6, note_step, word
	dchan_x	'slide:       ', FM6, slide_mode, word
	dchan_x	'lastnote:    ', FM6, lastnote, byte
	dchan_x	'volume_note: ', FM6, note_volume, byte
	dchan   'volume_chan: ', FM6, 9, byte
	_break

	dc.w	-1			; end of list


; ---------------------------------------------------------------
; Draws a number
; ---------------------------------------------------------------

Player_DrawNumber:
	move.w	d0,d1
	lsr.w	#4,d1
	andi.w	#$F,d1
	cmpi.w	#$A,d1
	bcs.s	@0
	add.w	#'A'-'9'-1,d1
@0	add.w	#'0',d1
	move.w	d1,(a5)

	move.w	d0,d1
	andi.w	#$F,d1
	cmpi.w	#$A,d1
	bcs.s	@1
	add.w	#'A'-'9'-1,d1
@1	add.w	#'0',d1
	move.w	d1,(a5)
	rts

; ---------------------------------------------------------------
; Draw A String
; ---------------------------------------------------------------
; INPUT:
;	A0	= String
; ---------------------------------------------------------------

Player_DrawString:
	moveq	#0,d0
@0	move.b	(a0)+,d0
	beq.s	@1
	move.w	d0,(a5)
	bra.s	@0
@1	rts

; ---------------------------------------------------------------
; Player font
; ---------------------------------------------------------------

Font:
	incbin	font.1bpp
