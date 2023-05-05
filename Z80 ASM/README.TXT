There are a few things to keep in mind when using the Z80 core. Here they are listed;

* In the source you are trying to assemble with the Z80 core, you need "org 0" before ANY code is placed; Else you will get errors prohibitng the assembly process from completing. This is done to instruct the assembler that the vector table is where the ROM starts at. If instead you wish to assemble Z80 code separately, this org needs just be placed as the first line of the assembly

* If you get an error stating "Attempt to seek before start of file", you have placed the org incorrectly or forgot to place it at all.

* Your source where you assemble Z80 code, must contain NO sections. This unfortunately limits you from assembling Z80 code into another file as you assemble 68k code, but I can not work around this limitation.

* All Z80 code is adviced to be placed between "z80prog <code_offset>" and another "z80prog". These will set certain flags to properly assemble code and perform self-checks to fix code with any signed offsets. The first one will contain the offset of the code you are assembling. It is commonly 0, but can be set to for example $8000 for use with Z80 banks. This allows you to assemble Z80 pointers without oring $8000 manually (as is done commonly with SMPS2ASM to this point!)

* All instructions that conflict with ASM68K directives or 68000 instructions must be prepended with 'z', as shown by GEMS source code. All the affected instructions are: nop, add, sub, set, or, and neg. As ASM68K does not allow redefining system macros or opcodes, there is no workaround

* All instances of "ex	af,af'" must be changed to "ex	af,af". ASM68K has difficulty understanding that ' at the end, and I do not know a solution to this.

* All IX and IY offsets must use + or - and provide a valid offset. therefore, "bit 0,(IX)" must be turned into "bit 0,(IX+0)"

* You may not use $ as the character for PC. You should use * instead.

* RST instructions that forward reference a label may not be validated. Make sure from listings file that these instructions are assembled correctly. Backward references are properly validated.

* Avoid putting any of the instructions (including db and all variants thereof) right after a label name. For ex "Table:db 1" may assemble incorrectly! This seems to be ASM68K bug, not quite sure what causes it.

* You may omit the tab from conditional jump instructions (jp, jr and call). For example, you can turn "jp nz,100h" into "jpnz 100h". This is more a convinience than anything and it is much faster to process as the macro does not need to do error checking nor resolving the condition separately.

* When using an address instead of immediate, the address statement must start with ( and end with ). So, this would not be valid: "ld (100H)+1,a". You may enclose more complex statements inside of the outer parenthesis', as deep as ASM68K will allow you to.

* If you get an error with a relative jump or offset that indicates a value that is not correct, you may ignore it; The core uses a complex trick to pull off detecting signed values correctly. ASM68K does not provide this functionality, so we have trick it to. This means, sometimes you get errors for values that are higher than $7F, that appear to actually be negative. You can turn this check off, but it will also disable checking the offset for jr and djnz.

* Enabling expanded macro logging inside Z80 code is a REALLY bad idea. Except if you want megabytes of listings files of course.

* Use undocumented instructions at your own risk.

* If you do not follow all these instructions properly, do not report issues with the core at me; You are on your own.
