#include <assembler/error.h>

#include <asmlink/debug_tracer.h>

#include <lib/files.h>
#include <lib/messages/global.h>

// function to open the trace file
#if defined(TRACER)

FILE* Tracer_FileHandle;
char* Tracer_FilePath;

void Tracer_OpenFile() {
	if (Tracer_FilePath) {
		Tracer_FileHandle = fopen(Tracer_FilePath, "w+b");

		// check if failed to make the file
		if (!Tracer_FileHandle) {
			Error_ErrorProgram(ERRFMT_FILE_NOT_FOUND, Tracer_FilePath);
		}

		fseek(Tracer_FileHandle, 0, SEEK_SET);

		// initialize trace header
		fputs("trace\tv0.0\n", Tracer_FileHandle);
	}
}

void Tracer_CloseFile() {
	if (Tracer_FileHandle) {
		// trace footer
		fputs("trace\tend", Tracer_FileHandle);

		// flush and close
		fclose(Tracer_FileHandle);
	}
}

uint8_t Tracer_FileActions[][6] = {
		"open",
		"close",
};

void Tracer_WriteFileMode(uint8_t action, uint8_t* file, uint8_t* type) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "file\t%s\t%s\t%s\n", Tracer_FileActions[action], type, Files_ExtractFileName(file));
	}
}

void Tracer_WriteLine(uint8_t* file, uint8_t* line) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "\nline\t%s\t%s\n", Files_ExtractFileName(file), line);
	}
}

void Tracer_WritePassNumber(int8_t num) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "\n\npass\t%d\n\n", num);
	}
}

uint8_t Tracer_SymbolActions[][7] = {
		"create",
		"delete",
		"fetch",
};

void Tracer_WriteSymbolTableAction(uint8_t action, uint8_t local) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "symbol\t%s\t%s\ttable\n", Tracer_SymbolActions[action], local ? "local" : "global");
	}
}

void Tracer_WriteSymbolAction(uint8_t action, uint8_t local, Symbol* symbol) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "symbol\t%s\t%s\tsymbol\t%s type::", Tracer_SymbolActions[action], local != 0 ? "local" : "global", symbol->name);

		uint8_t* flags[8];
		flags[7] = "initialized";
		flags[6] = "locked";
		flags[5] = "bit5";
		flags[4] = "bit4";
		flags[3] = "bit3";
		flags[2] = "bit2";
		flags[1] = "bit1";
		flags[0] = "bit0";

		// print symbol type as a string
		switch (symbol->type) {
			case Symbol_Type_Function:
				fputs("function/macro", Tracer_FileHandle);
				break;

			case Symbol_Type_Section:
				fputs("section", Tracer_FileHandle);
				break;

			case Symbol_Type_Integer_Equate:
				fputs("equate=number", Tracer_FileHandle);
				flags[0] = "local";
				break;

			case Symbol_Type_String_Equate:
				fputs("equate=string", Tracer_FileHandle);
				flags[0] = "local";
				break;

			case Symbol_Type_Function_Equate:
				fputs("equate=function", Tracer_FileHandle);
				flags[0] = "local";
				break;

			case Symbol_Type_Function_Register_68k:
				fputs("register=MC68000", Tracer_FileHandle);
				flags[0] = "reglist";
				break;

			case Symbol_Type_Function_Register_Z80:
				fputs("register=Z80", Tracer_FileHandle);
				flags[0] = "reglist";
				break;

			default:
				fprintf(Tracer_FileHandle, "unknown=0x%X", symbol->type);
				break;
		}

		// this stupid complicated piece of code just neatly lays out channel flags as:
		// flags=flag1,flag2,etc.
		if (symbol->flags != 0) {
			fputs(" flags", Tracer_FileHandle);
			uint8_t separator = '=';

			// print each flag by its bit
			for (int8_t bit = 7; bit >= 0; bit--) {
				if (symbol->flags & (1 << (uint8_t)bit)) {
					fprintf(Tracer_FileHandle, "%c%s", separator, flags[bit]);
					separator = ',';
				}
			}
		}

		fputs("\n", Tracer_FileHandle);
	}
}

void Tracer_WriteUnaryOperator(char* operation, uint64_t rvalue, uint64_t result) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "oper\t%s$%" PRIX64 " -> $%" PRIX64 "\n", operation, rvalue, result);
	}
}

void Tracer_WriteBinaryOperator(uint64_t lvalue, char* operation, uint64_t rvalue, uint64_t result) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "oper\t$%" PRIX64 " %s $%" PRIX64 " -> $%" PRIX64 "\n", lvalue, operation, rvalue, result);
	}
}

void Tracer_GetValueNumber(uint64_t number) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "eval\tvalue\tnumber\t$%" PRIX64 "\n", number);
	}
}

void Tracer_GetSymbolNumber(uint64_t number, uint8_t* name) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "eval\tsymbol\tnumber\t$%" PRIX64 "\t%s\n", number, name);
	}
}

void Tracer_GetValueStringToNumber(uint64_t number, EvaluateToken* token) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "eval\tvalue\tstring\t$%" PRIX64 "\t%s\n", number, token->string->string);
	}
}

void Tracer_GetSymbolStringToNumber(uint64_t number, Symbol* symbol) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "eval\tsymbol\tstring\t$%" PRIX64 "\t%s\t%s\n", number, symbol->name, symbol->string->string);
	}
}

void Tracer_WritePass2ValueEqu(uint8_t* name, uint64_t value) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "\npass2\tequ\tnumber\t%s\t%" PRIX64 "\n", name, value);
	}
}

void Tracer_WritePass2StringEqu(uint8_t* name, uint8_t* value) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "\npass2\tequ\tstring\t%s\t%s\n", name, value);
	}
}

void Tracer_WritePass2ReplaceBytes(ObjectReplacement* entry, uint64_t value) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "\npass2\tpatch\t$%X\t$%" PRIx64 " -> $%" PRIx64 "\n", entry->patch, value, entry->address);
	}
}

void Tracer_WriteFunctionSize(Symbol* func, uint8_t* text) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "func\tsize\t%s\t%s\n", func->name, text);
	}
}

void Tracer_WriteFunctionArgument(Symbol* func, uint8_t* text, uint64_t index) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "func\targ\t%" PRIu64 "\t%s\t%s\n", index, func->name, text);
	}
}

void Tracer_WriteAddressingModeM68k(AddrModeHelper* helper) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "m68k\tmode\t%04X\t%d:%d\t%08X\n", helper->id, helper->mode, helper->reg, helper->extendUint);
	}
}

void Tracer_WriteIncbin(uint64_t start, uint64_t length) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "incbin\trange\t$%" PRIX64 "\t$%" PRIX64 "\tlength $%" PRIX64 "\n", start, start + length, length);
	}
}

void Tracer_WriteRename(Symbol* old, Symbol* new) {
	if (Tracer_FileHandle) {
		fprintf(Tracer_FileHandle, "rename\t%s -> %s\n", old->name, new->name);
	}
}

#endif
