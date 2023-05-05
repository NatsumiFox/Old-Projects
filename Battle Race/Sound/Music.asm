; ===========================================================================
; ---------------------------------------------------------------------------
; Some helpful macros
; ---------------------------------------------------------------------------

; do some action with all the songs. I am very pleasantly surprised this works in AS!
domusic		macro method
	method	TitleScreen
	method	MainMenu
	method	DataSelect
	method	SpecialSelect
	method	Options
	method	AIZ1
	method	AIZ2
	method	HCZ1
	method	HCZ2
	method	MGZ1
	method	MGZ2
	method	CNZ1
	method	CNZ2
	method	ICZ1
	method	ICZ2
	method	LBZ1
	method	LBZ2
	method	MHZ1
	method	MHZ2
	method	FBZ1
	method	FBZ2
	method	SOZ1
	method	SOZ2
	method	LRZ1
	method	LRZ2
	method	SSZ
	method	DEZ1
	method	DEZ2
	method	MiniAIZ
	method	MiniCNZ
	method	MiniLBZ
	method	MiniSSZ
	method	MiniDEZ2
	method	SpecialStage
	method	Drown
	method	InvicS3
	method	Invic
	method	KnuxS3
	method	Knux
	method	Minib_S3
	method	Minib_SK
	method	Boss
	method	FinalBoss
	method	ResultsSonic
	method	ResultsTie
	method	ResultsTails
	method	Continue
	method	Credits
	method	OAZ1
	method	Null
	method	Null
	method	Null
	method	Null
	method	Null
    endm

; simpler packed method for including Music names to generate pointer list
muspt		macro NAME
	dw zmake68kPtr(Snd_NAME)
    endm

; simpler packed method for including Music names to generate bank list
musbk		macro NAME
	db zmake68kBank(Snd_NAME)
    endm

; method for generating music equates for each song
musequ		macro NAME
Mus_NAME :=	id
id :=		id+1
    endm

id :=	$01
	domusic	musequ				; create equates
