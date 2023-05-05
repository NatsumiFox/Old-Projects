; this macro is created to emulate enum in AS
enum	macro	num, lable
; copy initial number for referencing later
.num	= num

	rept narg-1
\lable		equ .num
.num =	.num+1
	shift
	endr
    endm

; simple macro to create a Z80 pointer (relative to bank)
Z80PtrROM	macro addr
	dc.w	(((addr)<<8)&$FF00)|(((addr)>>8)&$FF)|$80
    endm

; simple macro to create little endian word values
littleEndian	macro value
	dc.w	(((value)<<8)&$FF00)|(((value)>>8)&$FF)
    endm
; ---------------------------------------------------------------------------------------------
; Standard Octave Pitch Equates
smpsPitch10lo	equ $88
smpsPitch09lo	equ $94
smpsPitch08lo	equ $A0
smpsPitch07lo	equ $AC
smpsPitch06lo	equ $B8
smpsPitch05lo	equ $C4
smpsPitch04lo	equ $D0
smpsPitch03lo	equ $DC
smpsPitch02lo	equ $E8
smpsPitch01lo	equ $F4
smpsPitch00	equ $00
smpsPitch01hi	equ $0C
smpsPitch02hi	equ $18
smpsPitch03hi	equ $24
smpsPitch04hi	equ $30
smpsPitch05hi	equ $3C
smpsPitch06hi	equ $48
smpsPitch07hi	equ $54
smpsPitch08hi	equ $60
smpsPitch09hi	equ $6C
smpsPitch10hi	equ $78
; ---------------------------------------------------------------------------------------------
; Note Equates
	enum $80+0, nRst,nC0,nCs0,nD0,nEb0,nE0,nF0,nFs0,nG0,nAb0,nA0,nBb0,nB0,nC1,nCs1,nD1
	enum nD1+1, nEb1,nE1,nF1,nFs1,nG1,nAb1,nA1,nBb1,nB1,nC2,nCs2,nD2,nEb2,nE2,nF2,nFs2
	enum nFs2+1, nG2,nAb2,nA2,nBb2,nB2,nC3,nCs3,nD3,nEb3,nE3,nF3,nFs3,nG3,nAb3,nA3,nBb3
	enum nBb3+1, nB3,nC4,nCs4,nD4,nEb4,nE4,nF4,nFs4,nG4,nAb4,nA4,nBb4,nB4,nC5,nCs5,nD5
	enum nD5+1, nEb5,nE5,nF5,nFs5,nG5,nAb5,nA5,nBb5,nB5,nC6,nCs6,nD6,nEb6,nE6,nF6,nFs6
	enum nFs6+1, nG6,nAb6,nA6,nBb6,nB6,nC7,nCs7,nD7,nEb7,nE7,nF7,nFs7,nG7,nAb7,nA7,nBb7
; ---------------------------------------------------------------------------------------------
; Channel IDs for SFX
cPSG1				EQU $80
cPSG2				EQU $A0
cPSG3				EQU $C0
cNoise				EQU $E0	; Not for use in S3/S&K/S3D
cFM3				EQU $02
cFM4				EQU $04
cFM5				EQU $05
cFM6				EQU $06	; Only in S3/S&K/S3D, overrides DAC
; ---------------------------------------------------------------------------------------------
smpsIsZ80 =		1
smpsUniVoiceBank =	$17D8
smpsNoAttack =		$E7
nMaxPSG1 =		nBb6
nMaxPSG2 =		nB6
; ---------------------------------------------------------------------------------------------
; PSG volume envelope equates
	enum $00,	  VolEnv_00,VolEnv_01,VolEnv_02,VolEnv_03,VolEnv_04,VolEnv_05
	enum VolEnv_05+1, VolEnv_06,VolEnv_07,VolEnv_08,VolEnv_09
; ---------------------------------------------------------------------------------------------
; DAC Equates
	enum $81, dKick,dSnare,dTimpani
	enum $88, dHiTimpani,dMidTimpani,dLowTimpani,dVLowTimpani

; ---------------------------------------------------------------------------------------------
; Header Macros
smpsHeaderStartSong macro
songStart =	offset(*)
    endm

smpsHeaderVoiceNull macro
	if songStart<>offset(*)
		inform 2,"Missing smpsHeaderStartSong or smpsHeaderStartSongConvert"
	endif
	dc.w $0000
    endm

; Header - Set up Voice Location
; Common to music and SFX
smpsHeaderVoice macro loc
	if songStart<>offset(*)
		inform 2,"Missing smpsHeaderStartSong or smpsHeaderStartSongConvert"
	endif
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w loc-songStart
	endif
    endm

; Header - Set up Voice Location as S3's Universal Voice Bank
; Common to music and SFX
smpsHeaderVoiceUVB macro
	if songStart<>offset(*)
		inform 2,"Missing smpsHeaderStartSong or smpsHeaderStartSongConvert"
	endif
	if smpsIsZ80=1
		littleEndian smpsUniVoiceBank
	else
		dc.w smpsUniVoiceBank-songStart
	endif
    endm

; Header macros for music (not for SFX)
; Header - Set up Channel Usage
smpsHeaderChan macro fm,psg
	dc.b \fm

	if narg=2
		dc.b \psg
	endif
    endm

; Header - Set up Tempo
smpsHeaderTempo macro div,mod
	dc.b \div,\mod
    endm

; Header - Set up Tick
smpsHeaderTick macro tick
	dc.b \tick
    endm

; Header - Set up DAC Channel
smpsHeaderDAC macro loc,pitch,vol
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w \loc-songStart
	endif
	if narg>=2
		dc.b \pitch
		if narg>=3
			dc.b \vol
		else
			dc.b $00
		endif
	else
		dc.w $00
	endif
    endm

; Header - Set up FM Channel
smpsHeaderFM macro loc,pitch,vol
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w loc-songStart
	endif
	dc.b \pitch,\vol
    endm

; Header - Set up PSG Channel
smpsHeaderPSG macro loc,pitch,vol,mod,voice
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w loc-songStart
	endif
	dc.b	\pitch,\vol,\mod,\voice
    endm

; Header - Set up SFX Channel
smpsHeaderSFX macro play, voice,loc,pitch,vol
	dc.b \play,\voice
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w loc-songStart
	endif
	dc.b \pitch,\vol
    endm
; ---------------------------------------------------------------------------------------------
; Header Macros
panNone set $00
panRight set $40
panLeft set $80
panCentre set $C0
panCenter set $C0 ; silly Americans :U
smpsPan	macro direction,amsfms
	dc.b $E0,direction+amsfms
    endm

smpsAlterNote	macro val
	dc.b $E1,val
    endm

smpsReturn	macro
	dc.b $F9
    endm

smpsFade	macro val
	dc.b	$E2
	if narg=1
		dc.b	val
	else
		dc.b	$FF
	endif
    endm

smpsAlterVol	macro val
	dc.b $E6,val
    endm

smpsNoteFill	macro val
	dc.b $E8,val
    endm

smpsAlterPitch	macro val
	dc.b $FB,val
    endm

smpsSetTempoMod	macro mod
	dc.b $FF,$00,mod
    endm

smpsSetTempoDiv	macro div
	dc.b $FF,$04,div
    endm

smpsSetVol	macro val
	dc.b $E4,val
    endm

smpsPSGAlterVol	macro vol
	dc.b	$EC,vol
    endm

smpsSetvoice	macro voice,songID
	if narg=2
		dc.b	$EF,voice|$80,songID+$81
	else
		dc.b	$EF,voice
	endif
    endm

smpsModSet	macro wait,speed,change,step
	dc.b $F0,wait,speed,change,step
    endm

smpsModOn	macro
	dc.b $F4,$80
    endm

smpsStop	macro
	dc.b $F2
    endm

smpsPSGform	macro form
	dc.b $F3,form
    endm

smpsModOff	macro
	dc.b $FA
    endm

smpsPSGvoice	macro voice
	dc.b $F5,voice
    endm

smpsJump	macro loc
	dc.b $F6
	Z80PtrROM \loc
    endm

smpsLoop	macro index,loops,loc
	dc.b $F7,index,loops
	Z80PtrROM \loc
    endm

smpsCall	macro loc
	dc.b $F8
	Z80PtrROM \loc
    endm

smpsFMAlterVol	macro val1,val2
	if narg=2
		dc.b $E5,val1,val2
	else
		dc.b $E6,val1
	endif
    endm

smpsStopFM	macro
	dc.b $E3
    endm

smpsSpindashRev	macro
	dc.b $E9
    endm

smpsPlayDACSample	macro sample
	dc.b $EA,(sample&$7F)
    endm

smpsConditionalJump macro index,loc
	dc.b $EB,index
	Z80PtrROM \loc
    endm

smpsSetNote	macro val
	dc.b $ED,val
    endm

smpsFMICommand	macro reg,val
	dc.b $EE,reg,val
    endm

smpsModChange2	macro fmmod,psgmod
	dc.b $F1,fmmod,psgmod
    endm

smpsModChange	macro val
	dc.b $F4,val
    endm

smpsContinuousLoop	macro loc
	dc.b $FC
	Z80PtrROM \loc
    endm

smpsAlternateSMPS	macro flag
	dc.b $FD,flag
    endm

smpsFM3SpecialMode	macro ind1,ind2,ind3,ind4
	dc.b $FE,ind1,ind2,ind3,ind4
    endm

smpsPlaySound	macro index
	dc.b $FF,$01,index
    endm

smpsHaltMusic	macro flag
	dc.b $FF,$02,flag
    endm

smpsMusPause	macro val
	dc.b $FF,$03,val
    endm

smpsSSGEG	macro op1,op2,op3,op4
	dc.b $FF,$05,op1,op3,op2,op4
    endm

smpsFMVolEnv	macro tone,mask
	dc.b $FF,$06,tone,mask
    endm

smpsFMFlutter	macro tone,mask
	smpsFMVolEnv tone,mask
    endm

smpsResetSpindashRev	macro
	dc.b $FF,$07
    endm

smpsVcFeedback macro val
vcFeedback set val
    endm

; Voices - Algorithm
smpsVcAlgorithm macro val
vcAlgorithm set val
    endm

; Voices - Detune
smpsVcDetune macro op1,op2,op3,op4
vcDT1 set op1
vcDT2 set op2
vcDT3 set op3
vcDT4 set op4
    endm

; Voices - Coarse-Frequency
smpsVcCoarseFreq macro op1,op2,op3,op4
vcCF1 set op1
vcCF2 set op2
vcCF3 set op3
vcCF4 set op4
    endm

; Voices - Rate Scale
smpsVcRateScale macro op1,op2,op3,op4
vcRS1 set op1
vcRS2 set op2
vcRS3 set op3
vcRS4 set op4
    endm

; Voices - Attack Rate
smpsVcAttackRate macro op1,op2,op3,op4
vcAR1 set op1
vcAR2 set op2
vcAR3 set op3
vcAR4 set op4
    endm

; Voices - Amplitude Modulation
smpsVcAmpMod macro op1,op2,op3,op4
vcAM1 set op1
vcAM2 set op2
vcAM3 set op3
vcAM4 set op4
    endm

; Voices - First Decay Rate
smpsVcDecayRate1 macro op1,op2,op3,op4
vcD1R1 set op1
vcD1R2 set op2
vcD1R3 set op3
vcD1R4 set op4
    endm

; Voices - Second Decay Rate
smpsVcDecayRate2 macro op1,op2,op3,op4
vcD2R1 set op1
vcD2R2 set op2
vcD2R3 set op3
vcD2R4 set op4
    endm

; Voices - Decay Level
smpsVcDecayLevel macro op1,op2,op3,op4
vcDL1 set op1
vcDL2 set op2
vcDL3 set op3
vcDL4 set op4
    endm

; Voices - Release Rate
smpsVcReleaseRate macro op1,op2,op3,op4
vcRR1 set op1
vcRR2 set op2
vcRR3 set op3
vcRR4 set op4
    endm

; Voices - Total Level
smpsVcTotalLevel macro op1,op2,op3,op4
vcTL1 set op1
vcTL2 set op2
vcTL3 set op3
vcTL4 set op4

	dc.b	(vcFeedback<<3)+vcAlgorithm
;   0     1     2     3     4     5     6     7
;%1000,%1000,%1000,%1000,%1010,%1110,%1110,%1111
vcTLMask4 set ((vcAlgorithm=7)<<7)
vcTLMask3 set ((vcAlgorithm>=4)<<7)
vcTLMask2 set ((vcAlgorithm>=5)<<7)
vcTLMask1 set $80
	dc.b	(vcDT4<<4)+vcCF4, (vcDT3<<4)+vcCF3, (vcDT2<<4)+vcCF2, (vcDT1<<4)+vcCF1
	dc.b	(vcRS4<<6)+vcAR4, (vcRS3<<6)+vcAR3, (vcRS2<<6)+vcAR2, (vcRS1<<6)+vcAR1
	dc.b	(vcAM4<<7)+vcD1R4,(vcAM3<<7)+vcD1R3,(vcAM2<<7)+vcD1R2,(vcAM1<<7)+vcD1R1
	dc.b	vcD2R4,           vcD2R3,           vcD2R2,           vcD2R1
	dc.b	(vcDL4<<4)+vcRR4, (vcDL3<<4)+vcRR3, (vcDL2<<4)+vcRR2, (vcDL1<<4)+vcRR1
	dc.b	vcTL4|vcTLMask4,  vcTL3|vcTLMask3,  vcTL2|vcTLMask2,  vcTL1|vcTLMask1
    endm
