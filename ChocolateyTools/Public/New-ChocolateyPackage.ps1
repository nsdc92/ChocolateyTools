function New-ChocolateyPackage () {

    Param(
        [Parameter(Mandatory = $true)]
        [ValidatePattern("[a-z]")]
        [String]
        $PackageName
    
        ,

        [Parameter(Mandatory = $true)]
        [ValidatePattern("\d{1,2}\.\d{1,2}\.\d{1,2}")]
        [string]
        $PackageVersion

        ,

        [Parameter(Mandatory = $true)]
        [ValidatePattern("[a-z]")]
        [String]
        $PackagePath

        ,

        [Parameter(Mandatory = $false)]
        [ValidatePattern("[a-z]")]
        [String]
        $InstallerType

        ,

        [Parameter(Mandatory = $false)]
        [ValidatePattern("[a-z]")]
        [String]
        $Maintainer = "AlasConnect")

    Process {
        choco.exe new $PackageName `
            --template=$Template `
            --version=$PackageVersion `
            --maintainer=$MaintainerName `
            url=$PackagePath `
            installertype=$InstallerType `
            silentargs=$SilentArgs `
            --acceptlicense --limitoutput --force 
    }

}