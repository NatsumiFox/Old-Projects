
; =============================================================
; Macro to check button presses
; Arguments:	1 - buttons to check
;		2 - bitfield to check
; -------------------------------------------------------------
tpress	macro
	move.b	(\2+1),d0
	andi.b	#\1,d0
	endm

; =============================================================
; Macro to check if buttons are held
; Arguments:	1 - buttons to check
;		2 - bitfield to check
; -------------------------------------------------------------
theld	macro
	move.b	\2,d0
	andi.b	#\1,d0
	endm

; =============================================================
; Macro to align data
; Arguments:	1 - align value
; -------------------------------------------------------------
align	macro
	cnop 0,\1
	endm
	

; =============================================================
; Macro to fuck up everything
; Arguments:	no fucking arguments
; -------------------------------------------------------------
fuck	macro
	bra.s	*
	endm

; =============================================================
; Macro to set VRAM write access
; Arguments:	1 - raw VRAM offset
;		2 - register to write access bitfield in (Optional)
; -------------------------------------------------------------
vram	macro
	if (narg=1)
		move.l	#($40000000+((\1&$3FFF)<<16)+((\1&$C000)>>14)),($C00004).l
	else
		move.l	#($40000000+((\1&$3FFF)<<16)+((\1&$C000)>>14)),\2
	endc
	endm
	

; =============================================================
; Macro to set CRAM write access
; Arguments:	1 - raw CRAM offset
;		2 - register to write access bitfield in (Optional)
; -------------------------------------------------------------
cram	macro	offset,operand
	if (narg=1)
		move.l	#($C0000000+(\1<<16)),VDP_Ctrl
	else
		move.l	#($C0000000+(\1<<16)),\operand
	endc
	endm

; =============================================================
; Macro to raise an error in vectors
; Arguments:	1 - error number
;		2 - branch location
;		3 - if exists, adds 2 to stack pointer
; -------------------------------------------------------------
raise	macro
	move.b	#\1,($FFFFFC44).w
	if narg=3
		addq.l	#2,2(sp)
	endc
	bra.s	\2
	endm

; =============================================================
; Macro to stop Z80
; -------------------------------------------------------------
stopZ80	macro
	move.w	#$100,($A11100).l
	nop
	nop
	nop

@wait\@:btst	#0,($A11100).l
	bne.s	@wait\@
	endm

; =============================================================
; Macro to reset Z80
; -------------------------------------------------------------
resetZ80	macro
	move.w	#$100,($A11200).l
	endm

; =============================================================
; Macro to start Z80
; -------------------------------------------------------------
startZ80	macro
	move.w	#0,($A11100).l
	endm 
	
; =============================================================
; Macro to wait for YM
; -------------------------------------------------------------

waitYM	macro
@wait\@:move.b	($A04000).l,d2
	btst	#7,d2
	bne.s	@wait\@
	endm


; =============================================================
; Macro to direct copy data into VRAM via DMA
; Arguments:	1 - Source Offset
;		2 - Transfer Length (in bytes)
;		3 - Destination
; -------------------------------------------------------------
writeVRAM	macro
	lea	($C00004).l,a5
	move.l	#$94000000+(((\2>>1)&$FF00)<<8)+$9300+((\2>>1)&$FF),(a5)
	move.l	#$96000000+(((\1>>1)&$FF00)<<8)+$9500+((\1>>1)&$FF),(a5)
	move.w	#$9700+((((\1>>1)&$FF0000)>>16)&$7F),(a5)
	move.w	#$4000+(\3&$3FFF),(a5)
	move.w	#$80+((\3&$C000)>>14),($FFFFF640).w
	move.w	($FFFFF640).w,(a5)
	endm

; =============================================================
; Macro to direct copy data into CRAM via DMA
; Arguments:	1 - Source Offset
;		2 - Transfer Length (in bytes)
;		3 - Destination
; -------------------------------------------------------------
writeCRAM	macro
	lea	($C00004).l,a5
	move.l	#$94000000+(((\2>>1)&$FF00)<<8)+$9300+((\2>>1)&$FF),(a5)
	move.l	#$96000000+(((\1>>1)&$FF00)<<8)+$9500+((\1>>1)&$FF),(a5)
	move.w	#$9700+((((\1>>1)&$FF0000)>>16)&$7F),(a5)
	move.w	#$C000+(\3&$3FFF),(a5)
	move.w	#$80+((\3&$C000)>>14),($FFFFF640).w
	move.w	($FFFFF640).w,(a5)
	endm

; =============================================================
; DMA fill VRAM with a value
; Arguments:	1 - Value
;		2 - Length
;		3 - Destination
; -------------------------------------------------------------

fillVRAM	macro value,length,loc
	lea	VDP_Ctrl,a5
	move.w	#$8F01,(a5)
	move.l	#$94000000+((\length&$FF00)<<8)+$9300+(\length&$FF),(a5)
	move.w	#$9780,(a5)
	move.l	#$40000080+((\loc&$3FFF)<<16)+((\loc&$C000)>>14),(a5)
	move.w	#value,VDP_Data
	
@wait\@:move.w	(a5),d1
	btst	#1,d1
	bne.s	@wait\@

	move.w	#$8F02,(a5)
	endm

; DMA Fill VRAM with zero value
; - Length, Dest
clrVRAM	macro
	move.w	#$8F01,(a6)
	move.l	#$94000000+((\1&$FF00)<<8)+$9300+(\1&$FF),(a6)
	move.w	#$9780,(a6)
	move.l	#$40000080+((\2&$3FFF)<<16)+((\2&$C000)>>14),(a6)
	move.w	#0,($C00000).l
wait\@	move.w	(a6),d1
	btst	#1,d1
	bne.s	wait\@
	move.w	#$8F02,(a6)
	endm

; VRAM write access constant
DCvram	macro
	dc.l	($40000000+(((\1)&$3FFF)<<16)+(((\1)&$C000)>>14))
	endm

