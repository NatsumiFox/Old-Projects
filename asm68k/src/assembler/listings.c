#include <inttypes.h>
#include <setjmp.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "assembler.h"
#include "error.h"
#include "hash.h"
#include "listings.h"
#include "object.h"
#include "parse.h"

#include <asmlink/debug_tracer.h>
#include <asmlink/symbol_ext.h>

#include <lib/compat.h>
#include <lib/debug.h>
#include <lib/files.h>
#include <lib/string_lib.h>
#include <lib/messages/global.h>

uint8_t useAsmErrors = 0;
FILE* listingFile;
char* listingPath;
uint8_t* listingBufferPtr;

void (*writeListingsAddress)(int32_t);

// set the listings address on 32-bit machines
void writeAddr_32bit(int32_t value) {
	if (!listingFile) {
		return;
	}

	// load address
	uint8_t* data = buffers.listings + LST_POS_ADDR;

	*(data + LST_LEN_ADDR - 1) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 2) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 3) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 4) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 5) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 6) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 7) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 8) = String_UpperCaseHexLUT[value & 0xF];

	*(data + 3) = FILL_UNUSED_ADDR;
	*(data + 2) = FILL_UNUSED_ADDR;
	*(data + 1) = FILL_UNUSED_ADDR;
	*(data + 0) = FILL_UNUSED_ADDR;
}

// set the listings address on 24-bit machines
void writeAddr_24bit(int32_t value) {
	if (!listingFile) {
		return;
	}

	// load address
	uint8_t* data = buffers.listings + LST_POS_ADDR;

	*(data + LST_LEN_ADDR - 1) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 2) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 3) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 4) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 5) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 6) = String_UpperCaseHexLUT[value & 0xF];

	*(data + 5) = FILL_UNUSED_ADDR;
	*(data + 4) = FILL_UNUSED_ADDR;
	*(data + 3) = FILL_UNUSED_ADDR;
	*(data + 2) = FILL_UNUSED_ADDR;
	*(data + 1) = FILL_UNUSED_ADDR;
	*(data + 0) = FILL_UNUSED_ADDR;
}

// set the listings address on 16-bit
void writeAddr_16bit(int32_t value) {
	if (!listingFile) {
		return;
	}

	// load address
	uint8_t* data = buffers.listings + LST_POS_ADDR;

	*(data + LST_LEN_ADDR - 1) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 2) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 3) = String_UpperCaseHexLUT[value & 0xF];
	value >>= 4;
	*(data + LST_LEN_ADDR - 4) = String_UpperCaseHexLUT[value & 0xF];

	*(data + 7) = FILL_UNUSED_ADDR;
	*(data + 6) = FILL_UNUSED_ADDR;
	*(data + 5) = FILL_UNUSED_ADDR;
	*(data + 4) = FILL_UNUSED_ADDR;
	*(data + 3) = FILL_UNUSED_ADDR;
	*(data + 2) = FILL_UNUSED_ADDR;
	*(data + 1) = FILL_UNUSED_ADDR;
	*(data + 0) = FILL_UNUSED_ADDR;
}

// no-op for when listings are disabled
void writeAddr_null(int32_t value) {
}

// clear listings address line
void clearListingsAddress() {
	if (!listingFile) {
		return;
	}

	memset(buffers.listings + LST_POS_ADDR, FILL_UNUSED_ADDR, LST_LEN_ADDR);
}

// helper to reset various text fields
c_inline void clearTextParts() {
	buffers.listings[LST_POS_S2] = buffers.listings[LST_POS_S1] = buffers.listings[LST_POS_MACRO] = buffers.listings[LST_POS_PLUS] = ' ';
}

// function to initialize the listings file
void initializeListingsFile() {
	if (listingPath) {
		Tracer_WriteFileMode(0, listingPath, "listings-file");
		listingFile = fopen(listingPath, "wb");

		// check if failed to make the file
		if (!listingFile) {
			Error_ErrorProgram(ERRFMT_FILE_NOT_FOUND " ", listingPath);
		}

		fseek(listingFile, 0, SEEK_SET);

		// initialize params
		clearTextParts();
		writeListingsAddress = &writeAddr_24bit;
		writeListingsAddress(0);

	} else {
		// use a no-op in the case listings are disabled
		writeListingsAddress = &writeAddr_null;
	}

	// must be reset for error stuff
	listingBufferPtr = buffers.listings + LST_POS_BUF;
}

// close the listings file
void closeListingsFile() {
	if (listingFile) {
		Tracer_WriteFileMode(1, listingPath, "listings-file");
		fclose(listingFile);
	}
}

// print the listing line
void printListingsLine() {
	if (listingFile) {
		// write NL at the end
		*listingBufferPtr++ = '\n';

		// write the buffer
		fwrite(buffers.listings, 1, listingBufferPtr - buffers.listings, listingFile);

		// reset some things
		buffers.listings[LST_POS_MACRO] = buffers.listings[LST_POS_PLUS] = ' ';
	}

	// must be reset for error stuff
	listingBufferPtr = buffers.listings + LST_POS_BUF;
}

// write listings line
void writeListingsLine() {
	uint8_t* buf = buffers.line;

	// copy buffer data
	while (*buf) {
		*listingBufferPtr++ = (*buf++) & 0x7F;
	}
}

// write the listings equate
void setListingsEqu(uint64_t value) {
	if (!listingFile) {
		return;
	}

	// reset data value
	uint8_t* data = buffers.listings + LST_POS_HEX;
	memset(data, ' ', LST_LEN_HEX);

	// write equals sign
	*data = '=';
	data += 16;

	// write dat number
	for (int i = 0; i < 16; i++) {
		*data-- = String_UpperCaseHexLUT[value & 0xF];
		value >>= 4;
	}
}

// write the listings equate
void setListingsEqustr(LengthString* value) {
	if (!listingFile) {
		return;
	}

	// write str and fill rest with spaces
	char* data = ((char*)buffers.listings) + LST_POS_HEX;
	int tlen = sprintf(data, "=str(%" PRIu32 ")", value->length);
	memset(data + tlen, ' ', LST_LEN_HEX - tlen);
}

// write the listings unknown equate value
void setListingsEquUnk() {
	if (!listingFile) {
		return;
	}

	// reset data value
	uint8_t* data = buffers.listings + LST_POS_HEX;
	memset(data + 4, ' ', LST_LEN_HEX - 4);

	// write equals sign
	*data++ = '=';
	*data++ = '?';
	*data++ = '?';
	*data = '?';
}

// write file change operations for listings
void writeListingsFileChange(uint8_t ch, int32_t filesCount, uint8_t* filename) {
	// print this monstrous line
	listingBufferPtr =
			buffers.listings + sprintf((char*)buffers.listings, "%c %d :: \"%s\"", ch, filesCount, filename);
	printListingsLine();

	// must be reset for error stuff
	clearTextParts();
	listingBufferPtr = buffers.listings + LST_POS_BUF;
}

// write the listings bytes
void setListingsBytes() {
	if (!listingFile) {
		return;
	}

	// reset data value
	uint8_t* data = buffers.listings + LST_POS_HEX;
	memset(data, ' ', LST_LEN_HEX);

	// write words, at most 5
	int words = 0;

	while (objectListBufferPtr < objectBufferPtr) {
		// check for max number of words
		if (++words > 5) {
			buffers.listings[LST_POS_PLUS] = '+';
			objectListBufferPtr = objectBufferPtr;
			break;
		}

		// check 16-bit vs 8-bit distance
		if (objectBufferPtr - objectListBufferPtr >= 2) {
			// load value
			uint16_t value = *((uint16_t*)objectListBufferPtr);

			// write value as hex
#if ENDIANNESS == 0
			*(3 + data) = String_UpperCaseHexLUT[value & 0xF];
			value >>= 4;
			*(2 + data) = String_UpperCaseHexLUT[value & 0xF];
			value >>= 4;
#endif

			*(1 + data) = String_UpperCaseHexLUT[value & 0xF];
			value >>= 4;
			*(0 + data) = String_UpperCaseHexLUT[value & 0xF];

#if ENDIANNESS == 1
			value >>= 4;
			*(3 + data) = String_UpperCaseHexLUT[value & 0xF];
			value >>= 4;
			*(2 + data) = String_UpperCaseHexLUT[value & 0xF];
#endif

			data += 4;
			*data++ = ' ';
			objectListBufferPtr += 2;

		} else {
			// load value
			uint8_t value = *objectListBufferPtr++;

			// write value as hex
			*(1 + data) = String_UpperCaseHexLUT[value & 0xF];
			value >>= 4;
			*(0 + data) = String_UpperCaseHexLUT[value & 0xF];

			data += 2;
			*data++ = ' ';
		}
	}
}
