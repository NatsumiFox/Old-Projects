; --------------------------------------------------------------------------------
; Sprite mappings - output from SonMapEd - Sonic 1 format
; --------------------------------------------------------------------------------

Cards:	
		dc.w Cards_GHZ-Cards, Cards_LZ-Cards	
		dc.w Cards_MZ-Cards, Cards_SLZ-Cards	
		dc.w Cards_SYZ-Cards, Cards_SBZ-Cards	
		dc.w Cards_FZ-Cards, Cards_18C-Cards	
		dc.w Cards_197-Cards, Cards_198-Cards	
		dc.w Cards_1A3-Cards, Cards_1A4-Cards	
Cards_GHZ:      dc.b $C	;  GREEN HILL | ICY MOUNTAIN
                dc.b $F8, 1, 0, $20, $80	; I
		dc.b $F8, 5, 0, 8, $88		; C
		dc.b $F8, 5, 0, $4A, $98	; Y
		dc.b $F8, 0, 0, $56, $A8	; Space
		dc.b $F8, 5, 0, $2A, $B8	; M
		dc.b $F8, 5, 0, $32, $C8	; O
		dc.b $F8, 5, 0, $46, $D8	; U
		dc.b $F8, 5, 0, $2E, $E8	; N
		dc.b $F8, 5, 0, $42, $F8	; T
		dc.b $F8, 5, 0, 0, $8		; A
		dc.b $F8, 1, 0, $20, $18	; I
		dc.b $F8, 5, 0, $2E, $20	; N	
Cards_LZ:	dc.b $D	;  Labyrinth | HIDDEN PALACE	
		dc.b $F8, 5, 0, $1C, $8C	; H
		dc.b $F8, 1, 0, $20, $9C	; I
		dc.b $F8, 5, 0, $0C, $A4	; D
		dc.b $F8, 5, 0, $0C, $B4	; D
		dc.b $F8, 5, 0, $10, $C4	; E
		dc.b $F8, 5, 0, $2E, $D4	; N
		dc.b $F8, 0, 0, $56, $E4	; Space
		dc.b $F8, 5, 0, $36, $F4	; P
		dc.b $F8, 5, 0, 0, $4		; A
		dc.b $F8, 5, 0, $26, $14	; L
		dc.b $F8, 5, 0, 0, $24		; A
		dc.b $F8, 5, 0, 8, $34		; C
		dc.b $F8, 5, 0, $10, $44	; E	
Cards_MZ:	dc.b $B	
		dc.b $F8, 5, 0, $10, $9C	
		dc.b $F8, 5, 0, $18, $AC	
		dc.b $F8, 5, 0, $18, $BC	
		dc.b $F8, 0, 0, $56, $CC	
		dc.b $F8, 5, 0, $C, $DC	
		dc.b $F8, 5, 0, $46, $EC	
		dc.b $F8, 5, 0, $2E, $FC	
		dc.b $F8, 5, 0, $18, $C	
		dc.b $F8, 5, 0, $10, $1C	
		dc.b $F8, 5, 0, $32, $2C	
		dc.b $F8, 5, 0, $2E, $3C	
Cards_SLZ:	dc.b $D	;  STAR LIGHT | HIDDEN PALACE	
		dc.b $F8, 5, 0, $1C, $8C	; H
		dc.b $F8, 1, 0, $20, $9C	; I
		dc.b $F8, 5, 0, $0C, $A4	; D
		dc.b $F8, 5, 0, $0C, $B4	; D
		dc.b $F8, 5, 0, $10, $C4	; E
		dc.b $F8, 5, 0, $2E, $D4	; N
		dc.b $F8, 0, 0, $56, $E4	; Space
		dc.b $F8, 5, 0, $36, $F4	; P
		dc.b $F8, 5, 0, 0, $4		; A
		dc.b $F8, 5, 0, $26, $14	; L
		dc.b $F8, 5, 0, 0, $24		; A
		dc.b $F8, 5, 0, 8, $34		; C
		dc.b $F8, 5, 0, $10, $44	; E	
Cards_SYZ:	dc.b 9	
		dc.b $F8, 5, 0, 8, $C4	
		dc.b $F8, 1, 0, $20, $D4	
		dc.b $F8, 5, 0, $42, $DC	
		dc.b $F8, 5, 0, $4A, $EC	
		dc.b $F8, 0, 0, $56, $FC	
		dc.b $F8, 5, 0, $3A, $C	
		dc.b $F8, 5, 0, $46, $1C	
		dc.b $F8, 5, 0, $3E, $2C	
		dc.b $F8, 5, 0, $1C, $3C	
Cards_SBZ:	dc.b $A	
		dc.b $F8, 5, 0, $3E, $AC	
		dc.b $F8, 5, 0, 8, $BC	
		dc.b $F8, 5, 0, $3A, $CC	
		dc.b $F8, 5, 0, 0, $DC	
		dc.b $F8, 5, 0, $36, $EC	
		dc.b $F8, 5, 0, 4, $C	
		dc.b $F8, 5, 0, $3A, $1C	
		dc.b $F8, 5, 0, 0, $2C	
		dc.b $F8, 1, 0, $20, $3C	
		dc.b $F8, 5, 0, $2E, $44	
Cards_FZ:	dc.b 4	
		dc.b 0, 5, 0, $4E, $E0	
		dc.b 0, 5, 0, $32, $F0	
		dc.b 0, 5, 0, $2E, 0	
		dc.b 0, 5, 0, $10, $10	
Cards_18C:	dc.b 2	
		dc.b $5C, $C, 0, $53, $24	
		dc.b $4C, 2, 0, $57, $44	
Cards_197:	dc.b 0	
Cards_198:	dc.b 2	
		dc.b $5C, $C, 0, $53, $24	
		dc.b $4C, 6, 0, $5A, $40	
Cards_1A3:	dc.b 0	
Cards_1A4:	dc.b 7	
		dc.b $F8, 5, 0, 8, $DC	
		dc.b $F8, 5, 0, $32, $EC	
		dc.b $F8, 5, 0, $2E, $FC	
		dc.b $F8, 5, 0, $42, $C	
		dc.b $F8, 5, 0, $3A, $1C	
		dc.b $F8, 5, 0, $32, $2C	
		dc.b $F8, 5, 0, $26, $3C	
		even