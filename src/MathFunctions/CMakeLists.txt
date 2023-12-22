# generate SqrtTable.h which is required by MathFunctions
include(MakeSqrtTable.cmake)

add_library(MathFunctions MathFunctions.cpp mysqrt.cpp SqrtTable.h)

# state that anybody linking to us needs to include the current source dir;
# while MathFunctions itself doesn't
target_include_directories(MathFunctions
        INTERFACE 
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
        $<INSTALL_INTERFACE:include>)

# include(CheckCXXSourceCompiles)
# check_cxx_source_compiles("
#     #include <cmath>
#     int main() {
#         std::log(1.0);
#         return 0;
#     }
# " HAVE_LOG)
# check_cxx_source_compiles("
#     #include <cmath>
#     int main() {
#         std::exp(1.0);
#         return 0;
#     }
# " HAVE_EXP)

unset(HAVE_EXP)
unset(HAVE_LOG)

# if(HAVE_LOG AND HAVE_EXP)
#     target_compile_definitions(MathFunctions PRIVATE "HAVE_LOG" "HAVE_EXP")
# endif()


target_include_directories(MathFunctions PRIVATE "${CMAKE_CURRENT_BINARY_DIR}")
target_link_libraries(MathFunctions PUBLIC tutorial_compiler_flags)

# setup the version numbering
set_property(TARGET MathFunctions PROPERTY VERSION "1.0.0")
set_property(TARGET MathFunctions PROPERTY SOVERSION "1")

# install rules
set(installable_libs MathFunctions tutorial_compiler_flags)
# also add export configuration (MathFunctionsTargets.cmake)
install(TARGETS ${installable_libs} 
        EXPORT MathFunctionsTargets
        DESTINATION lib)
install(FILES MathFunctions.h DESTINATION include)
