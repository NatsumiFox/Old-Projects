#include <inttypes.h>
#include <setjmp.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <assembler/unsorted.h>
#include <assembler/assembler.h>
#include <assembler/error.h>
#include <assembler/hash.h>
#include <assembler/listings.h>
#include <assembler/object.h>
#include <assembler/parse.h>
#include <assembler/pass2.h>
#include <assembler/messages/directives.h>

#include <asmlink/debug_tracer.h>
#include <asmlink/symbol_ext.h>
#include <asmlink/messages/global.h>

#include <lib/compat.h>
#include <lib/debug.h>
#include <lib/expressions.h>
#include <lib/files.h>
#include <lib/messages/global.h>
#include <lib/messages/expressions.h>

#pragma region DC
/*
	DC, DCB - Define constant data
	===========================
	dc.[bwlqus] * - define byte/word/long/quad data and add optional signed/unsigned checks
	dcv.[bwlqus] <count>,* - define byte/word/long/quad data <count> times and add optional signed/unsigned checks
*/

#define Dc_Check_ObjBuffer(bytes)                                  \
	if (objectBufferPtr + (bytes) >= objectBuffer + OBJ_BUFFER_SIZE) \
		flushObjectBuffer();

Expression_Result_Type Dc_PutByte(TokenTable* table, int64_t repeats, uint8_t noeval) {
	LengthString* str;
	Expression_Result_Type result = Expression_Result_Type_Success;
	uint8_t value = 0;

	// check if alraedy failed to evaluate
	if (noeval) {
		result = Expression_Result_Type_No_Eval;
		goto writebytes;
	}

	// fetch symbol and check for uninitialized symbols
	if (macroTable.result.type == Expression_Token_Type_Symbol) {
		Symbol* symbol;
		result = Expression_FetchSymbolByToken(&macroTable.result, &symbol);

		if (result != Expression_Result_Type_Success) {
			return result;
		}

		if ((symbol->flags & Symbol_Flag_Initialized) == 0) {
			// reserve bytes because maybe this will lead to some result?
			result = Expression_Result_Type_Symbol_Undefined;
			goto writebytes;
		}

		// resolve symbol type
		switch (symbol->type) {
			case Symbol_Type_Integer_Equate: // symbol is number
				// not sure this is a good idea
				macroTable.result.type = Expression_Token_Type_Number;
				macroTable.result.value = symbol->extraParam;
				break;

			case Symbol_Type_String_Equate: // symbol is string
				str = symbol->string;
				goto writestr;

			default:
				return Expression_Result_Type_Symbol_Invalid_In_Exp;
		}
	}

	// check type
	switch (macroTable.result.type) {
		case Expression_Token_Type_Number:; // number - save as such
			result = Expression_EvaluateAsByte(table, &value, 0);
			goto writebytes;

		case Expression_Token_Type_String:; // string - save as such
			result = Expression_EvaluateAsString(&str, &table->result);
			goto writestr;
	}

	return Expression_Result_Type_Symbol_Invalid_In_Exp;

writestr:
	if (result != Expression_Result_Type_Success) {
		return result;
	}

	// write the actual data
	for (; repeats > 0; --repeats) {
		objWriteArray(str->length, str->string);
	}

	return Expression_Result_Type_Success;

writebytes:
	// write the actual data
	for (; repeats > 0; --repeats) {
		Dc_Check_ObjBuffer(1);
		objWriteByte(value);
	}

	return result;
}

Expression_Result_Type Dc_PutUint8(TokenTable* table, int64_t repeats, uint8_t noeval) {
	// convert the number
	uint8_t value = 0;
	Expression_Result_Type result = noeval ? Expression_Result_Type_No_Eval : Expression_EvaluateAsUint8(table, &value, 0);

	// write the actual data
	for (; repeats > 0; --repeats) {
		Dc_Check_ObjBuffer(1);
		objWriteByte(value);
	}

	return result;
}

Expression_Result_Type Dc_PutInt8(TokenTable* table, int64_t repeats, uint8_t noeval) {
	// convert the number
	int8_t value = 0;
	Expression_Result_Type result = noeval ? Expression_Result_Type_No_Eval : Expression_EvaluateAsInt8(table, &value, 0);

	// write the actual data
	for (; repeats > 0; --repeats) {
		Dc_Check_ObjBuffer(1);
		objWriteByte(value);
	}

	return result;
}

Expression_Result_Type Dc_PutWord(TokenTable* table, int64_t repeats, uint8_t noeval) {
	// convert the number
	uint16_t value = 0;
	Expression_Result_Type result = noeval ? Expression_Result_Type_No_Eval : Expression_EvaluateAsWord(table, &value, 0);

	// check if endianness needs to be changed
	if (options.endianness != ENDIANNESS) {
		value = wordChangeEndian(value);
	}

	// write the actual data
	for (; repeats > 0; --repeats) {
		Dc_Check_ObjBuffer(2);
		objWriteWordAll(value);
	}

	return result;
}

Expression_Result_Type Dc_PutUint16(TokenTable* table, int64_t repeats, uint8_t noeval) {
	// convert the number
	uint16_t value = 0;
	Expression_Result_Type result = noeval ? Expression_Result_Type_No_Eval : Expression_EvaluateAsUint16(table, &value, 0);

	// check if endianness needs to be changed
	if (options.endianness != ENDIANNESS) {
		value = wordChangeEndian(value);
	}

	// write the actual data
	for (; repeats > 0; --repeats) {
		Dc_Check_ObjBuffer(2);
		objWriteWordAll(value);
	}

	return result;
}

Expression_Result_Type Dc_PutInt16(TokenTable* table, int64_t repeats, uint8_t noeval) {
	// convert the number
	int16_t value = 0;
	Expression_Result_Type result = noeval ? Expression_Result_Type_No_Eval : Expression_EvaluateAsInt16(table, &value, 0);

	// check if endianness needs to be changed
	if (options.endianness != ENDIANNESS) {
		value = wordChangeEndian(value);
	}

	// write the actual data
	for (; repeats > 0; --repeats) {
		Dc_Check_ObjBuffer(2);
		objWriteWordAll(value);
	}

	return result;
}

Expression_Result_Type Dc_PutLong(TokenTable* table, int64_t repeats, uint8_t noeval) {
	// convert the number
	uint32_t value = 0;
	Expression_Result_Type result = noeval ? Expression_Result_Type_No_Eval : Expression_EvaluateAsLong(table, &value, 0);

	// check if endianness needs to be changed
	if (options.endianness != ENDIANNESS) {
		value = longChangeEndian(value);
	}

	// write the actual data
	for (; repeats > 0; --repeats) {
		Dc_Check_ObjBuffer(4);
		objWriteLongAll(value);
	}

	return result;
}

Expression_Result_Type Dc_PutUint32(TokenTable* table, int64_t repeats, uint8_t noeval) {
	// convert the number
	uint32_t value = 0;
	Expression_Result_Type result = noeval ? Expression_Result_Type_No_Eval : Expression_EvaluateAsUint32(table, &value, 0);

	// check if endianness needs to be changed
	if (options.endianness != ENDIANNESS) {
		value = longChangeEndian(value);
	}

	// write the actual data
	for (; repeats > 0; --repeats) {
		Dc_Check_ObjBuffer(4);
		objWriteLongAll(value);
	}

	return result;
}

Expression_Result_Type Dc_PutInt32(TokenTable* table, int64_t repeats, uint8_t noeval) {
	// convert the number
	int32_t value = 0;
	Expression_Result_Type result = noeval ? Expression_Result_Type_No_Eval : Expression_EvaluateAsInt32(table, &value, 0);

	// check if endianness needs to be changed
	if (options.endianness != ENDIANNESS) {
		value = longChangeEndian(value);
	}

	// write the actual data
	for (; repeats > 0; --repeats) {
		Dc_Check_ObjBuffer(4);
		objWriteLongAll(value);
	}

	return result;
}

Expression_Result_Type Dc_PutQuad(TokenTable* table, int64_t repeats, uint8_t noeval) {
	// convert the number
	uint64_t value = 0;
	Expression_Result_Type result = noeval ? Expression_Result_Type_No_Eval : Expression_EvaluateAsQuad(table, &value, 0);

	// check if endianness needs to be changed
	if (options.endianness != ENDIANNESS) {
		value = quadChangeEndian(value);
	}

	// write the actual data
	for (; repeats > 0; --repeats) {
		Dc_Check_ObjBuffer(8);
		objWriteQuadAll(value);
	}

	return result;
}

void Directive_Dc(uint8_t* buffer, uint32_t param) {
	Expression_Result_Type result = Expression_Result_Type_Success;
	uint8_t size = 0x0F;
	uint8_t read = *buffer;
	uint8_t* _buf = buffer;
	int64_t repeats = 1;
	uint8_t argno = 0;

	// fetch instruction size param
	if (read == '.') {
		buffer++;
		_buf++;

		while (1) {
			// find all size characters
			switch (read = *buffer) {
				case 'S':
				case 's':
					if ((size & 0xC0) != 0) {
						goto sizeSU;
					}
					size |= 0x40;
					break;

				case 'U':
				case 'u':
					if ((size & 0xC0) != 0) {
						goto sizeSU;
					}
					size |= 0x80;
					break;

				case 'B':
				case 'b':
					if ((size & 0xF) != 0xF) {
						goto sizeBWL;
					}
					size = size & 0xF0;
					break;

				case 'W':
				case 'w':
					if ((size & 0xF) != 0xF) {
						goto sizeBWL;
					}
					size = size & 0xF1;
					break;

				case 'L':
				case 'l':
					if ((size & 0xF) != 0xF) {
						goto sizeBWL;
					}
					size = size & 0xF2;
					break;

				case 'Q':
				case 'q':
					if ((size & 0xF) != 0xF) {
						goto sizeBWL;
					}
					size = size & 0xF3;
					break;

				case ' ':
					goto sizeget;
				case 0:
					goto eol;
				default:
					goto unexpected;
			}

			buffer++;
		}
	} else if (read != ' ') {
		// must be either . or whitespace
		goto unexpected;
	}

sizeget:
	// size special case: word is default
	if ((size & 0xF) == 0xF) {
		size = size & 0xF1;
	}

	// parse line into macroTable
	uint8_t* end;
	result = Expression_TokenizeRemainingLine(&macroTable, buffer, &end);

	if (result > Expression_Result_Type_Success) {
		goto evalerr;
	}

	if (param == 1) {
		// fetch the next argument
		EvaluateToken* argend = Expression_FindArgumentEnd(&macroTable);

		if (argend == NULL) {
			goto eol;
		}

		// evaluate the tokens
		result = Expression_Evaluate(&macroTable, macroTable.start, argend - 1);

		if (result != Expression_Result_Type_Success) {
			goto evalerr;
		}

		// convert the number
		result = Expression_EvaluateAsQuad(&macroTable, (uint64_t*)(&repeats), 0);

		if (result != Expression_Result_Type_Success) {
			goto evalerr;
		}

		// check repeat count
		if (repeats == 0) {
			objSetAddress();
			setListingsBytes();
			return;

		} else if (repeats < 0) {
			Error_ErrorUnderline(buffers.line, macroTable.start->start, (argend - 1)->end, ERRFMT_DIR_DCB_REPT, repeats);
		}

		// apply to next argument
		macroTable.start = argend + 1;
	}

	// load function according to type
	Expression_Result_Type (*putFunc)(TokenTable*, int64_t, uint8_t);
	uint16_t patch;

	switch (size) {
		default:
		case 0x00:
			patch = Pass2_Patch_Byte;
			putFunc = &Dc_PutByte;
			break;
		case 0x40:
			patch = Pass2_Patch_Int8;
			putFunc = &Dc_PutInt8;
			break;
		case 0x80:
			patch = Pass2_Patch_Uint8;
			putFunc = &Dc_PutUint8;
			break;
		case 0x01:
			patch = options.endianness ? Pass2_Patch_LE_Word : Pass2_Patch_BE_Word;
			putFunc = &Dc_PutWord;
			break;
		case 0x41:
			patch = options.endianness ? Pass2_Patch_LE_Int16 : Pass2_Patch_BE_Int16;
			putFunc = &Dc_PutInt16;
			break;
		case 0x81:
			patch = options.endianness ? Pass2_Patch_LE_Uint16 : Pass2_Patch_BE_Uint16;
			putFunc = &Dc_PutUint16;
			break;
		case 0x02:
			patch = options.endianness ? Pass2_Patch_LE_Long : Pass2_Patch_BE_Long;
			putFunc = &Dc_PutLong;
			break;
		case 0x42:
			patch = options.endianness ? Pass2_Patch_LE_Int32 : Pass2_Patch_BE_Int32;
			putFunc = &Dc_PutInt32;
			break;
		case 0x82:
			patch = options.endianness ? Pass2_Patch_LE_Uint32 : Pass2_Patch_BE_Uint32;
			putFunc = &Dc_PutUint32;
			break;
		case 0x03:
			patch = options.endianness ? Pass2_Patch_LE_Quad : Pass2_Patch_BE_Quad;
			putFunc = &Dc_PutQuad;
			break;
		case 0x43:
		case 0x83:
			goto sizeSUQ;
	}

	// skip whitespace
	skipWhitespaceAndEOL(buffer, goto eol);

	// check alignment and check default functions
	if ((size & 0xF) != 0) {
		objWordAlign();
	}

	objSetAddress();
	createLabelCheck();

	// parse each argument
	while (1) {
		// fetch the next argument
		EvaluateToken* argend = Expression_FindArgumentEnd(&macroTable);

		if (argend == NULL) {
			// check if this was the first argument
			if (argno == 0) {
				goto eol;
			}

			break;
		}

		// clone token table just in case
		EvaluateToken* _start = macroTable.start;
		EvaluateToken* _end = argend - 1;

		// evaluate the tokens
		result = Expression_Evaluate(&macroTable, macroTable.start, argend - 1);

		if (result > Expression_Result_Type_Success) {
			goto evalerr;
		}

		// store object address before running function just in case
		uint64_t _addr = objectAddress;
		uint64_t _filepos = getObjectFilePos();

		// put this into the ROM
		uint8_t noeval = result < Expression_Result_Type_Success;
		int rex = putFunc(&macroTable, repeats, noeval);

		if (rex > Expression_Result_Type_Success) {
			result = rex;
			macroTable.expStart = macroTable.evalStart = macroTable.start->start;
			macroTable.expEnd = macroTable.evalEnd = (argend - 1)->end;
			goto evalerr;
		}

		// check pass2
		if (rex < Expression_Result_Type_Success || noeval) {
#ifdef DEBUG
			memTokenTable += Expression_CloneTokenTable(&_start, &_end);
#else
			Expression_CloneTokenTable(&_start, &_end);
#endif

			// calculate the number of bytes per entry
			uint64_t bytes = (objectAddress - _addr) / repeats;

			for (int64_t i = 0; i < repeats; i++) {
				// add this to pass 2 now
				addPass2Data(patch, _addr, _filepos, _start, _end, 0);
				_addr += bytes;
				_filepos += bytes;
			}
		}

		// go to next argument
		macroTable.start = argend + 1;
		argno++;
	}

	setListingsBytes();
	return;

evalerr:
	Error_Eval(&macroTable, result);
sizeBWL:
	Error_ErrorUnderline(buffers.line, _buf, buffer + 1, ERRTXT_DIR_DC_SIZE_BWL);
sizeSU:
	Error_ErrorUnderline(buffers.line, _buf, buffer + 1, ERRTXT_DIR_DC_SIZE_SU);
sizeSUQ:
	Error_ErrorUnderline(buffers.line, _buf, buffer + 1, ERRTXT_DIR_DC_SIZE_US_SQ);
eol:
	Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL);
unexpected:
	Error_ErrorUnderline(buffers.line, buffer, buffer, ERRFMT_UNEXPECTED_IN_INPUT, read);
}

#pragma endregion

/*
	EVEN - Align address to the next CPU-specific boundary
	===========================
*/

void Directive_Even(uint8_t* buffer, uint32_t param) {
	objSetAddress();
	createLabelCheck();

	if (objectAddress & 1) {
		objWriteByte(options.fillChar);
	}

	setListingsBytes();
}

#pragma region Incbin& Include

void Directive_Incbin(uint8_t* buffer, uint32_t param) {
	objSetAddress();
	createLabelCheck();

	// skip whitespace
	skipWhitespaceAndEOL(buffer, goto eol);

	// parse line into macroTable
	uint8_t* end;
	Expression_Result_Type result = Expression_TokenizeRemainingLine(&macroTable, buffer, &end);

	if (result != Expression_Result_Type_Success) {
		goto evalerr;
	}

	// evaluate the next argument
	LengthString* fileParam;
	EvaluateToken* argEnd;
	fetchArgumentAsStringPass1(macroTable, fileParam, argEnd, result, goto eol, goto evalerr);

	// fetch the file itself
	LengthString* filePath;
	FILE* file = findFile(fileParam->string, "rb", &filePath);
	Tracer_WriteFileMode(0, filePath->string, "incbin");

	if (file == NULL) {
		Error_ErrorUnderline(buffers.line, macroTable.result.start, macroTable.result.end, ERRFMT_FILE_NOT_FOUND, fileParam->string);
	}

	// fetch file length
	fseek(file, 0, SEEK_END);
	uint64_t fileLength = ftell(file);
	fseek(file, 0, SEEK_SET);

	// TODO: extra params

	Tracer_WriteIncbin(0, fileLength);

	// check if we can write the fragment of the file (eg area < OBJ_BUFFER_SIZE)
	uint64_t fragment = fileLength % OBJ_BUFFER_SIZE;
	fileLength -= fragment;

	if (fragment != 0 && (objectBufferPtr + fragment < objectBuffer + OBJ_BUFFER_SIZE)) {
		fread((char*)objectBufferPtr, 1, fragment, file);
		objectBufferPtr += fragment;
		objectAddress += fragment;

		// indicate write was performed
		fragment = 0;
	}

	// flush the buffer just to be safe
	flushObjectBuffer();

	while (fileLength > 0) {
		// write next full buffer and flush it
		fread((char*)objectBuffer, 1, OBJ_BUFFER_SIZE, file);
		objectBufferPtr += OBJ_BUFFER_SIZE;
		flushObjectBuffer();

		// update file address
		fileLength -= OBJ_BUFFER_SIZE;
		objectAddress += OBJ_BUFFER_SIZE;
	}

	// if fragment wasn't written, write it now
	if (fragment != 0) {
		fread((char*)objectBufferPtr, 1, fragment, file);
		objectBufferPtr += fragment;
		objectAddress += fragment;
	}

	Tracer_WriteFileMode(1, filePath->string, "incbin");
	fclose(file);

	// free them strings
	free(fileParam);
	free(filePath);
	setListingsBytes();
	return;

evalerr:
	Error_Eval(&macroTable, result);
eol:
	Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL);
}

void Directive_Include(uint8_t* buffer, uint32_t param) {
	objSetAddress();
	createLabelCheck();

	// skip whitespace
	skipWhitespaceAndEOL(buffer, goto eol);

	// parse line into macroTable
	uint8_t* end;
	Expression_Result_Type result = Expression_TokenizeRemainingLine(&macroTable, buffer, &end);

	if (result != Expression_Result_Type_Success) {
		goto evalerr;
	}

	// evaluate the next argument
	LengthString* fileParam;
	EvaluateToken* argEnd;
	fetchArgumentAsStringPass1(macroTable, fileParam, argEnd, result, goto eol, goto evalerr);

	// fetch the file itself
	LengthString* filePath;
	FILE* file = findFile(fileParam->string, "rb", &filePath);

	if (file == NULL) {
		Error_ErrorUnderline(buffers.line, macroTable.result.start, macroTable.result.end, ERRFMT_FILE_NOT_FOUND, fileParam->string);
	}

	// free them strings
	free(fileParam);
	includedFilename = filePath;
	includedFile = file;
	setListingsBytes();
	return;

evalerr:
	Error_Eval(&macroTable, result);
eol:
	Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL);
}

#pragma endregion
#pragma region Equ, Equr& Set

/*
	EQU/SET - Generate a symbol with arbitary value
	===========================
	_label_ equ/set * - Set _label_ to value of *. Set can be used to change _label_ multiple times.
*/

void Directive_Equ(uint8_t* buffer, uint32_t param) {
	// param = 1 -> equ, param = 0 -> set
	objSetAddress();

	if (hasLabel == 0) {
		Error_ErrorUnderline(buffers.line, funcNameBufStart, buffers.line, ERRFMT_SYMBOL_EXPECTED, param == 0 ? "SET" : "EQU");
	}

	// skip whitespace
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// grab proper hashes
	uint32_t hglobal = SymbolExt_CurrentScopeHash, hlocal = 0;
	uint8_t mode = 0;

	if (hasLabel == 1) {
		// global
		hglobal = labelHash;

	} else if (hasLabel == 2) {
		// local
		hlocal = labelHash;
		mode = 1;
	}

	// create symbol
	Symbol* sym = SymbolExt_MakeStdSymbol(labelHash, (uint8_t)param);

	if (sym == NULL) {
		// multiply defined! bad bad
		Error_PrepareString(labelNameBuffer, labelNameBuffer + labelNameLength);
		Error_ErrorUnderline(buffers.line, labelNameBuffer, labelNameBuffer + labelNameLength, ERRFMT_SYMBOL_MULTIPLY, buffers.error);
	}

	if ((sym->flags & Symbol_Flag_Locked) != 0) {
		// can not redefine labels with SET if they are locked
		Error_PrepareString(labelNameBuffer, labelNameBuffer + labelNameLength);
		Error_ErrorUnderline(buffers.line, labelNameBuffer, labelNameBuffer + labelNameLength, ERRFMT_SYMBOL_REDEFINE, buffers.error);

	} else if (param != 0) {
		// lock EQU labels
		sym->flags |= Symbol_Flag_Locked;
	}

	// update scope on non-local labels
	if (options.descopeLabels && (sym->flags & Symbol_Flag_Local) == 0) {
		SymbolExt_CurrentScope = sym;
	}

	Tracer_WriteSymbolAction(0, sym->flags & Symbol_Flag_Local, sym);

	// parse line into macroTable
	uint8_t* end;
	Expression_Result_Type result = Expression_TokenizeRemainingLine(&macroTable, buffer, &end);

	// clone token table just in case
	EvaluateToken* _start = macroTable.start;
	EvaluateToken* _end = macroTable.end - 1;

	if (result <= Expression_Result_Type_Success) {
		// evaluate all tokens
		result = Expression_Evaluate(&macroTable, macroTable.start, macroTable.end - 1);
	}

	// SET must evaluate in pass 1, EQU on pass 2
	if (param == 0 ? (result != Expression_Result_Type_Success) : (result > Expression_Result_Type_Success)) {
		Error_Eval(&macroTable, result);

	} else if (result != Expression_Result_Type_Success) {
		goto pass2;
	}

	// fetch symbol and check for uninitialized symbols
	if (macroTable.result.type == Expression_Token_Type_Symbol) {
		Symbol* symbol;
		result = Expression_FetchSymbolByToken(&macroTable.result, &symbol);

		// check if we are able to resolve the symbol
		if (result != Expression_Result_Type_Success || (symbol->flags & Symbol_Flag_Initialized) == 0) {
			if (param == 0) {
				Error_Eval(&macroTable, result == Expression_Result_Type_Success ? Expression_Result_Type_Symbol_Undefined : result);
			}

			goto pass2;
		}

		// resolve symbol type
		switch (symbol->type) {
			case Symbol_Type_Integer_Equate: // symbol is number
				sym->type = Symbol_Type_Integer_Equate;
				sym->flags |= Symbol_Flag_Initialized;
				sym->extraParam = symbol->extraParam;
				setListingsEqu(sym->extraParam);
				return;

			case Symbol_Type_String_Equate: // symbol is string
				sym->type = Symbol_Type_String_Equate;
				sym->flags |= Symbol_Flag_Initialized;
				sym->string = symbol->string;
				setListingsEqustr(sym->string);
				return;
		}

		goto error;
	}

	// check type
	switch (macroTable.result.type) {
		case Expression_Token_Type_Number: // number - save as such
			sym->type = Symbol_Type_Integer_Equate;
			sym->flags |= Symbol_Flag_Initialized;
			sym->extraParam = macroTable.result.value;
			setListingsEqu(sym->extraParam);
			return;

		case Expression_Token_Type_String: // string - save as such
			sym->type = Symbol_Type_String_Equate;
			sym->flags |= Symbol_Flag_Initialized;
			sym->string = macroTable.result.string;
			setListingsEqustr(sym->string);
			return;
	}

// failed to get result
error:
	Error_ErrorUnderline(buffers.line, buffer, end, ERRTXT_EXP_RESULT_STRORNUM);

pass2:
#ifdef DEBUG
	memTokenTable += Expression_CloneTokenTable(&_start, &_end);
#else
	Expression_CloneTokenTable(&_start, &_end);
#endif

	// EQU resolved on pass 2
	addPass2Symbol(Pass2_Resolve_Equ, objectAddress, _start, _end, hglobal, hlocal, mode);

	// give some default values
	sym->type = Symbol_Type_Integer_Equate;
	sym->extraParam = 0;
	setListingsEquUnk();
}

/*
	EQUR - Generate a symbol with a register value
	===========================
	_label_ equr * - Set _label_ to value of register *. This only supports registers of current CPU
*/

void Directive_Equr(uint8_t* buffer, uint32_t param) {
	// skip dat whitespace
	objSetAddress();
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// check for blank symbols
	if (hasLabel == 0) {
		Error_ErrorUnderline(buffers.line, funcNameBufStart, buffers.line, ERRFMT_SYMBOL_EXPECTED, "EQUR");
	}

	// initialize variables
	uint8_t* _buf = buffer;
	uint8_t read = *buffer;
	uint8_t isLocal = 0;
	uint32_t regHash = 0;

	// get hash for label
	getLabelHash(buffer, regHash, read, isLocal);

	// fetch symbol and check its type
	Symbol* regSym;
	getSymbolAndCheckType(regSym, _buf, buffer, isLocal, regHash, Symbol_Type_Function_Register_68k, ERRFMT_SYMBOL_NOT_REG);

	// throw an error if there's any text following the operand
	expectNUL(_buf, buffer, ERRTXT_DIR_EXPECTED_1_OPERAND);

	// try to create the new symbol
	Symbol* newSym = SymbolExt_MakeStdSymbol(labelHash, 1);

	if (newSym == NULL) {
		// multiply defined! bad bad
		Error_PrepareString(labelNameBuffer, labelNameBuffer + labelNameLength);
		Error_ErrorUnderline(buffers.line, labelNameBuffer, labelNameBuffer + labelNameLength, ERRFMT_SYMBOL_MULTIPLY, buffers.error);
	}

	// update scope on non-local labels
	if (options.descopeLabels && (newSym->flags & Symbol_Flag_Local) == 0) {
		SymbolExt_CurrentScope = newSym;
	}

	Tracer_WriteSymbolAction(0, newSym->flags & Symbol_Flag_Local, newSym);

	// update symbol info
	newSym->flags |= Symbol_Flag_Initialized | Symbol_Flag_Locked;
	newSym->type = regSym->type;
	newSym->extraParam = regSym->extraParam;
}

#pragma endregion

/*
	RENAME - Rename a built-in symbol
	===========================
	_label_ RENAME * - Set _label_ to built-in symbol *, and deprecate *. This only supports symbols of current CPU and assembler built-ins.
*/

void Directive_Rename(uint8_t* buffer, uint32_t param) {
	// skip dat whitespace
	objSetAddress();
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// check for blank symbols
	if (hasLabel == 0) {
		Error_ErrorUnderline(buffers.line, buffers.line, funcNameBufStart, ERRFMT_SYMBOL_EXPECTED, "RENAME");
	}

	// disallow local labels
	if (hasLabel == 2) {
		Error_ErrorUnderline(buffers.line, labelNameBuffer, labelNameBuffer + labelNameLength, ERRTXT_RENAME_LOCAL_SYM);
	}

	// initialize variables
	uint8_t* _buf = buffer;
	uint8_t read = *buffer;
	uint8_t isLocal = 0;
	uint32_t oldHash = 0;

	// get hash for label
	getLabelHash(buffer, oldHash, read, isLocal);

	// fetch symbol and check its type
	Symbol* oldSym;
	getSymbolOnly(oldSym, _buf, buffer, isLocal, oldHash);

	// throw an error if there's any text following the operand
	expectNUL(_buf, buffer, ERRTXT_DIR_EXPECTED_1_OPERAND);

	// find this symbol in the built-in table
	BuiltInSymbol* builtin = SymbolExt_FetchBuiltinByHash(oldHash);

	if (builtin == NULL) {
		Error_ErrorUnderline(buffers.line, _buf, buffer, ERRFMT_NOT_BUILTIN, _buf);
	}

	// try to create the new symbol
	Symbol* newSym = SymbolExt_MakeStdSymbol(labelHash, 1);

	if (newSym == NULL) {
		// multiply defined! bad bad
		Error_PrepareString(labelNameBuffer, labelNameBuffer + labelNameLength);
		Error_ErrorUnderline(buffers.line, labelNameBuffer, labelNameBuffer + labelNameLength, ERRFMT_SYMBOL_MULTIPLY, buffers.error);
	}

	// copy data from the old symbol
	newSym->type = oldSym->type;
	newSym->flags = oldSym->flags;
	newSym->extraParam = oldSym->extraParam;
	newSym->functionPtr = oldSym->functionPtr;

	Tracer_WriteSymbolAction(0, newSym->flags & Symbol_Flag_Local, newSym);
	Tracer_WriteRename(oldSym, newSym);

	// delete old symbol and update built-in table
	builtin->hash = labelHash;
	Symbol_DeleteByHash(oldHash, Symbol_GlobalTable);
	clearListingsAddress();
}

/*
	helper for initializing directives
*/

struct DirectiveHelper {
	void (*code)(uint8_t*, uint32_t);

	uint8_t* name;
	uint64_t param;
	uint32_t index;
	uint32_t hash;
	uint8_t type;
};

// clang-format off
struct DirectiveHelper dirSymbolList[] = {
	{ .type = Symbol_Type_Function, .index = BI_dc, .hash = HASH_dc, .code = &Directive_Dc, .name = HN_DC, .param = 0, },
	{ .type = Symbol_Type_Function, .index = BI_DC, .hash = HASH_DC, .code = &Directive_Dc, .name = HN_DC, .param = 0, },
	{ .type = Symbol_Type_Function, .index = BI_dcb, .hash = HASH_dcb, .code = &Directive_Dc, .name = HN_DCB, .param = 1, },
	{ .type = Symbol_Type_Function, .index = BI_DCB, .hash = HASH_DCB, .code = &Directive_Dc, .name = HN_DCB, .param = 1, },
	{ .type = Symbol_Type_Function, .index = BI_even, .hash = HASH_even, .code = &Directive_Even, .name = HN_EVEN, .param = 0, },
	{ .type = Symbol_Type_Function, .index = BI_EVEN, .hash = HASH_EVEN, .code = &Directive_Even, .name = HN_EVEN, .param = 0, },
	{ .type = Symbol_Type_Function, .index = BI_equ, .hash = HASH_equ, .code = &Directive_Equ, .name = HN_EQU, .param = 1, },
	{ .type = Symbol_Type_Function, .index = BI_EQU, .hash = HASH_EQU, .code = &Directive_Equ, .name = HN_EQU, .param = 1, },
	{ .type = Symbol_Type_Function, .index = BI_set, .hash = HASH_set, .code = &Directive_Equ, .name = HN_EQU, .param = 0, },
	{ .type = Symbol_Type_Function, .index = BI_SET, .hash = HASH_SET, .code = &Directive_Equ, .name = HN_EQU, .param = 0, },
	{ .type = Symbol_Type_Function, .index = BI_equr, .hash = HASH_equr, .code = &Directive_Equr, .name = HN_EQUR, .param = 0, },
	{ .type = Symbol_Type_Function, .index = BI_EQUR, .hash = HASH_EQUR, .code = &Directive_Equr, .name = HN_EQUR, .param = 0, },
	{ .type = Symbol_Type_Function, .index = BI_rename, .hash = HASH_rename, .code = &Directive_Rename, .name = HN_RENAME, .param = 0, },
	{ .type = Symbol_Type_Function, .index = BI_RENAME, .hash = HASH_RENAME, .code = &Directive_Rename, .name = HN_RENAME, .param = 0, },
	{ .type = Symbol_Type_Function, .index = BI_include, .hash = HASH_include, .code = &Directive_Include, .name = HN_INCLUDE, .param = 0, },
	{ .type = Symbol_Type_Function, .index = BI_INCLUDE, .hash = HASH_INCLUDE, .code = &Directive_Include, .name = HN_INCLUDE, .param = 0, },
	{ .type = Symbol_Type_Function, .index = BI_incbin, .hash = HASH_incbin, .code = &Directive_Incbin, .name = HN_INCBIN, .param = 0, },
	{ .type = Symbol_Type_Function, .index = BI_INCBIN, .hash = HASH_INCBIN, .code = &Directive_Incbin, .name = HN_INCBIN, .param = 0, },
};
// clang-format on

/*
	make and load symbols for this assembler
*/

void createDirectives() {
	// loop through all to add dem symbols
	for (uint64_t i = 0; i < sizeof(dirSymbolList) / sizeof(struct DirectiveHelper); i++) {
		SymbolExt_BuiltInTable[dirSymbolList[i].index].hash = dirSymbolList[i].hash;

		// create a new symbol for this
		Symbol* sym = Symbol_FindOrAllocate(dirSymbolList[i].hash, 1);

		if (sym != NULL) {
			// fill its details
			sym->type = dirSymbolList[i].type;
			sym->functionPtr = dirSymbolList[i].code;
			sym->extraParam = dirSymbolList[i].param;
			sym->flags = Symbol_Flag_Initialized | Symbol_Flag_Locked;
			sym->name = dirSymbolList[i].name;

			//	Tracer_WriteSymbolAction(0, 0, sym);
		}
	}
}
