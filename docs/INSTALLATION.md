# Installation Guide

## Automated Installation (Recommended)

The easiest way to install Windows Defender Exclusion Wizard is using the automated installer:

### Quick Install Steps

1. Download or clone the repository
2. Double-click `Install.bat`
3. Wait for installation to complete
5. Start using the context menu options

### What the Installer Does

The `Install.bat` script automatically:
- Ensures you are running with admin permission
- Detects where you've placed the repository
- Creates `C:\Scripts\` directory if needed
- Copies `ExclusionWizard.bat` to the Scripts folder
- Generates custom registry entries with correct paths
- Imports the registry entries
- Sets PowerShell execution policy to RemoteSigned
- Provides success/error feedback

### Using the Menu System

For a guided experience, you can use `ExclusionWizardMenu.bat`:
- Run `ExclusionWizardMenu.bat` (no admin required for this step)
- Choose option 1 for automatic installation
- Choose option 2 for automatic uninstallation
- Choose option 3 for manual setup
- Choose option 4 to test the context menu

## Manual Installation (Advanced Users)

### 1. Download or Clone the Repository

```bash
git clone https://github.com/KaladinDMP/Exclusion-Wizard.git
```

Or download the ZIP file from GitHub and extract it.

### 2. Prepare the Batch Script

1. Navigate to `src/scripts/` folder
2. Copy `ExclusionWizard.bat` to `C:\Scripts\`
   - If `C:\Scripts\` doesn't exist, create it first
   - You may need administrator privileges to create this folder

### 3. Allow PowerShell Script Execution

Open PowerShell as Administrator and run:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
```

Choose `Y` when prompted. This allows locally created scripts to run.

### 4. Install Context Menu Entries

Navigate to `src/registry/` folder and install the registry entries:

#### For "Add to Exclusions" feature:
1. Right-click on `add-exclude-folder.reg`
2. Select "Merge"
3. Click "Yes" on the UAC prompt
4. Click "Yes" to merge the registry entry
5. Click "OK" on the success message

#### For "Create Excluded Subfolder" feature:
1. Right-click on `add-create-excluded-subfolder.reg`
2. Select "Merge"
3. Click "Yes" on the UAC prompt
4. Click "Yes" to merge the registry entry
5. Click "OK" on the success message

### 5. Verify Installation

1. Open File Explorer
2. Right-click on any folder
3. You should see:
   - "Add to Exclusions"
   - "Create Excluded Subfolder"

## Alternative Installation Methods

### Using Batch File

Create a batch file to install everything:

```batch
@echo off
echo Installing Windows Defender Exclusion Wizard...

:: Create Scripts directory if it doesn't exist
if not exist "C:\Scripts" mkdir "C:\Scripts"

:: Copy batch script
copy "src\scripts\ExclusionWizard.bat" "C:\Scripts\"

:: Set PowerShell execution policy
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope LocalMachine -Force"

:: Add registry entries
regedit /s "src\registry\add-exclude-folder.reg"
regedit /s "src\registry\add-create-excluded-subfolder.reg"

echo Installation complete!
pause
```

Save this as `Install.bat` and run as administrator.

### Custom Script Location

If you prefer to store the script elsewhere, modify the registry file:

1. Open `add-create-excluded-subfolder.reg` in a text editor
2. Change the path in this line:
   ```reg
   @="\"C:\\Scripts\\ExclusionWizard.bat\" \"%1\""
   ```
3. Replace `C:\\Scripts\\` with your preferred location (remember to double the backslashes)

## Post-Installation

### Testing

1. Create a test folder on your desktop
2. Right-click it and select "Add to Exclusions"
3. You should see a success message
4. Right-click again and select "Create Excluded Subfolder"
5. Enter a name and verify both actions work

### Verification

To verify a folder is excluded from Windows Defender:

1. Open Windows Security (Windows Defender)
2. Go to "Virus & threat protection"
3. Click "Manage settings" under "Virus & threat protection settings"
4. Scroll down to "Exclusions" and click "Add or remove exclusions"
5. Your excluded folders should be listed here

## Uninstallation

To remove all context menu entries:

1. Navigate to `src/registry/`
2. Right-click on `remove-context-menu.reg`
3. Select "Merge"
4. Click "Yes" to all prompts
5. Delete `C:\Scripts\ExclusionWizard.bat`
6. Restart Windows Explorer or reboot your computer