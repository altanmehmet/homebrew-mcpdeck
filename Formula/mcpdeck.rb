class Mcpdeck < Formula
  desc "Manage MCP servers and global instructions across coding agents"
  homepage "https://github.com/altanmehmet/mcpdeck"
  version "0.1.0-alpha.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.6/mcpdeck-darwin-arm64.tar.gz"
      sha256 "d4a0e2e1d08d9527e9d5b95158f15f4ecfd9073c52a7ba3cfba475113940e419"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.6/mcpdeck-darwin-amd64.tar.gz"
      sha256 "fbb5f33a7494c1850fc640ab3996b54f35b3ecedd692f6e4187366ec8efad6f1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.6/mcpdeck-linux-arm64.tar.gz"
      sha256 "de00a1b3d7be1825d7aea2218d3f60ec219db7ce79481572a6fcc27657f1058d"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.6/mcpdeck-linux-amd64.tar.gz"
      sha256 "64af6a43b49111d8f3e80680e470c8592e37875414ae39b2ee42a78fedd144f8"
    end
  end

  def install
    bin.install "mcpdeck"
    doc.install "README.txt", "AKILLI-KURULUM.md", "INSTRUCTIONS.md", "RECOVERY.md"
    prefix.install "LICENSE", "THIRD_PARTY_NOTICES.txt"
  end

  test do
    assert_match "0.1.0-alpha.6", shell_output("#{bin}/mcpdeck --version")
    assert_match "Manage MCP servers", shell_output("#{bin}/mcpdeck --help")
  end
end
