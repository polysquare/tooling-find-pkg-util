# /tests/FindToolExecutableInCustomPath.cmake
# Find sample_executable in a provided CUSTOM_PATHS
#
# See LICENCE.md for Copyright information.

include (${POLYSQUARE_FP_TOOLING_CMAKE_DIRECTORY}/ToolingFindPackageUtil.cmake)
include (${POLYSQUARE_FP_TOOLING_CMAKE_TESTS_DIRECTORY}/CMakeUnit.cmake)

psq_find_tool_executable (${CUSTOM_EXECUTABLE_NAME} PATH_TO_EXECUTABLE
                          CUSTOM_PATHS ${CUSTOM_EXECUTABLE_INSTALL_ROOT}
                          PATH_SUFFIXES sample_executable)

assert_variable_is (${PATH_TO_EXECUTABLE} STRING EQUAL
                    ${CUSTOM_EXECUTABLE_LOCATION}/${CUSTOM_EXECUTABLE_NAME})