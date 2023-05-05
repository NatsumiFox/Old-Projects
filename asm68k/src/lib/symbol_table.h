#if !defined(INCLUDE_ASSEMBLER_SYMBOL_TABLE_H)
#define INCLUDE_ASSEMBLER_SYMBOL_TABLE_H

#include <stdint.h>

#include <lib/symbols.h>

#define SYMBOL_HASH_FUNC_BITS 12
#define SYMBOL_HASH_FUNC_BITS_LOCAL 6

#define SYMBOL_TABLE_SIZE (sizeof(SymbolRef) * (1 << SYMBOL_HASH_FUNC_BITS))
#define SYMBOL_TABLE_SIZE_LOCAL (sizeof(SymbolRef) * (1 << SYMBOL_HASH_FUNC_BITS_LOCAL))

struct SymbolRef {
	uint16_t entries;		// number of entries in the symbol table
	uint16_t alloc;			// number of allocated entries
	Symbol* data;			// data of the actual symbols
};

extern SymbolRef* Symbol_GlobalTable;

void Symbol_AllocateNameFromBuffer(Symbol* sym, char* buffer, int32_t length);

#endif // INCLUDE_ASSEMBLER_SYMBOL_TABLE_H
