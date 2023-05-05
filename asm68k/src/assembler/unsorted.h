#if !defined(INCLUDE_LIB_UNSORTED_H)
#define INCLUDE_LIB_UNSORTED_H

#include <stdint.h>

#include <lib/compat.h>
#include <lib/hash_lib.h>

// helper function to skip whitespace
#define skipWhitespaceAndEOL(buf, eol) \
	while (1) {                        \
		uint8_t d = *(buf);            \
		if (d == 0) {                  \
			eol;                       \
		}                              \
		if (d != ' ') {                \
			break;                     \
		}                              \
		(buf)++;                       \
	}

// helper function to accumulate a label hash
#define getLabelHash(buffer, hash, read, local)                                    \
	if ((charFlagLUT[read] & CF_LABEL_FIRST_CHAR) == 0) {                          \
		Error_ErrorUnderline(buffers.line, buffer, buffer, ERRFMT_UNEXPECTED_IN_INPUT, read); \
	}                                                                              \
	if (caseLUT[read] == options.localLabelSymbol) {                               \
		(local) = 1;                                                               \
		(read) = LOCAL_HASH_CHAR;                                                  \
	}                                                                              \
	while (1) {                                                                    \
		(buffer)++;                                                                \
		(hash) = HASH_GETNEXT(hash, caseLUT[read]);                                    \
		if ((charFlagLUT[(read) = *(buffer)] & CF_LABEL_CHAR) == 0) {              \
			break;                                                                 \
		}                                                                          \
	}

// helper function to get symbol

#define getSymbolOnly(symbol, start, end, local, hash)                           \
	if (local) {                                                                 \
		(symbol) = Symbol_FetchLocal(hash, SymbolExt_CurrentScope);                         \
		Tracer_WriteSymbolAction(2, 1, symbol);                                         \
	} else {                                                                     \
		(symbol) = Symbol_Fetch(hash, Symbol_GlobalTable);                               \
		Tracer_WriteSymbolAction(2, 0, symbol);                                         \
	}                                                                            \
	if (!(symbol)) {                                                             \
		*(end) = 0;                                                              \
		Error_ErrorUnderline(buffers.line, start, end, ERRFMT_SYMBOL_UNDEFINED, start); \
	}

// helper function to get symbol and check its type
#define getSymbolAndCheckType(symbol, start, end, local, hash, _type, err) \
	getSymbolOnly(symbol, start, end, local, hash);                        \
	if ((symbol)->type != (_type)) {                                       \
		*(end) = 0;                                                        \
		Error_ErrorUnderline(buffers.line, start, end, err, start);          \
	}

// check if the next character is NUL, and if not, throw an error
#define expectNUL(start, buffer, error)                         \
	if (*(buffer) != 0) {                                       \
		Error_ErrorUnderline(buffers.line, start, buffer, error); \
	}

#endif // INCLUDE_LIB_UNSORTED_H
