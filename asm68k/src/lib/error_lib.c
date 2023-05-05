#include <stdarg.h>
#include <stdint.h>
#include <stdlib.h>

#include <lib/compat.h>

//////////////////////////////////////////////////////////////////////////////
// Variable declarations
//////////////////////////////////////////////////////////////////////////////

int Error_ErrorCount = 0;
int Error_WarnCount = 0;
int Error_InfoCount = 0;

int (*Error_ExitHandler)(int code) = NULL;
int (*Error_FatalHandler)(int code, const char* format, ...) = NULL;
int (*Error_FatalUnderlineHandler)(char* text, char* start, char* end, int code, const char* format, ...) = NULL;
void (*Error_ErrorHandler)(const char* format, ...) = NULL;
void (*Error_ErrorUnderlineHandler)(char* text, char* start, char* end, const char* format, ...) = NULL;
void (*Error_WarnHandler)(const char* format, ...) = NULL;
void (*Error_WarnUnderlineHandler)(char* text, char* start, char* end, const char* format, ...) = NULL;
void (*Error_InfoHandler)(const char* format, ...) = NULL;
void (*Error_InfoUnderlineHandler)(char* text, char* start, char* end, const char* format, ...) = NULL;

//////////////////////////////////////////////////////////////////////////////
// Function declarations
//////////////////////////////////////////////////////////////////////////////

c_noreturn void Error_Exit(int code) {
	if (Error_ExitHandler != NULL) {
		// call handler
		code = Error_ExitHandler(code);
	}

	// exit program
	exit(code);
}

c_noreturn void Error_Fatal(int code, const char* format, ...) {
	if (Error_FatalHandler != NULL) {
		// call handler
		code = Error_FatalHandler(code, format);
	}

	// call error exit function
	Error_Exit(code);
}

c_noreturn void Error_FatalUnderline(char* text, char* start, char* end, int code, const char* format, ...) {
	if (Error_FatalUnderlineHandler != NULL) {
		// call handler
		va_list argptr;
		va_start(argptr, format);
		code = Error_FatalUnderlineHandler(text, start, end, code, format);
		va_end(argptr);
	}

	// call error exit function
	Error_Exit(code);
}

void Error_Error(const char* format, ...) {
	Error_ErrorCount++;

	if (Error_ErrorHandler != NULL) {
		// call handler
		va_list argptr;
		va_start(argptr, format);
		Error_ErrorHandler(format, argptr);
		va_end(argptr);
	}
}

void Error_ErrorUnderline(char* text, char* start, char* end, const char* format, ...) {
	Error_ErrorCount++;

	if (Error_ErrorUnderlineHandler != NULL) {
		// call handler
		va_list argptr;
		va_start(argptr, format);
		Error_ErrorUnderlineHandler(text, start, end, format, argptr);
		va_end(argptr);
	}
}

void Error_Warn(const char* format, ...) {
	Error_WarnCount++;

	if (Error_WarnHandler != NULL) {
		// call handler
		va_list argptr;
		va_start(argptr, format);
		Error_WarnHandler(format, argptr);
		va_end(argptr);
	}
}

void Error_WarnUnderline(char* text, char* start, char* end, const char* format, ...) {
	Error_WarnCount++;

	if (Error_WarnUnderlineHandler != NULL) {
		// call handler
		va_list argptr;
		va_start(argptr, format);
		Error_WarnUnderlineHandler(text, start, end, format, argptr);
		va_end(argptr);
	}
}

void Error_Info(const char* format, ...) {
	Error_InfoCount++;

	if (Error_InfoHandler != NULL) {
		// call handler
		va_list argptr;
		va_start(argptr, format);
		Error_InfoHandler(format, argptr);
		va_end(argptr);
	}
}

void Error_InfoUnderline(char* text, char* start, char* end, const char* format, ...) {
	Error_InfoCount++;

	if (Error_InfoUnderlineHandler != NULL) {
		// call handler
		va_list argptr;
		va_start(argptr, format);
		Error_InfoUnderlineHandler(text, start, end, format, argptr);
		va_end(argptr);
	}
}
