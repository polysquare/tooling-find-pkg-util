# /tests/ReportToolNotFoundIfQuietAndRequired.cmake
# Call psq_report_tool_not_found
#
# See LICENCE.md for Copyright information.

include (${POLYSQUARE_FP_TOOLING_CMAKE_DIRECTORY}/ToolingFindPackageUtil.cmake)
include (${POLYSQUARE_FP_TOOLING_CMAKE_TESTS_DIRECTORY}/CMakeUnit.cmake)

set (PREFIX_FIND_REQUIRED TRUE)
psq_report_tool_not_found (PREFIX "Not found report")