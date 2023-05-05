#if !defined(INCLUDE_ASSEMBLER_DEBUG_H)
#define INCLUDE_ASSEMBLER_DEBUG_H

#include <stddef.h>
#include <stdint.h>
#include <stddef.h>

#ifdef DEBUG
extern size_t memTokenTable;
extern size_t memTokenStr;
extern size_t memSymbols;
extern size_t memSymStr;
extern size_t memPass2;

void initDebug();
size_t updateMemoryUsage();
void printDebugInfoFinish();
void createHashSymbolFile(char* hpath, char* cpath);
#endif

#endif // INCLUDE_ASSEMBLER_DEBUG_H
