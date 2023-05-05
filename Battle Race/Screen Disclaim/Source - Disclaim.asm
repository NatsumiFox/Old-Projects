; ===========================================================================
; ---------------------------------------------------------------------------
; Disclaimer Screen
; ---------------------------------------------------------------------------
ED_ScreenList	=	$FFFF8000				; long
ED_RenderDone	=	$FFFF8004				; byte
ED_FadeSpeed	=	$FFFF8005				; byte
ED_FadeCount	=	$FFFF8006				; byte
ED_AverageX	=	$FFFF8008				; word
ED_OddCount	=	$FFFF800A				;  $1C
; ---------------------------------------------------------------------------

Disclaimer:
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
		move.w	#$8200|((($C000)>>$0A)&$FF),(a6)	; 00FE DCBA - Scroll Plane A Map Table VRam address
		move.w	#$8300|((($F000)>>$0A)&$FF),(a6)	; 00FE DCB0 / 00FE DC00 (20 H-resol) - Window Plane A Map Table VRam address
		move.w	#$8400|((($E000)>>$0D)&$FF),(a6)	; 0000 0FED - Scroll Plane B Map Table VRam address
		move.w	#$8500|((($B800)>>$09)&$FF),(a6)	; 0FED CBA9 / 0FED CBA0 (20 H-resol) - Sprite Plane Map Table VRam address
		move.w	#$8600|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8700|$20,(a6)				; 00PP CCCC - Backdrop Colour: Palette Line | Colour ID
		move.w	#$8800|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8900|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8A00|$DF,(a6)				; 7654 3210 - H-Interrupt Register
		move.w	#$8B00|%00000010,(a6)			; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)
		move.w	#$8C00|%10000001,(a6)			; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
		move.w	#$8D00|((($BC00)>>$0A)&$FF),(a6)	; 00FE DCBA - Horizontal Scroll Table VRam address
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

DIS_ClearRAM:
		move.l	d0,(a1)+				; clear RAM
		dbf	d7,DIS_ClearRAM				; repeat til cleared

		move.l	d0,(V_scroll_value).w			; clear V-scroll

	; --- Loading data ---

		move.w	#$20*$20,d2				; write to VRAM address
		lea	(Art_ASCII).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping

		move.w	#$1000,d2				; write to VRAM address 1000
		lea	(Art_DisBG).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping

	; --- Decompress Kos Module data ---

DIS_DelayLoad:
		move.b	#2,(V_int_routine).w
		jsr	Process_Kos_Queue
		jsr	Wait_VSync
		jsr	Process_Kos_Module_Queue.w
		tst.l	(Kos_module_queue).w
		bne.s	DIS_DelayLoad

		move.b	#2,(V_int_routine).w		; needed to finish decompression
		jsr	Wait_VSync

	; ---- Loading more data ---

		move	#$2700,sr				; disable interrupts
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.l	#NullRTE,(H_int_addr).w			; set H-blank routine
		move.l	#VB_Disclaim,(V_int_addr).w		; set V-blank routine

		move.l	#$00800080,d0				; prepare blank tiles
		move.l	#$60000003,(a6)				; set VDP to BG plane
		move.w	#((($20*$80)/2)/4)-1,d1			; set size of plane

DIS_SetPlane:
		move.l	d0,(a5)					; clear entire plane
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		dbf	d1,DIS_SetPlane				; repeat until all clear

		lea	($FFFF0000).l,a1			; load dump address
		lea	(Map_DisBG).l,a0			; load enigma compressed mappings address
		move.w	#$0080,d0				; clear tile adjustment
		jsr	Eni_Decomp				; decompress and dump to RAM

		move.l	#$01000000,d3				; set line advance amount
		lea	($FFFF0000).l,a1			; load mappings address
		move.l	#$60800003,d0				; set VDP mode/address (C000)
		moveq	#$40-1,d1				; set width
		moveq	#$20-1,d2				; set height
		jsr	SZ_MapScreen				; dump mappings

	; --- Finalising ---

		moveq	#$00,d0					; clear d0
		lea	(H_scroll_buffer).w,a1			; load H-scroll buffer ram
		move.w	#($380/$04)-1,d7			; set number of scanlines above the water

DIS_ClearHScroll:
		move.l	d0,(a1)+				; clear top half (where normal letters are)
		dbf	d7,DIS_ClearHScroll			; repeat til done

		lea	(Pal_Dis).l,a0				; load palette
		lea	(Target_palette).w,a1			; load main palette buffer
		move.w	#($0020/$04)-1,d7			; set number of colours to flush

DIS_LoadPal:
		move.l	(a0)+,(a1)+				; copy colours over
		dbf	d7,DIS_LoadPal				; repeat for number of colours

		move.w	#-$0180,(H_scroll_buffer).w		; set starting BG position

		move.w	#$003F,(Palette_fade_info).w		; set to fade entire palette
	;	jsr	Pal_FadeFromBlack			; fade into colour

		pea	ML_Disclaim(pc)				; set return address (into main loop)
		lea	DIS_PressStart(pc),a0			; load text to render (start button)
		moveq	#$00,d1					; prepare displacement
		move.l	#$5A000003,d2				; set VRAM address

		lea	(ED_OddCount+$1A).w,a2

; ---------------------------------------------------------------------------
; Subroutine to render ASCII text
; --- input -----------------------------------------------------------------
; a0.l = ASCII string
; d1.w = VDP Tile displacement
; d2.l = VDP write mode address
; ---------------------------------------------------------------------------

VBDIS_RenderASCII:
		move.l	#$01000000,d3				; prepare line advancement amount
		move.l	a0,d0					; check string
		bne.s	VRA_Start				; if valid, branch
		moveq	#($1C-4)-1,d4				; set height

VRA_ClearLine:
		move.l	d2,(a6)					; set VDP write address
		add.l	d3,d2					; advance to next line
		moveq	#($28/8)-1,d1				; set width

VRA_ClearArea:
		move.l	d0,(a5)					; clear map tile line
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		dbf	d1,VRA_ClearArea			; repeat for entire line
		dbf	d4,VRA_ClearLine			; repeat for all lines
		rts						; return

VRA_NextLine:
		cmpi.w	#$FFFF,d4				; were there any blank spaces left?
		blt.s	VRA_Start				; if not, branch
		move.w	d4,d0					; get odd/even count
		andi.w	#$0001,d0				; ''
		move.b	d0,-$01(a2)				; set odd/even position flag for scrolling
		move.w	d4,d5					; copy remaining spaces to d5
		asr.w	#$01,d5					; divide by 2
		andi.w	#$0001,d4				; get odd/even position
		add.w	d4,d5					; save to counter
		moveq	#$00,d0					; clear d0

VRA_ClearRight:
		move.w	d0,(a5)					; clear left side
		dbf	d5,VRA_ClearRight			; repeat until all clear

VRA_Start:
		moveq	#$27,d4					; prepare maximum width
		lea	(a0),a1					; store ASCII position

VRA_CountLine:
		subq.w	#$01,d4					; decrease width
		tst.b	(a1)+					; check character
		bgt.s	VRA_CountLine				; loop if we haven't reached end of line (or end of string)
		move.l	d2,(a6)					; set VDP address
		add.l	d3,d2					; advance to next column
		sf.b	(a2)+					; clear odd/even scroll position
		tst.w	d4					; were there any blank spaces left?
		bmi.s	VRA_NoBlank				; if not, branch
		move.w	d4,d5					; copy remaining spaces to d5
		lsr.w	#$01,d5					; divide by 2
		moveq	#$00,d0					; clear d0

VRA_ClearLeft:
		move.w	d0,(a5)					; clear left side
		dbf	d5,VRA_ClearLeft			; repeat until all clear

VRA_NoBlank:
		moveq	#$00,d0					; clear d0
		move.b	(a0)+,d0				; load ASCII character
		beq.s	VRA_Finish				; if it's the end of the string, branch

VRA_NewCharacter:
		bmi.s	VRA_NextLine				; if it's a new line, branch
		add.w	d1,d0					; displace
		move.w	d0,(a5)					; save character
		moveq	#$00,d0					; clear d0
		move.b	(a0)+,d0				; load ASCII character
		bne.s	VRA_NewCharacter			; if this isn't the end of the string, branch

VRA_Finish:
		rts						; return

; ---------------------------------------------------------------------------
; Press start text at bottom of screen
; ---------------------------------------------------------------------------

DIS_PressStart:	dc.b	"PRESS START",$00
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; SEGA Screen loops
; ---------------------------------------------------------------------------

	; --- Running intro effect ---

ML_Disclaim:
		move.b	(Ctrl_1_pressed).w,d0			; load player 1 controls
		or.b	(Ctrl_2_pressed).w,d0			; load player 2 controls
		bpl.s	MLDIS_NoAdv				; if neither player has pressed start, branch
		move.l	(ED_ScreenList).w,a0			; load list address
		addq.w	#$08,a0					; advance to next list
		move.w	$04(a0),d0				; load X destination
		sub.w	(ED_AverageX).w,d0			; get distance from average current X position
		addi.w	#(($0028+$04)*8),d0			; is the screen anywhere near the destination?
		cmpi.w	#(($0028+$04)*8)*2,d0			; ''
		blo.s	MLDIS_NoAdv				; if so, branch (DO NOT LOAD NEXT SCREEN UNTILL IT IS OFF OF THE SCREEN)
		move.l	a0,(ED_ScreenList).w			; update list address
		sf.b	(ED_RenderDone).w			; set to render a new string
		tst.l	(a0)					; is this the last entry?
		bne.s	MLDIS_NoAdv				; if so, branch to alternate
		move.b	#$16,(ED_FadeCount).w			; set fadeing out counter

	; --- When fading out ---

MLDIS_Finish:
		pea	MLDIS_Finish(pc)			; set to loop this section
		subq.b	#$01,(ED_FadeSpeed).w			; decrease fade speed
		bpl.s	MLDIS_NoOut				; if still running, branch
		move.b	#$01,(ED_FadeSpeed).w			; reset counter
		jsr	Pal_ToBlack				; fade out
		subq.b	#$01,(ED_FadeCount).w			; decrease fade out counter
		bpl.s	MLDIS_NoOut				; if still counting, branch
		addq.w	#$04,sp					; skip loop address
		move.b	#$00,(Game_mode).w			; change game mode to SEGA screen

MLDIS_NoOut:
		jsr	DIS_ScreenControl			; control scrolling and rendering
		st.b	(V_int_routine).w			; set 68k as ready
		jmp	Wait_VSync				; wait for V-blank

	; --- When fading in ---

MLDIS_NoAdv:
		jsr	Pal_FromBlack				; fade in
		jsr	DIS_ScreenControl			; control scrolling and rendering
		pea	ML_Disclaim(pc)				; set to loop this section
		st.b	(V_int_routine).w			; set 68k as ready
		jmp	Wait_VSync				; wait for V-blank

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to handle screen rendering
; ---------------------------------------------------------------------------

DIS_ScreenControl:
		move.l	(ED_ScreenList).w,d0			; load screen list address
		bne.s	DSC_SetList				; if there is an address, branch
		move.l	#DIS_List,d0				; load first screen list address
		move.l	d0,(ED_ScreenList).w			; store for later
		sf.b	(ED_RenderDone).w			; set to render a new string

DSC_SetList:
		tst.b	(ED_RenderDone).w			; is rendering done yet?
		beq.s	DSC_NoScroll				; if not, branch
		moveq	#$00,d3					; clear average X scroll
		movea.l	d0,a0					; set address
		lea	(H_scroll_buffer).w,a1			; load H-scroll buffer
		move.l	$06(a0),d0				; load BG X position
		clr.w	d0					; clear fraction
		sub.l	(a1),d0					; get distance
		asr.l	#$03,d0					; slow down
		add.l	d0,(a1)+				; adjust BG
		lea	DSC_ScrollList(pc),a2			; load scroll list
		moveq	#($1C-$04)-1,d2				; set number of tiles to scroll
		move.w	$04(a0),d1				; load FG X position
		addq.w	#$04,a1					; skip top tile
		lea	(ED_OddCount+$01).w,a3			; load odd/even count

DSC_NextScroll:
		move.w	d1,d0					; load destination
		tst.b	(a3)+					; is this an odd sized string?
		beq.s	DSC_NoOdd				; if not, branch
		addq.w	#$04,d0					; shift right by half a tile

DSC_NoOdd:
		sub.w	(a1),d0					; get distance
		ext.l	d0					; extend to long-word
		muls.w	(a2)+,d0				; multiply by scroll speed
		add.l	d0,(a1)+				; move FG to position
		add.w	-$04(a1),d3				; add X scroll to average
		dbf	d2,DSC_NextScroll			; repeat for all scrolling
		ext.l	d3
		divs.w	#($1C-$04),d3				; divide by number of X scrolls
		move.w	d3,(ED_AverageX).w			; save for X skip checking

DSC_NoScroll:
		rts						; return

DSC_ScrollList:	dc.w	$2000			; Random series of scroll speeds....
		dc.w	$1E00
		dc.w	$1800
		dc.w	$1C00
		dc.w	$1A00
		dc.w	$1D00
		dc.w	$1900
		dc.w	$1F00
		dc.w	$1B00
		dc.w	$1C00
		dc.w	$1D00
		dc.w	$1900
		dc.w	$1E00
		dc.w	$2000
		dc.w	$1800
		dc.w	$1F00
		dc.w	$1B00
		dc.w	$1A00
		dc.w	$2000
		dc.w	$1F00
		dc.w	$1900
		dc.w	$1C00
		dc.w	$1800
		dc.w	$1900
		dc.w	$1E00
		dc.w	$1A00
		dc.w	$1B00
		dc.w	$1D00

; ---------------------------------------------------------------------------
; Screen list
; ---------------------------------------------------------------------------

DIS_List:	dc.l	Attention				; String
		dc.w	-$0200					; FG X destination
		dc.w	-$0200					; BG X destination

		dc.l	Guidelines				; String
		dc.w	-$0400					; FG X destination
		dc.w	-$0300					; BG X destination

		dc.l	ThankYou				; String
		dc.w	-$0200					; FG X destination
		dc.w	-$0200					; BG X destination

		dc.l	0					; end of list
		dc.w	-$0000					; FG X destination
		dc.w	-$0000					; BG X destination

Attention:	dc.b	"> > > A T T E N T I O N < < <",$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	"THIS IS AN UNFINISHED DEMO BUILT",$FF
		dc.b	"FOR THE SONIC HACKING CONTEST 2018.",$FF
		dc.b	$FF
		dc.b	"SO IT WILL BE INCOMPLETE AND MISSING",$FF
		dc.b	"THINGS WHICH WILL BE AVAILABLE IN",$FF
		dc.b	"THE FINAL RELEASE.",$FF
		dc.b	$FF
		dc.b	"PLEASE CHECKOUT THE FOLLOWING LINK",$FF
		dc.b	"FOR MORE INFORMATION AND MAYBE EVEN",$FF
		dc.b	"A FULL RELEASE...",$FF
		dc.b	$FF
		dc.b	"OFFICIAL SITE:",$FF
		dc.b	"http://mrjester.hapisan.com/S3KBR",$00

	;	dc.b	$FF
	;	dc.b	"SONIC RETRO THREAD:",$FF
	;	dc.b	"forums.sonicretro.org/?showtopic=13",$FF
	;	dc.b	$FF
	;	dc.b	"SSRG THREAD:",$FF
	;	dc.b	"sonicresearch.org/?threads/5498",$00

Guidelines:	dc.b	"SONIC 3 & KNUCKLES - BATTLE RACE",$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	"THIS IS DESIGNED TO BE A 2 PLAYER ONLY",$FF
		dc.b	"HACK, THEREFORE, THERE IS NO SINGLE",$FF
		dc.b	"PLAYER SUPPORT, WE APOLOGISE TO THOSE",$FF
		dc.b	"EXPECTING SINGLE PLAYER AND CAN ONLY",$FF
		dc.b	"ENCOURAGE YOU TO FIND SOMEONE TO PLAY",$FF
		dc.b	"WITH.",$FF
		dc.b	$FF
		dc.b	"",'"',"Kega Fusion",'"'," SUPPORTS NETPLAY AND WILL",$FF
		dc.b	"PROBABLY BE YOUR GOTO EMULATOR TO PLAY",$FF
		dc.b	"WITH OTHERS.",$FF
		dc.b	$FF
		dc.b	"PLEASE NOTE, THIS HACK WILL NOT RUN",$FF
		dc.b	"CORRECTLY IN THE EMULATOR SERIES KNOWN",$FF
		dc.b	"AS ",'"',"Gens",'"',", YOU MUST USE AN ALTERNATIVE",$FF
		dc.b	"EMULATOR OR HARDWARE.  WE APOLOGISE FOR",$FF
		dc.b	"THE INCONVENIENCE (not our fault).",$00

ThankYou:	dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	"THANK YOU FOR DOWNLOADING THIS HACK.",$FF
		dc.b	$FF
		dc.b	"WE HOPE YOU ENJOY WHAT'S AVAILABLE SO",$FF
		dc.b	"FAR, AND WE PLAN ON RELEASING THE",$FF
		dc.b	"FINAL VERSION SOMETIME EARLY",$FF
		dc.b	"NEXT YEAR (2019)~",$FF
		dc.b	$FF
		dc.b	"HAVE FUN!",$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$FF
		dc.b	$00


		even

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank routine (Standard)
; ---------------------------------------------------------------------------

VB_Disclaim:
		tst.b	(V_int_routine).w			; was the 68k late?
		beq.w	VBDIS_68kLate				; if so, branch
		sf.b	(V_int_routine).w			; set V-blank as ran
		movem.l	d0-a4,-(sp)				; store register data

		move.l	(ED_ScreenList).w,d0			; load screen list address
		beq.s	VBDIS_NoText				; if there is no address, branch
		tst.b	(ED_RenderDone).w			; is rendering set to be done?
		bne.s	VBDIS_NoText				; if not, branch
		movea.l	d0,a0					; set address
		move.w	$04(a0),d2				; load X position
		lsr.w	#$02,d2					; divide by 8 pixels then multiply by size of map word
		andi.w	#$00FE,d2				; keep within plane width
		ori.w	#$4100,d2				; set starting plane X position
		swap	d2					; align for VDP
		move.w	#$0003,d2				; ''
		moveq	#$00,d1					; clear displacement
		move.l	(a0),a0					; load string
		lea	(ED_OddCount+$01).w,a2			; load odd/even count
		jsr	VBDIS_RenderASCII			; render the screen
		st.b	(ED_RenderDone).w			; set rendering as done
		bra.s	VBDIS_NoWrite				; continue with no other writing

VBDIS_NoText:
		DMA_SP	$0080, Normal_palette, $C0000000	; palette
		move.w	#$8F10,(a6)				; set increment mode to size of H-scroll 8 pixel length (and a half empty)
		DMA_SP	($1C*4), H_scroll_buffer+$04, $7C000002	; h-scroll FG
		move.w	#$8F20,(a6)				; set increment mode to size of H-scroll 8 pixel length
		move.l	(H_scroll_buffer).w,d0			; load BG position
		move.w	(H_scroll_buffer).w,d0			; ''
		move.l	#$7C020002,(a6)				; set H-scroll address for BG
		moveq	#($1C/2)-1,d1				; set size of BG writes

VBDIS_ScrollFG:
		move.l	d0,(a5)					; write BG position
		dbf	d1,VBDIS_ScrollFG			; repeat until all 8 pixels slots are done
		move.w	#$8F02,(a6)				; restore increment mode

VBDIS_NoWrite:
		jsr	Poll_Controllers			; read controls
		movem.l	(sp)+,d0-a4				; restore register data

VBDIS_68kLate:
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Includes
; ---------------------------------------------------------------------------

Pal_Dis:	binclude "Screen Disclaim\Data\Palette.bin"
		even
Art_DisBG:	binclude "Screen Disclaim\Data\Art BG.kosm"
		even
Map_DisBG:	binclude "Screen Disclaim\Data\Map BG.eni"
		even
Art_ASCII:	binclude "Screen Disclaim\Data\Art ASCII.kosm"

; ===========================================================================
