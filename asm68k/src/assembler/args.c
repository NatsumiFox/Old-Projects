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
#include <assembler/symbol_file.h>
#include <assembler/messages/misc.h>

#include <asmlink/debug_tracer.h>
#include <asmlink/symbol_ext.h>
#include <asmlink/messages/global.h>

#include <lib/arguments.h>
#include <lib/debug.h>
#include <lib/files.h>
#include <lib/hash_lib.h>
#include <lib/string_lib.h>
#include <lib/messages/global.h>

uint32_t ExtraLinesCount = 0;
uint8_t** ExtraLines = NULL;

#pragma region Opt and commandline shared routines

// function to set the CPU
uint8_t setProcessor(char* string, int mode) {
	// TODO: parse
	options.cpuModel = MC68000;
	options.endianness = 0;
	options.programCounterSymbol = '*';
	return 1;
}

// function to set the local label symbol
void setLocalLabelSymbol(uint8_t symbol) {
	// check for valid symbol
	switch (symbol) {
		case 0:
		case '\n':
		case '\r':
			if (useAsmErrors) {
				Error_Error(ERRTXT_LOCAL_SYMBOL_MISSING);

			} else {
				Error_ErrorProgram(ERRTXT_LOCAL_SYMBOL_MISSING);
			}
			break;

		case ' ':
			if (useAsmErrors) {
				Error_Error(ERRTXT_LOCAL_SYMBOL_SPACE);

			} else {
				Error_ErrorProgram(ERRTXT_LOCAL_SYMBOL_SPACE);
			}
			break;

		default:
			// remove the last local label symbol
			charFlagLUT[options.localLabelSymbol] = options.localSymbolFlags;

			// update the local label symbol, and update flags in the charFlagLUT
			options.localLabelSymbol = symbol;
			options.localSymbolFlags = charFlagLUT[symbol];
			charFlagLUT[options.localLabelSymbol] |= CF_LABEL_FIRST_CHAR | CF_SEPARATOR;
			break;
	}
}

// function to set the symbol format
uint8_t setSymbolFormat(uint8_t* format) {
	uint32_t hash = 0;
	uint8_t* buffer = format;

	// hash the format
	while (*buffer) {
		hash = HASH_GETNEXT(hash, String_LowerCaseLUT[*buffer++]);
	}

	if (hash == HASH_equ) { // two statements now, switch not needed at this moment
		symbolFormat = SYM_FMT_EQU;

	} else {
		return 0;
	}
	//	switch (hash) {
	//		case HASH_equ:
	//			symbolFormat = SYM_FMT_EQU;
	//			break;
	//
	//		default:
	//			return 0;
	//	}

	return 1;
}

#pragma endregion
#pragma region Parse Arguments

uint8_t paramId = 0;
uint32_t positionalArg = 0;

// function to process the end of the argument list
enum Arguments_ReturnType processArgumentsEnd(char* text) {
	switch (positionalArg) {
		case 0:
			fprintf(stderr, ERRFMT_EXPECTED_PARAM_HERE, ERRSTR_TYPE_SOURCE);
			break;

		case 1:
			fprintf(stderr, ERRFMT_EXPECTED_PARAM_HERE, ERRSTR_TYPE_OBJECT);
			break;

		case 2:
			return Arguments_ReturnType_OK;

		default:
			break;
	}

	return Arguments_ReturnType_Error;
}

// function to process the next positional argument
enum Arguments_ReturnType processPositionalArgument(char* text) {
	switch (positionalArg) {
		case 0:
			sourcePath = text;
			break;
		case 1:
			objectPath = text;
			break;
		default:
			fputs(ERRTXT_UNKNOWN_POS_ARGUMENT, stderr);
			return Arguments_ReturnType_Error;
	}

	positionalArg++;
	return Arguments_ReturnType_OK;
}

// function to process the next flag argument
enum Arguments_ReturnType processPlusMinusArgument(uint8_t value, char* text) {
	if (strcasecmp(text, "omq") == 0) {
		options.optimizeMOVEQ = value;

	} else if (strcasecmp(text, "oaq") == 0) {
		options.optimizeADDQ = value;

	} else if (strcasecmp(text, "opc") == 0) {
		options.optimizePCRelative = value;

	} else if (strcasecmp(text, "os") == 0) {
		options.optimizeShortBranch = value;

	} else if (strcasecmp(text, "ow") == 0) {
		options.optimizeWordAddr = value;

	} else if (strcasecmp(text, "oz") == 0) {
		options.optimizeZeroOffset = value;

	} else if (strcasecmp(text, "ae") == 0) {
		options.automaticEvens = value;

	} else if (strcasecmp(text, "an") == 0) {
		options.alternateNums = value;

	} else if (strstr(text, "lc") != NULL) {		// TODD: fix case sensitive
		setLocalLabelSymbol(text[2]);

	} else if (strcasecmp(text, "w") == 0) {
		options.printWarnings = value;

	} else if (strcasecmp(text, "d") == 0) {
		options.descopeLabels = 1;

	} else if (strcasecmp(text, "c") == 0) {
		options.caseSensitive = value;
		caseLUT = value ? caseSensitiveLUT : caseInsensitiveLUT;

	} else if (strcasecmp(text, "q") == 0) {
		quietMode = 1;

	} else if (strcasecmp(text, "m") == 0) {
		expandMacros = 1;

	} else if (strcasecmp(text, "p") == 0) {
		fprintf(stderr, ERRFUN_OPTION_NOT_IMPLEMENTED("-"), "p");
		return Arguments_ReturnType_Error;

	} else if (strcasecmp(text, "k") == 0) {
		fprintf(stderr, ERRFUN_OPTION_NOT_IMPLEMENTED("-"), "k");
		return Arguments_ReturnType_Error;

	} else if (strcasecmp(text, "i") == 0) {
		paramId = 0;
		return Arguments_ReturnType_Param;

	} else if (strcasecmp(text, "e") == 0) {
		paramId = 1;
		return Arguments_ReturnType_Param;

	} else {
		fprintf(stderr, ERRFUN_OPTION_NOT_RECOGNIZED("-"), text);
		return Arguments_ReturnType_Error;
	}

	return Arguments_ReturnType_OK;
}

// function to process the next flag argument
enum Arguments_ReturnType processFlagArgument(char* text) {
	if (strcasecmp(text, "cpu") == 0) {
		paramId = 2;
		return Arguments_ReturnType_Param;

	} else if (strcasecmp(text, "fpu") == 0) {
		paramId = 3;
		return Arguments_ReturnType_Param;

	} else if (strcasecmp(text, "include") == 0) {
		paramId = 0;
		return Arguments_ReturnType_Param;

	} else if (strcasecmp(text, "quiet") == 0) {
		quietMode = 1;

	} else if (strcasecmp(text, "macros") == 0) {
		expandMacros = 1;

	} else if (strcasecmp(text, "lst") == 0) {
		paramId = 4;
		return Arguments_ReturnType_Param;

	} else if (strcasecmp(text, "sym") == 0) {
		paramId = 5;
		return Arguments_ReturnType_Param;

	} else if (strcasecmp(text, "sf") == 0) {
		paramId = 6;
		return Arguments_ReturnType_Param;

#if defined(TRACER)
	} else if (strcasecmp(text, "trace") == 0) {
		paramId = 7;
		return Arguments_ReturnType_Param;
#endif

	} else {
		fprintf(stderr, ERRFUN_OPTION_NOT_RECOGNIZED("--"), text);
		return Arguments_ReturnType_Error;
	}

	return Arguments_ReturnType_OK;
}

// function to process the next argument that is related to a flag
enum Arguments_ReturnType processParamArgument(char* text) {
	switch (paramId) {
		case 0: // include path
			addIncludePath((uint8_t*)text);
			return Arguments_ReturnType_OK;

		case 1: // expression add
			// allocate more space for extra lines
			ExtraLinesCount++;
			ExtraLines = realloc(ExtraLines, sizeof(uint8_t**) * ExtraLinesCount);

			// check if allocation failed
			if (ExtraLines == NULL) {
				Error_ErrorProgram(ERRTXT_MALLOC_FAIL " ");
			}

			// save the string now
			ExtraLines[ExtraLinesCount - 1] = (uint8_t*)text;
			return Arguments_ReturnType_OK;

		case 2: // cpu set
			if (setProcessor(text, 0)) {
				return Arguments_ReturnType_OK;
			}

			fprintf(stderr, ERRFUN_CPUFPU_MODEL_UNSUPPORTED(ERRSTR_TYPE_CPU), text);
			return Arguments_ReturnType_Error;

		case 3: // fpu set
			if (setProcessor(text, 1)) {
				return Arguments_ReturnType_OK;
			}

			fprintf(stderr, ERRFUN_CPUFPU_MODEL_UNSUPPORTED(ERRSTR_TYPE_FPU), text);
			return Arguments_ReturnType_Error;

		case 4: // listings file set
			listingPath = text;
			return Arguments_ReturnType_OK;

		case 5: // symbol file set
			symbolPath = text;
			return Arguments_ReturnType_OK;

		case 6: // symbol format set
			if (setSymbolFormat((uint8_t*)text)) {
				return Arguments_ReturnType_OK;
			}

			fprintf(stderr, ERRFMT_UNKNOWN_SYMBOT_FORMAT, text);
			return Arguments_ReturnType_Error;

#if defined(TRACER)
		case 7: // trace file set
			Tracer_FilePath = text;
			return Arguments_ReturnType_OK;
#endif

		default:
			break;
	}

	return Arguments_ReturnType_Bail;
}

// function to process the missing text argument
enum Arguments_ReturnType processMissingArgument(char* text) {
	switch (paramId) {
		case 0:
			fprintf(stderr, ERRFUN_EXPECTED_PARAM_FOR(ERRSTR_TYPE_PATH), "--include/-i");
			break;
		case 1:
			fprintf(stderr, ERRFUN_EXPECTED_PARAM_FOR(ERRSTR_TYPE_EQUVALUE), "-e");
			break;
		case 2:
			fprintf(stderr, ERRFUN_EXPECTED_PARAM_FOR(ERRSTR_TYPE_MODEL), "--cpu");
			break;
		case 3:
			fprintf(stderr, ERRFUN_EXPECTED_PARAM_FOR(ERRSTR_TYPE_MODEL), "--fpu");
			break;
		case 4:
			fprintf(stderr, ERRFUN_EXPECTED_PARAM_FOR(ERRSTR_TYPE_FILE), "--lst");
			break;
		case 5:
			fprintf(stderr, ERRFUN_EXPECTED_PARAM_FOR(ERRSTR_TYPE_FILE), "--sym");
			break;
		case 6:
			fprintf(stderr, ERRFUN_EXPECTED_PARAM_FOR(ERRSTR_TYPE_FORMAT), "--sf");
			break;
#if defined(TRACER)
		case 7:
			fprintf(stderr, ERRFUN_EXPECTED_PARAM_FOR(ERRSTR_TYPE_FILE), "--trace");
			break;
#endif
		default:
			break;
	}

	return Arguments_ReturnType_Error;
}

// function to process commandline parameters
enum Arguments_ReturnType processParams(enum Arguments_Mode mode, char* text) {
	switch (mode) {
		case Arguments_Mode_Text:
			return processPositionalArgument(text);
		case Arguments_Mode_Param:
			return processParamArgument(text);
		case Arguments_Mode_Flag:
			return processFlagArgument(text);
		case Arguments_Mode_Plus:
			return processPlusMinusArgument(1, text);
		case Arguments_Mode_Minus:
			return processPlusMinusArgument(0, text);
		case Arguments_Mode_Null:
			return processMissingArgument(text);
		case Arguments_Mode_End:
			return processArgumentsEnd(text);
		default:
			break;
	}

	return Arguments_ReturnType_Bail;
}

// process commandline arguments
void loadCommandLine(int argc, char* argv[]) {
	// initialize options
	expandMacros = 0;
	quietMode = 0;

	options.automaticEvens = 1;
	options.alternateNums = 1;
	options.caseSensitive = 0;
	caseLUT = caseInsensitiveLUT;
	options.descopeLabels = 0;
	options.fillChar = 0x00;
	setProcessor("MC68000", 0);

	// initialize local label symbol
	options.localLabelSymbol = 0;
	options.localSymbolFlags = charFlagLUT[0];
	setLocalLabelSymbol('.');

	// handle arguments
	if (!Arguments_Process(MSGTXT_PROGRAM_USAGE, argc, argv, processParams)) {
		Error_Exit(2);
	}
}

#pragma endregion
