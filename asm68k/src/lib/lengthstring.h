#if !defined(INCLUDE_LIB_LENGTHSTRING_H)
#define INCLUDE_LIB_LENGTHSTRING_H

#include <stddef.h>
#include <stdint.h>

//////////////////////////////////////////////////////////////////////////////
// Type definitions
//////////////////////////////////////////////////////////////////////////////

/**
	\brief Memory structure that uses both a NUL terminated string,
	and string size. Useful for strings that accept NUL characters
	as a part of the string itself.
*/
typedef struct {
	uint32_t length; // length of the string (excluding NUL)
	char* string;	 // string data
} LengthString;

//////////////////////////////////////////////////////////////////////////////
// Function declarations
//////////////////////////////////////////////////////////////////////////////

/**
	\brief Allocate memory for a new LengthString instance.

	\param length maximum number of characters the new string buffer can hold

	\returns A LengthString instance based on the length,
	or NULL if unable to allocate memory.
*/
LengthString* LengthString_AllocateNew(size_t length);

/**
	\brief Allocate memory for a new LengthString instance, copying buffer contents.

	\param buffer Buffer where text will be copied to the new string instance

	\param length maximum number of characters the new string buffer can hold

	\returns A LengthString instance based on the length with buffer data,
	or NULL if unable to allocate memory.
*/
LengthString* LengthString_FromBuffer(char* buffer, size_t length);

/**
	\brief Create a new instance of LengthString at the desired size,
	and deallocate the source parameter

	\param source The LengthString whose contents to copy to the new string,
	and to deallocate

	\param length maximum number of characters the new string buffer can hold

	\returns A LengthString instance based on the source LengthString,
	or NULL if unable to allocate memory.
*/
LengthString* LengthString_Resize(LengthString* source, size_t length);

#endif // INCLUDE_LIB_LENGTHSTRING_H
