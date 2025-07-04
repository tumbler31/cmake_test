@echo off
setlocal

REM === Configuration ===
set PROJECT_ROOT=%~dp0
set VCPKG_DIR=%PROJECT_ROOT%vcpkg
set BUILD_DIR=%PROJECT_ROOT%build
set TRIPLET=x64-windows

REM === Bootstrap vcpkg (if needed) ===
if not exist "%VCPKG_DIR%\vcpkg.exe" (
    echo [INFO] Bootstrapping vcpkg...
    call "%VCPKG_DIR%\bootstrap-vcpkg.bat"
)

REM === Install dependencies via vcpkg.json (manifest mode) ===
echo [INFO] Installing dependencies from vcpkg.json...
"%VCPKG_DIR%\vcpkg.exe" install --triplet %TRIPLET%

REM === Generate Visual Studio 2022 project files ===
echo [INFO] Generating Visual Studio 2022 project files...
cmake -S "%PROJECT_ROOT%" -B "%BUILD_DIR%" ^
    -G "Visual Studio 17 2022" ^
    -DCMAKE_TOOLCHAIN_FILE="%VCPKG_DIR%\scripts\buildsystems\vcpkg.cmake" ^
    -DCMAKE_VCPKG_TARGET_TRIPLET=%TRIPLET% ^
    -DCMAKE_BUILD_TYPE=Release

echo.
echo ✅ Done! Open build\MyProject.sln in Visual Studio 2022
