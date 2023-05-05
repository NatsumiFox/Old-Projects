MacroSonic:
           move.w  ($FFFFFF0F).w,d0
           rts
Knux_cut_map_load:
           move.l #Map_Knux,4(a0)
           rts  
Map_Sonic_load_d:           
Map_Sonic_load:

           cmpi.b  #1,($FFFFFF0F).w
           beq.s   Map_Sonic_load2
           cmpi.b  #2,($FFFFFF0F).w
           beq.s   Map_Sonic_load3
           cmpi.b  #3,($FFFFFF0F).w
           beq.s   Map_Knux_load
           move.l #Map_sonic,($FFFFD004).w
           rts

Map_Sonic_load2: 
           move.l #Map_sonic2,($FFFFD004).w
           rts
Map_Sonic_load3:
           move.l #Map_sonic3,($FFFFD004).w
           rts
Map_knux_load:
           move.l #Map_Knux,($FFFFD004).w
           rts  
                    
Art_Sonic_load:
           cmpi.b  #1,($FFFFFF0F).w
           beq.s   art_Sonic_load2
           cmpi.b  #2,($FFFFFF0F).w
           beq.s   art_Sonic_load3
           cmpi.b  #3,($FFFFFF0F).w
           beq.s   art_Knux_load
           lea	(Art_sonic).l,a0
           rts

art_Sonic_load2: 
           lea	(Art_sonic2).l,a0
           rts 
art_Sonic_load3:
           lea	(Art_sonic3).l,a0
           rts
art_knux_load:
          lea	(Art_knux).l,a0
           rts              
           
LoadSonicPLC:
                cmpi.b  #3,($FFFFFF0F).w
                beq.s   SetPLC_Knux
                cmpi.b  #1,($FFFFFF0F).w
                beq.s   SetPLC_Sonic2
                cmpi.b  #2,($FFFFFF0F).w
                beq.s   SetPLC_Sonic3
SetPLC_Sonic1:
                lea	(SonicDynPLC).l,a2
        	rts
SetPLC_Sonic2:
                lea	(Sonic2DynPLC).l,a2
                rts
SetPLC_Sonic3:
                lea	(Sonic3DynPLC).l,a2
                rts  
SetPLC_Knux:
                lea	(KnuxDynPLC).l,a2
                rts 
                                
LoadSonicArt:
                cmpi.b  #3,($FFFFFF0F).w
                beq.s   Setart_knux
                cmpi.b  #1,($FFFFFF0F).w
                beq.s   Setart_Sonic2
                cmpi.b  #2,($FFFFFF0F).w
                beq.s   Setart_Sonic3
Setart_Sonic1:
                move.l	#Art_Sonic,d6
        	rts
Setart_Sonic2:
                move.l	#Art_Sonic2,d6
                rts
Setart_Sonic3:
                move.l	#Art_Sonic3,d6
                rts 
Setart_knux:
                move.l	#Art_Knux,d6
                rts                         