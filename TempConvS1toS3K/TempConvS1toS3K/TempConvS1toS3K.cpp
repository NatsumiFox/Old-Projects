#include "stdafx.h"

void flush() {
	fflush(stdin);
	int ch;
	while (((ch = getchar()) != '\n') && (ch != EOF));
}

/* stolen from Flamewing */
int convert(int n) {
	n = ((n == 0) << 8) | n;
	n = ((((n - 1) << 8) + (n >> 1)) / n) & 0xFF;
	return (0x100 - ((n == 0) | n)) & 0xFF;
}

int main() {
	start:
	printf("Give me hexadecimal tempo value!  ");
	int tempo;
	int res = scanf("%x", &tempo);
	flush();

	if (res == EOF) {
		printf("ERROR: EOF!\n");
		goto start;

	} else if (res == 0) {
		printf("ERROR: Not match!\n");
		goto start;
	}

	if (tempo < 0 || tempo >= 0x100) {
		printf("ERROR: Invalid tempo!\n");
		goto start;
	}

	printf("converted tempo is:               %X\n", convert(tempo));
	goto start;
}
