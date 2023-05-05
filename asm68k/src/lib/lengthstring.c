#include <stdint.h>
#include <stdlib.h>
#include <stddef.h>
#include <string.h>

#include <lib/lengthstring.h>

//////////////////////////////////////////////////////////////////////////////
// Main function
//////////////////////////////////////////////////////////////////////////////

LengthString* LengthString_AllocateNew(size_t length) {
	// try to allocate some space for the LengthString
	LengthString* ret = malloc(sizeof(LengthString) + length + 1);

	if (!ret) {
		// malloc failed
		return NULL;
	}

	// update details
	ret->string = ((char*)ret) + sizeof(LengthString);
	ret->length = length;
	return ret;
}

LengthString* LengthString_FromBuffer(char* buffer, size_t length) {
	// try to allocate some space for the LengthString
	LengthString* ret = LengthString_AllocateNew(length);

	if (ret) {
		// copy the string data and NUL terminate
		memcpy(ret->string, buffer, length);
		*(ret->string + length) = 0;
	}

	return ret;
}

LengthString* LengthString_Resize(LengthString* source, size_t length) {
	LengthString* ret = LengthString_FromBuffer(source->string, length);
	free(source);
	return ret;
}
