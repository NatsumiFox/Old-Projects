#if !defined(INCLUDE_LIB_ARGUMENTS_H)
#define INCLUDE_LIB_ARGUMENTS_H

#include <stdint.h>

//////////////////////////////////////////////////////////////////////////////
// Type definitions
//////////////////////////////////////////////////////////////////////////////

enum Arguments_Mode {
	Arguments_Mode_Null,	// param requested by not found
	Arguments_Mode_End,		// end of all parameters
	Arguments_Mode_Text,	// text without prefix
	Arguments_Mode_Param,	// same as text, but may contain a prefix. This is requested by the function
	Arguments_Mode_Plus,	// + prefix
	Arguments_Mode_Minus,	// - prefix
	Arguments_Mode_Flag,	// -- prefix
};

enum Arguments_ReturnType {
	Arguments_ReturnType_Bail,	// some error happened and caller wants to bail parsing
	Arguments_ReturnType_Error,	// same as bail, but also prints the arguments and highlights where the error happened
	Arguments_ReturnType_OK,	// no special instructions
	Arguments_ReturnType_Param, // caller requested a param argument
};

//////////////////////////////////////////////////////////////////////////////
// Function declarations
//////////////////////////////////////////////////////////////////////////////

/**
	\brief Process commandline arguments.
	This function parses the commandline and lets handler react to each item.

	\param usage If there is an error with commandline, the usage is printed along with the error

	\param argc Copy of argc passed to main, representing the number of arguments

	\param argv Pointer to the argument text array

	\param handler Pointer to the argument handler, that processes mode and text input and transforms processor state

	\returns Enum value representing how the function process returned. See Arguments_ReturnType
*/
enum Arguments_ReturnType Arguments_Process(char* usage, int argc, char* argv[], enum Arguments_ReturnType (*handler)(enum Arguments_Mode mode, char* text));

#endif // INCLUDE_LIB_ARGUMENTS_H
