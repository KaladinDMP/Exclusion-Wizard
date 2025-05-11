@echo off
setlocal enabledelayedexpansion

set "PARENT_PATH=%~1"

powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -Command "& { $parentFolder='%PARENT_PATH%'; Add-Type -AssemblyName Microsoft.VisualBasic; $folderName = [Microsoft.VisualBasic.Interaction]::InputBox('Enter name for the new excluded folder:', 'Create Excluded Subfolder', ''); if ($folderName.Trim() -ne '') { $newFolderPath = Join-Path $parentFolder $folderName.Trim(); try { New-Item -Path $newFolderPath -ItemType Directory -Force | Out-Null; Add-MpPreference -ExclusionPath $newFolderPath; Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Created and excluded folder:`n' + $newFolderPath, 'Success', 'OK', 'Information') } catch { Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Error creating folder:`n' + $_.Exception.Message, 'Error', 'OK', 'Error') } } }"