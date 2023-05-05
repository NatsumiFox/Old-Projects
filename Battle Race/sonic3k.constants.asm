; ---------------------------------------------------------------------------
; Object Status Table offsets
; ---------------------------------------------------------------------------
STARTINGMODE	=	$04	; $60 <- Disclaimer screen
CHEATS	=	1
oazflag =	0		; set to 1 to enable oaz

; universally followed object conventions:
render_flags =		  4 ; bitfield ; refer to SCHG for details
height_pixels =		  6 ; byte
width_pixels =		  7 ; byte
priority =		  8 ; word ; in units of $80
art_tile =		 $A ; word ; PCCVH AAAAAAAAAAA ; P = priority, CC = palette line, V = y-flip; H = x-flip, A = starting cell index of art
mappings =		 $C ; long
x_pos =			$10 ; word, or long when extra precision is required
y_pos =			$14 ; word, or long when extra precision is required
mapping_frame =		$22 ; byte
; ---------------------------------------------------------------------------
; conventions followed by most objects:
routine =		  5 ; byte
x_vel =			$18 ; word
y_vel =			$1A ; word
y_radius =		$1E ; byte ; collision height / 2
x_radius =		$1F ; byte ; collision width / 2
anim =			$20 ; byte
prev_anim =		$21 ; byte ; when this isn't equal to anim the animation restarts
anim_frame =		$23 ; byte
anim_frame_timer =	$24 ; byte
angle =			$26 ; byte ; angle about axis into plane of the screen (00 = vertical, 360 degrees = 256)
status =		$2A ; bitfield ; refer to SCHG for details
; ---------------------------------------------------------------------------
; conventions followed by many objects but not Sonic/Tails/Knuckles:
x_pixel =		x_pos ; word ; x-coordinate for objects using screen positioning
y_pixel =		y_pos ; word ; y-coordinate for objects using screen positioning
collision_flags =	$28 ; byte ; TT SSSSSS ; TT = collision type, SSSSSS = size
collision_property =	$29 ; byte ; usage varies, bosses use it as a hit counter
shield_reaction =	$2B ; byte ; bit 3 = bounces off shield, bit 4 = negated by fire shield, bit 5 = negated by lightning shield, bit 6 = negated by bubble shield
subtype =		$2C ; byte
ros_bit =		$3B ; byte ; the bit to be cleared when an object is destroyed if the ROS flag is set
ros_addr =		$3C ; word ; the RAM address whose bit to clear when an object is destroyed if the ROS flag is set
routine_secondary =	$3C ; byte ; used by monitors for this purpose at least
vram_art =      $40 ; word ; address of art in VRAM (same as art_tile * $20)
parent =		$42 ; word ; address of the object that owns or spawned this one, if applicable
child_dx = 		$42 ; byte ; X offset of child relative to parent
child_dy = 		$43 ; byte ; Y offset of child relative to parent
parent3 = 		$46 ; word ; parent of child objects
parent2 =		$48 ; word ; several objects use this instead
respawn_addr =		$48 ; word ; the address of this object's entry in the respawn table
; ---------------------------------------------------------------------------
; conventions specific to Sonic/Tails/Knuckles:
ground_vel =		$1C ; word ; overall velocity along ground, not updated when in the air
double_jump_property =	$25 ; byte ; remaining frames of flight / 2 for Tails, gliding-related for Knuckles
flip_angle =		$27 ; byte ; angle about horizontal axis (360 degrees = 256)
status_secondary =	$2B ; byte ; see SCHG for details
air_left =		$2C ; byte
flip_type =		$2D ; byte ; bit 7 set means flipping is inverted, lower bits control flipping type
object_control =	$2E ; byte ; bit 0 set means character can jump out, bit 7 set means he can't
double_jump_flag =	$2F ; byte ; meaning depends on current character, see SCHG for details
flips_remaining =	$30 ; byte
flip_speed =		$31 ; byte
move_lock =		$32 ; word ; horizontal control lock, counts down to 0
invulnerability_timer =	$34 ; byte ; decremented every frame
invincibility_timer =	$35 ; byte ; decremented every 8 frames
speed_shoes_timer =	$36 ; byte ; decremented every 8 frames
status_tertiary =	$37 ; byte ; see SCHG for details
character_id =		$38 ; byte ; 0 for Sonic, 1 for Tails, 2 for Knuckles
scroll_delay_counter =	$39 ; byte ; incremented each frame the character is looking up/down, camera starts scrolling when this reaches 120
next_tilt =		$3A ; byte ; angle on ground in front of character
tilt =			$3B ; byte ; angle on ground
stick_to_convex =	$3C ; byte ; used to make character stick to convex surfaces such as the rotating discs in CNZ
spin_dash_flag =	$3D ; byte ; bit 1 indicates spin dash, bit 7 indicates forced roll
spin_dash_counter =	$3E ; word
jumping =		$40 ; byte
interact =		$42 ; word ; RAM address of the last object the character stood on
default_y_radius =	$44 ; byte ; default value of y_radius
default_x_radius =	$45 ; byte ; default value of x_radius
top_solid_bit =		$46 ; byte ; the bit to check for top solidity (either $C or $E)
lrb_solid_bit =		$47 ; byte ; the bit to check for left/right/bottom solidity (either $D or $F)
; ---------------------------------------------------------------------------
; conventions followed by some/most bosses:
boss_hitcount2 =	$29
; ---------------------------------------------------------------------------
; when childsprites are activated (i.e. bit #6 of render_flags set)
mainspr_childsprites 	= $16	; amount of child sprites
sub2_x_pos		= $18	;x_vel
sub2_y_pos		= $1A	;y_vel
sub2_mapframe		= $1D
sub3_x_pos		= $1E	;y_radius
sub3_y_pos		= $20	;anim
sub3_mapframe		= $23	;anim_frame
sub4_x_pos		= $24	;anim_frame_timer
sub4_y_pos		= $26	;angle
sub4_mapframe		= $29	;collision_property
sub5_x_pos		= $2A	;status
sub5_y_pos		= $2C	;subtype
sub5_mapframe		= $2F
sub6_x_pos		= $30
sub6_y_pos		= $32
sub6_mapframe		= $35
sub7_x_pos		= $36
sub7_y_pos		= $38
sub7_mapframe		= $3B
sub8_x_pos		= $3C
sub8_y_pos		= $3E
sub8_mapframe		= $41
sub9_x_pos		= $42
sub9_y_pos		= $44
sub9_mapframe		= $47
next_subspr		= $6
; ---------------------------------------------------------------------------
; property of all objects:
object_size =		$4A ; the size of an object's status table entry
next_object =		object_size
; ---------------------------------------------------------------------------
; unknown or inconsistently used offsets that are not applicable to sonic/tails:
objoff_12 =		2+x_pos
objoff_16 =		2+y_pos
objoff_1C =		$1C
objoff_1D =		$1D
objoff_27 =		$27
objoff_2E =		$2E
objoff_2F =		$2F
objoff_30 =		$30
 enum   objoff_31=$31,objoff_32=$32,objoff_33=$33,objoff_34=$34,objoff_35=$35,objoff_36=$36,objoff_37=$37
 enum 	objoff_38=$38,objoff_39=$39,objoff_3A=$3A,objoff_3B=$3B,objoff_3C=$3C,objoff_3D=$3D,objoff_3E=$3E
 enum 	objoff_3F=$3F,objoff_40=$40,objoff_41=$41,objoff_42=$42,objoff_43=$43,objoff_44=$44,objoff_45=$45
 enum 	objoff_46=$46,objoff_47=$47,objoff_48=$48,objoff_49=$49

 ; ---------------------------------------------------------------------------
; Bits 3-6 of an object's status after a SolidObject call is a
; bitfield with the following meaning:
p1_standing_bit   = 3
p2_standing_bit   = p1_standing_bit + 1

p1_standing       = 1<<p1_standing_bit
p2_standing       = 1<<p2_standing_bit

pushing_bit_delta = 2
p1_pushing_bit    = p1_standing_bit + pushing_bit_delta
p2_pushing_bit    = p1_pushing_bit + 1

p1_pushing        = 1<<p1_pushing_bit
p2_pushing        = 1<<p2_pushing_bit


standing_mask     = p1_standing|p2_standing
pushing_mask      = p1_pushing|p2_pushing

; ---------------------------------------------------------------------------
; Controller Buttons
;
; Buttons bit numbers
button_up:			EQU	0
button_down:			EQU	1
button_left:			EQU	2
button_right:			EQU	3
button_B:			EQU	4
button_C:			EQU	5
button_A:			EQU	6
button_start:			EQU	7
; Buttons masks (1 << x == pow(2, x))
button_up_mask:			EQU	1<<button_up	; $01
button_down_mask:		EQU	1<<button_down	; $02
button_left_mask:		EQU	1<<button_left	; $04
button_right_mask:		EQU	1<<button_right	; $08
button_B_mask:			EQU	1<<button_B	; $10
button_C_mask:			EQU	1<<button_C	; $20
button_A_mask:			EQU	1<<button_A	; $40
button_start_mask:		EQU	1<<button_start	; $80

; ---------------------------------------------------------------------------
; Player Status Variables
Status_Facing       = 0
Status_InAir        = 1
Status_Roll         = 2
Status_OnObj        = 3
Status_RollJump     = 4
Status_Push         = 5
Status_Underwater   = 6

; ---------------------------------------------------------------------------
; Player status_secondary variables
Status_Shield       = 0
Status_Invincible   = 1
Status_SpeedShoes   = 2

Status_FireShield   = 4
Status_LtngShield   = 5
Status_BublShield   = 6

; ---------------------------------------------------------------------------
; Elemental Shield DPLC variables
LastLoadedDPLC      = $34
Art_Address         = $38
DPLC_Address        = $3C

; ---------------------------------------------------------------------------
; Address equates
; ---------------------------------------------------------------------------

; Z80 addresses
Z80_RAM =			$A00000 ; start of Z80 RAM
Z80_RAM_end =			$A02000 ; end of non-reserved Z80 RAM
Z80_bus_request =		$A11100
Z80_reset =			$A11200

SRAM_access_flag =		$A130F1
Security_addr =			$A14000
; ---------------------------------------------------------------------------

; I/O Area
HW_Version =				$A10001
HW_Port_1_Data =			$A10003
HW_Port_2_Data =			$A10005
HW_Expansion_Data =			$A10007
HW_Port_1_Control =			$A10009
HW_Port_2_Control =			$A1000B
HW_Expansion_Control =		$A1000D
HW_Port_1_TxData =			$A1000F
HW_Port_1_RxData =			$A10011
HW_Port_1_SCtrl =			$A10013
HW_Port_2_TxData =			$A10015
HW_Port_2_RxData =			$A10017
HW_Port_2_SCtrl =			$A10019
HW_Expansion_TxData =		$A1001B
HW_Expansion_RxData =		$A1001D
HW_Expansion_SCtrl =		$A1001F
; ---------------------------------------------------------------------------

; VDP addresses
VDP_data_port =			$C00000
VDP_control_port =		$C00004
PSG_input =			$C00011
; ---------------------------------------------------------------------------

; sign-extends a 32-bit integer to 64-bit
; all RAM addresses are run through this function to allow them to work in both 16-bit and 32-bit addressing modes
	phase $FFFF0000
RAM_start:
Chunk_table			ds.b $7880	; $8000 bytes ; chunk (128x128) definitions, $80 bytes per definition
Sprite_table_buffer_2		ds.b $280	; alternate sprite table for player 1 in competition mode
Sprite_table_buffer_P2		ds.b $280	; sprite table for player 2 in competition mode
Sprite_table_buffer_P2_2	ds.b $280	; alternate sprite table for player 2 in competition mode
Level_layout_header		ds.b 8		; first word = chunks per FG row, second word = chunks per BG row, third word = FG rows, fourth word = BG rows
Level_layout_main		ds.b $FF8	; $40 word-sized line pointers followed by actual layout data
Block_table			ds.b $1A00	; block (16x16) definitions, 8 bytes per definition
Stat_table
Pos_table			ds.b $100
Pos_table_P2			ds.b $100	; used by Player 2 in competition mode
prlayersize =	$80
Sprite_table_input		ds.b prlayersize*8; 8 priority levels, $80 bytes per level

Object_RAM:					; $4A bytes per object, 110 objects
Player_1			ds.b object_size; main character in 1 player mode, player 1 in Competition mode
Player_2			ds.b object_size; Tails in a Sonic and Tails game, player 2 in Competition mode
Reserved_object_3		ds.b object_size; during a level, an object whose sole purpose is to clear the collision response list is stored here
Dynamic_object_RAM		ds.b 90*object_size; $1A04 bytes ; 90 objects
Level_object_RAM		ds.b object_size; $4EA bytes ; various fixed in-level objects
Breathing_bubbles		ds.b object_size; for the main character
Breathing_bubbles_P2		ds.b object_size; for Tails in a Sonic and Tails game
Super_stars					; for Super Sonic and Super Knuckles
Hyper_trail					; for Hyper Sonic and Hyper Knuckles
Tails_tails_2P			ds.b object_size; Tails' tails in Competition mode
Tails_tails			ds.b object_size; Tails' tails
Dust				ds.b object_size
Dust_P2				ds.b object_size
Shield				ds.b object_size
Shield_P2			ds.b object_size
Hyper_Sonic_stars
Super_Tails_birds		ds.b object_size*4
Invincibility_stars		ds.b object_size*4

				ds.b $34
Kos_decomp_buffer		ds.b $1000	; each module in a KosM archive is decompressed here and then DMAed to VRAM
H_scroll_buffer			ds.b $380	; horizontal scroll table is built up here and then DMAed to VRAM
Collision_response_list		ds.b $80	; only objects in this list are processed by the collision response routines

MonContTable			ds.b $80	; Monitor Contents table for displayed on HUD. 2 longwords per entry, 8 entries per player, 2 players.
			ds.b $200
RandomLevList			ds.b $20	; reserved space for random level selection
RandomMiniList			ds.b $20	; reserved space for random mini selection
MonContPos			ds.b 1		; clear if using normal y-pos, set if offscreen
EnableInterlace			ds.b 1		; if set, player's will flicker, like in Sonic Bash
BoxAnglePos			ds.w 1		; QQ.DD the actual rotation position (so it moves towards the destination)
SpawnBoxPos			ds.w 1		; offset for spawn position array
BoxAngle			ds.w 1		; QQ.DD fixed point 8-bit
BoxAngleFrame			ds.b 1		; previous frame's "BoxAngle"
TagWinner					; The player who is the one trying to tag the other. (1 = Sonic, 2 = Tails)
BoxWinner			ds.b 1		; winner so far (00 = no-one | 01 = player 1 | 02 = player 2)
BoxRotSprite			ds.w 1		; first byte for the arrow moving in/out, second byte for blink count
BoxWinnerFrame			ds.w 1		; for art updating (keep lower byte 00)
SpawnWait			ds.b 1		; Check to wait til both players are onscreen, so when they respawn they dont get killed
BoxValidAngle			ds.b 1		; flag for if a valid angle exists or not (00 = No | FF = Yes)
BoxArrowDist			ds.w 1		; distance arrow is from centre
WinsPl1				ds.b 1		; The num of times player 1 has won
WinsPl2				ds.b 1		; The num of times player 2 has won
OptBits_Menu			ds.b 1		; Same as OptionsBits, but used in menus. Modes may and + or the value for specific settings ingame
; Options bits
; 0 - If set, all monitors are randomized (except hidden ones at end :V)
; 1 - If set, there are hidden monitors at the end of the level
; 2 - If set, floating monitors exist
; 3 - If set, players can use shield moves
; 4 - If set, players can bounce off of each other
; 5 - If set, bosses will spawn at end of level
; 6 - If set, players will spawn only when A/B/C is pressed. DEBUG TEMPORARY
; 7 - If set, alternate layouts are used.
OptionsBits			ds.b 1		; Bitfiled for selected options
HudPos				ds.l 1		; vertical position of HUD
ArrowDist			ds.w 1		; previous distance between the players

BoxArr2Script			ds.l 1		; The current script ID we are running
BoxArr2Timer			ds.b 1		; The timer for the frame changing
BoxArr2TimerBack		ds.b 1		; The saved timer for frame changing
BoxArr2Count			ds.b 1		; The number of times to change a frame
BosArr2Dir			ds.b 1		; If 0, move forwards, if -1, move backwards
BoxArr2Frame			ds.w 1		; Offset of the frame we are currently at
BoxLoopArea			ds.b 1		; if the box is within a loop area (00 No | FF Yes)
; Valid play modes
; 0 - Battle Race
; 2 - Team mode
; 4 - Tag mode
; 6 - Minigames
PlayMode			ds.b 1		; What the current play mode is
SwapNum				ds.b 1		; the ID of the last swap list item.
LevelWinner			ds.b 1		; The player who won (0 = draw, 1 = Sonic, -1 = Tails)

; --- Level select variables ---
; (THESE CANNOT BE CLEARED AT ANY TIME OUTSIDE OF TITLE SCREEN)
LS_LevelHighlight		ds.w 1		; main game level selected/highlighted
LS_MiniHighlight		ds.w 1		; mini game level selected/highlighted
LS_ReservedHigh01		ds.w 1		; reserved level selected/highlighted (if a new list is made)
LS_ReservedHigh02		ds.w 1		; reserved level selected/highlighted (if a new list is made)

LS_SoundTest			ds.w 1
LS_StageList			ds.l 1
LS_ScreenMode			ds.l 1
LS_MenuPos			ds.b 1
			ds.b 1
LS_OptionsSelect		ds.b 1
LS_Tempo			ds.b 1

Ring_status_table		ds.b $400	; 1 word per ring
Object_respawn_table		ds.b $300	; 1 byte per object, every object in the level gets an entry

Camera_RAM					; various camera and scroll-related variables are stored here
H_scroll_amount			ds.w 1		; number of pixels camera scrolled horizontally in the last frame * $100
V_scroll_amount			ds.w 1		; number of pixels camera scrolled vertically in the last frame * $100
CamFollow_X			ds.w 1		; X position for camera to follow
CamFollow_Y			ds.w 1		; Y position for camera to follow
Debug_cheat_flag		ds.w 1		; set if the debug cheat's been entered
Scroll_lock			ds.b 1		; if this is set scrolling routines aren't called
LRZ_Rock_Routine		ds.b 1
Camera_target_min_X_pos		ds.w 1
Camera_target_max_X_pos		ds.w 1
Camera_target_min_Y_pos		ds.w 1
Camera_target_max_Y_pos		ds.w 1		; this is the only one which ever differs from its target value
Camera_min_X_pos		ds.w 1
Camera_max_X_pos		ds.w 1
Camera_min_Y_pos		ds.w 1
Camera_max_Y_pos		ds.w 1
Camera_min_X_pos_P2		ds.w 1
Camera_max_X_pos_P2		ds.w 1
Camera_min_Y_pos_P2		ds.w 1
Camera_max_Y_pos_P2		ds.w 1
H_scroll_frame_offset		ds.w 1		; if this is non-zero with value x, horizontal scrolling will be based on the player's position x / $100 + 1 frames ago
Pos_table_index			ds.w 1		; goes up in increments of 4
H_scroll_frame_offset_P2	ds.w 1
Pos_table_index_P2		ds.w 1
Distance_from_screen_top	ds.w 1		; the vertical scroll manager scrolls the screen until the player's distance from the top of the screen is equal to this (or between this and this + $40 when in the air). $60 by default
Distance_from_screen_top_P2	ds.w 1
Deform_lock			ds.b 1
Dynamic_resize_routine		ds.b 1
Camera_max_Y_pos_changing	ds.b 1		; set when the maximum camera Y pos is undergoing a change
Fast_V_scroll_flag		ds.b 1		; if this is set vertical scroll when the player is on the ground and has a speed of less than $800 is capped at 24 pixels per frame instead of 6
			ds.b $A
BG_Offset_X			ds.w 1
BG_Offset_Y			ds.w 1
Ring_start_addr_ROM		ds.l 1		; address in the ring layout of the first ring whose X position is >= camera X position - 8
Ring_end_addr_ROM		ds.l 1		; address in the ring layout of the first ring whose X position is >= camera X position + 328
Ring_start_addr_RAM		ds.w 1		; address in the ring status table of the first ring whose X position is >= camera X position - 8
Ring_end_addr_RAM		ds.w 1		; address in the ring status table of the first ring whose X position is >= camera X position + 328
Apparent_zone_and_act
Apparent_zone			ds.b 1		; always equal to actual zone
Apparent_act			ds.b 1		; for example, after AIZ gets burnt, this indicates act 1 even though it's actually act 2
Palette_fade_timer		ds.w 1		; the palette gets faded in until this timer expires
MonContY			ds.w 1		; Y-position of the monitor contents HUD
			ds.b 6
SinglePlayer			ds.b 1
Act_3_flag			ds.b 1		; set when entering LRZ 3 or DEZ 3 directly from previous act. Prevents title card from loading
Mon_RandomizedShield		ds.w 1		; Randomized shields data for players. 2 bits per shield, 2 bytes for player 1 and 2
Debug_mode_flag			ds.b 1
Debug_On			ds.b 1		; both routine and type
Camera_X_pos_P2			ds.l 1
Camera_Y_pos_P2			ds.l 1
Camera_X_pos_P2_copy		ds.l 1
Camera_Y_pos_P2_copy		ds.l 1
WinTimePL1			ds.l 1
MiniTimer =			WinTimePL1+1	; various timers for minigames
TagTimer =			WinTimePL1	; The number of frames til player 1 wins
TagTimer2 =			WinTimePL1+2	; The number of frames til player 2 wins
TagCool						; cooldown timer for tagging in tag mode
ResultsShown					; set if results are shown in CNZ1 minigame
WinTimePL2			ds.l 1
DisplayTimer =			WinTimePL2+2	; timer for displaying Minitimer
Camera_X_pos			ds.l 1
Camera_Y_pos			ds.l 1
Camera_X_pos_copy		ds.l 1
Camera_Y_pos_copy		ds.l 1
Camera_X_pos_rounded		ds.w 1		; rounded down to the nearest block boundary ($10th pixel)
Camera_Y_pos_rounded		ds.w 1		; rounded down to the nearest block boundary ($10th pixel)
Camera_X_pos_BG_copy		ds.l 1
Camera_Y_pos_BG_copy		ds.l 1
Camera_X_pos_BG_rounded		ds.w 1		; rounded down to the nearest block boundary ($10th pixel)
Camera_Y_pos_BG_rounded		ds.w 1		; rounded down to the nearest block boundary ($10th pixel)
__u_EE98			ds.w 1
__u_EE9A			ds.w 1
__u_EE9C			ds.l 1
__u_EEA0			ds.w 1
__u_EEA2			ds.b 1
			ds.b 1
Plane_double_update_flag	ds.b 1		; set when two block are to be updated instead of one (i.e. the camera's scrolled by more than $10 pixels)
__u_F712			ds.b 1
Special_V_int_routine		ds.w 1
Screen_X_wrap_value		ds.w 1		; set to $FFFF
Screen_Y_wrap_value		ds.w 1		; either $7FF or $FFF
Camera_Y_pos_mask		ds.w 1		; either $7F0 or $FF0
Layout_row_index_mask		ds.w 1		; either $3C or $7C

__u_EEB0			ds.w 1
Special_Events_Routine		ds.w 1
ScrEvents_0			ds.w 1
__u_EEB6			ds.w 1
__u_EEB8			ds.l 1
Displace_Obj_X			ds.w 1
__u_EEBE			ds.w 1
ScrEvents_Routine		ds.w 1
TrigEvents_Routine		ds.w 1
ScrEvents_1			ds.w 1
ScrEvents_2			ds.w 1
DrawDelayed_Position		ds.w 1
DrawDelayed_RowCount		ds.w 1
ScrShake_Value			ds.w 1
ScrShake_Offset			ds.w 1
ScrShake_Offset_Prev		ds.w 1
ScrEvents_Routine2		ds.w 1
ScrEvents_3			ds.w 1
ScrEvents_4			ds.w 1
ScrEvents_5			ds.w 1
ScrEvents_6			ds.w 1
ScrEvents_7			ds.w 1
ScrEvents_8			ds.w 1
ScrEvents_9			ds.w 1
ScrEvents_A			ds.w 1
ScrEvents_B			ds.w 1
ScrEvents_C			ds.w 1
ScrEvents_D			ds.w 1
ScrEvents_E			;ds.w 1
VScrollBuffer			ds.l 20
ScrEvents_F =			VScrollBuffer+2 ; EEEC
__u_EEEE =			VScrollBuffer+4
__u_EEF2 =			VScrollBuffer+8
__u_EEF4 =			VScrollBuffer+$A
__u_EEF6 =			VScrollBuffer+$C
__u_EEFA =			VScrollBuffer+$10
ScrEvents_10			ds.w 1

Use_normal_sprite_table		ds.w 1		; if this is set Sprite_table_buffer and Sprite_table_buffer_P2 will be DMAed instead of Sprite_table_buffer_2 and Sprite_table_buffer_P2_2
Chg_sprite_table		ds.w 1
__u_EF40			ds.l 1
__u_EF44			ds.l 1
Demo_number			ds.w 1		; the currently running demo
			ds.b $E
Object_index_addr		ds.l 1		; points to either the object index for S3 levels or that for S&K levels
Act3_TempRings			ds.w 1
Act3_TempTime			ds.l 1
Camera_Y_pos_coarse_back	ds.w 1		; Camera_Y_pos_coarse - $80
ScrShake_Value_BG		ds.w 1

Cam_HoldPos			ds.w 1		; cameras' position when the screen is lagging for spindash/fire shield dash.
Debug_PosX			ds.l 1		; debug mode X position
Debug_PosY			ds.l 1		; debug mode Y position
Debug_Speed			ds.l 1		; debug movement speed
Debug_Angle			ds.w 1		; angle of players from centre
Debug_Dist			ds.w 1		; distance of players from centre
Debug_BoxPlay1			ds.l 1		; address of player 1's object routine
Debug_BoxPlay2			ds.l 1		; address of player 2's object routine

Ring_consumption_table				; stores the addresses of all rings currently being consumed
Ring_consumption_count		ds.w 1		; the number of rings being consumed currently
Ring_consumption_list		ds.b $7E	; the remaining part of the ring consumption table
Plane_buffer			ds.b $480	; used by level drawing routines
VRAM_buffer			ds.b $80	; used to temporarily hold data while it is being transferred from one VRAM location to another
Target_water_palette		ds.b $80	; used by palette fading routines
Water_palette			ds.b $20	; this is what actually gets displayed
Water_palette_line_2		ds.b $20
Water_palette_line_3		ds.b $20
Water_palette_line_4		ds.b $20

Game_mode			ds.b 1
Sprites_drawn			ds.b 1		; used to ensure the sprite limit isn't exceeded
Ctrl_1_logical					; both held and pressed
Ctrl_1_held_logical		ds.b 1
Ctrl_1_pressed_logical		ds.b 1
Ctrl_1						; both held and pressed
Ctrl_1_held			ds.b 1		; all held buttons
Ctrl_1_pressed			ds.b 1		; buttons being pressed newly this frame
Ctrl_2						; both held and pressed
Ctrl_2_held			ds.b 1
Ctrl_2_pressed			ds.b 1
VDP_reg_1_command		ds.w 1		; AND the lower byte by $BF and write to VDP control port to disable display, OR by $40 to enable
			ds.b $A
Demo_timer			ds.w 1		; the time left for a demo to start/run
V_scroll_value					; both foreground and background
V_scroll_value_FG		ds.w 1
V_scroll_value_BG		ds.w 1
			ds.b $A
H_int_counter_command		ds.w 1		; contains a command to write to VDP register $0A (line interrupt counter)
H_int_counter =			H_int_counter_command+1; just the counter part of the command
Palette_fade_info				; both index and count
Palette_fade_index		ds.b 1		; colour to start fading from
Palette_fade_count		ds.b 1		; the number of colours to fade
Lag_frame_count			ds.w 1		; more specifically, the number of times V-int routine 0 has run. Reset at the end of a normal frame
Game_paused			ds.w 1
DMA_trigger_word		ds.w 1		; transferred from RAM to avoid crashing the Mega Drive
V_int_routine
Water_palette_data_addr		ds.l 1		; points to the water palette data for the current level
PalCyc_Counters			ds.l 1
			ds.b $E
H_int_flag			ds.w 1		; unless this is set H-int will return immediately
Water_level			ds.w 1		; keeps fluctuating
Mean_water_level		ds.w 1		; the steady central value of the water level
Target_water_level		ds.w 1
Water_speed			ds.b 1		; this is added to or subtracted from Mean_water_level every frame till it reaches Target_water_level
Water_entered_counter		ds.b 1		; incremented when entering and exiting water, read by the the floating AIZ spike log, cleared on level initialisation and dynamic events of certain levels
Water_full_screen_flag		ds.b 1		; set if water covers the entire screen (i.e. the underwater pallete should be DMAed during V-int rather than the normal palette)
Do_Updates_in_H_int		ds.b 1		; if this is set Do_Updates will be called from H-int instead of V-int
PalCyc_Counters2		ds.b $C
Palette_frame			ds.w 1
Palette_timer			ds.b 1
Super_Hyper_palette_status	ds.b 1		; appears to be a flag for the palette's current status: '0' for 'off', '1' for 'fading', -1 for 'fading done'
RNG_seed			ds.l 1		; used by the random number generator
BG_Collision			ds.b 1
Border_Bottom_Death		ds.b 1
Hyper_Sonic_flash_timer		ds.b 1		; used for Hyper Sonic's double jump move
Super_Tails_flag		ds.b 1
Palette_frame_Tails		ds.b 1		; Tails would use Palette_frame and Palette_timer, but they're reserved for his Super Flickies
Palette_timer_Tails		ds.b 1
Ctrl_2_logical					; both held and pressed
Ctrl_2_held_logical		ds.b 1
Ctrl_2_pressed_logical		ds.b 1
__u_F66C			ds.b 1

Scroll_force_positions		ds.b 1		; if this is set scrolling will be based on the two variables below rather than the player's actual position
BossHitsP1			ds.b 1		; Number of hits done to a boss for Sonic
BossHitsP2			ds.b 1		; Number of hits done to a boss for Tails
BossHitMode					; If set, boss hit mode is enabled
ModeTable			ds.l 1		; mode table address. Contains data used by game modes
Super_Hyper_frame_count		ds.w 1
CameraOffY			ds.w 1		; y-offset of camera
Scroll_forced_X_pos		ds.w 1
Scroll_forced_Y_pos		ds.w 1
				ds.l 1

Kos_module_queue_size =		6*$15		; size of entire queue ($7E)
Kos_module_queue				; 6 bytes per entry, first longword is source location and next word is VRAM destination
Kos_module_source		ds.b Kos_module_queue_size; the compressed data location for the first module in the queue
Kos_module_destination =	Kos_module_queue+4; the VRAM destination for the first module in the queue
Kos_module_Error		ds.w 1

__u_F700			ds.w 1
CPU_Control_Ctr			ds.w 1
Tails_Respawn_Ctr		ds.w 1
Emerald_count					; both chaos and super emeralds
Chaos_emerald_count		ds.b 1
Super_emerald_count		ds.b 1
CPU_Routine			ds.w 1
CPU_Target_X			ds.w 1
CPU_Target_Y			ds.w 1
Tails_Interact			ds.w 1
Rings_manager_routine		ds.b 1
Level_started_flag		ds.b 1
			ds.b $2A
AIZ_Palette_Flag		ds.b 1
Water_flag			ds.b 1
Flying_carrying_Sonic_flag	ds.b 1		; set when Tails carries Sonic in a Sonic and Tails game
Flying_picking_Sonic_timer	ds.b 1		; until this is 0 Tails can't pick Sonic up
Software_Scaler_Unk		ds.w 1
__u_F744			ds.w 1
SavedTileP1			ds.w 1		; Saved Tile of Player 1
SavedTileP2			ds.w 1		; Saved Tile of Player 2

__u_F74C			ds.w 1
__u_F74E			ds.b 1
Wallgrab_Disable		ds.b 1
Debug00				ds.l 1		; long-word debug number
Debug01				ds.l 1
Debug02				ds.l 1
Debug03				ds.l 1
Debug04				ds.l 1

Sonic_Knux_top_speed		ds.w 1
Sonic_Knux_acceleration		ds.w 1
Sonic_Knux_deceleration		ds.w 1
Sonic_Knux_Mapnum		ds.b 1
Boss_flag			ds.b 1		; set if a boss fight is going on
Primary_Angle			ds.b 1
			ds.b 1
Secondary_Angle			ds.b 1
Last_star_post_hit		ds.b 1
Object_load_routine		ds.w 1		; routine counter for the object loading manager
Camera_X_pos_coarse		ds.w 1		; rounded down to the nearest chunk boundary (128th pixel)
Camera_Y_pos_coarse		ds.w 1		; rounded down to the nearest chunk boundary (128th pixel)
Object_load_addr_front		ds.l 1		; the address inside the object placement data of the first object whose X pos is >= Camera_X_pos_coarse + $280
Object_load_addr_back		ds.l 1		; the address inside the object placement data of the first object whose X pos is >= Camera_X_pos_coarse - $80
Object_respawn_index_front	ds.w 1		; the object respawn table index for the object at Obj_load_addr_front
Object_respawn_index_back	ds.w 1		; the object respawn table index for the object at Obj_load_addr_back
Competition_mode		ds.w 1
ColArrayNorm			ds.l 1		; address of collision array normal
ColArrayRot			ds.l 1		; address of collision array rotated
ColArrayAngle			ds.l 1		; address of collision array angles
			ds.b $8
Palfade_Timer			ds.w 1
Collision_addr			ds.l 1		; points to the primary or secondary collision data as appropriate
			ds.b $16
__u_F7B0			ds.l 1
Primary_collision_addr		ds.l 1
Secondary_collision_addr	ds.l 1
PlayerSpawn			ds.l 1		; Custom spawning positions for players
Pollen_Counter			ds.b 1
__u_F7C1			ds.b 1
__u_F7C2			ds.b 1
__u_F7C3			ds.b 1
__u_F7C4			ds.w 1
Reverse_gravity_flag		ds.b 1
__u_F7C7			ds.b 1
WindTunnel_flag			ds.b 1
WindTunnel_flag_P2		ds.b 1
Ctrl_1_locked			ds.b 1
Ctrl_2_locked			ds.b 1
GhostAddress			ds.l 1		; NAT: address of the ghost demo we're processing currently
Chain_bonus_counter		ds.w 1
Time_bonus_countdown		ds.w 1		; used on the results screen
Ring_bonus_countdown		ds.w 1		; used on the results screen
SpecialEnemyCtr			ds.b 1		; enemy counter for some minigames
SpecialEnemyFlag		ds.b 1		; if set, each time an enemy is hit, player gets a point
Level_select_flag		ds.b 1
NoReset_RespawnTbl		ds.b 1
Camera_X_pos_coarse_back	ds.w 1		; Camera_X_pos_coarse - $80
Demo_mode_flag			ds.w 1
Tails_Mapnum			ds.b 1
Tails_Tail_Mapnum		ds.b 1

Level_trigger_array		ds.b $10	; used by buttons, etc.
Anim_Counters			ds.b $10	; each word stores data on animated level art, including duration and current frame
Sprite_table_buffer		ds.b $280

__u_FA80			ds.w 1
__u_FA82			ds.w 1
__u_FA84			ds.w 1
__u_FA86			ds.w 1
__u_FA88			ds.b 1
MechaHead_DeleteFlag		ds.b 1
__u_FA8A			ds.w 4
__u_FA92			ds.w 1
__u_FA94			ds.w 1
__u_FA96			ds.w 1
__u_FA98			ds.w 1
__u_FA9A			ds.w 1
			ds.b 4
LastHUD				ds.w 1		; last second value written to HUD
__u_FAA2			ds.b 1
__u_FAA3			ds.b 1
__u_FAA4			ds.w 1
Signpost_Ptr			ds.w 1
End_Of_Level_Flag		ds.b 1
__u_FAA9			ds.b 1
Title_Card_Out_Flag		ds.b 1
__u_FAAB			ds.b 1
__u_FAAC			ds.b 1
__u_FAAD			ds.b 1
__u_FAAE			ds.w 1
__u_FAB0			ds.w 1
__u_FAB2			ds.w 1
__u_FAB4			ds.w 1
__u_FAB6			ds.w 1
__u_FAB8			ds.b 1
Update_PalRotation_Flag		ds.b 1
__u_FABA			ds.w 1
__u_FABC			ds.w 1
HCZ_Conveyors			ds.b $F
__u_FACD			ds.b 1
__u_FACE			ds.w 1
			ds.b $A
__u_FADA			ds.l 1
PalRotation_Data		ds.b $10
PalRotation_Null		ds.w 1		; DO NOT MOVE
__u_FAF0			ds.l 1
__u_FAF4			ds.l 1
__u_FAF8			ds.w 1
__u_FAFA			ds.w 1
__u_FAFC			ds.l 1

DMA_queue			ds.b $FC	; stores all the VDP commands necessary to initiate a DMA transfer
DMA_queue_slot			ds.w 1		; points to the next free slot on the queue
V_blank_cycles			ds.w 1		; the number of cycles between V-blanks
Normal_palette			ds.b $20
Normal_palette_line_2		ds.b $20
Normal_palette_line_3		ds.b $20
Normal_palette_line_4		ds.b $20
Target_palette			ds.b $20	; used by palette fading routines
Target_palette_line_2		ds.b $20
Target_palette_line_3		ds.b $20
Target_palette_line_4		ds.b $20

				ds.b $100	; this is stack data. IT IS USED, NOT UNUSED
System_stack					; this is the top of the stack, it grows downwards
Debug_Obj			ds.w 1		; pointer to the object we are holding
Monitor_Frame_Offset		ds.w 1		; art offset of the floating monitor fan
Level_frame_counter		ds.w 1		; the number of frames which have elapsed since the level started
LRZ_Spec_Rocks			ds.l 1		; used by LRZ

Total_bonus_countup		ds.w 1		; the total points to be added due to various bonuses this frame in the end of level results screen
V_int_run_count			ds.l 1		; the number of times V-int has run
Current_zone_and_act
Current_zone			ds.b 1
Current_act			ds.b 1
SpecialStage_Player1		ds.b 1		; SEE "Special Stage\Source - Special Stage.asm" FOR DETAILS
SpecialStage_Player2		ds.b 1		; SEE "Special Stage\Source - Special Stage.asm" FOR DETAILS
Collected_emeralds_array	ds.b 7
Restart_level_flag		ds.b 1
Super_Sonic_Knux_flag		ds.b 1
Update_HUD_ring_count		ds.b 1
Update_HUD_timer		ds.b 1
Update_HUD_score		ds.b 1
Ring_count			ds.b 1
Ring_count_P2			ds.b 1
Timer				ds.l 1
Timer_minute =			Timer+1
Timer_second =			Timer+2
Timer_frame =			Timer+3		; the second gets incremented when this reaches 60
Score				ds.b 1
Score_P2			ds.b 1
Pause_Selection			ds.w 1
__u_FE6A			ds.l 1
OscNumbers			ds.b $42
Rings_frame_timer		ds.b 1
Rings_frame			ds.b 1
Player_mode			ds.w 1		; 0 = Sonic and Tails, 1 = Sonic alone, 2 = Tails alone, 3 = Knuckles alone
Ring_spill_anim_counter		ds.b 1
Ring_spill_anim_frame		ds.b 1
Ring_spill_anim_accum		ds.w 1
__u_FEBA			ds.w 1
Tails_top_speed			ds.w 1
Tails_acceleration		ds.w 1
Tails_deceleration		ds.w 1

PauseSpriteRAM			ds.b $100	; pause sprite storage and RAM usage
Kos_decomp_queue_count		ds.w 1		; the number of pieces of data on the queue. Sign bit set indicates a decompression is in progress
Kos_decomp_stored_registers	ds.b 10*4	; allows decompression to be spread over multiple frames
Kos_decomp_stored_SR		ds.w 1
Kos_decomp_bookmark		ds.l 1		; the address within the Kosinski queue processor at which processing is to be resumed
Kos_description_field		ds.w 1		; used by the Kosinski queue processor the same way the stack is used by the normal Kosinski decompression routine
Kos_decomp_queue				; 2 longwords per entry, first is source location and second is decompression location
Kos_decomp_source		ds.b $20	; the compressed data location for the first entry in the queue
Kos_decomp_destination =	Kos_decomp_queue+4; the decompression location for the first entry in the queue
Kos_modules_left		ds.b 1		; the number of modules left to decompresses. Sign bit set indicates a module is being decompressed/has been decompressed
SpecialStage_Mode		ds.b 1		; SEE "Special Stage\Source - Special Stage.asm" FOR DETAILS
Kos_last_module_size		ds.w 1		; the uncompressed size of the last module in words. All other modules are $800 words

BoxLoc_Level			ds.l 1		; the starting address of the level's box list
BoxLoc_Play1			ds.l 1		; the current box list entry location for player 1
BoxLoc_Play2			ds.l 1		; the current box list entry location for player 2
BoxLoc_Valid			ds.l 1		; Last valid box a player was in
__u_FF7C			ds.w 1
__u_FF7E			ds.w 1
Level_music			ds.W 1
Graphics_flags			ds.b 1		; bit 7 set = English system, bit 6 set = PAL system
			ds.b 1
SK_alone_flag			ds.w 1		; -1 if Sonic 3 isn't locked on
V_int_jump			ds.w 1		; contains an instruction to jump to the V-int handler
V_int_addr			ds.l 1
H_int_jump			ds.w 1		; contains an instruction to jump to the H-int handler
H_int_addr			ds.l 1
Checksum_string			ds.l 1		; set to 'SM&K' once the checksum routine has run

	if * <> 0
		fatal "RAM map ended at $\{*}"
	endif

	!org 0
	phase 0

; ---------------------------------------------------------------------------
; Art tile stuff
palette_line_0      =      (0<<13)
palette_line_1      =      (1<<13)
palette_line_2      =      (2<<13)
palette_line_3      =      (3<<13)
high_priority       =      (1<<15)
tile_mask           =      $07FF
drawing_mask        =      $7FFF

; ---------------------------------------------------------------------------
; VRAM and tile art base addresses.
; VRAM Reserved regions.
VRAM_Plane_A_Name_Table               = $C000	; Extends until $CFFF
VRAM_Plane_B_Name_Table               = $E000	; Extends until $EFFF

; Menu background.
ArtTile_ArtKos_S3MenuBG               = $0001

; Competition mode.
ArtTile_ArtKos_Competition_LevSel     = $029F
ArtTile_ArtKos_Competition_ModeSel    = $034A
ArtTile_ArtKos_Competition_Results    = $034A
ArtTile_ArtKos_Competition_CharSel    = $05C9

; Save screen.
ArtTile_ArtKos_Save_Misc              = $029F
ArtTile_ArtKos_Save_Extra             = $0454

; ---------------------------------------------------------------------------
; Universal locations.

; Universal (used on all standard levels).
ArtTile_ArtNem_Powerups =	$04C4
ArtTile_ArtUnc_Sonic =		$0680			; Sonic uses $1D
ArtTile_ArtUnc_Tails =		ArtTile_ArtUnc_Sonic+$1D; Tails uses $18 tiles...
ArtTile_ArtUnc_Tails_Tails =	ArtTile_ArtUnc_Tails+$10; $9 tiles
ArtTile_ArtUnc_Shield =		$79C			; $24
ArtTile_ArtUnc_Shield2 =	$6B6
AT_FM =				$6DE
AT_PR =				$6DA
AT_Explosion =			$57C
ArtTile_ArtNem_Ring =		$5B0
AT_HUD =			ArtTile_ArtNem_Ring+$E
AT_HUD_Numbers =		AT_HUD+$14
AT_HUD_Timer =			AT_HUD_Numbers+$18
AT_HUD_End =			AT_HUD_Timer+$A

; Codepage for level select

	save
	codepage LEVELSELECT
	CHARSET '0','9', 16
	CHARSET 'A','Z', 30
	CHARSET 'a','z', 30
	CHARSET '*', 26
	CHARSET $A9, 27	; '?'
	CHARSET ':', 28
	CHARSET '.', 29
	CHARSET ' ',  0
	restore

StageOffset_NAT =	4*0
