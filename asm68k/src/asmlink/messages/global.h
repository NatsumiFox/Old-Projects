#if !defined(INCLUDE_ASMLINK_MESSAGES_GLOBAL_H)
#define INCLUDE_ASMLINK_MESSAGES_GLOBAL_H

//////////////////////////////////////////////////////////////////////////////
// Unformatted error strings
//////////////////////////////////////////////////////////////////////////////

#define ERRTXT_RENAME_LOCAL_SYM "Local symbols are disallowed with RENAME."
#define ERRTXT_LOCAL_SYMBOL_MISSING "Local label symbol was missing!"
#define ERRTXT_LOCAL_SYMBOL_SPACE "Local label symbol must not be a space!"

//////////////////////////////////////////////////////////////////////////////
// Formatted error strings
//////////////////////////////////////////////////////////////////////////////

#define ERRFMT_NOT_BUILTIN "Symbol \"%s\" is not a built-in symbol."
#define ERRFMT_INCLUDE_FILES_MAX "Include file depth is too large. At most %d files can be nested."
#define ERRFMT_INCLUDE_FILES_MIN "Attempted to close a file while file stack is empty!"
#define ERRFMT_LINE_LENGTH_ISSUE "Processed line was too long at %d characters! Maximum characters per line is %d!"
#define ERRFMT_UNKNOWN_SYMBOT_FORMAT "Symbol format %s is not recognized."

// bug related messages
#define ERRFMT_PASS2BUG_INVALID "Invalid pass2 patch %x executed! This is an assembler bug."

//////////////////////////////////////////////////////////////////////////////
// Formatted error strings that take arguments
//////////////////////////////////////////////////////////////////////////////

#define ERRFUN_CPUFPU_MODEL_UNSUPPORTED(type) (type " model \"%s\" not supported!")

//////////////////////////////////////////////////////////////////////////////
// Standard strings for arguments
//////////////////////////////////////////////////////////////////////////////

#define ERRSTR_TYPE_CPU "CPU"
#define ERRSTR_TYPE_FPU "FPU"

//////////////////////////////////////////////////////////////////////////////
// Misc messages
//////////////////////////////////////////////////////////////////////////////

#define MSGFUN_NAME(name, version) name " version " version

#define MSGFUN_OPTION(format, text) "        " format " " text "\n"

#define MSGFUN_USAGE(program, options) \
	program " -options source object\n\n" \
	"options:\n" \
	options

#endif // INCLUDE_ASMLINK_MESSAGES_GLOBAL_H
