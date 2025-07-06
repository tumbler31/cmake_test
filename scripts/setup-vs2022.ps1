# MyProject Setup Script for Visual Studio 2022 (PowerShell)
$ErrorActionPreference = "Stop"

Write-Host "==============================="
Write-Host " MyProject VS2022 Bootstrapper"
Write-Host "===============================`n"

# 🛠 Configuration
$ProjectRoot   = Split-Path -Parent ../$MyInvocation.MyCommand.Definition
$VcpkgDir      = Join-Path $ProjectRoot "vcpkg"
$BuildDir      = Join-Path $ProjectRoot "build"
$Triplet       = "x64-windows"
$ToolchainFile = Join-Path $VcpkgDir "scripts/buildsystems/vcpkg.cmake"

# 🔍 Step 0: Ensure CMake is installed
function Install-CMakeIfMissing {
    if (!(Get-Command cmake -ErrorAction SilentlyContinue)) {
        Write-Host "[INFO] CMake not found. Download and installing it."
        Write-Host "[INFO] After CMake has been installed, please restart PowerShell for PATH changes to take effect and rerun the script."
        exit 0
    }
}

Install-CMakeIfMissing

# 🧹 Step 1: Fix broken or missing vcpkg submodule
function Fix-VcpkgSubmodule {
    if (!(Test-Path "$VcpkgDir\bootstrap-vcpkg.bat")) {
        Write-Host "[WARNING] Detected missing or broken vcpkg submodule. Reinitializing..."

        Push-Location $ProjectRoot
        git submodule deinit -f vcpkg
        git rm --cached vcpkg -q
        Remove-Item -Recurse -Force "$VcpkgDir" -ErrorAction Ignore
        Remove-Item -Recurse -Force "$ProjectRoot\.git\modules\vcpkg" -ErrorAction Ignore

        git submodule add https://github.com/microsoft/vcpkg.git vcpkg
        git submodule update --init --recursive
        Pop-Location

        if (!(Test-Path "$VcpkgDir\bootstrap-vcpkg.bat")) {
            Write-Error "❌ Failed to reinitialize vcpkg. Check your internet connection or .gitmodules config."
            exit 1
        }
    }
}

Fix-VcpkgSubmodule

# 🛠️ Step 2: Bootstrap vcpkg if needed
if (!(Test-Path "$VcpkgDir\vcpkg.exe")) {
    Write-Host "[INFO] Bootstrapping vcpkg..."
    Push-Location $VcpkgDir
    cmd /c bootstrap-vcpkg.bat
    Pop-Location
}

# 📦 Step 3: Install dependencies
Write-Host "[INFO] Installing dependencies from vcpkg.json..."
& "$VcpkgDir\vcpkg.exe" install --triplet $Triplet

# ⚙️ Step 4: Generate Visual Studio 2022 solution
Write-Host "[INFO] Generating Visual Studio project files..."
cmake -S "$ProjectRoot" -B "$BuildDir" `
    -G "Visual Studio 17 2022" `
    -DCMAKE_TOOLCHAIN_FILE="$ToolchainFile" `
    -DCMAKE_VCPKG_TARGET_TRIPLET=$Triplet `
    -DCMAKE_BUILD_TYPE=Release

Write-Host "`n✅ Done! You can now open '$BuildDir\MyProject.sln' in Visual Studio 2022."
