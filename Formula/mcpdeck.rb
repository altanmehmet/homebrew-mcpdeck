class Mcpdeck < Formula
  desc "Manage MCP servers and global instructions across coding agents"
  homepage "https://github.com/altanmehmet/mcpdeck"
  version "0.1.0-alpha.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.8/mcpdeck-darwin-arm64.tar.gz"
      sha256 "8bb67230a82645f90d8d27bc112390b02f9f7df9b8f03b2553dfa7da31ff72c6"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.8/mcpdeck-darwin-amd64.tar.gz"
      sha256 "f370077e1fe8af826e832bd0022fbaf29575e2a251d6758cf6a2884f63754f90"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.8/mcpdeck-linux-arm64.tar.gz"
      sha256 "9a7822c6f81e8c59398e65722a44b7e62cf8936c91bd5afc9570f0d79193995a"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.8/mcpdeck-linux-amd64.tar.gz"
      sha256 "719240f5192c036b814000c556020678fa9bd6bbf9372dc67723853db635d585"
    end
  end

  def install
    bin.install "mcpdeck"
    doc.install "README.txt", "AKILLI-KURULUM.md", "INSTRUCTIONS.md", "RECOVERY.md"
    prefix.install "LICENSE", "THIRD_PARTY_NOTICES.txt"
  end

  test do
    assert_match "0.1.0-alpha.8", shell_output("#{bin}/mcpdeck --version")
    assert_match "Manage MCP servers", shell_output("#{bin}/mcpdeck --help")
  end
end
