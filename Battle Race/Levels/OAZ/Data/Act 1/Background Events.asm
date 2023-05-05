; ===========================================================================
; ---------------------------------------------------------------------------
; Background Events - The Setup
; ---------------------------------------------------------------------------

OAZ1_BackgroundInit:
		movem.l	d0-a6,-(sp)				; store registers
		jsr	Create_New_Sprite.w			; find a free object slot
		bne.s	OAZ1_BI_NoArm				; if none are available (highly impossible here), branch
		move.l	#Obj_StatueArm,(a1)			; set object routine
		move.b	#%00000100,render_flags(a1)		; set render flag bits
		move.w	#$C000|($1DC0/$20),art_tile(a1)		; set VRAM address of arm
		move.l	#Map_StatueArm,mappings(a1)		; set mappings list address
		move.w	#$281C,height_pixels(a1)		; set width and height of graphics
		move.w	#OAZ1_FloorPos+$108,y_pos(a1)		; set Y position

OAZ1_BI_NoArm:
		lea	(Sprite_table_buffer_P2_2+$200).l,a1			; load block buffer
		moveq	#($80/4)-1,d1				; set size to clear
		moveq	#$00,d0					; clear d0

OAZ1_BI_ClearHScroll:
		move.l	d0,(a1)+				; clear block buffer
		dbf	d1,OAZ1_BI_ClearHScroll			; repeat until cleared
		jsr	OAZ1_Scroll				; run level's scrolling
		movem.l	(sp)+,d0-a6				; restore registers
		jsr	Reset_TileOffsetPositionEff		; setup X and Y xor positions
		moveq	#$00,d1					; X draw position?
		jmp	Refresh_PlaneFull			; render the entire screen

; ---------------------------------------------------------------------------
; The arm to the statue which scrolls along the FG
; ---------------------------------------------------------------------------

Obj_StatueArm:
		move.w	(Camera_X_pos_Copy).w,d0		; load X position of camera
		addi.w	#$0140,d0				; adjust to avoid wrapping on-screen
		andi.w	#$FE00,d0				; keep it within the range
		addi.w	#$0034,d0				; advance to position where arm should be
		move.w	d0,x_pos(a0)				; set X position
		jmp	Draw_Sprite.w				; save object for display

	; --- Mappings ---

Map_StatueArm:	dc.w	Map00_Arm-Map_StatueArm

Map00_Arm:	dc.w	$0007
		dc.b	$D8,$01,$00,$00,$FF,$E4
		dc.b	$D8,$0F,$00,$02,$FF,$EC
		dc.b	$F0,$00,$00,$12,$00,$0C
		dc.b	$F8,$0F,$00,$13,$FF,$EC
		dc.b	$F8,$06,$00,$23,$00,$0C
		dc.b	$18,$08,$00,$29,$FF,$F4
		dc.b	$20,$00,$00,$2C,$FF,$FC

; ===========================================================================
; ---------------------------------------------------------------------------
; Background Events - The scrolling
; ---------------------------------------------------------------------------

OAZ1_BackgroundEvent:
		movem.l	d0-a6,-(sp)				; store registers
		bsr.s	OAZ1_Scroll				; run level's scrolling
		movem.l	(sp)+,d0-a6				; restore registers
		lea	(Camera_Y_pos_BG_copy).w,a6		; load Y position RAM data
		lea	(Camera_Y_pos_BG_rounded).w,a5		; load Y XOR RAM data
		moveq	#$00,d1					; set X position (perminantly draw from position 0.
	cmpi.w	#$1000,(Camera_X_pos_copy).w		; has the screen reached the carpet area?
	blo.s	OAZ1_BG_NoCarpet			; if not, branch
	move.w	#$0200,d1				; set X position to carpet floor

OAZ1_BG_NoCarpet:
		moveq	#$21-1,d6				; set mazimum number of blocks to draw in a row
		jmp	Draw_TileRow				; draw only horizontal rows if moved by XOR amount

; ===========================================================================
; ---------------------------------------------------------------------------
; The scrolling routine itself
; ---------------------------------------------------------------------------

OAZ1_Scroll:
		move.w	(Camera_X_pos_Copy).w,d2		; load X position
		neg.w	d2					; reverse direction
		move.w	d2,d0					; keep a copy
		swap	d2					; send to upper word for FG
		move.w	d0,d2					; send copy to lower word for BG

		move.l	(Camera_Y_pos_copy).w,d3		; load Y position to upper word
		move.w	(Camera_Y_pos_copy).w,d3		; load Y position
		asr.w	#$02,d3					; divide by 4 (slow it down)
		addi.w	#OAZ1_AdjustBG,d3			; adjust
		move.w	d3,(Camera_Y_pos_BG_copy).w		; set as BG Y position

		move.w	#$00E0,d7				; prepare number of scanlines
		move.w	(Camera_Y_pos_copy).w,d6		; load Y position
		subi.w	#OAZ1_FloorPos,d6			; has the screen reached the floor section?
		ble.w	OAZ1_SC_Normal				; if not, branch

		move.w	(Camera_Y_pos_copy).w,d3		; load Y position
		sub.w	d6,d3					; get position where floor area starts
		asr.w	#$02,d3					; divide by 4 (slow it down)
		addi.w	#OAZ1_AdjustBG,d3			; adjust
		add.w	d6,d3					; move BG at FG speed
		cmpi.w	#((OAZ1_FloorPos>>2)+$D0+OAZ1_AdjustBG),d3 ; has the BG reached the bottom?
		blo.s	OAZ1_SC_NoStop				; if not, branch
		move.w	#((OAZ1_FloorPos>>2)+$D0+OAZ1_AdjustBG)-1,d3 ; force it not to go too far (don't want the draw code to draw a block)

OAZ1_SC_NoStop:
		move.w	d3,(Camera_Y_pos_BG_copy).w		; set as BG Y position

	; --- Special floor ---

		lea	(WriteHScroll).l,a6			; load H-scroll write routine

		lea	(H_scroll_buffer).w,a2			; load H-scroll buffer
		lea	(Block_table+$1800).w,a0			; load V-scroll buffer
		tst.w	(a0)+					; is H-blank using buffer 1?
		bmi.s	OAZ1_SC_Buffer1				; if not, branch to use buffer 1
		lea	$100(a0),a0				; use buffer 2

OAZ1_SC_Buffer1:
	asr.w	#$02,d2					; slow BG down
	;	swap	d2					; slow down bricks and shift right half a brick
	;	move.l	d2,d5					; copy H-scroll position for bricks
	;	asr.w	#$03,d5					; '' (slow it down)
	;	sub.w	d2,d5					; ''
	;	neg.w	d5					; ''
	;	addq.w	#$08,d5					; ''
	;	swap	d2					; realign d2 for H-scroll

	move.l	d2,d5					; slow down bricks and shift right half a brick
	clr.w	d5					; '' (complete with fraction calculation)
	move.l	d5,d4					; ''
	asr.l	#$03,d5					; ''
	sub.l	d4,d5					; ''
	neg.l	d5					; ''
	addi.l	#$00080000,d5				; ''
	move.w	d2,d5					; ''
	swap	d5					; ''

		moveq	#$08-3,d1				; set number of bricks to render
		move.l	d3,d4					; load V-scroll position for first section
		sub.w	d6,d7					; get distance from floor area
		bgt.s	OAZ1_SC_DoNormal			; if there's still a normal section, branch

OAZ1_SC_FindBrick:
		addq.w	#$08,d5					; shift brick position right half a brick
		subq.w	#$01,d1					; decrease brick count (a brick is going out of the screen)
		subi.l	#$00080000,d3				; move V-scroll up to bricks again
		addq.w	#$08,d7					; move position in for bricks
		ble.s	OAZ1_SC_FindBrick			; if we haven't gotten bricks onto screen yet, branch
		move.l	d5,d2					; copy brick scroll position to d2
		swap	d2					; realign for H-scroll table
		move.l	d3,d4					; load V-scroll position to d4
		addi.l	#$00080000,d4				; move it forwards onto bricks for the first interrupts (d3 is set for the next interrupt)

OAZ1_SC_DoNormal:
		swap	d5					; realign brick H-scroll position for table
		move.w	#$8A00,d0				; load H-blank register
		move.b	d7,d0					; get size
		subq.b	#$01,d0					; minus 1 (position of next interrupt line)
		move.w	d0,(a0)+				; save as interrupt position
		move.l	#HB_OAZ_VScroll,(a0)+			; set routine
		move.l	d4,(a0)+				; write first V-scroll

		move.w	d7,d4					; load size of top/brick section
		neg.w	d4					; convert to negative
		add.w	d4,d4					; multiply by size of word instruction
		move.l	d2,d0					; load H-scroll position
		jsr	(a6,d4.w)				; do the H-scroll

		move.w	#$00E0,d4				; get remaining scanlines left
		sub.w	d7,d4					; ''

OAZ1_SC_NextBrick:
		move.w	#$8A00|($08-1),(a0)+			; set H-blank position
		move.l	#HB_OAZ_VScroll,(a0)+			; set H-blank address
		move.l	d3,(a0)+				; set V-scroll position
		subi.l	#$00080000,d3				; move brick back into screen
		addi.l	#$00080000,d5				; move right for next brick
		subq.w	#$08,d4					; decrease number of scanlines left
		bge.s	OAZ1_SC_NoFinBricks			; if not finished, branch
		move.w	d4,d1					; load number of scanlines left to d1
		addq.w	#$08,d1					; reverse count
		neg.w	d1					; ''
		add.w	d1,d1					; multiply by size of word
		move.l	d5,d0					; load H-scroll position
		jsr	(a6,d1.w)				; do the last bit of H-scroll
		bra.w	OAZ1_SC_Finish				; finish H-blank

OAZ1_SC_NoFinBricks:
		move.l	d5,d0					; load H-scroll position
		jsr	-$08*2(a6)				; do the H-scroll
		dbf	d1,OAZ1_SC_NextBrick			; repeat for all bricks on screen

OAZ1_SC_LastBricks:
		addi.l	#$00080000,d5				; move right for next brick
		move.l	d5,d0					; load H-scroll position

		move.w	#$8A00|($10-1),(a0)+			; set final brick section
		move.l	#HB_OAZ_VScroll,(a0)+			; ''
		move.l	d3,(a0)+				; ''
		subi.w	#$0010,d4				; decrease size of brick section for H-scroll
		bge.s	OAZ1_SC_NoFinLastBrick			; if the entire 10 pixel brick section will fit, branch
		move.w	d4,d1					; load number of scanlines left to d1
		neg.w	d1					; convert to positive
		cmpi.w	#$0008,d1				; is there enough to fill a full brick?
		bhs.s	OAZ1_SC_FinalBrick			; if not, branch
		addq.w	#$08,d1					; decrease count
		jsr	-$08*2(a6)				; do the last bit of H-scroll
	;	swap	d5					; slow H-scroll down for lowest brick
	;	move.l	d5,d0					; ''
	;	asr.w	#$04,d0					; ''
	;	sub.w	d5,d0					; ''
	;	neg.w	d0					; ''
	;	swap	d5					; ''
	;	swap	d0					; ''
	move.l	d5,d0					; slow H-scroll down for lowest brick
	clr.w	d0					; '' (with fraction calculation in mind)
	move.l	d0,d2					; ''
	asr.l	#$04,d0					; ''
	sub.l	d2,d0					; ''
	neg.l	d0					; ''
	move.w	d5,d0					; ''

OAZ1_SC_FinalBrick:
		subi.w	#$0010,d1				; reverse count
		add.w	d1,d1					; multiply by size of word
		jsr	(a6,d1.w)				; do the last bit of H-scroll
		bra.w	OAZ1_SC_Finish				; finish H-blank

OAZ1_SC_NoFinLastBrick:
		jsr	-$08*2(a6)				; do the last bit of H-scroll
	;	swap	d5					; slow H-scroll down for lowest brick
	;	move.l	d5,d0					; ''
	;	asr.w	#$04,d0					; ''
	;	sub.w	d5,d0					; ''
	;	neg.w	d0					; ''
	;	swap	d5					; ''
	;	swap	d0					; ''
	move.l	d5,d0					; slow H-scroll down for lowest brick
	clr.w	d0					; '' (with fraction calculation in mind)
	move.l	d0,d2					; ''
	asr.l	#$04,d0					; ''
	sub.l	d2,d0					; ''
	neg.l	d0					; ''
	move.w	d5,d0					; ''
		jsr	-$08*2(a6)				; do the last brick H-scroll

	; --- The curtain area ---

		move.w	(Camera_Y_pos_Copy).w,d3		; get distance the screen is from the floor
		sub.w	#$0F10,d3				; ''
		move.w	d3,d1					; copy to d1
		subi.w	#$18,d1					; start as already having a distance
	move.w	d3,d0
	asr.w	#$02,d0
	sub.w	d0,d3
	asr.w	#$02,d0
	sub.w	d0,d3


		sub.w	d3,d1					; ''
		ext.l	d1					; extend for division...
		move.l	d1,d6					; store for floor perspective later
		asl.l	#$03,d1					; every $18 pixels the floor is from the pillars, the...
		divs.w	#$18,d1					; ...BG curtains should be 8 pixels (conversion here)

		move.w	d3,d5					; add pillar position to this 18 > 8 pixel conversion
		sub.w	d1,d5					; ''
		move.w	(Camera_Y_pos_copy).w,d1		; load screen's FG Y position
		sub.w	d5,d1					; minus curtain position
		subi.w	#$0EA0,d1				; adjust (get Y size of curtains)

		move.w	#$8A00,d0				; prepare VDP H-blank register
		move.b	d1,d0					; load size of curtains
		subq.b	#$01,d0					; minus 1 (since 0 = 1 scanline)
		move.w	d0,(a0)+				; save for H-blank
		move.l	#HB_OAZ_VScroll,(a0)+			; set H-blank address
		addi.w	#$FFE0,d3				; adjust FG into position
		swap	d3					; send FG to upper word
		addi.w	#$0050,d5				; adjust BG into position
		move.w	d5,d3					; send BG to lower word
		move.l	d3,(a0)+				; save V-scroll position



		move.l	(Camera_X_pos_copy).w,d2		; prepare FG X position
		asr.l	#$02,d2					; slow down for pillars
		sub.l	(Camera_X_pos_copy).w,d2		; ''
		subi.l	#$00100000,d2				; adjust pillar position

	move.l	(Camera_X_pos_copy).w,d5		; prepare BG X position
	asr.l	#$02,d5					; slow down for curtains
	sub.l	(Camera_X_pos_copy).w,d5		; ''
	neg.l	d5					; reverse direction
	swap	d5					; copy to BG X position in d2
	move.w	d5,d2					; ''
	swap	d5					; '' (keep  a copy in d5
	;	move.w	(Camera_X_pos_copy).w,d2		; prepare BG X position
	;	asr.w	#$02,d2					; slow down for curtains
	;	sub.w	(Camera_X_pos_copy).w,d2		; ''
	;	neg.w	d2					; reverse direciton
		move.w	d2,d0					; copy and slow it down
		asr.w	#$03,d2					; ''
		sub.w	d0,d2					; subtract it from position to slow curtains down a little more than pillars

		move.w	d2,d0					; copy to d0 (can't tamper with upper word of d2)
		ext.l	d0					; extend to long-word for dividsion instruction
		divs.w	#112,d0					; divide because it's not a component of 2 (thus and cannot be used...)
		swap	d0					; ''
		subi.w	#$0080-$30,d0				; align curtain shadows to position
		move.w	d0,d2					; save as H-scroll BG

		move.l	d2,d0					; load H-scroll position back to d0
		sub.w	d1,d4					; subtract size of curtains from scanlines left
		bgt.s	OAZ1_SC_NoFinCurtain			; if the entire curtain section is on-screen, branch

		add.w	d4,d1					; put scanlines back and convert for jsr
		neg.w	d1					; ''
		add.w	d1,d1					; ''
		jsr	(a6,d1.w)				; write H-scroll positions
		bra.w	OAZ1_SC_Finish				; finish H-blank setup

OAZ1_SC_NoFinCurtain:
		neg.w	d1					; convert curtain size to negative
		add.w	d1,d1					; multiply by size of word instruction
		jsr	(a6,d1.w)				; write H-scroll positions

	; --- The floor section itself ---

		subq.w	#$01,d4					; minus 1 from remaining count
		bmi.w	OAZ1_SC_Finish				; if finished, branch

	move.l	#HB_OAZ_VScrollLast,-$08(a0)		; change last H-blank address

	move.w	a0,d0
	andi.w	#$FF00,d0
		move.w	#$8A00,(a0)+				; set H-blank interrupt to every line
		move.l	#HB_OAZ_Floor1,(a0)
	cmpi.w	#$A800,d0
	beq.s	OAZ1_SC_HBlank1
		move.l	#HB_OAZ_Floor2,(a0)

OAZ1_SC_HBlank1:

	move.b	d4,d0
	addq.b	#$01,d0
	neg.b	d0
	add.b	d0,d0
	movea.w	d0,a4
	move.w	d4,d0
	muls.w	#$10,d0		; Size of H-blank routine...
	sub.l	d0,(a0)+

;	cmpi.w	#$A800+$70,d0
;	beq.s	OAZ1_SC_NextFloor
;		move.l	#HB_OAZ_Floor2,(a0)+
	swap	d3
	clr.w	d3
	move.l	#$00010000,d0
	neg.l	d6
	subi.w	#$18,d6
	beq.s	OAZ1_SC_NoDiv
;	bra.s	OAZ1_SC_NoAdjust

;	cmpi.w	#$18,d6
;	blo.s	OAZ1_SC_NoAdjust
;	subi.w	#$18,d6
;	neg.w	d6
;	ext.l	d6
;	lsl.l	#$08,d6
;	lsl.l	#$02,d6
;	move.l	d6,d0
;	bra.s	OAZ1_SC_TEMP

OAZ1_SC_NoAdjust:
	lsl.l	#$08,d6
	divs.w	#$18,d6
	ext.l	d6
	lsl.l	#$08,d6
	sub.l	d6,d0

;OAZ1_SC_TEMP:

OAZ1_SC_NoDiv:

	swap	d2

;	move.l	(Camera_X_pos_copy).w,d1		; load X position again
;	asr.l	#$02,d1
;	sub.l	(Camera_X_pos_copy).w,d1
;	neg.l	d1

	move.l	d5,d1
	swap	d1
	andi.w	#$001F,d1
	subi.w	#$0010,d1
	swap	d1
	move.l	d1,d5
	asr.l	#$03,d1
	sub.l	d5,d1

	asr.l	#$07,d5

	move.l	d3,d6
	swap	d6
	sub.l	d0,d3

OAZ1_SC_NextFloor:
	add.l	d0,d3
	swap	d3
	move.w	d3,(a4)+
	cmp.w	d3,d6
	beq.s	OAZ1_SF_FLSKIP
	move.w	d3,d6
	sub.l	d5,d1

OAZ1_SF_FLSKIP:
	swap	d3

	move.w	d2,(a2)+
	swap	d1
	move.w	d1,(a2)+
	swap	d1
	sub.l	d5,d1

		dbf	d4,OAZ1_SC_NextFloor




;		move.w	#$8A00|($01-1),(a0)+
;		move.l	#HB_OAZ_Floor,(a0)+
;		move.l	d3,(a0)+

;	neg.w	d4
;	add.w	d4,d4
;	move.l	d2,d0
;	clr.w	d0
;	jsr	(a6,d4.w)



OAZ1_SC_Finish:
		move.w	#$8AFF,(a0)+
		move.l	#HB_OAZ_NULL,(a0)+
		rts						; return

; ---------------------------------------------------------------------------
; Normal scrolling
; ---------------------------------------------------------------------------

OAZ1_SC_Normal:
		clr.w	(Block_table+$1800).w				; clear buffer to use

		lea	(Sprite_table_buffer_P2_2+$200).l,a1			; load block buffer
		clr.w	(a1)+					; set moon speed
		move.l	(a1),d0					; load first cloud speed
		subi.l	#$00002000,d0				; increase first cloud speed
		move.l	d0,(a1)+				; set first cloud speed
		subi.l	#$00008000,d0				; displace for the animated tiles
		swap	d0					; ''
		move.w	d0,(a1)+				; save for animated tiles
		subi.l	#$00004000,(a1)+			; increase second clound speed
		subi.l	#$00005000,(a1)+			; increase third cloud speed
		subi.l	#$00008000,(a1)+			; increase fourth cloud speed

		lea	OAZ1_List(pc),a0			; load scroll list to use
		jmp	DeformScroll				; render list to scroll table

; ---------------------------------------------------------------------------
; Scroll data
; ---------------------------------------------------------------------------

OAZ1_List:
		dc.w	$7F80+$0C,	$78			; large cloud
		dc.w	$7F80+$08,	$18			; mid clouds
		dc.w	$7F80+$02,	$10			; small clouds
		dc.w	$7F80+$00,	$B0			; Moon
		dc.w	$7F80+$02,	$10			; small clouds
		dc.w	$7F80+$08,	$18			; mid clouds
		dc.w	$7F80+$0C,	$20			; large clouds
		dc.w	$7F80+$10,	$400			; larger clouds

		dc.w	$0000					; end of list

; ===========================================================================
; ---------------------------------------------------------------------------
; Scroll writing chain
; ---------------------------------------------------------------------------

		rept	$E0
		move.l	d0,(a2)+				; write scroll position
		endm
WriteHScroll:	rts						; return

; ===========================================================================



