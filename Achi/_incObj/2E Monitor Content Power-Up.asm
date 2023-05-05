; ---------------------------------------------------------------------------
; Object 2E - contents of monitors
; ---------------------------------------------------------------------------

PowerUp:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Pow_Index(pc,d0.w),d1
		jsr	Pow_Index(pc,d1.w)
	NEXT_OBJ
; ===========================================================================
Pow_Index:	dc.w Pow_Main-Pow_Index
		dc.w Pow_Move-Pow_Index
		dc.w Pow_Delete-Pow_Index
; ===========================================================================

Pow_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.w	#$680,obGfx(a0)
		move.b	#$24,obRender(a0)
	display		3, a0

		move.b	#8,obActWid(a0)
		move.w	#-$300,obVelY(a0)
		moveq	#0,d0
		move.b	obAnim(a0),d0	; get subtype
		addq.b	#2,d0
		move.b	d0,obFrame(a0)	; use correct frame
		movea.l	#Map_Monitor,a1
		add.b	d0,d0
		adda.w	(a1,d0.w),a1
		addq.w	#2,a1
		move.l	a1,obMap(a0)

Pow_Move:	; Routine 2
		tst.w	obVelY(a0)	; is object moving?
		bpl.w	Pow_Checks	; if not, branch
		bsr.w	SpeedToPos
		addi.w	#$18,obVelY(a0)	; reduce object	speed
		rts
; ===========================================================================

Pow_Checks:
		addq.b	#2,obRoutine(a0)
		move.w	#29,obTimeFrame(a0) ; display icon for half a second

Pow_ChkEggman:
		move.b	obAnim(a0),d0
		cmpi.b	#1,d0		; does monitor contain Eggman?
		bne.s	Pow_ChkSonic
		rts			; Eggman monitor does nothing
; ===========================================================================

Pow_ChkSonic:
		cmpi.b	#2,d0		; does monitor contain Sonic?
		bne.s	Pow_ChkShoes

	ExtraLife:
		addq.b	#1,(v_lives).w	; add 1 to the number of lives you have
		addq.b	#1,(f_lifecount).w ; update the lives counter
		cmp.b	#42,v_lives.w	; check for the meaning
		bne.s	@nolife
	ac	ac_life,a6

@nolife		music	Mus_Egor,0,0,0	; play extra life music
		jmp	UpdateSRAM.w
; ===========================================================================

Pow_ChkShoes:
		cmpi.b	#3,d0		; does monitor contain speed shoes?
		bne.s	Pow_ChkShield

		move.b	#1,(v_shoes).w	; speed up the BG music
		move.w	#$4B0,(v_player+$34).w	; time limit for the power-up
		move.w	#$C00,(v_sonspeedmax).w ; change Sonic's top speed
		move.w	#$18,(v_sonspeedacc).w	; change Sonic's acceleration
		move.w	#$80,(v_sonspeeddec).w	; change Sonic's deceleration
	ac	ac_Speed,a6
		music	Mus_ShoesOn,0,0,0		; Speed	up the music
		jmp	UpdateSRAM.w
; ===========================================================================

Pow_ChkShield:
		cmpi.b	#4,d0		; does monitor contain a shield?
		bne.s	Pow_ChkInvinc

		tst.b	v_shield.w	; check if there is a shield
		bne.s	@c		; if is, branch
		st	v_shield.w	; give Sonic a shield
		jsr	FindFreeObj
		move.l	#ShieldItem,(a1); load shield object ($38)
@c		music	sfx_Shield,1,0,0	; play shield sound
; ===========================================================================

Pow_ChkInvinc:
		cmpi.b	#5,d0		; does monitor contain invincibility?
		bne.w	Pow_ChkRings
	ac	ac_Invins,a6

		move.w	#28*60,(v_player+$32).w ; time limit for the power-up
		tst.b	v_invinc.w	; check if there is a shield
		beq.s	@doinvin	; if bot, branch
	ac	ac_dbinvin,a6
		bra.s	@invinok

@doinvin	st	(v_invinc).w	; make Sonic invincible
		jsr	FindFreeObj
		move.l	#Shi_Stars,(a1) ; load stars object ($3801)
		move.b	#1,obAnim(a1)
		jsr	FindFreeObj
		move.l	#Shi_Stars,(a1)
		move.b	#2,obAnim(a1)
		jsr	FindFreeObj
		move.l	#Shi_Stars,(a1)
		move.b	#3,obAnim(a1)
		jsr	FindFreeObj
		move.l	#Shi_Stars,(a1)
		move.b	#4,obAnim(a1)

@invinok	jsr	UpdateSRAM.w
		tst.b	(f_lockscreen).w ; is boss mode on?
		bne.s	Pow_NoMusic	; if yes, branch
			cmpi.w	#$C,(v_air).w
			bls.s	Pow_NoMusic

;	if safe=1
;		cmp.l	#Pray_Patches,mVctMus.w
;	else
;		cmp.l	#Pray_Patches|$0B000000,mVctMus.w
;	endif
;		beq.s	Pow_NoMusic		; branch if already playing
		music	Mus_Egor,0,0,0		; play invincibility music
; ===========================================================================

Pow_NoMusic:
		rts
; ===========================================================================

Pow_ChkRings:
		cmpi.b	#6,d0		; does monitor contain 10 rings?
		bne.w	Pow_ChkS

	ac	ac_Rings1,a6
	ac	ac_Rings10,a6
		addi.w	#10,(v_rings).w	; add 10 rings to the number of rings you have
		ori.b	#1,(f_ringcount).w ; update the ring counter
		cmpi.w	#100,(v_rings).w ; check if you have 100 rings
		bcs.s	Pow_RingSound
	ac	ac_Rings100,a6

		bset	#1,(v_lifecount).w
		beq.w	ExtraLife
		cmpi.w	#200,(v_rings).w ; check if you have 200 rings
		bcs.s	Pow_RingSound
		bset	#2,(v_lifecount).w
		beq.w	ExtraLife

	Pow_RingSound:
		jsr	UpdateSRAM.w
		music	sfx_RingRight,1,0,0	; play ring sound
; ===========================================================================

Pow_ChkS:
	;	cmpi.b	#7,d0		; does monitor contain 'S'?
	;	bne.s	Pow_ChkEnd
	;	nop

Pow_ChkEnd:
		rts			; 'S' and goggles monitors do nothing
; ===========================================================================

Pow_Delete:	; Routine 4
		subq.w	#1,obTimeFrame(a0)
		bmi.w	DeleteObject	; delete after half a second
		rts
