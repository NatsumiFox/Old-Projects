; ---------------------------------------------------------------------------
RandomNumber:
		move.l	RNG_Seed.w,d1
		move.l	d1,d0
		asl.l	#2,d1
		add.l	d0,d1
		asl.l	#3,d1
		add.l	d0,d1
		move.w	d1,d0
		swap	d1
		add.w	d1,d0
		move.w	d0,d1
		swap	d1
		move.l	d1,RNG_Seed.w
		rts

; ---------------------------------------------------------------------------
GetSine:
		andi.w	#$FF,d0
		addq.w	#8,d0
		add.w	d0,d0
		move.w	SineTable+($40*2)-16(pc,d0.w),d1
		move.w	SineTable-16(pc,d0.w),d0
		rts

; ---------------------------------------------------------------------------
SineTable:	incbin 'levels/SineTable.bin'
; ---------------------------------------------------------------------------

GetArcTan:
		movem.l	d3-d4,-(sp)
		moveq	#0,d3
		moveq	#0,d4
		move.w	d1,d3
		move.w	d2,d4
		or.w	d3,d4
		beq.s	loc_2036
		move.w	d2,d4
		tst.w	d3
		bpl.s	loc_1FFC
		neg.w	d3

loc_1FFC:
		tst.w	d4
		bpl.s	loc_2002
		neg.w	d4

loc_2002:
		cmp.w	d3,d4
		bhs.s	loc_2012
		lsl.l	#8,d4
		divu.w	d3,d4
		moveq	#0,d0
		move.b	ArcTan_Table(pc,d4.w),d0
		bra.s	loc_201C
; ---------------------------------------------------------------------------

loc_2012:
		lsl.l	#8,d3
		divu.w	d4,d3
		moveq	#$40,d0
		sub.b	ArcTan_Table(pc,d3.w),d0

loc_201C:
		tst.w	d1
		bpl.s	loc_2026
		neg.w	d0
		addi.w	#$80,d0

loc_2026:
		tst.w	d2
		bpl.s	loc_2030
		neg.w	d0
		addi.w	#$100,d0

loc_2030:
		movem.l	(sp)+,d3-d4
		rts

; ---------------------------------------------------------------------------

loc_2036:
		move.w	#$40,d0
		movem.l	(sp)+,d3-d4
		rts

; ---------------------------------------------------------------------------
ArcTan_Table:	incbin 'levels/ArcTan_Table.bin'
; ---------------------------------------------------------------------------

WritePlaneMap:
		lea	VDP_data_port,a6
		move.l	#$800000,d4		; get addition for next line

.writeLine	move.l	d0,4(a6)		; write VDP command
		move.w	d1,d3			; copy tile amount to d3

.writeTile	move.w	(a1)+,(a6)		; write single tile
		dbf	d3,.writeTile		; loop for the entire row
		add.l	d4,d0			; drop to next row
		dbf	d2,.writeLine		; write entire map
		rts
; ---------------------------------------------------------------------------

WritePlaneMap2:
		lea	VDP_data_port,a6
		move.l	#$1000000,d4		; get addition for next line

.writeLine	move.l	d0,4(a6)		; write VDP command
		move.w	d1,d3			; copy tile amount to d3

.writeTile	move.w	(a1)+,(a6)		; write single tile
		dbf	d3,.writeTile		; loop for the entire row
		add.l	d4,d0			; drop to next row
		dbf	d2,.writeLine		; write entire map
		rts
; ---------------------------------------------------------------------------

AddQueueDMA:
		movea.l	VDP_Command_Buffer_Slot.w,a1
		cmpa.w	#VDP_Command_Buffer_Slot,a1
		beq.s	.rts			; if queue is full, branch

		move.w	#$9300,d0
		move.b	d3,d0
		move.w	d0,(a1)+	; set first 8 bits of length

		move.w	#$9400,d0
		lsr.w	#8,d3
		move.b	d3,d0
		move.w	d0,(a1)+	; set second 8 bits of length

		move.w	#$9500,d0
		lsr.l	#1,d1
		move.b	d1,d0
		move.w	d0,(a1)+	; set source address & $0001FE

		move.w	#$9600,d0
		lsr.l	#8,d1
		move.b	d1,d0
		move.w	d0,(a1)+	; set source address & $01FE00

		move.w	#$9700,d0
		lsr.l	#8,d1
		andi.b	#$7F,d1		; ensures high bit isn't set
		move.b	d1,d0		; without this any value > $FFFFFF will cause VRAM corruption
		move.w	d0,(a1)+	; set source address & $FE0000

		andi.l	#$FFFF,d2
		lsl.l	#2,d2
		lsr.w	#2,d2
		swap	d2
	vdpComm	ori.l,$0000,VRAM,DMA,d2	; get DMA command
		move.l	d2,(a1)+	; write DMA mode to target address

		move.l	a1,VDP_Command_Buffer_Slot.w	; set next free slot
		cmpa.w	#VDP_Command_Buffer_Slot,a1
		beq.s	.rts		; if queue is full, branch
		clr.w	(a1)		; create stop token
.rts		rts
; ---------------------------------------------------------------------------

Process_DMA_Queue:
		lea	VDP_Command_Buffer.w,a1

.dmaloop	move.w	(a1)+,d0	; is this stop token?
		beq.s	.end		; if yes, end
		move.w	d0,(a5)
		move.l	(a1)+,(a5)
		move.l	(a1)+,(a5)
		move.l	(a1)+,(a5)
		cmpa.w	#VDP_Command_Buffer_Slot,a1
		bne.s	.dmaloop	; if not end yet, branch

.end		clr.w	VDP_Command_Buffer.w		; set stop token
		move.l	#VDP_Command_Buffer,VDP_Command_Buffer_Slot.w; reset offset
		rts
; ---------------------------------------------------------------------------
