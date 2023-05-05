; ===========================================================================
; ---------------------------------------------------------------------------
; Define variables
; ---------------------------------------------------------------------------
sInitializer =	"I love Mr Otter!"
sIniLen =	16
sVersion =	sIniLen
sChecksum =	sVersion+2
sOptions =	sChecksum+2
sMode =		sOptions+1
sCurrVer =	"B1"

	if * > SRAM
		fatal "SRAM routines overlap with SRAM data! PC is $\{*}"
	endif
; ===========================================================================
; ---------------------------------------------------------------------------
; Validate SRAM
; ---------------------------------------------------------------------------

ValidateData:	dc.b sInitializer		; SRAM intialization string
		dc.b sCurrVer			; current version
		dc.w 0				; checksum
DefaultSRAM:	dc.b %10100111, 0		; options, mode

ValidateSRAM:
;		move.b	#1,SRAMreg		; Enable SRAM
;		lea	SRAM,a1			; get SRAM to a1	; NAT: Disabled SRAM
;		lea	ValidateData(pc),a2	; get validation string

;	rept sIniLen/4
;		cmpm.l	(a2)+,(a1)+		; check next longword
;		bne.s	InvalidSRAM		; if invalid, branch
;	endm

;		cmp.w	#sCurrVer,(a1)+		; check if the version is current
;		bne.s	OldVerSRAM		; if not, branch

;		move.w	(a1)+,d2		; get saved checksum
;		jsr	ChecksumSRAM(pc)	; calculate checksum
;		cmp.w	d2,d1			; check if they match
;		beq.s	LoadSRAM		; if do, load SRAM

; ===========================================================================
; ---------------------------------------------------------------------------
; reset SRAM data
; ---------------------------------------------------------------------------

InvalidSRAM:
.len =		ValidateSRAM-ValidateData
		lea	SRAM,a1			; get SRAM to a1
		lea	ValidateData(pc),a2	; get validation string

	rept .len/4
		move.l	(a2)+,(a1)+		; load next longword
	endm

	if (.len&2)<>0
		move.w	(a2)+,(a1)+		; load next word
	endif
		pea	SaveSRAM(pc)		; this is used to correctly calculate the checksum because I am lazy.

; ===========================================================================
; ---------------------------------------------------------------------------
; load SRAM data
; ---------------------------------------------------------------------------

		lea	DefaultSRAM,a1
		bra.s	LoadSRAM.2		; For systems with no SRAM support

LoadSRAM:
		lea	SRAM+sOptions,a1	; get SRAM options data to a1
.2		move.b	(a1)+,OptBits_Menu.w	; load options
		move.b	(a1)+,PlayMode.w	; load mode
;		sf	SRAMreg			; Disable SRAM
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; correct old SRAM versions
; ---------------------------------------------------------------------------

OldVerSRAM:
		move.w	-2(a1),d0		; copy version
		lea	VersionData(pc),a1	; get array of older versions
		moveq	#-2,d1			; counter for an array index
		moveq	#(VersionData.e-VersionData)/2-1,d2; set num counter

.index		addq.w	#2,d1			; add index
		cmp.w	(a1)+,d0		; check if same version
		dbne	d2,.index		; if not, branch

		cmp.w	#(VersionData-.vertbl)/2,d1; check if in range
		bhs.w	InvalidSRAM		; if not, branch

		move.w	.vertbl(pc,d1.w),d1	; Get version table offset
		jmp	.vertbl(pc,d1.w)	; jump to appropriate code

.vertbl		dc.w InvalidSRAM-.vertbl	; "B0"
		dc.w InvalidSRAM-.vertbl	; default
VersionData:	dc.b "B0"
.e

; ===========================================================================
; ---------------------------------------------------------------------------
; save SRAM data
; ---------------------------------------------------------------------------

SaveSRAM:
;		move.b	#1,SRAMreg		; Enable SRAM
		lea	SRAM+sOptions,a1	; get SRAM options data to a1
		lea	sChecksum-sOptions(a1),a2; get SRAM checksum to a2

		move.b	OptBits_Menu.w,(a1)	; save options
		move.b	PlayMode.w,sMode-sOptions(a1); save mode

		bsr.s	ChecksumSRAM		; get the checksum
		move.w	d1,(a2)			; save checksum
;		sf	SRAMreg			; Disable SRAM
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; calculate a checksum for SRAM data
; ---------------------------------------------------------------------------

ChecksumSRAM:
.fullsize = SRAMsz-(sChecksum+2)
		moveq	#0,d1			; clear checksum
		moveq	#(.fullsize/8)-1,d0; get loop counter

.add	rept 4
		add.w	(a1)+,d1		; add next word to checksum
	endm
		dbf	d0,.add			; loop until all is done

	if (.fullsize&4)<>0
		add.w	(a1)+,d1		; add next word to checksum
		add.w	(a1)+,d1		; ''
	endif

	if (.fullsize&2)<>0
		add.w	(a1)+,d1		; add next word to checksum
	endif
		rts
; ===========================================================================
