; ===========================================================================
; *              S1HS - Levels order in Level Select Menu                   *
; ===========================================================================
; This file stores level order in level select menu
; The format of each item is: ZZAA, where ZZ is zone and AA is act number.
; ===========================================================================

		dc.w	$0000	; GHZ 1
		dc.w	$0001	; GHZ 2
		dc.w	$0002	; GHZ 3

		dc.w	$0100	; LZ 1
		dc.w	$0101	; LZ 2
		dc.w	$0102	; LZ 3

		dc.w	$0200	; MZ 1
		dc.w	$0201	; MZ 2
		dc.w	$0202	; MZ 3

		dc.w	$0300	; SLZ 1
		dc.w	$0301	; SLZ 2
		dc.w	$0302	; SLZ 3

		dc.w	$0400	; SYZ 1
		dc.w	$0401	; SYZ 2
		dc.w	$0402	; SYZ 3

		dc.w	$0500	; SBZ 1
		dc.w	$0501	; SBZ 2
		dc.w	$0103	; SBZ 3 (actually LZ 4)

		dc.w	$0502	; Final Zone (actually SBZ 3)

		dc.w	$0700	; Special Stage
		dc.w	$8000	; Sound select
