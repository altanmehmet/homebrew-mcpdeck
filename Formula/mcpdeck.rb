class Mcpdeck < Formula
  desc "Manage MCP servers and global instructions across coding agents"
  homepage "https://github.com/altanmehmet/mcpdeck"
  version "0.1.0-alpha.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.4/mcpdeck-darwin-arm64.tar.gz"
      sha256 "4dbd23b0fea8595f5b0d666f35c8bde6fd27cae42e03912273a7575488d1ced5"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.4/mcpdeck-darwin-amd64.tar.gz"
      sha256 "c5ef05776535b6832a0b69b21826737535cac97dc1aba0241c2a44c7366b1977"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.4/mcpdeck-linux-arm64.tar.gz"
      sha256 "6e58aecf05c45b661d06eaf75c44989f8320600038c9fd1cd298fc56bc3817d0"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.4/mcpdeck-linux-amd64.tar.gz"
      sha256 "6bdf856d337001b0663f4d0bf0be6e84b5603bba93b404e6f2d3b03c61f4ad85"
    end
  end

  def install
    bin.install "mcpdeck"
    doc.install "README.txt", "AKILLI-KURULUM.md", "INSTRUCTIONS.md", "RECOVERY.md"
    prefix.install "LICENSE", "THIRD_PARTY_NOTICES.txt"
  end

  test do
    assert_match "0.1.0-alpha.4", shell_output("#{bin}/mcpdeck --version")
    assert_match "Manage MCP servers", shell_output("#{bin}/mcpdeck --help")
  end
end
