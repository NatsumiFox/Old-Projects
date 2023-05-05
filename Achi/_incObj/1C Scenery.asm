; ---------------------------------------------------------------------------
; Object 1C - scenery (GHZ bridge stump, SLZ lava thrower)
; ---------------------------------------------------------------------------

Scenery:
		move.l	#Scen_ChkDel,(a0)
		ori.b	#4,obRender(a0)
		subq.b	#3,obSubtype(a0)
		blt.s	@3

		move.l	#Map_Scen,obMap(a0)
		move.w	#$44D8,obGfx(a0)
		move.b	#8,obActWid(a0)
	display		2, a0
		bra.s	Scen_ChkDel

@3
		addq.b	#1,obFrame(a0)		; $01
		move.b	#$10,obActWid(a0)	; $10
		move.l	#Map_Bri,obMap(a0)
		move.w	#$438E,obGfx(a0)
	display		1, a0

Scen_ChkDel:	; Routine 2
		out_of_range	DeleteObject2
	NEXT_OBJ

Act4Teleporter:
		move.b	v_vbla_byte.w,d0
		and.b	#$1F,d0
		bne.s	@nopts
		cmp.w	#$3D0,v_player+ObY.w
		blt.s	@nopts

		bsr.w	FindFreeObj
		move.l	#Points,(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)

		move.w	v_vbla_word.w,d0
		lsr.w	#5,d0
		and.b	#3,d0
		move.b	d0,obFrame(a1)

@nopts		tst.b	obRoutine(a0)
		bne.s	@collect
		move.b	#$47,obColType(a0)
		move.b	#$80,obRender(a0)	; HAX
		jsr	AddToCollList
	NEXT_OBJ

@collect	move.b	#3,v_act.w
		st.b	f_restart.w
		sf	v_lastlamp.w
	ac	ac_SecAct,a6
		jmp	DeleteObject2(pc)
