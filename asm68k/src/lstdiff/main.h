#if !defined(INCLUDE_LSTDIFF_MAIN_H)
#define INCLUDE_LSTDIFF_MAIN_H

#include <stdint.h>

#define BUFFER_LEN 0x1000
#define BUFFER_MIN 0x400

// struct for handling file processing
typedef struct {
	char buffer[BUFFER_LEN + 4];
	char* cur; // current buffer pointer
	char* end; // end position of the buffer
	FILE* file;
	char* filename;
	uint64_t address; // absolute file address
	uint64_t size;		// size of the file
} FileHelper;

extern FileHelper listingsHelper;
extern FileHelper objectHelper;
extern FileHelper baseHelper;

// maximum number of mismatched bytes
#define MAXERRORS 0x1000

extern uint32_t numErrors;
extern uint32_t maxErrors;

void checkFillBuffer(FileHelper* helper);

void loadBuffer(FileHelper* helper, uint64_t address);

void closeFiles();

int16_t getByte(FileHelper* helper, int increment);

#endif // INCLUDE_LSTDIFF_MAIN_H
