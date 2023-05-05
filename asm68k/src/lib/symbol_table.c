#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <lib/compat.h>
#include <lib/debug.h>
#include <lib/error_lib.h>
#include <lib/messages/global.h>
#include <lib/symbols.h>
#include <lib/symbol_table.h>

#include <asmlink/debug_tracer.h>

SymbolRef* Symbol_GlobalTable;
Symbol* SymbolExt_CurrentScope;
uint32_t SymbolExt_CurrentScopeHash;

// create an empty symbol table
SymbolRef* Symbol_AllocateNewTable(uint8_t isLocal) {
	// allocate everything
	SymbolRef* data = malloc(isLocal ? SYMBOL_TABLE_SIZE_LOCAL : SYMBOL_TABLE_SIZE);
	Tracer_WriteSymbolTableAction(0, isLocal);

	if (!data) {
		// malloc failed!
		Error_Error(ERRTXT_MALLOC_FAIL " ");
	}

	// clear memory
	memset(data, 0, isLocal ? SYMBOL_TABLE_SIZE_LOCAL : SYMBOL_TABLE_SIZE);

#ifdef DEBUG
	memSymbols += isLocal ? SYMBOL_TABLE_SIZE_LOCAL : SYMBOL_TABLE_SIZE;
	updateMemoryUsage();
#endif
	return data;
}

// function to clear symbol inner data
void Symbol_Unallocate(Symbol* entry) { // Function is within a recursive call chain, need to refactor
	// free the name string
	//	if(entry->name) {
	//		free(entry->name);		TODO: fix - segmentation fault caused by using static symbols as well as dynamic symbols
	//	}

	switch (entry->type) {
		case Symbol_Type_String_Equate:
			// free(entry->string);

		case Symbol_Type_Integer_Equate:
			// cler local label table ONLY if its not NUL
			if (entry->innerTable) {
				Symbol_UnallocateTable(entry->innerTable, 1);
			}
			break;
	}
}

// clear a symbol table
void Symbol_UnallocateTable(SymbolRef* table, uint8_t isLocal) { // Function is within a recursive call chain, need to refactor
	SymbolRef* pos = table + (isLocal ? (1 << SYMBOL_HASH_FUNC_BITS_LOCAL) : (1 << SYMBOL_HASH_FUNC_BITS));
	Tracer_WriteSymbolTableAction(1, isLocal);

	// look at every item to free it
	while (pos > table) {
		pos--;

		// free data if it exists
		if (pos->data != NULL) {
			// traverse the symbol table to delete all local labels

			// check for no entries
			if (pos->entries != 0) {
				// load head pointer
				Symbol* entry = pos->data;
				int32_t entries = (int32_t)pos->entries; // use int32_t here instead of uint16_t : the while loop requires a check for less than 0

				while (--entries >= 0) {
					// reset symbol data
					//	Tracer_WriteSymbolAction(1, isLocal, entry);
					Symbol_Unallocate(entry);
					entry++;
				}
			}

			free(pos->data);
		}
	}

	// free the table
	free(table);
}

// find a symbol by hash code
Symbol* Symbol_FindByHash(uint32_t hash, SymbolRef* table) {
	// check for no entries
	if (table->entries == 0) {
		return NULL;
	}

	// load head pointer
	Symbol* entry = table->data;
	int32_t entries = (int32_t)table->entries; // use int32_t here instead of uint16_t : the while loop requires a check for less than 0

	while (--entries >= 0) {
		// check if we found the right one
		if (entry->hash == hash) {
			return entry;
		}

		entry++;
	}

	// not found
	return NULL;
}

// function to allocate a new symbol to the SymbolRef
Symbol* Symbol_AllocateNew(uint32_t hash, SymbolRef* table) {
	if (table->alloc <= table->entries) {
		if (table->data != NULL) {
#ifdef DEBUG
			memSymbols += sizeof(Symbol) * table->alloc;
#endif

			// re-allocate
			table->alloc <<= 1;

		} else {
			// first alloc
			table->alloc = 8;
#ifdef DEBUG
			memSymbols += sizeof(Symbol) * table->alloc;
#endif
		}

		// allocate dat memory
		table->data = realloc(table->data, table->alloc * sizeof(Symbol));

		// check if allocation failed
		if (table->data == NULL) {
			Error_Error(ERRTXT_MALLOC_FAIL " ");
		}

#ifdef DEBUG
		updateMemoryUsage();
#endif
	}

	// find the first free slot
	Symbol* slot = table->data + table->entries;
	table->entries++;

	// reset data
	memset(slot, 0, sizeof(Symbol));
	slot->hash = hash;
	return slot;
}

// create a new symbol
Symbol* Symbol_FindOrAllocate(uint32_t hash, uint8_t mustBeNew) {
	// calculate table offset
	SymbolRef* tab = Symbol_GlobalTable + (hash & ((1 << SYMBOL_HASH_FUNC_BITS) - 1));

	// try to find the symbol
	Symbol* sym = Symbol_FindByHash(hash, tab);

	if (sym != NULL) {
		// symbol exists
		if (mustBeNew && (sym->flags & Symbol_Flag_Initialized) != 0) {
			return NULL; // NULL indicates the symbol exists
		}

		// symbol exists but not initialized
		return sym;
	}

	// create the symbol
	return Symbol_AllocateNew(hash, tab);
}

// check the state of the symbol and create innerTable if needed
int Symbol_CheckAndCreateInnerTable(Symbol* sym) {
	if (sym->type != Symbol_Type_Integer_Equate && sym->type != Symbol_Type_String_Equate) {
		// this is not an equate or equate string!
		return 0;
	}

	// check if local symbol table exists
	if (!sym->innerTable) {
		sym->innerTable = Symbol_AllocateNewTable(1);
	}

	return 1;
}

// create a new local symbol
Symbol* Symbol_FindOrAllocateLocal(uint32_t hash, Symbol* sym, uint8_t mustBeNew) {
	if (!Symbol_CheckAndCreateInnerTable(sym)) {
		return NULL;
	}

	// calculate table offset
	SymbolRef* tab = sym->innerTable + (hash & ((1 << SYMBOL_HASH_FUNC_BITS_LOCAL) - 1));

	// try to find the symbol
	sym = Symbol_FindByHash(hash, tab);

	if (sym != NULL) {
		// symbol exists
		if (mustBeNew && (sym->flags & Symbol_Flag_Initialized) != 0) {
			return NULL; // NULL indicates the symbol exists
		}

		// symbol exists but not initialized
		return sym;
	}

	// create the symbol
	return Symbol_AllocateNew(hash, tab);
}

// fetch a symbol
Symbol* Symbol_Fetch(uint32_t hash, SymbolRef* table) {
	// calculate table offset
	SymbolRef* tab = table + (hash & ((1 << SYMBOL_HASH_FUNC_BITS) - 1));

	// try to find the symbol
	return Symbol_FindByHash(hash, tab);
}

// fetch a local symbol
Symbol* Symbol_FetchLocal(uint32_t hash, Symbol* sym) {
	if (!Symbol_CheckAndCreateInnerTable(sym)) {
		return NULL;
	}

	// calculate table offset
	SymbolRef* tab = sym->innerTable + (hash & ((1 << SYMBOL_HASH_FUNC_BITS_LOCAL) - 1));

	// try to find the symbol
	return Symbol_FindByHash(hash, tab);
}

// helper function for deleting a symbol from a table
int Symbol_CommonDeleteByHash(uint32_t hash, SymbolRef* table, uint8_t isLocal) {
	// check for no entries
	if (table->entries == 0) {
		return 0;
	}

	// load head pointer
	Symbol* entry = table->data;
	int32_t entries = (int32_t)table->entries; // use int32_t here instead of uint16_t : the while loop requires a check for less than 0

	while (--entries >= 0) {
		// check if we found the right one

		if (entry->hash == hash) {
			//	Tracer_WriteSymbolAction(1, isLocal, entry);
			Symbol_Unallocate(entry);

			// copy over
			memcpy(entry, entry + 1, entries * sizeof(Symbol));
			--table->entries;
			return 1;
		}

		entry++;
	}

	// did not find it
	return 0;
}

// delete a symbol
bool Symbol_DeleteByHash(uint32_t hash, SymbolRef* table) {
	// calculate table offset
	SymbolRef* tab = table + (hash & ((1 << SYMBOL_HASH_FUNC_BITS) - 1));
	return Symbol_CommonDeleteByHash(hash, tab, 0);
}

// delete a symbol
bool Symbol_DeleteByHashLocal(uint32_t hash, Symbol* sym) {
	if (sym->type != Symbol_Type_Integer_Equate && sym->type != Symbol_Type_String_Equate) {
		// this is not an equate or equate string!
		return 0;
	}

	if (!sym->innerTable) {
		// symbol table not even created, nvm!
		return 0;
	}

	// calculate table offset
	SymbolRef* tab = sym->innerTable + (hash & ((1 << SYMBOL_HASH_FUNC_BITS_LOCAL) - 1));
	return Symbol_CommonDeleteByHash(hash, tab, 1);
}
