class Mcpdeck < Formula
  desc "Manage MCP servers and global instructions across coding agents"
  homepage "https://github.com/altanmehmet/mcpdeck"
  version "0.1.0-alpha.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.3/mcpdeck-darwin-arm64.tar.gz"
      sha256 "cbf48607300f63c74a204e6710db71635f5d555400a34e0c9a4ffa16a9318eb3"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.3/mcpdeck-darwin-amd64.tar.gz"
      sha256 "9b8e9c2b563dda8b181d3e0c533ab9cd5fa3ad83b7f1ff00458292cfcb8a0820"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.3/mcpdeck-linux-arm64.tar.gz"
      sha256 "0fb4d0e8aa52470bed6ee77b1fcf69d33f4ef6a5c9356e6881498832166fd715"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.3/mcpdeck-linux-amd64.tar.gz"
      sha256 "8256bd47c7e19d34a66791f782bd6ca827c5404625cd526d9b9f8b4b3dc0b5f0"
    end
  end

  def install
    bin.install "mcpdeck"
    doc.install "README.txt", "AKILLI-KURULUM.md", "INSTRUCTIONS.md", "RECOVERY.md"
    prefix.install "LICENSE", "THIRD_PARTY_NOTICES.txt"
  end

  test do
    assert_match "0.1.0-alpha.3", shell_output("#{bin}/mcpdeck --version")
    assert_match "Manage MCP servers", shell_output("#{bin}/mcpdeck --help")
  end
end
