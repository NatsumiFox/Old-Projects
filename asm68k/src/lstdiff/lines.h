#if !defined(INCLUDE_LSTDIFF_LINES_H)
#define INCLUDE_LSTDIFF_LINES_H

#include <stdint.h>

// struct for storing lines from listings file
typedef struct {
	char* text;
	char* file;
	uint64_t address;
	uint32_t line;

} ListingsLine;

// store asm filenames
#define ASM_FILE_STACK_SIZE 32
extern char* asmFileStack[ASM_FILE_STACK_SIZE];
extern uint32_t asmLineStack[ASM_FILE_STACK_SIZE];
extern int32_t asmFileStackPos;

extern ListingsLine* listingsLines;
extern uint32_t listingsAlloc;
extern uint32_t listingsUsed;

void processListings();

uint32_t fetchLineIndexAt(uint64_t address, uint32_t start);

ListingsLine* fetchLineByIndex(uint32_t index);

#endif // INCLUDE_LSTDIFF_LINES_H
