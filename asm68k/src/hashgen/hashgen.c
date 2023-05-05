#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <locale.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <lib/arguments.h>
#include <lib/compat.h>
#include <lib/hash_lib.h>
#include <lib/files.h>

//////////////////////////////////////////////////////////////////////////////
// Macro definitions
//////////////////////////////////////////////////////////////////////////////

// Macro for calculating the size of an array
#define SIZEOF_ARRAY(A) (sizeof(A) / sizeof(A[0]))

// Max identifier size
#define MAX_IDENTIFIER_SIZE 24u

//////////////////////////////////////////////////////////////////////////////
// Type definitions
//////////////////////////////////////////////////////////////////////////////

typedef enum {
	Casing_AsIs = 0,
	Casing_UpperLower,
} Casing;

typedef enum {
	ParamTarget_None = 0,
	ParamTarget_Casing,
	ParamTarget_CharType,
} ParamTarget;

typedef enum {
	ReadResult_OK = 0,
	ReadResult_EndOfFile,
	ReadResult_FileError,
	ReadResult_LineTooBig,
} ReadResult;

//////////////////////////////////////////////////////////////////////////////
// External variables
//////////////////////////////////////////////////////////////////////////////

// Usage message
extern const char UsageMessage[];

// Help message
extern const char HelpMessage[];

// Header file preamble
extern const char HeaderPreamble[];

// Header file footer
extern const char HeaderFooter[];

// Source file preamble
extern const char SourcePreamble[];

// Source file footer
extern const char SourceFooter[];

//////////////////////////////////////////////////////////////////////////////
// Static variables
//////////////////////////////////////////////////////////////////////////////

// Global program data
//
// TODO: Some of them could probably be localized.
static struct {
	// Command-line parsing results
	// ============================

	// File names
	const char* inputFileName;
	const char* outputSourceFileName;
	const char* outputHeaderFileName;

	// How to handle cases
	Casing casing;
	// Which character type to use
	const char* charType;

	// Various flags
	bool showHelp : 1;
	bool showUsage : 1;
	bool requiresStdint : 1;

	// Other global program parameters
	// ============================

	// Active file handlers
	FILE* inputFile;
	FILE* outputSourceFile;
	FILE* outputHeaderFile;

	// Current line number
	unsigned lineNumber;

	// Identifier counter
	uint32_t identifierCounter;
} Program = {
	.showUsage = true,
	.charType = "char"};

// Argument parser data
static struct {
	unsigned textArgCount;
	ParamTarget paramTarget;
} Args = {0};

//////////////////////////////////////////////////////////////////////////////
// Static function declarations
//////////////////////////////////////////////////////////////////////////////

// Argument parser callback
static enum Arguments_ReturnType ArgParserCallback(enum Arguments_Mode mode, char* string);

// Finishes the app if couldn't open file
static FILE* OpenFileOrQuit(const char* filename, const char* mode);

// Closes all opened files
static void CloseAllFiles(void);

// Writes header hash file preamble
static void WriteHeaderPreamble(FILE* file);

// Writes source hash file preamble
static void WriteSourcePreamble(FILE* file);

// Writes header hash file footer
static void WriteHeaderFooter(FILE* file);

// Writes source hash file footer
static void WriteSourceFooter(FILE* file);

// Reads a line
static ReadResult ReadLine(FILE* file, char* buffer, size_t* size);

// Returns true if identifier is valid
static bool IsValidIdentifier(const char* str);

// Returns hash of the identifier
static uint32_t CalculateHash(const char* str);

// Reports an error and quits
static c_noreturn void Error(const char* message, ...);

// Reports a warning
static void Warn(const char* message, ...);

// Reports a warning for a file line
static void WarnFile(
	const char* filename, uint32_t line, const char* message, ...);

// Prints a message
static void Message(const char* message, ...);

//////////////////////////////////////////////////////////////////////////////
// Inline functions
//////////////////////////////////////////////////////////////////////////////

// Makes all string characters uppercase
c_inline void StringToUpper(char* str) {
	size_t i;

	for (i = 0; str[i] != '\0'; i++) {
		str[i] = toupper(str[i]);
	}
}

// Makes all string characters lowercase
c_inline void StringToLower(char* str) {
	size_t i;

	for (i = 0; str[i] != '\0'; i++) {
		str[i] = tolower(str[i]);
	}
}

// Skips the current line. Returns false if found EOF instead.
c_inline bool SkipLine(FILE* file) {
	int ch;

	while (true) {
		ch = fgetc(file);
		switch (ch) {
			case '\n':
				return true;

			case EOF:
				return false;
		}
	}
}

// Writes the header hash data for the identifier
c_inline void WriteHeaderHashData(
	FILE* file, const char* ident, uint32_t hash) {
	fprintf(file, "#define HASH_%s 0x%08X\n", ident, hash);
	fprintf(file, "#define BI_%s %u\n", ident, Program.identifierCounter);

	Program.identifierCounter++;
}

// Writes the header hash data for the identifier
c_inline void WriteHeaderIdentName(FILE* file, const char* identVar) {
	fprintf(file, "extern %s HN_%s[];\n\n", Program.charType, identVar);
}

// Writes the source hash data for the identifier
c_inline void WriteSourceIdentName(
	FILE* file, const char* identVar, const char* identValue) {
	fprintf(
		file, "%s HN_%s[] = \"%s\";\n", Program.charType, identVar, identValue);
}

c_inline bool Files_IsPathSeparator(char ch) {
#if defined(WIN)
	return ch == '\\' || ch == '/';
#else
	return ch == PATH_SEPARATOR;
#endif
}

c_inline void WriteIncludeStdint(FILE* file) {
	fprintf(file, "#include <stdint.h>\n\n");
}

c_inline void WriteIncludeLocalFile(FILE* file, const char* filename) {
	fprintf(file, "#include \"%s\"\n\n", Files_ExtractFileName(filename));
}

c_inline void WriteIdentCount(FILE* file) {
	fprintf(file, "#define BI_NUM_ELEMENTS %u\n\n", Program.identifierCounter);
}

//////////////////////////////////////////////////////////////////////////////
// Main function
//////////////////////////////////////////////////////////////////////////////

int main(int argc, char** argv) {
	char ident[MAX_IDENTIFIER_SIZE + 1];
	size_t identSize;
	uint32_t hash;
	ReadResult readResult;
	uint8_t parseOk;

#if defined(WIN)
	// Set UTF-8 locale for Windows, so the program would print normally
	// in CMD instead of glibberish, which can happen in other locales
	setlocale(LC_CTYPE, ".UTF8");
#endif

	// Try to parse command-line arguments. Show usage or help and exit
	// if needed

	parseOk = Arguments_Process((char*)"", argc, argv, ArgParserCallback);
	if (!parseOk || Program.showUsage) {
		fputs(UsageMessage, stderr);
		return 1;
	}

	if (Program.showHelp) {
		fputs(HelpMessage, stdout);
		return 0;
	}

	// Open files

	Program.inputFile = OpenFileOrQuit(Program.inputFileName, "r");
	Program.outputHeaderFile = OpenFileOrQuit(Program.outputHeaderFileName, "w");
	Program.outputSourceFile = OpenFileOrQuit(Program.outputSourceFileName, "w");

	// Write preambles to header and source files

	WriteHeaderPreamble(Program.outputHeaderFile);
	WriteSourcePreamble(Program.outputSourceFile);

	if (Program.requiresStdint) {
		WriteIncludeStdint(Program.outputHeaderFile);
	}

	WriteIncludeLocalFile(Program.outputSourceFile, Program.outputHeaderFileName);

	// Run this loop until all the lines were parsed or empty line encountered
	while (true) {
		// Read an identifier
		identSize = sizeof(ident);
		readResult = ReadLine(Program.inputFile, ident, &identSize);
		Program.lineNumber += 1;

		switch (readResult) {
			// Continue as usual if identifier was read successfully
			case ReadResult_OK:
				break;

			// Stop if reached EOF
			case ReadResult_EndOfFile:
				goto EndRead;

			// Report an error and quit if encountered a file error
			case ReadResult_FileError:
				Error(
					"error occured while reading file \"%s\" (errno %d: %s)\n",
					Program.inputFileName, errno, strerror(errno));
				break;

			// Issue a warning and go to next identifier if the line is bigger
			// than max identifier size
			case ReadResult_LineTooBig:
				WarnFile(
					Program.inputFileName, Program.lineNumber,
					"hashing ignored, line is too big: \"%s...\"\n", ident);
				if (SkipLine(Program.inputFile)) {
					// If the line was skipped, continue on
					continue;
				} else {
					// If EOF was reached, quit
					goto EndRead;
				}
		}

		// If the size of identifier is 0, it means we have an empty line and
		// we should stop
		if (identSize == 0) {
			break;
		}

		// If identifier is invalid, issue a warning and go to next identifier
		if (!IsValidIdentifier(ident)) {
			WarnFile(
				Program.inputFileName, Program.lineNumber,
				"hashing ignored, invalid identifier: \"%s\"\n", ident);
			continue;
		}

		// Calculate hash and write it to files, depending on the identifier
		// casing
		switch (Program.casing) {
			case Casing_AsIs:
				hash = CalculateHash(ident);
				WriteHeaderHashData(Program.outputHeaderFile, ident, hash);
				WriteHeaderIdentName(Program.outputHeaderFile, ident);
				WriteSourceIdentName(Program.outputSourceFile, ident, ident);
				break;

			case Casing_UpperLower: {
				char identUp[MAX_IDENTIFIER_SIZE + 1];

				// Create an upper-case copy of identifier
				strcpy(identUp, ident);
				StringToLower(ident);
				StringToUpper(identUp);

				hash = CalculateHash(ident);
				WriteHeaderHashData(Program.outputHeaderFile, ident, hash);
				hash = CalculateHash(identUp);
				WriteHeaderHashData(Program.outputHeaderFile, identUp, hash);
				WriteHeaderIdentName(Program.outputHeaderFile, identUp);
				WriteSourceIdentName(Program.outputSourceFile, identUp, ident);
				break;
			}
		}
	}

EndRead:
	// When we're done, write footers and exit
	WriteIdentCount(Program.outputHeaderFile);
	WriteHeaderFooter(Program.outputHeaderFile);
	WriteSourceFooter(Program.outputSourceFile);

	Message("hashing finished");
	CloseAllFiles();
	return 0;
}

///////////////////////////////////////////////////////////////////////////////
// Other function definitions
///////////////////////////////////////////////////////////////////////////////

/**
	\brief A callback for argument parsing function.

	\param mode Information about parameter (text, flag, etc).
	\param param The parameter value. May be NULL depending on the mode
	parameter.
	\return int8_t The hint for the caller function (parser).
*/
enum Arguments_ReturnType ArgParserCallback(enum Arguments_Mode mode, char* param) {
	int8_t result;

	switch (mode) {
		case Arguments_Mode_End:
			if (Args.textArgCount < 3) {
				return Arguments_ReturnType_Error;
			}
			return Arguments_ReturnType_OK;

		case Arguments_Mode_Flag:
			if (strcmp(param, "help") == 0) {
				Program.showHelp = true;
				result = Arguments_ReturnType_Bail;
			} else if (strcmp(param, "cases") == 0) {
				Args.paramTarget = ParamTarget_Casing;
				result = Arguments_ReturnType_Param;
			} else if (strcmp(param, "ctype") == 0) {
				Args.paramTarget = ParamTarget_CharType;
				result = Arguments_ReturnType_Param;
			} else {
				result = Arguments_ReturnType_Error;
			}
			break;

		case Arguments_Mode_Text:
			result = Arguments_ReturnType_OK;
			switch (Args.textArgCount) {
				case 0:
					Program.inputFileName = param;
					break;

				case 1:
					Program.outputHeaderFileName = param;
					break;

				case 2:
					Program.outputSourceFileName = param;
					break;

				default:
					result = Arguments_ReturnType_Error;
					break;
			}
			Args.textArgCount += 1;
			break;

		case Arguments_Mode_Param:
			result = Arguments_ReturnType_OK;
			switch (Args.paramTarget) {
				case ParamTarget_Casing:
					if (strcmp(param, "as-is") == 0) {
						Program.casing = Casing_AsIs;
					} else if (strcmp(param, "upper-lower") == 0) {
						Program.casing = Casing_UpperLower;
					} else {
						result = Arguments_ReturnType_Error;
					}
					break;

				case ParamTarget_CharType:
					if (strcmp(param, "char") == 0) {
						Program.charType = "char";
						Program.requiresStdint = false;
					} else if (strcmp(param, "uint8_t") == 0) {
						Program.charType = "uint8_t";
						Program.requiresStdint = true;
					} else {
						result = Arguments_ReturnType_Error;
					}
					break;

				default:
					result = Arguments_ReturnType_Error;
					break;
			}
			Args.paramTarget = ParamTarget_None;
			break;

		default:
			result = Arguments_ReturnType_Error;
			break;
	}

	Program.showUsage = false;
	return result;
}

/**
	\brief Opens file and returns it or quits with error message.

	\param filename File name to open.
	\param mode Mode to to open file with.
	\return FILE* Opened file.
*/
FILE* OpenFileOrQuit(const char* filename, const char* mode) {
	FILE* file = fopen(filename, mode);

	if (!file) {
		Error(
			"failed to open file \"%s\" with mode \"%s\" (errno %d: %s)",
			filename, mode,
			errno, strerror(errno));
	}

	return file;
}

/**
	\brief Closes all opened files.
*/
void CloseAllFiles(void) {
	FILE* const files[] = {
		Program.inputFile,
		Program.outputHeaderFile,
		Program.outputSourceFile};

	size_t i;

	for (i = 0; i < SIZEOF_ARRAY(files); i++) {
		if (files[i] != NULL) {
			fclose(files[i]);
		}
	}
}

/**
	\brief Writes the header hash file preamble.

	\param file File to write preamble to.
*/
void WriteHeaderPreamble(FILE* file) {
	fputs(HeaderPreamble, file);
}

/**
	\brief Writes the source hash file preamble.

	\param file File to write preamble to.
*/
void WriteSourcePreamble(FILE* file) {
	fputs(SourcePreamble, file);
}

/**
	\brief Writes the header hash file footer.

	\param file File to write footer to.
*/
void WriteHeaderFooter(FILE* file) {
	fputs(HeaderFooter, file);
}

/**
	\brief Writes the source hash file footer.

	\param file File to write footer to.
*/
void WriteSourceFooter(FILE* file) {
	fputs(SourceFooter, file);
}

/**
	\brief Reads a line from file to a buffer.

	\param file File to read line from.
	\param buffer Buffer to put line into. Held line doesn't have LF character.
	\param size Pointer to the size of buffer. Holds line size without LF
	character upon successful completion.

	\details Param size holds different values on different return values.
	`ReadResult_OK` - line was read successfully, size holds line size.
	`ReadResult_EndOfFile` - EOF was encountered, size is unchanged.
	`ReadResult_FileError` - file error was encountered, size is unchanged.
	`ReadResult_LineTooBig` - line cannot fit in the buffer, size holds buffer
	size minus one.

	\return ReadResult The status of operation.
*/
ReadResult ReadLine(FILE* file, char* buffer, size_t* size) {
	size_t i;
	memset(buffer, 0, *size);
	buffer = fgets(buffer, *size, file);
	if (buffer == NULL) {
		if (feof(file) && !ferror(file)) {
			return ReadResult_EndOfFile;
		} else {
			return ReadResult_FileError;
		}
	}

	for (i = 0; i < *size; i++) {
		switch (buffer[i]) {
			case '\0':
				*size = i;
				return ReadResult_LineTooBig;

			case '\n':
				buffer[i] = '\0';
				*size = i;
				return ReadResult_OK;
		}
	}

	assert(false && "line wasn't terminated");
	buffer[*size - 1] = '\0';
	return ReadResult_LineTooBig;
}

/**
	\brief Checks if identifier is valid.

	\param str The buffer to check identifier from.
	\return true if identifier is valid.
*/
bool IsValidIdentifier(const char* str) {
	size_t i;
	int ch;

	ch = (int)str[0];
	if (ch < 1 || ch > 0x7F || !(isalpha(ch) || ch == '_')) {
		return false;
	}

	for (i = 1; str[i] != '\0'; i++) {
		ch = (int)str[i];
		if (ch < 0 || ch > 0x7F || !(isalnum(ch) || ch == '_')) {
			return false;
		}
	}

	return true;
}

/**
	\brief Calculates hash for the identifier.

	\param str Identifier to calculate hash from.
	\return Hash value.
*/
uint32_t CalculateHash(const char* str) {
	size_t i;
	uint32_t hash = 0;

	for (i = 0; str[i] != '\0'; i++) {
		hash = HASH_GETNEXT(hash, str[i]);
	}

	return hash;
}

// Reports an error and quits
c_noreturn void Error(const char* message, ...) {
	va_list args;

	fprintf(stderr, "hashgen: error: ");
	va_start(args, message);
	vfprintf(stderr, message, args);
	va_end(args);

	CloseAllFiles();
	exit(1);
}

// Reports a warning
void Warn(const char* message, ...) {
	va_list args;

	fprintf(stderr, "hashgen: warning: ");
	va_start(args, message);
	vfprintf(stderr, message, args);
	va_end(args);
}

// Reports a warning for a file line
void WarnFile(const char* filename, uint32_t line, const char* message, ...) {
	va_list args;

	fprintf(stderr, "hashgen: warning: %s:%u: ", filename, line);
	va_start(args, message);
	vfprintf(stderr, message, args);
	va_end(args);
}

// Prints a message
void Message(const char* message, ...) {
	va_list args;

	fprintf(stderr, "hashgen: ");
	va_start(args, message);
	vfprintf(stderr, message, args);
	va_end(args);
}
