# /tests/CheckAndReportToolVersionWithinRange.cmake
# Check tool version, the actual version will be higher than requested
#
# See LICENCE.md for Copyright information.

include (${POLYSQUARE_FP_TOOLING_CMAKE_DIRECTORY}/ToolingFindPackageUtil.cmake)
include (${POLYSQUARE_FP_TOOLING_CMAKE_TESTS_DIRECTORY}/CMakeUnit.cmake)

set (PREFIX_FIND_VERSION ${CUSTOM_EXECUTABLE_LOWER_VERSION})
psq_check_and_report_tool_version (PREFIX 
                                   ${CUSTOM_EXECUTABLE_HIGHER_VERSION}
                                   SUCCESS)

assert_true (${SUCCESS})