#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PRESET="linux-release"

# Bootstrap vcpkg if needed
if [ ! -f "$PROJECT_ROOT/external/vcpkg/vcpkg" ]; then
    echo "Bootstrapping vcpkg..."
    git clone https://github.com/microsoft/vcpkg.git "$PROJECT_ROOT/external/vcpkg"
    "$PROJECT_ROOT/external/vcpkg/bootstrap-vcpkg.sh"
fi

# Run CMake using presets (note: must run from root where the JSON lives)
pushd "$PROJECT_ROOT" > /dev/null
cmake --preset "$PRESET"
popd > /dev/null
