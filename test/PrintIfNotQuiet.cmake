# /tests/PrintIfQuiet.cmake
# Print a message.
#
# See LICENCE.md for Copyright information.

include (ToolingFindPackageUtil)
include (CMakeUnit)

psq_print_if_not_quiet (PREFIX MSG "My message")