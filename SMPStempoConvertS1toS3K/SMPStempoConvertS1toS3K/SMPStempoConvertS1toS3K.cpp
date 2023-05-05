// SMPStempoConvertS1toS3K.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#define COPY(off)\
	out[off] = dat[off];\
	if(off >= len) c(off);

#define COMM(num,args)\
	case num:\
		off = flag(off, args);\
		break;

#define COMMR(num,args)\
	case num:\
		off = flag(off, args);\
		return;

static char *dat;
static char *out;
static long len;

/* stolen from Flamewing */
int convert(int n) {
	n = ((n == 0) << 8) | n;
	n = ((((n - 1) << 8) + (n >> 1)) / n) & 0xFF;
	return (0x100 - ((n == 0) | n)) & 0xFF;
}

void c(int off) {
	printf("OOPS: %d %X %d %X", off, off, len, len);
	getchar();

	if (dat != NULL) {
		free(dat);
	}

	if (out != NULL) {
		free(out);
	}

	exit(0);	// exit now as we have no way of recovering from this!
}

int el(int off) {
	return (int)(short)off;
}

int wi(int off) {
	return ((dat[off] & 0xFF) << 8) | (dat[off + 1] & 0xFF);
}

int flag(int off, int num) {
	COPY(off);
	off++;

	while (num-- > 0) {
		COPY(off);
		off++;
	}

	return off;
}

void channel(int off, int from) {
	while (off < len) {
		if (off == 0xCA || off == 0x30) {
			int a = 0;
		}

		if (off == from) return;
		if ((byte)dat[off] < 0xE0) {
			COPY(off);
			off++;

		} else {
			switch ((byte)dat[off]) {
				COMM(0xE0, 1);	// pan
				COMM(0xE1, 1);	// detune
				COMM(0xE2, 1);	// comm
				COMMR(0xE3, 0);	// return
				COMMR(0xE4, 0);	// fade
				COMM(0xE5, 1);	// tick mul ch
				COMM(0xE6, 1);	// fm vol
				COMM(0xE7, 0);	// hold
				COMM(0xE8, 1);	// note timeout
				COMM(0xE9, 1);	// transpose

				case 0xEA:	// tempo
					off = flag(off, 0);
					if (out[off] == 0) {
						out[off] = convert(dat[off]);
					}
					off++;
					break;

					COMM(0xEB, 1);	// tick mul
					COMM(0xEC, 1);	// PSG vol
					COMM(0xED, 0);	// clear push
					COMMR(0xEE, 0);	// stop special FM4
					COMM(0xEF, 1);	// FM voice
					COMM(0xF0, 4);	// 68k modulation
					COMM(0xF1, 0);	// modulation on
					COMMR(0xF2, 0);	// stop
					COMM(0xF3, 1);	// PSG noise
					COMM(0xF4, 0);	// modulation off
					COMM(0xF5, 1);	// PSG volume envelope

				case 0xF6:	// jump
					off = flag(off, 2);
					channel(el(wi(off - 2)) + off, off - 3);
					return;

				case 0xF7:	// loop
					off = flag(off, 4);
					channel(el(wi(off - 2)) + off, off - 5);
					break;

				case 0xF8:	// call
					off = flag(off, 2);
					channel(el(wi(off - 2)) + off, off - 3);
					break;

					COMMR(0xF9, 0);	// stop special FM4

			default:
				off = flag(off, 0);
				break;
			}
		}
	}
}

void smps() {
	COPY(0);		// offset
	COPY(1);
	COPY(2);		// FM ch
	COPY(3);		// PSG ch
	COPY(4);		// tick mul
	COPY(6);		// offset
	COPY(7);
	COPY(8);		// DAC
	COPY(9);

	printf("...Process DAC at 0x%X\n", wi(6));
	out[5] = convert(dat[5]);
	int fm = dat[2], psg = dat[3];

	channel(wi(6), 0);
	int off = 10;
	int ch = 0;
	while (fm-- > 1) {
		ch++;
		printf("...Process FM%d at 0x%X\n", ch, wi(off));
		channel(wi(off), 0);
		COPY(off);
		COPY(off + 1);
		COPY(off + 2);
		COPY(off + 3);
		off += 4;
	}

	ch = 0;
	while (psg-- > 0) {
		ch++;
		printf("...Process PSG%d at 0x%X\n", ch, wi(off));
		channel(wi(off), 0);
		COPY(off);
		COPY(off + 1);
		COPY(off + 2);
		COPY(off + 3);
		COPY(off + 4);
		COPY(off + 5);
		off += 6;
	}

	// fill in all unexplored bytes (hopefully only the voices section!)
	printf("...Copy\n");
	for (; off < len; off++) {
		if (out[off] == 0) {
			COPY(off);
		}
	}
}

int main(int argc, char **argv) {
	if (argc < 2) {
		printf("Drag & Drop files into the executable to convert them!\n\n");
	}

	while (--argc > 0) {
		printf("Process file %s\n", argv[argc]);

		char *i;
		if ((i = strstr(argv[argc], ".bin")) != NULL) {
			argv[argc][i - argv[argc]] = '\0';

			FILE *fp = fopen(strcat(argv[argc], ".bin"), "rb");
			if (fp == NULL) {
				printf("File does not exist!\n");

			} else {
				fseek(fp, 0, SEEK_END);
				len = ftell(fp);
				rewind(fp);

				dat = (char *)malloc((len) * sizeof(char));
				out = (char *)malloc((len) * sizeof(char));
				memset(out, 0, (len) * sizeof(char));
				if (dat == NULL || out == NULL) {
					printf("Memory allocation failed! Can not continue.\n");
					getchar();
					return 0;
				}

				fread(dat, len, 1, fp);
				fclose(fp);
				smps();

				argv[argc][strstr(argv[argc], ".bin") - argv[argc]] = '\0';
				printf("...Write file to %s\n", strcat(argv[argc], ".smp"));
				fp = fopen(argv[argc], "wb");
				fwrite(out, 1, len, fp);
				fclose(fp);

				free(dat);
				free(out);
				dat = NULL;
			}

		} else {
			printf("File not converted. Must be .bin file!\n");
		}
	}

	printf("All done in %dms! Press any key to continue...");
	getchar();
	return 0;
}

