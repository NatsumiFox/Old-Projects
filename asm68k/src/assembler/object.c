#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "error.h"
#include "hash.h"
#include "listings.h"
#include "object.h"

#include <asmlink/debug_tracer.h>
#include <asmlink/symbol_ext.h>

#include <lib/compat.h>
#include <lib/files.h>
#include <lib/messages/global.h>

FILE* objectFile;
char* objectPath;
volatile char* objectBufferPtr;
volatile char* objectListBufferPtr;
uint64_t objectFileBaseAddr = 0;
volatile uint64_t objectAddress = 0;
volatile uint64_t objectAddrLine = 0;
volatile char objectBuffer[OBJ_BUFFER_SIZE];

// function to initialize the object file
void initializeObjectFile() {
	Tracer_WriteFileMode(0, objectPath, "object-file");
	objectFile = fopen(objectPath, "w+b");

	// check if failed to make the file
	if (!objectFile) {
		Error_ErrorProgram(ERRFMT_FILE_NOT_FOUND " ", objectPath);
	}

	fseek(objectFile, 0, SEEK_SET);

	// initialize params
	objectFileBaseAddr = 0;
	objectListBufferPtr = objectBufferPtr = objectBuffer;

	// initialize object file here
}

// function to flush the object buffer
void flushObjectBuffer() {
	objectFileBaseAddr += objectBufferPtr - objectBuffer;
	fwrite((char*)objectBuffer, 1, objectBufferPtr - objectBuffer, objectFile);
	objectListBufferPtr /* TODO: probably causes bugs! */ = objectBufferPtr = objectBuffer;
}

// close object file
void closeObjectFile() {
	if (objectFile) {
		Tracer_WriteFileMode(1, objectPath, "object-file");

		// flush and close
		fclose(objectFile);

		// also delete if it has errors
		if (Error_ErrorCount > 0) {
			remove(objectPath);
		}
	}
}

// get object file write position
uint64_t getObjectFilePos() {
	return objectFileBaseAddr + (objectBufferPtr - objectBuffer);
}
