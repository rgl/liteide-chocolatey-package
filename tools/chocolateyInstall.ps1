$ErrorActionPreference = 'Stop'

$packageName = 'liteide'
$url = 'https://sourceforge.net/projects/liteide/files/X33/liteidex33.windows-qt5.zip/download'
$sha256 = '24b3e34624442eb868f05a9c73d85033f5cf1293adb46de05638233861af639d'
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
