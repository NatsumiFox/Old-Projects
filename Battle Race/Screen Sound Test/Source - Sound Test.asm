; ===========================================================================
; ---------------------------------------------------------------------------
; Sound Test Screen
; ---------------------------------------------------------------------------
EST_SoundTest	=	LS_SoundTest			; word	; sound test number
EST_Tempo	=	LS_Tempo			; byte	; tempo in sound test
; ---------------------------------------------------------------------------

EST_MusicData	=	$FFFF4000
EST_MusicAddZ80	=	$FFFF4400
EST_MusicAdd68k	=	$FFFF4800
EST_MusicStatus	=	$FFFF4C00
EST_MusicRAM	=	$FFFFF000
EST_ChannelRAM	=	$FFFFF040

EST_ChannelSize	=	$30

EST_PCM1	=	(EST_ChannelRAM+(EST_ChannelSize*$00))
EST_PCM2	=	(EST_ChannelRAM+(EST_ChannelSize*$01))
EST_FM1		=	(EST_ChannelRAM+(EST_ChannelSize*$02))
EST_FM2		=	(EST_ChannelRAM+(EST_ChannelSize*$03))
EST_FM3		=	(EST_ChannelRAM+(EST_ChannelSize*$04))
EST_FM4		=	(EST_ChannelRAM+(EST_ChannelSize*$05))
EST_FM5		=	(EST_ChannelRAM+(EST_ChannelSize*$06))
EST_FM6		=	(EST_ChannelRAM+(EST_ChannelSize*$07))
EST_PSG1	=	(EST_ChannelRAM+(EST_ChannelSize*$08))
EST_PSG2	=	(EST_ChannelRAM+(EST_ChannelSize*$09))
EST_PSG3	=	(EST_ChannelRAM+(EST_ChannelSize*$0A))

EST_FM3_SFX	=	(EST_ChannelRAM+(EST_ChannelSize*$0B))
EST_FM4_SFX	=	(EST_ChannelRAM+(EST_ChannelSize*$0C))
EST_FM5_SFX	=	(EST_ChannelRAM+(EST_ChannelSize*$0D))
EST_PSG1_SFX	=	(EST_ChannelRAM+(EST_ChannelSize*$0E))
EST_PSG2_SFX	=	(EST_ChannelRAM+(EST_ChannelSize*$0F))
EST_PSG3_SFX	=	(EST_ChannelRAM+(EST_ChannelSize*$10))

EST_FM4_EXT	=	(EST_ChannelRAM+(EST_ChannelSize*$11))
EST_PSG3_EXT	=	(EST_ChannelRAM+(EST_ChannelSize*$12))
; ---------------------------------------------------------------------------

SoundTest:
		moveq	#-$1F,d0				; fade music out
		jsr	Play_Sound.w				; ''
		moveq	#0,d0
		jsr	Change_Music_Tempo.w			; slow music down
		clr.w	(Kos_decomp_queue_count).w		; clear kosinski decompression cue count
		jsr	Clear_KosM_Queue.w			; clear Kosinski Moduled decompression cue information
		jsr	Pal_FadeToBlack				; fade out to black

	; --- Setup/clearing ---

		move	#$2700,sr				; disable interrupts
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.l	#NullRTE,(H_int_addr).w			; set H-blank routine
		move.l	#VB_TitleInit,(V_int_addr).w		; set V-blank routine
		move.w	#$8000|%00000100,(a6)			; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)
		move.w	#$8100|%01110100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.w	#$8200|((($C000)>>$0A)&$FF),(a6)	; 00FE DCBA - Scroll Plane A Map Table VRam address
		move.w	#$8300|((($F000)>>$0A)&$FF),(a6)	; 00FE DCB0 / 00FE DC00 (20 H-resol) - Window Plane A Map Table VRam address
		move.w	#$8400|((($E000)>>$0D)&$FF),(a6)	; 0000 0FED - Scroll Plane B Map Table VRam address
		move.w	#$8500|((($F800)>>$09)&$FF),(a6)	; 0FED CBA9 / 0FED CBA0 (20 H-resol) - Sprite Plane Map Table VRam address
		move.w	#$8600|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8700|$20,(a6)				; 00PP CCCC - Backdrop Colour: Palette Line | Colour ID
		move.w	#$8800|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8900|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8A00|$DF,(a6)				; 7654 3210 - H-Interrupt Register
		move.w	#$8B00|%00000011,(a6)			; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)
		move.w	#$8C00|%10000001,(a6)			; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
		move.w	#$8D00|((($FC00)>>$0A)&$FF),(a6)	; 00FE DCBA - Horizontal Scroll Table VRam address
		move.w	#$8E00|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8F00|$02,(a6)				; 7654 3210 - Auto Increament
		move.w	#$9000|%00010001,(a6)			; 00VV 00HH - Plane Y Size (00-20|01-40|11-80) | Plane X size (00-20|01-40|11-80)
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
		move.w	#(($A400/$04)/$04)-1,d1			; set size of RAM

ST_ClearMain:
		move.l	d0,(a1)+				; clear RAM
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		dbf	d1,ST_ClearMain				; repeat til main RAM is clear

		lea	(EST_MusicRAM).w,a1			; load music RAM
		move.w	#(($600/$04)/$02)-1,d1			; set size to clear

ST_ClearMusic:
		move.l	d0,(a1)+				; clear RAM
		move.l	d0,(a1)+				; ''
		dbf	d1,ST_ClearMusic			; repeat til music RAM is cleared

		lea	(Sprite_table_buffer).w,a1		; sprite RAM
		moveq	#(($280/$04)/$02)-1,d1			; set size of RAM

ST_ClearSprites:
		move.l	d0,(a1)+				; clear RAM
		move.l	d0,(a1)+				; ''
		dbf	d1,ST_ClearSprites			; repeat til sprites art clear

		lea	(H_scroll_buffer).w,a1			; H-Scroll RAM
		moveq	#(($400/$04)/$02)-1,d1			; set size of RAM

ST_ClearHScroll:
		move.l	d0,(a1)+				; clear RAM
		move.l	d0,(a1)+				; ''
		dbf	d1,ST_ClearHScroll			; repeat til H-Scroll is clear

		move.l	d0,(V_scroll_value).w			; clear V-scroll

	; --- Loading data ---

		lea	(Pal_Sound).l,a0			; load palette data
		lea	(Target_palette+$00).w,a1		; load palette RAM
		moveq	#(((Pal_Sound_End-Pal_Sound)/4)/2)-1,d1	; set size of palette to laod

ST_LoadPal:
		move.l	(a0)+,(a1)+				; load palette
		move.l	(a0)+,(a1)+				; ''
		dbf	d1,ST_LoadPal				; repeat until entire palette is loaded

		lea	(Art_Piano).l,a1			; load art to decompress
		move.w	#$0000,d2				; set VRAM address to decompress to
		jsr	Queue_Kos_Module.w			; decompress and dump

		lea	(Art_Keys).l,a1				; load art to decompress
		move.w	#$A000,d2				; set VRAM address to decompress to
		jsr	Queue_Kos_Module.w			; decompress and dump

		lea	(Art_Char).l,a1				; load art to decompress
		move.w	#$A800,d2				; set VRAM address to decompress to
		jsr	Queue_Kos_Module.w			; decompress and dump

		lea	(Art_Extras).l,a1			; load art to decompress
		move.w	#$BC00,d2				; set VRAM address to decompress to
		jsr	Queue_Kos_Module.w			; decompress and dump

		lea	(Art_DAC).l,a1				; load DAC note art
		move.w	#$D300,d2				; set VRAM address to decompress to
		jsr	Queue_Kos_Module.w			; decompress and dump

	; --- Decompress Kos Module data ---

ST_DelayLoad:
		st.b	(V_int_routine).w			; set V-blank flag
		jsr	Process_Kos_Queue
		jsr	Wait_VSync
		jsr	Process_Kos_Module_Queue.w
		tst.l	(Kos_module_queue).w
		bne.s	ST_DelayLoad
		st.b	(V_int_routine).w			; set V-blank flag
		jsr	Wait_VSync
		move	#$2700,sr				; disable interrupts
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.l	#VB_SoundTest_NoHB,(V_int_addr).w	; set V-blank routine

	; --- Loading mappings ---

		lea	(Map_Piano).l,a0			; load plane A map address
		lea	($FFFF6000).l,a1			; load map dumping area to a1
		jsr	MunDec					; decompress and dump
		lea	($FFFF6000).l,a1			; load mappings
		move.l	#$60000003,d0				; set VRAM address
		moveq	#$28-1,d1				; set width
		moveq	#$1C-1,d2				; set height
		jsr	ST_MapScreen				; load mappings to plane in VRAM
		lea	($FFFF7220).l,a1			; load mappings of brighter bottom font bar area
		moveq	#$28-1,d1				; set width
		moveq	#$0F-1,d2				; set height
		jsr	ST_MapScreen				; load mappings to plane in VRAM

	; --- Final subroutines ---

		lea	($FFFF6050).l,a0			; load piano mappings
		lea	($FFFF8000).w,a1			; load plane buffer
		moveq	#$16-1,d2				; set number of rows to copy

ST_LoadMapRow:
		lea	(a1),a2					; load address to a2
		lea	$80(a1),a1				; advance to next row for next pass
		moveq	#($28/$08)-1,d1				; set number of tile maps to copy

ST_LoadMapLine:
		move.l	(a0)+,(a2)+				; copy mappings to buffer
		move.l	(a0)+,(a2)+				; ''
		move.l	(a0)+,(a2)+				; ''
		move.l	(a0)+,(a2)+				; ''
		dbf	d1,ST_LoadMapLine			; repeat for entire row
		dbf	d2,ST_LoadMapRow			; repeat for all rows
		bset.b	#$00,($FFFFA000).w			; set to redraw the plane

		bsr.w	ST_SetupKeyColours			; setup the colour fades/variations for the keys

	; --- Final variables ---

		moveq	#-1,d0					; set "previous" X and Y menu positions to something null
		move.l	d0,($FFFFA020+4).w			; ''
		move.l	d0,($FFFFA030+4).w			; ''
		move.w	#$0118,($FFFFA026).w			; set X position of text scroll

		move.b	#$80,($FFFF9000+$0B).w			; set PCM1 and2 as already rendered (this'll force FM6 to render if no music is playing)

		; reloading a5/a6 just in case...

		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.w	#$8000|%00010100,(a6)			; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)
		move.w	#$8100|%01110100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.l	#VB_SoundTest,(V_int_addr).w		; set V-blank routine
		moveq	#-$20,d0				; set sound ID to "Stop music"
		jsr	Play_Sound_2.w				; play sound ID
;	stopZ80
;		bsr.w	Z80_WriteModes				; write the modes
;	startZ80
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank
		jsr	SB_SoundTest				; rub subroutines
		jsr	Pal_FadeFromBlack			; fade into colour

; ---------------------------------------------------------------------------
; Main Loop - Sound Test
; ---------------------------------------------------------------------------

ML_SoundTest:
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank
		bsr.s	SB_SoundTest				; run subroutines
		move.b	(Ctrl_1_pressed).w,d0			; load player 1 buttons
		or.b	(Ctrl_2_pressed).w,d0			; fuse player 2 buttons
		btst.l	#$04,d0					; was B pressed?
		beq.s	ML_SoundTest				; if neither player have pressed B, branch
		moveq	#-$20,d0				; set sound ID to "Stop music"
		jsr	Play_Sound_2.w				; play sound ID
		move.l	#VB_SoundTest_NoHB,(V_int_addr).w	; set V-blank routine
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank
		move.l	#Hint,(H_int_addr).w			; set H-blank routine
		move.l	#Vint,(V_int_addr).w			; set V-blank routine
		move.b	#$04,(Game_mode).w			; set game mode to 04 (Main Menu)
	stopZ80
		move.b	#$00,(Z80_RAM+zTempoCtrl).l		; clear tempo setting
	startZ80
		rts						; return

; ---------------------------------------------------------------------------
; Subroutines - Sound Test
; ---------------------------------------------------------------------------

SB_SoundTest:
		bsr.w	ST_DrawFont				; draw the font (doing this BEFORE the control so scroll remains in sync)
		bsr.w	ST_Control				; read controls and perform options
		bsr.s	ST_DrawBars				; draw the transparent bars correctly
		bsr.w	ST_DrawPaino				; draw the piano background boards correctly
		bsr.w	ST_DrawKeys				; draw the keys on the piano

; ---------------------------------------------------------------------------
; Subroutine to scroll the text font of the music/sound being played
; ---------------------------------------------------------------------------

ST_ScrollFont:
		moveq	#$00,d0					; clear d0
		move.w	($FFFFA026).w,d0			; load text position
		swap	d0					; send to FG word
		lea	(H_scroll_buffer+$2F4).w,a1		; load scroll buffer area where text is
		move.l	d0,(a1)+				; set scroll position of text
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Drawing the transparent font bars
; ---------------------------------------------------------------------------

ST_DrawBars:
		move.l	#$002D0000,d0				; clear all registers
		move.l	d0,d1					; ''
		move.l	d0,d2					; ''
		move.l	d0,d3					; ''
		move.l	d0,d4					; ''
		move.l	d0,d5					; ''
		move.l	d0,d6					; ''
		move.l	d0,d7					; ''
		lea	($FFFF5E00+($28*4)).l,a1		; load bar VSRAM buffer
		movem.l	d0-d7,-(a1)				; clear buffer
		movem.l	d0-d7,-(a1)				; ''
		movem.l	d0-d7,-(a1)				; ''
		movem.l	d0-d7,-(a1)				; ''
		movem.l	d0-d7,-(a1)				; ''
		lea	($FFFFA010).l,a0			; load bar to display
		lea	(STDB_Dark).l,a2			; load brightness to use
		bsr.s	STDB_Draw				; draw the bar
		lea	($FFFFA014).l,a0			; load bar to display
		lea	(STDB_LightIn).l,a2			; load brightness to use
		bsr.s	STDB_Draw				; draw the bar
		lea	($FFFFA018).l,a0			; load bar to display
		lea	(STDB_Dark).l,a2			; load brightness to use
		bsr.s	STDB_Draw				; draw the bar
		lea	($FFFFA01C).l,a0			; load bar to display
		lea	(STDB_LightIn).l,a2			; load brightness to use

STDB_Draw:
		moveq	#$00,d6					; clear d6
		move.b	$02(a0),d6				; load size
		subq.w	#$01,d6					; minus 1 for dbf
		bmi.s	STDB_NoDraw				; if there is no size, branch
		moveq	#$00,d0					; clear d0
		move.b	(a0),d0					; load bar position
		cmpi.b	#$28,d0					; is it too far down?
		bhs.s	STDB_NoDraw				; if so, branch
		add.w	d0,d0					; multiply by long-word
		add.w	d0,d0					; ''
		lea	($FFFF5E00).l,a1			; load buffer
		adda.w	d0,a1					; advance to correct starting point
		cmpi.b	#$28+$02,d6				; is the size too large?
		bls.s	STDB_NoMaxSize				; if not, branch
		moveq	#$28+$02,d6				; set to maximum size

STDB_NoMaxSize:
		move.l	$04(a2),(a1)+				; draw edge
		dbf	d6,STDB_NoSingle			; if not finished, branch
		rts						; return

STDB_NoSingle:
		subq.w	#$02,d6					; minus size of minimum without middle
		bmi.s	STDB_End				; if there's no middle, branch

STDB_NoEnd:
		move.l	(a2),(a1)+				; draw ligh section
		dbf	d6,STDB_NoEnd				; repeat until all done

STDB_End:
		addq.w	#$01,d6					; adjust counter
		bmi.s	STDB_NoEdge				; if it was 0001 originaly, branch
		move.l	$04(a2),(a1)+				; draw egde again

STDB_NoEdge:
		move.l	$08(a2),(a1)+				; draw black line

STDB_NoDraw:
		rts						; return

	; --- Bright bar colours ---

STDB_Light:	dc.l	$00050050				; middle
		dc.l	$002D0028				; edges
		dc.l	$00550078				; black line

	; --- Dark bar colours ---

STDB_Dark:	dc.l	$002D0028				; middle
		dc.l	$002D0028				; edges
		dc.l	$00550078				; black line

	; --- Bright bar colours (WITHOUT THE EDGE) ---
	; For being displayed INSIDE a dark bar ONLY

STDB_LightIn:	dc.l	$00050050				; middle
		dc.l	$00050050				; edges
		dc.l	$00050050				; black line

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw the font onto the bars correctly
; ---------------------------------------------------------------------------

ST_DrawFont:

	; --- The song name ---

		move.w	(EST_SoundTest).w,d0			; load top menu X position
		move.w	($FFFFA022).w,d1			; is a change in progress?
		bne.s	STDF_Name				; if so, branch
		cmp.w	($FFFFA024).w,d0			; has it changed?
		beq.s	STDF_NoName				; if not, branch
		move.w	d0,($FFFFA024).w			; update change

STDF_Name:
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		lea	(STC_List).l,a0				; load font list
		movea.l	(a0,d0.w),a0				; load correct string
		adda.w	d1,a0					; advance to correct character
		add.w	d1,d1					; multiply by size of word for VRAM
		addq.w	#$02,($FFFFA022).w			; advance to next character for next frame
		subi.w	#$0010,($FFFFA026).w			; decrease position
		move.b	(a0)+,d3				; load character
		bne.s	STDF_NoNameFinish			; if valid, branch
		clr.w	($FFFFA022).w				; clear change position

STDF_NoNameFinish:

		move.l	#$00034C04,d0				; prepare VRAM address
		add.w	d1,d0
		swap	d0
		move	#$2700,sr				; disable interrupts
		move.w	#$8F80,(a6)				; set to increment a single line
		bsr.w	ST_DrawChar				; render the character
		move.b	(a0)+,d3				; load character
		bne.s	STDF_NoNameFinish2			; if valid, branch
		clr.w	($FFFFA022).w				; clear change position
		moveq	#' ',d3

STDF_NoNameFinish2:
		bsr.w	ST_DrawChar				; render the character
		moveq	#' ',d3					; set to load the space character
		bsr.w	ST_DrawChar				; ''
		move.w	#$8F02,(a6)				; revert increment mode
		move	#$2300,sr				; re-enable interrupts

STDF_NoName:

	; --- The options ---

		move.w	($FFFFA030).w,d0			; load top menu X position
		cmp.w	($FFFFA034).w,d0			; has it changed?
		beq.s	STDF_NoOption				; if not, branch
		move.w	d0,($FFFFA034).w			; update change
		lsl.w	#$03,d0					; multiply by size of 2 long-words
		lea	(STC_Opt).l,a0				; load font list
		movea.l	(a0,d0.w),a0				; load correct string


		move.l	#$4D020003,d0
		move	#$2700,sr				; disable interrupts
		move.w	#$8F80,(a6)				; set to increment a single line
		bsr.s	ST_DrawText
		move.w	#$8F02,(a6)				; revert increment mode
		move	#$2300,sr				; re-enable interrupts

STDF_NoOption:
		rts						; return

; ---------------------------------------------------------------------------
; Drawing text correctly to VRAM
; ---------------------------------------------------------------------------

ST_DrawText:
		move.l	d0,d1					; get dark VRAM address
		addi.l	#(($05*$80)<<$10),d1			; ''
		move.l	#$00020000,d2				; set advance amount
		lea	(Map_Char).l,a2				; load mappings address
		move.b	(a0)+,d3				; load character

STDT_NextChar:
		bsr.s	STDT_RenderChar				; draw character
		move.b	(a0)+,d3				; load next character
		bne.s	STDT_NextChar				; if not finished, branch
		rts						; return

; ---------------------------------------------------------------------------
; Subroutine to render a single character
; ---------------------------------------------------------------------------

ST_DrawChar:
		move.l	d0,d1					; get dark VRAM address
		addi.l	#(($05*$80)<<$10),d1			; ''
		move.l	#$00020000,d2				; set advance amount
		lea	(Map_Char).l,a2				; load mappings address

STDT_RenderChar:
		moveq	#$00,d4					; set size as single tile
		lea	(a2),a1					; reload font mappings
		cmpi.b	#' ',d3					; is it a space?
		beq.w	STDT_Space				; if so, branch
		addq.w	#$04,a1					; skip to next special character
		cmpi.b	#'<',d3					; is it a *insert symbol here*?
		beq.w	STDT_Space				; if so, branch
		addq.w	#$04,a1					; skip to next special character
		cmpi.b	#'>',d3					; is it a *insert symbol here*?
		beq.w	STDT_Space				; if so, branch
		cmpi.b	#'#',d3					; is it a variable?
		bne.s	STDT_NoVar				; if not, branch
		moveq	#$00,d3					; clear d3
		move.b	(a0)+,d3				; load variable number
		subi.b	#'0',d3					; ''
		add.w	d3,d3					; multiply by word
		moveq	#-1,d4					; load RAM address of variable
		move.w	STDT_VarList(pc,d3.w),d4		; ''
		move.l	d4,a1					; ''
		move.b	(a1),d3					; load variable
		move.b	d3,d4					; get first nybble
		lsr.b	#$04,d4					; ''
		andi.w	#$000F,d4				; ''
		addq.b	#$03,d4					; adjust it
		add.w	d4,d4					; multiply by long-word
		add.w	d4,d4					; ''
		lea	(a2,d4.w),a1				; load correct font mappings
		move.l	d1,(a6)					; set VRAM for dark
		move.l	$2E*4(a1),(a5)				; write character
		move.l	d0,(a6)					; set VRAM address
		move.l	(a1)+,(a5)				; write character
		add.l	d2,d0					; advance addresses
		add.l	d2,d1					; ''
		moveq	#$00,d4					; clear nybble size
		andi.w	#$000F,d3				; get second nybble
		addq.b	#$03,d3					; adjust it
		lea	(a2),a1					; load font mappings address
		bra.s	STDT_Special				; continue normally

STDT_VarList:	dc.w	$F014					; #0 - Pitch
		dc.w	EST_Tempo&$FFFF				; #1 - Tempo
		dc.w	$F016					; #2 - Volume
		dc.w	$0000					; #3 - Unused...
								; #4
								; #5 ...etc up to #9...

STDT_NoVar:
		cmpi.b	#'-',d3					; is it a dash symbol?
		bne.s	STDT_NoDash				; if not, branch
		lea	$27*4(a2),a1
		bra.s	STDT_Space

STDT_NoDash:
		cmpi.b	#'Z',d3					; is it a regular letter or number?
		bls.s	STDT_Letter				; if so, branch
		subi.b	#'a',d3					; subtract "a" for rendering button graphics
		add.w	d3,d3					; multiply by 2 (since the tiles are twice the size
		lea	$28*4(a2),a1				; advance to button graphics
		moveq	#$01,d4					; set size as double tile
		bra.s	STDT_Special				; render the buttons

STDT_Letter:
		cmpi.b	#'9',d3					; is it a number?
		bls.s	STDT_Number				; if so, branch
		subq.b	#'A'-('9'+1),d3				; adjust to letters

STDT_Number:
		subi.b	#'0'-1,d3				; adjust character

STDT_Special:
		ext.w	d3					; clear upper byte
		add.w	d3,d3					; multiply by long-word
		add.w	d3,d3					; ''
		adda.w	d3,a1					; advance to correct character

STDT_Space:
		move.l	d1,(a6)					; set VRAM for dark
		move.l	$2E*4(a1),(a5)				; write character
		move.l	d0,(a6)					; set VRAM address
		move.l	(a1)+,(a5)				; write character
		add.l	d2,d0					; advance addresses
		add.l	d2,d1					; ''
		dbf	d4,STDT_Space				; repeat for size
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control the menu correctly
; ---------------------------------------------------------------------------

ST_Control:
		move.l	($FFFFA004).w,d0			; load routine
		bne.s	STC_ValidRoutine			; if the routine is valid, branch
		move.l	#STC_Intro,d0				; set starting routine
		move.l	d0,($FFFFA004).w			; ''

STC_ValidRoutine:
		movea.l	d0,a0					; set address
		jmp	(a0)					; run address

; ===========================================================================
; ---------------------------------------------------------------------------
; The intro
; ---------------------------------------------------------------------------

STC_Intro:
		move.l	#$0C000000,($FFFFA010).w		; set starting position/size of bars
		move.l	#$0C000000,($FFFFA014).w		; ''
		move.l	#$1C000000,($FFFFA018).w		; ''
		move.l	#$1C000000,($FFFFA01C).w		; ''
		move.l	#STC_Intro_BarsIn,($FFFFA004).w		; set next routine
		rts						; return

	; --- Top bar in ---

STC_Intro_BarsIn:
		lea	($FFFFA010).w,a1			; load bar
		move.b	(a1),d0					; load position
		addq.b	#$02,$02(a1)				; increase size
		subq.b	#$01,d0					; decrease position
		cmpi.b	#$05,d0					; has it reached 5?
		bhi.s	STC_IBI_NoFinish			; if so, branch
		move.l	#STC_IBI_NextBar,($FFFFA004).w		; set next routine

STC_IBI_NoFinish:
		move.b	d0,(a1)					; set position
		rts						; return

	; --- Bottom bar in ---

STC_IBI_NextBar:
		lea	($FFFFA018).w,a1			; load bar
		move.b	(a1),d0					; load position
		addq.b	#$02,$02(a1)				; increase size
		subq.b	#$01,d0					; decrease position
		cmpi.b	#$15,d0					; has it reached 15?
		bhi.s	STC_IBI_NoFinishNext			; if so, branch
		move.l	#STC_IBI_Highlight,($FFFFA004).w	; set next routine

STC_IBI_NoFinishNext:
		move.b	d0,(a1)					; set position
		rts						; return

	; --- Highlighter ---

STC_IBI_Highlight:
		lea	($FFFFA014).w,a1			; load bar
		move.w	(a1),d0					; load position
		addq.b	#$01,$02(a1)				; increase size
		subi.w	#$0080,d0				; decrease position
		cmpi.w	#$0600,d0				; has it reached 5?
		bhi.s	STC_IBI_NoFinishHigh			; if so, branch
		move.l	#STC_TopBar,($FFFFA004).w		; set next routine
		subq.b	#$01,$02(a1)				; decrease size once

STC_IBI_NoFinishHigh:
		move.w	d0,(a1)					; set position
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Controls for top bar
; ---------------------------------------------------------------------------

STC_TopBar:
		bsr.w	STC_MoveHighlight			; move the highlight bar correctly
		move.b	(Ctrl_1_pressed).w,d5			; load pressed buttons
		or.b	(Ctrl_2_pressed).w,d5			; fuse player 2's buttons
		btst.l	#$01,d5					; was down pressed?
		beq.s	STC_TB_NoDown				; if not, branch
		andi.w	#%1111110011111100,(Ctrl_1_held).w	; clear up/down buttons
		andi.w	#%1111110011111100,(Ctrl_2_held).w	; clear up/down buttons
		move.l	#STC_BottomBar,($FFFFA004).w		; set next routine
		jmp	STC_BottomBar				; run the routine

STC_TB_NoDown:
		andi.b	#%00001100,d5				; get only left/right
		beq.s	STC_TB_NoPress				; if neither were pressed, branch
		clr.w	($FFFFA022).w				; reset draw position
		move.w	#$0118,($FFFFA026).w			; set X position of text scroll
		move.b	#$20,($FFFFA00F).w			; reset held timer
		bra.s	STC_TB_NoHeld				; continue

STC_TB_Release:
		move.b	#$20,($FFFFA00F).w			; reset held timer
		bra.s	STC_TB_NoRight				; continue

STC_TB_NoPress:
		move.b	(Ctrl_1_held).w,d5			; load held buttons
		or.b	(Ctrl_2_held).w,d5			; fuse player 2's held buttons
		andi.b	#%00001100,d5				; get only left/right
		beq.s	STC_TB_Release				; if neither were pressed, branch
		subq.b	#$01,($FFFFA00F).w			; decrease hold timer
		bcc.s	STC_TB_NoRight				; if still running, branch
		clr.w	($FFFFA022).w				; reset draw position
		move.w	#$0118,($FFFFA026).w			; set X position of text scroll
	;	sf.b	($FFFFA00F).w				; keep at 0
		move.b	#$04,($FFFFA00F).w			; reset hold timer

STC_TB_NoHeld:
		lsr.b	#$03,d5					; shift left into carry
		bcc.s	STC_TB_NoLeft				; if left was not pressed, branch
		subq.w	#$01,(EST_SoundTest).w			; decrease top menu X position
		bcc.s	STC_TB_NoLeft				; if it hasn't gone below the bottom, branch
		move.w	#((STC_List_End-STC_List)/$04)-1,(EST_SoundTest).w ; set to end of list

STC_TB_NoLeft:
		lsr.b	#$01,d5					; shift right into carry
		bcc.s	STC_TB_NoRight				; if right was not pressed, branch
		addq.w	#$01,(EST_SoundTest).w			; increase top menu X position
		cmpi.w	#((STC_List_End-STC_List)/$04),(EST_SoundTest).w ; has it reached the end of the list?
		blo.s	STC_TB_NoRight				; if not, branch
		clr.w	(EST_SoundTest).w			; set to beginning of list

STC_TB_NoRight:
		bra.w	STC_BB_NoRight

STC_TB_Play:
		move.w	(EST_SoundTest).w,d0			; load list position
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		move.b	STC_List(pc,d0.w),d0			; load correct ID

STC_TB_PlaySFX:
	;	cmpi.b	#$A0,d0					; is it a music track from 80 to 9F?
	;	bhs.s	STC_TB_NoDelay				; if not, branch
	;	move.b	#$03,($FFFFA001).w			; set the "postpone" draw timer

STC_TB_NoDelay:
		jmp	Play_Sound.w				; play the sound

STC_TB_NoPlay:
		rts						; return

; ---------------------------------------------------------------------------
; Sound Test - list
; ---------------------------------------------------------------------------

STC_List:
levsel	macro	name
		dc.l (lvsnum<<$18)|STC_name
lvsnum :=	lvsnum+1
	endm

lvsnum :=	$01
	domusic	levsel

		dc.l							      ($33<<$18)|STC_33
		dc.l	($34<<$18)|STC_34,($35<<$18)|STC_35,($36<<$18)|STC_36,($37<<$18)|STC_37
		dc.l	($38<<$18)|STC_38,($39<<$18)|STC_39,($3A<<$18)|STC_3A,($3B<<$18)|STC_3B
		dc.l	($3C<<$18)|STC_3C,($3D<<$18)|STC_3D,($3E<<$18)|STC_3E,($3F<<$18)|STC_3F
		dc.l	($40<<$18)|STC_40,($41<<$18)|STC_41,($42<<$18)|STC_42,($43<<$18)|STC_43
		dc.l	($44<<$18)|STC_44,($45<<$18)|STC_45,($46<<$18)|STC_46,($47<<$18)|STC_47
		dc.l	($48<<$18)|STC_48,($49<<$18)|STC_49,($4A<<$18)|STC_4A,($4B<<$18)|STC_4B
		dc.l	($4C<<$18)|STC_4C,($4D<<$18)|STC_4D,($4E<<$18)|STC_4E,($4F<<$18)|STC_4F
		dc.l	($50<<$18)|STC_50,($51<<$18)|STC_51,($52<<$18)|STC_52,($53<<$18)|STC_53
		dc.l	($54<<$18)|STC_54,($55<<$18)|STC_55,($56<<$18)|STC_56,($57<<$18)|STC_57
		dc.l	($58<<$18)|STC_58,($59<<$18)|STC_59,($5A<<$18)|STC_5A,($5B<<$18)|STC_5B
		dc.l	($5C<<$18)|STC_5C,($5D<<$18)|STC_5D,($5E<<$18)|STC_5E,($5F<<$18)|STC_5F
		dc.l	($60<<$18)|STC_60,($61<<$18)|STC_61,($62<<$18)|STC_62,($63<<$18)|STC_63
		dc.l	($64<<$18)|STC_64,($65<<$18)|STC_65,($66<<$18)|STC_66,($67<<$18)|STC_67
		dc.l	($68<<$18)|STC_68,($69<<$18)|STC_69,($6A<<$18)|STC_6A,($6B<<$18)|STC_6B
		dc.l	($6C<<$18)|STC_6C,($6D<<$18)|STC_6D,($6E<<$18)|STC_6E,($6F<<$18)|STC_6F
		dc.l	($70<<$18)|STC_70,($71<<$18)|STC_71,($72<<$18)|STC_72,($73<<$18)|STC_73
		dc.l	($74<<$18)|STC_74,($75<<$18)|STC_75,($76<<$18)|STC_76,($77<<$18)|STC_77
		dc.l	($78<<$18)|STC_78,($79<<$18)|STC_79,($7A<<$18)|STC_7A,($7B<<$18)|STC_7B
		dc.l	($7C<<$18)|STC_7C,($7D<<$18)|STC_7D,($7E<<$18)|STC_7E,($7F<<$18)|STC_7F
		dc.l	($80<<$18)|STC_80,($81<<$18)|STC_81,($82<<$18)|STC_82,($83<<$18)|STC_83
		dc.l	($84<<$18)|STC_84,($85<<$18)|STC_85,($86<<$18)|STC_86,($87<<$18)|STC_87
		dc.l	($88<<$18)|STC_88,($89<<$18)|STC_89,($8A<<$18)|STC_8A,($8B<<$18)|STC_8B
		dc.l	($8C<<$18)|STC_8C,($8D<<$18)|STC_8D,($8E<<$18)|STC_8E,($8F<<$18)|STC_8F
		dc.l	($90<<$18)|STC_90,($91<<$18)|STC_91,($92<<$18)|STC_92,($93<<$18)|STC_93
		dc.l	($94<<$18)|STC_94,($95<<$18)|STC_95,($96<<$18)|STC_96,($97<<$18)|STC_97
		dc.l	($98<<$18)|STC_98,($99<<$18)|STC_99,($9A<<$18)|STC_9A,($9B<<$18)|STC_9B
		dc.l	($9C<<$18)|STC_9C,($9D<<$18)|STC_9D,($9E<<$18)|STC_9E,($9F<<$18)|STC_9F
		dc.l	($A0<<$18)|STC_A0,($A1<<$18)|STC_A1,($A2<<$18)|STC_A2,($A3<<$18)|STC_A3
		dc.l	($A4<<$18)|STC_A4,($A5<<$18)|STC_A5,($A6<<$18)|STC_A6,($A7<<$18)|STC_A7
		dc.l	($A8<<$18)|STC_A8,($A9<<$18)|STC_A9,($AA<<$18)|STC_AA,($AB<<$18)|STC_AB
		dc.l	($AC<<$18)|STC_AC,($AD<<$18)|STC_AD,($AE<<$18)|STC_AE,($AF<<$18)|STC_AF
		dc.l	($B0<<$18)|STC_B0,($B1<<$18)|STC_B1,($B2<<$18)|STC_B2,($B3<<$18)|STC_B3
		dc.l	($B4<<$18)|STC_B4,($B5<<$18)|STC_B5,($B6<<$18)|STC_B6,($B7<<$18)|STC_B7
		dc.l	($B8<<$18)|STC_B8,($B9<<$18)|STC_B9,($BA<<$18)|STC_BA,($BB<<$18)|STC_BB
		dc.l	($BC<<$18)|STC_BC,($BD<<$18)|STC_BD,($BE<<$18)|STC_BE,($BF<<$18)|STC_BF
		dc.l	($C0<<$18)|STC_C0,($C1<<$18)|STC_C1,($C2<<$18)|STC_C2,($C3<<$18)|STC_C3
		dc.l	($C4<<$18)|STC_C4,($C5<<$18)|STC_C5,($C6<<$18)|STC_C6,($C7<<$18)|STC_C7
		dc.l	($C8<<$18)|STC_C8,($C9<<$18)|STC_C9,($CA<<$18)|STC_CA,($CB<<$18)|STC_CB
		dc.l	($CC<<$18)|STC_CC,($CD<<$18)|STC_CD,($CE<<$18)|STC_CE,($CF<<$18)|STC_CF
		dc.l	($D0<<$18)|STC_D0,($D1<<$18)|STC_D1,($D2<<$18)|STC_D2,($D3<<$18)|STC_D3
		dc.l	($D4<<$18)|STC_D4,($D5<<$18)|STC_D5,($D6<<$18)|STC_D6,($D7<<$18)|STC_D7
		dc.l	($D8<<$18)|STC_D8,($D9<<$18)|STC_D9,($DA<<$18)|STC_DA,($DB<<$18)|STC_DB
STC_List_End:

STC_AIZ1:	dc.b	" ANGEL ISLAND ZONE - ACT 1         ",$00
STC_AIZ2:	dc.b	" ANGEL ISLAND ZONE - ACT 2         ",$00
STC_HCZ1:	dc.b	" HYDROCITY ZONE - ACT 1            ",$00
STC_HCZ2:	dc.b	" HYDROCITY ZONE - ACT 2            ",$00
STC_MGZ1:	dc.b	" MARBLE GARDEN ZONE - ACT 1        ",$00
STC_MGZ2:	dc.b	" MARBLE GARDEN ZONE - ACT 2        ",$00
STC_CNZ1:	dc.b	" CARNIVAL NIGHT ZONE - ACT 1       ",$00
STC_CNZ2:	dc.b	" CARNIVAL NIGHT ZONE - ACT 2       ",$00
STC_FBZ1:	dc.b	" FLYING BATTERY ZONE - ACT 1       ",$00
STC_FBZ2:	dc.b	" FLYING BATTERY ZONE - ACT 2       ",$00
STC_ICZ1:	dc.b	" ICE CAP ZONE - ACT 1              ",$00
STC_ICZ2:	dc.b	" ICE CAP ZONE - ACT 2              ",$00
STC_LBZ1:	dc.b	" LAUNCH BASE ZONE - ACT 1          ",$00
STC_LBZ2:	dc.b	" LAUNCH BASE ZONE - ACT 2          ",$00
STC_MHZ1:	dc.b	" MUSHROOM HILL ZONE - ACT 1        ",$00
STC_MHZ2:	dc.b	" MUSHROOM HILL ZONE - ACT 2        ",$00
STC_SOZ1:	dc.b	" SANDOPOLIS ZONE - ACT 1           ",$00
STC_SOZ2:	dc.b	" SANDOPOLIS ZONE - ACT 2           ",$00
STC_LRZ1:	dc.b	" LAVA REEF ZONE                    ",$00
STC_LRZ2:	dc.b	" HIDDEN PALACE ZONE                ",$00
STC_SSZ:	dc.b	" SKY SANCTUARY ZONE                ",$00
STC_DEZ1:	dc.b	" DEATH EGG ZONE - ACT 1            ",$00
STC_DEZ2:	dc.b	" DEATH EGG ZONE - ACT 2            ",$00
STC_OAZ1:	dc.b	" IM A DEVIL                        ",$00
STC_MiniAIZ:	dc.b	" MINIGAME - ANGEL ISLAND ZONE 2    ",$00
STC_MiniCNZ:	dc.b	" MINIGAME - CARNIVAL NIGHT ZONE 1  ",$00
STC_MiniLBZ:	dc.b	" MINIGAME - LAUNCH BASE ZONE 1     ",$00
STC_MiniSSZ:	dc.b	" MINIGAME - SKY SANCTUARY ZONE     ",$00
STC_MiniDEZ2:	dc.b	" MINIGAME - DEATH EGG ZONE 2       ",$00
STC_SpecialStage:dc.b	" MINIGAME - SPECIAL STAGE          ",$00
STC_Minib_S3:	dc.b	" BOSS ACT 1 - SONIC 3              ",$00
STC_Minib_SK:	dc.b	" BOSS ACT 1 - SONIC AND KNUCKLES   ",$00
STC_Boss:	dc.b	" BOSS ACT 2                        ",$00
STC_FinalBoss:	dc.b	" FINAL BOSS                        ",$00
STC_KnuxS3:	dc.b	" KNUCKLES - SONIC 3                ",$00
STC_Knux:	dc.b	" KNUCKLES - SONIC AND KNUCKLES     ",$00
STC_InvicS3:	dc.b	" INVINCIBLE - SONIC 3              ",$00
STC_Invic:	dc.b	" INVINCIBLE - SONIC AND KNUCKLES   ",$00
STC_ResultsSonic:dc.b	" STAGE COMPLETE - SONIC VERSION    ",$00
STC_ResultsTie:	dc.b	" STAGE COMPLETE - TIED VERSION     ",$00
STC_ResultsTails:dc.b	" STAGE COMPLETE - TAILS VERSION    ",$00
STC_Drown:	dc.b	" DROWNING THEME                    ",$00
STC_MainMenu:	dc.b	" MAIN MENU THEME                   ",$00
STC_Options:	dc.b	" MINI GAME MENU                    ",$00
STC_DataSelect:	dc.b	" BATTLE RACE MENU                  ",$00
STC_Continue:	dc.b	" NO WAY   NO WAY   NO WAY   NO WAY ",$00
STC_Credits:	dc.b	" CREDITS THEME                     ",$00
STC_Null:	dc.b	"                                   ",$00
STC_TitleScreen:dc.b	" TITLE SCREEN - BATTLE RACE        ",$00
STC_SpecialSelect:dc.b	" SPECIAL STAGE LEVEL SELECT        ",$00

STC_33:		dc.b	" 33 RING COLLECT                   ",$00
STC_34:		dc.b	" 34 RING COLLECT - LEFT SPEAKER    ",$00
STC_35:		dc.b	" 35 GETTING HURT                   ",$00
STC_36:		dc.b	" 36 SKIDDING                       ",$00
STC_37:		dc.b	" 37 HURT BY SPIKES                 ",$00
STC_38:		dc.b	" 38 AIR BUBBLE                     ",$00
STC_39:		dc.b	" 39 WATER SPLASH                   ",$00
STC_3A:		dc.b	" 3A UNUSED SHIELD SOUND            ",$00
STC_3B:		dc.b	" 3B DROWNING                       ",$00
STC_3C:		dc.b	" 3C SPIN ATTACK                    ",$00
STC_3D:		dc.b	" 3D DESTROYING BADNIK OR MONITOR   ",$00
STC_3E:		dc.b	" 3E GET FIRE SHIELD                ",$00
STC_3F:		dc.b	" 3F GET BUBBLE SHIELD              ",$00
STC_40:		dc.b	" 40 UNKNOWN UNUSED                 ",$00
STC_41:		dc.b	" 41 GET ELECTRIC SHIELD            ",$00
STC_42:		dc.b	" 42 USE INSTA-SHIELD               ",$00
STC_43:		dc.b	" 43 USE FIRE SHIELD - JUMP DASH    ",$00
STC_44:		dc.b	" 44 USE BUBBLE SHIELD - BOUNCE     ",$00
STC_45:		dc.b	" 45 USE ELECTRIC SHIELD - JUMP X2  ",$00
STC_46:		dc.b	" 46 DOOMSDAY SUPER TRANSFORMATION  ",$00
STC_47:		dc.b	" 47 SANDOPOLIS SANDWALL DESTROYED  ",$00
STC_48:		dc.b	" 48 AIZ RHINO - LRZ SPIKE PLATFORM ",$00
STC_49:		dc.b	" 49 VARIOUS THUMP SOUNDS           ",$00
STC_4A:		dc.b	" 4A VARIOUS GRABBING SOUNDS        ",$00
STC_4B:		dc.b	" 4B AIZ VANISHING PLATFORM - BOSS  ",$00
STC_4C:		dc.b	" 4C VARIOUS BRIDGE SOUNDS          ",$00
STC_4D:		dc.b	" 4D VARIOUS PROJECTILE SHOOT SOUNDS",$00
STC_4E:		dc.b	" 4E MISSILE EXPLOSION              ",$00
STC_4F:		dc.b	" 4F AIZ MINIBOSS FLAMES            ",$00
STC_50:		dc.b	" 50 LBZ MINIBOSS DOORS OPENING     ",$00
STC_51:		dc.b	" 51 VARIOUS MISSILE THROW SOUNDS   ",$00
STC_52:		dc.b	" 52 SPIKES AND SPRINGS MOVING      ",$00
STC_53:		dc.b	" 53 CHARGING UP - TELEPORTER SOUNDS",$00
STC_54:		dc.b	" 54 SHOOTING BEAM                  ",$00
STC_55:		dc.b	" 55 SANDOPOLIS ROCK ON TRACK       ",$00
STC_56:		dc.b	" 56 AIZ DRAW BRIDGE                ",$00
STC_57:		dc.b	" 57 WATER EXPLOSION AND RUSHING    ",$00
STC_58:		dc.b	" 58 HYDROCITY DOORS AND FANS       ",$00
STC_59:		dc.b	" 59 COLLAPSING PLATFORMS           ",$00
STC_5A:		dc.b	" 5A UNKNOWN UNUSED                 ",$00
STC_5B:		dc.b	" 5B VARIOUS BUTTON PRESS SOUNDS    ",$00
STC_5C:		dc.b	" 5C METAL SONIC SPARKING           ",$00
STC_5D:		dc.b	" 5D KNUCKLES HURT - FLOOR THUMP    ",$00
STC_5E:		dc.b	" 5E LASER SOUNDS                   ",$00
STC_5F:		dc.b	" 5F CRASHING SOUNDS                ",$00
STC_60:		dc.b	" 60 EGGMANS SHIP - DISTANT ZOOM    ",$00
STC_61:		dc.b	" 61 BOSS HITTING FLOOR             ",$00
STC_62:		dc.b	" 62 JUMPING                        ",$00
STC_63:		dc.b	" 63 CHECKPOINT HIT                 ",$00
STC_64:		dc.b	" 64 UNKNOWN MHZ PULLEY             ",$00
STC_65:		dc.b	" 65 BLUE SPHERE COLLECT            ",$00
STC_66:		dc.b	" 66 COLLECTED ALL BLUE SPHERES     ",$00
STC_67:		dc.b	" 67 ROCKET SOUNDS - MGZ HEAD ARROWS",$00
STC_68:		dc.b	" 68 PERFECT - GOT SPECIAL ITEM     ",$00
STC_69:		dc.b	" 69 PUSHABLE ITEM SOUNDS           ",$00
STC_6A:		dc.b	" 6A UNUSED SPECIAL STAGE EXIT SOUND",$00
STC_6B:		dc.b	" 6B UNUSED R BLOCK SOUND           ",$00
STC_6C:		dc.b	" 6C SOZ SANDWORM - SAME AS SOUND 39",$00
STC_6D:		dc.b	" 6D UNKNOWN UNUSED                 ",$00
STC_6E:		dc.b	" 6E BOSS AND OTHER HIT SOUNDS      ",$00
STC_6F:		dc.b	" 6F RUMBLING SOUNDS                ",$00
STC_70:		dc.b	" 70 HCZ MINIBOSS LAUNCH            ",$00
STC_71:		dc.b	" 71 UNUSED SHIELD - SAME AS SFX 3A ",$00
STC_72:		dc.b	" 72 LBZ CUP ELEVATOR - CNZ FANS    ",$00
STC_73:		dc.b	" 73 TELEPOERTERS - CNZ HOVER UNITS ",$00
STC_74:		dc.b	" 74 VARIOUS DEFLECT SOUNDS         ",$00
STC_75:		dc.b	" 75 CARNIVAL NIGHT BALLOON PLATFORM",$00
STC_76:		dc.b	" 76 CARNIVAL NIGHT TRAP DOOR       ",$00
STC_77:		dc.b	" 77 CNZ AND MTZ BOSS BALLOON SOUNDS",$00
STC_78:		dc.b	" 78 ELECTROCUTING KNUCKLES SOUND   ",$00
STC_79:		dc.b	" 79 LIGHTNING SOUNDS               ",$00
STC_7A:		dc.b	" 7A LRZ BOSS APPEARS               ",$00
STC_7B:		dc.b	" 7B VARIOUS BUMPER SOUNDS          ",$00
STC_7C:		dc.b	" 7C FBZ MAGNETIC PLATFORM          ",$00
STC_7D:		dc.b	" 7D UNKNOWN UNUSED                 ",$00
STC_7E:		dc.b	" 7E KNUCKLES SLIDE - MHZ SWING WINE",$00
STC_7F:		dc.b	" 7F ICZ FREEZE SOUNDS              ",$00
STC_80:		dc.b	" 80 ICZ SMALL ICE SPIKES DESTROYED ",$00
STC_81:		dc.b	" 81 LBZ TUBE LAUNCHER - PLUS OTHERS",$00
STC_82:		dc.b	" 82 SOZ SANDWALL - AND LEVEL INTROS",$00
STC_83:		dc.b	" 83 BRIDGE COLLAPSE                ",$00
STC_84:		dc.b	" 84 UNKNOWN UNUSED                 ",$00
STC_85:		dc.b	" 85 UNKNOWN UNUSED                 ",$00
STC_86:		dc.b	" 86 LAUNCH BASE ALARM              ",$00
STC_87:		dc.b	" 87 MUSHROOM HILL MUSHROOM SOUNDS  ",$00
STC_88:		dc.b	" 88 MUSHROOM HILL PULLEY LIFT      ",$00
STC_89:		dc.b	" 89 MUSHROOM HILL WEATHER MACHINE  ",$00
STC_8A:		dc.b	" 8A GHOSTS - SSZ CLOUD - DEZ ENEMY ",$00
STC_8B:		dc.b	" 8B MUSHROOM HILL BOSS CHOPS TREE  ",$00
STC_8C:		dc.b	" 8C MUSHROOM HILL BOSS STUCK       ",$00
STC_8D:		dc.b	" 8D UNKNOWN UNUSED                 ",$00
STC_8E:		dc.b	" 8E UNKNOWN UNUSED                 ",$00
STC_8F:		dc.b	" 8F VARIOUS DOOR OPENING SOUNDS    ",$00
STC_90:		dc.b	" 90 SOZ DOOR LEVER - HPZ BOSS BEAT ",$00
STC_91:		dc.b	" 91 SOZ DOOR CLOSE - HCZ BOSS STOPS",$00
STC_92:		dc.b	" 92 SANDOPOLIS GHOST APPEARS       ",$00
STC_93:		dc.b	" 93 SANDOPOLIS BOSS MACHINE RESPAWN",$00
STC_94:		dc.b	" 94 LRZ CHAIN PLATFORMS            ",$00
STC_95:		dc.b	" 95 LRZ BOSS HAND APPEARS          ",$00
STC_96:		dc.b	" 96 SSZ METAL SONIC LANDS ON FLOOR ",$00
STC_97:		dc.b	" 97 LRZ TOXOMISTER - MHZ CHICKEN   ",$00
STC_98:		dc.b	" 98 VARIOUS LRZ SOUNDS             ",$00
STC_99:		dc.b	" 99 UNKNOWN UNUSED                 ",$00
STC_9A:		dc.b	" 9A RETRACTING SPRINGS             ",$00
STC_9B:		dc.b	" 9B VARIOUS BOSSES THUMPING        ",$00
STC_9C:		dc.b	" 9C SUPER EMERALD - LRZ3 BOSS FLASH",$00
STC_9D:		dc.b	" 9D LRZ3 BOSS MISSILES LANDING     ",$00
STC_9E:		dc.b	" 9E FBZ MAGNETIC PENDULUM          ",$00
STC_9F:		dc.b	" 9F SUPER TRANSFORMATION           ",$00
STC_A0:		dc.b	" A0 LRZ3 BOSS MISSILES BEING SHOT  ",$00
STC_A1:		dc.b	" A1 UNKNOWN UNUSED                 ",$00
STC_A2:		dc.b	" A2 PLAYER LAUNCHER                ",$00
STC_A3:		dc.b	" A3 DEZ LIFT GOING UP              ",$00
STC_A4:		dc.b	" A4 METALSONIC SUPER TRANSFORMATION",$00
STC_A5:		dc.b	" A5 UNKNOWN UNUSED                 ",$00
STC_A6:		dc.b	" A6 DEZ TUNNEL LAUNCHER            ",$00
STC_A7:		dc.b	" A7 DEATH EGG BEEP READY           ",$00
STC_A8:		dc.b	" A8 LBZ LAZER - DEZ ENERGY BRIDGE  ",$00
STC_A9:		dc.b	" A9 DROWN WARNING TIMER            ",$00
STC_AA:		dc.b	" AA BUMPER HIT                     ",$00
STC_AB:		dc.b	" AB SUPER SPIN DASH CHARGE         ",$00
STC_AC:		dc.b	" AC COLLECTED CONTINUE             ",$00
STC_AD:		dc.b	" AD DEATH EGG BEEP GO              ",$00
STC_AE:		dc.b	" AE FLIPPERS AND MUSHROOM CATAPULTS",$00
STC_AF:		dc.b	" AF ENTER AND EXIT SPECIAL STAGE   ",$00
STC_B0:		dc.b	" B0 SCORE COUNTDOWN FINISHED       ",$00
STC_B1:		dc.b	" B1 SPRING BOUNCE                  ",$00
STC_B2:		dc.b	" B2 INVALID SELECTION              ",$00
STC_B3:		dc.b	" B3 ENTERING LARGE RING            ",$00
STC_B4:		dc.b	" B4 VARIOUS EXPLOSION SOUNDS       ",$00
STC_B5:		dc.b	" B5 UNUSED CRYSTAL BLOCK SOUND     ",$00
STC_B6:		dc.b	" B6 SUPER SPIN DASH RELEASE        ",$00
STC_B7:		dc.b	" B7 SLOT MACHINE CYCLE             ",$00
STC_B8:		dc.b	" B8 SIGNPOST - SUPER EMERALD APPEAR",$00
STC_B9:		dc.b	" B9 RING LOSS                      ",$00
STC_BA:		dc.b	" BA TAILS FLYING                   ",$00
STC_BB:		dc.b	" BB TAILS FLYING TIRED             ",$00
STC_BC:		dc.b	" BC UNKNOWN UNUSED                 ",$00
STC_BD:		dc.b	" BD LARGE SHIPS                    ",$00
STC_BE:		dc.b	" BE EGGMAN SHIP SIREN              ",$00
STC_BF:		dc.b	" BF HCZ BOSS CYCLE SPIN - ICZ BOSS ",$00
STC_C0:		dc.b	" C0 HCZ FANS - BOSS - DEZ STAIRCASE",$00
STC_C1:		dc.b	" C1 HYDROCITY SMALL FANS           ",$00
STC_C2:		dc.b	" C2 FLAME THROWERS                 ",$00
STC_C3:		dc.b	" C3 DEATH EGG GRAVITY TUNNELS      ",$00
STC_C4:		dc.b	" C4 DEATH EGG BOSS ROTATE PLATFORMS",$00
STC_C5:		dc.b	" C5 UNKNOWN UNUSED                 ",$00
STC_C6:		dc.b	" C6 CNZ VERTICALHELIX RIDE         ",$00
STC_C7:		dc.b	" C7 CARNIVAL NIGHT CANNON          ",$00
STC_C8:		dc.b	" C8 WATER AND SAND AND SNOW SOUNDS ",$00
STC_C9:		dc.b	" C9 MGZ SWINGING SPIKEBALLS        ",$00
STC_CA:		dc.b	" CA DEATH EGG LIGHT TUNNEL         ",$00
STC_CB:		dc.b	" CB LEVEL CONSTANT RUMBLING        ",$00
STC_CC:		dc.b	" CC OTHER RUMBLING SOUNDS          ",$00
STC_CD:		dc.b	" CD DEATH EGG LAUNCHING SOUNDS     ",$00
STC_CE:		dc.b	" CE QUIET WIND BLOWINGS SOUNDS     ",$00
STC_CF:		dc.b	" CF LOUD WIND BLOWINGS SOUNDS      ",$00
STC_D0:		dc.b	" D0 DEZ HANG CARRIER - BOSS SOUNDS ",$00
STC_D1:		dc.b	" D1 UNKNOWN UNUSED                 ",$00
STC_D2:		dc.b	" D2 GUMBALL BONUS STAGE TAB TURNING",$00
STC_D3:		dc.b	" D3 SSZ CUTSCENE DEATH EGG RISING  ",$00
STC_D4:		dc.b	" D4 DEZ LARGE PROPELLERS           ",$00
STC_D5:		dc.b	" D5 LRZ LAVAFALL                   ",$00
STC_D6:		dc.b	" D6 UNKNOWN UNUSED                 ",$00
STC_D7:		dc.b	" D7 LRZ SPIN DASH LIFT - DEZ BELT  ",$00
STC_D8:		dc.b	" D8 UNKNOWN UNUSED                 ",$00
STC_D9:		dc.b	" D9 FBZ AND DEZ GRAVITY-HOVER SPIKE",$00
STC_DA:		dc.b	" DA MHZ KNUCKLES LEAFBLOWER        ",$00
STC_DB:		dc.b	" DB HCZ WATER SPLASH               ",$00
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Controls for bottom bar
; ---------------------------------------------------------------------------

STC_BottomBar:
		bsr.w	STC_MoveHighlight			; move the highlight bar
		move.b	(Ctrl_1_pressed).w,d5			; load pressed buttons
		or.b	(Ctrl_2_pressed).w,d5			; fuse player 2 pressed buttons
		btst.l	#$00,d5					; was up pressed?
		beq.s	STC_BB_NoUp				; if not, branch
		andi.w	#%1111110011111100,(Ctrl_1_held).w	; clear up/down buttons
		andi.w	#%1111110011111100,(Ctrl_2_held).w	; clear up/down buttons
		move.l	#STC_TopBar,($FFFFA004).w		; set next routine
		jmp	STC_TopBar				; run the routine

STC_BB_NoUp:
		andi.b	#%00001100,d5				; get only left/right
		beq.s	STC_BB_NoRight				; if neither were pressed, branch
		lsr.b	#$03,d5					; shift left into carry
		bcc.s	STC_BB_NoLeft				; if left was not pressed, branch
		subq.w	#$01,($FFFFA030).w			; decrease bottom menu X position
		bcc.s	STC_BB_NoLeft				; if it hasn't gone below the bottom, branch
		move.w	#((STC_Opt_End-STC_Opt)/$08)-1,($FFFFA030).w ; set to end of list

STC_BB_NoLeft:
		lsr.b	#$01,d5					; shift right into carry
		bcc.s	STC_BB_NoRight				; if right was not pressed, branch
		addq.w	#$01,($FFFFA030).w			; increase bottom menu X position
		cmpi.w	#((STC_Opt_End-STC_Opt)/$08),($FFFFA030).w ; has it reached the end of the list?
		blo.s	STC_BB_NoRight				; if not, branch
		clr.w	($FFFFA030).w				; set to beginning of list

STC_BB_NoRight:
		move.b	(Ctrl_1_pressed).w,d5			; load pressed buttons
		or.b	(Ctrl_2_pressed).w,d5			; fuse player 2's buttons
	bmi.w	STC_TB_Play				; if start was pressed, branch
	;	btst.l	#$05,d5					; was C pressed?
	;	bne.w	STC_TB_Play				; if so, branch
		andi.b	#%01100000,d5				; get A or C
		beq.s	STC_BB_NoPress				; if nothing was pressed, branch
		move.b	#$20,($FFFFA100).w			; reset hold timer
		bra.s	STC_BB_YesPlay				; continue into playing routine

STC_BB_NoPress:
		move.b	(Ctrl_1_held).w,d5			; reload pressed buttons
		or.b	(Ctrl_2_held).w,d5			; fuse with player 2's held buttons
		andi.b	#%01100000,d5				; get A or C
		beq.s	STC_BB_NoPlay				; if nothing was pressed, branch
		subq.b	#$01,($FFFFA100).w			; decrease timer
		bpl.s	STC_BB_NoPlay				; if timer is still running, branch
		sf.b	($FFFFA100).w				; keep timer at 00

		subq.b	#$01,($FFFFA101).w			; decrease speed
		bpl.s	STC_BB_NoPlay				; if still delay timer is still running, branch
		move.b	#$01,($FFFFA101).w			; reset delay timer

STC_BB_YesPlay:
		move.w	#$FFFF,($FFFFA034).w			; invalidate the "options" text area (so it renders the changing numbers)
		move.w	($FFFFA030).w,d0			; load list position
		lsl.w	#$03,d0					; multiply by size of 2 long-words
		movea.l	STC_Opt+$04(pc,d0.w),a0			; load correct address
		jmp	(a0)					; run address

STC_BB_NoPlay:
		rts						; return

; ---------------------------------------------------------------------------
; Sound Test - options
; ---------------------------------------------------------------------------

STC_Opt:	dc.l	STC_ST_Fade,	STC_Fade
		dc.l	STC_ST_Tempo,	STC_Tempo
	;	dc.l	STC_ST_Pitch,	STC_Pitch
	;	dc.l	STC_ST_Volume,	STC_Volume
	;	dc.l	STC_ST_FM1,	STC_FM1
	;	dc.l	STC_ST_FM2,	STC_FM2
	;	dc.l	STC_ST_FM3,	STC_FM3
	;	dc.l	STC_ST_FM4,	STC_FM4
	;	dc.l	STC_ST_FM5,	STC_FM5
	;	dc.l	STC_ST_FM6,	STC_FM6
	;	dc.l	STC_ST_PCM1,	STC_PCM1
	;	dc.l	STC_ST_PCM2,	STC_PCM2
	;	dc.l	STC_ST_PSG1,	STC_PSG1
	;	dc.l	STC_ST_PSG2,	STC_PSG2
	;	dc.l	STC_ST_PSG3,	STC_PSG3
STC_Opt_End:

STC_ST_Fade:	dc.b	" a OR c   <  FADE OUT  >   a OR c ",$00
STC_ST_Tempo:	dc.b	" a DOWN    <  TEMPO  #1 >      UP c ",$00
STC_ST_Pitch:	dc.b	" a DOWN    <  PITCH  #0 >      UP c ",$00
STC_ST_Volume:	dc.b	" a LOUD    <  VOLUME #2 >   QUIET c ",$00
STC_ST_FM1:	dc.b	" a OR c   < FM  1 MUTE >   a OR c ",$00
STC_ST_FM2:	dc.b	" a OR c   < FM  2 MUTE >   a OR c ",$00
STC_ST_FM3:	dc.b	" a OR c   < FM  3 MUTE >   a OR c ",$00
STC_ST_FM4:	dc.b	" a OR c   < FM  4 MUTE >   a OR c ",$00
STC_ST_FM5:	dc.b	" a OR c   < FM  5 MUTE >   a OR c ",$00
STC_ST_FM6:	dc.b	" a OR c   < FM  6 MUTE >   a OR c ",$00
STC_ST_PCM1:	dc.b	" a OR c   < PCM 1 MUTE >   a OR c ",$00
STC_ST_PCM2:	dc.b	" a OR c   < PCM 2 MUTE >   a OR c ",$00
STC_ST_PSG1:	dc.b	" a OR c   < PSG 1 MUTE >   a OR c ",$00
STC_ST_PSG2:	dc.b	" a OR c   < PSG 2 MUTE >   a OR c ",$00
STC_ST_PSG3:	dc.b	" a OR c   < PSG 3 MUTE >   a OR c ",$00
		even

	; --- Pitch control ---

STC_Pitch:
		add.b	d5,d5					; shift button A to MSB
		bpl.s	STC_P_NoA				; if it was not A, branch for B
		subq.b	#$02,(EST_MusicRAM+$14).w		; decrease the music pitch

STC_P_NoA:
		addq.b	#$01,(EST_MusicRAM+$14).w		; increase the music pitch

STC_UpdateChannels:
		lea	(EST_ChannelRAM).w,a1			; load channel RAM
		moveq	#(2+6+3)-1,d7				; set number of channels to do
		moveq	#$30,d0					; prepare channel advance amount

STC_P_Next:
		bset.b	#$06,(a1)				; set channel to update
		adda.w	d0,a1					; advance to next channel
		dbf	d7,STC_P_Next				; repeat for all channels
		rts						; return

	; --- Tempo control ---

STC_Tempo:
		add.b	d5,d5					; shift button A to MSB
		bpl.s	STC_T_NoA				; if it was not A, branch for B
		cmpi.b	#$80,(EST_Tempo).w			; is the music tempo at lowest?
		beq.s	STC_T_NoChange				; if not, branch
		subq.b	#$01,(EST_Tempo).w			; decrease the music tempo

STC_T_NoChange:
		rts						; return

STC_T_NoA:
		cmpi.b	#$7F,(EST_Tempo).w			; is the music tempo at highest?
		beq.s	STC_T_NoChange				; if so, branch
		addq.b	#$01,(EST_Tempo).w			; increase the music tempo
		rts						; return

	; --- Volume control ---

STC_Volume:
		add.b	d5,d5					; shift button A to MSB
		bpl.s	STC_V_NoA				; if it was not A, branch for B
		subq.b	#$01,(EST_MusicRAM+$16).w		; decrease the music volume
		bpl.s	STC_UpdateChannels			; if still valid, branch
		sf.b	(EST_MusicRAM+$16).w			; keep volume at 00
		bra.s	STC_UpdateChannels			; continue and trigger channels to update

STC_V_NoA:
		addq.b	#$01,(EST_MusicRAM+$16).w		; increase the music volume
		cmpi.b	#$28,(EST_MusicRAM+$16).W		; is it at maximum volume?
		bls.s	STC_UpdateChannels			; if not, branch
		move.b	#$28,(EST_MusicRAM+$16).W		; force to maximum volume
		bra.s	STC_UpdateChannels			; continue and trigger channels to update

	; --- Fade out ---

STC_Fade:
		moveq	#-$1F,d0
		jmp	Play_Sound_2.w

	; --- Channel control ---

STC_FM1:
		not.b	(EST_FM1+$21).w
		rts

STC_FM2:
		not.b	(EST_FM2+$21).w
		rts

STC_FM3:
		not.b	(EST_FM3+$21).w
		rts

STC_FM4:
		not.b	(EST_FM4+$21).w
		rts

STC_FM5:
		not.b	(EST_FM5+$21).w
		rts

STC_FM6:
		not.b	(EST_FM6+$21).w
		rts

STC_PCM1:
		not.b	(EST_PCM1+$21).w
		rts

STC_PCM2:
		not.b	(EST_PCM2+$21).w
		rts

STC_PSG1:
		not.b	(EST_PSG1+$21).w
		rts

STC_PSG2:
		not.b	(EST_PSG2+$21).w
		rts

STC_PSG3:
		not.b	(EST_PSG3+$21).w
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to move the highlighter to the correct position
; ---------------------------------------------------------------------------

STC_MoveHighlight:
		lea	($FFFFA014).w,a1			; load highlighters
		cmpi.l	#STC_TopBar,($FFFFA004).w		; is the routine set to bottom bar?
		bne.s	STC_MH_MoveDown				; if not, branch
		tst.b	$0A(a1)					; has the top bar's size been reduced to 0?
		beq.s	STC_MH_Finish				; if so, branch
		subq.b	#$01,$0A(a1)				; decrease size
		addi.w	#$0080,$08(a1)				; increase position
		addq.b	#$01,$02(a1)				; increase size
		subi.w	#$0080,(a1)				; decrease position

STC_MH_Finish:
		rts						; return

STC_MH_MoveDown:
		tst.b	$02(a1)					; has the top bar's size been reduced to 0?
		beq.s	STC_MH_Finish				; if so, branch
		subq.b	#$01,$02(a1)				; decrease size
		addi.w	#$0080,(a1)				; increase position
		addq.b	#$01,$0A(a1)				; increase size
		subi.w	#$0080,$08(a1)				; decrease position
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to create all possible colour fading values for all channels and types
; ---------------------------------------------------------------------------

ST_SetupKeyColours:
		lea	(ST_ColourList).l,a0			; load colours list
		lea	($FFFF5800).l,a3			; load palette RAM data

		moveq	#$06-1,d7				; number of key colours (2 FM, 2 PCM, 2 PSG (one for BGM, one for SFX))

STSKC_NextKey:
		move.l	d7,-(sp)				; store counter
		moveq	#$02-1,d6				; set to do twice (once for white, once for black)
		lea	(ST_ColourBlank).l,a1			; load blank colours list to fade to

STSKC_NextBlack:
		move.l	d6,-(sp)				; store counter

		; normal
		lea	(a3),a2					; load first colour address
		bsr.s	STSKC_CreateColour			; create white variations
		addq.w	#$02,a3					; advance for next colour
		lea	(a3),a2					; load second colour address
		bsr.s	STSKC_CreateColour			; create white variations
		lea	$1E(a3),a3				; advance for next colour

		; attack
		subq.w	#$04,a1					; go back and redo colours but for attack keys
		lea	(a3),a2					; load first colour address
		bsr.s	STSKC_CreateColour			; create white variations
		addq.w	#$02,a3					; advance for next colour
		lea	(a3),a2					; load second colour address
		bsr.s	STSKC_CreateColour			; create white variations
		lea	$1E(a3),a3				; advance for next colour

		subq.w	#$08,a0					; go back and redo colour but for black keys

		move.l	(sp)+,d6				; reload counter
		dbf	d6,STSKC_NextBlack			; repeat for black keys
		addq.w	#$08,a0					; continue to next colours

		move.l	(sp)+,d7				; restore counter
		dbf	d7,STSKC_NextKey			; repeat for all keys
		rts						; return

STSKC_CreateColour:
		clr.w	(a2)					; clear multiplication area
		move.w	(a0)+,d0				; load colour source
		move.w	(a1)+,d1				; load colour destination

	; --- Blue fraction ---

		move.w	d0,d2					; load blue
		sf.b	d2					; ''
		move.w	d1,d3					; load destination
		sf.b	d3					; ''
		sub.w	d2,d3					; get distance
		ext.l	d3					; extend to long-word
		divs.w	#$07,d3					; divide by 7 colours

	; --- Green fraction ---

		move.b	d0,d2					; load green
		andi.l	#$000000E0,d2				; ''
		move.b	d2,(a2)					; multiply by 100
		move.w	(a2),d2					; ''
		move.b	d1,d4					; load distance
		andi.l	#$000000E0,d4				; ''
		move.b	d4,(a2)					; multiply by 100
		move.w	(a2),d4					; ''
		sub.l	d2,d4					; get distance
		divs.w	#$07,d4					; divide by 7 colours
		ext.l	d4					; clear remainder
		asl.l	#$08,d4					; align into position

	; --- Red fraction ---

		move.b	d0,d2					; load red
		andi.l	#$0000000E,d2				; ''
		move.b	d2,(a2)					; multiply by 100
		move.w	(a2),d2					; ''
		move.b	d1,d5					; load distance
		andi.l	#$0000000E,d5				; ''
		move.b	d5,(a2)					; multiply by 100
		move.w	(a2),d5					; ''
		sub.l	d2,d5					; get distance
		divs.w	#$07,d5					; divide by 7 colours
		ext.l	d5					; clear remainder
		asl.l	#$08,d5					; align into position

	; --- creating starting colours ---

		move.w	d0,d2					; get red
		andi.l	#$0000000E,d2				; ''
		swap	d2					; align to quotient
		move.w	d0,d1					; get green
		andi.l	#$000000E0,d1				; ''
		swap	d1					; align to quotient
		andi.w	#$0E00,d0				; get blue

		moveq	#$08-1,d7				; set number of colours to do
		bra.s	STSKC_StartColour			; branch into loop

STSKC_NextColour:
		add.w	d3,d0					; advance blue
		add.l	d4,d1					; advance green
		add.l	d5,d2					; advance red

STSKC_StartColour:
		swap	d1					; get quotients
		swap	d2					; ''
		move.w	d0,d6					; get blue
		andi.w	#$0F00,d6				; ''
		or.b	d1,d6					; get green
		andi.w	#$0FF0,d6				; ''
		or.b	d2,d6					; get red
		andi.w	#$0FFF,d6				; ''
		move.w	d6,(a2)					; save colour
		andi.w	#$0111,d6				; get half fractions
		add.w	(a2),d6					; add to colour
		andi.w	#$0EEE,d6				; get only the colour
		move.w	d6,(a2)+				; save to palette correctly
		addq.w	#$02,a2					; skip slot
		swap	d1					; restore quotients
		swap	d2					; ''
		dbf	d7,STSKC_NextColour			; repeat for all 8 colours

		rts						; return

		;	Light, Dark

ST_ColourBlank:	dc.w	$0EEA,$0886				; white keys
		dc.w	$0EEA,$0000				; black keys

		;	  Normal	Attack

ST_ColourList:	dc.w	$000E,$0008, $00AE,$0068		; FM BGM
		dc.w	$0E48,$0844, $0E4C,$0846		; FM SFX
		dc.w	$0E08,$0804, $0E0E,$0808		; PCM BGM
		dc.w	$0000,$0000, $0000,$0000		; PCM SFX
		dc.w	$00A0,$0060, $08C0,$0680		; PSG BGM
		dc.w	$008E,$0048, $00CC,$008C		; PSG SFX

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw the key sprites on the piano
; ---------------------------------------------------------------------------

ST_DrawKeys:
		lea	(ST_BGMRAM).l,a4			; load channel RAM list
		lea	(Sprite_table_buffer).w,a1		; load sprite RAM
		moveq	#$00,d7					; clear key counter
		tst.b	($FFFFA001).w				; is render being delayed?
		bne.w	STDK_FinishKeys				; if so, branch
		moveq	#$00,d5					; reset keyboard ID
		moveq	#$00,d6					; reset sprite count

STDK_NextKey:
		moveq	#$00,d4					; set to use BGM colours
		movea.w	(a4),a2					; load channel
		btst.b	#$02,(a2)				; is the channel being interrupted by SFX?
		bne.s	STDK_CheckSPE				; if so, branch
  bra.s	STDK_NoSPE	; Z80 Specific - Just skip....
	tst.b	$21(a2)					; is the channel muted?
	beq.s	STDK_NoSPE				; if not, branch
	tst.b	(a2)
	bpl.s	STDK_NoSPE
	move.w	d5,d1					; adjust Y position
	lsl.w	#$04,d1					; ''
	addi.w	#$0088,d1				; ''
	move.w	d1,(a1)+				; Y position
	move.b	#$09,(a1)+				; shape
	addq.b	#$01,d6					; sprite link
	move.b	d6,(a1)+				; ''
	move.w	#($AC00/$20),(a1)+			; VRAM
	move.w	#$0088,(a1)+				; X pos
		bra.w	STDK_NoChannel				; continue

STDK_CheckSPE:
		addi.w	#$0080,d4				; advance to SFX colours

STDK_CheckSFX:
		move.w	ST_SFXRAM-ST_BGMRAM(a4),d0		; load SFX channel
		beq.w	STDK_NoChannel				; if there is no SFX channel, branch
		movea.w	d0,a2					; set address

STDK_NoSPE:

	; --- Reading channel ---

		move.b	(a2),d0					; load channel status
		bpl.s	STDK_NoChannel				; if the channel is not running, branch
		btst	#$04,d0		; $01 to $04		; is the channel resting?
		bne.s	STDK_NoChannel				; if so, branch
		btst	#$01,d0		; $04 to $01		; is soft key on?
		bne.s	STDK_NoHitKey				; if so, branch
		move.b	$0F(a2),d0				; load main timer
		sub.b	$0E(a2),d0				; minus current timer
		cmpi.b	#$03,d0					; has the key been hit recently?
		bgt.s	STDK_NoHitKey				; if not, branch
		addi.w	#$0020,d4				; advance to key hit colours

STDK_NoHitKey:
		move.w	d7,d0					; load channel counter
		lsl.w	#$03,d0					; multiply by size of two long-words
		lea	(STDK_ChanRouts).l,a0			; load routine/palette list
		adda.w	d0,a0					; load correct routine list
		move.l	(a0)+,a3				; load palette RAM to edit
		move.l	(a0)+,a0				; load routine
		jsr	(a0)					; run routine
		beq.s	STDK_NoChannel				; if there's no frequency to read, branch
;	btst.b	#$01,$23(a2)				; S3K Specific - is the octave meant to display down by 1?
;	beq.s	STDK_NoOctDown				; S3K Specific - if not, branch
;	subi.b	#$0C+$04,d2				; S3K Specific - move the note down an octave (and some more...)

STDK_NoOctDown:
		cmpi.b	#$5F-$0C,d2				; has the note gone outside of the keyboard?
		bhi.s	STDK_NoChannel				; if so, branch and ignore

	; This is to allow BGM to display the highest octave (by moving the note down an octave)

;	bls.s	STDK_InRange				; if not, branch
;	bmi.s	STDK_NoChannel				; if negative, branch (outside of keyboard to the left)
;	tst.b	d4					; is this an SFX?
;	bmi.s	STDK_NoChannel				; if so, branch and don't display keys
;	subi.b	#$0C,d2					; move the note down an octave
;	cmpi.b	#$5F-$0C,d2				; has the note gone outside of the keyboard?
;	bhi.s	STDK_NoChannel				; if not, branch

STDK_InRange:
		bsr.w	STDK_GetPos				; load the correct X and VRAM positions
		addi.w	#$00A0,d0				; adjust X position
		move.w	d5,d1					; adjust Y position
		lsl.w	#$04,d1					; ''
		addi.w	#$0088,d1				; ''
		move.w	d7,d3					; adjust VRAM
		add.w	d3,d3					; ''
		add.w	STDK_NoteVRAM(pc,d3.w),d2		; ''

		move.w	d1,(a1)+				; Y position
		move.b	#$01,(a1)+				; shape
		addq.b	#$01,d6					; sprite link
		move.b	d6,(a1)+				; ''
		move.w	d2,(a1)+				; VRAM
		move.w	d0,(a1)+				; X pos

STDK_NoChannel:
		addq.w	#$02,a4					; advance to next channel
		addq.b	#$01,d7					; increase key counter
		addq.b	#$01,d5					; increase keyboard ID
		cmpi.b	#10,d7					; have all 10 keys been accounted for?
		blo.w	STDK_NextKey				; if not, branch
		cmpi.b	#11,d7					; has FM6 been checked for?
		bhs.s	STDK_FinishKeys				; if so, branch
		moveq	#$05,d5					; set to use PCM 1's keyboard (for FM6)
		move.b	(EST_PCM1).w,d0				; check PCM 1 and 2
		or.b	(EST_PCM1).w,d0				; ''
		bpl.w	STDK_NextKey				; if neither of them are running, do another check for FM 6

STDK_FinishKeys:
		moveq	#$00,d0					; set end of sprite list
		move.l	d0,(a1)+				; ''
		rts						; return

; ---------------------------------------------------------------------------
;
; ---------------------------------------------------------------------------

STDK_NoteVRAM:	dc.w	$2500		; FM 1
		dc.w	$2508		; FM 2
		dc.w	$2510		; FM 3
		dc.w	$2518		; FM 4
		dc.w	$2520		; FM 5
		dc.w	$4500		; PCM 1
		dc.w	$4508		; PCM 2
		dc.w	$4510		; PSG 1
		dc.w	$4518		; PSG 2
		dc.w	$4520		; PSG 3/4
		dc.w	$2528		; FM 6

; ---------------------------------------------------------------------------
; Channel specific controls
; ---------------------------------------------------------------------------

STDK_ChanRouts:	dc.l	Normal_palette+$22, STDK_ChanFM
		dc.l	Normal_palette+$26, STDK_ChanFM
		dc.l	Normal_palette+$2A, STDK_ChanFM
		dc.l	Normal_palette+$2E, STDK_ChanFM
		dc.l	Normal_palette+$32, STDK_ChanFM
		dc.l	Normal_palette+$42, STDK_ChanPCM
		dc.l	Normal_palette+$46, STDK_ChanPCM
		dc.l	Normal_palette+$4A, STDK_ChanPSG
		dc.l	Normal_palette+$4E, STDK_ChanPSG
		dc.l	Normal_palette+$52, STDK_ChanPSG
		dc.l	Normal_palette+$36, STDK_ChanFM

	; --- FM ---

STDK_ChanFM:
		move.b	$09(a2),d0				; load volume
		add.b	(EST_MusicRAM+$16).w,d0			; add master volume
		subi.b	#$0C,d0					; subtract maximum cap
		bpl.s	STDK_VolFM_Max				; if the volume is not inside the cap, branch
		moveq	#$00,d0					; force to maximum

STDK_VolFM_Max:
		andi.b	#%01111100,d0				; get volume range 7C
		cmpi.b	#%00100000,d0				; is the volume below 20?
		blo.s	STDK_VolFM_Min				; if not, branch
		move.b	#%00011100,d0				; set to maximum 1C

STDK_VolFM_Min:
		add.b	d0,d4					; add to key palette

		lea	(FreqListFM).l,a0			; load FM frequency table
		move.w	$10(a2),d0				; load frequency
	andi.w	#$3FFF,d0				; Z80 specific - clear upper bits
		beq.s	STDK_InvalidFM				; if it's 0000, branch
	btst.b	#$04,(a2)				; Z80 specific - Is the channel resting?
	bne.w	STDK_InvalidPSG				; Z80 specific - if so, branch (Going to PSG for a reason, it sets the Z flag)
		move.b	$1E(a2),d1				; load detune
		ext.w	d1					; ''
		add.w	d1,d0					; add to frequency
	;	btst.b	#$03,(a2)				; is modulation enabled?
	;	beq.s	STDK_NoFM_Mod				; if not, branch
	btst.b	#$07,$22(a2)				; Z80 Specific - is modulation enabled?
	beq.s	STDK_NoFM_Mod				; Z80 Specific - if not, branch
	cmpi.b	#$01,$24(a2)				; Z80 Specific - is the modulaition timer still counting down?
	bhi.s	STDK_NoFM_Mod				; Z80 Specific - if so, branch
		add.w	$1C(a2),d0				; add modulation frequency

STDK_NoFM_Mod:
		bsr.w	STDK_GetNoteFM				; load the correct note
		lea	($FFFF5800).l,a0			; load FM colours for keys
		andi.b	#%11011,ccr				; clear the Z flag (so it's non-zero)

STDK_InvalidFM:
		rts						; return

	; --- DAC ---

STDK_ChanPCM:
		moveq	#$00,d0					; clear d0
		moveq	#$00,d1					; clear d1
		lea	(STDK_ListDAC).l,a0			; load list
		move.b	$11(a2),d0				; load the note
		subi.b	#$81,d0					; minus starting note
		bcs.s	STDK_NoDAC				; if it's a rest, branch
		beq.s	STDK_FoundDrum				; if it's 81, branch
		subq.b	#$01,d0

STDK_FindDrum:
		move.b	(a0)+,d1				; load number of sprites in the list
		bmi.s	STDK_NoDAC				; if we're outside the list, branch
		adda.w	d1,a0					; skip over this list
		dbf	d0,STDK_FindDrum			; repeat until we've reached the drum we need
		moveq	#$00,d0					; clear d0

STDK_FoundDrum:
		move.b	(a0)+,d1				; load sprite count
		bmi.s	STDK_NoDAC				; if we're outside the list, branch
		subq.b	#$01,d1					; minus 1 for dbf

STDK_NextDrum:
		move.b	(a0)+,d0				; load sprite ID
		lsl.w	#$03,d0					; multiply by size of sprite entry
		lea	STDK_SpriteDAC(pc,d0.w),a2		; load correct sprite entry
		move.w	(a2)+,(a1)+				; Y position
		move.w	(a2)+,d2				; load shape
		addq.b	#$01,d6					; increase sprite link ID
		move.b	d6,d2					; save with shape
		move.w	d2,(a1)+				; shape and sprite link ID
		move.l	(a2)+,(a1)+				; VRAM and X position
		dbf	d1,STDK_NextDrum			; repeat for all drums
		lea	($FFFF5900).l,a0			; load PCM colours for keys
		move.l	(a0,d4.w),(a3)				; save colours to palete buffer

STDK_NoDAC:
		ori.b	#%00100,ccr				; always set zero (this will prevent the returning routine from rendering a normal piano note sprite)
		rts						; return

; ---------------------------------------------------------------------------
; DAC Sprite Rendering list
; ---------------------------------------------------------------------------

STDK_SpriteDAC:	dc.w	$0080+089,$0900,($D300/$20)+$4000,$0080+034	; 00	; Kick
		dc.w	$0080+104,$0900,($D300/$20)+$4006,$0080+046	; 01	; Snare
		dc.w	$0080+089,$0900,($D300/$20)+$400C,$0080+059	; 02	; Scratch
		dc.w	$0080+104,$0900,($D300/$20)+$4012,$0080+069	; 03	; Cymbol
		dc.w	$0080+088,$0900,($D300/$20)+$4018,$0080+082	; 04	; Block (Large)
		dc.w	$0080+104,$0500,($D300/$20)+$401E,$0080+098	; 05	; Glass
		dc.w	$0080+088,$0900,($D300/$20)+$4022,$0080+109	; 06	; Block (Small)
		dc.w	$0080+104,$0500,($D300/$20)+$4028,$0080+122	; 07	; Jam (hehehe)
		dc.w	$0080+088,$0900,($D300/$20)+$402C,$0080+132	; 08	; Mic
		dc.w	$0080+108,$0500,($D300/$20)+$4032,$0080+141	; 09	; Timpani (Left)
		dc.w	$0080+088,$0500,($D300/$20)+$4036,$0080+160	; 0A	; Bongo (Large)
		dc.w	$0080+106,$0500,($D300/$20)+$403A,$0080+170	; 0B	; Timpani (Mid)
		dc.w	$0080+093,$0500,($D300/$20)+$403E,$0080+178	; 0C	; Bongo (Small)
		dc.w	$0080+105,$0500,($D300/$20)+$4042,$0080+201	; 0D	; Timpani (Right)
		dc.w	$0080+097,$0500,($D300/$20)+$4046,$0080+200	; 0E	; Tom 1
		dc.w	$0080+094,$0500,($D300/$20)+$404A,$0080+226	; 0F	; Tom 2
		dc.w	$0080+091,$0500,($D300/$20)+$404E,$0080+254	; 10	; Tom 3
		dc.w	$0080+089,$0500,($D300/$20)+$4052,$0080+283	; 11	; Tom 4
		dc.w	$0080+103,$0500,($D300/$20)+$4056,$0080+216	; 12	; Speaker 1
		dc.w	$0080+103,$0500,($D300/$20)+$4056,$0080+240	; 13	; Speaker 2
		dc.w	$0080+103,$0500,($D300/$20)+$4056,$0080+264	; 14	; Speaker 3
		dc.w	$0080+103,$0500,($D300/$20)+$4056,$0080+288	; 15	; Speaker 4

		; NN = Number of sprites
		; DD = Which sprites to display

		;	 NN  DD  DD  DD ...
STDK_ListDAC:	dc.b	$01,$01
		dc.b	$01,$0D
		dc.b	$01,$0B
		dc.b	$01,$09
		dc.b	$01,$09
		dc.b	$01,$00
		dc.b	$01,$01
		dc.b	$02,$00,$03
		dc.b	$01,$03

		dc.b	$01,$06
		dc.b	$01,$04
		dc.b	$01,$06

		dc.b	$01,$0C
		dc.b	$01,$0A

		dc.b	$01,$15

		dc.b	$01,$11
		dc.b	$01,$10
		dc.b	$01,$0F
		dc.b	$01,$0E

		dc.b	$01,$11
		dc.b	$01,$10
		dc.b	$01,$0F
		dc.b	$01,$0E

		dc.b	$01,$0D
		dc.b	$01,$0B
		dc.b	$01,$09

		dc.b	$01,$01


		dc.b	$01,$12
		dc.b	$02,$14,$00
		dc.b	$02,$13,$08

		dc.b	$01,$07
		dc.b	$01,$07

		dc.b	$03,$15,$00,$02
		dc.b	$01,$05

		dc.b	$02,$15,$01
		dc.b	$01,$00

		dc.b	$01,$08

		dc.b	$01,$01
		dc.b	$01,$00
		dc.b	$01,$00

		dc.b	$01,$08
		dc.b	$01,$08
		dc.b	$02,$01,$08

		dc.b	$01,$14

		dc.b	$01,$06
		dc.b	$01,$04

		dc.b	$01,$0C
		dc.b	$01,$0A

		dc.b	$01,$02

		dc.b	$01,$11
		dc.b	$01,$0F

		dc.b	$02,$00,$15
		dc.b	$02,$00,$14

		dc.b	$02,$00,$08
		dc.b	$01,$00

		dc.b	$02,$00,$14
		dc.b	$02,$00,$15
		dc.b	$02,$02,$15
		dc.b	$01,$02
		dc.b	$01,$01

		dc.b	$02,$14,$00
		dc.b	$02,$05,$08

		dc.b	$01,$01

		dc.b	$03,$02,$08,$00

		dc.b	$02,$00,$13
		dc.b	$02,$00,$12
		dc.b	$02,$00,$12
		dc.b	$02,$00,$15

		dc.b	$01,$11
		dc.b	$01,$0F

		dc.b	$01,$15
		dc.b	$02,$00,$15
		dc.b	$02,$02,$08
		dc.b	$FF
		even


	; --- Old code for Dual PCM Flex-Ed... ---

;		move.b	$09(a2),d0				; load volume
;		moveq	#$00,d1				; EXTRA
;		move.b	(EST_MusicRAM+$16).w,d1		; EXTRA
;		add.b	d1,d1
;		add.b	d1,d0
;		bpl.s	STDK_VolPCM_Max				; if the volume hasn't overflown to 40 (mute), branch
;		moveq	#$7F,d0					; force to maximum
;
;STDK_VolPCM_Max:
;		andi.b	#%01111100,d0				; get volume range 7C
;		cmpi.b	#%00100000,(EST_MusicRAM+$16).w		; is the volume below 20?
;		blo.s	STDK_VolPCM_Min				; if not, branch
;		moveq	#%01111100,d0				; set to maximum 1C
;
;STDK_VolPCM_Min:
;		lsr.b	#$02,d0
;		andi.b	#%00011100,d0
;		add.b	d0,d4					; add to key palette
;
;		lea	(FreqListPCM).l,a0			; load PCM frequency table
;		move.w	$10(a2),d0				; load frequency
;		move.b	$1E(a2),d1				; load detune
;		ext.w	d1					; ''
;		add.w	d1,d0					; add to frequency
	;	btst.b	#$03,(a2)				; is modulation enabled?
	;	beq.s	STDK_NoPCM_Mod				; if not, branch
;	tst.b	$22(a2)					; Z80 Specific - is modulation enabled?
;	beq.s	STDK_NoPCM_Mod				; Z80 Specific - if not, branch
;	cmpi.b	#$01,$24(a2)				; Z80 Specific - is the modulaition timer still counting down?
;	bhi.s	STDK_NoPCM_Mod				; Z80 Specific - if so, branch
;		add.w	$1C(a2),d0				; add modulation frequency
;
;STDK_NoPCM_Mod:
;		bsr.w	STDK_GetNote				; load the correct note
;		lea	($FFFF5900).l,a0			; load PCM colours for keys
;		andi.b	#%11011,ccr				; clear the Z flag (so it's non-zero)
;		rts						; return

	; --- PSG ---

STDK_ChanPSG:
		move.b	(EST_MusicRAM+$16).w,d0			; load master volume
		asr.b	#$02,d0					; divide by 4
		add.b	$09(a2),d0				; add total volume
	sub.b	#$02,d0					; S3K specific - increasing PSG visibility, it's quiet in S3K alot
	bpl.s	STDK_VolPSG_Min				; S3K specific - if the volume isn't at maximum, branch
	moveq	#$00,d0					; S3K specific - Force to maxiumum volume

STDK_VolPSG_Min:
		cmpi.b	#$10,d0					; it is at maximum?
		blo.s	STDK_VolPSG_Max				; if not, branch
		moveq	#%00001110,d0				; set to maximum E

STDK_VolPSG_Max:
		andi.b	#%00001110,d0				; get volume range E
		add.b	d0,d0					; align to position
		add.b	d0,d4					; add to key palette

		lea	(FreqListPSG).l,a0			; load PSG frequency table
		move.w	$10(a2),d0				; load frequency
	andi.w	#$03FF,d0				; Z80 specific - clear upper bits
		bmi.s	STDK_InvalidPSG				; if it's not FFFF, branch
	btst.b	#$04,(a2)				; Z80 specific - Is the channel resting?
	bne.s	STDK_InvalidPSG				; Z80 specific - if so, branch
		move.b	$1E(a2),d1				; load detune
		ext.w	d1					; ''
		add.w	d1,d0					; add to frequency
	;	btst.b	#$03,(a2)				; is modulation enabled?
	;	beq.s	STDK_NoPSG_Mod				; if not, branch
	btst.b	#$07,$22(a2)				; Z80 Specific - is modulation enabled?
	beq.s	STDK_NoPSG_Mod				; Z80 Specific - if not, branch
	cmpi.b	#$01,$24(a2)				; Z80 Specific - is the modulaition timer still counting down?
	bhi.s	STDK_NoPSG_Mod				; Z80 Specific - if so, branch
		add.w	$1C(a2),d0				; add modulation frequency

STDK_NoPSG_Mod:
	andi.w	#$03FF,d0				; Z80 specific - clear upper bits
		bsr.w	STDK_GetNoteRev				; load the correct note
		lea	($FFFF5A00).l,a0			; load PSG colours for keys
		andi.b	#%11011,ccr				; clear the Z flag (so it's non-zero)
		rts						; return

STDK_InvalidPSG:
		ori.b	#%00100,ccr				; set the Z flag (so it's zero)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Getting the right X and Y keyboard positions as well as correct frame
; ---------------------------------------------------------------------------

STDK_GetPos:
		divu.w	#$000C,d2				; ''
		lsl.w	#$03,d2					; multiply by 28 (size of octave piece on keyboard)
		move.w	d2,d0					; ''
		add.w	d2,d2					; ''
		add.w	d2,d2					; ''
		add.w	d2,d0					; ''
		swap	d2					; get key position
		add.b	STDK_KeyCol(pc,d2.w),d4			; add the black key's palette address
		move.l	(a0,d4.w),(a3)				; save colours to palete buffer
		add.w	d2,d2					; multiply by size of long-word
		add.w	d2,d2					; ''
		lea	STDK_KeyPos(pc,d2.w),a0			; load key positions
		add.w	(a0)+,d0				; add X position to octave position
		move.w	(a0)+,d2				; load VRAM art piece
		rts						; return

STDK_KeyCol:	dc.b	$00,$40,$00,$40,$00,$00,$40,$00,$40,$00,$40,$00


		;	 XXXX  VRAM
STDK_KeyPos:	dc.w	$FFFF,$0000
		dc.w	$0002,$0002
		dc.w	$0005,$0004
		dc.w	$0008,$0002
		dc.w	$000A,$0006
		dc.w	$0010,$0000
		dc.w	$0013,$0002
		dc.w	$0016,$0004
		dc.w	$0019,$0002
		dc.w	$001C,$0004
		dc.w	$001F,$0002
		dc.w	$0021,$0006

; ===========================================================================
; ---------------------------------------------------------------------------
; Working out the right note based on frequency (also accounts for detune/LFO)
; ---------------------------------------------------------------------------

	; --- Special octave version for FM ---

STDK_GetNoteFM:
		; Because S3K uses a different "B" frequency on a different octave, the
		; calculations for wrapping are slightly different, see comments for old
		; frequencies from Sonic 1 vs new from Sonic 3K.

		move.w	d0,d2					; load frequency
		andi.w	#$07FF,d2				; clear octave
		cmpi.w	#$0284-$25,d2	; 25E to 284		; is it down an octave?
		bhi.s	STDKGNFM_NoDown				; if not, branch
		subi.w	#$05C4-$40,d0	; 5E2 TO 5C4		; move frequency down a single octave
		bra.s	STDK_GetNote				; continue

STDKGNFM_NoDown:
		cmpi.w	#$04C0+$40,d2	; 47C to 4C0		; is it up an octave?
		blo.s	STDK_GetNote				; if not, branch
		addi.w	#$05C4-$40,d0	; 5E2 TO 5C4		; move frequency up a single octave

	; --- Normal get note (just happens that only PCM is normal, how ironic) ---

STDK_GetNote:
		move.l	d4,-(sp)				; store d4
		moveq	#$60,d2					; set number of notes to check
		move.w	(a0)+,d3				; load first frequency

STDKGN_Next:
		move.w	d3,d4					; store last note
		move.w	(a0)+,d3				; load next note
		move.w	d3,d1					; get distance between them
		sub.w	d4,d1					; ''
		lsr.w	#$01,d1					; get the exact middle
		add.w	d4,d1					; ''
		cmp.w	d1,d0					; has the frequency passed this point?
		dble	d2,STDKGN_Next				; if not, branch
		neg.w	d2					; reverse
		addi.w	#$005F,d2				; ''
		move.l	(sp)+,d4				; restore d4
		rts						; return

	; --- Reverse version for PSG ---

STDK_GetNoteRev:
		move.l	d4,-(sp)				; store d4
		moveq	#$60,d2					; set number of notes to check
		move.w	(a0)+,d3				; load first frequency

STDKGNR_Next:
		move.w	d3,d4					; store last note
		move.w	(a0)+,d3				; load next note
		move.w	d4,d1					; get distance between them
		sub.w	d3,d1					; ''
		lsr.w	#$01,d1					; get the exact middle
		add.w	d3,d1					; ''
		cmp.w	d1,d0					; has the frequency passed this point?
		dbge	d2,STDKGNR_Next				; if not, branch
		neg.w	d2					; reverse
		addi.w	#$005F,d2				; ''
		move.l	(sp)+,d4				; restore d4
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw the paino mappings properly
; ---------------------------------------------------------------------------

ST_DrawPaino:
		lea	($FFFF9000).w,a3			; load status

		lea	(ST_BGMRAM).l,a4			; load channel RAM list
		lea	($FFFF6052).l,a0			; load piano mappings
		lea	($FFFF8002).w,a1			; load plane buffer

		move.w	#$0870,d5				; load ON mappings address advancement
		moveq	#$02-1,d6				; set number of rows to render per piano
		moveq	#$0A-1,d7				; do all channels
		bsr.w	ST_DrawChannels				; ''

	; --- PSG 4 ---

		tst.b	(a2)					; was PSG 3 running?
		bmi.s	ST_CheckPSG4				; if so, branch

ST_NoPSG4:
		bclr.b	#$07,(a3)+				; clear PSG 4 flag
		beq.w	ST_CheckFM6				; if it was already cleared, branch

		moveq	#$02-1,d1				; set number of rows to draw
		lea	($FFFF6692).l,a0			; load piano mappings
		lea	($FFFF8A02).w,a1			; load plane buffer
		bsr.w	ST_DrawPiano

		bset.b	#$00,($FFFFA000).w			; set plane redraw flag
		bra.w	ST_CheckFM6				; continue

ST_CheckPSG4:
		move.b	$1F(a2),d4				; load PSG 3's PSG 4 mode flags
		beq.s	ST_NoPSG4				; if PSG 4 mode is off, branch
		andi.b	#$07,d4					; get only the mode bits
		ori.b	#$80,d4					; enable the PSG 4 on bit
		cmp.b	(a3),d4					; has the mode changed?
		beq.w	ST_FinishPSG4				; if not, branch
		move.b	d4,(a3)					; update mode
		bset.b	#$00,($FFFFA000).w			; set plane redraw flag

		; "PSG 4"

		lea	($FFFF6692).l,a0			; load piano mappings
		lea	($FFFF8A02).w,a1			; load plane buffer
		moveq	#$03-1,d2				; set width of piece
		bsr.w	ST_DrawPiece_On				; draw "PSG 4" on

		; "WHITE/PERIODIC"

		addq.w	#$02,a0					; advance to noise type
		addq.w	#$02,a1					; ''
		moveq	#$08-1,d2				; set width of piece
		btst	#$02,d4					; is white noise set?
		bne.s	ST_WhiteNoise				; if so, branch
		bsr.w	ST_DrawPiece				; "WHITE"
		bsr.w	ST_DrawPiece_On				; "PERIODIC"
		bra.s	ST_PeriodicNoise			; continue

ST_WhiteNoise:
		bsr.w	ST_DrawPiece_On				; "WHITE"
		bsr.w	ST_DrawPiece				; "PERIODIC"

ST_PeriodicNoise:
		addq.w	#$02,a0					; advance to noise type
		addq.w	#$02,a1					; ''
		moveq	#$04-1,d2				; set width of piece
		andi.w	#$0003,d4				; get only the frequency type
		lsl.b	#$04,d4					; multiply by 10
		jsr	ST_FrequList(pc,d4.w)			; run correct display list
		bra.s	ST_FinishPSG4				; continue

ST_FrequList:
		bsr.w	ST_DrawPiece				; "LOW"
		bsr.w	ST_DrawPiece				; "MID"
		bsr.w	ST_DrawPiece_On				; "HIGH"
		bra.w	ST_DrawPiece				; "PSG3"

		bsr.w	ST_DrawPiece				; "LOW"
		bsr.w	ST_DrawPiece_On				; "MID"
		bsr.w	ST_DrawPiece				; "HIGH"
		bra.w	ST_DrawPiece				; "PSG3"

		bsr.w	ST_DrawPiece_On				; "LOW"
		bsr.w	ST_DrawPiece				; "MID"
		bsr.w	ST_DrawPiece				; "HIGH"
		bra.w	ST_DrawPiece				; "PSG3"

		bsr.w	ST_DrawPiece				; "LOW"
		bsr.w	ST_DrawPiece				; "MID"
		bsr.w	ST_DrawPiece				; "HIGH"
		bra.w	ST_DrawPiece_On				; "PSG3"

ST_FinishPSG4:
		addq.w	#$01,a3					; skip passed PSG 4 flag

ST_CheckFM6:

	; --- FM 6 ---

		move.b	(EST_PCM1).w,d0				; load PCM 1 and 2 statuses
		or.b	(EST_PCM2).w,d0				; ''
		andi.b	#$80,d0					; get only running status
		bne.s	ST_NoDrawFM6				; if neither are on, branch

		lea	(ST_BGMFM6).l,a4			; load channel RAM list
		lea	($FFFF6FA2).l,a0			; load piano mappings
		lea	($FFFF8502).w,a1			; load plane buffer

		move.w	#$0140,d5				; load ON mappings address advancement
		moveq	#$04-1,d6				; set number of rows to render per piano
		moveq	#$01-1,d7				; do only 1 channel
		bsr.s	ST_DrawChannels				; ''
		rts						; return

ST_NoDrawFM6:
		bclr.b	#$07,(a3)				; clear FM 6 flag
		beq.s	ST_NoRedraw				; if it was already clear, branch
		bset.b	#$00,($FFFFA000).w			; set plane redraw flag

ST_NoRedraw:
		move.b	#$01,(a3)				; keep low bit set so it registers as "changed" when stopped
		rts						; return

; ---------------------------------------------------------------------------
; Checking normal channels
; ---------------------------------------------------------------------------

ST_DrawChannels:
		movea.w	(a4),a2					; load channel
		btst.b	#$02,(a2)				; is the channel being interrupted by SFX?
		bne.s	ST_CheckSPE				; if so, branch
;	move.b	$21(a2),d0			; is the channel muted?
;	not.b	d0
;	tst.b	d0
;	bpl.s	ST_Mute				; if so, branch
		bra.s	ST_NoSPE

ST_CheckSPE:
	;	move.w	ST_SPERAM-ST_BGMRAM(a4),d0		; load Special SFX channel
	;	beq.s	ST_CheckSFX				; if there is no special SFX channel, branch
	;	movea.w	d0,a2					; set address
	;	btst.b	#$02,(a2)				; is the channel being interrupted by SFX?
	;	beq.s	ST_NoSPE				; if not, branch

ST_CheckSFX:
		move.w	ST_SFXRAM-ST_BGMRAM(a4),d0		; load SFX channel
		beq.s	ST_NoChannel				; if there is no SFX channel, branch
		movea.w	d0,a2					; set address

ST_NoSPE:
		move.b	(a2),d0					; load channel status
	ST_Mute:
		andi.b	#$80,d0					; get only running flag
		cmp.b	(a3),d0					; has the channel's status changed?
		beq.s	ST_NoChannel				; no change...
		bset.b	#$00,($FFFFA000).w			; set plane redraw flag

		movem.l	a0-a1,-(sp)				; store registers
		move.w	d6,d1					; set number of rows to do
		move.b	d0,(a3)					; update status
		bpl.s	ST_PianoOff				; if turned off, branch
		adda.w	d5,a0					; load ON mappings

ST_PianoOff:
		cmpa.w	#EST_PCM1&$FFFF,a2			; S3K Specific - is this the DAC channel?
		bne.s	ST_NoDAC				; S3K Specific - if not, branch
		addq.b	#$02,d1					; S3K Specific - DAC uses more space than FM and PSG channels

ST_NoDAC:
		bsr.s	ST_DrawPiano				; draw piano
		movem.l	(sp)+,a0-a1				; restore registers

ST_NoChannel:
		lea	$50*2(a0),a0				; advance to next source mappings
		lea	$80*2(a1),a1				; advance to next destination plane
		addq.w	#$01,a3					; advance to next status storage
		addq.w	#$02,a4					; advance to next channel
		dbf	d7,ST_DrawChannels			; repeat for all channels
		rts						; return

ST_DrawPiano:
		move.l	(a0)+,(a1)+				; copy mappings
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		addq.w	#$04,a0					; advance to next source mappings
ST_ADVPLANE	=	$80-($26*2)	; because AS is a dick
		lea	ST_ADVPLANE(a1),a1			; advance to next plane row
		dbf	d1,ST_DrawPiano				; repeat for both rows
		rts						; return

; ---------------------------------------------------------------------------
; Subroutine to draw a PSG 4 piece
; ---------------------------------------------------------------------------

ST_DrawPiece_On:
		movem.l	a0-a1,-(sp)				; store registers
		adda.w	#$1B*$50,a0				; advance to "ON" graphics
		bra.s	STDP_Start				; continue

ST_DrawPiece:
		movem.l	a0-a1,-(sp)				; store registers

STDP_Start:
		moveq	#$01,d0					; set height

STDP_NextColumn:
		movem.l	a0-a1,-(sp)				; store registers
		move.w	d2,d1					; load width

STDP_NextRow:
		move.w	(a0)+,(a1)+
		dbf	d1,STDP_NextRow				; repeat for width
		movem.l	(sp)+,a0-a1				; restore registers
		lea	$50(a0),a0				; advance to next source mappings
		lea	$80(a1),a1				; advance to next destination plane
		dbf	d0,STDP_NextColumn			; repeat for height
		movem.l	(sp)+,a0-a1				; restore registers
		move.w	d2,d1					; advance mapping address to end
		addq.w	#$01,d1					; increase by 1 (due to dbf)
		add.w	d1,d1					; ''
		adda.w	d1,a0					; ''
		adda.w	d1,a1					; ''
		rts						; return

; ---------------------------------------------------------------------------
; Channel RAM list
; ---------------------------------------------------------------------------

ST_BGMRAM:	dc.w	EST_FM1&$FFFF				; FM 1
		dc.w	EST_FM2&$FFFF				; FM 2
		dc.w	EST_FM3&$FFFF				; FM 3
		dc.w	EST_FM4&$FFFF				; FM 4
		dc.w	EST_FM5&$FFFF				; FM 5
		dc.w	EST_PCM1&$FFFF				; PCM 1
		dc.w	EST_PCM2&$FFFF				; PCM 2
		dc.w	EST_PSG1&$FFFF				; PSG 1
		dc.w	EST_PSG2&$FFFF				; PSG 2
		dc.w	EST_PSG3&$FFFF				; PSG 3/4
ST_BGMFM6:	dc.w	EST_FM6&$FFFF				; FM 6

ST_SFXRAM:	dc.w	$0000					; FM 1
		dc.w	$0000					; FM 2
		dc.w	EST_FM3_SFX&$FFFF			; FM 3
		dc.w	EST_FM4_SFX&$FFFF			; FM 4
		dc.w	EST_FM5_SFX&$FFFF			; FM 5
		dc.w	$0000					; PCM 1
		dc.w	$0000					; PCM 2
		dc.w	EST_PSG1_SFX&$FFFF			; PSG 1
		dc.w	EST_PSG2_SFX&$FFFF			; PSG 2
		dc.w	EST_PSG3_SFX&$FFFF			; PSG 3
		dc.w	$0000					; FM 6

ST_SPERAM:	dc.w	$0000					; FM 1
		dc.w	$0000					; FM 2
		dc.w	$0000					; FM 3
		dc.w	EST_FM4_EXT&$FFFF			; FM 4
		dc.w	$0000					; FM 5
		dc.w	$0000					; PCM 1
		dc.w	$0000					; PCM 2
		dc.w	$0000					; PSG 1
		dc.w	$0000					; PSG 2
		dc.w	EST_PSG3_EXT&$FFFF			; PSG 3
		dc.w	$0000					; FM 6

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank - Sound Test (Text bar at bottom)
; ---------------------------------------------------------------------------

HB_SoundTest:
		move.w	#$8A00|$00,($C00004).l			; set new interrupt line occurance amount
		move.l	#$FFFF5D00,(H_int_addr).w		; set H-blank routine
		move.b	#$28-1,($FFFF5FFF).l			; set counter
		rte						; return

	; --- Copied to RAM 5C00 ---

HBST_FontBar:
		move.l	#$40000010,($C00004).l			; set VDP to VSRAM write mode
HBST_FontPos:	move.l	($FFFF5E00).l,($C00000).l		; change V-scroll position
		addq.w	#$04,((HBST_FontPos-HBST_FontBar)+$FFFF5D00)+$04
		subq.b	#$01,($FFFF5FFF).l			; decrease counter
		bpl.s	HBST_NoFinish				; if not finished, branch
		move.w	#$8A00|$DF,($C00004).l			; revert align amount
		move.l	#NullRTE,(H_int_addr).w			; set H-blank routine

HBST_NoFinish:
		rte						; return
HBST_FontBar_End:

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank - Sound Test (Normal)
; ---------------------------------------------------------------------------

VB_SoundTest:
		movem.l	d7/a0-a1,-(sp)				; store registers

		lea	(HBST_FontBar).l,a0
		lea	($FFFF5D00).l,a1

		rept	(HBST_FontBar_End-HBST_FontBar)/$04
		move.l	(a0)+,(a1)+
		endm

		movem.l	(sp)+,d7/a0-a1				; restore registers
		move.w	#$8A00|($B7/$02),($C00004).l		; set interrupt line address
		move.l	#HB_SoundTest,(H_int_addr).w		; set H-blank routine

VB_SoundTest_NoHB:
		movem.l	d0-a6,-(sp)				; store register data
		tst.b	(V_int_routine).w			; was the 68k late?
		beq.w	VBST_68kLate				; if so, branch

		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as read only

		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		subq.b	#$01,($FFFFA001).w			; decrease postpone draw timer
		bpl.s	VBST_NoDrawPlane			; if it's still running, branch
		sf.b	($FFFFA001).w				; keep at 0
		bclr.b	#$00,($FFFFA000).w			; clear plane drawn flag
		beq.s	VBST_NoDrawPlane			; if it was already clear, branch (no drawing required)
		DMA	$0B00, $60800003, $FFFF8000		; background plane

VBST_NoDrawPlane:
		DMA	$0080, $C0000000, Normal_palette	; palette
		DMA	$0280, $78000003, Sprite_table_buffer	; sprites
		DMA	$0380, $7C000003, H_scroll_buffer	; h-scroll
		move.l	#$40000010,(a6)				; v-scroll
		move.l	(V_scroll_value).w,(a5)			; ''
		jsr	Poll_Controllers			; read the controller pads

VBST_68kLate:
		sf.b	(V_int_routine).w			; clear V-blank flag
		move.w	#$2300,sr				; enable interrupts
	;	jsr	sub_71B4C				; run sound driver


VBST_WaitDisplay:	; NAT: Because tracker updating is now done by command, this is not needed here
			; it does make the display delayed by 1 frame more, which may be a problem?
	;	move.w	($C00008).l,d0				; Z80 Specific - load H/V counter
	;	cmpi.w	#$3000,d0				; Z80 Specific - has the VDP reached display period yet?
	;	bmi.s	VBST_WaitDisplay			; Z80 Specific - if not, then the Z80 probably isn't finished with tracker stuff yet, so wait til it is...
		jsr	Z80_ReadSMPS				; Z80 Specific - load Z80 channel data

		moveq	#-1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as execute tracker
		movem.l	(sp)+,d0-a6				; restore register data
		rtr						; return and restore ccr (does not affect sr)

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to read all Z80 SMPS data into RAM
; ---------------------------------------------------------------------------
; 68k addresses
_Flags		=	$00	; ##		; byte	O??S MIR? (See flags under index list for details)
_ChipValue	=	$01			; byte	Sound chip specific value for YM2612/PSG
_TempoMultiply	=	$02			; byte	Tempo divider per channel
_Tracker	=	$04			; long	tracker address (a pointer to the channel notes)
_Pitch		=	$08			; byte	Pitch (note adjustment, signed)
_Volume		=	$09	; ##		; byte	Volume control (00 loudest)
_PitchVolume	=	_Pitch			; ^^ See above
_Panning	=	$0A			; byte	Used to store panning/LFO
_VoiceID	=	$0B			; byte	voice ID to use
_VoicePosPSG	=	$0C			; byte	Voice evolope position
_StackAddress	=	$0D			; byte	Starts at end of channel, and moves back (used for F8 "call" flag)
_TimerCur	=	$0E	; ##		; byte	current timer (note duration)
_TimerPrev	=	$0F	; ##		; byte	previous timer loaded
_Note		=	$10			; byte	DAC ONLY: currently playing note
_Frequency	=	$10	; ##		; word	FM/PSG ONLY: currently playing frequency
_ReleaseKeyCur	=	$12			; byte	Release key rate current counter
_ReleaseKeyMain	=	$13			; byte	Release key rate total/main amount
_Modulation	=	$14			; long	address of modulation (frequency LFO)
_ModDelay	=	$18			; byte	Delay time before modulation starts
_ModSpeed	=	$19			; byte	Speed of modulation
_ModRate	=	$1A			; byte	Rate of modulation rise/drop per set
_ModSteps	=	$1B			; byte	Number of steps before changing direction
_ModFrequency	=	$1C	; ##		; word	Frequency of modulation
_Detune		=	$1E	; ##		; byte	Detune (signed byte to adjust the frequency up and down subtly)
_Algorithm	=	$1F			; byte	FM ONLY: currently selected voice's feedback/algorithm (--FF FAAA)
_StatusPSG4	=	$1F	; ##		; byte	PSG ONLY: PSG 4 settings/status (chip value for specifying noise type)
_LoopList	=	$24			; byte	List of loop counters, each one for a specific loop
; ---------------------------------------------------------------------------

Z80_ReadSMPS:
		lea	(Z80_RAM).l,a0				; load Z80 RAM
		lea	(EST_MusicStatus).l,a1			; load status RAM

		move.b	(EST_Tempo).w,d0			; load tempo control
		neg.b	d0					; reverse direction
		cmpi.b	#$80,d0					; is it 80?
		bne.s	ZWM_NoCapTempo				; if not, branch
		subq.b	#$01,d0					; 80 cannot be negated, so used 7F instead...

ZWM_NoCapTempo:
	stopZ80
		move.b	d0,(Z80_RAM+zTempoCtrl).l		; set tempo control amount
		move.b	zSongFM1(a0),(a1)+			; load statuses from all music/sfx channels
		move.b	zSongFM2(a0),(a1)+			; ''
		move.b	zSongFM3(a0),(a1)+			; ''
		move.b	zSongFM4(a0),(a1)+			; ''
		move.b	zSongFM5(a0),(a1)+			; ''
		move.b	zSongFM6_DAC(a0),(a1)+			; ''
		move.b	zSongPSG1(a0),(a1)+			; ''
		move.b	zSongPSG2(a0),(a1)+			; ''
		move.b	zSongPSG3(a0),(a1)+			; ''
		move.b	zSFX_FM3(a0),(a1)+			; ''
		move.b	zSFX_FM4(a0),(a1)+			; ''
		move.b	zSFX_FM5(a0),(a1)+			; ''
	;	move.b	zSFX_FM6(a0),(a1)+			; ''
		move.b	zSFX_PSG1(a0),(a1)+			; ''
		move.b	zSFX_PSG2(a0),(a1)+			; ''
		move.b	zSFX_PSG3(a0),(a1)+			; ''
	startZ80
		lea	(ST_Z80RAM).l,a0			; load Z80/68k RAM list
		moveq	#((ST_Z80RAM_End-ST_Z80RAM)/8)-1,d4	; set number of channels to read
		lea	(EST_MusicStatus).l,a2			; reload status RAM
		lea	(EST_MusicAddZ80).l,a3			; load music address list
		lea	(EST_MusicAdd68k).l,a4			; ''
		moveq	#$00,d3					; reset number of channels read

ZRS_NextChannel:
		move.l	(a0)+,a1				; load 68k's address
		move.b	(a2)+,(a1)				; copy status to the channel
		bpl.s	ZRS_NotRunning				; if the channel is not operational, branch
		move.l	(a0),(a3)+				; set Z80 address
		move.l	a1,(a4)+				; set 68k address
		addq.w	#$01,d3					; increase channel counter

ZRS_NotRunning:
		addq.w	#$04,a0					; skip to next channel
		dbf	d4,ZRS_NextChannel			; repeat for number of channels

	; --- Now the actual reading ---

		lea	(EST_MusicAddZ80).l,a3			; load music address list
		lea	(EST_MusicData).l,a0			; load music data storage
		subq.w	#$01,d3					; minus 1 (due to dbf
		bmi.w	ZRS_Finish				; if there are no channels to update, branch
		move.w	d3,d4					; copy counter to d4
	stopZ80

ZRS_ReadChannel:
		move.l	(a3)+,a1				; load Z80 RAM

	;	move.b	zTrack.Volume(a1),_Volume(a2)			; 06
	;	move.b	zTrack.ModulationCtrl(a1),$22(a2)		; 07
	;	move.b	zTrack.DurationTimeout(a1),_TimerCur(a2)	; 0B
	;	move.b	zTrack.SavedDuration(a1),_TimerPrev(a2)		; 0C
	;	move.b	zTrack.FreqLow(a1),_Frequency+1(a2)		; 0D
	;	move.b	zTrack.FreqHigh(a1),_Frequency(a2)		; 0E
	;	move.b	zTrack.Detune(a1),_Detune(a2)			; 10
	;	move.b	zTrack.PSGSustain(a1),$23(a2)			; 11
	;	move.b	zTrack.PSGNoise(a1),_StatusPSG4(a2)		; 1A
	;	move.b	zTrack.ModulationValLow(a1),_ModFrequency+1(a2)	; 22
	;	move.b	zTrack.ModulationValHigh(a1),_ModFrequency(a2)	; 23
	;	move.b	zTrack.ModulationWait(a1),$24(a2)		; 24

	addq.w	#$06,a1
	move.b	(a1)+,(a0)+
	move.b	(a1)+,(a0)+
	addq.w	#$03,a1
	move.b	(a1)+,(a0)+
	move.b	(a1)+,(a0)+
	move.b	(a1)+,(a0)+
	move.b	(a1)+,(a0)+
	addq.w	#$01,a1
	move.b	(a1)+,(a0)+
	move.b	(a1)+,(a0)+
	addq.w	#$08,a1
	move.b	(a1)+,(a0)+
	addq.w	#$07,A1
	move.b	(a1)+,(a0)+
	move.b	(a1)+,(a0)+
	move.b	(a1)+,(a0)+
		dbf	d3,ZRS_ReadChannel			; repeat for all channels
	startZ80

ZRS_ApplyChannels:
		lea	(EST_MusicAdd68k).l,a1			; load 68k RAM list
		lea	(EST_MusicData).l,a0			; load music data list

ZRS_ApplyChannel:
		move.l	(a1)+,a2				; load 68k RAM
		move.b	(a0)+,_Volume(a2)			; 06
		move.b	(a0)+,$22(a2)				; 07
		move.b	(a0)+,_TimerCur(a2)			; 0B
		move.b	(a0)+,_TimerPrev(a2)			; 0C
		move.b	(a0)+,_Frequency+1(a2)			; 0D
		move.b	(a0)+,_Frequency(a2)			; 0E
		move.b	(a0)+,_Detune(a2)			; 10
		move.b	(a0)+,$23(a2)				; 11
		move.b	(a0)+,_StatusPSG4(a2)			; 1A
		move.b	(a0)+,_ModFrequency+1(a2)		; 22
		move.b	(a0)+,_ModFrequency(a2)			; 23
		move.b	(a0)+,$24(a2)				; 24
		dbf	d4,ZRS_ApplyChannel			; repeat for all channels

ZRS_Finish:
		rts						; return

; ---------------------------------------------------------------------------
; Channel pointers
; ---------------------------------------------------------------------------

ST_Z80RAM:	dc.l	EST_FM1,	Z80_RAM+zSongFM1
		dc.l	EST_FM2,	Z80_RAM+zSongFM2
		dc.l	EST_FM3,	Z80_RAM+zSongFM3
		dc.l	EST_FM4,	Z80_RAM+zSongFM4
		dc.l	EST_FM5,	Z80_RAM+zSongFM5
		dc.l	EST_PCM1,	Z80_RAM+zSongFM6_DAC
		dc.l	EST_PSG1,	Z80_RAM+zSongPSG1
		dc.l	EST_PSG2,	Z80_RAM+zSongPSG2
		dc.l	EST_PSG3,	Z80_RAM+zSongPSG3
		dc.l	EST_FM3_SFX,	Z80_RAM+zSFX_FM3
		dc.l	EST_FM4_SFX,	Z80_RAM+zSFX_FM4
		dc.l	EST_FM5_SFX,	Z80_RAM+zSFX_FM5
		dc.l	EST_PSG1_SFX,	Z80_RAM+zSFX_PSG1
		dc.l	EST_PSG2_SFX,	Z80_RAM+zSFX_PSG2
		dc.l	EST_PSG3_SFX,	Z80_RAM+zSFX_PSG3
ST_Z80RAM_End:

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to clear a section of VDP memory using DMA fill
; ---------------------------------------------------------------------------
;		move.l	#$40000080,d0				; VDP mode/address
;		move.w	#$0400,d1				; size to clear
;		jsr	(ClearVDP).w				; clear VDP memory section
; ---------------------------------------------------------------------------

;ClearVDP:
;		move.w	#$8F01,(a6)				; set increment mode to 1
;		move.l	#$97809300,d2				; prepare size register data
;		subq.w	#$01,d1					; decrease size by 1
;		move.b	d1,d2					; get low byte
;		move.l	d2,(a6)					; set DMA source & DMA size low byte
;		lsr.w	#$08,d1					; get high byte
;		ori.w	#$9400,d1				; load size register
;		move.w	d1,(a6)					; set DMA size high byte
;		move.l	d0,(a6)					; set DMA destination
;		move.w	#$0000,(a5)				; fill location with 0000
;		nop						; delay
;
;CVD_Wait:
;		move.w	(a6),ccr				; load status (this resets the 2nd write flag too)
;		bvs.s	CVD_Wait				; if the VDP DMA busy flag was set (bit 1), branch to wait til finished...
;		move.w	#$8F02,(a6)				; set increment mode to normal
;		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write mapping tiles correctly to a plane
; --- Inputs ----------------------------------------------------------------
; d3.l = Line advance value
; d0.l = VRAM address of plane to write to
; d1.w = X size
; d2.w = Y size
; ---------------------------------------------------------------------------

ST_MapScreen:
		move.l	#$00800000,d3				; prepare line advance amount

ST_MapRow:
		move.l	d0,(a6)					; set VDP to VRAM write mode
		add.l	d3,d0					; advance to next line
		move.w	d1,d4					; load X size

ST_MapColumn:
		move.w	(a1)+,(a5)				; copy tile mappings over
		dbf	d4,ST_MapColumn				; repeat until all done
		dbf	d2,ST_MapRow				; repeat for all rows
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Frequency lists for channels
; ---------------------------------------------------------------------------

; --- FM ---

	;	dc.w	  C     C#    D     Eb    E     F     F#    G     G#    A     Bb    B

FreqListFM:	dc.w	                                                            	  $F000	; < added note 80 for calculation
		dc.w	$0284,$02AB,$02D3,$02FE,$032D,$035C,$038F,$03C5,$03FF,$043C,$047C,$04C0	; Octave 0 - (81 - 8C)
		dc.w	$0A84,$0AAB,$0AD3,$0AFE,$0B2D,$0B5C,$0B8F,$0BC5,$0BFF,$0C3C,$0C7C,$0CC0	; Octave 1 - (8D - 98)
		dc.w	$1284,$12AB,$12D3,$12FE,$132D,$135C,$138F,$13C5,$13FF,$143C,$147C,$14C0	; Octave 2 - (99 - A4)
		dc.w	$1A84,$1AAB,$1AD3,$1AFE,$1B2D,$1B5C,$1B8F,$1BC5,$1BFF,$1C3C,$1C7C,$1CC0	; Octave 3 - (A5 - B0)
		dc.w	$2284,$22AB,$22D3,$22FE,$232D,$235C,$238F,$23C5,$23FF,$243C,$247C,$24C0	; Octave 4 - (B1 - BC)
		dc.w	$2A84,$2AAB,$2AD3,$2AFE,$2B2D,$2B5C,$2B8F,$2BC5,$2BFF,$2C3C,$2C7C,$2CC0	; Octave 5 - (BD - C8)
		dc.w	$3284,$32AB,$32D3,$32FE,$332D,$335C,$338F,$33C5,$33FF,$343C,$347C,$34C0	; Octave 6 - (c9 - D4)
		dc.w	$3A84,$3AAB,$3AD3,$3AFE,$3B2D,$3B5C,$3B8F,$3BC5,$3BFF,$3C3C,$3C7C,$3CC0	; Octave 7 - (D5 - DF) < Added note E0 for calculation

; --- PSG ---

	;	dc.w	  C     C#    D     Eb    E     F     F#    G     G#    A     Bb    B

FreqListPSG:	dc.w	$0800	; < Added note 80 for calculation
		dc.w	$03FF,$03FF,$03FF,$03FF,$03FF,$03FF,$03FF,$03FF,$03FF,$03F7,$03BE,$0388	; Octave 2 - (81 - 8C)
		dc.w	$0356,$0326,$02F9,$02CE,$02A5,$0280,$025C,$023A,$021A,$01FB,$01DF,$01C4	; Octave 3 - (81 - 8C)
		dc.w	$01AB,$0193,$017D,$0167,$0153,$0140,$012E,$011D,$010D,$00FE,$00EF,$00E2	; Octave 4 - (8D - 98)
		dc.w	$00D6,$00C9,$00BE,$00B4,$00A9,$00A0,$0097,$008F,$0087,$007F,$0078,$0071	; Octave 5 - (99 - A4)
		dc.w	$006B,$0065,$005F,$005A,$0055,$0050,$004B,$0047,$0043,$0040,$003C,$0039	; Octave 6 - (A5 - B0)
		dc.w	$0036,$0033,$0030,$002D,$002B,$0028,$0026,$0024,$0022,$0020,$001F,$001D	; Octave 7 - (B1 - BC)

		dc.w	$001B,$001A,$0018,$0017,$0016,$0015,$0013,$0012,$0011,$0010,$0000,$0000	; Notes (BD - C8)
		dc.w	$F000	; < Added note C9 for calculation

; --- PCM ---

	;	dc.w	  C     C#    D     Eb    E     F     F#    G     G#    A     Bb    B

FreqListPCM:	dc.w	$000E	; < Added note 80 for calculation
		dc.w	$000F,$0010,$0011,$0012,$0013,$0014,$0016,$0017,$0019,$001B,$001D,$001F	; Octave 0 - (81 - 8C)
		dc.w	$0021,$0023,$0025,$0027,$0029,$002B,$002E,$0031,$0034,$0037,$003A,$003C	; Octave 1 - (8D - 98)
		dc.w	$0040,$0044,$0048,$004C,$0051,$0056,$005A,$0060,$0066,$006C,$0072,$007A	; Octave 2 - (99 - A4)
		dc.w	$0080,$0088,$0090,$0098,$00A2,$00AC,$00B6,$00C2,$00CE,$00DA,$00E6,$00F2	; Octave 3 - (A5 - B0)
		dc.w	$0100,$0110,$0121,$0132,$0144,$0156,$016B,$0184,$0198,$01B2,$01C8,$01E4	; Octave 4 - (B1 - BC)
		dc.w	$0204,$0220,$0240,$0262,$0286,$02AC,$02D4,$0300,$032C,$035C,$0390,$03C4	; Octave 5 - (BD - C8)
		dc.w	$0404,$0440,$0488,$04C8,$0510,$0558,$05A8,$05FC,$0658,$06C4,$0730,$078C	; Octave 6 - (C9 - D4)
		dc.w	$0806,$0888,$090C,$0990,$0A20,$0AB0,$0B48,$0BF8,$0CA8,$0D74,$0E48	; Octave 7 - (D5 - DF)

; ===========================================================================
; ---------------------------------------------------------------------------
; Data includes
; ---------------------------------------------------------------------------

Pal_Sound:	binclude "Screen Sound Test\Data\Pal Piano.bin"
		dc.w	$0000,$000E,$0008,$000E,$0008,$000E,$0008,$000E
		dc.w	$0008,$000E,$0008,$000E,$0008,$0E84,$0800,$0000
		dc.w	$0000,$0E00,$0800,$0E00,$0800,$00E0,$0080,$00E0
		dc.w	$0080,$00E0,$0080,$0000,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
Pal_Sound_End:	even

Art_Piano:	binclude "Screen Sound Test\Data\Art Piano.kosm"
		even
Map_Piano:	binclude "Screen Sound Test\Data\Map Piano.mun"
		even

Art_Keys:	binclude "Screen Sound Test\Data\Art Keys.kosm"
		even

Art_Char:	binclude "Screen Sound Test\Data\Art Char.kosm"
		even
Map_Char:	binclude "Screen Sound Test\Data\Map Char.bin"
		even

Art_Extras:	binclude "Screen Sound Test\Data\Art Extras.kosm"
		even
Art_DAC:	binclude "Screen Sound Test\Data\Art DAC.kosm"
		even

; ===========================================================================


