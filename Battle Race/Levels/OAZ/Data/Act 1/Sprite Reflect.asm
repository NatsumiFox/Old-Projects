; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to make reflection sprites for the floor in OAZ 1
; ---------------------------------------------------------------------------
FloorDist	=	$0040
MeshDist	=	$0080
; ---------------------------------------------------------------------------

SpriteReflect:
		cmpi.w	#$0E00,(Current_zone_and_act).w		; is this OAZ1?
		bne.w	SR_Finish				; if not, branch
		move.w	#OAZ1_ReflectPos,d5			; get distance the camera is from the collision floor
		sub.w	(Camera_Y_pos_copy).w,d5		; ''
		bmi.s	SR_Reflect				; if the screen is low enough, branch
		cmpi.w	#$0040,d5				; is the screen low enough to need sprites set as high plane?
		bhs.s	SR_Finish				; if not, branch

	; --- Without reflection (just high plane setting) ---

		addi.w	#224,d5					; advance to bottom where the reflection should be
		addi.w	#$0080,d5				; add VDP void space (for sprites)
		move.w	d5,d4					; copy to d2 for the check
		subi.w	#MeshDist,d4				; get distance from the mesh before sprites can be set as high plane
		moveq	#$00,d7					; load number of sprites in the table
		move.b	(Sprites_drawn).w,d7			; ''
		subq.w	#$01,d7					; minus 1 for dbf
		bmi.w	SR_Finish				; if there are no sprites, branch
		lea	(Sprite_table_buffer-8).w,a6		; load sprite table address

SR_NextPlane:
		addq.w	#$08,a6					; advance to next sprite
		move.w	(a6),d0					; load Y position
		cmp.w	d0,d4					; is this sprite in rnage to be reflected?
		bhs.s	SR_NoPlane				; if not, branch
		ori.w	#$8000,$04(a6)				; force sprite to high plane

SR_NoPlane:
		dbf	d7,SR_NextPlane				; repeat for all sprites loaded to table

SR_Finish:
		rts						; return
		
	; --- With reflection ---

SR_Reflect:
		addi.w	#224,d5					; advance to bottom where the reflection should be
		addi.w	#$0080,d5				; add VDP void space (for sprites)
		move.w	d5,d4					; copy to d2 for the check
		subq.w	#$01<<$02,d5				; applying the addq.w #$01,d1 to d5, so the instruction isn't needed
		move.l	#$F0000000,d3				; prepare VDP pattern index flip bits (for the reflection)
		subi.w	#FloorDist,d4				; get distance from the floor before sprites can be reflected
		moveq	#$00,d7					; load number of sprites in the table
		move.b	(Sprites_drawn).w,d7			; ''
		moveq	#$50,d6					; load total number of sprites possible
		sub.w	d7,d6					; get remaining sprite slots available
		beq.s	SR_Finish				; if there are no slots free, don't bother
		subq.w	#$01,d6					; minus 1 for dbf
		move.w	d7,d0					; copy number of sprites to d0
		subq.w	#$01,d7					; minus 1 for dbf
		bmi.s	SR_Finish				; if there are no sprites, branch
		lsl.w	#$03,d0					; multiply by size of a sprite slot
		lea	(Sprite_table_buffer-6).w,a6		; load sprite table address
		lea	$06(a6,d0.w),a5				; load next free sprite slot

SR_NextSprite:
		addq.w	#$06,a6					; advace to next sprite slot

SR_CheckSprite:
		move.w	(a6)+,d0				; load Y position
		cmp.w	d0,d4					; is this sprite in rnage to be reflected?
		bhs.s	SR_NoRange				; if not, branch
		move.b	(a6),d2					; load shape
		move.b	d2,d1					; copy to d1
		andi.w	#$0003,d1				; get only Y size of shape
		add.w	d1,d1					; multiply by 8 then divide by 2
		add.w	d1,d1					; ''
		sub.w	d5,d1					; add floor position
		add.w	d1,d0					; subtract floor position (using add as it's negative)
		neg.w	d0					; reverse position
		bmi.s	SR_NoRange				; if the sprite will be above the line, branch
		sub.w	d1,d0					; add floor position back (using sub as it's negative)
		move.w	d0,(a5)+				; save Y position
		move.b	d2,(a5)+				; write shape
		addq.w	#$02,a6					; skip over priority link
		addq.w	#$01,a5					; ''
		ori.w	#$8000,(a6)				; force the sprite above the floor to be high plane
		move.l	(a6)+,d0				; load VDP pattern index and X position
		eor.l	d3,d0					; flip the sprite upside-down, change its palette, and make it low plane
		move.l	d0,(a5)+				; save VDP pattern index and X position
		subq.w	#$01,d6					; decrease remaining slots counter
		bmi.s	SR_ReflectFinish			; if finished, branch
		dbf	d7,SR_CheckSprite			; repeat for all sprites

SR_ReflectFinish:
		rts						; return

SR_NoRange:
		dbf	d7,SR_NextSprite			; repeat for all sprites
		rts						; return

; ===========================================================================