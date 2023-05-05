cmake_minimum_required(VERSION 3.18)

project(re-asm68k
	# Version number can be used to generate header file with version info
	VERSION 0.1.0
	LANGUAGES C
)
enable_testing()

# compiling options
option(USE_TRACER "Use debug tracer" OFF)

# requires at least C99-compatible compiler to compile the code
set(CMAKE_C_STANDARD 99)

include_directories(${CMAKE_SOURCE_DIR}/src)

# Add `DEBUG` macro definition if compiling under Debug or RelWithDebInfo
# configuration
add_compile_definitions(
	$<$<CONFIG:Debug,RelWithDebInfo>:DEBUG>
)

# Add `TRACER` macro definition if USE_TRACER is enabled
if(USE_TRACER)
	add_compile_definitions(asm PRIVATE
		$<$<CONFIG:Debug,RelWithDebInfo>:TRACER>
	)
endif()

# Common functions library
add_library(common STATIC
	"src/lib/arguments.c"
	"src/lib/error_lib.c"
	"src/lib/debug.c"
	"src/lib/files.c"
	"src/lib/lengthstring.c"
	"src/lib/string_lib.c"
	"src/lib/expressions.c"
)

# Assembler executable
add_executable(asm
	# assembler functions
	"src/assembler/args.c"
	"src/assembler/error.c"
	"src/assembler/hash.c"
	"src/assembler/listings.c"
	"src/assembler/main.c"
	"src/assembler/object.c"
	"src/assembler/parse.c"
	"src/assembler/pass2.c"
	"src/assembler/symbol_file.c"

	# assembler and linker shared libary
	"src/asmlink/debug_tracer.c"
	"src/asmlink/symbol_ext.c"

	# builtins
	"src/assembler/builtins/directives.c"
	"src/assembler/builtins/functions.c"
	"src/assembler/builtins/variables.c"

	# M68K specifics
	"src/assembler/68k/68000.c"

	# library functions
	"src/lib/symbol_table.c"
)

# Differ executable
add_executable(diff
	"src/lstdiff/compare.c"
	"src/lstdiff/lines.c"
	"src/lstdiff/main.c"
	"src/lstdiff/uimode.c"
)

add_executable(hashgen
	"src/hashgen/hashgen.c"
	"src/hashgen/messages.c"
)

# Linking common functions library to the executables
target_link_libraries(asm PRIVATE common)
target_link_libraries(diff PRIVATE common)
target_link_libraries(hashgen PRIVATE common)

# If we're on Windows and we build for debug, link asm with psapi
if(WIN32)
	target_link_libraries(asm PRIVATE
		$<$<CONFIG:Debug,RelWithDebInfo>:psapi.lib>
	)
endif()

# Add tests

function(add_reference_test)
	cmake_parse_arguments(
		REFTEST
		"" "NAME;DIRECTORY" "ADDITIONAL_ARGUMENTS"
		${ARGN}
	)

	add_test(
		NAME ${REFTEST_NAME}
		COMMAND
			${CMAKE_COMMAND}
				-D ASM_PATH=$<TARGET_FILE:asm>
				-D DIFF_PATH=$<TARGET_FILE:diff>
				-D TEST_DIR=${CMAKE_SOURCE_DIR}/data/tests/${REFTEST_DIRECTORY}
				-D OUT_DIR=${CMAKE_BINARY_DIR}/tests/${REFTEST_DIRECTORY}
				-D "ASM_ADDITIONAL_ARGUMENTS=${REFTEST_ADDITIONAL_ARGUMENTS}"
				-P ${CMAKE_SOURCE_DIR}/cmake/ExecuteReferenceTest.cmake
	)
endfunction()

add_reference_test(NAME "Expressions" DIRECTORY expressions ADDITIONAL_ARGUMENTS -w)
add_reference_test(NAME "68000" DIRECTORY 68000 ADDITIONAL_ARGUMENTS -w)
add_reference_test(NAME "Pass2" DIRECTORY pass2 ADDITIONAL_ARGUMENTS -w)
add_reference_test(NAME "Functions" DIRECTORY functions ADDITIONAL_ARGUMENTS -w)
add_reference_test(NAME "Variables" DIRECTORY variables ADDITIONAL_ARGUMENTS -w)
add_reference_test(NAME "EQUR" DIRECTORY equr ADDITIONAL_ARGUMENTS -w)
add_reference_test(NAME "DC" DIRECTORY dc ADDITIONAL_ARGUMENTS +c)
add_reference_test(NAME "CaseSensitive" DIRECTORY case_sensitive ADDITIONAL_ARGUMENTS +c)
add_reference_test(NAME "Files" DIRECTORY files ADDITIONAL_ARGUMENTS -w -i ${CMAKE_SOURCE_DIR}/data/tests/files)
add_reference_test(NAME "CommandlinExpression" DIRECTORY cmd_EQU ADDITIONAL_ARGUMENTS -e "test1=123" -e "test2 equ $456" -e "test3 set 'TEST'" -e "test4 set $FF8000" -e "test5 equr d0")
add_reference_test(NAME "68000Optimization" DIRECTORY 68000_optimization ADDITIONAL_ARGUMENTS +opc +os +ow +oz +oaq +omq)
