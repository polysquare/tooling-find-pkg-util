# /tests/FindExecutableInstallationRoot.cmake
# Finds the installation root for our custom executable.
#
# See LICENCE.md for Copyright information.

include (ToolingFindPackageUtil)
include (CMakeUnit)

set (CUSTOM_EXECUTABLE ${CUSTOM_EXECUTABLE_LOCATION}/${CUSTOM_EXECUTABLE_NAME})
psq_find_executable_installation_root (${CUSTOM_EXECUTABLE} INSTALL_ROOT
                                       PREFIX_SUBDIRECTORY sample_executable)

assert_variable_is (INSTALL_ROOT STRING EQUAL ${CUSTOM_EXECUTABLE_INSTALL_ROOT})