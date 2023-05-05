#if !defined(INCLUDE_ASSEMBLER_MSG_68K_H)
#define INCLUDE_ASSEMBLER_MSG_68K_H

//////////////////////////////////////////////////////////////////////////////
// Unformatted error strings
//////////////////////////////////////////////////////////////////////////////

#define ERRTXT_68K_EA_UNSUPPORTED_COMB "Addressing mode combination unsupported by this instruction."
#define ERRTXT_68K_EA_UNSUPPORTED_OP "Addressing mode unsupported by this operand."
#define ERRTXT_68K_EA_ILLEGAL "Illegal addressing mode."
#define ERRTXT_68K_INS_SIZE_ADDRREG "Only \"w\" and \"l\" are valid instruction sizes on address register operations."
#define ERRTXT_68K_REG_DATAORADDR "Instruction expected data or address register as operand."
#define ERRTXT_68K_REG_DATA "Instruction expected data register as operand."
#define ERRTXT_68K_REG_ADDR "Instruction expected address register as operand."

//////////////////////////////////////////////////////////////////////////////
// Formatted error strings
//////////////////////////////////////////////////////////////////////////////

#define ERRFMT_68K_EA_D16x "Effective addressing mode d16(\"%s\") is not valid."
#define ERRFMT_68K_EA_D8xy "Effective addressing mode d8(%s,\"%s\") is not valid."
#define ERRFMT_68K_EA_D8xXN "Effective addressing mode d8(\"%s\",xn) is not valid."
#define ERRFMT_68K_TRAP_VECTOR "Trap vector $%x is not supported."
#define ERRFMT_68K_UNSUPPORTED_PLUSMINUS "Addressing mode -(%s)+ is not valid on MC68000."
#define ERRFMT_68K_UNSUPPORTED_INDIRECT "Addressing mode (%s) not supported on the MC68000."
#define ERRFMT_68K_EA_INVALID_REG "Register \"%s\" not valid in effective addressing mode."
#define ERRFMT_68K_REG_UNSUPPORTED "Register \"%s\" not supported on the MC68000."
#define ERRFMT_68K_SIZE_INVALID "Invalid instruction size \"%c\"."
#define ERRFMT_68K_SIZE_EXPECTED "Expected instruction size but got \"%c\"."

#endif // INCLUDE_ASSEMBLER_MSG_68K_H
