#if !defined(INCLUDE_ASSEMBLER_ASSEMBLER_H)
#define INCLUDE_ASSEMBLER_ASSEMBLER_H

#include <stdint.h>
#include <assembler/listings.h>

// processor enums
enum Processor {
	MC68000 = 0,
	MC68008 = 1,
	MC68010 = 2,
	MC68012 = 3,
	MC68020 = 4,
};

// options structure
typedef struct {
	uint8_t fillChar;
	uint8_t localLabelSymbol;
	uint8_t localSymbolFlags;    // refers to charFlagLUT

	uint8_t cpuModel;        // Processor
	uint8_t programCounterSymbol;
	uint8_t endianness;

	uint8_t automaticEvens;
	uint8_t alternateNums;
	uint8_t caseSensitive;
	uint8_t descopeLabels;
	uint8_t printWarnings;
	uint8_t allowWhitespace;

	uint8_t optimizePCRelative;
	uint8_t optimizeShortBranch;
	uint8_t optimizeWordAddr;
	uint8_t optimizeZeroOffset;
	uint8_t optimizeADDQ;
	uint8_t optimizeMOVEQ;
} Options;

// various assembler options
extern Options options;
extern uint8_t *caseLUT;
extern uint8_t expandMacros;
extern uint8_t quietMode;
extern int8_t pass;            // current pass ID. -1 = commandline, 0 = pass1, 1 = pass2

// various file paths
extern char *sourcePath;

// various buffers
#define LINE_MAX_LEN 0x400

// line buffers
typedef struct {
	uint32_t lineLength;
	uint8_t line[LINE_MAX_LEN];
	uint8_t listings[LST_LEN];
	uint8_t error[LINE_MAX_LEN];
	uint8_t underline[LINE_MAX_LEN];
} LineBuffers;

extern LineBuffers buffers;

// various label things
extern uint32_t labelHash;
extern uint8_t hasLabel;        // 0 = no label, 1 = label, 2 = local label
extern int32_t labelNameLength;
extern uint8_t *labelNameBuffer;
extern uint8_t *funcNameBufStart;


#endif // INCLUDE_ASSEMBLER_ASSEMBLER_H
