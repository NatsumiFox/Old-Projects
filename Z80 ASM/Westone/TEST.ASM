	org 0
	opt m+	; print better macro info
align	macro al
	cnop 0,\al
    endm
STACK =		$000000

;	if 0=1
    		dc.l STACK, EntryPoint, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap, ErrorTrap, ErrorTrap, ErrorTrap
		dc.l HBlank, ErrorTrap, VBlank, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
Console:	dc.b "SEGA     Natsumi"
ErrorTrap:	bra.s	ErrorTrap
		dc.b "    2017/05/03"
		dc.b "Z80 > ASM68K ASSEMBLY TEST PROGRAM              "
		dc.b "Z80 > ASM68K ASSEMBLY TEST PROGRAM              "
		dc.b "NATSUMI       "
		dc.w 0
		dc.b 'J       '
		dc.b "        "
		dc.l 0
		dc.l EndOfRom-1
		dc.l $FF0000
		dc.l $FFFFFF
		dc.b 'RO  '
		dc.l $200000
		dc.l $3FFFFF
		dc.b '                                                    '
		dc.b 'JUE             '

EntryPoint:
		bsr.s	@getdrv
		moveq	#-1,d0
		dbf	d0,*

		moveq	#$C,d0
		bsr.s	PlaySound
		bra.s	*

@getdrv		move.w	#$100,($A11100).l
		bsr.s	@resetZ80

@waitZ80stop:
		btst	#0,($A11100).l
		bne.s	@waitZ80stop
		movea.l	#unc_Z80Driver,a0
		move.b	7(a0),d0
		lsl.w	#8,d0
		move.b	6(a0),d0
		subq.w	#1,d0		; this piece of shit code really gets the size of the driver, byteswapped	from	the	Z80	ROM...
		lea	($A00000).l,a1

@loaddriver:
		move.b	(a0)+,(a1)+
		dbf	d0,@loaddriver
		bsr.s	@resetZ80
		move.w	#0,($A11100).l
		rts
@resetZ80:

		move.w	#0,($A11200).l
		movem.l	d0-a2,-(sp)
		movem.l	(sp)+,d0-a2
		move.w	#$100,($A11200).l
		rts

HBlank:
VBlank:
		rte

PlaySound:
		nop
		lea	($A00000).l,a0		; get Z80 address
@waitaccess:
		move.w	#$100,($A11100).l	; stop z80

@waitz80:
		btst	#0,($A11100).l		; wait for access
		bne.s	@waitz80		; ''
		tst.b	SndQueueAccess(a0)	; check if we have access to sound queue
		beq.s	@writesound		; if we do, branch
		move.w	#0,($A11100).l		; resume z80
		moveq	#$1F,d1			; delay timer

@delay:
		dbf	d1,@delay		; delay
		bra.s	@waitaccess
; ---------------------------------------------------------------------------
@writesound:
		move.b	SndQueuePos(a0),d1	; get position
		add.b	SndQueueCount(a0),d1	; add counter
		andi.w	#$F,d1			; keep in range
		addi.w	#SndQueue,d1		; add the sound queue address
		move.b	d0,(a0,d1.w)		; save sound there
		addq.b	#1,SndQueueCount(a0)	; add 1 to counter
		move.w	#0,($A11100).l		; start z80
		rts
;	endif

	include "LANG.ASM"
	include "MACROS.ASM"

unc_Z80Driver:
zbank:
	z80prog 0
	include "WESTONE.ASM"
	objend
	obj	$8000|(*&$7FFF)

mus:
	include "BANK.ASM"
	z80prog

EndOfRom:
	END
