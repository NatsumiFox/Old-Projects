#if !defined(INCLUDE_ASSEMBLER_68K_68000_H)
#define INCLUDE_ASSEMBLER_68K_68000_H

#include <asmlink/symbol_ext.h>

#include <lib/expressions.h>

#define SIZE68K_Byte 0x00 // .b
#define SIZE68K_Word 0x01 // .w
#define SIZE68K_Long 0x02 // .l

#define REG68K_D0 0
#define REG68K_D1 1
#define REG68K_D2 2
#define REG68K_D3 3
#define REG68K_D4 4
#define REG68K_D5 5
#define REG68K_D6 6
#define REG68K_D7 7

#define REG68K_A0 8
#define REG68K_A1 9
#define REG68K_A2 0xA
#define REG68K_A3 0xB
#define REG68K_A4 0xC
#define REG68K_A5 0xD
#define REG68K_A6 0xE
#define REG68K_A7 0xF

#define REG68K_SR 0x10
#define REG68K_CCR 0x11
#define REG68K_USP 0x20
#define REG68K_PC 0x30

#define REG68K_W 0x100 // this is required to make .w work
#define REG68K_L 0x102 // for example: 1(a0,d0.w)

// mode IDs for loadAddressingMode()
#define EA68KCHK_Fail 0			 // special
#define EA68KCHK_Data 0x0001 // dn
#define EA68KCHK_Addr 0x0002 // an

#define EA68KCHK_Addr_Indirect 0x0004 // (an)
#define EA68KCHK_Addr_PostInc 0x0008	// (an)+
#define EA68KCHK_Addr_PreDec 0x0010		// -(an)
#define EA68KCHK_Addr_d16 0x0020			// d16(an)
#define EA68KCHK_Addr_d8xn 0x0040			// d8(an,xn)

#define EA68KCHK_Word_Addr 0x0080 // xxxx.w
#define EA68KCHK_Long_Addr 0x0100 // xxxx.l
#define EA68KCHK_PC_d16 0x0200		// d16(pc)
#define EA68KCHK_PC_d8xn 0x0400		// d8(pc,xn)
#define EA68KCHK_Imm 0x0800				// #xxx

//#define ??? 0x1000		// mode = 7 reg = 5
//#define ??? 0x2000		// mode = 7 reg = 6
//#define ??? 0x4000		// mode = 7 reg = 7

#define EA68KCHK_SR 0x2000	// SR		// note: overlaps
#define EA68KCHK_CCR 0x4000 // CCR		// note: overlaps
#define EA68KCHK_USP 0x8000 // USP

// shortcut definitions
#define EA68KCHK_Addr_NoArg (EA68KCHK_Addr_Indirect | EA68KCHK_Addr_PostInc | EA68KCHK_Addr_PreDec)
#define EA68KCHK_Addr_Rel (EA68KCHK_Addr_d16 | EA68KCHK_Addr_d8xn)
#define EA68KCHK_Absolute (EA68KCHK_Word_Addr | EA68KCHK_Long_Addr)
#define EA68KCHK_PC_Rel (EA68KCHK_PC_d16 | EA68KCHK_PC_d8xn)

#define EA68KCHK_Common (EA68KCHK_Data | EA68KCHK_Addr_NoArg | EA68KCHK_Addr_Rel | EA68KCHK_Absolute)
#define EA68KCHK_Location (EA68KCHK_Addr_Indirect | EA68KCHK_Addr_Rel | EA68KCHK_Absolute | EA68KCHK_PC_Rel)

// helper struct for loading addressing mode
typedef struct {
	uint32_t extendUint;
	int32_t extendInt;

	uint16_t id;	// addressing mode id
	uint8_t reg;	// effective addressing register
	uint8_t mode; // effective addressing mode
	uint8_t size; // size field of the instruction
	uint8_t eval; // if nonzero, then can not evaluate

	// positions of the argument
	uint8_t* argStart;
	uint8_t* argEnd;

	// positions of the tokens
	EvaluateToken* tokenStart;
	EvaluateToken* tokenEnd;
} AddrModeHelper;

void addSymbolsMC68000();

void makeSymbolsMC68000();

void rmvSymbolsMC68000();

Expression_Result_Type checkAddqSubqValue(uint16_t* base, int64_t value);

Expression_Result_Type evaluateAsAddrMC68k(TokenTable* table, uint16_t* value, uint64_t offset);

Expression_Result_Type checkMoveqValue(uint8_t size, uint64_t value, uint8_t* start, uint8_t* end);

Expression_Result_Type getShiftCount(uint16_t* base, uint64_t value);

#endif // INCLUDE_ASSEMBLER_68K_68000_H
