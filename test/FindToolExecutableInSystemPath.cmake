# /tests/FindToolExecutableInSystemPath.cmake
# Find sample_executable in our system path
#
# See LICENCE.md for Copyright information.

include (ToolingFindPackageUtil)
include (CMakeUnit)

file (READ ${CMAKE_CFG_INTDIR_OUTPUT_FILE} CMAKE_CFG_INTDIR)

psq_find_tool_executable (${CUSTOM_EXECUTABLE_NAME} CUSTOM_EXECUTABLE
                          CUSTOM_PATHS
                          ${CUSTOM_EXECUTABLE_INSTALL_ROOT}
                          PATH_SUFFIXES sample_executable/${CMAKE_CFG_INTDIR})


set (ENV{PATH} "${CUSTOM_EXECUTABLE_LOCATION}/${CMAKE_CFG_INTDIR};$ENV{PATH}")

psq_find_tool_executable (${CUSTOM_EXECUTABLE_NAME} PATH_TO_EXECUTABLE)

set (NONNORMALIZED_EXECPTED_EXECUTABLE_PATH
     ${CUSTOM_EXECUTABLE_LOCATION}/${CMAKE_CFG_INTDIR}/${CUSTOM_EXECUTABLE_NAME})
get_filename_component (EXPECTED_EXECUTABLE_PATH
                        "${NONNORMALIZED_EXECPTED_EXECUTABLE_PATH}" REALPATH)

assert_variable_is (PATH_TO_EXECUTABLE STRING EQUAL ${EXPECTED_EXECUTABLE_PATH})