; ===========================================================================
; ---------------------------------------------------------------------------
; 20 - Intro
; ---------------------------------------------------------------------------
IN_IdentMap_MJ	=	$00FF3000				; mappings for MarkeyJester ident
IN_IdentMap_NS	=	$00FF3800				; mappings for Natsumi ident
IN_IdentMap_BL	=	$00FF5000				; mappings for "blank" ident (just to clear the mappings)
IN_PrevPos	=	$00FF6000				; previous positions for sprites
IN_PrevPosArt	=	$00FF6800				; previous positions for art
IN_HeadScrolls	=	$00FF6C00				; head sprites X scroll speeds
IN_VariableRAM	=	$00FF7000				; 1000
IN_SpritePri	=	$00FF7000				; byte
IN_IdentFlash	=	$00FF7001				; byte
IN_SpriteAdd	=	$00FF7002				; word
IN_ScrollPos	=	$00FF7004				; long (QQQQ.DDDD)
IN_EventsRout	=	$00FF7008				; long
IN_EventsTime	=	$00FF700C				; word
IN_EventsCount	=	$00FF700E				; word
IN_ZigZagPos	=	$00FF7010				; long (QQQQ.DDDD) zig-zag art/scroll position
IN_ZigZagFrame	=	$00FF7014				; long (QQQQ.DDRR) zig-zag frame position
IN_ZigZagDip	=	$00FF7018				; word time before frame positions should change
IN_PalBlendFade	=	$00FF701A				; word
IN_PalFadeTimer	=	$00FF701C				; word
IN_IdentScroll	=	$00FF7020				; long (QQQQ.DDDD)
IN_IdentSprite	=	$00FF7024				; long (QQQQ.DDDD) scroll position for the sprites
IN_IdentList	=	$00FF7028				; long
IN_ArtLoadList	=	$00FF702C				; 8 bytes (2 long pointers)
IN_IdentAniRout	=	$00FF7034				; long pointer to animation routine (if any)
IN_IdentAniList	=	$00FF7038				; long pointer to animation list
IN_IdentAniTime	=	$00FF703C				; word timer for animation frame
IN_IdentHold	=	$00FF703E				; word timer for holding the ident in place for a small while
IN_ScrollZigZag	=	$00FF7040				; byte flag
; ---------------------------------------------------------------------------
IN_STARTSCROLL	=	$150					; starting scroll position
; ---------------------------------------------------------------------------

Intro:
		moveq	#$E4,d0					; set sound ID to "Stop Music"
		jsr	Play_Sound_2.w				; play sound ID
		jsr	Clear_KosM_Queue.w			; clear PLC list
		jsr	Pal_FadeToBlack				; fade the screen out

	; --- Setup/clearing ---

		move	#$2700,sr				; disable interrupts
		move.l	#HInt_Done,(H_int_addr).w		; set H-blank routine
		move.l	#VInt,(V_int_addr).w			; set V-blank routine
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.w	#$8000|%00010100,(a6)			; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)
		move.w	#$8100|%01110100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.w	#$8200|((($E000)>>$0A)&$FF),(a6)	; 00FE DCBA - Scroll Plane A Map Table VRam address
		move.w	#$8300|((($F000)>>$0A)&$FF),(a6)	; 00FE DCB0 / 00FE DC00 (20 H-resol) - Window Plane A Map Table VRam address
		move.w	#$8400|((($C000)>>$0D)&$FF),(a6)	; 0000 0FED - Scroll Plane B Map Table VRam address
		move.w	#$8500|((($B800)>>$09)&$FF),(a6)	; 0FED CBA9 / 0FED CBA0 (20 H-resol) - Sprite Plane Map Table VRam address
		move.w	#$8600|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8700|$20,(a6)				; 00PP CCCC - Backdrop Colour: Palette Line | Colour ID
		move.w	#$8800|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8900|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8A00|$DF,(a6)				; 7654 3210 - H-Interrupt Register
		move.w	#$8B00|%00000011,(a6)			; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)
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

		moveq	#$00,d0					; clear d0

		lea	(IN_VariableRAM).l,a1			; load variable RAM address
		move.w	#($1000/$04)-1,d7			; set size of RAM to clear

IN_ClearVars:
		move.l	d0,(a1)+				; clear RAM
		dbf	d7,IN_ClearVars				; repeat til done
		lea	(IN_HeadScrolls).l,a1			; load variable RAM address
		move.w	#($0400/$04)-1,d7			; set size of RAM to clear

IN_ClearHeadScroll:
		move.l	d0,(a1)+				; clear RAM
		dbf	d7,IN_ClearHeadScroll			; repeat til done

	; --- Loading data ---

		moveq	#$20,d2					; write to VRAM address 0020
		lea	(Art_Head).l,a1				; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping

		move.w	#$2220,d2				; write to VRAM address 2220
		lea	(Art_PlaneSTH).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping

	; --- Decompress Kos Module data

IN_DelayLoad:
		move.b	#2,(V_int_routine).w
		jsr	Process_Kos_Queue
		jsr	Wait_VSync
		jsr	Process_Kos_Module_Queue.w
		tst.l	(Kos_module_queue).w
		bne.s	IN_DelayLoad

		move.b	#2,(V_int_routine).w		; needed to finish decompression
		jsr	Wait_VSync

	; ---- Loading more data ---

		move	#$2700,sr				; disable interrupts
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.l	#HB_Intro,(H_int_addr).w		; set H-blank routine
		move.l	#VB_Intro,(V_int_addr).w		; set V-blank routine

		lea	($00FF0000).l,a1			; load dump address
		lea	(Map_PlaneSTH).l,a0			; load enigma compressed mappings address
		jsr	Kos_Decomp				; decompress and dump to RAM
		move.l	#$01000000,d3				; set line advance amount
		lea	($00FF0000).l,a1			; load mappings address
		move.l	#$40000003,d0				; set VDP mode/address (C000)
		moveq	#$80-1,d1				; set width
		moveq	#$1C-1,d2				; set height
		jsr	SZ_MapScreen				; dump mappings

		lea	(IN_IdentMap_MJ).l,a1			; load dump address
		lea	(Map_LogoMJ).l,a0			; load kosinski mappings
		jsr	Kos_Decomp				; decompress and dump to RAM
		lea	(IN_IdentMap_NS).l,a1			; load dump address
		lea	(Map_LogoNS).l,a0			; load kosinski mappings
		jsr	Kos_Decomp				; decompress and dump to RAM

		move.l	#$00D00000,(V_scroll_value).w		; set v-scroll start position

		lea	(Target_palette).w,a1			; load main palette buffer
		move.w	#($0080/$04)-1,d7			; set number of colours to flush
		moveq	#$00,d0					; clear d0

IN_ClearPal:
		move.l	d0,(a1)+				; clear palette
		dbf	d7,IN_ClearPal				; repeat for number of colours

		move.l	#$76800002,(a6)				; set VDP address to zig-zag art
		moveq	#$FF,d1					; set to draw solid tiles where the art is to be redraw for sprites (hidden)
		moveq	#($80/$04)-1,d7				; size of hidden art tiles

IN_LoadHidden:
		move.l	d1,(a5)					; set hidden tiles
		dbf	d7,IN_LoadHidden			; repeat til all written

		bsr.w	IN_SetupSprites				; setup the static sprites

	; --- Clearing ---

		moveq	#$00,d0					; clear d0
		lea	(H_scroll_buffer).w,a1			; load h-scroll buffer
		move.w	#($0400/$04)-1,d7			; set size to clear

IN_ClearHScroll:
		move.l	d0,(a1)+				; clear h-scroll
		dbf	d7,IN_ClearHScroll			; repeat til done

		lea	(IN_IdentMap_BL).l,a1			; load blank mappings to clear
		move.w	#($0400/$04)-1,d7			; set size to clear

IN_ClearMapBL:
		move.l	d0,(a1)+				; clear blank mappings
		dbf	d7,IN_ClearMapBL			; repeat til all cleared

	; --- Finalising ---

		move.l	#NTE_Start,(IN_EventsRout).l		; set next routine
		move.w	#($4400+($08*2))+IN_STARTSCROLL,(IN_ScrollPos).l ; set starting scroll X position

IN_RenderTiles:
		subq.w	#$08,(IN_ScrollPos).l			; move scroll position left
		bsr.s	IN_SubroutNoEvents			; run subroutines
		bsr.w	VBIN_WriteArt				; update tile art for the sprites
		bsr.w	VBIN_WritePlane				; update "SONIC THE HEDGEHOG" mappings correctly
		cmpi.w	#$4000+IN_STARTSCROLL,(IN_ScrollPos).l	; has it scrolled enough to render all tiles in the plane?
		bgt.s	IN_RenderTiles				; if not, branch and keep rendering til done
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port

; ---------------------------------------------------------------------------
; New Title Main Loop
; ---------------------------------------------------------------------------

	; --- Running intro effect ---

ML_Intro:
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank
		bsr.s	IN_Subroutines				; run subroutines
		tst.b	(Ctrl_1_pressed).w			; was start button pressed?
		bpl.s	MLIn_NoStart				; if not, branch
		move.b	#$58,(Game_mode).w			; change to title screen

MLIn_NoStart:
		cmpi.b	#$54,(Game_mode).w			; is the game mode still set to 20 (New Title)?
		beq.s	ML_Intro				; if so, branch
		rts						; return

; ---------------------------------------------------------------------------
; Subroutines for New Title
; ---------------------------------------------------------------------------

IN_Subroutines:
		bsr.w	IN_BlendPalette				; blend the palette gradually towards main
		bsr.w	IN_Events				; run events routines

IN_SubroutNoEvents:
		bsr.w	IN_WriteScroll				; write the scroll position values
						; continue to..	; write sprite data correctly for effect

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write make the sprites correctly
; ---------------------------------------------------------------------------

IN_WriteSprites:
		movea.w	(IN_SpriteAdd).l,a1			; load sprite buffer address
		move.b	(IN_SpritePri).l,d4			; load sprite priority staring ID
		lea	(H_scroll_buffer+$0200).w,a2		; load H-scroll buffer list
		move.w	#$0080,d1				; prepare starting Y position
		move.w	#$8300,d3				; prepare starting VRAM/pattern index address
		moveq	#$07-1,d7				; set number of lines of sprites to create vertically

NTWS_NextY:
		moveq	#$04-1,d6				; set number of sprites to create horizontally
		move.w	(a2),d0					; load scroll position
		move.w	d0,d2					; copy to d2 as pattern index
		not.w	d2					; reverse direction (plus 1)
		lsr.w	#$01,d2					; divide to x4 (4 tiles per line)
		andi.w	#$003C,d2				; keep within range of sprite art
		move.w	d2,d5					; store in d5 (for the Zig-zag)
		andi.w	#$0007,d0				; wrap within 8 pixels
		addi.w	#$0078,d0				; advance to starting X position
		tst.w	d7					; is this the last line of sprites?
		beq.s	NTWS_LastPiece				; if so, branch (There is no Sonic head art on the last line, only zig-zag)

NTWS_NextX:
		move.w	d1,(a1)+				; write Y position
		move.b	#$0F,(a1)+				; write shape
		tst.w	d6					; is this the last sprite in the row?
		bne.s	NTWS_NotRightPiece			; if not, branch
		move.b	#$0B,-$01(a1)				; change shape to smaller piece (may as well save SOME sprite pixel space)

NTWS_NotRightPiece:
		addq.b	#$01,d4					; increase priority link ID
		move.b	d4,(a1)+				; write priority
		move.w	d2,(a1)					; write pattern index value
		add.w	d3,(a1)+				; add root index position
		addi.w	#$0010,d2				; advance pattern index to next art sprite piece position (every "F" piece)
		andi.w	#$003C,d2				; wrap within art section
		move.w	d0,(a1)+				; write X position
		addi.w	#$0020,d0				; move right for next sprite
		dbf	d6,NTWS_NextX				; repeat for all sprites on X
		addi.w	#(($800+$180)/$20),d3			; advance to zig-zag art
		bra.s	NTWS_ZigZag				; continue

NTWS_LastPiece:
		addi.w	#$0020*4,d0				; reposition X to the Zig-zag (no head sprites were drawn, so X position didn't automatically move over)

NTWS_ZigZag:
		move.w	d1,(a1)+				; write Y position
		move.b	#$0B,(a1)+				; write shape
		addq.b	#$01,d4					; increase priority link ID
		move.b	d4,(a1)+				; write priority
		andi.w	#$000C,d5				; wrap within zig-zag art section
		addi.w	#$2004,d5				; adjust (and change palette line)
		move.w	d5,(a1)					; write pattern index value
		add.w	d3,(a1)+				; add root index position
		addi.w	#$0060,d0				; advance X position to the Zig-zag area
		move.w	d0,(a1)+				; write X position
		addi.w	#$0020,d1				; move down for next row of sprites
		addi.w	#($380/$20),d3				; advance to next section of art
		lea	$20*2(a2),a2				; advance scroll buffer down a section
		dbf	d7,NTWS_NextY				; repeat for number of sprite colours to write
		moveq	#$00,d0					; clear last sprite
		move.l	d0,(a1)					; ''
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the scroll positions properly
; ---------------------------------------------------------------------------

IN_WriteScroll:
		lea	(H_scroll_buffer+$0200).w,a1		; load H-scroll buffer
		move.w	(IN_ScrollPos).l,d0			; load scroll position
		swap	d0					; ''
		move.w	(IN_ScrollPos).l,d0			; ''
		move.w	#($00A0/$02)-1,d7			; set size of "SONIC" section

NTWS_Sonic:
		move.l	d0,(a1)+				; write scroll position
		dbf	d7,NTWS_Sonic				; repeat til done
		move.w	#$0140,d1				; set number of pixels to reposition bottom half by
		neg.w	d0					; change position for "THE HEDGEHOG" section
		sub.w	d1,d0					; ''
		swap	d0					; ''
		neg.w	d0					; ''
		sub.w	d1,d0					; ''
		move.w	#($0040/$02)-1,d7			; set size of "THE HEDGEHOG" section

NTWS_TheHedgehog:
		move.l	d0,(a1)+				; write scroll position
		dbf	d7,NTWS_TheHedgehog			; repeat til done
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to run and control the letters in a specific way (i.e. events)
; ---------------------------------------------------------------------------

IN_Events:
		move.l	(IN_EventsRout).l,a0			; load events routine
		jmp	(a0)					; run that routine

; ---------------------------------------------------------------------------
; Events - Startup/init/setup
; ---------------------------------------------------------------------------

NTE_Start:
		move.l	#NTE_Scroll,(IN_EventsRout).l		; set next routine
		move.w	#$0002,(IN_EventsCount).l		; reset counter
		move.w	#$0004,(IN_PalFadeTimer).l		; set fade timer

NTE_SetTime:
		move.w	#$0068,(IN_EventsTime).l		; set delay time before starting

NTE_Finish:
		rts						; return

; ---------------------------------------------------------------------------
; Events - Scrolling in
; ---------------------------------------------------------------------------

NTE_Scroll:
		subq.w	#$01,(IN_ScrollPos).l			; scroll plane left
		subq.w	#$01,(IN_EventsTime).l			; decrease timer
		bpl.s	NTE_Finish				; if still running, branch
		subq.w	#$01,(IN_EventsCount).l			; decrease counter
		bmi.s	NTES_LoadNew				; if no longer running, branch
		lea	(Pal_TitleIntro).l,a0			; load grey palette
		lea	(Normal_palette).w,a1			; load main palette buffer
		move.w	#($0040/$04)-1,d7			; set number of colours to flush

NTES_LoadGrey:
		move.l	(a0)+,(a1)+				; copy colours over
		dbf	d7,NTES_LoadGrey			; repeat for number of colours
		bra.s	NTE_SetTime				; continue and set timer again

NTES_LoadNew:
		move.w	#$0002,(IN_PalFadeTimer).l		; set fade timer
		lea	(Pal_TitleIntro+$40).l,a0		; load grey palette
		lea	(Target_palette).w,a1			; load main palette buffer
		move.w	#($0080/$04)-1,d7			; set number of colours to flush

NTES_LoadFull:
		move.l	(a0)+,(a1)+				; copy colours over
		dbf	d7,NTES_LoadFull			; repeat for number of colours
		move.l	#NTE_Head,(IN_EventsRout).l		; set next routine
		move.w	#$0040,(IN_EventsTime).l		; set delay time

; ---------------------------------------------------------------------------
; Events - Scrolling Head Down
; ---------------------------------------------------------------------------

NTE_Head:
		moveq	#((NTSS_HeadSize-NTSS_List)/$08)-1,d7	; set number of "head" sprites to move
		lea	(Sprite_table_buffer).w,a1			; load sprite buffer
		lea	(NTSS_List).l,a0			; load original list

NTE_SetNextHead:
		move.w	(a0),d0					; load original Y position
		addi.w	#$00C0,d0				; get end position
		move.w	(a1),d1					; load Y position
		sub.w	d0,d1					; minus end position
		asr.w	#$04,d1					; divide by 10 (move at 1/10th the distance)
		sub.w	d1,(a1)					; subtract from current position (tis negative value)
		addq.w	#$08,a0					; advance to next sprite
		addq.w	#$08,a1					; ''
		dbf	d7,NTE_SetNextHead			; repeat for all head sprites
		subq.w	#$01,(IN_ScrollPos).l			; scroll plane left
		subq.w	#$01,(IN_EventsTime).l			; decrease timer
		bpl.w	NTE_Finish				; if still running, branch
		move.l	#NTE_IdentMJ,(IN_EventsRout).l		; set next routine
		move.l	#NTE_IdentList,(IN_IdentList).l

; ---------------------------------------------------------------------------
; Events - Ident scroll for MJ
; ---------------------------------------------------------------------------

NTE_IdentMJ:
		subq.w	#$01,(IN_ScrollPos).l			; scroll plane left
		move.l	(IN_IdentAniRout).l,d0			; load animation routine
		beq.s	NTEI_NoAniRout				; if there is no routine to run, branch
		move.l	d0,a0					; set routine address
		jsr	(a0)					; run routine

NTEI_NoAniRout:

		move.l	(IN_IdentList).l,a0			; load list address
		move.l	(a0),a1					; load mappings address from list
		cmpi.l	#IN_IdentMap_BL,a1			; are these blank mappings?
		bne.s	NTE_Normal				; if not, branch
		addq.w	#$06,(IN_IdentScroll).l			; just move it down as quick as possible
		addq.w	#$06,(IN_IdentSprite).l			; ''
		bra.w	NTEI_SlowIdent				; continue normally

NTE_Normal:
		addi.l	#$00008000,(IN_IdentScroll).l		; increase scroll down
		addi.l	#$00008000,(IN_IdentSprite).l		; ''
		move.w	(IN_IdentScroll).l,d0			; load position
		subi.w	#$0078,d0				; subtract start position of "slow section"
		bmi.s	NTEI_ContinueFast			; if we haven't reached the slow down area yet, branch
		tst.b	(IN_IdentFlash).l			; has the flash already occured this ident?
		bne.s	NTEI_NoNewPalette			; if so, branch
		st.b	(IN_IdentFlash).l			; set flash "done" flag
		lea	(Normal_palette+$42).w,a4			; load current palette
		move.l	#$0EEE0EEE,d1				; set white colours
		move.w	d1,(a4)+				; ''
		move.l	d1,(a4)+				; ''
		move.l	d1,(a4)+				; ''
		move.l	d1,(a4)+				; ''
		move.l	d1,(a4)+				; ''
		move.l	d1,(a4)+				; ''
		move.l	d1,(a4)+				; ''
		move.l	d1,(a4)+				; ''

NTEI_NoNewPalette:
		cmpi.w	#$0028,d0				; is the position within the "slow section"?
		blo.s	NTEI_SlowIdent				; if so, branch
		bne.s	NTEI_ContinueFast			; if we're not directly at the end, branch
		tst.b	(IN_IdentFlash).l			; has the flash already occured this ident?
		beq.s	NTEI_ContinueFast			; if not, branch
		subq.w	#$01,(IN_IdentHold).l			; decrease hold timer
		bmi.s	NTEI_ContinueFast			; if finished, branch
		subi.l	#$00008000,(IN_IdentScroll).l		; move ident back (keep in place)
		subi.l	#$00008000,(IN_IdentSprite).l		; ''
		bra.s	NTEI_SlowIdent				; continue normally

NTEI_ContinueFast:
		addq.w	#$06,(IN_IdentScroll).l			; increase scroll down faster
		addq.w	#$06,(IN_IdentSprite).l			; ''

NTEI_SlowIdent:
		bsr.w	IN_DrawIdent				; map it

		lea	(NTSS_IdentSprites).l,a0		; load original sprite list
		lea	(Sprite_table_buffer+(NTSS_IdentSprites-NTSS_List)).w,a1 ; list sprite buffer (starting from ident sprites)
		moveq	#$03-1,d7				; set number of sprites to do (just 3)
		move.w	(IN_IdentSprite).l,d1			; load sprite scroll position
		addi.w	#$0100+$2C,d1				; reposition (wrap around the right screen $100 (not on blanks) & with the plane $2C)

NTES_SetIdentSprites:
		move.w	(a0),d0					; load original Y position
		add.w	d1,d0					; add alignment
		move.w	d0,(a1)					; save to sprite
		addq.w	#$08,a0					; advance to next sprite...
		addq.w	#$08,a1					; ''
		dbf	d7,NTES_SetIdentSprites			; repeat for all sprites

		cmpi.w	#$00E0,(IN_IdentScroll).l		; have we reached far enough to prepare for next ident?
		ble.s	NTEI_WaitIdent				; if not, branch
		subi.w	#$0100,(IN_IdentScroll).l		; wrap back up again
		sf.b	(IN_IdentFlash).l			; clear flash "done" flag
		move.l	(IN_IdentList).l,a3			; load list address
		tst.l	$18(a3)					; are there still entries to do?
		bne.s	NTEI_LoadIdent				; if so, branch
		move.l	#NTE_ScrollOut,(IN_EventsRout).l	; set next routine
		move.w	#$0040,(IN_EventsTime).l		; set timer for heads to move out

NTEI_WaitIdent:
		rts						; return

NTEI_LoadIdent:
		addq.w	#$04,a3					; advance to art
		move.l	(a3)+,(IN_ArtLoadList).l		; set plane art DMA list address
		move.l	(a3)+,(IN_ArtLoadList+$04).l		; set sprite art DMA list address
		move.l	(a3)+,d0				; load palette address
		beq.s	NTEI_NoPalette				; if there is no palette (i.e. blank), branch
		move.l	d0,a0					; set palette address
		lea	(Normal_palette+$40).w,a1		; load buffers
		lea	(Target_palette+$40).w,a1		; ''
		move.l	(a0)+,(a1)				; dump palette for ident
		move.l	(a1)+,(a2)+				; ''
		move.l	(a0)+,(a1)				; ''
		move.l	(a1)+,(a2)+				; ''
		move.l	(a0)+,(a1)				; ''
		move.l	(a1)+,(a2)+				; ''
		move.l	(a0)+,(a1)				; ''
		move.l	(a1)+,(a2)+				; ''
		move.l	(a0)+,(a1)				; ''
		move.l	(a1)+,(a2)+				; ''
		move.l	(a0)+,(a1)				; ''
		move.l	(a1)+,(a2)+				; ''
		move.l	(a0)+,(a1)				; ''
		move.l	(a1)+,(a2)+				; ''
		move.l	(a0)+,(a1)				; ''
		move.l	(a1)+,(a2)+				; ''

NTEI_NoPalette:
		move.l	(a3)+,(IN_IdentAniRout).l		; set animation routine
		move.w	(a3)+,(IN_IdentHold).l			; set time to "hold" the ident in place
		addq.w	#$02,a3					; skip unknown "free" space
		move.l	a3,(IN_IdentList).l			; update list
		rts						; return

; ---------------------------------------------------------------------------
; Ident art/map/palette loading lists
; ---------------------------------------------------------------------------
DMAList		macro	Source, Size, Destination
		dc.l	(((((Size/$02)<<$08)&$FF0000)+((Size/$02)&$FF))+$94009300)
		dc.l	((((((Source&$FFFFFF)/$02)<<$08)&$FF0000)+(((Source&$FFFFFF)/$02)&$FF))+$96009500)
		dc.l	(((((Source&$FFFFFF)/$02)&$7F0000)+$97000000)+((Destination>>$10)&$FFFF))
		dc.w	((Destination&$FF7F)|$80)
		endm
; ---------------------------------------------------------------------------

	;	dc.l	Art plane,	Art sprite,	Palette,	Animation,	Hold | ?,	Mappings

NTE_IdentList:	dc.l											IN_IdentMap_BL		; blank
		dc.l	DMA_LogoMJ,	DMA_SprtMJ,	Pal_LogoMJ,	$00000000,	$00300000,	IN_IdentMap_MJ		; ident 1
		dc.l	$00000000,	$00000000,	$00000000,	$00000000,	$00000000,	IN_IdentMap_BL		; blank
		dc.l	DMA_LogoNS,	DMA_SprtNS,	Pal_LogoNS,	Ani_LogoNS,	$00900000,	IN_IdentMap_NS		; ident 2
		dc.l	$00000000,	$00000000,	$00000000,	$00000000,	$00000000,	IN_IdentMap_BL		; blank
		dc.l	$00000000,	$00000000,	$00000000,	$00000000,	$00000000,	$00000000		; end of list...

DMA_LogoMJ:	DMAList	Art_LogoMJ, (Art_LogoMJ_End-Art_LogoMJ), $5C000003
DMA_SprtMJ:	DMAList	Art_SprtMJ, (Art_SprtMJ_End-Art_SprtMJ), $6C400003
DMA_LogoNS:	DMAList	Art_LogoNS, (Art_LogoNS_End-Art_LogoNS), $5C000003
DMA_SprtNS:	DMAList	Art_SprtNS, (Art_SprtNS_End-Art_SprtNS), $6C400003

; ===========================================================================
; ---------------------------------------------------------------------------
; Natsumi's animation ident routine
; ---------------------------------------------------------------------------

Ani_LogoNS:
		move.l	#DMA_AniNSL_00,(IN_ArtLoadList).l	; set starting frames to load
		move.l	#DMA_AniNSR_00,(IN_ArtLoadList+$04).l	; ''
		move.l	#Ani_LNS_Start,(IN_IdentAniRout).l	; set starting routine
		move.l	#AniNS_R_List,(IN_IdentAniList).l	; set starting list
		clr.w	(IN_IdentAniTime).l			; reset timer
		rts						; return

Ani_LNS_Start:
		bsr.s	Ani_LNS_Control				; run animation routine
		move.l	#Ani_LNS_Second,(IN_IdentAniRout).l	; set next routine
		move.l	#AniNS_L_List,(IN_IdentAniList).l	; set next list

Ani_LNS_Second:
		bsr.s	Ani_LNS_Control				; run animation routine
		clr.l	(IN_IdentAniRout).l			; set no routine
		rts						; return (finish)

Ani_LNS_Control:
		subq.w	#$01,(IN_IdentAniTime).l		; decrease timer
		bpl.s	Ani_LNSC_Delay				; if still running, branch
		move.l	(IN_IdentAniList).l,a0			; load list address
		move.l	(a0)+,d0				; load animation frame DMA pointer
		beq.s	Ani_LNSC_Finish				; if there are no more frames, branch
		move.w	(a0)+,(IN_IdentAniTime).l		; set delay/frame timer
		move.l	a0,(IN_IdentAniList).l			; update list address
		move.l	d0,(IN_ArtLoadList).l			; set art address

Ani_LNSC_Delay:
		addq.w	#$04,sp					; skip return address

Ani_LNSC_Finish:
		rts						; return

; ---------------------------------------------------------------------------
; Animation lists
; ---------------------------------------------------------------------------

	; --- Right Size (Fox Head Peeping) ---

AniNS_R_List:	dc.l	DMA_AniNSR_00				; DMA list pointer
		dc.w	$0060					; frame time/delay
		dc.l	DMA_AniNSR_01
		dc.w	$0002
		dc.l	DMA_AniNSR_02
		dc.w	$0002
		dc.l	DMA_AniNSR_03
		dc.w	$0002
		dc.l	DMA_AniNSR_04
		dc.w	$0002
		dc.l	DMA_AniNSR_05
		dc.w	$0002
		dc.l	DMA_AniNSR_06
		dc.w	$0010
		dc.l	DMA_AniNSR_07
		dc.w	$0003
		dc.l	DMA_AniNSR_08
		dc.w	$0002
		dc.l	DMA_AniNSR_09
		dc.w	$0002
		dc.l	DMA_AniNSR_10
		dc.w	$0003
		dc.l	DMA_AniNSR_11
		dc.w	$0010
		dc.l	DMA_AniNSR_12
		dc.w	$0003
		dc.l	DMA_AniNSR_13
		dc.w	$0002
		dc.l	DMA_AniNSR_14
		dc.w	$0002
		dc.l	DMA_AniNSR_00
		dc.w	$0002
		dc.l	$00000000

DMA_AniNSR_00:	DMAList	(AniNS_Right+($0140*00)), $0140, $68400003
DMA_AniNSR_01:	DMAList	(AniNS_Right+($0140*01)), $0140, $68400003
DMA_AniNSR_02:	DMAList	(AniNS_Right+($0140*02)), $0140, $68400003
DMA_AniNSR_03:	DMAList	(AniNS_Right+($0140*03)), $0140, $68400003
DMA_AniNSR_04:	DMAList	(AniNS_Right+($0140*04)), $0140, $68400003
DMA_AniNSR_05:	DMAList	(AniNS_Right+($0140*05)), $0140, $68400003
DMA_AniNSR_06:	DMAList	(AniNS_Right+($0140*06)), $0140, $68400003
DMA_AniNSR_07:	DMAList	(AniNS_Right+($0140*07)), $0140, $68400003
DMA_AniNSR_08:	DMAList	(AniNS_Right+($0140*08)), $0140, $68400003
DMA_AniNSR_09:	DMAList	(AniNS_Right+($0140*09)), $0140, $68400003
DMA_AniNSR_10:	DMAList	(AniNS_Right+($0140*10)), $0140, $68400003
DMA_AniNSR_11:	DMAList	(AniNS_Right+($0140*11)), $0140, $68400003
DMA_AniNSR_12:	DMAList	(AniNS_Right+($0140*12)), $0140, $68400003
DMA_AniNSR_13:	DMAList	(AniNS_Right+($0140*13)), $0140, $68400003
DMA_AniNSR_14:	DMAList	(AniNS_Right+($0140*14)), $0140, $68400003

	; --- Left Side (Main Fox) ---

AniNS_L_List:	dc.l	DMA_AniNSL_00				; DMA list pointer
		dc.w	$0008					; frame time/delay
		dc.l	DMA_AniNSL_01
		dc.w	$0002
		dc.l	DMA_AniNSL_02
		dc.w	$0002
		dc.l	DMA_AniNSL_03
		dc.w	$0002
		dc.l	DMA_AniNSL_04
		dc.w	$0002
		dc.l	DMA_AniNSL_05
		dc.w	$0002
		dc.l	DMA_AniNSL_06
		dc.w	$0002
		dc.l	DMA_AniNSL_07
		dc.w	$0002
		dc.l	DMA_AniNSL_08
		dc.w	$0003
		dc.l	DMA_AniNSL_09
		dc.w	$0003
		dc.l	DMA_AniNSL_10
		dc.w	$0003
		dc.l	DMA_AniNSL_11
		dc.w	$0000
		dc.l	$00000000

DMA_AniNSL_00:	DMAList	AniNS_Left+($0720*00), $0720, $61200003
DMA_AniNSL_01:	DMAList	AniNS_Left+($0720*01), $0720, $61200003
DMA_AniNSL_02:	DMAList	AniNS_Left+($0720*02), $0720, $61200003
DMA_AniNSL_03:	DMAList	AniNS_Left+($0720*03), $0720, $61200003
DMA_AniNSL_04:	DMAList	AniNS_Left+($0720*04), $0720, $61200003
DMA_AniNSL_05:	DMAList	AniNS_Left+($0720*05), $0720, $61200003
DMA_AniNSL_06:	DMAList	AniNS_Left+($0720*06), $0720, $61200003
DMA_AniNSL_07:	DMAList	AniNS_Left+($0720*07), $0720, $61200003
DMA_AniNSL_08:	DMAList	AniNS_Left+($0720*08), $0720, $61200003
DMA_AniNSL_09:	DMAList	AniNS_Left+($0720*09), $0720, $61200003
DMA_AniNSL_10:	DMAList	AniNS_Left+($0720*10), $0720, $61200003
DMA_AniNSL_11:	DMAList	AniNS_Left+($0720*11), $0720, $61200003

; ---------------------------------------------------------------------------
; Events - Scrolling items out
; ---------------------------------------------------------------------------

NTE_ScrollOut:
		subq.w	#$01,(IN_ScrollPos).l			; scroll plane left
		cmpi.w	#$3D80,(IN_ScrollPos).l
		beq.s	NTE_StopScroll
		subq.w	#$01,(IN_EventsTime).l			; decrease heads timer
		bmi.w	NTE_Finish2				; if finished, branch
		moveq	#((NTSS_HeadSize-NTSS_List)/$08)-1,d7	; set number of "head" sprites to move
		lea	(Sprite_table_buffer+$06).w,a1		; load sprite buffer
		lea	(IN_HeadScrolls).l,a0			; load original list

NTE_ShiftNextHead:
		move.l	(a0),d0					; load speed
		addi.l	#$00001000,d0				; increase speed
		move.l	d0,(a0)+				; update speed
		sub.l	d0,(a0)					; subtract from X position
		move.w	(a0)+,(a1)				; save to sprite X position
		addq.w	#$02,a0					; advance to next sprite
		addq.w	#$08,a1					; ''
		dbf	d7,NTE_ShiftNextHead			; repeat for all head sprites
		rts						; return

NTE_StopScroll:
		move.l	#NTE_Final,(IN_EventsRout).l		; set next routine

		; --- making last palette white, so the zig-zag is white ---

		lea	(Target_palette+$60).w,a0		; load palette buffers
		lea	(Normal_palette+$60).w,a1			; ''
		move.l	#$0EEE0EEE,d0				; prepare white colour
		move.l	d0,(a0)+				; set entire palette line to white
		move.l	d0,(a1)+				; ''
		move.l	d0,(a0)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a0)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a0)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a0)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a0)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a0)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a0)+				; ''
		move.l	d0,(a1)+				; ''

		clr.w	(V_scroll_value).w			; clear FG's vertical scroll position (so it's in alignment)

		; --- making head area mappings use line 1 again ---

		move.w	#$8000|($2220/$20),d2			; prepare blank tile of line 1
		move.w	d2,d1					; ''
		swap	d1					; ''
		move.w	d2,d1					; ''
		moveq	#$1C-1,d7				; set number of lines to do
		move.l	#$60000003,d2				; prepare VDP VRAM write mode (address of Plane A)

NTE_ClearMapNext:
		move.l	d2,(a6)					; set VDP address
		addi.l	#$01000000,d2				; advance to next line
		move.l	d1,(a5)					; change tiles
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		dbf	d7,NTE_ClearMapNext			; repeat til all done

		st.b	(IN_ScrollZigZag).l			; enable zig-zag blank tile rendering (must be done in V-blank)

NTE_Finish2:
		rts						; return

; ---------------------------------------------------------------------------
; Events - Final stuff before finishing...
; ---------------------------------------------------------------------------

NTE_Final:
		tst.b	(IN_ScrollZigZag).l			; is zig-zag still enabled?
		bne.s	NTE_Finish2				; if so, branch and wait
	move.b	#$58,(Game_mode).w			; change game mode
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; redrawing blank tiles on the plane as the zig-zag scrolls out (done in V-blank)
; ---------------------------------------------------------------------------

VBIN_ScrollZigZag:
		lea	(Sprite_table_buffer+(NTSS_ZigZag-NTSS_List)+$04).w,a1	; load sprite buffer (starting from zig-zag)
		move.w	#((NTSS_List_End-NTSS_ZigZag)/$08)-1,d7		; set number of zig-zag sprites to move
		lea	(IN_HeadScrolls+(NTSS_ZigZag-NTSS_List)).l,a0	; load original list
		move.w	#$A000|($2220/$20),d2			; prepare blank tiles
		move.w	d2,d1					; ''
		swap	d1					; ''
		move.w	d2,d1					; ''
		move.w	#$E000,d3				; prepare tile high plane + palette line 2

NTEF_MoveZigZag:
		move.l	(a0),d0					; load speed
		cmpi.l	#$00030000,d0				; is it moving fast enough for fade out?
		bne.s	NTEF_NoFadeOut				; if not, branch
	move.w	#$0000,(Target_palette+$22).w		; set colour to fade out to
	move.w	#$0002,(IN_PalFadeTimer).l		; set fade timer

NTEF_NoFadeOut:
		cmpi.l	#$00080000,d0				; is it moving at the fastest speed?
		beq.s	NTEF_NoSpeedUp				; if so, branch
		addi.l	#$00002000,d0				; increase speed

NTEF_NoSpeedUp:
		move.l	d0,(a0)+				; update speed
		sub.l	d0,(a0)					; subtract from X position
		or.w	d3,(a1)+				; set sprite to high plane and at palette line 2
		move.w	(a0),(a1)				; save to sprite X position
		move.w	(a0)+,d0				; load position
		cmpi.w	#$0060,d0				; has the sprite moved out fully?
		bgt.s	NTEF_NoStop				; if not, branch
		sf.b	(IN_ScrollZigZag).l			; disable zig-zag

NTEF_NoStop:
		subi.w	#$0078,d0				; align to zig-zag
		lsr.w	#$02,d0					; divide to x2 (word for map)
		andi.w	#$00FE,d0				; get only the line
		move.w	d7,d2					; load sprite counter
		ror.w	#$06,d2					; multiply by 400
		andi.w	#$3F00,d2				; keep within VRAM plane space
		or.w	d2,d0					; fuse with tile position
		ori.w	#$6000,d0				; set modes/registers
		swap	d0					; align for VDP
		move.w	#$0003,d0				; set final address settings
		moveq	#$04-1,d6				; set number of lines per sprite to blank out

NTEF_NextTiles:
		move.l	d0,(a6)					; set VDP address
		addi.l	#$01000000,d0				; advance to next line
		move.l	d1,(a5)					; blank tiles out
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		dbf	d6,NTEF_NextTiles			; repeat for all sprite sized number of tiles
		addq.w	#$02,a0					; advance to next sprite
		addq.w	#$06,a1					; ''
		dbf	d7,NTEF_MoveZigZag			; repeat til all sprites are moved
		sf.b	-$09(a1)				; clear link (all sprites after will disappear)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw "ident" mappigns as the screen scrolls
; ---------------------------------------------------------------------------

IN_DrawIdent:
		move.w	(IN_IdentScroll).l,d0			; load ident position
		neg.w	d0					; reverse
		addi.w	#$00D0,d0				; advance to actual VSRAM position
		move.w	d0,(V_scroll_value).w			; save for VSRAM
		move.w	(IN_IdentScroll).l,d0			; load ident position
		andi.w	#$00F8,d0				; keep within every 8 pixels
		neg.w	d0					; reverse it
		addi.w	#$0048,d0				; start from the bottom and draw upwards
		move.w	d0,d1					; store in d1
		cmpi.w	#$0A*$08,d0				; are we drawing outside the range?
		bhs.s	NTDI_NoMap				; if so, branch
		lsl.w	#$05,d0					; multiply to x100 (a VRAM tile line)
		add.w	#$701E,d0				; add starting VRAM address
		swap	d0					; align for VDP port
		move.w	#$0003,d0				; set remaining register values
		lsr.w	#$02,d1					; divide position by 8 then multiply by 2
		mulu.w	#$15,d1					; multiply by X size of the ident
		adda.w	d1,a1					; advance to start of the mappings
		moveq	#$15-1,d1				; set width
		moveq	#$01-1,d2				; set height (ONLY 1 LINE AT A TIME!!)
		jmp	SZ_MapScreen				; dump mappings

NTDI_NoMap:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to blend colours from current to main
; ---------------------------------------------------------------------------

IN_BlendPalette:
		subq.w	#$01,(IN_PalBlendFade).l		; decrease delay counter
		bpl.s	NTBP_Delay				; if still counting, branch
		move.w	(IN_PalFadeTimer).l,(IN_PalBlendFade).l	; reset delay counter
		lea	(Target_palette).w,a0			; load main palette
		lea	(Normal_palette).w,a1			; load current palette buffer
		moveq	#($80/$02)-1,d7				; set number of colours to fade/blend

NTBP_NextColour:
		move.b	(a1),d0					; load current blue
		cmp.b	(a0)+,d0				; has it reached the main palette?
		beq.s	NTBP_MatchBlue				; if so, branch
		bcc.s	NTBP_BlueDown				; if blue needs to move down, branch
		addq.b	#$02*2,d0				; move blue up

NTBP_BlueDown:
		subq.b	#$02,d0					; move blue down

NTBP_MatchBlue:
		move.b	d0,(a1)+				; update current blue
		move.b	(a1),d0					; load current green and red
		move.w	d0,d1					; copy to d1
		andi.w	#$00E0,d0				; get green
		andi.w	#$000E,d1				; get red
		move.b	(a0)+,d2				; load main green and red
		move.w	d2,d3					; copy to d3
		andi.w	#$00E0,d2				; get green
		andi.w	#$000E,d3				; get red

		cmp.w	d2,d0					; has the green reached the main palette?
		beq.s	NTBP_MatchGreen				; if so, branch
		bcc.s	NTBP_GreenDown				; if the green needs to move down, branch
		addi.b	#$20*2,d0				; move green up

NTBP_GreenDown:
		subi.b	#$20,d0					; move green down

NTBP_MatchGreen:
		cmp.w	d3,d1					; has the red reached the main palette?
		beq.s	NTBP_MatchRed				; if so, branch
		bcc.s	NTBP_RedDown				; if the red needs to move down, branch
		addq.b	#$02*2,d1				; move red up

NTBP_RedDown:
		subq.b	#$02,d1					; move red down

NTBP_MatchRed:
		or.b	d1,d0					; fuse red to green
		move.b	d0,(a1)+				; update green and red
		dbf	d7,NTBP_NextColour			; repeat for all colours in the buffer

NTBP_Delay:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup the "static" sprites
; ---------------------------------------------------------------------------

IN_SetupSprites:
		lea	(IN_HeadScrolls+$04).l,a2		; load original list

		lea	(Sprite_table_buffer).w,a1			; load the sprite buffer
		move.w	#((NTSS_List_End-NTSS_List)/$08)-1,d7	; set size of list
		lea	NTSS_List(pc),a0			; load list
		moveq	#$00,d1					; reset sprite priority link ID

NTSS_Load:
		move.l	(a0)+,d0				; load Y position and shape
		addq.b	#$01,d1					; increase sprite priority ID
		move.b	d1,d0					; set sprite priority ID
		move.l	d0,(a1)+				; save to sprite buffer
		move.l	(a0)+,(a1)+				; save VRAM and X position
		move.w	-$02(a0),(a2)				; save original X position
		addq.w	#$08,a2					; advance to next position
		dbf	d7,NTSS_Load				; repeat for all sprites in the list
		move.b	d1,(IN_SpritePri).l			; store starting priority ID
		move.w	a1,(IN_SpriteAdd).l			; store sprite buffer address
		rts						; return

NTSS_List:
		dc.w	$0080-$C0,$0700,$0009,$0080		; Sonic's Head/Logo
		dc.w	$0088-$C0,$0E00,$0011,$0090
		dc.w	$0098-$C0,$0500,$001D,$00B0
		dc.w	$00A0-$C0,$0700,$0029,$0080
		dc.w	$00A8-$C0,$0E00,$0031,$00B0
		dc.w	$00A8-$C0,$0F00,$003D,$00D0
		dc.w	$00C8-$C0,$0E00,$004D,$00D0
		dc.w	$00C0-$C0,$0F00,$0059,$00B0
		dc.w	$00C0-$C0,$0D00,$0069,$0090
		dc.w	$00C0-$C0,$0700,$0079,$0080
		dc.w	$00E0-$C0,$0F00,$0089,$0080
		dc.w	$00E0-$C0,$0F00,$0099,$00B8
		dc.w	$00E0-$C0,$0700,$00A9,$00D8
		dc.w	$0100-$C0,$0100,$00B1,$00E0
		dc.w	$0100-$C0,$0F00,$00B3,$00C0
		dc.w	$0110-$C0,$0600,$00C3,$00B0
		dc.w	$0118-$C0,$0F00,$00C9,$0090
		dc.w	$0100-$C0,$0100,$00D9,$0090
		dc.w	$0100-$C0,$0700,$00E3,$0080
		dc.w	$0120-$C0,$0700,$00F3,$0080
		dc.w	$0138-$C0,$0C00,$00FB,$0090
		dc.w	$0120-$C0,$0C00,$00FF,$00C0
		dc.w	$0128-$C0,$0E00,$0103,$00B0
		dc.w	$0118-$C0,$0100,$010F,$00E0
		dc.w	$00A0-$C0,$0F00,$0021,$0090

NTSS_HeadSize:

NTSS_IdentSprites:
		dc.w	$00C4-$C0,$0B00,($C000|($EC40/$20))+$0000,$0160		; ident/splash sprites
		dc.w	$00E4-$C0,$0B00,($C000|($EC40/$20))+$000C,$0160
		dc.w	$0104-$C0,$0900,($C000|($EC40/$20))+$0018,$0160

NTSS_ZigZag:	dc.w	$0080,$0B00,$05B4,$0158			; Zig-Zag Bar
		dc.w	$00A0,$0B00,$05B4,$0158
		dc.w	$00C0,$0B00,$05B4,$0158
		dc.w	$00E0,$0B00,$05B4,$0158
		dc.w	$0100,$0B00,$05B4,$0158
		dc.w	$0120,$0B00,$05B4,$0158
		dc.w	$0140,$0B00,$05B4,$0158
NTSS_List_End:	even

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank routine (Standard)
; ---------------------------------------------------------------------------

VB_Intro:
		tst.b	(V_int_routine).w			; was the 68k late?
		beq.w	VBIN_68kLate				; if so, branch

		movem.l	d0-a4,-(sp)				; store register data
		tst.b	(IN_ScrollZigZag).l			; is the zig-zag scrolling out yet?
		beq.s	VBIN_NoScroll				; if not, branch
		jsr	VBIN_ScrollZigZag			; hand redrawing of plane/sprite movement (must be done by V-blank)

VBIN_NoScroll:
		DMA_SP	$0080, Normal_palette, $C0000000		; palette
		DMA_SP	$0280, Sprite_table_buffer, $78000002	; sprites

		move.w	#$8F00|$04,(a6)				; set auto-increment for H-scroll cell mode
		DMA_SP	$01C0, H_scroll_buffer, $7C000002	; h-scroll (FG)
		DMA_SP	$01C0, H_scroll_buffer+$0200, $7C020002	; h-scroll (BG)
		move.w	#$8F00|$02,(a6)				; restore increment
		move.l	#$40000010,(a6)				; v-scroll
		move.l	(V_scroll_value).w,(a5)		; ''

		bsr.w	VBIN_WriteZigZag			; update zig-zag art

		tst.b	(IN_ScrollZigZag).l			; is the zig-zag scrolling out yet?
		bne.w	NTEI_NoSpriteArt			; if so, branch

		bsr.s	VBIN_WriteArt				; update tile art for the sprites
		bsr.w	VBIN_WritePlane				; update "SONIC THE HEDGEHOG" mappings correctly

		lea	(IN_ArtLoadList).l,a2			; load art list pointers
		move.l	(a2)+,d0				; load first art list
		beq.s	NTEI_NoPlaneArt				; if it's blank, branch
		clr.l	-$04(a2)				; clear list
		move.l	d0,a0					; set pointer
		move.l	(a0)+,(a6)				; set DMA to transfer the art
		move.l	(a0)+,(a6)				; ''
		move.l	(a0)+,(a6)				; ''
		move.w	(a0)+,(a6)				; ''

NTEI_NoPlaneArt:
		move.l	(a2),d0					; load compressed art
		beq.s	NTEI_NoSpriteArt			; if it's blank, branch
		clr.l	(a2)					; clear list
		move.l	d0,a0					; load nemesis plane art
		move.l	(a0)+,(a6)				; set DMA to transfer the art
		move.l	(a0)+,(a6)				; ''
		move.l	(a0)+,(a6)				; ''
		move.w	(a0)+,(a6)				; ''

NTEI_NoSpriteArt:
		movem.l	(sp)+,d0-a4				; restore register data

; ---------------------------------------------------------------------------
; V-blank routine (No-VDP access)
; ---------------------------------------------------------------------------

VBIN_68kLate:
		move.w	(sp)+,-$06(sp)				; copy sr back
		pea	VBO_Intro(pc)				; force new return address
		subq.w	#$02,sp					; move back to sr space
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to update tile art for the sprites
; ---------------------------------------------------------------------------

NTWA_StripList:	dc.l	Art_Strip01				; Starting address
		dc.w	$2800					; New cap size (this saves us A800 bytes in total)
		dc.l	Art_Strip02
		dc.w	$2800
		dc.l	Art_Strip03
		dc.w	$2700
		dc.l	Art_Strip04
		dc.w	$2800
		dc.l	Art_Strip05
		dc.w	$2800
		dc.l	Art_Strip06
		dc.w	$2880
		dc.l	Art_Strip07
		dc.w	$2880

VBIN_WriteArt:

	; --- Sonic HEAD logo ---

		lea	(H_scroll_buffer+$0200).w,a1		; load H-scroll buffer
		lea	(IN_PrevPosArt).l,a2			; load previous positions value
		lea	(NTWA_StripList).l,a3			; load stip art pointers list
		move.w	#$6000,d4				; set starting VRAM address
		moveq	#$06-1,d7				; set number of strips to do

NTWA_NextSet:
		move.l	(a3)+,a0				; load strip art list
		move.w	(a3)+,d6				; load cap size
		move.w	(a1),d0					; load position
		moveq	#$00,d2					; clear d2 (long-word clear due to VDP port)
		neg.w	d0					; reverse
		move.w	d0,d2					; copy position to d2
		addi.w	#$0078,d0				; advance to correct strip art position
		andi.w	#$FFF8,d0				; keep within each tile
		cmp.w	(a2)+,d0				; has the position changed?
		beq.w	NTWA_NoChange				; if not, branch
		bcc.s	NTWA_DrawLeft				; if it's moving the plane right, branch to draw left
		subi.w	#$0078,d0				; revert position back again (coming from the left now)
		addq.w	#$08,d2					; correct position accordingly

NTWA_DrawLeft:
		lsl.w	#$04,d0					; multiply to x80 (4 tiles)
		andi.w	#$3F80,d0				; keep within the strip's set
		adda.w	d0,a0					; advance to correct tiles
		cmp.w	d6,d0					; is the position passed the cap?
		blt.s	NTWA_NoCap				; if not, branch
		lea	(Art_Strip01).l,a0			; load beginning of strip 1 (which conveniently has blank tiles)

NTWA_NoCap:

		; getting VDP write address

		subi.w	#$0088,d2				; align to position in VRAM (where the art is to be dumped)
		lsl.w	#$04,d2					; multiply to x80 (4 tiles)
		andi.w	#$0780,d2				; wrap within the art's sprite section (do not exceed...)
		move.l	d2,d3					; copy long-word (for a second line if needed)
		add.w	d4,d2					; add starting VRAM address
		lsl.l	#$02,d2					; convert for VDP port
		lsr.w	#$02,d2					; ''
		ori.w	#$4000,d2				; ''
		swap	d2					; ''
		move.l	d2,(a6)					; set VDP address/mode
		bsr.w	NTWA_WriteTiles				; flush the tiles
		cmpi.w	#$0180,d3				; is this one of the first three lines?
		bge.s	NTWA_NoChange				; if not, branch

		; Second line to draw (making a copy for the end sprite)

		lea	-$80(a0),a0				; go back to start of art line again
		addi.w	#$0800,d3				; advance to the end where the last sprite will overflow/overread
		add.w	d4,d3					; add starting VRAM address
		lsl.l	#$02,d3					; convert for VDP port
		lsr.w	#$02,d3					; ''
		ori.w	#$4000,d3				; ''
		swap	d3					; ''
		move.l	d3,(a6)					; set VDP address/mode
		bsr.w	NTWA_WriteTiles				; flush the tiles

NTWA_NoChange:
		lea	$20*2(a1),a1				; advance scroll buffer down a section
		addi.w	#$0800+$180+$380,d4			; advance to next section
		dbf	d7,NTWA_NextSet				; repeat for number of sections available

	; --- Zig-Zag ---

		lea	(H_scroll_buffer+$0200).w,a1		; load H-scroll buffer
		lea	(IN_PrevPosArt).l,a2			; load previous positions value
		lea	(NTWA_StripList).l,a3			; load stip art pointers list
		move.w	#$6000+$0800+$180,d4			; set starting VRAM address
		moveq	#$07-1,d7				; set number of strips to do

NTWAZZ_NextSet:
		move.l	(a3)+,a0				; load strip art list
		move.w	(a3)+,d6				; load cap size
		move.w	(a1),d0					; load position
		moveq	#$00,d2					; clear d2 (long-word clear due to VDP port)
		neg.w	d0					; reverse
		move.w	d0,d2					; copy position to d2
		addi.w	#$0078,d0				; advance to correct strip art position
		andi.w	#$FFF8,d0				; keep within each tile
		cmp.w	(a2)+,d0				; has the position changed?
		beq.w	NTWAZZ_NoChange				; if not, branch
		bcc.s	NTWAZZ_DrawLeft				; if it's moving the plane right, branch to draw left
		move.w	d0,-$02(a2)				; update previous position
		subi.w	#$0018,d0				; revert position back again (coming from the left now)
		addq.w	#$08,d2					; correct position accordingly
		bra.s	NTWAZZ_DrawRight			; continue

NTWAZZ_DrawLeft:
		move.w	d0,-$02(a2)				; update previous position

NTWAZZ_DrawRight:
		addi.w	#$0078,d0				; advance to correct strip position
		lsl.w	#$04,d0					; multiply to x80 (4 tiles)
		andi.w	#$3F80,d0				; keep within the strip's set
		adda.w	d0,a0					; advance to correct tiles
		cmp.w	d6,d0					; is the position passed the cap?
		blt.s	NTWAZZ_NoCap				; if not, branch
		lea	(Art_Strip01).l,a0			; load beginning of strip 1 (which conveniently has blank tiles)

NTWAZZ_NoCap:
		; getting VDP write address

		subi.w	#$0088,d2				; align to position in VRAM (where the art is to be dumped)
		lsl.w	#$04,d2					; multiply to x80 (4 tiles)
		andi.w	#$0180,d2				; wrap within the art's sprite section (do not exceed...)
		move.l	d2,d3					; copy long-word (for a second line if needed)
		add.w	d4,d2					; add starting VRAM address
		lsl.l	#$02,d2					; convert for VDP port
		lsr.w	#$02,d2					; ''
		ori.w	#$4000,d2				; ''
		swap	d2					; ''
		move.l	d2,(a6)					; set VDP address/mode
		bsr.s	NTWA_WriteTiles				; flush the tiles
		cmpi.w	#$0180,d3				; is this one of the first three lines?
		bge.s	NTWAZZ_NoChange				; if not, branch

		; Second line to draw (making a copy for the end sprite)

		lea	-$80(a0),a0				; go back to start of art line again
		addi.w	#$0200,d3				; advance to the end where the last sprite will overflow/overread
		add.w	d4,d3					; add starting VRAM address
		lsl.l	#$02,d3					; convert for VDP port
		lsr.w	#$02,d3					; ''
		ori.w	#$4000,d3				; ''
		swap	d3					; ''
		move.l	d3,(a6)					; set VDP address/mode
		bsr.s	NTWA_WriteTiles				; flush the tiles

NTWAZZ_NoChange:
		lea	$20*2(a1),a1				; advance scroll buffer down a section
		addi.w	#$380,d4				; advance to next section
		cmpi.w	#$0001,d7				; is this the last zig-zag bottom piece?
		beq.s	NTWAZZ_NoAdvance			; if so, branch (not enouch space to leave a gap (Sonic Head art doesn't exist here either))
		addi.w	#$0800+$180,d4				; advance to next section

NTWAZZ_NoAdvance:
		dbf	d7,NTWAZZ_NextSet			; repeat for number of sections available
		rts						; return

	; --- Writing a line of 4 tiles (for the sprites) ---

NTWA_WriteTiles:
		move.l	(a0)+,(a5)				; write tiles
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''

		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''

		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''

		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''

		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to update the plane mappings properly while scrolling
; ---------------------------------------------------------------------------

VBIN_WritePlane:
		lea	(H_scroll_buffer+$0200).w,a1		; load H-scroll buffer
		lea	(IN_PrevPos).l,a2			; load previous positions value
		lea	($00FF0000).l,a3			; load plane mappings buffer
		move.l	#$00034000,d3				; prepare VDP address/modes
		moveq	#$02-1,d6				; set number of sections that need doing (2 sections: top, and bottom)
		lea	NTWP_Top(pc),a4				; load top rendering subroutine
		moveq	#$18-1,d7				; set number of tiles need rendering

NTWP_NextLine:
		move.w	(a1),d0					; load position
		addi.w	#$0310,d0				; align into posiiton
		andi.w	#$FFF8,d0				; keep within each tile
		move.w	#$0000,d4				; set palette line swap values
		move.w	#$2000,d1				; ''
		cmp.w	(a2)+,d0				; has the position changed?
		beq.s	NTWP_NoChange				; if not, branch
		bcc.s	NTWP_DrawLeft				; if it's moving the plane right, branch to draw left
		move.w	#$2000,d4				; change palette line swap values
		move.w	#$0000,d1				; ''
		move.w	d0,-$02(a2)				; update previous position storage
		addq.w	#$08,d0					; correct position accordingly
		bra.s	NTWP_DrawRight				; continue rendering

NTWP_DrawLeft:
		move.w	d0,-$02(a2)				; update previous position storage

NTWP_DrawRight:
		neg.w	d0					; reverse direction
		lsr.w	#$02,d0					; divide by 8 then multiply by 4
		jsr	(a4)					; run correct tile drawing routine

NTWP_NoChange:
		addi.w	#$0100,d3				; advance VRAM address down a plane line
		lea	$100(a3),a3				; advance plane mappings down a plane line
		lea	$08*2(a1),a1				; advance scroll buffer down a plane line
		dbf	d7,NTWP_NextLine			; repeat until section is down (top/bottom)
		lea	NTWP_Bottom(pc),a4			; load bottom rendering subroutine
		moveq	#$04-1,d7				; set number of tiles need rendering
		dbf	d6,NTWP_NextLine			; repeat for bottom section (if not done already)
		rts						; return

	; --- Tile Redrawing for the top half (with the head) ---

NTWP_Top:
		andi.w	#$00FE,d0				; keep within a plane's line of mappings
		move.l	d3,d2					; load VDP address/modes
		or.w	d0,d2					; set address
		swap	d2					; align for VDP port
		move.l	d2,(a6)					; set VDP address/mode
		or.w	(a3,d0.w),d1				; load tile and fuse with palette line value
		move.w	d1,(a5)					; save to VRAM
		subi.b	#$20,d0					; move to the left side (The Sonic "head" logo)
		andi.w	#$00FE,d0				; keep within a plane's line of mappings
		move.l	d3,d2					; load VDP address/modes
		or.w	d0,d2					; set address
		swap	d2					; align for VDP port
		move.l	d2,(a6)					; set VDP address/mode
		or.w	(a3,d0.w),d4				; load tile and fuse with palette line value
		move.w	d4,(a5)					; save to VRAM
		rts						; return

	; --- Tile Redrawing for the bottom half (with NO head) ---

NTWP_Bottom:
		andi.w	#$00FE,d0				; keep within a plane's line of mappings
		move.l	d3,d2					; load VDP address/modes
		or.w	d0,d2					; set address
		swap	d2					; align for VDP port
		move.l	d2,(a6)					; set VDP address/mode
		or.w	(a3,d0.w),d1				; load tile and fuse with palette line value
		move.w	d1,(a5)					; save to VRAM
		subi.b	#$4E,d0					; move to the left side (The Sonic "head" logo)
		andi.w	#$00FE,d0				; keep within a plane's line of mappings
		move.l	d3,d2					; load VDP address/modes
		or.w	d0,d2					; set address
		swap	d2					; align for VDP port
		move.l	d2,(a6)					; set VDP address/mode
		or.w	(a3,d0.w),d4				; load tile and fuse with palette line value
		move.w	d4,(a5)					; save to VRAM
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to animate the zig-zag shape on the right
; ---------------------------------------------------------------------------

VBIN_WriteZigZag:
		move.l	#$77000002,(a6)				; set VDP address to zig-zag art
		move.w	(IN_ZigZagPos).l,d0			; load Zig-Zag position
		addi.w	#$0004,(IN_ZigZagPos).l			; increase to next position
		andi.w	#$007C,d0				; wrap within art range
		lea	(Art_ZigZag).l,a0			; load zig-zag art address
		adda.w	d0,a0					; advance to correct position
		move.w	(IN_ZigZagFrame).l,d0			; load frame position
		subq.w	#$01,(IN_ZigZagDip).l			; minus 1 from dip timer
		bpl.s	VBWZZ_Draw				; if still running, branch
		tst.b	(IN_ZigZagFrame+$03).l			; is the animation moving forwards?
		beq.s	VBWZZ_Forwards				; if so, branch
		subi.l	#$00006000,(IN_ZigZagFrame).l		; move backwards
		move.w	(IN_ZigZagFrame).l,d0			; load frame position
		bgt.s	VBWZZ_Draw				; if we're still ahead of first frame, branch
		sf.b	(IN_ZigZagFrame+$03).l			; set direction to forwards now
		move.w	#$0060,(IN_ZigZagDip).l			; reset dip timer
		bra.s	VBWZZ_Draw

VBWZZ_Forwards:
		addi.l	#$00006000,(IN_ZigZagFrame).l		; move forwards
		move.w	(IN_ZigZagFrame).l,d0			; load frame position
		cmpi.w	#$0010,d0				; has it reached the last frame?
		blo.s	VBWZZ_Draw				; if not, branch
		st.b	(IN_ZigZagFrame+$03).l			; set to move in reverse
		move.w	#$0003,(IN_ZigZagDip).l			; reset dip timer

VBWZZ_Draw:
		ror.w	#$07,d0					; multiply by 200
		andi.w	#$FE00,d0				; clear dividend (keep quotient)
		adda.w	d0,a0					; advance to correct zig-zag frame
		moveq	#$04-1,d7				; set number of tiles to draw
		bsr.s	VBWZZ_NextTile				; do left set of tiles first
		lea	$80(a0),a0				; advance to right set of tiles
		moveq	#$04-1,d7				; set number of tiles to draw
						; continue to..	; do right set of tiles

VBWZZ_NextTile:
		move.l	(a0)+,(a5)				; write tile to VRAM
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		dbf	d7,VBWZZ_NextTile			; repeat til all done
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank routine outside exception (H-blank may interrupt here if necessary)
; ---------------------------------------------------------------------------

VBO_Intro:
		move.w	sr,-(sp)				; store sr in the stack
		movem.l	d0-a6,-(sp)				; store register data
		tst.b	(V_int_routine).w			; was the 68k late?
		beq.s	VBOIN_68kLate				; if so, branch
	;	jsr	ReadControls				; read the controller pads
		jsr	Poll_Controllers

VBOIN_68kLate:
		sf.b	(V_int_routine).w			; clear V-blank flag
	;	jsr	SoundDriver				; run sound driver
		movem.l	(sp)+,d0-a6				; restore register data
		rtr						; return and restore ccr

; ===========================================================================
; ---------------------------------------------------------------------------
; H-blank routine
; ---------------------------------------------------------------------------

HB_Intro:
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Include Data
; ---------------------------------------------------------------------------

Pal_TitleIntro:	binclude "Screen Intro\Data\PalIntro.bin"
		even
Art_Head:	binclude "Screen Intro\Data\ArtHead.kosm"
		even
Art_PlaneSTH:	binclude "Screen Intro\Data\ArtPlaneSTH.kosm"
		even
Map_PlaneSTH:	binclude "Screen Intro\Data\MapPlaneSTH.kos"
		even
Art_ZigZag:	binclude "Screen Intro\Data\ArtZigZag.bin"
Art_ZigZag_End:	even

Art_Strip01:	binclude "Screen Intro\Data\Strip Art\Strip 01.bin"
Art_Strip02:	binclude "Screen Intro\Data\Strip Art\Strip 02.bin"
Art_Strip03:	binclude "Screen Intro\Data\Strip Art\Strip 03.bin"
Art_Strip04:	binclude "Screen Intro\Data\Strip Art\Strip 04.bin"
Art_Strip05:	binclude "Screen Intro\Data\Strip Art\Strip 05.bin"
Art_Strip06:	binclude "Screen Intro\Data\Strip Art\Strip 06.bin"
Art_Strip07:	binclude "Screen Intro\Data\Strip Art\Strip 07.bin"
		even

	; --- Ident (MarkeyJester) ---

Pal_LogoMJ:	binclude "Screen Intro\Data\Idents\PalLogo_MJ.bin"
		even
Art_LogoMJ:	binclude "Screen Intro\Data\Idents\ArtLogo_MJ.bin"
Art_LogoMJ_End:	even
Art_SprtMJ:	binclude "Screen Intro\Data\Idents\ArtSprite_MJ.bin"
Art_SprtMJ_End:	even
Map_LogoMJ:	binclude "Screen Intro\Data\Idents\MapLogo_MJ.kos"
		even

	; --- Ident (Natsumi) ---

Pal_LogoNS:	binclude "Screen Intro\Data\Idents\PalLogo_NS.bin"
		even
Art_LogoNS:	binclude "Screen Intro\Data\Idents\ArtLogo_NS.bin"
Art_LogoNS_End:	even
Art_SprtNS:	binclude "Screen Intro\Data\Idents\ArtSprite_NS.bin"
Art_SprtNS_End:	even
Map_LogoNS:	binclude "Screen Intro\Data\Idents\MapLogo_NS.kos"
		even

AniNS_Right:	binclude "Screen Intro\Data\Idents\AniNS_Right.bin"
		even
AniNS_Left:	binclude "Screen Intro\Data\Idents\AniNS_Left.bin"
		even

; ===========================================================================





