; ===========================================================================
; ---------------------------------------------------------------------------
; Museum Screen
; ---------------------------------------------------------------------------
; DO NOT USE 0000 - 7FFF AS IT'S USED FOR SHOT DECOMPRESSION DUMPING SPACE
; DO NOT USE 8000 - A066 AS IT'S USED FOR TWIZZLER MODULED DUMPING SPACE
; ---------------------------------------------------------------------------
EMU_AniQCounter	=	$FFFFA100			; word	; counter/position for animated Q
EMU_AniQTimer	=	$FFFFA102			; word	; delay timer for animated Q
EMU_AniSCounter	=	$FFFFA104			; word	; counter/position for animated selector
EMU_AniSTimer	=	$FFFFA106			; word	; delay timer for animated selector
EMU_AniACounter	=	$FFFFA108			; word	; counter/position for animated arrow
EMU_AniATimer	=	$FFFFA10A			; word	; delay timer for animated arrow
EMU_SelectorX	=	$FFFFA110			; byte	; X selection
EMU_SelectorY	=	$FFFFA111			; byte	; Y selection
EMU_PageNumber	=	$FFFFA112			; word	; destination of page wall position
EMU_FadeCount	=	$FFFFA114			; byte	; fade counter
EMU_FadeTimer	=	$FFFFA115			; byte	; fade timer
EMU_PagePrev	=	$FFFFA116			; byte	; previous page number (for icon loading)
EMU_IconCount	=	$FFFFA117			; byte	; icon load counter
EMU_IconTrans	=	$FFFFA118			; word	; icon DMA transfer address (if 0000, no transfer)
EMU_TextEntry	=	$FFFFA11A			; byte	; icon entry the text is currently displaying for
EMU_TextTime	=	$FFFFA11B			; byte	; delay timer before scrolling text
EMU_TextCur	=	$FFFFA11C			; word	; text current position
EMU_TextEnd	=	$FFFFA11E			; word	; text end position
EMU_PlaneTiles	=	$FFFFA120			; long	; icon render tiles
EMU_PlaneVRAM	=	$FFFFA124			; long	; icon render plane VRAM address
EMU_FadeSpeed	=	$FFFFA128			; byte	; fade in/out speed
EMU_ShadowReg	=	$FFFFA12A			; word	; VDP register from state/shot containing shadow bit
EMU_TextScroll	=	$FFFFA12C			; long	; V-scroll for text mode

EMU_IconSprites	=	$FFFFA1D8			;   28	; icon display flags
; ---------------------------------------------------------------------------
EMU_InfoText	=	$FFFF0000			; 8000	; "info" text address
EMU_InfoData	=	$FFFF8000			; 2000	; "info" data pointers/line count
; ---------------------------------------------------------------------------
TEXT_DELAYTIME	=	$40				; Time before text can scroll
SHADOWFADE	=	$06				; colour grade before enabling/disabling shadow/highlight when fading in/out
; ---------------------------------------------------------------------------

Museum:
		moveq	#-$1F,d0				; fade music out
		jsr	Play_Sound				; ''
		moveq	#0,d0
		jsr	Change_Music_Tempo			; slow music down

		clr.w	(Kos_decomp_queue_count).w		; clear kosinski decompression cue count
		jsr	Clear_KosM_Queue			; clear Kosinski Moduled decompression cue information
		jsr	Pal_FadeToBlack				; fade out to black
		move	#$2700,sr				; disable interrupts
		moveq	#$E0,d0					; stop music
		jsr	Play_Sound				; ''

		lea	(MusicMuseum).l,a0			; load music track list
		jsr	PlayPCM					; play the PCM tracker data

		moveq	#$00,d0					; clear d0
		lea	($FFFFA100).l,a1			; variable RAM
		move.w	#(($0F00/$04)/$04)-1,d1			; set size of RAM

MU_ClearVars:
		move.l	d0,(a1)+				; clear RAM
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		dbf	d1,MU_ClearVars				; repeat til variable RAM is clear

Museum_Return:

	; --- Setup/clearing ---

		move	#$2700,sr				; disable interrupts
		move.l	#NullRTE,(H_int_addr).w			; set H-blank routine
		move.l	#VB_Museum,(V_int_addr).w		; set V-blank routine
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.w	#$8000|%00000100,(a6)			; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)
		move.w	#$8100|%00110100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.w	#$8200|((($C000)>>$0A)&$FF),(a6)	; 00FE DCBA - Scroll Plane A Map Table VRam address
		move.w	#$8300|((($F000)>>$0A)&$FF),(a6)	; 00FE DCB0 / 00FE DC00 (20 H-resol) - Window Plane A Map Table VRam address
		move.w	#$8400|((($E000)>>$0D)&$FF),(a6)	; 0000 0FED - Scroll Plane B Map Table VRam address
		move.w	#$8500|((($DC00)>>$09)&$FF),(a6)	; 0FED CBA9 / 0FED CBA0 (20 H-resol) - Sprite Plane Map Table VRam address
		move.w	#$8600|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8700|$00,(a6)				; 00PP CCCC - Backdrop Colour: Palette Line | Colour ID
		move.w	#$8800|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8900|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8A00|$DF,(a6)				; 7654 3210 - H-Interrupt Register
		move.w	#$8B00|%00000010,(a6)			; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)
		move.w	#$8C00|%10000001,(a6)			; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
		move.w	#$8D00|((($FC00)>>$0A)&$FF),(a6)	; 00FE DCBA - Horizontal Scroll Table VRam address
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

	; I don't think DMA "Fill" works for CRAM (plus it should be black already)
	;	move.l	#$C0000080,d0				; CRAM
	;	move.w	#$0080,d1				; size to clear
	;	jsr	ClearVDP				; clear VDP memory section

	; --- 68k Memory ---

		moveq	#$00,d0					; clear d0

		lea	($FFFF0000).l,a1			; main RAM
		move.w	#(($8000/$04)/$04)-1,d1			; set size of RAM

MU_ClearMain:
		move.l	d0,(a1)+				; clear RAM
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		dbf	d1,MU_ClearMain				; repeat til main RAM is clear

		lea	(Sprite_table_buffer).w,a1		; sprite RAM
		moveq	#(($280/$04)/$02)-1,d1			; set size of RAM

MU_ClearSprites:
		move.l	d0,(a1)+				; clear RAM
		move.l	d0,(a1)+				; ''
		dbf	d1,MU_ClearSprites			; repeat til sprites art clear

		lea	(H_scroll_buffer).w,a1			; H-Scroll RAM
		moveq	#(($400/$04)/$02)-1,d1			; set size of RAM

MU_ClearHScroll:
		move.l	d0,(a1)+				; clear RAM
		move.l	d0,(a1)+				; ''
		dbf	d1,MU_ClearHScroll			; repeat til H-Scroll is clear

		move.l	d0,(V_scroll_value).w			; clear V-scroll

	; --- Loading data ---

		lea	(Pal_Museum).l,a0			; load palette data
		lea	(Target_palette+$00).w,a1		; load palette RAM
		moveq	#(($80/$04)/$02)-1,d1			; set size of palette to laod

MU_LoadPal:
		move.l	(a0)+,(a1)+				; load palette
		move.l	(a0)+,(a1)+				; ''
		dbf	d1,MU_LoadPal				; repeat until entire palette is loaded

		lea	(Art_MuseumText).l,a0			; load museum text
		move.w	#$B220,d0				; set VRAM address
		jsr	TwimDec					; decompress and dump

		lea	(Art_MuseumBG).l,a0			; load compressed art
		move.w	#$7DE0,d0				; set VRAM address
		jsr	TwimDec					; decompress and dump

		lea	(Map_MuseumBG).l,a0			; load enigma compressed mappings address
		lea	($FFFF0000).l,a1			; load dump address
		move.w	#($7DE0/$20),d0				; set tile adjustment
		jsr	Eni_Decomp				; decompress and dump to RAM

		lea	($FFFF0000+((((320*3)/8)*2)*$17)).l,a0	; load shadow area
		move.l	#$20002000,d0				; prepare palette change value
		moveq	#((((320*3)/8)*3)/8)-1,d1		; set number of tiles/rows to change

MU_MapShadow:
		or.l	d0,(a0)+				; change palette line to darker palette
		or.l	d0,(a0)+				; ''
		or.l	d0,(a0)+				; ''
		or.l	d0,(a0)+				; ''
		dbf	d1,MU_MapShadow				; repeat for all tiles

		move.l	#$01000000,d3				; set line advance amount
		lea	($FFFF0000).l,a1			; load mappings address
		move.l	#$60000003,d0				; set VDP mode/address (E000)
		moveq	#$78-1,d1				; set width
		moveq	#$1C-1,d2				; set height
		jsr	SZ_MapScreen				; dump mappings


	; --- Icon stuff ---

		move.l	#$78200001,(a6)				; set VRAM address of question mark
		move.l	#$11111111,d1				; prepare background piels
		moveq	#($04*$06)-1,d2				; set number of tiles to make

MU_LoadQBG:
		move.l	d1,(a5)					; dump tile
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		dbf	d2,MU_LoadQBG				; repeat for all tiles


		moveq	#$00,d0					; clear d0
		lea	(EMU_IconSprites).w,a1			; load icon display list
		move.l	d0,(a1)+				; clear icons
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''

;		move.l	#$42060003,d5				; set VRAM address to dump tiles
;		moveq	#$05-1,d6
;		bsr.s	MU_NEXTBG
;		move.l	#$42860003,d5				; set VRAM address to dump tiles
;		moveq	#$05-1,d6
;		bsr.s	MU_NEXTBG
;		bra.s	MU_FINBG
;
;MU_NEXTBG:
;		move.l	d5,d3
;		addi.l	#$000E0000,d5
;		move.w	#$03C1,d0				; 
;		bsr.w	MU_SetupBoxes
;		addi.l	#$01000000,d3
;		move.w	#$03C1,d0				; 
;		bsr.w	MU_SetupBoxes
;		addi.l	#$01000000,d3
;		move.w	#$03C1,d0				; 
;		bsr.w	MU_SetupBoxes
;		addi.l	#$01000000,d3
;		move.w	#$03C1,d0				; 
;		bsr.w	MU_SetupBoxes
;		addi.l	#$01000000,d3
;		dbf	d6,MU_NEXTBG
;		rts
;
;MU_FINBG:

	; --- Setup variables ---

		moveq	#$00,d0					; clear d0
		move.w	d0,(EMU_AniQCounter).w			; reset all animation counters/timers
		move.w	d0,(EMU_AniSCounter).w			; ''
		move.w	d0,(EMU_AniACounter).w			; ''
		move.w	d0,(EMU_AniQTimer).w			; ''
		move.w	d0,(EMU_AniSTimer).w			; ''
		move.w	d0,(EMU_AniATimer).w			; ''

		st.b	(EMU_PagePrev).w			; set invalid previous page (so icons load again)
		st.b	(EMU_TextEntry).w			; set invalid text edtry to update
		move.w	d0,(EMU_IconTrans).w			; clear transfer address

		moveq	#$00,d1					; clear d1
		move.b	(EMU_SelectorX).w,d1			; load X selection
		divu.w	#$05,d1					; wrap within the 5 entries
		move.b	d1,(EMU_PageNumber).w			; save as page number
		move.w	(EMU_PageNumber).w,d1			; multiply by 0x200
		add.w	d1,d1					; ''
		bsr.w	MUSF_SetHScroll				; save directly to H-scroll properly for first time

	; --- Final stuff ---

		move.b	#$0E,(EMU_FadeCount).w			; reset fade counter
		move.b	#$01,(EMU_FadeSpeed).w			; set fade in/out speed

		move.w	#$8100|%01110100,(a6)	; enable display; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)

; ---------------------------------------------------------------------------
; Main Loop - Museum
; ---------------------------------------------------------------------------

ML_Museum:
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank
		pea	ML_Museum(pc)				; set return address (loop screen)

; ---------------------------------------------------------------------------
; Subroutines - Museum
; ---------------------------------------------------------------------------

SB_Museum:
		bsr.w	MU_Text					; perform text rendering
		bsr.w	MU_FadeIn				; continue fading in
		bsr.w	MU_Controls				; read controls
		bsr.w	MU_Scroll				; perform wall scrolling
		bsr.w	MU_LoadIcons				; load the icon art correctly
						; continue to..	; display selector

; ---------------------------------------------------------------------------
; Subroutine to make the selector sprites
; ---------------------------------------------------------------------------

MU_DisplaySelector:
		lea	(Sprite_table_buffer).w,a1		; load sprite table address
		moveq	#$00,d3					; reset sprite link coutner
		bsr.s	MUDS_Selector				; do the selector first
		bsr.s	MUDS_Icons				; icons next
		moveq	#$00,d0					; clear last sprite link
		move.l	d0,(a1)+				; ''
		rts						; return


	; --- The icons first ---

MUDS_Icons:
		lea	(MULI_SpriteLoc).l,a0			; load sprite positions list
		lea	(EMU_IconSprites).w,a2			; load icon display list

		moveq	#((4*5)*2)-1,d4				; set number of icons to handle
		move.w	#($6000|($0320/$20))-($600/$20),d2	; prepare VRAM address

MUDS_NextSprite:
		addi.w	#($600/$20),d2				; advance VRAM address to next icon
		tst.b	(a2)+					; is the sprite displaying?
		beq.s	MUDS_NoIconAdv				; if not, branch

		move.w	(a0)+,d0				; load Y position
		move.w	(a0)+,d1				; load X position
		add.w	(H_scroll_buffer).w,d1			; subtract FG position
		beq.s	MUDS_NoIcon				; if it's at exactly 0 offset, branch
		cmpi.w	#$0200,d1				; is it out of the screen area?
		bhs.s	MUDS_NoIcon				; if so, branch

		move.w	d0,(a1)+				; save Y position
		move.b	#$07,(a1)+				; save shape
		addq.b	#$01,d3					; increase link ID
		move.b	d3,(a1)+				; save link
		move.w	d2,(a1)+				; save VRAM address
		move.w	d1,(a1)+				; save X position

		addi.w	#$0010,d1				; move right for large sprite piece
		move.w	d0,(a1)+				; save Y position
		move.b	#$0F,(a1)+				; save shape
		addq.b	#$01,d3					; increase link ID
		move.b	d3,(a1)+				; save link
		move.w	d2,d0					; load VRAM address
		addq.w	#$08,d0					; increase to next sprite
		move.w	d0,(a1)+				; save VRAM address
		move.w	d1,(a1)+				; save X position

MUDS_NoIcon:
		dbf	d4,MUDS_NextSprite			; repeat for all icons
		rts						; return

MUDS_NoIconAdv:
		addq.w	#$04,a0					; advance to next sprite position
		dbf	d4,MUDS_NextSprite			; repeat for all icons
		rts						; return

	; --- Now the actual selector ---

MUDS_Selector:
		lea	MU_SelectorSprites(pc),a0		; load selector sprites
		moveq	#$00,d1					; clear d1
		move.b	(EMU_SelectorX).w,d1			; load X position
		divu.w	#$05*2,d1				; wrap within the 5 entries
		swap	d1					; ''
		lsl.w	#$03,d1					; multiply by 8
		move.w	d1,d0					; multiply by 6 + 1 tiles horizontally
		add.w	d1,d1					; ''
		add.w	d1,d0					; ''
		add.w	d1,d1					; ''
		add.w	d0,d1					; ''
		cmpi.w	#$05*$38,d1				; if this is the 5th entry or higher, branch
		blo.s	MUDS_NoNextPage				; if it's not above 5, it's not on the next page, so branch
		addi.w	#$0200-($05*$38),d1			; advance to next plane position

MUDS_NoNextPage:
		addi.w	#$0018+$80,d1				; advance to starting point
	add.w	(H_scroll_buffer).w,d1			; subtract FG position
	;	cmpi.w	#$0200,d1				; is the sprite out of bounds?
	;	bhi.s	MUDS_NoDisplay				; if so, branch

	;subi.w	#PlanePos,d1

		moveq	#$00,d2					; load Y position
		move.b	(EMU_SelectorY).w,d2			; ''
		lsl.w	#$03,d2					; multiply by 8
		move.w	d2,d0					; multiply by 4 + 1 tiles vertically
		add.w	d2,d2					; ''
		add.w	d2,d2					; ''
		add.w	d0,d2					; ''
		addi.w	#$0010+$80,d2				; advance to starting point
		bra.s	MUDS_Render				; jump into loop

MUDS_DrawSprite:
		move.w	d0,(a1)+				; save Y position
		move.w	(a0)+,d0				; load shape/link
		addq.b	#$01,d3					; increase sprite link ID
		move.b	d3,d0					; save with shape/link
		move.w	d0,(a1)+				; save shape/link
		move.w	(a0)+,(a1)+				; save VRAM
		move.w	(a0)+,d0				; load X position
		add.w	d1,d0					; advance to correct position
		move.w	d0,(a1)+				; save X position

MUDS_Render:
		move.w	(a0)+,d0				; load Y position
		add.w	d2,d0					; advance to correct position
		bpl.s	MUDS_DrawSprite				; if this isn't the end of the list, branch

MUDS_NoDisplay:

	; --- The arrows that display on left/right side ---

		move.w	(H_scroll_buffer).w,d4			; load scroll position
		andi.w	#$01FF,d4				; is the screen scrolling?
		bne.s	MUDS_NoArrowRight			; if so, branch
		move.b	(EMU_PageNumber).w,d4			; load page number
		beq.s	MUDS_NoArrowLeft			; if we're on the first page, branch

		move.w	#$0080+$4C,(a1)+			; save Y position
		move.w	#$0700,d0				; prepare shape
		addq.b	#$01,d3					; increase sprite link ID
		move.b	d3,d0					; save with shape/link
		move.w	d0,(a1)+				; save shape/link
		move.w	#($7CE0/$20),(a1)+			; save VRAM
		move.w	#$0080+$05,(a1)+			; save X position

MUDS_NoArrowLeft
		cmpi.b	#((MU_ShotList_End-MU_ShotList)/((5*4)*4))-1,d4 ; are we on the last page?
		beq.s	MUDS_NoArrowRight			; if so, branch

		move.w	#$0080+$4C,(a1)+			; save Y position
		move.w	#$0700,d0				; prepare shape
		addq.b	#$01,d3					; increase sprite link ID
		move.b	d3,d0					; save with shape/link
		move.w	d0,(a1)+				; save shape/link
		move.w	#($7CE0/$20)|$800,(a1)+			; save VRAM
		move.w	#$0080+((320-$10)-$05),(a1)+		; save X position

MUDS_NoArrowRight:
		rts						; return


MU_SelectorSprites:
		dc.w	$FFF0,$0700,($7B20/$20)|$0000,$FFF0
		dc.w	$FFF0,$0900,($7C20/$20)|$0000,$0000
		dc.w	$FFF0,$0900,($7C20/$20)|$0800,$0018
		dc.w	$FFF0,$0700,($7B20/$20)|$0800,$0030
		dc.w	$0010,$0700,($7B20/$20)|$1000,$FFF0
		dc.w	$0020,$0900,($7C20/$20)|$1000,$0000
		dc.w	$0020,$0900,($7C20/$20)|$1800,$0018
		dc.w	$0010,$0700,($7B20/$20)|$1800,$0030
		dc.w	$8000

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check an entry's availability
; ---------------------------------------------------------------------------

MU_CheckEntry:
		jsr	MU_GetEntry				; load entry ID
		move.w	d0,d2					; store entry ID in d2
		jsr	LoadSlot_Museum				; load the museum slot status
		beq.s	MUCE_NoEntry				; if the slot is locked out, branch
		add.w	d2,d2					; multiply by size of long-word
		add.w	d2,d2					; ''
		tst.l	(a0,d2.w)				; is the entry valid?

MUCE_NoEntry:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to read controls
; ---------------------------------------------------------------------------

MU_Controls:
		move.b	(Ctrl_1_pressed).w,d4			; load controls
		or.b	(Ctrl_2_pressed).w,d4			; fuse player 2's controls
		bpl.s	MUC_NoStart				; if start was not pressed, branch
		nop

		lea	(MU_ShotList).l,a0			; load shot/page list
		bsr.s	MU_CheckEntry				; check the entry
		beq.s	MUC_NoStart				; if not open/valid, branch
		addq.w	#$08,sp					; skip return addresses
		jmp	MUC_Transition

MUC_NoStart:
		add.b	d4,d4					; was A pressed?
		bpl.s	MUC_NoA					; if not, branch
		lea	(MU_InfoList).l,a0			; load list
		bsr.s	MU_CheckEntry				; check the entry
		beq.s	MUC_NoA					; if not open/valid, branch
		addq.w	#$08,sp					; skip return addresses
		jmp	MUC_Text				; run transition screen

MUC_NoA:
		add.b	d4,d4					; was A pressed?
		bpl.s	MUC_NoC					; if not, branch
		lea	(MU_ShotList).l,a0			; load shot/page list
		bsr.s	MU_CheckEntry				; check the entry
		beq.s	MUC_NoC					; if not open/valid, branch
		addq.w	#$08,sp					; skip return addresses
		jmp	MUC_Transition				; run transition screen

MUC_NoC:
		add.b	d4,d4					; was A pressed?
		bpl.s	MUC_NoB					; if not, branch
		addq.w	#$08,sp					; skip return addresses
		move.b	#$04,(Game_mode).w			; set game mode to 04 (Main Menu)

		jsr	MU_FadeOut				; fade out to black
		move	#$2700,sr				; disable interrupts
		move.l	#NullRTE,(H_int_addr).w			; set H-blank routine
		move.l	#VB_TitleInit,(V_int_addr).w		; set V-blank routine
		jmp	(SndDrvInit).w				; reload normal sound driver (then return to main menu)

MUC_NoB:
		moveq	#$00,d1					; clear d1
		move.b	(EMU_SelectorX).w,d1			; load X selection
		add.b	d4,d4					; was right pressed?
		bpl.s	MUC_NoRight				; if not, branch
		addq.b	#$01,d1					; increase X selection
		cmpi.b	#($05*((MU_ShotList_End-MU_ShotList)/((5*4)*4)))-1,d1 ; have we passed the end?
		bls.s	MUC_SetPagePos				; if not, branch
		move.b	#($05*((MU_ShotList_End-MU_ShotList)/((5*4)*4)))-1,d1 ; force to stay on last page
		bra.s	MUC_SetPagePos				; set the page position

MUC_NoRight:
		add.b	d4,d4					; was left pressed?
		bpl.s	MUC_NoLeft				; if not, branch
		subq.b	#$01,d1					; decrease X selection
		bcc.s	MUC_SetPagePos				; if we've not passed the first page, branch
		moveq	#$00,d1					; keep at first page

MUC_SetPagePos:
		move.l	d1,d2					; copy to d2 for page setting
		divu.w	#$05,d2					; wrap within the 5 entries
		move.b	d2,(EMU_PageNumber).w			; save as page number

MUC_NoLeft:
		move.b	d1,(EMU_SelectorX).w			; update X selection
		move.b	(EMU_SelectorY).w,d1			; load Y selection
		add.b	d4,d4					; was down pressed?
		bpl.s	MUC_NoDown				; if not, branch
		addq.b	#$01,d1					; increase Y selection
		cmpi.b	#$04-1,d1				; has it gone below bottom selection?
		bls.s	MUC_NoDown				; if not, branch
		moveq	#$04-1,d1				; keep at bottom

MUC_NoDown:
		add.b	d4,d4					; was up pressed?
		bpl.s	MUC_NoUp				; if not, branch
		subq.b	#$01,d1					; decrease Y selection
		bpl.s	MUC_NoUp				; if the selection has not gone above the top, branch
		moveq	#$00,d1					; keep at top

MUC_NoUp:
		move.b	d1,(EMU_SelectorY).w			; update Y selection position
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to scroll the tiles/wall
; ---------------------------------------------------------------------------

MU_Scroll:
		bsr.w	MUSF_MoveText				; move text correctly
		lea	(H_scroll_buffer).w,a0			; load H-scroll buffer to a0
		move.w	(a0),d1					; load FG X position
		neg.w	d1					; convert to positive
		move.w	(EMU_PageNumber).w,d0			; load page destination
		add.w	d0,d0					; multiply to x200
		sub.w	d1,d0					; get distance
		move.w	d0,d2					; keep a copy
		asr.w	#$02,d0					; reduce for speed
		bne.s	MUSF_NoFinish				; if the speed has not reached 0, branch
		move.w	d2,d0					; force position to finish

MUSF_NoFinish:
		add.w	d0,d1					; add to FG position

MUSF_SetHScroll:
		move.w	d1,d0					; make BG scroll twice as slow
		asr.w	#$02,d0					; ''
		andi.w	#$01FF,d0				; keep within wrapping point
		muls.w	#320,d0					; multiply by width of screen
		asr.l	#$08,d0					; ''
		neg.w	d0					; reverse direction for scrolling
		neg.w	d1					; ''

	; FG writing...

	rept	$16
		move.w	d1,(a0)+				; save scroll positions
	endm
		move.w	(EMU_TextCur).w,d2			; load text current position
		neg.w	d2					; reverse direction
	rept	$02
		move.w	d2,(a0)+				; save for top shadow text pane
	endm
		move.w	d1,(a0)+				; do middle shadow line
	rept	$02
		move.w	#$0008,(a0)+				; save for bottom shadow text pane
	endm
		move.w	d1,(a0)+				; do last tile line

	; BG writing...

		lea	(H_scroll_buffer+$100).w,a0		; load H-scroll buffer to a0
		move.w	d0,d1					; copy BG to upper wor dt00
		swap	d1					; ''
		move.w	d0,d1					; ''
	rept	$1C/2
		move.l	d1,(a0)+				; write BG scroll positions
	endm
		rts						; return

MUSF_MoveText:
		move.w	(EMU_TextCur).w,d0			; load text current position
		cmpi.w	#$FFF8,d0				; is it at default position?
		beq.s	MUSF_CheckTimer				; if so, branch
		cmp.w	(EMU_TextEnd).w,d0			; has it reached the end of the
		bge.s	MUSF_CheckTimer				; if so, branch

MUSF_MoveRight:
		addq.w	#$01,d0					; move right
		move.w	d0,(EMU_TextCur).w			; update position
		rts						; return

MUSF_CheckTimer:
		subq.b	#$01,(EMU_TextTime).w			; decrease timer
		bcc.s	MUSF_WaitTimer				; if timer is still running, branch
		move.b	#TEXT_DELAYTIME,(EMU_TextTime).w	; reset timer
		cmp.w	(EMU_TextEnd).w,d0			; has it at the end position?
		blt.s	MUSF_MoveRight				; if not, branch
		move.w	#$FFF8,(EMU_TextCur).w			; reset position to beginning again

MUSF_WaitTimer:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to render text at the bottom pane
; ---------------------------------------------------------------------------

MU_Text:
		bsr.w	MU_GetEntry				; get entry
		cmp.b	(EMU_TextEntry).w,d0			; has the entry changed?
		beq.w	MUSF_WaitTimer				; if not, branch
		move.b	d0,(EMU_TextEntry).w			; update entry
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		move.w	d0,d1					; keep a copy
		move.l	#SLB_ButtonB,d3				; set to display only "B" button
		lea	(MU_LabelList).l,a0			; load list
		move.l	(a0,d0.w),d0				; load string address
		bne.s	MUT_NoBlank				; if the string is not blank, branch
		move.l	#SLB_Blank,d0				; load "blank" text

MUT_NoBlank:
		move.l	d0,a0					; set text address
		moveq	#$00,d0					; clear d0
		move.b	(EMU_TextEntry).w,d0			; load entry ID
		jsr	LoadSlot_Museum				; load the museum slot status
		beq.s	MUT_Locked				; if the entry is locked, branch
		move.l	#$00,d3					; set no buttons to display "yet"
		lea	(MU_ShotList).l,a1			; load screen shot list
		tst.l	(a1,d1.W)				; does the entry have an actual screenshot?
		bne.s	MUT_FindString				; if so, branch
		move.l	#SLB_ButtonB,d3				; set to display only "B" button
		lea	(MU_InfoList).l,a1			; load list
		tst.l	(a1,d1.w)				; does the slot have an info list?
		beq.s	MUT_FindString				; if not, branch
		move.l	#SLB_ButtonAB,d3			; set to display "A" and "B"

MUT_FindString:
		tst.b	(a0)+					; have we reached the end of the string yet?
		bne.s	MUT_FindString				; if not, branch and loop until we do

MUT_Locked:
		move.l	#$40000003+($1000000*$16),d2		; set VRAM address to write to
		bsr.s	MU_RenderString				; render the string
		lsl.w	#$03,d4					; multiply width by x8
		subi.w	#320,d4					; minus width of screen (add a tile's worth due to blank tile on left)
		move.w	d4,(EMU_TextEnd).w			; save end position
		move.b	#TEXT_DELAYTIME,(EMU_TextTime).w	; reset delay timer
		move.w	#$FFF8,(EMU_TextCur).w			; reset text current position

		tst.l	d3					; has a button string been set already?
		bne.s	MUT_NoInfo				; if so, branch
		move.l	#SLB_ButtonBC,d3			; set to display "B" and "C" buttons
		lea	(MU_InfoList).l,a1			; load list
		tst.l	(a1,d1.w)				; does the slot have an info list?
		beq.s	MUT_NoInfo				; if not, branch
		move.l	#SLB_ButtonABC,d3			; set to display "A" as well

MUT_NoInfo:
		move.l	d3,a0					; set string to display
		move.l	#$40000003+($1000000*$19),d2		; set to display on second line

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to render a string at a plane address
; --- input -----------------------------------------------------------------
; a0.l = text address
; d2.l = VRAM address - $40000003+($1000000*$16) - 16 or 19 (top or bottom)
; --- output ----------------------------------------------------------------
; d4.w = Size of string
; ---------------------------------------------------------------------------

MU_RenderString:
		movem.l	d0-d3,-(sp)				; store register data
		bsr.s	MURS_Render				; perform rendering
		movem.l	(sp)+,d0-d3				; restore register data
		rts						; return

MURS_Render:
		move.w	#($B220/$20),d1				; prepare tile add value
		moveq	#$7F,d3					; set size of single line
		lea	(a0),a1					; load string address
		move.l	d2,(a6)					; set VDP address
		addi.l	#$01000000,d2				; advance to next line]
		move.w	#$00FF,d0				; reset d0
		add.b	(a0)+,d0				; load character
		bcc.s	MURS_NoChar				; if still valid, branch

MURS_WriteChar:
		cmpi.b	#89-1,d0				; is this an "A" "B" "C" button art?
		blo.s	MURS_NoABC				; if not, branch
		add.w	d1,d0					; add text address
		move.w	d0,(a5)					; save to VDP
		subq.w	#$01,d3					; decrease character counter
		beq.s	MURS_NoChar				; if ran out of space, branch
		sub.w	d1,d0					; remove VDP
		addq.w	#$02,d0					; advance to right tile of button

MURS_NoABC:
		add.w	d1,d0					; add text address
		move.w	d0,(a5)					; save to VDP
		subq.w	#$01,d3					; decrease character counter
		beq.s	MURS_NoChar				; if ran out of space, branch
		move.w	#$00FF,d0				; reset d0
		add.b	(a0)+,d0				; load character
		bcs.s	MURS_WriteChar				; if still valid, branch

MURS_NoChar:
		moveq	#$7F,d4					; get number of chars written
		sub.w	d3,d4					; ''
		moveq	#$00,d0					; clear d0
		bsr.s	MURS_BlankTiles
		moveq	#$7F,d3					; reload size of blanking
		sub.w	d4,d3					; ''
		move.l	d2,(a6)					; set VDP address
	;	addi.l	#$01000000,d2				; advance to next line]
		dbf	d4,MURS_WriteBottom			; decrease counter and branch to render (if needed)
		move.w	#$0080,d4				; keep a copy of the number of tiles that were rendered
		sub.w	d3,d4					; ''
		dbf	d3,MURS_BlankChar			; repeat for all remaining chars to blank out
		rts						; return

MURS_WriteBottom:
		move.b	(a1)+,d0				; load character (no subtraction, bottom tile)
		cmpi.b	#89,d0					; is this an "A" "B" "C" button art?
		blo.s	MURS_WBNoABC				; if not, branch
		add.w	d1,d0					; add text address
		move.w	d0,(a5)					; save to VDP
		moveq	#$00,d0					; clear d0
		subq.w	#$01,d4					; decrease counter
		bmi.s	MURS_FinishABC				; if finished, branch
		move.b	-$01(a1),d0				; reload previous character
		addq.w	#$02,d0					; advance to right tile of button

MURS_WBNoABC:
		add.w	d1,d0					; add text address
		move.w	d0,(a5)					; save to VDP
		moveq	#$00,d0					; clear d0
		dbf	d4,MURS_WriteBottom			; repeat until all bottom tiles are done

MURS_FinishABC:
		move.w	#$0080,d4				; keep a copy of the number of tiles that were rendered
		sub.w	d3,d4					; ''
		dbf	d3,MURS_BlankChar			; repeat for all remaining chars to blank out
		rts						; return
		
MURS_BlankChar:
		move.w	d0,(a5)					; write blank tile

MURS_BlankTiles:
		dbf	d3,MURS_BlankChar			; repeat for all remaining chars to blank out
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to fade the palette lines in correctly
; ---------------------------------------------------------------------------

MU_FadeIn:
		move.b	(EMU_FadeCount).w,d3			; load fade counter
		beq.s	MUFI_NoFade				; if finished, branch
		subq.b	#$01,(EMU_FadeTimer).w			; decrease delay timer
		bpl.s	MUFI_NoFade				; if not finished, branch
		move.b	(EMU_FadeSpeed).w,(EMU_FadeTimer).w	; reset delay timer
	;	move.b	#$01,(EMU_FadeTimer).w			; reset delay timer
		subq.b	#$02,(EMU_FadeCount).w			; decrease fade counter
		lea	(Normal_palette).w,a0			; load current palette
		lea	(Target_palette).w,a1			; load destination palette
		moveq	#$40-1,d2				; set number of colours to fade

MUFI_NextColour:
		cmp.b	(a1)+,d3				; is the blue allowed to fade in?
		bhi.s	MUFI_NoBlue				; if not, branch
		addq.b	#$02,(a0)				; increase blue

MUFI_NoBlue:
		move.b	(a1)+,d0				; load green and red
		move.b	d0,d1					; store red
		lsr.b	#$04,d0					; get only green
		cmp.b	d0,d3					; is the green allowed to fade in?
		bhi.s	MUFI_NoGreen				; if not, branch
		addi.b	#$20,$01(a0)				; increase green

MUFI_NoGreen:
		andi.b	#$0E,d1					; get only red
		cmp.b	d1,d3					; is the red allowed to fade in?
		bhi.s	MUFI_NoRed				; if not, branch
		addq.b	#$02,$01(a0)				; increase red

MUFI_NoRed:
		addq.w	#$02,a0					; advance to next collour
		dbf	d2,MUFI_NextColour			; repeat for all colours in the palette

MUFI_NoFade:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to fade the palette lines out correctly
; ---------------------------------------------------------------------------

MU_FadeOut:
		bsr.s	MUFO_Perform				; perform fade out
		tst.b	d3					; has a colour changed still?
		bne.s	MU_FadeOut				; if so, branch to loop
		rts						; return

MUFO_Perform:
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank
		subq.b	#$01,(EMU_FadeTimer).w			; decrease delay timer
		bpl.s	MU_FadeOut				; if not finished, branch
		move.b	(EMU_FadeSpeed).w,(EMU_FadeTimer).w	; reset delay timer
		moveq	#$00,d3					; clear change counter
		lea	(Normal_palette).w,a0			; load current palette
		moveq	#$40-1,d2				; set number of colours to fade

MUFO_NextColour:
		addq.b	#$02,d3					; increase change counter
		subq.b	#$02,(a0)+				; decrease blue
		bcc.s	MUFO_NoBlue				; if still above black, branch
		sf.b	-$01(a0)				; keep it black
		subq.b	#$01,d3					; reverse change counter	

MUFO_NoBlue:
		move.b	(a0),d0					; load green/red
		subi.b	#$20,d0					; decreae green
		bcc.s	MUFO_NoGreen				; if still above black, branch
		andi.b	#$0E,d0					; keep it black
		subq.b	#$01,d3					; reverse change counter	

MUFO_NoGreen:
		move.b	d0,d1					; copy red to d1
		andi.b	#$0E,d1					; clear the green
		subq.b	#$02,d1					; decrease red
		bcs.s	MUFO_NoRed				; if it's reached black, branch
		subq.b	#$02,d0					; reduce towards black
		addq.b	#$01,d3					; increase change counter

MUFO_NoRed:
		move.b	d0,(a0)+				; update red/green
		dbf	d2,MUFO_NextColour			; repeat for all colours in the palette
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite relative positions
; ---------------------------------------------------------------------------

MULI_SpriteLoc:	dc.w	$0090,$0098, $0090,$00D0, $0090,$0108, $0090,$0140, $0090,$0178
		dc.w	$00B8,$0098, $00B8,$00D0, $00B8,$0108, $00B8,$0140, $00B8,$0178
		dc.w	$00E0,$0098, $00E0,$00D0, $00E0,$0108, $00E0,$0140, $00E0,$0178
		dc.w	$0108,$0098, $0108,$00D0, $0108,$0108, $0108,$0140, $0108,$0178
		dc.w	$0290,$0098, $0290,$00D0, $0290,$0108, $0290,$0140, $0290,$0178
		dc.w	$02B8,$0098, $02B8,$00D0, $02B8,$0108, $02B8,$0140, $02B8,$0178
		dc.w	$02E0,$0098, $02E0,$00D0, $02E0,$0108, $02E0,$0140, $02E0,$0178
		dc.w	$0308,$0098, $0308,$00D0, $0308,$0108, $0308,$0140, $0308,$0178

; ---------------------------------------------------------------------------
; Plane relative positions
; ---------------------------------------------------------------------------

MULI_PlaneLocs:	dc.l	$42060003, $42140003, $42220003, $42300003, $423E0003
		dc.l	$47060003, $47140003, $47220003, $47300003, $473E0003
		dc.l	$4C060003, $4C140003, $4C220003, $4C300003, $4C3E0003
		dc.l	$51060003, $51140003, $51220003, $51300003, $513E0003

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load icons on the page
; ---------------------------------------------------------------------------

MU_LoadIcons:
		moveq	#$00,d0					; clear d0
		move.b	(EMU_PageNumber).w,d0			; load the page number
		cmp.b	(EMU_PagePrev).w,d0			; has the page changed?
		beq.s	MULI_NoChangePage			; if not, branch
		move.b	d0,(EMU_PagePrev).w			; update page number

		lea	(EMU_IconSprites).w,a1			; load icon display list
		andi.b	#$01,d0					; get only odd/even page
		beq.s	MU_IconEven				; if it's an even page, branch
		lea	4*5(a1),a1				; advace to second page

MU_IconEven:
		moveq	#$00,d0					; clear d0
		move.l	d0,(a1)+				; clear sprites
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''

		move.w	(EMU_PageNumber).w,d0			; multiply page number by x80
		lsr.w	#$01,d0					; ''
		andi.w	#$0080,d0				; get only the page number as a plane position
		swap	d0					; align for VDP
		move.l	#$00080008,d2				; prepare tile horizontal advance
		move.l	#$000F000F,d3				; prepare line reset/advance
		move.l	#$01000000,d4				; prepare VDP address line advance
		lea	MULI_PlaneLocs(pc),a0			; load list of plane offsets for the icons
		moveq	#(5*4)-1,d5				; set number of icons to render

MULI_MapIcons:
		move.l	#$03C103C5,d1				; load question mark icon tiles
		move.l	(a0)+,d6				; load VDP address
		add.l	d0,d6					; add plane position address
		bsr.w	MULI_MapIcon				; render map icon (the question mark kind)
		dbf	d5,MULI_MapIcons			; repeat for all icons available
		sf.b	(EMU_IconCount).w			; reset icon counter
		rts						; return

MULI_NoChangePage:
		moveq	#$00,d1					; clear d1
		move.b	(EMU_IconCount).w,d1			; load icon render count
		cmpi.b	#5*4,d1					; has it finished?
		beq.w	MULI_NoUpdateIcon			; if so, branch
		mulu.w	#5*4,d0					; multiply page number of icons per page
		add.w	d1,d0					; add icon entry
		move.w	d0,d2					; store entry in d2
		jsr	LoadSlot_Museum				; load the museum slot status
		beq.s	MULI_NextIcon				; if the slot is locked out, branch
		add.w	d2,d2					; multiply by size of long-word
		add.w	d2,d2					; ''
		lea	(MU_IconList).l,a0			; load icon list
		move.l	(a0,d2.w),d0				; load entry
		beq.w	MULI_NextIcon				; if it doesn't have an icon, branch
		move.l	d0,a0					; set icon address into a0
		lea	($FFFF0000).l,a1			; load decompression address
		jsr	TwizDec					; decompress and dump

		lea	(EMU_IconSprites).w,a1			; load icon display list
		btst.b	#$00,(EMU_PageNumber).w			; are we on an even page?
		beq.s	MULI_SpriteEven				; if so, branch
		lea	5*4(a1),a1				; advance to odd page

MULI_SpriteEven:
		st.b	(a1,d1.w)				; set to display the sprite

		mulu.w	#$0600,d1				; multiply icon counter by 300 bytes (size of tile)
		addi.w	#$0020,d1				; add 20 (starting VRAM addres)
		move.w	d1,(EMU_IconTrans).w			; set DMA transfer address

		lsr.w	#$05,d1					; divide by 20 to get tile ID
		ori.w	#$4000,d1				; advance to plane palette line
		move.w	d1,d0					; copy to upper word too
		swap	d1					; ''
		move.w	d0,d1					; ''
		addq.w	#$04,d1					; make next tile be +4
		moveq	#$00,d0					; clear d0
		move.b	(EMU_IconCount).w,d0			; reload icon count
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		lea	(MULI_PlaneLocs).l,a0			; load list of plane offsets for the icons
		move.l	(a0,d0.w),d6				; load correct plane VRAM address
		move.w	(EMU_PageNumber).w,d0			; multiply page number by x80
		lsr.w	#$01,d0					; ''
		andi.w	#$0080,d0				; get only the page number as a plane position
		swap	d0					; align for VDP
		add.l	d0,d6					; add plane position address
		move.l	d1,(EMU_PlaneTiles).w			; store the starting icon tiles for transfer later
		move.l	d6,(EMU_PlaneVRAM).w			; store plane VRAM address for transfer later
		rts

MULI_NextIcon:
		addq.b	#$01,(EMU_IconCount).w			; increase icon entry counter
		rts						; return

; ---------------------------------------------------------------------------
; Mapping a single icon
; ---------------------------------------------------------------------------

MULI_MapEntry:
		move.l	(EMU_PlaneTiles).w,d1			; load plane tiles to map out
		move.l	(EMU_PlaneVRAM).w,d6			; load plane address where they're being mapped
		move.l	#$00080008,d2				; prepare tile horizontal advance
		move.l	#$000F000F,d3				; prepare line reset/advance
		move.l	#$01000000,d4				; prepare VDP address line advance

MULI_MapIcon:
		move.l	d6,(a6)					; set VDP line address
		move.l	d1,(a5)					; save tiles
		add.l	d2,d1					; increase tiles
		move.l	d1,(a5)					; save tiles
		add.l	d2,d1					; increase tiles
		move.l	d1,(a5)					; save tiles
		sub.l	d3,d1					; reset tiles to next line
		add.l	d4,d6					; advance to next line

		move.l	d6,(a6)					; set VDP line address
		move.l	d1,(a5)					; save tiles
		add.l	d2,d1					; increase tiles
		move.l	d1,(a5)					; save tiles
		add.l	d2,d1					; increase tiles
		move.l	d1,(a5)					; save tiles
		sub.l	d3,d1					; reset tiles to next line
		add.l	d4,d6					; advance to next line

		move.l	d6,(a6)					; set VDP line address
		move.l	d1,(a5)					; save tiles
		add.l	d2,d1					; increase tiles
		move.l	d1,(a5)					; save tiles
		add.l	d2,d1					; increase tiles
		move.l	d1,(a5)					; save tiles
		sub.l	d3,d1					; reset tiles to next line
		add.l	d4,d6					; advance to next line

		move.l	d6,(a6)					; set VDP line address
		move.l	d1,(a5)					; save tiles
		add.l	d2,d1					; increase tiles
		move.l	d1,(a5)					; save tiles
		add.l	d2,d1					; increase tiles
		move.l	d1,(a5)					; save tiles

MULI_NoUpdateIcon:
		rts						; return


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to calculate the exact entry number being highlighted
; ---------------------------------------------------------------------------

MU_GetEntry:
		moveq	#$00,d0					; clear d0
		move.b	(EMU_SelectorX).w,d0			; load X selection
		divu.w	#$05,d0					; get in multiples of 5 (per page)
		move.l	d0,d1					; keep remainder
		mulu.w	#$05*4,d0				; multiply by number of entries per page
		swap	d1					; add remainder (actual entry on current page)
		add.w	d1,d0					; ''
		move.b	(EMU_SelectorY).w,d1			; load Y position
		add.w	d1,d0					; add to page position (need to x5 anyways)
		add.w	d1,d1					; get the x4 of the x4
		add.w	d1,d1					; ''
		add.w	d1,d0					; add to get Y position
		rts						; return (d0 = entry number)

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank routine
; ---------------------------------------------------------------------------

VB_Museum:
		tst.b	(V_int_routine).w			; was the 68k late?
		beq.w	VBMU_68kLate				; if so, branch
		sf.b	(V_int_routine).w			; set V-blank as ran
		movem.l	d0-a4,-(sp)				; store register data
		jsr	Poll_Controllers			; read controls
		move.l	#$40000010,(a6)				; vscroll
		move.l	(V_scroll_value).w,(a5)			; ''
	Z80DMAOn
		move.w	#$8F20,(a6)				; set to increment a single tile's worth of H-scroll
		DMA	($0380/$10), $7C000003, H_scroll_buffer		; hscroll FG
		DMA	($0380/$10), $7C020003, (H_scroll_buffer+$100)	; hscroll BG
		move.w	#$8F02,(a6)				; reset increment mode to normal
		DMA	$0280, $5C000003, Sprite_table_buffer	; sprites

		move.l	#$00200000,d0				; prepare DMA bit
		move.w	(EMU_IconTrans).w,d0			; load icon transfer address
		beq.s	VBMU_NoIconLoad				; if there are no icons to load, branch
		lsl.l	#$02,d0					; convert to long-word DMA address
		lsr.w	#$02,d0					; ''
		ori.w	#$4000,d0				; ''
		swap	d0					; ''
		move.l	#$94039300,(a6)				; set DMA size (600 bytes)
		move.l	#$96809500,(a6)				; set DMA source (FF0000)
		move.w	#$977F,(a6)				; ''
		move.l	d0,(a6)					; set DMA destination (icon transfer)
		clr.w	(EMU_IconTrans).w			; clear transfer counter
		addq.b	#$01,(EMU_IconCount).w			; increase icon counter
		jsr	MULI_MapEntry				; map the icon entry now
		bra.s	VBMU_NoAni				; skip animations (not enough time)

VBMU_NoIconLoad:
		bsr.s	VBMU_AnimateQ				; animate the question mark
		bsr.w	VBMU_AnimateSelect			; animate the selection
		bsr.w	VBMU_AnimateArrow			; animate the glowing arrows

VBMU_NoAni:
		DMA	$0080, $C0000000, Normal_palette	; palette
	Z80DMAOff
		movem.l	(sp)+,d0-a4				; restore register data

VBMU_68kLate:
		rte						; return

; ---------------------------------------------------------------------------
; Subroutine to animate the question mark
; ---------------------------------------------------------------------------

VBMU_AnimateQ:
		lea	(EMU_AniQTimer).w,a0			; load delay timer
		subq.b	#$01,(a0)				; decrease delay timer
		bpl.s	VBMUQ_NoRender				; if not finished, branch
		moveq	#$00,d0					; clear d0
		move.w	(EMU_AniQCounter).w,d0			; load counter
		moveq	#$02,d2					; set delay speed for rotating the question mark
		subi.w	#$08*$20,d0				; decrease counter
		bne.s	VBMUQ_NoPause				; if the last frame has not been reached, branch
		moveq	#$30,d2					; set delay time before the next rotation

VBMUQ_NoPause:
		bpl.s	VBMUQ_NoReset				; if not finished, branch
		move.w	#(Art_AniQ_End-Art_AniQ)-($08*$20),d0	; reset counter

VBMUQ_NoReset:
		move.w	d0,(EMU_AniQCounter).w			; update counter
		addi.l	#Art_AniQ,d0				; add starting art address
		lsr.l	#$01,d0					; divide by 2
		move.l	#$94009380,(a6)				; set DMA size
		move.l	#$95009600,d1				; prepare DMA source registers
		move.w	d0,(a0)					; load mid byte
		move.b	(a0),d1					; ''
		move.b	d2,(a0)					; reset delay timer
		swap	d1					; get lower register
		move.b	d0,d1					; load lower byte
		move.l	d1,(a6)					; set DMA source lower word
		ori.l	#$97000000,d0				; set upper register
		move.w	#$7920,d0				; set DMA destination part 1
		move.l	d0,(a6)					; set DMA source and destination
		move.w	#$0081,(a6)				; write final destination

VBMUQ_NoRender:
		rts						; return

; ---------------------------------------------------------------------------
; Subroutine to animate the selector
; ---------------------------------------------------------------------------

VBMU_AnimateSelect:
		lea	(EMU_AniSTimer).w,a0			; load delay timer
		subq.b	#$01,(a0)				; decrease delay timer
		bpl.s	VBMUS_NoRender				; if not finished, branch
		moveq	#$00,d0					; clear d0
		move.w	(EMU_AniSCounter).w,d0			; load counter
		moveq	#$01,d2					; set delay speed for rotating the question mark
		addi.w	#$0E*$20,d0				; decrease counter
		cmpi.w	#(Art_AniSel_End-Art_AniSelect)-(($0E*$20)*$01),d0 ; is this the pausing frame?
		bne.s	VBMUS_NoPause				; if not, branch
		moveq	#$40,d2					; set delay time before the next rotation

VBMUS_NoPause:
		cmpi.w	#(Art_AniSel_End-Art_AniSelect),d0	; is this the end of the list?
		blo.s	VBMUS_NoReset				; if not, branch
		moveq	#$00,d0					; reset animation

VBMUS_NoReset:
		move.w	d0,(EMU_AniSCounter).w			; update counter
		addi.l	#Art_AniSelect,d0			; add starting art address
		lsr.l	#$01,d0					; divide by 2
		move.l	#$940093E0,(a6)				; set DMA size
		move.l	#$95009600,d1				; prepare DMA source registers
		move.w	d0,(a0)					; load mid byte
		move.b	(a0),d1					; ''
		move.b	d2,(a0)					; reset delay timer
		swap	d1					; get lower register
		move.b	d0,d1					; load lower byte
		move.l	d1,(a6)					; set DMA source lower word
		ori.l	#$97000000,d0				; set upper register
		move.w	#$7B20,d0				; set DMA destination part 1
		move.l	d0,(a6)					; set DMA source and destination
		move.w	#$0081,(a6)				; write final destination

VBMUS_NoRender:
		rts						; return

; ---------------------------------------------------------------------------
; Subroutine to animate the arrows
; ---------------------------------------------------------------------------

VBMU_AnimateArrow:
		lea	(EMU_AniATimer).w,a0			; load delay timer
		subq.b	#$01,(a0)				; decrease delay timer
		bpl.s	VBMUA_NoRender				; if not finished, branch
		moveq	#$00,d0					; clear d0
		move.w	(EMU_AniACounter).w,d0			; load counter
		addi.w	#$08*$20,d0				; decrease counter
		cmpi.w	#(Art_AniArr_End-Art_AniArr),d0		; is this the end of the list?
		blo.s	VBMUA_NoReset				; if not, branch
		moveq	#$00,d0					; reset animation

VBMUA_NoReset:
		move.w	d0,(EMU_AniACounter).w			; update counter
		addi.l	#Art_AniArr,d0				; add starting art address
		lsr.l	#$01,d0					; divide by 2
		move.l	#$94009380,(a6)				; set DMA size
		move.l	#$95009600,d1				; prepare DMA source registers
		move.w	d0,(a0)					; load mid byte
		move.b	(a0),d1					; ''
		move.b	#$06,(a0)				; reset delay timer
		swap	d1					; get lower register
		move.b	d0,d1					; load lower byte
		move.l	d1,(a6)					; set DMA source lower word
		ori.l	#$97000000,d0				; set upper register
		move.w	#$7CE0,d0				; set DMA destination part 1
		move.l	d0,(a6)					; set DMA source and destination
		move.w	#$0081,(a6)				; write final destination

VBMUA_NoRender:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Includes
; ---------------------------------------------------------------------------

Pal_Museum:	binclude "Screen Museum\Data\Palette.bin"
		binclude "Screen Museum\Shots - States\_Icon Palette.bin"
		even
Art_MuseumBG:	binclude "Screen Museum\Data\Art BG.twim"
		even
Map_MuseumBG:	binclude "Screen Museum\Data\Map BG.eni"
		even
Art_MuseumText:	binclude "Screen Museum\Data\Art Text.twim"
		even
Art_AniSelect:	binclude "Screen Museum\Data\Art Ani Selector.bin"
Art_AniSel_End:	even
Art_AniQ:	binclude "Screen Museum\Data\Art Ani Question.bin"
Art_AniQ_End:	even
Art_AniArr:	binclude "Screen Museum\Data\Art Ani Arrow.bin"
Art_AniArr_End:	even

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to transition from the museum to the text screen
; ---------------------------------------------------------------------------

MUC_Text:
		jsr	MU_FadeOut				; fade out to black

		move	#$2700,sr				; disable interrupts
		move.l	#NullRTE,(H_int_addr).w			; set H-blank routine
		move.l	#VB_MuseumText,(V_int_addr).w		; set V-blank routine
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.w	#$8000|%00000100,(a6)			; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)
		move.w	#$8100|%00010100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.w	#$8200|((($C000)>>$0A)&$FF),(a6)	; 00FE DCBA - Scroll Plane A Map Table VRam address
		move.w	#$8300|((($F000)>>$0A)&$FF),(a6)	; 00FE DCB0 / 00FE DC00 (20 H-resol) - Window Plane A Map Table VRam address
		move.w	#$8400|((($E000)>>$0D)&$FF),(a6)	; 0000 0FED - Scroll Plane B Map Table VRam address
		move.w	#$8500|((($B800)>>$09)&$FF),(a6)	; 0FED CBA9 / 0FED CBA0 (20 H-resol) - Sprite Plane Map Table VRam address
		move.w	#$8600|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8700|$00,(a6)				; 00PP CCCC - Backdrop Colour: Palette Line | Colour ID
		move.w	#$8800|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8900|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8A00|$DF,(a6)				; 7654 3210 - H-Interrupt Register
		move.w	#$8B00|%00000000,(a6)			; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)
		move.w	#$8C00|%10000001,(a6)			; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
		move.w	#$8D00|((($BC00)>>$0A)&$FF),(a6)	; 00FE DCBA - Horizontal Scroll Table VRam address
		move.w	#$8E00|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8F00|$02,(a6)				; 7654 3210 - Auto Increament
		move.w	#$9000|%00010001,(a6)			; 00VV 00HH - Plane Y Size (00-20|01-40|11-80) | Plane X size (00-20|01-40|11-80)
		move.w	#$9100|$00,(a6)				; 7654 3210 - Window Horizontal Position
		move.w	#$9200|$00,(a6)				; 7654 3210 - Window Vertical Position

		move.l	#$40000080,d0				; VRAM
		move.w	#$FFFF,d1				; size to clear
		jsr	ClearVDP				; clear VDP memory section

	; --- Loading BG ---

		lea	(Art_BGText).l,a0			; load compressed BG art
		move.w	#$4000,d0				; set VRAM dump address
		jsr	TwimDec					; decompress art and dump

		lea	(Map_BGText).l,a0			; load enigma compressed mappings address
		lea	($FFFF0000).l,a1			; load dump address
		move.w	#$2000|($4000/$20),d0			; set tile adjustment
		jsr	Eni_Decomp				; decompress and dump to RAM
		move.l	#$00800000,d3				; set line advance amount
		lea	($FFFF0000).l,a1			; load mappings address
		move.l	#$60000003,d0				; set VDP mode/address (E000)
		moveq	#$28-1,d1				; set width
		moveq	#$40-1,d2				; set height
		jsr	SZ_MapScreen				; dump mappings

	; --- Loading FG Text ---

		lea	(Art_MusText).l,a0			; load text art address
		move.w	#$0000,d0				; set VRAM dump address
		jsr	TwimDec					; decompress and dump

		lea	(MU_InfoList).l,a0			; load shot/page list
		jsr	MU_GetEntry				; load entry ID
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		move.l	(a0,d0.w),a0				; load correct entry
		lea	(EMU_InfoText).l,a1			; load RAM address to dump to
		jsr	KosDec					; decompress and dump text
		sf.b	(a1)					; clear final character (end marker)
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port

		lea	(EMU_InfoText).l,a0
		lea	(EMU_InfoData).w,a2
		bsr.w	MU_UnpackText

		move.l	#$FFF80000,(EMU_TextScroll).w		; set starting scroll position
		moveq	#$1C,d2					; set starting line

MUCT_RenderFull:
		bsr.w	MU_RenderLine				; render the line
		dbf	d2,MUCT_RenderFull			; repeat until entire screen is rendered

	; --- Brightening BG palette slightly ---

		lea	(Target_palette+$04).l,a0		; load FG palette
		lea	(Target_palette+$2A).l,a1		; load BG palette to copy to
		moveq	#$05-1,d1				; set number of colorus to copy

MUCT_CopyPal:
		move.w	(a0)+,(a1)+				; copy colours over
		dbf	d1,MUCT_CopyPal				; repeat until done

		move.w	#$8100|%01110100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.b	#$0E,(EMU_FadeCount).w			; reset fade counter
		sf.b	(EMU_FadeSpeed).w			; set fast fading speed

; ---------------------------------------------------------------------------
; Museum text screen main loop
; ---------------------------------------------------------------------------

ML_MuseumText:
		bsr.w	MU_FadeIn				; continue fading in
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank
		move.b	(Ctrl_1_held).w,d0			; load controls
		or.b	(Ctrl_2_held).w,d0			; fuse player 2's controls
		move.b	d0,d2					; copy to d2
		move.w	(EMU_TextScroll).w,d1			; load scroll position
		roxr.b	#$02,d2					; shift up/down into MSB and carry
		bcc.s	MLMT_NoDown				; if down was not pressed, branch
		addq.w	#$02,d1					; scroll down
		move.w	(EMU_InfoData).w,d3			; load scroll position
		subi.w	#$1C-1,d3				; get bottom position
		bmi.s	MLMT_NoScroll				; if the bottom is smaller than the screen, branch
		lsl.w	#$03,d3					; multiply by 8
		cmp.w	d3,d1					; have we reached the bottom?
		bmi.s	MLMT_NoDownMax				; if not, branch
		move.w	d3,d1					; set to the bottom exactly

MLMT_NoDownMax:
		tst.b	d2					; check for up

MLMT_NoDown:
		bpl.s	MLMT_NoUp				; if up was not pressed, branch
		subq.w	#$02,d1					; scroll up
		cmpi.w	#$FFF8,d1				; has it scrolled up to maximum?
		bgt.s	MLMT_NoUp				; if not, branch
		moveq	#$F8,d1					; set to top exactly

MLMT_NoUp:
		move.w	d1,(EMU_TextScroll).w			; update scroll position
		asr.w	#$02,d1					; divide by 4 for BG scroll speed
		move.w	d1,(EMU_TextScroll+2).w			; update BG scroll position

MLMT_NoScroll:
		andi.b	#$F0,d0					; get START, A, B, and C buttons
		beq.s	ML_MuseumText				; if none of them are pressed, branch
		jsr	MU_FadeOut				; fade out to black
		jmp	Museum_Return				; go back to Museum

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to render a line of text
; ---------------------------------------------------------------------------

MU_RenderLine:
		move.w	d2,d3					; copy render line ID to d3
		andi.w	#$003F,d3				; wrap
		lsl.w	#$07,d3					; multiply by 80
		ori.w	#$4002,d3				; setup for VDP write address
		swap	d3					; ''
		move.w	#$0003,d3				; ''
		move.l	d3,(a6)					; set address
		moveq	#$28-2-1,d3				; set width
		lea	(EMU_InfoData).w,a0			; load render list
		cmp.w	(a0)+,d2				; is the render line out of range?
		bcc.s	MURL_BlankLine				; if so, branch
		move.w	d2,d0					; load render line
		add.w	d0,d0					; multiply by size of long-word address
		add.w	d0,d0					; ''
		movem.l	(a0,d0.w),a0				; load address
		moveq	#$00,d0					; clear d0
		moveq	#$08-1,d4				; set tab size

MURL_NextChar:
		move.b	(a0)+,d0				; load character
		cmpi.b	#$7F,d0					; is it a new-line marker or end of page?
		bhs.s	MURL_CheckTab				; if so, branch
		move.w	d0,(a5)					; save to VDP
		dbf	d4,MURL_DecTab				; decrement tab counter
		moveq	#$08-1,d4				; reset tab size

MURL_DecTab:
		dbf	d3,MURL_NextChar			; repeat for all characters in the line
		rts						; return

MURL_CheckTab:
		cmpi.b	#('	'-$20)&$FF,d0			; is it a tab character?
		bne.s	MURL_BlankLine				; if not, branch
		moveq	#$00,d0					; clear d0

MURL_NextTab:
		move.w	d0,(a5)					; write a space tile
		dbf	d4,MURL_ContTab				; repeat for all spaces required to make a tab
		moveq	#$08-1,d4				; reset tab size
		dbf	d3,MURL_NextChar			; repeat for all characters in the line
		rts						; retyrn

MURL_ContTab:
		dbf	d3,MURL_NextTab				; repeat until all characters in the line are filled
		rts						; return

MURL_BlankLine:
		moveq	#$00,d0					; set to display space character

MURL_WriteBlank:
		move.w	d0,(a5)					; write blank tile
		dbf	d3,MURL_WriteBlank			; repeat for all blank characters left
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to unpack text correctly
; ---------------------------------------------------------------------------

MU_UnpackText:
		lea	(a2),a3					; store address
		clr.w	(a2)+					; clear address
		bra.s	MUUT_Start				; jump into loop

MUUT_SingleLine:
		subq.w	#$01,a0					; go back a line
		bra.s	MUUT_DoLine				; jump to do single line only

MUUT_NewLine:
		move.b	#$7F,-$01(a0)				; set as new line marker
		move.l	a0,(a2)+				; store line address

MUUT_DoLine:
		move.b	#$7F,(a0)+				; set as new line marker

MUUT_Start:
		moveq	#$00,d2					; reset word count
		moveq	#$00,d1					; reset width counter
		lea	(a0),a1					; store word location
		move.l	a1,(a2)+				; store line address
		bra.s	MUUT_NoReturn				; jump into the loop

MUUT_NoFinish:
		subi.b	#$80,d0					; convert to VRAM ASCII
		move.b	d0,(a0)+				; save character
		bne.s	MUUT_NoSpace				; if this is not a space character, branch
		lea	(a0),a1					; store next word location
		moveq	#-$01,d2				; reset counter

MUUT_NoSpace:
		cmpi.b	#$5F,d0					; is this a new paragraph?
		beq.s	MUUT_NewLine				; if so, branch
		cmpi.b	#('¬'-$20)&$FF,d0			; is this a single new-line?
		beq.s	MUUT_SingleLine
		addq.b	#$01,d2					; increase word count
		addq.b	#$01,d1					; increase width count
		cmpi.b	#$28-2,d1				; have we reached the end?
		bne.s	MUUT_NoReturn				; if not, branch
		move.b	d2,d1					; reset
		move.b	#$7F,-$01(a1)				; change the space to a return character
		move.l	a1,(a2)+				; store line address

MUUT_NoReturn:
		move.b	(a0),d0					; load character
		bne.s	MUUT_NoFinish				; if this is not the end of the list, branch
		st.b	(a0)					; set end marker
		clr.l	(a2)					; clear last line/position
		move.w	a2,d0					; load last address
		subi.w	#(EMU_InfoData&$FFFF),d0		; minus RAM address
		lsr.w	#$02,d0					; divide by long-word
		move.w	d0,(a3)					; save maximum number of lines to render
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank routine for text data
; ---------------------------------------------------------------------------

VB_MuseumText:
		tst.b	(V_int_routine).w			; was the 68k late?
		beq.w	VBMTxt_68kLate				; if so, branch
		sf.b	(V_int_routine).w			; set V-blank as ran
		movem.l	d0-a4,-(sp)				; store register data
		lea	($C00000).l,a5
		lea	$04(a5),a6
		jsr	Poll_Controllers			; read controls
		move.l	#$40000010,(a6)
		move.l	(EMU_TextScroll).w,(a5)

		move.w	(EMU_TextScroll).w,d2			; load scroll position
		asr.w	#$03,d2					; divide by 8
		bsr.w	MU_RenderLine				; render top line
		addi.w	#$1C,d2					; advance to bottom
		bsr.w	MU_RenderLine				; render bottom line
	Z80DMAOn
		DMA	$0080, $C0000000, Normal_palette	; palette only
	Z80DMAOff
		movem.l	(sp)+,d0-a4				; restore register data

VBMTxt_68kLate:
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to transition from the museum to the screenshot itself
; ---------------------------------------------------------------------------
MUC_TRANSSIZE	=	$2000
; ---------------------------------------------------------------------------

MUC_Transition:
		jsr	MU_FadeOut				; fade out to black
		move	#$2700,sr				; disable interrupts

		move.l	#NullRTE,(H_int_addr).w			; set H-blank routine
		move.l	#VB_MuseumTrans,(V_int_addr).w		; set V-blank routine

		lea	(MU_ShotList).l,a0			; load shot/page list
		jsr	MU_GetEntry				; load entry ID
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		move.l	(a0,d0.w),a0				; load correct entry

	; --- IRAM stuff ---
	; This has to be decompressed first so that the sprite table address
	; is set BEFORE the sprite data in VRAM is written to.
	; The caché won't update unless it's sprite table address
	; (the one currently set) is written to.  Some games/states
	; may and probably will use a different sprite table address...

		lea	($FFFF8000).w,a1			; set dumping address
		jsr	TwizDec					; decompress and dump

		move.w	#$8500,d0
		move.b	($FFFF8000+$80+$50+$05).w,d0
		move.w	d0,(a6)		; set sprite table address

	; --- VRAM Part A ---

		lea	($00FF0000).l,a1			; set dumping address
		jsr	TwizDec					; decompress and dump
		move.l	#$96809500,(a6)				; set DMA source
		move.w	#$977F,(a6)				; '' (this will auto-increment)
		move.l	#$00200000,d4				; set VRAM address
		moveq	#($8000/MUC_TRANSSIZE)-1,d5		; set number of transfers to do

MUCT_TransferA:
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank
		addi.w	#MUC_TRANSSIZE,d4			; advance to next VRAM address
		dbf	d5,MUCT_TransferA			; repeat until all transfers for part A are done
		move	#$2700,sr				; disable interrupts

	; --- VRAM Part B ---

		lea	($00FF0000).l,a1			; set dumping address
		jsr	TwizDec					; decompress and dump
		move.l	#$96809500,(a6)				; set DMA source
		move.w	#$977F,(a6)				; '' (this will auto-increment)
		move.l	#$00208000,d4				; set VRAM address
		moveq	#($8000/MUC_TRANSSIZE)-1,d5		; set number of transfers to do

MUCT_TransferB:
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank
		addi.w	#MUC_TRANSSIZE,d4			; advance to next VRAM address
		dbf	d5,MUCT_TransferB			; repeat until all transfers for part A are done
		move	#$2700,sr				; disable interrupts

	; --- IRAM ---

		lea	($FFFF8000).w,a0			; load IRAM data
		lea	(Target_palette).w,a1			; load palette buffer
		moveq	#($80/$04)-1,d1				; set size of palette to load

MUCT_LoadCRAM:
		move.l	(a0)+,(a1)+				; load palette into buffer
		dbf	d1,MUCT_LoadCRAM			; repeat for whole CRAM buffer size

		move.l	#$40000010,(a6)				; set VDP to VSRAM write mode
		moveq	#($50/$04)-1,d1				; size of VSRAM

MUCT_LoadVSRAM:
		move.l	(a0)+,(a5)				; copy VSRAM data into VSRAM
		dbf	d1,MUCT_LoadVSRAM			; repeat until done

		move.w	#$8000,d0				; prepare VDP register
		moveq	#$13-1,d1				; set number of registers to write

MUCT_VDPReg:
		move.b	(a0)+,d0				; load register value
		move.w	d0,d2					; copy to d2
		sf.b	d2					; get only the register
		cmpi.w	#$8C00,d2				; is this the shadow/highlight register?
		bne.s	MUCT_NoShadow				; if not, branch
		move.w	d0,(EMU_ShadowReg).w			; save register for later
		bclr.l	#$03,d0					; clear shadow/highlight bit
		beq.s	MUCT_NoShadow				; if shadow/highlight was not already set, branch
		move.b	#$00,(EMU_FadeSpeed).w			; set fade in/out speed to 00 (so it's quicker)

MUCT_NoShadow:
		move.w	d0,(a6)					; set VDP register
		addi.w	#$0100,d0				; increase to next register
		dbf	d1,MUCT_VDPReg				; repeat for all registers

		move.l	#VB_MuseumShot,(V_int_addr).w		; set V-blank routine
		move.b	#$0E,(EMU_FadeCount).w			; reset fade counter

; ---------------------------------------------------------------------------
; Main Loop - Shot Loop
; ---------------------------------------------------------------------------

ML_MuseumShot:
		tst.b	(EMU_FadeSpeed).w			; is the speed set to 00?
		bne.s	MLMS_NoShadow				; if noy, the image is NOT shadow/highlighted, so branch
		cmpi.b	#SHADOWFADE,(EMU_FadeCount).w		; have we reached the middle point?
		bne.s	MLMS_NoShadow				; if not, branch
		move.w	(EMU_ShadowReg).w,(a6)			; disable shadow/highlight
		bclr.b	#$03,(EMU_ShadowReg+1).w		; clear shadow/highlight bit

MLMS_NoShadow:
		bsr.w	MU_FadeIn				; continue fading in
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank
		move.b	(Ctrl_1_pressed).w,d0			; load controls
		or.b	(Ctrl_2_pressed).w,d0			; fuse player 2's controls
		andi.b	#$F0,d0					; get START, A, B, and C buttons
		beq.s	ML_MuseumShot				; if none of them are pressed, branch
		tst.b	(EMU_FadeSpeed).w			; is the speed set to 00?
		beq.s	MLMS_FadeOut				; if so, the image is shadow/highlighted, so branch

	; --- Normal fade out ---

		jsr	MU_FadeOut				; fade out to black
		jmp	Museum_Return				; go back to Museum

	; --- Shadow/Highlight fade out ---

MLMS_FadeOut:
		cmpi.b	#SHADOWFADE+2,(EMU_FadeCount).w		; have we reached the middle point?
		bne.s	MLMS_NoShadow2				; if not, branch
		move.w	(EMU_ShadowReg).w,(a6)			; disable shadow/highlight

MLMS_NoShadow2:
		addq.b	#$02,(EMU_FadeCount).w			; increase counter (just to keep track of when to switch)
		bsr.w	MUFO_Perform				; perform fade out
		tst.b	d3					; has a colour changed still?
		bne.s	MLMS_FadeOut				; if so, branch to loop
		jmp	Museum_Return				; go back to Museum

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank routine for transfering the screenshot VRAM data
; ---------------------------------------------------------------------------

VB_MuseumTrans:
		tst.b	(V_int_routine).w			; was the 68k late?
		beq.w	VBMT_68kLate				; if so, branch
		sf.b	(V_int_routine).w			; set V-blank as ran
		movem.l	d0-a4,-(sp)				; store register data
	Z80DMAOn
		move.l	#$94009300|(((MUC_TRANSSIZE>>1)&$FF00)<<8)|((MUC_TRANSSIZE>>1)&$00FF),(a6); set DMA size
		lsl.l	#$02,d4					; convert destination DMA port value
		lsr.w	#$02,d4					; ''
		ori.w	#$4000,d4				; ''
		swap	d4					; ''
		andi.w	#$0083,d4				; ''
		move.l	d4,(a6)					; set destination
	Z80DMAOff
		movem.l	(sp)+,d0-a4				; restore register data

VBMT_68kLate:
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank routine for the screenshot
; ---------------------------------------------------------------------------

VB_MuseumShot:
		tst.b	(V_int_routine).w			; was the 68k late?
		beq.w	VBMS_68kLate				; if so, branch
		sf.b	(V_int_routine).w			; set V-blank as ran
		movem.l	d0-a4,-(sp)				; store register data
		lea	($C00000).l,a5
		lea	$04(a5),a6
		jsr	Poll_Controllers			; read controls
	Z80DMAOn
		DMA	$0080, $C0000000, Normal_palette	; palette only
	Z80DMAOff
		movem.l	(sp)+,d0-a4				; restore register data

VBMS_68kLate:
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Text screen includes
; ---------------------------------------------------------------------------

Art_MusText:	binclude "Screen Museum\Shots - Info\Characters.twim"
		even
Art_BGText:	binclude "Screen Museum\Shots - Info\Art BG.twim"
		even
Map_BGText:	binclude "Screen Museum\Shots - Info\Map BG.eni"
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load a museum's slot bits
; --- input -----------------------------------------------------------------
; d0 = slot ID to read from
; --- output -----------------------------------------------------------------
; d0 = slot's status (binary: SS00 0000)
; ---------------------------------------------------------------------------

LoadSlot_Museum:
		movem.l	d1-d2,-(sp)				; store register data
		move.b	d0,d2					; store a copy in d2 for later
		move.w	d0,d1					; copy to d1
		lsr.w	#$02,d1					; divide by 4 (4 entries per byte)
		addi.w	#SRAM_MUSEUM,d1				; advance to correct SRAM address
		jsr	(SRAM_Load).w				; load the byte from SRAM
		andi.w	#$0003,d2				; get exact slot
		dbf	d2,LSM_NextSlot				; if it's not the first slot, branch
		andi.b	#%11000000,d0				; get only the slots' bits
		movem.l	(sp)+,d1-d2				; restore registers
		rts						; return

LSM_NextSlot:
		add.b	d0,d0					; shift to next slot
		add.b	d0,d0					; ''
		dbf	d2,LSM_NextSlot				; if it's not the first slot, branch
		andi.b	#%11000000,d0				; get only the slots' bits
		movem.l	(sp)+,d1-d2				; restore registers
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to save a museum's slot bits
; --- input -----------------------------------------------------------------
; d0 = slot ID to write to
; d1 = slot's status bits to write (binary: SS00 0000)
; ---------------------------------------------------------------------------

SaveSlot_Museum:
		movem.l	d0-d4,-(sp)				; store register data
		andi.b	#%11000000,d1				; get only the slots' bits
		move.w	#$FF00|%00111111,d3			; prepare and value
		move.b	d0,d2					; store a copy in d2 for later
		move.l	d1,-(sp)				; store status bits
		move.w	d0,d1					; copy slot address to d1
		lsr.w	#$02,d1					; divide by 4 (4 entries per byte)
		addi.w	#SRAM_MUSEUM,d1				; advance to correct SRAM address
		move.w	d1,d4					; keep a copy of the address for later
		jsr	(SRAM_Load).w				; load the byte from SRAM
		move.l	(sp)+,d1				; reload status bits
		andi.w	#$0003,d2				; get exact slot
		bra.s	SSM_CheckSlot

SSM_NextSlot:
		lsr.b	#$02,d1					; shift bits down
		lsr.w	#$02,d3					; shift AND position down

SSM_CheckSlot:
		dbf	d2,SSM_NextSlot				; if it's not the first slot, branch
		and.b	d3,d0					; clear the slot's bits
		or.b	d1,d0					; save bits to the slot
		move.w	d4,d1					; reload SRAM address
		jsr	(SRAM_Save).w				; save SRAM data
		movem.l	(sp)+,d0-d4				; restore registers
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Screenshot includes
; ---------------------------------------------------------------------------
; MU_ShotList: MU_ShotList_End: MU_IconList:

		include "Screen Museum\Shot Includes.asm"
		even

; ===========================================================================


