NatsumiAnim:
		move.b	#AniDat-ROMdat,-4.w	; set main int
		stop	#$2300
	di
		jsr	ClearScreen.w
		moveq	#0,d0
		move.l	VDP_Control_Port.w,a5	; get VDP control port to a5
		move.w	#$8707,(a5)		; transparent color is in line0
		move.l	VDP_Data_Port.w,a6	; get VDP data port to a6
	vdpcomm	move.l,0,VSRAM,WRITE,(a5)	; clear y-pos
		move.l	d0,(a6)

	vdpcomm	move.l,$F800,VRAM,WRITE,(a5)	; clear sprites
		move.l	d0,(a6)
		move.l	d0,(a6)

		lea	NatsumiPal(pc),a0	; get palette
	vdpcomm	move.l,2,CRAM,WRITE,(a5)	; write palette
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.w	(a0),(a6)

		move.l	#$77777777,d1
	vdpcomm	move.l,0,VRAM,WRITE,(a5)
	rept 64/8
		move.l	d1,(a6)			; clear top row
	endr

		clr.w	-(sp)			; start at last frame

		lea	$FFFF8000.w,a1
		moveq	#$700/8-1,d1

.clr		move.l	d0,(a1)+
		move.l	d0,(a1)+
		dbf	d1,.clr

		lea	$FF0000,a1
		lea	NatsumiArt_Main(pc),a0
		jsr	KosDec_
		move.l	VDP_Control_Port.w,a5	; get VDP control port to a5
	dma68kToVDP $FF0000,$CE00,$D40,VRAM	; DMA the art
		bra.w	.data

.loop	; send last frame's data
		move.l	VDP_Control_Port.w,a5	; get VDP control port to a5
		lea	$FFFF8000.w,a1
		moveq	#29-1,d1
		moveq	#28-1,d2

		bchg	#7,-8.w
		beq.s	.2
	vdpcomm	move.l,$C008,VRAM,WRITE,d0
		jsr	MapToPlane.w		; write mappings
		move.w	#$8200|($C000/$400),d1	; set new Plane A address
		bra.s	.c

.2	vdpcomm	move.l,$E008,VRAM,WRITE,d0
		jsr	MapToPlane.w		; write mappings
		move.w	#$8200|($E000/$400),d1	; set new Plane A address

.c	; here comes a hacky fix for random broken vertical line, no clue what causes is
	; and I definitely do not have time to fix it
		move.w	#$8F80,(a5)
		moveq	#0,d0
	vdpcomm	move.l,$C040,VRAM,WRITE,(a5)
		bsr.s	.x
	vdpcomm	move.l,$E040,VRAM,WRITE,(a5)
		bsr.s	.x
		move.w	#$8F02,(a5)
		bra.s	.c2

.x	rept	32/2
		move.l	d0,(a6)
	endr
		rts

.c2		stop	#$2300
		move.w	d1,(a5)
	dma68kToVDP $FF0000,$0020,$26E0,VRAM	; DMA the art

.data	; then decompress next data
		move.w	(sp)+,d0		; get d0 from stack
		subq.w	#4,d0			; next frame
		bpl.s	.ok			; if ok, branch
		moveq	#18*4,d0		; reset frame
.ok		move.w	d0,-(sp)		; store d0 back

		lea	$FF0000,a1
		move.l	NatsumiArtsArray(pc,d0.w),a0
		jsr	KosDec_

		move.w	(sp),d0
		lea	$FFFF8000.w,a1
		move.l	NatsumiMapsArray(pc,d0.w),a0
		moveq	#0,d0			; reset d0 because EniDec
		jsr	EniDec.w		; uses it for tile offsets
		bra.w	.loop

; ===========================================================================
NatsumiMapsArray:
	dc.l NatsumiMap_000, NatsumiMap_001, NatsumiMap_002, NatsumiMap_003
	dc.l NatsumiMap_004, NatsumiMap_005, NatsumiMap_006, NatsumiMap_007
	dc.l NatsumiMap_008, NatsumiMap_009, NatsumiMap_010, NatsumiMap_011
	dc.l NatsumiMap_012, NatsumiMap_013, NatsumiMap_014, NatsumiMap_015
	dc.l NatsumiMap_016, NatsumiMap_017, NatsumiMap_018

NatsumiArtsArray:
	dc.l NatsumiArt_000, NatsumiArt_001, NatsumiArt_002, NatsumiArt_003
	dc.l NatsumiArt_004, NatsumiArt_005, NatsumiArt_006, NatsumiArt_007
	dc.l NatsumiArt_008, NatsumiArt_009, NatsumiArt_010, NatsumiArt_011
	dc.l NatsumiArt_012, NatsumiArt_013, NatsumiArt_014, NatsumiArt_015
	dc.l NatsumiArt_016, NatsumiArt_017, NatsumiArt_018

; ===========================================================================
NatsumiPal:	incbin "dat/ani/main.pal"
NatsumiArt_Main incbin "dat/ani/main.tiles.kos"
NatsumiArt_000:	incbin "dat/ani/000.tiles.kos"
NatsumiArt_001:	incbin "dat/ani/001.tiles.kos"
NatsumiArt_002:	incbin "dat/ani/002.tiles.kos"
NatsumiArt_003:	incbin "dat/ani/003.tiles.kos"
NatsumiArt_004:	incbin "dat/ani/004.tiles.kos"
NatsumiArt_005:	incbin "dat/ani/005.tiles.kos"
NatsumiArt_006:	incbin "dat/ani/006.tiles.kos"
NatsumiArt_007:	incbin "dat/ani/007.tiles.kos"
NatsumiArt_008:	incbin "dat/ani/008.tiles.kos"
NatsumiArt_009:	incbin "dat/ani/009.tiles.kos"
NatsumiArt_010:	incbin "dat/ani/010.tiles.kos"
NatsumiArt_011:	incbin "dat/ani/011.tiles.kos"
NatsumiArt_012:	incbin "dat/ani/012.tiles.kos"
NatsumiArt_013:	incbin "dat/ani/013.tiles.kos"
NatsumiArt_014:	incbin "dat/ani/014.tiles.kos"
NatsumiArt_015:	incbin "dat/ani/015.tiles.kos"
NatsumiArt_016:	incbin "dat/ani/016.tiles.kos"
NatsumiArt_017:	incbin "dat/ani/017.tiles.kos"
NatsumiArt_018:	incbin "dat/ani/018.tiles.kos"
NatsumiMap_000:	incbin "dat/ani/000.map.eni"
NatsumiMap_001:	incbin "dat/ani/001.map.eni"
NatsumiMap_002:	incbin "dat/ani/002.map.eni"
NatsumiMap_003:	incbin "dat/ani/003.map.eni"
NatsumiMap_004:	incbin "dat/ani/004.map.eni"
NatsumiMap_005:	incbin "dat/ani/005.map.eni"
NatsumiMap_006:	incbin "dat/ani/006.map.eni"
NatsumiMap_007:	incbin "dat/ani/007.map.eni"
NatsumiMap_008:	incbin "dat/ani/008.map.eni"
NatsumiMap_009:	incbin "dat/ani/009.map.eni"
NatsumiMap_010:	incbin "dat/ani/010.map.eni"
NatsumiMap_011:	incbin "dat/ani/011.map.eni"
NatsumiMap_012:	incbin "dat/ani/012.map.eni"
NatsumiMap_013:	incbin "dat/ani/013.map.eni"
NatsumiMap_014:	incbin "dat/ani/014.map.eni"
NatsumiMap_015:	incbin "dat/ani/015.map.eni"
NatsumiMap_016:	incbin "dat/ani/016.map.eni"
NatsumiMap_017:	incbin "dat/ani/017.map.eni"
NatsumiMap_018:	incbin "dat/ani/018.map.eni"
; ===========================================================================
