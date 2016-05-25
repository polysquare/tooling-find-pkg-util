# /test/CMakeLists.txt
#
# Create executables that are re-used during the tests.
#
# See /LICENCE.md for Copyright information

include ("cmake/cmake-unit/CMakeUnit" OPTIONAL)

add_executable (other_sample_executable
                other_sample_executable.c)
add_executable (sample_executable
                sample_executable.c)

# Add a custom target which prints out the CMAKE_CFG_INTDIR for the
# current generator to CMAKE_CFG_INTDIR_OUTPUT_FILE
if (COMMAND cmake_unit_write_if_newer)

    set (WRITE_TO_CFG_OUTPUT_FILE_SCRIPT
         "${CMAKE_CURRENT_BINARY_DIR}/WriteCfgIntDir.cmake")
    set (WRITE_TO_CFG_OUTPUT_FILE_SCRIPT_CONTENTS
         "file (WRITE ${CMAKE_CFG_INTDIR_OUTPUT_FILE} \"\${INTDIR}\")\n")
    cmake_unit_write_if_newer ("${WRITE_TO_CFG_OUTPUT_FILE_SCRIPT}"
                               "${CMAKE_CURRENT_LIST_FILE}"
                               "${WRITE_TO_CFG_OUTPUT_FILE_SCRIPT_CONTENTS}")
    add_custom_command (OUTPUT "${CMAKE_CFG_INTDIR_OUTPUT_FILE}"
                        COMMAND
                        "${CMAKE_COMMAND}"
                        -P
                        "${WRITE_TO_CFG_OUTPUT_FILE_SCRIPT}"
                        "-DINTDIR=\"${CMAKE_CFG_INTDIR}\"")
    add_custom_target (write_cfg_int_dir ALL
                       SOURCES "${CMAKE_CFG_INTDIR_OUTPUT_FILE}")

endif ()
