param ($Task = 'Default')

# Grab nuget bits, install modules, set build variables, start build.
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

Install-Module Psake, PSDeploy, BuildHelpers -force
Install-Module Pester -Force -SkipPublisherCheck
Import-Module Psake, PSDeploy, BuildHelpers, Pester

Set-BuildEnvironment

Invoke-psake -buildFile .\psake1.ps1 -taskList $Task -nologo
exit ( [int]( -not $psake1.build_success ) )