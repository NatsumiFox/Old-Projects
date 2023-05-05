#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "assembler.h"
#include "error.h"
#include "hash.h"
#include "listings.h"
#include "symbol_file.h"

#include <asmlink/symbol_ext.h>

#include <lib/compat.h>
#include <lib/files.h>
#include <lib/expressions.h>
#include <lib/string_lib.h>
#include <lib/messages/global.h>

uint8_t symbolFormat;
char* symbolPath;
uint8_t symbolBuffer[1024];

// symbol name copy
c_inline uint32_t writeSymbolName(Symbol* entry, uint8_t** buffer) {
	uint32_t length = 0;

	// copy symbol name to buffer
	uint8_t* name = entry->name != NULL ? entry->name : (uint8_t*)"<null>";

	// silently ignore empty label names
	if (*name == 0) {
		return 0;
	}

	while (*name) {
		**buffer = *name++;
		(*buffer)++;
		length++;
	}

	// add a colon at the end
	**buffer = ':';
	(*buffer)++;

	// pad symbol to column 32
	length += 1 + String_PadBuffer((char**)buffer, 32, length + 1);
	return length;
}

// helper function to write an equ format symbol
uint32_t writeEquSymbol(Symbol* entry, uint8_t* buffer, uint32_t length) {
	// check if the symbol was ever initialized
	if ((entry->flags & Symbol_Flag_Initialized) == 0) {
		return 0;
	}

	// advance buffer position to skip written bytes
	buffer += length;

	switch (entry->type) {
		case Symbol_Type_Integer_Equate: {
			// write symbol name and check for invalid names
			uint32_t xlen = writeSymbolName(entry, &buffer);
			length += xlen;

			if (xlen == 0) {
				return 0;
			}

			// write equ 0x and value
			length += sprintf((char*)buffer, "equ $%" PRIX64, entry->extraParam);
			return length;
		}

		case Symbol_Type_String_Equate: {
			// write symbol name and check for invalid names
			uint32_t xlen = writeSymbolName(entry, &buffer);
			length += xlen;

			if (xlen == 0) {
				return 0;
			}

			// write equ and string open
			xlen = sprintf((char*)buffer, "equ \"");
			length += xlen;
			buffer += xlen;

			// write actual string
			uint8_t* str = entry->string->string;

			for (uint32_t i = 0; i < entry->string->length; i++) {
				// get char
				uint8_t c = *str++;

				if (c >= 0x20 && c < 0x7F) {
					if (c == '"') {
						// " is a special case
						*buffer++ = '\\';
						*buffer++ = '"';
						length += 2;
						continue;
					}

					// write character as is
					*buffer++ = c;
					length++;
					continue;
				}

				// write escape code
				*buffer++ = '\\';
				*buffer++ = 'x';
				*buffer++ = String_UpperCaseHexLUT[c >> 4];
				*buffer++ = String_UpperCaseHexLUT[c & 0xF];
				length += 4;
			}

			*buffer++ = '"';
			return length + 1;
		}

		default:
			return 0;
	}
}

// function to write local label symbols
void writeEquLocalSymbols(FILE* file, Symbol* data, uint8_t* buffer, uint32_t length) {
	if (!data->innerTable) {
		// no local labels
		return;
	}

	// prefix with local label symbol
	*(buffer + length) = options.localLabelSymbol;
	length++;

	// traverse symbols to find all equates
	SymbolRef* pos = data->innerTable + (1 << SYMBOL_HASH_FUNC_BITS_LOCAL);

	// look at every item to free it
	while (pos > data->innerTable) {
		pos--;

		// traverse the symbol table to print all local labels
		if (pos->data != NULL) {
			// check for no entries
			if (pos->entries != 0) {
				// load head pointer
				Symbol* entry = pos->data;
				int32_t entries = (int32_t)pos->entries; // use int32_t here instead of uint16_t : the while loop requires a check for less than 0

				while (--entries >= 0) {
					// write the symbol out
					uint32_t flen = writeEquSymbol(entry, buffer, length);

					if (flen > 0) {
						fwrite((char*)buffer, 1, flen, file);
					}

					entry++;
				}
			}
		}
	}
}

// function to write symbol file header
void writeEquFormat(FILE* file) {
	fwrite("; ------------------------------------------------------------------------------\n", 1, 81, file);
	fwrite(";                              SYMBOL EQUATE TABLE                              \n", 1, 81, file);
	fwrite("; ------------------------------------------------------------------------------\n", 1, 81, file);

	// initialize buffer
	*symbolBuffer = '\n';

	// traverse symbols to find all equates
	SymbolRef* pos = Symbol_GlobalTable + (1 << SYMBOL_HASH_FUNC_BITS);

	// look at every item to free it
	while (pos > Symbol_GlobalTable) {
		pos--;

		// traverse the symbol table to print all local labels
		if (pos->data != NULL) {
			// check for no entries
			if (pos->entries != 0) {
				// load head pointer
				Symbol* entry = pos->data;
				int32_t entries = (int32_t)pos->entries; // use int32_t here instead of uint16_t : the while loop requires a check for less than 0

				while (--entries >= 0) {
					// write the symbol out
					uint32_t flen = writeEquSymbol(entry, symbolBuffer, 1);

					if (flen > 0) {
						fwrite((char*)symbolBuffer, 1, flen, file);
					}

					// check for local symbols
					if (entry->type == Symbol_Type_Integer_Equate || entry->type == Symbol_Type_String_Equate) {
						writeEquLocalSymbols(file, entry, symbolBuffer, 1);
					}

					entry++;
				}
			}
		}
	}
}

// function to generate the symbol file
void generateSymbolFile() {
	if (!symbolPath) {
		return;
	}

	FILE* file = fopen(symbolPath, "wb");

	// check if failed to make the file
	if (!file) {
		Error_ErrorProgram(ERRFMT_FILE_NOT_FOUND " ", symbolPath);
	}

	fseek(file, 0, SEEK_SET);

	// write symbol file in the appropriate format
	if (symbolFormat == SYM_FMT_EQU) {
		writeEquFormat(file);
	}

	// close file handle
	fclose(file);
}
