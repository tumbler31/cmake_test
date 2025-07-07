cmake_minimum_required(VERSION 3.21)
project(MyProject)

add_executable(MyApp
    src/main.cpp
)

# Link with vcpkg-installed packages and modules
find_package(fmt REQUIRED)
target_link_libraries(MyApp PRIVATE fmt::fmt Logger)


