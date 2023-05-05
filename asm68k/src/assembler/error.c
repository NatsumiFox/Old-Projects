#include <inttypes.h>
#include <setjmp.h>
#include <stdarg.h>
#include <stdint.h>
#include <stddef.h>
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

#include <asmlink/symbol_ext.h>

#include <lib/compat.h>
#include <lib/error_lib.h>
#include <lib/expressions.h>
#include <lib/debug.h>
#include <lib/messages/global.h>

#define MAX_ERRORS 64

// helper to print the line that caused the error
void Error_PrintCodeLine(FILE* target) {
	uint8_t* maxAddr = buffers.line + LST_ERR_MAX_LEN;

	// replace the character at the max line length with a NUL temporarily
	uint8_t c = *maxAddr;
	*maxAddr = 0;
	fprintf(target, "\n  %s\n", buffers.line);
	*maxAddr = c;
}

// helper function to write code underlining (^~~~~) to indicate where error happened
void Error_PrintCodeUnderline(FILE* target, const char* line, char* start, char* end) {
	// length 0 is a special case
	if (start != end) {
		end--;
	}

	// fill with space until the key location
	uint8_t* buffer = buffers.underline;
	uint32_t spaces = (start - line) + 2;

	while (spaces-- > 0) {
		*buffer++ = ' ';
	}

	// write caret
	*buffer++ = '^';

	// write tildes
	while (start < end) {
		*buffer++ = '~';
		start++;
	}

	// write NL and NUL
	*buffer++ = '\n';
	*buffer = 0;

	// write dat line
	fprintf(target, "%s", buffers.underline);
}

// helper function to write the code location for error reporting
void Error_PrintCodeLocation(FILE* target, char* type) {
	if (pass == 0 && asmFileStackPos < 0) {
		fprintf(target, "%s: ", type);

	} else {
		fprintf(target, "%s (%d): %s: ", _filename->string, *_lineNumber, type);
	}
}

// helper function to display a warning with underline pointing to it
void Error_WarnUnderlineFunc(char* text, char* start, char* end, const char* format, va_list args) {
	if (options.printWarnings) {
		// print error correctly
		Error_PrintCodeLocation(stdout, "Warn");
		vfprintf(stdout, format, args);
		Error_PrintCodeLine(stdout);
		Error_PrintCodeUnderline(stderr, text, start, end);
	}
}

// helper function to display a warning
void Error_WarnNormalFunc(const char* format, va_list args) {
	if (options.printWarnings) {
		// print error correctly
		Error_PrintCodeLocation(stdout, "Warn");
		vfprintf(stdout, format, args);
		Error_PrintCodeLine(stdout);
	}
}

// helper function to display an error with underline pointing to it
c_noreturn void Error_ErrorUnderlineFunc(char* text, char* start, char* end, const char* format, va_list args) {
	// print error correctly
	Error_PrintCodeLocation(stderr, "Error");
	vfprintf(stderr, format, args);
	Error_PrintCodeLine(stderr);
	Error_PrintCodeUnderline(stderr, text, start, end);

	// if too many errors, bail completely
	if (Error_ErrorCount > MAX_ERRORS) {
		Error_Exit(3);
	}

	// update listings and assemble the next line
	setListingsBytes();
	longjmp(parseJumpBuf, -1);
}

// helper function to display an error
c_noreturn void Error_ErrorNormalFunc(const char* format, va_list args) {
	// print error correctly
	Error_PrintCodeLocation(stderr, "Error");
	vfprintf(stderr, format, args);
	Error_PrintCodeLine(stderr);

	// if too many errors, bail completely
	if (Error_ErrorCount > MAX_ERRORS) {
		Error_Exit(3);
	}

	// update listings and assemble the next line
	setListingsBytes();
	longjmp(parseJumpBuf, -1);
}

// helper function to display a fatal error
int Error_FatalNormalFunc(int code, const char* format, va_list args) {
	// print error correctly
	Error_PrintCodeLocation(stderr, "Fatal");
	vfprintf(stderr, format, args);
	Error_PrintCodeLine(stderr);
	return code;
}

// exit the program immediately
int Error_ExitNormalFunc(int code) {
	if (code == 3) {
		fprintf(stderr, "Assembly terminated - maximum number of errors reached!\n");

	} else {
		fprintf(stderr, "Assembly terminated!\n");
	}

	// close object file
	closeObjectFile();

	// generate symbols file
	generateSymbolFile();

#ifdef DEBUG
	printDebugInfoFinish();
#endif
	return code;
}

// helper function to display an error
void Error_ErrorPass2(const char* format, ...) {
	va_list argptr;

	// print error correctly
	Error_PrintCodeLocation(stderr, "Error");
	va_start(argptr, format);
	vfprintf(stderr, format, argptr);
	va_end(argptr);
	Error_PrintCodeLine(stderr);
	//	Error_PrintCodeUnderline(stderr, lineBuffer.sanitizedLine, start, end);

	// if too many errors, bail completely
	if (Error_ErrorCount > MAX_ERRORS) {
		Error_Exit(3);
	}
}

void Error_ErrorProgram(const char* format, ...) {
	va_list argptr;
	va_start(argptr, format);
	vfprintf(stderr, format, argptr);
	va_end(argptr);
	Error_Exit(1);
}

/**
 * Print error code for eval
 */

// helper function to write expression-related error
c_noreturn void Error_Eval(TokenTable* table, int error) {
	Error_EvalPass2(table, error);

	// update listings and assemble the next line
	setListingsBytes();
	longjmp(parseJumpBuf, -1);
}

// helper function to write expression-related error in pass 2
void Error_EvalPass2(TokenTable* table, Expression_Result_Type error) {
	Error_PrintCodeLocation(stderr, "Error");
	Expression_WriteErrorCode(stderr, table, error);
	Error_PrintCodeLine(stderr);

	// apply special rules for when can not evaluate
	if (error == Expression_Result_Type_No_Eval || error == Expression_Result_Type_Symbol_Undefined) {
		Error_PrintCodeUnderline(stderr, table->evalStart, table->evalEnd, table->lineStart);

	} else {
		Error_PrintCodeUnderline(stderr, table->expStart, table->expEnd, table->lineStart);
	}

	// check if this table was allocated
	Expression_FreeTokenTable(table);

	// if too many errors, bail completely
	if (++Error_ErrorCount > MAX_ERRORS) {
		Error_Exit(3);
	}
}

// helper to copy a text area to memory and NULL terminate it
char* Error_PrepareString(char* start, const char* end) {
	size_t length = (size_t)(end - start);
	memcpy(buffers.error, start, length);
	*(buffers.error + length) = 0;
	return buffers.error;
}
