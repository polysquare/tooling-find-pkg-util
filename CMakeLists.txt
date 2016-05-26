# /CMakeLists.txt
#
# Main entry point for tooling-find-pkg-util tests.
#
# See /LICENCE.md for Copyright information
include ("${CMAKE_CURRENT_LIST_DIR}/conanbuildinfo.cmake")
set (CMAKE_MODULE_PATH
     "${CMAKE_CURRENT_LIST_DIR}"
     ${CONAN_CMAKE_MODULE_PATH}  # NOLINT:correctness/quotes
     ${CMAKE_MODULE_PATH})  # NOLINT:correctness/quotes

cmake_minimum_required (VERSION 2.8)

set (CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR};${CMAKE_MODULE_PATH}")

include ("cmake/cmake-module-common/Common" OPTIONAL)
include (ToolingFindPackageUtil)

if (CMAKE_UNIT_INVOKING_BINARY_DIR)

    set (CMAKE_CFG_INTDIR_OUTPUT_FILE
         "${CMAKE_UNIT_INVOKING_BINARY_DIR}/CMakeCfgIntDir.txt")

else ()

    set (CMAKE_CFG_INTDIR_OUTPUT_FILE
         "${CMAKE_CURRENT_BINARY_DIR}/CMakeCfgIntDir.txt")

endif ()

set (_INVOKING_RUNTIME_OUTPUT_DIR
     "${CMAKE_UNIT_INVOKING_RUNTIME_OUTPUT_DIRECTORY}")
set (CUSTOM_EXEC_NAME sample_executable)
set (OTHER_EXEC_NAME other_sample_executable)
set (CUSTOM_EXEC_LOWER_VER 1.2.2)
set (CUSTOM_EXEC_HIGHER_VER 1.2.4)
set (CUSTOM_EXEC_EXACT_VER 1.2.3)

if (_INVOKING_RUNTIME_OUTPUT_DIR)

    set (CUSTOM_EXEC_LOCATION "${_INVOKING_RUNTIME_OUTPUT_DIR}")
    set (CUSTOM_EXEC_ROOT "${CUSTOM_EXEC_LOCATION}/")
    set (OTHER_EXEC_ROOT "${CUSTOM_EXEC_LOCATION}/")

else ()

    set (CUSTOM_EXEC_LOCATION
         "${CMAKE_UNIT_INVOKING_BINARY_DIR}/test")
    set (CUSTOM_EXEC_ROOT
         "${CMAKE_UNIT_INVOKING_BINARY_DIR}/test/")
    set (OTHER_EXEC_ROOT
         "${CMAKE_UNIT_INVOKING_BINARY_DIR}/test/")

endif ()

# Check tool version with PREFIX_FIND_VERSION_EXACT set. The requested
# version will not be exact.
function (psq_test_check_and_report_tool_version_not_exact)

    function (psq_configure)

        function (psq_run_find)
            set (SUCCESS TRUE)
            set (PREFIX_FIND_VERSION_EXACT TRUE) # NOLINT:unused/var_in_func
            set (PREFIX_FIND_VERSION  # NOLINT:unused/var_in_func
                 ${CUSTOM_EXEC_EXACT_VER})
            set (PREFIX_FIND_QUIETLY FALSE)  # NOLINT:unused/var_in_func
            psq_check_and_report_tool_version (PREFIX
                                               ${CUSTOM_EXEC_HIGHER_VER}
                                               REQUIRED_VARS SUCCESS)
        endfunction ()

        psq_run_find ()
        cmake_unit_assert_that (SUCCESS not is_defined)

    endfunction ()

    function (psq_verify)

        cmake_unit_get_log_for (INVOKE_CONFIGURE OUTPUT CONFIGURE_OUTPUT)
        set (CONFIGURE_MATCH
             "^.*Found unsuitable version.*but required is exact.*$")
        cmake_unit_assert_that (${CONFIGURE_OUTPUT}
                                file_contents any_line matches_regex
                                ${CONFIGURE_MATCH})

    endfunction ()

    cmake_unit_configure_test (CONFIGURE COMMAND psq_configure
                               VERIFY COMMAND psq_verify)
endfunction ()

# Check tool version, the actual version will be lower than requested
function (psq_test_check_and_report_tool_version_too_low)

    function (psq_configure)

        function (psq_run_find)
            set (SUCCESS TRUE)
            set (PREFIX_FIND_VERSION  # NOLINT:unused/var_in_func
                 ${CUSTOM_EXEC_EXACT_VER})
            set (PREFIX_FIND_QUIETLY FALSE)  # NOLINT:unused/var_in_func
            psq_check_and_report_tool_version (PREFIX
                                               ${CUSTOM_EXEC_LOWER_VER}
                                               REQUIRED_VARS SUCCESS)
        endfunction ()

        psq_run_find ()
        cmake_unit_assert_that (SUCCESS not is_defined)

    endfunction ()

    function (psq_verify)

        cmake_unit_get_log_for (INVOKE_CONFIGURE OUTPUT CONFIGURE_OUTPUT)
        set (CONFIGURE_MATCH
             "^.*Found unsuitable version.*but required is at least.*$")
        cmake_unit_assert_that (${CONFIGURE_OUTPUT}
                                file_contents any_line matches_regex
                                ${CONFIGURE_MATCH})

    endfunction ()

    cmake_unit_configure_test (CONFIGURE COMMAND psq_configure
                               VERIFY COMMAND psq_verify)
endfunction ()

# Check tool version, the actual version will be higher than requested
function (psq_test_check_and_report_tool_version_within_range)

    function (psq_configure)

        function (psq_run_find)
            set (SUCCESS TRUE)
            set (PREFIX_FIND_VERSION  # NOLINT:unused/var_in_func
                 ${CUSTOM_EXEC_LOWER_VER})
            psq_check_and_report_tool_version (PREFIX
                                               ${CUSTOM_EXEC_HIGHER_VER}
                                               REQUIRED_VARS SUCCESS)
        endfunction ()

        psq_run_find ()
        cmake_unit_assert_that (SUCCESS is_true)

    endfunction ()

    cmake_unit_configure_test (CONFIGURE COMMAND psq_configure)

endfunction ()

# Print a message, but set PREFIX_FIND_QUIETLY before doing so
function (psq_test_dont_print_if_quiet)

    function (psq_configure)

        set (PREFIX_FIND_QUIETLY TRUE)  # NOLINT:unused/var_in_func
        psq_print_if_not_quiet (PREFIX MSG "My message")

    endfunction ()

    function (psq_verify)

        cmake_unit_get_log_for (INVOKE_CONFIGURE OUTPUT CONFIGURE_OUTPUT)
        cmake_unit_assert_that (${CONFIGURE_OUTPUT}
                                not file_contents any_line matches_regex
                                "^.*My message.*$")

    endfunction ()

    cmake_unit_configure_test (CONFIGURE COMMAND psq_configure
                               VERIFY COMMAND psq_verify)
endfunction ()

# Report an non-found variable, but set PREFIX_FIND_QUIETLY before doing so
function (psq_test_dont_report_not_found_if_quiet)

    function (psq_configure)

        set (PREFIX_FIND_QUIETLY TRUE)  # NOLINT:unused/var_in_func
        psq_report_not_found_if_not_quiet (PREFIX UNFOUND_VARIABLE "Unfound")

    endfunction ()

    function (psq_verify)

        cmake_unit_get_log_for (INVOKE_CONFIGURE OUTPUT CONFIGURE_OUTPUT)
        cmake_unit_assert_that (${CONFIGURE_OUTPUT}
                                not file_contents any_line matches_regex
                                "^.*Unfound.*$")

    endfunction ()

    cmake_unit_configure_test (CONFIGURE COMMAND psq_configure
                               VERIFY COMMAND psq_verify)
endfunction ()

# Finds two different executables. The should be completely independent.
function (psq_test_executable_name_not_cached)

    function (psq_configure)

        file (READ "${CMAKE_CFG_INTDIR_OUTPUT_FILE}" CMAKE_CFG_INTDIR)
        psq_find_tool_executable (${CUSTOM_EXEC_NAME}
                                  CUSTOM_EXEC
                                  CUSTOM_PATHS ${CUSTOM_EXEC_ROOT}
                                               "${_INVOKING_RUNTIME_OUTPUT_DIR}"
                                  PATH_SUFFIXES
                                  "sample_executable/${CMAKE_CFG_INTDIR}")
        psq_find_tool_executable (${OTHER_EXEC_NAME}
                                  OTHER_EXEC
                                  CUSTOM_PATHS ${OTHER_EXEC_ROOT}
                                               "${_INVOKING_RUNTIME_OUTPUT_DIR}"
                                  PATH_SUFFIXES
                                  "other_sample_executable/${CMAKE_CFG_INTDIR}")

        get_filename_component (OTHER_EXEC_BASENAME "${OTHER_EXEC}" NAME)
        get_filename_component (CUSTOM_EXEC_BASENAME "${CUSTOM_EXEC}" NAME)
        set (SUFFIX "${CMAKE_EXECUTABLE_SUFFIX}")
        cmake_unit_assert_that (OTHER_EXEC_BASENAME
                                compare_as STRING EQUAL
                                "other_sample_executable${SUFFIX}")
        cmake_unit_assert_that (CUSTOM_EXEC_BASENAME
                                compare_as STRING EQUAL
                                "sample_executable${SUFFIX}")

    endfunction ()

    cmake_unit_configure_test (CONFIGURE COMMAND psq_configure)

endfunction ()

# Finds the installation root for our custom executable.
function (psq_test_find_executable_installation_root)

    function (psq_configure)

        set (CUSTOM_EXEC
             "${CUSTOM_EXEC_LOCATION}/${CUSTOM_EXEC_NAME}")

        psq_find_executable_installation_root ("${CUSTOM_EXEC}"
                                               INSTALL_ROOT)
        cmake_unit_assert_that (INSTALL_ROOT
                                compare_as STRING EQUAL
                                ${CUSTOM_EXEC_ROOT})

    endfunction ()

    cmake_unit_configure_test (CONFIGURE COMMAND psq_configure)

endfunction ()

# Finds a path in our installation root.
function (psq_test_find_path_in_installation_root)

    function (psq_configure)

        set (PATH_TO_FIND "${CMAKE_CURRENT_BINARY_DIR}/custom_path")
        file (MAKE_DIRECTORY ${PATH_TO_FIND})
        psq_find_path_in_installation_root ("${CMAKE_CURRENT_BINARY_DIR}"
                                            custom_path FOUND_PATH)
        cmake_unit_assert_that (PATH_TO_FIND
                                compare_as STRING EQUAL "${FOUND_PATH}")

    endfunction ()

    cmake_unit_configure_test (CONFIGURE COMMAND psq_configure)

endfunction ()

# Find sample_executable in a provided CUSTOM_PATHS
function (psq_test_find_tool_executable_in_custom_path)

    function (psq_configure)

        file (READ "${CMAKE_CFG_INTDIR_OUTPUT_FILE}" INTDIR)
        psq_find_tool_executable (${CUSTOM_EXEC_NAME}
                                  CUSTOM_EXEC
                                  CUSTOM_PATHS ${CUSTOM_EXEC_ROOT}
                                               "${_INVOKING_RUNTIME_OUTPUT_DIR}"
                                  PATH_SUFFIXES
                                  "sample_executable/${CMAKE_CFG_INTDIR}")
        set (NONNORMALIZED_EXECPTED_EXECUTABLE_PATH
             "${CUSTOM_EXEC_LOCATION}/${INTDIR}/${CUSTOM_EXEC_NAME}")
        get_filename_component (EXPECTED_EXECUTABLE_PATH
                                "${NONNORMALIZED_EXECPTED_EXECUTABLE_PATH}"
                                REALPATH)
        set (SUFFIX "${CMAKE_EXECUTABLE_SUFFIX}")
        cmake_unit_assert_that (CUSTOM_EXEC
                                compare_as STRING EQUAL
                                "${EXPECTED_EXECUTABLE_PATH}${SUFFIX}")

    endfunction ()

    cmake_unit_configure_test (CONFIGURE COMMAND psq_configure)

endfunction ()

# Find sample_executable in our system path
function (psq_test_find_tool_executable_in_system_path)

    function (psq_configure)

        file (READ "${CMAKE_CFG_INTDIR_OUTPUT_FILE}" INTDIR)
        psq_find_tool_executable (${CUSTOM_EXEC_NAME}
                                  CUSTOM_EXEC
                                  CUSTOM_PATHS ${CUSTOM_EXEC_ROOT}
                                               "${_INVOKING_RUNTIME_OUTPUT_DIR}"
                                  PATH_SUFFIXES
                                  "sample_executable/${CMAKE_CFG_INTDIR}")
        set (ENV{PATH}
             "${CUSTOM_EXEC_LOCATION}/${CMAKE_CFG_INTDIR};$ENV{PATH}")
        psq_find_tool_executable (${CUSTOM_EXEC_NAME} PATH_TO_EXECUTABLE)
        set (NONNORMALIZED_EXECPTED_EXECUTABLE_PATH
             "${CUSTOM_EXEC_LOCATION}/${INTDIR}/${CUSTOM_EXEC_NAME}")
        get_filename_component (EXPECTED_EXECUTABLE_PATH
                                "${NONNORMALIZED_EXECPTED_EXECUTABLE_PATH}"
                                REALPATH)
        cmake_unit_assert_that (PATH_TO_EXECUTABLE
                                compare_as STRING EQUAL
                                "${EXPECTED_EXECUTABLE_PATH}")

    endfunction ()

    # This test should work, but doesn't at the moment.
    # cmake_unit_configure_test (CONFIGURE COMMAND psq_configure)

endfunction ()

# Extract the version from a sample_executable by passing --version to it.
function (psq_test_find_tool_extract_version)

    function (psq_configure)

        file (READ "${CMAKE_CFG_INTDIR_OUTPUT_FILE}" CMAKE_CFG_INTDIR)
        psq_find_tool_executable (${CUSTOM_EXEC_NAME}
                                  CUSTOM_EXEC
                                  CUSTOM_PATHS ${CUSTOM_EXEC_ROOT}
                                               "${_INVOKING_RUNTIME_OUTPUT_DIR}"
                                  PATH_SUFFIXES
                                  "sample_executable/${CMAKE_CFG_INTDIR}")
        psq_find_tool_extract_version ("${CUSTOM_EXEC}" VERSION
                                       VERSION_ARG --version
                                       VERSION_HEADER "VERSION_HEADER "
                                       VERSION_END_TOKEN " VERSION_FOOTER\n")
        cmake_unit_assert_that (VERSION compare_as STRING EQUAL
                                "${CUSTOM_EXEC_EXACT_VER}")

    endfunction ()

    cmake_unit_configure_test (CONFIGURE COMMAND psq_configure)

endfunction ()

# Print a message.
function (psq_test_print_if_not_quiet)

    function (psq_configure)

        psq_print_if_not_quiet (PREFIX MSG "My message")

    endfunction ()

    function (psq_verify)

        include (CMakeUnit)
        cmake_unit_get_log_for (INVOKE_CONFIGURE OUTPUT CONFIGURE_OUTPUT)
        cmake_unit_assert_that (${CONFIGURE_OUTPUT}
                                file_contents any_line matches_regex
                                "^.*My message.*$")

    endfunction ()

    cmake_unit_configure_test (CONFIGURE COMMAND psq_configure
                               VERIFY COMMAND psq_verify)
endfunction ()

# Report an non-found variable, but set PREFIX_FIND_QUIETLY before doing so
function (psq_test_report_not_found_if_not_quiet)

    function (psq_configure)

        psq_report_not_found_if_not_quiet (PREFIX UNFOUND_VARIABLE "Unfound")

    endfunction ()

    function (psq_verify)

        cmake_unit_get_log_for (INVOKE_CONFIGURE OUTPUT CONFIGURE_OUTPUT)
        cmake_unit_assert_that (${CONFIGURE_OUTPUT}
                                file_contents any_line matches_regex
                                "^.*Unfound.*$")

    endfunction ()

    cmake_unit_configure_test (CONFIGURE COMMAND psq_configure
                               VERIFY COMMAND psq_verify)
endfunction ()

# Call psq_check_and_report_tool_version with an empty version
# string and with some REQUIRED_VARS being unset
function (psq_test_report_tool_not_found_if_not_quiet)

    function (psq_configure)

        psq_check_and_report_tool_version (PREFIX ""
                                           REQUIRED_VARS
                                           PREFIX_UNDEFINED_VARIABLE)

    endfunction ()

    function (psq_verify)

        cmake_unit_get_log_for (INVOKE_CONFIGURE OUTPUT CONFIGURE_OUTPUT)
        cmake_unit_assert_that (${CONFIGURE_OUTPUT}
                                file_contents any_line matches_regex
                                "^.*Could NOT find PREFIX.*$")

    endfunction ()

    cmake_unit_configure_test (CONFIGURE COMMAND psq_configure
                               VERIFY COMMAND psq_verify)
endfunction ()

# Call psq_check_and_report_tool_version with an empty version
# string and with some REQUIRED_VARS being unset, though
# PREFIX_FIND_QUIETLY and PREFIX_FIND_REQUIRED will be set
function (psq_test_report_tool_not_found_if_quiet_and_required)

    function (psq_configure)

        set (PREFIX_FIND_REQUIRED TRUE)  # NOLINT:unused/var_in_func
        set (PREFIX_FIND_QUIETLY TRUE)  # NOLINT:unused/var_in_func
        psq_check_and_report_tool_version (PREFIX ""
                                           REQUIRED_VARS
                                           PREFIX_UNDEFINED_VARIABLE)

    endfunction ()

    function (psq_verify)

        cmake_unit_get_log_for (INVOKE_CONFIGURE ERROR CONFIGURE_ERRORS)
        cmake_unit_assert_that (${CONFIGURE_ERRORS}
                                file_contents any_line matches_regex
                                "^.*Could NOT find PREFIX.*$")

    endfunction ()

    cmake_unit_configure_test (CONFIGURE COMMAND psq_configure
                               INVOKE_CONFIGURE OPTIONS ALLOW_FAIL NO_CLEAN
                               VERIFY COMMAND psq_verify)
endfunction ()


if (NOT CMAKE_SCRIPT_MODE_FILE AND
    "${CMAKE_CURRENT_SOURCE_DIR}"
    STREQUAL
    "${CMAKE_CURRENT_LIST_DIR}")

    add_subdirectory ("${CMAKE_CURRENT_LIST_DIR}/test")

endif ()

set (CMAKE_FILES
     "${CMAKE_CURRENT_LIST_DIR}/ToolingFindPackageUtil.cmake"
     "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt")
set (MARKDOWN_FILES
     "${CMAKE_CURRENT_LIST_DIR}/LICENCE.md"
     "${CMAKE_CURRENT_LIST_DIR}/README.md")

if (COMMAND cmake_module_add_common_targets)

    cmake_module_add_common_targets (NAMESPACE "psq"
                                     CMAKE_FILES ${CMAKE_FILES}
                                     DOCUMENTATION_FILES ${MARKDOWN_FILES})

endif ()
