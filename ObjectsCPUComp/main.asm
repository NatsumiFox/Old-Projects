Maincode	section org(0)
	opt op+
	opt m+
	opt l.
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

maxcount =	$100
prev =		4
next =		6
obX =		8
size =		$10

TEST_ADDR =	$FFFF7FF8
TEST_NUM =	$FFFF7FFC
CTRL_1 =	$FFFF7FFE
Obj_Tail =	$FFFF8000
ObjPrev_Tail =	$FFFF8004
Free_Head =	$FFFF8006
Objects =	$FFFF8000+size
; ===========================================================================

		dc.l TEST_ADDR, EntryPoint, ErrorTrap, ErrorTrap
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
		dc.b "OBJECTS CPU TEST PROGRAM                        "
		dc.b "OBJECTS CPU TEST PROGRAM                        "
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
VDPregs:	dc.w $8004, $8174, $8230, $8320
		dc.w $8407, $8570, $8600, $8700
		dc.w $8800, $8900, $8A00, $8B00
		dc.w $8C71, $8D3F, $8E00, $8F02
		dc.w $9001, $9100, $9200, $93FF
		dc.w $94FF, $9500, $9600, $9780
; ===========================================================================
VBlank:
		movem.l	d0-a4,-(sp)
		jsr	ResetObjs(pc)
		bsr.s	ReadPad
		movem.l	(sp)+,d0-a4
HBlank:
		rte

ReadPad:
		lea	$A10003,a1
		lea	CTRL_1,a0		; endpoint ctrl
		moveq	#0,d2
		moveq	#$40,d3			; TH hi

		move.b	d2,(a1)			; set TH low
	or.l	d0,d0				; delay
		move.b	(a1),d0			; Get controller port data (start/A)
		move.b	d3,(a1)			; set TH high
		andi.b	#$30,d0
		lsl.b	#2,d0

		move.b	(a1),d1			; Get controller port data (B/C/Dpad)
		andi.b	#$3F,d1
		or.b	d1,d0			; Fuse together into one controller bit array
		not.b	d0

		move.b	(a0),d1			; Get press button data
		eor.b	d0,d1			; Toggle off buttons that are being held
		move.b	d0,(a0)+		; Put raw controller input (for held buttons) in F604/F606
		and.b	d0,d1
		move.b	d1,(a0)+		; Put pressed controller input in F605/F607
		rts
; ===========================================================================

ResetObjs:
		lea	Objects+size.w,a0
		move.w	#maxcount-1,d0
		move.l	#Obj_Next,d1

.olo1		move.l	d1,(a0)
		lea	size(a0),a0
		move.w	a0,-size+next(a0)
		move.w	a0,-size+prev(a0)
		dbf	d0,.olo1

		move.w	#maxcount-1,d0
		move.l	#Obj_Null,d1

.olo2		move.l	d1,(a0)
		lea	size(a0),a0
		dbf	d0,.olo2

		move.l	#Obj_Next,Objects.w
		move.w	#Objects,ObjPrev_Tail.w
		move.w	#Objects+size,Free_Head.w
		move.w	#Obj_Tail,Objects+next.w
		move.l	#.tail,Obj_Tail.w
.tail
Obj_Null:
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
		moveq	#$40,d0
		move.b	d0,(a1)
		move.b	d0,2(a1)
		move.b	d0,4(a1)

	dmaFillVRAM 0,$10000,0			; fill VRAM with blank
.waitFillDone	move.w	(a6),d1
		btst	#1,d1
		bne.s	.waitFillDone		; wait until fill is done

	dma68kToVDP Font,$20,FontEnd-Font,VRAM
	vdpcomm	move.l,0,CRAM,WRITE,(a6)
		move.l	#$2222EEEE,(a5)

		move.w	#$8F80,(a6)
	vdpcomm	move.l,$8000,VRAM,WRITE,(a6)
		moveq	#$40,d0

	rept 28
		move.w	d0,(a5)
	endr
		move.w	#$8F02,(a6)
		jsr	ResetObjs(pc)

		moveq	#0,d0			; clear buttons
		move.w	d0,TEST_NUM		; clear test
		bsr.s	UpdateTest		; update test

.main 		move.w	#$9100,$C00004
		stop	#$2300			; wait for v-int
		move.w	#$9101,$C00004

		move.b	CTRL_1,d0		; get controls to d0
		beq.s	.test			; if no ctrl, branch
		bsr.s	UpdateTest		; update test

.test		move.l	TEST_ADDR,a0		; get test address
		jsr	(a0)			; run it
		bra.s	.main

UpdateTest:
		bpl.s	.chkABC			; if positive, check ABC
		or.w	#4,TEST_NUM		; chage test to alt
		bra.s	.noB

.chkABC		move.b	d0,d1			; copy to d1
		and.w	#$70,d1			; check ABC
		beq.s	.noB			; if not, branch
		and.w	#$FFF8,TEST_NUM		; chage test to norm

.noB		btst	#0,d0			; chk up
		beq.s	.noup			; if no, bra
		and.w	#4,TEST_NUM		; clear extra bits

.noup		btst	#1,d0			; chk dw
		beq.s	.nodw			; if no, bra
		and.w	#4,TEST_NUM		; clear extra bits
		or.w	#8,TEST_NUM		; set test

.nodw		btst	#2,d0			; chk left
		beq.s	.nolf			; if no, bra
		and.w	#4,TEST_NUM		; clear extra bits
		or.w	#$10,TEST_NUM		; set test

.nolf		btst	#3,d0			; chk right
		beq.s	.nori			; if no, bra
		and.w	#4,TEST_NUM		; clear extra bits
		or.w	#$18,TEST_NUM		; set test

.nori		move.w	TEST_NUM,d0		; get test num
		move.l	.tests(pc,d0.w),TEST_ADDR; save test address
		rts

.tests	dc.l Test_Create_1, Test_Create_2, Test_Del_1, Test_Del_2
	dc.l Test_Run_1, Test_Run_2, Test_Run2_1, Test_Run2_2
; ===========================================================================

Obj_Next:
		move.w	next(a0),a0
		move.l	(a0),a1
		jmp	(a1)
; ===========================================================================

	; NOTE: With this new method we need to commit to creating a new object
count_1 = $30
Test_Create_1:
		move.l	#Obj_Null,d1
		move.w	#count_1-1,d7
.loop2		jsr	FindSlot1(pc)

		move.l	d1,(a1)
		dbf	d7,.loop2
		rts

FindSlot1:
		move.w	Free_Head.w,a1		; get next free obj addr
		cmp.w	#0,a1			; check if address is tail
		beq.s	@rts			; if is, then can not load
		move.w	prev(a1),Free_Head.w	; save next free slot back

		move.w	ObjPrev_Tail.w,a2	; get last object of ever
		move.w	a1,next(a2)		; set the next object to this
		move.w	a1,ObjPrev_Tail.w	; also set new tail
		move.w	#Obj_Tail,next(a1)	; set the next obj to run
		move.w	a2,prev(a1)		; set prev obj
@rts		rts
; ===========================================================================

Test_Create_2:
		move.l	#Obj_Null,d1
		move.w	#count_1-1,d7
.loop1		jsr	FindSlot2(pc)

		move.l	d1,(a1)
		dbf	d7,.loop1

FindSlot2:
		lea	Objects+(2*size).w,a1 ; start address for object RAM
		move.w	#count_1-1,d0

	FFree_Loop:
		tst.l	(a1)		; is object RAM	slot empty?
		beq.s	FFree_Found	; if yes, branch
		lea	size(a1),a1	; goto next object RAM slot
		dbf	d0,FFree_Loop	; repeat $5F times

	FFree_Found:
		rts
; ===========================================================================

count_2 = $80
Test_Del_1:
		lea	Objects+size.w,a0
		move.w	#count_2-1,d7
.loop2		jsr	DeletSlot1(pc)
		dbf	d7,.loop2
		rts

DeletSlot1:
		move.w	a0,a1			; copy a0 to a1
		addq.w	#prev,a1		; skip to prev ptr
		move.w	(a1)+,a2		; copy pointer to a2
		move.w	(a1),next(a2)		; copy next ptr over
		move.w	(a1)+,a2		; get next obj
		move.w	-4(a1),prev(a2)		; copy prev ptr

		move.w	Free_Head.w,-4(a1)	; get the head of the free list to next of this object
		move.w	a1,Free_Head.w		; save as the new head
		subq.w	#obX,Free_Head.w	; fix free head
		moveq	#0,d1

	rept (size-obX)/4
		move.l	d1,(a1)+		; clear single long
	endr

	if (size-obX)&2
		move.w	d1,(a1)
	endif
		rts
; ===========================================================================

Test_Del_2:
		lea	Objects+size.w,a0
		move.w	#count_2-1,d7
.loop2		jsr	DeletSlot2(pc)
		dbf	d7,.loop2
		rts

DeletSlot2:
		movea.l	a0,a1		; move object RAM address to (a1)
		moveq	#0,d1
		moveq	#$F,d0

	DelObj_Loop:
		move.l	d1,(a1)+	; clear	the object RAM
		dbf	d0,DelObj_Loop	; repeat for length of object RAM
		rts
; ===========================================================================

count_3 = $80
Test_Run2_1:
		move.w	#Obj_Tail,Objects+size+next.w

Test_Run_1:
		move.w	#Objects+size,a0
		move.l	(a0),a1
		jmp	(a1)
; ===========================================================================

Test_Run_2:
		lea	Objects+size.w,a0
		move.w	#count_3-1,d7
		move.l	#Obj_Null,d1

.loop2		move.l	(a0),d0
		beq.s	.next
		move.l	d1,a1
		jsr	(a1)

.next		lea	size(a0),a0	; next object
		dbf	d7,.loop2
		rts
; ===========================================================================

Test_Run2_2:
		lea	Objects+size.w,a0
		move.w	#count_3-1,d7
		move.l	#Obj_Null,d1

.loop2		move.l	(a0),d0
		bra.s	.next
		move.l	d1,a1
		jsr	(a1)

.next		lea	size(a0),a0	; next object
		dbf	d7,.loop2
		rts
; ===========================================================================
Font:		incbin "font.unc"
FontEnd:	even
; ===========================================================================
EndOfRom:
	END
