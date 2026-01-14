class Branchbox < Formula
  desc "Parallel feature sandboxes for AI-assisted development"
  homepage "https://github.com/branchbox/branchbox"
  version "0.7.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "dbfbcd6b3a219d5f8dd939739bf0491e1c7ee3335d6fb830b6c7d69688f4b8ee"
    end
    on_arm do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "70ca6b00bba46fc9ef43ca356efaaf1f3a462488c5b355a3a858873df748e8ce"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a14c0be5d63733df22012e0be586032442400d63fea3f47e9c933208b210445f"
    end
    on_arm do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b6b36b61ff0c79f7d3f33b81c777ed402d4e2bb52227a1cf5b0ef450abfa1c20"
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
