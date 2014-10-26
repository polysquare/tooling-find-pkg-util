# /tests/ReportToolNotFoundIfQuietAndRequiredVerify.cmake
# Check that "Could NOT find PREFIX" is in the configure errors.
#
# See LICENCE.md for Copyright information.

include (CMakeUnit)

set (CONFIGURE_ERRORS ${CMAKE_CURRENT_BINARY_DIR}/CONFIGURE.error)

assert_file_has_line_matching (${CONFIGURE_ERRORS}
                               "^.*Could NOT find PREFIX.*$")