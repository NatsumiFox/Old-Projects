; ---------------------------------------------------------------------------
; Nemesis decompression subroutine, decompresses art directly to VRAM
; Inputs:
; a0 = art address
; a VDP command to write to the destination VRAM address must be issued
; before calling this routine
; See http://www.segaretro.org/Nemesis_compression for format description
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Nem_Decomp:
		movem.l	d0-a1/a3-a5,-(sp)
		lea	(Nem_PCD_WriteRowToVDP).l,a3
		lea	(VDP_data_port).l,a4	; write all rows to the VDP data port
		bra.s	Nem_Decomp_Main
; End of function Nem_Decomp

; ---------------------------------------------------------------------------
; Nemesis decompression subroutine, decompresses art to RAM
; Inputs:
; a0 = art address
; a4 = destination RAM address
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Nem_Decomp_To_RAM:
		movem.l	d0-a1/a3-a5,-(sp)
		lea	(Nem_PCD_WriteRowToRAM).l,a3
; End of function Nem_Decomp_To_RAM

; ---------------------------------------------------------------------------
; Main Nemesis decompression subroutine
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Nem_Decomp_Main:
		lea	(Nem_code_table).w,a1
		move.w	(a0)+,d2	; get number of patterns
		lsl.w	#1,d2
		bcc.s	+	; branch if the sign bit isn't set
		adda.w	#Nem_PCD_WriteRowToVDP_XOR-Nem_PCD_WriteRowToVDP,a3	; otherwise the file uses XOR mode
+
		lsl.w	#2,d2	; get number of 8-pixel rows in the uncompressed data
		movea.w	d2,a5	; and store it in a5 because there aren't any spare data registers
		moveq	#8,d3	; 8 pixels in a pattern row
		moveq	#0,d2
		moveq	#0,d4
		bsr.w	Nem_Build_Code_Table
		move.b	(a0)+,d5	; get first byte of compressed data
		asl.w	#8,d5	; shift up by a byte
		move.b	(a0)+,d5	; get second byte of compressed data
		move.w	#$10,d6	; set initial shift value
		bsr.s	Nem_Process_Compressed_Data
		movem.l	(sp)+,d0-a1/a3-a5
		rts
; End of function Nem_Decomp_Main

; ---------------------------------------------------------------------------
; Part of the Nemesis decompressor, processes the actual compressed data
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================

; PCD is used throughout this subroutine as an initialism for Process_Compressed_Data
Nem_Process_Compressed_Data:
		move.w	d6,d7
		subq.w	#8,d7	; get shift value
		move.w	d5,d1
		lsr.w	d7,d1	; shift so that high bit of the code is in bit position 7
		cmpi.b	#%11111100,d1	; are the high 6 bits set?
		bhs.s	Nem_PCD_InlineData	; if they are, it signifies inline data
		andi.w	#$FF,d1
		add.w	d1,d1
		move.b	(a1,d1.w),d0	; get the length of the code in bits
		ext.w	d0
		sub.w	d0,d6	; subtract from shift value so that the next code is read next time around
		cmpi.w	#9,d6	; does a new byte need to be read?
		bhs.s	+	; if not, branch
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5	; read next byte
+
		move.b	1(a1,d1.w),d1
		move.w	d1,d0
		andi.w	#$F,d1	; get palette index for pixel
		andi.w	#$F0,d0

Nem_PCD_GetRepeatCount:
		lsr.w	#4,d0	; get repeat count

Nem_PCD_WritePixel:
		lsl.l	#4,d4	; shift up by a nybble
		or.b	d1,d4	; write pixel
		subq.w	#1,d3	; has an entire 8-pixel row been written?
		bne.s	Nem_PCD_WritePixel_Loop	; if not, loop
		jmp	(a3)	; otherwise, write the row to its destination
; ---------------------------------------------------------------------------

Nem_PCD_NewRow:
		moveq	#0,d4	; reset row
		moveq	#8,d3	; reset nybble counter

Nem_PCD_WritePixel_Loop:
		dbf	d0,Nem_PCD_WritePixel
		bra.s	Nem_Process_Compressed_Data
; ---------------------------------------------------------------------------

Nem_PCD_InlineData:
		subq.w	#6,d6	; 6 bits needed to signal inline data
		cmpi.w	#9,d6
		bhs.s	+
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5
+
		subq.w	#7,d6	; and 7 bits needed for the inline data itself
		move.w	d5,d1
		lsr.w	d6,d1	; shift so that low bit of the code is in bit position 0
		move.w	d1,d0
		andi.w	#$F,d1	; get palette index for pixel
		andi.w	#$70,d0	; high nybble is repeat count for pixel
		cmpi.w	#9,d6
		bhs.s	Nem_PCD_GetRepeatCount
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a0)+,d5
		bra.s	Nem_PCD_GetRepeatCount
; ---------------------------------------------------------------------------

Nem_PCD_WriteRowToVDP:
		move.l	d4,(a4)	; write 8-pixel row
		subq.w	#1,a5
		move.w	a5,d4	; have all the 8-pixel rows been written?
		bne.s	Nem_PCD_NewRow	; if not, branch
		rts	; otherwise the decompression is finished
; ---------------------------------------------------------------------------

Nem_PCD_WriteRowToVDP_XOR:
		eor.l	d4,d2	; XOR the previous row by the current row
		move.l	d2,(a4)	; and write the result
		subq.w	#1,a5
		move.w	a5,d4
		bne.s	Nem_PCD_NewRow
		rts
; ---------------------------------------------------------------------------

Nem_PCD_WriteRowToRAM:
		move.l	d4,(a4)+
		subq.w	#1,a5
		move.w	a5,d4
		bne.s	Nem_PCD_NewRow
		rts
; ---------------------------------------------------------------------------

Nem_PCD_WriteRowToRAM_XOR:
		eor.l	d4,d2
		move.l	d2,(a4)+
		subq.w	#1,a5
		move.w	a5,d4
		bne.s	Nem_PCD_NewRow
		rts
; End of function Nem_Process_Compressed_Data

; ---------------------------------------------------------------------------
; Part of the Nemesis decompressor, builds the code table (in RAM)
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================

; BCT is used throughout this subroutine as an initialism for Build_Code_Table
Nem_Build_Code_Table:
		move.b	(a0)+,d0	; read first byte

Nem_BCT_ChkEnd:
		cmpi.b	#$FF,d0	; has the end of the code table description been reached?
		bne.s	Nem_BCT_NewPalIndex	; if not, branch
		rts	; otherwise, this subroutine's work is done
; ---------------------------------------------------------------------------

Nem_BCT_NewPalIndex:
		move.w	d0,d7

Nem_BCT_Loop:
		move.b	(a0)+,d0	; read next byte
		cmpi.b	#$80,d0	; sign bit being set signifies a new palette index
		bhs.s	Nem_BCT_ChkEnd	; a bmi could have been used instead of a compare and bcc
		move.b	d0,d1
		andi.w	#$F,d7	; get palette index
		andi.w	#$70,d1	; get repeat count for palette index
		or.w	d1,d7	; combine the two
		andi.w	#$F,d0	; get the length of the code in bits
		move.b	d0,d1
		lsl.w	#8,d1
		or.w	d1,d7	; combine with palette index and repeat count to form code table entry
		moveq	#8,d1
		sub.w	d0,d1	; is the code 8 bits long?
		bne.s	Nem_BCT_ShortCode	; if not, a bit of extra processing is needed
		move.b	(a0)+,d0	; get code
		add.w	d0,d0	; each code gets a word-sized entry in the table
		move.w	d7,(a1,d0.w)	; store the entry for the code
		bra.s	Nem_BCT_Loop	; repeat
; ---------------------------------------------------------------------------

; the Nemesis decompressor uses prefix-free codes (no valid code is a prefix of a longer code)
; e.g. if 10 is a valid 2-bit code, 110 is a valid 3-bit code but 100 isn't
; also, when the actual compressed data is processed the high bit of each code is in bit position 7
; so the code needs to be bit-shifted appropriately over here before being used as a code table index
; additionally, the code needs multiple entries in the table because no masking is done during compressed data processing
; so if 11000 is a valid code then all indices of the form 11000XXX need to have the same entry
Nem_BCT_ShortCode:
		move.b	(a0)+,d0	; get code
		lsl.w	d1,d0	; shift so that high bit is in bit position 7
		add.w	d0,d0	; get index into code table
		moveq	#1,d5
		lsl.w	d1,d5
		subq.w	#1,d5	; d5 = 2^d1 - 1

Nem_BCT_ShortCode_Loop:
		move.w	d7,(a1,d0.w)	; store entry
		addq.w	#2,d0	; increment index
		dbf	d5,Nem_BCT_ShortCode_Loop	; repeat for required number of entries
		bra.s	Nem_BCT_Loop
; End of function Nem_Build_Code_Table

; ---------------------------------------------------------------------------
; Adds pattern load requests to the Nemesis decompression queue
; Input: d0 = ID of the PLC to load
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Load_PLC:
		movem.l	a1-a2,-(sp)
		lea	(Offs_PLC).l,a1
		add.w	d0,d0
		move.w	(a1,d0.w),d0
		lea	(a1,d0.w),a1
		lea	(Nem_decomp_queue).w,a2

.findFreeSlot:
		tst.l	(a2)	; is the current slot in the queue free?
		beq.s	.getPieceCount	; if it is, branch
		addq.w	#6,a2	; otherwise check the next slot
		bra.s	.findFreeSlot
; ---------------------------------------------------------------------------

.getPieceCount:
		move.w	(a1)+,d0
		bmi.s	.done

.queuePieces:
		move.l	(a1)+,(a2)+	; store compressed data location
		move.w	(a1)+,(a2)+	; store destination in VRAM
		dbf	d0,.queuePieces

.done:
		movem.l	(sp)+,a1-a2
		rts
; End of function Load_PLC

; ---------------------------------------------------------------------------
; Loads a raw PLC from ROM
; Input: a1 = address of the PLC
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Load_PLC_Raw:
		lea	(Nem_decomp_queue).w,a2

.findFreeSlot:
		tst.l	(a2)
		beq.s	.getPieceCount
		addq.w	#6,a2
		bra.s	.findFreeSlot
; ---------------------------------------------------------------------------

.getPieceCount:
		move.w	(a1)+,d0
		bmi.s	.done

.queuePieces:
		move.l	(a1)+,(a2)+
		move.w	(a1)+,(a2)+
		dbf	d0,.queuePieces

.done:
		rts
; End of function Load_PLC_Raw

; ---------------------------------------------------------------------------
; Adds pattern load requests to the Nemesis decompression queue
; Differs from Load_PLC in that it clears the queue before loading
; Input: d0 = ID of the PLC to load
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Load_PLC_2:
		movem.l	a1-a2,-(sp)		; This differs from Load_PLC in that it overrides any PLCs already in the queue
		lea	(Offs_PLC).l,a1
		add.w	d0,d0
		move.w	(a1,d0.w),d0
		lea	(a1,d0.w),a1
		bsr.s	Clear_Nem_Queue
		lea	(Nem_decomp_queue).w,a2
		move.w	(a1)+,d0
		bmi.s	.done

.queuePieces:
		move.l	(a1)+,(a2)+
		move.w	(a1)+,(a2)+
		dbf	d0,.queuePieces

.done:
		movem.l	(sp)+,a1-a2
		rts
; End of function Load_PLC_2

; ---------------------------------------------------------------------------
; Clears the Nemesis decompression queue and its associated variables
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Clear_Nem_Queue:
		lea	(Nem_decomp_queue).w,a2
		moveq	#bytesToLcnt($80),d0	; clear till the end of Nem_decomp_vars

-		clr.l	(a2)+
		dbf	d0,-
		rts
; End of function Clear_Nem_Queue

; ---------------------------------------------------------------------------
; Initializes Nemesis decompression queue processing
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Nem_Queue_Init:
		tst.l	(Nem_decomp_queue).w
		beq.s	++	; return if the queue is empty
		tst.w	(Nem_patterns_left).w
		bne.s	++	; return if processing of a previous piece is still going on
		movea.l	(Nem_decomp_queue).w,a0
		lea	(Nem_PCD_WriteRowToVDP).l,a3

		lea	(Nem_code_table).w,a1
		move.w	(a0)+,d2
		bpl.s	+
		adda.w	#Nem_PCD_WriteRowToVDP_XOR-Nem_PCD_WriteRowToVDP,a3
+
		andi.w	#$7FFF,d2
		bsr.w	Nem_Build_Code_Table
		move.b	(a0)+,d5
		asl.w	#8,d5
		move.b	(a0)+,d5
		moveq	#$10,d6
		moveq	#0,d0
		move.l	a0,(Nem_decomp_queue).w
		move.l	a3,(Nem_decomp_vars).w
		move.l	d0,(Nem_repeat_count).w
		move.l	d0,(Nem_palette_index).w
		move.l	d0,(Nem_previous_row).w
		move.l	d5,(Nem_data_word).w
		move.l	d6,(Nem_shift_value).w
		move.w	d2,(Nem_patterns_left).w
+
		rts
; End of function Process_Nem_Queue_Init

; ---------------------------------------------------------------------------
; Processes the first piece on the Nemesis decompression queue
; Decompresses 6 patterns per frame
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Nem_Queue:
		tst.w	(Nem_patterns_left).w
		beq.w	Process_Nem_Queue_Done
		move.w	#6,(Nem_frame_patterns_left).w	; decompress 6 patterns per frame
		moveq	#0,d0
		move.w	(Nem_decomp_destination).w,d0
		addi.w	#6*$20,(Nem_decomp_destination).w	; increment by 6 patterns' worth of data
		bra.s	Process_Nem_Queue_Main
; End of function Process_Nem_Queue

; ---------------------------------------------------------------------------
; Processes the first piece on the Nemesis decompression queue
; Decompresses 3 patterns per frame
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Nem_Queue_2:
		tst.w	(Nem_patterns_left).w
		beq.s	Process_Nem_Queue_Done
		move.w	#3,(Nem_frame_patterns_left).w	; decompress 3 patterns per frame
		moveq	#0,d0
		move.w	(Nem_decomp_destination).w,d0
		addi.w	#3*$20,(Nem_decomp_destination).w	; increment by 3 patterns' worth of data
; End of function Process_Nem_Queue_2

; ---------------------------------------------------------------------------
; Main Nemesis decompression queue processor
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Process_Nem_Queue_Main:
		lea	(VDP_control_port).l,a4
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0	; d0 = VDP command word to write to VRAM destination
		move.l	d0,(a4)
		subq.w	#VDP_control_port-VDP_data_port,a4	; a4 = VDP_data_port
		movea.l	(Nem_decomp_queue).w,a0
		movea.l	(Nem_decomp_vars).w,a3
		move.l	(Nem_repeat_count).w,d0
		move.l	(Nem_palette_index).w,d1
		move.l	(Nem_previous_row).w,d2
		move.l	(Nem_data_word).w,d5
		move.l	(Nem_shift_value).w,d6
		lea	(Nem_code_table).w,a1

Process_Nem_Queue_Loop:
		movea.w	#8,a5	; decompress all 8 rows in a pattern
		bsr.w	Nem_PCD_NewRow
		subq.w	#1,(Nem_patterns_left).w	; have all the patterns been decompressed?
		beq.s	Process_Nem_Queue_ShiftUp	; if yes, shift all other queue entries up
		subq.w	#1,(Nem_frame_patterns_left).w	; has the current frame's worth of patterns been decompressed?
		bne.s	Process_Nem_Queue_Loop	; if not, loop
		move.l	a0,(Nem_decomp_queue).w
		move.l	a3,(Nem_decomp_vars).w
		move.l	d0,(Nem_repeat_count).w
		move.l	d1,(Nem_palette_index).w
		move.l	d2,(Nem_previous_row).w
		move.l	d5,(Nem_data_word).w
		move.l	d6,(Nem_shift_value).w

Process_Nem_Queue_Done:
		rts
; ---------------------------------------------------------------------------

; this routine is idiotic because:
; a) it doesn't copy the VRAM location for the last entry in the queue
; b) it doesn't actually mark the last slot in the queue as clear
; so basically don't store an entry in the last slot unless you want the game to screw up to high heaven
Process_Nem_Queue_ShiftUp:
		lea	(Nem_decomp_queue).w,a0
		moveq	#$54/4-1,d0

-		move.l	6(a0),(a0)+
		dbf	d0,-

	; NAT: Fixing the shifting bug
		move.w	6(a0),(a0)+		; copy last word(!)
		moveq	#0,d0
		move.w	d0,(a0)+		; clear last entry
		move.l	d0,(a0)+
		rts
; End of function Process_Nem_Queue_Main

; ---------------------------------------------------------------------------
	;	lea	(Offs_PLC).l,a1
	;	add.w	d0,d0
	;	move.w	(a1,d0.w),d0
	;	nop
	;	nop
	;	lea	(a1,d0.w),a1

; ---------------------------------------------------------------------------
; Loads a raw PLC from the ROM and decompresses it immediately
; Input: a1 = the address of the PLC
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


Load_PLC_Immediate:
		move.w	(a1)+,d1

.decompPieces:
		movea.l	(a1)+,a0	; get source address
		moveq	#0,d0
		move.w	(a1)+,d0	; get destination VRAM address
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap	d0	; d0 = VDP command to write to destination
		move.l	d0,(VDP_control_port).l
		bsr.w	Nem_Decomp
		dbf	d1,.decompPieces
		rts
; End of function Load_PLC_Immediate
