$ErrorActionPreference = 'Stop'

$packageName = 'liteide'
$url = 'https://sourceforge.net/projects/liteide/files/X32/liteidex32-2.windows-qt5.zip/download'
$sha256 = '0fa66c414a7e7af0cdaf8273c5fc6c11fca34e2849aaf573b6d8e83a252c8dac'
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
