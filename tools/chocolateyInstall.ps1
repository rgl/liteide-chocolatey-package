$ErrorActionPreference = 'Stop'

$packageName = 'liteide'
$url = 'https://sourceforge.net/projects/liteide/files/X32.2/liteidex32.2.windows-qt5.zip/download'
$sha256 = 'aa1fe49e7e5e6c4e4f315e9912f01d7ac69d8434222e0172dd8b43618598ddc9'
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
