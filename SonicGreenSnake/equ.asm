; Equates used in Sonic Green Snake
Beta_build = 1
Cheats = 1

; Object specific equates ; Sonic Green Snake custom
	rsset	0
ID		rs.b 1		 ; Maybe later upgraded to S3K system with one longword, but atm it's Sonic 1's normal ; 1
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
Misc_Data_count equ 4; everything but act or zone data (But includes Final Zone
GHZ_DPLC        equ Act_Count+Misc_Data_count+2; +2 is fix for DPLC information
SBZ_DPLC        equ Act_Count+Misc_Data_count+7; 7 is the amount of DPLC's from GHZ DPLC entry to SBZ DPLC entry plus 2
Misc_PLC	equ 20; amount of miscellaneous PLC's before Zone plc's
CharacterCount	equ 3
RingAttract_X	equ $80
RingAttract_Y	equ $40
RiAt_XMul	equ $30
RiAt_YMul	equ $30

; equates for Sonic's speed on different situations
Speed_Normal		equ $634
Acc_Normal		equ $C
Dec_Normal		equ $80

Speed_Shoes		equ (Speed_Normal*2)
Acc_Shoes		equ (Acc_Normal*2)
Dec_Shoes		equ Dec_Normal

Speed_Turbo		equ $1000
Acc_Turbo		equ (Acc_Normal*3)
Dec_Turbo		equ Dec_Normal+$40

Speed_UW		equ (Speed_Normal/2)
Acc_UW			equ (Acc_Normal/2)
Dec_UW			equ (Dec_Normal/2)

Speed_UW_Sho		equ ((Speed_Normal/6)*5)
ACC_UW_Sho		equ ((Acc_Normal/6)*5)
Dec_UW_Sho		equ ((Dec_Normal/6)*5)

Speed_UW_Tur		equ $880
Acc_UW_Tur		equ (Acc_Normal*2)
Dec_UW_Tur		equ Dec_Normal+$30

Speed_Sho_Tur		equ $1400
Acc_Sho_Tur		equ (Acc_Normal*4)
Dec_Sho_Tur		equ Dec_Normal+$80

Speed_UW_Sho_Tur	equ Speed_Turbo
Acc_UW_Sho_Tur		equ Acc_Shoes+4
Dec_UW_Sho_Tur		equ Dec_Normal+$60

; definitions for music
Sfx_fade		equ $E0

; Definitions for $D000-$D800
; Normal level
Object_RAM		equ $FFFFD000; Mostly used for Sonic object
SpinDust_RAM		equ $FFFFD1C0
InvinStars_RAM		equ $FFFFD200; also $FFFFD240
Shield_RAM		equ $FFFFD280
Splash_RAM		equ $FFFFD300
Bubbles_RAM		equ $FFFFD340
Tails_Tail_RAM		equ $FFFFD380
Object_RAM_Free		equ $FFFFD800

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
		dc.b $20,$FE, $23,$FE, $62,6, $5F,6, $1F,8, $60,6, $FF
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

; RAM equates for $8400 - $A3FF
CompDec_RAM		equ $FFFF8400
CompDec_RAM_End		equ $FFFF8A00-1
CompDec_Size		equ CompDec_RAM_End-CompDec_RAM+1	; 600 bytes

; RAM equates for $A400 - $A7FF

; RAM equates for $C800 - $CAFF
DMA_Buffer_Start	equ $FFFFC800; the start address of DMA buffer for uncompressed art
DMA_Buffer_End		equ $FFFFCA00-4; the end address of DMA buffer for uncompressed art
Signs_RAM		equ $FFFFCA00
TurboMode_flag		equ Signs_RAM; turbo mode flag
ExtCam_Use		equ Signs_RAM+1; choose whether to use extended camera or not


; RAM equates for $FF00 - $FF0F	; NOTE: Will be cleared each time level inits
HPZ_Aniart_Data:	equ $FFFFFF00
; RAM equates for $FF14 - $FF17
; seems not to work for whatever reason

Extcam_pos		equ $FFFFF7A0; position of extended camera from the screen

; RAM equates for $FF38 - $FF7F ; NOTE: Will be cleared each time level inits
Spindash_HorizDelay	equ $FFFFFF38; 2 bytes ; Horizontal camera delay
If_Spindash		equ $FFFFFF3A; flag to test if spindashing
Spindash_SoundPitch	equ $FFFFFF3B; flag to do with pitch settings for spindash sound
Spindash_StorePitch	equ $FFFFFF3C; stores pitch for spindash sound
Spindash_SoundTimer	equ $FFFFFF3D; timer for the sound reset
Spindash_ChangeCnt	equ $FFFFFF3E; Vertical scroll delay
Player_DJ_Data		equ $FFFFFF40; 4 bytes ; free RAM space for doublejump variables
Player_DoubleJump	equ $FFFFFF45; players doublejump flag
Sonic_ForceRollMode	equ $FFFFFF46; if set, will force Sonic to roll
PeelOut_Flag		equ $FFFFFF47; if Sonic is performing speelout (also timer for it)
Path_ID			equ $FFFFFF48; Path swappers' path ID
Glide_AnimHandler	equ $FFFFFF49; animation handler flag for Knuckles' glide
GlidingCollTimer	equ $FFFFFF4A; timer to check if Sonic is colliding with objects
FastInvis		equ $FFFFFF4B; If Sonic is going fast enough give him full invinciblity
Player_SpecTouAni	equ $FFFFFF4C; 2 bytes ; special animation to allow destroying badniks with	; mainly used with Knuckles' Glide move

; RAM equates for $FF86 - $FFB7
Coll_Pointer		equ $FFFFFF86; 12 bytes	; pointer for Zone's collision arrays and Anglemap file
Player_ArtLoc		equ $FFFFFF92; 4 bytes ; pointer for players art location (can also be used for special art if needed to ;) )
Player_MapLoc		equ $FFFFFF96; 4 bytes ; pointer for players mappings location (can be used for special mappings)
Player_DPLCLoc		equ $FFFFFF9A; 4 bytes ; pointer for players DPLC location (can be used for special DPLCs)
Player_AniDat		equ $FFFFFF9E; 4 bytes ; pointer for players animation data location (can be used for special anis)
PAni_Roll		equ $FFFFFFA2; 4 bytes ; pointer for players Roll animation
PAni_Roll2		equ $FFFFFFA6; 4 bytes ; pointer for players Roll animation
PAni_Push		equ $FFFFFFAA; 4 bytes ; pointer for players Push animation
Player_JumpHeight	equ $FFFFFFAE; 2 bytes ; player's jump height
Layout_Data		equ $FFFFFFB0; 4 bytes ; pointer for Layout FG
Layout_BG		equ $FFFFFFB4; 4 bytes ; pointer for Layout BG

; RAM equates for $FFBC - $FFDF
Time_Timer		equ $FFFFFFBE; time of day - timer
Time_DayNight		equ $FFFFFFBF; time of day - time of day ID
Debug_Mode		equ $FFFFFFC0; Debug mode flag
SRAM_ZoneComplete	equ $FFFFFFC2; bitfield for completed zone's	; zone id -> bit
SRAM_SlotID		equ $FFFFFFC4; save slot ID - longword
; RAM equates for $FFE8 - $FFE9
Music_RequestTypes	equ $FFFFFFE8; 0 = music is free to change if different to zone music, 1 = Cant change, 2 = change to "Music_StoreZoneID" if not equal to it
Music_StorePrevID	equ $FFFFFFE9; the music id currently playing is stored here

; RAM equates for $FFF5 - $FFF7
Music_StoreZoneID	equ $FFFFFFF5; Zone's (or special events) music id is stored here
Music_SpeedShoes	equ $FFFFFFF6; Handler for speedshoes music
Storeshield		equ $FFFFFFF7; stores shield ID while switching levels
Current_Character	equ $FFFFFFF9; whatever the character you are using is

; equates for gliding stuff
Gliding_Main		equ Player_DJ_Data+1
Gliding_2		equ Player_DJ_Data+2

; here is some variables used by SRAM checker
SRAM_Version		equ $F3			; current SRAM version
SRAM_Total_Versions	equ 2			; total amount of versions (not calculating current)
SRAM_Lenght		equ SRAM_End-SRAM_Initver; lenght of SRAM in bytes
SRAM_Err_Max		equ 2			; maximium amount of errors in SRAM check
SRAM_Slot_Size		equ $100		; $80 bytes of total SRAM slot space
SRAM_Filename_Lenght	equ 14*2		; 14 letters for the name

; macro which defines the SRAM versions array
SRAM_VerArray	macro			; inverted array (newest first)	; SGS V4 used 1 to determine we created the SRAM once
		dc.b SRAM_Version, $9A,1
		even
	endm
; ==========	SRAM MAP     ==========
	rsset	$200001
SRAM_Initver	rs.w 1			; If SRAM was initialized before, latest initialized version
SRAM_CheckSum	rs.l 1			; ROM checksum

	rsset	$200081			; unused space
SRAM_Slot1	rs.b SRAM_Slot_Size	; free space for slot 1
SRAM_Slot2	rs.b SRAM_Slot_Size	; free space for slot 2
SRAM_Slot3	rs.b SRAM_Slot_Size	; free space for slot 3
SRAM_Slot4	rs.b SRAM_Slot_Size	; free space for slot 4
SRAM_FreeSlot	rs.b SRAM_Slot_Size	; free space
SRAM_End	rs.w 1			; end of SRAM space

; ==========	SRAM SLOT DEFINITIONS     ==========
	rsset	0
SRAM_LastLVL	rs.w 1			; The level you were last on
SRAM_Char	rs.w 1			; The character you last had
SRAM_Turbo	rs.w 1			; Is Turbo Mode unlocked?
SRAM_ExtCam	rs.w 1			; The state of Extended camera
SRAM_TimeDay	rs.w 1			; Time of day
SRAM_Progress	rs.w 1			; progress on the save file
SRAM_ZoneCompl	rs.w 2			; table for completed zones. Will be copied over from "SRAM_ZoneComplete" each time level loads
SRAM_ActComp	rs.w 16			; table for completed acts in Zones. All bits can be used to define zone ID, if is completed. Will use Zone ids to determine what SRAM to write/read from

SRAM_FileName	equ SRAM_Slot_Size-SRAM_Filename_Lenght; filename for the save	; 14 letters	; 28 bytes (Of total space, 14 odd bytes)
; end of save slot space


; macro to fix header (used right after it)
headerfix	macro
	if Beta_build=0
		org    $132
  	  	dc.b	'V 5.0'
  	  	org    $162
  	  	dc.b	'V 5.0'
  	  	org    $200
	else
                org    $132
  	  	dc.b	'5.0 BETA '
		incbin	currentbuild.asm
  	  	org    $162
  	  	dc.b	'5.0 BETA '
  	  	incbin	currentbuild.asm
  	  	org    $200
	endif
	endm


; Equates for SMPS2ASM	

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
dCymbal			equ	$84
dKick2			EQU	$98

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
panNone set $00
panRight set $40
panLeft set $80
panCentre set $C0
panCenter set $C0 ; silly Americans :U
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

volWOI:		equ $0A
smpsSetVolWOI macro val
	dc.b	$EC,val+volWOI
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

	org 0