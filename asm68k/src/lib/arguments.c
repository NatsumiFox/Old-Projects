#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include <lib/arguments.h>

//////////////////////////////////////////////////////////////////////////////
// Macro definitions
//////////////////////////////////////////////////////////////////////////////

#define ARGUMENT_CHECKERROR(start, end)                                          \
	if (mode != Arguments_ReturnType_OK && mode != Arguments_ReturnType_Param) { \
		if (mode == Arguments_ReturnType_Error) {                                \
			Argument_PrintError(usage, argc, argv, start, end);                  \
		}                                                                        \
		return 0;                                                                \
	}

//////////////////////////////////////////////////////////////////////////////
// Main function
//////////////////////////////////////////////////////////////////////////////

static void Argument_PrintError(char* usage, int argc, char* argv[], uint32_t start, uint32_t end) {
	printf("\n   ");

	// print the actual commandline
	for (int a = 0; a < argc; a++) {
		printf(" %s", argv[a]);
	}

	// generate the beginning whitespace
	printf("\n   ");

	for (uint32_t s = 0; s < start; s++) {
		printf(" ");
	}

	// generate the caret and tildes
	printf("^");

	for (uint32_t t = start + 1; t < end; t++) {
		printf("~");
	}

	// print usage
	printf("\n\n%s", usage);
}

enum Arguments_ReturnType Arguments_Process(char* usage, int argc, char* argv[], enum Arguments_ReturnType (*handler)(enum Arguments_Mode mode, char* text)) {
	int8_t mode = Arguments_ReturnType_OK;
	uint32_t position = strlen(argv[0]) + 2, end = 0;

	// run for each argument
	for (int a = 1; a < argc; a++) {
		end = position + strlen(argv[a]);

		if (mode == Arguments_ReturnType_Param) {
			// handle current param
			mode = handler(Arguments_ReturnType_Param, argv[a]);

		} else if (argv[a][0] == '+') {
			// plus prefix
			mode = handler(Arguments_Mode_Plus, argv[a] + 1);

		} else if (argv[a][0] == '-') {
			if (argv[a][1] == '-') {
				// flag prefix
				mode = handler(Arguments_Mode_Flag, argv[a] + 2);

			} else {
				// minus prefix
				mode = handler(Arguments_Mode_Minus, argv[a] + 1);
			}

		} else {
			// no prefix
			mode = handler(Arguments_Mode_Text, argv[a]);
		}

		// check if we've been requested to bail
		ARGUMENT_CHECKERROR(position, end);
		position = end + 1;
	}

	// check if we wanted an extra param
	if (mode == Arguments_ReturnType_Param) {
		mode = handler(Arguments_Mode_Null, NULL);
	}

	if (mode == Arguments_ReturnType_OK) {
		// tell this is the end of the argument list
		mode = handler(Arguments_Mode_End, NULL);
	}

	// check if there was an error
	ARGUMENT_CHECKERROR(position, position + 1);
	return 1;
}
