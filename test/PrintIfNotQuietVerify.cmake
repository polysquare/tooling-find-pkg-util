# /tests/PrintIfQuietVerify.cmake
# Check that "My message" is in the configure output.
#
# See LICENCE.md for Copyright information.

include (${POLYSQUARE_FP_TOOLING_CMAKE_TESTS_DIRECTORY}/CMakeUnit.cmake)

set (CONFIGURE_OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/CONFIGURE.output)

assert_file_has_line_matching (${CONFIGURE_OUTPUT}
                               "^.*My message.*$")