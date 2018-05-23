function Test-ChocolateyPackage (
    [Parameter(Mandatory = $true)]
    [ValidateNotNull()]
    [ValidateScript( {
            if (-Not ($_ | Test-Path) ) {
                throw "File does not exist"
            }
            if (-Not ($_ | Test-Path -PathType Leaf) ) {
                throw "The Path argument must be a file. Folder paths are not allowed."
            }
            if ($_ -notmatch "(\.nupkg)") {
                throw "The file specified in the path argument must be a .nupkg"
            }
            return $true 
        })]
    [System.IO.FileInfo]$Path

    ,

    [Parameter(Mandatory = $false, 
    HelpMessage = "Available Test Boxes: WIN2012")
    [ValidatePattern("[a-z]")]
    [String]
    $BoxType = "WIN2012"

) 

{
    #Split-Path -Path $PSScriptRoot | Set-Variable -Name PSMRoot
    #Copy-Item -Path $PSMRoot\private\DefaultTemplate -Destination $env:ChocolateyInstall\templates -Recurse -Force
    #Set-Variable -Name Template -Value DefaultTemplate

    $vagrant = vagrant.exe -v

    if($vagrent -eq "Vagrant 2.*" ){
        Write-Host "Hello"
    }
    else

}

SO VERY IMPORTANT https://chocolatey.org/docs/how-to-recompile-packages

Package the installer inside tools folder of nupkg after downlaoding nupkg
changing extnetion to .zip
navigatig to tools file and running nothing like this, this goes in the chocolateyinstall.ps1
$toolsDir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
Get-ChocolateyUnzip -FileFullPath "c:\someFile.zip" -Destination $toolsDir
    Instead of specifyinh the flags, I will kepp the @packargs to only change very little
Need to update default template, perhaps keep the standard one and add the embedded installers as an option
https://chocolatey.org/docs/helpers-get-chocolatey-unzip

So Need to redo new-chocolateypackage in order to embed the installer in .nupckg
that way I wont need to unpack when it gets to Test-ChocolateyPackage, I just have to drop it in the packages folder
vagrant up and Test
If it passes then using Publish-ChocolateyPackage it will be uploaded to a repo of the users choosing
less then 100mb and we are still good