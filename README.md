# CMake-Tutorial
Learn CMake by following https://github.com/Kitware/CMake/tree/master/Help/guide/tutorial

## CMake project fundamentals
- cmake_minimum_required()
- project()
- add_executable() / add_library()

### Build
- cd to the build folder: <code>cd build</code>
- run
    ```
    cmake ../src -DUSE_MYMATH=ON -DCMAKE_BUILD_TYPE=Debug
    cmake --build .
    ```

### Install locally
- cd to the build folder, use <code>--prefix</code> to specify the root path of install location:
    ```
    cmake --install . --prefix ~/installdir
    ```

### CTest
- The simplest way to run tests is <code>ctest</code> :  
    ```
    ctest -N
    ctest -V
    ```

### CPack
- run cpack command from the build directory:
    ```
    cpack
    cpack -G ZIP -C Release
    ```
- to archive the source tree:
    ```
    cpack --config CPackSourceConfig.cmake
    ```
- to pack both debug and release together:
    ```
    cpack --config ../src/MultiCPackConfig.cmake
    ```

## CMake Tools
### Select a CMake kit
Command: <code>CMake:Select a Kit</code>

A kit is a toolchain - a set of compilers, linkers, or other tools that will be used to build your project. CMake Tools automatically scan the system and detect available toolchains.

A project can define/provide additioal kits via its own <code>cmake-kits.json</code> file.

### Select variant
Command: <code>CMake:Select a Variant</code>

CMake Tools variants are more than CMake build types (CMAKE_BUILD_TYPE). A project can provide a custom cmake-variants.json / cmake-variants.yaml file for [additional variants](https://vector-of-bool.github.io/docs/vscode-cmake-tools/variants.html#what-does-it-look-like).

### Configure project
Command: <code>CMake:Configure</code>

This runs CMake configure process, as well as populating the CMake Tools sidebar panel (Project Status).