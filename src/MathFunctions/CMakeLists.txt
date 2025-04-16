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
set_property(TARGET MathFunctions PROPERTY VERSION "1.0.0")
set_property(TARGET MathFunctions PROPERTY SOVERSION "1")

# install rules
set(installable_libs MathFunctions project_compiler_options)
# also add export configuration (MathFunctionsTargets.cmake)
install(TARGETS ${installable_libs}
        EXPORT MathFunctionsTargets
        DESTINATION lib
)
install(FILES MathFunctions.h DESTINATION include)
