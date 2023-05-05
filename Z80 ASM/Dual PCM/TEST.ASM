	org 0
align	macro al
	cnop 0,\al
    endm

	include "LANG.ASM"
	z80prog 0
	include "DUAL PCM.ASM"
	z80prog
	END
