function New-ChocolateyPackage (

    [Parameter(Mandatory = $true ,
        HelpMessage = "Enter a package name with no spaces")]
    [ValidateNotNull()]
    [ValidatePattern("[a-z]")]
    [String]
    $Name

    ,

    [Parameter(Mandatory = $true)]
    [ValidateNotNull()]
    [ValidatePattern("\d{1,2}\.\d{1,2}\.\d{1,2}")]
    [string]
    $Version

    ,
    
    [Parameter(Mandatory = $true)]
    [ValidateNotNull()]
    [ValidateScript( {
            if (-Not ($_ | Test-Path) ) {
                throw "File or folder does not exist"
            }
            if (-Not ($_ | Test-Path -PathType Leaf) ) {
                throw "The Path argument must be a file. Folder paths are not allowed."
            }
            if ($_ -notmatch "(\.msi|\.exe|\.mct)") {
                throw "The file specified in the path argument must be either of type msi, exe or mct"
            }
            return $true 
        })]
    [System.IO.FileInfo]$Path
    
    ,

    [Parameter(Mandatory = $false)]
    [ValidatePattern("[a-z]")]
    [String]
    $Type

    ,

    [Parameter(Mandatory = $false)]
    [ValidatePattern("[a-z]")]
    [String]
    $Maintainer = "Author") {
    <#
.Synopsis
    Create a chocolatey package
.Description
    Used to create a packed chocolatey package with a standard folder structure consiting of:
    |--Tools
    | |-chocolateyinstall.ps1
    | |-<installer>.(msi,exe,mst)
    |--<name><version>.nupkg
    |--<name>.nuspec
    |--Readme
.Example
    Example goes here
.Parameter Name
    The name of the package. Cannot contain spaces. Avoid special characters. 
    Mandatory
.Parameter Version
    The software version in major.minor.build format i.e 1.0.0. 
    Mandatory and must be in the prevouisly stated format     
.Parameter Path
    The path to the installer. This can be a local file path, a file share path or a URL. It will depend on your end goal.
    If you are developing and testing, this will most liekly be a local path. If you plan to publish this package straight to your
    Chocolatey source, use the file path to the installer that is accesible to your end users.
    Mandatory
.Parameter Type
    The type of installer. ex. .exe, .msi or .mst. It sets the type based on path passed to the "Path" parameter.
    If the installer is an .msi, the generic flags "/q /norestart" will be automatically added.
    Otherwise, you will be prompteed for the .exe or .mst silent arguments. (Which is when Test-ChocolateyPackage comes in handy
    because you don't want to be install and uninstalling software on your machine just to test)
    Automatic
.Parameter Maintainer
    The creator/maintainer of the package. Set to "Author" if no value is provided
    Optional
#>
    Process {
        $Type = $Path.Extension   
        switch ($Type) {
            #'.exe' {$SilentArgs = '/verysilent /norestart '}
            '.msi' {$SilentArgs = '/qn /norestart '}
            Default {
                Write-Error -Message "File extension is $Type . Please provide arguemnts"
                Read-Host -Prompt "Enter silent arguments" | Set-Variable -Name SilentArgs -Scope Global
            }
        }

        Split-Path -Path $PSScriptRoot | Set-Variable -Name PSMRoot
        Copy-Item -Path $PSMRoot\private\DefaultTemplate -Destination $env:ChocolateyInstall\templates -Recurse -Force
        Set-Variable -Name Template -Value DefaultTemplate

        #Set-Location

        choco.exe new $Name `
            --template=$Template `
            --version=$PVersion `
            --maintainer=$Maintainer `
            url64=$Path `
            installertype=$Type `
            silentargs=$SilentArgs `
            --acceptlicense --limitoutput --force 

        #choco.exe pack $ChocoWorkingDir\$PackageName\$Name.nuspec

        #Copy-Item -Path $ChocoWorkingDir\$PackageName\$Name.nupkg -Destination C:\Work\ACGit\chocolatey-test-environment\packages\ -Recurse -Force
            
        #Set-Location -Path C:\Work\ACGit\chocolatey-test-environment\
    }
}