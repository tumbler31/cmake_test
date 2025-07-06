cmake_minimum_required(VERSION 3.21)
project(Logs)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(MY_LIBRARY_TARGET Logger)

# GLOB all source and header files
file(GLOB LOGGER_SOURCES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
)

file(GLOB LOGGER_HEADERS CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/*.h"
)

# Add the static library target
add_library(${MY_LIBRARY_TARGET} STATIC
    ${LOGGER_SOURCES}
    ${LOGGER_HEADERS}  # Optional, not strictly needed for build, but makes IDEs happy
)

# Expose only the public header to consumers
target_include_directories(${MY_LIBRARY_TARGET}
    PUBLIC  ${CMAKE_CURRENT_SOURCE_DIR}
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Link with dependencies
find_package(spdlog REQUIRED)
target_link_libraries(${MY_LIBRARY_TARGET} PRIVATE fmt::fmt spdlog::spdlog)

