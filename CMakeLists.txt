cmake_minimum_required(VERSION 3.21)
project(MyProject CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# ADD THE ACTUAL SUBPROJECT DIRECTORIES HERE
add_subdirectory(applications)
add_subdirectory(modules)

