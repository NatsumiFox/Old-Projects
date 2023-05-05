#if !defined(INCLUDE_ASSEMBLER_MSG_DIRECTIVES_H)
#define INCLUDE_ASSEMBLER_MSG_DIRECTIVES_H

//////////////////////////////////////////////////////////////////////////////
// Unformatted error strings
//////////////////////////////////////////////////////////////////////////////

#define ERRTXT_DIR_DC_SIZE_SU "Op-code size for DC must only contain one S or U."
#define ERRTXT_DIR_DC_SIZE_BWL "Op-code size for DC must only contain one B, W or L."
#define ERRTXT_DIR_DC_SIZE_US_SQ "Op-code size for DC can not be UQ or SQ."

//////////////////////////////////////////////////////////////////////////////
// Formatted error strings
//////////////////////////////////////////////////////////////////////////////

#define ERRFMT_DIR_DCB_REPT ("Repeat count must be 0 or greater, but was %" PRIX64 ".")

#endif // INCLUDE_ASSEMBLER_MSG_DIRECTIVES_H
