#if !defined(INCLUDE_LIB_SYMBOLS_H)
#define INCLUDE_LIB_SYMBOLS_H

#include <stdbool.h>
#include <stdint.h>

#include <lib/lengthstring.h>

// symbol type definitons
typedef enum {
	/**
	 * Function symbols
	 *
	 * built-in function
	 * 		functionPtr = address
	 * 		extraParam = anything
	 * user macro
	 * 		functionPtr = processUserMacro()
	 * 		extraParam = pointer to macro data
	 * user function
	 * 		functionPtr = processUserFunc()
	 * 		extraParam = pointer to function data
	 */
	Symbol_Type_Function,

	/**
	 * Section symbols
	 *
	 * functionPtr = null
	 * extraParam = pointer to section struct
	 */
	Symbol_Type_Section,

	/**
	 * Integer equate symbols
	 *
	 * innerTable = local label table
	 * extraParam = equate value
	 */
	Symbol_Type_Integer_Equate,

	/**
	 * String equate symbols
	 *
	 * innerTable = local label table
	 * string = string pointer
	 */
	Symbol_Type_String_Equate,

	/**
	 * Equate symbols that use function to get the value
	 *
	 * evalPtr = pointer to resolve function
	 * extraParam = function parameter
	 */
	Symbol_Type_Function_Equate,

	/**
	 * Motorola 68000 register
	 *
	 * functionPtr = null
	 * extraParam = register ID or register list value
	 */
	Symbol_Type_Function_Register_68k,

	/**
	 * Zilog Z80 register
	 *
	 * functionPtr = null
	 * extraParam = register ID
	 */
	Symbol_Type_Function_Register_Z80,

} Symbol_Type;

// symbol flag definitons
typedef enum {
	Symbol_Flag_Local = 1,		  // indicates that this equate is a local equate
	Symbol_Flag_RegisterList = 1, // indicates that this register is a register list

	Symbol_Flag_Unconditional = 0x20, // indicates that the function will be executed regardless of condition
	Symbol_Flag_Locked = 0x40,		  // indicates that the symbol can not be redefined
	Symbol_Flag_Initialized = 0x80,	  // indicates that the symbol was initialized

} Symbol_Flag;

// token type definitions
typedef enum {
	Expression_Token_Type_Null,	  // token is not set or end of list
	Expression_Token_Type_Number, // number reference
	Expression_Token_Type_PC,	  // depends on the cpu
	Expression_Token_Type_String, // string reference

	Expression_Token_Type_Register,	   // register reference
	Expression_Token_Type_Symbol,	   // global symbol reference
	Expression_Token_Type_SymbolLocal, // local symbol reference
	Expression_Token_Type_SymbolBoth,  // local symbol reference relative to global symbol reference

	Expression_Token_Type_Func_Start, // function reference
	Expression_Token_Type_Func_Size,  // function size
	Expression_Token_Type_Func_Arg,	  // function argument
	Expression_Token_Type_Func_End,	  // function end

	Expression_Token_Type_NumSign,		// #
	Expression_Token_Type_Dot,			// .
	Expression_Token_Type_Comma,		// ,
	Expression_Token_Type_Paren_Open,	// (
	Expression_Token_Type_Paren_Closed, // )

	Expression_Token_Type_CmpEQ,  // a == b, a = b
	Expression_Token_Type_CmpNEQ, // a != b, a <> b
	Expression_Token_Type_CmpLT,  // a < b
	Expression_Token_Type_CmpLTE, // a <= b
	Expression_Token_Type_CmpGT,  // a > b
	Expression_Token_Type_CmpGTE, // a >= b

	Expression_Token_Type_Plus,		// a + b
	Expression_Token_Type_Minus,	// a - b
	Expression_Token_Type_Multiply, // a * b
	Expression_Token_Type_Divide,	// a / b
	Expression_Token_Type_Modulo,	// a % b

	Expression_Token_Type_Or,  // a | b
	Expression_Token_Type_Xor, // a ^ b
	Expression_Token_Type_And, // a & b

	Expression_Token_Type_ShiftL, // a << b
	Expression_Token_Type_ShiftR, // a >> b

	Expression_Token_Type_Logical_Or,  // a || b
	Expression_Token_Type_Logical_And, // a && b

	Expression_Token_Type_Unary_Minus,		 // -a
	Expression_Token_Type_Unary_Not,		 // ~a
	Expression_Token_Type_Unary_Logical_Not, // !a

} Expression_Token_Type;

// token precendece definitions
typedef enum {
	Expression_Token_Prec_CmpEQ = 9,  // a == b, a = b
	Expression_Token_Prec_CmpNEQ = 9, // a != b, a <> b
	Expression_Token_Prec_CmpLT = 8,  // a < b
	Expression_Token_Prec_CmpLTE = 8, // a <= b
	Expression_Token_Prec_CmpGT = 8,  // a > b
	Expression_Token_Prec_CmpGTE = 8, // a >= b

	Expression_Token_Prec_Plus = 5,		// a + b
	Expression_Token_Prec_Minus = 5,	// a - b
	Expression_Token_Prec_Multiply = 4, // a * b
	Expression_Token_Prec_Divide = 4,	// a / b
	Expression_Token_Prec_Modulo = 4,	// a % b

	Expression_Token_Prec_Or = 14,	// a | b
	Expression_Token_Prec_Xor = 13, // a ^ b
	Expression_Token_Prec_And = 12, // a & b

	Expression_Token_Prec_ShiftL = 6, // a << b
	Expression_Token_Prec_ShiftR = 6, // a >> b

	Expression_Token_Prec_Logical_Or = 21,	// a || b
	Expression_Token_Prec_Logical_And = 20, // a && b

	Expression_Token_Prec_Unary_Minus = 3,		 // -a
	Expression_Token_Prec_Unary_Not = 3,		 // ~a
	Expression_Token_Prec_Unary_Logical_Not = 3, // !a

} Expression_Token_Precendence;

// expression result types
typedef enum {
	Expression_Result_Type_Symbol_Undefined = -2, // symbol is undefined
	Expression_Result_Type_No_Eval = -1,		  // expression could not be evaluated
	Expression_Result_Type_Success = 0,			  // expression was evaluated correctly

	// hard errors
	Expression_Result_Type_Malloc_Fail,		 // memory allocation failed
	Expression_Result_Type_EOL,				 // unexpected end of line
	Expression_Result_Type_Unexpected_Char,	 // unexpected character in input
	Expression_Result_Type_Too_Deep,		 // too many parens
	Expression_Result_Type_Too_Shallow,		 // has too many )'s
	Expression_Result_Type_Not_Closed,		 // did not have matching () pairs
	Expression_Result_Type_Expect_OpenParen, // expected (

	Expression_Result_Type_Invalid_Str_Delim,  // invalid delimiter on string
	Expression_Result_Type_Invalid_Str_Escape, // invalid escape sequence in string
	Expression_Result_Type_Invalid_Str_HexEsc, // invalid character in \x escape sequence
	Expression_Result_Type_Invalid_Str_NoEnd,  // can not find end of string

	Expression_Result_Type_Op_Not_Unary,  // token is not a unary operator
	Expression_Result_Type_Op_Not_Binary, // token is not a binary operator

	Expression_Result_Type_Symbol_No_Scope,		  // symbol has no local scope
	Expression_Result_Type_Symbol_Invalid_In_Exp, // symbol type is not allowed in expressions

	// number errors
	Expression_Result_Type_NotHex,	 // non-hexadecimal character in hexadecimal number
	Expression_Result_Type_NotDec,	 // non-decimal character in hexadecimal number
	Expression_Result_Type_NotBin,	 // non-binary character in hexadecimal number
	Expression_Result_Type_LongHex,	 // hexadecimal number has too many digits
	Expression_Result_Type_LongDec,	 // decimal number has too many digits
	Expression_Result_Type_LongBin,	 // binary number has too many digits
	Expression_Result_Type_ShortNum, // number is too short

	// evaluate related errors
	Expression_Result_Type_No_Result,	 // result object is invalid
	Expression_Result_Type_Value_OOR,	 // value out of range
	Expression_Result_Type_Not_Int,		 // value is not integer
	Expression_Result_Type_Not_Str,		 // value is not string
	Expression_Result_Type_Str_Null,	 // string is null somehow
	Expression_Result_Type_Str_Long,	 // string is too long
	Expression_Result_Type_Empty_Parens, // () in input

	Expression_Result_Type_Invalid_Func_Call, // invalid function call???
	Expression_Result_Type_Func_Void,		  // no return value from function
	Expression_Result_Type_Arg_Null,		  // argument does not exist
	Expression_Result_Type_Arg_Empty,		  // empty argument

	// math error
	Expression_Result_Type_Divsion_0, // division by 0

	// special errors
	Expression_Result_Type_Not_Register, // not a register

	// 680x0 errors
	Expression_Result_Type_68k_Not_Register, // not 68k register
	Expression_Result_Type_68k_Not_Movem,	 // value is not a movem register list
	Expression_Result_Type_68k_Invalid_0,	 // value can not be 0 for addq/subq

} Expression_Result_Type;

/**
 * struct for tokens for the various evaluate functions
 * Tokens are actually linked lists
 */
typedef struct EvaluateToken {
	struct EvaluateToken* prev;
	struct EvaluateToken* next;

	union {
		LengthString* string;
		uint64_t value; // low 32-bits: global, high 32-bits: local
	};

	uint8_t* start; // string start position
	uint8_t* end;	// string end position
	Expression_Token_Type type;
	uint8_t extra; // mostly for symbol resolving. 0 = global, 1 = global:local

} EvaluateToken;

typedef struct SymbolRef SymbolRef;

/**
 * struct for all symbols
 */

typedef struct {
	uint32_t hash; // hash of this entry
	uint8_t* name; // name/label of the symbol

	union {
		uint64_t identifier;					 // generic identifier in all other instances
		void (*functionPtr)(uint8_t*, uint32_t); // pointer to the routine that parses this
		EvaluateToken* (*evalPtr)(uint64_t);	 // pointer to the routine that evaluates this into a token
		SymbolRef* innerTable;					 // pointer to the local symbol table of equates
	};

	union {
		uint64_t extraParam;  // extra parameter
		LengthString* string; // string pointer (malloc)
	};

	uint8_t type;  // type for the object
	uint8_t flags; // various flags associated with the symbol

} Symbol;

extern SymbolRef* Symbol_AllocateNewTable(uint8_t isLocal);

extern void Symbol_UnallocateTable(SymbolRef* table, uint8_t isLocal);

extern Symbol* Symbol_FindByHash(uint32_t hash, SymbolRef* table);

extern Symbol* Symbol_AllocateNew(uint32_t hash, SymbolRef* table);

extern Symbol* Symbol_FindOrAllocate(uint32_t hash, uint8_t mustBeNew);

extern Symbol* Symbol_FindOrAllocateLocal(uint32_t hash, Symbol* symbol, uint8_t mustBeNew);

extern Symbol* Symbol_Fetch(uint32_t hash, SymbolRef* table);

extern Symbol* Symbol_FetchLocal(uint32_t hash, Symbol* symbol);

extern bool Symbol_DeleteByHash(uint32_t hash, SymbolRef* table);

extern bool Symbol_DeleteByHashLocal(uint32_t hash, Symbol* symbol);

#endif // INCLUDE_LIB_SYMBOLS_H
