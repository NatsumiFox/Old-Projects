;  =========================================================================
; |           Sonic the Hedgehog Disassembly for Sega Mega Drive            |
;  =========================================================================
;
; Disassembly created by Hivebrain
; thanks to drx, Stealth and Esrael L.G. Neto

lag =		1	; 1 for lag
; ===========================================================================
		include "driver/lang.asm"
		include	"ErrorDebugger/Debugger.asm"
	include	"Constants.asm"
	include	"Variables.asm"
	include	"Macros.asm"
	opt w-

EnableSRAM:	equ 0	; change to 1 to enable SRAM
BackupSRAM:	equ 1
AddressSRAM:	equ 0	; 0 = odd+even; 2 = even only; 3 = odd only

Revision:	equ 1	; change to 1 for JP1 revision

ZoneCount:	equ 7	; discrete zones are: GHZ, MZ, SYZ, LZ, SLZ, SBZ and Ending

OptimiseSound:	equ 0	; change to 1 to optimise sound queuing
; ===========================================================================
	org 0

StartOfRom:
	if error
		dc.l 0, EntryPoint, BusError, AddressError
		dc.l IllegalInstr, ZeroDivide, ChkInstr, TrapvInstr
		dc.l PrivilegeViol, Trace, Line1010Emu, Line1111Emu
		dc.l ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept
		dc.l ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept
		dc.l ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept
		dc.l ErrorExcept, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l HBlank, ErrorTrap, VBlank, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
	else
		dc.l 0, EntryPoint, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l HBlank, ErrorTrap, VBlank, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
	endif

	if safe=0
ErrorTrap:
	endif
ConsoleName:	dc.b "SEGA CanSuckDick" ; Hardware system ID
Date:		dc.b "NATZI.NET S-EX69" ; Release date
Title_Local:	dc.b "INSERT SOME GAY ASS SHIT HERE AND YOU ARE WINRAR" ; Domestic name
Title_Int:	dc.b "INSERT SOME GAY ASS SHIT HERE AND YOU ARE WINRAR" ; International name
		dc.b "GM PISSANTS-00"
Checksum:	dc.w 0
		dc.b "J               " ; I/O support
RomStartLoc:	dc.l StartOfRom		; ROM start
RomEndLoc:	dc.l EndOfRom-1		; ROM end
RamStartLoc:	dc.l $FF0000		; RAM start
RamEndLoc:	dc.l $FFFFFF		; RAM end
SRAMSupport:	dc.w "RA"
		dc.b $A0+(BackupSRAM<<6)+(AddressSRAM<<3), $20
		dc.l $200000		; SRAM start ($200001)
		dc.l $2003FF		; SRAM end ($20xxxx)		  '
Notes:		dc.b "THE MOST IMPORTANT THING TO KNOW IS HOW TO SUCK DICK"
Region:		dc.b "JUE             " ; Region

; ===========================================================================
SetupValues:	dc.w $8000		; VDP register start number
		dc.w $3FFF		; size of RAM/4
		dc.w $100		; VDP register diff

		dc.l z80_ram		; start	of Z80 RAM
		dc.l z80_bus_request	; Z80 bus request
		dc.l z80_reset		; Z80 reset
		dc.l vdp_data_port	; VDP data
		dc.l vdp_control_port	; VDP control

		dc.b 4			; VDP $80 - 8-colour mode
		dc.b $14		; VDP $81 - Megadrive mode, DMA enable
		dc.b ($C000>>10)	; VDP $82 - foreground nametable address
		dc.b ($F000>>10)	; VDP $83 - window nametable address
		dc.b ($E000>>13)	; VDP $84 - background nametable address
		dc.b ($D800>>9)		; VDP $85 - sprite table address
		dc.b 0			; VDP $86 - unused
		dc.b 0			; VDP $87 - background colour
		dc.b 0			; VDP $88 - unused
		dc.b 0			; VDP $89 - unused
		dc.b 255		; VDP $8A - HBlank register
		dc.b 0			; VDP $8B - full screen scroll
		dc.b $81		; VDP $8C - 40 cell display
		dc.b ($DC00>>10)	; VDP $8D - hscroll table address
		dc.b 0			; VDP $8E - unused
		dc.b 1			; VDP $8F - VDP increment
		dc.b 1			; VDP $90 - 64 cell hscroll size
		dc.b 0			; VDP $91 - window h position
		dc.b 0			; VDP $92 - window v position
		dc.w $FFFF		; VDP $93/94 - DMA length
		dc.w 0			; VDP $95/96 - DMA source
		dc.b $80		; VDP $97 - DMA fill VRAM
		dc.l $40000080		; VRAM address 0

initz80	z80prog 0
	; init FM table
		ld	de,1000h	; then get the position to put at
.fill		ld	hl,.filldat	; get fill data to hl
		ldi			; load all 4 bytes
		ldi
		ldi
		ldi
		ld	a,d		; get high byte of address to a
		cp	20h		; check if end of RAM
		jrnz	.fill		; if not, branch

	; clear some RAM
		xor	a
		ld	bc,1000h-DualPCM_sz-1; set len
		ld	de,DualPCM_sz+1	; set destination
		ld	hl,DualPCM_sz	; set source
		ld	sp,hl
		ld	(hl),80h
		ldir
		pop	ix
		pop	iy
		ld	i,a
		ld	r,a
		pop	de
		pop	hl
		pop	af
		ex	af,af
		exx
		pop	bc
		pop	de
		pop	hl
		pop	af
		di
		im	1
.pc		jp	.pc

.filldat	dw	0FFFFh; Swapped, so the 68k can write the low byte, and immediately increment to the address/data bytes
		dw	0FFFFh
	z80prog
		even
endinit

		dc.w $8104		; VDP display mode
		dc.w $8F02		; VDP increment
		dc.l $C0000000		; CRAM write mode
		dc.l $40000010		; VSRAM address 0

		dc.b $9F, $BF, $DF, $FF	; values for PSG channel volumes
; ===========================================================================

EntryPoint:
		tst.l	(z80_port_1_control).l ; test port A & B control registers
		bne.s	PortA_Ok
		tst.w	(z80_expansion_control).l ; test port C control register
	PortA_Ok:
		bne.w	SoftReset

		lea	SetupValues(pc),a5
		movem.w	(a5)+,d5-d7
		movem.l	(a5)+,a0-a4
		move.b	-$10FF(a1),d0	; get hardware version (from $A10001)
		andi.b	#$F,d0
		beq.s	SkipSecurity
		move.l	ConsoleName.w,$2F00(a1) ; move "SEGA" to TMSS register ($A14000)

SkipSecurity:
		move.w	(a4),d0
		moveq	#0,d0
		movea.l	d0,a6
		move.l	a6,usp		; set usp to 0

		moveq	#$17,d1
VDPInitLoop:
		move.b	(a5)+,d5	; add $8000 to value
		move.w	d5,(a4)		; move value to	VDP register
		add.w	d7,d5		; next register
		dbf	d1,VDPInitLoop
		move.l	(a5)+,(a4)
		move.w	d0,(a3)		; clear	the VRAM
		move.w	d7,(a1)		; stop the Z80
		move.w	d7,(a2)		; reset	the Z80

	WaitForZ80:
		btst	d0,(a1)		; has the Z80 stopped?
		bne.s	WaitForZ80	; if not, branch

		moveq	#endinit-initz80-1,d2
Z80InitLoop:
		move.b	(a5)+,(a0)+
		dbf	d2,Z80InitLoop
		move.w	d0,(a2)
		move.w	d0,(a1)		; start	the Z80
		move.w	d7,(a2)		; reset	the Z80

ClrRAMLoop:
		move.l	d0,-(a6)
		dbf	d6,ClrRAMLoop	; clear	the entire RAM
		move.l	(a5)+,(a4)	; set VDP display mode and increment
		move.l	(a5)+,(a4)	; set VDP to CRAM write

		moveq	#$1F,d3
ClrCRAMLoop:
		move.l	d0,(a3)
		dbf	d3,ClrCRAMLoop	; clear	the CRAM
		move.l	(a5)+,(a4)

		moveq	#$13,d4
ClrVSRAMLoop:
		move.l	d0,(a3)
		dbf	d4,ClrVSRAMLoop ; clear the VSRAM
		moveq	#3,d5

PSGInitLoop:
		move.b	(a5)+,$11(a3)	; reset	the PSG
		dbf	d5,PSGInitLoop
		move.w	d0,(a2)
		movem.l	(a6),d0-a6	; clear	all registers
		disable_ints

		lea	($FF0000).l,a6
		moveq	#0,d7
		move.w	#$3FFF,d6
@clearRAM:
		move.l	d7,(a6)+
		dbf	d6,@clearRAM	; clear RAM ($0000-$FDFF)
		bra.s	GameProgram

SoftReset:
	ac	ac_Soft, a0
		jsr	UpdateSRAM.w

GameProgram:
	disable_ints
		tst.w	(vdp_control_port).l

GameInit:

		move.b	(z80_version).l,d0
		andi.b	#$C0,d0
		move.b	d0,(v_megadrive).w ; get region setting
		lea	$FFFE00,sp

		bsr.w	VDPSetupGame
		bsr.w	JoypadInit
		jsr	LoadDualPCM
		move.b	#id_Sega,(v_gamemode).w ; set Game Mode to Sega Screen

MainGameLoop:
		move.b	(v_gamemode).w,d0 ; load Game Mode
		andi.w	#$1C,d0
		jsr	GameModeArray(pc,d0.w) ; jump to apt location in ROM
		bra.s	MainGameLoop
; ===========================================================================
; ---------------------------------------------------------------------------
; Main game mode array
; ---------------------------------------------------------------------------

GameModeArray:

ptr_GM_Sega:	bra.w	GM_Sega		; Sega Screen ($00)

ptr_GM_Title:	bra.w	GM_Title	; Title	Screen ($04)

ptr_GM_Demo:	bra.w	GM_Level	; Demo Mode ($08)

ptr_GM_Level:	bra.w	GM_Level	; Normal Level ($0C)

ptr_GM_Special:
ptr_GM_Cont:
ptr_GM_Ending:
ptr_GM_Credits:
; ===========================================================================

CheckSumError:
		bsr.w	VDPSetupGame
		move.l	#$C0000000,(vdp_control_port).l ; set VDP to CRAM write
		moveq	#$3F,d7

	@fillred:
		move.w	#cRed,(vdp_data_port).l ; fill palette with red
		dbf	d7,@fillred	; repeat $3F more times

	@endlessloop:
		bra.s	@endlessloop
; ===========================================================================

Art_Text:	incbin	"artunc\menutext.bin" ; text used in level select and debug mode
		even

		include "_inc/SRAM.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Vertical interrupt
; ---------------------------------------------------------------------------

VBlank:
		movem.l	d0-a6,-(sp)
		tst.b	(v_vbla_routine).w
		beq.s	VBla_00
		move.w	(vdp_control_port).l,d0
		move.l	#$40000010,(vdp_control_port).l
		move.l	(v_scrposy_dup).w,(vdp_data_port).l ; send screen y-axis pos. to VSRAM

		move.b	(v_vbla_routine).w,d0
		clr.b	(v_vbla_routine).w
		move.w	#1,(f_hbla_pal).w
		andi.w	#$3E,d0
		move.w	VBla_Index(pc,d0.w),d0
		jsr	VBla_Index(pc,d0.w)

VBla_Music:
		jsr	UpdateAMPS

VBla_Exit:
		addq.l	#1,(v_vbla_count).w
		move.w	#$9193,$C00004		; enable window
		movem.l	(sp)+,d0-a6
		rte
; ===========================================================================
VBla_Index:	dc.w VBla_00-VBla_Index, VBla_02-VBla_Index
		dc.w VBla_04-VBla_Index, VBla_06-VBla_Index
		dc.w VBla_08-VBla_Index, VBla_0A-VBla_Index
		dc.w VBla_0C-VBla_Index, VBla_0E-VBla_Index
		dc.w VBla_10-VBla_Index, VBla_12-VBla_Index
		dc.w VBla_14-VBla_Index, VBla_16-VBla_Index
		dc.w VBla_18-VBla_Index
; ===========================================================================

VBla_00:
	if lag=1
		addq.l	#1,LAGF.w
		st	f_scorecount.w
	endif
		bra.s	VBla_Music	; if not, branch
; ===========================================================================

VBla_02:
		bsr.w	sub_106E

VBla_14:
		tst.w	(v_demolength).w
		beq.w	@end
		subq.w	#1,(v_demolength).w

	@end:
		jmp	SaveKosVint
; ===========================================================================

VBla_04:
		bsr.w	sub_106E
		bsr.w	sub_6886
		tst.w	(v_demolength).w
		beq.w	@end
		subq.w	#1,(v_demolength).w

	@end:
		jmp	SaveKosVint
; ===========================================================================

VBla_10:
		cmpi.b	#id_Special,(v_gamemode).w ; is game on special stage?
		beq.w	VBla_0A		; if yes, branch

VBla_08:
		bsr.w	ReadJoypads
		tst.b	(f_wtr_state).w
		bne.s	@waterabove

		writeCRAM	v_pal_dry,$80,0
		bra.s	@waterbelow

@waterabove:
		writeCRAM	v_pal_water,$80,0

	@waterbelow:
		move.w	(v_hbla_hreg).w,(a5)

		writeVRAM	v_hscrolltablebuffer,$380,vram_hscroll
		writeVRAM	v_spritetablebuffer,$280,vram_sprites
		jsr	ProcessDMAQueue(pc)

	@nochg:
		movem.l	(v_screenposx).w,d0-d7
		movem.l	d0-d7,($FFFFFF10).w
		movem.l	(v_bgscroll1).w,d0-d1
		movem.l	d0-d1,($FFFFFF30).w
		cmpi.b	#96,(v_hbla_line).w
		bhs.s	@a
		move.b	#1,($FFFFF64F).w
		addq.l	#4,sp
		jsr	SaveKosVint
		bra.w	VBla_Exit

@a		bsr.s	Demo_Time
		jmp	SaveKosVint

; ---------------------------------------------------------------------------
; Subroutine to	run a demo for an amount of time
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Demo_Time:
		bsr.w	LoadTilesAsYouMove
		jsr	(AnimateLevelGfx).l
		jsr	(HUD_Update).l
		tst.w	(v_demolength).w ; is there time left on the demo?
		beq.w	@end		; if not, branch
		subq.w	#1,(v_demolength).w ; subtract 1 from time left
@end:		rts

; ===========================================================================

VBla_0A:
		bsr.w	ReadJoypads
		writeCRAM	v_pal_dry,$80,0
		writeVRAM	v_spritetablebuffer,$280,vram_sprites
		writeVRAM	v_hscrolltablebuffer,$380,vram_hscroll
		jsr	ProcessDMAQueue(pc)

	@nochg:
		tst.w	(v_demolength).w
		beq.w	@end
		subq.w	#1,(v_demolength).w

	@end:
		jmp	SaveKosVint
; ===========================================================================

VBla_0C:
		bsr.w	ReadJoypads
		tst.b	(f_wtr_state).w
		bne.s	@waterabove

		writeCRAM	v_pal_dry,$80,0
		bra.s	@waterbelow

@waterabove:
		writeCRAM	v_pal_water,$80,0

	@waterbelow:
		move.w	(v_hbla_hreg).w,(a5)
		writeVRAM	v_hscrolltablebuffer,$380,vram_hscroll
		writeVRAM	v_spritetablebuffer,$280,vram_sprites
		jsr	ProcessDMAQueue(pc)

	@nochg:
		movem.l	(v_screenposx).w,d0-d7
		movem.l	d0-d7,($FFFFFF10).w
		movem.l	(v_bgscroll1).w,d0-d1
		movem.l	d0-d1,($FFFFFF30).w
		bsr.w	LoadTilesAsYouMove
		jsr	(AnimateLevelGfx).l
		jsr	(HUD_Update).l
		jmp	SaveKosVint
; ===========================================================================

VBla_0E:
		bsr.w	sub_106E
		addq.b	#1,($FFFFF628).w
		move.b	#$E,(v_vbla_routine).w
		jmp	SaveKosVint
; ===========================================================================

VBla_12:
		bsr.w	sub_106E
		move.w	(v_hbla_hreg).w,(a5)
		jmp	SaveKosVint
; ===========================================================================

VBla_16:
		bsr.w	ReadJoypads
		writeCRAM	v_pal_dry,$80,0
		writeVRAM	v_spritetablebuffer,$280,vram_sprites
		writeVRAM	v_hscrolltablebuffer,$380,vram_hscroll
		jsr	ProcessDMAQueue(pc)

	@nochg:
		tst.w	(v_demolength).w
		beq.w	@end
		subq.w	#1,(v_demolength).w

	@end:
		jmp	SaveKosVint
; ===========================================================================

VBla_06:
		move.w	#$8134,(a6)	; disable disp
		move.w	(v_hbla_hreg).w,(a6)
		rts

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_106E:
		bsr.w	ReadJoypads
		tst.b	(f_wtr_state).w ; is water above top of screen?
		bne.s	@waterabove	; if yes, branch
		writeCRAM	v_pal_dry,$80,0
		bra.s	@waterbelow

	@waterabove:
		writeCRAM	v_pal_water,$80,0

	@waterbelow:
		writeVRAM	v_spritetablebuffer,$280,vram_sprites
		writeVRAM	v_hscrolltablebuffer,$380,vram_hscroll
	;	bsr.s	ProcessDMAQueue
	;	rts
; End of function sub_106E
; ---------------------------------------------------------------------------
; Subroutine for issuing all VDP commands that were queued
; (by earlier calls to QueueDMATransfer)
; Resets the queue when it's done
; ---------------------------------------------------------------------------

ProcessDMAQueue:
                lea	DMAqueue.w,a1

ProcessDMAQueue_Loop:
                move.w  (a1)+,d0
                beq.s   ProcessDMAQueue_Done ; branch if we reached a stop token
                ; issue a set of VDP commands...
                move.w  d0,(a5)         ; transfer length
                move.w  (a1)+,(a5)      ; transfer length
                move.w  (a1)+,(a5)      ; source address
                move.w  (a1)+,(a5)      ; source address
                move.w  (a1)+,(a5)      ; source address
                move.w  (a1)+,(a5)      ; destination
                move.w  (a1)+,(a5)      ; destination
                cmpa.w  #DMAqueEnd,a1
                bne.s   ProcessDMAQueue_Loop ; loop if we haven't reached the end of the buffer

ProcessDMAQueue_Done:
                clr.w	DMAqueue.w
                move.w	#DMAqueue,DMAquePtr.w
                rts

; ---------------------------------------------------------------------------
; Subroutine for queueing VDP commands (seems to only queue transfers to VRAM),
; to be issued the next time ProcessDMAQueue is called.
; Can be called a maximum of 18 times before the buffer needs to be cleared
; by issuing the commands (this subroutine DOES check for overflow)
; ---------------------------------------------------------------------------
; In case you wish to use this queue system outside of the spin dash, this is the
; registers in which it expects data in:
; d1.l: Address to data (In 68k address space)
; d2.w: Destination in VRAM
; d3.w: Length of data
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; sub_144E: DMA_68KtoVRAM: QueueCopyToVRAM: QueueVDPCommand: Add_To_DMA_Queue:
QueueDMATransfer:
                movea.w DMAquePtr.w,a1
                cmpa.w  #DMAqueEnd,a1
                beq.s   QueueDMATransfer_Done ; return if there's no more room in the buffer

		move.w	#$9300,d0
		move.b	d3,d0
		move.w	d0,(a1)+		; set first 8 bits of length

		move.w	#$9400,d0
		lsr.w	#8,d3
		move.b	d3,d0
		move.w	d0,(a1)+		; set second 8 bits of length

		move.w	#$9500,d0
		lsr.l	#1,d1
		move.b	d1,d0
		move.w	d0,(a1)+		; set source address & $0001FE

		move.w	#$9600,d0
		lsr.l	#8,d1
		move.b	d1,d0
		move.w	d0,(a1)+		; set source address & $01FE00

		move.w	#$9700,d0
		lsr.l	#8,d1
		andi.b	#$7F,d1			; ensures high bit isn't set
		move.b	d1,d0			; without this any value > $FFFFFF will cause VRAM corruption
		move.w	d0,(a1)+		; set source address & $FE0000

		andi.l	#$FFFF,d2
		lsl.l	#2,d2
		lsr.w	#2,d2
		swap	d2
		ori.l	#$40000080,d2		; get DMA command
		move.l	d2,(a1)+		; write DMA mode to target address

		move.w  a1,DMAquePtr.w	; set the next free slot address
		clr.w	(a1)		; put a stop token at the end of the used part of the buffer

QueueDMATransfer_Done:
		rts

; ---------------------------------------------------------------------------
; Horizontal interrupt
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


HBlank:
		disable_ints
		move.w	hblreg.w,(a6)	; move reg
		rte

; ---------------------------------------------------------------------------
; Subroutine to	initialise joypads
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


JoypadInit:
		moveq	#$40,d0
		move.b	d0,($A10009).l	; init port 1 (joypad 1)
		move.b	d0,($A1000B).l	; init port 2 (joypad 2)
		move.b	d0,($A1000D).l	; init port 3 (expansion)
		move.w	#10*60*60,afkctr.w	; set time out
		rts
; End of function JoypadInit

; ---------------------------------------------------------------------------
; Subroutine to	read joypad input, and send it to the RAM
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


VBla_18:
ReadJoypads:
		lea	(v_jpadhold1).w,a0 ; address where joypad states are written
		lea	($A10003).l,a1	; first	joypad port
		move.b	#0,(a1)
		or.l	d0,d0
		move.b	(a1),d0
		lsl.b	#2,d0
		andi.b	#$C0,d0
		move.b	#$40,(a1)
		or.l	d0,d0
		move.b	(a1),d1
		andi.b	#$3F,d1
		or.b	d1,d0
		not.b	d0
		move.b	(a0),d1
		eor.b	d0,d1
		move.b	d0,(a0)+
		and.b	d0,d1
		move.b	d1,(a0)+

		tst.w	-(a0)
		bne.s	@pressed

		subq.w	#1,afkctr.w	; sub 1 from afk viewer
		bne.s	@rts
	ac	ac_AFK,a6
		jsr	UpdateSRAM.w

@pressed	move.w	#10*60*60,afkctr.w	; set time out
@rts		rts

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


VDPSetupGame:
		lea	(vdp_control_port).l,a0
		lea	(vdp_data_port).l,a1
		lea	(VDPSetupArray).l,a2
		moveq	#$12,d7

	@setreg:
		move.w	(a2)+,(a0)
		dbf	d7,@setreg	; set the VDP registers

		move.w	VDPSetupArray+2(pc),(v_vdp_buffer1).w
		move.w	#$8A00+223,(v_hbla_hreg).w
		moveq	#0,d0
		move.l	#$C0000000,(vdp_control_port).l ; set VDP to CRAM write
		move.w	#$3F,d7

	@clrCRAM:
		move.w	d0,(a1)
		dbf	d7,@clrCRAM	; clear	the CRAM

		clr.l	(v_scrposy_dup).w
		clr.l	(v_scrposx_dup).w
		move.l	d1,-(sp)
		fillVRAM	0,$FFFF,0

	@waitforDMA:
		move.w	(a5),d1
		btst	#1,d1		; is DMA (fillVRAM) still running?
		bne.s	@waitforDMA	; if yes, branch

		move.w	#$8F02,(a5)	; set VDP increment size
		move.l	(sp)+,d1
		rts
; End of function VDPSetupGame

; ===========================================================================
VDPSetupArray:	dc.w $8004		; 8-colour mode
		dc.w $8134		; enable V.interrupts, enable DMA
		dc.w $8200+(vram_fg>>10) ; set foreground nametable address
		dc.w $8300+($A000>>10)	; set window nametable address
		dc.w $8400+(vram_bg>>13) ; set background nametable address
		dc.w $8500+(vram_sprites>>9) ; set sprite table address
		dc.w $8600		; unused
		dc.w $8700		; set background colour (palette entry 0)
		dc.w $8800		; unused
		dc.w $8900		; unused
		dc.w $8A00		; default H.interrupt register
		dc.w $8B00		; full-screen vertical scrolling
		dc.w $8C81		; 40-cell display mode
		dc.w $8D00+(vram_hscroll>>10) ; set background hscroll address
		dc.w $8E00		; unused
		dc.w $8F02		; set VDP increment size
		dc.w $9001		; 64-cell hscroll size
		dc.w $9100		; window horizontal position
		dc.w $9200		; window vertical position

; ---------------------------------------------------------------------------
; Subroutine to	clear the screen
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ClearScreen:
		fillVRAM	0,$FFF,vram_fg ; clear foreground namespace

	@wait1:
		move.w	(a5),d1
		btst	#1,d1
		bne.s	@wait1

		move.w	#$8F02,(a5)
		fillVRAM	0,$FFF,vram_bg ; clear background namespace

	@wait2:
		move.w	(a5),d1
		btst	#1,d1
		bne.s	@wait2

		move.w	#$8F02,(a5)
		clr.l	(v_scrposy_dup).w
		clr.l	(v_scrposx_dup).w

		jsr	ResetSpriteList
		lea	(v_hscrolltablebuffer).w,a1
		moveq	#0,d0
		move.w	#($380/4)-1,d1	; This should be ($400/4)-1, leading to a slight bug (first bit of the Sonic object's RAM is cleared)

	@clearhscroll:
		move.l	d0,(a1)+
		dbf	d1,@clearhscroll ; clear hscroll table (in RAM)
		rts
; End of function ClearScreen

		include	"_incObj\sub PlaySound.asm"
		include	"_inc\PauseGame.asm"
		include	"_inc\AchiList.asm"

; ---------------------------------------------------------------------------
; Subroutine to	copy a tile map from RAM to VRAM namespace

; input:
;	a1 = tile map address
;	d0 = VRAM address
;	d1 = width (cells)
;	d2 = height (cells)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


TilemapToVRAM:
		lea	(vdp_data_port).l,a6
		move.l	#$800000,d4

	Tilemap_Line:
		move.l	d0,4(a6)
		move.w	d1,d3

	Tilemap_Cell:
		move.w	(a1)+,(a6)	; write value to namespace
		dbf	d3,Tilemap_Cell
		add.l	d4,d0		; goto next line
		dbf	d2,Tilemap_Line
		rts

		include	"_inc\Enigma Decompression.asm"
		include	"_inc\Kosinski Decompression.asm"

		include	"_inc\PaletteCycle.asm"

Pal_TitleCyc:	incbin	"palette\Cycle - Title Screen Water.bin"
Pal_GHZCyc:	incbin	"palette\Cycle - GHZ.bin"
; ---------------------------------------------------------------------------
; Subroutine to	fade in from black
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PaletteFadeIn:
		move.w	#$003F,(v_pfade_start).w ; set start position = 0; size = $40

PalFadeIn_Alt:				; start position and size are already set
		moveq	#0,d0
		lea	(v_pal_dry).w,a0
		move.b	(v_pfade_start).w,d0
		adda.w	d0,a0
		moveq	#cBlack,d1
		move.b	(v_pfade_size).w,d0

	@fill:
		move.w	d1,(a0)+
		dbf	d0,@fill 	; fill palette with black

		move.w	#$15,d4

	@mainloop:
		move.w	d4,-(sp)
		move.b	#$12,(v_vbla_routine).w
		jsr	ProcKos
		bsr.w	WaitForVBla
		bsr.s	FadeIn_FromBlack
		jsr	ProcKosM
		move.w	(sp)+,d4
		dbf	d4,@mainloop
		rts
; End of function PaletteFadeIn


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


FadeIn_FromBlack:
		moveq	#0,d0
		lea	(v_pal_dry).w,a0
		lea	(v_pal_dry_dup).w,a1
		move.b	(v_pfade_start).w,d0
		adda.w	d0,a0
		adda.w	d0,a1
		move.b	(v_pfade_size).w,d0

	@addcolour:
		bsr.s	FadeIn_AddColour ; increase colour
		dbf	d0,@addcolour	; repeat for size of palette

		cmpi.b	#id_LZ,(v_zone).w	; is level Labyrinth?
		bne.s	@exit		; if not, branch

		moveq	#0,d0
		lea	(v_pal_water).w,a0
		lea	(v_pal_water_dup).w,a1
		move.b	(v_pfade_start).w,d0
		adda.w	d0,a0
		adda.w	d0,a1
		move.b	(v_pfade_size).w,d0

	@addcolour2:
		bsr.s	FadeIn_AddColour ; increase colour again
		dbf	d0,@addcolour2 ; repeat

@exit:
		rts
; End of function FadeIn_FromBlack


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


FadeIn_AddColour:
@addblue:
		move.w	(a1)+,d2
		move.w	(a0),d3
		cmp.w	d2,d3		; is colour already at threshold level?
		beq.s	@next		; if yes, branch
		move.w	d3,d1
		addi.w	#$200,d1	; increase blue	value
		cmp.w	d2,d1		; has blue reached threshold level?
		bhi.s	@addgreen	; if yes, branch
		move.w	d1,(a0)+	; update palette
		rts
; ===========================================================================

@addgreen:
		move.w	d3,d1
		addi.w	#$20,d1		; increase green value
		cmp.w	d2,d1
		bhi.s	@addred
		move.w	d1,(a0)+	; update palette
		rts
; ===========================================================================

@addred:
		addq.w	#2,(a0)+	; increase red value
		rts
; ===========================================================================

@next:
		addq.w	#2,a0		; next colour
		rts
; End of function FadeIn_AddColour


; ---------------------------------------------------------------------------
; Subroutine to fade out to black
; ---------------------------------------------------------------------------


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PaletteFadeOut:
		move.w	#$003F,(v_pfade_start).w ; start position = 0; size = $40
		move.w	#$15,d4

	@mainloop:
		move.w	d4,-(sp)
		move.b	#$12,(v_vbla_routine).w
		jsr	ProcKos
		bsr.w	WaitForVBla
		bsr.s	FadeOut_ToBlack
		jsr	ProcKosM
		move.w	(sp)+,d4
		dbf	d4,@mainloop
		rts


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


FadeOut_ToBlack:
		moveq	#0,d0
		lea	(v_pal_dry).w,a0
		move.b	(v_pfade_start).w,d0
		adda.w	d0,a0
		move.b	(v_pfade_size).w,d0

	@decolour:
		bsr.s	FadeOut_DecColour ; decrease colour
		dbf	d0,@decolour	; repeat for size of palette

		moveq	#0,d0
		lea	(v_pal_water).w,a0
		move.b	(v_pfade_start).w,d0
		adda.w	d0,a0
		move.b	(v_pfade_size).w,d0

	@decolour2:
		bsr.s	FadeOut_DecColour
		dbf	d0,@decolour2
		rts
; End of function FadeOut_ToBlack


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


FadeOut_DecColour:
@dered:
		move.w	(a0),d2
		beq.s	@next
		move.w	d2,d1
		andi.w	#$E,d1
		beq.s	@degreen
		subq.w	#2,(a0)+	; decrease red value
		rts
; ===========================================================================

@degreen:
		move.w	d2,d1
		andi.w	#$E0,d1
		beq.s	@deblue
		subi.w	#$20,(a0)+	; decrease green value
		rts
; ===========================================================================

@deblue:
		move.w	d2,d1
		andi.w	#$E00,d1
		beq.s	@next
		subi.w	#$200,(a0)+	; decrease blue	value
		rts
; ===========================================================================

@next:
		addq.w	#2,a0
		rts
; End of function FadeOut_DecColour

; ---------------------------------------------------------------------------
; Subroutine to	fade in from white (Special Stage)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PaletteWhiteIn:
		move.w	#$003F,(v_pfade_start).w ; start position = 0; size = $40
		moveq	#0,d0
		lea	(v_pal_dry).w,a0
		move.b	(v_pfade_start).w,d0
		adda.w	d0,a0
		move.w	#cWhite,d1
		move.b	(v_pfade_size).w,d0

	@fill:
		move.w	d1,(a0)+
		dbf	d0,@fill 	; fill palette with white

		move.w	#$15,d4

	@mainloop:
		move.w	d4,-(sp)
		move.b	#$12,(v_vbla_routine).w
		jsr	ProcKos
		bsr.w	WaitForVBla
		bsr.s	WhiteIn_FromWhite
		jsr	ProcKosM
		move.w	(sp)+,d4
		dbf	d4,@mainloop
		rts
; End of function PaletteWhiteIn


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


WhiteIn_FromWhite:
		moveq	#0,d0
		lea	(v_pal_dry).w,a0
		lea	(v_pal_dry_dup).w,a1
		move.b	(v_pfade_start).w,d0
		adda.w	d0,a0
		adda.w	d0,a1
		move.b	(v_pfade_size).w,d0

	@decolour:
		bsr.s	WhiteIn_DecColour ; decrease colour
		dbf	d0,@decolour	; repeat for size of palette

		cmpi.b	#id_LZ,(v_zone).w	; is level Labyrinth?
		bne.s	@exit		; if not, branch
		moveq	#0,d0
		lea	(v_pal_water).w,a0
		lea	(v_pal_water_dup).w,a1
		move.b	(v_pfade_start).w,d0
		adda.w	d0,a0
		adda.w	d0,a1
		move.b	(v_pfade_size).w,d0

	@decolour2:
		bsr.s	WhiteIn_DecColour
		dbf	d0,@decolour2

	@exit:
		rts
; End of function WhiteIn_FromWhite


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


WhiteIn_DecColour:
@deblue:
		move.w	(a1)+,d2
		move.w	(a0),d3
		cmp.w	d2,d3
		beq.s	@next
		move.w	d3,d1
		subi.w	#$200,d1	; decrease blue	value
		blo.s	@degreen
		cmp.w	d2,d1
		blo.s	@degreen
		move.w	d1,(a0)+
		rts
; ===========================================================================

@degreen:
		move.w	d3,d1
		subi.w	#$20,d1		; decrease green value
		blo.s	@dered
		cmp.w	d2,d1
		blo.s	@dered
		move.w	d1,(a0)+
		rts
; ===========================================================================

@dered:
		subq.w	#2,(a0)+	; decrease red value
		rts
; ===========================================================================

@next:
		addq.w	#2,a0
		rts
; End of function WhiteIn_DecColour

; ---------------------------------------------------------------------------
; Subroutine to fade to white (Special Stage)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PaletteWhiteOut:
		move.w	#$003F,(v_pfade_start).w ; start position = 0; size = $40
		move.w	#$15,d4

	@mainloop:
		move.w	d4,-(sp)
		move.b	#$12,(v_vbla_routine).w
		jsr	ProcKos
		bsr.w	WaitForVBla
		bsr.s	WhiteOut_ToWhite
		jsr	ProcKosM
		move.w	(sp)+,d4
		dbf	d4,@mainloop
		rts
; End of function PaletteWhiteOut


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


WhiteOut_ToWhite:
		moveq	#0,d0
		lea	(v_pal_dry).w,a0
		move.b	(v_pfade_start).w,d0
		adda.w	d0,a0
		move.b	(v_pfade_size).w,d0

	@addcolour:
		bsr.s	WhiteOut_AddColour
		dbf	d0,@addcolour

		moveq	#0,d0
		lea	(v_pal_water).w,a0
		move.b	(v_pfade_start).w,d0
		adda.w	d0,a0
		move.b	(v_pfade_size).w,d0

	@addcolour2:
		bsr.s	WhiteOut_AddColour
		dbf	d0,@addcolour2
		rts
; End of function WhiteOut_ToWhite


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


WhiteOut_AddColour:
@addred:
		move.w	(a0),d2
		cmpi.w	#cWhite,d2
		beq.s	@next
		move.w	d2,d1
		andi.w	#$E,d1
		cmpi.w	#cRed,d1
		beq.s	@addgreen
		addq.w	#2,(a0)+	; increase red value
		rts
; ===========================================================================

@addgreen:
		move.w	d2,d1
		andi.w	#$E0,d1
		cmpi.w	#cGreen,d1
		beq.s	@addblue
		addi.w	#$20,(a0)+	; increase green value
		rts
; ===========================================================================

@addblue:
		move.w	d2,d1
		andi.w	#$E00,d1
		cmpi.w	#cBlue,d1
		beq.s	@next
		addi.w	#$200,(a0)+	; increase blue	value
		rts
; ===========================================================================

@next:
		addq.w	#2,a0
		rts
; End of function WhiteOut_AddColour

; ---------------------------------------------------------------------------
; Palette cycling routine - Sega logo
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PalCycle_Sega:
		tst.b	(v_pcyc_time+1).w
		bne.s	loc_206A
		lea	(v_pal_dry+$20).w,a1
		lea	(Pal_Sega1).l,a0
		moveq	#5,d1
		move.w	(v_pcyc_num).w,d0

loc_2020:
		bpl.s	loc_202A
		addq.w	#2,a0
		subq.w	#1,d1
		addq.w	#2,d0
		bra.s	loc_2020
; ===========================================================================

loc_202A:
		move.w	d0,d2
		andi.w	#$1E,d2
		bne.s	loc_2034
		addq.w	#2,d0

loc_2034:
		cmpi.w	#$60,d0
		bhs.s	loc_203E
		move.w	(a0)+,(a1,d0.w)

loc_203E:
		addq.w	#2,d0
		dbf	d1,loc_202A

		move.w	(v_pcyc_num).w,d0
		addq.w	#2,d0
		move.w	d0,d2
		andi.w	#$1E,d2
		bne.s	loc_2054
		addq.w	#2,d0

loc_2054:
		cmpi.w	#$64,d0
		blt.s	loc_2062
		move.w	#$401,(v_pcyc_time).w
		moveq	#-$C,d0

loc_2062:
		move.w	d0,(v_pcyc_num).w
		moveq	#1,d0
		rts
; ===========================================================================

loc_206A:
		subq.b	#1,(v_pcyc_time).w
		bpl.s	loc_20BC
		move.b	#4,(v_pcyc_time).w
		move.w	(v_pcyc_num).w,d0
		addi.w	#$C,d0
		cmpi.w	#$30,d0
		blo.s	loc_2088
		moveq	#0,d0
		rts
; ===========================================================================

loc_2088:
		move.w	d0,(v_pcyc_num).w
		lea	(Pal_Sega2).l,a0
		lea	(a0,d0.w),a0
		lea	(v_pal_dry+$04).w,a1
		move.l	(a0)+,(a1)+
		move.l	(a0)+,(a1)+
		move.w	(a0)+,(a1)
		lea	(v_pal_dry+$20).w,a1
		moveq	#0,d0
		moveq	#$2C,d1

loc_20A8:
		move.w	d0,d2
		andi.w	#$1E,d2
		bne.s	loc_20B2
		addq.w	#2,d0

loc_20B2:
		move.w	(a0),(a1,d0.w)
		addq.w	#2,d0
		dbf	d1,loc_20A8

loc_20BC:
		moveq	#1,d0
		rts
; End of function PalCycle_Sega

; ===========================================================================

Pal_Sega1:	incbin	"palette\Sega1.bin"
Pal_Sega2:	incbin	"palette\Sega2.bin"

; ---------------------------------------------------------------------------
; Subroutines to load palettes

; input:
;	d0 = index number for palette
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PalLoad1:
		lea	(PalPointers).l,a1
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2	; get palette data address
		movea.w	(a1)+,a3	; get target RAM address
		adda.w	#v_pal_dry_dup-v_pal_dry,a3		; skip to "main" RAM address
		move.w	(a1)+,d7	; get length of palette data

	@loop:
		move.l	(a2)+,(a3)+	; move data to RAM
		dbf	d7,@loop
		rts
; End of function PalLoad1


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PalLoad2:
		lea	(PalPointers).l,a1
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2	; get palette data address
		movea.w	(a1)+,a3	; get target RAM address
		move.w	(a1)+,d7	; get length of palette

	@loop:
		move.l	(a2)+,(a3)+	; move data to RAM
		dbf	d7,@loop
		rts
; End of function PalLoad2

; ---------------------------------------------------------------------------
; Underwater palette loading subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PalLoad3_Water:
		lea	(PalPointers).l,a1
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2	; get palette data address
		movea.w	(a1)+,a3	; get target RAM address
		suba.w	#v_pal_dry-v_pal_water,a3		; skip to "main" RAM address
		move.w	(a1)+,d7	; get length of palette data

	@loop:
		move.l	(a2)+,(a3)+	; move data to RAM
		dbf	d7,@loop
		rts
; End of function PalLoad3_Water


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PalLoad4_Water:
		lea	(PalPointers).l,a1
		lsl.w	#3,d0
		adda.w	d0,a1
		movea.l	(a1)+,a2	; get palette data address
		movea.w	(a1)+,a3	; get target RAM address
		suba.w	#v_pal_dry-v_pal_water_dup,a3
		move.w	(a1)+,d7	; get length of palette data

	@loop:
		move.l	(a2)+,(a3)+	; move data to RAM
		dbf	d7,@loop
		rts
; End of function PalLoad4_Water

; ===========================================================================

		include	"_inc\Palette Pointers.asm"

; ---------------------------------------------------------------------------
; Palette data
; ---------------------------------------------------------------------------
Pal_SegaBG:	incbin	"palette\Sega Background.bin"
Pal_Title:	incbin	"palette\Title Screen.bin"
Pal_Sonic:	incbin	"palette\Sonic.bin"
Pal_GHZ:	incbin	"palette\Green Hill Zone.bin"

; ---------------------------------------------------------------------------
; Subroutine to	wait for VBlank routines to complete
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


WaitForVBla:
		enable_ints
		move.w	#$9100,$C00004		; disable window

	@wait:
		tst.b	(v_vbla_routine).w ; has VBlank routine finished?
		bne.s	@wait		; if not, branch

ObjTail:
		rts
; End of function WaitForVBla

		include	"_incObj\sub RandomNumber.asm"
		include	"_incObj\sub CalcSine.asm"
		include	"_incObj\sub CalcAngle.asm"

; ---------------------------------------------------------------------------
; Sega screen
; ---------------------------------------------------------------------------

GM_Sega:
		clr.b	v_extrarender.w
		move.w	(v_vdp_buffer1).w,d0
		ori.b	#$40,d0
		move.w	d0,(vdp_control_port).l
		move.b	#id_Title,(v_gamemode).w ; go to title screen
		bra.s	GM_Title
; ===========================================================================

PLC_Title:
	dc.w 3
	dc.l Nem_GHZ_1st
	dc.w 0
	dc.l Nem_TitleFg
	dc.w $4000
	dc.l Nem_TitleTM
	dc.w $A200
	dc.l Nem_TitleSonic
	dc.w $6000

GM_Title:
		sfx	Mus_Stop,0,1,1 ; stop music
		bsr.w	ClearPLC
		bsr.w	PaletteFadeOut
		clr.b	v_extrarender.w
		disable_ints
		lea	(vdp_control_port).l,a6
		move.w	#$8004,(a6)	; 8-colour mode
		move.w	#$8200+(vram_fg>>10),(a6) ; set foreground nametable address
		move.w	#$8400+(vram_bg>>13),(a6) ; set background nametable address
		move.w	#$9001,(a6)	; 64-cell hscroll size
		move.w	#$9200,(a6)	; window vertical position
		move.w	#$8B03,(a6)
		move.w	#$8720,(a6)	; set background colour (palette line 2, entry 0)
		move.w  #DMAqueue,DMAquePtr.w
		clr.w	DMAqueue.w
		clr.b	(f_wtr_state).w
		bsr.w	ClearScreen

		jsr	ResetObjList(pc)		; reset all object states
		move.l	#ObjTail,Obj_Tail.w
		move.w	#v_player,ObjPrev_Tail.w
		move.l	#ObjNull,v_objspace.w
		move.w	#Obj_Tail,v_objspace+next.w

		lea	(v_pal_dry_dup).w,a1
		moveq	#cBlack,d0
		move.w	#$1F,d1

	Tit_ClrPal:
		move.l	d0,(a1)+
		dbf	d1,Tit_ClrPal	; fill palette with 0 (black)

		moveq	#palid_Sonic,d0	; load Sonic's palette
		bsr.w	PalLoad1
		disable_ints
		lea	(vdp_data_port).l,a6
		locVRAM	$D000,4(a6)
		lea	(Art_Text).l,a5	; load level select font
		move.w	#$28F,d1

	Tit_LoadText:
		move.w	(a5)+,(a6)
		dbf	d1,Tit_LoadText	; load level select font
		jsr	ResetSpriteList(pc)

		move.b	#0,(v_lastlamp).w ; clear lamppost counter
		move.w	#0,(v_debuguse).w ; disable debug item placement mode
		move.w	#0,(f_demo).w	; disable debug mode
		move.w	#0,($FFFFFFEA).w ; unused variable
		move.w	#(id_GHZ<<8),(v_zone).w	; set level to GHZ (00)
		move.w	#0,(v_pcyc_time).w ; disable palette cycling
		jsr	LoadSRAM

		lea	PLC_Title(pc),a5
		jsr	QueueRawPLC
		bsr.w	LevelSizeLoad
		bsr.w	DeformLayers

		lea	(Blk256_GHZ).l,a0 ; load GHZ 256x256 mappings
		lea	(v_256x256).l,a1
		bsr.w	KosDec
		bsr.w	LevelLayoutLoad
		disable_ints

		lea	(vdp_control_port).l,a5
		lea	(vdp_data_port).l,a6
		lea	(v_bgscreenposx).w,a3
		lea	(v_lvllayout+$40).w,a4
		move.w	#$6000,d2
		bsr.w	DrawChunks

		lea	($FF0000).l,a1
		lea	(Eni_Title).l,a0 ; load	title screen mappings
		move.w	#0,d0
		bsr.w	EniDec

		copyTilemap	$FF0000,$C206,$21,$15

		moveq	#palid_Title,d0	; load title screen palette
		bsr.w	PalLoad1
		sfx	Mus_Egor,0,1,1	; play title screen music
		clr.w	(f_debugmode).w ; disable debug mode
		move.w	#(16*60)-6,(v_demolength).w ; run title screen for $178 frames

		jsr	FindFreeObj(pc)
		move.l	#TitleSonic,(a1) ; load big Sonic object
		jsr	FindFreeObj(pc)
		move.l	#PSBTM,(a1)
		move.w	#$03B0,v_player+obY.w
		move.w	#$0300,v_screenposy.w

			tst.b   (v_megadrive).w	; is console Japanese?
			bpl.s   @isjap		; if yes, branch

		jsr	FindFreeObj(pc)
		move.l	#PSBTM,(a1)
		move.b	#3,obFrame(a1)
	@isjap:
		jsr	FindFreeObj(pc)
		move.l	#PSBTM,(a1)
		move.b	#2,obFrame(a1)

@fail		jsr	(ExecuteObjects).l
		bsr.w	DeformLayers
		jsr	(BuildSprites).l
		moveq	#plcid_Main,d0
		bsr.w	AddPLC
		move.w	#0,(v_title_dcount).w
		move.w	#0,(v_title_ccount).w
		jsr	ProcKosM
	rept 16
		move.b	#4,(v_vbla_routine).w
		jsr	ProcKos
		bsr.w	WaitForVBla
		jsr	ProcKosM
	endr

		move.w	(v_vdp_buffer1).w,d0
		ori.b	#$40,d0
		move.w	d0,(vdp_control_port).l
		bsr.w	PaletteFadeIn

Tit_MainLoop:
		move.b	#4,(v_vbla_routine).w
		jsr	ProcKos
		bsr.w	WaitForVBla
		jsr	(ExecuteObjects).l
		bsr.w	DeformLayers
		jsr	(BuildSprites).l
		bsr.w	PCycle_Title
		jsr	ProcKosM

		move.w	(v_objspace+obX).w,d0
		addq.w	#2,d0
		move.w	d0,(v_objspace+obX).w ; move Sonic to the right
		cmpi.w	#$1C00,d0	; has Sonic object passed $1C00 on x-axis?
		blo.s	Tit_ChkRegion	; if not, branch

		move.b	#id_Sega,(v_gamemode).w ; go to Sega screen
		rts
; ===========================================================================
PlayLevel:
		move.b	#id_Level,(v_gamemode).w ; set screen mode to $0C (level)
		moveq	#0,d0
		move.w	d0,(v_rings).w	; clear rings
		move.l	d0,(v_time).w	; clear time
		move.l	d0,(v_score).w	; clear score
		move.b	d0,(v_lastspecial).w ; clear special stage number
		move.b	d0,(v_emeralds).w ; clear emeralds
		move.l	d0,(v_emldlist).w ; clear emeralds
		move.l	d0,(v_emldlist+4).w ; clear emeralds
		move.b	d0,(v_continues).w ; clear continues
			move.l	#5000,(v_scorelife).w ; extra life is awarded at 50000 points
		clr.b	ckpt.w		; clear flag
		move.b	#Mus_FadeOut,mQueue+2.w	; fade out music
		rts

Tit_ChkRegion:
		lea	(LevSelCode_US).l,a0 ; load US code

Tit_EnterCheat:
		move.w	(v_title_dcount).w,d0
		adda.w	d0,a0
		move.b	(v_jpadpress1).w,d0 ; get button press
		andi.b	#btnDir,d0	; read only UDLR buttons
		cmp.b	(a0),d0		; does button press match the cheat code?
		bne.s	Tit_ResetCheat	; if not, branch
		addq.w	#1,(v_title_dcount).w ; next button press
		tst.b	d0
		bne.s	Tit_CountC
		move.b	#1,(f_levselcheat).w; activate cheat
		sfx	sfx_RingRight,0,1,1	; play ring sound when code is entered
		jsr	Credits
		bra.s	Tit_CountC
; ===========================================================================

Tit_ResetCheat:
		tst.b	d0
		beq.s	Tit_CountC
		cmpi.w	#9,(v_title_dcount).w
		beq.s	Tit_CountC
		move.w	#0,(v_title_dcount).w ; reset UDLR counter

Tit_CountC:
		move.b	(v_jpadpress1).w,d0
		andi.b	#btnC,d0	; is C button pressed?
		beq.s	loc_3230	; if not, branch
		addq.w	#1,(v_title_ccount).w ; increment C counter

loc_3230:
		tst.w	(v_demolength).w
		beq.w	GotoDemo
		andi.b	#btnStart,(v_jpadpress1).w ; check if Start is pressed
		beq.w	Tit_MainLoop	; if not, branch

Tit_ChkLevSel:
		tst.b	(f_levselcheat).w ; check if level select code is on
		beq.w	PlayLevel	; if not, play level
		btst	#bitA,(v_jpadhold1).w ; check if A is pressed
		bra.w	PlayLevel	; if not, play level

		move.b	#3,v_act.w
		bra.w	Tit_MainLoop
; ===========================================================================

LevSelCode_US:	dc.b btnUp,btnDn,btnL,btnR,0,$FF

; ---------------------------------------------------------------------------
; Demo mode
; ---------------------------------------------------------------------------

GotoDemo:
		move.w	#$1E,(v_demolength).w

loc_33B6:
		move.b	#4,(v_vbla_routine).w
		jsr	ProcKos
		bsr.w	WaitForVBla
		bsr.w	DeformLayers
		bsr.w	PaletteCycle
		jsr	ProcKosM
		move.w	(v_objspace+obX).w,d0
		addq.w	#2,d0
		move.w	d0,(v_objspace+obX).w
		cmpi.w	#$1C00,d0
		blo.s	loc_33E4
		move.b	#id_Sega,(v_gamemode).w
		rts
; ===========================================================================

loc_33E4:
		andi.b	#btnStart,(v_jpadpress1).w ; is Start button pressed?
		bne.w	Tit_ChkLevSel	; if yes, branch
		tst.w	(v_demolength).w
		bne.w	loc_33B6
		move.b	#Mus_FadeOut,mQueue+2.w	; fade out music
		move.w	Demo_Levels(pc),(v_zone).w

loc_3422:
		move.w	#1,(f_demo).w	; turn demo mode on
		move.b	#id_Demo,(v_gamemode).w ; set screen mode to 08 (demo)
		cmpi.w	#$600,d0	; is level number 0600 (special	stage)?
		bne.s	Demo_Level	; if not, branch
		move.b	#id_Special,(v_gamemode).w ; set screen mode to $10 (Special Stage)
		clr.w	(v_zone).w	; clear	level number
		clr.b	(v_lastspecial).w ; clear special stage number

Demo_Level:
		moveq	#0,d0
		move.w	d0,(v_rings).w	; clear rings
		move.l	d0,(v_time).w	; clear time
		move.l	d0,(v_score).w	; clear score
			move.l	#5000,(v_scorelife).w ; extra life is awarded at 50000 points
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Levels used in demos
; ---------------------------------------------------------------------------
Demo_Levels:	incbin	"misc\Demo Level Order - Intro.bin"
		even
; ===========================================================================

ResetObjList:
		lea	(v_objspace).w,a1
		moveq	#0,d0
		move.w	#(v_objspaceend-v_objspace)/4-1,d1

Level_ClrObjRam:
		move.l	d0,(a1)+
		dbf	d1,Level_ClrObjRam ; clear object RAM

	; reset object table
		lea	v_lvlobjspace.w,a1		; get object table to a1
		move.w	a1,Free_Head.w			; set as the head
		move.w	#(v_objspaceend-v_objspace)/size-3,d1; run through all objs

@loop		add.w	#size,a1			; get the next obj
		move.w	a1,prev-size(a1)		; set next header
		dbf	d1,@loop			; loop for all entries

	; reset display table
		lea	v_spritequeue-4.w,a1		; get display table to a1
		moveq	#8-1,d1				; run through all entries

@loop2		move.w	a1,vs_dprev+4(a1)		; save prev ptr
		addq.w	#4,a1				; advance to correct address
		move.w	a1,vs_dnext(a1)			; save next ptr

		clr.l	vs_n2(a1)			; clear some stuff
		addq.w	#vs_size-4,a1			; get the next obj
		dbf	d1,@loop2			; loop for all entries
		rts
; ===========================================================================

PLC_TTLCARD:
	dc.w 0
	dc.l Nem_TitleCard
	dc.w $B000

; ---------------------------------------------------------------------------
; Level
; ---------------------------------------------------------------------------

GM_Level_:
		jsr	UpdateSRAM

GM_Level:
		move.b	#1,$A130F1		; enable sram
		jsr	ResetStrSRAM
		move.b	#0,$A130F1		; disable sram

		bset	#7,(v_gamemode).w ; add $80 to screen mode (for pre level sequence)
		tst.w	(f_demo).w
;		bmi.s	Level_NoMusicFade
		move.b	#Mus_FadeOut,mQueue+2.w	; fade out music

	Level_NoMusicFade:
		bsr.w	ClearPLC
		bsr.w	PaletteFadeOut
		tst.w	(f_demo).w	; is an ending sequence demo running?
		bmi.s	Level_ClrRam	; if yes, branch

		lea	PLC_TTLCARD(pc),a5
		jsr	QueueRawPLC
		moveq	#0,d0
		move.b	(v_zone).w,d0
		lsl.w	#4,d0
		lea	(LevelHeaders).l,a2
		lea	(a2,d0.w),a2
		moveq	#0,d0
		move.b	(a2),d0
		beq.s	loc_37FC
		bsr.w	AddPLC		; load level patterns

loc_37FC:

Level_ClrRam:
		clr.w	HudPos.w
		clr.b	v_extrarender.w

		lea	someshitaddr.w,a1
		moveq	#0,d0
		move.w	#($FFFFF680-someshitaddr)/4-1,d1

	Level_ClrVars1:
		move.l	d0,(a1)+
		dbf	d1,Level_ClrVars1 ; clear misc variables

		lea	(v_screenposx).w,a1
		moveq	#0,d0
		move.w	#($FFFFF800-v_screenposx)/4-1,d1

	Level_ClrVars2:
		move.l	d0,(a1)+
		dbf	d1,Level_ClrVars2 ; clear misc variables

		lea	(v_emldlist+6).w,a1
		moveq	#0,d0
		move.w	#(v_levseldelay-v_emldlist-6)/4-1,d1

	Level_ClrVars3:
		move.l	d0,(a1)+
		dbf	d1,Level_ClrVars3 ; clear object variables
		clr.b	omactr.w

	if lag=1
		clr.l	LAGF.w
	endif
		jsr	ResetObjList(pc)
		jsr	ResetSpriteList(pc)
		move.l	#ObjTail,Obj_Tail.w
		move.w	#v_player,ObjPrev_Tail.w
		move.l	#ObjNull,v_objspace.w
		move.w	#Obj_Tail,v_objspace+next.w

		disable_ints
		bsr.w	ClearScreen
		lea	(vdp_control_port).l,a6
		move.w	#$8B03,(a6)	; line scroll mode
		move.w	#$8200+(vram_fg>>10),(a6) ; set foreground nametable address
		move.w	#$8400+(vram_bg>>13),(a6) ; set background nametable address
		move.w	#$8500+(vram_sprites>>9),(a6) ; set sprite table address
		move.w	#$9001,(a6)		; 64-cell hscroll size
		move.w	#$8004,(a6)		; 8-colour mode
		move.w	#$8720,(a6)		; set background colour (line 3; colour 0)
		move.w	#$8A00+223,(v_hbla_hreg).w ; set palette change position (for water)
		move.w	(v_hbla_hreg).w,(a6)
		move.w  #DMAqueue,DMAquePtr.w
		clr.w	DMAqueue.w

Level_LoadPal:
		move.w	#30,(v_air).w
		enable_ints
		moveq	#palid_Sonic,d0
		bsr.w	PalLoad2	; load Sonic's palette

Level_GetBgm:
		tst.w	(f_demo).w
		bmi.s	Level_SkipTtlCard
	Level_PlayBgm:
		jsr	FindFreeObj(pc)
		move.l	#TitleCard,(a1)
		move.w	a1,-(sp)

Level_TtlCardLoop:
		move.b	#$C,(v_vbla_routine).w
		jsr	ProcKos
		bsr.w	WaitForVBla
		jsr	(ExecuteObjects).l
		jsr	(BuildSprites).l
		jsr	ProcKosM

		cmp.b	#$7F,mMasterVolFM.w		; check if fadeout completed
		bne.s	@nofaded			; if no, bra
		moveq	#0,d0
		move.b	v_act.w,d0
		lea	MusicList,a1	; load music playlist
		move.b	(a1,d0.w),mQueue+2.w
		move.b	#Mus_Reset,mQueue.w

@nofaded	move.w	(sp),a1
		move.w	obX(a1),d0
		cmp.w	$30(a1),d0	 ; has title card sequence finished?
		bne.s	Level_TtlCardLoop ; if not, branch
		tst.b	(KosMmodNum).w ; are there any items in the pattern load cue?
		bne.s	Level_TtlCardLoop ; if yes, branch
		addq.w	#2,sp

	Level_SkipTtlCard:
		jsr	(Hud_Base).l	; load basic HUD gfx
		moveq	#palid_Sonic,d0
		bsr.w	PalLoad1	; load Sonic's palette
		bsr.w	LevelSizeLoad
		bsr.w	DeformLayers
		bset	#2,(v_bgscroll1).w
		bsr.w	LevelDataLoad ; load block mappings and palettes
		bsr.w	LoadTilesFromStart
		jsr	(FloorLog_Unk).l
		bsr.w	ColIndexLoad
		bsr.w	LZWaterFeatures
		move.w	#CollisionList+2,CollisionList.w	; reset list pos
		move.l	#SonicPlayer,(v_player).w ; load Sonic object
		tst.w	(f_demo).w
		bmi.s	Level_ChkDebug
	;	jsr	FindFreeObj(pc)
	;	move.l	#HUD,(a1)
		st.b	v_extrarender.w

Level_ChkDebug:
		tst.b	(f_debugcheat).w ; has debug cheat been entered?
		beq.s	Level_ChkWater	; if not, branch
		btst	#bitA,(v_jpadhold1).w ; is A button held?
		beq.s	Level_ChkWater	; if not, branch
		move.b	#1,(f_debugmode).w ; enable debug mode

Level_ChkWater:
		move.w	#0,(v_jpadhold2).w
		move.w	#0,(v_jpadhold1).w

Level_LoadObj:
		jsr	(ObjPosLoad).l
		jsr	(ExecuteObjects).l
		jsr	(BuildSprites).l
		moveq	#0,d0
		tst.b	(v_lastlamp).w	; are you starting from	a lamppost?
		bne.s	Level_SkipClr	; if yes, branch
		move.w	d0,(v_rings).w	; clear rings
		move.l	d0,(v_time).w	; clear time
		move.b	d0,(v_lifecount).w ; clear lives counter

	Level_SkipClr:
		move.b	d0,(f_timeover).w
		move.b	d0,(v_shield).w	; clear shield
		move.b	d0,(v_invinc).w	; clear invincibility
		move.b	d0,(v_shoes).w	; clear speed shoes
		move.b	d0,($FFFFFE2F).w
		move.w	d0,(v_debuguse).w
		move.w	d0,(f_restart).w
		move.w	d0,(v_framecount).w
		move.b	d0,RedCoinBits.w
		move.b	d0,HiddenBits.w

		bsr.w	OscillateNumInit
		move.b	#1,(f_scorecount).w ; update score counter
		move.b	#1,(f_ringcount).w ; update rings counter
		move.b	#1,(f_timecount).w ; update time counter
		move.w	#0,(v_btnpushtime1).w
		lea	(DemoDataPtr).l,a1 ; load demo data
		moveq	#0,d0
		move.b	(v_zone).w,d0
		lsl.w	#2,d0
		movea.l	(a1,d0.w),a1
		tst.w	(f_demo).w	; is demo mode on?
		bpl.s	Level_Demo	; if yes, branch
		lea	(DemoEndDataPtr).l,a1 ; load ending demo data
		move.w	(v_creditsnum).w,d0
		subq.w	#1,d0
		lsl.w	#2,d0
		movea.l	(a1,d0.w),a1

Level_Demo:
		move.b	1(a1),(v_btnpushtime2).w ; load key press duration
		subq.b	#1,(v_btnpushtime2).w ; subtract 1 from duration
		move.w	#1800,(v_demolength).w
		tst.w	(f_demo).w
		bpl.s	Level_ChkWaterPal
		move.w	#540,(v_demolength).w

Level_ChkWaterPal:
Level_Delay:
		move.w	#$202F,(v_pfade_start).w ; fade in 2nd, 3rd & 4th palette lines
		bsr.w	PalFadeIn_Alt
		tst.w	(f_demo).w	; is an ending sequence demo running?
		bmi.s	Level_ClrCardArt ; if yes, branch
		bclr	#7,(v_gamemode).w ; subtract $80 from mode to end pre-level stuff
		bra.s	Level_StartGame
; ===========================================================================

Level_ClrCardArt:
		moveq	#plcid_Explode,d0
		jsr	AddPLC	; load explosion gfx
		moveq	#0,d0
		move.b	(v_zone).w,d0
		addi.w	#plcid_GHZAnimals,d0
		jsr	AddPLC	; load animal gfx (level no. + $15)

Level_StartGame:
		bclr	#7,(v_gamemode).w ; subtract $80 from mode to end pre-level stuff

; ---------------------------------------------------------------------------
; Main level loop (when	all title card and loading sequences are finished)
; ---------------------------------------------------------------------------

Level_MainLoop:
		bsr.w	PauseGame
		move.b	#8,(v_vbla_routine).w
		jsr	ProcKos
		bsr.w	WaitForVBla
		addq.w	#1,(v_framecount).w ; add 1 to level timer
		bsr.w	MoveSonicInDemo
		bsr.w	LZWaterFeatures
		jsr	(ExecuteObjects).l
		if Revision=0
		else
			tst.w   (f_restart).w
			bne     GM_Level_
		endc
		tst.w	(v_debuguse).w	; is debug mode being used?
		bne.s	Level_DoScroll	; if yes, branch
		cmpi.b	#6,(v_player+obRoutine).w ; has Sonic just died?
		bhs.s	Level_SkipScroll ; if yes, branch

	Level_DoScroll:
		bsr.w	DeformLayers

	Level_SkipScroll:
		jsr	(BuildSprites).l
		jsr	(ObjPosLoad).l
		bsr.w	PaletteCycle
		jsr	ProcKosM
		bsr.w	OscillateNumDo
		bsr.w	SynchroAnimate
		bsr.w	SignpostArtLoad

		cmpi.b	#id_Demo,(v_gamemode).w
		beq.s	Level_ChkDemo	; if mode is 8 (demo), branch
		if Revision=0
		tst.w	(f_restart).w	; is the level set to restart?
		bne.w	GM_Level_	; if yes, branch
		else
		endc
		cmpi.b	#id_Level,(v_gamemode).w
		beq.w	Level_MainLoop	; if mode is $C (level), branch
		rts
; ===========================================================================

Level_ChkDemo:
		tst.w	(f_restart).w	; is level set to restart?
		bne.s	Level_EndDemo	; if yes, branch
		tst.w	(v_demolength).w ; is there time left on the demo?
		beq.s	Level_EndDemo	; if not, branch
		cmpi.b	#id_Demo,(v_gamemode).w
		beq.w	Level_MainLoop	; if mode is 8 (demo), branch
		move.b	#id_Sega,(v_gamemode).w ; go to Sega screen
		rts
; ===========================================================================

Level_EndDemo:
		cmpi.b	#id_Demo,(v_gamemode).w
		bne.s	Level_FadeDemo	; if mode is 8 (demo), branch
		move.b	#id_Sega,(v_gamemode).w ; go to Sega screen
		tst.w	(f_demo).w	; is demo mode on & not ending sequence?
		bpl.s	Level_FadeDemo	; if yes, branch
		move.b	#id_Credits,(v_gamemode).w ; go to credits

Level_FadeDemo:
		move.w	#$3C,(v_demolength).w
		move.w	#$3F,(v_pfade_start).w
		clr.w	(v_palchgspeed).w

	Level_FDLoop:
		move.b	#8,(v_vbla_routine).w
		bsr.w	WaitForVBla
		bsr.w	MoveSonicInDemo
		jsr	(ExecuteObjects).l
		jsr	(BuildSprites).l
		jsr	(ObjPosLoad).l
		subq.w	#1,(v_palchgspeed).w
		bpl.s	loc_3BC8
		move.w	#2,(v_palchgspeed).w
		bsr.w	FadeOut_ToBlack

loc_3BC8:
		tst.w	(v_demolength).w
		bne.s	Level_FDLoop
		rts
; ===========================================================================

		include	"_inc\LZWaterFeatures.asm"
		include	"_inc\MoveSonicInDemo.asm"

; ---------------------------------------------------------------------------
; Collision index pointer loading subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ColIndexLoad:
		moveq	#0,d0
		move.b	(v_zone).w,d0
		lsl.w	#2,d0
		move.l	ColPointers(pc,d0.w),(v_collindex).w
		rts
; End of function ColIndexLoad

; ===========================================================================
; ---------------------------------------------------------------------------
; Collision index pointers
; ---------------------------------------------------------------------------
ColPointers:	dc.l Col_GHZ
		dc.l Col_LZ
		dc.l Col_MZ
		dc.l Col_SLZ
		dc.l Col_SYZ
		dc.l Col_SBZ
;		dc.l Col_GHZ ; Pointer for Ending is missing by default.
		zonewarningnoending ColPointers,4

		include	"_inc\Oscillatory Routines.asm"

; ---------------------------------------------------------------------------
; Subroutine to	change synchronised animation variables (rings, giant rings)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


SynchroAnimate:

; Used for GHZ spiked log
Sync1:
		subq.b	#1,(v_ani0_time).w ; has timer reached 0?
		bpl.s	Sync2		; if not, branch
		move.b	#$B,(v_ani0_time).w ; reset timer
		subq.b	#1,(v_ani0_frame).w ; next frame
		andi.b	#7,(v_ani0_frame).w ; max frame is 7

; Used for rings and giant rings
Sync2:
		subq.b	#1,(v_ani1_time).w
		bpl.s	Sync3
		move.b	#7,(v_ani1_time).w
		addq.b	#1,(v_ani1_frame).w
		andi.b	#3,(v_ani1_frame).w

; Used for nothing
Sync3:
		subq.b	#1,(v_ani2_time).w
		bpl.s	Sync4
		move.b	#7,(v_ani2_time).w
		addq.b	#1,(v_ani2_frame).w
		cmpi.b	#6,(v_ani2_frame).w
		blo.s	Sync4
		move.b	#0,(v_ani2_frame).w

; Used for bouncing rings
Sync4:
		tst.b	(v_ani3_time).w
		beq.s	SyncEnd
		moveq	#0,d0
		move.b	(v_ani3_time).w,d0
		add.w	(v_ani3_buf).w,d0
		move.w	d0,(v_ani3_buf).w
		rol.w	#7,d0
		andi.w	#3,d0
		move.b	d0,(v_ani3_frame).w
		subq.b	#1,(v_ani3_time).w

SyncEnd:
		rts
; End of function SynchroAnimate

; ---------------------------------------------------------------------------
; End-of-act signpost pattern loading subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


SignpostArtLoad:
		tst.w	(v_debuguse).w	; is debug mode	being used?
		bne.w	@exit		; if yes, branch
		cmpi.b	#2,(v_act).w	; is act number 02 (act 3)?
		bhs.s	@exit		; if yes, branch

		move.w	(v_screenposx).w,d0
		move.w	(v_limitright2).w,d1
		subi.w	#$100,d1
		cmp.w	d1,d0		; has Sonic reached the	edge of	the level?
		blt.s	@exit		; if not, branch
		tst.b	(f_timecount).w
		beq.s	@exit
		cmp.w	(v_limitleft2).w,d1
		beq.s	@exit
		move.w	d1,(v_limitleft2).w ; move left boundary to current screen position
		moveq	#plcid_Signpost,d0
		bra.w	NewPLC		; load signpost	patterns

	@exit:
		rts
; End of function SignpostArtLoad

; ===========================================================================
Demo_GHZ:	incbin	"demodata\Intro - GHZ.bin"
; ===========================================================================

GM_Special:
GM_Continue:
GM_Ending:
GM_Credits:
TryAgainEnd:
SonicSpecial:
contscritem:
contsonic:
endsonic:
endchaos:
endsth:
endeggman:
trychaos:
NullObject:
		illegal

		if Revision=0
		include	"_inc\LevelSizeLoad & BgScrollSpeed.asm"
		include	"_inc\DeformLayers.asm"
		else
		include	"_inc\LevelSizeLoad & BgScrollSpeed (JP1).asm"
		include	"_inc\DeformLayers (JP1).asm"
		endc


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_6886:
		lea	(vdp_control_port).l,a5
		lea	(vdp_data_port).l,a6
		lea	(v_bgscroll2).w,a2
		lea	(v_bgscreenposx).w,a3
		lea	(v_lvllayout+$40).w,a4
		move.w	#$6000,d2
		bsr.w	sub_6954
		lea	(v_bgscroll3).w,a2
		lea	(v_bg2screenposx).w,a3
		bra.w	sub_69F4
; End of function sub_6886

; ---------------------------------------------------------------------------
; Subroutine to	display	correct	tiles as you move
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LoadTilesAsYouMove:
		lea	(vdp_control_port).l,a5
		lea	(vdp_data_port).l,a6
		lea	($FFFFFF32).w,a2
		lea	($FFFFFF18).w,a3
		lea	(v_lvllayout+$40).w,a4
		move.w	#$6000,d2
		bsr.w	sub_6954
		lea	($FFFFFF34).w,a2
		lea	($FFFFFF20).w,a3
		bsr.w	sub_69F4
		if Revision=0
		else
		lea	($FFFFFF36).w,a2
		lea	($FFFFFF28).w,a3
		bsr.w	locj_6EA4
		endc
		lea	($FFFFFF30).w,a2
		lea	($FFFFFF10).w,a3
		lea	(v_lvllayout).w,a4
		move.w	#$4000,d2
		tst.b	(a2)
		beq.s	locret_6952
		bclr	#0,(a2)
		beq.s	loc_6908
		moveq	#-$10,d4
		moveq	#-$10,d5
		bsr.w	Calc_VRAM_Pos
		moveq	#-$10,d4
		moveq	#-$10,d5
		bsr.w	DrawTiles_LR

loc_6908:
		bclr	#1,(a2)
		beq.s	loc_6922
		move.w	#$E0,d4
		moveq	#-$10,d5
		bsr.w	Calc_VRAM_Pos
		move.w	#$E0,d4
		moveq	#-$10,d5
		bsr.w	DrawTiles_LR

loc_6922:
		bclr	#2,(a2)
		beq.s	loc_6938
		moveq	#-$10,d4
		moveq	#-$10,d5
		bsr.w	Calc_VRAM_Pos
		moveq	#-$10,d4
		moveq	#-$10,d5
		bsr.w	DrawTiles_TB

loc_6938:
		bclr	#3,(a2)
		beq.s	locret_6952
		moveq	#-$10,d4
		move.w	#$140,d5
		bsr.w	Calc_VRAM_Pos
		moveq	#-$10,d4
		move.w	#$140,d5
		bsr.w	DrawTiles_TB

locret_6952:
		rts
; End of function LoadTilesAsYouMove


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_6954:
		tst.b	(a2)
		beq.w	locret_69F2
		bclr	#0,(a2)
		beq.s	loc_6972
		moveq	#-$10,d4
		moveq	#-$10,d5
		bsr.w	Calc_VRAM_Pos
		moveq	#-$10,d4
		moveq	#-$10,d5
		if Revision=0
		moveq	#$1F,d6
		bsr.w	DrawTiles_LR_2
		else
			bsr.w	DrawTiles_LR
		endc

loc_6972:
		bclr	#1,(a2)
		beq.s	loc_698E
		move.w	#$E0,d4
		moveq	#-$10,d5
		bsr.w	Calc_VRAM_Pos
		move.w	#$E0,d4
		moveq	#-$10,d5
		if Revision=0
		moveq	#$1F,d6
		bsr.w	DrawTiles_LR_2
		else
			bsr.w	DrawTiles_LR
		endc

loc_698E:
		bclr	#2,(a2)

		if Revision=0
		beq.s	loc_69BE
		moveq	#-$10,d4
		moveq	#-$10,d5
		bsr.w	Calc_VRAM_Pos
		moveq	#-$10,d4
		moveq	#-$10,d5
		move.w	($FFFFF7F0).w,d6
		move.w	4(a3),d1
		andi.w	#-$10,d1
		sub.w	d1,d6
		blt.s	loc_69BE
		lsr.w	#4,d6
		cmpi.w	#$F,d6
		blo.s	loc_69BA
		moveq	#$F,d6

loc_69BA:
		bsr.w	DrawTiles_TB_2

loc_69BE:
		bclr	#3,(a2)
		beq.s	locret_69F2
		moveq	#-$10,d4
		move.w	#$140,d5
		bsr.w	Calc_VRAM_Pos
		moveq	#-$10,d4
		move.w	#$140,d5
		move.w	($FFFFF7F0).w,d6
		move.w	4(a3),d1
		andi.w	#-$10,d1
		sub.w	d1,d6
		blt.s	locret_69F2
		lsr.w	#4,d6
		cmpi.w	#$F,d6
		blo.s	loc_69EE
		moveq	#$F,d6

loc_69EE:
		bsr.w	DrawTiles_TB_2

		else

			beq.s	locj_6D56
			moveq	#-$10,d4
			moveq	#-$10,d5
			bsr.w	Calc_VRAM_Pos
			moveq	#-$10,d4
			moveq	#-$10,d5
			bsr.w	DrawTiles_TB
	locj_6D56:

			bclr	#3,(a2)
			beq.s	locj_6D70
			moveq	#-$10,d4
			move.w	#$140,d5
			bsr.w	Calc_VRAM_Pos
			moveq	#-$10,d4
			move.w	#$140,d5
			bsr.w	DrawTiles_TB
	locj_6D70:

			bclr	#4,(a2)
			beq.s	locj_6D88
			moveq	#-$10,d4
			moveq	#$00,d5
			bsr.w	Calc_VRAM_Pos_2
			moveq	#-$10,d4
			moveq	#0,d5
			moveq	#$1F,d6
			bsr.w	DrawTiles_LR_3
	locj_6D88:

			bclr	#5,(a2)
			beq.s	locret_69F2
			move.w	#$00E0,d4
			moveq	#0,d5
			bsr.w	Calc_VRAM_Pos_2
			move.w	#$E0,d4
			moveq	#0,d5
			moveq	#$1F,d6
			bsr.w	DrawTiles_LR_3
		endc

locret_69F2:
		rts
; End of function sub_6954


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_69F4:
		if Revision=0

		tst.b	(a2)
		beq.w	locret_6A80
		bclr	#2,(a2)
		beq.s	loc_6A3E
		cmpi.w	#$10,(a3)
		blo.s	loc_6A3E
		move.w	($FFFFF7F0).w,d4
		move.w	4(a3),d1
		andi.w	#-$10,d1
		sub.w	d1,d4
		move.w	d4,-(sp)
		moveq	#-$10,d5
		bsr.w	Calc_VRAM_Pos
		move.w	(sp)+,d4
		moveq	#-$10,d5
		move.w	($FFFFF7F0).w,d6
		move.w	4(a3),d1
		andi.w	#-$10,d1
		sub.w	d1,d6
		blt.s	loc_6A3E
		lsr.w	#4,d6
		subi.w	#$E,d6
		bhs.s	loc_6A3E
		neg.w	d6
		bsr.w	DrawTiles_TB_2

loc_6A3E:
		bclr	#3,(a2)
		beq.s	locret_6A80
		move.w	($FFFFF7F0).w,d4
		move.w	4(a3),d1
		andi.w	#-$10,d1
		sub.w	d1,d4
		move.w	d4,-(sp)
		move.w	#$140,d5
		bsr.w	Calc_VRAM_Pos
		move.w	(sp)+,d4
		move.w	#$140,d5
		move.w	($FFFFF7F0).w,d6
		move.w	4(a3),d1
		andi.w	#-$10,d1
		sub.w	d1,d6
		blt.s	locret_6A80
		lsr.w	#4,d6
		subi.w	#$E,d6
		bhs.s	locret_6A80
		neg.w	d6
		bsr.w	DrawTiles_TB_2

locret_6A80:
		rts
; End of function sub_69F4

; ===========================================================================

		tst.b	(a2)
		beq.s	locret_6AD6
		bclr	#2,(a2)
		beq.s	loc_6AAC
		move.w	#$D0,d4
		move.w	4(a3),d1
		andi.w	#-$10,d1
		sub.w	d1,d4
		move.w	d4,-(sp)
		moveq	#-$10,d5
		bsr.w	sub_6C3C
		move.w	(sp)+,d4
		moveq	#-$10,d5
		moveq	#2,d6
		bsr.w	DrawTiles_TB_2

loc_6AAC:
		bclr	#3,(a2)
		beq.s	locret_6AD6
		move.w	#$D0,d4
		move.w	4(a3),d1
		andi.w	#-$10,d1
		sub.w	d1,d4
		move.w	d4,-(sp)
		move.w	#$140,d5
		bsr.w	sub_6C3C
		move.w	(sp)+,d4
		move.w	#$140,d5
		moveq	#2,d6
		bsr.w	DrawTiles_TB_2

locret_6AD6:
		rts

		else

			tst.b	(a2)
			beq.w	locj_6DF2
			cmpi.b	#id_SBZ,(v_zone).w
			beq.w	Draw_SBz
			bclr	#0,(a2)
			beq.s	locj_6DD2
			move.w	#$70,d4
			moveq	#-$10,d5
			bsr.w	Calc_VRAM_Pos
			move.w	#$70,d4
			moveq	#-$10,d5
			moveq	#2,d6
			bsr.w	DrawTiles_TB_2
	locj_6DD2:
			bclr	#1,(a2)
			beq.s	locj_6DF2
			move.w	#$70,d4
			move.w	#$140,d5
			bsr.w	Calc_VRAM_Pos
			move.w	#$70,d4
			move.w	#$140,d5
			moveq	#2,d6
			bsr.w	DrawTiles_TB_2
	locj_6DF2:
			rts
	locj_6DF4:
			dc.b $00,$00,$00,$00,$00,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$04
			dc.b $04,$04,$04,$04,$04,$04,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
			dc.b $02,$00
;===============================================================================
	Draw_SBz:
			moveq	#-$10,d4
			bclr	#0,(a2)
			bne.s	locj_6E28
			bclr	#1,(a2)
			beq.s	locj_6E72
			move.w	#$E0,d4
	locj_6E28:
			lea	(locj_6DF4+1),A0
			move.w	(v_bgscreenposy).w,d0
			add.w	d4,d0
			andi.w	#$1F0,d0
			lsr.w	#4,d0
			move.b	(a0,d0),d0
			lea	(locj_6FE4),a3
			move.w	(a3,d0),a3
			beq.s	locj_6E5E
			moveq	#-$10,d5
			movem.l	d4/d5,-(sp)
			bsr.w	Calc_VRAM_Pos
			movem.l	(sp)+,d4/d5
			bsr.w	DrawTiles_LR
			bra.s	locj_6E72
;===============================================================================
	locj_6E5E:
			moveq	#0,d5
			movem.l	d4/d5,-(sp)
			bsr.w	Calc_VRAM_Pos_2
			movem.l	(sp)+,d4/d5
			moveq	#$1F,d6
			bsr.w	DrawTiles_LR_3
	locj_6E72:
			tst.b	(a2)
			bne.s	locj_6E78
			rts
;===============================================================================
	locj_6E78:
			moveq	#-$10,d4
			moveq	#-$10,d5
			move.b	(a2),d0
			andi.b	#$A8,d0
			beq.s	locj_6E8C
			lsr.b	#1,d0
			move.b	d0,(a2)
			move.w	#$140,d5
	locj_6E8C:
			lea	(locj_6DF4),a0
			move.w	(v_bgscreenposy).w,d0
			andi.w	#$1F0,d0
			lsr.w	#4,d0
			lea	(a0,d0),a0
			bra.w	locj_6FEC
;===============================================================================



	locj_6EA4:
			tst.b	(a2)
			beq.w	locj_6EF0
			cmpi.b	#id_MZ,(v_zone).w
			beq.w	Draw_Mz
			bclr	#0,(a2)
			beq.s	locj_6ED0
			move.w	#$40,d4
			moveq	#-$10,d5
			bsr.w	Calc_VRAM_Pos
			move.w	#$40,d4
			moveq	#-$10,d5
			moveq	#2,d6
			bsr.w	DrawTiles_TB_2
	locj_6ED0:
			bclr	#1,(a2)
			beq.s	locj_6EF0
			move.w	#$40,d4
			move.w	#$140,d5
			bsr.w	Calc_VRAM_Pos
			move.w	#$40,d4
			move.w	#$140,d5
			moveq	#2,d6
			bsr.w	DrawTiles_TB_2
	locj_6EF0:
			rts
	locj_6EF2:
			dc.b $00,$00,$00,$00,$00,$00,$06,$06,$04,$04,$04,$04,$04,$04,$04,$04
			dc.b $04,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
			dc.b $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
			dc.b $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
			dc.b $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
			dc.b $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
			dc.b $02,$00
;===============================================================================
	Draw_Mz:
			moveq	#-$10,d4
			bclr	#0,(a2)
			bne.s	locj_6F66
			bclr	#1,(a2)
			beq.s	locj_6FAE
			move.w	#$E0,d4
	locj_6F66:
			lea	(locj_6EF2+1),a0
			move.w	(v_bgscreenposy).w,d0
			subi.w	#$200,d0
			add.w	d4,d0
			andi.w	#$7F0,d0
			lsr.w	#4,d0
			move.b	(a0,d0),d0
			move.w	locj_6FE4(pc,d0.w),a3
			beq.s	locj_6F9A
			moveq	#-$10,d5
			movem.l	d4/d5,-(sp)
			bsr.w	Calc_VRAM_Pos
			movem.l	(sp)+,d4/d5
			bsr.w	DrawTiles_LR
			bra.s	locj_6FAE
;===============================================================================
	locj_6F9A:
			moveq	#0,d5
			movem.l	d4/d5,-(sp)
			bsr.w	Calc_VRAM_Pos_2
			movem.l	(sp)+,d4/d5
			moveq	#$1F,d6
			bsr.w	DrawTiles_LR_3
	locj_6FAE:
			tst.b	(a2)
			bne.s	locj_6FB4
			rts
;===============================================================================
	locj_6FB4:
			moveq	#-$10,d4
			moveq	#-$10,d5
			move.b	(a2),d0
			andi.b	#$A8,d0
			beq.s	locj_6FC8
			lsr.b	#1,d0
			move.b	d0,(a2)
			move.w	#$140,d5
	locj_6FC8:
			lea	(locj_6EF2),a0
			move.w	(v_bgscreenposy).w,d0
			subi.w	#$200,d0
			andi.w	#$7F0,d0
			lsr.w	#4,d0
			lea	(a0,d0),a0
			bra.w	locj_6FEC
;===============================================================================
	locj_6FE4:
			dc.b $FF,$18,$FF,$18,$FF,$20,$FF,$28
	locj_6FEC:
			moveq	#$F,d6
			move.l	#$800000,d7
	locj_6FF4:
			moveq	#0,d0
			move.b	(a0)+,d0
			btst	d0,(a2)
			beq.s	locj_701C
			move.w	locj_6FE4(pc,d0.w),a3
			movem.l	d4/d5/a0,-(sp)
			movem.l	d4/d5,-(sp)
			bsr.w	DrawBlocks
			movem.l	(sp)+,d4/d5
			bsr.w	Calc_VRAM_Pos
			bsr.w	DrawTiles
			movem.l	(sp)+,d4/d5/a0
	locj_701C:
			addi.w	#$10,d4
			dbf	d6,locj_6FF4
			clr.b	(a2)
			rts

		endc

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


DrawTiles_LR:
		moveq	#$15,d6

DrawTiles_LR_2:
		move.l	#$800000,d7
		move.l	d0,d1

	@loop2:
		movem.l	d4-d5,-(sp)
		bsr.w	DrawBlocks
		move.l	d1,d0
		bsr.w	DrawTiles
		addq.b	#4,d1
		andi.b	#$7F,d1
		movem.l	(sp)+,d4-d5
		addi.w	#$10,d5
		dbf	d6,@loop2
		rts
; End of function DrawTiles_LR

		if Revision=0
		else
DrawTiles_LR_3:
		move.l	#$800000,d7
		move.l	d0,d1

	@loop:
		movem.l	d4-d5,-(sp)
		bsr.w	DrawBlocks_2
		move.l	d1,d0
		bsr.w	DrawTiles
		addq.b	#4,d1
		andi.b	#$7F,d1
		movem.l	(sp)+,d4-d5
		addi.w	#$10,d5
		dbf	d6,@loop
		rts
; End of function DrawTiles_LR_3
		endc


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


DrawTiles_TB:
		moveq	#$F,d6

DrawTiles_TB_2:
		move.l	#$800000,d7
		move.l	d0,d1

	@loop:
		movem.l	d4-d5,-(sp)
		bsr.w	DrawBlocks
		move.l	d1,d0
		bsr.w	DrawTiles
		addi.w	#$100,d1
		andi.w	#$FFF,d1
		movem.l	(sp)+,d4-d5
		addi.w	#$10,d4
		dbf	d6,@loop
		rts
; End of function DrawTiles_TB_2


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


DrawTiles:
		or.w	d2,d0
		swap	d0
		btst	#4,(a0)
		bne.s	DrawFlipY
		btst	#3,(a0)
		bne.s	DrawFlipX
		move.l	d0,(a5)
		move.l	(a1)+,(a6)
		add.l	d7,d0
		move.l	d0,(a5)
		move.l	(a1)+,(a6)
		rts
; ===========================================================================

DrawFlipX:
		move.l	d0,(a5)
		move.l	(a1)+,d4
		eori.l	#$8000800,d4
		swap	d4
		move.l	d4,(a6)
		add.l	d7,d0
		move.l	d0,(a5)
		move.l	(a1)+,d4
		eori.l	#$8000800,d4
		swap	d4
		move.l	d4,(a6)
		rts
; ===========================================================================

DrawFlipY:
		btst	#3,(a0)
		bne.s	DrawFlipXY
		move.l	d0,(a5)
		move.l	(a1)+,d5
		move.l	(a1)+,d4
		eori.l	#$10001000,d4
		move.l	d4,(a6)
		add.l	d7,d0
		move.l	d0,(a5)
		eori.l	#$10001000,d5
		move.l	d5,(a6)
		rts
; ===========================================================================

DrawFlipXY:
		move.l	d0,(a5)
		move.l	(a1)+,d5
		move.l	(a1)+,d4
		eori.l	#$18001800,d4
		swap	d4
		move.l	d4,(a6)
		add.l	d7,d0
		move.l	d0,(a5)
		eori.l	#$18001800,d5
		swap	d5
		move.l	d5,(a6)
		rts
; End of function DrawTiles

; ===========================================================================
; unused garbage
		if Revision=0
		rts
		move.l	d0,(a5)
		move.w	#$2000,d5
		move.w	(a1)+,d4
		add.w	d5,d4
		move.w	d4,(a6)
		move.w	(a1)+,d4
		add.w	d5,d4
		move.w	d4,(a6)
		add.l	d7,d0
		move.l	d0,(a5)
		move.w	(a1)+,d4
		add.w	d5,d4
		move.w	d4,(a6)
		move.w	(a1)+,d4
		add.w	d5,d4
		move.w	d4,(a6)
		rts
		else
		endc

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


DrawBlocks:
		if Revision=0
		lea	Blk16_GHZ,a1
		add.w	4(a3),d4
		add.w	(a3),d5
		else
			add.w	(a3),d5
	DrawBlocks_2:
			add.w	4(a3),d4
			lea	Blk16_GHZ,a1
		endc
		move.w	d4,d3
		lsr.w	#1,d3
		andi.w	#$380,d3
		lsr.w	#3,d5
		move.w	d5,d0
		lsr.w	#5,d0
		andi.w	#$7F,d0
		add.w	d3,d0
		moveq	#-1,d3
		move.b	(a4,d0.w),d3
		beq.s	locret_6C1E
		subq.b	#1,d3
		andi.w	#$7F,d3
		ror.w	#7,d3
		add.w	d4,d4
		andi.w	#$1E0,d4
		andi.w	#$1E,d5
		add.w	d4,d3
		add.w	d5,d3
		movea.l	d3,a0
		move.w	(a0),d3
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		adda.w	d3,a1

locret_6C1E:
		rts
; End of function DrawBlocks


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Calc_VRAM_Pos:
		if Revision=0
		add.w	4(a3),d4
		add.w	(a3),d5
		else
			add.w	(a3),d5
	Calc_VRAM_Pos_2:
			add.w	4(a3),d4
		endc
		andi.w	#$F0,d4
		andi.w	#$1F0,d5
		lsl.w	#4,d4
		lsr.w	#2,d5
		add.w	d5,d4
		moveq	#3,d0
		swap	d0
		move.w	d4,d0
		rts
; End of function Calc_VRAM_Pos


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||
; not used


sub_6C3C:
		add.w	4(a3),d4
		add.w	(a3),d5
		andi.w	#$F0,d4
		andi.w	#$1F0,d5
		lsl.w	#4,d4
		lsr.w	#2,d5
		add.w	d5,d4
		moveq	#2,d0
		swap	d0
		move.w	d4,d0
		rts
; End of function sub_6C3C

; ---------------------------------------------------------------------------
; Subroutine to	load tiles as soon as the level	appears
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LoadTilesFromStart:
		lea	(vdp_control_port).l,a5
		lea	(vdp_data_port).l,a6
		lea	(v_screenposx).w,a3
		lea	(v_lvllayout).w,a4
		move.w	#$4000,d2
		bsr.s	DrawChunks
		lea	(v_bgscreenposx).w,a3
		lea	(v_lvllayout+$40).w,a4
		move.w	#$6000,d2
		if Revision=0
		else
			tst.b	(v_zone).w
			beq.w	Draw_GHz_Bg
			cmpi.b	#id_MZ,(v_zone).w
			beq.w	Draw_Mz_Bg
			cmpi.w	#(id_SBZ<<8)+0,(v_zone).w
			beq.w	Draw_SBz_Bg
			cmpi.b	#id_EndZ,(v_zone).w
			beq.w	Draw_GHz_Bg
		endc
; End of function LoadTilesFromStart


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


DrawChunks:
		moveq	#-$10,d4
		moveq	#$F,d6

	@loop:
		movem.l	d4-d6,-(sp)
		moveq	#0,d5
		move.w	d4,d1
		bsr.w	Calc_VRAM_Pos
		move.w	d1,d4
		moveq	#0,d5
		moveq	#$1F,d6
		bsr.w	DrawTiles_LR_2
		movem.l	(sp)+,d4-d6
		addi.w	#$10,d4
		dbf	d6,@loop
		rts
; End of function DrawChunks

		if Revision=0
		else

	Draw_GHz_Bg:
			moveq	#0,d4
			moveq	#$F,d6
	locj_7224:
			movem.l	d4-d6,-(sp)
			lea	(locj_724a),a0
			move.w	(v_bgscreenposy).w,d0
			add.w	d4,d0
			andi.w	#$F0,d0
			bsr.w	locj_72Ba
			movem.l	(sp)+,d4-d6
			addi.w	#$10,d4
			dbf	d6,locj_7224
			rts
	locj_724a:
			dc.b $00,$00,$00,$00,$06,$06,$06,$04,$04,$04,$00,$00,$00,$00,$00,$00
;-------------------------------------------------------------------------------
	Draw_Mz_Bg:;locj_725a:
			moveq	#-$10,d4
			moveq	#$F,d6
	locj_725E:
			movem.l	d4-d6,-(sp)
			lea	(locj_6EF2+$01),a0
			move.w	(v_bgscreenposy).w,d0
			subi.w	#$200,d0
			add.w	d4,d0
			andi.w	#$7F0,d0
			bsr.w	locj_72Ba
			movem.l	(sp)+,d4-d6
			addi.w	#$10,d4
			dbf	d6,locj_725E
			rts
;-------------------------------------------------------------------------------
	Draw_SBz_Bg:;locj_7288:
			moveq	#-$10,d4
			moveq	#$F,d6
	locj_728C:
			movem.l	d4-d6,-(sp)
			lea	(locj_6DF4+$01),a0
			move.w	(v_bgscreenposy).w,d0
			add.w	d4,d0
			andi.w	#$1F0,d0
			bsr.w	locj_72Ba
			movem.l	(sp)+,d4-d6
			addi.w	#$10,d4
			dbf	d6,locj_728C
			rts
;-------------------------------------------------------------------------------
	locj_72B2:
			dc.b $F7,$08,$F7,$08,$F7,$10,$F7,$18
	locj_72Ba:
			lsr.w	#4,d0
			move.b	(a0,d0),d0
			move.w	locj_72B2(pc,d0.w),a3
			beq.s	locj_72da
			moveq	#-$10,d5
			movem.l	d4/d5,-(sp)
			bsr.w	Calc_VRAM_Pos
			movem.l	(sp)+,d4/d5
			bsr.w	DrawTiles_LR
			bra.s	locj_72EE
	locj_72da:
			moveq	#0,d5
			movem.l	d4/d5,-(sp)
			bsr.w	Calc_VRAM_Pos_2
			movem.l	(sp)+,d4/d5
			moveq	#$1F,d6
			bsr.w	DrawTiles_LR_3
	locj_72EE:
			rts
		endc

; ---------------------------------------------------------------------------
; Subroutine to load basic level data
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LevelDataLoad:
		moveq	#0,d0
		move.b	(v_zone).w,d0
		lsl.w	#4,d0
		lea	(LevelHeaders).l,a2
		lea	(a2,d0.w),a2
		move.l	a2,-(sp)
		addq.l	#4,a2
		movea.l	(a2)+,a0
	;	lea	(v_16x16).w,a1	; RAM address for 16x16 mappings
	;	move.w	#0,d0
	;	bsr.w	EniDec
		movea.l	(a2)+,a0
		lea	(v_256x256).l,a1 ; RAM address for 256x256 mappings
		bsr.w	KosDec
		bsr.w	LevelLayoutLoad
		move.w	(a2)+,d0
		move.w	(a2),d0
		andi.w	#$FF,d0
		bsr.w	PalLoad1	; load palette (based on d0)
		movea.l	(sp)+,a2
		addq.w	#4,a2		; read number for 2nd PLC
		moveq	#0,d0
		move.b	(a2),d0
		beq.s	@skipPLC	; if 2nd PLC is 0 (i.e. the ending sequence), branch
		bsr.w	AddPLC		; load pattern load cues

	@skipPLC:
		rts
; End of function LevelDataLoad

; ---------------------------------------------------------------------------
; Level	layout loading subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LevelLayoutLoad:
		lea	(v_lvllayout).w,a3
		move.w	#(v_spritequeue-v_lvllayout)/4-1,d1
		moveq	#0,d0

LevLoad_ClrRam:
		move.l	d0,(a3)+
		dbf	d1,LevLoad_ClrRam ; clear the RAM ($A400-A3FF)

		lea	(v_lvllayout).w,a3 ; RAM address for level layout
		moveq	#0,d1
		bsr.w	LevelLayoutLoad2 ; load	level layout into RAM
		lea	(v_lvllayout+$40).w,a3 ; RAM address for background layout
		moveq	#2,d1
; End of function LevelLayoutLoad

; "LevelLayoutLoad2" is	run twice - for	the level and the background

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


LevelLayoutLoad2:
		move.w	(v_zone).w,d0
		lsl.b	#6,d0
		lsr.w	#5,d0
		move.w	d0,d2
		add.w	d0,d0
		add.w	d2,d0
		add.w	d1,d0
		lea	(Level_Index).l,a1
		move.w	(a1,d0.w),d0
		lea	(a1,d0.w),a1
		moveq	#0,d1
		move.w	d1,d2
		move.b	(a1)+,d1	; load level width (in tiles)
		move.b	(a1)+,d2	; load level height (in	tiles)

LevLoad_NumRows:
		move.w	d1,d0
		movea.l	a3,a0

LevLoad_Row:
		move.b	(a1)+,(a0)+
		dbf	d0,LevLoad_Row	; load 1 row
		lea	$80(a3),a3	; do next row
		dbf	d2,LevLoad_NumRows ; repeat for	number of rows
		rts
; End of function LevelLayoutLoad2

		include	"_inc\DynamicLevelEvents.asm"

		include	"_incObj\01 Secret.asm"
		include	"_incObj\03 Red Coins.asm"
		include	"_incObj\11 Bridge (part 1).asm"

; ---------------------------------------------------------------------------
; Platform subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

PlatformObject:
		lea	(v_player).w,a1
		tst.w	obVelY(a1)	; is Sonic moving up/jumping?
		bmi.w	Plat_Exit	; if yes, branch

;		perform x-axis range check
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		add.w	d1,d0
		bmi.w	Plat_Exit
		add.w	d1,d1
		cmp.w	d1,d0
		bhs.w	Plat_Exit

	Plat_NoXCheck:
		move.w	obY(a0),d0
		subq.w	#8,d0

Platform3:
;		perform y-axis range check
		move.w	obY(a1),d2
		move.b	obHeight(a1),d1
		ext.w	d1
		add.w	d2,d1
		addq.w	#4,d1
		sub.w	d1,d0
		bhi.w	Plat_Exit
		cmpi.w	#-$10,d0
		blo.w	Plat_Exit

		tst.b	(f_lockmulti).w
		bmi.w	Plat_Exit
		cmpi.b	#6,obRoutine(a1)
		bhs.w	Plat_Exit
		add.w	d0,d2
		addq.w	#3,d2
		move.w	d2,obY(a1)
		addq.b	#2,obRoutine(a0)

loc_74AE:
		btst	#3,obStatus(a1)
		beq.s	loc_74DC
		moveq	#0,d0
		move.b	$3D(a1),d0
		mulu	#size,d0
		addi.w	#v_objspace,d0
		movea.w	d0,a2
		bclr	#3,obStatus(a2)
		clr.b	ob2ndRout(a2)
		cmpi.b	#4,obRoutine(a2)
		bne.s	loc_74DC
		subq.b	#2,obRoutine(a2)

loc_74DC:
		moveq	#0,d0
		move.w	a0,d0
		subi.w	#v_objspace,d0
		divu	#size,d0
		move.b	d0,$3D(a1)
		move.b	#0,obAngle(a1)
		move.w	#0,obVelY(a1)
		move.w	obVelX(a1),obInertia(a1)
		btst	#1,obStatus(a1)
		beq.s	loc_7512
		move.l	a0,-(sp)
		movea.l	a1,a0
		jsr	(Sonic_ResetOnFloor).l
		movea.l	(sp)+,a0

loc_7512:
		bset	#3,obStatus(a1)
		bset	#3,obStatus(a0)

Plat_Exit:
		rts
; End of function PlatformObject

; ---------------------------------------------------------------------------
; Sloped platform subroutine (GHZ collapsing ledges and	SLZ seesaws)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


SlopeObject:
		lea	(v_player).w,a1
		tst.w	obVelY(a1)
		bmi.w	Plat_Exit
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		add.w	d1,d0
		bmi.s	Plat_Exit
		add.w	d1,d1
		cmp.w	d1,d0
		bhs.s	Plat_Exit
		btst	#0,obRender(a0)
		beq.s	loc_754A
		not.w	d0
		add.w	d1,d0

loc_754A:
		lsr.w	#1,d0
		moveq	#0,d3
		move.b	(a2,d0.w),d3
		move.w	obY(a0),d0
		sub.w	d3,d0
		bra.w	Platform3
; End of function SlopeObject


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Swing_Solid:
		lea	(v_player).w,a1
		tst.w	obVelY(a1)
		bmi.w	Plat_Exit
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		add.w	d1,d0
		bmi.w	Plat_Exit
		add.w	d1,d1
		cmp.w	d1,d0
		bhs.w	Plat_Exit
		move.w	obY(a0),d0
		sub.w	d3,d0
		bra.w	Platform3
; End of function Obj15_Solid

; ===========================================================================

		include	"_incObj\11 Bridge (part 2).asm"

; ---------------------------------------------------------------------------
; Subroutine allowing Sonic to walk or jump off	a platform
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ExitPlatform:
		move.w	d1,d2

ExitPlatform2:
		add.w	d2,d2
		lea	(v_player).w,a1
		btst	#1,obStatus(a1)
		bne.s	loc_75E0
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		add.w	d1,d0
		bmi.s	loc_75E0
		cmp.w	d2,d0
		blo.s	locret_75F2

loc_75E0:
		bclr	#3,obStatus(a1)
		move.b	#2,obRoutine(a0)
		bclr	#3,obStatus(a0)

locret_75F2:
		rts
; End of function ExitPlatform

		include	"_incObj\11 Bridge (part 3).asm"
		include	"_maps\Bridge.asm"

		include	"_incObj\15 Swinging Platforms (part 1).asm"

; ---------------------------------------------------------------------------
; Subroutine to	change Sonic's position with a platform
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


MvSonicOnPtfm:
		lea	(v_player).w,a1
		move.w	obY(a0),d0
		sub.w	d3,d0
		bra.s	MvSonic2
; End of function MvSonicOnPtfm

; ---------------------------------------------------------------------------
; Subroutine to	change Sonic's position with a platform
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


MvSonicOnPtfm2:
		lea	(v_player).w,a1
		move.w	obY(a0),d0
		subi.w	#9,d0

MvSonic2:
		move.w	#AirCount,airctr.w
		tst.b	(f_lockmulti).w
		bmi.s	locret_7B62
		cmpi.b	#6,(v_player+obRoutine).w
		bhs.s	locret_7B62
		tst.w	(v_debuguse).w
		bne.s	locret_7B62
		moveq	#0,d1
		move.b	obHeight(a1),d1
		sub.w	d1,d0
		move.w	d0,obY(a1)
		sub.w	obX(a0),d2
		sub.w	d2,obX(a1)

locret_7B62:
		rts
; End of function MvSonicOnPtfm2

		include	"_incObj\15 Swinging Platforms (part 2).asm"
		include	"_maps\Swinging Platforms (GHZ).asm"
		dc.b "GO TALK TO SOMEONE WHO IS ARSED ENOUGH WITH THIS SHITTY FOLDER STRUCTURE"
	if *&1<>0
		dc.b "!"

	endif
		include	"_maps\Swinging Platforms (SLZ).asm"
		include	"_incObj\17 Spiked Pole Helix.asm"
		include	"_maps\Spiked Pole Helix.asm"
		include	"_incObj\18 Platforms.asm"
		include	"_maps\Platforms (GHZ).asm"
		include	"_maps\Platforms (SYZ).asm"
		include	"_maps\Platforms (SLZ).asm"
		include	"_maps\GHZ Ball.asm"
		include	"_incObj\1A Collapsing Ledge (part 1).asm"
		include	"_incObj\53 Collapsing Floors.asm"

; ===========================================================================

Ledge_Fragment:
		move.b	#0,ledge_collapse_flag(a0)

loc_847A:
		lea	(CFlo_Data1).l,a4
		moveq	#$18,d1
		addq.b	#2,obFrame(a0)

loc_8486:
		moveq	#0,d0
		move.b	obFrame(a0),d0
		add.w	d0,d0
		movea.l	obMap(a0),a3
		adda.w	(a3,d0.w),a3
		addq.w	#2,a3

		bset	#5,obRender(a0)
		move.l	#Ledge_Display,d4
		move.b	obRender(a0),d5
		movea.l	a0,a1
		bra.s	loc_84B2
; ===========================================================================

loc_84AA:
		bsr.w	FindFreeObj
		bpl.s	loc_84F2
		addq.w	#6,a3
	display	4, a1			; enable display for each segment

loc_84B2:
		move.l	d4,(a1)
		move.l	a3,obMap(a1)
		move.b	d5,obRender(a1)

		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	obGfx(a0),obGfx(a1)
		move.b	obActWid(a0),obActWid(a1)

		move.b	(a4)+,ledge_timedelay(a1)
;		cmpa.l	a0,a1
;		bhs.s	loc_84EE
;		bsr.w	DisplaySprite1

loc_84EE:
		dbf	d1,loc_84AA

loc_84F2:
		sfx	sfx_Collapse,0,0,0	; play collapsing sound
	NEXT_OBJ
; ===========================================================================
; ---------------------------------------------------------------------------
; Disintegration data for collapsing ledges (MZ, SLZ, SBZ)
; ---------------------------------------------------------------------------
CFlo_Data1:	dc.b $1C, $18, $14, $10, $1A, $16, $12,	$E, $A,	6, $18,	$14, $10, $C, 8, 4
		dc.b $16, $12, $E, $A, 6, 2, $14, $10, $C, 0
CFlo_Data2:	dc.b $1E, $16, $E, 6, $1A, $12,	$A, 2
CFlo_Data3:	dc.b $16, $1E, $1A, $12, 6, $E,	$A, 2

; ---------------------------------------------------------------------------
; Sloped platform subroutine (GHZ collapsing ledges and	MZ platforms)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


SlopeObject2:
		lea	(v_player).w,a1
		btst	#3,obStatus(a1)
		beq.s	locret_856E
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		add.w	d1,d0
		lsr.w	#1,d0
		btst	#0,obRender(a0)
		beq.s	loc_854E
		not.w	d0
		add.w	d1,d0

loc_854E:
		moveq	#0,d1
		move.b	(a2,d0.w),d1
		move.w	obY(a0),d0
		sub.w	d1,d0
		moveq	#0,d1
		move.b	obHeight(a1),d1
		sub.w	d1,d0
		move.w	d0,obY(a1)
		sub.w	obX(a0),d2
		sub.w	d2,obX(a1)

locret_856E:
		rts
; End of function SlopeObject2

; ===========================================================================
; ---------------------------------------------------------------------------
; Collision data for GHZ collapsing ledge
; ---------------------------------------------------------------------------
Ledge_SlopeData:
		incbin	"misc\GHZ Collapsing Ledge Heightmap.bin"
		even

		include	"_maps\Collapsing Ledge.asm"
		include	"_maps\Collapsing Floors.asm"

		include	"_incObj\1C Scenery.asm"
		include	"_maps\Scenery.asm"

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Obj44_SolidWall:
		bsr.w	Obj44_SolidWall2
		beq.s	loc_8AA8
		bmi.w	loc_8AC4
		tst.w	d0
		beq.w	loc_8A92
		bmi.s	loc_8A7C
		tst.w	obVelX(a1)
		bmi.s	loc_8A92
		bra.s	loc_8A82
; ===========================================================================

loc_8A7C:
		tst.w	obVelX(a1)
		bpl.s	loc_8A92

loc_8A82:
		sub.w	d0,obX(a1)
		move.w	#0,obInertia(a1)
		move.w	#0,obVelX(a1)

loc_8A92:
		btst	#1,obStatus(a1)
		bne.s	loc_8AB6
		bset	#5,obStatus(a1)
		bset	#5,obStatus(a0)
		rts
; ===========================================================================

loc_8AA8:
		btst	#5,obStatus(a0)
		beq.s	locret_8AC2
		move.w	#id_Run,obAnim(a1)

loc_8AB6:
		bclr	#5,obStatus(a0)
		bclr	#5,obStatus(a1)

locret_8AC2:
		rts
; ===========================================================================

loc_8AC4:
		tst.w	obVelY(a1)
		bpl.s	locret_8AD8
		tst.w	d3
		bpl.s	locret_8AD8
		sub.w	d3,obY(a1)
		move.w	#0,obVelY(a1)

locret_8AD8:
		rts
; End of function Obj44_SolidWall


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Obj44_SolidWall2:
		lea	(v_player).w,a1
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		add.w	d1,d0
		bmi.s	loc_8B48
		move.w	d1,d3
		add.w	d3,d3
		cmp.w	d3,d0
		bhi.s	loc_8B48
		move.b	obHeight(a1),d3
		ext.w	d3
		add.w	d3,d2
		move.w	obY(a1),d3
		sub.w	obY(a0),d3
		add.w	d2,d3
		bmi.s	loc_8B48
		move.w	d2,d4
		add.w	d4,d4
		cmp.w	d4,d3
		bhs.s	loc_8B48
		tst.b	(f_lockmulti).w
		bmi.s	loc_8B48
		cmpi.b	#6,(v_player+obRoutine).w
		bhs.s	loc_8B48
		tst.w	(v_debuguse).w
		bne.s	loc_8B48
		move.w	d0,d5
		cmp.w	d0,d1
		bhs.s	loc_8B30
		add.w	d1,d1
		sub.w	d1,d0
		move.w	d0,d5
		neg.w	d5

loc_8B30:
		move.w	d3,d1
		cmp.w	d3,d2
		bhs.s	loc_8B3C
		sub.w	d4,d3
		move.w	d3,d1
		neg.w	d1

loc_8B3C:
		cmp.w	d1,d5
		bhi.s	loc_8B44
		moveq	#1,d4
		rts
; ===========================================================================

loc_8B44:
		moveq	#-1,d4
		rts
; ===========================================================================

loc_8B48:
		moveq	#0,d4
		rts
; End of function Obj44_SolidWall2

; ===========================================================================

		include	"_incObj\24, 27 & 3F Explosions.asm"
		include	"_maps\Buzz Bomber Missile Dissolve.asm"
		include	"_maps\Explosions.asm"

		include	"_incObj\28 Animals.asm"
		include	"_incObj\29 Points.asm"
		include	"_maps\Animals 1.asm"
		include	"_maps\Animals 2.asm"
		include	"_maps\Animals 3.asm"
		include	"_maps\Points.asm"

		include	"_incObj\1F Crabmeat.asm"
		include	"_anim\Crabmeat.asm"
		include	"_maps\Crabmeat.asm"
		include	"_incObj\22 Buzz Bomber.asm"
		include	"_incObj\23 Buzz Bomber Missile.asm"
		include	"_anim\Buzz Bomber.asm"
		include	"_anim\Buzz Bomber Missile.asm"
		include	"_maps\Buzz Bomber.asm"
		include	"_maps\Buzz Bomber Missile.asm"

		include	"_incObj\25 & 37 Rings.asm"
		include	"_incObj\4B Giant Ring.asm"
		include	"_incObj\7C Ring Flash.asm"

		include	"_anim\Rings.asm"
		if Revision=0
		include	"_maps\Rings.asm"
		else
			include	"_maps\Rings (JP1).asm"
		endc
		include	"_maps\Giant Ring.asm"
		include	"_maps\Ring Flash.asm"
		include	"_incObj\26 Monitor.asm"
		include	"_incObj\2E Monitor Content Power-Up.asm"
		include	"_incObj\26 Monitor (SolidSides subroutine).asm"
		include	"_anim\Monitor.asm"
		include	"_maps\Monitor.asm"

		include	"_incObj\0E Title Screen Sonic.asm"
		include	"_incObj\0F Press Start and TM.asm"

		include	"_anim\Title Screen Sonic.asm"
		include	"_anim\Press Start and TM.asm"

		include	"_incObj\sub AnimateSprite.asm"

		include	"_maps\Press Start and TM.asm"
		include	"_maps\Title Screen Sonic.asm"

		include	"_incObj\2B Chopper.asm"
		include	"_anim\Chopper.asm"
		include	"_maps\Chopper.asm"
		include	"_incObj\2C Jaws.asm"
		include	"_anim\Jaws.asm"
		include	"_maps\Jaws.asm"

		include	"_incObj\34 Title Cards.asm"
		include	"_incObj\39 Game Over.asm"
		include	"_incObj\3A Got Through Card.asm"

; ---------------------------------------------------------------------------
; Sprite mappings - zone title cards
; ---------------------------------------------------------------------------
Map_Card:	dc.w M_Card_GHZ-Map_Card
		dc.w M_Card_LZ-Map_Card
		dc.w M_Card_MZ-Map_Card
		dc.w M_Card_SLZ-Map_Card
		dc.w M_Card_SYZ-Map_Card
		dc.w M_Card_SBZ-Map_Card
		dc.w M_Card_Zone-Map_Card
		dc.w M_Card_Act1-Map_Card
		dc.w M_Card_Act2-Map_Card
		dc.w M_Card_Act3-Map_Card
		dc.w M_Card_Act4-Map_Card
		dc.w M_Card_Oval-Map_Card
M_Card_GHZ:	dc.w 9 			; GREEN HILL
		dc.b $F8, 5, 0,	$18, $FF, $B4
		dc.b $F8, 5, 0,	$3A, $FF, $C4
		dc.b $F8, 5, 0,	$10, $FF, $D4
		dc.b $F8, 5, 0,	$10, $FF, $E4
		dc.b $F8, 5, 0,	$2E, $FF, $F4
		dc.b $F8, 5, 0,	$1C, $00, $14
		dc.b $F8, 1, 0,	$20, $00, $24
		dc.b $F8, 5, 0,	$26, $00, $2C
		dc.b $F8, 5, 0,	$26, $00, $3C
		even
M_Card_LZ:
M_Card_MZ:
M_Card_SLZ:
M_Card_SYZ:
M_Card_SBZ:
M_Card_Zone:	dc.w 4			; ZONE
		dc.b $F8, 5, 0,	$4E, $FF, $E0
		dc.b $F8, 5, 0,	$32, $FF, $F0
		dc.b $F8, 5, 0,	$2E, $00, 0
M_Card_Act4 =	*-2
		dc.b $F8, 5, 0,	$10, $00, $10
		even
M_Card_Act1:	dc.w 2			; ACT 1
		dc.b 4,	$C, 0, $53, $FF, $EC
		dc.b $F4, 2, 0,	$57, $00, $C
M_Card_Act2:	dc.w 2			; ACT 2
		dc.b 4,	$C, 0, $53, $FF, $EC
		dc.b $F4, 6, 0,	$5A, $00, 8
M_Card_Act3:	dc.w 2			; ACT 3
		dc.b 4,	$C, 0, $53, $FF, $EC
		dc.b $F4, 6, 0,	$60, $00, 8
M_Card_Oval:	dc.w $D			; Oval
		dc.b $E4, $C, 0, $70, $FF, $F4
		dc.b $E4, 2, 0,	$74, $00, $14
		dc.b $EC, 4, 0,	$77, $FF, $EC
		dc.b $F4, 5, 0,	$79, $FF, $E4
		dc.b $14, $C, $18, $70, $FF,	$EC
		dc.b 4,	2, $18,	$74, $FF, $E4
		dc.b $C, 4, $18, $77, $00, 4
		dc.b $FC, 5, $18, $79, $00, $C
		dc.b $EC, 8, 0,	$7D, $FF, $FC
		dc.b $F4, $C, 0, $7C, $FF, $F4
		dc.b $FC, 8, 0,	$7C, $FF, $F4
		dc.b 4,	$C, 0, $7C, $FF, $EC
		dc.b $C, 8, 0, $7C, $FF, $EC
		even
		include	"_maps\Game Over.asm"

; ---------------------------------------------------------------------------
; Sprite mappings - "SONIC HAS PASSED" title card
; ---------------------------------------------------------------------------
Map_Got:	dc.w M_Got_SonicHas-Map_Got
		dc.w M_Got_Passed-Map_Got
		dc.w M_Got_Score-Map_Got
		dc.w M_Got_TBonus-Map_Got
		dc.w M_Got_RBonus-Map_Got
		dc.w M_Card_Oval-Map_Got
		dc.w M_Card_Act1-Map_Got
		dc.w M_Card_Act2-Map_Got
		dc.w M_Card_Act3-Map_Got
		dc.w M_Card_Act4-Map_Got
M_Got_SonicHas:	dc.w 8			; SONIC HAS
		dc.b $F8, 5, 0,	$3E, $FF, $B8
		dc.b $F8, 5, 0,	$32, $FF, $C8
		dc.b $F8, 5, 0,	$2E, $FF, $D8
		dc.b $F8, 1, 0,	$20, $FF, $E8
		dc.b $F8, 5, 0,	8, $FF, $F0
		dc.b $F8, 5, 0,	$1C, $00, $10
		dc.b $F8, 5, 0,	0, $00, $20
		dc.b $F8, 5, 0,	$3E, $00, $30
M_Got_Passed:	dc.w 6			; PASSED
		dc.b $F8, 5, 0,	$36, $FF, $D0
		dc.b $F8, 5, 0,	0, $FF, $E0
		dc.b $F8, 5, 0,	$3E, $FF, $F0
		dc.b $F8, 5, 0,	$3E, $00, 0
		dc.b $F8, 5, 0,	$10, $00, $10
		dc.b $F8, 5, 0,	$C, $00, $20
M_Got_Score:	dc.w 6			; SCORE
		dc.b $F8, $D, 1, $4A, $FF, $B0
		dc.b $F8, 1, 1,	$62, $FF, $D0
		dc.b $F8, 9, 1,	$64, $00, $18
		dc.b $F8, $D, 1, $6A, $00, $30
		dc.b $F7, 4, 0,	$6E, $FF, $CD
		dc.b $FF, 4, $18, $6E, $FF, $CD
M_Got_TBonus:	dc.w 7			; TIME BONUS
		dc.b $F8, $D, 1, $5A, $FF, $B0
		dc.b $F8, $D, 0, $66, $FF, $D9
		dc.b $F8, 1, 1,	$4A, $FF, $F9
		dc.b $F7, 4, 0,	$6E, $FF, $F6
		dc.b $FF, 4, $18, $6E, $FF, $F6
		dc.b $F8, $D, $FF, $F0, $00,	$28
		dc.b $F8, 1, 1,	$70, $00, $48
M_Got_RBonus:	dc.w 7			; RING BONUS
		dc.b $F8, $D, 1, $52, $FF, $B0
		dc.b $F8, $D, 0, $66, $FF, $D9
		dc.b $F8, 1, 1,	$4A, $FF, $F9
		dc.b $F7, 4, 0,	$6E, $FF, $F6
		dc.b $FF, 4, $18, $6E, $FF, $F6
		dc.b $F8, $D, $FF, $F8, $00,	$28
		dc.b $F8, 1, 1,	$70, $00, $48
		even

		include	"_incObj\36 Spikes.asm"
		include	"_maps\Spikes.asm"
		include	"_incObj\3B Purple Rock.asm"
		include	"_incObj\49 Waterfall Sound.asm"
		include	"_maps\Purple Rock.asm"
		include	"_incObj\3C Smashable Wall.asm"

		include	"_incObj\sub SmashObject.asm"

; ===========================================================================
; Smashed block	fragment speeds
;
Smash_FragSpd1:	dc.w $400, -$500	; x-move speed,	y-move speed
		dc.w $600, -$100
		dc.w $600, $100
		dc.w $400, $500
		dc.w $600, -$600
		dc.w $800, -$200
		dc.w $800, $200
		dc.w $600, $600

Smash_FragSpd2:	dc.w -$600, -$600
		dc.w -$800, -$200
		dc.w -$800, $200
		dc.w -$600, $600
		dc.w -$400, -$500
		dc.w -$600, -$100
		dc.w -$600, $100
		dc.w -$400, $500

		include	"_maps\Smashable Walls.asm"

; ---------------------------------------------------------------------------
; Object code execution subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

ExecuteObjects:
		lea	v_objspace.w,a0
		move.l	(a0),a1
		jmp	(a1)
; ===========================================================================

		include	"_incObj\sub ObjectFall.asm"
		include	"_incObj\sub SpeedToPos.asm"
		include	"_incObj\sub DisplaySprite.asm"
		include	"_incObj\sub DeleteObject.asm"
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to	reset the sprite list to contain proper link data
; ---------------------------------------------------------------------------

ResetSpriteList:
		lea	v_spritetablebuffer.w,a0; get sprite buffer to a0
		moveq	#1,d1			; link #1
		moveq	#80-1,d7		; 80 sprites

.next		clr.w	(a0)			; clear y-pos (hide)
		move.b	d1,3(a0)		; set link
		addq.w	#1,d1			; increment link
		addq.w	#8,a0			; go to next sprite
		dbf	d7,.next		; loop til done

		clr.b	-5(a0)			; break last link
		rts

; ---------------------------------------------------------------------------
; Subroutine to	convert	mappings (etc) to proper Megadrive sprites
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


BuildSprites:
		lea	v_spritequeue+vs_dnext.w,a5; set address for object slot queue
		lea	v_spritetablebuffer.w,a6; set address for sprite table
		lea	v_screenposx.w,a3	; get camera position for quick access
		moveq	#80-1,d7		; do only 80 sprites
		moveq	#0,d6			; clear render flags stuff

		tst.b	v_extrarender.w
		beq.s	@layerloop
		jsr	BuildAchi(pc)		; build the archievements
		jsr	BuildHUD(pc)		; build the HUD

@layerloop	move.w	(a5),a0			; load layer address to a0
		add.w	#vs_size,a5		; skip bunch of shit
		tst.w	dnext(a0)		; check the next pointer for valid object
		beq.w	@nextlayer		; if none, go to next layer

@objloop	andi.b	#$7F,obRender(a0)	; clear onscreen bit
		move.b	obRender(a0),d6		; get render flags
		move.w	obX(a0),d0		; get x-position
		move.w	obY(a0),d1		; get y-position

		btst	#6,d6			; has child sprites?
		bne.w	@childs			; if so, branch to draw child sprites as well
		btst	#2,d6			; uses screen coordinates?
		beq.s	@onscreen		; if so, branch to draw onscreen as opposed to on level

		moveq	#0,d2
		move.b	obActWid(a0),d2		; get object width
		sub.w	(a3),d0			; sub camera x from object xpos
		move.w	d0,d3			; copy the result
		add.w	d2,d3			; add object width
		bmi.s	@nextobj		; if negative still, this is offscreen, ignore it

		move.w	d0,d3			; copy relative x again
		sub.w	d2,d3			; sub width from relative x
		cmpi.w	#320,d3			; is object offscreen?
		bge.s	@nextobj		; if so, ignore this object
		addi.w	#128,d0			; there is 128 pixels of blank at the edges

		sub.w	4(a3),d1		; sub camera y from ypos
		moveq	#$40,d2			; default to $40
		btst	#4,d6			; check vertical size flag
		beq.s	@gotheight		; if not set, branch
		move.b	obHeight(a0),d2		; get object height

@gotheight	add.w	d2,d1			; add height to ypos
		and.w	#$7FF,d1		; and with the Y-wrap value

		move.w	d2,d3			; store height
		add.w	d2,d2			; double height
		addi.w	#224,d2			; add screen height to to d2
		cmp.w	d2,d1			; compare against relative object ypos
		bhs.s	@nextobj		; if offscreen, ignore object
		addi.w	#128,d1			; there is 128 pixels of blank at the edges
		sub.w	d3,d1			; sub object height from relative y

@onscreen	ori.b	#$80,obRender(a0)	; set onscreen bit
		tst.w	d7			; check if we should render more sprite pieces
		bmi.s	@nextobj		; if not, branch

		movea.l	obMap(a0),a1		; get mappings address
		moveq	#0,d4			; set amount of sprite pieces to 1
		btst	#5,d6			; check if single mode
		bne.s	@directsprite		; if set, render sprite piece from a1

		move.b	obFrame(a0),d4		; get mappings frame
		add.w	d4,d4			; double it
		adda.w	(a1,d4.w),a1		; get the final sprite position
		move.w	(a1)+,d4		; get sprite piece amount
		subq.w	#1,d4			; sub 1 from the sprite piece amount
		bmi.s	@nextobj		; if negative, there is 0 sprite pieces. skip.

@directsprite	move.w	obGfx(a0),d5		; get art tile address
		jsr	DrawSpritePiece(pc)	; render this sprite

@nextobj	move.w	dnext(a0),a0		; load next object to a0
		tst.w	dnext(a0)		; check the next pointer for valid object
		bne.w	@objloop		; if there are objects left, branch

@nextlayer	cmpa.w	#v_spritequeue+(vs_size*7),a5; check if this is the table end?
		blo.w	@layerloop		; if not, branch

		move.w	d7,d6			; copy sprites count
		bmi.s	@sprct			; if negative, branch
		moveq	#0,d0			; clear d0

@nullsprites	move.w	d0,(a6)			; clear sprite
		addq.w	#8,a6			; increment to next sprite
		dbf	d7,@nullsprites		; loop until all are done

@sprct	;	subi.w	#80,d6			; sub 80 from sprite count
	;	neg.w	d6			; negate
	;	move.b	d6,v_spritecount.w	; and then store sprite amount
		rts

@childs		btst	#5,d6			; uses screen coordinates?
		beq.s	@childs2		; if not, branch to draw onscreen as opposed to on level

		moveq	#0,d2
		move.b	obWidth(a0),d2		; get object width
		subi.w	#128,d0			; there is 128 pixels of blank at the edges
		move.w	d0,d3			; copy the result
		add.w	d2,d3			; add width to xpos
		bmi.w	@nextobj		; if negative still, this is offscreen, ignore it

		move.w	d0,d3			; copy xpos again
		sub.w	d2,d3			; sub width from xpos
		cmpi.w	#320,d3			; is object offscreen?
		bge.w	@nextobj		; if so, ignore this object
		addi.w	#128,d0			; there is 128 pixels of blank at the edges

		move.b	obHeight(a0),d2		; get object height
		subi.w	#128,d1			; there is 128 pixels of blank at the edges
		move.w	d1,d3			; copy the result
		add.w	d2,d3			; add height to ypos
		bmi.w	@nextobj		; if negative still, this is offscreen, ignore it

		move.w	d1,d3			; copy ypos again
		sub.w	d2,d3			; sub height from ypos
		cmpi.w	#224,d3			; is object offscreen?
		bge.w	@nextobj		; if so, ignore this object
		addi.w	#128,d1			; there is 128 pixels of blank at the edges
		bra.s	@common

@childs2	moveq	#0,d2
		move.b	obWidth(a0),d2		; get object width
		sub.w	(a3),d0			; sub camera x from object xpos
		move.w	d0,d3			; copy the result
		add.w	d2,d3			; add width to xpos
		bmi.w	@nextobj		; if negative still, this is offscreen, ignore it

		move.w	d0,d3			; copy xpos again
		sub.w	d2,d3			; sub width from xpos
		cmpi.w	#320,d3			; is object offscreen?
		bge.w	@nextobj		; if so, ignore this object

		addi.w	#128,d0			; there is 128 pixels of blank at the edges
		sub.w	4(a3),d1		; sub camera y from ypos
		move.b	obHeight(a0),d2		; get object height
		add.w	d2,d1			; add height to ypos
		and.w	#$7FF,d1		; and with the Y-wrap value

		move.w	d2,d3			; store height
		add.w	d2,d2			; double height
		addi.w	#224,d2			; add screen height to to d2
		cmp.w	d2,d1			; compare against relative object ypos
		bhs.w	@nextobj		; if offscreen, ignore object

		addi.w	#128,d1			; there is 128 pixels of blank at the edges
		sub.w	d3,d1			; sub object height from relative y

@common		ori.b	#$80,obrender(a0)	; set onscreen bit
		tst.w	d7			; check if we should render more sprite pieces
		bmi.w	@nextobj		; if not, branch

		move.w	obGfx(a0),d5		; get art tile address
		movea.l	obMap(a0),a2		; get mappings address
		moveq	#0,d4			; set amount of sprite pieces to 1
		move.b	obFrame(a0),d4		; get mappings frame
		beq.s	@nomap			; branch if o

		add.w	d4,d4			; double it
		lea	(a2),a1			; copy mappings address to a1
		adda.w	(a1,d4.w),a1		; get the final sprite position
		move.w	(a1)+,d4		; get sprite piece amount
		subq.w	#1,d4			; sub 1 from the sprite piece amount
		bmi.s	@nomap			; if negative, there is 0 sprite pieces. skip.

		move.w	d6,d3			; copy render flags elsewhere
		jsr	DrawSpritePiece2(pc)	; render this sprite
		move.w	d3,d6			; and copy it back
		tst.w	d7			; check if we should render more sprite pieces
		bmi.w	@nextobj		; if not, branch

@nomap		move.w	childnum(a0),d3		; get number of child sprites
		subq.w	#1,d3			; sub 1 from it
		blo.w	@nextobj		; if less than 0, branch
		lea	child(a0),a0		; get the child data to a0

@nextsprite	move.w	(a0)+,d0		; get xpos
		move.w	(a0)+,d1		; get ypos
		btst	#2,d6			; is bit 2 of render flags set?
		beq.s	@onscreen2		; if not, branch to draw onscreen as opposed to on level

		sub.w	(a3),d0			; sub camera x from object xpos
		addi.w	#128,d0			; add 128 to relative x
		sub.w	4(a3),d1		; sub camera y from ypos
		addi.w	#128,d1			; add 128 to relative x
		and.w	#$7FF,d1		; and with the Y-wrap value

@onscreen2	addq.w	#1,a0			; skip unused byte
		moveq	#0,d4			; set amount of sprite pieces to 1
		move.b	(a0)+,d4		; get mappings frame
		add.w	d4,d4			; double it

		lea	(a2),a1			; copy mappings address to a1
		adda.w	(a1,d4.w),a1		; get the final sprite position
		move.w	(a1)+,d4		; get sprite piece amount
		subq.w	#1,d4			; sub 1 from the sprite piece amount
		bmi.s	@nextchild		; if negative, there is 0 sprite pieces. skip.

		move.w	d6,-(sp)		; store render flags
		jsr	DrawSpritePiece2(pc)	; render this sprite
		move.w	(sp)+,d6		; get stored render flags

@nextchild	tst.w	d7			; check if we should render more sprite pieces
		dbmi	d3,@nextsprite		; if so, keep looping
		bra.w	@nextobj
; ---------------------------------------------------------------------------
; input:
; d0 = horizontal offset
; d1 = vertical offset
; d4 = amount of sprite pieces
; d5 = art tile
; d6 = render flags
; d7 = sprite pieces left
; a1 = mappings data address
; a6 = sprite attribution table address
; ---------------------------------------------------------------------------

DrawSpritePiece:
		lsr.b	#1,d6
		bcs.s	DrawSpritePiece_FlipX	; branch if X-flipped
		lsr.b	#1,d6
		bcs.w	DrawSpritePiece_FlipY	; branch if only Y-flipped

@dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		add.w	d1,d2			; add y-offset to y-position
		move.w	d2,(a6)+		; put the y-pos to table

		move.b	(a1)+,(a6)+		; copy size to table
		addq.w	#1,a6			; add 1 to the table address (skip empty byte)

		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		add.w	d0,d2			; add x-offset to x-position

		andi.w	#$1FF,d2		; keep in range
		bne.s	@0			; branch if 0?
		addq.w	#1,d2			; add 1 to xpos
@0		move.w	d2,(a6)+		; store x-pos to the table

		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,@dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts
; ---------------------------------------------------------------------------

DrawSpritePiece_FlipX:
		lsr.b	#1,d6
		blo.s	DrawSpritePiece_FlipXY	; branch if XY-flipped

@dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		add.w	d1,d2			; add y-offset to y-position
		move.w	d2,(a6)+		; put the y-pos to table

		move.b	(a1)+,d6		; get sprite size
		move.b	d6,(a6)+		; put it to the table
		addq.w	#1,a6			; add 1 to the table address (skip empty byte)

		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		eori.w	#$800,d2		; flip X-flip bit
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		neg.w	d2			; negate it
		move.b	DrawSprPiece_XOffs(pc,d6.w),d6; get x-offset based on sprite size
		sub.w	d6,d2			; sub the offset from x-pos
		add.w	d0,d2			; add x-offset to x-position

		andi.w	#$1FF,d2		; keep in range
		bne.s	@0			; branch if 0?
		addq.w	#1,d2			; add 1 to xpos
@0		move.w	d2,(a6)+		; store x-pos to the table

		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,@dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts

; ---------------------------------------------------------------------------
DrawSprPiece_XOffs:
	dcb.b 4, $08; 4x $08
	dcb.b 4, $10; 4x $10
	dcb.b 4, $18; 4x $18
	dcb.b 4, $20; 4x $20
; ---------------------------------------------------------------------------

DrawSpritePiece_FlipXY:
@dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		neg.w	d2			; negate it

		move.b	(a1),d6			; get sprite size
		move.b	DrawSprPiece_YOffs(pc,d6.w),d6; get y-offset based on sprite size
		sub.w	d6,d2			; sub the offset from y-pos
		add.w	d1,d2			; add y-offset to y-position
		move.w	d2,(a6)+		; put the y-pos to table

		move.b	(a1)+,d6		; get sprite size
		move.b	d6,(a6)+		; put it to the table
		addq.w	#1,a6			; add 1 to the table address (skip empty byte)

		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		eori.w	#$1800,d2		; flip X-flip and y-flip bits
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		neg.w	d2			; negate it
		move.b	DrawSprPiece_XOffs(pc,d6.w),d6; get x-offset based on sprite size
		sub.w	d6,d2			; sub the offset from x-pos
		add.w	d0,d2			; add x-offset to x-position

		andi.w	#$1FF,d2		; keep in range
		bne.s	@0			; branch if 0?
		addq.w	#1,d2			; add 1 to xpos
@0		move.w	d2,(a6)+		; store x-pos to the table

		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,@dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts

; ---------------------------------------------------------------------------
DrawSprPiece_YOffs:
	rept 4	; 4x $08, $10, $18, $20
		dc.b $08, $10, $18, $20
	endr
; ---------------------------------------------------------------------------

DrawSpritePiece_FlipY:
@dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		neg.w	d2			; negate it
		move.b	(a1)+,d6		; get sprite size
		move.b	d6,2(a6)		; put it to the table

		move.b	DrawSprPiece_YOffs(pc,d6.w),d6; get y-offset based on sprite size
		sub.w	d6,d2			; sub the offset from y-pos
		add.w	d1,d2			; add y-offset to y-position
		move.w	d2,(a6)+		; put the y-pos to table

		addq.w	#2,a6			; add 2 to the table address (skip empty byte and sprite size we saved ealier)
		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		eori.w	#$1000,d2		; flip Y-flip bit
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		add.w	d0,d2			; add x-offset to x-position

		andi.w	#$1FF,d2		; keep in range
		bne.s	@0			; branch if 0?
		addq.w	#1,d2			; add 1 to xpos
@0		move.w	d2,(a6)+		; store x-pos to the table

		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,@dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts
; ---------------------------------------------------------------------------
; input:
; d0 = horizontal offset
; d1 = vertical offset
; d4 = amount of sprite pieces
; d5 = art tile
; d6 = render flags
; d7 = sprite pieces left
; a1 = mappings data address
; a6 = sprite attribution table address
; ---------------------------------------------------------------------------

DrawSpritePiece2:
		lsr.b	#1,d6
		blo.s	DrawSpritePiece2_FlipX	; branch if X-flipped
		lsr.b	#1,d6
		blo.w	DrawSpritePiece2_FlipY	; branch if only Y-flipped

@dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		add.w	d1,d2			; add y-offset to y-position

		cmpi.w	#96,d2
		bls.s	@offscreen		; branch if too high offscreen
		cmpi.w	#352,d2
		bhs.s	@offscreen		; branch if too low offscreen
		move.w	d2,(a6)+		; put the y-pos to table

		move.b	(a1)+,(a6)+		; copy size to table
		addq.w	#1,a6			; add 1 to the table address (skip empty byte)

		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		add.w	d0,d2			; add x-offset to x-position
		cmpi.w	#96,d2
		bls.s	@gobacksprite		; branch if too left offscreen
		cmpi.w	#448,d2
		bhs.s	@gobacksprite		; branch if too right offscreen

		move.w	d2,(a6)+		; store x-pos to the table
		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,@dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts

@gobacksprite	subq.w	#6,a6			; sub 6 from sprite table address, to be overwritten later
		dbf	d4,@dopiece		; loop for rest of the sprites
		rts

@offscreen	addq.w	#5,a1			; skip rest of the mappings data
		dbf	d4,@dopiece		; loop for rest of the sprites
		rts
; ---------------------------------------------------------------------------

DrawSpritePiece2_FlipX:
		lsr.b	#1,d6
		blo.s	DrawSpritePiece2_FlipXY	; branch if XY-flipped

@dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		add.w	d1,d2

		cmpi.w	#96,d2
		bls.s	@offscreen		; branch if too high offscreen
		cmpi.w	#352,d2
		bhs.s	@offscreen		; branch if too low offscreen
		move.w	d2,(a6)+		; put the y-pos to table

		move.b	(a1)+,d6		; get sprite size
		move.b	d6,(a6)+		; put it to the table
		addq.w	#1,a6			; add 1 to the table address (skip empty byte)

		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		eori.w	#$800,d2		; flip X-flip bit
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		neg.w	d2			; negate it
		move.b	DrawSprPiece2_XOffs(pc,d6.w),d6; get x-offset based on sprite size
		sub.w	d6,d2			; sub the offset from x-pos
		add.w	d0,d2			; add x-offset to x-position

		cmpi.w	#96,d2
		bls.s	@gobacksprite		; branch if too left offscreen
		cmpi.w	#448,d2
		bhs.s	@gobacksprite		; branch if too right offscreen
		move.w	d2,(a6)+		; put the y-pos to table

		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,@dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts

@gobacksprite	subq.w	#6,a6			; sub 6 from sprite table address, to be overwritten later
		dbf	d4,@dopiece		; loop for rest of the sprites
		rts

@offscreen	addq.w	#5,a1			; skip rest of the mappings data
		dbf	d4,@dopiece		; loop for rest of the sprites
		rts

; ---------------------------------------------------------------------------
DrawSprPiece2_XOffs:
	dcb.b 4, $08; 4x $08
	dcb.b 4, $10; 4x $10
	dcb.b 4, $18; 4x $18
	dcb.b 4, $20; 4x $20
; ---------------------------------------------------------------------------

DrawSpritePiece2_FlipXY:
@dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		neg.w	d2			; negate it

		move.b	(a1),d6			; get sprite size
		move.b	DrawSprPiece2_YOffs(pc,d6.w),d6; get y-offset based on sprite size
		sub.w	d6,d2			; sub the offset from y-pos
		add.w	d1,d2			; add y-offset to y-position

		cmpi.w	#96,d2
		bls.s	@offscreen		; branch if too high offscreen
		cmpi.w	#352,d2
		bhs.s	@offscreen		; branch if too low offscreen
		move.w	d2,(a6)+		; put the y-pos to table

		move.b	(a1)+,d6		; get sprite size
		move.b	d6,(a6)+		; put it to the table
		addq.w	#1,a6			; add 1 to the table address (skip empty byte)

		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		eori.w	#$1800,d2		; flip X-flip and y-flip bits
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		neg.w	d2			; negate it
		move.b	DrawSprPiece2_XOffs(pc,d6.w),d6; get x-offset based on sprite size
		sub.w	d6,d2			; sub the offset from x-pos
		add.w	d0,d2			; add x-offset to x-position

		cmpi.w	#96,d2
		bls.s	@gobacksprite		; branch if too left offscreen
		cmpi.w	#448,d2
		bhs.s	@gobacksprite		; branch if too right offscreen
		move.w	d2,(a6)+		; put the y-pos to table

		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,@dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts

@gobacksprite	subq.w	#6,a6			; sub 6 from sprite table address, to be overwritten later
		dbf	d4,@dopiece		; loop for rest of the sprites
		rts

@offscreen	addq.w	#5,a1			; skip rest of the mappings data
		dbf	d4,@dopiece		; loop for rest of the sprites
		rts

; ---------------------------------------------------------------------------
DrawSprPiece2_YOffs:
	rept 4	; 4x $08, $10, $18, $20
		dc.b $08, $10, $18, $20
	endr
; ---------------------------------------------------------------------------

DrawSpritePiece2_FlipY:
@dopiece	move.b	(a1)+,d2		; get vertical position
		ext.w	d2			; sign-extend
		neg.w	d2			; negate it
		move.b	(a1)+,d6		; get sprite size
		move.b	d6,2(a6)		; put it to the table

		move.b	DrawSprPiece2_YOffs(pc,d6.w),d6; get y-offset based on sprite size
		sub.w	d6,d2			; sub the offset from y-pos
		add.w	d1,d2			; add y-offset to y-position

		cmpi.w	#96,d2
		bls.s	@offscreen		; branch if too high offscreen
		cmpi.w	#352,d2
		bhs.s	@offscreen		; branch if too low offscreen
		move.w	d2,(a6)+		; put the y-pos to table

		addq.w	#2,a6			; add 2 to the table address (skip empty byte and sprite size we saved ealier)
		move.w	(a1)+,d2		; get art tile for maps
		add.w	d5,d2			; add source art tile
		eori.w	#$1000,d2		; flip Y-flip bit
		move.w	d2,(a6)+		; store it to the table

		move.w	(a1)+,d2		; get horizontal position
		add.w	d0,d2			; add x-offset to x-position
		cmpi.w	#96,d2
		bls.s	@gobacksprite		; branch if too left offscreen
		cmpi.w	#448,d2
		bhs.s	@gobacksprite		; branch if too right offscreen

		move.w	d2,(a6)+		; store x-pos to the table
		subq.w	#1,d7			; sub 1 from the amount of sprite pieces
		dbmi	d4,@dopiece		; if no more sprite pieces to do, end. Else, do rest of the sprite pieces.
		rts

@gobacksprite	subq.w	#6,a6			; sub 6 from sprite table address, to be overwritten later
		dbf	d4,@dopiece		; loop for rest of the sprites
		rts

@offscreen	addq.w	#4,a1			; skip rest of the mappings data
		dbf	d4,@dopiece		; loop for rest of the sprites
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; build hud
; ---------------------------------------------------------------------------

BuildHUD:
HUD:
		lea	Map_HUD(pc),a1
		btst	#3,(v_framebyte).w
		bne.s	@display
		tst.w	v_rings.w	; do you have any rings?
		bne.s	@norings	; if yes, branch
		add.w	#$3E,a1		; increase map

@norings	cmpi.b	#9,(v_timemin).w ; have	9 minutes elapsed?
		bne.s	@display	; if not, branch
		add.w	#$3E*2,a1	; increase map

@display	move.w	#$90,d0
		add.w	HudPos.w,d0	; add hudpos var
		move.w	#$108,d1
		move.w	#$6CA,d5
		move.w	(a1)+,d4
		subq.w	#1,d4
		jmp	DrawSpritePiece(pc)

; ===========================================================================
Map_HUD:
@allyellow:	dc.w $A
		dc.b $80, $D, $80, 0, $00, 0
		dc.b $80, $D, $80, $18, $00,	$20
		dc.b $80, $D, $80, $20, $00,	$40
		dc.b $90, $D, $80, $10, $00,	0
		dc.b $90, $D, $80, $28, $00,	$28
		dc.b $A0, $D, $80, 8, $00, 0
		dc.b $A0, 1, $80, 0, $00, $20
		dc.b $A0, 9, $80, $30, $00, $30
		dc.b $40, 5, $81, $A, $00, 0
		dc.b $40, $D, $81, $E, $00, $10
@ringred:	dc.w $A
		dc.b $80, $D, $80, 0, $00, 0
		dc.b $80, $D, $80, $18, $00,	$20
		dc.b $80, $D, $80, $20, $00,	$40
		dc.b $90, $D, $80, $10, $00,	0
		dc.b $90, $D, $80, $28, $00,	$28
		dc.b $A0, $D, $A0, 8, $00, 0
		dc.b $A0, 1, $A0, 0, $00, $20
		dc.b $A0, 9, $80, $30, $00, $30
		dc.b $40, 5, $81, $A, $00, 0
		dc.b $40, $D, $81, $E, $00, $10
@timered:	dc.w $A
		dc.b $80, $D, $80, 0, $00, 0
		dc.b $80, $D, $80, $18, $00,	$20
		dc.b $80, $D, $80, $20, $00,	$40
		dc.b $90, $D, $A0, $10, $00,	0
		dc.b $90, $D, $80, $28, $00,	$28
		dc.b $A0, $D, $80, 8, $00, 0
		dc.b $A0, 1, $80, 0, $00, $20
		dc.b $A0, 9, $80, $30, $00, $30
		dc.b $40, 5, $81, $A, $00, 0
		dc.b $40, $D, $81, $E, $00, $10
@allred:	dc.w $A
		dc.b $80, $D, $80, 0, $00, 0
		dc.b $80, $D, $80, $18, $00,	$20
		dc.b $80, $D, $80, $20, $00,	$40
		dc.b $90, $D, $A0, $10, $00,	0
		dc.b $90, $D, $80, $28, $00,	$28
		dc.b $A0, $D, $A0, 8, $00, 0
		dc.b $A0, 1, $A0, 0, $00, $20
		dc.b $A0, 9, $80, $30, $00, $30
		dc.b $40, 5, $81, $A, $00, 0
		dc.b $40, $D, $81, $E, $00, $10
; ===========================================================================

		include	"_inc\Achi.asm"
		include	"_incObj\sub ChkObjectVisible.asm"

; ---------------------------------------------------------------------------
; Subroutine to	load a level's objects
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ObjPosLoad:
		moveq	#0,d0
		move.b	(v_opl_routine).w,d0
		move.w	OPL_Index(pc,d0.w),d0
		jmp	OPL_Index(pc,d0.w)
; End of function ObjPosLoad

; ===========================================================================
OPL_Index:	dc.w OPL_Main-OPL_Index
		dc.w OPL_Next-OPL_Index
; ===========================================================================

OPL_Main:
		addq.b	#2,(v_opl_routine).w
		move.w	(v_zone).w,d0
		lsl.b	#6,d0
		lsr.w	#4,d0
		lea	(ObjPos_Index).l,a0
		movea.l	a0,a1
		adda.w	(a0,d0.w),a0
		move.l	a0,(v_opl_data).w
		move.l	a0,(v_opl_data+4).w
		adda.w	2(a1,d0.w),a1
		move.l	a1,(v_opl_data+8).w
		move.l	a1,(v_opl_data+$C).w
		lea	(v_objstate).w,a2
		move.w	#$101,(a2)+
		move.w	#$5E,d0

OPL_ClrList:
		clr.l	(a2)+
		dbf	d0,OPL_ClrList	; clear	pre-destroyed object list

		lea	(v_objstate).w,a2
		moveq	#0,d2
		move.w	(v_screenposx).w,d6
		subi.w	#$80,d6
		bhs.s	loc_D93C
		moveq	#0,d6

loc_D93C:
		andi.w	#$FF80,d6
		movea.l	(v_opl_data).w,a0

loc_D944:
		cmp.w	(a0),d6
		bls.s	loc_D956
		tst.b	4(a0)
		bpl.s	loc_D952
		move.b	(a2),d2
		addq.b	#1,(a2)

loc_D952:
		addq.w	#6,a0
		bra.s	loc_D944
; ===========================================================================

loc_D956:
		move.l	a0,(v_opl_data).w
		movea.l	(v_opl_data+4).w,a0
		subi.w	#$80,d6
		blo.s	loc_D976

loc_D964:
		cmp.w	(a0),d6
		bls.s	loc_D976
		tst.b	4(a0)
		bpl.s	loc_D972
		addq.b	#1,1(a2)

loc_D972:
		addq.w	#6,a0
		bra.s	loc_D964
; ===========================================================================

loc_D976:
		move.l	a0,(v_opl_data+4).w
		move.w	#-1,(v_opl_screen).w

OPL_Next:
		lea	(v_objstate).w,a2
		moveq	#0,d2
		move.w	(v_screenposx).w,d6
		andi.w	#$FF80,d6
		cmp.w	(v_opl_screen).w,d6
		beq.w	locret_DA3A
		bge.s	loc_D9F6
		move.w	d6,(v_opl_screen).w
		movea.l	(v_opl_data+4).w,a0
		subi.w	#$80,d6
		blo.s	loc_D9D2

loc_D9A6:
		cmp.w	-6(a0),d6
		bge.s	loc_D9D2
		subq.w	#6,a0
		tst.b	4(a0)
		bpl.s	loc_D9BC
		subq.b	#1,1(a2)
		move.b	1(a2),d2

loc_D9BC:
		bsr.w	loc_DA3C
		bne.s	loc_D9C6
		subq.w	#6,a0
		bra.s	loc_D9A6
; ===========================================================================

loc_D9C6:
		tst.b	4(a0)
		bpl.s	loc_D9D0
		addq.b	#1,1(a2)

loc_D9D0:
		addq.w	#6,a0

loc_D9D2:
		move.l	a0,(v_opl_data+4).w
		movea.l	(v_opl_data).w,a0
		addi.w	#$300,d6

loc_D9DE:
		cmp.w	-6(a0),d6
		bgt.s	loc_D9F0
		tst.b	-2(a0)
		bpl.s	loc_D9EC
		subq.b	#1,(a2)

loc_D9EC:
		subq.w	#6,a0
		bra.s	loc_D9DE
; ===========================================================================

loc_D9F0:
		move.l	a0,(v_opl_data).w
		rts
; ===========================================================================

loc_D9F6:
		move.w	d6,(v_opl_screen).w
		movea.l	(v_opl_data).w,a0
		addi.w	#$280,d6

loc_DA02:
		cmp.w	(a0),d6
		bls.s	loc_DA16
		tst.b	4(a0)
		bpl.s	loc_DA10
		move.b	(a2),d2
		addq.b	#1,(a2)

loc_DA10:
		bsr.w	loc_DA3C
		beq.s	loc_DA02

loc_DA16:
		move.l	a0,(v_opl_data).w
		movea.l	(v_opl_data+4).w,a0
		subi.w	#$300,d6
		blo.s	loc_DA36

loc_DA24:
		cmp.w	(a0),d6
		bls.s	loc_DA36
		tst.b	4(a0)
		bpl.s	loc_DA32
		addq.b	#1,1(a2)

loc_DA32:
		addq.w	#6,a0
		bra.s	loc_DA24
; ===========================================================================

loc_DA36:
		move.l	a0,(v_opl_data+4).w

locret_DA3A:
		rts
; ===========================================================================

loc_DA3C:
		tst.b	4(a0)
		bpl.s	OPL_MakeItem
		bset	#7,2(a2,d2.w)
		beq.s	OPL_MakeItem
		addq.w	#6,a0
		moveq	#0,d0
		rts
; ===========================================================================

OPL_MakeItem:
		move.l	a2,-(sp)
		bsr.w	FindFreeObj
	;	bpl.s	locret_DA8A_
		move.l	(sp)+,a2
		move.w	(a0)+,obX(a1)
		move.w	(a0)+,d0
		move.w	d0,d1
		andi.w	#$FFF,d0
		move.w	d0,obY(a1)
		rol.w	#2,d1
		andi.b	#3,d1
		move.b	d1,obRender(a1)
		move.b	d1,obStatus(a1)

		moveq	#0,d0
		move.b	(a0)+,d0
		bpl.s	loc_DA80
		andi.b	#$7F,d0
		move.b	d2,obRespawnNo(a1)

loc_DA80:
		add.w	d0,d0
		add.w	d0,d0
		move.l	Obj_Index-4(pc,d0.w),(a1)
		move.b	(a0)+,obSubtype(a1)
		moveq	#0,d0

locret_DA8A:
		rts

locret_DA8A_:
;		move.l	(sp)+,a2
;		rts
Obj_Index:
		include	"_inc\Object Pointers.asm"

		include	"_incObj\sub FindFreeObj.asm"
		include	"_incObj\41 Springs.asm"
		include	"_anim\Springs.asm"
		include	"_maps\Springs.asm"

		include	"_incObj\42 Newtron.asm"
		include	"_anim\Newtron.asm"
		include	"_maps\Newtron.asm"

		include	"_incObj\44 GHZ Edge Walls.asm"
		include	"_maps\GHZ Edge Walls.asm"

		include	"_incObj\0D Signpost.asm" ; includes "GotThroughAct" subroutine
		include	"_anim\Signpost.asm"
		include	"_maps\Signpost.asm"

		include	"_incObj\40 Moto Bug.asm" ; includes "_incObj\sub RememberState.asm"
		include	"_anim\Moto Bug.asm"
		include	"_maps\Moto Bug.asm"

		include	"_incObj\sub SolidObject.asm"
		include	"_maps\Big Spiked Ball.asm"

		include	"_incObj\71 Invisible Barriers.asm"
		include	"_maps\Invisible Barriers.asm"
		include	"_incObj\5F Bomb Enemy.asm"
		include	"_anim\Bomb Enemy.asm"
		include	"_maps\Bomb Enemy.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Object 01 - Sonic
; ---------------------------------------------------------------------------

SonicPlayer:
		tst.w	(v_debuguse).w	; is debug mode	being used?
		beq.s	Sonic_Normal	; if not, branch
		jsr	(DebugMode).l
		move.w	#CollisionList+2,CollisionList.w; reset list pos
	NEXT_OBJ					; next object
; ===========================================================================

Sonic_Normal:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Sonic_Index(pc,d0.w),d1
		jsr	Sonic_Index(pc,d1.w)

ObjClearCollResp:
		move.w	#CollisionList+2,CollisionList.w; reset list pos

ObjNull:
	NEXT_OBJ					; next object
; ===========================================================================
Sonic_Index:	dc.w Sonic_Main-Sonic_Index
		dc.w Sonic_Control-Sonic_Index
		dc.w Sonic_Hurt-Sonic_Index
		dc.w Sonic_Death-Sonic_Index
		dc.w Sonic_ResetLevel-Sonic_Index
; ===========================================================================

Sonic_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Sonic,obMap(a0)
		move.w	#vram_sonic/32,obGfx(a0)
	display		2, a0			; display

		move.b	#$18,obActWid(a0)
		move.b	#4,obRender(a0)
		move.b	#$13,obHeight(a0)
		move.b	#9,obWidth(a0)

		move.w	#$600,(v_sonspeedmax).w ; Sonic's top speed
		move.w	#$C,(v_sonspeedacc).w ; Sonic's acceleration
		move.w	#$80,(v_sonspeeddec).w ; Sonic's deceleration

Sonic_Control:	; Routine 2
		sf	featurectr.w	; no features here
		tst.w	(f_debugmode).w	; is debug cheat enabled?
		beq.s	loc_12C58	; if not, branch
		btst	#bitB,(v_jpadpress1).w ; is button B pressed?
		beq.s	loc_12C58	; if not, branch
		move.w	#1,(v_debuguse).w ; change Sonic into a ring/item
		clr.b	(f_lockctrl).w
		rts
; ===========================================================================

loc_12C58:
		tst.b	(f_lockctrl).w	; are controls locked?
		bne.s	loc_12C64	; if yes, branch
		move.w	(v_jpadhold1).w,(v_jpadhold2).w ; enable joypad control

loc_12C64:
		btst	#0,(f_lockmulti).w ; are controls locked?
		bne.s	loc_12C7E	; if yes, branch
		moveq	#0,d0
		move.b	obStatus(a0),d0
		andi.w	#6,d0
		move.w	Sonic_Modes(pc,d0.w),d1
		jsr	Sonic_Modes(pc,d1.w)

loc_12C7E:
		bsr.s	Sonic_Display
		bsr.w	Sonic_RecordPosition
		bsr.w	Sonic_Water
		move.b	(v_anglebuffer).w,$36(a0)
		move.b	($FFFFF76A).w,$37(a0)
		tst.b	(f_wtunnelmode).w
		beq.s	loc_12CA6
		tst.b	obAnim(a0)
		bne.s	loc_12CA6
		move.b	obNextAni(a0),obAnim(a0)

loc_12CA6:
		bsr.w	Sonic_Animate
		tst.b	(f_lockmulti).w
		bmi.s	loc_12CB6
		jsr	(ReactToItem).l

loc_12CB6:
		bsr.w	Sonic_Loops
		bra.w	Sonic_LoadGfx
; ===========================================================================
Sonic_Modes:	dc.w Sonic_MdNormal-Sonic_Modes
		dc.w Sonic_MdJump-Sonic_Modes
		dc.w Sonic_MdRoll-Sonic_Modes
		dc.w Sonic_MdJump2-Sonic_Modes

		include	"_incObj\Sonic Display.asm"
		include	"_incObj\Sonic RecordPosition.asm"
		include	"_incObj\Sonic Water.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Modes	for controlling	Sonic
; ---------------------------------------------------------------------------

Sonic_MdNormal:
		move.w	#AirCount,airctr.w
		bsr.w	Sonic_Jump
		bsr.w	Sonic_SlopeResist
		bsr.w	Sonic_Move
		bsr.w	Sonic_Roll
		bsr.w	Sonic_LevelBound
		jsr	(SpeedToPos).l
		bsr.w	Sonic_AnglePos
		bra.w	Sonic_SlopeRepel
; ===========================================================================

Sonic_MdJump:
	ac	ac_WalkAir,a6
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_JumpDirection
		bsr.w	Sonic_LevelBound
		jsr	(ObjectFall).l
		btst	#6,obStatus(a0)
		beq.s	loc_12E5C
		subi.w	#$28,obVelY(a0)

loc_12E5C:
		subq.w	#1,airctr.w
		bne.s	@noair
	ac	ac_Airtime,a6

@noair		bsr.w	Sonic_JumpAngle
		bra.w	Sonic_Floor
; ===========================================================================

Sonic_MdRoll:
		move.w	#AirCount,airctr.w
		bsr.w	Sonic_Jump
		bsr.w	Sonic_RollRepel
		bsr.w	Sonic_RollSpeed
		bsr.w	Sonic_LevelBound
		jsr	(SpeedToPos).l
		bsr.w	Sonic_AnglePos
		bra.w	Sonic_SlopeRepel
; ===========================================================================

Sonic_MdJump2:
		bsr.w	Sonic_JumpHeight
		bsr.w	Sonic_JumpDirection
		bsr.w	Sonic_LevelBound
		jsr	(ObjectFall).l
		btst	#6,obStatus(a0)
		beq.s	loc_12EA6
		subi.w	#$28,obVelY(a0)

loc_12EA6:
		subq.w	#1,airctr.w
		bne.s	@noair
	ac	ac_Airtime,a6

@noair		bsr.w	Sonic_JumpAngle
		bra.w	Sonic_Floor

		include	"_incObj\Sonic Move.asm"
		include	"_incObj\Sonic RollSpeed.asm"
		include	"_incObj\Sonic JumpDirection.asm"

		include	"_incObj\Sonic LevelBound.asm"
		include	"_incObj\Sonic Roll.asm"
		include	"_incObj\Sonic Jump.asm"
		include	"_incObj\Sonic JumpHeight.asm"
		include	"_incObj\Sonic SlopeResist.asm"
		include	"_incObj\Sonic RollRepel.asm"
		include	"_incObj\Sonic SlopeRepel.asm"
		include	"_incObj\Sonic JumpAngle.asm"
		include	"_incObj\Sonic Floor.asm"
		include	"_incObj\Sonic ResetOnFloor.asm"
		include	"_incObj\Sonic (part 2).asm"
		include	"_incObj\Sonic Loops.asm"
		include	"_incObj\Sonic Animate.asm"
		include	"_anim\Sonic.asm"
		include	"_incObj\Sonic LoadGfx.asm"

ResumeMusic:
		include	"_incObj\38 Shield and Invincibility.asm"
		include	"_anim\Shield and Invincibility.asm"
		include	"_maps\Shield and Invincibility.asm"

		include	"_incObj\Sonic AnglePos.asm"

		include	"_incObj\sub FindNearestTile.asm"
		include	"_incObj\sub FindFloor.asm"
		include	"_incObj\sub FindWall.asm"

; ---------------------------------------------------------------------------
; Unused floor/wall subroutine - logs something	to do with collision
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


FloorLog_Unk:
		rts

		lea	(CollArray1).l,a1
		lea	(CollArray1).l,a2
		move.w	#$FF,d3

loc_14C5E:
		moveq	#$10,d5
		move.w	#$F,d2

loc_14C64:
		moveq	#0,d4
		move.w	#$F,d1

loc_14C6A:
		move.w	(a1)+,d0
		lsr.l	d5,d0
		addx.w	d4,d4
		dbf	d1,loc_14C6A

		move.w	d4,(a2)+
		suba.w	#$20,a1
		subq.w	#1,d5
		dbf	d2,loc_14C64

		adda.w	#$20,a1
		dbf	d3,loc_14C5E

		lea	(CollArray1).l,a1
		lea	(CollArray2).l,a2
		bsr.s	FloorLog_Unk2
		lea	(CollArray1).l,a1
		lea	(CollArray1).l,a2

; End of function FloorLog_Unk

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


FloorLog_Unk2:
		move.w	#$FFF,d3

loc_14CA6:
		moveq	#0,d2
		move.w	#$F,d1
		move.w	(a1)+,d0
		beq.s	loc_14CD4
		bmi.s	loc_14CBE

loc_14CB2:
		lsr.w	#1,d0
		bhs.s	loc_14CB8
		addq.b	#1,d2

loc_14CB8:
		dbf	d1,loc_14CB2

		bra.s	loc_14CD6
; ===========================================================================

loc_14CBE:
		cmpi.w	#-1,d0
		beq.s	loc_14CD0

loc_14CC4:
		lsl.w	#1,d0
		bhs.s	loc_14CCA
		subq.b	#1,d2

loc_14CCA:
		dbf	d1,loc_14CC4

		bra.s	loc_14CD6
; ===========================================================================

loc_14CD0:
		move.w	#$10,d0

loc_14CD4:
		move.w	d0,d2

loc_14CD6:
		move.b	d2,(a2)+
		dbf	d3,loc_14CA6

		rts

; End of function FloorLog_Unk2


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_WalkSpeed:
		move.l	obX(a0),d3
		move.l	obY(a0),d2
		move.w	obVelX(a0),d1
		ext.l	d1
		asl.l	#8,d1
		add.l	d1,d3
		move.w	obVelY(a0),d1
		ext.l	d1
		asl.l	#8,d1
		add.l	d1,d2
		swap	d2
		swap	d3
		move.b	d0,(v_anglebuffer).w
		move.b	d0,($FFFFF76A).w
		move.b	d0,d1
		addi.b	#$20,d0
		bpl.s	loc_14D1A
		move.b	d1,d0
		bpl.s	loc_14D14
		subq.b	#1,d0

loc_14D14:
		addi.b	#$20,d0
		bra.s	loc_14D24
; ===========================================================================

loc_14D1A:
		move.b	d1,d0
		bpl.s	loc_14D20
		addq.b	#1,d0

loc_14D20:
		addi.b	#$1F,d0

loc_14D24:
		andi.b	#$C0,d0
		beq.w	loc_14DF0
		cmpi.b	#$80,d0
		beq.w	loc_14F7C
		andi.b	#$38,d1
		bne.s	loc_14D3C
		addq.w	#8,d2

loc_14D3C:
		cmpi.b	#$40,d0
		beq.w	loc_1504A
		bra.w	loc_14EBC

; End of function Sonic_WalkSpeed


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_14D48:
		move.b	d0,(v_anglebuffer).w
		move.b	d0,($FFFFF76A).w
		addi.b	#$20,d0
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	loc_14FD6
		cmpi.b	#$80,d0
		beq.w	Sonic_DontRunOnWalls
		cmpi.b	#$C0,d0
		beq.w	sub_14E50

; End of function sub_14D48

; ---------------------------------------------------------------------------
; Subroutine to	make Sonic land	on the floor after jumping
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_HitFloor:
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obHeight(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	obWidth(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(v_anglebuffer).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$D,d5
		bsr.w	FindFloor
		move.w	d1,-(sp)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obHeight(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	obWidth(a0),d0
		ext.w	d0
		sub.w	d0,d3
		lea	($FFFFF76A).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$D,d5
		bsr.w	FindFloor
		move.w	(sp)+,d0
		move.b	#0,d2

loc_14DD0:
		move.b	($FFFFF76A).w,d3
		cmp.w	d0,d1
		ble.s	loc_14DDE
		move.b	(v_anglebuffer).w,d3
		exg	d0,d1

loc_14DDE:
		btst	#0,d3
		beq.s	locret_14DE6
		move.b	d2,d3

locret_14DE6:
		rts

; End of function Sonic_HitFloor

; ===========================================================================
		move.w	obY(a0),d2
		move.w	obX(a0),d3

loc_14DF0:
		addi.w	#$A,d2
		lea	(v_anglebuffer).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$E,d5
		bsr.w	FindFloor
		move.b	#0,d2

loc_14E0A:
		move.b	(v_anglebuffer).w,d3
		btst	#0,d3
		beq.s	locret_14E16
		move.b	d2,d3

locret_14E16:
		rts

		include	"_incObj\sub ObjFloorDist.asm"


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_14E50:
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obWidth(a0),d0
		ext.w	d0
		sub.w	d0,d2
		move.b	obHeight(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(v_anglebuffer).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.w	d1,-(sp)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obWidth(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	obHeight(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	($FFFFF76A).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.w	(sp)+,d0
		move.b	#-$40,d2
		bra.w	loc_14DD0

; End of function sub_14E50


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


sub_14EB4:
		move.w	obY(a0),d2
		move.w	obX(a0),d3

loc_14EBC:
		addi.w	#$A,d3
		lea	(v_anglebuffer).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.b	#-$40,d2
		bra.w	loc_14E0A

; End of function sub_14EB4

; ---------------------------------------------------------------------------
; Subroutine to	detect when an object hits a wall to its right
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ObjHitWallRight:
		add.w	obX(a0),d3
		move.w	obY(a0),d2
		lea	(v_anglebuffer).w,a4
		move.b	#0,(a4)
		movea.w	#$10,a3
		move.w	#0,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.b	(v_anglebuffer).w,d3
		btst	#0,d3
		beq.s	locret_14F06
		move.b	#-$40,d3

locret_14F06:
		rts

; End of function ObjHitWallRight

; ---------------------------------------------------------------------------
; Subroutine preventing	Sonic from running on walls and	ceilings when he
; touches them
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_DontRunOnWalls:
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obHeight(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		move.b	obWidth(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(v_anglebuffer).w,a4
		movea.w	#-$10,a3
		move.w	#$1000,d6
		moveq	#$E,d5
		bsr.w	FindFloor
		move.w	d1,-(sp)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obHeight(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		move.b	obWidth(a0),d0
		ext.w	d0
		sub.w	d0,d3
		lea	($FFFFF76A).w,a4
		movea.w	#-$10,a3
		move.w	#$1000,d6
		moveq	#$E,d5
		bsr.w	FindFloor
		move.w	(sp)+,d0
		move.b	#-$80,d2
		bra.w	loc_14DD0
; End of function Sonic_DontRunOnWalls

; ===========================================================================
		move.w	obY(a0),d2
		move.w	obX(a0),d3

loc_14F7C:
		subi.w	#$A,d2
		eori.w	#$F,d2
		lea	(v_anglebuffer).w,a4
		movea.w	#-$10,a3
		move.w	#$1000,d6
		moveq	#$E,d5
		bsr.w	FindFloor
		move.b	#-$80,d2
		bra.w	loc_14E0A

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ObjHitCeiling:
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obHeight(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		lea	(v_anglebuffer).w,a4
		movea.w	#-$10,a3
		move.w	#$1000,d6
		moveq	#$E,d5
		bsr.w	FindFloor
		move.b	(v_anglebuffer).w,d3
		btst	#0,d3
		beq.s	locret_14FD4
		move.b	#-$80,d3

locret_14FD4:
		rts
; End of function ObjHitCeiling

; ===========================================================================

loc_14FD6:
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obWidth(a0),d0
		ext.w	d0
		sub.w	d0,d2
		move.b	obHeight(a0),d0
		ext.w	d0
		sub.w	d0,d3
		eori.w	#$F,d3
		lea	(v_anglebuffer).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.w	d1,-(sp)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obWidth(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	obHeight(a0),d0
		ext.w	d0
		sub.w	d0,d3
		eori.w	#$F,d3
		lea	($FFFFF76A).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.w	(sp)+,d0
		move.b	#$40,d2
		bra.w	loc_14DD0

; ---------------------------------------------------------------------------
; Subroutine to	stop Sonic when	he jumps at a wall
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_HitWall:
		move.w	obY(a0),d2
		move.w	obX(a0),d3

loc_1504A:
		subi.w	#$A,d3
		eori.w	#$F,d3
		lea	(v_anglebuffer).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.b	#$40,d2
		bra.w	loc_14E0A
; End of function Sonic_HitWall

; ---------------------------------------------------------------------------
; Subroutine to	detect when an object hits a wall to its left
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ObjHitWallLeft:
		add.w	obX(a0),d3
		move.w	obY(a0),d2
		; Engine bug: colliding with left walls is erratic with this function.
		; The cause is this: a missing instruction to flip collision on the found
		; 16x16 block; this one:
		eori.w	#$F,d3
		lea	(v_anglebuffer).w,a4
		move.b	#0,(a4)
		movea.w	#-$10,a3
		move.w	#$800,d6
		moveq	#$E,d5
		bsr.w	FindWall
		move.b	(v_anglebuffer).w,d3
		btst	#0,d3
		beq.s	locret_15098
		move.b	#$40,d3

locret_15098:
		rts

off_164A6:	dc.w word_164B2-off_164A6, word_164C6-off_164A6, word_164DA-off_164A6
		dc.w word_164EE-off_164A6, word_16502-off_164A6, word_16516-off_164A6
word_164B2:	dc.w $10, $E80,	$E14, $370, $EEF, $302,	$EEF, $340, $E14, $3AE
word_164C6:	dc.w $10, $F80,	$F14, $2E0, $FEF, $272,	$FEF, $2B0, $F14, $31E
word_164DA:	dc.w $10, $1080, $1014,	$270, $10EF, $202, $10EF, $240,	$1014, $2AE
word_164EE:	dc.w $10, $F80,	$F14, $570, $FEF, $502,	$FEF, $540, $F14, $5AE
word_16502:	dc.w $10, $1B80, $1B14,	$670, $1BEF, $602, $1BEF, $640,	$1B14, $6AE
word_16516:	dc.w $10, $1C80, $1C14,	$5E0, $1CEF, $572, $1CEF, $5B0,	$1C14, $61E
; ===========================================================================

		include	"_incObj\01 Easter Egg.asm"
		include	"_incObj\79 Lamppost.asm"
		include	"_maps\Lamppost.asm"
		include	"_incObj\7D Hidden Bonuses.asm"
		include	"_maps\Hidden Bonuses.asm"

		include	"_incObj\shoe.asm"
		include	"_incObj\3D Boss - Green Hill (part 1).asm"
; ---------------------------------------------------------------------------
; Defeated boss	subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


BossDefeated:
		move.b	(v_vbla_byte).w,d0
		andi.b	#7,d0
		bne.s	locret_178A2
		jsr	(FindFreeObj).l
	;	bpl.s	locret_178A2
		move.l	#ExplosionBomb,(a1)	; load explosion object
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		jsr	(RandomNumber).l
		move.w	d0,d1
		moveq	#0,d1
		move.b	d0,d1
		lsr.b	#2,d1
		subi.w	#$20,d1
		add.w	d1,obX(a1)
		lsr.w	#8,d0
		lsr.b	#3,d0
		add.w	d0,obY(a1)

locret_178A2:
		rts
; End of function BossDefeated

; ---------------------------------------------------------------------------
; Subroutine to	move a boss
; ---------------------------------------------------------------------------

Shoe_SnapAngle:
		move.w	BossTgtX(a0),d1		; get target xpos
		move.w	BossTgtY(a0),d2		; and target ypos
		sub.w	BossX(a0),d1		; sub bosses pos
		sub.w	BossY(a0),d2		; sub bosses pos
		jsr	CalcAngle		; get target angle
		move.b	d0,obAngle(a0)		; set angle
		rts

ShoeHomeTo:
		move.w	v_player+ObX.w,d1	; get target xpos
		move.w	v_player+ObY.w,d2	; and target ypos
		sub.w	BossX(a0),d1		; sub bosses pos
		sub.w	BossY(a0),d2		; sub bosses pos
		jsr	CalcAngle		; get target angle
		bra.s	ShoeMove_

ShoeMove:
		move.w	BossTgtX(a0),d1		; get target xpos
		move.w	BossTgtY(a0),d2		; and target ypos
		sub.w	BossX(a0),d1		; sub bosses pos
		sub.w	BossY(a0),d2		; sub bosses pos
		jsr	CalcAngle		; get target angle

		move.b	obAngle(a0),d1		; get angle
		exg	d1,d0			; swap d0 and d1
		move.w	#$260,d2		; get angle speed

		sub.b	d0,d1			; compare
		beq.s	ShoeMove_		; if same, branch
		bpl.s	@notneg			; if positive, branch

		neg.w	d2			; positive to negative
@notneg		add.w	d2,obAngle(a0)		; add to current angle

ShoeMove_:
		jsr	CalcSine		; get sine

		move.w	BossSpeed(a0),d5	; get speed

		muls.w	d5,d1			; mult sine
		asr.l	#8,d1			; keep in reasonable range
		move.w	d1,obVelX(a0)		; towards sonic

		add.w	#$40,d1			; add $40 to velocity
		cmp.w	#$80,d1			; check if velocity is small
		blo.s	@n			; if is, branch

		bclr	#0,ObStatus(a0)		; change boss to left
		tst.w	d1			; check speed
		bmi.s	@n			; if negative, done
		bset	#0,ObStatus(a0)		; change boss to right

@n		muls.w	d5,d0			; mult cosine
		asr.l	#8,d0			; keep in reasonable range
		move.w	d0,obVelY(a0)		; towards sonic

BossMove:
		move.l	BossX(a0),d2
		move.l	BossY(a0),d3
		move.w	obVelX(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d2
		move.w	obVelY(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d3
		move.l	d2,BossX(a0)
		move.l	d3,BossY(a0)
		rts

; ===========================================================================

		include	"_incObj\3D Boss - Green Hill (part 2).asm"
		include	"_incObj\48 Eggman's Swinging Ball.asm"
		include	"_anim\Eggman.asm"
		include	"_maps\Eggman.asm"
		include	"_maps\Boss Items.asm"

Obj7A_Delete:
loc_1982C:
		jmp	(DeleteObject).l

		include	"_incObj\3E Prison Capsule.asm"
		include	"_anim\Prison Capsule.asm"
		include	"_maps\Prison Capsule.asm"

		include	"_incObj\sub ReactToItem.asm"

		include	"_incObj\10.asm"

		include	"_inc\AnimateLevelGfx.asm"

; ---------------------------------------------------------------------------
; Add points subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


AddPoints:
		move.b	#1,(f_scorecount).w ; set score counter to update

			lea     (v_score).w,a3
			add.l   d0,(a3)
			move.l  #999999,d1
			cmp.l   (a3),d1 ; is score below 999999?
			bhi.s   @belowmax ; if yes, branch
			move.l  d1,(a3) ; reset score to 999999
		@belowmax:
			move.l  (a3),d0
			cmp.l   (v_scorelife).w,d0 ; has Sonic got 50000+ points?
			blo.s   @noextralife ; if not, branch

			addi.l  #5000,(v_scorelife).w ; increase requirement by 50000
			tst.b   (v_megadrive).w
			bmi.s   @noextralife ; branch if Mega Drive is Japanese
			addq.b  #1,(v_lives).w ; give extra life
			addq.b  #1,(f_lifecount).w
			music	Mus_Egor,1,0,0

@locret_1C6B6:
@noextralife:
		rts
; End of function AddPoints

		include	"_inc\HUD_Update.asm"

; ---------------------------------------------------------------------------
; Subroutine to	load countdown numbers on the continue screen
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ContScrCounter:
		locVRAM	$DF80
		lea	(vdp_data_port).l,a6
		lea	(Hud_10).l,a2
		moveq	#1,d6
		moveq	#0,d4
		lea	Art_Hud(pc),a1 ; load numbers patterns

ContScr_Loop:
		moveq	#0,d2
		move.l	(a2)+,d3

loc_1C95A:
		sub.l	d3,d1
		blo.s	loc_1C962
		addq.w	#1,d2
		bra.s	loc_1C95A
; ===========================================================================

loc_1C962:
		add.l	d3,d1
		lsl.w	#6,d2
		lea	(a1,d2.w),a3
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		dbf	d6,ContScr_Loop	; repeat 1 more	time

		rts
; End of function ContScrCounter

; ===========================================================================

		include	"_inc\HUD (part 2).asm"

Art_Hud:	incbin	"artunc\HUD Numbers.bin" ; 8x16 pixel numbers on HUD
		even
Art_LivesNums:	incbin	"artunc\Lives Counter Numbers.bin" ; 8x8 pixel numbers on lives counter
		even

		include	"_inc\FanFic.asm"
		include	"_incObj\DebugMode.asm"
		include	"_inc\DebugList.asm"
		include	"_inc\LevelHeaders.asm"
		include	"_inc\Pattern Load Cues.asm"

Nem_SegaLogo:	incbin	"artnem\Sega Logo (JP1).kosm" ; large Sega logo
		even
Eni_SegaLogo:	incbin	"tilemaps\Sega Logo (JP1).bin" ; large Sega logo (mappings)
		even
Eni_Title:	incbin	"tilemaps\Title Screen.bin" ; title screen foreground (mappings)
		even
Nem_TitleFg:	incbin	"artnem\Title Screen Foreground.kosm"
		even
Nem_TitleSonic:	incbin	"artnem\Title Screen Sonic.kosm"
		even
Nem_TitleTM:	incbin	"artnem\Title Screen TM.kosm"
		even

		include	"_maps\Sonic.asm"
		sonicdynplc:
		include	"_maps - Copy\Sonic - Dynamic Gfx Script.asm"

; ---------------------------------------------------------------------------
; Uncompressed graphics	- Sonic
; ---------------------------------------------------------------------------
Art_Sonic:	incbin	"artunc\Sonic.bin"	; Sonic
		even
; ---------------------------------------------------------------------------
; Compressed graphics - various
; ---------------------------------------------------------------------------
Nem_Shield:	incbin	"artnem\Shield.unc"
		even
Nem_Stars:	incbin	"artnem\Invincibility Stars.unc"
		even
Unc_Cross:	incbin "artunc/cross.unc"
Unc_Egg:	incbin "artunc/egg.unc"

; ---------------------------------------------------------------------------
; Compressed graphics - GHZ stuff
; ---------------------------------------------------------------------------
Nem_Stalk:	incbin	"artnem\GHZ Flower Stalk.kosm"
		even
Nem_Swing:	incbin	"artnem\GHZ Swinging Platform.kosm"
		even
Nem_Bridge:	incbin	"artnem\GHZ Bridge.kosm"
		even
Nem_Ball:	incbin	"artnem\GHZ Giant Ball.kosm"
		even
Nem_Spikes:	incbin	"artnem\Spikes.kosm"
		even
Nem_SpikePole:	incbin	"artnem\GHZ Spiked Log.kosm"
		even
Nem_PplRock:	incbin	"artnem\GHZ Purple Rock.kosm"
		even
Nem_GhzWall1:	incbin	"artnem\GHZ Breakable Wall.kosm"
		even
Nem_GhzWall2:	incbin	"artnem\GHZ Edge Wall.kosm"
		even
; ---------------------------------------------------------------------------
; Compressed graphics - enemies
; ---------------------------------------------------------------------------
Nem_Crabmeat:	incbin	"artnem\Enemy Crabmeat.kosm"
		even
Nem_Buzz:	incbin	"artnem\Enemy Buzz Bomber.kosm"
		even
Nem_Chopper:	incbin	"artnem\Enemy Chopper.kosm"
		even
Nem_Motobug:	incbin	"artnem\Enemy Motobug.kosm"
		even
Nem_Newtron:	incbin	"artnem\Enemy Newtron.kosm"
		even
Nem_Bomb:	incbin	"artnem\Enemy Bomb.kosm"
		even
; ---------------------------------------------------------------------------
; Compressed graphics - various
; ---------------------------------------------------------------------------
Nem_TitleCard:	incbin	"artnem\Title Cards.kosm"
		even
Nem_Hud:	incbin	"artnem\HUD.kosm"	; HUD (rings, time, score)
		even
Nem_Lives:	incbin	"artnem\HUD - Life Counter Icon.kosm"
		even
Nem_Ring:	incbin	"artnem\Rings.kosm"
		even
Nem_Monitors:	incbin	"artnem\Monitors.kosm"
		even
Nem_Explode:	incbin	"artnem\Explosion.kosm"
		even
Nem_Points:	incbin	"artnem\Points.kosm"	; points from destroyed enemy or object
		even
Nem_GameOver:	incbin	"artnem\Game Over.kosm"	; game over / time over
		even
Nem_HSpring:	incbin	"artnem\Spring Horizontal.kosm"
		even
Nem_VSpring:	incbin	"artnem\Spring Vertical.kosm"
		even
Nem_SignPost:	incbin	"artnem\Signpost.kosm"	; end of level signpost
		even
Nem_Lamp:	incbin	"artnem\Lamppost.kosm"
		even
Nem_BigFlash:	incbin	"artnem\Giant Ring Flash.kosm"
		even
Nem_Bonus:	incbin	"artnem\Hidden Bonuses.kosm" ; hidden bonuses at end of a level
		even
Nem_Shoe:	incbin	"artunc\Shoe.kosm"
		even
Unc_Armor:	incbin	"artunc\armor.unc"
		even
; ---------------------------------------------------------------------------
; Compressed graphics - animals
; ---------------------------------------------------------------------------
Nem_Rabbit:	incbin	"artnem\Animal Rabbit.kosm"
		even
Nem_Chicken:	incbin	"artnem\Animal Chicken.kosm"
		even
Nem_BlackBird:	incbin	"artnem\Animal Blackbird.kosm"
		even
Nem_Seal:	incbin	"artnem\Animal Seal.kosm"
		even
Nem_Pig:	incbin	"artnem\Animal Pig.kosm"
		even
Nem_Flicky:	incbin	"artnem\Animal Flicky.kosm"
		even
Nem_Squirrel:	incbin	"artnem\Animal Squirrel.kosm"
		even
	incbin "_inc/bam/soup.asm"
	even
	incbin "_inc/bam/hyDTqJo.png"
	even
; ---------------------------------------------------------------------------
; Compressed graphics - primary patterns and block mappings
; ---------------------------------------------------------------------------
Blk16_GHZ:	incbin	"map16\GHZ.unc"
		even
Nem_GHZ_1st:	incbin	"artnem\8x8 - GHZ1.kosm"	; GHZ primary patterns
		even
Nem_GHZ_2nd:	incbin	"artnem\8x8 - GHZ2.kosm"	; GHZ secondary patterns
		even
Blk256_GHZ:	incbin	"map256\GHZ.kos"
		even
; ---------------------------------------------------------------------------
; Compressed graphics - bosses and ending sequence
; ---------------------------------------------------------------------------
Nem_Eggman:	incbin	"artnem\Boss - Main.kosm"
		even
Nem_Weapons:	incbin	"artnem\Boss - Weapons.kosm"
		even
Nem_Prison:	incbin	"artnem\Prison Capsule.kosm"
		even
Nem_Exhaust:	incbin	"artnem\Boss - Exhaust Flame.kosm"
		even

; ---------------------------------------------------------------------------
; Collision data
; ---------------------------------------------------------------------------
AngleMap:	incbin	"collide\Angle Map.bin"
		even
CollArray1:	incbin	"collide\Collision Array (Normal).bin"
		even
CollArray2:	incbin	"collide\Collision Array (Rotated).bin"
		even
Col_GHZ:	incbin	"collide\GHZ.bin"	; GHZ index
		even
Col_LZ:
Col_MZ:
Col_SLZ:
Col_SYZ:
Col_SBZ:
; ---------------------------------------------------------------------------
; Animated uncompressed graphics
; ---------------------------------------------------------------------------
Art_GhzWater:	incbin	"artunc\GHZ Waterfall.bin"
		even
Art_GhzFlower1:	incbin	"artunc\GHZ Flower Large.bin"
		even
Art_GhzFlower2:	incbin	"artunc\GHZ Flower Small.bin"
		even
Art_MzLava1:
Art_MzLava2:
Art_MzTorch:
Art_SbzSmoke:

Kos_Credits:	incbin "_inc/credits.kos"
Kos_Fanfic:	incbin "_inc/fanfic.kos"
Font1:		incbin "artunc/font1.unc"
Font2:		incbin "artunc/font2.unc"

; ---------------------------------------------------------------------------
; Level	layout index
; ---------------------------------------------------------------------------
Level_Index:	dc.w Level_GHZ1-Level_Index, Level_GHZbg-Level_Index, byte_68D70-Level_Index
		dc.w Level_GHZ2-Level_Index, Level_GHZbg-Level_Index, byte_68E3C-Level_Index
		dc.w Level_GHZ3-Level_Index, Level_GHZbg-Level_Index, byte_68F84-Level_Index
		dc.w Level_GHZ4-Level_Index, Level_GHZbg-Level_Index, byte_68F84-Level_Index

Level_GHZ1:	incbin	"levels\ghz1.bin"
		even
byte_68D70:	dc.b 0,	0, 0, 0
Level_GHZ2:	incbin	"levels\ghz2.bin"
		even
byte_68E3C:	dc.b 0,	0, 0, 0
Level_GHZ3:	incbin	"levels\ghz3.bin"
		even
Level_GHZ4:	incbin	"levels\ghz4.bin"
		even
Level_GHZbg:	incbin	"levels\ghzbg.bin"
		even
byte_68F84:	dc.b 0,	0, 0, 0

Art_BigRing:	incbin	"artunc\Giant Ring.bin"
		even

; ---------------------------------------------------------------------------
; Sprite locations index
; ---------------------------------------------------------------------------
ObjPos_Index:	dc.w ObjPos_GHZ1-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_GHZ2-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_GHZ3-ObjPos_Index, ObjPos_Null-ObjPos_Index
		dc.w ObjPos_GHZ4-ObjPos_Index, ObjPos_Null-ObjPos_Index
ObjPosLZPlatform_Index:
ObjPosSBZPlatform_Index:
		dc.b $FF, $FF, 0, 0, 0,	0
ObjPos_GHZ1:	incbin	"objpos\ghz1.bin"
		even
ObjPos_GHZ2:	incbin	"objpos\ghz2.bin"
		even
ObjPos_GHZ3:	incbin	"objpos\ghz3.bin"
ObjPos_GHZ4:	incbin	"objpos\ghz4.bin"
ObjPos_Null:	dc.b $FF, $FF, 0, 0, 0,	0

Unc_Achi_End:	incbin "artunc/achi end.unc"
Unc_Achi:	incbin "artunc/achi.unc"
Unc_Achi2:	incbin "artunc/achi2.unc"
Unc_AchiList:	incbin "artunc/achi list.unc"

		include "driver/code/smps2asm.asm"
SoundDriver:	include "driver/code/68k.asm"
DualPCM:	z80prog 0
		include "driver/code/z80.asm"
DualPCM_sz:	z80prog

; end of 'ROM'
	if error
		even
		include	"ErrorDebugger/ErrorHandler.asm"
	else
		dc.b "Fucking piece of shit Git disassembly has the shittest "
		dc.b "Z80 stopping macro ever. It should go to hell and die "
		dc.b "in fire. Took me 30 mins to figure out that Z80 stops "
		dc.b "in my driver didn't wait for BUS grant... Whoever "
		dc.b "cocksucker came up with that bs, can go die in a fire!!!"
	endif
EndOfRom:
		END
