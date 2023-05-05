Splash:           
            jsr	Pal_FadeFrom			; Fade out
	;		move	#$2700,sr
        ;    jsr    ClearScreen            ; Clear the actual screen
                
Splash_Art:        
            move.l    #$40000000,($C00004).l        ; VRAM $0000
            lea    (Art_Splash).l,a0        ; Image's tiles
            jsr    NemDec                ; Decompress
     
Splash_Mappings:
            lea    ($FF0000).l,a1            ; Load screen mappings
            lea    (Map_Splash).l,a0
            move.w  #0,d0
            jsr    EniDec
                
Splash_ShowOnVDP:    
            lea    ($FF0000).l,a1            ; Show screen
            move.l    #$40000003,d0            ; Location
            moveq    #$27,d1
            moveq    #$1B,d2
            jsr    ShowVDPGraphics                

Splash_Palette:
      lea   (Pal_Splash).l,a1
      lea   ($FFFFFB80).w,a2
      moveq   #$1F,d0
@loop:   move.l   (a1)+,(a2)+
      dbf   d0,@loop
       jsr	Pal_Fadeto                        
; ---------------------------------------------------------------------------------------------------------------------
Splash_Loop:        
            move.b    #2,($FFFFF62A).w        ; Function 2 in vInt
           jsr    DelayProgram            ; Run delay program
            andi.b    #$80,($FFFFF605).w        ; is Start button pressed?
            beq.s    Splash_Loop            ; if not, loop
Splash_Next:
            move.b    #4,($FFFFF600).w ; go to next screen
            rts
            
Pal_Splash:      incbin  'splashes\pal_sasm.bin'
         even
Art_Splash:      incbin  'splashes\art_sasm.bin'
         even
Map_Splash:      incbin   'splashes\mapsasm.bin'
         even