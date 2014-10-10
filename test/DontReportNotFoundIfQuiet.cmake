# /tests/DontReportNotFoundIfQuiet.cmake
# Report an unfound variable, but set PREFIX_FIND_QUIETLY before doing so
#
# See LICENCE.md for Copyright information.

include (ToolingFindPackageUtil)
include (CMakeUnit)

set (PREFIX_FIND_QUIETLY TRUE)
psq_report_not_found_if_not_quiet (PREFIX UNFOUND_VARIABLE "Unfound")