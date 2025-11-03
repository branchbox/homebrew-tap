class Branchbox < Formula
  desc "Parallel feature sandboxes for AI-assisted development"
  homepage "https://github.com/branchbox/branchbox"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/branchbox/branchbox/releases/download/v0.2.0/branchbox-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "fe30c8045e5318f1f4b66e053c69491867f26f2249c54ef246623070d15fa78e"
    elsif Hardware::CPU.arm?
      url "https://github.com/branchbox/branchbox/releases/download/v0.2.0/branchbox-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "ffcf0d75266d5497677631aa7587467aa74fd053ad9f1c0cbf679ed00e333c9c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/branchbox/branchbox/releases/download/v0.2.0/branchbox-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e308a5d1caf252f6fe3bbc667801261dea953194ea6edae86575962d70580f95"
    elsif Hardware::CPU.arm?
      url "https://github.com/branchbox/branchbox/releases/download/v0.2.0/branchbox-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f66716c8f74c3ea605a519335383bb68104f8c6ad8938881cdfd091e210f0ec5"
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
