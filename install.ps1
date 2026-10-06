[CmdletBinding()]
param(
    [string]$Prefix = (Join-Path $env:LOCALAPPDATA 'MCPDeck'),
    [switch]$NoPathUpdate
)
$ErrorActionPreference = 'Stop'
function Get-MCPDeckArchiveChecksum([string]$Path) {
    $stream = [IO.File]::OpenRead($Path)
    $sha = [Security.Cryptography.SHA256]::Create()
    try { return [BitConverter]::ToString($sha.ComputeHash($stream)).Replace('-', '').ToLowerInvariant() }
    finally { $stream.Dispose(); $sha.Dispose() }
}
$version = '0.1.0-alpha.3'
$checksums = @{
    amd64 = '9057d7e27ae2f3ad9c85921044d0bc49c037827374e1cea9509dcda5a468606d'
    arm64 = 'bbdffe67c8663e0890f9f3cdcaa9604214eb3226a45fb99e47106397772458f8'
}
$machine = $env:PROCESSOR_ARCHITECTURE
if ($env:PROCESSOR_ARCHITEW6432) { $machine = $env:PROCESSOR_ARCHITEW6432 }
switch ($machine.ToUpperInvariant()) {
    'AMD64' { $arch = 'amd64' }
    'ARM64' { $arch = 'arm64' }
    default { throw 'MCPDeck requires 64-bit Windows (x64 or ARM64).' }
}
$temporary = Join-Path ([IO.Path]::GetTempPath()) ('mcpdeck-download-' + [Guid]::NewGuid().ToString('N'))
$oldProtocol = [Net.ServicePointManager]::SecurityProtocol
try {
    [Net.ServicePointManager]::SecurityProtocol = $oldProtocol -bor [Net.SecurityProtocolType]::Tls12
    $null = New-Item -ItemType Directory -Path $temporary
    $archive = Join-Path $temporary 'mcpdeck.zip'
    $url = "https://github.com/altanmehmet/homebrew-mcpdeck/releases/download/v$version/mcpdeck-windows-$arch.zip"
    Write-Output "Downloading MCPDeck $version for Windows $arch..."
    $client = [Net.WebClient]::new()
    try { $client.DownloadFile($url, $archive) } finally { $client.Dispose() }
    if ((Get-MCPDeckArchiveChecksum $archive) -ne $checksums[$arch]) {
        throw 'Package checksum does not match the pinned release. Nothing was installed.'
    }
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip = [IO.Compression.ZipFile]::OpenRead($archive)
    try {
        $expected = @('mcpdeck.exe', 'install.ps1', 'uninstall.ps1', 'README.txt', 'AKILLI-KURULUM.md', 'INSTRUCTIONS.md', 'RECOVERY.md', 'LICENSE', 'THIRD_PARTY_NOTICES.txt')
        $names = @($zip.Entries | ForEach-Object { $_.FullName })
        if ($names.Count -ne $expected.Count -or (Compare-Object ($names | Sort-Object) ($expected | Sort-Object))) {
            throw 'Unexpected package contents.'
        }
    } finally { $zip.Dispose() }
    $unpacked = Join-Path $temporary 'package'
    [IO.Compression.ZipFile]::ExtractToDirectory($archive, $unpacked)
    & (Join-Path $unpacked 'install.ps1') -Prefix $Prefix -NoPathUpdate:$NoPathUpdate
} finally {
    [Net.ServicePointManager]::SecurityProtocol = $oldProtocol
    if (Test-Path -LiteralPath $temporary) { Remove-Item -LiteralPath $temporary -Recurse -Force }
}
