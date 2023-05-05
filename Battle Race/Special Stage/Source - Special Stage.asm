; ===========================================================================
; ---------------------------------------------------------------------------
; Sonic 3 Special Stage - 2 Player Version
; ---------------------------------------------------------------------------
; Game modes:  (ESS_StageMode / SpecialStage_Mode)
;
; 	FF = Get Blue Spheres (Separate Stages)
; 	00 = Get Most Spheres (Same Stage)
; 	01 = Get Opponent Spheres (Same Stage)
; ---------------------------------------------------------------------------
SS_GAMESTART	=	$E0			; Game start timer (number of frames to wait til start, byte only)
; ---------------------------------------------------------------------------
ESS_StageMode	=	SpecialStage_Mode	; byte		; Game Mode
ESS_StageP1	=	SpecialStage_Player1	; byte		; Player 1's special stage ID
ESS_StageP2	=	SpecialStage_Player2	; byte		; Player 2's special stage ID
; ---------------------------------------------------------------------------
ESS_P1_ScaleArt	=	$FFFF0000		;  280		; player 1's scaling art
ESS_P2_ScaleArt	=	$FFFF1000		;  280		; player 2's scaling art
ESS_LoopRecord	=	$FFFF2000		; ????		; record of sphere loop
ESS_Layout_Ring	=	$FFFF4000		; 2000		; ring marker layout
ESS_Layout_P1	=	$FFFF6000		; 2000		; player 1's layout data
ESS_Layout_P2	=	$FFFF6020		; 2000		; player 2's layout data
ESS_Layout_CPU1	=	ESS_Layout_P1+$40	; 2000		; player 1 CPU's layout remember marker
ESS_Layout_CPU2	=	ESS_Layout_P2+$40	; 2000		; player 2 CPU's layout remember marker
ESS_H2_HScroll	=	$FFFF8000		; long		; Player 2's H-blank X positions (FFFF.BBBB)
ESS_H2_VScroll	=	$FFFF8004		; word		; Player 2's H-blank Y positions (BBBB)
ESS_H2_Buffer	=	$FFFF8006		; byte		; Player 2's buffer flag (for transfering correct sprite buffer)
ESS_PalFade	=	$FFFF8007		; byte		; palette fading counter
ESS_LagCount	=	$FFFF8008		; word		; number of frames lagged since start of game
ESS_RingFrame	=	$FFFF800A		; word		; ring timer (for animating rings)
ESS_RingDelay	=	$FFFF800C		; byte		; ring delay timer
ESS_GameStart	=	$FFFF800D		; byte		; game start timer (time before the game can start)
ESS_SphereLoc	=	$FFFF800E		; word		; layout address of blue sphere (closest)
ESS_SphereLast	=	$FFFF8010		; word		; layout address of blue sphere (furthest away)
ESS_Trap	=	$FFFF8012		; byte		; trap flag

REG00		=	$FFFF8020
REG01		=	$FFFF8021
REG02		=	$FFFF8022
REG03		=	$FFFF8023
REG04		=	$FFFF8024
REG05		=	$FFFF8025
REG06		=	$FFFF8026
REG07		=	$FFFF8027
REG08		=	$FFFF8028
REG09		=	$FFFF8029
REG0A		=	$FFFF802A
REG0B		=	$FFFF802B
REG0C		=	$FFFF802C
REG0D		=	$FFFF802D
REG0E		=	$FFFF802E
REG0F		=	$FFFF802F

ESS_Debug00	=	$FFFF80E0		; byte		; debug display numbers
ESS_Debug01	=	(ESS_Debug00+$01)	; byte		; ''
ESS_Debug02	=	(ESS_Debug00+$02)	; byte		; ''
ESS_Debug03	=	(ESS_Debug00+$03)	; byte		; ''
ESS_Debug04	=	(ESS_Debug00+$04)	; byte		; ''
ESS_Debug05	=	(ESS_Debug00+$05)	; byte		; ''
ESS_Debug06	=	(ESS_Debug00+$06)	; byte		; ''
ESS_Debug07	=	(ESS_Debug00+$07)	; byte		; ''
ESS_Debug08	=	(ESS_Debug00+$08)	; byte		; ''
ESS_Debug09	=	(ESS_Debug00+$09)	; byte		; ''
ESS_Debug0A	=	(ESS_Debug00+$0A)	; byte		; ''
ESS_Debug0B	=	(ESS_Debug00+$0B)	; byte		; ''
ESS_Debug0C	=	(ESS_Debug00+$0C)	; byte		; ''
ESS_Debug0D	=	(ESS_Debug00+$0D)	; byte		; ''
ESS_Debug0E	=	(ESS_Debug00+$0E)	; byte		; ''
ESS_Debug0F	=	(ESS_Debug00+$0F)	; byte		; ''

ESS_P1_Floor	=	$FFFF8100		; 0100		; Player 1's floor details
ESS_P2_Floor	=	$FFFF8200		; 0100		; Player 2's floor details

ESS_PlayerID		=	$00		; byte		; player ID (00 = player 1 | 01 = Player 2)
ESS_HitBumper		=	$01		; byte		; if the player has hit a bumper
ESS_LayoutYX		=	$02		; word		; YYXX
ESS_LayoutY		=	ESS_LayoutYX	; byte		; layout Y position
ESS_LayoutX		=	ESS_LayoutYX+1	; byte		; layout X position
ESS_HScroll		=	$04		; long		; H-scroll position (FG and BG)
ESS_VScroll		=	$08		; long		; BG Y position (QQQQ.FFFF)
ESS_FloorPos		=	$0C		; word		; floor position (QQ.DD)
ESS_FloorSpeed		=	$0E		; word		; floor speed (QQ.DD)
ESS_RotatePos		=	$10		; word		; rotation position
ESS_FrameEntry		=	$12		; byte		; the frame entry being displayed
ESS_Direction		=	$13		; byte		; the direction the player is facing in the stage
ESS_Point		=	$14		; byte		; the direction the player last pressed to rotate the stage (FE left, 02 right, 00 none, odd numbers trigger no direction can be pressed)
ESS_Move		=	$15		; byte		; the direciton the player is moving (01 forwards, FF backwards, 00 not moving)
ESS_SpeedLevel		=	$16		; byte		; speed level the player will move at (00 to ... whetever, a table will be referenced)
ESS_RotateHold		=	$17		; byte		; if the player has moved off of a spot (rotation position)
ESS_Layout		=	$18		; long		; pointer to layout data
ESS_PalList		=	$1C		; long		; palette list to use
ESS_RingPos		=	$20		; word		; position of last ring collected (to be erased when player moves in the layout)
ESS_RingTime		=	$22		; byte		; ring collection timer
ESS_SpriteD		=	$23		; byte		; if the opponent's sprite should display or not
ESS_Controller		=	$24		; long		; 24-bit address of controller (MSByte = CPU player (00 = No CPU | FF = Yes CPU)
ESS_ButtonCPU		=	$28		; word		; CPU controller (held then pressed, etc...)
ESS_SpriteP		=	$2A		; byte		; opponent's sprite priority bit
ESS_SpriteL		=	$2B		; byte		; priority link number (position/place behind/infront of spheres)
ESS_SpriteX		=	$2C		; word		; opponent's sprite X position relative to current player (only axis, not actual position)
ESS_SpriteY		=	$2E		; word		; opponent's sprite Y position relative to current player (only axis, not actual position)
ESS_JumpPos		=	$30		; word		; jump height/position (QQ.DD)
ESS_JumpSpeed		=	$32		; word		; jump speed (QQ.DD)
ESS_Changed		=	$34		; byte		; flag for CPU to know that it's layout position has changed
ESS_DirectDest		=	$35		; byte		; destination direction for CPU in places
ESS_Count01		=	$36		; byte		; a counter for the CPU
ESS_TurnFinish		=	$37		; byte		; if a turn has just finished
ESS_RoutCPU		=	$38		; long		; CPU routine to run
ESS_SphereNear		=	$3C		; word		; layout position for CPU of where the next visible sphere is
ESS_SphereFar		=	$3E		; word		; layout position for CPU of where the furthest visible sphere is
ESS_SphereDest		=	$40		; word		; current sphere the CPU is meant to follow
ESS_SphereFarDest	=	$42		; word		; for keeping a far away destination (since the position changes since it last obtained one)

ESS_SpritesP1	=	$FFFF8800		; 0280		; player 1's sprite list
ESS_SpritesP2A	=	$FFFF8A80		; 0280		; player 2's sprite list (buffer A)
ESS_SpritesP2B	=	$FFFF8D00		; 0280		; player 2's sprite list (buffer B)
ESS_LinkP1	=	$FFFF8F80		; byte		; last sprite link ID removed
ESS_LinkP2A	=	ESS_LinkP1+1		; byte		; last sprite link ID removed
ESS_LinkP2B	=	ESS_LinkP1+2		; byte		; last sprite link ID removed
ESS_MusicTempo	=	$FFFF8F83		; byte		; last music tempo that was set

ESS_PalBG_H2	=	$FFFF8F84		; 0006		; Player 2's H-blank BG palette
ESS_PalBG_P2	=	$FFFF8F8A		; 0006		; '' current BG palette
ESS_MainBG_P2	=	$FFFF8F90		; 0006		; '' destination BG palette

ESS_FramePal_P1	=	$FFFF9000		; 0400		; list of palette frames to use (Player 1)
ESS_FramePal_P2	=	$FFFF9400		; 0400		; list of palette frames to use (Player 2)
; ---------------------------------------------------------------------------

SpecialStage:
;	move.b	#$00,(ESS_StageP1).w
;	move.b	#$00,(ESS_StageP2).w

;	move.b	#$FF,(ESS_StageMode).w

SS_Reset:
		moveq	#$E2,d0					; set sound ID to "Fade Music"
		jsr	Play_Sound.w				; play sound ID
		jsr	Clear_KosM_Queue.w			; clear PLC list
		jsr	Pal_FadeToWhite				; fade to white

	; ---Setup/clearing ---

		move	#$2700,sr				; disable interrupts
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		move.l	#VInt,(V_int_addr).w			; force blank routines back to normal
		move.l	#NullRTE,(H_int_addr).w			; ''
		move.w	#$8000|%00010100,(a6)			; 00LH 01CD - Leftover SMS bar (0N|1Y) | H-Interrupt (0N|1Y) | H,V Counter (0N|1Y) | Disable video signal (0N|1Y)
		move.w	#$8100|%00110100,(a6)			; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)
		move.w	#$8200|((($C000)>>$0A)&$FF),(a6)	; 00FE DCBA - Scroll Plane A Map Table VRam address
		move.w	#$8300|((($C000)>>$0A)&$FF),(a6)	; 00FE DCB0 / 00FE DC00 (20 H-resol) - Window Plane A Map Table VRam address
		move.w	#$8400|((($E000)>>$0D)&$FF),(a6)	; 0000 0FED - Scroll Plane B Map Table VRam address
		move.w	#$8500|((($BC00)>>$09)&$FF),(a6)	; 0FED CBA9 / 0FED CBA0 (20 H-resol) - Sprite Plane Map Table VRam address
		move.w	#$8600|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8700|$20,(a6)				; 00PP CCCC - Backdrop Colour: Palette Line | Colour ID
		move.w	#$8800|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8900|%00000000,(a6)			; 0000 0000 - Unknown/Unused Register
		move.w	#$8A00|$DF,(a6)				; 7654 3210 - H-Interrupt Register
		move.w	#$8B00|%00000000,(a6)			; 0000 EVHH - External Interrupt (0N|1Y) | V-Scroll (0-Full|1-2Celled) | H-Scroll: (00-Full|10-Celled|11-Sliced)
		move.w	#$8C00|%10000001,(a6)			; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
		move.w	#$8D00|((($C000)>>$0A)&$FF),(a6)	; 00FE DCBA - Horizontal Scroll Table VRam address
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

	; --- Clearing ---

		moveq	#$00,d0					; clear d0
		lea	($00FF0000).l,a1			; load start of ram
		move.w	#($E380/$04)-1,d7			; set number of bytes to clear

SP_ClearRAM:
		move.l	d0,(a1)+				; clear RAM
		dbf	d7,SP_ClearRAM				; repeat til cleared

	; --- Loading data ---

		moveq	#$00,d2					; write to VRAM address
		lea	(SP_ArtFloor).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping

		move.w	#$56E0,d2				; write to VRAM address
		lea	(SP_ArtBG).l,a1				; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping

		move.w	#$5840,d2				; write to VRAM address
		lea	(SP_ArtSpheres).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping

		move.w	#$98C0,d2				; write to VRAM address
		lea	(SP_ArtRings).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping

		move.w	#$A160,d2				; write to VRAM address
		lea	(SP_ArtShadows).l,a1			; load kosinski moduled compress art address
		jsr	Queue_Kos_Module.w			; queue file for decompression and VRAM dumping

	move.w	#$BA00,d2
	lea	(SP_ArtDebug).l,a1
	jsr	Queue_Kos_Module.w

	; --- Decompress Kos Module data ---

SP_DelayLoad:
		move.b	#$02,(V_int_routine).w			; set interrupt routine to run
		jsr	Process_Kos_Queue			; decompress data while waiting
		jsr	Wait_VSync				; continue waiting for V-blank
		jsr	Process_Kos_Module_Queue.w		; process the next queue if needed
		tst.l	(Kos_module_queue).w			; is the queue empty?
		bne.s	SP_DelayLoad				; if not, branch
		move.b	#$02,(V_int_routine).w			; set interrupt routine to run
		jsr	Process_Kos_Queue			; decompress data while waiting
		jsr	Wait_VSync				; continue waiting for V-blank

		move	#$2700,sr				; disable interrupts
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port

	jmp	SP_StartLevel

	move.l	#$C00A0000,(a6)
	move.w	#$0000,(a5)
	move.w	#$8100|%01110100,(a6)


SP_Loop:
		moveq	#$01-1,d2
		moveq	#$0F,d3
		move.w	#$8000|($BA00/$20),d4
		move.l	#$42100003,(a6)
		lea	(ESS_StageP1).w,a0
		jsr	VBSS_WD_NextWord

		moveq	#$01-1,d2
		move.l	#$421C0003,(a6)
		lea	(ESS_StageMode-1).w,a0	; Stage mode is on an odd address unfortunately...
		jsr	VBSS_WD_NextWord

		jsr	Poll_Controllers			; read controls

	move.w	#$FFFF,d0
	dbf	d0,*

	move.b	(Ctrl_1_pressed).w,d0
	bmi.s	SP_StartLevel
	lsl.b	#$04,d0
	bpl.s	SPP1_R
	addq.b	#$01,(ESS_StageP1).w

SPP1_R:
	add.b	d0,d0
	bpl.s	SPP1_L
	subq.b	#$01,(ESS_StageP1).w

SPP1_L:
	add.b	d0,d0
	bpl.s	SPP1_D
	subq.b	#$01,(ESS_StageMode).w
	cmpi.b	#$FF,(ESS_StageMode).w
	bge.s	SPP1_D
	move.b	#$FF,(ESS_StageMode).w

SPP1_D:
	add.b	d0,d0
	bpl.s	SPP1_U
	addq.b	#$01,(ESS_StageMode).w
	cmpi.b	#$01,(ESS_StageMode).w
	ble.s	SPP1_U
	move.b	#$01,(ESS_StageMode).w

SPP1_U:
	move.b	(Ctrl_2_pressed).w,d0
	bmi.s	SP_StartLevel
	lsl.b	#$04,d0
	bpl.s	SPP2_R
	addq.b	#$01,(ESS_StageP2).w

SPP2_R:
	add.b	d0,d0
	bpl.s	SPP2_L
	subq.b	#$01,(ESS_StageP2).w

SPP2_L:
	bra.w	SP_Loop

SP_StartLevel:

		move.l	#Ctrl_1_Held&$FFFFFF,(ESS_P1_Floor+ESS_Controller).w
		move.l	#Ctrl_2_Held&$FFFFFF,(ESS_P2_Floor+ESS_Controller).w

;	movea.l	#ESS_P1_Floor+ESS_ButtonCPU,(ESS_P1_Floor+ESS_Controller).w	; set player 1 as CPU player
;	movea.l	#ESS_P2_Floor+ESS_ButtonCPU,(ESS_P2_Floor+ESS_Controller).w	; set player 2 as CPU player




	move.w	#$8100|%00110100,(a6)
	move.l	#$C00A0000,(a6)
	move.w	#$0EEE,(a5)

	; --- Loading mappings for floor ---

		move.l	#$42000003,(a6)				; set VDP to VRAM write mode (FG plane)
		move.l	#$80008000,d0				; prepare blank tiles at high plane
		moveq	#$02-1,d3				; set to repeat for player 2 after player 1 is done

SP_NextSky:
		move.w	#($0400/$04)-1,d2			; set size of top section to set to high plane

SP_SkyHighPlane:
		move.l	d0,(a5)					; force top sky area to high plane on FG
		dbf	d2,SP_SkyHighPlane			; repeat until plane is mapped
		move.l	#$50000003,(a6)				; set VDP to VRAM write mdoe (player 2's FG plane)
		dbf	d3,SP_NextSky				; repeat again for player 2

		lea	(SP_MapFloor).l,a0			; load enigma compressed mappings address
		lea	($FFFF0000).l,a1			; load dump address
		move.w	#$8000,d0				; clear tile adjustment
		jsr	Eni_Decomp				; decompress and dump to RAM

		; Left Rotate

		lea	($FFFF03C0).l,a1			; load mappings address
		move.l	#$46000003,d0				; set VDP mode/address
		moveq	#$28-1,d1				; set width
		moveq	#$0C-1,d2				; set height
		move.w	#$0000,d3				; set tile adjustment
		jsr	SP_MapScreen				; dump mappings

		lea	($FFFF03C0).l,a1			; load mappings address
		move.l	#$54000003,d0				; set VDP mode/address
		moveq	#$28-1,d1				; set width
		moveq	#$0C-1,d2				; set height
		move.w	#$2000,d3				; set tile adjustment
		jsr	SP_MapScreen				; dump mappings

		; Middle movement

		lea	($FFFF0000).l,a1			; load mappings address
		move.l	#$46500003,d0				; set VDP mode/address
		moveq	#$28-1,d1				; set width
		moveq	#$0C-1,d2				; set height
		move.w	#$0000,d3				; set tile adjustment
		jsr	SP_MapScreen				; dump mappings

		lea	($FFFF0000).l,a1			; load mappings address
		move.l	#$54500003,d0				; set VDP mode/address
		moveq	#$28-1,d1				; set width
		moveq	#$0C-1,d2				; set height
		move.w	#$2000,d3				; set tile adjustment
		jsr	SP_MapScreen				; dump mappings

		; Right rotate

		lea	($FFFF03C0).l,a1			; load mappings address
		moveq	#$28-1,d1				; set width
		moveq	#$0C-1,d2				; set height
		jsr	SP_MirrorMap				; mirror the mappings

		lea	($FFFF03C0).l,a1			; load mappings address
		move.l	#$46A00003,d0				; set VDP mode/address
		moveq	#$28-1,d1				; set width
		moveq	#$0C-1,d2				; set height
		move.w	#$0800,d3				; set tile adjustment
		jsr	SP_MapScreen				; dump mappings

		lea	($FFFF03C0).l,a1			; load mappings address
		move.l	#$54A00003,d0				; set VDP mode/address
		moveq	#$28-1,d1				; set width
		moveq	#$0C-1,d2				; set height
		move.w	#$2800,d3				; set tile adjustment
		jsr	SP_MapScreen				; dump mappings

	; --- Loading BG wall and backdrop floor ---

		lea	(SP_MapBG).l,a0				; load background mappings
		lea	($FFFF0000).l,a1			; ''
		jsr	MunDec					; ''

		lea	($FFFF0000).l,a1			; load mappings address
		move.l	#$60000003,(a6)				; set VDP write address
		move.w	#($1600/$02)-1,d2			; set size of mappings to dump
		move.w	#($56E0/$20)|$4000,d1			; prepare adjustment
		moveq	#$02-1,d3				; set to repeat for backdrop section

SP_LoadBG:
		move.w	(a1)+,d0				; load tile maps
		add.w	d1,d0					; adjust tiles
		move.w	d0,(a5)					; save to VDP
		dbf	d2,SP_LoadBG				; repeat until mappings have been dumped
		ori.w	#$E000,d1				; set to render backdrop as high plane...
		move.w	#($0A00/$02)-1,d2			; set size of backdrop section
		dbf	d3,SP_LoadBG				; repeat for backdrop now...

	; --- Setting up VDP related stuff ---

		move.l	#$40000010,(a6)				; set VDP to VSRAM write
		move.w	#$0020,(a5)				; write FG position (to move away from H-scroll table)
		move.l	#VB_SpecialStage,(V_int_addr).w		; set blanking routines
		move.l	#NullRTE,(H_int_addr).w			; ''

	move.l	#$70000002,(a6)
	move.l	#$33333333,d0
	moveq	#($5*4)-1,d1

SP_LoadSonic:
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	dbf	d1,SP_LoadSonic

	move.l	#$77777777,d0
	moveq	#($5*4)-1,d1

SP_LoadTails:
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	move.l	d0,(a5)
	dbf	d1,SP_LoadTails

	; --- Setting up sprite tables ---

		lea	(ESS_SpritesP1).w,a0			; load player 1's sprite table
		lea	(ESS_SpritesP2A).w,a1			; load player 2's sprite table buffer A
		lea	(ESS_SPritesP2B).w,a2			; load player 2's sprite table buffer B
		moveq	#$01,d0					; reset d0
		moveq	#$00,d1					; clear d1
		moveq	#($280/8)-1,d2				; set size to write

SP_SetupSprite:
		move.l	d0,(a0)+				; write Y pos, shape and priority
		move.l	d1,(a0)+				; write VRAM and X pos
		move.l	d0,(a1)+				; write Y pos, shape and priority
		move.l	d1,(a1)+				; write VRAM and X pos
		move.l	d0,(a2)+				; write Y pos, shape and priority
		move.l	d1,(a2)+				; write VRAM and X pos
		addq.b	#$01,d0					; increase sprite ID
		dbf	d2,SP_SetupSprite			; repeat until entire table is done

	; --- BG palette ---

		lea	(ESS_PalBG_P2).w,a0			; load player 2's BG palette
		move.w	#$0EEE,d0				; set BG palette to white
		move.w	d0,(a0)+				; ''
		move.w	d0,(a0)+				; ''
		move.w	d0,(a0)+				; ''

	; --- Ring marker layout ---

		lea	(ESS_Layout_Ring).l,a1			; load ring layout data
		move.l	#$7F7F7F7F,d0				; reset d0
		move.w	#(($2000/$04)/$04)-1,d1			; size of marker layout to clear

SP_SetupMarker:
		move.l	d0,(a1)+				; reset ring layout marker
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		move.l	d0,(a1)+				; ''
		dbf	d1,SP_SetupMarker			; repeat until entire marker area is reset

	; --- Game modes ---

		move.b	#$07,(ESS_PalFade).w			; reset counter
		move.b	#SS_GAMESTART,(ESS_GameStart).w		; set game start timer

		move.b	(ESS_StageMode).w,d0			; load game mode
		ext.w	d0					; extend to upper word
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		jsr	SP_Modes+4(pc,d0.w)			; run correct routine for game modes
		bsr.w	SP_SetupPlayers				; setup the players correctly (speed/frame init/etc)

		; Doing the below twice due to Player 2's double buffer

		st.b	(V_int_routine).w			; set V-blank flag
		jsr	Wait_VSync				; wait for V-blank
		lea	(Target_palette).w,a1			; load player 1's palette buffer
		bsr.w	SB_SpecialStage				; run subroutines

		st.b	(V_int_routine).w			; set V-blank flag
		jsr	Wait_VSync				; wait for V-blank
		lea	(Target_palette).w,a1			; load player 1's palette buffer
		bsr.w	SB_SpecialStage				; run subroutines

		move.w	#$8100|%01110100,(a6)	; enable display; SDVM P100 - SMS mode (0N|1Y) | Display (0N|1Y) | V-Interrupt (0N|1Y) | DMA (0N|1Y) | V-resolution (0-1C|1-1E)

		moveq	#Mus_SpecialStage,d0			; set sound ID to "Special Stage"
		jsr	Play_Sound.w				; play sound ID

		bra.w	ML_SpecialFadeIn			; run special stage routine

	; --- The game mode routines ---

SP_Modes:	bra.w	SP_GetBlueSpheres			; FF = Get Blue Spheres (Separate Stages)
		bra.w	SP_GetMostSpheres			; 00 = Get Most Spheres (Same Stage)
		bra.w	SP_GetOpponentSpheres			; 01 = Get Opponent Spheres (Same Stage)

; ---------------------------------------------------------------------------
; setup routine for both players
; ---------------------------------------------------------------------------

SP_SetupPlayers:
		lea	(ESS_P1_Floor).w,a2			; load player 1's floor info
		move.b	#$00,ESS_PlayerID(a2)			; set player ID
		bsr.w	SPSP_Setup				; set player 1 up
		lea	(ESS_P2_Floor).w,a2			; load player 2's floor info
		move.b	#$01,ESS_PlayerID(a2)			; set player ID
						; continue to..	; set player 2 up

SPSP_Setup:
		moveq	#$00,d0					; clear d0
		move.b	ESS_SpeedLevel(a2),d0			; load speed level
		add.w	d0,d0					; multiply by size of word
		lea	(SSCF_Speeds).l,a0			; load speeds list
		move.w	(a0,d0.w),ESS_FloorSpeed(a2)		; load the starting speed level
		st.b	ESS_FrameEntry(a2)			; force a frame update on the player
		st.b	ESS_RingPos(a2)				; remove collected ring layout position
		st.b	ESS_SpriteD(a2)				; set no opponent sprite to display
	st.b	ESS_Changed(a2)				; set layout as changed (for CPU to start)
	st.b	ESS_SphereNear(a2)			; set no sphere as visible (for CPU to start)
	st.b	ESS_SphereFar(a2)			; set no sphere far away
	st.b	ESS_SphereDest(a2)			; set no current destination sphere
	st.b	ESS_SphereFarDest(a2)			; set no far away destination sphere
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; FF - Get Blue Spheres (Separate Stages)
; ---------------------------------------------------------------------------

SP_GetBlueSpheres:

	; --- Player 1 ---

		moveq	#$00,d0					; clear d0
		move.b	(ESS_StageP1).w,d0			; load player 1's stage ID
		add.w	d0,d0					; multiply by size of word
		lea	(SP_Stages).l,a4			; load stage list
		adda.w	(a4,d0.w),a4				; load correct stage data
		move.l	(a4)+,d0				; load stage colours
		lea	(ESS_FramePal_P1).w,a1			; load frame palette list
		move.l	a1,(ESS_P1_Floor+ESS_PalList).w		; save address to player
		bsr.w	SP_SetupColours				; setup colour frame animations
		lea	(SP_Palette).l,a0			; load palette data (temp)
		lea	(Target_palette+$40).w,a1		; load the main palette
		moveq	#((SP_Palette_End-SP_Palette)/2)-1,d1	; size of palette to load

SP_GBS_SetupPalette:
		move.w	(a0)+,(a1)+				; copy colours
		dbf	d1,SP_GBS_SetupPalette			; repeat until palette is filled
		lea	(Target_palette+$40+$1A).w,a1		; load background position of palette
		move.l	(a4)+,(a1)+				; copy background colours
		move.w	(a4)+,(a1)+				; ''

		move.b	(a4)+,(ESS_P1_Floor+ESS_LayoutX).w	; load X position
		move.b	(a4)+,(ESS_P1_Floor+ESS_LayoutY).w	; load Y position
		move.b	(a4)+,(ESS_P1_Floor+ESS_Direction).w	; load direction facing
		addq.w	#$03,a4					; skip player 2's data

		lea	(ESS_Layout_P1).l,a1			; load layout address
		move.l	a1,(ESS_P1_Floor+ESS_Layout).w		; save layout address
		bsr.w	SP_LoadLayout				; load the level layout

	; --- Player 2 ---

		moveq	#$00,d0					; clear d0
		move.b	(ESS_StageP2).w,d0			; load player 1's stage ID
		add.w	d0,d0					; multiply by size of word
		lea	(SP_Stages).l,a4			; load stage list
		adda.w	(a4,d0.w),a4				; load correct stage data
		move.l	(a4)+,d0				; load stage colours
		lea	(ESS_FramePal_P2).w,a1			; load frame palette list
		move.l	a1,(ESS_P2_Floor+ESS_PalList).w		; save address to player
		bsr.w	SP_SetupColours				; setup colour frame animations
		lea	(ESS_MainBG_P2).w,a1			; copy background colours to player 2's BG
		move.l	(a4)+,(a1)+				; ''
		move.w	(a4)+,(a1)+				; ''

		addq.w	#$03,a4					; skip player 1's data
		move.b	(a4)+,(ESS_P2_Floor+ESS_LayoutX).w	; load X position
		move.b	(a4)+,(ESS_P2_Floor+ESS_LayoutY).w	; load Y position
		move.b	(a4)+,(ESS_P2_Floor+ESS_Direction).w	; load direction facing

		lea	(ESS_Layout_P2).l,a1			; load layout address
		move.l	a1,(ESS_P2_Floor+ESS_Layout).w		; save layout address
		bra.s	SP_LoadLayout 				; load the level layout

; ===========================================================================
; ---------------------------------------------------------------------------
; 00 - Get Most Spheres (Same Stage)
; ---------------------------------------------------------------------------

SP_GetMostSpheres:

; ---------------------------------------------------------------------------
; 01 - Get Opponent Spheres (Same Stage)
; ---------------------------------------------------------------------------

SP_GetOpponentSpheres:

	; --- Player 1 ---

		moveq	#$00,d0					; clear d0
		move.b	(ESS_StageP1).w,d0			; load player 1's stage ID
		add.w	d0,d0					; multiply by size of word
		lea	(SP_Stages).l,a4			; load stage list
		adda.w	(a4,d0.w),a4				; load correct stage data
		move.l	(a4)+,d0				; load stage colours
		lea	(ESS_FramePal_P1).w,a1			; load frame palette list
		move.l	a1,(ESS_P1_Floor+ESS_PalList).w		; save to players
		move.l	a1,(ESS_P2_Floor+ESS_PalList).w		; ''
		bsr.w	SP_SetupColours				; setup colour frame animations

		lea	(SP_Palette).l,a0			; load palette data (temp)
		lea	(Target_palette+$40).w,a1		; load the main palette
		moveq	#((SP_Palette_End-SP_Palette)/2)-1,d1	; size of palette to load

SP_GMS_SetupPalette:
		move.w	(a0)+,(a1)+				; copy colours
		dbf	d1,SP_GMS_SetupPalette			; repeat until palette is filled
		lea	(Target_palette+$40+$1A).w,a1		; load background position of palette
		lea	(ESS_MainBG_P2).w,a2			; load player 2's BG colours
		move.l	(a4),(a1)+				; copy background colours to both players
		move.l	(a4)+,(a2)+				; ''
		move.w	(a4),(a1)+				; ''
		move.w	(a4)+,(a2)+				; ''

		move.b	(a4)+,(ESS_P1_Floor+ESS_LayoutX).w	; load X position
		move.b	(a4)+,(ESS_P1_Floor+ESS_LayoutY).w	; load Y position
		move.b	(a4)+,(ESS_P1_Floor+ESS_Direction).w	; load direction facing
		move.b	(a4)+,(ESS_P2_Floor+ESS_LayoutX).w	; load X position
		move.b	(a4)+,(ESS_P2_Floor+ESS_LayoutY).w	; load Y position
		move.b	(a4)+,(ESS_P2_Floor+ESS_Direction).w	; load direction facing

		lea	(ESS_Layout_P1).l,a1			; load layout address
		move.l	a1,(ESS_P1_Floor+ESS_Layout).w		; save layout address
		move.l	a1,(ESS_P2_Floor+ESS_Layout).w		; save layout address
						; continue to..	; load level layout

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load a stage layout into RAM correctly
; ---------------------------------------------------------------------------
; Ensuring that the rows will loop endlessly throughout the 100 byte line
; and that layout repeats above and below for wrappings...
; ---------------------------------------------------------------------------

SP_LoadLayout:
		moveq	#$20-1,d4				; size of row

SPLL_NextRow:
		moveq	#$01-1,d3				; set number of wraps per coloumn

SPLL_NextWrap:
		lea	(a4),a0					; load layout address
		moveq	#(($20/$04)/$04)-1,d2			; set size of column

SPLL_LoadColumn:
		move.l	(a0)+,(a1)+				; copy layout into RAM
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		move.l	(a0)+,(a1)+				; ''
		dbf	d2,SPLL_LoadColumn			; repeat until column is done
		dbf	d3,SPLL_NextWrap			; repeat for all wraps
		lea	(a0),a4					; advance to next row
		lea	$E0(a1),a1	; 100 - (20 * 3)	; ''
		dbf	d4,SPLL_NextROw				; repeat for all rows
		rts						; return

; ---------------------------------------------------------------------------
; A RAW version, this is for the menus' display, it will only keep the type
; ID, clearing the rest of the data...
; ---------------------------------------------------------------------------

SP_LoadLayout_RAW:
		moveq	#$20-1,d4				; size of row
		move.l	#$0F0F0F0F,d1				; prepare AND type obtainer values

SPLLR_NextRow:
		moveq	#$01-1,d3				; set number of wraps per coloumn

SPLLR_NextWrap:
		lea	(a4),a0					; load layout address
		moveq	#(($20/$04)/$04)-1,d2			; set size of column

SPLLR_LoadColumn:
	rept	$04
		move.l	(a0)+,d0				; load layout data
		and.l	d1,d0					; get only types
		move.l	d0,(a1)+				; save to layout RAM
	endm
		dbf	d2,SPLLR_LoadColumn			; repeat until column is done
		dbf	d3,SPLLR_NextWrap			; repeat for all wraps
		lea	(a0),a4					; advance to next row
		lea	$E0(a1),a1	; 100 - (20 * 3)	; ''
		dbf	d4,SPLLR_NextROw				; repeat for all rows
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Fade in loop - Special Stage
; ---------------------------------------------------------------------------

ML_SpecialFadeIn_Next:
		st.b	(V_int_routine).w			; set V-blank flag
		jsr	Wait_VSync				; wait for V-blank
		subq.w	#$01,($FFFFFACE).w			; decrease delay counter
		bpl.s	ML_SpecialFadeIn_Next			; if still running, branch
		move.w	#$0002,($FFFFFACE).w			; reset delay counter

ML_SpecialFadeIn:
		lea	(Normal_palette).w,a0			; load destination palette
		lea	(Target_palette).w,a1			; load source palette
		moveq	#$40-1,d0				; set number of colours to fade

MLSFI_MainPalette:
		jsr	Pal_DecColor2				; fade colour in from white
		dbf	d0,MLSFI_MainPalette			; repeat for all colours
		lea	(ESS_PalBG_P2).w,a0			; load destination palette
		lea	(ESS_MainBG_P2).w,a1			; load source palette
		moveq	#$03-1,d0				; set number

MLSFI_BGPalette:
		jsr	Pal_DecColor2				; fade colour in from white
		dbf	d0,MLSFI_BGPalette			; repeat for all colours
		subq.b	#$01,(ESS_PalFade).w			; decrease fade counter
		bne.s	ML_SpecialFadeIn_Next			; if still running, branch

		bsr.s	SB_SpecialStage				; run subroutines before updating last palette fading
		clr.w	(ESS_LagCount).w			; reset lag counter
	move.w	(ESS_LagCount).w,(ESS_Debug00).w

		move.w	#$8C00|%10001001,(a6)	; enable shadow	; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)

; ===========================================================================
; ---------------------------------------------------------------------------
; Main Loop - Special Stage
; ---------------------------------------------------------------------------

ML_SpecialStage:
		st.b	(V_int_routine).w			; set V-blank flag
		jsr	Wait_VSync				; wait for V-blank
	move.b	(Ctrl_1_Pressed).w,d0
;	or.b	(Ctrl_2_Pressed).w,d0
	bmi.w	SS_Reset

	tst.b	(Ctrl_2_Pressed).w
	bpl.s	SS_NoTrap
	st.b	(ESS_Trap).w

SS_NoTrap:
		pea	ML_SpecialStage(pc)			; set loop address

		move.b	(ESS_GameStart).w,d0			; load timer
		subq.b	#$01,d0					; decrease timer
		bne.s	SBSS_NoForceGo				; if it's not reached 00, branch
		move.b	#$01,(ESS_P1_Floor+ESS_Move).w		; set to move both players forwards
		move.b	#$01,(ESS_P2_Floor+ESS_Move).w		; ''
			; carry should be clear so the timer should be updated fine...

SBSS_NoForceGo:
		bcs.s	SBSS_TimerFinish			; if it's finished (below 00), branch
		move.b	d0,(ESS_GameStart).w			; update timer

SBSS_TimerFinish:
		lea	(Normal_palette+$00).w,a1		; load player 1's palette buffer

SB_SpecialStage:
		lea	(ESS_P1_Floor).w,a2			; load player 1's floor details
		bsr.w	SS_ControlFloor				; control player 1's floor

		lea	$20(a1),a1				; load player 2's palette buffer
		lea	(ESS_P2_Floor).w,a2			; load player 2's floor details
		bsr.w	SS_ControlFloor				; control player 2's floor

		lea	(ESS_P1_Floor).w,a2			; load player 1's floor details
		bsr.w	SS_ReadSpheres				; read and react to spheres
		lea	(ESS_P2_Floor).w,a2			; load player 1's floor details
		bsr.w	SS_ReadSpheres				; read and react to spheres

		bsr.w	SS_PlayerArt				; render player art

		bsr.w	SS_RenderSprites			; render the sprites

		moveq	#$00,d0					; clear d0
		move.b	(ESS_P1_Floor+ESS_SpeedLevel).w,d0	; load player 1's speed level
		cmp.b	(ESS_P2_Floor+ESS_SpeedLevel).w,d0	; is player 2's speed faster?
		bcc.s	SBSS_CheckTempo				; if not, branch
		move.b	(ESS_P2_Floor+ESS_SpeedLevel).w,d0	; use player 2's speed instead

SBSS_CheckTempo:
		cmp.b	(ESS_MusicTempo).w,d0			; has the tempo changed?
		bne.s	SBSS_SetTempo				; if not, branch
		rts						; return

SBSS_SetTempo:
		move.b	d0,(ESS_MusicTempo).w			; update new tempo
		move.b	SBSS_TempoList(pc,d0.w),d0		; load correct tempo
		jmp	Change_Music_Tempo			; save tempo to sound driver

	; --- Music Tempo List ---

SBSS_TempoList:	dc.b	$28,$20,$18,$10,$08,$00			; tempos in order of speed levels (Normal to fast)
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to render sprites on-screen
; ---------------------------------------------------------------------------

SS_RenderSprites:
		moveq	#$00,d0					; clear d0

	; --- Player 1 ---

	move.w	#$4000|($B500/$20),d4
		move.w	#$0080,d5				; set Y position adjustment
		lea	(ESS_P1_Floor).w,a2			; load player 1's floor details
		lea	(ESS_SpritesP1).w,a3			; load sprite table
		move.b	(ESS_LinkP1).w,d0			; load last link ID that was removed
		bsr.s	SS_RenderPerform			; perform the rendering
		move.b	d0,(ESS_LinkP1).w			; save new last link ID

	; --- Player 2 ---

	move.w	#$4000|($B780/$20),d4
		move.w	#$0080+(224/2),d5			; set Y position adjustment
		lea	(ESS_P2_Floor).w,a2			; load player 2's floor details
		tst.b	(ESS_H2_Buffer).w			; is buffer A being displayed?
		bne.s	SSRS_BufferB				; if so, branch (write to buffer B instead...)

		; --- (Buffer A) ---

		lea	(ESS_SpritesP2A).w,a3			; load sprite table
		move.b	(ESS_LinkP2A).w,d0			; load last link ID that was removed
		bsr.s	SS_RenderPerform			; perform the rendering
		move.b	d0,(ESS_LinkP2A).w			; save new last link ID
		rts						; return

SSRS_BufferB:

		; --- (Buffer B) ---

		lea	(ESS_SpritesP2B).w,a3			; load sprite table
		move.b	(ESS_LinkP2B).w,d0			; load last link ID that was removed
		bsr.s	SS_RenderPerform			; perform the rendering
		move.b	d0,(ESS_LinkP2B).w			; save new last link ID
		rts						; return

; ---------------------------------------------------------------------------
; Performing sprite rendering; but attenting to the link ID first
; ---------------------------------------------------------------------------

SS_RenderPerform:
		moveq	#-1,d1					; prepare -1
		add.w	d0,d1					; load ID and subtract 1
		bcc.s	SSRP_NoLink				; if there's no link to restore, branch
		lsl.w	#$03,d1					; multiply by 8 (size of sprite entry)
		move.b	d0,$03(a3,d1.w)				; restore last link

SSRP_NoLink:
		pea	(a3)					; store sprite table
		bsr.s	SSRP_Render				; do the necessary sprite rendering here
		moveq	#$00,d0					; clear d0 (set link ID to first)
		move.l	(sp)+,d1				; reload original sprite table
		sub.l	a3,d1					; minus current table address
		beq.s	SSRP_Clear				; if no sprites were written, branch
		cmpi.b	#$50,-$05(a3)				; have all sprites been written to?
		beq.s	SSRP_NoClear				; if so, branch (no need to clear)

SSRP_Clear:
		move.b	$03(a3),d0				; load link ID
		clr.l	(a3)					; hide sprite and clear ID

SSRP_NoClear:
		rts						; return

; ---------------------------------------------------------------------------
; The sprite rendering routines themselves
; ---------------------------------------------------------------------------

SSRP_Render:
		bsr.s	SSRP_RenderPlayer

		st.b	ESS_SphereNear(a2)				; clear last near and far spheres
		st.b	ESS_SphereFar(a2)				; ''
		st.b	(ESS_SphereLoc).w				; ''
		st.b	(ESS_SphereLast).w				; ''
		bsr.w	SSRP_RenderSpheres				; do the level spheres of the layout
		btst.b	#$00,ESS_Point(a2)				; is the stage turning?
		bne.s	SSRP_NoSpheres					; if so, branch (ignore spheres)
		move.w	(ESS_SphereLoc).w,ESS_SphereNear(a2)		; store near sphere
		move.w	(ESS_SphereLast).w,ESS_SphereFar(a2)		; store far sphere

SSRP_NoSpheres:

	; --- The shadow of the main player ---

		tst.b	(ESS_PalFade).w				; has fading fully finished?
		bne.s	SSRP_NoShadow				; if not, branch
		move.w	d5,d0					; load player's Y position
		addi.w	#$004C,d0				; advance to players' standing position for shadow
		move.w	d0,(a3)+				; save Y position
		move.b	#$0D,(a3)+				; set shape of shadow
		addq.w	#$01,a3					; skip link ID
		move.w	#$E000|($A160/$20),(a3)+		; set VRAM address to shadow art
		move.w	#$0080+((320/2)-$10),(a3)+		; set X position

SSRP_NoShadow:
		rts						; return


; ===========================================================================
; ---------------------------------------------------------------------------
; TEMP!!!!!  Subroutine to render the opponent (just a test/example for now)
; Need a way of rendering the opponent with the correct priority later which
; will likely require rendering the player while rendering the spheres...
; ---------------------------------------------------------------------------

SSRP_RenderPlayer:
	moveq	#$00,d0
	move.b	ESS_JumpPos(a2),d0
	beq.s	SSRP_NoJump
	ext.w	d0
	addq.w	#$08,d0

SSRP_NoJump:
	add.w	d5,d0

	;	move.w	d5,d0					; load player's Y position
		addi.w	#$002B,d0				; advance to players' standing position for shadow
		move.w	d0,(a3)+				; save Y position
		move.b	#$0F,(a3)+				; set shape of shadow
		addq.w	#$01,a3					; skip link ID
		move.w	d4,d1
		subi.w	#($0280/$20)*2,d1
		ori.w	#$8000,d1
		move.w	d1,(a3)+
		move.w	#$0080+((320/2)-$10),(a3)+		; set X position

	tst.b	ESS_JumpPos(a2)
	bne.s	SSRP_NoLower

		move.w	d5,d0					; load player's Y position
		addi.w	#$002B+$20,d0				; advance to players' standing position for shadow
		move.w	d0,(a3)+				; save Y position
		move.b	#$0C,(a3)+				; set shape of shadow
		addq.w	#$01,a3					; skip link ID
	addi.w	#$0010,d1
		move.w	d1,(a3)+
		move.w	#$0080+((320/2)-$10),(a3)+		; set X position

SSRP_NoLower:

	tst.b	ESS_SpriteD(a2)				; is there an opponent sprite to display?
	bmi.s	SSRP_NoOpponent				; if not, branch
		move.w	ESS_SpriteY(a2),d0			; load opponent's Y position
		add.w	d5,d0					; advance to player's Y screen position
		move.w	d0,(a3)+				; save Y position
		move.b	#$0F,(a3)+				; set shape
		addq.w	#$01,a3					; skip link ID
		move.w	ESS_SpriteP(a2),d0			; load plane high/low
		sf.b	d0					; keep only the plane byte (in the upper word)
		or.w	d0,d4					; set high plane on sprite if necessary
		move.w	d4,(a3)+				; save VRAM address of opponents' art
		move.w	ESS_SpriteX(a2),d0			; load opponent's X position
		addi.w	#($0080+((320/2)-$10)),d0		; adjust to screen correctly
		move.w	d0,(a3)+				; save X position
		move.w	ESS_SpriteY(a2),d0			; load opponent's Y position
		addi.w	#$0020,d0				; adjust for next sprite's position
		add.w	d5,d0					; advance to player's Y screen position
		move.w	d0,(a3)+				; save Y position
		move.b	#$0C,(a3)+				; set shape
		addq.w	#$01,a3					; skip link ID
		addi.w	#$0010,d4				; advance VRAM to next sprite
		move.w	d4,(a3)+				; save VRAM address of opponents' next sprite art
		move.w	ESS_SpriteX(a2),d0			; load opponent's X position
		addi.w	#($0080+((320/2)-$10)),d0		; adjust to screen correctly
		move.w	d0,(a3)+				; save X position

SSRP_NoOpponent:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to render spheres from the layout
; ---------------------------------------------------------------------------

SSRP_RenderSpheres:
		pea	(a2)					; store a2
		movea.l	ESS_Layout(a2),a1			; load layout
		moveq	#$00,d0					; load correct frame entry
		move.b	ESS_FrameEntry(a2),d0			; ''
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		lea	(SS_RenderList).l,a0			; load render list table
		movea.l	(a0,d0.w),a0				; advance to correct render list entry
		move.b	ESS_Direction(a2),d0			; load direciton
		andi.w	#$0006,d0				; get only the direciton
		move.w	(a0,d0.w),d0				; load relative word
		lea	(a0,d0.w),a4				; load correct relative layout data based on direction facing
		addq.w	#$08,a0					; advance to sprite data
		move.w	(a0)+,d7				; load number of sprites to render
		bmi.s	SSRS_NoSpheres				; if there are no sprites, branch
		move.w	ESS_LayoutYX(a2),d3			; load X and Y position
		move.b	d3,d4					; copy X position to d4
		sf.b	d3					; clear X slot on Y position
		lea	(SSRS_VRAM_Mode).l,a2			; load VRAM list
		move.b	(ESS_StageMode).w,d1			; load stage mode
		ext.w	d1					; extend to signed word
		add.w	d1,d1					; convert to size of word pointer
		add.w	(a2,d1.w),a2				; load correct VRAM list

SSRS_NextSphere:
		move.w	(a4)+,d1				; load relative positions
		add.b	d4,d1					; add X position
		add.w	d3,d1					; add Y position
		andi.w	#$1F1F,d1				; keep within layout
		moveq	#$07,d0					; prepare to get only sphere type
		and.b	(a1,d1.w),d0				; load only the sphere type at the layout entry
		beq.s	SSRS_BlankSphere			; if there's no sphere/orb, branch
	move.b	SSRS_AndStore-$01(pc,d0.w),d2	; have to load to d2, AS is being a dick and won't let me tst it directly.
	bmi.s	SSRS_NoCPU
	move.w	d1,(ESS_SphereLast).w
;	or.b	d2,(ESS_SphereLast).w
	tst.b	(ESS_SphereLoc).w			; has the CPU already got a sphere to look for?
	bpl.s	SSRS_NoCPU				; if so, branch
	move.w	d1,(ESS_SphereLoc).w			; save layout address
;	move.b	SSRS_AndStore-$01(pc,d0.w),d2		; load MSB set/clear flag
;	or.b	d2,(ESS_SphereLoc).w			; set/clear MSB (if needed)

SSRS_NoCPU:

	; --- Sphere sprites ---

		move.w	(a0)+,d1				; load sprite Y position
		add.w	d5,d1					; avance to correct Y position on-screen
		move.w	d1,(a3)+				; save sprite Y pos
		move.w	(a0)+,d1				; load shape/type
		move.w	SSRS_ShapeType(pc,d1.w),d2		; load correct shape from list
		move.b	$01(a3),d2				; load priority
		move.w	d2,(a3)+				; save shape/priority
		lsl.w	#$05,d0					; multiply type by size of sphere's VRAM list
		add.w	d0,d1					; add sphere type/ID
		move.w	(a2,d1.w),d1				; add VRAM sphere type
		move.w	d1,(a3)+				; save VRAM
		move.w	(a0)+,(a3)+				; save X pos
		dbf	d7,SSRS_NextSphere			; repeat until all done

SSRS_NoSpheres:
		move.l	(sp)+,a2				; restore a2
		rts						; return

	; --- List of sprite shapes (for spheres) ---

SSRS_ShapeType:	dc.w	$0E00,$0E00,$0E00,$0E00,$0900,$0900,$0900,$0900
		dc.w	$0500,$0400,$0400,$0400,$0000,$0000,$0000,$0000

		;	Star, Blue, Orange, Yellow, Red, Blue(collect), Orange(collect)
SSRS_AndStore:	dc.b	$80,$00,$00,$80,$80,$80,$80
		even

	; --- Ring sprites ---

SSRS_BlankSphere:
		move.b	(a1,d1.w),d6				; load sphere ID
		btst.l	#$03,d6					; is it a ring?
		beq.s	SSRS_NoRings				; if not, branch
		move.w	(a0)+,d1				; load sprite Y position
		move.w	(a0)+,d0				; load shape/type
		btst.l	#$06,d6					; is this a collected ring?
		bne.s	SSRS_Collect				; if so, branch to keep "collected" type
		add.w	(ESS_RingFrame).w,d0			; add frame position

SSRS_Collect:
		move.l	a2,d6					; store a2
		lea	SSRS_RingData(pc,d0.w),a2		; load correct ring data
		add.w	(a2),d1					; add reposition Y for rings
		bmi.s	SSRS_BlankRing				; if this frame is invalid, branch
		add.w	d5,d1					; advance to correct Y position on-screen
		move.w	d1,(a3)+				; save sprite Y pos
		move.w	$20*4(a2),d2				; load correct shape from list
		move.b	$01(a3),d2				; load priority
		move.w	d2,(a3)+				; save shape/priority
		move.w	$20*8(a2),(a3)+				; save VRAM
		move.w	(a0)+,d1				; load sprite X position
		add.w	$20*$C(a2),d1				; add reposition X for rings
		move.w	d1,(a3)+				; save sprite X pos
		move.l	d6,a2					; restore a2
		dbf	d7,SSRS_NextSphere			; repeat until all done
		move.l	(sp)+,a2				; restore a2
		rts						; return

SSRS_BlankRing:
		move.l	d6,a2					; restore a2
		subq.w	#$04,a0					; revert back to beginning of entry

SSRS_NoRings:
		addq.w	#$06,a0					; skip entry
		dbf	d7,SSRS_NextSphere			; repeat until all done
		move.l	(sp)+,a2				; restore a2
		rts						; return

; ---------------------------------------------------------------------------
; Sprite adjustment data for rings/spheres/etc
; ---------------------------------------------------------------------------

SP_RED	=	($6000|($7880/$20))	; Red sphere
SPSTAR	=	($6000|($8340/$20))	; Star bumper sphere
SPBLUE	=	($6000|($5840/$20))	; Blue sphere
SPORAN	=	($6000|($6300/$20))	; Orange sphere
SPGREY	=	($6000|($6DC0/$20))	; Grey sphere
SPYELL	=	($6000|($8E00/$20))	; Yellow sphere
SPRING	=	($6000|($98C0/$20))	; Rings

	; --- List of ring VRAM/shape/repos data ---

SSRS_RingData:
		; --- Reposition Y ---

		dc.w	$0000,$0000,$8000,$8000,$8000,$8000,$8000,$8000		; Ring collected
		dc.w	$8000,$8000,$8000,$8000,$8000,$8000,$8000,$8000

		dc.w	$0004,$0004,$0000,$0004,$0004,$0004,$0004,$0004		; Normal
		dc.w	$0000,$0000,$0000,$0000,$8000,$8000,$8000,$8000

		dc.w	$0000,$0000,$0000,$0000,$0004,$0004,$0004,$0004		; Rotate right
		dc.w	$0000,$0000,$0000,$0000,$8000,$8000,$8000,$8000

		dc.w	$0000,$0000,$0000,$0000,$0004,$0004,$0004,$0004		; Rotate left
		dc.w	$0000,$0000,$0000,$0000,$8000,$8000,$8000,$8000

		; --- Shape ---

		dc.w	$0900,$0900,$0000,$0000,$0000,$0000,$0000,$0000		; Ring collected
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000

		dc.w	$0900,$0900,$0900,$0900,$0500,$0400,$0400,$0400		; Normal
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000

		dc.w	$0500,$0500,$0500,$0500,$0100,$0000,$0000,$0000		; Rotate right
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000

		dc.w	$0500,$0500,$0500,$0500,$0100,$0000,$0000,$0000		; Rotate left
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000

		; --- VRAM ---

		dc.w	$803F+SPRING,$803F+SPRING,$0000,$0000,$0000,$0000,$0000,$0000		; Ring collected
		dc.w	$0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000

		dc.w	$8000+SPRING,$8006+SPRING,$800C+SPRING,$8012+SPRING, $8018+SPRING,$801C+SPRING,$801E+SPRING,$8020+SPRING		; Normal
		dc.w	$8022+SPRING,$8023+SPRING,$8024+SPRING,$0025+SPRING, $0000,$0000,$0000,$0000

		dc.w	$8826+SPRING,$882A+SPRING,$882E+SPRING,$8832+SPRING, $8836+SPRING,$8838+SPRING,$8839+SPRING,$883A+SPRING		; Rotate left
		dc.w	$883B+SPRING,$883C+SPRING,$883D+SPRING,$083E+SPRING, $0000,$0000,$0000,$0000

		dc.w	$8026+SPRING,$802A+SPRING,$802E+SPRING,$8032+SPRING, $8036+SPRING,$8038+SPRING,$8039+SPRING,$803A+SPRING		; Rotate right
		dc.w	$803B+SPRING,$803C+SPRING,$803D+SPRING,$083E+SPRING, $0000,$0000,$0000,$0000

		; --- Reposition X ---

		dc.w	$0004,$0004,$8000,$8000,$8000,$8000,$8000,$8000		; Ring collected
		dc.w	$8000,$8000,$8000,$8000,$8000,$8000,$8000,$8000

		dc.w	$0004,$0004,$0004,$0004,$0004,$0004,$0004,$0004		; Normal
		dc.w	$0004,$0004,$0004,$0004,$8000,$8000,$8000,$8000

		dc.w	$0008,$0008,$0008,$0008,$0008,$0008,$0008,$0008		; Rotate right
		dc.w	$0004,$0004,$0004,$0004,$8000,$8000,$8000,$8000

		dc.w	$0008,$0008,$0008,$0008,$0008,$0008,$0008,$0008		; Rotate left
		dc.w	$0004,$0004,$0004,$0004,$8000,$8000,$8000,$8000

	; --- List of sphere VRAM ---

		dc.w	(SSRS_VRAM_Norm-$20)-SSRS_VRAM_Mode
SSRS_VRAM_Mode:	dc.w	(SSRS_VRAM_Most-$20)-SSRS_VRAM_Mode
		dc.w	(SSRS_VRAM_Oppo-$20)-SSRS_VRAM_Mode

; ---------------------------------------------------------------------------
; For game mdoe FF - "Normal"
; ---------------------------------------------------------------------------

SSRS_VRAM_Norm:	dc.w	$8000+SPSTAR,$800C+SPSTAR,$8018+SPSTAR,$8024+SPSTAR, $8030+SPSTAR,$8036+SPSTAR,$803C+SPSTAR,$8042+SPSTAR	; 1 - Star bumper
		dc.w	$8048+SPSTAR,$804C+SPSTAR,$804E+SPSTAR,$0050+SPSTAR, $0052+SPSTAR,$0053+SPSTAR,$0054+SPSTAR,$0055+SPSTAR

		dc.w	$8000+SPBLUE,$800C+SPBLUE,$8018+SPBLUE,$8024+SPBLUE, $8030+SPBLUE,$8036+SPBLUE,$803C+SPBLUE,$8042+SPBLUE	; 2 - Blue sphere
		dc.w	$8048+SPBLUE,$804C+SPBLUE,$804E+SPBLUE,$0050+SPBLUE, $0052+SPBLUE,$0053+SPBLUE,$0054+SPBLUE,$0055+SPBLUE

		dc.w	$8000+SPBLUE,$800C+SPBLUE,$8018+SPBLUE,$8024+SPBLUE, $8030+SPBLUE,$8036+SPBLUE,$803C+SPBLUE,$8042+SPBLUE	; 3 - Orange sphere
		dc.w	$8048+SPBLUE,$804C+SPBLUE,$804E+SPBLUE,$0050+SPBLUE, $0052+SPBLUE,$0053+SPBLUE,$0054+SPBLUE,$0055+SPBLUE

		dc.w	$8000+SPYELL,$800C+SPYELL,$8018+SPYELL,$8024+SPYELL, $8030+SPYELL,$8036+SPYELL,$803C+SPYELL,$8042+SPYELL	; 4 - Yellow sphere
		dc.w	$8048+SPYELL,$804C+SPYELL,$804E+SPYELL,$0050+SPYELL, $0052+SPYELL,$0053+SPYELL,$0054+SPYELL,$0055+SPYELL

		dc.w	$8000+SP_RED,$800C+SP_RED,$8018+SP_RED,$8024+SP_RED, $8030+SP_RED,$8036+SP_RED,$803C+SP_RED,$8042+SP_RED	; 5 - Red sphere (Layout default)
		dc.w	$8048+SP_RED,$804C+SP_RED,$804E+SP_RED,$0050+SP_RED, $0052+SP_RED,$0053+SP_RED,$0054+SP_RED,$0055+SP_RED

		dc.w	$8000+SP_RED,$800C+SP_RED,$8018+SP_RED,$8024+SP_RED, $8030+SP_RED,$8036+SP_RED,$803C+SP_RED,$8042+SP_RED	; 6 - Red sphere (Blue collect)
		dc.w	$8048+SP_RED,$804C+SP_RED,$804E+SP_RED,$0050+SP_RED, $0052+SP_RED,$0053+SP_RED,$0054+SP_RED,$0055+SP_RED

		dc.w	$8000+SP_RED,$800C+SP_RED,$8018+SP_RED,$8024+SP_RED, $8030+SP_RED,$8036+SP_RED,$803C+SP_RED,$8042+SP_RED	; 7 - Red sphere (Orange collect)
		dc.w	$8048+SP_RED,$804C+SP_RED,$804E+SP_RED,$0050+SP_RED, $0052+SP_RED,$0053+SP_RED,$0054+SP_RED,$0055+SP_RED

; ---------------------------------------------------------------------------
; For game mode 00 - "Get most spheres"
; ---------------------------------------------------------------------------

SSRS_VRAM_Most:	dc.w	$8000+SPSTAR,$800C+SPSTAR,$8018+SPSTAR,$8024+SPSTAR, $8030+SPSTAR,$8036+SPSTAR,$803C+SPSTAR,$8042+SPSTAR	; 1 - Star bumper
		dc.w	$8048+SPSTAR,$804C+SPSTAR,$804E+SPSTAR,$0050+SPSTAR, $0052+SPSTAR,$0053+SPSTAR,$0054+SPSTAR,$0055+SPSTAR

		dc.w	$8000+SPGREY,$800C+SPGREY,$8018+SPGREY,$8024+SPGREY, $8030+SPGREY,$8036+SPGREY,$803C+SPGREY,$8042+SPGREY	; 2 - Blue sphere
		dc.w	$8048+SPGREY,$804C+SPGREY,$804E+SPGREY,$0050+SPGREY, $0052+SPGREY,$0053+SPGREY,$0054+SPGREY,$0055+SPGREY

		dc.w	$8000+SPGREY,$800C+SPGREY,$8018+SPGREY,$8024+SPGREY, $8030+SPGREY,$8036+SPGREY,$803C+SPGREY,$8042+SPGREY	; 3 - Orange sphere
		dc.w	$8048+SPGREY,$804C+SPGREY,$804E+SPGREY,$0050+SPGREY, $0052+SPGREY,$0053+SPGREY,$0054+SPGREY,$0055+SPGREY

		dc.w	$8000+SPYELL,$800C+SPYELL,$8018+SPYELL,$8024+SPYELL, $8030+SPYELL,$8036+SPYELL,$803C+SPYELL,$8042+SPYELL	; 4 - Yellow sphere
		dc.w	$8048+SPYELL,$804C+SPYELL,$804E+SPYELL,$0050+SPYELL, $0052+SPYELL,$0053+SPYELL,$0054+SPYELL,$0055+SPYELL

		dc.w	$8000+SP_RED,$800C+SP_RED,$8018+SP_RED,$8024+SP_RED, $8030+SP_RED,$8036+SP_RED,$803C+SP_RED,$8042+SP_RED	; 5 - Red sphere (Layout default)
		dc.w	$8048+SP_RED,$804C+SP_RED,$804E+SP_RED,$0050+SP_RED, $0052+SP_RED,$0053+SP_RED,$0054+SP_RED,$0055+SP_RED

		dc.w	$8000+SPBLUE,$800C+SPBLUE,$8018+SPBLUE,$8024+SPBLUE, $8030+SPBLUE,$8036+SPBLUE,$803C+SPBLUE,$8042+SPBLUE	; 6 - Red sphere (Blue collect)
		dc.w	$8048+SPBLUE,$804C+SPBLUE,$804E+SPBLUE,$0050+SPBLUE, $0052+SPBLUE,$0053+SPBLUE,$0054+SPBLUE,$0055+SPBLUE

		dc.w	$8000+SPORAN,$800C+SPORAN,$8018+SPORAN,$8024+SPORAN, $8030+SPORAN,$8036+SPORAN,$803C+SPORAN,$8042+SPORAN	; 7 - Red sphere (Orange collect)
		dc.w	$8048+SPORAN,$804C+SPORAN,$804E+SPORAN,$0050+SPORAN, $0052+SPORAN,$0053+SPORAN,$0054+SPORAN,$0055+SPORAN

; ---------------------------------------------------------------------------
; For game mode 01 - "Get opponent spheres"
; ---------------------------------------------------------------------------

SSRS_VRAM_Oppo:	dc.w	$8000+SPSTAR,$800C+SPSTAR,$8018+SPSTAR,$8024+SPSTAR, $8030+SPSTAR,$8036+SPSTAR,$803C+SPSTAR,$8042+SPSTAR	; 1 - Star bumper
		dc.w	$8048+SPSTAR,$804C+SPSTAR,$804E+SPSTAR,$0050+SPSTAR, $0052+SPSTAR,$0053+SPSTAR,$0054+SPSTAR,$0055+SPSTAR

		dc.w	$8000+SPBLUE,$800C+SPBLUE,$8018+SPBLUE,$8024+SPBLUE, $8030+SPBLUE,$8036+SPBLUE,$803C+SPBLUE,$8042+SPBLUE	; 2 - Blue sphere
		dc.w	$8048+SPBLUE,$804C+SPBLUE,$804E+SPBLUE,$0050+SPBLUE, $0052+SPBLUE,$0053+SPBLUE,$0054+SPBLUE,$0055+SPBLUE

		dc.w	$8000+SPORAN,$800C+SPORAN,$8018+SPORAN,$8024+SPORAN, $8030+SPORAN,$8036+SPORAN,$803C+SPORAN,$8042+SPORAN	; 3 - Orange sphere
		dc.w	$8048+SPORAN,$804C+SPORAN,$804E+SPORAN,$0050+SPORAN, $0052+SPORAN,$0053+SPORAN,$0054+SPORAN,$0055+SPORAN

		dc.w	$8000+SPYELL,$800C+SPYELL,$8018+SPYELL,$8024+SPYELL, $8030+SPYELL,$8036+SPYELL,$803C+SPYELL,$8042+SPYELL	; 4 - Yellow sphere
		dc.w	$8048+SPYELL,$804C+SPYELL,$804E+SPYELL,$0050+SPYELL, $0052+SPYELL,$0053+SPYELL,$0054+SPYELL,$0055+SPYELL

		dc.w	$8000+SP_RED,$800C+SP_RED,$8018+SP_RED,$8024+SP_RED, $8030+SP_RED,$8036+SP_RED,$803C+SP_RED,$8042+SP_RED	; 5 - Red sphere (Layout default)
		dc.w	$8048+SP_RED,$804C+SP_RED,$804E+SP_RED,$0050+SP_RED, $0052+SP_RED,$0053+SP_RED,$0054+SP_RED,$0055+SP_RED

		dc.w	$8000+SP_RED,$800C+SP_RED,$8018+SP_RED,$8024+SP_RED, $8030+SP_RED,$8036+SP_RED,$803C+SP_RED,$8042+SP_RED	; 6 - Red sphere (Blue collect)
		dc.w	$8048+SP_RED,$804C+SP_RED,$804E+SP_RED,$0050+SP_RED, $0052+SP_RED,$0053+SP_RED,$0054+SP_RED,$0055+SP_RED

		dc.w	$8000+SP_RED,$800C+SP_RED,$8018+SP_RED,$8024+SP_RED, $8030+SP_RED,$8036+SP_RED,$803C+SP_RED,$8042+SP_RED	; 7 - Red sphere (Orange collect)
		dc.w	$8048+SP_RED,$804C+SP_RED,$804E+SP_RED,$0050+SP_RED, $0052+SP_RED,$0053+SP_RED,$0054+SP_RED,$0055+SP_RED

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control the floor using player's controller
; ---------------------------------------------------------------------------
SpeedInc	=	$0008
; ---------------------------------------------------------------------------

	; --- Speeds (please keep these in multiples of the SpeedInc) ---

SSCF_Speeds:	dc.w	$0080,$00A0,$00C0,$00E0,$0100
SSCF_Speeds_End:

SSCF_SpeedSize = (((SSCF_Speeds_End-SSCF_Speeds)/2)-1)	; Maximum speed level...

	; --- The routine itself ---

SS_ControlFloor:
		move.l	ESS_Controller(a2),d0			; load controller address
		movea.l	d0,a3					; set address in a3 (shouldn't affect Z flag)
		bpl.s	SSCF_Human				; if this is a human controller, brancher address
		jsr	SS_CPU					; run CPU routine

SSCF_Human:
		sf.b	ESS_Changed(a2)				; clear changed layout position flag
	btst.b	#$06,$01(a3)	; A
	beq.s	SSCF_NoInc
	addq.b	#$01,ESS_SpeedLevel(a2)

SSCF_NoInc:
	btst.b	#$05,$01(a3)	; C
	beq.s	SSCF_NoDec
	subq.b	#$01,ESS_SpeedLevel(a2)
	bpl.s	SSCF_NoDec
	sf.b	ESS_SpeedLevel(a2)

SSCF_NoDec:
		btst.b	#$04,$01(a3)				; has player pressed jump?
		beq.s	SSCF_NoJump				; if not, branch
		tst.b	ESS_JumpPos(a2)				; is the player already in the air?
		bne.s	SSCF_NoJump				; if so, branch (don't jump again)
		move.w	#-$0440,ESS_JumpSpeed(a2)		; set starting jump speed
		moveq	#$62,d0					; play jump SFX
		jsr	Play_Sound_2				; ''

SSCF_NoJump:
		move.w	ESS_JumpSpeed(a2),d0			; load jump speed
		add.w	ESS_JumpPos(a2),d0			; add jump position
		bmi.s	SSCF_NoStop				; if we're above the floor, branch
		moveq	#$00,d0					; clear d0
		move.w	d0,ESS_JumpSpeed(a2)			; stop jumping
		move.w	d0,ESS_JumpPos(a2)			; ''
		bra.s	SSCF_StopJump				; continue

SSCF_NoStop:
		move.w	d0,ESS_JumpPos(a2)			; update jumping position
		addi.w	#$0040,ESS_JumpSpeed(a2)		; increase speed downwards

SSCF_StopJump:

		tst.b	ESS_Move(a2)				; are we moving?
		bne.s	SSCF_Moving				; if not, branch
		addq.w	#$01,a3					; use pressed controls (for rotation)
		sf.b	ESS_RotateHold(a2)			; clear rotation hold flag

SSCF_Moving:
		moveq	#$00,d0					; clear d0
		move.b	ESS_SpeedLevel(a2),d0			; load speed level
		cmpi.b	#SSCF_SpeedSize,d0			; is the level beyond the maximum speed?
		bls.s	SSCF_NoMaxSpeed				; if not, branch
		move.b	#SSCF_SpeedSize,d0			; force to maximum speed (don't want it to get out of hand...)
		move.b	d0,ESS_SpeedLevel(a2)			; ''

SSCF_NoMaxSpeed:
		btst.b	#$00,ESS_Point(a2)			; is the stage rotating?
		bne.s	SSCF_NoChange				; if so, branch
		add.w	d0,d0					; multiply by size of word
		lea	SSCF_Speeds(pc),a0
		move.w	(a0,d0.w),d0				; load speed
		tst.b	ESS_Move(a2)				; is the player moving forwards?
		bpl.s	SSCF_NoRevSpeed				; if so, branch
		neg.w	d0					; reverse direction

SSCF_NoRevSpeed:
		cmp.w	ESS_FloorSpeed(a2),d0			; has the speed changed?
		beq.s	SSCF_NoChange				; if not, branch
		bpl.s	SSCF_Forwards				; if the speed is moving forwards, branch
		move.w	d0,ESS_FloorSpeed(a2)			; force directly to the speed
		bra.s	SSCF_NoChange				; skip speed increase...

SSCF_Forwards:
		addi.w	#SpeedInc,ESS_FloorSpeed(a2)		; increase floor speed forwards

SSCF_NoChange:
		move.b	ESS_Point(a2),d1			; load pointing direction
		btst.l	#$00,d1					; is the stage already rotating? (odd set)
		bne.w	SSCF_Rotate				; if so, branch (no controls can be pressed while rotating according to my observation of the original)
		tst.b	ESS_RotateHold(a2)			; are the rotation controls locked from being pressed?
		bne.s	SSCF_NoLeft				; if so, branch
		btst.b	#$03,(a3)				; was right pressed?
		beq.s	SSCF_NoRight				; if not, branch
		move.b	#$02,d1					; set to go right

SSCF_NoRight:
		btst.b	#$02,(a3)				; was left pressed?
		beq.s	SSCF_NoLeft				; if not, branch
		move.b	#$FE,d1					; set to go left

SSCF_NoLeft:
		move.b	d1,ESS_Point(a2)			; update pointing direction
		tst.b	ESS_HitBumper(a2)			; has the player already hit a bumper recently?
		bne.s	SSCF_NoControls				; if so, branch
		btst.b	#$00,(a3)				; was up pressed?
		beq.s	SSCF_NoControls				; if not, branch
		move.b	#$01,ESS_Move(a2)			; set to move forwards

SSCF_NoControls:
	sf.b	ESS_TurnFinish(a2)			; clear turning flag
		move.b	ESS_FloorPos(a2),d0			; load floor position
		andi.w	#$0007,d0				; get only within a squares' position
		bne.s	SSCF_NoRotate				; if the player is not in a rotation position, branch
		tst.b	d1					; is the player meant to be turning?
		beq.s	SSCF_NoReset				; if not, branch
	tst.b	ESS_JumpPos(a2)				; is the player in the air?
	bne.s	SSCF_NoReset				; if so, branch
		bset.l	#$00,d1					; lock left/right controls
		move.b	d1,ESS_Point(a2)			; update pointing direction
		andi.w	#%10000000,d1				; get only left/right direction
		lsl.w	#$04,d1					; align to quotient
		addi.w	#$1080,d1				; increment to the rotation slots for palette/info
		move.b	ESS_Direction(a2),d2			; load direction facing (since the direction flips the palette/floor)
		andi.b	#$02,d2					; get only the odd/even facing floors
		add.b	d2,d2					; align with floor positions odd/even facing floors
		add.b	d2,d2					; ''
		move.b	ESS_FloorPos(a2),d0			; load floor position
		eor.b	d2,d0					; reverse floor odd/even facing position
		andi.b	#$08,d0					; get only that odd/even position
		beq.s	SSCF_FlipCol				; if we're not on an odd floor position, branch
		addi.w	#$1000,d1				; advance to odd palette/H-scroll floor data

SSCF_FlipCol:
		move.w	d1,ESS_RotatePos(a2)			; set rotation position
		move.b	ESS_RotatePos(a2),d0			; load rotation position
		st.b	ESS_RotateHold(a2)			; set to hold rotation from being ran again via controls
		bra.s	SSCF_ApplyData				; continue to apply the data to the floor and render

		; --- Rotation ---

SSCF_Rotate:
		tst.b	ESS_Point(a2)				; is the stage rotating right?
		bpl.s	SSCF_BGLeft				; if so, branch
		addi.w	#$0010,ESS_HScroll+2(a2)		; scroll the BG right

SSCF_BGLeft:
		subq.w	#$08,ESS_HScroll+2(a2)			; scroll the BG left

SSCF_NoBGLR:

		addi.w	#$0080,ESS_RotatePos(a2)		; rotate position around
		move.b	ESS_RotatePos(a2),d0			; load rotation position
		move.w	ESS_RotatePos(a2),d1			; load full rotation position
		andi.w	#$0780,d1				; get only the rotation position
		bne.s	SSCF_ApplyData				; if we've not finished rotating, branch
	st.b	ESS_TurnFinish(a2)			; set turning as finished
		sf.b	ESS_Point(a2)				; clear pointing direction
		bra.s	SSCF_ContinueNormal			; continue normally

		; --- Normal movement ---

SSCF_NoRotate:
		sf.b	ESS_RotateHold(a2)			; allow controls to rotate again

SSCF_NoReset:
		moveq	#$00,d0					; clear d0
		tst.b	ESS_Move(a2)				; is the player moving?
		beq.s	SSCF_ContinueNormal			; if not, branch
		move.w	ESS_FloorSpeed(a2),d0			; load speed
		move.w	d0,d2					; keep a copy
		swap	d0					; multiply by x200
		asr.l	#$07,d0					; ''
		add.l	d0,ESS_VScroll(a2)			; add to V-scroll position for the stars in the background
		add.w	d2,ESS_FloorPos(a2)			; add to floor position (fraction only)

SSCF_ContinueNormal:
		move.b	ESS_FloorPos(a2),d0			; load new floor position
		andi.w	#$000F,d0				; keep within forwards/backwards flooring
		move.b	ESS_Direction(a2),d2			; load direction facing (since the direction flips the palette/floor)
		andi.b	#$02,d2					; get only the odd/even facing floors
		add.b	d2,d2					; align with floor positions odd/even facing floors
		add.b	d2,d2					; ''
		eor.b	d2,d0					; reverse floor odd/even facing position

SSCF_ApplyData:
		andi.w	#$003F,d0				; keep floor within table (00 - 2F)
		cmp.b	ESS_FrameEntry(a2),d0			; has the frame changed?
		bne.s	SSCF_ChangePos				; if so, branch
		rts						; return

		; Palette entries (each one multiplied by 20 as that's the size of a line...

SSCF_PalLoc:	dc.w	$00*$20, $01*$20, $02*$20, $03*$20, $04*$20, $05*$20, $06*$20, $07*$20
		dc.w	$08*$20, $09*$20, $0A*$20, $0B*$20, $0C*$20, $0D*$20, $0E*$20, $0F*$20
		dc.w	$10*$20, $11*$20, $12*$20, $13*$20, $14*$20, $15*$20, $16*$20, $17*$20
		dc.w	$10*$20, $19*$20, $1A*$20, $1B*$20, $1C*$20, $1D*$20, $1E*$20, $1F*$20
		dc.w	$18*$20, $1F*$20, $1E*$20, $1D*$20, $1C*$20, $1B*$20, $1A*$20, $19*$20
		dc.w	$18*$20, $17*$20, $16*$20, $15*$20, $14*$20, $13*$20, $12*$20, $11*$20

SSCF_ChangePos:
		move.b	d0,ESS_FrameEntry(a2)			; save frame ID for sprite rendering list to use
		add.w	d0,d0					; multiply by size of word
		move.w	SSCF_PalLoc(pc,d0.w),d0			; load correct palette table reference to use
		move.l	ESS_PalList(a2),a0			; load palette list address
		adda.w	d0,a0					; advance to correct frame palette list
		movem.l	(a0),d0-d7				; copy palette over
		movem.l	d0-d7,(a1)				; ''

		moveq	#$00,d0					; reload frame entry
		move.b	ESS_FrameEntry(a2),d0			; ''
		add.w	d0,d0					; multiply by long-word
		add.w	d0,d0					; ''
		lea	(SS_PositionH).l,a0			; load H-scroll positions for the floor to use
		adda.w	d0,a0					; advance to correct entry
		move.w	(a0)+,ESS_HScroll(a2)			; set plane to use
		move.b	(a0)+,d0				; rotate direction around if needed
		add.b	d0,ESS_Direction(a2)			; ''
		tst.b	ESS_Move(a2)				; is the player moving?
		beq.s	SSCF_NoLayout				; if not, branch
		move.b	(a0),d0					; load forwards/backwards inc/dec value
		beq.s	SSCF_NoLayout				; if it's 00, branch (no layout change yet)
		bmi.s	SSCF_Backwards				; if it's a backwards advance one, branch
		tst.w	ESS_FloorSpeed(a2)			; is the speed moving forwards?
		bge.s	SSCF_DoLayout				; if so, branch
		bra.s	SSCF_NoLayout				; continue

SSCF_Backwards:
		tst.w	ESS_FloorSpeed(a2)			; is the speed moving backwards?
		bpl.s	SSCF_NoLayout				; if not, branch

SSCF_DoLayout:
		move.b	ESS_Direction(a2),d1			; load direction to d1
		andi.w	#$0006,d1				; get only the direction
		lea	SSRF_Advance(pc,d1.w),a0		; load correct direction/entry
		move.b	(a0)+,d1				; load X or Y to manipulate
		tst.b	(a0)					; is the layout slot meant to be added to?
		bpl.s	SSRF_AddLayout				; if so, branch
		neg.b	d0					; reverse direction

SSRF_AddLayout:

	cmpi.l	#SSC_Roam,ESS_RoutCPU(a2)
	bne.s	SSRF_NoRemember
	move.w	ESS_LayoutYX(a2),d2
	move.b	ESS_Direction(a2),d3
	move.l	ESS_Layout(a2),a4
	lea	$40(a4),a4
	andi.w	#$0006,d3
	tas.b	d3
	move.b	d3,(a4,d2.w)

SSRF_NoRemember:

		add.b	(a2,d1.w),d0				; add layout position to advancement
		andi.b	#$1F,d0					; wrap
		move.b	d0,(a2,d1.w)				; update position

		st.b	ESS_Changed(a2)				; set layout position changed flag
		move.w	ESS_RingPos(a2),d0			; load collected ring layout position
		bmi.s	SSCF_NoLayout				; if there's no ring to erase, branch
		movea.l	ESS_Layout(a2),a0			; load layout address
		move.b	#$80,(a0,d0.w)				; erase ring from layout
		st.b	ESS_RingPos(a2)				; set no collected ring

SSCF_NoLayout:
		rts						; return

								; Don't confuse backwards/forwards with direction on the layout please...

SSRF_Advance:	dc.b	ESS_LayoutY,$FF				; moving Y backwards
		dc.b	ESS_LayoutX,$01				; moving X forwards
		dc.b	ESS_LayoutY,$01				; moving Y forwards
		dc.b	ESS_LayoutX,$FF				; moving X backwards
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to read and process what to do when touching spheres
; ---------------------------------------------------------------------------

SS_ReadSpheres:
		movea.l	ESS_Layout(a2),a1			; load layout address
		move.w	ESS_LayoutYX(a2),d1			; load Y position
		andi.w	#$1F1F,d1				; wrap it
		move.b	(a1,d1.w),d0				; load the sphere type at the layout entry
		move.b	d0,d4					; copy to d2
		andi.w	#$000F,d0				; get only the sphere number (and ring flag)
		bne.s	SSRS_Process				; if it's not blank, branch

SSRS_NoSphere:
		sf.b	ESS_HitBumper(a2)			; clear bumper hit flag
		rts						; return

SSRS_Process:
	tst.b	ESS_JumpPos(a2)
	bne.s	SSRS_ClearBumper
		cmpi.b	#$01,d0					; is it a star sphere?
		beq.s	SSRS_NoStar				; if so, branch

SSRS_ClearBumper:
		sf.b	ESS_HitBumper(a2)			; clear bumper hit flag

SSRS_NoStar:
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		jmp	SSRS_Spheres-$04(pc,d0.w)		; run correct routine

SSRS_Spheres:	bra.w	SSRS_StarSphere				; 01 - Star Sphere
		bra.w	SSRS_BlueSphere				; 02 - Blue Sphere (Uncollected Grey)
		bra.w	SSRS_BlueSphere				; 03 - Orange Sphere (Uncollected Grey)
		bra.w	SSRS_NoSphere				; 04 - ---Free---
		bra.w	SSRS_RedSphere				; 05 - Red Sphere
		bra.w	SSRS_RedSphere				; 06 - Blue Sphere (Collected)
		bra.w	SSRS_RedSphere				; 07 - Orange Sphere *Collected)

	; --- 08 - Rings ---

SSRS_Rings:
		bset.l	#$06,d4					; set ring as collected
		bne.s	SSRS_RNG_NoTouch			; if it was already collected, branch
	tst.b	ESS_JumpPos(a2)				; is the player in the air?
	bne.s	SSRS_RNG_NoErase			; if so, branch
		move.b	d4,(a1,d1.w)				; change ring to collected type
		move.b	#$10,ESS_RingTime(a2)			; set timer before ring collection stars should disappear (in-game player is rotating or whatever)

	; increment ring counter here...

		move.w	d1,ESS_RingPos(a2)			; save position of collected ring
		moveq	#$33,d0					; play ring SFX
		jmp	Play_Sound_2				; ''

SSRS_RNG_NoTouch:
		subq.b	#$01,ESS_RingTime(a2)			; decrease ring timer
		bpl.s	SSRS_RNG_NoErase			; if still counting, branch
		move.b	#$80,(a1,d1.w)				; clear the ring at the layout address

SSRS_RNG_NoErase:
		rts						; return

	; --- 00 - Red Sphere ---

SSRS_RedSphere:
	tst.b	ESS_JumpPos(a2)				; is the player in the air?
	bne.s	SSRS_RS_NoTouch				; if so, branch
		move.b	ESS_FloorPos(a2),d0			; load floor position
		andi.b	#$07,d0					; are we directly on the sphere?
		bne.s	SSRS_RS_NoTouch				; if not, branch
	tst.b	ESS_Move(a2)
	beq.s	SSRS_RS_NoTouch
	moveq	#$6A,d0
	jsr	Play_Sound_2
	sf.b	ESS_Move(a2)				; stop player moving (just temporary)

SSRS_RS_NoTouch:
		rts						; return

	; --- 01 - Star Sphere ---

SSRS_StarSphere:
	tst.b	ESS_JumpPos(a2)				; is the player in the air?
	bne.s	SSRS_SS_NoTouch				; if so, branch
		tst.b	ESS_HitBumper(a2)			; has the player already hit a bumper recently?
		bne.s	SSRS_SS_NoHit				; if so, branch

SSRS_SS_Hit:
		moveq	#$AA,d0					; play bumper hit SFX
		jsr	Play_Sound_2				; ''
		st.b	ESS_HitBumper(a2)			; set bumper as hit
		neg.b	ESS_Move(a2)				; set to move player in reverse now
		neg.w	ESS_FloorSpeed(a2)			; reverse speed
		move.b	ESS_FloorPos(a2),d0			; load position
		addq.b	#$01,d0					; check if the position is just touching the sphere (off by one infront or behind)
		andi.w	#$0007,d0				; ''
		cmpi.b	#$02,d0					; ''
		bhi.s	SSRS_SS_NoTouch				; if not, branch
		move.b	ESS_FloorSpeed(a2),d0			; load speed
		ext.w	d0					; convert to FF00 or 0100 depending on negative or positive respectively
		sf.b	d0					; ''
		add.w	d0,d0					; ''
		addi.w	#$0100,d0				; ''
		add.w	d0,ESS_FloorPos(a2)			; add speed to position (just nudge it forwards or backwards)
		rts						; return

SSRS_SS_NoHit:
		tst.b	ESS_Point(a2)				; is the stage rotating?
		bne.s	SSRS_SS_NoTouch				; if so, branch
		move.b	ESS_FloorPos(a2),d0			; load floor position
		andi.b	#$07,d0					; ''
		beq.s	SSRS_SS_Hit				; set to hit the bumper

SSRS_SS_NoTouch:
		rts						; return

	; --- 02 - Blue Sphere ---

SSRS_BlueSphere:
		moveq	#$45,d3					; prepare red sphere
		tst.b	(ESS_StageMode).w			; is this the normal mode or get most?
		ble.s	SSRS_BS_CollectNormal			; if so, branch
		moveq	#$02,d3					; prepare blue sphere uncollected
		add.b	ESS_PlayerID(a2),d3			; add player ID to get orange if necessary
		move.b	d4,d0					; load current sphere in locaiton
		andi.b	#$1F,d0					; get only ID
		cmp.b	d3,d0					; is the sphere the same type as the player's collecting sphere?
		bne.s	SSRS_BS_NoMost				; if not, branch to allow it to be collected
		rts						; return (if the player already owns the sphere, then just walk over it)

SSRS_BS_CollectNormal:
		bmi.s	SSRS_BS_NoMost				; if the mode is normal mode, branch
		moveq	#$46,d3					; prepare blue sphere collected
		add.b	ESS_PlayerID(a2),d3			; add player ID to get orange if necessary

SSRS_BS_NoMost:
		add.b	d4,d4					; is the blue sphere set as collected?
		bmi.s	SSRS_BS_Touched				; if so, branch
	tst.b	ESS_JumpPos(a2)				; is the player in the air?
	bne.s	SSRS_BS_NoChange			; if so, branch
		ori.b	#$40,(a1,d1.w)				; set the sphere as collected
		tst.b	(ESS_StageMode).w			; is this get opponents' spheres mode?
		bgt.s	SSRS_BS_NoRings				; if so, ignore ring searching
		jsr	SP_CheckRings				; check if a ring of reds have been connected
		bne.s	SSRS_BS_NoChange			; if so, branch

SSRS_BS_NoRings:
		moveq	#$65,d0					; play sphere collect SFX
		jsr	Play_Sound_2				; ''

SSRS_BS_Touched:
		move.w	ESS_FloorPos(a2),d0			; load floor position
		andi.w	#$0700,d0				; get only within a squares' position
		lsr.w	#$03,d0					; align with MSB of byte
		ext.w	d0					; extend sign
		asr.b	#$05,d0					; align correctly
		tst.w	ESS_FloorSpeed(a2)			; is the player moving forwards?
		bmi.s	SSRS_BS_Backwards			; if not, branch
		tst.b	d0					; is the player a step passed the sphere?
		ble.s	SSRS_BS_NoChange			; if not, the player has not passed yet, so branch

SSRS_BS_Change:
		move.b	d3,(a1,d1.w)				; change sphere to red (or collected sphere)
		rts						; return

SSRS_BS_Backwards:
		tst.b	d0					; is the player a step behind the sphere?
		bmi.s	SSRS_BS_Change				; if so, the player has passed, so branch

SSRS_BS_NoChange:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to look for a ring of red spheres to turn into rings
; ---------------------------------------------------------------------------
SP_U	=	-$0100
SP_R	=	+$01
SP_D	=	+$0100
SP_L	=	((+$20-$01)|$8000)	; Doing it with +20 will stop the carry from reducing the Y...
; ---------------------------------------------------------------------------

SP_CheckRings:
		movem.l	d0-a4,-(sp)				; store register data

	; At least two red spheres have to exist on the X or Y axis in order
	; for a loop to possibly be completed, so this check will eliminate
	; unnecessary checks

		move.w	#$1F1F,d6				; prepare wrap value
		move.w	d1,d4					; copy layout address to d4
		moveq	#$80,d3					; prepare -2's worth
		moveq	#$40,d2					; prepare collectable AND bit
		move.w	d4,d5					; copy address
		add.w	#SP_L,d5				; move left
		and.w	d6,d5					; keep within layout
		move.b	(a1,d5.w),d0				; load sphere
		and.w	d2,d0					; get only collectable bit
		add.w	d0,d3					; add to counter
		move.w	d4,d5					; copy address
		add.w	#SP_R,d5				; move right
		and.w	d6,d5					; keep within layout
		move.b	(a1,d5.w),d0				; load sphere
		and.w	d2,d0					; get only collectable bit
		add.w	d0,d3					; add to counter
		move.w	d4,d5					; copy address
		add.w	#SP_U,d5				; move up
		and.w	d6,d5					; keep within layout
		move.b	(a1,d5.w),d0				; load sphere
		and.w	d2,d0					; get only collectable bit
		add.w	d0,d3					; add to counter
		move.w	d4,d5					; copy address
		add.w	#SP_D,d5				; move down
		and.w	d6,d5					; keep within layout
		move.b	(a1,d5.w),d0				; load sphere
		and.w	d2,d0					; get only collectable bit
		add.w	d0,d3					; add to counter
		bmi.s	SPCR_NoRings				; if there's less than two red spheres, branch

	; --- Now to check for the actual loop ---

		lea	(ESS_LoopRecord).l,a2			; load ring loop record
		lea	SP_Directions+$00(pc),a0		; load directions list starting from up
		bsr.w	SPCR_FindLoop				; find the loop
		lea	SP_Directions+$02(pc),a0		; load directions list starting from right
		bsr.w	SPCR_FindLoop				; find the loop
		lea	SP_Directions+$04(pc),a0		; load directions list starting from down
		bsr.w	SPCR_FindLoop				; find the loop
		lea	SP_Directions+$06(pc),a0		; load directions list starting from left
		bsr.w	SPCR_FindLoop				; find the loop
		move.w	a2,d7					; load end address
		lea	(ESS_LoopRecord).l,a2			; reload start of loop record
		sub.w	a2,d7					; get size
		bne.w	SPCR_MarkRings				; if a loop was found this list should not be empty, so branch

SPCR_NoRings:
		movem.l	(sp)+,d0-a4				; restore register data
		ori.b	#%00100,ccr				; set zero flag (no loop found)
		rts						; return

; ---------------------------------------------------------------------------
; Direction list array (in order of rotation and filled to a byte's worth)
; ---------------------------------------------------------------------------

		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
SP_Directions:	dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L
		dc.w	SP_U,  SP_R,  SP_D,  SP_L,  SP_U,  SP_R,  SP_D,  SP_L

; ---------------------------------------------------------------------------
; The main searching algorithm
; ---------------------------------------------------------------------------

SPCR_FindLoop:
		pea	(a2)					; save loop record
		move.w	d1,d4					; load layout address
		sf.b	d5					; reset blue sphere flag
		move.l	(a0),d0					; load layout direction
		move.w	#$8000,d7				; prepare MSB setting
		move.w	d0,d2					; load next-to sphere location
		add.w	d4,d2					; ''
		and.w	d6,d2					; keep within layout
		move.b	(a1,d2.w),d3				; load sphere
		bmi.s	SPCR_Return				; if it's uncollectable/blank, branch
		add.b	d3,d3					; is the sphere red?
		bpl.s	SPCR_Return				; if not, branch
		move.w	$04(a0),d2				; load 180-degrees location
		add.w	d4,d2					; ''
		and.w	d6,d2					; keep within layout
		move.b	(a1,d2.w),d3				; load sphere
		bmi.s	SPCR_Return				; if it's uncollectable/blank, branch
		add.b	d3,d3					; is the sphere red?
		bmi.s	SPCR_CheckSphere			; if so, branch
		or.w	d7,d2					; mark as blue sphere
		move.w	d2,(a2)+				; save sphere location
		move.w	$06(a0),d2				; load 270 degrees location
		add.w	d4,d2					; ''
		and.w	d6,d2					; keep within layout
		move.b	(a1,d2.w),d3				; load sphere
		bmi.s	SPCR_Return				; if it's uncollectable/blank, branch
		add.b	d3,d3					; is the sphere red?
		bmi.s	SPCR_CheckSphere			; if so, branch
		or.w	d7,d2					; mark as blue sphere
		move.w	d2,(a2)+				; save sphere location
		bra.s	SPCR_CheckSphere			; jump into loop (everything accounted for)

SPCR_Return:
		move.l	(sp)+,a2				; restore loop record
		rts						; return

	; --- The main loop search itself ---

SPCR_RedSphere:
		cmp.w	d1,d4					; have we looped around?
		beq.s	SPCR_FoundLoop				; if so, branch
		move.w	d4,(a2)+				; save red entry

SPCR_NextSphere:
		swap	d0					; get next-to sphere

SPCR_CheckSphere:
		move.w	d0,d2					; load sphere address next-to current
		add.w	d4,d2					; ''
		and.w	d6,d2					; keep within layout
		move.b	(a1,d2.w),d3				; load sphere
		bmi.s	SPCR_Return				; if it's uncollectable, branch
		add.b	d3,d3					; is it a collected sphere?
		bpl.s	SPCR_BlueSphere				; if not, branch
		move.w	d2,(a2)+				; save red sphere
		addq.w	#$02,a0					; rotate to next direction
		move.l	(a0),d0					; load layout direction
		add.w	(a0),d4					; advance layout
		and.w	d6,d4					; keep within layout
		cmp.w	d1,d4					; have we looped around?
		bne.s	SPCR_CheckSphere			; if not, branch
		bra.s	SPCR_FoundLoop				; continue

SPCR_BlueSphere:
		or.w	d7,d2					; set MSB to indicate it's a blue sphere on the inside of the loop
		move.w	d2,(a2)+				; save blue entry
		st.b	d5					; set blue sphere as found
		swap	d0					; get current sphere
		move.w	d4,d2					; store layout in-case it needs reverting
		add.w	d0,d4					; move layout towards direction
		and.w	d6,d4					; keep within layout
		cmp.w	d1,d4					; have we looped around?
		beq.s	SPCR_FoundLoop				; if so, branch
		move.b	(a1,d4.w),d3				; load sphere
		bmi.s	SPCR_Return				; if it's uncollectable, branch
		add.b	d3,d3					; is it a collected sphere?
		bmi.s	SPCR_RedSphere				; if so, branch
		move.w	d2,d4					; revert layout (sub.w  d0,d4 won't work since the change of -1 to +1F was installed)
		subq.w	#$02,a0					; rotate to previous direction
		move.l	(a0),d0					; load layout direction
		st.b	d5					; set blue sphere as found
		bra.s	SPCR_CheckSphere			; check next sphere

SPCR_FoundLoop:
		tst.b	d5					; were any blues found within the loop?
		beq.s	SPCR_Return				; if not, branch
		move.w	d4,(a2)+				; save last red entry (the current sphere the player is on)
		addq.w	#$04,sp					; restore stack
		rts						; return

; ---------------------------------------------------------------------------
; Turning the loop into rings (Marking/Finding/etc)
; ---------------------------------------------------------------------------

SPCR_MarkRings:
		moveq	#$B9,d0					; play ring creation SFX
		jsr	Play_Sound_2				; ''
		lea	(ESS_Layout_Ring).l,a3			; load ring layout
		move.w	d7,d2					; load count
		lsr.w	#$01+$04,d7				; divide by 2 (for word) and 10 (for unrolled loop)
		moveq	#$0F,d0					; prepare bit clear position
		andi.l	#$0000001E,d2				; get only the jump position (x2)
		beq.s	SPMR_MarkStart				; if it's 0, just go strait to first entry
		add.w	d2,d2					; multiply by size of section
		add.w	d2,d2					; ''
		neg.w	d2					; reverse...
		lea	SPMR_MarkList(pc),a0			; load unrolled loop end address
		jmp	(a0,d2.w)				; jump to correct starting position

SPMR_MarkStart:
		subq.w	#$01,d7					; decrease dbf by 1

SPMR_MarkNext:
	rept	$10
		move.w	(a2)+,d4				; load entry
		bclr.l	d0,d4					; clear the MSB
		smi.b	(a3,d4.w)				; set the entry to red/blue depending on MSB
	endm
SPMR_MarkList:
		dbf	d7,SPMR_MarkNext			; repeat for all 10 markers that exist

	; --- Creating the actual rings in the layout now ---

		moveq	#$7F,d7					; prepare "reset" value for ring marker loop
		move.w	d1,d4					; reload layout address
		moveq	#$88,d0					; prepare ring ID
		moveq	#$20-1,d3				; prepare number of columns

	; --- The outter no loop area ---

SPCR_NextY_No:
		moveq	#$20-1,d5				; prepare number of rows

SPCR_NextX_No:
		and.w	d6,d4					; wrap address
		tst.b	(a3,d4.w)				; check sphere
		ble.s	SPCR_Set_Mid				; if it's not blank, branch

SPCR_Set_No:
		addq.b	#$01,d4					; move right
		dbf	d5,SPCR_NextX_No			; repeat for all rows
		addi.w	#$0100,d4				; move down
		dbf	d3,SPCR_NextY_No			; repeat fro all columns
		movem.l	(sp)+,d0-a4				; restore register data
		andi.b	#%11011,ccr				; clear zero flag (found loop)
		rts						; return

	; --- In the middle between the red/blue area ---

SPCR_NextY_Mid:
		moveq	#$20-1,d5				; prepare number of rows

SPCR_NextX_Mid:
		and.w	d6,d4					; wrap address
		tst.b	(a3,d4.w)				; check sphere
		bgt.s	SPCR_Set_No				; if there is no sphere, branch
		bmi.s	SPCR_Set_Yes				; if it's a blue inner sphere, branch

SPCR_Set_Mid:
		move.b	d7,(a3,d4.w)				; reset ring marker layout
		move.b	d0,(a1,d4.w)				; change sphere to ring

SPCR_NoSphere_Mid:
		addq.b	#$01,d4					; move right
		dbf	d5,SPCR_NextX_Mid			; repeat for all rows
		addi.w	#$0100,d4				; move down
		dbf	d3,SPCR_NextY_Mid			; repeat fro all columns
		movem.l	(sp)+,d0-a4				; restore register data
		andi.b	#%11011,ccr				; clear zero flag (found loop)
		rts						; return

	; --- The inner yes loop area ---

SPCR_NextY_Yes:
		moveq	#$20-1,d5				; prepare number of rows

SPCR_NextX_Yes:
		and.w	d6,d4					; wrap address
		tst.b	(a3,d4.w)				; check sphere
		beq.s	SPCR_Set_Mid				; if there is a red sphere, branch

SPCR_Set_Yes:
		tst.b	(a1,d4.w)				; is the sphere uncollectable? (i.e. is it a star bumper or blank space?
		bmi.s	SPCR_NoSphere_Yes			; if so, branch (don't change this to a ring)
		move.b	d0,(a1,d4.w)				; change sphere to ring

SPCR_NoSphere_Yes:
		move.b	d7,(a3,d4.w)				; reset ring marker layout
		addq.b	#$01,d4					; move right
		dbf	d5,SPCR_NextX_Yes			; repeat for all rows
		addi.w	#$0100,d4				; move down
		dbf	d3,SPCR_NextY_Yes			; repeat fro all columns
		movem.l	(sp)+,d0-a4				; restore register data
		andi.b	#%11011,ccr				; clear zero flag (found loop)

SSC_Return:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; CPU Player
; ---------------------------------------------------------------------------
; SS_CPU:

		include	"Special Stage\Source - CPU.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank - Special Stage
; ---------------------------------------------------------------------------

VB_SpecialStage:
		movem.l	d0-a3,-(sp)				; store register data
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as write only

		tst.b	(V_int_routine).w			; is the 68k on time?
		beq.w	VBSS_Late68k				; if not, branch
		sf.b	(V_int_routine).w			; set V-blank as ran
		jsr	Poll_Controllers			; read controls (stupid name "poll", I should find the morron who decided that, and kick him in the gonads...)

	;	DMA	$0280, $7C000002, ESS_SpritesP1		; transfer player 1's sprites

	bsr.w	VBSS_WriteDebug


	clr.w	(Normal_palette+$40).w

		lea	(Normal_palette).w,a0			; load main and current palette
		lea	(Target_palette).w,a1			; '' (doing current palette too allows fading while transactions occur)
		move.w	(a0),$7C(a0)				; copy player 1's transparent floor colour to the real floor backdrop art
		move.w	(a1),$7C(a1)				; ''
		move.w	$20(a0),$7E(a0)				; copy player 2's transparent floor colour to the real floor backdrop art
		move.w	$20(a1),$7E(a1)				; ''

	DMA	$280, $75000002, ESS_P1_ScaleArt
	DMA	$280, $77800002, ESS_P2_ScaleArt


		subq.b	#$01,(ESS_RingDelay).w			; decrease delay timer
		bpl.s	VBSS_NoFrame				; if still counting, branch
		move.b	#$08-1,(ESS_RingDelay).w		; reset delay timer
		subi.w	#$0020,(ESS_RingFrame).w		; decrease ring timer
		bgt.s	VBSS_NoFrame				; if not finished, branch
		move.w	#$0020*3,(ESS_RingFrame).w		; reset timer

VBSS_NoFrame:
	bra.s	VBSS_NoLag

VBSS_Late68k:
	addq.w	#$01,(ESS_LagCount).w
	move.w	(ESS_LagCount).w,(ESS_Debug00).w

VBSS_NoLag:
		DMA	$0280, $7C000002, ESS_SpritesP1		; transfer player 1's sprites
		DMA	$0080, $C0000000, Normal_palette	; palette (last thing)
		moveq	#-1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as execute tracker

		lea	(ESS_PalBG_P2).w,a0			; load background palette
		lea	(ESS_PalBG_H2).w,a1			; load H-blank palette
		move.l	(a0)+,(a1)+				; copy palette for H-blank
		move.w	(a0)+,(a1)+				; ''

	; --- Setting up VDP for H-blank ---

		move.l	#$40000003,(a6)				; set VDP to VRAM H-scroll write address
		move.l	(ESS_P1_Floor+ESS_HScroll).w,d0		; load H-scroll position
		move.l	d0,(a5)					; save to H-scroll in VRAM

		move.l	#$40020010,(a6)				; set VDP to VSRAM write address
		move.w	(ESS_P1_Floor+ESS_VScroll).w,d0		; load BG Y position
		andi.w	#$007F,d0				; keep within the sky's art
		move.w	d0,(a5)					; save to VSRAM

		; storing player 2's data for H-blank during display
		; so the main code doesn't change the data mid-screen
		; while rendering

		move.l	(ESS_P2_Floor+ESS_HScroll).w,d0		; load H-scroll position
		move.l	d0,(ESS_H2_HScroll).w			; save for H-scroll later during H-blank

		move.w	(ESS_P2_Floor+ESS_VScroll).w,d0		; load BG Y position
		andi.w	#$007F,d0				; keep within sky's art
		subi.w	#224/2,d0				; adjust for player 2's position in H-blank on-screen vertically
		move.w	d0,(ESS_H2_VScroll).w			; ''

		; prepare sprite transfer DMA data information

		lea	HB_SpriteP2A(pc),a4			; load buffer A DMA list
		not.b	(ESS_H2_Buffer).w			; change buffer
		bne.s	VBSS_ReadBufferA			; if we're gonna write to buffer B, branch
		lea	HB_SpriteP2B(pc),a4			; load buffer B DMA list

VBSS_ReadBufferA:
		move.l	a4,usp					; store buffer address for H-blank

		; Now setting final H-blank

		move.w	#$8A00|(($20-1)/2),(a6)			; set next interrupt to V-scroll slice section
		move.l	#HB_SpecialStage,(H_int_addr).w		; set H-blank routine

		movem.l	(sp)+,d0-a3				; restore register data
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; H-blank - Special Stage
; ---------------------------------------------------------------------------

HB_SpriteP2A:	dc.l	((((($0280/$02)<<$08)&$FF0000)+(($0280/$02)&$FF))+$94009300)
		dc.l	((((((ESS_SpritesP2A&$FFFFFF)/$02)<<$08)&$FF0000)+(((ESS_SpritesP2A&$FFFFFF)/$02)&$FF))+$96009500)
		dc.w	(((((ESS_SpritesP2A&$FFFFFF)/$02)&$7F0000)>>$10)+$9700)
		dc.l	$7C000082
HB_SpriteP2B:	dc.l	((((($0280/$02)<<$08)&$FF0000)+(($0280/$02)&$FF))+$94009300)
		dc.l	((((((ESS_SpritesP2B&$FFFFFF)/$02)<<$08)&$FF0000)+(((ESS_SpritesP2B&$FFFFFF)/$02)&$FF))+$96009500)
		dc.w	(((((ESS_SpritesP2B&$FFFFFF)/$02)&$7F0000)>>$10)+$9700)
		dc.l	$7C000082

HB_SpecialStage:
		move.w	#$8A00|($50-1),(a6)			; set next interrupt occurance
		move.l	#HB_P1_Floor,(H_int_addr).w		; set H-blank routine
		rte						; return

HB_P1_Floor:
		move.l	#$40020003,(a6)				; set VDP to VRAM write (BG H-scroll)
		move.w	#$0000,(a5)				; force BG to player 1's floor
		move.l	#$40020010,(a6)				; set VDP to VSRAM write mode (BG only)
		move.w	#$00B0-$20,(a5)				; set BG to dislay floor area
		move.w	#$8A00|($20-1),(a6)			; set next interrupt occurance
		move.l	#HB_P2_Swap,(H_int_addr).w		; set H-blank routine
		rte						; return

HB_P2_Swap:
		move.w	#$8A00|$DF,(a6)				; set next interrupt occurance
		move.l	#HB_P2_Floor,(H_int_addr).w		; set H-blank routine
		move.w	#$8100|%00110100,(a6)			; disable display
		move.l	#$40020010,(a6)				; set VDP to VSRAM write mode
		move.w	(ESS_H2_VScroll).w,(a5)			; write player 2's VSRAM positions
		move.l	#$40000003,(a6)				; set VDP to VRAM H-scroll area
		move.l	(ESS_H2_HScroll).w,(a5)			; write player 2's H-scroll positions

		movem.l	d0-d1/a4,-(sp)				; store registers
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as write only

		move.l	usp,a4					; load DMA data
		move.l	(a4)+,(a6)				; set DMA size
		move.l	(a4)+,(a6)				; set DMA source
		move.l	(a4)+,(a6)				; set DMA source and destination
		move.w	(a4)+,(a6)				; set DMA destination
		moveq	#1,d0
		jsr	Set_PCM_Status.w			; NAT: Set PCM status as read & write

		move.l	#$C05A0000,(a6)				; load player 2's BG colours
		move.l	(ESS_PalBG_H2).w,(a5)			; ''
		move.w	(ESS_PalBG_H2+4).w,(a5)			; ''
		moveq	#%00000100,d1				; prepare H-blank bit checking

HB_P2_WaitLine:
		move.w	(a6),d0					; load status register
		and.w	d1,d0					; is the VDP in H-blank mode?
		beq.s	HB_P2_WaitLine				; if not, branch
		move.w	#$8100|%01110100,(a6)			; enable display again
		movem.l	(sp)+,d0-d1/a4				; store registers
		rte						; return

HB_P2_Floor:
		move.l	#$40020003,(a6)				; set VDP to VRAM write (BG H-scroll)
		move.w	#$0200,(a5)				; force BG to player 2's floor
		move.l	#$40020010,(a6)				; set VDP to VSRAM write mode (BG only)
		move.w	#$00B0-($20+(224/2)),(a5)		; set BG to dislay floor area
		move.l	#NullRTE,(H_int_addr).w			; set to null return address (just in-case)
		rte						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write debug numbers to the screen
; ---------------------------------------------------------------------------

VBSS_WriteDebug:
		move.w	#$E000|($BA00/$20),d4
		move.l	#$44000003,(a6)
		bsr.s	VBSS_WD_Write
		move.l	#$44500003,(a6)
		bsr.s	VBSS_WD_Write
		move.l	#$44A00003,(a6)

VBSS_WD_Write:
		lea	(ESS_Debug00).w,a0
		moveq	#$08-1,d2
		moveq	#$0F,d3

VBSS_WD_NextWord:
		move.w	(a0)+,d1
		rol.w	#$04,d1
		move.w	d1,d0
		and.w	d3,d0
		add.w	d4,d0
		move.w	d0,(a5)
		rol.w	#$04,d1
		move.w	d1,d0
		and.w	d3,d0
		add.w	d4,d0
		move.w	d0,(a5)
		rol.w	#$04,d1
		move.w	d1,d0
		and.w	d3,d0
		add.w	d4,d0
		move.w	d0,(a5)
		rol.w	#$04,d1
		move.w	d1,d0
		and.w	d3,d0
		add.w	d4,d0
		move.w	d0,(a5)
		move.w	#$8000,(a5)
		dbf	d2,VBSS_WD_NextWord
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to map a square of mappings to a plane
; ---------------------------------------------------------------------------

SP_MapScreen:
		move.l	#$01000000,d5				; row increment value

SP_NextY:
		move.l	d0,(a6)					; set VDP address
		add.l	d5,d0					; advance to next line
		move.w	d1,d4					; get X

SP_NextX:
		move.w	(a1)+,d6				; load mappings to d6
		eor.w	d3,d6					; adjust tile flip/mirror
		move.w	d6,(a5)					; write mappings to VRAM plane
		dbf	d4,SP_NextX				; repeat for all columns
		dbf	d2,SP_NextY				; repeat for all rows
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to mirror a section of mappings
; ---------------------------------------------------------------------------

SP_MirrorMap:
		move.w	d1,d4					; load X count
		addq.w	#$01,d4					; remove dbf count
		add.w	d4,d4					; multiply by size of word

SMM_NextY:
		lea	(a1),a2					; load left side
		adda.w	d4,a1					; advance to next line
		lea	(a1),a0					; load right side
		move.w	d1,d3					; load X count to d3
		lsr.w	#$01,d3					; divide by 2

SMM_NextX:
		move.w	-(a0),d0				; load end tile
		move.w	(a2),(a0)				; copy beginning to end
		move.w	d0,(a2)+				; save end to beginning
		dbf	d3,SMM_NextX				; repeat for all tiles in the row
		dbf	d2,SMM_NextY				; repeat for all columns
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup the special stage colour sequence
; ---------------------------------------------------------------------------

SP_SetupColours:
		lea	SPPC_List(pc),a0			; load palette list
		move.w	#((SPPC_ListEnd-SPPC_List)/2)-1,d4	; set number of frames to generate

SPPC_NextFrame:
		move.w	(a0)+,d2				; load entry
		moveq	#$10-1,d3				; set number of colours (10... duh)

SPPC_NextColour:
		move.l	d0,d1					; colour colours to d1
		add.w	d2,d2					; get colour bit
		bcs.s	SPPC_Colour2				; if set, use colour 2
		swap	d1					; set to use first colour instead

SPPC_Colour2:
		move.w	d1,(a1)+				; dump colour
		dbf	d3,SPPC_NextColour			; repeat for all colours in a line
		dbf	d4,SPPC_NextFrame			; repeat for all entries in the list
		rts						; return

SPPC_List:
		dc.w	%0000000011111111
		dc.w	%1000000001111111
		dc.w	%1100000000111111
		dc.w	%1110000000011111
		dc.w	%1111000000001111
		dc.w	%1111100000000111
		dc.w	%1111110000000011
		dc.w	%1111111000000001

		dc.w	%1111111100000000
		dc.w	%0111111110000000
		dc.w	%0011111111000000
		dc.w	%0001111111100000
		dc.w	%0000111111110000
		dc.w	%0000011111111000
		dc.w	%0000001111111100
		dc.w	%0000000111111110

		dc.w	%0000000011111111
		dc.w	%1010101010101010
		dc.w	%1100110011001100
		dc.w	%1111000011110000
		dc.w	%1111111100000000
		dc.w	%1111000011110000
		dc.w	%1100110011001100
		dc.w	%1010101010101010

		dc.w	%1111111100000000
		dc.w	%0101010101010101
		dc.w	%0011001100110011
		dc.w	%0000111100001111
		dc.w	%0000000011111111
		dc.w	%0000111100001111
		dc.w	%0011001100110011
		dc.w	%0101010101010101
SPPC_ListEnd:

; ===========================================================================
; ---------------------------------------------------------------------------
; Screen H position depending on frame
; ---------------------------------------------------------------------------

		;   H-Scroll,  Direction/Layout Inc+Dec

SS_PositionH:	dc.w	-(320*1),$0000
		dc.w	-(320*1),$0000
		dc.w	-(320*1),$0000
		dc.w	-(320*1),$00FF
		dc.w	-(320*1),$0001
		dc.w	-(320*1),$0000
		dc.w	-(320*1),$0000
		dc.w	-(320*1),$0000

		dc.w	-(320*1),$0000
		dc.w	-(320*1),$0000
		dc.w	-(320*1),$0000
		dc.w	-(320*1),$00FF
		dc.w	-(320*1),$0001
		dc.w	-(320*1),$0000
		dc.w	-(320*1),$0000
		dc.w	-(320*1),$0000

		dc.w	-(320*1),$0000
		dc.w	-(320*2),$0000
		dc.w	-(320*2),$0000
		dc.w	-(320*2),$0000
		dc.w	-(320*0),$0200
		dc.w	-(320*0),$0000
		dc.w	-(320*0),$0000
		dc.w	-(320*0),$0000

		dc.w	-(320*1),$0000
		dc.w	-(320*0),$0000
		dc.w	-(320*0),$0000
		dc.w	-(320*0),$0000
		dc.w	-(320*0),$0000
		dc.w	-(320*2),$FE00
		dc.w	-(320*2),$0000
		dc.w	-(320*2),$0000

		dc.w	-(320*1),$0000
		dc.w	-(320*2),$0000
		dc.w	-(320*2),$0000
		dc.w	-(320*2),$0000
		dc.w	-(320*0),$0200
		dc.w	-(320*0),$0000
		dc.w	-(320*0),$0000
		dc.w	-(320*0),$0000

		dc.w	-(320*1),$0000
		dc.w	-(320*0),$0000
		dc.w	-(320*0),$0000
		dc.w	-(320*0),$0000
		dc.w	-(320*0),$0000
		dc.w	-(320*2),$FE00
		dc.w	-(320*2),$0000
		dc.w	-(320*2),$0000

; ===========================================================================
; ---------------------------------------------------------------------------
; Sphere/ring rendering positions list
; ---------------------------------------------------------------------------

SS_RenderList:	dc.l	SSRL_Normal00
		dc.l	SSRL_Normal01
		dc.l	SSRL_Normal02
		dc.l	SSRL_Normal03
		dc.l	SSRL_Normal04
		dc.l	SSRL_Normal05
		dc.l	SSRL_Normal06
		dc.l	SSRL_Normal07
		dc.l	SSRL_Normal00
		dc.l	SSRL_Normal01
		dc.l	SSRL_Normal02
		dc.l	SSRL_Normal03
		dc.l	SSRL_Normal04
		dc.l	SSRL_Normal05
		dc.l	SSRL_Normal06
		dc.l	SSRL_Normal07

		dc.l	SSRL_Normal00
		dc.l	SSRL_Rotate00
		dc.l	SSRL_Rotate01
		dc.l	SSRL_Rotate02
		dc.l	SSRL_Rotate03
		dc.l	SSRL_Rotate04
		dc.l	SSRL_Rotate05
		dc.l	SSRL_Rotate06

		dc.l	SSRL_Normal00
		dc.l	SSRL_Rotate06
		dc.l	SSRL_Rotate05
		dc.l	SSRL_Rotate04
		dc.l	SSRL_Rotate03
		dc.l	SSRL_Rotate02
		dc.l	SSRL_Rotate01
		dc.l	SSRL_Rotate00

		dc.l	SSRL_Normal00
		dc.l	SSRL_Rotate00
		dc.l	SSRL_Rotate01
		dc.l	SSRL_Rotate02
		dc.l	SSRL_Rotate03
		dc.l	SSRL_Rotate04
		dc.l	SSRL_Rotate05
		dc.l	SSRL_Rotate06

		dc.l	SSRL_Normal00
		dc.l	SSRL_Rotate06
		dc.l	SSRL_Rotate05
		dc.l	SSRL_Rotate04
		dc.l	SSRL_Rotate03
		dc.l	SSRL_Rotate02
		dc.l	SSRL_Rotate01
		dc.l	SSRL_Rotate00


SSRL_Normal00:	dc.w	SSRLN00_A-SSRL_Normal00
		dc.w	SSRLN00_B-SSRL_Normal00
		dc.w	SSRLN00_C-SSRL_Normal00
		dc.w	SSRLN00_D-SSRL_Normal00

	;	dc.w	sprite count

		dc.w	$002A				; sprite count

	;	dc.w	Y pos, frame, X pos

		dc.w	$004A,$0000,$00A9
		dc.w	$0049,$0000,$0110
		dc.w	$004A,$0000,$0176

		dc.w	$002E,$0006,$0075
		dc.w	$002A,$0006,$00C0
		dc.w	$0029,$0006,$0110
		dc.w	$002A,$0006,$015F
		dc.w	$002E,$0006,$01AA

		dc.w	$001E,$0008,$0097
		dc.w	$001A,$0008,$00D4
		dc.w	$0019,$0008,$0114
		dc.w	$001A,$0008,$0153
		dc.w	$001E,$0008,$0190

		dc.w	$001B,$0010,$0080
		dc.w	$0013,$000E,$00AC
		dc.w	$0010,$000E,$00DF
		dc.w	$000F,$000E,$0114
		dc.w	$0010,$000E,$0148
		dc.w	$0013,$000E,$017B
		dc.w	$001B,$0010,$01AF

		dc.w	$0016,$0014,$0096
		dc.w	$0011,$0014,$00BF
		dc.w	$000E,$0014,$00EB
		dc.w	$000D,$0014,$0118
		dc.w	$000E,$0014,$0144
		dc.w	$0011,$0014,$0170
		dc.w	$0016,$0014,$0199

		dc.w	$0019,$0016,$0086
		dc.w	$0013,$0016,$00A7
		dc.w	$000E,$0016,$00CB
		dc.w	$000C,$0016,$00F1
		dc.w	$000C,$0016,$0118
		dc.w	$000C,$0016,$013E
		dc.w	$000E,$0016,$0164
		dc.w	$0013,$0016,$0188
		dc.w	$0019,$0016,$01A9

		dc.w	$0012,$0018,$00B9
		dc.w	$000E,$0018,$00D9
		dc.w	$000C,$0018,$00FA
		dc.w	$000C,$0018,$011C
		dc.w	$000C,$0018,$013D
		dc.w	$000F,$0018,$015E
		dc.w	$0012,$0018,$017E

		; Layout relative reference positions ($YYXX)

SSRLN00_A:	dc.w	                     $00FF, $0000, $0001
		dc.w	              $FFFE, $FFFF, $FF00, $FF01, $FF02
		dc.w	              $FEFE, $FEFF, $FE00, $FE01, $FE02
		dc.w	       $FDFD, $FDFE, $FDFF, $FD00, $FD01, $FD02, $FD03
		dc.w	       $FCFD, $FCFE, $FCFF, $FC00, $FC01, $FC02, $FC03
		dc.w	$FBFC, $FBFD, $FBFE, $FBFF, $FB00, $FB01, $FB02, $FB03, $FB04
		dc.w	       $FAFD, $FAFE, $FAFF, $FA00, $FA01, $FA02, $FA03

SSRLN00_B:	dc.w	                     $FF00, $0000, $0100
		dc.w	              $FE01, $FF01, $0001, $0101, $0201
		dc.w	              $FE02, $FF02, $0002, $0102, $0202
		dc.w	       $FD03, $FE03, $FF03, $0003, $0103, $0203, $0303
		dc.w	       $FD04, $FE04, $FF04, $0004, $0104, $0204, $0304
		dc.w	$FC05, $FD05, $FE05, $FF05, $0005, $0105, $0205, $0305, $0405
		dc.w	       $FD06, $FE06, $FF06, $0006, $0106, $0206, $0306

SSRLN00_C:	dc.w	                     $0001, $0000, $00FF
		dc.w	              $0102, $0101, $0100, $01FF, $01FE
		dc.w	              $0202, $0201, $0200, $02FF, $02FE
		dc.w	       $0303, $0302, $0301, $0300, $03FF, $03FE, $03FD
		dc.w	       $0403, $0402, $0401, $0400, $04FF, $04FE, $04FD
		dc.w	$0504, $0503, $0502, $0501, $0500, $05FF, $05FE, $05FD, $05FC
		dc.w	       $0603, $0602, $0601, $0600, $06FF, $06FE, $06FD

SSRLN00_D:	dc.w	                     $0100, $0000, $FF00
		dc.w	              $02FF, $01FF, $00FF, $FFFF, $FEFF
		dc.w	              $02FE, $01FE, $00FE, $FFFE, $FEFE
		dc.w	       $03FD, $02FD, $01FD, $00FD, $FFFD, $FEFD, $FDFD
		dc.w	       $03FC, $02FC, $01FC, $00FC, $FFFC, $FEFC, $FDFC
		dc.w	$04FB, $03FB, $02FB, $01FB, $00FB, $FFFB, $FEFB, $FDFB, $FCFB
		dc.w	       $03FA, $02FA, $01FA, $00FA, $FFFA, $FEFA, $FDFA

SSRL_Normal01:	dc.w	SSRLN00_A-SSRL_Normal01
		dc.w	SSRLN00_B-SSRL_Normal01
		dc.w	SSRLN00_C-SSRL_Normal01
		dc.w	SSRLN00_D-SSRL_Normal01

		dc.w	$002A
		dc.w	$0050,$0000,$00A5
		dc.w	$004E,$0000,$0110
		dc.w	$0050,$0000,$017A

		dc.w	$0032,$0002,$0070
		dc.w	$002E,$0004,$00BE
		dc.w	$002C,$0004,$0110
		dc.w	$002E,$0004,$0161
		dc.w	$0032,$0006,$01AE

		dc.w	$0020,$0008,$0094
		dc.w	$001C,$0008,$00D2
		dc.w	$001B,$0008,$0114
		dc.w	$001C,$0008,$0155
		dc.w	$0020,$0008,$0193

		dc.w	$001A,$000E,$0079
		dc.w	$0014,$000E,$00AA
		dc.w	$0011,$000E,$00DE
		dc.w	$0010,$000E,$0114
		dc.w	$0011,$000E,$0149
		dc.w	$0014,$000E,$017D
		dc.w	$0019,$000E,$01AE

		dc.w	$0017,$0014,$0094
		dc.w	$0012,$0012,$00BE
		dc.w	$000F,$0012,$00EA
		dc.w	$000E,$0012,$0118
		dc.w	$000F,$0012,$0145
		dc.w	$0012,$0012,$0171
		dc.w	$0017,$0014,$019B

		dc.w	$0019,$0016,$0083
		dc.w	$0013,$0016,$00A5
		dc.w	$000F,$0016,$00CA
		dc.w	$000C,$0016,$00F0
		dc.w	$000C,$0016,$0118
		dc.w	$000C,$0016,$013F
		dc.w	$000F,$0016,$0165
		dc.w	$0013,$0016,$018A
		dc.w	$0019,$0016,$01AC

		dc.w	$0012,$0018,$00B7
		dc.w	$000E,$0018,$00D8
		dc.w	$000C,$0018,$00F9
		dc.w	$000C,$0018,$011C
		dc.w	$000C,$0018,$013E
		dc.w	$000E,$0018,$015F
		dc.w	$0012,$0018,$0180

SSRL_Normal02:	dc.w	SSRLN00_A-SSRL_Normal02
		dc.w	SSRLN00_B-SSRL_Normal02
		dc.w	SSRLN00_C-SSRL_Normal02
		dc.w	SSRLN00_D-SSRL_Normal02

		dc.w	$002A
		dc.w	$0056,$0000,$00A1
		dc.w	$0055,$0000,$0110
		dc.w	$0056,$0000,$017E

		dc.w	$0034,$0004,$006C
		dc.w	$0030,$0004,$00BB
		dc.w	$0030,$0004,$0110
		dc.w	$0030,$0004,$0164
		dc.w	$0034,$0004,$01B4

		dc.w	$0022,$0008,$0090
		dc.w	$001E,$0008,$00D0
		dc.w	$001C,$0008,$0114
		dc.w	$001E,$0008,$0157
		dc.w	$0022,$0008,$0197

		dc.w	$001B,$000E,$0076
		dc.w	$0015,$000E,$00A7
		dc.w	$0011,$000E,$00DC
		dc.w	$0011,$000C,$0114
		dc.w	$0011,$000E,$014B
		dc.w	$0015,$000E,$0180
		dc.w	$001B,$000E,$01B1

		dc.w	$0017,$0012,$0091
		dc.w	$0012,$0012,$00BC
		dc.w	$000F,$0012,$00E9
		dc.w	$000E,$0012,$0118
		dc.w	$000F,$0012,$0146
		dc.w	$0012,$0012,$0173
		dc.w	$0017,$0012,$019E

		dc.w	$0019,$0016,$0081
		dc.w	$0013,$0016,$00A3
		dc.w	$000E,$0016,$00C9
		dc.w	$000C,$0016,$00F0
		dc.w	$000B,$0016,$0118
		dc.w	$000C,$0016,$013F
		dc.w	$000E,$0016,$0166
		dc.w	$0013,$0016,$018C
		dc.w	$0019,$0016,$01AE

		dc.w	$0012,$0018,$00B6
		dc.w	$000E,$0018,$00D7
		dc.w	$000C,$0018,$00F9
		dc.w	$000C,$0018,$011C
		dc.w	$000C,$0018,$013E
		dc.w	$000E,$0018,$0160
		dc.w	$0012,$0018,$0181

SSRL_Normal03:	dc.w	SSRLN00_A-SSRL_Normal03
		dc.w	SSRLN00_B-SSRL_Normal03
		dc.w	SSRLN00_C-SSRL_Normal03
		dc.w	SSRLN00_D-SSRL_Normal03

		dc.w	$002A
		dc.w	$005C,$0000,$009D
		dc.w	$005B,$0000,$0110
		dc.w	$005C,$0000,$0182

		dc.w	$003A,$0004,$0068
		dc.w	$0034,$0004,$00B8
		dc.w	$0033,$0004,$0110
		dc.w	$0034,$0004,$0167
		dc.w	$003A,$0004,$01B8

		dc.w	$0024,$0008,$008D
		dc.w	$0020,$0008,$00CF
		dc.w	$001E,$0008,$0114
		dc.w	$0020,$0008,$0158
		dc.w	$0024,$0008,$019A

		dc.w	$001C,$000E,$0072
		dc.w	$0017,$000C,$00A5
		dc.w	$0014,$000C,$00DB
		dc.w	$0012,$000C,$0114
		dc.w	$0014,$000C,$014C
		dc.w	$0017,$000C,$0182
		dc.w	$001C,$000E,$01B6

		dc.w	$0018,$0012,$008F
		dc.w	$0012,$0012,$00BA
		dc.w	$000F,$0012,$00E8
		dc.w	$000E,$0012,$0118
		dc.w	$000F,$0012,$0147
		dc.w	$0012,$0012,$0175
		dc.w	$0018,$0012,$01A0

		dc.w	$001A,$0016,$007E
		dc.w	$0014,$0016,$00A1
		dc.w	$000F,$0014,$00C7
		dc.w	$000C,$0014,$00EF
		dc.w	$000B,$0014,$0118
		dc.w	$000C,$0014,$0140
		dc.w	$000F,$0014,$0168
		dc.w	$0014,$0016,$018E
		dc.w	$001A,$0016,$01B1

		dc.w	$0012,$0018,$00B4
		dc.w	$000E,$0018,$00D6
		dc.w	$000C,$0018,$00F8
		dc.w	$000C,$0018,$011C
		dc.w	$000C,$0018,$013F
		dc.w	$000E,$0018,$0161
		dc.w	$0012,$0018,$0183

SSRL_Normal04:	dc.w	SSRLN04_A-SSRL_Normal04
		dc.w	SSRLN04_B-SSRL_Normal04
		dc.w	SSRLN04_C-SSRL_Normal04
		dc.w	SSRLN04_D-SSRL_Normal04

		dc.w	$002A
		dc.w	$0063,$0000,$0098
		dc.w	$0063,$0000,$0110
		dc.w	$0063,$0000,$0187

		dc.w	$003E,$0004,$0065
		dc.w	$0037,$0004,$00B6
		dc.w	$0036,$0002,$0110
		dc.w	$0037,$0004,$0169
		dc.w	$003E,$0004,$01BB

		dc.w	$0026,$0008,$0089
		dc.w	$0022,$0008,$00CD
		dc.w	$0020,$0008,$0114
		dc.w	$0022,$0008,$015A
		dc.w	$0026,$0008,$019E

		dc.w	$0021,$0010,$0074
		dc.w	$0018,$000C,$00A2
		dc.w	$0014,$000C,$00DA
		dc.w	$0013,$000C,$0114
		dc.w	$0014,$000C,$014D
		dc.w	$0018,$000C,$0185
		dc.w	$0021,$0010,$01BC

		dc.w	$0018,$0012,$008C
		dc.w	$0013,$0012,$00B8
		dc.w	$000F,$0010,$00E7
		dc.w	$000E,$0010,$0118
		dc.w	$000F,$0010,$0148
		dc.w	$0013,$0012,$0177
		dc.w	$0018,$0012,$01A3

		dc.w	$001A,$0016,$007C
		dc.w	$0014,$0014,$009F
		dc.w	$000F,$0014,$00C6
		dc.w	$000D,$0014,$00EE
		dc.w	$000B,$0014,$0118
		dc.w	$000D,$0014,$0141
		dc.w	$000F,$0014,$0169
		dc.w	$0014,$0014,$0190
		dc.w	$001A,$0016,$01B3

		dc.w	$0012,$0018,$00B2
		dc.w	$000E,$0018,$00D4
		dc.w	$000C,$0018,$00F8
		dc.w	$000C,$0018,$011C
		dc.w	$000C,$0018,$013F
		dc.w	$000E,$0018,$0163
		dc.w	$0012,$0018,$0185

SSRLN04_A:	dc.w	                     $01FF, $0100, $0101
		dc.w	              $00FE, $00FF, $0000, $0001, $0002
		dc.w	              $FFFE, $FFFF, $FF00, $FF01, $FF02
		dc.w	       $FEFD, $FEFE, $FEFF, $FE00, $FE01, $FE02, $FE03
		dc.w	       $FDFD, $FDFE, $FDFF, $FD00, $FD01, $FD02, $FD03
		dc.w	$FCFC, $FCFD, $FCFE, $FCFF, $FC00, $FC01, $FC02, $FC03, $FC04
		dc.w	       $FBFD, $FBFE, $FBFF, $FB00, $FB01, $FB02, $FB03

SSRLN04_B:	dc.w	                     $FFFF, $00FF, $01FF
		dc.w	              $FE00, $FF00, $0000, $0100, $0200
		dc.w	              $FE01, $FF01, $0001, $0101, $0201
		dc.w	       $FD02, $FE02, $FF02, $0002, $0102, $0202, $0302
		dc.w	       $FD03, $FE03, $FF03, $0003, $0103, $0203, $0303
		dc.w	$FC04, $FD04, $FE04, $FF04, $0004, $0104, $0204, $0304, $0404
		dc.w	       $FD05, $FE05, $FF05, $0005, $0105, $0205, $0305

SSRLN04_C:	dc.w	                     $FF01, $FF00, $FFFF
		dc.w	              $0002, $0001, $0000, $00FF, $00FE
		dc.w	              $0102, $0101, $0100, $01FF, $01FE
		dc.w	       $0203, $0202, $0201, $0200, $02FF, $02FE, $02FD
		dc.w	       $0303, $0302, $0301, $0300, $03FF, $03FE, $03FD
		dc.w	$0404, $0403, $0402, $0401, $0400, $04FF, $04FE, $04FD, $04FC
		dc.w	       $0503, $0502, $0501, $0500, $05FF, $05FE, $05FD

SSRLN04_D:	dc.w	                     $0101, $0001, $FF01
		dc.w	              $0200, $0100, $0000, $FF00, $FE00
		dc.w	              $02FF, $01FF, $00FF, $FFFF, $FEFF
		dc.w	       $03FE, $02FE, $01FE, $00FE, $FFFE, $FEFE, $FDFE
		dc.w	       $03FD, $02FD, $01FD, $00FD, $FFFD, $FEFD, $FDFD
		dc.w	$04FC, $03FC, $02FC, $01FC, $00FC, $FFFC, $FEFC, $FDFC, $FCFC
		dc.w	       $03FB, $02FB, $01FB, $00FB, $FFFB, $FEFB, $FDFB

SSRL_Normal05:	dc.w	SSRLN05_A-SSRL_Normal05
		dc.w	SSRLN05_B-SSRL_Normal05
		dc.w	SSRLN05_C-SSRL_Normal05
		dc.w	SSRLN05_D-SSRL_Normal05

		dc.w	$0028
		dc.w	$006B,$0000,$0095
		dc.w	$006B,$0000,$0110
		dc.w	$006B,$0000,$018B

		dc.w	$003C,$0002,$00B3
		dc.w	$003A,$0002,$0110
		dc.w	$003B,$0002,$016C

		dc.w	$0028,$0008,$0086
		dc.w	$0022,$0006,$00C7
		dc.w	$0021,$0006,$0110
		dc.w	$0022,$0006,$0158
		dc.w	$0028,$0008,$01A1

		dc.w	$0023,$0014,$0074
		dc.w	$0019,$000C,$009F
		dc.w	$0016,$000C,$00D8
		dc.w	$0014,$000C,$0114
		dc.w	$0016,$000C,$014F
		dc.w	$0019,$000C,$0188
		dc.w	$0023,$0014,$01BC

		dc.w	$0019,$0012,$0089
		dc.w	$0014,$0010,$00B6
		dc.w	$0010,$0010,$00E6
		dc.w	$000F,$0010,$0118
		dc.w	$0010,$0010,$0149
		dc.w	$0014,$0010,$0179
		dc.w	$0019,$0012,$01A6

		dc.w	$001B,$0014,$0079
		dc.w	$0014,$0014,$009D
		dc.w	$0010,$0014,$00C4
		dc.w	$000D,$0014,$00ED
		dc.w	$000C,$0014,$0118
		dc.w	$000D,$0014,$0142
		dc.w	$0010,$0014,$016B
		dc.w	$0014,$0014,$0192
		dc.w	$001B,$0014,$01B6

		dc.w	$0012,$0018,$00B1
		dc.w	$000E,$0016,$00CF
		dc.w	$000C,$0016,$00F3
		dc.w	$000C,$0016,$0118
		dc.w	$000C,$0016,$013C
		dc.w	$000E,$0016,$0160
		dc.w	$0012,$0018,$0186

SSRLN05_A:	dc.w	                     $01FF, $0100, $0101
		dc.w	                     $00FF, $0000, $0001
		dc.w	              $FFFE, $FFFF, $FF00, $FF01, $FF02
		dc.w	       $FEFD, $FEFE, $FEFF, $FE00, $FE01, $FE02, $FE03
		dc.w	       $FDFD, $FDFE, $FDFF, $FD00, $FD01, $FD02, $FD03
		dc.w	$FCFC, $FCFD, $FCFE, $FCFF, $FC00, $FC01, $FC02, $FC03, $FC04
		dc.w	       $FBFD, $FBFE, $FBFF, $FB00, $FB01, $FB02, $FB03

SSRLN05_B:	dc.w	                     $FFFF, $00FF, $01FF
		dc.w	                     $FF00, $0000, $0100
		dc.w	              $FE01, $FF01, $0001, $0101, $0201
		dc.w	       $FD02, $FE02, $FF02, $0002, $0102, $0202, $0302
		dc.w	       $FD03, $FE03, $FF03, $0003, $0103, $0203, $0303
		dc.w	$FC04, $FD04, $FE04, $FF04, $0004, $0104, $0204, $0304, $0404
		dc.w	       $FD05, $FE05, $FF05, $0005, $0105, $0205, $0305

SSRLN05_C:	dc.w	                     $FF01, $FF00, $FFFF
		dc.w	                     $0001, $0000, $00FF
		dc.w	              $0102, $0101, $0100, $01FF, $01FE
		dc.w	       $0203, $0202, $0201, $0200, $02FF, $02FE, $02FD
		dc.w	       $0303, $0302, $0301, $0300, $03FF, $03FE, $03FD
		dc.w	$0404, $0403, $0402, $0401, $0400, $04FF, $04FE, $04FD, $04FC
		dc.w	       $0503, $0502, $0501, $0500, $05FF, $05FE, $05FD

SSRLN05_D:	dc.w	                     $0101, $0001, $FF01
		dc.w	                     $0100, $0000, $FF00
		dc.w	              $02FF, $01FF, $00FF, $FFFF, $FEFF
		dc.w	       $03FE, $02FE, $01FE, $00FE, $FFFE, $FEFE, $FDFE
		dc.w	       $03FD, $02FD, $01FD, $00FD, $FFFD, $FEFD, $FDFD
		dc.w	$04FC, $03FC, $02FC, $01FC, $00FC, $FFFC, $FEFC, $FDFC, $FCFC
		dc.w	       $03FB, $02FB, $01FB, $00FB, $FFFB, $FEFB, $FDFB

SSRL_Normal06:	dc.w	SSRLN06_A-SSRL_Normal06
		dc.w	SSRLN06_B-SSRL_Normal06
		dc.w	SSRLN06_C-SSRL_Normal06
		dc.w	SSRLN06_D-SSRL_Normal06

		dc.w	$0025
		dc.w	$0040,$0002,$00AF
		dc.w	$003F,$0002,$0110
		dc.w	$0040,$0002,$0170

		dc.w	$0029,$0006,$007E
		dc.w	$0025,$0006,$00C5
		dc.w	$0023,$0006,$0110
		dc.w	$0025,$0006,$015A
		dc.w	$0029,$0006,$01A1

		dc.w	$001B,$000C,$009D
		dc.w	$0017,$000A,$00D7
		dc.w	$0013+2,$000A,$0114
		dc.w	$0017,$000A,$0150
		dc.w	$001B,$000C,$018A

		dc.w	$001A,$0010,$0086
		dc.w	$0014,$0010,$00B4
		dc.w	$0011,$0010,$00E5
		dc.w	$0010,$0010,$0118
		dc.w	$0011,$0010,$014A
		dc.w	$0014,$0010,$017B
		dc.w	$001A,$0010,$01A9

		dc.w	$001C,$0014,$0075
		dc.w	$0015,$0014,$009B
		dc.w	$0010,$0014,$00C3
		dc.w	$000D,$0014,$00ED
		dc.w	$000C,$0014,$0118
		dc.w	$000D,$0014,$0142
		dc.w	$0010,$0014,$016C
		dc.w	$0015,$0014,$0194
		dc.w	$001C,$0014,$01BB

		dc.w	$0018,$0016,$008A
		dc.w	$0013,$0016,$00AC
		dc.w	$000E,$0016,$00CE
		dc.w	$000C,$0016,$00F2
		dc.w	$000C,$0016,$0118
		dc.w	$000C,$0016,$013D
		dc.w	$000E,$0016,$0161
		dc.w	$0013,$0016,$0184
		dc.w	$0018,$0016,$01A5

SSRLN06_A:	dc.w	                     $00FF, $0000, $0001
		dc.w	              $FFFE, $FFFF, $FF00, $FF01, $FF02
		dc.w	              $FEFE, $FEFF, $FE00, $FE01, $FE02
		dc.w	       $FDFD, $FDFE, $FDFF, $FD00, $FD01, $FD02, $FD03
		dc.w	$FCFC, $FCFD, $FCFE, $FCFF, $FC00, $FC01, $FC02, $FC03, $FC04
		dc.w	$FBFC, $FBFD, $FBFE, $FBFF, $FB00, $FB01, $FB02, $FB03, $FB04

SSRLN06_B:	dc.w	                     $FF00, $0000, $0100
		dc.w	              $FE01, $FF01, $0001, $0101, $0201
		dc.w	              $FE02, $FF02, $0002, $0102, $0202
		dc.w	       $FD03, $FE03, $FF03, $0003, $0103, $0203, $0303
		dc.w	$FC04, $FD04, $FE04, $FF04, $0004, $0104, $0204, $0304, $0404
		dc.w	$FC05, $FD05, $FE05, $FF05, $0005, $0105, $0205, $0305, $0405

SSRLN06_C:	dc.w	                     $0001, $0000, $00FF
		dc.w	              $0102, $0101, $0100, $01FF, $01FE
		dc.w	              $0202, $0201, $0200, $02FF, $02FE
		dc.w	       $0303, $0302, $0301, $0300, $03FF, $03FE, $03FD
		dc.w	$0404, $0403, $0402, $0401, $0400, $04FF, $04FE, $04FD, $04FC
		dc.w	$0504, $0503, $0502, $0501, $0500, $05FF, $05FE, $05FD, $05FC

SSRLN06_D:	dc.w	                     $0100, $0000, $FF00
		dc.w	              $02FF, $01FF, $00FF, $FFFF, $FEFF
		dc.w	              $02FE, $01FE, $00FE, $FFFE, $FEFE
		dc.w	       $03FD, $02FD, $01FD, $00FD, $FFFD, $FEFD, $FDFD
		dc.w	$04FC, $03FC, $02FC, $01FC, $00FC, $FFFC, $FEFC, $FDFC, $FCFC
		dc.w	$04FB, $03FB, $02FB, $01FB, $00FB, $FFFB, $FEFB, $FDFB, $FCFB

SSRL_Normal07:	dc.w	SSRLN00_A-SSRL_Normal07
		dc.w	SSRLN00_B-SSRL_Normal07
		dc.w	SSRLN00_C-SSRL_Normal07
		dc.w	SSRLN00_D-SSRL_Normal07

		dc.w	$002A
		dc.w	$0045,$0002,$00AC
		dc.w	$0043,$0002,$0110
		dc.w	$0045,$0002,$0173

		dc.w	$002B,$0006,$007A
		dc.w	$0027,$0006,$00C2
		dc.w	$0026,$0006,$0110
		dc.w	$0027,$0006,$015D
		dc.w	$002B,$0006,$01A5

		dc.w	$001C,$000A,$009A
		dc.w	$0019,$000A,$00D5
		dc.w	$0017,$000A,$0114
		dc.w	$0019,$000A,$0152
		dc.w	$001C,$000A,$018D

		dc.w	$001B,$0010,$0083
		dc.w	$0015,$0010,$00B2
		dc.w	$000F,$000E,$00E0
		dc.w	$000E,$000E,$0114
		dc.w	$000F,$000E,$0147
		dc.w	$0015,$0010,$017D
		dc.w	$001B,$0010,$01AC

		dc.w	$0015,$0014,$0099
		dc.w	$0010,$0014,$00C1
		dc.w	$000D,$0014,$00EC
		dc.w	$000C,$0014,$0118
		dc.w	$000D,$0014,$0143
		dc.w	$0010,$0014,$016E
		dc.w	$0015,$0014,$0196

		dc.w	$0018,$0016,$0088
		dc.w	$0013,$0016,$00A9
		dc.w	$000E,$0016,$00CD
		dc.w	$000C,$0016,$00F2
		dc.w	$000C,$0016,$0118
		dc.w	$000C,$0016,$013D
		dc.w	$000E,$0016,$0161
		dc.w	$0013,$0016,$0186
		dc.w	$0018,$0016,$01A7

		dc.w	$0012,$0018,$00BA
		dc.w	$000F,$0018,$00DA
		dc.w	$000C,$0018,$00FA
		dc.w	$000C,$0018,$011C
		dc.w	$000C,$0018,$013D
		dc.w	$000F,$0018,$015D
		dc.w	$0012,$0018,$017D

SSRL_Rotate00:	dc.w	SSRLR00_A-SSRL_Rotate00
		dc.w	SSRLR00_B-SSRL_Rotate00
		dc.w	SSRLR00_C-SSRL_Rotate00
		dc.w	SSRLR00_D-SSRL_Rotate00

		dc.w	$002C
		dc.w	$003E,$0004,$01B8
		dc.w	$0042,$0002,$0170
		dc.w	$0049,$0000,$0110
		dc.w	$0053,$0000,$00A6

		dc.w	$0027,$0008,$0193
		dc.w	$0026,$0006,$014D
		dc.w	$0029,$0004,$0101
		dc.w	$002F,$0004,$00AF

		dc.w	$001B,$000C,$01A2
		dc.w	$0018,$000C,$0171
		dc.w	$0018,$000A,$0139
		dc.w	$001A,$000A,$00FB
		dc.w	$001F,$0008,$00B9
		dc.w	$0027,$0008,$0077

		dc.w	$0019,$0012,$01AD
		dc.w	$0015,$0012,$0188
		dc.w	$0012,$0010,$015D
		dc.w	$000E,$000E,$0129
		dc.w	$000F,$000E,$00F6
		dc.w	$0013,$000E,$00BF
		dc.w	$001A,$000C,$0088

		dc.w	$001A,$0016,$01B2
		dc.w	$0014,$0016,$0194
		dc.w	$0010,$0014,$0172
		dc.w	$000D,$0014,$014C
		dc.w	$000D,$0014,$0122
		dc.w	$000E,$0012,$00F6
		dc.w	$0011,$0012,$00C8
		dc.w	$0016,$0012,$009A
		dc.w	$001B,$0014,$0078

		dc.w	$0017,$0018,$019F
		dc.w	$0012,$0018,$0183
		dc.w	$000E,$0018,$0164
		dc.w	$000C,$0016,$013E
		dc.w	$000B,$0016,$011A
		dc.w	$000C,$0016,$00F3
		dc.w	$000E,$0016,$00CC
		dc.w	$0013,$0014,$00A4
		dc.w	$001A,$0014,$007D

		dc.w	$000D,$0018,$0138
		dc.w	$000C,$0018,$0118
		dc.w	$000D,$0018,$00F4
		dc.w	$000F,$0018,$00D4
		dc.w	$0013,$0018,$00B1
		dc.w	$0017,$0018,$008F

SSRLR00_A:	dc.w	                     $0002, $0001, $0000, $00FF
		dc.w	                     $FF02, $FF01, $FF00, $FFFF
		dc.w	              $FE03, $FE02, $FE01, $FE00, $FEFF, $FEFE
		dc.w	       $FD04, $FD03, $FD02, $FD01, $FD00, $FDFF, $FDFE
		dc.w	$FC05, $FC04, $FC03, $FC02, $FC01, $FC00, $FCFF, $FCFE, $FCFD
		dc.w	$FB05, $FB04, $FB03, $FB02, $FB01, $FB00, $FBFF, $FBFE, $FBFD
		dc.w	                     $FA02, $FA01, $FA00, $FAFF, $FAFE, $FAFD

SSRLR00_B:	dc.w	                     $0200, $0100, $0000, $FF00
		dc.w	                     $0201, $0101, $0001, $FF01
		dc.w	              $0302, $0202, $0102, $0002, $FF02, $FE02
		dc.w	       $0403, $0303, $0203, $0103, $0003, $FF03, $FE03
		dc.w	$0504, $0404, $0304, $0204, $0104, $0004, $FF04, $FE04, $FD04
		dc.w	$0505, $0405, $0305, $0205, $0105, $0005, $FF05, $FE05, $FD05
		dc.w	                     $0206, $0106, $0006, $FF06, $FE06, $FD06

SSRLR00_C:	dc.w	                     $00FE, $00FF, $0000, $0001
		dc.w	                     $01FE, $01FF, $0100, $0101
		dc.w	              $02FD, $02FE, $02FF, $0200, $0201, $0202
		dc.w	       $03FC, $03FD, $03FE, $03FF, $0300, $0301, $0302
		dc.w	$04FB, $04FC, $04FD, $04FE, $04FF, $0400, $0401, $0402, $0403
		dc.w	$05FB, $05FC, $05FD, $05FE, $05FF, $0500, $0501, $0502, $0503
		dc.w	                     $06FE, $06FF, $0600, $0601, $0602, $0603

SSRLR00_D:	dc.w	                     $FE00, $FF00, $0000, $0100
		dc.w	                     $FEFF, $FFFF, $00FF, $01FF
		dc.w	              $FDFE, $FEFE, $FFFE, $00FE, $01FE, $02FE
		dc.w	       $FCFD, $FDFD, $FEFD, $FFFD, $00FD, $01FD, $02FD
		dc.w	$FBFC, $FCFC, $FDFC, $FEFC, $FFFC, $00FC, $01FC, $02FC, $03FC
		dc.w	$FBFB, $FCFB, $FDFB, $FEFB, $FFFB, $00FB, $01FB, $02FB, $03FB
		dc.w	                     $FEFA, $FFFA, $00FA, $01FA, $02FA, $03FA

SSRL_Rotate01:	dc.w	SSRLR01_A-SSRL_Rotate01
		dc.w	SSRLR01_B-SSRL_Rotate01
		dc.w	SSRLR01_C-SSRL_Rotate01
		dc.w	SSRLR01_D-SSRL_Rotate01

		dc.w	$002D
		dc.w	$0066,$0002,$01AD

		dc.w	$0033,$0004,$01A8
		dc.w	$003B,$0002,$0166
		dc.w	$0049,$0000,$0110
		dc.w	$005C,$0000,$00A6

		dc.w	$001F,$000A,$01A5
		dc.w	$0020,$0008,$0177
		dc.w	$0022,$0006,$0139
		dc.w	$002B,$0004,$00F1
		dc.w	$0037,$0004,$009D

		dc.w	$001B,$0016,$01B6
		dc.w	$0018,$0012,$01A4
		dc.w	$0013,$000E,$017D
		dc.w	$0013,$000C,$0152
		dc.w	$0016,$000A,$011F
		dc.w	$001C,$0008,$00E2
		dc.w	$0023+2,$0008,$009E

		dc.w	$0016,$0016,$01A0
		dc.w	$0012,$0014,$0184
		dc.w	$0010,$0012,$0163
		dc.w	$000F,$0010,$013B
		dc.w	$000E,$000E,$010A
		dc.w	$0012,$000E,$00D6
		dc.w	$001A,$000C,$009E
		dc.w	$0023,$0014,$0074

		dc.w	$0017,$0018,$01A1
		dc.w	$0013,$0018,$0189
		dc.w	$000F,$0016,$016B
		dc.w	$000D,$0016,$014C
		dc.w	$000C,$0014,$0128
		dc.w	$000D,$0014,$00FF
		dc.w	$0010,$0012,$00D3
		dc.w	$0016,$0010,$00A3
		dc.w	$001E,$0014,$0077

		dc.w	$000E,$0018,$015B
		dc.w	$000C,$0018,$013E
		dc.w	$000B,$0016,$0119
		dc.w	$000C,$0016,$00F5
		dc.w	$000F,$0014,$00CD
		dc.w	$0014,$0014,$00A6
		dc.w	$001B,$0014,$007A

		dc.w	$000D,$0018,$00F2
		dc.w	$0010,$0018,$00CD
		dc.w	$0014,$0018,$00AB
		dc.w	$0019,$0016,$0082

		dc.w	$001A,$0018,$008C

SSRLR01_A:	dc.w	                                   $0101
		dc.w	                            $0002, $0001, $0000, $00FF
		dc.w	                     $FF03, $FF02, $FF01, $FF00, $FFFF
		dc.w	       $FE05, $FE04, $FE03, $FE02, $FE01, $FE00, $FEFF
		dc.w	       $FD05, $FD04, $FD03, $FD02, $FD01, $FD00, $FDFF, $FDFE
		dc.w	$FC06, $FC05, $FC04, $FC03, $FC02, $FC01, $FC00, $FCFF, $FCFE
		dc.w	              $FB04, $FB03, $FB02, $FB01, $FB00, $FBFF, $FBFE
		dc.w	                                   $FA01, $FA00, $FAFF, $FAFE
		dc.w	                                                 $F9FF

SSRLR01_B:	dc.w	                                   $01FF
		dc.w	                            $0200, $0100, $0000, $FF00
		dc.w	                     $0301, $0201, $0101, $0001, $FF01
		dc.w	       $0502, $0402, $0302, $0202, $0102, $0002, $FF02
		dc.w	       $0503, $0403, $0303, $0203, $0103, $0003, $FF03, $FE03
		dc.w	$0604, $0504, $0404, $0304, $0204, $0104, $0004, $FF04, $FE04
		dc.w	              $0405, $0305, $0205, $0105, $0005, $FF05, $FE05
		dc.w	                                   $0106, $0006, $FF06, $FE06
		dc.w	                                                 $FF07

SSRLR01_C:	dc.w	                                   $FFFF
		dc.w	                            $00FE, $00FF, $0000, $0001
		dc.w	                     $01FD, $01FE, $01FF, $0100, $0101
		dc.w	       $02FB, $02FC, $02FD, $02FE, $02FF, $0200, $0201
		dc.w	       $03FB, $03FC, $03FD, $03FE, $03FF, $0300, $0301, $0302
		dc.w	$04FA, $04FB, $04FC, $04FD, $04FE, $04FF, $0400, $0401, $0402
		dc.w	              $05FC, $05FD, $05FE, $05FF, $0500, $0501, $0502
		dc.w	                                   $06FF, $0600, $0601, $0602
		dc.w	                                                 $0701

SSRLR01_D:	dc.w	                                   $FF01
		dc.w	                            $FE00, $FF00, $0000, $0100
		dc.w	                     $FDFF, $FEFF, $FFFF, $00FF, $01FF
		dc.w	       $FBFE, $FCFE, $FDFE, $FEFE, $FFFE, $00FE, $01FE
		dc.w	       $FBFD, $FCFD, $FDFD, $FEFD, $FFFD, $00FD, $01FD, $02FD
		dc.w	$FAFC, $FBFC, $FCFC, $FDFC, $FEFC, $FFFC, $00FC, $01FC, $02FC
		dc.w	              $FCFB, $FDFB, $FEFB, $FFFB, $00FB, $01FB, $02FB
		dc.w	                                   $FFFA, $00FA, $01FA, $02FA
		dc.w	                                                 $01F9

SSRL_Rotate02:	dc.w	SSRLR02_A-SSRL_Rotate02
		dc.w	SSRLR02_B-SSRL_Rotate02
		dc.w	SSRLR02_C-SSRL_Rotate02
		dc.w	SSRLR02_D-SSRL_Rotate02

		dc.w	$002C
		dc.w	$0058,$0000,$01A9

		dc.w	$0026,$000A,$01B6
		dc.w	$002A,$0006,$018F
		dc.w	$0035,$0004,$015A
		dc.w	$0049,$0000,$0110
		dc.w	$0065,$0000,$00B1

		dc.w	$001B,$0012,$01B7
		dc.w	$0019,$0010,$01A3
		dc.w	$0018,$000C,$0183
		dc.w	$001B,$0008,$015C
		dc.w	$0021,$0006,$0125
		dc.w	$002D,$0004,$00E2
		dc.w	$0040,$0002,$008E

		dc.w	$0014,$0014,$0194
		dc.w	$0012,$0014,$017C
		dc.w	$0012,$0010,$015E
		dc.w	$0011,$000E,$0134
		dc.w	$0016,$000A,$0104
		dc.w	$0020,$0008,$00C9
		dc.w	$002B,$0006,$007E

		dc.w	$0014,$0018,$018E
		dc.w	$0011,$0016,$0176
		dc.w	$000E,$0014,$015D
		dc.w	$000D,$0014,$013F
		dc.w	$000E,$0012,$011A
		dc.w	$000F,$000E,$00EA
		dc.w	$0017,$000C,$00B6
		dc.w	$0021,$000A,$007A

		dc.w	$000E,$0018,$0161
		dc.w	$000C,$0016,$0144
		dc.w	$000B,$0016,$0127
		dc.w	$000C,$0014,$0104
		dc.w	$000F,$0012,$00DC
		dc.w	$0014,$0010,$00AE
		dc.w	$001A,$000E,$0077

		dc.w	$000B,$0018,$0118
		dc.w	$000C,$0016,$00F4
		dc.w	$000E,$0016,$00CF
		dc.w	$0013,$0014,$00A7
		dc.w	$001B,$0012,$007A

		dc.w	$000D,$0018,$00EC
		dc.w	$0010,$0018,$00CB
		dc.w	$0014,$0016,$00A3
		dc.w	$001B,$0018,$0080

		dc.w	$0016,$0018,$00A4

SSRLR02_A:	dc.w	                                   $0101
		dc.w	                     $0003, $0002, $0001, $0000, $00FF
		dc.w	       $FF05, $FF04, $FF03, $FF02, $FF01, $FF00, $FFFF
		dc.w	       $FE05, $FE04, $FE03, $FE02, $FE01, $FE00, $FEFF
		dc.w	$FD06, $FD05, $FD04, $FD03, $FD02, $FD01, $FD00, $FDFF
		dc.w	       $FC05, $FC04, $FC03, $FC02, $FC01, $FC00, $FCFF
		dc.w	                     $FB03, $FB02, $FB01, $FB00, $FBFF
		dc.w	                            $FA02, $FA01, $FA00, $FAFF
		dc.w	                                                 $F9FF

SSRLR02_B:	dc.w	                                   $01FF
		dc.w	                     $0300, $0200, $0100, $0000, $FF00
		dc.w	       $0501, $0401, $0301, $0201, $0101, $0001, $FF01
		dc.w	       $0502, $0402, $0302, $0202, $0102, $0002, $FF02
		dc.w	$0603, $0503, $0403, $0303, $0203, $0103, $0003, $FF03
		dc.w	       $0504, $0404, $0304, $0204, $0104, $0004, $FF04
		dc.w	                     $0305, $0205, $0105, $0005, $FF05
		dc.w	                            $0206, $0106, $0006, $FF06
		dc.w	                                                 $FF07

SSRLR02_C:	dc.w	                                   $FFFF
		dc.w	                     $00FD, $00FE, $00FF, $0000, $0001
		dc.w	       $01FB, $01FC, $01FD, $01FE, $01FF, $0100, $0101
		dc.w	       $02FB, $02FC, $02FD, $02FE, $02FF, $0200, $0201
		dc.w	$03FA, $03FB, $03FC, $03FD, $03FE, $03FF, $0300, $0301
		dc.w	       $04FB, $04FC, $04FD, $04FE, $04FF, $0400, $0401
		dc.w	                     $05FD, $05FE, $05FF, $0500, $0501
		dc.w	                            $06FE, $06FF, $0600, $0601
		dc.w	                                                 $0701

SSRLR02_D:	dc.w	                                   $FF01
		dc.w	                     $FD00, $FE00, $FF00, $0000, $0100
		dc.w	       $FBFF, $FCFF, $FDFF, $FEFF, $FFFF, $00FF, $01FF
		dc.w	       $FBFE, $FCFE, $FDFE, $FEFE, $FFFE, $00FE, $01FE
		dc.w	$FAFD, $FBFD, $FCFD, $FDFD, $FEFD, $FFFD, $00FD, $01FD
		dc.w	       $FBFC, $FCFC, $FDFC, $FEFC, $FFFC, $00FC, $01FC
		dc.w	                     $FDFB, $FEFB, $FFFB, $00FB, $01FB
		dc.w	                            $FEFA, $FFFA, $00FA, $01FA
		dc.w	                                                 $01F9

SSRL_Rotate03:	dc.w	SSRLR03_A-SSRL_Rotate03
		dc.w	SSRLR03_B-SSRL_Rotate03
		dc.w	SSRLR03_C-SSRL_Rotate03
		dc.w	SSRLR03_D-SSRL_Rotate03

		dc.w	$002A
		dc.w	$004C,$0002,$0080
		dc.w	$0049,$0000,$0110
		dc.w	$004C,$0002,$019F

		dc.w	$0030,$0004,$00D3
		dc.w	$0031,$0004,$014C

		dc.w	$0023+2,$0008,$00AF
		dc.w	$0020,$0006,$0110
		dc.w	$0023+2,$0008,$0178

		dc.w	$001D,$000A,$0094
		dc.w	$0018,$0008,$00E7
		dc.w	$0018,$0008,$013F
		dc.w	$001D,$000A,$0193

		dc.w	$0019,$000E,$0083
		dc.w	$0013,$000E,$00C7
		dc.w	$0010,$000E,$0113
		dc.w	$0012,$000E,$015E
		dc.w	$0018,$000E,$01A4

		dc.w	$001B,$0012,$007C
		dc.w	$0014,$0012,$00B4
		dc.w	$000F,$0010,$00F4
		dc.w	$000F,$0010,$0137
		dc.w	$0013,$0012,$0179
		dc.w	$001A,$0012,$01B3

		dc.w	$0014,$0014,$00A3
		dc.w	$000E,$0014,$00D9
		dc.w	$000C,$0014,$0117
		dc.w	$000E,$0014,$0150
		dc.w	$0013,$0014,$0188

		dc.w	$0015,$0016,$0097
		dc.w	$000F,$0016,$00C5
		dc.w	$000C,$0016,$00F8
		dc.w	$000C,$0016,$0132
		dc.w	$000F,$0016,$0163
		dc.w	$0015,$0016,$0194

		dc.w	$0018,$0018,$0093
		dc.w	$0010,$0018,$00BB
		dc.w	$000D,$0018,$00E6
		dc.w	$000C,$0018,$00EF
		dc.w	$000C,$0018,$011B
		dc.w	$000C,$0018,$0143
		dc.w	$000D,$0018,$014B
		dc.w	$0010,$0018,$0175
		dc.w	$0017,$0018,$019E

SSRLR03_A:	dc.w	                     $01FF, $0000, $FF01
		dc.w	                        $00FF, $FF00
		dc.w	                     $00FE, $FFFF, $FE00
		dc.w	                 $00FD, $FFFE, $FEFF, $FD00
		dc.w	              $00FC, $FFFD, $FEFE, $FDFF, $FC00
		dc.w	          $00FB, $FFFC, $FEFD, $FDFE, $FCFF, $FB00
		dc.w	              $FFFB, $FEFC, $FDFD, $FCFE, $FBFF
		dc.w	          $FFFA, $FEFB, $FDFC, $FCFD, $FBFE, $FAFF
		dc.w	$00F8, $FFF9, $FEFA, $FDFB, $FCFC, $FBFD, $FAFE, $F9FF, $F800

SSRLR03_B:	dc.w	                     $FFFF, $0000, $0101
		dc.w	                        $FF00, $0001
		dc.w	                     $FE00, $FF01, $0002
		dc.w	                 $FD00, $FE01, $FF02, $0003
		dc.w	              $FC00, $FD01, $FE02, $FF03, $0004
		dc.w	          $FB00, $FC01, $FD02, $FE03, $FF04, $0005
		dc.w	              $FB01, $FC02, $FD03, $FE04, $FF05
		dc.w	          $FA01, $FB02, $FC03, $FD04, $FE05, $FF06
		dc.w	$F800, $F901, $FA02, $FB03, $FC04, $FD05, $FE06, $FF07, $0008

SSRLR03_C:	dc.w	                     $FF01, $0000, $01FF
		dc.w	                        $0001, $0100
		dc.w	                     $0002, $0101, $0200
		dc.w	                 $0003, $0102, $0201, $0300
		dc.w	              $0004, $0103, $0202, $0301, $0400
		dc.w	          $0005, $0104, $0203, $0302, $0401, $0500
		dc.w	              $0105, $0204, $0303, $0402, $0501
		dc.w	          $0106, $0205, $0304, $0403, $0502, $0601
		dc.w	$0008, $0107, $0206, $0305, $0404, $0503, $0602, $0701, $0800

SSRLR03_D:	dc.w	                     $0101, $0000, $FFFF
		dc.w	                        $0100, $00FF
		dc.w	                     $0200, $01FF, $00FE
		dc.w	                 $0300, $02FF, $01FE, $00FD
		dc.w	              $0400, $03FF, $02FE, $01FD, $00FC
		dc.w	          $0500, $04FF, $03FE, $02FD, $01FC, $00FB
		dc.w	              $05FF, $04FE, $03FD, $02FC, $01FB
		dc.w	          $06FF, $05FE, $04FD, $03FC, $02FB, $01FA
		dc.w	$0800, $07FF, $06FE, $05FD, $04FC, $03FB, $02FA, $01F9, $00F8

SSRL_Rotate04:	dc.w	SSRLR04_A-SSRL_Rotate04
		dc.w	SSRLR04_B-SSRL_Rotate04
		dc.w	SSRLR04_C-SSRL_Rotate04
		dc.w	SSRLR04_D-SSRL_Rotate04

		dc.w	$002C
		dc.w	$0058,$0000,$0077

		dc.w	$0026,$000A,$0072
		dc.w	$002A,$0006,$0091
		dc.w	$0035,$0004,$00C6
		dc.w	$0049,$0000,$0110
		dc.w	$0065,$0000,$016F

		dc.w	$001B,$0012,$0079
		dc.w	$0019,$0010,$008D
		dc.w	$0018,$000C,$00A5
		dc.w	$001B,$0008,$00CC
		dc.w	$0021,$0006,$00FB
		dc.w	$002D,$0004,$013E
		dc.w	$0040,$0002,$0192

		dc.w	$0014,$0014,$009C
		dc.w	$0012,$0014,$00B4
		dc.w	$0012,$0010,$00D2
		dc.w	$0011,$000E,$00F4
		dc.w	$0016,$000A,$0124
		dc.w	$0020,$0008,$015F
		dc.w	$002B,$0006,$01A2

		dc.w	$0014,$0018,$00AA
		dc.w	$0011,$0016,$00BA
		dc.w	$000E,$0014,$00D3
		dc.w	$000D,$0014,$00F1
		dc.w	$000E,$0012,$0116
		dc.w	$000F,$000E,$013E
		dc.w	$0017,$000C,$0172
		dc.w	$0021,$000A,$01AE

		dc.w	$000E,$0018,$00D7
		dc.w	$000C,$0016,$00EC
		dc.w	$000B,$0016,$0109
		dc.w	$000C,$0014,$012C
		dc.w	$000F,$0012,$0154
		dc.w	$0014,$0010,$0182
		dc.w	$001A,$000E,$01B1

		dc.w	$000B,$0018,$0120
		dc.w	$000C,$0016,$013C
		dc.w	$000E,$0016,$0161
		dc.w	$0013,$0014,$0189
		dc.w	$001B,$0012,$01B6

		dc.w	$000D,$0018,$014C
		dc.w	$0010,$0018,$016D
		dc.w	$0014,$0016,$018D
		dc.w	$001B,$0018,$01B8

		dc.w	$0016,$0018,$0194

SSRLR04_A:	dc.w	                                   $01FF
		dc.w	                     $00FD, $00FE, $00FF, $0000, $0001
		dc.w	       $FFFB, $FFFC, $FFFD, $FFFE, $FFFF, $FF00, $FF01
		dc.w	       $FEFB, $FEFC, $FEFD, $FEFE, $FEFF, $FE00, $FE01
		dc.w	$FDFA, $FDFB, $FDFC, $FDFD, $FDFE, $FDFF, $FD00, $FD01
		dc.w	       $FCFB, $FCFC, $FCFD, $FCFE, $FCFF, $FC00, $FC01
		dc.w	                     $FBFD, $FBFE, $FBFF, $FB00, $FB01
		dc.w	                            $FAFE, $FAFF, $FA00, $FA01
		dc.w	                                                 $F901

SSRLR04_B:	dc.w	                                   $FFFF
		dc.w	                     $FD00, $FE00, $FF00, $0000, $0100
		dc.w	       $FB01, $FC01, $FD01, $FE01, $FF01, $0001, $0101
		dc.w	       $FB02, $FC02, $FD02, $FE02, $FF02, $0002, $0102
		dc.w	$FA03, $FB03, $FC03, $FD03, $FE03, $FF03, $0003, $0103
		dc.w	       $FB04, $FC04, $FD04, $FE04, $FF04, $0004, $0104
		dc.w	                     $FD05, $FE05, $FF05, $0005, $0105
		dc.w	                            $FE06, $FF06, $0006, $0106
		dc.w	                                                 $0107

SSRLR04_C:	dc.w	                                   $FF01
		dc.w	                     $0003, $0002, $0001, $0000, $00FF
		dc.w	       $0105, $0104, $0103, $0102, $0101, $0100, $01FF
		dc.w	       $0205, $0204, $0203, $0202, $0201, $0200, $02FF
		dc.w	$0306, $0305, $0304, $0303, $0302, $0301, $0300, $03FF
		dc.w	       $0405, $0404, $0403, $0402, $0401, $0400, $04FF
		dc.w	                     $0503, $0502, $0501, $0500, $05FF
		dc.w	                            $0602, $0601, $0600, $06FF
		dc.w	                                                 $07FF

SSRLR04_D:	dc.w	                                   $0101
		dc.w	                     $0300, $0200, $0100, $0000, $FF00
		dc.w	       $05FF, $04FF, $03FF, $02FF, $01FF, $00FF, $FFFF
		dc.w	       $05FE, $04FE, $03FE, $02FE, $01FE, $00FE, $FFFE
		dc.w	$06FD, $05FD, $04FD, $03FD, $02FD, $01FD, $00FD, $FFFD
		dc.w	       $05FC, $04FC, $03FC, $02FC, $01FC, $00FC, $FFFC
		dc.w	                     $03FB, $02FB, $01FB, $00FB, $FFFB
		dc.w	                            $02FA, $01FA, $00FA, $FFFA
		dc.w	                                                 $FFF9

SSRL_Rotate05:	dc.w	SSRLR05_A-SSRL_Rotate05
		dc.w	SSRLR05_B-SSRL_Rotate05
		dc.w	SSRLR05_C-SSRL_Rotate05
		dc.w	SSRLR05_D-SSRL_Rotate05

		dc.w	$002D
		dc.w	$0066,$0002,$0073
		dc.w	$0033,$0004,$0078
		dc.w	$003B,$0002,$00BA
		dc.w	$0049,$0000,$0110
		dc.w	$005C,$0000,$017A
		dc.w	$001F,$000A,$0083
		dc.w	$0020,$0008,$00B1
		dc.w	$0022,$0006,$00E7
		dc.w	$002B,$0004,$012F
		dc.w	$0037,$0004,$0183
		dc.w	$001B,$0016,$007A
		dc.w	$0018,$0012,$008C
		dc.w	$0013,$000E,$00AB
		dc.w	$0013,$000C,$00D6
		dc.w	$0016,$000A,$0109
		dc.w	$001C,$0008,$0146
		dc.w	$0023+2,$0008,$018A
		dc.w	$0016,$0016,$0090
		dc.w	$0012,$0014,$00AC
		dc.w	$0010,$0012,$00CD
		dc.w	$000F,$0010,$00F5
		dc.w	$000E,$000E,$011E
		dc.w	$0012,$000E,$0152
		dc.w	$001A,$000C,$018A
		dc.w	$0023,$0014,$01BC
		dc.w	$0017,$0018,$0097
		dc.w	$0013,$0018,$00AF
		dc.w	$000F,$0016,$00C5
		dc.w	$000D,$0016,$00E4
		dc.w	$000C,$0014,$0108
		dc.w	$000D,$0014,$0131
		dc.w	$0010,$0012,$015D
		dc.w	$0016,$0010,$018D
		dc.w	$001E,$0014,$01B9
		dc.w	$000E,$0018,$00DD
		dc.w	$000C,$0018,$00FA
		dc.w	$000B,$0016,$0117
		dc.w	$000C,$0016,$013B
		dc.w	$000F,$0014,$0163
		dc.w	$0014,$0014,$018A
		dc.w	$001B,$0014,$01B6
		dc.w	$000D,$0018,$0146
		dc.w	$0010,$0018,$016B
		dc.w	$0014,$0018,$018D
		dc.w	$0019,$0016,$01AE
		dc.w	$001A,$0018,$01AC

SSRLR05_A:	dc.w	                                   $01FF
		dc.w	                            $00FE, $00FF, $0000, $0001
		dc.w	                     $FFFD, $FFFE, $FFFF, $FF00, $FF01
		dc.w	       $FEFB, $FEFC, $FEFD, $FEFE, $FEFF, $FE00, $FE01
		dc.w	       $FDFB, $FDFC, $FDFD, $FDFE, $FDFF, $FD00, $FD01, $FD02
		dc.w	$FCFA, $FCFB, $FCFC, $FCFD, $FCFE, $FCFF, $FC00, $FC01, $FC02
		dc.w	              $FBFC, $FBFD, $FBFE, $FBFF, $FB00, $FB01, $FB02
		dc.w	                                   $FAFF, $FA00, $FA01, $FA02
		dc.w	                                                 $F901

SSRLR05_B:	dc.w	                                   $FFFF
		dc.w	                            $FE00, $FF00, $0000, $0100
		dc.w	                     $FD01, $FE01, $FF01, $0001, $0101
		dc.w	       $FB02, $FC02, $FD02, $FE02, $FF02, $0002, $0102
		dc.w	       $FB03, $FC03, $FD03, $FE03, $FF03, $0003, $0103, $0203
		dc.w	$FA04, $FB04, $FC04, $FD04, $FE04, $FF04, $0004, $0104, $0204
		dc.w	              $FC05, $FD05, $FE05, $FF05, $0005, $0105, $0205
		dc.w	                                   $FF06, $0006, $0106, $0206
		dc.w	                                                 $0107

SSRLR05_C:	dc.w	                                   $FF01
		dc.w	                            $0002, $0001, $0000, $00FF
		dc.w	                     $0103, $0102, $0101, $0100, $01FF
		dc.w	       $0205, $0204, $0203, $0202, $0201, $0200, $02FF
		dc.w	       $0305, $0304, $0303, $0302, $0301, $0300, $03FF, $03FE
		dc.w	$0406, $0405, $0404, $0403, $0402, $0401, $0400, $04FF, $04FE
		dc.w	              $0504, $0503, $0502, $0501, $0500, $05FF, $05FE
		dc.w	                                   $0601, $0600, $06FF, $06FE
		dc.w	                                                 $07FF

SSRLR05_D:	dc.w	                                   $0101
		dc.w	                            $0200, $0100, $0000, $FF00
		dc.w	                     $03FF, $02FF, $01FF, $00FF, $FFFF
		dc.w	       $05FE, $04FE, $03FE, $02FE, $01FE, $00FE, $FFFE
		dc.w	       $05FD, $04FD, $03FD, $02FD, $01FD, $00FD, $FFFD, $FEFD
		dc.w	$06FC, $05FC, $04FC, $03FC, $02FC, $01FC, $00FC, $FFFC, $FEFC
		dc.w	              $04FB, $03FB, $02FB, $01FB, $00FB, $FFFB, $FEFB
		dc.w	                                   $01FA, $00FA, $FFFA, $FEFA
		dc.w	                                                 $FFF9

SSRL_Rotate06:	dc.w	SSRLR06_A-SSRL_Rotate06
		dc.w	SSRLR06_B-SSRL_Rotate06
		dc.w	SSRLR06_C-SSRL_Rotate06
		dc.w	SSRLR06_D-SSRL_Rotate06

		dc.w	$002C
		dc.w	$003E,$0004,$0068
		dc.w	$0042,$0002,$00B0
		dc.w	$0049,$0000,$0110
		dc.w	$0053,$0000,$017A

		dc.w	$0027,$0008,$0095
		dc.w	$0026,$0006,$00D3
		dc.w	$0029,$0004,$011F
		dc.w	$002F,$0004,$0171

		dc.w	$001B,$000C,$0086
		dc.w	$0018,$000C,$00B7
		dc.w	$0018,$000A,$00EF
		dc.w	$001A,$000A,$012D
		dc.w	$001F,$0008,$016F
		dc.w	$0027,$0008,$01B1

		dc.w	$0019,$0012,$0083
		dc.w	$0015,$0012,$00A8
		dc.w	$0012,$0010,$00D3
		dc.w	$000E,$000E,$00FF
		dc.w	$000F,$000E,$0132
		dc.w	$0013,$000E,$0169
		dc.w	$001A,$000C,$01A0

		dc.w	$001A,$0016,$007E
		dc.w	$0014,$0016,$009C
		dc.w	$0010,$0014,$00BE
		dc.w	$000D,$0014,$00E4
		dc.w	$000D,$0014,$010E
		dc.w	$000E,$0012,$013A
		dc.w	$0011,$0012,$0168
		dc.w	$0016,$0012,$0196
		dc.w	$001B,$0012,$01B8

		dc.w	$0017,$0018,$0099
		dc.w	$0012,$0018,$00B5
		dc.w	$000E,$0018,$00D4
		dc.w	$000C,$0016,$00F2
		dc.w	$000B,$0016,$0116
		dc.w	$000C,$0016,$013D
		dc.w	$000E,$0016,$0164
		dc.w	$0013,$0014,$018C
		dc.w	$001A,$0014,$01B3

		dc.w	$000D,$0018,$0100
		dc.w	$000C,$0018,$0120
		dc.w	$000D,$0018,$0144
		dc.w	$000F,$0018,$0164
		dc.w	$0013,$0018,$0187
		dc.w	$0017,$0018,$01A9

SSRLR06_A:	dc.w	                     $00FE, $00FF, $0000, $0001
		dc.w	                     $FFFE, $FFFF, $FF00, $FF01
		dc.w	              $FEFD, $FEFE, $FEFF, $FE00, $FE01, $FE02
		dc.w	       $FDFC, $FDFD, $FDFE, $FDFF, $FD00, $FD01, $FD02
		dc.w	$FCFB, $FCFC, $FCFD, $FCFE, $FCFF, $FC00, $FC01, $FC02, $FC03
		dc.w	$FBFB, $FBFC, $FBFD, $FBFE, $FBFF, $FB00, $FB01, $FB02, $FB03
		dc.w	                     $FAFE, $FAFF, $FA00, $FA01, $FA02, $FA03

SSRLR06_B:	dc.w	                     $FE00, $FF00, $0000, $0100
		dc.w	                     $FE01, $FF01, $0001, $0101
		dc.w	              $FD02, $FE02, $FF02, $0002, $0102, $0202
		dc.w	       $FC03, $FD03, $FE03, $FF03, $0003, $0103, $0203
		dc.w	$FB04, $FC04, $FD04, $FE04, $FF04, $0004, $0104, $0204, $0304
		dc.w	$FB05, $FC05, $FD05, $FE05, $FF05, $0005, $0105, $0205, $0305
		dc.w	                     $FE06, $FF06, $0006, $0106, $0206, $0306

SSRLR06_C:	dc.w	                     $0002, $0001, $0000, $00FF
		dc.w	                     $0102, $0101, $0100, $01FF
		dc.w	              $0203, $0202, $0201, $0200, $02FF, $02FE
		dc.w	       $0304, $0303, $0302, $0301, $0300, $03FF, $03FE
		dc.w	$0405, $0404, $0403, $0402, $0401, $0400, $04FF, $04FE, $04FD
		dc.w	$0505, $0504, $0503, $0502, $0501, $0500, $05FF, $05FE, $05FD
		dc.w	                     $0602, $0601, $0600, $06FF, $06FE, $06FD

SSRLR06_D:	dc.w	                     $0200, $0100, $0000, $FF00
		dc.w	                     $02FF, $01FF, $00FF, $FFFF
		dc.w	              $03FE, $02FE, $01FE, $00FE, $FFFE, $FEFE
		dc.w	       $04FD, $03FD, $02FD, $01FD, $00FD, $FFFD, $FEFD
		dc.w	$05FC, $04FC, $03FC, $02FC, $01FC, $00FC, $FFFC, $FEFC, $FDFC
		dc.w	$05FB, $04FB, $03FB, $02FB, $01FB, $00FB, $FFFB, $FEFB, $FDFB
		dc.w	                     $02FA, $01FA, $00FA, $FFFA, $FEFA, $FDFA

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to render player art using correct scale
; ---------------------------------------------------------------------------

SSPA_PosArray:	dc.b	$FF,$FF,$FF,$FF,$00,$00,$00,$FF,$FF,$FF,$FF,  $FF,$FF,$FF,$FF,$FF
		dc.b	$FF,$FF,$FF,$00,$00,$00,$00,$00,$FF,$FF,$FF,  $FF,$FF,$FF,$FF,$FF
		dc.b	$FF,$FF,$FF,$00,$00,$00,$00,$00,$FF,$FF,$FF,  $FF,$FF,$FF,$FF,$FF
		dc.b	$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,  $FF,$FF,$FF,$FF,$FF
		dc.b	$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,  $FF,$FF,$FF,$FF,$FF
		dc.b	$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FF,  $FF,$FF,$FF,$FF,$FF
		dc.b	$FF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FF,  $FF,$FF,$FF,$FF,$FF
		dc.b	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,  $FF,$FF,$FF,$FF,$FF

SS_PlayerArt:
		tst.b	(ESS_StageMode).w			; is the game mode a shared game?
		bmi.w	SSPA_OutOfScreen			; if not, branch
		lea	SSPA_PosArray+$05(pc),a0		; load position array
		lea	(ESS_P1_Floor).w,a1			; load player 1's floor details
		lea	(ESS_P2_Floor).w,a2			; load player 2's floor details

		moveq	#$1F,d1

		move.b	ESS_Direction(a1),d0			; load player 1's direction
		andi.w	#$0006,d0				; get only the direction
		move.w	SSPA_Angles(pc,d0.w),d0			; load correct routine
		jmp	SSPA_Angles(pc,d0.w)			; run correct routine for direction/angle

	; --- Direction list ---

SSPA_Angles:	dc.w	SSPA_FaceUp-SSPA_Angles			; 0 - Facing upwards
		dc.w	SSPA_FaceRight-SSPA_Angles		; 2 - Facing right
		dc.w	SSPA_FaceDown-SSPA_Angles		; 4 - Facing down
		dc.w	SSPA_FaceLeft-SSPA_Angles		; 6 - Facing left

	; --- When facing north of the layout ---

SSPA_FaceUp:
		move.b	ESS_LayoutY(a1),d3			; load Y position
		sub.b	ESS_LayoutY(a2),d3			; get Y distance between players
		addq.b	#$01,d3					; take lowest layout into account
		and.w	d1,d3					; keep within the layout
		cmpi.b	#$06+1,d3				; is the player out of range?
		bhi.s	SSPA_OutOfScreen			; if so, branch

		move.b	ESS_LayoutX(a2),d2			; load X position
		sub.b	ESS_LayoutX(a1),d2			; get X distance between players
		bra.s	SSPA_CheckX				; continue to check X

	; --- When facing east of the layout ---

SSPA_FaceRight:
		move.b	ESS_LayoutX(a2),d3			; load X position
		sub.b	ESS_LayoutX(a1),d3			; get X distance between players
		addq.b	#$01,d3					; take lowest layout into account
		and.w	d1,d3					; keep within the layout
		cmpi.b	#$06+1,d3				; is the player out of range?
		bhi.s	SSPA_OutOfScreen			; if so, branch

		move.b	ESS_LayoutY(a2),d2			; load Y position
		sub.b	ESS_LayoutY(a1),d2			; get Y distance between players
		bra.s	SSPA_CheckX				; continue to check X

	; --- When facing south of the layout ---

SSPA_FaceDown:
		move.b	ESS_LayoutY(a2),d3			; load Y position
		sub.b	ESS_LayoutY(a1),d3			; get Y distance between players
		addq.b	#$01,d3					; take lowest layout into account
		and.w	d1,d3					; keep within the layout
		cmpi.b	#$06+1,d3				; is the player out of range?
		bhi.s	SSPA_OutOfScreen			; if so, branch

		move.b	ESS_LayoutX(a1),d2			; load X position
		sub.b	ESS_LayoutX(a2),d2			; get X distance between players
		bra.s	SSPA_CheckX				; continue to check X

SSPA_OutOfScreen:
		st.b	ESS_SpriteD(a1)				; set no sprite display
		rts						; return

	; --- When facing west of the layout ---

SSPA_FaceLeft:
		move.b	ESS_LayoutX(a1),d3			; load X position
		sub.b	ESS_LayoutX(a2),d3			; get X distance between players
		addq.b	#$01,d3					; take lowest layout into account
		and.w	d1,d3					; keep within the layout
		cmpi.b	#$06+1,d3				; is the player out of range?
		bhi.s	SSPA_OutOfScreen			; if so, branch

		move.b	ESS_LayoutY(a1),d2			; load Y position
		sub.b	ESS_LayoutY(a2),d2			; get Y distance between players

SSPA_CheckX:
		addq.b	#$05,d2					; take left side into account
		and.w	d1,d2					; keep within the layout
		cmpi.b	#$05*2,d2				; is the player out of range?
		bhi.s	SSPA_OutOfScreen			; if so, branch
		subq.w	#$05,d2					; restore to central

; ---------------------------------------------------------------------------
; If the other player is in range
; ---------------------------------------------------------------------------

SSPA_ProcessDisplay:

	; d2 = steps on screen from left to right
	; d3 = steps away from player on Y axis

		move.w	d3,d0					; copy Y to d0
		lsl.w	#$04,d0					; multiply Y by 10 (size of X)
		add.w	d2,d0					; fuse together
		tst.b	(a0,d0.w)				; check correcct slot
		bmi.s	SSPA_OutOfScreen			; if the player is out of the screen, branch
		move.w	ESS_FloorPos(a2),d0			; load floor position
		andi.w	#$0700,d0				; get only within a squares' position
		lsr.w	#$03,d0					; align with MSB of byte
		ext.w	d0					; extend sign
		asr.b	#$05,d0					; align correctly
		lsl.w	#$03,d2					; align X and Y correctly
		lsl.w	#$03,d3					; ''
		move.b	ESS_Direction(a2),d1			; load other player's direction
		sub.b	ESS_Direction(a1),d1			; minus current player's direction (given position is relative to current player)
		andi.w	#$0006,d1				; get only the angle
		roxr.b	#$03,d1					; shift bits to MSB and carry
		bcc.s	SSPA_NoOpposite				; if the opposite direction bit is clear, branch
		neg.w	d0					; reverse adding direction
		tst.b	d1					; recheck MSB

SSPA_NoOpposite:
		bpl.s	SSPA_Vertical				; if we're moving vertically, branch
		add.w	d0,d2					; add floor position to horizontal position
		bra.s	SSPA_CalcPos				; continue to calculate the correct position

SSPA_Vertical:
		add.w	d0,d3					; add floor position to vertical position

SSPA_CalcPos:
		move.w	ESS_FloorPos(a1),d1			; load player 1's floor position
		andi.w	#$0700,d1				; get only within a squares' position
		lsr.w	#$03,d1					; align with MSB of byte
		ext.w	d1					; extend sign
		asr.b	#$05,d1					; align correctly
		sub.w	d1,d3					; subtract from opponent's Y position
		bmi.s	SSPA_OutOfScreen			; if the Y position is off-screen, branch
		sf.b	ESS_SpriteD(a1)				; allow sprite to display

	; --- Calculating the correct position on-screen ---

		move.w	d3,d0					; load Y position
		add.w	d0,d0					; multiply by size of word now
		lea	(SSPA_PosY+$01).l,a0			; load Y table lists
		move.w	+$7F(a0,d0.w),ESS_SpriteP(a1)		; load correct priority (high/low) (and load the link ID
		move.w	-$01(a0,d0.w),d1			; load correct Y position on-floor
		lea	(SSPA_PosX+$01).l,a0			; load X table lists
		muls.w	-$01(a0,d0.w),d2			; multiply X position by the adjustment (curve of the world)
		asr.l	#$07,d2					; divide by 10 (and by another 8 as there's 8 steps in every square)
		move.w	d2,ESS_SpriteX(a1)			; save as X position
		bpl.s	SSPA_NoNeg				; if the X position is positive (on the right side of the world), branch
		neg.w	d2					; it must be on the left (negative) so force it to positive

SSPA_NoNeg:
		add.w	d2,d2					; multiply by size of word for table
		move.w	+$7F(a0,d2.w),d3			; load correct Y adjustment for curving the Y based on the X position
		move.w	d1,d4					; load Y position
		subi.w	#103,d4					; reverse it (but take the -18 into account)
		neg.w	d4					; ''
		mulu.w	d4,d3					; multiply the Y adjustment by the sprite's current Y position on-floor
;	divu.w	#103+18,d3				; divide by maximum amount (when player is at the top)
	lsr.l	#$07,d3					; divide by 80 (maximum is 79 which is close enough, and this is quicker than divu)
		add.w	d3,d1					; adjust the Y position to curve down
		move.w	d1,ESS_SpriteY(a1)			; save as Y position
		add.w	d0,d0					; multiply Y position to size of long-word
		lea	(SBSS_List).l,a0			; load list
		moveq	#$00,d1					; clear d1
		move.b	(a0,d0.w),d1				; load scaling amount
		move.l	(a0,d0.w),a0				; load art address to display/scale
		lea	(ESS_P1_ScaleArt).l,a1			; destination
		moveq	#$00,d0					; clear d0
		move.l	#$00FFFFFF,d2				; prepare first byte clear
		move.l	#$FF00FFFF,d3				; prepare second byte clear
		move.w	#$00FF,d4				; prepare third byte clear
		move.l	ScaleList(pc,d1.w),a2			; load correct scale routine
		jmp	(a2)					; run correct scale routine

; ---------------------------------------------------------------------------
; Scale list code
; ---------------------------------------------------------------------------
; ScaleList:
		include "Special Stage\Scale List.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Art Y scaling list
; ---------------------------------------------------------------------------

	; --- X curve adjustments ---
	; As they move vertically down/up the world, the X position
	; away from the centre should expand/contract depending on
	; Y position.
	; ---------------------------

SSPA_PosX:	dc.w	135*$10, 130*$10, 126*$10, 121*$10, 116*$10, 111*$10, 107*$10, 103*$10
		dc.w	100*$10,  96*$10,  94*$10,  90*$10,  87*$10,  85*$10,  83*$10,  80*$10
		dc.w	 78*$10,  76*$10,  74*$10,  72*$10,  70*$10,  68*$10,  66*$10,  64*$10
		dc.w	 63*$10,  62*$10,  60*$10,  58*$10,  57*$10,  56*$10,  55*$10,  54*$10
		dc.w	 53*$10,  52*$10,  50*$10,  49*$10,  48*$10,  47*$10,  47*$10,  46*$10
		dc.w	 46*$10,  44*$10,  43*$10,  42*$10,  41*$10,  40*$10,  39*$10,  39*$10
		dc.w	 38*$10,  38*$10,  37*$10,  36*$10,  36*$10,  35*$10,  34*$10,  34*$10
		dc.w	 33*$10,  33*$10,  32*$10,  32*$10,  31*$10,  31*$10,  31*$10,  30*$10

	; --- Y curve adjustments ---
	; As they move horizontally along the world, the Y position
	; should change and curve down.
	; ---------------------------

SSPA_ReposY:	dc.w	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		dc.w	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		dc.w	  0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1
		dc.w	  1,  1,  1,  1,  1,  1,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2
		dc.w	  2,  2,  2,  2,  2,  2,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3
		dc.w	  3,  3,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4
		dc.w	  4,  5,  5,  5,  5,  5,  5,  5,  5,  5,  6,  6,  6,  6,  6,  6
		dc.w	  6,  6,  6,  7,  7,  7,  7,  7,  7,  7,  8,  8,  8,  8,  8,  9
		dc.w      9,  9,  9,  9, 10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11
		dc.w	 11, 11, 12, 12, 12, 12, 12, 12, 13, 13, 13, 13, 13, 13, 14, 14

		dc.w	 14, 14, 14, 14, 15, 15, 15, 15, 16, 16, 16, 16, 16, 17, 17, 17	; <- Some overflow values (just in-case the sprite happens to spill over)

	; Old positions....
	;	dc.w	  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	;	dc.w	  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1
	;	dc.w	  1,  1,  1,  1,  1,  1,  1,  1,  2,  2,  2,  2,  2,  2,  2,  2
	;	dc.w	  2,  2,  2,  2,  2,  2,  2,  2,  3,  3,  3,  3,  3,  3,  3,  3
	;	dc.w	  3,  3,  3,  3,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  5
	;	dc.w	  5,  5,  5,  5,  5,  5,  5,  5,  6,  6,  6,  6,  6,  6,  6,  6
	;	dc.w	  6,  8,  8,  8,  8,  8,  8,  8,  8,  9,  9,  9,  9,  9,  9,  9
	;	dc.w	  9, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 12, 12
	;	dc.w	 12, 12, 12, 12, 13, 13, 13, 13, 13, 13, 14, 14, 14, 14, 14, 15
	;	dc.w	 15, 15, 15, 15, 15, 16, 16, 16, 16, 16, 17, 17, 17, 17, 17, 18

	; --- The actual Y conversion ---
	; The raw Y relative position away from the player is
	; converted into screen Y position, this is the table for
	; the exact Y positions (on centre) along vertically.
	; -------------------------------

SSPA_PosY:	dc.w	103,  96,  89,  81,  74,  67,  60,  54
		dc.w	 48,  43,  39,  34,  30,  26,  23,  19
		dc.w	 16,  13,  11,   8,   6,   4,   2,   0
		dc.w	 -2,  -3,  -5,  -6,  -7,  -8,  -9, -10
		dc.w	-11, -12, -13, -14, -14, -15, -15, -16
		dc.w	-16, -17, -17, -17, -18, -18, -18, -17
		dc.w	-17, -17, -16, -16, -15, -15, -14, -13
		dc.w	-12, -11, -10,  -9,  -8,  -7,  -6,  -5

	; --- Plane/priority ---
	; Whether or not the sprite is high plane (infront of the
	; world) or low plane (behind it), the second byte is sprite
	; priority/line so the player can display behind specific spheres
	; ----------------------

SSPA_Plane:	dc.w	$8000, $8000, $8000, $8000, $8000, $8000, $8000, $8000
		dc.w	$8001, $8001, $8001, $8001, $8001, $8001, $8001, $8001
		dc.w	$8002, $8002, $8002, $8002, $8002, $8002, $8002, $8002
		dc.w	$8003, $8003, $8003, $8003, $8003, $8003, $8003, $8003
		dc.w	$8004, $8004, $8004, $8004, $8004, $8004, $8004, $8004
		dc.w	$8005, $8005, $8005, $8005, $0005, $0005, $0005, $0005
		dc.w	$0006, $0006, $0006, $0006, $0006, $0006, $0006, $0006
		dc.w	$0007, $0007, $0007, $0007, $0007, $0007, $0007, $0007

SBSS_List:	dc.l	($00<<$1A)|SP_ArtScaSon1, ($00<<$1A)|SP_ArtScaSon1, ($01<<$1A)|SP_ArtScaSon1, ($01<<$1A)|SP_ArtScaSon1, ($02<<$1A)|SP_ArtScaSon1, ($02<<$1A)|SP_ArtScaSon1, ($03<<$1A)|SP_ArtScaSon1, ($03<<$1A)|SP_ArtScaSon1
		dc.l	($04<<$1A)|SP_ArtScaSon1, ($04<<$1A)|SP_ArtScaSon1, ($05<<$1A)|SP_ArtScaSon1, ($05<<$1A)|SP_ArtScaSon1, ($06<<$1A)|SP_ArtScaSon1, ($06<<$1A)|SP_ArtScaSon1, ($07<<$1A)|SP_ArtScaSon1, ($07<<$1A)|SP_ArtScaSon1
		dc.l	($00<<$1A)|SP_ArtScaSon2, ($00<<$1A)|SP_ArtScaSon2, ($01<<$1A)|SP_ArtScaSon2, ($01<<$1A)|SP_ArtScaSon2, ($02<<$1A)|SP_ArtScaSon2, ($02<<$1A)|SP_ArtScaSon2, ($03<<$1A)|SP_ArtScaSon2, ($03<<$1A)|SP_ArtScaSon2
		dc.l	($04<<$1A)|SP_ArtScaSon2, ($04<<$1A)|SP_ArtScaSon2, ($05<<$1A)|SP_ArtScaSon2, ($05<<$1A)|SP_ArtScaSon2, ($06<<$1A)|SP_ArtScaSon2, ($06<<$1A)|SP_ArtScaSon2, ($07<<$1A)|SP_ArtScaSon2, ($07<<$1A)|SP_ArtScaSon2
		dc.l	($00<<$1A)|SP_ArtScaSon3, ($00<<$1A)|SP_ArtScaSon3, ($01<<$1A)|SP_ArtScaSon3, ($01<<$1A)|SP_ArtScaSon3, ($02<<$1A)|SP_ArtScaSon3, ($02<<$1A)|SP_ArtScaSon3, ($03<<$1A)|SP_ArtScaSon3, ($03<<$1A)|SP_ArtScaSon3
		dc.l	($04<<$1A)|SP_ArtScaSon3, ($04<<$1A)|SP_ArtScaSon3, ($05<<$1A)|SP_ArtScaSon3, ($05<<$1A)|SP_ArtScaSon3, ($06<<$1A)|SP_ArtScaSon3, ($06<<$1A)|SP_ArtScaSon3, ($07<<$1A)|SP_ArtScaSon3, ($07<<$1A)|SP_ArtScaSon3
		dc.l	($00<<$1A)|SP_ArtScaSon4, ($00<<$1A)|SP_ArtScaSon4, ($01<<$1A)|SP_ArtScaSon4, ($01<<$1A)|SP_ArtScaSon4, ($02<<$1A)|SP_ArtScaSon4, ($02<<$1A)|SP_ArtScaSon4, ($03<<$1A)|SP_ArtScaSon4, ($03<<$1A)|SP_ArtScaSon4
		dc.l	($04<<$1A)|SP_ArtScaSon4, ($04<<$1A)|SP_ArtScaSon4, ($05<<$1A)|SP_ArtScaSon4, ($05<<$1A)|SP_ArtScaSon4, ($06<<$1A)|SP_ArtScaSon4, ($06<<$1A)|SP_ArtScaSon4, ($07<<$1A)|SP_ArtScaSon4, ($07<<$1A)|SP_ArtScaSon4

; ===========================================================================
; ---------------------------------------------------------------------------
; Includes
; ---------------------------------------------------------------------------

SP_Palette:	dc.w	$0000,$0222,$0666,$0AAA,$0ECC,$0EEE,$064E,$000E,$0008,$0004,$0EEC,$0000,$0000,$0000,$0000,$0000
		dc.w	$0000,$0000,$0EEE,$0820,$0E42,$0EA4,$0666,$0AAA,$0ECC,$006A,$00AE,$00EE,$0008,$000E
SP_Palette_End:
SP_ArtFloor:	binclude "Special Stage\Art Floor.kosm"
		even
SP_MapFloor:	binclude "Special Stage\Map Floor.eni"
		even
SP_ArtBG:	binclude "Special Stage\Art Background.kosm"
		even
SP_MapBG:	binclude "Special Stage\Map Background.mun"
		even

SP_ArtDebug:	binclude "Special Stage\Art Debug.kosm"
		even

SP_ArtSpheres:	binclude "Special Stage\Art Spheres.kosm"
		even
SP_ArtShadows:	binclude "Special Stage\Art Shadows.kosm"
		even
SP_ArtRings:	binclude "Special Stage\Art Rings.kosm"
		even

SP_ArtScaSon1:	binclude "Special Stage\Scale Art\Temp 1.bin"
SP_ArtScaSon2:	binclude "Special Stage\Scale Art\Temp 2.bin"
SP_ArtScaSon3:	binclude "Special Stage\Scale Art\Temp 3.bin"
SP_ArtScaSon4:	binclude "Special Stage\Scale Art\Temp 4.bin"
SP_ArtScaTai1:	binclude "Special Stage\Scale Art\Temp 5.bin"
		even

SP_Stages:	binclude "Special Stage\Layouts\Layouts.bin"
		even

; ===========================================================================


























