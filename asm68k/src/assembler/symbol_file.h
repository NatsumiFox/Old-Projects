#if !defined(INCLUDE_ASSEMBLER_SYMBOL_FILE_H)
#define INCLUDE_ASSEMBLER_SYMBOL_FILE_H

#include <stdint.h>

// define symbol types
#define SYM_FMT_H 0
#define SYM_FMT_EQU 1

extern uint8_t symbolFormat;
extern char* symbolPath;

void generateSymbolFile();

#endif // INCLUDE_ASSEMBLER_SYMBOL_FILE_H
