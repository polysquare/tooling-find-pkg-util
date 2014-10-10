# /tests/ReportNotFoundIfQuiet.cmake
# Report an unfound variable, but set PREFIX_FIND_QUIETLY before doing so
#
# See LICENCE.md for Copyright information.

include (ToolingFindPackageUtil)
include (CMakeUnit)

psq_report_not_found_if_not_quiet (PREFIX UNFOUND_VARIABLE "Unfound")