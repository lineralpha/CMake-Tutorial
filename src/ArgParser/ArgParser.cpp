#include <iostream>

#include "TutorialConfig.h"
#include "include/ArgParse.h"

bool parse_args(int argc, char* argv[]) {
    if (argc < 2) {
        std::cout << argv[0] << " Version: "
                  << Tutorial_VERSION_MAJOR << "." << Tutorial_VERSION_MINOR
                  << std::endl;
        std::cout << "Usage: " << argv[0] << " number"
                  << std::endl;
        return false;
    }

    return true;
}
