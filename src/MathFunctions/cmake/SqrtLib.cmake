include(cmake/CheckStandardLibrary.cmake)

# build the sub library (SqrtTable.h must be explicitly listed here)
add_library(SqrtLib STATIC mysqrt.cpp SqrtTable.h)

Check_Standard_Library(HAVE_LOG HAVE_EXP)
message(STATUS "HAVE_LOG: ${HAVE_LOG}, and HAVE_EXP: ${HAVE_EXP}")

# unset(HAVE_LOG)
# unset(HAVE_EXP)

if(HAVE_LOG AND HAVE_EXP)
    target_compile_definitions(SqrtLib PRIVATE "HAVE_LOG" "HAVE_EXP")
endif()

# to include SqrtTable.h
target_include_directories(SqrtLib
    INTERFACE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    PRIVATE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
)

# requires PIC because consuming lib is SHARED
set_target_properties(SqrtLib
    PROPERTIES
        POSITION_INDEPENDENT_CODE ON
)

target_link_libraries(SqrtLib PRIVATE project_compiler_options)
