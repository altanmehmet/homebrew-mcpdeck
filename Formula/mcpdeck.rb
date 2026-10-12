class Mcpdeck < Formula
  desc "Manage MCP servers and global instructions across coding agents"
  homepage "https://github.com/altanmehmet/mcpdeck"
  version "0.1.0-alpha.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.5/mcpdeck-darwin-arm64.tar.gz"
      sha256 "0fbdf4ae85604e8b6e0463693f40aa472ba8ffb65f0f32fcc7be75500a0f5aa0"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.5/mcpdeck-darwin-amd64.tar.gz"
      sha256 "9ac72d98625493a173f25d567f67198b7b355a6074e02043f3f2d59af1005701"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.5/mcpdeck-linux-arm64.tar.gz"
      sha256 "d6e679297993cf7bd03e6ef4925abb4c412da5840683c07a94eee218b645a614"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.5/mcpdeck-linux-amd64.tar.gz"
      sha256 "85930350c3c36dd77da6a3a2980955c339385795d57546447401854443ec633f"
    end
  end

  def install
    bin.install "mcpdeck"
    doc.install "README.txt", "AKILLI-KURULUM.md", "INSTRUCTIONS.md", "RECOVERY.md"
    prefix.install "LICENSE", "THIRD_PARTY_NOTICES.txt"
  end

  test do
    assert_match "0.1.0-alpha.5", shell_output("#{bin}/mcpdeck --version")
    assert_match "Manage MCP servers", shell_output("#{bin}/mcpdeck --help")
  end
end
