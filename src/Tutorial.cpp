// A simple program that computes the square root of a number
#include <cmath>
#include <iostream>
#include <string>

#include "AppConfig.h"

#ifdef USE_MYMATH
#include "MathFunctions.h"
#endif

#include "spdlog/spdlog.h"

int main(int argc, char *argv[])
{
    spdlog::info("Welcome to spdlog version {}.{}.{}", SPDLOG_VER_MAJOR, SPDLOG_VER_MINOR, SPDLOG_VER_PATCH);

    if (argc < 2)
    {
        std::cout << argv[0] << " Version: "
                  << PROJECT_VERSION_MAJOR << "." << PROJECT_VERSION_MINOR
                  << std::endl;
        std::cout << "Usage: " << argv[0] << " number"
                  << std::endl;
        return EXIT_FAILURE;
    }

    // convert input to double - requires c++11 and above
    const double inputValue = std::stod(argv[1]);

    // calculate square root
    #ifdef USE_MYMATH
        const double outputValue = mathfunctions::sqrt(inputValue);
    #else
        const double outputValue = std::sqrt(inputValue);
    #endif

    std::cout << "The square root of " << inputValue << " is " << outputValue
              << std::endl;
    return EXIT_SUCCESS;
}
