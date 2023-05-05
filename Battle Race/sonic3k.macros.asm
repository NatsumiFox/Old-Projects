; simplifying macros and functions
; nameless temporary symbols should NOT be used inside macros because they can interfere with the surrounding code
; normal labels should be used instead (which automatically become local to the macro)
prio	function id, Sprite_table_input+(id*prlayersize)

; makes a VDP command
vdpComm function addr,type,rwd,(((type&rwd)&3)<<30)|((addr&$3FFF)<<16)|(((type&rwd)&$FC)<<2)|((addr&$C000)>>14)

; values for the type argument
VRAM = %100001
CRAM = %101011
VSRAM = %100101

; values for the rwd argument
READ = %001100
WRITE = %000111
DMA = %100111

; tells the VDP to copy a region of 68k memory to VRAM or CRAM or VSRAM
dma68kToVDP macro source,dest,length,type
	lea	(VDP_control_port).l,a5
	move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a5)
	move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a5)
	move.w	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F),(a5)
	move.w	#((vdpComm(dest,type,DMA)>>16)&$FFFF),(a5)
	move.w	#(vdpComm(dest,type,DMA)&$FFFF),(DMA_trigger_word).w
	move.w	(DMA_trigger_word).w,(a5)
    endm

; tells the VDP to fill a region of VRAM with a certain byte
dmaFillVRAM macro byte,addr,length
	lea	(VDP_control_port).l,a5
	move.w	#$8F01,(a5) ; VRAM pointer increment: $0001
	move.l	#(($9400|((((length)-1)&$FF00)>>8))<<16)|($9300|(((length)-1)&$FF)),(a5) ; DMA length ...
	move.w	#$9780,(a5) ; VRAM fill
	move.l	#$40000080|(((addr)&$3FFF)<<16)|(((addr)&$C000)>>14),(a5) ; Start at ...
	move.w	#(byte)<<8,(VDP_data_port).l ; Fill with byte
loop:	move.w	(a5),d1
	btst	#1,d1
	bne.s	loop	; busy loop until the VDP is finished filling...
	move.w	#$8F02,(a5) ; VRAM pointer increment: $0002
    endm

; calculates initial loop counter value for a dbf loop
; that writes n bytes total at 4 bytes per iteration
bytesToLcnt function n,n>>2-1

; calculates initial loop counter value for a dbf loop
; that writes n bytes total at 2 bytes per iteration
bytesToWcnt function n,n>>1-1

; calculates initial loop counter value for a dbf loop
; that writes n bytes total at x bytes per iteration
bytesToXcnt function n,x,n/x-1

; fills a region of 68k RAM with 0
clearRAM macro addr,length
    if ((addr)&$8000)==0
	lea	(addr).l,a1
    else
	lea	(addr).w,a1
    endif
	moveq	#0,d0
    if ((addr)&1)
	move.b	d0,(a1)+
    endif
	move.w	#bytesToLcnt(length - ((addr)&1)),d1
.loop:	move.l	d0,(a1)+
	dbf	d1,.loop
    if ((length - ((addr)&1))&2)
	move.w	d0,(a1)+
    endif
    if ((length - ((addr)&1))&1)
	move.b	d0,(a1)+
    endif
    endm

; tells the Z80 to stop, and waits for it to finish stopping (acquire bus)
stopZ80 macro
	move.w	#$100,(Z80_bus_request).l ; stop the Z80
loop:	btst	#0,(Z80_bus_request).l
	bne.s	loop ; loop until it says it's stopped
    endm

; tells the Z80 to start again
startZ80 macro
	move.w	#0,(Z80_bus_request).l    ; start the Z80
    endm

; function to make a little-endian 16-bit pointer for the Z80 sound driver
z80_ptr function x,(x)<<8&$FF00|(x)>>8&$7F|$80

; macro to declare a little-endian 16-bit pointer for the Z80 sound driver
rom_ptr_z80 macro addr
	dc.w z80_ptr(addr)
    endm

; macros to convert from tile index to art tiles, block mapping or VRAM address.
make_art_tile function addr,pal,pri,((pri&1)<<15)|((pal&3)<<13)|(addr&tile_mask)
tiles_to_bytes function addr,((addr&$7FF)<<5)

; function to calculate the location of a tile in plane mappings with a width of 40 cells
planeLocH28 function col,line,(($50 * line) + (2 * col))

; macro for generating level select strings
levselstr macro str
	save
	codepage	LEVELSELECT
	dc.b strlen(str)-1, str
	restore
    endm

; macros for defining animated PLC script lists
zoneanimstart macro {INTLABEL}
__LABEL__ label *
zoneanimcount := 0
zoneanimcur := "__LABEL__"
	dc.w zoneanimcount___LABEL__	; Number of scripts for a zone (-1)
    endm

zoneanimend macro
zoneanimcount_{"\{zoneanimcur}"} = zoneanimcount-1
    endm

zoneanimdeclanonid := 0

zoneanimdecl macro duration,artaddr,vramaddr,numentries,numvramtiles
zoneanimdeclanonid := zoneanimdeclanonid + 1
start:
	dc.l (duration&$FF)<<24|artaddr
	dc.w tiles_to_bytes(vramaddr)
	dc.b numentries, numvramtiles
zoneanimcount := zoneanimcount + 1
    endm

tribyte macro val
	if "val"<>""
		dc.b (val >> 16)&$FF,(val>>8)&$FF,val&$FF
		shift
		tribyte ALLARGS
	endif
    endm

CheckPlatStuff	macro plmask, oppmask
	move.b	$2A(a1),$2A(a0)		; copy status table
	btst	#3,$2A(a0)		; check if on a platform
	beq.s	.ok			; if not, skip
	move.w	$42(a1),d0		; get plat address
	move.w	d0,$42(a0)		; set plat address
	beq.s	.ok			; if was 0, branch

	move.w	d0,a2			; copy to a2
	move.b	$2A(a2),d0		; get status bits of the platform
	and.b	#plmask,$2A(a2)		; make sure bits are clear
	and.b	#oppmask,d0		; get only standing bits

	if oppmask=%01010000
		lsr.b	#1,d0		; shift them in place
	else
		lsl.b	#1,d0		; shift them in place
	endif

	or.b	d0,$2A(a2)		; then or the bits in
.ok
	endm

PlatNoStand	macro plmask, oppmask
	btst	#3,$2A(a0)		; check if on a platform
	beq.s	.ok			; if not, skip
	move.w	$42(a0),a2		; get platform
	and.b	#plmask,$2A(a2)		; make sure bits are clear
.ok
	endm

DMA:		macro	Size, Destination, Source
		move.l	#((((((Size)/$02)<<$08)&$FF0000)+(((Size)/$02)&$FF))+$94009300),(a6)
		move.l	#(((((((Source)&$FFFFFF)/$02)<<$08)&$FF0000)+((((Source)&$FFFFFF)/$02)&$FF))+$96009500),(a6)
		move.l	#((((((Source)&$FFFFFF)/$02)&$7F0000)+$97000000)+(((Destination)>>$10)&$FFFF)),(a6)
		move.w	#(((Destination)&$FF7F)|$80),(a6)
		endm

DMASRC:		macro	Size, Source
		move.l	#((((((Size)/$02)<<$08)&$FF0000)+(((Size)/$02)&$FF))+$94009300),(a6)
		move.l	#(((((((Source)&$FFFFFF)/$02)<<$08)&$FF0000)+((((Source)&$FFFFFF)/$02)&$FF))+$96009500),(a6)
		move.w	#((((((Source)&$FFFFFF)/$02)&$7F0000)>>$10)+$9700),(a6)
		endm

DMATAB:		macro	Source
		dc.l	$94009330
		dc.l	(((((((Source)&$FFFFFF)/$02)<<$08)&$FF0000)+((((Source)&$FFFFFF)/$02)&$FF))+$96009500)
		dc.w	((((((Source)&$FFFFFF)/$02)&$7F0000)>>$10)+$9700)
		endm

	; PCM Driver stuff...

Z80Stack	=	$0FF0+$A00000
Z80FlagDMA	=	$0FF0+$A00000		; 1		; DMA on/off flag (00 No | FF Yes)
Z80BankPCM	=	$0FF1+$A00000		; 1		; new sample bank address
Z80WindowPCM	=	$0FF2+$A00000		; 2		; new sample window address
Z80PitchPCM	=	$0FF4+$A00000		; 1		; new sample pitch
Z80FlagYM2612	=	$0FF8+$A00000		; 1		; YM2612 access flag (00+ No | FF- Yes)
Z80BankPCMCUr	=	$0FF9+$A00000		; 1		; current sample bank address
Z80DACON	=	$0FFA+$A00000		; 1		; DAC on flag (00+ No | FF- Yes)

	; --- Rewriteable instructions ---
	; Remove "CLS" from batch to see offsets

Z80NewSample	=	$0018+$A00000
Z80DMA01	=	$001A+$A00000
Z80DMA02	=	$002C+$A00000
Z80Volume01	=	$003B+$A00000
Z80Volume02	=	$00EF+$A00000
Z80Volume03	=	$015C+$A00000
Z80Volume04	=	$019E+$A00000
Z80Volume05	=	$01F9+$A00000


	; --- Z80 DMA On ---

Z80DMAOn	macro
		tst.w	($FFFFF63A).w				; is the game paused?
		bne.s	*+$54					; if so, branch
		move.w	#$0100,($A11100).l			; request Z80 stop (ON)
		btst.b	#$00,($A11100).l			; has the Z80 stopped yet?
		bne.s	*-$08					; if not, branch
		tst.b	($FFFFF000+$3F).w			; is the tracker PCM driver being used?
		beq.s	*+$1C					; if not, branch
		move.b	#$FF,($A00FF0).l			; set DMA on
		move.b	#$20,($A00032).l			; change first jr instruction to nz
		move.b	#$20,($A00043).l			; change second jr instruction to nz
		bra.s	*+$1A					; continue to put Z80 stop off
		move.b	#$FF,(Z80FlagDMA).l			; set DMA on
		move.b	#$20,(Z80DMA01).l			; change first jr instruction to nz
		move.b	#$20,(Z80DMA02).l			; change second jr instruction to nz
		move.w	#$0000,($A11100).l			; request Z80 stop (OFF)
		endm

	; --- Z80 DMA Off ---

Z80DMAOff	macro
		tst.w	($FFFFF63A).w				; is the game paused?
		bne.s	*+$54					; if so, branch
		move.w	#$0100,($A11100).l			; request Z80 stop (ON)
		btst.b	#$00,($A11100).l			; has the Z80 stopped yet?
		bne.s	*-$08					; if not, branch
		tst.b	($FFFFF000+$3F).w			; is the tracker PCM driver being used?
		beq.s	*+$1C					; if not, branch
		move.b	#$00,($A00FF0).l			; set DMA off
		move.b	#$28,($A00032).l			; change first jr instruction to z
		move.b	#$28,($A00043).l			; change second jr instruction to z
		bra.s	*+$1A					; continue to put Z80 stop off
		move.b	#$00,(Z80FlagDMA).l			; set DMA off
		move.b	#$28,(Z80DMA01).l			; change first jr instruction to z
		move.b	#$28,(Z80DMA02).l			; change second jr instruction to z
		move.w	#$0000,($A11100).l			; request Z80 stop (OFF)
		endm
