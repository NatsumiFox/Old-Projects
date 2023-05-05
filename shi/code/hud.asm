; ---------------------------------------------------------------------------
HUDframe:
	dcb.b 7, 0	; 7 frames with RINGS
	dc.b 2		; 1 frame with faded RINGS
	dcb.b 7, 4	; 7 frames without RINGS
	dc.b 2		; 1 frame with faded RINGS
; ---------------------------------------------------------------------------

BuildHUD:
		moveq	#0,d4
		tst.w	Ring_Count.w
		bne.s	.norings		; branch if you have more than 0 rings
		move.b	Level_Frame_Timer+1.w,d4; get level timer
		lsr.w	#2,d4			; shift twice (division by 4)
		and.w	#$F,d4			; get only 16 frames
		move.b	HUDframe(pc,d4.w),d4	; get correct frame

.norings	move.b	Level_Start_Flag.w,d0	; get x-position of the HUD
		ext.w	d0
		bpl.s	.noadd			; branch if positive

		; this is used in AIZ intro, after Knuckles exits
		addq.w	#8,d0			; scroll in
		move.b	d0,Level_Start_Flag.w	; save it back

.noadd		lea	Map_HUD2(pc),a1
		adda.w	(a1,d4.w),a1		; get mappings data
		tst.w	Debug_Routine.w
		beq.s	.drawfinal		; if debug isnt active, draw rings only
		lea	Map_HUD(pc),a1

.drawfinal	addi.w	#$8F,d0			; add $8F to the HUD's x position
		move.w	#$108,d1		; maybe this is y-offset
		moveq	#0,d5			; this art tile
		move.w	(a1)+,d4		; get sprite pieces
		subq.w	#1,d4			; sub 1
		bmi.s	.drawTails		; if negative, dont display
		jsr	DrawSpritePiece		; render the sprite pieces

.drawTails	tst.b	HUD_RenderTails.w	; check if flag is set
		bpl.w	HUD_TimeOver		; branch if not
		clr.b	HUD_RenderTails.w	; then clear it

		lea	HudTailsIconMap(pc),a1	; get mappings ptr
		move.w	Obj_player_2+xpos.w,d0	; get x-position
		move.w	Obj_player_2+ypos.w,d1	; get y-position
		moveq	#0,d5			; this art tile
		moveq	#1,d4			; get sprite pieces
		jmp	DrawSpritePiece		; render the sprite pieces
; ---------------------------------------------------------------------------

UpdateHUD:
		lea	VDP_data_port,a6
		tst.w	Debug_Routine.w
		bne.w	HUDDebug

.chkrings	tst.b	Update_HUD_Rings.w
		beq.w	HUD_TimeOver
		bpl.s	.donormal
		bsr.w	HUD_DrawZeroRings

.donormal	clr.b	Update_HUD_Rings.w
	vdpComm	move.l,$D740,VRAM,WRITE,d0
		moveq	#0,d1
		move.w	Ring_Count.w,d1
		bra.w	HUD_DrawRings
; --------------------------------------------------------------------------

HUDDebug:
		bsr.w	HudCoords
		tst.b	Update_HUD_Rings.w
		beq.s	loc_DE18
		bpl.s	.donormal
		bsr.w	HUD_DrawZeroRings

.donormal	clr.b	Update_HUD_Rings.w
	vdpComm	move.l,$D740,VRAM,WRITE,d0
		moveq	#0,d1
		move.w	Ring_Count.w,d1
		bsr.w	HUD_DrawRings

loc_DE18:
	vdpComm	move.l,$DD80,VRAM,WRITE,d0
		moveq	#0,d1
		move.b	Sprite_Count.w,d1
		bra.w	HUD_DrawTimeSec		; write sprite count

HudCoords:
	vdpComm	move.l,$DE00,VRAM,WRITE,4(a6)
		move.w	Camera_X.w,d1
		swap	d1
		move.w	Object_RAM+xpos.w,d1
		bsr.s	.common

		move.w	Camera_Y.w,d1
		swap	d1
		move.w	Object_RAM+ypos.w,d1

.common		moveq	#8-1,d6
		lea	HudArt_DebugNums,a1

.loop		rol.w	#4,d1
		move.w	d1,d2
		andi.w	#$F,d2
		cmpi.w	#10,d2
		blo.s	.notAF
		addi.w	#7,d2		; increment to A-F

.notAF		lsl.w	#5,d2
		lea	(a1,d2.w),a3

	rept 8
		move.l	(a3)+,(a6)
	endr
		swap	d1
		dbf	d6,.loop

HUD_TimeOver:
HUD_AddScore:
		rts
; ---------------------------------------------------------------------------

HUD_DrawInit:
		lea	VDP_data_port,a6
HUD_DrawZeroRings:
	vdpComm	move.l,$D740,VRAM,WRITE,VDP_control_port
		lea	HUD_ZeroRings(pc),a2
		move.w	#3-1,d2

loc_DEBE:
		lea	HudArt_NumLarge(pc),a1
.loop2		move.w	#16-1,d1
		move.b	(a2)+,d0
		bmi.s	.loop3		; if byte is negative, its space
		ext.w	d0
		lsl.w	#5,d0
		lea	(a1,d0.w),a3

.loop		move.l	(a3)+,(a6)
		dbf	d1,.loop
.0		dbf	d2,.loop2
		rts

.loop3		move.l	#0,(a6)
		dbf	d1,.loop3
		bra.s	.0

locret_DEEA:
		rts

; ---------------------------------------------------------------------------
HUD_ZeroRings:	dc.b $FF, $FF, 0	; "  0"
		even
; ---------------------------------------------------------------------------

HUD_DrawRings:
		lea	HUDNum_100(pc),a2
		moveq	#2,d6
		bra.s	loc_DF92

HUD_DrawScore:
		lea	HUDNum_100000(pc),a2
		moveq	#5,d6

loc_DF92:
		moveq	#0,d4
		lea	HudArt_NumLarge(pc),a1

.writeNext	moveq	#0,d2
		move.l	(a2)+,d3

.fetchnum	sub.l	d3,d1
		blo.s	.numgot
		addq.w	#1,d2		; next number
		bra.s	.fetchnum

.numgot		add.l	d3,d1
		tst.w	d2
		beq.s	.writeTiles
		move.w	#1,d4		; start writing tiles

.writeTiles	tst.w	d4
		beq.s	.dontwrite	; if d4 is set, write 0's too
		lsl.w	#6,d2
		move.l	d0,4(a6)
		lea	(a1,d2.w),a3

	rept 16
		move.l	(a3)+,(a6)
	endr

.dontwrite	addi.l	#$400000,d0	; next tile
		dbf	d6,.writeNext
		rts

; ---------------------------------------------------------------------------
HUDNum_100000:	dc.l 100000
		dc.l 10000
HUDNum_1000:	dc.l 1000
HUDNum_100:	dc.l 100
HUDNum_10:	dc.l 10
HUDNum_1:	dc.l 1
; ---------------------------------------------------------------------------

HUD_DrawTimeMin:
		lea	HUDNum_1(pc),a2
		moveq	#1-1,d6
		bra.s	loc_E06A

HUD_DrawTimeSec:
		lea	HUDNum_10(pc),a2
		moveq	#2-1,d6

loc_E06A:
		moveq	#0,d4
		lea	HudArt_NumLarge(pc),a1

.writeNext	moveq	#0,d2
		move.l	(a2)+,d3

.fetchnum	sub.l	d3,d1
		blo.s	.numgot
		addq.w	#1,d2
		bra.s	.fetchnum

.numgot		add.l	d3,d1
		tst.w	d2
		beq.s	.writeTiles
		move.w	#1,d4

.writeTiles	lsl.w	#6,d2
		move.l	d0,4(a6)
		lea	(a1,d2.w),a3

	rept 16
		move.l	(a3)+,(a6)
	endr

		addi.l	#$400000,d0
		dbf	d6,.writeNext

Locret_HUD123:
		rts
; ---------------------------------------------------------------------------
HTI_TimerDef	equ 6
HTI_Timer	equ routine
HTI_Cycle	equ height
HTI_Out		equ width
HTI_Last	equ mappings

HudTailsIcon:
		move.w	#$180-1,xpos(a0)	; set xpos
		move.w	#$A0,ypos(a0)		; set ypos
		sf	HTI_Timer(a0)		; clear timer
		sf	HTI_Cycle(a0)		; clear cycle offset
		move.b	#30,HTI_Out(a0)		; clear out off
		move.l	#HudTailsIconMain,(a0)	; set routine

HudTailsIconOut:
		addq.w	#2,xpos(a0)		; move out
		subq.b	#1,HTI_Out(a0)		; check if outside of screen
		bpl.s	HudTailsIconMain	; if not, branch
		move.l	parent(a0),(a0)		; set to target object
		clr.l	render(a0)		; clear used data
		rts

HudTailsIconMain:
		st	HUD_RenderTails.w	; render Tails icon
		subq.b	#1,HTI_Timer(a0)	; sub 1 from timer
		bpl.s	Locret_HUD123		; if positive, branch
		move.b	#HTI_TimerDef,HTI_Timer(a0); reset timer
		move.b	HTI_Cycle(a0),d0	; get cycle pojnter
		addq.b	#4,d0			; add 1 to cycle counter
		and.w	#$1C,d0			; keep in range
		move.b	d0,HTI_Cycle(a0)	; store cycle counter

		move.l	.offs(pc,d0.w),d1	; get offset
		cmp.l	HTI_Last(a0),d1		; check if we DMA'd this frame
		beq.s	Locret_HUD123		; if so, branch
		move.l	d1,HTI_Last(a0)		; save DMA'd frame

		move.w	#$200/2,d3		; set length
		move.w	#$6EE*$20,d2		; set art tile
		jmp	AddQueueDMA		; DMA new art!
; ---------------------------------------------------------------------------
.offs	rept 3
		dc.l HudArt_Tails
	endr
	dc.l HudArt_Tails+$200
	rept 3
		dc.l HudArt_Tails+$400
	endr
	dc.l HudArt_Tails+$200
; ---------------------------------------------------------------------------
Map_HUD:		include "levels/common/HUD/Map.asm"
Map_HUD2:		include "levels/common/HUD/Map2.asm"
HudTailsIconMap:	include "levels/common/HUD/icomap.asm"
; ---------------------------------------------------------------------------
HudArt_NumLarge:	inceven "levels/common/HUD/UNC Numbers Large.bin"
HudArt_NumSmall:	inceven "levels/common/HUD/UNC Numbers Small.bin"
HudArt_DebugNums:	inceven "levels/common/HUD/UNC Debug Numbers.bin"
; ---------------------------------------------------------------------------
