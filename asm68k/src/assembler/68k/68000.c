#include <setjmp.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include <assembler/unsorted.h>
#include <assembler/68k/68000.h>
#include <assembler/assembler.h>
#include <assembler/error.h>
#include <assembler/hash.h>
#include <assembler/listings.h>
#include <assembler/object.h>
#include <assembler/parse.h>
#include <assembler/pass2.h>
#include <assembler/messages/680x0.h>

#include <asmlink/debug_tracer.h>
#include <asmlink/symbol_ext.h>

#include <lib/compat.h>
#include <lib/debug.h>
#include <lib/expressions.h>
#include <lib/math_lib.h>
#include <lib/messages/global.h>
#include <lib/messages/expressions.h>

#pragma region No Operand Instructions

// define no operands instructions that just have a static word value
#define m68k_InsWordOnly(name, word)           \
	void name(uint8_t* buffer, uint32_t param) { \
		objWordAlign();                            \
		objSetAddress();                           \
		createLabelCheck();                        \
		expectNUL(buffer, buffer, ERRFUN_INS_EXPECTED_X_OPERANDS("0"));   \
		objWriteWordBE(word);                      \
		setListingsBytes();                        \
	}

// clang-format off
m68k_InsWordOnly(MC68000_Illegal, 0x4AFC)
m68k_InsWordOnly(MC68000_Reset, 0x4E70)
m68k_InsWordOnly(MC68000_Nop, 0x4E71)
m68k_InsWordOnly(MC68000_Rte, 0x4E73)
m68k_InsWordOnly(MC68000_Rts, 0x4E75)
m68k_InsWordOnly(MC68000_Trapv, 0x4E76)
m68k_InsWordOnly(MC68000_Rtr, 0x4E77)
// clang-format on

#pragma endregion
#pragma region Special Converters

/**
 * Helper number converter functions
 */

// evaluate result as 16-bit signed or unsigned integer from 24-bit address
Expression_Result_Type evaluateAsAddrMC68k(TokenTable* table, uint16_t* value, uint64_t offset) {
	// convert result to a number
	Expression_Result_Type result = Expression_EvaluateAsNumber(table, &table->evalValue, 4, &table->result);

	if (result != Expression_Result_Type_Success) {
		// can not convert, fail
		*value = 0;
		return result;
	}

	table->evalValue += offset;

	// check range is within integer limits
	if ((int64_t)table->evalValue < INT16_MIN) {
		*value = 0;
		return Expression_Result_Type_Value_OOR;

	} else if ((int64_t)table->evalValue >= 0) {
		// special checks for 24-bit numbers
		uint64_t x = table->evalValue & 0xFFFFFFFF00000000;

		if (x != 0) {
			*value = 0;
			return Expression_Result_Type_Value_OOR;
		}

		// check for 24-bit vs 32-bit
		x = table->evalValue & 0xFF000000;

		if (x != 0 && x != 0xFF000000) {
			*value = 0;
			return Expression_Result_Type_Value_OOR;
		}

		// check check for FFxxxx and 00xxxx
		uint64_t y = table->evalValue & 0xFF0000;
		x = table->evalValue & 0xFFFF;

		if (y == 0 ? (x >= 0x8000) : y == 0xFF0000 ? (x < 0x8000) : 1) {
			*value = 0;
			return Expression_Result_Type_Value_OOR;
		}
	}

	// valid!!
	*value = (uint16_t)table->evalValue;
	return Expression_Result_Type_Success;
}

#pragma endregion
#pragma region Library Functions

/**
 * Parse 68000 addressing modes
 */

AddrModeHelper source;
AddrModeHelper destination;

// helper function to fetch register symbol
int getRegisterSymbol(EvaluateToken* reg, Symbol** sym) {
	*sym = NULL;

	// check if this is a register
	if (reg->type != Expression_Token_Type_Register) {
		return Expression_Result_Type_Not_Register;
	}

	// fetch the token
	Expression_Result_Type result = Expression_FetchSymbolByToken(reg, sym);

	if (result != Expression_Result_Type_Success) {
		return result;
	}

	// check if this is a 68k register
	if ((*sym)->type != Symbol_Type_Function_Register_68k) {
		return Expression_Result_Type_68k_Not_Register;
	}

	return Expression_Result_Type_Success;
}

// helper function to check if eval succeeded
c_inline void checkEvalSuccess(TokenTable* table, Expression_Result_Type result, AddrModeHelper* helper) {
	// check if return value was fine
	if (result < Expression_Result_Type_Success) {
		helper->eval = 1;

	} else if (result > Expression_Result_Type_Success) {
		// handle error
		Error_Eval(table, result);
	}
}

// helper function to safely evaluate a region of tokens
c_inline void evaluateHelper(TokenTable* table, AddrModeHelper* helper, EvaluateToken* start, EvaluateToken* end) {
	if (start == NULL || end == NULL) {
		Error_Error(ERRTXT_UNEXPECTED_EOL);
	}

	// clone the token table data
	helper->tokenStart = start;
	helper->tokenEnd = end;

	// process the actual evaluation
	checkEvalSuccess(table, Expression_Evaluate(table, start, end), helper);
}

// helper function to check for simple address relatives
uint16_t checkSimpleAddressRel(AddrModeHelper* helper) {
	// handle checking predecrement and postincrement
	EvaluateToken* tokenPre =
			(helper->tokenStart->type == Expression_Token_Type_Unary_Minus ? helper->tokenStart->next : helper->tokenStart);
	EvaluateToken* tokenPost = (helper->tokenEnd->type == Expression_Token_Type_Plus ? helper->tokenEnd->prev : helper->tokenEnd);

	if (tokenPre == NULL || tokenPost == NULL) {
		return EA68KCHK_Fail;
	}

	if (tokenPre->type == Expression_Token_Type_Paren_Open && tokenPost->type == Expression_Token_Type_Paren_Closed) {
		// check there is exactly 1 token in the middle
		if (tokenPost->prev == tokenPre->next) {
			// fetch the register token
			EvaluateToken* regToken = tokenPre->next;

			if (regToken == NULL) {
				return EA68KCHK_Fail;
			}

			// fetch the register
			Symbol* reg;
			Expression_Result_Type result = getRegisterSymbol(tokenPre->next, &reg);

			if (result != Expression_Result_Type_Success) {
				return EA68KCHK_Fail; // not a register
			}

			// check register mode
			if (reg->extraParam < REG68K_A0) {
				// (dn)
				Error_ErrorUnderline(buffers.line, helper->tokenStart->start, helper->tokenEnd->end, ERRFMT_68K_UNSUPPORTED_INDIRECT, reg->name);

			} else if (reg->extraParam <= REG68K_A7) {
				if (tokenPost != helper->tokenEnd && tokenPre != helper->tokenStart) {
					// -(an)+
					Error_ErrorUnderline(buffers.line, helper->tokenStart->start, helper->tokenEnd->end, ERRFMT_68K_UNSUPPORTED_PLUSMINUS, reg->name);

				} else if (tokenPre != helper->tokenStart) {
					// -(an)
					helper->mode = 4;
					helper->reg = reg->extraParam & 7;
					return EA68KCHK_Addr_PreDec;

				} else if (tokenPost != helper->tokenEnd) {
					// (an)+
					helper->mode = 3;
					helper->reg = reg->extraParam & 7;
					return EA68KCHK_Addr_PostInc;

				} else {
					// (an)
					helper->mode = 2;
					helper->reg = reg->extraParam & 7;
					return EA68KCHK_Addr_Indirect;
				}

			} else if (reg->extraParam == REG68K_PC) {
				if (tokenPre == helper->tokenStart && tokenPost == helper->tokenEnd) {
					// d16(pc)
					helper->mode = 7;
					helper->reg = 2;
					helper->extendInt = -objectAddress - 2;
					helper->extendUint = (uint32_t)helper->extendInt;
					return EA68KCHK_Addr_Indirect;
				}
			}
		}
	}

	return EA68KCHK_Fail;
}

// helper function to check for immedate values
uint16_t checkImmediate(TokenTable* table, AddrModeHelper* helper) {
	if (helper->tokenStart->type == Expression_Token_Type_NumSign) {
		// immediate mode
		helper->mode = 7;
		helper->reg = 4;

		// fetch param value
		evaluateHelper(table, helper, helper->tokenStart->next, helper->tokenEnd);

		Expression_Result_Type result = Expression_Result_Type_Success;

		// get extend value
		switch (helper->size) {
			case SIZE68K_Byte:; // parse as a byte value
				uint8_t resb;
				if ((result = Expression_EvaluateAsByte(table, &resb, 0)) <= Expression_Result_Type_Success) {
					helper->eval |= result < Expression_Result_Type_Success ? 1 : 0;
					helper->extendUint = (uint32_t)resb;
					helper->extendInt = (int32_t)(resb >= 0x80 ? (resb | 0xFFFFFF00) : resb);
					return EA68KCHK_Imm;
				}
				break;

			case SIZE68K_Word:; // parse as a word value
				uint16_t resw;
				if ((result = Expression_EvaluateAsWord(table, &resw, 0)) <= Expression_Result_Type_Success) {
					helper->eval |= result < Expression_Result_Type_Success ? 1 : 0;
					helper->extendUint = (uint32_t)resw;
					helper->extendInt = (int32_t)(resw >= 0x8000 ? (resw | 0xFFFF0000) : resw);
					return EA68KCHK_Imm;
				}
				break;

			case SIZE68K_Long: // parse as a longword value
				if ((result = Expression_EvaluateAsLong(table, &helper->extendUint, 0)) <= Expression_Result_Type_Success) {
					helper->eval |= result < Expression_Result_Type_Success ? 1 : 0;
					helper->extendInt = (int32_t)helper->extendUint;
					return EA68KCHK_Imm;
				}
				break;
		}

		// handle error
		Error_Eval(table, result);
	}

	return EA68KCHK_Fail;
}

// helper function to check for d16(x) and d8(x,y)
uint16_t checkAddrOffset(TokenTable* table, AddrModeHelper* helper) {
	uint16_t md = 0;
	Expression_Result_Type result = Expression_Result_Type_Success;

	// load tokenEnd-1 and tokenEnd-2
	EvaluateToken* realEnd = helper->tokenEnd;
	EvaluateToken* tokenM1 = helper->tokenEnd->prev;
	EvaluateToken* tokenM2 = NULL;
	EvaluateToken* tokenXM1 = helper->tokenEnd->prev;
	EvaluateToken* tokenXM2 = NULL;

	if (tokenM1 != NULL) {
		tokenXM2 = tokenM2 = tokenM1->prev;
	}

	if (tokenM2 != NULL && helper->tokenEnd->type == Expression_Token_Type_Paren_Closed && tokenM2 != helper->tokenStart) {
		uint16_t xnsize = 0;

		// check if .l or .w is defined
		if (tokenM2->type == Expression_Token_Type_Dot) {
			// fetch the .w or .l mode
			Symbol* reg;
			result = getRegisterSymbol(tokenM1, &reg);

			if (result == Expression_Result_Type_Success) {
				// check for .w and .l
				if (reg->extraParam == REG68K_W) {
					xnsize = 0x000;

				} else if (reg->extraParam == REG68K_L) {
					xnsize = 0x800;

				} else {
					// neither! :(
					return EA68KCHK_Fail;
				}

				// recalculate M1 and M2
				realEnd = tokenM2;
				tokenXM1 = realEnd->prev;
				tokenXM2 = NULL;

				if (tokenXM1 != NULL) {
					tokenXM2 = tokenXM1->prev;
				}
			}
		}

		// check if there is a comma
		if (tokenXM2 != NULL && tokenXM2->type == Expression_Token_Type_Comma) {
			// load first and second register so they're easier to access
			EvaluateToken* reg1 = tokenXM2->prev;
			EvaluateToken* reg2 = tokenXM1;

			if (tokenXM2->prev == NULL || reg1 == NULL) {
				goto checkd16;
			}

			// check opening parent
			if (reg1->prev->type != Expression_Token_Type_Paren_Open) {
				return EA68KCHK_Fail;
			}

			// make sure the previous token ISN'T a function
			if (reg1->prev->prev != NULL && reg1->prev->prev->type == Expression_Token_Type_Func_Start) {
				return EA68KCHK_Fail;
			}

			// fetch the registers for d16(pc/an)
			Symbol* regs1;
			Symbol* regs2;
			int result1 = getRegisterSymbol(reg1, &regs1);
			int result2 = getRegisterSymbol(reg2, &regs2);

			if (result1 == Expression_Result_Type_Not_Register || result2 == Expression_Result_Type_Not_Register) {
				return EA68KCHK_Fail; // not a register
			}

			if (result1 == Expression_Result_Type_68k_Not_Register) {
				// not 68k register
				Error_ErrorUnderline(buffers.line, reg1->start, reg1->end, ERRFMT_68K_REG_UNSUPPORTED, regs1->name);
			}

			if (result2 == Expression_Result_Type_68k_Not_Register) {
				// not 68k register
				Error_ErrorUnderline(buffers.line, reg2->start, reg2->end, ERRFMT_68K_REG_UNSUPPORTED, regs2->name);
			}

			// check for PC
			if (regs1->extraParam == REG68K_PC) {
				// d8(pc,xn)
				helper->mode = 7;
				helper->reg = 3;
				md = EA68KCHK_PC_d8xn;

			} else if (regs1->extraParam <= REG68K_A7 && regs1->extraParam >= REG68K_A0) {
				// d8(an,xn)
				helper->mode = 6;
				helper->reg = regs1->extraParam & 7;
				md = EA68KCHK_Addr_d8xn;

			} else {
				Error_ErrorUnderline(buffers.line, reg1->start, reg1->end, ERRFMT_68K_EA_D8xXN, regs1->name);
			}

			if (regs2->extraParam > REG68K_A7) {
				Error_ErrorUnderline(
						buffers.line, reg2->start, reg2->end, ERRFMT_68K_EA_D8xy, helper->mode == 7 ? "pc" : "an",
						regs2->name);
			}

			// load register into extend with .l or .w mode
			helper->extendUint = regs2->extraParam << 12;
			helper->extendUint |= xnsize;

			if (reg1->prev != helper->tokenStart) {
				// evaluate d8
				evaluateHelper(table, helper, helper->tokenStart, reg1->prev->prev);

				int8_t d8;
				if ((result = Expression_EvaluateAsInt8(table, &d8, helper->mode == 7 ? -objectAddress - 2 : 0)) > Expression_Result_Type_Success) {
					if (helper->eval == 0 || helper->mode != 7 || result != Expression_Result_Type_Value_OOR) {
						// failed!
						Error_Eval(table, result);
					}

				} else if (result < Expression_Result_Type_Success) {
					helper->eval = 1;
				}

				// do not set the value if can not evaluate
				if (helper->eval == 0) {
					helper->extendInt = (int32_t)d8;
					helper->extendUint |= (uint8_t)d8;
				}
			}

			return md;
		}

	checkd16:
		if (tokenM2 != NULL && xnsize == 0 && tokenM2->type == Expression_Token_Type_Paren_Open) {
			// make sure the previous token ISN'T a function
			if ((helper->tokenEnd - 3)->type == Expression_Token_Type_Func_Start) {
				return EA68KCHK_Fail;
			}

			// fetch the register for d16(pc/an)
			Symbol* reg;
			result = getRegisterSymbol(tokenM1, &reg);

			if (result == Expression_Result_Type_Not_Register) {
				return EA68KCHK_Fail; // not a register
			}

			if (result == Expression_Result_Type_68k_Not_Register) {
				// not 68k register
				Error_ErrorUnderline(buffers.line, tokenM1->start, tokenM1->end, ERRFMT_68K_REG_UNSUPPORTED, reg->name);
			}

			// check for PC
			if (reg->extraParam == REG68K_PC) {
				// d16(pc)
				helper->mode = 7;
				helper->reg = 2;
				md = EA68KCHK_PC_d16;

			} else if (reg->extraParam <= REG68K_A7 && reg->extraParam >= REG68K_A0) {
				// d16(an)
				helper->mode = 5;
				helper->reg = reg->extraParam & 7;
				md = EA68KCHK_Addr_d16;

			} else {
				Error_ErrorUnderline(buffers.line, tokenM1->start, tokenM1->end, ERRFMT_68K_EA_D16x, reg->name);
			}

			// evaluate d16
			evaluateHelper(table, helper, helper->tokenStart, tokenM2->prev);

			int16_t d16;
			if ((result = Expression_EvaluateAsInt16(table, &d16, helper->mode == 7 ? -objectAddress - 2 : 0)) > Expression_Result_Type_Success) {
				if (helper->eval == 0 || helper->mode != 7 || result != Expression_Result_Type_Value_OOR) {
					// failed!
					Error_Eval(table, result);
				}

			} else if (result < Expression_Result_Type_Success) {
				helper->eval = 1;
			}

			// check if this can be optimized to (an)
			if (options.optimizeZeroOffset && helper->mode != 7 && helper->eval == 0 &&
					result == Expression_Result_Type_Success && d16 == 0) {
				// wow! what a mess!
				helper->mode = 2;
				return EA68KCHK_Addr_Indirect;
			}

			// do not set the value if can not evaluate
			helper->extendInt = helper->eval == 0 ? (int32_t)d16 : 0;
			helper->extendUint = helper->eval == 0 ? (uint16_t)d16 : 0;
			return md;
		}
	}

	return EA68KCHK_Fail;
}

// helper function to check raw addresses
uint16_t checkRawAddr(TokenTable* table, AddrModeHelper* helper, uint8_t allowpc) {
	Expression_Result_Type result = Expression_Result_Type_Success;
	uint16_t md = EA68KCHK_Long_Addr;
	helper->mode = 7;
	helper->reg = 1;

	// load tokenEnd-1 and tokenEnd-2
	EvaluateToken* realEnd = helper->tokenEnd;
	EvaluateToken* tokenM1 = helper->tokenEnd->prev;
	EvaluateToken* tokenM2 = NULL;

	if (tokenM1 != NULL) {
		tokenM2 = tokenM1->prev;
	}

	// check for .l or .w
	if (tokenM2 != NULL && tokenM1 != helper->tokenStart && tokenM1->type == Expression_Token_Type_Dot) {
		// fetch the .w or .l mode
		Symbol* reg;
		result = getRegisterSymbol(helper->tokenEnd, &reg);

		if (result == Expression_Result_Type_Success) {
			realEnd = tokenM2;

			// check for .w and .l
			if (reg->extraParam == REG68K_W) {
				md = EA68KCHK_Word_Addr;

			} else if (reg->extraParam == REG68K_L) {
				// do nothing :-)

			} else {
				// neither! :(
				return EA68KCHK_Fail;
			}
		}
	}

	// evaluate the address value
	evaluateHelper(table, helper, helper->tokenStart, realEnd);

	// check for optimization
	if (md == EA68KCHK_Word_Addr || (options.optimizeWordAddr && helper->eval == 0)) {
		// evaluate as word
		uint16_t word;
		result = evaluateAsAddrMC68k(table, &word, 0);

		// check if we can go check the result now
		if (result == Expression_Result_Type_Success || md == EA68KCHK_Word_Addr) {
			helper->reg = 0;
			helper->extendUint = word;
			md = EA68KCHK_Word_Addr;
			goto fin;
		}
	}

	// check for pc-relative optimization
	if (allowpc && options.optimizePCRelative && helper->eval == 0) {
		// evaluate as word
		int16_t word;
		result = Expression_EvaluateAsInt16(table, &word, -objectAddress - 2);

		// check if the difference was actually ok
		if (result == Expression_Result_Type_Success) {
			helper->reg = 2;
			helper->extendUint = word;
			md = EA68KCHK_Addr_d16;
			goto fin;
		}
	}

	// evaluate as longword
	result = Expression_EvaluateAsLong(table, &helper->extendUint, 0);

// check if we succeeded actually
fin:
	checkEvalSuccess(table, result, helper);
	return md;
}

// helper function to check for registers
uint16_t checkRegister(AddrModeHelper* helper) {
	if (helper->tokenStart == helper->tokenEnd) {
		// fetch the register
		Symbol* reg;
		Expression_Result_Type result = getRegisterSymbol(helper->tokenStart, &reg);

		if (result == Expression_Result_Type_Not_Register) {
			return EA68KCHK_Fail; // not a register
		}

		if (result == Expression_Result_Type_68k_Not_Register) {
			// not 68k register
			Error_ErrorUnderline(
					buffers.line, helper->tokenStart->start, helper->tokenStart->end, ERRFMT_68K_REG_UNSUPPORTED,
					reg->name);
		}

		if (reg->extraParam <= REG68K_D7) {
			// data register mode
			helper->mode = 0;
			helper->reg = reg->extraParam;
			return EA68KCHK_Data;

		} else if (reg->extraParam <= REG68K_A7) {
			// address register mode
			helper->mode = 1;
			helper->reg = reg->extraParam & 7;
			return EA68KCHK_Addr;
		}

		// check all other registers
		switch (reg->extraParam) {
			case REG68K_SR:
				return EA68KCHK_SR;
			case REG68K_CCR:
				return EA68KCHK_CCR;
			case REG68K_USP:
				return EA68KCHK_USP;
			default:
				Error_ErrorUnderline(
						buffers.line, helper->tokenStart->start, helper->tokenStart->end, ERRFMT_68K_EA_INVALID_REG,
						reg->name);
		}
	}

	return EA68KCHK_Fail;
}

// function to process the addressing mode of the next operand
uint16_t loadAddressingMode(TokenTable* table, AddrModeHelper* helper, uint8_t allowpc) {
	uint16_t ret;

	// check for simple registers
	if ((ret = checkRegister(helper)) != EA68KCHK_Fail) {
		return ret;
	}

	// check for immediate
	if ((ret = checkImmediate(table, helper)) != EA68KCHK_Fail) {
		return ret;
	}

	// check for (an), -(an) and (an)+
	if ((ret = checkSimpleAddressRel(helper)) != EA68KCHK_Fail) {
		return ret;
	}

	// check for d8(pc/an,xn) and d16(pc/an)
	if ((ret = checkAddrOffset(table, helper)) != EA68KCHK_Fail) {
		return ret;
	}

	// check for word and longword addresses
	if ((ret = checkRawAddr(table, helper, allowpc)) != EA68KCHK_Fail) {
		return ret;
	}

	// no idea
	Error_ErrorUnderline(buffers.line, helper->argStart, helper->argEnd, ERRTXT_68K_EA_ILLEGAL);
}

// helper function to add data to pass2 if need to
uint8_t checkAddPass2(AddrModeHelper* helper, uint16_t patch, int64_t offset, uint16_t value) {
	if (helper->eval != 0) {
#ifdef DEBUG
		memTokenTable += Expression_CloneTokenTable(&helper->tokenStart, &helper->tokenEnd);
#else
		Expression_CloneTokenTable(&helper->tokenStart, &helper->tokenEnd);
#endif

		// add this value to pass 2
		addPass2Data(
				patch, objectAddress + offset, getObjectFilePos() + offset, helper->tokenStart,
				helper->tokenEnd, value);
		return 1;
	}

	return 0;
}

// function to write the extra data for addressing mode
void writeExtend(AddrModeHelper* helper) {
	switch (helper->id) {
		case EA68KCHK_Addr_d8xn:
			checkAddPass2(helper, Pass2_Patch_Int8, 1, 0);
			objWriteWordBE(helper->extendUint);
			break;

		case EA68KCHK_PC_d8xn:
			checkAddPass2(helper, Pass2_Patch_68k_Int8PC, 1, 0);
			objWriteWordBE(helper->extendUint);
			break;

		case EA68KCHK_Addr_d16:
			checkAddPass2(helper, Pass2_Patch_BE_Int16, 0, 0);
			objWriteWordBE(helper->extendUint);
			break;

		case EA68KCHK_PC_d16:
			checkAddPass2(helper, Pass2_Patch_68k_Int16PC, 0, 0);
			objWriteWordBE(helper->extendUint);
			break;

		case EA68KCHK_Word_Addr:
			checkAddPass2(helper, Pass2_Patch_68k_AddrWord, 0, 0);
			objWriteWordBE(helper->extendUint);
			break;

		case EA68KCHK_Long_Addr:
			checkAddPass2(helper, Pass2_Patch_BE_Long, 0, 0);
			objWriteLongBE(helper->extendUint);
			break;

		case EA68KCHK_Imm: // immediate mode special check
			switch (helper->size) {
				case SIZE68K_Byte:
					checkAddPass2(helper, Pass2_Patch_Byte, 1, 0);
					objWriteWordBE(helper->extendUint);
					break;

				case SIZE68K_Word:
					checkAddPass2(helper, Pass2_Patch_BE_Int16, 0, 0);
					objWriteWordBE(helper->extendUint);
					break;

				case SIZE68K_Long:
					checkAddPass2(helper, Pass2_Patch_BE_Long, 0, 0);
					objWriteLongBE(helper->extendUint);
					break;
			}
			break;
	}
}

// function to check if the next operand is a specific addressing mode
void checkAddressMode(TokenTable* table, uint16_t modeMask, int size, AddrModeHelper* helper) {
	// load token range
	EvaluateToken* end = Expression_FindArgumentEndPosition(table);
	helper->tokenStart = table->start;
	helper->tokenEnd = end - 1;

	// check if argument is invalid
	if (end == table->start) {
		Error_ErrorUnderline(buffers.line, (table->end - 1)->end, (table->end - 1)->end, ERRTXT_EXPECTED_MORE_ARGS);
	}

	// load the operand text range
	helper->argStart = table->start->start;
	helper->argEnd = helper->tokenEnd->end;

	// reset values
	helper->size = size;
	helper->eval = helper->extendInt = helper->extendUint = 0;

	// check addressing mode
	helper->id = loadAddressingMode(table, helper, modeMask & EA68KCHK_Addr_d16);

	// check if addressing mode is supported
	if ((modeMask & helper->id) == 0) {
		Error_ErrorUnderline(buffers.line, helper->argStart, helper->argEnd, ERRTXT_68K_EA_UNSUPPORTED_OP);
	}

	// handle value
	table->start = end + 1;
	Tracer_WriteAddressingModeM68k(helper);
}

// helper function to raise an error if there are extra operands
c_inline void checkExtraOperands(TokenTable* table, const char* error) {
	if (table->start <= table->end) {
		Error_ErrorUnderline(buffers.line, (table->start - 1)->start, (table->end - 1)->end, error);
	}
}

// function to get the next argument as a value
uint32_t getValueArg(TokenTable* table, uint64_t offset, AddrModeHelper* helper) {
	// load token range
	EvaluateToken* end = Expression_FindArgumentEndPosition(table);
	helper->tokenStart = table->start;
	helper->tokenEnd = end - 1;

	// check if argument is invalid
	if (end == table->start) {
		Error_ErrorUnderline(buffers.line, (table->end - 1)->end, (table->end - 1)->end, ERRTXT_EXPECTED_MORE_ARGS);
	}

	// load the operand text range
	helper->argStart = table->start->start;
	helper->argEnd = helper->tokenEnd->end;

	// reset values
	helper->eval = 0;

	// check addressing mode
	helper->id = EA68KCHK_Long_Addr;

	// fetch param value
	evaluateHelper(table, helper, helper->tokenStart, helper->tokenEnd);

	// evaluate as long and check for success
	checkEvalSuccess(table, Expression_EvaluateAsLong(table, &helper->extendUint, offset), helper);
	helper->extendInt = (int32_t)helper->extendUint;
	Tracer_WriteAddressingModeM68k(helper);

	// go to the next arg
	table->start = end + 1;
	return helper->extendUint;
}

// funtion to tokenize operands in the rest of the line
c_inline Expression_Result_Type parseArgs(TokenTable* table, uint8_t* buffer) {
	table->lineStart = buffers.line;
	uint8_t* end = buffer;

	// find eol
	while (*end)
		end++;

	// tokenize the symbol
	Expression_Result_Type result = Expression_Tokenize(buffer, end, table);

	if (result > Expression_Result_Type_Success) {
		Error_Eval(table, result);
	}

	// if result != Expression_Result_Type_Success, then we can at best figure out the addressing mode
	return result;
}

#define UNSIZED 0x00

#define SIZE_B 0x01
#define SIZE_W 0x02
#define SIZE_L 0x04
#define SIZE_S 0x08

#define DEFAULT_B (SIZE68K_Byte << 4)
#define DEFAULT_W (SIZE68K_Word << 4)
#define DEFAULT_L (SIZE68K_Long << 4)
#define DEFAULT_X (3 << 4)

uint8_t checkSizeField(uint8_t** buffer, uint8_t size) {
	uint8_t read = **buffer;

	// check if there's a size field specified
	if (read != '.') {

		// if not, check for end of line or invalid characters
		if (read == 0) {
			Error_ErrorUnderline(buffers.line, *buffer, *buffer, ERRTXT_UNEXPECTED_EOL);

		} else if (read != ' ') {
			Error_ErrorUnderline(buffers.line, *buffer, *buffer, ERRFMT_UNEXPECTED_IN_INPUT, read);

		} else {
			// return the default size
			return (size >> 4);
		}
	}

	// increment the line position
	(*buffer)++;

	// read out the instruction size
	read = **buffer;
	(*buffer)++;

	switch (read) {
		case 0:
			Error_ErrorUnderline(buffers.line, *buffer - 1, *buffer - 1, ERRTXT_UNEXPECTED_EOL);

		case ' ':
			Error_ErrorUnderline(buffers.line, *buffer - 1, *buffer - 1, ERRFMT_68K_SIZE_EXPECTED, read);

		case 'B':
		case 'b':
			if ((size & SIZE_B) == 0)
				goto invalid;
			return SIZE68K_Byte;

		case 'W':
		case 'w':
			if ((size & SIZE_W) == 0)
				goto invalid;
			return SIZE68K_Word;

		case 'L':
		case 'l':
			if ((size & SIZE_L) == 0)
				goto invalid;
			return SIZE68K_Long;

		case 'S':
		case 's':
			if ((size & SIZE_S) == 0)
				goto invalid;
			return SIZE68K_Byte;
		default:
			break;
	}

invalid:
	Error_ErrorUnderline(buffers.line, *buffer - 1, *buffer - 1, ERRFMT_68K_SIZE_INVALID, read);
}

#pragma endregion
#pragma region Common 1 Operand Instructions

/*
	EXT,EXTB - Sign-Extend
	CLR - Clear an Operand
	NEG - Negate
	NEGX - Negate with Extend
	NOT - Logical Complement
	TST - Test an Operand
	NBCD - Negate Decimal with Extend
	TAS - Test and Set an Operand
	JMP - Jump
	JSR - Jump to Subroutine
	PEA - Push Effective Address
	SWAP - Swap Register Halves
	UNLK - Unlink
	=======================================
	Instruction Format: iiii iiio oomm mnnn
		i - Instruction base
		o - Opmode
		m - Effective address mode
		n - Effective address register

	"param" specifies which instruction to encode
	---------------------------------------------

	EXT Notes:
		- Instruction base is 0100 100x xxxx xxxx
		- Opmode describes extention type; 010 = byte -> word, 011 = word -> long
		- Only accepts data registers, so effective address mode is always 000

	EXTB Notes:
		- Instruction base is 0100 100x xxxx xxxx
		- Opmode describes extention type; 111 = byte -> long
		- Only accepts data registers, so effective address mode is always 000

	CLR Notes:
		- Instruction base is 0100 001x xxxx xxxx
		- Opmode format is 0ss, where s is size

	NEG Notes:
		- Instruction base is 0100 010x xxxx xxxx
		- Opmode format is 0ss, where s is size

	NEGX Notes:
		- Instruction base is 0100 000x xxxx xxxx
		- Opmode format is 0ss, where s is size

	NOT Notes:
		- Instruction base is 0100 011x xxxx xxxx
		- Opmode format is 0ss, where s is size

	TST Notes:
		- Instruction base is 0100 101x xxxx xxxx
		- Opmode format is 0ss, where s is size
		- An, #<data>, (d16,PC), and (d8,PC,Xn) adressing modes are allowed with MC68020+

	NBCD Notes:
		- Instruction base is 0100 1000 00xx xxxx
		- No opmode field; harcoded value
		- Only byte size allowed

	TAS Notes:
		- Instruction base is 0100 1010 11xx xxxx, same as TST
		- No opmode field; harcoded value
		- Only byte size allowed

	JMP Notes:
		- Instruction base is 0100 1110 11xx xxxx
		- No opmode field; harcoded value
		- Unsized

	JSR Notes:
		- Instruction base is 0100 1110 10xx xxxx
		- No opmode field; harcoded value
		- Unsized

	PEA Notes:
		- Instruction base is 0100 1000 01xx xxxx
		- No opmode field; harcoded value
		- Only long size allowed

	SWAP Notes:
		- Instruction base is 0100 1000 0100 0xxx
		- No opmode or effective address mode fields; harcoded values
		- Only accepts data registers, so effective address mode is always 000 and won't interfere with the hardcoded value when OR'd together

	UNLK Notes:
		- Instruction base is 0100 1110 0101 1xxx
		- No opmode or effective address mode fields; harcoded values
		- Only accepts address registers, so effective address mode is always 001 and won't interfere with the hardcoded value when OR'd together
*/

// Base for common 1 op instructions
uint16_t MC68000_Base_Common1OP[] = {
		0x4800, // EXT
		0x4900, // EXTB (MC68020+)
		0x4200, // CLR
		0x4400, // NEG
		0x4000, // NEGX
		0x4600, // NOT
		0x4A00, // TST
		0x4A00, // TST (MC68020+)

		0x4AC0, // TAS
		0x4800, // NBCD
		0x4EC0, // JMP
		0x4E80, // JSR
		0x4840, // PEA
		0x4840, // SWAP
		0x4E58, // UNLK
};

// EA mode masks for logical insstructions
uint16_t MC68000_EAMask_Common1OP[] = {
		EA68KCHK_Data,																										// EXT
		EA68KCHK_Data,																										// EXTB (MC68020+)
		EA68KCHK_Common,																									// CLR
		EA68KCHK_Common,																									// NEG
		EA68KCHK_Common,																									// NEGX
		EA68KCHK_Common,																									// NOT
		EA68KCHK_Common,																									// TST
		EA68KCHK_Common | EA68KCHK_Addr | EA68KCHK_Imm | EA68KCHK_PC_Rel, // TST (MC68020+)

		EA68KCHK_Common,	 // TAS
		EA68KCHK_Common,	 // NBCD
		EA68KCHK_Location, // JMP
		EA68KCHK_Location, // JSR
		EA68KCHK_Location, // PEA
		EA68KCHK_Data,		 // SWAP
		EA68KCHK_Addr,		 // UNLK
};

// Size masks for common 1 op instructions
uint8_t MC68000_Size_Common1OP[] = {
		SIZE_W | SIZE_L | DEFAULT_W,					// EXT
		SIZE_L | DEFAULT_L,										// EXTB (MC68020+)
		SIZE_B | SIZE_W | SIZE_L | DEFAULT_W, // CLR
		SIZE_B | SIZE_W | SIZE_L | DEFAULT_W, // NEG
		SIZE_B | SIZE_W | SIZE_L | DEFAULT_W, // NEGX
		SIZE_B | SIZE_W | SIZE_L | DEFAULT_W, // NOT
		SIZE_B | SIZE_W | SIZE_L | DEFAULT_W, // TST
		SIZE_B | SIZE_W | SIZE_L | DEFAULT_W, // TST (MC68020+)

		SIZE_B | DEFAULT_B, // TAS
		SIZE_B | DEFAULT_B, // NBCD
		UNSIZED,						// JMP
		UNSIZED,						// JSR
		SIZE_L | DEFAULT_L, // PEA
		SIZE_W | DEFAULT_W, // SWAP
		UNSIZED,						// UNLK
};

void MC68000_Common1OP(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// select the appropriate instruction base
	uint16_t base = MC68000_Base_Common1OP[param];

	// check size field, with a special case for both EXT and EXTB
	uint8_t size = checkSizeField(&buffer, MC68000_Size_Common1OP[param]) + (param >= 2 ? 0 : 1);
	uint8_t* postsize = buffer;
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// check effective addressing mode
	checkAddressMode(&macroTable, MC68000_EAMask_Common1OP[param], size, &destination);

	// check for extra operands
	checkExtraOperands(&macroTable, ERRTXT_INS_EXPECTED_1_OPERAND);

	// throw an error if size was byte on address register direct operation (TST MC68020+ only)
	if (param == 7 && destination.id == EA68KCHK_Addr && size == 0) {
		Error_ErrorUnderline(buffers.line, postsize - 1, postsize - 1, ERRTXT_68K_INS_SIZE_ADDRREG);
	}

	// encode the instruction, output to the listings, and return (size is only
	// factored in when param is 7 or below)
	objWriteWordBE(base | (param <= 7 ? (size << 6) : 0) | (destination.mode << 3) | destination.reg);
	writeExtend(&destination);
	setListingsBytes();
}

#pragma endregion
#pragma region Trap Instruction

/*
	TRAP - Call Trap Vector
	=======================================
	Instruction Format: 0100 1110 0100 nnnn
		n - Vector number
*/

#define TRAP_BASE 0x4E40

void MC68000_Trap(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check the instruction size field to make sure it's empty
	checkSizeField(&buffer, UNSIZED);
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for operand 1
	checkAddressMode(&macroTable, EA68KCHK_Imm, SIZE68K_Byte, &destination);

	// check for extra operands
	checkExtraOperands(&macroTable, ERRTXT_INS_EXPECTED_1_OPERAND);

	// check for immediate max value and if we add it to pass 2
	if (!checkAddPass2(&destination, Pass2_Patch_Uint4_Low, 1, TRAP_BASE) && destination.extendUint > 0xF) {
		Error_ErrorUnderline(
				buffers.line, destination.argStart, destination.argEnd, ERRFMT_68K_TRAP_VECTOR,
				destination.extendUint);
	}

	// encode the instruction, output to the listings, and return
	objWriteWordBE(TRAP_BASE | destination.extendUint);
	setListingsBytes();
}

#pragma endregion
#pragma region SR + CCR Logical Instructions

/*
	STOP - Load Immediate to the Status Register and Stop
	EORI to SR - Exclusive-OR Immediate to the Status Register
	ORI to SR - Inclusive-OR Immediate to the Status Register
	ANDI to SR - Logical AND Immediate to the Status Register
	EORI to CCR - Exclusive-OR Immediate to the Condition Code Register
	ORI to CCR - Inclusive-OR Immediate to the Condition Code Register
	ANDI to CCR - Logical AND Immediate to the Condition Code Register
	=======================================
	Instruction Format: iiii iiii iiii iiii
		i - Instruction base

	"param" specifies which instruction to encode
	---------------------------------------------

	STOP Notes:
		- Instruction base 0100 1110 0111 0010

	EORI to SR Notes:
		- Instruction base 0000 1010 0111 1100

	ORI to SR Notes:
		- Instruction base 0000 0000 0111 1100

	ANDI to SR Notes:
		- Instruction base 0000 0010 0111 1100

	EORI to CCR Notes:
		- Instruction base 0000 1010 0011 1100

	ORI to CCR Notes:
		- Instruction base 0000 0000 0011 1100

	ANDI to CCR Notes:
		- Instruction base 0000 0010 0011 1100
*/

// Prototypes for encoding routines refrenced by this function
c_inline void MC68000_EncodeToSROrCCR(uint32_t param);

// Base for immediate to SR/CCR ins. STOP    EOR_SR  OR_SR   AND_SR  EOR_CCR OR_CCR  AND_CCR
uint16_t MC68000_Base_ImmSRCCR[] = {
		0x4E72,
		0x0A7C,
		0x007C,
		0x027C,
		0x0A3C,
		0x003C,
		0x023C,
};

void MC68000_Stop(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	checkSizeField(&buffer, SIZE_W | DEFAULT_W);
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for source operand
	checkAddressMode(&macroTable, EA68KCHK_Imm, SIZE68K_Word, &source);

	// check for extra operands
	checkExtraOperands(&macroTable, ERRTXT_INS_EXPECTED_1_OPERAND);

	// run the encoding function
	MC68000_EncodeToSROrCCR(param);
}

// EORI/ORI/ANDI to SR/CCR get to this function via the normal logical or immediate
// logical functions
c_inline void MC68000_EncodeToSROrCCR(uint32_t param) {
	objWriteWordBE(MC68000_Base_ImmSRCCR[param]);
	writeExtend(&source);
	setListingsBytes();
}

#pragma endregion
#pragma region ADDQ SUBQ

/*
	ADDQ - Add Quick
	SUBQ - Subtract Quick
	=======================================
	Instruction Format: 0101 dddo ssmm mnnn
		d - 3-bit immediate data
		o - Opmode: 0 = addition, 1 = subtraction
		m - Destination effective address mode
		n - Destination effective address register

	"param" specifies which instruction to encode
	---------------------------------------------
*/

// see if an integer can be used with addq or subq
Expression_Result_Type checkAddqSubqValue(uint16_t* base, int64_t value) {
	// check range is within integer limits
	if (value < -8 || value > 8) {
		return Expression_Result_Type_Value_OOR;

	} else if (value == 0) {
		return Expression_Result_Type_68k_Invalid_0;
	}

	// value is valid, check for negative values
	if (value < 0) {
		*base ^= 1;
		value = -value;
	}

	// convert 8 to 0
	value &= 7;

	// merge the value
	*base |= (value << 1);
	return Expression_Result_Type_Success;
}

#define ADDQ_BASE 0x50

void MC68000_AddqSubq(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	uint8_t size = checkSizeField(&buffer, SIZE_B | SIZE_W | SIZE_L | DEFAULT_W);
	uint8_t* postsize = buffer;
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the source operand
	checkAddressMode(&macroTable, EA68KCHK_Imm, size, &source);

	// check if we need this value to be handled in pass 2
	uint16_t base = ADDQ_BASE | param;

	if (checkAddPass2(&source, Pass2_Patch_68k_ADDQ_SUBQ, 0, base)) {
		base <<= 8;

	} else {
		// is in pass 1, we need to calculate the base properly
		Expression_Result_Type result = checkAddqSubqValue(&base, source.extendInt);
		base <<= 8;

		// check return value and print error if failed
		if (result != Expression_Result_Type_Success) {
			Error_Eval(&macroTable, result);
		}
	}

	// load addressing mode for the destination operand
	checkAddressMode(&macroTable, EA68KCHK_Common | EA68KCHK_Addr, size, &destination);

	// check for extra operands
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// thrown an error if the destination was address register direct and instruction size was byte
	if (destination.id == EA68KCHK_Addr && size == SIZE68K_Byte) {
		Error_ErrorUnderline(buffers.line, postsize - 1, postsize - 1, ERRTXT_68K_INS_SIZE_ADDRREG);
	}

	// encode the instruction, output to the listings, and return
	objWriteWordBE(base | (size << 6) | (destination.mode << 3) | destination.reg);
	writeExtend(&destination);
	setListingsBytes();
}

int MC68000_OptAddqSubq(uint8_t size, uint32_t param) {
	// set up the base
	uint16_t base = ADDQ_BASE | param;

	// check if value is in range
	if (checkAddqSubqValue(&base, source.extendInt) != Expression_Result_Type_Success) {
		// return unsuccessful if not
		return 0;
	}

	// encode the instruction, output to the listings, and return
	objWriteWordBE((base << 8) | (size << 6) | (destination.mode << 3) | destination.reg);
	writeExtend(&destination);
	setListingsBytes();
	return 1;
}

#pragma endregion
#pragma region Logical Instructions

/*
	EOR - Exclusive-OR
	OR - Inclusive-OR
	AND - Logical AND
	ADD - Add
	SUB - Subtract
	CMP - Compare
	=======================================
	Instruction Format: iiii rrro oomm mnnn
		i - Instruction base
		r - Data register ID
		o - Opmode: Lower 2 bits are instruction size, upper bit is tranfer direction (0 = <ea> -> Dn, 1 = Dn -> <ea>)
		m - Effective address mode
		n - Effective address register

	"param" specifies which instruction to encode
	---------------------------------------------

	EOR Notes:
		- Instruction base 1011 xxxx xxxx xxxx
		- Only allows Dn -> <ea>; top bit of opmode is always set

	OR Notes:
		- Instruction base 1000 xxxx xxxx xxxx

	AND Notes:
		- Instruction base 1100 xxxx xxxx xxxx

	ADD Notes:
		- Instruction base 1101 xxxx xxxx xxxx

	SUB Notes:
		- Instruction base 1001 xxxx xxxx xxxx

	CMP Notes:
		- Instruction base 1011 xxxx xxxx xxxx
		- Only allows <ea> -> Dn; top bit of opmode is always clear
		- Immediate version allows PC relative destinations on MC68020+
*/

// Prototypes for encoding routines refrenced by this function
c_inline void MC68000_EncodeLogImm(uint8_t size, uint32_t param);

c_inline void MC68000_EncodeLogAddr(uint16_t size, uint16_t base);

c_inline void MC68000_EncodeLogExt(uint16_t base, uint32_t param);

// Base for logical instructions    EOR     OR      AND     ADD     SUB     CMP	    CMP (MC68020+)
uint16_t MC68000_Base_Logical[] = {
		0xB000,
		0x8000,
		0xC000,
		0xD000,
		0x9000,
		0xB000,
		0xB000,
};

// EA mode masks for logical insstructions
uint16_t MC68000_EAMask_Src_Logical[] = {
		EA68KCHK_Data | EA68KCHK_Imm,																			// EOR Source
		EA68KCHK_Common | EA68KCHK_PC_Rel | EA68KCHK_Imm,									// OR Source
		EA68KCHK_Common | EA68KCHK_PC_Rel | EA68KCHK_Imm,									// AND Source
		EA68KCHK_Common | EA68KCHK_PC_Rel | EA68KCHK_Addr | EA68KCHK_Imm, // ADD Source
		EA68KCHK_Common | EA68KCHK_PC_Rel | EA68KCHK_Addr | EA68KCHK_Imm, // SUB Source
		EA68KCHK_Common | EA68KCHK_PC_Rel | EA68KCHK_Addr | EA68KCHK_Imm, // CMP Source
		EA68KCHK_Common | EA68KCHK_PC_Rel | EA68KCHK_Addr | EA68KCHK_Imm, // CMP Source (MC68020+)
};

uint16_t MC68000_EAMask_Dst_Logical[] = {
		EA68KCHK_Common | EA68KCHK_SR | EA68KCHK_CCR,														 // EOR Destination
		EA68KCHK_Common | EA68KCHK_SR | EA68KCHK_CCR,														 // OR Destination
		EA68KCHK_Common | EA68KCHK_SR | EA68KCHK_CCR,														 // AND Destination
		EA68KCHK_Common | EA68KCHK_Addr,																				 // ADD Destination
		EA68KCHK_Common | EA68KCHK_Addr,																				 // SUB Destination
		EA68KCHK_Data | EA68KCHK_Addr | EA68KCHK_Addr_PostInc,									 // CMP Destination
		EA68KCHK_Data | EA68KCHK_Addr | EA68KCHK_Addr_PostInc | EA68KCHK_PC_Rel, // CMP Destination (MC68020+)
};

void MC68000_LogicalOpr(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	uint8_t* presize = buffer;
	uint8_t size = checkSizeField(&buffer, SIZE_B | SIZE_W | SIZE_L | DEFAULT_W);
	uint8_t* postsize = buffer;
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the source and destination operands
	checkAddressMode(&macroTable, MC68000_EAMask_Src_Logical[param], size, &source);
	checkAddressMode(&macroTable, MC68000_EAMask_Dst_Logical[param], size, &destination);

	// check for extra operands
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// special case to encode CMP (Ay)+,(Ax)+ as CMPM
	if (param <= 5 && source.id == EA68KCHK_Addr_PostInc && destination.id == EA68KCHK_Addr_PostInc) {
		MC68000_EncodeLogExt(0xB108 | (size << 6), 4);
		return;
	}

	// check if we need to switch to an alternate encoding routine based on the addressing modes of each operand
	switch (destination.id) {
		case EA68KCHK_Addr:
			// thrown an error if instruction size was byte
			if (size == SIZE68K_Byte) {
				Error_ErrorUnderline(buffers.line, postsize - 1, postsize - 1, ERRTXT_68K_INS_SIZE_ADDRREG);
			}

			// check if this instruction can be optimized to a quick version
			if (options.optimizeADDQ && source.id == EA68KCHK_Imm && source.eval == 0 && (param == 3 || param == 4)) {
				if (MC68000_OptAddqSubq(size, param - 3) != 0) {
					return;
				}
			}

			// run the encoding function for ADDA, SUBA, and CMPA
			MC68000_EncodeLogAddr(size - 1, MC68000_Base_Logical[param]);
			return;

		case EA68KCHK_SR:
			// make sure that source is immediate
			if (source.id == EA68KCHK_Imm) {
				// thrown an error if instruction size was byte or long
				checkSizeField(&presize, SIZE_W | DEFAULT_W);

				// run the encoding function for EORI, ORI, ANDI, to SR
				MC68000_EncodeToSROrCCR(param + 1);
				return;

			} else {
				// if not, thrown an invalid adressing mode error
				Error_ErrorUnderline(buffers.line, source.argStart, destination.argEnd, ERRTXT_68K_EA_UNSUPPORTED_COMB);
			}

		case EA68KCHK_CCR:
			// make sure that source is immediate
			if (source.id == EA68KCHK_Imm) {
				// thrown an error if instruction size was word or long
				checkSizeField(&presize, SIZE_B | DEFAULT_B);

				// run the encoding function for EORI, ORI, ANDI, to CCR
				MC68000_EncodeToSROrCCR(param + 4);
				return;

			} else {
				// if not, thrown an invalid adressing mode error
				Error_ErrorUnderline(buffers.line, source.argStart, destination.argEnd, ERRTXT_68K_EA_UNSUPPORTED_COMB);
			}

		default:
			// check if source is immediate
			if (source.id == EA68KCHK_Imm) {
				// check if this instruction can be optimized to a quick version
				if (options.optimizeADDQ && source.eval == 0 && (param == 3 || param == 4)) {
					if (MC68000_OptAddqSubq(size, param - 3) != 0) {
						return;
					}
				}

				// run the encoding function for EORI, ORI, ANDI, ADDI, SUBI, and CMPI
				MC68000_EncodeLogImm(size, param);
				return;

				// make sure size is word for address register direct operations
			} else if (source.id == EA68KCHK_Addr && size == SIZE68K_Byte) {
				// thrown an error if instruction size was byte
				Error_ErrorUnderline(buffers.line, postsize - 1, postsize - 1, ERRTXT_68K_INS_SIZE_ADDRREG);

				// check that at least one of the operands is a data register
			} else if (source.id != EA68KCHK_Data && destination.id != EA68KCHK_Data) {
				// if not, thrown an invalid adressing mode error
				Error_ErrorUnderline(buffers.line, source.argStart, destination.argEnd, ERRTXT_68K_EA_UNSUPPORTED_COMB);
			}
	}

	// encode the instruction, output to the listings, and return
	if (destination.id != EA68KCHK_Data || param == 0) {
		objWriteWordBE(MC68000_Base_Logical[param] | (source.reg << 9) | ((size | 4) << 6) | (destination.mode << 3) | destination.reg);
		writeExtend(&destination);
	} else {
		objWriteWordBE(MC68000_Base_Logical[param] | (destination.reg << 9) | (size << 6) | (source.mode << 3) | source.reg);
		writeExtend(&source);
	}

	setListingsBytes();
}

#pragma endregion
#pragma region Logical Immediate Instructions

/*
	EORI - Exclusive-OR Immediate
	ORI - Inclusive-OR Immediate
	ANDI - Logical AND Immediate
	ADDI - Add Immediate
	SUBI - Subtract Immediate
	CMPI - Compare Immediate
	=======================================
	Instruction Format: 0000 iiii ssmm mnnn
		i - Instruction base
		s - Size field
		m - Effective address mode
		n - Effective address register

	"param" specifies which instruction to encode
	---------------------------------------------

	EORI Notes:
		- Instruction base 0000 1010 xxxx xxxx

	ORI Notes:
		- Instruction base 0000 0000 xxxx xxxx

	ANDI Notes:
		- Instruction base 0000 0010 xxxx xxxx

	ADDI Notes:
		- Instruction base 0000 0110 xxxx xxxx

	SUBI Notes:
		- Instruction base 0000 0100 xxxx xxxx

	CMPI Notes:
		- Instruction base 0000 1100 xxxx xxxx
*/

// Base for logical instructions       EORI   ORI    ANDI   ADDI   SUBI   CMPI   CMPI (MC68020+)
uint16_t MC68000_Base_LogicalImm[] = {
		0xA00,
		0x000,
		0x200,
		0x600,
		0x400,
		0xC00,
		0xC00,
};

uint16_t MC68000_EAMask_LogicalImm[] = {
		EA68KCHK_Common | EA68KCHK_SR | EA68KCHK_CCR,			 // EORI Destination
		EA68KCHK_Common | EA68KCHK_SR | EA68KCHK_CCR,			 // ORI Destination
		EA68KCHK_Common | EA68KCHK_SR | EA68KCHK_CCR,			 // ANDI Destination
		EA68KCHK_Common | EA68KCHK_Addr,									 // ADDI Destination
		EA68KCHK_Common | EA68KCHK_Addr,									 // SUBI Destination
		EA68KCHK_Common | EA68KCHK_Addr,									 // CMPI Destination
		EA68KCHK_Common | EA68KCHK_Addr | EA68KCHK_PC_Rel, // CMPI Destination (MC68020+)
};

void MC68000_LogicalImm(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	uint8_t* presize = buffer;
	uint8_t size = checkSizeField(&buffer, SIZE_B | SIZE_W | SIZE_L | DEFAULT_W);
	uint8_t* postsize = buffer;
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the source and destination operands
	checkAddressMode(&macroTable, EA68KCHK_Imm, size, &source);
	checkAddressMode(&macroTable, MC68000_EAMask_LogicalImm[param], size, &destination);

	// check for extra operands
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// check if we need to switch to an alternate encoding routine based on
	// destination operand
	switch (destination.id) {
		case EA68KCHK_Addr:
			// thrown an error if instruction size was byte
			if (size == SIZE68K_Byte) {
				Error_ErrorUnderline(buffers.line, postsize - 1, postsize - 1, ERRTXT_68K_INS_SIZE_ADDRREG);
			}

			// check if this instruction can be optimized to a quick version
			if (options.optimizeADDQ && source.eval == 0 && (param == 3 || param == 4)) {
				if (MC68000_OptAddqSubq(size, param - 3) != 0) {
					return;
				}
			}

			// run the encoding function for ADDA, SUBA, and CMPA
			MC68000_EncodeLogAddr(size - 1, MC68000_Base_Logical[param]);
			return;

		case EA68KCHK_SR:
			// thrown an error if instruction size was byte or long
			checkSizeField(&presize, SIZE_W | DEFAULT_W);

			// run the encoding function for EORI, ORI, ANDI, to SR
			MC68000_EncodeToSROrCCR(param + 1);
			return;

		case EA68KCHK_CCR:
			// thrown an error if instruction size was word or long
			checkSizeField(&presize, SIZE_B | DEFAULT_B);

			// run the encoding function for EORI, ORI, ANDI, to CCR
			MC68000_EncodeToSROrCCR(param + 4);
			return;

		default:
			// check if this instruction can be optimized to a quick version
			if (options.optimizeADDQ && source.eval == 0 && (param == 3 || param == 4)) {
				if (MC68000_OptAddqSubq(size, param - 3) != 0) {
					return;
				}
			}
	}

	// run the encoding function
	MC68000_EncodeLogImm(size, param);
}

c_inline void MC68000_EncodeLogImm(uint8_t size, uint32_t param) {
	// encode the instruction, output to the listings, and return
	objWriteWordBE(MC68000_Base_LogicalImm[param] | (size << 6) | (destination.mode << 3) | destination.reg);
	writeExtend(&source);
	writeExtend(&destination);
	setListingsBytes();
}

#pragma endregion
#pragma region Logical Address Instructions

/*
	LEA - Load Effective Address
	ADDA - Add Address
	SUBA - Subtract Address
	CMPA - Compare Address
	=======================================
	Instruction Format: iiii rrro oomm mnnn
		i - Instruction base
		r - Address register ID
		o - Opmode: 011 = word operation, 111 = long operation
		m - Effective address mode
		n - Effective address register

	"param" specifies which instruction to encode
	---------------------------------------------

	LEA Notes:
		- Instruction base 0100 xxxx xxxx xxxx
		- Long only

	ADDA Notes:
		- Instruction base 1101 xxxx xxxx xxxx

	SUBA Notes:
		- Instruction base 1001 xxxx xxxx xxxx

	CMPA Notes:
		- Instruction base 1011 xxxx xxxx xxxx

*/

void MC68000_LogicalAddr(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	uint8_t size = checkSizeField(&buffer, (param == 0 ? SIZE_L | DEFAULT_L : SIZE_W | SIZE_L | DEFAULT_W));
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the source and destination operands
	checkAddressMode(
			&macroTable,
			EA68KCHK_Location | (param == 0 ? 0 : EA68KCHK_Data | EA68KCHK_Addr | EA68KCHK_Addr_NoArg | EA68KCHK_Imm),
			size, &source);

	checkAddressMode(&macroTable, EA68KCHK_Addr, size, &destination);

	// check for extra operands
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// check if this instruction can be optimized to a quick version
	if (options.optimizeADDQ && source.eval == 0 && param < 5) {
		if (source.id == EA68KCHK_Imm && param != 0) {
			if (MC68000_OptAddqSubq(SIZE68K_Word, param - 3) != 0) {
				return;
			}

		} else if (source.id == EA68KCHK_Addr_d16 && source.reg == destination.reg) {
			if (MC68000_OptAddqSubq(SIZE68K_Word, param) != 0) {
				return;
			}
		}
	}

	// run the encoding function, passing the appropriate instruction base
	MC68000_EncodeLogAddr(size - 1, (param == 0 ? 0x4000 : MC68000_Base_Logical[param]));
}

// Size field conversion array
uint16_t MC68000_Opmode_LogicalAddr[] = {
		(3 << 6),
		(7 << 6),
};

c_inline void MC68000_EncodeLogAddr(uint16_t size, uint16_t base) {
	// get proper opmode based on the size argument
	size = MC68000_Opmode_LogicalAddr[size];

	// encode the instruction, output to the listings, and return
	objWriteWordBE(base | (destination.reg << 9) | size | (source.mode << 3) | source.reg);
	writeExtend(&source);
	setListingsBytes();
}

#pragma endregion
#pragma region Misc.Logical Instructions

/*
	ABCD - Add Decimal with Extend
	ADDX - Add Extended
	SBCD - Subtract Decimal with Extend
	SUBX - Subtract Extended
	CMPM - Compare Memory
	EXG - Exchange Registers
	=======================================
	Instruction Format: iiii xxx1 oooo oyyy
		x - Register Rx ID
		o - Opmode; see instruction specific notes for more info
		y - Register Ry ID

	"param" specifies which instruction to encode
	---------------------------------------------

	ABCD Notes:
		- Instruction base 1100 xxx1 xxxx xxxx
		- Opmode format is 0000m, where m determines the register mode. 0 = Dy,Dx. 1 = -(Ay),-(Ax).
		- Only byte size allowed
		- Rx is the Destination, Ry is the Source

	ADDX Notes:
		- Instruction base 1101 xxx1 xxxx xxxx
		- Opmode format is ss00m, where s is size and m determines the register mode. 0 = Dy,Dx. 1 = -(Ay),-(Ax).
		- Rx is the Destination, Ry is the Source

	SBCD Notes:
		- Instruction base 1000 xxx1 xxxx xxxx
		- Opmode format is 0000m, where m determines the register mode. 0 = Dy,Dx. 1 = -(Ay),-(Ax).
		- Only byte size allowed
		- Rx is the Destination, Ry is the Source

	SUBX Notes:
		- Instruction base 1001 xxx1 xxxx xxxx
		- Opmode format is ss00m, where s is size and m determines the register mode. 0 = Dy,Dx. 1 = -(Ay),-(Ax).
		- Rx is the Destination, Ry is the Source

	CMPM Notes:
		- Instruction base 1011 xxx1 xxxx xxxx
		- Opmode format is ss001, where s is size
		- Only register mode is (Ay)+,(Ax)+
		- Rx is the Destination, Ry is the Source

	EXG Notes:
		- Instruction base 1100 xxx1 xxxx xxxx
		- Opmode determines transfer mode. 01000 = Dx,Dy. 01001 = Ax,Ay. 10001 = Dx,Ay
		- Only long size allowed
		- Rx is the Source, Ry is the Destination
		- Syntax Ay,Dx is accepted, but assembled as Dx,Ay. In other words, in this case, Rx is the Destination, Ry is the Source.

*/

// Base for logical extended instr.    ABCD    ADDX    SBCD    SUBX    CMPM    EXG
uint16_t MC68000_Base_LogicalExt[] = {
		0xC100,
		0xD100,
		0x8100,
		0x9100,
		0xB100,
		0xC100,
};

// EA mode masks for logical extended instructions
uint16_t MC68000_EAMask_LogicalExt[] = {
		EA68KCHK_Data | EA68KCHK_Addr_PreDec, // ABCD
		EA68KCHK_Data | EA68KCHK_Addr_PreDec, // ADDX
		EA68KCHK_Data | EA68KCHK_Addr_PreDec, // SBCD
		EA68KCHK_Data | EA68KCHK_Addr_PreDec, // SUBX
		EA68KCHK_Addr_PostInc,								// CMPM
		EA68KCHK_Data | EA68KCHK_Addr,				// EXG
};

// Size masks for logical extended instructions
uint8_t MC68000_Size_LogicalExt[] = {
		SIZE_B | DEFAULT_B,										// ABCD
		SIZE_B | SIZE_W | SIZE_L | DEFAULT_W, // ADDX
		SIZE_B | DEFAULT_B,										// SBCD
		SIZE_B | SIZE_W | SIZE_L | DEFAULT_W, // SUBX
		SIZE_B | SIZE_W | SIZE_L | DEFAULT_W, // CMPM
		SIZE_L | DEFAULT_L,										// EXG
};

// EXG opmodes                   Dx,Dy Dx,Ay Ax,Ay
uint8_t MC68000_ExgOpmodes[] = {
		0x08,
		0x11,
		0x09,
};

void MC68000_LogicalExt(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// select the appropriate instruction base and effective address masks
	uint16_t base = MC68000_Base_LogicalExt[param];
	uint16_t eamask = MC68000_EAMask_LogicalExt[param];

	// check size field
	uint8_t size = checkSizeField(&buffer, MC68000_Size_LogicalExt[param]);
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the source and destination operands
	checkAddressMode(&macroTable, eamask, size, &source);
	checkAddressMode(&macroTable, eamask, size, &destination);

	// check for extra operands
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// build the opmode to be passed to the encoding function
	if (param < 5) {
		// thrown an error if the operand types don't match
		if (source.id != destination.id) {
			Error_ErrorUnderline(buffers.line, source.argStart, destination.argEnd, ERRTXT_68K_EA_UNSUPPORTED_COMB);
		}

		// convert size to opmode and set the M bit if operands are memory
		size = (size << 3) + (source.mode == 0 ? 0 : 1);

	} else {
		// assign the appropriate opmode for EXG based on the register types present
		size = MC68000_ExgOpmodes[source.mode + destination.mode];
	}

	// run the encoding function
	MC68000_EncodeLogExt((base | (size << 3)), param);
}

c_inline void MC68000_EncodeLogExt(uint16_t base, uint32_t param) {
	// special case for EXG to not reorder registers
	if (param == 5 && source.mode <= destination.mode) {
		objWriteWordBE(base | (source.reg << 9) | destination.reg);

	} else {
		objWriteWordBE(base | (destination.reg << 9) | source.reg);
	}

	setListingsBytes();
}

#pragma endregion
#pragma region MOVEQ

/*
	MOVEQ - Move quick
	=======================================
	Instruction Format: 0111 rrr0 8888 8888
		r - Data register ID
		8 - 8-bit value extended to longword to be moved

	Additional Notes:
		- Size field of b tells the assembler to allow assembly of 8-bit values >= $80
		- Size field of l tells the assembler to not allow assembly of 8-bit values >= $80
		- Undefined size field sends a warning about 8-bit values >= $80
*/

// helper to process moveq value
Expression_Result_Type checkMoveqValue(uint8_t size, uint64_t value, uint8_t* start, uint8_t* end) {
	// -0x80 to 0x7F are ok
	if ((int64_t)value >= -0x80 && (int64_t)value < 0x80) {
		return Expression_Result_Type_Success;
	}

	// check for > 0xFF
	if (value > 0xFF) {
		return Expression_Result_Type_Value_OOR;
	}

	// handle 0x80-0xFF
	switch (size) {
		case SIZE68K_Byte:
			return Expression_Result_Type_Success;
		case SIZE68K_Long:
			return Expression_Result_Type_Value_OOR;
		default:
			Error_WarnUnderline(buffers.line, start, end, ERRTXT_68K_MOVEQ_VAL);
			return Expression_Result_Type_Success;
	}
}

#define MOVEQ_BASE 0x7000

void MC68000_Moveq(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	uint8_t size = checkSizeField(&buffer, SIZE_B | SIZE_L | DEFAULT_X);
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the source operand
	checkAddressMode(&macroTable, EA68KCHK_Imm, SIZE68K_Long, &source);

	// check the value
	Expression_Result_Type result = checkMoveqValue(
			size, source.extendInt >= 0 ? source.extendUint : 0xFFFFFFFF00000000 | source.extendUint,
			source.argStart, source.argEnd);

	if (result != Expression_Result_Type_Success) {
		Error_Eval(&macroTable, result);
	}

	// load addressing mode for the destination operands
	checkAddressMode(&macroTable, EA68KCHK_Data, SIZE68K_Byte, &destination);

	// check for extra operands
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// check to add to pass2
	checkAddPass2(&source, Pass2_Patch_68k_MOVEQ, 1, size);

	// encode instruction
	objWriteWordBE(MOVEQ_BASE | (destination.reg << 9) | (uint8_t)source.extendUint);
	setListingsBytes();
}

#pragma endregion
#pragma region MOVEP

/*
	MOVEP - Move Peripheral Data
	=======================================
	Instruction Format: 0000 ddd1 os00 1aaa
		d - Data register ID
		o - Opmode: 0 = memory -> register, 1 = register -> memory
		s - Size: 0 = word, 1 = longword
		a - Address register ID
*/

#define MOVEP_BASE_MtR 0x0108
#define MOVEP_BASE_RtM 0x0188

void MC68000_Movep(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	uint8_t size = ((checkSizeField(&buffer, SIZE_W | SIZE_L | DEFAULT_W) - 1) << 6);
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the source and destination operands
	checkAddressMode(
			&macroTable, EA68KCHK_Data | EA68KCHK_Addr_Indirect | EA68KCHK_Addr_d16, SIZE68K_Word,
			&source);

	checkAddressMode(
			&macroTable, EA68KCHK_Data | EA68KCHK_Addr_Indirect | EA68KCHK_Addr_d16, SIZE68K_Word,
			&destination);

	// check if this is the last argument
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// encode the instruction
	if (destination.id == EA68KCHK_Data && source.id != EA68KCHK_Data) {
		objWriteWordBE(MOVEP_BASE_MtR | (destination.reg << 9) | size | source.reg);
		source.id = EA68KCHK_Addr_d16;
		writeExtend(&source);

	} else if (source.id == EA68KCHK_Data && destination.id != EA68KCHK_Data) {
		objWriteWordBE(MOVEP_BASE_RtM | (source.reg << 9) | size | destination.reg);
		destination.id = EA68KCHK_Addr_d16;
		writeExtend(&destination);

		// throw an error if the operand types are incorrect
	} else {
		Error_ErrorUnderline(buffers.line, source.argStart, destination.argEnd, ERRTXT_68K_EA_UNSUPPORTED_COMB);
	}

	// output to the listings and return
	setListingsBytes();
}

#pragma endregion
#pragma region MOVEM

/*
	MOVEM - Move multiple
	=======================================
	Instruction Format: 0100 1d00 1smm mnnn
						llll llll llll llll
		s - Transfer size
		d - Direction of movement. 0 = register -> memory, 1 = memory -> register
		m - Effective address mode
		n - Effective address register
		l - 16-bit register list mask
	---------------------------------------------

	Additional Notes:
		- immediate mode can be used as a replacement for register list
*/

// helper function to convert movem register list
int getMovemRegisterList(uint16_t* value, TokenTable* table, AddrModeHelper* helper) {
	*value = 0;
	Expression_Result_Type result = Expression_Result_Type_Success;

	// load token range
	EvaluateToken* end = Expression_FindArgumentEndPosition(table);
	helper->tokenStart = table->start;
	helper->tokenEnd = end - 1;

	// check if argument is invalid
	if (end == table->start) {
		Error_ErrorUnderline(buffers.line, (table->end - 1)->end, (table->end - 1)->end, ERRTXT_EXPECTED_MORE_ARGS);
	}

	// load the operand text range
	helper->argStart = table->start->start;
	helper->argEnd = helper->tokenEnd->end;

	// reset values
	helper->eval = 0;

	// check addressing mode
	helper->id = EA68KCHK_Long_Addr;

	// check if this is immediate mode
	if (helper->tokenStart->type == Expression_Token_Type_NumSign) {
		// fetch param value
		evaluateHelper(table, helper, helper->tokenStart->next, helper->tokenEnd);

		// convert to word
		result = Expression_EvaluateAsUint16(table, value, 0);
		goto nextarg;
	}

	// process each token to determine the register list
	EvaluateToken* cursor = helper->tokenStart;
	uint8_t mode = 0;				// 0 = /, 1 = -
	uint8_t lastReg = 0xFF; // used for xx-yy expression
	Symbol* reg;

	while (cursor != NULL && cursor <= helper->tokenEnd) {
		// fetch the current register and check its d0 to a7
		result = getRegisterSymbol(cursor, &reg);

		if (result != Expression_Result_Type_Success || reg->extraParam > REG68K_A7) {
			return Expression_Result_Type_68k_Not_Movem;
		}

		if (cursor->next && cursor->next <= helper->tokenEnd) {
			// check what mode to handle
			switch (cursor->next->type) {
				case Expression_Token_Type_Divide:
					mode = 0;
					break;
				case Expression_Token_Type_Minus:
					if (mode == 1) { // check for xx-yy-zz
						return Expression_Result_Type_68k_Not_Movem;
					}

					mode = 1;
					break;
				default:
					return Expression_Result_Type_68k_Not_Movem;
			}

			// go to the next cursor position
			cursor = cursor->next->next;

		} else {
			cursor = NULL;
		}

		// handle register assignment
		if (lastReg == 0xFF) {
			// not a register list yet
			if (mode == 1) {
				lastReg = (uint8_t)reg->extraParam;

			} else {
				*value |= 1 << (uint8_t)reg->extraParam;
			}

		} else {
			// range of registers
			for (uint8_t bit = MIN(lastReg, (uint8_t)reg->extraParam);
					 bit <= MAX(lastReg, (uint8_t)reg->extraParam); bit++) {
				*value |= 1 << bit;
			}

			lastReg = 0xFF;
		}
	}

nextarg: // go to the next arg
	table->start = end + 1;
	return result;
}

// helper function to invert register list on -(an) mode
c_inline uint16_t checkInvertRegisterList(uint16_t list, uint8_t invert) {
	if (invert == 0) {
		return list;
	}

	// invert bit order
	uint16_t res = 0;

	for (int i = 0; i < 16; i++) {
		res <<= 1;
		res |= (list & 1);
		list >>= 1;
	}

	return res;
}

#define MOVEM_BASE_TOMEM 0x48800000
#define MOVEM_BASE_FROMMEM 0x4C800000

void MC68000_Movem(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	uint8_t size = checkSizeField(&buffer, SIZE_W | SIZE_L | DEFAULT_W);
	uint32_t rsize = size == SIZE68K_Word ? 0 : 0x400000;
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// try parsing register list
	uint16_t registers;
	Expression_Result_Type result = getMovemRegisterList(&registers, &macroTable, &source);

	if (result <= Expression_Result_Type_Success) {
		// actually register list must also evaluate
		if (result != Expression_Result_Type_Success) {
			Error_Eval(&macroTable, result);
		}

		// movem registers -> memory
		checkAddressMode(
				&macroTable,
				EA68KCHK_Addr_Rel | EA68KCHK_Absolute | EA68KCHK_Addr_PreDec | EA68KCHK_Addr_Indirect,
				size, &destination);

		// check for extra operands
		checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

		// encode instruction
		objWriteLongBE(
				MOVEM_BASE_TOMEM | rsize | (destination.mode << 19) | (destination.reg << 16) |
				checkInvertRegisterList(registers, destination.id == EA68KCHK_Addr_PreDec));

		writeExtend(&destination);
		setListingsBytes();
		return;
	}

	// movem memory -> registers
	checkAddressMode(
			&macroTable,
			EA68KCHK_PC_Rel | EA68KCHK_Addr_Rel | EA68KCHK_Absolute | EA68KCHK_Addr_PostInc | EA68KCHK_Addr_Indirect,
			size, &source);

	// parse register list
	result = getMovemRegisterList(&registers, &macroTable, &destination);

	if (result != Expression_Result_Type_Success) {
		Error_Eval(&macroTable, result);
	}

	// check for extra operands
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// encode instruction
	objWriteLongBE(MOVEM_BASE_FROMMEM | rsize | (source.mode << 19) | (source.reg << 16) | registers);
	writeExtend(&source);
	setListingsBytes();
}

#pragma endregion
#pragma region Multiplication& Division

/*
	MULU - Multiply Unsigned
	MULS - Multiply Signed
	DIVU - Divide Unsigned
	DIVS - Divide Signed
	=======================================
	Instruction Format: iiii rrri iimm mnnn
		i - Instruction base
		r - Address register ID
		o - Opmode: 011 = word operation, 111 = long operation
		m - Effective address mode
		n - Effective address register

	"param" specifies which instruction to encode
	---------------------------------------------

	MULU Notes:
		- Instruction base 1100 rrr0 11mm mnnn

	MULS Notes:
		- Instruction base 1100 rrr1 11mm mnnn

	DIVU Notes:
		- Instruction base 1000 rrr0 11mm mnnn

	DIVS Notes:
		- Instruction base 1000 rrr1 11mm mnnn
*/

// Base for muldiv				 	 MULU    MULS    DIVU    DIVS
uint16_t MC68000_Base_MulDiv[] = {
		0xC0C0,
		0xC1C0,
		0x80C0,
		0x81C0,
};

void MC68000_MulDiv(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	checkSizeField(&buffer, SIZE_W | DEFAULT_W);
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the source and destination operands
	checkAddressMode(
			&macroTable, EA68KCHK_Location | EA68KCHK_Addr_NoArg | EA68KCHK_Data | EA68KCHK_Imm, SIZE68K_Word, &source);

	checkAddressMode(&macroTable, EA68KCHK_Data, SIZE68K_Word, &destination);

	// check for extra operands
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// encode instruction
	objWriteWordBE(MC68000_Base_MulDiv[param] | (destination.reg << 9) | (source.mode << 3) | source.reg);
	writeExtend(&source);
	setListingsBytes();
}

#pragma endregion
#pragma region Bitwise Instructions

/*
	BTST - Test a Bit
	BCHG - Test a Bit and Change
	BCLR - Test a Bit and Clear
	BSET - Test a Bit and Set
	======================================================
	Instruction Format (Dn as Source): 0000 rrr1 bbmm mnnn
	Instruction Format (#Imm as Source): 0000 1000 bbmm mnnn
		r - Data register ID
		b - Bit operation type: 00 = test, 01 = test & change, 10 = test & clear, 11 = test & set
		m - Effective address mode
		n - Effective address register

	"param" specifies which instruction to encode
	---------------------------------------------

	Additional Notes:
		- If Dn is the destination operand, size must be long. Otherwise, size is byte.
*/

void MC68000_Bitwise(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	uint8_t size = checkSizeField(&buffer, SIZE_B | SIZE_L | DEFAULT_X);
	uint8_t* postsize = buffer;
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the source and destination operands
	checkAddressMode(&macroTable, EA68KCHK_Data | EA68KCHK_Imm, SIZE68K_Byte, &source);
	checkAddressMode(
			&macroTable,
			EA68KCHK_Common | (param != 0 ? 0 : (EA68KCHK_PC_Rel | (source.id == EA68KCHK_Data ? EA68KCHK_Imm : 0))),
			SIZE68K_Byte, &destination);

	// check for extra operands
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// TODO: make a more specific error for each case
	// throw an error if the size isn't appropriate given the destination operand
	if ((destination.id == EA68KCHK_Data && size == SIZE68K_Byte) ||
			(destination.id != EA68KCHK_Data && size == SIZE68K_Long)) {
		Error_ErrorUnderline(buffers.line, postsize - 1, postsize - 1, ERRFMT_68K_SIZE_INVALID, *(postsize - 1));
	}

	// encode the instruction
	if (source.id == EA68KCHK_Data) {
		objWriteWordBE(0x0100 | (source.reg << 9) | param | (destination.mode << 3) | destination.reg);

		// TODO: range check the immediate value being passed based on the
		// destination operand (0-31 for Dn, 0-7 for everything else)
	} else {
		objWriteWordBE(0x0800 | param | (destination.mode << 3) | destination.reg);
		writeExtend(&source);
	}

	writeExtend(&destination);
	setListingsBytes();
}

#pragma endregion
#pragma region Shift Instructions

/*
	ASL,ASR - Arithmetic shift left/right
	LSL,LSR - Logical shift left/right
	ROL,ROR - Rotate left/right
	ROXL,ROXR - Rotate with eXtend left/right
	==========================================================
	Instruction Format (ea only):		   1110 0iid 11mm mnnn
	Instruction Format (count & register): 1110 cccd ssxi irrr
		i - Instruction base
		d - Shift direction. 0 = right, 1 = left
		m - Effective address mode
		n - Effective address register
		r - Destination data register ID
		x - 0 = immediate, 1 = register
		c - Data register ID or rotate count

	"param" specifies instruction base. lower 16 bits are for count & register, upper for ea mode
	---------------------------------------------

	ASL,ASR Notes:
		- Instruction base (cr) is 1110 xxxx xxx0 0xxx
		- Instruction base (ea) is 1110 000x 11xx xxxx

	LSL,LSR Notes:
		- Instruction base (cr) is 1110 xxxx xxx0 1xxx
		- Instruction base (ea) is 1110 001x 11xx xxxx

	ROL,ROR Notes:
		- Instruction base (cr) is 1110 xxxx xxx1 1xxx
		- Instruction base (ea) is 1110 011x 11xx xxxx

	ROXL,ROXR Notes:
		- Instruction base (cr) is 1110 xxxx xxx1 0xxx
		- Instruction base (ea) is 1110 010x 11xx xxxx
*/

// helper function to apply the shift count into the instruction
Expression_Result_Type getShiftCount(uint16_t* base, uint64_t value) {
	// check range is within integer limits
	if (value > 8) {
		return Expression_Result_Type_Value_OOR;

	} else if (value == 0) {
		return Expression_Result_Type_68k_Invalid_0;
	}

	// value is valid, convert 8 to 0
	value &= 7;

	// merge the value
	*base |= (value << 9);
	return Expression_Result_Type_Success;
}

void MC68000_Shift(uint8_t* buffer, uint32_t base) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	uint8_t size = checkSizeField(&buffer, SIZE_B | SIZE_W | SIZE_L | DEFAULT_W);
	uint8_t* postsize = buffer;
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load source addressing mode
	checkAddressMode(&macroTable, EA68KCHK_Common | EA68KCHK_Imm, size, &source);

	if (source.id != EA68KCHK_Data && source.id != EA68KCHK_Imm) {
		// check for extra operands
		checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

		// check size
		if (size != SIZE68K_Word) {
			Error_ErrorUnderline(buffers.line, postsize - 1, postsize - 1, ERRFMT_68K_SIZE_INVALID, *(postsize - 1));
		}

		// encode shift ea
		objWriteWordBE((base >> 16) | (source.mode << 3) | source.reg);
		writeExtend(&source);
		setListingsBytes();
		return;
	}

	// handle source parameter
	uint16_t _base = (uint16_t)base;

	if (source.id == EA68KCHK_Imm) {
		if (!checkAddPass2(&source, Pass2_Patch_68k_Shift_Count, 0, base)) {
			// convert immediate number
			Expression_Result_Type result = getShiftCount(&_base, source.extendUint);

			if (result != Expression_Result_Type_Success) {
				Error_Eval(&macroTable, result);
			}
		}

	} else {
		// add the data register instead
		_base |= (source.reg << 9) + 0x20;
	}

	// load destination addressing mode
	checkAddressMode(&macroTable, EA68KCHK_Data, size, &destination);

	// check for extra operands
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// encode shift
	objWriteWordBE(_base | (size << 6) | destination.reg);
	setListingsBytes();
}

#pragma endregion
#pragma region CC Instructions

/*
	BCC - Branch with condition code
	=======================================
	Instruction Format: 0110 cccc 8888 8888
		c - Condition code
		8 - 8-bit displacement (0 = 16-bit displacement, $FF = 32-bit displacement)
*/

#define BCC_BASE 0x6000

void MC68000_Bcc(uint8_t* buffer, uint32_t cc) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field (.l = check for backward optimization)
	uint8_t size = checkSizeField(&buffer, SIZE_B | SIZE_S | SIZE_W | DEFAULT_X);
	skipWhitespaceAndEOL(buffer, goto eol);

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the destination operand
	int32_t offset = (int32_t)getValueArg(&macroTable, -objectAddress - 2, &destination);

	// force a valid value if noeval is enabled
	if (destination.eval != 0) {
		offset = 2;

	} else if (options.optimizeShortBranch && size == SIZE68K_Word) {
		size = DEFAULT_X >> 4;
	}

	// check for extra operands
	checkExtraOperands(&macroTable, ERRTXT_INS_EXPECTED_1_OPERAND);

	Expression_Result_Type result = Expression_Result_Type_Success;

// handle the opcode itself
reeval:
	switch (size) {
		default:
			break;
		case (DEFAULT_X >> 4): { // unsized
			if (destination.eval == 0 && offset != 0 && offset >= -0x80 && offset <= 0x7F) {
				// re-evaluate as byte
				size = SIZE68K_Byte;
				goto reeval;
			}

			// re-evaluate as word
			size = SIZE68K_Word;
			goto reeval;
		}

		case SIZE68K_Byte: { // .s or .b
			if (offset < -0x80 || offset > 0x7F) {
				// displacement is out of range
				result = Expression_Result_Type_Value_OOR;
				goto evalerr;
			}

			if (offset == 0) {
				// displacement is 0
				result = Expression_Result_Type_68k_Invalid_0;
				goto evalerr;
			}

			// check to add to pass2
			checkAddPass2(&destination, Pass2_Patch_68k_BCC_Short, 1, 0);

			// encode instruction
			objWriteWordBE(BCC_BASE | cc | (uint8_t)offset);
			break;
		}

		case SIZE68K_Word: { // .w
			if (offset < -0x8000 || offset > 0x7FFF) {
				// displacement is out of range
				result = Expression_Result_Type_Value_OOR;
				goto evalerr;
			}

			// check to add to pass2
			checkAddPass2(&destination, Pass2_Patch_68k_Int16PC, 2, 0);

			// encode instruction
			objWriteLongBE(((BCC_BASE | cc) << 16) | (uint16_t)offset);
			break;
		}
	}

	setListingsBytes();
	return;

evalerr:
	Error_Eval(&macroTable, result);
eol:
	Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL);
}

/*
	DBCC - Branch with condition code and a loop counter
	=======================================
	Instruction Format: 0110 cccc 11oo 1rrr
		c - Condition code
		r - data register holding the counter
		followed by 16-bit displacement
*/

#define DBCC_BASE 0x50C8

void MC68000_Dbcc(uint8_t* buffer, uint32_t cc) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	uint8_t size = checkSizeField(&buffer, SIZE_W | DEFAULT_W);
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the source and destination operands
	checkAddressMode(&macroTable, EA68KCHK_Data, size, &source);
	int32_t offset = (int32_t)getValueArg(&macroTable, -objectAddress - 2, &destination);

	if (offset < -0x8000 || offset > 0x7FFF) {
		// displacement is out of range
		Error_Eval(&macroTable, Expression_Result_Type_Value_OOR);
	}

	// check if this is the last argument
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// check to add to pass2
	checkAddPass2(&destination, Pass2_Patch_68k_Int16PC, 2, 0);

	// encode instruction
	objWriteLongBE(((DBCC_BASE | cc | source.reg) << 16) | (uint16_t)offset);
	setListingsBytes();
}

/*
	SCC - Set According to Condition
	=======================================
	Instruction Format: 0101 cccc 11mm mnnn
		c - Condition code
		m - Destination effective address mode
		n - Destination effective address register
*/

#define SCC_BASE 0x50C0

void MC68000_Scc(uint8_t* buffer, uint32_t cc) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	checkSizeField(&buffer, SIZE_B | DEFAULT_B);
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the destination operand
	checkAddressMode(&macroTable, EA68KCHK_Common, SIZE68K_Byte, &destination);

	// check if this is the last argument
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// encode the instruction, output to the listings, and return
	objWriteWordBE(SCC_BASE | cc | (destination.mode << 3) | destination.reg);
	writeExtend(&destination);
	setListingsBytes();
}

#pragma endregion
#pragma region Move Instructions

/*
	MOVE - Move Data
	MOVEA - Move Address
	=======================================
	Instruction Format: 00ss nnnm mmxx xyyy
		s - Size field; 01 = bytes, 11 = word, 10 = long
		n - Destination effective address register
		m - Destination effective address mode
		x - Source effective address mode
		y - Source effective address register
*/

// Prototypes for encoding routines refrenced by this function
c_inline void MC68000_EncodeMoveSROrCCR(uint16_t base, AddrModeHelper* operand, uint8_t size, uint8_t* sizeptr);

c_inline void MC68000_EncodeMoveUSP(AddrModeHelper* operand, uint8_t size, uint8_t* sizeptr);

// EA mode masks for each operand of the instructon
#define EA68KCHK_MoveSrc                                                                         \
	(EA68KCHK_Data | EA68KCHK_Addr | EA68KCHK_Addr_NoArg | EA68KCHK_Addr_Rel | EA68KCHK_Absolute | \
	 EA68KCHK_Imm | EA68KCHK_PC_Rel | EA68KCHK_SR | EA68KCHK_USP)

#define EA68KCHK_MoveDst                                                                         \
	(EA68KCHK_Data | EA68KCHK_Addr | EA68KCHK_Addr_NoArg | EA68KCHK_Addr_Rel | EA68KCHK_Absolute | \
	 EA68KCHK_SR | EA68KCHK_CCR | EA68KCHK_USP)

// Size field conversion array    byte       word       long       default (word)
uint16_t MC68000_Size_Move[] = {(1 << 12), (3 << 12), (2 << 12), (3 << 12)};

void MC68000_Move(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	uint8_t size = checkSizeField(&buffer, SIZE_B | SIZE_W | SIZE_L | DEFAULT_X);
	uint8_t* postsize = buffer;
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the source and destination operands
	checkAddressMode(
			&macroTable, EA68KCHK_MoveSrc | (options.cpuModel >= MC68010 ? EA68KCHK_CCR : 0),
			(size == 3 ? SIZE68K_Word : size), &source);

	checkAddressMode(
			&macroTable, (param == 0 ? EA68KCHK_MoveDst : EA68KCHK_Addr | EA68KCHK_USP),
			size, &destination);

	// check for extra operands
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// check if we need to switch to an alternate encoding routine based on the
	// destination addressing mode
	switch (destination.id) {
		case EA68KCHK_SR:
			MC68000_EncodeMoveSROrCCR((0x46C0 | (source.mode << 3) | source.reg), &source, size, postsize);
			return;

		case EA68KCHK_CCR:
			MC68000_EncodeMoveSROrCCR((0x44C0 | (source.mode << 3) | source.reg), &source, size, postsize);
			return;

		case EA68KCHK_USP:
			MC68000_EncodeMoveUSP(&source, size, postsize);
			return;

		case EA68KCHK_Addr:
			// thrown an error if instruction size was byte
			if (size == SIZE68K_Byte) {
				Error_ErrorUnderline(buffers.line, postsize - 1, postsize - 1, ERRTXT_68K_INS_SIZE_ADDRREG);
			}
			break;
	}

	// check if we need to switch to an alternate encoding routine based on the source addressing mode
	switch (source.id) {
		case EA68KCHK_Imm:
			// check if this instruction can be optimized to MOVEQ
			if (options.optimizeMOVEQ && destination.id == EA68KCHK_Data && size == SIZE68K_Long && source.eval == 0) {
				// check if the immediate value is within MOVEQ's range
				if (checkMoveqValue(size, source.extendInt >= 0 ? source.extendUint : 0xFFFFFFFF00000000 | source.extendUint, source.argStart, source.argEnd) == Expression_Result_Type_Success) {
					// encode the instruction, output to the listings, and return
					objWriteWordBE(MOVEQ_BASE | (destination.reg << 9) | (uint8_t)source.extendUint);
					setListingsBytes();
					return;
				}
			}
			// continue encoding as normal
			break;

		case EA68KCHK_SR:
			MC68000_EncodeMoveSROrCCR((0x40C0 | (destination.mode << 3) | destination.reg), &destination, size, postsize);
			return;

		case EA68KCHK_CCR:
			MC68000_EncodeMoveSROrCCR((0x42C0 | (destination.mode << 3) | destination.reg), &destination, size, postsize);
			return;

		case EA68KCHK_USP:
			destination.reg |= 0x08;
			MC68000_EncodeMoveUSP(&destination, size, postsize);
			return;

		case EA68KCHK_Addr:
			// thrown an error if instruction size was byte
			if (size == SIZE68K_Byte) {
				Error_ErrorUnderline(buffers.line, postsize - 1, postsize - 1, ERRTXT_68K_INS_SIZE_ADDRREG);
			}
			break;
	}

	// encode the instruction, output to the listings, and return
	objWriteWordBE(MC68000_Size_Move[size] | (destination.reg << 9) | (destination.mode << 6) | (source.mode << 3) | source.reg);
	writeExtend(&source);
	writeExtend(&destination);
	setListingsBytes();
}

// Inline function to encode MOVE to/from SR or CCR
c_inline void MC68000_EncodeMoveSROrCCR(uint16_t base, AddrModeHelper* operand, uint8_t size, uint8_t* sizeptr) {
	// make sure that operand is a supported addressing mode
	if ((operand->id & (EA68KCHK_Addr | EA68KCHK_SR | EA68KCHK_CCR | EA68KCHK_USP)) != 0) {
		// if not, thrown an invalid adressing mode error
		Error_ErrorUnderline(buffers.line, source.argStart, destination.argEnd, ERRTXT_68K_EA_UNSUPPORTED_COMB);
	}

	// thrown an error if instruction size was byte or long
	if (size == SIZE68K_Byte || size == SIZE68K_Long) {
		Error_ErrorUnderline(buffers.line, sizeptr - 1, sizeptr - 1, ERRFMT_68K_SIZE_INVALID, *(sizeptr - 1));
	}

	// encode the instruction, output to the listings, and return
	objWriteWordBE(base);
	writeExtend(operand);
	setListingsBytes();
}

// Inline function to encode MOVE to/from USP
c_inline void MC68000_EncodeMoveUSP(AddrModeHelper* operand, uint8_t size, uint8_t* sizeptr) {
	// make sure that operand is not address register
	if (operand->id != EA68KCHK_Addr) {
		// if not, thrown an invalid adressing mode error
		Error_ErrorUnderline(buffers.line, source.argStart, destination.argEnd, ERRTXT_68K_EA_UNSUPPORTED_COMB);
	}

	// thrown an error if instruction size was byte or word
	if (size == SIZE68K_Byte || size == SIZE68K_Word) {
		Error_ErrorUnderline(buffers.line, sizeptr - 1, sizeptr - 1, ERRFMT_68K_SIZE_INVALID, *(sizeptr - 1));
	}

	// encode the instruction, output to the listings, and return
	objWriteWordBE(0x4E60 | operand->reg);
	setListingsBytes();
}

#pragma endregion
#pragma region Other Misc.Instructions

/*
	CHK - Check Register Against Bounds
	=======================================
	Instruction Format: 0100 rrrs s0mm mnnn
		r - Data register id
		s - Size Field: 11 = word, 10 = long (MC68020+)
		m - Source effective address mode
		n - Source effective address register
*/

uint16_t MC68000_Base_Chk[] = {
		0x4180,
		0x4100,
};

void MC68000_Chk(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	uint8_t size = checkSizeField(&buffer, SIZE_W | (options.cpuModel >= MC68020 ? SIZE_L : 0) | DEFAULT_W);
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the source and destination operands
	checkAddressMode(&macroTable, EA68KCHK_Common | EA68KCHK_Imm | EA68KCHK_PC_Rel, size, &source);
	checkAddressMode(&macroTable, EA68KCHK_Data, size, &destination);

	// check if this is the last argument
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// encode the instruction, output to the listings, and return
	objWriteWordBE(MC68000_Base_Chk[size - 1] | (destination.reg << 9) | (source.mode << 3) | source.reg);
	writeExtend(&source);
	setListingsBytes();
}

/*
	LINK - Link and Allocate
	=======================================
	Instruction Format: 0100 iiii iiii irrr
		i - Instruction base
		r - Address register id

	Additional notes:
		- Instruction base for word-size link is 0100 1110 0101 0xxx
		- Instruction base for long-size link is 0100 1000 0000 1xxx (MC68020+)
*/

uint16_t MC68000_Base_Link[] = {
		0x4E50,
		0x4808,
};

void MC68000_Link(uint8_t* buffer, uint32_t param) {
	// initial setup
	objWordAlign();
	objSetAddress();
	createLabelCheck();

	// check size field
	uint8_t size = checkSizeField(&buffer, SIZE_W | (options.cpuModel >= MC68020 ? SIZE_L : 0) | DEFAULT_W);
	skipWhitespaceAndEOL(buffer, Error_ErrorUnderline(buffers.line, buffer, buffer, ERRTXT_UNEXPECTED_EOL));

	// parse instruction operands
	parseArgs(&macroTable, buffer);

	// load addressing mode for the source and destination operands
	checkAddressMode(&macroTable, EA68KCHK_Addr, size, &source);
	checkAddressMode(&macroTable, EA68KCHK_Imm, size, &destination);

	// check if this is the last argument
	checkExtraOperands(&macroTable, ERRFUN_INS_EXPECTED_X_OPERANDS("2"));

	// encode the instruction, output to the listings, and return
	objWriteWordBE(MC68000_Base_Link[size - 1] | source.reg);
	writeExtend(&destination);
	setListingsBytes();
}

#pragma endregion
#pragma region Define instructions

/*
	helper for initializing instructions and variables
*/

struct MC68000Helper {
	void (*code)(uint8_t*, uint32_t);

	uint8_t* name;
	uint64_t param;
	uint32_t index;
	uint32_t hash;
	uint8_t type;
};

// clang-format off
struct MC68000Helper cpuSymbolList[] = {
		// registers
		{.type=Symbol_Type_Function_Register_68k, .index=BI_d0, .hash=HASH_d0, .param=REG68K_D0, .name=HN_D0,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_d1, .hash=HASH_d1, .param=REG68K_D1, .name=HN_D1,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_d2, .hash=HASH_d2, .param=REG68K_D2, .name=HN_D2,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_d3, .hash=HASH_d3, .param=REG68K_D3, .name=HN_D3,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_d4, .hash=HASH_d4, .param=REG68K_D4, .name=HN_D4,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_d5, .hash=HASH_d5, .param=REG68K_D5, .name=HN_D5,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_d6, .hash=HASH_d6, .param=REG68K_D6, .name=HN_D6,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_d7, .hash=HASH_d7, .param=REG68K_D7, .name=HN_D7,},

		{.type=Symbol_Type_Function_Register_68k, .index=BI_D0, .hash=HASH_D0, .param=REG68K_D0, .name=HN_D0,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_D1, .hash=HASH_D1, .param=REG68K_D1, .name=HN_D1,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_D2, .hash=HASH_D2, .param=REG68K_D2, .name=HN_D2,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_D3, .hash=HASH_D3, .param=REG68K_D3, .name=HN_D3,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_D4, .hash=HASH_D4, .param=REG68K_D4, .name=HN_D4,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_D5, .hash=HASH_D5, .param=REG68K_D5, .name=HN_D5,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_D6, .hash=HASH_D6, .param=REG68K_D6, .name=HN_D6,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_D7, .hash=HASH_D7, .param=REG68K_D7, .name=HN_D7,},

		{.type=Symbol_Type_Function_Register_68k, .index=BI_a0, .hash=HASH_a0, .param=REG68K_A0, .name=HN_A0,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_a1, .hash=HASH_a1, .param=REG68K_A1, .name=HN_A1,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_a2, .hash=HASH_a2, .param=REG68K_A2, .name=HN_A2,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_a3, .hash=HASH_a3, .param=REG68K_A3, .name=HN_A3,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_a4, .hash=HASH_a4, .param=REG68K_A4, .name=HN_A4,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_a5, .hash=HASH_a5, .param=REG68K_A5, .name=HN_A5,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_a6, .hash=HASH_a6, .param=REG68K_A6, .name=HN_A6,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_a7, .hash=HASH_a7, .param=REG68K_A7, .name=HN_A7,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_sp, .hash=HASH_sp, .param=REG68K_A7, .name=HN_SP,},

		{.type=Symbol_Type_Function_Register_68k, .index=BI_A0, .hash=HASH_A0, .param=REG68K_A0, .name=HN_A0,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_A1, .hash=HASH_A1, .param=REG68K_A1, .name=HN_A1,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_A2, .hash=HASH_A2, .param=REG68K_A2, .name=HN_A2,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_A3, .hash=HASH_A3, .param=REG68K_A3, .name=HN_A3,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_A4, .hash=HASH_A4, .param=REG68K_A4, .name=HN_A4,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_A5, .hash=HASH_A5, .param=REG68K_A5, .name=HN_A5,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_A6, .hash=HASH_A6, .param=REG68K_A6, .name=HN_A6,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_A7, .hash=HASH_A7, .param=REG68K_A7, .name=HN_A7,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_SP, .hash=HASH_SP, .param=REG68K_A7, .name=HN_SP,},

		{.type=Symbol_Type_Function_Register_68k, .index=BI_usp, .hash=HASH_usp, .param=REG68K_USP, .name=HN_USP,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_USP, .hash=HASH_USP, .param=REG68K_USP, .name=HN_USP,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_pc, .hash=HASH_pc, .param=REG68K_PC, .name=HN_PC,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_PC, .hash=HASH_PC, .param=REG68K_PC, .name=HN_PC,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_ccr, .hash=HASH_ccr, .param=REG68K_CCR, .name=HN_CCR,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_CCR, .hash=HASH_CCR, .param=REG68K_CCR, .name=HN_CCR,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_sr, .hash=HASH_sr, .param=REG68K_SR, .name=HN_SR,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_SR, .hash=HASH_SR, .param=REG68K_SR, .name=HN_SR,},

		{.type=Symbol_Type_Function_Register_68k, .index=BI_w, .hash=HASH_w, .param=REG68K_W, .name=HN_W,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_W, .hash=HASH_W, .param=REG68K_W, .name=HN_W,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_l, .hash=HASH_l, .param=REG68K_L, .name=HN_L,},
		{.type=Symbol_Type_Function_Register_68k, .index=BI_L, .hash=HASH_L, .param=REG68K_L, .name=HN_L,},

		// 68000 instructions with 0 operands
		{.type=Symbol_Type_Function, .index=BI_illegal, .hash=HASH_illegal, .code=&MC68000_Illegal, .param=0, .name=HN_ILLEGAL,},
		{.type=Symbol_Type_Function, .index=BI_ILLEGAL, .hash=HASH_ILLEGAL, .code=&MC68000_Illegal, .param=0, .name=HN_ILLEGAL,},
		{.type=Symbol_Type_Function, .index=BI_reset, .hash=HASH_reset, .code=&MC68000_Reset, .param=0, .name=HN_RESET,},
		{.type=Symbol_Type_Function, .index=BI_RESET, .hash=HASH_RESET, .code=&MC68000_Reset, .param=0, .name=HN_RESET,},
		{.type=Symbol_Type_Function, .index=BI_trapv, .hash=HASH_trapv, .code=&MC68000_Trapv, .param=0, .name=HN_TRAPV,},
		{.type=Symbol_Type_Function, .index=BI_TRAPV, .hash=HASH_TRAPV, .code=&MC68000_Trapv, .param=0, .name=HN_TRAPV,},
		{.type=Symbol_Type_Function, .index=BI_nop, .hash=HASH_nop, .code=&MC68000_Nop, .param=0, .name=HN_NOP,},
		{.type=Symbol_Type_Function, .index=BI_NOP, .hash=HASH_NOP, .code=&MC68000_Nop, .param=0, .name=HN_NOP,},
		{.type=Symbol_Type_Function, .index=BI_rte, .hash=HASH_rte, .code=&MC68000_Rte, .param=0, .name=HN_RTE,},
		{.type=Symbol_Type_Function, .index=BI_RTE, .hash=HASH_RTE, .code=&MC68000_Rte, .param=0, .name=HN_RTE,},
		{.type=Symbol_Type_Function, .index=BI_rts, .hash=HASH_rts, .code=&MC68000_Rts, .param=0, .name=HN_RTS,},
		{.type=Symbol_Type_Function, .index=BI_RTS, .hash=HASH_RTS, .code=&MC68000_Rts, .param=0, .name=HN_RTS,},
		{.type=Symbol_Type_Function, .index=BI_rtr, .hash=HASH_rtr, .code=&MC68000_Rtr, .param=0, .name=HN_RTR,},
		{.type=Symbol_Type_Function, .index=BI_RTR, .hash=HASH_RTR, .code=&MC68000_Rtr, .param=0, .name=HN_RTR,},

		// 68000 instructions with 1 operand
		{.type=Symbol_Type_Function, .index=BI_ext, .hash=HASH_ext, .code=&MC68000_Common1OP, .param=0, .name=HN_EXT,},
		{.type=Symbol_Type_Function, .index=BI_EXT, .hash=HASH_EXT, .code=&MC68000_Common1OP, .param=0, .name=HN_EXT,},
//	{ .type=Symbol_Type_Function, .index=BI_extb, .hash=HASH_extb, .code=&MC68000_Common1OP, .param=1, .name=HN_EXTB, },	// MC68020+
//	{ .type=Symbol_Type_Function, .index=BI_EXTB, .hash=HASH_EXTB, .code=&MC68000_Common1OP, .param=1, .name=HN_EXTB, },	// MC68020+
		{.type=Symbol_Type_Function, .index=BI_clr, .hash=HASH_clr, .code=&MC68000_Common1OP, .param=2, .name=HN_CLR,},
		{.type=Symbol_Type_Function, .index=BI_CLR, .hash=HASH_CLR, .code=&MC68000_Common1OP, .param=2, .name=HN_CLR,},
		{.type=Symbol_Type_Function, .index=BI_neg, .hash=HASH_neg, .code=&MC68000_Common1OP, .param=3, .name=HN_NEG,},
		{.type=Symbol_Type_Function, .index=BI_NEG, .hash=HASH_NEG, .code=&MC68000_Common1OP, .param=3, .name=HN_NEG,},
		{.type=Symbol_Type_Function, .index=BI_negx, .hash=HASH_negx, .code=&MC68000_Common1OP, .param=4, .name=HN_NEGX,},
		{.type=Symbol_Type_Function, .index=BI_NEGX, .hash=HASH_NEGX, .code=&MC68000_Common1OP, .param=4, .name=HN_NEGX,},
		{.type=Symbol_Type_Function, .index=BI_not, .hash=HASH_not, .code=&MC68000_Common1OP, .param=5, .name=HN_NOT,},
		{.type=Symbol_Type_Function, .index=BI_NOT, .hash=HASH_NOT, .code=&MC68000_Common1OP, .param=5, .name=HN_NOT,},
		{.type=Symbol_Type_Function, .index=BI_tst, .hash=HASH_tst, .code=&MC68000_Common1OP, .param=6, .name=HN_TST,},
		{.type=Symbol_Type_Function, .index=BI_TST, .hash=HASH_TST, .code=&MC68000_Common1OP, .param=6, .name=HN_TST,},
//	{ .type=Symbol_Type_Function, .index=BI_tst, .hash=HASH_tst, .code=&MC68000_Common1OP, .param=7, .name=HN_TST, },		// MC68020+ (different addressing mode capabilities)
//	{ .type=Symbol_Type_Function, .index=BI_TST, .hash=HASH_TST, .code=&MC68000_Common1OP, .param=7, .name=HN_TST, },		// MC68020+ (different addressing mode capabilities)
		{.type=Symbol_Type_Function, .index=BI_tas, .hash=HASH_tas, .code=&MC68000_Common1OP, .param=8, .name=HN_TAS,},
		{.type=Symbol_Type_Function, .index=BI_TAS, .hash=HASH_TAS, .code=&MC68000_Common1OP, .param=8, .name=HN_TAS,},
		{.type=Symbol_Type_Function, .index=BI_nbcd, .hash=HASH_nbcd, .code=&MC68000_Common1OP, .param=9, .name=HN_NBCD,},
		{.type=Symbol_Type_Function, .index=BI_NBCD, .hash=HASH_NBCD, .code=&MC68000_Common1OP, .param=9, .name=HN_NBCD,},
		{.type=Symbol_Type_Function, .index=BI_jmp, .hash=HASH_jmp, .code=&MC68000_Common1OP, .param=10, .name=HN_JMP,},
		{.type=Symbol_Type_Function, .index=BI_JMP, .hash=HASH_JMP, .code=&MC68000_Common1OP, .param=10, .name=HN_JMP,},
		{.type=Symbol_Type_Function, .index=BI_jsr, .hash=HASH_jsr, .code=&MC68000_Common1OP, .param=11, .name=HN_JSR,},
		{.type=Symbol_Type_Function, .index=BI_JSR, .hash=HASH_JSR, .code=&MC68000_Common1OP, .param=11, .name=HN_JSR,},
		{.type=Symbol_Type_Function, .index=BI_pea, .hash=HASH_pea, .code=&MC68000_Common1OP, .param=12, .name=HN_PEA,},
		{.type=Symbol_Type_Function, .index=BI_PEA, .hash=HASH_PEA, .code=&MC68000_Common1OP, .param=12, .name=HN_PEA,},
		{.type=Symbol_Type_Function, .index=BI_swap, .hash=HASH_swap, .code=&MC68000_Common1OP, .param=13, .name=HN_SWAP,},
		{.type=Symbol_Type_Function, .index=BI_SWAP, .hash=HASH_SWAP, .code=&MC68000_Common1OP, .param=13, .name=HN_SWAP,},
		{.type=Symbol_Type_Function, .index=BI_unlk, .hash=HASH_unlk, .code=&MC68000_Common1OP, .param=14, .name=HN_UNLK,},
		{.type=Symbol_Type_Function, .index=BI_UNLK, .hash=HASH_UNLK, .code=&MC68000_Common1OP, .param=14, .name=HN_UNLK,},

		{.type=Symbol_Type_Function, .index=BI_stop, .hash=HASH_stop, .code=&MC68000_Stop, .param=0, .name=HN_STOP,},
		{.type=Symbol_Type_Function, .index=BI_STOP, .hash=HASH_STOP, .code=&MC68000_Stop, .param=0, .name=HN_STOP,},
		{.type=Symbol_Type_Function, .index=BI_trap, .hash=HASH_trap, .code=&MC68000_Trap, .param=0, .name=HN_TRAP,},
		{.type=Symbol_Type_Function, .index=BI_TRAP, .hash=HASH_TRAP, .code=&MC68000_Trap, .param=0, .name=HN_TRAP,},

		// 68000 instructions with 2 operands
		{.type=Symbol_Type_Function, .index=BI_ADDQ, .hash=HASH_ADDQ, .code=&MC68000_AddqSubq, .param=0, .name=HN_ADDQ,},
		{.type=Symbol_Type_Function, .index=BI_addq, .hash=HASH_addq, .code=&MC68000_AddqSubq, .param=0, .name=HN_ADDQ,},
		{.type=Symbol_Type_Function, .index=BI_SUBQ, .hash=HASH_SUBQ, .code=&MC68000_AddqSubq, .param=1, .name=HN_SUBQ,},
		{.type=Symbol_Type_Function, .index=BI_subq, .hash=HASH_subq, .code=&MC68000_AddqSubq, .param=1, .name=HN_SUBQ,},

		{.type=Symbol_Type_Function, .index=BI_eor, .hash=HASH_eor, .code=&MC68000_LogicalOpr, .param=0, .name=HN_EOR,},
		{.type=Symbol_Type_Function, .index=BI_EOR, .hash=HASH_EOR, .code=&MC68000_LogicalOpr, .param=0, .name=HN_EOR,},
		{.type=Symbol_Type_Function, .index=BI_xor, .hash=HASH_xor, .code=&MC68000_LogicalOpr, .param=0, .name=HN_EOR,},
		{.type=Symbol_Type_Function, .index=BI_XOR, .hash=HASH_XOR, .code=&MC68000_LogicalOpr, .param=0, .name=HN_EOR,},
		{.type=Symbol_Type_Function, .index=BI_or, .hash=HASH_or, .code=&MC68000_LogicalOpr, .param=1, .name=HN_OR,},
		{.type=Symbol_Type_Function, .index=BI_OR, .hash=HASH_OR, .code=&MC68000_LogicalOpr, .param=1, .name=HN_OR,},
		{.type=Symbol_Type_Function, .index=BI_and, .hash=HASH_and, .code=&MC68000_LogicalOpr, .param=2, .name=HN_AND,},
		{.type=Symbol_Type_Function, .index=BI_AND, .hash=HASH_AND, .code=&MC68000_LogicalOpr, .param=2, .name=HN_AND,},
		{.type=Symbol_Type_Function, .index=BI_add, .hash=HASH_add, .code=&MC68000_LogicalOpr, .param=3, .name=HN_ADD,},
		{.type=Symbol_Type_Function, .index=BI_ADD, .hash=HASH_ADD, .code=&MC68000_LogicalOpr, .param=3, .name=HN_ADD,},
		{.type=Symbol_Type_Function, .index=BI_sub, .hash=HASH_sub, .code=&MC68000_LogicalOpr, .param=4, .name=HN_SUB,},
		{.type=Symbol_Type_Function, .index=BI_SUB, .hash=HASH_SUB, .code=&MC68000_LogicalOpr, .param=4, .name=HN_SUB,},
		{.type=Symbol_Type_Function, .index=BI_cmp, .hash=HASH_cmp, .code=&MC68000_LogicalOpr, .param=5, .name=HN_CMP,},
		{.type=Symbol_Type_Function, .index=BI_CMP, .hash=HASH_CMP, .code=&MC68000_LogicalOpr, .param=5, .name=HN_CMP,},
//	{ .type=Symbol_Type_Function, .index=BI_cmp, .hash=HASH_cmp, .code=&MC68000_LogicalOpr, .param=6, .name=HN_CMP, },		// MC68020+ (different addressing mode capabilities on immediate version)
//	{ .type=Symbol_Type_Function, .index=BI_CMP, .hash=HASH_CMP, .code=&MC68000_LogicalOpr, .param=6, .name=HN_CMP, },		// MC68020+ (different addressing mode capabilities on immediate version)

		{.type=Symbol_Type_Function, .index=BI_eori, .hash=HASH_eori, .code=&MC68000_LogicalImm, .param=0, .name=HN_EORI,},
		{.type=Symbol_Type_Function, .index=BI_EORI, .hash=HASH_EORI, .code=&MC68000_LogicalImm, .param=0, .name=HN_EORI,},
		{.type=Symbol_Type_Function, .index=BI_xori, .hash=HASH_xori, .code=&MC68000_LogicalImm, .param=0, .name=HN_EORI,},
		{.type=Symbol_Type_Function, .index=BI_XORI, .hash=HASH_XORI, .code=&MC68000_LogicalImm, .param=0, .name=HN_EORI,},
		{.type=Symbol_Type_Function, .index=BI_ori, .hash=HASH_ori, .code=&MC68000_LogicalImm, .param=1, .name=HN_ORI,},
		{.type=Symbol_Type_Function, .index=BI_ORI, .hash=HASH_ORI, .code=&MC68000_LogicalImm, .param=1, .name=HN_ORI,},
		{.type=Symbol_Type_Function, .index=BI_andi, .hash=HASH_andi, .code=&MC68000_LogicalImm, .param=2, .name=HN_ANDI,},
		{.type=Symbol_Type_Function, .index=BI_ANDI, .hash=HASH_ANDI, .code=&MC68000_LogicalImm, .param=2, .name=HN_ANDI,},
		{.type=Symbol_Type_Function, .index=BI_addi, .hash=HASH_addi, .code=&MC68000_LogicalImm, .param=3, .name=HN_ADDI,},
		{.type=Symbol_Type_Function, .index=BI_ADDI, .hash=HASH_ADDI, .code=&MC68000_LogicalImm, .param=3, .name=HN_ADDI,},
		{.type=Symbol_Type_Function, .index=BI_subi, .hash=HASH_subi, .code=&MC68000_LogicalImm, .param=4, .name=HN_SUBI,},
		{.type=Symbol_Type_Function, .index=BI_SUBI, .hash=HASH_SUBI, .code=&MC68000_LogicalImm, .param=4, .name=HN_SUBI,},
		{.type=Symbol_Type_Function, .index=BI_cmpi, .hash=HASH_cmpi, .code=&MC68000_LogicalImm, .param=5, .name=HN_CMPI,},
		{.type=Symbol_Type_Function, .index=BI_CMPI, .hash=HASH_CMPI, .code=&MC68000_LogicalImm, .param=5, .name=HN_CMPI,},
//	{ .type=Symbol_Type_Function, .index=BI_cmpi, .hash=HASH_cmpi, .code=&MC68000_LogicalImm, .param=6, .name=HN_CMPI, },	// MC68020+ (different addressing mode capabilities)
//	{ .type=Symbol_Type_Function, .index=BI_CMPI, .hash=HASH_CMPI, .code=&MC68000_LogicalImm, .param=6, .name=HN_CMPI, },	// MC68020+ (different addressing mode capabilities)

		{.type=Symbol_Type_Function, .index=BI_lea, .hash=HASH_lea, .code=&MC68000_LogicalAddr, .param=0, .name=HN_LEA,},
		{.type=Symbol_Type_Function, .index=BI_LEA, .hash=HASH_LEA, .code=&MC68000_LogicalAddr, .param=0, .name=HN_LEA,},
		{.type=Symbol_Type_Function, .index=BI_adda, .hash=HASH_adda, .code=&MC68000_LogicalAddr, .param=3, .name=HN_ADDA,},
		{.type=Symbol_Type_Function, .index=BI_ADDA, .hash=HASH_ADDA, .code=&MC68000_LogicalAddr, .param=3, .name=HN_ADDA,},
		{.type=Symbol_Type_Function, .index=BI_suba, .hash=HASH_suba, .code=&MC68000_LogicalAddr, .param=4, .name=HN_SUBA,},
		{.type=Symbol_Type_Function, .index=BI_SUBA, .hash=HASH_SUBA, .code=&MC68000_LogicalAddr, .param=4, .name=HN_SUBA,},
		{.type=Symbol_Type_Function, .index=BI_cmpa, .hash=HASH_cmpa, .code=&MC68000_LogicalAddr, .param=5, .name=HN_CMPA,},
		{.type=Symbol_Type_Function, .index=BI_CMPA, .hash=HASH_CMPA, .code=&MC68000_LogicalAddr, .param=5, .name=HN_CMPA,},

		{.type=Symbol_Type_Function, .index=BI_abcd, .hash=HASH_abcd, .code=&MC68000_LogicalExt, .param=0, .name=HN_ABCD,},
		{.type=Symbol_Type_Function, .index=BI_ABCD, .hash=HASH_ABCD, .code=&MC68000_LogicalExt, .param=0, .name=HN_ABCD,},
		{.type=Symbol_Type_Function, .index=BI_addx, .hash=HASH_addx, .code=&MC68000_LogicalExt, .param=1, .name=HN_ADDX,},
		{.type=Symbol_Type_Function, .index=BI_ADDX, .hash=HASH_ADDX, .code=&MC68000_LogicalExt, .param=1, .name=HN_ADDX,},
		{.type=Symbol_Type_Function, .index=BI_sbcd, .hash=HASH_sbcd, .code=&MC68000_LogicalExt, .param=2, .name=HN_SBCD,},
		{.type=Symbol_Type_Function, .index=BI_SBCD, .hash=HASH_SBCD, .code=&MC68000_LogicalExt, .param=2, .name=HN_SBCD,},
		{.type=Symbol_Type_Function, .index=BI_subx, .hash=HASH_subx, .code=&MC68000_LogicalExt, .param=3, .name=HN_SUBX,},
		{.type=Symbol_Type_Function, .index=BI_SUBX, .hash=HASH_SUBX, .code=&MC68000_LogicalExt, .param=3, .name=HN_SUBX,},
		{.type=Symbol_Type_Function, .index=BI_cmpm, .hash=HASH_cmpm, .code=&MC68000_LogicalExt, .param=4, .name=HN_CMPM,},
		{.type=Symbol_Type_Function, .index=BI_CMPM, .hash=HASH_CMPM, .code=&MC68000_LogicalExt, .param=4, .name=HN_CMPM,},
		{.type=Symbol_Type_Function, .index=BI_exg, .hash=HASH_exg, .code=&MC68000_LogicalExt, .param=5, .name=HN_EXG,},
		{.type=Symbol_Type_Function, .index=BI_EXG, .hash=HASH_EXG, .code=&MC68000_LogicalExt, .param=5, .name=HN_EXG,},

		{.type=Symbol_Type_Function, .index=BI_MOVE, .hash=HASH_MOVE, .code=&MC68000_Move, .param=0, .name=HN_MOVE,},
		{.type=Symbol_Type_Function, .index=BI_move, .hash=HASH_move, .code=&MC68000_Move, .param=0, .name=HN_MOVE,},
		{.type=Symbol_Type_Function, .index=BI_MOVEA, .hash=HASH_MOVEA, .code=&MC68000_Move, .param=1, .name=HN_MOVEA,},
		{.type=Symbol_Type_Function, .index=BI_movea, .hash=HASH_movea, .code=&MC68000_Move, .param=1, .name=HN_MOVEA,},
		{.type=Symbol_Type_Function, .index=BI_MOVEQ, .hash=HASH_MOVEQ, .code=&MC68000_Moveq, .param=0, .name=HN_MOVEQ,},
		{.type=Symbol_Type_Function, .index=BI_moveq, .hash=HASH_moveq, .code=&MC68000_Moveq, .param=0, .name=HN_MOVEQ,},
		{.type=Symbol_Type_Function, .index=BI_MOVEM, .hash=HASH_MOVEM, .code=&MC68000_Movem, .param=0, .name=HN_MOVEM,},
		{.type=Symbol_Type_Function, .index=BI_movem, .hash=HASH_movem, .code=&MC68000_Movem, .param=0, .name=HN_MOVEM,},
		{.type=Symbol_Type_Function, .index=BI_MOVEP, .hash=HASH_MOVEP, .code=&MC68000_Movep, .param=0, .name=HN_MOVEP,},
		{.type=Symbol_Type_Function, .index=BI_movep, .hash=HASH_movep, .code=&MC68000_Movep, .param=0, .name=HN_MOVEP,},

		{.type=Symbol_Type_Function, .index=BI_MULU, .hash=HASH_MULU, .code=&MC68000_MulDiv, .param=0, .name=HN_MULU,},
		{.type=Symbol_Type_Function, .index=BI_mulu, .hash=HASH_mulu, .code=&MC68000_MulDiv, .param=0, .name=HN_MULU,},
		{.type=Symbol_Type_Function, .index=BI_MULS, .hash=HASH_MULS, .code=&MC68000_MulDiv, .param=1, .name=HN_MULS,},
		{.type=Symbol_Type_Function, .index=BI_muls, .hash=HASH_muls, .code=&MC68000_MulDiv, .param=1, .name=HN_MULS,},
		{.type=Symbol_Type_Function, .index=BI_DIVU, .hash=HASH_DIVU, .code=&MC68000_MulDiv, .param=2, .name=HN_DIVU,},
		{.type=Symbol_Type_Function, .index=BI_divu, .hash=HASH_divu, .code=&MC68000_MulDiv, .param=2, .name=HN_DIVU,},
		{.type=Symbol_Type_Function, .index=BI_DIVS, .hash=HASH_DIVS, .code=&MC68000_MulDiv, .param=3, .name=HN_DIVS,},
		{.type=Symbol_Type_Function, .index=BI_divs, .hash=HASH_divs, .code=&MC68000_MulDiv, .param=3, .name=HN_DIVS,},

		{.type=Symbol_Type_Function, .index=BI_CHK, .hash=HASH_CHK, .code=&MC68000_Chk, .param=0, .name=HN_CHK,},
		{.type=Symbol_Type_Function, .index=BI_chk, .hash=HASH_chk, .code=&MC68000_Chk, .param=0, .name=HN_CHK,},
		{.type=Symbol_Type_Function, .index=BI_LINK, .hash=HASH_LINK, .code=&MC68000_Link, .param=0, .name=HN_LINK,},
		{.type=Symbol_Type_Function, .index=BI_link, .hash=HASH_link, .code=&MC68000_Link, .param=0, .name=HN_LINK,},

		// 68000 bit instructions
		{.type=Symbol_Type_Function, .index=BI_BTST, .hash=HASH_BTST, .code=&MC68000_Bitwise, .param=(0 << 6), .name=HN_BTST,},
		{.type=Symbol_Type_Function, .index=BI_btst, .hash=HASH_btst, .code=&MC68000_Bitwise, .param=(0 << 6), .name=HN_BTST,},
		{.type=Symbol_Type_Function, .index=BI_BCHG, .hash=HASH_BCHG, .code=&MC68000_Bitwise, .param=(1 << 6), .name=HN_BCHG,},
		{.type=Symbol_Type_Function, .index=BI_bchg, .hash=HASH_bchg, .code=&MC68000_Bitwise, .param=(1 << 6), .name=HN_BCHG,},
		{.type=Symbol_Type_Function, .index=BI_BCLR, .hash=HASH_BCLR, .code=&MC68000_Bitwise, .param=(2 << 6), .name=HN_BCLR,},
		{.type=Symbol_Type_Function, .index=BI_bclr, .hash=HASH_bclr, .code=&MC68000_Bitwise, .param=(2 << 6), .name=HN_BCLR,},
		{.type=Symbol_Type_Function, .index=BI_BSET, .hash=HASH_BSET, .code=&MC68000_Bitwise, .param=(3 << 6), .name=HN_BSET,},
		{.type=Symbol_Type_Function, .index=BI_bset, .hash=HASH_bset, .code=&MC68000_Bitwise, .param=(3 << 6), .name=HN_BSET,},

		// 68000 shift instructions
		{.type=Symbol_Type_Function, .index=BI_ASL, .hash=HASH_ASL, .code=&MC68000_Shift, .param=0xE1C0E100, .name=HN_ASL,},
		{.type=Symbol_Type_Function, .index=BI_asl, .hash=HASH_asl, .code=&MC68000_Shift, .param=0xE1C0E100, .name=HN_ASL,},
		{.type=Symbol_Type_Function, .index=BI_ASR, .hash=HASH_ASR, .code=&MC68000_Shift, .param=0xE0C0E000, .name=HN_ASR,},
		{.type=Symbol_Type_Function, .index=BI_asr, .hash=HASH_asr, .code=&MC68000_Shift, .param=0xE0C0E000, .name=HN_ASL,},
		{.type=Symbol_Type_Function, .index=BI_LSL, .hash=HASH_LSL, .code=&MC68000_Shift, .param=0xE1C0E108, .name=HN_LSL,},
		{.type=Symbol_Type_Function, .index=BI_lsl, .hash=HASH_lsl, .code=&MC68000_Shift, .param=0xE3C0E108, .name=HN_LSL,},
		{.type=Symbol_Type_Function, .index=BI_LSR, .hash=HASH_LSR, .code=&MC68000_Shift, .param=0xE2C0E008, .name=HN_LSR,},
		{.type=Symbol_Type_Function, .index=BI_lsr, .hash=HASH_lsr, .code=&MC68000_Shift, .param=0xE2C0E008, .name=HN_LSL,},
		{.type=Symbol_Type_Function, .index=BI_ROL, .hash=HASH_ROL, .code=&MC68000_Shift, .param=0xE7C0E118, .name=HN_ROL,},
		{.type=Symbol_Type_Function, .index=BI_rol, .hash=HASH_rol, .code=&MC68000_Shift, .param=0xE7C0E118, .name=HN_ROL,},
		{.type=Symbol_Type_Function, .index=BI_ROR, .hash=HASH_ROR, .code=&MC68000_Shift, .param=0xE6C0E018, .name=HN_ROR,},
		{.type=Symbol_Type_Function, .index=BI_ror, .hash=HASH_ror, .code=&MC68000_Shift, .param=0xE6C0E018, .name=HN_ROR,},
		{.type=Symbol_Type_Function, .index=BI_ROXL, .hash=HASH_ROXL, .code=&MC68000_Shift, .param=0xE5C0E110, .name=HN_ROXL,},
		{.type=Symbol_Type_Function, .index=BI_roxl, .hash=HASH_roxl, .code=&MC68000_Shift, .param=0xE5C0E110, .name=HN_ROXL,},
		{.type=Symbol_Type_Function, .index=BI_ROXR, .hash=HASH_ROXR, .code=&MC68000_Shift, .param=0xE4C0E010, .name=HN_ROXR,},
		{.type=Symbol_Type_Function, .index=BI_roxr, .hash=HASH_roxr, .code=&MC68000_Shift, .param=0xE4C0E010, .name=HN_ROXR,},
		{.type=Symbol_Type_Function, .index=BI_ROLX, .hash=HASH_ROLX, .code=&MC68000_Shift, .param=0xE5C0E110, .name=HN_ROLX,},
		{.type=Symbol_Type_Function, .index=BI_rolx, .hash=HASH_rolx, .code=&MC68000_Shift, .param=0xE5C0E110, .name=HN_ROLX,},
		{.type=Symbol_Type_Function, .index=BI_RORX, .hash=HASH_RORX, .code=&MC68000_Shift, .param=0xE4C0E010, .name=HN_RORX,},
		{.type=Symbol_Type_Function, .index=BI_rorx, .hash=HASH_rorx, .code=&MC68000_Shift, .param=0xE4C0E010, .name=HN_RORX,},

		// 68000 instructions with condition codes
		{.type=Symbol_Type_Function, .index=BI_BRA, .hash=HASH_BRA, .code=&MC68000_Bcc, .param=0x0000, .name=HN_BRA,},
		{.type=Symbol_Type_Function, .index=BI_bra, .hash=HASH_bra, .code=&MC68000_Bcc, .param=0x0000, .name=HN_BRA,},
		{.type=Symbol_Type_Function, .index=BI_BT, .hash=HASH_BT, .code=&MC68000_Bcc, .param=0x0000, .name=HN_BT,},
		{.type=Symbol_Type_Function, .index=BI_bt, .hash=HASH_bt, .code=&MC68000_Bcc, .param=0x0000, .name=HN_BT,},
		{.type=Symbol_Type_Function, .index=BI_BSR, .hash=HASH_BSR, .code=&MC68000_Bcc, .param=0x0100, .name=HN_BSR,},
		{.type=Symbol_Type_Function, .index=BI_bsr, .hash=HASH_bsr, .code=&MC68000_Bcc, .param=0x0100, .name=HN_BSR,},
		{.type=Symbol_Type_Function, .index=BI_BHI, .hash=HASH_BHI, .code=&MC68000_Bcc, .param=0x0200, .name=HN_BHI,},
		{.type=Symbol_Type_Function, .index=BI_bhi, .hash=HASH_bhi, .code=&MC68000_Bcc, .param=0x0200, .name=HN_BHI,},
		{.type=Symbol_Type_Function, .index=BI_BLS, .hash=HASH_BLS, .code=&MC68000_Bcc, .param=0x0300, .name=HN_BLS,},
		{.type=Symbol_Type_Function, .index=BI_bls, .hash=HASH_bls, .code=&MC68000_Bcc, .param=0x0300, .name=HN_BLS,},
		{.type=Symbol_Type_Function, .index=BI_BHS, .hash=HASH_BHS, .code=&MC68000_Bcc, .param=0x0400, .name=HN_BHS,},
		{.type=Symbol_Type_Function, .index=BI_bhs, .hash=HASH_bhs, .code=&MC68000_Bcc, .param=0x0400, .name=HN_BHS,},
		{.type=Symbol_Type_Function, .index=BI_BCC, .hash=HASH_BCC, .code=&MC68000_Bcc, .param=0x0400, .name=HN_BCC,},
		{.type=Symbol_Type_Function, .index=BI_bcc, .hash=HASH_bcc, .code=&MC68000_Bcc, .param=0x0400, .name=HN_BCC,},
		{.type=Symbol_Type_Function, .index=BI_BLO, .hash=HASH_BLO, .code=&MC68000_Bcc, .param=0x0500, .name=HN_BLO,},
		{.type=Symbol_Type_Function, .index=BI_blo, .hash=HASH_blo, .code=&MC68000_Bcc, .param=0x0500, .name=HN_BLO,},
		{.type=Symbol_Type_Function, .index=BI_BCS, .hash=HASH_BCS, .code=&MC68000_Bcc, .param=0x0500, .name=HN_BCS,},
		{.type=Symbol_Type_Function, .index=BI_bcs, .hash=HASH_bcs, .code=&MC68000_Bcc, .param=0x0500, .name=HN_BCS,},
		{.type=Symbol_Type_Function, .index=BI_BNE, .hash=HASH_BNE, .code=&MC68000_Bcc, .param=0x0600, .name=HN_BNE,},
		{.type=Symbol_Type_Function, .index=BI_bne, .hash=HASH_bne, .code=&MC68000_Bcc, .param=0x0600, .name=HN_BNE,},
		{.type=Symbol_Type_Function, .index=BI_BZC, .hash=HASH_BZC, .code=&MC68000_Bcc, .param=0x0600, .name=HN_BZC,},
		{.type=Symbol_Type_Function, .index=BI_bzc, .hash=HASH_bzc, .code=&MC68000_Bcc, .param=0x0600, .name=HN_BZC,},
		{.type=Symbol_Type_Function, .index=BI_BEQ, .hash=HASH_BEQ, .code=&MC68000_Bcc, .param=0x0700, .name=HN_BEQ,},
		{.type=Symbol_Type_Function, .index=BI_beq, .hash=HASH_beq, .code=&MC68000_Bcc, .param=0x0700, .name=HN_BEQ,},
		{.type=Symbol_Type_Function, .index=BI_BZS, .hash=HASH_BZS, .code=&MC68000_Bcc, .param=0x0700, .name=HN_BZS,},
		{.type=Symbol_Type_Function, .index=BI_bzs, .hash=HASH_bzs, .code=&MC68000_Bcc, .param=0x0700, .name=HN_BZS,},
		{.type=Symbol_Type_Function, .index=BI_BVC, .hash=HASH_BVC, .code=&MC68000_Bcc, .param=0x0800, .name=HN_BVC,},
		{.type=Symbol_Type_Function, .index=BI_bvc, .hash=HASH_bvc, .code=&MC68000_Bcc, .param=0x0800, .name=HN_BVC,},
		{.type=Symbol_Type_Function, .index=BI_BVS, .hash=HASH_BVS, .code=&MC68000_Bcc, .param=0x0900, .name=HN_BVS,},
		{.type=Symbol_Type_Function, .index=BI_bvs, .hash=HASH_bvs, .code=&MC68000_Bcc, .param=0x0900, .name=HN_BVS,},
		{.type=Symbol_Type_Function, .index=BI_BPL, .hash=HASH_BPL, .code=&MC68000_Bcc, .param=0x0A00, .name=HN_BPL,},
		{.type=Symbol_Type_Function, .index=BI_bpl, .hash=HASH_bpl, .code=&MC68000_Bcc, .param=0x0A00, .name=HN_BPL,},
		{.type=Symbol_Type_Function, .index=BI_BNC, .hash=HASH_BNC, .code=&MC68000_Bcc, .param=0x0A00, .name=HN_BNC,},
		{.type=Symbol_Type_Function, .index=BI_bnc, .hash=HASH_bnc, .code=&MC68000_Bcc, .param=0x0A00, .name=HN_BNC,},
		{.type=Symbol_Type_Function, .index=BI_BMI, .hash=HASH_BMI, .code=&MC68000_Bcc, .param=0x0B00, .name=HN_BMI,},
		{.type=Symbol_Type_Function, .index=BI_bmi, .hash=HASH_bmi, .code=&MC68000_Bcc, .param=0x0B00, .name=HN_BMI,},
		{.type=Symbol_Type_Function, .index=BI_BNS, .hash=HASH_BNS, .code=&MC68000_Bcc, .param=0x0B00, .name=HN_BNS,},
		{.type=Symbol_Type_Function, .index=BI_bns, .hash=HASH_bns, .code=&MC68000_Bcc, .param=0x0B00, .name=HN_BNS,},
		{.type=Symbol_Type_Function, .index=BI_BGE, .hash=HASH_BGE, .code=&MC68000_Bcc, .param=0x0C00, .name=HN_BGE,},
		{.type=Symbol_Type_Function, .index=BI_bge, .hash=HASH_bge, .code=&MC68000_Bcc, .param=0x0C00, .name=HN_BGE,},
		{.type=Symbol_Type_Function, .index=BI_BLT, .hash=HASH_BLT, .code=&MC68000_Bcc, .param=0x0D00, .name=HN_BLT,},
		{.type=Symbol_Type_Function, .index=BI_blt, .hash=HASH_blt, .code=&MC68000_Bcc, .param=0x0D00, .name=HN_BLT,},
		{.type=Symbol_Type_Function, .index=BI_BGT, .hash=HASH_BGT, .code=&MC68000_Bcc, .param=0x0E00, .name=HN_BGT,},
		{.type=Symbol_Type_Function, .index=BI_bgt, .hash=HASH_bgt, .code=&MC68000_Bcc, .param=0x0E00, .name=HN_BGT,},
		{.type=Symbol_Type_Function, .index=BI_BLE, .hash=HASH_BLE, .code=&MC68000_Bcc, .param=0x0F00, .name=HN_BLE,},
		{.type=Symbol_Type_Function, .index=BI_ble, .hash=HASH_ble, .code=&MC68000_Bcc, .param=0x0F00, .name=HN_BLE,},

		{.type=Symbol_Type_Function, .index=BI_DBRA, .hash=HASH_DBRA, .code=&MC68000_Dbcc, .param=0x0000, .name=HN_DBRA,},
		{.type=Symbol_Type_Function, .index=BI_dbra, .hash=HASH_dbra, .code=&MC68000_Dbcc, .param=0x0000, .name=HN_DBRA,},
		{.type=Symbol_Type_Function, .index=BI_DBT, .hash=HASH_DBT, .code=&MC68000_Dbcc, .param=0x0000, .name=HN_DBT,},
		{.type=Symbol_Type_Function, .index=BI_dbt, .hash=HASH_dbt, .code=&MC68000_Dbcc, .param=0x0000, .name=HN_DBT,},
		{.type=Symbol_Type_Function, .index=BI_DBF, .hash=HASH_DBF, .code=&MC68000_Dbcc, .param=0x0100, .name=HN_DBF,},
		{.type=Symbol_Type_Function, .index=BI_dbf, .hash=HASH_dbf, .code=&MC68000_Dbcc, .param=0x0100, .name=HN_DBF,},
		{.type=Symbol_Type_Function, .index=BI_DBHI, .hash=HASH_DBHI, .code=&MC68000_Dbcc, .param=0x0200, .name=HN_DBHI,},
		{.type=Symbol_Type_Function, .index=BI_dbhi, .hash=HASH_dbhi, .code=&MC68000_Dbcc, .param=0x0200, .name=HN_DBHI,},
		{.type=Symbol_Type_Function, .index=BI_DBLS, .hash=HASH_DBLS, .code=&MC68000_Dbcc, .param=0x0300, .name=HN_DBLS,},
		{.type=Symbol_Type_Function, .index=BI_dbls, .hash=HASH_dbls, .code=&MC68000_Dbcc, .param=0x0300, .name=HN_DBLS,},
		{.type=Symbol_Type_Function, .index=BI_DBHS, .hash=HASH_DBHS, .code=&MC68000_Dbcc, .param=0x0400, .name=HN_DBHS,},
		{.type=Symbol_Type_Function, .index=BI_dbhs, .hash=HASH_dbhs, .code=&MC68000_Dbcc, .param=0x0400, .name=HN_DBHS,},
		{.type=Symbol_Type_Function, .index=BI_DBCC, .hash=HASH_DBCC, .code=&MC68000_Dbcc, .param=0x0400, .name=HN_DBCC,},
		{.type=Symbol_Type_Function, .index=BI_dbcc, .hash=HASH_dbcc, .code=&MC68000_Dbcc, .param=0x0400, .name=HN_DBCC,},
		{.type=Symbol_Type_Function, .index=BI_DBLO, .hash=HASH_DBLO, .code=&MC68000_Dbcc, .param=0x0500, .name=HN_DBLO,},
		{.type=Symbol_Type_Function, .index=BI_dblo, .hash=HASH_dblo, .code=&MC68000_Dbcc, .param=0x0500, .name=HN_DBLO,},
		{.type=Symbol_Type_Function, .index=BI_DBCS, .hash=HASH_DBCS, .code=&MC68000_Dbcc, .param=0x0500, .name=HN_DBCS,},
		{.type=Symbol_Type_Function, .index=BI_dbcs, .hash=HASH_dbcs, .code=&MC68000_Dbcc, .param=0x0500, .name=HN_DBCS,},
		{.type=Symbol_Type_Function, .index=BI_DBNE, .hash=HASH_DBNE, .code=&MC68000_Dbcc, .param=0x0600, .name=HN_DBNE,},
		{.type=Symbol_Type_Function, .index=BI_dbne, .hash=HASH_dbne, .code=&MC68000_Dbcc, .param=0x0600, .name=HN_DBNE,},
		{.type=Symbol_Type_Function, .index=BI_DBZC, .hash=HASH_DBZC, .code=&MC68000_Dbcc, .param=0x0600, .name=HN_DBZC,},
		{.type=Symbol_Type_Function, .index=BI_dbzc, .hash=HASH_dbzc, .code=&MC68000_Dbcc, .param=0x0600, .name=HN_DBZC,},
		{.type=Symbol_Type_Function, .index=BI_DBEQ, .hash=HASH_DBEQ, .code=&MC68000_Dbcc, .param=0x0700, .name=HN_DBEQ,},
		{.type=Symbol_Type_Function, .index=BI_dbeq, .hash=HASH_dbeq, .code=&MC68000_Dbcc, .param=0x0700, .name=HN_DBEQ,},
		{.type=Symbol_Type_Function, .index=BI_DBZS, .hash=HASH_DBZS, .code=&MC68000_Dbcc, .param=0x0700, .name=HN_DBZS,},
		{.type=Symbol_Type_Function, .index=BI_dbzs, .hash=HASH_dbzs, .code=&MC68000_Dbcc, .param=0x0700, .name=HN_DBZS,},
		{.type=Symbol_Type_Function, .index=BI_DBVC, .hash=HASH_DBVC, .code=&MC68000_Dbcc, .param=0x0800, .name=HN_DBVC,},
		{.type=Symbol_Type_Function, .index=BI_dbvc, .hash=HASH_dbvc, .code=&MC68000_Dbcc, .param=0x0800, .name=HN_DBVC,},
		{.type=Symbol_Type_Function, .index=BI_DBVS, .hash=HASH_DBVS, .code=&MC68000_Dbcc, .param=0x0900, .name=HN_DBVS,},
		{.type=Symbol_Type_Function, .index=BI_dbvs, .hash=HASH_dbvs, .code=&MC68000_Dbcc, .param=0x0900, .name=HN_DBVS,},
		{.type=Symbol_Type_Function, .index=BI_DBPL, .hash=HASH_DBPL, .code=&MC68000_Dbcc, .param=0x0A00, .name=HN_DBPL,},
		{.type=Symbol_Type_Function, .index=BI_dbpl, .hash=HASH_dbpl, .code=&MC68000_Dbcc, .param=0x0A00, .name=HN_DBPL,},
		{.type=Symbol_Type_Function, .index=BI_DBNC, .hash=HASH_DBNC, .code=&MC68000_Dbcc, .param=0x0A00, .name=HN_DBNC,},
		{.type=Symbol_Type_Function, .index=BI_dbnc, .hash=HASH_dbnc, .code=&MC68000_Dbcc, .param=0x0A00, .name=HN_DBNC,},
		{.type=Symbol_Type_Function, .index=BI_DBMI, .hash=HASH_DBMI, .code=&MC68000_Dbcc, .param=0x0B00, .name=HN_DBMI,},
		{.type=Symbol_Type_Function, .index=BI_dbmi, .hash=HASH_dbmi, .code=&MC68000_Dbcc, .param=0x0B00, .name=HN_DBMI,},
		{.type=Symbol_Type_Function, .index=BI_DBNS, .hash=HASH_DBNS, .code=&MC68000_Dbcc, .param=0x0B00, .name=HN_DBNS,},
		{.type=Symbol_Type_Function, .index=BI_dbns, .hash=HASH_dbns, .code=&MC68000_Dbcc, .param=0x0B00, .name=HN_DBNS,},
		{.type=Symbol_Type_Function, .index=BI_DBGE, .hash=HASH_DBGE, .code=&MC68000_Dbcc, .param=0x0C00, .name=HN_DBGE,},
		{.type=Symbol_Type_Function, .index=BI_dbge, .hash=HASH_dbge, .code=&MC68000_Dbcc, .param=0x0C00, .name=HN_DBGE,},
		{.type=Symbol_Type_Function, .index=BI_DBLT, .hash=HASH_DBLT, .code=&MC68000_Dbcc, .param=0x0D00, .name=HN_DBLT,},
		{.type=Symbol_Type_Function, .index=BI_dblt, .hash=HASH_dblt, .code=&MC68000_Dbcc, .param=0x0D00, .name=HN_DBLT,},
		{.type=Symbol_Type_Function, .index=BI_DBGT, .hash=HASH_DBGT, .code=&MC68000_Dbcc, .param=0x0E00, .name=HN_DBGT,},
		{.type=Symbol_Type_Function, .index=BI_dbgt, .hash=HASH_dbgt, .code=&MC68000_Dbcc, .param=0x0E00, .name=HN_DBGT,},
		{.type=Symbol_Type_Function, .index=BI_DBLE, .hash=HASH_DBLE, .code=&MC68000_Dbcc, .param=0x0F00, .name=HN_DBLE,},
		{.type=Symbol_Type_Function, .index=BI_dble, .hash=HASH_dble, .code=&MC68000_Dbcc, .param=0x0F00, .name=HN_DBLE,},

		{.type=Symbol_Type_Function, .index=BI_ST, .hash=HASH_ST, .code=&MC68000_Scc, .param=0x0000, .name=HN_ST,},
		{.type=Symbol_Type_Function, .index=BI_st, .hash=HASH_st, .code=&MC68000_Scc, .param=0x0000, .name=HN_ST,},
		{.type=Symbol_Type_Function, .index=BI_SF, .hash=HASH_SF, .code=&MC68000_Scc, .param=0x0100, .name=HN_SF,},
		{.type=Symbol_Type_Function, .index=BI_sf, .hash=HASH_sf, .code=&MC68000_Scc, .param=0x0100, .name=HN_SF,},
		{.type=Symbol_Type_Function, .index=BI_SHI, .hash=HASH_SHI, .code=&MC68000_Scc, .param=0x0200, .name=HN_SHI,},
		{.type=Symbol_Type_Function, .index=BI_shi, .hash=HASH_shi, .code=&MC68000_Scc, .param=0x0200, .name=HN_SHI,},
		{.type=Symbol_Type_Function, .index=BI_SLS, .hash=HASH_SLS, .code=&MC68000_Scc, .param=0x0300, .name=HN_SLS,},
		{.type=Symbol_Type_Function, .index=BI_sls, .hash=HASH_sls, .code=&MC68000_Scc, .param=0x0300, .name=HN_SLS,},
		{.type=Symbol_Type_Function, .index=BI_SHS, .hash=HASH_SHS, .code=&MC68000_Scc, .param=0x0400, .name=HN_SHS,},
		{.type=Symbol_Type_Function, .index=BI_shs, .hash=HASH_shs, .code=&MC68000_Scc, .param=0x0400, .name=HN_SHS,},
		{.type=Symbol_Type_Function, .index=BI_SCC, .hash=HASH_SCC, .code=&MC68000_Scc, .param=0x0400, .name=HN_SCC,},
		{.type=Symbol_Type_Function, .index=BI_scc, .hash=HASH_scc, .code=&MC68000_Scc, .param=0x0400, .name=HN_SCC,},
		{.type=Symbol_Type_Function, .index=BI_SLO, .hash=HASH_SLO, .code=&MC68000_Scc, .param=0x0500, .name=HN_SLO,},
		{.type=Symbol_Type_Function, .index=BI_slo, .hash=HASH_slo, .code=&MC68000_Scc, .param=0x0500, .name=HN_SLO,},
		{.type=Symbol_Type_Function, .index=BI_SCS, .hash=HASH_SCS, .code=&MC68000_Scc, .param=0x0500, .name=HN_SCS,},
		{.type=Symbol_Type_Function, .index=BI_scs, .hash=HASH_scs, .code=&MC68000_Scc, .param=0x0500, .name=HN_SCS,},
		{.type=Symbol_Type_Function, .index=BI_SNE, .hash=HASH_SNE, .code=&MC68000_Scc, .param=0x0600, .name=HN_SNE,},
		{.type=Symbol_Type_Function, .index=BI_sne, .hash=HASH_sne, .code=&MC68000_Scc, .param=0x0600, .name=HN_SNE,},
		{.type=Symbol_Type_Function, .index=BI_SZC, .hash=HASH_SZC, .code=&MC68000_Scc, .param=0x0600, .name=HN_SZC,},
		{.type=Symbol_Type_Function, .index=BI_szc, .hash=HASH_szc, .code=&MC68000_Scc, .param=0x0600, .name=HN_SZC,},
		{.type=Symbol_Type_Function, .index=BI_SEQ, .hash=HASH_SEQ, .code=&MC68000_Scc, .param=0x0700, .name=HN_SEQ,},
		{.type=Symbol_Type_Function, .index=BI_seq, .hash=HASH_seq, .code=&MC68000_Scc, .param=0x0700, .name=HN_SEQ,},
		{.type=Symbol_Type_Function, .index=BI_SZS, .hash=HASH_SZS, .code=&MC68000_Scc, .param=0x0700, .name=HN_SZS,},
		{.type=Symbol_Type_Function, .index=BI_szs, .hash=HASH_szs, .code=&MC68000_Scc, .param=0x0700, .name=HN_SZS,},
		{.type=Symbol_Type_Function, .index=BI_SVC, .hash=HASH_SVC, .code=&MC68000_Scc, .param=0x0800, .name=HN_SVC,},
		{.type=Symbol_Type_Function, .index=BI_svc, .hash=HASH_svc, .code=&MC68000_Scc, .param=0x0800, .name=HN_SVC,},
		{.type=Symbol_Type_Function, .index=BI_SVS, .hash=HASH_SVS, .code=&MC68000_Scc, .param=0x0900, .name=HN_SVS,},
		{.type=Symbol_Type_Function, .index=BI_svs, .hash=HASH_svs, .code=&MC68000_Scc, .param=0x0900, .name=HN_SVS,},
		{.type=Symbol_Type_Function, .index=BI_SPL, .hash=HASH_SPL, .code=&MC68000_Scc, .param=0x0A00, .name=HN_SPL,},
		{.type=Symbol_Type_Function, .index=BI_spl, .hash=HASH_spl, .code=&MC68000_Scc, .param=0x0A00, .name=HN_SPL,},
		{.type=Symbol_Type_Function, .index=BI_SNC, .hash=HASH_SNC, .code=&MC68000_Scc, .param=0x0A00, .name=HN_SNC,},
		{.type=Symbol_Type_Function, .index=BI_snc, .hash=HASH_snc, .code=&MC68000_Scc, .param=0x0A00, .name=HN_SNC,},
		{.type=Symbol_Type_Function, .index=BI_SMI, .hash=HASH_SMI, .code=&MC68000_Scc, .param=0x0B00, .name=HN_SMI,},
		{.type=Symbol_Type_Function, .index=BI_smi, .hash=HASH_smi, .code=&MC68000_Scc, .param=0x0B00, .name=HN_SMI,},
		{.type=Symbol_Type_Function, .index=BI_SNS, .hash=HASH_SNS, .code=&MC68000_Scc, .param=0x0B00, .name=HN_SNS,},
		{.type=Symbol_Type_Function, .index=BI_sns, .hash=HASH_sns, .code=&MC68000_Scc, .param=0x0B00, .name=HN_SNS,},
		{.type=Symbol_Type_Function, .index=BI_SGE, .hash=HASH_SGE, .code=&MC68000_Scc, .param=0x0C00, .name=HN_SGE,},
		{.type=Symbol_Type_Function, .index=BI_sge, .hash=HASH_sge, .code=&MC68000_Scc, .param=0x0C00, .name=HN_SGE,},
		{.type=Symbol_Type_Function, .index=BI_SLT, .hash=HASH_SLT, .code=&MC68000_Scc, .param=0x0D00, .name=HN_SLT,},
		{.type=Symbol_Type_Function, .index=BI_slt, .hash=HASH_slt, .code=&MC68000_Scc, .param=0x0D00, .name=HN_SLT,},
		{.type=Symbol_Type_Function, .index=BI_SGT, .hash=HASH_SGT, .code=&MC68000_Scc, .param=0x0E00, .name=HN_SGT,},
		{.type=Symbol_Type_Function, .index=BI_sgt, .hash=HASH_sgt, .code=&MC68000_Scc, .param=0x0E00, .name=HN_SGT,},
		{.type=Symbol_Type_Function, .index=BI_SLE, .hash=HASH_SLE, .code=&MC68000_Scc, .param=0x0F00, .name=HN_SLE,},
		{.type=Symbol_Type_Function, .index=BI_sle, .hash=HASH_sle, .code=&MC68000_Scc, .param=0x0F00, .name=HN_SLE,},
};
// clang-format on

/*
	load symbols for this instruction set
*/

void addSymbolsMC68000() {
	// loop through all to add dem symbols
	for (uint64_t i = 0; i < sizeof(cpuSymbolList) / sizeof(struct MC68000Helper); i++) {
		// create a new symbol for this
		Symbol* sym = Symbol_FindOrAllocate(SymbolExt_BuiltInTable[cpuSymbolList[i].index].hash, 1);

		if (sym != NULL) {
			// fill its details
			sym->type = cpuSymbolList[i].type;
			sym->functionPtr = cpuSymbolList[i].code;
			sym->extraParam = cpuSymbolList[i].param;
			sym->flags = Symbol_Flag_Initialized | Symbol_Flag_Locked;
			sym->name = cpuSymbolList[i].name;

			//	Tracer_WriteSymbolAction(0, 0, sym);
		}
	}
}

/*
	Generate symbols for this instruction set
*/

void makeSymbolsMC68000() {
	// loop through all to add dem symbols
	for (uint64_t i = 0; i < sizeof(cpuSymbolList) / sizeof(struct MC68000Helper); i++) {
		SymbolExt_BuiltInTable[cpuSymbolList[i].index].hash = cpuSymbolList[i].hash;
	}
}

/*
	Remove symbols for this instruction set
*/

void rmvSymbolsMC68000() {
	// loop through all to remove dem symbols
	for (uint64_t i = 0; i < sizeof(cpuSymbolList) / sizeof(struct MC68000Helper); i++) {
		Symbol_DeleteByHash(cpuSymbolList[i].hash, Symbol_GlobalTable);
	}
}

#pragma endregion
#pragma region Comprehensive Errors

/*
typedef struct {

} MC68000HelpInfo;

// helper function to display an error with additional relevant reference info
c_noreturn void errorWith68KHelp(uint8_t* start, uint8_t* end, uint8_t* line, uint8_t* name, MC68000HelpInfo* info, const char* format, ...) {
		va_list argptr;

	// print error correctly
	Error_PrintCodeLocation((uint8_t*)"Error");
		va_start(argptr, format);
	vfprintf(stdout, format, argptr);
		va_end(argptr);
	Error_PrintCodeLine();
	Error_PrintCodeUnderline(start, end, line);



	// if too many errors, bail completely
	if(++errorCount > MAX_ERRORS) {
		exitProgram(3);
	}

	// update listings and assemble the next line
	setListingsBytes();
	longjmp(parseJumpBuf, -1);
}
*/

#pragma endregion
