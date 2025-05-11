# Troubleshooting Guide

## Common Issues and Solutions

### Installer Issues

**Symptoms**: Install.bat fails or shows errors.

**Solutions**:
1. **Run as Administrator**: Ensure you right-click install.bat and select "Run as administrator"
2. **Check File Structure**: Verify the repository structure is intact (src/scripts/ and src/registry/ folders exist)
3. **Path Issues**: If the script can't find files, make sure you're running from the repository root
4. **Antivirus Interference**: Some antivirus software may block the installer

### Context Menu Items Not Appearing

**Symptoms**: Right-click menu doesn't show "Add to Exclusions" or "Create Excluded Subfolder" options.

**Solutions**:
1. **Verify Registry Merge**: Make sure you selected "Yes" when merging the .reg files
2. **Restart Explorer**: Press `Ctrl+Shift+Esc`, find "Windows Explorer" in Task Manager, right-click and "Restart"
3. **Reboot**: Sometimes a full restart is needed for registry changes to take effect
4. **Check Registry**: Open Registry Editor and verify these keys exist:
   - `HKEY_CLASSES_ROOT\Directory\shell\AddToExclusions`
   - `HKEY_CLASSES_ROOT\Directory\shell\CreateExcludedSubfolder`

### PowerShell Script Not Running

**Symptoms**: Context menu appears but clicking items does nothing or shows error.

**Solutions**:
1. **Check Script Location**: Ensure `ExclusionWizard.bat` is in `C:\Scripts\`
2. **Set Execution Policy**: 
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
   ```
3. **Manual Test**: Open PowerShell as admin and run:
   ```powershell
   C:\Scripts\ExclusionWizard.bat "C:\Test"
   ```
4. **Check Path in Registry**: Verify the script path in `add-create-excluded-subfolder.reg` matches your actual location

### Permission Denied Errors

**Symptoms**: "Access denied" or "Permission denied" messages when trying to add exclusions.

**Solutions**:
1. **Run as Administrator**: Right-click Windows Explorer and "Run as administrator"
2. **UAC Settings**: Lower UAC settings temporarily (not recommended for daily use)
3. **Group Policy**: Check if your organization restricts Windows Defender modifications
4. **Antivirus Conflict**: Some third-party antivirus may conflict with Windows Defender management

### Script Errors

**Symptoms**: PowerShell errors when creating excluded subfolders.

**Common Errors and Fixes**:

#### "Cannot bind argument to parameter 'Path'"
```powershell
# Problem: Invalid characters in folder name
# Solution: The script now automatically trims and validates input
```

#### "Item already exists"
```powershell
# Problem: Folder already exists
# Solution: Script uses -Force parameter to handle existing folders
```

#### "Add-MpPreference : Access denied"
```powershell
# Problem: Insufficient privileges
# Solution: Run as administrator or check Windows Security permissions
```

### Windows Defender Issues

**Symptoms**: Exclusions not working or getting removed.

**Solutions**:
1. **Windows Security App**: Check if exclusions are visible in Windows Security > Virus & threat protection > Exclusions
2. **Group Policy**: Enterprise environments may have policies that override exclusions
3. **Defender Updates**: Sometimes Windows updates reset exclusions
4. **Verify Exclusions**: Use PowerShell to list current exclusions:
   ```powershell
   Get-MpPreference | Select-Object -ExpandProperty ExclusionPath
   ```

### Debugging Steps

### Check Installer Success

1. **Registry Check**: Open Registry Editor and look for:
   - `HKEY_CLASSES_ROOT\Directory\shell\AddToExclusions`
   - `HKEY_CLASSES_ROOT\Directory\shell\CreateExcludedSubfolder`

2. **File Check**: Ensure `C:\Scripts\ExclusionWizard.bat` exists

3. **Run Test**: Use `ExclusionWizardMenu.bat` option 4 to create a test folder and verify context menu

### Manual Path Verification

### Enable PowerShell Logging

Create a debug version of the script:

```powershell
# Add this at the beginning of CreateExcludedSubfolder.ps1
Start-Transcript -Path "C:\Scripts\debug.log" -Append

# At the end of the script
Stop-Transcript
```

### Manual Testing

Test each component individually:

```powershell
# Test 1: Can you create a folder?
New-Item -Path "C:\Test\NewFolder" -ItemType Directory -Force

# Test 2: Can you add exclusions?
Add-MpPreference -ExclusionPath "C:\Test\NewFolder"

# Test 3: Can you list exclusions?
Get-MpPreference | Select-Object -ExpandProperty ExclusionPath
```

### Registry Verification

Manually check registry entries:

1. Open `regedit` as administrator
2. Navigate to `HKEY_CLASSES_ROOT\Directory\shell\`
3. Look for `AddToExclusions` and `CreateExcludedSubfolder` keys
4. Verify the command values are correct

## Getting Help

If you're still having issues:

1. **Check the documentation**: Review [INSTALLATION.md](INSTALLATION.md) for setup requirements
2. **Search existing issues**: Look through GitHub issues for similar problems
3. **Create a new issue**: Include:
   - Windows version
   - PowerShell version (`$PSVersionTable.PSVersion`)
   - Error messages (full text)
   - Steps you've already tried

## Safe Mode Recovery

If something goes wrong and you can't access your context menu:

1. Safe Mode: Boot into Safe Mode
2. Manual Registry Cleanup:
   ```reg
   reg delete "HKEY_CLASSES_ROOT\Directory\shell\AddToExclusions" /f
   reg delete "HKEY_CLASSES_ROOT\Directory\shell\CreateExcludedSubfolder" /f
   ```
3. Or use the provided `remove-context-menu.reg` file

## Prevention Tips

1. **Backup Registry**: Before making changes, export the registry keys:
   ```cmd
   reg export "HKEY_CLASSES_ROOT\Directory\shell" directory_shell_backup.reg
   ```

2. **Test in VM**: Try the tool in a virtual machine first

3. **Regular Updates**: Keep Windows and PowerShell updated

4. **Monitor Exclusions**: Periodically review your Windows Defender exclusions to ensure they're still needed