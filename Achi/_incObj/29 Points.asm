; ---------------------------------------------------------------------------
; Object 29 - points that appear when you destroy something
; ---------------------------------------------------------------------------

Points:
		move.l	#Map_Poi,obMap(a0)
		move.w	#$2000|($F520/32),obGfx(a0)
		move.b	#4,obRender(a0)
	display		1, a0
		move.b	#8,obActWid(a0)
		move.w	#-$300,obVelY(a0) ; move object upwards
		move.l	#Poi_Slower,(a0)

Poi_Slower:	; Routine 2
		tst.w	obVelY(a0)	; is object moving?
		bpl.w	DeleteObject2	; if not, delete
		bsr.w	SpeedToPos
		addi.w	#$18,obVelY(a0)	; reduce object	speed
	NEXT_OBJ
