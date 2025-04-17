
add_executable(MyTest mytest.cpp)

message(STATUS "Unit tests using Catch2")

target_link_libraries(MyTest PRIVATE Catch2::Catch2WithMain)

catch_discover_tests(MyTest)
