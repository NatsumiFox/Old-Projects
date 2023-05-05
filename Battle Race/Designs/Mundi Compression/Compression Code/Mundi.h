// =============================================================================
// -----------------------------------------------------------------------------
// Mundi Compression Code
// -----------------------------------------------------------------------------
// Start-{1-H-H-H-H-H-H-H-<U-U-U-U-U-U-U-U>------------------------}-Repeat
//       \0{0{0<U-U-U-U-U-U-U-U-U-U-U-U-U-U-U-U>-------------------|
//         | \1<I-I-I-I-I-I-I-I>-<C-C-C-C-C-C-C-C>(2-101)----------|
//         \1<R-R-R-R-R-R-R-R>(1-100)<C-C-C-C-C-C-C-C>{(1-FF)------|
//                                                    \(0){1-Split-/
//                                                        \0-Finish
// -----------------------------------------------------------------------------
// Includes
// -----------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>

// --------------------------------------------------------------------------
// Main defines
// --------------------------------------------------------------------------

#define rangeof(ENTRY) (0x01<<(0x08*sizeof(ENTRY)))

#define MUNERR_ALLOC -0x01
#define MUNERR_SIZE -0x02
#define MUNERR_SPLIT -0x03

#define MUN_COPY_MIN 0x02
#define MUN_COPY_MAX 0x100
#define MUN_RETRACE_MAX 0x100
#define MUN_WINDOW_SIZE (MUN_RETRACE_MAX * 2)
#define MUN_WINDOW_WRAP (MUN_WINDOW_SIZE - 0x01)
#define MUN_FIELD_SIZE 0x08
#define MUN_HUFFMAN_BITS 0x03				// Number of bits for the huffman counter
#define MUN_HUFFMAN_MAX (1 << MUN_HUFFMAN_BITS)

#define MUN_INC_MIN 0x02
#define MUN_INC_MAX 0x101

// --------------------------------------------------------------------------
// Routine macros
// --------------------------------------------------------------------------

#define MUN_SAVEFIELD(BField,BCount,BLoc,BNext,BArray,BNextLoc)\
{\
	if (--BCount == 0x00)\
	{\
		*BLoc = BField;\
		BLoc = BNext;\
		BNext = &BArray [BNextLoc++];\
		BField = 0x00;\
		BCount = 0x08;\
	}\
}

#define MUN_CLEARBIT(BField,BCount,BLoc,BNext,BArray,BNextLoc)\
{\
	BField <<= 1;\
	MUN_SAVEFIELD (BField, BCount, BLoc, BNext, BArray, BNextLoc);\
}

#define MUN_SETBIT(BField,BCount,BLoc,BNext,BArray,BNextLoc)\
{\
	BField = (BField << 1) | 1;\
	MUN_SAVEFIELD (BField, BCount, BLoc, BNext, BArray, BNextLoc);\
}

#define MUN_GETBIT(BValue,BField,BCount,BArray,BNextLoc)\
{\
	BValue = ((BField >> 0x0F) & 0x01);\
	BField <<= 0x01;\
	if (--BCount == 0x00)\
	{\
		BField |= (BArray [BNextLoc++] & 0xFF);\
		BCount = 0x08;\
	}\
}

// =============================================================================
// -----------------------------------------------------------------------------
// Mundi Compressor
// -----------------------------------------------------------------------------

int MunComp (char *&Data, int &DataSize, int SplitSize)

{
	if (DataSize < 1)
	{
		return (MUNERR_SIZE);
	}
	if (SplitSize != 0 && SplitSize < MUN_RETRACE_MAX)
	{
		return (MUNERR_SPLIT);
	}
	SplitSize &= -2;
	int SplitCount = 0;

	// --- Copying char data into u_short ---

	int InputLoc;
	int InputSize = (DataSize + (DataSize & 1)) / 2;
	u_short *Input = (u_short*) malloc (InputSize * sizeof (u_short));
	if (Input == NULL)
	{
		return (MUNERR_ALLOC);
	}
	int DataLoc = 0;
	for (InputLoc = 0; DataLoc < (DataSize & -2); InputLoc++)
	{
		Input [InputLoc] = Data [DataLoc++] << 8;
		Input [InputLoc] |= Data [DataLoc++] & 0xFF;
	}
	if ((DataSize & 1) != 0)
	{
		Input [InputLoc] = Data [DataLoc++] << 8;
	}

	// --- Init ---

	int RetStart [rangeof (u_short)];
	int RetCount [rangeof (u_short)] = { 0 };
	int Retraces [MUN_WINDOW_SIZE];
	u_short Window [MUN_WINDOW_SIZE + MUN_COPY_MAX + 1];
	u_int HuffCount [rangeof (u_char)] = { 0 };

	u_char Byte;
	u_short Word;

	u_short IncWord, IncStart;
	int IncCount;
	int IncBits;

	const u_short *WindowCur, *RetraceCur;
	int WindowLoc = 0;
	int WindowCopy;
	int WindowCount = InputSize;
	int RetraceLoc;
	int RetraceCount;
	int RetraceBest;
	int CopyMin = 1;
	int CopyCur;
	int CopyBest;
	int CopyTotal = MUN_COPY_MAX;
	int SavedCur;
	int SavedBest;
	int SavedTotal = 0x00;

	int DocuSize = InputSize;
	if (SplitSize != 0)
	{
		DocuSize += (InputSize / SplitSize);
	}


	u_short *DocuStore = (u_short*) malloc ((DocuSize * 0x02) * sizeof (u_short));
	if (DocuStore == NULL)
	{
		free (Input); Input = NULL;
		return (MUNERR_ALLOC);
	}
	u_short *Document = DocuStore;
	DocuSize = 0;

// -----------------------------------------------------------------------------
// Main Search Loop
// -----------------------------------------------------------------------------

	InputLoc = 0;
	while (WindowCount > 0)
	{

		// --- Updating the window ---

		WindowCopy = (MUN_COPY_MAX + 0x01) - (InputLoc - WindowLoc);
		if (WindowCopy > (InputSize - InputLoc))
		{
			WindowCopy = (InputSize - InputLoc);
		}
		while (WindowCopy-- > 0x00)
		{
			if (InputLoc >= MUN_WINDOW_SIZE)
			{
				Word = Window [InputLoc & MUN_WINDOW_WRAP];
				RetCount [Word]--;
			}
			Word = Input [InputLoc];
			if ((InputLoc & MUN_WINDOW_WRAP) <= (MUN_COPY_MAX + 0x01))
			{
				Window [(InputLoc & MUN_WINDOW_WRAP) + MUN_WINDOW_SIZE] = Word;
			}
			Window [InputLoc++ & MUN_WINDOW_WRAP] = Word;
		}

			// --- Retrace Search ---

		Word = Window [WindowLoc & MUN_WINDOW_WRAP];
		RetraceLoc = RetStart [Word];
		RetraceCount = RetCount [Word];
		SavedBest = -2; CopyBest = 1;
		if (1 > WindowCount)
		{
			CopyMin = WindowCount;
		}
		if (MUN_COPY_MAX > WindowCount)
		{
			CopyTotal = WindowCount;
		}
		while (RetraceLoc >= (WindowLoc - MUN_RETRACE_MAX) && RetraceCount-- > 0x00)
		{
			WindowCur = &Window [(WindowLoc + 1) & MUN_WINDOW_WRAP];
			RetraceCur = &Window [(RetraceLoc + 1) & MUN_WINDOW_WRAP];
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
			if (CopyCur >= MUN_COPY_MIN)
			{
				SavedCur = (CopyCur * 0x10) - (0x10 + 2);
				if (SavedCur > SavedBest)
				{
					SavedBest = SavedCur;
					CopyBest = CopyCur;
					RetraceBest = WindowLoc - RetraceLoc;
					if (CopyBest == CopyTotal)
					{
						break;
					}
				}
			}
			RetraceLoc = Retraces [RetraceLoc & MUN_WINDOW_WRAP];
		}
		SavedTotal += SavedBest;

			// --- Checking for increment mode ---

		IncBits = 0;
		if (WindowLoc > 0)
		{
			IncStart = Window [WindowLoc & MUN_WINDOW_WRAP];
			IncWord = IncStart - Window [(WindowLoc - 1) & MUN_WINDOW_WRAP];
			if (IncWord > -0x80 && IncWord < 0x7F)
			{
				for (IncCount = 1; IncCount < MUN_INC_MAX && ((WindowLoc + IncCount) * 2) < InputSize; IncCount++)
				{
					IncStart += IncWord;
					if (IncStart != Window [(WindowLoc + IncCount) & MUN_WINDOW_WRAP])
					{
						break;
					}
				}
				if (IncCount >= MUN_INC_MIN)
				{
					IncBits = (IncCount * 0x10) - (0x10 + 3);
				}
			}
		}

			// --- Documenting Results ---

		if (IncBits != 0 && IncBits > SavedBest)
		{
			if (SplitSize != 0)
			{
				SplitCount += IncCount * 2;
				if (SplitCount > SplitSize)
				{
					SplitCount -= SplitSize;
					*Document++ = 0x8000;
					*Document++ = 0;
					DocuSize++;
				}
			}
			*Document++ = 0xFF00;
			*Document++ = ((IncWord & 0xFF) << 8) | (IncCount - MUN_INC_MIN);
			CopyBest = IncCount;
		}
		else if (SavedBest == -2)
		{
			if (SplitSize != 0)
			{
				SplitCount += 2;
				if (SplitCount > SplitSize)
				{
					SplitCount -= SplitSize;
					*Document++ = 0x8000;
					*Document++ = 0;
					DocuSize++;
				}
			}
			*Document++ = 0xFFFF;
			*Document++ = Word;
			HuffCount [Word >> 8]++;
		}
		else
		{
			if (SplitSize != 0)
			{
				SplitCount += CopyBest * 2;
				if (SplitCount > SplitSize)
				{
					SplitCount -= SplitSize;
					*Document++ = 0x8000;
					*Document++ = 0;
					DocuSize++;
				}
			}
			*Document++ = RetraceBest;
			*Document++ = -(CopyBest - (MUN_COPY_MIN - 1));
		}
		DocuSize++;

			// --- Update Retraces ---

		do
		{
			Word = Window [WindowLoc & MUN_WINDOW_WRAP];
			Retraces [WindowLoc & MUN_WINDOW_WRAP] = RetStart [Word];
			RetStart [Word] = WindowLoc++;
			RetCount [Word]++;
			WindowCount--;
		}
		while (--CopyBest > 0x00);
	}

// -----------------------------------------------------------------------------
// Finding huffman entries
// -----------------------------------------------------------------------------

	u_char Huffman [MUN_HUFFMAN_MAX];

	int HuffmanSize = 0;
	while (HuffmanSize < MUN_HUFFMAN_MAX)
	{
		int HuffLoc = -1;
		int HuffBestLoc;
		int HuffBestCount = 0;
		while (++HuffLoc < rangeof (u_char))
		{
			if (HuffBestCount <= HuffCount [HuffLoc])
			{
				HuffBestCount = HuffCount [HuffLoc];
				HuffBestLoc = HuffLoc;
			}
		}
		if (HuffBestCount == 0)
		{
			break;
		}
		Huffman [HuffmanSize++] = HuffBestLoc;
		HuffCount [HuffBestLoc] = 0;
	}
	int HuffmanLoc = -1;
	while (++HuffmanLoc < rangeof (u_char))
	{
		HuffCount [HuffmanLoc] = 0xFFFFFFFF;
	}
	for (HuffmanLoc = 0; HuffmanLoc < HuffmanSize; HuffmanLoc++)
	{
		HuffCount [Huffman [HuffmanLoc]] = HuffmanLoc;
	}

// -----------------------------------------------------------------------------
// Setting up output
// -----------------------------------------------------------------------------

	SavedTotal -= MUN_HUFFMAN_BITS + 2; // Minus three bits for the huffman counter and 2 bits for the end of compression marker bitfield
	int OutputSize = (((InputSize * 0x10) - SavedTotal) + ((0x10 - (((InputSize * 0x10) - SavedTotal) & 0x0F)) & 0x0F)) / 0x10;
 	OutputSize += HuffmanSize;
	OutputSize += 2; // Two bytes for the end of compression marker

	char *Output = (char*) malloc (OutputSize * sizeof (u_short));
	if (Output == NULL)
	{
		free (Input); Input = NULL;
		free (DocuStore); DocuStore = NULL;
		return (MUNERR_ALLOC);
	}

	OutputSize = 0;

	char *BitLoc = &Output [OutputSize++];
	char *BitNext = &Output [OutputSize++];
	char BitField = (HuffmanSize - 1);
	char BitCount = 0x08 - MUN_HUFFMAN_BITS;

	for (HuffmanLoc = 0; HuffmanLoc < HuffmanSize; HuffmanLoc++)
	{
		Output [OutputSize++] = Huffman [HuffmanLoc];
	}

// -----------------------------------------------------------------------------
// Compression Loop
// -----------------------------------------------------------------------------

	Document = DocuStore;
	while (--DocuSize >= 0x00)
	{
		if (*Document == 0x8000)
		{
			// Split

			MUN_CLEARBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 0
			MUN_SETBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 1
			Output [OutputSize++] = 0x00;
			Output [OutputSize++] = 0x00;
			MUN_SETBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 1
			Document += 2;
		}
		else if (*Document == 0xFFFF)
		{
			Document++;
			Byte = *Document >> 8;
			if (HuffCount [Byte] == 0xFFFFFFFF)
			{
				// Uncompressed

				MUN_CLEARBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 0
				MUN_CLEARBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 0
				MUN_CLEARBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 0
				Output [OutputSize++] = Byte;
				Output [OutputSize++] = *Document++;
			}
			else
			{
				// Huffman

				MUN_SETBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 1
				int HuffBitSize = HuffCount [Byte];
				while (HuffBitSize-- > 0)
				{
					MUN_SETBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 1
				}
				if (HuffCount [Byte] < (HuffmanSize - 1))
				{
					MUN_CLEARBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 0
				}
				Output [OutputSize++] = *Document++;
			}
		}
		else if (*Document++ == 0xFF00)
		{
			// Increment mode

			MUN_CLEARBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 0
			MUN_CLEARBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 0
			MUN_SETBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 1
			Output [OutputSize++] = (*Document >> 0x08) & 0xFF;
			Output [OutputSize++] = *Document++ & 0xFF;
		}
		else
		{
			// LZSS

			MUN_CLEARBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 0
			MUN_SETBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 1
			Output [OutputSize++] = -Document [-1];
			Output [OutputSize++] = *Document++;
		}
	}
	MUN_CLEARBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 0
	MUN_SETBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 1
	Output [OutputSize++] = 0x00;
	Output [OutputSize++] = 0x00;
	MUN_CLEARBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);	// 0
	while (BitCount != 0x08)
	{
		MUN_CLEARBIT (BitField, BitCount, BitLoc, BitNext, Output, OutputSize);
	}
	OutputSize--;

// -----------------------------------------------------------------------------
// Saving data for return
// -----------------------------------------------------------------------------

	free (Input); Input = NULL;
	free (DocuStore); DocuStore = NULL;
	free (Data); Data = NULL;
	Data = Output;
	DataSize = OutputSize;

	return (0x00);
}

// =============================================================================
// -----------------------------------------------------------------------------
// Mundi Decompressor
// -----------------------------------------------------------------------------

int MunDec (char *&Input, int &InputSize)

{
	if (InputSize < 1)
	{
		return (MUNERR_SIZE);
	}
	int InputLoc = 0;
	u_short BitField = Input [InputLoc++] << 8;
	BitField |= Input [InputLoc++] & 0xFF;
	int HuffmanSize = ((BitField >> (0x10 - MUN_HUFFMAN_BITS)) & (MUN_HUFFMAN_MAX - 1)) + 1;
	BitField <<= MUN_HUFFMAN_BITS;
	char BitCount = 8 - MUN_HUFFMAN_BITS;

	u_char Byte;
	u_short Word;

	u_short IncWord;
	int IncCount;

	// --- Unpacking huffman tree ---

	int Count = 0x100;
	int Shift = 0x00;
	u_short Huffman [0x100];
	int HuffmanLoc = 0;
	while (HuffmanSize-- > 0)
	{
		if (HuffmanSize != 0)
		{
			Count >>= 1;
			Shift++;
		}
		Word = Input [InputLoc++] << 8;
		Word |= Shift;
		int Position = 0;
		while (Position++ < Count)
		{
			Huffman [HuffmanLoc++] = Word;
		}
	}

	int OutputLoc = 0;
	int OutputSize = 0x800;
	char *Output = (char*) malloc (OutputSize);

	// --- Decompression ---

	for ( ; ; )
	{
		if (OutputLoc > (OutputSize / 2))
		{
			OutputSize *= 2;
			char *OutputNew = (char*) realloc (Output, OutputSize);
			if (OutputNew == NULL)
			{
				free (Output); Output = NULL;
				return (MUNERR_ALLOC);
			}
			Output = OutputNew;
			OutputNew = NULL;
		}
		MUN_GETBIT (Byte, BitField, BitCount, Input, InputLoc);
		if (Byte != 0)
		{
			// --- Huffman ---

			Word = BitField >> 8;
			Byte = Huffman [Word] >> 8;
			Shift = Huffman [Word] & 0xFF;
			BitField <<= Shift;
			BitCount -= Shift;
			if (BitCount <= 0)
			{
				BitCount = -BitCount;
				BitField |= (Input [InputLoc++] & 0xFF) << BitCount;
				BitCount = -(BitCount - 8);
			}
			Output [OutputLoc++] = Byte;
			Output [OutputLoc++] = Input [InputLoc++];
		}
		else
		{
			MUN_GETBIT (Byte, BitField, BitCount, Input, InputLoc);
			if (Byte == 0)
			{
				MUN_GETBIT (Byte, BitField, BitCount, Input, InputLoc);
				if (Byte == 0)
				{
					// --- Uncompressed ---

					Output [OutputLoc++] = Input [InputLoc++];
					Output [OutputLoc++] = Input [InputLoc++];
				}
				else
				{
					// --- Increment mode ---

					IncWord = Input [InputLoc++]; // This SHOULD sign extend... if it doesn't, then perhaps shift left then right...
					IncCount = (Input [InputLoc++] & 0xFF) + MUN_INC_MIN;
					Word = Output [OutputLoc - 2] << 0x08;
					Word |= Output [OutputLoc - 1] & 0xFF;

					while (IncCount-- > 0)
					{
						Word += IncWord;
						Output [OutputLoc++] = Word >> 0x08;
						Output [OutputLoc++] = Word;
					}
				}
			}
			else
			{
				// --- LZSS ---

				char *Retrace = &Output [OutputLoc - ((0x100 - (Input [InputLoc++] & 0xFF)) * 2)];
				int Copy = (0x100 - (Input [InputLoc++] & 0xFF)) + (MUN_COPY_MIN - 1);
				if (Copy == (0x100 + (MUN_COPY_MIN - 1)))
				{
					MUN_GETBIT (Byte, BitField, BitCount, Input, InputLoc);
					if (Byte != 0)
					{
						continue;	// Split data, just continue
					}
					break;
				}
				while (Copy-- > 0)
				{
					Output [OutputLoc++] = *Retrace++;
					Output [OutputLoc++] = *Retrace++;
				}
			}
		}
	}
	free (Input);
	Input = Output;
	InputSize = OutputLoc;
	return (0x00);
}

// =============================================================================








