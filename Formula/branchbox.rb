class Branchbox < Formula
  desc "Parallel feature sandboxes for AI-assisted development"
  homepage "https://github.com/branchbox/branchbox"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/branchbox/branchbox/releases/download/v0.1.0/branchbox-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "9584e6a3cbe435558e1d104c1b66b9cfcfccddf29c3e6e3262e393704cd2ff05"
    elsif Hardware::CPU.arm?
      url "https://github.com/branchbox/branchbox/releases/download/v0.1.0/branchbox-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "3869b746a4ba95bd3caed86263965c74c9190bc6951da565808fdd07f93bb1dc"
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
