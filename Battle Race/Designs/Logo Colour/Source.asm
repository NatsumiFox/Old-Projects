; ===========================================================================
; ---------------------------------------------------------------------------
; Test ROM
; ---------------------------------------------------------------------------

		include	"Equates.asm"
		include	"Macros.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Start of ROM data
; ---------------------------------------------------------------------------

StartRom:	dc.l	$4EA10001+($07+$04)			; prepare TMSS address in the stack
		moveq	#$00,d4					; clear d4
		ori.b	#$00,d4					; a filler instruction, must be ori.b, must be d4 (The immediate value can be whatever necessary though).

	; --- Soft Reset ---

		tst.w	(sp)					; has control port C been initialised? (last port to be initialised)
		bne.w	SG_Reset				; if all ports have been initialised, branch

	; --- TMSS ---

		move.b	-($07+$04)(sp),d3			; load hardware version
		asl.b	#$04,d3					; get only hardware version ID
		beq.s	SG_NoTMSS				; if it's version 0, branch
		move.l	(ConsoleName).w,($3FFF-($07+$04))(sp)	; save SEGA to TMSS chip

SG_NoTMSS:

	; --- VDP DMA wait/Latch reset ---

		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port

SG_WaitDMA:
		move.w	(a6),ccr				; load status (this resets the 2nd write flag too)
		bvs.s	SG_WaitDMA				; if the VDP DMA busy flag was set (bit 1), branch to wait til finished...

	; --- VDP Register Setup & VRAM Clear ---

		lea	(SG_SetupList).w,a0			; load VDP register list
		movem.w	(a0)+,d1/d2/d5/a1			; load number of entries, 80XX value, 0100 for advancing (and for Z80 later), VDP reg RAM
		lea	(a1),a2					; copy start register address as end RAM address

SG_SetupVDP:
		move.w	d2,(a6)					; set VDP register
		move.w	d2,(a1)+				; ...and save to RAM storage
		add.w	d5,d2					; advance register ID
		move.b	(a0)+,d2				; load next register value
		dbf	d1,SG_SetupVDP				; repeat for all registers
		move.l	(a0)+,(a6)				; set DMA fill destination
		move.w	d4,(a5)					; set DMA fill value (0000)

	; --- 68k RAM Clear ---

		move.w	#SG_InitStack&$FFFF,-(a2)		; set first return address to the stack
		move.w	a2,d1					; copy address (for size of remaining 68k RAM)
		subq.w	#$01,d1					; minus 1 (for dbf)

SG_ClearRAM:
		move.b	d4,-(a2)				; clear entire RAM
		dbf	d1,SG_ClearRAM				; repeat until entire RAM is cleared

	; --- Loading Z80 related data (for Part 2) ---

		movem.l	(a0)+,d0/a1/a3-a4			; load Z80 RAM addresses & flag settings
		move.w	d5,(a3)					; request Z80 stop (ON)

	; --- CRAM/VSRAM Clear ---

		neg.w	d1		; convert FFFF to 0001	; number of times to run (Twice: CRAM first, VSRAM second)

SG_ClearCRAM:
		move.l	(a0)+,(a6)				; set VDP to VSRAM/CRAM write mode
		moveq	#$3F,d3					; set repeat times

SG_ClearVSRAM:
		move.w	d4,(a5)					; clear VSRAM/CRAM (done by word to slow the 68k down enough to stop the Z80 in time)
		dbf	d3,SG_ClearVSRAM			; repeat until entire VSRAM/CRAM is cleared
		move.w	d2,-(sp)				; initialise port B, then A (C will be done last)
		dbf	d1,SG_ClearCRAM				; repeat routine (VSRAM is done, CRAM is next)

	; --- Jumping to part 2 ---

		move.w	d5,(a4)					; request Z80 reset (OFF)

		bra.s	SG_Continue				; branch to part 2

; ---------------------------------------------------------------------------
; Setup information
; ---------------------------------------------------------------------------
;	 	align	$006C
; ---------------------------------------------------------------------------

		dc.l	R_HBlankInt				; H-blank address
SG_CounterSum:	dc.l	-$01234567				; counter checksum
		dc.l	R_VBlankInt				; V-blank address

SG_SetupList:	dc.w	$0018-1					; number of VDP registers to write
		dc.w	$8000|%00000100				; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)
		dc.w	$0100					; VDP Reg increment value & opposite initialisation flag for Z80
		dc.w	(R_VDPReg80&$FFFF)			; VDP register RAM storage area
		dc.b	%00010100				; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		dc.b	((($C000)>>$0A)&$FF)			; 00FE DCBA - Scroll Plane A Map Table VRam address
		dc.b	((($D000)>>$0A)&$FF)			; 00FE DCB0 / 00FE DC00 (20 Resolution) - Window Plane A Map Table VRam address
		dc.b	((($E000)>>$0D)&$FF)			; 0000 0FED - Scroll Plane B Map Table VRam address
		dc.b	((($BC00)>>$09)&$FF)			; 0FED CBA9 / 0FED CBA0 (20 Resolution) - Sprite Plane Map Table VRam address
		dc.b	$00					; 0000 0000 - Unknown/Unused Register
		dc.b	$30					; 00PP CCCC - Backdrop Colour: Palette Line 0/Colour ID 0
		dc.b	$00					; 0000 0000 - Unknown/Unused Register
		dc.b	$00					; 0000 0000 - Unknown/Unused Register
		dc.b	$DF					; 7654 3210 - H-Interrupt Register
		dc.b	%00000000				; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll: (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)
		dc.b	%10000001				; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
		dc.b	((($B800)>>$0A)&$FF)			; 00FE DCBA - Horizontal Scroll Table VRam address
		dc.b	$00					; 0000 0000 - Unknown/Unused Register
		dc.b	$02					; 7654 3210 - Auto Increament: By 2
		dc.b	%00000001				; 00VV 00HH - Plane Y Size (00-20|01-40|11-80) | Plane X size (00-20|01-40|11-80)
		dc.b	$00					; 7654 3210 - Window Horizontal Position
		dc.b	$00					; 7654 3210 - Window Vertical Position
		dc.b	$FF					; 7654 3210 - DMA Fill Size (FFFF bytes)
		dc.b	$FF					; FEDC BA98 - ''
		dc.b	$00					; 7654 3210 - DMA Fill Source (800000 Fill mode)
		dc.b	$00					; FEDC BA98 - ''
		dc.b	$80					; D654 3210 - '' D = DMA

		dc.b	%01000000				; control port initialisation flags
		dc.l	$40000080				; DMA Fill destination

	; --- Z80 register data ---

		dc.w	$000E,(($2000-$02)-$01)	; d0		; red checksum error colour & Z80 RAM size
		dc.l	$A00000			; a1		; load Z80 RAM address
		dc.l	$A11100			; a3		; load Z80 bus access port
		dc.l	$A11200			; a4		; load Z80 reset port

	; --- VSRAM/CRAM ---

		dc.l	$40000010				; VSRAM write mode
		dc.l	$C0000000				; CRAM write mode

		dc.b	$9F,$BF,$DF,$FF				; PSG mute values (PSG 1 to 4)
		dc.b	$F3,$C3					; di & jp instructions

; ---------------------------------------------------------------------------
; Initialising the stack before starting the game
; ---------------------------------------------------------------------------

SG_InitStack:
		pea	(ResetGame).w				; set "reset" routine address (when reset is pressed, this routine will run instead)
		bra.w	StartGame				; branch to starting routine

; ---------------------------------------------------------------------------
; Continue (Part 2)
; ---------------------------------------------------------------------------

SG_Continue:

	; --- PSG Reset ---

		moveq	#$04-1,d3				; set number of PSG channels to mute (for Part 2)

SG_MutePSG:
		move.b	(a0)+,$0D(a6)				; set the PSG channel volume to null (No sound)
		dbf	d3,SG_MutePSG				; repeat for all channels

	; --- Z80 Setup & YM2612 Reset ---

	;	btst.b	d4,(a3)	; No need, it was stopped a...	; has the Z80 stopped yet?
	;	bne.s	*-$08	; ...long time ago (see above)	; if not, branch
		move.b	(a0)+,(a1)+				; write di (disable interrupts) instruction
		move.b	(a0)+,(a1)+				; write jp (jump) instruction (the 00's after will jump to 0)

SG_ClearZ80:
		move.b	d4,(a1)+				; clear Z80 space
		dbf	d0,SG_ClearZ80				; repeat til done
		move.w	d4,(a4)					; request Z80 reset (ON)

	; --- ROM Checksum (is also enough delay for Z80 reset) ---

		move.l	(ROMFinish).w,a0			; load end ROM address

SG_CheckSum:
		add.l	-(a0),d4				; move back and add a long-word
		move.l	a0,d3					; copy address to d3
		bne.s	SG_CheckSum				; if the address is not 0, branch
		cmpi.l	#$01234567,d4				; is the ROM sum correct? (Modify this long-word externally)
		beq.s	SG_NoLockSum				; if not, branch and loop endlessly
		move.l	d0,(a5)					; write red colour to CRAM backdrop
		bra.s	*					; branch endlessly for checksum error (trap/loop)

SG_NoLockSum:
		move.w	d5,(a4)					; request Z80 reset (OFF)
		move.w	a0,(a3)					; request Z80 stop (OFF)

	; --- I/O port initialisation (Must be done last) ---

		move.w	d2,$04(sp)				; initialise port C (last one)

	; --- Final ---

SG_Reset:
		movea.w	#(R_StackSP&$FFFF),sp			; set stack address
		rts						; return

; ---------------------------------------------------------------------------
; Mega Drive specific data
; ---------------------------------------------------------------------------
;		align	$0100
; ---------------------------------------------------------------------------

ConsoleName:	dc.b	"SEGA MEGA DRIVE "
ProductDate:	dc.b	"(C)???? YYYY.MMM"
TitleLocal:	dc.b	"Engine Test                                     "
TitleInter:	dc.b	"Engine Test                                     "
SerialNumber:	dc.b	"GM XXXXXXXXXXX"
Checksum:	dc.w	$0000
IOSupport:	dc.b	"J               "
ROMStart:	dc.l	StartRom
ROMFinish:	dc.l	FinishRom
RAMStart:	dc.l	$00FF0000
RAMFinish:	dc.l	$00FFFFFF
SupportRAM:	dc.b	'RA',%11111000,%00100000
SRAMStart:	dc.l	$00200000
SRAMFinish:	dc.l	$00203FFF
ModemInfo:	dc.b	"                                                    "
ProductRegion:	dc.b	"JUE             "

; ===========================================================================
; ---------------------------------------------------------------------------
; Start of game
; ---------------------------------------------------------------------------

StartGame:
		lea	SG_RoutList-$02(pc),a0			; load routine list
		movea.w	(a0)+,a1				; set dumping address
		move.l	(a0)+,(a1)+				; jmp $0000
		move.l	(a0)+,(a1)+				; 0000 jmp
		move.l	(a0)+,(a1)+				; $0000 0000
		move.l	(a0)+,(a1)+				; jmp $0000
		move.w	(a0),(a1)				; 0000
		jmp	(R_MainInt).w				; jump to main routine

SG_RoutList:
		jmp	Screen
		jmp	HB_Screen
		jmp	VB_Screen

; ===========================================================================
; ---------------------------------------------------------------------------
; Reset game routine
; ---------------------------------------------------------------------------

ResetGame:
		move.l	#$C0000000,($C00004).l
		move.w	#$0E00,($C00000).l
		bra.s	*

; ===========================================================================
; ---------------------------------------------------------------------------
; Screen/Routine
; ---------------------------------------------------------------------------

Screen:
		move.l	#$40000000,(a6)
		lea	(Art).l,a0
		move.w	#((Map-Art)/$20)-1,d0

S_ArtLoad:
		move.l	(a0)+,(a5)
		move.l	(a0)+,(a5)
		move.l	(a0)+,(a5)
		move.l	(a0)+,(a5)
		move.l	(a0)+,(a5)
		move.l	(a0)+,(a5)
		move.l	(a0)+,(a5)
		move.l	(a0)+,(a5)
		dbf	d0,S_ArtLoad

		move.l	#$40000003,(a6)
		lea	(Map).l,a0
		move.w	#((Map-Art)/$02)-1,d0

S_MapLoad:
		move.w	(a0)+,(a5)
		dbf	d0,S_MapLoad

		lea	(Pal).l,a0
		lea	($FFFF0000).l,a1
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+

		move.b	#%01110100,(R_VDPReg81+1).w
		move.w	(R_VDPReg81).w,(a6)

MainLoop:
		st.b	($FFFF8000).w
		move	#$2300,sr

ML_WaitVBlank:
		tst.b	($FFFF8000).w
		bne.s	ML_WaitVBlank
		pea	MainLoop(pc)
		bsr.w	ReadControls
		bsr.w	ProcessControls


		lea	(Pal+$02).l,a0
		lea	($FFFF0002).l,a1
		lea	($FFFF8001).w,a2
		moveq	#$07-1,d2
		bsr.s	NextColour

		lea	(Pal+$10).l,a0
		lea	($FFFF0010).l,a1
		lea	($FFFF800C).w,a2
		moveq	#$01-1,d2
		bsr.s	NextColour

		lea	(Pal+$12).l,a0
		lea	($FFFF0012).l,a1
		lea	($FFFF8008).w,a2
		moveq	#$07-1,d2
		bsr.s	NextColour

	rts

		tst.b	($FFFF8005).w
		bpl.s	NoWhiteUp
		addi.w	#$0222,($FFFF0010).l
		cmpi.w	#$0EEE,($FFFF0010).l
		ble.s	NoWhiteUp
		move.w	#$0EEE,($FFFF0010).l

NoWhiteUp:
		tst.b	($FFFF8007).w
		bpl.s	NoWhiteDown
		subi.w	#$0222,($FFFF0010).l
		bpl.s	NoWhiteDown
		clr.w	($FFFF0010).l

NoWhiteDown:
		rts

NextColour:
		move.b	(a0)+,d0
		add.b	(a2),d0
		bsr.s	DoCap
		move.b	d0,(a1)+

		move.b	(a0),d0
		lsr.b	#$04,d0
		add.b	$01(a2),d0
		bsr.s	DoCap
		lsl.b	#$04,d0
		move.b	d0,d1

		move.b	(a0)+,d0
		andi.b	#$0E,d0
		add.b	$02(a2),d0
		bsr.s	DoCap
		or.b	d1,d0
		move.b	d0,(a1)+
		dbf	d2,NextColour

		rts

DoCap:
		bpl.s	NoBottomCap
		moveq	#$00,d0

NoBottomCap:
		cmpi.b	#$0E,d0
		bls.s	NoTopCap
		moveq	#$0E,d0

NoTopCap:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; using controls to change colour
; ---------------------------------------------------------------------------

ProcessControls:

		move.b	($FFFF8005).w,d0
		or.b	($FFFF8007).w,d0
		bpl.s	NoStart
		not.b	($FFFF800F).w

NoStart:
		tst.b	($FFFF800F).w
		beq.s	Normal
		lea	($FFFF800C).w,a0
		lea	($FFFF8004).w,a1
		bsr.s	PC_Change
		lea	($FFFF800C).w,a0
		lea	($FFFF8006).w,a1
		bra.s	PC_Change

Normal:
		lea	($FFFF8001).w,a0
		lea	($FFFF8004).w,a1
		bsr.s	PC_Change
		lea	($FFFF8008).w,a0
		lea	($FFFF8006).w,a1

PC_Change:
		move.b	$01(a1),d1
		andi.b	#%00000011,d1
		beq.s	NoGreen

		moveq	#$FFFFFFFE,d2
		lsr.b	#$01,d1
		bcc.s	NoUp
		moveq	#$02,d2

NoUp:
		move.b	(a1),d0
		add.b	d0,d0
		bpl.s	NoBlue
		add.b	d2,(a0)
		cmpi.b	#$0E,(a0)
		ble.s	NoBlueCap
		move.b	#$0E,(a0)

NoBlueCap:
		cmpi.b	#-$E,(a0)
		bgt.s	NoBlue
		move.b	#-$E,(a0)

NoBlue:
		add.b	d0,d0
		bpl.s	NoRed
		add.b	d2,$02(a0)
		cmpi.b	#$0E,$02(a0)
		ble.s	NoRedCap
		move.b	#$0E,$02(a0)

NoRedCap:
		cmpi.b	#-$E,$02(a0)
		bgt.s	NoRed
		move.b	#-$E,$02(a0)

NoRed:
		add.b	d0,d0
		bpl.s	NoGreen
		add.b	d2,$01(a0)
		cmpi.b	#$0E,$01(a0)
		ble.s	NoGreenCap
		move.b	#$0E,$01(a0)

NoGreenCap:
		cmpi.b	#-$E,$01(a0)
		bgt.s	NoGreen
		move.b	#-$E,$01(a0)

NoGreen:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; H-blank interrupt routine
; ---------------------------------------------------------------------------

HB_Screen:
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank interrupt routine
; ---------------------------------------------------------------------------

VB_Screen:
		movem.l	d0-a4,-(sp)
		move.l	#$94009310,(a6)
		move.l	#$96809500,(a6)
		move.l	#$977FC000,(a6)
		move.w	#$0080,(a6)
		movem.l	(sp)+,d0-a4
		sf.b	($FFFF8000).w
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to	collect standard 3-button controller holds/presses
; ---------------------------------------------------------------------------

ReadControls:
		lea	($FFFF8004).w,a0			; load controller button storage address
		lea	($A10003).l,a1				; load control port A data address
		bsr.s	RC_Collect				; load button values for "control pad A" (player 1)
		addq.w	#$02,a1					; advance to port B data address
						; continue to..	; load button values for "control pad B" (player 2)

RC_Collect:
		move.b	#%00000000,(a1)				; set TH to low
		nop						; wait a while for a response...
		nop						; ''
		move.b	(a1),d0					; load returned Start and A button bits
		lsl.b	#$02,d0					; send button bits furthest to the left
		andi.b	#%11000000,d0				; clear the other bits
		move.b	#%01000000,(a1)				; set TH to high
		nop						; wait a while for a response...
		nop						; ''
		move.b	(a1),d1					; load returned B, C and D-pad button bits
		andi.b	#%00111111,d1				; clear the other bits
		or.b	d1,d0					; add B, C and D-pad button bits to Start and A
		not.b	d0					; reverse button states (for XOR below)
		move.b	(a0),d1					; load currently held buttons
		eor.b	d0,d1					; disable the buttons that are already held
		move.b	d0,(a0)+				; save all held buttons
		and.b	d0,d1					; get only the newly pressed buttons
		move.b	d1,(a0)+				; save all pressed buttons
		rts						; return

; ===========================================================================


Art:		incbin	"Art.bin"
Map:		incbin	"Map.bin"
Pal:		incbin	"Palette.bin"


		align	$04					; must align to the next long-word (for checksum)
FinishRom:


