#if !defined(INCLUDE_ASSEMBLER_EXPRESSIONS_H)
#define INCLUDE_ASSEMBLER_EXPRESSIONS_H

#include <stdint.h>
#include <stdio.h>
#include <stddef.h>

#include <lib/compat.h>
#include <lib/lengthstring.h>
#include <lib/symbols.h>

// size of the token table
#define TOKEN_TABLE_MAX 254
#define TOKEN_TABLE_LEN 256
#define MAX_DEPTH 120

typedef enum {
	Expression_Eval_State_Unary,
	Expression_Eval_State_Binary,
	Expression_Eval_State_Function,

} Expression_Eval_State;

/**
 * struct for single function argument data
 */
typedef struct {
	uint8_t* text; // actual text for the argument
	uint8_t* line; // beginning of line (only for underlining!)

} FunctionArg;

/**
 * struct for all function arguments
 */

typedef struct {
	uint8_t* funcStart; // beginning of function text
	uint8_t* funcEnd;		// end of function text

	uint32_t count;
	uint32_t position; // for shift
	uint8_t* size;		 // strlen.<size> basically
	FunctionArg* arguments;
	EvaluateToken result;

} FunctionArguments;

// table of tokens
typedef struct {
	EvaluateToken table[TOKEN_TABLE_LEN];
	EvaluateToken tableCopy[TOKEN_TABLE_LEN];
	EvaluateToken* start;
	EvaluateToken* end;
	EvaluateToken* endCopy;

	uint8_t* lineStart;
	uint8_t* expStart;
	uint8_t* expEnd;
	uint8_t* evalStart;
	uint8_t* evalEnd;

	EvaluateToken result;
	uint64_t evalValue;
	Expression_Eval_State state;
	int8_t depth;
	int8_t maxDepth;
	uint8_t isMalloc;

} TokenTable;

extern TokenTable macroTable;

#define OH_NO_DOTS_WONT_WORK_HERE // force : to be used in global.local statements because I'm bad at programming :-)

// macros to define more complex expression parsing tasks
#define fetchArgumentAsStringPass1(table, string, argend, result, eol, evalErr) \
	argend = Expression_FindArgumentEnd(&(table));                                             \
	if ((argend) == NULL) {                                                       \
		eol;                                                                        \
	}                                                                             \
	(result) = Expression_Evaluate(&(table), (table).start, (argend)-1);                     \
	if ((result) != Expression_Result_Type_Success) {                                               \
		evalErr;                                                                    \
	}                                                                             \
	(result) = Expression_EvaluateAsString(&(string), &(table).result);                      \
	if ((result) != Expression_Result_Type_Success) {                                               \
		evalErr;                                                                    \
	}                                                                             \
	(table).start = (argend) + 1;

#define fetchArgumentAsNumberPass1(table, value, max, argend, result, eol, evalErr) \
	argend = Expression_FindArgumentEnd(&(table));                                                 \
	if ((argend) == NULL) {                                                           \
		eol;                                                                            \
	}                                                                                 \
	(result) = Expression_Evaluate(&(table), (table).start, (argend)-1);                         \
	if ((result) != Expression_Result_Type_Success) {                                                   \
		evalErr;                                                                        \
	}                                                                                 \
	(result) = Expression_EvaluateAsNumber(&(table), &(value), max, &(table).result);            \
	if ((result) != Expression_Result_Type_Success) {                                                   \
		evalErr;                                                                        \
	}                                                                                 \
	(table).start = (argend) + 1;

#define getResult(result, res)   \
	if ((result) > Expression_Result_Type_Success) { \
		return result;               \
	}                              \
	if ((result) < Expression_Result_Type_Success) { \
		(res) = result;              \
	}

// function variables
extern FunctionArguments* Expression_TempFunctionArgs;

void Expression_WriteErrorCode(FILE* target, TokenTable* table, Expression_Result_Type error);

Expression_Result_Type Expression_Tokenize(uint8_t* start, uint8_t* end, TokenTable* table);

Expression_Result_Type Expression_Evaluate(TokenTable* table, EvaluateToken* start, EvaluateToken* end);

size_t Expression_CloneTokenTable(EvaluateToken** start, EvaluateToken** end);

size_t Expression_CloneTokenData(EvaluateToken** start, EvaluateToken** end);

Expression_Result_Type Expression_ParseFunctionArg(TokenTable* table, FunctionArguments* args, uint32_t argn);

TokenTable* Expression_AllocateTokenTable();

void Expression_FreeTokenTable(TokenTable* table);

Expression_Result_Type Expression_EvaluateAsString(LengthString** value, EvaluateToken* token);

Expression_Result_Type Expression_TokenizeRemainingLine(TokenTable* table, uint8_t* buffer, uint8_t** end);

Expression_Result_Type Expression_FetchSymbolByToken(EvaluateToken* token, Symbol** symbol);

Expression_Result_Type Expression_FetchSymbolByHash(uint64_t hashes, uint8_t mode, Symbol** symbol);

EvaluateToken* Expression_FindArgumentEndPosition(TokenTable* table);

EvaluateToken* Expression_FindArgumentEnd(TokenTable* table);

Expression_Result_Type Expression_EvaluateAsNumber(TokenTable* table, uint64_t* value, uint32_t maxString, EvaluateToken* token);

Expression_Result_Type Expression_EvaluateAsQuad(TokenTable* table, uint64_t* value, uint64_t offset);

Expression_Result_Type Expression_EvaluateAsUint32(TokenTable* table, uint32_t* value, uint64_t offset);

Expression_Result_Type Expression_EvaluateAsInt32(TokenTable* table, int32_t* value, int64_t offset);

Expression_Result_Type Expression_EvaluateAsLong(TokenTable* table, uint32_t* value, uint64_t offset);

Expression_Result_Type Expression_EvaluateAsUint16(TokenTable* table, uint16_t* value, uint64_t offset);

Expression_Result_Type Expression_EvaluateAsInt16(TokenTable* table, int16_t* value, int64_t offset);

Expression_Result_Type Expression_EvaluateAsWord(TokenTable* table, uint16_t* value, uint64_t offset);

Expression_Result_Type Expression_EvaluateAsUint8(TokenTable* table, uint8_t* value, uint64_t offset);

Expression_Result_Type Expression_EvaluateAsInt8(TokenTable* table, int8_t* value, int64_t offset);

Expression_Result_Type Expression_EvaluateAsByte(TokenTable* table, uint8_t* value, uint64_t offset);

Expression_Result_Type Expression_EvaluateAsUint4(TokenTable* table, uint8_t* value, uint64_t offset);

Expression_Result_Type Expression_EvaluateAsInt4(TokenTable* table, int8_t* value, int64_t offset);

Expression_Result_Type Expression_EvaluateAsNibble(TokenTable* table, uint8_t* value, uint64_t offset);

#endif // INCLUDE_ASSEMBLER_EXPRESSIONS_H
