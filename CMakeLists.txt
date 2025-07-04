cmake_minimum_required(VERSION 3.21)
project(MyProject)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add main target
add_executable(MyApp src/main.cpp)

# Link with vcpkg-installed packages
find_package(fmt REQUIRED)
find_package(spdlog REQUIRED)

target_link_libraries(MyApp PRIVATE fmt::fmt spdlog::spdlog)
