# /tests/ReportToolNotFoundIfNotQuiet.cmake
# Call psq_report_tool_not_found
#
# See LICENCE.md for Copyright information.

include (ToolingFindPackageUtil)
include (CMakeUnit)

psq_report_tool_not_found (PREFIX "Not found report")