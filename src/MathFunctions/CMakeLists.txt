include(cmake/MakeSqrtTable.cmake)
include(cmake/SqrtLib.cmake)

# BUILD_SHAREED_LIBS controls the default library type - SHARED or STATIC by default
# here explicitly state to build a shared library
add_library(MathFunctions SHARED MathFunctions.cpp)

# state that anybody linking to us needs to include the current source dir
# to find MathFunctions.h, while MathFunctions itself doesn't
target_include_directories(MathFunctions
        INTERFACE
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
            $<INSTALL_INTERFACE:include>
)

target_link_libraries(MathFunctions
    PUBLIC project_compiler_options
    PRIVATE SqrtLib
)

# setup the version numbering
set_target_properties(MathFunctions
    PROPERTIES
        # set the versioning scheme to be compatible with the shared library
        # versioning scheme
        VERSION "1.0.0"
        SOVERSION "1"
)

# install rules
set(installable_libs MathFunctions project_compiler_options)
# also add export configuration (MathFunctionsTargets.cmake)
install(TARGETS ${installable_libs}
        EXPORT MathFunctionsTargets
        DESTINATION lib
)
install(FILES MathFunctions.h DESTINATION include)

# install the configuration targets
# the EXPORT generates a CMake file containing code to import all targets
# listed in the install command from the installation tree.
install(EXPORT MathFunctionsTargets
        FILE MathFunctionsTargets.cmake
        DESTINATION lib/cmake/MathFunctions
)

include(CMakePackageConfigHelpers)

# generate the config file that includes the exports
# so that find_package can find the targets
# Note: INSTALL_DESTINATION here gives a hint on the path structure,
# not necessary the actual path
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake"
    INSTALL_DESTINATION "lib/cmake/example"
    NO_SET_AND_CHECK_MACRO
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

# generate the version file for the config file
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake"
    VERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}"
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
