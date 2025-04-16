include(cmake/AppConfig.cmake)

# executable target
add_executable(Tutorial Tutorial.cpp)

if(DEFINED CMAKE_DEBUG_POSTFIX)
    set_target_properties(Tutorial
        PROPERTIES
            DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX}
    )
endif()

# use an option to decide which sqrt function is used
option(USE_MYMATH "Use tutorial provided math implementation" ON)
if(USE_MYMATH)
    # use this command instead of #cmakedefine
    target_compile_definitions(Tutorial PRIVATE "USE_MYMATH")
    add_subdirectory(MathFunctions)
    list(APPEND EXTRA_LIBS MathFunctions)
endif()

# require header AppConfig.h to build the target
target_include_directories(Tutorial
    PRIVATE
        "${CMAKE_CURRENT_BINARY_DIR}"
)

target_link_libraries(Tutorial
    PRIVATE
        ${EXTRA_LIBS}
        project_compiler_options
)

# run install commands from the build directory
# the --prefix option specifies the root path of the install location
# cmake --install . --prefix "/home/atoz/installdir/"
# or overwrite cache variable CMAKE_INSTALL_PREFIX
install(TARGETS Tutorial DESTINATION bin)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/AppConfig.h"
    DESTINATION include
)
