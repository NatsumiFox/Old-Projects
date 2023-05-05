const char HelpMessage[] = 
"Hash Generator Tool for re-asm68k\n"
"By std282\n"
"\n"
"Usage: \n"
"  hashgen [options] <inputFile> <outputHeaderFile> <outputSourceFile>\n"
"\n"
"The program reads all the identifiers from <inputFile>, computes hash for\n"
"every line, formats the hash data for every identifier and puts the data\n"
"in <outputHeaderFile> and <outputSourceFile>.\n"
"\n"
"<inputFile> should have 1 identifier per line, no spaces before or after\n"
"the identifier. The identifier must start with an English letter or \n"
"underscore. The identifier can contain English letters, underscore and\n"
"decimal digits. Empty line designates the end of identifier list. Everything\n"
"after the empty line is ignored.\n"
"\n"
"Options:\n"
"  --help           Show this help message and exit.\n"
"  --cases <cases>  Defines the letter case sensitivity for hash\n"
"                   generation. <cases> parameter can be one of the\n"
"                   following:\n"
"                       as-is (default)\n"
"                           Leaves letter cases as they are.\n"
"                       upper-lower\n"
"                           Generates two hashes for each identifier:\n"
"                           all-upper and all-lower.\n"
"  --ctype <ctype>  Sets the character type. <ctype> can be one of the\n"
"                   following:\n"
"                       char (default)\n"
"                           Default character type.\n"
"                       uint8_t\n"
"                           For compatibility with uint8_t* strings in\n"
"                           re-asm68k.\n"
"\n"
;

const char UsageMessage[] = 
"Usage: \n"
"  hashgen [options] <inputFile> <outputHeaderFile> <outputSourceFile>\n"
"\n"
"Execute 'hashgen --help' for details.\n"
;

const char HeaderPreamble[] = 
"// This file was generated automatically. Please do not edit it.\n"
"\n"
"#if !defined(_HASH_HEADER)\n"
"#define _HASH_HEADER\n"
"\n"
;

const char HeaderFooter[] = 
"#endif  // _HASH_HEADER\n"
;

const char SourcePreamble[] = 
"// This file was generated automatically. Please do not edit it.\n"
"\n"
;

const char SourceFooter[] =
""
;
