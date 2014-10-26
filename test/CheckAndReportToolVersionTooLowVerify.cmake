# /tests/CheckAndReportVersionTooLowVerify.cmake
# Check that "^.*Requested at least version:.*but.*version was.*$" is in the
# configure output.
#
# See LICENCE.md for Copyright information.

include (CMakeUnit)

set (CONFIGURE_OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/CONFIGURE.output)

set (CONFIGURE_MATCH "^.*Found unsuitable version.*but required is at least.*$")
assert_file_has_line_matching (${CONFIGURE_OUTPUT} ${CONFIGURE_MATCH})