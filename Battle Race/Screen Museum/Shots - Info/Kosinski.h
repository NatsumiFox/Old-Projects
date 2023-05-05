// ==========================================================================
// --------------------------------------------------------------------------
// Kosinski
// --------------------------------------------------------------------------
// Usaged:
//
//	switch (Routine (Input, InputSize))
//	{
//		case -1:
//		{
//			printf ("Memory allocation error...\n");
//		}
//		break;
//		case -2:
//		{
//			printf ("Input size error...\n");
//		}
//		break;
//	}
//
// Where "Routine" is:
//
//	KosComp		- Kosinski Compression
//	KosDec		- Kosinski Decompression
//	KosMComp	- Kosinski Moduled Compression
//	KosMDec		- Kosinski Moduled Decompression
//
// "Input" is a char pointer (char*) pointing to the data to compress/decompress.
// This must be pointing into data on the heap (using Windows' "malloc" from the
// windows.h library.
//
// "InputSize" is an integer (int) which is the size of the data to compress/decompress.
//
// After compression/decompression "Input" and "InputSize" will contain the
// compressed/decompressed data and size (Still on the heap via "malloc").
//
// Return value is an error value, if the number is positive (0 or higher), then
// the routine was successful, if the number is negatuve (lower than 0), then an
// error occurred, this is a standard format for KENS:
//
//	-0x01 = Issue with memory allocation
//	-0x02 = Issue with size of file (too small/too large/etc)
//
// --------------------------------------------------------------------------
// Includes
// --------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>

#define ORIGINAL FALSE	// If SEGA's original compression should be used...

// --------------------------------------------------------------------------
// Main defines
// --------------------------------------------------------------------------

#define rangeof(ENTRY) (0x01<<(0x08*sizeof(ENTRY)))

#define KOS_COPY_MIN 0x02
#define KOS_COPY_MAXCC 0x05
#define KOS_COPY_MINRD 0x03
#define KOS_COPY_MAXRD 0x09
#define KOS_COPY_SPECIAL (KOS_COPY_MAXCC * 2)	// special instance where two CC copies would work better
#if ORIGINAL==FALSE
	#define KOS_COPY_MAXRDCC 0x100
#else
	#define KOS_COPY_MAXRDCC 0xFD
#endif

#if ORIGINAL==FALSE
	#define KOS_RETRACE_SHORT 0x100	// The full amount
#else
	#define KOS_RETRACE_SHORT 0xFF	// SEGA's only went back FF, when it could have gone 100
#endif
#if ORIGINAL==FALSE
	#define KOS_RETRACE_MAX 0x2000
#else
	#define KOS_RETRACE_MAX 0x1F00
#endif

#define KOS_COPY_MAX KOS_COPY_MAXRDCC
#define KOS_WINDOW_SIZE (0x2000 * 2)
#define KOS_WINDOW_WRAP (KOS_WINDOW_SIZE - 0x01)
#define KOS_FIELD_SIZE 0x10

// --------------------------------------------------------------------------
// Routine macros
// --------------------------------------------------------------------------

#define KOS_SAVEFIELD(BField,BCount,BLoc,BNextLoc,BSize)\
{\
	if (--BCount == 0x00)\
	{\
		*BLoc++ = BField;\
		*BLoc = BField >> 0x08;\
		BLoc = BNextLoc;\
		BNextLoc += 0x02;\
		BSize += 0x02;\
		BField = 0x00;\
		BCount = KOS_FIELD_SIZE;\
	}\
}

#define KOS_CLEARBIT(BField,BCount,BLoc,BNextLoc,BSize)\
{\
	BField = (BField >> 0x01) & 0b0111111111111111;\
	KOS_SAVEFIELD (BField, BCount, BLoc, BNextLoc, BSize);\
}

#define KOS_SETBIT(BField,BCount,BLoc,BNextLoc,BSize)\
{\
	BField = ((BField >> 0x01) & 0b0111111111111111) | 0b1000000000000000;\
	KOS_SAVEFIELD (BField, BCount, BLoc, BNextLoc, BSize);\
}

#define KOS_PLACEBIT(BValue,BField,BCount,BLoc,BNextLoc,BSize)\
{\
	BField = ((BField >> 0x01) & 0b0111111111111111) | (((BValue) & 0b00000001) << 0x0F);\
	KOS_SAVEFIELD (BField, BCount, BLoc, BNextLoc, BSize);\
}

// ==========================================================================
// --------------------------------------------------------------------------
// Kosinski Compression Algorithm
// --------------------------------------------------------------------------

int KosComp (char *&Input, int &InputSize)

{
	if (InputSize <= 0x00)
	{
		return (-0x02);
	}
	const char *WindowCur, *RetraceCur;
	const char *InputAccess = Input;

	int WindowLoc = 0x00;
	int WindowPos;
	int WindowCopy;
	int WindowCount = InputSize;
	int InputLoc = 0x00;
	int InputCount = InputSize;
	int RetraceLoc;
	int RetracePos;
	int RetraceCount;
	int RetraceBest;
	int CopyMin = KOS_COPY_MIN;
	int CopyCur;
	int CopyBest;
	int CopyTotal = KOS_COPY_MAX;
	int SavedCur;
	int SavedBest;
	int SavedTotal = 0x00;

	u_short *Document = NULL;
	u_short *DocuStore = NULL;
	int DocuSize = 0x00;

	int BinaryRange;

	int OutputSize;
	char *Output = NULL;
	char *OutputAccess = NULL;

	int Count, Offset;
	u_short Word;
	char Byte;

	char *BitLoc = NULL;
	u_short BitField;
	char BitCount;

	int *RetStart = NULL;
	int *RetCount = NULL;
	int *Retraces = NULL;
	u_short *WindowWord = NULL;
	char *Window = NULL;


#if ORIGINAL==TRUE
	bool PosA000 = FALSE;
#endif

	// --- Allocations (for heap) ---

	RetStart = (int*) malloc (rangeof (u_short) * sizeof (int));
	if (RetStart == NULL)
	{
		return (-0x01);
	}
	RetCount = (int*) malloc (rangeof (u_short) * sizeof (int));
	if (RetCount == NULL)
	{
		free (RetStart);
		return (-0x01);
	}
	memset (RetCount, 0x00, rangeof (u_short) * sizeof (int));
	Retraces = (int*) malloc (KOS_WINDOW_SIZE * sizeof (int));
	if (Retraces == NULL)
	{
		free (RetStart);
		free (RetCount);
		return (-0x01);
	}
	WindowWord = (u_short*) malloc (KOS_WINDOW_SIZE * sizeof (u_short));
	if (WindowWord == NULL)
	{
		free (RetStart);
		free (RetCount);
		free (Retraces);
		return (-0x01);
	}
	Window = (char*) malloc ((KOS_WINDOW_SIZE + (KOS_COPY_MAX + 0x01)) * sizeof (u_short));
	if (Window == NULL)
	{
		free (RetStart);
		free (RetCount);
		free (Retraces);
		free (WindowWord);
		return (-0x01);
	}
	DocuStore = (u_short*) malloc ((InputSize * 0x02) * sizeof (u_short));
	if (DocuStore == NULL)
	{
		free (RetStart);
		free (RetCount);
		free (Retraces);
		free (WindowWord);
		free (Window);
		return (-0x01);
	}

// --------------------------------------------------------------------------
// Main Search Loop
// --------------------------------------------------------------------------

	Document = DocuStore;
	while (WindowCount > 0x00)
	{

#if ORIGINAL==TRUE
		if (WindowLoc >= 0xA000 && PosA000 == FALSE)
		{
			PosA000 = TRUE;
			SavedTotal -= (1 + 1 + 0x10 + 0x08);
			*Document++ = -0x02;
			*Document++ = 0x0000;
			DocuSize++;
		}
#endif
			// --- Update Window ---

		WindowCopy = (KOS_COPY_MAX + 0x01) - (InputLoc - WindowLoc);
		if (WindowCopy > InputCount)
		{
			WindowCopy = InputCount;
		}
		while (WindowCopy > 0x00)
		{
			if (InputLoc >= KOS_WINDOW_SIZE)
			{
				Word = WindowWord [(InputLoc & KOS_WINDOW_WRAP)];
			/*	if (RetCount [Word] == 0x00)
				{
					printf ("Error; we've got a problem here...\n");
					printf ("InputLoc: %X (KOS_WINDOW_WRAP: %X)\n", InputLoc, InputLoc & KOS_WINDOW_WRAP);
					printf ("Word: %0.4X\n", Word);
					printf ("WindowLoc: %X (KOS_WINDOW_WRAP: %X)\n", WindowLoc, WindowLoc & KOS_WINDOW_WRAP);
					fflush (stdin);
					getchar ( );
				}	*/
				RetCount [Word]--;
			}
			Byte = *InputAccess++;
			if ((InputLoc & KOS_WINDOW_WRAP) <= (KOS_COPY_MAX + 0x01))
			{
				Window [(InputLoc & KOS_WINDOW_WRAP) + KOS_WINDOW_SIZE] = Byte;
			}
			Window [(InputLoc++ & KOS_WINDOW_WRAP)] = Byte;
			InputCount--;
			WindowCopy--;
		}

			// --- Retrace Search ---

		WindowPos = WindowLoc;
		Word = Window [(WindowPos++ & KOS_WINDOW_WRAP)] & 0xFF;
		Word |= Window [(WindowPos++ & KOS_WINDOW_WRAP)] << 0x08;
		RetraceLoc = RetStart [Word];
		RetraceCount = RetCount [Word];
		SavedBest = -0x01; CopyBest = 0x01;
		if (KOS_COPY_MIN > WindowCount)
		{
			CopyMin = WindowCount;
		}
		if (KOS_COPY_MAX > WindowCount)
		{
			CopyTotal = WindowCount;
		}
		while (RetraceLoc >= (WindowLoc - KOS_RETRACE_MAX) && RetraceCount-- > 0x00)
		{
			WindowCur = Window + (WindowPos & KOS_WINDOW_WRAP);
			RetraceCur = Window + ((RetraceLoc + 0x02) & KOS_WINDOW_WRAP);
			CopyCur = CopyMin;
			while (*WindowCur++ == *RetraceCur++)
			{
				CopyCur++;
				if (CopyCur >= CopyTotal)
				{
					CopyCur = CopyTotal;
					break;
				}
			}
#if ORIGINAL==TRUE
			if (CopyCur > CopyBest)
#endif
			{
				SavedCur = (CopyCur * 0x08) - 0x02;

				RetracePos = WindowLoc - RetraceLoc;

					// --- Retrace & Copy Check ---

				if (RetracePos > KOS_RETRACE_SHORT && CopyCur < KOS_COPY_MINRD)
				{
					// invalid...
				}
				else
				{
					if (RetracePos <= KOS_RETRACE_SHORT && CopyCur <= KOS_COPY_MAXCC)
					{
							// --- CC ---

						SavedCur -= 0x02 + 0x08;	// 2 "C" bits and 8 "R" bits
					}
					else if (CopyCur <= KOS_COPY_MAXRD)
					{
							// --- RD ---

						SavedCur -= 0x0D + 0x03;	// D "R" bits and 3 "D" bits
					}
#if ORIGINAL==FALSE
					else if (RetracePos <= KOS_RETRACE_SHORT && CopyCur == KOS_COPY_SPECIAL)
					{
						SavedCur -= (0x02 + 0x08) * 2;	// 2 "C" bits and 8 "R" bits
					}
#endif
					else
					{
							// --- RDCC ---

						SavedCur -= 0x0D + 0x03 + 0x08;	// D "R" bits, 3 "D" bits and 8 "C" bits
					}

						// --- Saved Bits Check ---

#if ORIGINAL==FALSE
					if (SavedCur > SavedBest)
#endif
					{
						SavedBest = SavedCur;
						CopyBest = CopyCur;
						RetraceBest = RetracePos;
#if ORIGINAL==FALSE
						if (CopyBest == CopyTotal)
						{
							break;
						}
#endif
					}
				}
			}
			RetraceLoc = Retraces [(RetraceLoc & KOS_WINDOW_WRAP)];
		}
		SavedTotal += SavedBest;

			// --- Documenting Results ---

		if (SavedBest == -0x01)
		{
			*Document++ = -0x01;
			*Document++ = Word;
		}
		else
		{
			*Document++ = CopyBest;
			*Document++ = RetraceBest;
		}
		DocuSize++;

			// --- Update Retraces ---

		do
		{
			WindowPos = WindowLoc;
			Word = Window [(WindowLoc++ & KOS_WINDOW_WRAP)] & 0xFF;
			Word |= Window [(WindowLoc & KOS_WINDOW_WRAP)] << 0x08;
			Retraces [(WindowPos & KOS_WINDOW_WRAP)] = RetStart [Word];
			RetStart [Word] = WindowPos;
			RetCount [Word]++;
			WindowWord [(WindowPos & KOS_WINDOW_WRAP)] = Word;
			WindowCount--;
		}
		while (--CopyBest > 0x00);
	}
	free (RetStart);
	free (RetCount);
	free (Retraces);
	free (WindowWord);
	free (Window);

// --------------------------------------------------------------------------
// Setting up data dumping
// --------------------------------------------------------------------------


		// --- Creating Memory & Prep ---

	Output = (char*) malloc (((((InputSize * 0x08) - SavedTotal) / 0x08) + 0x01) + 0x02 + 0x03 + 0x01 + 0x10); // Adding an extra 2 for the first/last bitfield, adding an extra 3 for end marker (if necessary), + 0x10 for padding...
	if (Output == NULL)
	{
		free (DocuStore);
		return (-0x01);
	}
	OutputAccess = Output;

		// --- Bit Field Preparation ---

	BitField = 0x00;
	BitCount = KOS_FIELD_SIZE;
	BitLoc = OutputAccess;
	OutputSize = 0x02;
	OutputAccess += 0x02;

// --------------------------------------------------------------------------
// Main Compression Loop
// --------------------------------------------------------------------------

	Document = DocuStore;
	while (--DocuSize >= 0x00)
	{
		if (*Document == (-0x01 & 0xFFFF))
		{
				// --- Uncompressed ---

			Document++;
			KOS_SETBIT (BitField, BitCount, BitLoc, OutputAccess, OutputSize);				// 1
			*OutputAccess++ = *Document++;									// U
			OutputSize++;
		}
#if ORIGINAL==TRUE
		else if (*Document == (-0x02 & 0xFFFF))
		{
			Document += 0x02;
			KOS_CLEARBIT (BitField, BitCount, BitLoc, OutputAccess, OutputSize);				// 0
			KOS_SETBIT (BitField, BitCount, BitLoc, OutputAccess, OutputSize);				// 1
			RetraceBest = -0x200;
			CopyBest = 0x01;
			*OutputAccess++ = RetraceBest;								// R
			*OutputAccess++ = (RetraceBest >> (0x08 - 0X03)) & 0xF8;				// RD
			*OutputAccess++ = CopyBest;								// C
			OutputSize += 0x03;
		}
#endif
		else
		{
			KOS_CLEARBIT (BitField, BitCount, BitLoc, OutputAccess, OutputSize);				// 0
			CopyBest = *Document++;
			RetraceBest = *Document++;
			if (RetraceBest <= KOS_RETRACE_SHORT && CopyBest <= KOS_COPY_MAXCC)
			{
					// --- CC ---

				RetraceBest = -RetraceBest;
				CopyBest -= KOS_COPY_MIN;
				KOS_CLEARBIT (BitField, BitCount, BitLoc, OutputAccess, OutputSize);			// 0
				KOS_PLACEBIT (CopyBest >> 1, BitField, BitCount, BitLoc, OutputAccess, OutputSize);	// C
				KOS_PLACEBIT (CopyBest >> 0, BitField, BitCount, BitLoc, OutputAccess, OutputSize);	// C
				*OutputAccess++ = RetraceBest;								// R
				OutputSize++;
			}
#if ORIGINAL==FALSE
			else if (RetraceBest <= KOS_RETRACE_SHORT && CopyBest == KOS_COPY_SPECIAL)
			{
				RetraceBest = -RetraceBest;
				CopyBest /= 2;
				CopyBest -= (KOS_COPY_MINRD - 0x01);

				KOS_CLEARBIT (BitField, BitCount, BitLoc, OutputAccess, OutputSize);			// 0
				KOS_PLACEBIT (CopyBest >> 1, BitField, BitCount, BitLoc, OutputAccess, OutputSize);	// C
				KOS_PLACEBIT (CopyBest >> 0, BitField, BitCount, BitLoc, OutputAccess, OutputSize);	// C
				*OutputAccess++ = RetraceBest;								// R
				OutputSize++;
				KOS_CLEARBIT (BitField, BitCount, BitLoc, OutputAccess, OutputSize);			// 0
				KOS_CLEARBIT (BitField, BitCount, BitLoc, OutputAccess, OutputSize);			// 0
				KOS_PLACEBIT (CopyBest >> 1, BitField, BitCount, BitLoc, OutputAccess, OutputSize);	// C
				KOS_PLACEBIT (CopyBest >> 0, BitField, BitCount, BitLoc, OutputAccess, OutputSize);	// C
				*OutputAccess++ = RetraceBest;								// R
				OutputSize++;
			}
#endif
			else if (CopyBest <= KOS_COPY_MAXRD)
			{
					// --- RD ---

				RetraceBest = -RetraceBest;
				CopyBest -= (KOS_COPY_MINRD - 0x01);
				KOS_SETBIT (BitField, BitCount, BitLoc, OutputAccess, OutputSize);			// 1
				*OutputAccess++ = RetraceBest;								// R
				*OutputAccess++ = ((RetraceBest >> (0x08 - 0X03)) & 0xF8) | CopyBest;			// RD
				OutputSize += 0x02;
			}
			else
			{
					// --- RDCC ---

				RetraceBest = -RetraceBest;
				CopyBest--;
				KOS_SETBIT (BitField, BitCount, BitLoc, OutputAccess, OutputSize);			// 1
				*OutputAccess++ = RetraceBest;								// R
				*OutputAccess++ = (RetraceBest >> (0x08 - 0X03)) & 0xF8;				// RD
				*OutputAccess++ = CopyBest;								// C
				OutputSize += 0x03;
			}
		}
	}
	free (DocuStore);

		// --- Final Flags ---

	KOS_CLEARBIT (BitField, BitCount, BitLoc, OutputAccess, OutputSize);			// 0
	KOS_SETBIT (BitField, BitCount, BitLoc, OutputAccess, OutputSize);			// 1
	if (BitCount != KOS_FIELD_SIZE)
	{
		while (BitCount != KOS_FIELD_SIZE)
		{
			KOS_CLEARBIT (BitField, BitCount, BitLoc, OutputAccess, OutputSize);		// 0
		}
		OutputSize -= 0x02;	// Do not need to save last bitfield...
		OutputAccess -= 0x02;
	}
	*OutputAccess++ = 0x00;									// R
	*OutputAccess++ = 0xF0;									// RD
	*OutputAccess++ = 0x00;									// C
	OutputSize += 0x03;

#if ORIGINAL==TRUE
	while ((OutputSize % 0x10) != 0x00)
	{
		Output [OutputSize++] = 0x00;
	}
#endif

// --------------------------------------------------------------------------
// Finish/Cleanup
// --------------------------------------------------------------------------

	free (Input);
	Input = Output;
	InputSize = OutputSize;
	return (0x00);
}

// ==========================================================================
// --------------------------------------------------------------------------
// Routine macros
// --------------------------------------------------------------------------

#define KOS_LOADBIT(BOut,BField,BCount,BPos,BLoc,BSize)\
{\
	BOut = BField & 0b0000000000000001;\
	BField >>= 0x01;\
	if (--BCount < 0x00)\
	{\
		BPos += 0x02;\
		if (BPos > BSize)\
		{\
			break;\
		}\
		BField = *BLoc++ & 0xFF;\
		BField |= *BLoc++ << 0x08;\
		BCount = KOS_FIELD_SIZE-1;\
	}\
}

// ==========================================================================
// --------------------------------------------------------------------------
// Kosinski Decompression Algorithm
// --------------------------------------------------------------------------

int KosDec (char *&Input, int &InputSize)

{
	const char *InputAccess = Input;

	u_short BitField;
	char BitCount = 0x00;
	char BitOut;

	int InputLoc = 0x00;
	char *Output = NULL;
	char *OutputAccess;
	int OutputLoc = 0x00;
	int OutputSize = InputSize;
	int RetraceNum;
	const char *Retrace;
	int CopyCount;

	InputLoc += 0x02;
	if (InputLoc > InputSize)
	{
		return (-0x02);
	}
	BitField = *InputAccess++ & 0xFF;
	BitField |= *InputAccess++ << 0x08;
	BitCount = KOS_FIELD_SIZE-1;

	Output = (char*) malloc (OutputSize);
	if (Output == NULL)
	{
		return (-0x01);
	}
	OutputAccess = Output;
	for ( ; ; )
	{
		KOS_LOADBIT (BitOut, BitField, BitCount, InputLoc, InputAccess, InputSize);
		if (BitOut == 1)
		{
			// --- Uncompressed (1) ---

			if ((OutputLoc + 1) >= OutputSize)
			{
				// reallocate
				while ((OutputLoc + 1) >= OutputSize)
				{
					OutputSize <<= 0x01;
				}
				char* OutputNew = (char*) realloc (Output, OutputSize);
				if (OutputNew == NULL)
				{
					free (Output);
					return (-0x01);
				}
				Output = OutputNew;
				OutputAccess = Output + OutputLoc;
			}
			OutputLoc++;
			InputLoc++;
			if (InputLoc > InputSize)
			{
				break;
			}
			*OutputAccess++ = *InputAccess++;
		}
		else
		{
			KOS_LOADBIT (BitOut, BitField, BitCount, InputLoc, InputAccess, InputSize);
			if (BitOut == 0)
			{
				// --- LZSS-CC compression (00CC) ---

				KOS_LOADBIT (BitOut, BitField, BitCount, InputLoc, InputAccess, InputSize);
				CopyCount = BitOut << 0x01;
				KOS_LOADBIT (BitOut, BitField, BitCount, InputLoc, InputAccess, InputSize);
				CopyCount |= BitOut;
				CopyCount += KOS_COPY_MIN;
				InputLoc++;
				if (InputLoc > InputSize)
				{
					break;
				}
				RetraceNum = 0x100 - (*InputAccess++ & 0xFF);
			}
			else
			{
				// --- LZSS-RD compression (01RD) ---

				InputLoc += 0x02;
				if (InputLoc > InputSize)
				{
					break;
				}
				RetraceNum = *InputAccess++ & 0xFF;
				CopyCount = *InputAccess++ & 0xFF;
				RetraceNum |= (CopyCount & 0b11111000) << 0x05;
				RetraceNum = 0x2000 - RetraceNum;
				CopyCount = (CopyCount & 0b00000111) + KOS_COPY_MIN;
				if (CopyCount == KOS_COPY_MIN)
				{
					// --- LZSS-RDCC compression (01RDCC) ---

					InputLoc++;
					if (InputLoc > InputSize)
					{
						break;
					}
					CopyCount = *InputAccess++ & 0xFF;
					if (CopyCount == 0x00)
					{
						// --- Finished ---

						break;
					}
					if (CopyCount == 0x01)
					{
						// The pointless branch...

						continue;
					}
					CopyCount++;
				}
			}
			if ((OutputLoc + CopyCount) >= OutputSize)
			{
				// reallocate
				while (OutputSize < (OutputLoc + CopyCount))
				{
					OutputSize <<= 0x01;
				}
				char* OutputNew = (char*) realloc (Output, OutputSize);
				if (OutputNew == NULL)
				{
					free (Output);
					return (-0x01);
				}
				Output = OutputNew;
				OutputAccess = Output + OutputLoc;
			}
			OutputLoc += CopyCount;
			Retrace = OutputAccess - RetraceNum;
			while (CopyCount-- > 0x00)
			{
				*OutputAccess++ = *Retrace++;
			}
		}
	}
	free (Input);
	Input = Output;
	InputSize = OutputLoc;
	return (InputLoc);
}

// ==========================================================================
// --------------------------------------------------------------------------
// Main defines
// --------------------------------------------------------------------------

#define MODULED_SIZE 0x1000
#define MODULED_PAD 0x10

	// --- The special A000 = 8000 here, optional ---

#define MODULED_SPECIAL TRUE

#define MODULED_POSITION 0xA000
#define MODULED_REPLACE 0x8000

// ==========================================================================
// --------------------------------------------------------------------------
// Kosinski Moduled Compression Algorithm
// --------------------------------------------------------------------------

int KosMComp (char *&Input, int &InputSize)

{
	if (InputSize <= 0)
	{
		return (-0x02);
	}
	int OutputSize = 0x02;
	char *Output = (char*) malloc (OutputSize);
	if (Output == NULL)
	{
		return (-0x01);
	}

	Output [0x00] = InputSize >> 0x08;
	Output [0x01] = InputSize;

	char *Entry = NULL;
	int EntrySize;
	int Error;

	int InputLoc = 0x00;
	while (InputSize > 0)
	{
		// --- Getting size of entry ---

		EntrySize = InputSize;
		InputSize -= MODULED_SIZE;
		if (InputSize > 0)
		{
			EntrySize = MODULED_SIZE;
		}

		// --- Creating memory space for module entry ---

		Entry = (char*) malloc (EntrySize);
		if (Entry == NULL)
		{
			free (Output);
			return (-0x01);
		}

		// --- Copy uncompressed module entry over and then compress it ---

		memcpy (Entry, Input + InputLoc, EntrySize);
		Error = KosComp (Entry, EntrySize);
		if (Error < 0x00)
		{
			free (Output);
			free (Entry);
			return (Error);
		}

		// --- Find out the 0x10 byte padding amount ---

		int PadCount = MODULED_PAD - (EntrySize % MODULED_PAD);
		if (PadCount == MODULED_PAD)
		{
			PadCount = 0x00;
		}

		// --- reallocate output so we have space for compressed module entry ---

		char *OutputNew = (char*) realloc (Output, OutputSize + (EntrySize + PadCount));
		if (OutputNew == NULL)
		{
			free (Output);
			free (Entry);
		}
		Output = OutputNew;

		// --- Copy module entry over and pad it if it's not the last entry ---

		memcpy (Output + OutputSize, Entry, EntrySize);
		OutputSize += EntrySize;
		if (InputSize > 0)
		{
			while (PadCount-- > 0x00)
			{
				Output [OutputSize++] = 0x00;
			}
		}

		// --- Entry finished... ---

		free (Entry);
		Entry = NULL;
		InputLoc += MODULED_SIZE;
	}
	free (Input);
	Input = Output;
	InputSize = OutputSize;
	return (0x00);
}

// ==========================================================================
// --------------------------------------------------------------------------
// Kosinski Moduled Decompression Algorithm
// --------------------------------------------------------------------------

int KosMDec (char *&Input, int &InputSize)

{
	InputSize -= 0x02;
	if (InputSize < 0x02)
	{
		return (-0x02);
	}

	int OutputLoc = 0x00;
	int OutputSize = (Input [0x00] & 0xFF) << 0x08;
	OutputSize |= Input [0x01] & 0xFF;
	int InputLoc = 0x02;

#if MODULED_SPECIAL==TRUE
	if (OutputSize == MODULED_POSITION)
	{
		OutputSize = MODULED_REPLACE;
	}
#endif

	char *Output = (char*) malloc (OutputSize);
	if (Output == NULL)
	{
		return (-0x01);
	}

	char *Entry = NULL;
	int EntrySize;

	while (OutputLoc < OutputSize)
	{
		EntrySize = InputSize;
		Entry = (char*) malloc (EntrySize);
		if (Entry == NULL)
		{
			return (-0x01);
		}

		memcpy (Entry, Input + InputLoc, EntrySize);

		int ModuleEnd = KosDec (Entry, EntrySize);
		if (ModuleEnd < 0x00)
		{
			return (ModuleEnd);
		}
		memcpy (Output + OutputLoc, Entry, EntrySize);

		OutputLoc += EntrySize;
		int PadCount = MODULED_PAD - (ModuleEnd % MODULED_PAD);
		if (PadCount == MODULED_PAD)
		{
			PadCount = 0x00;
		}
		ModuleEnd += PadCount;
		InputSize -= ModuleEnd;
		InputLoc += ModuleEnd;


		free (Entry);
		Entry = NULL;
	}

	free (Input);
	Input = Output;
	InputSize = OutputSize;
	return (0x00);
}

// ==========================================================================

