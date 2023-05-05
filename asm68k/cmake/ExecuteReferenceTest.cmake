cmake_minimum_required(VERSION 3.18)

##############################################################################
# Reference test execution script
##############################################################################

# Check if all the variables are defined
# ======================================

if(NOT DEFINED TEST_DIR)
    message(FATAL_ERROR "TEST_DIR must be defined")
endif()

if(NOT DEFINED OUT_DIR)
    message(FATAL_ERROR "OUT_DIR must be defined")
endif()

if(NOT DEFINED ASM_PATH)
    message(FATAL_ERROR "ASM_PATH must be defined")
endif()

if(NOT DEFINED DIFF_PATH)
    message(FATAL_ERROR "DIFF_PATH must be defined")
endif()

if(NOT DEFINED ASM_ADDITIONAL_ARGUMENTS)
    set(ASM_ADDITIONAL_ARGUMENTS "")
endif()

# Actual execution
# ======================================

# Create output directory if it doesn't exist
file(MAKE_DIRECTORY ${OUT_DIR})

# Create variables for every file that participates in testing
set(testFile ${TEST_DIR}/main.asm)
set(testTrace ${TEST_DIR}/main.log)
set(testResult ${TEST_DIR}/main.dat)
set(outTrace ${OUT_DIR}/test.log)
set(outResult ${OUT_DIR}/test.dat)
set(outListing ${OUT_DIR}/test.lst)

# Run asm and get its return code
execute_process(
    COMMAND ${ASM_PATH} -q ${ASM_ADDITIONAL_ARGUMENTS}
        --trace ${outTrace}
        --lst ${outListing}
        ${testFile} ${outResult}
    RESULT_VARIABLE asmExitCode
)

# Exit with error if asm failed
if(NOT (${asmExitCode} EQUAL 0))
    message(FATAL_ERROR "failed to build file \"${testFile}\"")
endif()

# Run diff and get its return code
execute_process(
    COMMAND ${DIFF_PATH} --uprint
        ${testResult} ${outListing} ${outResult}
    RESULT_VARIABLE diffExitCode
)

# Exit with error if diff failed
if(NOT (${diffExitCode} EQUAL 0))
    message(FATAL_ERROR "diff failed with parameters: ${testResult} ${outListing} ${outResult}")
endif()

# Compare reference file with output file
execute_process(
    COMMAND ${CMAKE_COMMAND} -E compare_files
        ${testTrace} ${outTrace}
    RESULT_VARIABLE fcExitCode
)

# Exit with error if files do not match
if(NOT (${fcExitCode} EQUAL 0))
    message(FATAL_ERROR "file comparison failed: ${testTrace} ${outTrace}")
endif()

# If we're here, CMake will finish with return code 0
