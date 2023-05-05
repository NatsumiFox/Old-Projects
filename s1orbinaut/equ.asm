	opt w-	; warnings are useless to me.

debug = 1	; enable debug mode by default
ChunkMappings =		$FF0000
LevelLayout =		$FFFFA400
SLZExtScrollBuf =	$FFFFA800
NemDecBuf =		$FFFFAA00
SpriteTable =		$FFFFAC00
BlockMaps =		$FFFFB000
SonArtBuf =		$FFFFC800
SonicPrevPosArr =	$FFFFCB00
ScrollRAM =		$FFFFCC00
ObjRAM =		$FFFFD000
OrbRAM =		$FFFFD400
ObjRAM_Free =		$FFFFD800
SndEngineRAM =		$FFFFF000
ObjRAM_End =		SndEngineRAM
GameMode =		$FFFFF600
SonicBtnHeld =		$FFFFF602
SonicBtnPress =		$FFFFF603
Player1BtnHeld =	$FFFFF604
Player1BtnPress =	$FFFFF605
Player2BtnHeld =	$FFFFF606
Player2BtnPress =	$FFFFF607
VDPMode2Setting =	$FFFFF60C
UnivCounter =		$FFFFF614
PlaneAXPrev =		$FFFFF616
PlaneAYPrev =		$FFFFF618
PlaneBXPrev =		$FFFFF61A
PlaneBYPrev =		$FFFFF61C
Prev_F71C =		$FFFFF61E
Prev_F718 =		$FFFFF620
VDPModeASetting =	$FFFFF624
Palfade1 =		$FFFFF626
Palfade2 =		$FFFFF627
VBIRoutine =		$FFFFF62A
SpriteCounter =		$FFFFF62C
PalCycOff =		$FFFFF632
PalCycWait =		$FFFFF634
RandSeed =		$FFFFF636
PauseState =		$FFFFF63A
UnusedVDP =		$FFFFF640
WatHeight =		$FFFFF646
WatRoutine =		$FFFFF64D
WatDir =		$FFFFF64E
HBIExtRtns =		$FFFFF64F
PLCQueueAdr =		$FFFFF650
PLCQueue: =		PLCQueueAdr+4
PLCQueueEnd =           $FFFFF700-$20
PlaneAX =		$FFFFF700
PlaneAY =		$FFFFF704
PlaneBX =		$FFFFF708
PlaneBY =		$FFFFF70C
TgtLeftBound =		$FFFFF720
TgtRightBound =		$FFFFF722
TgtUpperBound =		$FFFFF724
TgtLowerBound =		$FFFFF726
LeftBound =		$FFFFF728
RightBound =		$FFFFF72A
UpperBound =		$FFFFF72C
LowerBound =		$FFFFF72E
PlaneAXCopy =		$FFFFF73A
PlaneAYCopy =		$FFFFF73C
ResizeRoutine =		$FFFFF742
NoScrollFlag =		$FFFFF744
SonTopSpeed =		$FFFFF760
SonAccel =		$FFFFF762
SonDece =		$FFFFF764
SonDPLCLast =		$FFFFF766
ObjPosRoutine =		$FFFFF76C
ObjPosPlaneAX =		$FFFFF76E
SSAngle =		$FFFFF780
SSRotSpeed =		$FFFFF782
DemoBtnPressOff =	$FFFFF790
DemoBtnPressDur =	$FFFFF792
CollAdr =		$FFFFF796
SSPalCycCounter =	$FFFFF79A
SSPalCycDelay =		$FFFFF79C
SonicPrevPosArrCounter = $FFFFF7A8
ScrnLock =		$FFFFF7AA
LoopNums =		$FFFFF7AC
SonIgnorePhysics =	$FFFFF7C8
LZWindTunnelEnable =	$FFFFF7C9
SonLockControl =	$FFFFF7CA
LockJoypad =		$FFFFF7CC
IsInBigRing =		$FFFFF7CD
OnAirEnemyKills =	$FFFFF7D0
TimeBonusFlag =		$FFFFF7D2
RingBonusFlag =		$FFFFF7D4
RingBonusUpdate =	$FFFFF7D6
SpriteTableBuf =	$FFFFF800
TargetUWPal =		$FFFFFA00
TargetPal =		$FFFFFA80
CurrentPal =		$FFFFFB00
CurrentUWPal =		$FFFFFB80
DestStateTable =	$FFFFFC00
ErrorMessage =		$FFFFFC44
SystemStack =		$FFFFFD80
StackPtr =		SystemStack+$80
RestartLevel =		$FFFFFE02
LevelTimer =		$FFFFFE04
DebugItemPtr =		$FFFFFE06
ObjPlacementFlag =	$FFFFFE08
ZoneID =		$FFFFFE10
ActID =			$FFFFFE11
LivesCounter =		$FFFFFE12
AirRemain =		$FFFFFE14
SSLast =		$FFFFFE16
ContinuesCount =	$FFFFFE18
TimeOverFlag =		$FFFFFE1A
ExtraLifeGot =		$FFFFFE1B
LiveCounterUpd =	$FFFFFE1C
RingCounterUpd =	$FFFFFE1D
TimeCounterUpd =	$FFFFFE1E
ScoreCounterUpd =	$FFFFFE1F
RingCounter =		$FFFFFE20
TimeCounter =		$FFFFFE22
ScoreCounter =		$FFFFFE26
GotShield =		$FFFFFE2C
InvinFlag =		$FFFFFE2D
SpeedShoeFlag =		$FFFFFE2E
LPostCount =		$FFFFFE30
LPost_LposCount =	$FFFFFE31
LPost_SonX =		$FFFFFE32
LPost_SonY =		$FFFFFE34
LPost_RingCounter =	$FFFFFE36
LPost_TimeCounter =	$FFFFFE38
LPost_LVLResize =	$FFFFFE3C
LPost_LVLLowBound =	$FFFFFE3E
LPost_PlaneAX =		$FFFFFE40
LPost_PlaneAY =		$FFFFFE42
LPost_WatHeight =	$FFFFFE50
LPost_WatRoutine =	$FFFFFE52
LPost_WatDir =		$FFFFFE53
LPost_LivesCounter =	$FFFFFE54
EmeraldsCounter =	$FFFFFE58
LVLSel_MovePtr =	$FFFFFF80
LVLSel_SelID =		$FFFFFF82
LVLSel_SoundID =	$FFFFFF84
LVLSelCheat =		$FFFFFFE0
SlowMoCheat =		$FFFFFFE1
DebugCheat =		$FFFFFFE2
CorrBtnPressCtr =	$FFFFFFE4
CBtnPressCtr =		$FFFFFFE6
DemoModeFlag =		$FFFFFFF0
DemoNumber =		$FFFFFFF2
CreditNumber =		$FFFFFFF4
VersionReg =		$FFFFFFF8
DebugFlag =		$FFFFFFFA
ChecksumFlag =		$FFFFFFFC
VBlankJump	equ $FFFFF5C0
HBlankJump	equ VBlankJump+6

; ===========================================================================
; Z80 addresses
Z80_RAM =			$A00000 ; start of Z80 RAM
Z80_RAM_end =			$A02000 ; end of non-reserved Z80 RAM
Z80_bus_request =		$A11100
Z80_reset =			$A11200

SRAM_access =			$A130F1
Security_addr =			$A14000
; ===========================================================================
; I/O Area
HW_Version =			$A10001
HW_Port_1_Data =		$A10003
HW_Port_2_Data =		$A10005
HW_Expansion_Data =		$A10007
HW_Port_1_Control =		$A10009
HW_Port_2_Control =		$A1000B
HW_Expansion_Control =		$A1000D
HW_Port_1_TxData =		$A1000F
HW_Port_1_RxData =		$A10011
HW_Port_1_SCtrl =		$A10013
HW_Port_2_TxData =		$A10015
HW_Port_2_RxData =		$A10017
HW_Port_2_SCtrl =		$A10019
HW_Expansion_TxData =		$A1001B
HW_Expansion_RxData =		$A1001D
HW_Expansion_SCtrl =		$A1001F

; ===========================================================================
; VDP addresses
VDP_data_port =			$C00000
VDP_control_port =		$C00004
PSG_input =			$C00011
; ===========================================================================
loadJumps	macro fromloc

		lea	VBlankJump,a0
		lea	fromloc,a1
	rept 3
		move.l	(a1)+,(a0)+
	endr
    endm

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

; ---------------------------------------------------------------------------
; macro to create code for performing a VRAM fill
; ---------------------------------------------------------------------------
FillVRAM	macro byte,addr,length,autoincr
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
; ---------------------------------------------------------------------------

VdPsize macro length
	dc.l	(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF))
    endm

; =============================================================
stopZ80        macro
        move.w    #$100,($A11100).l
        nop
        nop
        nop

@wait\@:    btst    #0,($A11100).l
        bne.s    @wait\@
        endm

; =============================================================

startZ80    macro
        move.w    #0,($A11100).l    ; start the Z80
        endm

; =============================================================

waitYM        macro
@wait\@:    move.b    ($A04000).l,d2
        btst    #7,d2
        bne.s    @wait\@
        endm

        opt l+
	include "snd/macros.asm"
