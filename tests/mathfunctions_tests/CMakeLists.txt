add_executable(MathFunctionsTests sqrt_tests.cpp)

target_link_libraries(MathFunctionsTests
    PRIVATE
        MathFunctions
        Catch2::Catch2WithMain
)

catch_discover_tests(MathFunctionsTests)
