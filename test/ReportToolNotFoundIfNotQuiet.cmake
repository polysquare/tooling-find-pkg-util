# /tests/ReportToolNotFoundIfNotQuiet.cmake
# Call psq_check_and_report_tool_version with an empty version
# string and with some REQUIRED_VARS being unset
#
# See LICENCE.md for Copyright information.

include (ToolingFindPackageUtil)
include (CMakeUnit)

psq_check_and_report_tool_version (PREFIX
                                   ""
                                   REQUIRED_VARS
                                   PREFIX_UNDEFINED_VARIABLE)