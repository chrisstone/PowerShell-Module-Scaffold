<#
.NOTES
	Author:			Chris Stone <chris.stone@nuwavepartners.com>
	Date-Modified:	2020-10-15 10:53:01
	Based On:		https://github.com/RamblingCookieMonster/PSDeploy
#>

function Resolve-Module {
	[Cmdletbinding()]
	Param (
		[Parameter(Mandatory)]
		[string[]]	$Name
	)

	Process {
		Foreach ($ModuleName in $Name) {
			Write-Output "Resolving Module $($ModuleName)"
			$Module = Get-Module -Name $ModuleName -ListAvailable

			If ($Module) {
				$Version = $Module | Measure-Object -Property Version -Maximum | Select-Object -ExpandProperty Maximum
				$GalleryVersion = Find-Module -Name $ModuleName -Repository PSGallery | Measure-Object -Property Version -Maximum | Select-Object -ExpandProperty Maximum

				If ($Version -lt $GalleryVersion) {
					Write-Output "`tOutdated, Version [$($Version.tostring())] is installed. Updating to Gallery Version [$($GalleryVersion.tostring())]"
					Install-Module -Name $ModuleName -Force
					Import-Module -Name $ModuleName -Force -RequiredVersion $GalleryVersion
				} else {
					Write-Output "`tInstalled, Importing $($ModuleName)"
					Import-Module -Name $ModuleName -Force -RequiredVersion $Version
				}
			} else {
				Write-Output "`tMissing, installing Module"
				Install-Module -Name $ModuleName -Force
				Import-Module -Name $ModuleName -Force -RequiredVersion $Version
			}
		}
	}
}

Write-Output ("`n{0} started " -f $MyInvocation.MyCommand.Name ).PadRight(70,'-')

# Grab nuget, PSGallery, install modules
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null
If ((Get-PSRepository -Name PSGallery).InstallationPolicy -ne 'Trusted') { Set-PSRepository -Name PSGallery -InstallationPolicy Trusted }
Resolve-Module -Name Psake, PSDeploy, Pester, BuildHelpers

# From BuildHelpers
Set-BuildEnvironment -Force

# Go for a deployment in CI system
If ($env:BHBuildSystem -ne 'Unknown') { $BuildOpts = @{ taskList = 'Deploy' } }

# Everything else should be in PSAke
Invoke-psake -buildFile "$env:BHProjectPath\psake.ps1" @BuildOpts
Exit ( [int]( -not $psake.build_success ) )
