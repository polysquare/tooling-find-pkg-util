# /tests/ReportToolNotFoundIfNotQuietVerify.cmake
# Check that "Could NOT find PREFIX" is in the configure output.
#
# See LICENCE.md for Copyright information.

include (CMakeUnit)

set (CONFIGURE_OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/CONFIGURE.output)

assert_file_has_line_matching (${CONFIGURE_OUTPUT}
                               "^.*Could NOT find PREFIX.*$")