$ErrorActionPreference = "Stop"
Write-Host "Setting up Visual Studio 2022 solution for MyProject"

$ProjectRoot = Resolve-Path "$PSScriptRoot\.."
$Preset = "vs2022-release"

# Step 1: Bootstrap vcpkg
& "$PSScriptRoot\bootstrap-vcpkg.ps1"

# Step 2: Generate solution with CMake preset
Write-Host "Running cmake --preset $Preset"
Push-Location $ProjectRoot
cmake --preset $Preset
Pop-Location

# Step 3: Done
$SlnPath = Join-Path "$ProjectRoot\build" "myproject.sln"
if (Test-Path $SlnPath) {
    Write-Host "Solution generated at: $SlnPath"
}
else {
    Write-Warning "Solution not found. Check configuration output."
}
