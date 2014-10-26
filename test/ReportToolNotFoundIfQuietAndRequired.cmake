# /tests/ReportToolNotFoundIfQuietAndRequired.cmake
# Call psq_check_and_report_tool_version with an empty version
# string and with some REQUIRED_VARS being unset, though
# PREFIX_FIND_QUIETLY and PREFIX_FIND_REQUIRED will be set
#
# See LICENCE.md for Copyright information.

include (ToolingFindPackageUtil)
include (CMakeUnit)

set (PREFIX_FIND_REQUIRED TRUE)
set (PREFIX_FIND_QUIETLY TRUE)
psq_check_and_report_tool_version (PREFIX
                                   ""
                                   REQUIRED_VARS
                                   PREFIX_UNDEFINED_VARIABLE)