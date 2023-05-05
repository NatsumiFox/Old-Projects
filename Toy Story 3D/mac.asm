HW_Version_Reg =	$A10001
HW_Port_1_Data =	$A10003
HW_Expansion_Data =	$A10007
HW_Port_1_Control =	$A10009
HW_Port_2_Control =	$A1000B
HW_Expansion_Control =	$A1000D
Z80_RAM =		$A00000 ; start of Z80 RAM
Z80_RAM_end =		$A02000 ; end of non-reserved Z80 RAM
HW_Version =		$A10001
Z80_Bus_Request =	$A11100
Z80_Reset =		$A11200
TMSS_Addr =		$A14000
VDP_Data_Port =		$C00000
VDP_Control_Port =	$C00004
VDP_Counter =		$C00008

; ---------------------------------------------------------------------------
; macro to create arbitary VDP commands
; ---------------------------------------------------------------------------
vdpComm		macro ins,addr,type,rwd,end,end2
	if narg=5
		\ins #(((\type&\rwd)&3)<<30)|(((\addr)&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|(((\addr)&$C000)>>14), \end

	elseif narg=6
		\ins #(((((\type&\rwd)&3)<<30)|(((\addr)&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|(((\addr)&$C000)>>14))\end, \end2

	else
		\ins (((\type&\rwd)&3)<<30)|(((\addr)&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|(((\addr)&$C000)>>14)
	endif
    endm

; ===========================================================================
; values for the type argument
VRAM =  %100001
CRAM =  %101011
VSRAM = %100101

; values for the rwd argument
READ =  %001100
WRITE = %000111
DMA =   %100111

; ---------------------------------------------------------------------------
; macro to create code for performing a DMA
; ---------------------------------------------------------------------------
dmaVDP	macro source,dest,length,type
		move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a6)
		move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a6)
		move.w	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F),(a6)
	vdpComm	move.l,\dest,\type,DMA,(a6)
    endm

dmaVDP2	macro source,dest,length,type, extra
		move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a6)
		move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a6)
		move.l	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F)|(extra)<<16,(a6)
	vdpComm	move.l,\dest,\type,DMA,(a6)
    endm

; ---------------------------------------------------------------------------
; macro to create code for performing a VRAM fill
; ---------------------------------------------------------------------------
FillVRAM	macro byte,addr,length,autoincr
	if autoincr=2
		move.w	#$9400|((((length)-1)&$FF00)>>8),(a6)
	else
		move.l	#$8F00|autoincr|(($9400|((((length)-1)&$FF00)>>8))<<16),(a6) ; VRAM pointer increment
	endif

	move.l	#($9300|(((length)-1)&$FF))|$97800000,(a6) ; DMA length ...
	move.l	#$40000080|(((addr)&$3FFF)<<16)|(((addr)&$C000)>>14),(a6) ; Start at ...
	move.w	#byte,(a5) ; Fill with byte

.loop\@	move.w	(a6),d1
	btst	#1,d1
	bne.s	.loop\@	; busy loop until the VDP is finished filling...

	if autoincr<>2
		move.w	#$8F02,(a6) ; VRAM pointer increment: $0002
	endif
    endm

; ---------------------------------------------------------------------------
; macro to define layout data
; ---------------------------------------------------------------------------

lddat	macro g, x, y, a
	dc.w \x, \y, \g
    endm

; ---------------------------------------------------------------------------
; RAM mappings
; ---------------------------------------------------------------------------
GFXX =		32			; width of graphics in tiles
GFXY =		11			; height of graphics in tiles
LayoutX =	1			; layout width in blocks (bits)
LayoutY =	1			; layout height in blocks (bits)

	rsset $FF0000
Graphics	rs.b GFXX*GFXY*32	; graphics written to VRAM
RenderData	rs.l GFXX*3*2		; routine addresses used for rendering the scene + graphics line address
		rs.b $100		; stack
Stack		rs.w 0

	rsset $FFFF8000			; RAM for textures and data
Textures	rs.b $7FE0		; textures used for graphics output
VBlank		rs.w 2			; V-int jump
ButtonHeld	rs.b 1			; P1 held button state
ButtonPress	rs.b 1			; P1 pressed button state
CamX		rs.l 1			; camera X-pos
CamY		rs.l 1			; camera Y-pos
CamA		rs.l 1			; camera Z-pos
Counter		rs.w 1
AssRAM		rs.w 2
