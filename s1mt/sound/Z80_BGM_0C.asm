
; ---------------------------------------------------------------
; Created by Terpsichorean-2-SMPS v.1.00
; 2015, Vladikcomper
; ---------------------------------------------------------------

Z80_BGM_0C:
; ---------------------------------------------------------------
; Music Header
; ---------------------------------------------------------------

	dc.w	Z80_BGM_0C_Voices-Z80_BGM_0C			; Voice bank offset
	dc.w	$8700			; Number of Z80_BGM_0C_FM/PSG channels
	dc.w	$0100			; Tempo modifier

	dc.w	$0008, $F200		; Disable DAC channel
	dc.w	Z80_BGM_0C_FM1-Z80_BGM_0C, 99
	dc.w	Z80_BGM_0C_FM2-Z80_BGM_0C, 99
	dc.w	Z80_BGM_0C_FM3-Z80_BGM_0C, 99
	dc.w	Z80_BGM_0C_FM4-Z80_BGM_0C, 99
	dc.w	Z80_BGM_0C_FM5-Z80_BGM_0C, 99
	dc.w	Z80_BGM_0C_FM6-Z80_BGM_0C, 99

; ---------------------------------------------------------------
; Music Program
; ---------------------------------------------------------------

Z80_BGM_0C_FM5:
	smpsAlterVol 0
	dc.b	$FC, $53
	smpsAlterNote $06
	dc.b	nRst, $15
	smpsJump Z80_BGM_0C_FM_51
Z80_BGM_0C_FM3:
	smpsAlterVol 0
	dc.b	$FC, $59
Z80_BGM_0C_FM_51:
	smpsAlterPitch 0
	smpsAlterPitch 48
	; Unsupported command: 1F 03
Z80_BGM_0C_FM_59:
	smpsFMvoice	$08
	dc.b	$81, $5C, nRst, $04
	smpsAlterPitch -12
	dc.b	$8B, $5C, nRst, $04
	dc.b	$89, $5C, nRst, $04
	smpsFMvoice	$07
	dc.b	$89, $5C, nRst, $04
	smpsAlterPitch 12
	smpsFMvoice	$08
	dc.b	$81, $5C, nRst, $04
	smpsAlterPitch -12
	dc.b	$8B, $2C, nRst, $04
	dc.b	$89, $2C, nRst, $04
	smpsFMvoice	$07
	dc.b	$89, $5C, nRst, $04
	dc.b	$8B, $5C, nRst, $04
	smpsAlterPitch 12
	; Unsupported command: 1F 01
	smpsLoop 0, 2, Z80_BGM_0C_FM_59
	; Unsupported command: 1F FFFFFFFE
	smpsAlterPitch 0
	smpsAlterPitch 24
	smpsCall Z80_BGM_0C_FM_9D
	; Unsupported command: 17 00
	smpsJump Z80_BGM_0C_FM_51
Z80_BGM_0C_FM_9D:
	smpsFMvoice	$06
	; Unsupported command: 17 09 09
	; Unsupported command: 1F 03
Z80_BGM_0C_FM_A8:
	dc.b	$8B, $0A, nRst, $02
	dc.b	nRst, $04, nRst, $02
	dc.b	$8B, $0A, nRst, $02
	dc.b	nRst, $04, nRst, $02
	dc.b	$8C, $24, nRst, $02
	smpsAlterPitch 12
	dc.b	$81
	dc.b	$82
	dc.b	$83
	dc.b	$84
	dc.b	$85
	dc.b	$86
	dc.b	$87
	dc.b	$88
	dc.b	$89
	dc.b	$8A
	dc.b	$8B
	dc.b	$8C, $30, nRst, $02
	dc.b	$8B
	dc.b	$8A
	dc.b	$89
	dc.b	$88
	dc.b	$87
	dc.b	$86
	dc.b	$85
	dc.b	$84
	dc.b	$83
	dc.b	$82
	dc.b	$81
	smpsAlterPitch -12
	dc.b	$8C, $04, nRst, $02
	smpsAlterPitch 12
	dc.b	$82, $10, nRst, $02
	smpsAlterPitch -12
	dc.b	$8B, $0A, nRst, $02
	dc.b	nRst, $04, nRst, $02
	dc.b	$8B, $0A, nRst, $02
	dc.b	nRst, $04, nRst, $02
	dc.b	$8C, $0A, nRst, $02
	dc.b	nRst, $04, nRst, $02
	smpsAlterPitch 12
	dc.b	$82, $28, nRst, $02
	dc.b	$83, $18, nRst, $02
	dc.b	$84
	dc.b	$85
	dc.b	$86
	dc.b	$87
	dc.b	$88
	dc.b	$89
	dc.b	$8A
	dc.b	$8B
	dc.b	$8C
	smpsAlterPitch 12
	dc.b	$81
	dc.b	$82
	dc.b	$83
	dc.b	$82, $01
	dc.b	$81
	smpsAlterPitch -12
	dc.b	$8C
	dc.b	$8B
	dc.b	$8A
	dc.b	$8B
	dc.b	$8C
	smpsAlterPitch 12
	dc.b	$81
	dc.b	$82
	dc.b	$83, $18, nRst, $02
	dc.b	$82, $01
	dc.b	$81
	smpsAlterPitch -12
	dc.b	$8C
	dc.b	$8B
	dc.b	$8A
	dc.b	$89
	dc.b	$88
	dc.b	$87
	dc.b	$86
	dc.b	$85
	dc.b	$84
	smpsAlterPitch -12
	smpsLoop 0, 2, Z80_BGM_0C_FM_A8
	smpsReturn
Z80_BGM_0C_FM6:
	smpsFMvoice	$09
	smpsAlterVol 0
	dc.b	$FC, $53
	smpsAlterPitch 0
	smpsAlterPitch 36
	smpsAlterNote $05
	; Unsupported command: 1F 03
Z80_BGM_0C_FM_125:
	dc.b	$81, $5D, nRst, $03
	dc.b	$81, $5D, nRst, $03
	dc.b	$81, $5D, nRst, $03
	dc.b	$81, $5D, nRst, $03
	dc.b	$81, $5D, nRst, $03
	dc.b	$81, $5D, nRst, $03
	dc.b	$81, $5D, nRst, $03
	dc.b	$83, $5D, nRst, $03
	; Unsupported command: 1F 01
	smpsLoop 0, 2, Z80_BGM_0C_FM_125
	; Unsupported command: 1F FFFFFFFE
	smpsAlterVol 0
	dc.b	$FC, $5B
	smpsAlterPitch 0
	smpsAlterPitch 24
	; Unsupported command: 1F FFFFFFF9
	smpsAlterNote $00
	smpsCall Z80_BGM_0C_FM_9D
	smpsJump Z80_BGM_0C_FM6
Z80_BGM_0C_FM4:
	smpsFMvoice	$05
	smpsAlterVol 0
	dc.b	$FC, $56
	smpsAlterNote $0A
	dc.b	nRst, $01
	smpsJump Z80_BGM_0C_FM_151
Z80_BGM_0C_FM2:
	smpsFMvoice	$04
	smpsAlterVol 0
	dc.b	$FC, $56
Z80_BGM_0C_FM_151:
	smpsAlterPitch 0
	smpsAlterPitch 12
	; Unsupported command: 1F 03
Z80_BGM_0C_FM_159:
Z80_BGM_0C_FM_15B:
Z80_BGM_0C_FM_15D:
	smpsAlterPitch 12
	dc.b	$81, $05, nRst, $01
	smpsAlterPitch -12
	dc.b	$81, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$81, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$81, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$81, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$81, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$81, $05, nRst, $01
	smpsAlterPitch 12
	dc.b	$81, $05, nRst, $01
	smpsAlterPitch -12
	dc.b	$81, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$81, $05, nRst, $01
	smpsLoop 2, 3, Z80_BGM_0C_FM_15D
	smpsAlterPitch 12
	dc.b	$81, $05, nRst, $01
	smpsAlterPitch -12
	dc.b	$81, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$81, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$81, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$81, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$81, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$81, $05, nRst, $01
	dc.b	$86, $05, nRst, $01
	dc.b	$88, $05, nRst, $01
	dc.b	$8B, $05, nRst, $01
	smpsAlterPitch 12
	dc.b	$81, $05, nRst, $01
	smpsAlterPitch -12
	smpsLoop 1, 2, Z80_BGM_0C_FM_15B
	; Unsupported command: 1F 01
	smpsLoop 0, 2, Z80_BGM_0C_FM_159
	; Unsupported command: 1F FFFFFFFE
	smpsAlterPitch 0
	smpsAlterPitch 12
	smpsAlterVol $FFFFFFFD
	; Unsupported command: 1F 03
Z80_BGM_0C_FM_194:
Z80_BGM_0C_FM_196:
	smpsAlterPitch 12
	dc.b	$84, $05, nRst, $01
	smpsAlterPitch -12
	dc.b	$84, $05, nRst, $01
	dc.b	$84, $05, nRst, $01
	smpsLoop 1, 2, Z80_BGM_0C_FM_196
	smpsAlterPitch 12
	dc.b	$83, $0B, nRst, $01
	smpsAlterPitch -12
Z80_BGM_0C_FM_1A2:
	dc.b	nRst, $05, nRst, $01
	dc.b	$83, $0B, nRst, $01
	dc.b	$83, $05, nRst, $01
	dc.b	$83, $05, nRst, $01
	dc.b	$85, $05, nRst, $01
	dc.b	$88, $05, nRst, $01
	dc.b	$8A, $05, nRst, $01
	smpsLoop 1, 2, Z80_BGM_0C_FM_1A2
	smpsAlterPitch 12
	dc.b	$83, $05, nRst, $01
	smpsAlterPitch -12
	dc.b	$83, $0B, nRst, $01
	dc.b	$83, $05, nRst, $01
	smpsAlterPitch 12
	dc.b	$81, $05, nRst, $01
	dc.b	$83, $11, nRst, $01
	smpsAlterPitch -12
Z80_BGM_0C_FM_1B8:
	smpsAlterPitch 12
	dc.b	$84, $05, nRst, $01
	smpsAlterPitch -12
	dc.b	$84, $05, nRst, $01
	dc.b	$84, $05, nRst, $01
	smpsLoop 1, 2, Z80_BGM_0C_FM_1B8
	smpsAlterPitch 12
	dc.b	$82, $05, nRst, $01
	smpsAlterPitch -12
	dc.b	$82, $05, nRst, $01
	dc.b	$82, $05, nRst, $01
	dc.b	$8C, $05, nRst, $01
	smpsAlterPitch -12
	dc.b	$8C, $05, nRst, $01
	dc.b	$8C, $05, nRst, $01
	dc.b	$8C, $05, nRst, $01
	smpsAlterPitch 12
	dc.b	$8C, $05, nRst, $01
	smpsAlterPitch -12
	dc.b	$8C, $05, nRst, $01
	dc.b	$8C, $05, nRst, $01
	smpsAlterPitch 12
	dc.b	$8A, $05, nRst, $01
	smpsAlterPitch -12
	dc.b	$8A, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$8A, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$8A, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$8A, $05, nRst, $01
	dc.b	$8A, $05, nRst, $01
	dc.b	$8A, $05, nRst, $01
	dc.b	nRst, $05, nRst, $01
	dc.b	$8A, $05, nRst, $01
	smpsAlterPitch 12
	dc.b	$83, $05, nRst, $01
	dc.b	$85, $05, nRst, $01
	dc.b	$88, $05, nRst, $01
	dc.b	$8A, $05, nRst, $01
	smpsLoop 0, 2, Z80_BGM_0C_FM_194
	smpsAlterVol $03
	smpsJump Z80_BGM_0C_FM_151
Z80_BGM_0C_FM1:
	; Unsupported command: 00 FFFFFFC5
	smpsAlterVol 0
	dc.b	$FC, $5B
	smpsAlterPitch 0
	smpsAlterPitch 36
	; Unsupported command: 1F 00
	; Unsupported command: 15 01 01 FFFFFFE0 FFFFFFFF FFFFFFFF
Z80_BGM_0C_FM_21B:
Z80_BGM_0C_FM_21D:
	smpsFMvoice	$01
	dc.b	$85, $06
	smpsFMvoice	$00
	dc.b	$88
Z80_BGM_0C_FM_225:
	smpsFMvoice	$02
	dc.b	$81, $06
	smpsFMvoice	$00
	dc.b	$88
	smpsLoop 2, 5, Z80_BGM_0C_FM_225
	smpsFMvoice	$01
	dc.b	$85
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$02
	dc.b	$81
	smpsFMvoice	$00
	dc.b	$88
	smpsLoop 1, 3, Z80_BGM_0C_FM_21D
	smpsFMvoice	$01
	dc.b	$85
	smpsFMvoice	$00
	dc.b	$88
Z80_BGM_0C_FM_241:
	smpsFMvoice	$02
	dc.b	$81, $06
	smpsFMvoice	$00
	dc.b	$88
	smpsLoop 1, 5, Z80_BGM_0C_FM_241
	smpsFMvoice	$01
	dc.b	$85
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$01
	dc.b	$85
	dc.b	$85
	smpsLoop 0, 2, Z80_BGM_0C_FM_21B
	smpsAlterVol $FFFFFFFD
Z80_BGM_0C_FM_256:
Z80_BGM_0C_FM_258:
	smpsFMvoice	$00
	dc.b	$88, $06
	smpsFMvoice	$02
	dc.b	$81
	dc.b	$81
	dc.b	$81
	smpsFMvoice	$01
	dc.b	$85, $0C
	smpsFMvoice	$02
	dc.b	$81, $06
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$02
	dc.b	$81
	smpsFMvoice	$00
	dc.b	$88
	dc.b	$88
	smpsFMvoice	$02
	dc.b	$81
	smpsFMvoice	$01
	dc.b	$85, $0C
	smpsFMvoice	$00
	dc.b	$88, $06
	smpsFMvoice	$02
	dc.b	$81
	smpsLoop 1, 3, Z80_BGM_0C_FM_258
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$02
	dc.b	$81
	dc.b	$81
	dc.b	$81
	smpsFMvoice	$01
	dc.b	$85, $0C
	smpsFMvoice	$02
	dc.b	$81, $06
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$01
	dc.b	$85
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$01
	dc.b	$85
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$01
	dc.b	$85
	dc.b	$85
	dc.b	nRst
	dc.b	$85
Z80_BGM_0C_FM_2A5:
	smpsFMvoice	$00
	dc.b	$88, $06
	smpsFMvoice	$02
	dc.b	$81
	dc.b	$81
	dc.b	$81
	smpsFMvoice	$01
	dc.b	$85, $0C
	smpsFMvoice	$02
	dc.b	$81, $06
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$02
	dc.b	$81
	smpsFMvoice	$00
	dc.b	$88
	dc.b	$88
	smpsFMvoice	$02
	dc.b	$81
	smpsFMvoice	$01
	dc.b	$85, $0C
	smpsFMvoice	$00
	dc.b	$88, $06
	smpsFMvoice	$02
	dc.b	$81
	smpsLoop 1, 3, Z80_BGM_0C_FM_2A5
	smpsFMvoice	$00
	dc.b	$88
	dc.b	$88
	smpsFMvoice	$01
	dc.b	$85
	dc.b	$85
	smpsFMvoice	$03
	dc.b	$86, $02
	dc.b	$86, $04
	dc.b	$86, $06
	dc.b	$82
	dc.b	$82
	smpsFMvoice	$01
	dc.b	$85
	dc.b	$85
	smpsFMvoice	$03
	dc.b	$86, $02
	dc.b	$86, $04
	smpsFMvoice	$00
	dc.b	$88, $06
	smpsFMvoice	$01
	dc.b	$85
	smpsFMvoice	$03
	dc.b	$82
	smpsFMvoice	$01
	dc.b	$85
	smpsFMvoice	$03
	smpsAlterPitch -12
	dc.b	$89
	smpsAlterPitch 12
	smpsLoop 0, 1, Z80_BGM_0C_FM_256
Z80_BGM_0C_FM_2FB:
Z80_BGM_0C_FM_2FD:
	smpsFMvoice	$01
	dc.b	$85, $06
	smpsFMvoice	$00
	dc.b	$88
	dc.b	$88
	smpsLoop 1, 2, Z80_BGM_0C_FM_2FD
	smpsFMvoice	$01
	dc.b	$85
	dc.b	$85
Z80_BGM_0C_FM_30B:
	smpsFMvoice	$00
	dc.b	$88, $06
	dc.b	$88
	smpsFMvoice	$02
	dc.b	$81
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$01
	dc.b	$85, $0C
	smpsFMvoice	$02
	dc.b	$81, $06
	dc.b	$81
	smpsLoop 1, 2, Z80_BGM_0C_FM_30B
	smpsFMvoice	$01
	dc.b	$85
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$02
	dc.b	$81
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$01
	dc.b	$85
	smpsAlterVol $05
	dc.b	$85, $03
	dc.b	$85
	smpsAlterVol $FFFFFFFB
	dc.b	$85, $06
	dc.b	$85
Z80_BGM_0C_FM_339:
	smpsFMvoice	$01
	dc.b	$85, $06
	smpsFMvoice	$00
	dc.b	$88
	dc.b	$88
	smpsLoop 1, 4, Z80_BGM_0C_FM_339
	smpsFMvoice	$01
	dc.b	$85
	dc.b	$85
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$01
	dc.b	$85
	smpsFMvoice	$00
	dc.b	$88
	dc.b	$88
	smpsFMvoice	$02
	dc.b	$81
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$01
	dc.b	$85, $0C
	smpsFMvoice	$02
	dc.b	$81, $06
	dc.b	$81
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$01
	dc.b	$85
	smpsFMvoice	$02
	dc.b	$81
	smpsFMvoice	$01
	dc.b	$85
	smpsFMvoice	$00
	dc.b	$88
	smpsFMvoice	$01
	dc.b	$85
	dc.b	$85
	dc.b	$85
	smpsLoop 0, 2, Z80_BGM_0C_FM_2FB
	smpsAlterVol $03
	smpsJump Z80_BGM_0C_FM_21B
; ---------------------------------------------------------------
; Z80_BGM_0C_Voices
; ---------------------------------------------------------------

Z80_BGM_0C_Voices:
	; Voice $00 (Z80_BGM_0C_FM)
	dc.b	$10, $07, $61, $73, $20, $1F, $1C, $1C, $1F, $1C, $17, $18, $05, $04, $11, $13, $0D, $F1, $08, $78, $18, $00, $00, $0E, $00
	; Voice $01 (Z80_BGM_0C_FM)
	dc.b	$3C, $0B, $02, $15, $71, $18, $1F, $17, $1F, $10, $10, $14, $13, $00, $0C, $1B, $0B, $3F, $1F, $1F, $1F, $00, $08, $0F, $01
	; Voice $02 (Z80_BGM_0C_FM)
	dc.b	$3C, $08, $05, $04, $05, $1F, $1F, $1F, $1F, $02, $11, $1F, $11, $0B, $12, $00, $16, $2F, $7F, $0F, $8F, $04, $0A, $00, $08
	; Voice $03 (Z80_BGM_0C_FM)
	dc.b	$3C, $0F, $25, $09, $01, $1F, $9F, $1F, $5F, $00, $11, $15, $09, $00, $0B, $1F, $1F, $00, $46, $2F, $9F, $00, $03, $03, $00
	; Voice $04 (Z80_BGM_0C_FM)
	dc.b	$03, $79, $35, $31, $01, $5F, $1F, $1F, $5F, $0F, $16, $0B, $1B, $00, $00, $00, $00, $A6, $05, $05, $04, $10, $26, $1F, $05
	; Voice $05 (Z80_BGM_0C_FM)
	dc.b	$30, $2A, $0A, $71, $01, $1F, $1F, $1F, $1F, $15, $0C, $06, $0F, $02, $01, $01, $01, $76, $73, $33, $26, $07, $1A, $20, $01
	; Voice $06 (Z80_BGM_0C_FM)
	dc.b	$38, $7C, $54, $36, $08, $1B, $13, $1A, $1B, $0E, $00, $08, $0C, $00, $00, $03, $01, $36, $06, $14, $17, $1A, $19, $18, $05
	; Voice $07 (Z80_BGM_0C_FM)
	dc.b	$3C, $76, $3C, $34, $74, $1F, $1F, $16, $1F, $10, $00, $12, $0B, $01, $03, $01, $03, $33, $05, $24, $05, $10, $0B, $0A, $0B
	; Voice $08 (Z80_BGM_0C_FM)
	dc.b	$3C, $74, $38, $33, $73, $1F, $1F, $16, $1F, $10, $00, $12, $0B, $01, $03, $01, $03, $33, $05, $24, $05, $10, $0B, $0A, $0B
	; Voice $09 (Z80_BGM_0C_FM)
	dc.b	$0C, $36, $76, $38, $78, $1F, $1F, $1F, $1F, $0A, $10, $08, $10, $04, $03, $04, $03, $15, $14, $15, $14, $1A, $0B, $1A, $0F
