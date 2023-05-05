; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to display monitor contents on HUD
; ---------------------------------------------------------------------------

MonHud_Y1 =	$90
MonHud_XP1 =	$DC
MonHud_XP2 =	$154

DD_DrawMonitors:
		lea	MonContTable.w,a1			; get contents table
		lea	Player_1.w,a4				; get player addr
		move.l	ModeTable.w,a2				; Get mode table

		tst.b	MonContPos.w				; check which direction we are going
		bpl.s	.movedown				; if we are moving to normal pos, branch
		move.w	$16(a2),d0				; get high pos
		moveq	#-6,d1					; add -6 to offset

		cmp.w	MonContY.w,d0				; check if in place
		blt.s	.movepos				; if not, branch
		move.w	d0,MonContY.w				; set onscreen
		bra.s	.inplace

.movedown	move.w	$14(a2),d0				; get low pos
		moveq	#6,d1					; add 6 to offset

		cmp.w	MonContY.w,d0				; check if in place
		bgt.s	.movepos				; if not, branch
		move.w	d0,MonContY.w				; set offscreen
		bra.s	.inplace

.movepos	add.w	d1,MonContY.w				; offset y-pos
.inplace	lea	DD_DM_Tiles(pc),a2			; get tile array

		move.w	#MonHud_XP1,d1				; prepare x-pos
		moveq	#8-1,d2					; loop count
		move.w	MonContY.w,d0				; get y-pos

		tst.b	(a2)					; check if entry pos offset is 0
		beq.s	.c					; if so, branch
		subq.b	#1,(a2)					; sub 1 from offset

.c		bsr.s	.mon1loop				; do for p1
		lea	Player_2.w,a4				; get player addr
		move.w	#MonHud_XP2,d1				; prepare x-pos
		moveq	#8-1,d2					; loop count

.mon1loop	tst.b	(a1)					; check if this monitor exists
		bpl.s	.noskip					; if not, branch
.skipmon1	addq.w	#8,a1					; skip over the monitor
		dbf	d2,.mon1loop				; goto next monitor
		rts

.noskip		moveq	#0,d3
		move.b	(a1),d3					; get monitor type to d3
		add.w	d3,d3					; double
		move.w	(a2,d3.w),4(a6)				; set VRAM addr
		move.b	#$05,2(a6)				; 2x2 tiles

		addq.w	#2,a1					; skip over crap
		cmp.b	#$FE,(a1)				; check if moving up
		bne.s	.notup					; branch if not

		addq.w	#2,a1					; skip over stuffs
		subq.w	#2,(a1)					; sub 2 from y-pos
		move.w	(a1),d3					; load the y-pos again
		add.w	d0,d3					; add y-offset
		cmp.w	#$80-$10,d3				; check if above screen
		bgt.s	.notoffy				; if not, branch
		st	-4(a1)					; remove this object from list

.notoffy	move.w	(a1)+,d3				; copy y-pos
		add.w	d0,d3					; add y-pos offset
		move.w	d3,(a6)					; save to buffer
		move.w	(a1)+,6(a6)				; save x-pos
		bra.s	.nextmon1

.notup		tst.b	(a1)					; check if using a timer
		bpl.s	.notimer				; branch if not
		subq.b	#1,1(a1)				; sub 1 from timer
		bpl.s	.getxy					; if not over, branch

		bsr.s	.setgoup				; set this object as going up
		bra.s	.getxy

.notimer	moveq	#0,d3
		move.b	(a1),d3					; get RAM offs
		moveq	#0,d4
		move.b	1(a1),d4				; get bit
		bpl.s	.isabit					; branch if we do bit op

		cmp.b	#(5*60)/8,(a4,d3.w)			; check if only 5 seconds left
		bhi.s	.getxy					; if more, branch
		tst.b	(a4,d3.w)				; check if active
		beq.s	.deactivate				; if not, branch

		moveq	#2,d4					; flash slowly
		cmp.b	#80/8,(a4,d3.w)				; check if only 1 second left
		bhi.s	.gotcheck				; if more, branch
		moveq	#1,d4					; flash quickly

.gotcheck	btst	d4,(Level_frame_counter+1).w		; check for every 4th frame
		bne.s	.getxy					; if every other 4 frames, this object is displayed
		addq.w	#6,a1					; go to next obj
		dbf	d2,.mon1loop				; goto next monitor
		rts

.isabit		btst	d4,(a4,d3.w)				; check if active
		bne.s	.getxy					; if so, branch
.deactivate	bsr.s	.setgoup				; set this object as going up

.getxy		addq.w	#2,a1					; skip stuff
		move.w	(a1)+,d3				; copy y-pos
		add.w	d0,d3					; add y-pos offset
		move.w	d3,(a6)					; save to buffer

		moveq	#0,d3
		move.b	-5(a1),d3				; get queue pos
		lsl.w	#4,d3					; *$10

		cmp.w	#Player_1,a4				; check if doing for p1
		bne.s	.dop2					; if not, branch
		neg.w	d3					; negate offset
		add.w	d1,d3					; add x-pos

		cmp.w	(a1),d3					; check if properly aligned
		blt.s	.p1align				; if so, branch
		addq.w	#4,(a1)					; move along

.p1align	move.w	(a1)+,6(a6)				; save x-pos
		bra.s	.nextmon1

.dop2		add.w	d1,d3					; add x-pos
		cmp.w	(a1),d3					; check if properly aligned
		bgt.s	.p2align				; if so, branch
		subq.w	#4,(a1)					; move along
.p2align	move.w	(a1)+,6(a6)				; save x-pos

.nextmon1	addq.w	#8,a6					; go to next sprite
		subq.w	#1,d7					; sub 1 from num of tiles left
		dbmi	d2,.mon1loop				; goto next monitor
		rts

.setgoup	move.b	#$FE,(a1)				; set to moving up
		lea	MonContTable.w,a2			; get table
		move.b	-1(a1),d4				; get queue pos
		moveq	#8-1,d5					; loop count

		cmpa.w	#Player_1,a4				; check if doing for p1
		beq.s	.entryloop				; if so, branch
		adda.w	#$40,a2					; get p2 table

.entryloop	tst.b	(a2)					; check if this monitor exists
		bmi.s	.nextentry				; if not, branch
		cmp.b	1(a2),d4				; check if this is lower in queue
		bhs.s	.nextentry				; if is, branch
		subq.b	#1,1(a2)				; sub 1 from queue pos

.nextentry	addq.w	#8,a2					; skip over the monitor
		dbf	d5,.entryloop				; goto next monitor
		lea	DD_DM_Tiles(pc),a2			; get tile array

DDDM_Rts:
		rts

DD_DM_Tiles:	dc.w $84DC, $87D4, $84E0, $A4E4, $84E8
		dc.w $84F4, $84F0, $84F8, $84EC, $84FC
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to display directional information (the arrows/HUD/etc)
; ---------------------------------------------------------------------------

Render_BattleRace:
		bsr.s	DD_ArrowArt				; MJ: update arrow art
		bsr.w	DD_ArrowSprites				; MJ: write arrow sprites
		jmp	DD_DrawMonitors(pc)			; NAT: Draw monitor contents
						; continue to..	; MJ: change the backdrop colour

; ---------------------------------------------------------------------------
; Subroutine to control the backdrop palette (Temporary or debug, donno...)
; ---------------------------------------------------------------------------

;		tst.b	(Debug_mode_flag).w			; MJ: is debug mode enabled?
;		beq.s	DD_NoPalette				; MJ: if not, branch
;		moveq	#$00,d0					; MJ: clear d0
;	tst.b	(BoxValidAngle).w			; MJ5: is the box invalid?
;	bne.s	DO_Invalid				; MJ5: if so, branhc
;		move.b	(BoxWinner).w,d0			; MJ: load winner so far
;		add.w	d0,d0					; MJ: multiply by size of word

DO_Invalid:
;		move.w	DD_Cols(pc,d0.w),(Normal_palette+$40).w	; MJ: load correct colour to palette

DD_NoPalette:
;		rts						; MJ: return

DD_Cols:;	dc.w	$0000					; Black		- Draw
;		dc.w	$0E00					; Blue		- Player 1
;		dc.w	$008E					; Orange	- Player 2

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to update the arrow art
; ---------------------------------------------------------------------------
Art_Arrows2 =	Art_Arrows+$4B60

DD_ArrowArt:
		tst.b	(BoxValidAngle).w			; NAT: is the angle valid
		beq.w	.valid					; NAT: if is, branch
		subq.b	#1,BoxArr2Timer.w			; NAT: sub 1 from the timer
		bpl.w	DD_Return				; NAT: if not over, branch

		cmp.b	#$0E,BoxArr2TimerBack.w			; NAT: Check if timer is E.
		beq.s	.gotframe				; NAT: If so, branch
		move.b	BoxArr2TimerBack.w,BoxArr2Timer.w	; NAT: Copy timer

		tst.b	BosArr2Dir.w				; NAT: Check if moving forwards
		bpl.s	.forwards				; NAT: If so, branch
		sub.w	#$120,BoxArr2Frame.w			; NAT: Go to next frame
		bpl.s	.gotframe				; NAT: If valid frame, branch
		move.w	#$120*6,BoxArr2Frame.w			; NAT: reset the frame
		bra.s	.gotframe

.forwards	add.w	#$120,BoxArr2Frame.w			; NAT: Go to next frame
		cmp.w	#$120*6,BoxArr2Frame.w			; NAT: Check against the max frame
		ble.s	.gotframe				; NAT: If fine, branch
		clr.w	BoxArr2Frame.w				; NAT: Clear the frame

.gotframe	moveq	#0,d1					; derp
		move.w	BoxArr2Frame.w,d1			; NAT: Get offset
		addi.l	#Art_Arrows2,d1				; NAT: add starting art location
		move.w	#$DDC0,d2				; NAT: set VRAM address to dump to
		move.w	#($20*9)/2,d3				; NAT: set size to transfer
		movem.l	d6-d7/a3/a5-a6,-(sp)			; NAT: store register data
		jsr	Add_To_DMA_Queue.w			; NAT: save to DMA cue list for V-blank later
		movem.l	(sp)+,d6-d7/a3/a5-a6			; NAT: restore register data

		subq.b	#1,BoxArr2Count.w			; NAT: sub 1 from frame count
		bpl.w	DD_Return				; NAT: branch if we have more frames to do~
		move.l	BoxArr2Script.w,a1			; NAT: Get script

.cmdloop	move.b	(a1)+,d0				; NAT: Get data
		cmp.b	#$F0,d0					; NAT: Check if command
		blo.s	.normal					; NAT: If not a command, branch

		lea	DD_ArrowCMD(pc),a2			; NAT: get command data to a1
		add.b	d0,d0					; NAT: double
		add.b	d0,d0					; NAT: quad
		ext.w	d0					; NAT: extend to word
		move.l	(a2,d0.w),a2				; NAT: Get routine address
		jmp	(a2)					; NAT: Jump to the code

.normal		move.l	a1,BoxArr2Script.w			; NAT: Save script pos
		move.b	d0,d1					; NAT: copy to d1
		and.b	#$F,d1					; NAT: get low nibble
		move.b	d1,BoxArr2Count.w			; NAT: save the counter

		lsr.b	#4,d0					; NAT: Get the timer
		move.b	d0,BoxArr2TimerBack.w			; NAT: save timer

		cmp.b	#$0E,d0					; NAT: Check if timer is E.
		beq.s	.clear					; NAT: If so, branch
		move.b	d0,BoxArr2Timer.w			; NAT: save timer
		bra.s	DD_Return

.clear		clr.b	BoxArr2Timer.w				; NAT: Reset timer
		bra.s	DD_Return
; ---------------------------------------------------------------------------

.valid		moveq	#0,d1					; NAT: Clear high word for DMA
		move.w	(BoxAnglePos).w,d1			; MJ: load angle of "diplay position" box
		sub.w	(BoxAngle).w,d1				; MJ: minus angle of box
		asr.w	#$03,d1					; MJ: divide distance by 8
		sub.w	d1,(BoxAnglePos).w			; MJ: move the "display position" towards the destination
		move.b	(BoxAnglePos).w,d1			; MJ: load angle of box
		neg.b	d1					; MJ: convert correctly (because I was an idiot and imported the arrow art the wrong way)
		addi.b	#$40+$08,d1				; MJ: ''
		andi.w	#$00F0,d1				; MJ: keep within every 10 per frame
		cmp.b	(BoxAngleFrame).w,d1			; MJ: has the frame changed?
		beq.s	DD_Return				; MJ: if not, branch
		move.b	d1,(BoxAngleFrame).w			; MJ: update frame
		mulu.w	#($20*9)/$04,d1				; MJ: multiply by size of a single frame
		addi.l	#Art_Arrows+($120*3),d1			; MJ: add starting art location
		move.w	#$DDC0,d2				; MJ: set VRAM address to dump to
		move.w	#($20*9)/2,d3				; MJ: set size to transfer
		movem.l	d6-d7/a3/a5-a6,-(sp)			; MJ: store register data
		jsr	Add_To_DMA_Queue.w			; MJ: save to DMA cue list for V-blank later
		movem.l	(sp)+,d6-d7/a3/a5-a6			; MJ: restore register data

DD_Return:
		moveq	#$00,d0					; MJ: clear d0
		move.b	(BoxWinner).w,d0			; MJ: load winner so far
	tst.b	(BoxValidAngle).w			; MJ5: is the box invalid?
	beq.s	DO_NoInvalid				; MJ5: if not, branhc
	moveq	#$00,d0					; MJ5: set no player as winning

DO_NoInvalid:
		cmp.b	(BoxWinnerFrame).w,d0			; MJ: has the winner changed?
		beq.s	DD_NoWinner				; MJ: if not, branch
		move.b	d0,(BoxWinnerFrame).w			; MJ: update winner frame
		move.w	(BoxWinnerFrame).w,d0			; MJ: multiply by 100
		moveq	#0,d1					; NAT: Clear high word for DMA
		move.w	d0,d1					; MJ: copy to d1
		lsr.w	#$03,d1					; MJ: get x20
		add.w	d0,d1					; MJ: get x120
		addi.l	#Art_Arrows,d1				; MJ: add starting art location
		move.w	#$DDC0+($20*9),d2			; MJ: set VRAM address to dump to
		move.w	#($20*9)/2,d3				; MJ: set size to transfer
		movem.l	d6-d7/a3/a5-a6,-(sp)			; MJ: store register data
		jsr	Add_To_DMA_Queue.w			; MJ: save to DMA cue list for V-blank later
		movem.l	(sp)+,d6-d7/a3/a5-a6			; MJ: restore register data

DD_NoWinner:
		rts						; MJ: return
; ===========================================================================

.toframe;	moveq	#0,d0	; !!!
		move.b	(a1)+,d0				; NAT: Get frame
		mulu	#9*$20,d0				; NAT: Get frame offset
		move.w	d0,BoxArr2Frame.w			; NAT: Set frame off
		move.b	#$0E,BoxArr2TimerBack.w			; NAT: Do not advance frame
		move.b	#0,BoxArr2Timer.w			; NAT: Clear timer
		move.l	a1,BoxArr2Script.w			; NAT: Save script pos
		jmp	DD_Return(pc)				; NAT: Get next command/data
; ===========================================================================

.reverse;	st	BosArr2Dir.w				; NAT: reverse
		jmp	DD_ArrowArt.cmdloop(pc)			; NAT: Get next script data
; ===========================================================================

.unreverse;	clr.b	BosArr2Dir.w				; NAT: unreverse
		jmp	DD_ArrowArt.cmdloop(pc)			; NAT: Get next script data
; ===========================================================================

.revrnd		jsr	Random_Number				; NAT: Get random number
		cmp.b	(a1)+,d0				; NAT: Check x against the random num
		blo.w	DD_ArrowArt.cmdloop			; NAT: Branch if x is higher

		btst	#9,d0					; NAT: check if we invert?
		beq.s	.notrev					; NAT: if not, branch
.invrev		not.b	BosArr2Dir.w				; NAT: Check if we were reversed
		jmp	DD_ArrowArt.cmdloop(pc)			; NAT: Get next script data

.notrev		btst	#10,d0					; NAT: Check if bit 10 is set
		seq	BosArr2Dir.w				; NAT: Set accordingly
		jmp	DD_ArrowArt.cmdloop(pc)			; NAT: Get next script data
; ===========================================================================

.endrand	jsr	Random_Number				; NAT: Get random number
		cmp.b	(a1)+,d0				; NAT: Check x against the random num
		bhs.s	.end2					; NAT: Branch if x is higher
		jmp	DD_ArrowArt.cmdloop(pc)

.end		jsr	Random_Number				; NAT: Get random number
.end2		swap	d0					; NAT: Get random number
		and.w	#$F,d0					; NAT: And by number of scripts
		moveq	#0,d1					; NAT: Clear script position
		bra.s	.scriptloop				; NAT: Get next script data
; ===========================================================================

.restartrnd	jsr	Random_Number				; NAT: Get random number
		cmp.b	(a1)+,d0				; NAT: Check x against the random num
		blo.w	DD_ArrowArt.cmdloop			; NAT: Branch if x is higher
.restart	moveq	#0,d1					; NAT: Clear script position
; ===========================================================================

.scriptpos	moveq	#0,d0					; NAT:
		move.b	BoxArr2Script.w,d0			; NAT: get the script ID

.scriptloop	lea	DD_Arrow2Anim(pc),a1			; NAT: Normal arrow animation data
		add.w	d0,d0					; NAT: Double ID
		move.w	(a1,d0.w),d0				; NAT: get offset
		add.w	d0,a1					; NAT: Get the actual position
		add.w	d1,a1					; NAT: Add script offset to a1
		jmp	DD_ArrowArt.cmdloop(pc)
; ===========================================================================

.gotorandz	jsr	Random_Number				; NAT: Get random number
		cmp.b	(a1)+,d0				; NAT: Check x against the random num
		blo.s	.nextscript				; NAT: Branch if x is higher

.gotoz		moveq	#0,d1
		move.b	(a1)+,d1				; NAT: get data
		bra.s	.goto2
; ===========================================================================

.gotorand	jsr	Random_Number				; NAT: Get random number
		cmp.b	(a1)+,d0				; NAT: Check x against the random num
		blo.w	.nextscript				; NAT: Branch if x is higher

.goto		moveq	#0,d1					; NAT: Clear script position
.goto2		move.b	(a1)+,d0				; NAT: go to script
		jmp	.scriptloop(pc)				; NAT: Get next script data
; ===========================================================================

.gobackrand	jsr	Random_Number				; NAT: Get random number
		cmp.b	(a1)+,d0				; NAT: Check x against the random num
		blo.s	.nextscript				; NAT: Branch if x is higher

.goback		move.b	(a1)+,d0				; NAT: Get offset
		ext.w	d0					; NAT: Extend to word!
		add.w	d0,a1					; NAT: offset a1!
		jmp	DD_ArrowArt.cmdloop(pc)			; NAT: Get next command/data
; ===========================================================================

.framerand	jsr	Random_Number				; NAT: Get random number
		andi.b	#7,d0					; NAT: Keep in range!
		bra.s	.frcm
; ===========================================================================

.frame		move.b	(a1)+,d0				; NAT: Get frame
.frcm		moveq	#0,d1
		move.w	BoxArr2Frame.w,d1			; NAT: Get current frame
		divu	#9*$20,d1				; NAT: divide by $120

		tst.b	BosArr2Dir.w				; NAT: Check if going forwards
		bpl.s	.forwards				; NAT: If so, branch
		exg	d1,d0					; NAT: Do reverse calculation

.forwards	sub.b	d1,d0					; NAT: sub frame from d1
		bpl.s	.fine					; NAT: if positive, its all good
		moveq	#7,d1					; NAT: get max frame
		add.b	d0,d1					; NAT: Add offset
		move.b	d1,d0					; NAT: copy back

.fine		subq.b	#1,d0					; NAT: do this because of bpl
		bmi.s	.nextscript				; NAT: If negative (aka move 0), skip
		move.b	d0,BoxArr2Count.w			; NAT: Save
		move.b	(a1)+,d0				; NAT: Get speed
		move.b	d0,BoxArr2TimerBack.w			; NAT: Save
		move.b	d0,BoxArr2Timer.w			; NAT: Save
		move.l	a1,BoxArr2Script.w			; NAT: Save script pos
		jmp	DD_Return(pc)				; NAT: Get next command/data
; ===========================================================================

.nextscript	addq.w	#1,a1					; NAT: Skip a param
		jmp	DD_ArrowArt.cmdloop(pc)			; NAT: Get next command/data
; ===========================================================================

	dc.l .reverse		; F0 - Reverse
	dc.l .unreverse		; F1 - Unreverse
	dc.l .revrnd		; F2 - Choose reverse directions if random > x
	dc.l .invrev		; F3 - Invert reverse flag
	dc.l .framerand		; F4 - Go to random frame num with speed x
	dc.l .frame		; F5 - Go to frame num x with speed y
	dc.l .gobackrand	; F6 - Go back x bytes if random > y
	dc.l .goback		; F7 - Go back x bytes
	dc.l .gotorandz		; F8 - Go to script x position z if random > y
	dc.l .gotoz		; F9 - Go to script x position z
	dc.l .gotorand		; FA - Go to script x if random > y
	dc.l .goto		; FB - Go to script x
	dc.l .restartrnd	; FC - Reset to start if random > x
	dc.l .restart		; FD - Reset to start
	dc.l .endrand		; FE - Get new routine if random > x (End)
	dc.l .end		; FF - Get new routine (End)
DD_ArrowCMD:

DD_Arrow2Anim:
aaRev	= $F0
aaNorm	= $F1
aarRev	= $F2
aaInvRe	= $F3
aarFr	= $F4
aaFr	= $F5
aarGoBk	= $F6
aaGoBk	= $F7
aarGoToz = $F8
aaGoToz	= $F9
aarGoTo	= $FA
aaGoTo	= $FB
aarRest	= $FC
aaRest	= $FD
aarEnd	= $FE
aaEnd	= $FF
	dc.w .rovert-DD_Arrow2Anim	; $00
	dc.w .rodiag-DD_Arrow2Anim	; $01
	dc.w .stopngo-DD_Arrow2Anim	; $02
	dc.w .backforth-DD_Arrow2Anim	; $03
	dc.w .speedup-DD_Arrow2Anim	; $04
	dc.w .spdupjit-DD_Arrow2Anim	; $05
	dc.w .jittery-DD_Arrow2Anim	; $06
	dc.w .derp-DD_Arrow2Anim	; $07
	dc.w .rotc-DD_Arrow2Anim	; $08
	dc.w .rotcc-DD_Arrow2Anim	; $09
	dc.w .wait-DD_Arrow2Anim	; $0A
	dc.w .transp-DD_Arrow2Anim	; $0B
	dc.w	[$10] .temp-DD_Arrow2Anim

.temp	dc.b aaEnd

.speedup
	dc.b aaRev, $C0, $B0, $A0, $90, $80, $71, $61, $52, $43, $35, $28, $1B, $F, $1
	dc.b $1, $F, $1B, $28, $35, $43, $52, $61, $71, $80, $90, $A0, $B0, $C0
	dc.b aarEnd, $A0
	dc.b aaNorm, $C0, $B0, $A0, $90, $80, $71, $61, $52, $43, $35, $28, $1B, $F, $1
	dc.b $1, $F, $1B, $28, $35, $43, $52, $61, $71, $80, $90, $A0, $B0, $C0
	dc.b aaEnd

.backforth	dc.b aaRev, $36, aaNorm, $1D, aarEnd, $C0, aaRest
.spdupjit	dc.b aarRev, $00, $09, $13, $21, $30, $20, $60, aarEnd, $C0, aaGoBk, -$09
.jittery	dc.b aaFr, $04, $00, $EF, aarFr, $00, $EF, aarRev, $00, aarEnd, $90, aaRest
.stopngo	dc.b $1D, $1D, $EF, aarGoBk, $20, -$03, aarRev, $40, aarRest, $50, aaEnd
.derp		dc.b aaRev, $06, aaNorm, $06, aarEnd, $E0, aaRest
.rotc		dc.b aaRev, $16, aarEnd, $A0, aaRest
.rotcc		dc.b aaNorm, $16, aarEnd, $A0, aaRest
.rovert		dc.b aaFr, $00, $02, $EF, aarGoBk, $60, -$04, aaEnd
.rodiag		dc.b aaFr, $03, $02, $EF, aarGoBk, $60, -$04, aaEnd
.wait		dc.b $EF, aarEnd, $C0, aaRest
.transp
	rept 7
		rept 4
			dc.b aaInvRe, $16, aaInvRe, $16
		endm
		dc.b aaInvRe, $17, aaInvRe, $16, aarEnd, $80
	endm
	dc.b aaEnd
	even
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to display the arrow sprites
; ---------------------------------------------------------------------------
DDAS_MixDist	=	$0040
; ---------------------------------------------------------------------------

DD_ArrowSprites:
		lea	(SineTable+$01).w,a1			; MJ: load sinewave table address

	; --- The waving in/out ---

		moveq	#$00,d2					; MJ: clear d2
		subq.w	#$04,(BoxArrowDist).w			; NAT: move arrow inwards
		bpl.s	DDAS_NoMinDist				; NAT: if it hasn't reached centre, branch
		clr.w	(BoxArrowDist).w			; NAT: force to centre

DDAS_NoMinDist:
		tst.b	(Debug_On).w			; MJ: is debug mode enabled?
		beq.s	DDAS_NoDebug				; MJ: if not, branch
	addq.b	#$08,(BoxRotSprite).w			; MJ3: rotate and increase blink counter
	move.w	(Debug_PosX).w,d3
	sub.w	(Camera_X_pos).w,d3
	addi.w	#$0080-$0C,d3
	move.w	(Debug_PosY).w,d4
	sub.w	(Camera_Y_pos).w,d4
	addi.w	#$0080-$0C,d4
	bra.s	DDAS_Debug

DDAS_NoDebug:
		tst.b	(BoxValidAngle).w			; NAT: is the angle valid
		bne.s	DDAS_Centre				; NAT: if not, branch
		addq.w	#$08,(BoxArrowDist).w			; NAT: increase arrow outwards
		cmpi.w	#DDAS_MixDist,(BoxArrowDist).w		; NAT: has the arrow gone out to maximum position?
		blo.s	DDAS_NoMaxDist				; NAT: if not, branch
		move.w	#DDAS_MixDist,(BoxArrowDist).w		; NAT: force to maximum distance

DDAS_NoMaxDist:
		move.b	(BoxRotSprite).w,d2			; MJ: load sprite rotation counter
		addq.b	#$08,(BoxRotSprite).w			; MJ3: rotate and increase blink counter
		add.w	d2,d2					; MJ: multiply rotation by size of word
		move.w	-$01(a1,d2.w),d2			; MJ: load correct sine position
		asr.w	#$06,d2					; MJ: divide to precise amount
		addi.w	#($100>>$06),d2				; MJ: advance to starting position

DDAS_Centre:
		move.w	#((320/2)+$80)-$0C,d3			; MJ: advance to centre of screen
		move.w	#((224/2)+$80)-$0C,d4			; MJ: ''

DDAS_Debug:
		add.w	(BoxArrowDist).w,d2			; NAT: add arrow distance

	; --- The circular position itself ---

		moveq	#$00,d0					; MJ: clear d0
		move.b	(BoxAnglePos).w,d0			; MJ: load the angle
		subi.b	#$40,d0					; MJ: rotate/align
		add.w	d0,d0					; MJ: multiply by size of word
		move.w	-$01(a1,d0.w),d1			; MJ: load Y sine position
		move.w	+$7F(a1,d0.w),d0			; MJ: load X sine position
		movem.w	d0-d1,-(sp)				; MJ: store positions for later (no point in redoing them)
		muls.w	d2,d0					; MJ: multiply by waving distance
		muls.w	d2,d1					; MJ: ''
		asr.l	#$08,d0					; MJ: ''
		asr.l	#$08,d1					; MJ: ''
		add.w	d3,d0			; MJ: advance to centre of screen
		add.w	d4,d1			; MJ: ''

	; --- The sprite writing itself --

		tst.b	(End_Of_Level_Flag).w				; MJ6: is the level finished?
		bne.s	DDAS_NoArrows				; MJ6: if so, branch
		tst.b	(BoxValidAngle).w			; NAT: is the angle valid
		bne.s	.norm					; NAT: if not, branch
		tst.b	(BoxRotSprite).w			; MJ3: is the arrow meant to be invisible? (blinking frame)
		bmi.s	DDAS_Blink				; MJ3: if so, branch
.norm		move.w	d1,(a6)+				; MJ: set Y position
		move.b	#$0A,(a6)+				; MJ: set shape
		addq.w	#$01,a6					; MJ: skip over priority
		move.w	#$8000|($DDC0/$20),(a6)+		; MJ: set VRAM address
		move.w	d0,(a6)+				; MJ: set X position
		subq.w	#$01,d7					; MJ: minus sprite counter (for S3K's engine)

DDAS_Blink:
		move.w	d1,(a6)+				; MJ: set Y position
		move.b	#$0A,(a6)+				; MJ: set shape
		addq.w	#$01,a6					; MJ: skip over priority
		move.w	#$8000|(($DDC0+($20*9))/$20),(a6)+	; MJ: set VRAM address
		move.w	d0,(a6)+				; MJ: set X position
		subq.w	#$01,d7					; MJ: minus sprite counter (for S3K's engine)

		tst.b	(Debug_mode_flag).w			; MJ: is debug mode enabled?
		bne.s	DDAS_DebugArrows			; MJ: if so, branch

DDAS_NoArrows:
		addq.w	#$04,sp					; MJ: restore the stack correctly
		rts						; MJ: return

; ---------------------------------------------------------------------------
; Debug arrows
; ---------------------------------------------------------------------------

DDAS_List:	dc.w	(Player_1&$FFFF)			; 01 - Player 1
		dc.w	(Player_2&$FFFF)			; 02 - Player 2

DDAS_DebugArrows:
		moveq	#$00,d0					; MJ: clear d0
		move.b	(BoxWinner).w,d0			; MJ: load winner
		bne.s	DDAS_NoDraw				; MJ: if it's not a draw, branch
		move.w	(Player_1+x_pos).w,d2			; MJ: get X distance from player 1 and 2
		sub.w	(Player_2+x_Pos).w,d2			; MJ: ''
		asr.w	#$01,d2					; MJ: get centre X position between them
		add.w	(Player_2+x_Pos).w,d2			; MJ: ''
		move.w	(Player_1+y_pos).w,d3			; MJ: get Y distance from player 1 and 2
		sub.w	(Player_2+y_Pos).w,d3			; MJ: ''
		asr.w	#$01,d3					; MJ: get centre Y position between them
		add.w	(Player_2+y_Pos).w,d3			; MJ: ''
		bra.s	DDAS_GetRelative			; MJ: continue to relative calculation

DDAS_NoDraw:
		add.b	d0,d0					; MJ: multiply by word
		move.w	DDAS_List-$02(pc,d0.w),d0		; MJ: load correct player object
		movea.w	d0,a0					; MJ: load player object
		move.w	x_pos(a0),d2				; MJ: load X and Y position
		move.w	y_pos(a0),d3				; MJ: ''

DDAS_GetRelative:
		sub.w	(Camera_X_pos).w,d2			; MJ: minus camera positions (so it's relative to the screen)
		sub.w	(Camera_Y_pos).w,d3			; MJ: ''
		moveq	#$80-$0C,d0				; MJ: make it relative to the VDP sprite plane
		add.w	d0,d2					; MJ: ''
		add.w	d0,d3					; MJ: ''

	; --- Drawing the sprites in a line ---


		movem.w	(sp)+,d0-d1				; MJ: reload sinewave calculations
		asr.w	#$03,d0					; MJ: divide to x20
		asr.w	#$03,d1					; MJ: ''
		move.w	d0,d4					; MJ: set starting amounts
		move.w	d1,d5					; MJ: ''
		move.l	d6,-(sp)				; MJ: store d6 (sprite routine using it)
		moveq	#($08/2)-1,d6				; MJ: set number of sprites to draw in a line

DDAS_LineSprites:
		sub.w	d5,d2					; MJ: move X and Y positions
		add.w	d4,d3					; MJ: ''
		add.w	d0,d4					; MJ: increase movement amounts for next time
		add.w	d1,d5					; MJ: ''
	cmpi.w	#$0080+(224-$1C),d3			; is the arrow going to get in the way of the window?
	bhs.s	DDAS_NoCoverWindow1			; if so, branch
		move.w	d3,(a6)+				; MJ: set Y position
		move.b	#$0A,(a6)+				; MJ: set shape
		addq.w	#$01,a6					; MJ: skip over priority
		move.w	#$8000|($DDC0/$20),(a6)+		; MJ: set VRAM address
		move.w	d2,(a6)+				; MJ: set X position
		subq.w	#$01,d7					; MJ: minus sprite counter (for S3K's engine)

DDAS_NoCoverWindow1:
		add.w	d5,d2					; MJ: move X and Y positions (in reverse direction)
		sub.w	d4,d3					; MJ: ''
		add.w	d0,d4					; MJ: increase movement amounts for next time
		add.w	d1,d5					; MJ: ''

	cmpi.w	#$0080+(224-$1C),d3			; is the arrow going to get in the way of the window?
	bhs.s	DDAS_NoCoverWindow2			; if so, branch
		move.w	d3,(a6)+				; MJ: set Y position
		move.b	#$0A,(a6)+				; MJ: set shape
		addq.w	#$01,a6					; MJ: skip over priority
		move.w	#$8000|($DDC0/$20),(a6)+		; MJ: set VRAM address
		move.w	d2,(a6)+				; MJ: set X position
		subq.w	#$01,d7					; MJ: minus sprite counter (for S3K's engine)

DDAS_NoCoverWindow2:
		dbf	d6,DDAS_LineSprites			; MJ: repeat for all sprites to display
		move.l	(sp)+,d6				; MJ: restore d6
		rts						; MJ: return
