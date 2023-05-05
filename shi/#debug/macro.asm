; ===========================================================================
; allows you to declare string to be converted to character map or mappings
asc2	macro	or, str, add
	dc.W strlen(\str)-1
	if narg=3
		asc \or, \str, \add
	else
		asc \or, \str, 0
	endif
    endm

asc	macro	or, str, _add
	if narg=3
.add	= _add
	else
.add	= 0
	endif

.lc = 0
	rept strlen(\str)
.cc		substr .lc+1,.lc+1,\str

		if '\.cc'=' '
			dc.\0 0|or+.add		; whitespace

		elseif ('\.cc'>='0')&('\.cc'<='9')
			dc.\0 ('\.cc'-'0'+1)|or+.add	; 0-9

		elseif ('\.cc'>='a')&('\.cc'<='z')
			dc.\0 ('\.cc'-'a'+$2B)|or+.add	; a-z

		elseif ('\.cc'>='A')&('\.cc'<='Z')
			dc.\0 ('\.cc'-'A'+$B)|or+.add	; A-Z

		elseif '\.cc'='!'
			dc.\0 $25|or+.add; !

		elseif '\.cc'='?'
			dc.\0 $26|or+.add; ?

		elseif '\.cc'='.'
			dc.\0 $27|or+.add; .

		elseif '\.cc'=','
			dc.\0 $28|or+.add; ,

		elseif '\.cc'=':'
			dc.\0 $29|or+.add; :

		elseif '\.cc'=';'
			dc.\0 $2A|or+.add; ;

		elseif '\.cc'='^'
			dc.\0 $45|or+.add; ^

		elseif '\.cc'='/'
			dc.\0 $46|or+.add; /

		elseif '\.cc'='\\'
			dc.\0 $47|or+.add; \

		elseif '\.cc'='*'
			dc.\0 $48|or+.add; *

		elseif '\.cc'='-'
			dc.\0 $49|or+.add; -

		elseif '\.cc'='|'
			dc.\0 $4A|or+.add; _ (wider)

		elseif '\.cc'='$'
			dc.\0 $4B|or+.add; $

		elseif '\.cc'='%'
			dc.\0 $4C|or+.add; %

		elseif '\.cc'='#'
			dc.\0 $4D|or+.add; #

		elseif '\.cc'='+'
			dc.\0 $4E|or+.add; +

		elseif '\.cc'='}'
			dc.\0 $4F|or+.add; ->

		elseif '\.cc'='{'
			dc.\0 $50|or+.add; <-

		elseif '\.cc'='@'
			dc.\0 $51|or+.add; @

		elseif '\.cc'='_'
			dc.\0 $52|or+.add; _

		elseif '\.cc'='('
			dc.\0 $53|or+.add; (

		elseif '\.cc'=')'
			dc.\0 $54|or+.add; )

		elseif '\.cc'='['
			dc.\0 $55|or+.add; [

		elseif '\.cc'=']'
			dc.\0 $56|or+.add; ]

		elseif '\.cc'='>'
			dc.\0 $57|or+.add; >

		elseif '\.cc'='<'
			dc.\0 $58|or+.add; <

		elseif '\.cc'='&'
			dc.\0 $59|or+.add; &

		elseif '\.cc'='~'
			dc.\0 $5A|or+.add; ~

		elseif '\.cc'="'"
			dc.\0 $5B|or+.add; '

		elseif '\.cc'='"'
			dc.\0 $5C|or+.add; "

		elseif '\.cc'='='
			dc.\0 $5D|or+.add; =

		elseif '\.cc'='`'
			dc.\0 $5E|or+.add; `

		else
			inform 2,"ASCII value failure: \.cc %d", .cc
		endif

.lc =		.lc+1
	endr
    endm

; ===========================================================================
crash	macro	id, frame
	move	sr,Crash_SR		; copy Status Register to RAM
	move.b	#id,CrashID		; set crash ID
	move.b	#frame,CrashStckFrm	; set stack frame size
	bra.w	CrashHandler		; run crash handler
    endm
; ===========================================================================
