ROMInfo:
				move.b	#$E4,d0		;E4
SkipCheck:
				jsr	Playsound_special               ; Stop music
				jsr	ClearPLC			; Clear PLCs
				jsr	Pal_FadeFrom			; Fade out previous palette
				jsr	SoundDriverLoad
				move	#$2700,sr

ROMInfoScreen_VDP:		lea	($C00004).l,a6			; Setup VDP
                               	move.w	#$8004,(a6)
				move.w	#$8230,(a6)
				move.w	#$8407,(a6)
				move.w	#$9001,(a6)
				move.w	#$9200,(a6)
				move.w	#$8B03,(a6)
;				move.w	#$8C00,(a6)		; H res 32 cells, no interlace, S/H enabled
				move.w	#$8720,(a6)
				clr.b	($FFFFF64E).w
				jsr	ClearScreen			; Clear screen
				lea	($FFFFD000).w,a1
				moveq	#0,d0
				move.w	#$7FF,d1

ROMInfo_ClrObjRam:
				move.l	d0,(a1)+
				dbf	d1,ROMInfo_ClrObjRam
				
ROMInfoScreen_Art:		move.l	#$74000002,($C00004).l		;Localizacion en VRAM a usar
				lea	(Art_ASCII),a2			;Poner arte en memoria xd
				move.w	#$5A,d0				;Cantidad de bytes (hex) / $20
				jsr	LoadUncArt			;Cargar el arte a VRAM
				move.l	#$54C00000,($C00004).l
				lea	(Nem_XulSpr).l,a0
				jsr	NemDec
				
ROMInfoScreen_Mappings:
				move.l	#$40000003,d5
				cmpi.b	#$34,($FFFFF600).w
				beq.s	Message_Warning
                                lea	(ROMInfo_ASCII),a1
				jmp	ROMInfoScreen_Mappings_Cont
Message_Warning: 
                        	lea	(Warning_ASCII_spa),a1
                        	clr.w	($FFFFF600).w
ROMInfoScreen_Mappings_Cont:
				move.w	#$6580,d3
				jsr	LoadASCII
				jmp	ROMInfoScreen_ShowOnVDP
				
ROMInfoScreen_Mappings_Cont2:
				move.w	#$2580,d3
				jsr	LoadASCII

ROMInfoScreen_ShowOnVDP:	
				move.w	#-$A,($FFFFF632).w
				move.w	($FFFFF60C).w,d0
				ori.b	#$40,d0
				move.w	d0,($C00004).l
				move.w	#0,($FFFFFB000+$80).w
ROMInfoScreen_Palette:
				lea	($FFFFFB80).w,a1
				moveq	#0,d0
				move.w	#$1F,d1

ROMInfo_ClrPallet:
				move.l	d0,(a1)+
				dbf	d1,ROMInfo_ClrPallet ; fill pallet with 0	(black)
				cmpi.b	#$40,($FFFFF600).w
				beq.s	ROMInfo_Pal2
				moveq	#$17,d0
				jsr	PalLoad2
				moveq	#$17,d0
				jsr	PalLoad1
				jsr	Pal_FadeTo
				moveq	#$17,d0
				jsr	PalLoad1
				moveq	#$17,d0
				jsr	PalLoad2
				jmp	ROMInfoScreen_LoadObj

ROMInfo_Pal2:
				moveq	#$1A,d0
				jsr	PalLoad2
				moveq	#3,d0
				jsr	PalLoad2
				moveq	#$1A,d0
				jsr	PalLoad1
				moveq	#3,d0
				jsr	PalLoad1
				jsr	Pal_FadeTo
				moveq	#3,d0
				jsr	PalLoad1
				moveq	#$1A,d0
				jsr	PalLoad1
				moveq	#3,d0
				jsr	PalLoad2
				moveq	#$1A,d0
				jsr	PalLoad2
		
ROMInfoScreen_LoadObj:

				jsr	ObjectsLoad
				jsr	BuildSprites
; ---------------------------------------------------------------------------------------------------------------------
ROMInfoScreen_Loop:		move.b	#2,($FFFFF62A).w		; Function 2 in vInt
				jsr	DelayProgram			; Run delay program
				jsr	ObjectsLoad
				jsr	BuildSprites
ROMInfoScreen_Loop_NoObj:
				andi.b	#$70,($FFFFF605).w		; is Start button pressed?
				beq.s	ROMInfoScreen_Loop		; if not, loop

ROMInfoScreen_Next:
				
Rominfo_chkgm:				
                                cmpi.b	#$30,($FFFFF600).w
				beq.s	Go_Warn
				move.b	#$20,($FFFFF600).w
				rts
Go_Warn:
				move.b	#$34,($FFFFF600).w
				rts                                	