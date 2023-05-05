; NOTE: This file is in DOS (ASCII) encoding !!! Use EDIT or change the font
; to TERMINAL if you're using any non-DOS text editor !!!

; TÊEE co.(TM) Z80 WAVPLAY version 0.1

; If you're going to make something out of this, don't hesitate to contact
; me if you need any help !!! I would like to know if you are going to use
; this in your program(s).

; If you modify this code you must send me the modified version of this !!!
; If you don't agree, you're not allowed to modify this code !!!

; E-mail   : tmeeco@hot.ee, tmeeco@vongodric.com
; Web-site : http://www.hot.ee/tmeeco

; Copyright (C) 2007 TÊEE co.(TM)

FMPORT1   EQU $4000  ; YM2612 Data port, set 1
FMPORT2   EQU $4001  ; YM2612 Index port, set 1
FMPORT3   EQU $4002  ; YM2612 Data port, set 2
FMPORT4   EQU $4003  ; YM2612 Index port, set 2
BANKREG   EQU $6000  ; Bank register

WAVADDRL  EQU $0040  ; WAV file address L
WAVADDRM  EQU $0041  ; WAV file address M
WAVADDRH  EQU $0042  ; WAV file address H
COMMAND   EQU $0043  ; Command from 68K program
TIMECONS  EQU $0044  ; Time constant
BANKS     EQU $0045  ; Bank switch counter
WAVLENL   EQU $0046  ; WAV lenght L
WAVLENM   EQU $0047  ; WAV lenght M
WAVLENH   EQU $0048  ; WAV lenght H
BPLAYL    EQU $0049  ; Bytes played L
BPLAYM    EQU $004A  ; Bytes played M
BPLAYH    EQU $004B  ; Bytes played H
BCPLACE   EQU $004C  ; stored BC value during whatever

; ########################### Code starts here ##############################

	ORG  $0000
	DI                  ; Disable ints
	LD   SP, $2000      ; Setup stack
	IM   $01            ; Set int mode 1
	JP   StartOfProg    ; Jump to start

	DB   "TÊEE co.(TM) Z80 WAVPLAY - ver 0.1 - 2007.JAN "


; ########################## Interrupt handler ##############################

	ORG  $0038
InterruptHandler     ; Do nothing in this program
	RETI


; ############################## Main code ##################################

	ORG  $0080
StartOfProg

	CALL ResetYM2612
	CALL InitYM2612

CheckIfSTOP1          ; Check if we're STOPPED
;	LD   A, (COMMAND)
;	OR   A
;	JP   Z, CheckIfSTOP1 ; Loop while COMMAND = 0

	CALL SetupBankStuff

PCMloop

	LD   A, (HL)         ; Load sample
	INC  HL              ; Increase address
	INC  DE              ; Increase Bank end counter
	LD   (BCPLACE), HL   ; PUSH HL - Use reg because its faster

	LD   (FMPORT2), A    ; Output sample, this code is slow enough (can't play
	                     ; over 32KHz) so we don't need to "wait before write
	                     ; loop". The rest of the code acts as it.

CheckIfSTOP           ; Check if we're STOPPED
;	LD   A, (COMMAND)
;	OR   A
;	JP   Z, CheckIfSTOP  ; Loop while COMMAND = 0

;	EXX                  ; Do nothing to get desired sample rate
;	LD   A, (TIMECONS)
;	LD   B, A            ; Comment all of it to get maximum speed while
DelayLoop             ; keeping full functionality
;	DJNZ DelayLoop
;	EXX
	rept 16
		NOP
	endr

; JP   WAVnotPlayed    ; Uncomment for maximum speed (+ static after the end)

	LD   HL, (BCPLACE)   ; POP  HL

	LD   A, $80          ; Check if bank is played
	CP   D
	JP   NZ, NoBankChange
	LD   HL, BANKS       ; Setup bank
	INC  (HL)
	LD   A, (BANKS)
	LD   HL, BANKREG
	LD   (HL), A
	RRA
	LD   (HL), A
	RRA
	LD   (HL), A
	RRA
	LD   (HL), A
	RRA
	LD   (HL), A
	RRA
	LD   (HL), A
	RRA
	LD   (HL), A
	XOR  A
	LD   (HL), A
	LD   (HL), A
	LD   DE, 0           ; Reset Bank end counter
	LD   H, $80          ; Start from start of Bank
NoBankChange

	JP   PCMloop

; ################## All the routines we're going to use ####################

SetupBankStuff        ; Setup Bank, address within Bank and Bank counter
	LD   A, (WAVADDRM)   ; Set Bank
	RLCA
	LD   HL, BANKREG
	LD   (HL), A
	LD   A, (WAVADDRH)
	LD   (HL), A
	RRA
	LD   (HL), A
	RRA
	LD   (HL), A
	RRA
	LD   (HL), A
	RRA
	LD   (HL), A
	RRA
	LD   (HL), A
	XOR  A               ; Setting last 2 bank-bits is pointless because I'm
	LD   (HL), A         ; going to load data only from the ROM area.
	LD   (HL), A

	LD   (BPLAYL), A     ; Reset Bytes played counter
	LD   (BPLAYM), A
	LD   (BPLAYH), A

	LD   A, (WAVADDRL)   ; Set Z80 address in Bank
	LD   L, A
	LD   A, (WAVADDRM)
	OR   $80
	LD   H, A

	LD   A, (WAVADDRM)   ; Set Bank count
	RLA
	AND  $01
	LD   B, A
	LD   A, (WAVADDRH)
	SLA  A
	OR   B
	LD   (BANKS), A

	LD   BC, 4           ; Get lenght of WAV
	ADD  HL, BC
	LD   A, (HL)
	LD   (WAVLENL), A
	INC  HL
	LD   A, (HL)
	LD   (WAVLENM), A
	INC  HL
	LD   A, (HL)
	LD   (WAVLENH), A
	LD   BC, 51          ; Skip the rest of the header
	ADD  HL, BC

	LD   A, H
	AND  $7F
	LD   D, A
	LD   E, L

	RET

ResetYM2612           ; Quick n' Dirty OPL2/OPL3 style reset on YM2612
	LD   B, $21
FMresetLoop           ; I know that I'm writing to some non-existant regs
	XOR  A               ; but if not, this won't be dirty anymore
	CALL WriteFMset1
	CALL WriteFMset2
	INC  B
	LD   A, $B6
	CP   B
	JP   NZ, FMresetLoop
	RET

InitYM2612
	LD   A, $80          ; Enable DAC
	LD   B, $2B
	CALL WriteFMset1
	LD   A, $C0          ; CH6 both channels
	LD   B, $B6
	CALL WriteFMset2
	LD   A, $80          ; Point to DAC reg
	LD   B, $2A
	CALL WriteFMset1
	RET

WriteFMset1           ; Write data to YM2612 register set 1
	LD   HL, FMPORT1     ; B = index, A = data
	BIT  7, (HL)
	JP   NZ, WriteFMset1
	LD   (HL), B
WriteFMset11
	BIT  7, (HL)
	JP   NZ, WriteFMset11
	LD   (FMPORT2), A
	RET

WriteFMset2           ; Write data to YM2612 register set 2
	LD   HL, FMPORT1     ; B = index, A = data
	BIT  7, (HL)
	JP   NZ, WriteFMset2
	LD   HL, FMPORT3
	LD   (HL), B
WriteFMset22
	BIT  7, (HL)
	JP   NZ, WriteFMset22
	LD   (FMPORT4), A
	RET

