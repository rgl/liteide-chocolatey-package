$ErrorActionPreference = 'Stop'

$packageName = 'liteide'
$url = 'https://github.com/visualfc/liteide/releases/download/x37.3/liteidex37.3.win64-qt5.14.2.zip'
$sha256 = 'c9d43f997c165507dcc14365ae9eda4feaedf1b3e6a04cf3b0f9636cb8a9bd07'
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
