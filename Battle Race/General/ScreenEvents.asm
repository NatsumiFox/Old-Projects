LevelSetup:
		clr.b	(BG_Collision).w
		bclr	#7,(Wallgrab_Disable).w
		clr.l	(Plane_double_update_flag).w
		clr.w	(Special_Events_Routine).w
		clr.l	(Displace_Obj_X).w
		clr.l	(ScrEvents_Routine).w
		clr.l	(ScrEvents_1).w
		clr.w	(ScrShake_Value).w
		clr.l	(ScrShake_Offset).w
		clr.w	(ScrShake_Value_BG).w
		clr.w	(Palette_fade_timer).w
		clr.l	(ScrEvents_Routine2).w
		clr.l	(ScrEvents_4).w
		clr.l	(ScrEvents_6).w
		clr.l	(ScrEvents_8).w
		move.w	#$FFF,(Screen_Y_wrap_value).w
		move.w	#$FF0,(Camera_Y_pos_mask).w
		move.w	#$7C,(Layout_row_index_mask).w
		move.w	(Camera_X_pos).w,(Camera_X_pos_copy).w
		move.w	(Camera_Y_pos).w,(Camera_Y_pos_copy).w
		lea	(Plane_buffer).w,a0
		lea	(Block_table).w,a2
		lea	(Level_layout_main).w,a3
		move.w	#$C000,d7
		move.w	(Current_zone_and_act).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		movea.l	Offs_ScreenInit(pc,d0.w),a1
		jsr	(a1)
		addq.w	#2,a3
		move.w	#$E000,d7
		move.w	(Current_zone_and_act).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		movea.l	Offs_BackgroundInit(pc,d0.w),a1
		jsr	(a1)
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		rts
; ---------------------------------------------------------------------------

ScreenEvents:

		move.w	(Camera_X_pos).w,(Camera_X_pos_copy).w
		move.w	(Camera_Y_pos).w,(Camera_Y_pos_copy).w
		jsr	ShakeScreen_BG.w
		lea	(Plane_buffer).w,a0
		lea	(Block_table).w,a2
		lea	(Level_layout_main).w,a3
		move.w	#$C000,d7
		move.w	(Current_zone_and_act).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		movea.l	Offs_ScreenEvent(pc,d0.w),a1
		jsr	(a1)
		addq.w	#2,a3
		move.w	#$E000,d7
		move.w	(Current_zone_and_act).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		movea.l	Offs_BackgroundEvent(pc,d0.w),a1
		jsr	(a1)
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		rts
; ---------------------------------------------------------------------------
Offs_ScreenInit:dc.l AIZ1_ScreenInit
Offs_BackgroundInit:dc.l AIZ1_BackgroundInit	 ; 0
		dc.l AIZ2_ScreenInit	; 1
		dc.l AIZ2_BackgroundInit	; 2
Offs_ScreenEvent:dc.l AIZ1_ScreenEvent
Offs_BackgroundEvent:dc.l AIZ1_BackgroundEvent  ; 0
		dc.l AIZ2_ScreenEvent	; 1
		dc.l AIZ2_BackgroundEvent	; 2
		dc.l HCZ1_ScreenInit	; 3
		dc.l HCZ1_BackgroundInit	; 4
		dc.l HCZ2_ScreenInit	; 5
		dc.l HCZ2_BackgroundInit	; 6
		dc.l HCZ1_ScreenEvent	; 7
		dc.l HCZ1_BackgroundEvent	; 8
		dc.l HCZ2_ScreenEvent	; 9
		dc.l HCZ2_BackgroundEvent	; 10
		dc.l MGZ1_ScreenInit	; 11
		dc.l MGZ1_BackgroundInit	; 12
		dc.l MGZ2_ScreenInit	; 13
		dc.l MGZ2_BackgroundInit	; 14
		dc.l MGZ1_ScreenEvent	; 15
		dc.l MGZ1_BackgroundEvent	; 16
		dc.l MGZ2_ScreenEvent	; 17
		dc.l MGZ2_BackgroundEvent	; 18
		dc.l CNZ1_ScreenInit	; 19
		dc.l CNZ1_BackgroundInit	; 20
		dc.l CNZ2_ScreenInit	; 21
		dc.l CNZ2_BackgroundInit	; 22
		dc.l CNZ1_ScreenEvent	; 23
		dc.l CNZ1_BackgroundEvent	; 24
		dc.l CNZ2_ScreenEvent	; 25
		dc.l CNZ2_BackgroundEvent	; 26
		dc.l FBZ1_ScreenInit	; 27
		dc.l FBZ1_BackgroundInit	; 28
		dc.l FBZ2_ScreenInit	; 29
		dc.l FBZ2_BackgroundInit	; 30
		dc.l FBZ1_ScreenEvent	; 31
		dc.l FBZ1_BackgroundEvent	; 32
		dc.l FBZ2_ScreenEvent	; 33
		dc.l FBZ2_BackgroundEvent	; 34
		dc.l ICZ1_ScreenInit	; 35
		dc.l ICZ1_BackgroundInit	; 36
		dc.l ICZ2_ScreenInit	; 37
		dc.l ICZ2_BackgroundInit	; 38
		dc.l ICZ1_ScreenEvent	; 39
		dc.l ICZ1_BackgroundEvent	; 40
		dc.l ICZ2_ScreenEvent	; 41
		dc.l ICZ2_BackgroundEvent	; 42
		dc.l LBZ1_ScreenInit	; 43
		dc.l LBZ1_BackgroundInit	; 44
		dc.l LBZ2_ScreenInit	; 45
		dc.l LBZ2_BackgroundInit	; 46
		dc.l LBZ1_ScreenEvent	; 47
		dc.l LBZ1_BackgroundEvent	; 48
		dc.l LBZ2_ScreenEvent	; 49
		dc.l LBZ2_BackgroundEvent	; 50
		dc.l MHZ1_ScreenInit	; 51
		dc.l MHZ1_BackgroundInit	; 52
		dc.l MHZ2_ScreenInit	; 53
		dc.l MHZ2_BackgroundInit	; 54
		dc.l MHZ1_ScreenEvent	; 55
		dc.l MHZ1_BackgroundEvent	; 56
		dc.l MHZ2_ScreenEvent	; 57
		dc.l MHZ2_BackgroundEvent	; 58
		dc.l SOZ1_ScreenInit	; 59
		dc.l SOZ1_BackgroundInit	; 60
		dc.l SOZ2_ScreenInit	; 61
		dc.l SOZ2_BackgroundInit	; 62
		dc.l SOZ1_ScreenEvent	; 63
		dc.l SOZ1_BackgroundEvent	; 64
		dc.l SOZ2_ScreenEvent	; 65
		dc.l SOZ2_BackgroundEvent	; 66
		dc.l LRZ1_ScreenInit	; 67
		dc.l LRZ1_BackgroundInit	; 68
		dc.l LRZ2_ScreenInit	; 69
		dc.l LRZ2_BackgroundInit	; 70
		dc.l LRZ1_ScreenEvent	; 71
		dc.l LRZ1_BackgroundEvent	; 72
		dc.l LRZ2_ScreenEvent	; 73
		dc.l LRZ2_BackgroundEvent	; 74
		dc.l SSZ1_ScreenInit	; 75
		dc.l SSZ1_BackgroundInit	; 76
		dc.l SSZ2_ScreenInit	; 77
		dc.l SSZ2_BackgroundInit	; 78
		dc.l SSZ1_ScreenEvent	; 79
		dc.l SSZ1_BackgroundEvent	; 80
		dc.l SSZ2_ScreenEvent	; 81
		dc.l SSZ2_BackgroundEvent	; 82
		dc.l DEZ1_ScreenInit	; 83
		dc.l DEZ1_BackgroundInit	; 84
		dc.l DEZ2_ScreenInit	; 85
		dc.l DEZ2_BackgroundInit	; 86
		dc.l DEZ1_ScreenEvent	; 87
		dc.l DEZ1_BackgroundEvent	; 88
		dc.l DEZ2_ScreenEvent	; 89
		dc.l DEZ2_BackgroundEvent	; 90

		dc.l DDZ_ScreenInit	; 91
		dc.l DDZ_BackgroundInit	; 92
		dc.l DDZ_ScreenInit	; 93
		dc.l DDZ_BackgroundInit	; 94
		dc.l DDZ_ScreenEvent	; 95
		dc.l DDZ_BackgroundEvent	; 96
		dc.l DDZ_ScreenEvent	; 97
		dc.l DDZ_BackgroundEvent	; 98
		dc.l Ending_ScreenInit	; 99
		dc.l Ending_BackgroundInit	; 100
		dc.l Ending_ScreenInit	; 101
		dc.l Ending_BackgroundInit	; 102
		dc.l Ending_ScreenEvent	; 103
		dc.l Ending_BackgroundEvent; 104
		dc.l Ending_ScreenEvent	; 105
		dc.l Ending_BackgroundEvent; 106

	if oazflag=1
		dc.l	OAZ1_ScreenInit				; See "OAZ/Includes.asm"
		dc.l	OAZ1_BackgroundInit
		dc.l	OAZ2_ScreenInit
		dc.l	OAZ2_BackgroundInit
		dc.l	OAZ1_ScreenEvent
		dc.l	OAZ1_BackgroundEvent
		dc.l	OAZ2_ScreenEvent
		dc.l	OAZ2_BackgroundEvent
	else
		dc.l [8] 0	; dummy entries be important!
	endif

		dc.l Comp_ScreenInit	; 115
		dc.l BPZ_BackgroundInit	; 116
		dc.l Comp_ScreenInit	; 117
		dc.l BPZ_BackgroundInit	; 118
		dc.l Comp_ScreenEvent	; 119
		dc.l BPZ_BackgroundEvent	; 120
		dc.l Comp_ScreenEvent	; 121
		dc.l BPZ_BackgroundEvent	; 122
		dc.l Comp_ScreenInit	; 123
		dc.l DPZ_BackgroundInit	; 124
		dc.l Comp_ScreenInit	; 125
		dc.l DPZ_BackgroundInit	; 126
		dc.l Comp_ScreenEvent	; 127
		dc.l DPZ_BackgroundEvent	; 128
		dc.l Comp_ScreenEvent	; 129
		dc.l DPZ_BackgroundEvent	; 130
		dc.l Comp_ScreenInit	; 131
		dc.l CGZ_BackgroundInit	; 132
		dc.l Comp_ScreenInit	; 133
		dc.l CGZ_BackgroundInit	; 134
		dc.l CGZ_ScreenEvent	; 135
		dc.l CGZ_BackgroundEvent	; 136
		dc.l CGZ_ScreenEvent	; 137
		dc.l CGZ_BackgroundEvent	; 138
		dc.l Comp_ScreenInit	; 139
		dc.l EMZ_BackgroundInit	; 140
		dc.l Comp_ScreenInit	; 141
		dc.l EMZ_BackgroundInit	; 142
		dc.l Comp_ScreenEvent	; 143
		dc.l EMZ_BackgroundEvent	; 144
		dc.l Comp_ScreenEvent	; 145
		dc.l EMZ_BackgroundEvent	; 146
		dc.l Gumball_ScreenInit	; 147
		dc.l Gumball_BackgroundInit; 148
		dc.l Gumball_ScreenInit	; 149
		dc.l Gumball_BackgroundInit; 150
		dc.l Gumball_ScreenEvent; 151
		dc.l Gumball_BackgroundEvent; 152
		dc.l Gumball_ScreenEvent; 153
		dc.l Gumball_BackgroundEvent; 154
		dc.l Pachinko_ScreenInit; 155
		dc.l Pachinko_BackgroundInit; 156
		dc.l Pachinko_ScreenInit; 157
		dc.l Pachinko_BackgroundInit; 158
		dc.l Pachinko_ScreenEvent; 159
		dc.l Pachinko_BackgroundEvent; 160
		dc.l Pachinko_ScreenEvent; 161
		dc.l Pachinko_BackgroundEvent; 162
		dc.l Slots_ScreenInit	; 163
		dc.l Slots_BackgroundInit	; 164
		dc.l Slots_ScreenInit	; 165
		dc.l Slots_BackgroundInit	; 166
		dc.l Slots_ScreenEvent	; 167
		dc.l Slots_BackgroundEvent	; 168
		dc.l Slots_ScreenEvent	; 169
		dc.l Slots_BackgroundEvent	; 170
		dc.l LRZ3_ScreenInit	; 171
		dc.l LRZ3_BackgroundInit	; 172
		dc.l HPZ_ScreenInit	; 173
		dc.l HPZ_BackgroundInit	; 174
		dc.l LRZ3_ScreenEvent	; 175
		dc.l LRZ3_BackgroundEvent	; 176
		dc.l HPZ_ScreenEvent	; 177
		dc.l HPZ_BackgroundEvent	; 178
		dc.l DEZ3_ScreenInit	; 179
		dc.l DEZ3_BackgroundInit	; 180
		dc.l HPZS_ScreenInit	; 181
		dc.l HPZS_BackgroundInit	; 182
		dc.l DEZ3_ScreenEvent	; 183
		dc.l DEZ3_BackgroundEvent	; 184
		dc.l HPZS_ScreenEvent	; 185
		dc.l HPZS_BackgroundEvent	; 186

; =============== S U B R O U T I N E =======================================


VInt_DrawLevel:
		lea	(VDP_data_port).l,a6
		lea	(Plane_buffer).w,a0

; =============== S U B R O U T I N E =======================================


VInt_DrawLevel_2:
		move.w	(a0),d0
		beq.s	VInt_DrawLevel_Done
		clr.w	(a0)+
		move.w	(a0)+,d1
		bmi.s	VInt_DrawLevel_Col
		move.w	#$8F02,d2		; VRAM increment at 2 bytes (horizontal level write)
		move.w	#$80,d3
		bra.s	VInt_DrawLevel_Draw
; ---------------------------------------------------------------------------

VInt_DrawLevel_Col:
		move.w	#$8F80,d2		; VRAM increment at $80 bytes (vertical level write)
		moveq	#2,d3
		andi.w	#$7FFF,d1

VInt_DrawLevel_Draw:
		move.w	d2,VDP_control_port-VDP_data_port(a6)
		move.w	d0,d2
		move.w	d1,d4
		bsr.s	VInt_VRAMWrite
		move.w	d2,d0
		add.w	d3,d0
		move.w	d4,d1
		bsr.s	VInt_VRAMWrite
		bra.s	VInt_DrawLevel_2
; ---------------------------------------------------------------------------

VInt_DrawLevel_Done:
		move.w	#$8F02,VDP_control_port-VDP_data_port(a6)

VInt_DrawLevel_Return:
		rts
; End of function VInt_DrawLevel_2


; =============== S U B R O U T I N E =======================================


VInt_VRAMWrite:
		swap	d0
		clr.w	d0
		swap	d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0
		move.l	d0,4(a6)
		neg.w	d1
		add.w	d1,d1
		jmp	VVW_Write(pc,d1.w)

		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)
VVW_Write:	move.l	(a0)+,(a6)
		rts
; End of function VInt_VRAMWrite


; =============== S U B R O U T I N E =======================================


SpecialVInt_VRAMRead:
		swap	d0
		clr.w	d0
		swap	d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		swap	d0
		move.l	d0,4(a6)

loc_4E7D2:
		move.l	(a6),(a0)+
		dbf	d1,loc_4E7D2
		rts
; End of function SpecialVInt_VRAMRead


; =============== S U B R O U T I N E =======================================


sub_4E7DA:
		lea	(VDP_data_port).l,a6
		lea	(Plane_buffer).w,a0

loc_4E7E4:
		move.w	(a0),d0
		beq.s	locret_4E7FE
		clr.w	(a0)+
		move.w	(a0)+,d1
		move.w	d0,d2
		move.w	d1,d4
		bsr.w	VInt_VRAMWrite
		move.w	d2,d0
		add.w	(__u_EEB0).w,d0
		move.w	d4,d1
		bsr.w	VInt_VRAMWrite
		bra.s	loc_4E7E4
; ---------------------------------------------------------------------------

locret_4E7FE:
		rts
; End of function sub_4E7DA


; =============== S U B R O U T I N E =======================================


SpecialVInt_Function:
		lea	(VDP_data_port).l,a6
		move.w	(Special_V_int_routine).w,d0
		jmp	SpecialVInt_Array(pc,d0.w)
; End of function SpecialVInt_Function

; ---------------------------------------------------------------------------

SpecialVInt_Array:
		rts
		rts
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_VScrollOn		; $04
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_VScrollCopy		; $08
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_VScrollOff		; $0C
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_LBZ2WindowCopy	; $10
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_LBZ2ScrollAClear	; $14
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_LBZ2ScrollAClear2	; $18
; ---------------------------------------------------------------------------
		bra.w	SpecialVInt_LBZ2WindowClear	; $1C
; ---------------------------------------------------------------------------

SpecialVInt_VScrollOn:
		move.w	#$8B07,VDP_control_port-VDP_data_port(a6)		; Command $8B07 - VScroll cell-based, HScroll line-based
		addq.w	#4,(Special_V_int_routine).w

SpecialVInt_VScrollCopy:
		lea	(VScrollBuffer).w,a0
		move.l	#$40000010,VDP_control_port-VDP_data_port(a6)
		moveq	#$13,d0

loc_4E846:
		move.l	(a0)+,(a6)
		dbf	d0,loc_4E846
		rts
; ---------------------------------------------------------------------------

SpecialVInt_VScrollOff:
		move.w	#$8B03,VDP_control_port-VDP_data_port(a6)		; Command $8B03 - VScroll full, HScroll line-based
		clr.w	(Special_V_int_routine).w
		rts
; ---------------------------------------------------------------------------

SpecialVInt_LBZ2WindowCopy:
		lea	(VRAM_buffer).w,a0		; Used specifically by the Death Egg platform at the end of LBZ2
		move.w	(DrawDelayed_RowCount).w,d0
		addi.w	#$D,d0
		andi.w	#$1F,d0
		lsl.w	#7,d0
		addi.w	#$C000,d0
		move.w	d0,d2
		addi.w	#$64,d0
		moveq	#6,d1
		jsr	SpecialVInt_VRAMRead(pc)	; Grabs the nametable area of the Death Egg platform
		move.w	d2,d0
		moveq	#$18,d1
		jsr	SpecialVInt_VRAMRead(pc)
		lea	(VRAM_buffer).w,a0
		move.w	(DrawDelayed_RowCount).w,d0
		lsl.w	#7,d0
		addi.w	#$8000,d0
		moveq	#$1F,d1
		jsr	VInt_VRAMWrite(pc)			; Copies the pertinent data from scroll A to the window nametable
		subq.w	#1,(DrawDelayed_RowCount).w		; Do this (EECA) number of times
		bpl.s	locret_4E8A2
		addq.w	#4,(Special_V_int_routine).w

locret_4E8A2:
		rts
; ---------------------------------------------------------------------------

SpecialVInt_LBZ2ScrollAClear:
		move.l	#$49000003,(VDP_control_port).l	; VRAM base $C900
		moveq	#0,d0
		moveq	#$5F,d1

loc_4E8B2:
		move.l	d0,(a6)				; Clear 6 cell lines from VRAM A for when it scrolls upward
		move.l	d0,(a6)
		dbf	d1,loc_4E8B2
		move.w	#$8320,VDP_control_port-VDP_data_port(a6)		; VRAM command $8320 - Window at base address $8000
		move.w	#$9285,VDP_control_port-VDP_data_port(a6)		; VRAM command $9285 - Window starts 5 cells down from top
		clr.w	(Special_V_int_routine).w
		rts
; ---------------------------------------------------------------------------

SpecialVInt_LBZ2ScrollAClear2:
		move.l	#$46000003,(VDP_control_port).l	; VRAM base $C600
		moveq	#0,d0
		moveq	#$5F,d1

loc_4E8DA:
		move.l	d0,(a6)					; Erase remainder of upper area of VRAM A
		move.l	d0,(a6)
		dbf	d1,loc_4E8DA
		addq.w	#4,(Special_V_int_routine).w
		rts
; ---------------------------------------------------------------------------

SpecialVInt_LBZ2WindowClear:
		lea	(VRAM_buffer).w,a0
		move.w	#$829C,d0
		moveq	#$18,d1
		jsr	SpecialVInt_VRAMRead(pc)
		move.w	#$8280,d0
		moveq	#6,d1
		jsr	SpecialVInt_VRAMRead(pc)	; Copy from window data. Luckily, all 6 cell lines are identical so it only needs to be done once

loc_4E900:
		move.l	#$49000003,(VDP_control_port).l	; VRAM position $C900
		moveq	#5,d0

loc_4E90C:
		lea	(VRAM_buffer).w,a0
		moveq	#$F,d1

loc_4E912:
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a6)				; Write cell lines back to Scroll A
		dbf	d1,loc_4E912
		dbf	d0,loc_4E90C
		move.w	#$9200,VDP_control_port-VDP_data_port(a6)			; VRAM command $9200 - Zero out window position
		clr.w	(Special_V_int_routine).w
		rts

; =============== S U B R O U T I N E =======================================


Draw_TileColumn:

		move.w	(a6),d0
		andi.w	#-$10,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_4EAB6
		tst.b	d2
		bpl.s	loc_4E948
		neg.w	d2
		move.w	d3,d0
		addi.w	#$150,d0

loc_4E948:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne	(Plane_double_update_flag).w
		movem.w	d1/d6,-(sp)
		bsr.s	Setup_TileColumnDraw
		movem.w	(sp)+,d1/d6
		tst.b	(Plane_double_update_flag).w
		beq.w	locret_4EAB6
		addi.w	#$10,d0
		bra.s	Setup_TileColumnDraw
; End of function Draw_TileColumn


; =============== S U B R O U T I N E =======================================


Draw_TileColumn2:

		move.w	(a6),d0
		andi.w	#-$10,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_4EAB6
		tst.b	d2
		bpl.s	loc_4E98C
		neg.w	d2
		move.w	d3,d0
		addi.w	#$150,d0
		swap	d1

loc_4E98C:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne	(Plane_double_update_flag).w
		movem.w	d1/d6,-(sp)
		bsr.s	Setup_TileColumnDraw
		movem.w	(sp)+,d1/d6
		tst.b	(Plane_double_update_flag).w
		beq.w	locret_4EAB6
		addi.w	#$10,d0
; End of function Draw_TileColumn2


; =============== S U B R O U T I N E =======================================


Setup_TileColumnDraw:

		move.w	d1,d2
		andi.w	#$70,d2
		move.w	d1,d3
		lsl.w	#4,d3
		andi.w	#$F00,d3
		asr.w	#4,d1
		move.w	d1,d4
		asr.w	#1,d1
		and.w	(Layout_row_index_mask).w,d1
		andi.w	#$F,d4
		moveq	#$10,d5
		sub.w	d4,d5
		move.w	d5,d4
		sub.w	d6,d5
		bmi.s	loc_4E9FC
		move.w	d0,d5
		asr.w	#2,d5
		andi.w	#$7C,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		bset	#7,-2(a0)
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
		jsr	Get_LevelChunkColumn(pc)
		bra.s	sub_4EA4A
; ---------------------------------------------------------------------------

loc_4E9FC:
		neg.w	d5
		move.w	d5,-(sp)
		move.w	d0,d5

loc_4EA02:
		asr.w	#2,d5
		andi.w	#$7C,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d4,d6
		subq.w	#1,d6
		move.w	d6,(a0)+
		bset	#7,-2(a0)
		lea	(a0),a1
		add.w	d4,d4
		add.w	d4,d4
		adda.w	d4,a0
		jsr	Get_LevelChunkColumn(pc)
		bsr.s	sub_4EA4A
		move.w	(sp)+,d6
		move.w	d0,d5
		asr.w	#2,d5
		andi.w	#$7C,d5
		add.w	d7,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		bset	#7,-2(a0)
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0

sub_4EA4A:

		swap	d7

loc_4EA4C:
		move.w	(a5,d2.w),d3
		move.w	d3,d4
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		move.w	(a2,d3.w),d5
		swap	d5
		move.w	4(a2,d3.w),d5
		move.w	6(a2,d3.w),d7
		move.w	2(a2,d3.w),d3
		swap	d3
		move.w	d7,d3
		btst	#$B,d4
		beq.s	loc_4EA84
		eori.l	#$10001000,d5
		eori.l	#$10001000,d3
		swap	d5
		swap	d3

loc_4EA84:
		btst	#$A,d4
		beq.s	loc_4EA98
		eori.l	#$8000800,d5
		eori.l	#$8000800,d3
		exg	d3,d5

loc_4EA98:
		move.l	d5,(a1)+
		move.l	d3,(a0)+
		addi.w	#$10,d2
		andi.w	#$70,d2
		bne.s	loc_4EAAE
		addq.w	#4,d1
		and.w	(Layout_row_index_mask).w,d1
		bsr.s	Get_LevelChunkColumn

loc_4EAAE:
		dbf	d6,loc_4EA4C
		swap	d7
		clr.w	(a0)

locret_4EAB6:

		rts
; End of function Setup_TileColumnDraw


; =============== S U B R O U T I N E =======================================


Get_LevelChunkColumn:

		movea.w	(a3,d1.w),a4
		move.w	d0,d3
		asr.w	#7,d3
		adda.w	d3,a4
		moveq	#-1,d3
		clr.w	d3
		move.b	(a4),d3
		lsl.w	#7,d3
		move.w	d0,d4
		asr.w	#3,d4
		andi.w	#$E,d4
		add.w	d4,d3
		movea.l	d3,a5
		rts
; End of function Get_LevelChunkColumn


; =============== S U B R O U T I N E =======================================


Draw_TileRow:

		move.w	(a6),d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_4EC46
		tst.b	d2
		bpl.s	loc_4EAFA
		neg.w	d2
		move.w	d3,d0
		addi.w	#$F0,d0
		and.w	(Camera_Y_pos_mask).w,d0

loc_4EAFA:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne.b	(Plane_double_update_flag).w
		movem.w	d1/d6,-(sp)
		bsr.s	Setup_TileRowDraw

		movem.w	(sp)+,d1/d6
		tst.b	(Plane_double_update_flag).w
		beq.w	locret_4EC46
		addi.w	#$10,d0
		and.w	(Camera_Y_pos_mask).w,d0
		bra.s	Setup_TileRowDraw
; End of function Draw_TileRow


; =============== S U B R O U T I N E =======================================


Draw_TileRow2:

		move.w	(a6),d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	(a5),d2
		move.w	d0,(a5)
		move.w	d2,d3
		sub.w	d0,d2
		beq.w	locret_4EC46
		tst.b	d2
		bpl.s	loc_4EB46
		neg.w	d2
		move.w	d3,d0
		addi.w	#$F0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		swap	d1

loc_4EB46:
		andi.w	#$30,d2
		cmpi.w	#$10,d2
		sne	(Plane_double_update_flag).w
		movem.w	d1/d6,-(sp)
		bsr.s	Setup_TileRowDraw
		movem.w	(sp)+,d1/d6
		tst.b	(Plane_double_update_flag).w
		beq.w	locret_4EC46
		addi.w	#$10,d0
		and.w	(Camera_Y_pos_mask).w,d0
; End of function Draw_TileRow2


; =============== S U B R O U T I N E =======================================


Setup_TileRowDraw:

		asr.w	#4,d1
		move.w	d1,d2
		move.w	d1,d4
		asr.w	#3,d1
		add.w	d2,d2
		move.w	d2,d3
		andi.w	#$E,d2
		add.w	d3,d3
		andi.w	#$7C,d3
		andi.w	#$1F,d4
		moveq	#$20,d5
		sub.w	d4,d5
		move.w	d5,d4
		sub.w	d6,d5
		bmi.s	loc_4EBB2
		move.w	d0,d5
		andi.w	#$F0,d5		; If the length of the write can fit without wrapping the nametable
		lsl.w	#4,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
		jsr	Get_LevelAddrChunkRow(pc)
		bra.s	loc_4EBF2
; ---------------------------------------------------------------------------

loc_4EBB2:
		neg.w	d5			; If the length of the write wraps over the length of the nametable
		move.w	d5,-(sp)
		move.w	d0,d5
		andi.w	#$F0,d5
		lsl.w	#4,d5
		add.w	d7,d5
		add.w	d3,d5
		move.w	d5,(a0)+
		move.w	d4,d6
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d4,d4
		add.w	d4,d4
		adda.w	d4,a0
		bsr.s	Get_LevelAddrChunkRow
		bsr.s	loc_4EBF2
		move.w	(sp)+,d6	; Must place one more write command to account for rollover
		move.w	d0,d5
		andi.w	#$F0,d5
		lsl.w	#4,d5
		add.w	d7,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0

loc_4EBF2:

		move.w	(a5,d2.w),d3
		move.w	d3,d4
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		move.l	(a2,d3.w),d5
		move.l	4(a2,d3.w),d3
		btst	#$B,d4
		beq.s	loc_4EC1A
		eori.l	#$10001000,d5
		eori.l	#$10001000,d3
		exg	d3,d5

loc_4EC1A:
		btst	#$A,d4
		beq.s	loc_4EC30
		eori.l	#$8000800,d5
		eori.l	#$8000800,d3
		swap	d5
		swap	d3

loc_4EC30:
		move.l	d5,(a1)+
		move.l	d3,(a0)+
		addq.w	#2,d2
		andi.w	#$E,d2
		bne.s	loc_4EC40
		addq.w	#1,d1
		bsr.s	Get_ChunkRow

loc_4EC40:
		dbf	d6,loc_4EBF2
		clr.w	(a0)

locret_4EC46:

		rts
; End of function Setup_TileRowDraw

; =============== S U B R O U T I N E =======================================


Get_LevelAddrChunkRow:
GetLevelAddrChunk:
		move.w	d0,d3
		asr.w	#5,d3
		and.w	(Layout_row_index_mask).w,d3
		movea.w	(a3,d3.w),a4

Get_ChunkRow:
GetChunk:
		moveq	#-1,d3
		clr.w	d3
		move.b	(a4,d1.w),d3
		lsl.w	#7,d3
		move.w	d0,d4
		andi.w	#$70,d4
		add.w	d4,d3
		movea.l	d3,a5
		rts
; End of function Get_LevelAddrChunkRow


; =============== S U B R O U T I N E =======================================


sub_4EC6A:
		asr.w	#3,d1
		move.w	d1,d2
		asr.w	#4,d1
		andi.w	#$E,d2
		cmpi.w	#$100,(__u_EEB0).w
		beq.s	loc_4EC84
		moveq	#4,d3
		move.w	#$1F80,d4
		bra.s	loc_4EC8A
; ---------------------------------------------------------------------------

loc_4EC84:
		moveq	#5,d3
		move.w	#$1F00,d4

loc_4EC8A:
		move.w	d0,d5
		lsl.w	d3,d5
		and.w	d4,d5
		add.w	d7,d5
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
		jsr	Get_LevelAddrChunkRow(pc)
		bra.w	loc_4EBF2
; End of function sub_4EC6A


; =============== S U B R O U T I N E =======================================


sub_4ECAA:

		asr.w	#4,d1
		move.w	d1,d2
		asr.w	#3,d1
		add.w	d2,d2
		andi.w	#$E,d2
		move.w	d5,(a0)+
		move.w	d6,d5
		subq.w	#1,d6
		move.w	d6,(a0)+
		lea	(a0),a1
		add.w	d5,d5
		add.w	d5,d5
		adda.w	d5,a0
		jsr	Get_LevelAddrChunkRow(pc)
		bra.w	loc_4EBF2
; End of function sub_4ECAA


; =============== S U B R O U T I N E =======================================


Refresh_PlaneFull:

		moveq	#$F,d2

loc_4ECD0:
		movem.l	d0-d2/a0,-(sp)
		moveq	#$20,d6
		jsr	Setup_TileRowDraw(pc)
		jsr	VInt_DrawLevel(pc)
		movem.l	(sp)+,d0-d2/a0
		addi.w	#$10,d0
		dbf	d2,loc_4ECD0
		rts
; End of function Refresh_PlaneFull


; =============== S U B R O U T I N E =======================================


Refresh_PlaneTileDeform:

		move.w	(a4)+,d2
		moveq	#$F,d3

loc_4ECF0:

		cmp.w	d2,d0
		bmi.s	loc_4ECFA
		add.w	(a4)+,d2
		addq.w	#4,a5
		bra.s	loc_4ECF0
; ---------------------------------------------------------------------------

loc_4ECFA:
		move.w	(a5),d1
		moveq	#$20,d6
		movem.l	d0/d2-d3/a0/a4-a5,-(sp)
		jsr	Setup_TileRowDraw(pc)
		jsr	VInt_DrawLevel(pc)
		movem.l	(sp)+,d0/d2-d3/a0/a4-a5
		addi.w	#$10,d0
		dbf	d3,loc_4ECF0
		rts
; End of function Refresh_PlaneTileDeform

; ---------------------------------------------------------------------------
; Dead code
		move.w	(a4)+,d2
		moveq	#$1F,d3

; Dead code
loc_4ED1C:
		cmp.w	d2,d0
		bmi.s	loc_4ED26
		add.w	(a4)+,d2
		addq.w	#4,a5
		bra.s	loc_4ED1C
; ---------------------------------------------------------------------------
; Dead code
loc_4ED26:
		move.w	(a5),d1
		moveq	#$10,d6
		movem.l	d0/d2-d3/a0/a4-a5,-(sp)
		jsr	Setup_TileColumnDraw(pc)
		jsr	VInt_DrawLevel(pc)
		movem.l	(sp)+,d0/d2-d3/a0/a4-a5
		addi.w	#$10,d0
		dbf	d3,loc_4ED1C
		rts
; ---------------------------------------------------------------------------
; Dead code
loc_4ED44:
		movem.l	d0-d2/d6/a0,-(sp)
		jsr	sub_4EC6A(pc)
		jsr	sub_4E7DA(pc)
		movem.l	(sp)+,d0-d2/d6/a0
		addi.w	#$10,d0
		dbf	d2,loc_4ED44
		rts
; ---------------------------------------------------------------------------

Refresh_PlaneFullDirect:
		moveq	#$20,d6
		bra.s	Refresh_PlaneDirect2
; ---------------------------------------------------------------------------

Refresh_PlaneScreenDirect:

		moveq	#$15,d6		; NAT: Draw extra column

Refresh_PlaneDirect2:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Camera_X_pos_copy).w,d1

; =============== S U B R O U T I N E =======================================


Refresh_PlaneDirect:

		move	#$2700,sr
		moveq	#$E,d2		; NAT: Draw extra row

loc_4ED72:
		movem.l	d0-d2/d6/a0,-(sp)		; Redraws the entire plane in one go during 68k execution
		jsr	Setup_TileRowDraw(pc)
		jsr	VInt_DrawLevel(pc)
		movem.l	(sp)+,d0-d2/d6/a0
		addi.w	#$10,d0
		dbf	d2,loc_4ED72
		move	#$2300,sr
		rts
; End of function Refresh_PlaneDirect


; =============== S U B R O U T I N E =======================================


DrawTilesAsYouMove:
		lea	(Camera_X_pos_copy).w,a6
		lea	(Camera_X_pos_rounded).w,a5
		move.w	(Camera_Y_pos_copy).w,d1
		moveq	#$F,d6
		jsr	Draw_TileColumn(pc)
		lea	(Camera_Y_pos_copy).w,a6
		lea	(Camera_Y_pos_rounded).w,a5
		move.w	(Camera_X_pos_copy).w,d1
		moveq	#$15,d6
		jmp	Draw_TileRow(pc)
; End of function DrawTilesAsYouMove


; =============== S U B R O U T I N E =======================================


DrawBGAsYouMove:

		lea	(Camera_X_pos_BG_copy).w,a6
		lea	(Camera_X_pos_BG_rounded).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		moveq	#$F,d6
		jsr	Draw_TileColumn(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	(Camera_X_pos_BG_copy).w,d1
		moveq	#$15,d6
		jmp	Draw_TileRow(pc)
; End of function DrawBGAsYouMove

; ---------------------------------------------------------------------------

loc_4EDD8:
		movem.l	d5/a4-a5,-(sp)
		lea	(Camera_Y_pos_copy).w,a6
		jsr	Get_DeformDrawPosVert(pc)
		lea	(Camera_Y_pos_rounded).w,a5
		jsr	Draw_TileRow2(pc)
		movem.l	(sp)+,d5/a4/a6
		move.w	(Camera_Y_pos_rounded).w,d6
		bra.s	Draw_BGNoVert

; =============== S U B R O U T I N E =======================================


Draw_BG:
		movem.l	d5/a4-a5,-(sp)
		lea	(Camera_Y_pos_BG_copy).w,a6
		jsr	Get_DeformDrawPosVert(pc)
		lea	(Camera_Y_pos_BG_rounded).w,a5
		jsr	Draw_TileRow2(pc)
		movem.l	(sp)+,d5/a4/a6
		move.w	(Camera_Y_pos_BG_rounded).w,d6
		tst.w	(Camera_Y_pos_BG_copy).w
		bpl.s	Draw_BGNoVert
		move.w	(Camera_Y_pos_BG_copy).w,d6
		andi.w	#-$10,d6

Draw_BGNoVert:

		move.w	d6,d1

loc_4EE22:
		sub.w	(a4)+,d6
		bmi.s	loc_4EE32
		move.w	(a6)+,d0
		andi.w	#-$10,d0
		move.w	d0,(a6)+
		subq.w	#1,d5
		bra.s	loc_4EE22
; ---------------------------------------------------------------------------

loc_4EE32:
		neg.w	d6
		lsr.w	#4,d6
		moveq	#$F,d4
		sub.w	d6,d4
		bcc.s	loc_4EE40
		moveq	#0,d4
		moveq	#$F,d6

loc_4EE40:

		movem.w	d1/d4-d6,-(sp)
		movem.l	a4/a6,-(sp)
		lea	2(a6),a5
		jsr	Draw_TileColumn(pc)
		movem.l	(sp)+,a4/a6
		movem.w	(sp)+,d1/d4-d6
		addq.w	#4,a6
		tst.w	d4
		beq.s	loc_4EE74
		lsl.w	#4,d6
		add.w	d6,d1
		subq.w	#1,d5
		move.w	(a4)+,d6
		lsr.w	#4,d6
		move.w	d4,d0
		sub.w	d6,d4
		bpl.s	loc_4EE40
		move.w	d0,d6
		moveq	#0,d4
		bra.s	loc_4EE40
; ---------------------------------------------------------------------------

loc_4EE74:

		subq.w	#1,d5
		beq.s	locret_4EE82
		move.w	(a6)+,d0
		andi.w	#-$10,d0
		move.w	d0,(a6)+
		bra.s	loc_4EE74
; ---------------------------------------------------------------------------

locret_4EE82:
		rts
; End of function Draw_BG


; =============== S U B R O U T I N E =======================================


Get_DeformDrawPosVert:

		move.w	(a4)+,d2
		move.w	(a6),d0
		bsr.s	sub_4EE8E
		addi.w	#$E0,d0
; End of function Get_DeformDrawPosVert


; =============== S U B R O U T I N E =======================================


sub_4EE8E:
		cmp.w	d2,d0
		bmi.s	loc_4EE98
		add.w	(a4)+,d2
		addq.w	#4,a5
		bra.s	sub_4EE8E
; ---------------------------------------------------------------------------

loc_4EE98:
		move.w	(a5),d1
		swap	d1
		rts
; End of function sub_4EE8E

; ---------------------------------------------------------------------------

DrawTilesVDeform:

		movem.l	d5/a4-a5,-(sp)
		lea	(Camera_X_pos_copy).w,a6
		jsr	Get_XDeformRange(pc)
		lea	(Camera_X_pos_rounded).w,a5
		jsr	Draw_TileColumn2(pc)
		movem.l	(sp)+,d5/a4/a6
		move.w	(Camera_X_pos_rounded).w,d6
		bra.s	loc_4EED8

; =============== S U B R O U T I N E =======================================


DrawTilesVDeform2:
		movem.l	d5/a4-a5,-(sp)
		lea	(Camera_X_pos_BG_copy).w,a6
		jsr	Get_XDeformRange(pc)
		lea	(Camera_X_pos_BG_rounded).w,a5
		jsr	Draw_TileColumn2(pc)
		movem.l	(sp)+,d5/a4/a6
		move.w	(Camera_X_pos_BG_rounded).w,d6

loc_4EED8:
		move.w	d6,d1

loc_4EEDA:
		sub.w	(a4)+,d6
		bcs.s	loc_4EEEA
		move.w	(a6)+,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(a6)+
		subq.w	#1,d5
		bra.s	loc_4EEDA
; ---------------------------------------------------------------------------

loc_4EEEA:
		neg.w	d6
		lsr.w	#4,d6
		moveq	#$15,d4
		sub.w	d6,d4
		bcc.s	loc_4EEF8
		moveq	#0,d4
		moveq	#$15,d6

loc_4EEF8:

		movem.w	d1/d4-d6,-(sp)
		movem.l	a4/a6,-(sp)
		lea	2(a6),a5
		jsr	Draw_TileRow(pc)
		movem.l	(sp)+,a4/a6
		movem.w	(sp)+,d1/d4-d6
		addq.w	#4,a6
		tst.w	d4
		beq.s	loc_4EF2C
		lsl.w	#4,d6
		add.w	d6,d1
		subq.w	#1,d5
		move.w	(a4)+,d6
		lsr.w	#4,d6
		move.w	d4,d0
		sub.w	d6,d4
		bcc.s	loc_4EEF8
		move.w	d0,d6
		moveq	#0,d4
		bra.s	loc_4EEF8
; ---------------------------------------------------------------------------

loc_4EF2C:

		subq.w	#1,d5
		beq.s	locret_4EF3A
		move.w	(a6)+,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(a6)+
		bra.s	loc_4EF2C
; ---------------------------------------------------------------------------

locret_4EF3A:
		rts
; End of function DrawTilesVDeform2


; =============== S U B R O U T I N E =======================================


Get_XDeformRange:

		move.w	(a4)+,d2
		move.w	(a6),d0
		bsr.s	sub_4EF46
		addi.w	#$140,d0
; End of function Get_XDeformRange


; =============== S U B R O U T I N E =======================================


sub_4EF46:
		cmp.w	d2,d0
		blo.s	loc_4EF50
		add.w	(a4)+,d2
		addq.w	#4,a5
		bra.s	sub_4EF46
; ---------------------------------------------------------------------------

loc_4EF50:
		move.w	(a5),d1
		swap	d1
		rts
; End of function sub_4EF46


; =============== S U B R O U T I N E =======================================


Draw_PlaneVertBottomUp:

		movem.w	d1-d2,-(sp)
		bsr.s	Draw_PlaneVertSingleBottomUp
		movem.w	(sp)+,d1-d2
		bpl.s	Draw_PlaneVertSingleBottomUp
		rts
; End of function Draw_PlaneVertBottomUp


; =============== S U B R O U T I N E =======================================


Draw_PlaneVertSingleBottomUp:
		and.w	(Camera_Y_pos_mask).w,d2
		move.w	d2,d3
		addi.w	#$F0,d3
		and.w	(Camera_Y_pos_mask).w,d3
		move.w	(DrawDelayed_Position).w,d0
		cmp.w	d2,d0
		blo.s	loc_4EF84
		cmp.w	d3,d0
		bhi.s	loc_4EF84
		moveq	#$20,d6
		jsr	Setup_TileRowDraw(pc)

loc_4EF84:

		subi.w	#$10,(DrawDelayed_Position).w
		subq.w	#1,(DrawDelayed_RowCount).w
		rts
; End of function Draw_PlaneVertSingleBottomUp


; =============== S U B R O U T I N E =======================================


Draw_PlaneVertTopDown:
		and.w	(Camera_Y_pos_mask).w,d2
		move.w	d2,d3
		addi.w	#$F0,d3
		and.w	(Camera_Y_pos_mask).w,d3
		move.w	(DrawDelayed_Position).w,d0
		cmp.w	d2,d0
		blo.s	loc_4EFB0
		cmp.w	d3,d0
		bhi.s	loc_4EFB0
		moveq	#$20,d6
		jsr	Setup_TileRowDraw(pc)

loc_4EFB0:

		addi.w	#$10,(DrawDelayed_Position).w
		subq.w	#1,(DrawDelayed_RowCount).w
		rts
; End of function Draw_PlaneVertTopDown


; =============== S U B R O U T I N E =======================================


Draw_PlaneHorzRightToLeft:
		movem.w	d1-d2,-(sp)
		bsr.s	sub_4EFCA
		movem.w	(sp)+,d1-d2
		bpl.s	sub_4EFCA
		rts
; End of function Draw_PlaneHorzRightToLeft


; =============== S U B R O U T I N E =======================================


sub_4EFCA:
		andi.w	#-$10,d2
		move.w	d2,d3
		addi.w	#$1F0,d3
		andi.w	#-$10,d3
		move.w	(DrawDelayed_Position).w,d0
		cmp.w	d2,d0
		blo.s	loc_4EFEA
		cmp.w	d3,d0
		bhi.s	loc_4EFEA
		moveq	#$10,d6
		jsr	Setup_TileColumnDraw(pc)

loc_4EFEA:

		subi.w	#$10,(DrawDelayed_Position).w
		subq.w	#1,(DrawDelayed_RowCount).w
		rts
; End of function sub_4EFCA


; =============== S U B R O U T I N E =======================================


Draw_PlaneHorzLeftToRight:
		movem.w	d1-d2,-(sp)
		bsr.s	sub_4F004
		movem.w	(sp)+,d1-d2
		bpl.s	sub_4F004
		rts
; End of function Draw_PlaneHorzLeftToRight


; =============== S U B R O U T I N E =======================================


sub_4F004:
		andi.w	#-$10,d2
		move.w	d2,d3
		addi.w	#$1F0,d3
		andi.w	#-$10,d3
		move.w	(DrawDelayed_Position).w,d0
		cmp.w	d2,d0
		blo.s	loc_4F024
		cmp.w	d3,d0
		bhi.s	loc_4F024
		moveq	#$10,d6
		jsr	Setup_TileColumnDraw(pc)

loc_4F024:

		addi.w	#$10,(DrawDelayed_Position).w
		subq.w	#1,(DrawDelayed_RowCount).w
		rts
; End of function sub_4F004


; =============== S U B R O U T I N E =======================================


Draw_PlaneVertBottomUpComplex:

		movem.l	d1/a4-a5,-(sp)
		bsr.s	sub_4F03E
		movem.l	(sp)+,d1/a4-a5
		bpl.s	sub_4F03E
		rts
; End of function Draw_PlaneVertBottomUpComplex


; =============== S U B R O U T I N E =======================================


sub_4F03E:
		and.w	(Camera_Y_pos_mask).w,d1
		move.w	d1,d2
		addi.w	#$F0,d2
		and.w	(Camera_Y_pos_mask).w,d2
		move.w	(DrawDelayed_Position).w,d0
		cmp.w	d1,d0
		blo.s	loc_4F066
		cmp.w	d2,d0
		bhi.s	loc_4F066

loc_4F058:
		addq.w	#4,a5
		cmp.w	(a4)+,d0
		bpl.s	loc_4F058
		move.w	(a5),d1
		moveq	#$20,d6
		jsr	Setup_TileRowDraw(pc)

loc_4F066:

		subi.w	#$10,(DrawDelayed_Position).w
		subq.w	#1,(DrawDelayed_RowCount).w
		rts
; End of function sub_4F03E


; =============== S U B R O U T I N E =======================================


PlainDeformation:

		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		neg.w	d0
		swap	d0
		move.w	(Camera_X_pos_BG_copy).w,d0
		neg.w	d0
		moveq	#$37,d1

loc_4F086:
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		dbf	d1,loc_4F086
		rts
; End of function PlainDeformation


; =============== S U B R O U T I N E =======================================


PlainDeformation_Flipped:

		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_X_pos_BG_copy).w,d0
		neg.w	d0
		swap	d0
		move.w	(Camera_X_pos_copy).w,d0
		neg.w	d0
		moveq	#$37,d1

loc_4F0A8:
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		dbf	d1,loc_4F0A8
		rts
; End of function PlainDeformation_Flippe

; =============== S U B R O U T I N E =======================================

ApplyDeformation:

		move.w	#$DF,d1

sub_239E90:
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	(Camera_X_pos_copy).w,d3

ApplyDeformation2:

		move.w	(a4)+,d2
		smi	d4
		bpl.s	loc_4F0E8
		andi.w	#$7FFF,d2

loc_4F0E8:
		sub.w	d2,d0
		bmi.s	loc_4F0FA
		addq.w	#2,a5
		tst.b	d4
		beq.s	ApplyDeformation2
		subq.w	#2,a5
		add.w	d2,d2
		adda.w	d2,a5
		bra.s	ApplyDeformation2
; ---------------------------------------------------------------------------

loc_4F0FA:
		tst.b	d4
		beq.s	loc_4F104
		add.w	d0,d2
		add.w	d2,d2
		adda.w	d2,a5

loc_4F104:
		neg.w	d0
		move.w	d1,d2
		sub.w	d0,d2
		bcc.s	loc_4F110
		move.w	d1,d0
		addq.w	#1,d0

loc_4F110:
		neg.w	d3
		swap	d3

loc_4F114:
		subq.w	#1,d0

loc_4F116:
		tst.b	d4
		beq.s	loc_4F130
		lsr.w	#1,d0
		bcc.s	loc_4F124

loc_4F11E:
		move.w	(a5)+,d3
		neg.w	d3
		move.l	d3,(a1)+

loc_4F124:
		move.w	(a5)+,d3
		neg.w	d3
		move.l	d3,(a1)+
		dbf	d0,loc_4F11E
		bra.s	loc_4F140
; ---------------------------------------------------------------------------

loc_4F130:
		move.w	(a5)+,d3
		neg.w	d3
		lsr.w	#1,d0
		bcc.s	loc_4F13A

loc_4F138:
		move.l	d3,(a1)+

loc_4F13A:
		move.l	d3,(a1)+
		dbf	d0,loc_4F138

loc_4F140:
		tst.w	d2
		bmi.s	locret_4F158
		move.w	(a4)+,d0
		smi	d4
		bpl.s	loc_4F14E
		andi.w	#$7FFF,d0

loc_4F14E:
		move.w	d2,d3
		sub.w	d0,d2
		bpl.s	loc_4F114
		move.w	d3,d0
		bra.s	loc_4F116
; ---------------------------------------------------------------------------

locret_4F158:
		rts
; End of function ApplyDeformation


; =============== S U B R O U T I N E =======================================


ApplyFGDeformation:

		move.w	#$DF,d1
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Camera_X_pos_BG_copy).w,d3

ApplyFGDeformation2:

		move.w	(a4)+,d2
		smi	d4
		bpl.s	loc_4F174
		andi.w	#$7FFF,d2

loc_4F174:
		sub.w	d2,d0
		bmi.s	loc_4F186
		addq.w	#2,a5
		tst.b	d4
		beq.s	ApplyFGDeformation2
		subq.w	#2,a5
		add.w	d2,d2
		adda.w	d2,a5
		bra.s	ApplyFGDeformation2
; ---------------------------------------------------------------------------

loc_4F186:
		tst.b	d4
		beq.s	loc_4F190
		add.w	d0,d2
		add.w	d2,d2
		adda.w	d2,a5

loc_4F190:
		neg.w	d0
		move.w	d1,d2
		sub.w	d0,d2
		bcc.s	loc_4F19C
		move.w	d1,d0
		addq.w	#1,d0

loc_4F19C:
		neg.w	d3

loc_4F19E:
		subq.w	#1,d0

loc_4F1A0:
		tst.b	d4
		beq.s	loc_4F1C2
		lsr.w	#1,d0
		bcc.s	loc_4F1B2

loc_4F1A8:
		swap	d3
		move.w	(a5)+,d3
		neg.w	d3
		swap	d3
		move.l	d3,(a1)+

loc_4F1B2:
		swap	d3
		move.w	(a5)+,d3
		neg.w	d3
		swap	d3
		move.l	d3,(a1)+
		dbf	d0,loc_4F1A8
		bra.s	loc_4F1D6
; ---------------------------------------------------------------------------

loc_4F1C2:
		swap	d3
		move.w	(a5)+,d3
		neg.w	d3
		swap	d3
		lsr.w	#1,d0
		bcc.s	loc_4F1D0

loc_4F1CE:
		move.l	d3,(a1)+

loc_4F1D0:
		move.l	d3,(a1)+
		dbf	d0,loc_4F1CE

loc_4F1D6:
		tst.w	d2
		bmi.s	locret_4F1EE
		move.w	(a4)+,d0
		smi	d4
		bpl.s	loc_4F1E4
		andi.w	#$7FFF,d0

loc_4F1E4:
		move.w	d2,d1
		sub.w	d0,d2
		bpl.s	loc_4F19E
		move.w	d1,d0
		bra.s	loc_4F1A0
; ---------------------------------------------------------------------------

locret_4F1EE:
		rts
; End of function ApplyFGDeformation

; ---------------------------------------------------------------------------

ApplyFGandBGDeformation:
		swap	d7
		swap	d3

loc_4F1F4:

		move.w	(a4)+,d3
		smi	d7
		bpl.s	loc_4F1FE
		andi.w	#$7FFF,d3

loc_4F1FE:
		sub.w	d3,d0
		bmi.s	loc_4F210
		addq.w	#2,a5
		tst.b	d7
		beq.s	loc_4F1F4
		subq.w	#2,a5
		add.w	d3,d3
		adda.w	d3,a5
		bra.s	loc_4F1F4
; ---------------------------------------------------------------------------

loc_4F210:
		tst.b	d7
		beq.s	loc_4F21A
		add.w	d0,d3
		add.w	d3,d3
		adda.w	d3,a5

loc_4F21A:
		swap	d3
		neg.w	d0
		move.w	d1,d4
		sub.w	d0,d4
		bcc.s	loc_4F228
		move.w	d1,d0
		addq.w	#1,d0

loc_4F228:

		subq.w	#1,d0

loc_4F22A:
		tst.b	d7
		beq.s	loc_4F250
		lsr.w	#1,d0
		bcc.s	loc_4F23E

loc_4F232:
		move.w	(a2)+,d6
		swap	d6
		move.w	(a5)+,d6
		neg.w	d6
		add.w	(a6)+,d6
		move.l	d6,(a1)+

loc_4F23E:
		move.w	(a2)+,d6
		swap	d6
		move.w	(a5)+,d6
		neg.w	d6
		add.w	(a6)+,d6
		move.l	d6,(a1)+
		dbf	d0,loc_4F232
		bra.s	loc_4F270
; ---------------------------------------------------------------------------

loc_4F250:
		move.w	(a5)+,d5
		neg.w	d5
		lsr.w	#1,d0
		bcc.s	loc_4F262

loc_4F258:
		move.w	(a2)+,d6
		swap	d6
		move.w	(a6)+,d6
		add.w	d5,d6
		move.l	d6,(a1)+

loc_4F262:
		move.w	(a2)+,d6
		swap	d6
		move.w	(a6)+,d6
		add.w	d5,d6
		move.l	d6,(a1)+
		dbf	d0,loc_4F258

loc_4F270:
		tst.w	d4
		bmi.s	loc_4F288
		move.w	(a4)+,d0
		smi	d7
		bpl.s	loc_4F27E
		andi.w	#$7FFF,d0

loc_4F27E:
		move.w	d4,d5
		sub.w	d0,d4
		bpl.s	loc_4F228
		move.w	d5,d0
		bra.s	loc_4F22A
; ---------------------------------------------------------------------------

loc_4F288:
		swap	d7
		rts

; =============== S U B R O U T I N E =======================================


Apply_FGVScroll:

		lea	(VScrollBuffer).w,a1
		move.w	(Camera_Y_pos_BG_copy).w,d1
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,d2
		andi.w	#$F,d2
		beq.s	loc_4F2A4
		addi.w	#$10,d0

loc_4F2A4:
		lsr.w	#4,d0

loc_4F2A6:
		addq.w	#2,a5
		move.w	(a4)+,d2
		lsr.w	#4,d2
		sub.w	d2,d0
		bpl.s	loc_4F2A6
		neg.w	d0
		moveq	#$13,d2
		sub.w	d0,d2
		bcc.s	loc_4F2BA
		moveq	#$14,d0

loc_4F2BA:

		subq.w	#1,d0

loc_4F2BC:
		move.w	(a5)+,d3

loc_4F2BE:
		move.w	d3,(a1)+
		move.w	d1,(a1)+
		dbf	d0,loc_4F2BE
		tst.w	d2
		bmi.s	locret_4F2D8
		move.w	(a4)+,d0
		lsr.w	#4,d0
		move.w	d2,d3
		sub.w	d0,d2
		bpl.s	loc_4F2BA
		move.w	d3,d0
		bra.s	loc_4F2BC
; ---------------------------------------------------------------------------

locret_4F2D8:
		rts


; =============== S U B R O U T I N E =======================================


Reset_TileOffsetPositionActual:
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,d1
		andi.w	#$FFF0,d0
		move.w	d0,(Camera_X_pos_rounded).w
		move.w	(Camera_Y_pos_copy).w,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Camera_Y_pos_rounded).w
		rts


; =============== S U B R O U T I N E =======================================


Reset_TileOffsetPositionEff:
		move.w	(Camera_X_pos_BG_copy).w,d0
		move.w	d0,d1
		andi.w	#-$10,d0
		move.w	d0,d2
		move.w	d0,(Camera_X_pos_BG_rounded).w
		move.w	(Camera_Y_pos_BG_copy).w,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(Camera_Y_pos_BG_rounded).w
		rts

; =============== S U B R O U T I N E =======================================


SpecialEvents:
		move.w	(Special_Events_Routine).w,d0
		movea.l	off_4F34E(pc,d0.w),a0
		jmp	(a0)
; ---------------------------------------------------------------------------
off_4F34E:	dc.l locret_4F366
		dc.l AIZ2_DoShipLoop
		dc.l loc_54CB0
		dc.l loc_5560C
		dc.l loc_569BA
		dc.l loc_59E46
; ---------------------------------------------------------------------------

locret_4F366:


		rts
; End of function SpecialEvents


; =============== S U B R O U T I N E =======================================


Adjust_BGDuringLoop:

		move.w	(a1),d1
		move.w	d0,(a1)+
		sub.w	d1,d0
		bpl.s	loc_4F37C
		neg.w	d0
		cmp.w	d2,d0
		blo.s	loc_4F378
		sub.w	d3,d0

loc_4F378:
		sub.w	d0,(a1)+
		rts
; ---------------------------------------------------------------------------

loc_4F37C:
		cmp.w	d2,d0
		blo.s	loc_4F382
		sub.w	d3,d0

loc_4F382:
		add.w	d0,(a1)+
		rts
; End of function Adjust_BGDuringLoop


; =============== S U B R O U T I N E =======================================


Get_BGActualEffectiveDiff:

		move.w	(Camera_X_pos_copy).w,d0
		sub.w	(Camera_X_pos_BG_copy).w,d0
		move.w	d0,(BG_Offset_X).w
		move.w	(Camera_Y_pos_copy).w,d0
		sub.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	d0,(BG_Offset_Y).w
		rts
; End of function Get_BGActualEffectiveDiff


; =============== S U B R O U T I N E =======================================


Offset_SomeObjectsDuringTransition:

		tst.b	(Super_Tails_flag).w
		bne.s	loc_4F3A8
		rts
; ---------------------------------------------------------------------------

loc_4F3A8:
		lea	(Hyper_Sonic_stars).w,a1
		moveq	#3,d2
		bra.s	loc_4F3B6
; ---------------------------------------------------------------------------

Offset_ObjectsDuringTransition:


		lea	(Dynamic_object_RAM+$4A).w,a1
		moveq	#$59,d2

loc_4F3B6:

		tst.l	(a1)
		beq.s	loc_4F3CA
		btst	#2,4(a1)
		beq.s	loc_4F3CA
		sub.w	d0,$10(a1)
		sub.w	d1,$14(a1)

loc_4F3CA:

		lea	next_object(a1),a1
		dbf	d2,loc_4F3B6
		rts

; =============== S U B R O U T I N E =======================================

Comp_ScreenInit:
Comp_ScreenEvent:
CGZ_ScreenEvent:
DDZ_ScreenEvent:
ALZ_BackgroundInit:
BPZ_BackgroundInit:
DPZ_BackgroundInit:
CGZ_BackgroundInit:
EMZ_BackgroundInit:
TwoP_BackgroundInit:
ALZ_BackgroundEvent:
BPZ_BackgroundEvent:
CGZ_BackgroundEvent:
EMZ_BackgroundEvent:
DPZ_BackgroundEvent:
EMZ_Deformation:
; ---------------------------------------------------------------------------
;
;
; AIZ STUFF
;
;
; ---------------------------------------------------------------------------
AIZ_TreeReveal:
		asr.w	#4,d1
		move.w	d1,d2
		asr.w	#3,d1
		add.w	d2,d2
		andi.w	#$E,d2
		addq.w	#4,a0
		movea.l a0,a1
		lea	$40(a0),a0
		jsr	GetLevelAddrChunk(pc)

loc_23ABAE:
		move.w	(a5,d2.w),d3
		move.w	d3,d4
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		move.l	(a2,d3.w),d5
		move.l	4(a2,d3.w),d3
		btst	#$B,d4
		beq.s	loc_23ABD6
		eori.l	#$10001000,d5
		eori.l	#$10001000,d3
		exg	d3,d5

loc_23ABD6:
		btst	#$A,d4
		beq.s	loc_23ABEC
		eori.l	#$8000800,d5
		eori.l	#$8000800,d3
		swap	d5
		swap	d3

loc_23ABEC:
		tst.b	(a6)+
		beq.s	loc_23ABF2
		move.l	d5,(a1)

loc_23ABF2:
		addq.w	#4,a1
		tst.b	$F(a6)
		beq.s	loc_23ABFC
		move.l	d3,(a0)

loc_23ABFC:
		addq.w	#4,a0
		addq.w	#2,d2
		andi.w	#$E,d2
		bne.s	loc_23AC0C
		addq.w	#1,d1
		jsr	GetChunk(pc)

loc_23AC0C:
		dbf	d6,loc_23ABAE
		clr.w	(a0)
		rts

AIZ_TreeRevealArray:	dc.b	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
		dc.b	0,	0,	0,	0,	0,	1,	1,	1,	1,	1,	1,	0,	0,	0,	0,	0
		dc.b	0,	0,	0,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	0,	0
		dc.b	0,	0,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	0
		dc.b	0,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0
		dc.b	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1
		dc.b	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1
; ---------------------------------------------------------------------------

AIZ1_IntroDeform:
		move.w	(Camera_Y_pos_copy).w,(Camera_Y_pos_BG_copy).w
		move.w	(__u_EEB6).w,d0
		bmi.s	loc_23AFE2
		move.w	(Camera_X_pos_copy).w,d0

loc_23AFE2:
		asr.w	#1,d0
		lea	(Block_table+$1828).w,a1
		cmpi.w	#$580,d0
		blt.s	loc_23AFF8
		moveq	#$24,d1

loc_23AFF0:
		move.w	d0,(a1)+
		dbf	d1,loc_23AFF0
		bra.s	loc_23B018
; ---------------------------------------------------------------------------

loc_23AFF8:
		move.w	d0,(a1)+
		subi.w	#$580,d0
		swap	d0
		clr.w	d0
		move.l	d0,d1
		asr.l	#5,d1
		moveq	#$23,d2

loc_23B008:
		add.l	d1,d0
		move.l	d0,d3
		swap	d3
		addi.w	#$580,d3
		move.w	d3,(a1)+
		dbf	d2,loc_23B008

loc_23B018:
		lea	(Block_table+$1828).w,a1
		lea	(Block_table+$1800).w,a5
		move.w	(a1)+,d0
		bpl.s	loc_23B026
		moveq	#0,d0

loc_23B026:
		move.w	d0,(a5)
		addq.w	#4,a5
		moveq	#8,d0

loc_23B02C:
		move.w	(a1),d1
		bpl.s	loc_23B032
		moveq	#0,d1

loc_23B032:
		move.w	d1,(a5)
		addq.w	#8,a1
		addq.w	#4,a5
		dbf	d0,loc_23B02C
		rts
; ---------------------------------------------------------------------------

AIZ1_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$1300,d0
		swap	d0
		clr.w	d0
		asr.l	#5,d0
		move.l	d0,d2
		add.l	d0,d0
		move.l	d0,d1
		lsl.l	#3,d0
		sub.l	d1,d0
		lea	(Block_table+$1830).w,a1
		swap	d0
		move.w	d0,(a1)
		swap	d0

loc_23B06A:
		add.l	d1,d0
		swap	d0
		move.w	d0,-$2C(a1)
		move.w	d0,2(a1)
		move.w	d0,$A(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,4(a1)
		move.w	d0,8(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,6(a1)
		lea	(Block_table+$1816).w,a1
		move.l	d2,d0
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		move.l	(Block_table+$183C).w,d3
		addi.l	#$2000,(Block_table+$183C).w
		asr.l	#1,d0
		moveq	#5,d1

loc_23B0AE:
		add.l	d3,d0
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		add.l	d2,d0
		dbf	d1,loc_23B0AE
		lea	(Block_table+$1816).w,a1
		move.l	d2,d0
		asr.l	#3,d2
		moveq	#$C,d1

loc_23B0C6:
		add.l	d2,d0
		swap	d0

loc_23B0CA:
		move.w	d0,(a1)+
		swap	d0
		dbf	d1,loc_23B0C6
		rts
; ---------------------------------------------------------------------------

AIZ1_ApplyDeformWater:
		lea	AIZ1_DeformArray(pc),a4
		lea	(Block_table+$1808).w,a5
		move.w	(Water_level).w,d1
		sub.w	(Camera_Y_pos_copy).w,d1
		cmpi.w	#$E0,d1
		blt.s	loc_23B0EE
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_23B0EE:
		subq.w	#1,d1
		jsr	sub_239E90(pc)		; NAT: 1 line after ApplyDeformation
		move.l	a1,-(sp)
		lea	(Block_table+$1840).w,a1
		lea	AIZ1_WaterFGDeformDelta(pc),a6
		move.w	(Water_level).w,d0
		subi.w	#$DE,d1
		neg.w	d1
		move.w	(Level_frame_counter).w,d2
		add.w	d0,d2
		add.w	d0,d2
		andi.w	#$7E,d2
		adda.w	d2,a6
		move.w	(Camera_X_pos_copy).w,d6
		neg.w	d6
		jsr	MakeFGDeformArray(pc)
		movea.l (sp)+,a1
		lea	(Block_table+$1840).w,a2
		lea	AIZ1_DeformArray(pc),a4
		lea	(Block_table+$1808).w,a5
		lea	AIZ1_WaterBGDeformDelta(pc),a6
		move.w	(Water_level).w,d0
		sub.w	(Camera_Y_pos_copy).w,d0
		add.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2
		andi.w	#$7E,d2
		adda.w	d2,a6
		jmp	ApplyFGAndBGDeformation(pc)
; ---------------------------------------------------------------------------

AIZ1_FireRise:
	;	cmpi.b	#6,(Player_1+$5).w
	;	bcc.s	locret_23B178
		moveq	#0,d0
		move.w	(ScrEvents_3).w,d0
		addi.w	#$280,d0
		cmpi.w	#$A000,d0
		bcs.s	loc_23B16E
		move.w	#$A000,d0

loc_23B16E:
		move.w	d0,(ScrEvents_3).w
		lsl.l	#4,d0
		add.l	d0,(Camera_Y_pos_BG_copy).w

locret_23B178:
		rts
; ---------------------------------------------------------------------------

AIZTrans_WavyFlame:
	;	cmpi.b	#6,(Player_1+$5).w
	;	bcc.s	locret_23B1C4
		addq.w	#6,(Camera_X_pos_BG_copy+$2).w
		move.w	(Camera_X_pos_BG_copy+$2).w,d0
		andi.w	#$60,d0
		addi.w	#$1000,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		lea	(VScrollBuffer).w,a1
		lea	AIZ_FlameVScroll(pc),a5
		move.w	(Camera_Y_pos_copy).w,d0
		swap	d0
		move.w	(Camera_Y_pos_BG_copy).w,d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#2,d2
		moveq	#$13,d3

loc_23B1B0:
		addq.w	#2,d2
		andi.w	#$F,d2
		move.b	(a5,d2.w),d0
		ext.w	d0
		add.w	d1,d0
		move.l	d0,(a1)+
		dbf	d3,loc_23B1B0

locret_23B1C4:
		rts

; ---------------------------------------------------------------------------
AIZ1_IntroDrawArray:	dc.w	$3E0,	$10,	$10,	$10,	$10,	$10,	$10,	$10,	$10,$7FFF
AIZ1_IntroDeformArray:	dc.w	$3E0,	4,	4,	4,	4,	4,	4,	4,	4,	4,	4,	4,	4,	4,	4,	4
		dc.w	4,	4,	4,	4,	4,	4,	4,	4,	4,	4,	4,	4,	4,	4,	4,	4
		dc.w	4,	4,	4,	4,$7FFF
AIZ1_BGDrawArray:	dc.w	$220,$7FFF
AIZ1_DeformArray:	dc.w    $D0,  $20,  $30,  $30,  $10,  $10,  $10,$800D,   $F,    6,   $E,  $50,  $20,$7FFF
AIZ_FlameVScroll:	dc.b	0,$FF,$FE,$FB,$F8,$F6,$F3,$F2,$F1,$F2,$F3,$F6,$F9,$FB,$FE,$FF ;
; ---------------------------------------------------------------------------

AIZ1_WaterFGDeformDelta:	dc.w	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	0,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
		dc.w $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1
		dc.w	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	0,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
		dc.w $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1
		dc.w	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	0,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
		dc.w $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1
		dc.w	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	0,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
		dc.w $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1
		dc.w	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	0,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
; ---------------------------------------------------------------------------
AIZ1_WaterBGDeformDelta:	dc.w	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	1,	1,	1,	1,	1
		dc.w	1,	0,	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	1,	1,	1
		dc.w	1,	1,	1,	0,	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	1
		dc.w	1,	1,	1,	1,	1,	0,$FFFF,$FFFE,$FFFE,$FFFF,	0,	2,	2,	2,	2,	0
		dc.w	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	1,	1,	1,	1,	1
		dc.w	1,	0,	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	1,	1,	1
		dc.w	1,	1,	1,	0,	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	1
		dc.w	1,	1,	1,	1,	1,	0,$FFFF,$FFFE,$FFFE,$FFFF,	0,	2,	2,	2,	2,	0
		dc.w	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	1,	1,	1,	1,	1
		dc.w	1,	0,	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	1,	1,	1
		dc.w	1,	1,	1,	0,	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	1
		dc.w	1,	1,	1,	1,	1,	0,$FFFF,$FFFE,$FFFE,$FFFF,	0,	2,	2,	2,	2,	0
		dc.w	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	1,	1,	1,	1,	1
		dc.w	1,	0,	0,	0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,	0,	0,	0,	1,	1,	1
; ---------------------------------------------------------------------------
ALZ_AIZ2_BGDeformDelta:	dc.w $FFFE,	1,	2,	2,$FFFF,	2,	2,	1,	2,$FFFF,$FFFE,$FFFE,$FFFE,	1,$FFFF,$FFFF
		dc.w $FFFF,	0,$FFFE,	0,	0,	0,$FFFE,	0,$FFFE,	2,	0,$FFFE,	2,	2,$FFFF,$FFFE
		dc.w $FFFE,	1,	2,	2,$FFFF,	2,	2,	1,	2,$FFFF,$FFFE,$FFFE,$FFFE,	1,$FFFF,$FFFF
		dc.w $FFFF,	0,$FFFE,	0,	0,	0,$FFFE,	0,$FFFE,	2,	0,$FFFE,	2,	2,$FFFF,$FFFE
		dc.w $FFFE,	1,	2,	2,$FFFF,	2,	2,	1,	2,$FFFF,$FFFE,$FFFE,$FFFE,	1,$FFFF,$FFFF
		dc.w $FFFF,	0,$FFFE,	0,	0,	0,$FFFE,	0,$FFFE,	2,	0,$FFFE,	2,	2,$FFFF,$FFFE
		dc.w $FFFE,	1,	2,	2,$FFFF,	2,	2,	1,	2,$FFFF,$FFFE,$FFFE,$FFFE,	1,$FFFF,$FFFF
		dc.w $FFFF,	0,$FFFE,	0,	0,	0,$FFFE,	0,$FFFE,	2,	0,$FFFE,	2,	2,$FFFF,$FFFE
		dc.w $FFFE,	1,	2,	2,$FFFF,	2,	2,	1,	2,$FFFF,$FFFE,$FFFE,$FFFE,	1,$FFFF,$FFFF
		dc.w $FFFF,	0,$FFFE,	0,	0,	0,$FFFE,	0,$FFFE,	2,	0,$FFFE,	2,	2,$FFFF,$FFFE
		dc.w $FFFE,	1,	2,	2,$FFFF,	2,	2,	1,	2,$FFFF,$FFFE,$FFFE,$FFFE,	1,$FFFF,$FFFF
		dc.w $FFFF,	0,$FFFE,	0,	0,	0,$FFFE,	0,$FFFE,	2,	0,$FFFE,	2,	2,$FFFF,$FFFE
		dc.w $FFFE,	1,	2,	2,$FFFF,	2,	2,	1,	2,$FFFF,$FFFE,$FFFE,$FFFE,	1,$FFFF,$FFFF
		dc.w $FFFF,	0,$FFFE,	0,	0,	0,$FFFE,	0,$FFFE,	2,	0,$FFFE,	2,	2,$FFFF,$FFFE
		dc.w $FFFE,	1,	2,	2,$FFFF,	2,	2,	1,	2,$FFFF,$FFFE,$FFFE,$FFFE,	1,$FFFF,$FFFF
		dc.w $FFFF,	0,$FFFE,	0,	0,	0,$FFFE,	0,$FFFE,	2,	0,$FFFE,	2,	2,$FFFF,$FFFE
; ---------------------------------------------------------------------------

AIZ2_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(ScrShake_Offset).w,d1
		sub.w	d1,d0
		asr.w	#1,d0
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		cmpi.w	#$10,(TrigEvents_Routine).w
		bcs.s	loc_23B648
		move.w	(ScrEvents_D).w,d0
		add.w	d0,(Camera_Y_pos_BG_copy).w

loc_23B648:
		move.w	(__u_EEB6).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#5,d1
		move.l	d1,d2
		add.l	d1,d1
		add.l	d2,d1
		lea	(Block_table+$19C0).w,a1
		lea	AIZ2_BGDeformMake(pc),a5
		moveq	#0,d2

loc_23B666:
		move.b	(a5)+,d3
		bmi.s	locret_23B67E
		ext.w	d3
		swap	d0

loc_23B66E:
		move.b	(a5)+,d2
		move.w	d0,(a1,d2.w)
		dbf	d3,loc_23B66E
		swap	d0
		add.l	d1,d0
		bra.s	loc_23B666
; ---------------------------------------------------------------------------

locret_23B67E:
		rts
; ---------------------------------------------------------------------------

AIZ2_ApplyDeform:
		lea	(Block_table+$1800).w,a1
		lea	AIZ2_FGDeformDelta(pc),a6
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	#$DF,d1
		move.w	(Level_frame_counter).w,d2
		add.w	d0,d2
		add.w	d0,d2
		moveq	#$3E,d3
		move.w	(Camera_X_pos_copy).w,d6
		neg.w	d6
		move.w	(Water_level).w,d4
		sub.w	d0,d4
		bls.s	loc_23B6CA			; If completely underwater, only do water deformation
		cmp.w	d1,d4
		bhi.s	loc_23B6D0			; If water isn't showing at all, only do non-water deformation
		move.w	d4,d1				; Otherwise, just do both
		subq.w	#1,d1
		and.w	d3,d2
		adda.w	d2,a6
		jsr	MakeFGDeformArray(pc)
		move.w	(Water_level).w,d0
		subi.w	#$DE,d1
		neg.w	d1
		move.w	(Level_frame_counter).w,d2
		add.w	d0,d2
		add.w	d0,d2

loc_23B6CA:
		lea	AIZ1_WaterFGDeformDelta(pc),a6
		moveq	#$7E,d3

loc_23B6D0:
		and.w	d3,d2
		adda.w	d2,a6
		jsr	MakeFGDeformArray(pc)
		lea	(H_scroll_buffer).w,a1
		lea	(Block_table+$1800).w,a2
		lea	AIZ2_BGDeformArray(pc),a4
		lea	(Block_table+$19C0).w,a5
		lea	ALZ_AIZ2_BGDeformDelta(pc),a6
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	#$DF,d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2
		moveq	#$3E,d3
		move.w	(Water_level).w,d4
		sub.w	(Camera_Y_pos_copy).w,d4
		bls.s	loc_23B73E			; Same as above, if completely underwater only apply water deformation
		cmp.w	d1,d4
		bhi.s	loc_23B744			; Same as above, if no water is showing, only do above-ground deformation
		move.w	d4,d1				; Otherwise, just do both
		subq.w	#1,d1
		and.w	d3,d2
		adda.w	d2,a6
		jsr	ApplyFGAndBGDeformation(pc)
		lea	AIZ2_BGDeformArray(pc),a4
		lea	(Block_table+$19C0).w,a5
		move.w	(Water_level).w,d0
		sub.w	(Camera_Y_pos_copy).w,d0
		add.w	(Camera_Y_pos_BG_copy).w,d0
		subi.w	#$DE,d1
		neg.w	d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2

loc_23B73E:
		lea	AIZ1_WaterBGDeformDelta(pc),a6
		moveq	#$7E,d3

loc_23B744:
		and.w	d3,d2
		adda.w	d2,a6
		jsr	ApplyFGAndBGDeformation(pc)
		tst.w	(ScrEvents_4).w
		beq.s	locret_23B772
		lea	(H_scroll_buffer).w,a1		; This is for what I assume to be the flying battleship sequence.
		move.w	(__u_EE98).w,d0		; Nullifies the top 8 tiles worth of FG waviness for this effect
		neg.w	d0						; And replaces it with position data from the second BG camera.
		moveq	#$F,d1

loc_23B75E:
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		dbf	d1,loc_23B75E

locret_23B772:
		rts
; ---------------------------------------------------------------------------

AIZ2_BGDeformMake:	dc.b 1
		dc.b $12,$2A
		dc.b 3
		dc.b $10,$14,$28,$2C
		dc.b 3
		dc.b	$E,$16,$26,$2E
		dc.b 4
		dc.b	0, $C,$18,$24,$30
		dc.b 3
		dc.b	2, $A,$1A,$22
		dc.b 3
		dc.b	4,	8,$1C,$20
		dc.b 1
		dc.b	6,$1E
		dc.b $FF
		dc.b 0
; ---------------------------------------------------------------------------
AIZ2_FGDeformDelta:	dc.w	0,	0,	1,	1,	0,	0,	0,	0,	1,	0,	0,	0,	0,	1,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	1,	1,	0,	0
		dc.w	0,	0,	1,	1,	0,	0,	0,	0,	1,	0,	0,	0,	0,	1,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	1,	1,	0,	0
		dc.w	0,	0,	1,	1,	0,	0,	0,	0,	1,	0,	0,	0,	0,	1,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	1,	1,	0,	0
		dc.w	0,	0,	1,	1,	0,	0,	0,	0,	1,	0,	0,	0,	0,	1,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	1,	1,	0,	0
		dc.w	0,	0,	1,	1,	0,	0,	0,	0,	1,	0,	0,	0,	0,	1,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	1,	1,	0,	0
		dc.w	0,	0,	1,	1,	0,	0,	0,	0,	1,	0,	0,	0,	0,	1,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	1,	1,	0,	0
		dc.w	0,	0,	1,	1,	0,	0,	0,	0,	1,	0,	0,	0,	0,	1,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	1,	1,	0,	0
		dc.w	0,	0,	1,	1,	0,	0,	0,	0,	1,	0,	0,	0,	0,	1,	0,	0
		dc.w	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	1,	1,	0,	0
; ---------------------------------------------------------------------------
AIZ2_BGDeformArray:	dc.w	$10,	$20,	$38,	$58,	$28,	$40,	$38,	$18,	$18,	$90,	$48,	$10,	$18,	$20,	$38,	$58
		dc.w	$28,	$40,	$38,	$18,	$18,	$90,	$48,	$10,$7FFF
Pal_AIZBattleship:	dc.w	0, $EEE, $2AE,	$6E,	$4C,	$EE,	$88, $224,	$CA,	$66,	$42,	$20, $CAA, $866, $644,	$44
Pal_AIZBossSmall:	dc.w	$EEE, $CAA, $E26, $222,	$EE,	0,	8, $2AE,	$4C,	6,	$20, $C68, $A24, $622
AIZBattleShip_BobbingMotion:	dc.b	4,	4,	3,	3,	2,	1,	1,	0,	0,	0,	1,	1,	2,	3,	3,	4
AIZBattleship_BombScript:	dc.w	$20,$3F5C
		dc.w	$20,$3F2C
		dc.w	$20,$3F5C
		dc.w	$20,$3F2C
		dc.w	$20,$3F5C
		dc.w	$38,$3F2C
		dc.w	$20,$3EDC
		dc.w	$20,$3EAC
		dc.w	$20,$3EDC
		dc.w	$20,$3EAC
		dc.w	$20,$3EDC
		dc.w	$38,$3EAC
		dc.w	$20,$3E5C
		dc.w	$20,$3E2C
		dc.w	$20,$3E5C
		dc.w	$20,$3E2C
		dc.w	$20,$3E5C
		dc.w	$38,$3E2C
		dc.w	$40,$3DEC
		dc.w	$40,$3DEC
		dc.w	$40,$3DEC
		dc.w	$FFFF
; ---------------------------------------------------------------------------
AIZBombExplodeDat:	dc.w	0,$FFC4,	0,	$A ; X offset, Y offset, animation number, animation delay
		dc.w	0,$FFF4, $101,	9
		dc.w $FFFC,$FFCC,	0,	8
		dc.w	$C,$FFFC, $101,	7
		dc.w $FFF4,$FFFC, $101,	5
		dc.w	8,$FFDC,	0,	4
		dc.w $FFF8,$FFE4,	0,	2
		dc.w	0,$FFF4,	0,	0
; ---------------------------------------------------------------------------
AIZMakeTreeScript:	dc.w	0, $280
		dc.w	$32, $380
		dc.w	$8E, $280
		dc.w	$103, $380
		dc.w	$179, $280
		dc.w	$1C6, $380
		dc.w	$233, $280
		dc.w	$2A0, $380
		dc.w	$30A, $280
		dc.w	$37C, $380
		dc.w	$3C7, $280
		dc.w	$401, $380
		dc.w	$439, $280
		dc.w	$46E, $380
		dc.w	$4CA, $280
		dc.w	$50C, $380
		dc.w	$557, $280
		dc.w $FFFF
; ---------------------------------------------------------------------------
Map_AIZShipPropeller:dc.w word_23C18A-Map_AIZShipPropeller
		dc.w word_23C192-Map_AIZShipPropeller
		dc.w word_23C19A-Map_AIZShipPropeller
		dc.w word_23C1A2-Map_AIZShipPropeller
word_23C18A:	dc.w 1
		dc.b $F0,	3,$A0,	0,$FF,$FC
word_23C192:	dc.w 1
		dc.b $F4,	2,$A0,	4,$FF,$FC
word_23C19A:	dc.w 1
		dc.b $FC,	0,$A0,	7,$FF,$FC
word_23C1A2:	dc.w 1
		dc.b $F4,	2,$B0,	4,$FF,$FC
; ---------------------------------------------------------------------------
Ani_AIZShipPropeller:dc.w byte_23C1AC-Ani_AIZShipPropeller
byte_23C1AC:	dc.b	2,	0,	1,	2,	3,$FF
; ---------------------------------------------------------------------------
Map_AIZ2BombExplode:dc.w word_23C1CA-Map_AIZ2BombExplode
		dc.w word_23C1D2-Map_AIZ2BombExplode
		dc.w word_23C1DA-Map_AIZ2BombExplode
		dc.w word_23C1E2-Map_AIZ2BombExplode
		dc.w word_23C1EA-Map_AIZ2BombExplode
		dc.w word_23C1F2-Map_AIZ2BombExplode
		dc.w word_23C1FA-Map_AIZ2BombExplode
		dc.w word_23C202-Map_AIZ2BombExplode
		dc.w word_23C20A-Map_AIZ2BombExplode
		dc.w word_23C212-Map_AIZ2BombExplode
		dc.w word_23C21A-Map_AIZ2BombExplode
		dc.w word_23C222-Map_AIZ2BombExplode
word_23C1CA:	dc.w 1
		dc.b $F0, $B,$20,	8,$FF,$F4
word_23C1D2:	dc.w 1
		dc.b $FC, $E,	0,$14,$FF,$F0
word_23C1DA:	dc.w 1
		dc.b $F4, $F,	0,$20,$FF,$F0
word_23C1E2:	dc.w 1
		dc.b $F4, $F,	0,$30,$FF,$F0
word_23C1EA:	dc.w 1
		dc.b $F4, $E,	0,$40,$FF,$F0
word_23C1F2:	dc.w 1
		dc.b $F4, $E,	0,$4C,$FF,$F0
word_23C1FA:	dc.w 1
		dc.b	0,	5,	0,$58,$FF,$F8
word_23C202:	dc.w 1
		dc.b $FC, $A,	0,$5C,$FF,$F4
word_23C20A:	dc.w 1
		dc.b $FC, $A,	0,$65,$FF,$F4
word_23C212:	dc.w 1
		dc.b $FC, $A,	0,$6E,$FF,$F4
word_23C21A:	dc.w 1
		dc.b $FC, $A,	0,$77,$FF,$F4
word_23C222:	dc.w 1
		dc.b $FC,	9,	0,$80,$FF,$F4
; ---------------------------------------------------------------------------
Ani_AIZ2BombExplode:dc.w byte_23C22E-Ani_AIZ2BombExplode
		dc.w byte_23C23A-Ani_AIZ2BombExplode
byte_23C22E:	dc.b	1,	3,	2,	4,	3,	5,	4,	5,	5,	5,$FC,	0
byte_23C23A:	dc.b	6,	2,	7,	3,	8,	4,	9,	5, $A,	5, $B,	5,$FC,	0
; ---------------------------------------------------------------------------
Map_AIZ2BGTree: dc.w word_23C24A-Map_AIZ2BGTree
word_23C24A:	dc.w 4
		dc.b $C0,	7,$40,	0,	0,	0
		dc.b $E0,	7,$40,	0,	0,	0
		dc.b	0,	7,$40,	0,	0,	0
		dc.b $20,	7,$40,	0,	0,	0
; ---------------------------------------------------------------------------
Map_AIZ2BossSmall:dc.w word_23C266-Map_AIZ2BossSmall
word_23C266:	dc.w 6
		dc.b $E4, $E,$20,$86,$FF,$F0
		dc.b $F4,	0,$20,$92,$FF,$E8
		dc.b $F4,	0,$20,$93,	0,$10
		dc.b $FC, $E,$20,$94,$FF,$E0
		dc.b $FC, $E,$20,$A0,	0,	0
		dc.b $14, $C,$20,$AC,$FF,$F0
; ---------------------------------------------------------------------------
HCZ1_BGDeformArray:	dc.w $40
		dc.w 8
		dc.w 8
		dc.w 5
		dc.w 5
		dc.w 6
		dc.w $F0
		dc.w 6
		dc.w 5
		dc.w 5
		dc.w 8
		dc.w 8
		dc.w $30
		dc.w $80C0
		dc.w $7FFF
; ---------------------------------------------------------------------------
HCZ2_BGDeformArray:	dc.w	8,	8,	$90,	$10,	8,	$30,	$18,	8
		dc.w	8,	$A8,	$30,	$18,	8,	8,	$A8,	$30
		dc.w	$18,	8,	8,	$B0,	$10,	8,$7FFF
HCZ2_BGDeformIndex:	dc.b	3, $A
		dc.b $14,$1E
		dc.b $2C,	2
		dc.b	$C,$16
		dc.b $20,	5
		dc.b	0,	8
		dc.b	$E,$18
		dc.b $22,$2A
		dc.b	3,	2
		dc.b $10,$1A
		dc.b $24,	1
		dc.b $12,$1C
		dc.b	1,	6
		dc.b $28,	1
		dc.b	4,$26
		dc.b $FF,	0
; ---------------------------------------------------------------------------
MGZ1_Deform:
		move.w	(ScrShake_Offset).w,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#2,d0
		move.l	d0,d1
		asr.l	#4,d1
		lea	(Block_table+$181C).w,a1
		moveq	#8,d2

loc_23C98A:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d2,loc_23C98A
		lea	(Block_table+$1800).w,a1
		move.l	(Block_table+$181C).w,d2
		addi.l	#$500,(Block_table+$181C).w
		asr.l	#1,d0
		moveq	#4,d3

loc_23C9AA:
		add.l	d2,d0
		addi.l	#$500,d2
		swap	d0
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		dbf	d3,loc_23C9AA
		move.w	-2(a1),d0
		move.w	-4(a1),-2(a1)
		move.w	d0,-4(a1)
		rts
; ---------------------------------------------------------------------------
MGZ1_BGDeformArray:	dc.w	$10,	4,	4,	8,	8,	8,	$D,	$13
		dc.w	8,	8,	8,	8,	$18,$7FFF
; ---------------------------------------------------------------------------
MGZ2_QuakeEventArray:	dc.w	$780, $7C0, $580, $600, $5A0, $7E0 ; Player X boundaries, Player Y boundaries, Level size reset val
		dc.w $31C0,$3200, $1C0, $280, $1E0,$2F60
		dc.w $3440,$3480, $680, $700, $6A0,$32C0
MGZ2_ChunkEventArray:	dc.w	$F68, $F78, $500, $580, $F00, $500 ; Player X boundaries, Player Y boundaries, Screen redraw area
		dc.w $3680,$3700, $2F0, $380,$3700, $280
		dc.w $3000,$3080, $770, $800,$3080, $700
; ---------------------------------------------------------------------------
MGZ2_ScreenRedrawArray:	dc.w	$40,	3
		dc.w	$50,	3
		dc.w	$50,	4
		dc.w	$60,	4
		dc.w	$60,	3
		dc.w	$70,	2
		dc.w	$70,	3
		dc.w	$80,	3
		dc.w	$80,	3
		dc.w	$80,	4
		dc.w	$80,	4
		dc.w	$80,	4
		dc.w	$80,	5
		dc.w	$90,	5
		dc.w	$A0,	4
		dc.w	$90,	6
		dc.w	$80,	6
		dc.w	$90,	6
		dc.w	$A0,	5
		dc.w	$B0,	4
		dc.w	$C0,	3
		dc.w	$D0,	2
		dc.w	$E0,	1
MGZ2_ChunkReplaceArray:	dc.w	$100, $500
		dc.w	$180, $580
		dc.w	$200, $600
		dc.w	$280, $680
		dc.w	$300, $700
		dc.w	$380, $780
		dc.w	0, $800
		dc.w	0, $880
		dc.w	0, $900
		dc.w	0, $980
		dc.w	0, $A00
		dc.w	0, $A80
		dc.w	0, $B00
		dc.w	0, $B80
		dc.w	0, $C00
		dc.w	0, $C80
		dc.w	0, $D00
		dc.w	0, $D80
		dc.w	0, $E00
		dc.w	0, $E80
		dc.w	0, $F00
		dc.w	0, $F80
		dc.w	0,$1000
		dc.w	$80, $480
; ---------------------------------------------------------------------------
MGZ2_CollapseScrollDelay:	dc.w	$A,	$10,	2,	8,	$E,	6,	0,	$C,	$12,	4
MGZ2_FGVScrollArray:	dc.w $3CA0,	$20,	$20,	$20,	$20,	$20,	$20,	$20
		dc.w	$20,$7FFF

; =============== S U B R O U T I N E =======================================


MGZ2_BGDeform:
		move.w	(ScrEvents_Routine2).w,d0
		jmp	loc_23D1D8(pc,d0.w)


; ---------------------------------------------------------------------------

loc_23D1D8:
		bra.w	loc_23D21E	; 0 - Normal
; ---------------------------------------------------------------------------
		bra.w	loc_23D1F4	; 4 - Knuckles BG move event
; ---------------------------------------------------------------------------
		bra.w	loc_23D1EA	; 8 - Sonic BG move event
; ---------------------------------------------------------------------------
		move.w	#$500,d1	; C - After BG move event
		bra.s	loc_23D220
; ---------------------------------------------------------------------------

loc_23D1EA:
		move.w	#$8F0,d1
		move.w	#$3200,d2
		bra.s	loc_23D1FC
; ---------------------------------------------------------------------------

loc_23D1F4:
		move.w	#$1E0,d1
		move.w	#$3580,d2

loc_23D1FC:
		move.w	(Camera_Y_pos_copy).w,d0
		sub.w	d1,d0
		add.w	(ScrEvents_3).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w		; Effective BG Y is offset, but otherwise matched in ratio during the special BG events
		move.w	(Camera_X_pos_copy).w,d0
		sub.w	d2,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	d0,(Block_table+$1804).w
		move.w	d0,(Block_table+$1836).w
		bra.s	loc_23D24C
; ---------------------------------------------------------------------------

loc_23D21E:
		moveq	#0,d1

loc_23D220:
		move.w	(Camera_Y_pos_copy).w,d0		; Get BG Y camera
		move.w	(ScrShake_Offset).w,d2		; Get screen shake offset
		sub.w	d2,d0
		sub.w	d1,d0					; Subtract from that and the special offset for MGZ2 events
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		add.l	d0,d0
		add.l	d1,d0
		swap	d0
		add.w	d2,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w		; Effective BG Y is normal 3/16ths normal BG Y during normal play
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Block_table+$1804).w
		clr.w	(Block_table+$1836).w

loc_23D24C:
		move.w	(Camera_X_pos_copy).w,d0
		cmpi.w	#8,(ScrEvents_Routine).w
		bne.s	loc_23D25C
		move.w	(ScrEvents_8).w,d0		; If playing on the boss, use the special camera scrolling set by MGZ2's screen event

loc_23D25C:
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#3,d1
		move.l	d1,d2
		asr.l	#2,d2
		lea	(Block_table+$1836).w,a1
		moveq	#7,d3

loc_23D270:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d3,loc_23D270
		tst.w	(ScrEvents_9).w			; If EEE0 is set, don't bother moving the clouds automatically
		bne.s	loc_23D28A
		addi.l	#$800,(Block_table+$1838).w

loc_23D28A:
		move.l	(Block_table+$1838).w,d1
		lea	(Block_table+$1808).w,a1
		lea	MGZ2_BGDeformIndex(pc),a5
		move.l	d2,d0
		asr.l	#1,d2
		moveq	#$E,d3

loc_23D29C:
		move.w	(a5)+,d4
		add.l	d1,d0
		swap	d0
		move.w	d0,(a1,d4.w)
		swap	d0
		add.l	d2,d0
		dbf	d3,loc_23D29C
		lea	MGZ2_BGDeformOffset(pc),a5
		moveq	#$16,d0

loc_23D2B4:
		move.w	(a5)+,d1
		add.w	d1,(a1)+
		dbf	d0,loc_23D2B4
		rts
; ---------------------------------------------------------------------------
MGZ2_BGDrawArray:	dc.w $200
		dc.w $7FFF
MGZ2_BGDeformArray:	dc.w	$10,	$10,	$10,	$10,	$10,	$18,	8,	$10
		dc.w	8,	8,	$10,	8,	8,	8,	5,	$2B
		dc.w	$C,	6,	6,	8,	8,	$18,	$D8,$7FFF
MGZ2_BGDeformIndex:	dc.w	$1C,	$18,	$1A,	$C,	6,	$14,	2,	$10
		dc.w	$16,	$12,	$A,	0,	8,	4,	$E
MGZ2_BGDeformOffset:	dc.w $FFFB,$FFF8,	9,	$A,	2,$FFF4,	3,	$10
		dc.w $FFFF,	$D,$FFF1,	6,$FFF5,$FFFC,	$E,$FFF8
		dc.w	$10,	8,	0,$FFF8,	$10,	8,	0
; ---------------------------------------------------------------------------

ICZ1_SetIntroPal:
		tst.b	(Game_mode).w
		bmi.s	loc_23DE92
		lea	(Normal_palette_line_4+$2).w,a1
		bsr.s	sub_23DE96

loc_23DE92:
		lea	(Target_palette_line_4+$2).w,a1


; =============== S U B R O U T I N E =======================================


sub_23DE96:
		move.l	#$EEE0EEC,(a1)+
		move.l	#$EEA0ECA,(a1)+
		move.l	#$EC80EA6,(a1)+
		move.l	#$E860E64,(a1)+
		move.l	#$E400E00,(a1)+
		move.l	#$C000000,(a1)+
		move.l	#$AEC0CEA,(a1)+
		move.w	#$E80,(a1)
		rts
; ---------------------------------------------------------------------------
ICZ1_SetIndoorPal:
		tst.b	(Game_mode).w
		bmi.s	loc_23DED2
		lea	(Normal_palette_line_4+$2).w,a1
		bsr.s	sub_23DED6

loc_23DED2:
		lea	(Target_palette_line_4+$2).w,a1



; =============== S U B R O U T I N E =======================================


sub_23DED6:
		move.l	#$EC00E40,(a1)+
		move.l	#$E040C00,(a1)+
		move.l	#$6000200,(a1)+
		move.l	#$E64,(a1)+
		move.l	#$E240A02,(a1)+
		move.w	#$402,(a1)
		rts


ICZ1_IntroBGDeformArray:	dc.w	$44,	$C,	$B,	$D,	$18,	$50,	2,	6
		dc.w	8,	$10,	$18,	$20,	$28,$7FFF
; ---------------------------------------------------------------------------
ICZ2_OutDeform:
		clr.w	(Camera_Y_pos_BG_copy).w		; Effective Y is always 0
		move.w	(Camera_X_pos_copy).w,d0
		move.w	(Level_frame_counter).w,d1
		asr.w	#1,d1
		add.w	d1,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		andi.l	#$7FFFFF,d0
		move.l	d0,d1
		asr.l	#6,d1
		lea	(Block_table+$1864).w,a1
		moveq	#$27,d2

loc_23E0E8:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		dbf	d2,loc_23E0E8
		lea	(Block_table+$1800).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#1,d0
		add.l	d0,d1
		move.l	d1,$64(a1)
		asr.l	#2,d0
		move.l	d0,d1
		swap	d0
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,(a1)+
		move.w	(Level_frame_counter).w,d1
		lsr.w	#2,d1
		andi.w	#$3E,d1
		lea	ALZ_AIZ2_BGDeformDelta(pc),a5
		adda.w	d1,a5
		moveq	#7,d1

loc_23E12E:
		move.w	(a5)+,d2
		add.w	d0,d2
		move.w	d2,(a1)+
		dbf	d1,loc_23E12E
		rts


; =============== S U B R O U T I N E =======================================


ICZ2_InDeform:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$700,d0
		asr.w	#2,d0
		addi.w	#$118,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		lea	(Block_table+$1800).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#3,d1
		swap	d0
		move.w	d0,(a1)
		move.w	d0,$10(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,2(a1)
		move.w	d0,$E(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,4(a1)
		move.w	d0,$C(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,6(a1)
		move.w	d0,$A(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	d0,8(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(ScrEvents_A).w
		rts



; =============== S U B R O U T I N E =======================================


ICZ2_SetOutdoorsPal:
		tst.b	(Game_mode).w
		bmi.s	loc_23E1B6
		lea	(Normal_palette_line_4+$2).w,a1
		bsr.s	sub_23E1BA

loc_23E1B6:
		lea	(Target_palette_line_4+$2).w,a1



; =============== S U B R O U T I N E =======================================


sub_23E1BA:
		move.l	#$EEE0EEA,(a1)+
		move.l	#$EC80EA4,(a1)+
		move.l	#$C820C60,(a1)+
		move.l	#$C400E20,(a1)+
		move.l	#$A000E00,(a1)
		rts



; =============== S U B R O U T I N E =======================================


ICZ2_SetIndoorsPal:
		tst.b	(Game_mode).w
		bmi.s	loc_23E1E6
		lea	(Normal_palette_line_4+$2).w,a1
		bsr.s	sub_23E1EA

loc_23E1E6:
		lea	(Target_palette_line_4+$2).w,a1



; =============== S U B R O U T I N E =======================================


sub_23E1EA:
		move.l	#$EE20E24,(a1)+
		move.l	#$E040E02,(a1)+
		move.l	#$4020200,(a1)+
		move.l	#$E20,(a1)+
		move.l	#$E400840,(a1)+
		move.w	#$600,(a1)
		rts



; =============== S U B R O U T I N E =======================================


ICZ2_SetICZ1Pal:
		tst.b	(Game_mode).w
		bmi.s	loc_23E21A
		lea	(Normal_palette_line_4+$2).w,a1
		bsr.s	sub_23E21E

loc_23E21A:
		lea	(Target_palette_line_4+$2).w,a1



; =============== S U B R O U T I N E =======================================


sub_23E21E:
		move.l	#$EEC0CC6,(a1)+
		move.l	#$C800C60,(a1)+
		move.l	#$C400A40,(a1)+
		move.l	#$8200620,(a1)+
		move.l	#$2000600,(a1)
		rts

; ---------------------------------------------------------------------------
ICZ2_OutBGDeformArray:	dc.w $5A
		dc.w $26
		dc.w $8030
		dc.w $7FFF
ICZ2_InBGDeformArray:	dc.w	$1A0,	$40,	$20,	$18,	$40,	8,	8,	$18
		dc.w $7FFF
; ---------------------------------------------------------------------------
LBZ1_CheckLayoutMod:
		move.w	Player_1+x_pos.w,d0
		move.w	Player_1+y_pos.w,d1
		move.w	d2,d4
		bsr.s	.chkonce

		move.w	Player_2+x_pos.w,d0
		move.w	Player_2+y_pos.w,d1
		move.w	d4,d2
		bsr.s	.chkonce		; NAT: Needs to be bsr for stack manipulation
		rts

.chkonce	lea	LBZ1_LayoutModRange(pc),a1
		moveq	#5-1,d3
		cmp.w	#Boxes_LBZK-Ranges_LBZK,SpawnBoxPos.w; check if knux cutscene (a hack)
		bne.s	loc_23E45E		; if no, normal
		moveq	#0,d3
		add.w	#8*3,a1			; skip over entries
		add.w	#4*3,d2

loc_23E45E:
		lea	(a1),a5
		cmp.w	(a5)+,d0
		bcs.s	loc_23E480
		cmp.w	(a5)+,d0
		bhi.s	loc_23E480
		cmp.w	(a5)+,d1
		bcs.s	loc_23E480
		cmp.w	(a5)+,d1
		bhi.s	loc_23E480
		tst.w	d2
		bne.s	loc_23E48A
		cmpi.w	#$1580,d0		; The first layout mod range ignores a small corner on the lower right.
		bcs.s	loc_23E48A
		cmpi.w	#$400,d1
		bcs.s	loc_23E48A

loc_23E480:
		addq.w	#8,a1
		addq.w	#4,d2
		dbf	d3,loc_23E45E
		rts
; ---------------------------------------------------------------------------

loc_23E48A:
		addq.w	#4,sp
		addq.w	#4,d2
		move.w	d2,(ScrEvents_Routine2).w
		lsr.w	#1,d2
		jmp	LBZ1_LayoutModBranch-2(pc,d2.w)

LBZ1_LayoutModBranch:
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutMod1
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutMod2
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutMod3
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutMod4
; ---------------------------------------------------------------------------
	;	bra.s	LBZ1_LayoutMod5

LBZ1_LayoutMod5:
		movea.w $48(a3),a5		; NAT: Custom layout mod
		lea	$94(a5),a5

LBZ1_LayoutMod5_:
		movea.w $48(a3),a1
		lea	$0A(a1),a1
		bra.s	LBZ1_DoMod5
; ---------------------------------------------------------------------------

LBZ1_LayoutMod1:
		movea.w (a3),a5
		lea	$80(a5),a5
		bra.w	LBZ1_DoMod1
; ---------------------------------------------------------------------------

LBZ1_LayoutMod2:
		movea.w $24(a3),a5
		lea	$80(a5),a5
		bra.s	LBZ1_DoMod2
; ---------------------------------------------------------------------------

LBZ1_LayoutMod3:
		tst.w	(ScrEvents_3).w
		beq.s	loc_23E4C0
		clr.w	(ScrEvents_Routine2).w
		moveq	#-1,d3
		rts
; ---------------------------------------------------------------------------

loc_23E4C0:
		st	MonContPos.w			; hide HUD now
		movea.w (a3),a5
		lea	$94(a5),a5
		bra.s	LBZ1_DoMod3
; ---------------------------------------------------------------------------

LBZ1_LayoutMod4:
		movea.w $30(a3),a5
		lea	$94(a5),a5

LBZ1_DoMod4:
		movea.w (a3),a1
		lea	$7A(a1),a1

LBZ1_DoMod5:
		move.w	-8(a3),d0
		subq.w	#6,d0
		moveq	#5,d1

loc_23E4DE:
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_23E4DE
		rts
; ---------------------------------------------------------------------------

LBZ1_DoMod3:
		movea.w (a3),a1
		lea	$74(a1),a1
		move.w	-8(a3),d0
		subq.w	#4,d0
		moveq	#$B,d1

loc_23E4FA:
		move.l	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_23E4FA
		rts
; ---------------------------------------------------------------------------

LBZ1_DoMod2:
		movea.w (a3),a1
		lea	$42(a1),a1
		move.w	-8(a3),d0
		subi.w	#$A,d0
		moveq	#$D,d1

loc_23E516:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_23E516
		rts
; ---------------------------------------------------------------------------

LBZ1_DoMod1:
		movea.w 8(a3),a1
		lea	$26(a1),a1
		move.w	-8(a3),d0
		subq.w	#8,d0
		moveq	#8,d1

loc_23E536:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_23E536
		rts
LBZ1_FGVScrollArray:	dc.w $3B60,	$10,	$10,	$10,	$10,	$10,	$10,	$10
		dc.w	$10,	$10,	$10,$7FFF

LBZ1_LayoutModRange:
	dc.w $13E0,$16A0, $100, $580
	dc.w $2160,$2520,	0, $700
	dc.w $3A60,$3BA0,	0, $600
	dc.w $3DE0,$3FA0,	0, $300
	dc.w $0560,$0720, $900, $C00	; NAT: New check

LBZ1_LayoutModExitRange:
	dc.w $1376,$170A
	dc.w $20F6,$258A
	dc.w $39F6,$3C0A
	dc.w $3D76,$400A
	dc.w $04F6,$078A		; NAT: New check

LBZ1_CollapseScrollSpeed:	dc.w	$1EE, $1F2,	$C7, $1B3, $1B7, $198,	$E, $139

; =============== S U B R O U T I N E =======================================


LBZ1_Deform:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(ScrShake_Offset).w,d1
		sub.w	d1,d0
		asr.w	#4,d0
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#1,d0
		swap	d0
		move.w	d0,(ScrEvents_A).w
		swap	d0
		swap	d1
		move.w	d1,(Camera_X_pos_BG_copy).w
		move.w	d1,(Block_table+$1800).w
		move.w	d1,(Block_table+$1808).w
		swap	d1
		lea	(Block_table+$180A).w,a1
		add.l	d0,d1
		add.l	d0,d1
		asr.l	#2,d0
		moveq	#3,d2

loc_23E79A:
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		add.l	d0,d1
		dbf	d2,loc_23E79A
		moveq	#$A,d0
		add.w	d0,(ScrEvents_A).w
		add.w	d0,(Camera_X_pos_BG_copy).w
		add.w	d0,(Block_table+$1800).w
		add.w	d0,(Block_table+$1808).w
		lea	(Block_table+$180A).w,a1
		addq.w	#4,(a1)+
		subq.w	#2,(a1)+
		addq.w	#7,(a1)
		rts

; ---------------------------------------------------------------------------
LBZ2_BGDeformArray:	dc.w	$C0,	$40,	$38,	$18,	$28,	$10,	$10,	$10
		dc.w	$18,	$40,	$20,	$10,	$20,	$70,	$30,$80E0
		dc.w	$20,$7FFF
LBZ2_DEBGDeformArray:	dc.w	$38,	$18,	$28,	$10,	$10,	$10,	$18,	$40
		dc.w	$38,	$18,	$28,	$10,	$10,	$10,	$18,	$40
		dc.w	$20,	$10,	$20,	$70,	$60,	$10,$805F,$7FFF
LBZ2_CloudDeformArray:	dc.w	$16,	$E,	$A,	$14,	$C,	6,	$18,	$10
		dc.w	$12,	2,	8,	4,	0
LBZ2_BGUWDeformRange:	dc.w 7
		dc.w 1
		dc.w 3
		dc.w 1
		dc.w 7
; ---------------------------------------------------------------------------

Gumball_ScreenInit:
Gumball_ScreenEvent:
Gumball_SetUpVScroll:
Gumball_VScroll:
Gumball_BackgroundInit:
Gumball_BackgroundEvent:
Gumball_Deform:
		rts

AIZ1_ScreenInit:
;		tst.b	OptionsBits.w		; NAT: Check if we need to mod layout
;		bpl.s	.nomod			; if not, branch
;		lea	Level_layout_main+$10.w,a5; get layout address table
;		lea	AIZ1_AltMod(pc),a1	; get alt mod data
;		jsr	LayoutMod_AltLayouts(pc); do alternate layouts

.nomod		jsr	Adjust_AIZ1Chunks(pc)
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)

AIZ1_AltMod:
	dc.b $58, 2-1, $35, $2E
	dc.b $59, 2-1, $00, $35
	dc.b $58, 3-1, $00, $00, $31
	dc.b $57, 4-1, $45, $13, $14, $33
	dc.b $57, 4-1, $87, $1F, $87, $27
	dc.b 0
	even
; ---------------------------------------------------------------------------

AIZ1_ScreenEvent:
		jsr	DrawTilesAsYouMove(pc)
		move.w	(ScrEvents_1).w,d0
		beq.w	locret_4F9BE
		cmpi.w	#$2D30,(Camera_X_pos).w		; perform the tree tile manipulation routine when signalled.
		bhs.w	AIZ1SE_ChangeChunk1
		cmpi.w	#$39,d0
		bhs.w	AIZ1SE_ChangeChunk1
		cmpi.w	#$34,d0
		blo.s	loc_4F93C
		bsr.w	AIZ1SE_ChangeChunk2
		bra.s	loc_4F952
; ---------------------------------------------------------------------------

loc_4F93C:
		cmpi.w	#$24,d0
		blo.s	loc_4F948
		bsr.w	AIZ1SE_ChangeChunk3
		bra.s	loc_4F952
; ---------------------------------------------------------------------------

loc_4F948:
		cmpi.w	#$14,d0
		blo.s	loc_4F952
		bsr.w	AIZ1SE_ChangeChunk4


loc_4F952:

		lea	(AIZ_TreeRevealArray).l,a6
		btst	#0,d0
		bne.s	loc_4F962
		lea	$10(a6),a6

loc_4F962:
		subq.w	#1,d0
		lsr.w	#1,d0
		move.w	d0,(ScrEvents_Routine2).w
		cmpi.w	#3,d0
		blo.s	loc_4F976
		move.w	#2,(ScrEvents_Routine2).w

loc_4F976:
		lsl.w	#4,d0
		neg.w	d0
		addi.w	#$470,d0

loc_4F97E:

		cmp.w	(Camera_Y_pos_rounded).w,d0
		bhs.s	loc_4F994
		lea	$20(a6),a6
		addi.w	#$10,d0
		subq.w	#1,(ScrEvents_Routine2).w
		bpl.s	loc_4F97E
		bra.s	AIZ1SE_ChangeChunk1
; ---------------------------------------------------------------------------

loc_4F994:
		move.w	#$2C80,d1
		moveq	#$10,d6
		move.l	a0,-(sp)
		jsr	Setup_TileRowDraw(pc)
		movea.l	(sp)+,a0
		subi.w	#$280,d0
		moveq	#0,d1
		moveq	#$F,d6
		jsr	(AIZ_TreeReveal).l
		lea	$10(a6),a6
		addi.w	#$290,d0
		subq.w	#1,(ScrEvents_Routine2).w
		bpl.s	loc_4F97E

locret_4F9BE:
		rts
; ---------------------------------------------------------------------------

AIZ1SE_ChangeChunk1:

		clr.w	(ScrEvents_1).w		; When this is run, all chunks have been changed and the routine need not be run anymore
		movea.w	$14(a3),a1
		movea.w	(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)

; =============== S U B R O U T I N E =======================================


AIZ1SE_ChangeChunk2:
		movea.w	$18(a3),a1
		movea.w	4(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)
; End of function AIZ1SE_ChangeChunk2


; =============== S U B R O U T I N E =======================================


AIZ1SE_ChangeChunk3:
		movea.w	$1C(a3),a1
		movea.w	8(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)
; End of function AIZ1SE_ChangeChunk3


; =============== S U B R O U T I N E =======================================


AIZ1SE_ChangeChunk4:
		movea.w	$20(a3),a1
		movea.w	$C(a3),a5
		move.b	(a5),$59(a1)
		move.b	1(a5),$5A(a1)
		rts
; End of function AIZ1SE_ChangeChunk4

; ---------------------------------------------------------------------------

Obj_AIZ1TreeRevealControl:
		tst.w	$2E(a0)
		beq.s	loc_4FA1E
		tst.w	(ScrEvents_1).w
		bne.s	loc_4FA1E
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_4FA1E:

		subq.w	#1,$2E(a0)
		move.w	#$480,d0
		sub.w	(Player_1+y_pos).w,d0
		lsr.w	#3,d0
		addq.w	#3,d0
		cmp.w	(ScrEvents_1).w,d0
		bhs.s	loc_4FA3C
		btst	#0,$2F(a0)
		beq.s	locret_4FA40

loc_4FA3C:
		addq.w	#1,(ScrEvents_1).w

locret_4FA40:
		rts

; =============== S U B R O U T I N E =======================================


Adjust_AIZ1Chunks:
		cmpi.w	#3,(Player_mode).w
		beq.s	Adjust_AIZ1Chunks2			; Make changes to AIZ's chunk data if playing as Knuckles
		rts
; End of function Adjust_AIZ1Chunks


; =============== S U B R O U T I N E =======================================


Adjust_AIZ1Chunks2:

		lea	(Target_palette_line_4+$10).w,a1
		lea	word_4FAE4(pc),a5
		move.l	(a5)+,(a1)+
		move.l	(a5),(a1)
		lea	(Chunk_table+$4C70).l,a1
		bsr.s	sub_4FAD8
		lea	(Chunk_table+$4CF0).l,a1
		bsr.s	sub_4FAD8
		lea	(Chunk_table+$4D70).l,a1
		bsr.s	sub_4FAD8
		lea	(Chunk_table+$52F0).l,a1
		bsr.s	sub_4FAD8
		lea	(Chunk_table+$4980).l,a1
		bsr.s	sub_4FAD8
		lea	(Chunk_table+$4D80).l,a1
		bsr.s	sub_4FAD8
		lea	(Chunk_table+$3420).l,a1
		bsr.s	sub_4FAD8
		move.w	#$402,(a1)+
		moveq	#5,d1
		bsr.s	sub_4FADA
		move.w	#2,(a1)
		lea	(Chunk_table+$3FA0).l,a1
		bsr.s	sub_4FAD8
		addq.w	#4,a1
		move.w	#$C,(a1)+
		move.w	#$406,(a1)+
		move.w	#$4B,(a1)+
		move.w	#$4B,(a1)+
		move.w	#$40A,2(a1)
		lea	(Chunk_table+$5820).l,a1
		move.w	#$40B,(a1)+
		moveq	#5,d1
		bsr.s	sub_4FADA
		addq.w	#6,a1
		move.w	#$C,(a1)+
		move.w	#$406,(a1)+
		moveq	#1,d1
		bra.s	sub_4FADA
; End of function Adjust_AIZ1Chunks2


; =============== S U B R O U T I N E =======================================


sub_4FAD8:

		moveq	#7,d1
; End of function sub_4FAD8


; =============== S U B R O U T I N E =======================================


sub_4FADA:

		moveq	#$4B,d0

loc_4FADC:
		move.w	d0,(a1)+
		dbf	d1,loc_4FADC
		rts
; End of function sub_4FADA

; ---------------------------------------------------------------------------
word_4FAE4:	dc.w   $EE4,  $EA6,  $E62

word_4FAEA:	dc.w $E40
; ---------------------------------------------------------------------------

AIZ1_BackgroundInit:
		cmpi.w	#$1300,(Camera_X_pos).w
		bhs.s	loc_4FB1C
		lea	(Block_table+$1800).w,a1			; Intro deformation
		moveq	#9,d0

loc_4FAFA:
		clr.l	(a1)+
		dbf	d0,loc_4FAFA

loc_4FB00:
		jsr	(AIZ1_IntroDeform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		jsr	Refresh_PlaneFull(pc)

loc_4FB0E:
		lea	(AIZ1_IntroDeformArray).l,a4
		lea	(Block_table+$1828).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_4FB1C:
		move.w	#8,(TrigEvents_Routine).w			; If not in the intro
		jsr	(AIZ1_Deform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		clr.l	(Block_table+$1800).w
		move.w	d2,(Block_table+$1806).w
		lea	(AIZ1_BGDrawArray).l,a4
		lea	(Block_table+$1800).w,a5
		jsr	Refresh_PlaneTileDeform(pc)
		jmp	(AIZ1_ApplyDeformWater).l
; ---------------------------------------------------------------------------

AIZ1_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_4FB50(pc,d0.w)
; ---------------------------------------------------------------------------

loc_4FB50:
		bra.w	AIZ1BGE_Intro
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_NormalRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_FireTransition
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_FireRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ1BGE_Finish
; ---------------------------------------------------------------------------

AIZ1BGE_Intro:
		tst.w	(ScrEvents_2).w
		beq.s	loc_4FBA4
		tst.w	(Kos_decomp_queue_count).w
		bne.w	loc_4FBA4
		clr.w	(ScrEvents_2).w
		jsr	(AIZ1_Deform).l							; Set up normal deformation when intro is over
		jsr	Reset_TileOffsetPositionEff(pc)
		clr.l	(Block_table+$1800).w
		move.w	d2,(Block_table+$1806).w
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w				; Next routine
		bra.s	loc_4FBD0
; ---------------------------------------------------------------------------

loc_4FBA4:

		jsr	(AIZ1_IntroDeform).l
		lea	(AIZ1_IntroDrawArray).l,a4
		lea	(Block_table+$1800).w,a5
		moveq	#$20,d6
		moveq	#$A,d5
		jsr	Draw_BG(pc)
		lea	(AIZ1_IntroDeformArray).l,a4
		lea	(Block_table+$1828).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

AIZ1BGE_NormalRefresh:
		jsr	(AIZ1_Deform).l

loc_4FBD0:
		lea	(AIZ1_BGDrawArray).l,a4
		lea	(Block_table+$17FC).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	Draw_PlaneVertBottomUpComplex(pc)
		bpl.s	loc_4FC08	;loc_4FBF6
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_4FC08		; NAT: Changed routine
; ---------------------------------------------------------------------------

AIZ1BGE_Normal:
		tst.w	(ScrEvents_2).w
		bne.s	AIZ1_AIZ2_Transition		; Wait for signal to start level transition
		jsr	(AIZ1_Deform).l

loc_4FBF6:

		lea	(AIZ1_BGDrawArray).l,a4
		lea	(Block_table+$1800).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	Draw_BG(pc)

loc_4FC08:
		jmp	(AIZ1_ApplyDeformWater).l
; ---------------------------------------------------------------------------

AIZ1_AIZ2_Transition:
		clr.w	(ScrEvents_2).w
		lea	(Normal_palette_line_4+$2).w,a1
		move.l	#$4E006E,(a1)+
		move.l	#$AE00CE,(a1)+
		move.l	#$2EE0AEE,(a1)
		move.l	#$200000,(Camera_Y_pos_BG_copy).w
		move.w	#$10,(Camera_Y_pos_BG_rounded).w
		move.w	#$68,(ScrEvents_Routine2).w
		move.w	#4,(Special_V_int_routine).w
		addq.w	#4,(TrigEvents_Routine).w

		move.l	#Ranges_AIZ2,d0
		move.l	d0,BoxLoc_Level.w
		move.l	d0,BoxLoc_Play1.w
		move.l	d0,BoxLoc_Play2.w
		move.w	#Boxes_AIZ2-Ranges_AIZ2,SpawnBoxPos.w

AIZ1BGE_FireTransition:
		tst.w	(ScrEvents_3).w
		bne.s	loc_4FC6E
		move.w	(ScrEvents_Routine2).w,d0
		swap	d0
		clr.w	d0
		sub.l	(Camera_Y_pos_BG_copy).w,d0
		asr.l	#5,d0
		add.l	d0,(Camera_Y_pos_BG_copy).w
		cmpi.l	#$1400,d0
		bhs.s	loc_4FC74

loc_4FC6E:
		jsr	(AIZ1_FireRise).l

loc_4FC74:

		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$1000,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		cmpi.w	#$190,(Camera_Y_pos_BG_copy).w
		blo.w	loc_4FD22
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(AIZ2_128x128_Kos).l,a1
		lea	(RAM_start).l,a2
		jsr	Queue_Kos.w
		lea	(AIZ2_16x16_Primary_Kos).l,a1
		lea	(Block_table).w,a2
		jsr	Queue_Kos.w
		lea	(AIZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$AB8).w,a2
		jsr	Queue_Kos.w
		lea	(AIZ2_8x8_Primary_KosM).l,a1
		move.w	#0,d2
		jsr	Queue_Kos_Module.w
		lea	(AIZ2_8x8_Secondary_KosM).l,a1
		move.w	#$3F80,d2
		jsr	Queue_Kos_Module.w
		lea	(PLC_SpikesSprings).l,a1
		jsr	Load_PLC_Raw.w

loc_4FCF2:
		movem.l	(sp)+,d7-a0/a2-a3
		jsr	Create_New_Sprite.w
		bne.s	loc_4FD10
		move.l	#Obj_AIZTransitionFloor,(a1)
		move.w	#$2FB0,$10(a1)

loc_4FD0A:
		move.w	#$3A0,$14(a1)

loc_4FD10:
		move.w	#$F0,(DrawDelayed_Position).w

loc_4FD16:
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_4FD32
; ---------------------------------------------------------------------------

loc_4FD22:
		jsr	(AIZTrans_WavyFlame).l
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

AIZ1BGE_FireRefresh:
		jsr	(AIZ1_FireRise).l

loc_4FD32:
		lea	(Level_layout_main).w,a3
		move.w	#$C000,d7
		move.w	#$180,d1
		moveq	#0,d2
		jsr	Draw_PlaneVertBottomUp(pc)	; Refresh main plane
		bpl.s	loc_4FD52
		addq.w	#2,a3
		move.w	#$E000,d7
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_4FD62
; ---------------------------------------------------------------------------

loc_4FD52:
		jsr	(AIZTrans_WavyFlame).l
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

AIZ1BGE_Finish:
		jsr	(AIZ1_FireRise).l

loc_4FD62:
		tst.b	(Kos_modules_left).w
		bne.w	loc_4FE2E		; Wait for the art to be loaded
;		cmp.w	#$80,Camera_X_Pos.w
		move.w	#1,(Current_zone_and_act).w	; Officially change this to act 2
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(NoReset_RespawnTbl).w
		jsr	Clear_Switches.w
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l
		moveq	#$B,d0
		jsr	LoadPalette_Immediate.w
		movem.l	(sp)+,d7-a0/a2-a3
		jsr	Adjust_AIZ2Layout(pc)
		lea	(Normal_palette_line_4+$2).w,a1
		move.l	#$4E006E,(a1)+
		move.l	#$AE00CE,(a1)+
		move.l	#$2EE0AEE,(a1)
		move.w	#$2F00,d0
		move.w	#$80,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w
		jsr	Offset_SomeObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w		; Offset objects and camera positions
		move.l	#$100010,d0
		move.l	d0,(Camera_min_X_pos).w
		move.l	#$260,d0
		move.l	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	(Camera_X_pos_copy).w,(ScrEvents_0).w
		move.w	(Camera_X_pos_copy).w,(__u_EEB6).w
		jsr	Reset_TileOffsetPositionActual(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		clr.w	(TrigEvents_Routine).w

loc_4FE2E:
		jsr	(AIZTrans_WavyFlame).l
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

Obj_AIZTransitionFloor:
		tst.b	(Current_act).w
		beq.s	loc_4FE4A
		move.w	#$7FFF,$10(a0)
		move.l	#Delete_Current_Sprite,(a0)

loc_4FE4A:
		move.b	#$10,6(a0)
		bset	#7,$2A(a0)
		move.w	#$A0,d1
		moveq	#$10,d2
		moveq	#$10,d3
		move.w	$10(a0),d4
		jmp	SolidObjectTop.w

; =============== S U B R O U T I N E =======================================


Adjust_AIZ2Layout:

		cmpi.w	#3,(Player_mode).w
		bne.s	loc_4FECC
		move.w	#$5B,(Chunk_table+$1020).l		; Only do this if playing as Knuckles
		lea	(Chunk_table+$3420).l,a1
		moveq	#7,d1
		bsr.s	sub_4FF00
		move.w	#$CAE,(a1)+
		moveq	#5,d1
		bsr.s	sub_4FF00
		move.w	#$8AE,(a1)
		lea	(Chunk_table+$3FA0).l,a1
		moveq	#7,d1
		bsr.s	sub_4FF00
		addq.w	#4,a1
		move.w	#$4B6,(a1)+
		move.w	#$4CC,(a1)+
		move.w	#$5B,(a1)+
		move.w	#$5B,(a1)+
		move.w	#$4B7,2(a1)
		lea	(Chunk_table+$5822).l,a1
		moveq	#5,d1
		bsr.s	sub_4FF00
		addq.w	#6,a1
		move.w	#$4B6,(a1)+
		move.w	#$4CC,(a1)+
		move.w	#$5B,(a1)+
		move.w	#$5B,(a1)

loc_4FECC:
		movea.w	(Level_layout_main+$C).w,a1
		movea.w	(Level_layout_main+$40).w,a5
		move.b	$7F(a1),$63(a5)
		movea.w	(Level_layout_main+$A).w,a1
		movea.w	(Level_layout_main+$1E).w,a5
		bsr.s	sub_4FEF6
		movea.w	(Level_layout_main+$E).w,a1
		movea.w	(Level_layout_main+$22).w,a5
		bsr.s	sub_4FEF6
		movea.w	(Level_layout_main+$12).w,a1
		movea.w	(Level_layout_main+$26).w,a5
; End of function Adjust_AIZ2Layout


; =============== S U B R O U T I N E =======================================


sub_4FEF6:

		moveq	#3,d0

loc_4FEF8:
		move.b	(a1)+,(a5)+
		dbf	d0,loc_4FEF8
		rts
; End of function sub_4FEF6


; =============== S U B R O U T I N E =======================================


sub_4FF00:

		moveq	#$5B,d0

loc_4FF02:
		move.w	d0,(a1)+
		dbf	d1,loc_4FF02
		rts
; End of function sub_4FF00
; ---------------------------------------------------------------------------

LayoutMod_AltLayouts_Do:	; NAT: Custom routine
		move.w	(a5)+,a0		; get layout row addr
		add.w	d0,a0			; offset by amount
		addq.w	#2,a5			; skip BG chunk

		move.b	(a1)+,d0		; get repeat count
.replace	move.b	(a1)+,(a0)+		; copy next byte
		dbf	d0,.replace		; loop til done

LayoutMod_AltLayouts:
		moveq	#0,d0
		move.b	(a1)+,d0		; get offset to d0
		bne.s	LayoutMod_AltLayouts_Do	; if nonzero, branch
		lea	Plane_Buffer.w,a0	; put plane buffer back to a0
		rts
; ---------------------------------------------------------------------------

AIZ2_ScreenInit:
		jsr	Adjust_AIZ2Layout(pc)
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

AIZ2_ScreenEvent:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(ScrEvents_Routine).w,d0
		jmp	loc_4FF26(pc,d0.w)
; ---------------------------------------------------------------------------

loc_4FF26:
		bra.w	AIZ2SE_Normal
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_ShipRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_ShipDraw
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_EndRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ2SE_End
; ---------------------------------------------------------------------------

AIZ2_DrawTilesAsYouMove:
		jmp	DrawTilesAsYouMove(pc)

AIZ2SE_Normal:
		tst.w	(ScrEvents_1).w
		beq.s	AIZ2_DrawTilesAsYouMove		; Keep drawing as usual while flag isn't set
		clr.w	(ScrEvents_1).w
		move.w	#$180,(DrawDelayed_Position).w		; Set up redraw memory
		move.w	#5,(DrawDelayed_RowCount).w
		clr.l	(Block_table+$19F8).w
		move.w	(Camera_X_pos_copy).w,d0
		andi.w	#-$10,d0
		subi.w	#$10,d0
		move.w	d0,(Block_table+$19FE).w
		st	(Scroll_lock).w				; Camera doesn't follow Sonic
		move.w	#4,(Special_Events_Routine).w
		addq.w	#4,(ScrEvents_Routine).w		; Set speed of automatic movement

AIZ2SE_ShipRefresh:
		move.w	#$4380,d1
		move.w	(Camera_Y_pos_copy).w,d2
		subi.w	#$10,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	loc_4FFF0
		move.w	#$4020,d0
		move.w	d0,(Block_table+$19F6).w
		move.w	d0,(__u_EE98).w
		clr.w	(__u_EE9A).w			; Set up secondary BG camera X
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$8F0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(__u_EE9C).w
		move.w	d0,(__u_EEA2).w		; Set up secondary BG camera Y
		jsr	Create_New_Sprite.w
		bne.s	loc_4FFBA
		move.l	#Obj_AIZBattleship,(a1)	; Star battleship sequence

loc_4FFBA:
		st	(ScrEvents_4).w
		move.l	#HInt6,(H_int_addr).w	; HInt is needed to change Y scroll value to proper amount mid-draw
		clr.b	(Water_flag).w
		move.b	#$40,(H_int_counter).w		; Set HInt position
		addq.w	#4,(ScrEvents_Routine).w

AIZ2SE_ShipDraw:
		tst.w	(ScrEvents_1).w
		bne.s	loc_50008				; Branch when battleship has gone off-screen
		lea	AIZ2SE_BGShipDrawArray2(pc),a4
		lea	(Block_table+$19F4).w,a6
		move.w	(__u_EE98).w,(a6)
		moveq	#2,d5
		move.w	(__u_EEA2).w,d6
		jsr	Draw_BGNoVert(pc)

loc_4FFF0:
		lea	AIZ2SE_BGShipDrawArray1(pc),a4
		lea	(Block_table+$19F8).w,a6
		move.w	(Camera_X_pos_copy).w,4(a6)
		moveq	#2,d5
		move.w	(Camera_Y_pos_rounded).w,d6

loc_50004:
		jmp	Draw_BGNoVert(pc)
; ---------------------------------------------------------------------------

loc_50008:
		clr.w	(ScrEvents_1).w

loc_5000C:
		move.w	#$170,(DrawDelayed_Position).w
		move.w	#4,(DrawDelayed_RowCount).w		;Set redraw memory

loc_50018:
		addq.w	#4,(ScrEvents_Routine).w

AIZ2SE_EndRefresh:
		move.w	#$4380,d1
		move.w	(Camera_Y_pos_copy).w,d2
		subi.w	#$10,d2

loc_50028:
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_4FFF0
		move.w	(Camera_X_pos_copy).w,d0
		andi.w	#-$10,d0

loc_50036:
		subi.w	#$10,d0
		move.w	d0,(Camera_X_pos_rounded).w
		move.w	#$46C0,(ScrEvents_3).w		; Set level X start to 46C0
		clr.w	(ScrEvents_4).w
		move.b	#-1,(H_int_counter).w
		addq.w	#4,(ScrEvents_Routine).w

AIZ2SE_End:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

HInt6:

		move.w	#$8AFF,(VDP_control_port).l
		move.l	#$40000010,(VDP_control_port).l
		move.w	(Camera_Y_pos_copy).w,(VDP_data_port).l
		rte
; ---------------------------------------------------------------------------
AIZ2SE_BGShipDrawArray1:
		dc.w $180
		dc.w $7FFF
AIZ2SE_BGShipDrawArray2:
		dc.w $A80
		dc.w $7FFF
; ---------------------------------------------------------------------------

AIZ2_BackgroundInit:
		move.w	(Camera_X_pos_copy).w,(ScrEvents_0).w
		move.w	(Camera_X_pos_copy).w,(__u_EEB6).w
		move.w	#$C,(TrigEvents_Routine).w
		cmpi.w	#$3E80,(Camera_X_pos).w
		blo.s	loc_500A0
		move.w	#$14,(TrigEvents_Routine).w
		move.w	#$4440,(ScrEvents_3).w

loc_500A0:
		jsr	(AIZ2_Deform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		jmp	(AIZ2_ApplyDeform).l
; ---------------------------------------------------------------------------

AIZ2_BackgroundEvent:
		lea	(ScrEvents_0).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		move.w	#$100,d2
		move.w	#$200,d3
		jsr	Adjust_BGDuringLoop(pc)
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_500D2(pc,d0.w)
; ---------------------------------------------------------------------------

loc_500D2:
		bra.w	AIZ2BGE_FireRedraw
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_WaitFire
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_BGRedraw
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_ShipRefresh
; ---------------------------------------------------------------------------
		bra.w	AIZ2BGE_ShipMove
; ---------------------------------------------------------------------------

AIZ2BGE_FireRedraw:
		lea	(Level_layout_main).w,a3
		move.w	#$C000,d7
		move.w	(Camera_X_pos_copy).w,d1
		move.w	(Camera_Y_pos_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bmi.s	loc_50110
		jsr	(AIZ1_FireRise).l
		jsr	(AIZTrans_WavyFlame).l
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_50110:
		addq.w	#2,a3
		move.w	#-$2000,d7
		clr.w	(ScrEvents_Routine2).w
		addq.w	#4,(TrigEvents_Routine).w

AIZ2BGE_WaitFire:
		jsr	(AIZ1_FireRise).l
		jsr	(AIZTrans_WavyFlame).l
		tst.w	(ScrEvents_Routine2).w
		bne.s	loc_50160
		move.w	(Camera_Y_pos_BG_copy).w,d0
		andi.w	#$7F,d0
		cmpi.w	#$20,d0
		blo.s	loc_50144
		cmpi.w	#$30,d0
		blo.s	loc_50148

loc_50144:
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_50148:
		addi.w	#$180,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		and.w	(Camera_Y_pos_mask).w,d0
		subi.w	#$10,d0
		move.w	d0,(Camera_Y_pos_BG_rounded).w
		st	(ScrEvents_Routine2).w

loc_50160:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$200,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		cmpi.w	#$310,(Camera_Y_pos_BG_copy).w
		blo.s	loc_501D6			; If fire hasn't subsided, branch
		movem.l	d7-a0/a2-a3,-(sp)
		moveq	#$C,d0
		jsr	Load_PLC.w
		jsr	(LoadEnemyArt).l
		movem.l	(sp)+,d7-a0/a2-a3
		lea	(Normal_palette_line_4+$2).w,a1
		move.l	#$8EE00AA,(a1)+
		move.l	#$8E004E,(a1)+
		move.l	#$2E000C,(a1)
		move.w	#$6000,d0
		move.w	d0,(Camera_max_X_pos).w
		jsr	(AIZ2_Deform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w		; Set up Effective BG Y location for screen redraw
		move.w	#$F,(DrawDelayed_RowCount).w		; Set up redraw count
		move.w	#$C,(Special_V_int_routine).w
		addq.w	#4,(TrigEvents_Routine).w
		clr.b	MonContPos.w		; NAT: put normal monitor mode
		bra.s	loc_50204
; ---------------------------------------------------------------------------

loc_501D6:
		jsr	(AIZ2_ApplyDeform).l
		lea	(H_scroll_buffer+2).w,a1
		move.w	(Camera_X_pos_BG_copy).w,d0	; Cancel out background deformation since we're still in the open field
		neg.w	d0
		moveq	#$37,d1

loc_501E8:
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		dbf	d1,loc_501E8
		rts
; ---------------------------------------------------------------------------

AIZ2BGE_BGRedraw:
		jsr	(AIZ2_Deform).l

loc_50204:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_50270		; NAT: Change lable
		addq.w	#4,(TrigEvents_Routine).w

		jsr	Boss_DisableHitMode.l		; NAT: Disable hit mode
		bra.s	loc_50270
; ---------------------------------------------------------------------------

AIZ2BGE_Normal:
		jsr	(AIZ2_Deform).l
		tst.w	(ScrEvents_2).w
		beq.s	loc_50260
		clr.w	(ScrEvents_2).w
		move.w	#$A8,d0
		cmpi.w	#$400,(Camera_Y_pos).w
		blo.s	loc_50236
		move.w	#-$198,d0

loc_50236:
		move.w	d0,(ScrEvents_D).w
		add.w	d0,(Camera_Y_pos_BG_copy).w
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		move.w	#$4440,(ScrEvents_3).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_50280
; ---------------------------------------------------------------------------

loc_50260:

		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)

loc_50270:
		jsr	(AIZ2_ApplyDeform).l
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

AIZ2BGE_ShipRefresh:
		jsr	(AIZ2_Deform).l

loc_50280:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_502A8		; NAT: Change lable
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_502A8
; ---------------------------------------------------------------------------

AIZ2BGE_ShipMove:
		jsr	(AIZ2_Deform).l

loc_50298:

		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)

loc_502A8:
		jsr	(AIZ2_ApplyDeform).l
		tst.w	(ScrEvents_4).w
		beq.s	loc_502C2
		move.w	(__u_EE9C).w,(V_scroll_value).w		; Use effective camera position rather than actual camera position
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp		; Skip last part of ScreenEvents

loc_502C2:
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

AIZ2_DoShipLoop:
		clr.w	(Displace_Obj_X).w
		move.w	(Camera_X_pos).w,d0
		addq.w	#4,d0
		cmp.w	(ScrEvents_3).w,d0
		blo.s	loc_502FA
		move.w	#$200,d1			; Do loop
		move.w	d1,(Displace_Obj_X).w
		sub.w	d1,(Player_1+x_pos).w
		sub.w	d1,(Player_2+x_pos).w	; Subtract $200 from X position of Sonic and Tails
		sub.w	d1,d0
		move.w	d0,d1
		andi.w	#-$10,d1
		subi.w	#$10,d1
		move.w	d1,(Camera_X_pos_rounded).w
		move.w	d1,(Block_table+$19FE).w

loc_502FA:
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w	; Set all the camera/start positions
		move.w	d0,d1
		lea	(Player_1).w,a1
		bsr.s	sub_50318
		move.w	d1,d0
		lea	(Player_2).w,a1

; =============== S U B R O U T I N E =======================================


sub_50318:
		cmpi.b	#5,$20(a1)
		bne.s	loc_50324
		clr.b	$20(a1)				; If Sonic is standing set him to the running animation

loc_50324:
		addi.w	#$18,d0
		cmp.w	$10(a1),d0
		bls.s	loc_5033A
		move.w	d0,$10(a1)			; Make sure Sonic stays on-screen
		move.w	#$400,$1C(a1)		; Set his running velocity to $400 if the left of screen is hit
		bra.s	locret_50348
; ---------------------------------------------------------------------------

loc_5033A:
		addi.w	#$88,d0
		cmp.w	$10(a1),d0
		bhi.s	locret_50348
		move.w	d0,$10(a1)			; Make sure Sonic can't go past a certain point to the right

locret_50348:

		rts

; ---------------------------------------------------------------------------

Obj_AIZBattleship:
		move.l	#Obj_AIZBattleshipMain,(a0)
		move.l	#AIZBattleship_BombScript,$2E(a0)
		move.w	#$1A4,$32(a0)
		move.w	#$3FBC,d1
		moveq	#1,d2

loc_50364:
		jsr	Create_New_Sprite3.w
		bne.s	loc_5037E
		move.l	#Obj_BattleshipPropeller,(a1)	; Create two propellers, one at the front and one in the back
		move.w	d1,$2E(a1)
		move.w	#$3DCC,d1
		dbf	d2,loc_50364

loc_5037E:
		lea	(Normal_palette_line_2).w,a1
		lea	(Pal_AIZBattleship).l,a5
		moveq	#7,d0

loc_5038A:
		move.l	(a5)+,(a1)+
		dbf	d0,loc_5038A

Obj_AIZBattleshipMain:
		subi.l	#$8800,(__u_EE98).w
		move.w	(__u_EE98).w,d0
		cmpi.w	#$3CDC,d0
		bpl.s	loc_503BC
		move.l	#Obj_AIZ2BossSmall,(a0)
		st	(ScrEvents_1).w				; Set for the next screen event
		jsr	Create_New_Sprite3.w
		bne.s	locret_503BA
		move.l	#Obj_AIZ2MakeTree,(a1)

locret_503BA:
		rts
; ---------------------------------------------------------------------------

loc_503BC:
		move.w	d0,d1
		subi.w	#$3D5C,d0
		bpl.s	loc_503D2
		neg.w	d0					; Move upwards as the battleship goes offscreen
		asr.w	#1,d0
		add.w	(__u_EEA2).w,d0
		move.w	d0,(__u_EE9C).w
		bra.s	loc_503EA
; ---------------------------------------------------------------------------

loc_503D2:
		asr.w	#2,d1			; Continue bobbing up and down
		andi.w	#$F,d1
		lea	(AIZBattleShip_BobbingMotion).l,a1
		move.b	(a1,d1.w),d1
		add.w	(__u_EEA2).w,d1
		move.w	d1,(__u_EE9C).w	; Get the bobbing motion delta, apply it to the second camera Y

loc_503EA:
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_503FE
		moveq	#-$43,d0			; Replay the battleship flying sound every 16th frame
		jsr	Play_Sound_2.w

loc_503FE:
		subq.w	#1,$32(a0)			; Wait for delay to finish
		bcc.s	locret_50424
		movea.l	$2E(a0),a2
		move.w	(a2)+,$32(a0)		; Get the first word of the bomb script as the new delay
		bmi.s	locret_50424
		jsr	Create_New_Sprite3.w
		bne.s	locret_50424
		move.l	#Obj_AIZShipBomb,(a1)		; Create a new bomb
		move.w	(a2)+,$2E(a1)		; Put the X position into $2E so it can be translated
		move.l	a2,$2E(a0)			; Update the script position

locret_50424:

		rts
; ---------------------------------------------------------------------------

Obj_BattleshipPropeller:
		move.l	#Obj_BattleshipPropellerMain,(a0)
		move.b	#4,4(a0)
		move.b	#$20,6(a0)
		move.b	#8,7(a0)
		move.w	#prio(1),8(a0)
		move.w	#$500,$A(a0)
		move.l	#Map_AIZShipPropeller,$C(a0)
		move.w	#$A71,$30(a0)

Obj_BattleshipPropellerMain:
		cmpi.w	#$C,(ScrEvents_Routine).w
		bne.s	loc_50466
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_50466:
		lea	(Ani_AIZShipPropeller).l,a1
		jsr	Animate_Sprite.w
		jsr	Translate_Camera2ObjPosition(pc)
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Obj_AIZShipBomb:
		move.l	#Obj_AIZShipBombMain,(a0)
		move.b	#4,4(a0)
		move.b	#$18,7(a0)
		move.w	#prio(1),8(a0)
		move.w	#$500,$A(a0)
		move.l	#Map_AIZ2BombExplode,$C(a0)
		move.b	#$10,$1E(a0)
		move.w	#$A60,$30(a0)
		move.w	#6,$32(a0)

Obj_AIZShipBombMain:
		moveq	#0,d0
		move.b	5(a0),d0
		jmp	loc_504BE(pc,d0.w)
; ---------------------------------------------------------------------------

loc_504BE:
		bra.w	AIZShipBomb_ReadyDrop
; ---------------------------------------------------------------------------
		bra.w	AIZShipBomb_Delay
; ---------------------------------------------------------------------------
		bra.w	AIZShipBomb_Drop
; ---------------------------------------------------------------------------

AIZShipBomb_ReadyDrop:
		addq.w	#2,$30(a0)
		cmpi.w	#$A80,$30(a0)		; Put bomb into position before delay
		blo.s	loc_504EE
		addq.b	#4,5(a0)
		bra.s	loc_504EE
; ---------------------------------------------------------------------------

AIZShipBomb_Delay:
		subq.w	#1,$32(a0)
		bne.s	loc_504EE
		addq.b	#4,5(a0)
		moveq	#$51,d0
		jsr	Play_Sound_2.w		; Play the drop sound after the delay

loc_504EE:

		jsr	Translate_Camera2ObjPosition(pc)
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

AIZShipBomb_Drop:
		move.l	$14(a0),d0
		add.l	$1A(a0),d0
		move.l	d0,$14(a0)			; Drop bomb downwards

loc_50504:
		addi.l	#$2000,$1A(a0)		; Increase acceleration
		swap	d0
		jsr	Translate_Camera2ObjX(pc)
		jsr	Draw_Sprite.w
		jsr	ObjCheckFloorDist.w
		cmpi.w	#-8,d1
		bgt.s	locret_50578
		move.w	#$10,(ScrShake_Value).w	; If touching the floor, set up a timed screen shake
		moveq	#$4E,d0
		jsr	Play_Sound_2.w		; Play the bomb explosion sound
		jsr	Create_New_Sprite3.w
		bne.s	loc_50572
		lea	(AIZBombExplodeDat).l,a2
		moveq	#7,d1

loc_50542:
		move.l	#Obj_AIZBombExplosion,(a1)
		move.w	$10(a0),$10(a1)
		move.w	$14(a0),$14(a1)
		move.w	(a2)+,d2
		add.w	d2,$10(a1)
		move.w	(a2)+,d2
		add.w	d2,$14(a1)
		move.w	(a2)+,$20(a1)
		move.w	(a2)+,$2E(a1)
		jsr	(CreateNewSprite4).l
		dbne	d1,loc_50542

loc_50572:
		move.l	#Delete_Current_Sprite,(a0)		; Delete the bomb sprite

locret_50578:
		rts

; =============== S U B R O U T I N E =======================================


Translate_Camera2ObjPosition:

		move.w	$30(a0),d0
		sub.w	(__u_EE9C).w,d0
		add.w	(Camera_Y_pos_copy).w,d0

Translate_Camera2ObjX:
		sub.w	(ScrShake_Offset_Prev).w,d0
		add.w	(ScrShake_Offset).w,d0
		move.w	d0,$14(a0)
		move.w	$2E(a0),d0
		sub.w	(__u_EE98).w,d0
		add.w	(Camera_X_pos_copy).w,d0
		move.w	d0,$10(a0)
		rts
; End of function Translate_Camera2ObjPosition

; ---------------------------------------------------------------------------

Obj_AIZBombExplosion:
		move.w	(Displace_Obj_X).w,d0
		sub.w	d0,$10(a0)
		subq.w	#1,$2E(a0)
		bmi.s	loc_505B4
		rts
; ---------------------------------------------------------------------------

loc_505B4:
		move.l	#Obj_AIZBombExplosionAnim,(a0)
		move.b	#4,4(a0)
		move.b	#$20,7(a0)
		move.w	#$500,$A(a0)
		move.l	#Map_AIZ2BombExplode,$C(a0)
		move.b	#-$75,$28(a0)
		bra.s	loc_505E4
; ---------------------------------------------------------------------------

Obj_AIZBombExplosionAnim:
		move.w	(Displace_Obj_X).w,d0
		sub.w	d0,$10(a0)

loc_505E4:
		lea	(Ani_AIZ2BombExplode).l,a1
		jsr	Animate_SpriteIrregularDelay.w
		tst.b	5(a0)
		beq.s	loc_505FC
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_505FC:
		moveq	#4,d0
		add.b	$20(a0),d0
		cmp.b	$22(a0),d0
		bls.s	loc_5060E
		jsr	Add_SpriteToCollisionResponseList.w

loc_5060E:
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Obj_AIZ2MakeTree:
		cmpi.w	#$44D0,(Camera_X_pos).w
		bhs.s	loc_5061E
		rts
; ---------------------------------------------------------------------------

loc_5061E:
		move.l	#loc_50632,(a0)
		move.w	(__u_EEB6).w,$2E(a0)
		move.l	#AIZMakeTreeScript,$30(a0)

loc_50632:
		movea.l	$30(a0),a2
		tst.w	(a2)
		bpl.s	loc_50640
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_50640:
		move.w	(__u_EEB6).w,d0
		sub.w	$2E(a0),d0
		cmp.w	(a2)+,d0
		blo.s	locret_50662
		jsr	Create_New_Sprite3.w
		bne.s	locret_50662
		move.l	#Obj_AIZ2BGTree,(a1)
		move.w	(a2)+,8(a1)
		move.l	a2,$30(a0)

locret_50662:

		rts
; ---------------------------------------------------------------------------

Obj_AIZ2BGTree:
		move.l	#Obj_AIZ2BGTreeMove,(a0)
		move.w	#$438,$A(a0)
		move.l	#Map_AIZ2BGTree,$C(a0)
		move.w	#$E9,$14(a0)
		move.w	#$1C0,$2E(a0)
		move.w	(__u_EEB6).w,$30(a0)

Obj_AIZ2BGTreeMove:
		cmpi.w	#$4880,(Camera_X_pos).w
		blo.s	loc_50698
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_50698:
		move.w	(__u_EEB6).w,d0
		sub.w	$30(a0),d0
		move.w	d0,d1
		asr.w	#2,d0
		sub.w	d0,d1
		move.w	$2E(a0),d0
		sub.w	d1,d0
		move.w	d0,$10(a0)
		cmpi.w	#$1C0,d0
		bhs.s	locret_506BC
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

locret_506BC:
		rts
; ---------------------------------------------------------------------------

Obj_AIZ2BossSmall:
		move.l	#Obj_AIZ2BossSmallMain,(a0)
		move.w	#prio(6),8(a0)
		move.w	#$500,$A(a0)
		move.l	#Map_AIZ2BossSmall,$C(a0)
		move.w	#$30,$10(a0)
		move.w	#$D8,$14(a0)
		move.w	#5,$18(a0)
		clr.w	$2E(a0)
		lea	(Normal_palette_line_2+$2).w,a1
		lea	(Pal_AIZBossSmall).l,a5
		moveq	#6,d0

loc_506FA:
		move.l	(a5)+,(a1)+
		dbf	d0,loc_506FA

Obj_AIZ2BossSmallMain:
		tst.b	$2E(a0)
		bne.s	loc_50712
		cmpi.w	#$4670,(Camera_X_pos).w
		blo.s	locret_5077C
		st	$2E(a0)

loc_50712:
		cmpi.w	#$240,$10(a0)
		blo.s	loc_50732
		clr.b	(Scroll_lock).w
		clr.w	(Special_Events_Routine).w
		clr.w	(Displace_Obj_X).w			; Stop repeating scrolling section
		move.w	#$6000,(Camera_max_X_pos).w	; Change level size
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_50732:
		move.l	$10(a0),d0
		move.l	$18(a0),d1		; Move Robotnik
		add.l	d1,d0
		move.l	d0,$10(a0)
		tst.b	$2F(a0)
		bne.s	loc_50758
		subi.l	#$E80,d1		; Phase 1: Slow down until moving slightly to the left
		cmpi.l	#-$10000,d1
		sle	$2F(a0)
		bra.s	loc_5075E
; ---------------------------------------------------------------------------

loc_50758:
		addi.l	#$E80,d1		; Phase 2: Speed up till moving off screen

loc_5075E:
		move.l	d1,$18(a0)
		jsr	Draw_Sprite.w
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	locret_5077C
		moveq	#-$42,d0		; Every sixteenth frame, play alarm sound
		jmp	Play_Sound_2.w

locret_5077C:

		rts
; ---------------------------------------------------------------------------
word_5077E:	dc.w 0

		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w 1
		dc.w 1
		dc.w 0
		dc.w 0
		dc.w $FFFE
		dc.w 1
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w 2
		dc.w 2
		dc.w 1
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w $FFFF
		dc.w $FFFF
		dc.w $FFFF
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w 2
		dc.w 2
		dc.w 1
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w $FFFF
		dc.w $FFFF
		dc.w $FFFF
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w 2
		dc.w 2
		dc.w 1
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w $FFFF
		dc.w $FFFF
		dc.w $FFFF
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w 2
		dc.w 2
		dc.w 1
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w $FFFF
		dc.w $FFFF
		dc.w $FFFF
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w 2
		dc.w 2
		dc.w 1
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w $FFFF
		dc.w $FFFF
		dc.w $FFFF
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w 2
		dc.w 2
		dc.w 1
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w $FFFF
		dc.w $FFFF
		dc.w $FFFF
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w 2
		dc.w 2
		dc.w 1
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w $FFFF
		dc.w $FFFF
		dc.w $FFFF
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w 2
		dc.w 2
		dc.w 1
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
		dc.w $FFFE
		dc.w $FFFE
		dc.w 1
		dc.w $FFFF
		dc.w $FFFF
		dc.w $FFFF
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w 0
		dc.w 0
		dc.w $FFFE
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 0
		dc.w $FFFE
		dc.w 2
		dc.w 2
		dc.w $FFFF
		dc.w $FFFE
; ---------------------------------------------------------------------------

HCZ1_ScreenInit:
		clr.w	(ScrEvents_D).w
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

HCZ1_ScreenEvent:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

HCZ1_BackgroundInit:
		jsr	HCZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		moveq	#$60,d0
		cmp.w	(ScrEvents_A).w,d0
		blt.s	loc_50BAC
		neg.w	d0
		cmp.w	(ScrEvents_A).w,d0
		bgt.s	loc_50BB0

loc_50BAC:
		move.w	d0,(ScrEvents_A).w		; Cap dynamic art reloading value at $60 either way

loc_50BB0:
		lea	(HCZ1_BGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

HCZ1_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_50BC6(pc,d0.w)
; ---------------------------------------------------------------------------

loc_50BC6:
		bra.w	HCZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	HCZ1BGE_DoTransition
; ---------------------------------------------------------------------------

HCZ1BGE_Normal:
		tst.w	(ScrEvents_2).w
		beq.s	loc_50C2A
		clr.w	(ScrEvents_2).w				; Do transition
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(HCZ2_128x128_Secondary_Kos).l,a1
		lea	(Chunk_table+$A00).l,a2
		jsr	Queue_Kos.w
		lea	(HCZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$558).w,a2
		jsr	Queue_Kos.w
		lea	(HCZ2_8x8_Secondary_KosM).l,a1	; Load secondary HCZ2 art, blocks, and chunks so as to not compromise current position
		move.w	#$2360,d2
		jsr	Queue_Kos_Module.w
		moveq	#$10,d0
		jsr	Load_PLC.w
		moveq	#$11,d0
		jsr	Load_PLC.w			; load HCZ 2 PLCs
		movem.l	(sp)+,d7-a0/a2-a3
		st	(ScrEvents_D).w
		addq.w	#4,(TrigEvents_Routine).w

loc_50C2A:
		jsr	HCZ1_Deform(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	(HCZ1_BGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

HCZ1BGE_DoTransition:
		tst.b	(Kos_modules_left).w
		bne.w	loc_50CDC			; Don't do anything else until kos queue has been cleared
		move.w	#$101,(Current_zone_and_act).w	; Change the act
		clr.b	(Dynamic_resize_routine).w		; Reload resize routine counter
		clr.b	(Object_load_routine).w		; Reload sprite manager
		clr.b	(Rings_manager_routine).w		; Reload ring manager
		clr.b	(Boss_flag).w		; Unlock the screen
		clr.b	(NoReset_RespawnTbl).w		; Refresh sprite/ring memory
		jsr	Clear_Switches.w
		move.l	#Obj_HCZWaterSplash,(Dynamic_object_RAM+$94).w	; Load the splash object
		move.b	#1,(Dynamic_object_RAM+$C0).w
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l				; Load HCZ2 layout
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l
		move.w	#$6A0,d0
		move.w	d0,(Water_level).w
		move.w	d0,(Mean_water_level).w
		move.w	d0,(Target_water_level).w	; Set the water up
		moveq	#$D,d0
		jsr	LoadPalette_Immediate.w	; Load HCZ2 palette
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$3600,d0
		moveq	#0,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w		; Offset objects/camera position by specified amount
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.w	(TrigEvents_Routine).w

loc_50CDC:
		jsr	HCZ1_Deform(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	(HCZ1_BGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)

; =============== S U B R O U T I N E =======================================


HCZ1_Deform:

		move.w	(Camera_Y_pos_copy).w,d0		; Get the BG camera Y position
		subi.w	#$610,d0				; Get the difference between that and the water line equilibrium point
		move.w	d0,d1
		asr.w	#2,d0
		move.w	d0,d2
		addi.w	#$190,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w		; The effective BG Y is negative when the BG is above the water line, positive when otherwise
		sub.w	d1,d2					; The difference between the effective BG Y and the actual BG Y difference is what's used to calculate how the water line should be drawn
		move.w	d2,(ScrEvents_A).w
		move.w	(Camera_X_pos_copy).w,d0		; Get the camera BG X
		swap	d0
		clr.w	d0
		tst.w	d2
		beq.w	loc_50DDA		; If equilibrium point, branch
		move.l	d0,d1
		move.l	d0,d3			; Set up deformation scroll value
		asr.l	#7,d3
		moveq	#$2F,d4
		cmpi.w	#-$60,d2
		bgt.s	loc_50D52
		lea	(Block_table+$181A).w,a1	; If background is high enough that water line doesn't have to be messed with, just apply the standard formation to it

loc_50D3A:
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_50D3A
		bra.w	loc_50DDA		; Then finish it up
; ---------------------------------------------------------------------------

loc_50D52:
		lea	(Block_table+$199A).w,a1

loc_50D56:
		swap	d1				; If background camera is lower, then apply water line deformation backwards
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_50D56
		cmpi.w	#$60,d2
		bge.s	loc_50DDA		; If background camera is low enough that water line doesn't need to be messed with, then end it.
		lea	(Block_table+$18DA).w,a1	; Otherwise, the fun begins
		lea	(a1),a5
		lea	(HCZ_WaterlineScroll_Data).l,a6
		move.w	d2,d1
		bmi.s	loc_50DAE
		move.w	d1,d3			; If waterline is displayed below water level
		neg.w	d3
		addi.w	#$60,d3
		lsl.w	#5,d3
		adda.w	d3,a6
		add.w	d3,d3
		adda.w	d3,a6			; Set up area of water line scroll data to use based on position
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_50DA0

loc_50D98:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+

loc_50DA0:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+	; Apply scroll data
		dbf	d1,loc_50D98
		bra.s	loc_50DDA
; ---------------------------------------------------------------------------

loc_50DAE:
		move.w	d1,d3			; If waterline is displayed above water level
		addi.w	#$60,d3
		lsl.w	#5,d3
		adda.w	d3,a6
		add.w	d3,d3
		adda.w	d3,a6			; Set up area of water line scroll data to use based on position
		neg.w	d1
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_50DCE

loc_50DC6:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),-(a1)

loc_50DCE:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),-(a1)	; Apply scroll data
		dbf	d1,loc_50DC6

loc_50DDA:

		move.l	d0,d1			; Get BG X again
		asr.l	#2,d0
		asr.l	#5,d1
		lea	(Block_table+$1800).w,a1
		swap	d0
		move.w	d0,(a1)
		move.w	d0,$18(a1)
		move.w	d0,d3
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,2(a1)
		move.w	d0,$16(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,4(a1)
		move.w	d0,$14(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,6(a1)
		move.w	d0,$12(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,8(a1)
		move.w	d0,$10(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,$A(a1)
		move.w	d0,$E(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,$C(a1)
		move.w	d0,$19A(a1)
		move.w	d0,d4
		tst.w	d2
		bpl.s	loc_50E68
		lea	(Block_table+$18DA).w,a1	; Water line above water
		moveq	#$2F,d0

loc_50E4E:
		move.w	d4,(a1)+
		move.w	d4,(a1)+
		dbf	d0,loc_50E4E
		moveq	#$5F,d0
		add.w	d2,d0
		bmi.s	locret_50E86
		lea	(Block_table+$181A).w,a1

loc_50E60:
		move.w	d3,(a1)+
		dbf	d0,loc_50E60
		bra.s	locret_50E86
; ---------------------------------------------------------------------------

loc_50E68:
		lea	(Block_table+$181A).w,a1	; Water line below water
		moveq	#$2F,d0

loc_50E6E:
		move.w	d3,(a1)+
		move.w	d3,(a1)+
		dbf	d0,loc_50E6E
		moveq	#$5F,d0
		sub.w	d2,d0
		bmi.s	locret_50E86
		lea	(Block_table+$199A).w,a1

loc_50E80:
		move.w	d4,-(a1)
		dbf	d0,loc_50E80

locret_50E86:

		rts
; End of function HCZ1_Deform

; ---------------------------------------------------------------------------

HCZ2_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

HCZ2_ScreenEvent:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

HCZ2_BackgroundInit:
		cmpi.w	#$C00,(Camera_X_pos).w
		bhs.s	loc_50ED0
		cmpi.w	#$500,(Camera_Y_pos).w
		blo.s	loc_50ED0
		move.w	#4,(TrigEvents_Routine).w	; Special deformation occurs when camera X is less than $C00 and
		jsr	Create_New_Sprite.w		; camera Y is greater than $500
		bne.s	loc_50EC0
		move.l	#Obj_HCZ2Wall,(a1)

loc_50EC0:
		jsr	HCZ2_WallMove(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		jsr	Refresh_PlaneFull(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_50ED0:

		move.w	#$10,(TrigEvents_Routine).w			; Normal deformation
		jsr	HCZ2_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	(HCZ2_BGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

HCZ2_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_50EFA(pc,d0.w)
; ---------------------------------------------------------------------------

loc_50EFA:
		bra.w	HCZ2BGE_WallMoveInit
; ---------------------------------------------------------------------------
		bra.w	HCZ2BGE_WallMove
; ---------------------------------------------------------------------------
		bra.w	HCZ2BGE_NormalTransition
; ---------------------------------------------------------------------------
		bra.w	HCZ2BGE_NormalRefresh
; ---------------------------------------------------------------------------
		bra.w	HCZ2BGE_Normal
; ---------------------------------------------------------------------------

HCZ2BGE_WallMoveInit:
		jsr	Create_New_Sprite.w
		bne.s	loc_50F1C
		move.l	#Obj_HCZ2Wall,(a1)

loc_50F1C:
		addq.w	#4,(TrigEvents_Routine).w

HCZ2BGE_WallMove:
		tst.w	(ScrEvents_2).w
		bne.s	loc_50F64
		jsr	HCZ2_WallMove(pc)
		jsr	DrawBGAsYouMove(pc)
		jsr	PlainDeformation(pc)
		jsr	ShakeScreen_Setup.w
		jsr	Get_BGActualEffectiveDiff(pc)
		clr.b	(BG_Collision).w
		move.w	(Player_1+x_pos).w,d0
		cmpi.w	#$3F0,d0
		blo.s	locret_50F62
		cmpi.w	#$C10,d0
		bhs.s	locret_50F62
		move.w	(Player_1+y_pos).w,d0
		cmpi.w	#$600,d0
		blo.s	locret_50F62
		cmpi.w	#$840,d0
		bhs.s	locret_50F62
		st	(BG_Collision).w			; Only enable BG tile collision if player is within above parameters

locret_50F62:

		rts
; ---------------------------------------------------------------------------

loc_50F64:
		clr.w	(ScrEvents_2).w
		tst.w	(ScrShake_Value).w
		bpl.s	loc_50F72
		clr.w	(ScrShake_Value).w		; Disable screen shaking if still constant

loc_50F72:
		clr.b	(BG_Collision).w
		move.w	#$F0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w

HCZ2BGE_NormalTransition:
		move.w	#$400,d1
		moveq	#0,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	PlainDeformation
		jsr	HCZ2_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_50FB8
; ---------------------------------------------------------------------------

HCZ2BGE_NormalRefresh:
		jsr	HCZ2_Deform(pc)

loc_50FB8:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_50FDE		; NAT: Change lable
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_50FDE
; ---------------------------------------------------------------------------

HCZ2BGE_Normal:
		jsr	HCZ2_Deform(pc)

loc_50FCE:

		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)

loc_50FDE:
		lea	(HCZ2_BGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup.w

; =============== S U B R O U T I N E =======================================


HCZ2_WallMove:	; NAT: Some fixes here, mostly for respawning
		lea	Player_1.w,a1			; Sonic
		cmp.b	#1,BoxWinner.w			; check who is winning
		ble.s	.found				; if neither or Sonic, branch
		lea	Player_2.w,a1			; Sonic

.found		move.l	#$E000,d0
		cmpi.w	#$A88,x_pos(a1)
		blo.s	loc_5100C

loc_51006:
		move.l	#$14000,d0			; Speed up if player has passed the end already

loc_5100C:
		move.w	(ScrEvents_Routine2).w,d1
		beq.s	loc_5102E
		cmpi.w	#-$600,d1
		bgt.s	WallCheckReset
		cmpi.w	#-$800,d1
		blt.s	WallCheckReset

		cmp.b	#6,Player_1+routine.w		; check if players are dead
		blo.s	.notdead			; if at least 1 player is alive, all is well and good
		cmp.b	#6,Player_2+routine.w		; ''
		blo.s	.notdead			; ''
		move.w	#-$800,(ScrEvents_Routine2).w		; force wall in place
		bra.s	WallCheckReset

.notdead	tst.w	(ScrShake_Value).w			; When wall has travelled $600 pixels
		bpl.s	loc_51052
		move.w	#$E,(ScrShake_Value).w		; Set screen shake to timed
		moveq	#$5F,d0
		jsr	Play_Sound_2.w		; Play final crashing sound
		move.w	#-$600,(ScrEvents_Routine2).w		; force wall in place
		bra.s	loc_51052
; ---------------------------------------------------------------------------

WallCheckReset:
		neg.w	d1				; negate offset
		add.w	#$600-$10,d1			; just enough, so Sonic can't clip behind the wall and reset it
		cmp.w	x_pos(a1),d1			; check if behind the wall
		ble.s	loc_5103A			; if is not behind, branch

		cmp.b	#6,routine(a1)			; check if pl is dead
		bhs.s	loc_51052			; if so, do not move

		clr.l	(ScrEvents_Routine2).w			; clear the wall pos
		sf	(ScrShake_Value).w			; stop constant screen shake movement
		bra.s	loc_51052

loc_5102E:
		cmpi.w	#$680,x_pos(a1)
		blo.s	loc_51052			; If wall hasn't started moving and player hasn't moved far enough, end.
		st	(ScrShake_Value).w			; Begin constant screen shake movement

loc_5103A:
		sub.l	d0,(ScrEvents_Routine2).w		; Subtract speed from BG X offset
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_51052
		moveq	#$6F,d0
		jsr	Play_Sound_2.w		; Play the screen shake sound every 16th frame

loc_51052:
		move.w	(Camera_Y_pos_copy).w,d0	; Get BG camera Y
		subi.w	#$500,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w	; Offset it by $500 and put it in effective BG Y
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$200,d0
		add.w	(ScrEvents_Routine2).w,d0
		move.w	d0,(Camera_X_pos_BG_copy).w	; Do the same with the BG Camera X, offsetting it by the wall movement amount
		rts


; =============== S U B R O U T I N E =======================================


HCZ2_Deform:

		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(ScrShake_Offset).w,d1
		sub.w	d1,d0
		asr.w	#2,d0
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#3,d1
		lea	(Block_table+$1800).w,a1
		lea	(HCZ2_BGDeformIndex).l,a5
		moveq	#0,d2

loc_5109C:
		move.b	(a5)+,d3
		bmi.s	loc_510B4
		ext.w	d3
		swap	d0

loc_510A4:
		move.b	(a5)+,d2
		move.w	d0,(a1,d2.w)
		dbf	d3,loc_510A4
		swap	d0
		sub.l	d1,d0
		bra.s	loc_5109C
; ---------------------------------------------------------------------------

loc_510B4:
		move.w	$12(a1),d0
		sub.w	$A(a1),d0
		move.w	d0,(ScrEvents_A).w
		move.w	6(a1),d0
		sub.w	$12(a1),d0
		move.w	d0,(ScrEvents_B).w
		move.w	4(a1),d0
		sub.w	$12(a1),d0
		move.w	d0,(ScrEvents_C).w
		rts
; End of function HCZ2_Deform

; ---------------------------------------------------------------------------

Obj_HCZ2Wall:

		cmpi.w	#4,(TrigEvents_Routine).w
		beq.s	loc_510E8
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_510E8:
		move.w	(ScrEvents_Routine2).w,d4
		neg.w	d4
		addi.w	#$5BE,d4
		move.w	d4,$10(a0)
		move.w	#$700,$14(a0)
		move.b	#$40,7(a0)
		bset	#7,$2A(a0)
		moveq	#$4B,d1
		move.w	#$100,d2
		move.w	#$100,d3
		jmp	SolidObjectFull2.w
; ---------------------------------------------------------------------------

MGZ1_ScreenInit:
		clr.w	(ScrEvents_D).w
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

MGZ1_ScreenEvent:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jsr	Do_ShakeSound(pc)
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

MGZ1_BackgroundInit:
		jsr	(MGZ1_Deform).l
		moveq	#0,d0
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	(MGZ1_BGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

MGZ1_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_51158(pc,d0.w)
; ---------------------------------------------------------------------------

loc_51158:
		bra.w	MGZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	MGZ1BGE_Transition
; ---------------------------------------------------------------------------

MGZ1BGE_Normal:
		tst.w	(ScrEvents_2).w
		beq.s	loc_511B0
		clr.w	(ScrEvents_2).w			; Transition time

loc_511B0:
		jsr	(MGZ1_Deform).l					; Pretty self-explanatory to be honest
		lea	(MGZ1_BGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

MGZ1BGE_Transition:
		tst.b	(Kos_modules_left).w
		bne.w	loc_51268				; Wait for Kos queue to finish
		move.w	#$201,(Current_zone_and_act).w		; Change act
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(NoReset_RespawnTbl).w			; Reset various managers
		jsr	Clear_Switches.w
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		moveq	#$F,d0
		jsr	LoadPalette_Immediate.w
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$2E00,d0
		move.w	#$600,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		sub.w	d1,(Camera_min_Y_pos).w
		sub.w	d1,(Camera_max_Y_pos).w
		move.w	(Camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.l	(ScrEvents_A).w
		clr.w	(ScrEvents_C).w
		clr.w	(__u_EEA2).w
		clr.w	(ScrEvents_0).w
		clr.w	(__u_EEB8).w
		clr.w	(TrigEvents_Routine).w		; Clear flags/values used for BG stuff in act 2

loc_51268:
		jsr	(MGZ1_Deform).l
		lea	(MGZ1_BGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)

; =============== S U B R O U T I N E =======================================


Do_ShakeSound:
		tst.w	(ScrEvents_D).w
		bne.s	locret_512A4		; If flag is set, skip this
		tst.w	(ScrShake_Value).w
		bpl.s	locret_512A4		; If screen is not shaking continuously, skip this
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	locret_512A4
		moveq	#$6F,d0
		jsr	Play_Sound_2.w

locret_512A4:
		rts
; End of function Do_ShakeSound

; ---------------------------------------------------------------------------

MGZ2_ScreenInit:
		clr.l	(ScrEvents_A).w
		clr.l	(ScrEvents_C).w
		clr.w	(ScrEvents_0).w
		clr.w	(__u_EEB8).w
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

MGZ2_ScreenEvent:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		tst.w	(ScrEvents_0).w
		beq.s	loc_512D0
		st	(ScrShake_Value).w		; Turn continuous shaking on

loc_512D0:
		jsr	Do_ShakeSound(pc)
		move.w	(ScrEvents_Routine).w,d0
		jmp	loc_512DC(pc,d0.w)
; ---------------------------------------------------------------------------

loc_512DC:
		bra.w	MGZ2SE_Normal
; ---------------------------------------------------------------------------
		bra.w	MGZ2SE_Collapse
; ---------------------------------------------------------------------------
		bra.w	MGZ2SE_MoveBG
; ---------------------------------------------------------------------------

MGZ2SE_Normal:
		tst.w	(ScrEvents_1).w
		bne.s	loc_512FA
		jsr	MGZ2_QuakeEvent(pc)
		jsr	MGZ2_ChunkEvent(pc)
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

loc_512FA:
		clr.w	(ScrEvents_1).w		; Clear background event
		st	(ScrEvents_D).w
		move.w	#$14,(ScrShake_Value).w
		addq.w	#4,(ScrEvents_Routine).w

MGZ2SE_Collapse:
		jsr	MGZ2_LevelCollapse(pc)
		tst.w	(ScrShake_Value).w
		bmi.s	loc_5131A
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

loc_5131A:
		lea	(MGZ2_FGVScrollArray).l,a4
		lea	(Block_table+$1900).w,a5
		moveq	#$F,d6
		moveq	#$A,d5
		jmp	DrawTilesVDeform(pc)
; ---------------------------------------------------------------------------

MGZ2SE_MoveBG:
		move.l	(ScrEvents_6).w,d0
		cmpi.l	#$50000,d0
		bhs.s	loc_51342
		addi.l	#$800,d0
		move.l	d0,(ScrEvents_6).w

loc_51342:
		swap	d0
		add.w	d0,(ScrEvents_8).w	; Apply a movement offset for the BG scrolling during the boss
		jmp	DrawTilesAsYouMove(pc)

; =============== S U B R O U T I N E =======================================


MGZ2_LevelCollapse:
		tst.w	(ScrShake_Value).w
		bmi.w	loc_5140C			; If shaking continuously, branch
		bne.w	locret_514A8
		movea.w	$38(a3),a1			; Get chunk line at $700 Y
		lea	$79(a1),a1				; Get chunk at $3C80
		move.w	-8(a3),d0			; Get FG level X chunksize
		subq.w	#3,d0
		moveq	#2,d1

loc_51372:
		clr.b	(a1)+
		clr.b	(a1)+
		clr.b	(a1)+				; Clear the three main chunks on three lines that comprise the boss battle
		adda.w	d0,a1
		dbf	d1,loc_51372
		lea	(Block_table+$1902).w,a1
		lea	(Block_table+$193C).w,a5
		lea	$28(a5),a6
		move.w	(Camera_Y_pos_copy).w,d0	; Get BG Y camera
		and.w	(Camera_Y_pos_mask).w,d0	; AND it to get tile position
		moveq	#9,d1

loc_51394:
		move.w	d0,(a1)
		addq.w	#4,a1
		clr.l	(a5)+
		clr.l	(a6)+				; Clear scroll values, etc
		dbf	d1,loc_51394
		jsr	Create_New_Sprite.w
		bne.s	loc_513FA
		move.w	#$3C90,d1
		move.l	#$5C00790,d2
		move.l	#Block_table+$193C,d3
		moveq	#9,d4

loc_513BA:
		move.l	#Obj_MGZ2LevelCollapseSolid,(a1)		; Create solid objects that Sonic can stand on as the level collapses
		move.w	d1,$10(a1)
		move.w	d2,$2E(a1)
		move.l	d3,$30(a1)
;		swap	d2		; NAT: Delete the top row
;		jsr	(CreateNewSprite4).l
;		bne.s	loc_513FA
;		move.l	#Obj_MGZ2LevelCollapseSolid,(a1)
;		move.w	d1,$10(a1)
;		move.w	d2,$2E(a1)
;		move.l	d3,$30(a1)
		addi.w	#$20,d1
;		swap	d2
		addq.l	#4,d3
		jsr	(CreateNewSprite4).l
		dbne	d4,loc_513BA

loc_513FA:

		st	(ScrShake_Value).w		; Turn quake on
		clr.w	(ScrEvents_5).w
		st	(__u_EEA2).w			; Turn on special VScroll VInt function
		move.w	#4,(Special_V_int_routine).w

loc_5140C:
		lea	(Block_table+$1900).w,a1
		lea	$28(a1),a4
		lea	$14(a4),a5
		lea	(MGZ2_CollapseScrollDelay).l,a6
		move.w	(ScrEvents_5).w,d0
		addq.w	#1,(ScrEvents_5).w
		moveq	#$A,d1
		moveq	#9,d2

loc_5142A:
		cmp.w	(a6)+,d0		; Get scroll delay for each block
		blo.s	loc_51436
		addi.l	#$500,$64(a1)	; Add $500 to Vscroll velocity for this block when not delayed

loc_51436:
		move.l	$64(a1),d3
		add.l	d3,(a5)+		; Add velocity to actual VScroll
		move.w	-4(a5),d3
		cmpi.w	#$2E0,d3
		blo.s	loc_5144C
		move.w	#$2E0,d3		; $2E0 is the maximum scroll
		subq.w	#1,d1			; When maximum scroll is reached, lower amount of "active" scrolling lines

loc_5144C:
		move.w	(Camera_Y_pos_copy).w,d4	; Get BG Y
		sub.w	d3,d4
		move.w	d4,(a4)+
		move.w	d4,(a1)				; Subtract from scroll to get... something
		addq.w	#4,a1
		dbf	d2,loc_5142A			; Repeat until all scrolling parts are off-screen
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_51470
		moveq	#-$34,d0			; Play collapsing sound every 16 frames
		jsr	Play_Sound_2.w

loc_51470:
		tst.w	d1
		bne.s	locret_514A8		; If scrolling chunks still remain, do nothing
		movea.w	$2C(a3),a1			; Get chunk line at $580 Y
		lea	$79(a1),a1				; Get chunk at $3C80 X
		move.w	-8(a3),d0
		subq.w	#3,d0
		moveq	#2,d1

loc_51484:
		clr.b	(a1)+
		clr.b	(a1)+
		clr.b	(a1)+
		adda.w	d0,a1
		dbf	d1,loc_51484
		clr.w	(ScrShake_Value).w		; Stop quaking
		clr.l	(ScrEvents_6).w		; Stop special tile drawing
		move.w	(Camera_X_pos_copy).w,(ScrEvents_8).w
		move.w	#$C,(Special_V_int_routine).w	; Set VScroll VInt routine
		addq.w	#4,(ScrEvents_Routine).w	; Next screen routine

locret_514A8:

		rts
; End of function MGZ2_LevelCollapse


; =============== S U B R O U T I N E =======================================


MGZ2_QuakeEvent:
		tst.w	(__u_EEB8).w
		beq.s	loc_514D8
		bpl.s	loc_514BE
		tst.l	(Kos_module_queue).w
		bne.s	loc_514D8
		move.w	#$FF,(__u_EEB8).w

loc_514BE:
		move.w	(Camera_min_Y_pos).w,d0
		beq.s	loc_514D8
		cmpi.w	#$1E0,d0
		beq.s	loc_514D8
		subq.w	#2,d0
		bcc.s	loc_514D4
		moveq	#0,d0
		move.w	d0,(__u_EEB8).w

loc_514D4:
		move.w	d0,(Camera_min_Y_pos).w

loc_514D8:
		move.w	Player_1+x_pos.w,d0
		move.w	Player_1+y_pos.w,d1
		move.w	(ScrEvents_A).w,d2
		jmp	loc_514E8(pc,d2.w)
; End of function MGZ2_QuakeEvent

; ---------------------------------------------------------------------------

loc_514E8:
		bra.w	MGZ2_QuakeEventCheck
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent1
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent2
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent3
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent1Cont
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent2Cont
; ---------------------------------------------------------------------------
		bra.w	MGZ2_QuakeEvent3Cont
; ---------------------------------------------------------------------------

MGZ2_QuakeEventCheck:
		lea	(ScrEvents_B).w,a5		; EEE4-EEE6 are flags to determine whether earthquake event has already completed. There are three
		lea	(MGZ2_QuakeEventArray).l,a1
		moveq	#4,d2
		moveq	#2,d3

loc_51512:
		tst.b	(a5)
		bne.s	loc_51552
		move.w	Player_1+x_pos.w,d0	; NAT: fix for tails
		move.w	Player_1+y_pos.w,d1
		cmp.w	(a1),d0
		blo.s	.cktails
		cmp.w	2(a1),d0
		bhs.s	.cktails
		cmp.w	4(a1),d1
		blo.s	.cktails
		cmp.w	6(a1),d1
		blo.s	.ok

.cktails	move.w	Player_2+x_pos.w,d0
		move.w	Player_2+y_pos.w,d1
		cmp.w	(a1),d0
		blo.s	loc_51552
		cmp.w	2(a1),d0
		bhs.s	loc_51552
		cmp.w	4(a1),d1
		blo.s	loc_51552
		cmp.w	6(a1),d1
		bhs.s	loc_51552

.ok		move.w	d2,(ScrEvents_A).w
		move.w	8(a1),d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	$A(a1),d0
		cmpi.w	#4,d2
		bne.s	loc_5154C
		move.w	d0,(Camera_max_X_pos).w	; First earthquake event near start of level makes you go right
		rts
; ---------------------------------------------------------------------------

loc_5154C:
		move.w	d0,(Camera_min_X_pos).w	; The other two make you go left
		rts
; ---------------------------------------------------------------------------

loc_51552:

		lea	$C(a1),a1
		addq.w	#1,a5
		addq.w	#4,d2
		dbf	d3,loc_51512
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent1:
		cmpi.w	#$780,d0
		bhs.s	.cool		; If player retreats, revert to normal camera movement
		move.w	Player_2+x_pos.w,d0	; NAT: fix for tails
		move.w	Player_2+y_pos.w,d1
		cmpi.w	#$780,d0
		blo.w	loc_51656		; If player retreats, revert to normal camera movement

.cool		move.w	(Camera_max_X_pos).w,d0
		cmp.w	(Camera_X_pos).w,d0
		bhi.s	locret_515A2		; If camera X hasn't reached level X end, branch
		move.w	d0,(Camera_min_X_pos).w	; Lock the screen
		st	(ScrEvents_B).w			; Set the earthquake flag for this first one
		addi.w	#$C,(ScrEvents_A).w	; Set next quake event routine
		jsr	Create_New_Sprite.w
		bne.s	locret_515A2
		move.l	#Obj_MGZ2DrillingEggman,(a1)
		move.w	#$8E0,$10(a1)
		move.w	#$690,$14(a1)		; Create drilling eggman boss sprite
		st	(ScrShake_Value).w
		st	(ScrEvents_0).w			; Start shaking the screen

locret_515A2:

		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent2:
		cmpi.w	#$3200,d0
		blo.s	loc_515B4		; If player retreats, revert to normal camera movement
		move.w	Player_2+x_pos.w,d0	; NAT: fix for tails
		move.w	Player_2+y_pos.w,d1
		cmpi.w	#$3200,d0
		blo.s	loc_515B4

		move.w	#$1DF,(Camera_min_Y_pos).w	; If player retreats, reset level height
		bra.w	loc_51656
; ---------------------------------------------------------------------------

loc_515B4:
		move.w	(Camera_max_Y_pos).w,d1
		cmp.w	(Camera_Y_pos).w,d1
		bne.s	loc_515CC
		cmp.w	(Camera_min_Y_pos).w,d1
		beq.s	loc_515CC
		move.w	d1,(Camera_min_Y_pos).w	; Adjust level height during this event
		st	(__u_EEB8+$1).w

loc_515CC:

		move.w	(Camera_min_X_pos).w,d0	; If camera X hasn't reached level X start, branch
		cmp.w	(Camera_X_pos).w,d0
		blo.s	locret_5160C
		move.w	d0,(Camera_max_X_pos).w	; Lock the screen
		st	(ScrEvents_B+$1).w			; Set this earthquake flag
		addi.w	#$C,(ScrEvents_A).w	; Set next quake event routine
		jsr	Create_New_Sprite.w
		bne.s	locret_5160C
		move.l	#Obj_MGZ2DrillingEggman,(a1)
		bset	#0,4(a1)
		move.w	#$2FA0,$10(a1)
		move.w	#$2D0,$14(a1)		; Set Robotnik drilling object
		st	(ScrShake_Value).w
		st	(ScrEvents_0).w			; Start quaking

locret_5160C:

		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent3:
		cmpi.w	#$3480,d0
		blo.s	.cool		; If player retreats, revert to normal camera movement
		move.w	Player_2+x_pos.w,d0
		move.w	Player_2+y_pos.w,d1		; NAT: fix for tails
		cmpi.w	#$3480,d0			; Same as above, you know the drill (haha, drill...)
		bhs.s	loc_51656

.cool		move.w	(Camera_min_X_pos).w,d0
		cmp.w	(Camera_X_pos).w,d0
		blo.s	locret_51654
		move.w	d0,(Camera_max_X_pos).w
		st	(ScrEvents_C).w
		addi.w	#$C,(ScrEvents_A).w

		jsr	Create_New_Sprite.w
		bne.s	locret_51654
;		move.l	#Boss_Force_End,(a1)		; FIX: Remove line
		move.l	#Obj_MGZ2DrillingEggman,(a1)	; FIX: Uncomment lines
		bset	#0,4(a1)
		move.w	#$3300,$10(a1)
		move.w	#$790,$14(a1)
		st	(ScrShake_Value).w			; ''
		st	(ScrEvents_0).w			; ''

locret_51654:

		rts
; ---------------------------------------------------------------------------

loc_51656:

		move.w	#$1000,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.l	#$6000,d0
		move.l	d0,(Camera_min_X_pos).w
		clr.w	(ScrEvents_A).w
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent1Cont:
		cmpi.w	#$980,Player_2+x_pos.w	; NAT: fix for tails
		bhs.s	loc_516A2
		cmpi.w	#$980,Player_1+x_pos.w
		bhs.s	loc_516A2			; Reset level Y end when Sonic has travelled past $980 X
		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent2Cont:
		cmpi.w	#$100,Player_2+y_pos.w
		bhs.s	.sonic
		cmpi.w	#$2F80,Player_2+x_pos.w	; NAT: fix for tails
		bhs.s	.cool

.sonic		cmpi.w	#$100,Player_1+y_pos.w
		bhs.s	locret_51696
		cmpi.w	#$2F80,Player_1+x_pos.w
		blo.s	locret_51696

.cool		move.w	#$6000,d0
		move.w	d0,(Camera_max_X_pos).w
		bra.s	loc_516A2
; ---------------------------------------------------------------------------

locret_51696:

		rts
; ---------------------------------------------------------------------------

MGZ2_QuakeEvent3Cont:
		cmpi.w	#$3200,Player_2+x_pos.w	; NAT: fix for tails
		blo.s	loc_516A2
		cmpi.w	#$3200,Player_1+x_pos.w
		bhs.s	locret_51696
; ---------------------------------------------------------------------------

loc_516A2:

		move.w	#$1000,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		clr.w	(ScrEvents_A).w
		rts

; =============== S U B R O U T I N E =======================================


MGZ2_ChunkEvent:
		move.w	(ScrEvents_4).w,d0
		jmp	loc_516BC(pc,d0.w)
; End of function MGZ2_ChunkEvent

; ---------------------------------------------------------------------------

loc_516BC:
		bra.w	MGZ2_ChunkEventCheck
; ---------------------------------------------------------------------------
		bra.w	MGZ2_ChunkEvent1
; ---------------------------------------------------------------------------
		bra.w	MGZ2_ChunkEvent2_3
; ---------------------------------------------------------------------------
		bra.w	MGZ2_ChunkEvent2_3
; ---------------------------------------------------------------------------
		bra.w	MGZ2_ChunkEventReset
; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------

MGZ2_ChunkEventCheck:
		lea	(MGZ2_ChunkEventArray).l,a1
		moveq	#4,d2
		moveq	#2,d3

loc_516E4:
		move.w	Player_1+x_pos.w,d0	; NAT: fix for tails
		move.w	Player_1+y_pos.w,d1
		cmp.w	(a1),d0
		blo.s	.cktails
		cmp.w	2(a1),d0
		bhs.s	.cktails
		cmp.w	4(a1),d1
		blo.s	.cktails
		cmp.w	6(a1),d1
		blo.s	.ok

.cktails	move.w	Player_2+x_pos.w,d0
		move.w	Player_2+y_pos.w,d1
		cmp.w	(a1),d0
		blo.s	loc_51706
		cmp.w	2(a1),d0
		bhs.s	loc_51706
		cmp.w	4(a1),d1
		blo.s	loc_51706
		cmp.w	6(a1),d1
		bhs.s	loc_51706

.ok		cmpi.w	#4,d2
		bne.s	loc_51712
		tst.w	(ScrShake_Value).w
		bmi.s	loc_51712		; Only perform the first layout shift event if screen is continually shaking

loc_51706:

		lea	$C(a1),a1
		addq.w	#4,d2
		dbf	d3,loc_516E4
		rts
; ---------------------------------------------------------------------------

loc_51712:

		move.w	d2,(ScrEvents_4).w
		clr.w	(ScrEvents_5).w
		clr.w	(ScrEvents_6).w
		move.w	8(a1),(ScrEvents_7).w
		move.w	$A(a1),(ScrEvents_8).w

MGZ2_ChunkEvent1:
		move.w	(ScrEvents_5).w,d0
		cmpi.w	#$5C,d0
		blo.s	loc_51762
		clr.w	(ScrShake_Value).w		; Stop shaking when first chunk event is finished
		clr.w	(ScrEvents_0).w		; Reset quake event
		clr.w	(Camera_min_X_pos).w		; Reset level height
		move.w	#$10,(ScrEvents_4).w
		rts
; ---------------------------------------------------------------------------

MGZ2_ChunkEvent2_3:

		move.w	(ScrEvents_5).w,d0
		cmpi.w	#$5C,d0
		blo.s	loc_51762
		move.w	#$6000,d0
		move.w	d0,(Camera_max_X_pos).w	; Reset level end X
		move.w	#$14,(ScrEvents_4).w
		rts
; ---------------------------------------------------------------------------

loc_51762:

		subq.w	#1,(ScrEvents_6).w
		bpl.s	locret_517C2
		move.w	#6,(ScrEvents_6).w	; Perform the layout change once every seven frames
		move.w	d0,d2
		bsr.s	MGZ2_ModifyChunk
		move.w	(ScrEvents_7).w,d0
		addi.w	#$80,d0
		sub.w	(Camera_X_pos_copy).w,d0
		bcs.s	locret_517C2
		cmpi.w	#$1C0,d0			; Calculate the X position of the screen redraw
		bhs.s	locret_517C2
		move.w	(ScrEvents_8).w,d0
		lea	(MGZ2_ScreenRedrawArray).l,a1
		add.w	(a1,d2.w),d0		; Calculate the Y position
		move.w	2(a1,d2.w),d2		; And the number of lines to write

loc_51798:
		move.w	(Camera_Y_pos_copy).w,d3
		and.w	(Camera_Y_pos_mask).w,d3
		cmp.w	d3,d0
		blo.s	loc_517BA
		addi.w	#$F0,d3
		cmp.w	d3,d0
		bhs.s	loc_517BA
		move.w	(ScrEvents_7).w,d1
		moveq	#8,d6				; Always draw 8 tiles
		swap	d2
		jsr	Setup_TileRowDraw(pc)
		swap	d2

loc_517BA:

		addi.w	#$10,d0
		dbf	d2,loc_51798

locret_517C2:

		rts
; ---------------------------------------------------------------------------

MGZ2_ChunkEventReset:
		move.w	Camera_X_pos.w,d0
		add.w	#320/2,d0		; NAT: Fix again
		cmpi.w	#$2A00,d0
		blo.s	locret_517D4

	;	cmpi.w	#$2A00,Player_1+x_pos.w	; When Player has travelled far enough, reset the chunk to its original form
	;	bhs.s	.milesperhour
	;	cmpi.w	#$2A00,Player_2+x_pos.w	; NAT: and for tails too
	;	blo.s	locret_517D4
		clr.w	(ScrEvents_4).w
		moveq	#$5C,d0
		bra.s	MGZ2_ModifyChunk
; ---------------------------------------------------------------------------

locret_517D4:
		rts

; =============== S U B R O U T I N E =======================================


MGZ2_ModifyChunk:

		lea	(MGZ2_ChunkReplaceArray).l,a1
		lea	(Chunk_table+$5880).l,a5
		bsr.s	sub_517EA
		lea	(Chunk_table+$7500).l,a5
; End of function MGZ2_ModifyChunk


; =============== S U B R O U T I N E =======================================


sub_517EA:
		lea	(MGZ2_QuakeChunks).l,a4
		adda.w	(a1,d0.w),a4
		moveq	#7,d1

loc_517F6:
		move.l	(a4)+,(a5)+
		move.l	(a4)+,(a5)+
		move.l	(a4)+,(a5)+
		move.l	(a4)+,(a5)+
		dbf	d1,loc_517F6

		addq.w	#2,d0
		move.w	d0,(ScrEvents_5).w
		rts
; End of function sub_517EA

; ---------------------------------------------------------------------------

Obj_MGZ2LevelCollapseSolid:

		cmpi.w	#8,(ScrEvents_Routine).w
		bne.s	loc_51818
		jmp	Delete_Current_Sprite.w		; Delete control object when next screen event is in effect
; ---------------------------------------------------------------------------

loc_51818:
		movea.l	$30(a0),a1		; Get vertical scroll position for this block
		move.w	$2E(a0),d0		; Get vertical position
		add.w	(a1),d0			; Add it to scroll value to get final Y position
		move.w	d0,$14(a0)
		move.b	#$10,7(a0)		; Set up width
		bset	#7,$2A(a0)		; Make it invisible
		moveq	#$1B,d1
		moveq	#$40,d2
		moveq	#$40,d3			; Height, etc
		move.w	$10(a0),d4		; Position
		jmp	SolidObjectFull2.w
; ---------------------------------------------------------------------------

MGZ2_BackgroundInit:
		jsr	MGZ2_ClearBottomBG(pc)
		move.w	#4,(TrigEvents_Routine).w	; Use second background event
		clr.w	(__u_EEA2).w		; Clear VScroll routine flag


		move.w	Camera_X_Pos.w,d0	; NAT: Fix for tails too
		add.w	#320/2,d0
		move.w	Camera_Y_Pos.w,d1
		add.w	#224/2,d1

		cmpi.w	#$500,d1
		bhs.s	loc_5187E
		cmpi.w	#$3800,d0
		blo.s	loc_518CA
		move.w	#4,(ScrEvents_Routine2).w	; If player is <$500 Y and >$3800 X (Knuckles area presumably)
		move.l	#Obj_MGZ2BGMoveKnux,d1
		cmpi.w	#$3A80,d0
		blo.s	loc_518C0
		move.w	#$220,(ScrEvents_3).w
		bra.s	loc_518CA
; ---------------------------------------------------------------------------

loc_5187E:
		cmpi.w	#$800,d1
		blo.s	loc_518A4
		cmpi.w	#$34C0,d0
		blo.s	loc_518CA
		move.w	#8,(ScrEvents_Routine2).w	; If player is >$800 Y and >$34C0 X
		move.l	#Obj_MGZ2BGMoveSonic,d1
		cmpi.w	#$3800,d0
		blo.s	loc_518C0
		move.w	#$1D0,(ScrEvents_3).w
		bra.s	loc_518CA
; ---------------------------------------------------------------------------

loc_518A4:
		cmpi.w	#$3900,d0
		blo.s	loc_518CA
		move.w	#$C,(ScrEvents_Routine2).w	; If player is >$3900X and inbetween $500 and $800 Y
		move.w	#$1D0,(ScrEvents_3).w
		st	(ScrEvents_9).w			; Turn off cloud movement
		clr.l	(Block_table+$1838).w
		bra.s	loc_518CA
; ---------------------------------------------------------------------------

loc_518C0:

		jsr	Create_New_Sprite.w
		bne.s	loc_518CA
		move.l	d1,(a1)

loc_518CA:

		jsr	(MGZ2_BGDeform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		clr.l	(Block_table+$1800).w
		move.w	d2,(Block_table+$1806).w
		lea	(MGZ2_BGDrawArray).l,a4
		lea	(Block_table+$1800).w,a5
		jsr	Refresh_PlaneTileDeform(pc)
		lea	(MGZ2_BGDeformArray).l,a4
		lea	(Block_table+$1808).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

MGZ2_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_51900(pc,d0.w)
; ---------------------------------------------------------------------------

loc_51900:
		bra.w	MGZ2BGE_GoRefresh
; ---------------------------------------------------------------------------
		bra.w	MGZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	MGZ2BGE_Refresh
; ---------------------------------------------------------------------------

MGZ2BGE_GoRefresh:
		jsr	MGZ2_ClearBottomBG(pc)
		clr.l	(Block_table+$1800).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_51968
; ---------------------------------------------------------------------------

MGZ2BGE_Normal:
		jsr	MGZ2_BGEventTrigger(pc)
		bne.s	loc_51968		; If BG event has triggered, go refresh the BG
		jsr	(MGZ2_BGDeform).l

loc_51926:
		lea	(MGZ2_BGDrawArray).l,a4
		lea	(Block_table+$1800).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	Draw_BG(pc)

loc_51936:
		lea	(MGZ2_BGDeformArray).l,a4
		lea	(Block_table+$1808).w,a5
		jsr	ApplyDeformation(pc)
		lea	(MGZ2_FGVScrollArray).l,a4
		lea	(Block_table+$1926).w,a5
		jsr	Apply_FGVScroll(pc)
		jsr	Get_BGActualEffectiveDiff(pc)
		jsr	ShakeScreen_Setup.w
		tst.b	(BG_Collision).w
		beq.s	locret_51966
		jmp	Go_CheckPlayerRelease(pc)			; Only do this if BG collision is on
; ---------------------------------------------------------------------------

locret_51966:
		rts
; ---------------------------------------------------------------------------

loc_51968:

		jsr	(MGZ2_BGDeform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	d2,(Block_table+$1806).w
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_51994
; ---------------------------------------------------------------------------

MGZ2BGE_Refresh:
		jsr	(MGZ2_BGDeform).l

loc_51994:
		lea	(MGZ2_BGDrawArray).l,a4
		lea	(Block_table+$17FC).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	Draw_PlaneVertBottomUpComplex(pc)
		bpl.w	loc_51936		; NAT: Change lable
		subq.w	#4,(TrigEvents_Routine).w
		bra.w	loc_51936

; =============== S U B R O U T I N E =======================================


MGZ2_ClearBottomBG:

		move.w	(a3),d0
		addq.w	#8,d0
		move.w	d0,$74(a3)
		move.w	d0,$78(a3)
		move.w	d0,$7C(a3)
		rts
; End of function MGZ2_ClearBottomBG


; =============== S U B R O U T I N E =======================================


MGZ2_BGEventTrigger:
		tst.w	(__u_EEA2).w
		beq.s	loc_519CC
		rts
; ---------------------------------------------------------------------------

loc_519CC:
		move.w	Camera_X_Pos.w,d0	; NAT: Fix for tails too
		add.w	#320/2,d0
		move.w	Camera_Y_Pos.w,d1
		add.w	#224/2,d1

	;	move.w	Player_1+x_pos.w,d0
	;	move.w	Player_1+y_pos.w,d1

		move.w	(ScrEvents_Routine2).w,d2
		jmp	loc_519DC(pc,d2.w)
; End of function MGZ2_BGEventTrigger

; ---------------------------------------------------------------------------

loc_519DC:
		bra.w	loc_51A6A	; 0 - Normal
; ---------------------------------------------------------------------------
		bra.w	loc_51A3C	; 4 - Knuckles BG Move Event
; ---------------------------------------------------------------------------
		bra.w	loc_51A04	; 8 - Sonic BG Move Event
; ---------------------------------------------------------------------------
		clr.b	(BG_Collision).w	; C - After BG Move
		cmpi.w	#$800,d1		; Turn off BG collision
		blo.w	loc_51AB8
		cmpi.w	#$3A40,d0
		blo.w	loc_51AB8		; If Player (Sonic/Tails) is > $800 Y and > $3A40 X, go back to BG event
		move.w	#8,(ScrEvents_Routine2).w
		rts
; ---------------------------------------------------------------------------

loc_51A04:
		st	(BG_Collision).w		; Set BG collision on
		cmpi.w	#$800,d1
		bhs.s	loc_51A22
		cmpi.w	#$3900,d0
		blo.w	loc_51AB8
		st	(ScrEvents_9).w		; If Player < $800 Y and > $3900 X, turn off cloud movement
		clr.l	(Block_table+$1838).w
		moveq	#$C,d0			; Got to after BG Event trigger
		bra.s	loc_51A34
; ---------------------------------------------------------------------------

loc_51A22:
		cmpi.w	#$900,d1
		bhs.w	loc_51AB8
		cmpi.w	#$34C0,d0
		bhs.w	loc_51AB8		; If player is > $900 Y or > $34C0 X, continue normal deformation
		moveq	#0,d0

loc_51A34:
		move.w	d0,(ScrEvents_Routine2).w	; Otherwise, return to normal BG collision trigger
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

loc_51A3C:
		st	(BG_Collision).w		; Set BG collision on
		cmpi.w	#$100,d1
		bhs.s	loc_51A50
		cmpi.w	#$3C00,d0
		blo.s	loc_51A50
		clr.b	(BG_Collision).w	; If Player < $100 Y and > $3C00 X, turn off BG collision

loc_51A50:

		cmpi.w	#$80,d1
		blo.s	loc_51AB8
		cmpi.w	#$180,d1
		bhs.s	loc_51AB8
		cmpi.w	#$3800,d0
		bhs.s	loc_51AB8		; If player is < $80 Y and > $180 Y and  > $3800 X, continue deformation
		clr.w	(ScrEvents_Routine2).w	; Otherwise
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

loc_51A6A:
		clr.b	(BG_Collision).w
		cmpi.w	#$80,d1
		blo.s	loc_51AB8
		cmpi.w	#$180,d1
		bhs.s	loc_51A8A
		cmpi.w	#$3800,d0
		blo.s	loc_51AB8
		moveq	#4,d0			; If between $80 and $180 Y and > $3800 X, use first BG move
		move.l	#Obj_MGZ2BGMoveKnux,d1
		bra.s	loc_51AA4
; ---------------------------------------------------------------------------

loc_51A8A:
		cmpi.w	#$800,d1
		blo.s	loc_51AB8
		cmpi.w	#$900,d1
		bhs.s	loc_51AB8
		cmpi.w	#$34C0,d0
		blo.s	loc_51AB8
		moveq	#8,d0			; If between $800 and $900 Y and > $34C0 X, use second BG move
		move.l	#Obj_MGZ2BGMoveSonic,d1

loc_51AA4:
		move.w	d0,(ScrEvents_Routine2).w
		clr.w	(ScrEvents_3).w
		jsr	Create_New_Sprite.w
		bne.s	locret_51AB6
		move.l	d1,(a1)

locret_51AB6:
		rts
; ---------------------------------------------------------------------------

loc_51AB8:

		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------

Obj_MGZ2BGMoveKnux:

		moveq	#4,d0
		move.w	#$400,d1
		move.w	#$38A0,d2
		move.w	#$220,d3
		move.w	#$6000,d4
		bra.s	loc_51AE6
; ---------------------------------------------------------------------------

Obj_MGZ2BGMoveSonic:

		moveq	#8,d0
		move.w	#$A80,d1
		move.w	#$36D0,d2
		move.w	#$1D0,d3
		move.w	#$6000,d4
		st	$38(a0)

loc_51AE6:
		cmp.w	(ScrEvents_Routine2).w,d0
		beq.s	loc_51AF2
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_51AF2:
		cmp.w	Player_2+y_pos.w,d1		; NAT: Fix de la tails
		bhs.s	.sunak
		cmp.w	Player_2+x_pos.w,d2
		blo.s	loc_51B00

.sunak		cmp.w	(Player_1+y_pos).w,d1
		bhs.s	locret_51AFE
		cmp.w	(Player_1+x_pos).w,d2
		blo.s	loc_51B00

locret_51AFE:
		rts
; ---------------------------------------------------------------------------

loc_51B00:
		move.w	d3,$2E(a0)
		move.w	d4,$32(a0)
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,(Camera_min_X_pos).w
		bset	#7,(Wallgrab_Disable).w
		move.l	#loc_51B1C,(a0)

loc_51B1C:
		cmp.b	#6,Player_1+routine.w		; NAT: Check if dead
		blo.s	.alive				; if so, bra
		cmp.b	#6,Player_2+routine.w		; NAT: Check if dead
		blo.s	.alive				; if no, bra
	;	clr.w	(ScrEvents_3).w			; clear floor pose
	;	clr.l	$34(a0)				; ^
		clr.b	$39(a0)				; make sure we go slow
		move.l	#$FFFC0000,$30(a0)		; move down

.alive		tst.w	$30(a0)				; test speed
		bpl.s	.normal				; if normal, branch
		tst.w	(ScrEvents_3).w			; check position
		bgt.s	loc_51B44			; if not low enough, branch
		clr.w	(ScrEvents_3).w			; clear floor pose
		clr.l	$34(a0)				; ^
		move.l	#$6000,$30(a0)			; reset speed

.normal		move.w	(ScrEvents_3).w,d0
		cmp.w	$2E(a0),d0			; Wait for BG offset to match given value
		blo.s	loc_51B44
		moveq	#$5F,d0				; Play final crashing sound
		jsr	Play_Sound_2.w
		move.w	#$E,(ScrShake_Value).w	; Do final screen shake
		clr.w	(ScrEvents_0).w		; Disable constant screen shaking
		bclr	#7,(Wallgrab_Disable).w	; Reenable Knuckles wall grab
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_51B44:
		move.w	Camera_X_Pos.w,d2	; NAT: Making the fricking frogs gay!
		add.w	#320/2,d2
		move.w	Camera_Y_Pos.w,d3
		add.w	#224/2,d3

		tst.w	$30(a0)			; NAT: test speed
		bmi.s	loc_51B76		; if backwards, do not check completion
		tst.b	$39(a0)
		beq.s	loc_51B58
		move.w	d0,d1
		addq.w	#1,d1
		move.w	d1,$34(a0)		; NAT: Fix visual bugs
		bra.s	loc_51B84
; ---------------------------------------------------------------------------

loc_51B58:
		tst.b	$38(a0)
		bne.s	loc_51B6C
		cmpi.w	#$200,d3
		bhs.s	loc_51B76
		cmpi.w	#$3CB0,d2
		blo.s	loc_51B72
		bra.s	loc_51B76
; ---------------------------------------------------------------------------

loc_51B6C:
		cmpi.w	#$3D50,d2	; Second background object check
		blo.s	loc_51B76

loc_51B72:
		st	$39(a0)

loc_51B76:

		move.l	$34(a0),d1
		add.l	$30(a0),d1
		move.l	d1,$34(a0)
		swap	d1

loc_51B84:
		move.w	d1,(ScrEvents_3).w	; Move background offset
		tst.w	$30(a0)			; NAT: test speed
		bmi.s	.rts			; if backwards, do not move players

		sub.w	d0,d1
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d1,(Player_2+y_pos).w
.rts		rts
; ---------------------------------------------------------------------------

CNZ1_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

CNZ1_ScreenEvent:
		tst.w	(ScrEvents_5).w
		beq.s	loc_51BAA
		clr.w	(ScrEvents_5).w
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_51BAA:
		jsr	DrawTilesAsYouMove(pc)
		lea	(ScrEvents_Routine2).w,a5
		tst.l	(a5)
		beq.w	locret_51C6A
		move.w	(a5)+,d0			; All this below is for removing chunks from the miniboss arena
		move.w	(a5),d1
		clr.l	-2(a5)
		move.w	d0,d2
		move.w	d1,d3
		asr.w	#3,d2
		move.w	d2,d4
		asr.w	#4,d2
		move.w	d3,d5
		asr.w	#5,d3
		and.w	(Layout_row_index_mask).w,d3
		movea.w	(a3,d3.w),a4
		moveq	#-1,d6
		clr.w	d6
		move.b	(a4,d2.w),d6
		lsl.w	#7,d6
		andi.w	#$C,d4
		andi.w	#$60,d5
		add.w	d4,d6
		add.w	d5,d6
		movea.l	d6,a4
		clr.l	(a4)
		clr.l	$10(a4)		; Clear the neccesary parts of the chunks
		asr.w	#2,d0
		andi.w	#$78,d0
		lsl.w	#4,d1
		andi.w	#$E00,d1
		add.w	d1,d0
		add.w	d7,d0
		moveq	#0,d1
		move.w	d0,(a0)+
		move.w	#1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		addi.w	#$100,d0
		move.w	d0,(a0)+
		move.w	#1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+
		move.l	d1,(a0)+		; Add a VRAM write to remove it from the screen
		clr.w	(a0)
		movea.w	$18(a3),a4
		lea	$64(a4),a4			; Level layout $300 Y $3200 X (the boss arena blocks)
		moveq	#0,d1
		clr.w	(ScrEvents_4).w
		moveq	#3,d3

loc_51C38:
		lea	(a4),a5
		moveq	#2,d2

loc_51C3C:
		moveq	#-1,d0
		clr.w	d0
		move.b	(a5)+,d0
		lsl.w	#7,d0
		add.w	d1,d0
		movea.l	d0,a6
		tst.l	(a6)+
		bne.s	locret_51C6A
		tst.l	(a6)+
		bne.s	locret_51C6A
		tst.l	(a6)+
		bne.s	locret_51C6A
		tst.l	(a6)
		bne.s	locret_51C6A
		dbf	d2,loc_51C3C
		addi.w	#$20,d1			; Basically, if a line of blocks is completely destroyed, the boss is lowered by $20 pixels to compensate.
		addi.w	#$20,(ScrEvents_4).w
		dbf	d3,loc_51C38

locret_51C6A:

		rts
; ---------------------------------------------------------------------------

CNZ1_BackgroundInit:
		jsr	CNZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)

		moveq	#0,d1
		cmp.b	#6,PlayMode.w		; NAT: is this the minigame
		bne.s	.okok			; if no, brahh
		move.w	#$200,d1		; MAGIC VALUE A GO

.okok		jsr	Refresh_PlaneFull(pc)
		lea	CNZ1_BGDeformArray(pc),a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

CNZ1_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_51C8E(pc,d0.w)
; ---------------------------------------------------------------------------

loc_51C8E:
		bra.w	CNZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_BossStart
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_Boss
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_AfterBoss
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_FGRefresh
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_FGRefresh2
; ---------------------------------------------------------------------------
		bra.w	CNZ1BGE_DoTransition
; ---------------------------------------------------------------------------

CNZ1BGE_Normal:
		cmpi.w	#$3000,(Camera_X_pos).w
		blo.s	loc_51CFA
		cmpi.w	#$54C,(Camera_Y_pos).w
		blo.s	loc_51CD2
		move.w	#$700,d0			; This is positional adjustment for Knuckles' path
		sub.w	d0,(Player_1+y_pos).w
		sub.w	d0,(Player_2+y_pos).w
		sub.w	d0,(Camera_Y_pos).w
		sub.w	d0,(Camera_Y_pos_copy).w
		jsr	Reset_TileOffsetPositionActual(pc)

loc_51CD2:
		jsr	CNZ1_BossLevelScroll(pc)
		jsr	Reset_TileOffsetPositionEff(pc)

		cmp.b	#6,PlayMode.w		; NAT: is this the minigame
		beq.s	.okok			; if so, brahh
		lea	(Pal_CNZMiniboss).l,a1
		jsr	PalLoad_Line1.w

		move.w	#$1C0,d0
		move.w	d0,(Camera_min_Y_pos).w	; Change level start Y
.okok		bset	#7,(Wallgrab_Disable).w	; Disable wall grabbing for Knuckles
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_51D26
; ---------------------------------------------------------------------------

loc_51CFA:
		jsr	CNZ1_Deform(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	CNZ1_BGDeformArray(pc),a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

CNZ1BGE_BossStart:
		move.w	#$1C0,d0
		jsr	CNZ1_ScrollToYStart(pc)
		jsr	CNZ1_BossLevelScroll(pc)

loc_51D26:
		jsr	DrawBGAsYouMove(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

CNZ1BGE_Boss:
		move.w	#$1C0,d0
		jsr	CNZ1_ScrollToYStart(pc)
		jsr	CNZ1_BossLevelScroll2(pc)
		lea	(Camera_X_pos_BG_copy).w,a6
		lea	(Camera_X_pos_BG_rounded).w,a5
		move.w	#$200,d1
		moveq	#$10,d6
		jsr	Draw_TileColumn(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

CNZ1BGE_AfterBoss:
		move.w	#$1C0,d0
		jsr	CNZ1_ScrollToYStart(pc)
		tst.w	(ScrEvents_2).w
		bne.s	loc_51D6E
		jsr	CNZ1_BossLevelScroll2(pc)
		jsr	DrawBGAsYouMove(pc)
		jsr	PlainDeformation(pc)
		jmp	Get_BGActualEffectiveDiff(pc)
; ---------------------------------------------------------------------------

loc_51D6E:
		clr.w	(ScrEvents_2).w		; When signalled
		move.w	#$2F0,(DrawDelayed_Position).w	; Set refresh position
		move.w	#$F,(DrawDelayed_RowCount).w	; Refresh number
		addq.w	#4,(TrigEvents_Routine).w

CNZ1BGE_FGRefresh:
		move.w	#$1C0,d0
		jsr	CNZ1_ScrollToYStart(pc)		; Continue scrolling
		move.w	#-$4000,d7
		moveq	#0,d1
		move.w	#$200,d2

		jsr	Draw_PlaneVertSingleBottomUp(pc)	; Refresh the foreground using BG chunks
		bmi.s	loc_51DAE
		move.w	#-$2000,d7
		jsr	CNZ1_BossLevelScroll2(pc)
		jsr	DrawBGAsYouMove(pc)
		jsr	PlainDeformation(pc)
		jmp	Get_BGActualEffectiveDiff(pc)
; ---------------------------------------------------------------------------

loc_51DAE:
		movea.w	$C(a3),a1		; $180 Y of BG
		addq.w	#4,a1			; $200 X of BG
		move.w	-8(a3),d0		; Get X size of BG
		subq.w	#5,d0
		movea.w	$12(a3),a5		; $280 Y of FG
		lea	$63(a5),a5			; $3180 of FG
		move.w	-$A(a3),d1		; Get X size of FG
		subq.w	#5,d1
		moveq	#5,d2

loc_51DCA:
		move.b	(a1)+,(a5)+		; Replace 5x5 portion of Foreground with equivalent from BG. Basically,
		move.b	(a1)+,(a5)+		; transferring the actual layout to the FG for use with collision.
		move.b	(a1)+,(a5)+
		move.b	(a1)+,(a5)+
		move.b	(a1)+,(a5)+
		adda.w	d0,a1
		adda.w	d1,a5
		dbf	d2,loc_51DCA
		clr.b	(BG_Collision).w	; Turn off BG collision
		clr.w	(ScrEvents_6).w	; Turn off scrolling
		move.w	#$1C0,d0
		add.w	d0,(Player_1+y_pos).w	; Move players and camera to position
		add.w	d0,(Player_2+y_pos).w
		add.w	d0,(Camera_Y_pos).w
		add.w	d0,(Camera_Y_pos_copy).w
		jsr	Reset_TileOffsetPositionActual(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w	; Set up refresh position
		move.w	#$F,(DrawDelayed_RowCount).w	; Refresh amount
		addq.w	#4,(TrigEvents_Routine).w

CNZ1BGE_FGRefresh2:
		move.w	#$380,d0
		jsr	CNZ1_ScrollToYStart(pc)
		lea	(Level_layout_main).w,a3
		move.w	#-$4000,d7
		move.w	(Camera_X_pos_copy).w,d1
		move.w	(Camera_Y_pos_copy).w,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)	; Refresh the FG using FG chunks this time
		bmi.s	loc_51E42
		addq.w	#2,a3
		move.w	#-$2000,d7
		jsr	CNZ1_BossLevelScroll2(pc)
		jsr	DrawBGAsYouMove(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_51E42:
		addq.w	#2,a3
		move.w	#-$2000,d7
		jsr	Create_New_Sprite.w
		bne.s	loc_51E5C
		move.l	#Obj_EndSign,(a1)
		move.w	#$32C0,$10(a1)			; Set up the end sign

loc_51E5C:
		addq.w	#4,(TrigEvents_Routine).w

CNZ1BGE_DoTransition:
		tst.w	(ScrEvents_2).w
		beq.w	loc_51F28				; Don't do anything until signpost lands
		clr.w	(ScrEvents_2).w
		movem.l	d7-a0/a2-a3,-(sp)
		moveq	#$18,d0
		jsr	Load_PLC.w
		moveq	#$19,d0
		jsr	Load_PLC.w					; Load CNZ 2 PLCs
		move.w	#$301,(Current_zone_and_act).w		; Change to act 2
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(NoReset_RespawnTbl).w			; Reset various managers
		jsr	Clear_Switches.w
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l		; Level stuff, etc etc
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_51EC0
		move.w	#$8014,(VDP_control_port).l		; Turn HInt on for water only if not playing as Knuckles

loc_51EC0:
		moveq	#$11,d0
		jsr	LoadPalette_Immediate.w	; Load CNZ palette
		movem.l	(sp)+,d7-a0/a2-a3
		bclr	#7,(Wallgrab_Disable).w		; Wall gliding is possible again
		move.w	#$3000,d0
		move.w	#-$200,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w		; Offset object/player positions
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w		; Offset camera positions
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		sub.w	d1,(Camera_min_Y_pos).w
		sub.w	d1,(Camera_max_Y_pos).w		; Offset level start/ends
		move.w	(Camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		move.w	#$2F0,(DrawDelayed_Position).w		; Set up refresh
		move.w	#$F,(DrawDelayed_RowCount).w
		clr.w	(TrigEvents_Routine).w

loc_51F28:
		jsr	CNZ1_BossLevelScroll2(pc)
		jsr	DrawBGAsYouMove(pc)
		jmp	PlainDeformation(pc)

; =============== S U B R O U T I N E =======================================


CNZ1_Deform:

		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(ScrShake_Offset).w,d2
		sub.w	d2,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#1,d1
		add.l	d1,d0
		asr.l	#2,d1
		add.l	d1,d0
		swap	d0
		add.w	d2,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w		; Effective BG Y is about 1/10th (13/128ths to be exact) of camera Y
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#3,d1
		lea	(Block_table+$180A).w,a1
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(Camera_X_pos_BG_copy).w		; Effective BG X is 7/16th speed of normal camera
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(ScrEvents_A).w		; Dynamic art reload BG speed is 5/16th of normal camera
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d1,d0
		asr.l	#1,d1
		sub.l	d1,d0
		swap	d0
		move.w	d0,-(a1)
		rts
; End of function CNZ1_Deform


; =============== S U B R O U T I N E =======================================


CNZ1_BossLevelScroll:

		cmpi.w	#$1E0,(Camera_Y_pos_BG_copy).w
		blo.s	CNZ1_BossLevelScroll2
		addq.w	#4,(TrigEvents_Routine).w

CNZ1_BossLevelScroll2:

		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$100,d0
		add.w	(ScrEvents_6).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$2F80,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function CNZ1_BossLevelScroll

; ---------------------------------------------------------------------------

Obj_CNZMinibossScrollControl:
		moveq	#0,d0
		move.b	5(a0),d0
		jmp	loc_51FD8(pc,d0.w)
; ---------------------------------------------------------------------------

loc_51FD8:
		bra.w	Obj_CNZMinibossScrollInit
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollMain
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollWait
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollSlow
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollWait2
; ---------------------------------------------------------------------------
		bra.w	Obj_CNZMinibossScrollWait3
; ---------------------------------------------------------------------------

Obj_CNZMinibossScrollInit:
		lea	(Level_layout_main).w,a3
		movea.w	$14(a3),a1			; $280 Y
		move.b	$63(a1),d0			; $3180 X chunk
		suba.w	-8(a3),a1
		move.b	d0,$63(a1)			; Replace FG layout piece
		addq.w	#2,a3
		movea.w	(a3),a1
		move.b	4(a1),d0
		move.w	-8(a3),d1
		adda.w	d1,a1
		move.b	d0,4(a1)
		adda.w	d1,a1
		move.b	d0,4(a1)			; Replace BG layout piece
		addq.b	#4,5(a0)

Obj_CNZMinibossScrollMain:
		tst.w	(ScrEvents_2).w
		bne.s	loc_52042
		move.l	(ScrEvents_8).w,d0	; Speed up scroll
		cmpi.l	#$40000,d0
		bhs.s	loc_5203C
		addi.l	#$200,d0
		move.l	d0,(ScrEvents_8).w

loc_5203C:
		add.l	d0,(ScrEvents_6).w	; Set BG scrolling speed
		rts
; ---------------------------------------------------------------------------

loc_52042:
		clr.w	(ScrEvents_2).w		; When boss is completed
		addq.b	#4,5(a0)
		btst	#5,OptionsBits.w		; NAT: Check if bosses are on
		bne.s	Obj_CNZMinibossScrollWait	; if are, branch
		addq.b	#8,5(a0)			; else skip phases
		bra.s	Obj_CNZMinibossScrollWait2

Obj_CNZMinibossScrollWait:
		move.w	(ScrEvents_6).w,d0
		andi.w	#$FF,d0
		cmpi.w	#4,d0
		blo.s	loc_52062			; Wait until the offset is a multiple of $100
		move.l	(ScrEvents_8).w,d0
		add.l	d0,(ScrEvents_6).w
		rts
; ---------------------------------------------------------------------------

loc_52062:
		addq.b	#4,5(a0)

Obj_CNZMinibossScrollSlow:
		move.l	(ScrEvents_8).w,d0	; Start slowing down the scrolling
		cmpi.l	#$10000,d0
		bls.s	loc_52082
		subi.l	#$400,d0
		move.l	d0,(ScrEvents_8).w
		add.l	d0,(ScrEvents_6).w
		rts
; ---------------------------------------------------------------------------

loc_52082:
		addq.b	#4,5(a0)

Obj_CNZMinibossScrollWait2:
		move.w	(ScrEvents_6).w,d0
		andi.w	#$FF,d0
		cmpi.w	#4,d0
		blo.s	loc_5209E			; Keep going until offset is a multiple of $100 again
		move.l	(ScrEvents_8).w,d0
		add.l	d0,(ScrEvents_6).w
		rts
; ---------------------------------------------------------------------------

loc_5209E:
		move.w	d0,(ScrEvents_6).w		; Reset scroll offset
		move.w	#$1000,(Camera_target_max_Y_pos).w	; Reset Y end
		st	(BG_Collision).w				; BG collision is on
		addq.w	#4,(TrigEvents_Routine).w		; Next BG Event
		movea.w	(Level_layout_main).w,a1
		lea	$67(a1),a1
		move.w	(Level_layout_header).w,d0
		moveq	#0,d1
		moveq	#6,d2

loc_520C0:
		move.b	d1,(a1)					; Copy top of FG at $3380 downwards
		adda.w	d0,a1
		dbf	d2,loc_520C0
		addq.b	#4,5(a0)

Obj_CNZMinibossScrollWait3:
		cmpi.w	#$1C0,(ScrEvents_6).w		; Wait till scroll offset is $1C0
		bhs.s	loc_520DE

		move.l	(ScrEvents_8).w,d0		; Speed up scroll
		btst	#5,OptionsBits.w		; NAT: Check if bosses are on
		beq.s	.add				; if not, branch

		cmpi.l	#$40000,d0
		bhs.s	.add
		addi.l	#$200,d0
		move.l	d0,(ScrEvents_8).w
.add		add.l	d0,(ScrEvents_6).w
		rts
; ---------------------------------------------------------------------------

loc_520DE:
		st	(ScrEvents_2).w				; Set flag to continue next BG event
		jmp	Delete_Current_Sprite.w

; =============== S U B R O U T I N E =======================================


CNZ1_ScrollToYStart:
		move.w	(Camera_Y_pos).w,d1
		cmp.w	d0,d1
		blo.s	loc_520F2
		exg	d0,d1

loc_520F2:
		cmp.w	(Camera_min_Y_pos).w,d1
		bls.s	locret_520FC
		move.w	d1,(Camera_min_Y_pos).w

locret_520FC:
		rts
; End of function CNZ1_ScrollToYStart

; ---------------------------------------------------------------------------
CNZ1_BGDeformArray:	dc.w $80
		dc.w $30
		dc.w $60
		dc.w $C0
		dc.w $7FFF
; ---------------------------------------------------------------------------

CNZ2_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

CNZ2_ScreenEvent:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	Camera_X_Pos.w,d1
		add.w	#320/2,d1			; NAT: Use camera and not player pos!!!

		cmpi.w	#$4600,d1
		bhs.s	loc_52138			; If player is far enough to the right, skip ahead
		moveq	#0,d0
		cmpi.w	#$940,d1
		bhs.s	loc_5212E
		move.w	#$580,d0			; If player is still in old boss arena, set the level Y start to $580, otherwise, make it 0 like normal

loc_5212E:
		cmp.w	(Camera_min_Y_pos).w,d0
		beq.s	loc_52138
		move.w	d0,(Camera_min_Y_pos).w

loc_52138:

		tst.w	(ScrEvents_5).w
		beq.s	loc_52146
		clr.w	(ScrEvents_5).w
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_52146:
		move.w	(ScrEvents_Routine).w,d0
		jmp	loc_5214E(pc,d0.w)
; ---------------------------------------------------------------------------

loc_5214E:
		bra.w	loc_5215A
; ---------------------------------------------------------------------------
		bra.w	loc_521D2
; ---------------------------------------------------------------------------
		bra.w	CNZ2SE_Normal
; ---------------------------------------------------------------------------

loc_5215A:
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_5216C
		move.w	#8,(ScrEvents_Routine).w	; If playing as Sonic/Tails, don't do any special screen events
		bra.w	CNZ2SE_Normal
; ---------------------------------------------------------------------------

loc_5216C:
		lea	(Player_1).w,a1		; Only do all this is Knuckles is playing
		cmpi.w	#$4880,$10(a1)
		blo.w	CNZ2SE_Normal		; If Knuckles is not past $4880 X, just play normally

loc_5217A:
		cmpi.w	#$B00,$14(a1)
		blo.s	CNZ2SE_Normal		; If Knuckles is not past $B00 Y, play normally
		jsr	Create_New_Sprite.w
		bne.s	loc_521BE
		move.l	#Obj_CNZTeleporter,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_521BE
		move.l	#Obj_81,(a1)
		move.w	#$4980,$10(a1)
		move.w	#$A20,$14(a1)
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(PLC_CNZ2KnuxEnd).l,a1
		jsr	Load_PLC_Raw.w
		movem.l	(sp)+,d7-a0/a2-a3

loc_521BE:

		move.w	#$4750,(Camera_min_X_pos).w
		move.w	#$48E0,(Camera_max_X_pos).w
		clr.b	(Title_Card_Out_Flag).w
		addq.w	#4,(ScrEvents_Routine).w

loc_521D2:
		tst.b	(Title_Card_Out_Flag).w
		beq.s	CNZ2SE_Normal
		jsr	Create_New_Sprite.w
		bne.s	CNZ2SE_Normal
		move.l	#Obj_IncLevEndXGradual,(a1)
		move.w	#$49A0,(__u_FA92).w
		lea	(a2),a6
		jsr	Obj_PlayLevelMusic.w
		lea	(a6),a2
		jsr	Restore_PlayerControl.w
		addq.w	#4,(ScrEvents_Routine).w

CNZ2SE_Normal:

		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

CNZ2_BackgroundInit:
		move.w	#8,(TrigEvents_Routine).w
		jsr	CNZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	CNZ1_BGDeformArray(pc),a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

CNZ2_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_5222C(pc,d0.w)
; ---------------------------------------------------------------------------

loc_5222C:
		bra.w	loc_52238
; ---------------------------------------------------------------------------
		bra.w	loc_52266
; ---------------------------------------------------------------------------
		bra.w	loc_5227C
; ---------------------------------------------------------------------------

loc_52238:
		moveq	#0,d1
		move.w	#$200,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	PlainDeformation
		jsr	CNZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_5226A
; ---------------------------------------------------------------------------

loc_52266:
		jsr	CNZ1_Deform(pc)

loc_5226A:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.s	loc_52280
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_52280
; ---------------------------------------------------------------------------

loc_5227C:
		jsr	CNZ1_Deform(pc)

loc_52280:

		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	CNZ1_BGDeformArray(pc),a4
		lea	(Block_table+$1800).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

Obj_CNZTeleporter:
		lea	(Player_1).w,a1
		cmpi.w	#$4A38,$10(a1)
		blo.s	locret_522FE		; If Knuckles isn't in range, don't bother
		btst	#1,$2A(a1)
		beq.s	loc_522C2
		move.w	#$4A40,d0
		cmp.w	$10(a1),d0
		bhi.s	locret_522FE
		move.w	d0,$10(a1)			; While jumping, don't allow Knuckles past this point (so he lands on the teleporter)

loc_522C2:
		clr.w	$18(a1)
		clr.w	$1C(a1)				; Stop Knuckles' momentum
		st	(Ctrl_1_locked).w			; Turn off player control
		clr.w	(Ctrl_1_logical).w		; Clear buttons
		lea	(ArtKosM_SSZTeleport).l,a1
		move.w	#-$6000,d2
		jsr	Queue_Kos_Module.w	; Load teleporter graphics
		lea	(Normal_palette_line_2+$2).w,a1
		move.l	#$EEE0EC0,(a1)
		move.w	#$EA2,$E(a1)
		move.w	#$E80,$12(a1)		; Replace applicable palette entries
		move.l	#Obj_CNZTeleporterMain,(a0)

locret_522FE:

		rts
; ---------------------------------------------------------------------------

Obj_CNZTeleporterMain:
		tst.b	(Kos_modules_left).w
		bne.s	locret_52348		; Don't do anything while art is loading
		lea	(Player_1).w,a1
		btst	#1,$2A(a1)
		bne.s	locret_52348		; Wait till Knuckles is not in the air
		jsr	Create_New_Sprite3.w
		bne.s	locret_52348
		move.w	a1,$3C(a0)
		move.l	#Obj_TeleporterBeam,(a1)
		move.w	a0,parent2(a1)
		move.w	#$4A40,d0
		move.w	d0,$10(a0)
		move.w	d0,$10(a1)
		move.w	#$A38,$14(a1)		; Set teleporter position/attributes
		moveq	#$53,d0
		jsr	Play_Sound_2.w
		move.l	#loc_5234A,(a0)

locret_52348:

		rts
; ---------------------------------------------------------------------------

loc_5234A:
		lea	(Player_1).w,a1
		movea.w	$3C(a0),a2
		cmpi.b	#8,$46(a2)
		blt.s	locret_523C8
		beq.s	loc_523B6		; Once beam has expanded halfway. On the first frame this happen, set player state
		cmpi.b	#$18,$46(a2)
		bhs.s	loc_5238E
		btst	#0,(Level_frame_counter+1).w
		beq.s	locret_523C8
		subq.w	#1,$14(a1)		; Raise player slightly
		btst	#1,(Level_frame_counter+1).w
		beq.s	locret_523C8
		moveq	#1,d1
		move.w	$10(a1),d0
		cmp.w	$10(a0),d0
		beq.s	locret_523C8
		bcs.s	loc_52388
		neg.w	d1

loc_52388:
		add.w	d1,$10(a1)		; Move player X towards center of beam X
		bra.s	locret_523C8
; ---------------------------------------------------------------------------

loc_5238E:
		move.l	#loc_523CA,(a0)	; When beam has expanded all the way
		move.b	#3,$2E(a1)		; Stop player animation
		moveq	#0,d0
		move.w	d0,$14(a1)		; Make player disappear!
		move.b	d0,$20(a1)
		move.b	d0,$22(a1)
		moveq	#$73,d0
		jsr	Play_Sound_2.w
		st	(Scroll_lock).w
		bra.s	locret_523C8
; ---------------------------------------------------------------------------

loc_523B6:
		move.b	#1,$2E(a1)		; Player under object control
		bset	#2,$2A(a1)		; Set to jumping state
		move.b	#2,$20(a1)		; Rolling animation

locret_523C8:
locret_523EA:
		rts
; ---------------------------------------------------------------------------

loc_523CA:
		subi.w	#$10,(Camera_Y_pos).w
		cmpi.w	#$780,(Camera_Y_pos).w
		bhs.s	locret_523EA
		moveq	#-$1F,d0
		jsr	Play_Sound.w
		move.w	#$500,d0		; Start Ice Cap
		jmp	StartNewLevel.w
; ---------------------------------------------------------------------------

FBZ1_ScreenInit:
		tst.b	OptionsBits.w		; check if normal layout
		bpl.s	.noalt			; if so, branch
		lea	Level_layout_main+$34.w,a5; get layout address table
		lea	FBZ1_AltMod(pc),a1	; get alt mod data
		jsr	LayoutMod_AltLayouts(pc); do alternate layouts
		bra.s	.moddone

.noalt		move.w	Level_layout_main+$24.w,a5; get address to layout data
		clr.w	$16(a5)			; clear 2 chunks

.moddone	cmpi.w	#$180,(Player_1+x_pos).w
		blo.s	loc_52412
		move.w	-8(a3),d0
		subq.w	#5,d0
		movea.w	$34(a3),a1		; $680 Y
		movea.w	$48(a3),a5		; $900 Y
		moveq	#2,d1

loc_52404:
		move.l	(a5)+,(a1)+		; Copy the "indoors" beginning part
		move.b	(a5)+,(a1)+
		adda.w	d0,a1
		adda.w	d0,a5
		dbf	d1,loc_52404
		bra.s	loc_5241C
; ---------------------------------------------------------------------------

loc_52412:
		move.w	#$18,(ScrEvents_Routine2).w		; If player is < $180 X
		st	(ScrEvents_3).w

loc_5241C:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

FBZ1_AltMod:
	dc.b $22, 2-1, $00, $00
	dc.b $22, 4-1, $32, $00, $6A, $A1
	dc.b $21, 3-1, $6B, $28, $2A
	dc.b $22, 2-1, $00, $A1
	dc.b 0
	even
; ---------------------------------------------------------------------------

FBZ1_ScreenEvent:

loc_5242E:
		lea	FBZ1_LayoutModRange(pc),a1
		move.w	Player_1+x_pos.w,d0
		move.w	Player_1+y_pos.w,d1
		move.w	(ScrEvents_Routine2).w,d2
		jmp	loc_52442(pc,d2.w)
; ---------------------------------------------------------------------------

loc_52442:
		bra.w	FBZ1SE_Normal
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod1
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod2
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod3
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod4
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod5
; ---------------------------------------------------------------------------
		bra.w	FBZ1SE_LayoutMod6	; Beginning of stage
; ---------------------------------------------------------------------------

FBZ1SE_Normal:
		cmp.b	#6,Player_1+routine.w		; NAT: Tails oops
		bhs.s	.fuckingdead1
		move.w	d2,d4
		bsr.s	.chkonce

.fuckingdead1	move.w	Player_2+x_pos.w,d0
		move.w	Player_2+y_pos.w,d1
		cmp.b	#6,Player_2+routine.w		; NAT: dick
		bhs.s	.fuckingdead2

		lea	FBZ1_LayoutModRange(pc),a1
		move.w	d4,d2
		bsr.s	.chkonce
.fuckingdead2	rts

.chkonce	moveq	#4,d4
		moveq	#5,d5

loc_52462:
		lea	(a1),a5					; Check layout mod ranges
		cmp.w	(a5)+,d0
		blo.s	loc_5247A
		cmp.w	(a5)+,d0
		bhi.s	loc_5247A
		cmp.w	(a5)+,d1
		blo.s	loc_5247A
		cmp.w	(a5)+,d1
		bhi.s	loc_5247A
		move.w	d4,(ScrEvents_Routine2).w
		addq.w	#4,sp
		bra.s	loc_52482
; ---------------------------------------------------------------------------

loc_5247A:

		addq.w	#8,a1
		addq.w	#4,d4
		dbf	d5,loc_52462

loc_52482:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod1:
		jsr	FBZ1Screen_CheckInRange(pc)		; Make sure Sonic is still in range
		tst.w	(ScrEvents_3).w			; NAT: Somehow fix all this crap
		bne.s	.chkoutdoors
		cmpi.w	#$B00+(320/2),Camera_X_Pos.w; If indoors, check if Sonic is in right half of ranged area
		bhs.s	.righthalf		; If so, branch
		cmpi.w	#$70A,d0		; Otherwise, check if Sonic has gone far enough to the right
		bls.w	FBZ1Screen_DrawOnly
		cmpi.w	#$70A,d2
		bls.w	FBZ1Screen_DrawOnly
		bra.s	.outdoors
; ---------------------------------------------------------------------------

.righthalf	cmpi.w	#$A0E,d1		; If to the right of ranged area, instead check if Sonic has gone low enough
		bls.w	FBZ1Screen_DrawOnly
		cmpi.w	#$A0E,d3
		bls.w	FBZ1Screen_DrawOnly
		bra.s	.outdoors
; ---------------------------------------------------------------------------

.chkoutdoors	cmpi.w	#$B00+(320/2),Camera_X_Pos.w; If outdoors, check if Sonic is in right half of ranged area
		bhs.s	.righthalf2		; If so, branch
		cmpi.w	#$6F6,d2
		bls.s	.indoors
		cmpi.w	#$6F6,d0		; Otherwise, check if Sonic has gone far enough to the left
		bls.s	.indoors
		bra.w	FBZ1Screen_DrawOnly
; ---------------------------------------------------------------------------

.righthalf2	cmpi.w	#$9F2,d3
		blo.s	.indoors
		cmpi.w	#$9F2,d1		; If to the right of ranged area, instead check if Sonic has gone high enough
		bhi.w	FBZ1Screen_DrawOnly

.indoors	clr.w	(ScrEvents_3).w	; In either case, go outdoors->indoors
		movea.w	(a3),a5
		lea	$60(a5),a5
		movea.w	(a3),a6
		lea	$64(a6),a6
		bra.s	.update
; ---------------------------------------------------------------------------

.outdoors	st	(ScrEvents_3).w		; Go indoors->outdoors
		movea.w	$18(a3),a5
		lea	$60(a5),a5			; First source is at $300 Y, $3000 X
		movea.w	$14(a3),a6
		lea	$64(a6),a6			; Second source is at $280 Y, $3200 X (both of these are technically out of range)

.update		movea.w	$48(a3),a1
		lea	$C(a1),a1			; First destination is $900 Y, $600 X
		move.w	-8(a3),d0
		subq.w	#4,d0			; Width of four tiles
		moveq	#5,d1			; Height of 6 tiles

loc_524F8:
		move.l	(a5)+,(a1)+		; Copy over layout
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_524F8
		movea.w	$48(a3),a1
		lea	$1A(a1),a1			; Second destination is $900 Y, $D00 X
		move.w	-8(a3),d0
		subq.w	#6,d0			; Width of 6 tiles
		moveq	#3,d1			; Height of 4 tiles

loc_52512:
		move.l	(a6)+,(a1)+
		move.w	(a6)+,(a1)+		; Copy over layout
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,loc_52512
		jmp	Refresh_PlaneFullDirect(pc)	; Refresh screen
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod2:
		lea	8(a1),a1			; The following layout mods all basically work identically to the above with modifications in positioning, etc
		jsr	FBZ1Screen_CheckInRange(pc)		; I'll leave it as an exercise to the reader to get the specifics of each routine :)
		tst.w	(ScrEvents_3).w
		bne.s	.chkoutdoors
		cmpi.w	#$C80+(320/2),Camera_X_Pos.w
		bhs.s	.righthalf
		cmpi.w	#$1F2,d1
		bhs.w	FBZ1Screen_DrawOnly
		cmpi.w	#$1F2,d3
		bhs.w	FBZ1Screen_DrawOnly
		bra.s	.outdoors
; ---------------------------------------------------------------------------

.righthalf	cmpi.w	#$108A,d0
		bls.w	FBZ1Screen_DrawOnly
		cmpi.w	#$108A,d2
		bls.w	FBZ1Screen_DrawOnly
		bra.s	.outdoors
; ---------------------------------------------------------------------------

.chkoutdoors	cmpi.w	#$C80+(320/2),Camera_X_Pos.w
		bhs.s	.righthalf2
		cmpi.w	#$20E,d1
		bhs.s	.indoors
		cmpi.w	#$20E,d3
		bhs.s	.indoors
		bra.w	FBZ1Screen_DrawOnly
; ---------------------------------------------------------------------------

.righthalf2	cmpi.w	#$1076,d0
		blo.s	.indoors
		cmpi.w	#$1076,d2
		bhi.w	FBZ1Screen_DrawOnly

.indoors	clr.w	(ScrEvents_3).w
		movea.w	(a3),a5
		lea	$6C(a5),a5
		movea.w	(a3),a6
		lea	$76(a6),a6
		bra.s	.update
; ---------------------------------------------------------------------------

.outdoors	st	(ScrEvents_3).w
		movea.w	$14(a3),a5
		lea	$6C(a5),a5
		movea.w	$10(a3),a6
		lea	$76(a6),a6

.update		movea.w	8(a3),a1
		lea	$E(a1),a1
		move.w	-8(a3),d0
		subi.w	#$A,d0
		moveq	#3,d1

loc_5259A:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_5259A
		movea.w	$C(a3),a1
		lea	$1C(a1),a1
		move.w	-8(a3),d0
		subi.w	#$C,d0
		moveq	#2,d1

loc_525BA:
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,loc_525BA
		jmp	Refresh_PlaneFullDirect(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod3:
		lea	$10(a1),a1
		jsr	FBZ1Screen_CheckInRange(pc)
		tst.w	(ScrEvents_3).w
		bne.s	.chkoutdoors
		cmpi.w	#$1880+(320/2),Camera_X_Pos.w
		bhs.s	.righthalf
		cmpi.w	#$158A,d0
		bls.w	FBZ1Screen_DrawOnly
		cmpi.w	#$158A,d2
		bls.w	FBZ1Screen_DrawOnly
		bra.s	.outdoors
; ---------------------------------------------------------------------------

.righthalf	cmpi.w	#$A0E,d1
		bls.w	FBZ1Screen_DrawOnly
		cmpi.w	#$A0E,d3
		bls.w	FBZ1Screen_DrawOnly
		bra.s	.outdoors
; ---------------------------------------------------------------------------

.chkoutdoors	cmpi.w	#$1880+(320/2),Camera_X_Pos.w
		bhs.s	.righthalf2
		cmpi.w	#$1576,d0
		bls.s	.indoors
		cmpi.w	#$1576,d2
		bls.s	.indoors
		bra.w	FBZ1Screen_DrawOnly
; ---------------------------------------------------------------------------

.righthalf2	cmpi.w	#$9F2,d1
		blo.s	.indoors
		cmpi.w	#$9F2,d3
		bhi.w	FBZ1Screen_DrawOnly

.indoors	clr.w	(ScrEvents_3).w
		movea.w	$34(a3),a5
		lea	$60(a5),a5
		movea.w	$28(a3),a6
		lea	$66(a6),a6
		bra.s	.update
; ---------------------------------------------------------------------------

.outdoors	st	(ScrEvents_3).w
		movea.w	$44(a3),a5
		lea	$60(a5),a5
		movea.w	$3C(a3),a6
		lea	$66(a6),a6

.update		movea.w	$48(a3),a1
		lea	$28(a1),a1
		move.w	-8(a3),d0
		subq.w	#6,d0
		moveq	#3,d1

loc_52646:
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_52646
		movea.w	$48(a3),a1
		lea	$34(a1),a1
		move.w	-8(a3),d0
		subq.w	#6,d0
		moveq	#3,d1

loc_52662:
		move.l	(a6)+,(a1)+
		move.w	(a6)+,(a1)+
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,loc_52662
		jmp	Refresh_PlaneFullDirect(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod4:
		lea	$18(a1),a1
		jsr	FBZ1Screen_CheckInRange(pc)
		tst.w	(ScrEvents_3).w
		bne.s	.chkoutdoors
		cmpi.w	#$208A,d0
		blo.s	.nope
		cmpi.w	#$208A,d2
		bhs.s	.outdoors

.nope		cmpi.w	#$1D00+(320/2),Camera_X_Pos.w
		bhs.s	.righthalf2
		cmpi.w	#$1C0A,d2
		bls.w	FBZ1Screen_DrawOnly
		cmpi.w	#$1C0A,d0
		bls.w	FBZ1Screen_DrawOnly
		bra.s	.outdoors
; ---------------------------------------------------------------------------

.righthalf2	cmpi.w	#$F2,d1
		bhs.w	FBZ1Screen_DrawOnly
		cmpi.w	#$F2,d3
		bhs.w	FBZ1Screen_DrawOnly
		bra.s	.outdoors
; ---------------------------------------------------------------------------

.chkoutdoors	cmpi.w	#$1D00+(320/2),Camera_X_Pos.w
		bhs.s	.righthalf
		cmpi.w	#$1BF6,d2
		bls.s	.indoors
		cmpi.w	#$1BF6,d0
		bls.s	.indoors
		bra.w	FBZ1Screen_DrawOnly
; ---------------------------------------------------------------------------

.righthalf	cmpi.w	#$10E,d3
		bhi.s	.derp
		cmpi.w	#$10E,d1
		bls.w	FBZ1Screen_DrawOnly
.derp		cmpi.w	#$2076,d2
		blo.s	.indoors
		cmpi.w	#$2076,d0
		bhs.w	FBZ1Screen_DrawOnly

.indoors	clr.w	(ScrEvents_3).w
		movea.w	$28(a3),a5
		lea	$6E(a5),a5
		movea.w	$28(a3),a6
		lea	$76(a6),a6
		bra.s	.update
; ---------------------------------------------------------------------------

.outdoors	st	(ScrEvents_3).w
		movea.w	$3C(a3),a5
		lea	$6E(a5),a5
		movea.w	$3C(a3),a6
		lea	$76(a6),a6

.update		movea.w	(a3),a1
		lea	$36(a1),a1
		move.w	-8(a3),d0
		subq.w	#8,d0
		moveq	#3,d1

loc_526F8:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_526F8
		movea.w	(a3),a1
		lea	$3E(a1),a1
		move.w	-8(a3),d0
		subi.w	#$12,d0
		moveq	#4,d1

loc_52714:
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.w	(a6)+,(a1)+
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,loc_52714
		jmp	Refresh_PlaneFullDirect(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod5:
		lea	$20(a1),a1
		jsr	FBZ1Screen_CheckInRange(pc)
		cmpi.w	#$2100,d0
		blo.s	.chk
		cmpi.w	#$2100,d2
		blo.s	.chk
		cmpi.w	#$2600,d0
		bhi.w	.chk
		cmpi.w	#$2600,d2
		bls.w	FBZ1Screen_DrawOnly

.chk		tst.w	(ScrEvents_3).w
		bne.s	.indoors
		cmpi.w	#$172,d1
		bhs.w	FBZ1Screen_DrawOnly
		cmpi.w	#$172,d3
		bhs.w	FBZ1Screen_DrawOnly
		bra.s	.outdoors
; ---------------------------------------------------------------------------

.indoors	cmpi.w	#$18E,d1
		bhs.s	.ind
		cmpi.w	#$18E,d3
		blo.w	FBZ1Screen_DrawOnly
.ind		clr.w	(ScrEvents_3).w
		movea.w	$28(a3),a5
		lea	$6E(a5),a5
		movea.w	$28(a3),a6
		lea	$76(a6),a6
		bra.s	.update
; ---------------------------------------------------------------------------

.outdoors	st	(ScrEvents_3).w
		movea.w	$3C(a3),a5
		lea	$6E(a5),a5
		movea.w	$3C(a3),a6
		lea	$76(a6),a6

.update		movea.w	(a3),a1
		lea	$36(a1),a1
		move.w	-8(a3),d0
		subq.w	#8,d0
		moveq	#3,d1

loc_52790:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_52790
		movea.w	(a3),a1
		lea	$3E(a1),a1
		move.w	-8(a3),d0
		subi.w	#$12,d0
		moveq	#4,d1

loc_527AC:
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.l	(a6)+,(a1)+
		move.w	(a6)+,(a1)+
		adda.w	d0,a6
		adda.w	d0,a1
		dbf	d1,loc_527AC
		jmp	Refresh_PlaneFullDirect(pc)
; ---------------------------------------------------------------------------

FBZ1SE_LayoutMod6:
		lea	$28(a1),a1			; Get the last layout change range
		jsr	FBZ1Screen_CheckInRange(pc)	; Ensure player is still in specified range
		cmp.b	#2,BoxWinner.w				; NAT: Check if tails is winrar
		bne.s	.tails					; NAT: If not, check Sonic
		exg	d0,d2
		exg	d1,d3

.tails		tst.w	(ScrEvents_3).w
		bne.s	loc_527DA
		cmpi.w	#$70E,d1		; If "indoors", check if Sonic is below given point
		bls.w	FBZ1Screen_DrawOnly		; If not, don't do anything
		bra.s	loc_527EC
; ---------------------------------------------------------------------------

loc_527DA:
		cmpi.w	#$6F2,d1		; If "outdoors" flag is set, check if Sonic is above point given
		bhi.w	FBZ1Screen_DrawOnly		; If not, don't do anything
		clr.w	(ScrEvents_3).w	; Make Sonic "indoors"
		movea.w	$48(a3),a5		; Perform layout copy of indoor tiles
		bra.s	loc_527F4
; ---------------------------------------------------------------------------

loc_527EC:
		st	(ScrEvents_3).w		; Make Sonic "outdoors"
		movea.w	$54(a3),a5		; Perform layout copy of outdoor tiles

loc_527F4:
		movea.w	$34(a3),a1
		move.w	-8(a3),d0
		subq.w	#5,d0
		moveq	#2,d1

loc_52800:
		move.l	(a5)+,(a1)+
		move.b	(a5)+,(a1)+		; Perform layout copy
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_52800
		jmp	Refresh_PlaneFullDirect(pc)	; Redraw screen directly

; =============== S U B R O U T I N E =======================================


FBZ1Screen_CheckInRange:
		move.w	Player_2+x_pos.w,d2	; NAT: Fix for tails
		move.w	Player_2+y_pos.w,d3
		cmp.b	#6,Player_2+routine.w	; check if Tails ded
		blo.s	.notded2		; if not, branch
		move.w	d0,d2			; copy Sonic's x-pos
		move.w	d1,d3			; copy Sonic's y-pos

.notded2	cmp.b	#6,Player_1+routine.w	; check if Sanik ded
		blo.s	.notded1		; if not, branch
		move.w	d2,d0			; copy Tails's x-pos
		move.w	d3,d1			; copy Tails's y-pos

.notded1	cmp.w	(a1),d2
		blo.s	.chkson
		cmp.w	2(a1),d2
		bhi.s	.chkson
		cmp.w	4(a1),d3
		blo.s	.chkson
		cmp.w	6(a1),d3
		bhi.s	.chkson
		rts

.chkson		cmp.w	(a1)+,d0
		blo.s	loc_52822
		cmp.w	(a1)+,d0
		bhi.s	loc_52822
		cmp.w	(a1)+,d1
		blo.s	loc_52822
		cmp.w	(a1)+,d1
		bhi.s	loc_52822
		rts
; ---------------------------------------------------------------------------

loc_52822:
		addq.w	#4,sp
		clr.w	(ScrEvents_Routine2).w

FBZ1Screen_DrawOnly:
		jmp	DrawTilesAsYouMove(pc)

; ---------------------------------------------------------------------------
FBZ1_LayoutModRange:	dc.w   $400,  $F00,  $880,  $A80
		dc.w   $880, $1100,  $180,  $300
		dc.w  $1400, $1B80,  $900,  $B00
		dc.w  $1A80, $2100,   $80,  $200
		dc.w  $2080, $2680,  $100,  $280
		dc.w	  0,  $180,  $580,  $780
; ---------------------------------------------------------------------------

FBZ1_BackgroundInit:
		jsr	Create_New_Sprite.w
		bne.s	loc_5286A
		move.l	#Obj_FBZOutdoorBGMotion,(a1)

loc_5286A:
		cmpi.w	#$180,(Player_1+x_pos).w
		bhs.s	loc_528A4
		st	(ScrEvents_4).w		; if player is at start, then he's outside. Set outdoors flag
		lea	Pal_FBZBGOutdoors(pc),a1
		lea	(Target_palette_line_4+$4).w,a5
		move.l	(a1)+,(a5)+		; Change to outdoor palette
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		jsr	FBZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	#$200,d1		; Outdoor BG is $200 pixels right of indoor BG
		moveq	#0,d0
		jsr	Refresh_PlaneFull(pc)
		lea	FBZ_OutBGDeformArray(pc),a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_528A4:
		jsr	FBZ_Deform(pc)		; Indoors
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	FBZ_InBGDeformArray(pc),a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

FBZ1_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_528C6(pc,d0.w)
; ---------------------------------------------------------------------------

loc_528C6:
		bra.w	FBZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	FBZ1BGE_ChangeTopDown
; ---------------------------------------------------------------------------
		bra.w	FBZ1BGE_ChangeBottomUp
; ---------------------------------------------------------------------------
		bra.w	FBZ1BGE_ChangeLeftRight
; ---------------------------------------------------------------------------
		bra.w	FBZ1BGE_ChangeRightLeft
; ---------------------------------------------------------------------------

FBZ1BGE_ChangeTopDown:
		jsr	FBZ1_CheckBGChange(pc)

loc_528DE:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		tst.w	(ScrEvents_4).w
		beq.s	loc_528F0
		move.w	#$200,d1
		moveq	#0,d2

loc_528F0:
		jsr	Draw_PlaneVertTopDown(pc)
		bpl.w	FBZ1BGE_GoDeform
		clr.w	(TrigEvents_Routine).w
		bra.w	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

FBZ1BGE_ChangeBottomUp:
		jsr	FBZ1_CheckBGChange(pc)

loc_52904:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		tst.w	(ScrEvents_4).w
		beq.s	loc_52916
		move.w	#$200,d1
		moveq	#0,d2

loc_52916:
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	FBZ1BGE_GoDeform
		clr.w	(TrigEvents_Routine).w
		bra.w	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

FBZ1BGE_ChangeLeftRight:
		jsr	FBZ1_CheckBGChange(pc)

loc_5292A:
		move.w	(Camera_Y_pos_BG_copy).w,d1
		moveq	#0,d2
		tst.w	(ScrEvents_4).w
		beq.s	loc_5293C
		moveq	#0,d1
		move.w	#$200,d2

loc_5293C:
		jsr	Draw_PlaneHorzLeftToRight(pc)
		bpl.w	FBZ1BGE_GoDeform
		clr.w	(TrigEvents_Routine).w
		bra.w	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

FBZ1BGE_ChangeRightLeft:
		jsr	FBZ1_CheckBGChange(pc)

loc_52950:
		move.w	(Camera_Y_pos_BG_copy).w,d1
		moveq	#0,d2
		tst.w	(ScrEvents_4).w
		beq.s	loc_52962
		moveq	#0,d1
		move.w	#$200,d2

loc_52962:
		jsr	Draw_PlaneHorzRightToLeft(pc)
		bpl.w	FBZ1BGE_GoDeform
		clr.w	(TrigEvents_Routine).w
		bra.w	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

FBZ1BGE_Normal:
		tst.w	(ScrEvents_2).w
		beq.s	loc_529EE
		clr.w	(ScrEvents_2).w		; Check for transition flag
		movem.l	d7-a0/a2-a3,-(sp)
		moveq	#$1C,d0
		jsr	Load_PLC.w
		move.w	#$401,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(NoReset_RespawnTbl).w
		jsr	Clear_Switches.w
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		moveq	#$13,d0
		jsr	LoadPalette_Immediate.w
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$2E00,d0
		moveq	#0,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		jsr	FBZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		bra.s	FBZ1BGE_GoDeform
; ---------------------------------------------------------------------------

loc_529EE:

loc_529F8:
		jsr	FBZ1_CheckBGChange(pc)

FBZ1BGE_GoDeform:

		move.w	(ScrEvents_4).w,d1
		beq.s	loc_52A06
		move.w	#$200,d1

loc_52A06:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	FBZ_InBGDeformArray(pc),a4
		tst.w	(ScrEvents_4).w
		beq.s	loc_52A22
		lea	FBZ_OutBGDeformArray(pc),a4

loc_52A22:
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)

; =============== S U B R O U T I N E =======================================


FBZ_Deform:

		tst.w	(ScrEvents_4).w
		bne.s	loc_52A70
		move.w	(Camera_Y_pos_copy).w,d0	; Indoors
		asr.w	#1,d0
		move.w	d0,d1
		asr.w	#5,d1
		sub.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w	; Effective BG Y is slightly below half speed of normal BG Y
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		lea	(Block_table+$1800).w,a1
		lea	FBZ_InBGDeformIndex(pc),a5
		moveq	#0,d2

loc_52A56:
		move.b	(a5)+,d3
		bmi.s	locret_52A6E
		ext.w	d3
		swap	d0

loc_52A5E:
		move.b	(a5)+,d2
		move.w	d0,(a1,d2.w)
		dbf	d3,loc_52A5E
		swap	d0
		add.l	d1,d0
		bra.s	loc_52A56
; ---------------------------------------------------------------------------

locret_52A6E:
		rts
; ---------------------------------------------------------------------------

loc_52A70:
		moveq	#$16,d0				; Outdoors
		add.w	(ScrEvents_6).w,d0	; Add offset of bobbing motion to 16
		move.w	d0,(Camera_Y_pos_BG_copy).w

		lea	(Block_table+$1800).w,a1		; get deform data offset
		lea	FBZ_OutBGDeformIndex(pc),a5	; get data offset array to a5
		move.w	(Camera_X_pos_copy).w,d0	; load camera x-pos copy to d0
		swap	d0				; swap
		clr.w	d0				; clear low word of d0
		asr.l	#4,d0				; divide x-pos by 16
		move.l	d0,d1				; copy to d1
		asr.l	#1,d1				; halve d1

		move.l	(Block_table+$19FC).w,d2		; Get cloud movement speed
		addi.l	#$E00,(Block_table+$19FC).w		; increase it
		moveq	#8,d3

loc_52A9E:
		move.w	(a5)+,d4			; get the next offset to write data to
		add.l	d2,d0				; add cloud speed to d0
		swap	d0				; get the real offset to d0
		move.w	d0,(a1,d4.w)			; save as plane position
		swap	d0				; swap back
		add.l	d1,d0				; add half speed to d0
		dbf	d3,loc_52A9E			; loop
		rts
; End of function FBZ_Deform


; =============== S U B R O U T I N E =======================================


FBZ1_CheckBGChange:
		move.w	Camera_X_Pos.w,d0	; NAT: Get approx camera pos as fake
		add.w	#320/2,d0		; Dont judge me =/
		move.w	Camera_Y_Pos.w,d1
		add.w	#224/2,d1
	;	move.w	(Player_1+x_pos).w,d0
	;	move.w	(Player_1+y_pos).w,d1
		move.w	(ScrEvents_Routine2).w,d2	; The BG change events are synced with the layout mod events in screen events. Each numbered routine
		jmp	loc_52AC2(pc,d2.w)		; here corresponds with the same layoutmod number in FBZ1_ScreenEvents
; End of function FBZ1_CheckBGChange

; ---------------------------------------------------------------------------

loc_52AC2:
		bra.w	FBZ_Deform		; If no event, then just do business as usual
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange1
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange2
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange3
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange4
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange5
; ---------------------------------------------------------------------------
		bra.w	FBZ1_BGChange6
; ---------------------------------------------------------------------------

FBZ1_BGChange1:
		tst.w	(ScrEvents_4).w
		bne.s	loc_52AFE
		cmpi.w	#$B00,d0		; If indoors
		bhs.s	loc_52AF4
		cmpi.w	#$9C0,d1
		blo.w	FBZ_Deform
		bra.s	loc_52B22
; ---------------------------------------------------------------------------

loc_52AF4:
		cmpi.w	#$900,d1
		blo.w	FBZ_Deform
		bra.s	loc_52B22
; ---------------------------------------------------------------------------

loc_52AFE:
		cmpi.w	#$B00,d0		; If outdoors
		bhs.s	loc_52B0E
		cmpi.w	#$9C0,d1
		bhi.w	FBZ_Deform
		bra.s	loc_52B16
; ---------------------------------------------------------------------------

loc_52B0E:
		cmpi.w	#$900,d1
		bhi.w	FBZ_Deform

loc_52B16:
		clr.w	(ScrEvents_4).w
		moveq	#4,d0
		moveq	#0,d6
		bra.w	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

loc_52B22:

		st	(ScrEvents_4).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.w	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

FBZ1_BGChange2:
		tst.w	(ScrEvents_4).w
		bne.s	loc_52B50
		cmpi.w	#$C80,d0
		bhs.s	loc_52B46
		cmpi.w	#$2C0,d1
		bhi.w	FBZ_Deform
		bra.s	loc_52B76
; ---------------------------------------------------------------------------

loc_52B46:
		cmpi.w	#$240,d1
		bhi.w	FBZ_Deform
		bra.s	loc_52B76
; ---------------------------------------------------------------------------

loc_52B50:
		cmpi.w	#$C80,d0
		bhs.s	loc_52B60
		cmpi.w	#$2C0,d1
		blo.w	FBZ_Deform
		bra.s	loc_52B68
; ---------------------------------------------------------------------------

loc_52B60:
		cmpi.w	#$240,d1
		blo.w	FBZ_Deform

loc_52B68:
		clr.w	(ScrEvents_4).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.w	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

loc_52B76:

		st	(ScrEvents_4).w
		moveq	#4,d0
		moveq	#0,d6
		bra.w	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

FBZ1_BGChange3:
		tst.w	(ScrEvents_4).w
		bne.s	loc_52BA2
		cmpi.w	#$1880,d0
		bhs.s	loc_52B98

loc_52B8E:
		cmpi.w	#$9C0,d1
		blo.w	FBZ_Deform
		bra.s	loc_52BC6
; ---------------------------------------------------------------------------

loc_52B98:
		cmpi.w	#$940,d1
		blo.w	FBZ_Deform
		bra.s	loc_52BC6
; ---------------------------------------------------------------------------

loc_52BA2:
		cmpi.w	#$1880,d0
		bhs.s	loc_52BB2
		cmpi.w	#$9C0,d1
		bhi.w	FBZ_Deform
		bra.s	loc_52BBA
; ---------------------------------------------------------------------------

loc_52BB2:
		cmpi.w	#$940,d1
		bhi.w	FBZ_Deform

loc_52BBA:
		clr.w	(ScrEvents_4).w
		moveq	#4,d0
		moveq	#0,d6
		bra.w	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

loc_52BC6:

		st	(ScrEvents_4).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.w	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

FBZ1_BGChange4:
		cmpi.w	#$100,d1
		blo.s	loc_52C0C
		tst.w	(ScrEvents_4).w
		bne.s	loc_52BEA
		cmpi.w	#$1C0,d1
		bhi.w	FBZ_Deform
		bra.s	loc_52C00
; ---------------------------------------------------------------------------

loc_52BEA:
		cmpi.w	#$1C0,d1
		blo.w	FBZ_Deform
		clr.w	(ScrEvents_4).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.w	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

loc_52C00:
		st	(ScrEvents_4).w
		moveq	#4,d0
		moveq	#0,d6
		bra.w	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

loc_52C0C:
		tst.w	(ScrEvents_4).w
		bne.s	loc_52C1C
		cmpi.w	#$1B00,d0
		blo.w	FBZ_Deform
		bra.s	loc_52C2E
; ---------------------------------------------------------------------------

loc_52C1C:
		cmpi.w	#$1B00,d0
		bhi.w	FBZ_Deform
		clr.w	(ScrEvents_4).w
		moveq	#$C,d0
		moveq	#0,d6
		bra.s	loc_52C3E
; ---------------------------------------------------------------------------

loc_52C2E:
		st	(ScrEvents_4).w
		moveq	#$10,d0
		move.w	#$3F0,d6
		lea	Pal_FBZBGOutdoors(pc),a1
		bra.s	loc_52C42
; ---------------------------------------------------------------------------

loc_52C3E:
		lea	Pal_FBZBGIndoors(pc),a1		; Special case for going left/right rather than up/down

loc_52C42:
		lea	(Normal_palette_line_4+$4).w,a5
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.w	d0,(TrigEvents_Routine).w
		jsr	FBZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	d6,(DrawDelayed_Position).w
		move.w	#$1F,(DrawDelayed_RowCount).w
		addq.w	#4,sp
		cmpi.w	#$C,(TrigEvents_Routine).w
		beq.w	loc_5292A
		bra.w	loc_52950
; ---------------------------------------------------------------------------

FBZ1_BGChange5:
		tst.w	(ScrEvents_4).w
		bne.s	loc_52C84
		cmpi.w	#$240,d1
		bhi.w	FBZ_Deform
		bra.s	loc_52C98
; ---------------------------------------------------------------------------

loc_52C84:
		cmpi.w	#$240,d1
		blo.w	FBZ_Deform
		clr.w	(ScrEvents_4).w
		moveq	#8,d0
		move.w	#$F0,d6
		bra.s	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

loc_52C98:
		st	(ScrEvents_4).w
		moveq	#4,d0
		moveq	#0,d6
		bra.s	FBZ_BGChangeGoOut
; ---------------------------------------------------------------------------

FBZ1_BGChange6:
		tst.w	(ScrEvents_4).w
		bne.s	loc_52CB2
		cmpi.w	#$640,d1
		blo.w	FBZ_Deform
		bra.s	loc_52CC4
; ---------------------------------------------------------------------------

loc_52CB2:
		cmpi.w	#$640,d1
		bhi.w	FBZ_Deform
		clr.w	(ScrEvents_4).w
		moveq	#4,d0
		moveq	#0,d6
		bra.s	FBZ_BGChangeGoIn
; ---------------------------------------------------------------------------

loc_52CC4:
		st	(ScrEvents_4).w
		moveq	#8,d0
		move.w	#$F0,d6

FBZ_BGChangeGoOut:

		lea	Pal_FBZBGOutdoors(pc),a1
		bra.s	loc_52CD8
; ---------------------------------------------------------------------------

FBZ_BGChangeGoIn:

		lea	Pal_FBZBGIndoors(pc),a1

loc_52CD8:
		lea	(Normal_palette_line_4+$4).w,a5
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+			; Modify the palette as needed
		move.w	d0,(TrigEvents_Routine).w	; Set the appropriate BG event to handle the change
		jsr	FBZ_Deform(pc)			; Do deformation as normal
		jsr	Reset_TileOffsetPositionEff(pc)
		add.w	d6,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,sp				; Finish here without doing anything else
		cmpi.w	#4,(TrigEvents_Routine).w
		beq.w	loc_528DE
		bra.w	loc_52904
; ---------------------------------------------------------------------------

Obj_FBZOutdoorBGMotion:

		move.l	#$2800,d0			; Uses built-in bobbing motion function to move BG up and down
		move.l	#$80,d1
		jsr	Gradual_SwingOffset.w
		move.w	d0,(ScrEvents_6).w
		rts
; ---------------------------------------------------------------------------
FBZ_InBGDeformArray:	dc.w $80

		dc.w $40
		dc.w $20
		dc.w 8
		dc.w 8
		dc.w 8
		dc.w 8
		dc.w $28
		dc.w $30
		dc.w 8
		dc.w 4
		dc.w 4
		dc.w $B8
		dc.w $30
		dc.w $10
		dc.w $10
		dc.w $30
		dc.w $28
		dc.w $18
		dc.w $10
		dc.w $30
		dc.w $30
		dc.w $10
		dc.w $10
		dc.w $30
		dc.w $28
		dc.w $18
		dc.w $10
		dc.w $B0
		dc.w $30
		dc.w $28
		dc.w $40
		dc.w $18
		dc.w $30
		dc.w $7FFF
FBZ_OutBGDeformArray:	dc.w $30

		dc.w $20
		dc.w $30
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $7FFF
FBZ_InBGDeformIndex:	dc.b    0,  $C,   1,  $A, $16,  $A,   8, $14, $18, $1C, $20, $24, $28, $2C, $30, $34, $38,   2,   6, $12
		dc.b  $3E,   0, $46,   7,   4, $10, $1E, $26, $2E, $36, $3A, $40,   3,  $E, $22, $32, $3C,   1,   0, $44
		dc.b    3,   2, $1A, $2A, $42, $FF
FBZ_OutBGDeformIndex:	dc.w $E
		dc.w 2
		dc.w $A
		dc.w 6
		dc.w $C
		dc.w 4
		dc.w 8
		dc.w 0
		dc.w $10

Pal_FBZBGIndoors:	binclude "Levels/FBZ/Palettes/FBZ BG Indoors.bin"
	even
Pal_FBZBGOutdoors:	binclude "Levels/FBZ/Palettes/FBZ BG Outdoors.bin"
	even
; ---------------------------------------------------------------------------

FBZ2_ScreenInit:
		move.w	#$2C40,d0
		cmp.w	(Camera_X_pos).w,d0
		bhi.s	loc_52E2C
		move.w	#4,(ScrEvents_Routine).w	; If screen X is past subboss battle, change screen event
		move.w	d0,(Camera_min_X_pos).w
		jsr	SetUp_FBZ2BossEvent(pc)
		clr.l	(__u_EE98).w
		clr.l	(__u_EE9C).w		; Clear BG camera offset
		move.w	#-$2000,d7
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(ArtKosM_FBZCloud).l,a1
		move.w	#$7460,d2
		jsr	Queue_Kos_Module.w
		lea	(ArtKosM_FBZBossPillar).l,a1
		move.w	#$7AA0,d2
		jsr	Queue_Kos_Module.w	; Load boss event graphics
		movem.l	(sp)+,d7-a0/a2-a3

loc_52E2C:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

FBZ2_ScreenEvent:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(ScrEvents_Routine).w,d0
		jmp	loc_52E44(pc,d0.w)
; ---------------------------------------------------------------------------

loc_52E44:
		bra.w	FBZ2SE_Normal
; ---------------------------------------------------------------------------
		bra.w	FBZ2SE_BossEvent
; ---------------------------------------------------------------------------
		bra.w	FBZ2SE_BossEventRefresh
; ---------------------------------------------------------------------------
		bra.w	FBZ2SE_BossEventEnd
; ---------------------------------------------------------------------------

FBZ2SE_Normal:

loc_52E5E:
		lea	FBZ2_LayoutModRange(pc),a1		; Only one layout mod this time around
		move.w	Camera_X_Pos.w,d0			; NAT: Fuck it, camera pos it is
		move.w	Camera_Y_Pos.w,d1
		add.w	#320/2,d0
		add.w	#224/2,d1
		move.w	(ScrEvents_Routine2).w,d2
		jmp	loc_52E72(pc,d2.w)
; ---------------------------------------------------------------------------

loc_52E72:
		bra.w	FBZ2_NoLayoutMod
; ---------------------------------------------------------------------------
		bra.w	FBZ2_LayoutMod1
; ---------------------------------------------------------------------------

FBZ2_NoLayoutMod:
		cmp.w	(a1)+,d0
		blo.s	loc_52E90
		cmp.w	(a1)+,d0
		bhi.s	loc_52E90
		cmp.w	(a1)+,d1
		blo.s	loc_52E90
		cmp.w	(a1)+,d1
		bhi.s	loc_52E90
		move.w	#4,(ScrEvents_Routine2).w

loc_52E90:

		jsr	DrawTilesAsYouMove(pc)
		cmpi.w	#$2900,Camera_X_pos.w		; NAT: Hide hud if close enoguh
		shs	MonContPos.w			; hide HUD now

		cmpi.w	#$2B30,(Camera_X_pos).w
		blo.s	locret_52EAC
		jsr	SetUp_FBZ2BossEvent(pc)		; If Player passes certain point, set up the boss event
		clr.l	(__u_EE98).w
		clr.l	(__u_EE9C).w
		addq.w	#4,(ScrEvents_Routine).w

locret_52EAC:
		rts
; ---------------------------------------------------------------------------

FBZ2_LayoutMod1:
		jsr	FBZ1Screen_CheckInRange(pc)
		cmpi.w	#$E00,d0
		blo.s	loc_52EBE
		cmpi.w	#$1280,d0
		bls.s	loc_52F10

loc_52EBE:
		tst.w	(ScrEvents_3).w
		bne.s	loc_52ECC
		cmpi.w	#$B0E,d1		; If indoors
		bls.s	loc_52F10
		bra.s	loc_52EDE
; ---------------------------------------------------------------------------

loc_52ECC:
		cmpi.w	#$AF2,d1		; If outdoors
		bhi.s	loc_52F10
		clr.w	(ScrEvents_3).w
		movea.w	(a3),a5
		lea	$70(a5),a5
		bra.s	loc_52EEA
; ---------------------------------------------------------------------------

loc_52EDE:
		st	(ScrEvents_3).w
		movea.w	$10(a3),a5
		lea	$70(a5),a5

loc_52EEA:
		movea.w	$50(a3),a1
		lea	$1A(a1),a1
		move.w	-8(a3),d0
		subi.w	#$E,d0		; Width of 14 tiles
		moveq	#3,d1		; Height of 4 tiles

loc_52EFC:
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_52EFC
		jmp	Refresh_PlaneFullDirect(pc)
; ---------------------------------------------------------------------------

loc_52F10:

		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

FBZ2SE_BossEvent:
		move.w	#-$2000,d7			; Draw FG tiles on BG plane instead
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

FBZ2SE_BossEventRefresh:
		move.w	#-$2000,d7
		move.w	#$2D00,d1
		moveq	#0,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	FBZ2SE_BossEventEnd
		addq.w	#4,(ScrEvents_Routine).w

FBZ2SE_BossEventEnd:
		rts

; =============== S U B R O U T I N E =======================================


SetUp_FBZ2BossEvent:

		jsr	Create_New_Sprite.w
		bne.s	loc_52F7A
		move.l	#Obj_FBZEndBossEventControl,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_52F7A
		move.l	#Obj_FBZBossPillar,(a1)
		lea	(VScrollBuffer).w,a5
		moveq	#0,d1
		moveq	#4,d2

loc_52F56:
		move.l	d1,(a5)+		; Reset object addresses for clouds
		dbf	d2,loc_52F56
		lea	(VScrollBuffer).w,a5
		moveq	#9,d1

loc_52F62:
		jsr	(CreateNewSprite4).l
		bne.s	loc_52F7A
		move.w	a1,(a5)+
		move.l	#Obj_FBZCloud,(a1)	; Create cloud objects and place addresses in FFEEEA
		move.w	d1,$2E(a1)
		dbf	d1,loc_52F62

loc_52F7A:

		lea	Pal_FBZBGOutdoors(pc),a1	; Modify palette
		lea	(Normal_palette_line_4+$2).w,a5
		lea	(Target_palette_line_4+$2).w,a6
		move.w	#$EEE,(a5)+
		move.w	#$EEE,(a6)+
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		rts
; End of function SetUp_FBZ2BossEvent

; ---------------------------------------------------------------------------
FBZ2_LayoutModRange:	dc.w $D80, $1300, $A00,	$B80
; ---------------------------------------------------------------------------

FBZ2_BackgroundInit:
		jsr	Create_New_Sprite.w
		bne.s	loc_52FB6
		move.l	#Obj_FBZOutdoorBGMotion,(a1)

loc_52FB6:
		cmpi.w	#$2C40,(Camera_X_pos).w
		blo.s	loc_53002
		move.w	#$10,(TrigEvents_Routine).w		; If in boss event area, set BG event
		move.w	(a3),d0
		move.w	d0,$70(a3)			; Copy top BG line to bottom BG line (I guess so the scrolling doesn't garble the screen?)
		move.w	d0,$74(a3)
		move.w	d0,$78(a3)
		move.w	d0,$7C(a3)
		st	(ScrShake_Value).w			; Start shaking
		move.w	#-$4000,d7
		jsr	FBZ2_CloudDeform(pc)	; Deform the cloud sprites
		jsr	Reset_TileOffsetPositionEff(pc)
		jsr	Refresh_PlaneFull(pc)
		jsr	PlainDeformation_Flipped(pc)	; Reverse deformation
		jsr	Get_BGActualEffectiveDiff(pc)
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp

locret_53000:
		rts
; ---------------------------------------------------------------------------

loc_53002:
		jsr	FBZ_Deform(pc)			; Nromal play
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	FBZ_InBGDeformArray(pc),a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

FBZ2_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_53024(pc,d0.w)
; ---------------------------------------------------------------------------

loc_53024:
		bra.w	FBZ2BGE_Init
; ---------------------------------------------------------------------------
		bra.w	FBZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	FBZ2BGE_ChangeTopDown
; ---------------------------------------------------------------------------
		bra.w	FBZ2BGE_ChangeBottomUp
; ---------------------------------------------------------------------------
		bra.w	FBZ2BGE_BossEvent
; ---------------------------------------------------------------------------

FBZ2BGE_ChangeTopDown:
		jsr	FBZ2_CheckBGChange(pc)

loc_5303C:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		tst.w	(ScrEvents_4).w
		beq.s	loc_5304E
		move.w	#$200,d1
		moveq	#0,d2

loc_5304E:
		jsr	Draw_PlaneVertTopDown(pc)
		bpl.s	loc_530BA
		move.w	#4,(TrigEvents_Routine).w
		bra.s	loc_530BA
; ---------------------------------------------------------------------------

FBZ2BGE_ChangeBottomUp:
		jsr	FBZ2_CheckBGChange(pc)

loc_53060:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		tst.w	(ScrEvents_4).w
		beq.s	loc_53072
		move.w	#$200,d1
		moveq	#0,d2

loc_53072:
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.s	loc_530BA
		move.w	#4,(TrigEvents_Routine).w
		bra.s	loc_530BA
; ---------------------------------------------------------------------------

FBZ2BGE_Init:
		move.w	(a3),d0
		move.w	d0,$70(a3)
		move.w	d0,$74(a3)
		move.w	d0,$78(a3)
		move.w	d0,$7C(a3)			; Copy BG lines
		addq.w	#4,(TrigEvents_Routine).w	; Next BG Event

FBZ2BGE_Normal:
		tst.w	(ScrEvents_Routine).w
		beq.s	loc_530AC
		jsr	FBZ2_CloudDeform(pc)	; If boss event has started
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	#$10,(TrigEvents_Routine).w
		bra.s	loc_530F0
; ---------------------------------------------------------------------------

loc_530AC:

loc_530B6:
		jsr	FBZ2_CheckBGChange(pc)

loc_530BA:

		move.w	(ScrEvents_4).w,d1
		beq.s	loc_530C4
		move.w	#$200,d1

loc_530C4:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	FBZ_InBGDeformArray(pc),a4
		tst.w	(ScrEvents_4).w
		beq.s	loc_530E0
		lea	FBZ_OutBGDeformArray(pc),a4

loc_530E0:
		lea	(Block_table+$1800).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

FBZ2BGE_BossEvent:
		jsr	FBZ2_CloudDeform(pc)

loc_530F0:
		move.w	#-$4000,d7
		jsr	DrawBGAsYouMove(pc)		; Draw BG on plane A
		jsr	PlainDeformation_Flipped(pc)
		jsr	Get_BGActualEffectiveDiff(pc)
		jsr	ShakeScreen_Setup.w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp
		tst.w	(ScrEvents_5).w
		beq.w	locret_5318A
		clr.w	(ScrEvents_5).w		; If boss has been loaded
		move.w	(__u_EE9C).w,d0
		clr.w	(__u_EE9C).w		; Get final Y offset and clear it

		move.l	#Ranges_FBZB,d1
		move.l	d1,BoxLoc_Level.w		; NAT: switch to boss specific boxers
		move.l	d1,BoxLoc_Play1.w
		move.l	d1,BoxLoc_Play2.w
		move.w	#Boxes_FBZB-Ranges_FBZB,SpawnBoxPos.w

		btst	#1,(Player_1+$2A).w
		beq.s	.tails			; NAT: Fix for tails
		add.w	d0,(Player_1+y_pos).w	; If player is not on ground, adjust his Y position properly

.tails		btst	#1,Player_2+status.w
		beq.s	loc_53134
		add.w	d0,(Player_2+y_pos).w

loc_53134:
		add.w	d0,(Camera_Y_pos).w
		add.w	d0,(Camera_Y_pos_copy).w
		add.w	d0,(Camera_min_Y_pos).w
		add.w	d0,(Camera_max_Y_pos).w	; Add offset to camera Ys
		move.w	(Camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		move.w	(__u_EE98).w,d0
		clr.w	(__u_EE98).w
		sub.w	d0,(Player_1+x_pos).w

loc_53156:
		sub.w	d0,(Player_2+x_pos).w	; Adjust X position of players
		sub.w	d0,(Camera_X_pos).w

loc_5315E:
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w	; and of cameras
		movea.w	(Level_layout_main+$2C).w,a1	; $580 Y of FG
		lea	$5C(a1),a1				; $2D00 X of FG
		move.w	(Level_layout_header).w,d0
		subi.w	#$14,d0
		moveq	#3,d1

loc_5317C:
		moveq	#$13,d2

loc_5317E:
		clr.b	(a1)+				; Clear large area of FG, probably erasing the copied FG area from the layout mod
		dbf	d2,loc_5317E
		adda.w	d0,a1
		dbf	d1,loc_5317C

locret_5318A:
		rts

; =============== S U B R O U T I N E =======================================


FBZ2_CloudDeform:

		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$300,d0
		add.w	(__u_EE9C).w,d0		; Add camera BG Y to Y event offset
		move.w	d0,(Camera_Y_pos_BG_copy).w		; Make that the effective Y
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$2600,d0
		sub.w	(__u_EE98).w,d0
		move.w	d0,(Camera_X_pos_BG_copy).w		; Do the same with the X values
		lea	(Block_table+$1800).w,a1
		lea	FBZ2_CloudDeformIndex(pc),a5
		move.w	(Camera_X_pos_BG_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#2,d1
		move.l	(Block_table+$19FC).w,d2
		asr.l	#3,d2
		addi.l	#$8000,(Block_table+$19FC).w	; Perform cloud movement
		moveq	#9,d3

loc_531D2:
		move.w	(a5)+,d4
		add.l	d2,d0
		swap	d0
		move.w	d0,(a1,d4.w)		; Set up cloud speeds
		swap	d0
		add.l	d1,d0
		dbf	d3,loc_531D2
		lea	(Block_table+$1800).w,a1
		lea	(VScrollBuffer).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	(ScrShake_Offset).w,d1
		sub.w	d1,d0
		asr.w	#1,d0
		add.w	d1,d0
		neg.w	d0
		add.w	(ScrEvents_6).w,d0	; Get effective Y, add BG motion offset to it
		moveq	#9,d1

loc_53202:
		move.w	(a5)+,d2
		beq.s	loc_5322E
		movea.w	d2,a6			; Load cloud address
		move.w	$30(a6),d3		; Get Y position
		add.w	d0,d3			; Add ofset
		andi.w	#$FF,d3
		addi.w	#$74,d3
		move.w	d3,$14(a6)		; Load to actual Y
		move.w	(a1)+,d3
		neg.w	d3
		add.w	$2E(a6),d3
		andi.w	#$1FF,d3
		addi.w	#$54,d3
		move.w	d3,$10(a6)		; Do the same to the X

loc_5322E:
		dbf	d1,loc_53202
		rts
; End of function FBZ2_CloudDeform


; =============== S U B R O U T I N E =======================================


FBZ2_CheckBGChange:

		move.w	Camera_X_Pos.w,d0	; NAT: Get approx camera pos as fake
		add.w	#320/2,d0		; Dont judge me =/
		move.w	Camera_Y_Pos.w,d1
		add.w	#224/2,d1
		move.w	(ScrEvents_Routine2).w,d2		; You know how this goes by now
		jmp	loc_53244(pc,d2.w)
; End of function FBZ1_CheckBGChange

; ---------------------------------------------------------------------------

loc_53244:
		bra.w	FBZ_Deform
; ---------------------------------------------------------------------------
		tst.w	(ScrEvents_4).w
		bne.s	loc_53258
		cmpi.w	#$A40,d1
		blo.w	FBZ_Deform
		bra.s	loc_5326A
; ---------------------------------------------------------------------------

loc_53258:
		cmpi.w	#$A40,d1
		bhi.w	FBZ_Deform
		clr.w	(ScrEvents_4).w
		moveq	#8,d0
		moveq	#0,d6
		bra.s	loc_5327A
; ---------------------------------------------------------------------------

loc_5326A:
		st	(ScrEvents_4).w
		moveq	#$C,d0
		move.w	#$F0,d6
		lea	Pal_FBZBGOutdoors(pc),a1
		bra.s	loc_5327E
; ---------------------------------------------------------------------------

loc_5327A:
		lea	Pal_FBZBGIndoors(pc),a1

loc_5327E:
		lea	(Normal_palette_line_4+$4).w,a5
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.l	(a1)+,(a5)+
		move.w	d0,(TrigEvents_Routine).w
		jsr	FBZ_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		add.w	d6,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,sp
		cmpi.w	#8,(TrigEvents_Routine).w
		beq.w	loc_5303C
		bra.w	loc_53060
; ---------------------------------------------------------------------------

Obj_FBZEndBossEventControl:
		move.l	#loc_532E0,(a0)
		move.b	#$11,6(a0)
		bset	#7,$2A(a0)
		move.w	#$2B40,Camera_max_X_pos.w	; force camera max pos
		st	MonContPos.w			; hide HUD if close enough
		move.w	#$3C,d0

loc_532DC:
		move.w	d0,(Camera_min_Y_pos).w		;

loc_532E0:
		cmpi.w	#$2E80,Player_2+x_pos.w		; NAT: Tails too
		bhs.s	.sex
		cmpi.w	#$2E80,(Player_1+x_pos).w
		blo.w	loc_533A4
.sex		move.l	#loc_532F0,(a0)			; If Sonic has passed $2E80 X, start moving the BG

loc_532F0:
		st	(BG_Collision).w				; Set BG collision on
		addi.l	#$A000,(__u_EE9C).w
		addi.l	#$7800,(__u_EE98).w	; Move the extra BG camera by a set amount

		cmp.w	#$3240,Camera_X_pos.w	; NAT: Check if we are at that end section
		blo.s	.nop			; if not, skip
		cmp.w	#$280,Camera_Y_pos.w
		bhs.s	.nop
		addi.l	#$7800*2,(__u_EE98).w	; move camera faster
		addi.l	#$A000*2,(__u_EE9C).w

.nop		cmpi.w	#$5D0,(__u_EE9C).w
		blo.s	loc_5333A
		move.w	#$5D0,(__u_EE9C).w		; When BG has reached end point
		move.w	#$45C,(__u_EE98).w
		clr.b	(BG_Collision).w			; Stop BG collision
		move.l	#loc_53322,(a0)

loc_53322:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	(Camera_Y_pos).w,d0
		bne.s	loc_5333A
		move.w	d0,(Camera_max_Y_pos).w		; Lock screen when camera has scrolled as high as possible
		move.w	d0,(Camera_target_max_Y_pos).w
		move.l	#loc_5333A,(a0)

loc_5333A:
		cmpi.w	#$280,Player_2+y_pos.w		; NAT: Tails
		blo.s	.sex
		cmpi.w	#$280,(Player_1+y_pos).w
		bhs.s	loc_53348
.sex		move.w	(Camera_X_pos).w,(Camera_min_X_pos).w	; If player is above $280 Y then lock screen X as you move

loc_53348:
		move.w	(Camera_min_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	loc_533A4
		move.w	(Camera_max_X_pos).w,d0
		cmp.w	(Camera_min_X_pos).w,d0
		bne.s	loc_533A4
		move.w	#$F0,(DrawDelayed_Position).w		; When the screen is completely locked, start proper Screen Events
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(ScrEvents_Routine).w		; Next screen event
		move.l	#loc_53372,(a0)

loc_53372:
		cmpi.w	#$C,(ScrEvents_Routine).w
		bne.s	loc_533A4
		jsr	Create_New_Sprite.w
		bne.s	loc_53388				; When screen event has finished, load the boss
		move.l	#Obj_FBZEndBoss,(a1)

loc_53388:
		clr.w	(ScrShake_Value).w			; Stop shaking
		st	(ScrEvents_5).w				; Set variable when boss has loaded
		move.w	#$31C0,d0
		move.w	#$31C0,d4
		move.w	#$690,d1
		move.l	#loc_533A4,(a0)
		bra.s	loc_533B8
; ---------------------------------------------------------------------------

loc_533A4:

		move.w	$10(a0),d4
		move.w	#$31C0,d0
		add.w	(__u_EE98).w,d0
		move.w	#$690,d1
		sub.w	(__u_EE9C).w,d1

loc_533B8:
		move.w	d0,$10(a0)
		move.w	d1,$14(a0)
		move.w	#$4C0,d1
		moveq	#$11,d2
		moveq	#$11,d3
		jmp	SolidObjectTop.w
; ---------------------------------------------------------------------------

Obj_FBZBossPillar:
		move.l	#Obj_FBZBossPillarMain,(a0)
		move.b	#$44,4(a0)			; Set up boss pillar object
		move.b	#-1,6(a0)
		move.b	#$20,7(a0)
		move.w	#prio(6),8(a0)
		move.w	#-$3C2B,$A(a0)
		move.l	#Map_FBZ2Preboss,$C(a0)
		move.w	#2,$16(a0)			; 2 sprites

Obj_FBZBossPillarMain:
		move.w	#$2DE0,d4
		add.w	(__u_EE98).w,d4
		move.w	d4,$10(a0)			; Move pillar to proper X area
		move.w	d4,d0
		move.w	d4,d1
		subi.w	#$200,d0
		tst.w	$30(a0)
		beq.s	loc_5341E
		addi.w	#$28,d1

loc_5341E:
		move.w	#$580,d5
		sub.w	(__u_EE9C).w,d5	; Get proper Y offset
		move.w	d5,d2
		move.w	d5,d3
		addi.w	#$80,d2
		addi.w	#$100,d3
		clr.w	$30(a0)
		lea	(Player_1).w,a1
		bsr.s	FBZBossPillar_CheckPlayerPos
		lea	(Player_2).w,a1
		bsr.s	FBZBossPillar_CheckPlayerPos
		tst.w	$30(a0)
		beq.s	loc_53456
		cmpi.w	#$40,$2E(a0)	; If player is in range, increase pillar offset
		bhs.s	loc_5346A
		addq.w	#8,$2E(a0)
		bra.s	loc_5346A
; ---------------------------------------------------------------------------

loc_53456:
		tst.w	$2E(a0)
		beq.s	loc_5346A
		subq.w	#8,$2E(a0)		; If player is not in range, decrease pillar offset
		bne.s	loc_5346A
		moveq	#-$37,d0		; Play sound only when pillar hits ground
		jsr	Play_Sound_2.w

loc_5346A:

		sub.w	$2E(a0),d5
		move.w	d5,$14(a0)		; Subtract Y from offset and place it in sprite Y
		lea	$18(a0),a1
		addi.w	#$80,d5
		moveq	#1,d0

loc_5347C:
		move.w	d4,(a1)
		move.w	d5,2(a1)
		subi.w	#$100,d5		; Set the sprite positions of each pillar sprite
		addq.w	#6,a1
		dbf	d0,loc_5347C
		moveq	#$2B,d1
		move.w	#$100,d2
		move.w	#$100,d3
		jsr	SolidObjectFull.w	; Make it solid
		jmp	Draw_Sprite.w

; =============== S U B R O U T I N E =======================================


FBZBossPillar_CheckPlayerPos:

		move.w	$10(a1),d6
		cmp.w	d0,d6
		blt.s	locret_534C4
		cmp.w	d1,d6
		bhs.s	locret_534C4
		move.w	$14(a1),d6
		cmp.w	d2,d6
		blo.s	locret_534C4
		cmp.w	d3,d6
		bhs.s	locret_534C4
		tst.b	$2E(a1)
		bmi.s	locret_534C4
		st	$30(a0)

locret_534C4:
		rts
; End of function FBZBossPillar_CheckPlayerPos

; ---------------------------------------------------------------------------

Obj_FBZCloud:
		move.l	#Draw_Sprite,(a0)
		move.b	#$40,4(a0)		; Multisprite routine
		move.b	#$C,6(a0)
		move.b	#$2C,7(a0)
		move.w	#prio(7),8(a0)
		move.w	#$63A3,$A(a0)
		move.l	#Map_FBZ2Preboss,$C(a0)
		move.w	$2E(a0),d0
		add.w	d0,d0
		move.w	d0,d1
		add.w	d0,d0
		add.w	d1,d0
		lea	FBZCloud_PositionFrameData(pc),a1
		adda.w	d0,a1
		move.w	(a1)+,$2E(a0)
		move.w	(a1)+,$30(a0)
		move.w	(a1),d0
		move.b	d0,$22(a0)
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------
Map_FBZ2Preboss:	include "Levels/FBZ/Misc Object Data/Map - Act 2 Preboss.asm"

FBZ2_CloudDeformIndex:	dc.w 4
		dc.w $E
		dc.w 8
		dc.w $10
		dc.w 2
		dc.w $C
		dc.w 6
		dc.w $12
		dc.w $A
		dc.w 0
FBZCloud_PositionFrameData:	dc.w   $1E0,   $EC,	1
		dc.w   $144,   $C8,	2
		dc.w	$60,   $B4,	3
		dc.w	$C4,   $A0,	2
		dc.w   $140,   $84,	1
		dc.w   $1A0,   $6C,	3
		dc.w	$F0,   $54,	1
		dc.w   $160,   $3C,	3
		dc.w	$7C,   $28,	2
		dc.w	$20,	$C,	1
; ---------------------------------------------------------------------------

ICZ1_ScreenInit:
		tst.b	(Last_star_post_hit).w
		bne.s	loc_53648			; If not restarting from a lamppost
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_53648			; And we're Knuckles
		jsr	Create_New_Sprite.w
		bne.s	loc_53648
		move.l	#Obj_ICZTeleporter,(a1)	; Make teleporter object, etc
		move.w	#$3640,(Player_1+x_pos).w
		move.w	#$660,(Player_1+y_pos).w
		move.w	#$35A0,d0
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_X_pos).w
		move.w	#$5FB,d0
		move.w	d0,(Camera_Y_pos_copy).w
		move.w	d0,(Camera_Y_pos).w

loc_53648:

		move.w	#$7FF,(Screen_Y_wrap_value).w
		move.w	#$7F0,(Camera_Y_pos_mask).w
		move.w	#$3C,(Layout_row_index_mask).w		; We're in a looping level!
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

ICZ1_ScreenEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_5366A(pc,d0.w)
; ---------------------------------------------------------------------------

loc_5366A:
		bra.w	ICZ1SE_Init
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_WaitQuake
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ1SE_Normal
; ---------------------------------------------------------------------------

ICZ1SE_Init:
		tst.w	(ScrShake_Value).w
		beq.s	loc_53696
		tst.b	(Ctrl_1_locked).w	; If shaking due to hitting the wall, remove player control temporarily
		bne.s	loc_53696
		st	(Ctrl_1_locked).w
		clr.w	(Ctrl_1_logical).w

loc_53696:

		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_X_pos_copy).w
		bra.s	ICZ1SE_Normal
; ---------------------------------------------------------------------------

ICZ1SE_WaitQuake:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w

ICZ1SE_Normal:

		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

ICZ1_BackgroundInit:
		lea	(a3),a1
		moveq	#7,d0

loc_536B0:
		move.w	(a1),$20(a1)	; Upper $400 of BG is mirrored in lower $400
		addq.w	#4,a1
		dbf	d0,loc_536B0
		move.w	(Camera_Y_pos_copy).w,(ScrEvents_0).w
		move.w	(Camera_Y_pos_copy).w,(__u_EEB6).w		; Camera BG Y is noted in two variables
		cmpi.w	#$3940,(Camera_X_pos).w
		bhs.s	loc_53704
		cmpi.w	#$3580,(Camera_X_pos).w
		blo.s	loc_536DC
		addi.w	#$2800,(__u_EEB6).w		; If past $3580 X, adjust BG camera

loc_536DC:
		clr.w	(ScrEvents_D).w				; No VScrolling when outside
		jsr	(ICZ1_SetIntroPal).l
		jsr	ICZ1_IntroDeform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	#$1880,d1
		jsr	Refresh_PlaneFull(pc)
		lea	(ICZ1_IntroBGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_53704:
		move.w	#$10,(TrigEvents_Routine).w		; If past $3940 X, we're indoors already
		st	(ScrEvents_D).w				; Go indoors
		jsr	(ICZ1_SetIndoorPal).l
		jsr	ICZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		jsr	Refresh_PlaneFull(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

ICZ1_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_5372C(pc,d0.w)
; ---------------------------------------------------------------------------

loc_5372C:
		bra.w	ICZ1BGE_Intro
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_SnowFall
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_Refresh
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_Refresh2
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ1BGE_Transition
; ---------------------------------------------------------------------------

ICZ1BGE_Intro:
		tst.w	(ScrEvents_2).w
		beq.s	loc_53780
		clr.w	(ScrEvents_2).w		; If flag is set
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_5375C
		addq.w	#4,(TrigEvents_Routine).w	; Just go to next BG event if playing as Knuckles
		bra.s	loc_53780
; ---------------------------------------------------------------------------

loc_5375C:
		jsr	Create_New_Sprite.w
		bne.s	loc_5376A
		move.l	#Obj_ICZ1BigSnowPile,(a1)

loc_5376A:
		clr.l	(ScrEvents_Routine2).w
		clr.l	(ScrEvents_4).w		; Clear offsets
		jsr	ICZ1_BigSnowFall(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_537BA
; ---------------------------------------------------------------------------

loc_53780:

		jsr	ICZ1_IntroDeform(pc)		; Deformation is pretty standard during the intro portion
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$1880,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	(ICZ1_IntroBGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

ICZ1BGE_SnowFall:
		tst.w	(ScrEvents_2).w
		bne.s	loc_537C6
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_53780
		jsr	ICZ1_BigSnowFall(pc)	; If Knuckles, skip

loc_537BA:
		jsr	DrawBGAsYouMove(pc)
		jsr	PlainDeformation(pc)
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

loc_537C6:
		clr.w	(ScrEvents_2).w
		move.w	#$2E0,(DrawDelayed_Position).w		; Set BG refresh position
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w

ICZ1BGE_Refresh:
		move.w	#$1880,d1
		move.w	#$200,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	PlainDeformation
		jsr	ICZ1_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_5380E
; ---------------------------------------------------------------------------

ICZ1BGE_Refresh2:
		jsr	ICZ1_Deform(pc)

loc_5380E:
		move.w	(Camera_X_pos_BG_copy).w,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_53882		; NAT: Change routine
		st	(ScrEvents_D).w		; Go indoors
		jsr	(ICZ1_SetIndoorPal).l	; Set indoor palette
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_53882
; ---------------------------------------------------------------------------

ICZ1BGE_Normal:
		cmpi.w	#$6900,(Camera_X_pos).w
		blo.s	loc_5387A
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(ICZ2_128x128_Secondary_Kos).l,a1
		lea	(Chunk_table+$A00).l,a2
		jsr	Queue_Kos.w
		lea	(ICZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$408).w,a2
		jsr	Queue_Kos.w
		lea	(ICZ2_8x8_Secondary_KosM).l,a1
		move.w	#$2440,d2
		jsr	Queue_Kos_Module.w
		moveq	#$20,d0
		jsr	Load_PLC.w
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(TrigEvents_Routine).w

loc_5387A:
		jsr	ICZ1_Deform(pc)

loc_5387E:

		jsr	DrawBGAsYouMove(pc)

loc_53882:
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

ICZ1BGE_Transition:
		tst.w	(Kos_decomp_queue_count).w
		bne.w	loc_53938
		move.w	#$501,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(NoReset_RespawnTbl).w
		jsr	Clear_Switches.w
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l
		move.w	#-$7FEC,(VDP_control_port).l		; Turn on HInt since ICZ2 has water
		moveq	#$15,d0
		jsr	LoadPalette_Immediate.w
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$6880,d0
		move.w	#-$100,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		jsr	Offset_SomeObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w
		move.l	#$7000,d0
		move.l	d0,(Camera_min_X_pos).w
		move.l	#$B20,d0
		move.l	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	#$FFF,(Screen_Y_wrap_value).w
		move.w	#$FF0,(Camera_Y_pos_mask).w
		move.w	#$7C,(Layout_row_index_mask).w
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.w	(TrigEvents_Routine).w

		move.l	#Ranges_ICZ2,d0
		move.l	d0,BoxLoc_Level.w
		move.l	d0,BoxLoc_Play1.w
		move.l	d0,BoxLoc_Play2.w
		move.w	#Boxes_ICZ2-Ranges_ICZ2,SpawnBoxPos.w


loc_53938:
		jsr	ICZ1_Deform(pc)
		jmp	PlainDeformation(pc)

; =============== S U B R O U T I N E =======================================


ICZ1_IntroDeform:

		lea	(ScrEvents_0).w,a1
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	#$400,d2
		move.w	#$800,d3
		jsr	Adjust_BGDuringLoop(pc)
		move.w	(__u_EEB6).w,d0
		asr.w	#7,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		move.w	(ScrShake_Offset).w,d3
		sub.w	d3,d0
		swap	d0
		clr.w	d0
		asr.l	#5,d0
		move.l	d0,d1
		swap	d0
		add.w	d3,d0
		swap	d0
		lea	(Block_table+$1800).w,a1
		moveq	#0,d3
		moveq	#4,d2			; First five deformation speeds are constant
		bsr.s	sub_53996
		add.l	d1,d0
		move.l	d1,d2
		asr.l	#1,d2
		add.l	d2,d1
		move.l	$12(a1),d3
		addi.l	#$800,$12(a1)
		moveq	#8,d2			; Last 9 move slowly automatically
; End of function ICZ1_IntroDeform


; =============== S U B R O U T I N E =======================================


sub_53996:

		swap	d0
		move.w	d0,(a1)+
		swap	d0
		add.l	d1,d0
		add.l	d3,d1
		addi.l	#$800,d3
		dbf	d2,sub_53996
		rts
; End of function sub_53996


; =============== S U B R O U T I N E =======================================


ICZ1_BigSnowFall:

		cmpi.w	#-$12E,(ScrEvents_Routine2).w
		ble.s	loc_539DE
		st	(ScrShake_Value).w
		addi.l	#$2400,(ScrEvents_4).w
		move.l	(ScrEvents_4).w,d0
		sub.l	d0,(ScrEvents_Routine2).w
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_539F0
		moveq	#$6F,d0
		jsr	Play_Sound_2.w
		bra.s	loc_539F0
; ---------------------------------------------------------------------------

loc_539DE:
		tst.w	(ScrShake_Value).w
		bpl.s	loc_539F0
		move.w	#4,(ScrShake_Value).w
		move.w	#-$12E,(ScrEvents_Routine2).w

loc_539F0:

		move.w	(Camera_Y_pos_copy).w,d0		; Use portion of background to show snow object
		subi.w	#$460,d0
		add.w	(ScrEvents_Routine2).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$1D40,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function ICZ1_BigSnowFall


; =============== S U B R O U T I N E =======================================


ICZ1_Deform:

		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w	; BG moves up/down at half speed
		asr.w	#1,d0
		move.w	d0,(ScrEvents_B).w	; Dynamic BG moves up/down at quarter speed
		move.w	(Camera_X_pos_copy).w,d0
		asr.w	#1,d0
		subi.w	#$1D80,d0
		move.w	d0,(Camera_X_pos_BG_copy).w	; BG moves left/right at half speed
		asr.w	#1,d0
		move.w	d0,(ScrEvents_A).w	; Dynamic BG moves left/right at quarter speed
		rts
; End of function ICZ1_Deform

; ---------------------------------------------------------------------------

Obj_ICZ1BigSnowPile:
		move.l	#loc_53A4C,(a0)
		move.b	#-$80,6(a0)
		move.w	#$3880,$10(a0)
		bset	#7,$2A(a0)

loc_53A4C:
		cmpi.w	#8,(TrigEvents_Routine).w
		blo.s	loc_53A5A
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_53A5A:
		move.w	#$5E0,d0
		sub.w	(ScrEvents_Routine2).w,d0		; Shift Y position based on offset
		move.w	d0,$14(a0)
		move.w	#$94,d1
		lea	ICZ1_SnowpileSlopeDef(pc),a2
		move.w	$10(a0),d4
		jsr	SolidObjectTopSloped2.w
		cmpi.w	#$70E,$14(a0)
		bne.s	locret_53AD2
		tst.b	(Ctrl_1_locked).w
		beq.s	locret_53AD2
		lea	(Player_1).w,a1
		btst	#1,$2A(a1)		; Wait till player is standing on ground
		bne.s	locret_53AD2
		move.b	(Ctrl_1_pressed).w,d0
		andi.w	#$70,d0			; Wait until a jump button is pressed
		beq.s	locret_53AD2
		clr.b	(Ctrl_1_locked).w	; When done, unlock player
		move.w	#-$600,$1A(a1)
		bset	#1,$2A(a1)
		move.b	#1,$40(a1)
		move.b	#$E,$1E(a1)
		move.b	#7,$1F(a1)
		move.b	#2,$20(a1)
		bset	#2,$2A(a1)
		moveq	#$62,d0
		jmp	Play_Sound_2.w	; Perform jumping on player object manually
; ---------------------------------------------------------------------------

Obj_ICZTeleporter:
		jsr	Create_New_Sprite3.w
		beq.s	loc_53ADE

locret_53AD2:
		rts
; ---------------------------------------------------------------------------

loc_53ADE:
		move.l	#Obj_ICZTeleporterMain,(a0)
		move.b	#4,4(a0)
		move.b	#$10,6(a0)
		move.b	#$20,7(a0)
		move.w	#prio(1),8(a0)
		move.w	#$2347,$A(a0)
		move.l	#Map_ICZPlatforms,$C(a0)		; Attributes for teleporter platform in ICZ
		move.w	#$3640,$10(a0)
		move.w	#$670,$14(a0)					; Set position
		move.b	#$1A,$22(a0)
		move.w	(Player_1+y_pos).w,$3E(a0)			; Knuckles Y position into $3E
		move.w	a1,$3C(a0)						; Child beam object into $3C
		move.l	#Obj_TeleporterBeamExpand,(a1)
		move.b	#$44,4(a1)
		st	5(a1)
		move.b	#-$80,6(a1)
		move.b	#$18,7(a1)
		move.w	#prio(1),8(a1)
		move.w	#$255E,$A(a1)
		move.l	#Map_SSZHPZTeleporter,$C(a1)	; Set attributes of beam object
		move.w	$10(a0),$10(a1)
		move.w	$14(a0),$14(a1)
		move.w	#2,$16(a1)
		move.w	$14(a0),$44(a1)					; Lots of init stuff for the beam to work properly
		subi.w	#$80,$44(a1)
		move.b	#$18,$46(a1)
		move.w	a0,parent2(a1)				; Parent in $48
		lea	(Target_palette_line_2+$10).w,a1
		move.w	#$EA2,(a1)
		move.w	#$E80,4(a1)				; Slight change to palette
		lea	(Player_1).w,a1
		move.b	#1,$2E(a1)
		move.b	#2,$20(a1)
		bset	#2,$2A(a1)				; Knuckles is under object control, spinning animation, and jumping

Obj_ICZTeleporterMain:
		lea	(Player_1).w,a1
		move.l	#$20000,d0
		move.l	#$800,d1
		jsr	Gradual_SwingOffset.w		; Do gradual swing on Knuckles until he starts to reverse direction
		add.w	$3E(a0),d0
		move.w	d0,$14(a1)
		tst.l	$2E(a0)
		bmi.s	loc_53BFE
		clr.b	$2E(a1)				; Return player control to Knuckles
		clr.b	$20(a1)
		move.l	#Obj_ICZTeleporterCheckDel,(a0)

Obj_ICZTeleporterCheckDel:
		cmpi.w	#$3780,(Camera_X_pos_copy).w
		blo.s	loc_53BEE
		lea	(Normal_palette_line_2+$10).w,a1		; When player moves far enough to the right, restore palette and delete object
		move.w	#$2C,(a1)
		clr.w	4(a1)
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_53BEE:
		moveq	#$23,d1			; Act as a solid object otherwise
		moveq	#$10,d2
		moveq	#1,d3
		move.w	$10(a0),d4
		jsr	SolidObjectFull.w

loc_53BFE:
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------
		dc.b  $61, $61
		dc.b  $61, $61
		dc.b  $60, $60
		dc.b  $60, $60
		dc.b  $5F, $5F
		dc.b  $5E, $5E
		dc.b  $5D, $5C
		dc.b  $5C, $5B
		dc.b  $5A, $59
		dc.b  $59, $58
		dc.b  $57, $57
ICZ1_SnowpileSlopeDef:	dc.b  $56, $56
		dc.b  $55, $55
		dc.b  $54, $54
		dc.b  $53, $53
		dc.b  $52, $52
		dc.b  $51, $51
		dc.b  $51, $51
		dc.b  $50, $50
		dc.b  $50, $50
		dc.b  $4F, $4F
		dc.b  $4E, $4E
		dc.b  $4D, $4C
		dc.b  $4C, $4B
		dc.b  $4A, $49
		dc.b  $49, $48
		dc.b  $47, $47
		dc.b  $46, $46
		dc.b  $45, $45
		dc.b  $44, $44

		dc.b  $43, $43
		dc.b  $42, $42
		dc.b  $41, $41
		dc.b  $41, $41
		dc.b  $40, $40
		dc.b  $40, $40
		dc.b  $3F, $3F
		dc.b  $3E, $3E
		dc.b  $3D, $3C
		dc.b  $3C, $3B
		dc.b  $3A, $39
		dc.b  $39, $38
		dc.b  $37, $37
		dc.b  $36, $36
		dc.b  $35, $35
		dc.b  $34, $34
		dc.b  $33, $33
		dc.b  $32, $32
		dc.b  $31, $31
		dc.b  $31, $31
		dc.b  $30, $30
		dc.b  $30, $30
		dc.b  $2F, $2F
		dc.b  $2E, $2E
		dc.b  $2D, $2C
		dc.b  $2C, $2B
		dc.b  $2A, $29
		dc.b  $29, $28
		dc.b  $27, $27
		dc.b  $26, $26
		dc.b  $25, $25
		dc.b  $24, $24
		dc.b  $23, $23
		dc.b  $22, $22
		dc.b  $21, $21
		dc.b  $21, $21
		dc.b  $20, $20
		dc.b  $20, $20
		dc.b  $1F, $1F
		dc.b  $1E, $1E
		dc.b  $1D, $1C
		dc.b  $1C, $1B
		dc.b  $1A, $19
		dc.b  $19, $18
		dc.b  $17, $17
		dc.b  $16, $16
		dc.b  $15, $15
		dc.b  $14, $14
		dc.b  $13, $13
		dc.b  $12, $12
		dc.b  $11, $11
		dc.b  $11, $11
		dc.b  $10, $10
		dc.b  $10, $10
		dc.b   $F,  $F
		dc.b   $E,  $E
		dc.b   $D,  $C
		dc.b   $C,  $B
		dc.b   $A,   9
		dc.b	9,   8
		dc.b	7,   7
		dc.b	6,   6
		dc.b	5,   5
		dc.b	4,   4
		dc.b	3,   3
		dc.b	2,   2
; ---------------------------------------------------------------------------

ICZ2_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

ICZ2_ScreenEvent:
		jmp	DrawTilesAsYouMove(pc)		; About as straightforward as you can get really
; ---------------------------------------------------------------------------

ICZ2_BackgroundInit:
		move.w	#4,(TrigEvents_Routine).w
		cmpi.w	#$3600,(Camera_X_pos).w	; Check ranges for either indoor/outdoor BGs
		bhs.s	loc_53CF6
		cmpi.w	#$720,(Camera_Y_pos).w
		bhs.s	loc_53D2C
		cmpi.w	#$1000,(Camera_X_pos).w
		bhs.s	loc_53CF6
		cmpi.w	#$580,(Camera_Y_pos).w
		bhs.s	loc_53D2C

loc_53CF6:

		clr.w	(ScrEvents_D).w			; Outdoors
		cmpi.w	#$720,(Camera_X_pos).w
		bhs.s	loc_53D0A
		jsr	(ICZ2_SetICZ1Pal).l
		bra.s	loc_53D10
; ---------------------------------------------------------------------------

loc_53D0A:
		jsr	(ICZ2_SetOutdoorsPal).l

loc_53D10:
		jsr	(ICZ2_OutDeform).l
		moveq	#0,d0
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	(ICZ2_OutBGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_53D2C:

		st	(ScrEvents_D).w			; Indoors
		jsr	(ICZ2_SetIndoorsPal).l
		jsr	(ICZ2_InDeform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		lea	(ICZ2_InBGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

ICZ2_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_53D5C(pc,d0.w)
; ---------------------------------------------------------------------------

loc_53D5C:
		bra.w	ICZ2BGE_FromICZ1
; ---------------------------------------------------------------------------
		bra.w	ICZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	ICZ2BGE_Refresh
; ---------------------------------------------------------------------------

ICZ2BGE_FromICZ1:
		addq.w	#4,(TrigEvents_Routine).w		; This only applies when coming from ICZ 1
		cmpi.w	#$580,(Camera_Y_pos).w
		bhs.s	loc_53D96
		bra.w	loc_53DFC
; ---------------------------------------------------------------------------

ICZ2BGE_Normal:
		tst.w	(ScrEvents_D).w
		bne.s	loc_53DD8
		move.w	(Camera_X_pos).w,d0		; If outdoors
		cmpi.w	#$1000,d0
		blo.s	loc_53DC4
		cmpi.w	#$3600,d0
		bhs.s	loc_53DC4
		cmpi.w	#$720,(Camera_Y_pos).w
		blo.s	loc_53DC4

loc_53D96:
		st	(ScrEvents_D).w				; Set to go indoors
		jsr	(ICZ2_SetIndoorsPal).l
		jsr	(ICZ2_InDeform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.w	loc_53E84
; ---------------------------------------------------------------------------

loc_53DC4:

		jsr	(ICZ2_OutDeform).l				; No trigger, run normal deformation

loc_53DCA:

		lea	(ICZ2_OutBGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

loc_53DD8:
		move.w	(Camera_X_pos).w,d0		; If indoors
		cmpi.w	#$1900,d0
		blo.s	loc_53DE8
		cmpi.w	#$1B80,d0
		blo.s	loc_53E38

loc_53DE8:
		cmpi.w	#$1000,d0
		blo.s	loc_53E38
		cmpi.w	#$3600,d0
		bhs.s	loc_53E38
		cmpi.w	#$720,(Camera_Y_pos).w
		bhs.s	loc_53E38

loc_53DFC:
		clr.w	(ScrEvents_D).w
		cmpi.w	#$720,(Camera_X_pos).w
		bhs.s	loc_53E10
		jsr	(ICZ2_SetICZ1Pal).l
		bra.s	loc_53E16
; ---------------------------------------------------------------------------

loc_53E10:
		jsr	(ICZ2_SetOutdoorsPal).l

loc_53E16:
		jsr	(ICZ2_OutDeform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_53E68
; ---------------------------------------------------------------------------

loc_53E38:

		jsr	(ICZ2_InDeform).l

loc_53E3E:

		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)

loc_53E4E:
		lea	(ICZ2_InBGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

ICZ2BGE_Refresh:
		tst.w	(ScrEvents_D).w
		bne.s	loc_53E7E
		jsr	(ICZ2_OutDeform).l

loc_53E68:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	loc_53DCA
		subq.w	#4,(TrigEvents_Routine).w
		bra.w	loc_53DCA
; ---------------------------------------------------------------------------

loc_53E7E:
		jsr	(ICZ2_InDeform).l

loc_53E84:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_53E4E		; NAT: Change lable
		subq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_53E4E
; ---------------------------------------------------------------------------

LBZ1_ScreenInit:
		move.w	4(a3),d0
		subi.w	#$76,d0
		move.w	d0,$70(a3)
		move.w	d0,$74(a3)
		move.w	d0,$78(a3)
		move.w	d0,$7C(a3)
		movea.w	$48(a3),a1
		movea.w	$4C(a3),a5
		move.b	$79(a1),$79(a5)
		move.b	#-$25,$79(a1)
		jsr	LBZ1_RotateChunks(pc)
		lea	(Block_table+$1948).w,a1
		moveq	#$D,d0

loc_53ECC:
		clr.l	(a1)+		; Clear VScroll
		dbf	d0,loc_53ECC
		jsr	LBZ1_EventVScroll(pc)
		lea	(Block_table+$1900).w,a1
		moveq	#$B,d0

loc_53EDC:
		move.w	(a1)+,d1
		and.w	(Camera_Y_pos_mask).w,d1
		move.w	d1,(a1)+	; Set up tile offsets for VScroll array
		dbf	d0,loc_53EDC
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_53F06
		cmpi.w	#$3B60,(Camera_X_pos).w	; Skip this if Knuckles
		blo.s	loc_53F0A
		jsr	Create_New_Sprite.w
		bne.s	loc_53F06
		move.l	#Obj_LBZ1InvisibleBarrier,(a1)

loc_53F06:

		jsr	LBZ1_ModEndingLayout(pc)

loc_53F0A:
		moveq	#0,d2
		jsr	(LBZ1_CheckLayoutMod).l
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

LBZ1_ScreenEvent:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w

		cmpi.w	#$55,(ScrEvents_1).w
		bne.s	loc_53F6A
		clr.w	(ScrEvents_1).w
		cmpi.w	#3,(Player_mode).w
		beq.s	loc_53F50
		movea.w	8(a3),a1
		move.b	#-$26,$7D(a1)		; Changes the chunk where the boss appears
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_53F50:
		movea.w	$4C(a3),a1
		move.b	$78(a1),d0
		movea.w	$50(a3),a1
		lea	$78(a1),a1
		move.b	d0,(a1)+		; Changes all the chunks where the boss appears in Knuckles' stage
		move.b	d0,(a1)+
		move.b	d0,(a1)+
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_53F6A:
		move.w	(ScrEvents_Routine2).w,d2
		bne.s	loc_53F86
		jsr	(LBZ1_CheckLayoutMod).l
		tst.w	d3
		bmi.w	loc_53FE2
		jsr	Refresh_PlaneScreenDirect(pc)	; Refresh screen when a layout mod is made
		bra.w	loc_53FE2			; NAT: Fix a possible way to leave glitch behind
; ---------------------------------------------------------------------------

loc_53F86:
		move.w	Player_2+x_pos.w,d1
		move.w	Player_1+x_pos.w,d0
		lea	(LBZ1_LayoutModExitRange-4).l,a1		; If already in a layout
		adda.w	d2,a1

		cmp.w	#Boxes_LBZK-Ranges_LBZK,SpawnBoxPos.w; check if knux cutscene (a hack)
		bne.s	.notend			; if not, do normal
		cmp.b	#1,BoxWinner.w		; check if anyone is the box winner
		ble.s	.nowin			; branch if nobody or sonic
		exg	d0,d1			; if tails, swap the correct xpos in

.nowin		cmp.w	(a1)+,d0
		blo.s	.kkk
		cmp.w	(a1)+,d0
		blo.w	loc_53FE2		; if still inside, branch away

.kkk		cmp.b	#1,BoxWinner.w		; check if anyone is the box winner
		blt.s	loc_53F98			; branch if nobody
		lea	Player_1.w,a5		; set Sonic to move
		lea	Player_2.w,a6		; ''
		beq.s	.move			; branch if Sonic is winning
		exg	a5,a6

.move		move.w	x_pos(a5),x_pos(a6)	; move
		move.w	y_pos(a5),y_pos(a6)	; ''
		bra.s	loc_53F98

.notend		moveq	#2-1,d5
		cmp.w	(a1),d1
		slo	d4
		add.b	d4,d5

		cmp.w	(a1)+,d0
		slo	d4
		add.b	d4,d5

		cmp.w	(a1),d1
		shs	d4
		add.b	d4,d5

		cmp.w	(a1)+,d0
		shs	d4
		add.b	d4,d5

		tst.b	d5
		bpl.s	loc_53FE2
; ---------------------------------------------------------------------------

loc_53F98:

		clr.w	(ScrEvents_Routine2).w
		lsr.w	#1,d2
		jsr	loc_53FA6-2(pc,d2.w)

loc_53FA2:
		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_53FA6:
		bra.s	LBZ1_LayoutExitMod1
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutExitMod2
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutExitMod3
; ---------------------------------------------------------------------------
		bra.s	LBZ1_LayoutExitMod4
; ---------------------------------------------------------------------------
;		bra.s	LBZ1_LayoutExitMod5
		movea.w $48(a3),a5		; NAT: Custom layout mod
		lea     $9A(a5),a5
		jmp	LBZ1_LayoutMod5_
; ---------------------------------------------------------------------------

LBZ1_LayoutExitMod1:
		movea.w	(a3),a5
		lea	$88(a5),a5
		jmp	LBZ1_DoMod1
; ---------------------------------------------------------------------------

LBZ1_LayoutExitMod2:
		movea.w	$24(a3),a5
		lea	$8A(a5),a5
		jmp	LBZ1_DoMod2
; ---------------------------------------------------------------------------

LBZ1_LayoutExitMod3:
		movea.w	(a3),a5
		lea	$98(a5),a5
		jmp	LBZ1_DoMod3
; ---------------------------------------------------------------------------

LBZ1_LayoutExitMod4:
		movea.w	$30(a3),a5
		lea	$9A(a5),a5
		jmp	LBZ1_DoMod4
; ---------------------------------------------------------------------------

loc_53FE2:

		jsr	LBZ1_EventVScroll(pc)		; Do the vscroll deformation, if necessary
		lea	(LBZ1_FGVScrollArray).l,a4
		lea	(Block_table+$1900).w,a5
		moveq	#$F,d6
		moveq	#$C,d5
		jmp	DrawTilesVDeform(pc)

; =============== S U B R O U T I N E =======================================


LBZ1_EventVScroll:

		tst.w	(ScrEvents_1).w
		beq.w	loc_540AC
		bpl.s	loc_5401C
		move.w	#1,(ScrEvents_1).w
		move.w	#4,(Special_V_int_routine).w
		jsr	Create_New_Sprite.w
		bne.s	loc_5401C
		move.l	#Obj_LBZ1InvisibleBarrier,(a1)

loc_5401C:

		lea	(Block_table+$194C).w,a1
		lea	(LBZ1_CollapseScrollSpeed).l,a5
		move.l	$2C(a1),d0
		addi.l	#$100,$2C(a1)
		move.w	$30(a1),d1
		addq.w	#1,$30(a1)
		asr.w	#6,d1
		moveq	#$A,d2
		moveq	#9,d3

loc_54040:
		addq.w	#2,d1
		andi.w	#$E,d1
		move.w	(a5,d1.w),d4
		ext.l	d4
		lsl.l	#4,d4
		move.l	(a1),d5
		sub.l	d4,d5
		sub.l	d0,d5
		swap	d5
		cmpi.w	#-$300,d5
		bgt.s	loc_54062
		move.w	#-$300,d5
		subq.w	#1,d2

loc_54062:
		swap	d5
		move.l	d5,(a1)+
		dbf	d3,loc_54040
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_54082
		tst.w	d2
		beq.s	loc_54082
		moveq	#-$34,d0
		jsr	Play_Sound_2.w

loc_54082:

		tst.w	d2
		bne.s	loc_540AC
		clr.w	(ScrShake_Value).w
		clr.w	(ScrEvents_1).w
		move.w	#$C,(Special_V_int_routine).w
		jsr	LBZ1_ModEndingLayout(pc)
		lea	(Block_table+$1948).w,a1
		moveq	#$D,d0

loc_5409E:
		clr.l	(a1)+
		dbf	d0,loc_5409E
		moveq	#$5F,d0
		jsr	Play_Sound_2.w

loc_540AC:

		lea	(Block_table+$1900).w,a1
		lea	(Block_table+$1930).w,a4
		lea	(Block_table+$1948).w,a5
		move.w	(Camera_Y_pos_copy).w,d0
		moveq	#$B,d1

loc_540BE:
		move.w	(a5),d2
		add.w	d0,d2
		move.w	d2,(a1)
		move.w	d2,(a4)+
		addq.w	#4,a1
		addq.w	#4,a5
		dbf	d1,loc_540BE
		rts
; End of function LBZ1_EventVScroll


; =============== S U B R O U T I N E =======================================


LBZ1_ModEndingLayout:

		movea.w	(a3),a1			; This ensures that when Sonic starts from the lamppost before the boss the building behind him disappears
		lea	$74(a1),a1			; It also doubles as the layout used by Knuckles in his version of the level
		move.w	-8(a3),d0
		subq.w	#4,d0
		moveq	#$B,d1

loc_540DE:
		clr.l	(a1)+
		adda.w	d0,a1
		dbf	d1,loc_540DE
		movea.w	(a3),a5
		lea	$98(a5),a5
		movea.w	$24(a3),a1
		lea	$74(a1),a1
		move.w	-8(a3),d0
		subq.w	#4,d0
		moveq	#2,d1

loc_540FC:
		move.l	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_540FC
		st	(ScrEvents_3).w		; Disable the layout modding for this area (layoutmod3)
		rts
; End of function LBZ1_ModEndingLayout


; =============== S U B R O U T I N E =======================================


LBZ1_KnuxLevelSizeAdjust:
		cmpi.w	#3,(Player_mode).w
		bne.s	locret_54144		; Only do this if playing as Knuckles
		move.w	(Player_1+x_pos).w,d0
		cmpi.w	#$37C0,d0			; Basically this adjusts the top of the screen for Knuckles when he approaches the end of the level
		blo.s	locret_54144
		cmpi.w	#$3800,d0
		bhi.s	locret_54144
		move.w	(Player_1+y_pos).w,d0
		cmpi.w	#$600,d0
		blo.s	locret_54144
		cmpi.w	#$680,d0
		bhi.s	locret_54144
		moveq	#0,d1
		cmpi.w	#$640,d0
		bhs.s	loc_54140
		move.w	#$40C,d1

loc_54140:
		move.w	d1,(Camera_min_Y_pos).w

locret_54144:

		rts
; End of function LBZ1_KnuxLevelSizeAdjust


; =============== S U B R O U T I N E =======================================


LBZ1_RotateChunks:

		moveq	#$17,d2

loc_54148:
		lea	(Chunk_table+$6E00).l,a1
		lea	-2(a1),a5
		move.w	(a5),d0
		moveq	#$3E,d1

loc_54156:
		move.w	-(a5),-(a1)
		dbf	d1,loc_54156
		move.w	d0,(a5)
		dbf	d2,loc_54148
		rts
; End of function LBZ1_RotateChunks

; ---------------------------------------------------------------------------

Obj_LBZ1InvisibleBarrier:

		cmpi.w	#$3D80,(Camera_X_pos).w
		blo.s	loc_54172
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_54172:
		move.w	#$3BC0,d4
		move.w	d4,$10(a0)
		move.w	#$100,$14(a0)
		move.b	#$40,7(a0)
		bset	#7,$2A(a0)
		moveq	#$4B,d1
		move.w	#$100,d2
		move.w	#$100,d3
		jmp	SolidObjectFull2.w
; ---------------------------------------------------------------------------

LBZ1_BackgroundInit:
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_541C6
		movea.w	(a3),a1			; Get rid of the death egg portion of the BG while playing as Knuckles. For obvious reasons.
		addq.w	#2,a1
		move.b	#-$1C,(a1)+
		move.b	#-$1A,(a1)+
		move.b	#-$20,(a1)+
		movea.w	4(a3),a1
		addq.w	#2,a1
		move.b	#-$14,(a1)+
		move.b	#-$12,(a1)+
		move.b	#-$18,(a1)+

loc_541C6:
		jsr	(LBZ1_Deform).l
		jsr	Reset_TileOffsetPositionEff(pc)
		move.w	d2,(Block_table+$1802).w
		clr.l	(Block_table+$1804).w
		lea	LBZ1_BGDrawArray(pc),a4
		lea	(Block_table+$1800).w,a5
		jsr	Refresh_PlaneTileDeform(pc)
		lea	LBZ1_BGDeformArray(pc),a4
		lea	(Block_table+$1808).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

LBZ1_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_541F8(pc,d0.w)
; ---------------------------------------------------------------------------

loc_541F8:
		bra.w	LBZ1BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	LBZ1BGE_DoTransition
; ---------------------------------------------------------------------------

LBZ1BGE_Normal:
		tst.w	(ScrEvents_2).w
		beq.s	loc_54248
		clr.w	(ScrEvents_2).w		; Yeah, normal transition nonsense for the level change
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(LBZ2_128x128_Kos).l,a1
		lea	(RAM_start).l,a2
		jsr	Queue_Kos.w
		lea	(LBZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$6B8).w,a2
		jsr	Queue_Kos.w
		lea	(LBZ2_8x8_Secondary_KosM).l,a1
		move.w	#$33A0,d2
		jsr	Queue_Kos_Module.w
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(TrigEvents_Routine).w

loc_54248:
		jsr	(LBZ1_Deform).l
		lea	LBZ1_BGDrawArray(pc),a4
		lea	(Block_table+$1800).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	Draw_BG(pc)
		lea	LBZ1_BGDeformArray(pc),a4
		lea	(Block_table+$1808).w,a5
		jsr	ApplyDeformation(pc)
		lea	(LBZ1_FGVScrollArray).l,a4
		lea	(Block_table+$192E).w,a5
		jsr	Apply_FGVScroll(pc)
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

LBZ1BGE_DoTransition:
		tst.b	(Kos_modules_left).w
		bne.w	loc_5432E
		move.w	#$601,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(NoReset_RespawnTbl).w
		jsr	Clear_Switches.w
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		jsr	(CheckLevelForWater).l
		move.w	#-$7FEC,(VDP_control_port).l		; Water in this stage yaaay
		moveq	#$17,d0
		jsr	LoadPalette_Immediate.w
		movem.l	(sp)+,d7-a0/a2-a3
		jsr	Adjust_LBZ2Layout(pc)
		move.w	#$3A00,d0
		moveq	#0,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w
		jsr	Offset_ObjectsDuringTransition(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.l	(ScrEvents_Routine2).w
		clr.l	(ScrEvents_C).w
		clr.w	(__u_EEA0).w
		clr.w	(__u_EF40).w
		clr.w	(__u_EEBE).w
		move.w	#$40,(ScrEvents_A).w
		cmpi.w	#$540,(Camera_Y_pos).w
		blo.s	loc_5431C
		neg.w	(ScrEvents_A).w

loc_5431C:
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(sub_2807A).l				; Start LBZ2 tile animation
		movem.l	(sp)+,d7-a0/a2-a3
		clr.w	(TrigEvents_Routine).w

loc_5432E:
		lea	LBZ1_BGDeformArray(pc),a4
		lea	(Block_table+$1808).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------
LBZ1_BGDrawArray:	dc.w $D0
		dc.w $7FFF
LBZ1_BGDeformArray:	dc.w $D0
		dc.w $18
		dc.w 8
		dc.w 8
		dc.w $7FFF
; ---------------------------------------------------------------------------

LBZ2_ScreenInit:
		jsr	Adjust_LBZ2Layout(pc)
		move.w	#4,(ScrEvents_Routine).w

		btst	#5,OptionsBits.w		; NAT: Check if bosses are on
		bne.s	.boss				; if yes, branch
		addq.w	#4,(ScrEvents_Routine).w		; else do not hide HUD

.boss		clr.l	(ScrEvents_C).w
		clr.w	(__u_EEA0).w
		clr.w	(__u_EF40).w
		clr.w	(__u_EEBE).w
		bsr.s	LBZ2_LayoutMod
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

LBZ2_ScreenEvent:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(ScrEvents_Routine).w,d0
		jmp	loc_5437C(pc,d0.w)
; ---------------------------------------------------------------------------

loc_5437C:
		bra.w	LBZ2SE_FromTransition
; ---------------------------------------------------------------------------
		bra.w	LBZ2SE_Normal
; ---------------------------------------------------------------------------
		bra.w	LBZ2SE_Normal2
; ---------------------------------------------------------------------------

LBZ2SE_FromTransition:
		cmpi.w	#$60A,Player_2+x_pos.w		; NAT: Tails...
		bhs.s	.ok
		cmpi.w	#$60A,(Player_1+x_pos).w
		blo.s	loc_5439E

.ok		bsr.s	LBZ2_LayoutMod
		addq.w	#4,(ScrEvents_Routine).w

		btst	#5,OptionsBits.w		; NAT: Check if bosses are on
		bne.s	.boss				; if yes, branch
		addq.w	#4,(ScrEvents_Routine).w		; else do not hide HUD

.boss		jmp	Refresh_PlaneScreenDirect(pc)
; ---------------------------------------------------------------------------

loc_5439E:
		jmp	DrawTilesAsYouMove(pc)

; =============== S U B R O U T I N E =======================================


LBZ2_LayoutMod:

		movea.w	(a3),a5			; Thankfully, this is the only one in the whole level
		lea	$94(a5),a5
		movea.w	(a3),a1
		addq.w	#6,a1
		move.w	-8(a3),d0
		subq.w	#6,d0
		moveq	#5,d1

loc_543B4:
		move.l	(a5)+,(a1)+
		move.w	(a5)+,(a1)+
		adda.w	d0,a5
		adda.w	d0,a1
		dbf	d1,loc_543B4
		rts
; End of function LBZ2_LayoutMod

; ---------------------------------------------------------------------------

loc_543C2:
		bsr.s	LBZ2_LayoutMod
		addq.w	#4,(ScrEvents_Routine).w

LBZ2SE_Normal:
		cmp.w	#$3900,Camera_X_pos.w		; NAT: Check if we are far enuf
		shs	MonContPos.w			; hide HUD if close enough

		cmp.w	#$39F0,Camera_X_pos.w		; NAT: Check if we are far enuf
		blo.s	LBZ2SE_Normal2			; if not, branch
		addq.w	#4,(ScrEvents_Routine).w

LBZ2SE_Normal2:
		jmp	DrawTilesAsYouMove(pc)		; Remarkably straightforward

; =============== S U B R O U T I N E =======================================


Adjust_LBZ2Layout:

		movea.w	(Level_layout_main+$48).w,a1
		movea.w	(Level_layout_main+$4C).w,a5
		move.b	5(a1),5(a5)
		move.b	#-$25,5(a1)
		jsr	LBZ1_RotateChunks(pc)
		movea.w	(Level_layout_main+$4C).w,a1
		move.b	4(a1),d0
		movea.w	(Level_layout_main+$50).w,a1
		addq.w	#4,a1
		move.b	d0,(a1)+
		move.b	d0,(a1)+
		move.b	d0,(a1)+
		movea.w	(Level_layout_main+$1C).w,a1
		move.b	#$58,$8A(a1)
		movea.w	(Level_layout_main+$20).w,a1
		move.b	#$55,$8A(a1)
		rts
; End of function Adjust_LBZ2Layout

; ---------------------------------------------------------------------------

LBZ2_BackgroundInit:
		move.w	#8,(TrigEvents_Routine).w
		jsr	LBZ2_Deform(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		moveq	#$40,d0
		cmp.w	(ScrEvents_A).w,d0
		blt.s	loc_54432
		neg.w	d0
		cmp.w	(ScrEvents_A).w,d0
		bgt.s	loc_54436

loc_54432:
		move.w	d0,(ScrEvents_A).w		; Keep art reloading in range

loc_54436:
		lea	(LBZ2_BGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jmp	ApplyDeformation(pc)
; ---------------------------------------------------------------------------

LBZ2_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_5444C(pc,d0.w)
; ---------------------------------------------------------------------------

loc_5444C:
		bra.w	LBZ2BGE_FromTransition
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_Refresh
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_Normal
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_DeathEgg
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_PlatformDetach
; ---------------------------------------------------------------------------
		bra.w	LBZ2BGE_Falling
; ---------------------------------------------------------------------------

LBZ2BGE_FromTransition:
		jsr	LBZ2_Deform(pc)						; This and below are only done when transitioning
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_54488
; ---------------------------------------------------------------------------

LBZ2BGE_Refresh:
		jsr	LBZ2_Deform(pc)

loc_54488:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.s	loc_544B4		; NAT: Change lable
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_544B4
; ---------------------------------------------------------------------------

LBZ2BGE_Normal:
		tst.w	(ScrEvents_2).w
		bne.s	loc_544C6		; Wait for flag
		jsr	LBZ2_Deform(pc)

loc_544A4:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)

loc_544B4:
		lea	(LBZ2_BGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

loc_544C6:
		clr.w	(ScrEvents_2).w			; Oh boy, NOW the fun begins
		move.w	8(a3),(a3)
		move.w	$C(a3),4(a3)			; Modify the background slightly
		move.w	#$4390,d0
		move.w	d0,(Camera_max_X_pos).w		; X-end is at $4390
		move.w	#$668,d0
		move.w	d0,(Camera_max_Y_pos).w		; Y-end is $668
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	#$3C,(ScrEvents_9).w
		move.w	#$1E00,(__u_EEA2).w
		move.l	#$6200,(__u_EE9C).w
		st	(Scroll_lock).w
		st	(__u_EF40).w
		addq.w	#4,(TrigEvents_Routine).w

LBZ2BGE_DeathEgg:
		tst.w	(__u_EF40).w
		beq.s	loc_5452E
		tst.w	(ScrShake_Value).w
		bne.s	loc_5451A			; Branch if shaking
		clr.w	(__u_EF40).w
		bra.s	loc_5452E
; ---------------------------------------------------------------------------

loc_5451A:
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_5452E
		moveq	#-$33,d0			; Play death egg rumbling sound
		jsr	Play_Sound_2.w

loc_5452E:

		tst.w	(ScrEvents_2).w
		beq.w	loc_545DE
		jsr	LBZ2_EndFallingAccel(pc)	; When signalled, start the falling of the death egg platform
		tst.w	(__u_EE9C).w
		bpl.w	loc_545DE
		clr.w	(ScrEvents_2).w			; When movement starts going negative
		move.w	#$1B,(DrawDelayed_RowCount).w
		move.w	#$10,(Special_V_int_routine).w		; Do the first window copy
		clr.b	(Water_flag).w			; No more water evidently
		addq.w	#4,(TrigEvents_Routine).w
		bra.w	loc_545DE
; ---------------------------------------------------------------------------

LBZ2BGE_PlatformDetach:
		tst.w	(Special_V_int_routine).w
		bne.s	sub_545DA			; Wait for window copy to finish
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		bne.s	loc_545AA
		move.w	(ScrEvents_D).w,d0	; Only ever four frames
		cmpi.w	#$28,d0
		blo.s	loc_545A4
		clr.w	(ScrEvents_D).w		; When scroll A has scrolled off screen
		move.w	#$18,(Special_V_int_routine).w	; Use the next Special VInt function to restore the entire platform
		movea.w	$2A(a3),a1
		lea	$87(a1),a1
		clr.b	(a1)
		clr.b	1(a1)
		clr.b	2(a1)				; Furthermore, clear the entire level layout at $580 Y, $4380 X (3 chunks long, 2 chunks high)
		adda.w	-$A(a3),a1
		clr.b	(a1)+
		clr.b	(a1)+
		clr.b	(a1)				; This is for when the platform scrolls off screen at the end
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	LBZ2BGE_Falling
; ---------------------------------------------------------------------------

loc_545A4:
		addq.w	#1,d0
		move.w	d0,(ScrEvents_D).w	; Increment value

loc_545AA:
		bsr.s	sub_545DA
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		move.w	(ScrEvents_D).w,d0
		add.w	d0,(V_scroll_value).w	; Actual vertical scroll is modified by EEE8.
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------

LBZ2BGE_Falling:

		tst.w	(ScrEvents_2).w
		beq.s	sub_545DA		; Continue Death Egg deformation until signal
		st	(Scroll_lock).w		; Set flag so that camera doesn't follow Sonic
		move.w	(Camera_Y_pos).w,(Camera_Y_pos_copy).w		; Scroll screen upwards
		subq.w	#2,(Camera_Y_pos).w
		rts

; =============== S U B R O U T I N E =======================================


sub_545DA:

		jsr	LBZ2_EndFallingAccel(pc)

loc_545DE:

		jsr	LBZ2_DeathEggMoveScreen(pc)
		jsr	LBZ2_DeathEggDeform(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		lea	(LBZ2_DEBGDeformArray).l,a4
		lea	(Block_table+$1800).w,a5
		jsr	ApplyDeformation(pc)
		jmp	ShakeScreen_Setup.w
; End of function sub_545DA


; =============== S U B R O U T I N E =======================================


LBZ2_Deform:

		move.w	(Camera_Y_pos_copy).w,d0			; Oh hey, it's more waterline fun, wasn't this just so interesting the first timeno
		move.w	(ScrShake_Offset).w,d3
		sub.w	d3,d0
		subi.w	#$5F0,d0
		move.w	d0,d1
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d2
		asr.l	#3,d2
		sub.l	d2,d0
		asr.l	#2,d2
		sub.l	d2,d0
		swap	d0
		move.w	d0,d2
		addi.w	#$2C0,d0
		add.w	d3,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w			; Calculate effective Y position
		sub.w	d1,d2
		move.w	d2,(ScrEvents_A).w			; Water line equilibrium point
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		tst.w	d2
		beq.w	loc_546FA					; Equilibrium skips ahead
		move.l	d0,d1
		move.l	d0,d3
		asr.l	#6,d3
		move.l	d3,d4
		asr.l	#3,d4
		sub.l	d4,d3
		moveq	#$1F,d4
		cmpi.w	#-$40,d2
		bgt.s	loc_5467A
		lea	(Block_table+$181E).w,a1	; Above water, no art reloading needed

loc_54662:
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_54662
		bra.w	loc_546FA
; ---------------------------------------------------------------------------

loc_5467A:
		lea	(Block_table+$191E).w,a1	; Below water

loc_5467E:
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_5467E
		cmpi.w	#$40,d2
		bge.s	loc_546FA		; No art reloading needed if out of range
		lea	(Block_table+$189E).w,a1
		lea	(a1),a5
		lea	(LBZ_WaterlineScroll_Data).l,a6
		move.w	d2,d1
		bmi.s	loc_546D2
		move.w	d1,d3			; Below water
		neg.w	d3
		addi.w	#$40,d3
		lsl.w	#6,d3
		adda.w	d3,a6
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_546C4

loc_546BC:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+

loc_546C4:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+
		dbf	d1,loc_546BC
		bra.s	loc_546FA
; ---------------------------------------------------------------------------

loc_546D2:
		move.w	d1,d3			; Above water
		addi.w	#$40,d3
		lsl.w	#6,d3
		adda.w	d3,a6
		neg.w	d1
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_546EE

loc_546E6:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),-(a1)

loc_546EE:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),-(a1)
		dbf	d1,loc_546E6

loc_546FA:

		lea	(Block_table+$19E2).w,a1			; Below the water area moving up (from Knuckles area of course)
		move.l	d0,d1
		asr.l	#1,d1
		move.l	d1,d3
		asr.l	#3,d3
		swap	d1
		move.w	d1,(Camera_X_pos_BG_copy).w		; Effective X
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,(ScrEvents_B).w		; Art reloading for the bricks in Knuckles' area
		move.w	d1,-(a1)
		swap	d1
		lea	(LBZ2_BGUWDeformRange).l,a5	; This is an array of counters used for deformation sizes underwater.
		sub.l	d3,d1					; Likely because the underwater wavy effect neccesitates specifying deformation line-by-line
		moveq	#4,d4

loc_54726:
		sub.l	d3,d1
		swap	d1
		move.w	(a5)+,d5

loc_5472C:
		move.w	d1,-(a1)
		move.w	d1,-(a1)
		move.w	d1,-(a1)
		move.w	d1,-(a1)
		dbf	d5,loc_5472C
		swap	d1
		dbf	d4,loc_54726
		moveq	#$3F,d3
		tst.w	d2
		bmi.s	loc_54748
		sub.w	d2,d3					; Only perform as much addition line-by-line deformation as needed
		bcs.s	loc_54756

loc_54748:
		swap	d1
		lsr.w	#1,d3
		bcc.s	loc_54750

loc_5474E:
		move.w	d1,-(a1)

loc_54750:
		move.w	d1,-(a1)
		dbf	d3,loc_5474E

loc_54756:
		lea	(Block_table+$1800).w,a1			; With that overwith, we can actually do some normal stuff
		lea	(LBZ2_CloudDeformArray).l,a5
		move.l	d0,d1
		asr.l	#6,d1
		move.l	d1,d3
		move.l	(Block_table+$19E2).w,d4
		addi.l	#$E00,(Block_table+$19E2).w		; Move clouds
		moveq	#$C,d5

loc_54774:
		move.w	(a5)+,d6
		add.l	d4,d1
		swap	d1
		move.w	d1,(a1,d6.w)
		swap	d1
		add.l	d3,d1
		dbf	d5,loc_54774
		move.l	d0,d1			; And now just do the rest of the deformation
		asr.l	#4,d1
		move.l	d1,d3
		asr.l	#1,d3
		lea	(Block_table+$181A).w,a1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		add.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		tst.w	d2
		bpl.s	loc_547B4		; If below water, just do the full deformation
		moveq	#$3F,d4
		add.w	d2,d4
		bmi.s	loc_547D2		; If above water far enough that entire waterline shows, skip ahead
		cmpi.w	#$30,d4
		blo.s	loc_547C6
		subi.w	#$30,d4
		bra.s	loc_547B6
; ---------------------------------------------------------------------------

loc_547B4:
		moveq	#$F,d4

loc_547B6:
		moveq	#$17,d5

loc_547B8:
		move.w	d1,(a1)+		; First $30 pixels have their own deformation
		move.w	d1,(a1)+
		dbf	d5,loc_547B8
		swap	d1
		add.l	d3,d1
		swap	d1

loc_547C6:
		lsr.w	#1,d4			; As do the last $10 pixels
		bcc.s	loc_547CC

loc_547CA:
		move.w	d1,(a1)+

loc_547CC:
		move.w	d1,(a1)+
		dbf	d4,loc_547CA

loc_547D2:
		moveq	#$3F,d0			; And yet, there's more, cause we now have the wavy effects to go!
		sub.w	d2,d0
		bmi.s	locret_5480A	; If high enough, no waviness needed
		addi.w	#$60,d0			; Otherwise, keep it up
		cmpi.w	#$E0,d0
		blo.s	loc_547E6
		move.w	#$DF,d0

loc_547E6:
		lea	(Block_table+$19DE).w,a1
		lea	LBZ_WaterWaveArray(pc),a5	; Water wave array
		move.w	(Level_frame_counter).w,d1
		asr.w	#1,d1
		andi.w	#$7E,d1
		adda.w	d1,a5
		lsr.w	#1,d0
		bcc.s	loc_54802

loc_547FE:
		move.w	-(a5),d3
		add.w	d3,-(a1)

loc_54802:
		move.w	-(a5),d3
		add.w	d3,-(a1)
		dbf	d0,loc_547FE

locret_5480A:
		rts
; End of function LBZ2_Deform


; =============== S U B R O U T I N E =======================================


LBZ2_DeathEggDeform:
		move.w	(Camera_Y_pos_copy).w,d0		; Oh no, I'm not commenting all of this again.
		move.w	(ScrShake_Offset).w,d3
		sub.w	d3,d0
		subi.w	#$5F0,d0
		sub.w	(ScrEvents_3).w,d0
		sub.w	(ScrEvents_5).w,d0
		move.w	d0,d1
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d2
		asr.l	#3,d2
		sub.l	d2,d0
		asr.l	#2,d2
		sub.l	d2,d0
		swap	d0
		move.w	d0,d2
		addi.w	#$2C0,d0
		sub.w	(__u_EEBE).w,d0
		add.w	d3,d0
		bpl.s	loc_5485C
		moveq	#0,d3
		move.w	d0,d4

loc_54848:
		addi.w	#$100,d3
		addi.w	#$100,d4
		bmi.s	loc_54848
		cmp.w	(__u_EEA0).w,d3
		blo.s	loc_5485C
		move.w	d3,(__u_EEA0).w

loc_5485C:

		tst.w	(__u_EEBE).w
		bne.s	loc_5486C
		cmpi.w	#$100,d0
		bne.s	loc_5486C
		move.w	d0,(__u_EEBE).w

loc_5486C:

		add.w	(__u_EEA0).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		tst.w	(__u_EEA0).w
		beq.s	loc_5488A

loc_5487A:
		cmpi.w	#$100,d0
		blo.s	loc_54886
		subi.w	#$100,d0
		bra.s	loc_5487A
; ---------------------------------------------------------------------------

loc_54886:
		move.w	d0,(Camera_Y_pos_BG_copy).w

loc_5488A:
		tst.w	(__u_EE9C).w
		bmi.s	loc_54894
		sub.w	d1,d2
		bpl.s	loc_54898

loc_54894:
		move.w	#$7FFF,d2

loc_54898:
		move.w	d2,(ScrEvents_A).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		move.l	d0,d1
		move.l	d0,d3
		asr.l	#6,d3
		move.l	d3,d4
		asr.l	#3,d4
		sub.l	d4,d3
		moveq	#$1F,d4
		lea	(Block_table+$18AC).w,a1

loc_548B6:
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		sub.l	d3,d1
		dbf	d4,loc_548B6
		cmpi.w	#$40,d2
		bge.s	loc_54906
		lea	(Block_table+$182C).w,a1
		lea	(a1),a5
		lea	(LBZ_WaterlineScroll_Data).l,a6
		move.w	d2,d1
		move.w	d1,d3
		neg.w	d3
		addi.w	#$40,d3
		lsl.w	#6,d3
		adda.w	d3,a6
		subq.w	#1,d1
		moveq	#0,d3
		lsr.w	#1,d1
		bcc.s	loc_548FA

loc_548F2:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+

loc_548FA:
		move.b	(a6)+,d3
		add.w	d3,d3
		move.w	(a5,d3.w),(a1)+
		dbf	d1,loc_548F2

loc_54906:
		lea	(Block_table+$18EC).w,a1
		move.l	d0,d1
		asr.l	#1,d1
		move.l	d1,d3
		asr.l	#3,d3
		moveq	#6,d4

loc_54914:
		sub.l	d3,d1
		dbf	d4,loc_54914
		moveq	#$5F,d3
		sub.w	d2,d3
		bcs.s	loc_5492E
		swap	d1
		lsr.w	#1,d3
		bcc.s	loc_54928

loc_54926:
		move.w	d1,-(a1)

loc_54928:
		move.w	d1,-(a1)
		dbf	d3,loc_54926

loc_5492E:
		lea	(Block_table+$180C).w,a1
		lea	(LBZ2_CloudDeformArray).l,a5
		move.l	d0,d1
		asr.l	#6,d1
		move.l	d1,d3
		move.l	(Block_table+$19E2).w,d4
		addi.l	#$E00,(Block_table+$19E2).w
		moveq	#$C,d5

loc_5494C:
		move.w	(a5)+,d6
		add.l	d4,d1
		swap	d1
		move.w	d1,(a1,d6.w)
		swap	d1
		add.l	d3,d1
		dbf	d5,loc_5494C
		lea	(Block_table+$1810).w,a1
		lea	(Block_table+$1800).w,a5
		moveq	#3,d1

loc_54968:
		move.l	(a1)+,(a5)+
		dbf	d1,loc_54968
		move.l	d0,d1
		asr.l	#4,d1
		move.l	d1,d3
		asr.l	#1,d3
		lea	(Block_table+$1826).w,a1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		add.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		swap	d1
		add.l	d3,d1
		swap	d1
		move.w	d1,(a1)+
		moveq	#$3F,d0
		sub.w	d2,d0
		addi.w	#$20,d0
		cmpi.w	#$60,d0
		blo.s	loc_549A0
		move.w	#$5F,d0

loc_549A0:
		lea	(Block_table+$18EC).w,a1
		lea	LBZ_WaterWaveArray2(pc),a5
		move.w	(Level_frame_counter).w,d1
		asr.w	#1,d1
		andi.w	#$7E,d1
		adda.w	d1,a5
		lsr.w	#1,d0
		bcc.s	loc_549BC

loc_549B8:
		move.w	-(a5),d3
		add.w	d3,-(a1)

loc_549BC:
		move.w	-(a5),d3
		add.w	d3,-(a1)
		dbf	d0,loc_549B8
		rts
; End of function LBZ2_DeathEggDeform


; =============== S U B R O U T I N E =======================================


LBZ2_DeathEggMoveScreen:
		tst.b	(Scroll_lock).w
		beq.s	loc_549FC			; Skip if flag turned off
		move.w	(Player_1+x_pos).w,d0
		sub.w	(Camera_X_pos).w,d0
		subi.w	#$A0,d0
		bcs.s	loc_549E8
		add.w	d0,(Camera_X_pos).w	; Move screen along with player in robotnik ship

loc_549E8:
		cmpi.w	#$4390,(Camera_X_pos).w
		bhs.s	loc_549F8
		cmpi.w	#$668,(Camera_Y_pos).w
		blo.s	loc_549FC

loc_549F8:
		clr.b	(Scroll_lock).w		; Stop movement when screen edge is reached

loc_549FC:

		tst.w	(ScrEvents_9).w
		beq.s	loc_54A0A
		subq.w	#1,(ScrEvents_9).w
		bra.w	locret_54A92
; ---------------------------------------------------------------------------

loc_54A0A:
		cmpi.w	#$4390,(Camera_X_pos).w
		blo.s	loc_54A1A
		move.w	(Camera_max_X_pos).w,d0
		move.w	d0,(Camera_min_X_pos).w

loc_54A1A:
		cmpi.w	#$668,(Camera_Y_pos).w
		blo.s	loc_54A2A
		move.w	(Camera_max_Y_pos).w,d0
		move.w	d0,(Camera_min_Y_pos).w		; Lock screen when edges are reached

loc_54A2A:
		lea	(ScrEvents_3).w,a1
		moveq	#0,d1
		move.w	(__u_EEA2).w,d1		; Speed of death egg movement
		add.l	d1,(a1)
		move.w	(a1),d0
		move.w	d0,d1
		sub.w	8(a1),d0
		move.w	d1,8(a1)
		move.w	#$2200,d1
		tst.b	(Scroll_lock).w
		bne.s	loc_54A50
		move.l	(__u_EE9C).w,d1		; Get BG movement speed if edge of screen is reached

loc_54A50:
		add.l	d1,4(a1)
		move.w	4(a1),d1
		move.w	d1,d2
		sub.w	$A(a1),d1
		move.w	d2,$A(a1)
		tst.b	(Scroll_lock).w
		beq.s	loc_54A74
		movea.w	(ScrEvents_Routine2).w,a5	; If movement is still going
		add.w	d0,$14(a5)			; Add Y movement to screen and robotnik ship
		add.w	d0,(Camera_Y_pos).w

loc_54A74:
		move.w	(Target_water_level).w,d2
		add.w	d0,d2
		add.w	d1,d2
		cmpi.w	#$F00,d2
		blo.s	loc_54A86
		move.w	#$F80,d2

loc_54A86:
		move.w	d2,(Target_water_level).w
		move.w	d0,(ScrEvents_C).w
		add.w	d1,(ScrEvents_C).w

locret_54A92:

		rts
; End of function LBZ2_DeathEggMoveScreen


; =============== S U B R O U T I N E =======================================


LBZ2_EndFallingAccel:
		tst.w	(__u_EEA2).w
		beq.s	loc_54AA2
		subi.w	#$100,(__u_EEA2).w
		bra.s	locret_54AB4
; ---------------------------------------------------------------------------

loc_54AA2:
		cmpi.l	#$FFFE8000,(__u_EE9C).w
		ble.s	locret_54AB4
		subi.l	#$100,(__u_EE9C).w

locret_54AB4:

		rts

; ---------------------------------------------------------------------------
LBZ_WaterWaveArray2:     dc.w     1,    1,    1,    0,    0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    1
		dc.w     1,    1,    1,    1,    1,    0,$FFFF,$FFFE,$FFFE,$FFFF,    0,    2,    2,    2,    2,    0
		dc.w     0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    1,    1,    1,    1,    1
		dc.w     1,    0,    0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    1,    1,    1
		dc.w     1,    1,    1,    0,    0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    1
		dc.w     1,    1,    1,    1,    1,    0,$FFFF,$FFFE,$FFFE,$FFFF,    0,    2,    2,    2,    2,    0
		dc.w     0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    1,    1,    1,    1,    1
		dc.w     1,    0,    0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    1,    1,    1
LBZ_WaterWaveArray:     dc.w     1,    1,    1,    0,    0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    1
		dc.w     1,    1,    1,    1,    1,    0,$FFFF,$FFFE,$FFFE,$FFFF,    0,    2,    2,    2,    2,    0
		dc.w     0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    1,    1,    1,    1,    1
		dc.w     1,    0,    0,    0,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,    0,    0,    0,    1,    1,    1
; ---------------------------------------------------------------------------

MHZ1_ScreenInit:
		clr.w	(ScrEvents_D).w
		clr.b	(__u_F7C1).w
		jsr	sub_54B80(pc)
	;	tst.w	(SK_alone_flag).w
	;	beq.s	loc_54B18
		move.b	(Last_star_post_hit).w,d0
		bne.s	loc_54B18

		lea	(Player_1).w,a1
		move.w	#$718,$10(a1)
		move.w	#$62D,$14(a1)
		move.w	#$680,d2
		move.w	#$5CD,d3

loc_54B08:
		move.w	d3,(Camera_Y_pos).w
		move.w	d3,(Camera_Y_pos_copy).w

loc_54B10:
		move.w	d2,(Camera_X_pos).w
		move.w	d2,(Camera_X_pos_copy).w

loc_54B18:

		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

MHZ1_ScreenEvent:
		tst.b	(ScrEvents_Routine2).w
		bne.s	loc_54B7C
		tst.w	(ScrEvents_D).w
		bne.s	loc_54B7C

		jsr	sub_54B80(pc)
		cmpi.w	#$4000,Camera_X_Pos.w	; NAT: Check for hide
		shs	MonContPos.w

		move.w	#$AA0,d0
		cmpi.w	#$4100,Player_2+x_pos.w	; NAT: Tails too
		bhs.s	.chg
		cmpi.w	#$4100,Player_1+x_pos.w
		blo.s	loc_54B40
.chg		move.w	#$710,d0

loc_54B40:
		cmp.w	(Camera_max_Y_pos).w,d0
		beq.s	loc_54B4E
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w

loc_54B4E:
		cmpi.w	#$710,(Camera_Y_pos).w
		blo.s	loc_54B7C
		cmpi.w	#$4298,(Camera_X_pos).w
		blo.s	loc_54B7C
		move.w	#$710,(Camera_min_Y_pos).w
		move.w	#8,(Special_Events_Routine).w
		st	(ScrEvents_Routine2).w
		jsr	Create_New_Sprite.w
		bne.s	loc_54B7C
		move.l	#Obj_MHZ_Miniboss,(a1)

loc_54B7C:

		jmp	DrawTilesAsYouMove(pc)

; =============== S U B R O U T I N E =======================================


sub_54B80:

		move.w	#$680,d0

loc_54B98:

		cmp.w	(Camera_min_X_pos).w,d0
		beq.s	locret_54BA2
		move.w	d0,(Camera_min_X_pos).w

locret_54BA2:
		rts
; End of function sub_54B80

; ---------------------------------------------------------------------------

MHZ1_BackgroundInit:
		move.w	(Camera_X_pos_copy).w,(ScrEvents_0).w
		move.w	(Camera_X_pos_copy).w,(__u_EEB6).w
		jsr	sub_54C68(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

MHZ1_BackgroundEvent:
		tst.w	(ScrEvents_2).w
		beq.w	loc_54C3C
		clr.w	(ScrEvents_2).w

		movem.l	d7-a0/a2-a3,-(sp)
		moveq	#$28,d0
		jsr	Load_PLC.w
		move.w	#$701,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(NoReset_RespawnTbl).w
		jsr	Clear_Switches.w
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$4200,d0
		moveq	#0,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w
		jsr	sub_54CF4(pc)
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		move.w	(Camera_X_pos_copy).w,(ScrEvents_0).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		jsr	Reset_TileOffsetPositionActual(pc)
		clr.w	(Special_Events_Routine).w
		clr.b	(ScrEvents_Routine2).w

loc_54C3C:
		lea	(ScrEvents_0).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		move.w	#$100,d2
		move.w	#$200,d3
		jsr	Adjust_BGDuringLoop(pc)
		jsr	sub_54C68(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jmp	PlainDeformation(pc)

; =============== S U B R O U T I N E =======================================


sub_54C68:

		move.w	(Camera_Y_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#3,d0
		move.l	d0,d1
		asr.l	#2,d1
		add.l	d1,d0
		swap	d0
		addi.w	#$76,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(__u_EEB6).w,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#2,d1
		sub.l	d1,d0
		asr.l	#1,d1
		swap	d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(ScrEvents_A).w
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(ScrEvents_B).w
		rts
; End of function sub_54C68

; ---------------------------------------------------------------------------

loc_54CB0:
		clr.w	(Displace_Obj_X).w
		move.w	(Camera_X_pos).w,d0
		cmpi.w	#$4400,d0
		blo.s	loc_54CEE
		move.w	#$200,d1
		move.w	d1,(Displace_Obj_X).w
		sub.w	d1,(Player_1+x_pos).w
		sub.w	d1,(Player_2+x_pos).w
		sub.w	d1,d0
		move.w	d0,d1
		andi.w	#-$10,d1
		subi.w	#$10,d1
		move.w	d1,(Camera_X_pos_rounded).w

loc_54CDE:
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	#$4298,d2
		move.w	d2,(Camera_max_X_pos).w

loc_54CEE:
		move.w	d0,(Camera_min_X_pos).w

locret_54CF2:
		rts

; =============== S U B R O U T I N E =======================================


sub_54CF4:
		lea	(Dynamic_object_RAM+$4A).w,a1
		moveq	#$59,d2

loc_54CFA:
		move.l	(a1),d3
		beq.s	loc_54D26
		cmpi.l	#loc_2B962,d3
		bne.s	loc_54D16
		move.l	#Delete_Current_Sprite,(a1)
		move.w	respawn_addr(a1),d3
		beq.s	loc_54D16
		movea.w	d3,a5
		clr.b	(a5)

loc_54D16:

		btst	#2,4(a1)
		beq.s	loc_54D26
		sub.w	d0,$10(a1)
		sub.w	d1,$14(a1)

loc_54D26:

		lea	next_object(a1),a1
		dbf	d2,loc_54CFA
		rts
; End of function sub_54CF4

; ---------------------------------------------------------------------------

MHZ2_ScreenInit:
		move.w	#4,(ScrEvents_Routine).w
		clr.w	(ScrEvents_D).w
		st	(__u_F7C1).w
		move.w	(Player_1+x_pos).w,d0
		lea	Pal_MHZ2Gold(pc),a1
		cmpi.w	#$2940,d0
		bhs.s	loc_54D72
		st	(ScrEvents_4).w
		lea	(Pal_MHZ2+$20).l,a1
		cmpi.w	#$9C0,d0
		bhs.s	loc_54D72
		cmpi.w	#$600,(Player_1+y_pos).w
		blo.s	loc_54D72
		clr.b	(ScrEvents_4).w
		clr.b	(__u_F7C1).w
		lea	(Pal_MHZ1+$20).l,a1

loc_54D72:

		lea	(Normal_palette_line_3).w,a5
		lea	(Target_palette_line_3).w,a6
		moveq	#$F,d0

loc_54D7C:
		move.l	(a1),(a5)+
		move.l	(a1)+,(a6)+
		dbf	d0,loc_54D7C
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull(pc)
; ---------------------------------------------------------------------------

MHZ2_ScreenEvent:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_X_pos_copy).w
		move.w	(ScrEvents_Routine).w,d0
		jmp	loc_54D9C(pc,d0.w)
; ---------------------------------------------------------------------------

loc_54D9C:
		bra.w	loc_54DB0
; ---------------------------------------------------------------------------
		bra.w	loc_54DBE
; ---------------------------------------------------------------------------
		bra.w	loc_54E86
; ---------------------------------------------------------------------------
		bra.w	loc_54E9C
; ---------------------------------------------------------------------------
		bra.w	loc_54F64
; ---------------------------------------------------------------------------

loc_54DB0:
		tst.b	(Title_Card_Out_Flag).w
		beq.s	loc_54DBA
		addq.w	#4,(ScrEvents_Routine).w

loc_54DBA:
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

loc_54DBE:
		tst.w	(ScrEvents_1).w
		beq.s	loc_54DDC
		clr.w	(ScrEvents_1).w
		move.w	#$320,(DrawDelayed_Position).w
		move.w	#$A,(DrawDelayed_RowCount).w
		addq.w	#8,(ScrEvents_Routine).w
		bra.w	loc_54E9C
; ---------------------------------------------------------------------------

loc_54DDC:
		cmpi.w	#$3C90,(Camera_X_pos).w
		blo.s	loc_54E00
		bne.w	loc_54E7E
		move.w	#$3C90,(Camera_min_X_pos).w
		cmpi.w	#$280,(Camera_Y_pos).w
		blo.w	loc_54E7E
		move.w	#$280,(Camera_min_Y_pos).w
		bra.w	loc_54E7E
; ---------------------------------------------------------------------------

loc_54E00:
		move.w	#$620,d0
		cmpi.w	#$380,(Camera_X_pos).w
		blo.s	loc_54E1A
		moveq	#0,d0
		cmpi.w	#$3600,(Camera_X_pos).w
		blo.s	loc_54E1A
		move.w	#$1A8,d0

loc_54E1A:

		cmp.w	(Camera_min_Y_pos).w,d0
		beq.s	loc_54E24
		move.w	d0,(Camera_min_Y_pos).w

loc_54E24:
		cmpi.w	#$3600,(Camera_X_pos).w
		bhs.s	loc_54E4C
		move.w	#$98,d0
		cmpi.w	#$5C0,(Player_1+y_pos).w
		bhs.s	loc_54E3C
		cmpi.w	#$5C0,Player_2+y_pos.w	; NAT: Tiles
		bhs.s	loc_54E3C
		move.w	#$380,d0

loc_54E3C:
		cmp.w	(Camera_min_X_pos).w,d0
		beq.s	loc_54E4C
		tst.w	(ScrEvents_D).w
		bne.s	loc_54E4C
		move.w	d0,(Camera_min_X_pos).w

loc_54E4C:

		move.w	#$9A0,d0
		cmpi.w	#$3A97,Player_2+x_pos.w	; NAT: Tiles
		bhs.s	.kkkk
		cmpi.w	#$3A97,(Player_1+x_pos).w
		blo.s	loc_54E70

.kkkk		move.w	#$280,d0
		st	MonContPos.w		; move contents up
		cmpi.w	#$3AE0,Player_2+x_pos.w	; NAT: Tiles
		bhs.s	loc_54E70
		cmpi.w	#$3AE0,(Player_1+x_pos).w
		bhs.s	loc_54E70
.kkkkk		move.w	#$9A0,d0
		clr.b	MonContPos.w		; move contents down

loc_54E70:

		cmp.w	(Camera_max_Y_pos).w,d0
		beq.s	loc_54E7E
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w

loc_54E7E:

		bsr.w	sub_55008
		jmp	DrawTilesAsYouMove(pc)
; ---------------------------------------------------------------------------

loc_54E86:
		move.w	(Camera_X_pos_copy).w,(Block_table+$1804).w
		lea	MHZ2_BGDrawArray1(pc),a4
		lea	(Block_table+$1800).w,a5
		moveq	#$15,d6
		moveq	#2,d5
		jmp	loc_4EDD8(pc)
; ---------------------------------------------------------------------------

loc_54E9C:

		move.w	#$4280,d1
		move.w	#$280,d2
		jsr	Draw_PlaneVertBottomUp(pc)
		bpl.w	locret_54F62
		move.l	#$400000,(__u_EE98).w
		move.w	#$80,d0
		move.w	d0,(__u_EEA2).w
		move.w	d0,(__u_EE9C).w
		jsr	sub_54F8C(pc)
		lea	(Block_table+$1800).w,a1
		move.w	(a1)+,d0
		andi.w	#-$10,d0
		move.w	d0,(a1)+
		clr.l	(a1)+
		move.w	(a1)+,d0
		andi.w	#-$10,d0
		move.w	d0,(a1)+
		lea	(Normal_palette_line_2).w,a1
		lea	Pal_MHZ2Ship(pc),a5
		moveq	#7,d0

loc_54EE4:
		move.l	(a5)+,(a1)+
		dbf	d0,loc_54EE4
		lea	(Block_table+$180C).w,a5
		clr.l	(a5)
		jsr	Create_New_Sprite.w
		bne.s	loc_54F2A
		move.l	#loc_5583E,(a1)
		move.w	#$4C0,$30(a1)
		move.w	#$4000,$3A(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_54F2A
		move.l	#loc_55814,(a1)
		move.w	a1,(a5)+
		jsr	(CreateNewSprite4).l
		bne.s	loc_54F2A
		move.l	#loc_55814,(a1)
		move.w	a1,(a5)+

loc_54F2A:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(ArtKosM_MHZShipPropeller).l,a1
		move.w	#-$6000,d2
		jsr	Queue_Kos_Module.w
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$4EF9,(H_int_jump).w
		move.l	#HInt6,(H_int_addr).w
		move.b	#$80,(H_int_counter).w
		move.w	#-$7FEC,(VDP_control_port).l
		addq.w	#4,(ScrEvents_Routine).w

locret_54F62:
		rts
; ---------------------------------------------------------------------------

loc_54F64:
		jsr	sub_54F8C(pc)
		lea	MHZ2_BGDrawArray3(pc),a4
		lea	(Block_table+$1800).w,a6
		moveq	#2,d5
		move.w	(__u_EEA2).w,d6
		jsr	Draw_BGNoVert(pc)
		lea	MHZ2_BGDrawArray2(pc),a4
		lea	(Block_table+$1804).w,a6
		moveq	#2,d5
		move.w	(Camera_Y_pos_rounded).w,d6
		jmp	Draw_BGNoVert(pc)

; =============== S U B R O U T I N E =======================================


sub_54F8C:
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,(Block_table+$1808).w
		addi.w	#$1E0,d0
		add.w	(__u_EE98).w,d0
		move.w	(Block_table+$1800).w,d2
		move.w	d0,(Block_table+$1800).w
		move.w	(__u_EE9C).w,d1
		lea	(Player_1).w,a1
		cmpi.b	#-$7F,$2E(a1)
		bne.s	loc_54FD4
	;	move.w	#$2DC,d3
	;	cmpi.w	#3,(Player_mode).w
	;	beq.s	loc_54FC4
		move.w	#$2CD,d3

loc_54FC4:
		move.w	(ScrEvents_8).w,d4
		sub.w	d1,d4
		add.w	d4,$14(a1)
		sub.w	d0,d2
		add.w	d2,$10(a1)

		add.w	d4,$14+$4A(a1)		; NAT: Do tails?
		add.w	d2,$10+$4A(a1)

loc_54FD4:
		move.w	d1,(ScrEvents_8).w
		neg.w	d1
		addi.w	#$158,d1
		lea	(Block_table+$180C).w,a1
		move.w	#$46B8,d2
		bsr.s	sub_54FEC
		move.w	#$45B8,d2
; End of function sub_54F8C


; =============== S U B R O U T I N E =======================================


sub_54FEC:
		move.w	(a1)+,d3
		beq.s	locret_55006
		movea.w	d3,a5
		sub.w	d0,d2
		bcs.s	locret_55006
		addi.w	#$5C,d2
		andi.w	#$1FF,d2
		move.w	d2,$10(a5)
		move.w	d1,$14(a5)

locret_55006:
		rts
; End of function sub_54FEC


; =============== S U B R O U T I N E =======================================

; MHZ PALETTE SHENANIGANS
sub_55008:
		lea	word_5513E(pc),a1
;		move.w	(Player_1+x_pos).w,d0
;		move.w	(Player_1+y_pos).w,d1
		move.w	Camera_X_Pos.w,d0	; NAT: Get approx camera pos as fake
		add.w	#320/2,d0		; Dont judge me =/
		move.w	Camera_Y_Pos.w,d1
		add.w	#224/2,d1
		moveq	#0,d2
		move.w	#4,d3

loc_5501A:
		lea	(a1),a5
		cmp.w	(a5)+,d0
		blo.s	loc_5502C
		cmp.w	(a5)+,d0
		bhi.s	loc_5502C
		cmp.w	(a5)+,d1
		blo.s	loc_5502C
		cmp.w	(a5)+,d1
		blo.s	loc_55038

loc_5502C:

		adda.w	#$A,a1
		addq.w	#4,d2
		dbf	d3,loc_5501A
		rts
; ---------------------------------------------------------------------------

loc_55038:
		jmp	loc_5503C(pc,d2.w)
; End of function sub_55008

; ---------------------------------------------------------------------------

loc_5503C:
		bra.w	loc_55050
; ---------------------------------------------------------------------------
		bra.w	loc_55062
; ---------------------------------------------------------------------------
		bra.w	loc_55074
; ---------------------------------------------------------------------------
		bra.w	loc_55074
; ---------------------------------------------------------------------------
		bra.w	loc_55086
; ---------------------------------------------------------------------------

loc_55050:
		tst.w	(ScrEvents_4).w
		bne.s	loc_5505C
		cmp.w	(a5),d1
		blo.s	loc_55098
		rts
; ---------------------------------------------------------------------------

loc_5505C:
		cmp.w	(a5),d1
		bhs.s	loc_550A8
		rts
; ---------------------------------------------------------------------------

loc_55062:
		tst.w	(ScrEvents_4).w
		bne.s	loc_5506E
		cmp.w	(a5),d0
		bhs.s	loc_55098
		rts
; ---------------------------------------------------------------------------

loc_5506E:
		cmp.w	(a5),d0
		blo.s	loc_550A8
		rts
; ---------------------------------------------------------------------------

loc_55074:

		tst.w	(ScrEvents_4).w
		bne.s	loc_55080
		cmp.w	(a5),d0
		blo.s	loc_55098
		rts
; ---------------------------------------------------------------------------

loc_55080:
		cmp.w	(a5),d0
		bhs.s	loc_550B8
		rts
; ---------------------------------------------------------------------------

loc_55086:
		tst.w	(ScrEvents_4).w
		bne.s	loc_55092
		cmp.w	(a5),d1
		blo.s	loc_55098
		rts
; ---------------------------------------------------------------------------

loc_55092:
		cmp.w	(a5),d1
		bhs.s	loc_550B8
		rts
; ---------------------------------------------------------------------------

loc_55098:

		st	(ScrEvents_4).w
		st	(__u_F7C1).w
		lea	(Pal_MHZ2+$20).l,a1
		bra.s	loc_550C4
; ---------------------------------------------------------------------------

loc_550A8:

		clr.w	(ScrEvents_4).w
		clr.b	(__u_F7C1).w
		lea	(Pal_MHZ1+$20).l,a1
		bra.s	loc_550C4
; ---------------------------------------------------------------------------

loc_550B8:

		clr.w	(ScrEvents_4).w
		st	(__u_F7C1).w
		lea	Pal_MHZ2Gold(pc),a1

loc_550C4:

		lea	(Normal_palette_line_3).w,a5
		moveq	#$F,d0

loc_550CA:
		move.l	(a1)+,(a5)+
		dbf	d0,loc_550CA
		rts
; ---------------------------------------------------------------------------
MHZ2_BGDrawArray1:
		dc.w $2B0
		dc.w $7FFF
MHZ2_BGDrawArray2:
		dc.w $300
		dc.w $7FFF
MHZ2_BGDrawArray3:
		dc.w $100
		dc.w $7FFF
Pal_MHZ2Ship:	binclude "Levels/MHZ/Palettes/Act 2 Ship.bin"
	even

Pal_MHZ2Gold:	binclude "Levels/MHZ/Palettes/Act 2 Gold.bin"
	even


word_5513E:	dc.w   $420,  $4A0,  $640,  $6C0
		dc.w   $680,  $980,  $A00,  $7C0
		dc.w   $800,  $9C0, $2900, $2980
		dc.w   $280,  $300, $2940, $2B00
		dc.w  $2B80,  $540,  $580, $2B40
		dc.w  $2800, $2980,  $7C0,  $840
		dc.w   $800
; ---------------------------------------------------------------------------

MHZ2_BackgroundInit:
		move.w	(Camera_X_pos_copy).w,(ScrEvents_0).w
		move.w	(Camera_X_pos_copy).w,(__u_EEB6).w
		cmpi.w	#$3700,(Player_1+x_pos).w
		blo.s	loc_55198
		cmpi.w	#$500,(Player_1+y_pos).w
		bhs.s	loc_55198
		move.w	#8,(TrigEvents_Routine).w
		jsr	sub_554B8(pc)
		bra.s	loc_5519C
; ---------------------------------------------------------------------------

loc_55198:

		jsr	sub_54C68(pc)

loc_5519C:
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	Refresh_PlaneFull(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

MHZ2_BackgroundEvent:
		lea	(ScrEvents_0).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		move.w	#$100,d2
		move.w	#$200,d3
		jsr	Adjust_BGDuringLoop(pc)
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_551C6(pc,d0.w)
; ---------------------------------------------------------------------------

loc_551C6:
		bra.w	loc_551EE
; ---------------------------------------------------------------------------
		bra.w	loc_55236
; ---------------------------------------------------------------------------
		bra.w	loc_55250
; ---------------------------------------------------------------------------
		bra.w	loc_552F8
; ---------------------------------------------------------------------------
		bra.w	loc_55312	; $10
; ---------------------------------------------------------------------------
		bra.w	loc_553B6
; ---------------------------------------------------------------------------
		bra.w	loc_55424
; ---------------------------------------------------------------------------
		bra.w	loc_5543A
; ---------------------------------------------------------------------------
		bra.w	loc_5545A
; ---------------------------------------------------------------------------
		bra.w	loc_55486
; ---------------------------------------------------------------------------

loc_551EE:
		cmpi.w	#$3700,Player_2+x_pos.w
		blo.s	.sonic
		cmpi.w	#$500,Player_2+y_pos.w
		blo.s	.ok
.sonic		cmpi.w	#$3700,Player_1+x_pos.w
		blo.s	loc_5521E
		cmpi.w	#$500,Player_1+y_pos.w
		bhs.s	loc_5521E

.ok		jsr	sub_554B8(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_5523A
; ---------------------------------------------------------------------------

loc_5521E:

		jsr	sub_54C68(pc)

loc_55222:

		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_55236:
		jsr	sub_554B8(pc)

loc_5523A:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	loc_552E4
		addq.w	#4,(TrigEvents_Routine).w
		bra.w	loc_552E4
; ---------------------------------------------------------------------------

loc_55250:
		cmpi.w	#$500,Player_2+y_pos.w
		blo.s	loc_5527A
		cmpi.w	#$500,Player_1+y_pos.w
		blo.s	loc_5527A

		jsr	sub_54C68(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.w	loc_552FC
; ---------------------------------------------------------------------------

loc_5527A:
		cmpi.w	#$420,Player_2+y_pos.w
		bls.s	loc_5528A
		cmpi.w	#$420,Player_1+y_pos.w
		bls.s	loc_5528A
		btst	#1,Player_2+status.w
		beq.s	loc_5528A
		btst	#1,Player_1+status.w
		bne.s	loc_552E0

loc_5528A:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(MHZ_Custom_Layout).l,a1
		lea	(Level_layout_header).w,a2
		move.w	#$1FF,d0

loc_5529C:
		move.l	(a1)+,(a2)+
		move.l	(a1)+,(a2)+
		dbf	d0,loc_5529C
		lea	(MHZ_128x128_Custom_Kos).l,a1
		lea	(Chunk_table+$2280).l,a2
		jsr	Queue_Kos.w
		lea	(MHZ_16x16_Custom_Kos).l,a1
		lea	(Block_table+$B28).w,a2
		jsr	Queue_Kos.w
		lea	(ArtKosM_MHZ_Custom).l,a1
		move.w	#$4440,d2
		jsr	Queue_Kos_Module.w
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#8,(TrigEvents_Routine).w
		bra.s	loc_55312
; ---------------------------------------------------------------------------

loc_552E0:
		jsr	sub_554B8(pc)

loc_552E4:

		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jmp	PlainDeformation(pc)
; ---------------------------------------------------------------------------

loc_552F8:
		jsr	sub_54C68(pc)

loc_552FC:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		bpl.w	loc_55222
		clr.w	(TrigEvents_Routine).w
		bra.w	loc_55222
; ---------------------------------------------------------------------------

loc_55312:

		tst.b	(ScrEvents_Routine2).w
		bne.s	loc_55380
		cmpi.w	#$3F00,(Camera_X_pos).w
		blo.w	loc_55486
		addq.w	#4,(ScrEvents_Routine).w
		clr.l	(Block_table+$1800).w
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,(Block_table+$1804).w
		andi.w	#-$10,d0
		move.w	d0,(Block_table+$1806).w
		move.w	#$1A0,(DrawDelayed_Position).w
		move.w	#2,(DrawDelayed_RowCount).w
		st	(ScrEvents_Routine2).w
		lea	word_558E8(pc),a1
	;	cmpi.w	#3,(Player_mode).w
	;	bne.s	loc_5535A
	;	lea	$10(a1),a1

loc_5535A:
		move.b	(a1),(ScrEvents_5+$1).w
		st	(Scroll_lock).w
		move.w	#$C,(Special_Events_Routine).w
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(ArtKosM_MHZEndBossPillar).l,a1
		move.w	#$98E0,d2
		jsr	Queue_Kos_Module.w
		movem.l	(sp)+,d7-a0/a2-a3

loc_55380:
		move.w	#$4000,d1
		move.w	#$180,d2
		lea	(Level_layout_main).w,a3
		move.w	#-$4000,d7
		jsr	Draw_PlaneVertSingleBottomUp(pc)
		addq.w	#2,a3
		move.w	#-$2000,d7
		tst.w	(DrawDelayed_RowCount).w
		bpl.w	loc_55486
		move.w	#$80,(DrawDelayed_Position).w
		move.w	#2,(DrawDelayed_RowCount).w
		st	(ScrEvents_Routine2+$1).w
		addq.w	#4,(TrigEvents_Routine).w

loc_553B6:
		move.w	#$200,d1
		move.w	#$80,d2
		jsr	Draw_PlaneVertTopDown(pc)
		bpl.w	loc_55486
		lea	(Block_table+$1808).w,a5
		clr.l	(a5)
		clr.l	4(a5)
		jsr	Create_New_Sprite.w
		bne.s	loc_55420
		move.l	#loc_556F8,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_55420
		move.l	#loc_55732,(a1)
		move.w	a1,(a5)+
		moveq	#2,d1

loc_553F0:
		jsr	(CreateNewSprite4).l
		bne.s	loc_55420
		move.l	#loc_5577C,(a1)
		move.w	d1,$2E(a1)
		move.w	a1,(a5)+
		jsr	(CreateNewSprite4).l
		bne.s	loc_55420
		move.l	#loc_5577C,(a1)
		move.w	d1,$2E(a1)
		st	$30(a1)
		move.w	a1,(a5)+
		dbf	d1,loc_553F0

loc_55420:

		addq.w	#4,(TrigEvents_Routine).w

loc_55424:
		tst.w	(ScrEvents_2).w
		bpl.s	loc_55486
		move.w	#$180,(DrawDelayed_Position).w
		move.w	#2,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w

loc_5543A:
		moveq	#0,d1
		move.w	#$180,d2
		jsr	Draw_PlaneVertTopDown(pc)
		bpl.s	loc_55486
		clr.b	(ScrEvents_Routine2+$1).w
		move.w	#$280,(DrawDelayed_Position).w
		move.w	#2,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w

loc_5545A:
		move.w	#$4080,d1
		move.w	#$280,d2
		lea	(Level_layout_main).w,a3
		move.w	#-$4000,d7
		jsr	Draw_PlaneVertTopDown(pc)
		addq.w	#2,a3
		move.w	#-$2000,d7
		tst.w	(DrawDelayed_RowCount).w
		bpl.s	loc_55486
		clr.b	(ScrEvents_Routine2).w
		clr.w	(ScrEvents_Routine).w
		addq.w	#4,(TrigEvents_Routine).w

loc_55486:

		jsr	sub_554B8(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	Draw_TileRow(pc)
		jsr	sub_5550C(pc)
		cmpi.w	#$10,(ScrEvents_Routine).w
		bne.s	loc_554B4
		move.w	(__u_EE9C).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp

loc_554B4:
		jmp	ShakeScreen_Setup.w

; =============== S U B R O U T I N E =======================================

sub_554B8:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$280,d0
		swap	d0
		clr.w	d0
		asr.l	#3,d0
		move.l	d0,d1
		asr.l	#2,d1
		add.l	d1,d0
		swap	d0
		addi.w	#$180,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(__u_EEB6).w,d0
		move.w	(ScrShake_Offset).w,d2
		sub.w	d2,d0
		swap	d0
		clr.w	d0
		asr.l	#1,d0
		move.l	d0,d1
		asr.l	#2,d1
		sub.l	d1,d0
		asr.l	#1,d1
		swap	d0
		add.w	d2,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(ScrEvents_A).w
		swap	d0
		sub.l	d1,d0
		swap	d0
		move.w	d0,(ScrEvents_B).w
		rts
; End of function sub_554B8


; =============== S U B R O U T I N E =======================================


sub_5550C:
		jsr	PlainDeformation(pc)
		cmpi.w	#$10,(ScrEvents_Routine).w
		bne.s	loc_55534
		lea	(H_scroll_buffer).w,a1
		move.w	(Block_table+$1800).w,d0
		neg.w	d0
		moveq	#$3F,d1

loc_55524:
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		dbf	d1,loc_55524
		rts
; ---------------------------------------------------------------------------

loc_55534:
		tst.b	(ScrEvents_Routine2).w
		beq.s	loc_55552
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_X_pos_BG_copy).w,d0
		neg.w	d0
		moveq	#$17,d1

loc_55546:
		move.w	d0,(a1)
		addq.w	#4,a1
		move.w	d0,(a1)
		addq.w	#4,a1
		dbf	d1,loc_55546

loc_55552:
		tst.b	(ScrEvents_Routine2+$1).w
		beq.w	locret_5560A
		move.w	(Camera_X_pos).w,d0
		subi.w	#$4180,d0
		cmpi.w	#-$140,d0
		blt.w	loc_555FC
		move.w	d0,d1
		muls.w	#$5600,d1
		add.l	d1,d1
		swap	d1
		sub.w	d1,d0
		subi.w	#$18,d0
		swap	d0
		clr.w	d0
		tst.l	d0
		smi	d3
		bpl.s	loc_55586
		neg.l	d0

loc_55586:
		moveq	#0,d2
		swap	d0
		move.w	d0,d2
		divu.w	#$30,d2
		move.w	d2,d1
		swap	d0
		move.w	d0,d2
		divu.w	#$30,d2
		swap	d1
		move.w	d2,d1
		tst.b	d3
		beq.s	loc_555A4
		neg.l	d1

loc_555A4:
		lea	(H_scroll_buffer+2).w,a1
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$80,d0
		neg.w	d0
		swap	d0
		clr.w	d0
		moveq	#$2F,d2

loc_555B8:
		swap	d0
		move.w	d0,(a1)
		swap	d0
		add.l	d1,d0
		addq.w	#4,a1
		dbf	d2,loc_555B8
		lea	(Block_table+$1808).w,a1
		lea	(H_scroll_buffer+$BE).w,a5
		moveq	#$1C,d0
		moveq	#6,d1

loc_555D2:
		move.w	(a1)+,d2
		beq.s	locret_5560A
		movea.w	d2,a6
		move.w	(a5),d2
		subi.w	#$48,d2
		andi.w	#$1FF,d2
		add.w	(Camera_X_pos).w,d2
		move.w	d2,$10(a6)
		btst	#0,d1
		bne.s	loc_555F6
		suba.w	d0,a5
		addi.w	#$C,d0

loc_555F6:
		dbf	d1,loc_555D2
		rts
; ---------------------------------------------------------------------------

loc_555FC:
		lea	(H_scroll_buffer+2).w,a1
		moveq	#$2F,d0

loc_55602:
		clr.w	(a1)
		addq.w	#4,a1
		dbf	d0,loc_55602

locret_5560A:

		rts
; End of function sub_5550C

; ---------------------------------------------------------------------------

loc_5560C:
		clr.w	(Displace_Obj_X).w
		move.w	(Camera_X_pos).w,d0
		addq.w	#4,d0
	;	cmpi.w	#3,(Player_mode).w
	;	bne.s	loc_55620
	;	addq.w	#1,d0

loc_55620:
		cmpi.w	#$4280,d0
		blo.s	loc_5569A
		tst.w	(ScrEvents_2).w
		beq.s	loc_5564A
		st	(ScrEvents_2).w
		cmpi.w	#$4420,d0
		blo.s	loc_5569A
		move.w	#$4420,d0
		move.w	#$45A0,(Camera_max_X_pos).w
		st	(Scroll_lock).w
		clr.w	(Special_Events_Routine).w
		bra.s	loc_5569E
; ---------------------------------------------------------------------------

loc_5564A:
		move.w	#$200,d1
		move.w	d1,(Displace_Obj_X).w
		sub.w	d1,(Player_1+x_pos).w
		sub.w	d1,(Player_2+x_pos).w
		sub.w	d1,d0
		move.w	d0,d1
		andi.w	#-$10,d1
		subi.w	#$10,d1
		move.w	d1,(Camera_X_pos_rounded).w
		addq.w	#1,(ScrEvents_6).w
		move.w	(ScrEvents_6).w,d1
		andi.w	#$F,d1
		lea	word_558E8(pc),a1
	;	cmpi.w	#3,(Player_mode).w
	;	bne.s	loc_55686
	;	lea	$10(a1),a1

loc_55686:
		move.b	(a1,d1.w),(ScrEvents_5+$1).w
		tst.b	(__u_FAA9).w
		beq.s	loc_5569A
		st	(ScrEvents_7).w
		clr.b	(__u_FAA9).w

loc_5569A:

		move.w	d0,(Camera_max_X_pos).w

loc_5569E:
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,d1
		lea	(Player_1).w,a1
		bsr.s	sub_556B8
		move.w	d1,d0
		lea	(Player_2).w,a1

; =============== S U B R O U T I N E =======================================


sub_556B8:
		cmpi.b	#5,$20(a1)
		bne.s	loc_556C4
		clr.b	$20(a1)

loc_556C4:
		addi.w	#$18,d0
		cmp.w	$10(a1),d0
		bls.s	loc_556E8
		move.w	d0,$10(a1)
		move.w	#$400,$1C(a1)
	;	cmpi.w	#3,(Player_mode).w
	;	bne.s	locret_556F6
	;	move.w	#$500,$1C(a1)
	;	bra.s	locret_556F6
		rts
; ---------------------------------------------------------------------------

loc_556E8:
		addi.w	#$A8,d0
		cmp.w	$10(a1),d0
		bhi.s	locret_556F6
		move.w	d0,$10(a1)

locret_556F6:

		rts
; End of function sub_556B8

; ---------------------------------------------------------------------------

loc_556F8:
		move.l	#loc_5576A,(a0)
		move.b	#4,4(a0)
		move.b	#$18,6(a0)
		move.b	#$18,7(a0)
		move.w	#prio(1),8(a0)
		move.w	#$E4C7,$A(a0)
		move.l	#Map_MHZEndBossMisc,$C(a0)
		move.w	#$4238,$10(a0)
		move.w	#$2F0,$14(a0)
		bra.s	loc_5576A
; ---------------------------------------------------------------------------

loc_55732:
		move.l	#loc_5576A,(a0)
		move.b	#$44,4(a0)
		move.b	#-$80,6(a0)
		move.b	#$C,7(a0)
		move.w	#prio(7),8(a0)
		move.w	#$64C7,$A(a0)
		move.l	#Map_MHZEndBossMisc,$C(a0)
		move.w	#$300,$14(a0)
		move.b	#1,$22(a0)

loc_5576A:

		tst.b	(ScrEvents_Routine2+$1).w
		bne.s	loc_55776
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_55776:
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

loc_5577C:

		move.l	#loc_557C8,(a0)
		move.b	#$44,4(a0)
		move.b	#$10,6(a0)
		move.b	#$10,7(a0)
		move.w	#$23AF,$A(a0)
		move.l	#Map_MHZEndBossMisc,$C(a0)
		move.b	#-$75,$28(a0)
		move.w	#prio(1),d0
		moveq	#4,d1
		move.w	$2E(a0),d2
		subq.w	#1,d2
		bcs.s	loc_557C0

loc_557B6:
		addi.w	#prlayersize,d0
		subq.w	#1,d1
		dbf	d2,loc_557B6

loc_557C0:
		move.w	d0,8(a0)
		move.b	d1,$22(a0)

loc_557C8:
		tst.w	(ScrEvents_7).w
		bne.s	loc_557D4
		tst.b	(ScrEvents_Routine2+$1).w
		bne.s	loc_557DA

loc_557D4:
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_557DA:
		move.w	(ScrEvents_5).w,d0
		tst.w	$30(a0)
		beq.s	loc_557EC
		cmpi.w	#4,d0
		bne.s	locret_55812
		moveq	#0,d0

loc_557EC:
		lsl.w	#2,d0
		add.w	$2E(a0),d0
		add.w	d0,d0
		lea	word_558C2(pc),a1
		move.w	(a1,d0.w),$14(a0)
		jsr	Draw_Sprite.w
		cmpi.w	#1,$2E(a0)
		bne.s	locret_55812
		jmp	Add_SpriteToCollisionResponseList.w
; ---------------------------------------------------------------------------

locret_55812:

		rts
; ---------------------------------------------------------------------------

loc_55814:

		move.l	#loc_5582E,(a0)
		move.w	#prio(7),8(a0)
		move.w	#-$5B00,$A(a0)
		move.l	#Map_MHZEndBossMisc,$C(a0)

loc_5582E:
		lea	Ani_MHZEndPropellers(pc),a1
		jsr	Animate_Sprite.w
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

loc_5583E:
		addq.b	#1,$3C(a0)
		addi.l	#$C0,$38(a0)
		move.l	$38(a0),d0
		sub.l	d0,(__u_EE98).w
		tst.w	(ScrEvents_1).w
		beq.s	loc_55876
		cmpi.l	#$2800,$2E(a0)
		bne.s	loc_55876
		move.w	$32(a0),d0
		move.b	$3C(a0),d1
		andi.w	#3,d1
		bne.s	loc_55888
		addq.w	#1,$32(a0)
		bra.s	loc_55888
; ---------------------------------------------------------------------------

loc_55876:

		move.l	#$2800,d0
		move.l	#$C0,d1
		jsr	Gradual_SwingOffset.w

loc_55888:

		add.w	(__u_EEA2).w,d0
		addq.w	#5,d0
		move.w	d0,(__u_EE9C).w
		tst.b	(__u_FAA9).w
		bne.s	loc_558AC
		cmpi.w	#-$3E6,(__u_EE98).w
		bgt.s	loc_558AC
		st	(__u_FAA9).w
		st	(ScrEvents_1).w
		st	(Scroll_lock).w

loc_558AC:

		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	locret_558C0
		moveq	#-$43,d0
		jmp	Play_Sound_2.w

locret_558C0:
		rts
; ---------------------------------------------------------------------------
word_558C2:	dc.w $336
		dc.w $334
		dc.w $333
		dc.w 0
		dc.w $320
		dc.w $320
		dc.w $320
		dc.w 0
		dc.w $2F6
		dc.w $2F8
		dc.w $2FA
		dc.w 0
		dc.w $2C9
		dc.w $2CF
		dc.w $2D4
		dc.w 0
		dc.w $2C9
		dc.w $2CF
		dc.w $2D4
word_558E8:	dc.w $102

		dc.w 2
		dc.w $102
		dc.w $100
		dc.w $200
		dc.w $102
		dc.w $102
		dc.w $200
		dc.w $102
		dc.w 3
		dc.w $104
		dc.w $200
		dc.w $401
		dc.w $304
		dc.w $200
		dc.w $402
Map_MHZEndBossMisc:	include "Levels/MHZ/Misc Object Data/Map - End Boss Misc.asm"

Ani_MHZEndPropellers:	include "Levels/MHZ/Misc Object Data/Anim - End Propellers.asm"

; ---------------------------------------------------------------------------

SOZ1_ScreenInit:
		jsr	Reset_TileOffsetPositionActual(pc)
		jmp	Refresh_PlaneFull
; ---------------------------------------------------------------------------

SOZ1_ScreenEvent:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jmp	DrawTilesAsYouMove
; ---------------------------------------------------------------------------

SOZ1_BackgroundInit:
		move.w	(a3),$1C(a3)
		movea.w	$18(a3),a1
		move.b	#-3,$D(a1)
		jsr	sub_55D56(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		moveq	#0,d1
		jsr	(Refresh_PlaneFull).l
		jmp	loc_55DF2(pc)
; ---------------------------------------------------------------------------

SOZ1_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_55A82(pc,d0.w)
; ---------------------------------------------------------------------------

loc_55A82:
		bra.w	loc_55A9A
; ---------------------------------------------------------------------------
		bra.w	loc_55B04
; ---------------------------------------------------------------------------
		bra.w	loc_55B70
; ---------------------------------------------------------------------------
		bra.w	loc_55BCE
; ---------------------------------------------------------------------------
		bra.w	loc_55C26
; ---------------------------------------------------------------------------
		bra.w	loc_55C84
; ---------------------------------------------------------------------------

loc_55A9A:
		tst.w	(ScrEvents_2).w
		beq.s	loc_55ACE
		clr.w	(ScrEvents_2).w
		move.w	#-8,(__u_EE9C).w
		st	(ScrShake_Value).w
	;	jsr	sub_55DB6(pc)
		jsr	Reset_TileOffsetPositionEff(pc)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_55B08
; ---------------------------------------------------------------------------

loc_55ACE:
		move.w	#$B20,d0
		cmpi.w	#$4000,Player_2+x_pos.w		; NAT: Fuck
		bhs.s	.tiles
		cmpi.w	#$4000,(Player_1+x_pos).w
		blo.s	loc_55ADE
.tiles		move.w	#$960,d0

loc_55ADE:
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		jsr	sub_55E96(pc)
		jsr	sub_55D56(pc)
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		jmp	loc_55DF2(pc)
; ---------------------------------------------------------------------------

loc_55B04:
	;	jsr	sub_55DB6(pc)

loc_55B08:
		move.w	(Camera_X_pos_BG_copy).w,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	Draw_PlaneVertBottomUp
		bpl.w	loc_55B74		; NAT: Change lable
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SOZ1_16x16_Custom_Kos).l,a1
		lea	(Block_table+$EA0).w,a2
		jsr	Queue_Kos.w
		lea	(ArtKosM_SOZ1_Custom).l,a1
		move.w	#$62A0,d2
		jsr	Queue_Kos_Module.w
		movem.l	(sp)+,d7-a0/a2-a3
		jsr	Create_New_Sprite.w
		bne.s	loc_55B6A
		move.l	#loc_55F48,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_55B6A
		move.l	#loc_55F98,(a1)
	;	jsr	(CreateNewSprite4).l
	;	bne.s	loc_55B6A
	;	move.l	#loc_55FDA,(a1)

loc_55B6A:

		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_55B74		; NAT: add lable
; ---------------------------------------------------------------------------

loc_55B70:

		jsr	(DrawBGAsYouMove).l

loc_55B74:
		jsr	sub_55EBE(pc)
		jmp	sub_55E4C(pc)
; ---------------------------------------------------------------------------

loc_55BB4:

		move.w	#$F,(Palette_fade_info).w
		move.w	#$15,(ScrEvents_4).w
		move.w	#$10,(ScrEvents_5).w
		st	(Palette_fade_timer).w
		addq.w	#4,(TrigEvents_Routine).w

loc_55BCE:
		tst.w	(ScrEvents_5).w
		beq.s	loc_55BE0
		subq.w	#1,(ScrEvents_5).w
		bne.s	loc_55BFE
		st	(ScrEvents_3).w
		bra.s	loc_55BFE
; ---------------------------------------------------------------------------

loc_55BE0:
		tst.w	(ScrEvents_3).w
		bne.s	loc_55BFE
		btst	#0,(Level_frame_counter+1).w
		beq.s	loc_55BFE
		move.l	a0,-(sp)
		jsr	(Pal_ToBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(ScrEvents_4).w
		bmi.s	loc_55C10

loc_55BFE:

		jsr	sub_55D94(pc)
		jsr	(DrawBGAsYouMove).l
		jsr	sub_55EBE(pc)
		jmp	sub_55E4C(pc)
; ---------------------------------------------------------------------------


loc_55C10:
		move.w	#$401F,(Palette_fade_info).w
		move.w	#$15,(ScrEvents_4).w
		move.w	#8,(ScrEvents_5).w
		addq.w	#4,(TrigEvents_Routine).w

loc_55C26:
		tst.w	(ScrEvents_5).w
		beq.s	loc_55C32
		subq.w	#1,(ScrEvents_5).w
		bra.s	loc_55C4A
; ---------------------------------------------------------------------------

loc_55C32:
		btst	#0,(Level_frame_counter+1).w
		beq.s	loc_55C4A
		move.l	a0,-(sp)
		jsr	(Pal_ToBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(ScrEvents_4).w
		bmi.s	loc_55C4E

loc_55C4A:

		jmp	sub_55E4C(pc)
; ---------------------------------------------------------------------------

loc_55C4E:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SOZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$EA0).w,a2
		jsr	Queue_Kos.w
		lea	(ArtKosM_SOZ2_Secondary).l,a1
		move.w	#$62A0,d2
		jsr	Queue_Kos_Module.w
		moveq	#$2C,d0
		jsr	Load_PLC.w
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(TrigEvents_Routine).w
		rts
; ---------------------------------------------------------------------------

loc_55C84:
		tst.b	(Kos_modules_left).w
		bne.w	locret_55D54
		move.w	#$801,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(NoReset_RespawnTbl).w
		jsr	Clear_Switches.w
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		moveq	#3,d0
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_55CC6
		moveq	#5,d0

loc_55CC6:
		jsr	LoadPalette.w
		moveq	#$1B,d0
		jsr	LoadPalette.w
		moveq	#$1B,d0
		jsr	LoadPalette_Immediate.w
		movem.l	(sp)+,d7-a0/a2-a3
		jsr	sub_55EFC(pc)
		lea	(Normal_palette_line_3).w,a1
		moveq	#$F,d0

loc_55CEA:
		clr.l	(a1)+
		dbf	d0,loc_55CEA
		move.w	(Player_1+x_pos).w,d2
		sub.w	(Player_2+x_pos).w,d2
		move.w	(Player_1+y_pos).w,d3
		sub.w	(Player_2+y_pos).w,d3
		move.w	#$140,d0
		move.w	#$3AC,d1
		move.w	d0,(Player_1+x_pos).w
		move.w	d1,(Player_1+y_pos).w
		sub.w	d2,d0
		sub.w	d3,d1
		move.w	d0,(Player_2+x_pos).w
		move.w	d1,(Player_2+y_pos).w
		move.w	#$A0,d0
		move.w	#$34C,d1
		move.w	d0,(Camera_X_pos).w
		move.w	d1,(Camera_Y_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d1,(Camera_Y_pos_copy).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		move.w	d1,(Camera_min_Y_pos).w
		move.w	d1,(Camera_max_Y_pos).w
		move.w	d1,(Camera_target_max_Y_pos).w
		clr.l	(ScrEvents_3).w
		clr.w	(ScrEvents_2).w
		clr.w	(TrigEvents_Routine).w

locret_55D54:
		rts

; =============== S U B R O U T I N E =======================================


sub_55D56:

		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#4,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w

	; calculate the background x-position for BG
		move.w	(Camera_X_pos_copy).w,d0	; get camera FG x-pos
		swap	d0				; swap to high word
		clr.w	d0				; clear extra word
		asr.l	#4,d0				; divide by 16
		move.l	d0,d1				; copy to d1
		asr.l	#1,d1				; divide by 2 (total 32/$20)
		swap	d0				; get the shifted x-pos back to d0
		move.w	d0,(Camera_X_pos_BG_copy).w	; save as BG x-pos copy
		swap	d0				; then unswap the x-pos lol

	; we calculate x-positions and offsets
		swap	d1				; swap halved copy
		move.w	d1,(ScrEvents_A).w		; save to some RAM address
		swap	d1				; ...and swap again....
		asr.l	#1,d1				; halve it (total 64/$40)

	; fill $A800-$A81C
		lea	(Block_table+$1800).w,a1		; this is some data in the chunk table..!
		moveq	#6,d2				; write 7 values

loc_55D86:
		swap	d0				; ...yay swapping!...
		move.w	d0,(a1)+			; write data to this RAM address
		swap	d0				; ...yay swapping!...
		add.l	d1,d0				; add a quarter to the position
		dbf	d2,loc_55D86			; loop!
		rts
; End of function sub_55D56


; =============== S U B R O U T I N E =======================================


sub_55D94:

		tst.w	(ScrShake_Value).w
		bpl.s	sub_55DB6
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		beq.s	sub_55DB6
		addq.w	#1,(__u_EE9C).w
		cmpi.w	#$280,(__u_EE9C).w
		blt.s	sub_55DB6
		move.w	#8,(ScrShake_Value).w
; End of function sub_55D94


; =============== S U B R O U T I N E =======================================


sub_55DB6:
		tst.w	(ScrShake_Value).w
		bpl.s	loc_55DD0
		move.w	(Level_frame_counter).w,d0
		subq.w	#1,d0
		andi.w	#$F,d0
		bne.s	loc_55DD0
		moveq	#$6F,d0
		jsr	Play_Sound_2.w

loc_55DD0:

		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$900,d0
		add.w	(__u_EE9C).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$3CD0,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	d0,(ScrEvents_A).w
		rts
; End of function sub_55DB6

; ---------------------------------------------------------------------------

loc_55DF2:
		lea	(Block_table+$1810).w,a1
		lea	word_5077E(pc),a6
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	#$DF,d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2
		andi.w	#$3E,d2
		adda.w	d2,a6
		move.w	(Camera_X_pos_copy).w,d6
		neg.w	d6
		jsr	MakeFGDeformArray(pc)
		lea	(H_scroll_buffer).w,a1
		lea	(Block_table+$1810).w,a2
		lea	word_560DC(pc),a4
		lea	(Block_table+$1800).w,a5
		lea	word_5077E(pc),a6
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	#$DF,d1
		move.w	(Level_frame_counter).w,d2
		asr.w	#1,d2
		add.w	d0,d2
		add.w	d0,d2
		andi.w	#$3E,d2
		adda.w	d2,a6
		jmp	ApplyFGandBGDeformation.l

; =============== S U B R O U T I N E =======================================

MakeFGDeformArray:
		move.w	d1,d0
		lsr.w	#1,d0
		bcc.s	loc_4F0C2

loc_4F0BC:
		move.w	(a6)+,d5
		add.w	d6,d5
		move.w	d5,(a1)+

loc_4F0C2:
		move.w	(a6)+,d5
		add.w	d6,d5
		move.w	d5,(a1)+
		dbf	d0,loc_4F0BC
		rts

; =============== S U B R O U T I N E =======================================

sub_55E4C:
		lea	(H_scroll_buffer).w,a1
		lea	word_5077E(pc),a6
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Level_frame_counter).w,d1
		asr.w	#1,d1
		add.w	d0,d1
		add.w	d0,d1
		andi.w	#$3E,d1
		adda.w	d1,a6
		move.w	(Camera_X_pos_copy).w,d0
		neg.w	d0
		move.w	(Camera_X_pos_BG_copy).w,d1
		neg.w	d1
		move.w	#$6F,d2

loc_55E78:
		move.w	(a6)+,d3
		move.w	d3,d4
		add.w	d0,d3
		add.w	d1,d4
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	(a6)+,d3
		move.w	d3,d4
		add.w	d0,d3
		add.w	d1,d4
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		dbf	d2,loc_55E78
		rts
; End of function sub_55E4C


; =============== S U B R O U T I N E =======================================


sub_55E96:
		cmpi.w	#$4200,Camera_X_pos.w		; NAT: Check x-pos
		shs	MonContPos.w			; hide HUD if close enough

		move.w	(Camera_max_Y_pos).w,d0
		cmpi.w	#$960,d0
		bne.s	locret_55EBC
		cmp.w	(Camera_Y_pos).w,d0
		bhi.s	locret_55EBC
		move.w	d0,(Camera_min_Y_pos).w
		cmpi.w	#$4310,(Camera_X_pos).w
		blo.s	locret_55EBC
		move.w	#$4200,(Camera_min_X_pos).w
		st	(ScrEvents_2).w

locret_55EBC:
		rts
; End of function sub_55E96


; =============== S U B R O U T I N E =======================================


sub_55EBE:

		move.w	(ScrEvents_Routine2).w,d0
		beq.s	locret_55EFA
		clr.w	(ScrEvents_Routine2).w
		movea.w	$18(a3),a1
		move.b	d0,$D(a1)
		cmpi.w	#$540,(Camera_X_pos_BG_copy).w
		blo.s	locret_55EFA
		move.w	#$6A0,d1
		move.w	#$320,d0
		moveq	#5,d6
		moveq	#5,d2

loc_55EE4:
		movem.w	d0-d2/d6,-(sp)
		jsr	(Setup_TileRowDraw).l
		movem.w	(sp)+,d0-d2/d6
		addi.w	#$10,d0
		dbf	d2,loc_55EE4

locret_55EFA:

		rts
; End of function sub_55EBE


; =============== S U B R O U T I N E =======================================


sub_55EFC:
		lea	(Normal_palette_line_3+$2).w,a1
		lea	(Target_palette_line_3+$2).w,a5
		lea	word_560EA(pc),a6
		moveq	#$A,d0

loc_55F0A:
		move.w	(a6),(a1)+
		move.w	(a6)+,(a5)+
		dbf	d0,loc_55F0A
		lea	(Normal_palette_line_4+$2).w,a1
		lea	(Target_palette_line_4+$2).w,a5
		lea	word_56100(pc),a6
		moveq	#$E,d0

loc_55F20:
		move.w	(a6),(a1)+
		move.w	(a6)+,(a5)+
		dbf	d0,loc_55F20
		move.b	#5,(__u_F7C3).w
		move.w	#$707,(PalCyc_Counters+$2).w
		move.b	#0,(PalCyc_Counters2).w
		move.w	#4,(PalCyc_Counters2+$6).w
		move.w	#$D0,(PalCyc_Counters2+$2).w
		rts
; End of function sub_55EFC

; ---------------------------------------------------------------------------

loc_55F48:
		move.l	#Obj_SOZ_Miniboss,(a0)
; ---------------------------------------------------------------------------

locret_55F96:

		rts
; ---------------------------------------------------------------------------

loc_55F98:
		move.l	#loc_55FBE,(a0)
		move.b	#4,4(a0)
		move.b	#$24,7(a0)
		move.w	#prio(4),8(a0)
		move.l	#Map_SOZ1EndDoor,$C(a0)
		move.w	#$A00,$14(a0)

loc_55FBE:
		tst.b	(End_Of_Level_Flag).w		; NAT: Nope! I lied. It's drum'n'bass, whatcha gonna do?
		beq.s	loc_55FCA
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_55FCA:
		move.w	(Camera_X_pos).w,$10(a0)
		st	(ScrEvents_10).w
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

loc_55FDA:
		move.l	#loc_56012,(a0)
		move.b	#4,4(a0)
		move.b	#$24,7(a0)
		move.w	#prio(7),8(a0)
		move.w	#-$3FD7,$A(a0)
		move.l	#Map_SOZ1EndDoor,$C(a0)
		move.w	#$439C,$18(a0)
		move.w	#$9D4,$1A(a0)
		move.b	#1,$22(a0)

loc_56012:

		bclr	#7,4(a0)
		tst.w	(ScrEvents_3).w
		bne.s	loc_56020
		rts
; ---------------------------------------------------------------------------

loc_56020:
		moveq	#-$71,d0
		jsr	Play_Sound_2.w
		move.w	#$F6,(ScrEvents_Routine2).w
		move.l	#loc_56034,(a0)

loc_56034:
		moveq	#1,d0
		bsr.s	sub_560A2
		cmpi.w	#$58,$2E(a0)
		blo.s	loc_56050
		move.w	#$58,$2E(a0)
		clr.w	(ScrEvents_3).w
		move.l	#loc_56056,(a0)

loc_56050:
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

loc_56056:
		tst.b	(Current_act).w
		beq.s	loc_56062
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_56062:
		bclr	#7,4(a0)
		tst.w	(ScrEvents_3).w
		bne.s	loc_56070
		rts
; ---------------------------------------------------------------------------

loc_56070:
		moveq	#-$71,d0
		jsr	Play_Sound_2.w
		move.l	#loc_5607E,(a0)

loc_5607E:
		moveq	#-1,d0
		bsr.s	sub_560A2
		tst.w	$2E(a0)
		bpl.s	loc_5609C
		clr.w	$2E(a0)
		move.w	#$FD,(ScrEvents_Routine2).w
		clr.w	(ScrEvents_3).w
		move.l	#loc_56012,(a0)

loc_5609C:
		jmp	Draw_Sprite.w

; =============== S U B R O U T I N E =======================================


sub_560A2:

		move.w	(Level_frame_counter).w,d1
		andi.w	#3,d1
		bne.s	loc_560AE
		add.w	d0,d0

loc_560AE:
		add.w	d0,$2E(a0)
		move.w	$1A(a0),d0
		add.w	$2E(a0),d0
		move.w	d0,$14(a0)
		lea	ScreenShakeArray2.w,a1
		move.w	$2E(a0),d0
		andi.w	#$3F,d0
		move.b	(a1,d0.w),d0
		andi.w	#1,d0
		add.w	$18(a0),d0
		move.w	d0,$10(a0)
		rts
; End of function sub_560A2

; ---------------------------------------------------------------------------
word_560DC:	dc.w $110
		dc.w 8
		dc.w 8
		dc.w 8
		dc.w 8
		dc.w 8
		dc.w $7FFF
word_560EA:	dc.w   $C46,  $824,  $804,  $402,  $202,  $200,	    0,	$422,  $402,  $200,   $40

word_56100:	dc.w   $6AE,  $664,  $422,  $402,  $200,     0,	    0,	$EEE,  $466,  $224,	0,   $46,  $6EE,  $48C,	 $26A

Map_SOZ1EndDoor:	include "Levels/SOZ/Misc Object Data/Map - Act 1 End Door.asm"

; ---------------------------------------------------------------------------

SOZ2_ScreenInit:
		move.w	#$7FF,(Screen_Y_wrap_value).w
		move.w	#$7F0,(Camera_Y_pos_mask).w
		move.w	#$3C,(Layout_row_index_mask).w
		move.w	#8,(ScrEvents_Routine).w
		cmpi.w	#$4E80,Player_2+x_pos.w	; NAT: Do i need to even fix this?
		bhs.s	.tulpan
		cmpi.w	#$4E80,(Player_1+x_pos).w
		blo.s	loc_561B0
.tulpan		jsr	sub_5622C(pc)

loc_561B0:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

SOZ2_ScreenEvent:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(ScrEvents_Routine).w,d0
		jmp	loc_561CC(pc,d0.w)
; ---------------------------------------------------------------------------

loc_561CC:
		bra.w	loc_561D8
; ---------------------------------------------------------------------------
		bra.w	loc_56206
; ---------------------------------------------------------------------------
		bra.w	loc_5621A
; ---------------------------------------------------------------------------

loc_561D8:
		move.w	#$7FF,(Screen_Y_wrap_value).w
		move.w	#$7F0,(Camera_Y_pos_mask).w
		move.w	#$3C,(Layout_row_index_mask).w
		jsr	(Reset_TileOffsetPositionActual).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(ScrEvents_Routine).w

loc_56206:
		move.w	(Camera_X_pos_copy).w,d1
		move.w	(Camera_Y_pos_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_5622A		; NAT: Change lable
		addq.w	#4,(ScrEvents_Routine).w
		bra.s	loc_5622A

loc_5621A:

		tst.w	(ScrEvents_1).w
		beq.s	loc_56226
		clr.w	(ScrEvents_1).w
		bsr.s	sub_5622C

loc_56226:
		jmp	(DrawTilesAsYouMove).l
; =============== S U B R O U T I N E =======================================


sub_5622C:

		movea.w	$1C(a3),a1
		lea	$AB(a1),a5
		lea	$95(a1),a1
		move.b	(a5)+,(a1)+
		move.b	(a5)+,(a1)+
		move.b	(a5)+,(a1)+
		move.b	(a5)+,(a1)+
		movea.w	$28(a3),a1
		lea	$AB(a1),a5
		lea	$8C(a1),a1
		move.w	-8(a3),d0
		subi.w	#9,d0
		moveq	#3,d1

loc_56256:
		moveq	#8,d2

loc_56258:
		move.b	(a5)+,(a1)+
		dbf	d2,loc_56258
		adda.w	d0,a1
		adda.w	d0,a5
		dbf	d1,loc_56256

loc_5622A:
		rts
; End of function sub_5622C

; ---------------------------------------------------------------------------

SOZ2_BackgroundInit:
		jsr	sub_5697E(pc)
		moveq	#$10,d0
		cmpi.w	#$2980,Player_2+x_pos.w	; NAT: Do i need to even fix this?
		bhs.s	.corpse
		cmpi.w	#$2980,(Player_1+x_pos).w
		blo.s	loc_56278
.corpse		moveq	#$20,d0

loc_56278:
		move.w	d0,(TrigEvents_Routine).w
		jsr	sub_566D2(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		moveq	#0,d1
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

SOZ2_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_5629C(pc,d0.w)
; ---------------------------------------------------------------------------

loc_5629C:
		bra.w	loc_562D0	; $00
; ---------------------------------------------------------------------------
		bra.w	loc_56300	; $04
; ---------------------------------------------------------------------------
		bra.w	loc_56324	; $08
; ---------------------------------------------------------------------------
		bra.w	loc_56366	; $0C
; ---------------------------------------------------------------------------
		bra.w	loc_563A6	; $10
; ---------------------------------------------------------------------------
		bra.w	loc_5641C	; $14	Rising sand #1
; ---------------------------------------------------------------------------
		bra.w	loc_5645E	; $18	Rising sand #2
; ---------------------------------------------------------------------------
		bra.w	loc_564B8	; $1C
; ---------------------------------------------------------------------------
		bra.w	loc_564D4	; $20
; ---------------------------------------------------------------------------
		bra.w	loc_565C6	; $24
; ---------------------------------------------------------------------------
		bra.w	loc_565DE	; $28
; ---------------------------------------------------------------------------
		bra.w	loc_56676	; $2C
; ---------------------------------------------------------------------------
		bra.w	loc_566A4	; $30
; ---------------------------------------------------------------------------

loc_562D0:
		cmpi.w	#8,(ScrEvents_Routine).w
		blo.s	locret_562FE
		jsr	sub_5697E(pc)
		jsr	sub_566D2(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_56304
; ---------------------------------------------------------------------------

locret_562FE:
		rts
; ---------------------------------------------------------------------------

loc_56300:
		jsr	sub_566D2(pc)

loc_56304:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.w	loc_563D0			; NAT: Change lable
		move.w	#$F,(Palette_fade_info).w
		move.w	#$15,(ScrEvents_Routine2).w
		addq.w	#4,(TrigEvents_Routine).w

loc_56324:
		btst	#0,(Level_frame_counter+1).w
		beq.s	loc_563A6
		cmpi.w	#5,(ScrEvents_Routine2).w
		bne.s	loc_56346
		jsr	Create_New_Sprite.w
		bne.s	loc_56346
		move.l	#Obj_TitleCard,(a1)
		st	$3E(a1)

loc_56346:

		move.l	a0,-(sp)
		jsr	(Pal_FromBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(ScrEvents_Routine2).w
		bpl.s	loc_563A6
		move.w	#$401F,(Palette_fade_info).w
		move.w	#$15,(ScrEvents_Routine2).w
		addq.w	#4,(TrigEvents_Routine).w

loc_56366:
		btst	#0,(Level_frame_counter+1).w
		beq.s	loc_563A6
		move.l	a0,-(sp)
		jsr	(Pal_FromBlack).l
		movea.l	(sp)+,a0
		subq.w	#1,(ScrEvents_Routine2).w
		bpl.s	loc_563A6
		move.l	#$6000,d0
		move.l	d0,(Camera_min_X_pos).w
		move.l	d0,(Camera_target_min_X_pos).w
		move.l	#-Sprite_table_buffer,d0
		move.l	d0,(Camera_min_Y_pos).w
		move.l	d0,(Camera_target_min_Y_pos).w
		clr.w	(Palette_fade_timer).w
		clr.w	(Ctrl_1_locked).w
		addq.w	#4,(TrigEvents_Routine).w

loc_563A6:

		jsr	sub_5699A(pc)
		beq.s	loc_563B6
		move.w	#$18,(TrigEvents_Routine).w
		bra.w	loc_56484
; ---------------------------------------------------------------------------

loc_563B6:
		tst.w	(ScrEvents_2).w
		bne.s	loc_563D8
		jsr	sub_566D2(pc)

loc_563C0:
		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l

loc_563D0:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

loc_563D8:
		clr.w	(ScrEvents_2).w
		addq.w	#4,(TrigEvents_Routine).w
		moveq	#0,d0
		move.w	#$80,d0

		cmpi.w	#$400,Player_2+y_pos.w		; NAT: GAy fuck
		bhs.s	.tulips
		cmpi.w	#$400,(Player_1+y_pos).w
		blo.s	loc_563F6
.tulips		addq.w	#4,(TrigEvents_Routine).w
		move.w	#$3E0,d0

loc_563F6:
		swap	d0
		move.l	d0,(__u_EE9C).w
		jsr	sub_566E8(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		subi.w	#$10,(Camera_Y_pos_BG_rounded).w
		move.w	#$10,(Special_Events_Routine).w
		cmpi.w	#$14,(TrigEvents_Routine).w
		beq.s	loc_56440
		bra.s	loc_56474
; ---------------------------------------------------------------------------

loc_5641C:
		jsr	sub_5699A(pc)
		beq.s	loc_5642A
		move.w	#$18,(TrigEvents_Routine).w
		bra.s	loc_56484
; ---------------------------------------------------------------------------

loc_5642A:
		tst.w	(ScrEvents_2).w
		bne.s	loc_56450
		cmpi.w	#$400,(__u_EE9C).w
		blo.s	loc_5643C
		clr.w	(Special_Events_Routine).w

loc_5643C:
		jsr	sub_566E8(pc)

loc_56440:
		jsr	(DrawBGAsYouMove).l
		jsr	(PlainDeformation).l
		jmp	Go_CheckPlayerRelease(pc)
; ---------------------------------------------------------------------------

loc_56450:
		clr.w	(ScrEvents_2).w
		move.w	#$10,(Special_Events_Routine).w
		addq.w	#4,(TrigEvents_Routine).w

loc_5645E:
		jsr	sub_5699A(pc)
		bne.s	loc_56484
		cmpi.w	#$A00,(__u_EE9C).w
		blo.s	loc_56470
		clr.w	(Special_Events_Routine).w

loc_56470:
		jsr	sub_566E8(pc)

loc_56474:
		jsr	(DrawBGAsYouMove).l
		jsr	(PlainDeformation).l
		jmp	Go_CheckPlayerRelease(pc)
; ---------------------------------------------------------------------------

loc_56484:

		move.w	(Camera_X_pos_BG_copy).w,(ScrEvents_3).w
		move.w	(Camera_Y_pos_BG_copy).w,(ScrEvents_4).w
		jsr	sub_566D2(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$1F0,(DrawDelayed_Position).w
		move.w	#$1F,(DrawDelayed_RowCount).w
		clr.w	(ScrEvents_2).w
		clr.w	(Special_Events_Routine).w
		clr.b	(BG_Collision).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_564BC
; ---------------------------------------------------------------------------

loc_564B8:
		jsr	sub_566D2(pc)

loc_564BC:
		move.w	(Camera_Y_pos_BG_copy).w,d1
		moveq	#0,d2
		jsr	(Draw_PlaneHorzRightToLeft).l
		bpl.s	loc_564E8
		clr.w	(ScrEvents_3).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_564E8
; ---------------------------------------------------------------------------

loc_564D4:
		btst	#5,OptionsBits.w		; NAT: If bosses are off, don't load the BG maps
		beq.s	loc_564E4
		cmpi.w	#$5000,player_2+x_pos.w		; NAT: oops
		bhs.s	.poopals
		cmpi.w	#$5000,(Player_1+x_pos).w
		blo.s	loc_564E4
.poopals	cmpi.w	#$500,(Camera_Y_pos).w
		bhs.s	loc_56510

loc_564E4:
		jsr	sub_566D2(pc)

loc_564E8:

		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l
		move.w	(ScrEvents_3).w,d0
		beq.s	loc_5650A
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(ScrEvents_4).w,(Camera_Y_pos_BG_copy).w

loc_5650A:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

loc_56510:
		move.w	#$5250,(ScrEvents_8).w
		move.w	#$6D8,(ScrEvents_9).w
		movea.w	(a3),a1
		move.w	-8(a3),d0
		subq.w	#4,d0
		moveq	#0,d1
		moveq	#$F,d2

loc_56528:
		moveq	#3,d3

loc_5652A:
		move.b	(a1),4(a1)
		move.b	d1,(a1)+
		dbf	d3,loc_5652A
		adda.w	d0,a1
		dbf	d2,loc_56528
		lea	(Block_table+$1800).w,a1
		moveq	#$7F,d2

loc_56540:
		move.l	d1,(a1)+
		dbf	d2,loc_56540
		jsr	sub_56706(pc)
		lea	(Block_table+$1800).w,a1
		moveq	#$C,d0

loc_56550:
		move.w	(a1)+,(a1)
		andi.w	#-$10,(a1)+
		dbf	d0,loc_56550
		move.w	#$500,(Camera_min_Y_pos).w
		move.w	#$680,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	#$5140,(Camera_max_X_pos).w
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SOZ2_16x16_Custom_Kos).l,a1
		lea	(Block_table+$EA0).w,a2
		jsr	Queue_Kos.w
		lea	(ArtKosM_SOZ2_Custom).l,a1
		move.w	#$62A0,d2
		jsr	Queue_Kos_Module.w
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$7FFF,(PalCyc_Counters+$2).w
		move.b	#0,(__u_F7C3).w
		move.w	(PalCyc_Counters2+$6).w,d0
		neg.b	d0
		move.b	d0,(PalCyc_Counters2).w
		move.w	#0,(PalCyc_Counters2+$8).w
		move.b	#$7F,(Anim_Counters).w
		jsr	sub_56A12(pc)
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_565F4
; ---------------------------------------------------------------------------

loc_565C6:
		move.w	(Camera_Y_pos_copy).w,d0
		cmp.w	(Camera_min_Y_pos).w,d0
		beq.s	loc_565D4
		move.w	d0,(Camera_min_Y_pos).w

loc_565D4:
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	loc_565DE
		addq.w	#4,(TrigEvents_Routine).w

loc_565DE:

		move.w	#$7FFF,(PalCyc_Counters+$2).w
		move.b	#$7F,(Anim_Counters).w
		tst.w	(ScrEvents_2).w
		bmi.s	loc_5661A
		jsr	sub_56706(pc)

loc_565F4:
		lea	SOZ2_BGDrawArray(pc),a4
		lea	(Block_table+$1800).w,a5
		moveq	#$20,d6
		moveq	#$D,d5
		jsr	(Draw_BG).l
		lea	SOZ2_BGDrawArray(pc),a4
		lea	(Block_table+$1900).w,a5
		jsr	(ApplyDeformation).l
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

loc_5661A:
		move.w	(Camera_X_pos_BG_copy).w,d0
		subi.w	#$100,d0
		move.w	d0,(ScrEvents_3).w
		jsr	sub_56964(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SOZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$EA0).w,a2
		jsr	Queue_Kos.w
		lea	(ArtKosM_SOZ2_Secondary).l,a1
		move.w	#$62A0,d2
		jsr	Queue_Kos_Module.w
		moveq	#$1B,d0
		jsr	LoadPalette_Immediate.w
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(TrigEvents_Routine).w

loc_56676:
		tst.b	(Kos_modules_left).w
		bne.s	loc_566BC
		jsr	sub_56964(pc)
		move.w	#$200,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_566BC			; NAT: Change lable
		clr.w	(ScrEvents_3).w
	;	move.w	#$52C0,(Camera_max_X_pos).w
		clr.b	(Anim_Counters).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_566BC
; ---------------------------------------------------------------------------

loc_566A4:
		jsr	sub_56964(pc)

loc_566A8:

		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$200,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l

loc_566BC:
		move.w	(ScrEvents_3).w,d0
		beq.s	loc_566C6
		move.w	d0,(Camera_X_pos_BG_copy).w

loc_566C6:
		jsr	(PlainDeformation).l
		jmp	ShakeScreen_Setup.w

; =============== S U B R O U T I N E =======================================


sub_566D2:

		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function sub_566D2


; =============== S U B R O U T I N E =======================================


sub_566E8:

		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$2E0,d0
		add.w	(__u_EE9C).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$1930,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function sub_566E8


; =============== S U B R O U T I N E =======================================


sub_56706:
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$250,d0
		move.w	#$6D8,d1
		sub.w	(ScrEvents_9).w,d1
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$4010,d0
		move.w	#$5250,d1
		sub.w	(ScrEvents_8).w,d1
		add.w	d1,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(ScrEvents_6).w,d0
		jmp	loc_56744(pc,d0.w)
; ---------------------------------------------------------------------------

loc_56744:
		bra.w	loc_5675C
; ---------------------------------------------------------------------------
		bra.w	loc_5678A
; ---------------------------------------------------------------------------
		bra.w	loc_567B0
; ---------------------------------------------------------------------------
		bra.w	loc_5680A
; ---------------------------------------------------------------------------
		bra.w	loc_5687C
; ---------------------------------------------------------------------------
		bra.w	loc_56904
; ---------------------------------------------------------------------------

loc_5675C:
		jsr	loc_568DE(pc)
		tst.w	(ScrEvents_7).w
		beq.w	loc_56936
		lea	(Block_table+$1934).w,a1
		moveq	#-1,d0
		moveq	#8,d1

loc_56770:
		move.w	d0,-(a1)
		subq.w	#1,d0
		dbf	d1,loc_56770
		moveq	#$6E,d0
		jsr	Play_Sound_2.w
		move.w	#3,(ScrEvents_5).w
		addq.w	#4,(ScrEvents_6).w

loc_5678A:
		jsr	loc_568DE(pc)
		subq.w	#1,(ScrEvents_5).w
		bpl.w	loc_56936
		lea	(Block_table+$1934).w,a1
		moveq	#-1,d0
		moveq	#8,d1

loc_5679E:
		move.w	d0,-(a1)
		subq.w	#2,d0
		dbf	d1,loc_5679E
		move.w	#8,(ScrEvents_5).w
		addq.w	#4,(ScrEvents_6).w

loc_567B0:
		jsr	loc_568DE(pc)
		subq.w	#1,(ScrEvents_5).w
		bpl.w	loc_56936
		lea	(Block_table+$1984).w,a1
		lea	$3E(a1),a5
		lea	word_56AE2(pc),a6
		move.w	(ScrEvents_7).w,d0
		sub.w	(Camera_Y_pos_copy).w,d0
		add.w	(Camera_Y_pos_BG_copy).w,d0
		subi.w	#$440,d0
		bcc.s	loc_567DC
		moveq	#0,d0

loc_567DC:
		lsr.w	#3,d0
		andi.w	#-2,d0
		cmpi.w	#$10,d0
		bls.s	loc_567EA
		moveq	#$10,d0

loc_567EA:
		suba.w	d0,a6
		moveq	#8,d1

loc_567EE:
		move.l	#$80000,(a1)+
		move.w	(a6)+,(a5)+
		dbf	d1,loc_567EE
		clr.w	(ScrEvents_Routine2).w
		moveq	#$59,d0
		jsr	Play_Sound_2.w
		addq.w	#4,(ScrEvents_6).w

loc_5680A:
		jsr	loc_568DE(pc)
		lea	(Block_table+$1944).w,a1
		lea	$40(a1),a5
		lea	$3E(a5),a6
		moveq	#9,d0
		moveq	#8,d1

loc_5681E:
		tst.b	(a6)
		beq.s	loc_5682C
		bpl.s	loc_56828
		subq.w	#1,d0
		bra.s	loc_5683A
; ---------------------------------------------------------------------------

loc_56828:
		subq.b	#1,(a6)
		bra.s	loc_5683A
; ---------------------------------------------------------------------------

loc_5682C:
		move.l	(a5),d2
		sub.l	d2,(a1)
		subi.l	#$2800,(a5)
		bpl.s	loc_5683A
		st	(a6)

loc_5683A:

		addq.w	#4,a1
		addq.w	#4,a5
		addq.w	#2,a6
		dbf	d1,loc_5681E
		tst.w	d0
		beq.s	loc_56868
		cmpi.w	#9,d0
		beq.w	loc_56936
		tst.w	(ScrEvents_Routine2).w
		bne.w	loc_56936
		moveq	#-$6D,d0
		jsr	Play_Sound_2.w
		st	(ScrEvents_Routine2).w
		bra.w	loc_56936
; ---------------------------------------------------------------------------

loc_56868:
		lea	(Block_table+$1922).w,a1
		moveq	#8,d1

loc_5686E:
		clr.w	(a1)+
		dbf	d1,loc_5686E
		clr.w	(ScrEvents_5).w
		addq.w	#4,(ScrEvents_6).w

loc_5687C:
		jsr	loc_568DE(pc)
		tst.w	(ScrEvents_5).w
		beq.s	loc_5689A
		subq.w	#1,(ScrEvents_5).w
		bne.w	loc_56936
		clr.w	(ScrEvents_7).w
		clr.w	(ScrEvents_6).w
		bra.w	loc_56936
; ---------------------------------------------------------------------------

loc_5689A:
		lea	(Block_table+$1944).w,a1
		lea	$40(a1),a5
		lea	$3F(a5),a6
		moveq	#9,d0
		moveq	#8,d1

loc_568AA:
		tst.b	(a6)
		beq.s	loc_568B8
		bpl.s	loc_568B4
		subq.w	#1,d0
		bra.s	loc_568C8
; ---------------------------------------------------------------------------

loc_568B4:
		subq.b	#1,(a6)
		bra.s	loc_568C8
; ---------------------------------------------------------------------------

loc_568B8:
		move.l	(a5),d2
		subi.l	#$2800,(a5)
		sub.l	d2,(a1)
		bmi.s	loc_568C8
		clr.l	(a1)
		st	(a6)

loc_568C8:

		addq.w	#4,a1
		addq.w	#4,a5
		addq.w	#2,a6
		dbf	d1,loc_568AA
		tst.w	d0
		bne.s	loc_56936
		move.w	#$F,(ScrEvents_5).w
		bra.s	loc_56936
; ---------------------------------------------------------------------------

loc_568DE:

		tst.w	(ScrEvents_2).w
		bne.s	loc_568E6
		rts
; ---------------------------------------------------------------------------

loc_568E6:
		lea	(Block_table+$19C2).w,a1
		moveq	#0,d0
		moveq	#$B,d1

loc_568EE:
		move.w	d0,(a1)+
		addq.w	#5,d0
		dbf	d1,loc_568EE
		move.w	#$5140,(Camera_max_X_pos).w
		move.w	#$14,(ScrEvents_6).w
		addq.w	#4,sp

loc_56904:
		lea	(Block_table+$1944).w,a1
		lea	$7E(a1),a5
		moveq	#$C,d0
		moveq	#$B,d1

loc_56910:
		tst.w	(a5)
		beq.s	loc_56918
		subq.w	#1,(a5)
		bra.s	loc_56926
; ---------------------------------------------------------------------------

loc_56918:
		subq.w	#5,(a1)
		cmpi.w	#-$100,(a1)
		bgt.s	loc_56926
		move.w	#-$100,(a1)
		subq.w	#1,d0

loc_56926:

		addq.w	#4,a1
		addq.w	#2,a5
		dbf	d1,loc_56910
		tst.w	d0
		bne.s	loc_56936
		st	(ScrEvents_2).w

loc_56936:

		move.l	a0,-(sp)
		lea	(Block_table+$1800).w,a0
		lea	$100(a0),a1
		lea	$20(a1),a5
		lea	$20(a5),a6
		move.w	(Camera_X_pos_BG_copy).w,d0
		moveq	#$C,d1

loc_5694E:
		move.w	(a5)+,d2
		add.w	(a6),d2
		add.w	d0,d2
		move.w	d2,(a0)
		move.w	d2,(a1)+
		addq.w	#4,a0
		addq.w	#4,a6
		dbf	d1,loc_5694E
		movea.l	(sp)+,a0
		rts
; End of function sub_56706


; =============== S U B R O U T I N E =======================================


sub_56964:

		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		asr.w	#1,d0
		addi.w	#$200,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function sub_56964


; =============== S U B R O U T I N E =======================================


sub_5697E:

		movea.w	$38(a3),a5
		movea.w	$3C(a3),a6
		lea	$17(a5),a5
		lea	$17(a6),a6
		moveq	#9,d0

loc_56990:
		clr.b	(a5)+
		clr.b	(a6)+
		dbf	d0,loc_56990
		rts
; End of function sub_5697E


; =============== S U B R O U T I N E =======================================


sub_5699A:	; NAT: homosexual
		cmpi.w	#$2A00,Player_2+x_pos.w
		bhs.s	.tup
		cmpi.w	#$2A00,(Player_1+x_pos).w
		blo.s	loc_569B6

.tup		move.w	Camera_Y_Pos.w,d0
		add.w	#224/2,d0
		cmpi.w	#$140,d0
		blo.s	loc_569B6
		cmpi.w	#$180,d0
		bhi.s	loc_569B6
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

loc_569B6:

		moveq	#0,d0
		rts
; End of function sub_5699A

; ---------------------------------------------------------------------------

loc_569BA:
		st	(BG_Collision).w
		addi.l	#$A000,(__u_EE9C).w
		move.w	#$2E0,d0
		add.w	(__u_EE9C).w,d0
		neg.w	d0
		move.w	d0,(BG_Offset_Y).w
		move.w	#$1930,(BG_Offset_X).w
		rts
; ---------------------------------------------------------------------------

Go_CheckPlayerRelease:

		movem.l	d7-a0/a2-a3,-(sp)
		lea	(Player_1).w,a1
		btst	#3,$2A(a1)
		beq.s	loc_569F6
		movea.w	$42(a1),a0
		jsr	CheckPlayerReleaseFromObj.w

loc_569F6:
		lea	(Player_2).w,a1
		btst	#3,$2A(a1)
		beq.s	loc_56A0C
		movea.w	$42(a1),a0
		jsr	CheckPlayerReleaseFromObj.w

loc_56A0C:
		movem.l	(sp)+,d7-a0/a2-a3
		rts

; =============== S U B R O U T I N E =======================================


sub_56A12:
		jsr	Create_New_Sprite.w
		bne.s	locret_56A32
		move.l	#loc_56A34,d1
		moveq	#7,d2

loc_56A22:
		move.l	d1,(a1)
		move.w	d2,$2C(a1)
		jsr	(CreateNewSprite4).l
		dbne	d2,loc_56A22

locret_56A32:
		rts
; End of function sub_56A12

; ---------------------------------------------------------------------------

loc_56A34:
		move.b	#$40,7(a0)
		bset	#7,$2A(a0)
		move.w	$2C(a0),d0
		lsl.w	#4,d0
		addi.w	#$458,d0
		sub.w	(Camera_Y_pos_BG_copy).w,d0
		add.w	(Camera_Y_pos_copy).w,d0
		move.w	d0,$14(a0)
		move.w	$2C(a0),d0
		add.w	d0,d0
		lea	word_56AF4(pc),a1
		move.w	(a1,d0.w),d4
		add.w	d0,d0
		lea	(Block_table+$1808).w,a1
		sub.w	(a1,d0.w),d4
		add.w	(Camera_X_pos_copy).w,d4
		cmpi.w	#$10,(ScrEvents_6).w
		beq.s	loc_56A7E
		move.w	#$7FFF,d4

loc_56A7E:
		move.w	d4,$10(a0)
		moveq	#$4B,d1
		moveq	#8,d2
		moveq	#8,d3
		jsr	SolidObjectFull2.w
		move.w	#-$300,d0
		lea	(Player_1).w,a1
		btst	#$10,d6
		beq.s	loc_56AA4
		move.w	d0,$18(a1)
		move.w	d0,$1A(a1)

loc_56AA4:
		lea	(Player_2).w,a1
		btst	#$11,d6
		beq.s	locret_56AB6
		move.w	d0,$18(a1)
		move.w	d0,$1A(a1)

locret_56AB6:
		rts
; ---------------------------------------------------------------------------
SOZ2_BGDrawArray:
		dc.w $440
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $7FFF
		dc.w $1800
		dc.w $1502
		dc.w $1204
		dc.w $F06
		dc.w $C08
		dc.w $90A
		dc.w $60C
		dc.w $30E
word_56AE2:	dc.w $10
		dc.w $30E
		dc.w $60C
		dc.w $90A
		dc.w $C08
		dc.w $F06
		dc.w $1204
		dc.w $1502
		dc.w $1800
word_56AF4:	dc.w $1268
		dc.w $1260
		dc.w $1260
		dc.w $125C
		dc.w $1254
		dc.w $1248
		dc.w $1248
		dc.w $1248
; ---------------------------------------------------------------------------

LRZ1_ScreenInit:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

LRZ1_ScreenEvent:
		cmpi.w	#$2C00,Camera_X_pos.w		; NAT: Check x-pos
		bge.s	.nolol
		cmpi.w	#$2B20,Camera_X_pos.w		; NAT: Check x-pos
		shs	MonContPos.w			; hide HUD if close enough

.nolol		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(ScrEvents_8).w,d0
		beq.s	loc_56B5E
		bmi.s	loc_56B2C
		movea.w	$40(a3),a1
		move.b	#-$64,$A(a1)
		bra.s	loc_56B54
; ---------------------------------------------------------------------------

loc_56B2C:
		movea.w	$38(a3),a1
		lea	$1D(a1),a1
		move.b	#$44,(a1)+
		move.b	#0,(a1)+
		move.b	#$4A,(a1)
		movea.w	$3C(a3),a1
		lea	$1D(a1),a1
		move.b	#$3E,(a1)+
		move.b	#0,(a1)+
		move.b	#$4B,(a1)

loc_56B54:
		clr.w	(ScrEvents_8).w
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

loc_56B5E:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

LRZ1_BackgroundInit:
		move.w	(a3),d0
		move.w	#$1C,d1
		moveq	#$18,d2

loc_56B6C:
		move.w	d0,(a3,d1.w)
		addq.w	#4,d1
		dbf	d2,loc_56B6C
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_56B88
		movea.w	4(a3),a1
		move.b	#-$A,4(a1)

loc_56B88:
		jsr	sub_56D40(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		clr.l	(Block_table+$1800).w
		move.w	d2,(Block_table+$1806).w
		clr.l	(Block_table+$1808).w
		lea	LRZ1_BGDrawArray(pc),a4
		lea	(Block_table+$1800).w,a5
		jsr	(Refresh_PlaneTileDeform).l
		lea	LRZ1_BGDeformArray(pc),a4
		lea	(Block_table+$180C).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

LRZ1_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_56BC2(pc,d0.w)
; ---------------------------------------------------------------------------

loc_56BC2:
		bra.w	loc_56BD2
; ---------------------------------------------------------------------------
		bra.w	loc_56C6E
; ---------------------------------------------------------------------------
		bra.w	loc_56C88
; ---------------------------------------------------------------------------
		bra.w	loc_56CAA
; ---------------------------------------------------------------------------

loc_56BD2:
		tst.w	(ScrEvents_2).w
		beq.s	loc_56C28
		clr.w	(ScrEvents_2).w
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(LRZ2_128x128_Secondary_Kos).l,a1
		lea	(Chunk_table+$180).l,a2
		jsr	Queue_Kos.w
		lea	(LRZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$128).w,a2
		jsr	Queue_Kos.w
		lea	(ArtKosM_LRZ2_Secondary).l,a1
		move.w	#$1200,d2
		jsr	Queue_Kos_Module.w
		moveq	#$30,d0
		jsr	Load_PLC.w
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$C,(TrigEvents_Routine).w
		bra.w	loc_56D16
; ---------------------------------------------------------------------------

loc_56C28:
		jsr	sub_56DCA(pc)
		jsr	sub_56D40(pc)

loc_56C30:

		lea	LRZ1_BGDrawArray(pc),a4
		lea	(Block_table+$1800).w,a5
		moveq	#$20,d6
		moveq	#3,d5
		jsr	(Draw_BG).l

loc_56C40:
		move.l	(ScrEvents_3).w,d0
		beq.s	loc_56C5A
		move.w	d0,(Camera_Y_pos_BG_copy).w
		swap	d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		jsr	(PlainDeformation).l
		bra.s	loc_56C68
; ---------------------------------------------------------------------------

loc_56C5A:
		lea	LRZ1_BGDeformArray(pc),a4
		lea	(Block_table+$180C).w,a5
		jsr	(ApplyDeformation).l

loc_56C68:
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

loc_56C6E:
		jsr	sub_56DCA(pc)
		jsr	sub_56DAC(pc)

loc_56C76:
		jsr	(DrawBGAsYouMove).l
		jsr	(PlainDeformation).l
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

loc_56C88:
		jsr	sub_56D40(pc)

loc_56C8C:
		lea	LRZ1_BGDrawArray(pc),a4
		lea	(Block_table+$17FC).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	(Draw_PlaneVertBottomUpComplex).l
		bpl.s	loc_56C40		; NAT: Change lable
		clr.l	(ScrEvents_3).w
		clr.w	(TrigEvents_Routine).w
		bra.s	loc_56C40
; ---------------------------------------------------------------------------

loc_56CAA:
		tst.b	(Kos_modules_left).w
		bne.s	loc_56D16
		move.w	#$901,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w

loc_56CC6:
		clr.b	(NoReset_RespawnTbl).w
		jsr	Clear_Switches.w
		clr.b	(LRZ_Rock_Routine).w
		movem.l	d7-a0/a2-a3,-(sp)

loc_56CD8:
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$2C00,d0
		moveq	#0,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d0,(Player_2+x_pos).w
		jsr	(Offset_ObjectsDuringTransition).l
		sub.w	d0,(Camera_X_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		jsr	(Reset_TileOffsetPositionActual).l
		clr.w	(TrigEvents_Routine).w

loc_56D16:
		bsr.s	sub_56D40
		lea	LRZ1_BGDrawArray(pc),a4
		lea	(Block_table+$1800).w,a5
		moveq	#$20,d6
		moveq	#3,d5
		jsr	(Draw_BG).l
		lea	LRZ1_BGDeformArray(pc),a4
		lea	(Block_table+$180C).w,a5
		jsr	(ApplyDeformation).l
		jmp	ShakeScreen_Setup.w

; =============== S U B R O U T I N E =======================================

sub_56D40:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(ScrShake_Offset).w,d1
		sub.w	d1,d0
		asr.w	#3,d0
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#3,d0
		move.l	d0,d1
		move.l	d0,d2
		asr.l	#2,d0
		swap	d1
		move.w	d1,(Camera_X_pos_BG_copy).w
		move.w	d1,(Block_table+$1804).w
		swap	d1
		sub.l	d0,d1
		swap	d1
		move.w	d1,(ScrEvents_A).w
		swap	d1
		sub.l	d0,d1
		swap	d1
		move.w	d1,(ScrEvents_B).w
		lea	(Block_table+$181C).w,a1
		move.l	d2,d1
		moveq	#7,d3

loc_56D88:
		swap	d1
		move.w	d1,-(a1)
		swap	d1
		add.l	d0,d1
		dbf	d3,loc_56D88
		lea	(Block_table+$181C).w,a1
		add.l	d0,d2
		add.l	d0,d0
		moveq	#4,d3

loc_56D9E:
		swap	d2
		move.w	d2,(a1)+
		swap	d2
		add.l	d0,d2
		dbf	d3,loc_56D9E
		rts

; =============== S U B R O U T I N E =======================================


sub_56DAC:

		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$788,d0
		add.w	(__u_EE9C).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$1500,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; End of function sub_56DAC


; =============== S U B R O U T I N E =======================================


sub_56DCA:

		lea	word_56F88(pc),a1
		move.w	(Player_1+x_pos).w,d0
		move.w	(Player_1+y_pos).w,d1
		moveq	#0,d2
		move.w	#2,d3

loc_56DDC:
		lea	(a1),a5
		cmp.w	(a5)+,d0
		blo.s	loc_56DEE
		cmp.w	(a5)+,d0
		bhi.s	loc_56DEE
		cmp.w	(a5)+,d1
		blo.s	loc_56DEE
		cmp.w	(a5)+,d1
		blo.s	loc_56DFA

loc_56DEE:

		adda.w	#$A,a1
		addq.w	#4,d2
		dbf	d3,loc_56DDC
		rts
; ---------------------------------------------------------------------------

loc_56DFA:
		jmp	loc_56DFE(pc,d2.w)
; End of function sub_56DCA

; ---------------------------------------------------------------------------

loc_56DFE:
		bra.w	loc_56E0A
; ---------------------------------------------------------------------------
		bra.w	loc_56E1C
; ---------------------------------------------------------------------------
		bra.w	loc_56E2E
; ---------------------------------------------------------------------------

loc_56E0A:
		tst.w	(ScrEvents_Routine2).w
		bne.s	loc_56E16
		cmp.w	(a5),d0
		bhs.s	loc_56E40
		rts
; ---------------------------------------------------------------------------

loc_56E16:
		cmp.w	(a5),d0
		blo.s	loc_56E66
		rts
; ---------------------------------------------------------------------------

loc_56E1C:
		tst.w	(ScrEvents_Routine2).w
		bne.s	loc_56E28
		cmp.w	(a5),d0
		blo.s	loc_56E40
		rts
; ---------------------------------------------------------------------------

loc_56E28:
		cmp.w	(a5),d0
		bhs.s	loc_56E66
		rts
; ---------------------------------------------------------------------------

loc_56E2E:
		tst.w	(ScrEvents_Routine2).w
		bne.s	loc_56E3A
		cmp.w	(a5),d1
		bhs.s	loc_56E40
		rts
; ---------------------------------------------------------------------------

loc_56E3A:
		cmp.w	(a5),d1
		blo.s	loc_56E66
		rts
; ---------------------------------------------------------------------------

loc_56E40:
		st	(ScrEvents_Routine2).w
		jsr	Create_New_Sprite.w
		bne.s	loc_56E52
		move.l	#Obj_56EA0,(a1)

loc_56E52:
		jsr	sub_56DAC(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addq.w	#4,(TrigEvents_Routine).w
		addq.w	#4,sp
		jmp	loc_56C76(pc)
; ---------------------------------------------------------------------------

loc_56E66:
		clr.w	(ScrEvents_Routine2).w
		move.w	(Camera_X_pos_BG_copy).w,(ScrEvents_3).w
		move.w	(Camera_Y_pos_BG_copy).w,(ScrEvents_4).w
		jsr	sub_56D40(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	d2,(Block_table+$1806).w
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		addq.w	#4,sp
		jmp	loc_56C8C(pc)
; ---------------------------------------------------------------------------

Obj_56EA0:
		move.l	#loc_56EC2,(a0)
		move.b	#-$80,6(a0)
		move.w	#$1E80,$10(a0)
		bset	#7,$2A(a0)
		move.w	#-$4000,$34(a0)
		clr.w	(__u_EE9C).w

loc_56EC2:
		tst.w	(ScrEvents_Routine2).w
		bne.s	loc_56ECE
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_56ECE:
		move.l	$2E(a0),d0
		move.l	$32(a0),d1
		move.l	#-$100,d2
		tst.b	$36(a0)
		beq.s	loc_56EF6
		neg.l	d2
		add.l	d1,d0
		bmi.s	loc_56F0A
		moveq	#0,d0
		move.l	#$C000,d1
		clr.b	$36(a0)
		bra.s	loc_56F0C
; ---------------------------------------------------------------------------

loc_56EF6:
		add.l	d1,d0
		beq.s	loc_56EFC
		bpl.s	loc_56F0A

loc_56EFC:
		moveq	#0,d0
		move.l	#-$C000,d1
		st	$36(a0)
		bra.s	loc_56F0C
; ---------------------------------------------------------------------------

loc_56F0A:

		add.l	d2,d1

loc_56F0C:

		move.l	d1,$32(a0)
		move.l	d0,$2E(a0)
		swap	d0
		move.w	d0,(__u_EE9C).w
		neg.w	d0
		addi.w	#$988,d0
		move.w	d0,$14(a0)
		move.w	#$280,d1
		move.w	#$80,d2
		move.w	#$6C,d3
		move.w	$10(a0),d4
		jsr	SolidObjectTop.w
		btst	#3,$2A(a0)
		beq.s	loc_56F54
		lea	(Player_1).w,a1
		btst	#4,$2B(a1)
		bne.s	loc_56F54
		jsr	sub_24280.w

loc_56F54:

		btst	#4,$2A(a0)
		beq.s	locret_56F66
		lea	(Player_2).w,a1
		jmp	sub_24280.w

locret_56F66:
		rts
; ---------------------------------------------------------------------------
LRZ1_BGDrawArray:
		dc.w $B0
		dc.w $100
		dc.w $7FFF
LRZ1_BGDeformArray:
		dc.w $40
		dc.w $20
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $100
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $20
		dc.w $7FFF
word_56F88:	dc.w  $1AC0, $1B40,  $840,  $8C0
		dc.w  $1B00, $2240, $2340,  $840
		dc.w   $880, $22C0, $20C0, $2180
		dc.w   $740,  $800,  $7A0
; ---------------------------------------------------------------------------

LRZ2_ScreenInit:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

LRZ2_ScreenEvent:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

LRZ2_BackgroundInit:
		jsr	Create_New_Sprite.w
		bne.s	loc_56FD2
		move.l	#loc_5711E,(a1)
		move.w	a1,(ScrEvents_5).w

loc_56FD2:
		move.w	#8,(TrigEvents_Routine).w
		jsr	sub_57082(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		moveq	#0,d1
		jsr	(Refresh_PlaneFull).l
		lea	LRZ2_BGDeformArray(pc),a4
		lea	(Block_table+$1800).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

LRZ2_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_57000(pc,d0.w)
; ---------------------------------------------------------------------------

loc_57000:
		bra.w	loc_5700C
; ---------------------------------------------------------------------------
		bra.w	loc_57040
; ---------------------------------------------------------------------------
		bra.w	loc_57058
; ---------------------------------------------------------------------------

loc_5700C:
		jsr	Create_New_Sprite.w
		bne.s	loc_5701E
		move.l	#loc_5711E,(a1)
		move.w	a1,(ScrEvents_5).w

loc_5701E:
		jsr	sub_57082(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_57044
; ---------------------------------------------------------------------------

loc_57040:
		jsr	sub_57082(pc)

loc_57044:
		moveq	#0,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_5706C		; NAT: Change lable
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_5706C
; ---------------------------------------------------------------------------

loc_57058:
		jsr	sub_57082(pc)

loc_5705C:

		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		moveq	#0,d1
		moveq	#$20,d6
		jsr	(Draw_TileRow).l

loc_5706C:
		lea	LRZ2_BGDeformArray(pc),a4
		lea	(Block_table+$1800).w,a5
		jsr	(ApplyDeformation).l
		jmp	ShakeScreen_Setup.w

; =============== S U B R O U T I N E =======================================


sub_57082:
	; first, calculate screen shake offset for BG
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(ScrShake_Offset).w,d1
		sub.w	d1,d0
		swap	d0
		clr.w	d0
		asr.l	#3,d0
		move.l	d0,d2
		asr.l	#2,d2
		sub.l	d2,d0
		swap	d0
		add.w	d1,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w

	; then calculate the background x-position for BG
		move.w	(Camera_X_pos_copy).w,d0	; get camera FG x-pos
		swap	d0				; swap to high word
		clr.w	d0				; clear extra word
		asr.l	#3,d0				; divide by 8
		move.l	d0,d1				; copy to d1
		move.l	d0,d2				; and d2
		asr.l	#2,d0				; divide by 4 (total 32/$20)
		swap	d1				; get the shifted x-pos back to d1
		move.w	d1,(Camera_X_pos_BG_copy).w	; save as BG x-pos copy
		swap	d1				; then unswap the x-pos lol

	; we calculate x-positions and offsets
		sub.l	d0,d1				; substract 1 quarter from the x-pos
		swap	d1				; ...and swap again....
		move.w	d1,(ScrEvents_A).w		; save to some RAM address
		swap	d1				; ...and more swaps
		sub.l	d0,d1				; sub 1 more quarter from it (halving in total)
		swap	d1				; ...swap...
		move.w	d1,(ScrEvents_B).w		; save to some RAM address

	; fill $A800-$A810
		lea	(Block_table+$1810).w,a1		; this is some data in the chunk table..!
		move.l	d2,d1				; copy the old x-pos to d1 again
		moveq	#7,d3				; write 8 values in RAM

loc_570D2:
		swap	d1				; ...yay swapping!...
		move.w	d1,-(a1)			; write data to this RAM address
		swap	d1				; ...yay swapping!...
		add.l	d0,d1				; add a single quarter to the position
		dbf	d3,loc_570D2			; loop!

	; fill $A810-$A8224
		lea	(Block_table+$1810).w,a1		; this is some data in the chunk table..!
		add.l	d0,d2				; add a quarter to BG x-pos
		add.l	d0,d0				; double offset into a halve
		moveq	#4,d3				; write 5 values

loc_570E8:
		swap	d2				; ...yay swapping!...
		move.w	d2,(a1)+			; write data to this RAM address
		swap	d2				; ...yay swapping!...
		add.l	d0,d2				; add a halve to the position
		dbf	d3,loc_570E8			; loop!

		move.w	(ScrEvents_5).w,d0
		beq.s	locret_5711C
		movea.w	d0,a1
		move.w	#$678,d0
		sub.w	(Block_table+$1804).w,d0
		cmpi.w	#-$7E0,d0
		ble.s	loc_5710C
		moveq	#0,d0

loc_5710C:
		move.w	d0,$10(a1)
		move.w	#$C0,d0
		sub.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	d0,$14(a1)

locret_5711C:
		rts
; End of function sub_57082

; ---------------------------------------------------------------------------

loc_5711E:

	;	cmpi.w	#3,(Player_mode).w
	;	bne.s	loc_57130
	;	clr.w	(ScrEvents_5).w
	;	jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_57130:
		move.l	#loc_57156,(a0)
		move.b	#$40,6(a0)
		move.b	#$50,7(a0)
		move.w	#prio(7),8(a0)
		move.w	#$639F,$A(a0)
		move.l	#Map_LRZ2DeathEggBG,$C(a0)

loc_57156:
		tst.w	$2E(a0)
		bne.s	loc_57176
		tst.w	$10(a0)
		beq.s	locret_57182
		lea	(ArtKosM_LRZ2DeathEggBG).l,a1
		move.w	#$73E0,d2
		jsr	Queue_Kos_Module.w
		st	$2E(a0)

loc_57176:
		tst.w	$10(a0)
		beq.s	locret_57182
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

locret_57182:

		rts
; ---------------------------------------------------------------------------
LRZ2_BGDeformArray:
		dc.w $20
		dc.w $20
		dc.w $20
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $F0
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $20
		dc.w $7FFF
Map_LRZ2DeathEggBG:	include "Levels/LRZ/Misc Object Data/Map - Act 2 BG Death Egg.asm"

; ---------------------------------------------------------------------------

SSZ1_ScreenInit:
		clr.w	(__u_EE98).w
		clr.w	(__u_EE9C).w
		lea	(Block_table+$19F6).w,a1
		lea	(a1),a5
		moveq	#4,d0

loc_57256:
		clr.w	(a1)+
		dbf	d0,loc_57256
		lea	word_58758(pc),a6
		moveq	#4,d1
		jsr	Create_New_Sprite.w
		bne.s	loc_5728E

loc_5726A:
		move.w	a1,(a5)+
		move.l	#loc_57BB2,(a1)
		move.w	(a6)+,$38(a1)
		move.w	(a6)+,$3A(a1)
		move.w	(a6)+,$40(a1)
		move.w	(a6)+,d2
		move.b	d2,$22(a1)
		jsr	(CreateNewSprite4).l
		dbne	d1,loc_5726A

loc_5728E:
		jsr	sub_5758A(pc)
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

SSZ1_ScreenEvent:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		move.w	(ScrEvents_Routine).w,d0
		jmp	loc_572AE(pc,d0.w)
; ---------------------------------------------------------------------------

loc_572AE:
		bra.w	loc_572BA
; ---------------------------------------------------------------------------
		bra.w	loc_57344
; ---------------------------------------------------------------------------
		bra.w	loc_574B0
; ---------------------------------------------------------------------------

loc_572BA:
		cmp.b	#6,PlayMode.w		; NAT: Check for minigame mode
		beq.s	.draw			; if so, branch
		tst.b	(Title_Card_Out_Flag).w
		bne.s	loc_572CE
		jsr	sub_575EA(pc)
.draw		jsr	sub_5758A(pc)
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

loc_572CE:
		jsr	Create_New_Sprite.w
		bne.s	loc_572E2
		move.l	#Obj_57E96,(a1)
		move.w	#$1E,$2E(a1)

loc_572E2:
		lea	(Block_table+$18E0).w,a1
		lea	$20(a1),a5
		moveq	#9,d0

loc_572EC:
		move.w	#-1,(a1)+
		clr.l	(a5)+
		clr.l	$3C(a5)
		dbf	d0,loc_572EC
		jsr	sub_5750C(pc)
		lea	(Block_table+$1880).w,a1
		move.w	(Camera_Y_pos_mask).w,d0
		moveq	#9,d1

loc_57308:
		move.w	(a1)+,(a1)
		and.w	d0,(a1)+
		dbf	d1,loc_57308
		jsr	Restore_PlayerControl.w
		lea	(Player_2).w,a1
		jsr	Restore_PlayerControl2.w
		st	(Ctrl_1_locked).w
		st	(Ctrl_2_locked).w
		clr.w	(Ctrl_1_logical).w
		clr.w	(Ctrl_2_logical).w
		st	(Scroll_lock).w
		st	(ScrShake_Value).w
		move.w	#4,(Special_V_int_routine).w
		addq.w	#4,(ScrEvents_Routine).w
		bra.s	loc_5734E
; ---------------------------------------------------------------------------

loc_57344:
		tst.w	(ScrEvents_1).w
		bne.s	loc_57360
		jsr	sub_5750C(pc)

loc_5734E:
		lea	word_577B2(pc),a4
		lea	(Block_table+$1880).w,a5
		moveq	#$F,d6
		moveq	#$A,d5
		jmp	(DrawTilesVDeform).l
; ---------------------------------------------------------------------------

loc_57360:
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(SSZ1_128x128_Custom_Kos).l,a1
		lea	(Chunk_table+$180).l,a2
		jsr	Queue_Kos.w
		lea	(SSZ1_16x16_Custom_Kos).l,a1
		lea	(Block_table+$B8).w,a2
		jsr	Queue_Kos.w
		lea	(ArtKosM_SSZ1_Custom).l,a1
		move.w	#$E60,d2
		jsr	Queue_Kos_Module.w
		lea	(ArtKosM_SSZSpiralRamp).l,a1
		move.w	#$6900,d2
		jsr	Queue_Kos_Module.w
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	-8(a3),d0
		subq.w	#3,d0
		movea.w	(a3),a1
		move.b	#4,(a1,d0.w)
		move.b	#5,1(a1,d0.w)
		move.b	#6,2(a1,d0.w)
		movea.w	4(a3),a1
		move.b	#7,(a1,d0.w)
		move.b	#8,1(a1,d0.w)
		move.b	#9,2(a1,d0.w)
		lea	(Normal_palette_line_2).w,a1
		lea	Pal_SSZDeathEgg(pc),a5
		moveq	#7,d0

loc_573E4:
		move.l	(a5)+,(a1)+
		dbf	d0,loc_573E4
		jsr	sub_574DC(pc)
		move.w	(ScrEvents_E).w,d0
		move.w	d0,d1
		andi.w	#-$10,d0
		move.w	d0,(__u_EEF2).w
		move.w	(__u_EEEE).w,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(__u_EEF4).w
		st	(__u_EE98).w
		clr.l	(__u_EEF6).w
		clr.w	(__u_EEFA).w
		jsr	Create_New_Sprite.w
		bne.w	loc_574A0
		move.w	#$5A8,d1
		move.w	#$58C,d2
		move.w	#$554,d3
		moveq	#9,d4

loc_5742C:
		move.l	#loc_58234,(a1)
		move.w	#$1A38,$10(a1)
		move.w	d1,$14(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_574A0
		move.l	#loc_58360,(a1)
		move.w	#$1A80,$10(a1)
		move.w	d2,$14(a1)
		tst.w	d4
		beq.s	loc_574A0
		jsr	(CreateNewSprite4).l
		bne.s	loc_574A0
		move.l	#loc_582AC,(a1)
		move.w	#$1A48,$10(a1)
		move.w	d1,$14(a1)
		subi.w	#$38,$14(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_574A0
		move.l	#loc_581F2,(a1)
		move.w	#$19F8,$10(a1)
		move.w	d3,$14(a1)
		moveq	#$70,d5
		sub.w	d5,d1
		sub.w	d5,d2
		sub.w	d5,d3
		jsr	(CreateNewSprite4).l
		dbne	d4,loc_5742C

loc_574A0:

		st	(ScrEvents_1).w
		move.w	#$C,(Special_V_int_routine).w
		addq.w	#4,(ScrEvents_Routine).w
		rts
; ---------------------------------------------------------------------------

loc_574B0:
		jsr	sub_574DC(pc)
		lea	(VScrollBuffer).w,a6
		lea	(__u_EEF2).w,a5
		move.w	(__u_EEEE).w,d1
		moveq	#$F,d6
		jsr	(Draw_TileColumn).l
		lea	(__u_EEEE).w,a6
		lea	(__u_EEF4).w,a5
		move.w	(VScrollBuffer).w,d1
		moveq	#$15,d6
		jmp	(Draw_TileRow).l

; =============== S U B R O U T I N E =======================================


sub_574DC:

		move.w	(Camera_X_pos_copy).w,(ScrEvents_E).w
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$110,d0
		asr.w	#2,d0
		move.w	d0,(__u_EEEE).w
		cmpi.w	#$110,(Camera_Y_pos).w
		bne.w	sub_5758A
		addi.l	#$6000,(__u_EEF6).w
		move.w	(__u_EEF6).w,d0
		add.w	d0,(__u_EEEE).w
		bra.s	sub_5758A
; End of function sub_574DC


; =============== S U B R O U T I N E =======================================


sub_5750C:

		lea	(Block_table+$1880).w,a5
		lea	$60(a5),a6
		move.w	(Camera_Y_pos_copy).w,d0
		moveq	#$A,d1
		moveq	#9,d2

loc_5751C:
		tst.w	(a6)
		beq.s	loc_57526
		bmi.s	loc_57536
		subq.w	#1,(a6)
		bra.s	loc_57536
; ---------------------------------------------------------------------------

loc_57526:
		move.l	$80(a5),d3
		addi.l	#$800,$80(a5)
		sub.l	d3,$C0(a5)

loc_57536:

		move.w	$C0(a5),d3
		add.w	d0,d3
		cmpi.w	#$580,d3
		bhs.s	loc_5754C
		clr.l	$80(a5)
		move.w	#$580,d3
		subq.w	#1,d1

loc_5754C:
		move.w	d3,(a5)
		move.w	d3,-$20(a6)
		addq.w	#4,a5
		addq.w	#2,a6
		dbf	d2,loc_5751C
		movea.w	(__u_FAA4).w,a1
		move.w	$10(a1),d0
		subi.w	#$19A0,d0
		lsr.w	#3,d0
		andi.w	#-4,d0
		lea	(Block_table+$1940).w,a5
		move.w	#$660,d2
		sub.w	(a5,d0.w),d2
		move.w	d2,$14(a1)
		tst.w	d1
		bne.s	sub_5758A
		st	(ScrEvents_1+$1).w
		move.l	#Delete_Current_Sprite,(a1)
; End of function sub_5750C


; =============== S U B R O U T I N E =======================================


sub_5758A:

		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(ScrShake_Offset).w,d3
		sub.w	d3,d0
		move.w	d0,d1
		asr.w	#2,d1
		add.w	d1,d0
		move.w	(__u_EE9C).w,d1
		move.w	d1,d2
		asr.w	#2,d2
		add.w	d2,d1
		asr.w	#1,d1
		add.w	d1,d0
		add.w	d3,d0
		move.w	(Camera_X_pos_copy).w,d1
		move.w	d1,d2
		asr.w	#2,d2
		add.w	d2,d1
		lea	(Block_table+$19F6).w,a5
		moveq	#4,d2

loc_575BA:
		move.w	(a5)+,d3
		beq.s	loc_575E4
		movea.w	d3,a6
		move.w	$38(a6),d3
		sub.w	d0,d3
		andi.w	#$FF,d3
		addi.w	#$70,d3
		move.w	d3,$14(a6)
		move.w	$3A(a6),d3
		sub.w	d1,d3
		andi.w	#$1FF,d3
		addi.w	#$50,d3
		move.w	d3,$10(a6)

loc_575E4:
		dbf	d2,loc_575BA

locret_575E8:
		rts
; End of function sub_5758A


; =============== S U B R O U T I N E =======================================


sub_575EA:
		tst.b	(ScrEvents_5).w
		bne.s	locret_575E8
		cmpi.w	#$19A0,(Camera_X_pos).w
		blo.s	loc_5761C
		move.w	(Camera_Y_pos).w,d1	; NAT: fuck
		add.w	#224/2,d1

		cmpi.w	#$680,d1
		bhs.s	loc_5761C
		move.w	#$19A0,(Camera_min_X_pos).w
		move.w	#$5C0,d0
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		st	(ScrEvents_5).w
		bra.w	locret_57788
; ---------------------------------------------------------------------------

loc_5761C:

		tst.b	(ScrEvents_4+$1).w
		bne.w	locret_57788
		move.b	(ScrEvents_Routine2+$1).w,d0
		or.b	(ScrEvents_3+$1).w,d0
		bne.s	loc_57686
		move.w	(Camera_Y_pos).w,d0
		cmpi.w	#$100,d0
		blo.s	loc_57674
		cmpi.w	#$E00,d0
		bhs.s	loc_57674
		lea	word_5778A(pc),a1

		move.w	(Camera_X_pos).w,d1	; NAT: fuck
		add.w	#320/2,d1

loc_57646:
		cmp.w	(a1)+,d1
		blo.s	loc_5764E
		addq.w	#2,a1
		bra.s	loc_57646
; ---------------------------------------------------------------------------

loc_5764E:
		move.w	(a1),d2
		cmp.w	d0,d2
		bhi.s	loc_57658
		move.w	d2,(Camera_min_Y_pos).w

loc_57658:
		lea	word_5779A(pc),a1

loc_5765C:
		cmp.w	(a1)+,d1
		blo.s	loc_57664
		addq.w	#2,a1
		bra.s	loc_5765C
; ---------------------------------------------------------------------------

loc_57664:
		move.w	(a1),d2
		cmp.w	d0,d2
		blo.s	loc_57686
		move.w	d2,(Camera_max_Y_pos).w
		move.w	d2,(Camera_target_max_Y_pos).w
		bra.s	loc_57686
; ---------------------------------------------------------------------------

loc_57674:

		move.w	#-$100,(Camera_min_Y_pos).w
		move.w	#$1000,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w

loc_57686:
		move.w	(Camera_Y_pos).w,d0	; NAT: fuck
		add.w	#224/2,d0

		cmpi.w	#$440,d0
		blo.w	loc_5770C
		cmpi.w	#$880,d0
		bhs.w	loc_5777E
		tst.b	(ScrEvents_Routine2).w
		bmi.w	loc_5777E
		bne.w	locret_57788
		tst.b	(ScrEvents_Routine2+$1).w
		bne.s	loc_576E8
		move.w	#$160,(Camera_min_X_pos).w
		move.w	#$19A0,(Camera_max_X_pos).w
		cmpi.w	#$7C0,d0
		blo.w	locret_57788
		cmpi.w	#$160,(Camera_X_pos).w
		bne.w	locret_57788

		btst	#1,player_2+x_pos.w		; NAT: teat test
		beq.s	.tammy
		btst	#1,(Player_1+$2A).w
		bne.w	locret_57788

.tammy		move.w	#$160,(Camera_max_X_pos).w
		move.w	#$7C0,d0
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		st	(ScrEvents_Routine2+$1).w

loc_576E8:
		cmpi.w	#$7C0,(Camera_Y_pos).w
		bne.w	locret_57788
		jsr	Create_New_Sprite.w
		bne.s	loc_5770A
		move.l	#Obj_SSZGHZBoss,(a1)
		st	(ScrEvents_4+$1).w
		move.w	#$7F00,(ScrEvents_Routine2).w

loc_5770A:
		rts		; NAT: was branch to rts
; ---------------------------------------------------------------------------

loc_5770C:
		tst.b	(ScrEvents_3).w
		bmi.s	loc_5777E
		bne.s	locret_57788
		tst.b	(ScrEvents_3+$1).w
		bne.s	loc_5775C
		move.w	#$1660,(Camera_max_X_pos).w
		moveq	#0,d1
		tst.w	(ScrEvents_Routine2).w
		bne.s	loc_5772C
		move.w	#$160,d1

loc_5772C:
		move.w	d1,(Camera_min_X_pos).w
		cmpi.w	#$420,d0
		blo.s	locret_57788
		cmpi.w	#$1660,(Camera_X_pos).w
		bne.s	locret_57788

		btst	#1,Player_2+status.w	; NAT: Sex
		beq.s	.erotica
		btst	#1,(Player_1+$2A).w
		bne.s	locret_57788

.erotica	move.w	#$1660,(Camera_min_X_pos).w
		move.w	#$380,d0
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		st	(ScrEvents_3+$1).w

loc_5775C:
		cmpi.w	#$380,(Camera_Y_pos).w
		bne.s	locret_57788
		jsr	Create_New_Sprite.w
		bne.s	loc_5777C
		move.l	#Obj_SSZMTZBoss,(a1)
		st	(ScrEvents_4+$1).w
		move.w	#$7F00,(ScrEvents_3).w

loc_5777C:
		bra.s	locret_57788
; ---------------------------------------------------------------------------

loc_5777E:

		clr.w	(Camera_min_X_pos).w
		move.w	#$19A0,(Camera_max_X_pos).w

locret_57788:

		rts
; End of function sub_575EA

; ---------------------------------------------------------------------------
word_5778A:	dc.w $EE0
		dc.w $D00
		dc.w $11E0
		dc.w $CC0
		dc.w $1340
		dc.w $B20
		dc.w $7FFF
		dc.w 0
word_5779A:	dc.w $640
		dc.w $C60
		dc.w $880
		dc.w $CA0
		dc.w $1200
		dc.w $C60
		dc.w $1380
		dc.w $A80
		dc.w $13C0
		dc.w $660
		dc.w $7FFF
		dc.w $3E0
word_577B2:	dc.w $19C0

		dc.w $20
		dc.w $20
		dc.w $20
		dc.w $20
		dc.w $20
		dc.w $20
		dc.w $20
		dc.w $20
		dc.w $7FFF
dword_577C6:	dc.l 9
		dc.l $C0006
		dc.l $3000C
		dc.l 9
		dc.l $C0003
Pal_SSZDeathEgg:	binclude "Levels/SSZ/Palettes/Death Egg.bin"
	even

; ---------------------------------------------------------------------------

SSZ1_BackgroundInit:
		clr.w	(ScrEvents_A).w
		jsr	Create_New_Sprite.w
		bne.s	loc_57840
		move.l	#loc_57B6A,(a1)

		lea	SSZMain_SolidBG(pc),a5
		cmp.b	#6,PlayMode.w			; NAT: check If minigame
		bne.s	.load				; branch if not
		lea	SSZMini_SolidBG(pc),a5		; load shit for Solid BG for minigmae

.load		move.w	(a5)+,d1

loc_57812:
		jsr	(CreateNewSprite4).l
		bne.s	loc_57840
		move.l	#loc_57B8E,(a1)
		move.w	(a5)+,d2
		move.b	d2,render_flags(a1)
		move.b	#$80,height_pixels(a1)
		move.w	(a5)+,x_pos(a1)
		move.w	(a5)+,$1A(a1)		; this is the real y-pos
		move.w	(a5)+,$2E(a1)		; this is width of the object

		moveq	#0,d3
		move.w	(a5)+,d3
		add.l	#SSZ_SolidBG_Data,d3	; add solid BG data address to d0
		move.l	d3,$30(a1)		; this is the top surface table
		dbf	d1,loc_57812

loc_57840:
		move.w	(Camera_Y_pos).w,d0
		and.w	(Screen_Y_wrap_value).w,d0
		cmpi.w	#$800,d0
		blo.s	loc_57854
		cmpi.w	#$F00,d0
		blo.s	loc_5786A

loc_57854:
		jsr	sub_579F0(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

loc_5786A:
		move.w	#8,(TrigEvents_Routine).w
		jsr	sub_57A60(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$2000,d1			; NAT: Background was moved in layout
		jsr	(Refresh_PlaneFull).l
		lea	SSZ1_BGDeformArray(pc),a4
		lea	(Block_table+$1804).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

SSZ1_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_5789A(pc,d0.w)
; ---------------------------------------------------------------------------

loc_5789A:
		bra.w	loc_578AA
; ---------------------------------------------------------------------------
		bra.w	loc_57942
; ---------------------------------------------------------------------------
		bra.w	loc_57960
; ---------------------------------------------------------------------------
		bra.w	loc_579D2
; ---------------------------------------------------------------------------

loc_578AA:
		move.w	(Camera_Y_pos).w,d0
		and.w	(Screen_Y_wrap_value).w,d0
		cmpi.w	#$800,d0
		blo.s	loc_578EC
		cmpi.w	#$F00,d0
		bhs.s	loc_578EC

		move.w	(Camera_X_pos_BG_copy).w,(ScrEvents_8).w
		move.w	(Camera_Y_pos_BG_copy).w,(ScrEvents_9).w
		jsr	sub_57A60(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_57946
; ---------------------------------------------------------------------------

loc_578EC:

		jsr	sub_579F0(pc)
		jsr	(DrawBGAsYouMove).l

loc_578F0:		; NAT: Move lable
		jsr	(PlainDeformation).l
		jsr	ShakeScreen_Setup.w
		tst.w	(__u_EE98).w
		bne.s	loc_57916
		lea	word_577B2(pc),a4
		lea	(Block_table+$18BE).w,a5
		jmp	(Apply_FGVScroll).l
; ---------------------------------------------------------------------------

loc_57916:
		move.w	(__u_EEFA).w,d0
		beq.s	loc_57932
		clr.w	(__u_EEFA).w
		move.w	d0,(a0)+
		move.w	#7,(a0)+
		moveq	#$1F,d0

loc_57928:
		move.w	#$6061,(a0)+
		dbf	d0,loc_57928
		clr.w	(a0)

loc_57932:
		move.w	(__u_EEEE).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------

loc_57942:
		jsr	sub_57A60(pc)

loc_57946:
		move.w	#$2000,d1		; NAT: BG was moved
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_5799A
		clr.w	(ScrEvents_8).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_5799A
; ---------------------------------------------------------------------------

loc_57960:
		move.w	(Camera_Y_pos).w,d0
		and.w	(Screen_Y_wrap_value).w,d0
		cmpi.w	#$800,d0
		blo.s	loc_57974
		cmpi.w	#$F00,d0
		blo.s	loc_57996

loc_57974:
		jsr	sub_579F0(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_579D6
; ---------------------------------------------------------------------------

loc_57996:
		jsr	sub_57A60(pc)

		lea	(Camera_Y_pos_BG_copy).w,a6
		lea	(Camera_Y_pos_BG_rounded).w,a5
		move.w	#$2000,d1			; NAT: background was moved
		moveq	#$20,d6
		jsr	(Draw_TileRow).l

loc_5799A:		; NAT: Move lable
		move.w	(ScrEvents_8).w,d0
		beq.s	loc_579C4
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(ScrEvents_9).w,(Camera_Y_pos_BG_copy).w
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

loc_579C4:
		lea	SSZ1_BGDeformArray(pc),a4
		lea	(Block_table+$1804).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

loc_579D2:
		jsr	sub_579F0(pc)

loc_579D6:
		move.w	(Camera_X_pos_BG_copy).w,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertSingleBottomUp).l
		bpl.w	loc_578F0
		clr.w	(TrigEvents_Routine).w
		bra.w	loc_578F0

; =============== S U B R O U T I N E =======================================


sub_579F0:
		tst.w	(ScrEvents_A).w
		bne.s	loc_57A30
		cmpi.w	#$1800,(Camera_X_pos).w
		blo.s	loc_57A12
		cmp.b	#6,PlayMode.w			; NAT: If minigame, also branch
		beq.s	loc_57A12

		st	(ScrEvents_A).w
		bsr.s	sub_579F0
		move.w	(Camera_X_pos_BG_copy).w,d0
		andi.w	#-$10,d0
		move.w	d0,(Camera_X_pos_BG_rounded).w
		rts
; ---------------------------------------------------------------------------

loc_57A12:
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$160,d0
		add.w	(__u_EE9C).w,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		addi.w	#$28,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		rts
; ---------------------------------------------------------------------------

loc_57A30:
		cmpi.w	#$1800,(Camera_X_pos).w
		bhs.s	loc_57A4C
		cmp.b	#6,PlayMode.w			; NAT: If minigame, also branch
		beq.s	loc_57A4C

		clr.w	(ScrEvents_A).w
		bsr.s	sub_579F0
		move.w	(Camera_X_pos_BG_copy).w,d0
		andi.w	#-$10,d0
		move.w	d0,(Camera_X_pos_BG_rounded).w
		rts
; ---------------------------------------------------------------------------

loc_57A4C:
		move.w	(Camera_Y_pos_copy).w,d0
		addi.w	#$180,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,(Camera_X_pos_BG_copy).w
		rts
; End of function sub_579F0


; =============== S U B R O U T I N E =======================================


sub_57A60:

		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(__u_EE9C).w,d1
		asr.w	#1,d1
		add.w	d1,d0
		and.w	(Screen_Y_wrap_value).w,d0
		subi.w	#$800,d0
		asr.w	#1,d0
		addi.w	#$A0,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		lea	(Block_table+$1804).w,a1
		move.l	-4(a1),d2
		addi.l	#$500,-4(a1)
		move.w	(Camera_X_pos_copy).w,d0
		swap	d0
		clr.w	d0
		asr.l	#5,d0
		move.l	d0,d1
		asr.l	#1,d0
		add.l	d2,d0
		swap	d0
		move.w	d0,(a1)
		move.w	d0,6(a1)
		move.w	d0,$A(a1)
		move.w	d0,$14(a1)
		swap	d0
		add.l	d2,d1
		add.l	d1,d0
		swap	d0
		move.w	d0,8(a1)
		move.w	d0,$E(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,4(a1)
		move.w	d0,$C(a1)
		move.w	d0,$12(a1)
		move.w	d0,$16(a1)
		move.w	d0,$3A(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,2(a1)
		move.w	d0,$10(a1)
		move.w	d0,$18(a1)
		move.w	d0,$38(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$1A(a1)
		move.w	d0,$36(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$1C(a1)
		move.w	d0,$34(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$1E(a1)
		move.w	d0,$32(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$20(a1)
		move.w	d0,$30(a1)
		swap	d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$22(a1)
		move.w	d0,$2E(a1)
		swap	d0
		add.l	d1,d0
		add.l	d1,d0
		swap	d0
		move.w	d0,$24(a1)
		move.w	d0,$2C(a1)
		swap	d0
		move.l	d1,d2
		asr.l	#1,d2
		add.l	d1,d0
		add.l	d1,d0
		add.l	d2,d0
		swap	d0
		move.w	d0,$26(a1)
		move.w	d0,$2A(a1)
		swap	d0
		add.l	d1,d0
		add.l	d1,d0
		add.l	d2,d0
		swap	d0
		move.w	d0,$28(a1)
		rts
; End of function sub_57A60

; ---------------------------------------------------------------------------

loc_57B6A:
		move.l	#loc_57B76,(a0)
		move.w	#-$8000,$30(a0)

loc_57B76:
		move.l	#$8000,d0
		move.l	#$100,d1
		jsr	Gradual_SwingOffset.w
		move.w	d0,(__u_EE9C).w
		rts
; ---------------------------------------------------------------------------

loc_57B8E:
		bset	#7,$2A(a0)
		move.w	$1A(a0),d0
		sub.w	(__u_EE9C).w,d0
		move.w	d0,$14(a0)
		move.w	$2E(a0),d1
		movea.l	$30(a0),a2
		move.w	$10(a0),d4
		jmp	SolidObjectTopSloped2.w
; ---------------------------------------------------------------------------

loc_57BB2:
		move.l	#loc_57BF6,(a0)
		move.b	#$40,4(a0)
		move.b	#$10,6(a0)
		move.b	#$30,7(a0)
		move.w	#prio(0),priority(a0)
		move.w	#-$1CF0,$A(a0)
		move.l	#Map_SSZRoamingClouds,$C(a0)
		move.w	$38(a0),$1A(a0)
		jsr	Random_Number.w
		andi.w	#$FFF,d0
		addi.w	#$C00,d0
		move.w	d0,$30(a0)

loc_57BF6:
		move.l	#$1C00,d0
		move.l	#$80,d1
		jsr	Gradual_SwingOffset.w
		add.w	$1A(a0),d0
		move.w	d0,$38(a0)
		move.l	$3E(a0),d0
		sub.l	d0,$3A(a0)
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Obj_57C1E:

		jsr	Create_New_Sprite3.w
		beq.s	loc_57C28
		rts
; ---------------------------------------------------------------------------

loc_57C28:
		move.l	#loc_57CD2,(a0)
		move.w	#$1000,$14(a0)
		move.w	#-$100,$38(a0)
		move.w	a1,$3C(a0)
		move.l	#Obj_TeleporterBeamExpand,(a1)
		move.b	#$44,4(a1)
		move.b	#-$80,6(a1)
		move.b	#$18,7(a1)
		move.w	#prio(1),8(a1)
		move.w	#-$1CA4,$A(a1)
		move.l	#Map_SSZHPZTeleporter,$C(a1)
		move.w	$10(a0),$10(a1)
		move.w	$14(a0),$14(a1)
		move.w	#2,$16(a1)
		move.w	$14(a0),$44(a1)
		subi.w	#$88,$44(a1)
		move.b	#$18,$46(a1)
		move.w	a0,$48(a1)
		tst.b	(Current_act).w
		bne.s	loc_57CAC
		jsr	(CreateNewSprite4).l
		bne.s	loc_57CAC
		move.l	#Obj_57E34,(a1)
		move.w	#$60,$2C(a1)

loc_57CAC:

		st	(ScrEvents_4).w
		lea	(Player_1).w,a1
		move.w	(Camera_Y_pos).w,d0
		addi.w	#$65,d0
		move.w	d0,$14(a1)
		move.b	#3,$2E(a1)
		moveq	#0,d0
		move.b	d0,$20(a1)
		move.b	d0,$22(a1)
		rts
; ---------------------------------------------------------------------------

loc_57CD2:
		jsr	(sub_45866).l
		lea	(Player_1).w,a1
		move.w	$10(a0),$10(a1)
		tst.b	$2D(a0)
		bne.w	loc_57D50
		move.b	#1,$2E(a1)
		move.b	#2,$20(a1)
		bset	#2,$2A(a1)
		move.w	#-1,$1A(a1)
		move.w	$14(a1),d1
		move.w	d1,$3E(a0)
		tst.b	(Current_act).w
		beq.s	loc_57D18
		bset	#7,$A(a1)
		bra.s	loc_57D3C
; ---------------------------------------------------------------------------

loc_57D18:
		tst.w	(Player_mode).w
		bne.s	loc_57D3C
		jsr	(CreateNewSprite4).l
		bne.s	loc_57D3C
		move.l	#Obj_57DCC,(a1)
		move.w	$10(a0),$10(a1)
		move.w	d1,$3E(a1)
		move.w	#$C,$2C(a1)

loc_57D3C:

		clr.b	(Scroll_lock).w
		movea.w	$3C(a0),a1
		st	5(a1)
		move.l	#Obj_57D64,(a0)
		rts
; ---------------------------------------------------------------------------

loc_57D50:
		subi.w	#8,$14(a1)
		subq.b	#1,$2D(a0)
		beq.s	locret_57D62
		subi.w	#8,(Camera_Y_pos).w

locret_57D62:
		rts
; ---------------------------------------------------------------------------

Obj_57D64:
		jsr	(sub_45866).l
		lea	(Player_1).w,a1
		move.l	#$20000,d0
		move.l	#$800,d1
		jsr	Gradual_SwingOffset.w
		add.w	$3E(a0),d0
		move.w	d0,$14(a1)
		tst.l	$2E(a0)
		bmi.s	locret_57DA0
		clr.b	$2E(a1)
		clr.b	$20(a1)
		clr.b	(ScrEvents_4).w
		move.l	#loc_57DA2,(a0)

locret_57DA0:
		rts
; ---------------------------------------------------------------------------

loc_57DA2:
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	loc_57DC6
		cmp.w	(Camera_min_Y_pos).w,d0
		beq.s	loc_57DB6
		move.w	d0,(Camera_min_Y_pos).w

loc_57DB6:
		move.w	$3A(a0),d0
		or.b	$38(a0),d0
		bne.s	loc_57DC6
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_57DC6:

		jmp	(sub_45866).l
; ---------------------------------------------------------------------------

Obj_57DCC:
		lea	(Player_2).w,a1
		tst.w	$2C(a0)
		beq.s	loc_57DFA
		subq.w	#1,$2C(a0)
		bne.s	locret_57E32
		move.w	$10(a0),$10(a1)
		move.b	#1,$2E(a1)
		move.b	#2,$20(a1)
		bset	#2,$2A(a1)
		move.w	#-1,$1A(a1)

loc_57DFA:
		move.l	#$20000,d0
		move.l	#$800,d1
		jsr	Gradual_SwingOffset.w
		add.w	$3E(a0),d0
		move.w	d0,$14(a1)
		tst.l	$2E(a0)
		bmi.s	locret_57E32
		clr.b	$2E(a1)
		clr.b	$20(a1)
		clr.w	(Tails_Respawn_Ctr).w
		move.w	#6,(CPU_Routine).w
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

locret_57E32:

		rts
; ---------------------------------------------------------------------------

Obj_57E34:
		tst.w	$2C(a0)
		beq.s	loc_57E64
		subq.w	#1,$2C(a0)
		bne.s	locret_57E94
		jsr	Create_New_Sprite3.w
		bne.s	locret_57E94
		move.l	#Obj_CutsceneKnuckles,(a1)
		move.w	#$100,$10(a1)
		move.b	#$2C,$2C(a1)
		move.w	a1,$20(a0)
		move.w	#$C4E,$3E(a0)

loc_57E64:
		movea.w	$20(a0),a1
		move.l	#$20000,d0
		move.l	#$800,d1
		jsr	Gradual_SwingOffset.w
		add.w	$3E(a0),d0
		move.w	d0,$14(a1)
		tst.l	$2E(a0)
		bmi.s	locret_57E94
		bset	#0,(__u_FAB8).w
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

locret_57E94:

		rts
; ---------------------------------------------------------------------------


Obj_57E96:
		cmpi.b	#4,5(a0)
		bhi.s	loc_57EB0
		move.w	(Level_frame_counter).w,d0
		andi.w	#$F,d0
		bne.s	loc_57EB0
		moveq	#-$34,d0
		jsr	Play_Sound_2.w

loc_57EB0:

		moveq	#0,d0
		move.b	5(a0),d0
		jmp	loc_57EBA(pc,d0.w)
; ---------------------------------------------------------------------------

loc_57EBA:
		bra.w	loc_57ECA
; ---------------------------------------------------------------------------
		bra.w	loc_57EDC
; ---------------------------------------------------------------------------
		bra.w	loc_57F18
; ---------------------------------------------------------------------------
		bra.w	loc_57F3E
; ---------------------------------------------------------------------------

loc_57ECA:
		subq.w	#1,$2E(a0)
		bne.w	locret_57FBE
		move.w	#4,$30(a0)
		addq.b	#4,5(a0)

loc_57EDC:
		jsr	sub_57FC0(pc)
		cmpi.w	#$600,(Camera_Y_pos).w
		blo.w	locret_57FBE
		jsr	sub_57FE2(pc)
		cmpi.w	#$60C,(Camera_Y_pos).w
		blo.w	locret_57FBE
		lea	(Block_table+$18E0).w,a1
		lea	dword_577C6(pc),a5
		moveq	#4,d0

loc_57F02:
		move.l	(a5)+,(a1)+
		dbf	d0,loc_57F02
		moveq	#$59,d0
		jsr	Play_Sound_2.w
		addq.b	#4,5(a0)
		bra.w	locret_57FBE
; ---------------------------------------------------------------------------

loc_57F18:
		jsr	sub_57FC0(pc)
		jsr	sub_57FE2(pc)
		cmpi.w	#$640,(Camera_Y_pos).w
		blo.w	locret_57FBE
		move.w	#$F,$2E(a0)
		move.w	#8,$30(a0)
		clr.w	$32(a0)
		addq.b	#4,5(a0)

loc_57F3E:
		tst.w	(ScrEvents_1).w
		bpl.s	locret_57FBE
		tst.w	$2E(a0)
		beq.s	loc_57F5E
		subq.w	#1,$2E(a0)
		bne.s	locret_57FBE
		jsr	Create_New_Sprite.w
		bne.s	loc_57F5E
		move.l	#Obj_583BE,(a1)

loc_57F5E:

		cmpi.w	#$5C0,(Camera_Y_pos).w
		bhs.s	loc_57F7E
		jsr	sub_58048(pc)
		move.w	(Level_frame_counter).w,d0
		addq.w	#8,d0
		andi.w	#$F,d0
		bne.s	loc_57F7E
		moveq	#-$33,d0
		jsr	Play_Sound_2.w

loc_57F7E:

		move.w	#$500,d0
		moveq	#0,d1
		move.b	$30(a0),d1
		subq.w	#1,d1
		bcs.s	loc_57F94

loc_57F8C:
		subi.w	#$70,d0
		dbf	d1,loc_57F8C

loc_57F94:
		moveq	#0,d1
		move.b	$31(a0),d1
		sub.w	d1,d0
		move.w	(Camera_Y_pos).w,d1
		sub.w	d0,d1
		bcs.s	locret_57FBE
		cmpi.w	#2,d1
		bls.s	loc_57FAC
		moveq	#2,d1

loc_57FAC:
		sub.w	d1,(Camera_Y_pos).w
		cmpi.w	#$110,(Camera_Y_pos).w
		bhs.s	locret_57FBE
		move.w	#$110,(Camera_Y_pos).w

locret_57FBE:

		rts

; =============== S U B R O U T I N E =======================================


sub_57FC0:

		cmpi.w	#$618,(Camera_Y_pos).w
		blo.s	loc_57FD2
		btst	#0,(Level_frame_counter+1).w
		beq.s	locret_57FE0
		bra.s	loc_57FDC
; ---------------------------------------------------------------------------

loc_57FD2:
		move.w	(Level_frame_counter).w,d0
		andi.w	#3,d0
		beq.s	locret_57FE0

loc_57FDC:
		addq.w	#1,(Camera_Y_pos).w

locret_57FE0:

		rts
; End of function sub_57FC0


; =============== S U B R O U T I N E =======================================


sub_57FE2:

		lea	(Player_1).w,a1
		lea	(Ctrl_1_logical).w,a2
		lea	$30(a0),a3
		bsr.s	sub_58002
		tst.w	(Player_mode).w
		bne.s	locret_58046
		lea	(Player_2).w,a1
		lea	(Ctrl_2_logical).w,a2
		lea	$31(a0),a3
; End of function sub_57FE2


; =============== S U B R O U T I N E =======================================


sub_58002:
		tst.b	$2E(a1)
		bne.s	locret_58046
		tst.b	(a3)
		bmi.s	loc_58016
		subq.b	#1,(a3)
		bpl.s	locret_58046
		move.w	#$2020,(a2)
		rts
; ---------------------------------------------------------------------------

loc_58016:
		tst.w	$1A(a1)
		bmi.s	loc_58034
		move.w	#$7FFF,$14(a1)
		andi.b	#-4,4(a1)
		move.b	#3,$2E(a1)
		clr.b	$20(a1)
		bra.s	locret_58046
; ---------------------------------------------------------------------------

loc_58034:
		move.w	#$2800,d0
		cmpi.w	#$1A40,$10(a1)
		blo.s	loc_58044
		move.w	#$2400,d0

loc_58044:
		move.w	d0,(a2)

locret_58046:

		rts
; End of function sub_58002


; =============== S U B R O U T I N E =======================================


sub_58048:
		lea	(Player_1).w,a1
		lea	$30(a0),a2
		moveq	#0,d3
		cmpi.w	#2,(Player_mode).w
		bne.s	loc_5805C
		moveq	#-1,d3

loc_5805C:
		bsr.s	sub_5806E
		tst.w	(Player_mode).w
		bne.s	locret_58046
		lea	(Player_2).w,a1
		lea	$32(a0),a2
		moveq	#-1,d3
; End of function sub_58048


; =============== S U B R O U T I N E =======================================


sub_5806E:
		tst.w	4(a2)
		bne.w	loc_58192
		cmpi.w	#$910,(a2)
		bne.s	loc_580CC
		st	4(a2)
		move.b	#1,$2E(a1)
		bset	#1,$2A(a1)
		move.b	#1,$40(a1)
		move.b	#$E,$1E(a1)
		move.b	#7,$1F(a1)
		move.b	#2,$20(a1)
		bset	#2,$2A(a1)
		move.w	#$800,$1C(a1)
		move.w	#$400,$18(a1)
		move.w	#-$680,$1A(a1)
		clr.w	$12(a1)
		clr.w	$16(a1)
		moveq	#$62,d0
		jmp	Play_Sound_2.w
; ---------------------------------------------------------------------------

loc_580CC:
		moveq	#0,d0
		move.b	1(a2),d0
		addq.b	#1,d0
		cmpi.b	#$70,d0
		blo.s	loc_580E0
		subi.b	#$70,d0
		addq.b	#1,(a2)

loc_580E0:
		move.b	d0,1(a2)
		lea	byte_587B4(pc),a6
		move.b	(a6,d0.w),d0
		move.w	d0,d2
		andi.w	#$7FFF,$A(a1)
		addi.b	#$40,d2
		bmi.s	loc_58100
		ori.w	#-$8000,$A(a1)

loc_58100:
		jsr	GetSineCosine.w
		muls.w	#$4C00,d0
		swap	d0
		move.w	#$1A40,$10(a1)
		add.w	d0,$10(a1)
		muls.w	#$1C00,d1
		swap	d1
		subi.b	#$40,d2
		bpl.s	loc_58128
		neg.w	d1
		subi.w	#$38,d1

loc_58128:
		move.w	#$570,$14(a1)
		add.w	d1,$14(a1)
		lea	byte_58824(pc),a6
		moveq	#0,d0
		move.b	1(a2),d0
		move.b	(a6,d0.w),d0
		ext.w	d0
		sub.w	d0,$14(a1)
		moveq	#0,d0
		move.b	(a2),d0
		subq.w	#1,d0
		bcs.s	loc_58158

loc_5814E:
		subi.w	#$70,$14(a1)
		dbf	d0,loc_5814E

loc_58158:
		tst.w	d3
		beq.s	loc_58170
		addq.w	#4,$14(a1)
		move.w	#prio(2),8(a1)
		tst.b	d2
		bmi.s	loc_58170
		move.w	#prio(1),8(a1)

loc_58170:

		addi.w	#$A,d2
		andi.w	#$FF,d2
		move.w	d2,d0
		add.w	d2,d2
		add.w	d0,d2
		lsr.w	#6,d2
		lea	byte_587A8(pc),a2
		move.b	(a2,d2.w),d0
		move.b	d0,$22(a1)
		jmp	(Tails_Carry_LoadPLC).l
; ---------------------------------------------------------------------------

loc_58192:
		tst.w	4(a2)
		bpl.s	loc_581D2
		move.w	$18(a1),d0
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,$10(a1)
		move.w	$1A(a1),d0
		addi.w	#$38,$1A(a1)
		ext.l	d0
		lsl.l	#8,d0
		add.l	d0,$14(a1)
		tst.w	$1A(a1)
		bmi.s	locret_581F0
		move.b	#3,$2E(a1)
		clr.b	$22(a1)
		clr.b	$20(a1)
		move.w	#$B4,4(a2)
		bra.s	locret_581F0
; ---------------------------------------------------------------------------

loc_581D2:
		cmpa.w	#Player_1,a1
		bne.s	locret_581F0
		subq.w	#1,4(a2)
		bne.s	locret_581F0
		moveq	#-$1F,d0
		jsr	Play_Sound.w
		move.w	#$B00,d0
		jmp	StartNewLevel.w
; ---------------------------------------------------------------------------

locret_581F0:

		rts
; End of function sub_5806E

; ---------------------------------------------------------------------------

loc_581F2:
		move.l	#loc_5821E,(a0)
		move.b	#4,4(a0)
		move.b	#$1C,6(a0)
		move.w	#prio(1),8(a0)
		move.w	#-$3CB8,$A(a0)
		move.l	#Map_SSZCollapsingBridge,$C(a0)
		move.b	#9,$22(a0)

loc_5821E:
		move.w	$14(a0),d0
		subi.w	#$24,d0
		cmp.w	(Player_1+y_pos).w,d0
		bhs.w	loc_583A0
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

loc_58234:
		move.l	#loc_58260,(a0)
		move.b	#4,4(a0)
		move.b	#$18,6(a0)
		move.w	#prio(1),8(a0)
		move.w	#-$3D0C,$A(a0)
		move.l	#Map_SSZCollapsingBridge,$C(a0)
		move.b	#6,$22(a0)

loc_58260:
		move.w	$14(a0),d0
		move.b	$22(a0),d1
		subq.b	#6,d1
		beq.s	loc_58288
		subq.b	#1,d1
		beq.s	loc_5827E
		subi.w	#$2C,d0
		cmp.w	(Player_1+y_pos).w,d0
		blo.s	loc_582A6
		bra.w	loc_583A0
; ---------------------------------------------------------------------------

loc_5827E:
		moveq	#-$20,d1
		moveq	#8,d2
		subi.w	#$24,d0
		bra.s	loc_58290
; ---------------------------------------------------------------------------

loc_58288:
		moveq	#-$40,d1
		moveq	#$10,d2
		subi.w	#$1C,d0

loc_58290:
		cmp.w	(Player_1+y_pos).w,d0
		blo.s	loc_582A6
		addq.b	#1,$22(a0)
		jsr	Create_New_Sprite3.w
		bne.s	loc_582A6
		moveq	#8,d0
		bra.s	loc_5831E
; ---------------------------------------------------------------------------

loc_582A6:

		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

loc_582AC:
		move.l	#loc_582D8,(a0)
		move.b	#4,4(a0)
		move.b	#$18,6(a0)
		move.w	#prio(4),8(a0)
		move.w	#$42F4,$A(a0)
		move.l	#Map_SSZCollapsingBridge,$C(a0)
		move.b	#$B,$22(a0)

loc_582D8:
		move.w	$14(a0),d0
		move.b	$22(a0),d1
		subi.b	#$B,d1
		beq.s	loc_58302
		subq.b	#1,d1
		beq.s	loc_582F8
		subi.w	#$2C,d0
		cmp.w	(Player_1+y_pos).w,d0
		blo.s	loc_5835A
		bra.w	loc_583A0
; ---------------------------------------------------------------------------

loc_582F8:
		moveq	#$20,d1
		moveq	#8,d2
		subi.w	#$24,d0
		bra.s	loc_5830A
; ---------------------------------------------------------------------------

loc_58302:
		moveq	#$40,d1
		moveq	#$10,d2
		subi.w	#$1C,d0

loc_5830A:
		cmp.w	(Player_1+y_pos).w,d0
		blo.s	loc_5835A
		addq.b	#1,$22(a0)
		jsr	Create_New_Sprite3.w
		bne.s	loc_5835A
		moveq	#$D,d0

loc_5831E:
		move.l	#loc_583A6,(a1)
		move.b	#-$7C,4(a1)
		move.b	#$10,6(a1)
		move.w	8(a0),8(a1)
		move.w	$A(a0),$A(a1)
		move.l	$C(a0),$C(a1)
		move.b	d0,$22(a1)
		move.w	$10(a0),$10(a1)
		add.w	d1,$10(a1)
		move.w	$14(a0),$14(a1)
		add.w	d2,$14(a1)

loc_5835A:

		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

loc_58360:
		move.l	#loc_5838C,(a0)
		move.b	#4,4(a0)
		move.b	#$1C,6(a0)
		move.w	#prio(2),8(a0)
		move.w	#-$3CB8,$A(a0)
		move.l	#Map_SSZCollapsingBridge,$C(a0)
		move.b	#$A,$22(a0)

loc_5838C:
		move.w	$14(a0),d0
		subi.w	#$24,d0
		cmp.w	(Player_1+y_pos).w,d0
		bhs.s	loc_583A0
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

loc_583A0:

		move.l	#loc_583A6,(a0)

loc_583A6:

		tst.b	4(a0)
		bmi.s	loc_583B2
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_583B2:
		jsr	MoveSprite.w
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------

Obj_583BE:
		tst.w	(__u_EE98).w
		bne.s	loc_583C6
		rts
; ---------------------------------------------------------------------------

loc_583C6:
		move.l	#loc_583D2,(a0)
		move.w	#$870,$2E(a0)

loc_583D2:
		move.w	(Level_frame_counter).w,d0
		andi.w	#$F,d0
		bne.s	loc_583E4
		moveq	#-$34,d0
		jsr	Play_Sound_2.w

loc_583E4:
		tst.w	$30(a0)
		beq.s	loc_583F2
		subq.w	#1,$30(a0)
		bra.w	locret_584A0
; ---------------------------------------------------------------------------

loc_583F2:
		move.w	(Player_1+y_pos).w,d0
		cmpi.w	#$4000,d0
		blo.s	loc_58400
		move.w	#$5C0,d0

loc_58400:
		addi.w	#$198,d0
		move.w	$2E(a0),d1
		cmp.w	d1,d0
		bhi.w	locret_584A0
		move.w	d1,d0
		cmpi.w	#$300,d0
		bhs.s	loc_5841C
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_5841C:
		lsl.w	#4,d1
		andi.w	#$F00,d1
		addi.w	#-$2000,d1
		move.w	d1,(__u_EEFA).w
		lea	word_58894(pc),a2
		cmpi.w	#$380,d0
		blo.s	loc_58442
		lea	$80(a2),a2
		cmpi.w	#$800,d0
		blo.s	loc_58442
		lea	$80(a2),a2

loc_58442:

		lea	byte_58A3E(pc),a3
		move.w	$32(a0),d4
		addq.w	#3,$32(a0)
		move.w	d0,d1
		andi.w	#$70,d0
		adda.w	d0,a2
		subi.w	#$178,d1
		move.w	#$1A08,d2
		moveq	#7,d3
		jsr	Create_New_Sprite3.w
		bne.s	loc_58494

loc_58468:
		move.l	#loc_584A2,(a1)
		move.w	(a2)+,$A(a1)
		move.w	d2,$10(a1)
		move.w	d1,$14(a1)
		andi.w	#7,d4
		move.b	(a3,d4.w),$2E(a1)
		addq.w	#1,d4
		addi.w	#$10,d2
		jsr	(CreateNewSprite4).l
		dbne	d3,loc_58468

loc_58494:
		subi.w	#$10,$2E(a0)
		move.w	#7,$30(a0)

locret_584A0:

		rts
; ---------------------------------------------------------------------------

loc_584A2:
		move.w	$A(a0),d0
		bpl.s	loc_584BE
		clr.w	$A(a0)
		addq.w	#1,d0
		beq.s	loc_584E4
		move.b	#1,$22(a0)
		addq.w	#1,d0
		beq.s	loc_584BE
		addq.b	#1,$22(a0)

loc_584BE:

		move.l	#loc_584DE,(a0)
		move.b	#-$7C,4(a0)
		move.b	#8,6(a0)
		move.w	#prio(3),8(a0)
		move.l	#Map_SSZSpiralRampPieces,$C(a0)

loc_584DE:
		tst.b	4(a0)
		bmi.s	loc_584EA

loc_584E4:
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_584EA:
		tst.b	$2E(a0)
		beq.s	loc_584F6
		subq.b	#1,$2E(a0)
		bra.s	loc_584FC
; ---------------------------------------------------------------------------

loc_584F6:
		jsr	MoveSprite.w

loc_584FC:
		jmp	Draw_Sprite.w
; ---------------------------------------------------------------------------
SSZ1_BGDeformArray:
		dc.w $1D0
		dc.w $10
		dc.w 8
		dc.w $18
		dc.w $10
		dc.w $10
		dc.w 8
		dc.w $28
		dc.w $10
		dc.w 8
		dc.w 8
		dc.w $28
		dc.w 8
		dc.w $20
		dc.w 8
		dc.w 8
		dc.w 8
		dc.w $10
		dc.w $18
		dc.w $20
		dc.w $40
		dc.w $20
		dc.w $18
		dc.w $10
		dc.w 8
		dc.w 8
		dc.w 8
		dc.w $20
		dc.w 8
		dc.w $7FFF

; because SSZ is such an awesome level!
;SSZ_FloorCreate	macro flags, xpos, ypos, width, surface
;	dc.w flags, xpos+$98, ypos-$140, width/2, surface-byte_585B8
;    endm

SSZMini_SolidBG:	dc.w (SSZMain_SolidBG-SSZMini_SolidBG)/$A-1
	binclude "Levels/SSZ/Directions/XC Header.bin"

SSZMain_SolidBG:	dc.w (SSZ_SolidBG_Data-SSZMain_SolidBG)/$A-1
	binclude "Levels/SSZ/Directions/NC Header.bin"

SSZ_SolidBG_Data:
	binclude "Levels/SSZ/Directions/Chunk.bin"

word_58758:	dc.w	$10,   $30, $FE00,     1
		dc.w	$44,  $100, $9E00,     2
		dc.w	$78,   $B0, $E600,     1
		dc.w	$AC,  $1C0, $B600,     2
		dc.w	$D8,  $140, $CE00,     1
Map_SSZRoamingClouds:	include "Levels/SSZ/Misc Object Data/Map - Roaming Clouds.asm"

byte_587A8:	dc.b  $EF, $FA,	$F9, $F8, $F7, $F6, $F5, $F4, $F3, $F2,	$F1, $F0

byte_587B4:	dc.b    0,   2,   5,   7,   9,  $B,  $E, $10, $12, $15, $17, $19, $1B, $1E, $20, $22, $25, $27, $29, $2B
		dc.b  $2E, $30, $32, $35, $37, $39, $3B, $3E, $40, $42, $45, $47, $49, $4B, $4E, $50, $52, $55, $57, $59
		dc.b  $5B, $5E, $60, $62, $65, $67, $69, $6B, $6E, $70, $72, $75, $77, $79, $7B, $7E, $80, $82, $85, $87
		dc.b  $89, $8B, $8E, $90, $92, $95, $97, $99, $9B, $9E, $A0, $A2, $A5, $A7, $A9, $AB, $AE, $B0, $B2, $B5
		dc.b  $B7, $B9, $BB, $BE, $C0, $C2, $C5, $C7, $C9, $CB, $CE, $D0, $D2, $D5, $D7, $D9, $DB, $DE, $E0, $E2
		dc.b  $E5, $E7, $E9, $EB, $EE, $F0, $F2, $F5, $F7, $F9, $FB, $FE
byte_58824:	dc.b    3,   3,   4,   5,   6,   6,   7,   7,   8,   8,   8,   8,   7,   7,   7,   7,   7,   6,   5,   4
		dc.b    3,   3,   3,   2,   1,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, $FF, $FF, $FF, $FF, $FE
		dc.b  $FE, $FE, $FE, $FE, $FE, $FD, $FD, $FD, $FD, $FE, $FE, $FF, $FF,   0,   0,   2,   3,   4,   5,   6
		dc.b    7,   7,   8,   8,   9,   9,   9,   8,   7,   7,   7,   7,   7,   6,   5,   4,   3,   3,   3,   2
		dc.b    1,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, $FF, $FF, $FF, $FF, $FE, $FE, $FF, $FF, $FF
		dc.b  $FF, $FE, $FE, $FE, $FE, $FF, $FF,   0,   0,   0,   1,   3
word_58894:	dc.w $4000
		dc.w $4004
		dc.w $4008
		dc.w $400C
		dc.w $480C
		dc.w $4808
		dc.w $4804
		dc.w $4800
		dc.w $4010
		dc.w $4014
		dc.w $4018
		dc.w $401C
		dc.w $481C
		dc.w $4818
		dc.w $4814
		dc.w $4810
		dc.w $4020
		dc.w $4024
		dc.w $4028
		dc.w $402C
		dc.w $482C
		dc.w $4828
		dc.w $4824
		dc.w $4820
		dc.w $4020
		dc.w $4024
		dc.w $4028
		dc.w $402C
		dc.w $482C
		dc.w $4828
		dc.w $4824
		dc.w $4820
		dc.w $4030
		dc.w $4034
		dc.w $4038
		dc.w $403C
		dc.w $483C
		dc.w $4838
		dc.w $4834
		dc.w $4830
		dc.w $4040
		dc.w $4044
		dc.w $4048
		dc.w $404C
		dc.w $484C
		dc.w $4848
		dc.w $4844
		dc.w $4840
		dc.w $4020
		dc.w $4024
		dc.w $4028
		dc.w $402C
		dc.w $482C
		dc.w $4828
		dc.w $4824
		dc.w $4820
		dc.w $4040
		dc.w $4044
		dc.w $4048
		dc.w $404C
		dc.w $484C
		dc.w $4848
		dc.w $4844
		dc.w $4840
		dc.w $4020
		dc.w $4024
		dc.w $4028
		dc.w $402C
		dc.w $482C
		dc.w $4828
		dc.w $4824
		dc.w $4820
		dc.w $4040
		dc.w $4044
		dc.w $4048
		dc.w $404C
		dc.w $484C
		dc.w $4848
		dc.w $4844
		dc.w $4840
		dc.w $4020
		dc.w $4024
		dc.w $4028
		dc.w $402C
		dc.w $482C
		dc.w $4828
		dc.w $4824
		dc.w $4820
		dc.w $4020
		dc.w $4024
		dc.w $4028
		dc.w $402C
		dc.w $482C
		dc.w $4828
		dc.w $4824
		dc.w $4820
		dc.w $4030
		dc.w $4034
		dc.w $4038
		dc.w $403C
		dc.w $483C
		dc.w $4838
		dc.w $4834
		dc.w $4830
		dc.w $4040
		dc.w $4044
		dc.w $4048
		dc.w $404C
		dc.w $484C
		dc.w $4848
		dc.w $4844
		dc.w $4840
		dc.w $4020
		dc.w $4024
		dc.w $4028
		dc.w $402C
		dc.w $482C
		dc.w $4828
		dc.w $4824
		dc.w $4820
		dc.w $4040
		dc.w $4044
		dc.w $4048
		dc.w $404C
		dc.w $484C
		dc.w $4848
		dc.w $4844
		dc.w $4840
		dc.w $4020
		dc.w $4024
		dc.w $4028
		dc.w $402C
		dc.w $482C
		dc.w $4828
		dc.w $4824
		dc.w $4820
		dc.w $4040
		dc.w $4044
		dc.w $4048
		dc.w $404C
		dc.w $484C
		dc.w $4848
		dc.w $4844
		dc.w $4840
		dc.w $4020
		dc.w $4024
		dc.w $4028
		dc.w $402C
		dc.w $482C
		dc.w $4828
		dc.w $4824
		dc.w $4820
		dc.w $4040
		dc.w $4044
		dc.w $4048
		dc.w $404C
		dc.w $484C
		dc.w $4848
		dc.w $4844
		dc.w $4840
		dc.w $4020
		dc.w $4024
		dc.w $4028
		dc.w $402C
		dc.w $482C
		dc.w $4828
		dc.w $4824
		dc.w $4820
		dc.w $4040
		dc.w $4044
		dc.w $4048
		dc.w $404C
		dc.w $484C
		dc.w $4848
		dc.w $4844
		dc.w $4840
		dc.w $FFFE
		dc.w $4054
		dc.w $4058
		dc.w $405C
		dc.w $485C
		dc.w $4858
		dc.w $4854
		dc.w $FFFD
		dc.w $FFFF
		dc.w $FFFF
		dc.w $FFFE
		dc.w $4068
		dc.w $4868
		dc.w $FFFD
		dc.w $FFFF
		dc.w $FFFF
Map_SSZSpiralRampPieces:	include "Levels/SSZ/Misc Object Data/Map - Spiral Ramp Pieces.asm"

byte_58A3E:	dc.b  $1C
		dc.b	8
		dc.b  $10
		dc.b	0
		dc.b	4
		dc.b  $14
		dc.b  $18
		dc.b   $C
; ---------------------------------------------------------------------------

SSZ2_ScreenInit:
SSZ2_ScreenEvent:
SSZ2_BackgroundInit:
SSZ2_BackgroundEvent:
DEZ1_ScreenInit:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

DEZ1_ScreenEvent:
		tst.w	(ScrEvents_1).w
		beq.s	loc_59378
		clr.w	(ScrEvents_1).w
		movea.w	$14(a3),a1
		move.b	#-$43,$6E(a1)
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

loc_59378:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

DEZ1_BackgroundInit:
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy).w
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

DEZ1_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_593A0(pc,d0.w)
; ---------------------------------------------------------------------------

loc_593A0:
		bra.w	loc_593A8
; ---------------------------------------------------------------------------
		bra.w	loc_593EC
; ---------------------------------------------------------------------------

loc_593A8:
		tst.w	(ScrEvents_2).w
		beq.s	loc_593E6
		clr.w	(ScrEvents_2).w
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(DEZ2_16x16_Secondary_Kos).l,a1
		lea	(Block_table+$15E0).w,a2
		jsr	Queue_Kos.w
		lea	(ArtKosM_DEZ2_Secondary).l,a1
		move.w	#$5240,d2
		jsr	Queue_Kos_Module.w
		moveq	#$38,d0
		jsr	Load_PLC.w
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(TrigEvents_Routine).w

loc_593E6:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

loc_593EC:
		tst.b	(Kos_modules_left).w
		bne.w	loc_59488
		move.w	#$B01,(Current_zone_and_act).w
		clr.b	(Dynamic_resize_routine).w
		clr.b	(Object_load_routine).w
		clr.b	(Rings_manager_routine).w
		clr.b	(Boss_flag).w
		clr.b	(NoReset_RespawnTbl).w
		jsr	Clear_Switches.w
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(Load_Level).l
		jsr	(LoadSolids).l
		lea	(Normal_palette_line_3).w,a0
		lea	(Pal_DEZ2+$20).l,a1
		moveq	#$F,d0

loc_59430:
		move.l	(a1)+,(a0)+
		dbf	d0,loc_59430
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$3600,d0
		move.w	#-$400,d1
		sub.w	d0,(Player_1+x_pos).w
		sub.w	d1,(Player_1+y_pos).w
		sub.w	d0,(Player_2+x_pos).w
		sub.w	d1,(Player_2+y_pos).w
		jsr	(Offset_ObjectsDuringTransition).l
		sub.w	d0,(Camera_X_pos).w
		sub.w	d1,(Camera_Y_pos).w
		sub.w	d0,(Camera_X_pos_copy).w
		sub.w	d1,(Camera_Y_pos_copy).w
		sub.w	d0,(Camera_min_X_pos).w
		sub.w	d0,(Camera_max_X_pos).w
		sub.w	d1,(Camera_min_Y_pos).w
		sub.w	d1,(Camera_max_Y_pos).w
		move.w	(Camera_max_Y_pos).w,(Camera_target_max_Y_pos).w
		jsr	(Reset_TileOffsetPositionActual).l
		clr.w	(TrigEvents_Routine).w

loc_59488:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

DEZ2_ScreenInit:
		move.w	#4,(ScrEvents_Routine).w
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

DEZ2_ScreenEvent:
		move.w	(ScrEvents_Routine).w,d0
		jmp	loc_594A8(pc,d0.w)
; ---------------------------------------------------------------------------

loc_594A8:
		bra.w	loc_594B4
; ---------------------------------------------------------------------------
		bra.w	loc_594DA
; ---------------------------------------------------------------------------
		bra.w	loc_594F8
; ---------------------------------------------------------------------------

loc_594B4:
		tst.w	(ScrEvents_1).w
		beq.s	loc_594F8
		clr.w	(ScrEvents_1).w
		movea.w	$38(a3),a1
		addq.w	#1,a1
		move.b	#-$29,(a1)+
		move.b	#-$24,(a1)+
		move.b	#-$29,(a1)
		addq.w	#4,(ScrEvents_Routine).w
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

loc_594DA:
		tst.w	(ScrEvents_1).w
		beq.s	loc_594F8
		clr.w	(ScrEvents_1).w
		movea.w	$18(a3),a1
		move.b	#-$44,$6B(a1)
		addq.w	#4,(ScrEvents_Routine).w
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

loc_594F8:

		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

DEZ2_BackgroundInit:
		move.w	#8,(TrigEvents_Routine).w
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy).w
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

DEZ2_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_59526(pc,d0.w)
; ---------------------------------------------------------------------------

loc_59526:
		bra.w	loc_59532
; ---------------------------------------------------------------------------
		bra.w	loc_59556
; ---------------------------------------------------------------------------
		bra.w	loc_59566
; ---------------------------------------------------------------------------

loc_59532:
		clr.w	(Camera_X_pos_BG_copy).w
		clr.w	(Camera_Y_pos_BG_copy).w
		jsr	(Reset_TileOffsetPositionEff).l
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w

loc_59556:
		moveq	#0,d1
		moveq	#0,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_59566
		addq.w	#4,(TrigEvents_Routine).w

loc_59566:

		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

DDZ_ScreenInit:
DDZ_BackgroundInit:
DDZ_BackgroundEvent:
Pachinko_ScreenInit:
Pachinko_ScreenEvent:
Pachinko_BackgroundInit:
Pachinko_BackgroundEvent:
Slots_ScreenInit:
Slots_ScreenEvent:
Slots_BackgroundInit:
Slots_BackgroundEvent:
LRZ3_ScreenInit:
		clr.w	(Camera_max_X_pos).w
		lea	(Player_1).w,a1
		cmpi.w	#$480,$10(a1)
		blo.s	loc_59AF8
		lea	(Target_palette_line_2).w,a1
		lea	(Pal_LRZBossFire).l,a5
		moveq	#$17,d0

loc_59A9A:
		move.l	(a5)+,(a1)+
		dbf	d0,loc_59A9A
		move.w	#$9C0,$10(a1)
		move.w	#$36C,$14(a1)
		move.w	#$920,d0
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_X_pos).w
		clr.w	(Camera_X_pos+$2).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		move.w	#$2F0,d0
		move.w	d0,(Camera_Y_pos_copy).w
		move.w	d0,(Camera_Y_pos).w
		clr.w	(Camera_Y_pos+$2).w
		move.w	d0,(Camera_min_Y_pos).w
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		move.w	#$14,(Special_Events_Routine).w
		move.w	#$10,(ScrEvents_Routine2).w
		move.w	#$2D,(ScrEvents_3).w
		move.w	#$C,(ScrEvents_Routine).w

loc_59AF8:
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

LRZ3_ScreenEvent:
		move.w	(ScrEvents_Routine).w,d0
		jmp	loc_59B0C(pc,d0.w)
; ---------------------------------------------------------------------------

loc_59B0C:
		bra.w	loc_59B1C
; ---------------------------------------------------------------------------
		bra.w	loc_59B46
; ---------------------------------------------------------------------------
		bra.w	loc_59B88
; ---------------------------------------------------------------------------
		bra.w	loc_59BA4
; ---------------------------------------------------------------------------

loc_59B1C:
		move.w	(Act3_TempRings).w,d0
		beq.s	loc_59B30
		clr.w	(Act3_TempRings).w
		move.b	d0,(Ring_count).w
		move.b	#1,(Update_HUD_ring_count).w

loc_59B30:
		move.l	(Act3_TempTime).w,d0
		beq.s	loc_59B42
		clr.l	(Act3_TempTime).w
		move.l	d0,(Timer).w
		st	(Update_HUD_timer).w

loc_59B42:
		addq.w	#4,(ScrEvents_Routine).w

loc_59B46:
		tst.w	(ScrEvents_1).w
		beq.s	loc_59B78
		clr.w	(ScrEvents_1).w
		movea.w	$24(a3),a1
		move.b	#$16,(a1)+
		move.b	#$15,(a1)+
		move.b	#$16,(a1)+
		move.b	#$15,(a1)+
		move.b	#$16,(a1)
		addq.w	#4,(ScrEvents_Routine).w
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

loc_59B78:
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	loc_59BA4
		move.w	d0,(Camera_min_Y_pos).w
		bra.s	loc_59BA4
; ---------------------------------------------------------------------------

loc_59B88:
		tst.w	(ScrEvents_1).w
		beq.s	loc_59BA4
		clr.w	(ScrEvents_1).w
		clr.w	(Camera_X_pos+$2).w
		clr.w	(Camera_Y_pos+$2).w
		move.w	#$14,(Special_Events_Routine).w
		addq.w	#4,(ScrEvents_Routine).w

loc_59BA4:

		move.w	(ScrEvents_8).w,d1
		beq.s	loc_59BF4
		move.w	d1,d3
		lsr.w	#7,d3
		move.w	(ScrEvents_9).w,d0
		move.w	d0,d2
		lsr.w	#5,d2
		andi.w	#-4,d2
		movea.w	(a3,d2.w),a1
		move.b	#$17,(a1,d3.w)
		move.b	#$17,1(a1,d3.w)
		moveq	#-$80,d2
		and.w	d2,d0
		and.w	d2,d1
		moveq	#$30,d2
		add.w	d2,d0
		add.w	d2,d1
		moveq	#$A,d6
		moveq	#4,d2

loc_59BDA:
		movem.w	d0-d2/d6,-(sp)
		jsr	(Setup_TileRowDraw).l
		movem.w	(sp)+,d0-d2/d6
		addi.w	#$10,d0
		dbf	d2,loc_59BDA
		clr.w	(ScrEvents_8).w

loc_59BF4:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

LRZ3_BackgroundInit:
		jsr	Create_New_Sprite.w
		bne.s	loc_59C08
		move.l	#Obj_59FC4,(a1)

loc_59C08:
		lea	(Block_table+$1800).w,a1
		move.l	#$600050,d0
		moveq	#$13,d1

loc_59C14:
		move.l	d0,(a1)+
		dbf	d1,loc_59C14
		lea	(Block_table+$1900).w,a1
		move.l	#$30303030,d0
		moveq	#$2F,d1

loc_59C26:
		move.l	d0,(a1)+
		dbf	d1,loc_59C26
		move.w	(a3),$7C(a3)
		jsr	sub_59D82(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		jmp	sub_59DDE(pc)
; ---------------------------------------------------------------------------

LRZ3_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_59C4C(pc,d0.w)
; ---------------------------------------------------------------------------

loc_59C4C:
		bra.w	loc_59C60
; ---------------------------------------------------------------------------
		bra.w	loc_59C8C
; ---------------------------------------------------------------------------
		bra.w	loc_59D02
; ---------------------------------------------------------------------------
		bra.w	loc_59D24
; ---------------------------------------------------------------------------
		bra.w	loc_59D74
; ---------------------------------------------------------------------------

loc_59C60:
		cmpi.w	#$500,(Camera_Y_pos).w
		blo.s	loc_59C6E
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_59C8C
; ---------------------------------------------------------------------------

loc_59C6E:
		jsr	sub_59D82(pc)

loc_59C72:

		jsr	(DrawBGAsYouMove).l
		move.w	(ScrEvents_4).w,d0
		beq.s	loc_59C88
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(ScrEvents_5).w,(Camera_Y_pos_BG_copy).w

loc_59C88:
		jmp	sub_59DDE(pc)
; ---------------------------------------------------------------------------

loc_59C8C:

		cmpi.w	#$500,(Camera_Y_pos).w
		blo.s	loc_59CD8
		cmpi.w	#$A00,(Camera_X_pos).w
		bne.s	loc_59CCA
		move.w	(Camera_Y_pos).w,d0
		cmp.w	(Camera_max_Y_pos).w,d0
		bne.s	loc_59CCA
		move.w	#$A00,(Camera_max_X_pos).w
		move.w	d0,(Camera_min_Y_pos).w
		jsr	Create_New_Sprite.w
		bne.s	loc_59CBE
		move.l	#Obj_LRZEndBoss,(a1)

loc_59CBE:
		move.w	#4,(Special_V_int_routine).w
		addq.w	#8,(TrigEvents_Routine).w
		bra.s	loc_59D24
; ---------------------------------------------------------------------------

loc_59CCA:

		jsr	sub_59DA2(pc)
		jsr	(DrawBGAsYouMove).l
		jmp	sub_59DDE(pc)
; ---------------------------------------------------------------------------

loc_59CD8:
		move.w	(Camera_X_pos_BG_copy).w,(ScrEvents_4).w
		move.w	(Camera_Y_pos_BG_copy).w,(ScrEvents_5).w
		jsr	sub_59D82(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_59D06
; ---------------------------------------------------------------------------

loc_59D02:
		jsr	sub_59D82(pc)

loc_59D06:
		move.w	(Camera_X_pos_BG_copy).w,d1
		move.w	(Camera_Y_pos_BG_copy).w,d2
		jsr	(Draw_PlaneVertTopDown).l
		bpl.w	loc_59C72
		clr.w	(ScrEvents_4).w
		clr.w	(TrigEvents_Routine).w
		bra.w	loc_59C72
; ---------------------------------------------------------------------------

loc_59D24:

		tst.w	(ScrEvents_2).w
		beq.s	loc_59D30
		tst.w	(ScrEvents_7).w
		beq.s	loc_59D66

loc_59D30:
		jsr	sub_59DBC(pc)
		lea	word_5A106(pc),a4
		lea	(Block_table+$1800).w,a5
		moveq	#$F,d6
		moveq	#$14,d5
		jsr	(DrawTilesVDeform2).l
		jsr	sub_59DDE(pc)
		lea	(VScrollBuffer).w,a1
		lea	(Block_table+$1800).w,a5
		move.w	(Camera_Y_pos_copy).w,d0
		swap	d0
		moveq	#$13,d1

loc_59D5A:
		move.w	(a5),d0
		move.l	d0,(a1)+
		addq.w	#4,a5
		dbf	d1,loc_59D5A
		rts
; ---------------------------------------------------------------------------

loc_59D66:
		clr.w	(ScrEvents_2).w
		move.w	#$C,(Special_V_int_routine).w
		addq.w	#4,(TrigEvents_Routine).w

loc_59D74:
		jsr	sub_59DA2(pc)
		jsr	(DrawBGAsYouMove).l
		jmp	sub_59DDE(pc)

; =============== S U B R O U T I N E =======================================


sub_59D82:

		move.w	(Camera_Y_pos_copy).w,d0
		asr.w	#4,d0
		addi.w	#$10,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		asr.w	#4,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		asr.w	#1,d0
		move.w	d0,(ScrEvents_B).w
		rts
; End of function sub_59D82


; =============== S U B R O U T I N E =======================================


sub_59DA2:

		move.w	(Camera_X_pos_copy).w,d0
		subi.w	#$700,d0
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(Camera_Y_pos_copy).w,d0
		subi.w	#$500,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		rts
; End of function sub_59DA2


; =============== S U B R O U T I N E =======================================


sub_59DBC:
		bsr.s	sub_59DA2
		lea	(Block_table+$1800).w,a1
		lea	$113(a1),a5
		moveq	#$30,d1
		moveq	#$13,d2

loc_59DCA:
		moveq	#0,d3
		move.b	(a5),d3
		sub.w	d1,d3
		add.w	d0,d3
		move.w	d3,(a1)
		addq.w	#4,a1
		addq.w	#8,a5
		dbf	d2,loc_59DCA
		rts
; End of function sub_59DBC


; =============== S U B R O U T I N E =======================================


sub_59DDE:

		tst.b	(Title_Card_Out_Flag).w
		bne.s	loc_59DF2
		tst.b	(__u_FACD).w
		bne.s	loc_59DF2
		cmpi.w	#8,(ScrEvents_Routine).w
		bhs.s	loc_59DF8

loc_59DF2:
		jmp	(PlainDeformation).l
; ---------------------------------------------------------------------------

loc_59DF8:
		lea	(H_scroll_buffer).w,a1
		lea	(word_5077E).l,a5
		lea	(a5),a6
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(Level_frame_counter).w,d1
		add.w	d1,d1
		add.w	d1,d0
		andi.w	#$3E,d0
		adda.w	d0,a5
		move.w	(Camera_Y_pos_BG_copy).w,d0
		asr.w	#1,d1
		add.w	d1,d0
		andi.w	#$3E,d0
		adda.w	d0,a6
		move.w	(Camera_X_pos_copy).w,d0
		neg.w	d0
		move.w	(Camera_X_pos_BG_copy).w,d1
		neg.w	d1
		move.w	#$DF,d2

loc_59E34:
		move.w	(a5)+,d3
		add.w	d0,d3
		move.w	d3,(a1)+
		move.w	(a6)+,d3
		add.w	d1,d3
		move.w	d3,(a1)+
		dbf	d2,loc_59E34
		rts
; End of function sub_59DDE

; ---------------------------------------------------------------------------

loc_59E46:
		tst.w	(ScrEvents_3).w
		beq.s	loc_59E52
		subq.w	#1,(ScrEvents_3).w
		rts
; ---------------------------------------------------------------------------

loc_59E52:
		st	(Scroll_lock).w
		move.w	(ScrEvents_Routine2).w,d0
		jmp	loc_59E5E(pc,d0.w)
; ---------------------------------------------------------------------------

loc_59E5E:
		bra.w	loc_59E7A
; ---------------------------------------------------------------------------
		bra.w	loc_59E90
; ---------------------------------------------------------------------------
		bra.w	loc_59EA8
; ---------------------------------------------------------------------------
		bra.w	loc_59EBE
; ---------------------------------------------------------------------------
		bra.w	loc_59ED4
; ---------------------------------------------------------------------------
		bra.w	loc_59EE8
; ---------------------------------------------------------------------------
		bra.w	loc_59F00
; ---------------------------------------------------------------------------

loc_59E7A:
		move.l	#$20000,d2
		moveq	#0,d1
		cmpi.w	#$410,(Camera_X_pos).w
		blo.w	loc_59F3C
		addq.w	#4,(ScrEvents_Routine2).w

loc_59E90:
		move.l	#$16A00,d2
		move.l	d2,d1
		neg.l	d1
		cmpi.w	#$330,(Camera_Y_pos).w
		bhi.w	loc_59F3C
		addq.w	#4,(ScrEvents_Routine2).w

loc_59EA8:
		move.l	#$20000,d2
		moveq	#0,d1
		cmpi.w	#$650,(Camera_X_pos).w
		blo.w	loc_59F3C
		addq.w	#4,(ScrEvents_Routine2).w

loc_59EBE:
		move.l	#$16A00,d2
		move.l	d2,d1
		neg.l	d1
		cmpi.w	#$2F0,(Camera_Y_pos).w
		bhi.s	loc_59F3C
		addq.w	#4,(ScrEvents_Routine2).w

loc_59ED4:
		move.l	#$20000,d2
		moveq	#0,d1
		cmpi.w	#$910,(Camera_X_pos).w
		blo.s	loc_59F3C
		addq.w	#4,(ScrEvents_Routine2).w

loc_59EE8:
		move.l	#$1D900,d2
		move.l	#$C400,d1
		cmpi.w	#$320,(Camera_Y_pos).w
		blo.s	loc_59F3C
		addq.w	#4,(ScrEvents_Routine2).w

loc_59F00:
		move.l	#$20000,d2
		moveq	#0,d1
		cmpi.w	#$BBF,(Camera_X_pos).w
		blo.s	loc_59F3C
		moveq	#0,d2
		cmpi.w	#$C50,(Player_1+x_pos).w
		blo.s	loc_59F3C
		move.w	#$A00,(Camera_min_X_pos).w
		move.w	#$BC0,(Camera_max_X_pos).w
		move.w	#$560,d0
		move.w	d0,(Camera_max_Y_pos).w
		move.w	d0,(Camera_target_max_Y_pos).w
		clr.b	(Scroll_lock).w
		clr.w	(Special_Events_Routine).w
		rts
; ---------------------------------------------------------------------------

loc_59F3C:

		add.l	d1,(Camera_Y_pos).w
		move.w	(Camera_Y_pos).w,d1
		move.w	d1,(Camera_Y_pos).w
		move.w	d1,(Camera_Y_pos_copy).w
		move.w	d1,(Camera_min_Y_pos).w
		move.w	d1,(Camera_max_Y_pos).w
		move.w	d1,(Camera_target_max_Y_pos).w
		add.l	d2,(Camera_X_pos).w
		move.w	(Camera_X_pos).w,d0
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(Camera_min_X_pos).w
		move.w	d0,(Camera_max_X_pos).w
		movem.w	d0/d2,-(sp)
		lea	(Player_1).w,a1
		bsr.s	sub_59F82
		movem.w	(sp)+,d0/d2
		lea	(Player_2).w,a1

; =============== S U B R O U T I N E =======================================


sub_59F82:
		cmpi.b	#5,$20(a1)
		bne.s	loc_59F8E
		clr.b	$20(a1)

loc_59F8E:
		addi.w	#$10,d0
		cmp.w	$10(a1),d0
		bls.s	loc_59FB4
		btst	#5,$2A(a1)
		beq.s	loc_59FA8
		lea	(a1),a0
		jmp	(Kill_Character).l
; ---------------------------------------------------------------------------

loc_59FA8:
		move.w	d0,$10(a1)
		asr.l	#8,d2
		move.w	d2,$1C(a1)
		bra.s	locret_59FC2
; ---------------------------------------------------------------------------

loc_59FB4:
		addi.w	#$110,d0
		cmp.w	$10(a1),d0
		bhi.s	locret_59FC2
		move.w	d0,$10(a1)

locret_59FC2:

		rts
; End of function sub_59F82

; ---------------------------------------------------------------------------

Obj_59FC4:
		move.l	#loc_59FDC,(a0)
		move.b	#-$40,6(a0)
		move.w	#$640,$14(a0)
		bset	#7,$2A(a0)

loc_59FDC:
		cmpi.w	#$C,(TrigEvents_Routine).w
		bne.w	loc_5A07A
		move.w	(ScrEvents_7).w,d0
		tst.b	(ScrEvents_6+$1).w
		beq.s	loc_59FFA
		cmpi.w	#$80,d0
		bhs.s	loc_5A000
		addq.w	#1,d0
		bra.s	loc_5A000
; ---------------------------------------------------------------------------

loc_59FFA:
		tst.w	d0
		beq.s	loc_5A000
		subq.w	#1,d0

loc_5A000:

		move.w	d0,(ScrEvents_7).w
		swap	d0
		clr.w	d0
		asr.l	#8,d0
		move.w	d0,d1
		swap	d0
		moveq	#$30,d2
		moveq	#0,d3
		move.w	#$AF,d4
		tst.b	(ScrEvents_6).w
		bne.s	loc_5A040
		lea	(Block_table+$1910).w,a1

loc_5A020:
		move.b	d2,(a1)+
		add.w	d1,d3
		addx.w	d0,d2
		dbf	d4,loc_5A020
		moveq	#$30,d2
		moveq	#0,d3
		moveq	#$F,d4
		lea	(Block_table+$1910).w,a1

loc_5A034:
		sub.w	d1,d3
		subx.w	d0,d2
		move.b	d2,-(a1)
		dbf	d4,loc_5A034
		bra.s	loc_5A062
; ---------------------------------------------------------------------------

loc_5A040:
		lea	(Block_table+$19B0).w,a1

loc_5A044:
		move.b	d2,-(a1)
		add.w	d1,d3
		addx.w	d0,d2
		dbf	d4,loc_5A044
		moveq	#$30,d2
		moveq	#0,d3
		moveq	#$F,d4
		lea	(Block_table+$19B0).w,a1

loc_5A058:
		sub.w	d1,d3
		subx.w	d0,d2
		move.b	d2,(a1)+
		dbf	d4,loc_5A058

loc_5A062:
		move.w	#$A0,d1
		lea	(Block_table+$1910).w,a2
		move.w	#$AA0,d4
		move.w	d4,$10(a0)
		jsr	SolidObjectTopSloped2.w
		bra.s	loc_5A094
; ---------------------------------------------------------------------------

loc_5A07A:
		move.w	#$180,d1
		move.w	#$40,d2
		move.w	#$30,d3
		move.w	#$B80,d4
		move.w	d4,$10(a0)
		jsr	SolidObjectTop.w

loc_5A094:
		move.w	(ScrEvents_7).w,d0
		swap	d0
		clr.w	d0
		lsr.l	#7,d0
		move.l	d0,d1
		lsr.l	#1,d1
		add.l	d1,d0
		tst.b	(ScrEvents_6).w
		bne.s	loc_5A0AC
		neg.l	d0

loc_5A0AC:
		move.l	d0,(ScrEvents_C).w
		btst	#3,$2A(a0)
		beq.s	loc_5A0DE
		lea	(Player_1).w,a1
		tst.b	(Title_Card_Out_Flag).w
		bne.s	loc_5A0D6
		btst	#4,$2B(a1)
		bne.s	loc_5A0D6
		tst.b	(__u_FACD).w
		bne.s	loc_5A0D6
		jsr	sub_24280.w

loc_5A0D6:

		move.l	(ScrEvents_C).w,d0
		add.l	d0,$10(a1)

loc_5A0DE:
		btst	#4,$2A(a0)
		beq.s	locret_5A104
		lea	(Player_2).w,a1
		tst.b	(Title_Card_Out_Flag).w
		bne.s	loc_5A0FC
		tst.b	(__u_FACD).w
		bne.s	loc_5A0FC
		jsr	sub_24280.w

loc_5A0FC:

		move.l	(ScrEvents_C).w,d0
		add.l	d0,$10(a1)

locret_5A104:
		rts
; ---------------------------------------------------------------------------
word_5A106:	dc.w $310
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $10
		dc.w $7FFF
; ---------------------------------------------------------------------------

HPZ_ScreenInit:
		cmpi.b	#6,PlayMode.w		; NAT: If miniga,e ignore bad code
		beq.s	loc_5A14C
		cmpi.w	#$480,(Player_1+y_pos).w
		bhs.s	loc_5A14C
		move.w	#$AA0,(Camera_min_X_pos).w

loc_5A14C:

		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

HPZ_ScreenEvent:
		tst.w	(ScrEvents_Routine2).w
		bne.s	loc_5A176
		tst.w	(Palette_fade_timer).w
		bne.s	loc_5A176
		jsr	Create_New_Sprite.w
		bne.s	loc_5A172
		move.l	#Obj_B1_2,(a1)

loc_5A172:
		st	(ScrEvents_Routine2).w

loc_5A176:

		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		tst.w	(ScrEvents_1).w
		beq.s	loc_5A19E
		clr.w	(ScrEvents_1).w
		movea.w	$1C(a3),a1
		move.b	#$61,$30(a1)
		move.b	#$61,$31(a1)
		jmp	(Refresh_PlaneScreenDirect).l
; ---------------------------------------------------------------------------

loc_5A19E:
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

HPZ_BackgroundInit:
		move.w	$14(a3),$18(a3)
		cmpi.w	#3,(Player_mode).w
		bne.s	loc_5A1C2
		movea.w	4(a3),a1
		move.b	#-$72,3(a1)
		move.b	#-$71,4(a1)

loc_5A1C2:
		cmpi.w	#$EC0,(Player_1+x_pos).w
		bhs.s	loc_5A1D0
		jsr	sub_5A32C(pc)
		bra.s	loc_5A1DA
; ---------------------------------------------------------------------------

loc_5A1D0:
		move.w	#8,(TrigEvents_Routine).w
		jsr	sub_5A334(pc)

loc_5A1DA:
		jsr	(Reset_TileOffsetPositionEff).l
		lea	(Block_table+$1800).w,a1
		move.w	(a1)+,(a1)
		andi.w	#-$10,(a1)+
		move.w	(a1)+,(a1)
		andi.w	#-$10,(a1)
		lea	HPZ_BGDrawArray(pc),a4
		lea	(Block_table+$1800).w,a5
		jsr	(Refresh_PlaneTileDeform).l
		lea	HPZ_BGDeformArray(pc),a4
		lea	(Block_table+$1808).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

HPZ_BackgroundEvent:
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_5A214(pc,d0.w)
; ---------------------------------------------------------------------------

loc_5A214:
		bra.w	loc_5A224
; ---------------------------------------------------------------------------
		bra.w	loc_5A288
; ---------------------------------------------------------------------------
		bra.w	loc_5A2A6
; ---------------------------------------------------------------------------
		bra.w	loc_5A30A
; ---------------------------------------------------------------------------

loc_5A224:
		cmpi.w	#$EC0,(Player_1+x_pos).w
		blo.s	loc_5A25E
		jsr	sub_5A334(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		lea	(Block_table+$1800).w,a1
		move.w	(a1)+,(a1)
		andi.w	#-$10,(a1)+
		move.w	(a1)+,(a1)
		andi.w	#-$10,(a1)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_5A28C
; ---------------------------------------------------------------------------

loc_5A25E:
		jsr	sub_5A32C(pc)

loc_5A262:

		lea	HPZ_BGDrawArray(pc),a4
		lea	(Block_table+$1800).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	(Draw_BG).l
		lea	HPZ_BGDeformArray(pc),a4
		lea	(Block_table+$1808).w,a5
		jsr	(ApplyDeformation).l
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

loc_5A288:
		jsr	sub_5A334(pc)

loc_5A28C:
		lea	HPZ_BGDrawArray(pc),a4
		lea	(Block_table+$17FC).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	(Draw_PlaneVertBottomUpComplex).l
		bpl.s	loc_5A2E4
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_5A2E4
; ---------------------------------------------------------------------------

loc_5A2A6:
		cmpi.w	#$EC0,(Player_1+x_pos).w
		bhs.s	loc_5A2E0
		jsr	sub_5A32C(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		lea	(Block_table+$1800).w,a1
		move.w	(a1)+,(a1)
		andi.w	#-$10,(a1)+
		move.w	(a1)+,(a1)
		andi.w	#-$10,(a1)
		addi.w	#$E0,d0
		and.w	(Camera_Y_pos_mask).w,d0
		move.w	d0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		addq.w	#4,(TrigEvents_Routine).w
		bra.s	loc_5A30E
; ---------------------------------------------------------------------------

loc_5A2E0:
		jsr	sub_5A334(pc)

loc_5A2E4:

		lea	HPZ_BGDrawArray(pc),a4
		lea	(Block_table+$1800).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	(Draw_BG).l
		lea	HPZ_BGDeformArray(pc),a4
		lea	(Block_table+$1808).w,a5
		jsr	(ApplyDeformation).l
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

loc_5A30A:
		jsr	sub_5A32C(pc)

loc_5A30E:
		lea	HPZ_BGDrawArray(pc),a4
		lea	(Block_table+$17FC).w,a5
		move.w	(Camera_Y_pos_BG_copy).w,d1
		jsr	(Draw_PlaneVertBottomUpComplex).l
		bpl.w	loc_5A262
		clr.w	(TrigEvents_Routine).w
		bra.w	loc_5A262

; =============== S U B R O U T I N E =======================================


sub_5A32C:

		move.w	#$348,d2
		moveq	#0,d3
		bra.s	loc_5A33C
; End of function sub_5A32C


; =============== S U B R O U T I N E =======================================


sub_5A334:

		move.w	#$E00,d2
		move.w	#$700,d3

loc_5A33C:
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(ScrShake_Offset).w,d4
		sub.w	d4,d0
		add.w	d3,d0
		swap	d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		add.l	d0,d0
		add.l	d1,d0
		swap	d0
		add.w	d4,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		sub.w	d2,d0
		swap	d0
		clr.w	d0
		move.l	d0,d2
		asr.l	#4,d0
		move.l	d0,d1
		add.l	d0,d0
		add.l	d1,d0
		swap	d0
		move.w	d0,(Block_table+$1800).w
		move.w	d0,(Block_table+$1808).w
		lea	(Block_table+$181C).w,a1
		move.l	d2,d0
		asr.l	#2,d2
		sub.l	d2,d0
		asr.l	#2,d2
		moveq	#8,d1

loc_5A388:
		swap	d0
		move.w	d0,-(a1)
		swap	d0
		sub.l	d2,d0
		dbf	d1,loc_5A388
		move.w	(Block_table+$181A).w,(Block_table+$1804).w
		rts
; End of function sub_5A334

; ---------------------------------------------------------------------------
HPZ_BGDrawArray:
		dc.w $200
		dc.w $7FFF
HPZ_BGDeformArray:
		dc.w $198
		dc.w 8
		dc.w 4
		dc.w 4
		dc.w 8
		dc.w 8
		dc.w $10
		dc.w 8
		dc.w $30
		dc.w $7FFF
; ---------------------------------------------------------------------------

DEZ3_ScreenInit:
		clr.w	(ScrEvents_A).w
		st	(ScrEvents_B).w
		move.b	#10,SpawnWait.w		; NAT: Set spawn wait timer

		jsr	sub_5A79E(pc)
		move.w	(a3),d0
		move.w	d0,$10(a3)
		move.w	d0,$12(a3)
		move.w	d0,$7C(a3)
		move.w	d0,$7E(a3)
		lea	(Level_layout_main+$2).w,a3
		move.w	#-$2000,d7
		lea	(Level_layout_header).w,a1
		move.w	(a1),d0
		mulu.w	4(a1),d0
		move.w	2(a1),d1
		mulu.w	6(a1),d1
		add.w	d1,d0
		addi.w	#$88,d0
		adda.w	d0,a1
		move.w	#$FFF,d1
		sub.w	d0,d1

loc_5A3FA:
		clr.b	(a1)+
		dbf	d1,loc_5A3FA
		jsr	Create_New_Sprite.w
		bne.s	loc_5A442
		move.l	#Obj_5A7C8,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_5A442
		move.l	#Obj_5A8E6,(a1)
		jsr	(CreateNewSprite4).l
		bne.s	loc_5A442
		move.l	#Obj_DEZ3_Boss,(a1)
		move.w	#$3C0,d0
		move.w	#$F8,d1
		move.w	d0,$10(a1)
		move.w	d1,$14(a1)
		move.w	d0,(ScrEvents_3).w
		move.w	d1,(ScrEvents_4).w

loc_5A442:

		move.w	#$6C0,(ScrEvents_Routine2).w
		st	(Scroll_lock).w
		move.w	#$80,d0
		move.w	d0,(Camera_X_pos).w
		move.w	d0,(Camera_X_pos_copy).w
		move.w	d0,(ScrEvents_D).w
		jsr	sub_5A508(pc)
		jsr	(Reset_TileOffsetPositionActual).l
		lea	(Block_table+$1800).w,a1
		clr.l	(a1)+
		move.w	(a1)+,(a1)
		andi.w	#-$10,(a1)+
		clr.w	(a1)
		lea	DEZ3_BGDrawArray(pc),a4
		lea	(Block_table+$1800).w,a5
		jmp	(Refresh_PlaneTileDeform).l
; ---------------------------------------------------------------------------

DEZ3_ScreenEvent:
		lea	(Level_layout_main+$2).w,a3
		move.w	#-$2000,d7
		move.w	(ScrEvents_Routine).w,d0
		jmp	loc_5A492(pc,d0.w)
; ---------------------------------------------------------------------------

loc_5A492:
		bra.w	loc_5A49A
; ---------------------------------------------------------------------------
		bra.w	loc_5A4C4
; ---------------------------------------------------------------------------

loc_5A49A:
		move.w	(Act3_TempRings).w,d0
		beq.s	loc_5A4AE
		clr.w	(Act3_TempRings).w
		move.b	d0,(Ring_count).w
		move.b	#1,(Update_HUD_ring_count).w

loc_5A4AE:
		move.l	(Act3_TempTime).w,d0
		beq.s	loc_5A4C0
		clr.l	(Act3_TempTime).w
		move.l	d0,(Timer).w
		st	(Update_HUD_timer).w

loc_5A4C0:
		addq.w	#4,(ScrEvents_Routine).w

loc_5A4C4:
		jsr	sub_5A508(pc)
		lea	DEZ3_BGDrawArray(pc),a4
		lea	(Block_table+$1800).w,a6
		moveq	#2,d5
		move.w	(Camera_Y_pos_rounded).w,d6
		jsr	(Draw_BGNoVert).l
		move.w	(ScrEvents_5).w,d1
		beq.s	locret_5A506
		clr.w	(ScrEvents_5).w
		move.w	#$1E0,d0
		and.w	d0,d1
		moveq	#2,d6
		moveq	#1,d2

loc_5A4F0:
		movem.w	d0-d2/d6,-(sp)
		jsr	(Setup_TileRowDraw).l
		movem.w	(sp)+,d0-d2/d6
		addi.w	#$10,d0
		dbf	d2,loc_5A4F0

locret_5A506:
		rts

; =============== S U B R O U T I N E =======================================


sub_5A508:

		moveq	#$20,d0
		add.w	(ScrShake_Offset).w,d0
		move.w	d0,(Camera_Y_pos_copy).w
		move.w	(Camera_X_pos_copy).w,d0
		move.w	d0,(Block_table+$180A).w
		andi.w	#$1FF,d0
		move.w	d0,(Block_table+$1804).w
		rts
; End of function sub_5A508

; ---------------------------------------------------------------------------
DEZ3_BGDrawArray:
		dc.w $E0
		dc.w $7FFF
; ---------------------------------------------------------------------------

DEZ3_BackgroundInit:
		lea	(Level_layout_main).w,a3
		move.w	#-$4000,d7
		jsr	sub_5A76C(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		jsr	(Refresh_PlaneFull).l
		bra.w	loc_5A734
; ---------------------------------------------------------------------------

DEZ3_BackgroundEvent:
		lea	(Level_layout_main).w,a3
		move.w	#-$4000,d7
		jsr	sub_5A76C(pc)
		move.w	(TrigEvents_Routine).w,d0
		jmp	loc_5A558(pc,d0.w)
; ---------------------------------------------------------------------------

loc_5A558:
		bra.w	loc_5A57C
; ---------------------------------------------------------------------------
		bra.w	loc_5A5B0
; ---------------------------------------------------------------------------
		bra.w	loc_5A5E0
; ---------------------------------------------------------------------------
		bra.w	loc_5A606
; ---------------------------------------------------------------------------
		bra.w	loc_5A61A
; ---------------------------------------------------------------------------
		bra.w	loc_5A662
; ---------------------------------------------------------------------------
		bra.w	loc_5A676
; ---------------------------------------------------------------------------
		bra.w	loc_5A71A
; ---------------------------------------------------------------------------
		bra.w	loc_5A72E
; ---------------------------------------------------------------------------

loc_5A57C:
		tst.w	(ScrEvents_2).w
		beq.w	loc_5A72E
		clr.w	(ScrEvents_2).w
		movea.w	8(a3),a1
		move.b	#$1A,$D(a1)
		move.w	(Camera_Y_pos_BG_copy).w,d0
		move.w	(Camera_X_pos_BG_copy).w,d1
		moveq	#$15,d6
		jsr	(Refresh_PlaneDirect).l
		addq.w	#4,(TrigEvents_Routine).w
		bra.w	loc_5A734
; ---------------------------------------------------------------------------

loc_5A5B0:
		tst.w	(ScrShake_Value).w
		beq.w	loc_5A72E
		jsr	Create_New_Sprite.w
		bne.s	loc_5A5DC
		move.l	#Obj_5A922,(a1)
		move.w	#$13,$2E(a1)
		move.w	#$2D0,$30(a1)
		move.w	#$2C0,(ScrEvents_D).w
		addq.w	#4,(TrigEvents_Routine).w

loc_5A5DC:
		bra.w	loc_5A72E
; ---------------------------------------------------------------------------

loc_5A5E0:
		cmpi.w	#$6C0,(ScrEvents_Routine2).w
		beq.w	loc_5A72E
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$F0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		move.w	(Camera_X_pos_BG_copy+$2).w,(ScrEvents_8).w
		addq.w	#4,(TrigEvents_Routine).w

loc_5A606:
		moveq	#0,d1
		moveq	#0,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_5A61A
		clr.w	(ScrEvents_8).w
		addq.w	#4,(TrigEvents_Routine).w

loc_5A61A:

		cmpi.w	#$2C0,(ScrEvents_Routine2).w
		beq.w	loc_5A72E
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$F0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		move.w	(Camera_X_pos_BG_copy+$2).w,(ScrEvents_8).w
		jsr	Create_New_Sprite.w
		bne.s	loc_5A65E
		move.l	#Obj_5A94C,(a1)
		move.w	(Camera_X_pos_copy).w,d0
		andi.w	#-$20,d0
		move.w	d0,(ScrEvents_D).w
		subi.w	#$10,d0
		move.w	d0,$30(a1)

loc_5A65E:
		addq.w	#4,(TrigEvents_Routine).w

loc_5A662:
		moveq	#0,d1
		moveq	#0,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_5A676
		clr.w	(ScrEvents_8).w
		addq.w	#4,(TrigEvents_Routine).w

loc_5A676:

		tst.w	(ScrEvents_Routine2).w
		beq.w	loc_5A6FE
		jsr	sub_5A79E(pc)
		tst.w	(ScrEvents_2).w
		beq.w	loc_5A72E
		clr.w	(ScrEvents_2).w
		move.w	(ScrEvents_7).w,d0
		jmp	loc_5A696(pc,d0.w)
; ---------------------------------------------------------------------------

loc_5A696:
		bra.s	loc_5A69E
; ---------------------------------------------------------------------------
		bra.s	loc_5A6A4
; ---------------------------------------------------------------------------
		bra.s	loc_5A69E
; ---------------------------------------------------------------------------
		bra.s	loc_5A6AA
; ---------------------------------------------------------------------------

loc_5A69E:

		move.w	#$603,d0
		bra.s	loc_5A6B4
; ---------------------------------------------------------------------------

loc_5A6A4:
		move.w	#$903,d0
		bra.s	loc_5A6B4
; ---------------------------------------------------------------------------

loc_5A6AA:
		move.w	#$807,d0
		move.w	#-2,(ScrEvents_7).w

loc_5A6B4:

		addq.w	#2,(ScrEvents_7).w
		movea.w	8(a3),a1
		move.b	d0,$E(a1)
		lsr.w	#8,d0
		movea.w	$C(a3),a1
		move.b	d0,$E(a1)
		move.w	#$700,d1
		move.w	#$160,d0
		moveq	#8,d6
		moveq	#9,d2
		move.w	(Camera_Y_pos_BG_copy).w,d3
		andi.w	#-$10,d3
		addi.w	#$E0,d3

loc_5A6E2:
		movem.w	d0-d3/d6,-(sp)
		jsr	(Setup_TileRowDraw).l
		movem.w	(sp)+,d0-d3/d6
		addi.w	#$10,d0
		cmp.w	d3,d0
		bhi.s	loc_5A6FC
		dbf	d2,loc_5A6E2

loc_5A6FC:
		bra.s	loc_5A72E
; ---------------------------------------------------------------------------

loc_5A6FE:
		jsr	(Reset_TileOffsetPositionEff).l
		move.w	#$F0,(DrawDelayed_Position).w
		move.w	#$F,(DrawDelayed_RowCount).w
		move.w	(Camera_X_pos_BG_copy+$2).w,(ScrEvents_8).w
		addq.w	#4,(TrigEvents_Routine).w

loc_5A71A:
		moveq	#0,d1
		moveq	#0,d2
		jsr	(Draw_PlaneVertBottomUp).l
		bpl.s	loc_5A72E
		clr.w	(ScrEvents_8).w
		addq.w	#4,(TrigEvents_Routine).w

loc_5A72E:

		jsr	(DrawBGAsYouMove).l

loc_5A734:

		lea	DEZ3_BGDrawArray(pc),a4
		lea	(Block_table+$1808).w,a5
		lea	(H_scroll_buffer).w,a1
		move.w	(Camera_Y_pos_copy).w,d0
		move.w	(ScrEvents_8).w,d3
		bne.s	loc_5A74E
		move.w	(Camera_X_pos_BG_copy).w,d3

loc_5A74E:
		move.w	#$DF,d1
		jsr	(ApplyDeformation2).l
		move.w	(Camera_Y_pos_BG_copy).w,(V_scroll_value).w
		move.w	(Camera_Y_pos_copy).w,(V_scroll_value_BG).w
		addq.w	#4,sp
		jmp	ShakeScreen_Setup.w

; =============== S U B R O U T I N E =======================================


sub_5A76C:

		move.w	(Camera_X_pos_BG_copy).w,(Camera_X_pos_BG_copy+$2).w
		tst.w	(ScrEvents_Routine2).w
		bne.s	loc_5A77C
		moveq	#0,d0
		bra.s	loc_5A788
; ---------------------------------------------------------------------------

loc_5A77C:
		move.w	(Camera_X_pos_copy).w,d0
		sub.w	(ScrEvents_3).w,d0
		add.w	(ScrEvents_Routine2).w,d0

loc_5A788:
		move.w	d0,(Camera_X_pos_BG_copy).w
		move.w	(Camera_Y_pos_copy).w,d0
		sub.w	(ScrEvents_4).w,d0
		addi.w	#$180,d0
		move.w	d0,(Camera_Y_pos_BG_copy).w

locret_5A7C6:
		rts
; End of function sub_5A76C


; =============== S U B R O U T I N E =======================================


sub_5A79E:

		moveq	#0,d1
		move.w	(ScrEvents_A).w,d1
		cmp.w	(ScrEvents_B).w,d1
		beq.s	locret_5A7C6
		move.w	d1,(ScrEvents_B).w
		addq.w	#2,d1
		lsl.w	#2,d1
		addi.l	#ArtUnc_DEZFBLaser,d1
		move.w	#$4100,d2
		move.w	#$40,d3
		jmp	Add_To_DMA_Queue.w
; ---------------------------------------------------------------------------

Obj_5A7C8:
		move.l	#loc_5A7EC,(a0)
		move.b	#$10,6(a0)
		move.w	#$130,$10(a0)
		move.w	#$F0,$14(a0)
		bset	#7,$2A(a0)
		move.w	#$80,$2E(a0)

loc_5A7EC:
		cmpi.b	#$17,(Current_zone).w
		beq.s	loc_5A7FA
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_5A7FA:
		move.w	(ScrEvents_6).w,d1
		beq.s	loc_5A83C
		clr.w	(ScrEvents_6).w
		cmp.w	(ScrEvents_D).w,d1
		blo.s	loc_5A83C
		jsr	Create_New_Sprite3.w
		bne.s	loc_5A82C
		move.l	#Obj_5A872,(a1)
		move.w	d1,$10(a1)
		move.w	$2E(a0),d2
		subi.w	#$20,d2
		cmp.w	d1,d2
		bhi.s	loc_5A82C
		move.w	d1,(ScrEvents_5).w

loc_5A82C:

		moveq	#$20,d0
		add.w	d0,(ScrEvents_D).w
		cmp.w	$2E(a0),d1
		blo.s	loc_5A83C
		add.w	d0,$10(a0)

loc_5A83C:

		moveq	#-$20,d1
		move.w	(Camera_X_pos_copy).w,d0
		andi.w	#-$20,d0
		move.w	$2E(a0),d2
		cmp.w	d2,d0
		beq.s	loc_5A860
		bcs.s	loc_5A858
		cmp.w	(ScrEvents_D).w,d2
		blo.s	loc_5A85C
		neg.w	d1

loc_5A858:
		add.w	d1,$10(a0)

loc_5A85C:
		move.w	d0,$2E(a0)

loc_5A860:
		move.w	#$B0,d1
		moveq	#$10,d2
		moveq	#$10,d3
		move.w	$10(a0),d4
		jmp	SolidObjectTop.w
; ---------------------------------------------------------------------------

Obj_5A872:
		move.l	#loc_5A8B2,(a0)
		move.b	#-$7C,4(a0)
		move.b	#$10,6(a0)
		move.b	#$C,7(a0)
		move.w	#prio(1),8(a0)
		move.w	#-$3FFF,$A(a0)
		move.l	#Map_DEZ3Blocks,$C(a0)
		move.w	#$F0,$14(a0)
		move.w	$10(a0),d0
		andi.w	#$60,d0
		lsr.w	#5,d0
		move.b	d0,$22(a0)

loc_5A8B2:
		tst.b	4(a0)
		bmi.s	loc_5A8C4
		move.w	(Camera_X_pos_coarse_back).w,d0
		addi.w	#$400,d0
		move.w	d0,$10(a0)

loc_5A8C4:
		jsr	MoveSprite2.w
		addi.w	#$1A,$1A(a0)
		moveq	#$10,d1
		moveq	#$10,d2
		moveq	#$10,d3
		move.w	$10(a0),d4
		jsr	SolidObjectTop.w
		jmp	Sprite_OnScreen_Test.w
; ---------------------------------------------------------------------------

Obj_5A8E6:
		move.l	#loc_5A904,(a0)
		move.b	#$10,6(a0)
		move.w	#$40,$10(a0)
		move.w	#$F0,$14(a0)
		bset	#7,$2A(a0)

loc_5A904:
		cmpi.w	#$6C0,(ScrEvents_Routine2).w
		beq.s	loc_5A912
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_5A912:
		moveq	#$40,d1
		moveq	#$10,d2
		moveq	#$10,d3
		move.w	$10(a0),d4
		jmp	SolidObjectTop.w
; ---------------------------------------------------------------------------

Obj_5A922:
		subq.w	#1,$32(a0)
		bpl.s	locret_5A94A
		move.w	#$F,$32(a0)
		move.w	$30(a0),(ScrEvents_6).w
		addi.w	#$20,$30(a0)
		subq.w	#1,$2E(a0)
		bne.s	locret_5A94A
		clr.w	(ScrShake_Value).w
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

locret_5A94A:

		rts
; ---------------------------------------------------------------------------

Obj_5A94C:
		cmpi.b	#$17,(Current_zone).w
		beq.s	loc_5A95A
		jmp	Delete_Current_Sprite.w
; ---------------------------------------------------------------------------

loc_5A95A:
		tst.w	(ScrEvents_Routine2).w
		bne.s	loc_5A97C
		move.w	(Camera_X_pos_copy).w,d0
		addi.w	#$9C,d0
		cmp.w	$30(a0),d0
		blo.s	locret_5A9AA
		move.w	$30(a0),(ScrEvents_6).w
		addi.w	#$20,$30(a0)
		bra.s	locret_5A9AA
; ---------------------------------------------------------------------------

loc_5A97C:
		cmpi.w	#$110,(ScrEvents_4).w
		bhs.s	locret_5A9AA
		subq.w	#1,$32(a0)
		bpl.s	locret_5A9AA
		move.w	(ScrEvents_3).w,d0
		addi.w	#$90,d0
		cmp.w	$30(a0),d0
		blo.s	locret_5A9AA
		move.w	$30(a0),(ScrEvents_6).w
		addi.w	#$20,$30(a0)
		move.w	#$D,$32(a0)

locret_5A9AA:

		rts
; ---------------------------------------------------------------------------
Map_DEZ3Blocks:	include "Levels/DEZ/Misc Object Data/Map - Act 3 Blocks.asm"

; ---------------------------------------------------------------------------

HPZS_ScreenInit:
loc_5AA14:
		movea.w	$10(a3),a1
		clr.b	$29(a1)
		clr.b	$2B(a1)
		movea.w	$14(a3),a1
		clr.b	$29(a1)
		jsr	(Reset_TileOffsetPositionActual).l
		jmp	(Refresh_PlaneFull).l
; ---------------------------------------------------------------------------

HPZS_ScreenEvent:
		move.w	(ScrShake_Offset).w,d0
		add.w	d0,(Camera_Y_pos_copy).w
		jmp	(DrawTilesAsYouMove).l
; ---------------------------------------------------------------------------

HPZS_BackgroundInit:
		jsr	sub_5A334(pc)
		jsr	(Reset_TileOffsetPositionEff).l
		lea	(Block_table+$1800).w,a1
		move.w	(a1)+,(a1)
		andi.w	#-$10,(a1)+
		move.w	(a1)+,(a1)
		andi.w	#-$10,(a1)
		lea	HPZ_BGDrawArray(pc),a4
		lea	(Block_table+$1800).w,a5
		jsr	(Refresh_PlaneTileDeform).l
		lea	HPZ_BGDeformArray(pc),a4
		lea	(Block_table+$1808).w,a5
		jmp	(ApplyDeformation).l
; ---------------------------------------------------------------------------

HPZS_BackgroundEvent:
		jsr	sub_5A334(pc)
		lea	HPZ_BGDrawArray(pc),a4
		lea	(Block_table+$1800).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	(Draw_BG).l
		lea	HPZ_BGDeformArray(pc),a4
		lea	(Block_table+$1808).w,a5
		jsr	(ApplyDeformation).l
		jmp	ShakeScreen_Setup.w
; ---------------------------------------------------------------------------

Ending_ScreenInit:
Ending_ScreenEvent:
Ending_BackgroundInit:
Ending_BackgroundEvent:
		jmp	Delete_Current_Sprite.w
