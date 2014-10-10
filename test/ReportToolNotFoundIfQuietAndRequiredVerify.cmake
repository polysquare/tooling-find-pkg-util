# /tests/ReportToolNotFoundIfQuietAndRequiredVerify.cmake
# Check that "Not found report" is in the configure out.
#
# See LICENCE.md for Copyright information.

include (CMakeUnit)

set (CONFIGURE_OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/CONFIGURE.error)

assert_file_has_line_matching (${CONFIGURE_OUTPUT}
                               "^.*Not found report.*$")