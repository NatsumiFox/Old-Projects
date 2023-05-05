	org 0
	opt m+	; print better macro info

STACK =		$000000
	include "LANG.ASM"		; LANGUAGE MACROS
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
		move.w	#$100,BUSREQ
		move.w	#$100,BUSRES

		lea	GEMSZ80(pc),a0
		lea	Z80RAM,a1	; get z80 driver address
		move.w	#patchbank-GEMSZ80-1,d0

.load		move.b	(a0)+,(a1)+
		dbf	d0,.load	; load drv

		move.w	#$2000-(patchbank-GEMSZ80)-1,d0
		moveq	#0,d1
.clear		move.b	d1,(a1)+
		dbf	d0,.clear

		move.w	#0,BUSRES
	rept 4
		nop
	endr
		move.w	#$100,BUSRES
		move.w	#0,BUSREQ	; start the Z80

		move.w	#-1,d0
		dbf	d0,*	; delay

		pea	sampbank
		pea	seqbank(pc)
		pea	envbank(pc)
		pea	patchbank(pc)
		jsr	.gemsinit

		moveq	#4,d0		; mus ID
		move.l	d0,-(sp)	; ''
		jsr	.gemsstartsong
		add.w	#18,sp
		bra.s	*

HBlank:
VBlank:
		rte

	include "GEMS/68K.ASM"		; GEMS 68K PRG
;	endif
GEMSZ80:
	z80prog	0			; NEW Z80 PROGRAM
	include "GEMS/Z80.ASM"		; GEMS Z80 PRG
	z80prog				; END PRG


;	if 0=1
; various stuffs used by GEMS
		opt l+	; local lables are now dots
		include "GEMS/macro.asm"
	gSetup
patchbank:	include "GEMS/pbank.asm"
envbank:	include "GEMS/mbank.asm"
seqbank:	include "GEMS/sbank.asm"
sampbank:	include "GEMS/dbank.asm"
;	endif
EndOfRom:	END
