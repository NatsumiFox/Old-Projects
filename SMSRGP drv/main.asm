; ===========================================================================
; ---------------------------------------------------------------------------
; Master System Source
; ---------------------------------------------------------------------------
; 0000 - 3FFF = ROM bank address (Defaults to ROM 0000 - 3FFF)
; 4000 - 7FFF = ROM bank address (Defaults to ROM 4000 - 7FFF)
; 8000 - BFFF = ROM bank address (Defaults to ROM 8000 - BFFF)
; C000 - DFFF = RAM
; E000 - FFFF = Mirror of C000 - DFFF
;
; FFFC = RAM control register for C000 - FFFF
;
;	Bank register value:	Binary: D00WREBB
;
;		D  = Devboard write protection (0 Read + Write | 1 Read only)
;		W  = RAM write protection (?)
;		R  = ROM/RAM switch (0 = ROM | 1 = RAM)
;		E  = External RAM bank number?
;		BB = Bank Position (depends on RAM/ROM)
;
; FFFD = Bank register for 0000 - 3FFF (Default = 00)
; FFFE = Bank register for 4000 - 7FFF (Default = 01)
; FFFF = Bank register for 8000 - BFFF (Default = 02)
;
;	Bank register values:	Binary: 000??BBB
;
;		BBB = Bank ROM position:
;
;		000 = ROM  0000 -  3FFF
;		001 = ROM  4000 -  7FFF
;		010 = ROM  8000 -  BFFF
;		011 = ROM  C000 -  FFFF
;		100 = ROM 10000 - 13FFF
;		101 = ROM 14000 - 17FFF
;		110 = ROM 18000 - 1BFFF
;		111 = ROM 1C000 - 1FFFF
;		..etc? (Programmer notes say the registers are 5
;			bits, not 3 bits, not sure though...)
; ---------------------------------------------------------------------------
	listing purecode
	include "sound/macro.asm"; include sound macros for use outside of driver code

Start:
		di						; disable interrupts
		im	1					; set interrupt mode
		jp	Setup					; continue into setup routine

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank
; ---------------------------------------------------------------------------
		align	038h
; ---------------------------------------------------------------------------

		jp	VBlank

; ===========================================================================
; ---------------------------------------------------------------------------
; Pause interrupt routine
; ---------------------------------------------------------------------------
		align	00066h
; ---------------------------------------------------------------------------

		jp	Pause

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to wait for V-blank
; ---------------------------------------------------------------------------

WaitVBlank:
		ld	a,001h					; set V-blank trigger
		ld	(0E1FFh),a				; ''
		ei						; enable interrupts

WVB_Next:
		ld	a,(0E1FFh)				; load V-blank trigger
		or	a					; check trigger
		jr	nz,WVB_Next				; if trigger is not clear, V-blank hasn't ran yet
		ret						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Setup routine
; ---------------------------------------------------------------------------

Setup:
		ld	sp,0FE00h				; set stack address

	; --- Setup Z80 RAM ---

		ld	hl,0E000h				; load RAM address
		ld	(hl),l					; clear first byte
		ld	de,0E000h+1				; load destination
		ld	bc,01FF8h-1				; set size
		ldir						; clear Z80 RAM

	; --- Setup PSG ---

		ld	hl,SetupData				; load setup data
		ld	bc,0047Fh				; set size and port address
		otir						; mute all PSG channels

	; --- Setup VDP registers ---

		ld	b,00Ah					; number of registers to write

Setup_VDP:
		ld	a,(hl)					; load VDP data
		inc	l					; advance to next register
		out	(0BFh),a				; dump register
		djnz	Setup_VDP				; repeat for all registers

	; --- Setup CRAM ---

		ld	c,0BFh					; prepare VDP register
		ld	hl,0C000h				; set VDP to CRAM write address 00
		out	(c),l					; ''
		xor	a					; clear a (also delay)
		out	(c),h					; '' (set VDP CRAM write)
		ld	b,020h					; set size of CRAM clear (2 palette lines)

Setup_CRAM:
		out	(0BEh),a				; clear CRAM
		djnz	Setup_CRAM				; repeat until it's all clear

	; --- Setup VRAM ---

		ld	hl,04000h				; set VDP to VRAM write address 0000
		out	(c),l					; ''
		nop						; delay
		out	(c),h					; '' (set VDP VRAM write)
		ld	bc,00040h				; set size of VRAM clear (0000 - 3FFF)

Setup_VRAM:
		out	(0BEh),a				; clear VRAM
		djnz	Setup_VRAM				; repeat for VRAM clear
		dec	c					; decrease counter
		jp	p,Setup_VRAM				; if it's still counting, branch

		jp	RunGame					; continue

; ---------------------------------------------------------------------------
; Setup data
; ---------------------------------------------------------------------------
		align	010h
; ---------------------------------------------------------------------------

SetupData:	db	010010000b|00Fh				; PSG 1 Volume (mute)
		db	010110000b|00Fh				; PSG 2 Volume (mute)
		db	011010000b|00Fh				; PSG 3 Volume (mute)
		db	011110000b|00Fh				; PSG 4 Volume (mute)

		dw	(080h<<8)|00010110b			; VHLIS11E | V-Scroll Right (0 Yes | 1 No), H-Scroll Top (0 Yes | 1 No), Left Column (0 No | 1 Yes), Interrupt IE1, Sprite Shift (0 Off | 1 On), External Sync
		dw	(081h<<8)|11100000b			; 1DI000S0 | Display (0 Off | 1 On), Interrupt IE, Sprite Size (0 = 8 | 1 = 16)
		dw	(082h<<8)|((03800h>>10)&00Eh)|0F1h	; 1111DCB1 | DCB = Map address (Multiples of 800 (0000 - 3800))
		dw	(083h<<8)|0FFh				; Unknown/Unused (keep at FF)
		dw	(084h<<8)|0FFh				; Unknown/Unused (keep at FF)
		dw	(085h<<8)|((03F00h>>7)&07Eh)|081h	; 1DCBA981 | DCBA98 = Sprite address (Multiples of 100 (0000 - 3F00))
		dw	(086h<<8)|11111011b			; 11111S11 | VRAM section sprites can use for tiles (0 = VRAM 0000 - 1FFF | 1 = 2000 - 3FFF)
		dw	(087h<<8)|11110000b			; 1111CCCC | Backdrop colour (second palette line only; Colour 0 - F)
		dw	(088h<<8)|000h				; H-Scroll position
		dw	(089h<<8)|000h				; V-Scroll position
		dw	(08Ah<<8)|0FFh				; H-interrupt line (00 - BF = Interrupt line | C0 - FF = Disabled/No interrupt)

; ===========================================================================
; ---------------------------------------------------------------------------
; Now the actual game...
; ---------------------------------------------------------------------------

RunGame:

	; --- Loading palette ---

		ld	c,0BFh					; prepare VDP register
		ld	hl,1100000000000000b			; set VDP to CRAM write address 00
		out	(c),l					; ''
		ld	b,Palette_End-Palette			; set size of CRAM
		out	(c),h					; '' (set VDP CRAM write)
		ld	hl,Palette				; load palette address

RG_LoadPal:
		ld	a,(hl)					; load colour
		out	(0BEh),a				; dump to CRAM
		inc	hl					; advance to next colour
		djnz	RG_LoadPal				; repeat until it's all written

	; --- Loading art ---

		ld	hl,0100000000000000b			; set VDP to VRAM write address 0000
		out	(c),l					; ''
		nop						; delay
		out	(c),h					; '' (set VDP VRAM write)
		ld	bc,(((Art_End-Art)&0FFh)<<8)|(((Art_End-Art)>>8)&0FFh) ; set size of art
		ld	hl,Art					; load art address

RG_LoadArt:
		ld	a,(hl)					; load art
		out	(0BEh),a				; dump to VRAM
		inc	hl					; advance to next pixel data
		djnz	RG_LoadArt				; repeat for VRAM write
		dec	c					; decrease counter
		jp	p,RG_LoadArt				; if it's still counting, branch

	; --- Drawing CPU meter mappings ---

		ld	hl,04000h+03800h			; prepare VRAM address
		ld	de,00040h				; prepare line advance amount
		ld	bc,018BFh				; number of lines to draw and VDP control port address

RG_MeterCPU:
		out	(c),l					; set VDP address
		ld	a,011h					; '' (prepare tile map ID)
		out	(c),h					; ''
		out	(0BEh),a				; write tile map
		xor	a					; ''
		out	(0BEh),a				; ''
		add	hl,de					; advance VDP address
		djnz	RG_MeterCPU				; repeat for number of lines on screen

	; --- Loop with V-blank waiting ---

LoopTest:
		call	WaitVBlank				; wait for V-blank

		ld	c,0BFh					; prepare VDP control port address
		ld	hl,0C00Fh				; set VDP to CRAM write address 00
		out	(c),l					; ''
		ld	a,00110011b				; '' (prepare colour)
		out	(c),h					; ''
		nop						; delay
		out	(0BEh),a				; set colour

		call	SoundDriver				; run sound driver

		ld	c,0BFh					; prepare VDP control port address
		ld	hl,0C00Fh				; set VDP to CRAM write address 00
		out	(c),l					; ''
		xor	a					; '' (prepare colour)
		out	(c),h					; ''
		nop						; delay
		out	(0BEh),a				; set colour

		ld	hl,0E1FCh				; load music to hl
		ld	a,(0E1F9h)				; get pressed controls to a

		bit	2,a			; check left
		jp	z,.nor			; no? Branch
		dec	(hl)			; decrease id

.nor		bit	3,a			; check right
		jp	z,.nol			; no? Branch
		inc	(hl)			; increase id

.nol		bit	4,a			; check button?
		jp	z,LoopTest		; no? Branch

		ld	a,(hl)			; load id
		ld	(dQueue),a		; save to queue
		jp	LoopTest				; loop endlessly

; ===========================================================================
; ---------------------------------------------------------------------------
; Display data
; ---------------------------------------------------------------------------
		;	00BBGGRR
Palette:	db	00000000b,00111111b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b
		db	00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b
		db	00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b
		db	00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b
Palette_End:

Art:		db	00000000b,00000000b,00000000b,00000000b
		db	00000000b,00000000b,00000000b,00000000b
		db	00000000b,00000000b,00000000b,00000000b
		db	00000000b,00000000b,00000000b,00000000b
		db	00000000b,00000000b,00000000b,00000000b
		db	00000000b,00000000b,00000000b,00000000b
		db	00000000b,00000000b,00000000b,00000000b
		db	00000000b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	00011000b,00000000b,00000000b,00000000b
		db	00011000b,00000000b,00000000b,00000000b
		db	00011000b,00000000b,00000000b,00000000b
		db	00011000b,00000000b,00000000b,00000000b
		db	00011000b,00000000b,00000000b,00000000b
		db	00011000b,00000000b,00000000b,00000000b
		db	00011000b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	00000110b,00000000b,00000000b,00000000b
		db	00001100b,00000000b,00000000b,00000000b
		db	00011000b,00000000b,00000000b,00000000b
		db	00110000b,00000000b,00000000b,00000000b
		db	01111110b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	00000110b,00000000b,00000000b,00000000b
		db	00001100b,00000000b,00000000b,00000000b
		db	00000110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	00001100b,00000000b,00000000b,00000000b
		db	00011100b,00000000b,00000000b,00000000b
		db	00101100b,00000000b,00000000b,00000000b
		db	01001100b,00000000b,00000000b,00000000b
		db	01111110b,00000000b,00000000b,00000000b
		db	00001100b,00000000b,00000000b,00000000b
		db	00001100b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	01111110b,00000000b,00000000b,00000000b
		db	01100000b,00000000b,00000000b,00000000b
		db	01111100b,00000000b,00000000b,00000000b
		db	00001110b,00000000b,00000000b,00000000b
		db	00000110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b
		db	01100000b,00000000b,00000000b,00000000b
		db	01100000b,00000000b,00000000b,00000000b
		db	01111100b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	01111110b,00000000b,00000000b,00000000b
		db	00000110b,00000000b,00000000b,00000000b
		db	00001100b,00000000b,00000000b,00000000b
		db	00001100b,00000000b,00000000b,00000000b
		db	00011000b,00000000b,00000000b,00000000b
		db	00011000b,00000000b,00000000b,00000000b
		db	00110000b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	00111110b,00000000b,00000000b,00000000b
		db	00000110b,00000000b,00000000b,00000000b
		db	00000110b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01111110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	01111100b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01111100b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01100110b,00000000b,00000000b,00000000b
		db	01111100b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b
		db	01110010b,00000000b,00000000b,00000000b
		db	01100000b,00000000b,00000000b,00000000b
		db	01100000b,00000000b,00000000b,00000000b
		db	01100000b,00000000b,00000000b,00000000b
		db	01110010b,00000000b,00000000b,00000000b
		db	00111100b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	01111000b,00000000b,00000000b,00000000b
		db	01100100b,00000000b,00000000b,00000000b
		db	01100010b,00000000b,00000000b,00000000b
		db	01100010b,00000000b,00000000b,00000000b
		db	01100010b,00000000b,00000000b,00000000b
		db	01100100b,00000000b,00000000b,00000000b
		db	01111000b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	01111110b,00000000b,00000000b,00000000b
		db	01100010b,00000000b,00000000b,00000000b
		db	01100000b,00000000b,00000000b,00000000b
		db	01111100b,00000000b,00000000b,00000000b
		db	01100000b,00000000b,00000000b,00000000b
		db	01100010b,00000000b,00000000b,00000000b
		db	01111110b,00000000b,00000000b,00000000b

		db	00000000b,00000000b,00000000b,00000000b
		db	01111110b,00000000b,00000000b,00000000b
		db	01100010b,00000000b,00000000b,00000000b
		db	01100000b,00000000b,00000000b,00000000b
		db	01111000b,00000000b,00000000b,00000000b
		db	01100000b,00000000b,00000000b,00000000b
		db	01100000b,00000000b,00000000b,00000000b
		db	01100000b,00000000b,00000000b,00000000b

		db	11111111b,11111111b,11111111b,11111111b	; CPU Meter Tile
		db	11111111b,11111111b,11111111b,11111111b
		db	11111111b,11111111b,11111111b,11111111b
		db	11111111b,11111111b,11111111b,11111111b
		db	11111111b,11111111b,11111111b,11111111b
		db	11111111b,11111111b,11111111b,11111111b
		db	11111111b,11111111b,11111111b,11111111b
		db	11111111b,11111111b,11111111b,11111111b
Art_End:

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank
; ---------------------------------------------------------------------------
DelayTime	=	0420h

VBlank:
		push	af					; store registers
		push	bc					; ''
		push	de					; ''
		push	hl					; ''
		ex	af,af'					; ''
		exx						; ''
		push	af					; ''
		push	bc					; ''
		push	de					; ''
		push	hl					; ''
		push	ix					; ''
		push	iy					; ''
		in	a,(0BFh)				; load VDP status (clears the interrupt request line from the VDP)
		or	a					; was V-blank triggered and not H-blank?
		jp	p,VB_HBlank				; if not, branch (ignore H-blank)
		ld	a,(0E1FFh)				; load v-blank trigger
		or	a					; is the Z80 on time for V-blank?
		jp	z,VB_LateZ80				; if not, branch (Z80 is late)
		call	DrawNumbers				; drawing numbers on the screen
		call	ReadControls				; read controller ports
		xor	a					; clear V-blank trigger
		ld	(0E1FFh),a				; ''

VB_LateZ80:

	; --- Delaying V-blank to ensure the colour swap occurs during display ---

		ld	bc,(DelayTime>>8)|((DelayTime&0FFh)<<8)

DelayVBlank:
		djnz	$
		dec	c
		jp	p,DelayVBlank

	; --- --- --- --- --- --- --- --- --- --- --- --- --- ---

VB_HBlank:
		pop	iy					; ''
		pop	ix					; ''
		pop	hl					; restore registers
		pop	de					; ''
		pop	bc					; ''
		pop	af					; ''
		exx						; ''
		ex	af,af'					; ''
		pop	hl					; ''
		pop	de					; ''
		pop	bc					; ''
		pop	af					; ''
		ei						; enable interrupts
		ret						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Pause interrupt routine
; ---------------------------------------------------------------------------

Pause:
		retn						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw a vareity of different numbers on the screen for visual debugging
; ---------------------------------------------------------------------------

DrawNumbers:
		ld	c,0BFh					; prepare VDP control port address

	; --- Byte display of frequency ---

		ld	hl,04000h+03814h			; set VDP to VRAM write address 3814
		ld	a,(0E1FDh)				; load frequency byte
		call	DrawByte				; display on screen as bits
		ld	hl,04000h+03818h			; set VDP to VRAM write address 3818
		ld	a,(0E1FCh)				; load frequency byte
		call	DrawByte				; display on screen as bits

	; --- Button press bits display ---

		ld	hl,04000h+03802h			; set VDP to VRAM write address 3802
		ld	a,(0E1F8h)				; load player 1 held buttons
		call	DrawBits				; display on screen as bits
		ld	hl,04000h+03842h			; set VDP to VRAM write address 3842
		ld	a,(0E1F9h)				; load player 1 pressed buttons
		call	DrawBits				; display on screen as bits
		ld	hl,04000h+03882h			; set VDP to VRAM write address 3882
		ld	a,(0E1FAh)				; load player 2 held buttons
		call	DrawBits				; display on screen as bits
		ld	hl,04000h+038C2h			; set VDP to VRAM write address 38C2
		ld	a,(0E1FBh)				; load player 2 pressed buttons

; ---------------------------------------------------------------------------
; Subroutine to draw bits on screen
; --- input -----------------------------------------------------------------
; a  = byte to display in bits on screen
; c  = VDP control port address
; hl = VRAM write mode address for VDP port
; --- used registers --------------------------------------------------------
; b
; ---------------------------------------------------------------------------

DrawBits:
		out	(c),l					; set VDP write addres mode
		ld	b,a					; '' load contents to b
		out	(c),h					; ''
	rept	8
		xor	a					; clear a
		sla	b					; shift bit into carry
		adc	a,a					; get bit into a
		inc	a					; increase to number '0'
		out	(0BEh),a				; write to VRAM plane mappings
		xor	a					; ''
		out	(0BEh),a				; ''
	endm
		ret						; return

; ---------------------------------------------------------------------------
; Subroutine to draw a byte on screen
; --- input -----------------------------------------------------------------
; a  = byte to display on screen
; c  = VDP control port address
; de = VRAM write mode address for VDP port
; --- used registers --------------------------------------------------------
; b
; ---------------------------------------------------------------------------

DrawByte:
		out	(c),l					; set VDP write addres mode
		ld	b,a					; '' load contents to b
		out	(c),h					; ''
		ld	e,a					; get upper nybble reference
		ld	d,DB_NybTable>>8			; ''
		ld	a,(de)					; load correct nybble VRAM value
		out	(0BEh),a				; write to VRAM plane mappings
		xor	a					; ''
		out	(0BEh),a				; ''
		ld	a,b					; copy back to a
		and	00Fh					; get lower nybble
		inc	a					; increase to number '0'
		out	(0BEh),a				; write to VRAM plane mappings
		xor	a					; ''
		out	(0BEh),a				; ''
		ret						; return

		align	0100h

DB_NybTable:	db	001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h
		db	002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h,002h
		db	003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h,003h
		db	004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h
		db	005h,005h,005h,005h,005h,005h,005h,005h,005h,005h,005h,005h,005h,005h,005h,005h
		db	006h,006h,006h,006h,006h,006h,006h,006h,006h,006h,006h,006h,006h,006h,006h,006h
		db	007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h,007h
		db	008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h,008h
		db	009h,009h,009h,009h,009h,009h,009h,009h,009h,009h,009h,009h,009h,009h,009h,009h
		db	00Ah,00Ah,00Ah,00Ah,00Ah,00Ah,00Ah,00Ah,00Ah,00Ah,00Ah,00Ah,00Ah,00Ah,00Ah,00Ah
		db	00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh,00Bh
		db	00Ch,00Ch,00Ch,00Ch,00Ch,00Ch,00Ch,00Ch,00Ch,00Ch,00Ch,00Ch,00Ch,00Ch,00Ch,00Ch
		db	00Dh,00Dh,00Dh,00Dh,00Dh,00Dh,00Dh,00Dh,00Dh,00Dh,00Dh,00Dh,00Dh,00Dh,00Dh,00Dh
		db	00Eh,00Eh,00Eh,00Eh,00Eh,00Eh,00Eh,00Eh,00Eh,00Eh,00Eh,00Eh,00Eh,00Eh,00Eh,00Eh
		db	00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh,00Fh
		db	010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to read player 1 and 2 controls
; ---------------------------------------------------------------------------

ReadControls:
		ld	hl,0E1F8h				; load button press RAM
		in	a,(0DCh)				; load buttons
		ld	c,a					; keep a copy of player 2's buttons
		or	11000000b				; disable player 2's buttons from player 1's byte
		cpl	a					; reverse button states (for XOR below)
		ld	b,a					; store in b
		ld	a,(hl)					; load current held buttons
		xor	b					; disable buttons that are already held
		ld	(hl),b					; save all new held buttons
		inc	l					; increase to pressed RAM slot
		and	b					; get only the newly pressed buttons
		ld	(hl),a					; save all pressed buttons
		inc	l					; increment
		in	a,(0DDh)				; load buttons
		sla	c					; shift player 2 buttons into player 2 byte
		adc	a,a					; ''
		sla	c					; ''
		adc	a,a					; ''
		or	11000000b				; remove end bits from player 2's byte
		cpl	a					; reverse button states (for XOR below)
		ld	b,a					; store in b
		ld	a,(hl)					; load current held buttons
		xor	b					; disable buttons that are already held
		ld	(hl),b					; save all new held buttons
		inc	l					; increase to pressed RAM slot
		and	b					; get only the newly pressed buttons
		ld	(hl),a					; save all pressed buttons
		ret						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Sound driver code and music header list
; ---------------------------------------------------------------------------

		org 4000h
		include "sound/sound.asm"
		include "sound/misc.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Master System Header
; ---------------------------------------------------------------------------
	if 07FF0h >= $
		align	07FF0h
	else
		fatal "\n\nError: First bank size is larger than 07FF0h, can't fit the security code in\n       Please rearrange some code/data into a later bank.\n\n"
	endif

		db	"TMR SEGA  "				; Security string
		dw	00000h					; ROM Checksum (Checkfix.exe will sort this)
		db	"GA"					; Serial number (pffftahahahahahaha....)
		db	"Y"					; Software revision number (eh *shrugs*)
		db	000h					; ROM Size Code (CheckFix.exe will sort this)


; ===========================================================================
; ---------------------------------------------------------------------------
; Sound bank #0
; ---------------------------------------------------------------------------

	bank
	include "sound/music/test.asm"
