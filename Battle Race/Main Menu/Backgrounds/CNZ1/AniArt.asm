; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Carnival Night 1
; ---------------------------------------------------------------------------

		move.w	(EMM_ScrollSpeed+$02).w,d1		; load scroll speed x2 backwards
		lsl.w	#$04-1,d1				; multiply to x10
		move.w	d1,d0					; store
		add.w	d0,d0					; multiply to x40
		add.w	d0,d0					; ''
		add.w	d0,d1					; add to get x50

		andi.l	#$00003F00,d1				; wrap
		add.w	d1,d1					; multiply to x400
		add.w	d1,d1					; ''
		addi.l	#ACCNZ01_BG,d1				; add the starting address to it
		swap	d2					; convert long-word VDP port alignment back to word...
		lsl.w	#$02,d2					; ...because the S3K DMA queue routine is a stupid and unoptimal...
		lsr.l	#$02,d2					; ...piece of shit...
		move.w	#($20*$20)/2,d3				; set size (6 tiles worth)
		jmp	Add_To_DMA_Queue.w			; save for transfer later

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

ACCNZ01_BG:	binclude "Main Menu\Backgrounds\CNZ1\Art Ani BG.bin"
		even

; ===========================================================================
