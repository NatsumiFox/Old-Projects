Obj3a_SetCompleteFlag:
          cmpi.w  #2,($FFFFFE10).w
	  beq.s   Obj3a_ghz
	  cmpi.w  #$302,($FFFFFE10).w
	  beq.s   Obj3a_slz
	  cmpi.w  #$700,($FFFFFE10).w
	  beq.s   Obj3a_ss
	  cmpi.w  #$102,($FFFFFE10).w
	  beq.s   Obj3a_lz
	  cmpi.w  #$402,($FFFFFE10).w
	  beq.w   Obj3a_syz
	  cmpi.w  #$202,($FFFFFE10).w
	  beq.w   Obj3a_mz
	  cmpi.w  #$502,($FFFFFE10).w
	  beq.w   Obj3a_sbz
	  jmp     Boucs_obj3a
obj3a_ghz:	  
          cmpi.w  #1,($FFFFFFD9).w
	  bge.w   Boucs_obj3a
	  move.w  #1,($FFFFFFD9).w
	  rts
obj3a_slz:
          cmpi.w  #2,($FFFFFFD9).w
	  bge.w   Boucs_obj3a
	  move.w  #2,($FFFFFFD9).w
	  rts
Obj3a_ss:
          cmpi.w  #3,($FFFFFFD9).w
	  bge.w   Boucs_obj3a
	  move.w  #3,($FFFFFFD9).w
	  rts
Obj3a_lz:
          cmpi.w  #4,($FFFFFFD9).w
	  bge.w   Boucs_obj3a
	  move.w  #4,($FFFFFFD9).w
	  rts
Obj3a_syz:
           cmpi.w  #5,($FFFFFFD9).w
	  bge.w   Boucs_obj3a
	  move.w  #5,($FFFFFFD9).w
	  rts
Obj3a_mz:
         ;  cmpi.w  #6,($FFFFFFD9).w
	 ; bge.w   Boucs_obj3a
	  move.w  #6,($FFFFFFD9).w
	  rts
Obj3a_sbz:
           cmpi.w  #7,($FFFFFFD9).w
	  bge.w   Boucs_obj3a
	  move.w  #7,($FFFFFFD9).w
	  rts