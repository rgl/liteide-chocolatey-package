$ErrorActionPreference = 'Stop'

$packageName = 'liteide'
$url = 'https://github.com/visualfc/liteide/releases/download/x33.2/liteidex33.2.windows-qt5.zip'
$sha256 = '41ff03e8cd2ae7d6253c94ab01b33c44f80201cd5f4bd17a93940fa72de5aa52'
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
