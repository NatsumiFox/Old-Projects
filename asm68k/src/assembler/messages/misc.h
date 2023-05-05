#if !defined(INCLUDE_ASSEMBLER_MSG_MISC_H)
#define INCLUDE_ASSEMBLER_MSG_MISC_H

#include <asmlink/messages/global.h>

//////////////////////////////////////////////////////////////////////////////
// Program messages
//////////////////////////////////////////////////////////////////////////////

#define MSGTXT_PROGRAM_NAME "re-asm"
#define MSGTXT_PROGRAM_VER "0.0"
#define MSGTXT_CREDITS "By re-asm project (c) 2022"
#define MSGTXT_NAME_VERSION MSGFUN_NAME(MSGTXT_PROGRAM_NAME, MSGTXT_PROGRAM_VER)

#define MSGTXT_PROGRAM_USAGE MSGFUN_USAGE(MSGTXT_PROGRAM_NAME, \
		MSGFUN_OPTION("--lst <file>          ", "Listings file") \
		MSGFUN_OPTION("--sym <file>          ", "Symbols file") \
		MSGFUN_OPTION("--sf <format>         ", "Symbols file format: H or EQU") \
		MSGFUN_OPTION("-e <symbol=value>     ", "Create a symbol equate") \
		MSGFUN_OPTION("-i or --include <path>", "Add include file search path") \
		MSGFUN_OPTION("-k                    ", "Enable 'ifeq' etc.") \
		MSGFUN_OPTION("-m or --macros        ", "Expand macros in listings file") \
		MSGFUN_OPTION("-q or --quiet         ", "Run quietly") \
		MSGFUN_OPTION("--cpu <model>         ", "Switch to cpu model. By default 68000") \
		MSGFUN_OPTION("--fpu <model>         ", "Switch to fpu model. Disabled by default") \
		MSGFUN_OPTION("-lc<c>                ", "Use \"<c>\" for local label symbol") \
		MSGFUN_OPTION("+/-ae                 ", "Automatic even on dc/dcb/ds/rs .w/l") \
		MSGFUN_OPTION("+/-an                 ", "Allow alternate number formats") \
		MSGFUN_OPTION("+/-c                  ", "Toggle case sensitivity") \
		MSGFUN_OPTION("+/-d                  ", "Descope local labels on EQU, SET, etc") \
		MSGFUN_OPTION("+/-w                  ", "Print warnings") \
		MSGFUN_OPTION("+/-opc                ", "Optimize PC relative statements") \
		MSGFUN_OPTION("+/-os                 ", "Optimize short branches") \
		MSGFUN_OPTION("+/-ow                 ", "Optimize absolute word addressing") \
		MSGFUN_OPTION("+/-oz                 ", "Optimize zero offsets") \
		MSGFUN_OPTION("+/-oaq                ", "Optimize to ADDQ and SUBQ") \
		MSGFUN_OPTION("+/-omq                ", "Optimize to MOVEQ") \
	)


#endif // INCLUDE_ASSEMBLER_MSG_MISC_H
