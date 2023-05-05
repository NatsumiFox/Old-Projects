Boss_Wall_CurDelay =	yvel
Boss_Wall_Delay =	xvel
Boss_Wall_StartDelay =	(60*3)+15	; 3 sec
Boss_Wall_VSOff =	routine
Boss_Wall_Hits =	tile
Boss_Wall_Spike =	oboff1C
Boss_Wall_Child =	yrad
Verti_Scroll_Buffer2 =	Chunk_table+$8000
Boss_Wall_SpikeSpeeds =	Chunk_table+$8000+80
Boss_Wall_SpikeMap =	Chunk_table+$8000+80+(4*16)
; ---------------------------------------------------------------------------
Boss_Wall:
	if debug=1
		sf	Level_Lag_Crash.w
	endif

		moveq	#(80/4)-1,d0
		move.l	VScroll_Factor_FG.w,d1	; get scroll factor
		lea	Verti_Scroll_Buffer.w,a1
		lea	Verti_Scroll_Buffer2.w,a2
.setlp		move.l	d1,(a1)+
		move.l	d1,(a2)+
		dbf	d0,.setlp

		move.l	#Boss_Wall_Wait,(a0)
		move.w	#Boss_Wall_StartDelay,Boss_Wall_CurDelay(a0)
		move.w	#Boss_Wall_StartDelay,Boss_Wall_Delay(a0)
		move.l	#Boss_Wall_Hint,HInt_Addr.w	; set H-int address
		move.w	#5,Boss_Wall_Hits(a0)		; set hits count
		move.b	#$68,Hint_Counter_Reserve+1.w	; set H-int lines

		cmpi.l	#HudTailsIconMain,Obj_player_2.w; check if p2 obj
		bne.s	Boss_Wall_Wait			; if not, branch
		clr	Obj_player_2+parent.w		; next obj will delete it
		move.l	#HudTailsIconOut,Obj_player_2.w	; move icon out

Boss_Wall_Wait:
		subq.w	#1,Boss_Wall_Delay(a0)		; sub 1 from delay
		bpl.s	Boss_Wall_Vscroll_RTS		; if delay isnt over, branch
		move.w	Camera_X.w,d0
	;	not.w	d0
		and.w	#$3C,d0				; check if camera X is inbetween a section
		bne.w	Boss_Wall_Vscroll_RTS		; if not, branch
		cmp.w	#-10,Boss_Wall_Delay(a0)	; check if warn delay is over
		bgt.s	Boss_Wall_Vscroll_RTS		; but if not, wait still

		bchg	#7,height(a0)			; change which side is moving
		st	FreezePlaneA.w			; if delay is over, freeze fg
		move.w	#4,SpecialFX_Routine.w		; enable vscroll
		move.w	#$8014,VDP_control_port		; enable H-int
		move.l	#Boss_Wall_Wait2,(a0)
; ---------------------------------------------------------------------------

Boss_Wall_VScroll:
		lea	Verti_Scroll_Buffer.w,a2
		lea	Verti_Scroll_Buffer2.w,a1; get buffers
		tst.b	height(a0)		; check if left or right
		bpl.s	.right
		; left size
		moveq	#0,d0
		move.b	Boss_Wall_VSOff(a0),d0	; get scroll offset
		bsr.s	.dohalf			; do the first halve
		moveq	#0,d0
		bra.s	.dohalf			; do the second halve

.right		moveq	#0,d0
		bsr.s	.dohalf			; do the first halve
		moveq	#0,d0
		move.b	Boss_Wall_VSOff(a0),d0	; get scroll offset

.dohalf		move.l	VScroll_Factor_FG.w,d1	; get scroll factor
		move.l	d1,d2			; copy

		swap	d0
		add.l	d0,d1			; add offset
		sub.l	d0,d2			; sub offset

		moveq	#(80/8)-1,d0
.halfloop	move.l	d1,(a1)+
		move.l	d2,(a2)+
		dbf	d0,.halfloop

Boss_Wall_Vscroll_RTS:
		rts
; ---------------------------------------------------------------------------

Boss_Wall_MoveOb:
		move.w	Camera_X.w,d0
		tst.b	height(a0)		; check if left or right
		bmi.s	.xok			; if left, x is ok
		add.w	#(320/2)+80,d0		; add screen half

.xok		move.w	Boss_Wall_Child(a0),a1	; get children
		move.w	Boss_Wall_Child+2(a0),a2
		move.w	Boss_Wall_Child+4(a0),a3
		move.w	Boss_Wall_Child+6(a0),a4
		move.w	Boss_Wall_Spike(a0),a5	; get spike
		move.w	d0,xpos(a1)		; set xposes
		move.w	d0,xpos(a3)
		add.w	#320/4,d0		; set the next objects
		move.w	d0,xpos(a2)
		move.w	d0,xpos(a4)

		moveq	#0,d2
		move.b	Boss_Wall_VSOff(a0),d2	; get offset
		move.w	Camera_Y.w,d0
		move.w	d0,d1
		add.w	d2,d0			; add offset
		sub.w	d2,d1			; add offset
		add.w	#240-12,d1		; add screen half to it

		move.w	d1,ypos(a1)		; set yposes
		move.w	d1,ypos(a2)
		move.w	d0,ypos(a3)
		move.w	d0,ypos(a4)
		sub.w	#64,d1
		move.w	d1,ypos(a5)		; set spike y-pos

Boss_Wall_MVSpike:
		move.w	Boss_Wall_Spike(a0),a5	; get spike
		move.w	xpos(a5),oboff30(a5)	; copy xpos of spikes

Boss_Wall_MoveOb_RTS:
		rts
; ---------------------------------------------------------------------------
	dc.b $30
Boss_Wall_SpikeSub:
	dc.b $20, $20, $10, $10, $00, $00
	even
; ---------------------------------------------------------------------------

Boss_Wall_Wait2:
		bsr.w	Boss_Wall_VScroll		; process vscroll
		subq.b	#1,Boss_Wall_VSOff(a0)
		cmp.b	#-4,Boss_Wall_VSOff(a0)
		bne.s	Boss_Wall_MoveOb_RTS

		move.l	#Boss_Wall_AfterSpawn,(a0)
		tst.b	height(a0)			; check if left or right
		bpl.s	Boss_Wall_AfterSpawn		; if right, skip
		subq.w	#1,Boss_Wall_Hits(a0)		; sub 1 from the hits

		; load spikes object every other time
		jsr	CreateObjectAfter.w		; load next free object
		bne.s	Boss_Wall_AfterSpawn		; if none could be, branch

		move.w	Boss_Wall_Hits(a0),d0		; get target subtype
		move.b	Boss_Wall_SpikeSub(pc,d0.w),subtype(a1); set subtype
		move.w	a1,Boss_Wall_Spike(a0)		; save child offset
		move.l	#Obj_Spikes,(a1)		; set object type
		move.w	Camera_Y.w,d0			; set y-pos of object
		add.w	#240-48-32,d0			; align to ground
		move.w	d0,ypos(a1)

		move.w	Camera_X.w,d0			; get camera x-pos
		add.w	#320+$40,d0			; put spikes behind the camera
		move.w	d0,xpos(a1)			; set the xpos
; ---------------------------------------------------------------------------

Boss_Wall_AfterSpawn:
		bsr.w	Boss_Wall_VScroll		; process vscroll
		bsr.w	Boss_Wall_MVSpike
		subq.w	#1,Boss_Wall_Delay(a0)		; sub 1 from delay
		cmp.w	#-80,Boss_Wall_Delay(a0)	; check if warn delay is over
		bgt.s	Boss_Wall_MoveOb_RTS		; but if not, wait still

		moveq	#$FFFFFF81,d0
		jsr	PlaySFX.w			; play boss mouth
		move.l	#Boss_Wall_MoveIn,(a0)

		; load 4 solid objects
		moveq	#4-1,d1
		lea	Boss_Wall_Child(a0),a2		; get child ptr

.loadloop	jsr	CreateObjectAfter.w		; load next free object
		bne.s	Boss_Wall_MoveIn		; if none could be, branch
		move.w	a1,(a2)+			; save child offset
		move.l	#Obj_InvisSolidBlock,(a1)	; set as invisible solid object
		move.b	#$95,subtype(a1)		; w=80px h=48px
		st	shireact(a1)			; no hurt
		dbf	d1,.loadloop			; loop until done
; ---------------------------------------------------------------------------

Boss_Wall_MoveIn:
		cmp.b	#4,Object_RAM+routine.w
		bne.s	.nodel
		move.w	Boss_Wall_Child+4(a0),a1
		jsr	DeleteObject_A1.w
		move.w	Boss_Wall_Child+6(a0),a1
		jsr	DeleteObject_A1.w
		clr.l	Boss_Wall_Child+4(a0)

.nodel		bsr	Boss_Wall_MoveOb
		bsr.w	Boss_Wall_VScroll		; process vscroll
		addq.b	#4,Boss_Wall_VSOff(a0)		; scroll a bit
		cmp.b	#$38,Boss_Wall_VSOff(a0)
		blt.w	Boss_Wall_RTS			; if scroll isnt over, branch

		bsr.w	Boss_Wall_SetHurtYes
		cmp.b	#$44,Boss_Wall_VSOff(a0)
		blo.w	Boss_Wall_RTS			; if scroll isnt over, branch
		move.l	#Boss_Wall_MoveOut,(a0)
		bsr	Boss_Wall_SetHurtNo

		tst.b	height(a0)			; check if left or right
		bpl.s	Boss_Wall_MoveOut		; if right, skip
		moveq	#$6E,d0; $9B
		jsr	PlaySFX.w			; play boss hurt sfx
		bsr.w	Boss_Wall_KillSpike		; put spike into fragments
		tst.w	Boss_Wall_Hits(a0)		; check hits left
		bmi.w	Boss_Wall_Defeat		; branch if defeated
; ---------------------------------------------------------------------------

Boss_Wall_MoveOut:
		bsr.w	Boss_Wall_MoveOb
		bsr.w	Boss_Wall_VScroll		; process vscroll
		subq.b	#4,Boss_Wall_VSOff(a0)		; scroll back
		bne.s	Boss_Wall_RTS

		move.l	#Boss_Wall_WaitA,(a0)
		move.w	#$C,SpecialFX_Routine.w		; disable hscroll
		move.w	#$8004,VDP_control_port		; disable H-int
		sub.w	#15,Boss_Wall_CurDelay(a0)	; sub from delay
		move.w	Boss_Wall_CurDelay(a0),Boss_Wall_Delay(a0); reset delay

		; delete children
		move.w	Boss_Wall_Child(a0),a1
		jsr	DeleteObject_A1.w
		move.w	Boss_Wall_Child+2(a0),a1
		jsr	DeleteObject_A1.w
		move.w	Boss_Wall_Child+4(a0),a1
		jsr	DeleteObject_A1.w
		move.w	Boss_Wall_Child+6(a0),a1
		jsr	DeleteObject_A1.w

		and.b	#%01010111,Object_RAM+status.w	; clear standing and pushing bits
		and.b	#%01010111,Obj_player_2+status.w; stop standing on objects you bitch
		st	Object_RAM+anilast.w		; clear ani
		st	Obj_player_2+anilast.w
; ---------------------------------------------------------------------------

Boss_Wall_WaitA:
		bsr	Boss_Wall_MVSpike
		move.w	Camera_X.w,d0
	;	neg.w	d0
		and.w	#$3C,d0				; check if camera X is inbetween a section
		bne.s	Boss_Wall_RTS			; if not, branch
		sf	FreezePlaneA.w			; unfreeze fg
		move.l	#Boss_Wall_Wait,(a0)

Boss_Wall_RTS:
		rts
; ---------------------------------------------------------------------------

Boss_Wall_SetHurtYes:
		moveq	#0,d0
		bra.s	Boss_Wall_SetHurtCom

Boss_Wall_SetHurtNo:
		moveq	#0,d0
		moveq	#-1,d0

Boss_Wall_SetHurtCom:
		lea	Boss_Wall_Child(a0),a1
		moveq	#4-1,d1

.lp		move.w	(a1)+,a2
		move.b	d0,shireact(a2)
		dbf	d1,.lp
		rts
; ---------------------------------------------------------------------------

Boss_Wall_Defeat:
		move.l	#Boss_Wall_Defeat,(a0)
		subq.b	#1,Boss_Wall_VSOff(a0)	; scroll back
		bpl.s	.k
		sf	Boss_Wall_VSOff(a0)

		move.w	AutoScroll_EndX,d0
		sub.w	#$30,d0
		cmp.w	Camera_X.w,d0
		bge.s	.noexit
		move.w	Camera_X.w,d0
	;	neg.w	d0
		and.w	#$3C,d0			; check if camera X is inbetween a section
		bne.w	.noexit			; if not, branch
		move.w	#$C,SpecialFX_Routine.w	; disable hscroll
		clr.w	Lvl_AutoScroll_Routine.w
		move.w	#$8004,VDP_control_port	; disable H-int
		jmp	DeleteObject_This.w

.noexit		; delete children
		move.w	Boss_Wall_Child(a0),a1
		cmp.w	#Obj_InvisSolidBlock_Normal,2(a1)
		bne.s	.k2			; if deleted already, branch
		jsr	DeleteObject_A1.w
		move.w	Boss_Wall_Child+2(a0),a1
		jsr	DeleteObject_A1.w
		move.w	Boss_Wall_Child+4(a0),a1
		jsr	DeleteObject_A1.w
		move.w	Boss_Wall_Child+6(a0),a1
		jsr	DeleteObject_A1.w

		and.b	#%01010111,Object_RAM+status.w	; clear standing and pushing bits
		and.b	#%01010111,Object_RAM+status.w	; stop standing on objects you bitch
		st	Object_RAM+anilast.w		; clear ani
		st	Obj_player_2+anilast.w

		move.w	#$C,SpecialFX_Routine.w	; disable hscroll
.k		bsr.w	Boss_Wall_MoveOb
.k2		bsr.w	Boss_Wall_VScroll	; process vscroll

		subq.b	#1,Boss_Wall_CurDelay(a0)
		bpl.s	.np
		move.b	#4-1,Boss_Wall_CurDelay(a0)
		moveq	#$FFFFFFB4,d0
		jsr	PlaySFX.w				; play explosion sfx

.np		jsr	CreateObjectAfter.w
		bne.s	.rts
		move.l	#Obj_Explosion,(a1)	; set as explosion obj
		move.b	#6,routine(a1)
		st	tile(a1)		; set high plane
		jsr	Randomnumber.w		; get random number
		move.w	d0,d1
		lsr.w	#7,d1
		and.w	#$F,d1
		and.w	#$7F,d0
		add.w	Camera_X.w,d0		; add camera x to xpos
		move.w	d0,xpos(a1)		; set xpos

		move.w	Camera_Y.w,d0
		add.w	d1,d0
		bchg	#0,height(a0)
		beq.s	.up
		add.w	#240-12-48-8,d0
		sub.b	Boss_Wall_VSOff(a0),d0
		move.w	d0,ypos(a1)
		rts

.up		add.w	#48-8,d0
		add.b	Boss_Wall_VSOff(a0),d0
		move.w	d0,ypos(a1)
.rts		rts
; ---------------------------------------------------------------------------

Boss_Wall_KillSpike:
	if debug=1
		sf	Level_Lag_Crash.w
	endif
		move.l	a0,a6			; store current object
		; first we create fake mappings
		move.w	Boss_Wall_Spike(a0),a0
		moveq	#0,d0
		move.b	frame(a0),d0		; get object mappings frame
		add.w	d0,d0			; double it
		movea.l	mappings(a0),a3		; get mappings ptr
		adda.w	(a3,d0.w),a3		; get actual pointer
		move.w	(a3)+,d1		; get sprite count
		subq.w	#1,d1			; sub 1 for dbf

		moveq	#0,d0			; sprite pieces counter
		moveq	#3,d5			; prepare tile count
		lea	Boss_Wall_SpikeMap+2.w,a1
.writeloop	move.b	(a3)+,d2		; get y-pos
		addq.w	#1,a3			; skip repeat count
		move.w	(a3)+,d3		; get art tile
		move.w	(a3)+,d4		; get x-pos

		addq.w	#1,d0			; add 1 tile
		moveq	#2-1,d6			; repeat count

.writeDualRow	move.b	d2,(a1)+		; set y-pos
		move.b	d5,(a1)+		; set tile count
		move.w	d3,(a1)+		; set art tile
		move.w	d4,(a1)+		; set xpos

		addq.w	#4,d3			; increase art tile
		addq.w	#8,d4			; increase xpos
		dbf	d6,.writeDualRow	; loop for all tiles
		dbf	d1,.writeloop		; loop for all pieces
		move.w	d0,d1			; copy
		add.w	d1,d1			; double
		move.w	d1,Boss_Wall_SpikeMap.w	; set the sprite piece count

	; best case: 514
	; worst case: 1348

	; now we generate a speeds table
		lea	Boss_Wall_SpikeSpeeds.w,a2
		move.w	d0,d1			; copy tile amount
		and.w	#$1F,d1			; keep in range
		lsl.w	#2,d1			; multiply by 4
		add.w	d1,a2			; add the offset
		lea	(a2),a1			; get also to a1

		moveq	#0,d3			; for divu
		move.w	#$400,d3		; get final speed to d3
		divu	d1,d3			; get in increments of $400/(pieces/4)
		subq.w	#1,d0			; sub 1 from d0 for dbf
		move.w	#$200,d1		; set default frag speed to 0
		move.w	d1,d2			; set default frag speed to 0
		move.w	#-$280,d4		; set y-speed

.fragspdloop	add.w	d3,d1
		sub.w	d3,d2
		move.w	d1,(a2)+
		move.w	d4,(a2)+
		move.w	d4,-(a1)
		move.w	d2,-(a1)
		dbf	d0,.fragspdloop
	; best case: 422
	; worst case: 1060

		move.l	#Boss_Wall_SpikeBreak,(a0); set spike break routine
		lea	Boss_Wall_SpikeMap.w,a3	; set spike mappings
		lea	Boss_Wall_SpikeSpeeds.w,a4
		jsr	ObjToFragments3.w
		move.l	a6,a0			; restore current object
		clr.w	Boss_Wall_Spike(a0)	; clear the spike address

	if debug=1
		st	Level_Lag_Crash.w
	endif
		rts
	; 102 cycles

	; ObjToFragments3:
	; best case: 896
	; worst case: 3776

	; total:
	; best case: 1934
	; worst case: 6286
; ---------------------------------------------------------------------------

Boss_Wall_SpikeBreak:
		jsr	ObjectMove.w
		addi.w	#$18,yvel(a0)

		move.w	Camera_Y.w,d0
		add.w	#240+16,d0
		cmp.w	ypos(a0),d0
		blo.s	.del

		jmp	DrawSprite.w
.del		jmp	DeleteObject_This.w
; ---------------------------------------------------------------------------

Boss_Wall_Hint:
		movem.l	d0/a5-a6,-(sp)
		lea	VDP_data_port,a6
		lea	Verti_Scroll_Buffer2.w,a5
		move.l	#$40000010,VDP_control_port-VDP_data_port(a6); set to VSRAM write

		moveq	#(80/4)-1,d0		; write 80 bytes (size of VSRAM)
.writeVscroll	move.l	(a5)+,(a6)		; write next entry
		dbf	d0,.writeVscroll	; loop til done
		movem.l	(sp)+,d0/a5-a6
		rte
; ---------------------------------------------------------------------------
Boss_Wall_End:
