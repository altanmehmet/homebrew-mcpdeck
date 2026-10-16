# MCPDeck CLI packages

[Source and documentation](https://github.com/altanmehmet/mcpdeck) · [Releases](https://github.com/altanmehmet/homebrew-mcpdeck/releases) · [Report a problem](https://github.com/altanmehmet/mcpdeck/issues)

Homebrew formula, Windows bootstrap and publisher-signed archives for **MCPDeck**, an MIT-licensed local CLI for MCP servers and shared coding-agent instructions. The application source is public. This repository contains distribution files rather than a separate application.

**Public alpha: 0.1.0-alpha.8.** Adds optional OS-vault credentials and reference-only agent settings, requires protected transport for remote vault connections, selects a patched Go toolchain and accepts both agy structured-result formats. Desktop packages are not part of this channel.

## macOS / Linux

```sh
brew install altanmehmet/mcpdeck/mcpdeck
mcpdeck
```

```sh
brew update
brew upgrade altanmehmet/mcpdeck/mcpdeck
```

To remove the manager, use `brew uninstall mcpdeck`. Personal MCPDeck data and agent configuration remain. Remove an MCP through MCPDeck before uninstalling if you also want its managed agent entries removed.

## Windows

In PowerShell or Windows Terminal:

```powershell
irm https://raw.githubusercontent.com/altanmehmet/homebrew-mcpdeck/main/install.ps1 | iex
mcpdeck
```

[Inspect the bootstrap](install.ps1) before execution. It checks the pinned x64/ARM64 ZIP checksum and installs under `%LOCALAPPDATA%\MCPDeck\versions\<version>`, updating your user PATH. No Go, WSL or administrator privileges are needed. Reopen other terminal windows. [Manual installation and removal](WINDOWS.md).

## Private inputs

```sh
mcpdeck install "Install the MCP for my service" --vault
```

Alternatively enable **OS VAULT** with `Ctrl+K` in the New MCP form. Private fields are separate from planner chat. The local runtime retrieves credentials from the OS store; client settings contain a runtime reference. This does not sandbox unrestricted same-user programs or sanitize data returned by an MCP. Legacy plaintext copies/backups need inspection and credential rotation. [Vault guide](https://github.com/altanmehmet/mcpdeck/blob/main/docs/VAULT.md).

## Verify archives

Download the six matching platform archives plus `SHA256SUMS` and `SHA256SUMS.sig` from one release (historical releases may contain four archives). From an independently trusted checkout:

```sh
sh scripts/verify-packages.sh /absolute/path/to/downloads keys/allowed_signers
```

Expected current Ed25519 fingerprint:

```text
SHA256:M8NS9J5AVuMDXSordI+V7dVzHdWKWcXTAMr/WolzzK8
```

OpenSSH with `ssh-keygen -Y` is required. The alpha.1/alpha.2 public key remains in `keys/allowed_signers` for historical verification; alpha.3 and later use the dedicated key above. Establish trust independently: a key supplied beside an untrusted archive is not proof of publisher identity.

After verification, extract your macOS/Linux archive and run `sh install.sh`; use the Windows guide for ZIP installation. Homebrew verifies its pinned SHA-256 hash, not the OpenSSH publisher signature.

## Coverage and boundaries

Source CI tests Linux/macOS and native Windows x64/ARM64. Distribution CI checks public downloads, installers and repeat-install PATH behavior. macOS ARM64 vault/terminal tests and Windows native credential/runtime fixtures pass. Linux ARM64 is cross-compiled; Linux live keyring integration, universal live agent/account behavior and all possible third-party MCPs are not established by these tests.

MCPDeck runs reviewed commands with your user permissions. It is not an OS sandbox, and a handshake is not proof of account/database access. Provider usage may cost money. macOS packages are not notarized and Windows executables are not Authenticode signed. [Security policy and known dependency records](https://github.com/altanmehmet/mcpdeck/blob/main/SECURITY.md).

Archives include the MIT license and Go/linked-module third-party notices. [Application changelog](https://github.com/altanmehmet/mcpdeck/blob/main/CHANGELOG.md).
