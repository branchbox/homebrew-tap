class Branchbox < Formula
  desc "Parallel feature sandboxes for AI-assisted development"
  homepage "https://github.com/branchbox/branchbox"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "ac48a16cbe18a4133b91d8a32587d1514a8c2e43e1d63c529764e8ead46ab3d4"
    end
    on_arm do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "974ec7f876cae8c3e381c33b43f92298e8e7f2a07bf756c44ddc21f30ddc2a03"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0881d2697d1d675297d11ae856812cdecc3a8c3b3797a4f4c30ebb10bd3d4b1a"
    end
    on_arm do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a338f5fdb9769e50edaef3a6b69fced48402630ce8f7036d0a07a57d7dc7591d"
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
