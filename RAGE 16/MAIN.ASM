	include "EQU.ASM"

; ===========================================================================
StartOfRom:
Vectors:	rts
ART_NUL:	dc.w 0
		dc.l EntryPoint, ErrorTrap, AddressError
		dc.l IllegalInstr, ZeroDivide, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, Line1010Emu,	Line1111Emu
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l H_INT,	ErrorTrap, V_INT, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
Console:	dc.b 'SEGA M3G2 DR1V3 '	; Hardware system ID
Date:		dc.b '(C)NAT 2016.OCT '	; Release date
Title_Local:	dc.b 'SEXY CUBES                                      '	; Domestic name
Title_Int:	dc.b '🌮🌮🌮🌮TOTINO CHALLENGE🌮🌮🌮🌮'	; International name
Serial:		dc.b 'homebr'	; Serial/version number
ART_PLAYER:	dc.w $0101,ARTD_PLAYER
ART_PLAYERDEST:	dc.w $0000,ARTD_PLAYER
		dc.w 0
		dc.b 'J   '		; I/O support
ART_TITLE1:	dc.w $0808,ARTD_TITLE1
ART_TITLE2:	dc.w $0708,ARTD_TITLE2
ART_GROUND:	dc.w $1301,ARTD_GROUND
RomStartLoc:	dc.l StartOfRom		; ROM start
RomEndLoc:	dc.l EndOfRom-1		; ROM end
RamStartLoc:	dc.l $FF0000		; RAM start
RamEndLoc:	dc.l $FFFFFF		; RAM end
ART_DIFF:	dc.w $0A08,ARTD_DIFF
vdp_comm_port:	dc.l $C00004		; address for VDP registers
vdp_data_port:	dc.l $C00000

AddressError:	bra.s	*
IllegalInstr:	bra.s	*
ZeroDivide:	bra.s	*
Line1010Emu:	bra.s	*
Line1111Emu:	bra.s	*
H_INT:		rte

ART_SPIKE:	dc.w $0102,ARTD_SPIKE1	; $00
		dc.w $0302,ARTD_SPIKE2	; $04
		dc.w $0502,ARTD_SPIKE3	; $08
		dc.w $0102,ARTD_SPIKEV1	; $0C
		dc.w $0302,ARTD_SPIKEV2	; $10
		dc.w $0502,ARTD_SPIKEV3	; $14
ART_SPRING:	dc.w $0102,ARTD_SPRING
		dc.w $0102,ARTD_SPRINGV
ART_DIFFSEL:	dc.w $0102,ARTD_DIFFSEL
ART_END:	dc.w $1317,ARTD_END
Region:		dc.b 'JUE ' ; Region
ART_TILE:	dc.w $0001,ARTD_GROUND	; $00
		dc.w $0101,ARTD_GROUND	; $04
		dc.w $0301,ARTD_GROUND	; $08
		dc.w $0501,ARTD_GROUND	; $0C
		dc.w $0701,ARTD_GROUND	; $10
		dc.w $0901,ARTD_GROUND	; $14
		dc.w $0003,ARTD_GROUND	; $18
		dc.w $0005,ARTD_GROUND	; $1C
		dc.w $0303,ARTD_GROUND	; $20
		dc.w $0505,ARTD_GROUND	; $24
		dc.w $0707,ARTD_GROUND	; $28
ErrorTrap:	bra.s	*
; ===========================================================================

	include "OBJS.ASM"
	include "LIB.ASM"
	include "VINT.ASM"
	include "INIT.ASM"

ARTD_TITLE1:	incbin "TITLE1.UNC"
ARTD_TITLE2:	incbin "TITLE2.UNC"
ARTD_PLAYER:	incbin "PLAYER.UNC"
ARTD_SPRING:	incbin "SPRING.UNC"
ARTD_SPRINGV:	incbin "SPRINGV.UNC"
ARTD_SPIKE1:	incbin "SPIKE1.UNC"
ARTD_SPIKE2:	incbin "SPIKE2.UNC"
ARTD_SPIKE3:	incbin "SPIKE3.UNC"
ARTD_SPIKEV1:	incbin "SPIKEV1.UNC"
ARTD_SPIKEV2:	incbin "SPIKEV2.UNC"
ARTD_SPIKEV3:	incbin "SPIKEV3.UNC"
ARTD_GROUND:	incbin "GROUND.UNC"
ARTD_DIFF:	incbin "DIFF.UNC"
ARTD_DIFFSEL:	incbin "ARROW.UNC"
ARTD_END:	incbin "END.UNC"
		even

PlanePoses:	dc.w $144, $1F4, $2B4
ObjectLayout:
	; first section
	objl ObjSpike,	$00, 25, 0
	objl ObjSpike,	$1E, 25, 0
	objl ObjSpike,	$32, 25, 0
	objl ObjSpike,	$46, 25, 0
	objl ObjSpike,	$5C, 25, 0
	objl ObjSpike,	$6C, 8,  $14
	objl ObjSpring,	$6D, 24, 0
	objl ObjSpike,	$78, 8,  $14
	objl ObjTile,	$8E, 19, $1C
	objl ObjTile,	$90, 19, $08
	objl ObjSpike,	$98, 20, $08
	objl ObjSpike,	$A4, 20, $08
	objl ObjTile,	$B0, 15, $1C
	objl ObjTile,	$B2, 15, $04
	objl ObjSpike,	$B2, 25, $08
	objl ObjSpike,	$BE, 25, $08
	objl ObjSpike,	$CA, 25, $08
	objl ObjTile,	$D0, 15, $00
	objl ObjSpike,	$D6, 25, $08
	objl ObjSpike,	$E2, 25, $08
	objl ObjTile,	$E6, 12, $00
	objl ObjSpike,	$F0, 25, $08

	; second section
	objl ObjSpring,	$124, 23, $00
	objl ObjSpike,	$128, 25, $08
	objl ObjSpike,	$134, 25, $08
	objl ObjTile,	$13A, 12, $00
	objl ObjSpike,	$140, 25, $08
	objl ObjTile,	$14A,  3, $00
	objl ObjSpike,	$14C, 25, $08
	objl ObjSpike,	$158, 25, $08
	objl ObjTile,	$160,  4, $08
	objl ObjSpike,	$164, 25, $08
	objl ObjTile,	$168,  4, $08
	objl ObjSpike,	$170, 25, $08
	objl ObjTile,	$17B, 10, $08
	objl ObjSpike,	$17C, 25, $08
	objl ObjSpring,	$183,  3, $04
	objl ObjSpike,	$183,  0, $00
	objl ObjSpring,	$188, 23, $00
	objl ObjSpike,	$18C, 25, $08
	objl ObjTile,	$197, 11, $08
	objl ObjSpike,	$198, 25, $08
	objl ObjTile,	$19F, 11, $00
	objl ObjSpike,	$1A1, 12, $04
	objl ObjSpike,	$1A4, 25, $08
	objl ObjSpring,	$1A6, -1, $04
	objl ObjSpike,	$1B0, 12, $04

	; third section
	objl ObjTile,	$1D0, 22, $18
	objl ObjTile,	$1D0, 12, $1C
	objl ObjTile,	$1DD,  5, $1C
	objl ObjSpike,	$1DD, 16, $00
	objl ObjTile,	$1DD, 24, $04
	objl ObjTile,	$1DD, 19, $1C
	objl ObjTile,	$1DF,  5, $1C
	objl ObjTile,	$1DF, 19, $1C
	objl ObjTile,	$1E8, 21, $1C
	objl ObjTile,	$1E8, 11, $1C
	objl ObjSpring,	$1F8, 26, $00
	objl ObjSpike,	$1F8, 11, $14
	objl ObjTile,	$206, 18, $08
	objl ObjSpike,	$20E, 21, $00
	objl ObjTile,	$212, 15, $1C
	objl ObjTile,	$212,  9, $1C
	objl ObjTile,	$214,  9, $00
	objl ObjSpike,	$216, 10, $08
	objl ObjSpike,	$240, 23, $08
	objl ObjSpike,	$24A, 23, $04
	objl ObjTile,	$25E, 19, $1C
	objl ObjTile,	$27C, 17, $1C
	objl ObjTile,	$27C, 21, $1C

	; fourth section
	objl ObjTile,	$290, 18, $24
	objl ObjTile,	$290, 12, $1C
	objl ObjTile,	$29C, 16, $24
	objl ObjTile,	$2A1, 24, $0C
	objl ObjTile,	$2A8, 16, $0C
	objl ObjTile,	$2AD, 23, $18
	objl ObjTile,	$2B4, 16, $00
	objl ObjTile,	$2B6, 16, $24
	objl ObjTile,	$2C0, 24, $0C
	objl ObjTile,	$2C0, 16, $10
	objl ObjTile,	$2C9, 22, $18
	objl ObjTile,	$2CA, 20, $24
	objl ObjTile,	$2D4,  8, $24
	objl ObjSpike,	$2D6, 23, $04
	objl ObjTile,	$2E0, 10, $24
	objl ObjSpring,	$2EA, 26, $00
	objl ObjTile,	$2EC,  9, $24
	objl ObjSpike,	$2EC, 13, $10
	objl ObjTile,	$2F2, 22, $24
	objl ObjTile,	$2F8,  9, $24
	objl ObjTile,	$2FC, 20, $24
	objl ObjTile,	$2FD, 11, $24
	objl ObjTile,	$308, 21, $1C
	objl ObjTile,	$30A, 22, $18
	objl ObjTile,	$30C, 23, $18
	objl ObjTile,	$30E, 24, $18
	objl ObjTile,	$310, 25, $00
	objl ObjTile,	$312, 26, $00
	objl ObjWin,	$348, 26, $00
		dc.w -1
	align $1000
EndOfRom:	END
