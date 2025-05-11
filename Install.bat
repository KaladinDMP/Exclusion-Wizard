@echo off
setlocal enabledelayedexpansion

:: Check for admin privileges and relaunch if needed
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo ============================================
echo    Windows Defender Exclusion Wizard
echo       Simple Installation Script
echo ============================================
echo.

set "INSTALL_DIR=%~dp0"
set "INSTALL_DIR=%INSTALL_DIR:~0,-1%"

echo Installation directory: %INSTALL_DIR%
echo.

:: Set file paths
set "BATCH_SCRIPT=%INSTALL_DIR%\src\scripts\ExclusionWizard.bat"
set "REG_FILE1=%INSTALL_DIR%\src\registry\add-exclude-folder.reg"
set "REG_FILE2=%INSTALL_DIR%\src\registry\add-create-excluded-subfolder.reg"

:: Check if files exist
if not exist "%BATCH_SCRIPT%" (
    echo ERROR: Cannot find %BATCH_SCRIPT%
    pause
    exit /b 1
)

if not exist "%REG_FILE1%" (
    echo ERROR: Cannot find %REG_FILE1%
    pause
    exit /b 1
)

if not exist "%REG_FILE2%" (
    echo ERROR: Cannot find %REG_FILE2%
    pause
    exit /b 1
)

:: Create Scripts directory if needed
set "SCRIPTS_DIR=C:\Scripts"
if not exist "%SCRIPTS_DIR%" (
    echo Creating directory: %SCRIPTS_DIR%
    mkdir "%SCRIPTS_DIR%" 2>nul
)

:: Copy the batch script
echo.
echo Copying ExclusionWizard.bat to %SCRIPTS_DIR%...
copy /Y "%BATCH_SCRIPT%" "%SCRIPTS_DIR%\" >nul
if %errorlevel% NEQ 0 (
    echo ERROR: Failed to copy batch script!
    pause
    exit /b 1
)

:: Import registry files directly (like you do manually)
echo.
echo Installing registry entries...
echo   - Importing add-exclude-folder.reg...
regedit /s "%REG_FILE1%"
echo   - Importing add-create-excluded-subfolder.reg...
regedit /s "%REG_FILE2%"

:: Set PowerShell execution policy
echo.
echo Setting PowerShell execution policy...
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope LocalMachine -Force" 2>nul

:: Success message
echo.
echo ============================================
echo     Installation Complete!
echo ============================================
echo.
echo Both context menu options should now be available:
echo   - Add to Exclusions
echo   - Create Excluded Subfolder
echo.
echo Try right-clicking on a folder to test.
echo.
echo Note: You may need to restart Windows Explorer (Ctrl+Shift+Esc)
echo.
pause