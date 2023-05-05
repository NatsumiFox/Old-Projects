; ---------------------------------------------------------------------------
; Align and pad
; input: length to align to, value to use as padding (default is 0)
; ---------------------------------------------------------------------------

align:    macro
	if narg=1
		dcb.b    (*-1+(\1)-((*-1)%(\1)))-*,$FF
	else
		dcb.b    (*-1+(\1)-((*-1)%(\1)))-*,\2
	endc
    endm

; ---------------------------------------------------------------------------
; Set a VRAM address via the VDP control port.
; input: 16-bit VRAM address, control port (default is ($C00004).l)
; ---------------------------------------------------------------------------

locVRAM:	macro loc,controlport
		if (narg=1)
		move.l	#($40000000+((loc&$3FFF)<<16)+((loc&$C000)>>14)),(vdp_control_port).l
		else
		move.l	#($40000000+((loc&$3FFF)<<16)+((loc&$C000)>>14)),controlport
		endc
		endm

; ---------------------------------------------------------------------------
; assbuts
; ---------------------------------------------------------------------------
vdpComm		macro ins,addr,type,rwd,end,end2
	if narg=5
		\ins #(((\type&\rwd)&3)<<30)|((\addr&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|((\addr&$C000)>>14), \end

	elseif narg=6
		\ins #(((((\type&\rwd)&3)<<30)|((\addr&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|((\addr&$C000)>>14))\end, \end2

	else
		\ins (((\type&\rwd)&3)<<30)|((\addr&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|((\addr&$C000)>>14)
	endif
    endm

; ===========================================================================
; values for the type argument
VRAM =  %100001
CRAM =  %101011
VSRAM = %100101

; values for the rwd argument
READ =  %001100
WRITE = %000111
DMA =   %100111

; ---------------------------------------------------------------------------
; DMA copy data from 68K (ROM/RAM) to the VRAM
; input: source, length, destination
; ---------------------------------------------------------------------------

writeVRAM:	macro
		lea	(vdp_control_port).l,a5
		writeVRAM_ a5, \1, \3, \2, VRAM
		endm

writeVRAM_	macro an,source,dest,length,type
		move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(\an)
		move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(\an)
		move.w	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F),(\an)
	vdpComm	move.l,\dest,\type,DMA,(\an)
		endm

; ---------------------------------------------------------------------------
; DMA copy data from 68K (ROM/RAM) to the CRAM
; input: source, length, destination
; ---------------------------------------------------------------------------

writeCRAM:	macro
		lea	(vdp_control_port).l,a5
		move.l	#$94000000+(((\2>>1)&$FF00)<<8)+$9300+((\2>>1)&$FF),(a5)
		move.l	#$96000000+(((\1>>1)&$FF00)<<8)+$9500+((\1>>1)&$FF),(a5)
		move.w	#$9700+((((\1>>1)&$FF0000)>>16)&$7F),(a5)
		move.w	#$C000+(\3&$3FFF),(a5)
		move.w	#$80+((\3&$C000)>>14),(v_vdp_buffer2).w
		move.w	(v_vdp_buffer2).w,(a5)
		endm

; ---------------------------------------------------------------------------
; DMA fill VRAM with a value
; input: value, length, destination
; ---------------------------------------------------------------------------

fillVRAM:	macro value,length,loc
		lea	(vdp_control_port).l,a5
		move.w	#$8F01,(a5)
		move.l	#$94000000+((length&$FF00)<<8)+$9300+(length&$FF),(a5)
		move.w	#$9780,(a5)
		move.l	#$40000080+((loc&$3FFF)<<16)+((loc&$C000)>>14),(a5)
		move.w	#value,(vdp_data_port).l
		endm

; ---------------------------------------------------------------------------
; Copy a tilemap from 68K (ROM/RAM) to the VRAM without using DMA
; input: source, destination, width [cells], height [cells]
; ---------------------------------------------------------------------------

copyTilemap:	macro source,loc,width,height
		lea	(source).l,a1
		move.l	#$40000000+((loc&$3FFF)<<16)+((loc&$C000)>>14),d0
		moveq	#width,d1
		moveq	#height,d2
	if narg=4
		bsr.w	TilemapToVRAM
	else
		jsr	TilemapToVRAM
	endif
		endm

; ---------------------------------------------------------------------------
; reset the Z80
; ---------------------------------------------------------------------------

resetZ80:	macro
		move.w	#$100,(z80_reset).l
		endm

resetZ80a:	macro
		move.w	#0,(z80_reset).l
		endm

; ---------------------------------------------------------------------------
; disable interrupts
; ---------------------------------------------------------------------------

disable_ints:	macro
		move	#$2700,sr
		endm

; ---------------------------------------------------------------------------
; enable interrupts
; ---------------------------------------------------------------------------

enable_ints:	macro
		move	#$2300,sr
		endm

; ---------------------------------------------------------------------------
; long conditional jumps
; ---------------------------------------------------------------------------

jhi:		macro loc
		bls.s	@nojump
		jmp	loc
	@nojump:
		endm

jcc:		macro loc
		bcs.s	@nojump
		jmp	loc
	@nojump:
		endm

jhs:		macro loc
		jcc	loc
		endm

jls:		macro loc
		bhi.s	@nojump
		jmp	loc
	@nojump:
		endm

jcs:		macro loc
		bcc.s	@nojump
		jmp	loc
	@nojump:
		endm

jlo:		macro loc
		jcs	loc
		endm

jeq:		macro loc
		bne.s	@nojump
		jmp	loc
	@nojump:
		endm

jne:		macro loc
		beq.s	@nojump
		jmp	loc
	@nojump:
		endm

jgt:		macro loc
		ble.s	@nojump
		jmp	loc
	@nojump:
		endm

jge:		macro loc
		blt.s	@nojump
		jmp	loc
	@nojump:
		endm

jle:		macro loc
		bgt.s	@nojump
		jmp	loc
	@nojump:
		endm

jlt:		macro loc
		bge.s	@nojump
		jmp	loc
	@nojump:
		endm

jpl:		macro loc
		bmi.s	@nojump
		jmp	loc
	@nojump:
		endm

jmi:		macro loc
		bpl.s	@nojump
		jmp	loc
	@nojump:
		endm

; ---------------------------------------------------------------------------
; check if object moves out of range
; input: location to jump to if out of range, x-axis pos (obX(a0) by default)
; ---------------------------------------------------------------------------

out_of_range:	macro exit,pos
		if (narg=2)
		move.w	pos,d0		; get object position (if specified as not obX)
		else
		move.w	obX(a0),d0	; get object position
		endc
		andi.w	#$FF80,d0	; round down to nearest $80
		move.w	(v_screenposx).w,d1 ; get screen position
		subi.w	#128,d1
		andi.w	#$FF80,d1
		sub.w	d1,d0		; approx distance between object and screen
		cmpi.w	#128+320+192,d0
		bhi.\0	exit
		endm

; ---------------------------------------------------------------------------
; play a sound effect or music
; input: track, terminate routine, branch or jump, move operand size
; ---------------------------------------------------------------------------

music:		macro track,terminate,branch,byte
	move.b	#track,mQueue.w
	if terminate=1
		rts
	endc
		endm

sfx:		macro track,terminate,branch,byte
	move.b	#track,mQueue+1.w
	if terminate=1
		rts
	endc
		endm

; ---------------------------------------------------------------------------
; bankswitch between SRAM and ROM
; (remember to enable SRAM in the header first!)
; ---------------------------------------------------------------------------

gotoSRAM:	macro
		move.b  #1,($A130F1).l
		endm

gotoROM:	macro
		move.b  #0,($A130F1).l
		endm

; ---------------------------------------------------------------------------
; compare the size of an index with ZoneCount constant
; (should be used immediately after the index)
; input: index address, element size
; ---------------------------------------------------------------------------

zonewarning:	macro loc,elementsize
	@end:
		if (@end-loc)-(ZoneCount*elementsize)<>0
		inform 1,"Size of \loc ($%h) does not match ZoneCount ($\#ZoneCount).",(@end-loc)/elementsize
		endc
		endm

zonewarningnoending:	macro loc,elementsize
	@end:
		if (@end-loc)-((ZoneCount-1)*elementsize)<>0
		inform 1,"Size of \loc ($%h) does not match ZoneCount (minus ending) ($\#ZoneCount-1).",(@end-loc)/elementsize
		endc
		endm
; ---------------------------------------------------------------------------
; Macro to continue object chain to next object
; ---------------------------------------------------------------------------

NEXT_OBJ	macro
	movea.w	next(a0),a0
	move.l	(a0),a1
	jmp	(a1)
    endm

NEXT_OBJ_	macro
	movea.w	next(a0),a0
	move.l	(a0),a1
	jmp	(a1)
    endm

NEXT_OBJ2	macro
	movea.w	next(a2),a0
	move.l	(a0),a1
	jmp	(a1)
    endm

; ---------------------------------------------------------------------------
; Set priority of object, or dc.w it, or lea it
; ---------------------------------------------------------------------------

leaprio	macro layer, areg
	if narg=1
		lea	v_spritequeue+(\layer*vs_size).w,a1
	else
		lea	v_spritequeue+(\layer*vs_size).w,\areg
	endif
    endm

dcprio	macro layer
	dc.\0	v_spritequeue+(\layer*vs_size)
    endm

; ---------------------------------------------------------------------------
; Add object to display list
; ---------------------------------------------------------------------------

displayck	macro layer, reg
	tst.w	dnext(\reg)				; check if displayed already
	bne.s	@no\@					; if yes, skip
	display	\layer, \reg				; display
@no\@
    endm

display		macro layer, reg
	local src,dst
	if "\reg"="a0"
src EQUR	a0
dst EQUR	a1
	else
src EQUR	a1
dst EQUR	a2
	endif

	move.w	#v_spritequeue+(\layer*vs_size),dnext(src)	; put end marker as the next pointer
	move.w	v_spritequeue+vs_dprev+(\layer*vs_size).w,dst	; copy the pointer from the end marker to dst register
	move.w	dst,dprev(src)					; copy that to prev pointer
	move.w	src,dnext(dst)					;
	move.w	src,v_spritequeue+vs_dprev+(\layer*vs_size).w	; copy the pointer from the end marker to dst register

;	cmp.w	#v_spritequeue+(\layer*vs_size),v_spritequeue+vs_dprev+(\layer*vs_size).w; special case: points to itself
;	bne.s	@nosc\@						; if no, skip
;	move.w	src,v_spritequeue+vs_dprev+(\layer*vs_size).w	; else, copy over

@nosc\@
    endm

displaydxck	macro reg, lr
	tst.w	dnext(\reg)				; check if displayed already
	bne.s	@no\@					; if yes, skip
	displaydx \reg, \lr				; display
@no\@
    endm

displaydx	macro reg, lr
	local src,dst,layer
layer EQUR \lr

	if "\reg"="a0"
src EQUR	a0
dst EQUR	a1
	else
src EQUR	a1
dst EQUR	a2
	endif

	move.w	layer,dnext(src)			; put end marker as the next pointer
	move.w	vs_dprev(layer),dst			; copy the pointer from the end marker to dst register
	move.w	dst,dprev(src)				; copy that to prev pointer
	move.w	src,dnext(dst)				;
	move.w	src,vs_dprev(layer)			; copy the pointer from the end marker to dst register

;	cmp.w	vs_dprev(layer),layer			; special case: points to itself
;	bne.s	@n0sc\@					; if no, skip
;	move.w	src,vs_dprev(layer)			; else, copy over

@n0sc\@
    endm
; ---------------------------------------------------------------------------
; remove object from display list
; ---------------------------------------------------------------------------

undisplayck	macro reg
	tst.w	dnext(\reg)				; check if displayed already
	beq.s	@no\@					; if not, skip
	undisplay \reg					; display
@no\@
    endm

undisplay	macro reg
	local src,dst
	if "\reg"="a0"
src EQUR	a0
dst EQUR	a1
	else
src EQUR	a1
dst EQUR	a2
	endif

	move.w	dprev(src),dst				; load the prev pointer to dst
	move.w	dnext(src),dnext(dst)			; copy the next object pointer from src to dst
	move.w	dnext(src),dst				; load the next pointer to dst
	move.w	dprev(src),dprev(dst)			; copy the prev object pointer from src to dst

;	cmp.w	dst,dprev(src)				; special case: last object
;	bne.s	@nos\@					; if no, skip
;	move.w	dst,					; else, change to point to same address

@nos\@
	clr.l	dnext(src)				; clear both pointers

    endm
; ---------------------------------------------------------------------------
; change objects display list
; ---------------------------------------------------------------------------

chdisplay	macro layer, reg
	undisplay	\reg
	display		\layer, \reg
    endm
; ---------------------------------------------------------------------------
; do an archievement code check
; ---------------------------------------------------------------------------

ac	macro id, areg
	bset	#\id&7,AchiBits+(\id/8).w; check if bit set, and set it anyway
	bne.s	@done\@			; if is, branch
	lea	Achievements.w,\areg	; get array to areg

	tst.b	(\areg)+		; check if set
	beq.s	@set\@			; if not, branch
	tst.b	(\areg)+		; check if set
	beq.s	@set\@			; if not, branch
	tst.b	(\areg)+		; check if set
	beq.s	@set\@			; if not, branch
	tst.b	(\areg)+		; check if set
	beq.s	@set\@			; if not, branch
	bclr	#\id&7,AchiBits+(\id/8).w; clear bit because we cant display =(
	bra.s	@done\@

@set\@	move.b	#\id+1,-1(\areg)	; set register
@done\@
    endm

ac2	macro id, areg
	move.b	d0,d1			; copy off
	add.b	#\id&7,d1		; add id
	bset	d1,AchiBits+(\id/8).w	; check if bit set, and set it anyway
	bne.s	@done\@			; if is, branch
	lea	Achievements.w,\areg	; get array to areg

	tst.b	(\areg)+		; check if set
	beq.s	@set\@			; if not, branch
	tst.b	(\areg)+		; check if set
	beq.s	@set\@			; if not, branch
	tst.b	(\areg)+		; check if set
	beq.s	@set\@			; if not, branch
	tst.b	(\areg)+		; check if set
	bne.s	@done\@			; if is, branch

@set\@	add.b	#\id+1,d0		; increase by id
	move.b	d0,-1(\areg)		; set register
@done\@
    endm
