#include <stdint.h>
#include <stdlib.h>

#include <asmlink/debug_tracer.h>
#include <asmlink/symbol_ext.h>

#include <assembler/assembler.h>
#include <assembler/error.h>
#include <assembler/object.h>
#include <assembler/hash.h>

#include <lib/debug.h>
#include <lib/messages/global.h>

// built-in symbols table
BuiltInSymbol SymbolExt_BuiltInTable[BI_NUM_ELEMENTS];

// function to find a built-in symbol by hash
BuiltInSymbol* SymbolExt_FetchBuiltinByHash(uint32_t hash) {
	for (int32_t i = 0; i < BI_NUM_ELEMENTS; i++) {
		// check if the hash matches
		if (SymbolExt_BuiltInTable[i].hash == hash) {
			return &SymbolExt_BuiltInTable[i];
		}
	}

	// indicate failure
	return NULL;
}

// helper function to create a standard symbol
Symbol* SymbolExt_MakeStdSymbol(uint32_t hash, uint8_t mustBeNew) {
	// try to create the label
	Symbol* sym = NULL;
	uint8_t flags = 0;

	switch (hasLabel) {
		case 1:
			sym = Symbol_FindOrAllocate(hash, mustBeNew);
			break;

		case 2:
			sym = Symbol_FindOrAllocateLocal(hash, SymbolExt_CurrentScope, mustBeNew);
			flags |= Symbol_Flag_Local;
			break;

		case 0:
			return NULL;
		default:
			break;
	}

	if (sym != NULL) {
		// set symbol params
		sym->flags |= flags;
		sym->innerTable = NULL; // ensure the inner table is NULL
		Symbol_AllocateNameFromBuffer(sym, labelNameBuffer, labelNameLength);
	}

	hasLabel = 0;
	return sym;
}

// helper function to create a standard label
Symbol* SymbolExt_MakeStdLabel(uint32_t hash) {
	// try to create the label
	Symbol* sym = SymbolExt_MakeStdSymbol(hash, 1);

	if (sym == NULL) {
		// multiply defined! bad bad
		Error_PrepareString(labelNameBuffer, labelNameBuffer + labelNameLength);
		Error_ErrorUnderline(buffers.line, labelNameBuffer, labelNameBuffer + labelNameLength, ERRFMT_SYMBOL_MULTIPLY, buffers.error);
	}

	// update scope on non-local labels
	if ((sym->flags & Symbol_Flag_Local) == 0) {
		SymbolExt_CurrentScope = sym;
		SymbolExt_CurrentScopeHash = hash;
	}

	// update symbol info
	sym->type = Symbol_Type_Integer_Equate;
	sym->flags |= Symbol_Flag_Initialized | Symbol_Flag_Locked;
	sym->extraParam = objectAddress;
	Tracer_WriteSymbolAction(0, sym->flags & Symbol_Flag_Local, sym);
	return sym;
}

// helper function to create a name for a symbol
void Symbol_AllocateNameFromBuffer(Symbol* sym, char* buffer, int32_t length) {
	// free the name string
	if (sym->name) {
		return;
	}

#ifdef DEBUG
	memSymStr += length + 1;
#endif

	// allocate memory for the name
	char* name = sym->name = malloc(length + 1);

	if (!name) {
		// malloc failed
		Error_ErrorProgram(ERRTXT_MALLOC_FAIL " ");
	}

	// copy the string over
	while (length-- > 0) {
		*name++ = *buffer++;
	}

	// set NUL at the end
	*name = 0;
}
