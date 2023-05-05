startseq:
                      move.b	#$E4,d0
			jsr	PlaySound_Special		; Stop the music
			jsr	ClearPLC			; Clear the PLC
			jsr	Pal_FadeFrom			; Fade out
			move	#$2700,sr

StSeq_SetupVDP:	        lea	($C00004).l,a6			; Setup teh VDP
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

StSeq_ClrObjRam:
			move.l	d0,(a1)+
			dbf	d1,StSeq_ClrObjRam
				
StSeq_Art:		move.l	#$40000000,($C00004).l		; VRAM $0000
			lea	(Art_StSeq).l,a0		; Image's tiles
			jsr	NemDec				; Decompress
;Here, you may add the art used for your objects
;		   move.l	#$54C00000,($C00004).l
;		   lea	(Nem_ObjStSeq).l,a0
;		   jsr	NemDec
				
StSeq_Mappings:
			lea	($FF0000).l,a1			; Load Screen mappings
			lea	(Map_StSeq).l,a0
			move.w	#0,d0
			jsr	EniDec
				
StSeq_ShowOnVDP:	lea	($FF0000).l,a1			; Show screen
			move.l	#$40000003,d0			; Location
			moveq	#$27,d1
			moveq	#$1B,d2
			jsr	ShowVDPGraphics				

StSeq_Palette:
		lea	(Pal_StSeq).l,a1
		lea	($FFFFFB80).w,a2
		moveq	#$1F,d0
	@loop:	move.l	(a1)+,(a2)+
		dbf	d0,@loop
				
StSeq_Music:	
		 ;       move.w	#$86,d0		; play SBZ music
		;	jsr	PlaySound
; The own palette for your object.
;			moveq	#$19,d0		; load Sonic's pallet
;			jsr	PalLoad2				
StSeq_LoadObj:	
			jsr	Pal_Fadeto
;Set the object's ID on $FFFFD000
			move.b	#$00,($FFFFD000).w ; load your object
			jsr	ObjectsLoad
			jsr	BuildSprites
; ---------------------------------------------------------------------------------------------------------------------
StSeq_Loop:		move.b	#2,($FFFFF62A).w		; Function 2 in vInt
			jsr	DelayProgram			; Run delay program
			jsr	ObjectsLoad
			jsr	BuildSprites
			move.b	($FFFFF605).w,d0	; move the current button press to d0 (we may not and d0 directly for whatever reason)
	        	and.b	#$70,d0			; and the your value on it ($10/B in this case)
		        bne.s	StSeq_next	; if B is being pressed, branch
			andi.b	#$80,($FFFFF605).w		; is Start button pressed?
			beq.s	StSeq_loop			; if yes, end
			
                        move.b	#$38,($FFFFF600).w ; go to next screen
                        rts                       
StSeq_Next:
                         move.b	#$30,($FFFFF600).w ; go to next screen
                        rts
Pal_StSeq:	
                	incbin	'Splashes/palSt.bin'
			even
Art_StSeq:		incbin	'Splashes/tileSt.bin'
			even
Map_StSeq:		incbin	'Splashes/mapSt.bin'
			even
