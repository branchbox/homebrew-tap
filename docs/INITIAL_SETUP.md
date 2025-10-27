# Initial Homebrew Formula Setup

Quick reference for setting up the Homebrew formula with your first release.

## Before First Release

Ensure your release workflow creates these macOS artifacts:
- `branchbox-{VERSION}-x86_64-apple-darwin.tar.gz` (Intel)
- `branchbox-{VERSION}-aarch64-apple-darwin.tar.gz` (Apple Silicon)
- `checksums.txt` (SHA256 hashes for all artifacts)

## Step 1: Get Checksums from Release

After publishing your first release (e.g., v0.2.0):

```bash
# Download the checksums file
curl -L https://github.com/branchbox/branchbox/releases/download/v0.2.0/checksums.txt

# Extract the macOS checksums
grep "x86_64-apple-darwin" checksums.txt
grep "aarch64-apple-darwin" checksums.txt
```

You'll see output like:
```
1a2b3c4d5e6f...  branchbox-0.2.0-x86_64-apple-darwin.tar.gz
9z8y7x6w5v4u...  branchbox-0.2.0-aarch64-apple-darwin.tar.gz
```

## Step 2: Update Formula

Clone the tap and edit the formula:

```bash
git clone https://github.com/branchbox/homebrew-tap
cd homebrew-tap
```

Edit `Formula/branchbox.rb` and replace:
- `CHECKSUM_INTEL` with the Intel checksum (line 10)
- `CHECKSUM_ARM` with the ARM checksum (line 13)

Example:
```ruby
sha256 "1a2b3c4d5e6f..."  # Intel
sha256 "9z8y7x6w5v4u..."  # ARM
```

## Step 3: Test Formula

```bash
# Audit for errors
brew audit --strict Formula/branchbox.rb

# Test installation
brew tap branchbox/tap ./
brew install branchbox

# Verify
branchbox --version

# Cleanup
brew uninstall branchbox
brew untap branchbox/tap
```

## Step 4: Commit and Push

```bash
git add Formula/branchbox.rb
git commit -m "chore: add checksums for v0.2.0 release"
git push
```

## Step 5: Setup Automation

Now that the formula works, set up automation for future releases:

1. **Create Personal Access Token**: https://github.com/settings/tokens/new
   - Scope: `repo`
   - Note: "Homebrew Tap Updates"

2. **Add Secret to Main Repo**:
   - Go to: Settings > Secrets and variables > Actions
   - Name: `HOMEBREW_TAP_TOKEN`
   - Value: (paste token)

3. **Add Workflow**: Follow instructions in `docs/HOMEBREW_AUTOMATION.md`

## Verification

Test the full installation flow:

```bash
# Fresh install
brew tap branchbox/tap
brew install branchbox
branchbox --version

# Update (after a new release)
brew update
brew upgrade branchbox
```

## Troubleshooting

**Error: "SHA256 mismatch"**
- Double-check you copied the full checksum (64 characters)
- Verify you're using the correct checksum for each architecture
- Make sure the release version matches (v0.2.0 in formula and release)

**Error: "Failed to download"**
- Check the release assets exist at the URL in the formula
- Verify the filenames match exactly
- Ensure the release is published (not draft)

**Error: "Binary not found"**
- Check your tar.gz contains `branchbox` binary at the root
- Run: `tar -tzf branchbox-0.2.0-x86_64-apple-darwin.tar.gz`
- Binary should be listed without subdirectories

## Next Steps

After initial setup:
- ✅ Formula works with real checksums
- ✅ Users can install via Homebrew
- ⏭️ Set up automation for future releases (see HOMEBREW_AUTOMATION.md)
- ⏭️ Update main repo README with installation instructions
- ⏭️ Announce Homebrew availability to users

## Example: Complete Formula

```ruby
class Branchbox < Formula
  desc "Parallel feature sandboxes for AI-assisted development"
  homepage "https://github.com/branchbox/branchbox"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/branchbox/branchbox/releases/download/v0.2.0/branchbox-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "1a2b3c4d5e6f7890abcdef1234567890abcdef1234567890abcdef1234567890"
    elsif Hardware::CPU.arm?
      url "https://github.com/branchbox/branchbox/releases/download/v0.2.0/branchbox-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "9z8y7x6w5v4u3210fedcba0987654321fedcba0987654321fedcba0987654321"
    end
  end

  def install
    bin.install "branchbox"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/branchbox --version")
  end
end
```
