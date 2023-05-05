; ===========================================================================
; ---------------------------------------------------------------------------
; Pausing/unpausing loop
; ---------------------------------------------------------------------------
EPG_PauseRAM	=	PauseSpriteRAM			; some RAM space to do shit with
EPG_SpeedY	=	$00				; Y speed of HUD going up
EPG_MenuX	=	$04				; X distance of menu from centre
EPG_SelectP1	=	$08				; player 1's selection
EPG_DoneP1	=	$09				; player 1's selected flag
EPG_PosP1	=	$0A				; player 1's position
EPG_SelectP2	=	$0C				; player 2's selection
EPG_DoneP2	=	$0D				; player 2's selected flag
EPG_PosP2	=	$0E				; player 2's position
EPG_SpriteStore	=	EPG_PauseRAM+$10		; RAM address to store HUD sprites
; ---------------------------------------------------------------------------
EPG_HUDVRAM	=	AT_HUD*$20			; starting VRAM where HUD is
EPG_ENDVRAM	=	AT_HUD_End*$20			; end VRAM address where HUD finishes
EPG_PAUVRAM2	=	$5F4*$20			; second VRAM address where to dump the pause art (won't fit in normal HUD area)
EPG_ENDVRAM2	=	EPG_PAUVRAM2+$400		; end VRAM address where pause art will finish
EPG_SelectPos	=	$0400				; relative address where selector art in ROM is
EPG_SelectVRAM	=	EPG_HUDVRAM+EPG_SelectPos	; VRAM address where selector art is
; ---------------------------------------------------------------------------

Pause_Game:
		move.b	(Ctrl_1_pressed).w,d0			; load player 1 pressed buttons
		or.b	(Ctrl_2_pressed).w,d0			; fuse with player 2 pressed buttons
		bmi.s	PG_CheckCredits				; if either player pressed start, branch
		rts						; return (no start pressed)

	; --- Credits check ---

PG_CheckCredits:
		cmpi.b	#$06,(playmode).w			; is this a mini-game?
		bne.s	PG_NoCredits				; if not, branch
		cmpi.w	#$1601,(Current_zone_and_act).w		; is this Hidden Palace Zone?
		bne.s	PG_NoCredits				; if not, branch
		move.b	#$04,(Game_Mode).w			; this is the credits, so go back to Main Menu
		rts						; return

PG_NoCredits:
		move.w	#$0001,(Game_paused).w			; set pause flag
	stopZ80
		move.b	#$01,(Z80_RAM+zPauseFlag).l		; pause the music
	startZ80

	; --- Init ---

		lea	(EPG_PauseRAM).w,a0			; load pause RAM
		moveq	#$00,d0					; clear d0
		move.l	d0,(a0)+				; clear pause RAM
		move.l	d0,(a0)+				; ''
		move.l	d0,(a0)+				; ''
		move.l	d0,(a0)+				; ''

		st.b	(EPG_PauseRAM+EPG_DoneP1).w		; clear player 1's selected menu item
		st.b	(EPG_PauseRAM+EPG_DoneP2).w		; clear player 2's selected menu item

		bsr.w	PG_FindHudSprites			; find all HUD sprites and store them

		tst.b	(Debug_mode_flag).w			; is debug mode enabled?
		beq.s	PG_MoveHudOut				; if not, branch and ignore window
		move.w	#$9200,($C00004).l			; move window off screen

; ---------------------------------------------------------------------------
; Moving HUD out
; ---------------------------------------------------------------------------

PG_MoveHudOut:
		move.w	(EPG_PauseRAM+EPG_SpeedY).w,d0		; load Y speed
		addi.l	#$00008000,(EPG_PauseRAM+EPG_SpeedY).w	; increase Y speed
		lea	(EPG_SpriteStore).w,a1			; load sprite HUD list
		moveq	#-$01,d2				; reset complete counter
		move.w	(a1)+,d4				; load number of HUD sprites there are
		bmi.s	PG_MHO_NoSprites			; if there are no HUD sprites, branch

PG_MHO_NextSprite:
		movea.w	(a1)+,a0				; set sprite table address
		move.w	(a0),d1					; load Y position
		cmpi.w	#$0080+(224/2),d1			; is the sprite on the bottom half of the screen?
		blo.s	PG_MHO_ContinueUp			; if not, branch
		add.w	d0,d1					; move sprite down
		add.w	d0,d1					; counter the "sub" below

PG_MHO_ContinueUp:
		sub.w	d0,d1					; move sprite up
		cmpi.w	#$0080-$20,d1				; has it gone above the screen?
		bhi.s	PG_MHO_OnScreen				; if not, branch
		move.w	#$0080-$20,d1				; force to top of screen
		addq.w	#$01,d2					; increase complete counter
		bra.s	PG_MHO_NotBelow				; continue

PG_MHO_OnScreen:
		cmpi.w	#$0080+224,d1				; has the sprite gone below the screen?
		blo.s	PG_MHO_NotBelow				; if not, branch
		move.w	#$0080+224,d1				; force to bottom
		addq.w	#$01,d2					; increase complete counter

PG_MHO_NotBelow:
		move.w	d1,(a0)					; update Y position
		addq.w	#$02,a1					; advance to next sprite
		dbf	d4,PG_MHO_NextSprite			; repeat for all sprites

PG_MHO_NoSprites:
		pea	PG_MoveHudOut(pc)			; set to loop
		cmp.w	(EPG_SpriteStore).w,d2			; have all sprites moved off screen?
		bne.s	PG_MHO_NoFinish				; if not, branch
		move.l	#PG_LoadPause,(sp)			; set new routine

PG_MHO_NoFinish:
		move.b	#$10,(V_int_routine).w			; set V-blank routine to run
		bra.w	Wait_VSync				; wait for V-blank

; ---------------------------------------------------------------------------
; Loading new pause menu art and sprites
; ---------------------------------------------------------------------------

PG_LoadPause:
		move.l	#Pause_Art,d1				; set pause art address
		move.w	#(EPG_ENDVRAM-EPG_HUDVRAM)/2,d3		; set pause size
		move.w	#EPG_HUDVRAM,d2				; set pause destination
		jsr	Add_To_DMA_Queue.w			; add to DMA queue

		move.l	#Pause_Art+($80*3)+(EPG_ENDVRAM-EPG_HUDVRAM),d1	; set pause art address
		move.w	#(EPG_ENDVRAM2-EPG_PAUVRAM2)/2,d3	; set pause size
		move.w	#EPG_PAUVRAM2,d2			; set pause destination
		jsr	Add_To_DMA_Queue.w			; add to DMA queue

		move.b	#$10,(V_int_routine).w			; set V-blank routine to run
		bsr.w	Wait_VSync				; wait for V-blank

	; --- Creating a space for menu sprites ---

		lea	(Sprite_table_buffer+$280).w,a1		; load end of sprite table
		lea	(Sprite_table_buffer+$280-(PG_Sprites_End-PG_Sprites)).w,a0	; load copy position

		moveq	#($50-((PG_Sprites_End-PG_Sprites)/$08))-1,d1 ; set number of sprites to copy over

PG_LP_Create:
		move.l	-(a0),-(a1)				; copy sprite X and VRAM over
		move.w	-(a0),d0				; load shape/link
		tst.b	d0					; check link ID
		beq.s	PG_LP_EndLink				; if it's, 00, branch
		addi.b	#(PG_Sprites_End-PG_Sprites)/$08,d0	; increase ID
 PG_LP_EndLink:
		move.w	d0,-(a1)				; save shape/link ID
		move.w	-(a0),-(a1)				; copy Y over
		dbf	d1,PG_LP_Create				; repeat until space is created

		move.w	#$00A0,(EPG_PauseRAM+EPG_MenuX).w	; set menu X distance

; ---------------------------------------------------------------------------
; Moving the pause menu in
; ---------------------------------------------------------------------------

PG_MovePauseIn:
		pea	PG_MovePauseIn(pc)			; set to loop
		move.l	(EPG_PauseRAM+EPG_MenuX).w,d0		; load X distance
		move.l	d0,d1					; reduce distance
		lsr.l	#$02,d1					; ''
		move.l	d1,d2					; check quotient only
		swap	d2					; ''
		tst.w	d2					; ''
		bne.s	PG_MPI_NoFinish				; if there's no distance left to move, branch
		move.l	#$00008000,d0				; give X distance a value to increment by (cannot multiply 0 to get solid number)
		moveq	#$00,d1					; clear subtraction amount
		move.l	#PG_Selection,(sp)			; set next routine

PG_MPI_NoFinish:
		sub.l	d1,d0					; reduce distance
		move.l	d0,(EPG_PauseRAM+EPG_MenuX).w		; update X distance
		bsr.w	PG_RenderMenu				; update menu sprites
		move.b	#$10,(V_int_routine).w			; set V-blank routine to run
		bra.w	Wait_VSync				; wait for V-blank

; ---------------------------------------------------------------------------
; Selection
; ---------------------------------------------------------------------------

PG_Selection:
		lea	(EPG_PauseRAM+EPG_SelectP1).w,a1	; load selection RAM
		move.b	(Ctrl_1_pressed).w,d0			; load player 1 buttons
		bsr.w	PG_Select				; perform selection
		lea	(EPG_PauseRAM+EPG_SelectP2).w,a1	; load selection RAM
		move.b	(Ctrl_2_pressed).w,d0			; load player 2 buttons
		bsr.w	PG_Select				; perform selection
		bsr.w	PG_RenderMenu				; update menu sprites

		move.b	(EPG_PauseRAM+EPG_DoneP1).w,d0		; load player 1 selection status
		or.b	(EPG_PauseRAM+EPG_DoneP2).w,d0		; fuse with player 2's
		bmi.s	PG_S_NoSelect				; if either MSB were set, then someone hasn't made a selection yet
		moveq	#$00,d0					; clear d0
		move.b	(EPG_PauseRAM+EPG_SelectP1).w,d0	; load player 1's selection
		cmp.b	(EPG_PauseRAM+EPG_SelectP2).w,d0	; does it match player 2's?
		bne.s	PG_S_NoSelect				; if not, branch (both need to agree)
		add.w	d0,d0					; multiply by size of long-word
		add.w	d0,d0					; ''
		jmp	PG_S_List(pc,d0.w)			; run correct routine

PG_S_List:	bra.w	PG_Resume				; Selection 1
		bra.w	PG_Respawn				; Selection 2
		bra.w	PG_Quit					; Selection 3

PG_S_NoSelect:
		bsr.s	PG_RenderSelectors			; render the selector art

	; --- Final loop ---

		pea	PG_Selection(pc)			; set to loop
		move.b	#$10,(V_int_routine).w			; set V-blank routine to run
		bra.w	Wait_VSync				; wait for V-blank

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to render the selector art correctly
; ---------------------------------------------------------------------------

PG_RenderSelectors:

	; --- Rendering player 1 selector art ---

		moveq	#$00,d1					; clear d1
		move.b	(EPG_PauseRAM+EPG_DoneP1).w,d1		; load player 1 done flag
		bpl.s	PG_S_AniArt1				; if selection has been made, branch
		cmpi.b	#$FF,d1					; has the art reset?
		beq.s	PG_S_NoAniArt1				; if so, branch
		moveq	#$00,d1					; set to render first non-flash frame
		st.b	(EPG_PauseRAM+EPG_DoneP1).w		; set art as reset now
		bra.s	PG_S_NoRev1				; continue to render

PG_S_AniArt1:
		addq.b	#$01,d1					; increase animation
		andi.b	#$1F,d1					; keep within the 3 frames
		move.b	d1,(EPG_PauseRAM+EPG_DoneP1).w		; update
		andi.b	#$1C,d1					; clear fraction bits
		btst.l	#$04,d1					; have we reached fade out point?
		beq.s	PG_S_NoRev1				; if not, branch
		not.b	d1					; reverse such that the animation goes backwards
		andi.b	#$0C,d1					; ''

PG_S_NoRev1:
		lsl.w	#$05,d1					; multiply by 80
		addi.l	#Pause_Art+EPG_SelectPos+$00,d1		; add art source address
		move.w	#($0040/2),d3				; set pause size
		move.w	#EPG_SelectVRAM+$00,d2			; set pause destination
		jsr	Add_To_DMA_Queue.w			; add to DMA queue

PG_S_NoAniArt1:

	; --- Rendering player 2 selector art ---

		moveq	#$00,d1					; clear d1
		move.b	(EPG_PauseRAM+EPG_DoneP2).w,d1		; load player 1 done flag
		bpl.s	PG_S_AniArt2				; if selection has been made, branch
		cmpi.b	#$FF,d1					; has the art reset?
		beq.s	PG_S_NoAniArt2				; if so, branch
		moveq	#$00,d1					; set to render first non-flash frame
		st.b	(EPG_PauseRAM+EPG_DoneP2).w		; set art as reset now
		bra.s	PG_S_NoRev2				; continue to render

PG_S_AniArt2:
		addq.b	#$01,d1					; increase animation
		andi.b	#$1F,d1					; keep within the 3 frames
		move.b	d1,(EPG_PauseRAM+EPG_DoneP2).w		; update
		andi.b	#$1C,d1					; clear fraction bits
		btst.l	#$04,d1					; have we reached fade out point?
		beq.s	PG_S_NoRev2				; if not, branch
		not.b	d1					; reverse such that the animation goes backwards
		andi.b	#$0C,d1					; ''

PG_S_NoRev2:
		lsl.w	#$05,d1					; multiply by 80
		addi.l	#Pause_Art+EPG_SelectPos+$40,d1		; add art source address
		move.w	#($0040/2),d3				; set pause size
		move.w	#EPG_SelectVRAM+$40,d2			; set pause destination
		jsr	Add_To_DMA_Queue.w			; add to DMA queue

PG_S_NoAniArt2:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Respawning in the level
; ---------------------------------------------------------------------------

PG_Respawn:
		bsr.w	PG_MovePauseOut				; move pause menu out and HUD back in
		lea	(Player_1).w,a0				; kill player 1
		jsr	Kill_Character				; ''
		lea	(Player_2).w,a0				; kill player 2
		jsr	Kill_Character				; ''
		bra.s	RG_Continue

; ---------------------------------------------------------------------------
; Resuming the level
; ---------------------------------------------------------------------------

PG_Resume:
		bsr.w	PG_MovePauseOut				; move pause menu out and HUD back in

RG_Continue:
	stopZ80
		move.b	#$80,(Z80_RAM+zPauseFlag).l		; Unpause music
	startZ80
		clr.w	(Game_paused).w				; uppause game
		tst.b	(Debug_mode_flag).w			; is debug mode enabled?
		beq.s	PGRP_NoDebug				; if not, branch and ignore window
		move.w	#$92FB,($C00004).l			; allow window to display on-screen
		jmp	LoadDebugArt				; reload debug number back over the pause menu art

; ---------------------------------------------------------------------------
; Quitting
; ---------------------------------------------------------------------------

PG_Quit:
		move.b	#$04,(Game_Mode).w			; set to go back to the main menu
		moveq	#$00,d0					; clear d0
		jsr	Change_Music_Tempo.w			; slow music down
	stopZ80
		move.b	#$80,(Z80_RAM+zPauseFlag).l		; Unpause music
	startZ80
		clr.w	(Game_paused).w				; uppause game
		addq.w	#$04,sp					; skip return address (so no player can get an advantaged kill score)

PGRP_NoDebug:
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Moving the pause menu out
; ---------------------------------------------------------------------------

PG_MovePauseOut:
		pea	PG_MovePauseOut(pc)			; set to loop
		move.l	(EPG_PauseRAM+EPG_MenuX).w,d0		; load X distance
		move.l	d0,d1					; get quarter the distance
		lsr.l	#$02,d1					; ''
		add.l	d1,d0					; increase distance
		cmpi.l	#$00A00000,d0				; has it gone out the screen fully yet?
		blo.s	PG_MPO_NoFinish				; if not, branch
		move.l	#$00A00000,d0				; force directly off screen
		move.l	#PG_LoadHud,(sp)			; set next routine

PG_MPO_NoFinish:
		move.l	d0,(EPG_PauseRAM+EPG_MenuX).w		; set new X distance
		bsr.w	PG_RenderSelectors			; render the selector art
		bsr.w	PG_RenderMenu				; update menu sprites
		move.b	#$10,(V_int_routine).w			; set V-blank routine to run
		bra.w	Wait_VSync				; wait for V-blank

; ---------------------------------------------------------------------------
; reloading HUD and counters again
; ---------------------------------------------------------------------------

PG_LoadHud:
		lea	(ArtNem_Ring).l,a1			; load art to decompress
		move.w	#ArtTile_ArtNem_Ring*$20,d2		; set VRAM address to dump the art
		jsr	Queue_Kos_Module.w			; decompress the file
		lea	(ArtKosM_Timer).l,a1			; load art to decompress
		move.w	#AT_HUD_Timer*32,d2			; set VRAM address to dump the art
		jsr	Queue_Kos_Module.w			; decompress the file

PG_WaitPLC:
		move.b	#$10,(V_int_routine).w			; set V-blank interrupt routine
		jsr	(Process_Kos_Queue).l			; process kosinski decompression itself
		bsr.w	Wait_VSync				; wait for V-blank (transfer during V-blank)
		jsr	Process_Kos_Module_Queue.w		; process kosinski queue
		tst.l	(Kos_module_queue).w			; is the queue empty?
		bne.s	PG_WaitPLC				; if not, branch
		move.b	#$10,(V_int_routine).w			; set V-blank interrupt routine
		jsr	(Process_Kos_Queue).l			; process kosinski decompression itself
		bsr.w	Wait_VSync				; wait for V-blank (transfer during V-blank)

		tst.b	(Debug_On).w				; are the characters in debug placement mode?
		beq.s	PG_NoDebugNumbers			; if not, branch
		move	#$2700,sr				; disable interrupts
		lea	($C00000).l,a6				; load VDP port address into a6 for the subroutine
		jsr	ForceDrawDebug.l			; force the debug numbers to reload
		bra.s	PG_NoUpdateHud				; skip over hud updating

PG_NoDebugNumbers:
		move	#$2700,sr				; disable interrupts
		lea	($C00000).l,a6				; load VDP port address into a6 for the subroutine
		moveq	#$01,d0					; force HUD numbers to update
		move.b	d0,(Update_HUD_score).w			; ''
		move.b	d0,(Update_HUD_ring_count).w		; ''
		move.b	d0,(Update_HUD_timer).w			; ''
		jsr	ForceTimer_MiniSSZ.l			; update mini-SSZ hud timer

PG_NoUpdateHud:
		move	#$2300,sr				; re-enable interrupts

	; --- removing menu sprites ---

		lea	(Sprite_table_buffer).w,a1		; load start of sprite table buffer
		lea	PG_Sprites_End-PG_Sprites(a1),a0	; load start of actual sprites in level
		moveq	#($50-((PG_Sprites_End-PG_Sprites)/$08))-1,d1 ; set number of sprites to copy over

PG_LH_Create:
		move.w	(a0)+,(a1)+				; copy Y position over
		move.w	(a0)+,d0				; load shape/link
		tst.b	d0					; check link ID
		beq.s	PG_LH_EndLink				; if it's, 00, branch
		subi.b	#(PG_Sprites_End-PG_Sprites)/$08,d0	; decrease ID

PG_LH_EndLink:
		move.w	d0,(a1)+				; save shape/link ID
		move.l	(a0)+,(a1)+				; copy VRAM and X position over
		dbf	d1,PG_LH_Create				; repeat until space is created

; ---------------------------------------------------------------------------
; Moving HUD sprites back in
; ---------------------------------------------------------------------------

PG_MoveHudIn:
		lea	(EPG_SpriteStore).w,a1			; load sprite HUD list
		moveq	#-$01,d2				; reset complete counter
		move.w	(a1)+,d4				; load number of HUD sprites there are
		bmi.s	PG_MHI_NoSprites			; if there are no HUD sprites, branch

PG_MHI_NextSprite:
		movea.w	(a1)+,a0				; set sprite table address
		moveq	#$00,d1					; clear d1
		move.w	(a1)+,d1				; load destination Y position
		swap	d1					; create fraction space
		move.l	(a0),d0					; load current Y position
		clr.w	d0					; clear fraction
		sub.l	d0,d1					; get distance
		asr.l	#$01,d1					; slow it down
		move.l	d1,d3					; get only quotient
		swap	d3					; ''
		tst.w	d3					; ''
		bne.s	PG_MHI_NoForce				; if not finished, branch
		move.w	-$02(a1),(a0)				; set Y position directly
		addq.w	#$01,d2					; increase complete counter
		dbf	d4,PG_MHI_NextSprite			; repeat for all sprites
		bra.s	PG_MHI_NoSprites			; continue

PG_MHI_NoForce:
		add.l	d1,d0					; add distance to position
		swap	d0					; save only quotient
		move.w	d0,(a0)					; ''
		dbf	d4,PG_MHI_NextSprite			; repeat for all sprites

PG_MHI_NoSprites:
		pea	PG_MoveHudIn(pc)			; set to loop
		cmp.w	(EPG_SpriteStore).w,d2			; have all sprites moved off screen?
		bne.s	PG_MHI_NoFinish				; if not, branch
		addq.w	#$04,sp					; return back to routine

PG_MHI_NoFinish:
		move.b	#$10,(V_int_routine).w			; set V-blank routine to run
		bra.w	Wait_VSync				; wait for V-blank

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to control player selections
; ---------------------------------------------------------------------------

PG_Select:
		bpl.s	PG_S_NoStart				; if start was not pressed, branch
		sf.b	$01(a1)					; set selection as done
		bra.s	PG_S_UpdatePos				; continue

PG_S_NoStart:
		move.b	(a1),d1					; load Y selection
		roxr.b	#$02,d0					; shift up/down into positions
		bcc.s	PG_S_NoDown				; if down was not pressed, branch
		ori.b	#$80,$01(a1)				; clear selection flag
		addq.b	#$01,d1					; increase selection
		cmpi.b	#$03,d1					; has selection surpassed maximum selection?
		blo.s	PG_S_UpdateY				; if not, branch
		moveq	#$00,d1					; reset to 0
		bra.s	PG_S_UpdateY				; update Y position

PG_S_NoDown:
		bpl.s	PG_S_UpdateY				; if up was not pressed, branch
		ori.b	#$80,$01(a1)				; clear selection flag
		subq.b	#$01,d1					; decrease selection
		bpl.s	PG_S_UpdateY				; if it's not gone below 0, branch
		moveq	#$02,d1					; reset to selection 3

PG_S_UpdateY:
		move.b	d1,(a1)					; update selection

PG_S_UpdatePos:
		move.w	(a1)+,d1				; reload selection x100
		sf.b	d1					; ''
		lsl.w	#$04,d1					; multiply by x10 pixels
		sub.w	(a1),d1					; get distance from current position
		asr.w	#$01,d1					; slow it down
		add.w	d1,(a1)					; get actual position
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to render the menu
; ---------------------------------------------------------------------------

PG_RenderMenu:
		lea	(PG_Sprites).l,a0			; load sprites to display
		lea	(Sprite_table_buffer).w,a1		; load beginning of sprite table
		moveq	#((PG_Sprites_End-PG_Sprites)/$08)-1,d1	; number of sprites to load
		moveq	#$00,d3					; clear d3

PG_LP_LoadSprites:
		move.w	(EPG_PauseRAM+EPG_MenuX).w,d2		; load X distance from centre (for Tails first)
		cmpa.l	#PG_Tails,a0				; have we reached Tails' sprites?
		bhs.s	PG_LP_NoTails				; if so, branch
		neg.w	d2					; reverse side for Sonic

PG_LP_NoTails:
		move.w	(a0)+,d0				; load Y position
		cmpa.l	#PG_Sonic+2,a0				; is this Sonic's selection sprite?
		bne.s	PG_LP_NoSonSelect			; if not, branch
		move.b	(EPG_PauseRAM+EPG_PosP1).w,d3		; load player 1's selection
		add.w	d3,d0					; change Y position

PG_LP_NoSonSelect:
		cmpa.l	#PG_Tails+2,a0				; is this Sonic's selection sprite?
		bne.s	PG_LP_NoTaiSelect			; if not, branch
		move.b	(EPG_PauseRAM+EPG_PosP2).w,d3		; load player 2's selection
		add.w	d3,d0					; change Y position

PG_LP_NoTaiSelect:
		move.w	d0,(a1)+				; save Y position
		move.b	(a0)+,(a1)+				; copy shape
		addq.w	#$01,a0					; skip over link
		addq.w	#$01,a1					; ''
		move.l	(a0)+,d0				; load VRAM and X position
		add.w	d2,d0					; add side position
		move.l	d0,(a1)+				; copy VRAM and X position
		dbf	d1,PG_LP_LoadSprites			; repeat for all menu sprites
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to find all HUD sprites in the sprite table currently
; ---------------------------------------------------------------------------

PG_FindHudSprites:
		lea	(Sprite_table_buffer).w,a0		; load sprite table
		lea	(EPG_SpriteStore).w,a1			; load sprite storage address
		lea	(a1),a2					; copy to a2
		move.w	#$FFFF,(a1)+				; clear counter
		moveq	#$50-1,d1				; set number of sprites to check in the sprite table

PG_FHS_NextSprite:
		move.w	$04(a0),d0				; load VRAM
		andi.w	#$07FF,d0				; get only the tile ID
	move.w	d0,d2
	subi.w	#(EPG_PAUVRAM2/$20),d2			; get VRAM range
	cmpi.w	#(EPG_ENDVRAM2-EPG_PAUVRAM2)/$20,d2	; is this sprite displaying the HUD art?
	blo.s	PG_FHS_YesHUD				; if not, branch
		subi.w	#(EPG_HUDVRAM/$20),d0			; get VRAM range
		cmpi.w	#(EPG_ENDVRAM-EPG_HUDVRAM)/$20,d0	; is this sprite displaying the HUD art?
		bhs.s	PG_FHS_NoHUD				; if not, branch

PG_FHS_YesHUD:
		addq.w	#$01,(a2)				; increase sprite count
		move.w	a0,(a1)+				; store address
		move.w	(a0),(a1)+				; save Y position for return

PG_FHS_NoHUD:
		addq.w	#$08,a0					; advance to next sprite
		dbf	d1,PG_FHS_NextSprite			; repeat for all slots
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Pause Sprites
; ---------------------------------------------------------------------------
PGX	=	($0080+(320/2))
PGY	=	($0080+(224/2))
PGV1	=	((EPG_HUDVRAM/$20)|$8000)
PGV2	=	((EPG_PAUVRAM2/$20)|$8000)
; ---------------------------------------------------------------------------

PG_Sprites:

PG_Sonic:	dc.w	PGY-$0018, $0100, PGV1+$0020, PGX-$0028 ; Highlighter

		dc.w	PGY-$0018, $0F00, PGV1+$0000, PGX-$0028	; Menu
		dc.w	PGY-$0018, $0300, PGV1+$0010, PGX-$0008
		dc.w	PGY+$0008, $0D00, PGV2+$0008, PGX-$0028
		dc.w	PGY+$0008, $0100, PGV2+$0010, PGX-$0008

PG_Tails:	dc.w	PGY-$0018, $0100, PGV1+$0022, PGX+$0020 ; Highlighter

		dc.w	PGY-$0018, $0B00, PGV1+$0014, PGX+$0000	; Menu
		dc.w	PGY-$0018, $0700, PGV2+$0000, PGX+$0018
		dc.w	PGY+$0008, $0D00, PGV2+$0012, PGX+$0000
		dc.w	PGY+$0008, $0100, PGV2+$001A, PGX+$0020

PG_Sprites_End:

; ===========================================================================



