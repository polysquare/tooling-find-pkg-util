# /tests/FindToolExtractVersion.cmake
# Finds two different executables. The should be completely independent.
#
# See LICENCE.md for Copyright information.

include (ToolingFindPackageUtil)
include (CMakeUnit)

psq_find_tool_executable (${CUSTOM_EXECUTABLE_NAME} CUSTOM_EXECUTABLE
                          CUSTOM_PATHS ${CUSTOM_EXECUTABLE_INSTALL_ROOT}
                          PATH_SUFFIXES sample_executable)

psq_find_tool_executable (${OTHER_EXECUTABLE_NAME} OTHER_EXECUTABLE
                          CUSTOM_PATHS ${OTHER_EXECUTABLE_INSTALL_ROOT}
                          PATH_SUFFIXES other_sample_executable)

get_filename_component (OTHER_EXEC_BASENAME ${OTHER_EXECUTABLE} NAME)
get_filename_component (CUSTOM_EXEC_BASENAME ${CUSTOM_EXECUTABLE} NAME)

assert_variable_is (${OTHER_EXEC_BASENAME} STRING EQUAL
                    "other_sample_executable")
assert_variable_is (${CUSTOM_EXEC_BASENAME} STRING EQUAL
                    "sample_executable")