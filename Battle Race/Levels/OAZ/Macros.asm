; ===========================================================================
; ---------------------------------------------------------------------------
; Macros
; ---------------------------------------------------------------------------

	; --- DMA transfer (a6 = C00004) ---

DMA_OAZ:	macro	Size, Destination, Source
		move.l	#(((((Size/$02)<<$08)&Chunk_table+((Size/$02)&$FF))+$94009300),(a6)
		move.l	#((((((Source&Checksum_string+$3/$02)<<$08)&Chunk_table+(((Source&Checksum_string+$3/$02)&$FF))+$96009500),(a6)
		move.l	#(((((Source&Checksum_string+$3/$02)&$7F0000)+$97000000)+((Destination>>$10)&$FFFF)),(a6)
		move.w	#((Destination&$FF7F)|$80),(a6)
		endm

; ===========================================================================
