@echo off
setlocal enabledelayedexpansion

:menu
cls
echo ============================================
echo    Windows Defender Exclusion Wizard
echo ============================================
echo.
echo Please select an option:
echo.
echo 1. Install (Automatic Setup)
echo 2. Uninstall (Remove All)
echo 3. Manual Setup (Open Directory)
echo 4. Test Context Menu
echo 5. Exit
echo.
echo ============================================
choice /C 12345 /N /M "Enter your choice (1-5): "

if errorlevel 5 goto :end
if errorlevel 4 goto :test
if errorlevel 3 goto :manual
if errorlevel 2 goto :uninstall
if errorlevel 1 goto :install

:install
echo.
echo Starting automatic installation...
call install.bat
goto :menu

:uninstall
echo.
echo Starting automatic uninstallation...
call uninstall.bat
goto :menu

:manual
echo.
echo Opening installation directory...
explorer "%~dp0"
echo.
echo For manual setup:
echo 1. Copy files manually
echo 2. Edit registry files as needed
echo 3. Import registry files
PAUSE
goto :menu

:test
echo.
echo Creating test folder...
echo Right-click on the TestContextMenu folder to test context menu options.
echo.
set "TEST_FOLDER=%USERPROFILE%\Desktop\TestContextMenu"
mkdir "%TEST_FOLDER%" 2>nul
explorer "%USERPROFILE%\Desktop"
echo.
echo Press any key to remove the test folder and return to menu...
pause >nul
echo.
echo Removing test folder...
rmdir /s /q "%TEST_FOLDER%" 2>nul
if exist "%TEST_FOLDER%" (
    echo Warning: Could not remove test folder. Please delete manually.
) else (
    echo Test folder removed successfully.
)
echo.
pause
goto :menu

:end
echo.
echo Thank you for using Windows Defender Exclusion Wizard!
exit /b 0