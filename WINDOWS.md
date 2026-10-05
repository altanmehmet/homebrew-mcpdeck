# Native Windows installation

MCPDeck runs directly in PowerShell or Windows Terminal. WSL, Go and administrator
access are not required to run the packaged application. It remains alpha software.
Use a 64-bit Windows system. The x64 package has native CI coverage; the ARM64
package is cross compiled and has not been tested on a native ARM64 machine.

## One-command public installer

```powershell
irm https://raw.githubusercontent.com/altanmehmet/homebrew-mcpdeck/main/install.ps1 | iex
mcpdeck
```

The public distribution installer chooses x64/ARM64, downloads a pinned release
and checks its embedded SHA-256 before extracting or running it. The current
PowerShell process and User PATH are updated. It needs no private repository
access. Treat the public installer repository as part of your trust boundary.

## Install a ZIP

Download `mcpdeck-windows-amd64.zip` for Intel/AMD x64 or
`mcpdeck-windows-arm64.zip` for Windows ARM64 from the
[public releases](https://github.com/altanmehmet/homebrew-mcpdeck/releases).
Only select a release that actually contains Windows assets. Extract the ZIP,
open PowerShell in that folder, then run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1
mcpdeck
```

`ExecutionPolicy Bypass` applies to this PowerShell process. The installer does
not change your system execution policy. Corporate policy can still prevent
script execution; follow your organization's rules.

The default destination is `%LOCALAPPDATA%\MCPDeck\versions\<version>`. The
installer updates the current process and your **User PATH**. Existing terminal
windows must be reopened; when launching the installer in a child PowerShell
process, reopen the parent terminal as well before running `mcpdeck`.

An explicit destination is supported:

```powershell
.\install.ps1 -Prefix "$env:LOCALAPPDATA\MCPDeck"
```

For a portable installation, use `-NoPathUpdate`, then run the installed
`mcpdeck.exe` by its full path. No registry PATH change is made in that mode.
You can also run `mcpdeck.exe` from the extracted ZIP.

## Updates and configuration

Run the new release's installer. Each version has its own directory so a running
older executable is not overwritten. Installing the same binary twice is safe;
an existing version with different binary contents is rejected. Older directories
are retained. Stop older sessions and update any explicit executable paths in
bridge configurations before removing an older directory.

The default deck is under `%USERPROFILE%\.config\mcpdeck`; `--config` can select
another file. Application-specific profiles use Windows paths, including
`%APPDATA%` for desktop clients and `%USERPROFILE%` for CLI clients. Custom paths
are preserved. Check detected profiles in the panel before syncing. MCPDeck's
written configuration files use a protected DACL allowing the current user and
SYSTEM; existing broad deck permissions are repaired before loading.

MCP servers can require Node, Java, Python or Docker. These are requirements of
the chosen server. Check `mcpdeck environment` and use the installation chat to
review missing prerequisites. Account login, OAuth and database permissions can
still require your input. Native `.exe` planning agents are recommended.
Windows `.cmd`/`.bat` shims support ordinary arguments but reject shell expansion
characters and embedded quotes. Use a direct runtime or `.exe` when necessary.
Process cancellation terminates the direct child; descendant termination is not
guaranteed on Windows.

## Manual acceptance test

1. Install, reopen Windows Terminal, run `mcpdeck --version` and `mcpdeck --help`.
2. Run `mcpdeck environment`; check the listed runtime and agent paths.
3. Open `mcpdeck`, navigate using keyboard and mouse, resize the terminal, and
   test copying. Clipboard behavior depends on terminal support; `--no-mouse`
   allows normal terminal text selection.
4. Add an MCP using **New MCP** and your logged-in planning agent. Review the
   commands, approve them, and supply secrets only in hidden inputs.
5. Check the MCP verification result and each agent's sync result. Restart the
   target agent and request an actual MCP tool call.
6. Disable, restart the target agent and verify the MCP is unavailable. Enable
   it and repeat the tool call. Remove it and check unrelated entries remain.
7. Review backups and `mcpdeck sync status`. Retry any failed targets.

Automated Windows CI exercises Go tests, vet, vulnerability scanning, ZIP
creation, installation into paths with spaces, repeat installation, User PATH,
private ACLs and a local MCP handshake plus eight profile configuration lifecycles.
These fixture checks do not prove actual Windows agent accounts, OAuth, Oracle
database access or interactive terminal behavior. Archive publisher signatures
are separate from Windows Authenticode; the executable is not Authenticode signed.
