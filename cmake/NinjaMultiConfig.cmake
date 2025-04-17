if(CMAKE_GENERATOR STREQUAL "Ninja Multi-Config")
    message(STATUS "Using Ninja Multi-Config generator")

    # optional - ensure build config options are visible to the user
    set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)

    # optional - set default build config if none is given;
    # defaults to the first item from CMAKE_CONFIGURATION_TYPES if not set
    if(NOT DEFINED CMAKE_DEFAULT_BUILD_TYPE)
        set(CMAKE_DEFAULT_BUILD_TYPE "Debug" CACHE STRING "Default build type" FORCE)
    endif()
endif()
