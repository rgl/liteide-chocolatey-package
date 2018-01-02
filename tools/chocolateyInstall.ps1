$ErrorActionPreference = 'Stop'

$packageName = 'liteide'
$url = 'https://sourceforge.net/projects/liteide/files/X33.1/liteidex33.1.windows-qt5.zip/download'
$sha256 = 'f40e831a776daf42ea94f442b007f41442f1ee8349a50cc15125cc5cb389b4c9'
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
