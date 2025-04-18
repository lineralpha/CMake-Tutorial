# policy settings: minimum version of CMake required
cmake_minimum_required(VERSION 3.28.0)

# define the project
project(Tutorial VERSION 1.0 LANGUAGES C CXX)

include(cmake/NinjaMultiConfig.cmake)
include(cmake/CompilerOptions.cmake)

# d for debug build postfix
set(CMAKE_DEBUG_POSTFIX d)

# set(CMAKE_INSTALL_PREFIX "${PROJECT_BINARY_DIR}/install")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")

# CPack
include(InstallRequiredSystemLibraries)
set(CPACK_RESOURCE_FILE_LICENSE "${PROJECT_SOURCE_DIR}/License.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
set(CPACK_SOURCE_GENERATOR "TGZ")

# this module outputs the CPackConfig.cmake and CPackSourceConfig.cmake
# to archive the source tree, run: cpack --config CPackSourceConfig.cmake
include(CPack)
include(CTest)

# third party libraries
# find_package(spdlog REQUIRED)
add_subdirectory(thirdParties)

add_subdirectory(src)
add_subdirectory(tests)
