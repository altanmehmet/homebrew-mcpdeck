# MCPDeck binary tap

MCPDeck is a terminal MCP manager for macOS, Linux and Windows. It helps configure MCP
servers and personal instructions across supported coding agents, with reviewed
installation plans, backups, discovery and removal.

**Alpha software.** Application source remains in a separate private repository.
This public repository contains only the Homebrew formula, verification helpers,
public signing key, release notes and compiled packages. Packages are MIT licensed
and include Go and linked dependency license notices.

## Install

```sh
brew tap altanmehmet/mcpdeck
brew install altanmehmet/mcpdeck/mcpdeck
mcpdeck
```

Go and private repository access are not required. To update:

```sh
brew update
brew upgrade altanmehmet/mcpdeck/mcpdeck
```

To remove the application binary, use `brew uninstall mcpdeck`. This retains
personal MCPDeck data and agent configuration. Use MCPDeck's Remove action to
remove an MCP from configured agents before uninstalling the manager.

## Native Windows installation

Open PowerShell or Windows Terminal:

```powershell
irm https://raw.githubusercontent.com/altanmehmet/homebrew-mcpdeck/main/install.ps1 | iex
mcpdeck
```

The installer downloads the pinned x64/ARM64 ZIP, checks its SHA-256 before
execution and installs under `%LOCALAPPDATA%\MCPDeck\versions\<version>`.
It updates your User PATH and the current terminal. Reopen other terminal windows.
No WSL, Go or administrator privileges are required. Windows ARM64 is cross
compiled and has not been tested on native ARM64 hardware.

For manual ZIP installation, portable usage, updates and test scenarios, see
[the Windows guide](WINDOWS.md). These executables are not Authenticode signed.

## Manual installation and signature verification

Download all six archives (four for historical releases), `SHA256SUMS` and `SHA256SUMS.sig` from the same release.
From an independently trusted checkout of this repository:

```sh
sh scripts/verify-packages.sh /absolute/path/to/downloads keys/allowed_signers
```

Expected Ed25519 key fingerprint:
`SHA256:sd7JZx1++fUe2ETVq60wqJowhKNXS7Sk9b/qgmOo7fQ`.
OpenSSH with `ssh-keygen -Y` support is required. Verify the fingerprint through a
trusted maintainer channel when first establishing trust. A key obtained only
alongside an untrusted archive does not prove the publisher's identity.

After successful verification, extract the archive matching your system and run:

```sh
sh install.sh
```

Homebrew verifies the pinned SHA-256 checksum; it does not run the OpenSSH
publisher signature verifier. Archive publisher signatures are not Apple
Developer ID signing or notarization. These alpha binaries are not notarized.

## Test coverage and limits

- Actual Codex and Copilot CLI sessions called an isolated MCP installed by
  MCPDeck, then called it again after re-enabling it. Disabling and removal were
  checked using both clients' real configuration readers.
- Native macOS arm64 archive installation and Homebrew installation are checked.
- Source CI runs Go tests, vet, installation smoke and terminal interaction tests
  on macOS and Linux. Cross compiled binaries do not prove native execution on
  every architecture.
- Native Windows x64 CI checks Go tests, vet, vulnerability scanning, archive
  installation using PowerShell 5.1, User PATH, private ACLs and a local MCP
  handshake plus eight profile configuration lifecycles. Public CI downloads
  the published ZIP and exercises the pinned bootstrap and terminal command.
  Windows interactive mouse/clipboard and actual provider accounts require
  manual verification.
- Other clients, remote OAuth servers and actual Oracle database access have not
  all been tested. Configuration support is not a guarantee that every MCP can
  install unattended. Provider login, credentials and reviewed approvals may be
  required. Existing sessions may need restarting to reload MCP configuration.

Use the packaged guides for setup, instructions and backup recovery. Never put
passwords or tokens in planner chat or GitHub issues.
