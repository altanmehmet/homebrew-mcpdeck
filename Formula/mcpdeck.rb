class Mcpdeck < Formula
  desc "Manage MCP servers and global instructions across coding agents"
  homepage "https://github.com/altanmehmet/homebrew-mcpdeck"
  version "0.1.0-alpha.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.1/mcpdeck-darwin-arm64.tar.gz"
      sha256 "64d634ee47603bf4c5ea46d150e02471e64422e9d386fa08b418e092612d1ac5"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.1/mcpdeck-darwin-amd64.tar.gz"
      sha256 "dac35f3d46da29aed485fee56cba26893aa5982c01d76a8156fb7182b430a7d2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.1/mcpdeck-linux-arm64.tar.gz"
      sha256 "567db7ff394fc3678afad5926625cdec69e380cba9736c1c6732d93ac415b397"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.1/mcpdeck-linux-amd64.tar.gz"
      sha256 "7478f2cdc6bdf0d74b504d7863791a9ae5b438eb58001be93dfc1e44af92e1d1"
    end
  end

  def install
    bin.install "mcpdeck"
    doc.install "README.txt", "AKILLI-KURULUM.md", "INSTRUCTIONS.md", "RECOVERY.md"
    prefix.install "LICENSE", "THIRD_PARTY_NOTICES.txt"
  end

  test do
    assert_match "0.1.0-alpha.1", shell_output("#{bin}/mcpdeck --version")
    assert_match "Manage MCP servers", shell_output("#{bin}/mcpdeck --help")
  end
end
