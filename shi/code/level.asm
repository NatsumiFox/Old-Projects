ClearDisplay:
		lea	VDP_control_port,a5
	dmaFillVRAM 0,$0000,$40
	dmaFillVRAM 0,$C000,$1000	; clear plane A PNT
	dmaFillVRAM 0,$E000,$1000	; clear plane B PNT
		moveq	#0,d0
		move.l	d0,VScroll_Factor_FG.w
		move.l	d0,HScroll_Factor_FG.w
	clearRAM Sprite_attribute_table,$280
	clearRAM Horiz_scroll_buffer,$400
		rts
; ---------------------------------------------------------------------------

LoadFadeInOutCode:
		lea	HintStartDispD,a2
		lea	Chunk_Tbl2.w,a1

	rept (HintStartData-HintStartDisp)/4
		move.l	(a2)+,(a1)+
	endr

	if ((HintStartData-HintStartDisp)&2)=2
		move.w	(a2),(a1)
	endif
		addq.b	#1,PalCycle_Delay.w
		rts
; ---------------------------------------------------------------------------

PreloadLevelData:
		clr.w	VDP_Command_Buffer.w
		move.l	#VDP_Command_Buffer,VDP_Command_Buffer_Slot.w
		lea	.kostbl(pc),a4
		moveq	#5-1,d7

.loadnext	move.l	(a4)+,a1
		move.w	(a4)+,d2
		jsr	Queue_Kos_Module
		dbf	d7,.loadnext

		move.l	#ML_Solid+2,d0
		move.l	d0,Secondary_Collision.w
		subq.b	#1,d0
		move.l	d0,Primary_Collision.w
		move.l	d0,Current_Collision.w
	if debug=1
		bra.s	PreloadLevelData2
	else
		rts
	endif
; ---------------------------------------------------------------------------
.kostbl		PLC $D800, ArtKosM_Ring
		PLC $AC80, ArtKosM_Monitors
		PLC $A680, ArtKosM_Spikes
		PLC $BC80, ArtKosM_EnemyPts
		PLC $B400, ArtKosM_Explosion
; ---------------------------------------------------------------------------

PreloadLevelData2:
	if debug=1
		move.l	#$857C857E,d0		; data to write
		lea	VDP_data_port,a6
		move.w	#$8F80,4(a6)		; autoincrement per $80 bytes (1 row in window maps)

	vdpComm	move.l,$8002,VRAM,WRITE,4(a6)	; write to VRAM $8000
		bsr.s	.writerow
	vdpComm	move.l,$8000,VRAM,WRITE,4(a6)	; write to VRAM $8000
		swap	d0
		bsr.s	.writerow
		move.w	#$8F02,4(a6)		; reset autoincrement
	endif

		moveq	#2,d0
		move.b	d0,Current_Mus.w
		jsr	PlayMusic.w

		move.l	#ML_Tiles,d1
		move.w	#0,d2
		move.w	#(ML_Tiles_End-ML_Tiles)/2,d3
		jmp	AddQueueDMA

	if debug=1
.writerow	moveq	#1,d2
		moveq	#18-1,d1		; num of rows
		move.w	d0,-(sp)
		bsr.s	.row
		moveq	#10-1,d1		; num of rows
		move.w	(sp)+,d0

.row		move.w	d0,(a6)
		add.w	d2,d0			; next set of tiles
		bchg	#1,d2
		dbf	d1,.row			; write all 28 rows
		rts
	endif
; ---------------------------------------------------------------------------

Level_rest:
		bset	#7,GameMode.w
	;	_moveq	$E1,d0
	;	jsr	playsfx.w
		lea	VDP_control_port,a6
		move.l	#$8AFF8B03,(a6)

		clr.w	Level_Frame_Timer.w
		clr.w	Lvl_AutoScroll_Routine.w

		move	#$2700,sr
		jsr	ClearDisplay(pc)
		move	#$2300,sr

	clearRAM Kos_decomp_stored_registers, Current_Collision-Kos_decomp_stored_registers
	clearRAM Sprite_table_input,	Object_RAM_End-Sprite_table_input
	clearRAM Level_Lag_Frames,	Player2_CPU_Flag-Level_Lag_Frames
	clearRAM Player2_CPU_Flag,	Pal_FadeIn_Delay-Player2_CPU_Flag
	clearRAM Osc_Num,		Total_Rings_Collected-Osc_Num

Level:
		clr.b	PalCycle_Delay.w

		jsr	sub_1AA6E
		move.b	#2,VInt_Routine.w
		jsr	wait_vsync.w

		move.w	#$8AFF,Hint_Counter_Reserve.w
		move.w	Hint_Counter_Reserve.w,(a6)

		moveq	#$20/4-1,d0
		lea	Main_Palette.w,a1
		lea	Pal_SonicTails,a0
		cmpi.w	#3,Player_Mode.w
		bne.s	.noknux
		lea	Pal_Knuckles-Pal_SonicTails(a0),a0

.noknux		move.l	(a0)+,(a1)+
		dbf	d0,.noknux

		move	#$2700,sr
		jsr	HUD_DrawInit
		move	#$2300,sr

		jsr	LoadLevelSize
		jsr	ScrollManager
		jsr	LoadLevelLayout

	; delay a bit so RINGS graphic can load
		jsr	Process_Kos_Queue
		jsr	Process_KosM_Queue

		move	#$2700,sr
		jsr	LevelSetup(pc)
		move	#$2300,sr

		clr.w	Ring_Count.w
		clr.b	Get_Extra_Life_Flag.w
		clr.w	Debug_Routine.w
		clr.b	Level_Restart_Flag.w
		clr.b	Stop_Referenced_Objs.w
		clr.w	Total_Rings_Collected.w
		clr.w	Monitors_Broken.w
		clr.b	Super_Flag.w
		clr.w	Ctrl_1_Held_Logical.w
		clr.w	Ctrl_2_Held_Logical.w
		clr.b	Level_Start_Flag.w
		clr.b	FreezePlaneA.w
		clr.b	Lvl_AutoScroll_Routine.w

		moveq	#1,d1
		move.b	d1,Update_HUD_Rings.w
		move.b	d1,Level_Start_Flag.w	; update counters
		jsr	InitOscValues(pc)
		jsr	SpawnLevelMainSprites(pc)

		moveq	#$60/4-1,d0
		lea	Main_Palette+$20.w,a1
		lea	ML_Pal,a0
.pal		move.l	(a0)+,(a1)+
		dbf	d0,.pal

		jsr	LoadFadeInOutCode(pc)
		move.b	#17,PalCycle_Delay.w
		move.w	#$16,Object_RAM_free+$1A0.w
		move.w	#$7F00,Ctrl_1_Held.w
		move.w	#$7F00,Ctrl_2_Held.w
		clr.w	Control_Locked.w
		bclr	#7,GameMode.w

; ---------------------------------------------------------------------------
LevelLoop:
	if debug=1
		st	Level_Lag_Crash.w
	endif
		jsr	PauseGame(pc)
		move.b	#2,VInt_Routine.w
		jsr	Process_Kos_Queue
		jsr	wait_vsync.w
		addq.w	#1,Level_Frame_Timer.w

		jsr	PaletteCycle
		jsr	sub_4F33C
		jsr	LoadObjects.w
		jsr	ProcessObjects.w
		tst.b	Level_Restart_Flag.w
		bne.w	Level_rest			; if level is set to restart, branch

		jsr	ScrollManager
		jsr	ScreenEvents
		jsr	Handle_Onscreen_Water_Height(pc)
		jsr	LoadRings.w
		jsr	AnimateTiles
		jsr	Process_KosM_Queue
		jsr	sub_773C(pc)
		jsr	ChangeRingFrame.w
		jsr	BuildSprites.w

		tst.b	Ctrl_2_Held.w
		bpl.s	.nospawn			; if p2 didnt press start, branch
		cmpi.l	#HudTailsIconMain,Obj_player_2.w; check if p2 obj
		bne.s	.nospawn			; if not, branch
		move.l	#Obj_Tails,Obj_player_2+parent.w; next obj is tails
		move.l	#HudTailsIconOut,Obj_player_2.w	; move icon out

.nospawn	cmpi.b	#$C,GameMode.w
		beq.w	LevelLoop

sub_67B6:
		rts
; ---------------------------------------------------------------------------

SpawnLevelMainSprites:
		move.w	Player_Mode.w,d0
		bne.s	.checkSonic			; branch if not Sonic & tails

		move.l	#Obj_Sonic,Object_RAM.w		; Spawn Sonic
		move.l	#Obj_DashDust,Obj_dust.w
		move.l	#Obj_Insta_Shield,Obj_shield.w
		move.w	#Object_RAM&$FFFF,Obj_shield+$42.w

		subi.w	#$20,Obj_player_2+$10.w
		addi.w	#4,Obj_player_2+$14.w

		move.l	#Obj_DashDust,Obj_dust_2.w
		move.w	#0,Player2_CPU_Routine.w
		move.l	#HudTailsIcon,Obj_player_2.w	; Spawn Tails spawn icon
		tst.b	Last_Starpole_Hit.w
		beq.s	.rts				; branch if no starpost was hit
		move.l	Saved_Obj_Tails.w,Obj_player_2.w; Spawn Tails
.rts		rts
; ---------------------------------------------------------------------------

.checkSonic	subq.w	#1,d0
		bne.s	.CheckTails			; branch if not Sonic alone

		move.l	#Obj_Sonic,Object_RAM.w		; spawn Sonic
		move.l	#Obj_DashDust,Obj_dust.w
		move.l	#Obj_Insta_Shield,Obj_shield.w
		move.w	#Object_RAM&$FFFF,Obj_shield+$42.w
		rts
; ---------------------------------------------------------------------------

.CheckTails	subq.w	#1,d0
		bne.s	.spawnKnuckles			; branch if not Tails alone

		move.l	#Obj_Tails,Object_RAM.w		; spawn Tails
		move.l	#Obj_DashDust,Obj_dust_2.w
		addi.w	#4,Object_RAM+ypos.w
		rts
; ---------------------------------------------------------------------------

.spawnKnuckles	move.l	#Obj_Knuckles,Object_RAM.w	; Spawn Knuckles
		move.l	#Obj_DashDust,Obj_dust.w
		rts
; ---------------------------------------------------------------------------

PauseGame:
		tst.b	Paused_Flag.w
		bne.s	.paused			; if already paused, branch

		move.b	Ctrl_1_Press.w,d0
		andi.b	#$80,d0
		beq.w	.rts			; if start is not pressed, end

.paused		st	Paused_Flag.w		; pause game
	stopZ80
		move.b	#1,Z80_RAM+$1C10	; pause music
	startZ80

.loop		move.b	#6,VInt_Routine.w
		jsr	wait_vsync.w
		tst.b	Slow_Motion_Flag.w	; is slow motion cheat enabled?
		beq.s	.chkStart		; if not, branch
		btst	#6,Ctrl_1_Press.w	; is A pressed?
		beq.s	.notA			; if not, branch
		bsr.s	.unpause2
		jmp	PauseMenu(pc)		; go to pause menu

.notA		btst	#5,Ctrl_1_Press.w	; is C pressed?
		bne.s	.unpause		; if is, branch

.chkStart	move.b	Ctrl_1_Press.w,d0
		andi.b	#$80,d0
		beq.w	.loop			; if start is not pressed, keep paused

.unpause2	sf	Paused_Flag.w
.unpause stopZ80
		move.b	#$80,Z80_RAM+$1C10	; unpause music
	startZ80

.rts		rts
; ---------------------------------------------------------------------------

LoadLevelSize:
		clr.b	Deform_Lock.w			; clear deformation lock
		clr.b	Scroll_Lock.w			; clear scrolling lock
		clr.b	Fast_V_scroll_flag.w		; clear fast scroll flag

		moveq	#0,d0
		move.w	d0,Dynamic_Resize_Routine.w	; clear dynamic resize routine
		move.w	d0,Camera_LockOff.w
		move.w	d0,BG_Layer_Scroll_Timer.w	;
		move.w	d0,BG_Layer_Scroll_Timer2.w	;

		move.w	#$6000,d0			; get left and right boundary
		move.l	d0,Camera_min_X.w		; store the minimum boundary
		move.l	d0,Camera_target_min_X.w	; store target boundary
		move.w	#$0310,d0			; get up and down boundary
		move.l	d0,Camera_min_Y.w		; store the minimum boundary
		move.l	d0,Camera_target_min_Y.w	; store target boundary

		move.w	#$60,Distance_from_screen_top.w	; set the screen height from player to default
		move.w	#-1,Screen_X_wrap_value.w	; no screen wrapping
		move.w	#-1,Screen_Y_wrap_value.w	; no screen wrapping

		tst.b	Last_Starpole_Hit.w
		beq.s	.nostarpost			; branch if no starpost was hit
		jsr	Load_Starpost_Settings		; get variables from starpost
		move.w	Object_RAM+xpos.w,d1		; get the x-pos and y-pos
		move.w	Object_RAM+ypos.w,d0		; for camera check
		bra.w	.normal

.nostarpost	move.w	StartLocSonic(pc),d1		; get x-position
		move.w	d1,Object_RAM+xpos.w		; move player there
		moveq	#0,d0
		move.w	StartLocSonic+2(pc),d0		; get y-position
		move.w	d0,Object_RAM+ypos.w		; move player there

.normal		subi.w	#(320/2),d1			; make Sonic go in the middle of the screen
		bhs.s	.xok				; if not negative, branch
		moveq	#0,d1				; make sure the screen stays in level boundaries

.xok		move.w	Camera_max_X.w,d2		; get camera max x-pos
		cmp.w	d2,d1				; compare against current camera x
		blo.s	.storex				; if less than max x
		move.w	d2,d1				; otherwise cap to max pos

.storex		move.w	d1,Camera_X.w			; store camera x-position

		subi.w	#96,d0				; make Sonic go roughly on the middle of the screen
		bhs.s	yok				; if not negative, branch
		moveq	#0,d0				; make sure the screen stays in level boundaries

yok		cmp.w	Camera_max_Y.w,d0		; check if we are below camera's max y-pos
		blt.s	.storey				; if we are not, branch
		move.w	Camera_max_Y.w,d0		; reset to max pos
.storey		move.w	d0,Camera_Y.w			; store camera x-position
		rts
; ---------------------------------------------------------------------------
StartLocSonic:		inceven "levels/ML/Sonic Start Location.bin"
; ---------------------------------------------------------------------------

LoadLevelLayout:
		lea	('X'<<24)|ML_Layout,a0
		lea	Level_layout_header.w,a1	; get layout header
		move.w	#(Nemdec_buffer-Level_layout_header)/4-1,d2
.loadlayout	move.l	(a0)+,(a1)+			; write word at a time
		dbf	d2,.loadlayout			; keep looping
		rts
; ---------------------------------------------------------------------------

InitOscValues:
		lea	Osc_Num.w,a1
		lea	.initvalues,a2
		moveq	#33-1,d1
.copyloop	move.w	(a2)+,(a1)+
		dbf	d1,.copyloop
		rts

; ---------------------------------------------------------------------------
.initvalues	dc.w $7D, $80, 0, $80
		dc.w 0, $80, 0, $80
		dc.w 0, $80, 0, $80
		dc.w 0, $80, 0, $80
		dc.w 0, $80, 0, $3848
		dc.w $EE, $2080, $B4, $3080
		dc.w $10E, $5080, $1C2, $7080
		dc.w $276, $80, 0, $4000
		dc.w $FE
; ---------------------------------------------------------------------------

sub_773C:
		cmpi.b	#6,Object_RAM+routine.w
		bhs.s	.rts

.multi		lea	Osc_Num.w,a1
		lea	word_7792,a2
		move.w	(a1)+,d3
		moveq	#16-1,d1

.loop		move.w	(a2)+,d2
		move.w	(a2)+,d4
		btst	d1,d3
		bne.s	.0

		move.w	2(a1),d0
		add.w	d2,d0
		move.w	d0,2(a1)
		add.w	d0,(a1)

		cmp.b	(a1),d4
		bhi.s	.next
		bset	d1,d3
		bra.s	.next

.0		move.w	2(a1),d0
		sub.w	d2,d0
		move.w	d0,2(a1)
		add.w	d0,(a1)

		cmp.b	(a1),d4
		bls.s	.next
		bclr	d1,d3

.next		addq.w	#4,a1
		dbf	d1,.loop
		move.w	d3,Osc_Num.w
.rts		rts

; ---------------------------------------------------------------------------
word_7792:	dc.w 2, $10, 2, $18
		dc.w 2, $20, 2, $30
		dc.w 4, $20, 8, 8
		dc.w 8, $40, 4, $40
		dc.w 2, $38, 2, $38
		dc.w 2, $20, 3, $30
		dc.w 5, $50, 7, $70
		dc.w 2, $40, 2, $40
; ---------------------------------------------------------------------------

sub_1AA6E:
		clr.w	Sprite_Draw_Flag.w
		clr.l	Use_normal_sprite_table.w
		lea	Sprite_Attribute_Table.w,a0

sub_1AAA2:
		moveq	#1,d1
		moveq	#$4F,d7

loc_1AAA8:
		clr.w	(a0)
		move.b	d1,3(a0)
		addq.w	#1,d1
		addq.w	#8,a0
		dbf	d7,loc_1AAA8
		clr.b	-5(a0)
		rts
; ---------------------------------------------------------------------------

AnimateTiles:
		movem.l	d0/a0/a5-a6,-(sp)			; store register data (d0 included simply to allocate memory space)
		lea	VDP_control_port,a6			; load VDP control port to a6
		move.w	Camera_BG_Y.w,d4			; load BG Y position
		cmpi.w	#$0150+$80,d4				; are we below all energy/pistons?
		bcc.s	AAGHZ_Energy				; if not, branch
		cmpi.w	#$0030+$80,d4				; are we above the energy/pistons?
		bcs.w	AAGHZ_NoPistons				; if so, branch

AAGHZ_Energy:

	; --- Bar Animation ---

		subq.w	#$01*$04,Level_Anim.w			; decrease frame counter
		bpl.s	AAGHZ_NoResetBar			; if still running, branch
		move.w	#($28-$01)*$04,Level_Anim.w		; reset frame counter

AAGHZ_NoResetBar:
		move.w	Level_Anim.w,d0				; load frame counter
		lea	AAGHZ_Bars(pc),a0			; load starting source address
		moveq	#$100/2,d3				; set DMA size ($100)
		move.l	(a0,d0.w),d1				; set DMA source
		move.w	#$140,d2				; set DMA destination
		jsr	AddQueueDMA				; and then fire DMA!

	; --- Orb Animation ---

		subq.b	#$01*$04,Level_Anim+8.w			; decrease frame counter
		bcc.s	AAGHZ_NoResetOrb			; if still running, branch
		move.b	#($1C-$01)*$04,Level_Anim+8.w		; reset frame counter

AAGHZ_NoResetOrb:
		moveq	#$00,d0					; clear d0
		move.b	Level_Anim+8.w,d0			; load frame counter
		lea	AAGHZ_Orbs(pc),a0			; load starting source address
		move.w	#($120/2),d3				; set DMA size ($120)
		move.l	(a0,d0.w),d1				; set DMA source
		moveq	#$20,d2					; set DMA destination
		jsr	AddQueueDMA				; and then fire DMA!

; ---------------------------------------------------------------------------
; Pistons...
; ---------------------------------------------------------------------------

AAGHZ_NoEnergy:
		cmpi.w	#$01C0+$80,d4				; are we below the energy machines BUT still showing the upside-down pistons?
		bcc.s	AAGHZ_NoPistons				; if not, and further below, branch

	; --- Pistons ---
		lea	AAGHZ_Pistons(pc),a0			; load starting source address

		; First piston...

		subq.b	#$01*$04,Level_Anim+2.w			; decrease frame counter
		bcc.s	AAGHZ_NoResetPiston			; if still running, branch
		move.b	#($12-$01)*$04,Level_Anim+2.w		; reset frame counter

AAGHZ_NoResetPiston:
		moveq	#$00,d0					; clear d0
		move.b	Level_Anim+2.w,d0			; load frame counter
		move.w	#$A0/2,d3				; set DMA size ($A0)
		move.l	(a0,d0.w),d1				; set DMA source
		move.w	#$240,d2				; set DMA destination
		jsr	AddQueueDMA				; and then fire DMA!

		; Second piston...
		moveq	#$00,d0					; clear d0
		move.b	Level_Anim+2.w,d0			; load frame counter
		subi.w	#($12*$04)/$02,d0			; get opposite frame for other piston
		bcc.s	AAGHZ_NoWrapPiston			; if it hasn't dropped below wrap point, branch
		addi.w	#$12*$04,d0				; advance back up again

AAGHZ_NoWrapPiston:
		move.w	#$A0/2,d3				; set DMA size ($A0)
		move.l	(a0,d0.w),d1				; set DMA source
		move.w	#$240+$A0,d2				; set DMA destination
		jsr	AddQueueDMA				; and then fire DMA!

; ---------------------------------------------------------------------------
; Above for the sky
; ---------------------------------------------------------------------------

AAGHZ_NoPistons:
		cmpi.w	#$0080+$80,d4				; are we below the sky?
		bcc.s	AAGHZ_Middle				; if so, branch

	; --- Blue Sky (Behind Bricks) ---

		move.w	Scroll_Block_Buffer+$0E.w,d0		; load brick's speed
		sub.w	Scroll_Block_Buffer+$00.w,d0		; minus sky's speed
		lsl.w	#$02,d0					; multiply by 4 (4 bytes per entry in the table)
		neg.w	d0					; reverse direction (since scrolling is polar opposite)
		andi.w	#$003C,d0				; wrap/division
		cmp.b	Level_Anim+3.w,d0			; have the bricks moved?
		beq.s	AAGHZ_NoMoveBlueSky			; if not, branch
		move.b	d0,Level_Anim+3.w			; update

		lea	AAGHZ_BlueSky(pc),a0			; load starting source address
		move.w	#$A0/2,d3				; set DMA size ($A0)
		move.l	(a0,d0.w),d1				; set DMA source
		move.w	#$580,d2				; set DMA destination
		jsr	AddQueueDMA				; and then fire DMA!

AAGHZ_NoMoveBlueSky:

; ---------------------------------------------------------------------------
; Middle section pylons
; ---------------------------------------------------------------------------

AAGHZ_Middle:
		cmpi.w	#$00F8+$80,d4				; are we below the pylon? (Only the animated one)
		bcc.s	AAGHZ_Below				; if so, branch

	; --- Pylon ---

		move.w	Scroll_Block_Buffer+$0A.w,d0		; load pylon beam's speed
		sub.w	Scroll_Block_Buffer+$06.w,d0		; minus backwall's speed
		lsl.w	#$02,d0					; multiply by 8 (8 bytes per entry in the table)
		neg.w	d0					; reverse direction (since scrolling is polar opposite)
		andi.w	#$FC,d0					; wrap/division
		cmp.w	Level_Anim+4.w,d0			; has the pylon/bg moved?
		beq.s	AAGHZ_NoMovePylon			; if not, branch
		move.w	d0,Level_Anim+4.w			; update

		lea	AAGHZ_Pylons(pc),a0			; load starting source address
		move.w	#$200/2,d3				; set DMA size ($200)
		move.l	(a0,d0.w),d1				; set DMA source
		move.w	#$380,d2				; set DMA destination
		jsr	AddQueueDMA				; and then fire DMA!

AAGHZ_NoMovePylon:
		movem.l	(sp)+,d0/a0/a5-a6			; restore register data
		rts						; return

; ---------------------------------------------------------------------------
; Below for the pillars, etc...
; ---------------------------------------------------------------------------

AAGHZ_Below:
	; --- Roof Ridges ---

		move.w	Scroll_Block_Buffer+$12.w,d1		; load pillar's scroll position
		lsr.w	#$01,d1					; divide by 2
		andi.w	#$00FF,d1				; keep in range of 100 frames
		cmp.b	Level_Anim+5.w,d1			; have the bricks moved?
		beq.s	AAGHZ_NoMoveRoof			; if not, branch
		move.b	d1,Level_Anim+5.w			; update
		lsl.w	#$08,d1					; multiply by 100 (then divide by 2)
		addi.l	#TP_RoofRidge,d1			; add starting add address to get correct frame address
		move.w	#$100/2,d3				; set DMA size ($100)
		move.w	#$620,d2				; set DMA destination
		jsr	AddQueueDMA				; and then fire DMA!

AAGHZ_NoMoveRoof:

	; --- Distant Pillars ---

		move.w	Scroll_Block_Buffer+$12.w,d0		; load pillar's scroll position
		neg.w	d0					; reverse direction
		subq.w	#$01,d0					; align with roof (neg causes a 1 pixel drift)
		andi.w	#$003F,d0				; keep in range of 40 frames (multiples of 2)
		cmp.b	Level_Anim+6.w,d0			; have the bricks moved?
		beq.s	AAGHZ_NoMoveDistPillar			; if not, branch
		move.b	d0,Level_Anim+6.w			; update
		lsl.w	#$02,d0					; multiply by x4

		lea	AAGHZ_DistPill(pc),a0
		moveq	#$80/2,d3				; set DMA size ($80)
		move.w	#$820,d2				; set DMA destination
		move.l	(a0,d0.w),d1				; set DMA source
		jsr	AddQueueDMA				; and then fire DMA!

AAGHZ_NoMoveDistPillar:

	; --- Pillars ---

		move.w	Scroll_Block_Buffer+$12.w,d0		; load pillar's scroll position
		neg.w	d0					; reverse direction
		subq.w	#$01,d0					; align with roof (neg causes a 1 pixel drift)
		andi.w	#$003E,d0				; keep in range of 20 frames (multiples of 2)
		cmp.b	Level_Anim+7.w,d0			; have the bricks moved?
		beq.s	AAGHZ_NoMovePillar			; if not, branch
		move.b	d0,Level_Anim+7.w			; update
		add.b	d0,d0					; multiply to x4

		move.w	#$100/2,d3				; set DMA size ($100)
		move.l	AAGHZ_Pillar(pc,d0.w),d1		; set DMA source
		move.w	#$720,d2				; set DMA destination
		jsr	AddQueueDMA				; and then fire DMA!

AAGHZ_NoMovePillar:
		movem.l	(sp)+,d0/a0/a5-a6			; restore register data
		rts						; return

; ---------------------------------------------------------------------------
; DMA source register data
; ---------------------------------------------------------------------------

AAGHZ_Pillar:
	dc.l TP_BotPillar+($1F*$100), TP_BotPillar+($1E*$100), TP_BotPillar+($1D*$100)
	dc.l TP_BotPillar+($1C*$100), TP_BotPillar+($1B*$100), TP_BotPillar+($1A*$100)
	dc.l TP_BotPillar+($19*$100), TP_BotPillar+($18*$100), TP_BotPillar+($17*$100)
	dc.l TP_BotPillar+($16*$100), TP_BotPillar+($15*$100), TP_BotPillar+($14*$100)
	dc.l TP_BotPillar+($13*$100), TP_BotPillar+($12*$100), TP_BotPillar+($11*$100)
	dc.l TP_BotPillar+($10*$100), TP_BotPillar+($0F*$100), TP_BotPillar+($0E*$100)
	dc.l TP_BotPillar+($0D*$100), TP_BotPillar+($0C*$100), TP_BotPillar+($0B*$100)
	dc.l TP_BotPillar+($0A*$100), TP_BotPillar+($09*$100), TP_BotPillar+($08*$100)
	dc.l TP_BotPillar+($07*$100), TP_BotPillar+($06*$100), TP_BotPillar+($05*$100)
	dc.l TP_BotPillar+($04*$100), TP_BotPillar+($03*$100), TP_BotPillar+($02*$100)
	dc.l TP_BotPillar+($01*$100), TP_BotPillar+($00*$100)

AAGHZ_DistPill:
	dc.l TP_DistPillar+($3F*$80), TP_DistPillar+($3E*$80), TP_DistPillar+($3D*$80)
	dc.l TP_DistPillar+($3C*$80), TP_DistPillar+($3B*$80), TP_DistPillar+($3A*$80)
	dc.l TP_DistPillar+($39*$80), TP_DistPillar+($38*$80), TP_DistPillar+($37*$80)
	dc.l TP_DistPillar+($36*$80), TP_DistPillar+($35*$80), TP_DistPillar+($34*$80)
	dc.l TP_DistPillar+($33*$80), TP_DistPillar+($32*$80), TP_DistPillar+($31*$80)
	dc.l TP_DistPillar+($30*$80), TP_DistPillar+($2F*$80), TP_DistPillar+($2E*$80)
	dc.l TP_DistPillar+($2D*$80), TP_DistPillar+($2C*$80), TP_DistPillar+($2B*$80)
	dc.l TP_DistPillar+($2A*$80), TP_DistPillar+($29*$80), TP_DistPillar+($28*$80)
	dc.l TP_DistPillar+($27*$80), TP_DistPillar+($26*$80), TP_DistPillar+($25*$80)
	dc.l TP_DistPillar+($24*$80), TP_DistPillar+($23*$80), TP_DistPillar+($22*$80)
	dc.l TP_DistPillar+($21*$80), TP_DistPillar+($20*$80), TP_DistPillar+($1F*$80)
	dc.l TP_DistPillar+($1E*$80), TP_DistPillar+($1D*$80), TP_DistPillar+($1C*$80)
	dc.l TP_DistPillar+($1B*$80), TP_DistPillar+($1A*$80), TP_DistPillar+($19*$80)
	dc.l TP_DistPillar+($18*$80), TP_DistPillar+($17*$80), TP_DistPillar+($16*$80)
	dc.l TP_DistPillar+($15*$80), TP_DistPillar+($14*$80), TP_DistPillar+($13*$80)
	dc.l TP_DistPillar+($12*$80), TP_DistPillar+($11*$80), TP_DistPillar+($10*$80)
	dc.l TP_DistPillar+($0F*$80), TP_DistPillar+($0E*$80), TP_DistPillar+($0D*$80)
	dc.l TP_DistPillar+($0C*$80), TP_DistPillar+($0B*$80), TP_DistPillar+($0A*$80)
	dc.l TP_DistPillar+($09*$80), TP_DistPillar+($08*$80), TP_DistPillar+($07*$80)
	dc.l TP_DistPillar+($06*$80), TP_DistPillar+($05*$80), TP_DistPillar+($04*$80)
	dc.l TP_DistPillar+($03*$80), TP_DistPillar+($02*$80), TP_DistPillar+($01*$80)
	dc.l TP_DistPillar+($00*$80)

AAGHZ_Orbs:
	dc.l TP_PowerOrb+($1B*$120), TP_PowerOrb+($1A*$120), TP_PowerOrb+($19*$120)
	dc.l TP_PowerOrb+($18*$120), TP_PowerOrb+($17*$120), TP_PowerOrb+($16*$120)
	dc.l TP_PowerOrb+($15*$120), TP_PowerOrb+($14*$120), TP_PowerOrb+($13*$120)
	dc.l TP_PowerOrb+($12*$120), TP_PowerOrb+($11*$120), TP_PowerOrb+($10*$120)
	dc.l TP_PowerOrb+($0F*$120), TP_PowerOrb+($0E*$120), TP_PowerOrb+($0D*$120)
	dc.l TP_PowerOrb+($0C*$120), TP_PowerOrb+($0B*$120), TP_PowerOrb+($0A*$120)
	dc.l TP_PowerOrb+($09*$120), TP_PowerOrb+($08*$120), TP_PowerOrb+($07*$120)
	dc.l TP_PowerOrb+($06*$120), TP_PowerOrb+($05*$120), TP_PowerOrb+($04*$120)
	dc.l TP_PowerOrb+($03*$120), TP_PowerOrb+($02*$120), TP_PowerOrb+($01*$120)
	dc.l TP_PowerOrb+($00*$120)

AAGHZ_Pistons:
	dc.l TP_Piston+($11*$0A0), TP_Piston+($10*$0A0), TP_Piston+($0F*$0A0)
	dc.l TP_Piston+($0E*$0A0), TP_Piston+($0D*$0A0), TP_Piston+($0C*$0A0)
	dc.l TP_Piston+($0B*$0A0), TP_Piston+($0A*$0A0), TP_Piston+($09*$0A0)
	dc.l TP_Piston+($08*$0A0), TP_Piston+($07*$0A0), TP_Piston+($06*$0A0)
	dc.l TP_Piston+($05*$0A0), TP_Piston+($04*$0A0), TP_Piston+($03*$0A0)
	dc.l TP_Piston+($02*$0A0), TP_Piston+($01*$0A0), TP_Piston+($00*$0A0)

AAGHZ_Bars:
	dc.l TP_PowerBar+($27*$100), TP_PowerBar+($26*$100), TP_PowerBar+($25*$100)
	dc.l TP_PowerBar+($24*$100), TP_PowerBar+($23*$100), TP_PowerBar+($22*$100)
	dc.l TP_PowerBar+($21*$100), TP_PowerBar+($20*$100), TP_PowerBar+($1F*$100)
	dc.l TP_PowerBar+($1E*$100), TP_PowerBar+($1D*$100), TP_PowerBar+($1C*$100)
	dc.l TP_PowerBar+($1B*$100), TP_PowerBar+($1A*$100), TP_PowerBar+($19*$100)
	dc.l TP_PowerBar+($18*$100), TP_PowerBar+($17*$100), TP_PowerBar+($16*$100)
	dc.l TP_PowerBar+($15*$100), TP_PowerBar+($14*$100), TP_PowerBar+($13*$100)
	dc.l TP_PowerBar+($12*$100), TP_PowerBar+($11*$100), TP_PowerBar+($10*$100)
	dc.l TP_PowerBar+($0F*$100), TP_PowerBar+($0E*$100), TP_PowerBar+($0D*$100)
	dc.l TP_PowerBar+($0C*$100), TP_PowerBar+($0B*$100), TP_PowerBar+($0A*$100)
	dc.l TP_PowerBar+($09*$100), TP_PowerBar+($08*$100), TP_PowerBar+($07*$100)
	dc.l TP_PowerBar+($06*$100), TP_PowerBar+($05*$100), TP_PowerBar+($04*$100)
	dc.l TP_PowerBar+($03*$100), TP_PowerBar+($02*$100), TP_PowerBar+($01*$100)
	dc.l TP_PowerBar+($00*$100)

AAGHZ_Pylons:
	dc.l TP_Pylon+($3F*$200), TP_Pylon+($3E*$200), TP_Pylon+($3D*$200)
	dc.l TP_Pylon+($3C*$200), TP_Pylon+($3B*$200), TP_Pylon+($3A*$200)
	dc.l TP_Pylon+($39*$200), TP_Pylon+($38*$200), TP_Pylon+($37*$200)
	dc.l TP_Pylon+($36*$200), TP_Pylon+($35*$200), TP_Pylon+($34*$200)
	dc.l TP_Pylon+($33*$200), TP_Pylon+($32*$200), TP_Pylon+($31*$200)
	dc.l TP_Pylon+($30*$200), TP_Pylon+($2F*$200), TP_Pylon+($2E*$200)
	dc.l TP_Pylon+($2D*$200), TP_Pylon+($2C*$200), TP_Pylon+($2B*$200)
	dc.l TP_Pylon+($2A*$200), TP_Pylon+($29*$200), TP_Pylon+($28*$200)
	dc.l TP_Pylon+($27*$200), TP_Pylon+($26*$200), TP_Pylon+($25*$200)
	dc.l TP_Pylon+($24*$200), TP_Pylon+($23*$200), TP_Pylon+($22*$200)
	dc.l TP_Pylon+($21*$200), TP_Pylon+($20*$200), TP_Pylon+($1F*$200)
	dc.l TP_Pylon+($1E*$200), TP_Pylon+($1D*$200), TP_Pylon+($1C*$200)
	dc.l TP_Pylon+($1B*$200), TP_Pylon+($1A*$200), TP_Pylon+($19*$200)
	dc.l TP_Pylon+($18*$200), TP_Pylon+($17*$200), TP_Pylon+($16*$200)
	dc.l TP_Pylon+($15*$200), TP_Pylon+($14*$200), TP_Pylon+($13*$200)
	dc.l TP_Pylon+($12*$200), TP_Pylon+($11*$200), TP_Pylon+($10*$200)
	dc.l TP_Pylon+($0F*$200), TP_Pylon+($0E*$200), TP_Pylon+($0D*$200)
	dc.l TP_Pylon+($0C*$200), TP_Pylon+($0B*$200), TP_Pylon+($0A*$200)
	dc.l TP_Pylon+($09*$200), TP_Pylon+($08*$200), TP_Pylon+($07*$200)
	dc.l TP_Pylon+($06*$200), TP_Pylon+($05*$200), TP_Pylon+($04*$200)
	dc.l TP_Pylon+($03*$200), TP_Pylon+($02*$200), TP_Pylon+($01*$200)
	dc.l TP_Pylon+($00*$200)

AAGHZ_BlueSky:
	dc.l TP_BlueSky+($0F*$0A0), TP_BlueSky+($0E*$0A0), TP_BlueSky+($0D*$0A0)
	dc.l TP_BlueSky+($0C*$0A0), TP_BlueSky+($0B*$0A0), TP_BlueSky+($0A*$0A0)
	dc.l TP_BlueSky+($09*$0A0), TP_BlueSky+($08*$0A0), TP_BlueSky+($07*$0A0)
	dc.l TP_BlueSky+($06*$0A0), TP_BlueSky+($05*$0A0), TP_BlueSky+($04*$0A0)
	dc.l TP_BlueSky+($03*$0A0), TP_BlueSky+($02*$0A0), TP_BlueSky+($01*$0A0)
	dc.l TP_BlueSky+($00*$0A0)
