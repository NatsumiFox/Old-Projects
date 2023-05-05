
; =========================================================================
; Error screen
; =========================================================================

ErrorScreen:
		move	#$2700,sr		; disable interrupts
		movem.l	d0-d7/a0-a7,(-$8000).w
		lea	(-$8000).w,a4		; a4 => registers backup
		lea	($C00000).l,a5		; a5 => VDP Data port
		lea	4(a5),a6		; a6 => VDP Cuntrol port
		move.w	#$8134,(a6)		; disable DISP
		move.w	#$8238,(a6)		; set Plane A nametable VRAM offset to $E000
		move.w	#$8330,(a6)		; set Window plane to $C000
		move.w	#$8407,(a6)		; set Plane B nametable VRAM offset to $E000
		move.w	#$857C,(a6)		; set Sprites data offset to $F800
		move.w	#$8700,(a6)		; set backdrop color
		move.w	#$8C00,(a6)		; use 256x224 resolution
		move.w	#$9000,(a6)		; use 256x256 planes size
		move.w	#$9120,(a6)		; setup Windows
		move.w	#$921C,(a6)		;
		CLRvram	$FFF,$C000
		CLRvram	$FFF,$E000
		vram	$F800,(a6)		; load Sprites data table
		moveq	#0,d0
		move.l	d0,(a5)			; clear sprites
		move.l	d0,(a5)			;

		; Load 1bpp font (using a routine from loader engine)
		lea	ErrorScreen_FontData(pc),a0
		jsr	(Load_1bpp).l

		; Load palette
		lea	ErrorScreen_Palette(pc),a0
		cram	0,d0
		moveq	#1,d1
		
	@LoadPal:
		move.l	d0,(a6)			; load CRAM address
		move.l	(a0)+,(a5)		; write colors to CRAM
		addi.l	#$20<<16,d0		; next palette row
		dbf	d1,@LoadPal

		; Load interface
		lea	ErrorScreen_Interface(pc),a0
		move.w	(a0)+,d1
		
	@LoadInteface:
		move.l	(a0)+,(a6)
		bsr.w	ErrorScreen_DisplayText
		dbf	d1,@LoadInteface

		; Display error description, program and vector id
		vram	$C042,(a6)
		move.w	(-$7FC0).w,d0
		move.w	d0,d1                            
		add.w	d0,d0
		lea	ErrorScreen_VectorsList(pc),a0
		adda.w	(a0,d0.w),a0
		move.w	#1<<13,d0
		bsr.w	ErrorScreen_DisplayText

		vram	$C0D6,(a6)
		move.w	d1,d0
		move.w	#$17+(1<<13),d3
		jsr	(DisplayValue).l

		vram	$C116,(a6)
		move.b	($FFFFFFFC+3).w,d0
		andi.w	#7,d0
		add.w	d0,d0
		lea	ErrorScreen_ProgramsList(pc),a0
		adda.w	(a0,d0.w),a0
		move.w	#1<<13,d0
		bsr.w	ErrorScreen_DisplayText

		; Display registers
		lea	ErorScreen_Registers(pc),a0
		move.w	#1<<13,d0		; highlight register values
		moveq	#1,d7			; do both data and address registers

	@LoadRegisters:
		move.l	(a0)+,d4
		move.l	(a0)+,d2		; load register group id
		moveq	#7,d6			; do 7 registers

	@DisplayRegister:
		move.l	d4,(a6)			; load destination VRAM
		move.l	d2,(a5)			; display register name
		move.l	#$13,(a5)		; display '=' char
		move.w	#0,(a5)			; display space
		moveq	#3,d5			; display 4-byte value
		bsr.s	ErrorScreen_DisplayValue
		addi.l	#$40<<16,d4		; go to next screen row
		addq.b	#1,d2			; next register name
		dbf	d6,@DisplayRegister

		dbf	d7,@LoadRegisters
		
		; Display stack contents
		movea.l	-(a4),a4		; load stack frame
		vram	$C482,d4		; load start VRAM address
		moveq	#7,d6			; do 8 rows
		moveq	#0,d7			; d7 will be SP shift value to display
		moveq	#0,d3			; d3 is space etalone!

	@LoadRAM:
		move.l	d4,(a6)
		move.l	#('S'-$20)<<16|('P'-$20),(a5)	; display 'SP' text
		move.w	#$B,(a5)			; display '+' char
		move.l	d7,d0				; d0 -> ---- --XX
		swap	d0				; d0 -> --XX ----
		lsr.l	#4,d0				; d0 -> ---X X---
		rol.w	#4,d0				; d0 -> ---X ---X
		addi.l	#$00170017,d0
		move.l	d0,(a5)				; display shift value
		move.l	d3,(a5)				; display space
		move.w	#1<<13,d0			; highlight words
		moveq	#3,d2				; display 4 words

	@DisplayWord:
		moveq	#1,d5				; display 2-byte value
		bsr.s	ErrorScreen_DisplayValue
		move.w	d3,(a5)				; display space
		dbf	d2,@DisplayWord

		addi.l	#$40<<16,d4
		addq.b	#8,d7
		dbf	d6,@LoadRAM

		move.w	#$8174,(a6)		; enable DISP
		fuck				; it should have come to thiS!

; -------------------------------------------------------------------------
ErrorScreen_DisplayText:
		move.b	(a0)+,d0
		beq.s	@Return			; if char = $00, branch
		subi.b	#$20,d0
		move.w	d0,(a5)			; display char
		bra.s	ErrorScreen_DisplayText

	@Return:
		rts

; -------------------------------------------------------------------------
ErrorScreen_DisplayValue:
		move.b	(a4)+,d1
		move.b	d1,d0
		lsr.b	#4,d0
		addi.b	#$17,d0
		move.w	d0,(a5)
		move.b	d1,d0
		andi.b	#$F,d0
		addi.b	#$17,d0
		move.w	d0,(a5)
		dbf	d5,ErrorScreen_DisplayValue
		rts

; -------------------------------------------------------------------------
Load_1bpp:
		movea.l	(a0)+,a1	; a1 => Source Data
		move.l	(a0)+,(a6)	; VDP => Set destionation offset
		move.l	(a0)+,d2	; d2 -> Pixel Mask
		move.w	(a0)+,d0	; d0 -> Data size

@GfxConv_Loop	move.b	(a1)+,d1
		moveq	#0,d4
		moveq	#7,d3
@GfxConv_Pix	rol.l	#4,d2
		rol.b	d1
		bcc.s	@null		; if pixel 0, branch
		or.l	d2,d4		; apply pixel
	@null:	dbf	d3,@GfxConv_Pix	; repeat for 8 pixels
		move.l	d4,(a5)		; output row of 8 pixels
		dbf	d0,@GfxConv_Loop

		rts

; -------------------------------------------------------------------------
DisplayValue:
		moveq	#3,d2
	@loop:	rol.w	#4,d0			; get Hi hex digit, then lower and so
		move.b	d0,d1			; get the digit
		andi.w	#$F,d1			;
		add.w	d3,d1			; add char base to get tile index
		move.w	d1,-4(a6)		; display char
		dbf	d2,@loop		; repeat for 4 digits (2 bytes, word)
		rts

; -------------------------------------------------------------------------
ErrorScreen_FontData:
		dc.l	ErrorScreen_FontArt	; source address (RAM/ROM)
		dcvram	0			; destination address (VRAM)
		dc.l	1<<28			; pixel mask (/<<28)
		dc.w	760-1			; art size (in bytes)

ErrorScreen_FontArt:
		incbin	'msgfont.1bpp'

ErrorScreen_Palette:
		dc.w	$0800, $0EEE		; row 0
		dc.w	$0800, $00EE		; row 1

; -- Interface holder
ErrorScreen_Interface:
		dc.w	$01			; number of items to load
		dcvram	$C0C2
		dc.b	'Vector0',0
		dcvram	$C102
		dc.b	'Program0 ',0

; -- Registers viewer data
ErorScreen_Registers:
		dcvram	$C202
		dc.b	0,'D'-$20,0,$17
		dcvram	$C222
		dc.b	0,'A'-$20,0,$17

; -- Program names list
ErrorScreen_ProgramsList:
@ListBase	dc.w	@Text00-@ListBase
		dc.w	@Text01-@ListBase
		dc.w	@Text02-@ListBase
		dc.w	@Text03-@ListBase
		dc.w	@Text04-@ListBase
		dc.w	@Text04-@ListBase
		dc.w	@Text04-@ListBase
		dc.w	@Text04-@ListBase
@Text00		dc.b	'SONIC ',$38,0
@Text01		dc.b	'SONIC ',$39,0
@Text02		dc.b	'SONIC ',$3A,0
@Text03		dc.b	'LOADER',0
@Text04		dc.b	'UNDERFINED',0
		even

; -- Error description list
ErrorScreen_VectorsList:
@ListBase	dc.w	@TextNull-@ListBase	; $00 - @ Stack Ptr
		dc.w	@TextNull-@ListBase	; $01 - @ Entry Point
		dc.w	@Text01-@ListBase	; $02 - Bus Error
		dc.w	@Text02-@ListBase	; $03 - Address Error
		dc.w	@Text03-@ListBase	; $04 - Illegal Instruction
		dc.w	@Text04-@ListBase	; $05 - Zero Divide
		dc.w	@Text05-@ListBase	; $06 - Chk Intruction
		dc.w	@Text06-@ListBase	; $07 - Trapv Instruction
		dc.w	@Text07-@ListBase	; $08 - Privilege Violation
		dc.w	@Text08-@ListBase	; $09 - Trace Interrupt
		dc.w	@Text09-@ListBase	; $0A - Line 1010 Emulator
		dc.w	@Text0A-@ListBase	; $0B - Line 1111 Emulator
		dc.w	@Text00-@ListBase	; $0C - Error Exception
		dc.w	@Text00-@ListBase	; $0D - Error Exception
		dc.w	@Text00-@ListBase	; $0E - Error Exception
		dc.w	@Text00-@ListBase	; $0F - Error Exception
		dc.w	@Text00-@ListBase	; $10 - Error Exception
		dc.w	@Text00-@ListBase	; $11 - Error Exception
		dc.w	@Text00-@ListBase	; $12 - Error Exception
		dc.w	@Text00-@ListBase	; $13 - Error Exception
		dc.w	@Text00-@ListBase	; $14 - Error Exception
		dc.w	@Text00-@ListBase	; $15 - Error Exception
		dc.w	@Text00-@ListBase	; $16 - Error Exception
		dc.w	@Text00-@ListBase	; $17 - Error Exception
		dc.w	@Text00-@ListBase	; $18 - Error Exception
		dc.w	@TextFF-@ListBase	; $19 - Error Trap
		dc.w	@TextFF-@ListBase	; $1A - Error Trap
		dc.w	@TextFF-@ListBase	; $1B - Error Trap
		dc.w	@TextNull-@ListBase	; $1C - @ HBlank
		dc.w	@TextFF-@ListBase	; $1D - Error Trap
		dc.w	@TextNull-@ListBase	; $1E - @ VHBlank
		dc.w	@TextFF-@ListBase	; $1F - Error Trap
		dc.w	@TextFF-@ListBase	; $20 - Error Trap
		dc.w	@TextFF-@ListBase	; $21 - Error Trap
		dc.w	@TextFF-@ListBase	; $22 - Error Trap
		dc.w	@TextFF-@ListBase	; $23 - Error Trap
		dc.w	@TextFF-@ListBase	; $24 - Error Trap
		dc.w	@TextFF-@ListBase	; $25 - Error Trap
		dc.w	@TextFF-@ListBase	; $26 - Error Trap
		dc.w	@TextFF-@ListBase	; $27 - Error Trap
		dc.w	@TextFF-@ListBase	; $28 - Error Trap
		dc.w	@TextFF-@ListBase	; $29 - Error Trap
		dc.w	@TextFF-@ListBase	; $2A - Error Trap
		dc.w	@TextFF-@ListBase	; $2B - Error Trap
		dc.w	@TextFF-@ListBase	; $2C - Error Trap
		dc.w	@TextFF-@ListBase	; $2D - Error Trap
		dc.w	@TextFF-@ListBase	; $2E - Error Trap
		dc.w	@TextFF-@ListBase	; $2F - Error Trap
		dc.w	@TextFF-@ListBase	; $30 - Error Trap
		dc.w	@TextFF-@ListBase	; $31 - Error Trap
		dc.w	@TextFF-@ListBase	; $32 - Error Trap
		dc.w	@TextFF-@ListBase	; $33 - Error Trap
		dc.w	@TextFF-@ListBase	; $34 - Error Trap
		dc.w	@TextFF-@ListBase	; $35 - Error Trap
		dc.w	@TextFF-@ListBase	; $36 - Error Trap
		dc.w	@TextFF-@ListBase	; $37 - Error Trap
		dc.w	@TextFF-@ListBase	; $38 - Error Trap
		dc.w	@TextFF-@ListBase	; $39 - Error Trap
		dc.w	@TextFF-@ListBase	; $3A - Error Trap
		dc.w	@TextFF-@ListBase	; $3B - Error Trap
		dc.w	@TextFF-@ListBase	; $3C - Error Trap
		dc.w	@TextFF-@ListBase	; $3D - Error Trap
		dc.w	@TextFF-@ListBase	; $3E - Error Trap
		dc.w	@TextFF-@ListBase	; $3F - Error Trap

@TextNull	dc.b	0
@Text00		dc.b	'ERROR EXCEPTION',0
@TextFF		dc.b	'ERROR TRAP',0
@Text01		dc.b	'BUS ERROR',0
@Text02		dc.b	'ADDRESS ERROR',0
@Text03		dc.b	'ILLEGAL INSTRUCTION',0
@Text04		dc.b	'ZERO DIVIDE',0
@Text05		dc.b	'CHK INTRUCTION',0
@Text06		dc.b	'TRAPV INSTRUCTION',0
@Text07		dc.b	'PRIVILEGE VIOLATION',0
@Text08		dc.b	'TRACE INTERRUPT',0
@Text09		dc.b	'LINE ',$38,$37,$38,$37,' EMULATOR',0
@Text0A		dc.b	'LINE ',$38,$38,$38,$38,' EMULATOR',0
		even


; =========================================================================
; Exception vectors table
; =========================================================================

raise	macro
		move.w	#\1,(-$7FC0).w
		jmp	ErrorScreen(pc)
	endm

Vector02	raise	$02
Vector03	raise	$03
Vector04	raise	$04
Vector05	raise	$05
Vector06	raise	$06
Vector07	raise	$07
Vector08	raise	$08
Vector09	raise	$09
Vector0A	raise	$0A
Vector0B	raise	$0B
Vector0C	raise	$0C
Vector0D	raise	$0D
Vector0E	raise	$0E
Vector0F	raise	$0F
Vector10	raise	$10
Vector11	raise	$11
Vector12	raise	$12
Vector13	raise	$13
Vector14	raise	$14
Vector15	raise	$15
Vector16	raise	$16
Vector17	raise	$17
Vector18	raise	$18
Vector19	raise	$19
Vector1A	raise	$1A
Vector1B	raise	$1B
Vector1D	raise	$1D
Vector1F	raise	$1F
Vector20	raise	$20
Vector21	raise	$21
Vector22	raise	$22
Vector23	raise	$23
Vector24	raise	$24
Vector25	raise	$25
Vector26	raise	$26
Vector27	raise	$27
Vector28	raise	$28
Vector29	raise	$29
Vector2A	raise	$2A
Vector2B	raise	$2B
Vector2C	raise	$2C
Vector2D	raise	$2D
Vector2E	raise	$2E
Vector2F	raise	$2F
Vector30	raise	$30
Vector31	raise	$31
Vector32	raise	$32
Vector33	raise	$33
Vector34	raise	$34
Vector35	raise	$35
Vector36	raise	$36
Vector37	raise	$37
Vector38	raise	$38
Vector39	raise	$39
Vector3A	raise	$3A
Vector3B	raise	$3B
Vector3C	raise	$3C
Vector3D	raise	$3D
Vector3E	raise	$3E
Vector3F	raise	$3F