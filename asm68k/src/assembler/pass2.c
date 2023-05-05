#include <setjmp.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <assembler/68k/68000.h>
#include <assembler/assembler.h>
#include <assembler/error.h>
#include <assembler/hash.h>
#include <assembler/listings.h>
#include <assembler/object.h>
#include <assembler/parse.h>
#include <assembler/pass2.h>

#include <asmlink/debug_tracer.h>
#include <asmlink/symbol_ext.h>
#include <asmlink/messages/global.h>

#include <lib/compat.h>
#include <lib/debug.h>
#include <lib/error_lib.h>
#include <lib/expressions.h>
#include <lib/files.h>
#include <lib/lengthstring.h>
#include <lib/messages/global.h>

c_inline void updateMemory();

#pragma region Pass 2 Replace Bytes
/**
 * Pass 2 replace bytes in file
 */

// the table of pass2 replacement values
ObjectReplacement* replaceTable = NULL;

// number of allocated and used slots
uint32_t slotAlloc = 0;
uint32_t slotUse = 0;

// tiny buffer for fwrite
uint8_t buffer[16];

// function to add a new item to pass2
void addPass2Data(uint16_t patch, uint64_t address, uint64_t filePos, EvaluateToken* start, EvaluateToken* end, uint16_t value) {
	// check if we need to reserve more space for table
	if (slotUse >= slotAlloc) {
		// check how much more space to allocate
		if (slotAlloc == 0) {
			slotAlloc = 0x100;

		} else {
			slotAlloc += slotAlloc / 2;
		}

		// allocate space
		replaceTable = realloc(replaceTable, slotAlloc * sizeof(ObjectReplacement));

		// check if allocation failed
		if (replaceTable == NULL) {
			Error_ErrorProgram(ERRTXT_MALLOC_FAIL " ");
		}

		updateMemory();
	}

	// add to table
	replaceTable[slotUse].patch = patch;
	replaceTable[slotUse].address = address;
	replaceTable[slotUse].filePos = filePos;
	replaceTable[slotUse].file = objectFile;
	replaceTable[slotUse].start = start;
	replaceTable[slotUse].end = end;
	replaceTable[slotUse].value = value;
	replaceTable[slotUse].filename = _filename;
	replaceTable[slotUse].lineNumber = *_lineNumber;

	// copy the line into temporary memory
	replaceTable[slotUse].line = LengthString_FromBuffer(buffers.line, buffers.lineLength);

	if (replaceTable[slotUse].line == NULL) {
		Error_ErrorProgram(ERRTXT_MALLOC_FAIL " ");
	}

	slotUse++;
}

/**
 * Pass 2 process 68k-specific patches
 */

// pass 2 patch nonexisting
void p2f_error(ObjectReplacement* entry) {
	Error_Fatal(2, ERRFMT_PASS2BUG_INVALID, entry->patch);
}

// pass 2 patch in addq/subq instruction byte
void p2f_AddqSubq(ObjectReplacement* entry) {
	uint16_t value = (uint16_t)entry->value;

	// convert the argument to number
	uint64_t eval;
	Expression_Result_Type result = Expression_EvaluateAsNumber(&macroTable, &eval, 1, &macroTable.result);

	if (result == Expression_Result_Type_Success) {
		// fetch the addqsubq value
		result = checkAddqSubqValue(&value, (int64_t)eval);
	}

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write, flipping bit 8 of the instruction if value is negative (changes ADDQ to SUBQ and vice-versa)
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wByte(value, entry->file, buffer);
}

// pass 2 patch in shift instruction byte
void p2f_68kShift(ObjectReplacement* entry) {
	uint16_t value = (uint16_t)entry->value;

	// convert the argument to number
	uint64_t eval;
	Expression_Result_Type result = Expression_EvaluateAsNumber(&macroTable, &eval, 1, &macroTable.result);

	if (result == Expression_Result_Type_Success) {
		// fetch the addqsubq value
		result = getShiftCount(&value, (int64_t)eval);
	}

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write the instruction upper byte
	Tracer_WritePass2ReplaceBytes(entry, value >> 8);
	p2wByte(value >> 8, entry->file, buffer);
}

// pass 2 patch in moveq value
void p2f_Moveq(ObjectReplacement* entry) {
	// convert the argument to number
	uint64_t eval;
	Expression_Result_Type result = Expression_EvaluateAsNumber(&macroTable, &eval, 1, &macroTable.result);

	if (result == Expression_Result_Type_Success) {
		// fcheck moveq value
		result = checkMoveqValue((uint8_t)entry->value, eval, macroTable.expStart, macroTable.expEnd);
	}

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, eval);
	p2wByte(eval, entry->file, buffer);
}

// pass 2 patch in signed BYTE value PC relative
void p2f_Int8_PC(ObjectReplacement* entry) {
	int8_t value;
	Expression_Result_Type result = Expression_EvaluateAsInt8(&macroTable, &value, -(entry->address - 1));

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wByte(value, entry->file, buffer);
}

// pass 2 patch in signed WORD value PC relative
void p2f_Int16_PC(ObjectReplacement* entry) {
	int16_t value;
	Expression_Result_Type result = Expression_EvaluateAsInt16(&macroTable, &value, -entry->address);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wWord(ENDIANNESS == 0 ? value : wordChangeEndian(value), entry->file, buffer);
}

// pass 2 patch in unsigned WORD value
void p2f_Int16_Addr(ObjectReplacement* entry) {
	uint16_t value;
	Expression_Result_Type result = evaluateAsAddrMC68k(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wWord(ENDIANNESS == 0 ? value : wordChangeEndian(value), entry->file, buffer);
}

// pass 2 patch in signed BYTE value with 0 check
void p2f_BCC_Short(ObjectReplacement* entry) {
	int8_t value;
	Expression_Result_Type result = Expression_EvaluateAsInt8(&macroTable, &value, -(entry->address + 1));

	if (result == Expression_Result_Type_Success && value == 0) {
		// can not convert, fail
		result = Expression_Result_Type_68k_Invalid_0;
	}

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wByte(value, entry->file, buffer);
}

/**
 * Pass 2 process generic patches
 */

// pass 2 patch in unsigned NIBBLE LOW value
void p2f_Uint4L(ObjectReplacement* entry) {
	uint8_t value;
	Expression_Result_Type result = Expression_EvaluateAsUint4(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value | entry->value);
	p2wByte(value | entry->value, entry->file, buffer);
}

// pass 2 patch in signed NIBBLE LOW value
void p2f_Int4L(ObjectReplacement* entry) {
	int8_t value;
	Expression_Result_Type result = Expression_EvaluateAsInt4(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, (uint8_t)value | entry->value);
	p2wByte((uint8_t)value | entry->value, entry->file, buffer);
}

// pass 2 patch in BYTE value
void p2f_Byte(ObjectReplacement* entry) {
	uint8_t value;
	Expression_Result_Type result = Expression_EvaluateAsByte(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wByte(value, entry->file, buffer);
}

// pass 2 patch in unsigned BYTE value
void p2f_Uint8(ObjectReplacement* entry) {
	uint8_t value;
	Expression_Result_Type result = Expression_EvaluateAsUint8(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wByte(value, entry->file, buffer);
}

// pass 2 patch in signed BYTE value
void p2f_Int8(ObjectReplacement* entry) {
	int8_t value;
	Expression_Result_Type result = Expression_EvaluateAsInt8(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wByte(value, entry->file, buffer);
}

// pass 2 patch in WORD value
void p2f_Word(ObjectReplacement* entry) {
	uint16_t value;
	Expression_Result_Type result = Expression_EvaluateAsWord(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wWord(value, entry->file, buffer);
}

// pass 2 patch in WORD value
void p2f_Word_Chg(ObjectReplacement* entry) {
	uint16_t value;
	Expression_Result_Type result = Expression_EvaluateAsWord(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wWord(wordChangeEndian(value), entry->file, buffer);
}

// pass 2 patch in unsigned WORD value
void p2f_Uint16(ObjectReplacement* entry) {
	uint16_t value;
	Expression_Result_Type result = Expression_EvaluateAsUint16(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wWord(value, entry->file, buffer);
}

// pass 2 patch in unsigned WORD value
void p2f_Uint16_Chg(ObjectReplacement* entry) {
	uint16_t value;
	Expression_Result_Type result = Expression_EvaluateAsUint16(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wWord(wordChangeEndian(value), entry->file, buffer);
}

// pass 2 patch in signed WORD value
void p2f_Int16(ObjectReplacement* entry) {
	int16_t value;
	Expression_Result_Type result = Expression_EvaluateAsInt16(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wWord(value, entry->file, buffer);
}

// pass 2 patch in signed WORD value
void p2f_Int16_Chg(ObjectReplacement* entry) {
	int16_t value;
	Expression_Result_Type result = Expression_EvaluateAsInt16(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wWord(wordChangeEndian(value), entry->file, buffer);
}

// pass 2 patch in LONG value
void p2f_Long(ObjectReplacement* entry) {
	uint32_t value;
	int result = Expression_EvaluateAsLong(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wLong(value, entry->file, buffer);
}

// pass 2 patch in LONG value
void p2f_Long_Chg(ObjectReplacement* entry) {
	uint32_t value;
	Expression_Result_Type result = Expression_EvaluateAsLong(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wLong(longChangeEndian(value), entry->file, buffer);
}

// pass 2 patch in unsigned LONG value
void p2f_Uint32(ObjectReplacement* entry) {
	uint32_t value;
	Expression_Result_Type result = Expression_EvaluateAsUint32(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wLong(value, entry->file, buffer);
}

// pass 2 patch in unsigned LONG value
void p2f_Uint32_Chg(ObjectReplacement* entry) {
	uint32_t value;
	Expression_Result_Type result = Expression_EvaluateAsUint32(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wLong(longChangeEndian(value), entry->file, buffer);
}

// pass 2 patch in signed LONG value
void p2f_Int32(ObjectReplacement* entry) {
	int32_t value;
	Expression_Result_Type result = Expression_EvaluateAsInt32(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wLong(value, entry->file, buffer);
}

// pass 2 patch in signed LONG value
void p2f_Int32_Chg(ObjectReplacement* entry) {
	int32_t value;
	Expression_Result_Type result = Expression_EvaluateAsInt32(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wLong(longChangeEndian(value), entry->file, buffer);
}

// pass 2 patch in QUAD value
void p2f_Quad(ObjectReplacement* entry) {
	uint64_t value;
	Expression_Result_Type result = Expression_EvaluateAsQuad(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wQuad(value, entry->file, buffer);
}

// pass 2 patch in QUAD value
void p2f_Quad_Chg(ObjectReplacement* entry) {
	uint64_t value;
	Expression_Result_Type result = Expression_EvaluateAsQuad(&macroTable, &value, 0);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		Error_EvalPass2(&macroTable, result);
	}

	// write it
	Tracer_WritePass2ReplaceBytes(entry, value);
	p2wQuad(quadChangeEndian(value), entry->file, buffer);
}

// function table for pass 2
void (*pass2Func[])(ObjectReplacement* entry) = {
		p2f_Uint4L, // Pass2_Patch_Uint4_Low
		p2f_error,	// Pass2_Patch_Uint4_High
		p2f_Int4L,	// Pass2_Patch_Int4_Low
		p2f_error,	// Pass2_Patch_Int4_High
		p2f_error,	// Pass2_Patch_4Bit_Low
		p2f_error,	// Pass2_Patch_4Bit_High

		p2f_Uint8,	 // Pass2_Patch_Uint8
		p2f_Int8,		 // Pass2_Patch_Int8
		p2f_Byte,		 // Pass2_Patch_Byte

		p2f_Uint16,		// Pass2_Patch_Uint16
		p2f_Int16,		// Pass2_Patch_Int16
		p2f_Word,			// Pass2_Patch_Word
		p2f_Uint16_Chg, // Pass2_Patch_Swap_Uint16
		p2f_Int16_Chg,	// Pass2_Patch_Swap_Int16
		p2f_Word_Chg,		// Pass2_Patch_Swap_Word

		p2f_Uint32,		 // Pass2_Patch_Uint32
		p2f_Int32,		 // Pass2_Patch_Int32
		p2f_Long,			 // Pass2_Patch_Long
		p2f_Uint32_Chg, // Pass2_Patch_Swap_Uint32
		p2f_Int32_Chg,	// Pass2_Patch_Swap_Int32
		p2f_Long_Chg,		// Pass2_Patch_Swap_Long

		p2f_Quad,			// Pass2_Patch_Quad
		p2f_Quad_Chg, // Pass2_Patch_Swap_Quad

		p2f_Int8_PC, // Pass2_Patch_68k_Int8PC
		p2f_Int16_PC, // Pass2_Patch_68k_Int16PC
		p2f_Int16_Addr, // Pass2_Patch_68k_AddrWord
		p2f_BCC_Short, // Pass2_Patch_68k_BCC_Short
		p2f_AddqSubq,		// Pass2_Patch_68k_ADDQ_SUBQ
		p2f_Moveq,		// Pass2_Patch_68k_MOVEQ
		p2f_68kShift, // Pass2_Patch_68k_Shift_Count
};

/**
 * Pass 2 handle patch processing
 */

// pass2 handle replacements
void Pass2ReplaceBytes() {
	// load every replacement
	for (uint32_t i = 0; i < slotUse; i++) {
		_filename = replaceTable[i].filename;
		_lineNumber = &replaceTable[i].lineNumber;

		// copy the stored line back into the buffer and free memory
		memcpy(buffers.line, replaceTable[i].line->string, 1 + (buffers.lineLength = replaceTable[i].line->length));
		macroTable.lineStart = buffers.line;
		free(replaceTable[i].line);

		// seek to correct position
		fseek(replaceTable[i].file, replaceTable[i].filePos, SEEK_SET);

		// try to evaluate expression
		Expression_Result_Type result = Expression_Evaluate(&macroTable, replaceTable[i].start, replaceTable[i].end);

		if (result != Expression_Result_Type_Success) {
			// can not evaluate
			Error_EvalPass2(&macroTable, result);
		}

		// handle specific function
		pass2Func[replaceTable[i].patch](&replaceTable[i]);

		// free some memory
		free(replaceTable[i].start);
	}

	// politely free memory
	if (replaceTable != NULL) {
		free(replaceTable);
	}
}

#pragma endregion
#pragma region Resolve Symbols
/**
 * Pass 2 resolve symbols
 */

// pass2 replacement struct
typedef struct {
	uint64_t address;
	uint16_t patch;
	uint8_t resolved;
	uint32_t lineNumber;
	LengthString* filename;

	// token table
	EvaluateToken* start;
	EvaluateToken* end;
	LengthString* line;

	// symbol to edit
	uint64_t hash;
	uint8_t mode;
} SymbolUpdate;

// the table of pass2 replacement values
SymbolUpdate* symbolItems = NULL;

// number of allocated and used slots
uint32_t slot2Alloc = 0;
uint32_t slot2Use = 0;

// function to add a new symbol to pass2
void addPass2Symbol(uint16_t patch, uint64_t address, EvaluateToken* start, EvaluateToken* end, uint32_t hglobal, uint32_t hlocal, uint8_t mode) {
	// check if we need to reserve more space for table
	if (slot2Use >= slot2Alloc) {
		// check how much more space to allocate
		if (slot2Alloc == 0) {
			slot2Alloc = 0x80;

		} else {
			slot2Alloc += slot2Alloc / 2;
		}

		// allocate space
		symbolItems = realloc(symbolItems, slot2Alloc * sizeof(SymbolUpdate));

		// check if allocation failed
		if (symbolItems == NULL) {
			Error_ErrorProgram(ERRTXT_MALLOC_FAIL " ");
		}

		updateMemory();
	}

	// add to table
	symbolItems[slot2Use].resolved = 0;
	symbolItems[slot2Use].patch = patch;
	symbolItems[slot2Use].address = address;
	symbolItems[slot2Use].start = start;
	symbolItems[slot2Use].end = end;
	symbolItems[slot2Use].hash = hglobal | ((uint64_t)hlocal << 32);
	symbolItems[slot2Use].mode = mode;
	symbolItems[slot2Use].filename = _filename;
	symbolItems[slot2Use].lineNumber = *_lineNumber;

	// copy the line into temporary memory
	symbolItems[slot2Use].line = LengthString_FromBuffer(buffers.line, buffers.lineLength);

	if (symbolItems[slot2Use].line == NULL) {
		Error_ErrorProgram(ERRTXT_MALLOC_FAIL " ");
	}

	slot2Use++;
}

// pass2 handle symbolUpdates
int Pass2ResolveSymbols(uint8_t mustResolve) {
	int changes = 0;
	int numLeft = 0;

	// run through every symbol to find ones needing to be fixed
	for (uint32_t i = 0; i < slot2Use; i++) {
		if (symbolItems[i].resolved) {
			continue;
		}

		_filename = symbolItems[i].filename;
		_lineNumber = &symbolItems[i].lineNumber;

		// copy the stored line back into the buffer
		memcpy(buffers.line, symbolItems[i].line->string, 1 + (buffers.lineLength = symbolItems[i].line->length));
		macroTable.lineStart = buffers.line;

		// clone the table for safe operation
		EvaluateToken* _start = symbolItems[i].start;
		EvaluateToken* _end = symbolItems[i].end;
		Expression_CloneTokenData(&_start, &_end);

		// try to resolve the symbol
		Expression_Result_Type result = Expression_Evaluate(&macroTable, _start, _end);
		free(_start);

		if (mustResolve ? (result != Expression_Result_Type_Success) : (result > Expression_Result_Type_Success)) {
			// print error if failed to resolve
			Error_EvalPass2(&macroTable, result);
			continue;
		}

		if (result != Expression_Result_Type_Success) {
			// handle failure
			numLeft++;
			Symbol* sym;
			result = Expression_FetchSymbolByHash(symbolItems[i].hash, symbolItems[i].mode, &sym);
			continue;
		}

		// fetch target symbol
		Symbol* sym;
		result = Expression_FetchSymbolByHash(symbolItems[i].hash, symbolItems[i].mode, &sym);

		// check for symbols
		if (macroTable.result.type == Expression_Token_Type_Symbol) {
			Symbol* symbol;
			result = Expression_FetchSymbolByToken(&macroTable.result, &symbol);

			// check if symbol can't be evaluated
			if (result != Expression_Result_Type_Success || (symbol->flags & Symbol_Flag_Initialized) == 0) {
				if (mustResolve == 1) {
					Error_EvalPass2(&macroTable, Expression_Result_Type_Symbol_Undefined);

				} else {
					numLeft++;
				}

				continue;
			}

			// evaluate symbol
			switch (symbol->type) {
				case Symbol_Type_Integer_Equate: // symbol is number
					sym->type = Symbol_Type_Integer_Equate;
					sym->flags |= Symbol_Flag_Initialized;
					sym->extraParam = symbol->extraParam;
					Tracer_WritePass2ValueEqu(sym->name, sym->extraParam);
					symbolItems[i].resolved = 1;
					changes++;
					continue;

				case Symbol_Type_String_Equate: // symbol is string
					sym->type = Symbol_Type_String_Equate;
					sym->flags |= Symbol_Flag_Initialized;
					sym->string = symbol->string;
					Tracer_WritePass2StringEqu(sym->name, sym->string->string);
					symbolItems[i].resolved = 1;
					changes++;
					continue;
			}

			goto error;
		}

		// handle success
		changes++;
		symbolItems[i].resolved = 1;

		// check type
		switch (macroTable.result.type) {
			case Expression_Token_Type_Number: // number - save as such
				sym->type = Symbol_Type_Integer_Equate;
				sym->flags |= Symbol_Flag_Initialized;
				sym->extraParam = macroTable.result.value;
				Tracer_WritePass2ValueEqu(sym->name, macroTable.result.value);
				continue;

			case Expression_Token_Type_String: // string - save as such
				sym->type = Symbol_Type_String_Equate;
				sym->flags |= Symbol_Flag_Initialized;
				sym->string = macroTable.result.string;
				Tracer_WritePass2StringEqu(sym->name, macroTable.result.string->string);
				continue;
		}

	error: // failed to get result
		Error_ErrorPass2("Expected a number or a string result, but expression evaluated to neither.");
	}

	// return 0 if no more things are even left
	if (numLeft == 0) {
		return 0;
	}

	return changes;
}

// pass2 handle symbolUpdates
void Pass2UpdateSymbols() {
	// resolve symbols until no more changes were made
	while (Pass2ResolveSymbols(0) > 0) ;

	// error out on any unresolved symbol
	Pass2ResolveSymbols(1);

	// politely free memory
	if (symbolItems != NULL) {
		free(symbolItems);
	}
}

#pragma endregion
#pragma region Other

// handle pass2 functions
void doPass2() {
	Pass2UpdateSymbols();
	Pass2ReplaceBytes();
}

// helper function to update memory usage on pass2
c_inline void updateMemory() {
#if defined(DEBUG)
	memPass2 = (slot2Alloc * sizeof(SymbolUpdate)) + (slotAlloc * sizeof(ObjectReplacement));
#endif
}

#pragma endregion
