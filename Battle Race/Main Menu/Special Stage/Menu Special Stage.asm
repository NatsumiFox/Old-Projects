; ===========================================================================
; ---------------------------------------------------------------------------
; Special Stage Menu
; ---------------------------------------------------------------------------
EMS_PlanetPal	=	$FFFF0000			;  300	; palettes for planet animation
EMS_ScalePal	=	$FFFF0300			;  200	; palettes for scale planet animation
EMS_SpriteTop_A	=	$00FF0500	; keep MSB clear;  280	; sprite table for top half of planet
EMS_SpriteBot_A	=	$00FF0780	; keep MSB clear;  280	; sprite table for bottom half of planet
EMS_SpriteTop_B	=	$00FF0A00	; keep MSB clear;  280	; '' Buffer B
EMS_SpriteBot_B	=	$00FF0C80	; keep MSB clear;  280	; '' Buffer B
EMS_PlanetScale	=	$FFFF0F00			;  400	; mappings for the scaling planet
EMS_SpherePos	=	$FFFF1300			;  2A4	; Sphere positions (generated in realtime)
	; 15A4 - 15BF is free (at least 15A4 "should" be free...)
EMS_MenuStrip	=	$FFFF15C0			;   40	; a single map strip for rendering
EMS_MenuMap_MAI	=	$FFFF1600			;  A00	; Main menu mappings (40 bytes per vertical strip)
EMS_MenuMap_LVL	=	$FFFF2000			;  A00	; Level Select menu mappings (40 bytes per vertical strip)
	; 2A00 - 2FFF is free
EMS_PlanetMap	=	$FFFF3000			; 3000	; mappings for planet animation
EMS_Layout	=	$FFFF6000			; 2000	; layout data to display
EMS_WorldPosX	=	$FFFF8000			; long	; QQQQ.DDDD world's X position on-screen
EMS_WorldPosY	=	$FFFF8004			; long	; QQQQ.DDDD world's Y position on-screen
EMS_WorldSize	=	$FFFF8008			; long	; QQQQ.DDDD world's size
EMS_WorldAdjX	=	$FFFF800C			; word	; adjusted X position (for sprites)
EMS_WorldAdjY	=	$FFFF800E			; word	; adjusted Y position (for sprites)
EMS_WorldAlpha	=	$FFFF8010			; word	; QQ.DD Alpha angle (for shrinking positions between spheres)
EMS_WorldDelta	=	$FFFF8012			; word	; QQ.DD Delta angle (for bending positions between spheres)
EMS_ObjectRout	=	$FFFF8014			; long	; address/routine of sphere objects control
EMS_WorldRotH	=	$FFFF8018			; long	; QQQQQQ.DD rotation horizontally (need the upper word due to H-scroll shifting)
EMS_WorldRotV	=	$FFFF801C			; long	; QQQQQQ.DD rotation vertically (need the upper word due to V-scroll shifting)
EMS_WorldRotHS	=	$FFFF8020			; word	; QQ.DD rotation H-speed
EMS_WorldRotVS	=	$FFFF8022			; word	; QQ.DD rotation V-speed
EMS_RingTimer	=	$FFFF8024			; byte	; ring rotation animation timer
EMS_RingFrame	=	$FFFF8025			; byte	; ring rotation animation frame
EMS_CurMapPos	=	$FFFF8026			; word	; current map position for the planet (to prevent re-rendering the same frame)
EMS_BGPalette	=	$FFFF8028			;    6	; the three colours of the BG to fade to
EMS_CurScalePos	=	$FFFF802E			; word	; current map position for the scaled planet (to prevent re-rendering the same frame)
EMS_ScaleAmount	=	$FFFF8030			; word	; QQ.DD current scale size
EMS_ScaleCycle	=	$FFFF8032			; word	; QQ.DD cycle palette position for scaling planet
EMS_ScalePrev	=	$FFFF8034			; byte	; previous scale size
EMS_DMA		=	$FFFF8036			; 8 bytes (6 plus padding)
EMS_Planet2_VS	=	$FFFF803E			; word	; VSRAM scroll position for the "world" (planet 2)
EMS_ScalePosX	=	$FFFF8040			; long	; QQQQ.DDDD scale world's X position on-screen
EMS_ScalePosY	=	$FFFF8044			; long	; QQQQ.DDDD scale world's Y position on-screen
EMS_Planet1_Y	=	$FFFF8048			; long	; QQQQ.DDDD Planet 1's Y position (scale planet)
EMS_Planet2_Y	=	$FFFF804C			; long	; QQQQ.DDDD Planet 2's Y position (normal planet "world")
EMS_ShadowSize	=	$FFFF8050			; word	; size of planet 1's sprite table (number of sprites to transfer)
EMS_ShadowCount	=	$FFFF8052			; byte	; number of planet 1's sprites (count rather than size)
EMS_DMA_SizeHB	=	$FFFF8054			; long	; 94009300 (for H-blank)
EMS_DMA_Size	=	$FFFF8058			; long	; 94009300
EMS_BufferFlag	=	$FFFF805C			; byte	; buffer flag (for sprite swapping)
EMS_DisSpheres	=	$FFFF805D			; byte	; flag to disable sphere sprites (main world rendering)
EMS_Planet2_YS	=	$FFFF805E			; word	; QQ.DD Planet 2's Y speed (normal planet "world")
EMS_HScrollPos1	=	$FFFF8060			; long	; QQQQ.DDDD H-scroll buffer position (to be copied to H-scroll table once done
EMS_HScrollPos2	=	$FFFF8064			; long	; ''
EMS_ReleatBGX	=	$FFFF8068			; long	; QQQQ.DDDD relative BG X position
EMS_ReleatBGY	=	$FFFF806C			; long	; QQQQ.DDDD relative BG Y position
EMS_LevelRout	=	$FFFF8070			; long	; routine address of loading a new level's data
EMS_LayoutDest	=	$FFFF8074			; long	; address of current layout position
EMS_LayoutSrc	=	$FFFF8078			; long	; address of current layout destination (RAM)
EMS_LayoutCount	=	$FFFF807C			; byte	; layout line counter
EMS_DisScale	=	$FFFF807D			; byte	; flag to disable scaling planet (mapping only)
EMS_LevelChange	=	$FFFF807E			; byte	; if the level is changing
EMS_CurLevel	=	$FFFF807F			; byte	; current level being displayed
EMS_WindowSizeX	=	$FFFF8080			; byte	; window's X size
EMS_FastMode	=	$FFFF8081			; byte	; if the level switching is meant to be going faster
EMS_PlanetsOn	=	$FFFF8082			; byte	; if the planets should be on or not
EMS_FadeCount	=	$FFFF8083			; byte	; fade in/out counter
EMS_SelectRout	=	$FFFF8084			; long	; routine for controls
EMS_Return	=	$FFFF8088			; byte	; if B was pressed and player wants to return (while level is cycling through)
EMS_NoSpheres	=	$FFFF8089			; byte	; if no spheres are rendering
EMS_WindowPrevX	=	$FFFF808A			; byte	; window's previous X size
EMS_WindowDraw	=	$FFFF808B			; byte	; Draw flag (00 None | FF Left | 7F Right)
EMS_MapAddress	=	$FFFF808C			; long	; address of mappings to use
EMS_StagePrev	=	$FFFF8090			; byte	; previous game mode selection
EMS_LevelPrev	=	$FFFF8091			; byte	; previous level ID
EMS_LevelCount	=	$FFFF8092			; byte	; total number of available levels for blue spheres challenge
EMS_LastSlot	=	$FFFF8093			; byte	; if we're on the last slot or not (and if the scale planet should display)
EMS_ScrollBG1	=	$FFFF8094			; word	; BG H-scroll speeds
EMS_ScrollBG2	=	$FFFF8096			; word	; ''
EMS_ScrollBG3	=	$FFFF8098			; word	; ''
EMS_ScrollBG4	=	$FFFF809A			; word	; ''
EMS_CountBlue	=	$FFFF809C			; word	; blue sphere count
EMS_CountOrange	=	$FFFF809E			; word	; orange sphere count
EMS_DMA_Dest	=	$FFFF80A0			; word	; last destination word

EMS_CharAniTime	=	$FFFF8100			; byte	; character icon animation timer
EMS_CharAniSlot	=	$FFFF8101			; byte	; character icon animation slot to display
EMS_ButAniFlag	=	$FFFF8102			; byte	; flag for remembering if buttons were greyed out (00 = No | FF = Yes)
; ---------------------------------------------------------------------------
EMS_WindowTrans	=	$FFFF8200			;  200	; window transfer list (for changing menu mappings while window is on-screen)
EMS_HScrollFG	=	$FFFF8400			;  200	; FG H-scroll buffer
EMS_HScrollBG	=	$FFFF8600			;  200	; BG H-scroll buffer
; ---------------------------------------------------------------------------
EMS_OBJECTS	=	$08					; number of object sphere lines
EMS_MAXDIST	=	$0080					; maxiumum distance spheres have to be before they can no longer display
; ---------------------------------------------------------------------------
EMS_ObjDist	=	$00				; long	; QQQQ.DDDD distance away from world
EMS_ObjSpeed	=	$04				; long	; QQQQ.DDDD
EMS_ObjTimer	=	$08				; word	; counter/timer
EMS_ObjSize	=	$20					; Maximum size of a single object
; ---------------------------------------------------------------------------
VRAM_TEXTTITLE	=	$7BC0
VRAM_COUNTER	=	$8500
VRAM_CHARACTERS	=	$8A00
VRAM_ASCII	=	$9F80
; ---------------------------------------------------------------------------
EMS_SONICA	=	($E000|((0*6)+(VRAM_CHARACTERS/$20)))
EMS_SONICB	=	($E000|((1*6)+(VRAM_CHARACTERS/$20)))
EMS_TAILSA	=	($E000|((2*6)+(VRAM_CHARACTERS/$20)))
EMS_TAILSB	=	($E000|((3*6)+(VRAM_CHARACTERS/$20)))
EMS_RESERVEDA	=	($E000|((4*6)+(VRAM_CHARACTERS/$20)))
EMS_RESERVEDB	=	($E000|((5*6)+(VRAM_CHARACTERS/$20)))
EMS_CPUA	=	($C000|((6*6)+(VRAM_CHARACTERS/$20)))
EMS_CPUB	=	($C000|((7*6)+(VRAM_CHARACTERS/$20)))
; ---------------------------------------------------------------------------
WindMap	function X, Y, (((X&$3F)*$40)|((Y&$1F)*2))
; ---------------------------------------------------------------------------

Menu_SpecialStage:
		moveq	#$E2,d0					; set sound ID to "Fade Music"
		jsr	Play_Sound.w				; play sound ID

	; --- Clearing decompression lists ---

		clr.w	(Kos_decomp_queue_count).w		; clear kosinski decompression cue count
		lea	(Kos_decomp_stored_registers).w,a1	; load kosinski decomrpession cue register storage RAM
		moveq	#$00,d0					; clear d0
		move.w	#($6C/$04)-1,d1				; ''

MSS_ClearKos:
		move.l	d0,(a1)+				; clear register storage
		dbf	d1,MSS_ClearKos				; repeat until all cleared
		jsr	Clear_KosM_Queue.w			; clear PLC list
		jsr	Pal_FadeToBlack				; fade out to black

	; ---Setup/clearing ---

		move	#$2700,sr				; disable interrupts
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.l	#VB_TitleInit,(V_int_addr).w		; set V-blank routine
		move.l	#NullRTE,(H_int_addr).w			; ''
		move.w	#$8000|%00010100,(a6)			; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)
		move.w	#$8100|%00110100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.w	#$8200|((($C000)>>$0A)&$FF),(a6)	; 00FE DCBA - Scroll Plane A Map Table VRam address
		move.w	#$8300|((($9000)>>$0A)&$FF),(a6)	; 00FE DCB0 / 00FE DC00 (20 H-resol) - Window Plane A Map Table VRam address
		move.w	#$8400|((($E000)>>$0D)&$FF),(a6)	; 0000 0FED - Scroll Plane B Map Table VRam address
		move.w	#$8500|((($1800)>>$09)&$FF),(a6)	; 0FED CBA9 / 0FED CBA0 (20 H-resol) - Sprite Plane Map Table VRam address
		move.w	#$8600|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8700|$00,(a6)				; 00PP CCCC - Backdrop Colour: Palette Line | Colour ID
		move.w	#$8800|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8900|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8A00|$DF,(a6)				; 7654 3210 - H-Interrupt Register
		move.w	#$8B00|%00000011,(a6)			; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)
		move.w	#$8C00|%10001001,(a6)			; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
		move.w	#$8D00|((($1C00)>>$0A)&$FF),(a6)	; 00FE DCBA - Horizontal Scroll Table VRam address
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

	; --- Clearing ---

		moveq	#$00,d0					; clear d0
		lea	($00FF0000).l,a1			; load start of ram
		move.w	#($E380/$04)-1,d7			; set number of bytes to clear

MSS_ClearRAM:
		move.l	d0,(a1)+				; clear RAM
		dbf	d7,MSS_ClearRAM				; repeat til cleared

		lea	(Sprite_table_buffer).w,a1		; load sprite table
		move.w	#($280/$04)-1,d7			; set size to clear

MSS_ClearSprites:
		move.l	d0,(a1)+				; clear sprite table
		dbf	d7,MSS_ClearSprites			; repeat until sprites are all cleared

	; --- Loading data ---

		DMA	$A00, $40200000, MSS_ArtSpheres		; Loading uncompressed sphere art

	;	moveq	#$20,d2					; write to VRAM address
	;	lea	(MSS_ArtSpheres).l,a1			; load kosinski moduled compress art address
	;	jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping
		move.w	#$1000,d2				; write to VRAM address
		lea	(MSS_ArtShine).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping
		move.w	#$FEE0,d2				; write to VRAM address
		lea	(MSS_ArtBG).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping
		move.w	#$2000,d2				; write to VRAM address
		lea	(MSS_ArtPlanet).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping
		move.w	#VRAM_TEXTTITLE,d2			; write to VRAM address
		lea	(MSS_ArtTextTit).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping
		move.w	#VRAM_COUNTER,d2			; write to VRAM address
		lea	(MSS_ArtCounter).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping
		move.w	#VRAM_CHARACTERS,d2			; write to VRAM address
		lea	(MSS_ArtChars).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping
		move.w	#VRAM_ASCII,d2				; write to VRAM address
		lea	(MSS_ArtASCII).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping

	; --- Decompress Kos Module data ---

MSS_DelayLoad:
		st.b	(V_int_routine).w			; set V-blank flag
		jsr	Process_Kos_Queue
		jsr	Wait_VSync
		jsr	Process_Kos_Module_Queue.w
		tst.l	(Kos_module_queue).w
		bne.s	MSS_DelayLoad
		st.b	(V_int_routine).w			; set V-blank flag
		jsr	Wait_VSync
		move	#$2700,sr				; disable interrupts
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.l	#MSS_VBlank,(V_int_addr).w		; set V-blank routine

	; --- Mapping data ---

		lea	(MSS_MapBG).l,a0			; load BG compressed mappings
		lea	($FFFF0000).l,a1			; load dumping address
		move.w	#$2000|($FEE0/$20),d0			; set tile adjustment
		jsr	Eni_Decomp				; decompress and dump to RAM
		lea	($FFFF0000).l,a1			; reload dumping address
		move.l	#$60000003,(a6)				; set VDP to VRAM write mode (plane B address)
		move.w	#(($1000/$04)/$04)-1,d1			; size of plane B mappings
		moveq	#$02-1,d2				; set to repeat again for bottom F000 - FE00 half

MSS_LoadBG:
		move.l	(a1)+,(a5)				; copy BG tiles to plane B
		move.l	(a1)+,(a5)				; ''
		move.l	(a1)+,(a5)				; ''
		move.l	(a1)+,(a5)				; ''
		dbf	d1,MSS_LoadBG				; repeat until entire BG is mapped out
		lea	($FFFF0000).l,a1			; reload dumping address
		move.w	#(($0E00/$04)/$04)-1,d1			; size of plane B mappings (for bottom)
		dbf	d2,MSS_LoadBG				; repeat for bottom half of plane B (F000 - FE00 now)

		move.l	#$80008000,d0				; prepare high plane (ensuring palette displays normally)
		move.l	#$40000003,(a6)				; set VDP to plane A
		move.w	#(($2000/$04)/$04)-1,d1			; size of plane A mappings

MSS_SetupFG:
		move.l	d0,(a5)					; Force FG to high plane
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		dbf	d1,MSS_SetupFG				; repeat until entire BG is mapped out

		lea	(MSS_MapPlanet).l,a0			; load planet mappings (all frames)
		lea	(EMS_PlanetMap).l,a1			; set dumping location (to use for later)
		move.w	#$8000|($2000/$20),d0			; set tile adjustment
		jsr	Eni_Decomp				; decompress and dump to RAM

		bsr.w	MSS_MapScalePlanet			; loading scale planet mappings to RAM ready for use/transfer

	; --- Window plane specifics ---

		move.l	#$A000A000,d0				; prepare high plane tiles
		move.l	#$50000002,(a6)				; set VDP write address to top line of window
		bsr.s	MSS_SetupTopBottom			; force it to non-shadowed
		move.l	#$5D800002,(a6)				; set VDP write address to bottom line of window
		bsr.s	MSS_SetupTopBottom			; force it to non-shadowed

		lea	(MSS_ArtWindCom).l,a0			; load uncompressed common tiles
		moveq	#$1C-1,d1				; number of common tiles which will fit in the window mapping space outside of display
		move.l	#$504E0002,d2				; prepare VDP write address to window plane area
		bra.s	MSS_SetupWindowStart

MSS_SetupTopBottom:
		moveq	#($28/2)-1,d1				; screen width of tiles to force the high plane

MSS_SetupTB:
		move.l	d0,(a5)					; set tiles to non-shadowed high plane
		dbf	d1,MSS_SetupTB				; repeat for all shadow tiles
		rts						; return

MSS_SetupWindowArt:
		move.w	d0,(a5)					; force left edge to non-shadowed

MSS_SetupWindowStart:
		move.l	d2,(a6)					; set VDP to VRAM write at window address
		move.w	d0,(a5)					; force right edge to non-shadowed
		addi.l	#$00120000,d2				; advance to tile spot
		move.l	d2,(a6)					; set VDP to VRAM write at window address
		addi.l	#$006E0000,d2				; advance to next available spot
		move.l	(a0)+,(a5)				; copy tile into VRAM space
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		dbf	d1,MSS_SetupWindowArt			; repeat until all tiles are copied over
		moveq	#($03*4)-1,d1				; set to copy 3 buttons "A", "B", and "C"

MSS_SetupButtons:
		move.l	(a0)+,(a5)				; copy remaining tiles into VRAM space
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		dbf	d1,MSS_SetupButtons			; repeat for all button art

	; -- Palette stuffs ---

		lea	(MSS_Palette).l,a0			; set palette address
		lea	(Target_palette).w,a1			; set palette buffer address
		moveq	#(($80/$04)/$04)-1,d1			; size of palette to copy

MSS_LoadPal:
		move.l	(a0)+,(a1)+				; copy colours over
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		dbf	d1,MSS_LoadPal				; repeat until entire palette is done

	; --- Loading initial level ---

		lea	(SP_Stages).l,a4			; load stage list address

MSS_CountLevels:
		tst.w	(a4)+					; is this the end slot marker?
		bne.s	MSS_CountLevels				; if not, branch to check next slot
		suba.l	#SP_Stages+2+2,a4			; get distance
		move.w	a4,d0					; copy to d0
		lsr.w	#$01,d0					; divide by 2 (word per entire)
		move.b	d0,(EMS_LevelCount).w			; save number of stages

 move.b	#$01,(ESS_StageP1).w

		move.b	(ESS_StageP1).w,(EMS_CurLevel).w	; set starting stage ID
		bsr.w	MSS_LoadStage				; load current stage
		bsr.w	MSS_UpdateSphereArt			; load correct art based on game mode

		jsr	MSS_SetupWindowAPI			; setting up window mappings ready
		move.l	#EMS_MenuMap_MAI&$FFFFFF,(EMS_MapAddress).w ; set starting map buffer to use

	; --- Finalisation ---

		move.l	#$00009700,(EMS_DMA).l			; prepare DMA register storage
		move.l	#$96009500,(EMS_DMA+$04).l		; ''
		move.l	#$94009300,(EMS_DMA_Size).l		; ''

		; ~$LL |$FFF
		; LL = Layout position (00 - 1F)
		; FFF = Fraction (000 - 7C0 [multiples of 40])

		move.l	#((~$03)<<$0B)|$140,(EMS_WorldRotH).w	; set starting rotation positions
		move.l	#((~$04)<<$0B)|$5C0,(EMS_WorldRotV).w	; ''

		; Main world/planet

		move.w	#$0010+$40,(EMS_WorldPosX).w		; central X position of planet
		move.w	#$0108+$40,(EMS_WorldPosY).w		; central Y position of planet
		move.w	#$0080+4,(EMS_WorldSize).w		; size of the planet
		move.w	#$0C00,(EMS_WorldAlpha).w		; alpha angle sinewave for spheres
		move.w	#$0780,(EMS_WorldDelta).w		; delta angle sinewave for spheres (just to bend but not so that the squares squash together at the pole, hence needing to be different from alpha)
		st.b	(EMS_CurMapPos).w			; force a planet map frame to update

		; Second smaller (scaleable) world/planet

		move.w	#$0030+$40,(EMS_ScalePosX).w		; central X position of scale-able planet
		move.w	#$0000+$40,(EMS_ScalePosY).w		; central Y position of scale-able planet
		st.b	(EMS_CurScalePos).w			; force a scale planet frame to update
		st.b	(EMS_ScalePrev).w			; force scale art to update
		move.b	#$1F,(EMS_ScaleAmount).w		; set to use smallest scale at first

		move.l	#$00180000,(EMS_Planet1_Y).w		; QQQQ.DDDD set starting scaleable planet Y position
		move.l	#$00500000,(EMS_Planet2_Y).w		; QQQQ.DDDD set starting main "world" planet Y position
		move.l	#$FF500000,(EMS_HScrollPos1).w		; QQQQ.DDDD set starting X positions (off-screen)
		move.l	#$FF500000,(EMS_HScrollPos2).w		; QQQQ.DDDD ''

		; Window menu

		move.b	#$14,(EMS_WindowSizeX).w		; set starting X position of window (completely closed)
		move.b	(EMS_WindowSizeX).w,(EMS_WindowPrevX).w	; ''

		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; continue waiting for V-blank
		bsr.s	MSS_Subroutines				; run the subroutine
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; continue waiting for V-blank
		bsr.s	MSS_Subroutines				; run the subroutines

		move.w	#$8100|%01110100,(a6)			; enable display

		moveq	#Mus_SpecialSelect,d0			; set sound ID to "Special Stage"
		jsr	Play_Sound.w				; play sound ID

		move.b	#$16,(EMS_FadeCount).w			; set fade in timer

; ---------------------------------------------------------------------------
; Main Loop - Special Stage Menu
; ---------------------------------------------------------------------------

MSS_FadeLoop:
		jsr	Pal_FromBlack				; fade in
		subq.b	#$01,(EMS_FadeCount).w			; decrease coutner
		beq.s	MSS_MainLoop				; if finished, branch
		pea	MSS_FadeLoop(pc)			; set fade in loop address
		bra.s	MSS_Continue

MSS_MainLoop:
		pea	MSS_MainLoop(pc)			; set return loop address

MSS_Continue:
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; continue waiting for V-blank

MSS_Subroutines:
		bsr.w	MSS_Controls				; hand controls of the menu and planet from the player(s)
		bsr.w	MSS_WindowDraw				; perform window drawing/updating
		bsr.w	MSS_RunSpheres				; run the sphere object routine/control
		bsr.w	MSS_RenderSprites			; render the sprites for the spheres and shadow/shine of the planet
		bsr.w	MSS_ScrollPlane				; scroll the FG and BG stars correctly

; ---------------------------------------------------------------------------
; Subroutine to fade to the BG palette gradually
; ---------------------------------------------------------------------------

MSS_FadePalBG:
		tst.b	(EMS_FadeCount).w			; is the palette fading in?
		bne.s	MSSFPB_NoFade				; if so, branch
		lea	(EMS_BGPalette).w,a0			; palette to fade to
		lea	(Normal_palette+$20+$10).w,a1		; palette buffer to fade
		moveq	#$03-1,d4				; set number of colours to be faded
		moveq	#$0F,d5					; prepare AND values
		move.w	#$00F0,d6				; ''

MSSFPB_FadeColour:
		move.b	(a0)+,d0				; load blue
		sub.b	(a1)+,d0				; minus current blue
		beq.s	MSSFPB_BlueOK				; if blue is done, branch
		bpl.s	MSSFPB_BlueUp				; if the blue colour is going up, branch
		subq.b	#$02,-$01(a1)				; decrease blue

MSSFPB_BlueUp:
		addq.b	#$01,-$01(a1)				; increase blue

MSSFPB_BlueOK:
		move.b	(a0)+,d0				; load green/red
		move.b	d0,d1					; copy to d1
		and.w	d6,d0					; get only green
		and.w	d5,d1					; get only red

		move.b	(a1),d2					; load current green/red
		move.b	d2,d3					; copy to d3
		and.w	d6,d2					; get only green
		and.w	d5,d3					; get only red
		sub.w	d2,d0					; minus current from destination
		beq.s	MSSFPB_GreenOK				; if green is done, branch
		bpl.s	MSSFPB_GreenUp				; if the green colour is going up, branch
		subi.b	#$20,d2					; decrease green

MSSFPB_GreenUp:
		addi.b	#$10,d2					; increase green

MSSFPB_GreenOK:
		sub.w	d3,d1					; minus current from destination
		beq.s	MSSFPB_RedOK				; if red is done, branch
		bpl.s	MSSFPB_RedUp				; if the red colour is going up, branch
		subq.b	#$02,d3					; decrease red

MSSFPB_RedUp:
		addq.b	#$01,d3					; increase red

MSSFPB_RedOK:
		or.b	d3,d2					; fuse red with green
		move.b	d2,(a1)+				; update green/red
		dbf	d4,MSSFPB_FadeColour			; repeat for all colours to be faded

MSSFPB_NoFade:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load an entire stage immediately
; ---------------------------------------------------------------------------

MSS_LoadStage:

		; Current stage

		moveq	#$00,d0					; clear d0
		move.b	(ESS_StageP1).w,d0			; load stage ID
		add.w	d0,d0					; multiply by size of word
		lea	(SP_Stages).l,a4			; load stage list
		adda.w	(a4,d0.w),a4				; load correct stage data

		; Floor cycling

		move.l	(a4)+,d0				; load floor palette
		lea	(EMS_PlanetPal).l,a1			; load frame palette list
		lea	(MSSC_List).l,a0			; load palette list
		move.w	#((MSSC_ListEnd-MSSC_List)/2)-1,d4	; set number of frames to generate
		jsr	SPPC_NextFrame				; setup colour frame animations

		; BG palette

		lea	(EMS_BGPalette).w,a1			; copy BG colours
		move.l	(a4)+,(a1)+				; ''
		move.w	(a4)+,(a1)+				; ''

		; level layout

		lea	$03+$03(a4),a4				; advance to the actual layout data
		lea	(ESS_Layout_P1).l,a1			; load layout address
		jsr	SP_LoadLayout_RAW			; load the level layout

		; next stage

		moveq	#$00,d0					; clear d0
		move.b	(ESS_StageP1).w,d0			; load stage ID
		addq.b	#$01,d0					; advance to next stage
		add.w	d0,d0					; multiply by size of word
		lea	(SP_Stages).l,a4			; load stage list
		adda.w	(a4,d0.w),a4				; load correct stage data

		; Floor cycling

		move.l	(a4)+,d0				; load floor palette
		lea	(EMS_ScalePal).l,a1			; load frame palette list
		lea	(MSSC_ListScale).l,a0			; load palette list
		move.w	#((MSSC_ListScaleEnd-MSSC_ListScale)/2)-1,d4	; set number of frames to generate
		jmp	SPPC_NextFrame				; setup colour frame animations

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup mappings for the scaleable planet...
; ---------------------------------------------------------------------------

MSS_MapScalePlanet:
		lea	(EMS_PlanetScale).l,a1			; load mappings RAM space
		move.w	#((MSS_MapList_End-MSS_MapList)/2)-1,d1	; size of top half
		lea	MSS_MapList(pc),a0			; load address of mapping list
		move.w	#$2000|(($B280/$20)-$0001),d3		; prepare tile advancement

MSS_MSP_NormalTop:
		move.w	(a0)+,d0				; load mapping tile
		beq.s	MSS_MSP_NormalBlank			; if it's null, branch
		add.w	d3,d0					; advance to correct VRAM address

MSS_MSP_NormalBlank:
		ori.w	#$8000,d0				; force to high plane
		move.w	d0,(a1)+				; copy mappings over
		dbf	d1,MSS_MSP_NormalTop			; repeat until top half is done
		lea	-$20(a1),a0				; go back to previous line
		moveq	#((MSS_MapList_End-MSS_MapList)/$20)-1,d2 ; set number of lines
		move.l	#$10001000,d3				; prepare flip flags

MSS_MSP_NormalBottom_Next:
		moveq	#($20/$04)-1,d1				; set size of line

MSS_MSP_NormalBottom:
		move.l	(a0)+,d0				; load mappings
		eor.l	d3,d0					; flip them upside down
		move.l	d0,(a1)+				; save to mappings
		dbf	d1,MSS_MSP_NormalBottom			; repeat for line
		lea	-$40(a0),a0				; go back to previous line
		dbf	d2,MSS_MSP_NormalBottom_Next		; repeat for all lines

		lea	(EMS_PlanetScale+$20).l,a0		; reload mappings RAM space

		moveq	#(((MSS_MapList_End-MSS_MapList)*2)/$20)-1,d2 ; set number of lines
		move.w	#$0800,d3				; prepare mirror flag

MSS_MSP_Mirror_Next:
		moveq	#($20/$02)-1,d1				; set size of line

MSS_MSP_Mirror:
		move.w	-(a0),d0				; load mapping word
		eor.w	d3,d0					; mirror it
		move.w	d0,(a1)+				; save to mappings
		dbf	d1,MSS_MSP_Mirror			; repeat for entire line
		lea	$40(a0),a0				; advance to next line
		dbf	d2,MSS_MSP_Mirror_Next			; repeat for all lines
		rts						; return

MSS_MapList:	dc.w	$0000,$0000,$0000,$0000,$8001,$8002,$8003,$8004,$8005,$8006,$8007,$8008,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$8009,$800A,$800B,$800C,$800D,$800E,$800F,$8010,$8011,$8012,$0000,$0000,$0000
		dc.w	$0000,$0000,$8013,$8014,$8015,$8016,$8017,$8018,$8019,$801A,$801B,$801C,$801D,$801E,$0000,$0000
		dc.w	$0000,$801F,$8020,$8021,$8022,$8023,$8024,$8025,$8026,$8027,$8028,$8029,$802A,$802B,$802C,$0000
		dc.w	$802D,$802E,$802F,$8030,$8031,$8032,$8033,$8034,$8035,$8036,$8037,$8038,$8039,$803A,$803B,$803C
		dc.w	$803D,$803E,$803F,$8040,$8041,$8042,$8043,$8044,$8045,$8046,$8047,$8048,$8049,$804A,$804B,$804C
		dc.w	$804D,$804E,$804F,$8050,$8051,$8052,$8053,$8054,$8055,$8056,$8057,$8058,$8059,$805A,$805B,$805C
		dc.w	$805D,$805E,$805F,$8060,$8061,$8062,$8063,$8064,$8065,$8066,$8067,$8068,$8069,$806A,$806B,$806C
MSS_MapList_End:

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw and update the window (if necessary)
; ---------------------------------------------------------------------------

MSS_WindowDraw:
		move.b	(EMS_WindowSizeX).w,d0			; load current X size
		cmp.b	(EMS_WindowPrevX).w,d0			; has it changed?
		beq.s	MSS_WD_NoUpdate				; if not, branch
		spl.b	d1					; set to FF for closing and 00 for opening
		move.b	d0,(EMS_WindowPrevX).w			; update previous position
		cmpi.b	#$14,d0					; is the window fully closed?
		beq.s	MSS_WD_NoUpdate				; if so, branch (no need to update really...)
		subi.b	#$80,d1					; set to 7F for closing and 80 for opening
		move.b	d1,(EMS_WindowDraw).w			; set the draw flag

		move.w	(EMS_WindowSizeX).w,d0			; load window X size (x100)
		sf.b	d0					; ''
		lsr.w	#$01,d0					; divide to x80
		movea.l	(EMS_MapAddress).w,a0			; load correct window map buffer
		adda.w	d0,a0					; advance to correct slot
		lea	(EMS_MenuStrip).l,a1			; load strip buffer
		moveq	#$1A-1,d7				; set number of rows the strip is in size

MSS_WD_NextTile:
		move.w	(a0)+,d0				; load tile from window
		andi.w	#$07FF,d0				; get only tile
		beq.s	MSS_WD_Blank				; if it's blank, branch
		lea	-$02(a0),a2				; go back to that tile

WSS_WD_FindTile:
		lea	-$40(a2),a2				; go left
		tst.w	(a2)					; have we reached a blank tile?
		bne.s	WSS_WD_FindTile				; if not, branch
		move.w	$40(a2),d0				; reload last non-blank tile and use that...

MSS_WD_Blank:
		move.w	d0,(a1)+				; save tile to buffer
		dbf	d7,MSS_WD_NextTile			; repeat for all strips

MSS_WD_NoUpdate:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control the menu
; ---------------------------------------------------------------------------
MSS_MAXROTATE	=	$0200
MSS_IDLEROTATEH	=	$0080
MSS_IDLEROTATEV	=	$0020
MSS_ACCELLERATE	=	$08
MSS_DECELLERATE	=	$03
; ---------------------------------------------------------------------------

MSSC_Decelerate:
		move.w	(a0),d0					; load speed
		bmi.s	MSSC_SlowPositive			; if it's moving positive, branch
		subq.w	#MSS_DECELLERATE,d0			; decrease speed
		bpl.s	MSSC_SlowNoMax				; if it's still positive, branch
		moveq	#$00,d0					; so no speed now
		bra.s	MSSC_SlowNoMax				; continue

MSSC_SlowPositive:
		addq.w	#MSS_DECELLERATE,d0			; decrease speed
		bmi.s	MSSC_SlowNoMax				; if it's still negative, branch
		moveq	#$00,d0					; so no speed now

MSSC_SlowNoMax:
		move.w	d0,(a0)					; update speed
		ext.l	d0					; extend quotient to long-word
		add.l	d0,(a1)					; update position
		add.l	d0,(a2)					; update BG position
		rts						; return

; ---------------------------------------------------------------------------
; The actual controls themselves
; ---------------------------------------------------------------------------

MSS_Controls:
		lea	(EMS_WorldRotHS).w,a0			; load worlds' rotation H speed
		lea	(EMS_WorldRotH).w,a1			; load worlds' rotation H position
		lea	(EMS_ReleatBGX).w,a2			; load BG X position
		bsr.s	MSSC_Decelerate				; perform deceleration
		lea	(EMS_WorldRotVS).w,a0			; load worlds' rotation V speed
		lea	(EMS_WorldRotV).w,a1			; load worlds' rotation V position
		lea	(EMS_ReleatBGY).w,a2			; load BG Y position
		bsr.s	MSSC_Decelerate				; perform deceleration

		move.l	(EMS_SelectRout).w,d0			; load controls routine
		bne.s	MSSC_Valid				; if it's valid, branch
		move.l	#MSSC_ModeIn,d0				; set new routine
		move.l	d0,(EMS_SelectRout).w			; ''

MSSC_Valid:
		movea.l	d0,a0					; set address
		jmp	(a0)					; run the routine

; ===========================================================================
; ---------------------------------------------------------------------------
; Mode select - IN
; ---------------------------------------------------------------------------

MSSC_ModeIn:
		lea	(EMS_BGPalette).w,a1			; set mode select BG colours to use
		lea	(MSS_Palette+$20+$10).l,a0		; load initial menu background colours
		move.l	(a0)+,(a1)+				; copy colours
		move.w	(a0)+,(a1)+				; ''

		subq.b	#$01,(EMS_WindowSizeX).w		; move window in...
		beq.s	MSSC_MI_Finish				; if the window has fully loaded in, branch
		bsr.W	MSSC_AutoScrollFast			; perform automatic scrolling

	; load mappings?

MSSC_NoControls:
		rts						; return

MSSC_MI_Finish:
		move.l	#MSSC_ModeSelect,(EMS_SelectRout).w	; set routine

; ===========================================================================
; ---------------------------------------------------------------------------
; Controlling the mode select
; ---------------------------------------------------------------------------

MSSC_ModeSelect:
		bsr.w	MSSC_AutoScrollFast			; perform automatic scrolling
		tst.b	(EMS_FadeCount).w			; is the screen still fading in?
		bne.s	MSSC_NoControls				; if so, branch
		move.b	(Ctrl_1_pressed).w,d0			; load pressed controls
		bpl.s	MSSM_NoStart				; if start was not pressed, branch

MSSM_Select:
		moveq	#$63,d0					; play checkpoint sound
		jsr	Play_Sound_2.w				; ''
		move.l	#MSSC_ModeToLevel,(EMS_SelectRout).w	; set routine
		move.b	(ESS_StageP1).w,(EMS_CurLevel).w	; set to view the EXACT level/stage
		bra.w	MSS_LoadStage				; load current stage

MSSM_NoStart:
		add.b	d0,d0					; check A and C
		add.b	d0,d0					; ''
		bcs.s	MSSM_Select				; if either were pressed, branch
		bmi.s	MSSM_Select				; ''
		add.b	d0,d0					; check B
		bpl.s	MSSM_NoB				; if not pressed, branch
		move.l	#MSSC_ModeOut,(EMS_SelectRout).w	; set routine
		rts						; return

MSSM_NoB:
		move.b	(ESS_StageMode).w,d2			; load stage mode
		addq.b	#$02,d2					; prep for wrapping
		lsl.b	#$03,d0					; check down
		bpl.s	MSSM_NoDown				; if not pressed, branch
		addq.b	#$01,d2					; go down a mode

MSSM_NoDown:
		add.b	d0,d0					; check up
		bpl.s	MSSM_NoUp				; if not pressed, branch
		subq.b	#$01,d2					; go up a mode

MSSM_NoUp:
		andi.b	#$03,d2					; keep within the four modes
		subq.b	#$02,d2					; restore
		move.b	d2,(ESS_StageMode).w			; save stage mode
		move.b	(EMS_StagePrev).w,d0			; load previous stage mode
		cmp.b	d2,d0					; has it changed?
		beq.s	MSSM_ModeNoChange			; if not, branch
		bsr.w	MSS_GreyOut				; grey out the previous mode
		move.b	(ESS_StageMode).w,d0			; load new stage mode
		move.b	d0,(EMS_StagePrev).w			; set as previous mode
		bsr.w	MSS_WhiteOut				; make new selection white
		bsr.w	MSS_UpdateSphereArt			; update the sphere art
		moveq	#$5B,d0					; play beep SFX
		jsr	Play_Sound_2.w				; ''

	st.b	(EMS_LevelPrev).w			; force stage ID to update...
	bsr.w	MSSC_LS_Display				; update display for level select menu

MSSM_ModeNoChange:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Mode select - OUT
; ---------------------------------------------------------------------------

MSSC_ModeOut:
		bsr.w	MSSC_AutoScrollFast			; perform automatic scrolling
		st.b	(EMS_FadeCount).w			; set fade counter/flag (to stop the BG fading from occuring)
		jsr	Pal_ToBlack				; fade out
		move.b	(EMS_WindowSizeX).w,d0			; load window size
		addq.b	#$01,d0					; close the window
		cmpi.b	#$14,d0					; has it fully closed?
		blt.s	MSSC_MO_Continue			; if not, branch
		move.b	#$04,(Game_mode).w			; set game mode to 04 (Main Menu)
		bra.w	MSSC_ChangeMode				; continue to change the game moDe

MSSC_MO_Continue:
		move.b	d0,(EMS_WindowSizeX).w			; update window position
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Mode select to Level select
; ---------------------------------------------------------------------------

MSSC_ModeToLevel:
		bsr.s	MSSC_AutoScrollFast			; perform automatic scrolling
		move.b	(EMS_WindowSizeX).w,d0			; load window size
		addq.b	#$01,d0					; close the window
		cmpi.b	#$14,d0					; has it fully closed?
		blt.s	MSSC_MTL_Continue			; if not, branch
		st.b	(EMS_PlanetsOn).w			; turn the planets (and sprites) on
		move.l	#MSSC_LevelIn,(EMS_SelectRout).w	; set the next routine
		move.l	#$FF500000,(EMS_HScrollPos1).w		; set starting positions for the planets
		move.l	#$FF500000,(EMS_HScrollPos2).w		; ''
	move.l	#EMS_MenuMap_LVL&$FFFFFF,(EMS_MapAddress).w ; set new map buffer to use

MSSC_MTL_Continue:
		move.b	d0,(EMS_WindowSizeX).w			; update window position
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to automatically scroll the planet (and backgrounds)
; ---------------------------------------------------------------------------

	; --- Faster version ---

MSSC_AutoScrollFast:
		move.l	(EMS_HScrollPos1).w,d0			; load X position
		asr.l	#$08,d0					; slow it down
		asr.l	#$07,d0					; ''
		sub.l	d0,(EMS_ReleatBGX).w			; add to BG scroll X position
		bra.s	MSSC_AS_Run				; continue to do Y auto-scrolling

	; --- Level Select version ---

MSSC_AutoScroll:
		tst.b	(EMS_LevelChange).w			; is the level changing forwards?
		bgt.w	MSSC_Cycle_NoAuto			; if so, branch to ignore auto speed
		move.w	(EMS_WorldRotHS).w,d2			; load Horizontal speed
		addi.w	#MSS_ACCELLERATE,d2			; rotate the world right
		cmpi.w	#MSS_IDLEROTATEH,d2			; is it at maximum speed?
		ble.s	MSSC_Cycle_NoAutoH			; if not, branch
		subi.w	#MSS_DECELLERATE+MSS_ACCELLERATE,d2	; decrease the speed back

MSSC_Cycle_NoAutoH:
		move.w	d2,(EMS_WorldRotHS).w			; update speed

MSSC_AS_Run:
		move.w	(EMS_WorldRotVS).w,d2			; load Horizontal speed
		addi.w	#MSS_ACCELLERATE,d2			; rotate the world right
		cmpi.w	#MSS_IDLEROTATEV,d2			; is it at maximum speed?
		ble.s	MSSC_Cycle_NoAutoV			; if not, branch
		subi.w	#MSS_DECELLERATE+MSS_ACCELLERATE,d2	; decrease the speed back

MSSC_Cycle_NoAutoV:
		move.w	d2,(EMS_WorldRotVS).w			; update speed

MSSC_Cycle_NoAuto:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Level select to Mode select
; ---------------------------------------------------------------------------

MSSC_LevelToMode:
		bsr.s	MSSC_AutoScrollFast			; perform automatic scrolling

		move.l	(EMS_HScrollPos1).w,d0			; load position
		subi.l	#$00020000,d0				; increase speed
		bmi.s	MSSC_LTM_Speed1OK			; if negative, branch
		move.l	#-$00020000,d0				; just in-case it's positive, we don't want the planet to go the other way

MSSC_LTM_Speed1OK:
		add.l	d0,(EMS_HScrollPos1).w			; move planet out
		cmpi.w	#$FF50,(EMS_HScrollPos1).w		; is the planet fully out?
		bgt.s	MSSC_LTM_NoStop1			; if not, branch
		move.l	#$FF500000,(EMS_HScrollPos1).w		; lock planet in place off of screen

MSSC_LTM_NoStop1:
		move.l	(EMS_HScrollPos2).w,d0			; load position
		subi.l	#$00008000,d0				; increase speed
		bmi.s	MSSC_LTM_Speed2OK			; if negative, branch
		move.l	#-$00008000,d0				; just in-case it's positive, we don't want the planet to go the other way

MSSC_LTM_Speed2OK:
		add.l	d0,(EMS_HScrollPos2).w			; move planet out
		cmpi.w	#$FF50,(EMS_HScrollPos2).w		; is the planet fully out?
		bgt.s	MSSC_LTM_NoStop2			; if not, branch
		move.l	#$FF500000,(EMS_HScrollPos2).w		; lock planet in place off of screen

MSSC_LTM_NoStop2:
		move.b	(EMS_WindowSizeX).w,d0			; load window size
		addq.b	#$01,d0					; close the window
		cmpi.b	#$14,d0					; has it fully closed?
		blt.s	MSSC_LTM_Continue			; if not, branch
		moveq	#$14,d0					; keep it at fully closed
		cmpi.w	#$FF50,(EMS_HScrollPos1).w		; ensure both planets are off screen BEFORE switching...
		bgt.s	MSSC_LTM_Continue			; ''
		cmpi.w	#$FF50,(EMS_HScrollPos2).w		; ''
		bgt.s	MSSC_LTM_Continue			; ''
		sf.b	(EMS_PlanetsOn).w			; turn the planets (and sprites) off
		move.l	#MSSC_ModeIn,(EMS_SelectRout).w		; set the next routine
	move.l	#EMS_MenuMap_MAI&$FFFFFF,(EMS_MapAddress).w ; set new map buffer to use

MSSC_LTM_Continue:
		move.b	d0,(EMS_WindowSizeX).w			; update window position
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Level select - IN
; ---------------------------------------------------------------------------

MSSC_LevelIn:
		bsr.w	MSSC_AutoScroll				; perform automatic scrolling
		moveq	#$02,d1					; prepare finish counter (2 positions)
		move.l	(EMS_HScrollPos1).w,d0			; load position
		asr.l	#$01,d0					; reduce distance
		sub.l	d0,(EMS_HScrollPos1).w			; move top planet towards destination
		swap	d0					; get only quotient
		addq.w	#$01,d0					; convert from FFFF to 0000 (cannot beq for negative)
		bne.s	MSSC_LI_NoFinish1			; if not finished, branch
		subq.b	#$01,d1					; decrease finish counter

MSSC_LI_NoFinish1:
		move.l	(EMS_HScrollPos2).w,d0			; load position
		asr.l	#$02,d0					; reduce distance
		sub.l	d0,(EMS_HScrollPos2).w			; move top planet towards destination
		swap	d0					; get only quotient
		addq.w	#$01,d0					; convert from FFFF to 0000 (cannot beq for negative)
		bne.s	MSSC_LI_NoFinish2			; if not finished, branch
		subq.b	#$01,d1					; decrease finish counter
		ble.s	MSSC_LI_YesFinish			; if both positions have finished, branch

MSSC_LI_NoFinish2:
		move.w	(EMS_HScrollPos1).w,d0			; have both positions finished?
		or.w	(EMS_HScrollPos2).w,d0			; ''
		bne.s	MSSC_LI_NoFinish			; if not, branch

MSSC_LI_YesFinish:
		moveq	#$00,d0					; clear the fractions
		move.w	d0,(EMS_HScrollPos1+2).w		; ''
		move.w	d0,(EMS_HScrollPos2+2).w		; ''
		move.l	#MSSC_LevelSelect,(EMS_SelectRout).w	; set routine
		rts						; return

MSSC_LI_NoFinish
		move.b	(EMS_WindowSizeX).w,d0			; load window size
		subq.b	#$01,d0					; open the window
		cmpi.b	#$0A,d0					; has it opened?
		bgt.s	MSSC_LI_Continue			; if not, branch
		moveq	#$0A,d0					; keep it open

MSSC_LI_Continue:
		move.b	d0,(EMS_WindowSizeX).w			; update window position
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Controlling the level select
; ---------------------------------------------------------------------------

MSSC_LevelSelect:
		bsr.w	MSSC_LS_Control				; run controls first
		bsr.w	MSSC_LS_Display				; run display update next
		rts						; return

MSSC_LS_Control:
		move.b	(Ctrl_1_held).w,d1			; load held controls
		move.b	(Ctrl_1_pressed).w,d0			; load pressed controls
		bpl.s	MSSC_NoStart				; if start was not pressed, branch

MSSC_PlayLevel:
		move.l	#MSSC_Play,(EMS_SelectRout).w		; set routine to run
		move.l	#MSSRS_Idle,(EMS_ObjectRout).w		; set to run idle routine
		moveq	#$63,d0					; play checkpoint sound
		jmp	Play_Sound_2.w				; ''

MSSC_ChangeMode:
		st.b	(V_int_routine).w			; set 68k as ready
		jsr	Wait_VSync				; wait for V-blank
		move.w	#$8AFF,($C00004).l			; set H-blank interrupt line to prevent after interruptions
		move.l	#NullRTE,(H_int_addr).w			; set H-blank routine
		move.l	#Vint,(V_int_addr).w			; set V-blank routine
		addq.w	#$04*2,sp				; skip return (and loop) addresses
		rts						; return

MSSC_NoStart:
		add.b	d0,d0					; check C
		add.b	d0,d0					; ''
		bmi.s	MSSC_PlayLevel				; if C was pressed, branch

MSSC_NoC:
		tst.b	(EMS_Return).w				; was B pressed previously?
		bne.s	MSSC_CheckBAgain			; if so, branch
		add.b	d0,d0					; check B
		bpl.s	MSSC_NoB				; if B was not pressed, branch
		st.b	(EMS_Return).w				; set B as been pressed

MSSC_CheckBAgain:
		tst.b	(EMS_LevelChange).w			; is the level already changing?
		bne.s	MSSC_NoReturn				; if so, branch (not while changing levels)
		tst.b	(EMS_FastMode).w			; is fast mode enabled?  (Means the levels are still changing but we happen to have stopped at a slot)
		bne.s	MSSC_NoReturn				; if so, branch (not while changing levels)
		sf.b	(EMS_Return).w				; set B as not been pressed
		move.l	#MSSC_LevelToMode,(EMS_SelectRout).w	; set routine
		moveq	#$6B,d0					; play sphere flying sound
		jsr	Play_Sound_2.w				; ''


MSSC_NoReturn:
		bra.w	MSSC_AutoScroll				; perform automatic scrolling

MSSC_NoB:
		rol.b	#$03,d1					; rotate D-pad buttons towards MSB
		tst.b	(EMS_LevelChange).w			; is the level already changing?
		bne.s	MSSC_NoViewMode				; if so, branch (don't want view mode to be able to run while changing levels)
		tst.b	(EMS_FastMode).w			; is fast mode enabled?  (Means the levels are still changing but we happen to have stopped at a slot)
		bne.s	MSSC_NoViewMode				; if so, branch (don't want view mode to be able to run while changing levels)
		btst.l	#$01,d1					; is A being held?
		bne.w	MSSC_ViewMode				; if so, branch for "viewing" mode

		; Auto-scrolling

MSSC_NoViewMode:
		bsr.w	MSSC_AutoScroll				; perform automatic scrolling

	; --- Cycle mode (cycling through the levels) ---

		add.b	d1,d1					; check right
		bpl.s	MSSC_Cycle_NoRight			; if not pressed, branch
	nop

MSSC_Cycle_NoRight:
		add.b	d1,d1					; check left
		bpl.s	MSSC_Cycle_NoLeft			; if not pressed, branch
	nop

MSSC_Cycle_NoLeft:
		lsl.b	#$03,d0					; check down
		bpl.s	MSSC_Cycle_NoDown			; if not pressed, branch
		subq.b	#$01,(ESS_StageP1).w			; decrease level ID
		bpl.s	MSSC_Cycle_Down				; if it hasn't dropped below 00, branch
		sf.b	(ESS_StageP1).w				; keep at 00
		bra.s	MSSC_Cycle_NoDown			; continue

MSSC_Cycle_Down:
		move.b	d0,d2					; store pressed controls
		moveq	#$5B,d0					; play beep SFX
		jsr	Play_Sound_2.w				; ''
		move.b	d2,d0					; restore pressed controls

MSSC_Cycle_NoDown:
		add.b	d0,d0					; check up
		bpl.s	MSSC_Cycle_NoUp				; if not pressed, branch
		move.b	(EMS_LevelCount).w,d0			; load level count
		cmp.b	(ESS_StageP1).w,d0			; is the stage already at the maximum?
		beq.s	MSSC_Cycle_NoUp				; if so, branch (don't change level ID)
		addq.b	#$01,(ESS_StageP1).w			; increase level ID
		moveq	#$5B,d0					; play beep SFX
		jsr	Play_Sound_2.w				; ''

MSSC_Cycle_NoUp:
		tst.b	(EMS_LevelChange).w			; is the level already changing?
		bne.s	MSSC_NoChange				; if so, branch
		move.b	(ESS_StageP1).w,d0			; load level ID
		sub.b	(EMS_CurLevel).w,d0			; load current displaying level
		beq.s	MSSC_NoChange				; if they match, branch
		bmi.s	MSSC_MoveBack				; if the destination level is lower, branch
		move.b	#$7F,(EMS_LevelChange).w		; set to move forwards
		addq.b	#$01,(EMS_CurLevel).w			; increase level ID
		move.l	#MSSRS_Fly,(EMS_ObjectRout).w		; set transition routine
;	moveq	#$66,d0					; make a buzzer sound
;	jsr	Play_Sound_2.w				; ''
		bra.s	MSSC_NoChange				; continue

MSSC_MoveBack:
		st.b	(EMS_LevelChange).w			; set to move backwards
		subq.b	#$01,(EMS_CurLevel).w			; decrease level ID
		move.l	#MSSRS_Fly,(EMS_ObjectRout).w		; set transition routine
;	moveq	#$66,d0					; make a buzzer sound
;	jsr	Play_Sound_2.w				; ''

MSSC_NoChange:

	; --- Whiting button mappings ---

		bclr.b	#$07,(EMS_ButAniFlag).w			; set to button animate/White out flag
		beq.s	MSSC_AlreadyWhite			; if it's already set, branch
		move.l	#$80008000,d0				; prepare OR value (to set tiles to high plane)

		movea.l	(EMS_MapAddress).w,a1			; load mappings address
		adda.w	#WindMap($16,$13)+4,a1			; advance to button position
		moveq	#$0F-1,d1				; width of "A" and "B" lines
		bra.s	MSSC_WhiteStart				; jump into loop

MSSC_WhiteOut:
		or.l	d0,(a1)+				; set "A" string tiles to high plane

MSSC_WhiteStart:
		or.l	d0,(a1)					; set "B" string tiles to high plane
		lea	$40-4(a1),a1				; advance to next column
		dbf	d1,MSSC_WhiteOut			; repeat for entire width of strings

		movea.l	(EMS_MapAddress).w,a1			; load mappings address
		adda.w	#WindMap($16,$02),a1			; advance to stage text
		moveq	#$0D-1,d1				; width of text

MSSC_WhiteStage:
		or.l	d0,(a1)					; set text to high plane
		lea	$40(a1),a1				; advance to next column
		dbf	d1,MSSC_WhiteStage			; repeat for all columns

		movea.l	(EMS_MapAddress).w,a1			; load mappings address
		adda.w	#WindMap($1B,$00),a1			; advance to arrows
		move.b	(ESS_StageP1).w,d1			; load stage ID
		cmp.b	(EMS_LevelCount).w,d1			; is the stage ID at the end?
		beq.s	MSSC_NoWhiteUp				; if so, branch (don't make the arrow high plane)
		or.w	d0,$02(a1)				; force the up arrow to high plane
		or.l	d0,$40(a1)				; ''
		or.w	d0,$82(a1)				; ''
		tst.b	d1					; is the stage ID at the beginning?
		beq.s	MSSC_NoWhiteDown			; if so, branch (don't make the arrow high plane)

MSSC_NoWhiteUp:
		or.w	d0,$08(a1)				; force the down arrow to high plane
		or.l	d0,$48(a1)				; ''
		or.w	d0,$88(a1)				; ''

MSSC_NoWhiteDown:
		move.l	#$16130E03,d1				; XX YY WW HH to transfer to VRAM
		bsr.w	MSS_SetupTransfer			; perform transfer
		move.l	#$16020C03,d1				; XX YY WW HH to transfer to VRAM
		bsr.w	MSS_SetupTransfer			; perform transfer
		move.l	#$1B000205,d1				; XX YY WW HH to transfer to VRAM
		bsr.w	MSS_SetupTransfer			; perform transfer

MSSC_AlreadyWhite:
		rts						; return

	; --- View mode (rotating the planet) ---

MSSC_ViewMode:
		move.w	(EMS_WorldRotHS).w,d2			; load Horizontal speed
		add.b	d1,d1					; check right
		bpl.s	MSSC_View_NoRight			; if not pressed, branch
		subi.w	#MSS_ACCELLERATE,d2			; rotate the world left
		cmpi.w	#-MSS_MAXROTATE,d2			; is it at maximum speed?
		bge.s	MSSC_View_NoRight			; if not, branch
		move.w	#-MSS_MAXROTATE,d2			; force to maximum speed

MSSC_View_NoRight:
		add.b	d1,d1					; check left
		bpl.s	MSSC_View_NoLeft			; if not pressed, branch
		addi.w	#MSS_ACCELLERATE,d2			; rotate the world right
		cmpi.w	#MSS_MAXROTATE,d2			; is it at maximum speed?
		ble.s	MSSC_View_NoLeft			; if not, branch
		move.w	#MSS_MAXROTATE,d2			; force to maximum speed

MSSC_View_NoLeft:
		move.w	d2,(EMS_WorldRotHS).w			; update speed
		move.w	(EMS_WorldRotVS).w,d2			; load Vertical speed
		add.b	d1,d1					; check down
		bpl.s	MSSC_View_NoDown			; if not pressed, branch
		subi.w	#MSS_ACCELLERATE,d2			; rotate the world up
		cmpi.w	#-MSS_MAXROTATE,d2			; is it at maximum speed?
		bge.s	MSSC_View_NoDown			; if not, branch
		move.w	#-MSS_MAXROTATE,d2			; force to maximum speed

MSSC_View_NoDown:
		add.b	d1,d1					; check up
		bpl.s	MSSC_View_NoUp				; if not pressed, branch
		addi.w	#MSS_ACCELLERATE,d2			; rotate the world down
		cmpi.w	#MSS_MAXROTATE,d2			; is it at maximum speed?
		ble.s	MSSC_View_NoUp				; if not, branch
		move.w	#MSS_MAXROTATE,d2			; force to maximum speed

MSSC_View_Noup:
		move.w	d2,(EMS_WorldRotVS).w			; update speed

	; --- Greying button mappings ---

		bset.b	#$07,(EMS_ButAniFlag).w			; set to button animate/grey out flag
		bne.s	MSSC_AlreadyGrey			; if it's already set, branch
		move.l	#$7FFF7FFF,d0				; prepare AND value (to set tiles to low plane)

		movea.l	(EMS_MapAddress).w,a1			; load mappings address
		adda.w	#WindMap($16,$13),a1			; advance to button position
		moveq	#$0F-1,d1				; width of "A" and "B" lines

MSSC_GreyOut:
		and.l	d0,(a1)+				; set "A" string tiles to low plane
		and.l	d0,(a1)					; set "B" string tiles to low plane
		lea	$40-4(a1),a1				; advance to next column
		dbf	d1,MSSC_GreyOut				; repeat for entire width of strings

		movea.l	(EMS_MapAddress).w,a1			; load mappings address
		adda.w	#WindMap($16,$02),a1			; advance to stage text
		moveq	#$0D-1,d1				; width of text

MSSC_GreyStage:
		and.l	d0,(a1)					; set text to low plane
		lea	$40(a1),a1				; advance to next column
		dbf	d1,MSSC_GreyStage			; repeat for all columns

		movea.l	(EMS_MapAddress).w,a1			; load mappings address
		adda.w	#WindMap($1B,$00),a1			; advance to arrows
		and.w	d0,$02(a1)
		and.w	d0,$08(a1)
		and.l	d0,$40(a1)
		and.l	d0,$48(a1)
		and.w	d0,$82(a1)
		and.w	d0,$88(a1)

		move.l	#$16130E03,d1				; XX YY WW HH to transfer to VRAM
		bsr.w	MSS_SetupTransfer			; perform transfer
		move.l	#$16020C03,d1				; XX YY WW HH to transfer to VRAM
		bsr.w	MSS_SetupTransfer			; perform transfer
		move.l	#$1B000205,d1				; XX YY WW HH to transfer to VRAM
		bsr.w	MSS_SetupTransfer			; perform transfer

MSSC_AlreadyGrey:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Playing a new level (when selected)
; ---------------------------------------------------------------------------

MSSC_Play:
		bsr.w	MSSC_AutoScrollFast			; perform automatic scrolling

		move.l	(EMS_HScrollPos1).w,d0			; load position
		subi.l	#$00020000,d0				; increase speed
		bmi.s	MSSC_PL_Speed1OK			; if negative, branch
		move.l	#-$00020000,d0				; just in-case it's positive, we don't want the planet to go the other way

MSSC_PL_Speed1OK:
		add.l	d0,(EMS_HScrollPos1).w			; move planet out
		cmpi.w	#$FF50,(EMS_HScrollPos1).w		; is the planet fully out?
		bgt.s	MSSC_PL_NoStop1				; if not, branch
		move.l	#$FF500000,(EMS_HScrollPos1).w		; lock planet in place off of screen

MSSC_PL_NoStop1:
		move.l	(EMS_HScrollPos2).w,d0			; load position
		subi.l	#$00008000,d0				; increase speed
		bmi.s	MSSC_PL_Speed2OK			; if negative, branch
		move.l	#-$00008000,d0				; just in-case it's positive, we don't want the planet to go the other way

MSSC_PL_Speed2OK:
		add.l	d0,(EMS_HScrollPos2).w			; move planet out
		cmpi.w	#$FF50,(EMS_HScrollPos2).w		; is the planet fully out?
		bgt.s	MSSC_PL_NoStop2				; if not, branch
		move.l	#$FF500000,(EMS_HScrollPos2).w		; lock planet in place off of screen

MSSC_PL_NoStop2:
		move.b	(EMS_WindowSizeX).w,d0			; load window size
		addq.b	#$01,d0					; close the window
		cmpi.b	#$14,d0					; has it fully closed?
		blt.s	MSSC_PL_Continue			; if not, branch
		moveq	#$14,d0					; keep it at fully closed
		move.b	d0,(EMS_WindowSizeX).w
		cmpi.w	#$FF50,(EMS_HScrollPos1).w		; ensure both planets are off screen BEFORE switching...
		bgt.s	MSSC_PL_Continue			; ''
		cmpi.w	#$FF50,(EMS_HScrollPos2).w		; ''
		bgt.s	MSSC_PL_Continue			; ''
		sf.b	(EMS_PlanetsOn).w			; turn the planets (and sprites) off
		move.b	#$64,(Game_mode).w			; set game mode to 04 (Main Menu)
		bra.w	MSSC_ChangeMode				; continue to change the game mode

MSSC_PL_Continue:
		move.b	d0,(EMS_WindowSizeX).w			; update X size
		st.b	(EMS_FadeCount).w			; set fade counter/flag (to stop the BG fading from occuring)
		jmp	Pal_ToWhite				; fade out

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to update the displaying of the level select menu
; ---------------------------------------------------------------------------

MSSC_LS_Display:
		lea	(EMS_MenuMap_LVL).l,a4			; load mappings address
		subq.b	#$01,(EMS_CharAniTime).w		; decrease animation timer
		bpl.s	MSSC_LS_NoChar				; if still running, branch
		move.b	#20,(EMS_CharAniTime).w			; reset timer
		move.w	#EMS_SONICA,d1				; set character mappings to use
		not.b	(EMS_CharAniSlot).w			; change slot
		beq.s	MSSC_LS_CharA				; if we're on slot A, branch
		move.w	#EMS_SONICB,d1				; set character mappings to use

MSSC_LS_CharA:
		move.w	#WindMap($17,$0D),d0			; position
		bsr.w	MSS_DrawCharacter			; draw the character
		move.l	#$170D0102,d1				; XX YY WW HH to transfer to VRAM
		bsr.w	MSS_SetupTransfer			; perform transfer

MSSC_LS_NoChar:
		moveq	#$00,d0					; clear d0
		move.b	(ESS_StageP1).w,d0			; load stage ID
		cmp.b	(EMS_LevelPrev).w,d0			; has it changed?
		beq.w	MSSC_LS_NoLevel				; if not, branch

		tst.b	d0					; is the number slot 00?
		bne.s	MSSC_LS_NoRandText			; if not, branch

		move.w	#WindMap($17,$02),d0			; position
		lea	(STR_Random).l,a2			; string
		sf.b	d1					; DO NOT render sides
		bsr.w	MSS_DrawTitle				; draw the text box
		move.l	#$17020901,d1				; XX YY WW HH to transfer to VRAM
		bsr.w	MSS_SetupTransfer			; perform transfer
		bra.s	MSSC_LS_RandText			; continue to next routine

MSSC_LS_NoRandText:
		move.b	d0,d1					; load digits
		move.w	#WindMap($1F,$02),d0			; position
		moveq	#$02-1,d2				; number of digits to draw
		bsr.w	MSS_DrawNumber				; draw the digits
		move.l	#$1F020101,d1				; XX YY WW HH to transfer to VRAM
		bsr.w	MSS_SetupTransfer			; perform transfer
		tst.b	(EMS_LevelPrev).w			; was the level on slot 00 before?
		bne.s	MSSC_LS_RandText			; if not, branch
		move.w	#WindMap($17,$02),d0			; position
		lea	(STR_Stage).l,a2			; string
		sf.b	d1					; DO NOT render sides
		bsr.w	MSS_DrawTitle				; draw the text box
		move.l	#$17020901,d1				; XX YY WW HH to transfer to VRAM
		bsr.w	MSS_SetupTransfer			; perform transfer

MSSC_LS_RandText:
		move.l	#$7FFF7FFF,d1				; prepare low plane AND bits
		move.l	#$80008000,d0				; prepare high plane OR bits
		lea	(EMS_MenuMap_LVL).l,a1			; load mappings address
		adda.w	#WindMap($1B,$00),a1			; advance to arrows
		and.w	d1,$02(a1)				; force the up arrow to low plane
		and.l	d1,$40(a1)				; ''
		and.w	d1,$82(a1)				; ''
		move.b	(ESS_StageP1).w,d2			; load stage ID
		cmp.b	(EMS_LevelCount).w,d2			; is the stage ID at the end?
		beq.s	MSSC_LS_NoWhiteUp			; if so, branch (don't make the arrow high plane)
		or.w	d0,$02(a1)				; force the up arrow to high plane
		or.l	d0,$40(a1)				; ''
		or.w	d0,$82(a1)				; ''
		and.w	d1,$08(a1)				; force the down arrow to low plane
		and.l	d1,$48(a1)				; ''
		and.w	d1,$88(a1)				; ''
		tst.b	d2					; is the stage ID at the beginning?
		beq.s	MSSC_LS_NoWhiteDown			; if so, branch (don't make the arrow high plane)

MSSC_LS_NoWhiteUp:
		or.w	d0,$08(a1)				; force the down arrow to high plane
		or.l	d0,$48(a1)				; ''
		or.w	d0,$88(a1)				; ''

MSSC_LS_NoWhiteDown:
		move.l	#$1B000205,d1				; XX YY WW HH to transfer to VRAM
		bsr.w	MSS_SetupTransfer			; perform transfer

		moveq	#$00,d0					; clear d0
		move.b	(ESS_StageP1).w,d0			; load stage ID
		move.b	d0,(EMS_LevelPrev).w			; update previous
		add.w	d0,d0					; multiply by size of word
		lea	(SP_Stages).l,a2			; load stage list
		adda.w	(a2,d0.w),a2				; load correct stage data
		pea	(a2)					; store stage address
		lea	-$22(a2),a2				; goto game name
		move.w	#WindMap($1B,$06),d0			; position
		bsr.w	MSS_DrawCaption				; draw the caption
		move.w	#WindMap($1C,$08),d0			; position
		bsr.w	MSS_DrawCaption				; draw the caption
		move.w	#WindMap($21,$09),d0			; position
		bsr.w	MSS_DrawCaption				; draw the caption
		move.l	#$1B060803,d1				; XX YY WW HH to transfer to VRAM
		bsr.w	MSS_SetupTransfer			; perform transfer
		move.l	(sp)+,a2				; reload stage address

		moveq	#$00,d1					; reset blue sphere count to 0
		moveq	#$00,d5					; reset orange sphere count to 0
		tst.b	(ESS_StageP1).w				; is this stage 1?
		beq.w	MSSC_LS_FinishCount			; if so, branch (Random stage shouldn't have any spheres)
		lea	4+6+3+3(a2),a2				; advance to layout data
		move.w	#($20*$20)-1,d7				; set number of rows to check

MSSC_LS_CountSpheres:
		move.b	(a2)+,d0				; load sphere
		subq.b	#$02,d0					; subtract blue to 0
		bne.s	MSSC_LS_NoBlue				; if it's not blue, branch
		addq.w	#$01,d1					; increase blue sphere count by 1
		dbf	d7,MSSC_LS_CountSpheres			; repeat for entire layout
		bra.s	MSSC_LS_FinishCount			; continue to save count

MSSC_LS_NoBlue:
		subq.b	#$01,d0					; check for orange sphere
		bne.s	MSSC_LS_NoOrange			; if there's no orange, branch
		addq.w	#$01,d5					; increase orange sphere count by 1

MSSC_LS_NoOrange:
		dbf	d7,MSSC_LS_CountSpheres			; repeat for entire layout

MSSC_LS_FinishCount:
		move.w	d1,(EMS_CountBlue).w			; save blue count
		move.w	d5,(EMS_CountOrange).w			; save orange count

		cmpi.w	#999,d1					; is the maximum blue amount reached?
		bls.s	MSSC_LS_NoMaxBlue			; if not, branch
		move.w	#999,d1					; set to maximum

MSSC_LS_NoMaxBlue:
		cmpi.w	#999,d5					; is the maximum orange amount reached?
		bls.s	MSSC_LS_NoMaxOrange			; if not, branch
		move.w	#999,d5					; set to maximum

MSSC_LS_NoMaxOrange:
		tst.b	(ESS_StageMode).w			; is the game mode "get opponents' spheres"?
		bgt.s	MSSC_LS_Split				; if so, branch
		add.w	d5,d1					; add orange to blue (total sphere count)
		moveq	#$00,d5					; clear orange count (must be ring count now)
		cmpi.w	#999,d1					; are the total amount at maximum?
		bls.s	MSSC_LS_Split				; if not, branch
		move.w	#999,d1					; force to maximum

MSSC_LS_Split:
		move.w	#WindMap($1B,$0C),d0			; position
		bsr.w	MSS_DrawCount				; draw the counter
		move.w	#WindMap($1B,$0F),d0			; position
		move.w	d5,d1					; numbers to draw
		bsr.w	MSS_DrawCount				; draw the counter
		move.l	#$1B0C0504,d1				; XX YY WW HH to transfer to VRAM
		bsr.w	MSS_SetupTransfer			; perform transfer

MSSC_LS_NoLevel:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to scroll the BG correctly based on the rotation of the planets
; and the cycling of the levels, and the FG planet positioning
; ---------------------------------------------------------------------------

MSS_ScrollPlane:

	; --- FG Planet ---

		move.l	(EMS_HScrollPos2).w,d0			; load H-scroll position
		move.w	(EMS_HScrollPos2).w,d0			; '' (double word)
		move.l	d0,d1					; copy to other registers
		move.l	d0,d2					; ''
		move.l	d0,d3					; ''
		move.l	d0,d4					; ''
		move.l	d0,d5					; ''
		move.l	d0,d6					; ''
		move.l	d0,d7					; ''
		move.l	d0,a0					; ''
		move.l	d0,a1					; ''
		move.l	d0,a2					; ''
		move.l	d0,a3					; ''
		lea	(EMS_HScrollFG+$1C0).w,a4		; load H-scroll table

	rept	6
		movem.l	d0-a3,-(a4)				; transfer positions to table
	endm

		move.l	(EMS_HScrollPos1).w,d0			; load H-scroll position
		move.w	(EMS_HScrollPos1).w,d0			; '' (double word)
		move.l	d0,d1					; copy to other registers
		move.l	d0,d2					; ''
		move.l	d0,d3					; ''
		move.l	d0,d4					; ''
		move.l	d0,d5					; ''
		move.l	d0,d6					; ''
		move.l	d0,d7					; ''
		move.l	d0,a0					; ''
		move.l	d0,a1					; ''
		move.l	d0,a2					; ''
		move.l	d0,a3					; ''
	rept	3
		movem.l	d0-a3,-(a4)				; transfer positions to table
	endm
		movem.l	d0-d7,-(a4)				; last 10

	; --- BG Stars ---

		lea	(EMS_HScrollBG).w,a1			; load BG H-scroll table
		move.l	(EMS_ReleatBGX).w,d0			; load BG relative position
		neg.l	d0					; reverse direction
		asr.l	#$05,d0					; slow it down to fastest speed
		move.w	#$E0,d2					; number of scanlines to render
		moveq	#$00,d3					; clear d3

		move.w	d0,(EMS_ScrollBG1).w			; save all possible scroll speeds
		asr.l	#$01,d0					; ''
		move.w	d0,(EMS_ScrollBG2).w			; ''
		asr.l	#$01,d0					; ''
		move.w	d0,(EMS_ScrollBG3).w			; ''
		asr.l	#$01,d0					; ''
		move.w	d0,(EMS_ScrollBG4).w			; ''

		move.l	(EMS_ReleatBGY).w,d1			; load BG relative position
		asr.l	#$05,d1					; divide by 20
		andi.w	#$00FF,d1				; keep within the planes' Y size
		add.w	d1,d1					; multiply by size of word
		lea	MSSSBG_List(pc),a0			; load list
		adda.w	(a0,d1.w),a0				; advance to correct starting entry
		bra.s	MSSSBG_Start				; jump into the loop

MSSSBG_Continue:
		adda.w	(a0)+,a0				; advance to next entry in the list
		add.w	d1,d1					; multiply by size of word
		neg.w	d1					; convert to negative (to jump backwards)
		jsr	MSSSBG_Write(pc,d1.w)			; copy correct amount of scanlines over

MSSSBG_Start:
		movea.w	(a0)+,a2				; load scroll speed
		move.w	(a2),d0					; ''
		move.w	(a0)+,d1				; load count
		sub.w	d1,d2					; subtract from scanline count
		bcc.s	MSSSBG_Continue				; if not finished, branch
		add.w	d2,d1					; set d1 to remaining count
		add.w	d1,d1					; multiply by size of word
		neg.w	d1					; convert to negative (to jump backwards)
		jmp	MSSSBG_Write(pc,d1.w)			; copy correct amount of scanlines over
	rept	24
		move.w	d0,(a1)+				; save position to H-scroll table
	endm
MSSSBG_Write:	rts						; return

; ---------------------------------------------------------------------------
; Scroll list
; ---------------------------------------------------------------------------
ScrlPos		macro	ScanCount, Scroll
Count := ScanCount
		rept	ScanCount
		dc.w	Scroll, Count, (Count-1)*(3*2)
Count := Count-1
		endm
		endm
; ---------------------------------------------------------------------------

MSSSBG_List:

	; --- Pointer table ---

Count := 0
		rept	$100
		dc.w	((Count*(3*2))+($100*2))
Count := Count+1
		endm

	; --- Actual data ---

		rept	2
		ScrlPos	10, EMS_ScrollBG1&$FFFF
		ScrlPos	 8, EMS_ScrollBG3&$FFFF
		ScrlPos	 4, EMS_ScrollBG2&$FFFF
		ScrlPos	 8, EMS_ScrollBG1&$FFFF
		ScrlPos	10, EMS_ScrollBG3&$FFFF
		ScrlPos	 8, EMS_ScrollBG2&$FFFF
		ScrlPos	 8, EMS_ScrollBG1&$FFFF
		ScrlPos	 9, EMS_ScrollBG3&$FFFF
		ScrlPos	14, EMS_ScrollBG4&$FFFF
		ScrlPos	10, EMS_ScrollBG2&$FFFF
		ScrlPos	10, EMS_ScrollBG1&$FFFF
		ScrlPos	 7, EMS_ScrollBG2&$FFFF
		ScrlPos	 5, EMS_ScrollBG1&$FFFF
		ScrlPos	12, EMS_ScrollBG3&$FFFF
		ScrlPos	15, EMS_ScrollBG2&$FFFF
		ScrlPos	 7, EMS_ScrollBG1&$FFFF
		ScrlPos	 9, EMS_ScrollBG3&$FFFF
		ScrlPos	14, EMS_ScrollBG2&$FFFF
		ScrlPos	 9, EMS_ScrollBG1&$FFFF
		ScrlPos	 9, EMS_ScrollBG3&$FFFF
		ScrlPos	16, EMS_ScrollBG1&$FFFF
		ScrlPos	 8, EMS_ScrollBG2&$FFFF
		ScrlPos	24, EMS_ScrollBG3&$FFFF
		ScrlPos	 7, EMS_ScrollBG1&$FFFF
		ScrlPos	10, EMS_ScrollBG3&$FFFF
		ScrlPos	 5, EMS_ScrollBG2&$FFFF
		endm

; ===========================================================================
; ---------------------------------------------------------------------------
; Special stage colour sequence for level selects' planet
; ---------------------------------------------------------------------------

	;	dc.w	%CCCCCCCCCCCCCC	; first two colours are unused...

MSSC_List:	dc.w	%11111110000000
		dc.w	%01111111000000
		dc.w	%00111111100000
		dc.w	%00011111110000
		dc.w	%00001111111000
		dc.w	%00000111111100

		dc.w	%00000011111110
		dc.w	%00000111111100
		dc.w	%00001111111000
		dc.w	%00011111110000
		dc.w	%00111111100000
		dc.w	%01111111000000

		dc.w	%00000001111111
		dc.w	%10000000111111
		dc.w	%11000000011111
		dc.w	%11100000001111
		dc.w	%11110000000111
		dc.w	%11111000000011

		dc.w	%11111100000001
		dc.w	%11111000000011
		dc.w	%11110000000111
		dc.w	%11100000001111
		dc.w	%11000000011111
		dc.w	%10000000111111
MSSC_ListEnd:

	;	dc.w	%FCCCCCC	; F = Flip bit

MSSC_ListScale:	dc.w	%0111000
		dc.w	%0011100
		dc.w	%0001110
		dc.w	%1011100

		dc.w	%0000111
		dc.w	%0100011
		dc.w	%0110001
		dc.w	%1100011
MSSC_ListScaleEnd:

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control how the spheres display/operate
; ---------------------------------------------------------------------------

MSSRS_SetupObjects:
		moveq	#(EMS_ObjSize/$04)-1,d1			; size to clear

MSSRS_ClearObj:
		move.l	d0,(a0)+				; clear objects
		dbf	d1,MSSRS_ClearObj			; ''
		move.w	#EMS_MAXDIST,EMS_ObjDist-EMS_ObjSize(a0) ; ensure the spheres do-not display
		dbf	d7,MSSRS_SetupObjects			; ''
		move.l	#MSSRS_SetupDrop,(EMS_ObjectRout).w	; set starting routine

MSS_RunSpheres:
		lea	(Object_RAM).w,a0			; load object RAM
		moveq	#(EMS_OBJECTS)-1,d7			; set number of objects to control
		move.l	(EMS_ObjectRout).w,d0			; load routine
		beq.w	MSSRS_SetupObjects			; if invalid routine, branch
		movea.l	d0,a1					; set address
		jmp	(a1)					; run the address

; ===========================================================================
; ---------------------------------------------------------------------------
; Setting up spheres for a drop
; ---------------------------------------------------------------------------

MSSRS_TimerLst:	dc.w	$0014,$0010,$000C,$0008,$0004,$0000,$0008,$0010

MSSRS_SetupDrop:
		moveq	#$20,d0					; set starting timer
		lea	MSSRS_TimerLst(pc),a1

MSSRS_SD_SetObj:
		move.w	#EMS_MAXDIST,EMS_ObjDist(a0)		; set starting distance
		move.w	(a1)+,EMS_ObjTimer(a0)			; set starting delay timer
		move.l	#-$00080000,EMS_ObjSpeed(a0)		; set starting speed
		lea	EMS_ObjSize(a0),a0			; advance to next object
		dbf	d7,MSSRS_SD_SetObj			; repeat for all objects
		move.l	#MSSRS_Drop,(EMS_ObjectRout).w		; set next routine
		sf.b	(EMS_LevelChange).w			; clear level change flag (allow level to change)
		sf.b	(EMS_FastMode).w			; disable fast mode
		move.b	(ESS_StageP1).w,d0			; load level ID
		sub.b	(EMS_CurLevel).w,d0			; load current displaying level
		beq.w	MSSC_NoChange				; if they match, branch
		tst.b	(EMS_Return).w				; was B pressed (does the player want to return?)
		bne.s	MSSRS_Idle				; if so, branch (DO NOT ENABLE FAST MODE AGAIN)
		st.b	(EMS_FastMode).w			; if the level needs to scroll again, use fast mode now

MSSRS_Idle:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Making the spheres drop and bounce on the floor
; ---------------------------------------------------------------------------

MSSRS_Drop:
		move.w	d7,d5					; copy object count to d5

MSSRS_D_NextObj:
		cmpi.w	#$8000,EMS_ObjTimer(a0)			; has this object finished?
		beq.s	MSSRS_D_Finish				; if so, branch
		subq.w	#$01,EMS_ObjTimer(a0)			; decrease delay timer
		bpl.s	MSSRS_D_NoFinish			; if the timer is still counting, branch
		clr.w	EMS_ObjTimer(a0)			; keep timer at finish point
		move.l	EMS_ObjDist(a0),d0			; load distance from the world
		add.l	EMS_ObjSpeed(a0),d0			; add the speed
		bpl.s	MSSRS_D_OK				; if the spheres have not touched the floor yet, branch
		neg.l	d0					; bounce distance away from world
		neg.l	EMS_ObjSpeed(a0)			; reverse speed
		subi.l	#$00050000,EMS_ObjSpeed(a0)		; decrease speed a bit (friction/air resistence/whatever)
		bpl.s	MSSRS_D_OK				; if there is still speed bouncing away, branch
		clr.l	EMS_ObjSpeed(a0)			; set absolutely no speed
		clr.l	EMS_ObjDist(a0)				; force sphere to the floor
		move.w	#$8000,EMS_ObjTimer(a0)			; set the object as finished

MSSRS_D_Finish:
		dbf	d5,MSSRS_D_NoFinish			; decrease object counter
		move.l	#MSSRS_Idle,(EMS_ObjectRout).w		; set to run idle routine
		rts						; return

MSSRS_D_OK:
		move.l	d0,EMS_ObjDist(a0)			; update distance from world
		subi.l	#$00006000,EMS_ObjSpeed(a0)		; decrease speed

MSSRS_D_NoFinish:
		lea	EMS_ObjSize(a0),a0			; advance to next object
		dbf	d7,MSSRS_D_NextObj			; repeat for all objects
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Making the spheres drop and bounce on the floor
; ---------------------------------------------------------------------------

MSSRS_Fly:
		clr.w	(EMS_Planet2_YS).w			; set starting Y speed to 0
		move.l	#MSSRS_FlyRun,(EMS_ObjectRout).w	; set routine to constantly run

MSSRS_FlyRun:
		move.w	d7,d5					; copy object count to d5 for finish checking

MSSRS_F_RunNext:
		move.w	EMS_ObjDist(a0),d0			; load distance
		cmpi.w	#EMS_MAXDIST,d0				; has the sphere fully drifted away?
		blo.s	MSSRS_F_StillValid			; if not, branch
		dbf	d5,MSSRS_F_NextObj			; decrease object counter
		move.l	#MSSRS_MoveDown,(EMS_ObjectRout).w	; set next routine
		tst.b	(EMS_LevelChange).w			; are we moving forwards?
		bgt.w	MSSRS_MoveDown				; if so, branch
		move.l	#MSSRS_MoveUp,(EMS_ObjectRout).w	; set next routine
		bra.s	MSSRS_MoveUp				; continue

MSSRS_F_StillValid:
		move.l	EMS_ObjSpeed(a0),d0			; load speed
		addi.l	#$00020000,d0				; increase the speed
		add.l	d0,EMS_ObjDist(a0)			; add to the distance
		bpl.s	MSSRS_F_NoForce				; if the distance is still above the world floor, branch
		neg.l	EMS_ObjDist(a0)				; reverse sphere above the floor
		neg.l	d0					; reverse speed's direction

MSSRS_F_NoForce:
		move.l	d0,EMS_ObjSpeed(a0)			; update speed

MSSRS_F_NextObj:
		lea	EMS_ObjSize(a0),a0			; advance to next object
		dbf	d7,MSSRS_F_RunNext			; repeat for all objects

MSSRS_CheckMove:
		tst.b	(EMS_LevelChange).w			; are we moving forwards?
		bgt.w	MSSRS_MoveDown				; if so, branch to move the planets down (instead of up)

; ===========================================================================
; ---------------------------------------------------------------------------
; Moving the small planet off of the screen
; ---------------------------------------------------------------------------

MSSRS_MoveUp:
		addq.w	#$04,(EMS_HScrollPos1).w		; move small planet out
		move.w	(EMS_Planet1_Y).w,d0			; load next planet's Y position
		addq.w	#$0008,d0				; move it in (on Y)
		tst.b	(EMS_FastMode).w			; is fast mode on?
		beq.s	MSSRS_MU_NoFast				; if not, branch
		addq.w	#$08,(EMS_HScrollPos1).w		; triple the speed
		addi.w	#$0010,d0				; ''

MSSRS_MU_NoFast:
		cmpi.w	#$0018+$0080,d0				; have we reached the destination?
		bge.s	MSSRS_MU_Moved				; if so, branch
		move.w	d0,(EMS_Planet1_Y).w			; update position

MSSRS_MU_NoChange:
		rts						; return

MSSRS_MU_Moved:
		move.w	#$0018+$0080,(EMS_Planet1_Y).w		; update position
		cmpi.l	#MSSRS_MoveUp,(EMS_ObjectRout).w	; has the routine been set? (have all spheres jumped off?)
		bne.s	MSSRS_MU_NoChange			; if not, branch

		sf.b	(EMS_ScaleAmount).w			; force scaling to largest size
		move.l	#MSSRS_SwapPlanet,(EMS_ObjectRout).w	; set next routine
		sf.b	(EMS_LastSlot).w			; set as not on last slot anylonger

		moveq	#$00,d0					; clear d0
		move.b	(EMS_CurLevel).w,d0			; load stage ID
		addq.b	#$01,d0					; advance to next stage
		add.w	d0,d0					; multiply by size of word
		lea	(SP_Stages).l,a4			; load stage list
		adda.w	(a4,d0.w),a4				; load correct stage data
		move.l	(a4)+,d0				; load floor palette
		lea	(EMS_ScalePal).l,a1			; load frame palette list
		lea	(MSSC_ListScale).l,a0			; load palette list
		move.w	#((MSSC_ListScaleEnd-MSSC_ListScale)/2)-1,d4	; set number of frames to generate
		jmp	SPPC_NextFrame				; setup colour frame animations

; ===========================================================================
; ---------------------------------------------------------------------------
; Swapping main planet with scaleable planet
; ---------------------------------------------------------------------------

MSSRS_SwapPlanet:
		clr.w	(EMS_WorldRotVS).w			; clear vertical speed

		move.w	(EMS_WorldRotV+2).w,d2			; load vertical position
		andi.w	#$0FFF,d2				; get only fraction position
		subi.w	#$08C0,d2				; get distance from correct alignment destination
		tst.b	(EMS_FastMode).w			; is fast mode on?
		bne.s	MSSRS_SP_Fast				; if so, branch
		asr.w	#$03,d2					; slow down even mode
		bra.s	MSSRS_SP_NoFast				; continue

MSSRS_SP_Fast:
		asr.w	#$01,d2					; divide distance by fraction
		move.w	(EMS_WorldRotHS).w,d0			; load Horizontal speed
		subi.w	#$0100,d0				; get distance to destination
		asr.w	#$02,d0					; slow it down
		sub.w	d0,(EMS_WorldRotHS).w			; move towards destination (should be faster)

MSSRS_SP_NoFast:
		sub.w	d2,(EMS_WorldRotV+2).w			; move towards destination


		move.w	(EMS_WorldRotHS).w,d2			; load Horizontal speed
		cmpi.w	#$0100,d2				; is it at maximum speed?
		beq.s	MSSRS_SP_Update				; if so, branch
		addi.w	#$0C,d2					; rotate the world right
		cmpi.w	#$0100,d2				; is it at maximum speed?
		beq.s	MSSRS_SP_Update				; if exactly on, branch
		ble.s	MSSRS_SP_NoAutoH			; if not, branch
		subi.w	#$02+$0C,d2				; decrease the speed back
		cmpi.w	#$0100,d2				; has it now dropped below the speed?
		ble.s	MSSRS_SP_Update				; if so, branch

MSSRS_SP_NoAutoH:
		move.w	d2,(EMS_WorldRotHS).w			; update speed

MSSRS_SP_NoUpdate:
		rts						; return

MSSRS_SP_Update:
		move.w	#$0100,(EMS_WorldRotHS).w		; set worlds' H-position (to scroll the planet the same speed as the scaleable planet is)
		tst.b	(EMS_FastMode).w			; is fast mode on?
		bne.s	MSSRS_SPU_Fast				; if so, branch
		move.w	(EMS_WorldRotV+2).w,d2			; load vertical position
		andi.w	#$0F00,d2				; get only fraction position
		subi.w	#$0800,d2				; is it aligned with scaleable planet?
		bne.s	MSSRS_SP_NoUpdate			; if not, branch (until it is)

MSSRS_SPU_Fast:
		move.w	(EMS_WorldRotH+2).w,d0			; load current H-rotation
		andi.w	#$0FFF,d0				; get only fraction position
		mulu.w	#$07,d0					; convert 1000 to 700
		asr.l	#$04,d0					; ''
		move.w	d0,(EMS_ScaleCycle).w			; save as scaleable planet's palette cycle position

		move.w	#$FFA6,(EMS_Planet1_Y).w		; force it directly to its destination
		move.l	#$FFDF0000,(EMS_HScrollPos1).w		; force X position into place
		move.l	(EMS_HScrollPos1).w,(EMS_HScrollPos2).w	; ''
		move.l	#MSSRS_ScaleOut,(EMS_ObjectRout).w	; set next routine
		clr.l	(EMS_LevelRout).w			; reset level loading routine
		move.w	#$00FF,(EMS_Planet2_Y).w		; force position to FF

MSSRS_SP_NoSwap:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Scaling the planet out
; ---------------------------------------------------------------------------

MSSRS_ScaleOut:

		moveq	#$00,d0					; clear d0
		move.b	(EMS_CurLevel).w,d0			; load stage ID
		add.w	d0,d0					; multiply by size of word
		lea	(SP_Stages).l,a4			; load stage list
		adda.w	(a4,d0.w),a4				; load correct stage data

		addq.b	#$01,(EMS_ScaleAmount).w		; increase scale amount
		tst.b	(EMS_FastMode).w			; is fast mode on?
		beq.s	MSSRS_SO_NoFast				; if not, branch
		move.b	(EMS_ScaleAmount).w,d0			; load scale amount
		andi.b	#$03,d0					; keep within steps of 4
		bne.s	MSSRS_SO_NoFast				; if adding 3 won't result in 3, 7, B, F, etc where 7, F, 17, and 1F are required to clear outter tiles properly, then branch
		addq.b	#$03,(EMS_ScaleAmount).w		; triple the speed (ensuring steps landing on 7, F, 17 and 1F).

MSSRS_SO_NoFast:
		cmpi.b	#$1F,(EMS_ScaleAmount).w		; have we passed the smallest size?
		ble.s	MSSRS_SO_NoScale			; if not, branch
		move.b	#$1F,(EMS_ScaleAmount).w		; force scale to smallest

		cmpi.w	#$0018,(EMS_Planet1_Y).w		; have the Y and X positions aligned into place correctly?
		bne.s	MSSRS_SO_NoScale			; ''
		tst.w	(EMS_HScrollPos1).w			; ''
		bne.s	MSSRS_SO_NoScale			; if not, branch to continue until they have

		tst.b	(EMS_LayoutCount).w			; is there still layout data to unpack?
		bge.w	MSSRS_WaitLayout			; if so, branch

		move.l	#MSSRS_ShiftIn,(EMS_ObjectRout).w	; set next routine
		move.l	#$FFE50000,(EMS_HScrollPos2).w		; set starting position
		move.w	#-$0D80,(EMS_Planet2_YS).w		; set starting Y speed
		move.l	(a4)+,d0				; load floor palette
		lea	(EMS_PlanetPal).l,a1			; load frame palette list
		lea	(MSSC_List).l,a0			; load palette list
		move.w	#((MSSC_ListEnd-MSSC_List)/2)-1,d4	; set number of frames to generate
		jmp	SPPC_NextFrame				; setup colour frame animations

MSSRS_SO_NoScale:
		cmpi.b	#$0C,(EMS_ScaleAmount).w		; have we passed a size that's not laggy?
		ble.w	MSSRS_WaitLayout			; if not, branch

	; Y movement

		move.w	(EMS_Planet1_Y).w,d0			; load planet's Y position
		subi.w	#$0018+$10,d0				; get distance (with extra amount to increase the speed)
		swap	d0					; send to upper quotient
		clr.w	d0					; ''
		tst.b	(EMS_FastMode).w			; is fast mode on?
		bne.s	MSSRS_SO_FastY				; if so, branch
		asr.l	#$02,d0					; slow down further

MSSRS_SO_FastY:
		asr.l	#$02,d0					; get a fraction of the position
		sub.l	d0,(EMS_Planet1_Y).w			; add fraction as speed
		cmpi.w	#$0018,(EMS_Planet1_Y).w		; has the planet's Y position reached its destination yet?
		blt.s	MSSRS_SO_ContinueMoveY			; if not, branch
		move.w	#$0018,(EMS_Planet1_Y).w		; force it directly to its destination
		moveq	#$00,d0					; clear speed

MSSRS_SO_ContinueMoveY:
		asr.l	#$08,d0					; slow it down for the BG
		asr.l	#$03,d0					; ''
		sub.l	d0,(EMS_ReleatBGY).w			; change BG Y position

	; X movement

		move.w	(EMS_HScrollPos1).w,d0			; load planet's X position
		subi.w	#$0010,d0				; sub extra amount to increase the speed
		swap	d0					; send to upper quotient
		clr.w	d0					; ''
		tst.b	(EMS_FastMode).w			; is fast mode on?
		bne.s	MSSRS_SO_FastX				; if so, branch
		asr.l	#$02,d0					; slow down further

MSSRS_SO_FastX:
		asr.l	#$03,d0					; get a fraction of the position
		tst.w	(EMS_HScrollPos1).w			; has the planet's X position reached its destination yet?
		blt.s	MSSRS_SO_ContinueMoveX			; if not, branch
		clr.w	(EMS_HScrollPos1).w			; force it directly to its destination
		moveq	#$00,d0					; clear speed

MSSRS_SO_ContinueMoveX:
		sub.l	d0,(EMS_HScrollPos1).w			; add fraction as speed
		asr.l	#$08,d0					; slow it down for the BG
		asr.l	#$01,d0					; ''
		add.l	d0,(EMS_ReleatBGX).w			; change BG X position
		move.l	(EMS_HScrollPos1).w,(EMS_HScrollPos2).w	; copy for upper part of screen too
		bra.w	MSSRS_WaitLayout

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to shift the main world in
; ---------------------------------------------------------------------------

MSSRS_ShiftIn:
		addi.w	#$0080,(EMS_Planet2_YS).w		; decrease speed of planet
		addi.l	#$00011800,(EMS_HScrollPos2).w		; shift planet right
		tst.b	(EMS_FastMode).w			; is fast mode on?
		beq.s	MSSRS_ShI_NoFast			; if not, branch
		subi.w	#$0080,(EMS_Planet2_YS).w		; reduce resistence
		addi.l	#$00010800,(EMS_HScrollPos2).w		; increase the speed

MSSRS_ShI_NoFast:
		move.w	(EMS_Planet2_YS).w,d0			; load Y speed
		ext.l	d0					; extend to long-word
		lsl.l	#$08,d0					; align for Y position
		add.l	d0,(EMS_Planet2_Y).w			; advance Y position of planet
		move.w	(EMS_Planet2_Y).w,d0			; reload quotient
		cmpi.w	#$0050,d0				; has the planet reached it's beginning point?
		bgt.s	MSSRS_ShI_NoFinish			; if not, branch
		move.l	#$00500000,(EMS_Planet2_Y).w		; force back to beginning point
		clr.w	(EMS_HScrollPos1).w			; force X position into place
		move.w	#$0018,(EMS_Planet1_Y).w		; reset scale planet position
		clr.l	(EMS_ObjectRout).w			; set no routine

MSSRS_ShI_NoFinish:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Moving the planet off of the screen
; ---------------------------------------------------------------------------

MSSRS_MoveDown:
		addi.w	#$0080,(EMS_Planet2_YS).w		; increase speed of planet
		subi.l	#$00010000,(EMS_HScrollPos2).w		; shift planet left
		tst.b	(EMS_FastMode).w			; is fast mode on?
		beq.s	MSSRS_MD_NoFast				; if not, branch
		addi.w	#$0100,(EMS_Planet2_YS).w		; triple speed
		subi.l	#$00020000,(EMS_HScrollPos2).w		; ''

MSSRS_MD_NoFast:
		move.w	(EMS_Planet2_YS).w,d0			; load Y speed
		ext.l	d0					; extend to long-word
		lsl.l	#$08,d0					; align for Y position
		add.l	d0,(EMS_Planet2_Y).w			; advance Y position of planet
		move.w	(EMS_Planet2_Y).w,d0			; reload quotient
		cmpi.w	#$0100,d0				; has the planet dropped down far enough?
		blo.s	MSSRS_MD_NotFinished			; if not, branch
		move.w	#$00FF,(EMS_Planet2_Y).w		; force it not to go beyond FF
		st.b	(EMS_DisSpheres).w			; disable the main planet
		move.l	#MSSRS_ScaleIn,(EMS_ObjectRout).w	; set next routine
		clr.l	(EMS_HScrollPos2).w			; clear H-scroll position
		clr.l	(EMS_LevelRout).w			; reset level loading routine
		bra.w	MSSRS_ScaleIn				; perform scaling in routine right away

MSSRS_MD_NotFinished:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Scaling the planet in
; ---------------------------------------------------------------------------

MSSRS_ScaleIn:
		moveq	#$00,d0					; clear d0
		move.b	(EMS_CurLevel).w,d0			; load stage ID
		add.w	d0,d0					; multiply by size of word
		lea	(SP_Stages).l,a4			; load stage list
		adda.w	(a4,d0.w),a4				; load correct stage data
		move.w	#$0100,(EMS_WorldRotHS).w		; set worlds' H-position (to scroll the planet the same speed as the scaleable planet is)

	; Scaling

		subq.b	#$01,(EMS_ScaleAmount).w		; decrease scale amount
		tst.b	(EMS_FastMode).w			; is fast mode on?
		beq.s	MSSRS_SI_NoFast				; if not, branch
		subq.b	#$03,(EMS_ScaleAmount).w		; decrease scale amount more....

MSSRS_SI_NoFast:
		tst.b	(EMS_ScaleAmount).w			; check scale
		bpl.w	MSSRS_SI_NoScale			; if we haven't passed the largest size, branch
		sf.b	(EMS_ScaleAmount).w			; force scale to largest
		tst.b	(EMS_LayoutCount).w			; is there still layout data to unpack?
		bge.w	MSSRS_WaitLayout			; if so, branch
		st.b	(EMS_ScaleAmount).w			; force scale to invalid (FF, so that addq  8 can make it 07, then 0F, then 17, then 1F (all which happen to blank outter tiles))
		move.l	#$00500000,(EMS_Planet2_Y).w		; reset FG planet position
		sf.b	(EMS_DisSpheres).w			; enable the main planet again
		clr.l	(EMS_HScrollPos2).w			; reset planet positions
		move.l	#$00500000,(EMS_HScrollPos1).w		; set next planet's starting position
		st.b	(EMS_DisScale).w			; disable planet scaling

		move.w	#$0018+$80+$17,(EMS_Planet1_Y).w	; force scaleable planet above the screen

	; Matching up world with the scaling planet's cycle

		move.w	(EMS_WorldRotH+2).w,d0			; load current H-rotation
		andi.w	#$F000,d0				; clear position (keep layout)
		moveq	#$00,d1					; clear long-word
		move.w	(EMS_ScaleCycle).w,d1			; load scale position
		asl.l	#$04,d1					; multiply to x1000
		divu.w	#$07,d1					; divide by 7 (conversion x7 to x10)
		addi.w	#$0400,d1				; align correctly
		andi.w	#$0FFF,d1				; keep within world's scroll range
		or.w	d1,d0					; save with H-rotation
		move.w	d0,(EMS_WorldRotH+2).w			; update H-rotation
		move.w	(EMS_WorldRotV+2).w,d0			; load current V-rotation
		andi.w	#$F000,d0				; clear position (keep layout)
		ori.w	#$08C0,d0				; align it down
		move.w	d0,(EMS_WorldRotV+2).w			; update V-rotation
		clr.w	(EMS_WorldRotVS).w			; clear vertical speed

		move.l	#MSSRS_LoadNextFloor,(EMS_ObjectRout).w	; set delay routine

		move.l	(a4)+,d0				; load floor palette
		lea	(EMS_PlanetPal).l,a1			; load frame palette list
		lea	(MSSC_List).l,a0			; load palette list
		move.w	#((MSSC_ListEnd-MSSC_List)/2)-1,d4	; set number of frames to generate
		jmp	SPPC_NextFrame				; setup colour frame animations

MSSRS_LoadNextFloor:
		move.l	#MSSRS_ResetScale,(EMS_ObjectRout).w	; set next routine
		moveq	#$00,d0					; clear d0
		move.b	(EMS_CurLevel).w,d0			; load stage ID
		addq.b	#$01,d0					; advance to next stage
		add.w	d0,d0					; multiply by size of word
		lea	(SP_Stages).l,a4			; load stage list
		adda.w	(a4,d0.w),a4				; load correct stage data
		move.l	(a4)+,d0				; load floor palette
		lea	(EMS_ScalePal).l,a1			; load frame palette list
		lea	(MSSC_ListScale).l,a0			; load palette list
		move.w	#((MSSC_ListScaleEnd-MSSC_ListScale)/2)-1,d4	; set number of frames to generate
		jmp	SPPC_NextFrame				; setup colour frame animations

MSSRS_ResetScale:
		move.b	(EMS_CurLevel).w,d0			; load current level
		cmp.b	(EMS_LevelCount).w,d0			; is this the last slot?
		bne.s	MSSRS_RS_NoLastScale			; if not, branch
		st.b	(EMS_LastSlot).w			; set that we're on the last slot now (hide scaling planet)

MSSRS_RS_NoLastScale:
		sf.b	(EMS_DisScale).w			; re-enable planet scaling
		cmpi.b	#$1F,(EMS_ScaleAmount).w		; have we reached smallest again yet?
		bge.s	MSSRS_RS_FinScale			; if so, branch
		addq.b	#$08,(EMS_ScaleAmount).w		; render the next frame that'll clear the tiles
		rts						; return

MSSRS_RS_FinScale:
		tst.b	(EMS_FastMode).w			; is fast mode on?
		beq.s	MSSRS_RS_NoFastX			; if not, branch
		subq.w	#$08,(EMS_HScrollPos1).w		; triple the speed

MSSRS_RS_NoFastX:
		subq.w	#$04,(EMS_HScrollPos1).w		; move next planet in (on X)
		bpl.s	MSSRS_RS_NoFinX				; if not finished, branch
		clr.w	(EMS_HScrollPos1).w			; force X position into place

MSSRS_RS_NoFinX:
		move.w	(EMS_Planet1_Y).w,d0			; load next planet's Y position
		subi.w	#$0008,d0				; move it in (on Y)
		tst.b	(EMS_FastMode).w			; is fast mode on?
		beq.s	MSSRS_RS_NoFastY			; if not, branch
		subi.w	#$0010,d0				; triple the speed

MSSRS_RS_NoFastY:
		cmpi.w	#$0018,d0				; have we reached the destination?
		ble.s	MSSRS_RS_Finish				; if so, branch
		move.w	d0,(EMS_Planet1_Y).w			; update position
		rts						; return

MSSRS_RS_Finish:
		clr.w	(EMS_HScrollPos1).w			; force X position into place
		move.w	#$0018,(EMS_Planet1_Y).w		; reset scale planet position
		clr.l	(EMS_ObjectRout).w			; set no routine
		rts						; return

MSSRS_SI_NoScale:

	; Y movement

		move.w	(EMS_Planet1_Y).w,d0			; load planet's Y position
		subi.w	#$FFA6-$10,d0				; get distance (with extra amount to increase the speed)
		swap	d0					; send to upper quotient
		clr.w	d0					; ''
		tst.b	(EMS_FastMode).w			; is fast mode on?
		bne.s	MSSRS_SI_FastY				; if so, branch
		asr.l	#$02,d0					; slow down further

MSSRS_SI_FastY:
		asr.l	#$02,d0					; get a fraction of the position
		sub.l	d0,(EMS_Planet1_Y).w			; add fraction as speed
		cmpi.w	#$FFA6,(EMS_Planet1_Y).w		; has the planet's Y position reached its destination yet?
		bge.s	MSSRS_SI_ContinueMoveY			; if not, branch
		move.w	#$FFA6,(EMS_Planet1_Y).w		; force it directly to its destination
		moveq	#$00,d0					; clear speed

MSSRS_SI_ContinueMoveY:
		asr.l	#$08,d0					; slow it down for the BG
		asr.l	#$03,d0					; ''
		sub.l	d0,(EMS_ReleatBGY).w			; change BG Y position

	; X movement

		move.w	(EMS_HScrollPos1).w,d0			; load planet's X position
		subi.w	#$FFDF,d0				; get distance
		swap	d0					; send to upper quotient
		clr.w	d0					; ''
		tst.b	(EMS_FastMode).w			; is fast mode on?
		bne.s	MSSRS_SI_FastX				; if so, branch
		asr.l	#$02,d0					; slow down further

MSSRS_SI_FastX:
		asr.l	#$01,d0					; get a fraction of the position
		sub.l	d0,(EMS_HScrollPos1).w			; add fraction as speed
		cmpi.w	#$FFDF,(EMS_HScrollPos1).w		; has the planet's X position reached its destination yet?
		bgt.s	MSSRS_SI_ContinueMoveX			; if not, branch
		move.w	#$FFDF,(EMS_HScrollPos1).w		; force it directly to its destination
		moveq	#$00,d0					; clear speed

MSSRS_SI_ContinueMoveX:
		asr.l	#$08,d0					; slow it down for the BG
		asr.l	#$01,d0					; ''
		add.l	d0,(EMS_ReleatBGX).w			; change BG X position
		move.l	(EMS_HScrollPos1).w,(EMS_HScrollPos2).w	; copy for upper part of screen too

	; Next level to load

MSSRS_WaitLayout:
		move.l	(EMS_LevelRout).w,d1			; load level loading routine
		bne.s	MSSRS_SI_ValidRoutine			; if it's valid, branch
		addq.w	#$04,a4					; advance to BG colours
		lea	(EMS_BGPalette).w,a1			; copy BG colours
		move.l	(a4)+,(a1)+				; ''
		move.w	(a4)+,(a1)+				; ''
		lea	3+3(a4),a4				; advance to layout data
		movea.l	a4,(EMS_LayoutSrc).w			; set source address
		move.l	#EMS_Layout,(EMS_LayoutDest).w		; set destination
		move.b	#$20,(EMS_LayoutCount).w		; reset layout line counter
		move.l	#MSSRS_LV_Layout,d1			; set routine
		move.l	d1,(EMS_LevelRout).w			; ''

MSSRS_SI_ValidRoutine:
		move.l	d1,a1					; set address
		jmp	(a1)					; run address

; ---------------------------------------------------------------------------
; Loading new layout
; ---------------------------------------------------------------------------

MSSRS_LV_Layout:
		move.l	#$0F0F0F0F,d1				; prepare AND type obtainer values
		movea.l	(EMS_LayoutSrc).w,a4			; load layout address
		movea.l	(EMS_LayoutDest).w,a1			; load dump address
		moveq	#$01-1,d2				; set to run loading one line per frame
		tst.b	(EMS_FastMode).w			; is fast mode on?
		beq.s	MSSRS_LV_NextLine			; if not, branch
		addq.b	#$02,d2					; set to run three times

MSSRS_LV_NextLine:
		subq.b	#$01,(EMS_LayoutCount).w		; decrease line counter
		bmi.s	MSSRS_LV_LayFinish			; if finished, branch
	rept	$08
		move.l	(a4)+,d0				; load layout data
		and.l	d1,d0					; get only types
		move.l	d0,(a1)+				; save to layout RAM
	endm
		lea	$E0(a1),a1	; 100 - (20 * 3)	; advance to next line
		dbf	d2,MSSRS_LV_NextLine			; repeat again (fast mode)
		move.l	a4,(EMS_LayoutSrc).w			; save for next line
		move.l	a1,(EMS_LayoutDest).w			; save for next line
		rts						; return

MSSRS_LV_LayFinish:
		move.l	#MSSRS_LV_Hold,(EMS_LevelRout).w	; keep routine trapped here

MSSRS_LV_Hold:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to render all sprites
; ---------------------------------------------------------------------------
MSS_RSPS_Size	= (MSS_RSPS_ListEnd-MSS_RSPS_List)
MSS_RSPS_Count	= ((MSS_RSPS_ListEnd-MSS_RSPS_List)/8)
MSS_SphCnt	= 7
SpPs	function X, Y, (((MSS_SphCnt+X)+(((MSS_SphCnt-1)+Y)*((MSS_SphCnt*2)-1)))*4)
LayP	function X, Y, (((MSS_SphCnt+X)&$1F)+((((MSS_SphCnt-1)+Y)&$1F)<<$08))
SpritePos	macro	X, Y, VRAM
		dc.w	LayP(X,Y),VRAM,SpPs(X,Y)
		endm
; ---------------------------------------------------------------------------

MSS_RenderSprites:

	; --- Main VBlank table ---

		lea	(Sprite_table_buffer).w,a1		; load the sprite table buffer
		bsr.w	MSS_RS_WindowCorners			; render window corners MUST BE DONE FIRST!!
		bsr.w	MSS_RS_ScaleShadow			; render shadow/shine of scaling planet
		bsr.w	MSS_RS_PlanetShadow			; render shadow/shine of main planet MUST BE DONE LAST!!

	; --- Secondary H-blank tables ---

		lea	(EMS_SpriteTop_A).l,a1			; load buffer A's table
		tst.b	(EMS_BufferFlag).w			; are we displaying buffer A?
		bmi.s	MSS_RS_BufferA				; if not, branch
		lea	(EMS_SpriteTop_B).l,a1			; load buffer B's table insetad

MSS_RS_BufferA:
		; clearing and linking sprite slot (just in-case there's
		; not enough sprites to overflow the scales' shadow/shine)
		moveq	#$50-MSS_RSPS_Count,d1			; prepare link ID
		move.w	(EMS_ShadowSize).w,d0			; load size of shadow sprites
		move.l	d1,(a1,d0.w)				; hide the sprite and force it to link to the main shadow/shine sprites
		addi.w	#$0280,d0				; do the same for the bottom list...
		move.l	d1,(a1,d0.w)				; ''
		tst.b	(EMS_PlanetsOn).w			; are the planets on at all?
		bne.s	MSS_RS_YesPlanets			; if so, branch

MSS_RS_NoSpheres:
		moveq	#$50-MSS_RSPS_Count,d1			; prepare link ID
		move.l	d1,(a1)					; set the first sprite to point directly to the shadow/shine sprites
		move.l	d1,$280(a1)				; ''
		rts						; return (not sure here...)

MSS_RS_YesPlanets:
		bsr.w	MSS_RS_SetupSpherePos			; setup positions first

		tst.b	(EMS_NoSpheres).w			; can spheres exist?
		bne.s	MSS_RS_NoSpheres			; if not, branch

		subq.b	#$01,(EMS_RingTimer).w			; decrease ring delay timer
		bpl.s	MSS_RS_NoRingFrame			; if still running, branch
		move.b	#$08-1,(EMS_RingTimer).w		; reset ring timer
		subq.b	#$01,(EMS_RingFrame).w			; decrease ring frame
		bpl.s	MSS_RS_NoRingFrame			; if not finished, branch
		move.b	#$02,(EMS_RingFrame).w			; reset ring frame

MSS_RS_NoRingFrame:

		moveq	#$04,d7					; set to start the link after the corner sprites
		lea	MSS_RS_TopList(pc),a0
		moveq	#((MSS_RS_TopListEnd-MSS_RS_TopList)/$06)-1,d6
		bsr.s	MSS_RS_Spheres				; render the spheres

		moveq	#$04,d7					; set to start the link after the corner sprites
		lea	MSS_RS_BotList(pc),a0
		moveq	#((MSS_RS_BotListEnd-MSS_RS_BotList)/$06)-1,d6
						; continue to..	; render the spheres

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to render the spheres in a specific order
; ---------------------------------------------------------------------------

MSS_RS_Spheres:
		lea	(EMS_SpherePos).l,a2			; load sphere position data
		lea	(EMS_Layout).l,a3			; load layout RAM
		move.w	(EMS_WorldRotV+2).w,d3			; load V position to upper byte
		move.b	(EMS_WorldRotH+2).w,d3			; load H position to lower byte
		not.w	d3					; reverse layout position
		lsr.w	#$03,d3					; align for layout positions
		move.w	#$1F1F,d4
		and.w	d4,d3					; wrap layout
		moveq	#($50-MSS_RSPS_Count-$04)-1,d5		; prepare availability counter

MSS_RSS_Next:
		move.w	d3,d1					; copy layout to d1
		move.w	(a0)+,d0				; load relative layout address
		add.b	d1,d0					; add layout X position
		sf.b	d1					; get only Y position
		add.w	d1,d0					; add layout Y position
		and.w	d4,d0					; keep within layout
		move.b	(a3,d0.w),d0				; load sphere at location
		subq.b	#$01,d0					; minus 1 to align first sphere to first set
		bcs.s	MSS_RSS_BlankSpace			; if there's no sphere here, branch
		ext.w	d0					; clear upper byte
		cmpi.b	#$08-1,d0				; is this a ring?
		blo.s	MSS_RSS_NoRing				; if not, branch
		subi.w	#$4000>>3,d0				; make it use a different palette line (the one that doesn't shadow/highlight)
		add.b	(EMS_RingFrame).w,d0			; add animation frame number (to animate the rings)

MSS_RSS_NoRing:
		lsl.w	#$03,d0					; multiply by number of scaled tiles each sphere set has in VRAM
		add.w	(a0)+,d0				; add VRAM size/priority
		move.w	(a0)+,d1				; load position on planet
		move.w	(a2,d1.w),d2				; load Y position from table
		beq.s	MSS_RSS_Continue			; if it's blank, branch (no sphere to display)
		move.w	d2,(a1)+				; save Y position
		addq.b	#$01,d7					; increase link ID
		move.w	d7,(a1)+				; save shape and link ID
		move.w	d0,(a1)+				; save pattern index.VRAM
		move.w	$02(a2,d1.w),(a1)+			; load X position from table
		dbf	d5,MSS_RSS_Continue			; repeat for all available slots
	;lea	MSS_RSPS_Size(a1),a1	; Stupid fucking assembler won't let me use the more efficient method for some reason...
		adda.w	#MSS_RSPS_Size+(4*8),a1			; advance to end of table (start of next table)
		rts						; return

MSS_RSS_BlankSpace:
		addq.w	#$04,a0					; skip to next entry

MSS_RSS_Continue:
		dbf	d6,MSS_RSS_Next				; repeat for all entries
		move.l	#$50-MSS_RSPS_Count,(a1)		; set next link to point to shadow/shine of planet
		moveq	#$50+4,d0				; get remaining number of slots
		sub.b	d7,d0					; ''
		lsl.w	#$03,d0					; multiply by size of sprite slot
		adda.w	d0,a1					; advance to end of table (start of next table)
		rts						; return

MSS_RS_TopList:
		SpritePos +0,+0,$E001
		SpritePos +1,+0,$E001
		SpritePos +2,+0,$E002
		SpritePos +3,+0,$E003
		SpritePos +4,+0,$E004
		SpritePos +5,+0,$E005
		SpritePos +6,+0,$6006

		SpritePos -1,+0,$E001
		SpritePos -2,+0,$E002
		SpritePos -3,+0,$E003
		SpritePos -4,+0,$E004
		SpritePos -5,+0,$E005
		SpritePos -6,+0,$6006

		SpritePos +0,-1,$E001
		SpritePos +1,-1,$E001
		SpritePos +2,-1,$E002
		SpritePos +3,-1,$E003
		SpritePos +4,-1,$E004
		SpritePos +5,-1,$E005
		SpritePos +6,-1,$6006
		SpritePos -1,-1,$E001
		SpritePos -2,-1,$E002
		SpritePos -3,-1,$E003
		SpritePos -4,-1,$E004
		SpritePos -5,-1,$E005
		SpritePos -6,-1,$6006

		SpritePos +0,-2,$E002
		SpritePos +1,-2,$E002
		SpritePos +2,-2,$E003
		SpritePos +3,-2,$E004
		SpritePos +4,-2,$E005
		SpritePos +5,-2,$E006
		SpritePos -1,-2,$E002
		SpritePos -2,-2,$E003
		SpritePos -3,-2,$E004
		SpritePos -4,-2,$E005
		SpritePos -5,-2,$E006

		SpritePos +0,-3,$E003
		SpritePos +1,-3,$E003
		SpritePos +2,-3,$E004
		SpritePos +3,-3,$E005
		SpritePos +4,-3,$E006
		SpritePos +5,-3,$6007
		SpritePos -1,-3,$E003
		SpritePos -2,-3,$E004
		SpritePos -3,-3,$E005
		SpritePos -4,-3,$E006
		SpritePos -5,-3,$6007

		SpritePos +0,-4,$E004
		SpritePos +1,-4,$E004
		SpritePos +2,-4,$E005
		SpritePos +3,-4,$E006
		SpritePos +4,-4,$6007
		SpritePos -1,-4,$E004
		SpritePos -2,-4,$E005
		SpritePos -3,-4,$E006
		SpritePos -4,-4,$6007

		SpritePos +0,-5,$E005
		SpritePos +1,-5,$E005
		SpritePos +2,-5,$6006
		SpritePos +3,-5,$6007
		SpritePos -1,-5,$E005
		SpritePos -2,-5,$6006
		SpritePos -3,-5,$6007

		SpritePos +0,-6,$6006
		SpritePos +1,-6,$6006
		SpritePos -1,-6,$6006
MSS_RS_TopListEnd:

MSS_RS_BotList:
		SpritePos +0,+0,$E001
		SpritePos +1,+0,$E001
		SpritePos +2,+0,$E002
		SpritePos +3,+0,$E003
		SpritePos +4,+0,$E004
		SpritePos +5,+0,$E005
		SpritePos +6,+0,$6006
		SpritePos -1,+0,$E001
		SpritePos -2,+0,$E002
		SpritePos -3,+0,$E003
		SpritePos -4,+0,$E004
		SpritePos -5,+0,$E005
		SpritePos -6,+0,$6006

		SpritePos +0,+1,$E001
		SpritePos +1,+1,$E001
		SpritePos +2,+1,$E002
		SpritePos +3,+1,$E003
		SpritePos +4,+1,$E004
		SpritePos +5,+1,$E005
		SpritePos +6,+1,$6006
		SpritePos -1,+1,$E001
		SpritePos -2,+1,$E002
		SpritePos -3,+1,$E003
		SpritePos -4,+1,$E004
		SpritePos -5,+1,$E005
		SpritePos -6,+1,$6006

		SpritePos +0,+2,$E002
		SpritePos +1,+2,$E002
		SpritePos +2,+2,$E003
		SpritePos +3,+2,$E004
		SpritePos +4,+2,$E005
		SpritePos +5,+2,$E006
		SpritePos -1,+2,$E002
		SpritePos -2,+2,$E003
		SpritePos -3,+2,$E004
		SpritePos -4,+2,$E005
		SpritePos -5,+2,$E006

		SpritePos +0,+3,$E003
		SpritePos +1,+3,$E003
		SpritePos +2,+3,$E004
		SpritePos +3,+3,$E005
		SpritePos +4,+3,$E006
		SpritePos +5,+3,$6007
		SpritePos -1,+3,$E003
		SpritePos -2,+3,$E004
		SpritePos -3,+3,$E005
		SpritePos -4,+3,$E006
		SpritePos -5,+3,$6007

		SpritePos +0,+4,$E004
		SpritePos +1,+4,$E004
		SpritePos +2,+4,$E005
		SpritePos +3,+4,$E006
		SpritePos +4,+4,$6007
		SpritePos -1,+4,$E004
		SpritePos -2,+4,$E005
		SpritePos -3,+4,$E006
		SpritePos -4,+4,$6007

		SpritePos +0,+5,$E005
		SpritePos +1,+5,$E005
		SpritePos +2,+5,$6006
		SpritePos +3,+5,$6007
		SpritePos -1,+5,$E005
		SpritePos -2,+5,$6006
		SpritePos -3,+5,$6007

		SpritePos +0,+6,$6006
		SpritePos +1,+6,$6006
		SpritePos -1,+6,$6006
MSS_RS_BotListEnd:

; ===========================================================================
; ---------------------------------------------------------------------------
; Setting up for the planet sprite generation
; ---------------------------------------------------------------------------

MSS_RS_List:	dc.b	$FF, $FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF,$FF

		dc.b	$FF, $FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF,$FF
		dc.b	$FF, $FF,$FF,$FF,$FF,$FF,$00, $FF,$FF,$FF,$FF,$FF,$00
		dc.b	$FF, $FF,$FF,$FF,$FF,$FF,$00, $FF,$FF,$FF,$FF,$FF,$00
		dc.b	$FF, $FF,$FF,$FF,$FF,$00,$00, $FF,$FF,$FF,$FF,$00,$00
		dc.b	$FF, $FF,$FF,$FF,$00,$00,$00, $FF,$FF,$FF,$00,$00,$00
		dc.b	$FF, $FF,$00,$00,$00,$00,$00, $FF,$00,$00,$00,$00,$00

		dc.b	$FF, $FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF,$FF
		dc.b	$FF, $FF,$FF,$FF,$FF,$FF,$00, $FF,$FF,$FF,$FF,$FF,$00
		dc.b	$FF, $FF,$FF,$FF,$FF,$FF,$00, $FF,$FF,$FF,$FF,$FF,$00
		dc.b	$FF, $FF,$FF,$FF,$FF,$00,$00, $FF,$FF,$FF,$FF,$00,$00
		dc.b	$FF, $FF,$FF,$FF,$00,$00,$00, $FF,$FF,$FF,$00,$00,$00
		dc.b	$FF, $FF,$00,$00,$00,$00,$00, $FF,$00,$00,$00,$00,$00
		even

MSS_RS_SetupSpherePos:
		movem.l	d7/a1,-(sp)				; store link ID and sprite table address

		st.b	(EMS_NoSpheres).w			; set spheres as NOT existing

		lea	MSS_RS_List(pc),a4			; load sphere mapper list

		move.w	(EMS_WorldPosX).w,d0			; load X position
		add.w	(EMS_HScrollPos2).w,d0			; add planet H-scroll position
		addi.w	#$0080-(4-1),d0				; adjust for sprites (-4 for half of 8 pixels, size of sphere sprite)
		move.w	d0,(EMS_WorldAdjX).w			; save X for sprites
		move.w	(EMS_WorldPosY).w,d0			; load Y position
		andi.w	#$00FF,d0				; clear lower plane position
		add.w	(EMS_Planet2_Y).w,d0			; add H-blank reposition
		addi.w	#$0080-(4-1),d0				; adjust for sprites (-4 for half of 8 pixels, size of sphere sprite)
		move.w	d0,(EMS_WorldAdjY).w			; save Y for sprites

	; --- Calculating sub-distances between each steps ---

		; Alpha distance for V rotation

		moveq	#$00,d0					; load world alpha angle advancement amount
		move.w	(EMS_WorldAlpha).w,d0			; ''
		move.w	(EMS_WorldRotV+2).w,d1			; load H rotation position
		andi.w	#$07C0,d1				; keep within 20 steps
		lsr.w	#$06,d1					; ''
		subi.w	#$0010,d1				; get middle position
		move.w	d1,d2					; store in d4 for Delta
		muls.w	d1,d0					; multiply by angle advancement distance
		asr.l	#$05,d0					; divide by maximum steps (20)
		move.w	d0,d1					; load only the angle

		; Delta bend for V rotation

		moveq	#$00,d0					; load world delta angle advancement amount
		move.w	(EMS_WorldDelta).w,d0			; ''
		muls.w	d2,d0					; multiply by angle advancement distance
		asr.l	#$05,d0					; divide by maximum steps (20)
		move.w	d0,d2					; copy angle to d7 (QQ.DD)

		swap	d1					; store V positions
		swap	d2					; ''

		; Alpha distance for H rotation

		moveq	#$00,d0					; load world alpha angle advancement amount
		move.w	(EMS_WorldAlpha).w,d0			; ''
		move.w	(EMS_WorldRotH+2).w,d1			; load H rotation position
		andi.w	#$07C0,d1				; keep within 20 steps
		lsr.w	#$06,d1					; ''
		subi.w	#$0010,d1				; get middle position
		move.w	d1,d2					; store in d2 for Delta
		muls.w	d1,d0					; multiply by angle advancement distance
		asr.l	#$05,d0					; divide by maximum steps (20)
		move.w	d0,d1					; load only the angle

		; Delta bend for H rotation

		moveq	#$00,d0					; load world delta angle advancement amount
		move.w	(EMS_WorldDelta).w,d0			; ''
		muls.w	d2,d0					; multiply by angle advancement distance
		asr.l	#$05,d0					; divide by maximum steps (20)
		move.w	d0,d2					; copy angle to d7 (QQ.DD)

	; --- The actual position generation loops ---

		lea	(EMS_SpherePos+(4*MSS_SphCnt)+(4*((MSS_SphCnt*2)-1)*(MSS_SphCnt-1))).l,a1	; load sphere positions RAM to a1

		lea	(SineTable+$01).w,a3			; load sinewave table to a3

		move.b	(EMS_WorldRotH+2).w,d0			; load H position to lower byte
		not.b	d0					; reverse (direction is opposite)
		lsr.w	#$03,d0					; align for layout positions
		andi.w	#$0007,d0				; get only with every 8 (out of 20)
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		lea	MSS_RSSP_Obj(pc,d0.w),a0		; load correct object starting slot

		; Right side

		movem.l	a0-a1,-(sp)				; store addresses
		move.w	d1,d3					; load alpha
		move.w	d2,d4					; load delta
		move.w	#MSS_SphCnt-1,d7			; set number of lines to do

MSS_RSSP_PosRight:
		movea.l	(a0)+,a2				; load object RAM
		bsr.w	MSS_RSSP_WriteLine			; create a line of positions
		add.w	(EMS_WorldAlpha).w,d3			; advance alpha
		add.w	(EMS_WorldDelta).w,d4			; advance delta
		addq.w	#$04,a1					; advance RAM address
		dbf	d7,MSS_RSSP_PosRight			; repeat until right side is done

		; Left side

		movem.l	(sp)+,a0-a1				; reload addresses
		move.w	d1,d3					; load alpha
		move.w	d2,d4					; load delta
		move.w	#MSS_SphCnt-2,d7			; set number of lines to do

MSS_RSSP_PosLeft:
		movea.l	-(a0),a2				; load object RAM
		sub.w	(EMS_WorldAlpha).w,d3			; move alpha back
		sub.w	(EMS_WorldDelta).w,d4			; move delta back
		subq.w	#$04,a1					; move RAM address back
		bsr.s	MSS_RSSP_WriteLine			; create a line of positions
		dbf	d7,MSS_RSSP_PosLeft			; repeat until left side is done

		movem.l	(sp)+,d7/a1				; restore link ID and sprite table address
		rts						; return

		dc.l	Object_RAM+(EMS_ObjSize*$01)
		dc.l	Object_RAM+(EMS_ObjSize*$02)
		dc.l	Object_RAM+(EMS_ObjSize*$03)
		dc.l	Object_RAM+(EMS_ObjSize*$04)
		dc.l	Object_RAM+(EMS_ObjSize*$05)
		dc.l	Object_RAM+(EMS_ObjSize*$06)
		dc.l	Object_RAM+(EMS_ObjSize*$07)

MSS_RSSP_Obj:	dc.l	Object_RAM+(EMS_ObjSize*$00)
		dc.l	Object_RAM+(EMS_ObjSize*$01)
		dc.l	Object_RAM+(EMS_ObjSize*$02)
		dc.l	Object_RAM+(EMS_ObjSize*$03)
		dc.l	Object_RAM+(EMS_ObjSize*$04)
		dc.l	Object_RAM+(EMS_ObjSize*$05)
		dc.l	Object_RAM+(EMS_ObjSize*$06)
		dc.l	Object_RAM+(EMS_ObjSize*$07)

		dc.l	Object_RAM+(EMS_ObjSize*$00)
		dc.l	Object_RAM+(EMS_ObjSize*$01)
		dc.l	Object_RAM+(EMS_ObjSize*$02)
		dc.l	Object_RAM+(EMS_ObjSize*$03)
		dc.l	Object_RAM+(EMS_ObjSize*$04)
		dc.l	Object_RAM+(EMS_ObjSize*$05)
		dc.l	Object_RAM+(EMS_ObjSize*$06)

	; --- Calculating lines of spheres ---

MSS_RSSP_WriteLine:
		move.w	EMS_ObjDist(a2),d6			; load object line distance
		cmpi.w	#EMS_MAXDIST,d6				; is the sphere too far away?
		bhs.s	MSS_RSSP_NoLine				; if the distance is too far that the sphere should disappear, so branch
		sf.b	(EMS_NoSpheres).w			; set spheres as existing
		add.w	(EMS_WorldSize).w,d6			; add worlds' actual size
		move.w	d3,d0					; load angle
		lsr.w	#$08,d0					; get only quotient
		add.w	d0,d0					; multiply by sizeof word
		move.w	-$01(a3,d0.w),d5			; load correct sine position
		muls.w	d6,d5					; multiply by world/distance size
		asl.l	#$07,d5					; divide by 200
		swap	d5					; ''
		move.w	d4,d0					; load delta angle
		lsr.w	#$08,d0					; get only quotient
		add.w	d0,d0					; multiply by size of word
		muls.w	+$7F(a3,d0.w),d6			; load correct sine position and multiply by world/distance size
		asr.l	#$08,d6					; divide by 100

		swap	d1					; store left/right registers
		swap	d2					; ''
		swap	d3					; ''
		swap	d4					; ''
		swap	d7					; ''


EMS_ADVAMOUNT	=	($04*((MSS_SphCnt*2)-1))
		; Below

		move.w	d1,d3					; load alpha
		move.w	d2,d4					; load delta
		move.w	#MSS_SphCnt-1,d7			; set number of lines to do
		pea	(a1)					; store positions table address

MSS_RSSP_PosDown:
		tst.b	(a4)+					; is the sphere allowed to map here?
		beq.s	MSS_RSSP_SkipDown			; if not, branch
		bsr.s	MSS_RSSP_WritePos			; write position

MSS_RSSP_SkipDown:
		add.w	(EMS_WorldAlpha).w,d3			; advance alpha
		add.w	(EMS_WorldDelta).w,d4			; advance delta
		lea	EMS_ADVAMOUNT(a1),a1			; advance to next position in RAM storage
		dbf	d7,MSS_RSSP_PosDown			; repeat for entire line going down

		; Above

		move.w	d1,d3					; load alpha
		move.w	d2,d4					; load delta
		move.w	#MSS_SphCnt-2,d7			; set number of lines to do
		move.l	(sp),a1					; reload positions table address

MSS_RSSP_PosUp:
		sub.w	(EMS_WorldAlpha).w,d3			; move alpha back
		sub.w	(EMS_WorldDelta).w,d4			; move delta back
		lea	-EMS_ADVAMOUNT(a1),a1			; move to previous position in RAM storage
		tst.b	(a4)+					; is the sphere allowed to map here?
		beq.s	MSS_RSSP_SkipUp				; if not, branch
		bsr.s	MSS_RSSP_WritePos			; write position

MSS_RSSP_SkipUp:
		dbf	d7,MSS_RSSP_PosUp			; repeat for entire line going up
		move.l	(sp)+,a1				; reload positions table address (and restore stack)
		swap	d1					; restore left/right registers
		swap	d2					; ''
		swap	d3					; ''
		swap	d4					; ''
		swap	d7					; ''
		rts						; return

MSS_RSSP_NoLine:
		lea	MSS_SphCnt+MSS_SphCnt-1(a4),a4		; skip over a line
		swap	d7					; store X counter
		moveq	#$00,d0
		move.w	#MSS_SphCnt-1,d7			; set number of lines to do
		pea	(a1)					; store positions table address

MSS_RSSP_NoDown:
		move.w	d0,(a1)					; clear position (no render)
		lea	EMS_ADVAMOUNT(a1),a1			; advance to next position in RAM storage
		dbf	d7,MSS_RSSP_NoDown			; repeat for entire line going down

		move.w	#MSS_SphCnt-2,d7			; set number of lines to do
		move.l	(sp),a1					; reload positions table address

MSS_RSSP_NoUp:
		lea	-EMS_ADVAMOUNT(a1),a1			; move to previous position in RAM storage
		move.w	d0,(a1)					; clear position (no render)
		dbf	d7,MSS_RSSP_NoUp			; repeat for entire line going up
		move.l	(sp)+,a1				; reload positions table address (and restore stack)
		swap	d7					; restore X counter
		rts						; return

	; --- Calculating sphere positions in a line ---

MSS_RSSP_WritePos:
		move.w	d3,d0					; load angle
		lsr.w	#$08,d0					; get only quotient
		add.w	d0,d0					; multiply by size of word
		move.w	-$01(a3,d0.w),d0			; load correct sine position
		muls.w	d6,d0					; multiply by Y size
		asl.l	#$07,d0					; divide by 200
		swap	d0					; ''
		add.w	(EMS_WorldAdjY).w,d0			; add central Y position
		move.w	d0,(a1)					; set Y position
		move.w	d4,d0					; load delta angle
		lsr.w	#$08,d0					; get only quotient
		add.w	d0,d0					; multiply by size of word
		move.w	+$7F(a3,d0.w),d0			; load correct sine position
		muls.w	d5,d0					; multiply by X size
		asr.l	#$08,d0					; divide by 100
		add.w	(EMS_WorldAdjX).w,d0			; add central X position
		move.w	d0,$02(a1)				; set X position
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite render - Main planets' shadow/shine (MUST BE DONE LAST!!)
; ---------------------------------------------------------------------------

MSS_RS_PlanetShadow:
		tst.b	(EMS_PlanetsOn).w			; are the planets on at all?
		beq.s	MSS_RSPS_NoPlanet			; if not, branch
		moveq	#$50-MSS_RSPS_Count,d0			; prepare starting slot link
		move.l	d0,d1					; copy to d1
		sub.b	d7,d1					; get distance from the slot
		lsl.w	#$03,d1					; multiply by 8 (size of sprite slot)
		move.l	d0,(a1)					; force next sprite to link to new slot
		adda.w	d1,a1					; advance to correct slot
		move.w	(EMS_WorldPosX).w,d2			; load worlds' X position
		add.w	(EMS_HScrollPos2).w,d2			; add H-scroll position of planet
		move.w	(EMS_WorldPosY).w,d3			; load worlds' Y position
		andi.w	#$00FF,d3				; clear lower plane position
		add.w	(EMS_Planet2_Y).w,d3			; add H-blank reposition
		addq.w	#$01,d3					; '' (the 1 displacement)
		move.w	#$E000|($1000/$20),d1			; prepare pattern index address
		move.w	#MSS_RSPS_Count-1,d1			; prepare size of list
		lea	MSS_RSPS_List(pc),a0			; load list address

MSS_RSPS_NextSprite:
		move.w	d3,d0					; load Y position
		add.w	(a0)+,d0				; add shine/shadow Y position
		move.w	d0,(a1)+				; save Y position
		move.l	(a0)+,(a1)+				; save shape/link ID and VRAM
		move.w	d2,d0					; load X position
		add.w	(a0)+,d0				; add shine/shaodw X position
		move.w	d0,(a1)+				; save X position
		dbf	d1,MSS_RSPS_NextSprite			; repeat for all sprites
		rts						; return

MSS_RSPS_NoPlanet:
		clr.l	(a1)					; hide last sprite and clear link
		rts						; return

MSS_RSPS_List:	dc.w	$0080-$38,$0F47,$E000|(($1000/$20)+$00),$0080-$20	; shine
		dc.w	$0080-$38,$0F48,$E800|(($1000/$20)+$00),$0080+$00
		dc.w	$0080-$18,$0F49,$E000|(($1000/$20)+$10),$0080-$20
		dc.w	$0080-$18,$0F4A,$E800|(($1000/$20)+$10),$0080+$00

		dc.w	$0080+$00,$024B,$E000|(($1000/$20)+$20),$0080-$40	; shadow
		dc.w	$0080+$18,$0F4C,$E000|(($1000/$20)+$23),$0080-$40
		dc.w	$0080+$28,$0E4D,$E000|(($1000/$20)+$33),$0080-$20
		dc.w	$0080+$00,$024E,$E800|(($1000/$20)+$20),$0080+$38
		dc.w	$0080+$18,$0F4F,$E800|(($1000/$20)+$23),$0080+$20
		dc.w	$0080+$28,$0E00,$E800|(($1000/$20)+$33),$0080+$00
MSS_RSPS_ListEnd:

; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite render - Scaling planets' shadow/shine
; ---------------------------------------------------------------------------

MSS_RSSS_NoPlanet:
		clr.w	(EMS_ShadowSize).w			; set no size
		sf.b	(EMS_ShadowCount).w			; set no count
		rts						; return

MSS_RS_ScaleShadow:
		tst.b	(EMS_LastSlot).w			; are we on the last level slot?
		bne.s	MSS_RSSS_NoPlanet			; if so, branch (there is no scale planet)
	;	tst.b	(EMS_PlanetsOn).w			; are the planets on at all?
	;	beq.s	MSS_RSSS_NoPlanet			; if not, branch
		tst.b	(EMS_DisScale).w			; has the scaling planet been disabled?
		bmi.s	MSS_RSSS_NoPlanet			; if so, branch
		lea	(MSS_SpriteShine).l,a0			; load scale list
		moveq	#$00,d0					; clear d0
		move.b	(EMS_ScaleAmount).w,d0			; load current scale amount
		bmi.s	MSS_RSSS_NoPlanet			; if there is no valid size, branch
		add.b	d0,d0					; multiply by size of long-word pointers
		add.b	d0,d0					; ''
		move.l	(a0,d0.w),a0				; load correct scale sprite list
		move.w	(a0)+,d1				; load dbf counter
		move.w	d1,d0					; copy to d0
		addq.w	#$01,d0					; restore the 1
		move.b	d0,(EMS_ShadowCount).w			; save as counter
		lsl.w	#$03,d0					; multiply by 8 (size of a single sprite slot)
		move.w	d0,(EMS_ShadowSize).w			; save as size

		move.w	(EMS_ScalePosY).w,d3			; load planets' Y position
		sub.w	(EMS_Planet1_Y).w,d3			; minus planet's VSRAM position
		addi.w	#$0080+4,d3				; adjust for sprites
		move.w	(EMS_ScalePosX).w,d2			; load planets' X position
		add.w	(EMS_HScrollPos1).w,d2			; add FG H-scroll position
		addi.w	#$0080,d2				; adjust for sprites

MSS_RSSS_Next:
		move.w	d3,d0					; load central Y position
		add.w	(a0)+,d0				; add Y position
		move.w	d0,(a1)+				; save Y position
		move.l	(a0)+,(a1)+				; copy shape/link and VRAM
		move.w	d2,d0					; load central X position
		add.w	(a0)+,d0				; add X position
		move.w	d0,(a1)+				; save X position
		dbf	d1,MSS_RSSS_Next			; repeat for all sprites in sprite table
		moveq	#$50-MSS_RSPS_Count,d1			; prepare link ID
		move.l	d1,(a1)					; force next sprite to be blank, and to point to the main planets' shadow sprites
		move.b	-$05(a1),d7				; load last link ID
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite render - Window corners (MUST BE DONE FIRST!!)
; ---------------------------------------------------------------------------

MSS_RS_WindowCorners:
		moveq	#$00,d7					; reset sprite link counter
		moveq	#$00,d0					; clear d0
		move.b	(EMS_WindowSizeX).w,d0			; load windows' X size/position
		cmpi.b	#$14,d0					; is the window off screen?
		beq.s	MSS_RSWC_NoWindow			; if so, branch
		lsl.w	#$04,d0					; multiply by 10 (two tiles per position)
		bne.s	MSS_RSWC_NoFull				; if the window isn't fully 100% on-screen, branch
		addq.w	#$08,d0					; move right (since the windows' transparent square is off by a tile the entire boarder)

MSS_RSWC_NoFull:
		addi.w	#$0080,d0				; adjust for sprite table

		; Top Right

		move.w	#$0008+$80,(a1)+			; set Y position
		addq.w	#$01,d7					; increase link ID
		move.w	d7,(a1)+				; save link/shape
		move.l	#(($E800|($9060/$20))<<$10)|$0130+$80,(a1)+ ; save VRAM and X position

		; Bottom right

		move.w	#$00D0+$80,(a1)+			; set Y position
		addq.w	#$01,d7					; increase link ID
		move.w	d7,(a1)+				; save link/shape
		move.l	#(($F800|($9060/$20))<<$10)|$0130+$80,(a1)+ ; save VRAM and X position

		; Top left

		move.w	#$0008+$80,(a1)+			; set Y position
		addq.w	#$01,d7					; increase link ID
		move.w	d7,(a1)+				; save link/shape
		move.w	#$E000|($9060/$20),(a1)+		; save VRAM address
		move.w	d0,(a1)+				; set X position

		; Bottom left

		move.w	#$00D0+$80,(a1)+			; set Y position
		addq.w	#$01,d7					; increase link ID
		move.w	d7,(a1)+				; save link/shape
		move.w	#$F000|($9060/$20),(a1)+		; save VRAM address
		move.w	d0,(a1)+				; set X position
		rts						; return

MSS_RSWC_NoWindow:
		move.b	#$04,d7					; set link to directly after corner slots
		move.l	d7,(a1)					; force the first sprite off screen and to point to the correct starting slot
		lea	$20(a1),a1				; advance to correct slot
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write correct sphere tile art depending on game mode
; ---------------------------------------------------------------------------

MSS_UpdateSphereArt:
		moveq	#$00,d0					; clear d0
		move.b	(ESS_StageMode).w,d0			; load stage mode
		addq.b	#$01,d0					; convert to positive
		bpl.s	MSSM_NoFreeRoam				; if it's not the free roam mode, branch
		moveq	#$00,d0					; force to use same spheres as normal mode

MSSM_NoFreeRoam:
		lsl.w	#$04,d0					; multiply by 10 (4 long-words
		lea	MSSM_SphereLoc(pc,d0.w),a0		; load correct mode
		moveq	#$02-1,d3				; number of sets to copy

MSSM_NextSphere:
		move.l	(a0)+,a1				; load source
		move	sr,d1					; store sr
		move	#$2700,sr				; disable interrupts
		move.l	(a0)+,(a6)				; set VDP VRAM address
		moveq	#$08-1,d2				; set to copy 8 tiles

MSSM_LoadSphereArt:
		move.l	(a1)+,(a5)				; copy tiles
		move.l	(a1)+,(a5)				; ''
		move.l	(a1)+,(a5)				; ''
		move.l	(a1)+,(a5)				; ''
		move.l	(a1)+,(a5)				; ''
		move.l	(a1)+,(a5)				; ''
		move.l	(a1)+,(a5)				; ''
		move.l	(a1)+,(a5)				; ''
		dbf	d2,MSSM_LoadSphereArt			; repeat for all spheres of a set
		dbf	d3,MSSM_NextSphere			; repeat for all spheres
		move.w	d1,sr					; restore sr
		rts						; return

MSSM_SphereLoc:	dc.l	MSS_ArtSpheres+$20+(($20*8)*$1), $40200000+((($20*8)*1)<<$10)
		dc.l	MSS_ArtSpheres+$20+(($20*8)*$1), $40200000+((($20*8)*2)<<$10)

		dc.l	MSS_ArtSpheres+$20+(($20*8)*$A), $40200000+((($20*8)*1)<<$10)
		dc.l	MSS_ArtSpheres+$20+(($20*8)*$A), $40200000+((($20*8)*2)<<$10)

		dc.l	MSS_ArtSpheres+$20+(($20*8)*$1), $40200000+((($20*8)*1)<<$10)
		dc.l	MSS_ArtSpheres+$20+(($20*8)*$2), $40200000+((($20*8)*2)<<$10)

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to force a menu mode to grey/white
; --- inputs ----------------------------------------------------------------
; d0.b	= Game mode to change
; ---------------------------------------------------------------------------

MSS_WhiteOut:
		movea.l	(EMS_MapAddress).w,a1			; load mappings address
		ext.w	d0					; extend game mode
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		adda.w	MSS_SWA_Modes(pc,d0.w),a1		; advance to correct layout
		move.w	MSS_SWA_Modes+2(pc,d0.w),d1		; load positions for render list later
		move.l	#$80008000,d0				; prepare high plane or
		moveq	#$22-1,d2				; width

MSS_WO_OrX:
		or.l	d0,(a1)+				; force to high plane
		or.l	d0,(a1)					; ''
		lea	$40-4(a1),a1				; advance to next column
		dbf	d2,MSS_WO_OrX				; repeat for all columns
		swap	d1					; align positions to the top
		move.w	#$2103,d1				; set size of box to render
		bra.w	MSS_SetupTransfer			; perform transfer

		dc.w	WindMap($02,$13),$0213
		dc.w	WindMap($02,$01),$0201
MSS_SWA_Modes:	dc.w	WindMap($02,$07),$0207
		dc.w	WindMap($02,$0D),$020D

MSS_GreyOut:
		movea.l	(EMS_MapAddress).w,a1			; load mappings address
		ext.w	d0					; extend game mode
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		adda.w	MSS_SWA_Modes(pc,d0.w),a1		; advance to correct layout
		move.w	MSS_SWA_Modes+2(pc,d0.w),d1		; load positions for render list later
		move.l	#$7FFF7FFF,d0				; prepare low plane mask
		moveq	#$22-1,d2				; width

MSS_GO_MaskX:
		and.l	d0,(a1)+				; force to low plane
		and.l	d0,(a1)					; ''
		lea	$40-4(a1),a1				; advance to next column
		dbf	d2,MSS_GO_MaskX				; repeat for all columns
		swap	d1					; align positions to the top
		move.w	#$2103,d1				; set size of box to render
		bra.w	MSS_SetupTransfer			; perform transfer

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to force a menu mode to grey
; --- inputs ----------------------------------------------------------------
; d0.w	= position
; ---------------------------------------------------------------------------

MSS_SWA_SetLowPlane:
		lea	(a4),a1					; load layout
		add.w	d0,a1					; advance to correct position
		move.l	#$7FFF7FFF,d0				; prepare low plane mask
		moveq	#$22-1,d1				; width

MSS_SWA_MaskX:
		and.l	d0,(a1)+				; force to low plane
		and.l	d0,(a1)					; ''
		lea	$40-4(a1),a1				; advance to next column
		dbf	d1,MSS_SWA_MaskX			; repeat for all columns
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup the window mappings with our SUPER COOL NEW ORZUM AYE PEE EYE!!!
; ---------------------------------------------------------------------------

MSS_SetupWindowAPI:

; ---------------------------------------------------------------------------
; Main Menu Mappings
; ---------------------------------------------------------------------------

		lea	(EMS_MenuMap_MAI).l,a4			; load mappings to write to

		move.w	#WindMap($01,$00),d0			; position
		moveq	#$24,d1					; width
		moveq	#$06,d2					; height
		bsr.w	MSS_DrawBox				; draw the box
		move.w	#WindMap($02,$01),d0			; position
		lea	(STR_IN_Normal).l,a2			; load string to draw
		bsr.w	MSS_DrawCaptionCAPS			; draw the caption
		move.w	#WindMap($02,$01),d0			; position
		lea	(STR_Normal).l,a2			; string
		st.b	d1					; render sides
		bsr.w	MSS_DrawTitle				; draw the text box

		move.w	#WindMap($01,$06),d0			; position
		moveq	#$24,d1					; width
		moveq	#$06,d2					; height
		bsr.w	MSS_DrawBox				; draw the box
		move.w	#WindMap($02,$07),d0			; position
		lea	(STR_IN_GetMost).l,a2			; load string to draw
		bsr.w	MSS_DrawCaptionCAPS			; draw the caption
		move.w	#WindMap($02,$07),d0			; position
		lea	(STR_GetMost).l,a2			; string
		st.b	d1					; render sides
		bsr.w	MSS_DrawTitle				; draw the text box

		move.w	#WindMap($01,$0C),d0			; position
		moveq	#$24,d1					; width
		moveq	#$06,d2					; height
		bsr.w	MSS_DrawBox				; draw the box
		move.w	#WindMap($02,$0D),d0			; position
		lea	(STR_IN_GetOppo).l,a2			; load string to draw
		bsr.w	MSS_DrawCaptionCAPS			; draw the caption
		move.w	#WindMap($02,$0D),d0			; position
		lea	(STR_GetOppo).l,a2			; string
		st.b	d1					; render sides
		bsr.w	MSS_DrawTitle				; draw the text box

		move.w	#WindMap($01,$12),d0			; position
		moveq	#$24,d1					; width
		moveq	#$06,d2					; height
		bsr.w	MSS_DrawBox				; draw the box
		move.w	#WindMap($02,$13),d0			; position
		lea	(STR_IN_FreeRoa).l,a2			; load string to draw
		bsr.w	MSS_DrawCaptionCAPS			; draw the caption
		move.w	#WindMap($02,$13),d0			; position
		lea	(STR_FreeRoa).l,a2			; string
		st.b	d1					; render sides
		bsr.w	MSS_DrawTitle				; draw the text box

		move.b	(ESS_StageMode).w,(EMS_StagePrev).w	; set previous selection to the same
		cmpi.b	#$FF,(ESS_StageMode).w			; is the stage mode set to normal?
		beq.s	MSS_SWA_NoMaskNormal			; if so, branch
		move.w	#WindMap($02,$01),d0			; set game mode
		bsr.w	MSS_SWA_SetLowPlane			; grey it out

MSS_SWA_NoMaskNormal:
		tst.b	(ESS_StageMode).w			; is the stage mode set to get MOSTspheres?
		beq.s	MSS_SWA_NoMaskOppon			; if so, branch
		move.w	#WindMap($02,$07),d0			; set game mode
		bsr.w	MSS_SWA_SetLowPlane			; grey it out

MSS_SWA_NoMaskOppon:
		tst.b	(ESS_StageMode).w			; is the stage mode set to get opponent's spheres?
		bgt.s	MSS_SWA_NoMaskMost			; if so, branch
		move.w	#WindMap($02,$0D),d0			; set game mode
		bsr.w	MSS_SWA_SetLowPlane			; grey it out

MSS_SWA_NoMaskMost:
		cmpi.b	#$FE,(ESS_StageMode).w			; is the stage mode set to free roam?
		beq.s	MSS_SWA_NoMaskFree			; if so, branch
		move.w	#WindMap($02,$13),d0			; set game mode
		bsr.w	MSS_SWA_SetLowPlane			; grey it out

MSS_SWA_NoMaskFree:


; ---------------------------------------------------------------------------
; Level Select Menu Mappings
; ---------------------------------------------------------------------------

		lea	(EMS_MenuMap_LVL).l,a4			; load mappings to write to

	; --- Stage Number ---

		move.w	#WindMap($15,$01),d0			; position
		moveq	#$0F,d1					; width
		moveq	#$04,d2					; height
		bsr.w	MSS_DrawBox				; draw the box
		move.w	#WindMap($16,$02),d0			; position
		lea	(STR_Stage).l,a2			; string
		st.b	d1					; render sides
		bsr.w	MSS_DrawTitle				; draw the text box

	; --- Stage info ---

		move.w	#WindMap($14,$05),d0			; position
		moveq	#$11,d1					; width
		moveq	#$06,d2					; height
		bsr.w	MSS_DrawBox				; draw the box

		move.w	#WindMap($15,$06),d0			; position
		lea	(STR_Game).l,a2				; load string to draw
		bsr.w	MSS_DrawCaptionCAPS			; draw the caption
		move.w	#WindMap($15,$08),d0			; position
		lea	(STR_Level).l,a2			; load string to draw
		bsr.w	MSS_DrawCaptionCAPS			; draw the caption
		move.w	#WindMap($15,$09),d0			; position
		lea	(STR_Difficulty).l,a2			; load string to draw
		bsr.w	MSS_DrawCaptionCAPS			; draw the caption

		; TEMP - Game name and level numbers...

		move.w	#WindMap($1B,$06),d0			; position
		lea	(STR_Sonic3K).l,a2			; load string to draw
		bsr.w	MSS_DrawCaption				; draw the caption
		move.w	#WindMap($1C,$08),d0			; position
		lea	(STR_1).l,a2				; load string to draw
		bsr.w	MSS_DrawCaption				; draw the caption
		move.w	#WindMap($21,$09),d0			; position
		lea	(STR_5).l,a2				; load string to draw
		bsr.w	MSS_DrawCaption				; draw the caption

	; --- Character and Sphere info ---

		move.w	#WindMap($15,$0B),d0			; position
		moveq	#$05,d1					; width
		moveq	#$07,d2					; height
		bsr.w	MSS_DrawBox				; draw the box
		move.w	#WindMap($19,$0B),d0			; position
		moveq	#$0C,d1					; width
		moveq	#$07,d2					; height
		bsr.w	MSS_DrawBox_Aligned			; draw the box

		move.w	#WindMap($16,$0C),d0			; position
		moveq	#$04,d1					; width
		moveq	#$05,d2					; height
		bsr.w	MSS_DrawWhiteBox			; draw the box
		move.w	#WindMap($17,$0D),d0			; position
		move.w	#EMS_SONICA,d1				; set character mappings to use
		bsr.w	MSS_DrawCharacter			; draw the character

		move.w	#WindMap($1A,$0B),d0			; position
		lea	(MSS_MapCounter+$50).l,a2		; load icon mappings to use
		bsr.w	MSS_DrawCountBox			; draw the box
		move.w	#WindMap($1A,$0E),d0			; position
		lea	(MSS_MapCounter+$5C).l,a2		; load icon mappings to use
		bsr.w	MSS_DrawCountBox			; draw the box

		move.w	#WindMap($1B,$0C),d0			; position
		move.w	#123,d1					; numbers to draw
		bsr.w	MSS_DrawCount				; draw the counter
		move.w	#WindMap($1B,$0F),d0			; position
		move.w	#456,d1					; numbers to draw
		bsr.w	MSS_DrawCount				; draw the counter

	; --- Button Bar (A, B, C) ---

		move.w	#WindMap($14,$12),d0			; position
		bsr.w	MSS_DrawButtonBar			; draw the A/B/C button bar
		move.w	#WindMap($19,$13),d0			; position
		lea	(STR_ButtonA).l,a2			; string
		sf.b	d1					; DO NOT render sides
		bsr.w	MSS_DrawTitle				; draw the text box
		move.w	#WindMap($18,$15),d0			; position
		lea	(STR_ButtonB).l,a2			; string
		sf.b	d1					; DO NOT render sides
		bsr.w	MSS_DrawTitle				; draw the text box
		move.w	#WindMap($17,$17),d0			; position
		lea	(STR_ButtonC).l,a2			; string
		sf.b	d1					; DO NOT render sides
		bsr.w	MSS_DrawTitle				; draw the text box

	; --- Doing arrows last so they mould with boxes ---

		move.w	#WindMap($1B,$00),d0			; position
		bsr.w	MSS_DrawArrowUp				; draw the arrow
		move.w	#WindMap($1B,$04),d0			; position
		bsr.w	MSS_DrawArrowDown			; draw the arrow

	st.b	(EMS_LevelPrev).w			; force stage ID to update...
	bra.w	MSSC_LS_Display				; update display for level select menu

; ---------------------------------------------------------------------------
; String data
; ---------------------------------------------------------------------------

	; --- Main Menu ---

STR_Normal:	dc.b	"Normal",$00
STR_GetOppo:	dc.b	"Get opponent spheres",$00
STR_GetMost:	dc.b	"Get most spheres",$00
STR_FreeRoa:	dc.b	"Free roam",$00

STR_IN_Normal:	dc.b	"######## Race to complete a stage ",$FF
		dc.b	"######## before your opponent does",$FF
		dc.b	"                                  ",$FF
		dc.b	"                                  ",$00

STR_IN_GetOppo:	dc.b	"###################### Race to get",$FF
		dc.b	"###################### the most   ",$FF
		dc.b	"grey spheres before time runs out!",$FF
		dc.b	"       (Playing on the same stage)",$00

STR_IN_GetMost:	dc.b	"################## Race to collect",$FF
		dc.b	"################## your opponent's",$FF
		dc.b	"spheres, get most before time runs",$FF
		dc.b	"out!   (Playing on the same stage)",$00

STR_IN_FreeRoa:	dc.b	"########### Playing a simple game ",$FF
		dc.b	"########### of blue spheres, with ",$FF
		dc.b	"            no competition.       ",$FF
		dc.b	"               Just a casual game~",$00

	; --- Level Select ---

STR_Stage:	dc.b	" Stage: 01 ",$00
STR_Random:	dc.b	"   Random  ",$00
STR_Game:	dc.b	"Game:",$00
STR_Level:	dc.b	"Level:",$00
STR_Difficulty:	dc.b	"Difficulty:",$00
STR_Sonic3:	dc.b	"Sonic 3  ",$FF
		dc.b	"         ",$00
STR_Sonic3K:	dc.b	"Sonic 3 &",$FF
		dc.b	"Knuckles ",$00
STR_Sonic3KBR:	dc.b	"S3&K Bat-",$FF
		dc.b	"-tle Race",$00

STR_1:		dc.b	"1       ",$00
STR_5:		dc.b	"5  ",$00

STR_ButtonA:	dc.b	  " Play level ",$00
STR_ButtonB:	dc.b	 " Go back     ",$00
STR_ButtonC:	dc.b	" View (Hold)  ",$00

		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw a black box in the window map buffer
; --- inputs ----------------------------------------------------------------
; d0.w	= Position (relative map buffer distance)
; d1.w	= width
; d2.w	= height
; ---------------------------------------------------------------------------
WndCm function T, ((($9060+(T*$80)))/$20)
; ---------------------------------------------------------------------------

MSS_DrawBox:
		lea	(a4),a0					; load window map buffer
		adda.w	d0,a0					; advance to correct position

	; --- Left side ---

		lea	(a0),a1					; copy location to a1
		lea	$40(a0),a0				; advance to next strip
		move.w	#WndCm($01)|$4000,(a1)+			; draw top left corner
		move.w	#WndCm($02)|$4000,(a1)+			; ''
		move.w	d2,d3					; load height
		subq.w	#$04+1,d3				; minus smallest height and dbf count
		bcs.s	MSS_DB_NoLeft				; if there's no middle section, branch

MSS_DB_NextLeft:
		move.w	#WndCm($03)|$C000,(a1)+			; draw middle left
		dbf	d3,MSS_DB_NextLeft			; repeat for all middle lefts required

MSS_DB_NoLeft:
		move.w	#WndCm($02)|$5000,(a1)+			; draw bottom left corner
		move.w	#WndCm($01)|$5000,(a1)+			; ''

	; --- Middle part ---

		subq.w	#$02+1,d1				; minus smallest width and dbf count
		bcs.s	MSS_DB_SkipMiddle

MSS_DB_NextColumn:
		lea	(a0),a1					; copy location to a1
		lea	$40(a0),a0				; advance to next strip
		move.w	#WndCm($04)|$4000,(a1)+			; draw top
		move.w	#WndCm($03)|$C000,(a1)+			; ''
		move.w	d2,d3					; load height
		subq.w	#$04+1,d3				; minus smallest height and dbf count
		bcs.s	MSS_DB_NoMiddle				; if there's no middle section, branch

MSS_DB_NextMiddle:
		move.w	#WndCm($03)|$C000,(a1)+			; draw middle
		dbf	d3,MSS_DB_NextMiddle			; repeat for all middles required

MSS_DB_NoMiddle:
		move.w	#WndCm($03)|$C000,(a1)+			; draw bottom
		move.w	#WndCm($04)|$5000,(a1)+			; ''
		dbf	d1,MSS_DB_NextColumn			; repeat for all middle columns

MSS_DB_SkipMiddle:

	; --- Right side ---

		move.w	#WndCm($01)|$4800,(a0)+			; draw top right corner
		move.w	#WndCm($02)|$4800,(a0)+			; ''
		move.w	d2,d3					; load height
		subq.w	#$04+1,d3				; minus smallest height and dbf count
		bcs.s	MSS_DB_NoRight				; if there's no middle section, branch

MSS_DB_NextRight:
		move.w	#WndCm($03)|$C000,(a0)+			; draw middle right
		dbf	d3,MSS_DB_NextRight			; repeat for all middle rights required

MSS_DB_NoRight:
		move.w	#WndCm($02)|$5800,(a0)+			; draw bottom Right corner
		move.w	#WndCm($01)|$5800,(a0)+			; ''
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw a black box in the window map buffer (Aligned version)
; --- inputs ----------------------------------------------------------------
; d0.w	= Position (relative map buffer distance)
; d1.w	= width
; d2.w	= height
; ---------------------------------------------------------------------------

MSS_DrawBox_Aligned:
		lea	(a4),a0					; load window map buffer
		adda.w	d0,a0					; advance to correct position

	; --- Left side ---

		lea	(a0),a1					; copy location to a1
		lea	$40(a0),a0				; advance to next strip
		move.w	#WndCm($08)|$4000,(a1)+			; draw top left corner
		move.w	d2,d3					; load height
		subq.w	#$02+1,d3				; minus smallest height and dbf count
		bcs.s	MSS_DBA_NoLeft				; if there's no middle section, branch

MSS_DBA_NextLeft:
		move.w	#WndCm($03)|$C000,(a1)+			; draw middle left
		dbf	d3,MSS_DBA_NextLeft			; repeat for all middle lefts required

MSS_DBA_NoLeft:
		move.w	#WndCm($08)|$5000,(a1)+			; draw bottom left corner

	; --- Middle part ---

		subq.w	#$02+1,d1				; minus smallest width and dbf count
		bcs.s	MSS_DBA_SkipMiddle

MSS_DBA_NextColumn:
		lea	(a0),a1					; copy location to a1
		lea	$40(a0),a0				; advance to next strip
		move.w	#WndCm($03)|$C000,(a1)+			; draw top
		move.w	d2,d3					; load height
		subq.w	#$02+1,d3				; minus smallest height and dbf count
		bcs.s	MSS_DBA_NoMiddle			; if there's no middle section, branch

MSS_DBA_NextMiddle:
		move.w	#WndCm($03)|$C000,(a1)+			; draw middle
		dbf	d3,MSS_DBA_NextMiddle			; repeat for all middles required

MSS_DBA_NoMiddle:
		move.w	#WndCm($03)|$C000,(a1)+			; draw bottom
		dbf	d1,MSS_DBA_NextColumn			; repeat for all middle columns

MSS_DBA_SkipMiddle:

	; --- Right side ---

		move.w	#WndCm($08)|$4800,(a0)+			; draw top right corner
		move.w	d2,d3					; load height
		subq.w	#$02+1,d3				; minus smallest height and dbf count
		bcs.s	MSS_DBA_NoRight				; if there's no middle section, branch

MSS_DBA_NextRight:
		move.w	#WndCm($03)|$C000,(a0)+			; draw middle right
		dbf	d3,MSS_DBA_NextRight			; repeat for all middle rights required

MSS_DBA_NoRight:
		move.w	#WndCm($08)|$5800,(a0)+			; draw bottom Right corner
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw an inner white box in the window map buffer
; --- inputs ----------------------------------------------------------------
; d0.w	= Position (relative map buffer distance)
; d1.w	= width
; d2.w	= height
; ---------------------------------------------------------------------------

MSS_DrawWhiteBox:
		lea	(a4),a0					; load window map buffer
		adda.w	d0,a0					; advance to correct position

	; --- Left side ---

		lea	(a0),a1					; copy location to a1
		lea	$40(a0),a0				; advance to next strip
		move.w	#WndCm($05)|$C000,(a1)+			; draw top left corner
		move.w	d2,d3					; load height
		subq.w	#$02+1,d3				; minus smallest height and dbf count
		bcs.s	MSS_DWB_NoLeft				; if there's no middle section, branch

MSS_DWB_NextLeft:
		move.w	#WndCm($06)|$C000,(a1)+			; draw middle left
		dbf	d3,MSS_DWB_NextLeft			; repeat for all middle lefts required

MSS_DWB_NoLeft:
		move.w	#WndCm($05)|$D000,(a1)+			; draw bottom left corner

	; --- Middle part ---

		subq.w	#$02+1,d1				; minus smallest width and dbf count
		bcs.s	MSS_DWB_SkipMiddle

MSS_DWB_NextColumn:
		lea	(a0),a1					; copy location to a1
		lea	$40(a0),a0				; advance to next strip
		move.w	#WndCm($07)|$C000,(a1)+			; draw top
		move.w	d2,d3					; load height
		subq.w	#$02+1,d3				; minus smallest height and dbf count
		bcs.s	MSS_DWB_NoMiddle			; if there's no middle section, branch

MSS_DWB_NextMiddle:
		move.w	#WndCm($07)|$C000,(a1)+			; draw middle
		dbf	d3,MSS_DWB_NextMiddle			; repeat for all middles required

MSS_DWB_NoMiddle:
		move.w	#WndCm($07)|$C000,(a1)+			; draw bottom
		dbf	d1,MSS_DWB_NextColumn			; repeat for all middle columns

MSS_DWB_SkipMiddle:

	; --- Right side ---

		move.w	#WndCm($05)|$C800,(a0)+			; draw top right corner
		move.w	d2,d3					; load height
		subq.w	#$02+1,d3				; minus smallest height and dbf count
		bcs.s	MSS_DWB_NoRight				; if there's no middle section, branch

MSS_DWB_NextRight:
		move.w	#WndCm($06)|$C800,(a0)+			; draw middle right
		dbf	d3,MSS_DWB_NextRight			; repeat for all middle rights required

MSS_DWB_NoRight:
		move.w	#WndCm($05)|$D800,(a0)+			; draw bottom Right corner
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw a number that can be displayed inside a white box
; --- inputs ----------------------------------------------------------------
; d0.w	= Position (relative map buffer distance)
; d1.l	= Number to display
; d2.w	= Number of digits to display (minus 1)
; ---------------------------------------------------------------------------

MSS_DrawNumber:
		lea	(a4),a0					; load window map buffer
		adda.w	d0,a0					; advance to correct position
		move.w	d2,d0					; load number of digits
		lsl.w	#$06,d0					; multiply by size of column
		lea	(a0,d0.w),a0				; advance to correct starting column
		lea	(MSS_MapTextTit+$0C).l,a1		; load mappings data (starting from 0)
		move.l	#(($C000|(VRAM_TEXTTITLE/$20))<<$10)|$C000|(VRAM_TEXTTITLE/$20),d3 ; prepare index address addition

MSS_DN_NextDigit:
		move.b	d1,d0					; load digit
		andi.w	#$000F,d0				; get only the digit
		add.w	d0,d0					; multiply by two words
		add.w	d0,d0					; ''
		move.l	(a1,d0.w),d0				; load digit mappings
		add.l	d3,d0					; add VRAM
		move.l	d0,(a0)					; write digit
		lea	-$40(a0),a0				; go to previous digits' column
		lsr.l	#$04,d1					; get next digit
		dbf	d2,MSS_DN_NextDigit			; repeat for all digits
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw a title string with a white box around it
; --- inputs ----------------------------------------------------------------
; d0.w	= Position (relative map buffer distance)
; d1.b	= if the box sides should render (00 = No | FF = Yes)
; a2.l	= ASCII text to render
; ---------------------------------------------------------------------------

MSS_DrawTitle:
		lea	(a4),a0					; load window map buffer
		adda.w	d0,a0					; advance to correct position
		move.b	d1,d0					; store render settings
		beq.s	MSS_DT_NoLeft				; if the sides are disabled, branch
		move.l	#((WndCm($05)|$C000)<<$10)|(WndCm($05)|$D000),(a0) ; draw left side
		lea	$40(a0),a0				; advance to next strip

MSS_DT_NoLeft:
		lea	(MSS_MapTextTit).l,a1			; load mappings data
		moveq	#$00,d1					; clear d1
		move.b	(a2)+,d1				; load character
		beq.w	MSS_DT_Finish				; if it's the end, branch

MSS_DT_DrawChar:
		move.b	MSS_DT_ConList-$20(pc,d1.w),d1		; load correct table position
		move.l	(a1,d1.w),d1				; load correct mappings
		move.l	d1,d2					; load upper tile
		swap	d2					; ''
		addi.w	#$C000|(VRAM_TEXTTITLE/$20),d2		; add VDP index address
		bcc.s	MSS_DT_ANoSpace				; if it's not a space character, branch
		move.w	#WndCm($07)|$C000,d2			; draw blank tile

MSS_DT_ANoSpace:
		swap	d2					; store for now
		move.w	d1,d2					; load lower tile
		addi.w	#$C000|(VRAM_TEXTTITLE/$20),d2		; add VDP index address
		bcc.s	MSS_DT_BNoSpace				; if it's not a space character, branch
		move.w	#WndCm($07)|$C000,d2			; draw blank tile

MSS_DT_BNoSpace:
		move.l	d2,(a0)					; save text to buffer
		lea	$40(a0),a0				; advance to next strip
		moveq	#$00,d1					; clear d1
		move.b	(a2)+,d1				; load character
		bne.w	MSS_DT_DrawChar				; if it's a valid character, branch

MSS_DT_Finish:
		tst.b	d0					; are the sides disabled?
		beq.s	MSS_DT_NoRight				; if so, branch
		move.l	#((WndCm($05)|$C800)<<$10)|(WndCm($05)|$D800),(a0) ; draw right side

MSS_DT_NoRight:
		rts						; return

MSS_DT_ConList:	dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$A0,$A4,$00,$00,$00,$9C,$00,$00	; ASCII to Map position table
		dc.b	$0C,$10,$14,$18,$1C,$20,$24,$28,$2C,$30,$A8,$00,$04,$00,$08,$AC
		dc.b	$00,$34,$38,$3C,$40,$44,$48,$4C,$50,$54,$58,$5C,$60,$64,$68,$6C
		dc.b	$70,$74,$78,$7C,$80,$84,$88,$8C,$90,$94,$98,$00,$00,$00,$00,$00
		dc.b	$00,$34,$38,$3C,$40,$44,$48,$4C,$50,$54,$58,$5C,$60,$64,$68,$6C
		dc.b	$70,$74,$78,$7C,$80,$84,$88,$8C,$90,$94,$98,$00,$00,$00,$00,$00

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw an ASCII caption
; --- inputs ----------------------------------------------------------------
; d0.w	= Position (relative map buffer distance)
; a2.l	= ASCII text to render
; ---------------------------------------------------------------------------

MSS_DrawCaption:
		lea	(a4),a0					; load window map buffer
		adda.w	d0,a0					; advance to correct position

MSS_DC_NewLine:
		lea	(a0),a1					; load map address
		addq.w	#$02,a0					; advance to next row

MSS_DC_Start:
		move.b	(a2)+,d0				; load ASCII character
		beq.s	MSS_DC_Finish				; if finished, branch

MSS_DC_NextChar:
		ext.w	d0					; extend to word
		bmi.s	MSS_DC_NewLine				; if it's a new line marker, branch
		subi.b	#' '+1,d0				; check if it's a space
		bcs.s	MSS_DC_Space				; if so, branch
		addi.w	#$C000|(VRAM_ASCII/$20),d0		; advance to correct character
		move.w	d0,(a1)					; save character
		lea	$40(a1),a1				; advance to next column
		move.b	(a2)+,d0				; load ASCII character
		bne.s	MSS_DC_NextChar				; if it's not finished, branch

MSS_DC_Finish:
		rts						; return

MSS_DC_Space:
		move.w	#WndCm($03)|$C000,(a1)			; use black tile (space character too)
		lea	$40(a1),a1				; advance to next column
		move.b	(a2)+,d0				; load ASCII character
		bne.s	MSS_DC_NextChar				; if it's not finished, branch
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw an ASCII caption - IN CAPS LOCK
; --- inputs ----------------------------------------------------------------
; d0.w	= Position (relative map buffer distance)
; a2.l	= ASCII text to render
; ---------------------------------------------------------------------------

MSS_DrawCaptionCAPS:
		lea	(a4),a0					; load window map buffer
		adda.w	d0,a0					; advance to correct position

MSS_DCC_NewLine:
		lea	(a0),a1					; load map address
		addq.w	#$02,a0					; advance to next row

MSS_DCC_Start:
		move.b	(a2)+,d0				; load ASCII character
		beq.s	MSS_DCC_Finish				; if finished, branch

MSS_DCC_NextChar:
		ext.w	d0					; extend to word
		bmi.s	MSS_DCC_NewLine				; if it's a new line marker, branch
		move.b	d0,d1					; copy character to d1
		subi.b	#'a',d1					; check if it's between lower case a - z
		cmpi.b	#'z'-'a',d1				; ''
		bhi.s	MSS_DCC_NoCapital			; if not, branch
		subi.b	#'a'-'A',d0				; convert to capital A - Z upper case

MSS_DCC_NoCapital:
		subi.b	#' '+1,d0				; check if it's a space
		bcs.s	MSS_DCC_Space				; if so, branch
		addi.w	#$C000|(VRAM_ASCII/$20),d0		; advance to correct character
		move.w	d0,(a1)					; save character
		lea	$40(a1),a1				; advance to next column
		move.b	(a2)+,d0				; load ASCII character
		bne.s	MSS_DCC_NextChar			; if it's not finished, branch

MSS_DCC_Finish:
		rts						; return

MSS_DCC_Space:
		move.w	#WndCm($03)|$C000,(a1)			; use black tile (space character too)
		lea	$40(a1),a1				; advance to next column
		move.b	(a2)+,d0				; load ASCII character
		bne.s	MSS_DCC_NextChar			; if it's not finished, branch
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw the count box from blue spheres challenge
; --- inputs ----------------------------------------------------------------
; d0.w	= Position (relative map buffer distance)
; a2.l  = icon mappings to use
; ---------------------------------------------------------------------------

MSS_DrawCountBox:
		lea	(a4),a0					; load window map buffer
		adda.w	d0,a0					; advance to correct position
		move.w	#(VRAM_COUNTER/$20)|$C000,d1		; prepare vRAM address of counter art

		lea	(a0),a1					; copy location to a1
		lea	$40(a0),a0				; advance to next strip

	; --- Left side ---

		move.l	#((WndCm($0A)|$C000)<<$10)|(WndCm($09)|$C000),d2 ; set to use single version
		move.w	(a1),d0					; load current tile at the location
		andi.w	#$07FF,d0				; get only tile ID
		cmpi.w	#WndCm($09),d0				; is it a corner?
		bne.s	MSS_DCB_LeftTop				; if not, branch
		move.l	#((WndCm($0D)|$C000)<<$10)|(WndCm($0C)|$C000),d2 ; set to use double version

MSS_DCB_LeftTop:
		move.w	d2,(a1)+				; save corner tile

		move.l	#((WndCm($0F)|$C000)<<$10)|(WndCm($0F)|$D000),(a1)+ ; draw left side

		move.l	#((WndCm($0A)|$D000)<<$10)|(WndCm($09)|$D000),d3 ; set to use single version
		move.w	(a1),d0					; load current tile at the location
		andi.w	#$07FF,d0				; get only tile ID
		cmpi.w	#WndCm($09),d0				; is it a corner?
		bne.s	MSS_DCB_LeftBottom			; if not, branch
		move.l	#((WndCm($0D)|$D000)<<$10)|(WndCm($0C)|$D000),d3 ; set to use double version

MSS_DCB_LeftBottom:
		move.w	d3,(a1)+				; save corner tile

	; --- Middle part ---

		swap	d2					; get middle tiles
		swap	d3					; ''
		moveq	#$06-1,d0				; set size of box in width (number of characters)

MSS_DCB_NextDigitSlot:
		lea	(a0),a1					; copy location to a1
		lea	$40(a0),a0				; advance to next strip
		move.w	d2,(a1)+				; save top
		addq.w	#$04,a1					; skip counter in middle
		move.w	d3,(a1)+				; save bottom
		dbf	d0,MSS_DCB_NextDigitSlot		; repeat for all digit slots

	; --- Icon and right side ---

	rept	$02
		lea	(a0),a1					; copy location to a1
		lea	$40(a0),a0				; advance to next strip
		move.w	d2,(a1)+				; save top
		move.w	d1,d0					; load VRAM address of counter art
		add.w	(a2)+,d0				; add mappings
		move.w	d0,(a1)+				; save tile
		move.w	d1,d0					; ''
		add.w	(a2)+,d0				; ''
		move.w	d0,(a1)+				; ''
		move.w	d3,(a1)+				; save bottom
	endm
		lea	(a0),a1					; copy location to a1
		lea	$40(a0),a0				; advance to next strip
		swap	d2					; get side tiles again
		swap	d3					; ''
		addq.w	#(($80/$20)*2),d2			; avance to right tiles
		addq.w	#(($80/$20)*2),d3			; ''
		move.w	d2,(a1)+				; save top
		move.w	d1,d0					; load VRAM address of counter art
		add.w	(a2)+,d0				; add mappings
		move.w	d0,(a1)+				; save tile
		move.w	d1,d0					; ''
		add.w	(a2)+,d0				; ''
		move.w	d0,(a1)+				; ''
		move.w	d3,(a1)+				; save bottom
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw the count box from blue spheres challenge
; --- inputs ----------------------------------------------------------------
; d0.w	= Position (relative map buffer distance)
; d1.w  = Number to display
; ---------------------------------------------------------------------------

MSS_DrawCount:
		lea	(a4),a0					; load window map buffer
		adda.w	d0,a0					; advance to correct position

		moveq	#$02-1,d3				; set to repeat the conversion process twice (for first two digits)
		move.w	#100,d2					; set digit A to count
		bra.s	MSS_DC_StartDigit			; run first digit process

MSS_DC_NextDigit:
		move.w	#10,d2					; set digit B to count

MSS_DC_StartDigit:
		moveq	#-8,d0					; reset d0

MSS_DC_IncreaseDigit:
		addq.w	#$08,d0					; increase digit map position
		sub.w	d2,d1					; decrease digit
		bcc.s	MSS_DC_IncreaseDigit			; if still counting, branch
		add.w	d2,d1					; revert to positive

		move.w	#(VRAM_COUNTER/$20)|$C000,d2		; prepare VRAM address of number art
		lea	(MSS_MapCounter).l,a1			; load counter mappings to use
		adda.w	d0,a1					; advance to correct slot
	rept	$02
		move.w	(a1)+,d0				; load tiles
		add.w	d2,d0					; advance to correct VRAM address
		swap	d0					; send to upper word
		move.w	(a1)+,d0				; load tiles
		add.w	d2,d0					; advance to correct VRAM address
		move.l	d0,(a0)					; save tile
		lea	$40(a0),a0				; advance to next coloumn
	endm
		dbf	d3,MSS_DC_NextDigit			; repeat for next digit

		lsl.w	#$03,d1					; multiply final digit by 8
		lea	(MSS_MapCounter).l,a1			; load counter mappings to use
		adda.w	d1,a1					; advance to correct slot
		move.w	(a1)+,d0				; load tiles
		add.w	d2,d0					; advance to correct VRAM address
		swap	d0					; send to upper word
		move.w	(a1)+,d0				; load tiles
		add.w	d2,d0					; advance to correct VRAM address
		move.l	d0,(a0)					; save tile
		lea	$40(a0),a0				; advance to next coloumn
		move.w	(a1)+,d0				; load tiles
		add.w	d2,d0					; advance to correct VRAM address
		swap	d0					; send to upper word
		move.w	(a1)+,d0				; load tiles
		add.w	d2,d0					; advance to correct VRAM address
		move.l	d0,(a0)					; save tile
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw the up arrow art correctly
; --- inputs ----------------------------------------------------------------
; d0.w	= Position (relative map buffer distance)
; ---------------------------------------------------------------------------

MSS_DrawArrowUp:
		lea	(a4),a0					; load window map buffer
		adda.w	d0,a0					; advance to correct position

		move.l	#((WndCm($10)|$4000)<<$10)|(WndCm($11)|$C000),d2 ; prepare normal version
		move.w	(a0),d0					; load tile at position
		andi.w	#$07FF,d0				; get only tile ID
		cmpi.w	#WndCm($04),d0				; is it a thin black line?
		bne.s	MSS_DAU_NoThin_Left			; if not, branch
		move.l	#((WndCm($12)|$4000)<<$10)|(WndCm($11)|$C000),d2 ; prepare thin version

MSS_DAU_NoThin_Left:
		cmpi.w	#WndCm($03),d0				; is it a thick black line?
		bne.s	MSS_DAU_NoThick_Left			; if not, branch
		move.l	#((WndCm($03)|$C000)<<$10)|(WndCm($11)|$C000),d2 ; prepare thick version

MSS_DAU_NoThick_Left:
		move.l	d2,(a0)					; draw left side

		lea	$40(a0),a0				; advance to next strip
		move.l	#((WndCm($13)|$C000)<<$10)|(WndCm($14)|$C000),(a0) ; draw middle
		lea	$40(a0),a0				; advance to next strip

		move.l	#((WndCm($10)|$4800)<<$10)|(WndCm($11)|$C800),d2 ; prepare normal version
		move.w	(a0),d0					; load tile at position
		andi.w	#$07FF,d0				; get only tile ID
		cmpi.w	#WndCm($04),d0				; is it a thin black line?
		bne.s	MSS_DAU_NoThin_Right			; if not, branch
		move.l	#((WndCm($12)|$4800)<<$10)|(WndCm($11)|$C800),d2 ; prepare thin version

MSS_DAU_NoThin_Right:
		cmpi.w	#WndCm($03),d0				; is it a thick black line?
		bne.s	MSS_DAU_NoThick_Right			; if not, branch
		move.l	#((WndCm($03)|$C800)<<$10)|(WndCm($11)|$C800),d2 ; prepare thick version

MSS_DAU_NoThick_Right:
		move.l	d2,(a0)					; draw right side
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw the down arrow art correctly
; --- inputs ----------------------------------------------------------------
; d0.w	= Position (relative map buffer distance)
; ---------------------------------------------------------------------------

MSS_DrawArrowDown:
		lea	(a4),a0					; load window map buffer
		adda.w	d0,a0					; advance to correct position

		move.l	#((WndCm($11)|$D000)<<$10)|(WndCm($10)|$5000),d2 ; prepare normal version
		move.w	$02(a0),d0				; load tile at position
		andi.w	#$07FF,d0				; get only tile ID
		cmpi.w	#WndCm($04),d0				; is it a thin black line?
		bne.s	MSS_DAD_NoThin_Left			; if not, branch
		move.l	#((WndCm($11)|$D000)<<$10)|(WndCm($12)|$5000),d2 ; prepare thin version

MSS_DAD_NoThin_Left:
		cmpi.w	#WndCm($03),d0				; is it a thick black line?
		bne.s	MSS_DAD_NoThick_Left			; if not, branch
		move.l	#((WndCm($11)|$D000)<<$10)|(WndCm($03)|$D000),d2 ; prepare thick version

MSS_DAD_NoThick_Left:
		move.l	d2,(a0)					; draw left side

		lea	$40(a0),a0				; advance to next strip
		move.l	#((WndCm($14)|$D000)<<$10)|(WndCm($13)|$D000),(a0) ; draw middle
		lea	$40(a0),a0				; advance to next strip

		move.l	#((WndCm($11)|$D800)<<$10)|(WndCm($10)|$5800),d2 ; prepare normal version
		move.w	$02(a0),d0				; load tile at position
		andi.w	#$07FF,d0				; get only tile ID
		cmpi.w	#WndCm($04),d0				; is it a thin black line?
		bne.s	MSS_DAD_NoThin_Right			; if not, branch
		move.l	#((WndCm($11)|$D800)<<$10)|(WndCm($12)|$5800),d2 ; prepare thin version

MSS_DAD_NoThin_Right:
		cmpi.w	#WndCm($03),d0				; is it a thick black line?
		bne.s	MSS_DAD_NoThick_Right			; if not, branch
		move.l	#((WndCm($11)|$D800)<<$10)|(WndCm($03)|$D800),d2 ; prepare thick version

MSS_DAD_NoThick_Right:
		move.l	d2,(a0)					; draw right side
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw a character icon (Sonic/Tails/CPU/etc)
; --- inputs ----------------------------------------------------------------
; d0.w	= Position (relative map buffer distance)
; d1.w	= Starting map ID to use
; ---------------------------------------------------------------------------

MSS_DrawCharacter:
		lea	(a4),a0					; load window map buffer
		adda.w	d0,a0					; advance to correct position
		move.w	d1,(a0)+				; write tile
		addq.w	#$01,d1					; advance to next tile
		move.w	d1,(a0)+				; ''
		addq.w	#$01,d1					; ''
		move.w	d1,(a0)+				; ''
		addq.w	#$01,d1					; ''
		lea	$40-6(a0),a0				; advance to next column
		move.w	d1,(a0)+				; write tile
		addq.w	#$01,d1					; advance to next tile
		move.w	d1,(a0)+				; ''
		addq.w	#$01,d1					; ''
		move.w	d1,(a0)+				; ''
		rts						; return


; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw the "A", "B", "C" button bar thing
; --- inputs ----------------------------------------------------------------
; d0.w	= Position (relative map buffer distance)
; ---------------------------------------------------------------------------
WndBLNK	=	($89E0/$20)
; ---------------------------------------------------------------------------

MSS_DBB_List:	dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	WndBLNK
		dc.w	WndCm($17)|$4000
		dc.w	WndCm($17)|$5000
		dc.w	WndBLNK
MSS_DBB_Y:
		dc.w	$0000
		dc.w	$0000
		dc.w	WndBLNK
		dc.w	WndCm($17)|$4000
		dc.w	WndCm($16)|$4000
		dc.w	(($9E00/$20)+0)|$C000
		dc.w	(($9E00/$20)+1)|$C000
		dc.w	WndCm($18)|$4000

		dc.w	WndBLNK
		dc.w	WndCm($17)|$4000
		dc.w	WndCm($16)|$4000
		dc.w	(($9E00/$20)+4)|$C000
		dc.w	(($9E00/$20)+5)|$C000
		dc.w	(($9E00/$20)+2)|$C000
		dc.w	(($9E00/$20)+3)|$C000
		dc.w	WndCm($19)|$4000

		dc.w	WndCm($15)|$4000
		dc.w	(($9E00/$20)+8)|$C000
		dc.w	(($9E00/$20)+9)|$C000
		dc.w	(($9E00/$20)+6)|$C000
		dc.w	(($9E00/$20)+7)|$C000
		dc.w	WndBLNK
		dc.w	WndBLNK
		dc.w	WndCm($19)|$4000

		dc.w	WndCm($04)|$4000
		dc.w	(($9E00/$20)+10)|$C000
		dc.w	(($9E00/$20)+11)|$C000
		dc.w	WndBLNK
		dc.w	WndBLNK
		dc.w	WndBLNK
		dc.w	WndBLNK
		dc.w	WndCm($19)|$4000

MSS_DBB_X:

		dc.w	WndCm($04)|$4000
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	$0000
		dc.w	WndCm($19)|$4000

		dc.w	WndCm($1A)|$4000
		dc.w	WndCm($1B)|$4000
		dc.w	WndCm($1B)|$4000
		dc.w	WndCm($1B)|$4000
		dc.w	WndCm($1B)|$4000
		dc.w	WndCm($1B)|$4000
		dc.w	WndCm($1B)|$4000
		dc.w	WndCm($1A)|$5000

	; --- The code itself ---
	; The assembler treats the equation below as a division of 0
	; if the table above is below the equation...
	; -----------------------

MSS_DrawButtonBar:
		lea	(a4),a0					; load window map buffer
		adda.w	d0,a0					; advance to correct position
		lea	(MSS_DBB_List).l,a2			; load list

		moveq	#((MSS_DBB_X-MSS_DBB_List)/(MSS_DBB_Y-MSS_DBB_List))-1,d2 ; set width

MSS_DBB_NextX:
		moveq	#((MSS_DBB_Y-MSS_DBB_List)/2)-1,d1	; set height
		lea	(a0),a1					; load map buffer address
		lea	$40(a0),a0				; advance to next column
		bsr.s	MSS_DBB_NextY				; draw the column
		dbf	d2,MSS_DBB_NextX			; repeat for all columns

	; --- The top/bottom middle area ---

		moveq	#$0C-1,d2				; set width

		lea	(a2),a3					; store list

MSS_DBB_NextMiddle:
		moveq	#((MSS_DBB_Y-MSS_DBB_List)/2)-1,d1	; set height
		lea	(a0),a1					; load map buffer address
		lea	$40(a0),a0				; advance to next column
		lea	(a3),a2					; reload list
		bsr.s	MSS_DBB_NextY				; draw the column
		dbf	d2,MSS_DBB_NextMiddle			; repeat for all columns

	; --- The right side ---

		moveq	#((MSS_DBB_Y-MSS_DBB_List)/2)-1,d1	; set height
		lea	(a0),a1					; load map buffer address
						; continue to..	; do far right side (last side)

MSS_DBB_NextY:
		move.w	(a2)+,d0				; load tile
		beq.s	MSS_DBB_SkipTile			; if it's blank, branch
		move.w	d0,(a1)+				; save tile
		dbf	d1,MSS_DBB_NextY			; repeat for all rows
		rts						; return

MSS_DBB_SkipTile:
		addq.w	#$02,a1					; skip over tile
		dbf	d1,MSS_DBB_NextY			; repeat for all rows
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup a tranfer from buffer to VRAM
; --- inputs ----------------------------------------------------------------
; d1.l	= XX YY WW HH (X position, Y position, Width-1, Height-1
; ---------------------------------------------------------------------------

MSS_SetupTransfer:
		lea	(EMS_WindowTrans).w,a0			; load transfer list
		move.w	(a0),d0					; load current list position
		addq.w	#$01,(a0)+				; increase count
		add.w	d0,d0					; multiply by x4
		add.w	d0,d0					; ''
		adda.w	d0,a0					; advance to next available slot
		move.l	d1,(a0)+				; set position and size
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank - Sound Test (Normal)
; ---------------------------------------------------------------------------

MSS_VBlank:
		movem.l	d0-a4,-(sp)				; store registers

		move.w	#$9180,d0				; prepare register settings
		or.b	(EMS_WindowSizeX).w,d0			; load window X position
		move.w	d0,(a6)					; save to VDP to set the window starting size/position

		tst.b	(V_int_routine).w			; was the 68k late?
		beq.s	MMSVB_NoSwitch				; if so, branch
		not.b	(EMS_BufferFlag).w			; switch buffer

MMSVB_NoSwitch:
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as write only
		bsr.w	MMSVB_SetupHBlank			; setup H-blank ready for next frame
		bsr.w	MMSVB_SpriteDMA				; setup DMA for sprites

		tst.b	(V_int_routine).w			; was the 68k late?
		beq.w	MMSVB_68kLate				; if so, branch
		sf.b	(V_int_routine).w			; set V-blank as ran
		jsr	Poll_Controllers			; read controls

		DMA	$0050, $C0300000, Normal_palette+$30
		bsr.w	MSS_UpdateWindow			; update the window mappings

		bsr.w	MSS_UpdatePlanet			; update planet's mapping and palettes
		bsr.w	MSS_ScalePlanet				; update planet scaling

		move.w	#$8F04,(a6)				; set auto-increment to skip a word
		DMA	$01C0, $5C000000, EMS_HScrollFG		; transfer H-scroll FG
		DMA	$01C0, $5C020000, EMS_HScrollBG		; transfer H-scroll BG
		move.w	#$8F02,(a6)				; restore auto-increment

MMSVB_68kLate:
		moveq	#-1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as execute tracker
		move.l	#$40000010,(a6)				; set VDP to VSRAM write mode (BG slot)
		move.w	(EMS_Planet1_Y).w,d0			; set VSRAM position for top scaleable planet

	tst.b	(EMS_LastSlot).w			; are we on the last level slot?
	beq.s	MMSVB_YesScalePlanet			; if not, branch
	move.w	#$FFA0,d0				; hide the scaling planet

MMSVB_YesScalePlanet:
		move.w	d0,(a5)					; set VSRAM position for top scaleable planet

		move.l	(EMS_ReleatBGY).w,d0			; load BG relative position
		asr.l	#$05,d0					; slow it down for scrolling
		andi.w	#$00FF,d0				; keep wrapping (allows us to use FE00 - FFFF in VRAM for art)
		move.w	d0,(a5)					; save to VSRAM
		movem.l	(sp)+,d0-a4				; restore registers
		rte						; return

; ---------------------------------------------------------------------------
; Setting up H-blank for next frame
; ---------------------------------------------------------------------------

MMSVB_SetupHBlank:
		tst.b	(EMS_DisSpheres).w			; is the world being displayed?
		bmi.s	MMSVB_NoWorld				; if not, branch (don't bother transfering mid-screen)

		tst.b	(EMS_PlanetsOn).w			; are the planets on?
		beq.s	MMSVBSH_NoPlanets			; if not, branch
		tst.b	(EMS_NoSpheres).w			; were there any spheres to render?
		beq.s	MSSVBSH_Spheres				; if so, branch

	; --- No sphere sprites, just the planet switch ---

MMSVBSH_NoPlanets:
		move.l	#MSSHB_SwitchWorld,(H_int_addr).w	; set H-interrupt address
		move.w	#$8A00,d0				; prepare H-interrupt register
		move.b	(EMS_Planet2_Y+$01).w,d0		; set planet's Y interrupt position
		move.w	d0,(a6)					; save to VDP
		move.w	#$0100-1,d0				; prepare planet 2's Y plane position (minus 1 for scanline displacement)
		sub.w	(EMS_Planet2_Y).w,d0			; subtract planet's Y position
		move.w	d0,(EMS_Planet2_VS).w			; save as VSRAM position
		rts						; return

	; --- When there are sphere sprites to render ---

MSSVBSH_Spheres:
		move.l	#MSSHB_SwitchWorldA,(H_int_addr).w	; set H-interrupt address
		tst.b	(EMS_BufferFlag).w			; change buffer
		bpl.s	MSSVBSH_Even				; if we're on an even frame, branch to display buffer A
		move.l	#MSSHB_SwitchWorldB,(H_int_addr).w	; set H-interrupt address

MSSVBSH_Even:
		move.w	#$8A00,d0				; prepare H-interrupt register
		move.b	(EMS_Planet2_Y+$01).w,d0		; set planet's Y interrupt position
		lsr.b	#$01,d0					; divide by 2 (I wanna stop off halfway to change the interrupt line...)
		move.w	d0,(a6)					; save to VDP

		move.w	#$0100-1,d0				; prepare planet 2's Y plane position (minus 1 for scanline displacement)
		sub.w	(EMS_Planet2_Y).w,d0			; subtract planet's Y position
		move.w	d0,(EMS_Planet2_VS).w			; save as VSRAM position

MMSVB_NoWorld:
		rts						; return

; ---------------------------------------------------------------------------
; Subroutine to DMA transfer the sprite tables correctly
; ---------------------------------------------------------------------------

MMSVB_SpriteDMA:
		lea	(EMS_DMA_Size).l,a0			; load DMA size storage
		lea	(EMS_DMA).l,a1				; load DMA source storage

		tst.b	(EMS_PlanetsOn).w			; are the planets on?
		bne.s	MMSVB_Planets				; if so, branch
		DMA	$280, $58000000, Sprite_table_buffer	; just transfer the table fully/normally
	;	move.l	#$94009301,(EMS_DMA_SizeHB).w		; set size to transfar smallest amount (1 word)
		rts						; return

MMSVB_Planets:

	; --- Transfering main sprite table (window corner/shadows) ---

		; Corners and scaling shadows

		move.w	(EMS_ShadowSize).w,d1			; load size of shadow data
		addi.w	#($04+1)*8,d1				; add corner window sprites size (and the blank one on the end in-case there's no spheres)
		lsr.w	#$01,d1					; divide by 2 for DMA word size
		movep.w	d1,$01(a0)				; save DMA size
		move.l	(a0),(a6)				; set DMA size
		move.l	#(((((((Sprite_table_buffer)&$FFFFFF)/$02)<<$08)&$FF0000)+((((Sprite_table_buffer)&$FFFFFF)/$02)&$FF))+$96009500),(a6)
		move.l	#((((Sprite_table_buffer)&$FFFFFF)/$02)&$7F0000)|$97005800,(a6)
		move.w	#$0080,(a6)				; write final destination

		; Shadow of main planet
		; (Written to the very end of the table)

		DMA	MSS_RSPS_Size, ($5A80-MSS_RSPS_Size)<<$10, Sprite_table_buffer+($280-MSS_RSPS_Size)

		tst.b	(EMS_NoSpheres).w			; were there any spheres to render?
		beq.s	MMSVB_Spheres				; if so, branch
		rts						; return

MMSVB_Spheres:
		move.l	#$94009301,(EMS_DMA_SizeHB).w		; set size to transfar smallest amount (1 word)
		move.w	(EMS_ShadowSize).w,d1			; load size of shadow data
		beq.s	MMSVB_NoShadow				; if there is no size, branch
		lsr.w	#$01,d1					; divide by 2 for DMA word size
		movep.w	d1,$01(a0)				; save DMA size
		move.l	(a0),(EMS_DMA_SizeHB).w			; save for later (to replace shadow with spheres)

MMSVB_NoShadow:

	; --- Transfering the first half of spheres ---

		move.w	#$0280-(4*8)-MSS_RSPS_Size,d1		; prepare maximum size of sprite table for spheres
		sub.w	(EMS_ShadowSize).w,d1			; minus scaling shadow sprites
		lsr.w	#$01,d1					; divide by 2 for DMA word size
		movep.w	d1,$01(a0)				; save DMA size
		move.l	(a0),(a6)				; set DMA size

		move.l	#EMS_SpriteTop_A,d1			; load sphere sprites buffer
		tst.b	(EMS_BufferFlag).w			; are we displaying buffer A?
		bpl.s	MMSVB_BufferA				; if so, branch
		move.l	#EMS_SpriteTop_B,d1			; load second sphere sprites buffer

MMSVB_BufferA:
		add.w	(EMS_ShadowSize).w,d1			; advance to starting point (after scaling shadow)
		lsr.l	#$01,d1					; divide by 2 for DMA word size
		movep.l	d1,$01(a1)				; save with VDP registers
		move.l	$04(a1),(a6)				; save DMA source
		move.w	$02(a1),(a6)				; ''
		move.w	#$5800+(4*8),d1				; prepare VRAM address
		add.w	(EMS_ShadowSize).w,d1			; advance to correct starting point
		move.w	d1,(a6)					; save DMA destination
		move.w	#$0080,(a6)				; ''
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; H-blank
; ---------------------------------------------------------------------------
MSSHB_SWITCH	= $3E	; Number of scanlines down the planet before the bottom sprites need to swap in
; ---------------------------------------------------------------------------

	; --- No sphere sprites, just the planet switch ---

MSSHB_SwitchWorld:
		move.l	#$40000010,(a6)				; set VDP to VSRAM write mode (BG slot)
		move.w	(EMS_Planet2_VS).w,(a5)			; set new position (for planet 2)
		move.w	#$8A00|$FF,(a6)				; 7654 3210 - H-Interrupt Register
		move.l	#NullRTE,(H_int_addr).w			; set H-interrupt address
		rte						; return

	; --- For transferring buffer A ---

MSSHB_SwitchWorldA:
		move.w	#$8A00|MSSHB_SWITCH,(a6)		; change interrupt line
		move.l	#MSSHB_HScrollA,(H_int_addr).w		; set next address
		rte						; return

MSSHB_HScrollA:
		move.l	#$40000010,(a6)				; set VDP to VSRAM write mode (BG slot)
		move.w	(EMS_Planet2_VS).w,(a5)			; set new position (for planet 2)
		move.l	#MSSHB_SpritesA,(H_int_addr).w		; set H-interrupt address
		move.w	#$8A00|$FF,(a6)				; 7654 3210 - H-Interrupt Register
		move.l	(EMS_DMA_SizeHB).w,(a6)			; set DMA size
		move.l	#(((((((EMS_SpriteTop_A)&$FFFFFF)/$02)<<$08)&$FF0000)+((((EMS_SpriteTop_A)&$FFFFFF)/$02)&$FF))+$96009500),(a6)
		move.l	#((((EMS_SpriteTop_A)&$FFFFFF)/$02)&$7F0000)|$97005820,(a6)	; INCLUDES SKIPPING OVER WINDOW CORNER SPRITES (SEE 20)
		move.w	#$0080,(a6)				; write final destination
		rte						; return

MSSHB_SpritesA:
		move.l	#NullRTE,(H_int_addr).w			; set H-interrupt address
		DMA	($280-(4*8)-MSS_RSPS_Size), $58200000, EMS_SpriteBot_A
		rte						; return

	; --- For transferring buffer B ---

MSSHB_SwitchWorldB:
		move.w	#$8A00|MSSHB_SWITCH,(a6)		; change interrupt line
		move.l	#MSSHB_HScrollB,(H_int_addr).w		; set next address
		rte						; return

MSSHB_HScrollB:
		move.l	#$40000010,(a6)				; set VDP to VSRAM write mode (BG slot)
		move.w	(EMS_Planet2_VS).w,(a5)			; set new position (for planet 2)
		move.l	#MSSHB_SpritesB,(H_int_addr).w		; set H-interrupt address
		move.w	#$8A00|$FF,(a6)				; 7654 3210 - H-Interrupt Register
		move.l	(EMS_DMA_SizeHB).w,(a6)			; set DMA size
		move.l	#(((((((EMS_SpriteTop_B)&$FFFFFF)/$02)<<$08)&$FF0000)+((((EMS_SpriteTop_B)&$FFFFFF)/$02)&$FF))+$96009500),(a6)
		move.l	#((((EMS_SpriteTop_B)&$FFFFFF)/$02)&$7F0000)|$97005820,(a6)	; INCLUDES SKIPPING OVER WINDOW CORNER SPRITES (SEE 20)
		move.w	#$0080,(a6)				; write final destination
		rte						; return

MSSHB_SpritesB:
		move.l	#NullRTE,(H_int_addr).w			; set H-interrupt address
		DMA	($280-(4*8)-MSS_RSPS_Size), $58200000, EMS_SpriteBot_B
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to transfer new window mappings while the window resizes in/out
; ---------------------------------------------------------------------------

MSS_UpdateWindow:
		bsr.w	MSS_WindowList				; read and process transfer list

		tst.b	(EMS_WindowDraw).w			; has a draw update been requested?
		beq.w	MSS_UW_NoUpdate				; if not, branch

		move.w	#$8F80,(a6)				; set auto-increment to 80 bytes (single line of mappings)
		move.b	(EMS_WindowSizeX).w,d3			; load window X size


		lea	(EMS_DMA).l,a1				; load DMA source storage
		move.l	#$00820000,d0				; prepare VDP lower word address
		move.b	d3,d0					; copy to d0

		add.w	d0,d0					; multiply by x4 (two words per size position)
		add.w	d0,d0					; ''
		addi.w	#$5080+2,d0				; add starting window position
		move.l	d0,d2					; store address in d2

		cmpi.b	#$14-1,d3				; is the opening/closing too small?
		bhs.w	MSS_UW_NoDraw				; if so, branch

	; --- Centre strip ---

		move.l	#$9400931A,(a6)				; set DMA size
		move.l	#(((((((EMS_MenuStrip)&$FFFFFF)/$02)<<$08)&$FF0000)+((((EMS_MenuStrip)&$FFFFFF)/$02)&$FF))+$96009500),(a6) ; set DMA source
		move.w	#(((((EMS_MenuStrip)&$FFFFFF)/$02)&$7F0000)>>$10)|$9700,(a6) ; set DMA source
		move.w	d0,(a6)					; set DMA destination
		swap	d0					; ''
		move.w	d0,(a6)					; '' (DMA start here)

		tst.b	(EMS_WindowDraw).w			; is the window closing?
		bpl.w	MSS_UW_Right				; if so, branch

	; --- First strip to the right ---

		move.l	#$9400931A,(a6)				; set DMA size
		moveq	#$00,d1					; clear d1
		move.w	(EMS_WindowSizeX).w,d1			; load window X size (x100)
		sf.b	d1					; ''
		lsr.w	#$01,d1					; divide to x80
		add.w	#$0040,d1				; advance right
		add.l	(EMS_MapAddress).w,d1			; add map address to advance to correct window mappings
		lsr.l	#$01,d1					; divide by 2 for DMA word size
		movep.l	d1,$01(a1)				; save with VDP registers
		move.l	$04(a1),(a6)				; save DMA source
		addq.w	#$02,d2					; advance to next column
		move.l	d2,d0					; load VDP write address
		move.w	d0,(a6)					; set DMA destination
		swap	d0					; ''
		move.w	d0,(a6)					; '' (DMA start here)

		cmpi.b	#$14-2,d3				; is the opening too small?
		bhs.s	MSS_UW_NoDraw				; if so, branch to ignore this third strip

	; --- Second strip to the right ---

		move.l	#$9400931A,(a6)				; set DMA size
		movep.w	$05(a1),d1				; load lower word of source
		addi.w	#$0040>>1,d1				; advance to next column
		movep.w	d1,$05(a1)				; update lower word
		move.l	$04(a1),(a6)				; save DMA source
		addq.w	#$02,d2					; advance to next column
		move.l	d2,d0					; load VDP write address
		move.w	d0,(a6)					; set DMA destination
		swap	d0					; ''
		move.w	d0,(a6)					; '' (DMA start here)

MSS_UW_NoDraw:
		tst.b	(EMS_WindowDraw).w			; is the window closing?
		bpl.w	MSS_UW_Right				; if so, branch

		move.w	#$8F02,(a6)				; restore auto-increment
		sf.b	(EMS_WindowDraw).w			; clear flag

MSS_UW_NoUpdate:
		rts						; return

MSS_UW_Right:

	; --- First strip to the left ---

		move.l	#$9400931A,(a6)				; set DMA size
		move.l	#(((((((MSS_UW_Blank)&$FFFFFF)/$02)<<$08)&$FF0000)+((((MSS_UW_Blank)&$FFFFFF)/$02)&$FF))+$96009500),(a6) ; set DMA source
		move.w	#(((((MSS_UW_Blank)&$FFFFFF)/$02)&$7F0000)>>$10)|$9700,(a6) ; set DMA source
		subq.w	#$02,d2					; advance to next column
		move.l	d2,d0					; load VDP write address
		move.w	d0,(a6)					; set DMA destination
		swap	d0					; ''
		move.w	d0,(a6)					; '' (DMA start here)

		move.w	#$8F02,(a6)				; restore auto-increment
		sf.b	(EMS_WindowDraw).w			; clear flag
		rts						; return

MSS_UW_Blank:	dc.w	[$1A] $0000				; blank section to transfer (to clear a strip)

; ---------------------------------------------------------------------------
; Window transfer list processing
; ---------------------------------------------------------------------------

MSS_WindowList:
		lea	(EMS_WindowTrans).w,a0			; load transfer list
		move.w	(a0),d7					; load number of entries
		clr.w	(a0)+					; clear count
		subq.w	#$01,d7					; minus 1 for dbf
		bmi.s	MSS_WL_Finish				; if there's nothing in the list, branch
		move.w	#$8F80,(a6)				; set auto-increment to single line
		move.l	#$00020000,d4				; prepare line advancement (and ironically VDP address)

MSS_WL_Next:
		moveq	#$00,d2					; clear d2
		move.b	(a0),d2					; load X position
		move.w	(a0)+,d1				; load position
		move.l	d4,d0					; clear d0 (and prepare VDP address)
		move.b	d1,d0					; keep Y position
		add.b	d0,d0					; multiply Y by size of word
		sf.b	d1					; get only X position
		lsr.w	#$02,d1					; align X to size of x40
		or.b	d0,d1					; fuse Y with X
		movea.l	(EMS_MapAddress).w,a1			; load map address
		adda.w	d1,a1					; advance to correct location
		add.w	d2,d2					; multiply X to size of word map tile
		lsl.w	#$06,d0					; multiply Y to x80
		or.w	d2,d0					; fuse Y with X
		addi.w	#$5082,d0				; add starting window address
		swap	d0					; align for VDP
		moveq	#$00,d2					; clear d2
		move.b	(a0)+,d2				; load X size
		moveq	#$00,d3					; clear d3
		move.b	(a0)+,d3				; load Y size

MSS_WL_NextX:
		move.l	d0,(a6)					; set VDP address
		add.l	d4,d0					; advance to next vertical position
		lea	(a1),a2					; load map slot
		lea	$40(a1),a1				; advance to next map slot
		move.w	d3,d1					; load Y size

MSS_WL_NextY:
		move.w	(a2)+,(a5)				; copy mappings over
		dbf	d1,MSS_WL_NextY				; repeat for all Y size
		dbf	d2,MSS_WL_NextX				; repeat for all X size
		dbf	d7,MSS_WL_Next				; repeat for all entires
		move.w	#$8F02,(a6)				; restore auto-increment

MSS_WL_Finish:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to map and palettise the planet correctly
; ---------------------------------------------------------------------------

MSS_UpdatePlanet:
		tst.b	(EMS_DisSpheres).w			; is the world being displayed?
		bpl.s	MSS_UP_YesWorld				; if so, branch
		rts						; return (no rendering)

MSS_UP_YesWorld:
		move.w	(EMS_WorldRotH+2).w,d0			; load the world's horizontal position
		subi.w	#$0400,d0				; adjust checkboard to match spheres
		andi.w	#$0FC0,d0				; keep within the limit
		mulu.w	#$000B*$10*2,d0				; multiply by E frames
		divu.w	#($0FC0/2),d0				; divide by original limit
		andi.l	#$000003E0,d0				; get only within the palette frame limit (and clear upper word)
		lea	(EMS_PlanetPal+4).l,a0			; load starting palette list
		adda.w	d0,a0					; advance to correct slot
		lea	$7*2(a0),a1				; load halfway position
		divu.w	#$00C0,d0				; divide the palette selection into slots of 4 (1 and 3 should be reversed mappings)
		moveq	#$00,d2					; set to use normal mappings
		btst.l	#$00,d0					; if this palette slot 0 or 2?
		beq.s	MSS_UP_NoSwapMap			; if so, branch
		move.w	#$1800,d2				; use mirrored mappings instead (for slot 1 or 3)

MSS_UP_NoSwapMap:
		move.w	(EMS_WorldRotV+2).w,d0			; load the vertical position
		subi.w	#$0400,d0				; adjust checkboard to match spheres
		andi.w	#$0FC0,d0				; keep within the limit
		mulu.w	#$000B*$10*2,d0				; multiply by B frames
		divu.w	#($0FC0/$10)/2,d0			; divide by original lmit
		move.w	d0,d1					; keep a copy of the position
		subi.w	#($800*($B*$10*2))/(($0FC0/$10)/2),d1	; get odd/even slots
		bmi.s	MSS_NoSwap				; if we're on an odd slot, branch
		exg.l	a0,a1					; swap the halfway positions around (so the palette sides are rendered in opposite order)
		move.w	d1,d0					; wrap position back to positive (quicker this way)

MSS_NoSwap:
	move.l	#$C0040000,(a6)
	move.l	(a0)+,(a5)
	move.l	(a0)+,(a5)
	move.l	(a0)+,(a5)
	move.w	(a0)+,(a5)
	move.l	(a1)+,(a5)
	move.l	(a1)+,(a5)
	move.l	(a1)+,(a5)
	move.w	(a1)+,(a5)
	;	lea	(Normal_palette+$04).w,a2		; load palette buffer position
	;	move.l	(a0)+,(a2)+				; write first half of cycle
	;	move.l	(a0)+,(a2)+				; ''
	;	move.l	(a0)+,(a2)+				; ''
	;	move.w	(a0)+,(a2)+				; ''
	;	move.l	(a1)+,(a2)+				; write second half of cycle
	;	move.l	(a1)+,(a2)+				; ''
	;	move.l	(a1)+,(a2)+				; ''
	;	move.w	(a1)+,(a2)+				; ''
		andi.w	#$1E00,d0				; get only within the map frame limit
		add.w	d2,d0					; add palette's mirror requirement (if any)
		cmp.w	(EMS_CurMapPos).w,d0			; is this frame already rendered?
		beq.w	MSS_UP_Return				; if so, branch
		move.w	d0,(EMS_CurMapPos).w			; update frame map
		move.l	#$00800000,d3				; set line advance amount
		lea	(EMS_PlanetMap).l,a1			; load mappings address
		adda.w	d0,a1					; advance to correct frame to map
		move.l	#$00034000,d0				; prepare
		move.w	(EMS_WorldPosY).w,d1			; load Y position of planet
		subi.w	#$0040,d1				; align from centre
		andi.w	#$01F8,d1				; keep within a tiles' worth
		lsl.w	#$04,d1					; multiply to size of a single line
		or.w	d1,d0					; fuse to VDP long-word
		move.w	(EMS_WorldPosX).w,d1			; load X position of planet
		subi.w	#$0040,d1				; align from centre
		andi.w	#$01F8,d1				; keep within a tiles' worth
		lsr.w	#$02,d1					; divide to multiples of 2
		or.w	d1,d0					; fuse to VDP long-word
		swap	d0					; swap for subroutine
		moveq	#$10-1,d1				; set width
		moveq	#$10-1,d2				; set height
		jmp	MSS_MapScreenDMA

; ---------------------------------------------------------------------------
; Subroutine to write mapping tiles correctly to a plane
; --- Inputs ----------------------------------------------------------------
; d3.l = Line advance value
; d0.l = VRAM address of plane to write to
; d1.w = X size
; d2.w = Y size
; ---------------------------------------------------------------------------

MSS_MapScreen:
		move.l	d0,(a6)					; set VDP to VRAM write mode
		add.l	d3,d0					; advance to next line
	;	andi.l	#$DFFFFFFF,d0				; wrap
		move.w	d1,d4					; load X size

MSS_MapColumn:
		move.w	(a1)+,(a5)				; copy tile mappings over
		dbf	d4,MSS_MapColumn			; repeat until all done
		dbf	d2,MSS_MapScreen			; repeat for all rows

MSS_UP_Return:
		rts						; return

; ---------------------------------------------------------------------------
; DMA version
; ---------------------------------------------------------------------------

MSS_MapScreenDMA:
		tas.b	d0					; enable DMA bit
		move.l	a1,d4					; get source
		lsr.l	#$01,d4					; divide by size of word
		bclr.l	#$17,d4					; clear MSB of DMA register (smaller than AND.l, same speed)
		lea	(EMS_DMA+$02).l,a0			; put into registers
		movep.l	d4,-$01(a0)				; ''
		move.l	(a0)+,(a6)				; set DMA source
		move.w	(a0)+,(a6)				; ''
		addi.w	#$9301,d1				; prepare width as DMA size
		move.w	d0,(EMS_DMA_Dest).w			; save last DMA address
		swap	d0					; get first destination
		swap	d3					; align d3 for additionm

MSS_EL_LoadMap:
		move.w	d1,(a6)					; set DMA size
		move.w	d0,(a6)					; set DMA destination
		move.w	(EMS_DMA_Dest).w,(a6)			; set DMA last destination
		add.w	d3,d0					; advance to next plane line
	;	andi.l	#$DFFFFFFF,d0				; wrap
		dbf	d2,MSS_EL_LoadMap			; repeat for all columns
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to scale the planet in the BG
; ---------------------------------------------------------------------------
DMARAW:		macro	Size, Destination, Source
		dc.l	((((((Size)/$02)<<$08)&$FF0000)+(((Size)/$02)&$FF))+$94009300)
		dc.l	(((((((Source)&$FFFFFF)/$02)<<$08)&$FF0000)+((((Source)&$FFFFFF)/$02)&$FF))+$96009500)
		dc.w	((((((Source)&$FFFFFF)/$02)&$7F0000)>>$10)+$9700)
		dc.w	Destination
		endm
DMANOSR:	macro	Size, Destination
		dc.l	((((((Size)/$02)<<$08)&$FF0000)+(((Size)/$02)&$FF))+$94009300)
		dc.w	Destination
		endm
DMANODST:	macro	Size, Source
		dc.l	((((((Size)/$02)<<$08)&$FF0000)+(((Size)/$02)&$FF))+$94009300)
		dc.l	(((((((Source)&$FFFFFF)/$02)<<$08)&$FF0000)+((((Source)&$FFFFFF)/$02)&$FF))+$96009500)
		dc.w	((((((Source)&$FFFFFF)/$02)&$7F0000)>>$10)+$9700)
		endm
; ---------------------------------------------------------------------------

MSS_ScalePlanet:
		tst.b	(EMS_DisScale).w			; is the scaleable planet disabled?
		bmi.w	MSS_UP_Return				; if so, branch
	tst.b	(EMS_LastSlot).w			; are we on the last level slot?
	bne.s	MSS_UP_Return				; if so, branch (there is no scale planet)

		lea	(EMS_ScalePal+$10).l,a0			; load palette cycle (starting from correct spot)
		moveq	#$00,d1					; clear d1
		move.b	(EMS_ScaleCycle).w,d1			; load cycle
		addi.w	#$00A0,(EMS_ScaleCycle).w		; increase cycle speed
		cmpi.b	#$07,(EMS_ScaleCycle).w			; have we reached the end of the cycle?
		blo.s	MSS_SP_NoResetPal			; if not, branch
		move.b	#$00,(EMS_ScaleCycle).w			; reset cycle

MSS_SP_NoResetPal:
		lsl.w	#$05,d1					; multiply by 20 (size of a palette line in the cycle list)
		adda.w	d1,a0					; advance to correct cycle frame
		moveq	#$00,d0					; set to use normal mappings
		move.w	(a0)+,d2				; load first default floor colour (always first one)
		cmp.w	(a0)+,d2				; does the flag colour match it?  (is the frame meant to be mirrored this time)?
		beq.s	MSS_SP_NoMirror				; if not, branch
		move.w	#$0200,d0				; set to use mirror mappings

MSS_SP_NoMirror:
	move.l	#$C0240000,(a6)
	move.l	(a0)+,(a5)
	move.l	(a0)+,(a5)
	move.l	(a0)+,(a5)
	;	lea	(Normal_palette+$24).w,a1		; load palette buffer position
	;	move.l	(a0)+,(a1)+				; copy cycle palette over
	;	move.l	(a0)+,(a1)+				; ''
	;	move.l	(a0)+,(a1)+				; ''

		move.b	(EMS_ScaleAmount).w,d3			; load current scale amount
		bmi.w	MSS_UP_Return				; if it's invalid, branch
		cmp.b	(EMS_ScalePrev).w,d3			; has it changed?
		bne.w	MSS_SP_YesMap				; if so, branch
		cmp.w	(EMS_CurScalePos).w,d0			; has the mapping changed?
		beq.s	MSS_SP_NoMap				; if not, branch (don't bother updating)

MSS_SP_YesMap:
		move.w	d0,(EMS_CurScalePos).w			; save frame (to prevent re-rendering if possible)
		lea	(EMS_PlanetScale).l,a1			; load mappings RAM space
		adda.w	d0,a1					; advance to correct mapping frame
		move.l	#$00034000,d0				; prepare VDP plane address

		andi.w	#$00F8,d3				; keep in multiples of 8 pixels (size of tile)
		move.w	(EMS_ScalePosY).w,d1			; load Y position of planet
		add.w	d3,d1					; advance down to starting point
		move.w	d3,d2					; multiply by size of map line
		add.w	d2,d2					; ''
		add.w	d2,d2					; ''
		adda.w	d2,a1					; advance to start mappings from where the art would be (given its size)
		subi.w	#$0040,d1				; align from centre
		andi.w	#$01F8,d1				; keep within a tiles' worth
		lsl.w	#$04,d1					; multiply to size of a single line
		or.w	d1,d0					; fuse to VDP long-word
		move.w	(EMS_ScalePosX).w,d1			; load X position of planet
		subi.w	#$0040,d1				; align from centre
		andi.w	#$01F8,d1				; keep within a tiles' worth
		lsr.w	#$02,d1					; divide to multiples of 2
		or.w	d1,d0					; fuse to VDP long-word
		swap	d0					; swap for subroutine
		moveq	#$10-1,d1				; set width
		moveq	#$10-1,d2				; set height
		lsr.w	#$02,d3					; divide the tile render position by 8 (then multiply by 2)
		sub.w	d3,d2					; decrease height by size of scale (no need to map the whole thing if there's only a small art rendering)
		move.l	#$00800000,d3				; set line advance amount
		jsr	MSS_MapScreenDMA			; dump mappings

MSS_SP_NoMap:
		moveq	#$00,d0					; clear d0
		move.b	(EMS_ScaleAmount).w,d0			; load current scale amount
		cmp.b	(EMS_ScalePrev).w,d0			; has it changed?
		beq.w	MSS_UP_Return				; if not, branch
		move.b	d0,(EMS_ScalePrev).w			; update as previous now
		move.l	#$00827280,d4				; prepare VDP write address (with DMA)
		bsr.w	MSS_RenderScale				; run planet scaling

	; --- Now the shadow/shine art ---

EMS_SCALESHVRAM	=	$AB40

		moveq	#$00,d0					; clear d0
		move.b	(EMS_ScaleAmount).w,d0			; load current scale amount
		add.w	d0,d0					; multiply by A
		move.w	d0,d1					; ''
		add.w	d0,d0					; ''
		add.w	d0,d0					; ''
		add.w	d1,d0					; ''
		lea	MSS_ScaleList(pc,d0.w),a0		; load correct
		move.l	(a0)+,(a6)				; set DMA size
		move.l	(a0)+,(a6)				; set DMA source
		move.w	(a0)+,(a6)				; set DMA source (highest byte)
		move.w	#$4000|(EMS_SCALESHVRAM&$3FFF),(a6)	; set DMA destination
		move.w	#((EMS_SCALESHVRAM>>$0E)&3)|$80,(a6)	; ''
		rts						; return

	; --- Art scale transfers (For shine/shadow) ---

MSS_ScaleList:	DMANODST -($0000-$0720), MSS_ScaleShine+$0000		; 00
		DMANODST -($0720-$0E20), MSS_ScaleShine+$0720		; 01
		DMANODST -($0E20-$1560), MSS_ScaleShine+$0E20		; 02
		DMANODST -($1560-$1C40), MSS_ScaleShine+$1560		; 03
		DMANODST -($1C40-$2380), MSS_ScaleShine+$1C40		; 04
		DMANODST -($2380-$2A40), MSS_ScaleShine+$2380		; 05
		DMANODST -($2A40-$3140), MSS_ScaleShine+$2A40		; 06
		DMANODST -($3140-$3760), MSS_ScaleShine+$3140		; 07
		DMANODST -($3760-$3D40), MSS_ScaleShine+$3760		; 08
		DMANODST -($3D40-$4300), MSS_ScaleShine+$3D40		; 09
		DMANODST -($4300-$48A0), MSS_ScaleShine+$4300		; 0A
		DMANODST -($48A0-$4E00), MSS_ScaleShine+$48A0		; 0B
		DMANODST -($4E00-$5340), MSS_ScaleShine+$4E00		; 0C
		DMANODST -($5340-$58C0), MSS_ScaleShine+$5340		; 0D
		DMANODST -($58C0-$5E40), MSS_ScaleShine+$58C0		; 0E
		DMANODST -($5E40-$62A0), MSS_ScaleShine+$5E40		; 0F
		DMANODST -($62A0-$6720), MSS_ScaleShine+$62A0		; 10
		DMANODST -($6720-$6B40), MSS_ScaleShine+$6720		; 11
		DMANODST -($6B40-$6F80), MSS_ScaleShine+$6B40		; 12
		DMANODST -($6F80-$73C0), MSS_ScaleShine+$6F80		; 13
		DMANODST -($73C0-$77E0), MSS_ScaleShine+$73C0		; 14
		DMANODST -($77E0-$7BE0), MSS_ScaleShine+$77E0		; 15
		DMANODST -($7BE0-$7FC0), MSS_ScaleShine+$7BE0		; 16
		DMANODST -($7FC0-$8320), MSS_ScaleShine+$7FC0		; 17
		DMANODST -($8320-$86C0), MSS_ScaleShine+$8320		; 18
		DMANODST -($86C0-$89E0), MSS_ScaleShine+$86C0		; 19
		DMANODST -($89E0-$8CE0), MSS_ScaleShine+$89E0		; 1A
		DMANODST -($8CE0-$8FE0), MSS_ScaleShine+$8CE0		; 1B
		DMANODST -($8FE0-$92C0), MSS_ScaleShine+$8FE0		; 1C
		DMANODST -($92C0-$95A0), MSS_ScaleShine+$92C0		; 1D
		DMANODST -($95A0-$9820), MSS_ScaleShine+$95A0		; 1E
		DMANODST -($9820-$9A40), MSS_ScaleShine+$9820		; 1F

; ---------------------------------------------------------------------------
; Subroutine to scale planet art correctly
; --- intputs ---------------------------------------------------------------
; d0.w = Scale amount (0000 - 001F)
; d4.l = VDP Write address (words swapped) MUST HAVE DMA BIT SET!!!
; ---------------------------------------------------------------------------

MSS_RenderScale:
		add.b	d0,d0					; multiply by size of long-word
		add.b	d0,d0					; ''
		lea	MSS_ScaleData(pc),a0			; load full DMA list
		move.l	(a0,d0.w),a0				; load correct DMA list
		move.l	(a0)+,(a6)				; set DMA transfer
		move.l	(a0)+,(a6)				; ''
		move.w	(a0)+,(a6)				; ''
		move.l	d4,d0					; load VDP write address
		add.w	(a0)+,d0				; add relative address
		move.w	d0,(a6)					; set DMA destination A
		swap	d0					; align for VDP
		move.w	d0,(a6)					; set DMA destination B
		move.l	(a0)+,d0				; load continue list address
		bmi.s	MSS_RS_Return				; if there's no continue list, branch
		move.l	d0,a0					; set address
		move.l	(a0)+,d0				; load DMA size

MSS_RS_NextScale:
		move.l	d0,(a6)					; set size
		move.l	d4,d0					; load VDP write address
		add.w	(a0)+,d0				; add relative address
		move.w	d0,(a6)					; set DMA destination A
		swap	d0					; align for VDP
		move.w	d0,(a6)					; set DMA destination B
		move.l	(a0)+,d0				; load next size
		bmi.s	MSS_RS_NextScale			; if there's more DMA to do, branch

MSS_RS_Return:
		rts						; return

	; --- Art scale transfers ---

MSS_ScaleData:	dc.l	MSS_SD_Scale4A,MSS_SD_Scale4B,MSS_SD_Scale4C,MSS_SD_Scale4D,MSS_SD_Scale4E,MSS_SD_Scale4F,MSS_SD_Scale4G,MSS_SD_Scale4H
		dc.l	MSS_SD_Scale3A,MSS_SD_Scale3B,MSS_SD_Scale3C,MSS_SD_Scale3D,MSS_SD_Scale3E,MSS_SD_Scale3F,MSS_SD_Scale3G,MSS_SD_Scale3H
		dc.l	MSS_SD_Scale2A,MSS_SD_Scale2B,MSS_SD_Scale2C,MSS_SD_Scale2D,MSS_SD_Scale2E,MSS_SD_Scale2F,MSS_SD_Scale2G,MSS_SD_Scale2H
		dc.l	MSS_SD_Scale1A,MSS_SD_Scale1B,MSS_SD_Scale1C,MSS_SD_Scale1D,MSS_SD_Scale1E,MSS_SD_Scale1F,MSS_SD_Scale1G,MSS_SD_Scale1H

MSS_SD_Scale4A:	DMARAW	$0D80, $0000, MSS_Scalex4+(0*$D80)
		dc.w	$FFFF
MSS_SD_Scale4B:	DMARAW	$0D80, $0000, MSS_Scalex4+(1*$D80)
		dc.w	$FFFF
MSS_SD_Scale4C:	DMARAW	$0D80, $0000, MSS_Scalex4+(2*$D80)
		dc.w	$FFFF
MSS_SD_Scale4D:	DMARAW	$0D80, $0000, MSS_Scalex4+(3*$D80)
		dc.w	$FFFF
MSS_SD_Scale4E:	DMARAW	$0D80, $0000, MSS_Scalex4+(4*$D80)
		dc.w	$FFFF
MSS_SD_Scale4F:	DMARAW	$0D80, $0000, MSS_Scalex4+(5*$D80)
		dc.w	$FFFF
MSS_SD_Scale4G:	DMARAW	$0D80, $0000, MSS_Scalex4+(6*$D80)
		dc.w	$FFFF
MSS_SD_Scale4H:	DMARAW	$0D80, $0000, MSS_Scalex4+(7*$D80)
		dc.w	$FFFF

MSS_SD_Scale3A:	DMARAW	$0100, $0120, MSS_Scalex3+(0*$AC0)
		dc.l	MSS_SD_Scale3
MSS_SD_Scale3B:	DMARAW	$0100, $0120, MSS_Scalex3+(1*$AC0)
		dc.l	MSS_SD_Scale3
MSS_SD_Scale3C:	DMARAW	$0100, $0120, MSS_Scalex3+(2*$AC0)
		dc.l	MSS_SD_Scale3
MSS_SD_Scale3D:	DMARAW	$0100, $0120, MSS_Scalex3+(3*$AC0)
		dc.l	MSS_SD_Scale3
MSS_SD_Scale3E:	DMARAW	$0100, $0120, MSS_Scalex3+(4*$AC0)
		dc.l	MSS_SD_Scale3
MSS_SD_Scale3F:	DMARAW	$0100, $0120, MSS_Scalex3+(5*$AC0)
		dc.l	MSS_SD_Scale3
MSS_SD_Scale3G:	DMARAW	$0100, $0120, MSS_Scalex3+(6*$AC0)
		dc.l	MSS_SD_Scale3
MSS_SD_Scale3H:	DMARAW	$0100, $0120, MSS_Scalex3+(7*$AC0)
		dc.l	MSS_SD_Scale3

MSS_SD_Scale3:	DMANOSR	$0140, $0260
		DMANOSR	$0180, $03E0
		DMANOSR	$01C0, $05A0
		DMANOSR	$01C0, $07A0
		DMANOSR	$01C0, $09A0
		DMANOSR	$01C0, $0BA0
		dc.w	$0000

MSS_SD_Scale2A:	DMARAW	$00C0, $02A0, MSS_Scalex2+(0*$7C0)
		dc.l	MSS_SD_Scale2
MSS_SD_Scale2B:	DMARAW	$00C0, $02A0, MSS_Scalex2+(1*$7C0)
		dc.l	MSS_SD_Scale2
MSS_SD_Scale2C:	DMARAW	$00C0, $02A0, MSS_Scalex2+(2*$7C0)
		dc.l	MSS_SD_Scale2
MSS_SD_Scale2D:	DMARAW	$00C0, $02A0, MSS_Scalex2+(3*$7C0)
		dc.l	MSS_SD_Scale2
MSS_SD_Scale2E:	DMARAW	$00C0, $02A0, MSS_Scalex2+(4*$7C0)
		dc.l	MSS_SD_Scale2
MSS_SD_Scale2F:	DMARAW	$00C0, $02A0, MSS_Scalex2+(5*$7C0)
		dc.l	MSS_SD_Scale2
MSS_SD_Scale2G:	DMARAW	$00C0, $02A0, MSS_Scalex2+(6*$7C0)
		dc.l	MSS_SD_Scale2
MSS_SD_Scale2H:	DMARAW	$00C0, $02A0, MSS_Scalex2+(7*$7C0)
		dc.l	MSS_SD_Scale2

MSS_SD_Scale2:	DMANOSR	$0140, $0400
		DMANOSR	$0140, $05E0
		DMANOSR	$0180, $07C0
		DMANOSR	$0180, $09C0
		DMANOSR	$0180, $0BC0
		dc.w	$0000

MSS_SD_Scale1A:	DMARAW	$00C0, $0440, MSS_Scalex1+(0*$580)
		dc.l	MSS_SD_Scale1
MSS_SD_Scale1B:	DMARAW	$00C0, $0440, MSS_Scalex1+(1*$580)
		dc.l	MSS_SD_Scale1
MSS_SD_Scale1C:	DMARAW	$00C0, $0440, MSS_Scalex1+(2*$580)
		dc.l	MSS_SD_Scale1
MSS_SD_Scale1D:	DMARAW	$00C0, $0440, MSS_Scalex1+(3*$580)
		dc.l	MSS_SD_Scale1
MSS_SD_Scale1E:	DMARAW	$00C0, $0440, MSS_Scalex1+(4*$580)
		dc.l	MSS_SD_Scale1
MSS_SD_Scale1F:	DMARAW	$00C0, $0440, MSS_Scalex1+(5*$580)
		dc.l	MSS_SD_Scale1
MSS_SD_Scale1G:	DMARAW	$00C0, $0440, MSS_Scalex1+(6*$580)
		dc.l	MSS_SD_Scale1
MSS_SD_Scale1H:	DMARAW	$00C0, $0440, MSS_Scalex1+(7*$580)
		dc.l	MSS_SD_Scale1

MSS_SD_Scale1:	DMANOSR	$0100, $0600
		DMANOSR	$0140, $07E0
		DMANOSR	$0140, $09E0
		DMANOSR	$0140, $0BE0
		dc.w	$0000

; ===========================================================================
; ---------------------------------------------------------------------------
; Sprites for scaleable planet's shine and shadow
; ---------------------------------------------------------------------------

MSS_SpriteShine:
		dc.l	MSS_SS_Scale00			; Largest
		dc.l	MSS_SS_Scale01
		dc.l	MSS_SS_Scale02
		dc.l	MSS_SS_Scale03
		dc.l	MSS_SS_Scale04
		dc.l	MSS_SS_Scale05
		dc.l	MSS_SS_Scale06
		dc.l	MSS_SS_Scale07
		dc.l	MSS_SS_Scale08
		dc.l	MSS_SS_Scale09
		dc.l	MSS_SS_Scale0A
		dc.l	MSS_SS_Scale0B
		dc.l	MSS_SS_Scale0C
		dc.l	MSS_SS_Scale0D
		dc.l	MSS_SS_Scale0E
		dc.l	MSS_SS_Scale0F
		dc.l	MSS_SS_Scale10
		dc.l	MSS_SS_Scale11
		dc.l	MSS_SS_Scale12
		dc.l	MSS_SS_Scale13
		dc.l	MSS_SS_Scale14
		dc.l	MSS_SS_Scale15
		dc.l	MSS_SS_Scale16
		dc.l	MSS_SS_Scale17
		dc.l	MSS_SS_Scale18
		dc.l	MSS_SS_Scale19
		dc.l	MSS_SS_Scale1A
		dc.l	MSS_SS_Scale1B
		dc.l	MSS_SS_Scale1C
		dc.l	MSS_SS_Scale1D
		dc.l	MSS_SS_Scale1E
		dc.l	MSS_SS_Scale1F			; Smallest

MSS_SS_Scale00:	dc.w	$0016-1
		dc.w	$FFC4,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFCC,$0302+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$FFDC,$0103+4,($E010+(EMS_SCALESHVRAM/$20)),$FFD9
		dc.w	$FFE4,$0B04+4,($E012+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFEC,$0105+4,($E01E+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$FFFC,$0306+4,($E020+(EMS_SCALESHVRAM/$20)),$FFC1
		dc.w	$0014,$0507+4,($E024+(EMS_SCALESHVRAM/$20)),$FFC9
		dc.w	$001C,$0608+4,($E028+(EMS_SCALESHVRAM/$20)),$FFD9
		dc.w	$0024,$0009+4,($E02E+(EMS_SCALESHVRAM/$20)),$FFD1
		dc.w	$0024,$0A0A+4,($E02F+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$0034,$000B+4,($E038+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$FFC4,$0B0C+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFCC,$030D+4,($E80C+(EMS_SCALESHVRAM/$20)),$0017
		dc.w	$FFDC,$010E+4,($E810+(EMS_SCALESHVRAM/$20)),$001F
		dc.w	$FFE4,$0B0F+4,($E812+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFEC,$0110+4,($E81E+(EMS_SCALESHVRAM/$20)),$0017
		dc.w	$FFFC,$0311+4,($E820+(EMS_SCALESHVRAM/$20)),$0037
		dc.w	$0014,$0512+4,($E824+(EMS_SCALESHVRAM/$20)),$0027
		dc.w	$001C,$0613+4,($E828+(EMS_SCALESHVRAM/$20)),$0017
		dc.w	$0024,$0014+4,($E82E+(EMS_SCALESHVRAM/$20)),$0027
		dc.w	$0024,$0A15+4,($E82F+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$0034,$0016+4,($E838+(EMS_SCALESHVRAM/$20)),$0017

MSS_SS_Scale01:	dc.w	$0014-1
		dc.w	$FFC4,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFCC,$0302+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$FFE4,$0B03+4,($E010+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFEC,$0104+4,($E01C+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$FFFC,$0305+4,($E01E+(EMS_SCALESHVRAM/$20)),$FFC1
		dc.w	$000C,$0206+4,($E022+(EMS_SCALESHVRAM/$20)),$FFC9
		dc.w	$0014,$0207+4,($E025+(EMS_SCALESHVRAM/$20)),$FFD1
		dc.w	$001C,$0608+4,($E028+(EMS_SCALESHVRAM/$20)),$FFD9
		dc.w	$0024,$0A09+4,($E02E+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$0034,$000A+4,($E037+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$FFC4,$0B0B+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFCC,$030C+4,($E80C+(EMS_SCALESHVRAM/$20)),$0017
		dc.w	$FFE4,$0B0D+4,($E810+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFEC,$010E+4,($E81C+(EMS_SCALESHVRAM/$20)),$0017
		dc.w	$FFFC,$030F+4,($E81E+(EMS_SCALESHVRAM/$20)),$0037
		dc.w	$000C,$0210+4,($E822+(EMS_SCALESHVRAM/$20)),$002F
		dc.w	$0014,$0211+4,($E825+(EMS_SCALESHVRAM/$20)),$0027
		dc.w	$001C,$0612+4,($E828+(EMS_SCALESHVRAM/$20)),$0017
		dc.w	$0024,$0A13+4,($E82E+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$0034,$0014+4,($E837+(EMS_SCALESHVRAM/$20)),$0017

MSS_SS_Scale02:	dc.w	$0016-1
		dc.w	$FFC4,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFCC,$0302+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE2
		dc.w	$FFDC,$0103+4,($E010+(EMS_SCALESHVRAM/$20)),$FFDA
		dc.w	$FFE4,$0B04+4,($E012+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFEC,$0105+4,($E01E+(EMS_SCALESHVRAM/$20)),$FFE2
		dc.w	$FFFC,$0306+4,($E020+(EMS_SCALESHVRAM/$20)),$FFC2
		dc.w	$000C,$0207+4,($E024+(EMS_SCALESHVRAM/$20)),$FFCA
		dc.w	$0014,$0608+4,($E027+(EMS_SCALESHVRAM/$20)),$FFD2
		dc.w	$001C,$0209+4,($E02D+(EMS_SCALESHVRAM/$20)),$FFE2
		dc.w	$0024,$0A0A+4,($E030+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$002C,$000B+4,($E039+(EMS_SCALESHVRAM/$20)),$FFDA
		dc.w	$FFC4,$0B0C+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$FFCC,$030D+4,($E80C+(EMS_SCALESHVRAM/$20)),$0016
		dc.w	$FFDC,$010E+4,($E810+(EMS_SCALESHVRAM/$20)),$001E
		dc.w	$FFE4,$0B0F+4,($E812+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$FFEC,$0110+4,($E81E+(EMS_SCALESHVRAM/$20)),$0016
		dc.w	$FFFC,$0311+4,($E820+(EMS_SCALESHVRAM/$20)),$0036
		dc.w	$000C,$0212+4,($E824+(EMS_SCALESHVRAM/$20)),$002E
		dc.w	$0014,$0613+4,($E827+(EMS_SCALESHVRAM/$20)),$001E
		dc.w	$001C,$0214+4,($E82D+(EMS_SCALESHVRAM/$20)),$0016
		dc.w	$0024,$0A15+4,($E830+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$002C,$0016+4,($E839+(EMS_SCALESHVRAM/$20)),$001E

MSS_SS_Scale03:	dc.w	$0014-1
		dc.w	$FFC4,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFCC,$0302+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE2
		dc.w	$FFE4,$0B03+4,($E010+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFEC,$0104+4,($E01C+(EMS_SCALESHVRAM/$20)),$FFE2
		dc.w	$FFFC,$0205+4,($E01E+(EMS_SCALESHVRAM/$20)),$FFC2
		dc.w	$000C,$0206+4,($E021+(EMS_SCALESHVRAM/$20)),$FFCA
		dc.w	$0014,$0607+4,($E024+(EMS_SCALESHVRAM/$20)),$FFD2
		dc.w	$001C,$0208+4,($E02A+(EMS_SCALESHVRAM/$20)),$FFE2
		dc.w	$0024,$0A09+4,($E02D+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$002C,$000A+4,($E036+(EMS_SCALESHVRAM/$20)),$FFDA
		dc.w	$FFC4,$0B0B+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$FFCC,$030C+4,($E80C+(EMS_SCALESHVRAM/$20)),$0016
		dc.w	$FFE4,$0B0D+4,($E810+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$FFEC,$010E+4,($E81C+(EMS_SCALESHVRAM/$20)),$0016
		dc.w	$FFFC,$020F+4,($E81E+(EMS_SCALESHVRAM/$20)),$0036
		dc.w	$000C,$0210+4,($E821+(EMS_SCALESHVRAM/$20)),$002E
		dc.w	$0014,$0611+4,($E824+(EMS_SCALESHVRAM/$20)),$001E
		dc.w	$001C,$0212+4,($E82A+(EMS_SCALESHVRAM/$20)),$0016
		dc.w	$0024,$0A13+4,($E82D+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$002C,$0014+4,($E836+(EMS_SCALESHVRAM/$20)),$001E

MSS_SS_Scale04:	dc.w	$0016-1
		dc.w	$FFC8,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$FFD0,$0302+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE3
		dc.w	$FFE0,$0103+4,($E010+(EMS_SCALESHVRAM/$20)),$FFDB
		dc.w	$FFE8,$0A04+4,($E012+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$FFF0,$0105+4,($E01B+(EMS_SCALESHVRAM/$20)),$FFE3
		dc.w	$FFF8,$0306+4,($E01D+(EMS_SCALESHVRAM/$20)),$FFC3
		dc.w	$0000,$0407+4,($E021+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$0008,$0308+4,($E023+(EMS_SCALESHVRAM/$20)),$FFCB
		dc.w	$0010,$0309+4,($E027+(EMS_SCALESHVRAM/$20)),$FFD3
		dc.w	$0018,$020A+4,($E02B+(EMS_SCALESHVRAM/$20)),$FFDB
		dc.w	$0020,$0E0B+4,($E02E+(EMS_SCALESHVRAM/$20)),$FFE3
		dc.w	$FFC8,$0B0C+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$FFD0,$030D+4,($E80C+(EMS_SCALESHVRAM/$20)),$0015
		dc.w	$FFE0,$010E+4,($E810+(EMS_SCALESHVRAM/$20)),$001D
		dc.w	$FFE8,$0A0F+4,($E812+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$FFF0,$0110+4,($E81B+(EMS_SCALESHVRAM/$20)),$0015
		dc.w	$FFF8,$0311+4,($E81D+(EMS_SCALESHVRAM/$20)),$0035
		dc.w	$0000,$0412+4,($E821+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$0008,$0313+4,($E823+(EMS_SCALESHVRAM/$20)),$002D
		dc.w	$0010,$0314+4,($E827+(EMS_SCALESHVRAM/$20)),$0025
		dc.w	$0018,$0215+4,($E82B+(EMS_SCALESHVRAM/$20)),$001D
		dc.w	$0020,$0E16+4,($E82E+(EMS_SCALESHVRAM/$20)),$FFFD

MSS_SS_Scale05:	dc.w	$0014-1
		dc.w	$FFC8,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$FFD0,$0302+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE3
		dc.w	$FFE8,$0A03+4,($E010+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$FFF0,$0104+4,($E019+(EMS_SCALESHVRAM/$20)),$FFE3
		dc.w	$FFF8,$0305+4,($E01B+(EMS_SCALESHVRAM/$20)),$FFC3
		dc.w	$0000,$0406+4,($E01F+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$0008,$0207+4,($E021+(EMS_SCALESHVRAM/$20)),$FFCB
		dc.w	$0010,$0208+4,($E024+(EMS_SCALESHVRAM/$20)),$FFD3
		dc.w	$0018,$0209+4,($E027+(EMS_SCALESHVRAM/$20)),$FFDB
		dc.w	$0020,$0E0A+4,($E02A+(EMS_SCALESHVRAM/$20)),$FFE3
		dc.w	$FFC8,$0B0B+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$FFD0,$030C+4,($E80C+(EMS_SCALESHVRAM/$20)),$0015
		dc.w	$FFE8,$0A0D+4,($E810+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$FFF0,$010E+4,($E819+(EMS_SCALESHVRAM/$20)),$0015
		dc.w	$FFF8,$030F+4,($E81B+(EMS_SCALESHVRAM/$20)),$0035
		dc.w	$0000,$0410+4,($E81F+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$0008,$0211+4,($E821+(EMS_SCALESHVRAM/$20)),$002D
		dc.w	$0010,$0212+4,($E824+(EMS_SCALESHVRAM/$20)),$0025
		dc.w	$0018,$0213+4,($E827+(EMS_SCALESHVRAM/$20)),$001D
		dc.w	$0020,$0E14+4,($E82A+(EMS_SCALESHVRAM/$20)),$FFFD

MSS_SS_Scale06:	dc.w	$0016-1
		dc.w	$FFC8,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFEC
		dc.w	$FFD0,$0302+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE4
		dc.w	$FFE0,$0103+4,($E010+(EMS_SCALESHVRAM/$20)),$FFDC
		dc.w	$FFE8,$0A04+4,($E012+(EMS_SCALESHVRAM/$20)),$FFEC
		dc.w	$FFF0,$0105+4,($E01B+(EMS_SCALESHVRAM/$20)),$FFE4
		dc.w	$FFF8,$0306+4,($E01D+(EMS_SCALESHVRAM/$20)),$FFC4
		dc.w	$0000,$0407+4,($E021+(EMS_SCALESHVRAM/$20)),$FFF4
		dc.w	$0008,$0208+4,($E023+(EMS_SCALESHVRAM/$20)),$FFCC
		dc.w	$0010,$0209+4,($E026+(EMS_SCALESHVRAM/$20)),$FFD4
		dc.w	$0018,$020A+4,($E029+(EMS_SCALESHVRAM/$20)),$FFDC
		dc.w	$0020,$0E0B+4,($E02C+(EMS_SCALESHVRAM/$20)),$FFE4
		dc.w	$FFC8,$0B0C+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFC
		dc.w	$FFD0,$030D+4,($E80C+(EMS_SCALESHVRAM/$20)),$0014
		dc.w	$FFE0,$010E+4,($E810+(EMS_SCALESHVRAM/$20)),$001C
		dc.w	$FFE8,$0A0F+4,($E812+(EMS_SCALESHVRAM/$20)),$FFFC
		dc.w	$FFF0,$0110+4,($E81B+(EMS_SCALESHVRAM/$20)),$0014
		dc.w	$FFF8,$0311+4,($E81D+(EMS_SCALESHVRAM/$20)),$0034
		dc.w	$0000,$0412+4,($E821+(EMS_SCALESHVRAM/$20)),$FFFC
		dc.w	$0008,$0213+4,($E823+(EMS_SCALESHVRAM/$20)),$002C
		dc.w	$0010,$0214+4,($E826+(EMS_SCALESHVRAM/$20)),$0024
		dc.w	$0018,$0215+4,($E829+(EMS_SCALESHVRAM/$20)),$001C
		dc.w	$0020,$0E16+4,($E82C+(EMS_SCALESHVRAM/$20)),$FFFC

MSS_SS_Scale07:	dc.w	$0014-1
		dc.w	$FFC8,$0701+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF0
		dc.w	$FFD0,$0302+4,($E008+(EMS_SCALESHVRAM/$20)),$FFE8
		dc.w	$FFD8,$0303+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE0
		dc.w	$FFE8,$0704+4,($E010+(EMS_SCALESHVRAM/$20)),$FFF0
		dc.w	$FFF0,$0105+4,($E018+(EMS_SCALESHVRAM/$20)),$FFE8
		dc.w	$FFF8,$0306+4,($E01A+(EMS_SCALESHVRAM/$20)),$FFC8
		dc.w	$0010,$0607+4,($E01E+(EMS_SCALESHVRAM/$20)),$FFD0
		dc.w	$0018,$0208+4,($E024+(EMS_SCALESHVRAM/$20)),$FFE0
		dc.w	$0020,$0A09+4,($E027+(EMS_SCALESHVRAM/$20)),$FFE8
		dc.w	$0028,$000A+4,($E030+(EMS_SCALESHVRAM/$20)),$FFD8
		dc.w	$FFC8,$070B+4,($E800+(EMS_SCALESHVRAM/$20)),$0000
		dc.w	$FFD0,$030C+4,($E808+(EMS_SCALESHVRAM/$20)),$0010
		dc.w	$FFD8,$030D+4,($E80C+(EMS_SCALESHVRAM/$20)),$0018
		dc.w	$FFE8,$070E+4,($E810+(EMS_SCALESHVRAM/$20)),$0000
		dc.w	$FFF0,$010F+4,($E818+(EMS_SCALESHVRAM/$20)),$0010
		dc.w	$FFF8,$0310+4,($E81A+(EMS_SCALESHVRAM/$20)),$0030
		dc.w	$0010,$0611+4,($E81E+(EMS_SCALESHVRAM/$20)),$0020
		dc.w	$0018,$0212+4,($E824+(EMS_SCALESHVRAM/$20)),$0018
		dc.w	$0020,$0A13+4,($E827+(EMS_SCALESHVRAM/$20)),$0000
		dc.w	$0028,$0014+4,($E830+(EMS_SCALESHVRAM/$20)),$0020

MSS_SS_Scale08:	dc.w	$0014-1
		dc.w	$FFCC,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFD4,$0302+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$FFEC,$0A03+4,($E010+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFF4,$0004+4,($E019+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$FFFC,$0305+4,($E01A+(EMS_SCALESHVRAM/$20)),$FFC9
		dc.w	$000C,$0206+4,($E01E+(EMS_SCALESHVRAM/$20)),$FFD1
		dc.w	$0014,$0207+4,($E021+(EMS_SCALESHVRAM/$20)),$FFD9
		dc.w	$001C,$0608+4,($E024+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$001C,$0209+4,($E02A+(EMS_SCALESHVRAM/$20)),$FFF9
		dc.w	$0024,$010A+4,($E02D+(EMS_SCALESHVRAM/$20)),$FFF1
		dc.w	$FFCC,$0B0B+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFD4,$030C+4,($E80C+(EMS_SCALESHVRAM/$20)),$0017
		dc.w	$FFEC,$0A0D+4,($E810+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFF4,$000E+4,($E819+(EMS_SCALESHVRAM/$20)),$0017
		dc.w	$FFFC,$030F+4,($E81A+(EMS_SCALESHVRAM/$20)),$002F
		dc.w	$000C,$0210+4,($E81E+(EMS_SCALESHVRAM/$20)),$0027
		dc.w	$0014,$0211+4,($E821+(EMS_SCALESHVRAM/$20)),$001F
		dc.w	$001C,$0612+4,($E824+(EMS_SCALESHVRAM/$20)),$000F
		dc.w	$001C,$0213+4,($E82A+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$0024,$0114+4,($E82D+(EMS_SCALESHVRAM/$20)),$0007

MSS_SS_Scale09:	dc.w	$0012-1
		dc.w	$FFCC,$0701+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF1
		dc.w	$FFD4,$0702+4,($E008+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$FFEC,$0603+4,($E010+(EMS_SCALESHVRAM/$20)),$FFF1
		dc.w	$FFF4,$0404+4,($E016+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$FFFC,$0205+4,($E018+(EMS_SCALESHVRAM/$20)),$FFC9
		dc.w	$FFFC,$0006+4,($E01B+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$000C,$0207+4,($E01C+(EMS_SCALESHVRAM/$20)),$FFD1
		dc.w	$0014,$0608+4,($E01F+(EMS_SCALESHVRAM/$20)),$FFD9
		dc.w	$001C,$0A09+4,($E025+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFCC,$070A+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFD4,$070B+4,($E808+(EMS_SCALESHVRAM/$20)),$000F
		dc.w	$FFEC,$060C+4,($E810+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFF4,$040D+4,($E816+(EMS_SCALESHVRAM/$20)),$000F
		dc.w	$FFFC,$020E+4,($E818+(EMS_SCALESHVRAM/$20)),$002F
		dc.w	$FFFC,$000F+4,($E81B+(EMS_SCALESHVRAM/$20)),$000F
		dc.w	$000C,$0210+4,($E81C+(EMS_SCALESHVRAM/$20)),$0027
		dc.w	$0014,$0611+4,($E81F+(EMS_SCALESHVRAM/$20)),$0017
		dc.w	$001C,$0A12+4,($E825+(EMS_SCALESHVRAM/$20)),$FFFF

MSS_SS_Scale0A:	dc.w	$0010-1
		dc.w	$FFCC,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFD4,$0302+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE2
		dc.w	$FFEC,$0A03+4,($E010+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFFC,$0204+4,($E019+(EMS_SCALESHVRAM/$20)),$FFCA
		dc.w	$000C,$0205+4,($E01C+(EMS_SCALESHVRAM/$20)),$FFD2
		dc.w	$0014,$0206+4,($E01F+(EMS_SCALESHVRAM/$20)),$FFDA
		dc.w	$001C,$0D07+4,($E022+(EMS_SCALESHVRAM/$20)),$FFE2
		dc.w	$002C,$0808+4,($E02A+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFCC,$0B09+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$FFD4,$030A+4,($E80C+(EMS_SCALESHVRAM/$20)),$0016
		dc.w	$FFEC,$0A0B+4,($E810+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$FFFC,$020C+4,($E819+(EMS_SCALESHVRAM/$20)),$002E
		dc.w	$000C,$020D+4,($E81C+(EMS_SCALESHVRAM/$20)),$0026
		dc.w	$0014,$020E+4,($E81F+(EMS_SCALESHVRAM/$20)),$001E
		dc.w	$001C,$0D0F+4,($E822+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$002C,$0810+4,($E82A+(EMS_SCALESHVRAM/$20)),$FFFE

MSS_SS_Scale0B:	dc.w	$0014-1
		dc.w	$FFCC,$0701+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF2
		dc.w	$FFD4,$0302+4,($E008+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFDC,$0203+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE2
		dc.w	$FFEC,$0604+4,($E00F+(EMS_SCALESHVRAM/$20)),$FFF2
		dc.w	$FFF4,$0105+4,($E015+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFFC,$0206+4,($E017+(EMS_SCALESHVRAM/$20)),$FFCA
		dc.w	$000C,$0207+4,($E01A+(EMS_SCALESHVRAM/$20)),$FFD2
		dc.w	$0014,$0208+4,($E01D+(EMS_SCALESHVRAM/$20)),$FFDA
		dc.w	$001C,$0D09+4,($E020+(EMS_SCALESHVRAM/$20)),$FFE2
		dc.w	$002C,$080A+4,($E028+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFCC,$070B+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$FFD4,$030C+4,($E808+(EMS_SCALESHVRAM/$20)),$000E
		dc.w	$FFDC,$020D+4,($E80C+(EMS_SCALESHVRAM/$20)),$0016
		dc.w	$FFEC,$060E+4,($E80F+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$FFF4,$010F+4,($E815+(EMS_SCALESHVRAM/$20)),$000E
		dc.w	$FFFC,$0210+4,($E817+(EMS_SCALESHVRAM/$20)),$002E
		dc.w	$000C,$0211+4,($E81A+(EMS_SCALESHVRAM/$20)),$0026
		dc.w	$0014,$0212+4,($E81D+(EMS_SCALESHVRAM/$20)),$001E
		dc.w	$001C,$0D13+4,($E820+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$002C,$0814+4,($E828+(EMS_SCALESHVRAM/$20)),$FFFE

MSS_SS_Scale0C:	dc.w	$0012-1
		dc.w	$FFD0,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$FFE0,$0202+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE3
		dc.w	$FFF0,$0903+4,($E00F+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$FFF8,$0304+4,($E015+(EMS_SCALESHVRAM/$20)),$FFCB
		dc.w	$0000,$0405+4,($E019+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$0010,$0506+4,($E01B+(EMS_SCALESHVRAM/$20)),$FFD3
		dc.w	$0018,$0607+4,($E01F+(EMS_SCALESHVRAM/$20)),$FFE3
		dc.w	$0020,$0008+4,($E025+(EMS_SCALESHVRAM/$20)),$FFDB
		dc.w	$0020,$0509+4,($E026+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$FFD0,$0B0A+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$FFE0,$020B+4,($E80C+(EMS_SCALESHVRAM/$20)),$0015
		dc.w	$FFF0,$090C+4,($E80F+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$FFF8,$030D+4,($E815+(EMS_SCALESHVRAM/$20)),$002D
		dc.w	$0000,$040E+4,($E819+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$0010,$050F+4,($E81B+(EMS_SCALESHVRAM/$20)),$001D
		dc.w	$0018,$0610+4,($E81F+(EMS_SCALESHVRAM/$20)),$000D
		dc.w	$0020,$0011+4,($E825+(EMS_SCALESHVRAM/$20)),$001D
		dc.w	$0020,$0512+4,($E826+(EMS_SCALESHVRAM/$20)),$FFFD

MSS_SS_Scale0D:	dc.w	$0012-1
		dc.w	$FFD0,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$FFD8,$0302+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE3
		dc.w	$FFF0,$0903+4,($E010+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$FFF8,$0304+4,($E016+(EMS_SCALESHVRAM/$20)),$FFCB
		dc.w	$0000,$0405+4,($E01A+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$0008,$0206+4,($E01C+(EMS_SCALESHVRAM/$20)),$FFD3
		dc.w	$0010,$0207+4,($E01F+(EMS_SCALESHVRAM/$20)),$FFDB
		dc.w	$0018,$0608+4,($E022+(EMS_SCALESHVRAM/$20)),$FFE3
		dc.w	$0020,$0509+4,($E028+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$FFD0,$0B0A+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$FFD8,$030B+4,($E80C+(EMS_SCALESHVRAM/$20)),$0015
		dc.w	$FFF0,$090C+4,($E810+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$FFF8,$030D+4,($E816+(EMS_SCALESHVRAM/$20)),$002D
		dc.w	$0000,$040E+4,($E81A+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$0008,$020F+4,($E81C+(EMS_SCALESHVRAM/$20)),$0025
		dc.w	$0010,$0210+4,($E81F+(EMS_SCALESHVRAM/$20)),$001D
		dc.w	$0018,$0611+4,($E822+(EMS_SCALESHVRAM/$20)),$000D
		dc.w	$0020,$0512+4,($E828+(EMS_SCALESHVRAM/$20)),$FFFD

MSS_SS_Scale0E:	dc.w	$0014-1
		dc.w	$FFD0,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFEC
		dc.w	$FFE0,$0202+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE4
		dc.w	$FFF0,$0903+4,($E00F+(EMS_SCALESHVRAM/$20)),$FFEC
		dc.w	$FFF8,$0304+4,($E015+(EMS_SCALESHVRAM/$20)),$FFCC
		dc.w	$0000,$0405+4,($E019+(EMS_SCALESHVRAM/$20)),$FFF4
		dc.w	$0008,$0206+4,($E01B+(EMS_SCALESHVRAM/$20)),$FFD4
		dc.w	$0010,$0207+4,($E01E+(EMS_SCALESHVRAM/$20)),$FFDC
		dc.w	$0018,$0608+4,($E021+(EMS_SCALESHVRAM/$20)),$FFE4
		dc.w	$0018,$0209+4,($E027+(EMS_SCALESHVRAM/$20)),$FFFC
		dc.w	$0020,$010A+4,($E02A+(EMS_SCALESHVRAM/$20)),$FFF4
		dc.w	$FFD0,$0B0B+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFC
		dc.w	$FFE0,$020C+4,($E80C+(EMS_SCALESHVRAM/$20)),$0014
		dc.w	$FFF0,$090D+4,($E80F+(EMS_SCALESHVRAM/$20)),$FFFC
		dc.w	$FFF8,$030E+4,($E815+(EMS_SCALESHVRAM/$20)),$002C
		dc.w	$0000,$040F+4,($E819+(EMS_SCALESHVRAM/$20)),$FFFC
		dc.w	$0008,$0210+4,($E81B+(EMS_SCALESHVRAM/$20)),$0024
		dc.w	$0010,$0211+4,($E81E+(EMS_SCALESHVRAM/$20)),$001C
		dc.w	$0018,$0612+4,($E821+(EMS_SCALESHVRAM/$20)),$000C
		dc.w	$0018,$0213+4,($E827+(EMS_SCALESHVRAM/$20)),$FFFC
		dc.w	$0020,$0114+4,($E82A+(EMS_SCALESHVRAM/$20)),$0004

MSS_SS_Scale0F:	dc.w	$0012-1
		dc.w	$FFD0,$0701+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF0
		dc.w	$FFD8,$0302+4,($E008+(EMS_SCALESHVRAM/$20)),$FFE8
		dc.w	$FFF0,$0603+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFF0
		dc.w	$FFF8,$0304+4,($E012+(EMS_SCALESHVRAM/$20)),$FFD0
		dc.w	$FFF8,$0005+4,($E016+(EMS_SCALESHVRAM/$20)),$FFE8
		dc.w	$0010,$0106+4,($E017+(EMS_SCALESHVRAM/$20)),$FFD8
		dc.w	$0018,$0907+4,($E019+(EMS_SCALESHVRAM/$20)),$FFE0
		dc.w	$0020,$0108+4,($E01F+(EMS_SCALESHVRAM/$20)),$FFF8
		dc.w	$0028,$0409+4,($E021+(EMS_SCALESHVRAM/$20)),$FFE8
		dc.w	$FFD0,$070A+4,($E800+(EMS_SCALESHVRAM/$20)),$0000
		dc.w	$FFD8,$030B+4,($E808+(EMS_SCALESHVRAM/$20)),$0010
		dc.w	$FFF0,$060C+4,($E80C+(EMS_SCALESHVRAM/$20)),$0000
		dc.w	$FFF8,$030D+4,($E812+(EMS_SCALESHVRAM/$20)),$0028
		dc.w	$FFF8,$000E+4,($E816+(EMS_SCALESHVRAM/$20)),$0010
		dc.w	$0010,$010F+4,($E817+(EMS_SCALESHVRAM/$20)),$0020
		dc.w	$0018,$0910+4,($E819+(EMS_SCALESHVRAM/$20)),$0008
		dc.w	$0020,$0111+4,($E81F+(EMS_SCALESHVRAM/$20)),$0000
		dc.w	$0028,$0412+4,($E821+(EMS_SCALESHVRAM/$20)),$0008

MSS_SS_Scale10:	dc.w	$000E-1
		dc.w	$FFD4,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFE4,$0102+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$FFF4,$0903+4,($E00E+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFFC,$0304+4,($E014+(EMS_SCALESHVRAM/$20)),$FFD1
		dc.w	$000C,$0205+4,($E018+(EMS_SCALESHVRAM/$20)),$FFD9
		dc.w	$0014,$0206+4,($E01B+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$001C,$0907+4,($E01E+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFD4,$0B08+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFE4,$0109+4,($E80C+(EMS_SCALESHVRAM/$20)),$0017
		dc.w	$FFF4,$090A+4,($E80E+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFFC,$030B+4,($E814+(EMS_SCALESHVRAM/$20)),$0027
		dc.w	$000C,$020C+4,($E818+(EMS_SCALESHVRAM/$20)),$001F
		dc.w	$0014,$020D+4,($E81B+(EMS_SCALESHVRAM/$20)),$0017
		dc.w	$001C,$090E+4,($E81E+(EMS_SCALESHVRAM/$20)),$FFFF

MSS_SS_Scale11:	dc.w	$000E-1
		dc.w	$FFD4,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFF4,$0802+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFFC,$0203+4,($E00F+(EMS_SCALESHVRAM/$20)),$FFD1
		dc.w	$FFFC,$0404+4,($E012+(EMS_SCALESHVRAM/$20)),$FFF1
		dc.w	$000C,$0605+4,($E014+(EMS_SCALESHVRAM/$20)),$FFD9
		dc.w	$0014,$0206+4,($E01A+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$001C,$0507+4,($E01D+(EMS_SCALESHVRAM/$20)),$FFF1
		dc.w	$FFD4,$0B08+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFF4,$0809+4,($E80C+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFFC,$020A+4,($E80F+(EMS_SCALESHVRAM/$20)),$0027
		dc.w	$FFFC,$040B+4,($E812+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$000C,$060C+4,($E814+(EMS_SCALESHVRAM/$20)),$0017
		dc.w	$0014,$020D+4,($E81A+(EMS_SCALESHVRAM/$20)),$000F
		dc.w	$001C,$050E+4,($E81D+(EMS_SCALESHVRAM/$20)),$FFFF

MSS_SS_Scale12:	dc.w	$000E-1
		dc.w	$FFD4,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFF4,$0802+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFFC,$0203+4,($E00F+(EMS_SCALESHVRAM/$20)),$FFD1
		dc.w	$FFFC,$0404+4,($E012+(EMS_SCALESHVRAM/$20)),$FFF1
		dc.w	$000C,$0605+4,($E014+(EMS_SCALESHVRAM/$20)),$FFD9
		dc.w	$0014,$0606+4,($E01A+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$001C,$0107+4,($E020+(EMS_SCALESHVRAM/$20)),$FFF9
		dc.w	$FFD4,$0B08+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFF4,$0809+4,($E80C+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFFC,$020A+4,($E80F+(EMS_SCALESHVRAM/$20)),$0027
		dc.w	$FFFC,$040B+4,($E812+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$000C,$060C+4,($E814+(EMS_SCALESHVRAM/$20)),$0017
		dc.w	$0014,$060D+4,($E81A+(EMS_SCALESHVRAM/$20)),$0007
		dc.w	$001C,$010E+4,($E820+(EMS_SCALESHVRAM/$20)),$FFFF

MSS_SS_Scale13:	dc.w	$0010-1
		dc.w	$FFD4,$0701+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF2
		dc.w	$FFDC,$0302+4,($E008+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFF4,$0503+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFF2
		dc.w	$FFFC,$0204+4,($E010+(EMS_SCALESHVRAM/$20)),$FFD2
		dc.w	$FFFC,$0005+4,($E013+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$000C,$0606+4,($E014+(EMS_SCALESHVRAM/$20)),$FFDA
		dc.w	$0014,$0607+4,($E01A+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$001C,$0108+4,($E020+(EMS_SCALESHVRAM/$20)),$FFFA
		dc.w	$FFD4,$0709+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$FFDC,$030A+4,($E808+(EMS_SCALESHVRAM/$20)),$000E
		dc.w	$FFF4,$050B+4,($E80C+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$FFFC,$020C+4,($E810+(EMS_SCALESHVRAM/$20)),$0026
		dc.w	$FFFC,$000D+4,($E813+(EMS_SCALESHVRAM/$20)),$000E
		dc.w	$000C,$060E+4,($E814+(EMS_SCALESHVRAM/$20)),$0016
		dc.w	$0014,$060F+4,($E81A+(EMS_SCALESHVRAM/$20)),$0006
		dc.w	$001C,$0110+4,($E820+(EMS_SCALESHVRAM/$20)),$FFFE

MSS_SS_Scale14:	dc.w	$0010-1
		dc.w	$FFD4,$0701+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$FFDC,$0302+4,($E008+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$FFF4,$0503+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$FFFC,$0204+4,($E010+(EMS_SCALESHVRAM/$20)),$FFD3
		dc.w	$FFFC,$0005+4,($E013+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$000C,$0606+4,($E014+(EMS_SCALESHVRAM/$20)),$FFDB
		dc.w	$0014,$0207+4,($E01A+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$001C,$0508+4,($E01D+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$FFD4,$0709+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$FFDC,$030A+4,($E808+(EMS_SCALESHVRAM/$20)),$000D
		dc.w	$FFF4,$050B+4,($E80C+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$FFFC,$020C+4,($E810+(EMS_SCALESHVRAM/$20)),$0025
		dc.w	$FFFC,$000D+4,($E813+(EMS_SCALESHVRAM/$20)),$000D
		dc.w	$000C,$060E+4,($E814+(EMS_SCALESHVRAM/$20)),$0015
		dc.w	$0014,$020F+4,($E81A+(EMS_SCALESHVRAM/$20)),$000D
		dc.w	$001C,$0510+4,($E81D+(EMS_SCALESHVRAM/$20)),$FFFD

MSS_SS_Scale15:	dc.w	$000E-1
		dc.w	$FFD8,$0701+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$FFE0,$0302+4,($E008+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$FFF8,$0203+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFD3
		dc.w	$FFF8,$0504+4,($E00F+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$0008,$0205+4,($E013+(EMS_SCALESHVRAM/$20)),$FFDB
		dc.w	$0010,$0606+4,($E016+(EMS_SCALESHVRAM/$20)),$FFE3
		dc.w	$0018,$0507+4,($E01C+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$FFD8,$0708+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$FFE0,$0309+4,($E808+(EMS_SCALESHVRAM/$20)),$000D
		dc.w	$FFF8,$020A+4,($E80C+(EMS_SCALESHVRAM/$20)),$0025
		dc.w	$FFF8,$050B+4,($E80F+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$0008,$020C+4,($E813+(EMS_SCALESHVRAM/$20)),$001D
		dc.w	$0010,$060D+4,($E816+(EMS_SCALESHVRAM/$20)),$000D
		dc.w	$0018,$050E+4,($E81C+(EMS_SCALESHVRAM/$20)),$FFFD

MSS_SS_Scale16:	dc.w	$000E-1
		dc.w	$FFD8,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFEC
		dc.w	$FFE8,$0102+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE4
		dc.w	$FFF8,$0203+4,($E00E+(EMS_SCALESHVRAM/$20)),$FFD4
		dc.w	$FFF8,$0804+4,($E011+(EMS_SCALESHVRAM/$20)),$FFEC
		dc.w	$0008,$0205+4,($E014+(EMS_SCALESHVRAM/$20)),$FFDC
		dc.w	$0010,$0106+4,($E017+(EMS_SCALESHVRAM/$20)),$FFE4
		dc.w	$0018,$0907+4,($E019+(EMS_SCALESHVRAM/$20)),$FFEC
		dc.w	$FFD8,$0B08+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFC
		dc.w	$FFE8,$0109+4,($E80C+(EMS_SCALESHVRAM/$20)),$0014
		dc.w	$FFF8,$020A+4,($E80E+(EMS_SCALESHVRAM/$20)),$0024
		dc.w	$FFF8,$080B+4,($E811+(EMS_SCALESHVRAM/$20)),$FFFC
		dc.w	$0008,$020C+4,($E814+(EMS_SCALESHVRAM/$20)),$001C
		dc.w	$0010,$010D+4,($E817+(EMS_SCALESHVRAM/$20)),$0014
		dc.w	$0018,$090E+4,($E819+(EMS_SCALESHVRAM/$20)),$FFFC

MSS_SS_Scale17:	dc.w	$000E-1
		dc.w	$FFD8,$0701+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF0
		dc.w	$FFE0,$0202+4,($E008+(EMS_SCALESHVRAM/$20)),$FFE8
		dc.w	$FFF8,$0303+4,($E00B+(EMS_SCALESHVRAM/$20)),$FFD8
		dc.w	$FFF8,$0404+4,($E00F+(EMS_SCALESHVRAM/$20)),$FFF0
		dc.w	$0008,$0205+4,($E011+(EMS_SCALESHVRAM/$20)),$FFE0
		dc.w	$0010,$0206+4,($E014+(EMS_SCALESHVRAM/$20)),$FFE8
		dc.w	$0018,$0507+4,($E017+(EMS_SCALESHVRAM/$20)),$FFF0
		dc.w	$FFD8,$0708+4,($E800+(EMS_SCALESHVRAM/$20)),$0000
		dc.w	$FFE0,$0209+4,($E808+(EMS_SCALESHVRAM/$20)),$0010
		dc.w	$FFF8,$030A+4,($E80B+(EMS_SCALESHVRAM/$20)),$0020
		dc.w	$FFF8,$040B+4,($E80F+(EMS_SCALESHVRAM/$20)),$0000
		dc.w	$0008,$020C+4,($E811+(EMS_SCALESHVRAM/$20)),$0018
		dc.w	$0010,$020D+4,($E814+(EMS_SCALESHVRAM/$20)),$0010
		dc.w	$0018,$050E+4,($E817+(EMS_SCALESHVRAM/$20)),$0000

MSS_SS_Scale18:	dc.w	$0010-1
		dc.w	$FFD8,$0701+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF1
		dc.w	$FFE0,$0302+4,($E008+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFF8,$0303+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFD9
		dc.w	$FFF8,$0404+4,($E010+(EMS_SCALESHVRAM/$20)),$FFF1
		dc.w	$0000,$0005+4,($E012+(EMS_SCALESHVRAM/$20)),$FFF9
		dc.w	$0008,$0206+4,($E013+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$0010,$0207+4,($E016+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$0018,$0508+4,($E019+(EMS_SCALESHVRAM/$20)),$FFF1
		dc.w	$FFD8,$0709+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFE0,$030A+4,($E808+(EMS_SCALESHVRAM/$20)),$000F
		dc.w	$FFF8,$030B+4,($E80C+(EMS_SCALESHVRAM/$20)),$001F
		dc.w	$FFF8,$040C+4,($E810+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$0000,$000D+4,($E812+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$0008,$020E+4,($E813+(EMS_SCALESHVRAM/$20)),$0017
		dc.w	$0010,$020F+4,($E816+(EMS_SCALESHVRAM/$20)),$000F
		dc.w	$0018,$0510+4,($E819+(EMS_SCALESHVRAM/$20)),$FFFF

MSS_SS_Scale19:	dc.w	$000E-1
		dc.w	$FFDC,$0701+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF1
		dc.w	$FFE4,$0202+4,($E008+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFFC,$0203+4,($E00B+(EMS_SCALESHVRAM/$20)),$FFD9
		dc.w	$FFFC,$0404+4,($E00E+(EMS_SCALESHVRAM/$20)),$FFF1
		dc.w	$000C,$0505+4,($E010+(EMS_SCALESHVRAM/$20)),$FFE1
		dc.w	$0014,$0506+4,($E014+(EMS_SCALESHVRAM/$20)),$FFF1
		dc.w	$001C,$0007+4,($E018+(EMS_SCALESHVRAM/$20)),$FFE9
		dc.w	$FFDC,$0708+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$FFE4,$0209+4,($E808+(EMS_SCALESHVRAM/$20)),$000F
		dc.w	$FFFC,$020A+4,($E80B+(EMS_SCALESHVRAM/$20)),$001F
		dc.w	$FFFC,$040B+4,($E80E+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$000C,$050C+4,($E810+(EMS_SCALESHVRAM/$20)),$000F
		dc.w	$0014,$050D+4,($E814+(EMS_SCALESHVRAM/$20)),$FFFF
		dc.w	$001C,$000E+4,($E818+(EMS_SCALESHVRAM/$20)),$000F

MSS_SS_Scale1A:	dc.w	$000C-1
		dc.w	$FFDC,$0701+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF2
		dc.w	$FFE4,$0202+4,($E008+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFFC,$0203+4,($E00B+(EMS_SCALESHVRAM/$20)),$FFDA
		dc.w	$FFFC,$0404+4,($E00E+(EMS_SCALESHVRAM/$20)),$FFF2
		dc.w	$000C,$0105+4,($E010+(EMS_SCALESHVRAM/$20)),$FFE2
		dc.w	$0014,$0906+4,($E012+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFDC,$0707+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$FFE4,$0208+4,($E808+(EMS_SCALESHVRAM/$20)),$000E
		dc.w	$FFFC,$0209+4,($E80B+(EMS_SCALESHVRAM/$20)),$001E
		dc.w	$FFFC,$040A+4,($E80E+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$000C,$010B+4,($E810+(EMS_SCALESHVRAM/$20)),$0016
		dc.w	$0014,$090C+4,($E812+(EMS_SCALESHVRAM/$20)),$FFFE

MSS_SS_Scale1B:	dc.w	$000C-1
		dc.w	$FFDC,$0701+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF2
		dc.w	$FFE4,$0202+4,($E008+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFFC,$0203+4,($E00B+(EMS_SCALESHVRAM/$20)),$FFDA
		dc.w	$FFFC,$0404+4,($E00E+(EMS_SCALESHVRAM/$20)),$FFF2
		dc.w	$000C,$0105+4,($E010+(EMS_SCALESHVRAM/$20)),$FFE2
		dc.w	$0014,$0906+4,($E012+(EMS_SCALESHVRAM/$20)),$FFEA
		dc.w	$FFDC,$0707+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$FFE4,$0208+4,($E808+(EMS_SCALESHVRAM/$20)),$000E
		dc.w	$FFFC,$0209+4,($E80B+(EMS_SCALESHVRAM/$20)),$001E
		dc.w	$FFFC,$040A+4,($E80E+(EMS_SCALESHVRAM/$20)),$FFFE
		dc.w	$000C,$010B+4,($E810+(EMS_SCALESHVRAM/$20)),$0016
		dc.w	$0014,$090C+4,($E812+(EMS_SCALESHVRAM/$20)),$FFFE

MSS_SS_Scale1C:	dc.w	$000E-1
		dc.w	$FFDC,$0701+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$FFEC,$0002+4,($E008+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$FFFC,$0203+4,($E009+(EMS_SCALESHVRAM/$20)),$FFDB
		dc.w	$FFFC,$0004+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$0004,$0205+4,($E00D+(EMS_SCALESHVRAM/$20)),$FFE3
		dc.w	$000C,$0206+4,($E010+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$0014,$0507+4,($E013+(EMS_SCALESHVRAM/$20)),$FFF3
		dc.w	$FFDC,$0708+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$FFEC,$0009+4,($E808+(EMS_SCALESHVRAM/$20)),$000D
		dc.w	$FFFC,$020A+4,($E809+(EMS_SCALESHVRAM/$20)),$001D
		dc.w	$FFFC,$000B+4,($E80C+(EMS_SCALESHVRAM/$20)),$0005
		dc.w	$0004,$020C+4,($E80D+(EMS_SCALESHVRAM/$20)),$0015
		dc.w	$000C,$020D+4,($E810+(EMS_SCALESHVRAM/$20)),$000D
		dc.w	$0014,$050E+4,($E813+(EMS_SCALESHVRAM/$20)),$FFFD

MSS_SS_Scale1D:	dc.w	$0008-1
		dc.w	$FFE0,$0B01+4,($E000+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$FFF8,$0202+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFDB
		dc.w	$0008,$0103+4,($E00F+(EMS_SCALESHVRAM/$20)),$FFE3
		dc.w	$0010,$0904+4,($E011+(EMS_SCALESHVRAM/$20)),$FFEB
		dc.w	$FFE0,$0B05+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFD
		dc.w	$FFF8,$0206+4,($E80C+(EMS_SCALESHVRAM/$20)),$001D
		dc.w	$0008,$0107+4,($E80F+(EMS_SCALESHVRAM/$20)),$0015
		dc.w	$0010,$0908+4,($E811+(EMS_SCALESHVRAM/$20)),$FFFD

MSS_SS_Scale1E:	dc.w	$000C-1
		dc.w	$FFE0,$0601+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF4
		dc.w	$FFE8,$0102+4,($E006+(EMS_SCALESHVRAM/$20)),$FFEC
		dc.w	$FFF8,$0203+4,($E008+(EMS_SCALESHVRAM/$20)),$FFDC
		dc.w	$FFF8,$0004+4,($E00B+(EMS_SCALESHVRAM/$20)),$FFFC
		dc.w	$0008,$0105+4,($E00C+(EMS_SCALESHVRAM/$20)),$FFE4
		dc.w	$0010,$0906+4,($E00E+(EMS_SCALESHVRAM/$20)),$FFEC
		dc.w	$FFE0,$0607+4,($E800+(EMS_SCALESHVRAM/$20)),$FFFC
		dc.w	$FFE8,$0108+4,($E806+(EMS_SCALESHVRAM/$20)),$000C
		dc.w	$FFF8,$0209+4,($E808+(EMS_SCALESHVRAM/$20)),$001C
		dc.w	$FFF8,$000A+4,($E80B+(EMS_SCALESHVRAM/$20)),$FFFC
		dc.w	$0008,$010B+4,($E80C+(EMS_SCALESHVRAM/$20)),$0014
		dc.w	$0010,$090C+4,($E80E+(EMS_SCALESHVRAM/$20)),$FFFC

MSS_SS_Scale1F:	dc.w	$000A-1
		dc.w	$FFE0,$0601+4,($E000+(EMS_SCALESHVRAM/$20)),$FFF0
		dc.w	$FFF8,$0302+4,($E006+(EMS_SCALESHVRAM/$20)),$FFE0
		dc.w	$FFF8,$0003+4,($E00A+(EMS_SCALESHVRAM/$20)),$FFF8
		dc.w	$0008,$0104+4,($E00B+(EMS_SCALESHVRAM/$20)),$FFE8
		dc.w	$0010,$0505+4,($E00D+(EMS_SCALESHVRAM/$20)),$FFF0
		dc.w	$FFE0,$0606+4,($E800+(EMS_SCALESHVRAM/$20)),$0000
		dc.w	$FFF8,$0307+4,($E806+(EMS_SCALESHVRAM/$20)),$0018
		dc.w	$FFF8,$0008+4,($E80A+(EMS_SCALESHVRAM/$20)),$0000
		dc.w	$0008,$0109+4,($E80B+(EMS_SCALESHVRAM/$20)),$0010
		dc.w	$0010,$050A+4,($E80D+(EMS_SCALESHVRAM/$20)),$0000

; ===========================================================================
; ---------------------------------------------------------------------------
; includes
; ---------------------------------------------------------------------------

MSS_ArtSpheres:	binclude "Main Menu\Special Stage\Art Spheres.unc"
MSS_ArtSph_End:	even

MSS_Palette:	binclude "Main Menu\Special Stage\Palette.bin"
		even
MSS_ArtBG:	binclude "Main Menu\Special Stage\Art BG.kosm"
		even
MSS_MapBG:	binclude "Main Menu\Special Stage\Map BG.eni"
		even
MSS_ArtShine:	binclude "Main Menu\Special Stage\Art Shine.kosm"
		even
MSS_ArtPlanet:	binclude "Main Menu\Special Stage\Art Planet.kosm"
		even
MSS_MapPlanet:	binclude "Main Menu\Special Stage\Map Planet.eni"
		even
MSS_ArtWindCom:	binclude "Main Menu\Special Stage\Art Window Common.unc"
		even
MSS_ArtCounter:	binclude "Main Menu\Special Stage\Art Counter.kosm"
		even
MSS_MapCounter:	binclude "Main Menu\Special Stage\Map Counter.bin"
		even
MSS_ArtChars:	binclude "Main Menu\Special Stage\Art Characters.kosm"
		even
MSS_ArtASCII:	binclude "Main Menu\Special Stage\Art ASCII.kosm"
		even
MSS_ArtTextTit:	binclude "Main Menu\Special Stage\Art Text (Title).kosm"
		even
MSS_MapTextTit:	binclude "Main Menu\Special Stage\Map Text (Title).bin"
		even

		align	$20000
MSS_Scalex1:	binclude "Main Menu\Special Stage\Planet Scale\Scale x1.bin"
MSS_Scalex2:	binclude "Main Menu\Special Stage\Planet Scale\Scale x2.bin"
MSS_Scalex3:	binclude "Main Menu\Special Stage\Planet Scale\Scale x3.bin"
MSS_Scalex4:	binclude "Main Menu\Special Stage\Planet Scale\Scale x4.bin"
MSS_ScaleShine:	binclude "Main Menu\Special Stage\Planet Scale\Scale Shine Art.bin"
		even

; ===========================================================================








