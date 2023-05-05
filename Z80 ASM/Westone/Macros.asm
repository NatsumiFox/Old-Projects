wHeaderMus	macro prio, tempo
	dc.b \prio
	dw \tempo
    endm

wHeaderSFX	macro prio
	dc.b \prio
    endm

wChSFX		macro ch, addr
	dc.b \ch
	dw \addr
    endm

wLoopGo		macro id, addr
	dc.b $D0+\id
	dw \addr
    endm

wLoopBackInit	macro id
	dc.b $D8+\id
    endm

wModOn		macro div
	dc.b $E0, \div
    endm

wModOff		macro
	dc.b $E1
    endm

wSetTimerB	macro timer
	dc.b $E2, \timer
    endm

wSetTimerW	macro timer
	dc.b $E3
	dw \timer
    endm

wTempo		macro tempo
	dc.b $E4, \tempo
    endm

wPlaySound	macro id
	dc.b $E5, \id
    endm

wSetPat		macro id
	dc.b $F0, \id
    endm

wTempoDiv	macro div
	dc.b $F1, \div
    endm

wSetFreq	macro freq
	dc.b $F2
	dw \freq
    endm

wAddFreq	macro freq
	dc.b $F3
	dw \freq
    endm

wSetVol		macro vol
	dc.b $F4, \vol
    endm

wAddVol		macro vol
	dc.b $F5, \vol
    endm

wSetType	macro type
	dc.b $F6, \type
    endm

wSetMask	macro mask
	dc.b $F7, \mask
    endm

wDrumChannel	macro
	dc.b $F8
    endm

wPan		macro pan
	dc.b $F9, \pan
    endm

wStopRead	macro
	dc.b $FA
    endm

wStopHw		macro
	dc.b $FB
    endm

wFC		macro
	dc.b $FC
    endm

wJump		macro addr
	dc.b $FD
	dw \addr
    endm

wLoopBack	macro
	dc.b $FE
    endm

wLoopGoEnd	macro
	dc.b $FF
    endm
