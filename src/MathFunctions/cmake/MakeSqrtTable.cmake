add_executable(MakeSqrtTable MakeSqrtTable.cpp)
target_link_libraries(MakeSqrtTable PRIVATE project_compiler_options)

# add the custom command to generate SqrtTable.h
add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/SqrtTable.h
    COMMAND MakeSqrtTable ${CMAKE_CURRENT_BINARY_DIR}/SqrtTable.h
    DEPENDS MakeSqrtTable
)
