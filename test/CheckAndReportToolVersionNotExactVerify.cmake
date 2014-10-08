# /tests/CheckAndReportVersionNotExactVerify.cmake
# Check that "^.*Requested exact version:.*but.*version was.*$" is in the
# configure output.
#
# See LICENCE.md for Copyright information.

include (${POLYSQUARE_FP_TOOLING_CMAKE_TESTS_DIRECTORY}/CMakeUnit.cmake)

set (CONFIGURE_OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/CONFIGURE.output)

set (CONFIGURE_MATCH "^.*Requested exact version:.*but.*version was.*$")
assert_file_has_line_matching (${CONFIGURE_OUTPUT} ${CONFIGURE_MATCH})