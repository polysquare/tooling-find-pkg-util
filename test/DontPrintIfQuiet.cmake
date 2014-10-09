# /tests/DontPrintIfQuiet.cmake
# Print a message, but set PREFIX_FIND_QUIETLY before doing so
#
# See LICENCE.md for Copyright information.

include (${POLYSQUARE_FP_TOOLING_CMAKE_DIRECTORY}/ToolingFindPackageUtil.cmake)
include (${POLYSQUARE_FP_TOOLING_CMAKE_TESTS_DIRECTORY}/CMakeUnit.cmake)

set (PREFIX_FIND_QUIETLY TRUE)
psq_print_if_not_quiet (PREFIX "My message")