# BranchBox Homebrew Tap

Official Homebrew tap for [BranchBox](https://github.com/branchbox/branchbox) — parallel feature sandboxes for AI-assisted dev.

## Installation

Install BranchBox directly from this tap:

```bash
brew install branchbox/tap/branchbox
```

Or add the tap first, then install:

```bash
brew tap branchbox/tap
brew install branchbox
```

## Updating

To update BranchBox to the latest version:

```bash
brew update
brew upgrade branchbox
```

## Uninstalling

To remove BranchBox:

```bash
brew uninstall branchbox
```

To also remove the tap:

```bash
brew untap branchbox/tap
```

## Troubleshooting

### Architecture Issues

BranchBox automatically installs the correct version for your Mac:
- **Intel Macs**: `x86_64-apple-darwin`
- **Apple Silicon Macs**: `aarch64-apple-darwin`

To verify which version is installed:

```bash
file $(which branchbox)
```

### Checksum Mismatch

If you encounter checksum errors during installation, try:

```bash
brew update
brew reinstall branchbox
```

### Version Issues

To check your installed version:

```bash
branchbox --version
```

To see what versions are available:

```bash
brew info branchbox
```

### Reporting Issues

Please report issues to the appropriate repository:
- **BranchBox issues**: https://github.com/branchbox/branchbox/issues
- **Homebrew formula issues**: https://github.com/branchbox/homebrew-tap/issues

## Formula Maintenance

This tap is automatically updated when new versions of BranchBox are released. The formula is maintained by the BranchBox team and updated via GitHub Actions.

### For Contributors

If you're contributing to the formula:

1. Test your changes locally:
   ```bash
   brew audit --strict --online Formula/branchbox.rb
   brew install --build-from-source Formula/branchbox.rb
   ```

2. Verify the installation:
   ```bash
   branchbox --version
   ```

3. Clean up after testing:
   ```bash
   brew uninstall branchbox
   ```

## About BranchBox

BranchBox provides parallel feature sandboxes for AI-assisted development, helping teams manage and coordinate development environments across multiple machines and configurations.

Learn more at the [main repository](https://github.com/branchbox/branchbox).

## License

This Homebrew tap is released under the MIT License. See the [BranchBox repository](https://github.com/branchbox/branchbox) for the main project license.
