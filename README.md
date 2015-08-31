# Macros for providing find_package for tooling scripts #

find_package helpers for polysquare cmake tooling scripts.

## Status ##

| Travis CI (Ubuntu) | AppVeyor (Windows) | Coverage | Biicode | Licence |
|--------------------|--------------------|----------|---------|---------|
|[![Travis](https://img.shields.io/travis/polysquare/tooling-find-pkg-util.svg)](http://travis-ci.org/polysquare/tooling-find-pkg-util)|[![AppVeyor](https://img.shields.io/appveyor/ci/smspillaz/tooling-find-package-cmake-util.svg)](https://ci.appveyor.com/project/smspillaz/tooling-find-package-cmake-util)|[![Coveralls](https://img.shields.io/coveralls/polysquare/tooling-find-pkg-util.svg)](http://coveralls.io/polysquare/tooling-find-pkg-util)|[![Biicode](https://webapi.biicode.com/v1/badges/smspillaz/smspillaz/tooling-find-pkg-util/master)](https://www.biicode.com/smspillaz/tooling-find-pkg-util)|[![License](https://img.shields.io/github/license/polysquare/tooling-find-pkg-util.svg)](http://github.com/polysquare/tooling-find-pkg-util)|

## Usage ##

`tooling-find-pkg-util` wraps [`FindPackageHandleStandardArgs`](http://www.cmake.org/cmake/help/v3.0/module/FindPackageHandleStandardArgs.html)
in relation to source code tooling binaries. It provides functions to
extract the path and version of those binaries (and thus whether they
are installed) and a means to pass that information to
`FindPackageHandleStandardArgs`.

### Extracting the path and version of binaries ###

#### `psq_find_tool_executable` ####

Finds the executable EXECUTABLE_TO_FIND and places the result in PATH_RETURN.
This information can later be passed to `psq_check_and_report_tool_version`. It
will check both the system installation paths and any provided `CUSTOM_PATHS`.

- `EXECUTABLE_TO_FIND`: The name of the executable to find
- `PATH_RETURN`: A variable to place the full path when found
- [Optional] `CUSTOM_PATHS`: Paths to search first before searching system paths
- [Optional] `PATH_SUFFIXES`: Suffixes on each installation root (eg, bin)

#### `psq_find_tool_extract_version` ####

Runs the tool and fetches its version, placing the result into VERSION_RETURN.
This information can later be passed to `psq_check_and_report_tool_version`.

Usually the version number is printed along with other information. As such
you should specify `VERSION_HEADER` and `VERSION_END_TOKEN` to indicate any
text that should be removed in the string before the version number and a
token which occurs indicating that the end of the version number has been
reached.

- `TOOL_EXECUTABLE`: The path to the tool
- `VERSION_RETURN`: A variable to place the full version when detected
- [Optional] `VERSION_ARG`: Argument to pass to the tool when running it to
                           fetch its version.
- [Optional] `VERSION_HEADER`: Text that comes before the version number.
- [Optional] `VERSION_END_TOKEN`: Text that comes after the version number.

### Checking that the requested version of the tool was found ###

#### `psq_check_and_report_tool_version` ####

For the package specified by `PREFIX`, determines if the detected
`VERSION` matched the requested version passed to find_package. If not
and we are not finding quietly, report problems. If the version check
is satisfied and all `REQUIRED_VARS` are set, then set each of the
`REQUIRED_VARS` in the `PARENT_SCOPE`

- `PREFIX`: The package prefix passed to find_package for this module
- `VERSION`: The detected tool version
- `REQUIRED_VARS`: Required variables, set in parent scope if present
                   Must specify at least one.

### Finding other directories relative to the tool ###

Sometimes you might want to set some variables after running a find macro
which indicate the location of data files related to the tool, or even
other useful binaries. To do this, it is useful to have the "installation
root" of the tool.

#### `psq_find_path_in_installation_root` ####

Places the full path to `SUBDIRECTORY_TO_FIND` in `PATH_RETURN` if found in
`INSTALL_ROOT`

- `INSTALL_ROOT` The directory to search for
- `SUBDIRECTORY_TO_FIND`: The name of the subdirectory to find
- `PATH_RETURN`: A variable to place the full path when found

#### `psq_find_executable_installation_root` ####

For the path to a `TOOL_EXECUTABLE`, get the installation prefix
of that executable and place it in the variable named by `INSTALL_ROOT_RETURN`

- `TOOL_EXECUTABLE`: Path to an executable
- `INSTALL_ROOT_RETURN`: A variable to place the full path to install root
- [Optional] `PREFIX_SUBDIRECTORY`: A partial path of directories between the
                                    executable itself and install root
                                    (eg /bin/)

### Printing messages correctly ###

Find macros are supposed to respect `PREFIX_FIND_QUIETLY`. Having a bunch of
if conditions can be quite tedious to write, so `tooling-find-pkg-util` provides
a function called `psq_print_if_not_quiet` which handles this logic for you.

#### `psq_print_if_not_quiet` ####

Print a message as specified as part of `ARGN` as long as
`${PREFIX}_FIND_QUIETLY` is not set.

- `PREFIX`: The package prefix passed to find_package for this module
- `MSG`: Message to print
- `DEPENDS`: Variables, which when changed, the message should be re-displayed