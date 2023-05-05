#if !defined(INCLUDE_ASSEMBLER_PARSE_H)
#define INCLUDE_ASSEMBLER_PARSE_H

#include <stdio.h>

#include <lib/lengthstring.h>

#define CF_LABEL_CHAR 1
#define CF_LABEL_FIRST_CHAR 2
#define CF_DEC_CHAR 4
#define CF_HEX_CHAR 8
#define CF_OPERATOR 0x10
#define CF_STRING 0x20
#define CF_SEPARATOR 0x40

extern uint8_t charFlagLUT[256];
extern uint8_t caseSensitiveLUT[256];
extern uint8_t caseInsensitiveLUT[256];

// structure for ASM file definition
#define ASM_FILE_BUFFER_LEN 0x4000

typedef struct {
	uint32_t lineNumber;
	uint32_t size;
	FILE* file;
	LengthString* filename;
	uint8_t* endPos; // set to the end of the buffer when fread returns 0 bytes
	uint8_t* data;
	uint8_t* buffer;
	uint8_t bufferNUL;
} AsmFile;

// list of asm files
#define ASM_FILE_STACK_SIZE 32
extern AsmFile asmFileStack[ASM_FILE_STACK_SIZE];
extern int32_t asmFileStackPos;
extern AsmFile* currentFile;
extern uint32_t totalLines;

// helpers for current asm file
extern uint32_t* _lineNumber;
extern LengthString* _filename;

// if INCLUDE is used, the file will be temporarily stored here
extern LengthString* includedFilename;
extern FILE* includedFile;

// functions
void initAsmFile();

AsmFile* openAsmFile();

void closeAllAsmFiles();

void closeAsmFile();

void parseAsmFile();

void parseBufferAsAsm(uint8_t* buffer, uint32_t length);

void processLine();

void sanitizeLine();

// special character that is applied to the hashing function when local labels are used.
// must be the first hashed character
#define LOCAL_HASH_CHAR '\xFF'

// parse jump pointer
extern jmp_buf parseJumpBuf;

#endif // INCLUDE_ASSEMBLER_PARSE_H
