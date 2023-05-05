AchiDisplay =	CollisionList+2		; display info table

acit	macro text
	if strlen(\text)>38
		inform 2,"STR len was %d!", strlen(\text)
	endif

	acis \text
	dcb.b 38-strlen(\text), $0C+$81
    endm

acis	macro txt
ct =	0
	rept narg
lc =	0
	rept strlen(\txt)
cc 	substr lc+1,lc+1,\txt
arg =	'\cc'
		acic arg
lc =	lc+1
ct =	ct+1
	endr
	shift
	endr
    endm

acic	macro c
	if \c=' '
		dc.b $0C+$81
	elseif \c='['
		dc.b $0A+$81
	elseif \c=']'
		dc.b $0B+$81
	elseif \c=','
		dc.b $41+$81
	elseif \c='.'
		dc.b $42+$81
	elseif \c='-'
		dc.b $43+$81
	elseif \c='_'
		dc.b $44+$81
	elseif \c='='
		dc.b $45+$81
	elseif \c='"'
		dc.b $46+$81
	elseif \c='?'
		dc.b $47+$81
	elseif \c='!'
		dc.b $48+$81
	elseif \c="'"
		dc.b $49+$81
	elseif \c='*'
		dc.b $4A+$81

	elseif (\c>='0')&(\c<='9')
		dc.b \c-'0'+$81

	elseif (\c>='A')&(\c<='Z')
		dc.b \c-'A'+$D+$81

	elseif (\c>='a')&(\c<='z')
		dc.b \c-'a'+$27+$81
	endif
    endm
; ===========================================================================

ListAchi:
		jsr	TileOut(pc)		; tile out display
	di
		move.l	#$82008400|($2000>>13),(a6); set PLANEB to $2000
		move.l	#$8B008500|($1000>>9),(a6); set SPRITES to $1000 and HSCROLL mode
		move.w	#$8D00|($3000>>10),(a6)	; set HSCROLL to $1000
	vdpcomm	move.l,$1000,VRAM,WRITE,(a6)	; write to CRAM
		moveq	#0,d0

		lea	-4(a6),a5		; DATA PORT
		move.l	d0,(a5)			; clear sprite table
		move.l	d0,(a5)			; ''

	vdpcomm	move.l,$3000,VRAM,WRITE,(a6)	; write to CRAM
		move.l	d0,(a5)			; clear bg pos
;
	writeVRAM_ a6,Unc_AchiList,$1020,filesize("artunc/achi list.unc"),VRAM	; DMA borders
	writeVRAM_ a6,Unc_Achi2,$3020,filesize("artunc/achi.unc"),VRAM		; DMA font

	vdpcomm	move.l,$22,CRAM,WRITE,(a6)	; write to CRAM
		move.l	#$0CCC08CA,(a5)		; load palette
		move.l	#$04C606A0,(a5)
		move.l	#$06800680,(a5)
		move.l	#$06600640,(a5)
		move.l	#$06200400,(a5)
		move.l	#$02000000,(a5)
		move.l	#$08440C88,(a5)

	; write planeb
		move.l	#$20BF28BF,d0
		move.l	#$28BF20BF,d1
		moveq	#32/2-1,d2
	vdpcomm	move.l,$2000,VRAM,WRITE,(a6)	; write maps

@lnloop	rept 64/2
		move.l	d0,(a5)			; write tile1
	endr
	rept 64/2
		move.l	d1,(a5)			; write tile2
	endr
		dbf	d2,@lnloop		; loop fro all tiles

		jsr	AchiBuildDisplay(pc)	; build display table for use
		moveq	#29-1,d7		; do 29 lines
		moveq	#0,d6			; clear y-pos

@draw		bsr.w	AchiDrawLine		; draw this line
		addq.w	#8,d6			; next line
		dbf	d7,@draw		; draw all lines
	ei

		move.l	v_scrposy_dup.w,-(sp)	; push screen pos dupe
		moveq	#0,d7
		move.l	d7,v_scrposy_dup.w	; save new screen dup
		moveq	#0,d5			; clear x-pos
		jsr	TileIn(pc)		; tile in display

@nostart	move.b	#$18,(v_vbla_routine).w	; delay
		bsr.w	WaitForVBla

		btst	#0,v_jpadhold1.w	; check if up is pressed
		beq.s	@noup			; if not, branch
		tst.w	d7			; check if y-pos = 0
		beq.s	@noup			; if so, skip

		move.w	d7,d6			; copy pos
		lsr.w	#3,d6			; get tile offset
		subq.w	#6,d7			; update y-pos
		move.w	d7,v_scrposy_dup.w	; save new screen dup

		move.w	d7,d0			; copy to d0
		lsr.w	#3,d0			; get tile offset
		cmp.w	d0,d6			; check if tile changed
		beq.s	@noup			; if not, branch

		move.w	d7,d6			; copy d7 to d6
		subq.w	#8,d6			; render 1 tile above
		bsr.w	AchiDrawLine		; draw this line

@noup		btst	#1,v_jpadhold1.w	; check if up is pressed
		beq.s	@nodwn			; if not, branch
		move.w	d7,d6			; copy y-pos
		lsr.w	#3,d6			; divide by a tile
		cmp.w	AchiDisplay.w,d6	; check if we can move down
		bhi.s	@nodwn

		addq.w	#6,d7			; update y-pos
		move.w	d7,v_scrposy_dup.w	; save new screen dup

		move.w	d7,d0			; copy to d0
		lsr.w	#3,d0			; get tile offset
		cmp.w	d0,d6			; check if tile changed
		beq.s	@nodwn			; if not, branch

		move.w	d7,d6			; copy d7 to d6
		add.w	#28*8,d6		; advance to bottom of screen
		bsr.w	AchiDrawLine		; draw this line

@nodwn		move.w	d7,d0			; get y-pos
		lsr.w	#2,d0			; get 1/2
		add.w	d7,d0			; add y-pos back
		lsr.w	#1,d0			; get 1/2
		add.w	d7,d0			; add y-pos back
		lsr.w	#1,d0			; get 1/2
		move.w	d0,v_scrposy_dup+2.w	; save bg pos

	vdpcomm	move.l,$3002,VRAM,WRITE,(a6)	; hscroll
		addq.w	#1,d5			; increase x-pos
		move.w	d5,(a5)			; save x-pos

		tst.b	v_jpadpress1.w		; check if start is pressed
		bpl.s	@nostart		; if not, branch

		jsr	TileOut(pc)		; tile out display
		move.l	(sp)+,v_scrposy_dup.w	; pop screen pos dupe
		move.l	#$8B038200|($C000/$400),(a6); set PLANEA to $C000 and HSCROLL mode
		move.l	#$80148500+(vram_sprites>>9),(a6); set SPRITES to vram_sprites
		move.w	#$8400|($E000/$2000),(a6); set PlaneB to $E000
		move.w	#$8D00|(vram_hscroll>>10),hblreg.w; set HSCROLL to vram_hscroll

	; decompress the GHZ art
		lea	Nem_GHZ_1st,a1
		moveq	#0,d2
		jsr	QueueKosM

@wait		move.b	#$16,(v_vbla_routine).w
		jsr	ProcKos
		bsr.w	WaitForVBla
		jsr	ProcKosM

		tst.b	KosMmodNum.w		; check if we are loading
		bne.s	@wait			; if are, branch
		move.b	#$16,(v_vbla_routine).w
		bsr.w	WaitForVBla

	writeVRAM	v_spritetablebuffer,$280,vram_sprites; force sprite table update, clear cache
		jmp	TileIn(pc)		; tile in display
; ===========================================================================

AchiDrawLine:
		move.w	d6,d1			; get y-pos
		and.w	#$1F*8,d1		; get index on the plane
		lsl.w	#4,d1			; 64x vertical offset
		or.w	#$4000,d1		; VRAM WRITE
		swap	d1			; swap words
		clr.w	d1			; $0000 + VRAM WRITE
		move.l	d1,(a6)			; set VRAM WRITE mode

		moveq	#0,d0			; clear upper word for div
		move.w	d6,d0			; copy y-pos
		lsr.w	#3,d0			; get tile count
		divu	#6,d0			; divide by 6!!!

		swap	d0			; swap around
		move.w	d0,d1			; copy to d1
		swap	d0			; swap again!

		lea	AchiDisplay+2.w,a0	; get display list to a0
		move.b	(a0,d0.w),d0		; get the item to render

		move.w	d0,d2			; copy offset
		lsr.w	#3,d2			; get the bits offset
		add.w	#AchiBits,d2		; add the offset
		move.w	d2,a0			; copy to a0

		btst	d0,(a0)			; check if bit is set
		sne	d2			; if is, set

		add.w	d1,d1			; double offset
		add.w	d1,d1			; quadruple offset
		jmp	@drawindex(pc,d1.w)	; jump to draw index

@drawindex	bra.w	@topbar
		bra.w	@topebar
		bra.w	@titlebar
		bra.w	@infobar
		bra.w	@botebar
	;	bra.s	@botbar

@botbar		lea	@mapbot(pc),a1
		moveq	#40/2-1,d1		; set repeat count
		bra.s	@dobar

@botebar	lea	@mapboe(pc),a1
		moveq	#40/2-1,d1		; set repeat count
		bra.s	@dobar

@topbar		lea	@maptop(pc),a1
		moveq	#36/2-1,d1		; set repeat count
		tst.b	d2			; check if bit is set
		beq.s	@trb			; if not, branch

		move.l	#$20812082,(a5)		; write check mark
		move.l	#$20832084,(a5)		; ''
		bra.s	@dobar

@trb		move.l	#$20B120B2,(a5)		; write blank tiles
		move.l	#$20B320B4,(a5)		; ''

@dobar		move.l	(a1)+,(a5)		; write data
		dbf	d1,@dobar		; loop
		rts

@topebar	tst.b	d2			; check if bit is set
		beq.s	@terb			; if not, branch
		move.l	#$208B208C,(a5)		; write check mark
		move.l	#$208D208E,(a5)		; ''
		bra.s	@tect

@terb		move.l	#$20B520B6,(a5)		; write check mark
		move.l	#$20B720B8,(a5)		; ''

@tect		lea	@maptoe(pc),a1
		moveq	#36/2-1,d1		; set repeat count
		bra.s	@dobar

@titlebar	tst.b	d2			; check if bit is set
		beq.s	@ttrb			; if not, branch
		move.l	#$20982099,(a5)		; write check mark
		move.l	#$209A209B,(a5)		; ''
		bra.s	@notset

@ttrb		move.l	#$20B920BA,(a5)		; write check mark
		move.l	#$20BB20BC,(a5)		; ''

@notset		move.l	#$209C209C,d2		; blank tile
		move.w	d2,(a5)			; write a blank tile

		add.w	d0,d0			; double ID
		lea	AchiArr,a0		; get achi data
		add.w	d0,a0			; get to right offset
		add.w	(a0),a0			; add offset to get the actual data

		move.w	#$100,d0		; set tile offset
		moveq	#20-1,d1		; get repeat count

@wrstr		move.b	(a0)+,d0		; get num
		add.b	#$81,d0			; add offsi
		move.w	d0,(a5)			; save to VRAM
		dbf	d1,@wrstr		; loop

		moveq	#10/2-1,d0		; set repeat count
@blop		move.l	d2,(a5)			; write 12 blank tiles
		dbf	d0,@blop		; loop

		moveq	#0,d0
		move.w	d6,d0			; get y-pos
		divu	#6*8,d0			; divide by 6 tiles
		and.l	#$FFFF,d0		; clear high word
		divu	#10,d0			; divide id by 10 (get both 10's and 1's)
		add.l	#$1810181,d0		; align with 0
		swap	d0			; swap digits
		move.l	d0,(a5)			; write tiles

		move.w	d2,(a5)			; write a blank tile
		move.l	#$209D209E,(a5)		; write end bit
		rts

@infobar	move.w	#$209F,(a5)		; write a blank tile
		muls	#38,d0			; multiply offset by 38
		lea	@hinarr(pc,d0.w),a0	; get text data to a0

		moveq	#38-1,d1		; 38 letters
		move.w	#$100,d0
@let		move.b	(a0)+,d0		; copy letter to d0
		move.w	d0,(a5)			; write letter
		dbf	d1,@let			; loop for 38 letters

		move.w	#$20A0,(a5)		; end piece
		rts

@hinarr	acit "There are 8 coins hidden in act 1!"
	acit "There are 8 coins hidden in act 2!"
	acit "There are 8 coins hidden in act 3!"
	acit "There are 8 coins hidden in act 4!"
	acit "There are 5 hidden points in act 1!"
	acit "There are 5 hidden points in act 2!"
	acit "There are 5 hidden points in act 3!"
	acit "There are 5 hidden points in act 4!"
	acit "There is nothing that can stop you."
	acit "You spend too much time getting this."
	acit "Can we just agree that this is a bug?"
	acit "It fucking goes backwards!"
	acit "Gotta get that 24 second time..."
	acit "But really, you are just cheating."
	acit "So nearly got that time over."
	acit "This joke wasnt as funny as I imagined"
	acit "Too bad nobody on Nomad can get this."
	acit "This is a game, not a screen saver!"
	acit "Twilight approves this specific number"
	acit "This is so easy glitch to fix, too"
	acit "If you can figure this one out, woah"
	acit "Nobody actually does this."
	acit "Almost nobody actually does this."
	acit "What goes up, must come down!"
	acit "You should roll, not run into it!"
	acit "Sonic can secretly walk in air *_*"
	acit "Finished the most difficult level."
	acit "Wait, where did the badnik go???"
	acit "They see me rollin'"
	acit "Not as impressive as you'd hope"
	acit "Wouldn't it be hard to carry these?"
	acit "With this much, you could... Buy coke!"
	acit "Find 5 hidden points for epic secrets!"
	acit "You all know the game!"
	acit "Found gigantic ring that does nothing!"
	acit "Was it too obvious? I don't think so"
	acit "Avoided Eggman's balls successfully!"
	acit "I am 7 years old"
	acit "hi"
	acit "When life gives you lemons-"
	acit "Nigga you crazy fool!    Dude"
	acit 'dsinfdsogndsognsdognhsdognsdgosndgosd"'
	acit ""
	acit "Catch airtime while on the clock"

@maptop	incbin "misc/achi line0.map"
@maptoe	incbin "misc/achi line1.map"
@mapboe	incbin "misc/achi line4.map"
@mapbot	incbin "misc/achi line5.map"
; ===========================================================================

accc	macro ac
	rept narg
		dc.b (\ac)/8, \ac
	shift
	endr
    endm

AchiBuildDisplay:
		move.w	#CollisionList+2,CollisionList.w; reset list pos

		lea	AchiListData(pc),a1		; get the data set for displaying
		lea	AchiDisplay+2.w,a0		; get display data to a0
		lea	AchiBits.w,a2			; get achievement bits to a2
		moveq	#0,d0				; clear the counter
		moveq	#0,d2				; clear high byte

@loop		move.b	(a1)+,d1			; get next bytre
		bmi.s	@neg				; if negative, branch
		move.b	d1,(a0)+			; save next byte
		addq.w	#6,d0				; increase num
		bra.s	@loop

@neg		cmp.b	#$FF,d1				; check if end of list
		bne.s	@chk				; if not, branch
		sub.w	#28+1,d0			; account for bottom of screen
		move.w	d0,AchiDisplay.w		; save count too
		rts

@chk		and.w	#$7E,d1				; clear high bit & high byte
		move.b	@codes(pc,d1.w),d2		; get offset of the byte
		move.b	@codes+1(pc,d1.w),d1		; get ID
		btst	d1,(a2,d2.w)			; check if got
		beq.s	@loop				; if not, do not render

		move.b	d1,(a0)+			; save ID
		addq.w	#6,d0				; increase num
		bra.s	@loop

@codes	accc ac_feature, ac_69, ac_tas, ac_ssBoss, ac_Wrap, ac_Soft, ac_EasterEgg
	accc ac_HidPts, ac_HidPts+1, ac_HidPts+2, ac_HidPts+3

AchiListData:
	dc.b ac_Moved, ac_Jumped, ac_Roll, ac_WalkAir, ac_CamDown, ac_CamUp, ac_Hurt, ac_KillEnemy
	dc.b $80, ac_Oma, ac_Rings1, ac_Rings10, ac_Rings100, ac_Ristar, ac_BigRing, $82
	dc.b ac_RedCC, ac_RedCoins, ac_RedCoins+1, ac_RedCoins+2, ac_RedCoins+3, ac_Dead, ac_GameOver, ac_DoAct
	dc.b ac_LastMin, ac_sprun, $84, ac_AFK, ac_Boss, ac_SecAct, $86, ac_Airtime
	dc.b ac_Speed, ac_Invins, ac_dbinvin, $88, $8A, $8C, ac_life, ac_HidPt1
	dc.b $8E, $90, $92, $94
	dc.b $FF
	even

; ===========================================================================

TileOut:
		move.w	#$8174,hblreg.w			; enable display
		clr.b	v_hbla_line.w			; clear y-line
		move.b	#$18,(v_vbla_routine).w		; delay
		bsr.w	WaitForVBla

		moveq	#224/8-1,d0
		lea	vdp_control_port,a6		; get control port
		move.w	#$8014,(a6)			; enable hints

@loop		addq.b	#8,v_hbla_line.w		; increase y-pos
		move.b	#$06,(v_vbla_routine).w		; delay
		bsr.w	WaitForVBla
		dbf	d0,@loop			; loop for y

		move.l	#$80048134,(a6)			; disable hints
		st.b	v_hbla_line.w			; clear y-line
		rts
; ===========================================================================

TileIn:
		move.w	#$8174,hblreg.w			; enable display
		move.b	#224,v_hbla_line.w		; clear y-line
		moveq	#224/8-1,d0
		lea	vdp_control_port,a6		; get control port
		move.w	#$8014,(a6)			; enable hints

@loop		subq.b	#8,v_hbla_line.w		; increase y-pos
		move.b	#$06,(v_vbla_routine).w		; delay
		bsr.w	WaitForVBla
		dbf	d0,@loop			; loop for y

		move.l	#$80048174,(a6)			; disable hints, enable display
		st.b	v_hbla_line.w			; clear y-line
		rts
; ===========================================================================
