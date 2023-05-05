; CREDITS
; betatesting
; Vladikcomper
; Djohe
; DiscoTheBat
; TheRoboticOverlord
; TheStoneBanana
; NeoFusionBox
;
; Music
; S_T_D
; ElectroBall
; DalekSam
; Vladikcomper

; Equates used in Sonic Green Snake
Beta_build = 0
Cheats = 0

; BCC = BHS
; BCS = BLO

	opt l+
	opt op+
	opt os+
	opt ow+
	opt oz+
	opt oaq+
	opt osq+
	opt ae-
	opt d+

; Object specific equates ; Sonic Green Snake custom
	rsset	0
ID		rs.b 1		 ; Maybe later upgraded to S3K system with one longword, but atm it'=\1s Sonic 1'=\1s normal ; 1
Render_Flags	rs.b 1	; $2A
Art_Tile	rs.w 1	; $28
Mappings_Offset	rs.l 1	; 4
X_pos		rs.w 1
X_pos2		rs.w 1
Y_Pos		rs.w 1
Y_Pos2		rs.w 1
X_Vel		rs.w 1
Y_Vel		rs.w 1
Inertia		rs.w 1	; $14
Y_Radius	rs.b 1
X_Radius	rs.b 1
Priority	rs.w 1	; $18
Anim_Frame	rs.b 1	; $1A
Anim_scriptNum	rs.b 1
Anim		rs.b 1
Anim_Restart	rs.b 1
Anim_Dur	rs.b 1
X_Visible	rs.b 1	; $1F
Coll		rs.b 1
Coll2		rs.b 1
Status		rs.b 1
Respawn		rs.b 1	; $23
Routine		rs.b 1
Routine2	rs.b 1
Angle		rs.w 1
Subtype		rs.b 1	; $2B
Off29		rs.b 1
Off2A		rs.b 1
Off2B		rs.b 1
Off2C		rs.b 1
Off2D		rs.b 1
Off2E		rs.b 1
Off2F		rs.b 1
Off30		rs.b 1
Off31		rs.b 1
Off32		rs.b 1
Off33		rs.b 1
Off34		rs.b 1
Off35		rs.b 1
Off36		rs.b 1
Off37		rs.b 1
Off38		rs.b 1
Off39		rs.b 1
Off3A		rs.b 1
Off3B		rs.b 1
Off3C		rs.b 1
Off3D		rs.b 1
Off3E		rs.b 1
Off3F		rs.b 1
Next_Obj	rs.w 1

ChkNext_Obj	macro	asd
	if	Next_Obj=$40
	else
	inform 1,"Next_Obj is $\$Next_Obj"
	endif
	endm

; boss specific variables
Boss_X	equ Off30
Boss_Y	equ Off38

; Xeno and S2HG specific equates
mappings		equ	Mappings_Offset
x_pixel			equ	x_pos
X_Sub			equ	x_pos2
y_pixel			equ	x_pos2
Y_Sub			equ	Y_pos2
mapping_frame		equ	Anim_Frame
next_anim		equ	Anim_Restart
anim_frame_duration	equ	Anim_Dur
width_pixels		equ	X_Visible
collision_flags		equ	Coll
collision_property	equ	Coll2
respawn_index		equ	respawn
routine_secondary	equ	routine2
stick_to_convex		equ	Off38; 1
spindash_counter	equ	Off3A; 2(?)
jumping			equ	Off3C;1
interact		equ	Off3D; 1

; S1HG specific equates
obMap		equ	Mappings_Offset
obX		equ	X_Pos
obScreenY	equ	X_Pos2
obY		equ	Y_Pos
obVelX		equ	X_Vel
obVelY		equ	Y_Vel
obInertia	equ	Inertia
obHeight	equ	Y_Radius
obWidth		equ	X_Radius
obPriority	equ	Priority
obFrame		equ	Anim_Frame
obAniFrame	equ	Anim_scriptNum
obAnim		equ	Anim
obNextAni	equ	Anim_Restart
obTimeFrame	equ	Anim_Dur
obActWid	equ	X_Visible
obColType	equ	Coll
obColProp	equ	Coll2
obStatus	equ	Status
obRespawnNo	equ	Respawn
obRoutine	equ	Routine
ob2ndRout	equ	Routine2
obAngle		equ	Angle
obGfx		equ	Art_Tile
obRender	equ	Render_Flags
obSubtype	equ	Subtype

; equates used in obj34 (and some other situations)
Act_Count       equ 8; includes "ACT NO"
Zone_Count      equ 6; does not include Final Zone nor ending sequence
Misc_Data_count equ 4; everything but act or zone data (But includes Final Zone)
GHZ_DPLC        equ Act_Count+Misc_Data_count+2; +2 is fix for DPLC information
SBZ_DPLC        equ Act_Count+Misc_Data_count+7; 7 is the amount of DPLC'=\1s from GHZ DPLC entry to SBZ DPLC entry plus 2
Misc_PLC	equ 20; amount of miscellaneous PLC'=\1s before Zone plc'=\1s
CharacterCount	equ 3
RingAttract_X	equ $80
RingAttract_Y	equ $40
RiAt_XMul	equ $30
RiAt_YMul	equ $30
JumpBtns	equ $30
CharBtn		equ $40

; equates for Sonic'=\1s speed on different situations
Speed_Normal		equ $634
Acc_Normal		equ $C
Dec_Normal		equ $80

Speed_Shoes		equ (Speed_Normal*2)
Acc_Shoes		equ (Acc_Normal*2)
Dec_Shoes		equ Dec_Normal

Speed_UW		equ (Speed_Normal/2)
Acc_UW			equ (Acc_Normal/2)
Dec_UW			equ (Dec_Normal/2)

Speed_UW_Sho		equ $528
ACC_UW_Sho		equ $A
Dec_UW_Sho		equ $69

; definitions for music
Sfx_fade		equ $E0

; Definitions for $D000-$D800
; Normal level
Object_RAM		equ $FFFFD000; Mostly used for Sonic object
Hud_RAM			equ $FFFFD040
TimeOverRAM
GameOverRAM
Ttlcard_RAM		equ $FFFFD080; 4 slots
; -Free-		equ $FFFFD180
SpinDust_RAM		equ $FFFFD1C0
InvinStars_RAM		equ $FFFFD200; also $FFFFD240
Shield_RAM		equ $FFFFD280
Splash_RAM		equ $FFFFD300
Bubbles_RAM		equ $FFFFD340
Tails_Tail_RAM		equ $FFFFD380
Object_RAM_Free		equ $FFFFD800
Object_RAM_End		equ $FFFFF000

; special object variables
Shield_Type		equ Shield_RAM+Coll2
Shield_Type_obj		equ Shield_Type-Shield_RAM
Shield_ArtLoc		equ Shield_RAM+Off34
Shield_ArtLoc_obj	equ Shield_ArtLoc-Shield_RAM
Shield_DPLCLoc		equ Shield_RAM+Off38
Shield_DPLCLoc_obj	equ Shield_DPLCLoc-Shield_RAM
Shield_AniLoc		equ Shield_RAM+Off3C
Shield_AniLoc_obj	equ Shield_AniLoc-Shield_RAM
Shield_UseType		equ Shield_RAM+Angle
Shield_UseType_obj	equ Shield_UseType-Shield_RAM

ElMenSld_NegList	macro	; list of objects getting negated by elemetal shields
		dc.b $20,$FE, $23,$FE, $62,6, $5F,6, $1F,8, $60,6, $7B,$A, $FF
		even
			endm
; Misc stuff - Might come useful later
; VDP addressses
VDP_Data_Port		equ $C00000
VDP_Control_Port	equ $C00004
VDP_Counter		equ $C00008

psg_input		equ $C00011

; Z80 addresses
z80_ram			equ $A00000	; start of Z80 RAM
z80_dac3_pitch		equ $A000EA
z80_dac_status		equ $A01FFD
z80_dac_sample		equ $A01FFF
z80_ram_end		equ $A02000	; end of non-reserved Z80 RAM
z80_version		equ $A10001
z80_port_1_data		equ $A10002
z80_port_1_control	equ $A10008
z80_port_2_contro	equ $A1000A
z80_expansion_control	equ $A1000C
z80_bus_request		equ $A11100
z80_reset		equ $A11200
ym2612_a0		equ $A04000
ym2612_d0		equ $A04001
ym2612_a1 		equ $A04002
ym2612_d1		equ $A04003

security_addr		equ $A14000

; RAM equates for $8400 - $A7FF
CompDec_RAM		equ $FFFF8400
CompDec_RAM_End		equ $FFFF8A00-1
DMA_Buffer_Start	equ $FFFFA400-2	; the start address of DMA buffer for uncompressed art
DMA_Buffer_End		equ $FFFFA800-4	; the end address of DMA buffer for uncompressed art
CompDec_Size		equ CompDec_RAM_End-CompDec_RAM+1	; 600 bytes
FZ2_Boss_VScroll	equ CompDec_RAM_End+11

; RAM equates for $C800 - $CAFF
Palette_Mods		equ $FFFFC800	; palette modification array
Palette_ModsEnd		equ Palette_Mods+(2*16); palette modification array end
Palette_ModsSize	equ (Palette_ModsEnd-Palette_Mods)/2; the size of the palette mod array
VScroll_RAM		equ Palette_ModsEnd+2	; Vertical Scroll RAM	; $50 bytes

FZ2_Boss_VScrollSize	equ (FZ_Boss_Pos_Right-FZ2_Boss_Pos_Left)/16
FZ2_Boss_VScrollMove	equ VScroll_RAM
FZ2_Boss_VScrollTimers	equ FZ2_Boss_VScrollMove+FZ2_Boss_VScrollSize
FZ2_Boss_VScrollFinal	equ FZ2_Boss_VScrollTimers+FZ2_Boss_VScrollSize

DMAQueueMode		equ $FFFFCB00-20
VBlankJump		equ $FFFFCB00-16
HBlankJump		equ $FFFFCB00-10

; RAM equates for $FA00 - $FC00
Palette_UTarget		equ $FFFFFA00
Palette_NTarget		equ $FFFFFA80
Palette_NCurr		equ $FFFFFB00
Palette_UCurr		equ $FFFFFB80
DestroyTable		equ $FFFFFC00

; RAM equates for $FF00 - $FF0F	; NOTE: Will be cleared each time level inits
Turbomode_flag		equ $FFFFFF00
FZ_Boss_Tracking	equ CompDec_RAM		; tracking array for FZ boss turrets ; $400 bytes
FZ_Boss_TrackPos	equ VScroll_StartX	; offset of reading from Tracking position
; RAM equates for $FF14 - $FF17
; seems not to work for whatever reason
; RAM equates for $FF38 - $FF7F ; NOTE: Will be cleared each time level inits
Title_FlipAniMask	equ $FFFFFF3E
Title_FrameCount	equ $FFFFFF40
Title_screen_option	equ $FFFFFF43
Sound_test_sound	equ $FFFFFF44
LevSel_MoveTimer	equ $FFFFFF46
LevSel_Pos		equ $FFFFFF48

Spindash_HorizDelay	equ $FFFFFF38; 2 bytes ; Horizontal camera delay
If_Spindash		equ $FFFFFF3A; flag to test if spindashing
Spindash_SoundPitch	equ $FFFFFF3B; flag to do with pitch settings for spindash sound
Spindash_StorePitch	equ $FFFFFF3C; stores pitch for spindash sound
Spindash_SoundTimer	equ $FFFFFF3D; timer for the sound reset
Spindash_ChangeCnt	equ $FFFFFF3E; Vertical scroll delay
Player_DJ_Data		equ $FFFFFF40; 4 bytes ; free RAM space for doublejump variables
Player_DoubleJump	equ $FFFFFF43; players doublejump flag
Sonic_ForceRollMode	equ $FFFFFF44; if set, will force Sonic to roll
PeelOut_Flag		equ $FFFFFF46; if Sonic is performing speelout (also timer for it)
Extcam_pos		equ $FFFFFF47; position of extended camera from the screen
Path_ID			equ $FFFFFF48; Path swappers path ID
Glide_AnimHandler	equ $FFFFFF49; animation handler flag for Knuckles'=\1 glide
GlidingCollTimer	equ $FFFFFF4A; timer to check if Sonic is colliding with objects
FastInvis		equ $FFFFFF4B; If Sonic is going fast enough give him full invinciblity
Player_SpecTouAni	equ $FFFFFF4C; 2 bytes ; special animation to allow destroying badniks with	; mainly used with Knuckles'=\1 Glide move
CollIndx1		equ $FFFFFF50
CollIndx2		equ $FFFFFF54
ShakeOffset		equ $FFFFFF58; 2 bytes ; offset of screen shake
ShakeOffset_Prev	equ $FFFFFF5A; 2 bytes ; offset of screen shake for previous frame
ShakeOffset_Mode	equ $FFFFFF5C; 2 bytes ; mode to use for Screen Shake

Dirty_flag		equ $FFFFFF7B; if set, reloads whole screen (happens on next reload session, opposed to immediately with 'LoadTilesFromStart')
VScroll_StartX		equ $FFFFFF7C; 2 bytes ; Vertical scroll offset used by GHZ 2 rolling code
VScroll_Offset		equ $FFFFFF7E; 2 bytes ; offset of rolling positions used by GHZ 2 rolling code

PlaneBY_Stored		equ VScroll_Offset

; RAM equates for $FF86 - $FFB7
Cred_SCRID		equ $FFFFFF86; 2 bytes ; pointer for offset of credits to load
Cred_MoveOff		equ $FFFFFF88; 2 bytes ; position where to scan if letters should start moving

LS_TextData		equ $FFFFFF86
LS_OffsetTable		equ $FFFFFF8A
LS_SpecialScreen	equ $FFFFFF8E
LS_ExtraRowData		equ $FFFFFF92
LS_HighLight		equ $FFFFFF96
LS_LSTable		equ $FFFFFF9A
LS_MaxSel		equ $FFFFFF9E
LS_HighLenght		equ $FFFFFF9F
LS_LineLenght		equ $FFFFFFA0

Coll_Pointer		equ $FFFFFF86; 12 bytes	; pointer for Zone'=\1s collision arrays and Anglemap file
Player_ArtLoc		equ $FFFFFF92; 4 bytes ; pointer for players art location (can also be used for special art if needed to ;) )
Player_MapLoc		equ $FFFFFF96; 4 bytes ; pointer for players mappings location (can be used for special mappings)
Player_DPLCLoc		equ $FFFFFF9A; 4 bytes ; pointer for players DPLC location (can be used for special DPLCs)
Player_AniDat		equ $FFFFFF9E; 4 bytes ; pointer for players animation data location (can be used for special anis)
PAni_Roll		equ $FFFFFFA2; 4 bytes ; pointer for players Roll animation
PAni_Roll2		equ $FFFFFFA6; 4 bytes ; pointer for players Roll animation
PAni_Push		equ $FFFFFFAA; 4 bytes ; pointer for players Push animation
Player_JumpHeight	equ $FFFFFFAE; 2 bytes ; player's jump height
Player_StandHeight	equ $FFFFFFB0; Sonic's y_Radius when standing
Player_StandWidth	equ $FFFFFFB1; Sonic's x_Radius when standing
Player_RollHeight	equ $FFFFFFB2; Sonic's y_Radius when rolling
Player_RollWidth	equ $FFFFFFB3; Sonic's x_Radius when rolling

; RAM equates for $FFBC - $FFDF
Bought_Items		equ $FFFFFFBC; items you bought so far

Layout_Data		equ $FFFFFFC6; 4 bytes ; pointer for Layout FG
Layout_BG		equ $FFFFFFCA; 4 bytes ; pointer for Layout BG
Music_EnabledChans	equ $FFFFFFCE; enabled music tracks
Level_VBIRoutine	equ $FFFFFFD0
DefaultVBIRoutine	equ $FFFFFFD1; default VBlank routine to use for certain functions
Debug_Mode		equ $FFFFFFD2; Debug mode flag
Music_StoreChan		equ $FFFFFFD3; store channel when checking music updates
Music_StoreDAC		equ $FFFFFFD4; store channel when checking music updates
Sonic_Super 		equ $FFFFFFD5; whether or not Sonic is super or not
Freecycles 		equ $FFFFFFD6; free cycles in last V-int
Sonic_SuperFly 		equ $FFFFFFD8; whether or not Sonic is flying while super
DCL_Rings		equ $FFFFFFDC; amount of rings collected so far minus items bought ; you start with x rings
; RAM equates for $FFE8 - $FFE9
Music_RequestTypes	equ $FFFFFFE8; 0 = music is free to change if different to zone music, 1 = Cant change, 2 = change to "Music_StoreZoneID" if not equal to it
Music_StorePrevID	equ $FFFFFFE9; the music id currently playing is stored here

; RAM equates for $FFF5 - $FFFB
Music_StoreZoneID	equ $FFFFFFF5; Zone'=\1s (or special events) music id is stored here
Music_SpeedShoes	equ $FFFFFFF6; Handler for speedshoes music
Hacky_Mode		equ $FFFFFFF7; used by LZ6 boss
HW_Version		equ $FFFFFFF8; lists misc information about the hardware
Music_Updating		equ $FFFFFFF9; if SMPS driver is still running on 68k
Current_Character	equ $FFFFFFFA; whatever the character you are using is

; equates for gliding stuff
Gliding_Main		equ Player_DJ_Data+1
Gliding_2		equ Player_DJ_Data+2

; some other equates
DynWater_Off		equ $FFFFF622	; offset for dynamic water routine
Water_Array		equ $FFFFF62C	; negative = no water, positive = location for water array
VBlank_Routine		equ $FFFFF601
BossLives		equ $FFFFF62A
Emeralds		equ $FFFFFE57
BossMode		equ $FFFFFE09	; if set, boss mode is initiated

Start_Rings		equ 100		; amount of rings you start game with

; here is some variables used by SRAM checker
SRAM_Start		equ $200001

; macro which defines the SRAM versions array
SRAM_VerArray	macro			; inverted array (newest first)	; SGS V4 used 1 to determine we created the SRAM once
		dc.b SRAM_Version, $9A,1
		even
	endm
; ==========	SRAM MAP     ==========
	rsset	0
SRAM_Initver	rs.w 4			; If SRAM was initialized before, latest initialized version ('COCK')
SRAM_CheckSum	rs.w 2			; ROM checksum
SRAM_Sega	rs.w 4			; check 'SEGA'
		rs.w 50
SRAM_Char	rs.w 1			; The character you last had
SRAM_Lives	rs.w 1			; amount of lives you have
SRAM_GameCompl	rs.w 1			; whether or not game is completed
SRAM_LastLVL	rs.w 2			; The level you were last on
SRAM_Rings	rs.w 4			; all rings collected so far ; this will be used with buying DLC
SRAM_Items	rs.w 4			; items you unlocked with DLC rings
SRAM_Lenght	rs.w 0

SRAM_End	equ SRAM_Start+__rs	; end of SRAM space
; end of save slot space

; Table for Bought_Items bitfield
Bought_Knux		equ 0	; if Knuckles is unlocked
Bought_Tails		equ 1	; if Tails is unlocked
Bought_Shields		equ 2	; if shields are unlocked
Bought_LevSel		equ 3	; if level select is unlocked
Bought_SpinDash		equ 4	; if Spindash and Peelout is unlocked
Bought_AltMusic		equ 5	; if alternate music is unlocked
Bought_ExtCam		equ 6	; if extended camera is active
Bought_AirHorn		equ 7	; if ridiculous sfx is activated
Bought_Boobs		equ 8	; if boobies are bought
Used_Boobs		equ 26	; if boobies are in use
Used_AirHorn		equ 27	; if ridiculous sfx is used
Used_AltMusic		equ 28	; if alternate music is used
Bought_SaveSRAM 	equ 31	; if should save to SRAM

Music_LevelSelect	equ $FFFFFFE4+$02
Music_Invin		equ $FFFFFFE4+$0F
Music_Boss		equ $FFFFFFE4+$11
Music_TitleScreen	equ $FFFFFFE4+4
Music_CredNrom		equ $FFFFFFE4+$1A
Music_CredAlt		equ $FFFFFFE4+$12

DAC_NormSample		equ $1C

; Macro to test what items has been bought
buyTest	macro bit
	move.l	Bought_Items.w,d6
	btst	#bit,d6
	endm

; macro to fix header (used right after it)
headerfix	macro
	if Beta_build=0
		org    $132
  	  	dc.b	'=\1V 5.0'=\1
  	  	org    $162
  	  	dc.b	'=\1V 5.0'=\1
  	  	org    $200
else
                org    $132
  	  	dc.b	'=\15.0 BETA '=\1
		incbin	currentbuild.asm
  	  	org    $162
  	  	dc.b	'=\15.0 BETA '=\1
  	  	incbin	currentbuild.asm
  	  	org    $200
	endif
	endm


; Equates for SMPS2ASM

; Standard Octave Pitch Equates
; Standard Octave Pitch Equates
smpsPitch10lo		EQU	$88
smpsPitch09lo		EQU	$94
smpsPitch08lo		EQU	$A0
smpsPitch07lo		EQU	$AC
smpsPitch06lo		EQU	$B8
smpsPitch05lo		EQU	$C4
smpsPitch04lo		EQU	$D0
smpsPitch03lo		EQU	$DC
smpsPitch02lo		EQU	$E8
smpsPitch01lo		EQU	$F4
smpsPitch00		EQU	$00
smpsPitch01hi		EQU	$0C
smpsPitch02hi		EQU	$18
smpsPitch03hi		EQU	$24
smpsPitch04hi		EQU	$30
smpsPitch05hi		EQU	$3C
smpsPitch06hi		EQU	$48
smpsPitch07hi		EQU	$54
smpsPitch08hi		EQU	$60
smpsPitch09hi		EQU	$6C
smpsPitch10hi		EQU	$78

; Note Equates
nRst			EQU	$80
nC0			EQU	$81
nCs0			EQU	$82
nD0			EQU	$83
nEb0			EQU	$84
nE0			EQU	$85
nF0			EQU	$86
nFs0			EQU	$87
nG0			EQU	$88
nAb0			EQU	$89
nA0			EQU	$8A
nBb0			EQU	$8B
nB0			EQU	$8C
nC1			EQU	$8D
nCs1			EQU	$8E
nD1			EQU	$8F
nEb1			EQU	$90
nE1			EQU	$91
nF1			EQU	$92
nFs1			EQU	$93
nG1			EQU	$94
nAb1			EQU	$95
nA1			EQU	$96
nBb1			EQU	$97
nB1			EQU	$98
nC2			EQU	$99
nCs2			EQU	$9A
nD2			EQU	$9B
nEb2			EQU	$9C
nE2			EQU	$9D
nF2			EQU	$9E
nFs2			EQU	$9F
nG2			EQU	$A0
nAb2			EQU	$A1
nA2			EQU	$A2
nBb2			EQU	$A3
nB2			EQU	$A4
nC3			EQU	$A5
nCs3			EQU	$A6
nD3			EQU	$A7
nEb3			EQU	$A8
nE3			EQU	$A9
nF3			EQU	$AA
nFs3			EQU	$AB
nG3			EQU	$AC
nAb3			EQU	$AD
nA3			EQU	$AE
nBb3			EQU	$AF
nB3			EQU	$B0
nC4			EQU	$B1
nCs4			EQU	$B2
nD4			EQU	$B3
nEb4			EQU	$B4
nE4			EQU	$B5
nF4			EQU	$B6
nFs4			EQU	$B7
nG4			EQU	$B8
nAb4			EQU	$B9
nA4			EQU	$BA
nBb4			EQU	$BB
nB4			EQU	$BC
nC5			EQU	$BD
nCs5			EQU	$BE
nD5			EQU	$BF
nEb5			EQU	$C0
nE5			EQU	$C1
nF5			EQU	$C2
nFs5			EQU	$C3
nG5			EQU	$C4
nAb5			EQU	$C5
nA5			EQU	$C6
nBb5			EQU	$C7
nB5			EQU	$C8
nC6			EQU	$C9
nCs6			EQU	$CA
nD6			EQU	$CB
nEb6			EQU	$CC
nE6			EQU	$CD
nF6			EQU	$CE
nFs6			EQU	$CF
nG6			EQU	$D0
nAb6			EQU	$D1
nA6			EQU	$D2
nBb6			EQU	$D3
nB6			EQU	$D4
nC7			EQU	$D5
nCs7			EQU	$D6
nD7			EQU	$D7
nEb7			EQU	$D8
nE7			EQU	$D9
nF7			EQU	$DA
nFs7			EQU	$DB
nG7			EQU	$DC
nAb7			EQU	$DD
nA7			EQU	$DE
nBb7			EQU	$DF

; DAC Equates
dKick			EQU	$81
dSnare			EQU	$82
dTimpani		EQU	$83
dHiTimpani		EQU	$88
dMidTimpani		EQU	$89
dLowTimpani		EQU	$8A
dVLowTimpani		EQU	$8B

panNone set $00
panRight set $40
panLeft set $80
panCentre set $C0
panCenter set $C0 ; silly Americans :U
; Header Macros
; Header - Set up Voice Location
smpsHeaderVoice macro loc
songStart set *
	dc.w	loc-songStart
	endm
; Header - Set up Channel Usage
smpsHeaderChan macro fm,psg
	dc.b	fm,psg
	endm
; Header - Set up Tempo
smpsHeaderTempo macro div,mod
	dc.b	div,mod
	endm
; Header - Set up DAC Channel
smpsHeaderDAC macro loc
	dc.w	loc-songStart
	dc.w	$00
	endm
; Header - Set up FM Channel
smpsHeaderFM macro loc,pitch,vol
	dc.w	loc-songStart
	dc.b	pitch,vol
	endm
; Header - Set up PSG Channel
smpsHeaderPSG macro loc,pitch,vol,voice
	dc.w	loc-songStart
	dc.b	pitch,vol
	dc.w	voice
	endm

; Co-ord Flag Macros and Equates
; E0xx - Panning, AMS, FMS
smpsPan macro direction,amsfms
	dc.b $E0,direction+amsfms
	endm

; E1xx - Alter note values by xx
smpsAlterNote macro val
	dc.b	$E1,val
	endm

; E2xx - Unknown
smpsE2 macro val
	dc.b	$E2,val
	endm

; E3 - Return (generally used after F8)
smpsReturn macro val
	dc.b	$E3
	endm

; E4 - Fade in previous song (ie. 1-Up)
smpsFade macro val
	dc.b	$E4
	endm

; E5xx - Set channel tempo divider to xx
smpsChanTempoDiv macro val
	dc.b	$E5,val
	endm

; E6xx - Alter Volume by xx
smpsAlterVol macro val
	dc.b	$E6,val
	endm

; E7 - Prevent attack of next note
smpsNoAttack	EQU $E7

; E8xx - Set note fill to xx
smpsNoteFill macro val
	dc.b	$E8,val
	endm

; E9xx - Add xx to channel pitch
smpsAlterPitch macro val
	dc.b	$E9,val
	endm

; EAxx - Set music tempo modifier to xx
smpsSetTempoMod macro val
	dc.b	$EA,val
	endm

; EBxx - Set music tempo divider to xx
smpsSetTempoDiv macro val
	dc.b	$EB,val
	endm

; ECxx - Set Volume to xx
smpsSetVol macro val
	dc.b	$EC,val
	endm

; ED - Unknown
smpsED		EQU $ED

; EE - Unknown (Something to do with voice selection)
smpsEE 		EQU $EE

; EFxx - Set Voice of FM channel to xx
smpsFMvoice macro voice
	dc.b	$EF,voice
	endm

; F0wwxxyyzz - Modulation - ww: wait time - xx: modulation speed - yy: change per step - zz: number of steps
smpsModSet macro wait,speed,change,step
	dc.b	$F0,wait,speed,change,step
	endm

; F1 - Turn on Modulation
smpsModOn 	EQU $F1

; F2 - End of channel
smpsStop macro
	dc.b	$F2
	endm

; F3xx - PSG waveform to xx
smpsPSGform macro form
	dc.b	$F3,form
	endm

; F4 - Turn off Modulation
smpsModOff 	EQU $F4

; F5xx - PSG voice to xx
smpsPSGvoice macro voice
	dc.b	$F5,voice
	endm

; F6xxxx - Jump to xxxx
smpsJump macro loc
	dc.b	$F6
	dc.w	loc-*-1
	endm

; F7xxyyzzzz - Loop back to zzzz yy times, xx being the loop index for loop recursion fixing
smpsLoop macro index,loops,loc
	dc.b	$F7
	dc.b	index,loops
	dc.w	loc-*-1
	endm

; F8xxxx - Call pattern at xxxx, saving return point
smpsCall macro loc
	dc.b	$F8
	dc.w	loc-*-1
	endm

; F9 - Unknown
smpsF9		EQU $F9

; Voices - Feedback
smpsVcFeedback macro val
vcFeedback set val
	endm

; Voices - Algorithm
smpsVcAlgorithm macro val
vcAlgorithm set val
	endm

; Voices - Detune
smpsVcDetune macro op1,op2,op3,op4
vcDT1 set op1
vcDT2 set op2
vcDT3 set op3
vcDT4 set op4
	endm

; Voices - Coarse-Frequency
smpsVcCoarseFreq macro op1,op2,op3,op4
vcCF1 set op1
vcCF2 set op2
vcCF3 set op3
vcCF4 set op4
	endm

; Voices - Rate Scale
smpsVcRateScale macro op1,op2,op3,op4
vcRS1 set op1
vcRS2 set op2
vcRS3 set op3
vcRS4 set op4
	endm

; Voices - Attack Rate
smpsVcAttackRate macro op1,op2,op3,op4
vcAR1 set op1
vcAR2 set op2
vcAR3 set op3
vcAR4 set op4
	endm

; Voices - Amplitude Modulation
smpsVcAmpMod macro op1,op2,op3,op4
vcAM1 set op1
vcAM2 set op2
vcAM3 set op3
vcAM4 set op4
	endm

; Voices - First Decay Rate
smpsVcDecayRate1 macro op1,op2,op3,op4
vcD1R1 set op1
vcD1R2 set op2
vcD1R3 set op3
vcD1R4 set op4
	endm

; Voices - Second Decay Rate
smpsVcDecayRate2 macro op1,op2,op3,op4
vcD2R1 set op1
vcD2R2 set op2
vcD2R3 set op3
vcD2R4 set op4
	endm

; Voices - Decay Level
smpsVcDecayLevel macro op1,op2,op3,op4
vcDL1 set op1
vcDL2 set op2
vcDL3 set op3
vcDL4 set op4
	endm

; Voices - Release Rate
smpsVcReleaseRate macro op1,op2,op3,op4
vcRR1 set op1
vcRR2 set op2
vcRR3 set op3
vcRR4 set op4
	endm

; Voices - Total Level
smpsVcTotalLevel macro op1,op2,op3,op4
vcTL1 set op1
vcTL2 set op2
vcTL3 set op3
vcTL4 set op4
	dc.b	(vcFeedback<<3)+vcAlgorithm
	dc.b	(vcDT4<<4)+vcCF4,(vcDT3<<4)+vcCF3,(vcDT2<<4)+vcCF2,(vcDT1<<4)+vcCF1
	dc.b	(vcRS4<<6)+vcAR4,(vcRS3<<6)+vcAR3,(vcRS2<<6)+vcAR2,(vcRS1<<6)+vcAR1
	dc.b	(vcAM4<<5)+vcD1R4,(vcAM3<<5)+vcD1R3,(vcAM2<<5)+vcD1R2,(vcAM1<<5)+vcD1R1
	dc.b	vcD2R4,vcD2R3,vcD2R2,vcD2R1
	dc.b	(vcDL4<<4)+vcRR4,(vcDL3<<4)+vcRR3,(vcDL2<<4)+vcRR2,(vcDL1<<4)+vcRR1
	dc.b	vcTL4,vcTL3,vcTL2,vcTL1
	endm

; ---------------------------------------------------------------------------
; Memory map
; ---------------------------------------------------------------------------
v_snddriver_ram:  = $FFFFF000 ; start of RAM for the sound driver data

v_sndprio:		= $000	; sound priority (priority of new music/SFX must be higher or equal to this value or it won't play; bit 7 of priority being set prevents this value from changing)
v_main_tempo_timeout:	= $001	; Counts down to zero; when zero, resets to next value and delays song by 1 frame
v_main_tempo:		= $002	; Used for music only
f_stopmusic:		= $003	; flag set to stop music when paused
v_fadeout_counter:	= $004

v_fadeout_delay:	= $006
v_extension		= $005

f_updating_dac:		= $008	; $80 if updating DAC, $00 otherwise
v_playsnd0:		= $009	; sound or music copied from below
v_playsnd1:		= $00A	; sound or music to play
v_playsnd2:		= $00B	; special sound to play
v_playnull:		= $00C	; unused sound to play

f_voice_selector:	= $00E	; $00 = use music voice pointer; $40 = use special voice pointer; $80 = use track voice pointer

v_voice_ptr:		= $018	; voice data pointer (4 bytes)

v_special_voice_ptr:	= $020	; voice data pointer for special SFX ($D0-$DF) (4 bytes)

f_fadein_flag:		= $024	; Flag for fade in
v_fadein_delay:		= $025
v_fadein_counter:	= $026	; Timer for fade in/out
f_1up_playing:		= $027	; flag indicating 1-up song is playing
v_tempo_mod:		= $028	; music - tempo modifier
v_speeduptempo:		= $029	; music - tempo modifier with speed shoes
f_speedup:		= $02A	; flag indicating whether speed shoes tempo is on ($80) or off ($00)
v_ring_speaker:		= $02B	; which speaker the "ring" sound is played in (00 = right; 01 = left)
f_push_playing:		= $02C	; if set, prevents further push sounds from playing

v_track_ram:		= $040	; Start of music RAM

v_dac_track:		= $040
v_dac_playback_control:	= $040	; Playback control bits for DAC channel
v_dac_voice_control:	= $041	; Voice control bits for DAC channel
v_dac_tempo_time:	= $042	; music - tempo dividing timing
v_dac_ptr:		= $044	; DAC channel pointer (4 bytes)
v_dac_amsfmspan:	= $04A
v_dac_stack_ptr:	= $04D
v_dac_note_timeout:	= $04E	; Counts down to zero; when zero, a new DAC sample is needed
v_dac_note_duration:	= $04F
v_dac_curr_sample:	= $050
v_dac_loop_index:	= $064	; Several bytes, may overlap with gosub/return stack

; Note: using the channel assignment bits to determine FM channel #. Thus, there is no FM 3.

v_fm1_track:		= $070
v_fm1_playback_control:	= $070	; Playback control bits for FM1
v_fm1_voice_control:	= $071	; Voice control bits
v_fm1_tempo_time:	= $072	; music - tempo dividing timing
v_fm1_ptr:		= $074	; FM channel 0 pointer (4 bytes)
v_fm1_key:		= $078	; FM channel 0 key displacement
v_fm1_volume:		= $079	; FM channel 0 volume attenuation
v_fm1_amsfmspan:	= $07A
v_fm1_voice:		= $07B
v_fm1_stack_ptr:	= $07D
v_fm1_note_timeout:	= $07E	; Counts down to zero; when zero, a new note is needed
v_fm1_note_duration:	= $07F
v_fm1_curr_note:	= $080
v_fm1_note_fill:	= $082
v_fm1_note_fill_master:	= $083
v_fm1_modulation_ptr:	= $084	; 4 bytes
v_fm1_modulation_wait:	= $088
v_fm1_modulation_speed:	= $089
v_fm1_modulation_delta:	= $08A
v_fm1_modulation_steps:	= $08B
v_fm1_modulation_freq:	= $08C	; 2 bytes
v_fm1_freq_adjust:	= $08E
v_fm1_feedbackalgo:	= $08F
v_fm1_loop_index:	= $094	; Several bytes, may overlap with gosub/return stack

v_fm2_track:		= $0A0
v_fm2_playback_control:	= $0A0	; Playback control bits for FM2
v_fm2_voice_control:	= $0A1	; Voice control bits
v_fm2_tempo_time:	= $0A2	; music - tempo dividing timing
v_fm2_ptr:		= $0A4	; FM channel 1 pointer (4 bytes)
v_fm2_key:		= $0A8	; FM channel 1 key displacement
v_fm2_volume:		= $0A9	; FM channel 1 volume attenuation
v_fm2_amsfmspan:	= $0AA
v_fm2_voice:		= $0AB
v_fm2_stack_ptr:	= $0AD
v_fm2_note_timeout:	= $0AE	; Counts down to zero; when zero, a new note is needed
v_fm2_note_duration:	= $0AF
v_fm2_curr_note:	= $0B0
v_fm2_note_fill:	= $0B2
v_fm2_note_fill_master:	= $0B3
v_fm2_modulation_ptr:	= $0B4	; 4 bytes
v_fm2_modulation_wait:	= $0B8
v_fm2_modulation_speed:	= $0B9
v_fm2_modulation_delta:	= $0BA
v_fm2_modulation_steps:	= $0BB
v_fm2_modulation_freq:	= $0BC	; 2 bytes
v_fm2_freq_adjust:	= $0BE
v_fm2_feedbackalgo:	= $0BF
v_fm2_loop_index:	= $0C4	; Several bytes, may overlap with gosub/return stack

v_fm3_track:		= $0D0
v_fm3_playback_control:	= $0D0	; Playback control bits for FM3
v_fm3_voice_control:	= $0D1	; Voice control bits
v_fm3_tempo_time:	= $0D2	; music - tempo dividing timing
v_fm3_ptr:		= $0D4	; FM channel 2 pointer (4 bytes)
v_fm3_key:		= $0D8	; FM channel 2 key displacement
v_fm3_volume:		= $0D9	; FM channel 2 volume attenuation
v_fm3_amsfmspan:	= $0DA
v_fm3_voice:		= $0DB
v_fm3_stack_ptr:	= $0DD
v_fm3_note_timeout:	= $0DE	; Counts down to zero; when zero, a new note is needed
v_fm3_note_duration:	= $0DF
v_fm3_curr_note:	= $0E0
v_fm3_note_fill:	= $0E2
v_fm3_note_fill_master:	= $0E3
v_fm3_modulation_ptr:	= $0E4	; 4 bytes
v_fm3_modulation_wait:	= $0E8
v_fm3_modulation_speed:	= $0E9
v_fm3_modulation_delta:	= $0EA
v_fm3_modulation_steps:	= $0EB
v_fm3_modulation_freq:	= $0EC	; 2 bytes
v_fm3_freq_adjust:	= $0EE
v_fm3_feedbackalgo:	= $0EF
v_fm3_loop_index:	= $0F4	; Several bytes, may overlap with gosub/return stack

v_fm4_track:		= $100
v_fm4_playback_control:	= $100	; Playback control bits for FM4
v_fm4_voice_control:	= $101	; Voice control bits
v_fm4_tempo_time:	= $102	; music - tempo dividing timing
v_fm4_ptr:		= $104	; FM channel 4 pointer (4 bytes)
v_fm4_key:		= $108	; FM channel 4 key displacement
v_fm4_volume:		= $109	; FM channel 4 volume attenuation
v_fm4_amsfmspan:	= $10A
v_fm4_voice:		= $10B
v_fm4_stack_ptr:	= $10D
v_fm4_note_timeout:	= $10E	; Counts down to zero; when zero, a new note is needed
v_fm4_note_duration:	= $10F
v_fm4_curr_note:	= $110
v_fm4_note_fill:	= $112
v_fm4_note_fill_master:	= $113
v_fm4_modulation_ptr:	= $114	; 4 bytes
v_fm4_modulation_wait:	= $118
v_fm4_modulation_speed:	= $119
v_fm4_modulation_delta:	= $11A
v_fm4_modulation_steps:	= $11B
v_fm4_modulation_freq:	= $11C	; 2 bytes
v_fm4_freq_adjust:	= $11E
v_fm4_feedbackalgo:	= $11F
v_fm4_loop_index:	= $124	; Several bytes, may overlap with gosub/return stack

v_fm5_track:		= $130
v_fm5_playback_control:	= $130	; Playback control bits for FM5
v_fm5_voice_control:	= $131	; Voice control bits
v_fm5_tempo_time:	= $132	; music - tempo dividing timing
v_fm5_ptr:		= $134	; FM channel 5 pointer (4 bytes)
v_fm5_key:		= $138	; FM channel 5 key displacement
v_fm5_volume:		= $139	; FM channel 5 volume attenuation
v_fm5_amsfmspan:	= $13A
v_fm5_voice:		= $13B
v_fm5_stack_ptr:	= $13D
v_fm5_note_timeout:	= $13E	; Counts down to zero; when zero, a new note is needed
v_fm5_note_duration:	= $13F
v_fm5_curr_note:	= $140
v_fm5_note_fill:	= $142
v_fm5_note_fill_master:	= $143
v_fm5_modulation_ptr:	= $144	; 4 bytes
v_fm5_modulation_wait:	= $148
v_fm5_modulation_speed:	= $149
v_fm5_modulation_delta:	= $14A
v_fm5_modulation_steps:	= $14B
v_fm5_modulation_freq:	= $14C	; 2 bytes
v_fm5_freq_adjust:	= $14E
v_fm5_feedbackalgo:	= $14F
v_fm5_loop_index:	= $154	; Several bytes, may overlap with gosub/return stack

v_fm6_track:		= $160
v_fm6_playback_control:	= $160	; Playback control bits for FM6
v_fm6_voice_control:	= $161	; Voice control bits
v_fm6_tempo_time:	= $162	; music - tempo dividing timing
v_fm6_ptr:		= $164	; FM channel 6 pointer (4 bytes)
v_fm6_key:		= $168	; FM channel 6 key displacement
v_fm6_volume:		= $169	; FM channel 6 volume attenuation
v_fm6_amsfmspan:	= $16A
v_fm6_voice:		= $16B
v_fm6_stack_ptr:	= $16D
v_fm6_note_timeout:	= $16E	; Counts down to zero; when zero, a new note is needed
v_fm6_note_duration:	= $16F
v_fm6_curr_note:	= $170
v_fm6_note_fill:	= $172
v_fm6_note_fill_master:	= $173
v_fm6_modulation_ptr:	= $174	; 4 bytes
v_fm6_modulation_wait:	= $178
v_fm6_modulation_speed:	= $179
v_fm6_modulation_delta:	= $17A
v_fm6_modulation_steps:	= $17B
v_fm6_modulation_freq:	= $17C	; 2 bytes
v_fm6_freq_adjust:	= $17E
v_fm6_feedbackalgo:	= $17F
v_fm6_loop_index:	= $184	; Several bytes, may overlap with gosub/return stack

v_psg1_track:		= $190
v_psg1_playback_control:= $190	; Playback control bits for PSG1
v_psg1_voice_control:	= $191	; Voice control bits
v_psg1_tempo_time:	= $192	; music - tempo dividing timing
v_psg1_ptr:		= $194	; PSG channel 1 pointer (4 bytes)
v_psg1_key:		= $198	; PSG channel 1 key displacement
v_psg1_volume:		= $199	; PSG channel 1 volume attenuation
v_psg1_amsfmspan:	= $19A
v_psg1_tone:		= $19B
v_psg1_flutter_index:	= $19C
v_psg1_stack_ptr:	= $19D
v_psg1_note_timeout:	= $19E	; Counts down to zero; when zero, a new note is needed
v_psg1_note_duration:	= $19F
v_psg1_curr_note:	= $1A0
v_psg1_note_fill:	= $1A2
v_psg1_note_fill_master:= $1A3
v_psg1_modulation_ptr:	= $1A4	; 4 bytes
v_psg1_modulation_wait:	= $1A8
v_psg1_modulation_speed:= $1A9
v_psg1_modulation_delta:= $1AA
v_psg1_modulation_steps:= $1AB
v_psg1_modulation_freq:	= $1AC	; 2 bytes
v_psg1_freq_adjust:	= $1AE
v_psg1_noise:		= $1AF
v_psg1_loop_index:	= $1B4	; Several bytes, may overlap with gosub/return stack

v_psg2_track:		= $1C0
v_psg2_playback_control:= $1C0	; Playback control bits for PSG2
v_psg2_voice_control:	= $1C1	; Voice control bits
v_psg2_tempo_time:	= $1C2	; music - tempo dividing timing
v_psg2_ptr:		= $1C4	; PSG channel 2 pointer (4 bytes)
v_psg2_key:		= $1C8	; PSG channel 2 key displacement
v_psg2_volume:		= $1C9	; PSG channel 2 volume attenuation
v_psg2_amsfmspan:	= $1CA
v_psg2_tone:		= $1CB
v_psg2_flutter_index:	= $1CC
v_psg2_stack_ptr:	= $1CD
v_psg2_note_timeout:	= $1CE	; Counts down to zero; when zero, a new note is needed
v_psg2_note_duration:	= $1CF
v_psg2_curr_note:	= $1D0
v_psg2_note_fill:	= $1D2
v_psg2_note_fill_master:= $1D3
v_psg2_modulation_ptr:	= $1D4	; 4 bytes
v_psg2_modulation_wait:	= $1D8
v_psg2_modulation_speed:= $1D9
v_psg2_modulation_delta:= $1DA
v_psg2_modulation_steps:= $1DB
v_psg2_modulation_freq:	= $1DC	; 2 bytes
v_psg2_freq_adjust:	= $1DE
v_psg2_noise:		= $1DF
v_psg2_loop_index:	= $1E4	; Several bytes, may overlap with gosub/return stack

v_psg3_track:		= $1F0
v_psg3_playback_control:= $1F0	; Playback control bits for PSG3
v_psg3_voice_control:	= $1F1	; Voice control bits
v_psg3_tempo_time:	= $1F2	; music - tempo dividing timing
v_psg3_ptr:		= $1F4	; PSG channel 3 pointer (4 bytes)
v_psg3_key:		= $1F8	; PSG channel 3 key displacement
v_psg3_volume:		= $1F9	; PSG channel 3 volume attenuation
v_psg3_amsfmspan:	= $1FA
v_psg3_tone:		= $1FB
v_psg3_flutter_index:	= $1FC
v_psg3_stack_ptr:	= $1FD
v_psg3_note_timeout:	= $1FE	; Counts down to zero; when zero, a new note is needed
v_psg3_note_duration:	= $1FF
v_psg3_curr_note:	= $200
v_psg3_note_fill:	= $202
v_psg3_note_fill_master:= $203
v_psg3_modulation_ptr:	= $204	; 4 bytes
v_psg3_modulation_wait:	= $208
v_psg3_modulation_speed:= $209
v_psg3_modulation_delta:= $20A
v_psg3_modulation_steps:= $20B
v_psg3_modulation_freq:	= $20C	; 2 bytes
v_psg3_freq_adjust:	= $20E
v_psg3_noise:		= $20F
v_psg3_loop_index:	= $214	; Several bytes, may overlap with gosub/return stack

v_sfx_track_ram:	= $220	; Start of sfx RAM

v_sfx_fm3_track:	= $220
v_sfx_fm3_playback_control:	= $220	; Playback control bits for sfx FM3
v_sfx_fm3_voice_control:	= $221	; Voice control bits
v_sfx_fm3_tempo_time:	= $222	; sfx - tempo dividing timing
v_sfx_fm3_ptr:		= $224	; FM channel 2 pointer (4 bytes)
v_sfx_fm3_key:		= $228	; FM channel 2 key displacement
v_sfx_fm3_volume:	= $229	; FM channel 2 volume attenuation
v_sfx_fm3_amsfmspan:	= $22A
v_sfx_fm3_voice:	= $22B
v_sfx_fm3_stack_ptr:	= $22D
v_sfx_fm3_note_timeout:	= $22E	; Counts down to zero; when zero, a new note is needed
v_sfx_fm3_note_duration:	= $22F
v_sfx_fm3_curr_note:	= $230
v_sfx_fm3_note_fill:	= $232
v_sfx_fm3_note_fill_master:	= $233
v_sfx_fm3_modulation_ptr:	= $234	; 4 bytes
v_sfx_fm3_modulation_wait:	= $238
v_sfx_fm3_modulation_speed:	= $239
v_sfx_fm3_modulation_delta:	= $23A
v_sfx_fm3_modulation_steps:	= $23B
v_sfx_fm3_modulation_freq:	= $23C	; 2 bytes
v_sfx_fm3_freq_adjust:	= $23E
v_sfx_fm3_feedbackalgo:	= $23F
v_sfx_fm3_voice_ptr:	= $240
v_sfx_fm3_loop_index:	= $244	; Several bytes, may overlap with gosub/return stack

v_sfx_fm4_track:	= $250
v_sfx_fm4_playback_control:	= $250	; Playback control bits for sfx FM4
v_sfx_fm4_voice_control:	= $251	; Voice control bits
v_sfx_fm4_tempo_time:	= $252	; sfx - tempo dividing timing
v_sfx_fm4_ptr:		= $254	; FM channel 4 pointer (4 bytes)
v_sfx_fm4_key:		= $258	; FM channel 4 key displacement
v_sfx_fm4_volume:	= $259	; FM channel 4 volume attenuation
v_sfx_fm4_amsfmspan:	= $25A
v_sfx_fm4_voice:	= $25B
v_sfx_fm4_stack_ptr:	= $25D
v_sfx_fm4_note_timeout:	= $25E	; Counts down to zero; when zero, a new note is needed
v_sfx_fm4_note_duration:	= $25F
v_sfx_fm4_curr_note:	= $260
v_sfx_fm4_note_fill:	= $262
v_sfx_fm4_note_fill_master:	= $263
v_sfx_fm4_modulation_ptr:	= $264	; 4 bytes
v_sfx_fm4_modulation_wait:	= $268
v_sfx_fm4_modulation_speed:	= $269
v_sfx_fm4_modulation_delta:	= $26A
v_sfx_fm4_modulation_steps:	= $26B
v_sfx_fm4_modulation_freq:	= $26C	; 2 bytes
v_sfx_fm4_freq_adjust:	= $26E
v_sfx_fm4_feedbackalgo:	= $26F
v_sfx_fm4_voice_ptr:	= $270
v_sfx_fm4_loop_index:	= $274	; Several bytes, may overlap with gosub/return stack

v_sfx_fm5_track:	= $280
v_sfx_fm5_playback_control:	= $280	; Playback control bits for sfx FM5
v_sfx_fm5_voice_control:	= $281	; Voice control bits
v_sfx_fm5_tempo_time:	= $282	; sfx - tempo dividing timing
v_sfx_fm5_ptr:	= $284	; FM channel 5 pointer (4 bytes)
v_sfx_fm5_key:	= $288	; FM channel 5 key displacement
v_sfx_fm5_volume:	= $289	; FM channel 5 volume attenuation
v_sfx_fm5_amsfmspan:	= $28A
v_sfx_fm5_voice:	= $28B
v_sfx_fm5_stack_ptr:	= $28D
v_sfx_fm5_note_timeout:	= $28E	; Counts down to zero; when zero, a new note is needed
v_sfx_fm5_note_duration:	= $28F
v_sfx_fm5_curr_note:	= $290
v_sfx_fm5_note_fill:	= $292
v_sfx_fm5_note_fill_master:	= $293
v_sfx_fm5_modulation_ptr:	= $294	; 4 bytes
v_sfx_fm5_modulation_wait:	= $298
v_sfx_fm5_modulation_speed:	= $299
v_sfx_fm5_modulation_delta:	= $29A
v_sfx_fm5_modulation_steps:	= $29B
v_sfx_fm5_modulation_freq:	= $29C	; 2 bytes
v_sfx_fm5_freq_adjust:	= $29E
v_sfx_fm5_feedbackalgo:	= $29F
v_sfx_fm5_voice_ptr:	= $2A0
v_sfx_fm5_loop_index:	= $2A4	; Several bytes, may overlap with gosub/return stack

v_sfx_psg1_track:	= $2B0
v_sfx_psg1_playback_control:	= $2B0	; Playback control bits for sfx PSG1
v_sfx_psg1_voice_control:	= $2B1	; Voice control bits
v_sfx_psg1_tempo_time:	= $2B2	; sfx - tempo dividing timing
v_sfx_psg1_ptr:	= $2B4	; PSG channel 1 pointer (4 bytes)
v_sfx_psg1_key:	= $2B8	; PSG channel 1 key displacement
v_sfx_psg1_volume:	= $2B9	; PSG channel 1 volume attenuation
v_sfx_psg1_amsfmspan:	= $2BA
v_sfx_psg1_tone:	= $2BB
v_sfx_psg1_flutter_index:	= $2BC
v_sfx_psg1_stack_ptr:	= $2BD
v_sfx_psg1_note_timeout:	= $2BE	; Counts down to zero; when zero, a new note is needed
v_sfx_psg1_note_duration:	= $2BF
v_sfx_psg1_curr_note:	= $2C0
v_sfx_psg1_note_fill:	= $2C2
v_sfx_psg1_note_fill_master:	= $2C3
v_sfx_psg1_modulation_ptr:	= $2C4	; 4 bytes
v_sfx_psg1_modulation_wait:	= $2C8
v_sfx_psg1_modulation_speed:	= $2C9
v_sfx_psg1_modulation_delta:	= $2CA
v_sfx_psg1_modulation_steps:	= $2CB
v_sfx_psg1_modulation_freq:	= $2CC	; 2 bytes
v_sfx_psg1_freq_adjust:	= $2CE
v_sfx_psg1_noise:	= $2CF
v_sfx_psg1_loop_index:	= $2D4	; Several bytes, may overlap with gosub/return stack

v_sfx_psg2_track:	= $2E0
v_sfx_psg2_playback_control:	= $2E0	; Playback control bits for sfx PSG2
v_sfx_psg2_voice_control:	= $2E1	; Voice control bits
v_sfx_psg2_tempo_time:	= $2E2	; sfx - tempo dividing timing
v_sfx_psg2_ptr:	= $2E4	; PSG channel 2 pointer (4 bytes)
v_sfx_psg2_key:	= $2E8	; PSG channel 2 key displacement
v_sfx_psg2_volume:	= $2E9	; PSG channel 2 volume attenuation
v_sfx_psg2_amsfmspan:	= $2EA
v_sfx_psg2_tone:	= $2EB
v_sfx_psg2_flutter_index:	= $2EC
v_sfx_psg2_stack_ptr:	= $2ED
v_sfx_psg2_note_timeout:	= $2EE	; Counts down to zero; when zero, a new note is needed
v_sfx_psg2_note_duration:	= $2EF
v_sfx_psg2_curr_note:	= $2F0
v_sfx_psg2_note_fill:	= $2F2
v_sfx_psg2_note_fill_master:	= $2F3
v_sfx_psg2_modulation_ptr:	= $2F4	; 4 bytes
v_sfx_psg2_modulation_wait:	= $2F8
v_sfx_psg2_modulation_speed:	= $2F9
v_sfx_psg2_modulation_delta:	= $2FA
v_sfx_psg2_modulation_steps:	= $2FB
v_sfx_psg2_modulation_freq:	= $2FC	; 2 bytes
v_sfx_psg2_freq_adjust:	= $2FE
v_sfx_psg2_noise:	= $2FF
v_sfx_psg2_loop_index:	= $304	; Several bytes, may overlap with gosub/return stack

v_sfx_psg3_track:	= $310
v_sfx_psg3_playback_control:	= $310	; Playback control bits for sfx PSG3
v_sfx_psg3_voice_control:	= $311	; Voice control bits
v_sfx_psg3_tempo_time:	= $312	; sfx - tempo dividing timing
v_sfx_psg3_ptr:	= $314	; PSG channel 3 pointer (4 bytes)
v_sfx_psg3_key:	= $318	; PSG channel 3 key displacement
v_sfx_psg3_volume:	= $319	; PSG channel 3 volume attenuation
v_sfx_psg3_amsfmspan:	= $31A
v_sfx_psg3_tone:	= $31B
v_sfx_psg3_flutter_index:	= $31C
v_sfx_psg3_stack_ptr:	= $31D
v_sfx_psg3_note_timeout:	= $31E	; Counts down to zero; when zero, a new note is needed
v_sfx_psg3_note_duration:	= $31F
v_sfx_psg3_curr_note:	= $320
v_sfx_psg3_note_fill:	= $322
v_sfx_psg3_note_fill_master:	= $323
v_sfx_psg3_modulation_ptr:	= $324	; 4 bytes
v_sfx_psg3_modulation_wait:	= $328
v_sfx_psg3_modulation_speed:	= $329
v_sfx_psg3_modulation_delta:	= $32A
v_sfx_psg3_modulation_steps:	= $32B
v_sfx_psg3_modulation_freq:	= $32C	; 2 bytes
v_sfx_psg3_freq_adjust:	= $32E
v_sfx_psg3_noise:	= $32F
v_sfx_psg3_loop_index:	= $334	; Several bytes, may overlap with gosub/return stack

v_sfx2_track_ram:	= $340	; Start of special sfx RAM

v_sfx2_fm4_track:	= $340
v_sfx2_fm4_playback_control:	= $340	; Playback control bits for sfx FM4
v_sfx2_fm4_voice_control:	= $341	; Voice control bits
v_sfx2_fm4_tempo_time:	= $342	; sfx - tempo dividing timing
v_sfx2_fm4_ptr:	= $344	; FM channel 4 pointer (4 bytes)
v_sfx2_fm4_key:	= $348	; FM channel 4 key displacement
v_sfx2_fm4_volume:	= $349	; FM channel 4 volume attenuation
v_sfx2_fm4_amsfmspan:	= $34A
v_sfx2_fm4_voice:	= $34B
v_sfx2_fm4_stack_ptr:	= $34D
v_sfx2_fm4_note_timeout:	= $34E	; Counts down to zero; when zero, a new note is needed
v_sfx2_fm4_note_duration:	= $34F
v_sfx2_fm4_curr_note:	= $350
v_sfx2_fm4_note_fill:	= $352
v_sfx2_fm4_note_fill_master:	= $353
v_sfx2_fm4_modulation_ptr:	= $354	; 4 bytes
v_sfx2_fm4_modulation_wait:	= $358
v_sfx2_fm4_modulation_speed:	= $359
v_sfx2_fm4_modulation_delta:	= $35A
v_sfx2_fm4_modulation_steps:	= $35B
v_sfx2_fm4_modulation_freq:	= $35C	; 2 bytes
v_sfx2_fm4_freq_adjust:	= $35E
v_sfx2_fm4_feedbackalgo:	= $35F
v_sfx2_fm4_voice_ptr:	= $360
v_sfx2_fm4_loop_index:	= $364	; Several bytes, may overlap with gosub/return stack

v_sfx2_psg3_track:	= $370
v_sfx2_psg3_playback_control:	= $370	; Playback control bits for sfx PSG3
v_sfx2_psg3_voice_control:	= $371	; Voice control bits
v_sfx2_psg3_tempo_time:	= $372	; sfx - tempo dividing timing
v_sfx2_psg3_ptr:	= $374	; PSG channel 3 pointer (4 bytes)
v_sfx2_psg3_key:	= $378	; PSG channel 3 key displacement
v_sfx2_psg3_volume:	= $379	; PSG channel 3 volume attenuation
v_sfx2_psg3_amsfmspan:	= $37A
v_sfx2_psg3_tone:	= $37B
v_sfx2_psg3_flutter_index:	= $37C
v_sfx2_psg3_stack_ptr:	= $37D
v_sfx2_psg3_note_timeout:	= $37E	; Counts down to zero; when zero, a new note is needed
v_sfx2_psg3_note_duration:	= $37F
v_sfx2_psg3_curr_note:	= $380
v_sfx2_psg3_note_fill:	= $382
v_sfx2_psg3_note_fill_master:	= $383
v_sfx2_psg3_modulation_ptr:	= $384	; 4 bytes
v_sfx2_psg3_modulation_wait:	= $388
v_sfx2_psg3_modulation_speed:	= $389
v_sfx2_psg3_modulation_delta:	= $38A
v_sfx2_psg3_modulation_steps:	= $38B
v_sfx2_psg3_modulation_freq:	= $38C	; 2 bytes
v_sfx2_psg3_freq_adjust:	= $38E
v_sfx2_psg3_noise:	= $38F
v_sfx2_psg3_loop_index:	= $394	; Several bytes, may overlap with gosub/return stack

v_1up_ram_copy:	= $3A0

f_fastmusic:	= $3CA	; flag set to speed up the music (00 = normal; 80 = fast)

;Consts
PSG: 		equ $C00011
zTrackSz:	equ $30

; Sound effects
sfx_Push:	equ $A7
sfx_Ring:	equ $B5
sfx_RingLeft:	equ $CE
sfx_Waterfall:	equ $D0
sfx_Sega:	equ $E1

bgm_ExtraLife	equ	$88

SRAMEnable	macro
	move.b	#1,$A130F1		; enable SRAM
	endm

SRAMDisable	macro
	move.b	#0,$A130F1		; disable SRAM
	endm
; =============================================================
stopZ80        macro
        move.w    #$100,($A11100).l
        nop
        nop
        nop

.wait\@:    btst    #0,($A11100).l
        bne.s    .wait\@
        endm

; =============================================================

startZ80    macro
        move.w    #0,($A11100).l    ; start the Z80
        endm

; =============================================================

waitYM        macro
.wait\@:    move.b    ($A04000).l,d2
        btst    #7,d2
        bne.s    .wait\@
        endm

ttlcard2 macro
	rept narg

	if 'A'=\1
		dc.w $5000
	elseif 'B'=\1
		dc.w $5006
	elseif 'C'=\1
		dc.w $500C
	elseif 'D'=\1
		dc.w $5012
	elseif 'E'=\1
		dc.w $5018
	elseif 'F'=\1
		dc.w $501E
	elseif 'G'=\1
		dc.w $5024
	elseif 'H'=\1
		dc.w $502A
	elseif 'I'=\1
		dc.w $2030
	elseif 'J'=\1
		dc.w $2033
	elseif 'K'=\1
		dc.w $5036
	elseif 'L'=\1
		dc.w $203C
	elseif 'M'=\1
		dc.w $803F
	elseif 'N'=\1
		dc.w $5048
	elseif 'O'=\1
		dc.w $804E
	elseif 'P'=\1
		dc.w $5057
	elseif 'Q'=\1
		dc.w $805D
	elseif 'R'=\1
		dc.w $5066
	elseif 'S'=\1
		dc.w $506C
	elseif 'T'=\1
		dc.w $5072
	elseif 'U'=\1
		dc.w $2078
	elseif 'V'=\1
		dc.w $507B
	elseif 'W'=\1
		dc.w $8081
	elseif 'X'=\1
		dc.w $508A
	elseif 'Y'=\1
		dc.w $5090
	elseif 'Z'=\1
		dc.w $5096
	elseif ' '=\1
		dc.w $20FC
	else
		dc.w \1
	endc

	shift
	endr
	endm

ttlcard macro
	dc.b narg

	rept narg

	if 'A'=\1
		dc.w $5000
	elseif 'B'=\1
		dc.w $5006
	elseif 'C'=\1
		dc.w $500C
	elseif 'D'=\1
		dc.w $5012
	elseif 'E'=\1
		dc.w $5018
	elseif 'F'=\1
		dc.w $501E
	elseif 'G'=\1
		dc.w $5024
	elseif 'H'=\1
		dc.w $502A
	elseif 'I'=\1
		dc.w $2030
	elseif 'J'=\1
		dc.w $2033
	elseif 'K'=\1
		dc.w $5036
	elseif 'L'=\1
		dc.w $203C
	elseif 'M'=\1
		dc.w $803F
	elseif 'N'=\1
		dc.w $5048
	elseif 'O'=\1
		dc.w $804E
	elseif 'P'=\1
		dc.w $5057
	elseif 'Q'=\1
		dc.w $805D
	elseif 'R'=\1
		dc.w $5066
	elseif 'S'=\1
		dc.w $506C
	elseif 'T'=\1
		dc.w $5072
	elseif 'U'=\1
		dc.w $2078
	elseif 'V'=\1
		dc.w $507B
	elseif 'W'=\1
		dc.w $8081
	elseif 'X'=\1
		dc.w $508A
	elseif 'Y'=\1
		dc.w $5090
	elseif 'Z'=\1
		dc.w $5096
	elseif ' '=\1
		dc.w $20FC
	else
		dc.w \1
	endc

	shift
	endr

	dc.b 0
	endm

ttlzone	macro x
	dc.b 32, $E, 0, 0, x
	dc.b 32, $E, 0, 12, x+$20
	dc.b 32, 2, 0, 24, x+$40
	endm

; ---------------------------------------------------------------------------
; DMA Transfer
; ---------------------------------------------------------------------------
dma68kToVDP macro source,dest,length,type
	lea	VDP_Control_Port,a5
	move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a5)
	move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a5)
	move.w	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F),(a5)
	move.w	#((dest)&$3FFF)|((type&1)<<15)|$4000,(a5)
	move.w	#$80|(((dest)&$C000)>>14)|((type&2)<<3),$FFFFF640.w
	move.w	$FFFFF640.w,(a5)
    endm

Nat_dma68kToVDP macro source,dest,length,type
	move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(Nat_VDPc)
	move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(Nat_VDPc)
	move.w	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F),(Nat_VDPc)
	move.w	#((dest)&$3FFF)|((type&1)<<15)|$4000,(Nat_VDPc)
	move.w	#$80|(((dest)&$C000)>>14)|((type&2)<<3),(Nat_VDPc)
    endm

; ---------------------------------------------------------------------------
; DMA fill with a value
; input: value, length, destination
; ---------------------------------------------------------------------------

fillVRAM macro value,length,loc
	lea	vdp_control_port,a5
	move.w	#$8F01,(a5)
	move.l	#$94000000+((length&$FF00)<<8)+$9300+(length&$FF),(a5)
	move.w	#$9780,(a5)
	move.l	#$40000080+((loc&$3FFF)<<16)+((loc&$C000)>>14),(a5)
	move.w	#value,vdp_data_port-VDP_Control_Port(a5)
    endm

; values for the type argument
VRAM =	$0
CRAM =	$1
VSRAM =	$2

	include "dosequ.asm"


setColor macro col
		move.l #$C0000000,VDP_Control_Port
		move.w #col,VDP_Data_Port
	endm
