; Variables (v) and Flags (f)
	rsset 4
vs_dnext	rs.w 1		; sprite queue start
vs_n2		rs.w 1		; must be kept 0
vs_n1		rs.w 1		; must be kept 0
vs_dprev	rs.w 1		; sprite queue end
vs_size	=	__rs-4

	rsset $FFFF0000
v_256x256:	rs.b $8000	; 256x256 tile mappings ($A400 bytes)
KosBuf		rs.w $800	; Kos decomp buffer
KosBufLen =	(__rs-KosBuf)/2	; kosinski decomp buffer size (in words!)
v_scrollingtbl	rs.b $200
v_lvllayout:	rs.b $400	; level and background layouts ($400 bytes)

v_spritequeue =	__rs-4
		rs.b vs_size*8	; sprite queue data

;v_16x16:	rs.b $1800	; 16x16 tile mappings
v_tracksonic:	rs.b $100	; position tracking data for Sonic ($100 bytes)
DMAqueue	rs.w 3*$2A	; DMA queue data, 3 words per entry
DMAqueEnd	rs.w 1		; filler
DMAquePtr	rs.w 1		; pointer to DMA queue datawut

v_snddriver_ram rs.w 0		; start of RAM for the sound driver data
		include "driver/code/macro.asm"
	rsset mSize
v_hscrolltablebuffer rs.b $380	; scrolling table data (actually $380 bytes, but $400 is reserved for it)
v_spritetablebuffer rs.b $280	; sprite table ($280 bytes, last $80 bytes are overwritten by v_pal_water_dup)
v_pal_water_dup rs.b $80	; duplicate underwater palette, used for transitions ($80 bytes)
v_pal_water:	rs.b $80	; main underwater palette ($80 bytes)
v_pal_dry:	rs.b $80	; main palette ($80 bytes)
v_pal_dry_dup:	rs.b $80	; duplicate palette, used for transitions ($80 bytes)
v_objstate:	rs.b $200	; object state list ($200 bytes)
v_player:	rs.w 0		; object variable space for Sonic ($40 bytes)
v_objspace:	rs.b size	; object variable space ($40 bytes per object) ($2000 bytes)
v_lvlobjspace:	rs.b $78*size	; level object variable space ($1800 bytes)
v_objspaceend:	rs.w 0
CollisionList	rs.w $78	; entries for collision response.

KosMqueue	rs.b 6*$11	; KosM queue. More entries because PLC
KosQueue	rs.b 8*4	; Kos queue.
KosDecQueCnt	rs.w 1		; number of Kosinski files queued
KosDecRegs	rs.l 10		; register dump
KosDecSR	rs.w 1		; and SR
KosDecPos	rs.l 1		; bookmark
KosDecDesc	rs.w 1		; not needed by Flamewing's optimized Kos decompression
KosMmodSize	rs.w 1		; size of last module
KosMmodNum	rs.b 1		; number of modules left
v_gamemode:	rs.b 1		; game mode (00=Sega; 04=Title; 08=Demo; 0C=Level; 10=SS; 14=Cont; 18=End; 1C=Credit; +8C=PreLevel)

v_oscillate:	rs.b $42	; values which oscillate - for swinging platforms, et al ($42 bytes)
v_random:	rs.l 1		; pseudo random number buffer (4 bytes)
v_jpadhold1:	rs.b 1		; joypad input - held
v_jpadpress1:	rs.b 1		; joypad input - pressed
v_jpadhold2:	rs.b 1		; joypad input - held, duplicate
v_jpadpress2:	rs.b 1		; joypad input - pressed, duplicate
v_hbla_hreg:	rs.b 1		; VDP H.interrupt register buffer (8Axx) (2 bytes)
v_hbla_line:	rs.b 1		; screen line where water starts and palette is changed by HBlank
v_vdp_buffer1:	rs.w 1		; VDP instruction buffer (2 bytes)
v_vdp_buffer2:	rs.w 1		; VDP instruction buffer (2 bytes)
v_vbla_routine:	rs.b 1		; VBlank - routine counter
v_megadrive:	rs.b 1		; Megadrive machine type
f_hbla_pal:	rs.w 1		; flag set to change palette during HBlank (0000 = no; 0001 = change) (2 bytes)
v_vbla_count:	rs.l 1		; vertical interrupt counter (adds 1 every VBlank) (4 bytes)
v_vbla_word:	equ v_vbla_count+2 ; low word for vertical interrupt counter (2 bytes)
v_vbla_byte:	equ v_vbla_word+1; low byte for vertical interrupt counter
v_framecount:	rs.w 1		; frame counter (adds 1 every frame) (2 bytes)
v_framebyte:	equ v_framecount+1; low byte for frame counter

	if lag=1
LAGF		rs.l 1		; lag frames
	endif

afkctr		rs.l 1		; afk counter
airctr		rs.l 1		; airtime counter
HudPos		rs.l 1		; hud horiz pos

Obj_Tail	rs.l 1		; address of the tail object
ObjPrev_Tail	rs.w 1		; pointer to the last loaded object in the chain
Free_Head	rs.w 1		; head of the free object list

FanficShit	rs.l 3		; ass
Achievements 	rs.l 1		; list of archievements got
Ach_TextAddr	rs.l 1		; text address data
Ach_TextAddr2	rs.l 1		; text address data for "archievement unlocked"
Ach_Xpos	rs.w 1		; x-pos of the archievement text
Ach_Timer	rs.w 1		; timer countdown for when going back
Achi_VRAM	rs.w 1		; VRAM address to write to
Achi_TgtX	rs.w 1		; target x-pos
AchiBits	rs.b (ACLEN/8)+1; bits if some are set

v_extrarender	rs.b 1		; some extra rander shite.
featurectr	rs.b 1		; number of "features" encountered without getting a break
omactr		rs.b 1		; omachao ctr
RedCoinBits	rs.b 1		; red coin bits
HiddenBits	rs.b 1		; hidden point bits
ckpt		rs.b 1		; if starting from checkpoint
hblreg		rs.b 1		; h-blank register update

v_regbuffer:	equ $FFFFFC00	; stores registers d0-a7 during an error event ($40 bytes)
v_spbuffer:	equ $FFFFFC40	; stores most recent sp address (4 bytes)
v_errortype:	equ $FFFFFC44	; error type

AirCount =	3*60		; 3 sec in air oops

; =================================================================================
; From here on, no longer relative to sound driver RAM
; =================================================================================



v_demolength:	equ $FFFFF614	; the length of a demo in frames (2 bytes)
v_scrposy_dup:	equ $FFFFF616	; screen position y (duplicate) (2 bytes)
v_scrposxb_dup:	equ $FFFFF618	; screen position B X (duplicate) (2 bytes)
v_scrposx_dup:	equ $FFFFF61A	; screen position x (duplicate) (2 bytes)

v_pfade_start:	equ $FFFFF626	; palette fading - start position in bytes
v_pfade_size:	equ $FFFFF627	; palette fading - number of colours
someshitaddr	equ $FFFFF628
v_spritecount:	equ $FFFFF62C	; number of sprites on-screen
v_pcyc_num:	equ $FFFFF632	; palette cycling - current reference number (2 bytes)
v_pcyc_time:	equ $FFFFF634	; palette cycling - time until the next change (2 bytes)
f_pause:		equ $FFFFF63A	; flag set to pause the game (2 bytes)
v_waterpos1:	equ $FFFFF646	; water height, actual (2 bytes)
v_waterpos2:	equ $FFFFF648	; water height, ignoring sway (2 bytes)
v_waterpos3:	equ $FFFFF64A	; water height, next target (2 bytes)
f_water:		equ $FFFFF64C	; flag set for water
v_wtr_routine:	equ $FFFFF64D	; water event - routine counter
f_wtr_state:	equ $FFFFF64E	; water palette state when water is above/below the screen (00 = partly/all dry; 01 = all underwater)

v_pal_buffer:	equ $FFFFF650	; palette data buffer (used for palette cycling) ($30 bytes)

v_screenposx:	equ $FFFFF700	; screen position x (2 bytes)
v_screenposy:	equ $FFFFF704	; screen position y (2 bytes)
v_bgscreenposx:	equ $FFFFF708	; background screen position x (2 bytes)
v_bgscreenposy:	equ $FFFFF70C	; background screen position y (2 bytes)
v_bg2screenposx:	equ $FFFFF710	; 2 bytes
v_bg2screenposy:	equ $FFFFF714	; 2 bytes
v_bg3screenposx:	equ $FFFFF718	; 2 bytes
v_bg3screenposy:	equ $FFFFF71C	; 2 bytes

v_limitleft1:	equ $FFFFF720	; left level boundary (2 bytes)
v_limitright1:	equ $FFFFF722	; right level boundary (2 bytes)
v_limittop1:	equ $FFFFF724	; top level boundary (2 bytes)
v_limitbtm1:	equ $FFFFF726	; bottom level boundary (2 bytes)
v_limitleft2:	equ $FFFFF728	; left level boundary (2 bytes)
v_limitright2:	equ $FFFFF72A	; right level boundary (2 bytes)
v_limittop2:	equ $FFFFF72C	; top level boundary (2 bytes)
v_limitbtm2:	equ $FFFFF72E	; bottom level boundary (2 bytes)

v_limitleft3:	equ $FFFFF732	; left level boundary, at the end of an act (2 bytes)

v_scrshiftx:	equ $FFFFF73A	; screen shift as Sonic moves horizontally
v_scrshifty:	equ $FFFFF73C	; screen shift as Sonic moves horizontally

v_lookshift:	equ $FFFFF73E	; screen shift when Sonic looks up/down (2 bytes)
v_dle_routine:	equ $FFFFF742	; dynamic level event - routine counter
f_nobgscroll:	equ $FFFFF744	; flag set to cancel background scrolling
f_hcamredraw	equ $FFFFF74A
f_vcamredraw	equ $FFFFF74B
f_p1h_cambound	equ $FFFFF74C
f_p1v_cambound	equ $FFFFF74D
f_p2h_cambound	equ $FFFFF74E
f_p3h_cambound	equ $FFFFF750

v_bgscroll1:	equ $FFFFF754	; background scrolling variable 1
v_bgscroll2:	equ $FFFFF756	; redraw 1
v_bgscroll3:	equ $FFFFF758	; redraw 2
v_bgscroll4:	equ $FFFFF75A	; redraw 2
f_bgscrollvert:	equ $FFFFF75C	; flag for vertical background scrolling
v_sonspeedmax:	equ $FFFFF760	; Sonic's maximum speed (2 bytes)
v_sonspeedacc:	equ $FFFFF762	; Sonic's acceleration (2 bytes)
v_sonspeeddec:	equ $FFFFF764	; Sonic's deceleration (2 bytes)
v_sonframenum:	equ $FFFFF766	; frame to display for Sonic
f_sonframechg:	equ $FFFFF767	; flag set to update Sonic's sprite frame
v_anglebuffer:	equ $FFFFF768	; angle of collision block that Sonic or object is standing on

v_opl_routine:	equ $FFFFF76C	; ObjPosLoad - routine counter
v_opl_screen:	equ $FFFFF76E	; ObjPosLoad - screen variable
v_opl_data:	equ $FFFFF770	; ObjPosLoad - data buffer ($10 bytes)

v_ssangle:	equ $FFFFF780	; Special Stage angle (2 bytes)
v_ssrotate:	equ $FFFFF782	; Special Stage rotation speed (2 bytes)
v_btnpushtime1:	equ $FFFFF790	; button push duration - in level (2 bytes)
v_btnpushtime2:	equ $FFFFF792	; button push duration - in demo (2 bytes)
v_palchgspeed:	equ $FFFFF794	; palette fade/transition speed (0 is fastest) (2 bytes)
v_collindex:	equ $FFFFF796	; ROM address for collision index of current level (4 bytes)
v_palss_num:	equ $FFFFF79A	; palette cycling in Special Stage - reference number (2 bytes)
v_palss_time:	equ $FFFFF79C	; palette cycling in Special Stage - time until next change (2 bytes)

v_obj31ypos:	equ $FFFFF7A4	; y-position of object 31 (MZ stomper) (2 bytes)
v_bossstatus:	equ $FFFFF7A7	; status of boss and prison capsule (01 = boss defeated; 02 = prison opened)
v_trackpos:	equ $FFFFF7A8	; position tracking reference number (2 bytes)
v_trackbyte:	equ $FFFFF7A9	; low byte for position tracking
f_lockscreen:	equ $FFFFF7AA	; flag set to lock screen during bosses
v_256loop1:	equ $FFFFF7AC	; 256x256 level tile which contains a loop (GHZ/SLZ)
v_256loop2:	equ $FFFFF7AD	; 256x256 level tile which contains a loop (GHZ/SLZ)
v_256roll1:	equ $FFFFF7AE	; 256x256 level tile which contains a roll tunnel (GHZ)
v_256roll2:	equ $FFFFF7AF	; 256x256 level tile which contains a roll tunnel (GHZ)
v_lani0_frame:	equ $FFFFF7B0	; level graphics animation 0 - current frame
v_lani0_time:	equ $FFFFF7B1	; level graphics animation 0 - time until next frame
v_lani1_frame:	equ $FFFFF7B2	; level graphics animation 1 - current frame
v_lani1_time:	equ $FFFFF7B3	; level graphics animation 1 - time until next frame
v_lani2_frame:	equ $FFFFF7B4	; level graphics animation 2 - current frame
v_lani2_time:	equ $FFFFF7B5	; level graphics animation 2 - time until next frame
v_lani3_frame:	equ $FFFFF7B6	; level graphics animation 3 - current frame
v_lani3_time:	equ $FFFFF7B7	; level graphics animation 3 - time until next frame
v_lani4_frame:	equ $FFFFF7B8	; level graphics animation 4 - current frame
v_lani4_time:	equ $FFFFF7B9	; level graphics animation 4 - time until next frame
v_lani5_frame:	equ $FFFFF7BA	; level graphics animation 5 - current frame
v_lani5_time:	equ $FFFFF7BB	; level graphics animation 5 - time until next frame
v_gfxbigring:	equ $FFFFF7BE	; settings for giant ring graphics loading (2 bytes)
f_conveyrev:	equ $FFFFF7C0	; flag set to reverse conveyor belts in LZ/SBZ
v_obj63:		equ $FFFFF7C1	; object 63 (LZ/SBZ platforms) variables (6 bytes)
f_wtunnelmode:	equ $FFFFF7C7	; LZ water tunnel mode
f_lockmulti:	equ $FFFFF7C8	; flag set to lock controls, lock Sonic's position & animation
f_wtunnelallow:	equ $FFFFF7C9	; LZ water tunnels (00 = enabled; 01 = disabled)
f_jumponly:	equ $FFFFF7CA	; flag set to lock controls apart from jumping
v_obj6B:		equ $FFFFF7CB	; object 6B (SBZ stomper) variable
f_lockctrl:	equ $FFFFF7CC	; flag set to lock controls during ending sequence
f_bigring:	equ $FFFFF7CD	; flag set when Sonic collects the giant ring
v_itembonus:	equ $FFFFF7D0	; item bonus from broken enemies, blocks etc. (2 bytes)
v_timebonus:	equ $FFFFF7D2	; time bonus at the end of an act (2 bytes)
v_ringbonus:	equ $FFFFF7D4	; ring bonus at the end of an act (2 bytes)
f_endactbonus:	equ $FFFFF7D6	; time/ring bonus update flag at the end of an act
v_sonicend:	equ $FFFFF7D7	; routine counter for Sonic in the ending sequence
f_switch:	equ $FFFFF7E0	; flags set when Sonic stands on a switch ($10 bytes)

f_restart:	equ $FFFFFE02	; restart level flag (2 bytes)
v_debugitem:	equ $FFFFFE06	; debug item currently selected (NOT the object number of the item)
v_debuguse:	equ $FFFFFE08	; debug mode use & routine counter (when Sonic is a ring/item) (2 bytes)
v_debugxspeed:	equ $FFFFFE0A	; debug mode - horizontal speed
v_debugyspeed:	equ $FFFFFE0B	; debug mode - vertical speed
v_zone:		equ $FFFFFE10	; current zone number
v_act:		equ $FFFFFE11	; current act number
v_lives:		equ $FFFFFE12	; number of lives
v_air:		equ $FFFFFE14	; air remaining while underwater (2 bytes)
v_airbyte:	equ v_air+1	; low byte for air
v_lastspecial:	equ $FFFFFE16	; last special stage number
v_continues:	equ $FFFFFE18	; number of continues
f_timeover:	equ $FFFFFE1A	; time over flag
v_lifecount:	equ $FFFFFE1B	; lives counter value (for actual number, see "v_lives")
f_lifecount:	equ $FFFFFE1C	; lives counter update flag
f_ringcount:	equ $FFFFFE1D	; ring counter update flag
f_timecount:	equ $FFFFFE1E	; time counter update flag
f_scorecount:	equ $FFFFFE1F	; score counter update flag
v_rings:		equ $FFFFFE20	; rings (2 bytes)
v_ringbyte:	equ v_rings+1	; low byte for rings
v_time:		equ $FFFFFE22	; time (4 bytes)
v_timemin:	equ $FFFFFE23	; time - minutes
v_timesec:	equ $FFFFFE24	; time - seconds
v_timecent:	equ $FFFFFE25	; time - centiseconds
v_score:		equ $FFFFFE26	; score (4 bytes)
v_shield:	equ $FFFFFE2C	; shield status (00 = no; 01 = yes)
v_invinc:	equ $FFFFFE2D	; invinciblity status (00 = no; 01 = yes)
v_shoes:		equ $FFFFFE2E	; speed shoes status (00 = no; 01 = yes)
v_lastlamp:	equ $FFFFFE30	; number of the last lamppost you hit
v_lamp_xpos:	equ v_lastlamp+2	; x-axis for Sonic to respawn at lamppost (2 bytes)
v_lamp_ypos:	equ v_lastlamp+4	; y-axis for Sonic to respawn at lamppost (2 bytes)
v_lamp_rings:	equ v_lastlamp+6	; rings stored at lamppost (2 bytes)
v_lamp_time:	equ v_lastlamp+8	; time stored at lamppost (2 bytes)
v_lamp_dle:	equ v_lastlamp+$C	; dynamic level event routine counter at lamppost
v_lamp_limitbtm:	equ v_lastlamp+$E	; level bottom boundary at lamppost (2 bytes)
v_lamp_scrx:	equ v_lastlamp+$10 ; x-axis screen at lamppost (2 bytes)
v_lamp_scry:	equ v_lastlamp+$12 ; y-axis screen at lamppost (2 bytes)

v_lamp_wtrpos:	equ v_lastlamp+$20 ; water position at lamppost (2 bytes)
v_lamp_wtrrout:	equ v_lastlamp+$22 ; water routine at lamppost
v_lamp_wtrstat:	equ v_lastlamp+$23 ; water state at lamppost
v_lamp_lives:	equ v_lastlamp+$24 ; lives counter at lamppost
v_emeralds:	equ $FFFFFE57	; number of chaos emeralds
v_emldlist:	equ $FFFFFE58	; which individual emeralds you have (00 = no; 01 = yes) (6 bytes)
v_ani0_time:	equ $FFFFFEC0	; synchronised sprite animation 0 - time until next frame (used for synchronised animations)
v_ani0_frame:	equ $FFFFFEC1	; synchronised sprite animation 0 - current frame
v_ani1_time:	equ $FFFFFEC2	; synchronised sprite animation 1 - time until next frame
v_ani1_frame:	equ $FFFFFEC3	; synchronised sprite animation 1 - current frame
v_ani2_time:	equ $FFFFFEC4	; synchronised sprite animation 2 - time until next frame
v_ani2_frame:	equ $FFFFFEC5	; synchronised sprite animation 2 - current frame
v_ani3_time:	equ $FFFFFEC6	; synchronised sprite animation 3 - time until next frame
v_ani3_frame:	equ $FFFFFEC7	; synchronised sprite animation 3 - current frame
v_ani3_buf:	equ $FFFFFEC8	; synchronised sprite animation 3 - info buffer (2 bytes)
v_limittopdb:	equ $FFFFFEF0	; level upper boundary, buffered for debug mode (2 bytes)
v_limitbtmdb:	equ $FFFFFEF2	; level bottom boundary, buffered for debug mode (2 bytes)

v_levseldelay:	equ $FFFFFF80	; level select - time until change when up/down is held (2 bytes)
v_levselitem:	equ $FFFFFF82	; level select - item selected (2 bytes)
v_levselsound:	equ $FFFFFF84	; level select - sound selected (2 bytes)
v_scorecopy:	equ $FFFFFFC0	; score, duplicate (4 bytes)
v_scorelife:	equ $FFFFFFC0	; points required for an extra life (4 bytes) (JP1 only)
f_levselcheat:	equ $FFFFFFE0	; level select cheat flag
f_slomocheat:	equ $FFFFFFE1	; slow motion & frame advance cheat flag
f_debugcheat:	equ $FFFFFFE2	; debug mode cheat flag
f_creditscheat:	equ $FFFFFFE3	; hidden credits & press start cheat flag
v_title_dcount:	equ $FFFFFFE4	; number of times the d-pad is pressed on title screen (2 bytes)
v_title_ccount:	equ $FFFFFFE6	; number of times C is pressed on title screen (2 bytes)

f_demo:		equ $FFFFFFF0	; demo mode flag (0 = no; 1 = yes; $8001 = ending) (2 bytes)
v_demonum:	equ $FFFFFFF2	; demo level number (not the same as the level number) (2 bytes)
v_creditsnum:	equ $FFFFFFF4	; credits index number (2 bytes)
f_debugmode:	equ $FFFFFFF8	; debug mode flag (sometimes 2 bytes)
v_init:		equ $FFFFFFFC	; 'init' text string (4 bytes)
