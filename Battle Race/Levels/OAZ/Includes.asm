; ===========================================================================
; ---------------------------------------------------------------------------
; Include structure for "Ominous Alcazar Zone" (a.k.a. "Vertigo Castle Zone")
; ---------------------------------------------------------------------------

	if oazflag=1
		include	"Levels/OAZ/Equates.asm"	; Equates for OAZ routines
		include	"Levels/OAZ/Macros.asm"		; Macros for OAZ routines
		include	"Levels/OAZ/VBlank.asm"		; V-blank routines
		include	"Levels/OAZ/HBlank.asm"		; H-blank routines
		include	"Levels/OAZ/DeformScroll.asm"	; universal scroll routine

; ---------------------------------------------------------------------------
; Act 1 Includes
; ---------------------------------------------------------------------------

OAZ1_Palette:		binclude "Levels/OAZ/Data/Act 1/Palette.bin"
OAZ1_PalReflect:	binclude "Levels/OAZ/Data/Act 1/Palette Reflect.bin"; Sonic/Tails reflection palette
			even
OAZ1_8x8_KosM:		binclude "Levels/OAZ/Data/Act 1/Art.kosm"
			even
OAZ1_16x16_Kos:		binclude "Levels/OAZ/Data/Act 1/Blocks.kos"
			even
OAZ1_128x128_Kos:	binclude "Levels/OAZ/Data/Act 1/Chunks.kos"
			even
OAZ1_Layout:		binclude "Levels/OAZ/Data/Act 1/Layout.bin"
			even
OAZ1_Collision:		binclude "Levels/OAZ/Data/Act 1/Collision.bin"
			even
OAZ1_CA_Angles:		binclude "Levels/OAZ/Data/Act 1/Collision Array Angles.bin"
OAZ1_CA_Normal:		binclude "Levels/OAZ/Data/Act 1/Collision Array Normal.bin"
OAZ1_CA_Rotated:	binclude "Levels/OAZ/Data/Act 1/Collision Array Rotated.bin"
			even

			dc.w	$FFFF,$0000,$0000
OAZ1_Objects:		binclude "Levels/OAZ/Data/Act 1/Objects.bin"
OAZ1_Rings:		binclude "Levels/OAZ/Data/Act 1/Rings.bin"

			include	"Levels/OAZ/Data/Act 1/Screen Events.asm"
			include	"Levels/OAZ/Data/Act 1/Background Events.asm"
			include	"Levels/OAZ/Data/Act 1/Sprite Reflect.asm"

OAZ1_CloudMoon:		binclude "Levels/OAZ/Data/Act 1/Art Cloud Moon.bin"
OAZ1_CloudMask1:	binclude "Levels/OAZ/Data/Act 1/Art Cloud Mask 1.bin"
OAZ1_CloudMask2:	binclude "Levels/OAZ/Data/Act 1/Art Cloud Mask 2.bin"
OAZ1_CloudMask3:	binclude "Levels/OAZ/Data/Act 1/Art Cloud Mask 3.bin"
OAZ1_CloudAni:		binclude "Levels/OAZ/Data/Act 1/Art Animated Clouds.bin"
OAZ1_FlameAni:		binclude "Levels/OAZ/Data/Act 1/Art Animated Flame.bin"

; ---------------------------------------------------------------------------
; Act 2 Includes
; ---------------------------------------------------------------------------

OAZ2_Palette:		binclude "Levels/OAZ/Data/Act 2/Palette.bin"
			even
OAZ2_8x8_KosM:		binclude "Levels/OAZ/Data/Act 2/Art.kosm"
			even
OAZ2_16x16_Kos:		binclude "Levels/OAZ/Data/Act 2/Blocks.kos"
			even
OAZ2_128x128_Kos:	binclude "Levels/OAZ/Data/Act 2/Chunks.kos"
			even
OAZ2_Layout:		binclude "Levels/OAZ/Data/Act 2/Layout.bin"
			even
OAZ2_Collision:		binclude "Levels/OAZ/Data/Act 2/Collision.bin"
			even
OAZ2_CA_Angles:		binclude "Levels/OAZ/Data/Act 2/Collision Array Angles.bin"
OAZ2_CA_Normal:		binclude "Levels/OAZ/Data/Act 2/Collision Array Normal.bin"
OAZ2_CA_Rotated:	binclude "Levels/OAZ/Data/Act 2/Collision Array Rotated.bin"
			even

			dc.w	$FFFF,$0000,$0000
OAZ2_Objects:		binclude "Levels/OAZ/Data/Act 2/Objects.bin"
OAZ2_Rings:		binclude "Levels/OAZ/Data/Act 2/Rings.bin"

			include	"Levels/OAZ/Data/Act 2/Screen Events.asm"
			include	"Levels/OAZ/Data/Act 2/Background Events.asm"
		endif
		even

; ===========================================================================
