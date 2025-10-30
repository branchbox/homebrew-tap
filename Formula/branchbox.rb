class Branchbox < Formula
  desc "Parallel feature sandboxes for AI-assisted development"
  homepage "https://github.com/branchbox/branchbox"
  version "v0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/branchbox/branchbox/releases/download/vv0.1.1/branchbox-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "0874b711cb4a85cfaa71e93deb6baab5dd049bc6588f66c7e87320ad77f04b33"
    elsif Hardware::CPU.arm?
      url "https://github.com/branchbox/branchbox/releases/download/vv0.1.1/branchbox-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "2ad620b1a30ee5108c68909cd6ad225ba21bf46e74d48e86c7ad2c6e7a6cc04a"
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
