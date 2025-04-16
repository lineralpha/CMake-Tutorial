# policy settings: minimum version of CMake required
cmake_minimum_required(VERSION 3.28.0)

# define the project
project(Tutorial VERSION 1.0 LANGUAGES C CXX)

include(cmake/NinjaMultiConfig.cmake)
include(cmake/CompilerOptions.cmake)

# d for debug build postfix
set(CMAKE_DEBUG_POSTFIX d)
set(CMAKE_INSTALL_PREFIX "${PROJECT_BINARY_DIR}/install")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")

add_subdirectory(src)
