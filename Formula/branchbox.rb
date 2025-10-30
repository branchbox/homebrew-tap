class Branchbox < Formula
  desc "Parallel feature sandboxes for AI-assisted development"
  homepage "https://github.com/branchbox/branchbox"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/branchbox/branchbox/releases/download/v0.1.1/branchbox-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "e1b386139ada2bd1d6d62da089f776cf3a991fea2843e51a75d78540f38389db"
    elsif Hardware::CPU.arm?
      url "https://github.com/branchbox/branchbox/releases/download/v0.1.1/branchbox-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "83b8aa502737a2acec30ec8b43f51b91c6e616e393c3c76f1082a24efe86eb2a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/branchbox/branchbox/releases/download/v0.1.1/branchbox-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ae2fc9411de4614de2f6132aa417a8865c2a4397e754c5cc5acf8110b2b66a74"
    elsif Hardware::CPU.arm?
      url "https://github.com/branchbox/branchbox/releases/download/v0.1.1/branchbox-0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "06ef8a0f71ece938f1e9a4e313304f79b521288c5cdc4dde1a67102b10887d16"
    end
  end

  def install
    bin.install "branchbox"

    # Future: Install shell completions
    # bash_completion.install "completions/branchbox.bash"
    # zsh_completion.install "completions/branchbox.zsh"
    # fish_completion.install "completions/branchbox.fish"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/branchbox --version")
  end
end
