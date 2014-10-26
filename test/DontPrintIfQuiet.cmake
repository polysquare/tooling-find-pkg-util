# /tests/DontPrintIfQuiet.cmake
# Print a message, but set PREFIX_FIND_QUIETLY before doing so
#
# See LICENCE.md for Copyright information.

include (ToolingFindPackageUtil)
include (CMakeUnit)

set (PREFIX_FIND_QUIETLY TRUE)
psq_print_if_not_quiet (PREFIX MSG "My message")