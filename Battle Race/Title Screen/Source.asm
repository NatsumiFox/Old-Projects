; ===========================================================================
; ---------------------------------------------------------------------------
; New Title Screen
; ---------------------------------------------------------------------------
ROUNDEL_HI	=	0		; If the roundel should be infront of the sprites or not (Too complicated to do it manually everytime ughh...)
FLIPMODE	=	1		; If we're using cell scroll mode (hopefully so we can flip)
HIDEARROWS	=	0		; If the arrows should display or not (for debugging purposes)
HIDELOGO	=	0		; If the logo should display or not (for debugging purposes)
ROUNDELDISPLAY	=	0		; 0 = Star, 1 = Sonic, 2 = Little Planet, 3 = Sonic CD
LAGFLASH	=	0		; If a flash should occur every frame the screen lags
FRAMESWITCH	=	1		; if there should be allowed frame switching
; ---------------------------------------------------------------------------
	if ROUNDEL_HI=0
TSV_PlaneA	=	$0000		; 1000	; Plane A
TSV_PlaneRound	=	TSV_PlaneA
	else
TSV_PlaneB	=	$0000		; 1000	; Plane B
TSV_PlaneRound	=	TSV_PlaneB
	endif
TSV_Roundel1	=	$1000		; 5100	; Roundal Art Buffer 1
	if ROUNDEL_HI=0
TSV_PlaneB	=	$6100		;  E00	; Plane B
TSV_PlaneLogo	=	TSV_PlaneB
	else
TSV_PlaneA	=	$6100		;  E00	; Plane A
TSV_PlaneLogo	=	TSV_PlaneA
	endif
TSV_Roundel2	=	$6F00		; 5100	; Roundal Art Buffer 2
TSV_Sprites	=	$C000		;  280	; Sprite Table
TSV_Arrows	=	$C280		; 10A0	; Sprite Arrow Art
TSV_Boarder	=	$D320		;   E0	; Boarder Art
TSV_HScroll	=	$D400		;  380	; H-Scroll Table
TSV_Logo	=	$D780		; 2860	; S3K Logo Art
TSV_LogoJap	=	TSV_Logo+$1F40	;  920	; Japanese "BATTLE RACE" text (overwrites English version)
; ---------------------------------------------------------------------------
WriteVRAM function VRAM,((((VRAM&$3FFF)|$4000)<<$10)|((VRAM>>$0E)&3))
SetDestDMA function VRAM,(WriteVRAM(VRAM)|$80)
SetSizeDMA function SIZE,($94009300|(((SIZE>>1)&$FF00)<<$08)|((SIZE>>1)&$FF))
; ---------------------------------------------------------------------------
TSR_RoundelArt	=	$FFFF0000	; ????	; Roundel art buffer
TSR_MapDump	=	TSR_RoundelArt	; ????	; just a temporary dumping ground for loading compressed mappings...
TSR_VScroll1	=	$FFFF1000	; 1800	; V-scroll H-blank buffer 1
TSR_VScroll2	=	$FFFF2800	; 1800	; V-scroll H-blank buffer 2
TSR_MapBoarder	=	$FFFF4000	; ????	; boardrer mappings
TSR_RoundMap1	=	$FFFF4800	;  E00	; buffer 1 mappings
TSR_RoundMap2	=	$FFFF5600	;  E00	; buffer 2 mappings
TSR_RoundMap1F	=	$FFFF6400	;  E00	; buffer 1 mappings (flipped)
TSR_RoundMap2F	=	$FFFF7200	;  E00	; buffer 2 mappings (flipped)
TSR_Sprites	=	$FFFF8000	;  280	; Sprite Table
TSR_HScrollFG	=	$FFFF8400	;  200	; H-Scroll table for FG
TSR_HScrollBG	=	$FFFF8600	;  200	; H-Scroll table for BG
TSR_VScrollFG	=	$FFFF8800	;  100	; V-Scroll table for FG
TSR_ArrowPal	=	$FFFF8C00	;   20	; palette buffer for arrows
TSR_Subroutines	=	$FFFF9000	; long	; subroutines address
TSR_ArrowAngle	=	$FFFF9004	; word	; Angle for the arrows bowing in/out
TSR_BoardPos	=	$FFFF9006	; long	; Boarder scroll speed
TSR_LogoPos	=	$FFFF900A	;    8	; logo scroll position
TSR_ArrowFade	=	$FFFF9012	; byte	; fade counter for arrows
TSR_ArrFadeTime	=	$FFFF9013	; byte	; fade speed for arrows
TSR_ArrCycPos	=	$FFFF9014	; byte	; cycle position for arrows
TSR_BoarderFade	=	$FFFF9015	; byte	; fade speed for boarders
TSR_StripPos	=	$FFFF9016	; word	; strip address counter/position
TSR_RDMA_Dest	=	$FFFF9018	; word	; VVVV
TSR_RDMA_Size	=	$FFFF901A	; long	; 94XX93XX
TSR_RDMA_Plate	=	$FFFF901E	; long	; address of roundel art to use
TSR_AngleCur	=	$FFFF9022	; word	; roundel current angle
TSR_AngleDest	=	$FFFF9024	; word	; roundel destination angle
TSR_AnglePrev	=	$FFFF9026	; word	; previous destination angle
TSR_RoundelSize	=	$FFFF9028	; word	; VRAM destination increment size
TSR_RDMA_Map	=	$FFFF902A	; long	; 96XX95XX
TSR_AngleDir	=	$FFFF902E	; byte	; angle direction
TSR_RDMA_Requ	=	$FFFF902F	; byte	; roundel transfer request (new request)
TSR_AngleSpeed	=	$FFFF9030	; word	; speed to rotate angle by
TSR_FlipBuffer	=	$FFFF9032	; byte	; V-scroll buffer to use
TSR_FlipPrev	=	$FFFF9033	; byte	; previous side the roundel was facing
TSR_FlipAngle	=	$FFFF9034	; word	; flip angle
TSR_GreenCycle	=	$FFFF9036	; byte	; green palette cycle current amount
TSR_GreenPol	=	$FFFF9037	; byte	; fade polarity/direction
TSR_FlipSpeed	=	$FFFF9038	; word	; speed of flipping
TSR_UserControl	=	$FFFF903A	; byte	; if the players are now controlling the roundel
TSR_AllowCtrl	=	$FFFF903B	; byte	; when the players can control the roundel
TSR_AutoRoutine	=	$FFFF903C	; long	; address of auto-scroll routine to run
TSR_AutoTimer	=	$FFFF9040	; word	; timer for auto-scroll routines
TSR_AutoCounter	=	$FFFF9042	; word	; a counter for the auto-scroll, use for whatever...
TSR_ExitScreen	=	$FFFF9044	; byte	; if the screen is to exit
TSR_RoundelFin	=	$FFFF9045	; byte	; if the roundel has finished rotating/spinning
TSR_BlankList	=	$FFFF9048	; long	; address of blanking out art list
TSR_BlankVRAM	=	$FFFF904C	; long	; VDP setting address of VRAM
TSR_BlankSize	=	$FFFF9050	; long	; 94XX93XX
TSR_GreenCount	=	$FFFF9054	; byte	; delay counter for the roundel's green cycling
TSR_SwitchPlate	=	$FFFF9055	; byte	; plate switch flag (00 no switch, FF and below - prepare to switch, 01 and above - switch count)
TSR_BlankRAM	=	$FFFF9800	; 800	; please keep blank
; ---------------------------------------------------------------------------

TitleScreen:
		moveq	#-$1F,d0				; fade music out
		jsr	Play_Sound.w				; ''
		moveq	#$00,d0					; slow music down
		jsr	Change_Music_Tempo.w			; ''
		clr.w	(Kos_decomp_queue_count).w		; clear kosinski decompression cue count
		jsr	Clear_KosM_Queue.w			; clear Kosinski Moduled decompression cue information
		jsr	Pal_FadeToBlack				; fade out to black

	; --- Setup/clearing ---

		move	#$2700,sr				; disable interrupts
		move.l	#NullRTE,(H_int_addr).w			; set H-blank routine
		move.l	#VB_TitleInit,(V_int_addr).w		; set V-blank routine

		lea	($C00000).l,a5					; load VDP data port
		lea	$04(a5),a6					; load VDP control port
		move.w	#$8000|%00110100,(a6)				; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)
		move.w	#$8100|%00110100,(a6)				; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.w	#$8200|(((TSV_PlaneA&$E000)>>$0A)&$FF),(a6)	; 00FE DCBA - Scroll Plane A Map Table VRam address
		move.w	#$8300|(((TSV_PlaneRound)>>$0A)&$FF),(a6)	; 00FE DCB0 / 00FE DC00 (20 H-resol) - Window Plane A Map Table VRam address
		move.w	#$8400|(((TSV_PlaneB&$E000)>>$0D)&$FF),(a6)	; 0000 0FED - Scroll Plane B Map Table VRam address
		move.w	#$8500|(((TSV_Sprites&$FE00)>>$09)&$FF),(a6)	; 0FED CBA9 / 0FED CBA0 (20 H-resol) - Sprite Plane Map Table VRam address
		move.w	#$8600|%00000000,(a6)				; 0000 0000 - Unknown/Unused Register
		move.w	#$8700|$00,(a6)					; 00PP CCCC - Backdrop Colour: Palette Line | Colour ID
		move.w	#$8800|%00000000,(a6)				; 0000 0000 - Unknown/Unused Register
		move.w	#$8900|%00000000,(a6)				; 0000 0000 - Unknown/Unused Register
		move.w	#$8A00|$DF,(a6)					; 7654 3210 - H-Interrupt Register
		move.w	#$8B00|%00000111,(a6)				; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)
		move.w	#$8C00|%10000001,(a6)				; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
		move.w	#$8D00|(((TSV_HScroll&$FC00)>>$0A)&$FF),(a6)	; 00FE DCBA - Horizontal Scroll Table VRam address
		move.w	#$8E00|%00000000,(a6)				; 0000 0000 - Unknown/Unused Register
		move.w	#$8F00|$02,(a6)					; 7654 3210 - Auto Increament
		move.w	#$9000|%00000001,(a6)				; 00VV 00HH - Plane Y Size (00-20|01-40|11-80) | Plane X size (00-20|01-40|11-80)
		move.w	#$9100|$01,(a6)					; 7654 3210 - Window Horizontal Position
		move.w	#$9200|$00,(a6)					; 7654 3210 - Window Vertical Position

		move.l	#$40000080,d0				; VRAM
		move.w	#$FFFF,d1				; size to clear
		jsr	ClearVDP				; clear VDP memory section

		move.l	#$40000090,d0				; VSRAM
		move.w	#$0080,d1				; size to clear
		jsr	ClearVDP				; clear VDP memory section

		lea	($FFFF0000).l,a1			; load RAM to clear
		move.w	#(($A000/$04)/$04)-1,d1			; size to clear
		moveq	#$00,d0					; clear d0

TS_ClearRAM:
		move.l	d0,(a1)+				; clear RAM
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		dbf	d1,TS_ClearRAM				; repeat til all is clear

	; --- Art loading ---

		lea	(TS_ArtBoarder).l,a1			; load boarder art
		move.w	#TSV_Boarder,d2				; ''
		jsr	Queue_Kos_Module.w			; ''

		lea	(TS_ArtLogo).l,a1			; load logo art
		move.w	#TSV_Logo,d2				; ''
		jsr	Queue_Kos_Module.w			; ''

		lea	(TS_ArtArrows).l,a1			; load arrow sprite art
		move.w	#TSV_Arrows,d2				; ''
		jsr	Queue_Kos_Module.w			; ''

		tst.b	(Graphics_flags).w			; is the machine Japanese?
		bmi.s	TS_LoadArt				; if not, branch
		lea	(TS_ArtLogoJap).l,a1			; load Japanese "BATTLE RACE" text
		move.w	#TSV_LogoJap,d2				; ''
		jsr	Queue_Kos_Module.w			; ''

TS_LoadArt:
		st.b	(V_int_routine).w			; set V-blank flag
		jsr	Process_Kos_Queue	; Delete maybe? (I donno why we need this when moduled is only used, but we'll see)
		jsr	Wait_VSync				; wait for V-blank
		jsr	Process_Kos_Module_Queue.w		; decompress art
		tst.l	(Kos_module_queue).w			; have all art cues been decompressed?
		bne.s	TS_LoadArt				; if not, branch
		st.b	(V_int_routine).w			; set V-blank flag
		jsr	Wait_VSync				; wait for V-blank
		move	#$2700,sr				; disable interrupts
		lea	($C00000).l,a5				; reload VDP data port
		lea	$04(a5),a6				; reload VDP control port

	; --- Loading data ---

		lea	(TS_MapBoarder).l,a0			; load boarder mappings
		lea	(TSR_MapBoarder).l,a1			; ''
		moveq	#$00,d0					; ''
		jsr	Eni_Decomp				; ''

		move.l	#WriteVRAM(TSV_PlaneLogo),a0		; prepare starting VRAM address
		moveq	#$04-1,d7				; set number of width sections to write

TS_LoadBoardTop:
		lea	(TSR_MapBoarder).l,a1			; source
		move.l	a0,d0					; VRAM
		moveq	#$10-1,d1				; Width
		moveq	#$04-1,d2				; Height
		move.l	#$00800000,d4				; Increment
		move.w	#((TSV_Boarder/$20)-1),d5		; adjustment
		bsr.w	MapPlane				; dump to VRAM plane
		addi.l	#$00200000,a0				; advance map VRAM position right
		dbf	d7,TS_LoadBoardTop			; repeat until the entire plane width is filled

		move.l	#WriteVRAM(TSV_PlaneLogo+$D80),a0	; prepare starting VRAM address
		moveq	#$04-1,d7				; set number of width sections to write

TS_LoadBoardBottom:
		lea	(TSR_MapBoarder).l,a1			; source
		move.l	a0,d0					; VRAM
		moveq	#$10-1,d1				; Width
		moveq	#$04-1,d2				; Height
		move.l	#$FF800000,d4				; Increment
		move.w	#((TSV_Boarder/$20)-1)|$1000,d5		; adjustment
		bsr.w	MapPlane				; dump to VRAM plane
		addi.l	#$00200000,a0				; advance map VRAM position right
		dbf	d7,TS_LoadBoardBottom			; repeat until the entire plane width is filled

	if HIDELOGO=0
		lea	(TS_MapLogo).l,a0			; load logo mappings
		lea	(TSR_MapDump).l,a1			; ''
		moveq	#$00,d0					; ''
		jsr	Eni_Decomp				; ''
		lea	(TSR_MapDump).l,a1			; source
		move.l	#WriteVRAM(TSV_PlaneLogo+$408),d0		; VRAM
		moveq	#$20-1,d1				; Width
		moveq	#$0E-1,d2				; Height
		move.l	#$00800000,d4				; Increment
		move.w	#((TSV_Logo/$20)-1)|$A000,d5		; adjustment
		bsr.w	MapPlane				; dump to VRAM plane

		tst.b	(Graphics_flags).w			; is the machine Japanese?
		bmi.s	TS_NoJapLogo				; if not, branch
		lea	(TS_MapLogoJap).l,a0			; load logo mappings
		lea	(TSR_MapDump).l,a1			; ''
		moveq	#$00,d0					; ''
		jsr	Eni_Decomp				; ''
		lea	(TSR_MapDump).l,a1			; source
		move.l	#WriteVRAM(TSV_PlaneLogo+$908),d0	; VRAM
		moveq	#$20-1,d1				; Width
		moveq	#$04-1,d2				; Height
		move.l	#$00800000,d4				; Increment
		move.w	#((TSV_LogoJap/$20)-1)|$A000,d5		; adjustment
		bsr.w	MapPlane				; dump to VRAM plane

TS_NoJapLogo:
	endif

		lea	(TS_Palette).l,a0			; load palette list
		lea	(Target_palette).w,a1			; load buffer
		moveq	#($80/4)-1,d1				; set size to copy

TS_LoadPal:
		move.l	(a0)+,(a1)+				; copy colours to buffer
		dbf	d1,TS_LoadPal				; repeat for all colours

	; --- Roundel mappings ---

	if ROUNDEL_HI=0
		move.w	#(TSV_Roundel1/$20)|$6000,d0		; prepare roundel tile ID
	else
		move.w	#(TSV_Roundel1/$20)|$E000,d0		; prepare roundel tile ID
	endif
		lea	(TSR_RoundMap1).l,a1			; load map buffer to dump to
		bsr.w	TS_MapRoundel				; map the roundel
	if ROUNDEL_HI=0
		move.w	#(TSV_Roundel2/$20)|$6000,d0		; prepare roundel tile ID
	else
		move.w	#(TSV_Roundel2/$20)|$E000,d0		; prepare roundel tile ID
	endif
		lea	(TSR_RoundMap2).l,a1			; load map buffer to dump to
		bsr.w	TS_MapRoundel				; map the roundel
	if FLIPMODE=1
		lea	(TSR_RoundMap1).l,a0			; load mappings to flip
		lea	(TSR_RoundMap1F+$E00).l,a1		; load dumping area
		bsr.w	TS_FlipMap				; make a flipped version
		lea	(TSR_RoundMap2).l,a0			; load mappings to flip
		lea	(TSR_RoundMap2F+$E00).l,a1		; load dumping area
		bsr.w	TS_FlipMap				; make a flipped version
	endif

	; --- The left mask ---

		move.l	#$11111111,d0				; prepare mask tile (black pixels)
		move.l	#$7FE00003,(a6)				; write mask tile to VRAM FFE0 (last tile in VRAM)
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''

		lea	(TSR_RoundMap1+$180).l,a1		; map the left mask to buffer 1
		bsr.w	TS_CreateMask				; ''
		lea	(TSR_RoundMap2+$180).l,a1		; map the left mask to buffer 2
		bsr.w	TS_CreateMask				; ''
		lea	(TSR_RoundMap1F+$180).l,a1		; map the left mask to buffer 1 flipped
		bsr.w	TS_CreateMask				; ''
		lea	(TSR_RoundMap2F+$180).l,a1		; map the left mask to buffer 2 flipped
		bsr.w	TS_CreateMask				; ''

		lea	(TSR_Sprites).w,a1			; load sprite list
		move.l	#$00800001,(a1)+			; prepare sprites for mask
		move.l	#$00000000,(a1)+
		move.l	#$00800002,(a1)+
		move.l	#$00000000,(a1)+
		move.l	#$00880003,(a1)+
		move.l	#$00000000,(a1)+
		move.l	#$00880004,(a1)+
		move.l	#$00000000,(a1)+
		move.l	#$00900005,(a1)+
		move.l	#$00000000,(a1)+
		move.l	#$00900006,(a1)+
		move.l	#$00000000,(a1)+
		move.l	#$00980007,(a1)+
		move.l	#$00000000,(a1)+
		move.l	#$00980008,(a1)+
		move.l	#$00000000,(a1)+

		; Making adjustments to the mappings so the sprites can use them

		lea	(TSR_MapBoarder).l,a1			; load mappings
		move.w	#((TSV_Boarder/$20)-1),d5		; adjustment
		moveq	#($10*$04)-1,d1				; size of mappings

TS_AdjustMap:
		tst.w	(a1)					; is the tile blank?
		beq.s	TSAM_BlankTile				; if so, branch
		add.w	d5,(a1)+				; make VRAM adjustment
		dbf	d1,TS_AdjustMap				; repeat for all mappings
		bra.s	TSAM_FinishAdjust

TSAM_BlankTile:
		move.w	#$87FF,(a1)+				; set to use blank tile
		dbf	d1,TS_AdjustMap				; repeat for all mappings

TSAM_FinishAdjust:

		; creating a replica of the first tile on the end of every line
		; so copying a long-word can work

		lea	(TSR_MapBoarder+$80).l,a1		; load mapping address
		lea	$08(a1),a2				; load new end address (extra 2 tiles for every line)
		moveq	#$04-1,d1				; set number of lines

TS_ReposMap:
		move.w	-$20(a1),-(a2)				; copy first tile to end
		move.l	-(a1),-(a2)				; copy column of tiles over
		move.l	-(a1),-(a2)				; ''
		move.l	-(a1),-(a2)				; ''
		move.l	-(a1),-(a2)				; ''
		move.l	-(a1),-(a2)				; ''
		move.l	-(a1),-(a2)				; ''
		move.l	-(a1),-(a2)				; ''
		move.l	-(a1),-(a2)				; ''
		dbf	d1,TS_ReposMap				; repeat for all columns

	; --- Final stuff ---

	if ROUNDEL_HI=0
		move.l	#$00080000|((TSV_PlaneLogo&$F80)>>4),d0		; prepare V-scroll positions
	else
		move.l	#$00000008|((TSV_PlaneLogo&$F80)<<($10-4)),d0	; prepare V-scroll positions
	endif
		move.l	#$40000010,(a6)				; set VDP to VSRAM write mode
		moveq	#($80/4)-1,d1				; set size to write

TS_LoadVSRAM:
		move.l	d0,(a5)					; set starting V-Scroll positions
		dbf	d1,TS_LoadVSRAM				; repeat for all positions

		; --- V-scroll bug with -1 ---
		; A bug in models 1 and 2 cause plane A's $13 V-scroll to be
		; AND logical against Plane B's $13 V-scroll, and the result to be
		; used for both Plane A and B's -$1 V-scroll (only in 320 width mode)
		;
		; Effectively -$1 is an AND logical of the far right displaying columns.
		; This below will ensure that both Plane A and B's $13 are set the same
		; so the result will present itself in -$1.
		; ----------------------------

		move.l	#$404C0010,(a6)				; set VSRAM address of the screen's right furthest column
	if ROUNDEL_HI=1
		swap	d0					; get logo/boarder plane's position
	endif
		move.w	d0,(a5)					; ensure both plane A and plane B are set the same
		move.w	d0,(a5)					; ''


		move.l	#$94009300,(TSR_RDMA_Size).w		; prepare DMA size
		move.l	#$96009500,(TSR_RDMA_Map).w		; prepare DMA source
		st.b	(TSR_RDMA_Requ).w			; request art to be transferred
  if ROUNDELDISPLAY=0
		move.l	#TS_StarRoundel,(TSR_RDMA_Plate).w	; set roundel art to use
  elseif ROUNDELDISPLAY=1
		move.l	#TS_Sonic,(TSR_RDMA_Plate).w		; set roundel art to use
  elseif ROUNDELDISPLAY=2
		move.l	#TS_LitPlanet,(TSR_RDMA_Plate).w	; set roundel art to use
  elseif ROUNDELDISPLAY=3
		move.l	#TS_SonicCD,(TSR_RDMA_Plate).w		; set roundel art to use
  endif
		clr.w	(TSR_StripPos).w			; reset strip position
		move.b	#-8,(TSR_AngleCur).w			; set starting angle to -8 (so that angle 00 gets to render first)
		move.b	#$81,(TSR_AngleDir).w			; set forwards direction (frozen)
		clr.w	(TSR_AngleSpeed).w			; set no speed
		move.b	#$3F,(TSR_FlipAngle).w			; set starting angle
		clr.w	(TSR_FlipSpeed).w			; set no speed

		sf.b	(TSR_GreenCycle).w			; reset palette cycling
		sf.b	(TSR_GreenPol).w			; ''
		sf.b	(TSR_SwitchPlate).w			; clear flipping flag

		moveq	#$00,d0
		move.l	d0,(TSR_AutoRoutine).w			; reset auto-scroll routine to beginning
		move.w	d0,(TSR_AutoTimer).w			; ''

		move.w	#$00D0,(TSR_LogoPos).w
		move.w	#$00D0+$20,(TSR_LogoPos+4).w
		move.l	#MLTS_LogoIn,(TSR_Subroutines).w	; set starting routine
	if FLIPMODE=0
		move.l	#VB_TitleScreen,(V_int_addr).w		; set V-blank routine
	else
		move.w	#$8000,(TSR_VScroll1+(($E0/2)*$1E)).l	; write end markers for V-scroll
		move.w	#$8000,(TSR_VScroll2+(($E0/2)*$1E)).l	; ''
		move.l	#VB_LineScroll,(V_int_addr).w		; set V-blank routine
	endif
		move.w	#$8100|%01110100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)

		moveq	#Mus_TitleScreen,d0			; player title screen music
		jsr	Play_Sound.w				; ''

; ---------------------------------------------------------------------------
; Logo in loop
; ---------------------------------------------------------------------------

MLTS_LogoIn:
		bsr.w	TS_CheckExit				; check if title should finish
		bsr.w	TS_LogoScroll				; scrolling the logo/boarders
		lea	(Normal_palette+$20).w,a0		; load current palette
		lea	(Target_palette+$20).w,a1		; load palette to cycle to
		moveq	#$0010-1,d6				; set number of colours to do
		bsr.w	TS_FadePalette				; fade the logo colours in
		move.l	(TSR_Subroutines).w,-(sp)		; save return address
		st.b	(V_int_routine).w			; set V-blank flag
		jmp	Wait_VSync				; wait for V-blank

; ---------------------------------------------------------------------------
; fading arrows in
; ---------------------------------------------------------------------------

MLTS_FadeArrows:
		bsr.w	TS_CheckExit				; check if title should finish
		bsr.w	TS_ArrowPalette				; cycle palette for arrow sprites
		bsr.w	TS_FadeArrows				; subroutine to fade the arrow colours in correctly
		bsr.w	TS_ArrowSprites				; render sprites correctly
		move.l	(TSR_Subroutines).w,-(sp)		; save return address
		st.b	(V_int_routine).w			; set V-blank flag
		jmp	Wait_VSync				; wait for V-blank

; ---------------------------------------------------------------------------
; fading boarders in
; ---------------------------------------------------------------------------

MLTS_FadeBoarder:
		bsr.w	TS_CheckExit				; check if title should finish
		subq.b	#$01,(TSR_BoarderFade).w		; decrease fade delay timer
		bpl.s	MLTSFI_NoFadeB				; if still running, branch
		move.b	#$04,(TSR_BoarderFade).w		; reset fade delay timer
		lea	(Normal_palette+$00).w,a0		; load current palette
		lea	(Target_palette+$00).w,a1		; load palette to cycle to
		moveq	#$0010-1,d6				; set number of colours to do
		bsr.w	TS_FadePalette				; fade the palette in correctly
		tst.b	d4					; has it fully finished?
		bne.s	MLTSFI_NoFadeB				; if not, branch
		move.l	#MLTS_Main,(TSR_Subroutines).w		; set next routine

MLTSFI_NoFadeB:
	if FLIPMODE=0
		bsr.w	TS_BoarderScroll			; scrolling the logo/boarders
	endif
		bsr.w	TS_ArrowPalette				; cycle palette for arrow sprites
		bsr.w	TS_ArrowSprites				; render sprites correctly
		move.l	(TSR_Subroutines).w,-(sp)		; save return address
		st.b	(V_int_routine).w			; set V-blank flag
		jmp	Wait_VSync				; wait for V-blank

; ---------------------------------------------------------------------------
; The main idle loop
; ---------------------------------------------------------------------------

MLTS_Main:
		bsr.w	TS_CheckExit				; check if title should finish

MLTS_FadeOut:
	if FLIPMODE=0
		bsr.w	TS_BoarderScroll			; scrolling the logo/boarders
	endif
		bsr.w	TS_ArrowPalette_Quick			; cycle palette for arrow sprites
	if FLIPMODE=0
		bsr.w	TS_ArrowSprites				; render sprites correctly
	endif
		bsr.w	TS_ControlRoundel			; allow players to control the roundel
		bsr.w	TS_RoundelArt				; render the roundel art
		bsr.w	TS_RoundelScroll			; perform H/V-scrolling
	if FLIPMODE=1
		bsr.w	TS_RoundelPal				; perform palette change on the roundel
		bsr.w	TS_RoundelFlip				; perform V-scroll buffer flipping
	endif
		move.l	(TSR_Subroutines).w,-(sp)		; save return address
		st.b	(V_int_routine).w			; set V-blank flag
		jmp	Wait_VSync				; wait for V-blank

; ---------------------------------------------------------------------------
; Finishing...
; ---------------------------------------------------------------------------

MLTS_Finish:
		move	#$2700,sr				; disable interrupts
		move.l	#VB_Dull,(V_int_addr).w			; set V-blank routine
		move.b	#$04,(Game_mode).w			; change to main menu
		move.l	#NullRTE,(H_int_addr).w			; change H-blank address
		move.w	#$8ADF,(a6)				; disabe H-blank
		move.w	#$8F02,(a6)				; force auto-increment back to normal
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to trigger a finish
; ---------------------------------------------------------------------------

TS_CheckExit:
		tst.b	(TSR_AllowCtrl).w			; have players been given controller access yet?
		beq.s	TSCE_NoFinish				; if not, branch
		move.b	(Ctrl_1_pressed).w,d0			; load player 1 pressed buttons
		or.b	(Ctrl_2_pressed).w,d0			; fuse player 2 pressed buttons with it
		bpl.s	TSCE_NoFinish				; if start has not been pressed, branch
		st.b	(TSR_ExitScreen).w			; set to exit
		move.l	#MLTS_FadeOut,(TSR_Subroutines).w	; set fade out routine)
		move.l	#VBTS_BlankList,(TSR_BlankList).w	; set blankout list to use
		clr.l	(TSR_BlankVRAM).w			; clear VRAM address
		moveq	#-$1F,d0				; fade music out
		jmp	Play_Sound.w				; ''

TSCE_NoFinish:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to allow the controllers to control the roundel
; ---------------------------------------------------------------------------
TSCR_MAXSPEED	=	$00B0	; B8 is about the limit for COUNTSTRIPS=3, it'd be 100 for COUNTSTRIPS=4
TSCR_ACCEL	=	$0006	; acceleration
TSCR_MAXFLIP	=	$0200	; maximum speed for flipping
TSCR_ACCFLIP	=	$0008	; acceleration
; ---------------------------------------------------------------------------

TS_ControlRoundel:
	if FRAMESWITCH=1
		tst.b	(TSR_SwitchPlate).w			; is the roundel flipping?
		bgt.s	TSCR_NoControls				; if so, branch
	endif
		btst.b	#$00,(TSR_FlipPrev).w			; is the flip meant to be rendering mappings?
		bne.s	TSCR_NoControls				; if so branch (no rendering)
		tst.b	(TSR_AngleDir).w			; is the roundel rotation frozen?
		bpl.s	TSCR_AllowControls			; if not, branch
		bra.w	TSCR_RenderFlip				; perform only the flipping

TSCR_NoControls:
		rts						; return (wait until the frame renders)

TSCR_AllowControls:
		tst.b	(TSR_ExitScreen).w			; are we exiting?
		bne.w	TSCR_FinishScroll			; if so, branch
		tst.b	(TSR_UserControl).w			; are the players controlling the roundel now?
		bne.w	TSCR_UserControl			; if so, branch

; ---------------------------------------------------------------------------
; Auto-scroll
; ---------------------------------------------------------------------------

		tst.b	(TSR_AllowCtrl).w			; are users allow to control now?
		beq.s	TSCR_NoUsers				; if not, branch
		move.b	(Ctrl_1_held).w,d0			; load player 1 controls
		or.b	(Ctrl_2_held).w,d0			; fuse with player 2 controls
		andi.b	#$7F,d0					; clear start button
		beq.s	TSCR_NoUsers				; if no buttons were pressed, branch
		st.b	(TSR_UserControl).w			; set users as controlling the roundel
	if FRAMESWITCH=1
		tst.b	(TSR_SwitchPlate).w
		bgt.s	TSCR_NoClearSwitch
		sf.b	(TSR_SwitchPlate).w

TSCR_NoClearSwitch:
	endif
		bra.w	TSCR_UserControl			; continue to do user control

TSCR_NoUsers:
		move.l	(TSR_AutoRoutine).w,d0			; load auto-scroll routine
		bne.s	TSCR_AutoRoutine			; if there's a valid routine set, branch
		move.l	#TSCR_RotateIntro,d0			; set address
		move.l	d0,(TSR_AutoRoutine).w			; ''

TSCR_AutoRoutine:
		pea	TSCR_RenderRotate(pc)			; set to render the rotation/flipping afterwards
		move.l	d0,a0					; run the routine
		jmp	(a0)					; ''

	; --- Rotation intro ---

TSCR_RotateIntro:
		move.w	#$0100,(TSR_FlipSpeed).w		; set starting flip speed
		move.l	#TSCRRI_SpeedUp,(TSR_AutoRoutine).w	; set routine
		move.w	#$A800,(TSR_AutoCounter).w

TSCRRI_SpeedUp:
		move.w	(TSR_AutoCounter).w,d0
		cmp.w	(TSR_FlipAngle).w,d0			; has the angle reached slowing point?
		blo.s	TSCRRI_SlowDown				; if so, branch
		addq.w	#$08,(TSR_FlipSpeed).w			; increase speed
		rts						; return

TSCRRI_SlowDown:
		move.l	#TSCRRI_SlowDown2,(TSR_AutoRoutine).w	; set routine

TSCRRI_SlowDown2:
		subq.w	#$06,(TSR_FlipSpeed).w			; slow it down
		bcc.s	TSCRRI_NoStop				; if it hasn't stopped, branch
		clr.w	(TSR_FlipSpeed).w			; set no speed
		move.l	#TSCR_RotateHold,(TSR_AutoRoutine).w	; set routine
		move.w	#$0080,(TSR_AutoTimer).w		; set time before flipping again
		st.b	(TSR_AllowCtrl).w			; allow controls to work

TSCR_RotateHold:
		subq.w	#$01,(TSR_AutoTimer).w			; decrease timer
		bpl.s	TSCRRI_NoStop				; if still running, branch (wait before flipping again
		move.l	#TSCR_RotateFlip,(TSR_AutoRoutine).w	; set routine

TSCRRI_NoStop:
		addq.w	#$02,(TSR_AngleSpeed).w			; rotate roundel
		rts						; return

TSCR_RotateFlip:
	if FRAMESWITCH=1
		st.b	(TSR_SwitchPlate).w			; switch the roundel frame
	endif
		subq.w	#$02,(TSR_FlipSpeed).w			; start flipping back the other way
		cmpi.w	#-TSCR_MAXFLIP,(TSR_FlipSpeed).w	; has it reached maximum speed?
		bgt.s	TSCR_NoReverse				; if not, branch
		move.l	#TSCRRF_Reverse,(TSR_AutoRoutine).w

TSCRRF_Reverse:
		addq.w	#$04,(TSR_FlipSpeed).w			; slow down the flipping
		bcc.s	TSCR_NoReverse				; if it hasn't stopped, branch
		clr.w	(TSR_FlipSpeed).w			; stop speed
		move.l	#TSCRRF_ReverseAngle,(TSR_AutoRoutine).w

TSCRRF_ReverseAngle:
		subq.w	#$04,(TSR_AngleSpeed).w			; rotate backwards
		bpl.s	TSCR_NoReverse				; if it hasn't stopped and started going backwards, branch
		addq.w	#$02,(TSR_FlipSpeed).w			; continue flipping forwards again
		cmpi.w	#TSCR_MAXFLIP,(TSR_FlipSpeed).w		; has it reached maximum speed?
		ble.s	TSCR_NoReverse				; if not, branch
		subi.w	#$3240,(TSR_AutoCounter).w		; alter angle to be checked (will cause the looping to seem less repetetive
		move.l	#TSCRRI_SpeedUp,(TSR_AutoRoutine).w	; set routine

TSCR_NoReverse:
		rts						; return

; ---------------------------------------------------------------------------
; Finishing scroll
; ---------------------------------------------------------------------------

TSCR_FinishScroll:
		tst.w	(TSR_AngleSpeed).w			; has the roundel finished rotating?
		bne.s	TSCR_NoFinishFlip			; if not, branch
		st.b	(TSR_RoundelFin).w			; set roundel as finished

TSCR_NoFinishFlip:
		move.w	(TSR_FlipAngle).w,d0			; load current position
		subi.w	#$4000,d0				; rotate 90 degrees (40.00)
		neg.w	d0					; reverse side
		asr.w	#$03,d0					; reduce for speed
		move.w	d0,d1					; is it pretty much at 0?
		addq.w	#$01,d1					; ''
		cmpi.w	#$0001,d1				; ''
		bhi.s	TSCR_NoFinFlip				; if there's still speed, branch
		move.w	#$4000,(TSR_FlipAngle).w		; move directly to position
		moveq	#$00,d0					; clear speed

TSCR_NoFinFlip:
		move.w	d0,(TSR_FlipSpeed).w			; set speed towards position 0

		move.w	(TSR_AngleSpeed).w,d0			; load speed for rotating the angle
		move.w	d0,d1					; store for afterwards
		asr.w	#$03,d1					; get fraction of the speed
		beq.s	TSCR_FinStopRot				; if it's now 0, branch
		sub.w	d1,d0					; decrease speed
		move.w	d0,d1					; copy new speed to d1
		addq.w	#$01,d1					; is it FFFF or 0000?
		cmpi.w	#$0001,d1				; ''
		bhi.s	TSCR_FinNoStopRot			; if not, branch

TSCR_FinStopRot:
		moveq	#$00,d0					; force speed to 0

TSCR_FinNoStopRot:
		move.w	d0,(TSR_AngleSpeed).w			; update speed
		bra.w	TSCR_RenderRotate			; continue to render handler

; ---------------------------------------------------------------------------
; User is controlling the roundel
; ---------------------------------------------------------------------------

TSCR_UserControl:
		moveq	#$00,d2					; clear flip reset flag
		move.b	(Ctrl_1_held).w,d3			; load player 1 controls
		or.b	(Ctrl_2_held).w,d3			; fuse with player 2 controls
		add.b	d3,d3					; get button A
		bpl.s	TSCR_NoA				; if not pressed, branch
		ori.b	#%01100000,d3				; reset both rotation and flipping positions together

TSCR_NoA:
		add.b	d3,d3					; get button C
		bpl.s	TSCR_NoC				; if not pressed, branch
		move.w	(TSR_FlipAngle).w,d0			; load current position
		neg.w	d0					; reverse side
		asr.w	#$03,d0					; reduce for speed
		move.w	d0,d1					; is it pretty much at 0?
		addq.w	#$01,d1					; ''
		cmpi.w	#$0001,d1				; ''
		bhi.s	TSCR_NoForceFlip			; if there's still speed, branch
		moveq	#$00,d0					; move directly to position
		move.w	d0,(TSR_FlipAngle).w			; ''

TSCR_NoForceFlip:
		move.w	d0,(TSR_FlipSpeed).w			; set speed towards position 0
		st.b	d2					; set flipping as being reset

TSCR_NoC:
		add.b	d3,d3					; get button B
		bpl.s	TSCR_NoB				; if not pressed, branch
		move.w	(TSR_AngleCur).w,d0			; load current position
		neg.w	d0					; reverse side
		asr.w	#$03,d0					; reduce for speed
		move.w	d0,d1					; is it pretty much at 0?
		addq.w	#$01,d1					; ''
		cmpi.w	#$0001,d1				; ''
		bhi.s	TSCR_NoForce				; if there's still speed, branch
		moveq	#$00,d0					; move directly to position
		move.w	d0,(TSR_AngleCur).w			; ''

TSCR_NoForce:
		add.b	d3,d3					; skip left/right buttons
		add.b	d3,d3					; ''
		bra.w	TSCR_NoStopRot				; skip D-pad controls for rotation

TSCR_NoB:
		move.w	(TSR_AngleSpeed).w,d0			; load speed for rotating the angle
		move.w	d0,d1					; store for afterwards
		add.b	d3,d3					; get to D-pad buttons
		bpl.s	TSCR_NoRight				; if right was not held in MSB, branch
		addq.w	#TSCR_ACCEL,d0				; increase speed

TSCR_NoRight:
		add.b	d3,d3					; send left to MSB
		bpl.s	TSCR_NoLeft				; if left was not held, branch
		subq.w	#TSCR_ACCEL,d0				; decrease speed

TSCR_NoLeft:
		cmp.w	d1,d0					; has the speed changed?
		bne.s	TSCR_NoStopRot				; if so, branch (player is changing it, so don't slow down)
		asr.w	#$05,d1					; get fraction of the speed
		beq.s	TSCR_StopRot				; if it's now 0, branch
		sub.w	d1,d0					; decrease speed
		move.w	d0,d1					; copy new speed to d1
		addq.w	#$01,d1					; is it FFFF or 0000?
		cmpi.w	#$0001,d1				; ''
		bhi.s	TSCR_NoStopRot				; if not, branch

TSCR_StopRot:
		moveq	#$00,d0					; force speed to 0

TSCR_NoStopRot:
		move.w	d0,(TSR_AngleSpeed).w			; update speed
		tst.b	d2					; is flipping being reset to 00.00?
		bne.w	TSCR_RenderRotate			; if so, branch
		move.w	(TSR_FlipSpeed).w,d0			; load speed for flipping
		move.w	d0,d1					; store for afterwards
		add.b	d3,d3					; send down to MSB
		bpl.s	TSCR_NoDown				; if down was not held, branch
		addq.w	#TSCR_ACCFLIP,d0			; increase flip speed

TSCR_NoDown:
		add.b	d3,d3					; send down to MSB
		bpl.s	TSCR_NoUp				; if up was not held, branch
		subq.w	#TSCR_ACCFLIP,d0			; increase flip speed

TSCR_NoUp:
		cmp.w	d1,d0					; has the speed changed?
		bne.s	TSCR_NoStopFlip				; if so, branch (player is changing it, so don't slow down)
		asr.w	#$05,d1					; get fraction of the speed
		beq.s	TSCR_StopFlip				; if it's now 0, branch
		sub.w	d1,d0					; decrease speed
		move.w	d0,d1					; copy new speed to d1
		addq.w	#$01,d1					; is it FFFF or 0000?
		cmpi.w	#$0001,d1				; ''
		bhi.s	TSCR_NoStopFlip				; if not, branch

TSCR_StopFlip:
		moveq	#$00,d0					; force speed to 0

TSCR_NoStopFlip:
		move.w	d0,(TSR_FlipSpeed).w			; update flip speed

; ---------------------------------------------------------------------------
; Speed cap/render handler
; ---------------------------------------------------------------------------

TSCR_RenderRotate:
		move.w	(TSR_AngleSpeed).w,d0			; load speed for rotating the angle
		cmpi.w	#TSCR_MAXSPEED,d0			; has it passed the maximum speed?
		ble.s	TSCR_NoRightMax				; if not, branch
		move.w	#TSCR_MAXSPEED,d0			; force to maximum speed

TSCR_NoRightMax:
		cmpi.w	#-TSCR_MAXSPEED,d0			; has it passed the maximum speed?
		bge.s	TSCR_NoLeftMax				; if not, branch
		move.w	#-TSCR_MAXSPEED,d0			; force to maximum speed

TSCR_NoLeftMax:
		move.w	d0,(TSR_AngleSpeed).w			; update speed
		move.w	d0,d1					; get direction as 0 or 1
		add.w	d1,d1					; ''
		subx.w	d1,d1					; ''
		addq.w	#$01,d1					; ''
		move.b	(TSR_AngleDir).w,d2			; get the current direction bit
		move.b	d2,d3					; keep a copy of all other bits
		andi.b	#%00000001,d2				; get only direction bit
		cmp.b	d1,d2					; has the direction changed?
		beq.s	TSCR_SameDir				; if not, branch
		andi.b	#%11111110,d3				; change the direction bit
		or.b	d1,d3					; ''
		ori.b	#%10000000,d3				; set freeze mode on (no scrolling until it's had the chance to render the new direction)
		move.b	d3,(TSR_AngleDir).w			; save flags
		moveq	#$00,d0					; clear speed (no movement until after new frame has rendered)

TSCR_SameDir:
		add.w	d0,(TSR_AngleCur).w			; add to current position
		move.b	(TSR_AngleCur).w,d0			; reload angle quotient only
		lsl.w	#$04,d1					; subtract direction from angle (to rendering whichever direction ahead of time)
		subq.w	#$08,d1					; ''
		add.b	d1,d0					; ''
		addq.b	#$04,d0					; rotate half a scroll wedge
		andi.b	#$F8,d0					; keep in multiples of scroll wedges
		move.b	d0,(TSR_AngleDest).w			; save as destination angle for the roundel art
		cmp.b	(TSR_AnglePrev).w,d0			; has the roundel art angle changed?
		beq.w	TSCR_RenderFlip				; if not, branch
		move.b	d0,(TSR_AnglePrev).w			; update previous angle
		clr.w	(TSR_StripPos).w			; reset strip position
		st.b	(TSR_RDMA_Requ).w			; request a transfer
		tst.b	(TSR_AngleDir).w			; is the rotation frozen?
		bpl.s	TSCR_RenderFlip				; if so, branch
		st.b	(TSR_StripPos).w			; set to render reverse without switching buffers

TSCR_RenderFlip:
		move.w	(TSR_FlipSpeed).w,d0			; load flip speed
		cmpi.w	#-TSCR_MAXFLIP,d0			; is it going too fast backwards?
		bge.s	TSCR_FlipCapBack			; if not, branch
		move.w	#-TSCR_MAXFLIP,d0			; cap at maximum

TSCR_FlipCapBack:
		cmpi.w	#TSCR_MAXFLIP,d0			; is it going too fast forwards?
		ble.s	TSCR_FlipCapFront			; if not, branch
		move.w	#TSCR_MAXFLIP,d0			; cap at maximum

TSCR_FlipCapFront:
		move.w	d0,(TSR_FlipSpeed).w			; update flip speed
		add.w	d0,(TSR_FlipAngle).w			; rotate flipping
		move.b	(TSR_FlipAngle).w,d1			; load flip angle
		addi.b	#$40,d1					; rotate to get MSB correct
		andi.b	#$80,d1					; get only the flip side
		cmp.b	(TSR_FlipPrev).w,d1			; has it changed?
		beq.s	TSCR_NoFlip				; if not, branch
		ori.b	#$01,d1					; set to change the flip mappings (and lock controls)
		move.b	d1,(TSR_FlipPrev).w			; ''

	if FRAMESWITCH=1
		tst.b 	(TSR_SwitchPlate).w			; is the roundel meant to flip over?
		bpl.s	TSCR_NoFlipPlate			; if not, branch
		move.l	#TS_Sonic,d0				; set plate to Sonic
		cmp.l	(TSR_RDMA_Plate).w,d0			; is the plate already Sonic?
		bne.s	TSCR_SetPlate				; if not,  branch
		move.l	#TS_StarRoundel,d0			; set plate to star

TSCR_SetPlate:
		move.l	d0,(TSR_RDMA_Plate).w			; set plate
		move.b	#$02,(TSR_SwitchPlate).w		; set plate switch counter
		clr.w	(TSR_StripPos).w			; reset strip position

TSCR_NoFlipPlate:
	endif

TSCR_NoFlip:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank - Dull routine for advancing to next screen and so on (for other routines)
; ---------------------------------------------------------------------------

VB_Dull:
		movem.l	d0-a6,-(sp)				; store register data
		tst.b	(V_int_routine).w			; is the 68k ready?
		beq.w	VBDU_68kLate				; if not, branch
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as write only

		jsr	Poll_Controllers			; read controller data
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		DMA $0080, $C0000000, Normal_palette		; palette

VBDU_68kLate:
		moveq	#-1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as execute tracker
		sf.b	(V_int_routine).w			; clear V-blank flag
		movem.l	(sp)+,d0-a6				; restore register data
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to update the mask sprites in VRAM
; ---------------------------------------------------------------------------

VB_UpdateMask:
		move.w	(TSR_BoardPos).w,d0			; load boarder position
		subq.w	#$08,d0					; adjust position to the left side
		move.w	d0,d1					; copy to d1
		not.w	d0					; reverse tile direction
		andi.w	#$0078,d0				; keep within plane width
		lsr.w	#$02,d0					; divide by 8 then multiply by size of word
		lea	(TSR_MapBoarder).l,a1			; load boarder mappings
		adda.w	d0,a1					; advance to correct map tile
		andi.w	#$0007,d1				; get X pixel position
		addi.w	#$0080,d1				; adjust to left of screen
		move.w	d1,d2					; create one tile to the right position
		addq.w	#$08,d2					; ''
		swap	d1					; put both together
		move.w	d2,d1					; ''

		move.w	#$8F08,(a6)				; set to increment to next sprite every word

		move.l	#WriteVRAM(TSV_Sprites+$04),(a6)	; set to write to VRAM of sprites
		move.l	(a1),(a5)				; write VRAM tiles
		lea	$22(a1),a1				; ''
		move.l	(a1),(a5)				; ''
		lea	$22(a1),a1				; ''
		move.l	(a1),(a5)				; ''
		lea	$22(a1),a1				; ''
		move.l	(a1),(a5)				; ''

		move.l	#WriteVRAM(TSV_Sprites+$06),(a6)	; set to write to X position of sprites
		move.l	d1,(a5)					; write X positions
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''

		move.w	#$8F02,(a6)				; restore auto-incremenet
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Universal V-blank stuff
; ---------------------------------------------------------------------------

VBTS_Universal:

	; --- Rendering mask sprites to cover bug ---

		bsr.w	VB_UpdateMask

	; --- --- --- --- --- --- --- --- --- --- ---

  if FLIPMODE=0
		move.w	#$8F04,(a6)
	if ROUNDEL_HI=0
		DMA $01C0, WriteVRAM(TSV_HScroll+0), TSR_HScrollFG	; H-Scroll FG
		DMA $01C0, WriteVRAM(TSV_HScroll+2), TSR_HScrollBG	; H-Scroll BG
		DMA ($0028-2), $40000010, TSR_VScrollFG			; V-scroll FG
	else
		DMA $01C0, WriteVRAM(TSV_HScroll+2), TSR_HScrollFG	; H-Scroll FG
		DMA $01C0, WriteVRAM(TSV_HScroll+0), TSR_HScrollBG	; H-Scroll BG
		DMA ($0028-2), $40020010, TSR_VScrollFG			; V-scroll FG
	endif
		move.w	#$8F02,(a6)
		DMA $0280, WriteVRAM(TSV_Sprites), TSR_Sprites		; Sprites
		DMA $0080, $C0000000, Normal_palette			; palette
  else
		move.w	#$8F00|(4*8),(a6)
	if ROUNDEL_HI=0
		DMA ($01C0/8), WriteVRAM(TSV_HScroll+0), TSR_HScrollFG	; H-Scroll FG
		move.l	(TSR_BoardPos).w,d0
		move.l	#WriteVRAM(TSV_HScroll+2),(a6)
		addi.l	#$00010001,(TSR_BoardPos).w
		move.l	d0,(a5)
		move.l	d0,(a5)
		move.l	#WriteVRAM((TSV_HScroll+2+((224-(4*8))*4))),(a6)
		not.l	d0
		move.l	d0,(a5)
		move.l	d0,(a5)
	else
		DMA ($01C0/8), WriteVRAM(TSV_HScroll+2), TSR_HScrollFG	; H-Scroll FG
		move.l	(TSR_BoardPos).w,d0
		move.l	#WriteVRAM(TSV_HScroll+0),(a6)
		addi.l	#$00010001,(TSR_BoardPos).w
		move.l	d0,(a5)
		move.l	d0,(a5)
		move.l	#WriteVRAM((TSV_HScroll+0+((224-(4*8))*4))),(a6)
		not.l	d0
		move.l	d0,(a5)
		move.l	d0,(a5)
	endif
		move.w	#$8F02,(a6)
  endif

		cmpi.l	#MLTS_FadeOut,(TSR_Subroutines).w	; is the screen mode set to fading out?
		bne.w	VBTS_NoBlank				; if not, branch
		tst.b	(TSR_RoundelFin).w			; is the roundel finished rotating/scrolling?
		beq.s	VBTS_NoBlank				; if not, branch
		move.l	(TSR_BlankList).w,a0			; load current list address
		move.l	(TSR_BlankVRAM).w,d0			; load current VRAM write address
		bne.s	VBTS_ContinueBlank			; if a VRAM address has been set, branch
		subq.w	#$02,a0					; adjusting for add below (probably quicker than branching...

VBTS_NextEntry:
		addq.w	#$02,a0					; advance to next entry
		move.l	(a0)+,d0				; load new VRAM address
		bpl.s	VBTS_StartBlank				; if the list is not finished, branch
		move.l	#MLTS_Finish,(TSR_Subroutines).w	; set next routine
		bra.s	VBTS_NoBlank				; finish rendering

VBTS_StartBlank:
		move.l	d0,(TSR_BlankVRAM).w			; store DMA VRAM address
		move.l	(a0)+,(TSR_BlankSize).w			; load DMA size

VBTS_ContinueBlank:
		move.l	(a0),d1					; load position
		bmi.s	VBTS_NextEntry				; if this is the end of the list, branch
		clr.w	d1					; keep only the first word
		add.l	d1,d0					; change address
		addq.w	#$02,a0					; advance to next word for next time
		move.l	a0,(TSR_BlankList).w			; update list address
		move.w	#$8F20,(a6)				; set DMA size to 20
		move.l	(TSR_BlankSize).w,(a6)			; set DMA size
		move.l	#((((((TSR_BlankRAM&$FFFFFF)/$02)<<$08)&$FF0000)+(((TSR_BlankRAM&$FFFFFF)/$02)&$FF))+$96009500),(a6)
		move.w	#((((TSR_BlankRAM&$FFFFFF)/$02)>>$10)&$7F)+$9700,(a6)
		move.l	d0,(a6)					; set destination
		move.w	#$8F02,(a6)				; reset increment mode

VBTS_NoBlank:
		jmp	Poll_Controllers			; read controller data

VBTS_BlankList:	dc.l	SetDestDMA(TSV_Boarder)
		dc.l	SetSizeDMA($00E0/($20/2))
		dc.w	$0000,$0006,$0008,$000E,$0010,$0016,$0018,$001E
		dc.w	$0002,$0004,$000A,$000C,$0012,$0014,$001A,$001C
		dc.w	$FFFF

		dc.l	SetDestDMA(TSV_Logo)
		dc.l	SetSizeDMA($2880/($20/2))
		dc.w	$0000,$0006,$0008,$000E,$0010,$0016,$0018,$001E
		dc.w	$0002,$0004,$000A,$000C,$0012,$0014,$001A,$001C
		dc.w	$FFFF

		dc.l	SetDestDMA(TSV_Arrows)
		dc.l	SetSizeDMA($1A00/($20/2))
		dc.w	$0000,$0006,$0008,$000E,$0010,$0016,$0018,$001E
		dc.w	$0002,$0004,$000A,$000C,$0012,$0014,$001A,$001C
		dc.w	$FFFF

		dc.w	$FFFF

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank - Line-scroll
; ---------------------------------------------------------------------------

  if FLIPMODE=1

VB_LineScroll:
		move.w	#$8F02,(a6)				; force auto-increment back to normal
		movem.l	d0-d6/a0-a3,-(sp)			; store register data
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as write only

		tst.b	(V_int_routine).w			; is the 68k ready?
		beq.w	VBTS_68kLate				; if not, branch
		jsr	Poll_Controllers			; read controller data
		move.w	#$8F04,(a6)

	if ROUNDEL_HI=0
		DMA $01C0, WriteVRAM(TSV_HScroll+0), TSR_HScrollFG	; H-Scroll FG
		DMA $01C0, WriteVRAM(TSV_HScroll+2), TSR_HScrollBG	; H-Scroll BG
		DMA ($0028-2), $40000010, TSR_VScrollFG			; V-scroll FG
	else
		DMA $01C0, WriteVRAM(TSV_HScroll+2), TSR_HScrollFG	; H-Scroll FG
		DMA $01C0, WriteVRAM(TSV_HScroll+0), TSR_HScrollBG	; H-Scroll BG
		DMA ($0028-2), $40020010, TSR_VScrollFG			; V-scroll FG
	endif
		move.w	#$8F02,(a6)
		DMA $0280, WriteVRAM(TSV_Sprites), TSR_Sprites		; Sprites
		DMA $0080, $C0000000, Normal_palette			; palette
		bra.w	VBTS_68kLate				; continue to restoration
  endif

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank
; ---------------------------------------------------------------------------

VB_TitleScreen:
		move.w	#$8F02,(a6)				; force auto-increment back to normal
		movem.l	d0-d6/a0-a3,-(sp)			; store register data
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as write only

		tst.b	(V_int_routine).w			; is the 68k ready?
		beq.w	VBTS_68kLate				; if not, branch
		bsr.w	VBTS_Universal				; transfer universal stuff
	if FLIPMODE=1
		DMA $0280, WriteVRAM(TSV_Sprites), TSR_Sprites	; Sprites
		DMA $0080, $C0000000, Normal_palette		; palette
	endif
		bra.w	VBTS_68kLate				; continue to restoration

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank - for the plane transfering
; ---------------------------------------------------------------------------

VB_Mappings:
		move.w	#$8F02,(a6)				; force auto-increment back to normal
		movem.l	d0-d6/a0-a3,-(sp)			; store register data
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as write only
		tst.b	(V_int_routine).w			; is the 68k ready?
		beq.w	VBTS_68kLate				; if not, branch

	; --- Roundel DMA ---

		move.l	#$94079300,(a6)				; set DMA size
		move.l	(TSR_RDMA_Map).w,(a6)			; set DMA source
		move.l	#$977F4000|((TSV_PlaneRound+$80)&$3FFF),(a6) ; set DMA source and destination
		move.w	#(((TSV_PlaneRound+$80)>>$0E)&3)|$80,(a6)	; set findal DMA destination

	; --------------------

		bsr.w	VBTS_Universal				; transfer universal stuff
	if FLIPMODE=1
		DMA $003E, $C0420000, (Normal_palette+$42)	; palette
	endif
		bra.w	VBTS_68kLate				; continue to restoration

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank - for the art transfering
; ---------------------------------------------------------------------------

VB_Roundel:
		move.w	#$8F02,(a6)				; force auto-increment back to normal
		movem.l	d0-d6/a0-a3,-(sp)			; store register data
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as write only
		tst.b	(V_int_routine).w			; is the 68k ready?
		beq.w	VBTS_68kLate				; if not, branch

	; --- Roundel DMA ---

		move.l	(TSR_RDMA_Size).w,(a6)			; set DMA size
		move.l	#((((((TSR_RoundelArt&$FFFFFF)/$02)<<$08)&$FF0000)+(((TSR_RoundelArt&$FFFFFF)/$02)&$FF))+$96009500),(a6)
		move.w	#((((TSR_RoundelArt&$FFFFFF)/$02)>>$10)&$7F)+$9700,(a6)
		moveq	#$00,d0					; clear d0
		move.w	(TSR_RDMA_Dest).w,d0			; load VRAM destination
		lsl.l	#$02,d0					; convert to long-word write mode
		lsr.w	#$02,d0					; ''
		ori.w	#$4000,d0				; ''
		swap	d0					; ''
		tas.b	d0					; enable DMA bit
		move.l	d0,(a6)					; set DMA (transfer here)
		move.w	(TSR_RoundelSize).w,d0			; load size that was rendered
		add.w	d0,(TSR_RDMA_Dest).w			; advance roundel destination

	; --------------------

		bsr.w	VBTS_Universal				; transfer universal stuff
	if FLIPMODE=1
		DMA $003E, $C0420000, (Normal_palette+$42)	; palette
	endif

; ---------------------------------------------------------------------------
; Restoration and H-blank setup...
; ---------------------------------------------------------------------------

VBTS_68kLate:
		moveq	#-1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as execute tracker

  if LAGFLASH=1

	tst.b	(V_int_routine).w
	bne.s	VBDU_NoLagFlash
	move.l	#$C0000000,(a6)
	move.w	#$0EEE,(a5)

VBDU_NoLagFlash:

  endif
		sf.b	(V_int_routine).w			; clear V-blank flag
		movem.l	(sp)+,d0-d6/a0-a3			; restore register data

  if FLIPMODE=1

		move.w	#$8000|%00110100,(a6)				; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)

	; --------------------------------------
	; Doing a DMA of F words into VSRAM is just
	; slightly slower than a manual chain, this
	; is compared with the quickest DMA setup of
	; just giving it the lower byte size (93XX)
	; and destination (4000 0090), yet still
	; manual barely wins.
	; --------------------------------------

	if ROUNDEL_HI=0
		move.l	#$40080010,d7				; prepare V-scroll write value
	else
		move.l	#$400A0010,d7				; prepare V-scroll write value
	endif
		lea	(TSR_VScroll1).l,a4			; load V-scroll buffer 1
		tst.b	(TSR_FlipBuffer).w			; are we displaying buffer 1?
		beq.s	VNTS_Buffer1				; if so, branch
		lea	(TSR_VScroll2).l,a4			; load V-scroll buffer 2

VNTS_Buffer1:
		move.l	#HB_Roundel,(H_int_addr).w		; set address
		move.l	#$8A018F04,(a6)				; change auto-increment to skip every odd word
		move.l	d7,(a6)					; set VDP to VSRAM write mode

HB_Roundel:
		move.l	(a4)+,(a5)				; copy V-Scroll data for roundel
		move.l	(a4)+,(a5)				; ''
		move.l	(a4)+,(a5)				; ''
		move.l	(a4)+,(a5)				; ''
		move.l	(a4)+,(a5)				; ''
		move.l	(a4)+,(a5)				; ''
		move.l	(a4)+,(a5)				; ''
		move.w	(a4)+,(a5)				; ''
	;	cmpi.w	#$8000,(a4)				; is this the last one?
	;	beq.s	HB_Finish
		move.l	d7,(a6)					; set VDP to VSRAM write mode
	;	rte						; return

;HB_Finish:
	;	move.l	#NullRTE,(H_int_addr).w
	;	move.w	#$8000|%00100100,(a6)			; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)

  endif
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; A special V-blank to allow kosm to process during initialisation
; ---------------------------------------------------------------------------

	; This is to be used for decompressing KOS art, since we no longer
	; have nemesis to use, and kosinski doesn't have the ability to
	; decompress directly to VRAM.  Note, you cannot use S3K's V-blank
	; routines, or else the DMA transfers during them will transfer
	; sprite/scroll data into VRAM where we don't need/want it.

VB_TitleInit:
		movem.l	d0-a6,-(sp)				; store register data
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as write only

		jsr	Poll_Controllers			; read controller data
		jsr	Process_DMA_Queue			; perform DMA transfer (transfer KOS data most likely)
		moveq	#-1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as execute tracker

		sf.b	(V_int_routine).w			; clear V-blank flag
		movem.l	(sp)+,d0-a6				; restore register data
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to map a square of mappings to a plane
; ---------------------------------------------------------------------------

MapPlane:
		move.l	d0,(a6)					; set VDP address
		add.l	d4,d0					; advance to next line
		move.w	d1,d3					; get X

MP_NextX:
		move.w	(a1)+,d6				; load map tile
		beq.s	MP_NoAdjust				; if it's the transparent tile, branch
		add.w	d5,d6					; add adjustment

MP_NoAdjust:
		move.w	d6,(a5)					; write mappings to VRAM plane
		dbf	d3,MP_NextX				; repeat for all columns
		dbf	d2,MapPlane				; repeat for all rows
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup the sprite table for the arrow ring
; ---------------------------------------------------------------------------

TS_MapRoundel:
		lea	TS_MapList(pc),a2			; load mappings list
		move.w	(a2)+,d1				; load column

TSMR_NextColumn:
		lea	(a1),a0					; copy address to a0
		adda.w	(a2)+,a0				; advance to correct position

TSMR_DoColumn:
		move.w	d0,(a0)					; write map ID
		lea	$80(a0),a0				; advance to next line
		addq.w	#$01,d0					; increase map ID
		dbf	d1,TSMR_DoColumn			; repeat for all rows in the column
		move.w	(a2)+,d1				; load size
		bpl.s	TSMR_NextColumn				; if the list is not finished, branch
		rts						; return

	; --- Map column list ---

		;	Y count	X Pos

TS_MapList:	dc.w	$000A-1,$0480+$0C
		dc.w	$000E-1,$0380+$0E
		dc.w	$0012-1,$0280+$10
		dc.w	$0014-1,$0200+$12
		dc.w	$0016-1,$0180+$14
		dc.w	$0018-1,$0100+$16
		dc.w	$0018-1,$0100+$18
		dc.w	$001A-1,$0080+$1A
		dc.w	$001A-1,$0080+$1C
		dc.w	$001C-1,$0000+$1E
		dc.w	$001C-1,$0000+$20
		dc.w	$001C-1,$0000+$22
		dc.w	$001C-1,$0000+$24
		dc.w	$001C-1,$0000+$26
		dc.w	$001C-1,$0000+$28
		dc.w	$001C-1,$0000+$2A
		dc.w	$001C-1,$0000+$2C
		dc.w	$001C-1,$0000+$2E
		dc.w	$001C-1,$0000+$30
		dc.w	$001A-1,$0080+$32
		dc.w	$001A-1,$0080+$34
		dc.w	$0018-1,$0100+$36
		dc.w	$0018-1,$0100+$38
		dc.w	$0016-1,$0180+$3A
		dc.w	$0014-1,$0200+$3C
		dc.w	$0012-1,$0280+$3E
		dc.w	$000E-1,$0380+$40
		dc.w	$000A-1,$0480+$42
		dc.w	$FFFF					; end of list marker

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to flip the mappings for the roundel
; ---------------------------------------------------------------------------

TS_FlipMap:
		move.l	#$10001000,d1				; prepare flipping bits to change
		moveq	#$1C-1,d3				; set number of tiles vertically to flip
		lea	$80(a1),a1				; make adjustment for the "lea -$100(a1),a1" below

TSFM_NextRow:
		moveq	#($40/2)-1,d2				; number of tiles horizontally to flip
		lea	-$100(a1),a1				; go back to beginning and then up a single line

TSFM_NextColumn:
		move.l	(a0)+,d0				; load current mappings
		eor.l	d1,d0					; flip them
		move.l	d0,(a1)+				; save to new mappings
		dbf	d2,TSFM_NextColumn			; repeat for entire horizontal line
		dbf	d3,TSFM_NextRow				; repeat for all vertical lines
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to map a mask on the left of the mappings
; ---------------------------------------------------------------------------

TS_CreateMask:
		move.l	#$87FF87FF,d0				; prepare mask tiles
		moveq	#($1C-(4*2))-1,d1			; set number of tiles vertically to mask

TSCM_Create:
		move.l	d0,(a1)					; write mask tiles
		lea	$80(a1),a1				; advance to next row
		dbf	d1,TSCM_Create				; repeat until all left tiles in the black spot are masked
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup the sprite table for the arrow ring
; ---------------------------------------------------------------------------
HIDEGAP		=	$200	; extra shrink amount to hide the gaps around the roundel a little
; ---------------------------------------------------------------------------

TS_ArrowSprites:
	if HIDEARROWS=0
		moveq	#$00,d0					; clear d0
		addi.w	#$0200,(TSR_ArrowAngle).w		; increase angle
		move.b	(TSR_ArrowAngle).w,d0			; load angle
		add.w	d0,d0					; multiply by size of word
		lea	(SineTable).l,a0			; load sinewave table
		move.w	(a0,d0.w),d6				; load new multiplication distance
		addi.w	#$0100,d6				; keep positive
		add.w	d6,d6					; multiply to x800
		add.w	d6,d6					; ''
		addi.w	#($8000-($800+1))-HIDEGAP,d6		; adjust to be from 8000-7800 (or basically 1.0000 - 0.F000)
		lea	(TAS_SpriteData).l,a0			; load sprite data list
		lea	(TSR_Sprites+($08*8)).w,a1		; load sprite table
		move.w	#((TAS_SpriteData_End-TAS_SpriteData)/8)-1,d1 ; set size of list
		move.w	#$0080+(320/2),d2			; X position of sprites
		move.w	#$0080+(224/2),d3			; Y position of sprites
		moveq	#$08,d4					; reset link counter
		move.w	#(TSV_Arrows/$20)|$4000,d5		; prepare VRAM address of art

TAS_NextSprite:
		move.w	(a0)+,d0				; load Y position
		muls.w	d6,d0					; multiply the relative position by stretch amount
		add.l	d0,d0					; multiply to 1.0 (since we can only muls to 0.8)
		swap	d0					; get the quotient
		add.w	d3,d0					; adjust
		move.w	d0,(a1)+				; save to sprite table
		move.w	(a0)+,d0				; load shape/priority
		addq.b	#$01,d4					; increase priority link
		move.b	d4,d0					; set priority link
		move.w	d0,(a1)+				; save to sprite table
		move.w	(a0)+,d0				; load VRAM
		add.w	d5,d0					; adjust
		move.w	d0,(a1)+				; save to sprite table
		move.w	(a0)+,d0				; load X position
		muls.w	d6,d0					; multiply the relative position by stretch amount
		add.l	d0,d0					; multiply to 1.0 (since we can only muls to 0.8)
		swap	d0					; get the quotient
		add.w	d2,d0					; adjust
		move.w	d0,(a1)+				; save to sprite table
		dbf	d1,TAS_NextSprite			; repeat for all sprites
		sf.b	-$05(a1)				; clear last link
	endif
		rts						; return

	; --- Sprite list of the arrow ring ---

TAS_SpriteData:		;YYYY, SSPP, VVVV, XXXX
		dc.w	$FF80,$0D00,$0800,$FFE0
		dc.w	$FF80,$0200,$0808,$FFD8
		dc.w	$FF88,$0600,$080B,$FFC8
		dc.w	$FF8C,$0200,$0811,$FFC0
		dc.w	$FF90,$0800,$0814,$FFE0
		dc.w	$FF93,$0200,$0817,$FFB8
		dc.w	$FF98,$0700,$081A,$FFA8
		dc.w	$FFA0,$0300,$0822,$FFA0
		dc.w	$FFB0,$0300,$0826,$FF98
		dc.w	$FFB8,$0000,$082A,$FFA8
		dc.w	$FFB8,$0300,$082B,$FF90
		dc.w	$FFC0,$0000,$082F,$FFA0
		dc.w	$FFC0,$0300,$0830,$FF88
		dc.w	$FFD0,$0000,$0834,$FF98
		dc.w	$FFD8,$0300,$0835,$FF90
		dc.w	$FFD8,$0300,$0839,$FF80
		dc.w	$FFE0,$0300,$083D,$FF88
		dc.w	$FFF8,$0300,$0841,$FF80
		dc.w	$0000,$0300,$0845,$FF88
		dc.w	$0008,$0300,$0849,$FF90
		dc.w	$0018,$0100,$084D,$FF80
		dc.w	$0020,$0300,$084F,$FF88
		dc.w	$0028,$0700,$0853,$FF90
		dc.w	$0038,$0300,$085B,$FFA0
		dc.w	$0040,$0300,$085F,$FFA8
		dc.w	$0048,$0300,$0863,$FFB0
		dc.w	$0048,$0100,$0867,$FF98
		dc.w	$0055,$0200,$0869,$FFB8
		dc.w	$0058,$0000,$086C,$FFA0
		dc.w	$0060,$0000,$0876,$FFA8
		dc.w	$0068,$0E00,$0877,$FFD8
		dc.w	$0070,$0100,$0883,$FFF8
		dc.w	$0060,$0600,$086D,$FFC8
		dc.w	$005C,$0200,$0873,$FFC0
		dc.w	$0070,$0D00,$1000,$0000
		dc.w	$0068,$0200,$1008,$0020
		dc.w	$0068,$0800,$1014,$0008
		dc.w	$0060,$0600,$100B,$0028
		dc.w	$005C,$0200,$1011,$0038
		dc.w	$0055,$0200,$1017,$0040
		dc.w	$0048,$0700,$101A,$0048
		dc.w	$0040,$0300,$1022,$0058
		dc.w	$0030,$0300,$1026,$0060
		dc.w	$0040,$0000,$102A,$0050
		dc.w	$0028,$0300,$102B,$0068
		dc.w	$0038,$0000,$102F,$0058
		dc.w	$0020,$0300,$1030,$0070
		dc.w	$0028,$0000,$1034,$0060
		dc.w	$0008,$0300,$1035,$0068
		dc.w	$0008,$0300,$1039,$0078
		dc.w	$0000,$0300,$103D,$0070
		dc.w	$FFE8,$0300,$1041,$0078
		dc.w	$FFE0,$0300,$1045,$0070
		dc.w	$FFD8,$0300,$1049,$0068
		dc.w	$FFD8,$0100,$104D,$0078
		dc.w	$FFC0,$0300,$104F,$0070
		dc.w	$FFB8,$0700,$1053,$0060
		dc.w	$FFA8,$0300,$105B,$0058
		dc.w	$FFA0,$0300,$105F,$0050
		dc.w	$FF98,$0300,$1063,$0048
		dc.w	$FFA8,$0100,$1067,$0060
		dc.w	$FF93,$0200,$1069,$0040
		dc.w	$FFA0,$0000,$106C,$0058
		dc.w	$FF98,$0000,$1076,$0050
		dc.w	$FF80,$0E00,$1077,$0008
		dc.w	$FF80,$0100,$1083,$0000
		dc.w	$FF88,$0600,$106D,$0028
		dc.w	$FF8C,$0200,$1073,$0038
TAS_SpriteData_End:

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to cycle the arrow palete correctly
; ---------------------------------------------------------------------------

TS_ArrowPalette:
		moveq	#$00,d0					; clear d0
		move.b	(TSR_ArrCycPos).w,d0			; load position
		subq.b	#$04,d0					; decrease position
		bpl.s	TSAP_NoWrap				; if still running, branch
		moveq	#$04*4,d0				; reposition

TSAP_NoWrap:
		move.b	d0,(TSR_ArrCycPos).w			; update position
		move.l	TSAP_List(pc,d0.w),a2			; load list address
		lea	(Normal_palette+$42).w,a1		; load destination palette
	rept	$0F
		movea.w	(a2)+,a0				; load slot address
		move.w	(a0)+,(a1)+				; copy colours
	endm
		rts						; return

	; --- Animation list ---

TSAP_List:	dc.l	TSAP_Entry00
		dc.l	TSAP_Entry01
		dc.l	TSAP_Entry02
		dc.l	TSAP_Entry03
		dc.l	TSAP_Entry04

PPL function POS,(TSR_ArrowPal+POS)&$FFFF

TSAP_Entry00:	dc.w	PPL($02),PPL($04),PPL($06),PPL($08),PPL($0A),PPL($0C),PPL($0E),PPL($10),PPL($12),PPL($14),PPL($16),PPL($18),PPL($1A),PPL($1C),PPL($1E)
TSAP_Entry01:	dc.w	PPL($0A),PPL($02),PPL($04),PPL($06),PPL($08),PPL($14),PPL($0C),PPL($0E),PPL($10),PPL($12),PPL($1E),PPL($16),PPL($18),PPL($1A),PPL($1C)
TSAP_Entry02:	dc.w	PPL($08),PPL($0A),PPL($02),PPL($04),PPL($06),PPL($12),PPL($14),PPL($0C),PPL($0E),PPL($10),PPL($1C),PPL($1E),PPL($16),PPL($18),PPL($1A)
TSAP_Entry03:	dc.w	PPL($06),PPL($08),PPL($0A),PPL($02),PPL($04),PPL($10),PPL($12),PPL($14),PPL($0C),PPL($0E),PPL($1A),PPL($1C),PPL($1E),PPL($16),PPL($18)
TSAP_Entry04:	dc.w	PPL($04),PPL($06),PPL($08),PPL($0A),PPL($02),PPL($0E),PPL($10),PPL($12),PPL($14),PPL($0C),PPL($18),PPL($1A),PPL($1C),PPL($1E),PPL($16)

; ---------------------------------------------------------------------------
; A quicker version (this one cannot be special faded during...)
; ---------------------------------------------------------------------------

TS_ArrowPalette_Quick:
		lea	(Normal_palette+$42).w,a1		; load palette
		lea	(a1),a0					; copy to a0
	rept	3
		move.w	(a0)+,d0				; store rotated colour
		move.l	(a0)+,(a1)+				; shift colours down
		move.l	(a0)+,(a1)+				; ''
		move.w	d0,(a1)+				; save rotated colour to top
	endm
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to cycle the roundel's palette based on the rotation
; ---------------------------------------------------------------------------

  if FLIPMODE=1

TS_RoundelPal:
		moveq	#$00,d0					; clear d0
		move.b	(TSR_FlipAngle).w,d0			; load angle

	if FRAMESWITCH=1
		tst.b	(TSR_SwitchPlate).w			; is the plate going through a switching period?
		ble.s	TSRP_NoBlack				; if not, branch
		move.b	d0,d1
		andi.b	#$7F,d1
		subi.b	#$40,d1
		cmpi.b	#$01,d1
		bhi.s	TSRP_NoBlack
		moveq	#$00,d0
		bra.s	TSRP_Black

TSRP_NoBlack:
	endif
		neg.b	d0					; reverse direction (so that up is brighter)
		addi.b	#$40,d0					; adjust angle to ensure the bright side of sinewave is used
		ori.b	#$80,d0					; ''
		subi.b	#$40-($2E<<1),d0			; readjust (along with a slight adjustement to put the brightest part at an angle from top)
		bclr.l	#$00,d0					; divide by 2 (half angle is the brightness change) then multipl by size of word)
		lea	(SineTable).l,a2			; load position
		move.w	(a2,d0.w),d0				; ''
		subi.w	#$0100,d0				; reverse it
		neg.w	d0					; ''
		move.w	d0,d1					; get between 0 and 1E0
		add.w	d0,d0					; ''
		lsr.w	#$03,d1					; ''
		sub.w	d1,d0					; ''
		andi.w	#$FFE0,d0				; keep in multiples of 20

TSRP_Black:

	if ROUNDELDISPLAY=0
		lea	(TS_StarRounPal+2).l,a0
	elseif ROUNDELDISPLAY=1
		lea	(TS_SonicPal+2).l,a0
	elseif ROUNDELDISPLAY=2
		lea	(TS_LitPlanPal+2).l,a0
	elseif ROUNDELDISPLAY=3
		lea	(TS_SonicCDPal+2).l,a0
	endif

		lea	(TS_StarRounPal+2).l,a0			; use star roundel palette
	if FRAMESWITCH=1
		cmpi.l	#TS_StarRoundel,(TSR_RDMA_Plate).w	; is the star roundel being displayed?
		beq.s	TSRP_UseStarPal				; if so, branch
		lea	(TS_SonicPal+2).l,a0			; instead use Sonic's palette

TSRP_UseStarPal:
	endif
		adda.w	d0,a0					; advance to correct address
		lea	(Normal_palette+$62).w,a1		; load palette buffer
		move.w	(a0)+,(a1)+				; copy colours to buffer
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''



	if ROUNDELDISPLAY=0

		moveq	#$00,d1
	if FRAMESWITCH=1
		cmpi.l	#TS_StarRoundel,(TSR_RDMA_Plate).w	; is this the star roundel?
		bne.s	NoAlter					; if not, branch (no cycling for Sonic)
		tst.b	(TSR_SwitchPlate).w			; is the plate going through a switching period?
		bgt.s	NoChange				; if so, branch
	endif
		move.b	(TSR_GreenCycle).w,d1

		subq.b	#$01,(TSR_GreenCount).w		; decrease cycle counter
		bpl.s	NoChange
		move.b	#$01,(TSR_GreenCount).w
		tst.b	(TSR_GreenPol).w
		beq.s	OK1
		bra.s	OK2

Change:
		tst.b	(TSR_RoundelFin).w			; is the roundel finished (i.e. are we fading out)?
		beq.s	NoFinish				; if not, branch
		moveq	#$00,d1					; clear d1
		bra.s	NoChange				; keep palette at 0

NoFinish:

		not.b	(TSR_GreenPol).w
		addi.b	#$10,d1

OK1:
		addi.b	#$10,d1
		bcc.s	NoChange
		not.b	(TSR_GreenPol).w
		subi.b	#$10,d1

OK2:
		subi.b	#$10,d1
		bcs.s	Change

NoChange:
		move.b	d1,(TSR_GreenCycle).w

		move.b	(Normal_palette+$63).w,d0
		move.b	d0,d2
		andi.w	#$00E0,d0
		cmp.w	d1,d0
		bhi.s	NoAlter
		andi.b	#$0E,d2
		andi.b	#$E0,d1
		or.b	d1,d2
		move.b	d2,(Normal_palette+$63).w

NoAlter:
	endif
		rts						; return

  endif

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to scroll the logo in
; ---------------------------------------------------------------------------

TS_LogoScroll:
		lea	(TSR_LogoPos).w,a2			; load logo position address
		move.l	(a2),d0					; load even positions
		asr.l	#$03,d0					; subtract 1/8th the position
		cmpi.l	#$00000800,d0				; has the scrolling reached near enough finish?
		bgt.s	TSLS_NoFinishScroll			; if not, branch
		move.l	#MLTS_FadeArrows,(TSR_Subroutines).w	; move onto next routine
	if FLIPMODE=1
		move.w	#$8B00|%00000110,(a6)			; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)
		move.l	#VB_TitleScreen,(V_int_addr).w		; set V-blank routine
	endif
		rts						; return

TSLS_NoFinishScroll:
		sub.l	d0,(a2)					; ''
		move.l	$04(a2),d1				; load odd positions
		asr.l	#$03,d1					; subtract 1/8th the position
		sub.l	d1,$04(a2)				; ''
		move.l	(a2),d0					; interlace even/odd positions
		move.w	$04(a2),d0				; ''
		lea	(TSR_HScrollBG+(($40+($E*8))*2)).w,a1	; load bottom of logo where "BATTLE RACE" IS
		move.l	d0,d1					; prepare mass registers
		move.l	d0,d2					; ''
		move.l	d0,d3					; ''
		move.l	d0,d4					; ''
		move.l	d0,d5					; ''
		move.l	d0,d6					; ''
		move.l	d0,a0					; ''
		movem.l	d0-d6/a0,-(a1)				; set "BATTLE RACE" position
		movem.l	d0-d6/a0,-(a1)				; ''
		lea	-8*2(a1),a1				; skip to "SONIC 3" logo
		not.l	d0					; reverse position to other side
		move.w	$04(a2),d0				; ''
		not.w	d0					; ''
		move.l	d0,d1					; prepare mass registers
		move.l	d0,d2					; ''
		move.l	d0,d3					; ''
		move.l	d0,d4					; ''
		move.l	d0,d5					; ''
		move.l	d0,d6					; ''
		move.l	d0,a0					; ''
		movem.l	d0-d3,-(a1)				; set "SONIC 3" position
		movem.l	d0-d6/a0,-(a1)				; ''
		movem.l	d0-d6/a0,-(a1)				; ''
		movem.l	d0-d6/a0,-(a1)				; ''
		movem.l	d0-d6/a0,-(a1)				; ''
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to fade the arrow colours correctly
; ---------------------------------------------------------------------------

TS_FadeArrows:
		subq.b	#$01,(TSR_ArrFadeTime).w		; decrease delay timer
		bpl.s	TSFA_NoFade				; if still running, branch
		move.b	#$02,(TSR_ArrFadeTime).w		; reset delay timer
		moveq	#$00,d0					; clear d0
		move.b	(TSR_ArrowFade).w,d0			; load arrow fade position
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		move.l	TSFA_List(pc,d0.w),d0			; load list address
		bpl.s	TSFA_NoFinish				; if this isn't the end, branch
		move.l	#MLTS_FadeBoarder,(TSR_Subroutines).w	; move onto next routine
		rts						; return

TSFA_NoFinish:
		moveq	#$00,d4					; clear finish flag
		move.l	d0,a2					; set address
		move.w	(a2)+,d6				; load number of colours to do

TSFA_NextSlot:
		lea	(TSR_ArrowPal-$40).w,a0			; load holding palette location (will be copied to "normal" during cycle)
		lea	(Target_palette).w,a1			; load palette buffer
		adda.w	(a2),a0					; advance to correct slot
		adda.w	(a2)+,a1				; ''
		bsr.s	TS_FadeColour				; fade the colour in
		dbf	d6,TSFA_NextSlot			; repeat for all slots in the list
		tst.b	d4					; has this colour finished fading?
		bne.s	TSFA_NoFade				; if so, branch
		addq.b	#$01,(TSR_ArrowFade).w			; increase to next list (QQ.FF)

TSFA_NoFade:
		rts						; return

	; --- fade in list ---
	; To ensure that the bright colours fade in before the dark colours
	; this list will allow us to control each grade completely independentally
	; --------------------

TSFA_List:	dc.l	TSFA_Entry00
		dc.l	TSFA_Entry01
		dc.l	TSFA_Entry02
		dc.l	TSFA_Entry03
		dc.l	TSFA_Entry04
		dc.l	TSFA_Entry05
		dc.l	TSFA_Entry06
		dc.w	$FFFF					; End of list marker...

TSFA_Entry00:	dc.w	$0001-1
		dc.w	$0044

TSFA_Entry01:	dc.w	$0002-1
		dc.w	$0046
		dc.w	$004E

TSFA_Entry02:	dc.w	$0003-1
		dc.w	$0042
		dc.w	$0050
		dc.w	$0058

TSFA_Entry03:	dc.w	$0002-1
		dc.w	$0048
		dc.w	$004C

TSFA_Entry04:	dc.w	$0003-1
		dc.w	$004A
		dc.w	$0052
		dc.w	$005A

TSFA_Entry05:	dc.w	$0003-1
		dc.w	$0054
		dc.w	$0056
		dc.w	$005C

TSFA_Entry06:	dc.w	$0001-1
		dc.w	$005E

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to fade the colours to target palette
; ---------------------------------------------------------------------------

TS_FadePalette:
		moveq	#$00,d4					; clear finish flag

TSFP_NextColour:
		bsr.s	TS_FadeColour				; fade the current colour
		dbf	d6,TSFP_NextColour			; repeat for all colours
		rts						; return

	; --- Subroutine to fade a single colour ---

TS_FadeColour:
		move.b	(a0),d0					; load current colour
		cmp.b	(a1)+,d0				; has blue reached peak?
		bhs.s	TS_NoFadeBlue				; if so, branch
		addq.b	#$02,d0					; increase blue
		st.b	d4					; set as not finished fading yet

TS_NoFadeBlue:
		move.b	d0,(a0)+				; update blue
		move.b	(a0),d0					; load green/red
		move.b	d0,d2					; separate them
		andi.w	#$00E0,d0				; ''
		andi.w	#$000E,d2				; ''
		move.b	(a1)+,d1				; load destination green/red
		move.b	d1,d3					; separate them
		andi.w	#$00E0,d1				; ''
		andi.w	#$000E,d3				; ''
		cmp.w	d1,d0					; has green reached peak?
		bhs.s	TS_NoFadeGreen				; if so, branch
		addi.b	#$20,(a0)				; increase green
		st.b	d4					; set as not finished fading yet

TS_NoFadeGreen:
		cmp.b	d3,d2					; has red reached peak?
		bhs.s	TS_NoFadeRed				; if so, branch
		addq.b	#$02,(a0)				; increase red
		st.b	d4					; set as not finished fading yet

TS_NoFadeRed:
		addq.w	#$01,a0					; advance to next blue
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to fade the colours out
; ---------------------------------------------------------------------------

TS_FadeOutPal:
		moveq	#$00,d4					; clear finish flag

TSFOP_NextColour:
		bsr.s	TS_FadeColourOut			; fade the current colour
		dbf	d6,TSFOP_NextColour			; repeat for all colours
		rts						; return

	; --- Subroutine to fade out a single colour ---

TS_FadeColourOut:
		move.w	(a0),d0					; load colour
		subi.w	#$0200,d0				; decrease blue
		bcc.s	TSFC_Blue				; if blue is still fading, branch
		addi.w	#$0200,d0				; keep blue at black
		bra.s	TSFC_NoBlue				; continue over flag

TSFC_Blue:
		st.b	d4					; set as not finished fading yet

TSFC_NoBlue:
		subi.b	#$20,d0					; decrease green
		bcc.s	TSFC_Green				; if green is still fading, branch
		addi.b	#$20,d0					; keep green at black
		bra.s	TSFC_NoGreen				; continue over flag

TSFC_Green:
		st.b	d4					; set as not finished fading yet

TSFC_NoGreen:
		move.b	d0,d1					; copy to d1
		andi.b	#$0E,d1					; get only red
		beq.s	TSFC_Red				; if red is 0, branch
		subq.b	#$02,d0					; decrease red to black
		st.b	d4					; set as not finished fading yet

TSFC_Red:
		move.w	d0,(a0)+				; update colours
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to scroll the zig-zag boarders
; ---------------------------------------------------------------------------

	if FLIPMODE=0
TS_BoarderScroll:
		move.w	(TSR_BoardPos).w,d0			; load boarder's position
		addq.w	#$01,(TSR_BoardPos).w			; increase position for next frame
BOTTOMBOARDER	=	(2*224)-2
		lea	(TSR_HScrollBG+($40-2)).w,a1		; load top boarder scroll table area
		bsr.s	TSLS_DoBoarder				; do top boarder
		lea	BOTTOMBOARDER(a1),a1			; load bottom boarder scroll table area
		neg.w	d0					; reverse direction
						; continue to..	; do bottom boarder

TSLS_DoBoarder:
		move.w	d0,(a1)					; save position
		move.l	(a1),d0					; copy position to both words of register
		move.w	(a1)+,d0				; ''
		move.l	d0,d2					; mass copy to other registers
		move.l	d0,d3					; ''
		move.l	d0,d4					; ''
		move.l	d0,d5					; ''
		move.l	d0,d6					; ''
		move.l	d0,a0					; ''
		move.l	d0,a2					; ''
		movem.l	d0/d2-d6/a0/a2,-(a1)			; set boarder scroll positions
		movem.l	d0/d2-d6/a0/a2,-(a1)			; ''
		rts						; return
	endif

; ===========================================================================
; ---------------------------------------------------------------------------
; Scrolling H/V-scroll depending on angle
; ---------------------------------------------------------------------------

TS_RoundelScroll:
		move.w	(TSR_AngleCur).w,d0			; load angle
		move.b	(TSR_FlipAngle).w,d1			; load flip angle
		addi.b	#$40,d1					; get which side the roundel is displaying
		bpl.s	TSRS_NoFlipped				; if it's displaying the front side, branch
		not.w	d0					; reverse angle (going the other way now)

TSRS_NoFlipped:
		addi.w	#$0400,d0				; rotate left shifting into positive
		andi.w	#$07FF,d0				; keep within the scroll wedge
		subi.w	#$0400,d0				; rotate back to negative


		lsr.w	#$06-1,d0				; align (keeping fractions) x 2
		bclr.l	#$00,d0					; keep even
		lea	(TS_Sinewave).l,a0			; load position
		move.w	(a0,d0.w),d0				; ''
		ext.l	d0					; extend to long-word signed
		move.l	d0,d1					; keep a copy in d0 for V-scroll

	; --- V-scroll ---

		move.w	d1,d2					; copy for left start
		addi.w	#$00080000/(((224+$20)/2)*$80),d2	; adjust Y position correctly (doing it before muls so the add is "word", thus quicker).
		muls.w	#((224+$20)/2)*$80,d2			; multiply by width (plus an extra 10 on both sides as they spill over with H-scroll)
		swap	d1					; multiply by 10, then shift left by 7 (this way is quicker)
		ror.l	#$05,d1					; ''
		andi.w	#%1111100000000000,d1			; ''
	;	asl.l	#$08-1,d2				; multiply quotient into position (No need now as the muls has *$80 to do this)
		lea	(TSR_VScrollFG+$06-2).w,a1		; load V-scroll table starting from just outside of roundel
		move.w	d1,d3					; keep fractions
		move.w	d2,d4					; ''
		swap	d1					; get quotients
		swap	d2					; ''
		jsr	TSRS_Write-((((224+($20-$10))/$10)*6)+4) ; the +4 is so that the subtraction happens before the write for V-scroll~

	; --- H-scroll ---

		move.l	d0,d1					; copy to d1 (since the chain routine uses d1 instead...

		move.w	d1,d2					; copy for top start
	if FLIPMODE=0
		muls.w	#(224/2)*$80,d2				; multiply by size of half the roundel (to get the starting position on top)
		asl.l	#$08-1,d1				; multiply both to put quotient into place
		lea	(TSR_HScrollFG).w,a1			; load H-scroll table
	else
		lea	(TSRF_ScrollPos).l,a2			; load scroll position list
		moveq	#$00,d0					; load flip angle
		move.b	(TSR_FlipAngle).w,d0			; ''
		add.w	d0,d0					; load correct scroll list entry
		add.w	d0,d0					; ''
		move.l	(a2,d0.w),a2				; ''
		muls.w	(a2)+,d1				; multiply adder by V-scroll amount
		asl.l	#$03-1,d1				; multiply by 8 (minus 1 due to muls precision storage)

		muls.w	#((224/2)-(8/2))*$80,d2			; multiply by size of half the roundel (to get the starting position on top)
;		swap	d1					; multiply by 8, then shift left by 7 (this way is quicker)
;		ror.l	#$06,d1					; ''
;		andi.w	#%1111110000000000,d1			; ''
		lea	(TSR_HScrollFG).w,a1			; load H-scroll table
		adda.w	(a2)+,a1				; advance to correct starting point
	endif
	;	asl.l	#$08-1,d2				; multiply quotient into position (No need now as the muls has *$80 to do this)

		move.w	d1,d3					; keep fractions
		move.w	d2,d4					; ''
		swap	d1					; get quotients
		swap	d2					; ''


  if FLIPMODE=0
	rept	$E0
		move.w	d2,(a1)+				; write position
		sub.w	d3,d4					; subtract fraction
		subx.w	d1,d2					; subtract quotient
	endm
  else
		move.w	(a2)+,d0				; load jump distance
		jmp	TSRS_WriteH(pc,d0.w)			; jump to correct starting position

TSRS_WriteH:
	rept	$E0/8
		move.w	d2,(a1)+				; write position
		sub.w	d3,d4					; subtract fraction
		subx.w	d1,d2					; subtract quotient
	endm
  endif
TSRS_Write:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the V-scroll values for flipping
; ---------------------------------------------------------------------------

  if FLIPMODE=1

TS_RoundelFlip:
		lea	(TSR_VScroll1+(($E0/2)*$1E)).l,a2	; load V-scroll buffer 1
		tst.b	(TSR_FlipBuffer).w			; are we displaying buffer 1?
		bne.s	TSRF_Buffer1				; if not, branch
		lea	(TSR_VScroll2+(($E0/2)*$1E)).l,a2	; load V-scroll buffer 2

TSRF_Buffer1:
		lea	(TSRF_ScrollPos).l,a0
		moveq	#$00,d0
		move.b	(TSR_FlipAngle).w,d0
		add.w	d0,d0
		add.w	d0,d0
		move.l	(a0,d0.w),a0
		addq.w	#$06,a0

		lea	(TSR_VScrollFG+$06-2).w,a1		; load main V-scroll buffer

		move.w	#(($00E0/2)/4)-1,$1E(a1)		; set size to flush

TSRF_Next:
	rept	4
		move.l	(a0)+,d0				; load reposition value
		movem.l	$02(a1),d1-d6/a3			; load scroll positions in V-scroll RAM
		add.l	d0,d1					; reposition them
		add.l	d0,d2					; ''
		add.l	d0,d3					; ''
		add.l	d0,d4					; ''
		add.l	d0,d5					; ''
		add.l	d0,d6					; ''
		add.l	d0,a3					; ''
		movem.l	d1-d6/a3,-(a2)				; save to V-scroll buffer
		add.w	(a1),d0					; add final V-scroll value
		move.w	d0,-(a2)				; save to V-scroll buffer
	endm
		subq.w	#$01,$1E(a1)				; decrease counter
		bpl.w	TSRF_Next				; if not finished, branch
		not.b	(TSR_FlipBuffer).w			; change buffer
		rts						; return
  endif

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load roundel art
; ---------------------------------------------------------------------------

TS_RoundelArt:
	if FRAMESWITCH=1
		tst.b	(TSR_SwitchPlate).w			; is the plate going through a switching period?
		bgt.s	TSR_Transfer				; if so, branch
	endif
		tst.b	(TSR_RDMA_Requ).w			; has a transfer been requested?
		bne.s	TSR_Transfer				; if not, branch

		bclr.b	#$00,(TSR_FlipPrev).w			; has the flip rotation flipped over?
		beq.s	TSR_NoTransfer				; if not, branch
		subq.w	#$04,sp					; revert the "addq" for later on
		bra.w	SB_Flip					; update mappings to correct flip orientation

TSR_Transfer:
		move.l	#VB_Roundel,(V_int_addr).w		; set V-blank routine (to transfer art)
		lea	(TSR_RoundelArt).l,a1			; load art buffer address
		movea.l	(TSR_RDMA_Plate).w,a2			; load roundel plate/art to use
		move.b	(TSR_AngleDest).w,d0			; load angle

	if FRAMESWITCH=1
		tst.b	(TSR_SwitchPlate).w			; is the plate going through a switching period?
		ble.s	TSR_NoSwitchRoundel			; if not, branch
		btst.b	#$00,(TSR_SwitchPlate).w		; are we on the odd frame?
		bne.s	TSR_NoSwitchRoundel			; if not, branch
		move.b	(TSR_AnglePrev).w,d0			; use other angle

TSR_NoSwitchRoundel:
	endif
		addi.b	#$20,d0					; rotate by 45 degrees
		move.b	d0,d1					; keep a copy for later
		lsr.b	#$06-2,d0				; divide by 4 x 90 degrees, multiply by 4
		andi.w	#$000C,d0				; get only the 90 degree angles
		add.l	(a2,d0.w),a2				; advance to correct roundel plate/art position
		lsr.w	#$03-2,d1				; divide by 8 (multiply by 4)
		andi.w	#$001C,d1				; keep within the 90 degree section
		move.l	RenderList(pc,d1.w),a0			; load correct render list to use
		move.w	(TSR_StripPos).w,d0			; load strip render position
		bmi.s	RevserseDir				; if the roundel is going in reverse now, perform rendering without switching buffers...
		addq.w	#$04,(TSR_StripPos).w			; advance for next frame
		move.l	(a0,d0.w),a0				; load correct strip position left off from last frame
		jsr	(a0)					; run strip rendering routines
		move.w	a1,d0					; load buffer finish address
		sub.w	#TSR_RoundelArt&$FFFF,d0		; get size
		move.w	d0,(TSR_RoundelSize).w			; save size for V-blank
		lsr.w	#$01,d0					; divide by 2
		lea	(TSR_RDMA_Size).w,a0			; load DMA size
		movep.w	d0,$01(a0)				; write DMA size

TSR_NoTransfer:
		rts						; return

	; --- Render lists for 90 degrees ---

RenderList:	dc.l	RenderE0
		dc.l	RenderE8
		dc.l	RenderF0
		dc.l	RenderF8
		dc.l	Render00
		dc.l	Render08
		dc.l	Render10
		dc.l	Render18

	; --- When the roundel is reversing direciton ---
	; Because the art being rendered is done ahead of time to the
	; scrolling, when reversing direction, the same buffer must
	; be written to since the scrolling is on the same frame.
	; -----------------------------------------------

RevserseDir:
		move.b	(TSR_AngleDir).w,d0			; load buffer flag
		cmpi.w	#$8000,(TSR_StripPos).w			; is this a new render on the current frame?
		bne.s	RD_NoSameFrame				; if not, branch
		bchg.l	#$02,d0					; change buffer to current buffer being displayed

RD_NoSameFrame:
		andi.w	#$0004,d0				; ''
		move.w	#$0004,(TSR_StripPos).w			; skip over map switching
		move.w	BuffList(pc,d0.w),(TSR_RDMA_Dest).w	; load roundel art buffer to use
		move.l	#VB_TitleScreen,(V_int_addr).w		; set V-blank routine (NO TRANSFER)
		rts						; return

	; --- Switching mappings for different art buffer ---

SwitchBuffer:
		bchg.b	#$02,(TSR_AngleDir).w			; change buffer

SB_Flip:
		move.b	(TSR_AngleDir).w,d0			; load buffer flag
		andi.w	#$0004,d0				; ''
		lea	BuffList(pc,d0.w),a0			; load correct list
		move.b	(TSR_FlipAngle).w,d1			; load flip angle
		addi.b	#$40,d1					; get which side the roundel is displaying
		bpl.s	SB_NoFlipped				; if it's displaying the front side, branch
		addq.w	#$08,a0					; advance to upside down versions (it's the backside)

SB_NoFlipped:
		move.w	(a0)+,(TSR_RDMA_Dest).w			; set VRAM DMA position (for V-blank)
		move.b	(a0)+,(TSR_RDMA_Map+$01).w		; set mappings to transfer into plane
		move.b	(a0)+,(TSR_RDMA_Map+$03).w		; ''
		move.l	#VB_Mappings,(V_int_addr).w		; set V-blank routine (to transfer art)
		addq.w	#$04,sp					; skip return address
		rts						; return

BuffList:	dc.w	TSV_Roundel1, (TSR_RoundMap2>>1)&$FFFF	; Render to buffer 1, while mapping and displaying buffer 2
		dc.w	TSV_Roundel2, (TSR_RoundMap1>>1)&$FFFF	; Render to buffer 2, while mapping and displaying buffer 1
		dc.w	TSV_Roundel1, (TSR_RoundMap2F>>1)&$FFFF	; Render to buffer 1, while mapping and displaying buffer 2 (flipped)
		dc.w	TSV_Roundel2, (TSR_RoundMap1F>>1)&$FFFF	; Render to buffer 2, while mapping and displaying buffer 1 (flipped)

	; --- The lists themselves ---

		include	"Title Screen\Roundel\Matrix\RenderE0.asm"
		include	"Title Screen\Roundel\Matrix\RenderE8.asm"
		include	"Title Screen\Roundel\Matrix\RenderF0.asm"
		include	"Title Screen\Roundel\Matrix\RenderF8.asm"
		include	"Title Screen\Roundel\Matrix\Render00.asm"
		include	"Title Screen\Roundel\Matrix\Render08.asm"
		include	"Title Screen\Roundel\Matrix\Render10.asm"
		include	"Title Screen\Roundel\Matrix\Render18.asm"

FinishBuffer:
	if FRAMESWITCH=1
		subq.b	#$01,(TSR_SwitchPlate).w		; decrease plate switch counter
		ble.s	SB_NoStop				; if plate switching is not on or is finished, branch
		clr.w	(TSR_StripPos).w			; reset strip rendering to beginning again (for next frame)
		bra.s	SB_NoCap				; continue

SB_NoStop:
	scc.b	(TSR_SwitchPlate).w			; clear plate switching if it was off, otherwise keep it at FF
	;	bcc.s	SB_NoCap				; if plate switching is actually not on, branch
	;	sf.b	(TSR_SwitchPlate).w			; if plate switching was on and is finished, set to not on

SB_NoCap:
	endif
		andi.b	#%01111111,(TSR_AngleDir).w		; unfreeze scrolling (in case it was frozen before)
		sf.b	(TSR_RDMA_Requ).w			; clear request flag
		move.l	#VB_TitleScreen,(V_int_addr).w		; set V-blank routine (NO TRANSFER, FINISHED)
		addq.w	#$04,sp					; skip return address
		bset.b	#$01,(TSR_AngleDir).w			; set first run flag
		bne.s	FB_NoFinish				; if first run was already set, branch
		ori.b	#%10000000,(TSR_AngleDir).w		; reset freeze flag
		move.b	#$00,(TSR_AngleCur).w			; force angle to 00
		move.b	#$08,(TSR_AngleDest).w			; force destination angle to go right
		move.b	#$08,(TSR_AnglePrev).w			; ''
		clr.w	(TSR_StripPos).w			; reset strip position
		st.b	(TSR_RDMA_Requ).w			; request a transfer

FB_NoFinish:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Includes
; ---------------------------------------------------------------------------

TS_Palette:	binclude "Title Screen\Palette.bin"
TS_MapLogo:	binclude "Title Screen\Map Logo (20xE).eni"
TS_MapLogoJap:	binclude "Title Screen\Map Logo Jap (20x4).eni"
TS_MapBoarder:	binclude "Title Screen\Map Boarder (10x4).eni"
TS_ArtLogo:	binclude "Title Screen\Art Logo.kosm"
TS_ArtLogoJap:	binclude "Title Screen\Art Logo Jap.kosm"
TS_ArtBoarder:	binclude "Title Screen\Art Boarder.kosm"
TS_ArtArrows:	binclude "Title Screen\Art Arrows.kosm"

TS_Sinewave:	binclude "Title Screen\Roundel\Sinewave.bin"

  if ROUNDELDISPLAY=0
TS_StarRoundel:	binclude "Title Screen\Roundel\Bitmaps\Art Star Roundel.rou"
TS_StarRounPal:	binclude "Title Screen\Roundel\Bitmaps\Art Star Roundel.pal"
	if FRAMESWITCH=1
TS_Sonic:	binclude "Title Screen\Roundel\Bitmaps\Art Sonic.rou"
TS_SonicPal:	binclude "Title Screen\Roundel\Bitmaps\Art Sonic.pal"
	endif
  elseif ROUNDELDISPLAY=1
TS_Sonic:	binclude "Title Screen\Roundel\Bitmaps\Art Sonic.rou"
TS_SonicPal:	binclude "Title Screen\Roundel\Bitmaps\Art Sonic.pal"
  elseif ROUNDELDISPLAY=2
TS_LitPlanet:	binclude "Title Screen\Roundel\Bitmaps\Art Little Planet.rou"
TS_LitPlanPal:	binclude "Title Screen\Roundel\Bitmaps\Art Little Planet.pal"
  elseif ROUNDELDISPLAY=3
TS_SonicCD:	binclude "Title Screen\Roundel\Bitmaps\Art Sonic CD.rou"
TS_SonicCDPal:	binclude "Title Screen\Roundel\Bitmaps\Art Sonic CD.pal"
  endif
		even

  if FLIPMODE=1

TSRF_ScrollPos:	dc.l	VSl00,VSl01,VSl02,VSl03,VSl04,VSl05,VSl06,VSl07,VSl08,VSl09,VSl0A,VSl0B,VSl0C,VSl0D,VSl0E,VSl0F
		dc.l	VSl10,VSl11,VSl12,VSl13,VSl14,VSl15,VSl16,VSl17,VSl18,VSl19,VSl1A,VSl1B,VSl1C,VSl1D,VSl1E,VSl1F
		dc.l	VSl20,VSl21,VSl22,VSl23,VSl24,VSl25,VSl26,VSl27,VSl28,VSl29,VSl2A,VSl2B,VSl2C,VSl2D,VSl2E,VSl2F
		dc.l	VSl30,VSl31,VSl32,VSl33,VSl34,VSl35,VSl36,VSl37,VSl38,VSl39,VSl3A,VSl3B,VSl3C,VSl3D,VSl3E,VSl3F
		dc.l	VSl3F,VSl3F,VSl3E,VSl3D,VSl3C,VSl3B,VSl3A,VSl39,VSl38,VSl37,VSl36,VSl35,VSl34,VSl33,VSl32,VSl31
		dc.l	VSl30,VSl2F,VSl2E,VSl2D,VSl2C,VSl2B,VSl2A,VSl29,VSl28,VSl27,VSl26,VSl25,VSl24,VSl23,VSl22,VSl21
		dc.l	VSl20,VSl1F,VSl1E,VSl1D,VSl1C,VSl1B,VSl1A,VSl19,VSl18,VSl17,VSl16,VSl15,VSl14,VSl13,VSl12,VSl11
		dc.l	VSl10,VSl0F,VSl0E,VSl0D,VSl0C,VSl0B,VSl0A,VSl09,VSl08,VSl07,VSl06,VSl05,VSl04,VSl03,VSl02,VSl01
		dc.l	VSl00,VSl01,VSl02,VSl03,VSl04,VSl05,VSl06,VSl07,VSl08,VSl09,VSl0A,VSl0B,VSl0C,VSl0D,VSl0E,VSl0F
		dc.l	VSl10,VSl11,VSl12,VSl13,VSl14,VSl15,VSl16,VSl17,VSl18,VSl19,VSl1A,VSl1B,VSl1C,VSl1D,VSl1E,VSl1F
		dc.l	VSl20,VSl21,VSl22,VSl23,VSl24,VSl25,VSl26,VSl27,VSl28,VSl29,VSl2A,VSl2B,VSl2C,VSl2D,VSl2E,VSl2F
		dc.l	VSl30,VSl31,VSl32,VSl33,VSl34,VSl35,VSl36,VSl37,VSl38,VSl39,VSl3A,VSl3B,VSl3C,VSl3D,VSl3E,VSl3F
		dc.l	VSl3F,VSl3F,VSl3E,VSl3D,VSl3C,VSl3B,VSl3A,VSl39,VSl38,VSl37,VSl36,VSl35,VSl34,VSl33,VSl32,VSl31
		dc.l	VSl30,VSl2F,VSl2E,VSl2D,VSl2C,VSl2B,VSl2A,VSl29,VSl28,VSl27,VSl26,VSl25,VSl24,VSl23,VSl22,VSl21
		dc.l	VSl20,VSl1F,VSl1E,VSl1D,VSl1C,VSl1B,VSl1A,VSl19,VSl18,VSl17,VSl16,VSl15,VSl14,VSl13,VSl12,VSl11
		dc.l	VSl10,VSl0F,VSl0E,VSl0D,VSl0C,VSl0B,VSl0A,VSl09,VSl08,VSl07,VSl06,VSl05,VSl04,VSl03,VSl02,VSl01

VSl00:		binclude "Title Screen\Roundel\VScroll\VScroll00.bin"
VSl01:		binclude "Title Screen\Roundel\VScroll\VScroll01.bin"
VSl02:		binclude "Title Screen\Roundel\VScroll\VScroll02.bin"
VSl03:		binclude "Title Screen\Roundel\VScroll\VScroll03.bin"
VSl04:		binclude "Title Screen\Roundel\VScroll\VScroll04.bin"
VSl05:		binclude "Title Screen\Roundel\VScroll\VScroll05.bin"
VSl06:		binclude "Title Screen\Roundel\VScroll\VScroll06.bin"
VSl07:		binclude "Title Screen\Roundel\VScroll\VScroll07.bin"
VSl08:		binclude "Title Screen\Roundel\VScroll\VScroll08.bin"
VSl09:		binclude "Title Screen\Roundel\VScroll\VScroll09.bin"
VSl0A:		binclude "Title Screen\Roundel\VScroll\VScroll0A.bin"
VSl0B:		binclude "Title Screen\Roundel\VScroll\VScroll0B.bin"
VSl0C:		binclude "Title Screen\Roundel\VScroll\VScroll0C.bin"
VSl0D:		binclude "Title Screen\Roundel\VScroll\VScroll0D.bin"
VSl0E:		binclude "Title Screen\Roundel\VScroll\VScroll0E.bin"
VSl0F:		binclude "Title Screen\Roundel\VScroll\VScroll0F.bin"
VSl10:		binclude "Title Screen\Roundel\VScroll\VScroll10.bin"
VSl11:		binclude "Title Screen\Roundel\VScroll\VScroll11.bin"
VSl12:		binclude "Title Screen\Roundel\VScroll\VScroll12.bin"
VSl13:		binclude "Title Screen\Roundel\VScroll\VScroll13.bin"
VSl14:		binclude "Title Screen\Roundel\VScroll\VScroll14.bin"
VSl15:		binclude "Title Screen\Roundel\VScroll\VScroll15.bin"
VSl16:		binclude "Title Screen\Roundel\VScroll\VScroll16.bin"
VSl17:		binclude "Title Screen\Roundel\VScroll\VScroll17.bin"
VSl18:		binclude "Title Screen\Roundel\VScroll\VScroll18.bin"
VSl19:		binclude "Title Screen\Roundel\VScroll\VScroll19.bin"
VSl1A:		binclude "Title Screen\Roundel\VScroll\VScroll1A.bin"
VSl1B:		binclude "Title Screen\Roundel\VScroll\VScroll1B.bin"
VSl1C:		binclude "Title Screen\Roundel\VScroll\VScroll1C.bin"
VSl1D:		binclude "Title Screen\Roundel\VScroll\VScroll1D.bin"
VSl1E:		binclude "Title Screen\Roundel\VScroll\VScroll1E.bin"
VSl1F:		binclude "Title Screen\Roundel\VScroll\VScroll1F.bin"
VSl20:		binclude "Title Screen\Roundel\VScroll\VScroll20.bin"
VSl21:		binclude "Title Screen\Roundel\VScroll\VScroll21.bin"
VSl22:		binclude "Title Screen\Roundel\VScroll\VScroll22.bin"
VSl23:		binclude "Title Screen\Roundel\VScroll\VScroll23.bin"
VSl24:		binclude "Title Screen\Roundel\VScroll\VScroll24.bin"
VSl25:		binclude "Title Screen\Roundel\VScroll\VScroll25.bin"
VSl26:		binclude "Title Screen\Roundel\VScroll\VScroll26.bin"
VSl27:		binclude "Title Screen\Roundel\VScroll\VScroll27.bin"
VSl28:		binclude "Title Screen\Roundel\VScroll\VScroll28.bin"
VSl29:		binclude "Title Screen\Roundel\VScroll\VScroll29.bin"
VSl2A:		binclude "Title Screen\Roundel\VScroll\VScroll2A.bin"
VSl2B:		binclude "Title Screen\Roundel\VScroll\VScroll2B.bin"
VSl2C:		binclude "Title Screen\Roundel\VScroll\VScroll2C.bin"
VSl2D:		binclude "Title Screen\Roundel\VScroll\VScroll2D.bin"
VSl2E:		binclude "Title Screen\Roundel\VScroll\VScroll2E.bin"
VSl2F:		binclude "Title Screen\Roundel\VScroll\VScroll2F.bin"
VSl30:		binclude "Title Screen\Roundel\VScroll\VScroll30.bin"
VSl31:		binclude "Title Screen\Roundel\VScroll\VScroll31.bin"
VSl32:		binclude "Title Screen\Roundel\VScroll\VScroll32.bin"
VSl33:		binclude "Title Screen\Roundel\VScroll\VScroll33.bin"
VSl34:		binclude "Title Screen\Roundel\VScroll\VScroll34.bin"
VSl35:		binclude "Title Screen\Roundel\VScroll\VScroll35.bin"
VSl36:		binclude "Title Screen\Roundel\VScroll\VScroll36.bin"
VSl37:		binclude "Title Screen\Roundel\VScroll\VScroll37.bin"
VSl38:		binclude "Title Screen\Roundel\VScroll\VScroll38.bin"
VSl39:		binclude "Title Screen\Roundel\VScroll\VScroll39.bin"
VSl3A:		binclude "Title Screen\Roundel\VScroll\VScroll3A.bin"
VSl3B:		binclude "Title Screen\Roundel\VScroll\VScroll3B.bin"
VSl3C:		binclude "Title Screen\Roundel\VScroll\VScroll3C.bin"
VSl3D:		binclude "Title Screen\Roundel\VScroll\VScroll3D.bin"
VSl3E:		binclude "Title Screen\Roundel\VScroll\VScroll3E.bin"
VSl3F:		binclude "Title Screen\Roundel\VScroll\VScroll3F.bin"

;COUNTER := +8
;
;VSl40:		dc.w	$0000,$0000
;		rept	$E0/2
;		dc.l	((COUNTER&$FFFF)<<$10)|(COUNTER&$FFFF)
;COUNTER := COUNTER+2
;		endm
	endif

; ===========================================================================













