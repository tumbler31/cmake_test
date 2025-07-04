cmake_minimum_required(VERSION 3.21)

include(FetchContent)

# Step 1: Make sure vcpkg exists
if(NOT EXISTS "${CMAKE_SOURCE_DIR}/vcpkg")
  message(STATUS "Cloning vcpkg...")
  execute_process(COMMAND git clone https://github.com/microsoft/vcpkg.git "${CMAKE_SOURCE_DIR}/vcpkg")
endif()

# Step 2: Bootstrap it
if(NOT EXISTS "${CMAKE_SOURCE_DIR}/vcpkg/vcpkg")
  message(STATUS "Bootstrapping vcpkg...")
  execute_process(COMMAND ${CMAKE_COMMAND} -E chdir "${CMAKE_SOURCE_DIR}/vcpkg" ./bootstrap-vcpkg.sh RESULT_VARIABLE res)
  if(NOT res EQUAL 0)
    message(FATAL_ERROR "vcpkg bootstrap failed")
  endif()
endif()

# Step 3: Run CMake with toolchain
set(VCPKG_TOOLCHAIN "${CMAKE_SOURCE_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake")
message(STATUS "Configuring project using ${VCPKG_TOOLCHAIN}")

execute_process(COMMAND ${CMAKE_COMMAND}
    -S "${CMAKE_SOURCE_DIR}"
    -B "${CMAKE_SOURCE_DIR}/build"
    -DCMAKE_TOOLCHAIN_FILE=${VCPKG_TOOLCHAIN}
    -DCMAKE_BUILD_TYPE=Release
    RESULT_VARIABLE cmake_result
)
if(NOT cmake_result EQUAL 0)
    message(FATAL_ERROR "CMake configuration failed")
endif()

message(STATUS "Project successfully configured with vcpkg")
