# /tests/CMakeLists.txt
# Main entry point for the tooling-cmake-util tests.
#
# See LICENCE.md for Copyright information

if (POLICY CMP0025)

    cmake_policy (SET CMP0025 NEW)

endif (POLICY CMP0025)

project (PolysquareToolingFindPackageUtilTests)
cmake_minimum_required (VERSION 2.8)

# We assume that it is one-above us
set (POLYSQUARE_RELATIVE_CMAKE_DIRECTORY
     ${CMAKE_CURRENT_SOURCE_DIR}/..)
get_filename_component (POLYSQUARE_FP_TOOLING_CMAKE_DIRECTORY
                        ${POLYSQUARE_RELATIVE_CMAKE_DIRECTORY}
                        ABSOLUTE)

set (CMAKE_UNIT_DIRECTORY
     ${POLYSQUARE_FP_TOOLING_CMAKE_DIRECTORY}/cmake-unit)

# Setup variables for finding custom executable, etc
set (CUSTOM_EXECUTABLE_NAME sample_executable)
set (CUSTOM_EXECUTABLE_INSTALL_ROOT ${CMAKE_CURRENT_BINARY_DIR})
set (OTHER_EXECUTABLE_NAME other_sample_executable)
set (OTHER_EXECUTABLE_INSTALL_ROOT ${CMAKE_CURRENT_BINARY_DIR})
set (CUSTOM_EXECUTABLE_LOCATION ${CMAKE_CURRENT_BINARY_DIR}/sample_executable)
set (CUSTOM_EXECUTABLE_LOWER_VERSION 1.2.2)
set (CUSTOM_EXECUTABLE_HIGHER_VERSION 1.2.4)
set (CUSTOM_EXECUTABLE_EXACT_VERSION 1.2.3)

set (CMAKE_MODULE_PATH
     ${CMAKE_UNIT_DIRECTORY}
     ${POLYSQUARE_FP_TOOLING_CMAKE_DIRECTORY}
     ${CMAKE_MODULE_PATH})

include (CMakeUnitRunner)

bootstrap_cmake_unit (VARIABLES CMAKE_MODULE_PATH
                                CUSTOM_EXECUTABLE_NAME
                                CUSTOM_EXECUTABLE_INSTALL_ROOT
                                OTHER_EXECUTABLE_NAME
                                OTHER_EXECUTABLE_INSTALL_ROOT
                                CUSTOM_EXECUTABLE_LOCATION
                                CUSTOM_EXECUTABLE_LOWER_VERSION
                                CUSTOM_EXECUTABLE_HIGHER_VERSION
                                CUSTOM_EXECUTABLE_EXACT_VERSION)

add_cmake_test (CheckAndReportToolVersionWithinRange)
add_cmake_test (FindExecutableInstallationRoot)
add_cmake_test (FindPathInInstallationRoot)
add_cmake_test (FindToolExecutableInCustomPath)
add_cmake_test (ExecutableNameNotCached)
# This should work, but it appears that PATH is read from the point when
# CMake is launched and not immediately before calling find_program.
#add_cmake_test (FindToolExecutableInSystemPath)

add_cmake_build_test (CheckAndReportToolVersionNotExact
                      CheckAndReportToolVersionNotExactVerify NO_CLEAN)
add_cmake_build_test (CheckAndReportToolVersionTooLow
                      CheckAndReportToolVersionTooLowVerify NO_CLEAN)
add_cmake_build_test (DontPrintIfQuiet
                      DontPrintIfQuietVerify NO_CLEAN)
add_cmake_build_test (DontReportNotFoundIfQuiet
                      DontReportNotFoundIfQuietVerify NO_CLEAN)
add_cmake_build_test (PrintIfNotQuiet
                      PrintIfNotQuietVerify NO_CLEAN)
add_cmake_build_test (ReportNotFoundIfNotQuiet
                      ReportNotFoundIfNotQuietVerify NO_CLEAN)
add_cmake_build_test (ReportToolNotFoundIfNotQuiet
                      ReportToolNotFoundIfNotQuietVerify NO_CLEAN)
add_cmake_build_test (ReportToolNotFoundIfQuietAndRequired
                      ReportToolNotFoundIfQuietAndRequiredVerify
                      ALLOW_CONFIGURE_FAIL NO_CLEAN)

add_subdirectory (sample_executable)
add_subdirectory (other_sample_executable)
