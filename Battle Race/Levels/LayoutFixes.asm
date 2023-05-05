obf	macro x,y,id,sub,flip
	dc.w x,(y&$FFF)|(flip<<13),(id<<8)|sub
    endm

Obj_LayoutFixes:
		moveq	#0,d0
		move.b	subtype(a0),d0		; get sub
		add.b	d0,d0			; double sub
		bcc.s	.nox			; if positive, change according to alt lay

	; check according to bosses
		add.w	d0,d0			; quadrupble
		btst	#5,OptionsBits.w	; Check if bosses are on
		beq.s	.noalt			; branch if not
		addq.w	#2,d0			; get alt version
		bra.s	.noalt

.nox		add.w	d0,d0			; quadrupble
		tst.b	OptionsBits.w		; check if alt mode
		bpl.s	.noalt			; if not, branch
		addq.w	#2,d0			; get alt version

.noalt		lea	Sprite_ListingK,a3
		moveq	#0,d1
		move.b	Current_zone.w,d1
		cmpi.b	#$16,d1
		bhs.s	.lk
		cmpi.b	#$E,d1
		bhs.s	.l3
		cmpi.b	#7,d1
		bhs.s	.lk
.l3		lea	Sprite_Listing3,a3

.lk		add.w	d1,d1			; double zone
		move.w	.levels(pc,d1.w),d1	; get offset
		lea	.levels(pc,d1.w),a2	; get table offset

		move.w	(a2,d0.w),d0		; get offset in table
		beq.s	.del			; if offset 0, branch
		add.w	d0,a2			; get data to a2
		move.w	a0,a1			; convert this object first!

		move.w	(a2)+,d6		; get dbf counter
		move.w	x_pos(a0),d4		; get x-pos
		move.w	y_pos(a0),d5		; get y-pos
		move.b	render_flags(a0),d3	; get render flags
		and.w	#3,d3			; get only low 2 bits
		bra.s	.set

.load		jsr	Create_New_Sprite3	; load new obj
		bne.s	.rts			; if cant, end

.set		move.w	(a2)+,x_pos(a1)		; copy x-pos
		move.w	(a2)+,d1		; get y-pos
		move.w	d1,d2			; copy
		bpl.s	.noadd			; branch if not relative

		add.w	d4,x_pos(a1)		; offset x-pos
		add.w	d5,d1			; offset y-pos

.noadd		andi.w	#$FFF,d1		; get only necessary bits
		move.w	d1,y_pos(a1)		; save
		rol.w	#3,d2			; shift bits to right place
		andi.w	#3,d2			; get only 2 bits
		eor.b	d3,d2			; eor with original bits
		move.b	d2,render_flags(a1)	; save as render flags
		move.b	d2,status(a1)		; and status

		move.b	(a2)+,d2		; get obj ID
		add.w	d2,d2
		add.w	d2,d2			; quadruple
		move.l	(a3,d2.w),(a1)		; get proper pointer and put as obj ptr

		move.b	(a2)+,subtype(a1)	; set subtype
		dbf	d6,.load		; loop til done
.rts		rts
.del		jmp	Delete_Current_Sprite	; if no entries, delete ourselves
; ---------------------------------------------------------------------------

.levels	dc.w .tbl1-.levels		; AIZ
	dc.w .tbl1-.levels		; HCZ
	dc.w .tbl1-.levels		; MGZ
	dc.w .tbl1-.levels		; CNZ
	dc.w .tbl2-.levels		; FBZ
	dc.w 0				; ICZ
	dc.w .tbl1-.levels		; LBZ
	dc.w .tbl2-.levels		; MHZ
	dc.w .soz-.levels		; SOZ
	dc.w .tbl2-.levels		; LRZ
	dc.w .tbl2-.levels		; SSZ
	dc.w .tbl2-.levels		; DEZ
	dc.w [$16-$0C] 0		; oops
	dc.w 0				; LRZ/HPZ
; ---------------------------------------------------------------------------

.SprYV02	dc.w 1-1		; Yellow Spring vertical with offset 0.0
	obf 0, 0, $07, $02, 4

.SprRV02	dc.w 1-1		; Red Spring vertical with offset 0.0
	obf 0, 0, $07, $00, 4

.SprRH10	dc.w 1-1		; Red Spring horizontal with offset 0.0, subtype 10
	obf 0, 0, $07, $10, 4

.SprYH12	dc.w 1-1		; Yellow Spring horizontal with offset 0.0, subtype 12
	obf 0, 0, $07, $12, 4

.SpkH2		dc.w 1-1		; Horizontal Double Spike set
	obf 0, 0, $08, $10, 4

.SpkH2U		dc.w 1-1		; Horizontal Double Spike set move up-down
	obf 0, 0, $08, $11, 4

.SpkH1		dc.w 1-1		; Horizontal Single Spike set
	obf 0, 0, $08, $00, 4

.SpkH1U		dc.w 1-1		; Horizontal Signle Spike set move up-down
	obf 0, 0, $08, $01, 4

.SpkH1U_y4	dc.w 1-1		; Horizontal Signle Spike set move up-down, moved down 4 pixels
	obf 0, 4, $08, $01, 4

.SpkH3		dc.w 1-1		; Horizontal Triple Spike set
	obf 0, 0, $08, $20, 4

.lbz1bnc0 	dc.w 1-1
	obf  10, -10, $5E, $00, 4	; ring at x-offset of 10

.lbz1bnc1	dc.w 1-1
	obf  85, -10, $5E, $00, 4	; ring at x-offset of 85

.lbz1bnc2	dc.w 1-1
	obf 170, -10, $5E, $00, 4	; ring at x-offset of dc

.lbz1bnc3	dc.w 1-1
	obf 245, -10, $5E, $00, 4	; ring at x-offset of 245

.lbz1bnc4	dc.w 1-1
	obf 310, -10, $5E, $00, 4	; ring at x-offset of 310
; ---------------------------------------------------------------------------

.tbl1	dc.w .mgz1sketchN-.tbl1, 0			; 00 - MGZ1 bitchy spikes with sketchy jumps
	dc.w .cnz2barrelN-.tbl1, .cnz2barrelA-.tbl1	; 01 - CNZ2 bitch barrel exploit
	dc.w .SprRH10-.tbl1, 0				; 02 - CNZ2 bitch springs assholes
	dc.w .SprYH12-.tbl1, 0				; 03 - CNZ2 moar bitch spring shite
	dc.w .cnz2bump1N-.tbl1, .cnz2bump1A-.tbl1	; 04 - CNZ2 stupid bollocks bumper spike ledge 1
	dc.w .cnz2bump2N-.tbl1, 0			; 05 - CNZ2 stupid bollocks bumper spike ledge 2
	dc.w .cnz2bump3N-.tbl1, 0			; 06 - CNZ2 fucker bumper shite
	dc.w .cnz2fbarrelN-.tbl1, 0			; 07 - CNZ2 damn fast barrel
	dc.w .cnz2bump4N-.tbl1, 0			; 08 - CNZ2 horrid bumper shite
	dc.w .cnz1bump2N-.tbl1, 0			; 09 - CNZ1 gay bumpers
	dc.w .cnz1barrel1N-.tbl1, 0			; 0A - CNZ1 hetero barrels
	dc.w .SpkH3-.tbl1, 0				; 0B - LBZ2 large spike shit
	dc.w .lbz2orbiN-.tbl1, 0			; 0C - LBZ2 Gorbinaut
	dc.w .lbz1shooterN-.tbl1, 0			; 0D - LBZ1 shooting gye
	dc.w 0, 0					; 0E -
	dc.w 0, 0					; 0F -
	dc.w 0, 0					; 10 -
	dc.w .mgz2bossN-.tbl1, .mgz2bossA-.tbl1		; 11 - MGZ2 boss monitors
	dc.w .SpkH1U-.tbl1, .SpkH1U_y4-.tbl1		; 12 - CNZ2 derp spike palcement
	dc.w [2] .lbz1bnc0-.tbl1			; 13 - LBZ1 minigame bouncing ring 0
	dc.w [2] .lbz1bnc1-.tbl1			; 14 - LBZ1 minigame bouncing ring 1
	dc.w [2] .lbz1bnc2-.tbl1			; 15 - LBZ1 minigame bouncing ring 2
	dc.w [2] .lbz1bnc3-.tbl1			; 16 - LBZ1 minigame bouncing ring 3
	dc.w [2] .lbz1bnc4-.tbl1			; 17 - LBZ1 minigame bouncing ring 4
	dc.w [2] .lbz1mngs0_0-.tbl1			; 18 - LBZ1 minigame section 0, entry 0 - 3 flybots
	dc.w [2] .lbz1mngs0_1-.tbl1			; 19 - LBZ1 minigame section 0, entry 1 - 2 ribots
	dc.w [2] .lbz1mngs1_0-.tbl1			; 1A - LBZ1 minigame section 1, entry 0 - 2 flybots
	dc.w [2] .lbz1mngs1_1-.tbl1			; 1B - LBZ1 minigame section 1, entry 1 - 2 ribots
	dc.w [2] .lbz1mngs1_2-.tbl1			; 1C - LBZ1 minigame section 1, entry 2 - 2 ribots (copy from 0_1)
	dc.w [2] .lbz1mngs2_0-.tbl1			; 1D - LBZ1 minigame section 2, entry 0 - 2 corkeys
	dc.w [2] .lbz1mngs2_1-.tbl1			; 1E - LBZ1 minigame section 2, entry 1 - 2 ribots (almost copy from 1_1)
	dc.w [2] .lbz1mngs2_2-.tbl1			; 1F - LBZ1 minigame section 2, entry 2 - 1 corkey
	dc.w [2] .lbz1mngs3_0-.tbl1			; 20 - LBZ1 minigame section 3, entry 0 - 1 ribot (centre)
	dc.w [2] .lbz1mngs3_1-.tbl1			; 21 - LBZ1 minigame section 3, entry 1 - 1 ribot (left)
	dc.w [2] .lbz1mngs3_2-.tbl1			; 22 - LBZ1 minigame section 3, entry 2 - 1 ribot (right)
	dc.w [2] .lbz1mngs3_3-.tbl1			; 23 - LBZ1 minigame section 3, entry 3 - 1 ribot (left)
	dc.w [2] .lbz1mngs4_0-.tbl1			; 24 - LBZ1 minigame section 4, entry 0 - 1 ribot (left)
	dc.w [2] .lbz1mngs4_1-.tbl1			; 25 - LBZ1 minigame section 4, entry 1 - 1 ribot (right)
; ---------------------------------------------------------------------------

.lbz1mngs0_0	dc.w 3-1
	obf -16,  32, $DF, $00, 4
	obf 336,  32, $DF, $00, 4
	obf -16, 192, $DF, $00, 4

.lbz1mngs0_1	dc.w 2-1
	obf  60, -126, $DE, $14, 4
	obf 260, -126, $DE, $14, 4

.lbz1mngs1_0	dc.w 2-1
	obf -16, 200, $DF, $00, 4
	obf 336,   0, $DF, $00, 4

.lbz1mngs1_1	dc.w 2-1
	obf  20, -126, $DE, $98, 4
	obf 300, -126, $DE, $98, 4

.lbz1mngs1_2	dc.w 2-1
	obf  60, -126, $DE, $94, 4
	obf 260, -126, $DE, $94, 4

.lbz1mngs2_0	dc.w 2-1
	obf   0,  80, $C1, $FF, 4
	obf -32,  80, $C1, $FF, 4

.lbz1mngs2_1	dc.w 2-1
	obf  20, -126, $DE, $10, 4
	obf 300, -126, $DE, $10, 4

.lbz1mngs2_2	dc.w 1-1
	obf -16,  80, $C1, $FF, 4

.lbz1mngs3_0	dc.w 1-1
	obf 160, -126, $DE, $1C, 4

.lbz1mngs3_1	dc.w 1-1
	obf  20, -126, $DE, $14, 4

.lbz1mngs3_2	dc.w 1-1
	obf 300, -126, $DE, $14, 4

.lbz1mngs3_3	dc.w 1-1
	obf  20, -126, $DE, $08, 4

.lbz1mngs4_0	dc.w 1-1
	obf  60, -126, $DE, $0C, 4

.lbz1mngs4_1	dc.w 1-1
	obf 260, -126, $DE, $0C, 4



.cnz2barrelN	dc.w 1-1
	obf $1820, $620, $47, $40, 0

.cnz1barrel1N	dc.w 1-1
	obf 0, 0, $47, $45, 4

.cnz2barrelA	dc.w 3-1
	obf $1810, $608, $07, $00, 0
	obf $1830, $608, $07, $00, 0
	obf $1820, $620, $08, $10, 2

.cnz2bump1N	dc.w 2-1
	obf  $00, 0, $46, $80, 4
	obf -$20, 0, $46, $80, 4

.cnz2bump1A	dc.w 3-1
	obf  $00, 0, $07, $02, 4
	obf -$20, 0, $07, $02, 4
	obf -$10,$18,$08, $10, 6

.cnz2bump2N	dc.w 4-1
	obf 0, 0, $4A, $80, 5
	obf 0, 0, $4A, $00, 4
	obf 0, 0, $4A, $2B, 5
	obf 0, 0, $4A, $D5, 5

.cnz1bump2N	dc.w 4-1
	obf 0, 0, $4A, $80, 4
	obf 0, 0, $4A, $00, 4
	obf 0, 0, $4A, $2B, 4
	obf 0, 0, $4A, $D5, 4

.mgz1sketchN	dc.w 2-1
	obf $129A, $0EE, $08, $00, 0
	obf $12C8, $0C0, $08, $00, 0

.cnz2bump3N	dc.w 3-1
	obf 0, 0, $4A, $80, 4
	obf 0, 0, $4A, $FF, 4
	obf 0, 0, $4A, $00, 4

.cnz2bump4N	dc.w 3-1
	obf 0, 0, $4A, $80, 4
	obf 0, 0, $4A, $2B, 4
	obf 0, 0, $4A, $D5, 4

.cnz2fbarrelN	dc.w 1-1
	obf 0, 0, $47, $63, 4

.lbz2orbiN	dc.w 1-1
	obf 0, 0, $C0, $00, 4

.lbz1shooterN	dc.w 1-1
	obf 0, 0, $BE, $00, 4

.aiz1treeplatA	dc.w 1-1
	obf 0, 0, $51, $22, 4

.mgz2bossN	dc.w 3-1
	obf $3CA8, $0760, $80, $00, 0
	obf $3D20, $0760, $80, $00, 0
	obf $3D90, $0760, $80, $00, 0

.mgz2bossA	dc.w 3-1
	obf $3CA8, $0784, $80, $00, 0
	obf $3D20, $0784, $80, $00, 0
	obf $3D90, $0784, $80, $00, 0
; ---------------------------------------------------------------------------

.tbl2	dc.w .fbz2door1N-.tbl2, 0			; 00 - FBZ2 horizontal fuckin door
	dc.w .SpkH1-.tbl2, 0				; 01 - FBZ2 dumb spike lol
	dc.w .fbz1platN-.tbl2, .SprYV02-.tbl2		; 02 - FBZ1 cock platforms slooow
	dc.w .lrz1spinN-.tbl2, 0			; 03 - LRZ1 spindash platform for sex 1
	dc.w .lrz1crushN-.tbl2, 0			; 04 - LRZ1 crush platform death
	dc.w .lrz1spin2N-.tbl2, 0			; 05 - LRZ1 spindash platform for sex 2
	dc.w .lrz1spin3N-.tbl2, 0			; 06 - LRZ1 spindash platform for sex 3
	dc.w .lrz1spin4N-.tbl2, .SprRV02-.tbl2		; 07 - LRZ1 spindash platform for sex 4
	dc.w .lrz1spin5N-.tbl2, 0			; 08 - LRZ1 spindash platform for sex 5
	dc.w .dez1lightbN-.tbl2, .dez1lightbA-.tbl2	; 09 - DEZ1 awful lightbridge trap
	dc.w .lrz1doorBN-.tbl2, 0			; 0A - LRZ1 slow door butt
	dc.w .lrz2halfpipe1N-.tbl2, .lrz2halfpipe1A-.tbl2; 0B - LRZ2 half-ass pipe 1
	dc.w .lrz2halfpipe2N-.tbl2, .lrz2halfpipe2A-.tbl2; 0C - LRZ2 half-ass pipe 2
	dc.w .lrz2halfpipe3N-.tbl2, .lrz2halfpipe3A-.tbl2; 0D - LRZ2 half-ass pipe 2
	dc.w 0, .SprYV02-.tbl2				; 0E - SSZ extra spring
	dc.w 0, .sszwindA-.tbl2				; 0F - SSZ wind object

	dc.w .dez1lightt1N-.tbl2, 0			; 10 - DEZ1 silly light tunnel 1
	dc.w .dez1lightt2N-.tbl2, 0			; 11 - DEZ1 silly light tunnel 2
	dc.w .dez1lightt3N-.tbl2, 0			; 12 - DEZ1 silly light tunnel 3
	dc.w .dez1lightt4N-.tbl2, 0			; 13 - DEZ1 silly light tunnel 4
	dc.w .dez1lightt5N-.tbl2, 0			; 14 - DEZ1 silly light tunnel 5
	dc.w .dez1lightt6N-.tbl2, 0			; 15 - DEZ1 silly light tunnel 6
	dc.w .fbz1messec1N-.tbl2, .fbz1messec1A-.tbl2	; 16 - LRZ1 messy section fix 1
	dc.w .fbz1messec2N-.tbl2, 0			; 17 - LRZ1 messy section fix 2
	dc.w .fbz1messec3N-.tbl2, 0			; 18 - LRZ1 messy section fix 3
	dc.w .fbz1messec4N-.tbl2, 0			; 19 - LRZ1 messy section fix 4
	dc.w .fbz1messec5N-.tbl2, .fbz1messec5A-.tbl2	; 1A - LRZ1 messy section fix 5
	dc.w .fbz1messec6N-.tbl2, 0			; 1B - LRZ1 messy section fix 6
	dc.w .fbz1messec7N-.tbl2, 0			; 1C - LRZ1 messy section fix 7
	dc.w .fbz1messec8N-.tbl2, 0			; 1D - LRZ1 messy section fix 8
	dc.w .fbz1messec9N-.tbl2, 0			; 1E - LRZ1 messy section fix 9
	dc.w .fbz1messecAN-.tbl2, 0			; 1F - LRZ1 messy section fix 10

	dc.w .sszsmallplatN-.tbl2, 0			; 20 - SSZ small breaking platform
	dc.w .fbz1rotplatN-.tbl2, 0			; 21 - FBZ1 silly rotating platform at lay mod
	dc.w .mhz1swingN-.tbl2, .SprYV02-.tbl2		; 22 - MHZ1 homo swinging butts
	dc.w 0, .SprRV02-.tbl2				; 23 - Red vertical spring
	dc.w .lrz2triple1-.tbl2, 0			; 24 - LRZ2 triple platform 1
	dc.w .lrz2triple2-.tbl2, 0			; 25 - LRZ2 triple platform 2
	dc.w 0, .SprYH12-.tbl2				; 26 - SSZ more extra spring
	dc.w 0, .fbz1messecBA-.tbl2			; 27 - LRZ1 messy section fix 11
	dc.w 0, .dez1pitlightbA-.tbl2			; 28 - DEZ1 death pit add light bridge
	dc.w .lrz1door7N-.tbl2, 0			; 29 - LRZ1 slow door butt
	dc.w .lrz1door9N-.tbl2, 0			; 2A - LRZ1 slow door butt
; ---------------------------------------------------------------------------

.fbz2door1N	dc.w 1-1
	obf 0, 0, $7A, $57, 4

.fbz1platN	dc.w 2-1
	obf $118C, $770, $75, $00, 0
	obf $1174, $7F0, $75, $01, 0

.fbz1rotplatN	dc.w 2-1
	obf 0, 0, $28, $22, 4
	obf 0, 0, $77, $00, 5

.lrz1spinN	dc.w 1-1
	obf 0, 0, $1E, $B6, 4

.lrz1spin2N	dc.w 1-1
	obf 0, 0, $1E, $B9, 4

.lrz1spin3N	dc.w 1-1
	obf 0, 0, $1E, $20, 4

.lrz1spin4N	dc.w 1-1
	obf -$10, -$06, $1E, $1D, 5

.lrz1spin5N	dc.w 1-1
	obf 0, 0, $1E, $46, 4

.lrz1crushN	dc.w 1-1
	obf 0, 0, $21, $14, 4

.dez1lightbN	dc.w 1-1
	obf 0, 0, $55, $66, 4

.dez1lightbA	dc.w 4-1
	obf 0, 0, $55, $03, 4
	obf 0, 0, $55, $43, 4
	obf 0, 0, $55, $83, 4
	obf 0, 0, $55, $C3, 4

.dez1pitlightbA	dc.w 6-1
	obf 0, 0, $55, $01, 4
	obf 0, 0, $55, $41, 4
	obf 0, 0, $55, $81, 4
	obf 0, 0, $55, $C1, 4
	obf -$39, 4, $2F, $30, 4
	obf  $39, 4, $2F, $30, 5

.lrz1doorBN	dc.w 1-1
	obf 0, 0, $19, $0B, 4

.lrz1door7N	dc.w 1-1
	obf 0, 0, $19, $07, 4

.lrz1door9N	dc.w 1-1
	obf 0, 0, $19, $09, 4

.lrz2halfpipe1N	dc.w 2-1
	obf $2F10, $538, $29, $95, 1
	obf $2F20, $4A0, $2D, $12, 0

.lrz2halfpipe1A	dc.w 1-1
	obf $2F00, $4BC, $14, $01, 0

.lrz2halfpipe2N	dc.w 1-1
	obf $2EE0, $4A0, $2D, $12, 0

.lrz2halfpipe2A	dc.w 1-1
	obf $2E80, $4BC, $14, $01, 0

.lrz2halfpipe3N	dc.w 1-1
	obf 0, 0, $20, $02, 4

.lrz2halfpipe3A	dc.w 1-1
	obf $2F80, $4BC, $14, $01, 0

.sszwindA	dc.w 1-1
	obf 0, 0, $14, $01, 4

.sszsmallplatN	dc.w 1-1
	obf 0, 0, $7E, $00, 4

.mhz1swingN	dc.w 1-1
	obf 0, -$48, $10, $00, 4

.lrz2triple1	dc.w 2-1
	obf $2020, $2A0, $2D, $02, 0
	obf $2060, $260, $2D, $02, 1

.lrz2triple2	dc.w 1-1
	obf $2090, $2A0, $2D, $02, 0


.dez1lightt1N	dc.w 1-1
	obf 0, 0, $57, $00, 4

.dez1lightt2N	dc.w 1-1
	obf 0, 0, $57, $01, 4

.dez1lightt3N	dc.w 1-1
	obf 0, 0, $57, $03, 4

.dez1lightt4N	dc.w 1-1
	obf 0, 0, $57, $07, 4

.dez1lightt5N	dc.w 1-1
	obf 0, 0, $57, $04, 4

.dez1lightt6N	dc.w 1-1
	obf 0, 0, $57, $05, 4

; prepare for a fucking fantastic mess!!!
.fbz1messec1N	dc.w 5-1
	obf $0D5B, $510, $76, $02, 1
	obf $0D64, $4F8, $76, $01, 1
	obf $0D64, $438, $76, $01, 1
	obf $0D5B, $420, $76, $00, 1
	obf $0D04, $4A8, $71, $20, 1

.fbz1messec6N	dc.w 1-1
	obf $0D64, $420, $75, $02, 0

.fbz1messec2N	dc.w 4-1
	obf $0C5F, $510, $76, $02, 0
	obf $0C56, $4F9, $76, $01, 0
	obf $0C56, $437, $76, $01, 0
	obf $0C5F, $41F, $76, $00, 0

.fbz1messec7N	dc.w 1-1
	obf $0C56, $510, $75, $05, 0

.fbz1messec3N	dc.w 4-1
	obf $0CDA, $317, $76, $00, 1
	obf $0CE3, $32F, $76, $01, 1
	obf $0CE3, $3B0, $76, $01, 1
	obf $0CDA, $3C8, $76, $02, 1

.fbz1messec4N	dc.w 9-1
	obf $0B6D, $317, $76, $00, 0
	obf $0B64, $32F, $76, $01, 0
	obf $0B64, $3B0, $76, $01, 0
	obf $0B6D, $3C8, $76, $02, 0
	obf $0B00, $400, $08, $40, 1
	obf $0B00, $440, $08, $40, 1
	obf $0B00, $480, $08, $40, 1
	obf $0B00, $4C0, $08, $40, 1
	obf $0B00, $500, $08, $40, 1

.fbz1messec5N	dc.w 1-1
	obf $0C1A, $317, $75, $03, 0

.fbz1messec8N	dc.w 1-1
	obf $0C1B, $3C8, $75, $04, 0

.fbz1messec9N	dc.w 1-1
	obf 0, 0, $E4, $02, 4

.fbz1messecAN	dc.w 1-1
	obf 0, 0, $CF, $02, 4

.fbz1messec1A	dc.w 1-1
	obf $0D20, $4F8, $71, $00, 0

.fbz1messec5A	dc.w 1-1
	obf $0C60, $4F8, $71, $00, 0

.fbz1messecBA	dc.w 2-1
	obf $0BF0, $4D0, $7E, $00, 0
	obf $0BD9, $4D0, $07, $12, 1
; ---------------------------------------------------------------------------

.soz	dc.w .soz1stblkpush-.soz, 0			; 00 - SOZ1 stupid pushable block at beginning
	dc.w .soz1stblkmovef-.soz, 0			; 01 - SOZ1 stupid solid platform near beginning
	dc.w 0, 0					; 02 -
	dc.w .soz1spiplatmv-.soz, 0			; 03 - SOZ1 gay ass spiked thingamajigger
	dc.w .soz1rock-.soz, 0				; 04 - SOZ1 a rock
	dc.w .soz1stblkmove-.soz, 0			; 05 - SOZ1 stupid solid platform no xflip
	dc.w .SprYH12-.soz, .soz1sprv-.soz		; 06 - SOZ1 change a spring aroung
	dc.w .soz1baadnik-.soz, 0			; 07 - SOZ1 stupid ouch badnik

	dc.w .soz2gayblkmove-.soz, 0			; 08 - SOZ2 annoying start solid platform
	dc.w .SpkH2-.soz, 0				; 09 - SOZ2 annoying spike set
	dc.w .soz2bigspr0-.soz, .SprRV02-.soz		; 0A - SOZ2 large spring vine thing or red spring
	dc.w .soz2stblkstay-.soz, 0			; 0B - SOZ2 stupid solid platform on the way
	dc.w .SpkH2U-.soz, 0				; 0C - SOZ2 annoying spike set moving
	dc.w 0, .soz2platxtra-.soz			; 0D - SOZ2 extra breaking platforms
	dc.w .soz2splathi-.soz, .soz2splatlo-.soz	; 0E - SOZ2 silly platform too high
	dc.w 0, .SprYV02-.soz				; 0F - SOZ2 give extra spring because haard

	dc.w .soz2butt1-.soz, 0				; 10 - SOZ2 annoying button type 1
	dc.w .soz2gate1-.soz, 0				; 11 - SOZ2 annoying gate type 1
	dc.w .soz2butt6-.soz, 0				; 12 - SOZ2 annoying button type 6
	dc.w .soz2gate6-.soz, 0				; 13 - SOZ2 annoying gate type 6
	dc.w .soz2butt2-.soz, 0				; 14 - SOZ2 annoying button type 2
	dc.w .soz2gate2-.soz, 0				; 15 - SOZ2 annoying gate type 2
	dc.w .soz2butt3-.soz, 0				; 16 - SOZ2 annoying button type 3
	dc.w .soz2gate3-.soz, 0				; 17 - SOZ2 annoying gate type 3
	dc.w .soz2butt5-.soz, 0				; 18 - SOZ2 annoying button type 5
	dc.w .soz2gate5-.soz, 0				; 19 - SOZ2 annoying gate type 5
	dc.w .soz2butt7-.soz, 0				; 1A - SOZ2 annoying button type 7
	dc.w .soz2gate7-.soz, 0				; 1B - SOZ2 annoying gate type 7
	dc.w .soz2butt9-.soz, 0				; 1C - SOZ2 annoying button type 9
	dc.w .soz2gate9-.soz, 0				; 1D - SOZ2 annoying gate type 9
	dc.w .soz2buttA-.soz, 0				; 1E - SOZ2 annoying button type A
	dc.w .soz2gateA-.soz, 0				; 1F - SOZ2 annoying gate type A
	dc.w .soz2buttF-.soz, 0				; 20 - SOZ2 annoying button type F
	dc.w .soz2gateF-.soz, 0				; 21 - SOZ2 annoying gate type F

	dc.w .soz1spblockmvhz-.soz, 0			; 22 - SOZ2 spikey kill platform on the way
	dc.w 0, .SpkH2-.soz				; 23 - SOZ1 spike fall
	dc.w .soz1ceilbadnick-.soz, 0			; 24 - SOZ1 bugged badnik
; ---------------------------------------------------------------------------

.soz1stblkpush	dc.w 1-1
	obf 0, 0, $3E, $09, 4

.soz2stblkstay	dc.w 1-1
	obf 0, 0, $42, $00, 4

.soz1stblkmovef	dc.w 1-1
	obf 0, 0, $42, $04, 5

.soz1stblkmove	dc.w 1-1
	obf 0, 0, $42, $04, 4

.soz2gayblkmove	dc.w 1-1
	obf 0, 0, $42, $05, 4

.soz1spiplatmv	dc.w 1-1
	obf 0, 0, $42, $24, 4

.soz1rock	dc.w 1-1
	obf 0, 0, $44, $00, 4

.soz1sprv	dc.w 1-1
	obf -8, 8, $07, $02, 5

.soz1baadnik	dc.w 1-1
	obf 0, 0, $94, $40, 4

.soz2bigspr0	dc.w 1-1
	obf $1718, $378, $3F, $00, 0

.soz2platxtra	dc.w 1-1
	obf 0, 0, $0F, $04, 4

.soz2splathi	dc.w 1-1
	obf 0, 0, $42, $21, 4

.soz2splatlo	dc.w 1-1
	obf 0, $40, $42, $21, 4

.soz1spblockmvhz dc.w 1-1
	obf 0, 0, $42, $13, 4

.soz1ceilbadnick dc.w 1-1
	obf 0, 0, $96, $73, 4


.soz2butt1	dc.w 1-1
	obf 0, 0, $45, $01, 4

.soz2gate1	dc.w 1-1
	obf 0, 0, $46, $01, 4

.soz2butt2	dc.w 1-1
	obf 0, 0, $45, $02, 4

.soz2gate2	dc.w 1-1
	obf 0, 0, $46, $02, 4

.soz2butt3	dc.w 1-1
	obf 0, 0, $45, $03, 4

.soz2gate3	dc.w 1-1
	obf 0, 0, $46, $13, 4

.soz2butt5	dc.w 1-1
	obf 0, 0, $45, $05, 4

.soz2gate5	dc.w 1-1
	obf 0, 0, $46, $05, 4

.soz2butt6	dc.w 1-1
	obf 0, 0, $45, $06, 4

.soz2gate6	dc.w 1-1
	obf 0, 0, $46, $06, 4

.soz2butt7	dc.w 1-1
	obf 0, 0, $45, $07, 4

.soz2gate7	dc.w 1-1
	obf 0, 0, $46, $07, 4

.soz2butt9	dc.w 1-1
	obf 0, 0, $45, $19, 4

.soz2gate9	dc.w 1-1
	obf 0, 0, $46, $19, 4

.soz2buttA	dc.w 1-1
	obf 0, 0, $45, $0A, 4

.soz2gateA	dc.w 1-1
	obf 0, 0, $46, $0A, 4

.soz2buttF	dc.w 1-1
	obf 0, 0, $45, $1F, 4

.soz2gateF	dc.w 1-1
	obf 0, 0, $46, $1F, 4
; ---------------------------------------------------------------------------
