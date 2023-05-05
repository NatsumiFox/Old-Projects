; ===========================================================================
; ---------------------------------------------------------------------------
; Freeze debug screen
; ---------------------------------------------------------------------------
FreezeStore	=	$40040010
FreezeLoad	=	$00040010
FreezeRAM	=	$FFFF0000
; ---------------------------------------------------------------------------

FreezeScreen:
	;or.w	#$2700,sr				; disable interrupts
		bcs	F1___
		bvs	F01__
		bne	F001_
		bmi	F0001
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%00000,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F1___:
		bvs	F11__
		bne	F101_
		bmi	F1001
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%01000,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F11__:
		bne	F111_
		bmi	F1101
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%01100,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F111_:
		bmi	F1111
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%01110,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F01__:
		bne	F011_
		bmi	F0101
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%00100,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F011_:
		bmi	F0111
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%00110,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F001_:
		bmi	F0011
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%00010,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F101_:
		bmi	F1011
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%01010,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F0001:
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%00001,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F0011:
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%00011,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F0101:
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%00101,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F0111:
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%00111,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F1001:
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%01001,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F1011:
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%01011,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F1101:
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%01101,($C00000).l			; write ccr bits
		bra	F_GetX					; continue

F1111:
		move.l	#FreezeStore,($C00004).l		; set VDP address to store registers
		move.w	#%01111,($C00000).l			; write ccr bits

F_GetX:
		move.w	sr,($C00000).l				; store X
		move	#$2700,sr				; disable interrupts

	;	addx.w	d0,d0					; if the move of sr into VDP port doesn't work...
	;	move.w	d0,($C00000).l				; ...try this instead...
	;	roxr.w	#$01,d0					; ''

		move.l	#FreezeReturn,($C00000).l		; store return address
		move.l	a0,($C00000).l				; store a0
		lea	($C00000).l,a0				; load VDP data port
		move.l	a1,(a0)					; store address registers
		move.l	a2,(a0)					; ''
		move.l	a3,(a0)					; ''
		move.l	a4,(a0)					; ''
		move.l	a5,(a0)					; ''
		move.l	a6,(a0)					; ''
		move.l	a7,(a0)					; ''
		move.l	d0,(a0)					; store data registers
		move.l	d1,(a0)					; ''
		move.l	d2,(a0)					; ''
		move.l	d3,(a0)					; ''
		move.l	d4,(a0)					; ''
		move.l	d5,(a0)					; ''
		move.l	d6,(a0)					; ''
		move.l	d7,(a0)					; ''
		move.l	usp,a1					; store usp
		move.l	a1,(a0)					; ''

; ---------------------------------------------------------------------------
; Setting up
; ---------------------------------------------------------------------------

		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.w	#$8000|%00000100,(a6)			; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)
		move.w	#$8100|%01010100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.w	#$8200|((($C000)>>$0A)&$FF),(a6)	; 00FE DCBA - Scroll Plane A Map Table VRam address
		move.w	#$8300|((($C000)>>$0A)&$FF),(a6)	; 00FE DCB0 / 00FE DC00 (20 H-resol) - Window Plane A Map Table VRam address
		move.w	#$8400|((($C000)>>$0D)&$FF),(a6)	; 0000 0FED - Scroll Plane B Map Table VRam address
		move.w	#$8500|((($F000)>>$09)&$FF),(a6)	; 0FED CBA9 / 0FED CBA0 (20 H-resol) - Sprite Plane Map Table VRam address
		move.w	#$8600|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8700|$00,(a6)				; 00PP CCCC - Backdrop Colour: Palette Line | Colour ID
		move.w	#$8800|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8900|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8A00|$DF,(a6)				; 7654 3210 - H-Interrupt Register
		move.w	#$8B00|%00000000,(a6)			; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)
		move.w	#$8C00|%10000001,(a6)			; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
		move.w	#$8D00|((($F000)>>$0A)&$FF),(a6)	; 00FE DCBA - Horizontal Scroll Table VRam address
		move.w	#$8E00|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8F00|$02,(a6)				; 7654 3210 - Auto Increament
		move.w	#$9000|%00000001,(a6)			; 00VV 00HH - Plane Y Size (00-20|01-40|11-80) | Plane X size (00-20|01-40|11-80)
		move.w	#$9100|$00,(a6)				; 7654 3210 - Window Horizontal Position
		move.w	#$9200|$00,(a6)				; 7654 3210 - Window Vertical Position

		moveq	#$00,d0					; clear d0
		move.l	#$70000003,(a6)				; clear H-scroll and sprites
		move.l	d0,(a5)					; ''
		move.l	#$40000003,(a6)				; set VDP address to plane mappings field
		move.w	#($1000/$04)-1,d1			; prepare size

Freeze_ClearPlane:
		move.l	d0,(a5)					; clear mappings...
		dbf	d1,Freeze_ClearPlane			; repeat until all clear

		DMA	$0080, $C0000000, FreezePal			; transfer palette
		DMA	FreezeArt_End-FreezeArt, $40000000, FreezeArt	; transfer art

; ---------------------------------------------------------------------------
; Displaying registers
; ---------------------------------------------------------------------------

		move.l	#FreezeLoad,(a6)			; set VDP to VSRAM read...

	; sr

		move.w	(a5),d0					; load C, V, N and Z flags
		move.w	(a5),d1					; load sr/x flags
		or.w	d1,d0					; fuse together
		move.l	#FreezeStore+($02<<$10),(a6)		; set VSRAM write
		move.w	d0,(a5)					; store sr in full...

		swap	d0					; send to upper word
		move.l	#$41360003,(a6)				; set VDP address

		moveq	#$02-1,d1				; prepare number of digits
		move.w	#$4000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''

		moveq	#$02-1,d1				; prepare number of digits
		move.w	#$0000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''

	; return address

		move.l	#FreezeLoad+($04<<$10),(a6)		; set VDP to VSRAM read...
		move.l	(a5),d0					; load return address
		move.l	#$41B60003,(a6)				; set VDP address

		moveq	#$02-1,d1				; prepare number of digits
		move.w	#$2000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''

		moveq	#$06-1,d1				; prepare number of digits
		move.w	#$0000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''

	; Address registers

		move.l	#FreezeLoad+($08<<$10),d6		; prepare VSRAM read location
		move.l	#$411E0003,d5				; prepare VDP address
		moveq	#$08-1,d4				; set number of registers to run through
		move.l	#$A0000000,d3				; prepare register ID

FreezeAX:
		move.l	d5,(a6)					; set VDP write address

		move.l	d3,d0					; load register ID
		addi.l	#$01000000,d3				; increase ID
		moveq	#$02-1,d1				; prepare number of digits
		move.w	#$6000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''

		move.l	d6,(a6)					; set VSRAM read mode
		addi.l	#$00040000,d6				; skip to next long...
		move.l	(a5),d0					; load long-word

		move.l	d5,d1					; load VDP address
		addi.l	#$00060000,d1				; advance to long-word
		move.l	d1,(a6)					; set VDP write address
		addi.l	#$00800000,d5				; advance to next long

		moveq	#$02-1,d1				; prepare number of digits
		move.w	#$2000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''
		moveq	#$06-1,d1				; prepare number of digits
		move.w	#$0000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''

		dbf	d4,FreezeAX				; repeat for all registers

	; Data registers

		move.l	#FreezeLoad+($28<<$10),d6		; prepare VSRAM read location
		move.l	#$41060003,d5				; prepare VDP address
		moveq	#$08-1,d4				; set number of registers to run through
		move.l	#$D0000000,d3				; prepare register ID

FreezeDX:
		move.l	d5,(a6)					; set VDP write address

		move.l	d3,d0					; load register ID
		addi.l	#$01000000,d3				; increase ID
		moveq	#$02-1,d1				; prepare number of digits
		move.w	#$6000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''

		move.l	d6,(a6)					; set VSRAM read mode
		addi.l	#$00040000,d6				; skip to next long...
		move.l	(a5),d0					; load long-word

		move.l	d5,d1					; load VDP address
		addi.l	#$00060000,d1				; advance to long-word
		move.l	d1,(a6)					; set VDP write address
		addi.l	#$00800000,d5				; advance to next long

		moveq	#$04-1,d1				; prepare number of digits
		move.w	#$4000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''
		moveq	#$04-1,d1				; prepare number of digits
		move.w	#$0000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''

		dbf	d4,FreezeDX				; repeat for all registers

; ---------------------------------------------------------------------------
; RAM drawing...
; ---------------------------------------------------------------------------

		move.l	#$00800000,d6				; reset controls (have START as held, so it doesn't trigger return immediately)
		lea	(FreezeRAM&$FFFFFFF0).l,a4		; load RAM address to be used

FreezeLoop:
		bsr	FreezeControls				; get controls

		move.l	a4,d0					; load RAM to d0

		tst.b	d6					; was start pressed?
		bpl.s	FL_NoReturn				; if not, branch
		move.w	#$8100|%01110100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.l	#FreezeLoad+($08<<$10),(a6)		; set VDP to VSRAM read...
		move.l	(a5),a0					; restore address registers
		move.l	(a5),a1					; ''
		move.l	(a5),a2					; ''
		move.l	(a5),a3					; ''
		move.l	(a5),a4					; ''
		move.l	(a5),a6					; skip a5
		move.l	(a5),a6					; ''
		move.l	(a5),a7					; ''
		move.l	(a5),d0					; restore data registers
		move.l	(a5),d1					; ''
		move.l	(a5),d2					; ''
		move.l	(a5),d3					; ''
		move.l	(a5),d4					; ''
		move.l	(a5),d5					; ''
		move.l	(a5),d6					; ''
		move.l	(a5),d7					; ''
		move.l	(a5),a5					; load USP
		move.l	a5,usp					; ''
		move.l	#FreezeLoad+($1C<<$10),($C00004).l	; set VDP to VSRAM read...
		move.l	($C00000).l,a5				; reload a5
		move.l	#FreezeLoad+($02<<$10),($C00004).l	; set VDP to VSRAM read...
		move.w	($C00000).l,sr				; set SR again...
		jmp	FreezeReturn				; return

FL_NoReturn:
		btst.l	#$00,d6					; was up pressed?
		beq.s	FL_NoUp					; if not, branch
		subi.w	#$0010,d0				; move RAM address back

FL_NoUp:
		btst.l	#$01,d6					; was down pressed?
		beq.s	FL_NoDown				; if not, branch
		addi.w	#$0010,d0				; move RAM address forwards

FL_NoDown:
		btst.l	#$02,d6					; was left pressed?
		beq.s	FL_NoLeft				; if not, branch
		subi.w	#$0100,d0				; move RAM address back

FL_NoLeft:
		btst.l	#$03,d6					; was right pressed?
		beq.s	FL_NoRight				; if not, branch
		addi.w	#$0100,d0				; move RAM address forwards

FL_NoRight:
		btst.l	#$04,d6					; was left pressed?
		beq.s	FL_NoA					; if not, branch
		subi.w	#$1000,d0				; move RAM address back

FL_NoA:
		btst.l	#$05,d6					; was right pressed?
		beq.s	FL_NoB					; if not, branch
		addi.w	#$1000,d0				; move RAM address forwards

FL_NoB:

		move.l	d0,a4					; update RAM address

	; RAM location

		move.l	#$44B60003,(a6)				; set VDP address

		moveq	#$04-1,d1				; prepare number of digits
		move.w	#$2000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''

		moveq	#$04-1,d1				; prepare number of digits
		move.w	#$0000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''

	; RAM data...

		move.l	#$46060003,d5				; prepare VDP address
		lea	(a4),a3					; load RAM address

		moveq	#$0F-1,d4				; set number of rows...

FL_NextRow:
		move.l	d5,(a6)					; set VDP address
		addi.l	#$00800000,d5				; advance to next line...
		moveq	#$01,d3					; set number of sides

FL_NextLine:
		swap	d3					; send to upper word
		move.w	#$0001,d3				; set number of long-words

FL_NextLong:
		move.l	(a3)+,d0				; load long-word

		moveq	#$02-1,d1				; prepare number of digits
		move.w	#$0000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''

		moveq	#$02-1,d1				; prepare number of digits
		move.w	#$4000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''

		moveq	#$02-1,d1				; prepare number of digits
		move.w	#$0000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''

		moveq	#$02-1,d1				; prepare number of digits
		move.w	#$4000,d2				; prepare colour
		move.l	-$04(sp),d7				; draw the digits
		bsr	FreezeDraw				; ''
		move.l	d7,-$04(sp)				; ''

		dbf	d3,FL_NextLong				; repeat...

		move.w	#$0000,(a5)				; write space

		swap	d3					; get side counts
		dbf	d3,FL_NextLine				; repeat for both sides

		lea	-$10(a3),a3				; go back
		move.l	a3,d0					; load address
		addi.w	#$0010,d0				; advance (and wrap)
		move.l	d0,a3					; update address

		dbf	d4,FL_NextRow				; repeat for all rows

		bra.w	FreezeLoop				; loop debug lock...

; ===========================================================================
; ---------------------------------------------------------------------------
; Drawing digits
; ---------------------------------------------------------------------------

FreezeDraw:
		rol.l	#$04,d0					; get net digit
		move.b	d0,d2					; copy to d2
		andi.w	#$FF0F,d2				; get only the digit
		addq.b	#$01,d2					; adjust
		move.w	d2,(a5)					; save to VRAM
		dbf	d1,FreezeDraw				; repeat for all digits
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Reading controls (but in registers only)
; ---------------------------------------------------------------------------

FreezeControls:
		lea	($A10003).l,a0				; load control port A data address
		move.b	#%00000000,(a0)				; set TH to low
		nop						; wait a while for a response...
		nop						; ''
		move.b	(a0),d0					; load returned Start and A button bits
		lsl.b	#$02,d0					; send button bits furthest to the left
		andi.b	#%11000000,d0				; clear the other bits
		move.b	#%01000000,(a0)				; set TH to high
		nop						; wait a while for a response...
		nop						; ''
		move.b	(a0),d1					; load returned B, C and D-pad button bits
		andi.b	#%00111111,d1				; clear the other bits
		or.b	d1,d0					; add B, C and D-pad button bits to Start and A
		not.b	d0					; reverse button states (for XOR below)
		swap	d6					; get held buttons
		move.b	d6,d1					; load currently held buttons
		eor.b	d0,d1					; disable the buttons that are already held
		move.b	d0,d6					; save all held buttons
		swap	d6					; store held buttons
		and.b	d0,d1					; get only the newly pressed buttons
		move.b	d1,d6					; save all pressed buttons
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Data
; ---------------------------------------------------------------------------

		align	$20000

FreezePal:	dc.w	$0000,$0000,$0EEE,$0000,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0AAA,$0000,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0EAA,$0000,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0AEA,$0000,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000

FreezeArt:	binclude "Freeze\Art.bin"
FreezeArt_End:	even

; ===========================================================================