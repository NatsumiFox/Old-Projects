PaletteCycle:
		tst.b	PalCycle_Delay.w	; check delay
		beq.s	.palcycle		; if 0, do palette cycle
		cmp.b	#6,Object_RAM+routine.w
		bhs.s	.fadeout
		subq.b	#1,PalCycle_Delay.w	; sub 1 from delay
		bne.s	.rts			; if still 0, branch
	;	move.b	#17,PalCycle_Delay.w
		move.l	#$80048174,VDP_control_port; enable display and disable h-int
		st	Hint_Counter_Reserve+1.w
.rts		rts

.fadeout	addq.b	#1,PalCycle_Delay.w	; sub 1 from delay
		cmp.b	#19,PalCycle_Delay.w
		blt.s	.rts
		move.b	#18,PalCycle_Delay.w
		tst.b	MusFade_InProgress.w
		bmi.s	.rts			; branch if music fade is in progress
		st	Level_Restart_Flag.w	; restart level
		rts

.palcycle
; ---------------------------------------------------------------------------

SuperHyper_PalCyc:
		move.b	Super_PalCycle_Flag.w,d0
		beq.w	locret_37EC
		bmi.w	loc_3854
		subq.b	#1,d0
		bne.w	loc_37EE
		subq.b	#1,Super_PalCycle_Timer.w
		bpl.w	locret_37EC
		move.b	#1,Super_PalCycle_Timer.w
		cmpi.w	#2,Player_Mode.w
		blo.s	loc_3792
		st	Super_PalCycle_Flag.w
		clr.w	Super_PalCycle_Frame.w
		clr.b	SuperTails_PalCycle_Frame.w
		clr.b	Object_RAM+carried.w
		rts
; ---------------------------------------------------------------------------

loc_3792:
		lea	PalCyc_SuperSonic,a0
		move.w	Super_PalCycle_Frame.w,d0
		addq.w	#6,Super_PalCycle_Frame.w
		cmpi.w	#$24,Super_PalCycle_Frame.w
		blo.s	loc_37B4
		st	Super_PalCycle_Flag.w
		clr.b	Object_RAM+carried.w

loc_37B4:
		lea	Main_Palette+4.w,a1
		move.l	(a0,d0.w),(a1)+
		move.w	4(a0,d0.w),(a1)

locret_37EC:
		rts
; ---------------------------------------------------------------------------

loc_37EE:
		cmpi.w	#2,Player_Mode.w
		bhs.s	loc_3820
		subq.b	#1,Super_PalCycle_Timer.w
		bpl.s	locret_37EC
		move.b	#3,Super_PalCycle_Timer.w
		lea	PalCyc_SuperSonic,a0
		move.w	Super_PalCycle_Frame.w,d0
		subq.w	#6,Super_PalCycle_Frame.w
		bhs.s	loc_381E
		clr.b	Super_PalCycle_Frame.w
		clr.b	Super_PalCycle_Flag.w

loc_381E:
		bra.s	loc_37B4
; ---------------------------------------------------------------------------

loc_3820:
		clr.w	Super_PalCycle_Frame.w
		clr.b	Super_PalCycle_Flag.w
		clr.b	SuperTails_PalCycle_Frame.w
		cmpi.w	#3,Player_Mode.w
		bhs.s	loc_384A
		lea	PalCyc_SuperTails,a0
		bsr.w	sub_3914
		lea	PalCyc_SuperSonic,a0
		bra.w	loc_396C
; ---------------------------------------------------------------------------

loc_384A:
		lea	PalCyc_SuperRevert,a0
		bra.w	loc_396C
; ---------------------------------------------------------------------------

loc_3854:
		cmpi.w	#2,Player_Mode.w
		beq.w	loc_38E8
		cmpi.w	#3,Player_Mode.w
		beq.w	loc_393C
		tst.b	Super_Flag.w
		bmi.s	loc_389C

loc_386E:
		subq.b	#1,Super_PalCycle_Timer.w
		bpl.w	locret_37EC
		move.b	#6,Super_PalCycle_Timer.w
		lea	PalCyc_SuperSonic,a0
		move.w	Super_PalCycle_Frame.w,d0
		addq.w	#6,Super_PalCycle_Frame.w
		cmpi.w	#$36,Super_PalCycle_Frame.w
		blo.s	loc_3898
		move.w	#$24,Super_PalCycle_Frame.w

loc_3898:
		bra.w	loc_37B4
; ---------------------------------------------------------------------------

loc_389C:
		subq.b	#1,Super_PalCycle_Timer.w
		bpl.w	locret_37EC
		move.b	#4,Super_PalCycle_Timer.w
		lea	PalCyc_HyperSonic,a0
		move.w	Super_PalCycle_Frame.w,d0
		addq.w	#6,Super_PalCycle_Frame.w
		cmpi.w	#$48,Super_PalCycle_Frame.w
		blo.s	loc_38C6
		clr.w	Super_PalCycle_Frame.w

loc_38C6:
		lea	Main_Palette+4.w,a1
		move.l	(a0,d0.w),(a1)+
		move.w	4(a0,d0.w),(a1)
		tst.b	Water_Flag.w
		beq.w	locret_37EC
		lea	Water_Pal+4.w,a1
		move.l	(a0,d0.w),(a1)+
		move.w	4(a0,d0.w),(a1)
		rts
; ---------------------------------------------------------------------------

loc_38E8:
		subq.b	#1,SuperTails_PalCycle_Timer.w
		bpl.w	loc_386E
		move.b	#$B,SuperTails_PalCycle_Timer.w
		lea	PalCyc_SuperTails,a0
		moveq	#0,d0
		move.b	SuperTails_PalCycle_Frame.w,d0
		addq.b	#6,SuperTails_PalCycle_Frame.w
		cmpi.b	#$24,SuperTails_PalCycle_Frame.w
		blo.s	sub_3914
		clr.b	SuperTails_PalCycle_Frame.w

sub_3914:
		lea	Main_Palette+$10.w,a1
		move.l	(a0,d0.w),(a1)+
		move.w	4(a0,d0.w),2(a1)
		tst.b	Water_Flag.w
		beq.w	loc_386E
		lea	Water_Pal+$10.w,a1
		move.l	(a0,d0.w),(a1)+
		move.w	4(a0,d0.w),2(a1)
		bra.w	loc_386E
; ---------------------------------------------------------------------------

loc_393C:
		subq.b	#1,Super_PalCycle_Timer.w
		bpl.w	locret_37EC
		move.b	#2,Super_PalCycle_Timer.w
		lea	PalCyc_SuperKnuckles,a0
		move.w	Super_PalCycle_Frame.w,d0
		addq.w	#6,Super_PalCycle_Frame.w
		cmpi.w	#$3C,Super_PalCycle_Frame.w
		blo.s	loc_396C
		clr.w	Super_PalCycle_Frame.w
		move.b	#$E,Super_PalCycle_Timer.w

loc_396C:
		lea	Main_Palette+4.w,a1
		move.l	(a0,d0.w),(a1)+
		move.w	4(a0,d0.w),(a1)
		tst.b	Water_Flag.w
		beq.w	locret_37EC
		lea	Water_Pal+4.w,a1
		move.l	(a0,d0.w),(a1)+
		move.w	4(a0,d0.w),(a1)
		rts

; ---------------------------------------------------------------------------
PalCyc_SuperSonic:	incbin 'levels/Players/Sonic/Super Cycle.bin'
PalCyc_SuperUWAIZICZ:	incbin 'levels/Players/Sonic/Super UW  AIZ ICZ Cycle.bin'
PalCyc_SuperUWHCZCNZLBZ:incbin 'levels/Players/Sonic/Super UW  HCZ CNZ LBZ Cycle.bin'
PalCyc_HyperSonic:	incbin 'levels/Players/Sonic/Hyper Cycle.bin'
PalCyc_SuperTails:	incbin 'levels/Players/Tails/Super Cycle.bin'
PalCyc_SuperKnuckles:	incbin 'levels/Players/Knuckles/Super Cycle.bin'
PalCyc_SuperRevert:	dc.w $64E,$20C,$206
; ---------------------------------------------------------------------------

Pal_SonicTails:		incbin "levels/Players/Sonic/Pal SonicTails.bin"
Pal_Knuckles:		incbin "levels/Players/Knuckles/Pal Main.bin"

