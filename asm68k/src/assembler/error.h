#if !defined(INCLUDE_ASSEMBLER_ERROR_H)
#define INCLUDE_ASSEMBLER_ERROR_H

#include <stdint.h>
#include <stdarg.h>

#include <lib/compat.h>
#include <lib/error_lib.h>
#include <lib/expressions.h>
#include <lib/symbols.h>

void Error_WarnUnderlineFunc(char* text, char* start, char* end, const char* format, va_list args);

void Error_WarnNormalFunc(const char* format, va_list args);

c_noreturn void Error_ErrorUnderlineFunc(char* text, char* start, char* end, const char* format, va_list args);

c_noreturn void Error_ErrorNormalFunc(const char* format, va_list args);

void Error_ErrorPass2(const char* format, ...);

void Error_ErrorProgram(const char* format, ...);

int Error_FatalNormalFunc(int code, const char* format, va_list args);

int Error_ExitNormalFunc(int code);

char* Error_PrepareString(char* start, const char* end);

c_noreturn void Error_Eval(TokenTable* table, int error);

void Error_EvalPass2(TokenTable* table, Expression_Result_Type error);

#endif // INCLUDE_ASSEMBLER_ERROR_H
