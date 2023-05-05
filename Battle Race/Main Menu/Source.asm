; ===========================================================================
; ---------------------------------------------------------------------------
; New Main Menu
; ---------------------------------------------------------------------------
	include	"Main Menu\Scroll Equates.asm"
; ---------------------------------------------------------------------------
EMM_StageList	=	LS_StageList			; long	; stage list (normal stages/mini-game/etc)
EMM_ScreenMode	=	LS_ScreenMode			; long	; screen mode (main menu/character select/options/level select/etc)
EMM_LevelHighlt	=	LS_LevelHighlight		; word	; current level selected/highlighted
EMM_MiniHighlt	=	LS_MiniHighlight		; word	; current mini level selected/highlighted
	; ^ More of the level selecteds are reversed, see constants.asm
EMM_OptSelect	=	LS_OptionsSelect		; byte	; current option being highlighted
EMM_OptionsBits	=	OptBits_Menu			; byte	; binary settings
EMM_SoundTest	=	LS_SoundTest			; byte	; NOW UNUSED....
EMM_MenuPos	=	LS_MenuPos			; byte	; current menu position slot being highlighted
; ---------------------------------------------------------------------------
VRAMART01	=	$6680				; 2AC0	; slot 1 VRAM art address
VRAMART02	=	$9140				; 2AC0	; slot 2 VRAM art address
; ---------------------------------------------------------------------------
EMM_PlaneData	=	$00FF0400			; 2000	; 1000 per plane
EMM_PlaneA	=	EMM_PlaneData			; 1000	; Plane A data
EMM_PlaneB	=	EMM_PlaneData+$1000		; 1000	; Plane B data

EMM_VScroll	=	$00FF3000+$200			; 0800	; V-Scroll buffer
EMM_HScroll	=	$00FF3800+$200			; 0800	; H-scroll buffer
EMM_VScrollA	=	$00FF4000+$200			; 0800	; V-Scroll double buffers
EMM_VScrollB	=	$00FF4800+$200			; 0800	; ''
EMM_WindowA	=	$00FF5000+$200			; 0800	; window double buffers
EMM_WindowB	=	$00FF5800+$200			; 0800	; ''

EMM_SwapRAM	=	$00FF6000			; 0F00	; a small space of RAM for the swap effect routines to use
EMM_Anim3	=	$00FF6FEC			; word	; animation counter for the number 3
EMM_ClearWindow	=	$00FF6FEE			; byte	; if the render bars subroutine should clear the window
EMM_Buffer	=	$00FF6FEF			; byte	; buffer flag
EMM_VScrollSlot	=	$00FF6FF0			; long	; address of V-scroll buffer to use
EMM_WindowSlot	=	$00FF6FF4			; long	; address of window to use
EMM_VScrollPrev	=	$00FF6FF8			; long	; previous address of V-scroll buffer to use
EMM_WindowPrev	=	$00FF6FFC			; long	; previous address of window to use

EMM_Level	=	$00FF7000			; word	; level selection (multiples of 4)
EMM_LevelCur	=	$00FF7002			; word	; current level (previous frame)
EMM_DisplaySlot	=	$00FF7004			; word	; current slot (previous frame)
EMM_ScrollSlot	=	$00FF7006			; word	; scroll position of slot (0000 or 0100 for plane Y position)
EMM_FrameData	=	$00FF7008			; 0008	; long-word addresses to data for flushing during V-blank
EMM_SwapRout	=	$00FF7018			; long	; address of swap effect routine
EMM_ScrollMain	=	$00FF701C			; long	; main scroll speed value for "EMM_Speed" (like a "seed")
EMM_Scroll1	=	$00FF7020			; long	; 1st scroll speed data
EMM_Scroll2	=	$00FF7030			; long	; 2nd scroll speed data
EMM_PalCyc1	=	EMM_Scroll1+$04			; long	; 1st palette cycle routine
EMM_PalCyc2	=	EMM_Scroll2+$04			; long	; 2nd palette cycle routine
EMM_PalTimers1	=	EMM_Scroll1+$08			; long	; 1st palette cycle timers
EMM_PalTimers2	=	EMM_Scroll2+$08			; long	; 2nd palette cycle timers
EMM_ArtCyc1	=	EMM_Scroll1+$0C			; long	; 1st art cycle routine
EMM_ArtCyc2	=	EMM_Scroll2+$0C			; long	; 2nd art cycle routine
EMM_ArtTimers1	=	EMM_Scroll1+$20			; long	; 1st art cycle timers
EMM_ArtTimers2	=	EMM_Scroll2+$20			; long	; 2nd art cycle timers
EMM_ScrExx1	=	EMM_Scroll1+$24			; long	; 1st scroll extra routine
EMM_ScrExx2	=	EMM_Scroll2+$24			; long	; 2nd scroll extra routine
EMM_ScrTimers1	=	EMM_Scroll1+$28			; long	; 1st scroll extra timers
EMM_ScrTimers2	=	EMM_Scroll2+$28			; long	; 2nd scroll extra timers

EMM_SpeedY_FG1	=	EMM_Scroll1+$40			; long	; 1st Y speed for FG
EMM_SpeedY_FG2	=	EMM_Scroll2+$40			; long	; 2nd Y speed for FG
EMM_SpeedY_BG1	=	EMM_Scroll1+$44			; long	; 1st Y speed for BG
EMM_SpeedY_BG2	=	EMM_Scroll2+$44			; long	; 2nd Y speed for BG
EMM_PosY_FG1	=	EMM_Scroll1+$48			; long	; 1st Y position for FG
EMM_PosY_FG2	=	EMM_Scroll2+$48			; long	; 2nd Y position for FG
EMM_PosY_BG1	=	EMM_Scroll1+$4C			; long	; 1st Y position for BG
EMM_PosY_BG2	=	EMM_Scroll2+$4C			; long	; 2nd Y position for BG

EMM_ExtTimers1    =    EMM_Scroll1+$60            ; long    ; 1st extended timer
EMM_ExtTimers2    =    EMM_Scroll2+$60            ; long    ; 2nd extended timer

EXTEND        =    EMM_ExtTimers1-EMM_ArtTimers1

EMM_OptionBoxY	=	$00FF7100			; word	; Y position of highlighter box in options menu
EMM_OptionDestY	=	$00FF7102			; word	; Y destination
EMM_OptionSine	=	$00FF7104			; word	; angle sinewave (for waving in/out)
EMM_OptionPos	=	$00FF7106			; word	; the actual sinewave position
EMM_OptionPos2	=	$00FF7108			; word	; '' (but for bottom corners)
EMM_OptionInOut =	$00FF710A			; long	; in/out position for the box
EMM_LevelPrev	=	$00FF710E			; word	; previous level that was highlighted
	; continue with 7100 - 7123 please~
EMM_Random	=	$00FF7124			; long	; a random number (constantly changes)
EMM_SpriteCount	=	$00FF7128			; byte	; sprite table count of next sprite to be written so far
EMM_StartLevel	=	$00FF7129			; byte	; a level starting flag
EMM_StartTimer	=	$00FF712A			; word	; start timer (to give the selection SFX time to play before fading...)
EMM_HoldTimer	=	$00FF712C			; word	; button holding timer
EMM_ArrowAngle	=	$00FF712E			; word	; angle/rotation
EMM_TitleCard	=	$00FF7130			; long	; main menu ASCII text address
EMM_TitlePrev	=	$00FF7134			; long	; previous main menu ASCII text
EMM_TitlePos	=	$00FF7138			; 0026	; position of title cards
EMM_ArrowPos	=	$00FF7200			; long	; arrow positions (for when they move in/out)
EMM_FirstEffect	=	$00FF7204			; byte	; first effect flag
EMM_PlayerLast	=	$00FF7205			; byte	; last player to touch the controller
EMM_ArtTransfer	=	$00FF7206			; 000C	; DMA transfer register data for art
EMM_UpdatePal	=	$00FF7212			; byte	; palette update flag
EMM_RunEffect	=	$00FF7213			; byte	; if an effect is set to run or is running
EMM_SlotLoaded	=	$00FF7214			; byte	; if a slot is currently loading (00 No | FF Yes)
EMM_ArrowStatus	=	$00FF7215			; byte	; if the arrows should move in/out (00 out | FF in )
EMM_OptionsChg	=	$00FF7216			; byte	; if the options has changed and needs art updating (00 no | FF yes)
EMM_OptionsTrs	=	$00FF7217			; byte	; if the options is getting an art update next frame (00 no | FF yes)
EMM_SlotID	=	$00FF7218			; byte	; what slot the level is using at this moment in time (00 = Slot 1 | FF = Slot 2)

EMM_LoadPlane	=	$00FF721A	; - F72F	; 0016	; plane data
EMM_DecPlane	=	$00FF7230			; byte	; decompress plane flag
EMM_GoMainMenu	=	$00FF7331			; byte	; if the main menu is set to go back to
EMM_MusicMM	=	$00FF7332			; byte	; if the main menu should replay its own music (options uses the same music, don't want to replay the tune again)
	; continue at 7232+ please~

	; --- Main Menu RAM ---

EMM_MainMenuRAM	=	$00FF7300

EMM_SpinnerPos	=	$00FF7300			; word	; spinner Y position QQQQ.DDDD
EMM_SpinnerWrap	=	$00FF7302			; word	; spinner wrap count (number of strings in barrel)
;EMM_MenuPos	=	$00FF7304			; byte	; Main Menu Y position
EMM_MenuSize	=	$00FF7305			; byte	; Main Menu number of entries
EMM_MenuDirect	=	$00FF7306			; byte	; menu direction moved
EMM_MenuForce	=	$00FF7307			; byte	; menu force position flag
EMM_FadeAmount	=	$00FF7308			; word	; QQ.DD transparent fade amount
EMM_CardPos	=	$00FF730A			; word	; card render position (when rendering a full card)
EMM_MenuPrev	=	$00FF730C			; byte	; Main Menu previous frame
EMM_MenuPosLast	=	$00FF730D			; byte	; Main Menu previous position
EMM_ColourBG	=	$00FF730E			; word	; backdrop colour that's meant to display
EMM_ZigZagPos	=	$00FF7310			; word	; Zig-Zag animation position/counter QQ.DD
EMM_ZigZagPrev	=	$00FF7312			; byte	; previous QQ position
EMM_ExitMenu	=	$00FF7313			; byte	; if the menu is being exited
EMM_ZigZagSpeed	=	$00FF7314			; word	; speed (so it can be slowed down before fading out)
EMM_MenuFadeSpd	=	$00FF7316			; byte	; speed of fading out
EMM_TransCount1	=	$00FF7317			; byte	; colour 1 position
EMM_TransCount2	=	$00FF7318			; byte	; colour 2 position
EMM_TransCount3	=	$00FF7319			; byte	; colour 3 position
EMM_TransPal	=	$00FF731A			; 0006	; transition colour RAM
EMM_CycleSpeed	=	$00FF7320			; byte	; cycle timer/speed
EMM_AllowSprite =	$00FF7321			; byte	; if the level select/options can load their sprites in
EMM_SpinRender	=	$00FF7322			; word	; spinner render position (for in/out transition)
EMM_CheatCount	=	$00FF7324			; byte	; cheat position counter (if negative, cheat is activated)
EMM_DesPos	=	$00FF7325			; byte	; description text position
EMM_DesCurrent	=	$00FF7326			; byte	; current description ID

EMM_Description	=	$00FF7400			; 00A0	; 28 bytes per line, 4 lines, word mappings of ASCII text

	; --- --- --- --- --- ---

EMM_SwapList	=	$00FF7F00			; size of number of swap lists we have (a memory system to prevent the same swap effect running twice)
EMM_ScrollSpeed	=	$FFFF8000				; Scroll speeds table
Scroll		=	EMM_ScrollSpeed&$FFFF
EMM_ScrExtra1	=	$FFFF8800			; 0400	; extra scroll table for slot 1
EMM_ScrExtra2	=	$FFFF8C00			; 0400	; extra scroll table for slot 2
EMM_ScrList1	=	$FFFF9000			; 0200	; extra scroll list (quicker for the engine)
EMM_ScrList2	=	$FFFF9400			; 0200	; ''
EMM_Huffman	=	$FFFF9800			; 0210	; Huffman and split data for Mundi compression

VBU_DisplayLag	=	0				; if 1, will display white flashes indicating lag
; ---------------------------------------------------------------------------

MainMenu:
		moveq	#-$1F,d0				; fade music out
		jsr	Play_Sound.w				; ''
		moveq	#0,d0
		jsr	Change_Music_Tempo.w			; slow music down
		clr.w	(Kos_decomp_queue_count).w		; clear kosinski decompression cue count
		jsr	Clear_KosM_Queue.w			; clear Kosinski Moduled decompression cue information
		jsr	Pal_FadeToBlack				; fade out to black

	sf.b	(EMM_GoMainMenu).l
	sf.b	(EMM_MusicMM).l

MM_ReturnMainMenu:

	; --- Setup/clearing ---

		move	#$2700,sr				; disable interrupts

		move.l	#NullRTE,(H_int_addr).w			; set H-blank routine
		move.l	#VB_TitleInit,(V_int_addr).w		; set V-blank routine


	tst.b	(EMM_GoMainMenu).l
	beq.s	MM_NoReturn00
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.w	#$8100|%00110100,(a6)			; disable display (faster to transfer data during display period)
		move.l	#$40000083,d0				; VRAM C000
		move.w	#$4000,d1				; size to clear
		jsr	ClearVDP				; clear VDP memory section

MM_NoReturn00:
	move.b	(EMM_GoMainMenu).l,d2
	bne.w	MM_Return00

		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.w	#$8000|%00010100,(a6)			; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)
		move.w	#$8100|%00110100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.w	#$8200|((($C000)>>$0A)&$FF),(a6)	; 00FE DCBA - Scroll Plane A Map Table VRam address
		move.w	#$8300|((($3000)>>$0A)&$FF),(a6)	; 00FE DCB0 / 00FE DC00 (20 H-resol) - Window Plane A Map Table VRam address
		move.w	#$8400|((($E000)>>$0D)&$FF),(a6)	; 0000 0FED - Scroll Plane B Map Table VRam address
		move.w	#$8500|((($6400)>>$09)&$FF),(a6)	; 0FED CBA9 / 0FED CBA0 (20 H-resol) - Sprite Plane Map Table VRam address
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
		move.w	#$9000|%00010001,(a6)			; 00VV 00HH - Plane Y Size (00-20|01-40|11-80) | Plane X size (00-20|01-40|11-80)
		move.w	#$9100|$00,(a6)				; 7654 3210 - Window Horizontal Position
		move.w	#$9200|$00,(a6)				; 7654 3210 - Window Vertical Position

		move.l	#$40000080,d0				; VRAM
		move.w	#$FFFF,d1				; size to clear
		jsr	ClearVDP				; clear VDP memory section

		move.l	#$40000090,d0				; VSRAM
		move.w	#$0080,d1				; size to clear
		jsr	ClearVDP				; clear VDP memory section

	; --- Clearing data ---

	moveq	#$00,d2

MM_Return00:
	move.b	(EMM_MusicMM).l,d3			; store music status
		moveq	#$00,d0					; clear d0

		lea	($00FF0000).l,a1			; load RAM to clear 0000 - 8FFF
		move.w	#($9C00/$04)-1,d1			; set size to clear

MM_ClearMainRAM:
		move.l	d0,(a1)+				; clear RAM
		dbf	d1,MM_ClearMainRAM			; repeat until section is clear
	move.b	d3,(EMM_MusicMM).l			; restore music status
	move.b	d2,(EMM_GoMainMenu).l
	bne.w	MM_Return01

		lea	(Sprite_table_input).w,a1		; load sprite table chains list
		move.w	#(($80*8)/$04)-1,d1			; set number of chains to clear (all 8 of them)

MM_ClearChains:
		move.l	d0,(a1)+				; clear list
		dbf	d1,MM_ClearChains			; repeat for all lists


		lea	(Object_RAM).w,a1			; load object RAM
		move.w	#($2000/$40)-1,d1			; set size to clear

MM_ClearObjects:
		move.l	d0,(a1)+				; clear object RAM
		dbf	d1,MM_ClearObjects			; repeat til done

		lea	($FFFFF700).w,a1			; load various variables RAM
		move.w	#($100/$04)-1,d1			; set size to clear

MM_ClearVars:
		move.l	d0,(a1)+				; clear variables
		dbf	d1,MM_ClearVars				; repeat til done

		lea	(Camera_RAM).w,a1			; load camera RAM
		move.w	#($100/$04)-1,d1			; set size to clear

MM_ClearCamera:
		move.l	d0,(a1)+				; clear camera position data
		dbf	d1,MM_ClearCamera			; repeat til cleared

		jsr	(Init_SpriteTable).l			; setup sprite table (place priority links, etc...)

	; --- Various variables that S3K clears in its own title screen ---

		move.w	d0,(Current_zone_and_act).w		; Clear zone/act index
		move.b	d0,(Water_full_screen_flag).w
		move.b	d0,(Water_flag).w			; Both water flags cleared

		move.b	d0,(Last_star_post_hit).w
	;	move.b	d0,(Special_bonus_entry_flag).w
		move.b	d0,(Debug_On).w
		move.w	d0,(Demo_mode_flag).w
		move.w	d0,($FFFFF634).w
		move.w	d0,(Competition_mode).w
		move.b	d0,(Level_started_flag).w
		move.b	d0,(Debug_mode_flag).w
		move.w	d0,(Competition_mode).w
		move.w	d0,($FFFFFFE4).w
		move.w	d0,($FFFFFFE6).w
		move.b	d0,($FFFFFFD4).w
		move.w	d0,(DMA_queue).w
		move.w	#DMA_queue,(DMA_queue_slot).w		; Clear DMA queue

; ---------------------------------------------------------------------------
; Gens disclaimer
; ---------------------------------------------------------------------------

	; --- Loading window/title card art here since I need it for the disclaimer ---

		; Note that the MainMenu palette has the gold/yellow colours that the window also needs

MM_Return01:
		lea	(Pal_MainMenu).l,a0			; load title card palette
		lea	(Normal_palette+$00).w,a1		; load buffer to dump palette to (line 3)
		lea	(Target_palette+$00).w,a2		; ''
		moveq	#($04*2)-1,d1				; set number of palette lines to load

MM_LoadMenuPal:
		move.l	(a0),(a1)+				; dump palette
		move.l	(a0)+,(a2)+				; ''
		move.l	(a0),(a1)+				; ''
		move.l	(a0)+,(a2)+				; ''
		move.l	(a0),(a1)+				; ''
		move.l	(a0)+,(a2)+				; ''
		move.l	(a0),(a1)+				; ''
		move.l	(a0)+,(a2)+				; ''
		dbf	d1,MM_LoadMenuPal			; repeat for all palette lines

		; Universal art...

	tst.b	(EMM_GoMainMenu).l
	bne.s	MM_Return02

		lea	(Art_Window).l,a1			; load window art
		move.w	#$3E00,d2				; ''
		jsr	Queue_Kos_Module.w			; ''
		lea	(Art_TitleCard).l,a1			; load title card art
		moveq	#$20,d2					; ''
		jsr	Queue_Kos_Module.w			; ''

		; Main Menu art...

MM_Return02:
		lea	(Art_Font).l,a1				; load main menu test art
		move.w	#$D000,d2				; ''
		jsr	Queue_Kos_Module.w			; ''
		lea	(Art_Frames).l,a1			; load frame art (spinner box, etc)
		move.w	#$66C0,d2				; ''
		jsr	Queue_Kos_Module.w			; ''
		lea	(Art_MenuText).l,a1			; load main menu description text
		move.w	#$D8A0,d2				; ''
		jsr	Queue_Kos_Module.w			; ''

	; --- Decompress Kos Module data ---

MM_DelayLoad:
		st.b	(V_int_routine).w			; set V-blank flag
		jsr	Process_Kos_Queue
		jsr	Wait_VSync
		jsr	Process_Kos_Module_Queue.w
		tst.l	(Kos_module_queue).w
		bne.s	MM_DelayLoad
		st.b	(V_int_routine).w			; set V-blank flag
		jsr	Wait_VSync
		move	#$2700,sr				; disable interrupts
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port

	; --- Window "3" mappings ---

	tst.b	(EMM_GoMainMenu).l
	bne.w	MM_Return03

		move.l	#$70000000,(a6)				; set VDP window address write mdoe
		move.l	#($3E00/$20)|(($3E00/$20)<<$10)|$80008000,d0 ; prepare map tile values
		move.w	#(($0E00/$04)/$04)-1,d2			; set size of window plane

MM_WriteWindow:
		move.l	d0,(a5)					; clear entire window space (write blank (black) tile map ID)
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		dbf	d2,MM_WriteWindow			; repeat until the entire plane is done

		move.l	#$71000000,d2				; write animated 3 top bar
		bsr.w	MM_WriteMappings3			; ''
		move.l	#$7B800000,d2				; write animated 3 bottom bar
		bsr.w	MM_WriteMappings3			; ''

MM_Return03:
		lea	(Map_Window).l,a0			; load window mappings
		lea	($FFFF0000).l,a1			; ''
		jsr	MunDec					; ''

	tst.b	(EMM_GoMainMenu).l
	bne.w	MM_MenuInit

		lea	($FFFF0000).l,a1			; map main logo
		move.l	#$75080000,d0				; ''
		moveq	#$20-1,d1				; ''
		moveq	#$0A-1,d2				; ''
		bsr.w	MapScreen				; ''

	; --- Gens Disclaimer ---

		; Make a copy of the mappings in Plane A...

		lea	($FFFF0000).l,a1			; map main logo
		move.l	#$40880003,d0				; ''
		moveq	#$20-1,d1				; ''
		moveq	#$0A-1,d2				; ''
		bsr.w	MapScreen				; ''

		lea	(GensDisclaim-1).l,a3			; load disclaimer text
		lea	($FFFF1000-$80).l,a1			; load RAM map address to load text strings (before transfer)
		move.w	#$0136+1,d5				; prepare VRAM address of text
		moveq	#-(1+1),d2				; set starting map height (will become 2-1)

MM_NextLine:
		lea	$80(a1),a1				; skip a tile line
		addq.w	#$01,a3					; skip to the next string
		addq.w	#$01,d2					; increase mapping height

MM_NextDisclaim:
		lea	(a1),a2					; load map address
		jsr	MM_RenderString				; render the current line
		addq.w	#$02,d2					; increase mapping height
		lea	$100(a1),a1				; advance to next line for next string
		tst.b	(a3)					; is there another line?
		bmi.s	MM_NextLine
		bne.s	MM_NextDisclaim				; if so, branch
		lea	($FFFF1000).l,a1			; map main logo
		move.l	#$46020003,d0				; ''
		moveq	#$40-1,d1				; ''
		bsr.w	MapScreen				; ''

		DMA	$0080, $C0000000, Normal_palette	; palette
		move.l	#VB_GensScreen,(V_int_addr).w		; set V-blank routine
		st.b	(V_int_routine).w			; set V-blank flag
		jsr	Wait_VSync				; wait for V-blank

		move.l	#$40000083,d0				; VRAM
		move.w	#$1000,d1				; size to clear
		jsr	ClearVDP				; clear VDP memory section

		tst.l	(EMM_ScreenMode).w			; is the screen mode set?
		bne.w	MM_LevelSelectInit			; if so, branch (go strait to level select)
		bra.w	MM_MenuInit				; continue

; ---------------------------------------------------------------------------
; Disclaimer screen text to display
; ---------------------------------------------------------------------------

GensDisclaim:	dc.b	"WE HAVE DETECTED THAT YOU ARE USING AN",$00
		dc.b	"EMULATOR KNOWN AS GENS",$00
		dc.b	$FF
		dc.b	"THIS EMULATOR IS UNABLE TO RUN THIS",$00
		dc.b	"ROM CORRECTLY AND YOU MUST USE ANOTHER",$00
		dc.b	"EMULATOR",$00
		dc.b	$FF
		dc.b	"WE APOLOGISE FOR THE INCONVENIENCE",$00
		dc.b	$00
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Gens V-blank display disclaimer
; ---------------------------------------------------------------------------

VB_GensScreen:
		move	#$2700,sr				; disable interrupts
		move.w	#$4E75,($FF0000).l			; write "rts" into RAM
		move.w	#$8100|%01110100,(a6)			; enable display
		jsr	($F70000).l				; jump to that RAM location (but a mirror which Gens cannot do)
		move.w	#$8100|%00110100,(a6)			; disable display

		moveq	#-1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as execute tracker
		sf.b	(V_int_routine).w			; set V-blank as done
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Main Menu
; ---------------------------------------------------------------------------
SPINPOS		=	$80		; vertical position where the menu spinner is
SPINSIZE	=	$40		; vertical size of spinner
SPINSCALE	=	$00000C00	; the scale perspective along the barrel
SPINVRAM	=	$6E2C0003	; plane B VRAM address of spinner
; ---------------------------------------------------------------------------
CARDVRAM1	=	$7A00	; - 93FF	; 1600 bytes
CARDVRAM2	=	$9000	; - A9FF	; 1600 bytes
CARDVRAM3	=	$A600	; - BFFF	; 1600 bytes
CARDVDP1	=	(((CARDVRAM1&$3FFF)<<$10)|((CARDVRAM1>>$0E)&$03)|$40000000)
CARDVDP2	=	(((CARDVRAM2&$3FFF)<<$10)|((CARDVRAM2>>$0E)&$03)|$40000000)
CARDVDP3	=	(((CARDVRAM3&$3FFF)<<$10)|((CARDVRAM3>>$0E)&$03)|$40000000)
; ---------------------------------------------------------------------------

MM_MenuInit:

	; --- Clearing main palette, since it's no longer needed ---
	; Colours are in "Target" current palette...

		move	#$2700,sr				; disable interrupts

;		lea	(EMM_MainMenuRAM).l,a0
;		moveq	#$00,d0
;		moveq	#($30/$04)-1,d1
;
;MM_ClearMenuRAM:
;		move.l	d0,(a0)+
;		dbf	d1,MM_ClearMenuRAM


		lea	(Normal_palette+$00).w,a1		; load buffer to dump palette to (line 3)
		moveq	#($04*2)-1,d1				; set number of palette lines to clear
		moveq	#$00,d0					; clear d0

MM_ClearPalette:
		move.l	d0,(a1)+				; clear palette
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		dbf	d1,MM_ClearPalette			; repeat until palette buffer is clear

		move.l	#$C0000080,d0				; CRAM
		move.w	#$0080,d1				; size to clear
		jsr	ClearVDP				; clear VDP memory section
		move.w	#$8100|%01110100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.w	#$8B00|%00000111,(a6)			; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)

		move.l	#NullRTE,(H_int_addr).w			; set H-blank routine
		move.l	#VB_MainMenu,(V_int_addr).w		; set V-blank routine

MM_MAPDUMP	=	$FFFF0400

		lea	(Map_Frames).l,a0			; load window mappings
		lea	(MM_MAPDUMP).l,a1			; ''
		jsr	MunDec					; ''
		move.l	#$80008000,d0				; force right side to be high plane
		or.l	d0,(MM_MAPDUMP+($26*2)+($10*$50)).l	; '' (So it displays infront of text)
		or.l	d0,(MM_MAPDUMP+($26*2)+($11*$50)).l	; ''
		or.l	d0,(MM_MAPDUMP+($26*2)+($12*$50)).l	; ''
		or.l	d0,(MM_MAPDUMP+($26*2)+($13*$50)).l	; ''
		or.l	d0,(MM_MAPDUMP+($26*2)+($14*$50)).l	; ''
		or.l	d0,(MM_MAPDUMP+($26*2)+($15*$50)).l	; ''
		or.l	d0,(MM_MAPDUMP+($26*2)+($16*$50)).l	; ''
		or.l	d0,(MM_MAPDUMP+($26*2)+($17*$50)).l	; ''
		or.l	d0,(MM_MAPDUMP+($26*2)+($18*$50)).l	; ''
		lea	(MM_MAPDUMP).l,a1			; map main logo
		move.l	#$40000003,d0				; ''
		moveq	#$28-1,d1				; ''
		moveq	#$1C-1,d2				; ''
		bsr.w	MapScreen				; ''

	; --- Subroutine to write the BG colour tile into Plane B fully ---

		move.l	#$11111111,d1				; prepare black pixels
		move.l	#$63E00001,(a6)				; set VRAM address (just after the side zig-zag animated tiles)
		move.l	d1,(a5)					; write blank tile
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''

		move.l	#$60000003,(a6)				; set VDP address
		move.w	#((($40*$40)/$02)/$04)-1,d0
		move.l	#$231F231F,d1				; prepare blank tile maps

MM_SetupBGColour:
		move.l	d1,(a5)					; write BG tiles to plane B
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		dbf	d0,MM_SetupBGColour			; repeat for all blank tiles

	; --- Setting up menu selection ---

		bsr.w	MM_LoadText				; load the text mappings

		lea	(EMM_VScroll).l,a2			; load V-scroll RAM
		moveq	#$00,d0					; clear d0
		moveq	#($50/4)-1,d1				; set size of V-scroll to clear

MM_ClearVScroll:
		move.l	d0,(a2)+				; clear V-scroll
		dbf	d1,MM_ClearVScroll			; repeat until done

		bsr.w	MM_SetupHScroll				; setup H-scroll to have the barrel roller's bend inside
		bsr.w	MM_SetupCardMaps			; setup the cards for transparency mappings

		DMA	$0380, $7C000002, EMM_HScroll		; hscroll transfer here (don't need to do it every frame =3)

	; --- BG Side Zig-Zag mappings ---

		move.l	#$60300003,d2				; prepare VDP address

		move.w	#$8F80,(a6)				; set increment to single plane line

		move.l	d2,(a6)					; set VDP plane B address
		addi.l	#$00020000,d2				; advance to next column
		move.l	#$231D331D,d1				; perpare Zig-Zag side tiles
		bsr.s	MM_WriteSideZag				; write tiles

	;	move.l	d2,(a6)					; set VDP plane B address
	;	addi.l	#$00020000,d2				; advance to next column
	;	move.l	#$031E131E,d1				; perpare Zig-Zag side tiles
	;	bsr.s	MM_WriteSideZag				; write tiles

		moveq	#$0F-1,d0
		move.l	#$031F031F,d1				; prepare blank tile maps

MM_SetupSideZag:
		move.l	d2,(a6)					; set VDP plane B address
		addi.l	#$00020000,d2				; advance to next column
		bsr.s	MM_WriteSideZag				; write tiles
		dbf	d0,MM_SetupSideZag			; repeat for all blank tiles
		bra.s	MM_SideZagDone				; finished...

MM_WriteSideZag:
		move.l	d1,(a5)					; write enough tiles in the BG plane to fill the space
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		move.l	d1,(a5)					; ''
		rts						; return

MM_SideZagDone:
		move.w	#$8F02,(a6)				; restore auto-increment mode

	lea	($FFFF0000).l,a1			; map main logo
	move.w	d1,(a1)					; first tile was transparent...  Changing to solid.
	move.l	#$62340003,d0				; ''
	moveq	#$20-1,d1				; ''
	moveq	#$0A-1,d2				; ''
	bsr.w	MapScreen				; ''



		lea	(EMM_Description).l,a1			; load description mappings
		move.l	#(($71A0/$20)<<$10)|($71A0/$20),d0	; prepare mappings
		moveq	#($A0/$04)-1,d1				; set size of mappings to transfer

MM_SetupDescript:
		move.l	d0,(a1)+				; set all map words to blank
		dbf	d1,MM_SetupDescript			; repeat until all done

	; --- Final Stuff ---

		bclr.b	#$07,(EMM_MusicMM).l			; clear reload flag
		bne.s	MM_NoPlayBGM				; if the flag was set, the music is already playing, so don't play again...
		moveq	#Mus_MainMenu,d0			; play main menu music
		jsr	Play_Sound.w				; ''

MM_NoPlayBGM:

		move.w	#$1000,(EMM_FadeAmount).l		; set fade amount to maximum
		st.b	(EMM_MenuPosLast).l			; set previous menu position to an impossible position
		st.b	(EMM_MenuPrev).l			; set previous frame position to an impossible position
		sf.b	(EMM_MenuForce).l			; force menu to direciton immediately
		clr.w	(EMM_CardPos).l				; reset card art position to beginning again
		move.w	#$0080,(EMM_ZigZagSpeed).l		; set default Zig-zag speed
		sf.b	(EMM_MenuFadeSpd).l			; clear fade speed timer

		sf.b	(EMM_ExitMenu).l			; clear exit flag

		lea	(Trans_Palette).l,a0			; load transparency palette
		lea	(EMM_TransPal).l,a1			; load palette RAM
		move.l	(a0)+,(a1)+				; copy the three colours over
		move.w	(a0),(a1)				; ''

		move.b	#($2A*0)+$00,(EMM_TransCount1).l	; set starting cycle palette table position for each colour
		move.b	#($2A*2)+$08,(EMM_TransCount2).l	; ''
		move.b	#($2A*1)+$10,(EMM_TransCount3).l	; ''

		sf.b	(EMM_CycleSpeed).l			; clear the cycle speed timer
		move.w	#(MMCS_Repos_End-MMCS_Repos)/2,(EMM_SpinRender).l ; set to not display the spinner at all
		sf.b	(EMM_AllowSprite).l			; prevent level select/options from being allowed to load sprites in yet
		sf.b	(EMM_GoMainMenu).l			; clear return flag

		move.b	#$14,(EMM_DesPos).l			; set starting description position (outside of screen at first)

		lea	(Target_palette+$20).w,a2		; load palette
		bsr.w	MM_TransPalette				; control transparency palette

MM_WaitCard:
		move.b	(EMM_MenuPos).l,d0			; load menu position
		cmp.b	(EMM_MenuPosLast).l,d0			; has last menu position been updated yet?
		beq.s	MM_CardLoaded				; if so, then the new card art has loaded, so branch
		pea	MM_WaitCard(pc)				; save return address
		st.b	(V_int_routine).w			; set V-blank flag
		jmp	Wait_VSync				; wait for V-blank (load card art)

MM_CardLoaded:
		jsr	Pal_FadeFromBlack			; fade into colour

; ---------------------------------------------------------------------------
; Main Menu loop
; ---------------------------------------------------------------------------

ML_MainMenu:
		subi.w	#($09)*$04,(EMM_SpinRender).l		; display spinner (9 per scanline)
		bpl.s	ML_NoSpinMaxDisplay			; if not finished, branch
		clr.w	(EMM_SpinRender).l			; keep at 0

ML_NoSpinMaxDisplay:
		lea	(Normal_palette+$20).w,a2		; load palette
		bsr.w	MM_TransPalette				; control transparency palette
		bsr.w	MM_ControlMenu				; read controls for menu
		bsr.w	MM_ControlSpinner			; rotate the spinner correctly
		bsr.w	MM_ControlDescription			; control what description text is displayed
		pea	ML_MainMenu(pc)				; save return address
		st.b	(V_int_routine).w			; set V-blank flag
		jmp	Wait_VSync				; wait for V-blank

; ---------------------------------------------------------------------------
; Subroutine to control the menu selection
; ---------------------------------------------------------------------------

MM_ControlMenu:
		bsr.w	MM_CheckCheat				; check for cheat input first

		move.b	(Ctrl_1_pressed).w,d2			; load player 1 pressed buttons
		or.b	(Ctrl_2_pressed).w,d2			; fuse player 2 pressed buttons with it
		move.b	d2,d1					; get only A, B, C and start buttons
		andi.b	#%11110000,d1				; ''
		beq.w	MMCM_NoStart				; if none were pressed, branch

		moveq	#$00,d0					; clear d0
		move.b	(EMM_MenuPos).l,d0			; load menu position
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		lea	(MM_MenuSelect).l,a0			; is the menu entry locked?
		tst.l	(a0,d0.w)				; ''
		bne.s	MMCM_NotLocked				; if not, branch

	tst.b	(EMM_CheatCount).l			; have the cheats been unlocked?
	bpl.s	MMCM_Locked				; if not, branch
	move.l	#MM_SpecialStage,(sp)			; ''
	move.l	#VB_MainMenuClear,(V_int_addr).w	; set new V-blank routine
	bra.w	MM_NoFinishMenu

MMCM_Locked:
		moveq	#$B2,d0					; make a buzzer sound
		jsr	Play_Sound_2.w				; ''
		bra.w	MMCM_NoStart				; continue as if start wasn't pressed

MMCM_NotLocked:
	st.b	(EMM_ExitMenu).l			; set menu exit flag
		moveq	#$63,d0					; play select sound
		jsr	Play_Sound_2.w				; ''
		addq.w	#$04,sp					; restore return address

ML_MainMenuFade:
		bsr.w	MM_ControlDescription			; control what description text is displayed
		subq.w	#$04,(EMM_ZigZagSpeed).l		; decrease zig-zag speed
		bpl.s	MLMMF_NoStop				; if it's not finished, branch
		clr.w	(EMM_ZigZagSpeed).l			; force not to move

MLMMF_NoStop:
		move.w	(EMM_SpinRender).l,d2			; load spin render position
		addi.w	#($09)*$04,d2				; render the spinner out (9 per scanline)
		cmpi.w	#(MMCS_Repos_End-MMCS_Repos)/2,d2	; is the spinner fully rendered out?
		bmi.s	MLMMF_NoOutSpinner			; if not, branch
		move.w	#(MMCS_Repos_End-MMCS_Repos)/2,d2	; force to maximum out rendering

MLMMF_NoOutSpinner:
		move.w	d2,(EMM_SpinRender).l			; update render position
		pea	ML_MainMenuFade(pc)			; save return address
		bsr.w	MM_ControlSpinner			; rotate the spinner correctly
		lea	(Normal_palette+$20).w,a2		; load palette
		bsr.w	MM_FadePalette				; control transparency palette
		bne.s	MM_NoFinishMenu				; if it hasn't finished fading, branch
		moveq	#$00,d0					; clear d0
		move.b	(EMM_MenuPos).l,d0			; load menu position
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		lea	(MM_MenuSelect).l,a0			; load menu selection routine
		move.l	(a0,d0.w),(sp)				; ''
		move.l	#VB_MainMenuClear,(V_int_addr).w	; set new V-blank routine

MM_NoFinishMenu:
		st.b	(V_int_routine).w			; set V-blank flag
		jmp	Wait_VSync				; wait for V-blank

MMCM_NoStart:
		move.b	(EMM_MenuPos).l,d1			; load menu position
		roxr.b	#$02,d2					; shift Up/Down buttons into MSB/carry
		bcc.s	MMCM_NoDown				; if down was not pressed, branch
		moveq	#$7E,d0					; play swipe sound
		jsr	Play_Sound_2.w				; ''
		sf.b	(EMM_MenuDirect).l			; set direction as moving down
		addq.b	#$01,d1					; increase menu down
		cmp.b	(EMM_MenuSize).l,d1			; has the option moved below all possible selections?
		bls.s	MMCM_NoWrap				; if not, branch
		moveq	#$00,d1					; force it to top selection

MMCM_NoWrap:
		tst.b	d2					; recheck up...

MMCM_NoDown:
		bpl.s	MMCM_NoUp				; if up was not pressed, branch
		moveq	#$7E,d0					; play swipe sound
		jsr	Play_Sound_2.w				; ''
		st.b	(EMM_MenuDirect).l			; set direction as moving up
		subq.b	#$01,d1					; decrease menu up
		bcc.s	MMCM_NoUp				; if it hasn't surpassed the top, branch
		move.b	(EMM_MenuSize).l,d1			; force to bottom

MMCM_NoUp:
		move.b	d1,(EMM_MenuPos).l			; update menu position
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to check if a cheat sequence is input
; ---------------------------------------------------------------------------

MM_CheckCheat:
		moveq	#$00,d0					; clear d0
		move.b	(EMM_CheatCount).l,d0			; load cheat counter/position
		bmi.s	MMCC_NoCheat				; if it's empty, branch (cheat completed already)
		move.b	(Ctrl_1_pressed).w,d2			; load player 1's pressed buttons
		andi.W	#%00001100,d2				; get only left/right buttons
		lea	MMCC_CheatList(pc),a0			; load list address
		bne.s	MMCC_Check				; if player 1 is pressing left or right, branch

MMCC_NoCheat:
		rts						; return

MMCC_Recheck:
		moveq	#$00,d0					; reset counter/position to beginning again

MMCC_Check:
		cmp.b	(a0,d0.w),d2				; has the player pressed the right key?
		bne.s	MMCC_Error				; if not, branch
		addq.b	#$01,d0					; increase counter
		move.b	d0,(EMM_CheatCount).l			; update counter
		tst.b	(a0,d0.w)				; is this the end of the cheat list?
		bne.s	MMCC_NoCheat				; if not, branch
		st.b	(EMM_CheatCount).l			; set cheat counter as complete
		moveq	#$00,d0					; reset museum entry ID

MMCC_UnlockMuseum:
		moveq	#%11000000,d1				; set to unlock museum item
		jsr	SaveSlot_Museum				; ''
		addq.b	#$01,d0					; increase entry ID
		cmpi.b	#$F0,d0					; have we unlocked all entries?
		bls.s	MMCC_UnlockMuseum			; if not, branch
		move.b	#$68,d0					; player unlock SFX
		jmp	Play_Sound.w				; ''

MMCC_Error:
		sf.b	(EMM_CheatCount).l			; reset cheat counter/position to beginning again
		tst.b	d0					; was the counter already at 0?
		bne.s	MMCC_Recheck				; if not, check if the button pressed is the first entry at least
		rts						; return

MMCC_CheatList:	dc.b	$04,$04,$04,$08,$08,$08,$04,$08,$00
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to set the palette to the correct transparency
; ---------------------------------------------------------------------------
MM_FadeSpeed	=	$0100		; QQ.DD
; ---------------------------------------------------------------------------
MMTP_CycleList:
	dc.w	$E00,$E00,$E00,$E00,$E00,$E00,$E00
	dc.w	$E00,$E20,$E40,$E60,$E80,$EA0,$EC0,$EE0,$CE0,$AE0,$8E0,$6E0,$4E0,$2E0
	dc.w	$0E0,$0E0,$0E0,$0E0,$0E0,$0E0,$0E0
	dc.w	$0E0,$0E2,$0E4,$0E6,$0E8,$0EA,$0EC,$0EE,$0CE,$0AE,$08E,$06E,$04E,$02E
	dc.w	$00E,$00E,$00E,$00E,$00E,$00E,$00E
	dc.w	$00E,$20E,$40E,$60E,$80E,$A0E,$C0E,$E0E,$E0C,$E0A,$E08,$E06,$E04,$E02
MMTP_CycleList_End:
; ---------------------------------------------------------------------------

MM_TransPalette:

	; --- The transition card cycling ---

	; To turn off palette cycling and just use the normal colours
	; simply skip to "MMTP_DelayCycle".

	;bra.w	MMTP_DelayCycle

		subq.b	#$01,(EMM_CycleSpeed).l			; decrease cycle timer
		bpl.s	MMTP_DelayCycle				; if still counting, branch
		move.b	#$05,(EMM_CycleSpeed).l			; reset delay timer

		lea	(EMM_TransCount1).l,a3			; load colour positions
		lea	MMTP_CycleList(pc),a1			; load cycle list
		lea	(EMM_TransPal).l,a0			; load transparency palette
		moveq	#$03-1,d5				; set number of colours to cycle
		moveq	#$00,d0					; clear d0

MMTP_NextCycle:
		move.b	(a3),d0					; load position
		subq.b	#$02,d0					; decrease to next colour
		bpl.s	MMTP_NoReset				; if not finished, branch
		move.b	#(MMTP_CycleList_End-MMTP_CycleList)-2,d0 ; reset to end of list

MMTP_NoReset:
		move.b	d0,(a3)+				; update position
		move.w	(a1,d0.w),(a0)+				; save colour to RAM
		dbf	d5,MMTP_NextCycle			; repeat for all cards

MMTP_DelayCycle:

	; --- The actual transparency fading ---

		move.w	(EMM_FadeAmount).l,d1			; load fade amount
		moveq	#$00,d0					; clear d0
		move.b	(EMM_MenuPosLast).l,d0			; load menu's last position
		cmp.b	(EMM_MenuPos).l,d0			; has it changed?
		beq.s	MMTP_NoChange				; if not, branch
		addi.w	#MM_FadeSpeed,d1			; increase fade amount
		cmpi.w	#$1000,d1				; has it reached maximum transparency now?
		blo.s	MMTP_UpdateFade				; if not, branch
		move.w	#$1000,d1				; force to maximum
		bra.s	MMTP_UpdateFade				; continue

MMTP_NoChange:
		subi.w	#MM_FadeSpeed,d1			; decrease fade amount
		bgt.s	MMTP_UpdateFade				; if it hasn't reached opaque, branch
		moveq	#$00,d1					; force to complete opaque

MMTP_UpdateFade:
		tst.b	d0					; is the previous position at an invalid position?
		bpl.s	MMTP_ValidPalette			; if not, branch
		moveq	#$00,d0					; just use the first palette then...

MMTP_ValidPalette:
		move.w	d1,(EMM_FadeAmount).l			; update fade amount
		lsl.w	#$03,d0					; multiply by size of entry in the table
		lea	(MM_CardList).l,a3			; load card list
		move.l	(a3,d0.w),a3				; load correct palette address

		lea	(EMM_TransPal).l,a0			; load transparency palette
		moveq	#$00,d2					; clear d2
		move.b	(EMM_FadeAmount).l,d2			; load fade amount
		clr.w	-(sp)					; create multiplication/division space
		moveq	#$03-1,d6				; set number of palette lines to do

MMTP_NextLine:
		addq.w	#$02,a2					; skip the transparent slot
		lea	(a3),a1					; load palette to fade to/fraom
		moveq	#$0F-1,d5				; set number of colours in the palette

MMTP_NextColour:
		move.b	(a0)+,d0				; load blue
		move.b	(a1)+,d1				; ''
		sub.b	d1,d0					; get distance
		move.b	d0,(sp)					; create x100 fraction
		move.w	(sp),d0					; ''
		asr.w	#$04,d0					; divide by 10
		muls.w	d2,d0					; multiply by fade amount (0 - 10)
		move.w	d0,(sp)					; get only quotient again
		move.b	(sp),d0					; ''
		add.b	d1,d0					; add base
		andi.b	#$0E,d0					; get only the blue
		move.b	d0,(a2)+				; save new blue amount
		move.b	(a0),d0					; load green
		move.b	(a1),d1					; ''
		lsr.b	#$04,d0					; ''
		lsr.b	#$04,d1					; ''
		sub.b	d1,d0					; get distance
		move.b	d0,(sp)					; create x100 fraction
		move.w	(sp),d0					; ''
		asr.w	#$04,d0					; divide by 10
		muls.w	d2,d0					; multiply by fade amount (0 - 10)
		move.w	d0,(sp)					; get only quotient again
		move.b	(sp),d0					; ''
		add.b	d1,d0					; add base
		lsl.b	#$04,d0					; get only the green
		andi.b	#$E0,d0					; ''
		move.b	d0,d3					; store for later (red & green go together)
		move.b	(a0),d0					; load red
		move.b	(a1)+,d1				; ''
		andi.b	#$0E,d0					; ''
		andi.b	#$0E,d1					; ''
		sub.b	d1,d0					; get distance
		move.b	d0,(sp)					; create x100 fraction
		move.w	(sp),d0					; ''
		asr.w	#$04,d0					; divide by 10
		muls.w	d2,d0					; multiply by fade amount (0 - 10)
		move.w	d0,(sp)					; get only quotient again
		move.b	(sp),d0					; ''
		add.b	d1,d0					; add base
		andi.b	#$0E,d0					; get only the red
		or.b	d0,d3					; fuse with the green
		move.b	d3,(a2)+				; save new amounts
		subq.w	#$01,a0					; go back to blue in transparent colour
		dbf	d5,MMTP_NextColour			; repeat for all colours in the line
		addq.w	#$02,a0					; advance to next transparent colour
		dbf	d6,MMTP_NextLine			; repeat for all lines
		addq.w	#$02,sp					; restore stack
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to fade the card palette
; ---------------------------------------------------------------------------

MM_FadePalette:
		moveq	#($10*3)-1,d6				; set number of colours/lines to do
		moveq	#($10*3)*3,d5				; set number of elements to reach 0
		subq.b	#$01,(EMM_MenuFadeSpd).l		; decrease fade speed
		bpl.s	MMFP_NoFade				; if still running, branch
		move.b	#$03,(EMM_MenuFadeSpd).l		; reset timer

MMFP_NextColour:
		subq.b	#$02,(a2)+				; decrease blue
		bcc.s	MMFP_NoFinishBlue			; if still counting, branch
		sf.b	-$01(a2)				; force blue to finish
		subq.b	#$01,d5					; decrease count

MMFP_NoFinishBlue:
		subi.b	#$20,(a2)				; decrease green
		bcc.s	MMFP_NoFinishGreen			; if still counting, branch
		andi.b	#$0E,(a2)				; force green to finish
		subq.b	#$01,d5					; decrease count

MMFP_NoFinishGreen:
		move.b	(a2),d0					; load red
		andi.b	#$0E,d0					; ''
		bne.s	MMFP_NoFinishRed			; if there's still red to decrease, branch
		addq.b	#$02,(a2)				; keep red at 0
		subq.b	#$01,d5					; decrease count

MMFP_NoFinishRed:
		subq.b	#$02,(a2)+				; decrease red
		dbf	d6,MMFP_NextColour			; repeat for all colours

MMFP_NoFade:
		tst.b	d5					; check remaining count
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control and rotate the spinner
; ---------------------------------------------------------------------------
SPINVSWIDTH	=	(9*2)
; ---------------------------------------------------------------------------

MM_ControlSpinner:
		move.w	(EMM_SpinnerWrap).l,d2			; load spinner size/wrap
		moveq	#$00,d0					; clear d0
		move.b	(EMM_MenuPos).l,d0			; load menu position
		lsl.w	#$04,d0					; multiply by size of character height (10 pixels)
		add.w	d2,d0					; ensure position is always positive
		bset.b	#$07,(EMM_MenuForce).l			; is the spinner forced to a specific direction?
		bne.s	MMCS_ForcePosition			; if not, branch
		move.w	d0,(EMM_SpinnerPos).l			; force to direction immediately
		bra.w	MMCS_RenderPos				; continue

MMCS_ForcePosition:
		sub.w	(EMM_SpinnerPos).l,d0			; minus current position
		beq.s	MMCS_RenderPos				; if it hasn't moved, branch
		bcc.s	MMCS_Down				; if it's not gone upwards, branch
		tst.b	(EMM_MenuDirect).l			; is the menu meant to go upwards?
		bne.s	MMCS_DirectionOK			; if so, branch
		add.w	d2,d0					; menu is going down, so the barrel must wrap (adding to ensure it'll continue going up)
		bra.s	MMCS_DirectionOK			; continue to render routine

MMCS_Down:
		tst.b	(EMM_MenuDirect).l			; is the menu meant to go down?
		beq.s	MMCS_DirectionOK			; if so, branch
		sub.w	d2,d0					; menu is going up, so the barrel must wrap (subtracting to ensure it'll continue going down)

MMCS_DirectionOK:
		asr.w	#$02,d0					; divide by 4 (smooth shifting)
		bne.s	MMCS_NoFin				; if there's no more movement, branch
		addq.w	#$01,d0					; nudge it to the slot

MMCS_NoFin:
		add.w	d0,(EMM_SpinnerPos).l			; add to move towards the selection

	; --- Now rendering the position ---

MMCS_RenderPos:
		move.w	(EMM_SpinnerPos).l,d0			; load spinner position
		move.w	d0,d1					; make a copy for the actual spinner's position itself
		subi.w	#$0018,d0				; shift position up for display
		add.w	d2,d0					; ensure position is always positive
		ext.l	d0					; extend to long-word signed
		ext.l	d1					; ''
		divu.w	d2,d0					; wrap within menu size
		divu.w	d2,d1					; ''
		swap	d0					; ''
		swap	d1					; ''
		add.w	d2,d1					; shift it into positive
		move.w	d1,(EMM_SpinnerPos).l			; update position (this will prevent it from reaching the 7FFF/8000 area)
		addi.w	#SPINPOS-$28,d0				; adjust position to the text mappings in plane
		lea	(EMM_VScrollA).l,a1			; write to buffer A
		tst.b	(EMM_ScrollSlot).l			; is V-blank accessing Buffer A?
		bne.s	MMCS_BufferA				; if not, branch
		lea	(EMM_VScrollB).l,a1			; write to buffer B instead

MMCS_BufferA:
		lea	MMCS_Repos(pc),a0			; load reposition data
		move.w	#(MMCS_Repos_End-MMCS_Repos)/2,d1	; number of scanlines for the menu
		sub.w	(EMM_SpinRender).l,d1			; minus spin render position
		beq.s	MMCS_NoDisplay				; if there's nothing to display, branch
		subq.w	#$01,d1					; decrease for dbf

MMCS_WriteVScroll:
		move.w	(a0)+,d2				; load reposition
		bmi.s	MMCS_inValid				; if it's FFFF, branch
		add.w	d0,d2					; add current barrel spinner's position
		move.w	d2,(a1)+				; save for H-blank later
		dbf	d1,MMCS_WriteVScroll			; repeat for all slots/scanlines
		bra.s	MMCS_NoDisplay				; continue to blanking routine

MMCS_inValid:
		clr.w	(a1)+					; force to not display anything (skewed section)
		dbf	d1,MMCS_WriteVScroll			; repeat for all slots/scanlines

MMCS_NoDisplay:
		move.w	(EMM_SpinRender).l,d1			; load spin rendering position
		beq.s	MMCS_NoBlank				; if there's nothing to blank out, branch
		moveq	#$00,d0					; clear d0
		subq.w	#$01,d1					; decrease for dbf

MMCS_ClearSection:
		move.w	d0,(a1)+				; force to not display anything (skewed section)
		dbf	d1,MMCS_ClearSection			; repeat for all slots/scanlines

MMCS_NoBlank:
		rts						; return

	; --- Pre-calculated Y reposition values ---

MMCS_Repos:	dc.w	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$000C
		dc.w	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$000C,$000D
		dc.w	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$000B,$000C,$000D
		dc.w	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$000A,$000B,$000D,$000E
		dc.w	$FFFF,$FFFF,$FFFF,$FFFF,$0009,$000A,$000C,$000D,$000E
		dc.w	$FFFF,$FFFF,$FFFF,$0008,$000A,$000B,$000C,$000D,$000F
		dc.w	$FFFF,$FFFF,$0008,$0009,$000A,$000B,$000D,$000E,$000F
		dc.w	$FFFF,$0007,$0008,$0009,$000B,$000C,$000D,$000E,$000F
		dc.w	$0007,$0008,$0009,$000A,$000B,$000C,$000D,$000E,$000F
		dc.w	$0007,$0008,$0009,$000A,$000B,$000C,$000D,$000E,$0010
		dc.w	$0008,$0009,$000A,$000B,$000C,$000D,$000E,$000F,$0010
		dc.w	$0008,$0009,$000A,$000B,$000C,$000D,$000E,$000F,$0010
		dc.w	$0009,$0009,$000A,$000B,$000C,$000D,$000E,$000F,$0010
		dc.w	$0009,$000A,$000B,$000B,$000C,$000D,$000E,$000F,$0010
		dc.w	$0009,$000A,$000B,$000C,$000C,$000D,$000E,$000F,$0010
		dc.w	$000A,$000A,$000B,$000C,$000D,$000D,$000E,$000F,$0010
		dc.w	$000A,$000B,$000B,$000C,$000D,$000D,$000E,$000F,$0010
		dc.w	$000A,$000B,$000B,$000C,$000D,$000D,$000E,$000F,$000F
		dc.w	$000A,$000B,$000C,$000C,$000D,$000D,$000E,$000F,$000F
		dc.w	$000B,$000B,$000C,$000C,$000D,$000D,$000E,$000E,$000F
		dc.w	$000B,$000B,$000C,$000C,$000D,$000D,$000E,$000E,$000F
		dc.w	$000B,$000B,$000C,$000C,$000D,$000D,$000E,$000E,$000F
		dc.w	$000B,$000B,$000C,$000C,$000D,$000D,$000D,$000E,$000E
		dc.w	$000B,$000B,$000C,$000C,$000C,$000D,$000D,$000E,$000E
		dc.w	$000B,$000B,$000C,$000C,$000C,$000D,$000D,$000D,$000E
		dc.w	$000B,$000B,$000C,$000C,$000C,$000D,$000D,$000D,$000D
		dc.w	$000B,$000B,$000C,$000C,$000C,$000C,$000D,$000D,$000D
		dc.w	$000B,$000B,$000C,$000C,$000C,$000C,$000C,$000C,$000D
		dc.w	$000B,$000B,$000B,$000C,$000C,$000C,$000C,$000C,$000C
		dc.w	$000B,$000B,$000B,$000B,$000C,$000C,$000C,$000C,$000C
		dc.w	$000B,$000B,$000B,$000B,$000B,$000B,$000B,$000C,$000C
		dc.w	$000B,$000B,$000B,$000B,$000B,$000B,$000B,$000B,$000B
		dc.w	$000B,$000B,$000B,$000B,$000B,$000B,$000B,$000B,$000B
		dc.w	$000B,$000B,$000B,$000B,$000B,$000B,$000B,$000B,$000A
		dc.w	$000B,$000B,$000B,$000B,$000B,$000B,$000A,$000A,$000A
		dc.w	$000B,$000B,$000B,$000B,$000A,$000A,$000A,$000A,$000A
		dc.w	$000B,$000B,$000B,$000B,$000A,$000A,$000A,$000A,$0009
		dc.w	$000B,$000B,$000B,$000A,$000A,$000A,$000A,$0009,$0009
		dc.w	$000B,$000B,$000B,$000A,$000A,$000A,$0009,$0009,$0009
		dc.w	$000B,$000B,$000B,$000A,$000A,$000A,$0009,$0009,$0008
		dc.w	$000C,$000B,$000B,$000A,$000A,$0009,$0009,$0009,$0008
		dc.w	$000C,$000B,$000B,$000A,$000A,$0009,$0009,$0008,$0008
		dc.w	$000C,$000B,$000B,$000A,$000A,$0009,$0009,$0008,$0008
		dc.w	$000C,$000B,$000B,$000A,$000A,$0009,$0009,$0008,$0007
		dc.w	$000C,$000B,$000B,$000A,$000A,$0009,$0008,$0008,$0007
		dc.w	$000C,$000C,$000B,$000A,$000A,$0009,$0008,$0008,$0007
		dc.w	$000D,$000C,$000B,$000A,$000A,$0009,$0008,$0008,$0007
		dc.w	$000D,$000C,$000B,$000B,$000A,$0009,$0008,$0008,$0007
		dc.w	$000D,$000C,$000C,$000B,$000A,$0009,$0008,$0008,$0007
		dc.w	$000D,$000D,$000C,$000B,$000A,$0009,$0008,$0008,$0007
		dc.w	$000E,$000D,$000C,$000B,$000A,$0009,$0008,$0008,$0007
		dc.w	$000E,$000D,$000C,$000B,$000B,$000A,$0009,$0008,$0007
		dc.w	$000F,$000E,$000D,$000C,$000B,$000A,$0009,$0008,$0007
		dc.w	$000F,$000E,$000D,$000C,$000B,$000A,$0009,$0008,$0007
		dc.w	$0010,$000F,$000E,$000D,$000B,$000A,$0009,$0008,$0007
		dc.w	$0010,$000F,$000E,$000D,$000C,$000B,$000A,$0008,$0007
		dc.w	$0011,$0010,$000F,$000D,$000C,$000B,$000A,$0009,$0008
		dc.w	$FFFF,$0011,$000F,$000E,$000D,$000C,$000A,$0009,$0008
		dc.w	$FFFF,$FFFF,$0010,$000F,$000D,$000C,$000B,$0009,$0008
		dc.w	$FFFF,$FFFF,$FFFF,$000F,$000E,$000D,$000B,$000A,$0009
		dc.w	$FFFF,$FFFF,$FFFF,$FFFF,$000F,$000D,$000C,$000A,$0009
		dc.w	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$000E,$000C,$000B,$0009
		dc.w	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$000D,$000B,$000A
		dc.w	$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$000C,$000B
MMCS_Repos_End:

; ---------------------------------------------------------------------------
; Old code used to realtime create the V-Scroll H-blank positions
; which are no longer required...
; ---------------------------------------------------------------------------


;		addq.w	#$01,(EMM_SpinnerPos).l
;
;		move.w	(EMM_SpinnerPos).l,d2			; load spinner position
;		ext.l	d2					; extend to long-word signed
;		divs.w	(EMM_SpinnerWrap).l,d2			; wrap within menu size
;		swap	d2					; '' (using the remainder)
;		move.w	d2,(EMM_SpinnerPos).l			; update position (this will prevent it from reaching the 7FFF/8000 area)
;		addi.w	#SPINPOS-$28,d2				; adjust position to the text mappings in plane
;		swap	d2					; convert to QQQQ.DDDD
;		clr.w	d2					; ''
;
;		lea	(EMM_VScrollA).l,a2			; write to buffer A
;		tst.b	(EMM_ScrollSlot).l			; is V-blank accessing Buffer A?
;		bne.s	MMCS_BufferA				; if not, branch
;		lea	(EMM_VScrollB).l,a2			; write to buffer B instead
;
;MMCS_BufferA:
;		lea	(a2),a1					; keep a copy for later
;		lea	(SineTable).l,a0			; load sinewave table
;		moveq	#SPINSIZE-1,d1				; number of scanlines for the menu
;
;	lea	($00FF0000).l,a3		; load H-scroll table (starting at correct location)
;	move.l	#$00080000,(a3)+
;	move.l	#$00070000,(a3)+
;	move.l	#$00060000,(a3)+
;	move.l	#$00050000,(a3)+
;	move.l	#$00040000,(a3)+
;	move.l	#$00040000,(a3)+
;	move.l	#$00030000,(a3)+
;	move.l	#$00020000,(a3)+
;	move.l	#$00020000,(a3)+
;	move.l	#$00010000,(a3)+
;	moveq	#$00,d0
;	move.w	#(SPINSIZE-($A*2))-1,d4
;
;OKOKOK:
;	move.l	d0,(a3)+
;	dbf	d4,OKOKOK
;	move.l	#-$00010000,(a3)+
;	move.l	#-$00020000,(a3)+
;	move.l	#-$00020000,(a3)+
;	move.l	#-$00030000,(a3)+
;	move.l	#-$00040000,(a3)+
;	move.l	#-$00040000,(a3)+
;	move.l	#-$00050000,(a3)+
;	move.l	#-$00060000,(a3)+
;	move.l	#-$00070000,(a3)+
;	move.l	#-$00080000,(a3)+
;	lea	($00FF0000).l,a3		; load H-scroll table (starting at correct location)
;
;		move.l	d2,$300(a3)
;
;	move.l	#-SPINSCALE*(SPINSIZE/2),d4			; prepare counter Y stretch (for top part)
;
;MMCS_CurveVScroll:
;		moveq	#$00,d0
;		move.w	#$0100,d0				; load reverse sinewave position
;		sub.w	(a0),d0					; ''
;	move.l	d0,d3
;	swap	d3
;	asr.l	#$08,d3
;	add.l	d3,d2
;		asr.l	#$08,d3
;		add.l	d3,d4
;	move.l	d2,d3
;	;sub.l	(a3)+,d3
;
;	rept	8+1
;	move.l	d3,(a2)
;	addq.w	#$02,a2
;	sub.l	d4,d3
;	endm
;
;	addi.l	#SPINSCALE,d4					; increase stretch down
;
;	;swap	d2
;	;move.w	d2,(a2)+
;	;move.w	d2,(a2)+
;	;move.w	d2,(a2)+
;	;move.w	d2,(a2)+
;	;move.w	d2,(a2)+
;	;move.w	d2,(a2)+
;	;move.w	d2,(a2)+
;	;move.w	d2,(a2)+
;	;move.w	d2,(a2)+
;	;swap	d2
;		asr.w	#$04+4,d0				; get fraction of distance
;		addq.w	#$02,d0					; add 2 (in-case the distance is 0)
;		add.w	d0,d0					; multiply by 2 (keep size of word)
;		adda.w	d0,a0					; advance to next sinewave slot
;		dbf	d1,MMCS_CurveVScroll			; repeat for all spinner scanlines
;
;	moveq	#$00,d0
;
;	lea	SPINVSWIDTH*0(a1),a2
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	lea	SPINVSWIDTH*1(a1),a2
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	move.w	d0,(a2)+
;	lea	SPINVSWIDTH*2(a1),a2
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	lea	SPINVSWIDTH*3(a1),a2
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	move.w	d0,(a2)+
;	lea	SPINVSWIDTH*4(a1),a2
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	lea	SPINVSWIDTH*5(a1),a2
;	move.l	d0,(a2)+
;	move.w	d0,(a2)+
;	move.l	d0,SPINVSWIDTH*6(a1)
;	move.w	d0,SPINVSWIDTH*7(a1)
;
;DERP0	= (SPINSIZE-0)
;DERP1	= (SPINSIZE-1)
;DERP2	= (SPINSIZE-2)
;DERP3	= (SPINSIZE-3)
;DERP4	= (SPINSIZE-4)
;DERP5	= (SPINSIZE-5)
;DERP6	= (SPINSIZE-6)
;DERP7	= (SPINSIZE-7)
;
;
;	lea	SPINVSWIDTH*DERP0(a1),a2
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	lea	SPINVSWIDTH*DERP1(a1),a2
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	move.w	d0,(a2)+
;	lea	SPINVSWIDTH*DERP2(a1),a2
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	lea	SPINVSWIDTH*DERP3(a1),a2
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	move.w	d0,(a2)+
;	lea	SPINVSWIDTH*DERP4(a1),a2
;	move.l	d0,(a2)+
;	move.l	d0,(a2)+
;	lea	SPINVSWIDTH*DERP5(a1),a2
;	move.l	d0,(a2)+
;	move.w	d0,(a2)+
;	move.l	d0,SPINVSWIDTH*DERP6(a1)
;	move.w	d0,SPINVSWIDTH*DERP7(a1)
;
;
;	lea	($00FF0300).l,a3
;	move.l	(a3),d2
;	swap	d2
;		moveq	#SPINSIZE-1,d1				; number of scanlines for the menu
;
;NNNNNN:
;	rept	8+1
;	move.w	(a1)+,d0
;	sub.w	d2,d0
;	move.w	d0,(a3)+
;	endm
;	dbf	d1,NNNNNN
;		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank - Main Menu
; ---------------------------------------------------------------------------

VBMM_TransferDescript:
		move.l	#$96009500|(((EMM_Description>>1)&$FF00)<<8)|((EMM_Description>>1)&$00FF),(a6)	; set DMA source address
		move.l	#$97009400|((EMM_Description>>1)&$7F0000),(a6)	; set DMA source and upper size

		move.w	#$9314,(a6)				; set to transfer 14 characters
		move.l	#$4B800083,(a6)				; transfer line 1
		move.w	#$9314,(a6)				; set to transfer 14 characters
		move.l	#$4C000083,(a6)				; transfer line 2
		move.w	#$9314,(a6)				; set to transfer 14 characters
		move.l	#$4C800083,(a6)				; transfer line 3
		move.w	#$9314,(a6)				; set to transfer 14 characters
		move.l	#$4D000083,(a6)				; transfer line 4
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank - Main Menu
; ---------------------------------------------------------------------------

VB_MainMenu:
		move.w	#$8F02,(a6)
		tst.b	(V_int_routine).w			; was the 68k on time?
		beq.w	VBMM_68kLate				; if not, branch
		movem.l	d0-a6,-(sp)				; store register data
		lea	($C00000).l,a5				; set VDP registers
		lea	$04(a5),a6				; ''

		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as write only
		jsr	Poll_Controllers			; read controls (stupid name "poll", I should find the morron who decided that, and kick him in the gonads...)

VBMMC_Continue:
		bsr.w	VBMM_TransferDescript			; transfer the description

	;DMA	$0280, $78000002, Sprite_table_buffer	; sprites
	;DMA	$0380, $7C000002, EMM_HScroll		; hscroll (perhaps I could remove this after a single transfer?)
		DMA	$0050, $40000010, EMM_VScroll		; vscroll
		DMA	$0080, $C0000000, Normal_palette	; palette
		bsr.w	VBMM_CardFull				; load card art correctly
		bsr.w	VBMM_ZigZag				; perform Zig-Zag animation
		movem.l	(sp)+,d0-a6				; restore register data
		sf.b	(V_int_routine).w			; clear V-blank flag

VBMM_68kLate:
		move.w	d0,-(sp)
		move.b	#-1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as execute tracker
		move.w	d0,(sp)+

		move.l	#EMM_VScrollA,a4			; set V-scroll table A
		not.b	(EMM_ScrollSlot).l
		beq.s	VBMM_BufferA
		move.l	#EMM_VScrollB,a4			; set V-scroll table B

VBMM_BufferA:
		move.w	#$8A00,(a6)				; set to interrupt next scanline (so we can change the backdrop colour
		move.w	(Normal_palette+$22).w,(EMM_ColourBG).l	; set colour to swap out
		move.l	#HB_MainMenu,(H_int_addr).w		; set H-blank routine
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank - Main Menu clearing cards...
; ---------------------------------------------------------------------------

VB_MainMenuClear:
		movem.l	d0-a6,-(sp)				; store register data
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as write only

		lea	($C00000).l,a5				; set VDP registers
		lea	$04(a5),a6				; ''
		move.w	#$8F02,(a6)				; restore auto-increment
		move.l	#$64000001,(a6)				; clear sprite table
		move.l	#$00000000,(a5)				; ''

		lea	(MMSCM_SlideList+($06*2)).l,a1		; load plane card details
		move.w	(a1)+,d2				; set X position
		move.w	(a1)+,d1				; set Y position
		moveq	#$00,d3					; clear d3
		moveq	#$00,d6					; set no advancement amount
		moveq	#-$80,d0				; prepare sprite adjustment
		add.w	d0,d1					; adjust X and Y position due to sprites
		add.w	d0,d2					; ''
		lea	MM_MapList(pc),a0			; load mapping list
		move.w	#$8F80,(a6)				; set VDP to auto-increment by column
		bsr.w	MMSCM_LoadMap				; clear plane mappings

		moveq	#$00,d0					; clear d0
		move.l	#$42020003,d1				; clear left side of card
		bsr.s	VBMMC_ClearSides			; ''
		move.l	#$42260003,d1				; clear right side of card
		bsr.s	VBMMC_ClearSides			; ''

		move.w	#$8F02,(a6)				; restore auto-increment to normal
		bra.w	VBMMC_Continue				; continue to normal V-blank stuff

VBMMC_ClearSides:
		move.l	d1,(a6)					; set address
		bsr.s	VBMMC_ClearMap				; clear column
		addi.l	#$00020000,d1				; set next column address
		move.l	d1,(a6)					; ''

VBMMC_ClearMap:
		move.l	d0,(a5)					; clear column of tiles
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		move.l	d0,(a5)					; ''
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to animate the Zig-zag
; ---------------------------------------------------------------------------

VBMM_ZigZag:
		move.b	(EMM_ZigZagPos).l,d0			; load position
		move.w	(EMM_ZigZagSpeed).l,d1			; move zig-zag
		add.w	d1,(EMM_ZigZagPos).l			; ''
		cmp.b	(EMM_ZigZagPrev).l,d0			; has it changed?
		bne.s	VBMMZZ_Update				; if so, branch

	; --- Side-Zag ---

		move.b	(EMM_ZigZagPos).l,d0			; load position
		lsl.w	#$05,d0					; multiply by 20 (size of tiles)
		andi.l	#$000001E0,d0				; keep within tiles' worth
		addi.l	#AniArt_SideZag,d0			; add zig-zag address
		move.l	#$63A00001,(a6)				; set VDP address
		move.l	d0,a0					; set source address

VBMM_SideZag:
		move.l	(a0)+,(a5)				; copy tiles into VRAM
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		move.l	(a0)+,(a5)				; ''
		rts						; return

	; --- Zig-Zag ---

VBMMZZ_Update:
		move.b	d0,(EMM_ZigZagPrev).l			; update previous counter
		move.l	#$94019300,(a6)				; set size (200 bytes, 10 tiles)
		move.w	(EMM_ZigZagPos).l,d0			; load position x 100
		andi.l	#$00003E00>>1,d0			; keep within a frame's worth
		addi.l	#(AniArt_ZigZag>>1)|$97000000,d0	; add source address (and prep register
		move.l	#$96009500,d1				; prepare source registers
		move.b	d0,d1					; load lower byte address
		swap	d1					; get upper byte register
		lsr.w	#$08,d0					; get upper byte address
		move.b	d0,d1					; ''
		move.l	d1,(a6)					; set DMA source
		move.w	#$64C0,d0				; prepare latch destination
		move.l	d0,(a6)					; set final DMA source and latch destination
		move.w	#$0081,(a6)				; set final DMA destination (DMA transfer here)
		rts						; return (finished Zig-zag)

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load a full card art
; ---------------------------------------------------------------------------
VBMM_DIVIDE	=	$10
; ---------------------------------------------------------------------------

VBMM_CardFull:
		moveq	#$00,d0					; clear d0
		move.b	(EMM_MenuPos).l,d0			; load menu position
		cmp.b	(EMM_MenuPrev).l,d0			; has it changed since last frame?
		beq.s	VBMMCF_NoReset				; if not, branch
		move.b	(EMM_MenuPrev).l,(EMM_MenuPosLast).l	; change last position so it doesn't match new position (for rerendering)
		move.b	d0,(EMM_MenuPrev).l			; update previous frame
		clr.w	(EMM_CardPos).l				; reset card art position to beginning again

VBMMCF_NoReset:
		cmp.b	(EMM_MenuPosLast).l,d0			; has it changed?
		beq.s	VBMMCF_NoChange				; if not, branch
		cmpi.b	#$10,(EMM_FadeAmount).l			; is the fade out at maximum transparency?
		beq.s	VBMMCF_Change				; if so, branch (image is now hidden)

VBMMCF_NoChange:
		rts						; return

VBMMCF_Change:
		move.w	#$FFD0,d5				; set jump size (all 8 lines)
		move.w	#($B0/VBMM_DIVIDE)-1,d6			; set dbf size (number of tiles)
		move.w	(EMM_CardPos).l,d4			; set current VRAM/card position
		addi.w	#($B0/VBMM_DIVIDE)*$20,(EMM_CardPos).l	; advance to next position (for next frame)
		cmpi.w	#$1600,(EMM_CardPos).l			; is this the last card rendering?
		blo.s	VBMMCF_NoFinish				; if not, branch
		move.b	d0,(EMM_MenuPosLast).l			; update previous
		clr.w	(EMM_CardPos).l				; reset card render position

VBMMCF_NoFinish:
		lsl.w	#$03,d0					; multiply by size of entry in the table
		lea	(MM_CardList).l,a2			; load card list
		move.l	$04(a2,d0.w),a2				; load correct art address

		lea	(a2),a0					; load card art
		lea	(Trans_01_FULL0).l,a1			; load full transition card mask art
		move.l	#CARDVRAM1&$FFFF,d0			; set VRAM address
		bsr.w	VBMM_CA_LoadSegSpec			; write segment

		lea	(a2),a0					; load card art
		lea	(Trans_01_FULL1).l,a1			; load full transition card mask art
		move.l	#CARDVRAM2&$FFFF,d0			; set VRAM address
		bsr.w	VBMM_CA_LoadSegSpec			; write segment

		lea	(a2),a0					; load card art
		lea	(Trans_01_FULL2).l,a1			; load full transition card mask art
		move.l	#CARDVRAM3&$FFFF,d0			; set VRAM address
		bra.w	VBMM_CA_LoadSegSpec			; write segment

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load a segment of art
; ---------------------------------------------------------------------------

VBMM_CA_LoadSegSpec:
		adda.w	d4,a1					; advance transition mask to correct position

VBMM_CA_LoadSegment:
		adda.w	d4,a0					; advance card art to correct position
		add.w	d4,d0					; advance VRAM address to correct position
		lsl.l	#$02,d0					; convert for VDP long-word write
		lsr.w	#$02,d0					; ''
		ori.w	#$4000,d0				; ''
		swap	d0					; ''
		move.l	d0,(a6)					; set VDP VRAM write mode address
		move.w	d6,d3					; set dbf size
		jmp	VBMM_CA_Write(pc,d5.w)			; jump into loop and transfer art correctly

VBMM_CA_Loop:
	rept	$08
		move.l	(a0)+,d0				; load card art
		and.l	(a1)+,d0				; mask with transition card art
		move.l	d0,(a5)					; save to VRAM
	endm
VBMM_CA_Write:
		dbf	d3,VBMM_CA_Loop				; repeat until section is done
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load partial parts of a card (for the saving CPU time animating)
; ---------------------------------------------------------------------------

	; This has basically become unused because... well not enough CPU
	; time, what with the barrel roller in place

VBMM_VRAM:	dc.l	CARDVRAM1&$FFFF
		dc.l	CARDVRAM2&$FFFF
		dc.l	CARDVRAM3&$FFFF
		dc.l	$00000000				; Free slot

NoPressBUTT:
	rts

VBMM_CardPartial:
	btst.b	#$06,(Ctrl_2_pressed).w
	beq.s	NoPressBUTT
	move	#$2700,sr
	move.w	#$8100|%01010100,(a6)				; SDVM P100
	move.w	#$8000|%00000100,(a6)				; 00LH 01CD
		lea	(Trans_01_PAR0).l,a1			; load partial list
		moveq	#-1,d5					; prepare negative
		move.b	(a1)+,d5				; load jump size

VBMM_CP_Next:
		move.b	d5,d0					; copy jump size to d0
		ori.b	#%11000000,d5				; keep jump size as negative
		andi.w	#$00C0,d0				; get the transition slot VRAM to use
		lsr.b	#$04,d0					; ''
		move.l	VBMM_VRAM(pc,d0.w),d0			; ''

		moveq	#$00,d6					; load dbf size
		move.b	(a1)+,d6				; ''
		moveq	#$00,d4					; load card position
		move.w	(a1)+,d4				; ''

	lea	(Art_Card01).l,a0			; load card art

		bsr.w	VBMM_CA_LoadSegment			; load this segment
		move.b	(a1)+,d5				; load jump size
		bne.s	VBMM_CP_Next				; if not finished, branch

VBMM_CP_Finish:
	move.w	#$8100|%01110100,(a6)				; SDVM P100
	move.w	#$8000|%00010100,(a6)				; 00LH 01CD
		rts						; return (finished)


; ---------------------------------------------------------------------------
; Test list...
; ---------------------------------------------------------------------------

	; Commented out because we don't need it, and we need the space...

Trans_01_PAR0:

	;	include	"Main Menu\Main Menu\Menu Cards\Test.asm"

; ---------------------------------------------------------------------------
; Example list...
; ---------------------------------------------------------------------------

	; --- Entry 1 ---


		; P = Slot to use (00 = VRAM 1 | 01 = VRAM 2 | 10 = VRAM 3 | 11 = Free slot)
		; J = Number of lines
		; S = Number of tiles
		; V = Art position relative to beginning

		;	 PP	      JJ	      SS
		dc.b	%00000000|((-$06)&%00111111),$02
		;	 VVVV
		dc.w	$0800

		; Mask data to use for animating new slots...

		dc.l	$FFFF0F00
		dc.l	$00FFFFFF
		dc.l	$0000FFFF
		dc.l	$00000FFF
		dc.l	$000000FF
		dc.l	$000000FF
		dc.l	$0000000F
		dc.l	$0000000F
		dc.l	$00000000
		dc.l	$F0000000
		dc.l	$F0000000


	; --- Entry 2 ---


		; P = Slot to use (00 = VRAM 1 | 01 = VRAM 2 | 10 = VRAM 3 | 11 = Free slot)
		; J = Number of lines
		; S = Number of tiles
		; V = Art position relative to beginning

		;	 PP	      JJ	      SS
		dc.b	%00000000|((-$0C)&%00111111),$00
		;	 VVVV
		dc.w	$0210

		; Mask data to use for animating new slots...

		dc.l	$FFFF0F00
		dc.l	$0000000F

	; --- Entry 3 (Finish marker) ---


		; P = Slot to use (00 = VRAM 1 | 01 = VRAM 2 | 10 = VRAM 3 | 11 = Free slot)
		; J = Number of lines
		; S = Number of tiles
		; V = Art position relative to beginning

		;	 PP

		dc.b	$00	; Because P/J are 00, this is the end of the list
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; H-blank - Main Menu
; ---------------------------------------------------------------------------

HB_MainMenu:
		move.w	#$8A00|(($80-3)/2),(a6)			; set next position to interrupt (on line 80, but divide by 2 due to delay, and minus the colour swap lines)
	;	move.l	#$C0400000,(a6)				; change backdrop colour to the black/yellow BG
	;	move.w	(EMM_ColourBG).l,(a5)			; ''
		move.l	#HBMM_WaitSpinner,(H_int_addr).w	; set next H-blank address
		rte						; return

HBMM_WaitSpinner:
		move.l	#HBMM_StartSpinner,(H_int_addr).w	; set spinner address (delay routine)
		rte						; return (next trigger will be correct)

HBMM_StartSpinner:
		move.l	#$8A008F04,(a6)				; set interrupt and increment modes
		move.l	#HBMM_Spinner,(H_int_addr).w		; set next H-blank address
		move.w	#SPINSIZE-1,d7				; set size of spinner to H-blank around with
		rte						; return

HBMM_Spinner:
		move.l	#$402A0010,(a6)				; set to VSRAM write mode (only BG)
		move.l	(a4)+,(a5)				; write BG positions
		move.l	(a4)+,(a5)				; ''
		move.l	(a4)+,(a5)				; ''
		move.l	(a4)+,(a5)				; ''
		move.w	(a4)+,(a5)				; ''
		dbf	d7,HBMM_SpinNoFin			; repeat for all scanlines the spinner is in
		move.l	#HBMM_Restore,(H_int_addr).w		; set final routine
		lea	(EMM_VScroll+$28).l,a4			; load normal V-scroll positions
		move.l	#$8ADF8F02,(a6)				; set interrupt and increment modes
		rte						; return

HBMM_Restore:
	;	move.l	#$C0400000,(a6)				; change colour back to normal so the boarder doesn't show it
	;	move.w	(Normal_palette+$40).w,(a5)		; ''
		move.l	#$40280010,(a6)				; set to VSRAM (both FG and BG)
		move.l	(a4)+,(a5)				; Twice the amount as it's probably quicker to...
		move.l	(a4)+,(a5)				; ...do both FG and BG, than to addq every FG
		move.l	(a4)+,(a5)				; ''
		move.l	(a4)+,(a5)				; ''
		move.l	(a4)+,(a5)				; ''
		move.l	(a4)+,(a5)				; ''
		move.l	(a4)+,(a5)				; ''
		move.l	(a4)+,(a5)				; ''
		move.l	(a4)+,(a5)				; ''
		move.l	#NullRTE,(H_int_addr).w			; finish H-blank

HBMM_SpinNoFin:
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load main menu text
; ---------------------------------------------------------------------------

MM_LoadText:
		move.w	#$8F80,(a6)				; set VDP increment mode to advance a single line of mappings
		lea	(Map_Font).l,a2				; load font mappings
		lea	(MM_Select).l,a0			; load text to display
		move.l	#SPINVRAM,d4				; prepare plane/VRAM address
		moveq	#-1,d6					; set to render until string is finished
		bsr.s	MMLT_NextString				; render all strings

		not.w	d6					; get number of strings that were written
		move.b	d6,(EMM_MenuSize).l			; save the count as number of menu entries
		subq.b	#$01,(EMM_MenuSize).l			; minus 1
		lsl.w	#$04,d6					; multiply by 10 (size of a character's pixel height)
		move.w	d6,(EMM_SpinnerWrap).l			; store away for wrapping later

	; --- Doing another 4 on the end so it can wrap ---

		lea	(MM_Select).l,a0			; load text to display
		move.w	#$04,d6					; set to render only 3 more strings
		move.w	#$8F80,(a6)				; reset VDP increment mode to advance a single line of mappings

MMLT_NextString:
		lea	(a0),a1					; copy start of string to a1
		moveq	#$08,d1					; prepare maximum size of string

MMLT_NextChar:
		tst.b	(a1)+					; check string
		ble.s	MMLT_FinishChar				; if finished, branch
		dbf	d1,MMLT_NextChar			; repeat for all characters in string
		moveq	#$00,d1					; clear character count (maximum 8 characters)

MMLT_ProcessString:
		dbf	d6,MMLT_NoFinLines			; decrease line counter and branch if still counting
		move.w	#$8F02,(a6)				; restore increment mode
		rts						; return

MMLT_NoFinLines:
		move.l	d4,d3
		addi.l	#$01000000,d4				; move VRAM down to next line (for next string)

		move.w	d1,d5					; copy blank count to d5
		bsr.s	MMLT_Blank				; do left edge
		moveq	#$00,d0					; clear d0
		move.b	(a0)+,d0				; load character

MMLT_NextDraw:
		cmpi.b	#'?',d0					; is it a question mark?
		bne.s	MMLT_NoQuestion				; if not, branch
		moveq	#'Z'+1,d0				; set to use "?" mappings

MMLT_NoQuestion:
		subi.b	#'A'-1,d0				; minus the letter "A"
		bpl.s	MMLT_NoSpace				; if it's not a space character, branch
		moveq	#$00,d0					; set to use the "space" character

MMLT_NoSpace:
		lsl.w	#$03,d0					; multiply by size of four words (size of character mappings)
		lea	(a2,d0.w),a3				; load correct character mappings to use
		move.l	d3,(a6)					; set address
		addi.l	#$00020000,d3				; advance to next column
		move.l	(a3)+,(a5)				; write character mappings
		move.l	d3,(a6)					; set address
		addi.l	#$00020000,d3				; advance to next column
		move.l	(a3)+,(a5)				; write character mappings
		moveq	#$00,d0					; clear d0
		move.b	(a0)+,d0				; load character
		bne.s	MMLT_NextDraw				; if not finished, branch

		move.w	d1,d5					; copy blank count to d5
		bsr.s	MMLT_Blank				; do right edge
		bra.w	MMLT_NextString				; go and do the next string

MMLT_FinishChar:
		bpl.s	MMLT_ProcessString			; if this is not end of the list, branch
		move.w	#$8F02,(a6)				; restore increment mode
		rts						; return

	; --- Blank edges for centering ---

MMLT_NextBlank:
		move.l	d3,(a6)					; set address
		addi.l	#$00020000,d3				; advance to next column
		move.l	(a2),(a5)				; write blank square

MMLT_Blank:
		dbf	d5,MMLT_NextBlank			; repeat for all blank mappings
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control what description text to display
; ---------------------------------------------------------------------------
MMCD_Speed	=	$02
; ---------------------------------------------------------------------------

MM_ControlDescription:
		moveq	#$00,d1					; clear d1
		move.b	(EMM_DesPos).l,d1			; load position
		moveq	#$00,d0					; clear d0
		tst.b	(EMM_ExitMenu).l			; is the menu exiting?
		bne.s	MMCD_MoveOut				; if so, branch to keep the text scrolled out
		move.b	(EMM_MenuPos).l,d0			; load current menu position
		cmp.b	(EMM_DesCurrent).l,d0			; has the position changed?
		beq.s	MMCD_MoveIn				; if not, branch

MMCD_MoveOut:
		addq.b	#MMCD_Speed,d1				; move text out
		cmpi.b	#$14,d1					; has the text fully moved out?
		blo.s	MMCD_UpdatePos				; if not, branch
		move.b	d0,(EMM_DesCurrent).l			; update current menu text ID
		moveq	#$14+MMCD_Speed,d1			; keep at maximum

MMCD_MoveIn:
		subq.b	#MMCD_Speed,d1				; move text in
		bpl.s	MMCD_UpdatePos				; if the text is not fully in, branch
		moveq	#$00,d1					; keep in

MMCD_UpdatePos:
		move.b	d1,(EMM_DesPos).l			; update position

MMCD_NoIn:
		move.b	(EMM_DesCurrent).l,d0			; load current description selection
		add.w	d0,d0					; multiply selection ID by size of long-word
		add.w	d0,d0					; ''
		move.l	MM_Description(pc,d0.w),a0		; load correct text to display
		moveq	#$14,d2					; get reverse count
		sub.w	d1,d2					; ''
		lea	(EMM_Description).l,a1			; load mapping buffer
		moveq	#$04-1,d5				; set number of lines to render

	; --- Line rendering loop ---

MMCD_NextLine:
		adda.w	d1,a0					; advance to correct starting ASCII point
		move.w	#($D8A0/$20)-' ',d4			; prepare tile adjustment value
		move.w	d2,d3					; load render count
		subq.w	#$01,d3					; minus 1 for dbf
		bmi.s	MMCD_NoRender				; if there is no text being rendered branch

MMCD_Render:
		move.w	d4,d0					; load starting tile
		add.b	(a0)+,d0				; add ascii character
		move.w	d0,(a1)+				; save to mappings
		dbf	d3,MMCD_Render				; repeat for all characters

MMCD_NoRender:
		move.w	#($71A0/$20),d4				; prepare blank tile value
		move.w	d1,d3					; load blank count
		subq.w	#$01,d3					; minus 1 for dbf
		bmi.s	MMCD_NoBlank				; if there is no text being rendered branch

MMCD_Blank:
		move.w	d4,(a1)+				; save blank tile to mappings
		dbf	d3,MMCD_Blank				; repeat for all characters

MMCD_NoBlank:
		dbf	d5,MMCD_NextLine			; repeat for number of blank lines
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Main Menu Descriptions
; ---------------------------------------------------------------------------

MM_Description:	dc.l	DS_Battle			; 1	; "Battle Race" mode
		dc.l	DS_MiniGame			; 2	; "Mini Game" mode
		dc.l	DS_Locked			; 3	; "Team Race" mode
		dc.l	DS_Locked			; 4	; "Tag" mode
		dc.l	DS_BlueSpheres			; 5	; "Blue Spheres Challenge" mode
		dc.l	DS_SoundTest			; 6	; Sound Test
		dc.l	DS_Locked			; 7	; Museum
		dc.l	DS_Credits			; 8	; Credits screen
		dc.l	DS_Controls			; 9	; Player select screen
		dc.l	DS_Options			; 10	; Options screen

DS_Battle:	dc.b	" BATTLE AGAINST EACH"
		dc.b	" OTHER & RACE TO THE"
		dc.b	"   FINISH FLAG IN:  "
		dc.b	"  BATTLE RACE MODE! "

DS_MiniGame:	dc.b	"  PLAY AGAINST YOUR "
		dc.b	" OPPONENT IN VARIOUS"
		dc.b	"   BONUS MINIGAMES  "
		dc.b	"                    "

DS_BlueSpheres:	dc.b	"    BLUE SPHERES    "
		dc.b	"     CHALLENGE!     "
		dc.b	"                    "
		dc.b	"...TWO PLAYER STYLE!"

DS_Controls:	dc.b	"                    "
		dc.b	"      SORRY...      "
		dc.b	"    UNAVAILABLE     "
		dc.b	"                    "

DS_Locked:	dc.b	"  ?      ?     ?    "
		dc.b	"      ?     ?    ?  "
		dc.b	"   ?    ?     ?     "
		dc.b	"     ?     ?     ?  "

DS_SoundTest:	dc.b	" PLAY SOME MUSIC &  "
		dc.b	"  SOUND EFFECTS IN  "
		dc.b	" OUR COOL SOUNDTEST "
		dc.b	"                    "

DS_Credits:	dc.b	"  WANT TO KNOW WHO  "
		dc.b	"    WAS INVOLVED?   "
		dc.b	"                    "
		dc.b	"   FIND OUT HERE!!  "

DS_Options:	dc.b	"                    "
		dc.b	"  CHANGE SETTINGS   "
		dc.b	" ABOUT THE GAMEPLAY "
		dc.b	"                    "

; ---------------------------------------------------------------------------
; Main Menu Selection Text
; ---------------------------------------------------------------------------

	; No more than 8 characters per string...

	;	example limit v
	;	dc.b	"        ",$00

	; No more than 14 strings...

MM_Select:	dc.b	"BATTLE",$00			; 1	; "Battle Race" mode
		dc.b	"MINIGAME",$00			; 2	; "Mini Game" mode
		dc.b	"TEAMRACE",$00			; 3	; "Team Race" mode
		dc.b	"? ? ?",$00	; "TAG GAME"	; 4	; "Tag" mode
		dc.b	"BLUESPHE",$00			; 5	; "Blue Spheres Challenge" mode
		dc.b	"JUKE BOX",$00			; 6	; Sound Test
		dc.b	"MUSEUM",$00			; 7	; Museum
		dc.b	"CREDITS",$00			; 8	; Credits screen
		dc.b	"CONTROLS",$00			; 9	; Player select screen
		dc.b	"OPTIONS",$00			; 10	; Options screen

		dc.b	$FF					; End Marker
		even

; ---------------------------------------------------------------------------
; Main Menu card list
; ---------------------------------------------------------------------------

MM_CardList:	dc.l	Pal_Card01+$02,	Art_Card01	; 1	; "Battle Race" mode
		dc.l	Pal_Card02+$02,	Art_Card02	; 2	; "Mini Game" mode
		dc.l	Pal_Card06+$02,	Art_Card06	; 3	; "Team Race" mode
		dc.l	Pal_Card06+$02,	Art_Card06	; 4	; "Tag" mode
		dc.l	Pal_Card06+$02,	Art_Card06	; 5	; "Blue Spheres Challenge" mode
		dc.l	Pal_Card07+$02,	Art_Card07	; 6	; Sound test
		dc.l	Pal_Card06+$02,	Art_Card06	; 7	; Museum
		dc.l	Pal_Card05+$02,	Art_Card05	; 8	; Credits screen
		dc.l	Pal_Card03+$02,	Art_Card03	; 9	; Player select screen
		dc.l	Pal_Card04+$02,	Art_Card04	; 10	; Options screen

; ---------------------------------------------------------------------------
; Routines to run when the menu selection is made
; ---------------------------------------------------------------------------

MM_MenuSelect:	dc.l	MM_BattleRace			; 1	; "Battle Race" mode
		dc.l	MM_MiniGame			; 2	; "Mini Game" mode
		dc.l	MM_TeamRace			; 3	; "Team Race" mode
		dc.l	$00000000			; 4	; "Tag" mode
		dc.l	MM_BlueSpheres			; 5	; "Blue Spheres Challenge" mode
		dc.l	MM_SoundTest			; 6	; Sound Test
		dc.l	MM_Museum			; 7	; Museum
		dc.l	MM_Credits			; 8	; Credits screen
		dc.l	$00000000			; 9	; Player select screen
		dc.l	MM_Options			; 10	; Options screen

	; --- Menu Selection Routines ---

MM_BattleRace:
		move.b	#$00,(PlayMode).w			; set game mode to battle race
		move.l	#MM_SM_LevelSelect,(EMM_ScreenMode).w	; set level select routine to levels
		jmp	MM_LevelSelectInit			; run level select

MM_TeamRace:
		move.b	#$02,(PlayMode).w			; set game mode to battle race
		move.l	#MM_SM_LevelSelect,(EMM_ScreenMode).w	; set level select routine to levels
		jmp	MM_LevelSelectInit			; run level select

MM_MiniGame:
		move.b	#$06,(PlayMode).w			; set game mode to mini-games
		move.l	#MM_SM_LevelSelect,(EMM_ScreenMode).w	; set level select routine to levels
		jmp	MM_LevelSelectInit			; run level select

MM_Options:
		move.l	#MM_SM_Options,(EMM_ScreenMode).w	; set level select routine to options
		jmp	MM_LevelSelectInit			; run level select

MM_SoundTest:
		move.b	#$5C,(Game_mode).w			; set game mode to sound test
		bra.s	MM_ChangeScreen				; setup screen mode changing

MM_Museum:
		move.b	#$68,(Game_mode).w			; set game mode to Museum
		bra.s	MM_ChangeScreen				; setup screen mode changing

MM_BlueSpheres:	; TEMP method currently...
		move.b	#$10,(Game_mode).w			; set game mode to "blue spheres challenge"
		bra.s	MM_ChangeScreen				; setup screen mode changing

;	move.b	#$64,(Game_mode).w			; set game mode to "blue spheres challenge"
;	bra.s	MM_ChangeScreen				; setup screen mode changing

MM_Credits:
		bsr.s	MM_ChangeScreen				; setup screen mode changing

	; Mini-game HPZ is the credits screen...

		move.b	#$06,(PlayMode).w			; set game mode to mini-games
		move.w	#$1601,d0				; set to run HPZ for credits screen
		jmp	LevelSelect_StartZone			; setup level properly (see "sonic3k.asm")

	; --- Subroutine used when changing to a different screen mode ---

MM_ChangeScreen:
		moveq	#-$1F,d0				; fade music out
		jsr	Play_Sound.w				; ''
		jsr	Pal_FadeToBlack				; level doesn't do it properly...

		move	#$2700,sr				; disable interrupts
		move.l	#VInt,(V_int_addr).w			; force blank routines back to normal
		move.l	#HInt,(H_int_addr).w			; ''
		jsr	Init_VDP				; restore VDP for S3K (then return to normal game mode)
		move.w	#$8100|%01110100,(a6)			; enable display, Init_VDP disables it, and they don't re-enable during level running
		rts						; return

MM_SpecialStage:
		move.b	#$64,(Game_mode).w			; set game mode to sound test
		bra.s	MM_ChangeScreen				; setup screen mode changing

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup the H-scroll (the curve for the spinner, etc)
; ---------------------------------------------------------------------------

MM_SetupHScroll:
		lea	MMSHS_Curve(pc),a0			; load curve data
		lea	(EMM_HScroll+(SPINPOS*4)).l,a1		; load H-scroll table (starting at correct location)
		moveq	#SPINSIZE-1,d1				; number of scanlines for the menu

MMSHS_NextLine:
		addq.w	#$02,a1					; skip FG slot
		move.w	(a0)+,(a1)+				; write BG slot
		dbf	d1,MMSHS_NextLine			; repeat for all curve scanlines
		rts						; return

	; --- Curve list ---

MMSHS_Curve:	dc.w	$0018,$0015,$0014,$0012,$0010,$000F,$000E,$000C
		dc.w	$000B,$0009,$0008,$0007,$0006,$0006,$0005,$0005
		dc.w	$0004,$0003,$0003,$0002,$0002,$0002,$0001,$0001
		dc.w	$0001,$0000,$0000,$0000,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0001
		dc.w	$0001,$0001,$0002,$0002,$0002,$0003,$0003,$0004
		dc.w	$0005,$0005,$0006,$0006,$0007,$0008,$0009,$000B
		dc.w	$000C,$000E,$000F,$0010,$0012,$0014,$0015,$0017

; ---------------------------------------------------------------------------
; Old code to generate the above list of curve positions.
; ---------------------------------------------------------------------------

	;	lea	(SineTable).l,a0			; load sinewave table
	;	lea	(EMM_HScroll+(SPINPOS*4)).l,a1		; load H-scroll table (starting at correct location)
	;	moveq	#SPINSIZE-1,d1				; number of scanlines for the menu
	;	moveq	#$00,d2

;MM_CurveHScroll:
	;	moveq	#$00,d0
	;	addq.w	#$02,a1					; skip FG scroll position
	;	move.w	#$0100,d0				; load reverse sinewave position
	;	sub.w	(a0),d0					; ''
	;	asr.w	#$04,d0					; divide by 10 (to reduce the distance)
	;	move.w	d0,(a1)+				; save as H-scroll position
	;	asr.w	#$04,d0					; get fraction of distance
	;	addq.w	#$02,d0					; add 2 (in-case the distance is 0)
	;	add.w	d0,d0					; multiply by 2 (keep size of word)
	;	adda.w	d0,a0					; advance to next sinewave slot
	;	dbf	d1,MM_CurveHScroll			; repeat for all spinner scanlines

;	lea	(EMM_HScroll+(SPINPOS*4)).l,a1		; load H-scroll table (starting at correct location)
;	addi.l	#$0008,(a1)+
;	addi.l	#$0007,(a1)+
;	addi.l	#$0006,(a1)+
;	addi.l	#$0005,(a1)+
;	addi.l	#$0004,(a1)+
;	addi.l	#$0004,(a1)+
;	addi.l	#$0003,(a1)+
;	addi.l	#$0002,(a1)+
;	addi.l	#$0002,(a1)+
;	addi.l	#$0001,(a1)+

;	lea	(EMM_HScroll+((SPINPOS+SPINSIZE)*4)).l,a1		; load H-scroll table (starting at correct location)
;	addi.l	#$0008,-(a1)
;	addi.l	#$0007,-(a1)
;	addi.l	#$0006,-(a1)
;	addi.l	#$0005,-(a1)
;	addi.l	#$0004,-(a1)
;	addi.l	#$0004,-(a1)
;	addi.l	#$0003,-(a1)
;	addi.l	#$0002,-(a1)
;	addi.l	#$0002,-(a1)
;	addi.l	#$0001,-(a1)
;	rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup the mappings for the cards
; ---------------------------------------------------------------------------
		;	 XXXX  YYYY  VRAM Address of art
MMSCM_SlideList:dc.w	$0018,$0030,((CARDVRAM1/$20)|$2000)
		dc.w	$0018,$0030,((CARDVRAM2/$20)|$4000)
		dc.w	$0018,$0030,((CARDVRAM3/$20)|$6000)
; ---------------------------------------------------------------------------

MM_SetupCardMaps:
		lea	MMSCM_SlideList(pc),a1			; load the list of slides to render
		move.l	#$64000001,(a6)				; set VDP to address of sprite table
		moveq	#$00,d4					; reset sprite link Id

		move.w	(a1)+,d2				; set X position
		move.w	(a1)+,d1				; set Y position
		move.w	(a1)+,d3				; set index address
		lea	MM_MapList(pc),a0			; load mapping list
		bsr.s	MMSCM_LoadSprites			; load sprites

		move.w	(a1)+,d2				; set X position
		move.w	(a1)+,d1				; set Y position
		move.w	(a1)+,d3				; set index address
		lea	MM_MapList(pc),a0			; load mapping list
		bsr.s	MMSCM_LoadSprites			; load sprites

		move.l	#$64BA0001,(a6)				; clear last link (there's art after theses sprites)
		move.w	#$0E00,(a5)				; ''

		move.w	(a1)+,d2				; set X position
		move.w	(a1)+,d1				; set Y position
		move.w	(a1)+,d3				; set index address
		moveq	#$01,d6					; prepare advancement amount
		moveq	#-$80,d0				; prepare sprite adjustment
		add.w	d0,d1					; adjust X and Y position due to sprites
		add.w	d0,d2					; ''
		lea	MM_MapList(pc),a0			; load mapping list
		move.w	#$8F80,(a6)				; set VDP to auto-increment by column
		bsr.s	MMSCM_LoadMap				; load plane mappings
		move.w	#$8F02,(a6)				; restore auto-increment to normal
		rts						; return

	; --- Sprites ---

MMSCM_NextSprite:
		add.w	d1,d0					; adjust Y position
		move.w	d0,(a5)					; save to VRAM sprite table
		move.w	(a0)+,d0				; load sprite shape
		addq.b	#$01,d4					; increase sprite link ID
		move.b	d4,d0					; save with shape
		move.w	d0,(a5)					; save to VRAM sprite table
		move.w	d3,(a5)					; save index to VRAM sprite table
		move.w	(a0)+,d0				; load X position
		add.w	d2,d0					; adjust X position
		move.w	d0,(a5)					; save to VRAM sprite table
		add.w	(a0)+,d3				; advance index address

MMSCM_LoadSprites:
		move.w	(a0)+,d0				; load Y position
		bpl.s	MMSCM_NextSprite			; if this is not the end of the list, branch
		rts						; return

	; --- Plane mappings ---

MMSCM_NextMap:
		add.w	d1,d4					; add Y position of frame
		lsl.w	#$04,d4					; multiply by 80
		andi.l	#$00000F80,d4				; get only the Y position in the plane (and clear upper word)
		move.w	$02(a0),d0				; load X position of sprite
		add.w	d2,d0					; add X position of frame
		lsr.w	#$02,d0					; divide by 8 (then multiply by 2)
		andi.w	#$007E,d0				; get only the X position in the plane
		or.w	d0,d4					; fuse together
		addi.w	#$C000,d4				; advance to plane A address
		lsl.l	#$02,d4					; convert to long-word VDP write
		lsr.w	#$02,d4					; ''
		ori.w	#$4000,d4				; enable VDP write mode
		swap	d4					; prepare in order for VDP latch
		move.b	(a0),d0					; load shape
		move.b	d0,d5					; copy to d4
		andi.w	#$000C,d5				; get only width for dbf
		lsr.w	#$02,d5					; shift into place for dbf counter
		andi.w	#$0003,d0				; get only height for jumping
		neg.w	d0					; reverse for jumping
		add.w	d0,d0					; multiply by size of instructions below
		add.w	d0,d0					; ''

MMSCM_WriteRow:
		move.l	d4,(a6)					; set VDP VRAM address
		addi.l	#$00020000,d4				; move to the right
		jmp	MMSCM_WriteColumn-$04(pc,d0.w)		; jump to correct write size of column
	rept	$04
		move.w	d3,(a5)					; write tile
		add.w	d6,d3					; increase tile ID
	endm
MMSCM_WriteColumn:
		dbf	d5,MMSCM_WriteRow			; repeat for all rows
		addq.w	#$06,a0					; advance to next sprite

MMSCM_LoadMap:
		move.w	(a0)+,d4				; load Y position of sprite
		bpl.s	MMSCM_NextMap				; if list isn't finished, branch
		rts						; return (finished)

	; --- Sprite map list ---

		; Y = Y position
		; S = Sprite Shape
		; X = X position
		; T = Number of tiles the sprite has

		;	 YYYY  0S00, XXXX  TTTT

MM_MapList:	dc.w	$0080,$0F00,$0080,$0010
		dc.w	$00A0,$0F00,$0080,$0010
		dc.w	$00C0,$0E00,$0080,$000C
		dc.w	$0080,$0F00,$00A0,$0010
		dc.w	$00A0,$0F00,$00A0,$0010
		dc.w	$00C0,$0E00,$00A0,$000C
		dc.w	$0080,$0F00,$00C0,$0010
		dc.w	$00A0,$0F00,$00C0,$0010
		dc.w	$00C0,$0E00,$00C0,$000C
		dc.w	$0080,$0F00,$00E0,$0010
		dc.w	$00A0,$0F00,$00E0,$0010
		dc.w	$00C0,$0E00,$00E0,$000C
		dc.w	$FFFF

; ===========================================================================
; ---------------------------------------------------------------------------
; Level Select/Options
; ---------------------------------------------------------------------------

MM_LevelSelectInit:
		move.w	#$8B00|%00000011,(a6)			; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)

	; --- Let V-blank run again (this should allow the button presses to clear) ---

		st.b	(V_int_routine).w			; set V-blank flag
		jsr	Wait_VSync				; wait for V-blank

		move	#$2700,sr


		lea	(EMM_VScrollA-$200).l,a1		; clear V-scroll (so it doesn't fuck up the main menu)
		move.w	#($0800/$04)-1,d1			; set size to clear
		moveq	#$00,d0					; clear d0

MMLS_ClearMainRAM:
		move.l	d0,(a1)+				; clear RAM
		dbf	d1,MMLS_ClearMainRAM			; repeat until section is clear
		move.l	#EMM_VScrollA,(EMM_VScrollSlot).l	; set address to the first scroll table

	; --- Loading data ---

		move.w	#$0010,(EMM_DisplaySlot).l		; set starting display slot (second slot)
		move.w	#$0100,(EMM_ScrollSlot).l		; ''
		move.b	#(MM_Swap_End-MM_Swap)/$04,(EMM_SwapList).l ; set number of effects to check through randomly

		move.l	#Scroll_NODAT,d0			; point scroll positions to null
		move.l	d0,(EMM_Scroll1).l			; ''
		move.l	d0,(EMM_Scroll2).l			; ''

		lea	(EMM_ScrList1).l,a1			; load first scroll list
		move.w	#EMM_ScrExtra1&$FFFF,d1			; load first scroll table
		move.w	#($100*2)-1,d2				; set size (BOTH tables at once)

MM_SetupScroll:
		move.w	d1,(a1)+				; write FG address
		addq.w	#$02,d1					; advance
		move.w	d1,(a1)+				; write BG address
		addq.w	#$02,d1					; advance
		dbf	d2,MM_SetupScroll			; repeat til both tables are setup (for extra special scrolling)

		lea	(EMM_WindowA).l,a1			; load window buffer
		lea	(EMM_WindowB).l,a2			; load window buffer
		move.w	#(($380+$280)/4)-1,d2			; set size of window buffer
		move.l	#$91009200,d1				; prepare window position registers

MM_SetupWindow:
		move.l	d1,(a1)+				; write positions
		move.l	d1,(a2)+				; ''
		dbf	d2,MM_SetupWindow			; repeat til all window positions are setup

	;	move.l	#$00800ECC,(Normal_palette+$14).w	; write the green and light grey colours that the arrows need..

		lea	(Pal_TitleCard).l,a0			; load title card palette
		lea	(Normal_palette+$40).w,a1		; load buffer to dump palette to (line 3)
		move.l	(a0)+,(a1)+				; dump palette
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''

	; --- Final stuff ---

		move.w	#$8100|%01110100,(a6)			; enable display

		move.l	#HB_LevelSelect,(H_int_addr).w		; set H-blank routine
		move.l	#VB_LevelSelect,(V_int_addr).w		; set V-blank routine

		move.b	(WinsPl1).w,d1				; load player 1's score
		move.l	#$64800000,d0				; set VRAM address of score numbers for player 1
		jsr	MM_DrawScore				; write player 1's numbers

		move.b	(WinsPl2).w,d1				; load player 2's score
		move.l	#$66400000,d0				; set VRAM address of score numbers for player 2
		jsr	MM_DrawScore				; write player 2's numbers

		st.b	(EMM_UpdatePal).l			; set to update the palette
		move.l	#$00288000,(EMM_ArrowPos).l		; set arrow position to outside the screen
		move.l	#$00288000,(EMM_OptionInOut).l		; set box position to outside the screen

		moveq	#$00,d0
		move.l	d0,(EMM_SpeedY_FG1).l
		move.l	d0,(EMM_SpeedY_FG2).l
		move.l	d0,(EMM_SpeedY_BG1).l
		move.l	d0,(EMM_SpeedY_BG2).l
		move.l	d0,(EMM_PosY_FG1).l
		move.l	d0,(EMM_PosY_FG2).l
		move.l	d0,(EMM_PosY_BG1).l
		move.l	d0,(EMM_PosY_BG2).l

		move.l	(EMM_ScreenMode).w,d0			; load screen mode
		bne.s	MM_ValidMode				; if a screen mode has been set, branch
		move.l	#MM_SM_Options,d0			; set first starting screen mode
		move.l	d0,(EMM_ScreenMode).w			; update screen mode

MM_ValidMode:
		move.l	d0,a0					; set address
		jsr	(a0)					; run screen mode
		jmp	ML_LevelSelect				; jump into main loop

; ===========================================================================
; ---------------------------------------------------------------------------
; Screen Mode Setup - Options
; ---------------------------------------------------------------------------

MM_SM_Options:
		lea	(DataPointers).l,a0			; load default list
		move.l	a0,(EMM_StageList).w			; set default list
		move.l	#MM_SM_Options,(EMM_ScreenMode).w	; ensure screen mode was set
		move.l	$08(a0),d0				; load options screen mode address
		sub.l	(a0),d0					; get slot position in list
		move.w	d0,(EMM_Level).l			; set starting screen/slot
		sf.b	(EMM_ArrowStatus).l			; move arrows out
		bset.b	#$07,(EMM_MusicMM).l			; set flag to not play main menu music again on return
		rts						; return

	;	moveq	#Mus_Options,d0				; play options music
	;	jmp	Play_Sound.w				; ''

; ===========================================================================
; ---------------------------------------------------------------------------
; Screen Mode Setup - Level Select
; ---------------------------------------------------------------------------

MM_SM_LevelSelect:
		lea	(DataPointers).l,a0			; load level select list
		cmpi.b	#06,(PlayMode).w			; is the game mode set to mini game?
		bne.s	MMSMLS_NoMini				; if not, branch
		lea	(MiniPointers).l,a0			; load mini level select list

MMSMLS_NoMini:

; Valid play modes
; 0 - Battle Race
; 2 - Team mode
; 4 - Tag mode
; 6 - Minigames

		move.l	a0,(EMM_StageList).w			; set list
	;	move.l	(EMM_StageList).w,a0			; load stage list
		move.l	#MM_SM_LevelSelect,(EMM_ScreenMode).w	; ensure screen mode was set
	;	move.w	(EMM_LevelHighlt).w,d0			; load level select option stored
	move.l	$24(a0),a1				; load highlight selection
	move.w	(a1),d0					; load level select option stored
		bne.s	MMSMLS_ValidStage			; if there was one set, branch

		move.l	$10(a0),d0				; load level start address

	if StageOffset_NAT<>0
		add.l	#StageOffset_NAT,d0			; offset by some amount
	endif
		sub.l	(a0),d0					; get slot position in list
	;	move.w	d0,(EMM_LevelHighlt).w			; update
	move.w	d0,(a1)					; update

MMSMLS_ValidStage:
		move.w	d0,(EMM_Level).l			; set selection to the first level slot

		st.b	(EMM_ArrowStatus).l			; move arrows in
		moveq	#Mus_DataSelect,d0			; play level select music
		cmpi.b	#$06,(PlayMode).w			; is the game mode set to mini game?
		bne.s	MMSMLS_NoMiniBGM			; if not, branch
		moveq	#Mus_Options,d0				; play mini-game music

MMSMLS_NoMiniBGM:
		bclr.b	#$07,(EMM_MusicMM).l			; clear flag main menu music aplay flag
		jmp	Play_Sound.w				; ''

; ===========================================================================
; ---------------------------------------------------------------------------
; Main Loop
; ---------------------------------------------------------------------------

ML_LevelSelect:
		jsr	Random_Number.w				; get random number
		add.l	d0,(EMM_Random).l			; ''
		tst.b	(EMM_GoMainMenu).l			; are we meant to be going back to the main menu?
		beq.s	MLMM_NoMenu				; if not, branch
		sf.b	(EMM_ArrowStatus).l			; move arrows out
		tst.b	(EMM_RunEffect).l			; is a swap effect running or about to run?
		bne.s	MLMM_Cont				; if so, branch
		clr.l	(EMM_ScreenMode).w			; set no screen mode
		jmp	MM_ReturnMainMenu			; go to main menu

MLMM_NoMenu:
		tst.b	(EMM_StartLevel).l			; has the level been selected already?
		beq.s	MLMM_NoOut				; if not, branch
		sf.b	(EMM_ArrowStatus).l			; move arrows out
		subq.w	#$01,(EMM_StartTimer).l			; decrease timer
		bne.s	MLMM_NoFadeBGM				; if we're still waiting for the SFX, branch
		moveq	#-$1F,d0				; fade music out
		jsr	Play_Sound.w				; ''

MLMM_NoFadeBGM:
		tst.b	(EMM_RunEffect).l			; is a swap effect running or about to run?
		bne.s	MLMM_Cont				; if so, branch
		move	#$2700,sr				; disable interrupts
		move.l	#VInt,(V_int_addr).w			; force blank routines back to normal
		move.l	#HInt,(H_int_addr).w			; ''
		jsr	Init_VDP				; restore VDP for S3K (then return to normal game mode)
	; enable display (they don't disable/enable correctly on level start, idiots...)
		move.w	#$8100|%01110100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		rts						; return

MLMM_NoOut:
		bsr.w	MM_Controls				; run controls of the main menu

MLMM_Cont:
		tst.b	(EMM_AllowSprite).l			; are we still transitioning from the main menu?
		beq.s	MLMM_NoSpritesYet			; if so, branch (don't display sprites until main menu is gone)
		bsr.s	MM_ArrowControl				; control arrows correctly
		bsr.w	MM_SpritesOptions			; control the options sprites display
		bsr.w	MM_SpritesCard				; control the title card sprites display

MLMM_NoSpritesYet:
		bsr.w	MM_ChangeBG				; change the background if needed
		bsr.w	MM_RenderOptions			; render the options menu if needed
		bsr.w	MM_PalCycle				; run palette cycling for the level slots
		bsr.w	MM_ArtCycle				; run art cycling for the level slots
		bsr.w	MM_ScrollExtra				; run extra scrolling subroutines for the level slots
		bsr.w	MM_ScrollSpeeds				; change the scroll speeds
		jsr	MM_Scroll				; scroll the backgrounds
		pea	ML_LevelSelect(pc)			; save return address
		st.b	(V_int_routine).w			; set V-blank flag
		jmp	Wait_VSync				; wait for V-blank

; ===========================================================================
; ---------------------------------------------------------------------------
; Controlling arrow sprites
; ---------------------------------------------------------------------------

MM_ArrowControl:
		tst.b	(EMM_ArrowStatus).l			; are the arrows moving in?
		bne.s	MMAC_MoveIn				; if so, branch

	; --- Moving out ---

		move.l	(EMM_ArrowPos).l,d0			; load arrow's current position
		cmpi.l	#$00280000,d0				; have they moved out fully?
		bgt.s	MMAC_NoRunArrows			; if so, branch
		asr.l	#$01,d0					; divide distance by 2
		add.l	d0,(EMM_ArrowPos).l			; add to position

MMAC_NoRunArrows:
		rts						; return

	; --- Moving in ---

MMAC_MoveIn:
		move.w	(EMM_ArrowPos).l,d0			; load arrow position
		asr.w	#$01,d0					; divide by 2
		bne.s	MLMM_NoStopArrows			; if it hasn't reached 0, branch
		move.w	d0,(EMM_ArrowPos).l			; force at position

MLMM_NoStopArrows:
		sub.w	d0,(EMM_ArrowPos).l			; subtract from position
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to map a square of mappings to a plane
; ---------------------------------------------------------------------------

MapScreen:
		move.l	#$00800000,d4				; row increment value

MapScreen_Spec:

MS_NextY:
		move.l	d0,(a6)					; set VDP address
		add.l	d4,d0					; advance to next line
		move.w	d1,d3					; get X

MS_NextX:
		move.w	(a1)+,(a5)				; write mappings to VRAM plane
		dbf	d3,MS_NextX				; repeat for all columns
		dbf	d2,MS_NextY				; repeat for all rows
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to map the animated 3 mappings
; ---------------------------------------------------------------------------

MM_WriteMappings3:
		move.w	#$8F80,(a6)				; set increment to single plane line
		move.l	#$00030002,d1				; tile add amounts
		move.l	#$00020000,d3				; prepare column add value
		moveq	#$05-1,d5				; set number of sections

MM_Sections3:
		moveq	#$08-1,d4				; set number of times to add the column
		move.l	#$83058306,d0				; tiles of animated 3

MM_Write3:
		move.l	d2,(a6)					; set VDP address
		add.l	d3,d2					; advance to next tile on the right
		move.l	d0,(a5)					; write tiles
		addq.w	#$01,d0					; ''
		move.w	d0,(a5)					; ''
		add.l	d1,d0					; advance to next tiles
		dbf	d4,MM_Write3				; repeat for section
		dbf	d5,MM_Sections3				; repeat for all sections
		move.w	#$8F02,(a6)				; restore increment mode
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw decimal numbers for the score
; ---------------------------------------------------------------------------

MM_DrawScore:
		lea	(Art_ScoreNum).l,a1			; load score art address
		lea	(MM_DecDisplace).l,a2			; load decimal displacement array
		moveq	#$02-1,d6				; set number of digits to check

MMDS_NextDigit:
		move.b	(a2)+,d3				; load decimal position
		moveq	#-$40,d2				; reset decimal counter
		move.w	#$0040,d4				; prepare tile size

MMDS_CountDigit:
		add.w	d4,d2					; increase decimal number (tile position)
		sub.b	d3,d1					; minus 1 from digit
		bcc.s	MMDS_CountDigit				; if if hasn't gone below 0, branch
		add.b	d3,d1					; restore to positive again
		move.l	d0,(a6)					; set VDP write address{mode)
		lea	(a1,d2.w),a3				; load correct art tiles address
	rept	$10
		move.l	(a3)+,(a5)				; copy digit art across
	endm
		addi.l	#$400000,d0				; advance to next tiles
		dbf	d6,MMDS_NextDigit			; repeat for all digits
		rts						; return

	; decimal displacement digit positions list (note decimal, not hex)

MM_DecDisplace:	dc.b	10
		dc.b	1

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to let the players control the main menu
; ---------------------------------------------------------------------------

MM_Controls:
		cmpi.l	#MM_SM_LevelSelect,(EMM_ScreenMode).w	; are we in the level select?
		beq.w	MMC_LevelSelect				; if so, branch
		cmpi.l	#MM_SM_Options,(EMM_ScreenMode).w	; is this the options?
		beq.w	MMC_Options				; if so, branch
		rts						; return (no control)

; ---------------------------------------------------------------------------
; Options controls
; ---------------------------------------------------------------------------

MMC_Options:
		tst.b	(EMM_RunEffect).l			; is a swap effect running or about to run?
		bne.w	MMCO_Control				; if so, branch
		move.b	(Ctrl_1_pressed).w,d1			; load player 1 pressed buttons
		or.b	(Ctrl_2_pressed).w,d1			; fuse player 1 pressed buttons
	btst.l	#$04,d1					; was B pressed?
	beq.s	MMCO_NoStart				; if not, branch
	;	bpl.s	MMCO_NoStart				; if neither pressed start, branch

		moveq	#$63,d0					; play select sound
		jsr	Play_Sound_2.w				; ''

		move.b	(OptBits_Menu).w,d0			; load current options
		move.w	#SRAM_OPTIONS,d1			; set address in SRAM to save
		jsr	(SRAM_Save).w				; save to SRAM

		; For returning to main menu correctly from options

		bclr.b	#$01,(EMM_FirstEffect).l		; set to run the first (arrow) effect
		clr.l	(EMM_ScreenMode).w			; set no screen mode
		st.b	(EMM_GoMainMenu).l			; set to go to the main menu next
		movea.l	(EMM_StageList).w,a2			; load stage list
	; Don't want options to save itself as a highlight, or else the level select will think it's using options...
	;	move.w	(EMM_Level).l,d0			; load current selection to d0
	;	move.l	$24(a2),a0				; get highlight RAM address
	;	move.w	d0,(a0)					; set highlight selection for return
		move.l	$0C(a2),d1				; get null slot ID
		sub.l	(a2),d1					; ''
		move.w	d1,(EMM_Level).l			; set selection to the blank slot (so it goes black before returning)
		rts

	;	bra.w	MM_SM_LevelSelect			; go to level select

MMCO_NoStart:
		moveq	#$00,d4					; clear d4
		move.b	(EMM_OptSelect).w,d4			; load option currently selected
		move.b	d1,d2					; keep a copy of the controls in d1
		andi.b	#%00000011,d2				; get only up/down buttons
		beq.s	MMCO_NoUpDown				; if any were pressed, branch
		moveq	#$5B,d0					; play swipe sound
		jsr	Play_Sound_2.w				; ''
		lsr.b	#$01,d2					; shift up into carry
		bcc.s	MMCO_NoUp				; if up was not pressed, branch
		subq.b	#$01,d4					; minus 1 from selection
		bra.s	MMCO_Check				; find new selection

MMCO_NoUp:
		beq.s	MMCO_NoUpDown				; if down was not pressed, branch
		addq.b	#$01,d4					; add 1 to selection

MMCO_Check:
		moveq	#-$01,d6				; reset selection counter
		lea	(MM_OptionText).l,a0			; load options menu list

MMCO_NotFound:
		addq.b	#$01,d6
		addq.w	#$04,a0					; advance to control routine
		tst.l	(a0)+					; is this entry valid?
		bpl.s	MMCO_Valid				; if so, branch
		tst.b	d4					; is the selection outside the menu above?
		bpl.s	MMCO_MoveTop				; if not, branch
		move.b	d6,d4					; reset selection to the bottom
		subq.b	#$01,d4					; adjust
		bra.s	MMCO_FoundNew				; continue

MMCO_MoveTop:
		moveq	#$00,d4					; force selection to the top
		bra.s	MMCO_FoundNew				; continue

MMCO_Valid:
		cmp.b	d4,d6					; do the entries match?
		bne.s	MMCO_NotFound				; if not, branch

MMCO_FoundNew:
		move.b	d4,(EMM_OptSelect).w			; update option selected
		st.b	(EMM_OptionsChg).l			; set to update the options menu

MMCO_NoUpDown:
		lea	(MM_OptionText+$04).l,a0		; load options menu list
		lsl.w	#$03,d4					; multiply options ID by size of two long-words
		adda.w	d4,a0					; advance to correct slot
		move.l	(a0),a0					; load control routine
		jmp	(a0)					; run it's control routine

MMCO_Control:
		rts						; return

; ---------------------------------------------------------------------------
; Level select controls
; ---------------------------------------------------------------------------

MMC_LevelSelect:
		moveq	#%00001100,d2
		move.b	(Ctrl_1_pressed).w,d1			; load player 1 buttons
		and.w	d2,d1					; get only left/right
		beq.s	MMCL_NoPlay1				; if neither were pressed, branch
		move.b	#$01,(EMM_PlayerLast).l			; set player 1 as last player to press a button

MMCL_NoPlay1:
		move.b	(Ctrl_2_pressed).w,d1			; load player 2 buttons
		and.w	d2,d1					; get only left/right
		beq.s	MMCL_NoPlay2				; if neither were pressed, branch
		move.b	#$02,(EMM_PlayerLast).l			; set player 2 as last player to press a button

MMCL_NoPlay2:
		move.b	(Ctrl_1_pressed).w,d1			; load player 1 pressed buttons
		or.b	(Ctrl_2_pressed).w,d1			; fuse player 1 pressed buttons
		bpl.w	MMCL_NoStart				; if neither pressed start, branch

;		cmp.b	#$F0,Ctrl_1_Held.w			; check if ABC is held
;		bne.s	.noheld					; if not, branch
;		move.b	#$1C,Game_Mode.w			; set to old level select
;		st	EMM_StartLevel
;		rts

	; --- running the level ---

;.noheld
		moveq	#$63,d0					; play select sound
		jsr	Play_Sound_2.w				; ''
		st.b	(EMM_StartLevel).l			; set the level start flag
		move.w	#$0010,(EMM_StartTimer).l		; set timer before playing the fade out sound
		move.b	#$0C,(Game_mode).w			; set game mode to level
	movea.l	(EMM_StageList).w,a2			; load stage list
		move.w	(EMM_Level).l,d0			; load current selection to d0
	;	move.w	d0,(EMM_LevelHighlt).w			; store level selection for return
	move.l	$24(a2),a0				; get highlight RAM address
	move.w	d0,(a0)					; set highlight selection for return

	move.l	$0C(a2),d1				; get null slot ID
	sub.l	(a2),d1					; ''
	move.w	d1,(EMM_Level).l			; set selection to the blank slot (so it goes black before playing the level)
	move.l	$14(a2),d1				; get random slot ID
	sub.l	(a2),d1					; ''
	cmp.w	d1,d0					; is this the random level slot?

	;	move.w	#DataStages_NUL-DataStages,(EMM_Level).l; set selection to the blank slot (so it goes black before playing the level)
	;	cmpi.w	#DataStages_RAN-DataStages,d0		; is this the random level slot?
		beq.s	MMCL_Random				; if so, branch
	;	subi.w	#DataStages_Lev-DataStages,d0		; get correct zone/act values
	move.l	$10(a2),d1				; get level start ID
	sub.l	(a2),d1					; ''
	sub.w	d1,d0					; get correct zone/act values
	;	lea	(MMCL_Zones).l,a0			; set zone and act to run
	movea.l	$1C(a2),a0				; load zone list
		move.w	(a0,d0.w),d4				; ''
		lsr.w	#$02,d0					; divide by size of long-word

	movea.l	$18(a2),a0				; load swap list
	;	lea	(RandomLevList).l,a0			; load swap list
		tst.b	$01(a0,d0.w)				; has this level already been set?
		bmi.s	MMRL_Normal				; if so, branch
		subq.b	#$01,(a0)+				; decrease zone count
		bgt.s	MMRL_ContinueList			; if there are still zones not ran yet, branch
		moveq	#$00,d1					; clear d1
		lea	-$01(a0),a1				; copy list to a1
	;	moveq	#((MMCL_Zones_End-MMCL_Zones)/$04)-1,d2	; set number of entries to clear
	move.w	$20+2(a2),d2				; set number of entries to clear
	subq.w	#$01,d2					; minus 1 for dbf
		move.b	d2,(a1)+				; reset list counter

MMRL_ClearList:
		move.b	d1,(a1)+				; clear level list
		dbf	d2,MMRL_ClearList			; repeat until it's all cleared

MMRL_ContinueList:
		st.b	(a0,d0.w)				; set level

MMRL_Normal:
		move.w	d4,d0					; get level ID requested
		jmp	LevelSelect_StartZone			; setup level properly (see "sonic3k.asm")

	; --- random level select ---

MMCL_Random:
	movea.l	$18(a2),a0				; load swap list
	;	lea	(RandomLevList).l,a0			; load swap list
		subq.b	#$01,(a0)+				; decrease zone count
		bgt.s	MMCL_ContinueList			; if there are still zones not ran yet, branch

MMCL_FindLast:
		tst.b	(a0)+					; is this the last zone?
		bmi.s	MMCL_FindLast				; if not, keep searching
		move.w	a0,d0					; store address of entry
		moveq	#$00,d1					; clear d1
	movea.l	$18(a2),a0				; reload swap list
	;	lea	(RandomLevList).l,a0			; reload swap list
	;	moveq	#((MMCL_Zones_End-MMCL_Zones)/$04)-1,d2	; set number of entries to clear
	move.w	$20+2(a2),d2				; set number of entries to clear
	subq.w	#$01,d2					; minus 1 for dbf
		move.b	d2,(a0)+				; reset list counter
		lea	(a0),a3					; copy to a3

MMCL_ClearList:
		move.b	d1,(a3)+				; clear level list
		dbf	d2,MMCL_ClearList			; repeat until it's all cleared
		subq.w	#$01+$01,d0				; minus 1 (due to increment) and another 1 (due to first byte being counter)
	;	subi.w	#(RandomLevList&$FFFF),d0		; get entry ID
	sub.w	$18+2(a2),d0				; get entry ID
		bra.s	MMCL_CheckZone				; set entry and run it

MMCL_NextZone:
		jsr	Random_Number.w			; get random number
		move.l	d0,(EMM_Random).l			; ''

MMCL_ContinueList:
		moveq	#$00,d0					; clear d0
		move.b	(EMM_Random).l,d0			; load random number
	;	divu.w	#(MMCL_Zones_End-MMCL_Zones)/$04,d0	; divide by number of possible swap list entries
	divu.w	$20+2(a2),d0				; divide by number of possible swap list entries
		swap	d0					; get remainder

MMCL_CheckZone:
	;	tas.b	(a0,d0.w) ; won't work on Mega Drive	; has this zone been ran before?
		tst.b	(a0,d0.w)				; has this zone been ran before?
		bmi.s	MMCL_NextZone				; if so, branch
		st.b	(a0,d0.w)				; set the entry as ran
		add.w	d0,d0					; multiply entry ID by size of long-word
		add.w	d0,d0					; ''
	movea.l	$1C(a2),a0				; load zone list
	move.w	(a0,d0.w),d0				; set zone and act to run
	;	move.w	MMCL_Zones(pc,d0.w),d0			; set zone and act to run
		jmp	LevelSelect_StartZone			; setup level properly (see "sonic3k.asm")

	; --- selecting level (left/right) ---

MMCL_NoStart:
	movea.l	(EMM_StageList).w,a2			; load stage list
		btst.l	#$04,d1					; was B pressed?
		beq.s	MMCL_NoOptions				; if not, branch
	;	move.w	(EMM_Level).l,(EMM_LevelHighlt).w	; store level being highlighted
	move.l	$24(a2),a0				; load highlight RAM address
	move.w	(EMM_Level).l,(a0)			; store level being highlighted
		moveq	#$3D,d0		; 6B 72 7B 8A A2	; play go back sound
		jsr	Play_Sound_2.w				; ''

		; For returning to main menu correctly from level select

		bclr.b	#$01,(EMM_FirstEffect).l		; set to run the first (arrow) effect
		clr.l	(EMM_ScreenMode).w			; set no screen mode
		st.b	(EMM_GoMainMenu).l			; set to go to the main menu next
		movea.l	(EMM_StageList).w,a2			; load stage list
		move.w	(EMM_Level).l,d0			; load current selection to d0
		move.l	$24(a2),a0				; get highlight RAM address
		move.w	d0,(a0)					; set highlight selection for return
		move.l	$0C(a2),d1				; get null slot ID
		sub.l	(a2),d1					; ''
		move.w	d1,(EMM_Level).l			; set selection to the blank slot (so it goes black before returning)
		rts

	;	bra.w	MM_SM_Options				; go to options

MMCL_NoOptions:
		andi.b	#%00001100,d1				; get only left/right buttons
		bne.s	MMCL_Check				; if any were pressed, branch
	rts			; disabling "holding" ability, doesn't look good...
		subq.w	#$01,(EMM_HoldTimer).l			; decrease timer
		bpl.s	MMCL_Return				; if still running, branch
		clr.w	(EMM_HoldTimer).l			; keep timer at 0
		move.b	(Ctrl_1_held).w,d1			; load player 2 held buttons
		or.b	(Ctrl_2_held).w,d1			; fuse player 2 held buttons
		andi.b	#%00001100,d1				; get only left/right buttons
		bne.s	MMCL_CheckNoTime			; if any were pressed, branch

MMCL_Return:
		rts						; return

MMCL_Check:
		move.w	#$0040,(EMM_HoldTimer).l		; reset hold timer

MMCL_CheckNoTime:
		moveq	#$5B,d0					; play swipe sound
		jsr	Play_Sound_2.w				; ''
		move.w	(EMM_Level).l,d0			; load level slot address
		lsr.b	#$03,d1					; get left/right buttons
		bcc.s	MMCL_NoLeft				; if left was not pressed, branch
		subq.w	#$04,d0					; decrease level slot ID

	move.l	$10(a2),d2				; get first slot ID
	sub.l	(a2),d2					; ''
	cmp.w	d2,d0					; have we reached the first slot?

	;	cmpi.w	#(DataStages_Lev-DataStages),d0		; have we reached the first slot?
		bhs.s	MMCL_FinishLeft				; if not, branch
	;	move.w	#(DataStages_Size-DataStages)-4,d0	; set selection to the last stage

	move.l	$04(a2),d0				; set selection to the last stage
	sub.l	(a2),d0					; ''
	subq.w	#$04,d0					; ''

MMCL_FinishLeft:
		tst.b	d1					; check for right button press

MMCL_NoLeft:
		beq.s	MMCL_NoRight				; if right was not pressed, branch
		addq.w	#$04,d0					; increase level slot ID
	move.l	$04(a2),d2				; get after last slot ID
	sub.l	(a2),d2					; ''
	cmp.w	d2,d0					; have we reached the last slot?
	;	cmpi.w	#(DataStages_Size-DataStages),d0	; have we reached the last slot?
		blo.s	MMCL_NoRight				; if not, branch
	;	move.w	#DataStages_Lev-DataStages,d0		; set selection to the first stage
	move.l	$10(a2),d0				; set selection to the first stage
	sub.l	(a2),d0					; ''

MMCL_NoRight:
		move.w	d0,(EMM_Level).l			; update level slot address
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write the scroll speeds for the background
; ---------------------------------------------------------------------------

MM_ScrollSpeeds:
		addq.w	#$02,(EMM_ScrollMain).l			; increase scroll amount
		move.l	(EMM_ScrollMain).l,d0			; load scroll amount
		move.l	d0,d1					; copy to d1
		asr.l	#$06,d0					; divide by 40
		move.w	d0,d2					; separate fractions and quotients
		swap	d0					; ''
		move.w	d1,d3					; ''
		swap	d1					; ''
		lea	(EMM_ScrollSpeed).w,a1			; load scroll speeds
		rept	(($0100/$04)/2)
		move.w	d1,(a1)+				; save normal version
		neg.w	d1					; save negative version
		move.w	d1,(a1)+				; ''
		sub.w	d2,d3					; add fractions
		addx.w	d0,d1					; add quotients
		move.w	d1,(a1)+				; save normal version
		neg.w	d1					; save negative version
		move.w	d1,(a1)+				; ''
		sub.w	d2,d3					; add fractions
		subx.w	d0,d1					; add quotients
		endm

MMPC_NoCycle2:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to run the appropriate palette cycling subroutines
; ---------------------------------------------------------------------------

MM_PalCycle:
		move.l	(EMM_PalCyc1).l,d0			; load first palette cycling slot
		beq.s	MMPC_NoCycle1				; if there is no routine, branch
		move.b	(EMM_SlotLoaded).l,d1			; load slot loading status
		bpl.s	MMPC_SlotLoad1				; if no slot is currently loading, branch
		add.b	d1,d1					; is it this slot that's loading?
		bpl.s	MMPC_NoCycle1				; if so, branch to skip palette cycling

MMPC_SlotLoad1:
		lea	(Normal_palette).l,a1			; load first palette line as the palette
		lea	(EMM_PalTimers1).l,a2			; load first timers
		move.l	d0,a0					; set address
		sf.b	(EMM_SlotID).l				; set as running slot 1
		jsr	(a0)					; run routine

MMPC_NoCycle1:
		move.l	(EMM_PalCyc2).l,d0			; load second palette cycling slot
		beq.s	MMPC_NoCycle2				; if there is no routine, branch
		move.b	(EMM_SlotLoaded).l,d1			; load slot loading status
		bpl.s	MMPC_SlotLoad2				; if no slot is currently loading, branch
		add.b	d1,d1					; is it this slot that's loading?
		bmi.s	MMPC_NoCycle2				; if so, branch to skip palette cycling

MMPC_SlotLoad2:
		lea	(Normal_palette+$40).l,a1		; load third palette line as the palette
		lea	(EMM_PalTimers2).l,a2			; load second timers
		move.l	d0,a0					; set address
		st.b	(EMM_SlotID).l				; set as running slot 2
		jmp	(a0)					; run routine

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to run the appropriate art cycling subroutines
; ---------------------------------------------------------------------------

MM_ArtCycle:
		move.l	(EMM_ArtCyc1).l,d0			; load first palette cycling slot
		beq.s	MMAC_NoCycle1				; if there is no routine, branch
		move.b	(EMM_SlotLoaded).l,d1			; load slot loading status
		bpl.s	MMAC_SlotLoad1				; if no slot is currently loading, branch
		add.b	d1,d1					; is it this slot that's loading?
		bpl.s	MMAC_NoCycle1				; if so, branch to skip animated art

MMAC_SlotLoad1:
		lea	(EMM_ArtTimers1).l,a2			; load first timers
		move.l	d0,a0					; set address
		move.l	(MMC_Slots+$0C).l,d2			; load VRAM address of art slot
		sf.b	(EMM_SlotID).l				; set as running slot 1
		jsr	(a0)					; run routine

MMAC_NoCycle1:
		move.l	(EMM_ArtCyc2).l,d0			; load second palette cycling slot
		beq.w	MMPC_NoCycle2				; if there is no routine, branch
		move.b	(EMM_SlotLoaded).l,d1			; load slot loading status
		bpl.s	MMAC_SlotLoad2				; if no slot is currently loading, branch
		add.b	d1,d1					; is it this slot that's loading?
		bmi.w	MMPC_NoCycle2				; if so, branch to skip animated art

MMAC_SlotLoad2:
		lea	(EMM_ArtTimers2).l,a2			; load second timers
		move.l	d0,a0					; set address
		move.l	(MMC_Slots+$1C).l,d2			; load VRAM address of art slot
		st.b	(EMM_SlotID).l				; set as running slot 2
		jmp	(a0)					; run routine

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to run the appropriate extra scrolling subroutines
; ---------------------------------------------------------------------------

MM_ScrollExtra:
		move.l	(EMM_ScrExx1).l,d0			; load first palette cycling slot
		beq.s	MMSE_NoExx1				; if there is no routine, branch
		move.b	(EMM_SlotLoaded).l,d1			; load slot loading status
		bpl.s	MMSE_SlotLoad1				; if no slot is currently loading, branch
		add.b	d1,d1					; is it this slot that's loading?
		bpl.s	MMSE_NoExx1				; if so, branch to skip extra scrolling

MMSE_SlotLoad1:
		lea	(EMM_ScrExtra1).l,a1			; load extra scroll table
		lea	(EMM_ScrTimers1).l,a2			; load first timers
		move.l	#EMM_ScrList1,(EMM_Scroll1).l		; set the new scroll table list
		move.l	d0,a0					; set address
		sf.b	(EMM_SlotID).l				; set as running slot 1
		jsr	(a0)					; run routine

MMSE_NoExx1:
		move.l	(EMM_ScrExx2).l,d0			; load second palette cycling slot
		beq.w	MMPC_NoCycle2				; if there is no routine, branch
		move.b	(EMM_SlotLoaded).l,d1			; load slot loading status
		bpl.s	MMSE_SlotLoad2				; if no slot is currently loading, branch
		add.b	d1,d1					; is it this slot that's loading?
		bmi.w	MMPC_NoCycle2				; if so, branch to skip extra scrolling

MMSE_SlotLoad2:
		lea	(EMM_ScrExtra2).l,a1			; load extra scroll table
		lea	(EMM_ScrTimers2).l,a2			; load second timers
		move.l	#EMM_ScrList2,(EMM_Scroll2).l		; set the new scroll table list
		move.l	d0,a0					; set address
		st.b	(EMM_SlotID).l				; set as running slot 2
		jmp	(a0)					; run routine

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control the options control sprites
; ---------------------------------------------------------------------------

MM_SpritesOptions:
		lea	(Sprite_table_buffer).l,a1		; load sprite table
		moveq	#$00,d6					; clear d6
		move.b	(EMM_SpriteCount).l,d6			; load sprite table count so far
		beq.s	MMSO_NoAdvance				; if there are none, branch
		move.w	d6,d0					; copy to d0
		lsl.w	#$03,d0					; multiply by 8
		adda.w	d0,a1					; advance to correct sprite table starting address
		move.b	d6,-$05(a1)				; set last sprite link properly

MMSO_NoAdvance:
		cmpi.l	#MM_SM_Options,(EMM_ScreenMode).w	; are we in the options menu?
		bne.s	MMSO_MoveOut				; if so, branch
		tst.b	(EMM_RunEffect).l			; is a swap effect running or about to run?
		beq.s	MMSO_MoveIn				; if not, branch

MMSO_MoveOut:
		move.l	(EMM_OptionInOut).l,d0			; load box current position
		cmpi.l	#$00280000,d0				; have they moved out fully?
		bgt.w	MMSO_NoBoxes				; if so, branch
		asr.l	#$02,d0					; divide distance by 2
		add.l	d0,(EMM_OptionInOut).l			; add to position
		bra.s	MMSO_Display				; display sprites

MMSO_MoveIn:
		move.w	(EMM_OptionInOut).l,d0			; load box position
		asr.w	#$02,d0					; divide by 2
		bne.s	MMSO_NoStopBox				; if it hasn't reached 0, branch
		move.w	d0,(EMM_OptionInOut).l			; force at position

MMSO_NoStopBox:
		sub.w	d0,(EMM_OptionInOut).l			; subtract from position

MMSO_Display:
		move.w	(EMM_OptionDestY).l,d0			; load destination
		sub.w	(EMM_OptionBoxY).l,d0			; get distance
		asr.w	#$01,d0					; divide by 2
		add.w	d0,(EMM_OptionBoxY).l			; move to destination
		move.w	(EMM_OptionBoxY).l,d3			; load position to d3
		moveq	#$00,d0					; clear d0
		move.b	(EMM_OptionSine).l,d0			; load sinewave angle
		addq.b	#$08,(EMM_OptionSine).l			; rotate angle
		add.w	d0,d0					; multiply by size of word
		lea	(SineTable).w,a2			; load correct entry from sinewave table
		move.w	(a2,d0.w),d0				; ''
		asr.w	#$07,d0					; divide correctly
	add.w	(EMM_OptionInOut).l,d0
		move.w	d0,(EMM_OptionPos).l			; save as top corners position
	; No longer needed since the sound test no longer exists
	;	cmpi.w	#$0048,d3				; is the sound test being highlighted?
	;	blo.s	MMSO_NoLargeBox				; if not, branch
	;	addi.w	#$0010,d0				; move position down to make the box larger

MMSO_NoLargeBox:
		move.w	d0,(EMM_OptionPos2).l			; save as bottom corners position
		addi.w	#$00B0,d3				; advance Y position down
		move.w	#$0088,d4				; prepare X position
		lea	(MMSO_Box).l,a2				; load box sprites

	; --- Top Left ---

		move.l	(a2)+,a0				; load sprite list
		move.w	d3,d1					; load Y position
		add.w	(a2)+,d1				; adjust it
		move.w	d4,d2					; load X position
		add.w	(a2)+,d2				; adjust it
		move.w	(EMM_OptionPos).l,d0			; adjust with option's sinewave position
		sub.w	d0,d1					; ''
		sub.w	d0,d2					; ''
		bsr.s	MMSO_WriteSprites			; write sprite corner

	; --- Top Right ---

		move.l	(a2)+,a0				; load sprite list
		move.w	d3,d1					; load Y position
		add.w	(a2)+,d1				; adjust it
		move.w	d4,d2					; load X position
		add.w	(a2)+,d2				; adjust it
		move.w	(EMM_OptionPos).l,d0			; adjust with option's sinewave position
		sub.w	d0,d1					; ''
		add.w	d0,d2					; ''
		bsr.s	MMSO_WriteSprites			; write sprite corner

	; --- Bottom Left ---

		move.l	(a2)+,a0				; load sprite list
		move.w	d3,d1					; load Y position
		add.w	(a2)+,d1				; adjust it
		move.w	d4,d2					; load X position
		add.w	(a2)+,d2				; adjust it
		add.w	(EMM_OptionPos2).l,d1			; adjust with option's sinewave position
		sub.w	(EMM_OptionPos).l,d2			; ''
		bsr.s	MMSO_WriteSprites			; write sprite corner

	; --- Bottom Right ---

		move.l	(a2)+,a0				; load sprite list
		move.w	d3,d1					; load Y position
		add.w	(a2)+,d1				; adjust it
		move.w	d4,d2					; load X position
		add.w	(a2)+,d2				; adjust it
		add.w	(EMM_OptionPos2).l,d1			; adjust with option's sinewave position
		add.w	(EMM_OptionPos).l,d2			; ''
		bsr.s	MMSO_WriteSprites			; write sprite corner

MMSO_NoBoxes:
		sf.b	-$05(a1)				; clear last sprite
		sf.b	+$03(a1)				; clear next sprite
		move.b	d6,(EMM_SpriteCount).l			; update sprite count
		rts						; return

MMSO_WriteSprites:
		move.w	(a0)+,d5				; load number of sprites to process

MMSO_NextPiece:
		move.w	(a0)+,d0				; load Y position
		add.w	d1,d0					; add main Y position
		move.w	d0,(a1)+				; write Y position
		addq.b	#$01,d6					; increase sprite count
		move.w	(a0)+,d0				; load shape
		or.b	d6,d0					; fuse link ID with shape
		move.w	d0,(a1)+				; write shape/priority link ID
		move.w	(a0)+,(a1)+				; write VRAM address
		move.w	(a0)+,d0				; load X position
		add.w	d2,d0					; add main X position
		move.w	d0,(a1)+				; write X position
		dbf	d5,MMSO_NextPiece			; repeat for number of requested pieces
		rts						; return

MMSO_Box:	dc.l	MMSO_TopLeft
		dc.w	$0000,$0000
		dc.l	MMSO_TopRight
		dc.w	$0000,$0130
		dc.l	MMSO_BotLeft
		dc.w	$0020,$0000
		dc.l	MMSO_BotRight
		dc.w	$0020,$0130

MMSO_TopLeft:	dc.w	$0004-1
		dc.w	$0000,$0000,($0149+MMSC_VRAMMAIN),	$0000
		dc.w	$0000,$0000,($0149+MMSC_VRAMMAIN)|$0800,$0008
		dc.w	$0000,$0000,($014A+MMSC_VRAMMAIN),	$0000
		dc.w	$0008,$0000,($014A+MMSC_VRAMMAIN)|$1000,$0000

MMSO_TopRight:
		dc.w	$0004-1
		dc.w	$0000,$0000,($0149+MMSC_VRAMMAIN),	$FFF0
		dc.w	$0000,$0000,($0149+MMSC_VRAMMAIN)|$0800,$FFF8
		dc.w	$0000,$0000,($014A+MMSC_VRAMMAIN)|$0800,$FFF8
		dc.w	$0008,$0000,($014A+MMSC_VRAMMAIN)|$1800,$FFF8

MMSO_BotLeft:	dc.w	$0004-1
		dc.w	$FFF8,$0000,($0149+MMSC_VRAMMAIN)|$1000,$0000
		dc.w	$FFF8,$0000,($0149+MMSC_VRAMMAIN)|$1800,$0008
		dc.w	$FFF8,$0000,($014A+MMSC_VRAMMAIN)|$1000,$0000
		dc.w	$FFF0,$0000,($014A+MMSC_VRAMMAIN),	$0000

MMSO_BotRight:	dc.w	$0004-1
		dc.w	$FFF8,$0000,($0149+MMSC_VRAMMAIN)|$1800,$FFF8
		dc.w	$FFF8,$0000,($0149+MMSC_VRAMMAIN)|$1000,$FFF0
		dc.w	$FFF8,$0000,($014A+MMSC_VRAMMAIN)|$1800,$FFF8
		dc.w	$FFF0,$0000,($014A+MMSC_VRAMMAIN)|$0800,$FFF8

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control the title card sprites
; ---------------------------------------------------------------------------
MMSC_VRAMMAIN	=	($0020/$20)
MMSC_VRAM	=	(MMSC_VRAMMAIN|$C000)
MMSC_OutPos	=	$0110
MMSC_ArrowX	=	$08
MMSC_ArrowY	=	(224/2)+$40
; ---------------------------------------------------------------------------

MM_SpritesCard:
		lea	(Sprite_table_buffer).l,a1		; load sprite table
		moveq	#$00,d6					; clear d6
		move.b	(EMM_SpriteCount).l,d6			; load sprite table count so far
		beq.s	MMSC_NoAdvance				; if there are none, branch
		move.w	d6,d0					; copy to d0
		lsl.w	#$03,d0					; multiply by 8
		adda.w	d0,a1					; advance to correct sprite table starting address
		move.b	d6,-$05(a1)				; set last sprite link properly

MMSC_NoAdvance:

		move.w	#(224-$20)+$80,d0			; set Y position of score
		add.w	(EMM_ArrowPos).l,d0			; minus arrow position
		move.w	d0,d1					; create version for numbers
		addi.w	#$02,d1					; move down a little

	; --- Score ---

		move.w	d1,(a1)+				; write Y position
		move.b	#$05,(a1)+				; write shape
		addq.b	#$01,d6					; write sprite priority link ID
		move.b	d6,(a1)+				; ''
		move.w	#($0123+MMSC_VRAM),(a1)+		; write VRAM address
		move.w	#(320/2)+$5C-$08,(a1)+			; write X position

		move.w	d0,(a1)+				; write Y position
		move.b	#$0D,(a1)+				; write shape
		addq.b	#$01,d6					; write sprite priority link ID
		move.b	d6,(a1)+				; ''
		move.w	#($0127+MMSC_VRAM),(a1)+		; write VRAM address
		move.w	#(320/2)+$5C+$10,(a1)+			; write X position

		move.w	d0,(a1)+				; write Y position
		move.b	#$01,(a1)+				; write shape
		addq.b	#$01,d6					; write sprite priority link ID
		move.b	d6,(a1)+				; ''
		move.w	#($012F+MMSC_VRAM),(a1)+		; write VRAM address
		move.w	#(320/2)+$5C+$30,(a1)+			; write X position

		move.w	d1,(a1)+				; write Y position
		move.b	#$05,(a1)+				; write shape
		addq.b	#$01,d6					; write sprite priority link ID
		move.b	d6,(a1)+				; ''
		move.w	#($0131+MMSC_VRAM),(a1)+		; write VRAM address
		move.w	#(320/2)+$5C+$40,(a1)+			; write X position

	; --- The arrows ---

		addq.b	#$08,(EMM_ArrowAngle).l			; rotate angle
		moveq	#$00,d0					; clear d0
		move.b	(EMM_ArrowAngle).l,d0			; load angle
		add.w	d0,d0					; multiply by size of word
		lea	(SineTable).w,a2			; MJ: load sinewave table address
		move.w	(a2,d0.w),d0				; load new X position
		asr.w	#$06,d0					; reduce range
		move.w	d0,d1					; copy to right side
		addi.w	#$0080+((320-MMSC_ArrowX)-$18),d1	; advance to right side of screen
		add.w	(EMM_ArrowPos).l,d1			; add arrow position
		neg.w	d0					; reverse direction for left side
		addi.w	#$0080+MMSC_ArrowX,d0			; advance to left side of screen
		sub.w	(EMM_ArrowPos).l,d0			; minus arrow position

		tst.b	(EMM_ArrowAngle).l			; are the arrows meant to display?
		bmi.s	MMSC_NoArrows				; if not, branch to blink

		move.w	#$0080+(MMSC_ArrowY-$0C),(a1)+		; write Y position
		move.b	#$0A,(a1)+				; write shape
		addq.b	#$01,d6					; write sprite priority link ID
		move.b	d6,(a1)+				; ''
		move.w	#(($011A+MMSC_VRAM)|$800)&$9FFF,(a1)+	; write VRAM address
		move.w	d0,(a1)+				; write X position
		move.w	#$0080+(MMSC_ArrowY-$0C),(a1)+		; write Y position
		move.b	#$0A,(a1)+				; write shape
		addq.b	#$01,d6					; write sprite priority link ID
		move.b	d6,(a1)+				; ''
		move.w	#($011A+MMSC_VRAM)&$9FFF,(a1)+		; write VRAM address
		move.w	d1,(a1)+				; write X position

MMSC_NoArrows:
		moveq	#$00,d2					; clear d2
		move.b	(EMM_PlayerLast).l,d2			; load player last pressed button
		beq.s	MMSC_NoPlayer				; if there was no last player, branch (just use player 1's)
		subq.b	#$01,d2					; convert correctly

MMSC_NoPlayer:
		move.w	d2,d3					; keep x1 copy
		lsl.w	#$03,d2					; mutliply by 8
		add.w	d3,d2					; add x1
		addi.w	#$0108+MMSC_VRAM,d2			; advance to circle backdrop VRAM address

		move.w	#$0080+(MMSC_ArrowY-$0C),(a1)+		; write Y position
		move.b	#$0A,(a1)+				; write shape
		addq.b	#$01,d6					; write sprite priority link ID
		move.b	d6,(a1)+				; ''
		move.w	d2,(a1)+				; write VRAM address
		move.w	d0,(a1)+				; write X position
		move.w	#$0080+(MMSC_ArrowY-$0C),(a1)+		; write Y position
		move.b	#$0A,(a1)+				; write shape
		addq.b	#$01,d6					; write sprite priority link ID
		move.b	d6,(a1)+				; ''
		move.w	d2,(a1)+				; write VRAM address
		move.w	d1,(a1)+				; write X position

	; --- The title cards ---

		lea	(CardNames).l,a0			; load title card text list
	cmpi.b	#$06,(PlayMode).w		; TEMP
	bne.s	NoTitleNorm			; TEMP
	lea	(CardMini).l,a0			; TEMP

NoTitleNorm:
		move.w	(EMM_Level).l,d0			; save new title card text address
		move.l	(a0,d0.w),(EMM_TitleCard).l		; ''

		lea	(EMM_TitlePos+($26-2)).l,a3		; load title card positions data
		lea	$02(a3),a2				; copy to a2
		rept	$12
		move.w	-(a3),-(a2)				; keep a copy of the position for the next 12 frames
		endm

		lea	(a3),a2		; for scrolling in	; copy position address

		move.l	(EMM_TitleCard).l,d0			; load title card ASCII text address
		cmp.l	(EMM_TItlePrev).l,d0			; has it changed?
		beq.s	MMSC_ScrollIn				; if not, branch to scroll in
		move.l	(EMM_TItlePrev).l,d0			; load previous title card
		bne.s	MMSC_NoBlankPrev			; if the previous card is not blank, branch
		move.w	#MMSC_OutPos,(a3)			; force position to out...
		bsr.s	MMSC_ForceOut				; ''

MMSC_NoBlankPrev:
		lea	-$0E(a3),a2	; for scrolling out	; copy position address
		cmpi.w	#MMSC_OutPos,(a3)			; has the card moved out fully?
		bhs.s	MMSC_Stall				; if so, branch
		addi.w	#$0010,(a3)				; move title position out

MMSC_Stall:
		cmpi.w	#MMSC_OutPos,$24(a3)			; has the LAST card moved out fully?
		blo.s	MMSC_DrawCard				; if it's still moving, branch
		move.l	(EMM_TitleCard).l,d0			; load new title card
		move.l	d0,(EMM_TItlePrev).l			; save as previous title card

MMSC_ScrollIn:
		tst.l	d0					; is there actual text to display?
		bne.s	MMSC_NoBlank				; if so, branch
		move.w	#MMSC_OutPos,(a3)			; force position to out...
		bsr.s	MMSC_ForceOut				; ''
		move.b	d0,-$05(a1)				; clear last sprite
		move.b	d0,+$03(a1)				; clear next sprite
		move.b	d6,(EMM_SpriteCount).l			; update sprite count
		rts						; return

MMSC_ForceOut:
		move.w	(a3),d1					; load position to force to
		swap	d1					; ''
		move.w	(a3),d1					; ''
		lea	$02(a3),a2				; set other positions to the same place
		move.l	d1,(a2)+				; ''
		move.l	d1,(a2)+				; ''
		move.l	d1,(a2)+				; ''
		move.l	d1,(a2)+				; ''
		move.l	d1,(a2)+				; ''
		move.l	d1,(a2)+				; ''
		move.l	d1,(a2)+				; ''
		move.l	d1,(a2)+				; ''
		move.l	d1,(a2)+				; ''
		rts						; return

MMSC_NoBlank:
		subi.w	#$0010,(a3)				; move title position in
		bgt.s	MMSC_DrawCard				; if the cards are not fully in, branch
		clr.w	(a3)					; keep at 0

MMSC_DrawCard:
		pea	(a3)					; store normal scroll position address
		lea	(a2),a3					; use the scroll in/out position (they are different)
		move.l	d0,a2					; load text address to use

	; --- Name "ANGEL ISLAND" ---

		lea	(a2),a0					; set text address
		move.w	$14(a3),d2				; set end X position
		addi.w	#$01A0,d2				; ''
		move.w	#$00E0,d3				; set start Y position
		bsr.w	MMSC_WriteText				; write the sprite text

	; --- "ZONE" ---

		lea	(Card_Zone).l,a0			; load "ZONE" text
		move.w	$1C(a3),d2				; set end X position
		addi.w	#$01A0,d2				; ''
		cmpi.b	#$06,(PlayMode).w			; is the game a mini-game?
		bne.s	MMSC_DrawZone				; if not, branch
		lea	(Card_Mini).l,a0			; use "MINIGAME" text

MMSC_DrawZone:
		move.w	#$0100,d3				; set start Y position
		bsr.w	MMSC_WriteText				; write the sprite text

	; --- Act ---

		lea	(a2),a0					; load text address
		move.l	(a0)+,a0				; '' (advance to end of text where the act number is)
		move.b	(a0),d0					; load act number
		subq.b	#$01,d0					; convert to neg/null/pos for nothing/act1/act2
		bmi.s	MMSC_Banner				; if there is no act number, branch

		; "ACT"

		move.w	$24(a3),d2				; load end X position
		addi.w	#$01A0-($20+7+$11),d2			; ''
		cmpi.w	#$0200,d2				; is it out of the area (i.e. wrapping)?
		bge.s	MMSC_Banner				; if so, branch
		move.w	#$0120+$14,d3				; set start Y position
		move.w	d3,(a1)+				; write Y position
		move.b	#$09,(a1)+				; write shape
		addq.b	#$01,d6					; write sprite priority link ID
		move.b	d6,(a1)+				; ''
		move.w	#$00A2+MMSC_VRAM,(a1)+			; write VRAM address
		move.w	d2,(a1)+				; write X position

		; Number...

		subi.w	#$0014,d3				; move X and Y position down/left for the word "ACT"
		addi.w	#$0011,d2				; ''
		cmpi.w	#$0200,d2				; is it out of the area (i.e. wrapping)?
		bge.s	MMSC_Banner				; if so, branch
		lsl.b	#$04,d0					; multiply by 10 (size of art per act number)
		addi.w	#$00A8+MMSC_VRAM,d0			; add VRAM address
		move.w	d3,(a1)+				; write Y position
		move.b	#$0F,(a1)+				; write shape
		addq.b	#$01,d6					; write sprite priority link ID
		move.b	d6,(a1)+				; ''
		move.w	d0,(a1)+				; write VRAM address
		move.w	d2,(a1)+				; write X position

	; --- Banner ---

MMSC_Banner:
		move.l	(sp)+,a3				; restore first scroll address
		move.w	(a3),d3					; load first scroll position
		neg.w	d3					; reverse and align it correctly
		addi.w	#$0080,d3				; ''
		lea	(MMSC_BanDat).l,a0			; load banner VRAM address data
		moveq	#((MMSC_BanDat_End-MMSC_BanDat)/$04)-1,d1 ; set number of dual-sprites to write
		moveq	#$18,d2					; prepare number of pixels to move down each time
		moveq	#$0E,d4					; prepare sprite shape

MMSC_WriteBanner:
		tst.w	d1					; is this the last line of pieces?
		bne.s	MMSC_WB_NoLastPiece			; if not, branch
		moveq	#$0F,d4					; change sprite shape

MMSC_WB_NoLastPiece:
		move.w	d3,(a1)+				; set Y position
		move.b	d4,(a1)+				; set shape
		addq.b	#$01,d6					; write sprite priority link ID
		move.b	d6,(a1)+				; ''
		move.w	(a0)+,(a1)+				; set VRAM address
		move.w	#$00C0,(a1)+				; set X position
		move.w	d3,(a1)+				; set Y position
		move.b	d4,(a1)+				; set shape
		addq.b	#$01,d6					; write sprite priority link ID
		move.b	d6,(a1)+				; ''
		move.w	(a0)+,(a1)+				; set VRAM address
		move.w	#$00E0,(a1)+				; set X position
		add.w	d2,d3					; move down to next section
		dbf	d1,MMSC_WriteBanner			; repeat for all sections vertically

	; --- Finished... ---

MMSC_Finish:
		sf.b	-$05(a1)				; clear last sprite
		sf.b	+$03(a1)				; clear last sprite
		move.b	d6,(EMM_SpriteCount).l			; update sprite count
		rts						; return

; ---------------------------------------------------------------------------
; Title card banner sprite VRAM data
; ---------------------------------------------------------------------------

MMSC_BanDat:	dc.w	$00C8+MMSC_VRAM, $00C8+MMSC_VRAM
		dc.w	$00C8+MMSC_VRAM, $00C8+MMSC_VRAM
		dc.w	$00C8+MMSC_VRAM, $00C8+MMSC_VRAM
		dc.w	$00C8+MMSC_VRAM, $00C8+MMSC_VRAM
		dc.w	$00C8+MMSC_VRAM, $00C8+MMSC_VRAM
		dc.w	$00D0+MMSC_VRAM, $00DC+MMSC_VRAM
		dc.w	$00E8+MMSC_VRAM, $00F8+MMSC_VRAM
MMSC_BanDat_End:

; ---------------------------------------------------------------------------
; Subroutine to write ASCII text data as sprites
; ---------------------------------------------------------------------------

MMSC_WriteText:
		move.l	(a0)+,a0				; load starting sprite address
		moveq	#$00,d0					; clear d0
		move.b	-(a0),d0				; load character
		beq.s	MMSC_FinishText				; if the list is empty, branch

MMSC_ReadText:
		cmpi.b	#' ',d0					; is it a space character?
		bne.s	MMSC_NoSpace				; if so, branch
		subq.w	#$08,d2					; move X position back by the size of a space
		bra.s	MMSC_Space				; continue

MMSC_NoSpace:
		subi.b	#'A',d0					; minus starting letter
		add.w	d0,d0					; multiply by size of two words
		add.w	d0,d0					; ''
		move.l	MMSC_Text(pc,d0.w),d0			; load correct sprite data

		move.w	d3,(a1)+				; write Y position
		move.w	d0,d1					; copy shape to d1
		addq.b	#$01,d6					; increase sprite count
		move.b	d6,d1					; put with shape as priority
		move.w	d1,(a1)+				; write shape and priority link
		moveq	#$00,d1					; clear d1
		move.b	d0,d1					; load X advance amount
		swap	d0					; write VRAM address
		move.w	d0,(a1)+				; ''
		sub.w	d1,d2					; move it back the size of a sprite
		cmpi.w	#$0200,d2				; is it out of the area (i.e. wrapping)?
		blt.s	MMSC_NoHide				; if not, branch
		clr.w	-$06(a1)				; move Y position up off of screen

MMSC_NoHide:
		move.w	d2,(a1)+				; write X position

MMSC_Space:
		moveq	#$00,d0					; clear d0
		move.b	-(a0),d0				; load character
		bne.s	MMSC_ReadText				; if there are still characters left, branch

MMSC_FinishText:
		rts						; return

; --------------------------------------------------------------------------------
; Text sprite data
; --------------------------------------------------------------------------------
		;	VRAM, Shape|XSize

MMSC_Text:	dc.w	$0000+MMSC_VRAM, $0610		; A
		dc.w	$0006+MMSC_VRAM, $0610		; B
		dc.w	$000C+MMSC_VRAM, $0610		; C
		dc.w	$0012+MMSC_VRAM, $0610		; D
		dc.w	$0018+MMSC_VRAM, $0610		; E
		dc.w	$001E+MMSC_VRAM, $0610		; F
		dc.w	$0024+MMSC_VRAM, $0610		; G
		dc.w	$002A+MMSC_VRAM, $0610		; H
		dc.w	$0030+MMSC_VRAM, $0208		; I
		dc.w	$0033+MMSC_VRAM, $0610		; J
		dc.w	$0039+MMSC_VRAM, $0610		; K
		dc.w	$003F+MMSC_VRAM, $0208		; L
		dc.w	$0042+MMSC_VRAM, $0A18		; M
		dc.w	$004B+MMSC_VRAM, $0610		; N
		dc.w	$0051+MMSC_VRAM, $0A18		; O
		dc.w	$005A+MMSC_VRAM, $0610		; P
		dc.w	$0060+MMSC_VRAM, $0A18		; Q
		dc.w	$0069+MMSC_VRAM, $0610		; R
		dc.w	$006F+MMSC_VRAM, $0610		; S
		dc.w	$0075+MMSC_VRAM, $0610		; T
		dc.w	$007B+MMSC_VRAM, $0610		; U
		dc.w	$0081+MMSC_VRAM, $0610		; V
		dc.w	$0087+MMSC_VRAM, $0A18		; W
		dc.w	$0090+MMSC_VRAM, $0610		; X
		dc.w	$0096+MMSC_VRAM, $0610		; Y
		dc.w	$009C+MMSC_VRAM, $0610		; Z

		dc.w	$00A2+MMSC_VRAM, $0918		; ACT
		dc.w	$00A8+MMSC_VRAM, $0F20		; 1
		dc.w	$00B8+MMSC_VRAM, $0F20		; 2
		dc.w	$00C8+MMSC_VRAM, $0F20		; RED
		dc.w	$00D8+MMSC_VRAM, $0F20		; S3&K 1
		dc.w	$00E8+MMSC_VRAM, $0F20		; S3&K 2
		dc.w	$00F8+MMSC_VRAM, $0F20		; Battle 1
		dc.w	$0108+MMSC_VRAM, $0F20		; Battle 2
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Universal V-blank subroutine
; ---------------------------------------------------------------------------

VB_Universal:
		lea	($C00000).l,a5				; set VDP registers
		lea	$04(a5),a6				; ''

		jsr	Poll_Controllers			; read controls (stupid name "poll", I should find the morron who decided that, and kick him in the gonads...)

	;	DMA	$0280, $78000002, Sprite_table_buffer	; sprites
	;	DMA	$0380, $7C000002, EMM_HScroll		; hscroll
	;	DMA	$0080, $C0000000, Normal_palette	; palette

		move.w	#$9300,d0				; prepare DMA size register low byte
		move.b	(EMM_SpriteCount).l,d0			; load count
		beq.s	VBU_NoSprites				; if there are no sprites, branch
		move.w	#$9400,d1				; prepare DMA size register high byte
		move.b	d1,(EMM_SpriteCount).l			; reset sprite table count
		add.b	d0,d0					; multiply size by 8 then divide by 2 for DMA, but...
		addx.b	d1,d1					; ...transfer upper byte to upper byte register
		add.b	d0,d0					; ''
		addx.b	d1,d1					; ''
		move.w	d1,(a6)					; set DMA size
		move.w	d0,(a6)					; ''
		move.l	#((((((Sprite_table_buffer&$FFFFFF)/$02)<<$08)&$FF0000)+(((Sprite_table_buffer&$FFFFFF)/$02)&$FF))+$96009500),(a6)
		move.l	#(((((Sprite_table_buffer&$FFFFFF)/$02)&$7F0000)+$97000000)+(($64000001>>$10)&$FFFF)),(a6)
		move.w	#(($64000001&$FF7F)|$80),(a6)		; transfer only the number of sprites used...

VBU_NoSprites:
		DMA	$0380, $7C000002, EMM_HScroll		; hscroll
		jsr	Process_DMA_Queue			; run DMA cue
		lea	($C00000).l,a5				; restore a5/a6
		lea	$04(a5),a6				; ''

		bclr.b	#$07,(EMM_UpdatePal).l			; clear palette change flag
		beq.s	VBU_NoPalette				; if it was already cleared, branch (no change occurred)
		DMA	$0080, $C0000000, Normal_palette	; palette

VBU_NoPalette:
	if VBU_DisplayLag
	tst.b	(V_int_routine).w
	bne.s	VBU_No68kLate
	move.l	#$C0140000,(a6)
	move.w	#$0EEE,(a5)
	move.l	#$C0380000,(a6)
	move.w	#$0EEE,(a5)
	move.l	#$C0780000,(a6)
	move.w	#$0EEE,(a5)
	move.l	#$C0560000,(a6)
	move.w	#$0EEE,(a5)
	st.b	(EMM_UpdatePal).l
	endif

VBU_No68kLate:

; ---------------------------------------------------------------------------
; Subroutine to animate the number 3 in the window plane
; ---------------------------------------------------------------------------

VB_Animate3:
		addq.w	#$01,(EMM_Anim3).l		; increase counter
		move.w	(EMM_Anim3).l,d0		; load frame
		move.w	d0,d1				; copy to d1
		andi.w	#$0003,d0			; get within every 3 frames
		lsl.w	#$04,d0				; multiply by 4 long-words
		lea	VBA3_List(pc,d0.w),a0		; load correct list
		moveq	#$04-1,d6			; set number of strips

VBA3_Next:
		andi.w	#$001C,d1			; get tile position
		move.w	d1,d2				; copy to d2
		addq.w	#$04,d1				; advance to next position
		mulu.w	#$60/4,d2			; multiply by size of strip
		addi.w	#$60A0,d2			; advance to correct VDP address/mode
		move.l	(a0)+,a1			; load strip's DMA size/source
		move.l	(a1)+,(a6)			; set DMA size
		move.l	(a1)+,(a6)			; set DMA source
		move.w	(a1)+,(a6)			; ''
		move.w	d2,(a6)				; set DMA destination
		move.w	#$0081,(a6)			; set DMA ''
		dbf	d6,VBA3_Next			; repeat for all strips
		rts					; return

VBA3_List:	dc.l	VBA3_00_A
		dc.l	VBA3_00_B
		dc.l	VBA3_00_C
		dc.l	VBA3_00_D
		dc.l	VBA3_01_A
		dc.l	VBA3_01_B
		dc.l	VBA3_01_C
		dc.l	VBA3_01_D
		dc.l	VBA3_02_A
		dc.l	VBA3_02_B
		dc.l	VBA3_02_C
		dc.l	VBA3_02_D
		dc.l	VBA3_03_A
		dc.l	VBA3_03_B
		dc.l	VBA3_03_C
		dc.l	VBA3_03_D

VBA3_00_A:	DMATAB	Art_Anim3+($180*0)+($60*0)
VBA3_00_B:	DMATAB	Art_Anim3+($180*0)+($60*1)
VBA3_00_C:	DMATAB	Art_Anim3+($180*0)+($60*2)
VBA3_00_D:	DMATAB	Art_Anim3+($180*0)+($60*3)

VBA3_01_A:	DMATAB	Art_Anim3+($180*1)+($60*0)
VBA3_01_B:	DMATAB	Art_Anim3+($180*1)+($60*1)
VBA3_01_C:	DMATAB	Art_Anim3+($180*1)+($60*2)
VBA3_01_D:	DMATAB	Art_Anim3+($180*1)+($60*3)

VBA3_02_A:	DMATAB	Art_Anim3+($180*2)+($60*0)
VBA3_02_B:	DMATAB	Art_Anim3+($180*2)+($60*1)
VBA3_02_C:	DMATAB	Art_Anim3+($180*2)+($60*2)
VBA3_02_D:	DMATAB	Art_Anim3+($180*2)+($60*3)

VBA3_03_A:	DMATAB	Art_Anim3+($180*3)+($60*0)
VBA3_03_B:	DMATAB	Art_Anim3+($180*3)+($60*1)
VBA3_03_C:	DMATAB	Art_Anim3+($180*3)+($60*2)
VBA3_03_D:	DMATAB	Art_Anim3+($180*3)+($60*3)

; ===========================================================================
; ---------------------------------------------------------------------------
; V-Blank - Level Select/Options
; ---------------------------------------------------------------------------

VB_LevelSelect:
		movem.l	d0-a3,-(sp)				; store register data
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as read only
		bsr.w	VB_Universal				; transfer standard/universal stuff

		tst.w	(EMM_LoadPlane+$02).l			; is the plane data being loaded?
		bne.w	VB_StartHBlank				; if so, branch and wait
		move.l	(EMM_FrameData).l,d0			; load frame transfer data
		beq.w	VB_UpdateOptions			; if there is no frame to transfer, branch
		move.l	d0,a0					; set address
		sf.b	(EMM_OptionsChg).l			; set options as updated and transferred
		sf.b	(EMM_OptionsTrs).l			; '' (Doesn't need to be done since it's transitioning now...)

		lea	(EMM_ArtTransfer).l,a2			; load art transfer DMA register storage
		move.l	(a0)+,(a2)+				; save source address
		move.l	(a0)+,(a2)+				; ''
		move.l	(EMM_FrameData+$04).l,a1		; set destination address

		move.w	(a1)+,d0				; load plane A address
		move.w	(a1)+,d1				; ''
		move.l	(a1)+,(a2)+				; store destination

		DMASRC	$0800, EMM_PlaneA			; transfer plane A
		move.w	d1,(a6)					; ''
		move.w	d0,(a6)					; ''

		move.l	#VB_LoadMap2,(V_int_addr).w		; set V-blank routine
		bra.w	VB_StartHBlank				; continue to H-blank setup

	; --- Plane A part 2 ---

VB_LoadMap2:
		movem.l	d0-a3,-(sp)				; store register data
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as read only
		bsr.w	VB_Universal				; transfer standard/universal stuff

		move.l	(EMM_FrameData+$04).l,a1		; set destination address
		move.w	(a1)+,d0				; load plane A address
		move.w	(a1)+,d1				; ''
		addi.w	#$0800,d1				; advance to plane B
		DMASRC	$0800, EMM_PlaneA+$800			; transfer plane B
		move.w	d1,(a6)					; ''
		move.w	d0,(a6)					; ''
		move.l	#VB_LoadMap3,(V_int_addr).w		; set V-blank routine
		bra.w	VB_StartHBlank				; continue to H-blank setup

	; --- Plane B part 1 ---

VB_LoadMap3:
		movem.l	d0-a3,-(sp)				; store register data
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as read only
		bsr.w	VB_Universal				; transfer standard/universal stuff

		move.l	(EMM_FrameData+$04).l,a1		; set destination address
		move.w	(a1)+,d0				; load plane A address
		move.w	(a1)+,d1				; ''
		addi.w	#$2000,d1				; advance to plane B
		DMASRC	$0800, EMM_PlaneB			; transfer plane B
		move.w	d1,(a6)					; ''
		move.w	d0,(a6)					; ''
		move.l	#VB_LoadMap4,(V_int_addr).w		; set V-blank routine
		bra.w	VB_StartHBlank				; continue to H-blank setup


	; --- Plane B part 2 ---

VB_LoadMap4:
		movem.l	d0-a3,-(sp)				; store register data
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as read only
		bsr.w	VB_Universal				; transfer standard/universal stuff

		move.l	(EMM_FrameData+$04).l,a1		; set destination address
		move.w	(a1)+,d0				; load plane A address
		move.w	(a1)+,d1				; ''
		addi.w	#$2800,d1				; advance to plane B
		DMASRC	$0800, EMM_PlaneB+$800			; transfer plane B
		move.w	d1,(a6)					; ''
		move.w	d0,(a6)					; ''

		move.l	#VB_LoadArt,(V_int_addr).w		; set V-blank routine
		moveq	#$00,d0					; clear d0
		move.l	d0,(EMM_FrameData).l			; clear frame transfer data
		move.l	d0,(EMM_FrameData+$04).l		; ''

		bra.w	VB_StartHBlank				; continue to H-blank setup


VB_UpdateOptions:
		tst.b	(EMM_OptionsTrs).l			; has the transfer flag been set last frame?
		bne.s	VBUO_Update				; if so, branch
		tst.b	(EMM_OptionsChg).l			; do the options menu mappings need updating?
		beq.w	VB_StartHBlank				; if not, branch
		sf.b	(EMM_OptionsChg).l			; set options as updated
		st.b	(EMM_OptionsTrs).l			; set transfer flag
		bra.w	VB_StartHBlank				; continue to H-blank setup

VBUO_Update:
	sf.b	(EMM_SlotLoaded).l			; allow non-displaying slot to run next frame
		sf.b	(EMM_OptionsTrs).l			; clear transfer flag
		move.l	(MMC_Slot01Map).l,d1			; load slot 1's mappings
		btst.b	#$04,(EMM_DisplaySlot+$01).l		; are we using slot 1?
		bne.s	VBUO_Transfer				; if so, branch
		move.l	(MMC_Slot02Map).l,d1			; load slot 2's mappings

VBUO_Transfer:
		DMASRC	$0700, EMM_PlaneA+$380			; transfer plane A
		addi.w	#$0380,d1				; advance to starting plane offset
		move.w	d1,(a6)					; set DMA destination
		swap	d1					; ''
		move.w	d1,(a6)					; ''
		bra.w	VB_StartHBlank				; continue to H-blank setup

; ===========================================================================
; ---------------------------------------------------------------------------
; V-Blank (loading art only)
; ---------------------------------------------------------------------------
VBLA_TransSize	=	$400
; ---------------------------------------------------------------------------

VB_LoadArt:
		movem.l	d0-a3,-(sp)				; store register data
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as write only
		bsr.w	VB_Universal				; transfer standard/universal stuff

		lea	(EMM_ArtTransfer).l,a3			; load art transfer DMA register data

		move.w	#VBLA_TransSize,d3			; prepare segment size
		move.w	(a3),d0					; load art size
		sub.w	d3,(a3)+				; minus 1000 size at a time
		bgt.s	VBLA_NoFinish				; if there's more than 1000, branch
		move.w	d0,d3					; load remaining size
		move.l	#VB_SetEffect,(V_int_addr).w		; set V-blank routine

VBLA_NoFinish:
		asr.w	#$01,d3					; divide size by size of word
		move.l	#$93009400,d0				; prepare DMA size registers
		move.w	d3,-(sp)				; load upper byte
		move.b	(sp),d0					; ''
		addq.w	#$02,sp					; restore stack address
		swap	d0					; load lower byte
		move.b	d3,d0					; ''
		move.l	d0,(a6)					; save DMA size
		move.l	(a3)+,(a6)				; save DMA source
		move.w	(a3)+,(a6)				; ''

		addq.b	#(VBLA_TransSize>>$09),-$05(a3)		; increase destination to next 1000 bytes
		bcc.s	VBLA_NoCarryOffset			; if it hasn't overflowed, branch
		addq.b	#$01,-$01(a3)				; increase destination by 10000 bytes

VBLA_NoCarryOffset:
		move.w	(a3),d0					; load destination
		move.w	d0,(a6)					; set DMA destination
		move.w	$02(a3),(a6)				; ''

		move.w	#$3FFF,d2				; prepare VDP mode clear register
		move.w	d0,d1					; store modes
		andi.w	#$C000,d1				; ''
		and.w	d2,d0					; get only address
		addi.w	#VBLA_TransSize,d0			; increase address
		cmp.w	d2,d0					; has the address overflowed into modes?
		bls.s	VBLA_NoCarryDest			; if not, branch
		and.w	d2,d0					; wrap it
		addq.b	#$01,$03(a3)				; add overflow to lower word section (where it's meant to be)

VBLA_NoCarryDest:
		or.w	d1,d0					; restore modes
		move.w	d0,(a3)					; store new address

		bra.w	VB_StartHBlank				; go to set up H-blank

; ===========================================================================
; ---------------------------------------------------------------------------
; V-Blank (last routine - setting the effect to be ran)
; ---------------------------------------------------------------------------

VB_SetEffect:
		movem.l	d0-a3,-(sp)				; store register data
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as write only
		bsr.w	VB_Universal				; transfer standard/universal stuff

		bsr.w	OPT_RandomEffect			; randomly select an effect to use
		sf.b	(EMM_SlotLoaded).l			; set slot as loaded now
		bchg.b	#$04,(EMM_DisplaySlot+$01).l		; swap slot
		bchg.b	#$00,(EMM_ScrollSlot).l			; ''
		move.l	#VB_LevelSelect,(V_int_addr).w		; reset V-blank routine
		bra.w	VB_StartHBlank				; go to set up H-blank

; ===========================================================================
; ---------------------------------------------------------------------------
; H-Blank - Level Select/Options
; ---------------------------------------------------------------------------
	;	align	$1000	; simply for the "addi.w" to "H_int_addr+$02"
	; NAT: Commented out, because it was causing build issues? Keep an eye out for any others!
; ---------------------------------------------------------------------------
HBMM_Buffers:	dc.l	EMM_VScrollA
		dc.l	EMM_WindowA
		dc.l	EMM_VScrollB
		dc.l	EMM_WindowB
; ---------------------------------------------------------------------------

VB_StartHBlank:
		moveq	#-1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as execute tracker

		sf.b	(V_int_routine).w			; clear V-blank flag
		move.w	#$8A00,(a6)				; set scanline to single line

		movea.l	(EMM_VScrollSlot).l,a4			; load V-scroll buffer
		movea.l	(EMM_WindowSlot).l,a5			; load window buffer
		move.l	a4,(EMM_VScrollPrev).l			; store as previous
		move.l	a5,(EMM_WindowPrev).l			; ''

		bchg.b	#$03,(EMM_Buffer).l			; swap buffers
		moveq	#$00,d0					; load new buffer ID
		move.b	(EMM_Buffer).l,d0			; ''
		move.l	HBMM_Buffers+0(pc,d0.w),(EMM_VScrollSlot).l	; set buffers for main loop to write to
		move.l	HBMM_Buffers+4(pc,d0.w),(EMM_WindowSlot).l	; ''

		movem.l	(sp)+,d0-a3				; restore register data
		move.l	#$40000010,d7				; prepare d7 as VSRAM address
		move.l	#HBO_Start,(H_int_addr).w		; set H-blank routine

HBO_Start:
;		rept	$DE
;.Start:	addi.w	#.End-.Start,(H_int_addr+$02).w		; advance to next routine
		move.l	d7,(a6)					; set VDP to VSRAM write mode
		move.l	(a4)+,-$04(a6)				; load V-scroll position
		move.l	(a5)+,(a6)				; write window positions
;		rte						; return
;.End:
;		endm
;		move.l	d7,(a6)					; set VDP to VSRAM write mode
;		move.l	(a4)+,-$04(a6)				; load V-scroll position
;		move.l	(a5)+,(a6)				; write window positions
;		move.l	#HB_LevelSelect,(H_int_addr).w		; set H-blank routine
;		move.w	#$8ADF,(a6)				; force scanline to large amount
;		lea	-$04(a6),a5				; restore VDP data port address

HB_LevelSelect:
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to clear a section of VDP memory using DMA fill
; ---------------------------------------------------------------------------
;		move.l	#$40000080,d0				; VDP mode/address
;		move.w	#$0400,d1				; size to clear
;		jsr	(ClearVDP).l				; clear VDP memory section
; ---------------------------------------------------------------------------

ClearVDP:
		bclr.l	#$07,d0					; clear DMA bit
		move.l	d0,(a6)					; set VDP write mode address
		moveq	#$00,d0					; clear d0
		lsr.w	#$01,d1					; divide size by size of word
		dbf	d1,CV_Clear				; minus 1 for dbf initial
		rts						; return

CV_Clear:
		move.w	d0,(a5)					; clear VDP RAM
		dbf	d1,CV_Clear				; repeat until all clear
		rts						; return

	; --- The original DMA fill version ---
	; CRAM cannot be DMA filled for some reason, and VSRAM
	; appeared to have artifacts a short while after the
	; clear, I don't have time to experiment or analyse it
	; right now, so the above manual method will have to do.

FillVDP:
		move.w	(a6),ccr				; load status (this resets the 2nd write flag too)
		bvs.s	ClearVDP				; if the VDP DMA busy flag was set (bit 1), branch to wait til finished...

		move.w	#$8F01,(a6)				; set increment mode to 1
		move.l	#$97809300,d2				; prepare size register data
		subq.w	#$01,d1					; decrease size by 1
		move.b	d1,d2					; get low byte
		move.l	d2,(a6)					; set DMA source & DMA size low byte
		lsr.w	#$08,d1					; get high byte
		ori.w	#$9400,d1				; load size register
		move.w	d1,(a6)					; set DMA size high byte
		move.l	d0,(a6)					; set DMA destination
		move.w	#$0000,(a5)				; fill location with 0000
		nop						; delay

CVD_Wait:
		move.w	(a6),ccr				; load status
		bvs.s	CVD_Wait				; if the VDP DMA busy flag was set (bit 1), branch to wait til finished...
		move.w	#$8F02,(a6)				; set increment mode to normal
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to randomly select an effect from the list
; ---------------------------------------------------------------------------

OPT_RandomEffect:
;		move.l	#MMW_FlipBars,d0			; set to use flip routine
;		bset.b	#$01,(EMM_FirstEffect).l		; are we meant to run the first effect?
;		bne.s	.NoInitial				; if not, branch
;		move.l	#MMW_Arrows,d0				; set to use arrows routine

	.NoInitial:
;		move.l	d0,(EMM_SwapRout).l			; set effect routine
;		rts						; return


	movea.l	(EMM_StageList).w,a2			; load stage list
	move.l	$28(a2),d0				; get CNZ1 slot ID
	beq.s	MMRE_NoCNZ2				; if there are no special CNZ slots, branch
	sub.l	(a2),d0					; ''
	cmp.w	(EMM_LevelCur).l,d0			; is the current slot on CNZ1?
	;	cmpi.w	#(DataStages_CN1-DataStages),(EMM_LevelCur).l	; is the current slot on CNZ1?
		bne.s	MMRE_NoCNZ1					; if not, branch
	move.l	$2C(a2),d0				; get CNZ2 slot ID
	sub.l	(a2),d0					; ''
	cmp.w	(EMM_LevelPrev).l,d0			; was the previous slot CNZ 2?
	;	cmpi.w	#(DataStages_CN2-DataStages),(EMM_LevelPrev).l	; was the previous slot CNZ 2?
		bne.s	MMRE_NoCNZ1					; if not, branch
		move.l	#MMW_Carnival2,(EMM_SwapRout).l		; set effect as from CNZ 2 to CNZ 1
		rts						; return

MMRE_NoCNZ1:
	move.l	$2C(a2),d0				; get CNZ2 slot ID
	beq.s	MMRE_NoCNZ2				; if there are no special CNZ slots, branch
	sub.l	(a2),d0					; ''
	cmp.w	(EMM_LevelCur).l,d0			; is the current slot on CNZ2?
	;	cmpi.w	#(DataStages_CN2-DataStages),(EMM_LevelCur).l	; is the current slot on CNZ2?
		bne.s	MMRE_NoCNZ2					; if not, branch
	move.l	$28(a2),d0				; get CNZ1 slot ID
	sub.l	(a2),d0					; ''
	cmp.w	(EMM_LevelPrev).l,d0			; was the previous slot CNZ 1?
	;	cmpi.w	#(DataStages_CN1-DataStages),(EMM_LevelPrev).l	; was the previous slot CNZ 1?
		bne.s	MMRE_NoCNZ2					; if not, branch
		move.l	#MMW_Carnival1,(EMM_SwapRout).l		; set effect as from CNZ 1 to CNZ 2
		rts						; return

	; --- Normal random selection ---

MMRE_NoCNZ2:
		lea	(EMM_SwapList).l,a0			; load swap list
		subq.b	#$01,(a0)+				; decrease effect count
		bgt.s	MMRE_ContinueList			; if there are still effects not ran yet, branch

MMRE_FindLast:
		tst.b	(a0)+					; is this the last effect?
		bmi.s	MMRE_FindLast				; if not, keep searching
		move.w	a0,d0					; store address of entry
		moveq	#$00,d1					; clear d1
		lea	(EMM_SwapList).l,a0			; reload swap list
		moveq	#((MM_Swap_End-MM_Swap)/$04)-1,d2	; set number of entries to clear
		move.b	d2,(a0)+				; reset list counter
		lea	(a0),a2					; copy to a2

MMRE_ClearList:
		move.b	d1,(a2)+				; clear swap list
		dbf	d2,MMRE_ClearList			; repeat until it's all cleared
		subq.w	#$01+$01,d0				; minus 1 (due to increment) and another 1 (due to first byte being counter)
		subi.w	#(EMM_SwapList&$FFFF),d0		; get eforntry ID
		bra.s	MMRE_CheckEffect			; set entry and run it

MMRE_NextEffect:
		jsr	Random_Number.w			; get random number
		move.l	d0,(EMM_Random).l			; ''

MMRE_ContinueList:
		moveq	#$00,d0					; clear d0
		move.b	(EMM_Random).l,d0			; load random number
		divu.w	#(MM_Swap_End-MM_Swap)/$04,d0		; divide by number of possible swap list entries
		swap	d0					; get remainder

MMRE_CheckEffect:
	;	tas.b	(a0,d0.w) ; won't work on Mega Drive	; has this effect been ran before?
		tst.b	(a0,d0.w)				; has this effect been ran before?
		bmi.s	MMRE_NextEffect				; if so, branch
		bset.b	#$01,(EMM_FirstEffect).l		; are we meant to run the first effect?
		bne.s	MMRE_NoFirst				; if not, branch
		moveq	#$06,d0					; set effect to use first

MMRE_NoFirst:
		st.b	(a0,d0.w)				; set the entry as ran
		add.w	d0,d0					; multiply entry ID by size of long-word
		add.w	d0,d0					; ''
		move.l	MM_Swap(pc,d0.w),(EMM_SwapRout).l	; set swap effect routine to run
		rts						; return

; ---------------------------------------------------------------------------
; swap effect list
; ---------------------------------------------------------------------------

MM_Swap:
		dc.l	MMW_ScaleShift				; 00 (Original order of creation)
		dc.l	MMW_BarDrop				; 04
		dc.l	MMW_FlipBars				; 08
		dc.l	MMW_ScanVertical			; 0C
		dc.l	MMW_ZoomIn				; 10
		dc.l	MMW_ScanSlits				; 14
		dc.l	MMW_Arrows				; 18
		dc.l	MMW_Triangle				; 1C
		dc.l	MMW_BarSwipe				; 20
		dc.l	MMW_BoxScale				; 24
		dc.l	MMW_Sweep				; 28
		dc.l	MMW_ShrinkFall				; 2C
		dc.l	MMW_LevelFall				; 30
MM_Swap_End:

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutines for swap effects
; ---------------------------------------------------------------------------
; BarProcess:
		include	"Main Menu\Effects\BarProcess.asm"

; ---------------------------------------------------------------------------
; Swap Effect includes
; ---------------------------------------------------------------------------
; MMW_ScaleShift:
		include	"Main Menu\Effects\MMW_ScaleShift.asm"		; MarkeyJester
; MMW_ZoomIn:
		include	"Main Menu\Effects\MMW_ZoomIn.asm"		; Natsumi
; MMW_BarDrop:
		include	"Main Menu\Effects\MMW_BarDrop.asm"		; MarkeyJester
; MMW_FlipBars:
		include	"Main Menu\Effects\MMW_FlipBars.asm"		; MarkeyJester
; MMW_ScanVertical:
		include	"Main Menu\Effects\MMW_ScanVertical.asm"	; MarkeyJester (Idea: Natsumi)
; MMW_ScanSlits:
		include	"Main Menu\Effects\MMW_ScanSlits.asm"	; MarkeyJester
; MMW_Arrows:
		include	"Main Menu\Effects\MMW_Arrows.asm"		; MarkeyJester
; MMW_Triangle:
		include	"Main Menu\Effects\MMW_Triangle.asm"		; Natsumi
; MMW_BarSwipe:
		include	"Main Menu\Effects\MMW_BarSwipe.asm"		; Natsumi
; MMW_Shatter:
;		include	"Main Menu\Effects\MMW_Shatter.asm"		; Natsumi
; MMW_Sweep:
		include	"Main Menu\Effects\MMW_Sweep.asm"		; Natsumi
; MMW_ShrinkFall:
		include	"Main Menu\Effects\MMW_ShrinkFall.asm"		; Natsumi
; MMW_Sort:
;		include	"Main Menu\Effects\MMW_Sort.asm"		; Natsumi
; MMW_BoxScale:
		include	"Main Menu\Effects\MMW_BoxScale.asm"		; MarkeyJester
; MMW_LevelFall:
		include	"Main Menu\Effects\MMW_LevelFall.asm"		; Natsumi

; ---------------------------------------------------------------------------
; Swap Effect - Carnival Night Zone
; ---------------------------------------------------------------------------

	; --- Act 2 ---

MMW_Carnival2:
		moveq	#$00,d0					; set no shaking...
		move.l	d0,(a3)+				; ''
		bra.s	MMWCARN_Run				; continue...

	; --- Act 1 ---

MMW_Carnival1:
		move.w	#$4000,(a3)+				; force angle to 90 degrees
		move.w	#$0600,(a3)+				; set size to start shaking by

	; --- Loading bright light palette ---

		lea	(Normal_palette+$20).w,a1		; load slot 1 palette buffer
		btst.b	#$00,(EMM_ScrollSlot).l			; are we on slot 1?
		beq.s	MMWCARN_Slot1				; if so, branch
		lea	(Normal_palette+$60).w,a1		; load slot 2 palette buffer

MMWCARN_Slot1:
		lea	MMWCARN_Light(pc),a0			; load light palette
		move.l	(a0)+,(a1)+				; copy light palette onto the current palette
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''

MMWCARN_Run:

	; --- Flash counters ---

		move.w	#$0002,(a3)+				; preset on/off flag and counter position
		move.b	#$0A,(a3)+				; timers for each flag
		move.b	#$05,(a3)+				; ''
		move.b	#$04,(a3)+				; ''
		move.b	#$03,(a3)+				; ''
		move.b	#$04,(a3)+				; ''
		st.b	(a3)+					; end marker
		move.l	#MMWCARN_Flash,(EMM_SwapRout).l		; set next routine
		moveq	#$57,d0					; play water splash sound (this is the SFX they used for lights on/off in CNZ)
		jmp	Play_Sound_2.w				; ''

	; -- Light flash colours ---

MMWCARN_Light:	dc.w	$0000,$0200,$0400,$0644,$0C88,$06EE,$06EE,$08AE
		dc.w	$044E,$0EEE,$0E02,$0EEE,$0EEE,$00CC,$00AA,$0022

; ---------------------------------------------------------------------------
; The actual flashing/shaking
; ---------------------------------------------------------------------------

MMWCARN_Flash:
		moveq	#$00,d0					; clear d0
		move.b	(a3),d0					; load angle
		addi.w	#$8000,(a3)+				; rotate it
		add.w	d0,d0					; multiply by size of word
		lea	(SineTable).l,a0			; load sinewave table
		move.w	(a0,d0.w),d0				; load correct sinewave position
		moveq	#$00,d1					; clear d0
		move.b	(a3),d1					; load amount
		beq.s	MMWCARN_NoShake				; if there is not amount, branch to ignore shaking
		subi.w	#$0040,(a3)				; reduce shake amount
		muls.w	d1,d0					; multiply position by amount
		asr.l	#$08,d0					; divide by 100 (angle is x100)
		move.w	d0,d1					; copy to d1 for writing...

MMWCARN_NoShake:
		addi.w	#$0010,d1				; adjust to centre
		move.w	d1,(EMM_PosY_FG1).l			; save to plane positions
		move.w	d1,(EMM_PosY_FG2).l			; ''
		move.w	d1,(EMM_PosY_BG1).l			; ''
		move.w	d1,(EMM_PosY_BG2).l			; ''
		addq.w	#$02,a3					; skip over to palette data

		lea	(a3),a2					; keep a copy of the on/off flag
		moveq	#$00,d2					; clear d2
		move.b	$01(a3),d2				; load counter number
		subq.b	#$01,(a3,d2.w)				; decrease counter
		bpl.s	MMWCARN_NoFinish			; if we're not finished, branch
		moveq	#$00,d0					; clear d0
		move.l	d0,(EMM_SwapRout).l			; finish swap routine
		move.b	d0,(EMM_RunEffect).l			; set effect as NOT running

MMWCARN_NoChange:
		rts						; return

MMWCARN_NoFinish:
		bne.s	MMWCARN_NoChange			; if the counter has not reached 0, branch
		move.w	(EMM_ScrollSlot).l,d0			; load current slot being displayed
		not.b	(a2)+					; change lights on/off status
		beq.s	MMWCARN_NoLights			; if not on, branch
		addi.w	#$0100,d0				; advance to next slot

MMWCARN_NoLights:
		move.w	d0,d1					; place in both words of register
		swap	d0					; ''
		move.w	d1,d0					; ''
		addq.b	#$01,(a2)				; increase couner number
		lea	(EMM_VScroll+($E0*4)).l,a2		; load V-scroll RAM
		move.l	d0,d1					; ''
		move.l	d0,d2					; ''
		move.l	d0,d3					; ''
		move.l	d0,d4					; ''
		move.l	d0,d5					; ''
		move.l	d0,d6					; ''
		move.l	d0,a0					; ''
		move.l	d0,a1					; ''
	rept	$E0/9
		movem.l	d0-d6/a0-a1,-(a2)			; write scroll positions
	endm
		movem.l	d0-d6/a0,-(a2)				; write last scroll positions
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Slot data (think of it as double buffering)
; ---------------------------------------------------------------------------

MMC_Slots:

	; --- Slot 1 ---

		dc.l	Normal_palette+$18						; lines 1 and 2
		dc.l	((VRAMART01/$20)<<$10)|(VRAMART01/$20)				; mapping adds
MMC_Slot01Map:	dc.l	$00834000							; Map VRAM C000/E000
		dc.l	((VRAMART01&$3FFF)<<$10)|((VRAMART01>>$0E)&$03)|$40000080	; Art VRAM

	; --- Slot 2 ---

		dc.l	Normal_palette+$58						; lines 3 and 4
		dc.l	((VRAMART02/$20)<<$10)|(VRAMART02/$20)|$40004000		; mapping adds
MMC_Slot02Map:	dc.l	$00835000							; Map VRAM D000/F000
		dc.l	((VRAMART02&$3FFF)<<$10)|((VRAMART02>>$0E)&$03)|$40000080	; Art VRAM

; ---------------------------------------------------------------------------
; Subroutine to change the background correctly
; ---------------------------------------------------------------------------

MM_ChangeBG:
		tst.w	(EMM_LoadPlane+$02).l			; do we still need to load plane mappings?
		bne.w	MMC_LoadPlane				; if so, branch
		move.l	(EMM_SwapRout).l,d0			; load swap routine
		beq.s	MMC_NoEffect				; if the level is not already swapping, branch
		move.l	d0,a0					; set address
		lea	(EMM_SwapRAM).l,a3			; load swap RAM
		jmp	(a0)					; run routine

MMC_NoEffect:
		tst.b	(EMM_RunEffect).l			; is an effect currently running?
		bne.w	MMC_Return				; if so, branch
		move.w	(EMM_Level).l,d0			; load level selected
		cmp.w	(EMM_LevelCur).l,d0			; has it changed?
		beq.w	MMC_Return				; if not, branch
		move.w	(EMM_LevelCur).l,(EMM_LevelPrev).l	; store previous level
		move.w	d0,(EMM_LevelCur).l			; update current level selected
		st.b	(EMM_RunEffect).l			; set effect as about to run/is running

		move.w	(EMM_DisplaySlot).l,d1			; load slot
		lea	MMC_Slots(pc,d1.w),a1			; load slot data address

	movea.l	(EMM_StageList).w,a2			; load stage list
	movea.l	(a2),a0					; load correct level data
	;	lea	(DataStages).l,a0			; load correct level data
		move.l	(a0,d0.w),a0				; ''
		moveq	#$00,d0					; clear d0
		lea	(EMM_Scroll1).l,a2			; write scroll address to correct scroll slot
		move.l	(a0)+,(a2,d1.w)				; ''
		move.l	(a0)+,$04(a2,d1.w)			; write palette cycling routine
		move.l	d0,$08(a2,d1.w)				; clear palette timers
		move.l	(a0)+,$0C(a2,d1.w)			; write art cycling routine
		move.l	d0,$20(a2,d1.w)				; clear art timers
		move.l	(a0)+,$24(a2,d1.w)			; write scroll extra routine
		move.l	d0,$28(a2,d1.w)				; clear scroll extra timers

		move.l	(a0)+,$40(a2,d1.w)			; set Y scroll speed for FG
		move.l	(a0)+,$44(a2,d1.w)			; set Y scroll speed for BG
		move.l	(a0)+,$48(a2,d1.w)			; set Y scroll position for FG
		move.l	(a0)+,$4C(a2,d1.w)			; set Y scroll position for BG

		move.l	d0,$60(a2,d1.w)				; clear extended timer
		move.l	(a0)+,a2				; load palette
		move.l	(a1)+,a3				; load palette RAM
		moveq	#($28/$04)-1,d1				; set number of colours to copy

MMC_NextPal:
		move.l	(a2)+,(a3)+				; load colours
		dbf	d1,MMC_NextPal				; repeat til palette is loaded
		st.b	(EMM_UpdatePal).l			; set to update the palette

		lea	(EMM_LoadPlane).l,a2			; load plane map data
		clr.w	(a2)+					; clear map size to load
		move.w	#$0002+1,(a2)+				; set number of planes to load
		move.l	(a1)+,(a2)+				; load map add values
		move.l	#EMM_PlaneData,(a2)+			; load RAM space to dump mappings to
		move.w	#-$04,(a2)+				; reset list position (below is the list, plane A, plane B, etc...)
		move.l	(a0)+,(a2)+				; load plane A mapping data
		move.l	(a0)+,(a2)+				; load plane B mapping data

		move.b	(EMM_DisplaySlot+$01).l,d0		; load the current display slot
		add.b	d0,d0					; shift the bit to near MSB
		add.b	d0,d0					; ''
		ori.b	#$80,d0					; set MSB as now loading a slot
		move.b	d0,(EMM_SlotLoaded).l			; set slot as not loaded yet (with bit 6 being the slot to use)

		move.l	a0,(EMM_FrameData).l			; store source address data
		move.l	a1,(EMM_FrameData+$04).l		; store destination address data

MMC_Return:
		rts						; return

; ---------------------------------------------------------------------------
; Subroutine to load and convert map data into RAM correctly for DMA later
; ---------------------------------------------------------------------------
MMC_LoadSize	=	$400
; ---------------------------------------------------------------------------

MMC_LoadPlane:
		lea	(EMM_LoadPlane).l,a2			; load plane map data
		move.w	(a2)+,d0				; load size left to transfer
		bne.s	MMCLP_NoNextPlane			; if there's still something to transfer from this plane, branch
	sf.b	(EMM_DecPlane).l
		move.w	#$1000,d0				; reset size
		move.w	d0,-$02(a2)				; ''
		subq.w	#$01,(a2)				; minus plane count
		beq.s	MMC_CheckExtra				; if there are no planes left, branch
		addq.w	#$04,$0A(a2)				; increase plane position

MMCLP_NoNextPlane:
		addq.w	#$02,a2					; skip over plane count
		move.l	(a2)+,d1				; load map add values
		move.l	(a2)+,a3				; load buffer dump address
		move.w	(a2)+,d2				; load slot ID
		move.l	(a2,d2.w),a2				; load correct map data address

	; a2 = source mappings
	; a3 = RAM dump address
	; d1 = map add values
	; d0 = Total size left to copy

	tst.b	(EMM_DecPlane).l			; has the plane been decompressed yet?
	bne.s	MMCLP_Transfer				; if so, branch
	lea	(a2),a0					; copy mappings address to a0
	lea	(a3),a1					; copy dump address to a1
	jsr	MunDec					; decompress and dump
	tst.l	(EMM_Huffman+$208).w			; was an address saved?  (i.e. is it split and needs to continue decompressing a next frame?
	seq.b	(EMM_DecPlane).l			; if not, set decompression as done
	rts						; return

MMCLP_Transfer:
		move.w	#MMC_LoadSize,d2			; set size to transfer at a time
		sub.w	d2,d0					; minus from total size to transfer
		bpl.s	MMCLP_NoFinish				; if there's still size to transfer afterwards, branch
		add.w	d0,d2					; get remaining size
		moveq	#$00,d0					; clear remaining size

MMCLP_NoFinish:
		lea	(EMM_LoadPlane).l,a1			; load plane map data
		move.w	d0,(a1)					; update size

		lsr.w	#$05,d2					; divide by 20 (20 bytes at a time)
		subq.w	#$01,d2					; minus 1 for dbf

MMC_LoadMappings:
		rept	$08
	;	move.l	(a2)+,d0				; load mappings
	;	add.l	d1,d0					; adjust to correct VRAM
	;	move.l	d0,(a3)+				; dump to buffer
	add.l	d1,(a3)+
		endm
		dbf	d2,MMC_LoadMappings			; repeat til all mappings are loaded
		lea	$08(a1),a1				; advance to RAM dump address
		move.l	a3,(a1)+				; save RAM dump address
		move.w	(a1)+,d0				; load slot ID
		move.l	a2,(a1,d0.w)				; save source map address
		rts						; return

MMC_CheckExtra:
		moveq	#$00,d4		; !!! prepare to use current slot (slot ID doesn't change til AFTER the mappings are transfer and the effect is set)
		cmpi.l	#MM_SM_Options,(EMM_ScreenMode).w	; are we in the options menu?
		beq.s	MMC_RenderOptFull			; if so, branch
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Mapping a full screen of options
; ---------------------------------------------------------------------------
MM_SFX		=	$65		; SFX to use when changing an option
MM_MapFirst	=	$08
MM_MapSecond	=	$28+MM_MapFirst
MM_MapSound	=	$16+MM_MapSecond
; ---------------------------------------------------------------------------

MM_RenderOptions:
		tst.b	(EMM_OptionsChg).l			; have the options been updated?
		beq.s	MM_Return				; if not, branch

	; Setting non-displaying slot to not run, just
	; while options stuff is transfering/update
	; .. (Not enough time to do both)

	move.b	(EMM_DisplaySlot+$01).l,d0		; load the current display slot
	add.b	d0,d0					; shift the bit to near MSB
	add.b	d0,d0					; ''
	ori.b	#$80,d0					; set MSB as now loading a slot
	move.b	d0,(EMM_SlotLoaded).l			; set slot as not loaded yet (with bit 6 being the slot to use)

	; --- --- --- --- --- ---

		moveq	#$10,d4					; prepare to reverse the slot bit (slot will be opposite of plane)

MMC_RenderOptFull:
		moveq	#$00,d3					; reset destination
		lea	(MM_OptionText).l,a0			; load options menu list
		move.l	(a0)+,a1				; load plane mappings address
		addq.w	#$04,a0					; skip over routine
		moveq	#$00,d6					; reset selection counter
		bra.s	MM_ReadEntry				; branch intot he loop

MM_NextEntry:
		addq.w	#$02,a0					; advance to render routine
		lsr.w	#$01,d0					; get multiple 80
		andi.w	#$0F80,d0				; ''
		adda.w	d0,a1					; add space amount
		lsr.w	#$04,d0					; divide to x8
		addi.w	#$0010,d0				; add an extra 2 tiles worth
		add.w	d0,d3					; add to box destination

MM_ReadEntry:
		move.w	(EMM_DisplaySlot).l,d5			; load slot being used
		eor.b	d4,d5					; reverse slot being used
		ror.w	#$06,d5					; shift to palette slot
		addi.w	#$2000|(($0135+MMSC_VRAMMAIN)+1),d5	; advance to VRAM location (and slot palette)
		cmp.b	(EMM_OptSelect).w,d6			; is this option being selected?
		bne.s	MM_NoHighlight				; if so, branch
		move.w	#(($0135+MMSC_VRAMMAIN)+1),d5		; set to use highlighted palette line VRAM address
		move.w	d3,(EMM_OptionDestY).l			; save actual destination now...

MM_NoHighlight:
		move.l	(a0)+,a2				; load render routine
	move.l	d3,-(sp)
		jsr	(a2)					; run routine
	move.l	(sp)+,d3
		lea	$100(a1),a1				; advance to next line
		addq.b	#$01,d6					; increase selection counter
		move.w	(a0)+,d0				; load space amount
		bpl.s	MM_NextEntry				; if this is a valid entry, branch


	; Old code to render the sound test string right after the last entry
	; (of which the last one should be the sound test)
	;	moveq	#$00,d0					; clear d0
	;	move.b	(EMM_SoundTest).w,d0			; load sound test ID
	;	add.w	d0,d0					; multiply by size of long-word
	;	add.w	d0,d0					; ''
	;	move.l	MM_SoundString(pc,d0.w),a3		; load correct string
	;	lea	MM_MapFirst(a1),a2			; load plane map address
	;	bra.w	MM_RenderString				; dump string

MM_Return:
		rts						; return

; ---------------------------------------------------------------------------
; Sound test string list
; ---------------------------------------------------------------------------

MM_SoundString:		; Nothing, there's no sound test anymore...

; ---------------------------------------------------------------------------
; Options data
; ---------------------------------------------------------------------------

MM_OptionText:	dc.l	EMM_PlaneA+$0380

		;	(Spacer)|Control rout,	Render rout

		dc.l	($00<<$18)|MMOT_EndMon,		MMOR_EndMon
		dc.l	($00<<$18)|MMOT_FlyMon,		MMOR_FlyMon
		dc.l	($00<<$18)|MMOT_Monitor,	MMOR_Monitor
		dc.l	($00<<$18)|MMOT_GameMode,	MMOR_GameMode
		dc.l	($00<<$18)|MMOT_Layout,		MMOR_Layout
		dc.l	($00<<$18)|MMOT_Bounce,		MMOR_Bounce
		dc.l	($00<<$18)|MMOT_ShlMv,		MMOR_ShlMv


	;	dc.l	($00<<$18)|MMOT_SoundTest,	MMOR_SoundTest	; Old sound test...

		dc.w	$FFFF	; end marker

; ===========================================================================
; ---------------------------------------------------------------------------
; Game mode selection
; ---------------------------------------------------------------------------

	; --- Controls ---

MMOT_GameMode:
		lea	MMOD_GameMode(pc),a1			; load string to dump
		bra.w	Options_Control

	; --- Render ---

MMOR_GameMode:
		move.l	a0,-(sp)				; store a1 away
		lea	MMOD_GameMode(pc),a0			; load string to dump
		bra.s	Options_Render

; ===========================================================================
; ---------------------------------------------------------------------------
; Monitor mode selection
; ---------------------------------------------------------------------------

	; --- Controls ---

MMOT_Layout:
		lea	MMOD_Layout(pc),a1			; load string to dump
		bra.s	Options_Control

	; --- Render ---

MMOR_Layout:
		move.l	a0,-(sp)				; store a1 away
		lea	MMOD_Layout(pc),a0			; load string to dump
		bra.s	Options_Render

; ===========================================================================
; ---------------------------------------------------------------------------
; Monitor mode selection
; ---------------------------------------------------------------------------

	; --- Controls ---

MMOT_Monitor:
		lea	MMOD_Monitor(pc),a1			; load string to dump
		bra.s	Options_Control

	; --- Render ---

MMOR_Monitor:
		move.l	a0,-(sp)				; store a1 away
		lea	MMOD_Monitor(pc),a0			; load string to dump
		bra.s	Options_Render

; ===========================================================================
; ---------------------------------------------------------------------------
; End flag monitor mode selection
; ---------------------------------------------------------------------------

	; --- Controls ---

MMOT_EndMon:
		lea	MMOD_EndMon(pc),a1			; load string to dump
		bra.s	Options_Control

	; --- Render ---

MMOR_EndMon:
		move.l	a0,-(sp)				; store a1 away
		lea	MMOD_EndMon(pc),a0			; load string to dump
		bra.s	Options_Render

; ===========================================================================
; ---------------------------------------------------------------------------
; Floating flag monitor mode selection
; ---------------------------------------------------------------------------

	; --- Controls ---

MMOT_FlyMon:
		lea	MMOD_FlyMon(pc),a1			; load string to dump
		bra.s	Options_Control

	; --- Render ---

MMOR_FlyMon:
		move.l	a0,-(sp)				; store a1 away
		lea	MMOD_FlyMon(pc),a0			; load string to dump
		bra.s	Options_Render

; ===========================================================================
; ---------------------------------------------------------------------------
; Floating flag monitor mode selection
; ---------------------------------------------------------------------------

	; --- Controls ---

MMOT_Bounce:
		lea	MMOD_Bounce(pc),a1			; load string to dump
		bra.s	Options_Control

	; --- Render ---

MMOR_Bounce:
		move.l	a0,-(sp)				; store a1 away
		lea	MMOD_Bounce(pc),a0			; load string to dump
		bra.s	Options_Render

; ===========================================================================
; ---------------------------------------------------------------------------
; Floating flag monitor mode selection
; ---------------------------------------------------------------------------

	; --- Controls ---

MMOT_ShlMv:
		tst.b	Level_select_flag.w			; check if option is enabled
		beq.s	MMOT_Return				; branch if not
		lea	MMOD_ShlMv2(pc),a1			; load string to dump
		bra.s	Options_Control

MMOT_Return:
		rts

	; --- Render ---

MMOR_ShlMv:
		move.l	a0,-(sp)				; store a1 away
		lea	MMOD_ShlMv(pc),a0			; load string to dump

		tst.b	Level_select_flag.w			; check if option is enabled
		beq.s	Options_Render				; branch if not
		lea	MMOD_ShlMv2(pc),a0			; load string to dump

; ===========================================================================
; ---------------------------------------------------------------------------
; Generic methods for changing settings and rendering
; ---------------------------------------------------------------------------

Options_Render:
		move.l	(a0)+,a3				; load string to dump
		lea	MM_MapFirst(a1),a2			; load plane map address
		bsr.w	MM_RenderString				; dump string

		move.b	(a0),d0					; load bit to test
		move.l	(a0)+,a3				; load "no" string
		btst.b	d0,(EMM_OptionsBits).w			; is floating monitors mode enabled?
		beq.s	.got					; if not, branch
		move.l	(a0)+,a3				; load "yes" string

.got		move.l	(sp)+,a0				; load a1 back
		lea	MM_MapSecond(a1),a2			; load plane map address
		bra.w	MM_RenderString				; dump string

Options_Control:
		andi.b	#%00001100,d1				; get only left/right buttons
		beq.s	MMOT_Return				; if neither we pressed, branch

		move.b	4(a1),d1				; load bit to test
		bchg.b	d1,(EMM_OptionsBits).w			; change the option
		st.b	(EMM_OptionsChg).l			; set to update the options menu
		moveq	#MM_SFX,d0				; play change SFX
		jmp	Play_Sound_2.w				; ''
; ---------------------------------------------------------------------------

MMOD_GameMode:	dc.l MMOS_GameMode, (5<<24)|MMOS_No, MMOS_Yes
MMOD_Layout:	dc.l MMOS_Layout, (7<<24)|MMOS_Original, MMOS_Altered
MMOD_Monitor:	dc.l MMOS_Monitor, (0<<24)|MMOS_Normal, MMOS_Random
MMOD_EndMon:	dc.l MMOS_EndMon, (1<<24)|MMOS_No, MMOS_Yes
MMOD_FlyMon:	dc.l MMOS_FlyMon, (2<<24)|MMOS_No, MMOS_Yes
MMOD_Bounce:	dc.l MMOS_Bounce, (4<<24)|MMOS_No, MMOS_Yes
MMOD_ShlMv:	dc.l MMOS_ShlMv, (6<<24)|MMOS_No, MMOS_No
MMOD_ShlMv2:	dc.l MMOS_ShlMv2, (6<<24)|MMOS_No, MMOS_Yes

; ===========================================================================
; ---------------------------------------------------------------------------
; Sound Test selection
; ---------------------------------------------------------------------------

	; --- Controls ---

MMOT_SoundTest:
		move.b	(EMM_SoundTest).w,d0			; load sound test number
		lsr.b	#$03,d1					; shift left button into carry
		bcc.s	MMOMM_NoLeft				; if left was not pressed, branch
		lsr.b	#$01,d1					; shift right button out (since we need d1 in position)
		subq.b	#$01,d0					; decrease ID by 1 (left)
		bcc.s	MMOMM_Update				; if it hasn't dropped below 0, branch
		moveq	#$DF,d0					; reset to DF
		bra.s	MMOMM_Update				; continue

MMOMM_NoLeft:
		lsr.b	#$01,d1					; shift right button into carry
		bcc.s	MMOMM_NoRight				; if right was not pressed, branch
		addq.b	#$01,d0					; increase ID by 1
		cmpi.b	#$E0,d0					; has it reached E0?
		bcs.s	MMOMM_Update				; if not, branch
		moveq	#$00,d0					; reset to 0
		bra.s	MMOMM_Update				; continue

MMOMM_NoRight:
		btst	#$02,d1					; check A button
		beq.s	MMOMM_NoDec				; if not pressed, branch
		addi.b	#-$10,d0				; decrease ID by 10
		bcs.s	MMOMM_Update				; if still positive, branch
		addi.b	#$E0,d0					; wrap it
		bra.s	MMOMM_Update				; continue

MMOMM_NoDec:
		btst.l	#$01,d1					; check C
		beq.s	MMOMM_NoChange				; if neither were pressed, branch
		addi.b	#$10,d0					; increas ID by 10
		cmpi.b	#$E0,d0					; has it reached E0?
		bcs.s	MMOMM_Update				; if not, branch
		subi.b	#$E0,d0					; wrap it

MMOMM_Update:
		move.b	d0,(EMM_SoundTest).w			; update sound ID
		st.b	(EMM_OptionsChg).l			; set to update the options menu

MMOMM_NoChange:
		btst.l	#$03,d1					; check Start
		beq.s	MMOMM_NoPlay				; if not pressed, branch

		cmpi.b	#$33,d0					; is it an SFX?
		bhs.s	MMOMM_NoMainMenu			; if so, branch
		bclr.b	#$07,(EMM_MusicMM).l			; set main menu to play again on return
		tst.b	d0					; is the sound ID 00?
		bne.s	MMOMM_NoFade				; if not, branch
		moveq	#-$1F,d0				; set to play the fade out effect
		bra.s	MMOMM_NoMainMenu			; play the fade out effect

MMOMM_NoFade:
		cmpi.b	#Mus_MainMenu,d0			; has the main menu been requested to play?
		bne.s	MMOMM_NoMainMenu			; if so, branch
		bset.b	#$07,(EMM_MusicMM).l			; set to not play it again on return

MMOMM_NoMainMenu:
		jmp	Play_Sound_2.w				; set to play the sound ID requested

MMOMM_NoPlay:
		rts						; return

	; --- Render ---

MMOR_SoundTest:
		lea	MMOS_SoundTest(pc),a3			; load string to dump
		lea	MM_MapFirst(a1),a2			; load plane map address
		bsr.w	MM_RenderString				; dump string
		lea	MM_StringNULL(pc),a3			; load null string
		move.b	(EMM_SoundTest).w,d0			; load number
		beq.s	MMORS_WriteType				; if no ID has been select (i.e. 00), branch
		lea	MM_StringBGM(pc),a3			; load "music" string
		cmpi.b	#$33,d0					; is it a music track?
		bcs.s	MMORS_WriteType				; if so, branch
		cmpi.b	#$DC,d0					; is it Sonic & knuckles credits?
		beq.s	MMORS_WriteType				; if so, branch
		lea	MM_StringSFX(pc),a3			; load "sound" string

MMORS_WriteType:
		lea	MM_MapSound-$10(a1),a2			; load plane map address
		bsr.w	MM_RenderString				; dump string
		move.b	(EMM_SoundTest).w,d0			; load number
		lea	MM_MapSound(a1),a2			; load plane map address
		bra.w	MM_RenderNumber				; dump string

MM_StringNULL:	dc.b	"        ",$00
MM_StringBGM:	dc.b	"MUSIC - ",$00
MM_StringSFX:	dc.b	"SOUND - ",$00

; ---------------------------------------------------------------------------
; Options strings...
; ---------------------------------------------------------------------------

MMOS_GameMode:	dc.b	"LEVEL BOSSES",$00
MMOS_Layout:	dc.b	"LAYOUT MODE",$00
MMOS_Monitor:	dc.b	"MONITOR MODE",$00
MMOS_EndMon:	dc.b	"SIGNPOST MONITORS",$00
MMOS_FlyMon:	dc.b	"FLOATING MONITORS",$00
MMOS_Bounce:	dc.b	"BOUNCE MODE",$00
MMOS_ShlMv:	dc.b	"SECRET OPTION",$00
MMOS_ShlMv2:	dc.b	"ABC RESPAWN",$00
MMOS_SoundTest:	dc.b	"SOUND TEST",$00

MMOS_Minigame:	dc.b	"     MINIGAME",$00
MMOS_Original:	dc.b	"     ORIGINAL",$00
MMOS_Altered:	dc.b	"      ALTERED",$00
MMOS_Normal:	dc.b	"       NORMAL",$00
MMOS_Random:	dc.b	"       RANDOM",$00
MMOS_Yes:	dc.b	"          YES",$00
MMOS_No:	dc.b	"       NO WAY",$00
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to render a normal string from inside a3 into RAM at a2
; ---------------------------------------------------------------------------

MMRS_Dash:
		move.w	d5,d0					; load VRAM address
		addi.w	#($0A*2)-1,d0				; advance to dash art
		move.w	d0,$80(a2)				; write bottom dash tile
		bra.s	MMRS_TopSpace				; continue back to top of loop

MMRS_Space:
		clr.w	$80(a2)					; clear character

MMRS_TopSpace:
		clr.w	(a2)+					; ''

MM_RenderString:
		moveq	#$00,d0					; clear d0
		move.b	(a3)+,d0				; load character
		beq.s	MMRS_Finish				; if there are no characters, branch

MMRS_ReadChar:
		cmpi.b	#'-',d0					; is the character a "-" symbol?
		beq.s	MMRS_Dash				; if so, branch
		subi.b	#'0',d0					; minus starting number
		bmi.s	MMRS_Space				; the character must be a space if it's negative
		cmpi.b	#9,d0					; is it a number?
		bls.s	MMRS_Number				; if so, branch
		subq.b	#'A'-('9'+$02),d0			; adjust correctly

MMRS_Number:
		add.w	d0,d0					; multiply by 2 (2 tiles per character)
		add.w	d5,d0					; advance to correct VRAM address
		move.w	d0,$80(a2)				; write bottom tile
		subq.w	#$01,d0					; move to top tile
		move.w	d0,(a2)+				; write top tile
		moveq	#$00,d0					; clear d0
		move.b	(a3)+,d0				; load character
		bne.s	MMRS_ReadChar				; if it's a valid character, branch

MMRS_Finish:
		rts						; return

; ---------------------------------------------------------------------------
; Subroutine to render a byte from inside d0 into RAM at a2
; ---------------------------------------------------------------------------

MM_RenderNumber:
		moveq	#$00,d1					; clear d1
		move.b	d0,d1					; load number
		lsr.b	#$04,d1					; get first nybble
		bsr.s	MMRN_Rend				; dump digit
		move.b	d0,d1					; load number
		andi.w	#$000F,d1				; get second nybble

MMRN_Rend:
		cmpi.b	#$09,d1					; has it passed 9?
		bls.s	MMRN_NoLetter				; if not, branch
		addq.b	#$01,d1					; advance to letters

MMRN_NoLetter:
		add.w	d1,d1					; multiply by 2 (2 tiles per character)
		add.w	d5,d1					; advance to correct VRAM address
		move.w	d1,$80(a2)				; write bottom tile
		subq.w	#$01,d1					; move to top tile
		move.w	d1,(a2)+				; write top tile
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to scroll the background
; ---------------------------------------------------------------------------
MMS_PlaneA	=	$00
MMS_PlaneB	=	$04
MMS_VScrollA	=	EMM_VScrollA-EMM_HScroll
MMS_VScrollB	=	EMM_VScrollB-EMM_HScroll
MMS_HScrollA	=	$00
MMS_HScrollB	=	$02
; ---------------------------------------------------------------------------

MM_Scroll:

		lea	($FFFF0000).l,a3			; load quick reference RAM

		move.l	(EMM_Scroll1).l,(a3)			; copy "scroll 1" address
		move.l	(EMM_Scroll2).l,$100(a3)		; copy "scroll 2" address

	; --- Plane A Slot 1 ---

		lea	(EMM_SpeedY_FG1).l,a0			; add speed to positions for all slots/planes
		lea	(EMM_PosY_FG1).l,a1			; ''

		move.l	(a0)+,d0				; load Y speed
		add.l	(a1),d0					; add position
		move.l	d0,(a1)+				; update
		move.b	-$03(a1),MMS_PlaneA(a3)			; save new scroll position to plane A slot 1

	; --- Plane B Slot 1 ---

		move.l	(a0)+,d0				; load Y speed
		add.l	(a1),d0					; add position
		move.l	d0,(a1)+				; update
		move.b	-$03(a1),MMS_PlaneB(a3)			; save new scroll position to plane B slot 1

	; --- Plane A Slot 2 ---

		lea	(EMM_SpeedY_FG2).l,a0			; add speed to positions for all slots/planes
		lea	(EMM_PosY_FG2).l,a1			; ''

		move.l	(a0)+,d0				; load Y speed
		add.l	(a1),d0					; add position
		move.l	d0,(a1)+				; update
		move.b	-$03(a1),$100+MMS_PlaneA(a3)		; save new scroll position to plane A slot 2

	; --- Plane B Slot 2 ---

		move.l	(a0)+,d0				; load Y speed
		add.l	(a1),d0					; add position
		move.l	d0,(a1)+				; update
		move.b	-$03(a1),$100+MMS_PlaneB(a3)		; save new scroll position to plane B slot 2

; ---------------------------------------------------------------------------
; The actual scroll handler itself...
; ---------------------------------------------------------------------------

		lea	(EMM_VScroll).l,a0			; load V-scroll address
		lea	(EMM_HScroll).l,a3			; load H-scroll address (and V-scroll buffers)#

		moveq	#-$01,d0				; prepare RAM address FFFF####
		moveq	#$00,d3					; reset scanline count
		move.w	#$0100,d4				; prepare AND value
		lea	MMS_VScrollB(a3),a2			; V-scroll table in slot B
		btst.b	#$03,(EMM_Buffer).l			; is H-blank displaying buffer A?
		bne.w	MMS_BufferB				; if so, write to buffer B instead
		lea	MMS_VScrollA(a3),a2			; V-scroll table in slot A

MMS_BufferB:
		rept	$E0

	; --- FG ---

		move.w	(a0)+,d0				; load V-scroll position
		add.w	d3,d0					; advance to correct scanline
		moveq	#$00,d1					; get only scanline itself
		move.b	d0,d1					; ''
		and.w	d4,d0					; get only slot to use
		move.l	d0,a1					; set slot scroll address
		add.b	(a1),d1					; add plane/slot Y position
		move.l	(a1)+,a1				; load correct scroll slot address
		move.b	d1,d0					; fuse back with slot bit
		sub.w	d3,d0					; minus scanline advancing
		move.w	d0,(a2)+				; save to V-scroll buffer
		add.w	d1,d1					; multiply scanline by long-word
		add.w	d1,d1					; ''
		movea.w	MMS_HScrollA(a1,d1.w),a1		; load correct scroll RAM position
		move.w	(a1),(a3)+				; save to scroll buffer

	; --- BG ---

		move.w	(a0)+,d0				; load V-scroll position
		add.w	d3,d0					; advance to correct scanline
		moveq	#$00,d1					; get only scanline itself
		move.b	d0,d1					; ''
		and.w	d4,d0					; get only slot to use
		move.l	d0,a1					; set slot scroll address
		add.b	MMS_PlaneB(a1),d1			; add plane/slot Y position
		move.l	(a1),a1					; load correct scroll slot address
		move.b	d1,d0					; fuse back with slot bit
		sub.w	d3,d0					; minus scanline advancing
		move.w	d0,(a2)+				; save to V-scroll buffer
		add.w	d1,d1					; multiply scanline by long-word
		add.w	d1,d1					; ''
		movea.w	MMS_HScrollB(a1,d1.w),a1		; load correct scroll RAM position
		move.w	(a1),(a3)+				; save to scroll buffer

	; --- --- ---

		addq.w	#$01,d3					; increase scanline count
		endm
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Macros for background data below...
; ---------------------------------------------------------------------------
DSDAT		macro	Palette, Art, ArtE, PlaneA, PlaneB, Scroll, ScrollExtra, PalCycle, ArtCycle, SpeedYFG, SpeedYBG, PosYFG, PosYBG
		dc.l	Scroll					; scroll list of RAM words containing positions to use
		dc.l	PalCycle				; palette cycling routine to run
		dc.l	ArtCycle				; art cycling routine to run
		dc.l	ScrollExtra				; scrolling routine to run (if a normal list isn't enough, e.g. AIZ's heat wave)
		dc.l	SpeedYFG				; FG vertical scrolling speed (QQQQ.FFFF)
		dc.l	SpeedYBG				; BG vertical scrolling speed (QQQQ.FFFF)
		dc.l	PosYFG
		dc.l	PosYBG
		dc.l	Palette					; palette of colours to use
		dc.l	PlaneA, PlaneB				; plane mappings to use
		dc.w	ArtE-Art				; size of art to load
			; v source of art address in DMA register format v
		dc.l	((((((Art&$FFFFFF)/$02)<<$08)&$FF0000)+(((Art&$FFFFFF)/$02)&$FF))+$96009500)
		dc.w	(((((Art&$FFFFFF)/$02)&$7F0000)>>$10)+$9700)
		endm
; ---------------------------------------------------------------------------
F	=	$00	; Forwards scrolling
B	=	$02	; Backwards scrolling
; ---------------------------------------------------------------------------
SCRL		macro	Scanlines, DirectA, SpeedA, DirectB, SpeedB
	;	Scroll RAM loc + (((Max speed - Requested Speed) / Speed per element) * size of long-word)
		rept	Scanlines
		if SpeedA==0
			dc.w	$0000
		else
			if (SpeedA&$40)==0
				dc.w	(Scroll+((($1000-SpeedA)/$40)*4))+DirectA
			else
				dc.w	(Scroll+((($1000-SpeedA)/$40)*4))+((DirectA+$02)&$02)
			endif
		endif
		if SpeedB==0
			dc.w	$0000
		else
			if (SpeedB&$40)==0
				dc.w	(Scroll+((($1000-SpeedB)/$40)*4))+DirectB
			else
				dc.w	(Scroll+((($1000-SpeedB)/$40)*4))+((DirectB+$02)&$02)
			endif
		endif
		endm
		endm
; ---------------------------------------------------------------------------
TEXT		macro	Act, Name
		dc.l	.Start
		dc.b	$00
		dc.b	Name
.Start:		dc.b	Act
		even
		endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Normal stages
; ---------------------------------------------------------------------------

DataPointers:	dc.l	DataStages			; 00	; Start pointer
		dc.l	DataStages_Size			; 04	; End pointer
		dc.l	DataStages_OPT			; 08	; Options pointer
		dc.l	DataStages_NUL			; 0C	; Null slot pointer (for going into level)
		dc.l	DataStages_Lev			; 10	; Start of levels pointer
		dc.l	DataStages_RAN			; 14	; Random level pointer
		dc.l	RandomLevList			; 18	; Random level list
		dc.l	MMCL_Zones			; 1C	; Random list
		dc.l	(MMCL_Zones_End-MMCL_Zones)/4	; 20	; Random list end
		dc.l	EMM_LevelHighlt			; 24	; Last level highlighted
		dc.l	DataStages_CN1			; 28	; CNZ 1 pointer
		dc.l	DataStages_CN2			; 2C	; CNZ 2 pointer

	; --- The list itself ---

DataStages:	dc.l	Data_NODAT
		dc.l	Data_NODAT
		dc.l	Data_NODAT
DataStages_OPT:	dc.l	Data_OPTIONS
DataStages_NUL:	dc.l	Data_NODAT
DataStages_Lev:	dc.l	Data_AIZ01
		dc.l	Data_AIZ02
		dc.l	Data_HCZ01
		dc.l	Data_HCZ02
		dc.l	Data_MGZ01
		dc.l	Data_MGZ02
DataStages_CN1:	dc.l	Data_CNZ01
DataStages_CN2:	dc.l	Data_CNZ02
		dc.l	Data_ICZ01
		dc.l	Data_ICZ02
		dc.l	Data_LBZ01
		dc.l	Data_LBZ02
		dc.l	Data_MHZ01
		dc.l	Data_MHZ02
		dc.l	Data_FBZ01
		dc.l	Data_FBZ02
		dc.l	Data_SOZ01
		dc.l	Data_SOZ02
		dc.l	Data_LRZ01
		dc.l	Data_LRZ02
		dc.l	Data_HPZ01
		dc.l	Data_SSZ01
		dc.l	Data_DEZ01
		dc.l	Data_DEZ02
	;	dc.l	Data_NODAT
	;	dc.l	Data_NODAT
DataStages_RAN:	dc.l	Data_RANDOM
DataStages_Size:

; ---------------------------------------------------------------------------
; Level zone/act list
; ---------------------------------------------------------------------------

MMCL_Zones:	dc.w	$0000,$0000		; AIZ 1
		dc.w	$0001,$0000		; AIZ 2
		dc.w	$0100,$0000		; HCZ 1
		dc.w	$0101,$0000		; HCZ 2
		dc.w	$0200,$0000		; MGZ 1
		dc.w	$0201,$0000		; MGZ 2
		dc.w	$0300,$0000		; CNZ 1
		dc.w	$0301,$0000		; CNZ 2
		dc.w	$0500,$0000		; ICZ 1
		dc.w	$0501,$0000		; ICZ 2
		dc.w	$0600,$0000		; LBZ 1
		dc.w	$0601,$0000		; LBZ 2
		dc.w	$0700,$0000		; MHZ 1
		dc.w	$0701,$0000		; MHZ 2
		dc.w	$0400,$0000		; FBZ 1
		dc.w	$0401,$0000		; FBZ 2
		dc.w	$0800,$0000		; SPZ 1
		dc.w	$0801,$0000		; SPZ 2
		dc.w	$0900,$0000		; LRZ 1
		dc.w	$0901,$0000		; LRZ 2
		dc.w	$1601,$0000		; HPZ
		dc.w	$0A00,$0000		; SSZ
		dc.w	$0B00,$0000		; DEZ 1
		dc.w	$0B01,$0000		; DEZ 2
	;	dc.w	$0E00,$0000		; OAZ 1
	;	dc.w	$0E01,$0000		; OAZ 2
MMCL_Zones_End:

; ===========================================================================
; ---------------------------------------------------------------------------
; Mini-Game stages
; ---------------------------------------------------------------------------

MiniPointers:	dc.l	MiniStages			; 00	; Start pointer
		dc.l	MiniStages_Size			; 04	; End pointer
		dc.l	MiniStages_OPT			; 08	; Options pointer
		dc.l	MiniStages_NUL			; 0C	; Null slot pointer (for going into level)
		dc.l	MiniStages_Lev			; 10	; Start of levels pointer
		dc.l	MiniStages_RAN			; 14	; Random level pointer
		dc.l	RandomMiniList			; 18	; Random level list
		dc.l	MMCL_Minis			; 1C	; Random list
		dc.l	(MMCL_Minis_End-MMCL_Minis)/4	; 20	; Random list end
		dc.l	EMM_MiniHighlt			; 24	; Last level highlighted
		dc.l	$00000000			; 28	; CNZ 1 pointer (blank for mini-game)
		dc.l	$00000000			; 2C	; CNZ 2 pointer (blank for mini-game)

	; --- The list itself ---

MiniStages:	dc.l	Data_NODAT
		dc.l	Data_NODAT
		dc.l	Data_NODAT
MiniStages_OPT:	dc.l	Data_OPTIONS
MiniStages_NUL:	dc.l	Data_NODAT
MiniStages_Lev:	dc.l	Data_AIZ02
		dc.l	Data_CNZ01
		dc.l	Data_LBZ01
		dc.l	Data_SSZ01
		dc.l	Data_DEZ02
MiniStages_RAN:	dc.l	Data_RANDOM
MiniStages_Size:

; ---------------------------------------------------------------------------
; Level zone/act list
; ---------------------------------------------------------------------------

MMCL_Minis:	dc.w	$0001,$0000		; AIZ 2
		dc.w	$0300,$0000		; CNZ 1
		dc.w	$0600,$0000		; LBZ 1
		dc.w	$0A00,$0000		; SSZ 1
		dc.w	$0B01,$0000		; DEZ 2
MMCL_Minis_End:

; ===========================================================================
; ---------------------------------------------------------------------------
; The actual level card information itself
; ---------------------------------------------------------------------------
Pal_SOZ02 =	Pal_S0Z2+$18			; Its the same! =)

; MARKEYJESTER
Data_NODAT:	DSDAT	Pal_NODAT, Art_NODAT, Art_NODAT_End, Map_NODAT_A, Map_NODAT_A, Scroll_NODAT, $00000000000, $00000000000, $00000000000, $00000000, $00000000, $00000000, $00000000
Data_RANDOM:	DSDAT	Pal_RANDO, Art_RANDO, Art_RANDO_End, Map_RANDO_A, Map_RANDO_B, $00000000000, ScrExx_RANDO, PalCyc_RANDO, $00000000000, $00000000, $00000000, $00000000, $00000000
Data_OPTIONS:	DSDAT	Pal_OPTIO, Art_OPTIO, Art_OPTIO_End, Map_OPTIO_A, Map_OPTIO_B, Scroll_OPTIO, $00000000000, $00000000000, ArtCyc_OPTIO, $00000000, $FFFF8000, $00000000, $00000000
Data_AIZ01:	DSDAT	Pal_AIZ01, Art_AIZ01, Art_AIZ01_End, Map_AIZ01_A, Map_AIZ01_B, Scroll_AIZ01, $00000000000, $00000000000, $00000000000, $00000000, $00000000, $00000000, $00000000
Data_AIZ02:	DSDAT	Pal_AIZ02, Art_AIZ02, Art_AIZ02_End, Map_AIZ02_A, Map_AIZ02_B, $00000000000, ScrExx_AIZ02, PalCyc_AIZ02, ArtCyc_AIZ02, $00000000, $00000000, $00000000, $00000000
Data_HCZ01:	DSDAT	Pal_HCZ01, Art_HCZ01, Art_HCZ01_End, Map_HCZ01_A, Map_HCZ01_B, Scroll_HCZ01, $00000000000, PalCyc_HCZ01, ArtCyc_HCZ01, $00000000, $00000000, $00000000, $00000000
Data_HCZ02:	DSDAT	Pal_HCZ02, Art_HCZ02, Art_HCZ02_End, Map_HCZ02_A, Map_HCZ02_B, Scroll_HCZ02, $00000000000, $00000000000, ArtCyc_HCZ02, $00010000, $00008000, $00000000, $00000000
Data_MGZ01:	DSDAT	Pal_MGZ01, Art_MGZ01, Art_MGZ01_End, Map_MGZ01_A, Map_MGZ01_B, Scroll_MGZ01, $00000000000, $00000000000, $00000000000, $00000000, $00000000, $00000000, $00000000
Data_MGZ02:	DSDAT	Pal_MGZ02, Art_MGZ02, Art_MGZ02_End, Map_MGZ02_A, Map_MGZ02_B, $00000000000, ScrExx_MGZ02, $00000000000, $00000000000, $00000000, $00000000, $00000000, $00000000
Data_CNZ01:	DSDAT	Pal_CNZ01, Art_CNZ01, Art_CNZ01_End, Map_CNZ01_A, Map_CNZ01_B, Scroll_CNZ01, $00000000000, PalCyc_CNZ01, ArtCyc_CNZ01, $00000000, $00000000, $00100000, $00100000
Data_CNZ02:	DSDAT	Pal_CNZ02, Art_CNZ01, Art_CNZ01_End, Map_CNZ01_A, Map_CNZ01_B, Scroll_CNZ01, $00000000000, PalCyc_CNZ01, ArtCyc_CNZ01, $00000000, $00000000, $00100000, $00100000
Data_ICZ01:	DSDAT	Pal_ICZ01, Art_ICZ01, Art_ICZ01_End, Map_ICZ01_A, Map_ICZ01_B, Scroll_ICZ01, $00000000000, PalCyc_ICZ01, ArtCyc_ICZ01, $00020000, $00010000, $00000000, $00000000
Data_ICZ02:	DSDAT	Pal_ICZ02, Art_ICZ02, Art_ICZ02_End, Map_ICZ02_A, Map_ICZ02_B, $00000000000, ScrExx_ICZ02, $00000000000, $00000000000, $FFFF8000, $00000000, $00000000, $00000000
Data_LBZ01:	DSDAT	Pal_LBZ01, Art_LBZ01, Art_LBZ01_End, Map_LBZ01_A, Map_LBZ01_B, $00000000000, ScrExx_LBZ01, $00000000000, ArtCyc_LBZ01, $00000000, $00000000, $00000000, $00000000
Data_LBZ02:	DSDAT	Pal_LBZ02, Art_LBZ02, Art_LBZ02_End, Map_LBZ02_A, Map_LBZ02_B, $00000000000, ScrExx_LBZ02, $00000000000, ArtCyc_LBZ02, $00000000, $00000000, $00000000, $00000000

; NATSUMI
Data_MHZ01:	DSDAT	Pal_MHZ01, Art_MHZ01, Art_MHZ01_End, Map_MHZ01_A, Map_MHZ01_B, $00000000000, ScrExx_MHZ01, $00000000000, $00000000000, $00000000, $00000000, $00200000, $00200000
Data_MHZ02:	DSDAT	Pal_MHZ02, Art_MHZ02, Art_MHZ02_End, Map_MHZ02_A, Map_MHZ02_B, Scroll_MHZ02, $00000000000, PalCyc_MHZ02, ArtCyc_MHZ02, $00000000, $00000000, $00000000, $00400000
Data_FBZ01:	DSDAT	Pal_FBZ01, Art_FBZ01, Art_FBZ01_End, Map_FBZ01_A, Map_FBZ01_B, $00000000000, ScrExx_FBZ01, $00000000000, ArtCyc_FBZ01, $00000000, $00000000, $00200000, $00200000
Data_FBZ02:	DSDAT	Pal_FBZ02, Art_FBZ02, Art_FBZ02_End, Map_FBZ02_A, Map_FBZ02_B, Scroll_NODAT, $00000000000, $00000000000, ArtCyc_FBZ02, $FFFE4000, $FFFF2000, $00000000, $00000000
Data_SOZ01:	DSDAT	Pal_SOZ01, Art_SOZ01, Art_SOZ01_End, Map_SOZ01_A, Map_SOZ01_B, $00000000000, ScrExx_SOZ01, PalCyc_SOZ01, ArtCyc_SOZ01, $00000000, $00000000, $00000000, $00200000
Data_SOZ02:	DSDAT	Pal_SOZ02, Art_SOZ02, Art_SOZ02_End, Map_SOZ02_A, Map_SOZ02_B, Scroll_SOZ02, $00000000000, PalCyc_SOZ01, $00000000000, $FFFF8000, $00000000, $00C00000, $00200000
Data_LRZ01:	DSDAT	Pal_LRZ01, Art_LRZ01, Art_LRZ01_End, Map_LRZ01_A, Map_LRZ01_B, $00000000000, ScrExx_LRZ01, PalCyc_LRZ01, $00000000000, $00000000, $00000000, $00200000, $00000000
Data_LRZ02:	DSDAT	Pal_LRZ02, Art_LRZ02, Art_LRZ02_End, Map_LRZ02_A, Map_LRZ02_B, Scroll_LRZ02, $00000000000, PalCyc_LRZ02, $00000000000, $00000000, $00000000, $00200000, $00000000
Data_HPZ01:	DSDAT	Pal_HPZ01, Art_HPZ01, Art_HPZ01_End, Map_HPZ01_A, Map_HPZ01_B, Scroll_HPZ01, $00000000000, PalCyc_HPZ01, $00000000000, $00000000, $00000000, $00000000, $00200000
Data_SSZ01:	DSDAT	Pal_SSZ01, Art_SSZ01, Art_SSZ01_End, Map_SSZ01_A, Map_SSZ01_B, $00000000000, ScrExx_SSZ01, $00000000000, ArtCyc_SSZ01, $00005000, $00000000, $00180000, $00000000
Data_DEZ01:	DSDAT	Pal_DEZ01, Art_DEZ01, Art_DEZ01_End, Map_DEZ01_A, Map_DEZ01_B, Scroll_DEZ01, $00000000000, PalCyc_DEZ01, ArtCyc_DEZ01, $00000000, $00000000, $00000000, $00000000
Data_DEZ02:	DSDAT	Pal_DEZ02, Art_DEZ02, Art_DEZ02_End, Map_DEZ02_A, Map_DEZ02_B, Scroll_DEZ02, $00000000000, PalCyc_DEZ02, ArtCyc_DEZ02, $00000000, $00000000, $000C0000, $000C0000

; ---------------------------------------------------------------------------
; Includes...
; ---------------------------------------------------------------------------

	; --- Palettes ---

Pal_NODAT:	dc.w	$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
Pal_RANDO:	binclude "Main Menu\Backgrounds\_Random\Palette.bin"
Pal_OPTIO:	binclude "Main Menu\Backgrounds\_Options\Palette.bin"
Pal_AIZ01:	binclude "Main Menu\Backgrounds\AIZ1\Palette.bin"
Pal_AIZ02:	binclude "Main Menu\Backgrounds\AIZ2\Palette.bin"
Pal_HCZ01:	binclude "Main Menu\Backgrounds\HCZ1\Palette.bin"
Pal_HCZ02:	binclude "Main Menu\Backgrounds\HCZ2\Palette.bin"
Pal_MGZ01:	binclude "Main Menu\Backgrounds\MGZ1\Palette.bin"
Pal_MGZ02:	binclude "Main Menu\Backgrounds\MGZ2\Palette.bin"
Pal_CNZ01:	binclude "Main Menu\Backgrounds\CNZ1\Palette.bin"
Pal_CNZ02:	binclude "Main Menu\Backgrounds\CNZ1\Palette Act 2.bin"
Pal_ICZ01:	binclude "Main Menu\Backgrounds\ICZ1\Palette.bin"
Pal_ICZ02:	binclude "Main Menu\Backgrounds\ICZ2\Palette.bin"
Pal_LBZ01:	binclude "Main Menu\Backgrounds\LBZ1\Palette.bin"
Pal_LBZ02:	binclude "Main Menu\Backgrounds\LBZ2\Palette.bin"
Pal_MHZ01:	binclude "Main Menu\Backgrounds\MHZ1\Palette.bin"
Pal_MHZ02:	binclude "Main Menu\Backgrounds\MHZ2\Palette.bin"
Pal_FBZ01:	binclude "Main Menu\Backgrounds\FBZ1\Palette.bin"
Pal_FBZ02:	binclude "Main Menu\Backgrounds\FBZ2\Palette.bin"
Pal_SOZ01:	binclude "Main Menu\Backgrounds\SOZ1\Palette.bin"
Pal_LRZ02:	binclude "Main Menu\Backgrounds\LRZ2\Palette.bin"
Pal_LRZ01:	binclude "Main Menu\Backgrounds\LRZ1\Palette.bin"
Pal_HPZ01:	binclude "Main Menu\Backgrounds\HPZ\Palette.bin"
Pal_SSZ01:	binclude "Main Menu\Backgrounds\SSZ\Palette.bin"
Pal_DEZ01:	binclude "Main Menu\Backgrounds\DEZ1\Palette.bin"
Pal_DEZ02:	binclude "Main Menu\Backgrounds\DEZ2\Palette.bin"

	; --- Plane mappings ---

Map_NODAT_A:	binclude "Main Menu\Map_PlaneBlank.mun"
Map_OPTIO_A:	binclude "Main Menu\Backgrounds\_Options\Map_PlaneA.mun"
Map_OPTIO_B:	binclude "Main Menu\Backgrounds\_Options\Map_PlaneB.mun"
Map_RANDO_A:	binclude "Main Menu\Backgrounds\_Random\Map_PlaneA.mun"		; 600
Map_RANDO_B:	binclude "Main Menu\Backgrounds\_Random\Map_PlaneB.mun"		; 600
Map_AIZ01_A:	binclude "Main Menu\Backgrounds\AIZ1\Map_PlaneA.mun"		; 230
Map_AIZ01_B:	binclude "Main Menu\Backgrounds\AIZ1\Map_PlaneB.mun"		; 260
Map_AIZ02_A:	binclude "Main Menu\Backgrounds\AIZ2\Map_PlaneA.mun"		; 3C0
Map_AIZ02_B:	binclude "Main Menu\Backgrounds\AIZ2\Map_PlaneB.mun"		; 380
Map_HCZ01_A:	binclude "Main Menu\Backgrounds\HCZ1\Map_PlaneA.mun"		; 3C0
Map_HCZ01_B:	binclude "Main Menu\Backgrounds\HCZ1\Map_PlaneB.mun"		; 380
Map_HCZ02_A:	binclude "Main Menu\Backgrounds\HCZ2\Map_PlaneA.mun"		; 600
Map_HCZ02_B:	binclude "Main Menu\Backgrounds\HCZ2\Map_PlaneB.mun"		; 800
Map_MGZ01_A:	binclude "Main Menu\Backgrounds\MGZ1\Map_PlaneA.mun"		; 280
Map_MGZ01_B:	binclude "Main Menu\Backgrounds\MGZ1\Map_PlaneB.mun"		; 200
Map_MGZ02_A:	binclude "Main Menu\Backgrounds\MGZ2\Map_PlaneA.mun"		; 340
Map_MGZ02_B:	binclude "Main Menu\Backgrounds\MGZ2\Map_PlaneB.mun"		; 320
Map_CNZ01_A:	binclude "Main Menu\Backgrounds\CNZ1\Map_PlaneA.mun"		; 440
Map_CNZ01_B:	binclude "Main Menu\Backgrounds\CNZ1\Map_PlaneB.mun"		; 3A0
Map_ICZ01_A:	binclude "Main Menu\Backgrounds\ICZ1\Map_PlaneA.mun"		; 340
Map_ICZ01_B:	binclude "Main Menu\Backgrounds\ICZ1\Map_PlaneB.mun"		; 2A0
Map_ICZ02_A:	binclude "Main Menu\Backgrounds\ICZ2\Map_PlaneA.mun"		; 800
Map_ICZ02_B:	binclude "Main Menu\Backgrounds\ICZ2\Map_PlaneB.mun"		; 360
Map_LBZ01_A:	binclude "Main Menu\Backgrounds\LBZ1\Map_PlaneA.mun"		; 240
Map_LBZ01_B:	binclude "Main Menu\Backgrounds\LBZ1\Map_PlaneB.mun"		; 260
Map_LBZ02_A:	binclude "Main Menu\Backgrounds\LBZ2\Map_PlaneA.mun"		; 380
Map_LBZ02_B:	binclude "Main Menu\Backgrounds\LBZ2\Map_PlaneB.mun"		; 360
Map_MHZ01_A:	binclude "Main Menu\Backgrounds\MHZ1\Map_PlaneA.mun"		; 1A0
Map_MHZ01_B:	binclude "Main Menu\Backgrounds\MHZ1\Map_PlaneB.mun"		; 180
Map_MHZ02_A:	binclude "Main Menu\Backgrounds\MHZ2\Map_PlaneA.mun"		; 3C0
Map_MHZ02_B:	binclude "Main Menu\Backgrounds\MHZ2\Map_PlaneB.mun"		; 280
Map_FBZ01_A:	binclude "Main Menu\Backgrounds\FBZ1\Map_PlaneA.mun"		; 540
Map_FBZ01_B:	binclude "Main Menu\Backgrounds\FBZ1\Map_PlaneB.mun"		; 800
Map_FBZ02_A:	binclude "Main Menu\Backgrounds\FBZ2\Map_PlaneA.mun"		; 1C0
Map_FBZ02_B:	binclude "Main Menu\Backgrounds\FBZ2\Map_PlaneB.mun"		; 2A0
Map_SOZ01_A:	binclude "Main Menu\Backgrounds\SOZ1\Map_PlaneA.mun"		; 2C0
Map_SOZ01_B:	binclude "Main Menu\Backgrounds\SOZ1\Map_PlaneB.mun"		; 800
Map_SOZ02_A:	binclude "Main Menu\Backgrounds\SOZ2\Map_PlaneA.mun"		; 1A0	; <- NOTE: Possible lag frame
Map_SOZ02_B:	binclude "Main Menu\Backgrounds\SOZ2\Map_PlaneB.mun"		; 2D0
Map_LRZ01_A:	binclude "Main Menu\Backgrounds\LRZ1\Map_PlaneA.mun"		; 260
Map_LRZ01_B:	binclude "Main Menu\Backgrounds\LRZ1\Map_PlaneB.mun"		; C00
Map_LRZ02_A:	binclude "Main Menu\Backgrounds\LRZ2\Map_PlaneA.mun"		; 2E0
Map_LRZ02_B:	binclude "Main Menu\Backgrounds\LRZ2\Map_PlaneB.mun"		; 4A0
Map_HPZ01_A:	binclude "Main Menu\Backgrounds\HPZ\Map_PlaneA.mun"		; 310
Map_HPZ01_B:	binclude "Main Menu\Backgrounds\HPZ\Map_PlaneB.mun"		; 3E0
Map_SSZ01_A:	binclude "Main Menu\Backgrounds\SSZ\Map_PlaneA.mun"		; 280
Map_SSZ01_B:	binclude "Main Menu\Backgrounds\SSZ\Map_PlaneB.mun"		; 360
Map_DEZ01_A:	binclude "Main Menu\Backgrounds\DEZ1\Map_PlaneA.mun"		; 280
Map_DEZ01_B:	binclude "Main Menu\Backgrounds\DEZ1\Map_PlaneB.mun"		; 320
Map_DEZ02_A:	binclude "Main Menu\Backgrounds\DEZ2\Map_PlaneA.mun"		; 280
Map_DEZ02_B:	binclude "Main Menu\Backgrounds\DEZ2\Map_PlaneB.mun"		; 480
		even

	; --- Art (keeping it together since it needs alignment) ---

	;	align	$20000
Art_NODAT:	dc.b	[$20] $00
Art_NODAT_End:	even
Art_RANDO:	binclude "Main Menu\Backgrounds\_Random\Art.bin"
Art_RANDO_End:	even
Art_OPTIO:	binclude "Main Menu\Backgrounds\_Options\Art.bin"
Art_OPTIO_End:	even
Art_AIZ01:	binclude "Main Menu\Backgrounds\AIZ1\Art.bin"
Art_AIZ01_End:	even
Art_AIZ02:	binclude "Main Menu\Backgrounds\AIZ2\Art.bin"
Art_AIZ02_End:	even
Art_HCZ01:	binclude "Main Menu\Backgrounds\HCZ1\Art.bin"
Art_HCZ01_End	even
Art_HCZ02:	binclude "Main Menu\Backgrounds\HCZ2\Art.bin"
Art_HCZ02_End	even
Art_MGZ01:	binclude "Main Menu\Backgrounds\MGZ1\Art.bin"
Art_MGZ01_End	even
Art_MGZ02:	binclude "Main Menu\Backgrounds\MGZ2\Art.bin"
Art_MGZ02_End	even
Art_CNZ01:	binclude "Main Menu\Backgrounds\CNZ1\Art.bin"
Art_CNZ01_End	even
	align $20000 ;TEMP
Art_ICZ01:	binclude "Main Menu\Backgrounds\ICZ1\Art.bin"
Art_ICZ01_End	even
Art_ICZ02:	binclude "Main Menu\Backgrounds\ICZ2\Art.bin"
Art_ICZ02_End	even
Art_LBZ01:	binclude "Main Menu\Backgrounds\LBZ1\Art.bin"
Art_LBZ01_End	even
Art_LBZ02:	binclude "Main Menu\Backgrounds\LBZ2\Art.bin"
Art_LBZ02_End	even
Art_MHZ01:	binclude "Main Menu\Backgrounds\MHZ1\Art.bin"
Art_MHZ01_End	even
Art_MHZ02:	binclude "Main Menu\Backgrounds\MHZ2\Art.bin"
Art_MHZ02_End	even
Art_FBZ01:	binclude "Main Menu\Backgrounds\FBZ1\Art.bin"
Art_FBZ01_End	even
Art_FBZ02:	binclude "Main Menu\Backgrounds\FBZ2\Art.bin"
Art_FBZ02_End	even
Art_SOZ01:	binclude "Main Menu\Backgrounds\SOZ1\Art.bin"
Art_SOZ01_End	even
Art_SOZ02:	binclude "Main Menu\Backgrounds\SOZ2\Art.bin"
Art_SOZ02_End	even
Art_LRZ01:	binclude "Main Menu\Backgrounds\LRZ1\Art.bin"
Art_LRZ01_End	even
Art_LRZ02:	binclude "Main Menu\Backgrounds\LRZ2\Art.bin"
Art_LRZ02_End	even
Art_HPZ01:	binclude "Main Menu\Backgrounds\HPZ\Art.bin"
Art_HPZ01_End	even
Art_SSZ01:	binclude "Main Menu\Backgrounds\SSZ\Art.bin"
Art_SSZ01_End	even
Art_DEZ01:	binclude "Main Menu\Backgrounds\DEZ1\Art.bin"
Art_DEZ01_End	even
Art_DEZ02:	binclude "Main Menu\Backgrounds\DEZ2\Art.bin"
Art_DEZ02_End	even

	; --- Scroll data ---

		; Scanlines, FG Speed, BG Speed

Scroll_NODAT:	SCRL	$100, F,$0000, F,$0000
ScrExx_RANDO:	include	"Main Menu\Backgrounds\_Random\Scroll.asm"
Scroll_OPTIO:	include	"Main Menu\Backgrounds\_Options\Scroll.asm"
Scroll_AIZ01:	include	"Main Menu\Backgrounds\AIZ1\Scroll.asm"
ScrExx_AIZ02:	include	"Main Menu\Backgrounds\AIZ2\Scroll.asm"
Scroll_HCZ01:	include	"Main Menu\Backgrounds\HCZ1\Scroll.asm"
Scroll_HCZ02:	include	"Main Menu\Backgrounds\HCZ2\Scroll.asm"
Scroll_MGZ01:	include	"Main Menu\Backgrounds\MGZ1\Scroll.asm"
ScrExx_MGZ02:	include	"Main Menu\Backgrounds\MGZ2\Scroll.asm"
Scroll_CNZ01:	include	"Main Menu\Backgrounds\CNZ1\Scroll.asm"
Scroll_ICZ01:	include	"Main Menu\Backgrounds\ICZ1\Scroll.asm"
ScrExx_ICZ02:	include	"Main Menu\Backgrounds\ICZ2\Scroll.asm"
ScrExx_LBZ01:	include	"Main Menu\Backgrounds\LBZ1\Scroll.asm"
ScrExx_LBZ02:	include	"Main Menu\Backgrounds\LBZ2\Scroll.asm"
ScrExx_MHZ01:	include	"Main Menu\Backgrounds\MHZ1\Scroll.asm"
Scroll_MHZ02:	include	"Main Menu\Backgrounds\MHZ2\Scroll.asm"
ScrExx_SOZ01:	include	"Main Menu\Backgrounds\SOZ1\Scroll.asm"
ScrExx_FBZ01:	include	"Main Menu\Backgrounds\FBZ1\Scroll.asm"
Scroll_SOZ02:	include	"Main Menu\Backgrounds\SOZ2\Scroll.asm"
ScrExx_LRZ01:	include	"Main Menu\Backgrounds\LRZ1\Scroll.asm"
Scroll_LRZ02:	include	"Main Menu\Backgrounds\LRZ2\Scroll.asm"
Scroll_HPZ01:	include	"Main Menu\Backgrounds\HPZ\Scroll.asm"
ScrExx_SSZ01:	include	"Main Menu\Backgrounds\SSZ\Scroll.asm"
Scroll_DEZ01:	include	"Main Menu\Backgrounds\DEZ1\Scroll.asm"
Scroll_DEZ02:	include	"Main Menu\Backgrounds\DEZ2\Scroll.asm"

	; --- Animated Art ---

ArtCyc_OPTIO:	include	"Main Menu\Backgrounds\_Options\AniArt.asm"
ArtCyc_AIZ02:	include	"Main Menu\Backgrounds\AIZ2\AniArt.asm"
ArtCyc_HCZ01:	include	"Main Menu\Backgrounds\HCZ1\AniArt.asm"
ArtCyc_HCZ02:	include	"Main Menu\Backgrounds\HCZ2\AniArt.asm"
ArtCyc_CNZ01:	include	"Main Menu\Backgrounds\CNZ1\AniArt.asm"
ArtCyc_ICZ01:	include	"Main Menu\Backgrounds\ICZ1\AniArt.asm"
ArtCyc_LBZ01:	include	"Main Menu\Backgrounds\LBZ1\AniArt.asm"
ArtCyc_LBZ02:	include	"Main Menu\Backgrounds\LBZ2\AniArt.asm"
ArtCyc_MHZ02:	include	"Main Menu\Backgrounds\MHZ2\AniArt.asm"
ArtCyc_FBZ01:	include	"Main Menu\Backgrounds\FBZ1\AniArt.asm"
ArtCyc_FBZ02:	include	"Main Menu\Backgrounds\FBZ2\AniArt.asm"
ArtCyc_SOZ01:	include	"Main Menu\Backgrounds\SOZ1\AniArt.asm"
ArtCyc_DEZ01:	include	"Main Menu\Backgrounds\DEZ1\AniArt.asm"
ArtCyc_DEZ02:	include	"Main Menu\Backgrounds\DEZ2\AniArt.asm"
ArtCyc_SSZ01:	include	"Main Menu\Backgrounds\SSZ\AniArt.asm"

	; --- Palette Cycling ---

PalCyc_RANDO:	include	"Main Menu\Backgrounds\_Random\PalCycle.asm"
PalCyc_AIZ02:	include	"Main Menu\Backgrounds\AIZ2\PalCycle.asm"
PalCyc_HCZ01:	include	"Main Menu\Backgrounds\HCZ1\PalCycle.asm"
PalCyc_CNZ01:	include	"Main Menu\Backgrounds\CNZ1\PalCycle.asm"
PalCyc_ICZ01:	include	"Main Menu\Backgrounds\ICZ1\PalCycle.asm"
PalCyc_MHZ02:	include	"Main Menu\Backgrounds\MHZ2\PalCycle.asm"
PalCyc_SOZ01:	include	"Main Menu\Backgrounds\SOZ1\PalCycle.asm"
PalCyc_LRZ02:	include	"Main Menu\Backgrounds\LRZ2\PalCycle.asm"
PalCyc_HPZ01:	include	"Main Menu\Backgrounds\HPZ\PalCycle.asm"
PalCyc_DEZ01:	include	"Main Menu\Backgrounds\DEZ1\PalCycle.asm"
PalCyc_DEZ02:	include	"Main Menu\Backgrounds\DEZ2\PalCycle.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Large write chain for multiple extra scroll routines to use if need be (saves memory this way)
; ---------------------------------------------------------------------------

	rept	$100
		move.l	d0,(a1)+				; write to scroll buffer
	endm
WriteScroll:
		rts						; return

CardMini:	dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	Card_AIZ02
		dc.l	Card_CNZ01
		dc.l	Card_LBZ01
		dc.l	Card_SSZ
		dc.l	Card_DEZ02
		dc.l	Card_RAND

; ===========================================================================
; ---------------------------------------------------------------------------
; Title card names
; ---------------------------------------------------------------------------

CardNames:	dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	$00000000
		dc.l	Card_AIZ01
		dc.l	Card_AIZ02
		dc.l	Card_HCZ01
		dc.l	Card_HCZ02
		dc.l	Card_MGZ01
		dc.l	Card_MGZ02
		dc.l	Card_CNZ01
		dc.l	Card_CNZ02
		dc.l	Card_ICZ01
		dc.l	Card_ICZ02
		dc.l	Card_LBZ01
		dc.l	Card_LBZ02
		dc.l	Card_MHZ01
		dc.l	Card_MHZ02
		dc.l	Card_FBZ01
		dc.l	Card_FBZ02
		dc.l	Card_SPZ01
		dc.l	Card_SPZ02
		dc.l	Card_LRZ01
		dc.l	Card_LRZ02
		dc.l	Card_HPZ
		dc.l	Card_SSZ
		dc.l	Card_DEZ01
		dc.l	Card_DEZ02
	;	dc.l	Card_OAZ01
	;	dc.l	Card_OAZ02
		dc.l	Card_RAND

		;	act, name

Card_Zone:	TEXT	$00,"ZONE"
Card_Mini:	TEXT	$00,"MINI GAME"

Card_AIZ01:	TEXT	$01,"ANGEL ISLAND"
Card_AIZ02:	TEXT	$02,"ANGEL ISLAND"
Card_HCZ01:	TEXT	$01,"HYDROCITY"
Card_HCZ02:	TEXT	$02,"HYDROCITY"
Card_MGZ01:	TEXT	$01,"MARBLE GARDEN"
Card_MGZ02:	TEXT	$02,"MARBLE GARDEN"
Card_CNZ01:	TEXT	$01,"CARNIVAL NIGHT"
Card_CNZ02:	TEXT	$02,"CARNIVAL NIGHT"
Card_ICZ01:	TEXT	$01,"ICE CAP"
Card_ICZ02:	TEXT	$02,"ICE CAP"
Card_LBZ01:	TEXT	$01,"LAUNCH BASE"
Card_LBZ02:	TEXT	$02,"LAUNCH BASE"
Card_MHZ01:	TEXT	$01,"MUSHROOM HILL"
Card_MHZ02:	TEXT	$02,"MUSHROOM HILL"
Card_FBZ01:	TEXT	$01,"FLYING BATTERY"
Card_FBZ02:	TEXT	$02,"FLYING BATTERY"
Card_SPZ01:	TEXT	$01,"SANDOPOLIS"
Card_SPZ02:	TEXT	$02,"SANDOPOLIS"
Card_LRZ01:	TEXT	$01,"LAVA REEF"
Card_LRZ02:	TEXT	$02,"LAVA REEF"
Card_HPZ:	TEXT	$00,"HIDDEN PALACE"
Card_SSZ:	TEXT	$00,"SKY SANCTUARY"
Card_DEZ01:	TEXT	$01,"DEATH EGG"
Card_DEZ02:	TEXT	$02,"DEATH EGG"
Card_OAZ01:	TEXT	$01,"OMINOUS ALCAZAR"
Card_OAZ02:	TEXT	$02,"OMINOUS ALCAZAR"
Card_RAND:	TEXT	$00,"RANDOM"
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Other data
; ---------------------------------------------------------------------------

Pal_MainMenu:	binclude "Main Menu\Main Menu\Pal_MainMenu.bin"
		even
Art_Font:	binclude "Main Menu\Main Menu\Art_Font.kosm"
		even
Map_Font:	binclude "Main Menu\Main Menu\Map_Font.bin"
		even
Art_MenuText:	binclude "Main Menu\Main Menu\Art_MenuText.kosm"
		even
Art_Frames:	binclude "Main Menu\Main Menu\Art_Frames.kosm"
		even
Map_Frames:	binclude "Main Menu\Main Menu\Map_Frames.mun"
		even

Art_Window:	binclude "Main Menu\Art_Window.kosm"
		even
Map_Window:	binclude "Main Menu\Map_Window.mun"
		even
Pal_TitleCard:	binclude "Main Menu\Pal_TitleCard.bin"
		even
Art_TitleCard:	binclude "Main Menu\Art_TitleCard.kosm"
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Main Menu transition cards
; ---------------------------------------------------------------------------

Pal_Card01:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Card 01.pal"
Art_Card01:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Card 01.bin"
Pal_Card02:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Card 02.pal"
Art_Card02:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Card 02.bin"
Pal_Card03:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Card 03.pal"
Art_Card03:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Card 03.bin"
Pal_Card04:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Card 04.pal"
Art_Card04:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Card 04.bin"
Pal_Card05:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Card 05.pal"
Art_Card05:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Card 05.bin"
Pal_Card06:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Card 06.pal"
Art_Card06:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Card 06.bin"
Pal_Card07:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Card 07.pal"
Art_Card07:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Card 07.bin"

Trans_Palette:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Transition.pal"
Trans_01_FULL0:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 01 (FULL) - 0.bin"
Trans_01_FULL1:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 01 (FULL) - 1.bin"
Trans_01_FULL2:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 01 (FULL) - 2.bin"
;Trans_02_FULL0:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 02 (FULL) - 0.bin"
;Trans_02_FULL1:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 02 (FULL) - 1.bin"
;Trans_02_FULL2:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 02 (FULL) - 2.bin"
;Trans_03_FULL0:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 03 (FULL) - 0.bin"
;Trans_03_FULL1:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 03 (FULL) - 1.bin"
;Trans_03_FULL2:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 03 (FULL) - 2.bin"
;Trans_04_FULL0:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 04 (FULL) - 0.bin"
;Trans_04_FULL1:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 04 (FULL) - 1.bin"
;Trans_04_FULL2:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 04 (FULL) - 2.bin"
;Trans_05_FULL0:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 05 (FULL) - 0.bin"
;Trans_05_FULL1:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 05 (FULL) - 1.bin"
;Trans_05_FULL2:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 05 (FULL) - 2.bin"
;Trans_06_FULL0:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 06 (FULL) - 0.bin"
;Trans_06_FULL1:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 06 (FULL) - 1.bin"
;Trans_06_FULL2:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 06 (FULL) - 2.bin"
;Trans_07_FULL0:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 07 (FULL) - 0.bin"
;Trans_07_FULL1:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 07 (FULL) - 1.bin"
;Trans_07_FULL2:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 07 (FULL) - 2.bin"
;Trans_08_FULL0:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 08 (FULL) - 0.bin"
;Trans_08_FULL1:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 08 (FULL) - 1.bin"
;Trans_08_FULL2:	binclude "Main Menu\Main Menu\Menu Cards\Card Data\Trans 08 (FULL) - 2.bin"

AniArt_ZigZag:	binclude	"Main Menu\Main Menu\Ani Art Zig Zag.unc"
AniArt_SideZag:	binclude	"Main Menu\Main Menu\Ani Art Side Zag.unc"

; ===========================================================================
; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------

	if (*)&$1FFFF > $20000-$60	; thanks ASS, yes *&$1FFFF is totally not valid expression. Good job.
		align $60		; NAT: This was not here! Caused some graphical glitches
	endif
Art_Anim3:	binclude "Main Menu\Art_Animated3.bin"
		even
Art_ScoreNum:	binclude "Main Menu/Art_ScoreNumbers.bin"
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Mundi compression
; ---------------------------------------------------------------------------

		include	"Main Menu/Mundi.asm"

; ===========================================================================

