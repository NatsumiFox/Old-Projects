Credits:
		moveq	#$FFFFFFE0,d0
		bsr.w	PlaySound	; fade out music
		bsr	ClearPLC
		bsr	Pal_FadeFrom
		bsr	ClrObjRAM

		lea	($FFFFF628).w,a1
		moveq	#0,d0
		move.w	#$15,d1

.ClrVars:
		move.l	d0,(a1)+
		dbf	d1,.ClrVars ; clear misc variables

		lea	($FFFFF700).w,a1
		moveq	#0,d0
		move.w	#$3F,d1
.ClrVars2:
		move.l	d0,(a1)+
		dbf	d1,.ClrVars2 ; clear misc variables

		lea	($FFFFFE60).w,a1
		moveq	#0,d0
		move.w	#$47,d1

.ClrVars3:
		move.l	d0,(a1)+
		dbf	d1,.ClrVars3 ; clear object variables

		move.w	d0,$FFFFF614.w
		move.w	d0,Cred_SCRID.w

		move	#$2700,sr
		bsr.w	ClearScreen
		lea	VDP_Control_Port,a6
		move.w	#$8B03,(a6)
		move.w	#$8230,(a6)
		move.w	#$8407,(a6)
		move.w	#$857C,(a6)
		move.w	#$9001,(a6)
		move.w	#$8004,(a6)
		move.w	#$8720,(a6)
		move.w	#$8ADF,($FFFFF624).w
		move.w	($FFFFF624).w,(a6)
		clr.w	DMA_Buffer_Start			; clear start of the DMA queue
		move.l	#DMA_Buffer_Start,DMA_Buffer_End	; reset address pointer of DMA queue

		lea	$FFFFFB00,a2
		lea	$FFFFFA80,a3
		bsr	LoadPlayerPallets		; load palette

		moveq	#$FFFFFFE4,d0
		jsr	PlayMusic

		move.b	#8,VBlank_Routine.w
		bsr.w	DelayProgram

		cmpi.b	#7,Emeralds.w		; do you have 7 emeralds collected?
;		bne.s	.norm			; if not, dont play PCM
		moveq	#$FFFFFF9B,d0
		jsr	PlaySample

Credits_MainLoop:
		move.b	#8,VBlank_Routine.w
		bsr.w	DelayProgram
		jsr	ObjectsLoad
		jsr	BuildSprites
		addq.w	#3,Cred_MoveOff.w	; scan for letters

.skip		tst.w	$FFFFF614.w		; is time left?
		bne.s	.skipThing		; if is, dont load
		bsr	Cred_LoadNextASCII

.skipThing	move.w	Cred_SCRID.w,d0
		movea.l	Credits_ASCII(pc,d0.w),a2; get the address of the DPLC file
		cmpi.w	#-1,(a2)		; does the first word contain -1?
		bne.s	.next			; if no, do normal
		addq.w	#1,$FFFFF614.w		; as long as next entry is -1, keep looping forever (until Start is pressed
		btst	#7,$FFFFF605.w		; is Start button pressed?
		beq	.next			; if is, branch
		move.w	#0,$FFFFF614.w		; clear timer so the fadeout can happen

.next		bra.s	Credits_MainLoop

Cred_ToTitle:
		sf	Current_Character.w
		move.b	#4,$FFFFF600.w
		addq.l	#4,sp
		moveq	#$FFFFFF80,d0
		jmp	PlaySample				; Stop SEGA sound

Cred_ToTitle_rts:
		rts

Credits_ASCII:	dc.l Cred_1, Cred_2, Cred_3, Cred_4, Cred_5, Cred_6, Cred_7, Cred_8, Cred_9, Cred_10, Cred_11, .end
.end	dc.w -1


Cred_LoadNextASCII:
		lea	Object_RAM.w,a1 ; start address for object RAM
		move.w	#$7F,d0

.loop		lea	Next_Obj(a1),a1		; goto next object RAM slot
		cmpi.b	#Cred_Obj_ID,(a1)	; is this the credits object
		beq.s	Cred_ToTitle_rts	; if yes, then skip
.next		dbf	d0,.loop		; if the slot is not empty, repeat

		move.w	#$7FFF,$FFFFF614.w	; set timer to max value
		move.w	Cred_SCRID.w,d0		; get next credits ID
		addq.w	#4,Cred_SCRID.w		; increment to next slot for next time
		move.w	#0,Cred_MoveOff.w	; reset offset

		movea.l	Credits_ASCII(pc,d0.w),a2; get the address of the DPLC file
		cmpi.w	#-1,(a2)		; does the first word contain -1?
		beq.s	Cred_ToTitle		; if yes, then this is the cue to title screen transition

		move.l	a2,-(sp)		; store DPLC
                move.l  #Nem_Titlecard,d6	; artunc
                move.w  #$20,d4			; VRAM address
                move.w  #0,d0			; DPLC id
                jsr     Load_DPLC2              ; load the DPLC

		moveq	#Cred_YStart,d7		; initial Y offset
		moveq	#0,d6			; initial X offset
		moveq	#1,d5			; initial tile offset
		addq.l	#4,(sp)			; skip the start and pointer
		move.l	(sp),a2			; get the proper DPLC from stack
		move.l	(sp)+,a0		; get the proper DPLC from stack
		lea	Object_RAM+Next_Obj.w,a1; get the object RAM

		move.b	#Cred_Obj_ID,-Next_Obj(a1); set last object
		move.b	#4,-Next_Obj+Routine(a1); set to timer object

.ProcessSize	tst.w	(a0)			; if this is end of file
		beq.s	.ProcessLastLine	; then process last line

		cmpi.w	#1,(a0)			; is this the "next line" token
		bne.s	.notNextLine		; if not, skip
		bsr.s	.ProcessLine		; process collected data

	; this piece of code here calculates the space letters will need
	; this is done to calculate where to start to draw them to make them centered
.notNextLine	moveq	#0,d0
		move.b	(a0),d0			; number of loaded tiles
		lsr.w	#4,d0			; get high digit to low digit
		addq.l	#2,a0			; skip

		bsr.s	Cred_TileGetXSize	; get tile size
		add.w	d0,d6			; add to X Offset
		bra.s	.ProcessSize		; do until end

	; processes last line and creates timer object
.ProcessLastLine
		bsr.s	.ProcessLine		; process the line
		move.b	#Cred_Obj_ID,(a1)	; set last object
		move.b	#2,Routine(a1)		; set to timer object
		rts

	; create actual letter objects and get next line (if any)
.ProcessLine	move.w	#320,d4			; screen X-width
		sub.w	d6,d4			; get full free space
		lsr.w	#1,d4			; finally halve it and now use it as the start offset

.loadNextTile	cmpi.w	#2,(a2)			; is this a command?
		bls.s	.rest			; if so, skip (only to work with things to do with next line for now)

		moveq	#0,d0
		move.b	(a2),d0			; number of loaded tiles
		lsr.w	#4,d0			; get high digit to low digit
		addq.l	#2,a2			; skip

		cmpi.w	#$20FC,-2(a2)		; is this space
		beq.s	.noTile			; if so, dont load object
		bsr.s	Cred_LoadTile		; load the next tile

.noTile		addq.w	#1,d5			;
		add.w	d0,d5			; set correct tile offset
		bsr.s	Cred_TileGetXSize	; get tile size
		add.w	d0,d4			; add to X Offset
		bra.s	.loadNextTile		; load next tile

.rest		addq.l	#2,a2			; skip command bit (to not infinitely loop)
		move.l	a2,a0			; store this new address to memory
		addi.w	#Cred_YNext,d7		; next Y-position
		moveq	#0,d6			; initial X offset
		addq.w	#1,d5			; next tile
		rts

	; gets the horizontal space taken up by the tile in pixels
Cred_TileGetXSize:
		addq.w	#1,d0			; this is set for divu
		divu.w	#3,d0			; get only number of horizontal rows
		lsl.w	#3,d0			; make it to tiles
		addq.w	#2,d0			; additional space
		rts

	; loads tile object and creates new one
Cred_LoadTile:
		move.b	#Cred_Obj_ID,(a1)
		move.l	#Cred_Mappings,Mappings_Offset(a1)
		move.b	d0,Anim_Frame(a1)	; set correct mappings frame (to make correct mappings size)
		move.w	d5,Art_Tile(a1)		; set art offset
		move.w	d4,Cred_XPosEnd(a1)	; store target position
		move.w	#320+$20,Cred_XPosStart(a1); store starting position
		move.w	#320+$20,X_Pos(a1)	; set to starting position
		move.w	d7,Y_Pos(a1)		; set Y-position
		sf	Routine(a1)		; clear routine
		lea	Next_Obj(a1),a1		; goto next object RAM slot
		rts

Cred_1:		dc.w .1-Cred_1
		dc.b 0
.1		dc.b ((.1End+1-.1)/2)-2
		ttlcard2 'D','E','V','E','L','O','P','M','E','N','T', 1, 'A','N','D', 1
		ttlcard2 'P','R','O','G','R','A','M','M','I','N','G',' ', 1, ' ', 1
		ttlcard2 'G','R','E','E','N',' ','S','N','A','K','E', 1
		ttlcard2 'A','K','A',' ','N','A','T','S','U','M','I', 0
.1End		even

Cred_2:		dc.w .2-Cred_2
		dc.b 0
.2		dc.b ((.2End+1-.2)/2)-2
		ttlcard2 'M','U','S','I','C',' ','C','R','E','A','T','E','D',' ','B','Y', 1, ' ', 1
		ttlcard2 'V','L','A','D','I','K','C','O','M','P','E','R', 1
		ttlcard2 'E','L','E','C','T','R','O','B','A','L','L', 1
		ttlcard2 'D','A','L','E','K','S','A','M', 1
		ttlcard2 'S',' ','T',' ','D', 0
.2End		even


Cred_3:		dc.w .3-Cred_3
		dc.b 0
.3		dc.b ((.3End+1-.3)/2)-2
		ttlcard2 'B','E','T','A','T','E','S','T','I','N','G',' ','H','E','L','P', 1, ' ', 1
		ttlcard2 'V','L','A','D','I','K','C','O','M','P','E','R', 1
		ttlcard2 'D','I','S','C','O','T','H','E','B','A','T', 1
		ttlcard2 'S','O','N','I','C','V','A','A','N', 1
		ttlcard2 'D','J','O','H','E', 0
.3End		even

Cred_4:		dc.w .4-Cred_4
		dc.b 0
.4		dc.b ((.4End+1-.4)/2)-2
		ttlcard2 'B','E','T','A','T','E','S','T','I','N','G',' ','H','E','L','P', 1, ' ', 1
		ttlcard2 'T','H','E','S','T','O','N','E','B','A','N','A','N','A', 1
		ttlcard2 'L','U','I','G','I','X','H','E','R','O', 1
		ttlcard2 'A','N','I','M','E','M','A','S','T','E','R', 1
		ttlcard2 'D','A',' ','G','A','R','D','E','N', 0
.4End		even

Cred_5:		dc.w .5-Cred_5
		dc.b 0
.5		dc.b ((.5End+1-.5)/2)-2
		ttlcard2 'S','P','E','C','I','A','L',' ','T','H','A','N','K','S', 1, ' ', 1
		ttlcard2 'S','O','U','N','D',' ','D','R','I','V','E','R',' ','A','N','D', 1
		ttlcard2 'P','R','O','G','R','A','M',' ','H','E','L','P', 1, ' ', 1
		ttlcard2 'V','L','A','D','I','K','C','O','M','P','E','R', 0
.5End		even

Cred_6:		dc.w .6-Cred_6
		dc.b 0
.6		dc.b ((.6End+1-.6)/2)-2
		ttlcard2 'S','P','E','C','I','A','L',' ','T','H','A','N','K','S',1,' ',1
		ttlcard2 'H','A','R','D','W','A','R','E',' ','I','N','F','O',' ','A','N','D',1
		ttlcard2 'N','A','T','S','U','M','I',' ','S','C','R','E','E','N',' ','H','E','L','P',1, ' ', 1
		ttlcard2 'J','O','R','G','E', 0
.6End		even

Cred_7:		dc.w .7-Cred_7
		dc.b 0
.7		dc.b ((.7End+1-.7)/2)-2
		ttlcard2 'S','P','E','C','I','A','L',' ','T','H','A','N','K','S', 1, ' ', 1
		ttlcard2 'P','L','A','Y','T','E','S','T','I','N','G',' ','Q','U','A','L','I','T','Y', 1
		ttlcard2 'A','S','S','U','R','A','N','C','E',' ','A','N','D',' ','I','D','E','A','S', 1, ' ', 1
		ttlcard2 'T','H','E',' ','D','U','C','K','S', 0
.7End		even

Cred_8:		dc.w .8-Cred_8
		dc.b 0
.8		dc.b ((.8End+1-.8)/2)-2
		ttlcard2 'S','P','E','C','I','A','L',' ','D','U','C','K','S', 1, ' ', 1
		ttlcard2 'T','H','E','S','T','O','N','E','B','A','N','A','N','A', 1
		ttlcard2 'A','B','Y','S','S','A','L',' ','L','E','O','P','A','R','D', 1
		ttlcard2 'L','U','I','G','I','X','H','E','R','O', 1
		ttlcard2 'R','A','L','A','K','I','M','U','S', 0
.8End		even

Cred_9:		dc.w .9-Cred_9
		dc.b 0
.9		dc.b ((.9End+1-.9)/2)-2
		ttlcard2 'O','T','H','E','R',' ','D','U','C','K','S', 1, ' ', 1
		ttlcard2 'T','H','O','M','A','S','S','P','E','E','D','R','U','N','N','E','R', 1
		ttlcard2 'N','E','O','F','U','S','I','O','N','B','O','X', 1
		ttlcard2 'R','O','B','O','B','O','T', 1
		ttlcard2 'C','L','E','F','A','B','L','E', 0
.9End		even

Cred_10:	dc.w .10-Cred_10
		dc.b 0
.10		dc.b ((.10End+1-.10)/2)-2
		ttlcard2 'A','N','D',' ','O','F',' ','C','O','U','R','S','E',' ','Y','O','U', 1, ' ', 1, ' ', 1
		ttlcard2 'T','H','A','N','K',' ','Y','O','U',' ','F','O','R', 1
		ttlcard2 'P','L','A','Y','I','N','G', 1, ' ', 1
		ttlcard2 'Y','O','U',' ','D','I','D',' ','G','O','O','D', 0
.10End		even

Cred_11:	dc.w .11-Cred_11
		dc.b 0
.11		dc.b ((.11End+1-.11)/2)-2
		ttlcard2 'J','U','S','T',' ','K','I','D','D','I','N','G', 1, ' ', 1
		ttlcard2 'Y','O','U',' ','P','L','A','Y','E','D',' ','H','O','R','R','I','B','L','Y', 1, ' ', 1, ' ', 1, ' ', 1
		ttlcard2 'P','R','E','S','S',' ','S','T','A','R','T',' ','B','U','T','T','O','N', 0
.11End		even

Cred_YStart:	equ $12		; Y-Position to start laying tiles at
Cred_YNext:	equ $20		; next Y-position to lay tiles at
Cred_OffScr:	equ -$40	; Offscreen target position
Cred_MoveSpeedA	equ $300	; Offscreen target position
Cred_MoveSpeedM	equ 6		; Offscreen target position

Cred_XPosStart:	equ $3C		; object SST; position where we originally started at
Cred_XPosEnd:	equ $3E		; object SST; position where we are targeting to

Cred_Obj_ID:	equ $80		; Object ID

Cred_Mappings:	dcb.w 2,0
		dc.w .3-Cred_Mappings
		dcb.w 2,0
		dc.w .5-Cred_Mappings
		dcb.w 2,0
		dc.w .8-Cred_Mappings

.3		dc.b 1, -((3*8)/2), $2, 0, 0, -((1*8)/2)+2
.5		dc.b 1, -((3*8)/2), $6, 0, 0, -((2*8)/2)+8
.8		dc.b 1, -((3*8)/2), $A, 0, 0, -((3*8)/2)+10
		even

Cred_Obj_Timer:
		lea	-Next_Obj(a0),a1	; get last object (aka last object to hit its target position)
		move.w	X_Pos(a1),d0		; get its X-position for testing
		cmp.w	Cred_XPosEnd(a1),d0	; is at the targeted position?
		bne.s	Cred_Obj_Timer_rts	; if not, check next frame
		move.w	#(3*60)+30,$FFFFF614.w	; delay of x seconds
		jmp	DeleteObject		; get rid of this object

Cred_Obj_Timer_rts:
		rts

Cred_Obj_BackWards:
		tst.w	$FFFFF614.w		; is time left?
		bne	Cred_Obj_Timer_rts	; if is, dont move
		move.w	#0,Cred_MoveOff.w	; reset offset

Cred_Obj_Delete:
		jmp	DeleteObject		; get rid of this object

Cred_Obj:
		moveq	#0,d0
		move.b	Routine(a0),d0
		move.w	.I(pc,d0.w),d1
		jmp	.I(pc,d1.w)
; ===========================================================================
.I:		dc.w .Main-.I
		dc.w Cred_Obj_Timer-.I
		dc.w Cred_Obj_BackWards-.I
		dc.w .FadeIn-.I
		dc.w Cred_Obj_Wait-.I
		dc.w Cred_Obj_ChkDel-.I
; ===========================================================================


.Main		addq.b	#6,Routine(a0)		; set to fadein routine
		move.b	#4,Render_Flags(a0)	;

.FadeIn	;	lea	-Next_Obj(a0),a1	; get last object to a1
;		cmp.b	#Cred_Obj_ID,(a1)	; is it an actual object?
;		bne.s	.GoodToGo		; if not, we are free to go

;		move.w	Y_Pos(a0),d0		; get Y-position for testing
;		cmp.w	Y_Pos(a1),d0		; are we on same Y-position?
;		bne.s	.GoodToGo		; if not, we are free to go

		move.w	Cred_MoveOff.w,d0
;		move.w	Cred_XPosEnd(a1),d0	; get its target position for testing
;		addi.w	#(320/4),d0		; get some random distance accross the screen to start moving this one at
		cmp.w	Cred_XPosEnd(a0),d0	; is near the targeted position?
		ble	Cred_Obj_Display	; if not, display only

.GoodToGo	move.w	Cred_XPosEnd(a0),d3	; these are used to create slowdown for the object
		sub.w	Cred_XPosStart(a0),d3	; movement when they have short distance to travel
		move.w	Cred_XPosEnd(a0),d1
		bsr	Cred_GetSpeed

		jsr	SpeedToPos		; move the letters
		move.w	Cred_XPosEnd(a0),d0	; get own target position for testing
		cmp.w	X_Pos(a0),d0		; has passed targeted position?
		blt.s	Cred_Obj_Display	; if not, display only

		move.w	d0,X_Pos(a0)		; fix X-position
		move.w	#0,X_Vel(a0)		; clear velocity
		addq.b	#2,Routine(a0)		; next routine
		jmp	DisplaySprite

Cred_Obj_Wait:
		tst.w	$FFFFF614.w		; is time left?
		bne	Cred_Obj_Display	; if is, dont move
		addq.b	#2,Routine(a0)		; fadeout

Cred_Obj_ChkDel:
;		lea	-Next_Obj(a0),a1	; get last object to a1
;		cmp.b	#Cred_Obj_ID,(a1)	; is it an actual object?
;		bne.s	.GoodToGo		; if not, we are free to go

;		move.w	Y_Pos(a0),d0		; get Y-position for testing
;		cmp.w	Y_Pos(a1),d0		; are we on same Y-position?
;		bne.s	.GoodToGo		; if not, we are free to go

;		move.w	#Cred_OffScr,d0		; get its target position for testing
;		addi.w	#(320/4),d0		; get some random distance accross the screen to start moving this one at
		move.w	Cred_MoveOff.w,d0
		cmp.w	Cred_XPosEnd(a0),d0	; is near the targeted position?
		ble.s	Cred_Obj_Display	; if not, display only

.GoodToGo	moveq	#Cred_OffScr,d3		; these are used to create slowdown for the object
		sub.w	Cred_XPosEnd(a0),d3	; movement when they have short distance to travel
		moveq	#Cred_OffScr,d1		; get the targeted position
		bsr	Cred_GetSpeed		; get speed

		jsr	SpeedToPos		; move the letters
		moveq	#Cred_OffScr,d0		; get own target position for testing
		cmp.w	X_Pos(a0),d0		; has passed targeted position?
		blt.s	Cred_Obj_Display	; if not, display only
		jmp	DeleteObject

Cred_Obj_Display:
		jmp	DisplaySprite

Cred_GetSpeed:
		sub.w	X_Pos(a0),d1
		moveq	#0,d2
		jsr	CalcAngle
		jsr	CalcSine		; get speed to move letters in

		muls.w	#Cred_MoveSpeedM,d3
		neg.w	d3
		addi.w	#Cred_MoveSpeedA,d3
		muls.w	d3,d1
		asr.l	#8,d1
		move.w	d1,X_Vel(a0)		; set speed
		rts
