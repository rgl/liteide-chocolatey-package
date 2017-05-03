This repository contains the [liteide chocolatey package](https://chocolatey.org/packages/liteide) source for the [LiteIDE](https://github.com/visualfc/liteide) application.

Run `choco pack` to create the chocolatey nuget package.

Run `choco install -y -source $pwd -f liteide` to install the package.

Run the following to publish the package to chocolatey.org:

```powershell
choco apikey -k API-KEY -source https://chocolatey.org/
choco push -source https://chocolatey.org/
```
