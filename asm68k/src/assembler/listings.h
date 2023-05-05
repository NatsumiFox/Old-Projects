#if !defined(INCLUDE_ASSEMBLER_LISTINGS_H)
#define INCLUDE_ASSEMBLER_LISTINGS_H

#include <stdio.h>

#include <lib/lengthstring.h>

void initializeListingsFile();
void closeListingsFile();
void printListingsLine();
void writeListingsFileChange(uint8_t ch, int32_t filesCount, uint8_t* filename);
void setListingsBytes();
void setListingsEqu(uint64_t value);
void setListingsEqustr(LengthString* value);
void setListingsEquUnk();
void clearListingsAddress();

extern void (*writeListingsAddress)(int32_t);

extern uint8_t useAsmErrors;
extern FILE* listingFile;
extern char* listingPath;
extern uint8_t* listingBufferPtr;

// this represents a single listings line
#define LST_POS_ADDR 0
#define LST_LEN_ADDR 12
#define LST_POS_S1 LST_LEN_ADDR
#define LST_POS_HEX (LST_POS_S1 + 1)
#define LST_LEN_HEX 24
#define LST_POS_PLUS (LST_POS_HEX + LST_LEN_HEX)
#define LST_POS_MACRO (LST_POS_PLUS + 1)
#define LST_POS_S2 (LST_POS_MACRO + 1)
#define LST_POS_BUF (LST_POS_S2 + 1)
#define LST_LEN_BUF 0x400
#define LST_POS_SAFE (LST_LEN_BUF + LST_POS_BUF)
#define LST_LEN 0x2000

#define LST_ERR_MAX_LEN 128

#define FILL_UNUSED_ADDR ' '

#endif // INCLUDE_ASSEMBLER_LISTINGS_H
