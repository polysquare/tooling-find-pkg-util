from conans import ConanFile
from conans.tools import download, unzip
import os

VERSION = "0.0.4"


class ToolingCMakeUtilConan(ConanFile):
    name = "tooling-find-pkg-util"
    version = os.environ.get("CONAN_VERSION_OVERRIDE", VERSION)
    generators = "cmake"
    requires = ("cmake-include-guard/master@smspillaz/cmake-include-guard", )
    url = "http://github.com/polysquare/tooling-find-pkg-util"
    license = "MIT"
    options = {
        "dev": [True, False]
    }
    default_options = "dev=False"

    def requirements(self):
        if self.options.dev:
            self.requires("cmake-module-common/master@smspillaz/cmake-module-common")

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
