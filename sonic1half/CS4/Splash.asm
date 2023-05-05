CutScene4:
                        move.b	#$E4,d0
			jsr	PlaySound_Special				  ; Stop the music
			jsr	ClearPLC			; Clear the PLC
			jsr	Pal_FadeFrom			; Fade out
			move	#$2700,sr

CS4_SetupVDP:	lea	($C00004).l,a6			; Setup teh VDP
			move.w	#$8004,(a6)			; Mode register 1 setting
			move.w	#$8230,(a6)			; Map Plane A setting
			move.w	#$8407,(a6)			; Map Plane B setting
			move.w	#$9001,(a6)			; Plane size setting
			move.w	#$9200,(a6)			; Window vertical position
			move.w	#$8B03,(a6)			; Mode register 3 setting
			move.w	#$8720,(a6)			; Backdrop color setting
			clr.b	($FFFFF64E).w
			jsr	ClearScreen			; Clear the actual screen
			lea	($FFFFD000).w,a1		; Clear $FFD000-$FFD7FF
			moveq	#0,d0
			move.w	#$7FF,d1

CS4_ClrObjRam:
			move.l	d0,(a1)+
			dbf	d1,CS4_ClrObjRam
				
CS4_Art:		move.l	#$40000000,($C00004).l		; VRAM $0000
			lea	(Art_CS4).l,a0		; Image's tiles
			jsr	NemDec				; Decompress
;Here, you may add the art used for your objects
;		   move.l	#$54C00000,($C00004).l
;		   lea	(Nem_ObjCS4).l,a0
;		   jsr	NemDec
				
CS4_Mappings:
			lea	($FF0000).l,a1			; Load Screen mappings
			lea	(Map_CS4).l,a0
			move.w	#0,d0
			jsr	EniDec
				
CS4_ShowOnVDP:	lea	($FF0000).l,a1			; Show screen
			move.l	#$40000003,d0			; Location
			moveq	#$27,d1
			moveq	#$1B,d2
			jsr	ShowVDPGraphics				

CS4_Palette:
		lea	(Pal_CS4).l,a1
		lea	($FFFFFB80).w,a2
		moveq	#$1F,d0
	@loop:	move.l	(a1)+,(a2)+
		dbf	d0,@loop
				
CS4_Music:		move.w	#$E4,d0		; Play music
			jsr	PlaySound
; The own palette for your object.
;			moveq	#$19,d0		; load Sonic's pallet
;			jsr	PalLoad2				
CS4_LoadObj:	
			jsr	Pal_Fadeto
;Set the object's ID on $FFFFD000
			move.b	#$00,($FFFFD000).w ; load your object
			jsr	ObjectsLoad
			jsr	BuildSprites
; ---------------------------------------------------------------------------------------------------------------------
CS4_Loop:		move.b	#2,($FFFFF62A).w		; Function 2 in vInt
			jsr	DelayProgram			; Run delay program
			jsr	ObjectsLoad
			jsr	BuildSprites
			andi.b	#$80,($FFFFF605).w		; is Start button pressed?
			beq.s	CS4_Loop			; if not, loop
;			jmp	CS4_Loop
CS4_Next:
			move.b	#$30,($FFFFF600).w ; go to next screen
			rts

Pal_CS4:		incbin	'CS4/pal.bin'
			even
Art_CS4:		incbin	'CS4/tiles.bin'
			even
Map_CS4:		incbin	'CS4/maps.bin'
			even