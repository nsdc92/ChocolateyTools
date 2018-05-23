$ErrorActionPreference = 'Stop'; # stop on all errors

[[AutomaticPackageNotesInstaller]]
$packageName  = '[[PackageName]]'
#$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsDir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
$fileLocation = Join-Path $toolsDir '[[PackageName]][[InstallerType]]'

$packageArgs = @{
  packageName   = '[[PackageName]]'
  file          = $fileLocation
  fileType      = '[[InstallerType]]' #only one of these: exe, msi, msu
  silentArgs    = '[[silentArgs]]'
  validExitCodes= @(0, 3010, 1641)
  destination   = $toolsDir

}

Install-ChocolateyInstallPackage @packageArgs