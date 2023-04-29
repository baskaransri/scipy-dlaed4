#!/usr/bin/env python3
from distutils.extension import Extension
from distutils.command.build_ext import build_ext
from distutils.errors import DistutilsPlatformError, CCompilerError, DistutilsExecError
import Cython.Build
import numpy


ext_modules = [
    Extension(
        "scipy_dlaed4.scipy_dlaed4_interface",
        include_dirs=[numpy.get_include()],
        sources=["scipy_dlaed4/scipy_dlaed4_interface.pyx"],
    ),
]


class BuildFailed(Exception):
    pass


class ExtBuilder(build_ext):
    def run(self):
        try:
            build_ext.run(self)
        except (DistutilsPlatformError, FileNotFoundError):
            raise BuildFailed("File not found. Could not compile C extension.")

    def build_extension(self, ext):
        try:
            build_ext.build_extension(self, ext)
        except (CCompilerError, DistutilsExecError, DistutilsPlatformError, ValueError):
            raise BuildFailed("Could not compile C extension.")


def build(setup_kwargs):
    """
    This function is mandatory in order to build the extensions.
    """
    setup_kwargs.update(
        {
            "ext_modules": ext_modules,
            #"ext_modules": Cython.Build.cythonize(ext_modules),
            # "cmdclass": {"build_ext": ExtBuilder},
            "cmdclass": {"build_ext": Cython.Build.build_ext},
            "zip_safe": False,
        }
    )
