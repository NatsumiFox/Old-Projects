DOS_LineLenght		equ 40		; amount of text in a line
DOS_OnScreenLines	equ 28-4	; amount of lines on-screen at once
DOS_DefTextDelay	equ 0		; amount of frames for next letter draw by default
DOS_MaxCursorItem	equ $2E		; the biggest character available for the cursor

DOS_txtoff		EQUR	a4	; register to store position of the text
DOS_txtreg		EQUR	a5	; register to read text from
DOS_VDP			EQUR	a6	; VDP control port
DOS_TxtItem		EQUR	d6	; next byte of text
DOS_DelayCounter	EQUR	d7	; counter for how many frames to wait for next letter to draw

		opt ae+
		rsset $FFFF0000	; RAM start

DOS_Text	rs.b DOS_LineLenght*820; history of 820 lines of text
		rs.w $80/2	; stack size
DOS_Stack	rs.b 0		; stack pointer
DOS_InputBox	rs.b DOS_LineLenght-2; user input box
DOS_CursorPos	rs.b 1		; current cursor position
DOS_TextDelay	rs.b 1		; delay left to draw next letter
DOS_TextPos	rs.l 1		; address of the current position on text data
DOS_TextEndPos	rs.l 1		; the actual end position of text
DOS_TextLines	rs.w 1		; last line VBlank recorded, will be used for line clears
DOS_CtrlMode	rs.b 1		; current control mode
DOS_Folder	rs.b 1		; current folder we are in
DOS_VBIstuck	rs.b 1		; if we are currently ending the input after VBI

		opt ae-

DOS_Text_End		equ $FE		; end marker for text
DOS_Text_NewLine	equ $FC		; end marker for current line
DOS_Text_GoBack		equ $FA		; go backwards x letters, where x is the next byte
DOS_Text_GoForward	equ $F8		; go forwards x letters, where x is the next byte
DOS_Text_Delay		equ $F6		; arbitrary delay. Next byte is the delay in frames
DOS_Text_Percent	equ $F4		; arbitrary precentage counter. Will generate random increments on % until 100%, with the next byte being the anded value for added % each x frames, where x is the byte after that
DOS_Text_ClockSPD	equ $F2		; prints the target clock speed of the processor

DOS_String	macro
	rept narg
.lc = 0
		rept strlen(\1)
.cc			substr .lc+1,.lc+1,\1

			if '\.cc'=' '
				dc.b 0

			elseif ('\.cc'>='0')&('\.cc'<='9')
				dc.b '\.cc'-'0'+1

			elseif ('\.cc'>='a')&('\.cc'<='x')
				dc.b '\.cc'-'a'+$12

			elseif ('\.cc'>='A')&('\.cc'<='X')
				dc.b '\.cc'-'A'+$12

			elseif ('\.cc'='z')|('\.cc'='Z')
				dc.b $11

			elseif ('\.cc'='y')|('\.cc'='Y')
				dc.b $10

			elseif '\.cc'='$'
				dc.b $B

			elseif ('\.cc'='-')
				dc.b $C

			elseif '\.cc'='='
				dc.b $D

			elseif '\.cc'='>'
				dc.b $E

			elseif '\.cc'='%'
				dc.b $2A

			elseif '\.cc'='.'
				dc.b $2B

			elseif '\.cc'=','
				dc.b $2C

			elseif '\.cc'='!'
				dc.b $2D

			elseif ('\.cc'='?')
				dc.b $2E

			elseif ('\.cc'='_')
				dc.b $2F

			else
			endif

.lc =			.lc+1
		endr
	shift
	endr
    endm