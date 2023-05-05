; ===========================================================================
; ---------------------------------------------------------------------------
; Equates
; ---------------------------------------------------------------------------


; ---------------------------------------------------------------------------
; System Variables
; ---------------------------------------------------------------------------

R_MainInt	=	$FFFFFC00			; word		; jmp $00000000
R_MainRout	=	R_MainInt+$02			; long		; ''
R_HBlankInt	=	R_MainRout+$04			; word		; jmp $00000000
R_HBlankRout	=	R_HBlankInt+$02			; long		; ''
R_VBlankInt	=	R_HBlankRout+$04		; word		; jmp $00000000
R_VBlankRout	=	R_VBlankInt+$02			; long		; ''

; ---------------------------------------------------------------------------
; VDP Register settings & stack space (these MUST be at the end of the ROM)
; ---------------------------------------------------------------------------

R_VDPReg97	=	$FFFFFFFE			; word		; 97XX
R_VDPReg96	=	R_VDPReg97-$02			; word		; 96XX
R_VDPReg95	=	R_VDPReg96-$02			; word		; 95XX
R_VDPReg94	=	R_VDPReg95-$02			; word		; 94XX
R_VDPReg93	=	R_VDPReg94-$02			; word		; 93XX
R_VDPReg92	=	R_VDPReg93-$02			; word		; 92XX
R_VDPReg91	=	R_VDPReg92-$02			; word		; 91XX
R_VDPReg90	=	R_VDPReg91-$02			; word		; 90XX
R_VDPReg8F	=	R_VDPReg90-$02			; word		; 8FXX
R_VDPReg8E	=	R_VDPReg8F-$02			; word		; 8EXX
R_VDPReg8D	=	R_VDPReg8E-$02			; word		; 8DXX
R_VDPReg8C	=	R_VDPReg8D-$02			; word		; 8CXX
R_VDPReg8B	=	R_VDPReg8C-$02			; word		; 8BXX
R_VDPReg8A	=	R_VDPReg8B-$02			; word		; 8AXX
R_VDPReg89	=	R_VDPReg8A-$02			; word		; 89XX
R_VDPReg88	=	R_VDPReg89-$02			; word		; 88XX
R_VDPReg87	=	R_VDPReg88-$02			; word		; 87XX
R_VDPReg86	=	R_VDPReg87-$02			; word		; 86XX
R_VDPReg85	=	R_VDPReg86-$02			; word		; 85XX
R_VDPReg84	=	R_VDPReg85-$02			; word		; 84XX
R_VDPReg83	=	R_VDPReg84-$02			; word		; 83XX
R_VDPReg82	=	R_VDPReg83-$02			; word		; 82XX
R_VDPReg81	=	R_VDPReg82-$02			; word		; 81XX
R_VDPReg80	=	R_VDPReg81-$02			; word		; 80XX
R_StackSP	=	(R_VDPReg80-$04)				; Stack Space

; ===========================================================================