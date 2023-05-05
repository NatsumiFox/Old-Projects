SFF_Mainframe:
	dc.b $FF
	dc.b '       --- SELECT A SAVE FILE ---',$FF
	dc.b '________________________________________',$FF
	dc.b '                                        ',0
	even

SFF_Copy_Mainframe:
	dc.b $FF
	dc.b '       --- COPYING SAVE FILE ---',$FF
	dc.b '________________________________________',0
	even

SFF_Move_Mainframe:
	dc.b $FF
	dc.b '        --- MOVING SAVE FILE ---',$FF
	dc.b '________________________________________',0
	even

SFF_FileEmpty:
	dc.b '+----------------+',$FF
	dc.b '|     Empty      |',$FF
	dc.b '|                |',$FF
	dc.b '|                |',$FF
	dc.b '|                |',$FF
	dc.b '|                |',$FF
	dc.b '|                |',$FF
	dc.b '|                |',$FF
	dc.b '|                |',$FF
	dc.b '|                |',$FF
	dc.b '|                |',$FF
        dc.b '+----------------+',0
        even

SFF_InUse:
	dc.b '+----------------+',$FF
	dc.b '|                |',$FF
	dc.b '|                |',$FF
	dc.b '| Completion:    |',$FF
	dc.b '|            !!% |',$FF
	dc.b '|                |',$FF
	dc.b '|                |',$FF
	dc.b '|                |',$FF
	dc.b '|                |',$FF
	dc.b '|                |',$FF
	dc.b '| Player:        |',$FF
        dc.b '+----------------+',0
        even
	
SFF_NameSel:
	dc.b '+----------------+',$FF
	dc.b '| SAVE SLOT NAME |',$FF
	dc.b '|                |',$FF
	dc.b '|                |',$FF
	dc.b '+----------------+',0
        even

SFF_NameSel_2:
	dc.b '+--------------------+',$FF
	dc.b '| Hint: By pressing  |',$FF
	dc.b '| A, B and/or C you  |',$FF
	dc.b '| can scroll through |',$FF
	dc.b '| letters faster     |',$FF
	dc.b '+--------------------+',0
        even

SFF_Mainframe_Clear:
	dc.b $FF
	dc.b '                                        ',$FF
	dc.b '                                        ',0
	even

SSF_PlayerSelect:
	dc.b '+----------------------+',$FF
	dc.b '| SELECT THE CHARACTER |',$FF
	dc.b '| YOU WANT TO USE      |',$FF
	dc.b '|                      |',$FF
	dc.b '|                      |',$FF
	dc.b '|                      |',$FF
	dc.b '|                      |',$FF
	dc.b '|                      |',$FF,$FF
	dc.b '+----------------------+',0
        even

SSF_PS_Sonic:
	dc.b '|        SONIC         |',0
	even
SSF_PS_Tails:
	dc.b '|        TAILS         |',0
	even
SSF_PS_Knuckles:
	dc.b '|       KNUCKLES       |',0
        even
SFF_PS_IllegalValue:
	dc.b '| ILLEGAL PLAYER       |',$FF
	dc.b '| MAY CAUSE CRASH      |',0
        even
	
SSF_Menu:
	dc.b '+--------+',$FF
	dc.b '|        |',$FF
	dc.b '|  Copy  |',$FF
	dc.b '| Delete |',$FF
	dc.b '|  Move  |',$FF

SSF_End:
	dc.b '+--------+',0
	even

SSF_Play:
	dc.b ' Play',0
        even
SSF_Copy:
	dc.b ' Copy',0
        even
SSF_Delete:
	dc.b 'Delete',0
	even
SSF_Move:
	dc.b ' Move',0
	even
	
SSF_DestError:
	dc.b '+--------------------------------+',$FF
	dc.b '| SOURCE AND DESTINATION OF THE  |',$FF
	dc.b '| OPERATION CAN NOT BE THE SAME! |',$FF
	dc.b '|                                |',$FF
	dc.b '|                                |',$FF
	dc.b '|                                |',$FF
	dc.b '+--------------------------------+',0
	even

SSF_DE_1:
	dc.b '    Cancel operation',0
	even
SSF_DE_2:
	dc.b 'Select other destination',0
	even

SSF_SwitchMove:
	dc.b '+------------------+',$FF
	dc.b '| SELECT MOVE MODE |',$FF
	dc.b '|                  |',$FF
	dc.b '|     Switch       |',$FF
	dc.b '|    Overwrite     |',$FF
        dc.b '+------------------+',0
	even

SFF_SM_Switch:
	dc.b ' Switch',0
	even
SSF_SM_OverWrite:
	dc.b 'Overwrite',0
	even

SSF_PromptOverwrite:
	dc.b '+--------------------------+',$FF
	dc.b '|    YOU ARE ABOUT TO      |',$FF
	dc.b '| OVERWRITE EXISTING SAVE  |',$FF
	dc.b '| ARE YOU SURE THIS IS OK? |',$FF
	dc.b '|                          |',$FF
	dc.b '|                          |',$FF
	dc.b '|                          |',$FF
	dc.b '+--------------------------+',0
	even

SSF_PO_OK:
	dc.b ' Yes, overwrite',0
	even
SSF_PO_NO:
	dc.b 'Do not overwrite',0
	even



