# /tests/FindPathInInstallationRoot.cmake
# Finds a path in our installation root.
#
# See LICENCE.md for Copyright information.

include (${POLYSQUARE_FP_TOOLING_CMAKE_DIRECTORY}/ToolingFindPackageUtil.cmake)
include (${POLYSQUARE_FP_TOOLING_CMAKE_TESTS_DIRECTORY}/CMakeUnit.cmake)

set (PATH_TO_FIND ${CMAKE_CURRENT_BINARY_DIR}/custom_path)
file (MAKE_DIRECTORY ${PATH_TO_FIND})

psq_find_path_in_installation_root (${CMAKE_CURRENT_BINARY_DIR}
                                    custom_path
                                    FOUND_PATH)

assert_variable_is (${PATH_TO_FIND} STRING EQUAL ${FOUND_PATH})