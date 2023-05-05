; ---------------------------------------------------------------------------
; Sprite mappings - "SONIC TEAM	PRESENTS" and credits
; ---------------------------------------------------------------------------
Map_Cred:	dc.w @staff-Map_Cred, @gameplan-Map_Cred
		dc.w @program-Map_Cred, @character-Map_Cred
		dc.w @design-Map_Cred, @soundproduce-Map_Cred
		dc.w @soundprogram-Map_Cred, @thanks-Map_Cred
		dc.w @presentedby-Map_Cred, @tryagain-Map_Cred
		dc.w @sonicteam-Map_Cred
@staff:		dc.w $E			 ; SONIC TEAM STAFF
		dc.b $F8, 5, 0,	$2E, $FF, $88
		dc.b $F8, 5, 0,	$26, $FF, $98
		dc.b $F8, 5, 0,	$1A, $FF, $A8
		dc.b $F8, 1, 0,	$46, $FF, $B8
		dc.b $F8, 5, 0,	$1E, $FF, $C0
		dc.b $F8, 5, 0,	$3E, $FF, $D8
		dc.b $F8, 5, 0,	$E, $FF, $E8
		dc.b $F8, 5, 0,	4, $FF, $F8
		dc.b $F8, 9, 0,	8, $00, 8
		dc.b $F8, 5, 0,	$2E, $00, $28
		dc.b $F8, 5, 0,	$3E, $00, $38
		dc.b $F8, 5, 0,	4, $00, $48
		dc.b $F8, 5, 0,	$5C, $00, $58
		dc.b $F8, 5, 0,	$5C, $00, $68
@gameplan:	dc.w $10		; GAME PLAN CAROL YAS
		dc.b $D8, 5, 0,	0, $FF, $80
		dc.b $D8, 5, 0,	4, $FF, $90
		dc.b $D8, 9, 0,	8, $FF, $A0
		dc.b $D8, 5, 0,	$E, $FF, $B4
		dc.b $D8, 5, 0,	$12, $FF, $D0
		dc.b $D8, 5, 0,	$16, $FF, $E0
		dc.b $D8, 5, 0,	4, $FF, $F0
		dc.b $D8, 5, 0,	$1A, $00, 0
		dc.b 8,	5, 0, $1E, $FF, $C8
		dc.b 8,	5, 0, 4, $FF, $D8
		dc.b 8,	5, 0, $22, $FF, $E8
		dc.b 8,	5, 0, $26, $FF, $F8
		dc.b 8,	5, 0, $16, $00, 8
		dc.b 8,	5, 0, $2A, $00, $20
		dc.b 8,	5, 0, 4, $00, $30
		dc.b 8,	5, 0, $2E, $00, $44
@program:	dc.w $A			 ; PROGRAM YU 2
		dc.b $D8, 5, 0,	$12, $FF, $80
		dc.b $D8, 5, 0,	$22, $FF, $90
		dc.b $D8, 5, 0,	$26, $FF, $A0
		dc.b $D8, 5, 0,	0, $FF, $B0
		dc.b $D8, 5, 0,	$22, $FF, $C0
		dc.b $D8, 5, 0,	4, $FF, $D0
		dc.b $D8, 9, 0,	8, $FF, $E0
		dc.b 8,	5, 0, $2A, $FF, $E8
		dc.b 8,	5, 0, $32, $FF, $F8
		dc.b 8,	5, 0, $36, $00, 8
@character:	dc.w $18		 ; CHARACTER DESIGN BIGISLAND
		dc.b $D8, 5, 0,	$1E, $FF, $88
		dc.b $D8, 5, 0,	$3A, $FF, $98
		dc.b $D8, 5, 0,	4, $FF, $A8
		dc.b $D8, 5, 0,	$22, $FF, $B8
		dc.b $D8, 5, 0,	4, $FF, $C8
		dc.b $D8, 5, 0,	$1E, $FF, $D8
		dc.b $D8, 5, 0,	$3E, $FF, $E8
		dc.b $D8, 5, 0,	$E, $FF, $F8
		dc.b $D8, 5, 0,	$22, $00, 8
		dc.b $D8, 5, 0,	$42, $00, $20
		dc.b $D8, 5, 0,	$E, $00, $30
		dc.b $D8, 5, 0,	$2E, $00, $40
		dc.b $D8, 1, 0,	$46, $00, $50
		dc.b $D8, 5, 0,	0, $00, $58
		dc.b $D8, 5, 0,	$1A, $00, $68
		dc.b 8,	5, 0, $48, $FF, $C0
		dc.b 8,	1, 0, $46, $FF, $D0
		dc.b 8,	5, 0, 0, $FF, $D8
		dc.b 8,	1, 0, $46, $FF, $E8
		dc.b 8,	5, 0, $2E, $FF, $F0
		dc.b 8,	5, 0, $16, $00, 0
		dc.b 8,	5, 0, 4, $00, $10
		dc.b 8,	5, 0, $1A, $00, $20
		dc.b 8,	5, 0, $42, $00, $30
@design:	dc.w $14		 ; DESIGN JINYA	PHENIX RIE
		dc.b $D0, 5, 0,	$42, $FF, $A0
		dc.b $D0, 5, 0,	$E, $FF, $B0
		dc.b $D0, 5, 0,	$2E, $FF, $C0
		dc.b $D0, 1, 0,	$46, $FF, $D0
		dc.b $D0, 5, 0,	0, $FF, $D8
		dc.b $D0, 5, 0,	$1A, $FF, $E8
		dc.b 0,	5, 0, $4C, $FF, $E8
		dc.b 0,	1, 0, $46, $FF, $F8
		dc.b 0,	5, 0, $1A, $00, 4
		dc.b 0,	5, 0, $2A, $00, $14
		dc.b 0,	5, 0, 4, $00, $24
		dc.b $20, 5, 0,	$12, $FF, $D0
		dc.b $20, 5, 0,	$3A, $FF, $E0
		dc.b $20, 5, 0,	$E, $FF, $F0
		dc.b $20, 5, 0,	$1A, $00, 0
		dc.b $20, 1, 0,	$46, $00, $10
		dc.b $20, 5, 0,	$50, $00, $18
		dc.b $20, 5, 0,	$22, $00, $30
		dc.b $20, 1, 0,	$46, $00, $40
		dc.b $20, 5, 0,	$E, $00, $48
@soundproduce:	dc.w $1A		 ; SOUND PRODUCE MASATO	NAKAMURA
		dc.b $D8, 5, 0,	$2E, $FF, $98
		dc.b $D8, 5, 0,	$26, $FF, $A8
		dc.b $D8, 5, 0,	$32, $FF, $B8
		dc.b $D8, 5, 0,	$1A, $FF, $C8
		dc.b $D8, 5, 0,	$54, $FF, $D8
		dc.b $D8, 5, 0,	$12, $FF, $F8
		dc.b $D8, 5, 0,	$22, $00, 8
		dc.b $D8, 5, 0,	$26, $00, $18
		dc.b $D8, 5, 0,	$42, $00, $28
		dc.b $D8, 5, 0,	$32, $00, $38
		dc.b $D8, 5, 0,	$1E, $00, $48
		dc.b $D8, 5, 0,	$E, $00, $58
		dc.b 8,	9, 0, 8, $FF, $88
		dc.b 8,	5, 0, 4, $FF, $9C
		dc.b 8,	5, 0, $2E, $FF, $AC
		dc.b 8,	5, 0, 4, $FF, $BC
		dc.b 8,	5, 0, $3E, $FF, $CC
		dc.b 8,	5, 0, $26, $FF, $DC
		dc.b 8,	5, 0, $1A, $FF, $F8
		dc.b 8,	5, 0, 4, $00, 8
		dc.b 8,	5, 0, $58, $00, $18
		dc.b 8,	5, 0, 4, $00, $28
		dc.b 8,	9, 0, 8, $00, $38
		dc.b 8,	5, 0, $32, $00, $4C
		dc.b 8,	5, 0, $22, $00, $5C
		dc.b 8,	5, 0, 4, $00, $6C
@soundprogram:	dc.w $17		 ; SOUND PROGRAM JIMITA	MACKY
		dc.b $D0, 5, 0,	$2E, $FF, $98
		dc.b $D0, 5, 0,	$26, $FF, $A8
		dc.b $D0, 5, 0,	$32, $FF, $B8
		dc.b $D0, 5, 0,	$1A, $FF, $C8
		dc.b $D0, 5, 0,	$54, $FF, $D8
		dc.b $D0, 5, 0,	$12, $FF, $F8
		dc.b $D0, 5, 0,	$22, $00, 8
		dc.b $D0, 5, 0,	$26, $00, $18
		dc.b $D0, 5, 0,	0, $00, $28
		dc.b $D0, 5, 0,	$22, $00, $38
		dc.b $D0, 5, 0,	4, $00, $48
		dc.b $D0, 9, 0,	8, $00, $58
		dc.b 0,	5, 0, $4C, $FF, $D0
		dc.b 0,	1, 0, $46, $FF, $E0
		dc.b 0,	9, 0, 8, $FF, $E8
		dc.b 0,	1, 0, $46, $FF, $FC
		dc.b 0,	5, 0, $3E, $00, 4
		dc.b 0,	5, 0, 4, $00, $14
		dc.b $20, 9, 0,	8, $FF, $D0
		dc.b $20, 5, 0,	4, $FF, $E4
		dc.b $20, 5, 0,	$1E, $FF, $F4
		dc.b $20, 5, 0,	$58, $00, 4
		dc.b $20, 5, 0,	$2A, $00, $14
@thanks:	dc.w $1F		 ; SPECIAL THANKS FUJIO	MINEGISHI PAPA
		dc.b $D8, 5, 0,	$2E, $FF, $80
		dc.b $D8, 5, 0,	$12, $FF, $90
		dc.b $D8, 5, 0,	$E, $FF, $A0
		dc.b $D8, 5, 0,	$1E, $FF, $B0
		dc.b $D8, 1, 0,	$46, $FF, $C0
		dc.b $D8, 5, 0,	4, $FF, $C8
		dc.b $D8, 5, 0,	$16, $FF, $D8
		dc.b $D8, 5, 0,	$3E, $FF, $F8
		dc.b $D8, 5, 0,	$3A, $00, 8
		dc.b $D8, 5, 0,	4, $00, $18
		dc.b $D8, 5, 0,	$1A, $00, $28
		dc.b $D8, 5, 0,	$58, $00, $38
		dc.b $D8, 5, 0,	$2E, $00, $48
		dc.b 0,	5, 0, $5C, $FF, $B0
		dc.b 0,	5, 0, $32, $FF, $C0
		dc.b 0,	5, 0, $4C, $FF, $D0
		dc.b 0,	1, 0, $46, $FF, $E0
		dc.b 0,	5, 0, $26, $FF, $E8
		dc.b 0,	9, 0, 8, $00, 0
		dc.b 0,	1, 0, $46, $00, $14
		dc.b 0,	5, 0, $1A, $00, $1C
		dc.b 0,	5, 0, $E, $00, $2C
		dc.b 0,	5, 0, 0, $00, $3C
		dc.b 0,	1, 0, $46, $00, $4C
		dc.b 0,	5, 0, $2E, $00, $54
		dc.b 0,	5, 0, $3A, $00, $64
		dc.b 0,	1, 0, $46, $00, $74
		dc.b $20, 5, 0,	$12, $FF, $F8
		dc.b $20, 5, 0,	4, $00, 8
		dc.b $20, 5, 0,	$12, $00, $18
		dc.b $20, 5, 0,	4, $00, $28
@presentedby:	dc.w $F			 ; PRESENTED BY	SEGA
		dc.b $F8, 5, 0,	$12, $FF, $80
		dc.b $F8, 5, 0,	$22, $FF, $90
		dc.b $F8, 5, 0,	$E, $FF, $A0
		dc.b $F8, 5, 0,	$2E, $FF, $B0
		dc.b $F8, 5, 0,	$E, $FF, $C0
		dc.b $F8, 5, 0,	$1A, $FF, $D0
		dc.b $F8, 5, 0,	$3E, $FF, $E0
		dc.b $F8, 5, 0,	$E, $FF, $F0
		dc.b $F8, 5, 0,	$42, $00, 0
		dc.b $F8, 5, 0,	$48, $00, $18
		dc.b $F8, 5, 0,	$2A, $00, $28
		dc.b $F8, 5, 0,	$2E, $00, $40
		dc.b $F8, 5, 0,	$E, $00, $50
		dc.b $F8, 5, 0,	0, $00, $60
		dc.b $F8, 5, 0,	4, $00, $70
@tryagain:	dc.w 8			 ; TRY AGAIN
		dc.b $30, 5, 0,	$3E, $FF, $C0
		dc.b $30, 5, 0,	$22, $FF, $D0
		dc.b $30, 5, 0,	$2A, $FF, $E0
		dc.b $30, 5, 0,	4, $FF, $F8
		dc.b $30, 5, 0,	0, $00, 8
		dc.b $30, 5, 0,	4, $00, $18
		dc.b $30, 1, 0,	$46, $00, $28
		dc.b $30, 5, 0,	$1A, $00, $30
@sonicteam:	dc.w $11		 ; SONIC TEAM PRESENTS
		dc.b $E8, 5, 0,	$2E, $FF, $B4
		dc.b $E8, 5, 0,	$26, $FF, $C4
		dc.b $E8, 5, 0,	$1A, $FF, $D4
		dc.b $E8, 1, 0,	$46, $FF, $E4
		dc.b $E8, 5, 0,	$1E, $FF, $EC
		dc.b $E8, 5, 0,	$3E, $00, 4
		dc.b $E8, 5, 0,	$E, $00, $14
		dc.b $E8, 5, 0,	4, $00, $24
		dc.b $E8, 9, 0,	8, $00, $34
		dc.b 0,	5, 0, $12, $FF, $C0
		dc.b 0,	5, 0, $22, $FF, $D0
		dc.b 0,	5, 0, $E, $FF, $E0
		dc.b 0,	5, 0, $2E, $FF, $F0
		dc.b 0,	5, 0, $E, $00, 0
		dc.b 0,	5, 0, $1A, $00, $10
		dc.b 0,	5, 0, $3E, $00, $20
		dc.b 0,	5, 0, $2E, $00, $30
		even
