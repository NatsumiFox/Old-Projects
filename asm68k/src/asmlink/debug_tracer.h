#if !defined(INCLUDE_LIB_DEBUG_TRACER_H)
#define INCLUDE_LIB_DEBUG_TRACER_H

#if defined(TRACER)
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>

#include <asmlink/symbol_ext.h>

#include <assembler/68k/68000.h>
#include <assembler/pass2.h>

extern FILE* Tracer_FileHandle;
extern char* Tracer_FilePath;

void Tracer_OpenFile();
void Tracer_CloseFile();

void Tracer_WriteFileMode(uint8_t action, uint8_t* file, uint8_t* type);
void Tracer_WriteLine(uint8_t* file, uint8_t* line);
void Tracer_WritePassNumber(int8_t num);

void Tracer_WriteSymbolAction(uint8_t action, uint8_t local, Symbol* symbol);
void Tracer_WriteSymbolTableAction(uint8_t action, uint8_t local);
void Tracer_WriteBinaryOperator(uint64_t lvalue, char* operation, uint64_t rvalue, uint64_t result);
void Tracer_WriteUnaryOperator(char* operation, uint64_t rvalue, uint64_t result);

void Tracer_GetValueNumber(uint64_t value);
void Tracer_GetSymbolNumber(uint64_t value, uint8_t* name);
void Tracer_GetValueStringToNumber(uint64_t value, EvaluateToken* token);
void Tracer_GetSymbolStringToNumber(uint64_t value, Symbol* symbol);

void Tracer_WritePass2ValueEqu(uint8_t* name, uint64_t value);
void Tracer_WritePass2StringEqu(uint8_t* name, uint8_t* value);
void Tracer_WritePass2ReplaceBytes(ObjectReplacement* entry, uint64_t value);

void Tracer_WriteFunctionSize(Symbol* func, uint8_t* size);
void Tracer_WriteFunctionArgument(Symbol* func, uint8_t* size, uint64_t index);

void Tracer_WriteAddressingModeM68k(AddrModeHelper* helper);
void Tracer_WriteIncbin(uint64_t start, uint64_t length);
void Tracer_WriteRename(Symbol* old, Symbol* new);

#else
#undef INCLUDE_LIB_DEBUG_TRACER_H
#include <lib/tracer_dummy.h>
#endif

#endif // INCLUDE_LIB_DEBUG_TRACER_H
