__script :=		$04		; credits script address
__delay :=		$08		; delay for next script execute
__lines :=		$0A		; line dump for resolve step
TextDump =		MonContTable	; text dump for resolve step
; ---------------------------------------------------------------------------
	dc.b "This is my code, no snooping in here, fucker..."
	even

CredX		macro n
          if "n"<>""
		if n==0
			dc.w .vram
.vram :=		.vram+3

		elseif n==1
			dc.w $1000|.vram
.vram :=		.vram+6

		elseif n==2
			dc.w $2000|.vram
.vram :=		.vram+9

		elseif n==3
			dc.w $3000|.vram
.vram :=		.vram+12

		elseif n==4
			dc.w $4000|.vram
.vram :=		.vram+2
		endif

		shift
		CredX ALLARGS
	endif
    endm
; ---------------------------------------------------------------------------

Mini_HPZ_Handler:
		moveq	#$57,d0			; NAT: Load graphics
		jsr	Load_PLC.w
		move.l	#Mini_HPZ_Credits,__script(a0); load script address)
		move.w	#60,$2E(a0)		; set delay
		move.l	#.resolve,$34(a0)	; run resolve routine
		move.l	#Obj_Wait,(a0)
		jmp	Obj_Wait.w		; delay object execution

.delay		subq.w	#1,__delay(a0)		; decrease script delay
		bpl.s	.rts			; if positive, branch

.resolve	move.l	__script(a0),a1		; load script position to a1
		lea	TextDump.w,a2		; load text dump to a2
		lea	__lines(a0),a3		; load line dump to a3
		lea	.conv-2(pc),a4		; load conversion table to a4
		bra.s	.line

; ---------------------------------------------------------------------------
.sizes		dc.b 8, 16, 24, 8, 8, 'G'

.normal		add.w	d0,d0			; double offset
		move.w	(a4,d0.w),d0		; load real value
		move.w	d0,(a2)+		; save data
		addq.w	#1,d5			; increrase letter counter

		lsl.l	#4,d0			; shit bits into place
		swap	d0			; swap to 4 lsb's
		move.b	.sizes(pc,d0.w),d0	; load letter width
		add.w	d0,d6			; add to line width

.load		moveq	#0,d0
		move.b	(a1)+,d0		; load letter to d0
		bgt.s	.normal			; branch if normal letter

		move.w	d6,(a3)+		; save line width
		move.w	d5,(a3)+		; save letter count
		tst.b	d0			; check if this was end of script token
		bmi.s	.ends			; if so, branch

.line		moveq	#0,d6			; clear line width
		moveq	#0,d5			; clear letters counter

		moveq	#0,d0
		move.b	(a1)+,d0		; load line position to d0
		cmp.b	#$FF,d0			; check if end token
		beq.s	.sega			; if yes, goto sega screen
		move.w	d0,(a3)+		; save it to line dump
		bra.s	.load			; start next loop

.sega		move.b	#$04,(Game_Mode).w	; set to go back to Main Menu
		rts

.ends		moveq	#0,d0
		move.b	(a1)+,d0		; load delay from dump
		lsl.w	#3,d0			; *8
		move.w	d0,__delay(a0)		; save delay

		st	(a3)+			; mark end token
		move.l	a1,__script(a0)		; save script pos
		move.l	#.spawn,(a0)		; do spawn step next frame
.rts		rts

; ---------------------------------------------------------------------------
.conv		dc.w $3000			; space
.vram :=	$3B5				; small
		CredX 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
		CredX 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
						; large
		CredX 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 2
		CredX 1, 2, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1
						; numbers
		CredX 1, 0, 1
; ---------------------------------------------------------------------------

.spawn		lea	TextDump.w,a2		; load text dump to a2
		lea	__lines(a0),a3		; load line dump to a3
		lea	.sizes(pc),a4		; load size table to a4
		move.w	Camera_X_pos.w,d3	; load camera x-pos to d3
		sub.w	#320,d3			; make x-pos go behind the screen
		lea	Dynamic_object_RAM.w,a1	; get dynamic RAM to a1
		move.w	#2,a5			; reset delay

.nwline		move.w	(a3)+,d5		; load y-pos to d5
		bpl.s	.continue		; if negative, branch out
		move.l	#.delay,(a0)		; run this routine
		rts

.continue	move.w	#320,d6			; prepare screen size to d6
		sub.w	(a3)+,d6		; sub width from d6
		asr.w	#1,d6			; halve width (x-offset)
		add.w	d3,d6			; add to x-offset (x-destrination)

		add.w	Camera_Y_pos.w,d5	; offset y-pos with camera
		move.w	(a3)+,d4		; load letter count to d4
		subq.w	#1,d4			; for dbf

		move.w	a5,d2			; load delay into d2
		add.w	#10,a5			; increase delay for next line

.find		lea	next_object(a1),a1	; goto next object
		tst.l	(a1)			; check if its empty
		bne.s	.find			; if not, loop!

		move.l	#Mini_HPZ_Letters,(a1)	; load letters object
		move.w	d2,$2E(a1)		; set delay
		addq.w	#4,d2			; increase delay

		move.w	d6,x_pos(a1)		; save starting x-pos
		move.w	d5,y_pos(a1)		; save object y-pos

		moveq	#0,d0
		move.w	(a2)+,d0		; load text dump data into d0
		move.w	d0,d1			; copy to d1
		and.w	#$7FF,d1		; get only art offset
		move.w	d1,art_tile(a1)		; save it

		lsl.l	#4,d0			; shit bits into place
		swap	d0			; swap to 4 lsb's
		move.b	d0,mapping_frame(a1)	; save as map frame

		move.b	(a4,d0.w),d0		; load letter width
		add.w	d0,d6			; offset x-pos by table value
		dbf	d4,.find		; loop for all objects
		bra.s	.nwline			; do a new line

; ---------------------------------------------------------------------------
	save
	codepage WTF
	CHARSET ' ', 1
	CHARSET 'a','z', 2
	CHARSET 'A','Z', 28
	CHARSET '3', 54
	CHARSET '1', 55
	CHARSET '0', 56

Mini_HPZ_Credits:
	dc.b $20, "SONIC 3 AND KNUCKLES", $00
	dc.b $38, "battle race", $00
	dc.b $60, "presented by natsumi", $00
	dc.b $70, "and markeyjester", $FF, (6*60)/8

	dc.b $20, "NATSUMI", $00
	dc.b $40, "minigames and modes", $00
	dc.b $50, "gameplay additions", $00
	dc.b $60, "fixed game bugs", $00
	dc.b $70, "testing", $00
	dc.b $80, "music", $FF, (6*60)/8

	dc.b $20, "MARKEYJESTER", $00
	dc.b $40, "core game systems", $00
	dc.b $50, "menus and screens", $00
	dc.b $60, "graphics", $00
	dc.b $70, "testing", $00
	dc.b $80, "music", $FF, (6*60)/8

	dc.b $20, "REDHOTSONIC", $00
	dc.b $40, "bounce technology", $00
	dc.b $50, "testing", $FF, (6*60)/8

	dc.b $20, "FOXCONED", $00
	dc.b $40, "music help", $FF, (6*60)/8

	dc.b $90, "testing the hack", $00
	dc.b $30, "VLADIKCOMPER", $00
;	dc.b $30, "SNKENJOI", $00
	dc.b $50, "OZALETO", $00
	dc.b $70, "QIUU", $FF, (6*60)/8

	dc.b $90, "testing the hack", $00
	dc.b $10, "LAZLOPSYLUS", $00
	dc.b $30, "CLOWNACY", $00
	dc.b $50, "VADAPEGA", $00
	dc.b $70, "JORGE", $FF, (6*60)/8

	dc.b $40, "COLINC 10", $00
	dc.b $60, "this hack was inspired", $00
	dc.b $70, "by his hack", $00
	dc.b $80, "sonic ii battle race", $FF, (8*60)/8

	dc.b $FF
	even
	restore
; ---------------------------------------------------------------------------

Mini_HPZ_Letters:
		move.l	#.init,$34(a0)		; run init after delay
		jmp	Obj_Wait.w		; delay object execution

.sizes		dc.b 12,4, 12,8, 12,12, 0,0, 8,4

.init		moveq	#0,d0
		move.b	mapping_frame(a0),d0	; load map frame to d0
		add.w	d0,d0			; double it
		move.w	.sizes(pc,d0.w),height_pixels(a0); load width and height from table

		move.l	#.map,mappings(a0)	; load mappings address
		move.b	#4,render_flags(a0)	; set as level object type
		move.w	#prio(0),priority(a0)	; setup priority level
		move.w	#$CC8,x_vel(a0)		; set starting x-velocity
		move.l	#.movein,(a0)		; move letter into position

.movein		sub.w	#$40,x_vel(a0)		; decrease x-vel
		bpl.s	.move			; if positive, branch
		clr.w	x_vel(a0)		; clear x-vel

		move.l	#.delay,(a0)		; delay moar
		move.l	#.setout,$34(a0)	; run setout later
		move.w	#3*60,$2E(a0)		; set delay of 3 sec
		bra.s	.display		; go display yourselves

.setout		move.l	#.moveout,(a0)		; only set routine
		rts

.delay		bsr.s	.display		; display obj
		jmp	Obj_Wait.w		; then wait

.moveout	add.w	#$40,x_vel(a0)		; increase x-velocity
		jsr	MoveSprite2.w		; move object abouts
		jmp	Sprite_OnScreen_Test.w	; delete if out of range

.move		jsr	MoveSprite2.w		; move object abouts
.display	jmp	Draw_Sprite.w		; display only

; ---------------------------------------------------------------------------
.map	dc.w .let1-.map, .let2-.map, .let3-.map
	dc.w .space-.map, .small-.map

.small	dc.w 1
.space =	*+4
	dc.w $F801, $8000, $0000

.let1	dc.w 1
	dc.w $F402, $8000, $0000

.let2	dc.w 1
	dc.w $F406, $8000, $0000

.let3	dc.w 1
	dc.w $F40A, $8000, $0000
; ---------------------------------------------------------------------------
