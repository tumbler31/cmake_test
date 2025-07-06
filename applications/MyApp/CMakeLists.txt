cmake_minimum_required(VERSION 3.21)
project(MyProject)

add_executable(MyApp
    src/main.cpp
)

# Link with vcpkg-installed packages and modules
find_package(fmt REQUIRED)
target_link_libraries(MyApp PRIVATE fmt::fmt Logger)

target_include_directories(MyApp PRIVATE
    ${CMAKE_SOURCE_DIR}/modules
)

# Set the startup project to your chosen target
set(MY_LAUNCH_TARGET MyApp)
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${MY_LAUNCH_TARGET})

