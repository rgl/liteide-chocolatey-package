$ErrorActionPreference = 'Stop'

Remove-Item "$([Environment]::GetFolderPath('CommonStartMenu'))\Programs\LiteIDE.lnk"
