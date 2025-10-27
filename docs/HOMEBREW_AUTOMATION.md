# Homebrew Tap Automation Guide

This document provides instructions for integrating automated Homebrew formula updates into your release workflow.

## Overview

When you publish a new release, the workflow will automatically:
1. Download the macOS binary checksums from GitHub Releases
2. Update the Homebrew formula with the new version and checksums
3. Commit and push the changes to the `homebrew-tap` repository

## Prerequisites

- [x] Homebrew tap repository exists at `github.com/branchbox/homebrew-tap`
- [x] Formula file exists at `Formula/branchbox.rb`
- [ ] macOS binaries are published to GitHub Releases as:
  - `branchbox-{VERSION}-x86_64-apple-darwin.tar.gz`
  - `branchbox-{VERSION}-aarch64-apple-darwin.tar.gz`
- [ ] A `checksums.txt` file is published with each release containing SHA256 hashes

## Setup Instructions

### Step 1: Create GitHub Personal Access Token

1. Go to https://github.com/settings/tokens/new
2. Configure the token:
   - **Note**: `Homebrew Tap Updates`
   - **Expiration**: 1 year (or your preferred duration)
   - **Scopes**: Select `repo` (full control of private repositories)
3. Click "Generate token"
4. **Copy the token immediately** (you won't see it again)

### Step 2: Add Token to Repository Secrets

1. Go to your main repository settings
2. Navigate to **Settings > Secrets and variables > Actions**
3. Click **New repository secret**
4. Add the secret:
   - **Name**: `HOMEBREW_TAP_TOKEN`
   - **Value**: Paste the token from Step 1
5. Click **Add secret**

### Step 3: Add Workflow Job to Release Pipeline

Add this job to your `.github/workflows/release.yml` file:

```yaml
update-homebrew:
  name: Update Homebrew Formula
  needs: [create-release, build-release, publish-release]  # Adjust based on your job names
  runs-on: ubuntu-latest
  if: ${{ !contains(github.ref, 'rc') && !contains(github.ref, 'beta') }}  # Only for stable releases

  steps:
    - name: Checkout homebrew-tap repo
      uses: actions/checkout@v4
      with:
        repository: branchbox/homebrew-tap
        token: ${{ secrets.HOMEBREW_TAP_TOKEN }}
        path: homebrew-tap

    - name: Extract version from tag
      id: version
      run: |
        VERSION="${GITHUB_REF#refs/tags/v}"
        echo "version=$VERSION" >> $GITHUB_OUTPUT

    - name: Download checksums
      run: |
        VERSION="${{ steps.version.outputs.version }}"
        curl -fsSL "https://github.com/branchbox/branchbox/releases/download/v$VERSION/checksums.txt" -o checksums.txt

    - name: Extract checksums for macOS binaries
      id: checksums
      run: |
        INTEL_CHECKSUM=$(grep "x86_64-apple-darwin" checksums.txt | awk '{print $1}')
        ARM_CHECKSUM=$(grep "aarch64-apple-darwin" checksums.txt | awk '{print $1}')

        echo "intel=$INTEL_CHECKSUM" >> $GITHUB_OUTPUT
        echo "arm=$ARM_CHECKSUM" >> $GITHUB_OUTPUT

        echo "Intel checksum: $INTEL_CHECKSUM"
        echo "ARM checksum: $ARM_CHECKSUM"

    - name: Update formula
      run: |
        VERSION="${{ steps.version.outputs.version }}"
        cd homebrew-tap/Formula

        # Update version
        sed -i 's/version ".*"/version "'$VERSION'"/' branchbox.rb

        # Update Intel URL and checksum
        sed -i 's|url "https://github.com/branchbox/branchbox/releases/download/v.*/branchbox-.*-x86_64-apple-darwin.tar.gz"|url "https://github.com/branchbox/branchbox/releases/download/v'$VERSION'/branchbox-'$VERSION'-x86_64-apple-darwin.tar.gz"|' branchbox.rb
        sed -i '/Hardware::CPU.intel?/,/sha256/ s/sha256 ".*"/sha256 "'${{ steps.checksums.outputs.intel }}'"/' branchbox.rb

        # Update ARM URL and checksum
        sed -i 's|url "https://github.com/branchbox/branchbox/releases/download/v.*/branchbox-.*-aarch64-apple-darwin.tar.gz"|url "https://github.com/branchbox/branchbox/releases/download/v'$VERSION'/branchbox-'$VERSION'-aarch64-apple-darwin.tar.gz"|' branchbox.rb
        sed -i '/Hardware::CPU.arm?/,/sha256/ s/sha256 ".*"/sha256 "'${{ steps.checksums.outputs.arm }}'"/' branchbox.rb

    - name: Commit and push changes
      run: |
        cd homebrew-tap
        git config user.name "github-actions[bot]"
        git config user.email "github-actions[bot]@users.noreply.github.com"
        git add Formula/branchbox.rb
        git diff --cached --exit-code || (
          git commit -m "chore: update formula to v${{ steps.version.outputs.version }}"
          git push
        )
```

### Step 4: Adjust Job Dependencies

Make sure the `needs:` field references the correct job names from your workflow. The Homebrew update should run after:
- Release is created
- Binaries are built
- Assets are uploaded to GitHub Releases

Common job name patterns:
```yaml
needs: [create-release, build, upload-assets]
needs: [release, build-release, publish-release]
needs: [publish]
```

## Checksums File Format

Your release workflow should generate a `checksums.txt` file with this format:

```
abc123...  branchbox-0.2.0-x86_64-apple-darwin.tar.gz
def456...  branchbox-0.2.0-aarch64-apple-darwin.tar.gz
```

### Example: Generating Checksums

If you're using `cargo-dist`, it should generate this automatically. Otherwise, add this to your release workflow:

```yaml
- name: Generate checksums
  run: |
    cd dist/
    sha256sum *.tar.gz > checksums.txt

- name: Upload checksums
  uses: softprops/action-gh-release@v1
  with:
    files: dist/checksums.txt
```

## Testing

### Test the Workflow

1. Create a test release (or re-run your existing release workflow)
2. Check the Actions tab for the `update-homebrew` job
3. Verify the homebrew-tap repository was updated
4. Test installation:
   ```bash
   brew tap branchbox/tap
   brew install branchbox
   branchbox --version
   ```

### Troubleshooting

**Error: "Could not read from remote repository"**
- Check that `HOMEBREW_TAP_TOKEN` secret is set correctly
- Verify the token has `repo` scope
- Check token hasn't expired

**Error: "checksums.txt not found"**
- Verify checksums file is uploaded to GitHub Releases
- Check the filename matches exactly: `checksums.txt`
- Ensure this job runs after the publish/upload job

**Formula update fails**
- Check the sed commands match your formula structure
- Verify the version pattern in the formula matches expectations
- Review the job logs for the specific error

**Wrong checksums extracted**
- Verify your checksums.txt contains the exact filenames
- Check for extra spaces or formatting issues
- Test the grep/awk commands locally with your checksums.txt

## Manual Formula Update

If you need to update the formula manually:

```bash
# Clone the tap
git clone https://github.com/branchbox/homebrew-tap
cd homebrew-tap

# Edit Formula/branchbox.rb
# Update version, URLs, and sha256 checksums

# Test it
brew audit --strict Formula/branchbox.rb
brew install --build-from-source Formula/branchbox.rb

# Commit and push
git add Formula/branchbox.rb
git commit -m "chore: update formula to v0.3.0"
git push
```

## Security Notes

- The `HOMEBREW_TAP_TOKEN` has write access to your homebrew-tap repository
- Store it as a GitHub Actions secret, never commit it
- Use a fine-grained token with minimal permissions if possible
- Rotate the token periodically (GitHub will warn before expiration)
- Consider using a bot account instead of a personal token

## References

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Creating and Maintaining a Tap](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
- [GitHub Actions Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)

## Support

For issues with:
- **Formula bugs**: Open an issue in `branchbox/homebrew-tap`
- **Automation workflow**: Open an issue in `branchbox/branchbox`
- **Installation problems**: Check the tap README troubleshooting section
