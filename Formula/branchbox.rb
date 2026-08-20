class Branchbox < Formula
  desc "Parallel feature sandboxes for AI-assisted development"
  homepage "https://github.com/branchbox/branchbox"
  version "0.12.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "1b27578b1fa41e5129a174b8f42beb5f3f557fe7b1d774cf90443dbb1e778f52"
    end
    on_arm do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "9abb54c941e256ee703b86519c6a93cc9011b4c3035b4e4b4cf7050076d3d6c3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d8b3cc4ea64ab28de6d4589a563f0ea5dd041934652d3a9cf7d54ab582be0e7f"
    end
    on_arm do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4663981a948202b21477d56742830364e7d92a7d2ace1c045dbe92890d91be8e"
    end
  end

  def install
    bin.install "branchbox", "bb", "branchbox-local-vm"
    # Future: Install shell completions
    # bash_completion.install "completions/branchbox.bash"
    # zsh_completion.install "completions/branchbox.zsh"
    # fish_completion.install "completions/branchbox.fish"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/branchbox --version")
  end
end
