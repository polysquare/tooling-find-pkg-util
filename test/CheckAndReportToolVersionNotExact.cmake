# /tests/CheckAndReportToolVersionNotExact.cmake
# Check tool version with PREFIX_FIND_VERSION_EXACT set. The requested
# version will not be exact.
#
# See LICENCE.md for Copyright information.

include (ToolingFindPackageUtil)
include (CMakeUnit)

function (run_find)

    set (SUCCESS TRUE)
    set (PREFIX_FIND_VERSION_EXACT TRUE)
    set (PREFIX_FIND_VERSION ${CUSTOM_EXECUTABLE_EXACT_VERSION})
    set (PREFIX_FIND_QUIETLY FALSE)
    psq_check_and_report_tool_version (PREFIX
                                       ${CUSTOM_EXECUTABLE_HIGHER_VERSION}
                                       REQUIRED_VARS SUCCESS)

endfunction (run_find)

run_find ()
assert_variable_is_not_defined (SUCCESS)