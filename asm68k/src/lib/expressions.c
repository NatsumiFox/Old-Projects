#include <inttypes.h>
#include <setjmp.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <assembler/assembler.h>
#include <assembler/error.h>
#include <lib/expressions.h>
#include <assembler/hash.h>
#include <assembler/listings.h>
#include <assembler/object.h>
#include <assembler/parse.h>

#include <asmlink/debug_tracer.h>
#include <asmlink/symbol_ext.h>

#include <lib/compat.h>
#include <lib/error_lib.h>
#include <lib/debug.h>
#include <lib/messages/global.h>
#include <lib/messages/expressions.h>
#include <lib/hash_lib.h>
#include <lib/symbols.h>
#include <lib/lengthstring.h>
#include <lib/string_lib.h>

// boolean math function
#define EXPRESSION_GET_BOOL(b) (b) ? true : false

// token table and position
TokenTable macroTable;

// function variables
FunctionArguments* Expression_TempFunctionArgs;

#pragma region Error handling

// helper function to print the expression error code
void Expression_WriteErrorCode(FILE* target, TokenTable* table, Expression_Result_Type error) {
	switch (error) {
		case Expression_Result_Type_Unexpected_Char:
			fprintf(target, ERRFMT_UNEXPECTED_IN_INPUT, *table->expEnd);
			return;

		case Expression_Result_Type_EOL:
			fputs(ERRTXT_UNEXPECTED_EOL, target);
			return;

		case Expression_Result_Type_Malloc_Fail:
			fputs(ERRTXT_MALLOC_FAIL, target);
			return;

		case Expression_Result_Type_Symbol_Undefined:
			Error_PrepareString(table->evalStart, table->evalEnd);
			fprintf(target, ERRFMT_SYMBOL_UNDEFINED, buffers.error);
			return;

		case Expression_Result_Type_Symbol_Invalid_In_Exp:
			Error_PrepareString(table->expStart, table->expEnd);
			fprintf(target, ERRFMT_EXP_SYMBOLTYPE, buffers.error);
			return;

		case Expression_Result_Type_No_Eval:
			fputs(ERRTXT_EXP_NO_EVAL, target);
			return;

		case Expression_Result_Type_Too_Deep:
			fputs(ERRTXT_EXP_TOO_DEEP, target);
			return;

		case Expression_Result_Type_Too_Shallow:
			fprintf(target, ERRFMT_UNEXPECTED_CHAR, ')');
			return;

		case Expression_Result_Type_Not_Closed:
			fprintf(target, ERRFMT_EXPECTED_CHAR, ')');
			return;

		case Expression_Result_Type_Expect_OpenParen:
			fprintf(target, ERRFMT_EXPECTED_CHAR, '(');
			return;

		case Expression_Result_Type_NotHex:
			fprintf(target, ERRFUN_EXP_INVALID_NUMBERCHAR(ERRSTR_EXP_NUMBER_TYPE_HEX), *(table->expEnd - 1));
			return;

		case Expression_Result_Type_NotDec:
			fprintf(target, ERRFUN_EXP_INVALID_NUMBERCHAR(ERRSTR_EXP_NUMBER_TYPE_DEC), *(table->expEnd - 1));
			return;

		case Expression_Result_Type_NotBin:
			fprintf(target, ERRFUN_EXP_INVALID_NUMBERCHAR(ERRSTR_EXP_NUMBER_TYPE_BIN), *(table->expEnd - 1));
			return;

		case Expression_Result_Type_LongHex:
			fputs(ERRFUN_EXP_LARGE_NUMBER(ERRSTR_EXP_NUMBER_TYPE_HEX), target);
			return;

		case Expression_Result_Type_LongDec:
			fputs(ERRFUN_EXP_LARGE_NUMBER(ERRSTR_EXP_NUMBER_TYPE_DEC), target);
			return;

		case Expression_Result_Type_LongBin:
			fputs(ERRFUN_EXP_LARGE_NUMBER(ERRSTR_EXP_NUMBER_TYPE_BIN), target);
			return;

		case Expression_Result_Type_ShortNum:
			fputs(ERRTXT_EXP_NOT_NUMBER, target);
			return;

		case Expression_Result_Type_Invalid_Str_Delim:
			fprintf(target, ERRFMT_EXP_NOT_STRING_DELIM, *table->expEnd);
			return;

		case Expression_Result_Type_Invalid_Str_Escape:
			fputs(ERRTXT_EXP_INVALID_ESCAPE, target);
			return;

		case Expression_Result_Type_Invalid_Str_HexEsc:
			fprintf(target, ERRFMT_EXP_INVALID_ESCAPE_CHAR, *table->expEnd);
			return;

		case Expression_Result_Type_Invalid_Str_NoEnd:
			fputs(ERRTXT_EXP_UNEXPECTED_EOL_STR, target);
			return;

		case Expression_Result_Type_Op_Not_Unary:
			fprintf(target, ERRFUN_EXP_EXPECTED_OP_TYPE(ERRSTR_EXP_OP_TYPE_UNARY), *table->expEnd);
			return;

		case Expression_Result_Type_Op_Not_Binary:
			fprintf(target, ERRFUN_EXP_EXPECTED_OP_TYPE(ERRSTR_EXP_OP_TYPE_BINARY), *table->expEnd);
			return;

		case Expression_Result_Type_Value_OOR:
			fprintf(target, ERRFMT_EXP_VALUE_OOR, table->evalValue);
			return;

		case Expression_Result_Type_68k_Invalid_0:
			fputs(ERRTXT_68K_NOVALUE0, target);
			return;

		case Expression_Result_Type_Not_Int:
			fputs(ERRTXT_EXP_FAIL_NUMCONV, target);
			return;

		case Expression_Result_Type_Str_Long:
			fputs(ERRTXT_EXP_STRCONV_TOOLONG, target);
			return;

		case Expression_Result_Type_Not_Str:
			fputs(ERRTXT_EXP_NOT_STRING, target);
			return;

		case Expression_Result_Type_Divsion_0:
			fputs(ERRTXT_EXP_DIV0, target);
			return;

		case Expression_Result_Type_Func_Void:
			fputs(ERRTXT_EXP_VOID_FUNC, target);
			return;

		case Expression_Result_Type_Arg_Null:
			fputs(ERRTXT_EXP_ARG_MISSING, target);
			return;

		case Expression_Result_Type_Arg_Empty:
			fputs(ERRTXT_EXP_ARG_EMPTY, target);
			return;

		case Expression_Result_Type_Symbol_No_Scope:
			fputs(ERRTXT_EXP_SYMBOL_NO_LOCALS, target);
			return;

		case Expression_Result_Type_No_Result:
			fputs(ERRTXT_EXPBUG_NO_RESULT, target);
			return;

		case Expression_Result_Type_Str_Null:
			fputs(ERRTXT_EXPBUG_INVALID_STR, target);
			return;

		case Expression_Result_Type_Invalid_Func_Call:
			fputs(ERRTXT_EXPBUG_INVALID_FUNCCALL, target);
			return;

		case Expression_Result_Type_68k_Not_Movem:
			fprintf(target, ERRTXT_68K_NOTMOVEMREG);
			return;

		default:
			fprintf(target, ERRFMT_EXPBUG_UNKNOWKN, error);
			return;
	}
}

#pragma endregion
#pragma region Symbol fetch

/**
 * Fetch Symbol
 */

// helper function to fetch symbol from hashes
Expression_Result_Type Expression_FetchSymbolByHash(uint64_t hashes, uint8_t mode, Symbol** symbol) {
	// fetch the global symbol
	*symbol = Symbol_Fetch(hashes & 0xFFFFFFFF, Symbol_GlobalTable);

	// check if symbol is valid
	if (*symbol == NULL) {
		return Expression_Result_Type_Symbol_Undefined;
	}

	Tracer_WriteSymbolAction(2, 0, *symbol);

	// check if this is a global:local reference
	if (mode != 0) {
		if (((*symbol)->type != Symbol_Type_Integer_Equate && (*symbol)->type != Symbol_Type_String_Equate) || (*symbol)->innerTable == NULL) {
			return Expression_Result_Type_Symbol_No_Scope;
		}

		// fetch the local symbol
		*symbol = Symbol_FetchLocal(hashes >> 32, *symbol);

		// check if symbol is valid
		if (*symbol == NULL) {
			return Expression_Result_Type_Symbol_Undefined;
		}

		Tracer_WriteSymbolAction(2, 1, *symbol);
	}

	return Expression_Result_Type_Success;
}

// helper function to fetch symbol from token
Expression_Result_Type Expression_FetchSymbolByToken(EvaluateToken* token, Symbol** symbol) {
	return Expression_FetchSymbolByHash(token->value, token->extra, symbol);
}

#pragma endregion
#pragma region Put tokens into the table

// function to handle dealing with pointers
c_inline void tokenFixLinks(TokenTable* table) {
	if (table->end == table->start) {
		// special case
		table->end->prev = NULL;
		table->endCopy->prev = NULL;
	} else {
		// set the prev pointer
		table->end->prev = table->end - 1;
		table->end->prev->next = table->end;
		table->endCopy->prev = table->endCopy - 1;
		table->endCopy->prev->next = table->endCopy;
	}

	// reset next pointer
	table->end->next = NULL;
	table->endCopy->next = NULL;
	table->end++;
	table->endCopy++;
}

// function to add a new token string
c_inline void evaluatePutText(TokenTable* table, uint8_t type, LengthString* str, uint8_t* start, uint8_t* end) {
	table->endCopy->type = table->end->type = type;
	table->endCopy->string = table->end->string = str;
	table->endCopy->start = table->end->start = start;
	table->endCopy->end = table->end->end = end;
	tokenFixLinks(table);
}

// function to add a new token symbol
c_inline void
evaluatePutSymbol(TokenTable* table, uint8_t type, uint8_t extra, uint64_t value, uint8_t* start, uint8_t* end) {
	table->endCopy->type = table->end->type = type;
	table->endCopy->extra = table->end->extra = extra;
	table->endCopy->value = table->end->value = value;
	table->endCopy->start = table->end->start = start;
	table->endCopy->end = table->end->end = end;
	tokenFixLinks(table);
}

// function to add a new token value
c_inline void evaluatePutValue(TokenTable* table, uint8_t type, uint64_t value, uint8_t* start, uint8_t* end) {
	table->endCopy->type = table->end->type = type;
	table->endCopy->value = table->end->value = value;
	table->endCopy->start = table->end->start = start;
	table->endCopy->end = table->end->end = end;
	tokenFixLinks(table);
}

#pragma endregion
#pragma region Handle String

/**
 * Eval strings
 */

// function to escape the string
Expression_Result_Type evaluateEquString(TokenTable* table, LengthString* str, uint8_t* buffer, uint8_t* start, const uint8_t* end) {
	str->string = buffer;
	str->length = 0;

	// evaluate the string
	while (start < end) {
		table->expStart = start;
		uint8_t read = *start++;

		switch (read) {
			case '\\': { // handle escape sequences
				if (start >= end) {
					// failsafe
					table->expEnd = start + 1;
					return Expression_Result_Type_EOL;
				}

				// load eescape character
				str->length++;
				switch (*start++) {
					case '0':
						*buffer++ = '\0';
						break;
					case 'a':
						*buffer++ = '\a';
						break;
					case 'b':
						*buffer++ = '\b';
						break;
					case 'f':
						*buffer++ = '\f';
						break;
					case 'n':
						*buffer++ = '\n';
						break;
					case 'r':
						*buffer++ = '\r';
						break;
					case 't':
						*buffer++ = '\t';
						break;
					case 'v':
						*buffer++ = '\v';
						break;
					case '\\':
						*buffer++ = '\\';
						break;
					case '\'':
						*buffer++ = '\'';
						break;
					case '\"':
						*buffer++ = '\"';
						break;

					case 'x': { // escape hex sequence
						// make sure there is no eol
						if (start >= end + 2) {
							table->expEnd = start + 3;
							return Expression_Result_Type_EOL;
						}

						// load the hex value
						int8_t c1 = String_HexCharToInt(*start++);
						int8_t c2 = String_HexCharToInt(*start++);

						// check if failed to get chars
						if (c1 < 0 || c2 < 0) {
							table->expEnd = start + 1;
							return Expression_Result_Type_Invalid_Str_HexEsc;
						}

						// save character
						*buffer++ = (c1 << 4) | c2;
						break;
					}

					default:
						table->expEnd = start + 1;
						break;
				}
				break;
			}

			default: // all other characters
				*buffer++ = read;
				str->length++;
				break;
		}
	}

	// null terminate string
	*buffer = 0;
	return Expression_Result_Type_Success;
}

// helper function to find the string length
c_inline int32_t findStringLength(TokenTable* table, uint8_t** buffer) {
	// get the string delimiter
	uint8_t delim = **buffer;
	table->expStart = *buffer;

	if (delim != '"' && delim != '\'') {
		table->expEnd = *buffer;
		return -Expression_Result_Type_Invalid_Str_Delim;
	}

	int32_t length = 0;

	while (1) {
		// get the next character
		(*buffer)++;
		uint8_t read = **buffer;

		if (read == delim) {
			// return length on string delimiter
			return length;
		} else if (read == '\\') {
			// lazily evaluate escape sequence
			(*buffer)++;

			// if null, then it is very very bad
			if (**buffer == 0) {
				table->expEnd = *buffer + 1;
				return -Expression_Result_Type_Invalid_Str_NoEnd;
			}
		} else if (read == 0) {
			table->expEnd = *buffer + 1;
			return -Expression_Result_Type_Invalid_Str_NoEnd;
		}

		length++;
	}
}

// function to evaluate a string maybe
c_inline Expression_Result_Type evaluateString(TokenTable* table, uint8_t** start) {
	// fetch the string length
	uint8_t* strEnd = *start;
	int32_t length = findStringLength(table, &strEnd);

	if (length < 0) {
		// failed, return the error code instead
		return (Expression_Result_Type)(-length);
	}

	// create a new string instance
	LengthString* str = malloc(sizeof(LengthString) + length + 1);

	if (!str) {
		return Expression_Result_Type_Malloc_Fail;
	}

#ifdef DEBUG
	memTokenStr += sizeof(LengthString) + length + 1;
#endif

	// load it
	Expression_Result_Type result = evaluateEquString(table, str, (uint8_t*)((uint8_t*)str + sizeof(LengthString)), *start + 1, strEnd);

	if (result > Expression_Result_Type_Success) {
		return result;
	}

	// save the string
	evaluatePutText(table, Expression_Token_Type_String, str, *start, strEnd + 1);
	*start = strEnd + 1;

	table->state = Expression_Eval_State_Binary;
	return Expression_Result_Type_Success;
}

#pragma endregion
#pragma region Helpers

/**
 * Helper routines
 */

// function to skip whitespace in strings
c_inline Expression_Result_Type evaluateSkipSpace(TokenTable* table, uint8_t** start) {
	while (1) {
		uint8_t read = **start;

		// check for NUL
		if (read == 0) {
			table->expEnd = table->expStart = *start;
			return Expression_Result_Type_Success;
		}

		// check for not space
		if (read != ' ') {
			return Expression_Result_Type_Success;
		}

		(*start)++;
	}
}

#pragma endregion
#pragma region Handle Symbols

/**
 * Eval symbols
 */

// function to evaluate a function equate
c_inline void evaluateEquateFunc(TokenTable* table, Symbol* sym, uint8_t* start, uint8_t* end) {
	// run the function first
	EvaluateToken* token = sym->evalPtr(sym->extraParam);

	// put the token down
	switch (token->type) {
		case Symbol_Type_Integer_Equate:
			evaluatePutValue(table, Expression_Token_Type_Number, token->value, start, end);
			return;

		case Symbol_Type_String_Equate:
			evaluatePutText(table, Expression_Token_Type_String, token->string, start, end);
			return;
	}
}

// function to evaluate a token
Expression_Result_Type evaluateSymbolToken(TokenTable* table, uint8_t** start, uint8_t* end) {
	// define some stuffies
	Symbol* scope = SymbolExt_CurrentScope;
	Symbol* sym;

	uint8_t* realStart = *start;
	uint8_t* buffer = *start;
	uint8_t read = *buffer;
	uint32_t hash = 0;
	uint64_t valHash = SymbolExt_CurrentScopeHash;
	uint8_t extra = 0;
	Expression_Result_Type ret = Expression_Result_Type_Success;

	// check first character valid
	if ((charFlagLUT[read] & CF_LABEL_FIRST_CHAR) == 0) {
		table->expEnd = buffer;
		return read == 0 ? Expression_Result_Type_EOL : Expression_Result_Type_Unexpected_Char;
	}

	// check for local label symbol
	if (caseLUT[read] == options.localLabelSymbol) {
		read = LOCAL_HASH_CHAR;
		extra = 1;
		goto getLocalRef;
	}

	// get the hashcode for symbol
	while (1) {
		(buffer)++;
		hash = HASH_GETNEXT(hash, caseLUT[read]);

		// use LUT to check character
		if ((charFlagLUT[read = *buffer] & CF_LABEL_CHAR) == 0) {
			break;
		}
	}

	// fetch dat symbol
	scope = Symbol_Fetch(hash, Symbol_GlobalTable);
	valHash = hash;

	if (scope) {
		Tracer_WriteSymbolAction(2, 0, scope);

	} else {
		ret = Expression_Result_Type_Symbol_Undefined;
		table->evalEnd = table->expEnd = buffer;
		table->evalStart = table->expStart;

		// reserve symbol
		scope = Symbol_FindOrAllocate(hash, 1);
		scope->type = Symbol_Type_Integer_Equate;
		scope->flags = 0;
		scope->extraParam = 0;
		Symbol_AllocateNameFromBuffer(scope, *start, buffer - *start);

		Tracer_WriteSymbolAction(0, 0, scope);
	}

	// check for local label symbol
#ifdef OH_NO_DOTS_WONT_WORK_HERE
	if (caseLUT[read] != ':') {
#else
	if (caseLUT[read] != options.localLabelSymbol) {
#endif
		sym = scope;
		goto onlyGlobal;
	}

	// check that there is a local scope
	if ((scope->type != Symbol_Type_Integer_Equate) && (scope->type != Symbol_Type_String_Equate)) {
		sym = scope;
		goto onlyGlobal;
	}

	read = LOCAL_HASH_CHAR;
	hash = 0;
	extra = 1;
	*start = buffer - 1;

getLocalRef:
	// get the hashcode for symbol
	while (1) {
		(buffer)++;
		hash = HASH_GETNEXT(hash, caseLUT[read]);

		// use LUT to check character
		if ((charFlagLUT[read = *buffer] & CF_LABEL_CHAR) == 0) {
			break;
		}
	}

	// fetch dat symbol
	sym = Symbol_FetchLocal(hash, scope);
	valHash |= (uint64_t)hash << 32;

	if (sym) {
		Tracer_WriteSymbolAction(2, 1, sym);

	} else {
		ret = Expression_Result_Type_Symbol_Undefined;
		table->evalEnd = table->expEnd = buffer;
		table->evalStart = table->expStart;

		// reserve symbol
		sym = Symbol_FindOrAllocateLocal(hash, scope, 1);
		sym->type = Symbol_Type_Integer_Equate;
		sym->flags = 0;
		sym->extraParam = 0;
		Symbol_AllocateNameFromBuffer(sym, *start, buffer - *start);

		Tracer_WriteSymbolAction(0, 1, sym);
	}

onlyGlobal:
	// check if symbol was initialized
	if ((sym->flags & Symbol_Flag_Initialized) == 0) {
		table->evalEnd = table->expEnd = buffer;
		table->evalStart = table->expStart;
		ret = Expression_Result_Type_Symbol_Undefined;
	}

	table->state = Expression_Eval_State_Binary;
	*start = buffer;

	// resolve symbol type
	switch (sym->type) {
		case Symbol_Type_Function:
			evaluatePutSymbol(table, Expression_Token_Type_Func_Start, extra, valHash, realStart, buffer);
			table->state = Expression_Eval_State_Function;
			return ret;

		case Symbol_Type_Function_Register_68k:
		case Symbol_Type_Function_Register_Z80:
			evaluatePutSymbol(table, Expression_Token_Type_Register, extra, valHash, realStart, buffer);
			return ret;

		case Symbol_Type_Integer_Equate:
		case Symbol_Type_String_Equate:
			evaluatePutSymbol(table, Expression_Token_Type_Symbol, extra, valHash, realStart, buffer);
			return ret;

		case Symbol_Type_Function_Equate:
			evaluateEquateFunc(table, sym, realStart, buffer);
			return ret;
	}

	// token not supported
	table->expEnd = buffer;
	return Expression_Result_Type_Symbol_Invalid_In_Exp;
}

#pragma endregion
#pragma region Tokenize Misc Tokens

/**
 * Eval misc tokens
 */

// function to evaluate the program counter
c_inline Expression_Result_Type evaluateProgramCounter(TokenTable* table, uint8_t** start) {
	evaluatePutValue(table, Expression_Token_Type_PC, objectAddress, *start, *start + 1);
	(*start)++;
	table->state = Expression_Eval_State_Binary;
	return Expression_Result_Type_Success;
}

// function to evaluate a dot
c_inline Expression_Result_Type evaluateDot(TokenTable* table, uint8_t** start) {
	evaluatePutValue(table, Expression_Token_Type_Dot, table->depth, *start, *start + 1);
	(*start)++;
	table->state = Expression_Eval_State_Unary;
	return Expression_Result_Type_Success;
}

// function to evaluate a comma
c_inline Expression_Result_Type evaluateComma(TokenTable* table, uint8_t** start) {
	evaluatePutValue(table, Expression_Token_Type_Comma, table->depth, *start, *start + 1);
	(*start)++;
	table->state = Expression_Eval_State_Unary;
	return Expression_Result_Type_Success;
}

// function to evaluate a number sign
c_inline Expression_Result_Type evaluateNumSign(TokenTable* table, uint8_t** start) {
	evaluatePutValue(table, Expression_Token_Type_NumSign, table->depth, *start, *start + 1);
	(*start)++;
	return Expression_Result_Type_Success;
}

/**
 * Eval parenthesis
 */

// function to evaluate an open paren
c_inline Expression_Result_Type evaluateOpenParen(TokenTable* table, uint8_t** start, uint8_t* end) {
	evaluatePutValue(table, Expression_Token_Type_Paren_Open, ++table->depth, *start, *start + 1);

	if (table->depth > MAX_DEPTH) {
		// too deep! we done can't continue
		table->evalEnd = table->expEnd = *start;
		return Expression_Result_Type_Too_Deep;
	}

	// check if this depth is greater than max
	if (table->depth > table->maxDepth) {
		table->maxDepth = table->depth;
	}

	(*start)++;
	table->state = Expression_Eval_State_Unary;
	return Expression_Result_Type_Success;
}

// function to evaluate a closing paren
c_inline Expression_Result_Type evaluateClosingParen(TokenTable* table, uint8_t** start, uint8_t* end) {
	evaluatePutValue(table, Expression_Token_Type_Paren_Closed, --table->depth, *start, *start + 1);

	if (table->depth < 0) {
		// too shgallow! we done can't continue
		table->evalEnd = table->expEnd = *start;
		return Expression_Result_Type_Too_Shallow;
	}

	(*start)++;
	table->state = Expression_Eval_State_Binary;
	return Expression_Result_Type_Success;
}

#pragma endregion
#pragma region Tokenize Binary Operators

// function to evaluate a binary operator
Expression_Result_Type evaluateBinaryOperator(TokenTable* table, uint8_t** start, uint8_t* end) {
	table->state = Expression_Eval_State_Unary;

	switch (*(*start)++) {
		case '+':
			evaluatePutValue(table, Expression_Token_Type_Plus, Expression_Token_Prec_Plus, *start - 1, *start);
			return Expression_Result_Type_Success;

		case '-':
			// use + instead of --
			if (**start == '-') {
				(*start)++;
				evaluatePutValue(table, Expression_Token_Type_Plus, Expression_Token_Prec_Plus, *start - 2, *start);
			} else {
				evaluatePutValue(table, Expression_Token_Type_Minus, Expression_Token_Prec_Minus, *start - 1, *start);
			}
			return Expression_Result_Type_Success;

		case '*':
			evaluatePutValue(table, Expression_Token_Type_Multiply, Expression_Token_Prec_Multiply, *start - 1, *start);
			return Expression_Result_Type_Success;

		case '/':
			evaluatePutValue(table, Expression_Token_Type_Divide, Expression_Token_Prec_Divide, *start - 1, *start);
			return Expression_Result_Type_Success;

		case '%':
			evaluatePutValue(table, Expression_Token_Type_Modulo, Expression_Token_Prec_Modulo, *start - 1, *start);
			return Expression_Result_Type_Success;

		case '^':
			evaluatePutValue(table, Expression_Token_Type_Xor, Expression_Token_Prec_Xor, *start - 1, *start);
			return Expression_Result_Type_Success;

		case '&':
			// check for &&
			if (**start == '&') {
				(*start)++;
				evaluatePutValue(table, Expression_Token_Type_Logical_And, Expression_Token_Prec_Logical_And, *start - 2, *start);
			} else {
				evaluatePutValue(table, Expression_Token_Type_And, Expression_Token_Prec_And, *start - 1, *start);
			}
			return Expression_Result_Type_Success;

		case '|':
			// check for ||
			if (**start == '|') {
				(*start)++;
				evaluatePutValue(table, Expression_Token_Type_Logical_Or, Expression_Token_Prec_Logical_Or, *start - 2, *start);
			} else {
				evaluatePutValue(table, Expression_Token_Type_Or, Expression_Token_Prec_Or, *start - 1, *start);
			}
			return Expression_Result_Type_Success;

		case '<':
			if (**start == '<') {
				// this is <<
				(*start)++;
				evaluatePutValue(table, Expression_Token_Type_ShiftL, Expression_Token_Prec_ShiftL, *start - 2, *start);
			} else if (**start == '>') {
				// this is <>
				(*start)++;
				evaluatePutValue(table, Expression_Token_Type_CmpNEQ, Expression_Token_Prec_CmpNEQ, *start - 2, *start);
			} else if (**start == '=') {
				// this is <=
				(*start)++;
				evaluatePutValue(table, Expression_Token_Type_CmpLTE, Expression_Token_Prec_CmpLTE, *start - 2, *start);
			} else {
				evaluatePutValue(table, Expression_Token_Type_CmpLT, Expression_Token_Prec_CmpLT, *start - 1, *start);
			}
			return Expression_Result_Type_Success;

		case '>':
			if (**start == '>') {
				// this is >>
				(*start)++;
				evaluatePutValue(table, Expression_Token_Type_ShiftR, Expression_Token_Prec_ShiftR, *start - 2, *start);
			} else if (**start == '=') {
				// this is >=
				(*start)++;
				evaluatePutValue(table, Expression_Token_Type_CmpGTE, Expression_Token_Prec_CmpGTE, *start - 2, *start);
			} else {
				evaluatePutValue(table, Expression_Token_Type_CmpGT, Expression_Token_Prec_CmpGT, *start - 1, *start);
			}
			return Expression_Result_Type_Success;

		case '=':
			// check for ==
			if (**start == '=') {
				(*start)++;
			}

			evaluatePutValue(table, Expression_Token_Type_CmpEQ, Expression_Token_Prec_CmpEQ, *start - 1, *start);
			return Expression_Result_Type_Success;

		case '!':
			// check for !=
			if (**start == '=') {
				(*start)++;
				evaluatePutValue(table, Expression_Token_Type_CmpNEQ, Expression_Token_Prec_CmpNEQ, *start - 2, *start);
				return Expression_Result_Type_Success;
			}

			break; // ! does nothing by itself
	}

	// failed to find valid stuff
	table->expEnd = table->expStart = *start - 1;
	return Expression_Result_Type_Op_Not_Binary;
}

#pragma endregion
#pragma region Tokenize Unary Operators

// function to evaluate a unary operator
c_inline Expression_Result_Type evaluateUnaryOperator(TokenTable* table, uint8_t** start, uint8_t* end) {
	switch (*(*start)++) {
		case '+':
			// ignore unary plus
			return Expression_Result_Type_Success;

		case '-':
			// ignore if the next char is also unary minus
			if (**start == '-') {
				(*start)++;
			} else {
				evaluatePutValue(table, Expression_Token_Type_Unary_Minus, Expression_Token_Prec_Unary_Minus, *start - 1, *start);
			}
			return Expression_Result_Type_Success;

		case '~':
			// ignore if the next char is also unary not
			if (**start == '~') {
				(*start)++;
			} else {
				evaluatePutValue(table, Expression_Token_Type_Unary_Not, Expression_Token_Prec_Unary_Not, *start - 1, *start);
			}
			return Expression_Result_Type_Success;

		case '!':
			evaluatePutValue(table, Expression_Token_Type_Unary_Logical_Not, Expression_Token_Prec_Unary_Logical_Not, *start - 1, *start);
			return Expression_Result_Type_Success;
	}

	// failed to find valid stuff
	table->expEnd = table->expStart = *start - 1;
	return Expression_Result_Type_Op_Not_Unary;
}

#pragma endregion
#pragma region Tokenize Numbers

// function to evaluate a binary number
c_inline Expression_Result_Type evaluateBinaryNumber(TokenTable* table, uint8_t* realStart, uint8_t** start, const uint8_t* end) {
	uint64_t value = 0;
	int32_t bit = 64;
	uint8_t read = **start;

	while (1) {
		// check the end of the buffer
		if (*start >= end) {
			goto is_ok;
		}

		// check binary number being too long
		if (--bit < 0) {
			table->expEnd = *start;
			return Expression_Result_Type_LongBin;
		}

		// get character type
		uint8_t flags = charFlagLUT[read];

		if (flags & CF_HEX_CHAR) {
			(*start)++;

			// this is a number character, so check if its valid
			if (read == '0') {
				value <<= 1;
			} else if (read == '1') {
				value <<= 1;
				value |= 1;
			} else {
				// nope note valid
				table->expEnd = *start;
				return Expression_Result_Type_NotBin;
			}

			read = **start;
		} else if (read == 0 || (flags & CF_OPERATOR) || (flags & CF_SEPARATOR)) {
			goto is_ok;
		} else {
			// not a valid character either
			table->expEnd = *start + 1;
			return Expression_Result_Type_NotBin;
		}
	}

is_ok: // success!
	if (bit == 64) {
		// actually no
		table->expEnd = *start + 1;
		return read == 0 ? Expression_Result_Type_EOL : Expression_Result_Type_ShortNum;
	}

	evaluatePutValue(table, Expression_Token_Type_Number, value, realStart, *start);
	table->state = Expression_Eval_State_Binary;
	return Expression_Result_Type_Success;
}

// function to evaluate a hexadecimal number
c_inline Expression_Result_Type evaluateHexNumber(TokenTable* table, uint8_t* realStart, uint8_t** start, const uint8_t* end) {
	uint64_t value = 0;
	int32_t digit = 16;
	uint8_t read = **start;

	while (1) {
		// check the end of the buffer
		if (*start >= end) {
			goto is_ok;
		}

		// check hex number being too long
		if (--digit < 0) {
			table->expEnd = *start;
			return Expression_Result_Type_LongHex;
		}

		// get character type
		uint8_t flags = charFlagLUT[read];

		if (flags & CF_HEX_CHAR) {
			(*start)++;

			// load character value
			value <<= 4;
			value |= String_HexCharToInt(read);
			read = **start;

		} else if (read == 0 || (flags & CF_OPERATOR) || (flags & CF_SEPARATOR)) {
			goto is_ok;

		} else {
			// not a valid character either
			table->expEnd = *start + 1;
			return Expression_Result_Type_NotHex;
		}
	}

is_ok: // success!
	if (digit == 16) {
		// actually no
		table->expEnd = *start + 1;
		return read == 0 ? Expression_Result_Type_EOL : Expression_Result_Type_ShortNum;
	}

	evaluatePutValue(table, Expression_Token_Type_Number, value, realStart, *start);
	table->state = Expression_Eval_State_Binary;
	return Expression_Result_Type_Success;
}

// function to evaluate a decimal number
c_inline Expression_Result_Type evaluateDecNumber(TokenTable* table, uint8_t* realStart, uint8_t** start, const uint8_t* end) {
	uint64_t value = 0;
	int32_t digit = 20;
	uint8_t read = **start;

	while (1) {
		// check the end of the buffer
		if (*start >= end) {
			goto is_ok;
		}

		// check decimal number being too long
		if (--digit < 0) {
			table->expEnd = *start;
			return Expression_Result_Type_LongDec;
		}

		// get character type
		uint8_t flags = charFlagLUT[read];

		if (flags & CF_DEC_CHAR) {
			(*start)++;

			// this is a number character, so check if its valid
			if (read >= '0' && read <= '9') {
				value *= 10;
				value += read - '0';

			} else {
				// not a valid character
				table->expEnd = *start;
				return Expression_Result_Type_NotDec;
			}

			read = **start;

		} else if (read == 0 || (flags & CF_OPERATOR) || (flags & CF_SEPARATOR)) {
			goto is_ok;

		} else {
			// not a valid character either
			table->expEnd = *start + 1;
			return Expression_Result_Type_NotDec;
		}
	}

is_ok: // success!
	if (digit == 20) {
		// actually no
		table->expEnd = *start + 1;
		return read == 0 ? Expression_Result_Type_EOL : Expression_Result_Type_ShortNum;
	}

	evaluatePutValue(table, Expression_Token_Type_Number, value, realStart, *start);
	table->state = Expression_Eval_State_Binary;
	return Expression_Result_Type_Success;
}

// function to figure out what type of number this is
Expression_Result_Type evaluateNumber(TokenTable* table, uint8_t** start, uint8_t* end) {
	uint8_t* realStart = *start;

	// check number starting with 0x or 0b
	if (**start == '0') {
		if (*(*start + 1) == 'x' || *(*start + 1) == 'X') {
			(*start) += 2;
			return evaluateHexNumber(table, realStart, start, end);

		} else if (*(*start + 1) == 'b' || *(*start + 1) == 'B') {
			(*start) += 2;
			return evaluateBinaryNumber(table, realStart, start, end);
		}
	}

	// find the first non-alphanumeric
	uint8_t* buffer = (*start) - 1;

	while (1) {
		buffer++;

		if (*buffer >= '0' && *buffer <= '9') {
			continue;
		}

		if (*buffer >= 'A' && *buffer <= 'Z') {
			continue;
		}

		if (*buffer >= 'a' && *buffer <= 'z') {
			continue;
		}

		break;
	}

	// check if this could be a hex number
	if (*(buffer - 1) == 'h' || *(buffer - 1) == 'H') {
		int result = evaluateHexNumber(table, realStart, start, buffer - 1);
		(*start)++;
		return result;
	}

	// check if this could be a binary number
	if (*(buffer - 1) == 'b' || *(buffer - 1) == 'B') {
		int result = evaluateBinaryNumber(table, realStart, start, buffer - 1);
		(*start)++;
		return result;
	}

	// evaluate decimal number
	return evaluateDecNumber(table, realStart, start, end);
}

#pragma endregion
#pragma region Regular Tokens

/**
 * Eval token that comes after a value
 */

// function to tokenize binary tokens
Expression_Result_Type evaluateBinaryToken(TokenTable* table, uint8_t** start, uint8_t* end) {
	uint8_t read = **start;

	// get type
	table->expStart = *start;
	uint8_t flags = charFlagLUT[read];

	if (flags & CF_OPERATOR) {
		// this must be an operator
		return evaluateBinaryOperator(table, start, end);

	} else if (read == ',') {
		return evaluateComma(table, start);

	} else if (read == '.') {
		return evaluateDot(table, start);

	} else if (read == '(') {
		return evaluateOpenParen(table, start, end);

	} else if (read == ')') {
		return evaluateClosingParen(table, start, end);

	} else if (read == '#') {
		return evaluateNumSign(table, start);
	}

	// we don't understand!
	table->expEnd = *start;
	return read == 0 ? Expression_Result_Type_EOL : Expression_Result_Type_Unexpected_Char;
}

/**
 * Eval token that comes after an operator or NUL
 */

// function to tokenize unary tokens
Expression_Result_Type evaluateUnaryToken(TokenTable* table, uint8_t** start, uint8_t* end) {
	uint8_t read = **start;

	// get type
	table->expStart = *start;
	uint8_t flags = charFlagLUT[read];

	if (flags & CF_LABEL_FIRST_CHAR) {
		// this must be a symbol
		return evaluateSymbolToken(table, start, end);

	} else if (flags & CF_DEC_CHAR) {
		// this must be a number
		return evaluateNumber(table, start, end);

	} else if (read == options.programCounterSymbol) {
		return evaluateProgramCounter(table, start);

	} else if (read == '$') {
		// this must be a hex number
		(*start)++;
		return evaluateHexNumber(table, (*start) - 1, start, end);

	} else if (read == '%') {
		// this must be a binary number
		(*start)++;
		return evaluateBinaryNumber(table, (*start) - 1, start, end);

	} else if (flags & CF_OPERATOR) {
		// this must be an operator
		return evaluateUnaryOperator(table, start, end);

	} else if (flags & CF_STRING) {
		// this could be a string
		return evaluateString(table, start);

	} else if (read == ',') {
		return evaluateComma(table, start);

	} else if (read == '.') {
		return evaluateDot(table, start);

	} else if (read == '(') {
		return evaluateOpenParen(table, start, end);

	} else if (read == ')') {
		return evaluateClosingParen(table, start, end);

	} else if (read == '#') {
		return evaluateNumSign(table, start);
	}

	// we don't understand!
	table->expEnd = *start;
	return read == 0 ? Expression_Result_Type_EOL : Expression_Result_Type_Unexpected_Char;
}

#pragma endregion
#pragma region Tokenize Functions

/**
 * Eval token that comes after a function reference
 */

// function to tokenize function arguments
Expression_Result_Type evaluateFuncArg(TokenTable* table, uint8_t** start, const uint8_t* end) {
	uint8_t* realStart = *start;
	uint8_t read = **start;
	uint32_t length = 0;
	uint8_t strsym = 0;
	uint8_t escaped = 0;
	uint8_t depth = 0;

	// main loop
	while (1) {
		if (strsym == 0) {
			// not string
			if (depth == 0 && (read == ',' || read == ')')) {
				break;
			} else if (read == ')') {
				depth--;
			} else if (read == '(') {
				depth++;
			} else if ((charFlagLUT[read] & CF_STRING) != 0) {
				strsym = read;
			}

			// check string-specific modes
		} else if (read == '\\') {
			escaped = !escaped;
		} else if (!escaped && strsym == read) {
			strsym = 0;
		} else {
			escaped = 0;
		}

		// get next char
		(*start)++;
		length++;
		read = **start;

		// check EOL
		if (*start >= end) {
			return Expression_Result_Type_EOL;
		}
	}

	// create a new string instance
	LengthString* str = malloc(sizeof(LengthString) + length + 1);

	if (!str) {
		return Expression_Result_Type_Malloc_Fail;
	}

	str->string = (uint8_t*)((uint8_t*)str + sizeof(LengthString));
	str->length = length;

	// copy string data and append a NUL
	memcpy(str->string, realStart, length);
	*(str->string + length) = 0;

	// save the string
	evaluatePutText(table, Expression_Token_Type_Func_Arg, str, realStart, *start + 1);
	return Expression_Result_Type_Success;
}

// function to tokenize function size field
c_inline Expression_Result_Type evaluateFuncSize(TokenTable* table, uint8_t** start, const uint8_t* end) {
	uint8_t* realStart = *start;
	uint8_t read = **start;
	uint32_t length = 0;
	uint8_t flags = charFlagLUT[read];

	// find the next character that isnt valid for labels
	while ((flags & CF_LABEL_FIRST_CHAR) != 0) {
		(*start)++;
		length++;

		// update flag stuff
		read = **start;
		flags = charFlagLUT[read];

		// check EOL
		if (*start >= end) {
			return Expression_Result_Type_EOL;
		}
	}

	// create a new string instance
	LengthString* str = malloc(sizeof(LengthString) + length + 1);

	if (!str) {
		return Expression_Result_Type_Malloc_Fail;
	}

	str->string = (uint8_t*)((uint8_t*)str + sizeof(LengthString));
	str->length = length;

	// copy string data and append a NUL
	memcpy(str->string, realStart, length);
	*(str->string + length) = 0;

	// save the string
	evaluatePutText(table, Expression_Token_Type_Func_Size, str, realStart, *start + 1);
	return Expression_Result_Type_Success;
}

// function to tokenize function references
Expression_Result_Type evaluateFuncTokens(TokenTable* table, uint8_t** start, uint8_t* end) {
	uint8_t read = **start;
	table->expStart = *start;
	Expression_Result_Type result = Expression_Result_Type_Success;

	if (read == '.') {
		// check for size field
		(*start)++;
		if ((result = evaluateFuncSize(table, start, end)) != Expression_Result_Type_Success) {
			return result;
		}

		read = **start;
		table->expStart = *start;
	}

	// check the next token
	if (read != '(') {
		return Expression_Result_Type_Expect_OpenParen;
	}

	(*start)++;
	read = **start;
	uint32_t argc = 0;

	// check for empty argument list
	if (read == ')') {
		(*start)++;
	} else {
		// loop until )
		while (1) {
			if (*start >= end) {
				return Expression_Result_Type_EOL;
			}

			// evaluate next argument
			if ((result = evaluateFuncArg(table, start, end)) != Expression_Result_Type_Success) {
				return result;
			}

			argc++;

			// check which character was broken on
			read = **start;

			if (read == ',') {
				(*start)++;
				read = **start;
			} else if (read == ')') {
				(*start)++;
				break;
			}
		}
	}

	// add function end pos
	evaluatePutValue(table, Expression_Token_Type_Func_End, argc, *start, *start);
	table->state = Expression_Eval_State_Binary;
	return Expression_Result_Type_Success;
}

#pragma endregion
#pragma region Tokenize Main Functions

// function to tokenize inner scope of an expression
Expression_Result_Type tokenizeInner(TokenTable* table, uint8_t** start, uint8_t* end) {
	Expression_Result_Type result = Expression_Result_Type_Success, rx;
	table->state = Expression_Eval_State_Unary;

	// loop until we finally get it done
	while (*start < end) {
		// skip the initial whitespace
		if ((rx = evaluateSkipSpace(table, start)) > Expression_Result_Type_Success) {
			return rx;
		}

		// check if expression ended
		if (*start >= end) {
			break;
		}

		switch (table->state) {
			case Expression_Eval_State_Unary:
				// tokenize unary operand
				rx = evaluateUnaryToken(table, start, end);
				break;

			case Expression_Eval_State_Binary:
				// tokenize binary operand
				rx = evaluateBinaryToken(table, start, end);
				break;

			case Expression_Eval_State_Function:
				// tokenize binary operand
				rx = evaluateFuncTokens(table, start, end);
				break;
		}

		// check result of the operation
		if (rx > Expression_Result_Type_Success) {
			return rx;
		} else if (rx < result) {
			result = rx;
		}
	}

	return result;
}

// function to tokenize expressions. return value = if successful
Expression_Result_Type Expression_Tokenize(uint8_t* start, uint8_t* end, TokenTable* table) {
	table->start = table->table;
	table->end = table->table;
	table->endCopy = table->tableCopy;
	table->expStart = table->expEnd = start;
	table->depth = 0;

	// special check for empty strings
	if (start == end) {
		return Expression_Result_Type_Arg_Empty;
	}

	Expression_Result_Type result;

	// tokenize the inner stuff
	if ((result = tokenizeInner(table, &start, end)) > Expression_Result_Type_Success) {
		return result;
	}

	// check if expression was correct
	if (table->depth > 0) {
		table->expStart = table->expEnd = start;
		return Expression_Result_Type_Not_Closed;
	}

	// return the code
	return result;
}

#pragma endregion

/**
 * Convert token to string
 */

// helper function to check for symbol status
c_inline Expression_Result_Type checkSymbol(Symbol* sym) {
	// check if symbol was created
	if ((sym->flags & Symbol_Flag_Initialized) == 0) {
		//	table->evalStart = table->expStart = sym->name;		wait why was this here??
		return Expression_Result_Type_Symbol_Undefined;
	}

	return Expression_Result_Type_Success;
}

#pragma region Evaluate Strings

// evaluate result as a string
Expression_Result_Type Expression_EvaluateAsString(LengthString** value, EvaluateToken* token) {
	*value = NULL;

	// check if the result object is null somehow
	if (token->type == Expression_Token_Type_Null) {
		return Expression_Result_Type_No_Result;
	}

	// check for string symbol reference
	if (token->type == Expression_Token_Type_Symbol) {
		Symbol* symbol;
		Expression_Result_Type result = Expression_FetchSymbolByToken(token, &symbol);

		if (result == Expression_Result_Type_Success) {
			result = checkSymbol(symbol);
		}

		if (result != Expression_Result_Type_Success) {
			return result;
		}

		// check string type
		if (symbol->type != Symbol_Type_String_Equate) {
			return Expression_Result_Type_Not_Str;
		}

		*value = symbol->string;

		// check for not string
	} else if (token->type != Expression_Token_Type_String) {
		return Expression_Result_Type_Not_Str;
	} else {
		// load normal string
		*value = token->string;
	}

	// check if string is somehow null
	if (*value == NULL || (*value)->string == NULL) {
		return Expression_Result_Type_Str_Null;
	}

	// got dat string
	return Expression_Result_Type_Success;
}

#pragma endregion
#pragma region Evaluate Numbers

/**
 * Convert token to number
 */

// evaluate string as a number
c_inline Expression_Result_Type tokenStringToNumber(TokenTable* table, uint32_t characters, uint64_t* value, EvaluateToken* token) {
	*value = 0;
	LengthString* str;
	Symbol* symbol = NULL;

	// check for string symbol reference
	if (token->type == Expression_Token_Type_Symbol) {
		Expression_Result_Type result = Expression_FetchSymbolByToken(token, &symbol);

		if (result == Expression_Result_Type_Success) {
			result = checkSymbol(symbol);
		}

		if (result != Expression_Result_Type_Success) {
			return result;
		}

		// check string type
		if (symbol->type != Symbol_Type_String_Equate) {
			return Expression_Result_Type_Not_Str;
		}

		str = symbol->string;
	} else {
		// load normal string
		str = token->string;
	}

	// check if string is somehow null
	if (str == NULL || str->string == NULL) {
		return Expression_Result_Type_Str_Null;
	}

	// check max string length
	if (str->length > characters) {
		return Expression_Result_Type_Str_Long;
	}

	// load value from string
	int shift = 0, i;
	for (i = str->length - 1; i >= 0; i--) {
		*value |= str->string[i] << shift;
		shift += 8;
	}

#if defined(TRACER)
	// add trace debug
	if (symbol == NULL) {
		Tracer_GetValueStringToNumber(*value, token);

	} else {
		Tracer_GetSymbolStringToNumber(*value, symbol);
	}
#endif

	return Expression_Result_Type_Success;
}

// evaluate result as a number
Expression_Result_Type Expression_EvaluateAsNumber(TokenTable* table, uint64_t* value, uint32_t maxString, EvaluateToken* token) {
	*value = 0;

	// check if the result object is null somehow
	if (token->type == Expression_Token_Type_Null) {
		return Expression_Result_Type_No_Result;
	}

	Expression_Result_Type result = Expression_Result_Type_Success;
	switch (token->type) {
		case Expression_Token_Type_Symbol:; // special checks for symbols
			Symbol* symbol;
			result = Expression_FetchSymbolByToken(token, &symbol);

			if (result == Expression_Result_Type_Success) {
				result = checkSymbol(symbol);
			}

			if (result != Expression_Result_Type_Success) {
				return result;
			}

			switch (symbol->type) {
				case Symbol_Type_Integer_Equate: // symbol is number
					*value = symbol->extraParam;
					Tracer_GetSymbolNumber(*value, symbol->name);
					return Expression_Result_Type_Success;

				case Symbol_Type_String_Equate: // symbol is string
					return tokenStringToNumber(table, maxString, value, token);
			}

			// rip we failed
			break;

		case Expression_Token_Type_Number:
		case Expression_Token_Type_PC: // Expression_Token_Type_Number and Expression_Token_Type_PC don't need conversion
			*value = token->value;
			Tracer_GetValueNumber(*value);
			return Expression_Result_Type_Success;

		case Expression_Token_Type_String: // Expression_Token_Type_String is converted to number according to character encoding
			return tokenStringToNumber(table, maxString, value, token);
	}

	// can not be converted to an integer
	return Expression_Result_Type_Not_Int;
}

#pragma endregion
#pragma region Evaluate Specific number types

// evaluate result as 64-bit signed or unsigned integer
Expression_Result_Type Expression_EvaluateAsQuad(TokenTable* table, uint64_t* value, uint64_t offset) {
	// convert result to a number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, &table->evalValue, 8, &table->result);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		*value = 0;
		return result;
	}

	table->evalValue += offset;

	// valid!!
	*value = (uint64_t)table->evalValue;
	return Expression_Result_Type_Success;
}

// evaluate result as 32-bit unsigned integer
Expression_Result_Type Expression_EvaluateAsUint32(TokenTable* table, uint32_t* value, uint64_t offset) {
	// convert result to a number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, &table->evalValue, 4, &table->result);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		*value = 0;
		return result;
	}

	table->evalValue += offset;

	// check range is within integer limits
	if (table->evalValue > UINT32_MAX) {
		*value = 0;
		return Expression_Result_Type_Value_OOR;
	}

	// valid!!
	*value = (uint32_t)table->evalValue;
	return Expression_Result_Type_Success;
}

// evaluate result as 32-bit signed integer
Expression_Result_Type Expression_EvaluateAsInt32(TokenTable* table, int32_t* value, int64_t offset) {
	// convert result to a number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, &table->evalValue, 4, &table->result);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		*value = 0;
		return result;
	}

	table->evalValue += offset;
	int64_t vx = (int64_t)table->evalValue;

	// check range is within integer limits
	if (vx < INT32_MIN || vx > INT32_MAX) {
		*value = 0;
		return Expression_Result_Type_Value_OOR;
	}

	// valid!!
	*value = (int32_t)vx;
	return Expression_Result_Type_Success;
}

// evaluate result as 32-bit signed or unsigned integer
Expression_Result_Type Expression_EvaluateAsLong(TokenTable* table, uint32_t* value, uint64_t offset) {
	// convert result to a number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, &table->evalValue, 4, &table->result);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		*value = 0;
		return result;
	}

	table->evalValue += offset;

	// check range is within integer limits
	if ((int64_t)table->evalValue < INT32_MIN || (int64_t)table->evalValue > UINT32_MAX) {
		*value = 0;
		return Expression_Result_Type_Value_OOR;
	}

	// valid!!
	*value = (uint32_t)table->evalValue;
	return Expression_Result_Type_Success;
}

// evaluate result as 16-bit unsigned integer
Expression_Result_Type Expression_EvaluateAsUint16(TokenTable* table, uint16_t* value, uint64_t offset) {
	// convert result to a number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, &table->evalValue, 2, &table->result);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		*value = 0;
		return result;
	}

	table->evalValue += offset;

	// check range is within integer limits
	if (table->evalValue > UINT16_MAX) {
		*value = 0;
		return Expression_Result_Type_Value_OOR;
	}

	// valid!!
	*value = (uint16_t)table->evalValue;
	return Expression_Result_Type_Success;
}

// evaluate result as 16-bit signed integer
Expression_Result_Type Expression_EvaluateAsInt16(TokenTable* table, int16_t* value, int64_t offset) {
	// convert result to a number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, &table->evalValue, 2, &table->result);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		*value = 0;
		return result;
	}

	table->evalValue += offset;
	int64_t vx = (int64_t)table->evalValue;

	// check range is within integer limits
	if (vx < INT16_MIN || vx > INT16_MAX) {
		*value = 0;
		return Expression_Result_Type_Value_OOR;
	}

	// valid!!
	*value = (int16_t)vx;
	return Expression_Result_Type_Success;
}

// evaluate result as 16-bit signed or unsigned integer
Expression_Result_Type Expression_EvaluateAsWord(TokenTable* table, uint16_t* value, uint64_t offset) {
	// convert result to a number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, &table->evalValue, 2, &table->result);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		*value = 0;
		return result;
	}

	table->evalValue += offset;

	// check range is within integer limits
	if ((int64_t)table->evalValue < INT16_MIN || (int64_t)table->evalValue > UINT16_MAX) {
		*value = 0;
		return Expression_Result_Type_Value_OOR;
	}

	// valid!!
	*value = (uint16_t)table->evalValue;
	return Expression_Result_Type_Success;
}

// evaluate result as 8-bit unsigned integer
Expression_Result_Type Expression_EvaluateAsUint8(TokenTable* table, uint8_t* value, uint64_t offset) {
	// convert result to a number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, &table->evalValue, 1, &table->result);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		*value = 0;
		return result;
	}

	table->evalValue += offset;

	// check range is within integer limits
	if (table->evalValue > UINT8_MAX) {
		*value = 0;
		return Expression_Result_Type_Value_OOR;
	}

	// valid!!
	*value = (uint8_t)table->evalValue;
	return Expression_Result_Type_Success;
}

// evaluate result as 8-bit signed integer
Expression_Result_Type Expression_EvaluateAsInt8(TokenTable* table, int8_t* value, int64_t offset) {
	// convert result to a number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, &table->evalValue, 1, &table->result);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		*value = 0;
		return result;
	}

	table->evalValue += offset;
	int64_t vx = (int64_t)table->evalValue;

	// check range is within integer limits
	if (vx < INT8_MIN || vx > INT8_MAX) {
		*value = 0;
		return Expression_Result_Type_Value_OOR;
	}

	// valid!!
	*value = (int8_t)vx;
	return Expression_Result_Type_Success;
}

// evaluate result as 8-bit signed or unsigned integer
Expression_Result_Type Expression_EvaluateAsByte(TokenTable* table, uint8_t* value, uint64_t offset) {
	// convert result to a number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, &table->evalValue, 1, &table->result);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		*value = 0;
		return result;
	}

	table->evalValue += offset;

	// check range is within integer limits
	if ((int64_t)table->evalValue < INT8_MIN || (int64_t)table->evalValue > UINT8_MAX) {
		*value = 0;
		return Expression_Result_Type_Value_OOR;
	}

	// valid!!
	*value = (uint8_t)table->evalValue;
	return Expression_Result_Type_Success;
}

// evaluate result as 4-bit unsigned integer
Expression_Result_Type Expression_EvaluateAsUint4(TokenTable* table, uint8_t* value, uint64_t offset) {
	// convert result to a number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, &table->evalValue, 1, &table->result);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		*value = 0;
		return result;
	}

	table->evalValue += offset;

	// check range is within integer limits
	if (table->evalValue > 0xF) {
		*value = 0;
		return Expression_Result_Type_Value_OOR;
	}

	// valid!!
	*value = (uint8_t)table->evalValue;
	return Expression_Result_Type_Success;
}

// evaluate result as 4-bit signed integer
Expression_Result_Type Expression_EvaluateAsInt4(TokenTable* table, int8_t* value, int64_t offset) {
	// convert result to a number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, &table->evalValue, 1, &table->result);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		*value = 0;
		return result;
	}

	table->evalValue += offset;
	int64_t vx = (int64_t)table->evalValue;

	// check range is within integer limits
	if (vx < -8 || vx > 7) {
		*value = 0;
		return Expression_Result_Type_Value_OOR;
	}

	// valid!!
	*value = (int8_t)vx;
	return Expression_Result_Type_Success;
}

// evaluate result as 4-bit signed or unsigned integer
Expression_Result_Type Expression_EvaluateAsNibble(TokenTable* table, uint8_t* value, uint64_t offset) {
	// convert result to a number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, &table->evalValue, 1, &table->result);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		*value = 0;
		return result;
	}

	table->evalValue += offset;

	// check range is within integer limits
	if ((int64_t)table->evalValue < -8 || (int64_t)table->evalValue > 7) {
		*value = 0;
		return Expression_Result_Type_Value_OOR;
	}

	// valid!!
	*value = (uint8_t)table->evalValue;
	return Expression_Result_Type_Success;
}

#pragma endregion
#pragma region Evaluate Math expressions

/**
 * Binary operator calculations
 */

// binary plus handler
Expression_Result_Type calcBinaryPlus(uint64_t* result, uint64_t left, uint64_t right) {
	*result = left + right;
	Tracer_WriteBinaryOperator(left, "+", right, *result);
	return Expression_Result_Type_Success;
}

// binary minus handler
Expression_Result_Type calcBinaryMinus(uint64_t* result, uint64_t left, uint64_t right) {
	*result = left - right;
	Tracer_WriteBinaryOperator(left, "-", right, *result);
	return Expression_Result_Type_Success;
}

// binary multiply handler
Expression_Result_Type calcBinaryMul(uint64_t* result, uint64_t left, uint64_t right) {
	*result = left * right;
	Tracer_WriteBinaryOperator(left, "*", right, *result);
	return Expression_Result_Type_Success;
}

// binary divide handler
Expression_Result_Type calcBinaryDiv(uint64_t* result, uint64_t left, uint64_t right) {
	if (right == 0)
		return Expression_Result_Type_Divsion_0;

	*result = left / right;
	Tracer_WriteBinaryOperator(left, "/", right, *result);
	return Expression_Result_Type_Success;
}

// binary modulo handler
Expression_Result_Type calcBinaryMod(uint64_t* result, uint64_t left, uint64_t right) {
	if (right == 0)
		return Expression_Result_Type_Divsion_0;

	*result = left % right;
	Tracer_WriteBinaryOperator(left, "%", right, *result);
	return Expression_Result_Type_Success;
}

// binary xor handler
Expression_Result_Type calcBinaryXor(uint64_t* result, uint64_t left, uint64_t right) {
	*result = left ^ right;
	Tracer_WriteBinaryOperator(left, "^", right, *result);
	return Expression_Result_Type_Success;
}

// binary or handler
Expression_Result_Type calcBinaryOr(uint64_t* result, uint64_t left, uint64_t right) {
	*result = left | right;
	Tracer_WriteBinaryOperator(left, "|", right, *result);
	return Expression_Result_Type_Success;
}

// binary and handler
Expression_Result_Type calcBinaryAnd(uint64_t* result, uint64_t left, uint64_t right) {
	*result = left & right;
	Tracer_WriteBinaryOperator(left, "&", right, *result);
	return Expression_Result_Type_Success;
}

// binary shift left handler
Expression_Result_Type calcBinaryShiftLeft(uint64_t* result, uint64_t left, uint64_t right) {
	*result = left << right;
	Tracer_WriteBinaryOperator(left, "<<", right, *result);
	return Expression_Result_Type_Success;
}

// binary shift right handler
Expression_Result_Type calcBinaryShiftRight(uint64_t* result, uint64_t left, uint64_t right) {
	*result = left >> right;
	Tracer_WriteBinaryOperator(left, ">>", right, *result);
	return Expression_Result_Type_Success;
}

// binary logical and handler
Expression_Result_Type calcBinaryLogAnd(uint64_t* result, uint64_t left, uint64_t right) {
	*result = EXPRESSION_GET_BOOL(left && right);
	Tracer_WriteBinaryOperator(left, "&&", right, *result);
	return Expression_Result_Type_Success;
}

// binary logical or handler
Expression_Result_Type calcBinaryLogOr(uint64_t* result, uint64_t left, uint64_t right) {
	*result = EXPRESSION_GET_BOOL(left || right);
	Tracer_WriteBinaryOperator(left, "||", right, *result);
	return Expression_Result_Type_Success;
}

// binary equals handler
Expression_Result_Type calcBinaryEquals(uint64_t* result, uint64_t left, uint64_t right) {
	*result = EXPRESSION_GET_BOOL(left == right);
	Tracer_WriteBinaryOperator(left, "==", right, *result);
	return Expression_Result_Type_Success;
}

// binary not equals handler
Expression_Result_Type calcBinaryNotEquals(uint64_t* result, uint64_t left, uint64_t right) {
	*result = EXPRESSION_GET_BOOL(left != right);
	Tracer_WriteBinaryOperator(left, "!=", right, *result);
	return Expression_Result_Type_Success;
}

// binary less than handler
Expression_Result_Type calcBinaryLessThan(uint64_t* result, uint64_t left, uint64_t right) {
	*result = EXPRESSION_GET_BOOL(left < right);
	Tracer_WriteBinaryOperator(left, "<", right, *result);
	return Expression_Result_Type_Success;
}

// binary less than or equals handler
Expression_Result_Type calcBinaryLessThanEquals(uint64_t* result, uint64_t left, uint64_t right) {
	*result = EXPRESSION_GET_BOOL(left <= right);
	Tracer_WriteBinaryOperator(left, "<=", right, *result);
	return Expression_Result_Type_Success;
}

// binary greater than handler
Expression_Result_Type calcBinaryGreaterThan(uint64_t* result, uint64_t left, uint64_t right) {
	*result = EXPRESSION_GET_BOOL(left > right);
	Tracer_WriteBinaryOperator(left, ">", right, *result);
	return Expression_Result_Type_Success;
}

// binary greater than or equals handler
Expression_Result_Type calcBinaryGreaterThanEquals(uint64_t* result, uint64_t left, uint64_t right) {
	*result = EXPRESSION_GET_BOOL(left >= right);
	Tracer_WriteBinaryOperator(left, ">=", right, *result);
	return Expression_Result_Type_Success;
}

/**
 * Unary operator calculations
 */

// unary not handler
Expression_Result_Type calcUnaryNot(uint64_t* result, uint64_t right) {
	*result = ~right;
	Tracer_WriteUnaryOperator("~", right, *result);
	return Expression_Result_Type_Success;
}

// unary minus handler
Expression_Result_Type calcUnaryMinus(uint64_t* result, uint64_t right) {
	*result = -right;
	Tracer_WriteUnaryOperator("-", right, *result);
	return Expression_Result_Type_Success;
}

// unary logical not handler
Expression_Result_Type calcUnaryLogNot(uint64_t* result, uint64_t right) {
	*result = EXPRESSION_GET_BOOL(!right);
	Tracer_WriteUnaryOperator("!", right, *result);
	return Expression_Result_Type_Success;
}

#pragma endregion
#pragma region Evaluate Main Token Groups

/**
 * Evaluate tokens
 */

// helper function to load operators values
c_inline Expression_Result_Type loadOperatorValue(TokenTable* table, EvaluateToken* item, uint64_t* value) {
	*value = 0;

	// first make sure its not NULL ffs
	if (item == NULL) {
		table->expEnd++;
		return Expression_Result_Type_EOL;
	}

	// try to convert to number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, value, 8, item);

	if (result != Expression_Result_Type_Success) {
		// flag this symbol if result is not OK
		table->evalStart = table->expStart = item->start;
		table->evalEnd = table->expEnd = item->end;
	}

	return result;
}

// function to handle operator conversions
Expression_Result_Type handleOperator(TokenTable* table, EvaluateToken* item, EvaluateToken** end) {
	table->expStart = item->start;
	table->expEnd = item->end;

	// load rightmost value
	Expression_Result_Type res = Expression_Result_Type_Success;
	uint64_t right;
	Expression_Result_Type result = loadOperatorValue(table, item->next, &right);
	getResult(result, res);

	// functions for operator types
	Expression_Result_Type (*unaryOpFunc)(uint64_t * result, uint64_t right) = NULL;
	Expression_Result_Type (*binaryOpFunc)(uint64_t * result, uint64_t left, uint64_t right) = NULL;

	// fetch unary operator function
	switch (item->type) {
		case Expression_Token_Type_Unary_Minus:
			unaryOpFunc = &calcUnaryMinus;
			break;
		case Expression_Token_Type_Unary_Not:
			unaryOpFunc = &calcUnaryNot;
			break;
		case Expression_Token_Type_Unary_Logical_Not:
			unaryOpFunc = &calcUnaryLogNot;
			break;
	}

	uint64_t value;

	if (unaryOpFunc != NULL) {
		table->expStart = item->start;
		table->expEnd = item->next->end;

		// handle binary operation
		result = unaryOpFunc(&value, right);
		getResult(result, res);

		// special check for end
		if (*end == item->next) {
			*end = item;
		}

		// prepare the main item
		item->end = item->next->end;
		item->type = Expression_Token_Type_Number;
		item->value = value;
		item->next = item->next->next;

		if (item->next != NULL) {
			item->next->prev = item;
		}
		return res;
	}

	// load leftmost value
	uint64_t left;
	result = loadOperatorValue(table, item->prev, &left);
	getResult(result, res);

	// fetch binary operator function
	switch (item->type) {
		case Expression_Token_Type_Plus:
			binaryOpFunc = &calcBinaryPlus;
			break;
		case Expression_Token_Type_Minus:
			binaryOpFunc = &calcBinaryMinus;
			break;
		case Expression_Token_Type_Multiply:
			binaryOpFunc = &calcBinaryMul;
			break;
		case Expression_Token_Type_Divide:
			binaryOpFunc = &calcBinaryDiv;
			break;
		case Expression_Token_Type_Modulo:
			binaryOpFunc = &calcBinaryMod;
			break;

		case Expression_Token_Type_Xor:
			binaryOpFunc = &calcBinaryXor;
			break;
		case Expression_Token_Type_Or:
			binaryOpFunc = &calcBinaryOr;
			break;
		case Expression_Token_Type_And:
			binaryOpFunc = &calcBinaryAnd;
			break;
		case Expression_Token_Type_ShiftL:
			binaryOpFunc = &calcBinaryShiftLeft;
			break;
		case Expression_Token_Type_ShiftR:
			binaryOpFunc = &calcBinaryShiftRight;
			break;

		case Expression_Token_Type_Logical_And:
			binaryOpFunc = &calcBinaryLogAnd;
			break;
		case Expression_Token_Type_Logical_Or:
			binaryOpFunc = &calcBinaryLogOr;
			break;
		case Expression_Token_Type_CmpEQ:
			binaryOpFunc = &calcBinaryEquals;
			break;
		case Expression_Token_Type_CmpNEQ:
			binaryOpFunc = &calcBinaryNotEquals;
			break;

		case Expression_Token_Type_CmpLT:
			binaryOpFunc = &calcBinaryLessThan;
			break;
		case Expression_Token_Type_CmpLTE:
			binaryOpFunc = &calcBinaryLessThanEquals;
			break;
		case Expression_Token_Type_CmpGT:
			binaryOpFunc = &calcBinaryGreaterThan;
			break;
		case Expression_Token_Type_CmpGTE:
			binaryOpFunc = &calcBinaryGreaterThanEquals;
			break;
	}

	table->expStart = item->prev->start;
	table->expEnd = item->next->end;

	if (binaryOpFunc != NULL) {
		// handle binary operation
		result = binaryOpFunc(&value, left, right);
		getResult(result, res);

		// special check for end
		if (*end == item->next) {
			*end = item->prev;
		}

		// prepare the main item
		item->prev->end = item->next->end;
		item->prev->type = Expression_Token_Type_Number;
		item->prev->value = value;
		item->prev->next = item->next->next;

		if (item->next->next != NULL) {
			item->next->next->prev = item->prev;
		}

		return res;
	}

	return Expression_Result_Type_Op_Not_Binary;
}

// function to get the precende of an operator
c_inline uint16_t getPrecedence(EvaluateToken* item) {
	if (item->type >= Expression_Token_Type_CmpEQ) {
		return (uint16_t)item->value;
	}

	return UINT16_MAX;
}

// function to evaluate area inside parenthesis
Expression_Result_Type evaluateParens(TokenTable* table, EvaluateToken* start, EvaluateToken* end) {
	Expression_Result_Type result = Expression_Result_Type_Success, res = Expression_Result_Type_Success;

	// run while there are more than 1 token left
	while (start != end) {
		// find the highest precendence operation
		EvaluateToken* token = NULL;
		uint16_t best = UINT16_MAX;

		for (EvaluateToken* pos = start; pos != NULL && pos->prev != end; pos = pos->next) {
			// check if the precende of this operator is higher
			uint16_t prec = getPrecedence(pos);

			if (pos->type >= Expression_Token_Type_Unary_Minus ? (prec <= best) : (prec < best)) {
				// save new token with lowest precendece
				best = prec;
				token = pos;
			}
		}

		if (token == NULL) {
			// uhh wat
			Error_ErrorUnderline(buffers.line, start->start, end->end, "m8 what did you do");
		}

		// handle operator conversion
		result = handleOperator(table, token, &end);
		getResult(result, res);
	}

	return res;
}

// helper function to scan item depth
c_inline int8_t evaluateTokenDepth(EvaluateToken* scan) {
	switch (scan->type) {
		case Expression_Token_Type_Paren_Open:
		case Expression_Token_Type_Paren_Closed:
		case Expression_Token_Type_NumSign:
		case Expression_Token_Type_Comma:
		case Expression_Token_Type_Dot:
			return (int8_t)scan->value; // these token values store the depth
	}

	return -1;
}

#pragma endregion
#pragma region Evaluate Functions

// helper function to evaluate function call
Expression_Result_Type evaluateFunction(TokenTable* table, EvaluateToken* start, EvaluateToken** end) {
	table->expStart = start->start;

	// skip the first token
	if (start->next == NULL) {
		table->expEnd = table->expStart = start->start + 1;
		return Expression_Result_Type_EOL;
	}

	// get function
	EvaluateToken* realStart = start;
	Symbol* func;
	Expression_Result_Type result = Expression_FetchSymbolByToken(start, &func);

	if (result != Expression_Result_Type_Success) {
		return result;
	}

	if (start->next == NULL) {
		table->expEnd = table->expStart = start->start + 1;
		return Expression_Result_Type_EOL;
	}

	start = start->next;

	// get size string
	uint8_t* size = (uint8_t*)"";
	uint32_t sizelen = 0;

	if (start->type == Expression_Token_Type_Func_Size) {
		sizelen = start->string->length;
		size = start->string->string;
		Tracer_WriteFunctionSize(func, size);

		if (start->next == NULL) {
			table->expEnd = table->expStart = start->start + 1;
			return Expression_Result_Type_EOL;
		}

		start = start->next;
	}

	// fetch arguments
	EvaluateToken* arg0 = start;

	while (start->type == Expression_Token_Type_Func_Arg) {
		// check the next argument is valid
		if (start->next == NULL) {
			table->expEnd = table->expStart = start->start + 1;
			return Expression_Result_Type_EOL;
		}

		start = start->next;
	}

	// check if this is the end of the list
	if (start->type != Expression_Token_Type_Func_End) {
		table->expEnd = start->start;
		return Expression_Result_Type_Invalid_Func_Call;
	}

	// create the new argument object
	FunctionArguments* argsBefore = Expression_TempFunctionArgs;
	FunctionArguments* _args = malloc(sizeof(FunctionArguments) + sizelen + 1 + (sizeof(FunctionArg) * start->value));

	if (!_args) {
		return Expression_Result_Type_Malloc_Fail;
	}

	// set argument stuff up
	_args->funcStart = table->expStart;
	_args->funcEnd = start->end;
	_args->count = start->value;
	_args->position = 0;

	// update pointers
	_args->arguments = (FunctionArg*)((uint8_t*)_args + sizeof(FunctionArguments));
	_args->size = (uint8_t*)((uint8_t*)_args + sizeof(FunctionArguments) + (sizeof(FunctionArg) * start->value));

	// reset stuff
	memset(&_args->result, 0, sizeof(EvaluateToken));
	memcpy(_args->size, size, sizelen + 1);
	_args->result.type = Expression_Token_Type_Null;

	// copy arguments
	for (uint64_t i = 0; i < start->value; i++) {
		_args->arguments[i].text = arg0[i].string->string;
		_args->arguments[i].line = arg0[i].string->string - (arg0->start - buffers.line);
		Tracer_WriteFunctionArgument(func, arg0[i].string->string, i);
	}

	// call function
	Expression_TempFunctionArgs = _args;
	func->functionPtr(NULL, func->extraParam);
	Expression_TempFunctionArgs = argsBefore;

	// check return value
	if (_args->result.type == Expression_Token_Type_Null) {
		table->expEnd = start->end;
		free(_args);
		return Expression_Result_Type_Func_Void;
	}

	// transform function call token
	realStart->type = _args->result.type;
	realStart->value = _args->result.value;
	realStart->end = start->end;

	// special check for end
	if (*end == start) {
		*end = realStart;
	}

	// fix links
	realStart->next = start->next;

	if (start->next != NULL) {
		start->next->prev = realStart;
	}

	// free memory used by the arguments
	free(_args);
	return Expression_Result_Type_Success;
}

#pragma endregion
#pragma region Evaluate Main

// evaluate tokens and return a value saying whether it could be evaluated or not
Expression_Result_Type Expression_Evaluate(TokenTable* table, EvaluateToken* start, EvaluateToken* end) {
	// allow error messages to work properly
	table->expStart = table->evalStart = start->start;
	table->expEnd = table->evalEnd = end->end;

	table->result.start = start->start;
	table->result.end = end->end;

	Expression_Result_Type result = Expression_Result_Type_Success, res = Expression_Result_Type_Success;

	// find all function references
	EvaluateToken* scanStart = start;
	EvaluateToken* scanEnd;

	while (scanStart != NULL) {
		if (scanStart->type == Expression_Token_Type_Func_Start) {
			// handle function call
			result = evaluateFunction(table, scanStart, &end);
			getResult(result, res);
		}

		// check the end of the scan area
		if (scanStart == end) {
			break;
		}

		scanStart = scanStart->next;
	}

	// solve each depth separately
	int8_t de;

	for (int8_t depth = table->maxDepth; depth > 0; --depth) {
		// scan for items at this depth
		scanStart = start;

		while (scanStart != NULL) {
			de = evaluateTokenDepth(scanStart);

			if (de != depth) {
				// check the end of the scan area
				if (scanStart == end) {
					goto nextloop;
				}

				scanStart = scanStart->next;
				continue;
			}

			// correct depth, find end
			scanEnd = scanStart->next;

			while (scanEnd != NULL) {
				de = evaluateTokenDepth(scanEnd);

				// check the end of the scan area
				if ((de >= 0 && de != depth) || scanEnd == end) {
					break;
				}

				// scan the next item
				scanEnd = scanEnd->next;
			}

			// check if the last item was actually a paren
			if (scanEnd->type != Expression_Token_Type_Paren_Closed) {
				table->expStart = scanEnd->end;
				table->expEnd = scanEnd->end + 1;
				return Expression_Result_Type_Not_Closed;
			}

			// check if there is anything inside the parens
			if (scanStart->next == scanEnd) {
				table->expStart = scanStart->start;
				table->expEnd = scanEnd->end;
				return Expression_Result_Type_Empty_Parens;
			}

			// process the area
			result = evaluateParens(table, scanStart->next, scanEnd->prev);
			getResult(result, res);

			// special check for end
			if (end == scanEnd) {
				end = scanStart;
			}

			// remove parenthesis
			scanStart->end = scanEnd->end;
			scanStart->type = scanStart->next->type;
			scanStart->value = scanStart->next->value;
			scanStart->next = scanEnd->next;
			scanStart->extra = scanEnd->extra;

			if (scanStart->next != NULL) {
				scanStart->next->prev = scanStart;
			}

			// re-check depth
			++depth;
			goto nextloop;
		}

	nextloop:;
	}

	// process all remaining tokens
	result = evaluateParens(table, start, end);
	getResult(result, res);

	// process result
	table->result = *start;
	return res;
}

/*
+ *(pc)
+ 1(a0)
? 1(whatever)
+ 1+(whatever)
+ (label)(a0)
- (label)(1234)
? 1+2+3+4(d0)
+ function(1)(a0)
- register(a0)(a0)
+ (function(1))
+ (function(1, d0), d0.w)
+ (a0, function(1).w)
+ 1*2(a0)
- 1*(a0)
- *1(a0)
- *function(0)(a0)
+ *+function(0)(a0)
- function(0)*(a0)
- function(0),(a0)
- function(0)a0
- (function(0),function(0),a0.w)
+ function(a0)(a1)
? function(a1)

+ global:local(a0, d0.w)

function(labelthatdoesntexistyet)(function(1))

bsr.s    function(valuethatmightchange, unknownvalue)
*/

#pragma endregion
#pragma region Helper functions

/**
 * Clone token table
 */

// count the total num of tokens
c_inline uint32_t countTokens(EvaluateToken* start, EvaluateToken* end) {
	uint32_t count = 1;

	while (start != NULL && start != end) {
		++count;
		start = start->next;
	}

	return count;
}

// clone tokens from tableCopy into an array of tokens
size_t Expression_CloneTokenTable(EvaluateToken** start, EvaluateToken** end) {
	// offset for the copy table
	*start += TOKEN_TABLE_LEN;
	*end += TOKEN_TABLE_LEN;
	return Expression_CloneTokenData(start, end);
}

// clone tokens into an array of tokens
size_t Expression_CloneTokenData(EvaluateToken** start, EvaluateToken** end) {
	// find number of tokens
	uint32_t count = countTokens(*start, *end);

	// allocate us some space
	size_t length = count * sizeof(EvaluateToken);
	EvaluateToken* alloc = malloc(length);

	// check if allocation failed
	if (alloc == NULL) {
		Error_ErrorProgram(ERRTXT_MALLOC_FAIL " ");
	}

	// fill with stuff
	EvaluateToken* cursor = *start;
	EvaluateToken* pos = alloc;
	pos->prev = NULL;

	for (int i = count - 1; i >= 0; --i) {
		// copy params
		pos->type = cursor->type;
		pos->extra = cursor->extra;
		pos->value = cursor->value;
		pos->start = cursor->start;
		pos->end = cursor->end;

		// tie new elements
		if (i != 0) {
			pos->next = pos + 1;
			pos++;
			pos->prev = pos - 1;

			// go to next cursor
			cursor = cursor->next;

		} else {
			pos->next = NULL;
		}
	}

	// tell the new position
	*end = pos;
	*start = alloc;
	return length;
}

/**
 * Function argument parsing
 */

// create a new tokentable
TokenTable* Expression_AllocateTokenTable() {
	TokenTable* ptr = malloc(sizeof(TokenTable));

	if (ptr == NULL) {
		Error_Error(ERRTXT_MALLOC_FAIL " ");
	}

	ptr->isMalloc = 1;
	return ptr;
}

// delete tokentable
void Expression_FreeTokenTable(TokenTable* table) {
	if (table->isMalloc) {
		free(table);
	}
}

#pragma endregion
#pragma region Function argument handling

// parse function argument
Expression_Result_Type Expression_ParseFunctionArg(TokenTable* table, FunctionArguments* args, uint32_t argn) {
	// check if argument is valid
	argn += args->position;

	if (args->count <= argn) {
		return Expression_Result_Type_Arg_Null;
	}

	// tokenize argument
	table->lineStart = args->arguments[argn].line;
	Expression_Result_Type res = Expression_Tokenize(args->arguments[argn].text, args->arguments[argn].text + strlen((char*)args->arguments[argn].text), table);

	if (res != Expression_Result_Type_Success) {
		return res;
	}

	// evaluate expression
	return Expression_Evaluate(table, table->start, table->end - 1);
}

/**
 * Simple argument parse
 */

// funtion to tokenize operands in the rest of the line
Expression_Result_Type Expression_TokenizeRemainingLine(TokenTable* table, uint8_t* buffer, uint8_t** end) {
	table->lineStart = buffers.line;
	*end = buffer;

	// find eol
	while (**end) {
		(*end)++;
	}

	// tokenize the symbol
	return Expression_Tokenize(buffer, *end, table);
}

// function to find the end of the current operand
EvaluateToken* Expression_FindArgumentEndPosition(TokenTable* table) {
	// find the comma or a NULL
	EvaluateToken* position = table->start;

	// find a comma or a NULL
	while (position < table->end) {
		if (position->type == Expression_Token_Type_Comma && position->value == 0) {
			// commas at depth = 0
			return position;
		}

		position++;
	}

	return position;
}

// function to check if the next operand is a specific addressing mode
EvaluateToken* Expression_FindArgumentEnd(TokenTable* table) {
	// load token range
	EvaluateToken* end = Expression_FindArgumentEndPosition(table);

	// check if argument is invalid
	if (end == table->start) {
		return NULL;
	}

	// return the end value
	return end;
}

#pragma endregion
