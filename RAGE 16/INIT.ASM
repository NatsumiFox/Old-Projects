; ===========================================================================
SetupValues:	dc.w $8000		; XREF: PortA_Ok
		dc.w $3FFF
		dc.w $100

		dc.l $A00000		; start	of Z80 RAM
		dc.l $A11100		; Z80 bus request
		dc.l $A11200		; Z80 reset
		dc.l $C00000
		dc.l $C00004		; address for VDP registers

		dc.b 4,	$74, (PLANEVRAM/$400), (PLANEVRAM^$2000/$400)	; values for VDP registers
		dc.b (PLANEVRAM/$2000), ($E200/$200), 0, 0
		dc.b 0,	0, $FF,	0
		dc.b $81, ($E000/$400), 0, 1
		dc.b $11, 0, 0, $FF
		dc.b $FF, 0, 0,	$80

		dc.l $40000080

		dc.b $AF, 1, $D9, $1F, $11, $27, 0, $21, $26, 0, $F9, $77 ; Z80	instructions
		dc.b $ED, $B0, $DD, $E1, $FD, $E1, $ED,	$47, $ED, $4F
		dc.b $D1, $E1, $F1, 8, $D9, $C1, $D1, $E1, $F1,	$F9, $F3
		dc.b $ED, $56, $36, $E9, $E9

		dc.w $8F02		; value	for VDP	increment
		dc.l $C0000000		; value	for CRAM write mode
		dc.l $40000010

		dc.b $9F, $BF, $DF, $FF	; values for PSG channel volumes
; ===========================================================================

EntryPoint:
	di
		tst.l	($A10008).l	; test port A control
		bne.s	.k
		tst.w	($A1000C).l	; test port C control
.k		bne.s	SetupGame

		lea	SetupValues(pc),a5
		movem.w	(a5)+,d5-d7
		movem.l	(a5)+,a0-a4
		move.b	-$10FF(a1),d0	; get hardware version
		andi.b	#$F,d0
		beq.s	SkipSecurity
		move.l	Console.w,$2F00(a1)

SkipSecurity:
		move.w	(a4),d1
		btst	#1,d1
		bne.s	SkipSecurity	; wait till a DMA is completed

		moveq	#0,d0
		movea.l	d0,a6
		move.l	a6,usp		; set usp to $0
		moveq	#$17,d1

VDPInitLoop:
		move.b	(a5)+,d5	; add $8000 to value
		move.w	d5,(a4)		; move value to	VDP register
		add.w	d7,d5		; next register
		dbf	d1,VDPInitLoop
		move.l	(a5)+,(a4)
		move.w	d0,(a3)		; clear	the screen
		move.w	d7,(a1)		; stop the Z80
		move.w	d7,(a2)		; reset	the Z80

WaitForZ80:
		btst	d0,(a1)		; has the Z80 stopped?
		bne.s	WaitForZ80	; if not, branch
		moveq	#$25,d2

Z80InitLoop:
		move.b	(a5)+,(a0)+
		dbf	d2,Z80InitLoop
		move.w	d0,(a2)
		move.w	d0,(a1)		; start	the Z80
		move.w	d7,(a2)		; reset	the Z80

ClrRAMLoop:
		move.l	d0,-(a6)
		dbf	d6,ClrRAMLoop	; clear	the entire RAM
		move.w	(a5)+,(a4)	; set VDP display mode and increment
		move.l	(a5)+,(a4)	; set VDP to CRAM write
		moveq	#$1F,d3

ClrCRAMLoop:
		move.l	d0,(a3)
		dbf	d3,ClrCRAMLoop	; clear	the CRAM
		move.l	(a5)+,(a4)
		moveq	#$13,d4

ClrVDPStuff:
		move.l	d0,(a3)
		dbf	d4,ClrVDPStuff
		moveq	#3,d5

PSGInitLoop:
		move.b	(a5)+,$11(a3)	; reset	the PSG
		dbf	d5,PSGInitLoop
		move.w	d0,(a2)
		movem.l	(a6),d0-a6	; clear	all registers

SetupGame:
	; clearing the entire RAM seems to prevent issues when running on hw...
	; somehow?
		lea	$FFFF0000,a0
		move.w	#($FFFFFFFF-$FFFF0000)/4,d0
		moveq	#0,d1

.clr		move.l	d1,(a0)+
		dbf	d0,.clr

		moveq	#$40,d0
		move.b	d0,$A10009.l	; init port 1 (joypad 1)
		move.b	d0,$A1000B.l	; init port 2 (joypad 2)
		move.b	d0,$A1000D.l	; init port 3 (extra)

GameProgram:
		lea	STACK_PTR.w,sp
		movem.l	vdp_comm_port.w,a5-a6
		lea	PalDat(pc),a0
		move.l	(a0)+,(a5)
	rept 32/4
		move.l	(a0)+,(a6)
	endr

		move.l	(a0)+,(a5)
		move.l	(a0)+,(a6)
		move.l	(a0)+,(a5)
		move.l	(a0),(a6)
		move.l	(a0),(a6)
		move.l	(a0),(a6)
		move.l	(a0),(a6)

	vdpcomm move.l,0,VRAM,WRITE,(a5)
		move.l	#$11111111,d1
		moveq	#0,d0
		moveq	#$F-1,d2

.load	rept 32/4
		move.l	d0,(a6)
	endr

		add.l	d1,d0
		dbf	d2,.load

		lea	OBJECTS.w,a0
		moveq	#OBJCNT-1,d7

.clrloop	jsr	DeleteObj.w
		add.w	#SIZE,a0
		dbf	d7,.clrloop

		move.w	#ObjTitle1,OBJECTS.w
		move.w	#ObjTitle2,OBJECTS+SIZE.w
		move.w	#ObjDiff,OBJECTS+SIZE+SIZE.w
		move.w	#ObjChoose,OBJECTS+SIZE+SIZE+SIZE.w

		move.w	PLANEXCHKPT.w,d0
		sub.w	#38,d0
		bpl.s	.x
		moveq	#0,d0
.x		move.w	d0,PLANEX.w
		move.w	#ObjectLayout,a0

.next		cmp.w	(a0),d0
		bls.s	.svobj
		addq.w	#6,a0
		bra.s	.next

.svobj		move.w	a0,LAYOUTINDEX.w

.main		cmp.w	#ObjPlayer_Main,OBJECTS.w
		bne.s	.norun
		bchg	#7,PLANEUPDATED.w
		beq.s	.norun
		addq.w	#1,PLANEX.w

		move.w	PLANEX.w,d7
		move.w	LAYOUTINDEX.w,a0

.nextobj	cmp.w	(a0)+,d7
		blo.s	.endobj

		jsr	LoadObj.w
		cmp.w	#0,a1
		beq.s	.endobj

		move.w	(a0)+,(a1)
		move.w	(a0)+,YPOS(a1)	; ypos + arg
		bra.s	.nextobj

.endobj		move.w	a0,LAYOUTINDEX.w
		subq.w	#2,LAYOUTINDEX.w

.norun		lea	OBJECTS.w,a0
		moveq	#OBJCNT-1,d7

.objloop	move.w	(a0),a1
		jsr	(a1)
		add.w	#SIZE,a0
		dbf	d7,.objloop

		stop	#$2300
		bra.s	.main

; ===========================================================================
PalDat:	vdpcomm dc.l,0,CRAM,WRITE
	incbin "MAIN.PAL"
	vdpcomm dc.l,0,VSRAM,WRITE
		dcb.w 2,YOFF*8
	vdpcomm dc.l,$E000,VRAM,WRITE
		dcb.w 2,-XOFF*8
; ===========================================================================
