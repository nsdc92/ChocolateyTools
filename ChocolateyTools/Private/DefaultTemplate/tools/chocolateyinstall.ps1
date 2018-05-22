$ErrorActionPreference = 'Stop'; # stop on all errors

[[AutomaticPackageNotesInstaller]]
$packageName  = '[[PackageName]]'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir '[[url64]]'

$packageArgs = @{
  packageName   = '[[PackageName]]'
  file          = '[[url64]]'
  fileType      = '[[InstallerType]]' #only one of these: exe, msi, msu
  silentArgs    = '[[silentArgs]]'
  validExitCodes= @(0, 3010, 1641)

}

Install-ChocolateyInstallPackage @packageArgs