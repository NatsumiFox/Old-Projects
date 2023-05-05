; ---------------------------------------------------------------------------
; Animation script - Tails
; ---------------------------------------------------------------------------
		dc.w TailAni_Walk-TailsAniData
		dc.w tailAni_Run-TailsAniData
		dc.w TailAni_Roll-TailsAniData
		dc.w TailAni_Roll2-TailsAniData
		dc.w TailAni_Push-TailsAniData
		dc.w TailAni_Wait-TailsAniData
		dc.w TailAni_Balance-TailsAniData
		dc.w TailAni_LookUp-TailsAniData
		dc.w TailAni_Duck-TailsAniData
		dc.w TailAni_Warp1-TailsAniData
		dc.w TailAni_Warp2-TailSAniData
		dc.w TailAni_Warp3-TailsAniData
		dc.w TailAni_Warp4-TailsAniData
		dc.w TailAni_Stop-TailsAniData
		dc.w TailAni_Float1-TailsAniData
		dc.w TailAni_Float2-TailsAniData
		dc.w TailAni_Spring-TailsAniData
		dc.w TailAni_LZHang-TailsAniData
		dc.w TailAni_Leap1-TailsAniData
		dc.w TailAni_Leap2-TailsAniData
		dc.w TailAni_Surf-TailsAniData
		dc.w TailAni_Bubble-TailsAniData
		dc.w TailAni_Death1-TailsAniData
		dc.w TailAni_Drown-TailsAniData
		dc.w TailAni_Death2-TailsAniData
		dc.w TailAni_Shrink-TailsAniData
		dc.w TailAni_Hurt-TailsAniData
		dc.w TailAni_LZSlide-TailsAniData
		dc.w TailAni_Blank-TailsAniData
		dc.w TailAni_Float3-TailsAniData
		dc.w TailAni_Float4-TailsAniData
                dc.w TailAni_Spdsh-TailsAniData	; 20
                dc.w TailAni_SPO-TailsAniData	; 20
		dc.w TailAni_Sprinting-TailsAniData	; 21
		dc.w TailAni_SPO_Underwater-TailsAniData
                dc.w TailAni_Springs-TailsAniData
TailAni_Walk:	dc.b $FF, 6, 7,	8, 9, $A, $B, $FF
TailAni_Run:	dc.b $FF, $1E, $1F, $20, $21, $FF, $FF,	$FF
TailAni_Roll:	dc.b $FE, $2E, $2F, $30, $31, $32, $FF,	$FF
TailAni_Roll2:	dc.b $FE, $2E, $2F, $32, $30, $31, $32,	$FF
TailAni_Push:	dc.b $FD, $45, $46, $47, $48, $FF, $FF,	$FF
TailAni_Wait:	dc.b $17, 1, 1,	1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 3, 2, 2, 2, 3, 4, $FE, 2, 0
TailAni_Balance:	dc.b $1A, $5E, $5F, $60, $61, $FF
TailAni_LookUp:	dc.b $3F, 5, $FF, 0
TailAni_Duck:	dc.b $3F, $39, $FF, 0
TailAni_Warp1:	dc.b $3F, $33, $FF, 0
TailAni_Warp2:	dc.b $3F, $34, $FF, 0
TailAni_Warp3:	dc.b $3F, $35, $FF, 0
TailAni_Warp4:	dc.b $3F, $36, $FF, 0
TailAni_Stop:	dc.b 7,	$37, $38, $FF
TailAni_Float1:	dc.b 7,	$3C, $3F, $FF
TailAni_Float2:	dc.b 7,	$3C, $3D, $53, $3E, $54, $FF, 0
TailAni_Spring:	dc.b $2F, $40, $FD, 0
TailAni_LZHang:	dc.b 4,	$41, $42, $FF
TailAni_Leap1:	dc.b 3,	$72, $73, $74, $75, $76,$72, $73,$74, $75, $76,$72, $73, $74, $FD, 0
TailAni_Leap2:	dc.b $F, $43, $44, $FE,	1, 0
TailAni_Surf:	dc.b $3F, $49, $FF, 0
TailAni_Bubble:	dc.b $B, $56, $56, $A, $B, $FD,	0, 0
TailAni_Death1:     dc.b 3, 3, $4E, $4E, $4F, $4F, $50, $50, $51, $52, 0, $FE, 1, 0
;TailAni_Death1:    dc.b $20, $4B, $FF, 0

TailAni_Drown:      dc.b $2F, $4C, $FF, 0

TailAni_Death2:     dc.b 3, 3, $4E, $4E, $4F, $4F, $50, $50, $51, $52, 0, $FE, 1, 0
;TailAni_Death2:    dc.b 3, $4D, $FF, 0

TailAni_Shrink:     dc.b 3, $4E, $4F, $50, $51, $52, 0, $FE, 1, 0
TailAni_Hurt:	dc.b 3,	$55, $FF, 0
TailAni_LZSlide: dc.b 7, $55, $57, $FF
TailAni_Blank:	dc.b $77, 0, $FD, 0
TailAni_Float3:	dc.b 3,	$3C, $3D, $53, $3E, $54, $FF, 0
TailAni_Float4:	dc.b 3,	$3C, $FD, 0
TailAni_Spdsh: dc.b 0, $58, $59, $58, $5A, $58, $5B, $58, $5C, $58, $5D, $FF
TailAni_SPO:	dc.b 1, 8, 8, 9, 9, $A, $A, $B, $B, 6, 6, 7, 7, 8, 9, $1E, $1F, $20, $21, $1E, $1F, $20, $21, $62, $63, $64, $65, $FE, 4
TailAni_Sprinting:	dc.b $FF,$62, $63, $64, $65,$FF,$FF,$FF,$FF,$FF
TailAni_SPO_Underwater:dc.b  1, 8, 8, 9, 9, $A, $A, $B, $B, 6, 6, 7, 7, 8, 9, $A, $B, 6, 7, $1E, $1F, $20, $21, $1E, $1F,$FE, 4, 0
TailAni_Springs: dc.b 3, $6E, $6F, $70, $71, $72, $FF
		even