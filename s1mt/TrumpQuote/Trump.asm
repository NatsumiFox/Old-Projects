TrumpScreen:
		lea	(VDP_control_port).l,a6
		move.w	#$8710,(a6)			; Command $8700 - BG color is Pal 3 Color 0

		jsr	Pal_FadeFrom
		jsr	ClearScreen

		lea	ArtKos_TrumpTiles,a0
		lea	$FF0000,a1
		jsr	KosDec			; decomp art

		dma68kToVDP $FF0000, 0, $7C20, VRAM

		lea	$FF0000,a1
		lea	MapEni_Trumpfg,a0
		move.w	#0,d0
		jsr	EniDec

		lea	$FF1000,a1
		lea	MapEni_Trumpbg,a0
		move.w	#$61A1,d0
		jsr	EniDec

		lea	$FF0000,a1
		move.l	#$40000003,d0
		moveq	#40-1,d1
		moveq	#25-1,d2
		jsr	ShowVDPGraphics		; Copy screen mappings to VRAM

		lea	$FF1000,a1
		move.l	#$60000003,d0
		moveq	#40-1,d1
		moveq	#25-1,d2
		jsr	ShowVDPGraphics		; Copy screen mappings to VRAM

		lea	Palette_Trump,a1
		lea	Palette_NCurr.w,a2
		moveq	#$1F,d0
		jsr	Loc_Pal

		moveq	#$FFFFFFE4,d0
		jsr	PlayMusic
		move.b	#2,VBlank_Routine.w
		jsr	DelayProgram

		move	#$2300,sr
		moveq	#$FFFFFFC1,d0
		jsr	PlaySample2

.delay		move.b	#2,VBlank_Routine.w
		jsr	DelayProgram
		tst.w	$FFFFF604.w
		bpl.s	.delay

		move.l	#$FFFE00,sp	; 6
		jmp	MainGameLoop

; =============================================================
Palette_Trump:		incbin "TrumpQuote/palette.bin"
			even

MapEni_Trumpbg:		incbin "TrumpQuote/bg_map.eni"
			even
MapEni_Trumpfg:		incbin "TrumpQuote/fg_map.eni"
			even

ArtKos_TrumpTiles:	incbin "TrumpQuote/Art.kos"
			even
; =============================================================
