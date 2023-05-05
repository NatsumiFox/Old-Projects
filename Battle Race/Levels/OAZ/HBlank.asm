; ===========================================================================
; ---------------------------------------------------------------------------
; H-blank
; ---------------------------------------------------------------------------

	; --- Normal/blank/null ---

HB_OAZ_Null:
		rte						; return

	; --- Scanline alignement code (to sync up the delay) ---

HB_OAZ_Start:
		movem.l	d0/a0,-(sp)				; store registers
		move.l	usp,a0					; load V-scroll table
		move.w	(a0)+,d0				; load H-blank position
		subq.b	#$01,d0					; minus 1 (since the first scanline is done)
		bhi.s	HB_OAZ_More				; if there are still scanlines to perform, branch
		beq.s	HB_OAZ_Last				; if this is the last scanline, branch
		addq.w	#4+4,a0					; skip to next entry
		move.l	#$40000010,($C00004).l			; set VDP to VSRAM write mode
		move.l	2+4(a0),($C00000).l			; write V-scroll position
		move.l	a0,usp					; update V-scroll table
		movem.l	(sp)+,d0/a0				; restore registers
		rte						; return (do this routine again)

HB_OAZ_Last:
		addq.w	#4+4,a0					; skip H-blank address
		move.w	(a0)+,($C00004).l			; write H-blank position
		move.l	(a0)+,(H_int_addr).w			; set H-blank address
		move.l	a0,usp					; update V-scroll table
		movem.l	(sp)+,d0/a0				; restore registers
		rte						; return

HB_OAZ_More:
		lsr.b	#$01,d0					; divide by 2 for delay
		bcc.s	HB_OAZ_EvenScans			; if we can interrupt mid-way, branch
		bne.s	HB_OAZ_NoSingle				; if there's still more than 2 scanline, branch
		move.l	(a0)+,(H_int_addr).w			; set H-blank address
		move.l	a0,usp					; update V-scroll table
		movem.l	(sp)+,d0/a0				; restore registers
		rte						; return

HB_OAZ_NoSingle:
		move.w	d0,($FFFFA800+$100).w			; store H-blank interrupt for next trigger
		move.l	#HB_OAZ_OddScans,(H_int_addr).w		; set H-blank address to delay another line
		move.l	a0,usp					; update V-scroll table
		movem.l	(sp)+,d0/a0				; restore registers
		rte						; return

HB_OAZ_OddScans:
		movem.l	d0/a0,-(sp)				; store registers
		move.l	usp,a0					; load V-scroll table
		move.w	($FFFFA800+$100).w,d0			; reload H-blank interrupt line at halfway point

HB_OAZ_EvenScans:
		subq.b	#$01,d0					; minus 1 (1 = 2, 0 = 1, etc)
		move.w	d0,($C00004).l				; set interrupt line
		move.l	#HB_OAZ_Delay,(H_int_addr).w		; set to delay a scanline
		move.l	a0,usp					; update V-scroll table
		movem.l	(sp)+,d0/a0				; restore registers
		rte						; return

HB_OAZ_Delay:
		pea	(a0)					; store a0
		move.l	usp,a0					; load V-scroll table
		move.l	(a0)+,(H_int_addr).w			; set H-blank address
		move.l	a0,usp					; update V-scroll table
		move.l	(sp)+,a0				; restore a0
		rte						; return

	; --- For plane V-scroll repositioning ---

HB_OAZ_VScroll:
		pea	(a0)					; store a0
		move.l	usp,a0					; load V-scroll table
		move.l	#$40000010,($C00004).l			; set VDP to VSRAM write mode
		move.l	(a0)+,($C00000).l			; write V-scroll position
		move.w	(a0)+,($C00004).l			; set next H-blank interrupt position
		move.l	(a0)+,(H_int_addr).w			; set H-blank address
		move.l	a0,usp					; update V-scroll table
		move.l	(sp)+,a0				; restore a0
		rte						; return

HB_OAZ_VScrollLast:
		pea	(a0)					; store a0
		move.l	usp,a0					; load V-scroll table
		move.l	#$40000010,($C00004).l			; set VDP to VSRAM write mode
		move.l	(a0)+,($C00000).l			; write V-scroll position
		move.w	(a0)+,($C00004).l			; set next H-blank interrupt position
		move.l	(a0)+,(H_int_addr).w			; set H-blank address
		move.l	a0,usp					; update V-scroll table
		move.l	(sp)+,a0				; restore a0
		move.w	#$8F80,($C00004).l			; set VDP to automatically advance 80 (size of VSRAM)
		move.l	#$40020010,($C00004).l			; set VDP to VSRAM write mode (with BG slot address)
		rte						; return

	; --- For the floor ---

HB_OAZ_Floor:
	if ((HB_OAZ_Floor&$FF0000)>((HB_OAZ_Floor+$1000)&$FF0000))	; $1000 byte leeway...
		align	$10000
	endif

	; Buffer 1...

ScanCount = $49

Count := ScanCount*2
	rept	ScanCount-1
	.Start:
		move.w	($FFFFA800+($100-Count)).w,($C00000).l	; write V-scroll position
		addi.w	#.End-.Start,(H_int_addr+2).w		; advance to next H-blank address
		rte						; return
	.End:
Count := Count-2
	endm

HB_OAZ_Floor1:
		move.w	($FFFFA800+($100-Count)).w,($C00000).l	; write V-scroll position
		move.l	#$8AFF8F02,($C00004).l			; set no interrupt line
		move.l	#HB_OAZ_Null,(H_int_addr).w		; set null H-blank address
		rte						; return




	; Buffer 2...

Count := ScanCount*2
	rept	ScanCount-1
	.Start:
		move.w	($FFFFA900+($100-Count)).w,($C00000).l	; write V-scroll position
		addi.w	#.End-.Start,(H_int_addr+2).w		; advance to next H-blank address
		rte						; return
	.End:
Count := Count-2
	endm

HB_OAZ_Floor2:
		move.w	($FFFFA900+($100-Count)).w,($C00000).l	; write V-scroll position
		move.l	#$8AFF8F02,($C00004).l			; set no interrupt line
		move.l	#HB_OAZ_Null,(H_int_addr).w		; set null H-blank address
		rte						; return

; ===========================================================================