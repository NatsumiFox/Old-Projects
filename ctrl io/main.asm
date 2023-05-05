Maincode	section org(0)
	opt op+
	opt m+
	opt l+
	opt ae+
; ===========================================================================

vdpComm		macro ins,addr,type,rwd,end,end2
	if narg=5
		\ins #(((\type&\rwd)&3)<<30)|(((\addr)&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|(((\addr)&$C000)>>14), \end

	elseif narg=6
		\ins #(((((\type&\rwd)&3)<<30)|(((\addr)&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|(((\addr)&$C000)>>14))\end, \end2

	else
		\ins (((\type&\rwd)&3)<<30)|(((\addr)&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|(((\addr)&$C000)>>14)
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

; ===========================================================================
; tells the VDP to copy a region of 68k memory to VRAM or CRAM or VSRAM
dma68kToVDP macro source,dest,length,type
		move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a6)
		move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a6)
		move.w	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F),(a6)
	vdpComm	move.l,\dest,\type,DMA,(a6)
    endm

dma68kToVDP2 macro source,length,type
		move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a6)
		move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a6)
		move.w	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F),(a6)
    endm

; ===========================================================================
; tells the VDP to fill a region of VRAM with a certain byte
dmaFillVRAM macro byte,addr,length
	move.l	#$8F01|(($9400|((((length)-1)&$FF00)>>8))<<16),(a6) ; VRAM pointer increment: $0001
	move.l	#($9300|(((length)-1)&$FF))|$97800000,(a6) ; DMA length ...
	move.l	#$40000080|(((addr)&$3FFF)<<16)|(((addr)&$C000)>>14),(a6) ; Start at ...
	move.w	#byte,-4(a6) ; Fill with byte
.loop\@	move.w	(a6),d1
	btst	#1,d1
	bne.s	.loop\@	; busy loop until the VDP is finished filling...
	move.w	#$8F02,(a6) ; VRAM pointer increment: $0002
    endm

offtbl	macro offs
_offtbl = offset(\offs)
	endm

ote	macro offs
	rept narg
		dc.\0	\offs-_offtbl
	shift
	endr
	endm
; ===========================================================================
di	macro
	move	#$2700,sr
    endm

ei	macro
	move	#$2300,sr
    endm

halt	macro
	stop	#$2700
    endm
; ===========================================================================

CTRL_TH =	$40
CTRL_TL =	$20
CTRL_TR =	$10

STACK =		$FFFF1000
TEMP =		$FFFFFE00
CTRL_1 =	$FFFFFF00
CTRL_2 =	$FFFFFF10
CTRLDAT =	$FFFFFF40
MTAP_PIN =	$FFFFFFFE
MTAP_PIN_INIT =	$FFFFFFFC

; this instruction is basically 2 nops, except it affects cc too and is 2 bytes shorter
ctrl_delay	macro
	or.l	d0,d0
    endm
; ===========================================================================

; reads ASCII strings and passes them to character generator
asc		macro
ct =	0
	rept narg
lc =	0
	rept strlen(\1)
cc 	substr lc+1,lc+1,\1
arg =	'\cc'
		char arg
lc =	lc+1
ct =	ct+1
	endr
	shift
	endr
    endm

; translates ASCII character to proper hex value
char		macro c
	if c=' '
		dc.w 0
	elseif c<'0'
		dc.w (c-'!')+1
	elseif c<':'
		dc.w (c-'0')+$10
	elseif c<'A'
		dc.w (c-':')+$1A
	elseif c<='Z'
		dc.w (c-'A')+$21
	elseif c>='a'&c<='z'
		dc.w (c-'a')+$21
	else
		dc.w $44
	endif
    endm
; ===========================================================================

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
		dc.b "    2016/07/09"
		dc.b "CONTROLLER IO TEST PROGRAM                      "
		dc.b "CONTROLLER IO TEST PROGRAM                      "
		dc.b "NATSUMI       "
		dc.w 0
		dc.b 'J       '
		dc.b "        "
		dc.l 0
		dc.l EndOfRom-1
		dc.l $FF0000
		dc.l $FFFFFF
		dc.b 'RA', %11100000, %00100000
		dc.l $200000
		dc.l $3FFFFF
		dc.b '                                                    '
		dc.b 'JUE             '

; ===========================================================================
VDPregs:	dc.w $8004, $8174, $8230, $8338
		dc.w $8407, $8570, $8600, $8700
		dc.w $8800, $8900, $8A00, $8B00
		dc.w $8C71, $8D3F, $8E00, $8F02
		dc.w $9001, $9100, $9200, $93FF
		dc.w $94FF, $9500, $9600, $9780
; ===========================================================================
VBlank:
		movem.l	d0-a4,-(sp)
		jsr	InitCtrlRead_P2(pc)
		jsr	ReadCtrl_Pad3(pc)
		movem.l	(sp)+,d0-a4
HBlank:
		rte

InitCtrlRead_P1_MTap:
		bsr.s	InitCtrlRead_P1

InitCtrlRead_MCom:
		move.w	MTAP_PIN.w,d5	; TL or TR hi
		move.b	MTAP_PIN_INIT+1.w,6(a0)		; correctly init ctrl
		rts

InitCtrlRead_P1:
		lea	$A10003,a1
		lea	CTRL_1.w,a0		; endpoint ctrl
		moveq	#0,d2
		moveq	#CTRL_TH,d3		; TH hi
		rts

InitCtrlRead_P2_MTap:
		bsr.s	InitCtrlRead_P2
		bra.s	InitCtrlRead_MCom

InitCtrlRead_P2:
		lea	$A10005,a1
		lea	CTRL_2.w,a0		; endpoint ctrl
		moveq	#0,d2
		moveq	#CTRL_TH,d3		; TH hi
		rts

ReadCtrl_Pad3:
		move.b	d2,(a1)			; set TH low
	ctrl_delay				; delay
		move.b	(a1),d0			; Get controller port data (start/A)
		move.b	d3,(a1)			; set TH high
		andi.b	#CTRL_TL|CTRL_TR,d0
		lsl.b	#2,d0

		move.b	(a1),d1			; Get controller port data (B/C/Dpad)
		andi.b	#CTRL_TL|CTRL_TR|$F,d1
		or.b	d1,d0			; Fuse together into one controller bit array
		not.b	d0

		move.b	(a0),d1			; Get press button data
		eor.b	d0,d1			; Toggle off buttons that are being held
		move.b	d0,(a0)+		; Put raw controller input (for held buttons) in F604/F606
		and.b	d0,d1
		move.b	d1,(a0)+		; Put pressed controller input in F605/F607
		rts

ReadCtrl_Pad6:
		move.b	d3,(a1)			; set TH high
		moveq	#0,d0
		moveq	#0,d1

		move.b	(a1),d1			; Reading first 6 buttons
		move.b	d2,(a1)			; set TH low
		andi.b	#CTRL_TL|CTRL_TR|$F,d1

		move.b	(a1),d0			; Read second 2 buttons
		move.b	d3,(a1)			; set TH high
		andi.b	#CTRL_TL|CTRL_TR,d0
		move.b	d2,(a1)			; set TH low
		lsl.b	#2,d0
		move.b	d3,(a1)			; set TH high
		or.l	d0,d1			; Combine basic 8 buttons and store it to d1

		move.b	d2,(a1)			; set TH low
	ctrl_delay				; delay
		move.b	d3,(a1)			; set TH high
	ctrl_delay				; All this for unlock extra buttons (XYZM)

		move.b	(a1),d0			; Read extra buttons
		move.b	d3,(a1)			; set TH high
		andi.b	#$F,d0			; Mask it
		lsl.w	#8,d0			; Shift it by 8 bits
		or.w	d1,d0			; Combine it with basic buttons
		not.w	d0			; Invert basic buttons

		move.w	(a0),d1			; [GF64]
		eor.w	d0,d1			; [GF64]
		move.w	d0,(a0)+		; Save joystick state
		and.w	d0,d1			; [GF64]
		move.w	d1,(a0)+		; [GF64]
		rts

ReadCtrl_MultiTap:
.msetsw		macro
		move.b	d2,(a1)
		exg	d5,d2		; switch TR level
		nop
    endm

		lea	CTRLDAT.w,a2	; TEMP BUFFER
		move.b	d5,-16.w
		move.b	d2,-15.w
	; skip ident bytes
	rept 4
		.msetsw
	endr

	; get ctrl config
	rept 4
		move.b	(a1),(a2)+	; get the ctrl value
		.msetsw
	endr

		.msetsw

		moveq	#4-1,d3		; 4 ctrls to check
		lea	CTRLDAT.w,a2	; TEMP BUFFER

.ctrl		move.b	(a2)+,d0	; get type
		and.w	#$f,d0		; get only data bits
		beq.s	.ctrl3		; 3-button ctrl
		cmp.b	#1,d0		; 6-button check
		beq.s	.ctrl6		; if is 6-btn, branch

		clr.l	(a0)+
		dbf	d3,.ctrl	; check all ctrls

.lastctrl	move.b	MTAP_PIN_INIT+1.w,(a1); reset controller state
		rts

.ctrl6		bsr.s	.get3
	.msetsw
		move.b	(a1),d1		; get SABC
		andi.w	#$f,d1		;
		lsl.w	#8,d1		; to high byte
		or.w	d1,d0		; or back
		not.w	d0		; negate

		move.w	(a0),d1		; [GF64]
		eor.w	d0,d1		; [GF64]
		move.w	d0,(a0)+	; Save joystick state
		and.w	d0,d1		; [GF64]
		move.w	d1,(a0)+	; [GF64]
		dbf	d3,.ctrl	; check all ctrls
		bra.s	.lastctrl	; finish the job

.ctrl3		bsr.s	.get3
		not.b	d0

		clr.b	(a0)+		; clear high byte
		move.b	(a0),d1		; Get press button data
		eor.b	d0,d1		; Toggle off buttons that are being held
		move.b	d0,(a0)+	; Put raw controller input (for held buttons) in F604/F606
		and.b	d0,d1
		clr.b	(a0)+		; clear high byte
		move.b	d1,(a0)+	; Put pressed controller input in F605/F607
		dbf	d3,.ctrl	; check all ctrls
		bra.s	.lastctrl	; finish the job

.get3	.msetsw
		move.b	(a1),d0		; get UDLR
		andi.w	#$F,d0
	.msetsw
		move.b	(a1),d1		; get SABC
		lsl.b	#4,d1
		or.b	d1,d0
		rts
; ===========================================================================

EntryPoint:
	di
		move.w  #$100,$A11100.l
		lea	$C00004.l,a6
		lea	-4(a6),a5
		tst.w	(a6)

		lea	$A11100,a1
		move.b	-$10FF(a1),d0		; get hardware version	; 4
		andi.b	#$F,d0			; is this TMSS MD?
		beq.s	.skip			; if not, skip
		move.l	Console.w,$2F00(a1)	; do TMSS

.skip		lea	VDPregs(pc),a1
		moveq	#12-1,d0
.loop		move.l	(a1)+,(a6)		; move 2 register settings per move
		dbf	d0,.loop		; loop until 0

	; reset ctrl
		lea	$A10009,a1
		moveq	#CTRL_TH,d0
		move.b	d0,(a1)
		move.b	d0,2(a1)
		move.b	d0,4(a1)
		move.w	#CTRL_TR,MTAP_PIN.w	; TL by default
		move.w	#CTRL_TR|CTRL_TH,MTAP_PIN_INIT.w

	dmaFillVRAM 0,$10000,0			; fill VRAM with blank
.waitFillDone	move.w	(a6),d1
		btst	#1,d1
		bne.s	.waitFillDone		; wait until fill is done

	dma68kToVDP Font,$20,FontEnd-Font,VRAM
	vdpcomm	move.l,2,CRAM,WRITE,(a6)
		move.w	#$EEEE,(a5)

		jsr	TMP_UpdatePinType(pc)
.waittype	stop	#$2300			; wait for v-int
	di
		jsr	InitCtrlRead_P1_MTap.w
		jsr	ReadCtrl_MultiTap.w
		jsr	TMP_UpdateMulti(pc)

		move.b	CTRL_2+1.w,d6		; get ctrl pressed
		andi.w	#$70,d6			; get only ABC
		beq.s	.noswitch		; do not switch
		move.w	d6,MTAP_PIN.w		; set the pin

		btst	#6,d6
		bne.s	.r
		or.b	#CTRL_TH,d6		; always set TH too
		move.w	d6,MTAP_PIN_INIT.w

.r		jsr	TMP_UpdatePinType(pc)

.noswitch	jsr	TMP_GetTestType(pc)	; get the next test type
		bra.s	.waittype





; ===========================================================================
TMP_TL_HI:	asc 'NEXT POLLING TL'
TMP_TR_HI:	asc 'NEXT POLLING TR'
TMP_TH_HI:	asc 'NEXT POLLING TH'
TMP_UNK_HI:	asc 'NEXT POLLING ??'
TMP_UpdatePinType:
		cmp.b	#CTRL_TL,MTAP_PIN+1.w
		beq.s	.tl
		cmp.b	#CTRL_TR,MTAP_PIN+1.w
		beq.s	.tr
		cmp.b	#CTRL_TH,MTAP_PIN+1.w
		beq.s	.th

	dma68kToVDP TMP_UNK_HI,$C084,(15*2),VRAM
		rts

.th	dma68kToVDP TMP_TH_HI,$C084,(15*2),VRAM
		rts

.tl	dma68kToVDP TMP_TL_HI,$C084,(15*2),VRAM
		rts

.tr	dma68kToVDP TMP_TR_HI,$C084,(15*2),VRAM
		rts

; ===========================================================================
TMP_MPNA:	asc "P2AP2BP2CP2D"
TMP_MBNA:	asc "MXYZSABCRLDU"
TMP_MCTNA:	dc.b $13,$16
		dcb.b $10-2, $10

TMP_UpdateMulti:
		lea	CTRL_1.w,a0
		lea	CTRLDAT.w,a1
		lea	TMP_MPNA(pc),a3
	vdpComm	move.l,$C184,VRAM,DMA,d3
		moveq	#4-1,d2

.ctrl		lea	TEMP.w,a2
		move.l	(a3)+,(a2)+
		move.w	(a3)+,(a2)+
		clr.w	(a2)+

		move.b	(a1)+,d0
		andi.w	#$F,d0
		move.b	TMP_MCTNA(pc,d0.w),d0
		move.w	d0,(a2)+
		clr.w	(a2)+

		moveq	#2-1,d4
		bra.s	.c

.xyz		lea	TEMP.w,a2
		clr.l	(a2)+
		clr.l	(a2)+
		clr.l	(a2)+

.c		lea	TMP_MBNA(pc),a4
		moveq	#12-1,d1

.btn		cmp.b	#7,d1			; check if bit7
		bne.s	.notchange		; if not, do not change byte
		addq.w	#1,a0			; change byte

.notchange	btst	d1,(a0)			; check if button is pressed
		bne.s	.normal			; if is set, branch
		clr.w	(a2)+
		addq.w	#2,a4
		dbf	d1,.btn
		bra.s	.y

.normal		move.w	(a4)+,(a2)+
		dbf	d1,.btn

.y	dma68kToVDP2 TEMP,18*2,VRAM
		move.l	d3,(a6)
		add.l	#$00800000,d3
		addq.w	#1,a0			; change byte
		dbf	d4,.xyz
		dbf	d2,.ctrl
		rts

; ===========================================================================
Font:		incbin "font.unc"
FontEnd:	even
; ===========================================================================
EndOfRom:
	END
