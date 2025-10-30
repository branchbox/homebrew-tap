class Branchbox < Formula
  desc "Parallel feature sandboxes for AI-assisted development"
  homepage "https://github.com/branchbox/branchbox"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/branchbox/branchbox/releases/download/v0.1.1/branchbox-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "f5bed4a2afb1f7af3ac0e3693d9b261db9a0478dba2d574babf9e6326341b54a"
    elsif Hardware::CPU.arm?
      url "https://github.com/branchbox/branchbox/releases/download/v0.1.1/branchbox-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "cc96f345603109ca02172a047ad849d8ba849debecb59b3bb0c954582ceb0366"
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
