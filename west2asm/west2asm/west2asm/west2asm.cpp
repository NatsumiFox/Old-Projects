#include "stdafx.h"
#include "west2asm.h"

struct Line {
	char data[100];
	UINT16 addr;
	UINT16 size;
};

struct Lable {
	char name[50];
	UINT16 addr;
};

Line *lines;
Lable *lables;
int lnoff, laoff;

char* AddLine(UINT16 off, UINT16 size) {
	if ((lnoff & 0x1FF) == 0x1FF) {
		Line *l = (Line *)realloc(lines, (lnoff + 0x201) * sizeof(Line));

		if (l == NULL) {
			printf("Memory allocation failed! Can not continue.\n");
			getchar();
			return 0;
		}

		lines = l;
	}

	lines[lnoff].addr = off;
	lines[lnoff].size = size;
	return (char*)lines[lnoff++].data;
}

char* AddLable(UINT16 off) {
	if ((laoff & 0x1FF) == 0x1FF) {
		Lable *l = (Lable *)realloc(lables, (laoff + 0x201) * sizeof(Lable));

		if (l == NULL) {
			printf("Memory allocation failed! Can not continue.\n");
			getchar();
			return 0;
		}

		lables = l;
	}

	lables[laoff].addr = off;
	return (char*)lables[laoff++].name;
}

UINT16 dw(char *data, int off) {
	return (UINT16)((data[off] & 0xFF) | ((data[off + 1] << 8) & 0xFF00));
}

char* NoteStr[12] = {
	"C\0", "Cs\0", "D\0", "Eb\0", "E\0", "F\0", "Fs\0", "G\0", "Ab\0", "A\0", "Bb\0", "B\0",
};

int proctracker(char *data, int off, int mus, int slot, int base) {
	int i = base;
	int start = off;

	if (off < 0x1B00) {
		getchar();
	}

	while (TRUE) {
		int d = data[off++] & 0xFF;

		if (d < 0xc0) {
			char* b = AddLine(off - 1, 1);
			sprintf(b, "db %c%s%d\0", d < 0x60 ? 'n' : 't', NoteStr[d % 0xC], d / 0xC);

		} else if ((d < 0xD0) || ((d >= 0xE6) && (d < 0xF0))) {
			char* b = AddLine(off - 1, 1);
			sprintf(b, "db $%02X\0", d);

		} else if (d < 0xD8) {
			UINT16 labl = dw(data, off) & 0x7FFF;

			char* b = AddLine(off - 1, 3);
			sprintf(b, "\t\twLoopGo\t\t$%02X, .%02X_%02X_%02X", d & 0x7, mus, slot, i);

			b = AddLable(labl);
			sprintf(b, ".%02X_%02X_%02X", mus, slot, i++);

			if (labl < start || labl > off) i = proctracker(data, labl, mus, slot, i);
			off += 2;

		} else if(d < 0xE0) {
			char* b = AddLine(off - 1, 2);
			sprintf(b, "\t\twLoopBackInit\t$%02X", d & 0x7);

		} else {
			switch (d){
				case 0xE0: {
					char* b = AddLine(off - 1, 2);
					sprintf(b, "\t\twModOn\t\t$%02X", data[off++] & 0xFF);
				}
					break;

				case 0xE1: {
					char* b = AddLine(off - 1, 1);
					sprintf(b, "\t\twModOff");
				}
					break;

				case 0xE2: {
					char* b = AddLine(off - 1, 2);
					sprintf(b, "\t\twSetTimerB\t$%02X", data[off++] & 0xFF);
				}
					break;

				case 0xE3: {
					char* b = AddLine(off - 1, 3);
					sprintf(b, "\t\twSetTimerW\t$%04X", dw(data, off));
					off += 2;
				}
					break;

				case 0xE4: {
					char* b = AddLine(off - 1, 2);
					sprintf(b, "\t\twTempo\t\t$%02X", data[off++] & 0xFF);
				}
					break;

				case 0xE5: {
					char* b = AddLine(off - 1, 2);
					sprintf(b, "\t\twPlaySound\t$%02X", data[off++] & 0xFF);
				}
					break;

				case 0xF0: {
					char* b = AddLine(off - 1, 2);
					sprintf(b, "\t\twSetPat\t\t$%02X", data[off++] & 0xFF);
				}
					break;

				case 0xF1: {
					char* b = AddLine(off - 1, 2);
					sprintf(b, "\t\twTempoDiv\t$%02X", data[off++] & 0xFF);
				}
					break;

				case 0xF2: {
					char* b = AddLine(off - 1, 3);
					sprintf(b, "\t\twSetFreq\t$%04X", dw(data, off));
					off += 2;
				}
					break;

				case 0xF3: {
					char* b = AddLine(off - 1, 3);
					sprintf(b, "\t\twAddFreq\t$%04X", dw(data, off));
					off += 2;
				}
					break;

				case 0xF4: {
					char* b = AddLine(off - 1, 2);
					sprintf(b, "\t\twSetVol\t\t$%02X", data[off++] & 0xFF);
				}
					break;

				case 0xF5: {
					char* b = AddLine(off - 1, 2);
					sprintf(b, "\t\twAddVol\t\t$%02X", data[off++] & 0xFF);
				}
					break;

				case 0xF6: {
					char* b = AddLine(off - 1, 2);
					sprintf(b, "\t\twSetType\t$%02X", data[off++] & 0xFF);
				}
					break;

				case 0xF7: {
					char* b = AddLine(off - 1, 2);
					sprintf(b, "\t\twSetMask\t$%02X", data[off++] & 0xFF);
				}
					break;

				case 0xF8: {
					char* b = AddLine(off - 1, 1);
					sprintf(b, "\t\twDrumChannel");
				}
					break;

				case 0xF9: {
					char* b = AddLine(off - 1, 2);
					sprintf(b, "\t\twPan\t\t$%02X", data[off++] & 0xFF);
				}
					break;

				case 0xFA: {
					char* b = AddLine(off - 1, 1);
					sprintf(b, "\t\twStopRead");
					break;
				}

				case 0xFB: {
					char* b = AddLine(off - 1, 1);
					sprintf(b, "\t\twStopHw");
				}
					break;

				case 0xFC: {
					char* b = AddLine(off - 1, 1);
					sprintf(b, "\t\twFC");
				}
					break;

				case 0xFD: {
					UINT16 labl = dw(data, off) & 0x7FFF;

					char* b = AddLine(off - 1, 3);
					sprintf(b, "\t\twJump\t\t.%02X_%02X_%02X", mus, slot, i);

					b = AddLable(labl);
					sprintf(b, ".%02X_%02X_%02X", mus, slot, i++);

					if (labl < start || labl > off) i = proctracker(data, labl, mus, slot, i);
				}
					return i;

				case 0xFE: {
					char* b = AddLine(off - 1, 1);
					sprintf(b, "\t\twLoopBack");
				}
					break;

				case 0xFF: {
					char* b = AddLine(off - 1, 1);
					sprintf(b, "\t\twLoopGoEnd");

				}
					return i;

				default:
					break;
			}
		}
	}
}

void procheader(char *data, int off, int mus) {
	if (data[off] < 0) {
		//music
		char* b = AddLine(off, 3);
		sprintf(b, "\t\twHeaderMus\t$%02X, $%04X", data[off++] & 0xFF, dw(data, off));
		off += 2;

		int i = 0;
		while (TRUE) {
			UINT16 labl = dw(data, off) & 0x7FFF;
			if (labl == 0) {
				char* b = AddLine(off, 2);
				sprintf(b, "\t\tdw\t$0000", mus, i);
				break;
			}

			char* b = AddLine(off, 2);
			sprintf(b, "\t\tdw\t.%02X_%02X", mus, i);

			b = AddLable(labl);
			sprintf(b, ".%02X_%02X", mus, i);

			proctracker(data, labl, mus, i, 0);
			off += 2;
			i++;
		}

	} else {
		// SFX
		char* b = AddLine(off, 3);
		sprintf(b, "\t\twHeaderSFX\t$%02X", data[off++] & 0xFF);

		int i = 0;
		while (TRUE) {
			int ch = data[off++] & 0xFF;
			if (ch == 0xFF) {
				char* b = AddLine(off - 1, 1);
				sprintf(b, "\t\tdc.b\t$FF", mus, i);
				break;
			}
			UINT16 labl = dw(data, off) & 0x7FFF;

			char* b = AddLine(off - 1, 3);
			sprintf(b, "\t\twChSFX\t$%02X, .%02X_%02X", ch, mus, i);

			b = AddLable(labl);
			sprintf(b, ".%02X_%02X", mus, i);

			proctracker(data, labl, mus, i, 0);
			off += 2;
			i++;
		}
	}
}

int sortLines(const void *s1, const void *s2){
	return ((Line *)s1)->addr - ((Line *)s2)->addr;
}

int sortLables(const void *s1, const void *s2) {
	return ((Lable *)s1)->addr - ((Lable *)s2)->addr;
}

int main(int argc, char **argv){
	FILE *in = fopen(argv[1], "rb");
	if (in == NULL) {
		printf("File does not exist\n");
		getchar();
		return 0;
	}

	fseek(in, 0, SEEK_END);
	int len = ftell(in);
	rewind(in);
	char *data = (char *)malloc((0x8000) * sizeof(char));

	if (data == NULL) {
		printf("Memory allocation failed! Can not continue.\n");
		getchar();
		return 0;
	}

	if (len > 0x8000 && argc < 4) {
		printf("The size of input file is greater than 0x8000, but offset into input file was not provided!\n");
		getchar();
		return 0;
	}

	int off = (len > 0x8000) ? strtol(argv[3], (char **)NULL, 0) : 0;

	if ((off & 0x7FFF) != 0) {
		printf("The offset into the file is not properly aligned!\n");
		getchar();
		return 0;
	}

	if ((off + 0x7FFF) > len) {
		printf("Offset is out of range!\n");
		getchar();
		return 0;
	}

	fseek(in, off, SEEK_SET);
	fread(data, 0x8000, 1, in);
	fclose(in);

	lines = (Line *)malloc((0x200) * sizeof(Line));
	lables = (Lable *)malloc((0x200) * sizeof(Lable));
	lnoff = 0;
	laoff = 0;

	if (lines == NULL || lables == NULL) {
		printf("Memory allocation failed! Can not continue.\n");
		getchar();
		return 0;
	}

	off = strtol(argv[2], (char **)NULL, 0) & 0x7FFF;
	int ct = data[off++];

	for (int i = 0; i < ct; i++) {
		UINT16 labl = dw(data, off) & 0x7FFF;
		char* b = AddLine(off, 2);
		sprintf(b, "\t\tdw\t.%02X", i);

		b = AddLable(labl);
		sprintf(b, ".%02X", i);

		procheader(data, labl, i);
		off += 2;
	}

	qsort(lines, lnoff, sizeof(Line), sortLines);
	qsort(lables, laoff, sizeof(Lable), sortLables);

	char* path = (char *)malloc((0x400) * sizeof(char));

	if (path == NULL) {
		printf("Memory allocation failed! Can not continue.\n");
		getchar();
		return 0;
	}

	char* dot = strrchr(argv[1], '.');

	if (dot == NULL) {
		dot = strrchr(argv[1], 0);

		if (dot == NULL) {
			printf("Err, this error should not be possible to occur. Please help me!\n");
		}
	}

	memcpy(path, argv[1], dot - argv[1]);
	char* ext = path + (dot - argv[1]);
	ext[0] = '.';
	ext[1] = 'a';
	ext[2] = 's';
	ext[3] = 'm';
	ext[4] = 0;

	printf("%s", path);

	FILE *out = fopen(path, "wb");
	if (out == NULL) {
		printf("Could not open output file!\n");
		getchar();
		return 0;
	}

	int lablo = 0, lno = 0;
	char* bytebuf[8];
	char linebytebuffer[200];
	char newline[] = "\n";
	UINT16 currLineArg = 0, nxtchk = 0;
	bool waslabl = false;

	for (UINT16 i = (dw(data, dw(data, 6)) & 0x7FFF); i < 0x8000; i++) {
	chklable:
		if (lablo < laoff) {
			if (lables[lablo].addr == i) {
				if (currLineArg > 0) {
					waslabl = false;
					int chc = sprintf(linebytebuffer, "\t\tdc.b %s", bytebuf[0]);
					for (int a = 1; a < currLineArg; a++) {
						chc = sprintf(linebytebuffer, "%s, %s", linebytebuffer, bytebuf[a]);
					}

					fwrite(linebytebuffer, sizeof(char), chc, out);
					fwrite(newline, sizeof(char), 1, out);
					currLineArg = 0;
				}

				if(!waslabl) fwrite(newline, sizeof(char), 1, out);
				fwrite(lables[lablo].name, sizeof(char), (size_t)((strchr(lables[lablo].name, 0) - lables[lablo].name) / sizeof(char)), out);
				fwrite(newline, sizeof(char), 1, out);
				waslabl = true;

				lablo++;
				goto chklable;

			} else if (lables[lablo].addr < i) {
				lablo++;
				goto chklable;
			}
		}

		Line *fnline = NULL;

	chknext:
		if (lno < lnoff) {
			if (lines[lno].addr == i) {
				if (fnline == NULL) {
					fnline = &lines[lno];

				} else if (strcmp(fnline->data, lines[lno].data) != 0) {
					printf("Warning: Conflicting lines at %04X! '%s' vs '%s'! Ignoring the latter line.\n", i, fnline->data, lines[lno].data);
				}

				lno++;
				goto chknext;

			} else if (lines[lno].addr < i) {
				lno++;
				goto chknext;
			}
		}

		if (fnline != NULL) {
			waslabl = false;
			nxtchk = fnline->size + fnline->addr;

			if (strncmp(fnline->data, "db ", 3) == 0) {
				if (currLineArg >= 8) {
					int chc = sprintf(linebytebuffer, "\t\tdc.b %s, %s, %s, %s, %s, %s, %s, %s", bytebuf[0], bytebuf[1], bytebuf[2], bytebuf[3], bytebuf[4], bytebuf[5], bytebuf[6], bytebuf[7]);
					fwrite(linebytebuffer, sizeof(char), chc, out);
					fwrite(newline, sizeof(char), 1, out);
					currLineArg = 0;
				}

				bytebuf[currLineArg++] = (fnline->data) + 3;

			} else {
				if (currLineArg > 0) {
					int chc = sprintf(linebytebuffer, "\t\tdc.b %s", bytebuf[0]);
					for (int a = 1; a < currLineArg; a++) {
						chc = sprintf(linebytebuffer, "%s, %s", linebytebuffer, bytebuf[a]);
					}

					fwrite(linebytebuffer, sizeof(char), chc, out);
					fwrite(newline, sizeof(char), 1, out);
					currLineArg = 0;
				}

				fwrite(fnline->data, sizeof(char), (size_t)((strchr(fnline->data, 0) - fnline->data) / sizeof(char)), out);
				fwrite(newline, sizeof(char), 1, out);
			}
		} else if (i >= nxtchk) {
			if (currLineArg >= 8) {
				int chc = sprintf(linebytebuffer, "\t; Unused\n\t\tdc.b $%02X, $%02X, $%02X, $%02X, $%02X, $%02X, $%02X, $%02X", 
					(*bytebuf[0]) & 0xFF, (*bytebuf[1]) & 0xFF, (*bytebuf[2]) & 0xFF, (*bytebuf[3]) & 0xFF, (*bytebuf[4]) & 0xFF, (*bytebuf[5]) & 0xFF, (*bytebuf[6]) & 0xFF, (*bytebuf[7]) & 0xFF);
				fwrite(linebytebuffer, sizeof(char), chc, out);
				fwrite(newline, sizeof(char), 1, out);
				currLineArg = 0;
			}

			bytebuf[currLineArg++] = data + i;
		}
	}

	if (currLineArg > 0) {
		int chc = sprintf(linebytebuffer, "\t\tdc.b %s", bytebuf[0]);
		for (int a = 1; a < currLineArg; a++) {
			chc = sprintf(linebytebuffer, "%s, %s", linebytebuffer, bytebuf[a]);
		}

		fwrite(linebytebuffer, sizeof(char), chc, out);
		fwrite(newline, sizeof(char), 1, out);
	}

	fclose(out);
	free(path);
	free(data);
	free(lines);
	free(lables);

	getchar();
	return 0;
}

