; ---------------------------------------------------------------------------
; Equates for easier usage ;;;
; ---------------------------------------------------------------------------
VDP_control_port	equ $C00004	; VDP data port
MetaBlock_Table		equ $FF0000	; RAM start/BG mappings temporary storage address
Object_Ram		equ $FFFFD000	; main object space flag (for easier conversations between disassemblies
Game_mode		equ $FFFFF600	; the current game mode, easier conversation stuff again
Ctrl_1_Press		equ $FFFFF605	; pressed buttons on Joypad 1
Ctrl_2_Press		equ $FFFFF607	; pressed buttons on Joypad 2
Demo_Time_left		equ $FFFFF614	; timer which is counted down to 0 on VBlank
Splash_MainFlag 	equ $FFFFF726	; flag used to time fadein and test if we are ready to exit the screen
Delay_Time		equ $FFFFF62A	; Just equate for VBlank routine flag for easier conversions
Water_move		equ $FFFFF64E	; ???
Camera_X_Pos		equ $FFFFF700	; Camre X-position
Lock_Screen		equ $FFFFF744	; screen lock flag	; Sonic 1
;Lock_Screen		equ $FFFFEEDC	; screen lock flag	; Sonic 2
Second_palette		equ $FFFFFB80	; fade-to main pallet
Splash_HitSFX		equ $BD		; sound effect for the logo
Splash_XtraObjsToLoad	equ 4-1		; amount of objects to load-1 besides from Sonic obj
Splash_MainObjID	equ $8D 	; Main object id
Next_Obj		equ $40		; quickie for next object
Logo_GroundHeight	equ $80		; $80	; height if the ground from the top of the plane (when it is -$40, the object is out of screen (it wont however go there if the x-pos of the object is set to be more than what it is here))
Logo_LoadHeight		equ -$48	; -$48	; Y-pos to where to load the object to to make it not glitch on screen (also read above)
Logo_NearSonic		equ $6A		; the Y-position of the logo when the code will kill Sonic
Sonic_SpawnXPos		equ $50		; X-position Sonic will spawn to
Sonic_SpawnYPos		equ $AC		; Y-position Sonic will spawn to
; ===========================================================================
; ---------------------------------------------------------------------------
; Sonic Games Dimension splash screen - Coded by Green Snake
; ---------------------------------------------------------------------------
SplashScreen:
	     	move.b	#$E4,d0                 ; load "stop music" effect number to d0
		jsr	PlaySound_Special 	; process it
		jsr	ClearPLC		; clear plc
		jsr	Pal_FadeFrom		; fade to black
; ---------------------------------------------------------------------------
; set up the VDP
; ---------------------------------------------------------------------------
		move	#$2700,sr		; disable interrupts (?)
		lea	(VDP_control_port).l,a6	; Setup teh VDP			(Thanks to GF64 for these descriptions)
		move.w	#$8004,(a6)		; Mode register 1 setting
		move.w	#$8230,(a6)		; Map Plane A setting
		move.w	#$8407,(a6)		; Map Plane B setting
		move.w	#$9011,(a6)		; Plane size setting
		move.w	#$9200,(a6)		; Window vertical position
		move.w	#$8B03,(a6)		; Mode register 3 setting
		move.w	#$8700,(a6)		; Backdrop color setting
		clr.b	(Water_move).w		; ?
                jsr	ClearScreen		; clear the screen
; ---------------------------------------------------------------------------
; clear object RAM
; ---------------------------------------------------------------------------
		lea	(Object_Ram).w,a1	; load object address base	; optional
		moveq	#0,d0			; 0 				; optional
		move.w	#$7FF,d1		; object adress lenght/4	; optional
@clrObjRAM	move.l	d0,(a1)+		; clear a1			; optional
		dbf	d1,@clrObjRAM		; loop until d1 = 0		; optional
;		clearRAM Object_RAM,$2000	; fill object RAM ($B000-$D5FF) with $0	; Sonic 2
;		clearRAM $FFFFFE60,$50
;		clearRAM $FFFFE700,$100
;		clearRAM $FFFFF628,$58
;		clearRAM Misc_Variables,$100
; ---------------------------------------------------------------------------
; the next parts will fix many software reset glitches, 
; can be removed if you make the ROM to clear all RAM on soft reset too
; ---------------------------------------------------------------------------
		lea	($FFFFF628).w,a1	; miscellaneous data
		moveq	#0,d0			; move 0 to d0
		move.w	#$15,d1			; move amound of repeats to d1
@clrsomething	move.l	d0,(a1)+		; clear 4 bytes
		dbf	d1,@clrsomething	; repeat until d1=0
; ---------------------------------------------------------------------------
; clears level specific information
; ---------------------------------------------------------------------------
		lea	(Camera_X_Pos).w,a1	; plane A x_pos
		moveq	#0,d0			; move 0 to d0
		move.w	#$3F,d1			; move amound of repeats to d1
@clrlevelinfo	move.l	d0,(a1)+		; clear 4 bytes
		dbf	d1,@clrlevelinfo	; clear level plane poses, etc.
; ---------------------------------------------------------------------------
; ??? probably related to water
; ---------------------------------------------------------------------------
		lea	($FFFFFE60).w,a1	; more miscellaneous data
		moveq	#0,d0			; move 0 to d0
		move.w	#$47,d1			; move amound of repeats to d1
@clrunknown	move.l	d0,(a1)+		; clear 4 bytes
		dbf	d1,@clrunknown		; repeat until d1=0
; ---------------------------------------------------------------------------
; load nesessary art
; ---------------------------------------------------------------------------
		move.l	#$40000000,(VDP_control_port).l	; write to VRAM address 0
		lea	Nem_bg,a0			; load logo art
		jsr	NemDec				; decompress and send to VRAM
		move.l	#$50C00002,(VDP_control_port).l	; write to VRAM address $90C0
		lea	Nem_Logo,a0			; load logo art
		jsr	NemDec				; decompress and send to VRAM
		move.l	#$50000003,(VDP_control_port).l	; write to VRAM address $D000
		lea	Nem_Logo2,a0			; load logo art
		jsr	NemDec				; decompress and send to VRAM
; ---------------------------------------------------------------------------
; load bg mappings
; ---------------------------------------------------------------------------
		lea	(MetaBlock_Table).l,a1	; load RAM address to store the data (Chunks aren't necessary now, so we can use the RAM area)
		lea	bg_eni,a0		; load bg mappings
		move.w	#0,d0			; 0
		jsr	EniDec			; decompress
		lea	(MetaBlock_Table).l,a1	; the bg mappings are stored here
		move.l	#$60000003,d0		; VRAM read mode, VRAM address 0, background layer
		moveq	#$27,d1			; tiles per row (?)
		moveq	#$1B,d2			; amount of rows (?)
		jsr	ShowVDPGraphics		; make VDP output the correct bg layer to plane B
; ---------------------------------------------------------------------------
; load pallet
; ---------------------------------------------------------------------------
		lea	(Second_palette).w,a1	; pallet RAM address
		lea	pal_Splash,a2		; pallet
		move.w	#$17,d1			; amount of pallets to overwrite/4
@pal		move.l	(a2)+,(a1)+		; load the pallet
		dbf	d1,@pal			; loop until d1 = 0
		lea	pal_Sonic,a2		; pallet
		move.w	#7,d1			; amount of pallets to overwrite/4
@pal2		move.l	(a2)+,(a1)+		; load the pallet
		dbf	d1,@pal2		; loop until d1 = 0
; ---------------------------------------------------------------------------
; load objects and set stuff up
; ---------------------------------------------------------------------------
		move.b	#Splash_MainObjID,(Object_Ram).w	; load object
		move.b	#8,(Object_Ram+$28).w			; load object
		move.b	#Splash_MainObjID,(Object_Ram+$40).w	; load object
		move.b	#1,(Lock_Screen).w			; stop screen
		move.w	#4,(Splash_MainFlag).w			; delay
; ---------------------------------------------------------------------------
; wait few frames to get all objects working properly
; ---------------------------------------------------------------------------
@obj		move.b	#8,(Delay_Time).w	; VBlank 3rd routine
		jsr	DelayProgram		; wait for VBlank
		jsr	ObjectsLoad		; run objects
		jsr	BuildSprites		; show sprites
		subq.w	#1,(Splash_MainFlag).w	; sub 1 from the delay
		bne.s	@obj			; if not 0, branch back to the loop
; ---------------------------------------------------------------------------
; fade in
; ---------------------------------------------------------------------------
		jsr	DeformBgLayer		; deform background layer
		jsr	Pal_FadeTo		; fade to pallet
		move.w	#$64,(Demo_Time_left).w	; 100 frames before you can exit manually (optional)
; ---------------------------------------------------------------------------
; main loop
; ---------------------------------------------------------------------------
@loop		move.b	#8,(Delay_Time).w	; VBlank 3rd routine
		jsr	DelayProgram		; wait for VBlank
		jsr	ObjectsLoad		; run objects
		jsr	DeformBgLayer		; deform background layer
	;	jsr	RunPLC_RAM		; if you want to load PLC'd art while this screen runs, uncomment this line
		jsr	BuildSprites		; show sprites
		tst.w	(Splash_MainFlag).w 	; test levels boundary (used to determine if allow exiting manually or not)
		bne.s	@exit			; if not 0, exit
		tst.w	(Demo_Time_left).w	; is manual exit timer 0?
		bne.s	@loop			; if not, keep looping
		btst	#7,(Ctrl_1_Press).w	; was start pressed on controller 1?
		bne.s	@exit			; if it was, exit
		btst	#7,(Ctrl_2_Press).w	; was start pressed on controller 2?
		beq.s	@loop			; if wasnt, keep looping
; ---------------------------------------------------------------------------
; exit
; ---------------------------------------------------------------------------
@exit		move.b	#4,(Game_mode).w	; go to title screen
		clr.b	(Lock_Screen).w		; unlock screen
		jmp	Pal_MakeFlash		; fade to white (optional (comment out to disable)) (recommented to use MarkeyJesters improved fade in/out routines)
		rts				; rts. nuff' said
; ===========================================================================
; ---------------------------------------------------------------------------
; Splash screen Main object
; ---------------------------------------------------------------------------
Obj_Splash:
                moveq	#0,d0				; 0
		move.b	$28(a0),d0			; subtype
		move.w	Obj_Splash_Sub(pc,d0.w),d1	; index
		jmp	Obj_Splash_Sub(pc,d1.w)		;
; ===========================================================================
Obj_Splash_Sub: dc.w Obj_Splash_1-Obj_Splash_Sub	; object which controls the logo movement
		dc.w Obj_Splash_2-Obj_Splash_Sub	; object which controls sonic
		dc.w Obj_Splash_show-Obj_Splash_Sub	; show-only object
		dc.w Obj_Splash_show-Obj_Splash_Sub	; show-only object
		dc.w Obj_Splash_Sonic-Obj_Splash_Sub	; Sonic object
; ===========================================================================
; ---------------------------------------------------------------------------
; first half of "SONIC", also control object for the logo
; ---------------------------------------------------------------------------
Obj_Splash_1:
		lea	(Object_Ram+$80).w,a1		; load other half of Sonic object to a1
		lea	(Object_Ram+$C0).w,a3		; load "GAMES" to a3
		lea	(Object_Ram+$100).w,a2		; load "DIMENSION" to a2
		moveq	#0,d0				; 0
		move.b	$24(a0),d0			; routine
		move.w	Obj_Splash_Index(pc,d0.w),d1	; index
		jmp	Obj_Splash_Index(pc,d1.w)	;
; ===========================================================================
Obj_Splash_Index: dc.w Obj_Splash_Main-Obj_Splash_Index		; routine to setup all the objects
                  dc.w Obj_Splash_Control__Logo-Obj_Splash_Index; sets up logo to proper positions
                  dc.w Obj_Splash_Control_Logo-Obj_Splash_Index	; main control routine
                  dc.w Obj_Splash_WaitSonic-Obj_Splash_Index	; routine to make sure logo is at proper X-positions
; ===========================================================================
; ---------------------------------------------------------------------------
; other half of "SONIC", also control object for Sonic object
; ---------------------------------------------------------------------------
Obj_Splash_2:
	        lea	(Object_Ram).w,a1		; load fake Sonic address to a1
		moveq	#0,d0				; 0
		move.b	$24(a0),d0			; routine
		move.w	Obj_Splash_Index2(pc,d0.w),d1	; index
		jmp	Obj_Splash_Index2(pc,d1.w)	;
; ===========================================================================
Obj_Splash_Index2: dc.w Obj_Splash_Control_Sonic-Obj_Splash_Index2	; make Sonic act properly to certain situations
		   dc.w Obj_Splash_WaitLogo-Obj_Splash_Index2		; lag timer
; ===========================================================================
; ---------------------------------------------------------------------------
; fake Sonic object 
; (by having this and not the real one we can fix a lot of issues)
; ---------------------------------------------------------------------------
Obj_Splash_Sonic:
		moveq	#0,d0				; 0
		move.b	$24(a0),d0			; routine
		move.w	Obj_Splash_IndexS(pc,d0.w),d1	; index
		jmp	Obj_Splash_IndexS(pc,d1.w)	;
; ===========================================================================
Obj_Splash_IndexS: dc.w Obj_Splash_SonicMain-Obj_Splash_IndexS	; set up the object
		   dc.w Obj_Splash_SonicWait-Obj_Splash_IndexS	; wait until Sonic should fall, and make it fall
; ===========================================================================
; ---------------------------------------------------------------------------
; set up objects
; ---------------------------------------------------------------------------
Obj_Splash_Main:
		addq.b	#2,$24(a0)		; add 2 to routine counter
		move.w	#$20,8(a0)		; x-pos
		move.w	#80,$26(a0)		; lag timer
		move.w	#$340,$12(a0)		; y-velocity
		moveq	#0,d0			; 0
		moveq	#Splash_XtraObjsToLoad,d1; set amount of repeats
		lea	(a0),a1			; push the address of the object to a1
; ---------------------------------------------------------------------------
; this bit will load the object main stuff
; ---------------------------------------------------------------------------
@obload		move.b	#Splash_MainObjID,(a1)	; object ID
		move.b	#$50,$16(a1)		; Y-hitbox size
		move.w	#Logo_LoadHeight,$C(a1)	; Y-pos	; this will be updated after the lag, so we have to make sure it wont glitch at the screen by doing this
		move.l	#Map_Splash,4(a1)	; mappings
		move.w	#$2486,2(a1)		; VRAM $90C0, pallet line 2
		move.b	#$10,1(a1)		; bits 2&4 set
		move.b	#3,$18(a1)		; priority
	;	move.b	#$50,$19(a1)		; show width
		move.b	d0,$1A(a1)		; set displayed frame
		move.b	d0,$28(a1)		; set subtype
		add.b	d0,$28(a1)		; make the subtype to be in multiples of 2
		addq.b	#1,d0			; add 1 to d0 (to get new frames and subtype)
		lea	Next_Obj(a1),a1		; load next object
		dbf	d1,@obload		; redo this sequence until d1 is 0
; ---------------------------------------------------------------------------
; set up 4th object
; ---------------------------------------------------------------------------
		lea	-Next_Obj(a1),a1	; load previous object (RAM $FFFFD100)
		clr.b	$1A(a1)			; set frame to 0
                move.l	#Map_Splash2,4(a1)	; mappings
		move.w	#$2680,2(a1)		; VRAM $D000, pallet line 2
		rts				; rts
; ---------------------------------------------------------------------------
; lag a bit and set up objects x-pos
; ---------------------------------------------------------------------------
Obj_Splash_Control__Logo:
		subq.w	#1,$26(a0)		; subtract 1 from lag timer
		bne.w	Obj_Splash_show		; if not 0, branch
		addq.b	#2,$24(a0)		; add 2 to rouitne counter
		move.w	8(a0),d0		; move x-pos to d0
		subq.w	#4,d0			; subtract 4
		move.w	d0,8(a2)		; move d0 to X-pos of "Games" object
		addi.w	#$A4,d0			; add $A4 to d0
                move.w	d0,8(a1)		; move d0 to X-pos of second half of "SONIC" object
                move.w	d0,8(a3)		; move d0 to X-pos of "dimension" object
; ---------------------------------------------------------------------------
; the objects main features
; ---------------------------------------------------------------------------
Obj_Splash_Control_Logo:
		jsr	ObjectFall		; move the object
		move.w	$C(a0),d0		; move Y-pos to d0
		move.w	d0,$C(a1)		; move d0 to Y-pos of second half of "SONIC" object
		addi.w	#$40,d0			; add $40 to d0
                move.w	d0,$C(a2)		; move d0 to Y-pos of "Games" object
                move.w	d0,$C(a3)		; move d0 to X-pos of "dimension" object
; ---------------------------------------------------------------------------
; test for ground
; ---------------------------------------------------------------------------
		cmpi.w	#Logo_GroundHeight,$C(a0); is the object hitting "ground"?
		ble.s	Obj_Splash_show		; if we are higher, branch
; ---------------------------------------------------------------------------
; bounce back
; ---------------------------------------------------------------------------
		move.w	$12(a0),d0		; fetch y-velocity
		move.w	$12(a0),d1		; fetch y-velocity again
		neg.w	d0			; negate
		asr.w	#1,d0			; divide by 2
		asr.w	#2,d1			; divide by 4
		sub.w	d1,d0			; add d1 to d0 (we did not negate d1, so it works as addition now)
		move.w	d0,$12(a0)		; apply new speed	; now new speed is 75% of original speed
; ---------------------------------------------------------------------------
; play bouncing sound and stop when slow enough
; ---------------------------------------------------------------------------
		move.w	#Splash_HitSFX,d0	; get sound id
		jsr	PlaySound_Special	; play it
		cmpi.w	#-$100,$12(a0)		; are we going slowly?
		blt.s   Obj_Splash_show		; if not, branch away
		addq.b	#2,$24(a0)		; if so, add 2 to routine counter, and stop the logo (othervise we would be in endless loop of logo going 1 pixel up and down)
		bra.s   Obj_Splash_show		; branch away
; ---------------------------------------------------------------------------
; fix the logo positions
; ---------------------------------------------------------------------------
Obj_Splash_WaitSonic:
		move.w	8(a0),d0		; fetch x-pos
		subq.w	#4,d0			; sub 4
		move.w	d0,8(a2)		; move d0 to X-pos of "Games" object
		addi.w	#$A4,d0			; add $A4 to d0
                move.w	d0,8(a1)		; move d0 to X-pos of second half of "SONIC" object
                move.w	d0,8(a3)		; move d0 to X-pos of "dimension" object
; ---------------------------------------------------------------------------
; Display the object
; ---------------------------------------------------------------------------
Obj_Splash_show:
		jmp	DisplaySprite		; show the object
; ===========================================================================
; ---------------------------------------------------------------------------
; if the object is low enough kill Sonic
; ---------------------------------------------------------------------------
Obj_Splash_Control_Sonic:
		cmpi.w	#Logo_NearSonic,$C(a0)	; is the logo near Sonic?
		ble.s   Obj_Splash_show		; if it is not, branch away
		addq.b	#2,$24(a0)		; add 2 to rouitne counter
		move.b	#1,$22(a1)		; tell Sonic to start falling
		move.w	#-$700,$12(a1)		; set y-velocity
                move.b	#$18,$1C(a1)		; death animation
		move.w	#300,$26(a0)		; lag time
		bra.s	Obj_Splash_show		; branch away
; ---------------------------------------------------------------------------
; exit after lag
; ---------------------------------------------------------------------------
Obj_Splash_WaitLogo:
		subq.w	#1,$26(a0)		; subtract 1 from lag timer
                bne.s	Obj_Splash_show		; if not 0, branch
                move.w	#1,(Splash_MainFlag).w	; force exit
                bra.s	Obj_Splash_show		; branch away
; ===========================================================================
; ---------------------------------------------------------------------------
; subroutine to set up Sonic object
; ---------------------------------------------------------------------------
Obj_Splash_SonicMain:
		addq.b	#2,$24(a0)		; switch to the next routine, so this won't run twice
		move.b	#$13,$16(a0)		; y-hitbox size (avoid hiding sonic after his middle part is below screen)
		move.l	#Map_Sonic,4(a0)	; Mappings (modify if needed
		move.b	#2,$18(a0)		; priority
	;	move.b	#$18,$19(a0)		; show width (not needed)
		move.b	#4,1(a0)		; set the object to plane
		move.w	#Sonic_SpawnXPos,8(a0)	; set Sonic's x-pos
		move.w	#Sonic_SpawnYPos,$C(a0)	; set Sonic's Y-pos
		move.b	#5,$1C(a0)		; set animation to waiting animation
		move.w	#$6780,2(a0)		; VRAM $F000, pallet line 4
		rts
; ---------------------------------------------------------------------------
; subroutine to animate Sonic
; ---------------------------------------------------------------------------
Obj_Splash_SonicWait:
		tst.b	$22(a0)			; is Sonic supposed to fall yet?
		beq.s	@noFall			; if not, branch
		jsr	Objectfall		; make Sonic fall
@noFall		jsr	Sonic_Animate		; animate Sonic
		jsr	LoadSonicDynPLC		; load DPLC
		bra.w	Obj_Splash_show		; display
; ===========================================================================
; ---------------------------------------------------------------------------
; stuff needed
; ---------------------------------------------------------------------------
Pal_Splash:	incbin splash/main.pal
		; this is even file
Nem_logo:	incbin splash/logo.nem
		even	; align to even address
Nem_logo2:	incbin splash/logo2.nem
		even	;align to even address
Bg_eni:		incbin splash/bg.eni
		even	; align to even address
Nem_bg:		incbin splash/bg.nem
		even	; align to even address
Map_Splash:	include "splash/logo.map.asm"
		even	; align to even address
Map_Splash2:	include "splash/logo2.map.asm"
		even	; align to even address