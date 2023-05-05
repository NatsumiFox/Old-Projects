#if !defined(INCLUDE_ASSEMBLER_PASS2_H)
#define INCLUDE_ASSEMBLER_PASS2_H

#include <asmlink/symbol_ext.h>

#include <lib/compat.h>
#include <lib/expressions.h>
#include <lib/lengthstring.h>
#include <lib/symbols.h>

// pass2 replacement struct
typedef struct {
	uint64_t address;
	uint64_t filePos;
	FILE* file;
	LengthString* filename;
	uint32_t lineNumber;
	uint16_t patch;
	uint16_t value;

	// token table
	EvaluateToken* start;
	EvaluateToken* end;
	LengthString* line;
} ObjectReplacement;

// pass2 functions relating to pass2Func table
typedef enum {
	Pass2_Patch_Uint4_Low,
	Pass2_Patch_Uint4_High,
	Pass2_Patch_Int4_Low,
	Pass2_Patch_Int4_High,
	Pass2_Patch_4Bit_Low,
	Pass2_Patch_4Bit_High,

	Pass2_Patch_Uint8,
	Pass2_Patch_Int8,
	Pass2_Patch_Byte,

	Pass2_Patch_Uint16,
	Pass2_Patch_Int16,
	Pass2_Patch_Word,
	Pass2_Patch_Swap_Uint16,
	Pass2_Patch_Swap_Int16,
	Pass2_Patch_Swap_Word,

	Pass2_Patch_Uint32,
	Pass2_Patch_Int32,
	Pass2_Patch_Long,
	Pass2_Patch_Swap_Uint32,
	Pass2_Patch_Swap_Int32,
	Pass2_Patch_Swap_Long,

	Pass2_Patch_Quad,
	Pass2_Patch_Swap_Quad,

#if ENDIANNESS == 0
	// big endian host machine
	Pass2_Patch_LE_Uint16 = Pass2_Patch_Swap_Uint16,
	Pass2_Patch_LE_Int16 = Pass2_Patch_Swap_Int16,
	Pass2_Patch_LE_Word = Pass2_Patch_Swap_Word,
	Pass2_Patch_BE_Uint16 = Pass2_Patch_Uint16,
	Pass2_Patch_BE_Int16 = Pass2_Patch_Int16,
	Pass2_Patch_BE_Word = Pass2_Patch_Word,

	Pass2_Patch_LE_Uint32 = Pass2_Patch_Swap_Uint32,
	Pass2_Patch_LE_Int32 = Pass2_Patch_Swap_Int32,
	Pass2_Patch_LE_Long = Pass2_Patch_Swap_Long,
	Pass2_Patch_BE_Uint32 = Pass2_Patch_Uint32,
	Pass2_Patch_BE_Int32 = Pass2_Patch_Int32,
	Pass2_Patch_BE_Long = Pass2_Patch_Long,

	Pass2_Patch_LE_Quad = Pass2_Patch_Swap_Quad,
	Pass2_Patch_BE_Quad = Pass2_Patch_Quad,
#else
	// little endian host machine
	Pass2_Patch_LE_Uint16 = Pass2_Patch_Uint16,
	Pass2_Patch_LE_Int16 = Pass2_Patch_Int16,
	Pass2_Patch_LE_Word = Pass2_Patch_Word,
	Pass2_Patch_BE_Uint16 = Pass2_Patch_Swap_Uint16,
	Pass2_Patch_BE_Int16 = Pass2_Patch_Swap_Int16,
	Pass2_Patch_BE_Word = Pass2_Patch_Swap_Word,

	Pass2_Patch_LE_Uint32 = Pass2_Patch_Uint32,
	Pass2_Patch_LE_Int32 = Pass2_Patch_Int32,
	Pass2_Patch_LE_Long = Pass2_Patch_Long,
	Pass2_Patch_BE_Uint32 = Pass2_Patch_Swap_Uint32,
	Pass2_Patch_BE_Int32 = Pass2_Patch_Swap_Int32,
	Pass2_Patch_BE_Long = Pass2_Patch_Swap_Long,

	Pass2_Patch_LE_Quad = Pass2_Patch_Quad,
	Pass2_Patch_BE_Quad = Pass2_Patch_Swap_Quad,
#endif

	// custom processor-specific patches
	Pass2_Patch_68k_Int8PC,
	Pass2_Patch_68k_Int16PC,
	Pass2_Patch_68k_AddrWord,
	Pass2_Patch_68k_BCC_Short,
	Pass2_Patch_68k_ADDQ_SUBQ,
	Pass2_Patch_68k_MOVEQ,
	Pass2_Patch_68k_Shift_Count,

} Pass2_Patch;

// pass2 functions relating to Pass2ResolveSymbols table
typedef enum {
	Pass2_Resolve_Equ,

} Pass2_Resolve;

void addPass2Data(uint16_t patch, uint64_t address, uint64_t filePos, EvaluateToken* start, EvaluateToken* end, uint16_t value);

void addPass2Symbol(uint16_t patch, uint64_t address, EvaluateToken* start, EvaluateToken* end, uint32_t hglobal, uint32_t hlocal, uint8_t mode);

void doPass2();

// helper macros
#define p2wWrite(num, file, buf) \
	fwrite(buf, 1, num, file);

#define p2wByte(d, file, buf) \
	*(buf) = (uint8_t)(d);      \
	p2wWrite(1, file, buf);

#define p2wWord(d, file, buf)          \
	*((uint16_t*)(buf)) = (uint16_t)(d); \
	p2wWrite(2, file, buf);

#define p2wLong(d, file, buf)          \
	*((uint32_t*)(buf)) = (uint32_t)(d); \
	p2wWrite(4, file, buf);

#define p2wQuad(d, file, buf)          \
	*((uint64_t*)(buf)) = (uint64_t)(d); \
	p2wWrite(8, file, buf);

#endif // INCLUDE_ASSEMBLER_PASS2_H
