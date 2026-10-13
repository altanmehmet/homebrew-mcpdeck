class Mcpdeck < Formula
  desc "Manage MCP servers and global instructions across coding agents"
  homepage "https://github.com/altanmehmet/mcpdeck"
  version "0.1.0-alpha.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.7/mcpdeck-darwin-arm64.tar.gz"
      sha256 "a87a74478b8264d63656cf11eb59f356c8c8e2af1f901d23abab276944e0a1bd"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.7/mcpdeck-darwin-amd64.tar.gz"
      sha256 "6e33a13ceaad2d4749ae741cb855bf07c978fbd69a36fdc039b82383b3ee0fc2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.7/mcpdeck-linux-arm64.tar.gz"
      sha256 "e09a7df573dfd759c0fc71f961f002c97262c018c3bf5ea5d60cf9b74390061e"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.7/mcpdeck-linux-amd64.tar.gz"
      sha256 "d3f953eafc3e8f587255537c100f1dea1ce982d1587bfe44ed187d70797bad17"
    end
  end

  def install
    bin.install "mcpdeck"
    doc.install "README.txt", "AKILLI-KURULUM.md", "INSTRUCTIONS.md", "RECOVERY.md"
    prefix.install "LICENSE", "THIRD_PARTY_NOTICES.txt"
  end

  test do
    assert_match "0.1.0-alpha.7", shell_output("#{bin}/mcpdeck --version")
    assert_match "Manage MCP servers", shell_output("#{bin}/mcpdeck --help")
  end
end
