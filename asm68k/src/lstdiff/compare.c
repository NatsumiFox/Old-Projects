#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "compare.h"
#include "lines.h"
#include "main.h"

#include <lib/compat.h>
#include <lib/math_lib.h>

// helper to print the bytes for bytediff
void printBytes(FileHelper* helper, int64_t bytes) {
	if (bytes > 0x10) {
		printf(" %" PRIX64 " bytes ::", bytes);
		bytes = 0x10;
	}

	char* buf = helper->cur - bytes;

	for (; bytes > 0; bytes--) {
		// check if data can be trusted
		if (helper->end != NULL && buf >= helper->end) {
			printf(" --");

		} else {
			printf(" %02X", (uint8_t)*buf++);
		}
	}
}

// helper function to write byte difference
void printByteDiff(int64_t bytes, ListingsLine* line, uint64_t baseAddr, uint64_t objAddr) {
	numErrors++;
	printf("\nline %s (%d): %s\n%016" PRIX64 " ::", line->file, line->line, line->text, baseAddr);
	printBytes(&baseHelper, bytes);
	printf("\n%016" PRIX64 " ::", objAddr);
	printBytes(&objectHelper, bytes);
	printf("\n");
}

// compare the next x byte values
void compareBytes(int64_t count, ListingsLine* line) {
	// safety check
	if (count <= 0) {
		return;
	}

	int64_t dif = -1;
	uint64_t obase = 0;
	uint32_t dbase = 0, doff = 0;

	for (int64_t i = 0; i < count; i++) {
		// check difference start
		if (getByte(&baseHelper, 1) == getByte(&objectHelper, 1)) {
			doff++;
			objectHelper.address++;
			continue;
		}

		// find difference end
		dif = i++;
		dbase = doff++;
		obase = objectHelper.address++;

		for (; i < count; i++) {
			// check difference end
			if (getByte(&baseHelper, 0) == getByte(&objectHelper, 0)) {
				// print the difference
				printByteDiff(i - dif, line, dbase + line->address, obase);
				dif = -1;
			}

			// update stats
			doff++;
			objectHelper.address++;
			baseHelper.cur++;
			objectHelper.cur++;

			if (dif < 0) {
				break;
			}
		}
	}

	// check if there is end difference still
	if (dif >= 0) {
		printByteDiff(count - dif, line, dbase + line->address, obase);
	}
}

// function to write errors into stdout
void compareAndPrint() {
	uint64_t address = 0;

	// loop through the files finding differences
	while (address < baseHelper.size || address < objectHelper.size) {
		// fill the buffers
		checkFillBuffer(&baseHelper);
		checkFillBuffer(&objectHelper);

		// fetch the next line
		uint32_t index = fetchLineIndexAt(address, 0);
		ListingsLine* curLine = fetchLineByIndex(index);
		ListingsLine* nextLine = fetchLineByIndex(index + 1);

		if (curLine == NULL || nextLine == NULL) {
			printf("failed to get the next line!\n");
			exit(1);
		}

		// get the number of bytes
		int64_t bytes =
				(nextLine->address == UINT64_MAX ? MAX(baseHelper.size, objectHelper.size) : nextLine->address) -
				curLine->address;

		if (bytes <= 0) {
			// negative bytes..? if so, or 0 bytes, just skip completely
			continue;
		}

		// check if we're trying to check too many bytes... yeaaa this is hacky
		int64_t adjust =
				BUFFER_LEN - 2 - MAX(baseHelper.cur - baseHelper.buffer, objectHelper.cur - baseHelper.buffer) - bytes;

		if (adjust < 0) {
			bytes += adjust;
		}

		// compare the bytes
		compareBytes(bytes, curLine);
		address += bytes;

		// check if maximum errors has been reached
		if (numErrors >= maxErrors) {
			printf("Maximum number of errors reached!");
			closeFiles();
			exit(1);
		}
	}
}
