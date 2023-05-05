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

VDP_Data	= $C00000
VDP_Ctrl	= $C00004

SplashScreen:
	     	move.b	#$E4,d0                 ; load "stop music" effect number to d0
		jsr	PlaySound_Special 	; process it
		jsr	ClearPLC		; clear plc
		jsr	Pal_FadeFrom		; fade to black
		move	#$2700,sr		; disable interrupts (?)
		lea	($C00004).l,a6		; Setup teh VDP
		move.w	#$8004,(a6)		; Mode register 1 setting
		move.w	#$8230,(a6)		; Map Plane A setting
		move.w	#$8407,(a6)		; Map Plane B setting
		move.w	#$9011,(a6)		; Plane size setting
		move.w	#$9200,(a6)		; Window vertical position
		move.w	#$8B03,(a6)		; Mode register 3 setting
		move.w	#$8700,(a6)		; Backdrop color setting
		clr.b	($FFFFF64E).w		; ?
                jsr	ClearScreen		; clear the screen

		lea	($FFFFD000).w,a1	; load object address base ; optional
		moveq	#0,d0			; 0 ; optional
		move.w	#$7FF,d1		; object adress lenght/4 ; optional
-		move.l	d0,(a1)+		; clear a1 ; optional
		dbf	d1,-			; loop untile d1 = 0 ; optional

		lea	($FFFFF628).w,a1	; miscellaneous data
		moveq	#0,d0			; move 0 to d0
		move.w	#$15,d1			; move amound of repeats to d1
-		move.l	d0,(a1)+		; clear 4 bytes
		dbf	d1,-	; repeat until d1=0
; ---------------------------------------------------------------------------
; clears level specific information
; ---------------------------------------------------------------------------
		lea	(Camera_X_Pos).w,a1	; plane A x_pos
		moveq	#0,d0			; move 0 to d0
		move.w	#$3F,d1			; move amound of repeats to d1
-		move.l	d0,(a1)+		; clear 4 bytes
		dbf	d1,-	; clear level plane poses, etc.
; ---------------------------------------------------------------------------
; ??? probably related to water
; ---------------------------------------------------------------------------
		lea	($FFFFFE60).w,a1	; more miscellaneous data
		moveq	#0,d0			; move 0 to d0
		move.w	#$47,d1			; move amound of repeats to d1
-		move.l	d0,(a1)+		; clear 4 bytes
		dbf	d1,-		; repeat until d1=0
; ---------------------------------------------------------------------------
; load nesessary art
; ---------------------------------------------------------------------------
               move.l	#$40000000,($C00004).l	; write to VRAM address 0
		lea	Nem_bg,a0		; load logo art
		jsr	NemDec			; decompress and send to VRAM

                move.l	#$76000000,($C00004).l	; write to VRAM address $2200
		lea	Nem_sgd,a0		; load logo art
		jsr	NemDec			; decompress and send to VRAM

		lea	(MetaBlock_Table).l,a1	; load RAM address to store the data (Chunks aren't necessary now, so we can use the RAM area)
		lea	bg_eni,a0		; load bg mappings
		move.w	#$2000,d0			; 0
		jsr	EniDec			; decompress

		lea	(MetaBlock_Table).l,a1	; the bg mappings are stored here
		move.l	#$60000003,d0		; VRAM read mode, VRAM address 0, background layer
		moveq	#$27,d1			; tiles per row (?)
		moveq	#$1B,d2			; amount of rows (?)
		jsr	ShowVDPGraphics		; make VDP output the correct bg layer to plane B

                lea	(MetaBlock_Table).l,a1	; load RAM address to store the data (Chunks aren't necessary now, so we can use the RAM area)
		lea	sgdtxt,a0		; load bg mappings
		move.w	#$1B0,d0		; 0
		jsr	EniDec			; decompress

		lea	(MetaBlock_Table).l,a1	; the bg mappings are stored here
		move.l	#$4A000003,d0		; VRAM read mode, VRAM address 0, background layer
		moveq	#63,d1			; tiles per row (?)
		moveq	#3,d2			; amount of rows (?)
		jsr	ShowVDPGraphics	; make VDP output the correct bg layer to plane B

                lea	(Second_palette).w,a1	; pallet RAM address
		lea	pal_Splash,a2		; pallet
		moveq	#$17,d1			; amount of pallets to overwrite/4
-		move.l	(a2)+,(a1)+		; load the pallet
		dbf	d1,-			; loop until d1 = 0
		lea	pal_Sonic,a2		; pallet
		moveq	#7,d1			; amount of pallets to overwrite/4
-		move.l	(a2)+,(a1)+		; load the pallet
		dbf	d1,-		; loop until d1 = 0

		moveq	#0,d0
		jsr	LoadPLC2
		move.b	#$F,(Object_Ram+$40).w	; load object
		move.b	#1,(Lock_Screen).w			; stop screen
		clr.w	$FFFFFF00

                move.b  #$94,d0          ;change the number here to change the music playing on the level select. :-)
		jsr 	PlaySound
		jsr	DeformBgLayer		; deform background layer
		jsr	Pal_FadeTo		; fade to pallet
		move.w	#$64,(Demo_Time_left).w	; 100 frames before you can exit manually (optional)
; ---------------------------------------------------------------------------
; main loop
; ---------------------------------------------------------------------------
-		move.b	#8,(Delay_Time).w	; VBlank 3rd routine
		jsr	DelayProgram		; wait for VBlank
		jsr	ObjectsLoad
		jsr	DeformBgLayer		; deform background layer
		bsr	Screenshake
		jsr	BuildSprites
		jsr	RunPLC_RAM

		tst.w	(Demo_Time_left).w	; is manual exit timer 0?
		bne.s	-			; if not, keep looping
		btst	#7,(Ctrl_1_Press).w	; was start pressed on controller 1?
		bne.s	+			; if it was, exit
		btst	#7,(Ctrl_2_Press).w	; was start pressed on controller 2?
		beq.s	-			; if wasnt, keep looping
; ---------------------------------------------------------------------------
; exit
; ---------------------------------------------------------------------------
+		move.b	#4,(Game_mode).w	; go to title screen
		clr.b	(Lock_Screen).w		; unlock screen
		jmp	Pal_MakeFlash		; fade to white (optional (comment out to disable)) (recommented to use MarkeyJesters improved fade in/out routines)
		rts				; rts. nuff' said
Screenshake:
		moveq	#60-1,d0
		moveq	#0,d1
		lea	$FFFFCC00,a1
		move.w	$FFFFD800,d1
		lea	PosList(pc,d1.w),a2
		addq.w	#2,$FFFFD800
		move.w	$FFFFD802,d1
		subq.w	#2,$FFFFD802
		swap	d1
		cmpi.w	#204,$FFFFD800
		blt	getline
		clr.w	$FFFFD800
getline		cmpi.w	#$F00,(a2)
		bne	+
		lea	PosList,a2
+		move.w	(a2)+,d1
	;	addi.w	#$20,d0
		move.l	d1,(a1)+
		move.l	d1,(a1)+
		move.l	d1,(a1)+
		move.l	d1,(a1)+
		dbf	d0,getline
		rts
Obj_Splash
PosList:	dc.w -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10
		dc.w -10, -10, -10, -9, -9, -9, -9, -8, -8, -8, -7, -7, -6
		dc.w -5, -5, -4, -4, -3, -2, -2, -1, 0, 1, 2, 2, 3, 4, 4
		dc.w 5, 5, 6, 7, 7, 8, 8, 8, 9, 9, 9, 9, 10, 10, 10

		dc.w 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 9, 9, 9
		dc.w 9, 8, 8, 8, 7, 7, 6, 5, 5, 4, 4, 3, 2, 2, 1, 0, -1
		dc.w -2, -2, -3, -4, -4, -5, -5, -6, -7
		dc.w -7, -8, -8, -8, -9, -9, -9, -9      ; 112

		dc.w $F00,$F00,$F00,$F00

Pal_Splash:	binclude "splash/main.pal"
		; this is even file
Bg_eni:		binclude "splash/bg.map"
		align 2	; align to even address
Nem_bg:		binclude "splash/logo.bin"
		align 2	; align to even address
Nem_SGD:	binclude "splash/sgdtxt.bin"
		align 2	; align to even address
SGDtxt:		binclude "splash/sgdtxt.map"
		align 2	; align to even address