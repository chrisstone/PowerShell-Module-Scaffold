# Generic module deployment.
# This stuff should be moved to psake for a cleaner deployment view

# ASSUMPTIONS:

# folder structure of:
# - RepoFolder
#   - This PSDeploy file
#   - ModuleName
#	 - ModuleName.psd1

# Nuget key in $ENV:NugetApiKey

# Set-BuildEnvironment from BuildHelpers module has populated ENV:BHProjectName

# Publish to gallery with a few restrictions
If ($env:BHPSModulePath -and
	$env:BHBuildSystem -ne 'Unknown' -and
	@('release','devel') -contains $env:BHBranchName) {
	Deploy Module {
		By PSGalleryModule {
			FromSource $ENV:BHPSModulePath
			To PSGallery
			WithOptions @{
				ApiKey = $ENV:NugetApiKey
			}
		}
	}
} Else {
	"Skipping deployment: To deploy, ensure that...`n",
	"`t* You are in a known build system (Current: $ENV:BHBuildSystem)`n",
	"`t* You are committing to the release/devel branch (Current: $ENV:BHBranchName) `n" |
		Write-Output
}

<#
# Publish to AppVeyor if we're in AppVeyor
if(
	$env:BHPSModulePath -and
	$env:BHBuildSystem -eq 'AppVeyor'
   )
{
	Deploy DeveloperBuild {
		By AppVeyorModule {
			FromSource $ENV:BHPSModulePath
			To AppVeyor
			WithOptions @{
				Version = $env:APPVEYOR_BUILD_VERSION
			}
		}
	}
}
#>
