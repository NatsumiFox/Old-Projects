Handle_Onscreen_Water_Height:
		tst.b	Water_Flag.w
		beq.s	.endwater		; branch if there is no water in this level
		tst.b	Deform_Lock.w
		bne.s	.nodynwater		; if deform lock is active, branch
		cmpi.b	#6,Object_RAM+routine.w
		bhs.s	.nodynwater		; branch of Sonic has died
		bsr.w	WaterEvents

.nodynwater	clr.b	Water_Fullscrn_Flag.w
		moveq	#0,d0
		add.w	Current_Water_Height.w,d0
		move.w	d0,Water_Height_Default.w

		move.w	Water_Height_Default.w,d0
		sub.w	Camera_Y.w,d0
		beq.s	.fullscrn
		bhs.s	.dowater
		tst.w	d0
		bpl.s	.dowater

.fullscrn	move.b	#1,Water_Fullscrn_Flag.w
.nowater	move.b	#-1,Hint_Counter_Reserve+1.w
		rts
; ---------------------------------------------------------------------------

.dowater	cmpi.w	#$DF,d0
		blo.s	.somewater
		move.w	#$FF,d0

.somewater	move.b	d0,Hint_Counter_Reserve+1.w
.endwater	rts
; ---------------------------------------------------------------------------

WaterEvents:
		rts
; ---------------------------------------------------------------------------
