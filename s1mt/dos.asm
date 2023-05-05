DOS:
		moveq	#$FFFFFFE4,d0
		jsr	PlayMusic

		jsr	ClearScreen		; clear the screen

		lea	VDP_control_port,a6
		move.w	#$8004,(a6)		; Disable HInt, HV Counter
		move.w	#$8230,(a6)		; Nametable A at $C000
		move.w	#$8407,(a6)		; Nametable B at $E000
		move.w	#$9001,(a6)		; 64x32 cell nametable area
		move.w	#$9200,(a6)		; Window V position at default
		move.w	#$8B00,(a6)		; Vscroll full, HScroll full
		move.w	#$8700,(a6)		; BG color is Pal 0 Color 0

		move.w	$FFFFF60C.w,d0
		ori.b	#$40,d0
		move.w	d0,(a6)			; Turn the display on

		move	#$2700,sr		; disable ints

		moveq	#0,d1
		moveq	#0,d2
		moveq	#0,d3
		moveq	#0,d4
		movem.l	d1-d4,$FFFFFFF0.w
		movem.l	$FFFFFFF0.w,d5-d7
		movem.l	$FFFFFFF0.w,a0-a3
		movem.l	$FFFFFFF0.w,a4-a6

		lea	$FF0000,a7
		move.w	#$392-1,d0		; this clears the first $FFF0 bytes of RAM

.clr		movem.l	d1-a6,(a7)		; clear $38 bytes at once
		lea	$38(a7),a7
		dbf	d0,.clr

		move.l	#DOS_Stack,sp		; set new stack pointer

		; load art
		lea	VDP_Data_Port,a6
		move.l	#$40200000,4(a6)
                lea	Art_Text,a5
		move.w	#$290/2,d1

.LoadText	move.l	(a5)+,(a6)
		dbf	d1,.loadText		; load uncompressed text patterns

                lea	DOS_ExtraTiles,a5	; custom tiles
		move.w	#((DOS_ExtraTiles_end-DOS_ExtraTiles)/4)-1,d1

.LoadText2	move.l	(a5)+,(a6)
		dbf	d1,.loadText2		; load uncompressed text patterns

		moveq	#6-1,d7			; amount of repeats
.loop		moveq	#38-1,d6		; frames of delay
.loop2		move.b	#2,VBlank_Routine.w
		bsr.w	DelayProgram		; wait for VBI
		dbf	d6,.loop2		; delay frames

		jsr	RandomNumber		; generate a random number
		move.w	d0,Palette_NCurr.w	; set it as the palette

		jsr	RandomNumber		; generate a random number
		andi.w	#7,d0			; and for frames of delay
		addq.w	#2,d0			; add 2 for real delay

.loop3		move.b	#2,VBlank_Routine.w
		bsr.w	DelayProgram		; wait for another VBI
		dbf	d0,.loop3		; delay

		clr.w	Palette_NCurr.w		; set to black
		dbf	d7,.loop		; loop until done

		lea	Palette_NCurr.w,a6
		move.w	#$0EEE,($20*0)+(6*2)(a6)
		move.w	#$0000,($20*0)+(0*2)(a6); setup palette

		move.l	#0,$FFFFF616.w		; clear pos
		move.b	#2,VBlank_Routine.w
		bsr.w	DelayProgram		; wait for another VBI

		lea	DOS_ints(pc),a6		; new interrupts
		jsr	LoadJump		; load new interrupts over old ones

		move.l	#DOS_Text,DOS_TextPos.w	; copy default text pos
		lea	DOS_StartUp,DOS_txtreg	; start up text
		bsr	LoadText		; load it

; ---------------------------------------------------
; DOS main loop
; ---------------------------------------------------
.loop4		bsr.w	DelayProgram_
		bsr.s	CheckControls
		bra	.loop4

DOS_ints:	jmp	DOS_VBlank.l
		jmp	DOS_HBlank.l
DOS_ints_end:

CheckControls:
		move.b	$FFFFF604.w,d7			; get button presses
		move.b	$FFFFF605.w,d6			; get button presses
		btst	#5,d6				; if C is pressed
		beq.s	.notC				; if na, go aways
		bchg	#7,DOS_CtrlMode.w		; change button mode

.notC		tst.b	DOS_CtrlMode.w			; check the control mode
		bpl	.typemode			; if positive, its mode a

		btst	#0,d7				; if UP is pressed
		beq.s	.notup				; if not, test down
		sub.w	#DOS_LineLenght,DOS_TextPos+2.w; move position

		cmpi.w	#DOS_LineLenght*(DOS_OnScreenLines-1),DOS_TextPos+2.w
		bge.s	.noclr
		move.w	#DOS_LineLenght*(DOS_OnScreenLines-1),DOS_TextPos+2.w	; clear text pos

.noclr		moveq	#-DOS_OnScreenLines,d2
		bsr.s	.moveup

.notup		btst	#1,d7				; if DOWN is pressed
		beq.s	.notdown			; if not, test left
		add.w	#DOS_LineLenght,DOS_TextPos+2.w	; move position

		move.w	DOS_TextEndPos+2.w,d2		; get the end text position
		cmp.w	DOS_TextPos+2.w,d2		; compare with current pos
		bge.s	.nomove				; if not over it yet, skip
		move.w	d2,DOS_TextPos+2.w		; set to max

.nomove		moveq	#0,d2
		bsr.s	.moveup

.notdown	btst	#2,d6				; if LEFT is pressed
		beq.s	.notleft			; if not, test Right
		move.w	#DOS_LineLenght*(DOS_OnScreenLines-1),DOS_TextPos+2.w; move all the way up
		bra	.resetdisp

.notleft	btst	#3,d6				; if RIGHT is pressed
		beq.s	.notpress			; if not, quit life
		move.w	DOS_TextEndPos+2.w,DOS_TextPos+2.w; set to max
		bra	.resetdisp

.notpress	rts

.moveup		move.l	DOS_TextPos.w,DOS_txtoff	; get the offset of the requested text
		move.w	DOS_txtoff,d1			; get the offset of the text
		divu.w	#DOS_LineLenght,d1		; divide by the line lenght
		add.w	d2,d1				; add line offset
		moveq	#0,d0				; get cells offset

		andi.w	#$1F,d1				; wrap each 32 tiles
		jsr	GetPlatformPos2			; get the position

		muls.w	#DOS_LineLenght,d2		; make this line-wide
		add.w	d2,DOS_txtoff			; add desired read offset
		moveq	#0,d0

	rept	DOS_LineLenght				; repeat for the whole line
		move.b	(DOS_txtoff)+,d0		; get letter
		move.w	d0,(DOS_VDP)			; write next cell
	endr
		bra	DOS_InputDelay

.typemode	btst	#0,d7				; if UP is pressed
		beq.s	.notup2				; if not, test down
		moveq	#1,d4
		bsr	DOS_changeTile			; change tile at pointer

.notup2		btst	#1,d7				; if DOWN is pressed
		beq.s	.notdown2			; if not, test left
		moveq	#0,d4				; make sure upper bits are clear
		move.b	#-1,d4
		bsr	DOS_changeTile			; change tile at pointer

.notdown2	btst	#2,d6				; if LEFT is pressed
		beq.s	.notleft2			; if not, test Right

		subq.b	#1,DOS_CursorPos.w		; sub 1 from cursor pos
		bpl.s	.u
		sf	DOS_CursorPos.w			; if negative, clear the pos
.u		bsr	DOS_underscore

.notleft2	btst	#3,d6				; if RIGHT is pressed
		beq.s	.notright			; if not, check A

		addq.b	#1,DOS_CursorPos.w		; sub 1 from cursor pos
		cmpi.b	#DOS_LineLenght-3,DOS_CursorPos.w; check for max pos
		ble.s	.u2				; less -> branch
		move.b	#DOS_LineLenght-3,DOS_CursorPos.w; cap
.u2		bsr	DOS_underscore

.notright	btst	#6,d6				; if A is pressed
		beq.s	.notA				; if not, Check B

		bsr	DOS_InputPTR			; get pointer to a0
		sf	(a0)				; clear byte
		bsr	DOS_InputTextVDP		; get VDP command
		move.w	#0,(DOS_VDP)			; clear tile

		tst.b	d1
		beq.s	.notA				; if cursor pos is already 0, then dont move
		subq.b	#1,DOS_CursorPos.w		; else decrement
		bra	DOS_underscore			; move underscore to its preferred position

.notA		btst	#4,d6				; if B is pressed
		beq.s	.notB				; if not, quit life

.clearTextBox	moveq	#0,d1				; clear d1
		move.b	DOS_CursorPos.w,d1		; get cursor position
		bsr	DOS_InputTextVDP		; get VDP command
		addi.l	#$800000,d5			; get the bottom row
		move.l	d5,4(DOS_VDP)			; set to control port
		moveq	#0,d4				; clear d4
		move.w	d4,(DOS_VDP)			; clear the underscore

		sf	DOS_CursorPos.w			; clear the cursor position
		moveq	#0,d1
		bsr	DOS_InputTextVDP		; get VDP command

		lea	DOS_InputBox,a0			; get the inputbox data
		moveq	#DOS_LineLenght-3,d0		; clear the line

.clearloop	move.w	d4,(DOS_VDP)			; clear the tile
		move.b	d4,(a0)+			; clear the input box
		dbf	d0,.clearloop			; loop until cleared
		bra	DOS_underscore			; move underscore to its preferred position

.notB		btst	#7,d6				; if START is pressed
		beq.s	.notStart			; if not, quit life

		move.l	DOS_TextEndPos.w,DOS_txtoff	; force to end pos
		cmp.l	DOS_TextPos.w,DOS_txtoff	; test against the test pos
		seq	d7				; if equal, set d7

		add.w	#DOS_LineLenght,DOS_txtoff	; put to next line
		bsr	LoadText_getVDP			; get VDP comm

		lea	DOS_InputBox,a0			; get the text
		move.b	#$E,(DOS_txtoff)+		; write
		move.w	#$E,(DOS_VDP)			; write to VDP
		moveq	#DOS_LineLenght-3,d0		; length
		moveq	#0,d1				; clear d1

.copyloop	move.b	(a0)+,d1			; get letter
		move.b	d1,(DOS_txtoff)+		; copy next letter
		move.w	d1,(DOS_VDP)			; write to VDP
		dbf	d0,.copyloop			; loop until done

		move.b	#0,(DOS_txtoff)+		; clear the tiles

		sub.w	#DOS_LineLenght,DOS_txtoff	; correct the pusition
		move.l	DOS_txtoff,DOS_TextEndPos.w	; new end position
		move.l	DOS_txtoff,DOS_TextPos.w	; copy to ram

		moveq	#0,d4				; clear d4
		bsr	.clearTextBox			; clear the textbox
		bsr.w	DelayProgram_			; clear existing line

		tst.b	d7				; were we in the end already?
		bmi.s	.resetskip			; if so, dont reset display
		bsr	.resetdisp			; reset the display

.resetskip	move.l	DOS_TextEndPos.w,DOS_txtoff	; get the pointer again
		addq.w	#1,DOS_txtoff			; correct the position
		bra	DOS_DoCommand			; check commands

.notStart	rts

.resetdisp	move.w	#$8114,4(DOS_VDP)		; stop display

		move.l	DOS_TextPos.w,DOS_txtoff	; get the offset of the requested text
		add.w	#DOS_LineLenght,DOS_txtoff	; next line
		move.w	#(DOS_LineLenght*DOS_OnScreenLines)-1,d4; get repeat amount
		moveq	#0,d3

.loop		move.b	-(DOS_txtoff),d3		; get letter
		bsr	LoadText_getVDP			; get the write position
		move.w	d3,(DOS_VDP)			; write next cell
		dbf	d4,.loop			; loop until done

		move.l	DOS_TextPos.w,DOS_txtoff	; get the offset of the requested text
		add.w	#DOS_LineLenght,DOS_txtoff	; next line
		move.w	#(5*DOS_LineLenght)-1,d4	; get lines amount
		moveq	#0,d3

.loop2		bsr.s	LoadText_getVDP			; get the write position
		addq.w	#1,DOS_txtoff			; next pos
		move.w	d3,(DOS_VDP)			; write next cell
		dbf	d4,.loop2			; loop until done

		move.w	$FFFFF60C.w,d0
		ori.b	#$40,d0
		move.w	d0,4(DOS_VDP)			; Turn the display on
		rts

; ---------------------------------------------------
; Routines to handle some input commands
; ---------------------------------------------------
DOS_InputPTR:
		lea	DOS_InputBox,a0		; get the display pointer
		moveq	#0,d1			; clear d1
		move.b	DOS_CursorPos.w,d1	; get cursor position
		adda.w	d1,a0			; add it to the pointer
		rts

DOS_InputTextVDP:
		move.l	#$00036C82,d5		; initialize d5
		add.w	d1,d5			; add the tile offset
		add.w	d1,d5			; ^
		swap	d5			; swap for correct command
		move.l	d5,4(DOS_VDP)		; set to control port
		rts

; draws underscore where the cursor is at
DOS_underscore:
		moveq	#0,d1			; clear d1
		move.b	DOS_CursorPos.w,d1	; get cursor position
		bsr	DOS_InputTextVDP	; get VDP command

		addi.l	#$800000-$20000,d5	; get the bottom row
		move.l	d5,4(DOS_VDP)		; set new VDP thing
		move.l	#$C,(DOS_VDP)		; write underscore
		move.w	#0,(DOS_VDP)		; write space
		rts

DOS_changeTile:
		bsr	DOS_InputPTR		; get pointer to a0

		add.b	(a0),d4			; add the original amount to d0
		bpl.s	.checkmax		; if positive, check other bound
		moveq	#DOS_MaxCursorItem,d4	; set to max item

.checkmax	cmpi.b	#DOS_MaxCursorItem,d4	; check for max item
		ble.s	.done			; if less or same, dont bother
		moveq	#0,d4			; set to min item

.done		move.b	d4,(a0)			; store the num
		bsr	DOS_InputTextVDP	; get VDP command
		move.w	d4,(DOS_VDP)		; write text

		bsr.w	DelayProgram_

DOS_InputDelay:
		bsr.w	DelayProgram_
		bsr.w	DelayProgram_
		bra.w	DelayProgram_		; delay so you cant move too fast
; ---------------------------------------------------
; Routine to process text to screen
; ---------------------------------------------------
; get the VDP command for current position
LoadText_getVDP:
		moveq	#0,d0				; make sure the register wont overflow div
		move.w	DOS_txtoff,d0			; get the offset of the text
		divu.w	#DOS_LineLenght,d0		; divide by the line lenght
		move.w	d0,d1				; get lines offset
		swap	d0				; get cells offset

		andi.w	#$1F,d1				; wrap each 32 lines
		jmp	GetPlatformPos2			; get the position

LoadText:
		lea	VDP_Data_Port,DOS_VDP		; get data port for quick transfers
		move.l	DOS_TextPos.w,DOS_txtoff	; get the offset of the requested text
		moveq	#0,DOS_TxtItem			; clear this to make sure correct transfers occur

.nextText	moveq	#DOS_DefTextDelay,DOS_DelayCounter; set the new wait amount

.wait		bsr.w	DelayProgram__			; wait for vBlank
		dbf	DOS_DelayCounter,.wait		; loop for wait amount

		move.b	(DOS_txtreg)+,DOS_TxtItem	; get more text
		bmi.s	.command			; if negative, its a command

		bsr.s	LoadText_getVDP
		move.w	DOS_TxtItem,(DOS_VDP)		; store our new data to VDP
		move.b	DOS_TxtItem,(DOS_txtoff)+	; save item to memory also
		bra	.nextText			; draw more

		; index for program commands
		dc.w	.clockspd-.command	; $F2 - print clockspeed
		dc.w	.random-.command	; $F4 - Generate a random percent with random delays
		dc.w	.delay-.command		; $F6 - Delay x frames
		dc.w	.rts-.command		; $F8 - go forwards x tiles
		dc.w	.rts-.command		; $FA - go backwards x tiles
		dc.w	.newline-.command	; $FC - insert newline
		dc.w	.quit-.command		; $FE - end of text

.command	ori.w	#$FF00,DOS_TxtItem		; make this number negative for the command field
		move.w	.command(pc,DOS_TxtItem.w),d0	; get this lable as the pointer
		jsr	.command(pc,d0.w)		; jump to the newly found lable
		moveq	#0,DOS_TxtItem			; clear this flag
		bra	.nextText			; jump back

.quit		addq.l	#4,sp				; dont return to caller
		bsr.s	.newline			; skip to next line
		sub.w	#DOS_LineLenght,DOS_txtoff	; align correctly to last line
		move.l	DOS_txtoff,DOS_TextPos.w	; store the offset of the requested text
		move.l	DOS_txtoff,DOS_TextEndPos.w	; store actual end position
.rts		rts

.newline	bsr.s	.lineleft			; get the amount of tiles left in a line
		subq.b	#1,d1				; sub 1 for dbf
		moveq	#0,d0				; clear d0

.lineclear	move.b	d0,(DOS_txtoff)+		; clear next byte
		dbf	d1,.lineclear			; clear the whole line
		rts

; get the amount of tiles left in a line to d1
.lineleft	moveq	#DOS_LineLenght,d1
		moveq	#0,d0				; make sure the register wont overflow div
		move.w	DOS_txtoff,d0			; get the offset of the text
		divu.w	#DOS_LineLenght,d0		; divide by the line lenght
		swap	d0				; get the cells amount
		sub.w	d0,d1				; get the final result
		rts

.random		moveq	#0,d4				; prepare random % number to 0
		bsr	LoadText_getVDP			; get the VDP command

.rnd_main	bsr.s	.numtoVDP			; transfer number to VDP
		moveq	#0,d3				; clear loop counter
		move.b	1(DOS_txtreg),d3		; get loop counter

.rnd_loop	bsr.w	DelayProgram__
		dbf	d3,.rnd_loop			; delay for frames

		jsr	RandomNumber			; get random number
		lsr.w	#8,d0				; shift left 8 times
		and.b	(DOS_txtreg),d0			; and the value
		add.b	d0,d4				; add to the counter

		cmpi.b	#100,d4				; is over 100%?
		blo.s	.rnd_main			; if not, keep on going
		move.b	#$02,(DOS_txtoff)+		; move 100% to here
		move.b	#$01,(DOS_txtoff)+		; move 100% to here
		move.b	#$01,(DOS_txtoff)+		; move 100% to here
		move.b	#$2A,(DOS_txtoff)+		; move 100% to here

		move.l	d5,VDP_Control_Port-VDP_Data_Port(DOS_VDP); send the VDP command address
		move.l	#$00020001,(DOS_VDP)
		move.l	#$0001002A,(DOS_VDP)		; also 100% to screen
		adda.w	#2,DOS_txtreg			; skip control bytes
		rts

; write number in d4 to vDP
.numtoVDP	move.l	d5,VDP_Control_Port-VDP_Data_Port(DOS_VDP); send the VDP command address
		move.w	d4,d2
		moveq	#1,d3				; clear d3

.numloop	sub.w	#10,d2				; sub 10 from d4
		bcs.s	.0				; is less than 0?
		addq.w	#1,d3				; if not, add more to d3
		bra.s	.numloop			; loop

.0		add.w	#11,d2				; fix d4
		move.w	d3,(DOS_VDP)			;
		move.w	d2,(DOS_VDP)			; transfer numbers
		move.w	#$2A,(DOS_VDP)			; transfer %
		rts

; arbitrary delay generator
.delay		moveq	#0,d3				; clear loop counter
		move.b	(DOS_txtreg),d3			; get delay counter

.delayloop	bsr.w	DelayProgram__
		dbf	d3,.delayloop			; delay for frames
		adda.w	#1,DOS_txtreg			; skip control bytes
		rts

.clockspd	lea	DOS_USProcessorSpeed(pc),a0	; US setting
		btst	#6,HW_Version.w			; is this US?
		beq.s	.1				; if is, branch
		lea	DOS_EUProcessorSpeed(pc),a0	; EU setting

.1		bsr	LoadText_getVDP			; get the VDP command
		moveq	#0,d0				; clear upper word of d0
		moveq	#3,d1				; 3 repeats

.csloop		move.b	(a0)+,d0			; get byte to transfer
		move.w	d0,(DOS_VDP)			; transfer first word
		move.b	d0,(DOS_txtoff)+		; save next word
		dbf	d1,.csloop			; loop until done
		rts

DOS_EUProcessorSpeed:
		DOS_String '7.61'
		even

DOS_USProcessorSpeed:
		DOS_String '7.67'
		even

DOS_DoCommand:
		lea	DOS_Commands_End(pc),a3		; failure code
		lea	DOS_Commands(pc),a0		; get the command list
		moveq	#((DOS_Commands_End-DOS_Commands)/2)-1,d0; the lenght of the commands array

DOS_Command:
.mainloop	move.w	(a0)+,d1			; get the offset
		lea	(a0,d1.w),a1			; get the address of the command field

		moveq	#0,d1				; clear register
		move.b	(a1)+,d1			; get the lenght of the transfer
		btst	#0,d1				; check if this has odd number of data
		beq.s	.no				; if does, skip
		addq.w	#1,a1				; skip padding

.no		move.l	DOS_txtoff,a2			; copy the pointer

.loop		cmp.b	(a2)+,(a1)+			; check if the bytes match
		bne.s	.next				; if no match, branch
		dbf	d1,.loop			; keep looping
		jmp	(a1)				; jump to the command code

.next		dbf	d0,.mainloop			; loop for rest of commands
		jmp	(a3)				; go to the failure code


DOS_Commands:	dc.w DOS_cmd_htmlp-DOS_Commands-2	; HELP command
		dc.w DOS_cmd_cls-DOS_Commands-4		; CLS command
		dc.w DOS_cmd_dir-DOS_Commands-6		; DIR command
		dc.w DOS_cmd_cd-DOS_Commands-8		; CD command
		dc.w DOS_cmd_chkdsk-DOS_Commands-10	; CHKDSK command
		dc.w DOS_cmd_mem-DOS_Commands-12	; MEM command
		dc.w DOS_cmd_ver-DOS_Commands-14	; VER command
		dc.w DOS_cmd_read-DOS_Commands-16	; READ command
DOS_Commands_End:	; code for unknown command
		move.l	DOS_TextPos.w,DOS_txtoff	; get the offset of the text
		add.w	#DOS_LineLenght,DOS_txtoff	; next line
		bsr	LoadText_getVDP			; get VDP command

		lea	DOS_UnkCmd(pc),a0		; get right text
		moveq	#0,d0				; clear d0
		moveq	#DOS_LineLenght-1,d1		; set loop counter

.loop		move.b	(a0)+,d0			; get text to write
		move.b	d0,(DOS_txtoff)+		; write to memory
		move.w	d0,(DOS_VDP)			; write to VRAM
		dbf	d1,.loop			; loop

		sub.w	#DOS_LineLenght,DOS_txtoff	; last line
		move.l	DOS_txtoff,DOS_TextPos.w	;
		move.l	DOS_txtoff,DOS_TextEndPos.w	; save the offset of the text
		rts

DOS_UnkCmd:	DOS_String 'Uknown command!                         '

DOS_cmd_mem:	dc.b 3-1
		DOS_String 'mem'
		lea	DOS_mem,DOS_txtreg		; text
		add.w	#DOS_LineLenght,DOS_TextPos+2.w	; next line
		bra	LoadText			; load it

DOS_cmd_ver:	dc.b 3-1
		DOS_String 'ver'
		lea	DOS_ver,DOS_txtreg		; text
		add.w	#DOS_LineLenght,DOS_TextPos+2.w	; next line
		bra	LoadText			; load it

DOS_cmd_chkdsk:	dc.b 6-1, 0
		DOS_String 'CHKDSK'
		lea	DOS_CHKDSK,DOS_txtreg		; text
		add.w	#DOS_LineLenght,DOS_TextPos+2.w	; next line
		bra	LoadText			; load it

DOS_cmd_htmlp:	dc.b 5-1
		DOS_String 'help '

		move.l	a2,DOS_txtoff			; set pointer
		lea	.allcmds(pc),a3			; failure code
		lea	DOS_HelpCommands(pc),a0		; get the command list
		moveq	#((DOS_HelpCommands_End-DOS_HelpCommands)/2)-1,d0; the lenght of the commands array
		bsr	DOS_Command			; test out for commands

		add.w	#DOS_LineLenght,DOS_TextPos+2.w	; next line
		bra	LoadText			; load it

.allcmds	lea	DOS_Help,DOS_txtreg		; text
		rts

DOS_HelpCommands:
		dc.w DOS_helpcmd_cls-DOS_HelpCommands-2		; CLS command
		dc.w DOS_helpcmd_dir-DOS_HelpCommands-4		; DIR command
		dc.w DOS_helpcmd_cd-DOS_HelpCommands-6		; CD command
		dc.w DOS_helpcmd_chkdsk-DOS_HelpCommands-8	; CHKDSK command
		dc.w DOS_helpcmd_mem-DOS_HelpCommands-10	; MEM command
		dc.w DOS_helpcmd_ver-DOS_HelpCommands-12	; VER command
		dc.w DOS_helpcmd_read-DOS_HelpCommands-14	; READ command
DOS_HelpCommands_end:
DOS_helpcmd_cls:dc.b 3-1
		DOS_String 'cls'
		lea	DOS_Help_cls,DOS_txtreg		; text
		rts

DOS_helpcmd_dir:dc.b 3-1
		DOS_String 'dir'
		lea	DOS_Help_dir,DOS_txtreg		; text
		rts

DOS_helpcmd_cd:	dc.b 2-1, 0
		DOS_String 'cd'
		lea	DOS_Help_cd,DOS_txtreg		; text
		rts

DOS_helpcmd_chkdsk:	dc.b 6-1, 0
		DOS_String 'CHKDSK'
		lea	DOS_Help_CHKDSK,DOS_txtreg	; text
		rts

DOS_helpcmd_mem:dc.b 3-1
		DOS_String 'mem'
		lea	DOS_Help_mem,DOS_txtreg		; text
		rts

DOS_helpcmd_ver:dc.b 3-1
		DOS_String 'ver'
		lea	DOS_Help_ver,DOS_txtreg		; text
		rts

DOS_helpcmd_read:dc.b 5-1
		DOS_String 'read '
		lea	DOS_Help_read,DOS_txtreg		; text
		rts

DOS_cmd_read:	dc.b 5-1
		DOS_String 'read '

		cmpi.b	#32,DOS_Folder.w
		bne.s	.error

		move.l	a2,DOS_txtoff			; set pointer
		lea	.error(pc),a3			; failure code
		lea	DOS_redarr,a0			; get the command list
		moveq	#2-1,d0				; the lenght of the commands array
		bra	DOS_Command			; test out for commands

.error		add.w	#DOS_LineLenght,DOS_TextPos+2.w	; next line
		lea	DOS_readerr,DOS_txtreg		; text
		bra	LoadText			; load it

DOS_cmd_cls:	dc.b 3-1
		DOS_String 'cls'

		lea	DOS_Text,a0		; get text pointer
		move.w	#((DOS_LineLenght*820)/4)-1,d0; lenght of the clear
		moveq	#0,d1			; set to 0
		move.w	#DOS_LineLenght*(DOS_OnScreenLines-1),DOS_TextPos+2.w	;
		move.w	#DOS_LineLenght*(DOS_OnScreenLines-1),DOS_TextEndPos+2.w; reset text pos

.loop		move.l	d1,(a0)+		; clear next 4 bytes
		dbf	d0,.loop		; loop until done
		jmp	ClearScreen		; clear screen

DOS_cmd_cd:	dc.b 3-1
		DOS_String 'cd '

		move.l	a2,DOS_txtoff			; set pointer
		tst.b	(DOS_txtoff)			; check for space
		beq.s	.drawdir			; if the next was space, draw directory

		cmpi.b	#$2B,(DOS_txtoff)		; test dot
		bne.s	.nodot

		cmpi.b	#$2B,1(DOS_txtoff)		; test dot
		bne.s	.nodot

		cmpi.b	#$2B,2(DOS_txtoff)		; test dot
		beq.s	.lastdir
		cmpi.b	#0,2(DOS_txtoff)		; test space
		beq.s	.lastdir

.nodot		lea	.nodir(pc),a3			; failure code
		bsr	DOS_CurrentDirFoldersPTR	; get pointer for current directory folders
		move.w	-2(a0),d0			; the lenght of the commands array
		bmi	.nodir_				; negative amount = no directories
		bsr	DOS_Command			; test out for commands

		move.b	d0,DOS_Folder.w			; set folder
.drawdir	add.w	#DOS_LineLenght,DOS_TextPos+2.w	; next line
		lea	DOS_dir_asc,DOS_txtreg		; current dir text String
		bsr	LoadText			; load it

		bsr	DelayProgram_
		add.w	#DOS_LineLenght,DOS_TextPos+2.w	; next line
		bsr	DOS_CurrentDirNamePTR		; get pointer for current directory name
		bsr	LoadText			; load it
		rts

.nodir		addq.l	#4,sp
.nodir_		add.w	#DOS_LineLenght,DOS_TextPos+2.w	; next line
		lea	DOS_cd_asc,DOS_txtreg		; no dir text String
		bsr	LoadText			; load it

		bra	.drawdir

.lastdir	moveq	#0,d0
		move.b	DOS_Folder.w,d0			; get current dir ID
		move.b	.list(pc,d0.w),DOS_Folder.w	; get transform
		bpl	.drawdir

		move.b	d0,DOS_Folder.w			; restore
		add.w	#DOS_LineLenght,DOS_TextPos+2.w	; next line
		lea	DOS_cd_nodir,DOS_txtreg		; no dir text String
		bsr	LoadText			; load it
		bra	.drawdir			; draw new dir

.list		dc.b 32
		dcb.b 24, 0	; go back to main dir
		dcb.b 7, 20	; go to s3k
		dc.b $FF
		even


DOS_cmd_dir:	dc.b 3-1
		DOS_String 'dir'

		add.w	#DOS_LineLenght,DOS_TextPos+2.w	; next line
		lea	DOS_dir_asc,DOS_txtreg		; current dir text String
		bsr	LoadText			; load it

		bsr	DelayProgram_
		add.w	#DOS_LineLenght,DOS_TextPos+2.w	; next line
		bsr	DOS_CurrentDirNamePTR		; get pointer for current directory name
		bsr	LoadText			; load it

		bsr	DelayProgram_
		add.w	#DOS_LineLenght,DOS_TextPos+2.w	; next line
		bsr	DOS_CurrentDirFoldersPTR	; get pointer for current directory folders
		bsr	DOS_CurrentDirFoldersPrint	; print the folders

		bsr	DelayProgram_
		add.w	#DOS_LineLenght,DOS_TextPos+2.w	; next line
		bsr	DOS_CurrentDirFilesPTR		; get pointer for current directory folders
		bsr	DOS_CurrentDirFoldersPrint	; print the folders

		move.l	DOS_TextPos.w,DOS_TextEndPos.w	; set end pos
		rts

; print the directory folder listing
DOS_CurrentDirFoldersPrint:
		move.l	DOS_TextPos.w,DOS_txtoff	; get the offset
		move.w	-2(a0),d7			; the lenght of the commands array
		bmi	.rts				; negative amount = no directories

.mainloop	moveq	#0,d6
		move.w	(a0)+,d6			; get the offset
		lea	(a0,d6.w),a1			; get the address of the command field

		moveq	#0,d3
		moveq	#0,d6				; clear register
		moveq	#(40/2)-2,d4			; set register to half a line
		move.b	(a1)+,d6			; get the lenght of the transfer
		sub.w	d6,d4				; sub the lenght

		btst	#0,d6				; check if this has odd number of data
		beq.s	.loop				; if does, skip
		addq.w	#1,a1				; skip padding

.loop		bsr	LoadText_getVDP			; get the VDP pos
		move.b	(a1)+,d3
		move.b	d3,(DOS_txtoff)+		; check if the bytes match
		move.w	d3,(DOS_VDP)			; write to VRAM

		bsr	DelayProgram_
		dbf	d6,.loop			; keep looping

.loop2		move.b	#0,(DOS_txtoff)+		; check if the bytes match
		dbf	d4,.loop2			; keep looping

		bsr	DelayProgram__
		bsr	DelayProgram_
		bsr	DelayProgram_
		dbf	d7,.mainloop			; loop for rest of commands
.rts		rts

; get pointer for directory name
DOS_CurrentDirNamePTR:
		moveq	#0,d0
		move.b	DOS_Folder.w,d0			; get current dir ID
		lsl.w	#2,d0				; shift left for long
		move.l	.list(pc,d0.w),DOS_txtreg	; get its final pointer
		rts

.list		dc.l DOS_dirname_Initialdir, DOS_dirname_SSRG, DOS_dirname_anim
		dc.l DOS_dirname_dlls, DOS_dirname_inc, DOS_dirname_maps
		dc.l DOS_dirname_artkos, DOS_dirname_artnem, DOS_dirname_artunc
		dc.l DOS_dirname_boss, DOS_dirname_collide, DOS_dirname_dac
		dc.l DOS_dirname_demodata, DOS_dirname_levels, DOS_dirname_map16
		dc.l DOS_dirname_map256, DOS_dirname_mapeni, DOS_dirname_misc
		dc.l DOS_dirname_objpos, DOS_dirname_pallet, DOS_dirname_s3k
		dc.l DOS_dirname_s3l, DOS_dirname_SMPS, DOS_dirname_sound
		dc.l DOS_dirname_startpos, DOS_dirname_compart, DOS_dirname_compmap
		dc.l DOS_dirname_Enigma, DOS_dirname_Kosinski, DOS_dirname_KosinskiM
		dc.l DOS_dirname_Nemesis, DOS_dirname_Palette, DOS_dirname_Sys

		dc.w -1		; no folders to read
DOS_NoFolders:
; get pointer for directory contents
DOS_CurrentDirFoldersPTR:
		moveq	#0,d0
		move.b	DOS_Folder.w,d0			; get current dir ID
		lsl.w	#2,d0				; shift left for long
		move.l	.list(pc,d0.w),a0		; get its final pointer
		rts

.list		dc.l DOS_dircont_s1mt, DOS_NoFolders, DOS_NoFolders
		dc.l DOS_NoFolders, DOS_NoFolders, DOS_NoFolders
		dc.l DOS_NoFolders, DOS_NoFolders, DOS_NoFolders
		dc.l DOS_NoFolders, DOS_NoFolders, DOS_NoFolders
		dc.l DOS_NoFolders, DOS_NoFolders, DOS_NoFolders
		dc.l DOS_NoFolders, DOS_NoFolders, DOS_NoFolders
		dc.l DOS_NoFolders, DOS_NoFolders, DOS_dircont_s3k
		dc.l DOS_NoFolders, DOS_NoFolders, DOS_NoFolders
		dc.l DOS_NoFolders, DOS_NoFolders, DOS_NoFolders
		dc.l DOS_NoFolders, DOS_NoFolders, DOS_NoFolders
		dc.l DOS_NoFolders, DOS_NoFolders, DOS_dircont_sys

; get pointer for directory files
DOS_CurrentDirFilesPTR:
		moveq	#0,d0
		move.b	DOS_Folder.w,d0			; get current dir ID
		lsl.w	#2,d0				; shift left for long
		move.l	.list(pc,d0.w),a0		; get its final pointer
		rts

.list		dc.l DOS_dirfile_s1mt, DOS_dirfile_ssrg, DOS_dirfile_anim
		dc.l DOS_dirfile_dlls, DOS_dirfile_inc, DOS_dirfile_maps
		dc.l DOS_dirfile_artkos, DOS_dirfile_artnem, DOS_dirfile_artunc
		dc.l DOS_dirfile_boss, DOS_dirfile_collide, DOS_dirfile_dac
		dc.l DOS_dirfile_demodata, DOS_dirfile_levels, DOS_dirfile_map16
		dc.l DOS_dirfile_map256, DOS_dirfile_mapeni, DOS_dirfile_misc
		dc.l DOS_dirfile_objpos, DOS_dirfile_palette, DOS_dirfile_s3k
		dc.l DOS_dirfile_s3l, DOS_dirfile_smps, DOS_dirfile_sound
		dc.l DOS_dirfile_start, DOS_dirfile_s3kca, DOS_dirfile_s3kcm
		dc.l DOS_dirfile_s3kem, DOS_dirfile_s3kka, DOS_dirfile_s3kkma
		dc.l DOS_dirfile_s3kna, DOS_dirfile_s3kpal, DOS_dirfile_sys

DOS_ExtraTiles:
		hex 00000000
		hex 66000660
		hex 66006600
		hex 00066000
		hex 00660000
		hex 06600660
		hex 66000660; percent

		hex 00000000
		hex 00000000
		hex 00000000
		hex 00000000
		hex 00000000
		hex 06600000
		hex 06600000
		hex 00000000; dot

		hex 00000000
		hex 00000000
		hex 00000000
		hex 00000000
		hex 00000000
		hex 06600000
		hex 06600000
		hex 66000000; halfdotthingy

		hex 00000000
		hex 00066000
		hex 00066000
		hex 00660000
		hex 00660000
		hex 00000000
		hex 06600000
		hex 06600000; exclamation

		hex 00000000
		hex 00666600
		hex 06600660
		hex 00006600
		hex 00066000
		hex 00000000
		hex 00660000
		hex 00660000; question mark

		hex 00000000
		hex 00000000
		hex 00000000
		hex 00000000
		hex 00000000
		hex 00000000
		hex 66666666
		hex 00000000; underscore
DOS_ExtraTiles_end:
		even

DOS_ClearLine:
		moveq	#0,d0			; clear d0
	rept	DOS_LineLenght/2		; repeat for the whole line
		move.l	d0,(DOS_VDP)		; clear next 2 cells
	endr
		rts
; ----------------------------------------------------------------------
; Vertical blanking subroutine
; ----------------------------------------------------------------------
DOS_VBlank:
		movem.l	d0-d1/a0-a1,-(sp)	; store used variables

		moveq	#0,d0
		move.w	DOS_TextPos+2.w,d0	; get total amount of lines created so far
		divu.w	#DOS_LineLenght,d0	; divide by the line lenght
		subi.w	#DOS_OnScreenLines-1,d0	; add lines offset
		lsl.w	#3,d0			; multiply by 8
		move.l	#$40000010,4(DOS_VDP)
		move.w	d0,(DOS_VDP)		; write the line num

		cmp.w	DOS_TextLines.w,d0	; compare lines
		beq	.skip			; if same, branch
		bgt	.scrolldown		; if was scrolled down

		moveq	#0,d2
		bra.s	.common

.scrolldown	moveq	#4,d2

.common		move.w	d0,DOS_TextLines.w	; save the line
		moveq	#0,d1			; make sure the register wont overflow div
		move.w	DOS_TextPos+2.w,d1	; get the offset of the text
		add.w	#DOS_LineLenght,d1
		divu.w	#DOS_LineLenght,d1	; divide by the line lenght
		add.w	d2,d1			; get last shown line
		moveq	#0,d0			; get cells offset

		andi.w	#$1F,d1			; wrap each 32 tiles
		jsr	GetPlatformPos2		; get the position
		bsr	DOS_ClearLine

.skip		move.w	#$8000,d0
		sub.w	DOS_TextPos+2.w,d0	; get total amount of lines created so far
		cmpi.w	#DOS_LineLenght*4,d0
		bhs.s	.fine
		tst.b	DOS_VBIstuck.w
		bmi.s	.fine

		movem.l	(sp)+,d0-d1/a0-a1; restore used variables
		sf	VBlank_Routine.w
		st	DOS_VBIstuck.w

.errloc		move.l	#DOS_Text,DOS_TextPos.w	; copy default text pos
		lea	DOS_toolong,DOS_txtreg	; start up text
		bsr	LoadText		; load it
		bra	*

.fine		btst	#6,HW_Version.w
		beq.s	.noEU
		move.w	#$700,d0
		dbf	d0,*

.noEU		bsr.w	ReadJoypads
		movem.l	(sp)+,d0-d1/a0-a1; restore used variables

DOS_HBlank:
		sf	VBlank_Routine.w
		rte

NO_SRAM_FUCK_SEGA:
		moveq	#$FFFFFFE4,d0
		jsr	PlayMusic
		jsr	ClearScreen		; clear the screen

		lea	VDP_control_port,a6
		move.w	#$8004,(a6)		; Disable HInt, HV Counter
		move.w	#$8230,(a6)		; Nametable A at $C000
		move.w	#$8407,(a6)		; Nametable B at $E000
		move.w	#$9001,(a6)		; 64x32 cell nametable area
		move.w	#$9200,(a6)		; Window V position at default
		move.w	#$8B00,(a6)		; Vscroll full, HScroll full
		move.w	#$8700,(a6)		; BG color is Pal 0 Color 0

		move.w	$FFFFF60C.w,d0
		ori.b	#$40,d0
		move.w	d0,(a6)			; Turn the display on
		move	#$2700,sr		; disable ints

		moveq	#0,d1
		moveq	#0,d2
		moveq	#0,d3
		moveq	#0,d4
		movem.l	d1-d4,$FFFFFFF0.w
		movem.l	$FFFFFFF0.w,d5-d7
		movem.l	$FFFFFFF0.w,a0-a3
		movem.l	$FFFFFFF0.w,a4-a6

		lea	$FF0000,a7
		move.w	#$392-1,d0		; this clears the first $FFF0 bytes of RAM

.clr		movem.l	d1-a6,(a7)		; clear $38 bytes at once
		lea	$38(a7),a7
		dbf	d0,.clr

		; load art
		lea	VDP_Data_Port,a6
		move.l	#$40200000,4(a6)
		lea	Art_Text,a5
		move.w	#$290/2,d1

.LoadText	move.l	(a5)+,(a6)
		dbf	d1,.loadText		; load uncompressed text patterns

		lea	DOS_ExtraTiles,a5	; custom tiles
		move.w	#((DOS_ExtraTiles_end-DOS_ExtraTiles)/4)-1,d1

.LoadText2	move.l	(a5)+,(a6)
		dbf	d1,.loadText2		; load uncompressed text patterns

		lea	Palette_NCurr.w,a6
		move.w	#$0EEE,($20*0)+(6*2)(a6)
		move.w	#$0000,($20*0)+(0*2)(a6); setup palette
		clr.w	(a6)
		clr.l	$FFFFF616.w		; clear pos
		move.b	#2,VBlank_Routine.w
		bsr.w	DelayProgram		; wait for another VBI
		move.l	#DOS_Stack,sp		; set new stack pointer

		lea	DOS_ints(pc),a6		; new interrupts
		jsr	LoadJump		; load new interrupts over old ones

		move.l	#DOS_Text,DOS_TextPos.w	; copy default text pos
		lea	DOS_SEGA_ERROR,DOS_txtreg; error!
		jsr	LoadText(pc)		; load it

.loopforever	tst.b	$FFFFF604.w
		bpl.s	.loopforever
		lea	InterruptMain.w,a6	; new interrupts
		jsr	LoadJump		; load new interrupts over old ones
		jmp	TitleScreen_skip
