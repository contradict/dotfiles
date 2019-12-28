import os.path as p
import os

BASE_FLAGS = [
    "-Wall",
    "-Wextra",
    "-Werror",
    "-Wno-long-long",
    # '-Wno-variadic-macros',
    "-fexceptions",
    "-ferror-limit=10000",
    # '-DNDEBUG',
    "-std=c++11",
    "-xc++",
    "-I",
    "/usr/include/eigen3",
    "-I",
    "/usr/local/include",
    "-I",
    "/usr/local/cuda/include",
]
if "ROS_DISTRO" in os.environ:
    ros_base = "/opt/ros/%(ROS_DISTRO)s" % os.environ
    BASE_FLAGS += ["-I", ros_base + "/include"]


SOURCE_EXTENSIONS = [
    ".cpp",
    ".cxx",
    ".cc",
    ".c",
]

HEADER_EXTENSIONS = [".h", ".hxx", ".hpp", ".hh"]

DIR_OF_THIS_SCRIPT = p.abspath(p.dirname(__file__))


def Settings(**kwargs):
    return {
        "flags": BASE_FLAGS,
    }
