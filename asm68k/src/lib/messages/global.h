#if !defined(INCLUDE_LIB_ERRORS_GLOBAL_H)
#define INCLUDE_LIB_ERRORS_GLOBAL_H

//////////////////////////////////////////////////////////////////////////////
// Unformatted error strings
//////////////////////////////////////////////////////////////////////////////

#define ERRTXT_MALLOC_FAIL "Memory allocation failed! System may be out of memory."
#define ERRTXT_UNEXPECTED_EOL "Unexpected end of line."
#define ERRTXT_UNKNOWN_POS_ARGUMENT "Unknown positional argument detected."
#define ERRTXT_INS_EXPECTED_1_OPERAND "Instruction expected 1 operand."
#define ERRTXT_DIR_EXPECTED_1_OPERAND "Directive expected 1 operand."
#define ERRTXT_EXPECTED_COMMA_AFTER_OPERAND "Expected comma after operand."
#define ERRTXT_EXPECTED_MORE_ARGS "Expected another argument here."

//////////////////////////////////////////////////////////////////////////////
// Formatted error strings
//////////////////////////////////////////////////////////////////////////////

#define ERRFMT_UNEXPECTED_IN_INPUT "Unexpected character \"%c\" in input."
#define ERRFMT_UNEXPECTED_CHAR "Did not expect \"%c\" at this position."
#define ERRFMT_EXPECTED_CHAR "Expected \"%c\" at this position."
#define ERRFMT_EXPECTED_PARAM_HERE "Expected %s parameter here."
#define ERRFMT_SYMBOL_UNDEFINED "Symbol \"%s\" is undefined."
#define ERRFMT_SYMBOL_MULTIPLY "Symbol \"%s\" multiply defined."
#define ERRFMT_SYMBOL_REDEFINE "Symbol \"%s\" can not be re-defined."
#define ERRFMT_SYMBOL_NOT_FUNC "Symbol \"%s\" is not a macro or an instruction."
#define ERRFMT_SYMBOL_NOT_REG "Symbol \"%s\" is not a valid register."
#define ERRFMT_SYMBOL_EXPECTED "Expected symbol at %s but none was given."
#define ERRFMT_FILE_NOT_FOUND "File \"%s\" cannot be found!"
#define ERRFMT_PATH_NOT_DIR "Path \"%s\" is not a directory or does not exist!"

// bug related messages
#define ERRFMT_BUG_CANT_NORMALIZE "Path \"%s\" could not be normalized. This is an assembler bug."

//////////////////////////////////////////////////////////////////////////////
// Formatted error strings that take arguments
//////////////////////////////////////////////////////////////////////////////

#define ERRFUN_EXPECTED_PARAM_FOR(type) ("Expected " type " parameter for %s!")
#define ERRFUN_INS_EXPECTED_X_OPERANDS(count) ("Instruction expected " count " operands.")
#define ERRFUN_DIR_EXPECTED_X_OPERANDS(count) ("Directive expected " count " operands.")
#define ERRFUN_OPTION_NOT_RECOGNIZED(prefix) ("Option " prefix "%s not recognized!")
#define ERRFUN_OPTION_NOT_IMPLEMENTED(prefix) ("Option " prefix "%s not implemented yet!")

//////////////////////////////////////////////////////////////////////////////
// Standard strings for arguments
//////////////////////////////////////////////////////////////////////////////

#define ERRSTR_TYPE_FILE "<file>"
#define ERRSTR_TYPE_PATH "<path>"
#define ERRSTR_TYPE_MODEL "<model>"
#define ERRSTR_TYPE_FORMAT "<format>"
#define ERRSTR_TYPE_SOURCE "<source>"
#define ERRSTR_TYPE_OBJECT "<object>"
#define ERRSTR_TYPE_EQUVALUE "<symbol=value>"

#endif // INCLUDE_LIB_ERRORS_GLOBAL_H
