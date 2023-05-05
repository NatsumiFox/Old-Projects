	opt ae+
	opt l+
	opt w+
	opt ws+
	opt m+
; ===========================================================================
	rsset 0
PL_DIE		rs.b 1
ST_SOLID	rs.b 1
ST_STOOD	rs.b 1
ST_BOTTOM	rs.b 1

	rsset 0
PTR	rs.w 1
ART	rs.w 1
FRAME	rs.b 1	; multiple of 4
XPOS	rs.b 1
YPOS	rs.b 1
ARG	rs.b 1
STAT	rs.b 1
DAT1	rs.b 1
SIZE	rs.w 0	; 8
OBJCNT = $14

XOFF =		12
YOFF =		18
PLANEVRAM =	$C000
GRAVITY =	$08
GRAVITYL =	$06
; ===========================================================================
	rsset $FFFF0000
		rs.b $7F00
		rs.b $100	; STACK
STACK_PTR	rs.b 0
PLANEMAP	rs.w 64*64	; PLANE SIZE IS 64x64
OBJECTS		rs.b OBJCNT*SIZE
BUTHELD		rs.b 1
BUTPRESS	rs.b 1
PLANEX		rs.w 1
PLANEXCHKPT	rs.w 1
PLANEUPDATED	rs.b 1
		rs.b 1
LAYOUTINDEX	rs.w 1
STOODONOBJ	rs.w 1
PLAYERYPOS	rs.w 1
PLAYERYVEL	rs.w 1

; ===========================================================================
align macro
	cnop 0,\1
	endm

; ===========================================================================
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

; ===========================================================================
; tells the VDP to copy a region of 68k memory to VRAM or CRAM or VSRAM
dma68kToVDP macro source,dest,length,type
		move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a5)
		move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a5)
		move.w	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F),(a5)
	vdpComm	move.l,\dest,\type,DMA,(a5)
    endm

; ===========================================================================

di	macro
	move	#$2700,sr
    endm

ei	macro
	move	#$2300,sr
    endm

; ===========================================================================
objl	macro rtn, x, y, arg
	dc.w x, rtn
	dc.b YOFF+y, arg

    endm
