#include <errno.h>
#include <limits.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <assembler/error.h>

#include <lib/files.h>
#include <lib/compat.h>
#include <lib/math_lib.h>
#include <lib/messages/global.h>

#if defined(WIN)
#include <windows.h>

#elif defined(LINUX) || defined(MACOS)
#include <dirent.h>
#include <unistd.h>
#endif

#if defined(WIN)

c_inline bool IsDirectoryExists(const char* dirName) {
	DWORD fileAttr = GetFileAttributesA(dirName);

	if (fileAttr == INVALID_FILE_ATTRIBUTES) {
		return false;

	} else if ((fileAttr & FILE_ATTRIBUTE_DIRECTORY) != 0) {
		return true;

	} else {
		return false;
	}
}

#elif defined(LINUX) || defined(MACOS)

c_inline bool IsDirectoryExists(const char* dirName) {
	DIR* dir = opendir(dirName);

	if (dir != NULL) {
		closedir(dir);
		return true;

	} else if (errno == ENOENT) {
		return false;

	} else {
		return true;
	}
}
#endif

c_inline bool Files_IsPathSeparator(char ch) {
#if defined(WIN)
	return ch == '\\' || ch == '/';
#else
	return ch == PATH_SEPARATOR;
#endif
}

const char* Files_ExtractFileName(const char* path) {
	int32_t i, pathSepIndex = -1;

	for (i = 0; path[i] != '\0'; i++) {
		if (Files_IsPathSeparator(path[i])) {
			pathSepIndex = i;
		}
	}

	return &path[pathSepIndex + 1];
}

uint32_t pathAlloc;
LengthString** paths;

// function to return a pointer to the filename
uint8_t* getFilenameStart(uint8_t* path) {
	uint8_t* pos = path;
	uint8_t ch;

	// find the last path separator
	do {
		ch = *path++;

		if(Files_IsPathSeparator((char)ch)) {
			pos = path;
		}

	} while(ch != 0);

	return pos;
}

// function to normalize paths
uint8_t* normalizePath(uint8_t* path) {
	uint8_t ch = 0, lastch;

	// replace all path separators to OS-preferred separators
	while (1) {
		lastch = ch;
		ch = *path;

		if (ch == 0) {
			// special check if the last character is a path separator
			if (lastch == PATH_SEPARATOR) {
				path--;
			}
			break;

		} else if (ch == PATH_REPLACE) {
			// replace path separator
			*path = PATH_SEPARATOR;
		}

		path++;
	}

	return path;
}

// function to convert path fragment to absolute path relative to `base`. Will return NULL if can not created path. If `base` is null, only absolute paths are allowed.
LengthString* getAbsolutePath(uint8_t* path, uint32_t pathLen, LengthString* base) {
	// determine if this is an absolute file path
#ifdef WIN
	if (*(path + 1) == ':') {
#endif
#if defined(LINUX) || defined(MACOS)
		if (*path == PATH_SEPARATOR) {
#endif
			LengthString* res = LengthString_FromBuffer(path, pathLen);

			if (res) {
				return res;
			}

			return NULL;
		}

		// check if base has value
		if (base == NULL) {
			return NULL;
		}

		// check for a starting ./ (or .\ on windows!)
		uint32_t offset = 0;

		if (*path == '.' && Files_IsPathSeparator(*(path + 1))) {
			offset = 2;
		}

		// create a combined file path
		LengthString* ret = LengthString_AllocateNew(pathLen + base->length + 1 - offset);

		if (!ret) {
			return NULL;
		}

		// create the file path
		memcpy(ret->string, base->string, base->length);
		uint8_t* mid = ret->string + base->length + 1;
		*(mid - 1) = PATH_SEPARATOR;
		memcpy(mid, path + offset, pathLen - offset);
		*(mid + pathLen - offset) = 0;
		return ret;
	}

	// function to find a file from path
	FILE* findFile(uint8_t* path, char* mode, LengthString** filename) {
		// create
		uint8_t* end = normalizePath(path);
		uint32_t pathLen = end - path;

		// determine if this is an absolute file path
		*filename = getAbsolutePath(path, pathLen, NULL);

		if (*filename != NULL) {
			return fopen((char*)((*filename)->string), mode);
		}

		// check each path separately
		for (uint32_t i = 0; i < pathAlloc; i++) {
			// generate a new file path to check if its valid
			*filename = getAbsolutePath(path, pathLen, paths[i]);

			// attempt to open it was a file
			FILE* f = fopen((char*)((*filename)->string), mode);

			if (f) {
				return f;
			}

			// delete the buffer then! :(
			free(*filename);
		}

		// no file can be opened! :(
		return NULL;
	}

	// function to fetch the current working directory
	void getWorkingDirectory(char* buffer, uint32_t maxlen) {
#ifdef WIN
		GetCurrentDirectory(maxlen, buffer);
#endif
#if defined(LINUX) || defined(MACOS)
		getcwd(buffer, maxlen);
#endif
	}

	// function to initialize the current working directory
	char workingDir[FILENAME_MAX + 2];

	void initIncludePaths() {
		// initialize the path variables
		pathAlloc = 0;
		paths = NULL;

		// add the working directory as a path
		getWorkingDirectory(workingDir, FILENAME_MAX);
		addIncludePath((uint8_t*)workingDir);
	}

	// function to add a new file path to include paths
	void addIncludePath(uint8_t* path) {
		uint8_t* end = normalizePath(path);

		// make the file become and absolute path relative to current working directory
		LengthString* absPath = getAbsolutePath(path, end - path, pathAlloc == 0 ? NULL : paths[0]);

		if (absPath == NULL) {
			Error_Fatal(2, ERRFMT_BUG_CANT_NORMALIZE " ", path);
		}

		if (!IsDirectoryExists((const char*)absPath->string)) {
			Error_Fatal(2, ERRFMT_PATH_NOT_DIR " ", absPath->string);
		}

		// allocate the path now
		pathAlloc++;
		paths = realloc(paths, sizeof(LengthString*) * pathAlloc);
		paths[pathAlloc - 1] = absPath;
	}
