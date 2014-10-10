# /tests/ReportNotFoundIfQuietVerify.cmake
# Check that "My message" is not in the configure output.
#
# See LICENCE.md for Copyright information.

include (CMakeUnit)

set (CONFIGURE_OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/CONFIGURE.output)

assert_file_has_line_matching (${CONFIGURE_OUTPUT}
                               "^.*Unfound.*$")