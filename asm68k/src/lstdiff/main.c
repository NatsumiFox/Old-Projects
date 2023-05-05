#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "compare.h"
#include "lines.h"
#include "main.h"
#include "uimode.h"

#include <lib/arguments.h>
#include <lib/compat.h>

#if defined(LINUX) || defined(MACOS)
#define stricmp strcasecmp
#endif

#define PGMODE_UPRINT 0 // default mode
#define PGMODE_PRINT 1	// same as uprint but for non-interactive shells
#define PGMODE_UI 2			// graphical ui mode

#define NAME "re-diff"
char usage[] =
		NAME " base-object listings compare-object\n\n"
				 "options:\n"
				 "        --ui                    Use graphical mode for comparing files\n"
				 "        --uprint                Print diffs directly in stdout. This is the default mode.\n"
				 "        --print                 Same as uprint, but meants for file processors, and therefore has less information.\n"
				 "        -e or --errors <count>  Set maximum number of errors in print mode. Use all for no limit. This is only an approximation.\n";

uint8_t programMode = PGMODE_UPRINT;
uint32_t maxErrors = MAXERRORS;
uint32_t numErrors;
FileHelper baseHelper;
FileHelper objectHelper;
FileHelper listingsHelper;

#pragma region Library functions

// tiny helper to check bytes taking into account when the file ends
int16_t getByte(FileHelper* helper, int increment) {
	if ((helper->end != NULL && helper->cur >= helper->end) ||
			(helper->address + (helper->cur - helper->buffer)) >= helper->size) {
		helper->cur += increment;
		return -1;
	}

	uint8_t byte = (uint8_t)*helper->cur;
	helper->cur += increment;
	return byte;
}

// helper to close all open files
void closeFiles() {
	if (listingsHelper.file != NULL) {
		fclose(listingsHelper.file);
	}

	if (baseHelper.file != NULL) {
		fclose(baseHelper.file);
	}

	if (objectHelper.file != NULL) {
		fclose(objectHelper.file);
	}
}

// helper to fill object buffer if empty
void checkFillBuffer(FileHelper* helper) {
	int64_t left = BUFFER_LEN - (helper->cur - helper->buffer);

	if (left < 0) {
		printf("BUFFER OVERRUN BY %" PRIX64 " BYTES\n", -left);
		left = 0;
	}

	if (helper->end == NULL && left < BUFFER_MIN) {
		// copy the remaining buffer contents to the start of the buffer
		memcpy(helper->buffer, helper->cur, left);
		helper->cur = helper->buffer;

		// read moar
		size_t bytes = fread(helper->cur + left, 1, BUFFER_LEN - left, helper->file);
		size_t totalbuf = left + bytes;

		if (totalbuf < BUFFER_LEN) {
			helper->end = helper->buffer + totalbuf;

			// fill the rest with NUL
			memset(helper->end, 0, BUFFER_LEN - totalbuf);
		}
	}
}

// helper to fill object buffer at address
void loadBuffer(FileHelper* helper, uint64_t address) {
	helper->cur = helper->buffer;

	if (helper->address == address) {
		return;
	}

	// check for invalid address
	helper->address = address;
	int64_t bufoff = 0;

	if (address > helper->size) {
		// do some hijinx to read part of the buffer still
		bufoff = -(int64_t)address;

		if (bufoff > BUFFER_LEN || bufoff < 0) {
			return;
		}
	}

	// fread memory to buffer
	fseek(helper->file, address + bufoff, SEEK_SET);
	size_t bytes = fread(helper->buffer + bufoff, 1, BUFFER_LEN - bufoff, helper->file);

	helper->end = helper->buffer + bytes + bufoff;
}

#pragma endregion
#pragma region Commandline and main process

// helper for opening a file and bailing if failed
int8_t openFile(char* mode, char* filename, FileHelper* helper) {
	helper->filename = filename;
	helper->file = fopen(filename, mode);

	// if failed, then inform the caller
	if (helper->file == NULL) {
		printf("File \"%s\" not found.", filename);
		return Arguments_ReturnType_Error;
	}

	return Arguments_ReturnType_OK;
}

uint8_t paramId = 0;
uint32_t positionalArg = 0;

// function to process the end of the argument list
enum Arguments_Mode processArgumentsEnd(char* text) {
	switch (positionalArg) {
		case 0:
			printf("Expected <base-object> parameter here.");
			break;
		case 1:
			printf("Expected <listings> parameter here.");
			break;
		case 2:
			printf("Expected <compare-object> parameter here.");
			break;
		case 3:
			return Arguments_ReturnType_OK;
		default:
			break;
	}

	return Arguments_ReturnType_Error;
}

// function to process the next positional argument
enum Arguments_Mode processPositionalArgument(char* text) {
	switch (positionalArg++) {
		case 0:
			return openFile("rb", text, &baseHelper);
		case 1:
			return openFile("rb", text, &listingsHelper);
		case 2:
			return openFile("rb", text, &objectHelper);
		default:
			printf("Unknown positional argument detected.");
			return Arguments_ReturnType_Error;
	}
}

// function to process the next flag argument
enum Arguments_Mode processPlusMinusArgument(uint8_t value, char* text) {
	if (stricmp(text, "e") == 0) {
		paramId = 0;
		return Arguments_ReturnType_Param;

	} else {
		printf("Option -%s was not recognized!", text);
		return Arguments_ReturnType_Error;
	}
}

// function to process the next flag argument
enum Arguments_Mode processFlagArgument(char* text) {
	if (stricmp(text, "uprint") == 0) {
		programMode = PGMODE_UPRINT;

	} else if (stricmp(text, "print") == 0) {
		programMode = PGMODE_PRINT;

	} else if (stricmp(text, "ui") == 0) {
		programMode = PGMODE_UI;

	} else if (stricmp(text, "errors") == 0) {
		paramId = 0;
		return Arguments_ReturnType_Param;

	} else {
		printf("Option --%s was not recognized!", text);
		return Arguments_ReturnType_Error;
	}

	return Arguments_ReturnType_OK;
}

// function to process the next argument that is related to a flag
enum Arguments_Mode processParamArgument(char* text) {
	if (paramId == 0) {
		// maximum error count
		if (stricmp(text, "all") == 0) {
			// special case for all
			maxErrors = UINT32_MAX;

		} else {
			char* end = NULL;
			// try to fetch the number as longword
			maxErrors = strtol(text, &end, 0);

			if (end == text) {
				printf("Unable to convert this argument to a number.");
				return Arguments_ReturnType_Error;

			} else if (maxErrors == 0) {
				printf("Maximum number of errors must be more than 0.");
				return Arguments_ReturnType_Error;
			}
		}

		return Arguments_ReturnType_OK;
	}

	return Arguments_ReturnType_Bail;
}

// function to process the missing text argument
enum Arguments_Mode processMissingArgument(char* text) {
	if (paramId == 0) {
		printf("Expected <count> parameter for --errors/-e here.");
	}

	return Arguments_ReturnType_Error;
}

// function to process commandline parameters
enum Arguments_Mode processParams(enum Arguments_Mode mode, char* text) {
	switch (mode) {
		case Arguments_Mode_Text:
			return processPositionalArgument(text);
		case Arguments_Mode_Param:
			return processParamArgument(text);
		case Arguments_Mode_Flag:
			return processFlagArgument(text);
		case Arguments_Mode_Plus:
			return processPlusMinusArgument(1, text);
		case Arguments_Mode_Minus:
			return processPlusMinusArgument(0, text);
		case Arguments_Mode_Null:
			return processMissingArgument(text);
		case Arguments_Mode_End:
			return processArgumentsEnd(text);
		default:
			break;
	}

	return Arguments_ReturnType_Bail;
}

int main(int argc, char* argv[]) {
	// handle arguments
	if (!Arguments_Process(usage, argc, argv, processParams)) {
		exit(2);
	}

	numErrors = 0;
	if (programMode == PGMODE_UPRINT) {
		printf(NAME " version 0.0\n");
	}

	fseek(listingsHelper.file, 0, SEEK_END);
	listingsHelper.size = ftell(listingsHelper.file);
	fseek(listingsHelper.file, 0, SEEK_SET);

	// fetch file sizes
	fseek(objectHelper.file, 0, SEEK_END);
	objectHelper.size = ftell(objectHelper.file);
	fseek(objectHelper.file, 0, SEEK_SET);

	fseek(baseHelper.file, 0, SEEK_END);
	baseHelper.size = ftell(baseHelper.file);
	fseek(baseHelper.file, 0, SEEK_SET);

	// reset values
	listingsHelper.address = baseHelper.address = objectHelper.address = 0;
	listingsHelper.end = baseHelper.end = objectHelper.end = 0;
	listingsHelper.cur = listingsHelper.buffer + BUFFER_LEN;
	objectHelper.cur = objectHelper.buffer + BUFFER_LEN;
	baseHelper.cur = baseHelper.buffer + BUFFER_LEN;

	// load listings file data
	processListings();

	if (programMode == PGMODE_UI) {
		// handle ui mode
		runUiMode();

	} else {
		// handle processing of differences
		compareAndPrint();
	}

	if (programMode == PGMODE_UPRINT) {
		printf("\nDONE\n");
	}

	closeFiles();
	return numErrors == 0 ? 0 : 1;
}

#pragma endregion
