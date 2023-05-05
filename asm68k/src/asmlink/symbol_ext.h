#if !defined(INCLUDE_ASMLINK_SYMBOL_EXT_H)
#define INCLUDE_ASMLINK_SYMBOL_EXT_H

#include <assembler/hash.h>

#include <lib/symbol_table.h>

// helper function to create a label if it existed
#define createLabelCheck()          \
	if (hasLabel) {                   \
		SymbolExt_MakeStdLabel(labelHash); \
	}

// details for the table of built-in symbols
typedef struct {
	uint32_t hash; // hash of this entry
} BuiltInSymbol;

// built-in symbols table
extern BuiltInSymbol SymbolExt_BuiltInTable[BI_NUM_ELEMENTS];

extern Symbol* SymbolExt_CurrentScope;
extern uint32_t SymbolExt_CurrentScopeHash;

Symbol* SymbolExt_MakeStdSymbol(uint32_t hash, uint8_t mustBeNew);

Symbol* SymbolExt_MakeStdLabel(uint32_t hash);

BuiltInSymbol* SymbolExt_FetchBuiltinByHash(uint32_t hash);

#endif // INCLUDE_ASMLINK_SYMBOL_EXT_H
