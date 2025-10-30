class Branchbox < Formula
  desc "Parallel feature sandboxes for AI-assisted development"
  homepage "https://github.com/branchbox/branchbox"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/branchbox/branchbox/releases/download/v0.1.1/branchbox-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "95d72cd6cab5f821c0a4aeaec22ed3b4357389438600d379f31015d4f0efb7a3"
    elsif Hardware::CPU.arm?
      url "https://github.com/branchbox/branchbox/releases/download/v0.1.1/branchbox-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "419ae577f314e14c8730b8450913ecfceaa781a9109731aceca6866a59a6d0ee"
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
