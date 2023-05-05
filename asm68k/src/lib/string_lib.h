#if !defined(INCLUDE_LIB_STRING_H)
#define INCLUDE_LIB_STRING_H

#include <stdint.h>

//////////////////////////////////////////////////////////////////////////////
// Variable declarations
//////////////////////////////////////////////////////////////////////////////

/**
	\brief Variable that stores how wide tabs should be for string functions
*/
extern uint8_t String_TabWidth;

/**
	\brief A look up table for converting a nibble to uppercase hex character
*/
extern char String_UpperCaseHexLUT[16];

/**
	\brief A look up table for converting a character to lowercase
*/
extern char String_LowerCaseLUT[256];

//////////////////////////////////////////////////////////////////////////////
// Function declarations
//////////////////////////////////////////////////////////////////////////////

/**
	\brief Convert hexadecimal character to an integer

	\param ch The character to convert

	\returns Integer representing the value from the character, or -1 if invalid character was passed in
*/
int8_t String_HexCharToInt(char ch);

/**
	\brief Pad a buffer to the specified column with tabs

	\param buffer The buffer where to write tab characters to

	\param target The target column to pad to. Columns must be multiple of String_TabWidth

	\param current The current column of the buffer

	\returns The number of tab characters inserted
*/
uint32_t String_PadBuffer(char** buffer, uint32_t target, uint32_t current);

#endif // INCLUDE_LIB_STRING_H
