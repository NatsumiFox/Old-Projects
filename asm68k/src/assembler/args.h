#if !defined(INCLUDE_ASSEMBLER_ARGS_H)
#define INCLUDE_ASSEMBLER_ARGS_H

#include <stdint.h>

// stuff for -e flag
extern uint32_t ExtraLinesCount;
extern uint8_t **ExtraLines;

void loadCommandLine(int argc, char *argv[]);

#endif // INCLUDE_ASSEMBLER_ARGS_H
