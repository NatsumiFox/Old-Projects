Obj7C_GoToSS:				; XREF: Obj7C_Index
	        move.b	$28(a0),d0
               cmpi.b	#$1,d0
	        beq.w   obj7c_ghz 
                cmpi.b	#$2,d0
	        beq.w   obj7c_slz 
                cmpi.b	#$3,d0
	        beq.w   obj7c_Final 
                cmpi.b	#$5,d0
	        beq.w   obj7c_lz
                cmpi.b	#$4,d0
	        beq.w   obj7c_syz
	        cmpi.b	#$6,d0
	        beq.w   obj7c_mz
	        cmpi.b	#$7,d0
	        beq.w   obj7c_ending
                move.w	#0,($FFFFFFF7).w 
                move.w  #0,($FFFFFFF5).w
		move.w	($FFFFFE20).w,($FFFFFE36).w 	; rings
		move.b	($FFFFFE1B).w,($FFFFFE54).w 	; lives
		move.l	($FFFFFE22).w,($FFFFFE38).w 	; time
		move.b	($FFFFFE16).w,d0 ; load	number of last special stage entered
		move.b	#$10,($FFFFF600).w ; set game mode to Special Stage (10)
	;	move.w	#2,($FFFFFE02).w ; restart level
		move.b	#1,($FFFFF7C8).w ; freeze Sonic

		move.b	#$10,($FFFFF600).w
		rts
obj7c_ghz:
              move.w    #0,($FFFFFe10).w
              	move.w	#2,($FFFFFE02).w ; restart level
		move.b	#1,($FFFFF7C8).w ; freeze Sonic
                rts
obj7c_slz:
           move.w    #$302,($FFFFFe10).w
              	move.w	#2,($FFFFFE02).w ; restart level
		move.b	#1,($FFFFF7C8).w ; freeze Sonic
                rts
obj7c_Final:
             move.w    #$502,($FFFFFe10).w
              	move.w	#2,($FFFFFE02).w ; restart level
		move.b	#1,($FFFFF7C8).w ; freeze Sonic
                rts
obj7c_lz:
          move.w    #$101,($FFFFFe10).w
              	move.w	#2,($FFFFFE02).w ; restart level
		move.b	#1,($FFFFF7C8).w ; freeze Sonic
                rts
obj7c_syz: 
              move.w    #$401,($FFFFFe10).w
              	move.w	#2,($FFFFFE02).w ; restart level
		move.b	#1,($FFFFF7C8).w ; freeze Sonic
                rts
obj7c_Mz: 
              move.w    #$200,($FFFFFe10).w
              	move.w	#2,($FFFFFE02).w ; restart level
		move.b	#1,($FFFFF7C8).w ; freeze Sonic
                rts
obj7c_ending: 
                   move.b	#$18,($FFFFF600).w ; set screen	mode to	$18 (Ending)
		move.w	#$600,($FFFFFE10).w ; set level	to 0600	(Ending)
		move.b	#1,($FFFFF7C8).w ; freeze Sonic
                rts