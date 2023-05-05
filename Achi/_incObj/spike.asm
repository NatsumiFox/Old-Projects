; ----------------------------------------------------------------------------
; Object 17 - GHZ rotating log helix spikes
; the programming of this was modified somewhat between Sonic 1 and Sonic 2
; ----------------------------------------------------------------------------
; Sprite_10310:
Obj_SpikedLog:
	move.l	#Obj_SpikedLog_MapUnc_10452,mappings(a0)
	move.w	#make_art_tile(ArtTile_ArtNem_GHZ_Spiked_Log,2,0),art_tile(a0)
	move.b	#$44,render_flags(a0)
	move.w	#$180,priority(a0)
	move.w	y_pos(a0),d2
	move.w	x_pos(a0),d3
	moveq	#0,d1
	move.b	subtype(a0),d1
	move.b	d1,mainspr_childsprites(a0)
	lea	sub2_x_pos(a0),a2	; move helix length to a2
	move.w	d1,d0
	lsr.w	#1,d0
	lsl.w	#4,d0
	move.b	d0,mainspr_width(a0)
	sub.w	d0,d3
	move.w	d3,d5
	subq.b	#1,d1
	bcs.s	Obj_SpikedLog_MakeSpike
	moveq	#0,d6
	move.b	(Logspike_anim_frame).w,d6
; loc_10372:
Obj_SpikedLog_MakeHelix:
	move.w	d3,(a2)+		; subN_x_pos
	move.w	d2,(a2)+		; subN_y_pos
	move.w	d6,(a2)+		; subN_mapframe
	addi.w	#$10,d3
	addq.w	#1,d6
	andi.w	#7,d6
	dbf	d1,Obj_SpikedLog_MakeHelix ; repeat d1 times (helix length)
	move.l	#Obj_SpikedLog_MakeSpike,id(a0)	; Keep trying to make spike

Obj_SpikedLog_MakeSpike:
	jsr	(SingleObjLoad2).l
	bne.s	+
	move.w	a1,objoff_48(a0)
	move.l	#Obj_SpikedLog_RotateSpike,id(a1) ; load Obj_SpikedLog
	move.w	d2,y_pos(a1)
	move.w	d5,objoff_38(a1)
	moveq	#8,d0
	sub.b	(Logspike_anim_frame).w,d0
	andi.w	#7,d0
	lsl.w	#4,d0
	add.w	d0,d5
	move.w	d5,x_pos(a1)
	move.l	mappings(a0),mappings(a1)
	move.w	#make_art_tile(ArtTile_ArtNem_GHZ_Spiked_Log,2,0),art_tile(a1)
	move.b	#4,render_flags(a1)
	move.w	#$180,priority(a1)
	move.b	#8,width_pixels(a1)
	move.b	#$84,collision_flags(a1)	; make object harmful
	move.l	#Obj_SpikedLog_Main,id(a0)	; Stop trying to make the spike
+

; loc_103E8: Obj_SpikedLog_Action:
Obj_SpikedLog_Main:
	moveq	#0,d6
	move.b	mainspr_childsprites(a0),d6
	subq.w	#1,d6
	bcs.s	+	; rts
	lea	sub2_x_pos(a0),a1
	move.b	(Logspike_anim_frame).w,d0

-	move.b	d0,sub2_mapframe-sub2_x_pos(a1)
	addq.b	#1,d0
	andi.b	#7,d0
	adda.w	#next_subspr,a1
	dbf	d6,-
+
	move.w	x_pos(a0),d0
	andi.w	#$FF80,d0
	sub.w	(Camera_X_pos_coarse).w,d0
	cmpi.w	#$280,d0
	bhi.w	Obj_SpikedLog_DelAll
	move.w	#$180,d0
	jmp	(DisplaySprite3).l
; ===========================================================================
; loc_10404:
Obj_SpikedLog_DelAll:
	move.w	objoff_48(a0),d1
	beq.s	+
	movea.w	d1,a1
	move.l	#DeleteObject,id(a1)	; delete object
+
	markObj_gone
	jmp	(DeleteObject).l

; ===========================================================================
; loc_1044A:
Obj_SpikedLog_RotateSpike:
	move.w	objoff_38(a0),d3
	moveq	#8,d0
	sub.b	(Logspike_anim_frame).w,d0
	andi.w	#7,d0
	lsl.w	#4,d0
	add.w	d0,d3
	move.w	d3,x_pos(a0)
	jsr	(DisplaySprite).l
	jmp	(Add_Sprite_To_Collision_Response).l
; ===========================================================================
; -----------------------------------------------------------------------------
; sprite mappings - helix of spikes on a pole (GHZ) (unused)
; -----------------------------------------------------------------------------
Obj_SpikedLog_MapUnc_10452:	BINCLUDE "mappings/sprite/optimized/obj17.bin"
; ===========================================================================
