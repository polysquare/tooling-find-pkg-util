# /tests/ReportToolNotFoundIfQuietAndRequired.cmake
# Call psq_report_tool_not_found
#
# See LICENCE.md for Copyright information.

include (ToolingFindPackageUtil)
include (CMakeUnit)

set (PREFIX_FIND_REQUIRED TRUE)
psq_report_tool_not_found (PREFIX "Not found report")