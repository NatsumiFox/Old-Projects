Nat_VDP		EQUR a6
Nat_VDPc	EQUR a5
Nat_HV		EQUR a4
Nat_Pal		EQUR a3

Nat_DMAlen	EQUR d7
Nat_dispDis	EQUR d6
Nat_dispEn	EQUR d5
Nat_dispDis2	EQUR d4
Nat_PalOffs	EQUR d3
Nat_HscrOffs	EQUR d2

; ===========================================================================
NatsumiScreen:
		lea	(VDP_control_port).l,a6
		move.w	#$8004,(a6)			; Command $8004 - Disable HInt, HV Counter
		move.w	#$8230,(a6)			; Command $8230 - Nametable A at $C000
		move.w	#$8407,(a6)			; Command $8407 - Nametable B at $E000
		move.w	#$9000,(a6)			; Command $9001 - 32x32 cell nametable area
		move.w	#$9200,(a6)			; Command $9200 - Window V position at default
		move.w	#$8B03,(a6)			; Command $8B03 - Vscroll full, HScroll line-based
		move.w	#$8700,(a6)			; Command $8700 - BG color is Pal 0 Color 0

		lea	ArtUnc_NsTiles,a0
		lea	$FF0000,a1
		jsr	KosDec			; decomp art

		dma68kToVDP $FF0000, 0, $3A00, VRAM
		dma68kToVDP Maps_NatScrn, $C000,  $480, VRAM

;		moveq	#$FFFFFFC1,d0
	;	jsr	PlaySample2

	;	move.b	#8,VBlank_Routine.w	; flush art
	;	jsr	DelayProgram

		lea	$FF0000,a1
		lea	Pal_NatsumiScreen,a0
		move.w	#((Pal_NatsumiScreen_end-Pal_NatsumiScreen)/4)-1,d0

.load		move.l	(a0)+,(a1)+
		dbf	d0,.load

		move.l	#$40000010,VDP_control_port
		move.l	#$FFE40000,VDP_data_port 	; set VScroll

		move.l	#$C0020010,VDP_control_port
		move.l	#$00000220,VDP_Data_Port 	; set bg colors

		lea	Natsumi_ints(pc),a6		; load fancy vdp mode
		lea	VBlankJump.w,a5
		move.l	(a6)+,(a5)+
		move.l	(a6)+,(a5)+
		move.l	(a6)+,(a5)+
		move.l	(a6)+,(a5)+

	;	move.l	#$00000000,$FFFF0000
		lea	VDP_Data_Port,Nat_VDP
		lea	VDP_Control_Port,Nat_VDPc
		lea	VDP_Counter,Nat_HV		; set registers
		move.w	#$8A01,(Nat_VDPc)		; enable per scan HBI

		move.l	#$8134C004,Nat_dispDis		;
		move.l	#$8134C012,Nat_dispDis2		; reset display disable and DMA offset
		move.l	#$00808174,Nat_dispEn		; reset display enable
		move.l	#$93079400,Nat_DMAlen		; reset DMA lenght

	stopZ80

		moveq	#0,Nat_PalOffs			; reset palette offset
		moveq	#0,Nat_HscrOffs
		move.l	#(($9600|(((($FF0000)>>1)&$FF00)>>8))<<16)|($9500|((($FF0000)>>1)&$FF)),(Nat_VDPc)
		move.w	#$9700|((((($FF0000)>>1)&$FF0000)>>16)&$7F),(Nat_VDPc)		; reset DMA lenght
		move.l	Nat_DMAlen,(Nat_VDPc)		; reset DMA lenght

		move	#$2300,sr

.loop		cmp.b	#62/2,(Nat_HV)
		ble.s	.loop

		move.l	#$8134C004,Nat_dispDis		;
		move.l	#$8134C012,Nat_dispDis2		; reset display disable and DMA offset
		move.l	#$80148174,(Nat_VDPc)		; enable H-Int

.loop2		STOP	#$2300				; halt until H-Int
		cmp.b	#338/2,(Nat_HV)
		bne.s	.loop2				; if not yet scanline #, loop

		move.l	#$80048134,(Nat_VDPc)		; disable H-int
		tst.b	$FFFFF604.w
		bpl.s	.loop				; loop indefinitely

		lea	InterruptMain.w,a6		; restore ints
		jmp	LoadJump
; ===========================================================================

Natsumi_ints:	jmp	NatsumiVBlank.l			; Vblank routine

		move.l	Nat_dispDis,(Nat_VDPc)		; disable display
		move.l	Nat_dispEn,(Nat_VDPc)		; start DMA; enable display

		move.l	Nat_DMAlen,(Nat_VDPc)		; reset DMA lenght
		exg	Nat_dispDis,Nat_dispDis2	; swap CRAM targets
		rte
; ===========================================================================

NatsumiVBlank:
;		movem.l	d0-a6,-(sp)
;		btst	#6,HW_Version.w
;		beq.s	.ass
;		move.w	#$700,d0

;		dbf	d0,*

.ass		jsr	ReadJoypads
;		jsr     UpdateMusic             ; run SMPS
;		movem.l	(sp)+,d0-a6

		add.w	#276/3,Nat_HscrOffs
		move.w	#$8F04,(Nat_VDPc)	; autoincrement of 8

		cmp.w	#(276/3*3)*8*22,Nat_HscrOffs
		bne.s	.skp2
		bset	#7,$FFFFF604.w

.skp2		move.w	#$9500|(((HScroll_NatsumiScreen)>>1)&$FF),d0; get DMA offset
		add.b	Nat_HscrOffs,d0		; add low byte of palette offset
		move.w	d0,(Nat_VDPc)		; move to VDP

		move.w	#$9600|((((HScroll_NatsumiScreen)>>1)&$FF00)>>8),d0
		move.w	Nat_HscrOffs,d1		; get palette offset
		lsr.w	#8,d1			; get high byte
		add.b	d1,d0			; add to VDP command
		move.w	d0,(Nat_VDPc)		; move to vDP

		move.w	#$9700|(((((HScroll_NatsumiScreen)>>1)&$FF0000)>>16)&$7F),(Nat_VDPc)
		move.l	#(($9400|((((276)>>1)&$FF00)>>8))<<16)|($9300|(((276)>>1)&$FF)),(Nat_VDPc)
		move.l	#$7C740083,(Nat_VDPc)	; DMA HScroll

		move.w	#$8F02,(Nat_VDPc)	; autoincrement of 2
		sub.w	#14*2,Nat_PalOffs	; get earlier line
		bpl.s	.skp			; if positive, still keep the old one
		move.w	#14*2*$18,Nat_PalOffs	; reset palette offset

.skp		move.w	#$9500|((($FF0000)>>1)&$FF),d0; get DMA offset
		add.b	Nat_PalOffs,d0		; add low byte of palette offset
		move.w	d0,(Nat_VDPc)		; move to VDP

		move.w	#$9600|(((($FF0000)>>1)&$FF00)>>8),d0
		move.w	Nat_PalOffs,d1		; get palette offset
		lsr.w	#8,d1			; get high byte
		add.b	d1,d0			; add to VDP command
		move.w	d0,(Nat_VDPc)		; move to vDP

		move.w	#$9700|((((($FF0000)>>1)&$FF0000)>>16)&$7F),(Nat_VDPc)
		move.l	Nat_DMAlen,(Nat_VDPc)	; reset lenght
		rte
; ===========================================================================

Pal_NatsumiScreen_al:
	align $20000
Pal_NatsumiScreen:
		rept $20
			dc.w $0420, $0422, $0622, $0640, $0642, $0662, $0884, $0660, $0862, $0882, $0CA6, $0EEA, $0AA6, $0AC8
		endr

		rept 2
			dc.w $0640, $0644, $0844, $0862, $0864, $0884, $0AA8, $0882, $0A84, $0AA4, $0EC8, $0EEC, $0CC8, $0CEA
		endr

		rept 2
			dc.w $0862, $0866, $0A66, $0A84, $0A86, $0AA6, $0CCA, $0AA4, $0CA6, $0CC6, $0EEA, $0EEE, $0EEA, $0EEC
		endr

		rept 2
			dc.w $0A84, $0A88, $0C88, $0CA6, $0CA8, $0CC8, $0EEC, $0CC6, $0EC8, $0EE8, $0EEC, $0EEE, $0EEC, $0EEE
		endr

		rept 2
			dc.w $0CA6, $0CAA, $0EAA, $0EC8, $0ECA, $0EEA, $0EEE, $0EE8, $0EEA, $0EEA, $0EEE, $0EEE, $0EEE, $0EEE
		endr

		rept 2
			dc.w $0EC8, $0ECC, $0ECC, $0EEA, $0EEC, $0EEC, $0EEE, $0EEA, $0EEC, $0EEC, $0EEE, $0EEE, $0EEE, $0EEE
		endr

		rept 2
			dc.w $0CA6, $0CAA, $0EAA, $0EC8, $0ECA, $0EEA, $0EEE, $0EE8, $0EEA, $0EEA, $0EEE, $0EEE, $0EEE, $0EEE
		endr

		rept 2
			dc.w $0A84, $0A88, $0C88, $0CA6, $0CA8, $0CC8, $0EEC, $0CC6, $0EC8, $0EE8, $0EEC, $0EEE, $0EEC, $0EEE
		endr

		rept 2
			dc.w $0862, $0866, $0A66, $0A84, $0A86, $0AA6, $0CCA, $0AA4, $0CA6, $0CC6, $0EEA, $0EEE, $0EEA, $0EEC
		endr

		rept 2
			dc.w $0640, $0644, $0844, $0862, $0864, $0884, $0AA8, $0882, $0A84, $0AA4, $0EC8, $0EEC, $0CC8, $0CEA
		endr

		rept $1F
			dc.w $0420, $0422, $0622, $0640, $0642, $0662, $0884, $0660, $0862, $0882, $0CA6, $0EEA, $0AA6, $0AC8
		endr
Pal_NatsumiScreen_end:
; ===========================================================================

HScroll_NatsumiScreen:
		include "#Natsumi/HScroll1.asm"
		include "#Natsumi/HScroll2.asm"
		include "#Natsumi/HScroll3.asm"
		include "#Natsumi/HScroll4.asm"
		include "#Natsumi/HScroll5.asm"
		include "#Natsumi/HScroll6.asm"
		include "#Natsumi/HScroll7.asm"
		include "#Natsumi/HScroll8.asm"
		include "#Natsumi/HScroll9.asm"

Map_NatsumiScreen_size	= *-HScroll_NatsumiScreen
Pal_NatsumiScreen_size	= Pal_NatsumiScreen_end-Pal_NatsumiScreen
Pal_NatsumiScreen_asize	= Pal_NatsumiScreen-Pal_NatsumiScreen_al
	inform 0,"$\$Pal_NatsumiScreen_size $\$Map_NatsumiScreen_size $\$Pal_NatsumiScreen_asize"
; ===========================================================================

Maps_NatScrn:		incbin "#Natsumi/Map.unc"
			even
ArtUnc_NsTiles:		incbin "#Natsumi/Art.kos"
			even
; ===========================================================================
Emusucks_ints:
		move.l	d5,(Nat_VDPc)
		move.l	d7,(Nat_VDPc)		; reset DMA lenght
		rte
		move.l	d6,(Nat_VDPc)		; DMA!
	;	move.l	d5,(Nat_VDPc)
		move.l	d7,(Nat_VDPc)		; reset DMA lenght
		rte

EmuSucks_maps:
		Text.w 'Y','O','U','R',$23,'E','M','U','L','A','T','O','R',$23,'S','U','C','K','S'
EmuSucks_maps2:
		Text.w 'E','S','P','E','C','I','A','L','L','Y',$23,'I','F',$23,'Y','O','U',$23,'H','E','A','R',$23,'S','T','A','T','I','C'

YourEmuSucks:
		jsr	ClearScreen

		move	#$2700,sr
		move.l	#$42000000,VDP_control_port
		lea	ArtNem_S22POptions,a0
		jsr	NemDec
		move	#$2300,sr

		lea	Pal_SonicTailsS2,a1
		lea	Palette_NCurr.w,a2
		moveq	#$1F,d0
		jsr	Loc_Pal

		dma68kToVDP	EmuSucks_maps,$E612,19*2,VRAM
		dma68kToVDP	EmuSucks_maps2,$E80A,29*2,VRAM

		move.w	#$40,$C0001C	; <- lol this breaks fusion
		move.w	#20,d6

.dma		move.b	#2,VBlank_Routine.w
		jsr	DelayProgram
		subq.w	#1,d6
		bpl.s	.dma

		move.w	#0,$C0001C
		lea	InterruptMain.w,a6
		jmp	LoadJump
