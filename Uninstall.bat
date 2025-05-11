@echo off
setlocal enabledelayedexpansion

echo ============================================
echo    Windows Defender Exclusion Wizard
echo         Uninstaller Script
echo ============================================
echo.

net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

set "INSTALL_DIR=%~dp0"
set "INSTALL_DIR=%INSTALL_DIR:~0,-1%"

echo Uninstalling Windows Defender Exclusion Manager...
echo.

echo Removing context menu entries...
reg delete "HKEY_CLASSES_ROOT\Directory\shell\AddToExclusions" /f 2>nul
if %errorlevel% EQU 0 (
    echo   - Removed "Add to Exclusions" entry
) else (
    echo   - "Add to Exclusions" entry not found
)

reg delete "HKEY_CLASSES_ROOT\Directory\shell\CreateExcludedSubfolder" /f 2>nul
if %errorlevel% EQU 0 (
    echo   - Removed "Create Excluded Subfolder" entry
) else (
    echo   - "Create Excluded Subfolder" entry not found
)

set "SCRIPTS_DIR=C:\Scripts"
set "BATCH_SCRIPT=%SCRIPTS_DIR%\ExclusionWizard.bat"

if exist "%BATCH_SCRIPT%" (
    echo.
    echo Removing batch script...
    del "%BATCH_SCRIPT%" 2>nul
    if %errorlevel% EQU 0 (
        echo   - Removed %BATCH_SCRIPT%
    ) else (
        echo   - Failed to remove %BATCH_SCRIPT%
    )
)


rmdir "%SCRIPTS_DIR%" 2>nul
	echo   - Removed %SCRIPTS_DIR%
	
set "REMOVE_REG=%INSTALL_DIR%\src\registry\remove-context-menu.reg"
if exist "%REMOVE_REG%" (
    echo.
    echo Applying removal registry file...
    regedit /s "%REMOVE_REG%"
)

echo.
echo ============================================
echo     Uninstallation Complete!
echo ============================================
echo.
echo All context menu entries have been removed.
echo.
echo You may need to restart Windows Explorer for changes to take effect.
echo (Or press Ctrl+Shift+Esc, find Windows Explorer, and click Restart)
echo.
pause