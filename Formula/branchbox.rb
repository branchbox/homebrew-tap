class Branchbox < Formula
  desc "Parallel feature sandboxes for AI-assisted development"
  homepage "https://github.com/branchbox/branchbox"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/branchbox/branchbox/releases/download/v0.2.0/branchbox-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "CHECKSUM_INTEL"
    elsif Hardware::CPU.arm?
      url "https://github.com/branchbox/branchbox/releases/download/v0.2.0/branchbox-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "CHECKSUM_ARM"
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
