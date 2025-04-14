# create an OBJECT library that can then be consumed
# through TARGET_OBJECTS generator
add_library(ArgParser OBJECT ArgParser.cpp)

# require header TutorialConfig.h to build the target
target_include_directories(ArgParser
    INTERFACE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
    PRIVATE
        "${PROJECT_BINARY_DIR}"
)
