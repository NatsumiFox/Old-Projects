; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Angel Island Zone 2
; ---------------------------------------------------------------------------

		subq.b	#$01,(a2)				; decrease delay timer
		bpl.s	ACAIZ02_Return				; if still running, branch
		move.b	#$04-1,(a2)				; reset timer
		moveq	#$00,d1					; clear d1
		move.w	$02(a2),d1				; load art frame position
		move.w	d1,d0					; store a copy in d0
		addi.l	#ACAIZ02_Flames,d1			; add the starting address to it
		addi.w	#$0018*$20,d0				; advance to next frame of art
		cmpi.w	#($0018*$20)*$04,d0			; have we passed the last frame?
		blo.s	ACAIZ02_NoReset				; if not, branch
		moveq	#$00,d0					; reset position to first frame

ACAIZ02_NoReset:
		move.w	d0,$02(a2)				; update frame position
		swap	d2					; convert long-word VDP port alignment back to word...
		lsl.w	#$02,d2					; ...because the S3K DMA queue routine is a stupid and unoptimal...
		lsr.l	#$02,d2					; ...piece of shit...
		move.w	#($20*$18)/2,d3				; set size (6 tiles worth)
		jmp	Add_To_DMA_Queue.w			; save for transfer later

ACAIZ02_Return:
		rts						; return

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

ACAIZ02_Flames:	binclude "Main Menu\Backgrounds\AIZ2\Art Ani Flames.bin"
		even

; ===========================================================================
