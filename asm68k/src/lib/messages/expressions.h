#if !defined(INCLUDE_LIB_EXPRESSIONS_ERROR_H)
#define INCLUDE_LIB_EXPRESSIONS_ERROR_H

//////////////////////////////////////////////////////////////////////////////
// Unformatted error strings
//////////////////////////////////////////////////////////////////////////////

// generic errors
#define ERRTXT_EXP_NO_EVAL "Expression can not be evaluated."
#define ERRTXT_EXP_TOO_DEEP "Expression has too many ('s."
#define ERRTXT_EXP_NOT_NUMBER "Expected a number constant but got something else."
#define ERRTXT_EXP_FAIL_NUMCONV "Expression can not be converted to an integer number."
#define ERRTXT_EXP_STRCONV_TOOLONG "String is too long to be converted to an integer number."
#define ERRTXT_EXP_NOT_STRING "Expression is not a string."
#define ERRTXT_EXP_INVALID_ESCAPE "Invalid escape sequence in string."
#define ERRTXT_EXP_UNEXPECTED_EOL_STR "End of line before string was terminated."
#define ERRTXT_EXP_DIV0 "Division by 0 in expression."
#define ERRTXT_EXP_VOID_FUNC "Function did not return a value."
#define ERRTXT_EXP_ARG_MISSING "Argument was not specified."
#define ERRTXT_EXP_ARG_EMPTY "Argument was empty."
#define ERRTXT_EXP_SYMBOL_NO_LOCALS "Symbol does not have a scope."
#define ERRTXT_EXP_RESULT_STRORNUM "Expected a number or a string result, but expression evaluated to neither."

// M68K related errors
#define ERRTXT_68K_MOVEQ_VAL "Immediate value of MOVEQ will be sign-extended to 32-bit. If this is intended, use moveq.b to disable this warning."
#define ERRTXT_68K_NOTMOVEMREG "Expected one of the arguments to be a MOVEM register list."
#define ERRTXT_68K_NOVALUE0 "Value 0 is not acceptable for this operand."

// bug related errors
#define ERRTXT_EXPBUG_NO_RESULT "Invalid expression result. This is an assembler bug."
#define ERRTXT_EXPBUG_INVALID_STR "Invalid string in expression. This is an assembler bug."
#define ERRTXT_EXPBUG_INVALID_FUNCCALL "Invalid function call. This is an assembler bug."

//////////////////////////////////////////////////////////////////////////////
// Formatted error strings
//////////////////////////////////////////////////////////////////////////////

#define ERRFMT_EXP_SYMBOLTYPE "Symbol \"%s\" can not be used as a part of an expression."
#define ERRFMT_EXP_VALUE_OOR ("Value $%" PRIX64 " is out of range.")
#define ERRFMT_EXP_NOT_STRING_DELIM "Invalid string delimiter \"%c\"."
#define ERRFMT_EXP_INVALID_ESCAPE_CHAR "Invalid character \"%c\" in character escape sequence in string."
#define ERRFMT_FUNCARG_EXPECT_STR "Expected argument %d to be a string, but it was empty."

// bug related errors
#define ERRFMT_EXPBUG_UNKNOWKN "Unknown expression error $%x."

//////////////////////////////////////////////////////////////////////////////
// Formatted error strings that take arguments
//////////////////////////////////////////////////////////////////////////////

#define ERRFUN_EXP_INVALID_NUMBERCHAR(type) ("Character \"%c\" is not a valid " type " character.")
#define ERRFUN_EXP_LARGE_NUMBER(type) ("" type " constant is too large to be evaluated.")
#define ERRFUN_EXP_EXPECTED_OP_TYPE(type) ("Expected a " type " operator, but got \"%c\".")

//////////////////////////////////////////////////////////////////////////////
// Standard strings for arguments
//////////////////////////////////////////////////////////////////////////////

#define ERRSTR_EXP_NUMBER_TYPE_HEX "hexadecimal"
#define ERRSTR_EXP_NUMBER_TYPE_DEC "decimal"
#define ERRSTR_EXP_NUMBER_TYPE_BIN "binary"
#define ERRSTR_EXP_OP_TYPE_UNARY "unary"
#define ERRSTR_EXP_OP_TYPE_BINARY "binary"

#endif // INCLUDE_LIB_EXPRESSIONS_ERROR_H
