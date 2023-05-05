#include <stdint.h>

#include <lib/debug.h>

#ifdef DEBUG
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#include <asmlink/symbol_ext.h>

#include <lib/compat.h>
#include <lib/math_lib.h>

#ifdef WIN
#include <windows.h>
#include <psapi.h>
HANDLE proc;
#endif

#if defined(LINUX) || defined(MACOS)
#include <sys/resource.h>
#endif

size_t memTokenTable = 0;
size_t memTokenStr = 0;
size_t memSymbols = 0;
size_t memSymStr = 0;
size_t memPass2 = 0;
size_t memStoredTokenTable = 0;
size_t memStoredTokenStr = 0;
size_t memStoredSymbols = 0;
size_t memStoredSymStr = 0;
size_t memStoredPass2 = 0;
size_t maxMemoryUsage = 0;

// initialize debugging status
void initDebug() {
#ifdef WIN
	proc = GetCurrentProcess();
#endif

	maxMemoryUsage = 0;
	updateMemoryUsage();
}

// update memory use right now
size_t updateMemoryUsage() {
#ifdef WIN
	// get memory usage on windows
	PROCESS_MEMORY_COUNTERS_EX pmc;
	GetProcessMemoryInfo(proc, (PROCESS_MEMORY_COUNTERS*)&pmc, sizeof(pmc));
	const size_t usedBytes = (size_t)pmc.PrivateUsage;
#endif

#ifdef LINUX
	// get memory usage on linux
	struct rusage usage;
	getrusage(RUSAGE_SELF, &usage);

	const size_t usedBytes = usage.ru_maxrss * 1024;
#endif

#ifdef MACOS
	// get memory usage on linux
	struct rusage usage;
	getrusage(RUSAGE_SELF, &usage);

	const size_t usedBytes = usage.ru_maxrss;
#endif

	// update memory
	if (usedBytes > maxMemoryUsage) {
		maxMemoryUsage = usedBytes;
		memStoredTokenTable = memTokenTable;
		memStoredTokenStr = memTokenStr;
		memStoredSymbols = memSymbols;
		memStoredSymStr = memSymStr;
		memStoredPass2 = memPass2;
	}

	return usedBytes;
}

// print debugging info on finish
void printDebugInfoFinish() {
	printf("DEBUG: Current memory allocation: %.*f KB\n\n", 1, updateMemoryUsage() / 1024.0);
	printf("DEBUG: Maximum memory allocation: %.*f KB\n", 1, maxMemoryUsage / 1024.0);
	printf("DEBUG: Token table memory:        %.*f KB\n", 1, memStoredTokenTable / 1024.0);
	printf("DEBUG: Token string memory:       %.*f KB\n", 1, memStoredTokenStr / 1024.0);
	printf("DEBUG: Symbol memory:             %.*f KB\n", 1, memStoredSymbols / 1024.0);
	printf("DEBUG: Symbol string memory:      %.*f KB\n", 1, memStoredSymStr / 1024.0);
	printf("DEBUG: Pass 2 memory:             %.*f KB\n", 1, memStoredPass2 / 1024.0);
}

#endif
