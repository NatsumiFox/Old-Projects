	include "equ.asm"

; WARNING: Word at $30 ROM must be set to 0! Else Sonic 3 and Sonic & Knuckles may crash!
Maincode	section org(0)
		dc.l 0, EntryPoint, BusError_, AddressError_, IllegalInstrError_
		dc.l ZeroDivideError_, CHKExceptionError_, TRAPVError_, PrivilegeViolation_
		dc.l TraceError_, LineAEmulation_, LineFEmulation_
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap

; few shortcuts to make the init code fit in the first area here
RAM_START:	dc.l $FFFF0000
VDP_Data_Port:	dc.l $C00000
VDP_Control_Port:dc.l $C00004
		dc.l HBlank

Vint_Ani:
Vint_Null:	rte
TraceError_:
ErrorTrap:	bra.s	offset(*)

		dc.l VBlank, 0
	; these trap addresses are for easier reference to SRAM functions which have been modifed
		dc.l ENABLE_SRAM, DISABLE_SRAM

BusError_:
	nolist	; do not list these error definitions, to keep listings file cleaner
	err AddressError
	err IllegalInstrError
	err ZeroDivideError
	err CHKExceptionError
	err TRAPVError
	err PrivilegeViolation
	err LineAEmulation
	err LineFEmulation
	list

	cnop 0,$100
Console:	dc.b "SEGA SSF        "
		dc.b "(C)NAT  2016.OCT"
		dc.b "SUPER STREET FIGHTER2 The New Challengers       "
		dc.b "FILM REEL HACK                  GAME CAN SPECIAL"
		dc.b "GM T-12056 -00"
		dc.w 'FI'
		dc.b "J               "
		dc.l $00000000, $001FFFFF, $00FF0000, $00FFFFFF
		dc.w 'RA', $F820
		dc.l $200001, $2003FF
		dc.b "                                                    "
		dc.b "JUE             "
; ===========================================================================
	cnop 0,$200
	incbin "s3_1.bin"

EntryPoint:; check if we are soft resetting
	di
		lea	HW_Port_1_Control-1,a1
		tst.l	(a1)			; check cntroller ports
		bne.s	.chkmenu		; if set, itsa soft reset
		tst.w	HW_Expansion_Control-HW_Port_1_Control(a1)
		bne.s	.chkmenu		; if set, itsa soft reset

	; clear last $20 bytes of RAM
		moveq	#0,d0
		moveq	#$40/4-1,d1
		lea	-$40.w,a0

.clrRAM		move.l	d0,(a0)+
		dbf	d1,.clrRAM

.chkmenu	cmp.b	#MainDat-ROMdat,-4.w	; check if menu program was running
		blo.s	.reset			; if not, branch
		cmp.b	#MainDatEnd-ROMdat,-4.w	; ^
		blo.s	.tmss			; if was, skip over resetting variables

.reset	; reset variables
		clr.w	MenuState.w		; reset menu state and selected ROM
		clr.b	ChangingLockROM.w	; reset changing flag
		st	LockonROMid.w		; load S&K by default
		clr.w	PalCycleS2.w		; stop palcycle

	; set plane y-pos
		move.w	#$7FA0,d0		; there will be strange glitch near 0000
		move.w	d0,PlaneAY.w		; so we wanna go as far from it as possible
		move.w	d0,MenuTgtY.w		; to try to hide the issue :-)
		sub.w	#96,d0			; use S&K by default when changing selection
		move.w	d0,StoredPlaneA.w	; ^
.w
	; initialize frame data offsets
		movem.l	FrameArtPtr,d0-d3
		movem.l	d0-d3,FrameOffs.w

	; convince TMSS we are legimate program
.tmss		movem.l	$2A2.w,a0/a2-a5		; get some addresses
		move.w	VDP_Counter-$C00004(a5),Random_Seed+2.w

		lea	Stack.w,sp		; reset the stack
		move.b	-7(a1),d0		; get version
		andi.b	#$F,d0
		beq.s	.SkipSecurity		; check if non-TMSS
		move.l	Console.w,$A14000-(HW_Port_1_Control-1)(a1); satistify TMSS

	; put z80 reset program in
.SkipSecurity	tst.w	(a5)			; reset VDP
		lea	$2D2.w,a4		; get Z80 reset code address
		move.w	#$100,(a2)
		move.w	#$100,(a3)
.waitz80	btst	#0,(a2)
		bne.s	.waitz80

		moveq	#$26-1,d2
.loadz80	move.b	(a4)+,(a0)+		; write z80 code
		dbf	d2,.loadz80

	; reset PSG
		add.w	#12,a4			; advance by 12 bytes
	rept 4
		move.b	(a4)+,$C00011-$C00004(a5); send command
	endr
		move.w	#0,(a3)
	rept 2
		or.l	d0,d0	; <- 8 cycles, replaces 2 nops. D0 unchanged
	endr
		move.w	#$100,(a3)
		move.w	#0,(a2)
		move.w	VDP_Counter-$C00004(a5),Random_Seed.w
		addi.l	#'S4i1',Random_Seed.w	; fuck you Bizhawk

	; init VDP
		jsr	InitVDP.w
		move.l	#$81748B00,(a5)		; enable display and make fullscreen scroll
		move.w	#$8730,(a5)		; set bg color

	; get mappings
		moveq	#1,d0			; offset by one tile
		move.l	RAM_START.w,a1
		lea	Nat_Map,a0
		jsr	EniDec.w

		move.l	RAM_START.w,a1
	vdpcomm	move.l,$C200,VRAM,WRITE,d0
		moveq	#312/8-1,d1
		moveq	#128/8-1,d2
		jsr	MapToPlane.w

	; get art
		move.l	RAM_START.w,a1
		lea	Nat_Art,a0
		jsr	KosDec.w

	; dma art and palette
		move.l	VDP_Control_Port.w,a5
	dma68kToVDP $FF0000,$0020,$20D0,VRAM	; dma Natsumi Presents art
	vdpcomm move.l,2,CRAM,WRITE,(a5)
		move.l	#$EEE0000,-4(a5)	; write white and black

		moveq	#0,d0
		moveq	#62/2-1,d1
.clrpal		move.l	d0,-4(a5)
		dbf	d1,.clrpal
	vdpcomm move.l,$F000,VRAM,WRITE,(a5)
		move.w	#6,-4(a5)

	; check if bank switching and controllers work
		jsr	CheckBankSwitch		; try to see if bank switch works
		jsr	ResetControllers.w	; reset controller status

	; initialize banks
		lea	Banks(pc),a1
		lea	$A130F3,a0	; address for first bank to be switched
		move.b	(a1)+,(a0)	; load first bank
		move.l	(a1)+,d0
		movep.l	d0,2(a0)	; load 4 banks
		move.w	(a1)+,d0
		movep.w	d0,$A(a0)	; load last 2 banks

	vdpcomm move.l,$F000,VRAM,WRITE,(a5)
		move.w	#0,-4(a5)		; reset horizontal position
		tst.b	-4.w			; check if we hard resetted
		bne.s	.skipsplash		; if not, do not run splash screens
		jsr	SRetro			; run splash screens
	di					; disable ints again

	; get mappings
.skipsplash	move.w	#$680,d0		; load BG between planes
		move.l	RAM_START.w,a1
		lea	BG_Map,a0
		jsr	EniDec.w
		move.l	VDP_Control_Port.w,a5
	dma68kToVDP $FFFF0000,$E000,$E00,VRAM	; DMA the mappings

	; get bg art
		move.l	RAM_START.w,a1
		lea	BG_Art,a0
		jsr	KosDec_

	; get cancel button art
		lea	Cancel_Kos,a0
		jsr	KosDec_

		move.l	VDP_Control_Port.w,a5
	dma68kToVDP $FFFF0000,$D000,$C80+$240,VRAM; DMA the both arts

	; load scaler code
		jsr	LoadNameList		; load the game names
		lea	Kos_Scalers,a0		; get the scalers code to a0
		lea	Scalers.w,a1		; get the offset
		jsr	KosDec_			; decompress it

	; clear Plane A
		move.l	VDP_Control_Port.w,a5
	dmaFillVRAM 0,$C000,$1000,1
		move.l	#((MainDat-ROMdat)<<24)|Vint_Null,-4.w; set main int

		jsr	InitSpriteTbl		; init the sprites
		move.w	#$8134,4(a0)		; disable display
		jsr	LoadAllMenuRows		; load the menu data
	di					; LoadAllMenuRows will enable ints so blah

		clr.w	PlaneBX.w
		jsr	Scale_Image		; scale the images

		lea	WriteArtProg.w,a5
		movem.w	(a5)+,d0-d3/d6/a6	; get data
		move.w	d0,-(a6)		; rts

		move.l	(a5)+,d7		;;; move.l (a6)+,(a5) x2
.loadprg	move.l	d7,-(a6)		; load single byte of program
		dbf	d6,.loadprg		; loop til done
		movem.w	d1-d3,-(a6)		;;; lea ScaleBuf.l,a6

		jsr	RenderMenu_		; pre-render the menu
		clr.w	PlaySampleLen.w

		clr.b	MenuState.w		; stop moving
		jsr	LoadPalette		; load current palette
		move.l	#$81748730,4(a0)	; enable display
		jmp	MainLoop
; ===========================================================================

HBlank:	; fucking 40 cycles >_>
		move.l	-4.w,-(sp)	; push h-int address to stack
		rts			; jump to it ;)

VBlank:
		move.l	a0,usp		; push a0
		move.w	d0,-(sp)	; push d0
		move.b	-4.w,d0		; get offset in data
		ext.w	d0		; extend to word
		move.l	ROMdat(pc,d0.w),a0; get pointer to the routine
		move.w	(sp)+,d0	; pop d0
		pea	(a0)		; push to stack
		move.l	usp,a0		; pop a0
		rts			; jump to it ;)
; ===========================================================================

	dc.l $FFFFFFF0
	dc.l $FFFFFFF0
	dc.l $FFFFFFF0
	dc.l $FFFFFFF0
ROMdat:
S3KDat = offset(*)-4
	dc.l $080000
	dc.b $F3,(SKROM/$080000)+0
	dc.b $F5,(SKROM/$080000)+1
	dc.b $F7,(SKROM/$080000)+2
	dc.b $F9,(SKROM/$080000)+3
	dc.b $FB,1
	dc.b $FD,2
	dc.b $FF,3
	dc.w 0

s3data	= offset(*)
	dc.l $FFFFFE00
	dc.l $206

S3Dat:	; s3
	dc.l $802
	dc.l s3data
	dc.b $F3,1
	dc.b $F5,2
	dc.b $F7,3
	dc.w 0

S1Dat:	; s1
	dc.l S1_VInt
	dc.l $080000
	dc.b $F3,(S1ROM/$080000)+0
	dc.b $F5,1
	dc.w 0

S2Dat:	; s2
	dc.l S2_Vint-$200000
	dc.l $080000
	dc.b $F3,(S2ROM/$080000)+0
	dc.b $F5,(S2ROM/$080000)+1
	dc.b $FB,1
	dc.w 0

S2KDat:	; s2k
	dc.l $080000
	dc.b $F3,(SKROM/$080000)+0
	dc.b $F5,(SKROM/$080000)+1
	dc.b $F7,(SKROM/$080000)+2
	dc.b $F9,(SKROM/$080000)+3
	dc.b $FB,(S2ROM/$080000)+0
	dc.b $FD,(S2ROM/$080000)+1
	dc.b $FF,(UPMEM/$080000)
	dc.b 0
Banks:
	dc.b 1, 2, 3
	dc.b ScalersData/$080000,SKROM/$080000
	dc.b DebuggerOffs/$080000,S1ROM/$080000

MainDat:; null v-int
	dc.l Vint_Main
	dc.l Vint_ToSKSel
	dc.l Vint_FromSKSel
FanDat:	dc.l Vint_Fanfic
AniDat:	dc.l Vint_Ani
MainDatEnd:

	cnop s3data&2,4
	dcb.l ($74-(offset(*)-s3data))/4, $FFFFF608
	dc.l $69A
; ===========================================================================

WriteArtProg:
	rts
	lea	ScaleBuf,a6
	dc.w	$1200/2-1
	dc.w	WriteArtToVRAM+$2408
	move.l	(a6)+,(a5)
	move.l	(a6)+,(a5)
; ===========================================================================
	space $69A, Main

	cnop 0,$69A
;	incbin "s3_2.bin", 0, $18000-$1000
	incbin "s3_2.bin"
Nat_Map:incbin "dat/nat.map.eni"
Nat_Art:incbin "dat/nat.art.kos"

; ===========================================================================
; NOTE: The following code is a hack to get SRAM working on
; 	Mega-EverDrive! It is not a good solution and definitely not
;	recommended! It abuses the fact that Mega-ED allows you to write
;	to ROM memory with a setting, but emulators do not (currently)
;	implement a solution like this, making it possible to check if we
;	are on Mega-ED, and if so, use a different handler for SRAM which
;	fixes issues with SRAM saving. However, each game must be edited
;	to call trap #0 and trap #1 to enable/disable SRAM. S3 has been
;	edited to call trap #0 to enable SRAM (since it never disables it)
; ===========================================================================
ENABLE_SRAM:
		tst.b	3.w			; check if MED is inserted
		bmi.s	.med			; if is, use MED-specific code
		move.b	#1,$A130F1		; enable SRAM
		rte

.med		move.w	#$B000,$A130F0		; enable ROM WRITE & LED
		move.b	#28,$A130F9		; enable SD save at 2MB
		rte

DISABLE_SRAM:
		tst.b	3.w			; check if MED is inserted
		bmi.s	.med			; if is, use MED-specific code
		move.b	#0,$A130F1		; enable SRAM
		rte

.med		move.w	#$8000,$A130F0		; disable ROM WRITE & LED
		move.b	#(SKROM/$080000)+3,$A130F9; reset the bank at 2MB
		rte

MainLoop:; MEGA-ED test
		move.w	#$A000,$A130F0		; enable ROM WRITE
		st	3.w			; enable MEGA-ED on system, cannot write on emu's or other carts
		move.w	#$8000,$A130F0		; disable ROM WRITE

; ===========================================================================
; main loop of the menu program
.waitloop	tst.w	PlaySampleLen.w		; check if we need to load sound driver
		bne.s	.ok			; if not, branch
		subq.w	#1,PlaySampleLen.w	; do not reload driver
		jsr	SndDrvInit		; init sound driver
		stop	#$2300			; wait a frame
		moveq	#$FFFFFF81,d0		;
		jsr	PlaySound		; play menu music

.ok		stop	#$2300			; wait for v-int
		tst.b	MenuState.w		; check menu state
		bmi.w	.outani			; if negative, this is the out animation
		bne.w	.rendermenu		; render the menu
	; menu is not moving

		tst.b	$FFFFF605.w		; check start button held
		bpl.s	.noload			; if not held, don't load the ROM
		tst.b	ChangingLockROM.w	; check if we are changing lock-on ROM
		bne.s	.doload			; if yes, load
		cmp.b	#3,SelectedROM.w	; check if we selected S&K
		beq.w	.actlockon		; if yes, enable lock-on menu

.doload		moveq	#$FFFFFF90,d0
		jsr	PlaySound		; game selection sound
		move.b	#-80,MenuState.w	; wait for 2 sec

.noload		jsr	CheckButtonPresses(pc)	; check if correct buttons are pressed for cheats
		btst	#0,$FFFFF604.w		; check if up is pressed
		beq.s	.chkdwn			; if not, branch
		tst.w	PlaySampleLen.w
		bmi.s	.noadd1
		add.w	#3,PlaySampleLen.w	; fix for errors on RenderMenu

.noadd1		addq.b	#1,MenuState.w		; move up
		sub.w	#96,MenuTgtY.w		; move menu up
		ori.w	#$C000,NameSpriteX.w	; change name sprite
		moveq	#$FFFFFF91,d0
		jsr	PlaySound
		bra.w	.waitloop

.chkdwn		btst	#1,$FFFFF604.w		; check if down is pressed
		beq.s	.chkA			; if not, branch
		tst.w	PlaySampleLen.w
		bmi.s	.noadd2
		add.w	#3,PlaySampleLen.w	; fix for errors on RenderMenu

.noadd2		addq.b	#2,MenuState.w		; move down
		add.w	#96,MenuTgtY.w		; move menu down
		ori.w	#$C000,NameSpriteX.w	; change name sprite
		moveq	#$FFFFFF91,d0
		jsr	PlaySound		; play selection time
		bra.w	.waitloop

.chkA		andi.b	#$70,$FFFFF605.w	; check if A/B/C is pressed
		beq.w	.waitloop		; if not, branch
		btst	#1,ChangingLockROM.w	; change whether we are changing lock-on ROM
		bne.s	.actlockon		; if was set, branch

		cmp.b	#3,SelectedROM.w	; check if we selected S&K
		bne.w	.waitloop		; if not, branch
.actlockon	addq.b	#4,-4.w			; activate change
		ori.w	#$C000,NameSpriteX.w	; change name sprite
		bra.w	.waitloop

.rendermenu	bsr.s	RenderMenu		; render menu
		bra.w	.waitloop

.outani		addq.b	#1,MenuState.w		; add 1 to the state
		bpl.s	.load			; if over 0, branch
		cmp.b	#-75,MenuState.w	; check if this is the frame to fade out
		bne.w	.waitloop		; if not, branch

		moveq	#$FFFFFFF0,d0
		jsr	PlaySound		; play fadeout
		bra.w	.waitloop
.load		jmp	LoadROM(pc)		; else load the ROM already

; this code here renders the menu, loads menu rows and writes the art to VDP
RenderMenu:
		cmp.w	#2,PlaySampleLen.w	; check if we can reduce sample timer
		blt.s	.nop			; if not, branch
		subq.w	#2,PlaySampleLen.w	; do not reload driver
.nop		jsr	Scale_Image		; scale the images
		jsr	LoadMenuRows		; load rows of tiles when needed (also move plane)

RenderMenu_:
		move.l	VDP_Data_Port.w,a5
	vdpcomm	move.l,$0020,VRAM,WRITE,4(a5)	; VRAM WRITE to $20
		jmp	WriteArtToVRAM.w	; then write the art
; ===========================================================================
ROMoffs:
	dc.w S1Dat-ROMdat; s1
	dc.w S2Dat-ROMdat; s2
	dc.w S3Dat-ROMdat; s3
; ===========================================================================
; load the selected game. Will pick up things like h-int address, stack ptr,
; and the initial address of the game from its offset

LoadROM:
		moveq	#-1,d7			; hard reset
		moveq	#0,d0
		move.b	SelectedROM.w,d0	; get ROM ID
		cmp.b	#3,d0			; check if S&K
		beq.s	_loadsk			; branch if S&K

		add.w	d0,d0			; double it
		move.w	ROMoffs(pc,d0.w),d0	; get offset from tbl

SoftReset:
		lea	ROMdat+4.w,a0		; get final offset from ROM
		add.w	d0,a0			; add offset to a0
		bra.s	LoadROM_		; load ROM

; S&K is actually special because you can play S&K, S3K, S2K and Blue Spheres.
; Therefore we have this small custom loading code to do it right for us.
_loadsk		lea	S2KDat.w,a0		; get S2K data
		move.b	LockonROMid.w,d0	; get the lock-on ROM type
		bgt.s	LoadROM_		; if S2K, branch
		lea	S3KDat+4.w,a0		; get S&K data

		; 102 bytes
LoadROM_:	; 56+8 = 64
	di	; disable ints
		clr.w	$FFFFFFFA.w		; fix: disable debug mode. Caused by S3K, H-int jmp addr
		move.l	(a0)+,a1		; get ROM ptr
		move.l	#$A13000,d2		; get address register

.writestuff	move.b	(a0)+,d2		; get correct register
		bpl.s	.next			; if positive, branch
		move.l	d2,a2			; get final register ptr
		move.b	(a0)+,(a2)		; then write the final value in there
		bra.s	.writestuff		; keep looping

.next		move.l	$70(a1),-4.w		; store h-int address
		move.b	d0,-4.w			; set ROMdat offset
		move.l	(a1),sp			; set stack ptr
		move.l	$74(a1),a0		; get soft reset address

		tst.b	d7			; check if game was soft or hard reset
		bpl.s	.run			; if soft, branch
		move.l	4(a1),a0		; else get the address of ROM start

		lea	HW_Port_1_Control,a1	; get controller port to a1
		move.b	#0,(a1)			; reset all ports
		move.b	#0,2(a1)		;
		move.b	#0,4(a1)		;
.run		jmp	(a0)			; run game
; ===========================================================================

CheckButtonPresses:
		move.b	$FFFFF605.w,d2		; get pressed buttons
		beq.s	.rts			; if none were pressed, branch

		lea	CheatsOffset.w,a1	; get cheats offset
		tst.l	(a1)			; check if no cheats are active
		beq.s	.chkallcheats		; if no cheat active, branch
		bsr.s	.chk			; check cheats here
		addq.w	#2,a1			; next cheats
		move.b	$FFFFF605.w,d2		; get pressed buttons

.chk		move.w	(a1),d0			; get the offset to read from
		add.b	.chtarr(pc,d0.w),d2	; get next cheat entry
		bne.s	.resetcheat		; if not 0, reset cheat

	; cheat ok
		addq.w	#1,(a1)			; next cheat offset
		move.b	.chtarr+1(pc,d0.w),d2	; check if this is the end of the cheat
		bne.s	.rts			; if not 0, branch
		clr.w	(a1)
		move.l	.chtarr+1(pc,d0.w),a0	; get the address to run
		jmp	(a0)			; and run it

.chtarr		dc.w dncht1+1-.chtarr
		dc.w dncht2+1-.chtarr
		dc.w dncht3+1-.chtarr
		dc.w foxcht+1-.chtarr
		dc.w gencht+1-.chtarr
		dc.w 0

.chkallcheats	lea	.chtarr(pc),a0		; get cheats array1
.chknextcht	move.w	(a0)+,d0		; get cheat offset
		beq.s	.rts			; if null, end

		move.b	.chtarr-1(pc,d0.w),d1	; get next cheat entry
		add.b	d2,d1			; eor together
		bne.s	.chknextcht		; if not 0, rcheck another cheat

		move.w	d0,(a1)+		; save cheats offset
		bra.s	.chknextcht		; check next cheat

.resetcheat	clr.w	(a1)			; reset cheat
.rts		rts

; cheat codes
	cheat dncht1, WriteFanficOnScreen, "BABABCB"
	cheat dncht2, WriteFanficOnScreen, "ABCBCAB"
	cheat dncht3, WriteFanficOnScreen, "ACCABAB"
	cheat foxcht, NatsumiAnim, "BACLUA"
	cheat gencht, GenesisDoes, "UUDDLRLRBA"
; ===========================================================================
; check if this emulator/hardware supports bank switching. Will show red
; screen of death if not.

BankSwitchChecksums:
	dcb.w 12,0

CheckBankSwitch:
		lea	$A130F3,a4		; get bank 1 address
		move.w	#$9000,-3(a4)		; enable LED
		lea	BankSwitchChecksums(pc),a6; get bank switching
		moveq	#1,d7			; start on bank 1
		move.l	#"2b2t",d2		; set initial long

.next		move.w	(a6)+,d1		; get the correct checksum
		beq.s	.end			; if its NULL, we are done here
		move.b	d7,(a4)			; set current requested bank
		addq.b	#1,d7			; next bank

		move.l	d2,d0			; reset initial long
		move.w	#$080000/128-1,d4	; set the number of words to check
		lea	$080000,a0		; get the actual ROM address

.loop	rept 16
		sub.l	(a0)+,d0		; substract the next long with the result
		add.l	(a0)+,d0		; add the next long with the result
	endr
		dbf	d4,.loop		; keep doing til every long is done

		move.w	d0,d5			; get low word to d5
		swap	d0			; get upper word to low word
		eor.w	d5,d0			; exclusive or the values

		cmp.w	d0,d1			; check if they match
		beq.s	.next			; if do, branch
		move.w	#$8000,-3(a4)		; disable LED
		move.l	VDP_Control_Port.w,a6	; get VDP data port to a6
		move.w	#$8702,(a6)		; set bg color to pal 0 entry 2
	vdpcomm move.l,4,CRAM,WRITE,(a6)	; CRAM WRITE 4
		move.w	#$E,-4(a6)		; set to red screen of death
		bra.s	offset(*)		; loop

.end		move.w	#$8000,-3(a4)		; disable LED
		rts
; ===========================================================================
; load correct palettes depending on whether we are on locked-on menu or not

LoadPalette:
		move.l	VDP_Data_Port.w,a0	; get VDP data port to a6
	vdpcomm move.l,0,CRAM,WRITE,4(a0)	; CRAM WRITE 0
		lea	FramePalettes(pc),a3	; get offset of the palette data we want
		tst.b	ChangingLockROM.w	; check if changing lock-on ROM
		beq.s	.write			; branch if not
		add.w	#$80,a3			; go to lockROM palettes

.write	rept (32*4)/4
		move.l	(a3)+,(a0)		; write in the full palette
	endr
		rts

; ===========================================================================
FramePalettes:
	incbin "dat/gf.s1.pal"			; Sonic 1 palette
	incbin "dat/gf.s2.pal"			; Sonic 2 palette
	incbin "dat/gf.sk.pal"			; Sonic & Knuckles palette
	incbin "dat/gf.s3.pal"			; Sonic 3 palette

	incbin "dat/gf.s3k.pal"			; Sonic 3 & Knuckles palette
	incbin "dat/gf.s2k.pal"			; Sonic 2 & Knuckles palette
	incbin "dat/gf.sk.pal"			; Sonic & Knuckles palette
	incbin "dat/gf.bp.pal"			; BP palette
; ===========================================================================
; load the vertical rows of plane mappings depending on your position, to
; simulate infinitely scrolling menu

LoadAllMenuRows:
		move.l	VDP_Data_Port.w,a0	; get VDP port address
		moveq	#0,d7
		move.w	PlaneAY.w,d7		; get Plane Y-pos to d7
		lsr.w	#3,d7			; division by 8
		subq.w	#2,d7			; go up 2 tiles
		moveq	#32-1,d6		; load 32 rows
	di

.loadrow	move.l	d7,d0			; copy d7 to d0
		move.l	d7,d1			; copy d7 to d0
		bsr.s	LoadMenuRows_Common	; load row
		addq.w	#1,d7			; next row
		dbf	d6,.loadrow		; load all rows
	ei
		rts

LoadMenuRows:
		move.l	VDP_Data_Port.w,a0	; get VDP port address
		moveq	#0,d0
		clr.b	d1			; clear d1

		move.w	PlaneAY.w,d0		; get Plane y-pos
		cmp.w	MenuTgtY.w,d0		; check the target pos
		bne.s	.nop			; if not same, branch
		clr.b	MenuState.w		; stop menu rendering
		rts

.nop		addq.w	#8,PlaneAY.w		; move plane down
		cmp.b	#1,MenuState.w		; check if moving up
		bne.s	.dwn			; if not, branch
		sub.w	#16,PlaneAY.w		; move plane up
		st	d1			; set d1

	; disabled; plane moves 8 pixels in a frame anyway
.dwn	;	andi.w	#7,d0			; check if we are on edge of a tile
	;	bne.s	LMR_noredraw		; if not, branch

		move.w	PlaneAY.w,d0		; get Plane y-pos again
		lsr.w	#3,d0			; division by 8
		subq.w	#2,d0			; go up 2 tiles

		tst.b	d1			; check direction
		bmi.s	.c			; if we are moving up, branch (reload tiles on top)
		add.w	#31,d0			; go to screen bottom
.c		move.w	d0,d1			; store d0
	di

LoadMenuRows_Common:
	; first get the target tiles to render
		divu	#12*4,d0		; max number of tiles
		swap	d0			; we want to do modulo
		move.w	d0,d2			; copy it
		muls	#12,d0			; then multiply by 12

		andi.w	#$FE,d2			; align nicely
		or.w	PaletteLines(pc,d2.w),d0; add the correct palette line to map

		move.w	d0,d2			; copy d0
		subq.w	#1,d0			; ago back 1 tile (fixed later on)
		swap	d0			; store d0 low word to upper word
		move.w	d2,d0			; then store the stored value back to low word of d0

	; now get VDP address to write to
		andi.w	#$1F,d1			; keep in range of 32 vertical tiles
		lsl.w	#7,d1			; multiply by 0x80
		swap	d1			; swap words
		clr.w	d1			; clear low word
	vdpcomm ori.l,$C000,VRAM,WRITE,d1	; set to VRAM write mode for address $CXXX

	; set vdp command and prepare to write
		move.l	d1,4(a0)		; save VDP command
		move.l	#$00020002,d2		; value to add to each time
		moveq	#12/2-1,d1		; write only 12 tiles

.write		add.l	d2,d0			; increment tile
		move.l	d0,(a0)			; write next 2 tiles
		dbf	d1,.write		; write total of 12 tiles

LMR_noredraw:
		rts

PaletteLines:
	dcb.w	6,$C000
	dcb.w	6,$8000
	dcb.w	6,$A000
	dcb.w	6,$E000
; ===========================================================================

Vint_FromSKSel:
		movem.l	d0-d1/a0-a1,-(sp)
		move.l	VDP_Data_Port.w,a0	; VDP DATA PORT
	vdpcomm move.l,$F000,VRAM,READ,4(a0)
		move.w	(a0),d0			; get the h-offset
		bmi.s	.move			; if negative, move more
		moveq	#-4,d0			; set plane position
		subq.b	#8,-4.w			; return to normal operations

.move		addq.w	#4,d0			; move instead
	vdpcomm move.l,$F000,VRAM,WRITE,4(a0)
		move.w	d0,(a0)			; save the offset
		bra.w	Vint_Common

Vint_ToSKSel:
		movem.l	d0-d1/a0-a1,-(sp)
		clr.w	$FFFFF604.w

		move.l	VDP_Data_Port.w,a0	; VDP DATA PORT
	vdpcomm move.l,$F000,VRAM,READ,4(a0)
		move.w	(a0),d0			; get the h-offset
	vdpcomm move.l,$F000,VRAM,WRITE,4(a0)

		cmp.w	#-(12*9)-4,d0		; check if we are past the edge
		bgt.w	.move			; if not, move
		move.w	#-(12*9)-4,(a0)		; fix offset
		bchg	#1,ChangingLockROM.w	; change whether we are changing lock-on ROM
		bne.s	.tonorm			; if was set, branch

	; set frame data offsets
		jsr	CancelSpriteEnable(pc)
		lea	FrameArtLockPtr(pc),a3
		bra.s	.common

	; reset frame data offsets
.tonorm		jsr	CancelSpriteDisable(pc)
		lea	FrameArtPtr(pc),a3

	; load new place position, redraw plane, and then render menu
.common		lea	FrameOffs.w,a4
	rept 4
		move.l	(a3)+,(a4)+
	endr

		move.w	StoredPlaneA.w,d0	; get stored plane-a pos
		move.w	PlaneAY.w,StoredPlaneA.w; store y-pos
		move.w	d0,PlaneAY.w		; set plane-a y-pos
		move.w	d0,MenuTgtY.w		; reset target
		addq.b	#4,-4.w			; go to next v-int

		movem.l	d2/d6-d7,-(sp)		; save registers
		jsr	LoadPalette(pc)		; reload palette
		jsr	LoadAllMenuRows(pc)	; load all menu rows
		jsr	NameSpriteChangeArt(pc)
		movem.l	(sp)+,d2/d6-d7		; save registers
	di	; disable ints again

		jsr	RenderMenu		; re-render menu
		move.l	VDP_Data_Port.w,a0	; VDP DATA PORT

.move		subq.w	#4,d0			; move instead
		move.w	d0,(a0)			; save the offset
		bra.s	Vint_Common

Vint_Main:
		movem.l	d0-d1/a0-a1,-(sp)
		jsr	ReadController.w	; read controller input
		move.l	VDP_Data_Port.w,a0	; VDP DATA PORT

Vint_Common:
	vdpcomm move.l,0,VSRAM,WRITE,4(a0)
		move.w	PlaneAY.w,(a0)		; set plane A Y-pos
	vdpcomm move.l,$F002,VRAM,WRITE,4(a0)
		move.w	PlaneBX.w,(a0)		; set plane B X-pos
		subq.w	#1,PlaneBX.w		; move plane for next frame

	; run pcm timer
		tst.w	PlaySampleLen.w		; check timer
		ble.s	.notimer		; if negative, do not dec more
		subq.w	#1,PlaySampleLen.w	; sub 1 from sample len

	; cycle palettes
.notimer	moveq	#0,d0
		btst	#1,ChangingLockROM.w	; check if changing lock-rom
		bne.s	.palcycs3k		; if so, branch
		subq.b	#1,PalCycleS2Timer.w	; sub 1 from the timer
		bpl.s	.skippal		; if positive, branch
		move.b	#6-1,PalCycleS2Timer.w	; reset it

		move.b	PalCycleS2.w,d0		; get offset to read from
		addq.b	#8,PalCycleS2.w		; advance to next frame
		cmp.b	#$60-8,d0		; check if max frame
		blo.s	.ok2			; if not, branch
		clr.b	PalCycleS2.w		; reset the counter

.ok2		lea	S2SuperPalette(pc),a1	; get data to write
	vdpcomm	move.l,$0038,CRAM,WRITE,4(a0)	; write to palette line 1 entry 12
		move.l	(a1,d0.w),(a0)		; write next entries
		move.l	4(a1,d0.w),(a0)		; write next entries
		bra.s	.skippal

.palcycs3k	subq.b	#1,PalCycleS3KTimer.w	; sub 1 from the timer
		bpl.s	.skippal		; if positive, branch
		move.b	#5-1,PalCycleS3KTimer.w	; reset it

		move.b	PalCycleS3K.w,d0	; get offset to read from
		addq.b	#6,PalCycleS3K.w	; advance to next frame
		cmp.b	#$48-6,d0		; check if max frame
		blo.s	.ok3k			; if not, branch
		clr.b	PalCycleS3K.w		; reset the counter

.ok3k		lea	S3KSuperPalette(pc),a1	; get data to write
	vdpcomm	move.l,$0002,CRAM,WRITE,4(a0)	; write to palette line 1 entry 1
		move.l	(a1,d0.w),(a0)		; write next entries
		move.w	4(a1,d0.w),(a0)		; write next entries

	; deal with the name sprites
.skippal	tst.w	NameSpriteX.w		; check if we are moving
		bpl.s	.sprend			; if not, branch
		btst	#14,NameSpriteX.w	; check direction
		beq.s	.left			; if 0, branch left

		addq.w	#8,NameSpriteX.w	; move left
		bsr.s	NameSpriteUpdate	; update
		cmp.w	#Sprite_Right|$C000,NameSpriteX.w; check if we are at the end
		blo.s	.sprend			; if not, branch
		bclr	#14,NameSpriteX.w	; move back in
		bsr.s	NameSpriteChangeArt	; change art frame
		bra.s	.sprend

.left		subq.w	#6,NameSpriteX.w	; move right
		bsr.s	NameSpriteUpdate	; update
		cmp.w	#Sprite_Left|$8000,NameSpriteX.w; check if we are at the end
		bhi.s	.sprend			; if not, branch
		bclr	#15,NameSpriteX.w	; stop moving

.sprend		movem.l	(sp)+,d0-d1/a0-a1
		rte
; ===========================================================================
; move name sprites and cancel sprites along the x-axis when needed

NameSpriteUpdate:
		move.w	#$8F08,4(a0)		; autoincrement of 8 bytes (size of 1 sprite)
	vdpcomm move.l,$F806,VRAM,WRITE,4(a0)	; write address

		moveq	#4*8,d1			; prepare x-position addition
		bsr.s	.a			; load sprites
		bsr.s	.a			; load sprites

	; update A for cancel sprite position
		move.w	NameSpriteX.w,d0	; get the sprite x-position to d0
		add.w	#128-8,d0		; add offset

	rept 2
		move.w	d0,(a0)			; write horizontal position
		add.w	d1,d0			; go to next sprite position
	endr
		move.w	d0,(a0)			; write horizontal position
		move.w	#$8F02,4(a0)		; reset autoincrement
		rts

.a		move.w	NameSpriteX.w,d0	; get the sprite x-position to d0
.loop	rept 5
		move.w	d0,(a0)			; write horizontal position
		add.w	d1,d0			; go to next sprite position
	endr
		move.w	d0,(a0)			; write horizontal position
		rts
; ===========================================================================
; change the art tile of each sprite in spritetable
; associated with the game name

NameSpriteChangeArt:
		tst.b	ChangingLockROM.w	; check if changing lock-on ROM
		bne.s	.sk			; branch if so
		moveq	#0,d0
		move.b	SelectedROM.w,d0	; get currently selected ROM

		cmp.b	#2,MenuState.w		; check if moving up
		bne.s	.norm			; if yes, branch
		addq.w	#1,d0			; hack: Fixes getting wrong info
		andi.w	#3,d0			; keep in range

.norm		add.w	d0,d0			; double art
		move.w	.tiles(pc,d0.w),d0	; get the first tile
		bra.s	.notSK

.sk		move.b	LockonROMid.w,d0	; get lock-on ROM
		ext.w	d0			; extend to word
		addq.w	#1,d0			; make it 0-based

		cmp.b	#2,MenuState.w		; check if moving up
		bne.s	.norm2			; if yes, branch
		addq.w	#1,d0			; hack: Fixes getting wrong info
		andi.w	#3,d0			; keep in range

.norm2		add.w	d0,d0			; double it
		move.w	.tilessk(pc,d0.w),d0	; get the first tile

.notSK		move.w	#$8F08,4(a0)		; autoincrement of 8 bytes
	vdpcomm move.l,$F804,VRAM,WRITE,4(a0)	; write address

		bsr.s	.loop			; load sprites
		bsr.s	.loop			; load sprites
		move.w	#$8F02,4(a0)		; reset autoincrement
		rts

.tiles		dc.w $6241, $6271, $62A1
.tilessk	dc.w $62D1, $6301, $6331, $6361

.loop	rept 6
		move.w	d0,(a0)			; write horizontal position
		addq.w	#4,d0			; go to next sprite piece
	endr
		rts
; ===========================================================================
; with these following 2 routines, we actually disable the next sprite(s)
; or enable them, hiding or unhiding the cancel button art using the linking
; feature of sprite table

CancelSpriteEnable:
	vdpcomm move.l,($F802+(11*8)),VRAM,WRITE,4(a0)	; write address
		move.w	#$C0C,(a0)
		rts

CancelSpriteDisable:
	vdpcomm move.l,($F802+(11*8)),VRAM,WRITE,4(a0)	; write address
		move.w	#$C00,(a0)
		rts
; ===========================================================================

InitSpriteTbl:
		pea	CancelSpriteDisable(pc)	; disable cancel sprite by default
		pea	NameSpriteChangeArt(pc)	; then finally set correct art
		moveq	#0,d0			; null sprite piece
		move.l	#(($80+110)<<16)|$C01,d2; y-position and sprite size and link data

		move.w	#Sprite_Left,NameSpriteX.w; sprite not moving
		move.l	VDP_Data_Port.w,a0	; VDP DATA PORT
	vdpcomm move.l,$F800,VRAM,WRITE,4(a0)	; write address
		bsr.s	.a			; load sprites
		add.l	#$80000,d2		; go to next line
		bsr.s	.a			; load the bottom row too

	; then load the A for cancel art
		move.w	#$66E4,d0		; A cancel ptr
		moveq	#3-1,d3			; 3 sprites
		move.l	#(($80+180)<<16)|$D0D,d2; set 2 lines of tiles for lines and y-pos
		bsr.s	.loop			; then load them

	vdpcomm move.l,($F802+(14*8)),VRAM,WRITE,4(a0); write address
		move.w	#$D00,(a0)		; end the sprite table here
		rts

.a		moveq	#6-1,d3			; 5 sprites horizontally
		move.w	#Sprite_Left,d1		; reset initial x-pos

.loop		move.l	d2,(a0)			; save y-position and sprite size and link data
		move.w	d0,(a0)			; set pattern
		move.w	d1,(a0)			; save x-pos

		addq.w	#1,d2			; next link data
		addq.w	#8,d0			; go to next sprite piece (only for A for cancel)
		add.w	#4*8,d1			; next x-position
		dbf	d3,.loop		; loop for all sprites
		rts

; ===========================================================================
S2SuperPalette:	dc.w $00EE,$00CC,$00AA,$0088
		dc.w $00EE,$00CC,$00AA,$0088
		dc.w $04EE,$02EE,$00CC,$00AA
		dc.w $06EE,$04EE,$02EE,$00CC
		dc.w $08EE,$06EE,$04EE,$02EE
		dc.w $0AEE,$08EE,$06EE,$04EE
		dc.w $0CEE,$0AEE,$08EE,$06EE
		dc.w $0CEE,$0AEE,$08EE,$06EE
		dc.w $0AEE,$08EE,$06EE,$04EE
		dc.w $08EE,$06EE,$04EE,$02EE
		dc.w $06EE,$04EE,$02EE,$00CC
		dc.w $04EE,$02EE,$00CC,$00AA

S3KSuperPalette:dc.w $EEC,$ECA,$EA8
		dc.w $EEE,$EEE,$EEE
		dc.w $CEC,$AEA,$2E0
		dc.w $EEE,$EEE,$EEE
		dc.w $AEC,$4EC,$0CC
		dc.w $EEE,$EEE,$EEE
		dc.w $CEE,$8EE,$4CE
		dc.w $EEE,$EEE,$EEE
		dc.w $EEE,$CCE,$AAE
		dc.w $EEE,$EEE,$EEE
		dc.w $EEE,$ECE,$CAC
		dc.w $EEE,$EEE,$EEE

FrameArtLockPtr	dc.l FrameArtS3K, FrameArtS2K, FrameArtBP, FrameArtSK
FrameArtPtr	dc.l FrameArtS1, FrameArtS2, FrameArtS3, FrameArtSK
; ===========================================================================
	space $5E000, S3
	cnop 0,$1000
	incbin "s3_3.bin"
	cnop 0,$080000

S1ROM:	incbin "s1/.bin"
	obj (offset(*)&$7FFFF)+$380000
; ===========================================================================

SndDrvInit:
	di
		move.w	#$100,Z80_bus_request
		move.w	#$100,Z80_reset		; release Z80 reset

		lea	kos_z80,a0
		lea	Z80_RAM,a1
		jsr	KosDec_			; load sound driver code to z80

		move.w	#0,Z80_RAM+$1C3C
		bra.s	ResetZ80		; reset Z80

PlaySound:
		tst.w	PlaySampleLen.w
		bpl.s	.rts
		lea	Z80_bus_request,a0
		bset	#0,(a0)
.wait		btst	#0,(a0)
		bne.s	.wait
		nop
		move.b	d0,Z80_RAM+$1C0A
		nop
		bclr	#0,(a0)
.rts		rts
; End of function SndDrvInit
; ===========================================================================

ResetZ80:
		move.w	#0,Z80_reset		; reset Z80
	rept 4
		nop
	endr
		move.w	#$100,Z80_reset		; release reset
		move.w	#0,Z80_bus_request	; start the Z80
		rts
; ===========================================================================

GenesisDoes:
		move.l	#$380000,$FFFFFFC4.w
		move.b	#$94,($FFFFF00A).w	; play music
		jsr	S1_SndDrv
		move.w	#$100,Z80_bus_request
		move.w	#$100,Z80_reset		; release Z80 reset
		lea	Z80_MegaPCM,a0
		lea	Z80_RAM,a1
		jsr	KosDec_

		bsr.s	ResetZ80
		stop	#$2300

		lea	Z80_bus_request,a0
		move.w	#$100,(a0)
.0		btst	#0,(a0)
		bne.s	.0
		move.b	#$81,$A01FFF
		move.w	#0,(a0)		; start the Z80

		move.w	#GenDoes_Len,PlaySampleLen.w
		btst	#6,HW_Version
		beq.s	.rts
		move.w	#GenDoes_Len*5/6,PlaySampleLen.w
.rts		rts
; End of function SoundDriverLoad
; ===========================================================================
	include "dat/sr/main.asm"
	include "dat/ssrg/ssrg_screen.asm"
SSRG_Logo_Bank1:incbin "dat\ssrg\Logo_Bnk1.4bpp.kos"
SSRG_Logo_Bank2:incbin "dat\ssrg\Logo_Bnk2.4bpp.kos"
	dc.b 'THERE ARE NO EASTER EGGS HERE! GO AWAY...'
BG_Art:		incbin "dat/bg.tiles.kos"
	objend
	space $280000, S1
	cnop 0,$080000

SKROM:	incbin "sk/1.bin"
ScalersData:

	obj (offset(*)&$7FFFF)+$200000
Kos_Scalers:	incbin "dat/scaler/scaler.kos"
; ===========================================================================
; Menu frame art for Sonic 1, Sonic 2, Sonic 3, Sonic & Knuckles, S3K, S2K
; and Blue Spheres!
; Lots of thanks for GF ThePlayer and VAdaPEGA! Also special thanks for
; GF, he dealt with me setting a very rigid standard of 15 max colors, and
; was still able to make so colorful images! Everyone give him a round of
; applause!
;
; The format is simple: each nibble represents a pixel, and 48 bytes
; represents a line of pixels. 96 total lines of pixels. Unlike regular art,
; this art is not tiled but is rather in a raw format, easily read by the
; scaling code. Saves a lot of cycles!
; ===========================================================================
FrameArtS1:	incbin "dat/gf.s1.art.slice.unc"
FrameArtS2:	incbin "dat/gf.s2.art.slice.unc"
FrameArtS3:	incbin "dat/gf.s3.art.slice.unc"
Kos_SR:		incbin "dat/sr/logo.kos"
Kos_SR_Emerald:	incbin "dat/sr/emerald.kos"
		dc.w $FF00
FanFicText:	incbin "dat/font/cave.dat"
	objend

	space $37DE30, SK
	cnop $5E2F+1,$8000
	incbin "sk/2.bin"
	cnop 0,$080000

S2ROM:	incbin "s2/0.bin"
	cnop 0,$080000

UPMEM:	incbin "UPMEM/.bin"
	even
; ===========================================================================

DebuggerOffs:
	obj (offset(*)&$7FFFF)+$300000
	include "ScalerMacros.asm"
	include "dat/font/font.asm"
	include "fw/DebuggerBlob.asm"
SSRG_Art_Sonic:	incbin "dat\ssrg\Sonic.4bpp.nem"
		even
SSRG_Art_Title:	incbin "dat\ssrg\Title.4bpp.nem"
		even

; full Game no Kanzume Otokuyou sound driver
; including music and SFX. Life is great sometimes :D
Kos_Z80:	incbin "dat/z80/z80.kos"
FrameArtS2K:	incbin "dat/gf.s2k.art.slice.unc"
FrameArtS3K:	incbin "dat/gf.s3k.art.slice.unc"
FrameArtSK:	incbin "dat/gf.sk.art.slice.unc"
FrameArtBP:	incbin "dat/gf.bp.art.slice.unc"
Z80_MegaPCM:	incbin "dat/pcm/.kos"
	cnop 0,$8000
S_GenDoes:	incbin "dat/pcm/Genesis Does.raw"
		even
	incbin "dat/TMSS.bin"
Cancel_Kos:	incbin "dat/cancel.art.kos"
	incbin "dat/shc/shc16_lol.png"
BG_Map:		incbin "dat/bg.map.eni"
	include "dat/ani/code.asm"
	objend
	space $600000, END
; ===========================================================================
	cnop 0,$080000
ENDROMS:
	PUSHS
o1	SECTION file("temp_checksums.dat"), org(0)
.offs	EQU offset(BankSwitchChecksums)
		dc.b "\$.offs"
	POPS
	END

; ===========================================================================
; NOTES:
; SSF mapper for emulators requires >4MB ROM image, else it wont activate
; Fusion supports ~12 banks while Regen supports 10 or 11
; Exodus does not support bank switching
; Gens re-recording unknown, but does not seem to support either
; Bizhawk supports up to 20 banks (0-19), or 10MB
;     ^ incorrect, the limitation has been raised to 32MB, or 64 banks
; other emulators untested
; Mega Everdrive should support up to 15MB
; ===========================================================================
; The ROM here operates by "splitting" each part of game to these 512KB banks,
; which are loaded differently depending on the game or thing we want to use.
; the obj command tells asm68k to pretend data or code is in certain position,
; which allows us to correctly set pointers to these locations, later to be
; ran at the specified offset by the 68000 processor.
; ===========================================================================
