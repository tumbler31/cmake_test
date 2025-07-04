# 🚀 MyProject Setup Guide (Visual Studio 2022)

Welcome! This guide helps you get started with building the project using Visual Studio 2022, CMake, and `vcpkg`.



---

## 📦 Prerequisites

Make sure the following are installed before continuing:

1. **Microsoft Visual Studio 2022**  
   Ensure the Desktop development with C++ workload is enabled.

2. **CMake (version 3.21 or higher recommended)**  
   Download the latest stable release here:  
   [CMake Windows Installer](https://github.com/Kitware/CMake/releases/download/v4.0.3/cmake-4.0.3-windows-x86_64.msi)

---

## ⚙️ Usage

To configure the project and install dependencies:

1. Open **PowerShell**
2. Navigate to the root of the project
3. Run:

   ```powershell
   .\setup-vs2022.ps1
4. The .sln solution file will be found in the build/folder