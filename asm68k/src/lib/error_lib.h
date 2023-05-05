#if !defined(INCLUDE_LIB_ERROR_H)
#define INCLUDE_LIB_ERROR_H

#include <stdarg.h>

#include <lib/compat.h>

//////////////////////////////////////////////////////////////////////////////
// Variable declarations
//////////////////////////////////////////////////////////////////////////////

/**
	\brief Counter that calls how many times Error_Error was called
*/
extern int Error_ErrorCount;

/**
	\brief Counter that calls how many times Error_Warn was called
*/
extern int Error_WarnCount;

/**
	\brief Counter that calls how many times Error_Info was called
*/
extern int Error_InfoCount;

/**
	\brief Handle tasks that must be done before the program can exit safely

	\param code Program exit code

	\returns The new exit code that should replace the exit code given to the function.
*/
extern int (*Error_ExitHandler)(int code);

/**
	\brief Handle fatal errors on the program

	\param code Exit code to return from the program

	\param format The printf format for the error, along with arguments that follow

	\returns The new exit code that should replace the exit code given to the function
*/
extern int (*Error_FatalHandler)(int code, const char* format, va_list args);

/**
	\brief Handle fatal errors on the program with extra underlined text

	\param text An additional buffer of text to show for the error

	\param start The starting character of `text` where underlining should begin

	\param end The ending character of `text` where underlining should stop

	\param code Exit code to return from the program

	\param format The printf format for the error, along with arguments that follow

	\returns The new exit code that should replace the exit code given to the function
*/
extern int (*Error_FatalUnderlineHandler)(char* text, char* start, char* end, int code, const char* format, va_list args);

/**
	\brief Handle errors in the program

	\param format The printf format for the error, along with arguments that follow
*/
extern void (*Error_ErrorHandler)(const char* format, va_list args);

/**
	\brief Handle errors in the program with extra underlined text

	\param text An additional buffer of text to show for the error

	\param start The starting character of `text` where underlining should begin

	\param end The ending character of `text` where underlining should stop

	\param format The printf format for the error, along with arguments that follow
*/
extern void (*Error_ErrorUnderlineHandler)(char* text, char* start, char* end, const char* format, va_list args);

/**
	\brief Handle warnings in the program

	\param format The printf format for the error, along with arguments that follow
*/
extern void (*Error_WarnHandler)(const char* format, va_list args);

/**
	\brief Handle warnings in the program

	\param text An additional buffer of text to show for the error

	\param start The starting character of `text` where underlining should begin

	\param end The ending character of `text` where underlining should stop

	\param format The printf format for the error, along with arguments that follow
*/
extern void (*Error_WarnUnderlineHandler)(char* text, char* start, char* end, const char* format, va_list args);

/**
	\brief Handle extra information in the program

	\param format The printf format for the error, along with arguments that follow
*/
extern void (*Error_InfoHandler)(const char* format, va_list args);

/**
	\brief Handle extra information in the program

	\param text An additional buffer of text to show for the error

	\param start The starting character of `text` where underlining should begin

	\param end The ending character of `text` where underlining should stop

	\param format The printf format for the error, along with arguments that follow
*/
extern void (*Error_InfoUnderlineHandler)(char* text, char* start, char* end, const char* format, va_list args);

//////////////////////////////////////////////////////////////////////////////
// Function declarations
//////////////////////////////////////////////////////////////////////////////

/**
	\brief Exit the program with a specific exit code

	\param code Exit code to return from the program
*/
c_noreturn void Error_Exit(int code);

/**
	\brief Process a fatal error in the program, causing the Error_Exit function to be called as well

	\param code Exit code to return from the program

	\param format The printf format to apply to the function, as well as any arguments that follow
*/
c_noreturn void Error_Fatal(int code, const char* format, ...);

/**
	\brief Process a fatal error in the program, causing the Error_Exit function to be called as well

	\param code Exit code to return from the program

	\param text An additional buffer of text to show for the error

	\param start The starting character of `text` where underlining should begin

	\param end The ending character of `text` where underlining should stop

	\param format The printf format to apply to the function, as well as any arguments that follow
*/
c_noreturn void Error_FatalUnderline(char* text, char* start, char* end, int code, const char* format, ...);

/**
	\brief Process an error in the program

	\param format The printf format to apply to the function, as well as any arguments that follow
*/
void Error_Error(const char* format, ...);

/**
	\brief Process an error in the program

	\param text An additional buffer of text to show for the error

	\param start The starting character of `text` where underlining should begin

	\param end The ending character of `text` where underlining should stop

	\param format The printf format to apply to the function, as well as any arguments that follow
*/
void Error_ErrorUnderline(char* text, char* start, char* end, const char* format, ...);

/**
	\brief Process a warning in the program

	\param format The printf format to apply to the function, as well as any arguments that follow
*/
void Error_Warn(const char* format, ...);

/**
	\brief Process a warning in the program

	\param text An additional buffer of text to show for the error

	\param start The starting character of `text` where underlining should begin

	\param end The ending character of `text` where underlining should stop

	\param format The printf format to apply to the function, as well as any arguments that follow
*/
void Error_WarnUnderline(char* text, char* start, char* end, const char* format, ...);

/**
	\brief Process extra information in the program

	\param format The printf format to apply to the function, as well as any arguments that follow
*/
void Error_Info(const char* format, ...);

/**
	\brief Process extra information in the program

	\param text An additional buffer of text to show for the error

	\param start The starting character of `text` where underlining should begin

	\param end The ending character of `text` where underlining should stop

	\param format The printf format to apply to the function, as well as any arguments that follow
*/
void Error_InfoUnderline(char* text, char* start, char* end, const char* format, ...);

#endif // INCLUDE_LIB_ERROR_H
