
row	macro num,addition
	dc.\0 (num*$50)+addition
	endm

nargchk		macro val
	dc.\0 val-$23
	endm

levSelText	macro
	dc.\0 narg-1

	rept narg
	dc.\0 \1-$23
	shift
	endr

	endm
	
Text	macro
	rept narg
	dc.\0 \1-$23
	shift
	endr

	endm


ArtNem_S22POptions:	incbin 's3l/2P Options.bin'
	even
MapEni_S22POptions:	incbin 's3l/2P Options Enigma.bin'
	even

Pal_SonicTailsS2:	incbin 's3l/SonicAndTailsS2.bin'
	even

ArtUnc_SONICMILES:	incbin 's3l/SONICMILES.bin'
	even

AniPLC_SONICMILES:	dc.w	0
		dc.l	ArtUnc_SONICMILES+$FF000000
		dc.w	$20
		dc.b	6
		dc.b	$A
		dc.b	0, $C7
		dc.b	$A, 5
		dc.b	$14, 5
		dc.b	$1E, $C7
		dc.b	$14, 5
		dc.b	$A,	5
		even

DLC_OffsetTable:
		dc.w 21-1
		row.w 1,6
		row.w 2,6
		row.w 4,6
		row.w 5,6
		row.w 6,6
		row.w 7,6
		row.w 8,6
		row.w 9,6
		row.w 10,6
		row.w 11,6
		row.w 12,6
		row.w 13,6
		row.w 14,6
		row.w 15,6
		row.w 16,6

		row.w 20,6
		row.w 21,8
		row.w 22,8
		row.w 23,8
		row.w 24,8

		row.w 26,38

DLC_TextData:
		levSelText.b 'C','O','N','T','I','N','U','E',$23,'G','A','M','E'
		levSelText.b 'N','E','W',$23,'G','A','M','E'
		levSelText.b 'U','N','L','O','C','K',$23,'T','A','I','L','S'
		levSelText.b 'U','N','L','O','C','K',$23,'K','N','U','C','K','L','E','S'
		levSelText.b 'U','N','L','O','C','K',$23,'S','P','I','N','D','A','S','H'
		levSelText.b 'E','L','E','M','E','N','T','A','L',$23,'S','H','I','E','L','D','S'
		levSelText.b 'E','X','T','E','N','D','E','D',$23,'C','A','M','E','R','A'
		levSelText.b 'A','L','T','E','R','N','A','T','E',$23,'M','U','S','I','C'
		levSelText.b 'L','E','V','E','L',$23,'S','E','L','E','C','T'
		levSelText.b 'T','I','P',$23,'O','F',$23,'T','H','E',$23,'D','A','Y'
		levSelText.b 'E','X','T','R','A',$23,'L','I','F','E'
		levSelText.b 'P','L','A','Y',$23,'A',$23,'B','E','T','T','E','R',$23,'G','A','M','E'
		levSelText.b 'A','I','R',$23,'H','O','R','N',$23,'R','E','M','I','X'
		levSelText.b 'C','O','L','O','R',$23,'D','E','B','U','G',$23,'M','O','D','E'
		levSelText.b 'I',$23,'H','A','Z',$23,'S','E','K','R','I','T','Z'

		levSelText.b 'B','U','Y',$23,'P','O','I','N','T','S',$1C+$23
		levSelText.b '1'+3,'0'+3,$1C+$23,$23,$23,$23,$23,$23,$23,$23,$23,'0'+3,$1D+$23,'7'+3,'9'+3
		levSelText.b '1'+3,'0'+3,'0'+3,$1C+$23,$23,$23,$23,$23,$23,$23,$23,'3'+3,$1D+$23,'9'+3,'9'+3
		levSelText.b '1'+3,'0'+3,'0'+3,'0'+3,$1C+$23,$23,$23,$23,$23,$23,$23,'1'+3,'4'+3,$1D+$23,'9'+3,'9'+3
		levSelText.b '1'+3,'0'+3,'0'+3,'0'+3,'0'+3,'0'+3,'0'+3,'0'+3,'0'+3,$1C+$23,$23,'9'+3,'9'+3,'9'+3,$1D+$23,'9'+3,'9'+3

		levSelText.b 'P','O','I','N','T','S',$1C+$23
		even

DLC_TextDataJP:
		levSelText.b 'C','O','N','T','I','N','U','E',$23,'G','A','M','E'
		levSelText.b 'N','E','W',$23,'G','A','M','E'
		levSelText.b 'U','N','L','O','C','K',$23,'T','A','I','L','S'
		levSelText.b 'U','N','L','O','C','K',$23,'K','N','U','C','K','L','E','S'
		levSelText.b 'U','N','L','O','C','K',$23,'S','P','I','N','D','A','S','H'
		levSelText.b 'E','L','E','M','E','N','T','A','L',$23,'S','H','I','E','L','D','S'
		levSelText.b 'E','X','T','E','N','D','E','D',$23,'C','A','M','E','R','A'
		levSelText.b 'A','L','T','E','R','N','A','T','E',$23,'M','U','S','I','C'
		levSelText.b 'L','E','V','E','L',$23,'S','E','L','E','C','T'
		levSelText.b 'T','I','P',$23,'O','F',$23,'T','H','E',$23,'D','A','Y'
		levSelText.b 'E','X','T','R','A',$23,'L','I','F','E'
		levSelText.b 'P','L','A','Y',$23,'A',$23,'B','E','T','T','E','R',$23,'G','A','M','E'
		levSelText.b 'A','I','R',$23,'H','O','R','N',$23,'R','E','M','I','X'
		levSelText.b 'H','I','D','E',$23,'Y','O','U','R',$23,'E','Y','E','S'
		levSelText.b 'I',$23,'H','A','Z',$23,'S','E','K','R','I','T','Z'

		levSelText.b 'B','U','Y',$23,'P','O','I','N','T','S',$1C+$23
		levSelText.b '1'+3,'0'+3,$1C+$23,$23,$23,$23,$23,$23,$23,$23,$23,'7'+3,'9'+3,'9'+3
		levSelText.b '1'+3,'0'+3,'0'+3,$1C+$23,$23,$23,$23,$23,$23,$23,$23,'3'+3,'9'+3,'9'+3,'9'+3
		levSelText.b '1'+3,'0'+3,'0'+3,'0'+3,$1C+$23,$23,$23,$23,$23,$23,$23,'1'+3,'4'+3,'9'+3,'9'+3,'9'+3
		levSelText.b '1'+3,'0'+3,'0'+3,'0'+3,'0'+3,'0'+3,'0'+3,'0'+3,'0'+3,$1C+$23,$23,'9'+3,'9'+3,'9'+3,'9'+3,'9'+3,'9'+3

		levSelText.b 'P','O','I','N','T','S',$1C+$23
		even

DLC_HighLight:	dc.b	1,   6,	  1, 6
		dc.b	2,   6,	  2, 6

		dc.b	4,   6,	  4, 6
		dc.b	5,   6,	  5, 6
		dc.b	6,   6,	  6, 6
		dc.b	7,   6,	  7, 36
		dc.b	8,   6,	  8, 6
		dc.b	9,   6,	  9, 6
		dc.b   10,   6,	 10, 6
		dc.b   11,   6,	 11, 6
		dc.b   12,   6,	 12, 6
		dc.b   13,   6,	 13, 6
		dc.b   14,   6,	 14, 6
		dc.b   15,   6,	 15, 6
		dc.b   16,   6,	 16, 6

		dc.b   21,   8,	 21, 8
		dc.b   22,   8,	 22, 8
		dc.b   23,   8,	 23, 38
		dc.b   24,   8,	 24, 38
		even

LevSel_HighLight:
		dc.b	1,   6,	  1, $24
		dc.b	1,   6,	  2, $24
		dc.b	1,   6,	  3, $24

		dc.b	5,   6,	  5, $24
		dc.b	5,   6,	  6, $24
		dc.b	5,   6,	  7, $24

		dc.b	9,   6,	  9, $24
		dc.b	9,   6,	 10, $24
		dc.b	9,   6,	 11, $24

		dc.b   13,   6,	 13, $24
		dc.b   13,   6,	 14, $24
		dc.b   13,   6,	 15, $24

		dc.b   17,   6,	 17, $24
		dc.b   17,   6,	 18, $24
		dc.b   17,   6,	 19, $24

		dc.b   21,   6,	 21, $24
		dc.b   21,   6,	 22, $24
		dc.b   21,   6,	 23, $24

		dc.b   25,   6,	 25, $24
		dc.b   26,   6,	 26, $24

		dc.b	1, $2C,	  1, $4A
		dc.b	4, $2C,	  4, $4A
		dc.b	7, $2C,	  7, $4A
		dc.b   $A, $2C,	 $A, $4A
		dc.b   $D, $2C,	 $D, $4A
		dc.b  $10, $2C,	$10, $4A
		dc.b  $13, $2C,	$13, $4A
		dc.b  $16, $2C,	$16, $4A
		dc.b  $19, $2C,	$19, $4A
		dc.b  $1B, $2C,	$1B, $4A
		even

LevSel_OffsetTable:
		dc.w 18-1
		row.w 1,6
		row.w 5,6
		row.w 9,6
		row.w 13,6
		row.w 17,6
		row.w 21,6
		row.w 25,6
		row.w 26,6

		row.w 1,$2C
		row.w 4,$2C
		row.w 7,$2C
		row.w 10,$2C
		row.w 13,$2C
		row.w 16,$2C
		row.w 19,$2C
		row.w 22,$2C
		row.w 25,$2C
		row.w 27,$2C
		even

LevSel_TextData:
		levSelText.b 'G','R','E','E','N',$23,'H','I','L','L'
		levSelText.b 'M','A','R','B','L','E',$23,'H','I','L','L'
		levSelText.b 'S','P','R','I','N','G',$23,'Y','A','R','D'
		levSelText.b 'L','A','B','Y','R','I','N','T','H'
		levSelText.b 'S','T','A','R',$23,'L','I','G','H','T'
		levSelText.b 'S','C','R','A','P',$23,'B','R','A','I','N'
		levSelText.b 'S','O','U','N','D',$23,'T','E','S','T',$23,$23,$1A+$23
		levSelText.b 'M','U','S','I','C',$23,'T','E','S','T',$23,$23,$1A+$23
		levSelText.b 'F','M','1'+3
		levSelText.b 'F','M','2'+3
		levSelText.b 'F','M','3'+3
		levSelText.b 'F','M','4'+3
		levSelText.b 'F','M','5'+3
		levSelText.b 'F','M','6'+3
		levSelText.b 'P','S','G','1'+3
		levSelText.b 'P','S','G','2'+3
		levSelText.b 'P','S','G','3'+3
		levSelText.b 'D','A','C'
		even

LS_Level_Order:		dc.w $0000,$0001,$0002
			dc.w $0200,$0201,$0202
			dc.w $0400,$0401,$0402
			dc.w $0100,$0101,$0102
			dc.w $0300,$0301,$0302
			dc.w $0500,$0501,$0502
			dc.w $F001,$F000
;LevSel_TextData:	dc.b   $B, $1E, $2B, $24, $22, $29,   0, $26, $30, $29, $1E, $2B, $21
;		dc.b	8, $25, $36, $21, $2F, $2C, $20, $26, $31, $36
;		dc.b   $C, $2A, $1E, $2F, $1F, $29, $22,   0, $24, $1E, $2F, $21, $22, $2B
;		dc.b   $D, $20, $1E, $2F, $2B, $26, $33, $1E, $29,   0, $2B, $26, $24, $25, $31
;		dc.b	5, $26, $20, $22, $20, $1E, $2D
;		dc.b   $A, $29, $1E, $32, $2B, $20, $25,   0, $1F, $1E, $30, $22
;		dc.b   $C, $2A, $32, $30, $25, $2F, $2C, $2C, $2A, 0, $25, $26, $29, $29
;		dc.b   $D, $23, $29, $36, $26, $2B, $24,   0, $1F, $1E, $31, $31, $22, $2F, $36
;		dc.b    9, $30, $1E, $2B, $21, $2C, $2D, $2C, $29, $26, $30
;		dc.b    8, $29, $1E, $33, $1E,   0, $2F, $22, $22, $23
;		dc.b    8, $29, $1E, $33, $1E,   0, $2F, $22, $22, $23
;		dc.b   $C, $30, $28, $36,   0, $30, $1E, $2B, $20, $31, $32, $1E, $2F, $36
;		dc.b	7, $21, $22, $1E, $31, $25, $22, $24, $24
;		dc.b   $B, $31, $25, $22,   0, $21, $2C, $2C, $2A, $30, $21, $1E, $36
;		dc.b	4, $1F, $2C, $2B, $32, $30
;		dc.b   $C, $30, $2D, $22, $20, $26, $1E, $29,   0, $30, $31, $1E, $24, $22
;		dc.b   $C, $30, $2C, $32, $2B, $21,   0, $31, $22, $30, $31,   0,   0, $1A
;		even

DLC_TL_Debug:	levSelText.b 'C','D',$23,$23+$1D,$23+$1D,$23+$1D
		even
DLC_TL_Useless:	levSelText.b 'T','H','I','S',$23,'T','I','P',$23,'I','S',$23,'U','S','E','L','E','S','S'
		even
DLC_TL_Waste:	levSelText.b 'S','T','O','P',$23,'W','A','S','T','I','N','G',$23,'M','O','N','E','Y'
		even
DLC_TL_GS:	levSelText.b 'C','R','E','A','T','E','D',$23,'B','Y',$23,'N','A','T','S','U','M','I'
		even
DLC_TL_Stolen:	levSelText.b 'C','R','E','A','T','E','D',$23,'U','S','I','N','G',$23,'S','T','O','L','E','N',$23,'C','O','N','T','E','N','T'
		even
DLC_TL_Left:	levSelText.b 'G','O',$23,'L','E','F','T'
		even
DLC_TL_amusing:	levSelText.b 'I',$23,'A','M',$23,'A','M','U','S','I','N','G'
		even
DLC_TL_Rings:	levSelText.b 'I',$23,'C','O','S','T',$23,'R','I','N','G','S'
		even
DLC_TL_SRSBIZ:	levSelText.b 'S','A','N','I','C',$23,'H','A','X','I','N','G',$23,'I','Z',$23,'S','R','S',$23,'B','I','Z','N','E','Z'
		even
DLC_TL_shrek:	levSelText.b 'T','R','E','N','T',$23,'I','S',$23,'L','O','V','E',$1D+$23,$23,'T','R','E','N','T',$23,'I','S',$23,'L','I','F','E'
		even
DLC_TL_TITS:	levSelText.b 'T','I','T','S',$23,'O','R',$23,'G','T','F','O'
		even
DLC_TL_Wrong:	levSelText.b 'O','O','P','S',$23,'W','R','O','N','G',$23,'N','U','M','B','E','R'
		even
DLC_TL_King:	levSelText.b 'K','I','N','G',$23,'S','H','A','L','T',$23,'B','E',$23,'E','N','T','E','R','T','A','I','N','T'
		even
DLC_TL_Creds:	levSelText.b 'C','R','D','I','T','S',$1C+$23,$23,'M','E'
		even
DLC_TL_YOLO:	levSelText.b 'L','I','E',$23,'I','S',$23,'A',$23,'C','A','K','E'
		even
DLC_TL_Weed:	levSelText.b 'S','M','O','K','E',$23,'P','A','N',$23,'E','V','E','R','Y','D','A','Y'
		even
DLC_TL_Blank:	levSelText.b $1A+$23,'B','L','A','N','K',$1A+$23
		even
DLC_TL_Gender:	levSelText.b 'M','A','Y','O','N','N','A','I','S','E',$23,'I','S',$23,'A',$23,'G','E','N','D','E','R'
		even
DLC_TL_Code:	levSelText.b 'S','C','O','T','T','Y',$23,'C','E','N','A',$23,'S','U','C','K','S'
		even
DLC_TL_lel:	levSelText.b 'L','E','L',$23,'L','E','L',$23,'L','E','L',$23,'L','E','L',$23,'L','E','L',$23,'L','E','L',$23,'L','E','L'
		even
DLC_TL_SHC:	levSelText.b 'S','O','N','I','C',$23,'H','A','C','K','I','N','G',$23,'C','O','N','T','E','S','T',$23,'2'+3,'0'+3,'1'+3,'5'+3
		even
DLC_TL_S3k:	levSelText.b 'N','O','T',$23,'S','O','N','I','C',$23,'3'+3,$23,'K','N','U','C','K','L','E','S'
		even
DLC_TL_LSD:	levSelText.b 'L','S','D',$23,'I','S',$23,'B','A','D',$23,'G','U','I','S'
		even
DLC_TL_Internet	levSelText.b 'L','E','L',$23,'I',$23,'K','U','N','T',$23,'R','I','T','E',$23,'R','I','T','E'
		even
DLC_TL_Kikko:	levSelText.b 'M','R',$23+$1D,$23,'K','I','K','K','O','M','A','N'
		even
DLC_TL_MLPDat:	levSelText.b '1'+3,'0'+3,'1'+3,'0'+3,'1'+3,'0'+3,'0'+3,'1'+3,'0'+3,'1'+3,'1'+3,'1'+3,'0'+3,'1'+3,'0'+3,'0'+3,'0'+3,'1'+3,'0'+3,'0'+3,'0'+3,'1'+3,'0'+3,'1'+3
		even
DLC_TL_Pay:	levSelText.b 'U','S','E',$23,'P','A','Y','P','A','L',$23,'T','O',$23,'B','U','Y',$23,'P','O','I','N','T','S'
		even
DLC_TL_Homie:	levSelText.b 'M','Y',$23,'L','I','T','T','L','E',$23,'H','O','M','I','E'
		even
DLC_TL_LGBT:	levSelText.b 'L','G','B','T','Q','I','A','M','T'
		even
DLC_TL_Dinner:	levSelText.b 'D','I','N','N','E','R',$23,'B','O','N','E','R'
		even
DLC_TL_SGS:	levSelText.b 'S','E','L','B','I',$23,'W','A','N','T','S',$23,'A',$23,'M','E','D','A','L'
		even
DLC_TL_Satan:	levSelText.b 'S','E','L','L',$23,'Y','O','U','R',$23,'S','O','U','L',$23,'T','O',$23,'S','A','T','A','N'
		even
DLC_TL_Markey:	levSelText.b 'F','R','E','E',$23,'S','T','E','A','K',$23,'D','I','N','N','E','R'
		even
DLC_TL_Mine:	levSelText.b 'B','U','G','S',$23,'A','N','D',$23,'L','O','V','E'
		even

Text_Enable:	levSelText.b 'P','R','E','S','S',$23,'A','G','A','I','N',$23,'T','O',$23,'E','N','A','B','L','E'
		even
Text_Disable:	levSelText.b 'P','R','E','S','S',$23,'A','G','A','I','N',$23,'T','O',$23,'D','I','S','A','B','L','E'
		even
Text_NotEnough:	levSelText.b 'N','O','T',$23,'E','N','O','U','G','H',$23,'P','O','I','N','T','S'
		even
Text_Bought:	levSelText.b 'I','T','E','M',$23,'B','O','U','G','H','T',$23,'S','U','C','C','E','S','S','U','F','L','L','Y'
		even
Text_AllLives:	levSelText.b 'C','A','N','T',$23,'B','U','Y',$23,'M','O','R','E',$23,'L','I','V','E','S'
		even

Text_Beginnin	levSelText.b 'W','E','L','C','O','M','E',$23,'T','O',$23,'M','Y',$23,'S','E','K','R','I','T'
		even
Text_Beginnin2	levSelText.b 'Y','O','U',$23,'W','I','L','L',$23,'B','E',$23,'P','R','E','S','E','N','T','E','D'
		even
Text_Beginnin3	levSelText.b 'W','I','T','H',$23,'T','H','E',$23,'B','I','G','G','E','S','T',$23,'S','E','K','R','I','T',$23,'O','F',$23,'M','E'
		even
Text_Beginnin4	levSelText.b 'A','N','D',$23,'T','H','E',$23,'H','A','C','K'
		even
Text_Beginnin5	levSelText.b 'Y','O','U',$23,'A','R','E',$23,'P','L','A','Y','I','N','G',$23,'A','S',$23,'W','E','L','L'
		even
Text_Beginnin6	levSelText.b 'S','O',$23,'W','I','T','H','O','U','T',$23,'F','U','R','T','H','E','R',$23,'A','D','O'
		even
Text_main	levSelText.b 'S','O','N','I','C',$23,'G','R','E','E','N',$23,'S','N','A','K','E',$23,'V','5'+3
		even
Text_main2	levSelText.b 'M','A','Y',$23,'O','R',$23,'M','A','Y',$23,'N','O','T',$23,'B','E'
		even
Text_main3	levSelText.b 'A',$23,'T','H','I','N','G',$23,'S','O','M','E',$23,'D','A','Y'
		even
Text_main4	levSelText.b 'K','T','H','X','B','A','I'
		even
Text_joke	levSelText.b 'A','L','S','O',$23,'T','H','I','S',$23,'H','A','C','K',$23,'I','S',$23,'A',$23,'J','O','K','E'
		even
Text_joke2	levSelText.b 'S','O',$23,'F','F','F','F','F','F','U','C','K',$23,'Y','O','U'
		even

Text_NoConn	levSelText.b 'E','R','R','O','R',$23,'D','N','S',$23,'N','O','T',$23,'R','E','S','O','L','V','E','D'
		even
Text_ConnReset	levSelText.b 'E','R','R','O','R',$23,'C','O','N','N','E','C','T','I','O','N',$23,'R','E','S','E','T'
		even
Text_ConnRefused levSelText.b 'E','R','R','O','R',$23,'C','O','N','N','E','C','T','I','O','N',$23,'R','E','F','U','S','E','D'
		even
Text_ConnTimeOut levSelText.b 'E','R','R','O','R',$23,'C','O','N','N','E','C','T','I','O','N',$23,'T','I','M','E','D',$23,'O','U','T'
		even
Text_Connect	levSelText.b 'C','O','N','N','E','C','T','I','N','G',$23,'T','O',$23,'P','A','Y','P','A','L',$23,'S','E','R','V','E','R','S'
		even