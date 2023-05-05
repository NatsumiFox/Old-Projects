; ===========================================================================
Maincode	section org(0)
	include "equ.asm"
	include "macros.asm"
	include "sound/driver/smps2asm.asm"
	include "#debug/macro.asm"
; ===========================================================================
StartOfROM:
Vectors:
	dc.w 0,$666
	dc.l EntryPoint, ($FF<<24)|ErrorTrap, ($FF<<24)|AddressError
	dc.l ($FF<<24)|IllegalInstr, ($FF<<24)|ZeroDivide, ($FF<<24)|ChkInstr, ($FF<<24)|TrapvInstr
	dc.l ($FF<<24)|PrivilegeViol, ($FF<<24)|Trace, ($FF<<24)|Line1010Emu, ($FF<<24)|Line1111Emu
	dc.l ($FF<<24)|ErrorExcept, ($FF<<24)|ErrorExcept, ($FF<<24)|ErrorExcept, ($FF<<24)|ErrorExcept
	dc.l ($FF<<24)|ErrorExcept, ($FF<<24)|ErrorExcept, ($FF<<24)|ErrorExcept, ($FF<<24)|ErrorExcept
	dc.l ($FF<<24)|ErrorExcept, ($FF<<24)|ErrorExcept, ($FF<<24)|ErrorExcept, ($FF<<24)|ErrorExcept
	dc.l ($FF<<24)|ErrorExcept, ($FF<<24)|ErrorTrap
	dc.b 'POPPYCOC'
	dc.l ('K'<<24)|(HInt_jmp_Code&$FFFFFF),	($FF<<24)|ErrorTrap, (VInt_jmp_Code&$FFFFFF)
; ===========================================================================

PlayMusic:
	stopZ80
		move.b	d0,($A0<<24)|Z80_RAM+$1C0A
	startZ80
		move.b	d0,Last_Mus.w
		rts
	dc.b 'HI'

; ===========================================================================
		align $100
Header:		dc.b 'SEGA'
; ===========================================================================

PlaySFX:
	stopZ80
		cmp.b	($A0<<24)|Z80_RAM+$1C0B,d0
		beq.s	.skip
		tst.b	($A0<<24)|Z80_RAM+$1C0B
		bne.s	.3rdflag
		move.b	d0,($A0<<24)|Z80_RAM+$1C0B	; set sfx 1
	startZ80
		rts

.3rdflag	move.b	d0,($A0<<24)|Z80_RAM+$1C0C	; set sfx 2
.skip	startZ80
		rts

Wait_VSync:
		move.w	#$9100,VDP_control_port	; disable window plane
		move	#$2300,sr
.wait		tst.b	VInt_Routine.w
		bne.s	.wait
playtempo:
		rts
; ===========================================================================
		align $1F0
Country_Code:	dc.b "UE"
; ===========================================================================
		include "code/lib.asm"
		include "code/objlib.asm"
		include "code/floorwall.asm"
		include "code/objfunc.asm"
		include "boss/lib.asm"
		include "code/hud.asm"
		include "code/rings.asm"
		include "code/objects/starpost.asm"
		include "code/objects/bumper.asm"
		include "code/objects/bubble maker.asm"
		include "code/objects/animals.asm"
		include "code/objects/invisible solid block.asm"
		include "code/objects/spring.asm"
		include "code/objects/spikes.asm"
		include "code/objects/monitors.asm"
		include "code/objects/explosion.asm"
		include "code/objects/aircountdown.asm"
		include "code/objects/superhyper stars.asm"
		include "code/objects/invis.asm"
		include "code/objects/shields.asm"
		include "code/objects/dashdust.asm"
		include "code/objects/sonic.asm"
		include "code/objects/tails.asm"
		include "code/objects/knux.asm"
		include "code/debugmode.asm"
		include "code/objects/pathswap.asm"
		include "code/compression.asm"
		include "code/ints.asm"
		include "code/init.asm"
		include "code/water.asm"
		include "code/level.asm"
		include "code/pause.asm"
		include "code/scroll.asm"
		include "code/palette.asm"
		include "code/objects/music control objects.asm"
		include "boss/mecha/space.asm"
		include "#debug/main.asm"
		include "#end/main.asm"
		include "font.asm"
	CreateBoss wall, Chunk_table
	CreateBoss mecha, Chunk_table
; ===========================================================================

Sprite_ListingK:
	dc.l ('O'<<24)|Obj_Ring, ('O'<<24)|Obj_Monitor, ('O'<<24)|Obj_PathSwap
	dc.l ('O'<<24)|Obj_Spring, ('O'<<24)|Obj_Spikes, ('O'<<24)|Obj_Bumper
	dc.l ('O'<<24)|Obj_InvisSolidBlock, ('O'<<24)|Obj_StarPost
; ---------------------------------------------------------------------------

ArtKosM_Spikes:		inceven 'levels\common\Spikes\art.KosM'
ArtKosM_Ring:		inceven 'levels/common/Rings/art.KosM'
ArtKosM_Monitors:	inceven 'levels/common/Monitors/art.KosM'

ArtUnc_InstaShield:	inceven "levels/Players/Shields/Unc Insta Shield.bin"
ArtUnc_FireShield:	inceven "levels/Players/Shields/Unc Fire Shield.bin"
ArtUnc_LightningShield:	inceven "levels/Players/Shields/Unc Lightning Shield.bin"
ArtUnc_LightningSparks:	incbin "levels/Players/Shields/Unc Lightning Sparks.bin"
ArtUnc_LightningSparks_End:	even
ArtUnc_BubbleShield:	inceven "levels/Players/Shields/Unc Bubble Shield.bin"
ArtUnc_AirCountDown:	inceven "levels/common/countdown/Unc Countdown.bin"

ArtUnc_Invincibility:	incbin 'levels/common/ArtUnc_Invincibility.bin'
ArtUnc_DashDust:	incbin 'levels/common/ArtUnc_DashDust.bin'
ArtUnc_SplashDrown:	incbin 'levels/common/ArtUnc_UnkASpl.bin'
HudArt_Tails:		inceven "levels/common/HUD/tails art.unc"
; ---------------------------------------------------------------------------

word_1E3C00:	dc.w   $600,   $10
		dc.w	$20,	 0
		dc.w   $4C0,   $1C
		dc.w	$70,	 0
		dc.w   $580,   $10
		dc.w   $200,	 0

		align $8000
		include "sound/driver/SK.68k"
; ---------------------------------------------------------------------------
		align	$20000
TP_PowerBar:	incbin	"levels/ML/art/Power Bar.bin"
TP_Piston:	incbin	"levels/ML/art/Piston.bin"
TP_Pylon:	incbin	"levels/ML/art/Pylon.bin"
TP_BlueSky:	incbin	"levels/ML/art/Blue Sky.bin"
TP_RoofRidge:	incbin	"levels/ML/art/Roof Ridges.bin"
TP_BotPillar:	incbin	"levels/ML/art/Bottom Pillars.bin"
TP_DistPillar:	incbin	"levels/ML/art/Distant Pillars.bin"
Ending_NotLegit_Map:	incbin "#end/map nl.kos"
EndPalette:	incbin "#end/palette.bin"

Art_Sonic:		incbin "levels/Players/Sonic/Art.unc"
Art_Knuckles:		incbin "levels/Players/Knuckles/Art.unc"
Art_Tails:		incbin "levels/Players/Tails/Art.unc"
ML_Tiles:		incbin "levels/ML/Tiles.unc"
ML_Tiles_End:		even
TP_PowerOrb:		inceven	"levels/ML/art/Power Orb.bin"
Art_Tails_Extra:	incbin "levels/Players/Tails/Art Extra.unc"
ArtUnc_SuperSonicKnux_Stars:	incbin 'levels/common/ArtUnc_SuperSonicKnux_Stars.bin'

EndMaps_Array:		dc.l ('M'<<24)|EndMaps_1, ('M'<<24)|EndMaps_2, -1
		align	$20000
; ---------------------------------------------------------------------------
EndGraphics:		incbin "#end/art.unc"
EndGraphics_End:	even
Art_Sonic_Extra:	incbin "levels/Players/Sonic/Art Extra.unc"
Art_Tails_Tail:		incbin "levels/Players/Tails/Art Tail.unc"

Map_Sonic:		include "levels/Players/Sonic/Map Main.asm"
Map_SuperSonic:		include "levels/Players/Sonic/Map Super.asm"
DPLC_Sonic:		include "levels/Players/Sonic/DPLC Main.asm"
DPLC_SuperSonic:	include "levels/Players/Sonic/DPLC Super.asm"
			include "levels/Players/Sonic/DPLC Pieces.asm"
			include "levels/Players/Sonic/Map Pieces.asm"

Map_Tails:		include "levels/Players/Tails/Map.asm"
DPLC_Tails:		include "levels/Players/Tails/DPLC.asm"
Map_Tails_Tail:		include "levels/Players/Tails/Map Tail.asm"
DPLC_Tails_Tail:	include "levels/Players/Tails/DPLC Tail.asm"
Map_Knuckles:		include "levels/Players/Knuckles/Map.asm"
DPLC_Knuckles:		include "levels/Players/Knuckles/DPLC.asm"
; ---------------------------------------------------------------------------
ArtKosM_SuperTailsBirds:inceven 'levels/common/ArtKosM_SuperTailsBirds.bin'
ArtKosM_HyperSonic:	inceven 'levels/common/ArtKosM_HyperSonic.bin'
ArtKosM_Mecha:		inceven 'boss/mecha/mecha.kosM'
ArtKosM_MechaMisc:	inceven 'boss/mecha/misc.kosM'
ArtKosM_EnemyPts:	inceven 'levels/common/EnemyPts.KosM'
ArtKosM_Explosion:	inceven 'levels/common/Explosion.KosM'
; ---------------------------------------------------------------------------
AngleArray:		inceven "levels/AngleArray.bin"
HeightMaps:		inceven "levels/HeightMaps.bin"
HeightMapsRot:		inceven "levels/HeightMapsRot.bin"
debugfont:		inceven "#debug/font.kos"
; ---------------------------------------------------------------------------
FadeIn_00:		inceven "levels/fadein/00.bin"
FadeIn_01:		inceven "levels/fadein/01.bin"
FadeIn_02:		inceven "levels/fadein/02.bin"
FadeIn_03:		inceven "levels/fadein/03.bin"
FadeIn_04:		inceven "levels/fadein/04.bin"
FadeIn_05:		inceven "levels/fadein/05.bin"
FadeIn_06:		inceven "levels/fadein/06.bin"
FadeIn_07:		inceven "levels/fadein/07.bin"
FadeIn_08:		inceven "levels/fadein/08.bin"
FadeIn_09:		inceven "levels/fadein/09.bin"
FadeIn_10:		inceven "levels/fadein/10.bin"
FadeIn_11:		inceven "levels/fadein/11.bin"
FadeIn_12:		inceven "levels/fadein/12.bin"
FadeIn_13:		inceven "levels/fadein/13.bin"
FadeIn_14:		inceven "levels/fadein/14.bin"
FadeIn_15:		inceven "levels/fadein/15.bin"
FadeIn_16:		inceven "levels/fadein/16.bin"
FadeIn_17:		dc.w 1, $FFFF
; ---------------------------------------------------------------------------
ML_Blocks:		inceven "levels/ML/Blocks.unc"
ML_Chunks:		inceven "levels/ML/Chunks.unc"
ML_Layout:		inceven "levels/ML/Layout.unc"
ML_Pal:			inceven "levels/ML/pal.bin"
			dc.w  $FFFF, 0, 0
ML_Sprites:		inceven "levels/ML/ObjPos.unc"
			dc.w  $FFFF, 0, 0
ML_Rings:		inceven "levels/ML/RingPos.unc"
ML_Solid:		inceven "levels/ML/Solid.unc"
; ---------------------------------------------------------------------------
EndMaps_1:		inceven "#end/map1.kos"
EndMaps_2:		inceven "#end/map2.kos"
Z80_PCM_Driver:		incbin "sound/driver/Z80WAVD.bin"
End_Wav_Music:		incbin "sound/wav.wav"
		END
