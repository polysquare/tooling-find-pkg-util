# /tests/ReportNotFoundIfQuiet.cmake
# Report an unfound variable, but set PREFIX_FIND_QUIETLY before doing so
#
# See LICENCE.md for Copyright information.

include (${POLYSQUARE_FP_TOOLING_CMAKE_DIRECTORY}/ToolingFindPackageUtil.cmake)
include (${POLYSQUARE_FP_TOOLING_CMAKE_TESTS_DIRECTORY}/CMakeUnit.cmake)

psq_report_not_found_if_not_quiet (PREFIX UNFOUND_VARIABLE "Unfound")