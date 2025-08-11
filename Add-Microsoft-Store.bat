@echo off


setlocal enabledelayedexpansion


:: Check for admin rights by running a privileged command
net session >nul 2>&1
if %errorlevel% neq 0 goto :not_admin


:: This code runs ONLY if the script is an administrator
echo Running as Administrator.


set "PScommand=PowerShell -NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass"


echo.
powershell.exe -Command "Write-Host 'Script Made by czvv' -ForegroundColor Black -BackgroundColor White"
echo.


set "has_error=0"


if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
  set ARCH=x64
  ) else (
  set ARCH=x86
)


echo.
powershell.exe -Command "Write-Host 'To prevent errors, please close all other applications and keep only the CMD window open.' -ForegroundColor Yellow"
echo.

echo.
choice /c YN /m "Did you close all apps?"
echo.


if %errorlevel% equ 2 goto :cancel


echo.
powershell.exe -Command "Write-Host 'Stopping related processes to prevent errors.' -ForegroundColor DarkYellow"
1>nul 2>nul powershell.exe %PScommand% -Command "Get-Process | Where-Object { $_.Path -like 'C:\Program Files\WindowsApps\*' } | Stop-Process -Force"
1>nul 2>nul powershell.exe %PScommand% -Command "Stop-Process -Name 'backgroundTaskHost' -Force"
1>nul 2>nul powershell.exe %PScommand% -Command "Stop-Process -Name 'RuntimeBroker' -Force"
1>nul 2>nul powershell.exe %PScommand% -Command "Stop-Process -Name 'dllhost' -Force"
1>nul 2>nul powershell.exe %PScommand% -Command "Stop-Process -Name 'WindowsTerminal' -Force"
1>nul 2>nul powershell.exe %PScommand% -Command "Stop-Process -Name 'msedgewebview2' -Force"
1>nul 2>nul powershell.exe %PScommand% -Command "Stop-Process -Name 'Widgets' -Force"
1>nul 2>nul powershell.exe %PScommand% -Command "Stop-Process -Name 'WidgetService' -Force"
echo.


echo.
powershell.exe -Command "Write-Host 'Detected Architecture: %ARCH%' -ForegroundColor Blue"
echo.


echo.
powershell.exe -Command "Write-Host 'Installing %ARCH% packages...' -ForegroundColor DarkGray"
echo.


:: Adding Microsoft .NET Native Framework
echo.
powershell.exe -Command "Write-Host 'Adding Microsoft .NET Native Framework' -ForegroundColor Magenta"
echo.

for /f %%i in ('dir /s /b "%~dp0*NET.Native.Framework*%ARCH%*.Appx"') do (
  
  powershell.exe %PScommand% -Command "Add-AppxPackage -Path '%%i'"

  if !errorlevel! neq 0 (
    powershell.exe %PScommand% -Command "Write-Host 'An error occurred during the operation for %%i.' -ForegroundColor Red"
    set "has_error=1"
    ) else (
    powershell.exe %PScommand% -Command "Write-Host 'Successfully Installed Microsoft .NET Native Framework.' -ForegroundColor Green"
  )
  
)


:: Adding Microsoft .NET Native Runtime
echo.
powershell.exe -Command "Write-Host 'Adding Microsoft .NET Native Runtime' -ForegroundColor Magenta"
echo.

for /f %%i in ('dir /s /b "%~dp0*NET.Native.Runtime*%ARCH%*.Appx"') do (
  
  powershell.exe %PScommand% -Command "Add-AppxPackage -Path '%%i'"

  if !errorlevel! neq 0 (
    powershell.exe %PScommand% -Command "Write-Host 'An error occurred during the operation for %%i.' -ForegroundColor Red"
    set "has_error=1"
    ) else (
    powershell.exe %PScommand% -Command "Write-Host 'Successfully Installed Microsoft .NET Native Runtime.' -ForegroundColor Green"
  )
  
)


:: Adding Microsoft VCLibs 140.00 UWP Desktop
echo.
powershell.exe -Command "Write-Host 'Adding Microsoft VCLibs 140.00 UWP Desktop' -ForegroundColor Magenta"
echo.

for /f %%i in ('dir /s /b "%~dp0*VCLibs.140.00.UWPDesktop*%ARCH%*.Appx"') do (
  
  powershell.exe %PScommand% -Command "Add-AppxPackage -Path '%%i'"

  if !errorlevel! neq 0 (
    powershell.exe %PScommand% -Command "Write-Host 'An error occurred during the operation for %%i.' -ForegroundColor Red"
    set "has_error=1"
    ) else (
    powershell.exe %PScommand% -Command "Write-Host 'Successfully Installed Microsoft VCLibs 140.00 UWP Desktop.' -ForegroundColor Green"
  )
  
)


:: Adding Microsoft Visual C++ 2015-2019 UWP Desktop Runtime
echo.
powershell.exe -Command "Write-Host 'Adding Microsoft Visual C++ 2015-2019 UWP Desktop Runtime' -ForegroundColor Magenta"
echo.

for /f %%i in ('dir /s /b "%~dp0*VCLibs.140.00*%ARCH%*.Appx"') do (
  
  powershell.exe %PScommand% -Command "Add-AppxPackage -Path '%%i'"

  if !errorlevel! neq 0 (
    powershell.exe %PScommand% -Command "Write-Host 'An error occurred during the operation for %%i.' -ForegroundColor Red"
    set "has_error=1"
    ) else (
    powershell.exe %PScommand% -Command "Write-Host 'Successfully Installed Microsoft Visual C++ 2015-2019 UWP Desktop Runtime.' -ForegroundColor Green"
  )
  
)


:: Adding Microsoft UI Xaml
echo.
powershell.exe -Command "Write-Host 'Adding Microsoft UI Xaml' -ForegroundColor Magenta"
echo.

for /f %%i in ('dir /s /b "%~dp0*UI.Xaml*%ARCH%*.Appx"') do (
  
  powershell.exe %PScommand% -Command "Add-AppxPackage -Path '%%i'"

  if !errorlevel! neq 0 (
    powershell.exe %PScommand% -Command "Write-Host 'An error occurred during the operation for %%i.' -ForegroundColor Red"
    set "has_error=1"
    ) else (
    powershell.exe %PScommand% -Command "Write-Host 'Successfully Installed Microsoft UI Xaml.' -ForegroundColor Green"
  )
  
)


:: Adding Microsoft DesktopAppInstaller
echo.
powershell.exe -Command "Write-Host 'Adding Microsoft DesktopAppInstaller' -ForegroundColor Magenta"
echo.

%PScommand% -Command "try { Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile '%~dp0Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' -TimeoutSec 10; exit 0 } catch { exit 1 }"

if exist "%~dp0Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" (

    %PScommand% -Command "Add-AppxPackage -Path '%~dp0Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'"
    
     powershell.exe %PScommand% -Command "Write-Host 'Successfully Installed Microsoft DesktopAppInstaller.' -ForegroundColor Green"

    ) else (
    
    echo ERROR: Failed to download Microsoft.DesktopAppInstaller
    pause
    
    exit /b 1
)


:: Adding Microsoft Store Purchase App
echo.
powershell.exe -Command "Write-Host 'Adding Microsoft Store Purchase App' -ForegroundColor Magenta"
echo.

for /f %%i in ('dir /s /b "%~dp0*StorePurchaseApp*.AppxBundle"') do (
  
  powershell.exe %PScommand% -Command "Add-AppxPackage -Path '%%i'"
  
  if !errorlevel! neq 0 (
    powershell.exe %PScommand% -Command "Write-Host 'An error occurred during the operation for %%i.' -ForegroundColor Red"
    set "has_error=1"
    ) else (
    powershell.exe %PScommand% -Command "Write-Host 'Successfully Installed Microsoft Store Purchase App.' -ForegroundColor Green"
  )
  
)


:: Adding Microsoft Store
echo.
powershell.exe -Command "Write-Host 'Adding Microsoft Store' -ForegroundColor Magenta"
echo.

for /f %%i in ('dir /s /b "%~dp0*WindowsStore*.Msixbundle"') do (
  
  powershell.exe %PScommand% -Command "Add-AppxPackage -Path '%%i'"
  
  if !errorlevel! neq 0 (
    powershell.exe %PScommand% -Command "Write-Host 'An error occurred during the operation for %%i.' -ForegroundColor Red"
    set "has_error=1"
    ) else (
    powershell.exe %PScommand% -Command "Write-Host 'Successfully Installed Microsoft Store.' -ForegroundColor Green"
  )
  
)


echo.
powershell.exe -Command "Write-Host 'Done.' -ForegroundColor Green"
echo.


endlocal


echo.
echo Press any Key to Exit.
pause >nul
exit


:cancel
:: This part of the script only runs if the user presses 'N'
echo.
powershell.exe %PScommand% -Command "Write-Host 'Operation cancelled by user.' -ForegroundColor Red"
echo.
pause
exit /b 1


:not_admin
:: This code runs ONLY if the script is NOT an administrator
echo  Not running as Administrator.
echo Please restart the script with "Run as administrator".
pause