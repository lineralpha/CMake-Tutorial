#include <catch2/catch_test_macros.hpp>

#include "MathFunctions.h"

TEST_CASE("Sqrt(144) is 12", "[single-file]") {
    REQUIRE(mathfunctions::sqrt(144) == 12);
}
