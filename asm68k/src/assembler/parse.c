#include <setjmp.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "assembler.h"
#include "builtins/directives.h"
#include "error.h"
#include "hash.h"
#include "listings.h"
#include "object.h"
#include "parse.h"

#include <asmlink/debug_tracer.h>
#include <asmlink/symbol_ext.h>
#include <asmlink/messages/global.h>

#include <lib/compat.h>
#include <lib/debug.h>
#include <lib/files.h>
#include <lib/hash_lib.h>
#include <lib/lengthstring.h>
#include <lib/messages/global.h>

AsmFile asmFileStack[ASM_FILE_STACK_SIZE];
int32_t asmFileStackPos = -1;
AsmFile* currentFile;
uint32_t totalLines = 0;
LengthString* includedFilename = NULL;
FILE* includedFile = NULL;

uint32_t* _lineNumber;
LengthString* _filename;

jmp_buf parseJumpBuf;

// function to update file info
void updateFileInfo() {
	AsmFile* data = &asmFileStack[asmFileStackPos];

	// load file details
	_filename = data->filename;
	_lineNumber = &data->lineNumber;
}

// function to open an asm file
AsmFile* openAsmFile() {
	// check for asm file stack
	if (1 + asmFileStackPos >= ASM_FILE_STACK_SIZE) {
		Error_Fatal(2, ERRFMT_INCLUDE_FILES_MAX, ASM_FILE_STACK_SIZE);
	}

	// create output asm file data and open the file
	AsmFile* data = &asmFileStack[asmFileStackPos + 1];
	data->file = includedFile;
	data->filename = includedFilename;

	if (data->file == NULL) {
		Error_Fatal(2, ERRFMT_FILE_NOT_FOUND " ", includedFilename->string);
	}

	// reset global vars
	includedFile = NULL;
	includedFilename = NULL;

	// load file size
	fseek(data->file, 0, SEEK_SET);
	data->size = ftell(data->file);
	fseek(data->file, 0, SEEK_SET);

	// allocate buffer
	data->buffer = malloc(ASM_FILE_BUFFER_LEN);

	if (data->buffer == NULL) {
		Error_ErrorProgram(ERRTXT_MALLOC_FAIL " ");
	}

	// reset variables
	data->data = data->buffer + ASM_FILE_BUFFER_LEN;
	data->endPos = 0;
	data->bufferNUL = 0;
	data->lineNumber = 0;
	++asmFileStackPos;

	// update info and listings
	updateFileInfo();
	writeListingsFileChange('>', asmFileStackPos + 1, data->filename->string);
	Tracer_WriteFileMode(0, data->filename->string, "source-file");

#ifdef DEBUG
	updateMemoryUsage();
#endif
	return data;
}

// initialize the initial asm file
void initAsmFile() {
	includedFile = findFile((uint8_t*)sourcePath, "rb", &includedFilename);
}

// closes the last file in the stack
void closeAsmFile() {
	// check for asm file stack
	if (asmFileStackPos < 0) {
		Error_ErrorProgram(ERRFMT_INCLUDE_FILES_MIN);
	}

	// free memory and close the file
	AsmFile* data = &asmFileStack[asmFileStackPos];

	Tracer_WriteFileMode(1, data->filename->string, "source-file");
	free(data->buffer);
	fclose(data->file);

	// update listings with file
	writeListingsFileChange('<', asmFileStackPos + 1, data->filename->string);
	//	free(data->filename);
	asmFileStackPos--;

	updateFileInfo();
}

// close all ASM files
void closeAllAsmFiles() {
	// check for asm file stack
	while (asmFileStackPos >= 0) {
		closeAsmFile();
	}
}

// parse asm file data
void parseBufferAsAsm(uint8_t* buffer, uint32_t length) {
	uint8_t* fbuf = buffer;

	while (1) {
		// check if this is the end of the buffer
		if (fbuf >= buffer + length) {
			return;
		}

		// parse each line separately
		objectAddrLine = objectAddress;
		sanitizeLine(&fbuf);
		Tracer_WriteLine("buffer", buffers.line);

		// flush object buffer data
		if (objectBufferPtr >= objectBuffer + OBJ_BUFFER_LINE) {
			flushObjectBuffer();
		}

		// process the line contents, break upon exception
		if (setjmp(parseJumpBuf) == 0) {
			processLine();
		}

		// write rest of the listings stuff
		printListingsLine();
	}
}

// parse asm file data
void parseAsmFile() {
	while (1) {
		// check for the newly included file
		if (includedFilename != NULL) {
			currentFile = openAsmFile();
		}

		// check if file buffer is too empty
		if (!currentFile->endPos && (currentFile->data - currentFile->buffer) >= ASM_FILE_BUFFER_LEN - LINE_MAX_LEN) {
			const int length = ASM_FILE_BUFFER_LEN - (currentFile->data - currentFile->buffer);

			// copy the remaining buffer contents to the start of the buffer
			memcpy(currentFile->buffer, currentFile->data, length);
			currentFile->data = currentFile->buffer;

			// fill rest of the buffer
			const int bytes = fread(currentFile->buffer + length, 1, ASM_FILE_BUFFER_LEN - length, currentFile->file);
			const int bufferEndPos = length + bytes;

			// check for an empty return
			if (bufferEndPos < ASM_FILE_BUFFER_LEN) {
				currentFile->endPos = currentFile->buffer + bufferEndPos;

				// fill the rest with NUL
				memset(currentFile->buffer + bufferEndPos, 0, ASM_FILE_BUFFER_LEN - bufferEndPos);
			}
		}

		// check if this is the end of the file
		if (currentFile->endPos && currentFile->data >= currentFile->endPos) {
			// close the asm file, so we can process the one previously in the stack
			closeAsmFile();

			// check if there are more files on the stack
			if (asmFileStackPos < 0) {
				return;
			}

			// update current file
			currentFile = &asmFileStack[asmFileStackPos];
			continue;
		}

		// parse each line separately
		objectAddrLine = objectAddress;
		currentFile->lineNumber++;

		sanitizeLine(&currentFile->data);
		Tracer_WriteLine(currentFile->filename->string, buffers.line);

		// flush object buffer data
		if (objectBufferPtr >= objectBuffer + OBJ_BUFFER_LINE) {
			flushObjectBuffer();
		}

		// process the line contents, break upon exception
		if (setjmp(parseJumpBuf) == 0) {
			processLine();
		}

		// write rest of the listings stuff
		printListingsLine();
	}
}

uint8_t parseLUT[256] = {
		0x8A, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 00
		0x80, 0xA0, 0x8A, 0x80, 0x80, 0x8A, 0x80, 0x80, // 08
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 10
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 18

		0xA0, '!', '"', '#', '$', '%', '&', '\'', // 20
		'(', ')', '*', '+', ',', '-', '.', '/',		// 28
		'0', '1', '2', '3', '4', '5', '6', '7',		// 30
		'8', '9', ':', 0xBB, '<', '=', '>', '?',	// 38

		'@', 'A', 'B', 'C', 'D', 'E', 'F', 'G',	 // 40
		'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',	 // 48
		'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',	 // 50
		'X', 'Y', 'Z', '[', '\\', ']', '^', '_', // 58

		'`', 'a', 'b', 'c', 'd', 'e', 'f', 'g',	 // 60
		'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',	 // 68
		'p', 'q', 'r', 's', 't', 'u', 'v', 'w',	 // 70
		'x', 'y', 'z', '{', '|', '}', '~', 0x80, // 78

		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 80
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 88
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 90
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 98
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // A0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // A8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // B0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // B8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // C0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // C8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // D0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // D8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // E0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // E8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // F0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // F8
};

// parse the next line
void sanitizeLine(uint8_t** linedata) {
	totalLines++;

	// reset line buffer
	uint8_t* san = buffers.line;
	uint8_t* lastNonSpace = san - 1;
	listingBufferPtr = buffers.listings + LST_POS_BUF;

	// process each character
	while (1) {
		// read LUT character
		uint8_t rch = **linedata;
		uint8_t sch = parseLUT[rch];
		(*linedata)++;

		if (sch < 0x80) {
			// copy char as is
			lastNonSpace = san;
			*san++ = sch;
			*listingBufferPtr++ = rch;

		} else {
			switch (sch) {
				default:
					break;
				case 0x80:
					// invalid character
					*listingBufferPtr++ = rch;
					break;

				case 0x8A:
				case 0x8D:
					// newline, finish processing this line
					goto endOfText;

				case 0xA0:
					// whitespace
					*san++ = ' ';
					*listingBufferPtr++ = rch;
					break;

				case 0xBB:
					*listingBufferPtr++ = rch;

					// semicolon - keep reading until end of line
					while (1) {
						rch = **linedata;
						sch = parseLUT[rch];
						(*linedata)++;

						if (sch == 0x8A) {
							// newline or invalid character, end of comment
							goto endOfText;
						}

						*listingBufferPtr++ = rch;
					}
					break;
			}
		}
	}

endOfText:
	// check for CRLF
	if (**linedata == '\n' && *(*linedata - 1) == '\r') {
		(*linedata)++;
	}

	// trim the whitespace at the end
	*(lastNonSpace + 1) = 0;
	buffers.lineLength = (uint32_t)(lastNonSpace - buffers.line + 1);

	// check for a too long listings line
	if (listingFile) {
		if (listingBufferPtr >= buffers.listings + LST_POS_SAFE) {
			Error_ErrorProgram(ERRFMT_LINE_LENGTH_ISSUE, (uint32_t)(listingBufferPtr - buffers.listings), LST_LEN_BUF);
		}

		// set end of listings line
		*listingBufferPtr = 0;

	} else if (san >= buffers.line + (LINE_MAX_LEN - 1)) {
		Error_ErrorProgram(ERRFMT_LINE_LENGTH_ISSUE, (uint32_t)(san - buffers.line), LINE_MAX_LEN);
	}
}

// process the line data
void processLine() {
	uint8_t* buffer = buffers.line;
	uint8_t* funcNameBuf = buffer;
	labelNameBuffer = buffer;
	labelNameLength = 0;
	uint8_t labelAtStart = 0, isLocal = 0;

	// skip initial whitespace
	while (1) {
		// load character and check for NUL
		uint8_t d = *buffer;

		if (d == 0) {
			// reset address and listings stuff, so it doesn't do funky
			clearListingsAddress();
			setListingsBytes();
			return;
		}

		// if not a space character, we're done found it
		if (d != ' ') {
			break;
		}

		buffer++;
	}

	if (labelNameBuffer == buffer) {
		// label starts at the beginning of the line
		labelAtStart = 1;

	} else {
		// label starts at the end of the line
		funcNameBuf = labelNameBuffer = buffer;
	}

	uint32_t funcHash = 0;
	uint8_t read;
	hasLabel = 0;
	labelHash = 0;

	// check first character valid
	if ((charFlagLUT[read = *buffer] & 2) == 0) {
		if (*buffer == '=') {
			// special case for SET
			funcHash = HASH_set;
			funcNameBufStart = buffers.line;
			buffer++;
			goto gotFunc;
		}

		// unexpected character in input
		Error_ErrorUnderline(buffers.line, funcNameBuf, buffer, ERRFMT_UNEXPECTED_IN_INPUT, read);
	}

	// check for local label symbol
	if (caseLUT[read] == options.localLabelSymbol) {
		isLocal = 1;
		read = LOCAL_HASH_CHAR;
		labelNameBuffer++;
		--labelNameLength; // -1 because the next part will increment it again
	}

	// get the hashcode for label or function
	while (1) {
		buffer++;
		labelNameLength++;
		labelHash = HASH_GETNEXT(labelHash, caseLUT[read]);

		// use LUT to check character
		if ((charFlagLUT[read = *buffer] & 1) == 0) {
			break;
		}
	}

	if (*buffer == ':') {
		// definitely a label
		buffer++;

	} else if (!labelAtStart) {
		// is actually a function
		funcHash = labelHash;
		funcNameBufStart = buffers.line;
		goto gotFunc;
	}

	// mark the label read status and reset local symbol status
	hasLabel = isLocal + 1;
	isLocal = 0;

	// skip more whitespace
	while (1) {
		// load character and check for NUL
		uint8_t d = *buffer;

		if (d == 0) {
			objSetAddress();
			setListingsBytes();
			SymbolExt_MakeStdLabel(labelHash);
			return;
		}

		// if not a space character, we're done found it
		if (d != ' ') {
			break;
		}

		buffer++;
	}

	// reset function name position
	funcNameBufStart = funcNameBuf = buffer;

	// check first character valid
	if ((charFlagLUT[read = *buffer] & CF_LABEL_FIRST_CHAR) == 0) {
		if (*buffer == '=') {
			// special case for SET
			funcHash = HASH_set;
			buffer++;
			goto gotFunc;
		}

		// save label
		SymbolExt_MakeStdLabel(labelHash);

		// unexpected character in input
		Error_ErrorUnderline(buffers.line, funcNameBuf, buffer, ERRFMT_UNEXPECTED_IN_INPUT, read);
	}

	// check for local label symbol
	if (caseLUT[read] == options.localLabelSymbol) {
		isLocal = 1;
		read = LOCAL_HASH_CHAR;
	}

	// get the hashcode for function
	while (1) {
		buffer++;
		funcHash = HASH_GETNEXT(funcHash, caseLUT[read]);

		// use LUT to check character
		if ((charFlagLUT[read = *buffer] & CF_LABEL_CHAR) == 0) {
			break;
		}
	}

gotFunc:;
	// fetch symbol and check its type
	Symbol* sym;

	if (isLocal) {
		sym = Symbol_FetchLocal(funcHash, SymbolExt_CurrentScope);

	} else {
		sym = Symbol_Fetch(funcHash, Symbol_GlobalTable);
	}

	if (!sym) {
		Error_PrepareString(funcNameBuf, buffer);
		Error_ErrorUnderline(buffers.line, funcNameBuf, buffer, ERRFMT_SYMBOL_UNDEFINED, buffers.error);
	}

	Tracer_WriteSymbolAction(2, isLocal ? 1 : 0, sym);

	if (sym->type != Symbol_Type_Function) {
		Error_PrepareString(funcNameBuf, buffer);
		Error_ErrorUnderline(buffers.line, funcNameBuf, buffer, ERRFMT_SYMBOL_NOT_FUNC, buffers.error);
	}

	// execute dat code
	sym->functionPtr(buffer, sym->extraParam);
}

// ---ohdSs
// s = symbol label character
// S = symbol label first character
// d = valid dec character
// h = valid hex character
// o = expression operator
// q = string delimiter or escape character
// x = other separator character

#define F00000000 0
#define F0000000s CF_LABEL_CHAR
#define F000000Ss (CF_LABEL_CHAR | CF_LABEL_FIRST_CHAR)
#define F0000h000 CF_HEX_CHAR
#define F0000h0Ss (CF_HEX_CHAR | CF_LABEL_CHAR | CF_LABEL_FIRST_CHAR)
#define F0000hd0s (CF_HEX_CHAR | CF_DEC_CHAR | CF_LABEL_CHAR)
#define F0000hdSs (CF_HEX_CHAR | CF_DEC_CHAR | CF_LABEL_CHAR | CF_LABEL_FIRST_CHAR)
#define F000o0000 CF_OPERATOR
#define F00q00000 CF_STRING
#define F0x000000 CF_SEPARATOR

uint8_t charFlagLUT[256] = {
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // 00
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // 08
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // 10
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // 18

		F0x000000, F000o0000, F00q00000, F00000000, F00000000, F000o0000, F000o0000, F00q00000, // 20
		F0x000000, F0x000000, F000o0000, F000o0000, F0x000000, F000o0000, F00000000, F000o0000, // 28
		F0000hd0s, F0000hd0s, F0000hd0s, F0000hd0s, F0000hd0s, F0000hd0s, F0000hd0s, F0000hd0s, // 30
		F0000hd0s, F0000hd0s, F00000000, F00000000, F000o0000, F000o0000, F000o0000, F0000hd0s, // 38

		F0000000s, F0000h0Ss, F0000h0Ss, F0000h0Ss, F0000h0Ss, F0000h0Ss, F0000h0Ss, F000000Ss, // 40
		F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, // 48
		F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, // 50
		F000000Ss, F000000Ss, F000000Ss, F00000000, F00q00000, F00000000, F000o0000, F000000Ss, // 58

		F00000000, F0000h0Ss, F0000h0Ss, F0000h0Ss, F0000h0Ss, F0000h0Ss, F0000h0Ss, F000000Ss, // 60
		F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, // 68
		F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, F000000Ss, // 70
		F000000Ss, F000000Ss, F000000Ss, F00000000, F000o0000, F00000000, F000o0000, F00000000, // 78

		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // 80
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // 88
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // 90
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // 98
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // A0
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // A8
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // B0
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // B8
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // C0
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // C8
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // D0
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // D8
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // E0
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // E8
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // F0
		F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, F00000000, // F8
};

uint8_t caseSensitiveLUT[256] = {
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 00
		0x80, 0xA0, 0x8A, 0x80, 0x80, 0x8D, 0x80, 0x80, // 08
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 10
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 18

		0xA0, '!', 0xA2, '#', '$', '%', 0xA6, 0xA7, // 20
		'(', ')', '*', '+', ',', '-', '.', '/',			// 28
		'0', '1', '2', '3', '4', '5', '6', '7',			// 30
		'8', '9', ':', 0xBB, '<', '=', '>', '?',		// 38

		'@', 'A', 'B', 'C', 'D', 'E', 'F', 'G',	 // 40
		'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',	 // 48
		'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',	 // 50
		'X', 'Y', 'Z', '[', 0xDC, ']', '^', '_', // 58

		'`', 'a', 'b', 'c', 'd', 'e', 'f', 'g',	 // 60
		'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',	 // 68
		'p', 'q', 'r', 's', 't', 'u', 'v', 'w',	 // 70
		'x', 'y', 'z', '{', '|', '}', '~', 0x80, // 78

		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 80
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 88
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 90
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 98
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // A0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // A8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // B0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // B8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // C0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // C8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // D0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // D8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // E0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // E8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // F0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // F8
};

uint8_t caseInsensitiveLUT[256] = {
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 00
		0x80, 0xA0, 0x8A, 0x80, 0x80, 0x8D, 0x80, 0x80, // 08
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 10
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 18

		0xA0, '!', 0xA2, '#', '$', '%', 0xA6, 0xA7, // 20
		'(', ')', '*', '+', ',', '-', '.', '/',			// 28
		'0', '1', '2', '3', '4', '5', '6', '7',			// 30
		'8', '9', ':', 0xBB, '<', '=', '>', '?',		// 38

		'@', 'a', 'b', 'c', 'd', 'e', 'f', 'g',	 // 40
		'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',	 // 48
		'p', 'q', 'r', 's', 't', 'u', 'v', 'w',	 // 50
		'x', 'y', 'z', '[', 0xDC, ']', '^', '_', // 58

		'`', 'a', 'b', 'c', 'd', 'e', 'f', 'g',	 // 60
		'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',	 // 68
		'p', 'q', 'r', 's', 't', 'u', 'v', 'w',	 // 70
		'x', 'y', 'z', '{', '|', '}', '~', 0x80, // 78

		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 80
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 88
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 90
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // 98
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // A0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // A8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // B0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // B8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // C0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // C8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // D0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // D8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // E0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // E8
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // F0
		0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, // F8
};
