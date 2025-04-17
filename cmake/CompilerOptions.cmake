add_library(project_compiler_options INTERFACE)

set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")

# use c++17 standard
target_compile_features(project_compiler_options INTERFACE cxx_std_17)

# specify compiler warning flags when building this project through
# BUILD_INTERFACE generator expression
target_compile_options(project_compiler_options
    INTERFACE
        "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
)

target_compile_definitions(project_compiler_options
    INTERFACE
        $<$<CONFIG:Debug>:DEBUG>
        $<$<CONFIG:Release>:NDEBUG>
)
