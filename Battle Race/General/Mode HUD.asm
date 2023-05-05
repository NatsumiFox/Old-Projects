; ===========================================================================
; ---------------------------------------------------------------------------
; HUD update codes
; ---------------------------------------------------------------------------

UpdateHUD_TagBattle:
	if 0=1
		bsr.s	loc_DD36
		moveq	#0,d1
		move.l	#$5CC00003,d0
		lea	LastHUD.w,a0			; NAT: P1 last
		move.w	TagTimer.w,d1			; NAT: Get the tag timer
		bsr.s	.dotag				; NAT: D�ET

		moveq	#0,d1
		move.l	#$5D400003,d0
		addq.w	#1,a0				; NAT: P2 last
		move.w	TagTimer2.w,d1			; NAT: Get the tag timer

.dotag		bpl.s	.normal				; NAT: If positive, branch
		move.w	#$FF,d1				; NAT: Force to FF
		bra.s	.nega

.normal		divu	#60,d1				; NAT: Divide by seconds
.nega		cmp.b	(a0),d1				; NAT: check if same as last
		beq.s	locret_DDCC			; NAT: If is, dont render
		move.b	d1,(a0)				; NAT: Save back
		and.l	#$FF,d1				; NAT: Clear upper bytes
		addq.b	#1,d1				; NAT: Increase by 1
		bra.w	DrawTwoDigitNumber		; NAT: Draw the number
	endif
; ---------------------------------------------------------------------------

UpdateHUD_TeamMode:
		move.l	#vdpComm((AT_HUD_Numbers)*32,VRAM,WRITE),d7
		bsr.s	UpdateHudTimer
		bra.s	UpdateHUD_MiniCNZ1

UpdateHUD_MiniSSZ:
		tst.b	MiniTimer.w			; NAT: Check if timer is 0
		bne.s	UpdateHUD_BattleRace		; if not, branch

ForceTimer_MiniSSZ:
		move.l	#vdpComm((AT_HUD_Numbers+$10)*32,VRAM,WRITE),d7
		bsr.s	UpdateHudTimer

UpdateHUD_BattleRace:
		tst.b	(Update_HUD_score).w
		beq.s	loc_DD36
		clr.b	(Update_HUD_score).w

		move.l	#vdpComm((AT_HUD_Numbers+4)*32,VRAM,WRITE),d0
		move.b	Score+1.w,d1
		bsr.w	DrawTwoDigitNumber

		move.l	#vdpComm((AT_HUD_Numbers)*32,VRAM,WRITE),d0
		move.b	Score.w,d1
		bsr.w	DrawTwoDigitNumber

UpdateHUD_MiniCNZ1:
loc_DD36:
		tst.b	(Update_HUD_ring_count).w
		beq.s	loc_DD56

		clr.b	(Update_HUD_ring_count).w
		move.l	#vdpComm((AT_HUD_Numbers+8)*32,VRAM,WRITE),d0
		move.b	Ring_count.w,d1
		bsr.w	DrawTwoDigitNumber

		move.l	#vdpComm((AT_HUD_Numbers+$C)*32,VRAM,WRITE),d0
		move.b	Ring_count+1.w,d1
		bra.w	DrawTwoDigitNumber

loc_DD56:
locret_DDCC:
		rts

UpdateHudTimer:
		move.l	d7,d0
		move.w	DisplayTimer.w,d1		; get seconds counter value
		bne.s	.not0				; special case - 0 -> 1
		addq.b	#1,d1				; make sure we do not underflow

.not0		subq.b	#1,d1				; decrement the timer value because we are too early
		divu	#60,d1				; divide by num of seconds in minute

		swap	d1				; quickly swap args around
		move.w	d1,d5				; copy to d5
		clr.w	d1				; clear upper word
		swap	d1				; awap around
		bsr.w	DrawTwoDigitNumber		; NAT: Draw the number

		move.l	d7,d0
		add.l	#$800000,d0			; skip 4 tiles now
		moveq	#0,d1
		move.w	d5,d1				; get number of seconds from d5
		bra.w	DrawTwoDigitNumber		; NAT: Draw the number
; ---------------------------------------------------------------------------

HUD_DrawZeroRings:
		move.l	#vdpComm((AT_HUD_Numbers+8)*32,VRAM,WRITE),4(a6)
		moveq	#1,d0

loc_DEBE:
		lea	byte_E18A(pc),a1

loc_DEC2:
		move.w	#$F,d1
		ext.w	d0
		lsl.w	#5,d0
		lea	(a1,d0.w),a3

loc_DED2:
		move.l	(a3)+,(a6)
		dbf	d1,loc_DED2

HUD_DrawInitial:
locret_DEEA:
		rts
; ---------------------------------------------------------------------------

DrawDebugNumbers:
		tst.w	(Game_paused).w			; MJ: is the game paused?
		bne.s	locret_DEEA			; MJ: if so, branch (don't update debug numbers)

ForceDrawDebug:
		st	Update_HUD_score.w
		st	Update_HUD_ring_count.w
		move.l	#vdpComm((AT_HUD_Numbers)*32,VRAM,WRITE),4(a6)
		move.w	(Camera_X_pos).w,d1
		swap	d1
		move.w	(Player_1+x_pos).w,d1
		bsr.s	sub_DF1C
		move.w	(Camera_Y_pos).w,d1
		swap	d1
		move.w	(Player_1+y_pos).w,d1


; =============== S U B R O U T I N E =======================================


sub_DF1C:
		moveq	#7,d6
		lea	(byte_E5CA).l,a1

loc_DF24:
		rol.w	#4,d1
		move.w	d1,d2
		andi.w	#$F,d2
		cmpi.w	#$A,d2
		blo.s	loc_DF36
		addi.w	#7,d2

loc_DF36:
		lsl.w	#5,d2
		lea	(a1,d2.w),a3
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		swap	d1
		dbf	d6,loc_DF24
		rts
; End of function sub_DF1C

; ---------------------------------------------------------------------------
		lea	(Level_layout_header).w,a1
		move.w	(Player_1+x_pos).w,d3
		move.w	(Player_1+y_pos).w,d2
		move.w	d2,d0
		lsr.w	#5,d0
		and.w	(Layout_row_index_mask).w,d0
		move.w	8(a1,d0.w),d0
		move.w	d3,d1
		lsr.w	#3,d1
		move.w	d1,d4
		lsr.w	#4,d1
		add.w	d1,d0
		moveq	#-1,d1
		clr.w	d1
		movea.w	d0,a1
		move.b	(a1),d1
		rts

; =============== S U B R O U T I N E =======================================


DrawThreeDigitNumber:
		lea	(dword_E04C).l,a2
		moveq	#2,d6
		bra.s	loc_DF92
; End of function DrawThreeDigitNumber


; =============== S U B R O U T I N E =======================================


DrawSixDigitNumber:
		lea	(dword_E040).l,a2
		moveq	#5,d6

loc_DF92:
		moveq	#0,d4
		lea	byte_E18A(pc),a1

loc_DF98:
		moveq	#0,d2
		move.l	(a2)+,d3

loc_DF9C:
		sub.l	d3,d1
		bcs.s	loc_DFA4
		addq.w	#1,d2
		bra.s	loc_DF9C
; ---------------------------------------------------------------------------

loc_DFA4:
		add.l	d3,d1
		tst.w	d2
		beq.s	loc_DFAE
		move.w	#1,d4

loc_DFAE:
		tst.w	d4
		beq.s	loc_DFDC
		lsl.w	#6,d2
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		lea	(a1,d2.w),a3
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)

loc_DFDC:
		addi.l	#$400000,d0
		dbf	d6,loc_DF98
		rts
; End of function DrawSixDigitNumber

; ---------------------------------------------------------------------------
		move.l	#$5F800003,4(a6)
		lea	(VDP_data_port).l,a6
		lea	(dword_E050).l,a2
		moveq	#1,d6
		moveq	#0,d4
		lea	byte_E18A(pc),a1

loc_E006:
		moveq	#0,d2
		move.l	(a2)+,d3

loc_E00A:
		sub.l	d3,d1
		bcs.s	loc_E012
		addq.w	#1,d2
		bra.s	loc_E00A
; ---------------------------------------------------------------------------

loc_E012:
		add.l	d3,d1
		lsl.w	#6,d2
		lea	(a1,d2.w),a3
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		dbf	d6,loc_E006
		rts
; ---------------------------------------------------------------------------
dword_E040:	dc.l 100000
		dc.l 10000
dword_E048:	dc.l 1000
dword_E04C:	dc.l 100
dword_E050:	dc.l 10
dword_E054:	dc.l 1

; =============== S U B R O U T I N E =======================================


DrawSingleDigitNumber:
		lea	(dword_E054).l,a2
		moveq	#0,d6
		bra.s	loc_E06A
; End of function DrawSingleDigitNumber


; =============== S U B R O U T I N E =======================================


DrawTwoDigitNumber:
		lea	(dword_E050).l,a2
		moveq	#1,d6

loc_E06A:
		moveq	#0,d4
		lea	byte_E18A(pc),a1

loc_E070:
		moveq	#0,d2
		move.l	(a2)+,d3

loc_E074:
		sub.l	d3,d1
		bcs.s	loc_E07C
		addq.w	#1,d2
		bra.s	loc_E074
; ---------------------------------------------------------------------------

loc_E07C:
		add.l	d3,d1
		tst.w	d2
		beq.s	loc_E086
		move.w	#1,d4

loc_E086:
		lsl.w	#6,d2
		move.l	d0,VDP_control_port-VDP_data_port(a6)
		lea	(a1,d2.w),a3
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		addi.l	#$400000,d0
		dbf	d6,loc_E070
		rts
; End of function DrawTwoDigitNumber

; ---------------------------------------------------------------------------
		lea	(dword_E048).l,a2
		moveq	#3,d6
		moveq	#0,d4
		lea	byte_E18A(pc),a1

loc_E0CA:
		moveq	#0,d2
		move.l	(a2)+,d3

loc_E0CE:
		sub.l	d3,d1
		bcs.s	loc_E0D6
		addq.w	#1,d2
		bra.s	loc_E0CE
; ---------------------------------------------------------------------------

loc_E0D6:
		add.l	d3,d1
		tst.w	d2
		beq.s	loc_E0E0
		move.w	#1,d4

loc_E0E0:
		tst.w	d4
		beq.s	loc_E110
		lsl.w	#6,d2
		lea	(a1,d2.w),a3
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)

loc_E10A:
		dbf	d6,loc_E0CA
		rts
; ---------------------------------------------------------------------------

loc_E110:
		moveq	#$F,d5

loc_E112:
		move.l	#0,(a6)
		dbf	d5,loc_E112
		bra.s	loc_E10A

; ---------------------------------------------------------------------------
byte_E18A:	binclude "General\Sprites\HUD\HUD_BigNumbers.bin"
byte_E48A:	binclude "General\Sprites\HUD\HUD_SmallNumbers.bin"
byte_E5CA:	binclude "General\Sprites\HUD\HUD_Debug.bin"
