; ===========================================================================
; ---------------------------------------------------------------------------
; Animated Art - Hydrocity Zone 1
; ---------------------------------------------------------------------------

		sub.b	#$01,(a2)				; decrease delay timer
		bpl.s	ACHCZ01_Return				; if still running, branch
		move.w	$02(a2),d0				; load table position
		move.l	ACHCZ01_OrbPos(pc,d0.w),d1		; load data
		bpl.s	ACHCZ01_ContList			; if its not the end of the list, branch
		moveq	#$00,d0					; reset d0
		move.l	ACHCZ01_OrbPos(pc),d1			; load first entry

ACHCZ01_ContList:
		addq.w	#$04,d0					; increase entry table position
		move.l	d1,(a2)					; save next delay timer
		move.w	d0,$02(a2)				; update table position
		swap	d2					; convert long-word VDP port alignment back to word...
		lsl.w	#$02,d2					; ''
		lsr.l	#$02,d2					; ''
		addi.w	#$0200,d2				; increase VRAM address to the area where the animated tiles are
		move.w	#($20*6)/2,d3				; set size (6 tiles worth)
		jmp	Add_To_DMA_Queue.w			; save for transfer later

ACHCZ01_Return:
		rts						; return

; ---------------------------------------------------------------------------
; This is a copy of the list used for HCZ, but modified and optimised...
; see "AniPLC_HCZ1:" inside "sonic3k.asm" for details
; ---------------------------------------------------------------------------

		;	Delay timer | ROM location of art...

ACHCZ01_OrbPos:	dc.l	($04<<$18)|(($0000*$20)+ACHCZ01_Orbs)
		dc.l	($03<<$18)|(($0006*$20)+ACHCZ01_Orbs)
		dc.l	($02<<$18)|(($000C*$20)+ACHCZ01_Orbs)
		dc.l	($01<<$18)|(($0012*$20)+ACHCZ01_Orbs)
		dc.l	($00<<$18)|(($0018*$20)+ACHCZ01_Orbs)
		dc.l	($01<<$18)|(($001E*$20)+ACHCZ01_Orbs)
		dc.l	($02<<$18)|(($0024*$20)+ACHCZ01_Orbs)
		dc.l	($03<<$18)|(($002A*$20)+ACHCZ01_Orbs)
		dc.l	($04<<$18)|(($0030*$20)+ACHCZ01_Orbs)
		dc.l	($03<<$18)|(($002A*$20)+ACHCZ01_Orbs)
		dc.l	($02<<$18)|(($0024*$20)+ACHCZ01_Orbs)
		dc.l	($01<<$18)|(($001E*$20)+ACHCZ01_Orbs)
		dc.l	($00<<$18)|(($0018*$20)+ACHCZ01_Orbs)
		dc.l	($01<<$18)|(($0012*$20)+ACHCZ01_Orbs)
		dc.l	($02<<$18)|(($000C*$20)+ACHCZ01_Orbs)
		dc.l	($03<<$18)|(($0006*$20)+ACHCZ01_Orbs)
		dc.w	$FFFF	; end of list marker

; ---------------------------------------------------------------------------
; Include data
; ---------------------------------------------------------------------------

ACHCZ01_Orbs:	binclude "Main Menu\Backgrounds\HCZ1\Art Ani Orbs.bin"
		even

; ===========================================================================
