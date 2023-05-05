; ---------------------------------------------------------------------------
; Constants
; ---------------------------------------------------------------------------

Size_of_SegaPCM:		equ $6978

; VDP addressses
vdp_data_port:		equ $C00000
vdp_control_port:	equ $C00004
vdp_counter:		equ $C00008

psg_input:		equ $C00011

; Z80 addresses
z80_ram:		equ $A00000	; start of Z80 RAM
z80_dac3_pitch:		equ $A000EA
z80_dac_status:		equ $A01FFD
z80_dac_sample:		equ $A01FFF
z80_ram_end:		equ $A02000	; end of non-reserved Z80 RAM
z80_version:		equ $A10001
z80_port_1_data:	equ $A10002
z80_port_1_control:	equ $A10008
z80_port_2_control:	equ $A1000A
z80_expansion_control:	equ $A1000C
z80_bus_request:	equ $A11100
z80_reset:		equ $A11200
ym2612_a0:		equ $A04000
ym2612_d0:		equ $A04001
ym2612_a1:		equ $A04002
ym2612_d1:		equ $A04003

security_addr:		equ $A14000

; VRAM data
vram_fg:	equ $C000	; foreground namespace
vram_bg:	equ $E000	; background namespace
vram_sonic:	equ $A320	; Sonic graphics
vram_shi	equ $A600
vram_check	equ $AAC0
vram_sprites:	equ $F800	; sprite table
vram_hscroll:	equ $FC00	; horizontal scroll table

; Game modes
id_Sega:	equ ptr_GM_Sega-GameModeArray	; $00
id_Title:	equ ptr_GM_Title-GameModeArray	; $04
id_Demo:	equ ptr_GM_Demo-GameModeArray	; $08
id_Level:	equ ptr_GM_Level-GameModeArray	; $0C
id_Special:	equ ptr_GM_Special-GameModeArray; $10
id_Continue:	equ ptr_GM_Cont-GameModeArray	; $14
id_Ending:	equ ptr_GM_Ending-GameModeArray	; $18
id_Credits:	equ ptr_GM_Credits-GameModeArray; $1C

; Levels
id_GHZ:		equ 0
id_LZ:		equ 1
id_MZ:		equ 2
id_SLZ:		equ 3
id_SYZ:		equ 4
id_SBZ:		equ 5
id_EndZ:	equ 6
id_SS:		equ ZoneCount	; 7 by default

; Colours
cBlack:		equ $000		; colour black
cWhite:		equ $EEE		; colour white
cBlue:		equ $E00		; colour blue
cGreen:		equ $0E0		; colour green
cRed:		equ $00E		; colour red
cYellow:	equ cGreen+cRed		; colour yellow
cAqua:		equ cGreen+cBlue	; colour aqua
cMagenta:	equ cBlue+cRed		; colour magenta

; Joypad input
btnStart:	equ %10000000 ; Start button	($80)
btnA:		equ %01000000 ; A		($40)
btnC:		equ %00100000 ; C		($20)
btnB:		equ %00010000 ; B		($10)
btnR:		equ %00001000 ; Right		($08)
btnL:		equ %00000100 ; Left		($04)
btnDn:		equ %00000010 ; Down		($02)
btnUp:		equ %00000001 ; Up		($01)
btnDir:		equ %00001111 ; Any direction	($0F)
btnABC:		equ %01110000 ; A, B or C	($70)
bitStart:	equ 7
bitA:		equ 6
bitC:		equ 5
bitB:		equ 4
bitR:		equ 3
bitL:		equ 2
bitDn:		equ 1
bitUp:		equ 0

; Object variables
prev		equ 4
next		equ 6
dnext:		equ 8	; next pointer for object display list. Do not use if no display.
dprev:		equ $A	; prev pointer for object display list. Can be used if no display.

obX:		equ $C	; x-axis position (2-4 bytes)
obScreenY:	equ $E	; y-axis position for screen-fixed items (2 bytes)
obY:		equ $10	; y-axis position (2-4 bytes)
obInertia:	equ $14	; potential speed (2 bytes)
obHeight:	equ $16	; height/2
obWidth:	equ $17	; width/2
obRender:	equ $18	; bitfield for x/y flip, display mode
obActWid:	equ $19	; action width
obFrame:	equ $1A	; current frame displayed
obAniFrame:	equ $1B	; current frame in animation script
obAnim:		equ $1C	; current animation
obNextAni:	equ $1D	; next animation
obTimeFrame:	equ $1E	; time to next frame
obDelayAni:	equ $1F	; time to delay animation
obColType:	equ $20	; collision response type
obColProp:	equ $21	; collision extra property
obStatus:	equ $22	; orientation or mode
obRespawnNo:	equ $23	; respawn list index number
obRoutine:	equ $24	; routine number
ob2ndRout:	equ $25	; secondary routine number
obAngle:	equ $26	; angle
childnum	equ $28
obSubtype:	equ $28	; object subtype
obSolid:	equ ob2ndRout ; solid status flag
subtype:	equ $28	; object subtype
child		equ $2A

obMap:		equ $40	; mappings address (4 bytes)
obGfx:		equ $44	; palette line & VRAM setting (2 bytes)
obVelX:		equ $46	; x-axis velocity (2 bytes)
obVelY:		equ $48	; y-axis velocity (2 bytes)
size		equ $4A	; size of each obj

; Object variables (Sonic 2 disassembly nomenclature)
render_flags:	equ obRender; bitfield for x/y flip, display mode
art_tile:	equ obGfx; palette line & VRAM setting (2 bytes)
mappings:	equ 4	; mappings address (4 bytes)
x_pos:		equ 8	; x-axis position (2-4 bytes)
y_pos:		equ $C	; y-axis position (2-4 bytes)
x_vel:		equ $10	; x-axis velocity (2 bytes)
y_vel:		equ $12	; y-axis velocity (2 bytes)
y_radius:	equ $16	; height/2
x_radius:	equ $17	; width/2
priority:	equ $18	; sprite stack priority -- 0 is front
width_pixels:	equ $19	; action width
mapping_frame:	equ $1A	; current frame displayed
anim_frame:	equ $1B	; current frame in animation script
anim:		equ $1C	; current animation
next_anim:	equ $1D	; next animation
anim_frame_duration: equ $1E ; time to next frame
collision_flags: equ $20 ; collision response type
collision_property: equ $21 ; collision extra property
status:		equ $22	; orientation or mode
respawn_index:	equ $23	; respawn list index number
routine:	equ $24	; routine number
routine_secondary: equ $25 ; secondary routine number
angle:		equ $26	; angle

; Animation flags
afEnd:		equ $FF	; return to beginning of animation
afBack:		equ $FE	; go back (specified number) bytes
afChange:	equ $FD	; run specified animation
afRoutine:	equ $FC	; increment routine counter
afReset:	equ $FB	; reset animation and 2nd object routine counter
af2ndRoutine:	equ $FA	; increment 2nd routine counter

	rsset 0
ac_RedCoins	rs.b 4		; red coins for all acts
ac_HidPts	rs.b 4		; hidden points for all acts
ac_dbinvin	rs.b 1		; very invincible
ac_Ristar	rs.b 1		; ring star'
ac_feature	rs.b 1		; just as you imagined it
ac_Oma		rs.b 1		; certain someone says hi
ac_sprun	rs.b 1		; speedrunners
ac_tas		rs.b 1		; TASing
ac_LastMin	rs.b 1		; 9:59:59
ac_EasterEgg	rs.b 1		; literal easter egg
ac_Soft		rs.b 1		; soft reset
ac_AFK		rs.b 1		; afk
ac_life		rs.b 1		; meaning of life
ac_Wrap		rs.b 1		; level wrap
ac_Moved	rs.b 1		; move left or right
ac_CamDown	rs.b 1		; move camera down
ac_CamUp	rs.b 1		; move camera up
ac_Jumped	rs.b 1		; has jumps
ac_Hurt		rs.b 1		; hurt by enemy
ac_WalkAir	rs.b 1		; walk off a ledge
ac_DoAct	rs.b 1		; act completed
ac_KillEnemy	rs.b 1		; fuck that bitch
ac_Roll		rs.b 1		; they see me rollin'
ac_Rings1	rs.b 1		; 1 ring
ac_Rings10	rs.b 1		; 10 rings
ac_Rings100	rs.b 1		; 100 rings
ac_HidPt1	rs.b 1		; collected a hidden point
ac_RedCC	rs.b 1		; collected a red coin
ac_BigRing	rs.b 1		; whats the point
ac_SecAct	rs.b 1		; found secret act
ac_Boss		rs.b 1		; beat the boss~
ac_69		rs.b 1		; 69
ac_ssBoss	rs.b 1		; secret boss
ac_Dead		rs.b 1		; when life gives you lemons
ac_GameOver	rs.b 1		; Frankling is slippin
ac_Speed	rs.b 1		; Sonic
ac_Invins	rs.b 1		;
ac_Airtime	rs.b 1		; get as much air as you can~
ACLEN =		__rs-1		; len
