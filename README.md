# CMake-Tutorial
Learn CMake by following https://github.com/Kitware/CMake/tree/master/Help/guide/tutorial

## Tools and VS Code extensions

The following linux packages are required:

- git
- build-essential
- gdb
- cmake
- cmake-qt-gui
- ninja

VS Code extensions:

- `.vscode/extensions.json`

## CMake project fundamentals

A very basic project contains these three lines in its `CMakeLists.txt` file:

```cmake
cmake_minimum_required(VERSION 3.28.0)
project(Tutorial VERSION 1.0)
add_executable(Tutorial tutorial.cpp)
```

### Configure

```
cmake --preset debug
```

### Build

```
cmake --build --preset debug
```

### CPack

```
cpack --preset
```

to pack source tree (run from build tree):

```
cpack --config CPackSourceConfig.cmake
```

### Install locally
- run from build tree:

    ```
    cmake --build . --config Debug --target install
    ```

### CTest

- The simplest way to run tests are (run from build tree):
    ```
    ctest -N  # list all tests
    ctest -V
    ctest --preset debug
    ```

## CMake Tools

### Select a CMake kit

Command: `CMake:Select a Kit`

A kit is a toolchain - a set of compilers, linkers, or other tools that will be used to build your project. CMake Tools automatically scan the system and detect available toolchains.

A project can define/provide additional kits via its own `cmake-kits.json` file.

### Select variant

Command: `CMake:Select a Variant`

CMake Tools variants are more than CMake build types (CMAKE_BUILD_TYPE). A project can provide a custom cmake-variants.json / cmake-variants.yaml file for [additional variants][1].

### Configure project

Command: `CMake:Configure`

This runs CMake configure process, as well as populating the CMake Tools sidebar panel (Project Status).


[1]: https://vector-of-bool.github.io/docs/vscode-cmake-tools/variants.html#what-does-it-look-like
