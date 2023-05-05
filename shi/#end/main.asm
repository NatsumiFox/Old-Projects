Ending_NotLegit:
		move.l	#End_VInt4,VInt_Addr

		lea	Chunk_table,a1		; dest address
		lea	Ending_NotLegit_Map,a0	; src address
		jsr	KosDec			; decompress

		lea	VDP_control_port,a5
	dma68kToVDP EndPalette, 0, $80, CRAM
	dma68kToVDP EndGraphics, 0, EndGraphics_End-EndGraphics, VRAM
	dma68kToVDP Chunk_table, $C000, $800, VRAM

	; clear plane A and B
	vdpComm	move.l,$E000,VRAM,WRITE,(a5)
		move.l	#$00A400A4,d0
		move.w	#(($2000)/4)-1,d1

.loop		move.l	d0,-4(a5)
		dbf	d1,.loop

	; clear the sprite table
	vdpComm	move.l,$F800,VRAM,WRITE,(a5)
		move.l	#0,-4(a5)

	; write verti offset
	vdpComm	move.l,0,VSRAM,WRITE,(a5)
		move.w	#$10,-4(a5)

	; write horiz offset
	vdpComm	move.l,$F000,VRAM,WRITE,(a5)
		move.w	#0,-4(a5)

	; set horizontal scrolling to per longword
		move.l	#$8C009000,(a5)
		move.l	#$8B009100,(a5)	; disable window plane

.mainloop	stop	#$2300
		bra.s	.mainloop
; ---------------------------------------------------------------------------

Ending:
		_moveq	$E1,d0
		jsr	playsfx.w

		move.b	#1,PalCycle_Delay.w
.wait		move.b	#2,VInt_Routine.w
		jsr	wait_vsync.w

		addq.b	#1,PalCycle_Delay.w		; sub delay
		cmp.b	#17,PalCycle_Delay.w
		bne.s	.wait				; if over, branch

		move	#$2700,sr
		jsr	ClearDisplay

	; DMA the art shite
		move	#$2700,sr
		lea	VDP_control_port,a5
	dma68kToVDP EndGraphics, 0, EndGraphics_End-EndGraphics, VRAM

	; clear the sprite table
	vdpComm	move.l,$F800,VRAM,WRITE,(a5)
		move.l	#0,-4(a5)

	; set horizontal scrolling to per longword


	; write horiz offset
	;	move.w	#40,Horiz_scroll_buffer.w

	; load palette
		moveq	#($80/4)-1,d0
		lea	EndPalette,a0
		lea	Main_Palette.w,a1

.loadpal	move.l	(a0)+,(a1)+
		dbf	d0,.loadpal

	; clear plane A and B
	vdpComm	move.l,$C000,VRAM,WRITE,(a5)
		move.l	#$00A400A4,d0
		move.w	#(($4000)/4)-1,d1

.loop		move.l	d0,-4(a5)
		dbf	d1,.loop
		jsr	LoadSecondarySoundDriver; load sound driver and play music

	; decompress all of our maps
		move	#$2700,sr
		lea	EndMaps_Array,a6	; get the mapping ptr table to a6
		lea	Chunk_table,a1		; dest address

.loadloop	move.l	(a6)+,d0		; get next entry
		bmi.s	.done			; if negative, we are done here folks
		move.l	d0,a0			; move entry to a0 (poor 68k cant get condition codes from moves to address register)
		jsr	KosDec			; decompress
		bra.s	.loadloop		; next entry

.done		move.b	#2,VInt_Routine.w
		jsr	wait_vsync.w
		lea	VDP_control_port,a5
		move.l	#$8B008014,(a5)
		move.l	#$8AFF9100,(a5)
		move.w	#$8174,(a5)
		move.l	#End_VInt,VInt_Addr.w

		; preset some VDP commands
		move.l	#(($9400|((((80)>>1)&$FF00)>>8))<<16)|($9300|(((80)>>1)&$FF)),d7
		move.w	#$9700|((((($FF0000)>>1)&$FF0000)>>16)&$7F),d6

		; reset vars
		moveq	#0,d2			; y-scroll value
		moveq	#Chunk_table-$FFFF0000,d1; clear data offset
		lea	-4(a5),a6
		lea	End_Address_LUT(PC),a4	; get address LUT to a4
		lea	End_VarTbl(pc),a3	; get data table to a3
		lea	HInt_Jmp_Code.w,a2	; get data table to a3

.mainloop	; wait for V-Int
		stop	#$2300
		bra.s	.mainloop

; ---------------------------------------------------------------------------
End_Address_LUT:
		dc.w $F80
.n =	0
	rept 31
		dc.w .n*$80; each word entry is offset in VRAM in relation of $C000
.n =		.n+1	; advance .n to next entry.
	endr

	dc.w $8A00, $8A00|106, $4EF9
	dc.l End_HInt
End_VarTbl:
	dc.l $00834000, $96009500
; ---------------------------------------------------------------------------
; vertical interrupt handler

End_VInt2:
		move.l	#End_VInt,VInt_Addr
		bra.s	End_VInt3

End_VInt:
		move.l	#End_VInt2,VInt_Addr
		addq.w	#1,d2

		move.w	d2,d0		; get y-offset to d1
		and.w	#7,d0		; keep only few first bits
		bne.s	End_VInt3	; if not in edge of tile, branch

	; reset some VDP commands
		movem.w	4(a3),d3/d5	; get DMA len commands
		move.l	(a3),d4		; VRAM WRITE $CXXX

		move.w	d2,d0		; get y-offset to d1 again
		lsr.w	#2,d0		; div d1 by 4 (no shift by 8 because lut)
		and.w	#$3E,d0		; 32 vertical tiles in planemap
		or.w	(a4,d0.w),d4	; or the VRAM offset to VRAM activation long
		swap	d4		; swap the activation long

		move.w	d1,d0		; get data offset to d1
		add.w	#80/2,d1	; increment the offset
		move.b	d0,d5		; put the low byte of offset in command
		lsr.w	#8,d0		; get the high byte to low byte
		move.b	d0,d3		; put the high byte of offset in command

		move.w	d5,(a5)		; put low byte of address to VDP
		move.w	d3,(a5)		; put mid byte of address to VDP
		move.w	d6,(a5)		; put high byte of address to VDP
		move.l	d7,(a5)		; put length to VDP
		move.l	d4,(a5)		; put activation long to VDP, and DMA starts

End_VInt3:
	vdpComm	move.l,0,VSRAM,WRITE,(a5)
		move.w	d2,(a6)		; write VSCROLL value
		move.w	-8(a3),(a5)	; wait for 200 scanlines to Hint
		move.l	-4(a3),2(a2)
		move.w	-6(a3),(a2)	; put normal jmp address code in h-int

End_VInt4:
		rte

End_HInt2:
	vdpComm	move.l,0,VSRAM,WRITE,(a5)
		move.w	#0,(a6)		; write vscroll value
		sub.w	#1,8(a2)	; add 1 to it
		eor.b	#1,$E(a2)	;
		rte
End_HInt2_end:

End_HInt:
		lea	End_HInt2(pc),a0
		lea	(a2),a1
	rept (End_HInt2_end-End_HInt2)/4
		move.l	(a0)+,(a1)+	; writes all of the above code to h-int stuff
	endr

		move.w	d2,d0		; get vscroll value
		add.w	#256,d0		; add 100 to it
		move.w	d0,8(a2)	; set as initial vscroll value
		move.w	-$A(a3),(a5)	; HScroll per line
		rte			; end of int
; ---------------------------------------------------------------------------
