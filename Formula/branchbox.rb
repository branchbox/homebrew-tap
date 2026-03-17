class Branchbox < Formula
  desc "Parallel feature sandboxes for AI-assisted development"
  homepage "https://github.com/branchbox/branchbox"
  version "0.10.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "f98cf3e44ce3b72c0cbd6baee7f56de1565d5fe34e81bd3c07f29fa000f25928"
    end
    on_arm do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "9314b9cc7d573e16d2bdfbb7f11d23febab69a3e467d5887b7bcfb5114cd6e24"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6d6e2005c63d1011e4403e5dd22eef42bb2980864947bf4cef57cbf75fca1c54"
    end
    on_arm do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "55822c46351c2a3ad92f42383d8577581bed6292cc14671d1140f915dc39888f"
    end
  end

  def install
    bin.install "branchbox", "bb"
    # Future: Install shell completions
    # bash_completion.install "completions/branchbox.bash"
    # zsh_completion.install "completions/branchbox.zsh"
    # fish_completion.install "completions/branchbox.fish"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/branchbox --version")
  end
end
