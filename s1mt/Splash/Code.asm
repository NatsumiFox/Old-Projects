SplashScreen:
	     	move.b	#$E4,d0                 ; load "stop music" effect number to d0
		jsr	playsound_special 		; process it
		jsr	ClearPLC		; clear plc
		jsr	Pal_FadeFrom		; fade to black
		move	#$2700,sr		; disable interrupts (?)
		lea	($C00004).l,a6	; Setup teh VDP
		move.w	#$8004,(a6)		; Mode register 1 setting
		move.w	#$8230,(a6)		; Map Plane A setting
		move.w	#$8407,(a6)		; Map Plane B setting
		move.w	#$9011,(a6)		; Plane size setting
		move.w	#$9200,(a6)		; Window vertical position
		move.w	#$8B03,(a6)		; Mode register 3 setting
		move.w	#$8700,(a6)		; Backdrop color setting
		clr.b	($FFFFF64E).w		; ?
                jsr	ClearScreen		; clear the screen
                lea	($FFFFD000).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1
@clear		move.l	d0,(a1)+
		dbf	d1,@clear		; fill object RAM ($D000-$EFFF) with	0
		move.l	#$40000000,($C00004).l	; write to VRAM address 0
		lea	Nem_bg,a0		; load logo art
		jsr	NemDec			; decompress and send to VRAM
		move.l	#$50C00002,($C00004).l	; write to VRAM address 0
		lea	Nem_Logo,a0		; load logo art
		jsr	NemDec			; decompress and send to VRAM
		move.l	#$50000003,($C00004).l	; write to VRAM address 0
		lea	Nem_Logo2,a0		; load logo art
		jsr	NemDec			; decompress and send to VRAM
		lea	($FF0000).l,a1	; load bg address (?)
		lea	bg_eni,a0		; load bg Mappings_Offset
		move.w	#0,d0			; 0
		jsr	EniDec			; decompress
		lea	($FF0000).l,a1	; load bg address again (?)
		move.l	#$40000003,d0		; VRAM read mode, VRAM address 0
		moveq	#$27,d1			; ?
		moveq	#$1B,d2			; ?
		jsr	ShowVDPGraphics		; show the bg
                lea	($FFFFFB80).w,a1	; pallet RAM address
		lea	pal_Splash,a2		; pallet
		move.w	#$17,d1			; amount of pallets to overwrite/4
@load		move.l	(a2)+,(a1)+		; load the pallet
		dbf	d1,@load			; loop until d1 = 0
		lea	Pal_Sonic,a2		; pallet
		move.w	#7,d1			; amount of pallets to overwrite/4
@load2		move.l	(a2)+,(a1)+		; load the pallet
		dbf	d1,@load2			; loop until d1 = 0
		clr.w	($FFFFF700).w	; make sure camera is in default pos
		clr.w	($FFFFF704).w	;
		move.b	#1,($FFFFD000).w	; load object
		move.b	#1,($FFFFF7C8).w	; lock Sonic
		move.b	#1,($FFFFF7CC).w	; load object
		move.b	#$96,($FFFFD000+$40).w	; load object
		move.b	#$96,($FFFFD000+$80).w	; load object
		move.b	#2,($FFFFD000+$80+subtype).w	; set subtype
		move.b	#$96,($FFFFD000+$C0).w	; load object
		move.b	#4,($FFFFD000+$C0+subtype).w	; set subtype
		move.b	#$96,($FFFFD000+$100).w	; load object
		move.b	#6,($FFFFD000+$100+subtype).w	; set subtype
		move.b	#1,($FFFFF744).w	; stop screen
		move.b	#8,($FFFFF62A).w	; VBlank 3rd routine
		jsr	DelayProgram		; wait for VBlank
		jsr	objectsload		; run objects
		move.b	#$E4,d0                 ; load "stop music" effect number to d0
		jsr	playsound_special 		; process it ; fixes random roll sound glitch
		jsr	DeformBgLayer		; deform background layer
		move.b	#3,($FFFFF726).w	; loop counter
@Delay		move.b	#8,($FFFFF62A).w	; VBlank 3rd routine
		jsr	DelayProgram		; wait for VBlank
		jsr	objectsload		; run objects
		jsr	BuildSprites		; show sprites
		subq.b	#1,($FFFFF726).w	; subtract 1 form loop counter
		bne.s	@delay			; if not 0, loop
		clr.w	($FFFFF726).w		; clear bottom boundary pos
		jsr	Pal_FadeTo		; fade to pallet
@loop		move.b	#8,($FFFFF62A).w	; VBlank 3rd routine
		jsr	DelayProgram		; wait for VBlank
;		tst.b	($FFFFF600).w		; is this game mode 0?			; !
;		bne.s	@exit			; if is not, continue to title screen	; !
		jsr	objectsload		; run objects
		jsr	DeformBgLayer		; deform background layer
		jsr	BuildSprites		; show sprites
		tst.w	($FFFFF726).w 	; test levels boundary (used to determine if allow exiting manually or not)
		beq.s	@loop			; if 0
	;	move.b	(Ctrl_1_Press).w,d0	; is Start button pressed?		; !
	;	or.b	(Ctrl_2_Press).w,d0	; (either player)			; !
	;	andi.b	#$80,d0			; check both				; !
	;	beq.s	@loop			; if not, branch			; !
@exit		move.b	#4,($FFFFF600).w	; go to title screen
		clr.b	($FFFFF744).w		; unlock screen
		clr.w	($FFFFF726).w	; clear bottom boundary pos
		rts				; end of code
Obj_Splash:
	        moveq	#0,d0			; 0
		move.b	subtype(a0),d0		; subtype
		move.w	Obj_Splash_Sub(pc,d0.w),d1	; index
		jmp	Obj_Splash_Sub(pc,d1.w)		;
; ===========================================================================
Obj_Splash_Sub: dc.w Obj_Splash_1-Obj_Splash_Sub
		dc.w Obj_Splash_2-Obj_Splash_Sub
		dc.w Obj_Splash_3-Obj_Splash_Sub
		dc.w Obj_Splash_4-Obj_Splash_Sub
Obj_Splash_1:   				; first half of "SONIC", also control object for the logo
		lea	($FFFFD000+$80).w,a1
		lea	($FFFFD000+$C0).w,a2
		lea	($FFFFD000+$100).w,a3
		moveq	#0,d0			; 0
		move.b	Routine(a0),d0		; routine
		move.w	Obj_Splash_Index(pc,d0.w),d1	; index
		jmp	Obj_Splash_Index(pc,d1.w)	;
; ===========================================================================
Obj_Splash_Index: dc.w Obj_Splash_Main-Obj_Splash_Index
                  dc.w Obj_Splash_Control__Logo-Obj_Splash_Index
                  dc.w Obj_Splash_Control_Logo-Obj_Splash_Index
                  dc.w Obj_Splash_WaitSonic-Obj_Splash_Index
Obj_Splash_2:					; other half of "SONIC", also control object for Sonic object
		lea	($FFFFD000+0).w,a1
		moveq	#0,d0			; 0
		move.b	Routine(a0),d0		; routine
		move.w	Obj_Splash_Index2(pc,d0.w),d1
		jmp	Obj_Splash_Index2(pc,d1.w)
; ===========================================================================
Obj_Splash_Index2: dc.w Obj_Splash__Main-Obj_Splash_Index2
		   dc.w Obj_Splash_Control__Sonic-Obj_Splash_Index2
		   dc.w Obj_Splash_Control_Sonic-Obj_Splash_Index2
		   dc.w Obj_Splash_WaitLogo-Obj_Splash_Index2
		   dc.w Obj_Splash_Push-Obj_Splash_Index2
Obj_Splash_3:					; "Games Dimension" halfs
		moveq	#0,d0			; 0
		move.b	Routine(a0),d0		; routine
		move.w	Obj_Splash_Index3(pc,d0.w),d1
		jmp	Obj_Splash_Index3(pc,d1.w)
; ===========================================================================
Obj_Splash_Index3: dc.w Obj_Splash_Main2-Obj_Splash_Index3
		   dc.w Obj_Splash_show-Obj_Splash_Index3
Obj_Splash_4:					; "Games Dimension" halfs
		moveq	#0,d0			; 0
		move.b	Routine(a0),d0		; routine
		move.w	Obj_Splash_Index4(pc,d0.w),d1
		jmp	Obj_Splash_Index4(pc,d1.w)
; ===========================================================================
Obj_Splash_Index4: dc.w Obj_Splash_Main-Obj_Splash_Index4
		   dc.w Obj_Splash_show-Obj_Splash_Index4
Obj_Splash__Main:
		move.b	#1,anim_Frame(a0)		; set frame
Obj_Splash_Main:
		addq.b	#2,Routine(a0)		; add 2 to routine counter
		move.w	#-$30,Y_Pos(a0)		; Y-pos
		move.w	#80,Angle(a0)		; lag timer
		move.b	#$50,Y_Radius(a0)	; Y-hitbox size
		move.l	#Map_Splash_,Mappings_Offset(a0); Mappings_Offset
		move.w	#$2486,Art_Tile(a0)	; VRAM offset 90C0, pallet line 2
		move.b	#$14,Render_Flags(a0)	; bits 2&4 set
		move.w	#$20,X_pos(a0)		; x-pos
		move.w	#$340,Y_Vel(a0)		; y-velocity
		move.b	#3,Priority(a0)		; priority
		move.b	#$50,X_Visible(a0)	; show width
		cmpi.b	#6,subtype(a0)		; is this subtype 6?
		bne.s	@rts			; if not, branch
		move.b	#2,anim_Frame(a0)	; set frame
@rts		rts				; rts
Obj_Splash_Main2:
		addq.b	#2,Routine(a0)		; add 2 to routine counter
		move.l	#Map_Splash_2,Mappings_Offset(a0); Mappings_Offset
		move.b	#-$30,Y_Pos(a0)		; y-pos
		move.w	#$2680,Art_Tile(a0)	; VRAM D000, pallet line 2
		move.b	#$14,Render_Flags(a0)	; bits 2&4 set
		move.b	#$50,Y_Radius(a0)	; Y-hitbox size
		move.b	#3,Priority(a0)		; priority
		move.b	#$50,X_Visible(a0)	; show width
		rts
Obj_Splash_Control__Logo:
		subq.w	#1,Angle(a0)		; subtract 1 from lag timer
		bne.w	Obj_Splash_show		; if not 0, branch
		addq.b	#2,Routine(a0)		; add 2 to rouitne counter
		move.w	X_pos(a0),d0		; move x-pos to d0
		subi.w	#4,d0			; subtract 4
		move.w	d0,X_pos(a2)		; move d0 to X-pos of "Games" object
		addi.w	#$A4,d0			; add $A4 to d0
                move.w	d0,X_pos(a1)		; move d0 to X-pos of second half of "SONIC" object
                move.w	d0,X_pos(a3)		; move d0 to X-pos of "dimension" object
Obj_Splash_Control_Logo:
		jsr	ObjectFall		; move the object
		move.w	Y_Pos(a0),d0		; move Y-pos to d0
		move.w	d0,Y_Pos(a1)		; move d0 to Y-pos of second half of "SONIC" object
		addi.w	#$40,d0			; add $40 to d0
                move.w	d0,Y_Pos(a2)		; move d0 to Y-pos of "Games" object
                move.w	d0,Y_Pos(a3)		; move d0 to X-pos of "dimension" object
		cmpi.w	#$80,Y_Pos(a0)		; is the object hitting "gournd"?
		ble.s	Obj_Splash_show		; if we are higher, branch
		move.w	Y_Vel(a0),d0		; fetch y-velocity
		move.w	Y_Vel(a0),d1		; fetch y-velocity again
		neg.w	d0			; negate
		asr.w	#1,d0			; divide by 2
		asr.w	#2,d1			; divide by 4
		sub.w	d1,d0			; add d1 to d0 (we did not negate d1, so it works as addition now) ; now new speed is 75% of original speed
		move.w	d0,Y_Vel(a0)		; apply new speed
		move.w	#$BD,d0			; play normal death sound
		jsr	playsound_special	;
		cmpi.w	#-$100,Y_Vel(a0)	; are we going slowly?
		blt.s   Obj_Splash_show		; if not, branch away
		addq.b	#2,Routine(a0)		; if so, add 2 to routine counter, and stop the logo (othervise we would be in endless loop of logo going 1 pixel up and down)
		bra.s   Obj_Splash_show		; branch away
Obj_Splash_WaitSonic:
		move.w	X_pos(a0),d0		; fetch x-pos
		subi.w	#4,d0			; sub 4
		move.w	d0,X_pos(a2)		; move d0 to X-pos of "Games" object
		addi.w	#$A4,d0			; add $A4 to d0
                move.w	d0,X_pos(a1)		; move d0 to X-pos of second half of "SONIC" object
                move.w	d0,X_pos(a3)		; move d0 to X-pos of "dimension" object
Obj_Splash_show:
		jmp	DisplaySprite		; show the object
Obj_Splash_Control__Sonic:
		addq.b	#2,Routine(a0)		; add 2 to routine counter
                move.w	#$50,X_pos(a1)		; set Sonic's x-pos
		move.w	#$AC,Y_Pos(a1)		; set Sonic's Y-pos
		move.b	#5,anim(a1)		; set animation to waiting
		move.w	#$6780,Art_Tile(a1)	; VRAM F000, pallet line 4
Obj_Splash_Control_Sonic:
		cmpi.w	#$6A,Y_Pos(a0)		; is hte logo near Sonic?
		ble.s   Obj_Splash_show		; if it is not, branch away
		addq.b	#2,Routine(a0)		; add 2 to rouitne counter
		move.b	#6,Routine(a1)		; set sonic's routine counter to death
		bset	#1,Status(a1)		; set bit 1 of status (Sonic is in air
		move.w	#-$780,Y_Vel(a1)	; set y-velocity
		move.w	#0,X_Vel(a1)		; clear x-velocity
		move.w	#0,Inertia(a1)		; clear inertia
                move.b	#$18,anim(a1)		; death animation
                clr.b	($FFFFF7C8).w		; unlock Sonic
;		move.w	#1,($FFFFF726).w	; allow manual exit ; !
		move.w	#300,Angle(a0)		; lag time ; =
		bra.s	Obj_Splash_show		; branch away
Obj_Splash_WaitLogo:
		subq.w	#1,Angle(a0)		; subtract 1 from lag timer
                bne.s	Obj_Splash_show		; if not 0, branch
                move.w	#1,($FFFFF726).w	; force exit ; =
                bra.s	Obj_Splash_show		; branch away ; =
		tst.w	($FFFFFE02).w		; is leve set to restart?
		beq.w   Obj_Splash_show		; if not, branch
		addq.b  #2,Routine(a0)		; add 2 to routine counter
		move.b	#2,Routine(a1)		; reset Sonic's routine counter back to 2
		clr.w	($FFFFFE02).w		; clear level restart flag
		move.w	#$78,Off30(a1); make sonic invulnerable
		move.w	#6,X_pos(a1)		; set x-pos (next to logo)
		move.w	#$AC,Y_Pos(a1)		; set Sonic to ground
		move.b	#5,anim(a1)		; waiting animation
		move.w	#9,Angle(a0)		; set lag timer
		move.w	#$4A0,Inertia(a1)	; set inertia (to make pushing look better)
		move.b	#1,($FFFFF7C8).w	; lock Sonic
		bra.w	Obj_Splash_show		; branch away
Obj_Splash_Push:
	        cmpi.w	#$150,X_pos(a1)		; are we at the end of the screen?
	        bcc.s	@2			; if yes, branch
	        tst.w	Off30(a1)	; is sonic invulnerable?
	        bne.w	Obj_Splash_show		; if is, branch away
                subq.w	#1,Angle(a0)		; subtract 1 from lag timer
                bne.s	@0			; if it is not 0, branch
		move.w	#5,Angle(a0)		; lag of 5 frames
		addq.w	#1,X_pos(a1)		; add 1 to Sonic's x-pos
		move.w	#$A7,d0			; sound effect id
		jsr	playsound_special		; play pushing sound
@0		move.w	($FFFFD000+$40+X_Pos).w,d0; move logo x-pos to d0
		subi.w	#$1A,d0			; subtract $1A from d0
		cmp.w	X_pos(a1),d0		; compart d0 and Sonic's x-pos
		bcc.w   Obj_Splash_show		; if more than
		beq.s	@1			; if 0
		move.w	X_pos(a1),($FFFFD000+$40+x_pos).w; move Sonic's x-pos to logo X-pos
		addi.w	#$1A,($FFFFD000+$40+x_pos).w; add $1A to logo x-pos
@1		bset	#5,Status(a1)		; force pushing animation
		move.b	#4,anim(a1)		; make sure it is used 8mgiht be unnecessary)
                bra.w	Obj_Splash_show		; branch away
@2		move.b	#4,($FFFFF600).w	; go to title screen
		rts				; end of code
Pal_Splash:	incbin "splash/main.pal"
Nem_logo:	incbin "splash/logo.nem"
		even	; align to even address
Nem_logo2:	incbin "splash/logo2.nem"
		even	; align to even address
Bg_eni:		incbin "splash/bg.eni"
		even	; align to even address
Nem_bg:		incbin "splash/bg.nem"
		even	; align to even address
Map_Splash_:	include "splash/logo.map.asm"
		even
Map_Splash_2:	include "splash/logo2.map.asm"
		even