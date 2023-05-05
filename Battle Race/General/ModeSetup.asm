; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to process custom init codes for each game mode
; in:
;   d1 - Level + Act ID
; out:
;   d0 - And value to OptionsBits
;   d1 - Or value to OptionsBits
;   d7 - Music ID to play
; ---------------------------------------------------------------------------

LevelMusic_Playlist:
	dc.b Mus_AIZ1, Mus_AIZ2	; AIZ
	dc.b Mus_HCZ1, Mus_HCZ2	; HCZ
	dc.b Mus_MGZ1, Mus_MGZ2	; MGZ
	dc.b Mus_CNZ1, Mus_CNZ2	; CNZ
	dc.b Mus_FBZ1, Mus_FBZ2	; FBZ
	dc.b Mus_ICZ1, Mus_ICZ2	; ICZ
	dc.b Mus_LBZ1, Mus_LBZ2	; LBZ
	dc.b Mus_MHZ1, Mus_MHZ2	; MHZ
	dc.b Mus_SOZ1, Mus_SOZ2	; SOZ
	dc.b Mus_LRZ1, Mus_LRZ2	; LRZ
	dc.b Mus_SSZ,  Mus_SSZ	; SSZ
	dc.b Mus_DEZ1, Mus_DEZ2	; DEZ
	dc.w $00, $00
	dc.b Mus_Continue, Mus_Continue; OAZ
	dc.w [7] $00
	dc.b Mus_Boss, Mus_LRZ2	; LRZ/HPZ
	dc.b $00, Mus_LRZ2	; DEZ3

InitGameMode:
		clr.b	SpecialEnemyFlag.w	; disable special enemy flag
		moveq	#0,d0
		move.b	PlayMode.w,d0		; NAT: Get game mode
		move.w	.modes(pc,d0.w),d0	; get offsetr
		jmp	.modes(pc,d0.w)		; call routine

; ---------------------------------------------------------------------------
.modes		dc.w .m_br-.modes		; 0 - Battle Race
		dc.w .m_tm-.modes		; 2 - team mode
		dc.w .m_tb-.modes		; 4 - Tag Battle
		dc.w .m_mg-.modes		; 4 - Minigames
; ---------------------------------------------------------------------------

.m_br		bsr.s	.levelmusic				; initialize level music
		move.l	#ModeTbl_BattleRace,ModeTable.w		; set mode table address

.brextra2	clr.l	RNG_seed.w				; clear RNG seed
		bsr.s	.initbr
		bra.s	.brextra				; set box angle
; ---------------------------------------------------------------------------

.m_tb		bsr.s	.levelmusic				; initialize level music
		move.w	#Tag_Time,TagTimer.w			; NAT: Reset tag timer
		move.w	#Tag_Time,TagTimer2.w			; NAT: ''
		move.b	#Tag_Cool,TagCool.w			; NAT: reset the cooldown

		jsr	Random_Number.w				; NAT: Get random number
		add.w	EMM_Random+2,d0				; NAT: Extra random
		and.b	#1,d0					; NAT: Get only bit 1
		addq.b	#1,d0					; NAT: increse by 1 by 1
		move.b	d0,TagWinner.w				; NAT: Set player mode.
		clr.b	BoxValidAngle.w				; NAT: Rendering thing, remove!!!

.brextra	moveq	#$EF,d0					; OPT AND EF (no bounce pls)
		moveq	#0,d1					; OPT OR 0
; ---------------------------------------------------------------------------

.extra		st.b	(BoxAngleFrame).w			; MJ: set frame angle to an invalid value (ensures it'll update first time)
		move.b	#$80,(BoxWinnerFrame).w			; MJ2: set box winner frame to something invalid
		clr.l	(HudPos).w
		clr.b	MonContPos.w
		clr.b	SwapNum.w				; NAT: Clear swap num
		clr.b	SpawnWait.w				; NAT: Clear spawn wait time
		rts
; ---------------------------------------------------------------------------

.levelmusic	lea	LevelMusic_Playlist(pc),a1
		move.b	(a1,d1.w),d7
		add.w	d1,d1
		rts
; ---------------------------------------------------------------------------

.initbr		lea	LevelSpawnBoxes(pc),a1
		move.w	(a1,d1.w),SpawnBoxPos.w

		add.w	d1,d1
		lea	LevelRanges(pc),a1
		move.l	(a1,d1.w),a1

		move.l	a1,BoxLoc_Level.w
		addq.l	#8,a1
		move.l	a1,BoxLoc_Play1.w
		move.l	a1,BoxLoc_Play2.w
		move.b	#$40,(BoxAngle).w			; MJ: set default angle

		jsr	Random_Number.w				; NAT: Get random number
		add.w	EMM_Random+2,d0				; NAT: Extra random
		and.w	#$F,d0					; NAT: And by number of scripts
		lea	DD_Arrow2Anim,a1			; NAT: Normal arrow animation data
		add.w	d0,d0					; NAT: Double ID
		move.w	(a1,d0.w),d0				; NAT: get offset
		add.w	d0,a1					; NAT: Get the actual position
		move.l	a1,BoxArr2Script.w			; NAT: Save script
		rts
; ---------------------------------------------------------------------------

.m_tm		bsr.s	.levelmusic				; initialize level music
		clr.b	MiniTimer.w
		clr.w	MiniTimer+1.w
		clr.w	DisplayTimer.w

	if demorecord
		move.l	#$200004,GhostAddress.w		; set SRAM start as the ghost address

	else

	endif

		move.l	#ModeTbl_TeamMode,ModeTable.w		; set mode table address
		bra.w	.brextra2
; ---------------------------------------------------------------------------

.m_mg		add.w	d1,d1					; double level
		move.w	.mgtbl(pc,d1.w),d0			; get offset
		jmp	.mgtbl(pc,d0.w)				; jump to appropriate handler
; ---------------------------------------------------------------------------

.mgtbl	dc.w 0, .aiz2-.mgtbl		; AIZ
	dc.w 0, 0			; HCZ
	dc.w 0, 0			; MGZ
	dc.w .cnz1-.mgtbl, 0		; CNZ
	dc.w 0, 0			; FBZ
	dc.w 0, 0			; ICZ
	dc.w .lbz1-.mgtbl, 0		; LBZ
	dc.w 0, 0			; MHZ
	dc.w 0, 0			; SOZ
	dc.w 0, 0			; LRZ
	dc.w .ssz-.mgtbl, 0		; SSZ
	dc.w 0, .dez2-.mgtbl		; DEZ
	dc.w [($16-$0C)*2] 0		; oops
	dc.w 0, .hpz-.mgtbl		; LRZ/HPZ
; ---------------------------------------------------------------------------

.hpz		jsr	Create_New_Sprite
		bne.s	.hpz				; if cant load obj, freeze game!!!
		move.l	#Mini_HPZ_Handler,(a1)		; load CNZ1 handler obj

		moveq	#$10,d0				; OPT AND BOUNCE
		moveq	#0,d1				; OPT OR -
		moveq	#Mus_Credits,d7			; credits theme!

		move.w	#-1,Ctrl_1_locked.w		; lock ctrls
		move.l	#ModeTbl_MiniHPZ,ModeTable.w	; set mode table address
		st	PlayerSpawn.w			; disable respawn
		bra.s	.mini2
; ---------------------------------------------------------------------------

.cnz1		jsr	Create_New_Sprite
		bne.s	.cnz1				; if cant load obj, freeze game!!!
		move.l	#Mini_CNZ1_Handler,(a1)		; load CNZ1 handler obj

		moveq	#$10,d0				; OPT AND BOUNCE
		moveq	#$C,d1				; OPT OR FLOAT + SHIELD MOVES
		moveq	#Mus_MiniCNZ,d7			; CNZ minigame theme!

		move.w	#-1,Ctrl_1_locked.w		; lock ctrls
		move.l	#ModeTbl_MiniCNZ1,ModeTable.w	; set mode table address
		st	PlayerSpawn.w			; disable respawn
		bra.s	.mini2
; ---------------------------------------------------------------------------

.lbz1		bsr.w	.initbr				; initialize battle race mode
		jsr	Create_New_Sprite
		bne.s	.lbz1				; if cant load obj, freeze game!!!
		move.l	#Mini_LBZ1_Handler,(a1)		; load CNZ1 handler obj

		move.l	#ModeTbl_MiniLBZ1,ModeTable.w	; set mode table address
		clr.b	SpecialEnemyCtr.w		; clear enemy count
		moveq	#$1A,d0				; OPT AND BOUNCE + ENDMON + SHIELD MOVES
		moveq	#4,d1				; OPT OR FLOAT
		moveq	#Mus_MiniLBZ,d7			; LBZ minigame theme!

.minien		st	SpecialEnemyFlag.w		; enable special enemy flag
.mini3		move.w	#$303,Ring_count.w		; set 3 rings for both players
.mini2		clr.b	ResultsShown.w			; clear results shown
		bra.w	.extra
; ---------------------------------------------------------------------------

.aiz2		jsr	Create_New_Sprite
		bne.s	.aiz2				; if cant load obj, freeze game!!!
		move.l	#Mini_AIZ2_Handler,(a1)		; load AIZ2 handler obj

		moveq	#$18,d0				; OPT AND BOUNCE + SHIELD MOVES
		moveq	#5,d1				; OPT OR FLOAT + RANDOM
		moveq	#Mus_MiniAIZ,d7			; AIZ2 minigame theme!

		move.l	#ModeTbl_MiniAIZ2,ModeTable.w	; set mode table address
		st	PlayerSpawn.w			; disable respawn
		bra.s	.mini3
; ---------------------------------------------------------------------------

.dez2		move.l	#ModeTbl_MiniDEZ2,ModeTable.w	; set mode table address
		moveq	#Mus_MiniDEZ2,d7		; DEZ2 minigame theme!
		bra.s	.brmini
; ---------------------------------------------------------------------------

.ssz		move.l	#ModeTbl_MiniSSZ,ModeTable.w	; set mode table address
		moveq	#Mus_MiniSSZ,d7			; SSZ minigame theme!

.brmini		clr.b	MiniTimer.w
		move.w	#60,MiniTimer+1.w		; second timer for win

		bsr.w	.initbr				; initialize Battle Race mode
		moveq	#$0D,d0				; OPT AND RANDOM + FLOAT + SHIELD MOVES
		moveq	#0,d1				; OPT OR -
		bra.s	.mini2

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to do special level init codes for each mode
; in:
;   d0 - Level + Act ID
; out:
;   a0 - Level data array
;   a1 - Start position array
; ---------------------------------------------------------------------------

LevelSize_MainMode:
		lea	(Sonic_Start_Locations).l,a1
		lea	(a1,d0.w),a1
		add.w	d0,d0			; double offset
		lea	LevelSizes(pc,d0.w),a0
		rts
; ---------------------------------------------------------------------------
;			xstart	xend	ystart	yend	; Level
LevelSizes:	dc.w	$1308,	$6000,	$0,	 $390 	; AIZ1
		dc.w	$0,	$4640,	$0,	 $590	; AIZ2
		dc.w	$0,	$6000,	$0,	$1000	; HCZ1
		dc.w	$0,	$6000,	$0,	$1000	; HCZ2
		dc.w	$0,	$6000,	-$100,	$1000	; MGZ1
		dc.w	$0,	$6000,	$0,	$1000	; MGZ2
		dc.w	$0,	$6000,	$0,	 $B20	; CNZ1
		dc.w	$0,	$6000,	$580,	$1000	; CNZ2
		dc.w	$0,	$2E60,	$0,	 $B00	; FBZ1
		dc.w	$0,	$6000,	$0,	 $B00	; FBZ2
		dc.w	$0,	$7000,	-$100,	 $800	; ICZ1
		dc.w	$0,	$7000,	$0,	 $B20	; ICZ2
		dc.w	$0,	$6000,	$0,	$1000	; LBZ1
		dc.w	$0,	$6000,	$0,	 $B20	; LBZ2
		dc.w	$0,	$4298,	$0,	 $AA0	; MHZ1
		dc.w	$98,	$3C90,	$620,	 $9A0	; MHZ2
		dc.w	$0,	$4310,	$0,	 $B20	; SOZ1
		dc.w	$0,	$6000,	-$100,	 $800	; SOZ2
		dc.w	$0,	$2CC0,	$0,	 $B20	; LRZ1
		dc.w	$940,	$3EC0,	$0,	 $B20	; LRZ2
		dc.w	$0,	$19A0,	-$100,	$1000	; SSZ1
		dc.w	$0,	$6000,	$0,	 $400	; SSZ2
		dc.w	$0,	$6000,	$0,	 $B20	; DEZ1
		dc.w	$0,	$6000,	$0,	 $F10	; DEZ2
		dc.w	$0,	$6000,	$0,	$1000	; DDZ
		dc.w	$0,	$6000,	$0,	$1000	; DDZ
		dc.w	$0,	$6000,	$0,	$1000	; AIZ Intro (?)
		dc.w	$0,	$6000,	$0,	$1000	; Ending scene
		binclude "Levels/OAZ/Data/Act 1/Boundaries.bin"
		binclude "Levels/OAZ/Data/Act 2/Boundaries.bin"
		dc.w	$0,	$12C0,	$200,	 $390	; BPZ
		dc.w	$0,	$12C0,	$200,	 $390	; BPZ
		dc.w	$0,	$12C0,	$100,	 $190	; DPZ
		dc.w	$0,	$12C0,	$100,	 $190	; DPZ
		dc.w	$0,	$12C0,	-$100,	$1000	; CGZ
		dc.w	$0,	$12C0,	$0,	  $90	; CGZ
		dc.w	$0,	$12C0,	$100,	 $190	; EMZ
		dc.w	$0,	$12C0,	$100,	 $190	; EMZ
		dc.w	$60,	  $60,	$0,	 $240	; Gumball
		dc.w	$60,	  $60,	$0,	 $240	; Gumball
		dc.w	$0,	 $140,	$0,	 $F00	; Pachinko
		dc.w	$0,	 $140,	$0,	 $F00	; Pachinko
		dc.w	$0,	$6000,	$0,	$1000	; Slots
		dc.w	$0,	$6000,	$0,	$1000	; Slots
		dc.w	$0,	 $EC0,	$0,	 $430	; LRZ Boss
		dc.w	$0,	$1880,	$0,	 $B20	; HPZ
		dc.w	$0,	$6000,	$20,	  $20	; DEZ Boss
		dc.w	$1500,	$1640,	$320,	 $320	; Special Stage Arena (HPZ)

; ---------------------------------------------------------------------------

LevelSize_MiniCNZ1:
		lea	.size(pc),a0		; level size
		lea	.start(pc),a1		; start pos
		rts
.size		dc.w $31E0, $3260, $2A0, $2A0
.start		dc.w $32B0, $2F0
; ---------------------------------------------------------------------------

LevelSize_MiniAIZ2:
		lea	.size(pc),a0		; level size
		lea	.start(pc),a1		; start pos
		rts
.size		dc.w $1062, $1062, $444, $444
.start		dc.w $1100, $500
; ---------------------------------------------------------------------------

LevelSize_MiniLBZ1:
		lea	.size(pc),a0		; level size
		lea	.start(pc),a1		; start pos
		rts
.size		dc.w $0042, $0042, $A80, $A80
.start		dc.w $00F0, $B2C
; ---------------------------------------------------------------------------

LevelSize_MiniSSZ:
		bsr.s	.random
		lea	.size(pc),a0		; level size
		lea	.start(pc,d0.w),a1	; start pos
		rts

.size		dc.w $1B00, $1DC0, $FF00, $1000
.start		dc.w $1B7C, $5F0		; 0
		dc.w $1EE0, $430		; 1
		dc.w $1D78, $230		; 2
		dc.w $1C90, $0F0		; 3
		dc.w $1CD0, $FB0		; 4
		dc.w $1CD8, $C70		; 5
		dc.w $1B10, $9F0		; 6
		dc.w $1E90, $770		; 7

.random		jsr	Random_Number.w		; get random number
		add.w	EMM_Random+2,d0		; NAT: Extra random
		and.w	#$1C,d0			; get 8 total entries
		clr.l	RNG_seed.w		; clear RNG seed
		rts
; ---------------------------------------------------------------------------

LevelSize_MiniDEZ2:
		bsr.s	LevelSize_MiniSSZ.random
		lea	.size(pc),a0		; level size
		lea	.start(pc,d0.w),a1	; start pos

		cmp.w	#$06*4,d0		; check if this is upsidedown spawn pos
		shs	Reverse_gravity_flag.w	; set as reversed gravity if yes
		rts

.size		dc.w $0300, $1500, $AA0, $F80
.start		dc.w $06E0, $EB0		; 0
		dc.w $0C18, $F30		; 1
		dc.w $0A60, $DF0		; 2
		dc.w $09E8, $FB0		; 3
		dc.w $107C, $E90		; 4
		dc.w $1300, $BB0		; 5

		dc.w $0760, $C10		; 6
		dc.w $04C0, $C10		; 7
; ---------------------------------------------------------------------------

LevelSize_MiniHPZ:
		lea	.size(pc),a0		; level size
		lea	.start(pc),a1		; start pos
		rts
.size		dc.w $17E0, $17E0, $300, $300
.start		dc.w $1880, $3AC
; ---------------------------------------------------------------------------
