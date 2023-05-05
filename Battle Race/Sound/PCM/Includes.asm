; ===========================================================================
; ---------------------------------------------------------------------------
; Play PCM
; ---------------------------------------------------------------------------

PlayPCM:
		lea	(Z80PCMROM).l,a2			; load Z80 ROM data
		lea	($A00000).l,a1				; load Z80 RAM space address
		move.w	#(Z80PCMROM_End-Z80PCMROM)-$01,d1	; set repeat times
		move.w	#$2000,d2				; prepare total Z80 size
		sub.w	d1,d2					; subtract repeat times from total size
		subq.w	#$02,d2					; decrease by 2 (for dbf)
		move.w	#$0100,($A11100).l			; request Z80 stop (ON)
		move.w	#$0100,($A11200).l			; request Z80 reset (OFF)
		btst.b	#$00,($A11100).l			; has the Z80 stopped yet?
		bne.s	*-$08					; if not, branch

PPCM_LoadZ80:
		move.b	(a2)+,(a1)+				; dump Z80 data to Z80 space
		dbf	d1,PPCM_LoadZ80				; repeat til done
		moveq	#$00,d1					; clear d1

PPCM_ClearZ80:
		move.b	d1,(a1)+				; clear remaining Z80 space
		dbf	d2,PPCM_ClearZ80			; repeat til done
		move.b	#$FF,($A00FF1).l			; set to play the track
		lea	($A00000+((Z80PCMPoint+$01)-Z80PCMROM)).l,a1 ; load PCM pointer address
		subi.w	#$98,d7					; set starting offset
		add.w	d7,d7					; multiply by word size
		move.b	(a0)+,(a1)+				; set pointer
		move.b	(a0),(a1)				; ''
		move.w	#$0000,($A11200).l			; request Z80 reset (ON)
		moveq	#$7F,d1					; set repeat times
		dbf	d1,*					; there's no way of checking for reset, so a manual delay is necessary
		move.w	#$0000,($A11100).l			; request Z80 stop (OFF)
		move.w	#$0100,($A11200).l			; request Z80 reset (OFF)
		rts						; return

; ===========================================================================
; ---------------------------------------------------------------------------
; Z80 ROM address - PCM tracker driver
; ---------------------------------------------------------------------------

	; --- Z80 Pointer Data ---

PontZ80		macro	Location
		dc.b	((Location)&$FF),(((Location)&$1F00)>>$08)
		endm

	; --- Z80 Tracker Data ---

DataZ80		macro	Sample
		dc.b	$00,(((Sample)&$7F8000)>>$0F)
		dc.b	((Sample)&$FF),((((Sample)&$7F00)>>$08)|$80)
		endm

	; --- Z80 Tracker Loop ---

LoopZ80		macro	Location
		dc.b	$FF
		dc.b	((Location)&$FF),(((Location)&$1F00)>>$08)
		endm

; ---------------------------------------------------------------------------

Z80PCMROM:	binclude "Sound\PCM\Z80PCM.bin"
Z80PCMPoint:	LoopZ80	MusicMuseumLoc-Z80PCMROM

; ---------------------------------------------------------------------------
; Music - Museum
; ---------------------------------------------------------------------------

MusicMuseumLoc:	DataZ80	Museum_Intro
		DataZ80	Museum_Intro
		DataZ80	Museum_Intro
		DataZ80	Museum_Intro

MusicMusLoop:
		DataZ80	Museum_Sect1
		DataZ80	Museum_Sect2
		DataZ80	Museum_Sect1
		DataZ80	Museum_Sect3
		DataZ80	Museum_Sect1
		DataZ80	Museum_Sect2
		DataZ80	Museum_Sect1
		DataZ80	Museum_Sect3
		DataZ80	Museum_Sect4
		DataZ80	Museum_Sect6
		DataZ80	Museum_Sect1
		DataZ80	Museum_Sect3
		DataZ80	Museum_Sect5
		DataZ80	Museum_Sect6
		DataZ80	Museum_Sect1
		DataZ80	Museum_Sect3
		LoopZ80	MusicMusLoop-Z80PCMROM

; ---------------------------------------------------------------------------

Z80PCMROM_End:	even

; ===========================================================================
; ---------------------------------------------------------------------------
; Tracker list
; ---------------------------------------------------------------------------

MusicMuseum:	PontZ80	MusicMuseumLoc-Z80PCMROM

; ===========================================================================
; ---------------------------------------------------------------------------
; Sample data
; ---------------------------------------------------------------------------

Museum_Intro:	binclude "Sound\PCM\Samples\Museum\Museum Intro.wav",$3A
Museum_Sect1:	binclude "Sound\PCM\Samples\Museum\Museum Section 1.wav",$3A
Museum_Sect2:	binclude "Sound\PCM\Samples\Museum\Museum Section 2.wav",$3A
Museum_Sect3:	binclude "Sound\PCM\Samples\Museum\Museum Section 3.wav",$3A
Museum_Sect4:	binclude "Sound\PCM\Samples\Museum\Museum Section 4.wav",$3A
Museum_Sect5:	binclude "Sound\PCM\Samples\Museum\Museum Section 5.wav",$3A
Museum_Sect6:	binclude "Sound\PCM\Samples\Museum\Museum Section 6.wav",$3A



		even

; ===========================================================================