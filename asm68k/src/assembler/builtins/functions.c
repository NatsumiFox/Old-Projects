#include <inttypes.h>
#include <setjmp.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <assembler/assembler.h>
#include <assembler/error.h>
#include <assembler/hash.h>
#include <assembler/listings.h>
#include <assembler/object.h>
#include <assembler/parse.h>

#include <asmlink/debug_tracer.h>
#include <asmlink/symbol_ext.h>

#include <lib/compat.h>
#include <lib/expressions.h>
#include <lib/files.h>
#include <lib/messages/expressions.h>

/*
	STRLEN(string) - Return the number of characters in a string
	===========================
*/

void Func_Strlen(uint8_t* buffer, uint32_t param) {
	if (Expression_TempFunctionArgs == NULL) {
		// TODO
		Error_Error("Function arguments is NULL");
	}

	// store reference to Expression_TempFunctionArgs
	FunctionArguments* args = Expression_TempFunctionArgs;

	// parse argument
	TokenTable* table = Expression_AllocateTokenTable();
	int result = Expression_ParseFunctionArg(table, args, 0);

	if (result == Expression_Result_Type_Arg_Null || result == Expression_Result_Type_Arg_Empty) {
		Error_ErrorUnderline(buffers.line, args->funcStart, args->funcEnd, ERRFMT_FUNCARG_EXPECT_STR, 1);
	}

	// check other error
	if (result != Expression_Result_Type_Success) {
		Error_Eval(table, result);
	}

	// try to parse result as a string
	LengthString* str;
	result = Expression_EvaluateAsString(&str, &table->result);

	// check result error
	if (result != Expression_Result_Type_Success) {
		Error_Eval(table, result);
	}

	// save result and free table
	args->result.type = Expression_Token_Type_Number;
	args->result.value = str->length;
	Expression_FreeTokenTable(table);
}

/*
	helper for initializing functions
*/

struct FunctionHelper {
	void (*code)(uint8_t*, uint32_t);

	uint8_t* name;
	uint64_t param;
	uint32_t index;
	uint32_t hash;
};

// clang-format off
struct FunctionHelper funcSymbolList[] = {
	{ .index = BI_strlen, .hash = HASH_strlen, .code = &Func_Strlen, .name = HN_STRLEN, .param = 0, },
	{ .index = BI_STRLEN, .hash = HASH_STRLEN, .code = &Func_Strlen, .name = HN_STRLEN, .param = 0, },
};
// clang-format on

/*
	make and load symbols for this assembler
*/

void createFunctions() {
	// loop through all to add dem symbols
	for (uint64_t i = 0; i < sizeof(funcSymbolList) / sizeof(struct FunctionHelper); i++) {
		SymbolExt_BuiltInTable[funcSymbolList[i].index].hash = funcSymbolList[i].hash;

		// create a new symbol for this
		Symbol* sym = Symbol_FindOrAllocate(funcSymbolList[i].hash, 1);

		if (sym != NULL) {
			// fill its details
			sym->type = Symbol_Type_Function;
			sym->functionPtr = funcSymbolList[i].code;
			sym->extraParam = funcSymbolList[i].param;
			sym->flags = Symbol_Flag_Initialized | Symbol_Flag_Locked;
			sym->name = funcSymbolList[i].name;

			//	Tracer_WriteSymbolAction(0, 0, sym);
		}
	}
}
