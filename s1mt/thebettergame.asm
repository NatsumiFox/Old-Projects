BetterGame_Cells	equ 40
BetterGame_Lines	equ 28
BetterGame_Time		equ 8-1			; time for a timer
BetterGame_Direction	equ $FF0000+0		; direction snake was moved at
BetterGame_DirNew	equ $FF0000+1		; direction snake will be moving at
BetterGame_Timer	equ $FF0000+2		; byte for amount of frames till next snake move
BetterGame_Blip		equ $FF0000+4		; position of snake food (xpos, ypos)
BetterGame_SnakeLast	equ $FF0000+6		; first word is lenght, next is array of bytes (xpos, ypos)
BetterGame_SnakeBody	equ $FF0000+8		; first word is lenght, next is array of bytes (xpos, ypos)

BetterGame_musiclist:	dc.b $E4+$0A, $E4+$11, $E4+$16, $E4+$02, $E4+$08, 1
BetterGame:
		bsr	ClearScreen

		lea	Palette_NCurr.w,a6
		move.w	#$04C4,($20*0)+(6*2)(a6)
		move.w	#$00A0,($20*0)+(1*2)(a6)
		move.w	#$0A0A,($20*0)+(0*2)(a6)

		move.b	#8,VBlank_Routine.w
		bsr.w	DelayProgram

		fillVRAM 0,$1000,$C000

		jsr	Randomnumber
		add.l	$FFFFFE0C.w,d0
		andi.l	#$3FFF,d0
		divu.w	#4,d0
		swap	d0
		move.b	BetterGame_musiclist(pc,d0.w),d0
		jsr	PlayMusicFade

Snake_Reset:
		lea	VDP_Data_Port,a6
		move.w	#$0404,BetterGame_Direction
		move.b	#BetterGame_Time,BetterGame_Timer
		bsr	CreateSnake
		bsr	CreateBlip
		bra	.mainloop

.pause		andi.b	#$70,$FFFFF605.w
		beq.s	.c
		move.b	#4,$FFFFF600.w
		rts

.c		move.b	#30,VBlank_Routine.w
		bsr.w	DelayProgram
		btst	#7,$FFFFF605.w
		beq.s	.pause

.mainloop	move.b	#30,VBlank_Routine.w
		bsr.w	DelayProgram
		bsr	SnakeDir
		
		btst	#7,$FFFFF605.w
		bne.s	.pause

		subq.b	#1,BetterGame_Timer
		bpl.s	.mainloop
		move.b	#BetterGame_Time,BetterGame_Timer
		move.b	BetterGame_DirNew,BetterGame_Direction

		bsr	MoveSnake
		bra.s	.mainloop
; spawns the snake
CreateSnake:
		moveq	#2,d7
		moveq	#(BetterGame_Cells/2)-2,d2
		moveq	#(BetterGame_Lines/2),d3
		lea	BetterGame_SnakeBody,a1
		move.w	d7,(a1)+

.loop		move.b	d2,(a1)+
		move.b	d3,(a1)+

		move.b	d2,d0
		move.b	d3,d1
		bsr	GetPlatformPos
		move.w	#$30,(a6)
		addq.b	#1,d2
		dbf	d7,.loop
		rts

; get address for Plane from line and cell offsets
GetPlatformPos:
		andi.w	#$FF,d0
		bmi.s	gpfp_skp
		andi.w	#$FF,d1
		bmi.s	gpfp_skp

GetPlatformPos2:
		move.l	#$00034000,d5
		add.w	d0,d0
		add.w	d0,d5

		lsl.w	#7,d1
		add.w	d1,d5

		swap	d5
		move.l	d5,VDP_Control_Port-VDP_Data_Port(a6)
gpfp_skp:
		rts

; spawn new blip
CreateBlip:
		jsr	RandomNumber
		move.b	d0,d1
		lsr.w	#8,d0

.tst		cmpi.b	#BetterGame_Cells-1,d0
		bls.s	.xok
		subi.b	#BetterGame_Cells-1,d0
		bra.s	.tst

.xok		cmpi.b	#BetterGame_Lines-1,d1
		bls.s	.yok
		subi.b	#BetterGame_Lines-1,d1
		bra.s	.xok
		
.yok		lea	BetterGame_SnakeBody,a0
		move.w	(a0)+,d7

.loop		move.b	(a0)+,d5
		move.b	(a0)+,d6

		cmp.b	d0,d5
		bne.s	.next
		cmp.b	d0,d5
		beq.s	CreateBlip

.next		dbf	d7,.loop

		move.b	d0,BetterGame_Blip
		move.b	d1,BetterGame_Blip+1

		bsr.s	GetPlatformPos
		move.w	#$1A,(a6)
		rts

SnakeDir:
		moveq	#0,d0
		move.b	$FFFFF604.w,d0
		andi.b	#$0F,d0
		beq.s	.rts	; if something is pressed, get the desired direction

.getDir		moveq	#0,d6
		move.b	BetterGame_Direction,d2
		move.b	d2,d3
		move.b	d0,d1

		andi.b	#3,d1
		beq.s	.chkLR
		andi.b	#3,d3
		bne.s	.chkLR
		move.b	d1,BetterGame_DirNew
		rts

.chkLR		andi.b	#$C,d0
		beq.s	.rts
		andi.b	#$C,d2
		bne.s	.rts
		move.b	d0,BetterGame_DirNew
.rts		rts

MoveSnake:
		moveq	#0,d0
		move.b	BetterGame_Direction,d0
		beq	.rts
		move.b	.list(pc,d0.w),d0
		moveq	#1,d1
		btst	#0,d0
		beq.s	.notneg
		st	d1
		bra.s	.notneg

.list	dc.b 0, 3, 2, 2, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0

.notneg		lea	BetterGame_SnakeBody,a1
		move.w	(a1)+,d7
		subq.w	#1,d7
		move.w	(a1)+,d2	; store current body
		
		btst	#1,d0
		bne.s	.n
		add.b	d1,-2(a1)
		bra.s	.s

.n		add.b	d1,-1(a1)
.s		move.b	-1(a1),d1
		move.b	-2(a1),d0

		bsr	GetPlatformPos
		move.w	#$30,(a6)

.loop		move.w	d2,d3
		move.w	(a1),d2
		move.w	d3,(a1)+
		dbf	d7,.loop

		move.w	d2,BetterGame_SnakeLast
		move.b	d2,d1
		move.w	d2,d0
		lsr.w	#8,d0

		bsr	GetPlatformPos
		move.w	#0,(a6)

	; now here we check if we are eating a blip
		move.b	BetterGame_SnakeBody+2,d0
		move.b	BetterGame_SnakeBody+3,d1

		cmp.b	BetterGame_Blip,d0
		bne.s	.skip
		cmp.b	BetterGame_Blip+1,d1
		bne.s	.skip

		move.w	BetterGame_SnakeLast,(a1)
		addq.w	#1,BetterGame_SnakeBody

		move.b	BetterGame_SnakeLast,d0
		move.b	BetterGame_SnakeLast+1,d1
		bsr	GetPlatformPos
		move.w	#$30,(a6)
		jsr	CreateBlip

		move.b	BetterGame_SnakeBody+2,d0
		move.b	BetterGame_SnakeBody+3,d1

.skip		cmpi.b	#BetterGame_Cells-1,d0
		bhi.s	.killSnake
		cmpi.b	#BetterGame_Lines-1,d1
		bhi.s	.killSnake

.rts		lea	BetterGame_SnakeBody,a1
		move.w	(a1)+,d7
		subq.w	#1,d7
		move.b	(a1)+,d0
		move.b	(a1)+,d1

		move.b	BetterGame_SnakeLast,d2
		move.b	BetterGame_SnakeLast+1,d3
		cmp.b	d0,d2
		bne.s	.loop3
		cmp.b	d1,d3
		beq.s	.killSnake

.loop3		move.b	(a1)+,d2
		move.b	(a1)+,d3
		
		cmp.b	d0,d2
		bne.s	.next
		cmp.b	d1,d3
		beq.s	.killSnake
.next		dbf	d7,.loop3
		rts

.killSnake	lea	BetterGame_SnakeBody,a1
		move.w	(a1)+,d7

.loop2		move.b	(a1)+,d0
		move.b	(a1)+,d1

		bsr	GetPlatformPos
		move.w	#0,(a6)
		dbf	d7,.loop2

		move.b	BetterGame_Blip,d0
		move.b	BetterGame_Blip+1,d1
		bsr	GetPlatformPos
		move.w	#0,(a6)

		addq.l	#4,sp
		bra	Snake_Reset