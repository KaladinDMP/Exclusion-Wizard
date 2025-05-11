# Changelog

All notable changes to this project will be documented in this file.

## [2.0.0] - 2025-05-10

### Added
- **Automated Installer**: New `install.bat` script that:
  - Automatically detects repository location
  - Copies files to appropriate directories
  - Configures registry entries with correct paths
  - Sets PowerShell execution policy
  - Requires only "Run as administrator"
- **Automated Uninstaller**: New `uninstall.bat` script that completely removes all components
- **Menu System**: New `main.bat` with interactive options for installation, uninstallation, and testing
- **Test Function**: Ability to create test folders for verifying context menu functionality

### Changed
- Installation process now much simpler - just right-click install.bat and "Run as administrator"
- Registry entries are dynamically generated based on file locations
- No more need to manually edit registry files for custom paths

### Notes
- This is a major update that simplifies the installation process significantly
- The manual installation method is still available for advanced users

## [1.1.0] - 2025-05-10

### Changed
- **Major Update**: Switched from PowerShell script to batch file wrapper for "Create Excluded Subfolder" functionality
- Improved path handling to fix issues with special characters and complex folder paths
- Registry file now calls `ExclusionWizard.bat` instead of PowerShell directly

### Added
- New `ExclusionWizard.bat` script with inline PowerShell commands
- Better error handling for path issues
- Optional debug logging in batch file (commented out by default)

### Fixed
- Resolved path passing issues from registry to script that caused folders to be created in wrong locations
- Improved compatibility with various Windows configurations
- Fixed issues with paths containing spaces or special characters

### Notes
- The original `CreateExcludedSubfolder.ps1` is kept for legacy purposes but is no longer used by default
- Users upgrading should replace their registry entries with the new version

## [1.0.0] - 2025-05-10

### Added
- Initial release
- "Add to Exclusions" context menu option
- "Create Excluded Subfolder" context menu option
- PowerShell script for creating excluded subfolders
- Registry files for easy installation
- Comprehensive documentation and troubleshooting guide