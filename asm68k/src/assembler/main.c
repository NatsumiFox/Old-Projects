#include <setjmp.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include <assembler/68k/68000.h>
#include <assembler/args.h>
#include <assembler/assembler.h>
#include <assembler/error.h>
#include <assembler/hash.h>
#include <assembler/listings.h>
#include <assembler/object.h>
#include <assembler/parse.h>
#include <assembler/pass2.h>
#include <assembler/symbol_file.h>
#include <assembler/messages/misc.h>

#include <assembler/builtins/directives.h>
#include <assembler/builtins/functions.h>
#include <assembler/builtins/variables.h>

#include <asmlink/debug_tracer.h>
#include <asmlink/symbol_ext.h>

#include <lib/compat.h>
#include <lib/debug.h>
#include <lib/error_lib.h>
#include <lib/messages/global.h>
#include <lib/expressions.h>
#include <lib/files.h>

#ifdef X86
uint32_t parseStackPtr; // stack pointer that contains stack at parseAsmFile()
uint32_t parseJumpPtr;	// jump pointer that contains target after parsing is done at parseAsmFile()
#endif

#ifdef X64
uint64_t parseStackPtr; // stack pointer that contains stack at parseAsmFile()
uint64_t parseJumpPtr;	// jump pointer that contains target after parsing is done at parseAsmFile()
#endif

char* sourcePath;
uint8_t* caseLUT;

Options options;
uint8_t expandMacros;
uint8_t quietMode;
int8_t pass;

LineBuffers buffers;
uint32_t labelHash;
uint8_t hasLabel;
int32_t labelNameLength;
uint8_t* labelNameBuffer;
uint8_t* funcNameBufStart;

int main(int argc, char* argv[]) {
	// setup error handlers
	Error_WarnHandler = &Error_WarnNormalFunc;
	Error_ErrorHandler = &Error_ErrorNormalFunc;
	Error_FatalHandler = &Error_FatalNormalFunc;
	Error_ExitHandler = &Error_ExitNormalFunc;
	Error_WarnUnderlineHandler = &Error_WarnUnderlineFunc;
	Error_ErrorUnderlineHandler = &Error_ErrorUnderlineFunc;

#ifdef DEBUG
	initDebug();
#endif

	macroTable.isMalloc = 0;
	pass = 0;
	initIncludePaths();

	// load commandline parameters
	loadCommandLine(argc, argv);

	Tracer_OpenFile();

	// print program name
	if (!quietMode) {
		fputs(MSGTXT_NAME_VERSION "\n" MSGTXT_CREDITS "\n\n", stdout);
	}

	// initialize symbol table
	Symbol_GlobalTable = Symbol_AllocateNewTable(0);
	memset(SymbolExt_BuiltInTable, 0, BI_NUM_ELEMENTS * sizeof(BuiltInSymbol));

	// initialize CPU and assembler symbols
	makeSymbolsMC68000();

	// create a new symbol to act as the initial scope... Maybe this is a bad idea
	hasLabel = 1;
	SymbolExt_MakeStdLabel(0);

	// initialize the object file
	initializeObjectFile();

	// initialize the listings file
	initializeListingsFile();

	// initialize some params
	asmFileStackPos = -1;
	totalLines = 0;
	objectAddress = 0;

	// initialize the asm file
	useAsmErrors = 1;

	// initialize CPU and assembler
	createDirectives();
	createFunctions();
	createVariables();
	addSymbolsMC68000();

	// process the included lines
	if (ExtraLinesCount > 0) {
		pass = -1;
		Tracer_WritePassNumber(-1);
		_lineNumber = &totalLines;

		// allocate some space for the filename
		LengthString* str = LengthString_FromBuffer((uint8_t*)"commandline", 11);
		_filename = str;

		if (str == NULL) {
			Error_ErrorProgram(ERRTXT_MALLOC_FAIL " ");
		}

		// process the actual lines
		writeListingsFileChange('>', 0, str->string);

		for (uint32_t i = 0; i < ExtraLinesCount; i++) {
			parseBufferAsAsm(ExtraLines[i], strlen((char*)ExtraLines[i]));
		}

		writeListingsFileChange('<', 0, str->string);

		// free memory
		free(ExtraLines);
		free(str);
	}

	// parse ASM file
	pass = 0;
	Tracer_WritePassNumber(1);
	initAsmFile();
	parseAsmFile();

	// close all ASM files
	closeAllAsmFiles();

	// print extra line in the listings
	objSetAddress();
	setListingsBytes();
	*(buffers.listings + LST_POS_BUF) = 0;
	printListingsLine();

	// close the listings file
	closeListingsFile();

	// flush object buffer
	if (objectFile) {
		flushObjectBuffer();
	}

	// handle pass 2
	if (!quietMode) {
		printf("Executing Pass 2.\n");
	}

	pass = 1;
	Tracer_WritePassNumber(2);
	doPass2();

	// close object file
	closeObjectFile();

	// generate symbols file
	generateSymbolFile();

	// reset symbol table
	Symbol_UnallocateTable(Symbol_GlobalTable, 0);

	if (!quietMode) {
		// print assembly finish text
		const int32_t time = clock() / (CLOCKS_PER_SEC / 1000);

		if (time < 1000) {
			printf("Assembly finished with %d errors from %d lines in %d ms!\n", Error_ErrorCount, totalLines, time);

		} else {
			printf("Assembly finished with %d errors from %d lines in %.*f s!\n", Error_ErrorCount, totalLines, 2, time / 1000.0);
		}
	}

	// close the tracer file
	Tracer_CloseFile();

#ifdef DEBUG
	printDebugInfoFinish();
#endif
	return 0;
}
