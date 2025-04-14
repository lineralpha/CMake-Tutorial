# policy settings: minimum version of CMake required
cmake_minimum_required(VERSION 3.28.0)

# define the project
project(Tutorial VERSION 1.0 LANGUAGES C CXX)

# optional - ensure build config options are visible to the user
set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)

# optional - set default build config if none is given;
# defaults to the first item from CMAKE_CONFIGURATION_TYPES if not set
if(NOT DEFINED CMAKE_DEFAULT_BUILD_TYPE)
    set(CMAKE_DEFAULT_BUILD_TYPE "Debug" CACHE STRING "Default build type" FORCE)
endif()

# d for debug build postfix
set(CMAKE_DEBUG_POSTFIX d)

# use c++17 standard
add_library(tutorial_compiler_flags INTERFACE)
target_compile_features(tutorial_compiler_flags INTERFACE cxx_std_17)

# specify compiler warning flags when building this project through
# BUILD_INTERFACE generator expression
set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
target_compile_options(tutorial_compiler_flags
    INTERFACE
        "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Werror;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
        $<$<CONFIG:Debug>:DDEBUG>
        $<$<CONFIG:Release>:DNDEBUG>
)

# executable target
add_executable(Tutorial Tutorial.cpp)
set_target_properties(Tutorial
    PROPERTIES
        DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX}
)

# use an option to decide which sqrt function is used
option(USE_MYMATH "Use tutorial provided math implementation" ON)

# configure a header file to pass CMake settings/options
# the output file TutorialConfig.h will be written into build tree directory
configure_file(TutorialConfig.h.in TutorialConfig.h)

if(USE_MYMATH)
    # use this command instead of #cmakedefine
    target_compile_definitions(Tutorial PRIVATE "USE_MYMATH")
    add_subdirectory(MathFunctions)
    list(APPEND EXTRA_LIBS MathFunctions)
endif()

add_subdirectory(ArgParser)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")

target_link_libraries(Tutorial
    PUBLIC
        ${EXTRA_LIBS}
        $<TARGET_OBJECTS:ArgParser>
        tutorial_compiler_flags
)

# add the binary tree to the list of paths to search for include files.
# this is required because the generated TutorialConfig.h is in binary tree
# target_include_directories(Tutorial
#     PUBLIC
#         "${PROJECT_BINARY_DIR}"
# )

# run install commands from the build directory
# the --prefix option specifies the root path of the install location
# cmake --install . --prefix "/home/atoz/installdir/"
# or overwrite cache variable CMAKE_INSTALL_PREFIX
install(TARGETS Tutorial DESTINATION bin)
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h" DESTINATION include)

include(CTest) # also support CDash
enable_testing()

# does the application run?
add_test(NAME Runs COMMAND Tutorial 25)

# does the Usage message work?
add_test(NAME Usage COMMAND Tutorial)
set_tests_properties(Usage PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number")

#define a function to simplify adding tests
function(do_test target arg result)
    add_test(NAME Comp${arg} COMMAND ${target} ${arg})
    set_tests_properties(Comp${arg} PROPERTIES PASS_REGULAR_EXPRESSION ${result})
endfunction(do_test)

# do a bunch of result based tests
do_test(Tutorial 4 "4 is 2")
do_test(Tutorial 9 "9 is 3")
do_test(Tutorial 5 "5 is 2.236")
do_test(Tutorial 7 "7 is 2.645")
do_test(Tutorial 25 "25 is 5")
do_test(Tutorial -25 "-25 is [-nan|nan|0]")
do_test(Tutorial 0.0001 "0.0001 is 0.01")

# cpack - set up installer
# Note: to archive the source tree, run: cpack --config CPackSourceConfig.cmake
include(InstallRequiredSystemLibraries)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "${Tutorial_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${Tutorial_VERSION_MINOR}")
set(CPACK_SOURCE_GENERATOR "TGZ")
include(CPack)

# install the configuration targets
# the EXPORT generates a CMake file containing code to import all targets
# listed in the install command from the installation tree.
install(EXPORT MathFunctionsTargets
        FILE MathFunctionsTargets.cmake
        DESTINATION lib/cmake/MathFunctions)

include(CMakePackageConfigHelpers)

# generate the config file that includes the exports
# Note: INSTALL_DESTINATION here gives a hint on the path structure, not necessary the actual path
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake"
  INSTALL_DESTINATION "lib/cmake/example"
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
  )

# generate the version file for the config file
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake"
  VERSION "${Tutorial_VERSION_MAJOR}.${Tutorial_VERSION_MINOR}"
  COMPATIBILITY AnyNewerVersion
)

# install the generated configuration files
install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake
  DESTINATION lib/cmake/MathFunctions
  )

# generate the export targets from the build tree
# needs to be after the install(TARGETS) command
export(EXPORT MathFunctionsTargets
  FILE "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsTargets.cmake"
)
