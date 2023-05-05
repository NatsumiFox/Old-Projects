// =============================================================================
// -----------------------------------------------------------------------------
// Shared code between more than one program
// -----------------------------------------------------------------------------

#include "__Twizzler.c"
#define ICONBOARDER TRUE

// =============================================================================
// -----------------------------------------------------------------------------
// Packing and compressing data
// -----------------------------------------------------------------------------

int PackData (char *Data, int MemorySize, const char *Directory)

{
	char *Memory = (char*) malloc (MemorySize);
	if (Memory == NULL)
	{
		printf ("    Error, cannot allocate memory for compression\n"
			"\nPress enter key to exit...\n");
		fflush (stdin); getchar ( ); return (0xFF);
	}
	int Count;
	for (Count = 0x00; Count < MemorySize; Count++)
	{
		Memory [Count] = Data [Count];
	}
	TwizComp (Memory, MemorySize);
	FILE *File = fopen (Directory, "wb");
	int WriteSize = fwrite (Memory, 0x01, MemorySize, File);
	free (Memory); Memory = NULL;
	fclose (File);
	if (WriteSize != MemorySize)
	{
		printf ("    Error, fwrite size incorrect, %X of %X written\n"
			"\nPress enter key to exit...\n", WriteSize, MemorySize);
		fflush (stdin); getchar ( ); return (0xFF);
	}
	return (0x00);
}

// =============================================================================