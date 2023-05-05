VInt:
		movem.l	d0-a6,-(sp)
		lea	VDP_control_port,a5
		tst.b	VInt_Routine.w
		beq.w	loc_608

.waitVBI	move.w	VDP_control_port,d0
		andi.w	#8,d0
		beq.s	.waitVBI		; ensure VBlank is taking place

	vdpComm	move.l,$0000,VSRAM,WRITE,(a5)
		move.l	VScroll_Factor_FG.w,-4(a5)

		btst	#6,Graphics_Flags.w	; is PAL system?
		beq.s	.isNTSC			; if not, don't wait extra cycles
		move.w	#$700,d0
		dbf	d0,offset(*)

.isNTSC		move.b	VInt_Routine.w,d0	; get routine number
		sf	VInt_Routine.w		; clear it right after
		andi.w	#$3E,d0
		move.w	off_5E6-2(pc,d0.w),d0	; jump to appropriate code
		jsr	off_5E6(pc,d0.w)

VInt_Return:
		addq.l	#1,VInt_RunCount.w
		movem.l	(sp)+,d0-a6

HInt:
		rte

; ---------------------------------------------------------------------------
off_5E6:	dc.w VInt_8-off_5E6
		dc.w VInt_A_C-off_5E6
		dc.w VInt_8-off_5E6
		dc.w VInt_12-off_5E6

; ---------------------------------------------------------------------------
VInt_Lag:
		addq.w	#4,sp		; dont return

loc_608:
		addq.w	#1,Level_Lag_Frames.w
		cmpi.b	#$8C,GameMode.w
		beq.s	Vint_Lag_isLevel

loc_61C:
		cmpi.b	#$C,GameMode.w
		bne.s	VInt_Return
	if debug=1
		tst.b	Level_Lag_Crash.w
		bpl.s	Vint_Lag_isLevel
		jmp	LevelLagError
	endif
; ---------------------------------------------------------------------------

Vint_Lag_isLevel:
		tst.b	Water_Flag.w
		beq.w	.nowater
		move.w	VDP_control_port,d0
		btst	#6,Graphics_Flags.w	; is PAL system?
		beq.s	.isNTSC			; if not, don't wait extra cycles
		move.w	#$700,d0
		dbf	d0,offset(*)

.isNTSC		tst.b	Water_Fullscrn_Flag.w
		bne.s	.underwater
	dma68kToVDP Main_Palette,$0000,$80,CRAM
		bra.s	.common

.underwater	dma68kToVDP Water_Pal,$0000,$80,CRAM

.common		move.w	Hint_Counter_Reserve.w,(a5)
		move.w	WindowPlaneReg.w,(a5)		; potentially enable window plane
		bra.w	VInt_Return

.nowater	move.w	VDP_control_port,d0
		btst	#6,Graphics_Flags.w	; is PAL system?
		beq.s	.isNTSC2		; if not, don't wait extra cycles
		move.w	#$700,d0
		dbf	d0,offset(*)

.isNTSC2	move.w	Hint_Counter_Reserve.w,(a5)
	vdpComm	move.l,$0000,VSRAM,WRITE,(a5)
		move.l	VScroll_Factor_FG.w,-4(a5)
		move.w	WindowPlaneReg.w,(a5)		; potentially enable window plane

	dma68kToVDP Sprite_Attribute_Table,$F800,$280,VRAM
		bra.w	VInt_Return
; ---------------------------------------------------------------------------

VInt_8:
		bsr.w	ControllerInput
		tst.b	Flash_Timer.w
		beq.s	.noflash

		; used when super sonic double jump move is used to flash white
		subq.b	#1,Flash_Timer.w
		lea	VDP_data_port,a6
	vdpComm	move.l,$0000,CRAM,WRITE,VDP_control_port

		move.w	#$EEE,d0	; fill white
		move.w	#$40-1,d1	; do full line 1
.fill1		move.w	d0,(a6)
		dbf	d1,.fill1
		bra.s	.c2
; ---------------------------------------------------------------------------

.noflash dma68kToVDP Main_palette,$0000,$80,CRAM
.c2	dma68kToVDP Horiz_scroll_buffer,$F000,$380,VRAM
	dma68kToVDP Sprite_attribute_table,$F800,$280,VRAM

		jsr	Process_DMA_Queue.w
		jsr	SpecialFXcode(pc)
		jsr	PlaneBufferToVRAM(pc)
		move	#$2300,sr
		bsr.w	VInt_UpdateHUD

		tst.b	PalCycle_Delay.w		; get delay amount
		beq.s	.set				; if over, branch
		bset	#6,HintStartDisp_Type.w
		move.l	#$80148134,d7

		move.l	#HintStartDisp,HInt_Addr.w	; set to display to begin with
		lea	HintStartData.w,a1		; get the array ptr to a1
		move.w	a1,HintStartDisp_Addr.w		; store to anim address

		moveq	#0,d1
		move.b	PalCycle_Delay.w,d1		; get delay amount
		lsl.w	#2,d1				; 4 bytes per entry
		move.l	.fadetbl-4(pc,d1.w),a0		; get the target entry

		move.w	(a0)+,d0			; get the number of entries
		bpl.s	.mainloop			; if positive, branch
		bclr	#6,HintStartDisp_Type.w
		bset	#6,d7
		bclr	#15,d0				; clear this bit

.mainloop	move.l	(a0)+,(a1)+			; copy a long
		dbf	d0,.mainloop			; loop until done
		st	(a1)+

		move.l	d7,(a5)				; enable h-ints
		sf	Hint_Counter_Reserve+1.w	; clear the line count
.set		move.w	Hint_Counter_Reserve.w,(a5)
		move.w	WindowPlaneReg.w,(a5)		; potentially enable window plane
		jmp	Set_Kos_BookMark(pc)

; ---------------------------------------------------------------------------
.fadetbl	dc.l FadeIn_16
		dc.l FadeIn_15, FadeIn_14, FadeIn_13, FadeIn_12
		dc.l FadeIn_11, FadeIn_10, FadeIn_09, FadeIn_08
		dc.l FadeIn_07, FadeIn_06, FadeIn_05, FadeIn_04
		dc.l FadeIn_03, FadeIn_02, FadeIn_01, FadeIn_00
		dc.l FadeIn_17
; ---------------------------------------------------------------------------

VInt_UpdateHUD:
		jsr	UpdateHUD.w
		clr.w	Level_Lag_Frames.w

		tst.w	Demo_Time.w
		beq.w	.rts
		subq.w	#1,Demo_Time.w
.rts		rts
; ---------------------------------------------------------------------------

VInt_A_C:
		bsr.s	ControllerInput
	dma68kToVDP Water_pal,$0000,$80,CRAM
.continue	move.w	Hint_Counter_Reserve.w,(a5)
	dma68kToVDP Horiz_scroll_buffer,$F000,$380,VRAM
	dma68kToVDP Sprite_attribute_table,$F800,$280,VRAM

.c		jsr	Process_DMA_Queue.w
		move.w	WindowPlaneReg.w,(a5)		; potentially enable window plane
		jmp	Set_Kos_BookMark(pc)
; ---------------------------------------------------------------------------

VInt_12:
		move.w	Hint_Counter_Reserve.w,(a5)
		move.w	WindowPlaneReg.w,(a5)		; potentially enable window plane
	dma68kToVDP Main_palette,$0000,$80,CRAM
		bsr.s	ControllerInput
		jmp	Process_DMA_Queue.w
; ---------------------------------------------------------------------------

ControllerInput:
		lea	Ctrl_1_Held.w,a0
		lea	HW_Port_1_Data,a1
		bsr.s	.doSingle		; do controller 1 input
		addq.w	#2,a1			; do controller 2 input

.doSingle	move.b	#0,(a1)
		nop
		nop
		move.b	(a1),d0
		lsl.b	#2,d0
		andi.b	#$C0,d0
		move.b	#$40,(a1)
		nop
		nop
		move.b	(a1),d1
		andi.b	#$3F,d1
		or.b	d1,d0
		not.b	d0
		move.b	(a0),d1
		eor.b	d0,d1
		move.b	d0,(a0)+
		and.b	d0,d1
		move.b	d1,(a0)+
		rts
; ---------------------------------------------------------------------------

ControllerInit:
	stopZ80
		moveq	#$40,d0
		move.b	d0,HW_Port_1_Control
		move.b	d0,HW_Port_2_Control
		move.b	d0,HW_Expansion_Control
	startZ80
		rts
; ---------------------------------------------------------------------------

HintStartDispD:
	obj $FFFF8000
HintStartDisp:

HintStartDisp_Addr EQU *+2
		subq.b	#1,Header.w		; sub 1 from delay
		bne.s	.rts			; if positive, branch

HintStartDisp_Type EQU *+3
		move.w	#$8134,VDP_control_port	; disable display
		addq.w	#1,HintStartDisp_Addr.w	; increment offset
		bchg	#6,HintStartDisp_Type.w	; change type
.rts		rte

HintStartData:
	objend
; ---------------------------------------------------------------------------
