; ===========================================================================
; ---------------------------------------------------------------------------
; Pausing art/map includes (separate to include at end of ROM)
; ---------------------------------------------------------------------------

PauseMap:	binclude "General\Pause\Data (Old)\Map_MenuText.bin"

PauseArt:	dc.w (.art2-*-4)/2
		dc.w $FB00
		binclude "General\Pause\Data (Old)\Art_MenuEdges.bin"

.art2		dc.w (.end-*-4)/2
		dc.w $F380
		binclude "General\Pause\Data (Old)\Art_MenuText.bin"
.end

; ===========================================================================
