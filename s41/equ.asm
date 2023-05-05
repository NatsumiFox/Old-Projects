	opt w-
	opt l+
	opt m+
	nolist	; Do not list all these equates, to keep listings file cleaner
		include "sk/sonic3k.inc"	; various routines
		include "s2/s2.inc"		; various routines
		include "s1/s1.inc"

Sprite_Left	= 128+$80
Sprite_Right	= 320+$80

; all of this is picked from Sonic 3 disassembly
InitVDP =		$13AE
ResetControllers = 	$1342
ReadController =	$1372
ClearScreen =		$145E
LoadSoundDriver = 	$1562
PlayMusic = 		$15E2
PlaySFX =		$160A
MapToPlane =		$1770
QueueDMA =		$17B0
NemDec =		$1844
ClearPLC =		$19FC
EniDec =		$1B3E
KosDec =		$1CBC
VSync =			$1FA2
RandomNumber =		$1FAE
GetSine =		$1FD4
PalFade_InBlack =	$3276
PalFill_Black =		$3306
PalFade_OutBlack =	$333E
PalFadeDo_ToWhite =	$3466
AnimatePlayer =		$1345E
SonicAniDat =		$13814
SonicLoadDPLC =		$13A22
AniTails =		$165AA
Ani_Dust =		$17B0C
Map_Dust =		$17B40
DPLC_Dust =		$17C2E
LoadDPLC =		$18528
ResetSpriteList =	$19162
ProcessObjects =	$191BE
ObjFall =		$191F6
ObjMove =		$19216
DeleteObject =		$19230
DisplayObj =		$19240
AnimateObj =		$19256
BuildSprites =		$19396
LoadObject =		$1A0C2
Map_Spikes =		$22A5C
Pal_Sonic =		$8C234
Pal_Knuckles =		$8C2F4
ArtUnc_Sonic_ =		$100000
ArtUnc_Tails_ =		$1200E0
Map_Sonic =		$140FE0
DPLC_Sonic =		$1428AC
Map_Tails =		$143488
DPLC_Tails =		$144456
ArtUnc_Dust =		$149122
Nem_SpikesSprings =	$15EFFC
ArtUnc_Knux_ =		$1843E6

KosDec_ =		Kos_Decomp+$200000; custom KosDec in S&K ROM (faster)

HW_Expansion_Data =	$A10007
HW_Port_1_Control =	$A10009
HW_Port_2_Control =	$A1000B
HW_Expansion_Control =	$A1000D
Z80_RAM =		$A00000 ; start of Z80 RAM
Z80_RAM_end =		$A02000 ; end of non-reserved Z80 RAM
HW_Version =		$A10001
Z80_bus_request =	$A11100
Z80_reset =		$A11200
VDP_Counter =		$C00008

GenDoes_Len =		$270

Stack			equ $FFFFE000	; stack pointer
MenuState		equ $FFFFFD00	; current state of the menu (moving, waiting, fading out)
SelectedROM		equ $FFFFFD01	; currently selected ROM
MenuTgtY		equ $FFFFFD02	; target y-pos for menu
PlaneAY			equ $FFFFFD04	; current y-pos for menu
PlaneBX			equ $FFFFFD06	; current background x-position
NameSpriteX		equ $FFFFFD08	; x-position óf the name sprites
StoredPlaneA		equ $FFFFFD0A	; y-position of menu currently not loaded
CheatsOffset		equ $FFFFFD0C	; information about the cheats

; ===========================================================================
; lock-on ROM type. Selects what game to run with S&K
; -1 = Sonic & Knuckles
;  0 = Sonic 3 & Knuckles
;  1 = Sonic 2 & Knuckles
;  2 = Sonic 1 & Knuckles
; ===========================================================================
LockonROMid		equ $FFFFFD10
ChangingLockROM		equ $FFFFFD11	; whether we are changing the locked on ROM or not
PalCycleS2		equ $FFFFFD12	; palette cycle offset for S2 super Sonic
PalCycleS2Timer		equ $FFFFFD13	; and its timer
PalCycleS3K		equ $FFFFFD14	; palette cycle offset for S3K hyper Sonic
PalCycleS3KTimer	equ $FFFFFD15	; and its timer
PlaySampleLen		equ $FFFFFD16
FrameOffs		equ $FFFFFD20	; arrangement of the frame data on menu

WriteArtToVRAM		equ $FFFF9BF8	; routine to write menu art to VDP
Scalers			equ $FFFF8000	; scaler codes
ScaleBuf		equ $FFFF0000	; scaler buffers

Random_Seed		equ $FFFFF636	; randomnumber seed

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
; tells the VDP to fill a region of VRAM with a certain byte
dmaFillVRAM macro byte,addr,length,autoincr
	if autoincr=2
		move.w	#$9400|((((length)-1)&$FF00)>>8),(a5)
	else
		move.l	#$8F00|autoincr|(($9400|((((length)-1)&$FF00)>>8))<<16),(a5) ; VRAM pointer increment
	endif

	move.l	#($9300|(((length)-1)&$FF))|$97800000,(a5) ; DMA length ...
	move.l	#$40000080|(((addr)&$3FFF)<<16)|(((addr)&$C000)>>14),(a5) ; Start at ...
	move.w	#byte,-4(a5) ; Fill with byte
.loop\@	move.w	(a5),d1
	btst	#1,d1
	bne.s	.loop\@	; busy loop until the VDP is finished filling...

	if autoincr<>2
		move.w	#$8F02,(a5) ; VRAM pointer increment: $0002
	endif
    endm
; ===========================================================================

di	macro
	move	#$2700,sr
    endm

ei	macro
	move	#$2300,sr
    endm


; ===========================================================================
err	macro lable
\lable\_:
		move.b	#DebuggerOffs/$080000,$A130FF
	jmp	\lable
    endm
; ===========================================================================
space	macro x, n
.c =	offset(*)
	if .c>=(\x+1)
.o =		offset(*)-\x
		inform 3,"\n is currently at $\$.c, bytes went over; $\$.o!"
	else
.o =		\x-offset(*)
		inform 0,"\n is currently at $\$.c, bytes free; $\$.o!"
	endif
    endm
; ===========================================================================

cheat	macro lable, addr, code
	if strlen(\code)&1
		dc.b 0
	endif

\lable:
.lc = 0
	rept strlen(\code)
.cc		substr .lc+1,.lc+1,\code

	if ('\.cc'='u')|('\.cc'='U')
		dc.b ~$01+1

	elseif ('\.cc'='d')|('\.cc'='D')
		dc.b ~$02+1

	elseif ('\.cc'='l')|('\.cc'='L')
		dc.b ~$04+1

	elseif ('\.cc'='r')|('\.cc'='R')
		dc.b ~$08+1

	elseif ('\.cc'='a')|('\.cc'='A')
		dc.b ~$40+1

	elseif ('\.cc'='b')|('\.cc'='B')
		dc.b ~$10+1

	elseif ('\.cc'='c')|('\.cc'='C')
		dc.b ~$20+1

	else
		inform 3,"Illegal character '\.cc'"
	endif

.lc =		.lc+1
	endr

	dc.l	\addr&$FFFFFF
	endm
; ===========================================================================
	list
