class Branchbox < Formula
  desc "Parallel feature sandboxes for AI-assisted development"
  homepage "https://github.com/branchbox/branchbox"
  version "0.10.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "e3beb48fce72c3f9e7f8cb4cafba80fac8b975872087adecb0d86028a9ac4528"
    end
    on_arm do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "f632bb9f98ef9791388b40fb0b516efcfb7b05642212eaa74df0eca6234a9bd7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "85009bd97f673d3e399928492b0b9004e0984e8ed1faa30258f19a5f4d57f506"
    end
    on_arm do
      url "https://github.com/branchbox/branchbox/releases/download/v#{version}/branchbox-#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "65d82f0cb1436fb00041c41149e7715b262ae12622346f0e97d675f8a4ec1fd9"
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
