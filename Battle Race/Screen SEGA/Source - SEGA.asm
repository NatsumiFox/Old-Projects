; ===========================================================================
; ---------------------------------------------------------------------------
; 00 - SEGA screen
; ---------------------------------------------------------------------------
R_ChunkRAM	=	$FFFF0000		; $A400
RW_ChunkRAM	=	R_ChunkRAM&$FFFFFF	; ^^ See above
; ---------------------------------------------------------------------------
R_VScrollBuffer	=	$00FF0000
R_ScrollSG	=	R_VScrollBuffer
R_ScrollEA	=	R_VScrollBuffer+$40
R_ScrollSG_Cur	=	R_VScrollBuffer+$80
R_ScrollEA_Cur	=	R_VScrollBuffer+$C0
R_RipplePos	=	$00FF2000
R_RippleAngle	=	$00FF2002
R_RippleSpeed	=	$00FF2004
SS_EventsCount	=	$00FF2008
SS_EventsTime	=	$00FF200A
SS_EventsRout	=	$00FF200C
R_PosS		=	$00FF2010
R_PosE		=	$00FF2014
R_PosG		=	$00FF2018
R_PosA		=	$00FF201C
R_Speeds	=	$00FF2020	; 10 bytes
SS_PalDelay	=	$00FF2030
SS_DisRaster	=	$00FF2034
SS_PalCount	=	$00FF2036
; SS_PalDelay	=	$00FF2038
SS_DMA		=	$00FF2040		; 8 bytes (6 plus padding)

R_WaterBuffer	=	$00FF3000
SS_EffectMap	=	$00FF4000
SS_SEGAMap	=	$00FF6000
; ---------------------------------------------------------------------------
DMA_SP:		macro	Size, Source, Destination
		move.l	#(((((Size/$02)<<$08)&$FF0000)+((Size/$02)&$FF))+$94009300),(a6)
		move.l	#((((((Source&$FFFFFF)/$02)<<$08)&$FF0000)+(((Source&$FFFFFF)/$02)&$FF))+$96009500),(a6)
		move.l	#(((((Source&$FFFFFF)/$02)&$7F0000)+$97000000)+((Destination>>$10)&$FFFF)),(a6)
		move.w	#((Destination&$FF7F)|$80),(a6)
		endm
; ---------------------------------------------------------------------------

SEGAScreen:
		jsr	SndDrvInit				; reinit the driver (just in-case someone soft resets)
		moveq	#$E0,d0					; set sound ID to "Stop Music"
		jsr	Play_Sound.w				; play sound ID
		moveq	#$00,d0					; slow music down
		jsr	Change_Music_Tempo.w			; ''
		jsr	Clear_KosM_Queue.w			; clear PLC list
		jsr	Pal_FadeToBlack				; fade the screen out

	; --- Setup/clearing ---

		move	#$2700,sr				; disable interrupts
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.l	#VInt,(V_int_addr).w			; force blank routines back to normal
		move.l	#HInt,(H_int_addr).w			; ''
		move.w	#$8000|%00010100,(a6)			; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)
		move.w	#$8100|%01110100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.w	#$8200|((($A000)>>$0A)&$FF),(a6)	; 00FE DCBA - Scroll Plane A Map Table VRam address
		move.w	#$8300|((($F000)>>$0A)&$FF),(a6)	; 00FE DCB0 / 00FE DC00 (20 H-resol) - Window Plane A Map Table VRam address
		move.w	#$8400|((($E000)>>$0D)&$FF),(a6)	; 0000 0FED - Scroll Plane B Map Table VRam address
		move.w	#$8500|((($D800)>>$09)&$FF),(a6)	; 0FED CBA9 / 0FED CBA0 (20 H-resol) - Sprite Plane Map Table VRam address
		move.w	#$8600|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8700|$20,(a6)				; 00PP CCCC - Backdrop Colour: Palette Line | Colour ID
		move.w	#$8800|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8900|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8A00|$DF,(a6)				; 7654 3210 - H-Interrupt Register
		move.w	#$8B00|%00000111,(a6)			; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)
		move.w	#$8C00|%10000001,(a6)			; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
		move.w	#$8D00|((($DC00)>>$0A)&$FF),(a6)	; 00FE DCBA - Horizontal Scroll Table VRam address
		move.w	#$8E00|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8F00|$02,(a6)				; 7654 3210 - Auto Increament
		move.w	#$9000|%00000011,(a6)			; 00VV 00HH - Plane Y Size (00-20|01-40|11-80) | Plane X size (00-20|01-40|11-80)
		move.w	#$9100|$00,(a6)				; 7654 3210 - Window Horizontal Position
		move.w	#$9200|$00,(a6)				; 7654 3210 - Window Vertical Position

	; --- VDP Memory ---

		move.l	#$40000080,d0				; VRAM
		move.w	#$FFFF,d1				; size to clear
		jsr	ClearVDP				; clear VDP memory section

		move.l	#$40000090,d0				; VSRAM
		move.w	#$0080,d1				; size to clear
		jsr	ClearVDP				; clear VDP memory section

		move.l	#$40000010,(a6)				; set VDP to VSRAM write mode
		move.l	#$00000000,(a5)				; set final frame's FG and BG positions

	; --- Clearing ---

		moveq	#$00,d0					; clear d0
		lea	($00FF0000).l,a1			; load start of ram
		move.w	#($E380/$04)-1,d7			; set number of bytes to clear

SS_ClearRAM:
		move.l	d0,(a1)+				; clear RAM
		dbf	d7,SS_ClearRAM				; repeat til cleared

	move.l	d0,(V_scroll_value).w

	; --- Loading data ---

		moveq	#$20,d2					; write to VRAM address 0020
		lea	(Art_SEGA).l,a1				; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping

		move.w	#$2000,d2				; write to VRAM address 2000
		lea	(Art_SEGA_Full).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping

		move.w	#$4000,d2				; write to VRAM address 4000
		lea	(Art_SEGA_Eff1).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping
		move.w	#$7000,d2				; write to VRAM address 7000
		lea	(Art_SEGA_Eff2).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping

		lea	(RW_ChunkRAM).l,a1			; load dump address
		lea	(Map_SEGA).l,a0				; load enigma compressed mappings address
		jsr	Kos_Decomp				; decompress and dump to RAM

		lea	(SS_SEGAMap).l,a1			; load dump address
		lea	(Map_SEGA_Full).l,a0			; load enigma compressed mappings address
		jsr	Kos_Decomp				; decompress and dump to RAM

		lea	(SS_EffectMap).l,a1			; load dump address
		lea	(Map_SEGA_Eff1).l,a0			; load enigma compressed mappings address
		jsr	Kos_Decomp				; decompress and dump to RAM
		lea	(SS_EffectMap+$1000).l,a1		; load dump address
		lea	(Map_SEGA_Eff2).l,a0			; load enigma compressed mappings address
		jsr	Kos_Decomp				; decompress and dump to RAM

	; --- Decompress Kos Module data ---

SS_DelayLoad:
		move.b	#2,(V_int_routine).w
		jsr	Process_Kos_Queue
		jsr	Wait_VSync
		jsr	Process_Kos_Module_Queue.w
		tst.l	(Kos_module_queue).w
		bne.s	SS_DelayLoad

		move.b	#2,(V_int_routine).w		; needed to finish decompression
		jsr	Wait_VSync

	; ---- Loading more data ---

		move	#$2700,sr				; disable interrupts
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.l	#HB_SEGAScreen,(H_int_addr).w		; set H-blank routine
		move.l	#VB_SEGAScreen,(V_int_addr).w		; set V-blank routine
		move.l	#$01000000,d3				; set line advance amount

		; S-G-

		lea	(RW_ChunkRAM).l,a1			; load mappings address
		move.l	#$65100002,d0				; set VDP mode/address (C000)
		moveq	#$18-1,d1				; set width
		moveq	#$08-1,d2				; set height
		jsr	SZ_MapScreen				; dump mappings

		; -E-A

		lea	(RW_ChunkRAM+$180).l,a1			; load mappings address
		move.l	#$65100003,d0				; set VDP mode/address (C000)
		moveq	#$18-1,d1				; set width
		moveq	#$08-1,d2				; set height
		jsr	SZ_MapScreen				; dump mappings

		; changing palette for reflected versions

		lea	(RW_ChunkRAM).l,a1			; load mappings address
		move.w	#($0300/$04)-1,d7			; set number of map tiles to write
		move.l	#$30003000,d0				; prepare OR value

SS_ChangeMap:
		or.l	d0,(a1)+				; change palette lines
		dbf	d7,SS_ChangeMap				; repeat for number of mappings
		move.l	#$FF000000,d3				; set line advance amount

		; S-G-

		lea	(RW_ChunkRAM).l,a1			; load mappings address
		move.l	#$6D900002,d0				; set VDP mode/address (C000)
		moveq	#$18-1,d1				; set width
		moveq	#$08-1,d2				; set height
		jsr	SZ_MapScreen				; dump mappings

		; -E-A

		lea	(RW_ChunkRAM+$180).l,a1			; load mappings address
		move.l	#$6D900003,d0				; set VDP mode/address (C000)
		moveq	#$18-1,d1				; set width
		moveq	#$08-1,d2				; set height
		jsr	SZ_MapScreen				; dump mappings

	; --- Finalising ---

		moveq	#$00,d0					; clear d0
		lea	(H_scroll_buffer).w,a1			; load H-scroll buffer ram
		move.w	#($240/$04)-1,d7			; set number of scanlines above the water

SS_ClearHScroll:
		move.l	d0,(a1)+				; clear top half (where normal letters are)
		dbf	d7,SS_ClearHScroll			; repeat til done

		move.l	#$02000200,d0				; prepare scanline position to right side (where reflectio letters are)
		moveq	#($0140/$04)-1,d7

SS_SetHScroll:
		move.l	d0,(a1)+				; set bottom half (where reflection letters are)
		dbf	d7,SS_SetHScroll			; repeat for all reflection letters are

		move.w	#(R_WaterBuffer&$FFFF),(R_RipplePos).l	; reset ripple position to the start
		move.l	#SSE_Start,(SS_EventsRout).l		; set starting events routine


	move.l	#$00009700,(SS_DMA).l
	move.l	#$96009500,(SS_DMA+$04).l

		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port

		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank

		bsr.s	SS_Subroutines				; run subroutines

		; Palette

		lea	(Pal_SEGA).l,a0				; load palette
		lea	(Target_palette).w,a1			; load main palette buffer
		move.w	#($0080/$04)-1,d7			; set number of colours to flush

SS_LoadPal:
		move.l	(a0)+,(a1)+				; copy colours over
		dbf	d7,SS_LoadPal				; repeat for number of colours

		jsr	Pal_FadeFromBlack			; fade to colour

; ---------------------------------------------------------------------------
; SEGA Screen loops
; ---------------------------------------------------------------------------

	; --- Running intro effect ---

ML_SEGAScreen:
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank
		bsr.s	SS_Subroutines				; run subroutines
		tst.b	(Ctrl_1_pressed).w			; was start button pressed?
		bpl.s	MLSS_NoStart				; if not, branch
		move.b	#$54,(Game_mode).w			; finish SEGA screen

MLSS_NoStart:
		tst.b	(Game_mode).w				; is the game mode still set to 00 (SEGA Screen)?
		beq.s	ML_SEGAScreen				; if so, branch
		rts						; return

; ---------------------------------------------------------------------------
; Subroutines for the SEGA screen
; ---------------------------------------------------------------------------

SS_Subroutines:
		bsr.w	SS_Events				; run events routines
		bsr.w	SS_ScrollPos				; write the letter scroll positions
						; continue to..	; make the bottom water ripple

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to make the reflection/water ripple
; ---------------------------------------------------------------------------

SS_WaterRipple:
		moveq	#$FF,d0				; prepare RAM address
		move.w	(R_RipplePos).l,d0			; load ripple position RAM
		subq.w	#$02,d0					; move it back a position
		cmp.w	#(R_WaterBuffer&$FFFF),d0		; has it gone below the start?
		bcc.s	SSWR_NoWrap				; if so, branch
		addi.w	#$0140/$02,d0				; advace to the end

SSWR_NoWrap:
		move.w	d0,(R_RipplePos).l			; update ripple position
		move.w	d0,d7					; load position to d7
		subi.w	#(R_WaterBuffer&$FFFF),d7		; get distance from start
		lsr.w	#$01,d7					; divide by 2 for a word count
		move.w	#($0140/$04)-$01,d6			; prepare maximum word count
		sub.w	d7,d6					; get the difference (copying the scroll is split into two)
		move.l	d0,a0					; set address

		lea	(SineTable).l,a1			; load sinewave table
		moveq	#$00,d0					; clear d0
		move.b	(R_RippleAngle).l,d0			; load angle
		addi.w	#$2000,(R_RippleAngle).l		; rotate angle
		add.w	d0,d0					; multiply by size of word
		move.w	(a1,d0.w),d0				; load correct sinewave position
		asr.w	#$04,d0					; slow it down correctly
		move.w	d0,(a0)					; save to ripple position

		move.w	(R_RippleSpeed).l,d3			; load the ripple speed to expand by
		move.w	#$0000,d4				; clear current distance
		moveq	#$05-1,d5				; set number of lines to expand by

		lea	(H_scroll_buffer+$240).w,a1		; load H-scroll buffer ram
		bsr.s	SSWR_WriteScroll			; write the scroll positions correctly
		subq.w	#$01,d7					; minus 1 from second half
		bmi.s	SSWR_Finish				; if there is no second half to do (i.e. first half did all), then branch
		move.w	d7,d6					; copy to d6 (subroutine uses d6 not d7)
		lea	(R_WaterBuffer).l,a0			; reload from start of buffer
						; continue to..	; write the scroll positions correctly

SSWR_WriteScroll:
		move.w	(a0)+,d0				; load position
		muls.w	d4,d0					; multiply by current position
		asr.l	#$08,d0					; divide by 100
		addi.w	#$0200,d0				; advance to right (where the reflection letters are)
		move.w	d0,(a1)+				; save to both FG and BG
		move.w	d0,(a1)+				; ''
		dbf	d5,SSWR_Expand				; decrease expanding counter
		clr.w	d5					; counter has finished, keep it finished
		subq.w	#$04,d4					; contract ripples
		bcc.s	SSWR_NoStop				; if it's not passed 0, branch
		moveq	#$00,d4					; keep at 0 (ripples are finished)

SSWR_NoStop:
		dbf	d6,SSWR_WriteScroll			; repeat for all scanlines of this section

SSWR_Finish:
		rts						; return

SSWR_Expand:
		add.w	d3,d4					; expand ripples
		dbf	d6,SSWR_WriteScroll			; repeat for all scanlines of this section
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write each letter's position correctly
; ---------------------------------------------------------------------------

SS_ScrollPos:
		lea	(R_ScrollSG).l,a1			; load S and G scroll positions
		move.w	(R_PosS).l,d0				; load S
		move.w	d0,(a1)+				; write S positions
		move.w	d0,(a1)+				; ''
		move.w	d0,(a1)+				; ''
		move.w	d0,(a1)+				; ''
		move.w	d0,(a1)+				; ''
		move.w	(R_PosG).l,d0				; load G
		move.w	d0,(a1)+				; write G positions
		move.w	d0,(a1)+				; ''
		move.w	d0,(a1)+				; ''
		move.w	d0,(a1)+				; ''
		move.w	d0,(a1)+				; ''
		lea	(R_ScrollEA).l,a1			; load E and A scroll positions
		move.w	(R_PosE).l,d0				; load E
		move.w	d0,(a1)+				; write E positions
		move.w	d0,(a1)+				; ''
		move.w	d0,(a1)+				; ''
		move.w	d0,(a1)+				; ''
		move.w	d0,(a1)+				; ''
		move.w	(R_PosA).l,d0				; load A
		move.w	d0,(a1)+				; write A positions
		move.w	d0,(a1)+				; ''
		move.w	d0,(a1)+				; ''
		move.w	d0,(a1)+				; ''
		move.w	d0,(a1)+				; ''
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to run and control the letters in a specific way (i.e. events)
; ---------------------------------------------------------------------------

SS_Events:
		move.l	(SS_EventsRout).l,a0			; load events routine
		jmp	(a0)					; run that routine

; ---------------------------------------------------------------------------
; Events - Startup/init/setup
; ---------------------------------------------------------------------------

SSE_Start:
		move.l	#$FF800000,d0				; set starting positions
		move.l	d0,(R_PosS).l				; ''
		move.l	d0,(R_PosE).l				; ''
		move.l	d0,(R_PosG).l				; ''
		move.l	d0,(R_PosA).l				; ''
		move.w	#$0010,(R_RippleSpeed).l		; set starting ripple speed
		move.l	#SSE_Lift,(SS_EventsRout).l		; set next routine
		move.w	#$0020,(SS_EventsTime).l		; set delay time before starting
		move.w	#$FFFF,(SS_EventsCount).l		; reset counter
		rts						; return

; ---------------------------------------------------------------------------
; Events - Lifting letters up
; ---------------------------------------------------------------------------

SSE_List:	dc.l	R_PosS, R_PosE, R_PosG, R_PosA

SSE_Lift:
		subq.w	#$01,(SS_EventsTime).l			; decrease events timer
		bpl.s	SSEL_NoNewLift				; if the timer is still running, branch
		move.w	#$0020,(SS_EventsTime).l		; increase timer
		move.w	(SS_EventsCount).l,d0			; load counter
		addq.w	#$01,d0					; increase counter
		cmpi.w	#$0004,d0				; has it reached 4 or higher?
		bhs.s	SSEL_NoNewLift				; if so, branch
		move.w	d0,(SS_EventsCount).l			; update counter
		add.b	d0,d0					; multiply by size of long-word
		add.b	d0,d0					; ''
		lea	(R_Speeds).l,a1				; load speed RAM
		adda.w	d0,a1					; advance to correct letter's speed
		move.l	#$00080000,(a1)				; set starting speed

SSEL_NoNewLift:
		move.w	(SS_EventsCount).l,d7			; load lift counter
		bmi.s	SSEL_NoLift				; if there's no letters to lift, branch

SSEL_NextLift:
		move.w	d7,d0					; load letter count
		add.b	d0,d0					; multiply by size of long-word
		add.b	d0,d0					; ''
		move.l	SSE_List(pc,d0.w),a0			; load correct letter's position
		lea	(R_Speeds).l,a1				; load speed RAM
		adda.w	d0,a1					; advance to correct letter's speed
		move.l	(a1),d0					; load speed
		cmpi.l	#$00000001,d0				; is the speed still positive (moving up)?
		bgt.s	SSEL_NoCheckBounce			; if so, branch
		tst.b	d0					; has the bounce flag been set?
		beq.s	SSEL_MoveSpeed				; if not, branch
		moveq	#$01,d0					; set no speed (but keep the bounce flag set)
		cmpi.w	#$0003,d7				; is this the last letter that's finished?
		bne.s	SSEL_NoMoveSpeed			; if not, branch
		move.l	#SSEL_Sound,(SS_EventsRout).l		; set new routine
		bra.s	SSEL_NoMoveSpeed			; continue to finish all the letters

SSEL_MoveSpeed:
		move.w	(a0),d1					; load position
		cmpi.w	#$FFC4,d1				; has it hit the water?
		bgt.s	SSEL_NoCheckBounce			; if not, branch
		neg.l	d0					; reverse direction
		asr.l	#$01,d0					; slot it down
		move.l	d0,d1					; ''
		asr.l	#$02,d1					; ''
		sub.l	d1,d0					; ''
		addi.l	#$00002000,d0				; speed it up just a bit to stop in the right place
		move.b	#$01,d0					; set bounce flag
		move.w	#$0020,(R_RippleSpeed).l		; set ripple speed

SSEL_NoCheckBounce:
		subi.l	#$00002000,d0				; decrease speed

SSEL_NoMoveSpeed:
		move.l	d0,(a1)					; update speed
		add.l	d0,(a0)					; add speed to position
		dbf	d7,SSEL_NextLift			; repeat for all letters

SSEL_NoLift:
		cmpi.w	#$0010,(R_RippleSpeed).l		; is the ripple speed at normal "calm"?
		beq.s	SSEL_NoReduceRipple			; if so, branch
		subi.l	#$00004000,(R_RippleSpeed).l		; decrease ripple speed until "calm"

SSEL_NoReduceRipple:
		rts						; return

; ---------------------------------------------------------------------------
; Events - Sound
; ---------------------------------------------------------------------------

SSEL_Sound:
		subi.l	#$00009000,(R_RippleSpeed).l		; decrease ripple
		cmpi.l	#$000C0000,(R_RippleSpeed).l		; has it reached enough for palette to fade and hide the reflection?
		bpl.w	SSEL_NoSound				; if not, branch
		moveq	#$00,d0					; clear d0
		move.l	d0,(R_RippleSpeed).l			; set no ripple speed

		move	#$2700,sr
		move.w	#$0100,($A11100).l			; request Z80 stop (ON)
		btst.b	#$00,($A11100).l			; has the Z80 stopped yet?
		bne.s	*-$08					; if not, branch
		move.b	#$2B,($A04000).l			; set YM2612 to DAC switch address
		lea	(SegaPCM).l,a2				; Load the SEGA PCM sample into a2. It's important that we use a2 since a0 and a1 are going to be used up ahead when reading the joypad ports
		move.b	#$80,($A04001).l			; enable DAC (disable FM6)
		move.l	#(SegaPCM_End-SegaPCM),d3		; Load the size of the SEGA PCM sample into d3
		move.b	#$2A,($A04000).l			; set YM2612 to DAC port address

		lea	(HW_Port_1_Data).l,a1			; load controller port address for control pad 1

PlayPCM_Loop:
		move.b	#$00,(a1)				; Poll controller data port
		move.b	(a2)+,($A04001).l			; Write the PCM data (contained in a2) to $A04001 (YM2612 register D0)
		moveq	#$19,d0					; Write the pitch ($14 in this case) to d0
		dbf	d0,*					; Decrement d0; jump to itself if not 0. (for pitch control, avoids playing the sample too fast)

		move.b	(a1),d1					; Get controller port data (start/A)
		btst.l	#$05,d1					; was start button pressed?
		bne.s	PlayPCM_NoBreak				; if not, branch
		move.b	#$54,(Game_mode).w			; change game mode
		moveq	#$01,d3					; force sample to finish playing

PlayPCM_NoBreak:
		subq.l	#$01,d3					; Subtract 1 from the PCM sample size
		bne.s	PlayPCM_Loop				; If d3 = 0, we finished playing the PCM sample, so stop playing, leave this loop, and unfreeze the 68K
		move.w	#$0000,($A11100).l			; request Z80 stop (OFF)

	; --- Due to flickering, H-blank is disabled first ---

		st.b	(SS_DisRaster).l			; disable raster effects
	btst.b	#$06,(Graphics_flags).w			; is this a PAL machine?
	bne.s	SSEL_50Hz				; if so, branch
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank
		move.l	#NullBlank,(H_int_addr).w		; set H-blank routine

SSEL_50Hz:
		move.l	#VB_SEGAScreenStretch,(V_int_addr).w	; set V-blank routine
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank
	move.l	#NullBlank,(H_int_addr).w
		move.l	#SSE_StretchOut,(SS_EventsRout).l	; set new routine
		clr.w	(SS_EventsCount).l			; clear counter
		move.w	#$0040,(SS_PalDelay).l			; set red palette timer
		rts						; return

SSEL_NoSound:
		subq.b	#$01,(SS_PalDelay).l			; decrease palette delay time
		bpl.s	SSEL_NoPalChange			; if still running, branch
		move.b	#$03,(SS_PalDelay).l			; reset delay timer
		moveq	#$00,d0					; clear d0

		lea	(Normal_palette+$22).w,a1		; load start of palette
		moveq	#$05-1,d7				; set number of colours to fade into white

SSEL_NextColour:
		addq.w	#$01,a1					; skip blue (always E)
		move.b	(a1),d0					; load green and red
		move.b	SSEL_PalSwap(pc,d0.w),(a1)+		; advance them both to E
		dbf	d7,SSEL_NextColour			; repeat for number of colours

SSEL_NoPalChange:
		rts						; return

SSEL_PalSwap:	dc.b	$22,$22,$24,$24,$26,$26,$28,$28,$2A,$2A,$2C,$2C,$2E,$2E,$2E,$2E
		dc.b	$22,$22,$24,$24,$26,$26,$28,$28,$2A,$2A,$2C,$2C,$2E,$2E,$2E,$2E
		dc.b	$42,$42,$44,$44,$46,$46,$48,$48,$4A,$4A,$4C,$4C,$4E,$4E,$4E,$4E
		dc.b	$42,$42,$44,$44,$46,$46,$48,$48,$4A,$4A,$4C,$4C,$4E,$4E,$4E,$4E
		dc.b	$62,$62,$64,$64,$66,$66,$68,$68,$6A,$6A,$6C,$6C,$6E,$6E,$6E,$6E
		dc.b	$62,$62,$64,$64,$66,$66,$68,$68,$6A,$6A,$6C,$6C,$6E,$6E,$6E,$6E
		dc.b	$82,$82,$84,$84,$86,$86,$88,$88,$8A,$8A,$8C,$8C,$8E,$8E,$8E,$8E
		dc.b	$82,$82,$84,$84,$86,$86,$88,$88,$8A,$8A,$8C,$8C,$8E,$8E,$8E,$8E
		dc.b	$A2,$A2,$A4,$A4,$A6,$A6,$A8,$A8,$AA,$AA,$AC,$AC,$AE,$AE,$AE,$AE
		dc.b	$A2,$A2,$A4,$A4,$A6,$A6,$A8,$A8,$AA,$AA,$AC,$AC,$AE,$AE,$AE,$AE
		dc.b	$C2,$C2,$C4,$C4,$C6,$C6,$C8,$C8,$CA,$CA,$CC,$CC,$CE,$CE,$CE,$CE
		dc.b	$C2,$C2,$C4,$C4,$C6,$C6,$C8,$C8,$CA,$CA,$CC,$CC,$CE,$CE,$CE,$CE
		dc.b	$E2,$E2,$E4,$E4,$E6,$E6,$E8,$E8,$EA,$EA,$EC,$EC,$EE,$EE,$EE,$EE
		dc.b	$E2,$E2,$E4,$E4,$E6,$E6,$E8,$E8,$EA,$EA,$EC,$EC,$EE,$EE,$EE,$EE
		dc.b	$E2,$E2,$E4,$E4,$E6,$E6,$E8,$E8,$EA,$EA,$EC,$EC,$EE,$EE,$EE,$EE
		dc.b	$E2,$E2,$E4,$E4,$E6,$E6,$E8,$E8,$EA,$EA,$EC,$EC,$EE,$EE,$EE,$EE


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write SEGA mapping tiles correctly to a plane (this basically
; just ensures that the top right two tiles don't write
; --- Inputs ----------------------------------------------------------------
; d3.l = Line advance value
; d0.l = VRAM address of plane to write to
; d1.w = X size
; d2.w = Y size
; ---------------------------------------------------------------------------

SS_MapSEGA:
		move.l	d0,(a6)					; set VDP to VRAM write mode
		add.l	d3,d0					; advance to next line
		move.w	d1,d4					; load X size
		subq.w	#$02,d4					; minus 2 (skip end 2 tiles)

SS_MapColumn1:
		move.w	(a1)+,(a5)				; copy tile mappings over
		dbf	d4,SS_MapColumn1			; repeat until all done
		addq.w	#$04,a1					; advance passed the end two tiles
		dbf	d2,SSMS_Next1				; repeat for all rows
		rts						; return

SSMS_Next1:
		move.l	d0,(a6)					; set VDP to VRAM write mode
		add.l	d3,d0					; advance to next line
		move.w	d1,d4					; load X size
		subq.w	#$01,d4					; minus 1 (skip end tile)

SS_MapColumn2:
		move.w	(a1)+,(a5)				; copy tile mappings over
		dbf	d4,SS_MapColumn2			; repeat until all done
		addq.w	#$02,a1					; advance passed the end tile
		dbf	d2,SSMS_Next2				; repeat for all rows
		rts						; return

SSMS_Next2:
		move.l	d0,(a6)					; set VDP to VRAM write mode
		add.l	d3,d0					; advance to next line
		move.w	d1,d4					; load X size
		subq.w	#$01,d4					; minus 1 (skip end tile)

SS_MapColumn3:
		move.w	(a1)+,(a5)				; copy tile mappings over
		dbf	d4,SS_MapColumn3			; repeat until all done
		addq.w	#$02,a1					; advance passed the end tile
		dbf	d2,SSMS_Next3				; repeat for all rows
		rts						; return

SSMS_Next3:
		move.l	d0,(a6)					; set VDP to VRAM write mode
		add.l	d3,d0					; advance to next line
		move.w	d1,d4					; load X size
		subq.w	#$01,d4					; minus 1 (skip end tile)

SS_MapColumn4:
		move.w	(a1)+,(a5)				; copy tile mappings over
		dbf	d4,SS_MapColumn4			; repeat until all done
		addq.w	#$02,a1					; advance passed the end tile
		dbf	d2,SSMS_Next4				; repeat for all rows
		rts						; return

SSMS_Next4:
		jmp	SZ_MapScreenDMA				; continue to normal map screen subroutine and continue the rest

; ===========================================================================
; ---------------------------------------------------------------------------
; Events - Stretching out
; ---------------------------------------------------------------------------

SSE_StretchOut:
		bsr.s	SSESO_BluePalette

		subq.w	#$01,(SS_PalDelay).l
		bpl.s	SSESO_NoRed
		clr.w	(SS_PalDelay).l
		move.w	(SS_PalCount).l,d0
		cmpi.w	#$0036,d0
		bhs.s	SSESO_NoRed
		addq.w	#$02,(SS_PalCount).l
		lea	(Normal_palette+$40).l,a1			; load palette buffer
		add.w	d0,a1
		cmpi.w	#$0018,d0
		blo.s	SSESO_NoRedSkip
		lea	$0A(a1),a1				; advance to second line

SSESO_NoRedSkip:
		move.w	#$0800,(a1)

SSESO_NoRed:
		rts						; return

SSESO_BluePalette:
		move.w	(SS_EventsCount).l,d5			; load counter
		cmpi.w	#$0016-2,d5				; has it reached the point where the original logo should disappear?
		bne.s	SSESO_NoBlank				; if not, branch

		lea	(RW_ChunkRAM+$1000).l,a1		; load mappings address
		move.l	#$69100002,d0				; set VDP mode/address (C000)
		moveq	#$18-1,d1				; set width
		moveq	#$08-1,d2				; set height
		move.l	#$01000000,d3				; set line advance amount
		jsr	SS_MapSEGA				; dump mappings

SSESO_NoBlank:
		cmpi.w	#SSESO_List_End-SSESO_List,d5		; has it reached the end?
		beq.s	SSESO_Finish				; if so, branch

		subq.w	#$01,(SS_EventsTime).l			; decrease delay timer
		bpl.s	SSESO_Delay				; if still running, branch
		move.w	#$01,(SS_EventsTime).l			; reset timer
		addq.w	#$02,d5					; increase by 2

SSESO_Delay:
		move.w	d5,(SS_EventsCount).l			; update counter
		lea	SSESO_List(pc,d5.w),a0			; load correct starting point
		lea	(Normal_palette+$40).l,a1			; load palette buffer
		move.l	(a0)+,(a1)+				; dump palette
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		lea	$0A(a1),a1				; advance to second line
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.w	(a0)+,(a1)+				; ''
		rts						; return

SSESO_Finish:
		move.b	#$54,(Game_mode).w			; change the game/screen mode

SSESO_Wait:
		rts						; return

SSESO_List:	dc.w	$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE
		dc.w	$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE
		dc.w	$0800,$0800,$0800,$0800,$0800,$0800,$0800
		dc.w	$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE,$0EEE
		dc.w	$0800,$0800,$0800,$0800,$0800
SSESO_List_End:	dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank routine (Stretching setup)
; ---------------------------------------------------------------------------

VB_SEGAScreenStretch:
		move.w	#$8F00|$02,(a6)				; restore increment amount
		movem.l	d0-a4,-(sp)				; store register data

		DMA_SP	$0080, Normal_palette, $C0000000	; palette

		move.l	#$01000000,d3				; set line advance amount

		lea	(SS_EffectMap).l,a1			; load mappings address
		move.l	#$60000002,d0				; set VDP mode/address (C000)
		moveq	#$28-1,d1				; set width
		moveq	#$1C-1,d2				; set height
		jsr	SZ_MapScreenDMA				; dump mappings

		move.l	#VB_SEGAScreen,(V_int_addr).w		; set V-blank routine back to normal

		lea	(SS_SEGAMap).l,a1			; load mappings address
		move.l	#$69100002,d0				; set VDP mode/address (C000)
		moveq	#$18-1,d1				; set width
		moveq	#$08-1,d2				; set height
		jsr	SS_MapSEGA				; dump mappings

		move.w	#$8B00|%00000000,(a6)			; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)

		lea	(SS_EffectMap+$1000).l,a1		; load mappings address
		move.l	#$60000003,d0				; set VDP mode/address (C000)
		moveq	#$28-1,d1				; set width
		moveq	#$1C-1,d2				; set height
		jsr	SZ_MapScreenDMA				; dump mappings

		bra.s	VBSS_Cont				; continue

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank routine (Standard)
; ---------------------------------------------------------------------------

VB_SEGAScreen:
		btst.b	#$06,(Graphics_flags).w			; was the console region set to NTSC?
		beq.s	VBSS_RunRoutine				; if so, branch (NTSC doesn't have a boarder, it's stretched)
		move.l	d0,-(sp)				; store d0
		move.w	#$0700,d0				; set delay time for the screen to finish drawing the frame properly

VBSS_WaitBoarder:
		dbf	d0,VBSS_WaitBoarder			; PAL has a colour boarder, artifacts can show up if the transfers are made before the boarders are finished being drawn, hence the delay here
		move.l	(sp)+,d0				; restore d0

VBSS_RunRoutine:
		move.w	#$8F00|$02,(a6)				; restore increment amount
		tst.b	(V_int_routine).w			; was the 68k late?
		beq.w	VBSS_68kLate				; if so, branch

		movem.l	d0-a4,-(sp)				; store register data
		DMA_SP	$0080, Normal_palette, $C0000000	; palette

VBSS_Cont:
		DMA_SP	$0380, H_scroll_buffer, $5C000003	; h-scroll
		tst.b	(SS_DisRaster).l			; has raster been disabled?
		bne.s	VBSS_NoRaster				; if so, branch

		move.w	#$8F00|$04,(a6)				; set increment to 4
		DMA_SP	$0012, R_ScrollSG, $40100010		; v-scroll FG
		DMA_SP	$0014, R_ScrollEA, $401A0010		; v-scroll BG
		move.w	#$8F00|$02,(a6)				; restore

		move.w	#$8A00|$47,(a6)				; 7654 3210 - H-Interrupt Register
		move.w	#$8F00|$04,(a6)				; set increment to 4
		move.l	#HB_SEGAScreen,(H_int_addr).w		; set H-blank routine

	; --- Readjusting H-scroll positions ---

		move.w	#$0078,d1				; set reflection adjustment position
		lea	(R_ScrollSG).l,a0			; load S and G RAM scroll buffers
		lea	(R_ScrollSG_Cur).l,a1			; ''
		move.w	#$000A-1,d7				; set number of scroll positions to adjust
		bsr.w	VBSS_AdjustScroll			; adjust S and G positions correctly
		lea	(R_ScrollEA).l,a0			; load E and A RAM scroll buffers
		lea	(R_ScrollEA_Cur).l,a1			; ''
		move.w	#$000A-1,d7				; set number of scroll positions to adjust
		bsr.w	VBSS_AdjustScroll			; adjust E and A positions correctly


VBSS_NoRaster:
		movem.l	(sp)+,d0-a4				; restore register data

; ---------------------------------------------------------------------------
; V-blank routine (No-VDP access)
; ---------------------------------------------------------------------------

VBSS_68kLate:
		move.w	(sp)+,-$06(sp)				; copy sr back
		pea	VBO_SEGAScreen(pc)			; force new return address
		subq.w	#$02,sp					; move back to sr space

NullBlank:
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to adjust the scroll positions for H-blank
; ---------------------------------------------------------------------------

VBSS_AdjustScroll:
		move.w	(a0)+,d0				; load scroll position
		neg.w	d0					; reverse direction
		add.w	d1,d0					; adjust position correctly for reflection
		move.w	d0,(a1)+				; save new scroll position
		dbf	d7,VBSS_AdjustScroll			; repeat for all positions
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank routine outside exception (H-blank may interrupt here if necessary)
; ---------------------------------------------------------------------------

VBO_SEGAScreen:
		move.w	sr,-(sp)				; store sr in the stack
		movem.l	d0-a6,-(sp)				; store register data
		tst.b	(V_int_routine).w			; was the 68k late?
		beq.s	VBOSS_68kLate				; if so, branch
	;	jsr	ReadControls				; read the controller pads
		jsr	Poll_Controllers

VBOSS_68kLate:
		sf.b	(V_int_routine).w			; clear V-blank flag
	;	jsr	SoundDriver				; run sound driver
		movem.l	(sp)+,d0-a6				; restore register data
		rtr						; return and restore ccr

; ===========================================================================
; ---------------------------------------------------------------------------
; H-blank routine
; ---------------------------------------------------------------------------

HB_SEGAScreen:
		move.l	#HBSS_Reflect,(H_int_addr).w		; set H-blank routine
		move.w	#$8A00|$01,(a6)				; 7654 3210 - H-Interrupt Register
		rte						; return

HBSS_Reflect:
		move.l	a0,usp					; store a0
		lea	(R_ScrollSG_Cur).l,a0			; load S and G scroll positions
		move.l	#$400C0010,(a6)				; set VDP to FG's VSRAM
		move.l	(a0),(a5)				; write scroll positions...
		addq.w	#$02,(a0)+				; ...and avance for next scanlines
		addq.w	#$02,(a0)+				; ''
		move.l	(a0),(a5)				; ''
		addq.w	#$02,(a0)+				; ''
		addq.w	#$02,(a0)+				; ''
		move.l	(a0),(a5)				; ''
		addq.w	#$02,(a0)+				; ''
		addq.w	#$02,(a0)+				; ''
		move.l	(a0),(a5)				; ''
		addq.w	#$02,(a0)+				; ''
		addq.w	#$02,(a0)+				; ''
		move.l	(a0),(a5)				; ''
		addq.w	#$02,(a0)+				; ''
		addq.w	#$02,(a0)+				; ''
		lea	(R_ScrollEA_Cur).l,a0			; load E and A scroll positions
		move.l	#$401A0010,(a6)				; set VDP to BG's VSRAM
		move.l	(a0),(a5)				; write scroll positions...
		addq.w	#$02,(a0)+				; ...and avance for next scanlines
		addq.w	#$02,(a0)+				; ''
		move.l	(a0),(a5)				; ''
		addq.w	#$02,(a0)+				; ''
		addq.w	#$02,(a0)+				; ''
		move.l	(a0),(a5)				; ''
		addq.w	#$02,(a0)+				; ''
		addq.w	#$02,(a0)+				; ''
		move.l	(a0),(a5)				; ''
		addq.w	#$02,(a0)+				; ''
		addq.w	#$02,(a0)+				; ''
		move.l	(a0),(a5)				; ''
		addq.w	#$02,(a0)+				; ''
		addq.w	#$02,(a0)+				; ''
		move.l	usp,a0					; restore a0
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write mapping tiles correctly to a plane
; --- Inputs ----------------------------------------------------------------
; d3.l = Line advance value
; d0.l = VRAM address of plane to write to
; d1.w = X size
; d2.w = Y size
; ---------------------------------------------------------------------------

SZ_MapScreen:
		move.l	d0,(a6)					; set VDP to VRAM write mode
		add.l	d3,d0					; advance to next line
		move.w	d1,d4					; load X size

SZ_MapColumn:
		move.w	(a1)+,(a5)				; copy tile mappings over
		dbf	d4,SZ_MapColumn				; repeat until all done
		dbf	d2,SZ_MapScreen				; repeat for all rows
		rts

; ---------------------------------------------------------------------------
; DMA version
; ---------------------------------------------------------------------------

SZ_MapScreenDMA:
		tas.b	d0					; enable DMA bit
		move.l	a1,d4					; get source
		lsr.l	#$01,d4					; divide by size of word
		lea	(SS_DMA+$02).l,a0			; put into registers
		movep.l	d4,-$01(a0)				; ''
		move.l	(a0)+,(a6)				; set DMA source
		move.w	(a0)+,(a6)				; ''
		addi.w	#$9301,d1				; prepare width as DMA size

SSEL_LoadMap:
		move.w	d1,(a6)					; set DMA size
		move.l	d0,(a6)					; set DMA destination
		add.l	d3,d0					; advance to next plane line
		dbf	d2,SSEL_LoadMap				; repeat for all columns
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Includes
; ---------------------------------------------------------------------------

Pal_SEGA:	binclude "Screen SEGA\Data\Palette.bin"
		even
Art_SEGA:	binclude "Screen SEGA\Data\Art.kosm"
		even
Map_SEGA:	binclude "Screen SEGA\Data\Mappings.kos"
		even
Art_SEGA_Full:	binclude "Screen SEGA\Data\ArtFull.kosm"
		even
Map_SEGA_Full:	binclude "Screen SEGA\Data\MappingsFull.kos"
		even
Art_SEGA_Eff1:	binclude "Screen SEGA\Data\ArtEff1.kosm"
		even
Map_SEGA_Eff1:	binclude "Screen SEGA\Data\MappingsEff1.kos"
		even
Art_SEGA_Eff2:	binclude "Screen SEGA\Data\ArtEff2.kosm"
		even
Map_SEGA_Eff2:	binclude "Screen SEGA\Data\MappingsEff2.kos"
		even

; ===========================================================================
