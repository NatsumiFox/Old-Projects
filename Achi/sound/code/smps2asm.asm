; ===============================================
; Based on Flamewing's SMPS2ASM, and S1SMPS2ASM by Marc (AKA Cinossu)
; Reworked and improved by Natsumi
; ===============================================
; this macro is created to emulate enum in AS
enum	macro	num, lable
; copy initial number for referencing later
.num	= num

	rept narg-1
\lable		set .num
.num =	.num+1
	shift
	endr
    endm
; ---------------------------------------------------------------------------------------------
; Note Equates
	enum $80+0, nRst
	enum nRst+1,nC0,nCs0,nD0,nEb0,nE0,nF0,nFs0,nG0,nAb0,nA0,nBb0,nB0
	enum nB0+1, nC1,nCs1,nD1,nEb1,nE1,nF1,nFs1,nG1,nAb1,nA1,nBb1,nB1
	enum nB1+1, nC2,nCs2,nD2,nEb2,nE2,nF2,nFs2,nG2,nAb2,nA2,nBb2,nB2
	enum nB2+1, nC3,nCs3,nD3,nEb3,nE3,nF3,nFs3,nG3,nAb3,nA3,nBb3,nB3
	enum nB3+1, nC4,nCs4,nD4,nEb4,nE4,nF4,nFs4,nG4,nAb4,nA4,nBb4,nB4
	enum nB4+1, nC5,nCs5,nD5,nEb5,nE5,nF5,nFs5,nG5,nAb5,nA5,nBb5,nB5
	enum nB5+1, nC6,nCs6,nD6,nEb6,nE6,nF6,nFs6,nG6,nAb6,nA6,nBb6,nB6
	enum nB6+1, nC7,nCs7,nD7,nEb7,nE7,nF7,nFs7,nG7,nAb7,nA7,nBb7
; ---------------------------------------------------------------------------------------------
sHold =		$E7	; E7 - Do not attack of next note (HOLD)
nMaxPSG	=	nA5
; ---------------------------------------------------------------------------------------------
; PSG volume envelope equates
	enum $00, 	  VolEnv_00,VolEnv_01,VolEnv_02,VolEnv_03,VolEnv_04
	enum VolEnv_04+1, VolEnv_05,VolEnv_06,VolEnv_07,VolEnv_08,VolEnv_09
	enum VolEnv_09+1, VolEnv_0A,VolEnv_0B,VolEnv_0C,VolEnv_0D,VolEnv_0E
	enum VolEnv_0E+1, VolEnv_0F,VolEnv_10,VolEnv_11,VolEnv_12,VolEnv_13
	enum VolEnv_13+1, VolEnv_14,VolEnv_15,VolEnv_16,VolEnv_17,VolEnv_18
	enum VolEnv_18+1, VolEnv_19,VolEnv_1A,VolEnv_1B,VolEnv_1C,VolEnv_1D
; ---------------------------------------------------------------------------------------------
; PSG modulation envelope equates
	enum $00, 	  ModEnv_00
; ---------------------------------------------------------------------------------------------
; DAC Equates
	enum $81,	dKick,dLowKick,dSnare,dClap,dHiTom,dTom,dLowTom,dDrumHi3D,dDrumLow3D
	enum dDrumLow3D+1,dLife,dHidden,dStarve,dKickSVA,dSnareSVA,dCrash,dLowSnare
	enum dLowSnare+1,dHatCl,dHatOp,dRee1,dRee2,dRee3,dRee4,dBye,dKys
; ---------------------------------------------------------------------------------------------
; Header Macros
sHeaderInit	macro
sPointZero =	*
sPatNum =	0
    endm

; Header - Set up Channel Usage
sHeaderCh	macro fm,psg
	dc.b \fm-1

	if narg=2
		if \fm>5
			inform 2,"You sure there are \fm FM channels?"
		endif

		dc.b \psg-1
		if \psg>3
			inform 2,"You sure there are \psg PSG channels?"
		endif
	endif
    endm

; Header - Set up Tempo and Tick Multiplier
sHeaderTempo	macro tmul,tempo
	dc.b \tmul-1,\tempo
    endm

; Header - Set up Tick Multiplier
sHeaderTick	macro tmul
	dc.b \tmul-1
    endm

; Header - Set up DAC Channel
sHeaderDAC	macro loc,det,samp
	dc.w \loc-sPointZero

	if narg>=2
		dc.b \det
		if narg>=3
			dc.b \samp
		else
			dc.b $00
		endif
	else
		dc.w $00
	endif
    endm

; Header - Set up FM Channel
sHeaderFM	macro loc,pitch,vol
	dc.w \loc-sPointZero
	dc.b \pitch,\vol
    endm

; Header - Set up PSG Channel
sHeaderPSG	macro loc,pitch,vol,detune,volenv
	dc.w \loc-sPointZero
	dc.b \pitch,\vol,\detune,\volenv
    endm

; Header - Set up SFX Channel
sHeaderSFX	macro flags,type,loc,pitch,vol
	dc.b \flags,\type
	dc.w \loc-sPointZero
	dc.b \pitch,\vol
    endm
; ---------------------------------------------------------------------------------------------
; Command Flag Macros and Equates. Based on the original s1smps2asm, and Flamewing's smps2asm
spNone set $00
spRight set $40
spLeft set $80
spCentre set $C0
spCenter set $C0
; ---------------------------------------------------------------------------------------------
; Macros for FM instruments
; Patches - Feedback

; Patches - Algorithm
spAlgorithm macro val, name
	if sPatNum<>0
		dcb.b 3,0	; align the patch
	endif

	if narg>1
pat_\name =	sPatNum
	endif

sPatNum =	sPatNum+1
spAl	= val
    endm

spFeedback macro val
spFe	= val
    endm

; Patches - Detune
spDetune macro op1,op2,op3,op4
spDe1	= op1
spDe2	= op2
spDe3	= op3
spDe4	= op4
    endm

; Patches - Multiple
spMultiple macro op1,op2,op3,op4
spMu1	= op1
spMu2	= op2
spMu3	= op3
spMu4	= op4
    endm

; Patches - Rate Scale
spRateScale macro op1,op2,op3,op4
spRS1	= op1
spRS2	= op2
spRS3	= op3
spRS4	= op4
    endm

; Patches - Attack Rate
spAttackRt macro op1,op2,op3,op4
spAR1	= op1
spAR2	= op2
spAR3	= op3
spAR4	= op4
    endm

; Patches - Amplitude Modulation
spAmpMod macro op1,op2,op3,op4
spAM1	= op1
spAM2	= op2
spAM3	= op3
spAM4	= op4
    endm

; Patches - Decay Rate
spDecayRt macro op1,op2,op3,op4
spDR1	= op1
spDR2	= op2
spDR3	= op3
spDR4	= op4
    endm

; Patches - Sustain Rate
spSustainRt macro op1,op2,op3,op4
spSR1	= op1
spSR2	= op2
spSR3	= op3
spSR4	= op4
    endm

; Patches - Sustain Level
spSustainLv macro op1,op2,op3,op4
spSL1	= op1
spSL2	= op2
spSL3	= op3
spSL4	= op4
    endm

; Patches - Release Rate
spReleaseRt macro op1,op2,op3,op4
spRR1	= op1
spRR2	= op2
spRR3	= op3
spRR4	= op4
    endm

; Patches - SSG-EG
spSSGEG macro op1,op2,op3,op4
spSS1	= op1
spSS2	= op2
spSS3	= op3
spSS4	= op4
    endm

; Patches - Total Level
spTotalLv macro op1,op2,op3,op4
spTL1	= op1
spTL2	= op2
spTL3	= op3
spTL4	= op4

; Construct the patch finally.
	dc.b	(spFe<<3)+spAl
;   0     1     2     3     4     5     6     7
;%1000,%1000,%1000,%1000,%1010,%1110,%1110,%1111
spTLMask4 set $80
spTLMask2 set ((spAl>=5)<<7)
spTLMask3 set ((spAl>=4)<<7)
spTLMask1 set ((spAl=7)<<7)

	dc.b (spDe1<<4)+spMu1, (spDe3<<4)+spMu3, (spDe2<<4)+spMu2, (spDe4<<4)+spMu4
	dc.b (spRS1<<6)+spAR1, (spRS3<<6)+spAR3, (spRS2<<6)+spAR2, (spRS4<<6)+spAR4
	dc.b (spAM1<<7)+spDR1, (spAM3<<7)+spDR3, (spAM2<<7)+spDR2, (spAM4<<7)+spDR4
	dc.b spSR1,            spSR3,            spSR2,            spSR4
	dc.b (spSL1<<4)+spRR1, (spSL3<<4)+spRR3, (spSL2<<4)+spRR2, (spSL4<<4)+spRR4
	dc.b spSS1,            spSS3,            spSS2,            spSS4
	dc.b spTL1|spTLMask1,  spTL3|spTLMask3,  spTL2|spTLMask2,  spTL4|spTLMask4
    endm
; ---------------------------------------------------------------------------------------------
; SMPS commands

; E0xx - Panning, AMS, FMS (PANAFMS - PAFMS_PAN)
sPan		macro pan, ams, fms
	if narg=1
		dc.b $E0,\pan

	elseif narg=2
		dc.b $E0,\pan|\ams
	else
		dc.b $E0,\pan|(\ams<<4)|\fms
	endif
    endm

; E1xx - Set channel frequency displacement to xx (DETUNE_SET)
ssDetune	macro val
	dc.b $E1,\val
    endm

; FF0Dxx - Add xx to channel frequency displacement (DETUNE)
saDetune	macro val
	dc.b $FF,$0D,\val
    endm

; E2xx - Set channel pitch to xx (TRANSPOSE - TRNSP_SET)
ssTranspose	macro val
	dc.b $E2,\val
    endm

; E3xx - Add xx to channel pitch (TRANSPOSE - TRNSP_ADD)
saTranspose	macro val
	dc.b $E3,\val
    endm

; E4xx - Stop note after xx frames (NOTE_STOP - NSTOP_NORMAL)
sNoteTimeOut	macro val
	dc.b $E4,\val
    endm

; E5xx - Set channel tick multiplier to xx (TICK_MULT - TMULT_CUR)
ssTickMulCh	macro val
	dc.b $E5,\val-1
    endm

; E6xx - Set global tick multiplier to xx (TICK_MULT - TMULT_ALL)
ssTickMul	macro val
	dc.b $E6,\val-1
    endm

; E8xx - Add xx to music tempo (TEMPO - TEMPO_ADD)
saTempo		macro val
	dc.b $E8,\val
    endm

; E9xx - Set music tempo to xx (TEMPO - TEMPO_SET)
ssTempo		macro val
	dc.b $E9,\val
    endm

; FF06xx - Add xx to music tempo if in PAL region (TEMPO - TEMPO_ADD_PAL)
saTempoPAL	macro val
	dc.b $FF,$06,\val
    endm

; FF06xx - Add xx to music tempo if in NTSC region (TEMPO - TEMPO_ADD_NTSC)
saTempoNTSC	macro val
	dc.b $FF,$07,\val
    endm

; EAxx - Set patch/voice/sample to xx (INSTRUMENT - INS_N_FM / INS_N_PSG / INS_N_DAC)
sVolEnvPSG	macro val
	dc.b $EA,\val
    endm

; EAxx - Set patch/voice/sample to xx (INSTRUMENT - INS_N_FM / INS_N_PSG / INS_N_DAC)
sPatFM		macro val
	dc.b $EA,\val
    endm

sVoice		macro val
	dc.b $EA,\val
    endm

; EB - Turn on Modulation (MOD_SET - MODS_ON)
sModOn		macro
	dc.b $EB
    endm

; EC - Turn off Modulation (MOD_SET - MODS_OFF)
sModOff		macro
	dc.b $EC
    endm

; EDxx - Add xx to channel volume (VOLUME - VOL_NN_FM / VOL_NN_PSG)
saVolPSG	macro vol
	dc.b $ED,\vol
    endm

; EDxx - Add xx to channel volume (VOLUME - VOL_NN_FM / VOL_NN_PSG)
saVolFM	macro vol
	dc.b $ED,\vol
    endm

; EDxx - Add xx to channel volume (VOLUME - VOL_NN_FM / VOL_NN_PSG)
saVol		macro vol
	dc.b $ED,\vol
    endm

; EExx - Set channel volume to xx (VOLUME - VOL_ABS)
ssVol		macro vol
	dc.b $EE,\vol
    endm

; EFxxxx - Set LFO (SET_LFO - LFO_AMSEN)
ssLFO		macro reg, ams, fms, pan
	if narg=2
		dc.b $EF,\reg,\ams

	elseif narg=3
		dc.b $EF,\reg,(\ams<<4)|\fms

	else
		dc.b $EF,\reg,(\ams<<4)|\fms|\pan
	endif
    endm

; F0wwxxyyzz - Modulation
;  ww: wait time
;  xx: modulation speed
;  yy: change per step
;  zz: number of steps
; (MOD_SETUP)
ssMod68k	macro wait,speed,change,step
	dc.b $F0,\wait,\speed,\change,\step
    endm

; F1xxxx - Set channel frequency to xxxx (CHFREQ_SET)
ssFreq		macro freq
	dc.b $F1
	dc.w \freq
    endm

; F2xxxx - Set channel modulation frequency to xxxx (CHFREQ_SET)
ssModFreq	macro freq
	dc.b $F2
	dc.w \freq
    endm

; F3xx - PSG Noise command xx (PSG_NOISE - PNOIS_SET)
sNoisePSG	macro val
	dc.b $F3,\val
    endm

; F4xxxx - Keep looping back to xxx each time the SFX is being played (CONT_SFX)
sCont		macro loc
	dc.b $F4
	dc.w \loc-*-1
    endm

; F5 - End of channel (TRK_END - TEND_STD)
sStop		macro
	dc.b $F5
    endm

; F6xxxx - Jump to xxxx (GOTO)
sJump		macro loc
	dc.b $F6
	dc.w \loc-*-1
    endm

; F7xxyyzzzz - Loop back to zzzz yy times, xx being the loop index for loop recursion fixing (LOOP)
sLoop		macro index,loops,loc
	dc.b $F7,\index
	dc.w \loc-*-1
	dc.b \loops
    endm

; F8xxxx - Call pattern at xxxx, saving return point (GOSUB)
sCall		macro loc
	dc.b $F8
	dc.w \loc-*-1
    endm

; F9 - Return (RETURN)
sRet		macro
	dc.b $F9
    endm

; FAyyxx - Set communications byte yy to xx (SET_COMM - SPECIAL)
sComm		macro num, val
	dc.b $FA,\num,\val
    endm

; FBxyzz - Get communications byte y, and compare zz with it using condition x (COMM_CONDITION)
sCond		macro num, cond, val
	dc.b $FB,\num|(\cond<<4), \val
    endm

; FC - Reset condition (COND_RESET)
sCondOff	macro
	dc.b $FC
    endm

; FF08xyzz - Get RAM address pointer offset by y, and compare zz with it using condition x (COMM_CONDITION_EXTRA)
sCondReg	macro off, cond, val
	dc.b $FF,$08,\off|(\cond<<4), \val
    endm

; FD - Play another music/sfx (SND_CMD)
sPlayMus	macro id
	dc.b $FD,\id
    endm

; FE - YM command (YMCMD)
sCmdYM		macro reg, val
	dc.b $FE,\reg,\val
    endm

; FF00xx - Play sample xx on DAC1 (PLAY_DAC - DAC1)
sPlaySamp1	macro chan, id
	dc.b $FF,$00,\id
    endm

; FF01xx - Play sample xx on DAC1 (PLAY_DAC - DAC2)
sPlaySamp2	macro chan, id
	dc.b $FF,$01,\id
    endm

; FF02 - Use sample DAC mode (DAC_MODE - DACM_SAMP)
sModeSampDAC	macro
	dc.b $FF,$02
    endm

; FF03 - Use pitch DAC mode (DAC_MODE - DACM_NOTE)
sModePitchDAC	macro
	dc.b $FF,$03
    endm

; FF04 - Increment spindash rev counter (TODO!)
sSpinRev	macro
	dc.b $FF,$04
    endm

; FF05 - Reset spindash rev counter (TODO!)
sSpinReset	macro
	dc.b $FF,$05
    endm

; FF06xx - Add xx to music tempo if in PAL region (TEMPO - TEMPO_ADD_PAL)
saTempoPAL	macro tempo
	dc.b $FF,$06, \tempo
    endm

; FF07xx - Add xx to music tempo if in NTSC region (TEMPO - TEMPO_ADD_NTSC)
saTempoNTSC	macro tempo
	dc.b $FF,$07, \tempo
    endm

; FF 08 xy zz - Get RAM address pointer offset by y,
; and compare zz with it using condition x (COMM_CONDITION_EXTRA)
sCondReg	macro off, cond, val
	dc.b $FF, $08, \off|(cond<<4), \val
    endm

; FF09/FF0A - Set pitch slide on or off
sPitchSlide	macro type
	dc.b $FF, $09+\type
    endm

; FF0A - Set pitch slide off
sPitchSlideOff	macro
	dc.b $FF, $09
    endm

; FF09 - Set pitch slide on
sPitchSlideOn	macro
	dc.b $FF, $0A
    endm

; FF0B - Fade to pause state (special)
sFadePause	macro
	dc.b $FF, $0B
    endm

; FF0C - Fade to unpause state (special)
sFadeUnpause	macro
	dc.b $FF, $0C
    endm
