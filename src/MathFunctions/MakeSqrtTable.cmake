add_executable(MakeSqrtTable MakeSqrtTable.cpp)
target_link_libraries(MakeSqrtTable PRIVATE tutorial_compiler_flags)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/SqrtTable.h
    COMMAND MakeSqrtTable ${CMAKE_CURRENT_BINARY_DIR}/SqrtTable.h
    DEPENDS MakeSqrtTable
)