from conans import ConanFile
from conans.tools import download, unzip
import os

VERSION = "0.0.3"


class ToolingCMakeUtilConan(ConanFile):
    name = "tooling-find-pkg-util"
    version = os.environ.get("CONAN_VERSION_OVERRIDE", VERSION)
    generators = "cmake"
    requires = ("cmake-include-guard/master@smspillaz/cmake-include-guard",
                "cmake-unit/master@smspillaz/cmake-unit")
    url = "http://github.com/polysquare/tooling-find-pkg-util"
    license = "MIT"

    def source(self):
        zip_name = "tooling-find-pkg-util.zip"
        download("https://github.com/polysquare/"
                 "tooling-find-pkg-util/archive/{version}.zip"
                 "".format(version="v" + VERSION),
                 zip_name)
        unzip(zip_name)
        os.unlink(zip_name)

    def package(self):
        self.copy(pattern="*.cmake",
                  dst="cmake/tooling-find-pkg-util",
                  src="tooling-find-pkg-util-" + VERSION,
                  keep_path=True)
