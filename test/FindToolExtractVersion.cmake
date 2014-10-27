# /tests/FindToolExtractVersion.cmake
# Extract the version from a sample_executable by passing --version to it.
#
# See LICENCE.md for Copyright information.

include (ToolingFindPackageUtil)
include (CMakeUnit)

file (READ ${CMAKE_CFG_INTDIR_OUTPUT_FILE} CMAKE_CFG_INTDIR)

psq_find_tool_executable (${CUSTOM_EXECUTABLE_NAME} CUSTOM_EXECUTABLE
                          CUSTOM_PATHS
                          ${CUSTOM_EXECUTABLE_INSTALL_ROOT}
                          PATH_SUFFIXES sample_executable/${CMAKE_CFG_INTDIR})
psq_find_tool_extract_version (${CUSTOM_EXECUTABLE} VERSION
                               VERSION_ARG --version
                               VERSION_HEADER "VERSION_HEADER "
                               VERSION_FOOTER "VERSION_FOOTER\n")

assert_variable_is (VERSION STRING EQUAL
                    "${CUSTOM_EXECUTABLE_EXACT_VERSION}")