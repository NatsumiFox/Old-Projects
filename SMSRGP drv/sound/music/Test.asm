Test_PSG3:
Test_PSG1:
Test_PSG2:
	Ins1	Test_Ins.fade
	Ins2	Test_Ins
	ModSet	01h, 02h, 01h, 28h
	VolSet	08h

	Loops	82h
	db nDs3, 28h, nE3, 28h, nG3, 28h
	Loope
	Return

Test_PSG4:
	Ins1	Test_Ins.fade
	Ins2	Test_Ins
	VolSet	08h

	Loops	82h
	db ns7, 28h, ns7, 28h, ns7, 28h
	Loope
	Return

Test_Ins:
	db 00h, 00h, 00h, 00h, 01h, 01h, 01h, 02h, 02h, 02h, 01h, 01h, 01h, iReset

.fade:	db 0Eh, 0Eh, 0Ch, 0Bh, 0Bh, 0Ah, 0Ah, 09h
	db 08h, 08h, 07h, 06h, 06h, 05h, 04h, 04h
	db 03h, 03h, 02h, 02h, 01h, 01h, iHold, 00h
