$VcpkgDir = Join-Path $PSScriptRoot "..\external\vcpkg"

if (!(Test-Path "$VcpkgDir\vcpkg.exe")) {
    git clone https://github.com/microsoft/vcpkg.git $VcpkgDir
    & "$VcpkgDir\bootstrap-vcpkg.bat"
}
