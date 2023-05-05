#include <inttypes.h>
#include <setjmp.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include <assembler/assembler.h>
#include <assembler/error.h>
#include <assembler/hash.h>
#include <assembler/listings.h>
#include <assembler/object.h>
#include <assembler/parse.h>

#include <asmlink/symbol_ext.h>

#include <lib/compat.h>
#include <lib/expressions.h>
#include <lib/files.h>

#include <asmlink/debug_tracer.h>

EvaluateToken variableResult;

/*
	_filename - get the current filename
	====================================
*/

EvaluateToken* Var_Filename(uint64_t param) {
	variableResult.string = _filename;
	variableResult.type = Symbol_Type_String_Equate;
	return &variableResult;
}

/*
	Date - Return various parts of the current datetime
	===================================================
	param = 0 - _year
	param = 1 - _month
	param = 2 - _day
	param = 3 - _weekday
	param = 4 - _hour
	param = 5 - _minute
	param = 6 - _second
	param = 7 - _milli
*/

EvaluateToken* Var_Dates(uint64_t param) {
	// fetch the local time
	time_t t = time(NULL);
	struct tm tm = *localtime(&t);

	uint64_t value = 0;

	// fetch the parameter of interest
	switch (param) {
		case 0:
			value = tm.tm_year + 1900;
			break;
		case 1:
			value = tm.tm_mon + 1;
			break;
		case 2:
			value = tm.tm_mday;
			break;
		case 3:
			value = tm.tm_wday == 0 ? 7 : tm.tm_wday;
			break;
		case 4:
			value = tm.tm_hour;
			break;
		case 5:
			value = tm.tm_min;
			break;
		case 6:
			value = tm.tm_sec;
			break;
		case 7:
			value = 0;
			break;
		default:
			break;
	}

	// setup the result
	variableResult.value = value;
	variableResult.type = Symbol_Type_Integer_Equate;
	return &variableResult;
}

/*
	helper for initializing variables
*/

struct VariableHelper {
	EvaluateToken* (*code)(uint64_t);
	uint8_t* name;
	uint64_t param;
	uint32_t index;
	uint32_t hash;
};

// clang-format off
struct VariableHelper varSymbolList[] = {
	// date related
	{ .index = BI__year, .hash = HASH__year, .code = &Var_Dates, .name = HN__YEAR, .param = 0, },
	{ .index = BI__YEAR, .hash = HASH__YEAR, .code = &Var_Dates, .name = HN__YEAR, .param = 0, },
	{ .index = BI__month, .hash = HASH__month, .code = &Var_Dates, .name = HN__MONTH, .param = 1, },
	{ .index = BI__MONTH, .hash = HASH__MONTH, .code = &Var_Dates, .name = HN__MONTH, .param = 1, },
	{ .index = BI__day, .hash = HASH__day, .code = &Var_Dates, .name = HN__DAY, .param = 2, },
	{ .index = BI__DAY, .hash = HASH__DAY, .code = &Var_Dates, .name = HN__DAY, .param = 2, },
	{ .index = BI__weekday, .hash = HASH__weekday, .code = &Var_Dates, .name = HN__WEEKDAY, .param = 3, },
	{ .index = BI__WEEKDAY, .hash = HASH__WEEKDAY, .code = &Var_Dates, .name = HN__WEEKDAY, .param = 3, },

	// time related
	{ .index = BI__hour, .hash = HASH__hour, .code = &Var_Dates, .name = HN__HOUR, .param = 4, },
	{ .index = BI__HOUR, .hash = HASH__HOUR, .code = &Var_Dates, .name = HN__HOUR, .param = 4, },
	{ .index = BI__minute, .hash = HASH__minute, .code = &Var_Dates, .name = HN__MINUTE, .param = 5, },
	{ .index = BI__MINUTE, .hash = HASH__MINUTE, .code = &Var_Dates, .name = HN__MINUTE, .param = 5, },
	{ .index = BI__second, .hash = HASH__second, .code = &Var_Dates, .name = HN__SECOND, .param = 6, },
	{ .index = BI__SECOND, .hash = HASH__SECOND, .code = &Var_Dates, .name = HN__SECOND, .param = 6, },
	{ .index = BI__milli, .hash = HASH__milli, .code = &Var_Dates, .name = HN__MILLI, .param = 7, },
	{ .index = BI__MILLI, .hash = HASH__MILLI, .code = &Var_Dates, .name = HN__MILLI, .param = 7, },

	// misc
	{ .index = BI__filename, .hash = HASH__filename, .code = &Var_Filename, .name = HN__FILENAME, .param = 4, },
	{ .index = BI__FILENAME, .hash = HASH__FILENAME, .code = &Var_Filename, .name = HN__FILENAME, .param = 4, },
};
// clang-format on

/*
	make and load symbols for this assembler
*/

void createVariables() {
	// loop through all to add dem symbols
	for (uint64_t i = 0; i < sizeof(varSymbolList) / sizeof(struct VariableHelper); i++) {
		SymbolExt_BuiltInTable[varSymbolList[i].index].hash = varSymbolList[i].hash;

		// create a new symbol for this
		Symbol* sym = Symbol_FindOrAllocate(varSymbolList[i].hash, 1);

		if (sym != NULL) {
			// fill its details
			sym->type = Symbol_Type_Function_Equate;
			sym->evalPtr = varSymbolList[i].code;
			sym->extraParam = varSymbolList[i].param;
			sym->flags = Symbol_Flag_Initialized | Symbol_Flag_Locked;
			sym->name = varSymbolList[i].name;

			//	Tracer_WriteSymbolAction(0, 0, sym);
		}
	}
}
