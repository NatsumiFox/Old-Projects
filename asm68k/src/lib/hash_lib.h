#if !defined(INCLUDE_LIB_HASH_H)
#define INCLUDE_LIB_HASH_H

#include <stdint.h>

/**
	\brief The hash value multiplier that provides sufficiently "random" hashes
*/
#define HASH_MULTIPLIER 31u

/**
	\brief Update hash for the next character.

	\param hash The variable that holds the hash value

	\param char The character to add to the hash
*/
#define HASH_GETNEXT(hash, char) ((hash)*HASH_MULTIPLIER + (uint8_t)(char))

#endif // INCLUDE_LIB_HASH_H
