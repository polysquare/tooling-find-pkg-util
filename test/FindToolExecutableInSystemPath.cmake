# /tests/FindToolExecutableInSystemPath.cmake
# Find sample_executable in our system path
#
# See LICENCE.md for Copyright information.

include (${POLYSQUARE_FP_TOOLING_CMAKE_DIRECTORY}/ToolingFindPackageUtil.cmake)
include (${POLYSQUARE_FP_TOOLING_CMAKE_TESTS_DIRECTORY}/CMakeUnit.cmake)

set (ENV{PATH} "${CUSTOM_EXECUTABLE_LOCATION};$ENV{PATH}")

psq_find_tool_executable (${CUSTOM_EXECUTABLE_NAME} PATH_TO_EXECUTABLE)

assert_variable_is (${PATH_TO_EXECUTABLE} STRING EQUAL
                    ${CUSTOM_EXECUTABLE_LOCATION}/${CUSTOM_EXECUTABLE_NAME})