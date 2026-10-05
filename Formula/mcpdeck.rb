class Mcpdeck < Formula
  desc "Manage MCP servers and global instructions across coding agents"
  homepage "https://github.com/altanmehmet/homebrew-mcpdeck"
  version "0.1.0-alpha.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.2/mcpdeck-darwin-arm64.tar.gz"
      sha256 "a5b15c2060d1209d5318d56d2b7abd8b36306d87775c66d64afc0353304a1a6b"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.2/mcpdeck-darwin-amd64.tar.gz"
      sha256 "88185c125467bfd764191028e603356ef6eb95856e508b505b766989e8bb284f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.2/mcpdeck-linux-arm64.tar.gz"
      sha256 "af0e4355fbf82db3ff7bb67e441ba0d85400e13338d509fe01797b6d0a50dc3d"
    else
      url "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v0.1.0-alpha.2/mcpdeck-linux-amd64.tar.gz"
      sha256 "99085da4e85e91dc6e3463d6f091c2aff0702833c07116c7cf80da3cfba2f5ea"
    end
  end

  def install
    bin.install "mcpdeck"
    doc.install "README.txt", "AKILLI-KURULUM.md", "INSTRUCTIONS.md", "RECOVERY.md"
    prefix.install "LICENSE", "THIRD_PARTY_NOTICES.txt"
  end

  test do
    assert_match "0.1.0-alpha.2", shell_output("#{bin}/mcpdeck --version")
    assert_match "Manage MCP servers", shell_output("#{bin}/mcpdeck --help")
  end
end
