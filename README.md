# (Windows Defender) Exclusion Wizard

A convenient set of Windows Explorer context menu extensions for managing Windows Defender exclusions directly from the right-click menu.

![Windows Context Menu](https://github.com/user-attachments/assets/daa6034b-c6b5-4f64-a565-15bccf54ff9c)

## Features

- **Quick Exclusion**: Right-click any folder to add it to Windows Defender exclusions
- **Create Excluded Subfolder**: Create a new subfolder and automatically exclude it from Windows Defender scanning
- **Automated Installation**: One-click installer that configures everything automatically
- **Easy Uninstallation**: Complete removal with one script
- **Menu-Driven Interface**: User-friendly main.bat for all operations
- **Portable**: Works from any location, detects paths automatically

## Requirements

- Windows 10/11
- PowerShell 5.0 or higher (recommend 7.0)
- Administrator privileges (for modifying Windows Defender settings)

## Quick Start

### 🚀 Automated Installation (Recommended)

1. Download the repository or clone it:
   ```bash
   git clone https://github.com/KaladinDMP/Exclusion-Wizard.git
   ```

2. Run the installer:
   - Double click `Install.bat`
   - The installer will automatically:
     - Copy files to the correct location
     - Create necessary directories
     - Configure registry entries
     - Set PowerShell execution policy

3. Start using:
   - Right-click any folder and select "Add to Exclusions"
   - Right-click any folder and select "Create Excluded Subfolder"

### 📋 Alternative: Use the Menu System

- Run `WizardExclusionMenu.bat` for a menu-driven interface
- Choose Install, Uninstall, or Manual Setup options

### 🔧 Manual Installation (Advanced Users)

For those who prefer manual setup:
1. Copy `src/scripts/ExclusionWizard.bat` to your preferred location (e.g., `C:\Scripts\`)
2. Edit the registry files to match your script location
3. Right-click on both registry files and select "Merge"

## What's Included

### Context Menu Options

#### 1. Add to Exclusions
- Instantly adds the selected folder to Windows Defender exclusions
- Shows confirmation message
- No user input required
- Uses PowerShell directly from registry

#### 2. Create Excluded Subfolder
- Uses a reliable batch file wrapper for better path handling
- Prompts for new folder name
- Creates the folder inside the selected directory
- Automatically adds it to Windows Defender exclusions
- Perfect for organizing projects with excluded dependencies
- Works with complex folder paths and special characters

## Installation Methods

### 1. Automated Installation (Recommended)
- **Install.bat**: Automatically detects paths, copies files, and configures registry
- **Uninstall.bat**: Completely removes all components
- **ExclusionWizardMenu.bat**: Interactive menu for installation/uninstallation options

### 2. Manual Installation
- Copy files manually
- Edit registry files with custom paths
- Import registry files

See [docs/installation.md](docs/installation.md) for detailed instructions.

## Troubleshooting

Having issues? Check [docs/troubleshooting.md](docs/troubleshooting.md) for solutions to common problems.

## Uninstallation

To remove all context menu entries:
1. Right-click on `src/registry/remove-context-menu.reg`
2. Select "Merge"
3. Restart Windows Explorer or reboot

## Security Note

This tool requires administrator privileges to modify Windows Defender settings. Always be cautious about what you exclude from antivirus scanning. Only exclude trusted folders and applications.

## Contributing

Feel free to submit issues, fork the repository, and create pull requests for any improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This tool modifies Windows Defender settings. Use at your own risk. Always ensure you're excluding only trusted content from antivirus scanning.

## Acknowledgments

- Microsoft for Windows Defender and PowerShell
- Community feedback and contributions

---

Made with ❤️ for Windows power users