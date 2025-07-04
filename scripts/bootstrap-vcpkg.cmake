cmake_minimum_required(VERSION 3.21)

# Optional: let user override triplet from command line or environment
if(NOT DEFINED CMAKE_VCPKG_TARGET_TRIPLET)
    if(DEFINED ENV{CMAKE_VCPKG_TARGET_TRIPLET})
        set(CMAKE_VCPKG_TARGET_TRIPLET "$ENV{CMAKE_VCPKG_TARGET_TRIPLET}")
    else()
        # Fallback default (adjust to your platform)
        if(WIN32)
            set(CMAKE_VCPKG_TARGET_TRIPLET "x64-windows")
        elseif(UNIX)
            set(CMAKE_VCPKG_TARGET_TRIPLET "x64-linux")
        endif()
    endif()
endif()

# Path to vcpkg and toolchain
set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/vcpkg")
set(TOOLCHAIN_FILE "${VCPKG_DIR}/scripts/buildsystems/vcpkg.cmake")
set(BUILD_DIR "${CMAKE_SOURCE_DIR}/build")

# Clone vcpkg if needed
if(NOT EXISTS "${VCPKG_DIR}/.git")
    message(STATUS "Cloning vcpkg...")
    execute_process(COMMAND git clone https://github.com/microsoft/vcpkg.git "${VCPKG_DIR}")
endif()

# Bootstrap vcpkg
if(WIN32)
    set(BOOTSTRAP "${VCPKG_DIR}/bootstrap-vcpkg.bat")
else()
    set(BOOTSTRAP "${VCPKG_DIR}/bootstrap-vcpkg.sh")
endif()

if(NOT EXISTS "${VCPKG_DIR}/vcpkg" AND NOT EXISTS "${VCPKG_DIR}/vcpkg.exe")
    message(STATUS "Bootstrapping vcpkg...")
    execute_process(
        COMMAND ${BOOTSTRAP}
        WORKING_DIRECTORY "${VCPKG_DIR}"
        RESULT_VARIABLE bootstrap_result
        SHELL TRUE
    )
    if(NOT bootstrap_result EQUAL 0)
        message(FATAL_ERROR "Bootstrap failed.")
    endif()
endif()

# Install dependencies from manifest file using triplet
message(STATUS "Installing vcpkg dependencies for triplet: ${CMAKE_VCPKG_TARGET_TRIPLET}")
execute_process(
    COMMAND ${VCPKG_DIR}/vcpkg install --triplet ${CMAKE_VCPKG_TARGET_TRIPLET}
    WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
    RESULT_VARIABLE install_result
    SHELL TRUE
)
if(NOT install_result EQUAL 0)
    message(FATAL_ERROR "vcpkg install failed")
endif()

# Configure project with dynamic triplet
execute_process(
    COMMAND ${CMAKE_COMMAND}
        -S "${CMAKE_SOURCE_DIR}"
        -B "${BUILD_DIR}"
        -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE}"
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_VCPKG_TARGET_TRIPLET="${CMAKE_VCPKG_TARGET_TRIPLET}"
    RESULT_VARIABLE cmake_result
)
if(NOT cmake_result EQUAL 0)
    message(FATAL_ERROR "CMake configuration failed")
endif()

message(STATUS "✅ Bootstrapped and configured with triplet: ${CMAKE_VCPKG_TARGET_TRIPLET}")
