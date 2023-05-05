#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "lines.h"
#include "main.h"

#include <lib/compat.h>
#include <lib/math_lib.h>

typedef struct {
	uint64_t address;
	ListingsLine* list;
} LineInfo;

LineInfo* linesData;
uint32_t linesAlloc;
uint32_t linesUsed;

uint32_t curLine = 0;
int64_t uiShift = 0;

#pragma region Init and Library
#define MAXADDR() MAX(baseHelper.size, objectHelper.size)

// TODO: Use a saner function for this
#define clearInput(v)                             \
	while (((v) = getchar()) != '\n' && (v) != EOF) \
		;

#define BYTES_PER_LINE 16
#define LINES_PER_TYPE 8
#define BASE_LINE 2
#define OBJ_LINE (3 + LINES_PER_TYPE)
#define LIST_LINE (4 + (LINES_PER_TYPE * 2))
#define ISNTR_LINE (4 + (LINES_PER_TYPE * 3))

#define UI_W 80
#define UI_H (4 - 2 + 2 + (LINES_PER_TYPE * 3))

#if defined(WIN)
#include <conio.h>
#include <windows.h>
HANDLE handle;

#elif defined(LINUX) || defined(MACOS)
#include <termios.h>
#include <unistd.h>
static struct termios normalTerm, inputTerm;
#endif

// tiny helper to init os-related function
void initSystemVars() {
#if defined(WIN)
	handle = GetStdHandle(STD_OUTPUT_HANDLE);

#elif defined(LINUX) || defined(MACOS)
	// clone terminal attributes, to disable ICANON and ECHO
	tcgetattr(STDIN_FILENO, &normalTerm);
	memcpy(&inputTerm, &normalTerm, sizeof(struct termios));
	inputTerm.c_lflag &= ~(ICANON | ECHO);
	tcsetattr(STDIN_FILENO, TCSANOW, &inputTerm);
#endif
}

// tiny helper to enable text input
void setTextInput(uint8_t enabled) {
#if defined(LINUX) || defined(MACOS)
	tcsetattr(STDIN_FILENO, TCSANOW, (enabled ? &normalTerm : &inputTerm));
#endif
}

// helper function to set the console size
void setConsoleSize(int w, int h) {
#if defined(WIN)
	COORD size = {
			.X = w,
			.Y = h,
	};
	SetConsoleScreenBufferSize(handle, size);
#endif
}

// some helper functions
#define clearScreen() printf("\033[0J");
#define setCursor(x, y) printf("\033[%d;%dH", (y), (x));
#define setTitlebar() printf("\033[38;5;235;48;5;248;1m");
#define clearRestOfLine() printf("\033[0K");
#define setBody() printf("\033[0m");
#define getByteColor(match) match ? "\033[0m" : "\033[38;5;202;1m";
#define INS_BUTTON "\033[38;5;21;1m"
#define INS_TEXT "\033[30;22m"
#define setCursorOff() printf("\033[?25l");
#define setCursorOn() printf("\033[?25h");

// function to render instructions bar
void renderInstructions() {
	setTitlebar();
	setCursor(1, ISNTR_LINE);
	printf(INS_BUTTON " LEFT/RIGHT " INS_TEXT "shift base " INS_BUTTON " R " INS_TEXT "reset shift" INS_BUTTON " BACK " INS_TEXT "previous difference" INS_BUTTON " RET " INS_TEXT "next difference" INS_BUTTON " ESC " INS_TEXT "quit");
	clearRestOfLine();

	setCursor(1, ISNTR_LINE + 1);
	printf(INS_BUTTON "   UP/DOWN  " INS_TEXT "switch line" INS_BUTTON " F " INS_TEXT "find bytes " INS_BUTTON "  F2  " INS_TEXT "find previous      " INS_BUTTON " F3  " INS_TEXT "find next      " INS_BUTTON "  G  " INS_TEXT "go to address");
	clearRestOfLine();
}

// function to initialize the ui mode
void initUiMode() {
	initSystemVars();
	setConsoleSize(UI_W, UI_H);
	setCursorOff();
	setBody();
	setCursor(0, 0);
	clearScreen();

	// reset helper addresses
	baseHelper.address = UINT64_MAX;
	objectHelper.address = UINT64_MAX;

	// render instructions
	renderInstructions();

	// render filenames
	setCursor(1, BASE_LINE - 1);
	printf("\033[4m%.*s\033[24m", UI_W, baseHelper.filename);
	clearRestOfLine();

	setCursor(1, OBJ_LINE - 1);
	printf("\033[4m%.*s\033[24m", UI_W, objectHelper.filename);
	clearRestOfLine();
}

#pragma endregion
#pragma region Rendering

// byte line buffers
char baseByteBuf[512];
char objByteBuf[512];
char* baseBuf;
char* objBuf;

// function to re-render ui mode, where `address` is the address of the first line to be rendered
void renderUiMode(uint32_t line, int32_t shift) {
	// fetch data for both objects
	loadBuffer(&baseHelper, linesData[line].address + shift);
	loadBuffer(&objectHelper, linesData[line].address);

	// update listings file
	setTitlebar();
	setCursor(1, LIST_LINE - 1);
	printf("\033[4m%.*s\033[24m (%d)", UI_W - 8, linesData[line].list->file, linesData[line].list->line);
	clearRestOfLine();

	// write all line stuffs
	for (int i = 0; i < LINES_PER_TYPE; i++) {
		// limit line
		if ((uint32_t)i + line + 1 >= linesUsed) {
			setBody();
			setCursor(1, OBJ_LINE + i);
			clearRestOfLine();

			setCursor(1, LIST_LINE + i);
			clearRestOfLine();

			setCursor(1, BASE_LINE + i);
			clearRestOfLine();
			continue;
		}

		// print bytes (at minumum 1, because otherwise this will freeze)
		uint64_t addr = linesData[line + i].address;
		uint64_t endAddr = linesData[line + i + 1].address;

		// print line addresses and listings line
		setBody();
		setCursor(1, OBJ_LINE + i);
		printf("%016" PRIX64 " ", addr);

		setCursor(1, LIST_LINE + i);
		printf("%016" PRIX64 "  ", addr);
		clearRestOfLine();
		printf("%.*s", UI_W - 17, linesData[line + i].list->text);

		setCursor(1, BASE_LINE + i);
		printf("%016" PRIX64 " ", addr + shift);

		// reset variables
		baseBuf = baseByteBuf;
		objBuf = objByteBuf;

		for (int byte = 0; addr < endAddr; byte++, addr++) {
			int16_t baseb = getByte(&baseHelper, 1);
			int16_t objb = getByte(&objectHelper, 1);

			// fetch color
			char* color = getByteColor(baseb == objb);

			if (baseb < 0) {
				baseBuf += sprintf(baseBuf, "%s%s--", byte == 8 ? "  " : " ", color);

			} else {
				baseBuf += sprintf(baseBuf, "%s%s%02X", byte == 8 ? "  " : " ", color, (uint8_t)baseb);
			}

			if (objb < 0) {
				objBuf += sprintf(objBuf, "%s%s--", byte == 8 ? "  " : " ", color);

			} else {
				objBuf += sprintf(objBuf, "%s%s%02X", byte == 8 ? "  " : " ", color, (uint8_t)objb);
			}
		}

		// print the line details
		*baseBuf = 0;
		setCursor(19, BASE_LINE + i);
		puts(baseByteBuf);
		clearRestOfLine();

		*objBuf = 0;
		setCursor(19, OBJ_LINE + i);
		puts(objByteBuf);
		clearRestOfLine();
	}

	setCursor(1, UI_H + 1);
}

#pragma endregion
#pragma region Helper functions

// helper function to find the previous difference from address. returns 0 if none found
uint32_t findLineWithPrevDiff(uint32_t line) {
	int reads = BUFFER_LEN;

	objectHelper.cur = objectHelper.buffer + BUFFER_LEN;
	baseHelper.cur = baseHelper.buffer + BUFFER_LEN;
	objectHelper.end = baseHelper.end = NULL;

	// loop for the entire address space
	for (; line > 0; line--) {
		uint64_t address = linesData[line - 1].address;
		int64_t bytes = linesData[line].address - address;

		// fill the buffers
		if (++reads + bytes >= BUFFER_LEN) {
			loadBuffer(&baseHelper, address + uiShift);
			loadBuffer(&objectHelper, address);
		}

		// compare all bytes of line
		for (int64_t i = 0; i < bytes; i++) {
			if (getByte(&baseHelper, 1) != getByte(&objectHelper, 1)) {
				return (uint32_t)MAX(0, (int32_t)(line - LINES_PER_TYPE));
			}
		}
	}

	return 0;
}

// helper function to find the next difference from address. returns address of the last line if none found
uint32_t findLineWithNextDiff(uint64_t line) {
	int reads = BUFFER_LEN;
	line += LINES_PER_TYPE;

	objectHelper.cur = objectHelper.buffer + BUFFER_LEN;
	baseHelper.cur = baseHelper.buffer + BUFFER_LEN;
	objectHelper.end = baseHelper.end = NULL;

	// loop for the entire address space
	for (; line < linesUsed - 2; line++) {
		uint64_t address = linesData[line].address;
		int64_t bytes = linesData[line + 1].address - address;

		// fill the buffers
		if (++reads + bytes >= BUFFER_LEN) {
			loadBuffer(&baseHelper, address + uiShift);
			loadBuffer(&objectHelper, address);
		}

		// compare all bytes of line
		for (int64_t i = 0; i < bytes; i++) {
			if (getByte(&baseHelper, 1) != getByte(&objectHelper, 1)) {
				return line;
			}
		}
	}

	// find the address of the last line
	return linesUsed - 2;
}

#pragma endregion
#pragma region Goto& Find handlers

// print text lines
void renderTextField(char* mode) {
	setTitlebar();
	setCursor(1, ISNTR_LINE);
	puts(mode);
	clearRestOfLine();

	setCursor(1, ISNTR_LINE + 1);
	clearRestOfLine();
}

// go to handler
uint32_t handleGoto() {
	renderTextField("go to address (hex):");
	setTextInput(1);

	// scan for the address
	uint32_t line = curLine;
	uint64_t address = 0;
	int res = scanf("%" PRIx64, &address);

	if (res != EOF && res != 0) {
		line = 0;

		// scan the requested address
		for (int p = linesUsed - 3; p > 0; --p) {
			if (linesData[p].address <= address) {
				// we crossed the position boundary, return the next line
				line = p;
				break;
			}
		}
	}

	// fix the display and return
	setTextInput(0);
	clearInput(res);
	renderInstructions();
	return line;
}

#pragma endregion
#pragma region Input handling

#define KEY_OTHER 0
#define KEY_QUIT 1
#define KEY_FIND 2
#define KEY_GOTO 3
#define KEY_NEXT_DIFF 8
#define KEY_PREV_DIFF 9
#define KEY_NEXT_FIND 0xA
#define KEY_PREV_FIND 0xB
#define KEY_LINE_UP 0x10
#define KEY_LINE_DOWN 0x11
#define KEY_SHIFT_UP 0x12
#define KEY_SHIFT_DOWN 0x13
#define KEY_SHIFT_RESET 0x14

// function to convert input mapping to a specific input ID
int getInput() {
#if defined(WIN)
	switch (_getch()) {
		case 0x1B:
		case 0x03:
			return KEY_QUIT;
		case 0x08:
			return KEY_PREV_DIFF;
		case 0x0D:
			return KEY_NEXT_DIFF;
		case 'R':
		case 'r':
			return KEY_SHIFT_RESET;
		case 'F':
		case 'f':
			return KEY_FIND;
		case 'G':
		case 'g':
			return KEY_GOTO;

		case 0xE0: { // control codes
			switch (_getch()) {
				case 0x48:
					return KEY_LINE_UP;
				case 0x50:
					return KEY_LINE_DOWN;
				case 0x4B:
					return KEY_SHIFT_UP;
				case 0x4D:
					return KEY_SHIFT_DOWN;
			}
			break;
		} break;

		case 0x0: { // control codes?
			switch (_getch()) {
				case 0x3C:
					return KEY_PREV_FIND;
				case 0x3D:
					return KEY_NEXT_FIND;
			}
			break;
		}
	}
	return KEY_OTHER;
#endif

#if defined(LINUX) || defined(MACOS)
	switch (getchar()) {
		case 0x7F:
			return KEY_PREV_DIFF;
		case 0x0A:
			return KEY_NEXT_DIFF;

		case 'R':
		case 'r':
			return KEY_SHIFT_RESET;
		case 'F':
		case 'f':
			return KEY_FIND;
		case 'G':
		case 'g':
			return KEY_GOTO;

		case 0x1B: { // escape sequence
			switch (getchar()) {
				case 0x5B: { // ??
					switch (getchar()) {
						case 0x41:
							return KEY_LINE_UP;
						case 0x42:
							return KEY_LINE_DOWN;
						case 0x43:
							return KEY_SHIFT_UP;
						case 0x44:
							return KEY_SHIFT_DOWN;
					}

					break;
				}

				case 0x4F: { // ??
					switch (getchar()) {
						case 0x51:
							return KEY_PREV_FIND;
						case 0x52:
							return KEY_NEXT_FIND;
					}

					break;
				}
			}
			break;
		}
	}
#endif
}

// main function for handling input
uint8_t HandleInput() {
	switch (getInput()) {
		case KEY_QUIT:
			return 0;
		case KEY_SHIFT_UP:
			uiShift--;
			break;

		case KEY_SHIFT_DOWN:
			uiShift++;
			break;

		case KEY_SHIFT_RESET:
			uiShift = 0;
			break;

		case KEY_LINE_UP: {
			if (curLine > 0) {
				curLine--;
			}
			break;
		}

		case KEY_LINE_DOWN: {
			if (curLine < linesUsed - 2) {
				curLine++;
			}
			break;
		}

		case KEY_PREV_DIFF:
			curLine = findLineWithPrevDiff(curLine);
			break;

		case KEY_NEXT_DIFF:
			curLine = findLineWithNextDiff(curLine);
			break;

		case KEY_GOTO:
			curLine = handleGoto();
			break;
	}

	return 1;
}

#pragma endregion
#pragma region Init line data

// function to reallocate line buffer
void checkLinesFit() {
	// check if the listingLines array can fit this
	if (linesAlloc <= linesUsed) {
		linesAlloc <<= 1;
		linesData = realloc(linesData, linesAlloc * sizeof(ListingsLine));

		if (linesData == NULL) {
			printf("malloc failed!\n");
			exit(1);
		}
	}
}

// function to split all listings lines into
void initUiListings() {
	// pre-allocate some space
	linesAlloc = 0x100;
	linesUsed = 0;
	linesData = malloc(linesAlloc * sizeof(ListingsLine));

	// loop for every line
	for (uint32_t i = 0; i < listingsUsed - 1; i++) {
		uint64_t endAddr = listingsLines[i + 1].address;
		uint64_t startAddr = listingsLines[i].address;

		// fix endaddr = UINT64_MAX
		if (endAddr == UINT64_MAX) {
			endAddr = MAXADDR();
		}

		// make sure there are more than 0 bytes in here
		if (endAddr == startAddr) {
			continue;
		}

		// loop for every byte in the line
		for (uint64_t a = startAddr; a < endAddr; a += BYTES_PER_LINE) {
			checkLinesFit();

			// add a new entry here
			linesData[linesUsed].address = a;
			linesData[linesUsed].list = &listingsLines[i];
			linesUsed++;
		}
	}

	// add a new entry here
	checkLinesFit();
	linesData[linesUsed].address = MAXADDR();
	linesData[linesUsed].list = &listingsLines[listingsUsed - 1];
	linesUsed++;
}

#pragma endregion

// main function for running ui mode
void runUiMode() {
	initUiListings();
	initUiMode();

	while (1) {
		renderUiMode(curLine, uiShift);

		if (HandleInput() == 0) {
			break;
		}
	}

	setCursorOn();
	setBody();
}
