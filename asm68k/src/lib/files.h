#if !defined(INCLUDE_ASSEMBLER_FILES_H)
#define INCLUDE_ASSEMBLER_FILES_H

#include <stdio.h>

#include <lib/compat.h>
#include <lib/lengthstring.h>

void initIncludePaths();

void addIncludePath(uint8_t* path);
uint8_t* getFilenameStart(uint8_t* path);
FILE* findFile(uint8_t* path, char* mode, LengthString** filename);
const char* Files_ExtractFileName(const char* path);

#ifdef WIN
#define PATH_SEPARATOR 0x5C
#define PATH_REPLACE '/'

#elif defined(LINUX) || defined(MACOS)
#define PATH_SEPARATOR '/'
#define PATH_REPLACE 0x5C
#endif

#endif // INCLUDE_ASSEMBLER_FILES_H
