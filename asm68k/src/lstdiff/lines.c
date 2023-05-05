#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "lines.h"
#include "main.h"

#include <lib/compat.h>
#include <lib/math_lib.h>
#include <lib/string_lib.h>

char* asmFileStack[ASM_FILE_STACK_SIZE];
uint32_t asmLineStack[ASM_FILE_STACK_SIZE];
int32_t asmFileStackPos = -1;

uint32_t linenum = 1;

ListingsLine* listingsLines;
uint32_t listingsAlloc;
uint32_t listingsUsed;

#define isNewline(b) ((b) == 0 || (b) == '\r' || (b) == '\n')

// helper function to process newlines
void handleNewline() {
	if (asmFileStackPos >= 0) {
		asmLineStack[asmFileStackPos]++;
	}

	while (!isNewline(*listingsHelper.cur)) {
		listingsHelper.cur++;
	}

	if (listingsHelper.cur < listingsHelper.buffer + BUFFER_LEN) {
		// check for crlf
		if (*listingsHelper.cur == '\r' && *(listingsHelper.cur + 1) == '\n') {
			*listingsHelper.cur++ = 0;
		}

		// change NL to NUL
		*listingsHelper.cur++ = 0;
	}
}

// helper to handle file open/close in listings
void handleFileChange(int open) {
	// find the bounds of the filename
	while (*listingsHelper.cur++ != '"')
		;
	char* fnstart = listingsHelper.cur;
	while (*listingsHelper.cur++ != '"')
		;
	char* fnend = listingsHelper.cur - 1;
	*(listingsHelper.cur - 1) = 0;

	// handle operation
	if (open) {
		if (asmFileStackPos >= ASM_FILE_STACK_SIZE) {
			printf("file slots full!\n");
			exit(1);
		}

		// create a new filename
		char* newfile = malloc(fnend - fnstart + 1);

		if (newfile == NULL) {
			printf("malloc failed!\n");
			exit(1);
		}

		// copy buffer and store it
		memcpy(newfile, fnstart, fnend - fnstart + 1);
		asmFileStack[++asmFileStackPos] = newfile;
		asmLineStack[asmFileStackPos] = 0;

	} else if (asmFileStackPos > 0) {
		--asmFileStackPos;
	}

	// process newline
	handleNewline();
}

// helper to read the address parameter
uint64_t getAddressParam() {
	uint64_t ret = 0;
	uint8_t digits = 0;

	// loop for each byte while keeping track of nibble shift counter
	for (int shift = 48 - 4; shift >= 0; shift -= 4) {
		uint8_t read = *listingsHelper.cur++;
		int8_t v = String_HexCharToInt((char)read);

		if (v >= 0) {
			// accumulate value
			ret |= ((uint64_t)v) << shift;
			digits++;

		} else if (read != ' ') {
			// reject line
			return UINT64_MAX;
		}
	}

	return digits == 0 ? UINT64_MAX : ret;
}

// function to expand array for listings lines if needed
void expandListingsTable() {
	// check if the listingLines array can fit this
	if (listingsAlloc <= listingsUsed) {
		listingsAlloc <<= 1;
		listingsLines = realloc(listingsLines, listingsAlloc * sizeof(ListingsLine));

		if (listingsLines == NULL) {
			printf("malloc failed!\n");
			exit(1);
		}
	}
}

// function to process listings file into lines
void processListings() {
	// pre-allocate some space
	listingsAlloc = 0x100;
	listingsUsed = 0;
	listingsLines = malloc(listingsAlloc * sizeof(ListingsLine));

	while (listingsHelper.end == NULL || listingsHelper.cur < listingsHelper.end) {
		checkFillBuffer(&listingsHelper);

		// check for special command
		char read = *listingsHelper.cur;

		switch (read) {
			case '>': // open new file
				handleFileChange(1);
				continue;
			case '<': // close file
				handleFileChange(0);
				continue;
			default:
				break;
		}

		// calculate the address and check if it succeeded
		uint64_t address = getAddressParam();

		if (address == UINT64_MAX) {
			handleNewline();
			continue;
		}

		// skip other bytes in the line
		listingsHelper.cur += 40 - 12;
		char* lineStart = listingsHelper.cur;

		// find eol also
		handleNewline();
		char* lineEnd = listingsHelper.cur;
		expandListingsTable();

		// create the block
		listingsLines[listingsUsed].address = address;
		listingsLines[listingsUsed].line = asmLineStack[MAX(0, asmFileStackPos)];
		listingsLines[listingsUsed].file = asmFileStack[MAX(0, asmFileStackPos)];

		// create the line text
		listingsLines[listingsUsed].text = malloc(lineEnd - lineStart + 1);

		if (listingsLines[listingsUsed].text == NULL) {
			printf("malloc failed!\n");
			exit(1);
		}

		// set the current line contents to it
		memcpy(listingsLines[listingsUsed].text, lineStart, lineEnd - lineStart + 1);
		listingsUsed++;
	}

	// add a new listings line for the end of address space, in case one of the files is too large
	expandListingsTable();

	listingsLines[listingsUsed].address = UINT64_MAX;
	listingsLines[listingsUsed].line = 0;
	listingsLines[listingsUsed].file = "diff";
	listingsLines[listingsUsed].text = "";
	listingsUsed++;
}

// helper function to fetch a line at address
uint32_t fetchLineIndexAt(uint64_t address, uint32_t start) {
	// check each entry, returning the latest that is <= address
	for (uint32_t i = start; i < listingsUsed; i++) {
		if (listingsLines[i].address > address) {
			return i - 1;
		}
	}

	return listingsUsed - 1;
}

// fetch the ListingsLine by its index
ListingsLine* fetchLineByIndex(uint32_t index) {
	// fix the index being too large
	if (index >= listingsUsed) {
		index = 0;
	}

	// if there are no indices at all, bail
	if (listingsUsed == 0) {
		return NULL;
	}

	// fetch the line
	return &listingsLines[index];
}
