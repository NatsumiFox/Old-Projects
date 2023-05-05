; ===========================================================================
; ---------------------------------------------------------------------------
; V-blank
; ---------------------------------------------------------------------------

VB_OAZ_Null:
		move.w	#$8F02,($C00004).l			; force VDP auto increment to normal again (just in case of lag)

		movem.l	d0-a6,-(sp)				; store registers
		addq.l	#$01,(V_int_run_count).w		; increase frame counter
		tst.b	(V_int_routine).w			; was the 68k late?
		beq.w	VB_OAZ_68kLate				; if so, branch
		jsr	Poll_Controllers			; read controllers

	; --- Transfers ---

		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
	;move.w	#$8C00|%10001001,(a6)			; APHE SNNB - H-resol (0N|1Y) | Pixel int (0N|1Y) | H-sync (0N|1Y) | Extern-pix (0N|1Y) | S/H (0N|1Y) | Interlace (00N|01Y|11-Split) | H-resol (0-20|1-28)
		bsr.w	VB_OAZ_HBlank				; run H-blank setup
		jsr	DrawDebugMap				; draw debug map numbers
		DMA_OAZ	$0380,$70000003,H_scroll_buffer		; Hscroll
		DMA_OAZ	$0280,$78000003,Sprite_table_buffer	; Sprites
		cmpi.w	#OAZ1_ReflectPos,(Camera_Y_pos_copy).w	; has the screen reached the bottom floor section?
		bge.s	VB_OAZ_ReflectPal			; if so, branch
		DMA_OAZ	$0080,$C0000000,Normal_palette		; Palette
		bra.s	VB_OAZ_NormalPal			; continue

VB_OAZ_ReflectPal:
		DMA_OAZ	$0060,$C0000000,Normal_palette		; Palette
		DMA_OAZ	$0020,$C0600000,OAZ1_PalReflect		; Reflection palette

VB_OAZ_NormalPal:

		bsr.w	VB_OAZ_Animation

	; --- Standard stuff normal V-blank does in S3K below ---

		jsr	Process_DMA_Queue			; process the DMA queue list
		lea	(VB_OAZ_Level).l,a1			; load level's routine
		cmpi.b	#$0C,(V_int_routine).w			; is the routine set to title card's?
		bne.s	VB_OAZ_NoCards				; if not, branch
		lea	(VB_OAZ_NoDemo).l,a1		; load title card V-blank routine

VB_OAZ_NoCards:
		jsr	(a1)					; run V-blank routine
		pea	VB_OAZ_Finish(pc)			; set to run finishing routine afterwards
		jmp	(Set_Kos_Bookmark).l			; allow kosinski to continue if it was interrupted by V-blank

	; --- When V-blank occurs while the 68k isn't ready (ala; lag) ---

VB_OAZ_68kLate:
		addq.w	#$01,(Lag_frame_count).w		; increase the lag frame counter
		lea	($C00000).l,a5				; load VDP data port
		lea	$04(a5),a6				; load VDP control port
		bsr.w	VB_OAZ_HBlank				; run H-blank setup

VB_OAZ_Finish:
		sf.b	(V_int_routine).w			; set V-blank as ran
		movem.l	(sp)+,d0-a6				; restore registers
		rte						; return

; ---------------------------------------------------------------------------
; Normal Level V-blank ($08)
; ---------------------------------------------------------------------------
; The title cards don't do any of the below to save time, they only run
; Process_Nem_Queue (not _2), and that's it.  All below never run during
; title card.
; ---------------------------------------------------------------------------

VB_OAZ_Level:
		jsr	(VInt_DrawLevel).l			; do level tile maps transfer
		lea	VDP_data_port,a6			; load data port to a6 (because they like it that way...)
		moveq	#$00,d1					; clear d1
		lea	(DrawDebugNumbers-$08).l,a1		; load address of debug routine
		tst.b	(Debug_On).w				; is debug mode enabled?
		bne.s	VB_OAZ_Debug				; if so, branch
		move.l	(ModeTable).w,a1			; load the mode list table

VB_OAZ_Debug:
		jsr	$08(a1)					; run correct update routine

		clr.w	(Lag_frame_count).w			; clear the lag counter
		tst.w	(Demo_timer).w				; is demo mode on?
		beq.w	VB_OAZ_NoDemo				; if not, branch
		subq.w	#$01,(Demo_timer).w			; decrease demo timer

VB_OAZ_NoDemo:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Setting up H-blank
; ---------------------------------------------------------------------------

VB_OAZ_HBlank:
		move.l	#HB_OAZ_NULL,(H_int_addr).w		; set H-blank address to nothing
		move.w	#$8AFF,(a6)				; set no H-blank interrupt line
		cmpi.w	#OAZ1_FloorPos,(Camera_Y_pos_copy).w	; has the screen reached the bottom floor section?
		bgt.s	VB_OAZ_SetHBlank			; if so, branch
		move.l	#$40000010,(a6)				; set VSRAM write mode
		move.l	(V_scroll_value).w,(a5)			; Vscroll
		rts						; return

VB_OAZ_SetHBlank:
		lea	($FFFFA800).w,a0			; load V-scroll buffer..
		move.w	(a0),d0					; load buffer status
		tst.b	(V_int_routine).w			; was the 68k late?
		beq.s	VB_OAZF_68kLate				; if so, branch
		tst.w	(Game_paused).w				; is the game paused?
		beq.s	VB_OAZ_NoPause				; if not, branch
		tas.b	d0					; set the pause flag
		beq.s	VB_OAZF_PauseFlag			; if the flag was not set yet, branch
		bra.s	VB_OAZF_68kLate				; continue

VB_OAZ_NoPause:
		sf.b	d0					; clear pause flag

VB_OAZF_PauseFlag:
		addi.w	#$8000,d0				; change buffer
		move.w	d0,(a0)					; save buffer status

VB_OAZF_68kLate:
		tst.w	(a0)+					; check buffer
		bpl.s	VB_OAZF_Buffer1				; if we're now using buffer 1, branch
		lea	$100(a0),a0				; use buffer 2

VB_OAZF_Buffer1:
		move.w	#$8A00,(a6)				; set interrupt position
		move.l	#HB_OAZ_Start,(H_int_addr).w		; set starting H-blank address
		move.l	#$40000010,(a6)				; set VDP VSRAM write mode address
		move.l	2+4(a0),(a5)				; write first V-scroll position
		move.l	a0,usp					; save to usp for H-blank
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to animate clouds
; ---------------------------------------------------------------------------

VB_OAZ_Animation:

	; --- Pillar flames ---

		subq.b	#$01,(Anim_Counters+$A).w
		bpl.s	VB_OAZ_FlameOK
		move.b	#$01,(Anim_Counters+$A).w
		bra.s	VB_OAZ_NoFlame

VB_OAZ_FlameOK:
		moveq	#$00,d0					; clear d0
		move.w	(Anim_Counters+8).w,d0			; load frame position
	;subi.w	#$0900>>1,(Anim_Counters+8).w		; decrease frame counter
	subi.w	#$0100>>1,(Anim_Counters+8).w		; decrease frame counter
		bpl.s	VB_OAZ_FlameReset			; if not finished, branch
		addi.w	#$1100>>1,(Anim_Counters+8).w		; reset animation

VB_OAZ_FlameReset:
		addi.l	#OAZ1_FlameAni>>1,d0			; prepare flame address
		move.l	#$94009380,(a6)				; set DMA size
		move.l	#$96009500,d1				; prepare DMA source registers
		move.b	d0,d1					; get lower source byte
		swap	d1					; store away
		lsr.w	#$08,d0					; get upper source byte
		move.b	d0,d1					; ''
		move.l	d1,(a6)					; set DMA source
		move.w	#$4F20,d0				; prepare destination address
		ori.l	#$97000000,d0				; set DMA source register
		move.l	d0,(a6)					; set DMA source and first half of destination
		move.w	#$0080,(a6)				; set last destination

VB_OAZ_NoFlame:

	; --- Cloud parallax ---

		move.w	($FFFF7F80+$06).l,d0			; load cloud position
		cmp.w	(Anim_Counters+6).w,d0			; has it moved?
		beq.s	VB_OAZ_CloudMoon			; if not, branch
		move.w	d0,(Anim_Counters+6).w			; update
		neg.w	d0					; reverse direction
		andi.l	#$0000003F,d0				; get frame position
		lsl.w	#$08,d0					; multiply to x8 tiles worth
		addi.l	#OAZ1_CloudAni,d0			; prepare clouds address
		lsr.l	#$01,d0					; divide by 1 due to word transfer
		move.l	#$94009380,(a6)				; set DMA size
		move.l	#$96009500,d1				; prepare DMA source registers
		move.b	d0,d1					; get lower source byte
		swap	d1					; store away
		lsr.w	#$08,d0					; get upper source byte
		move.b	d0,d1					; ''
		move.l	d1,(a6)					; set DMA source
		move.w	#$4E20,d0				; prepare destination address
		ori.l	#$97000000,d0				; set DMA source register
		move.l	d0,(a6)					; set DMA source and first half of destination
		move.w	#$0080,(a6)				; set last destination

; ---------------------------------------------------------------------------
; Subroutine to render a cloud mask over the moon/sky
; ---------------------------------------------------------------------------

VB_OAZ_CloudMoon:

	; To save on CPU time, these clouds are rendered perfectly time such
	; that only one cloud will ever render at a time.

	; Two slow moving clouds rendering once every four frames (one every second frame).
	; One fast moving cloud rendering once every two frames (every odd frame).


		move.w	(V_int_run_count+$02).w,d0		; load cloud position
		neg.w	d0					; reverse direction
		addq.w	#$01,d0					; disposition so it doesn't render the same frame as the last cloud
		asr.w	#$01,d0					; slow it down
		addi.w	#$0040,d0				; move cloud to the right a few tiles
		move.w	d0,d1					; get if this is the cloud's second scroll cycle
		andi.w	#$0200,d1				; ''
		beq.s	VB_OAZCM_Cloud02			; if it's just the first cycle, branch (only show the cloud every 2 cycles so it doesn't overlap the other two clouds)
		cmp.w	(Anim_Counters).w,d0			; has the position changed?
		beq.s	VB_OAZCM_Cloud02			; if not, branch
		move.w	d0,(Anim_Counters).w			; update position
		lea	(OAZ1_CloudMask1).l,a1			; load mask art
		bsr.s	VB_OAZCM_DrawCloud			; render the cloud

VB_OAZCM_Cloud02:
		move.w	(V_int_run_count+$02).w,d0		; load cloud position
		neg.w	d0					; reverse direction
		asr.w	#$02,d0					; slow it down
		cmp.w	(Anim_Counters+2).w,d0			; has the position changed?
		beq.s	VB_OAZCM_Cloud03			; if not, branch
		move.w	d0,(Anim_Counters+2).w			; update position
		addi.w	#$0100,d0				; move cloud to opposite position
		lea	(OAZ1_CloudMask2).l,a1			; load mask art
		bsr.s	VB_OAZCM_DrawCloud			; render the cloud

VB_OAZCM_Cloud03:
		move.w	(V_int_run_count+$02).w,d0		; load cloud position
		neg.w	d0					; reverse direction
		addq.w	#$02,d0					; disposition so it doesn't render the same frame as the last cloud
		asr.w	#$02,d0					; slow it down
		cmp.w	(Anim_Counters+4).w,d0			; has the position changed?
		beq.s	VB_OAZCM_Finish				; if not, branch
		move.w	d0,(Anim_Counters+4).w			; update position
		addq.w	#$04,d0					; move cloud out the way of the fast moving cloud (just barely touches)
		lea	(OAZ1_CloudMask3).l,a1			; load mask art

; ---------------------------------------------------------------------------
; Cloud rendering
; ---------------------------------------------------------------------------

VB_OAZCM_DrawCloud:
		move.w	d0,d1					; copy to d1
		andi.l	#$000001F8,d1				; get tile position
		cmpi.w	#320+64,d1				; is the cloud fully off-screen?
		bhs.s	VB_OAZCM_Finish				; if so, branch
		lsl.w	#$03,d1					; multiply to x40 (2 tiles)
		lea	(OAZ1_CloudMoon-($40*8)).l,a0		; load moon art
		adda.w	d1,a0					; advance to correct tiles
		addi.w	#$4020,d1				; setup for VDP
		swap	d1					; ''
		move.l	d1,(a6)					; ''
		andi.w	#$0007,d0				; get only pixel position
		move.w	(a1)+,d7				; load number of coloumns to render
		move.w	d7,d1					; copy to calculate the frame position
		lsl.w	#$06,d1					; multiply by 40 (2 tiles of data), this gets the cloud frame's tile size
		mulu.w	d1,d0					; multiply pixel position by frame size
		adda.w	d0,a1					; advance to correct pixel mask position
		dbf	d7,VB_OAZCM_NextColumn			; repeat for all columns

VB_OAZCM_Finish:
		rts						; return

VB_OAZCM_NextColumn:

	; Interlacing the sub and move operations "should" help reduce
	; on filling up the FIFO as often, so it should be slightly faster
	; than mass sub followed by mass move.

	rept	2
		movem.l	(a0)+,d0-d6/a2
		sub.l	(a1)+,d0
		move.l	d0,(a5)
		sub.l	(a1)+,d1
		move.l	d1,(a5)
		sub.l	(a1)+,d2
		move.l	d2,(a5)
		sub.l	(a1)+,d3
		move.l	d3,(a5)
		sub.l	(a1)+,d4
		move.l	d4,(a5)
		sub.l	(a1)+,d5
		move.l	d5,(a5)
		sub.l	(a1)+,d6
		move.l	d6,(a5)
		sub.l	(a1)+,a2
		move.l	a2,(a5)
	endm
		dbf	d7,VB_OAZCM_NextColumn			; repeat for all columns
		rts						; return

; ===========================================================================





