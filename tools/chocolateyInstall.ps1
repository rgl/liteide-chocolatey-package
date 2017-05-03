$ErrorActionPreference = 'Stop'

$packageName = 'liteide'
$url = 'https://github.com/visualfc/liteide/releases/download/x31/liteidex31.windows-qt5.zip'
$sha256 = 'dbb31c0765d875e56d3d3a05327bd7b69aa6950c144d524358cbe08a0833ca46'
$installPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

Install-ChocolateyZipPackage `
    -PackageName $packageName `
    -Url $url `
    -UnzipLocation $installPath `
    -ChecksumType sha256 `
    -Checksum $sha256

# only create a shim for liteide.exe.
Get-ChildItem `
    $installPath `
    -Include *.exe `
    -Exclude liteide.exe `
    -Recurse `
    | ForEach-Object {New-Item "$($_.FullName).ignore" -Type File -Force} `
    | Out-Null

Install-ChocolateyShortcut `
  -ShortcutFilePath "$([Environment]::GetFolderPath('CommonStartMenu'))\Programs\LiteIDE.lnk" `
  -TargetPath "$installPath\liteide\bin\liteide.exe"
