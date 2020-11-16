<# 
.NOTES 
	Author:			Chris Stone <chris.stone@nuwavepartners.com>
	Date-Modified:	2020-10-15 17:56:18
#>

Param (
	[string]	
	$ModuleName = (Read-Host -Prompt 'Module Name'),

	[System.Management.Automation.PathInfo]
	$RootDir = (Get-Location)
)

$Tree = @("Private", "Public", "bin", "lib") + (Get-CIMInstance -Class Win32_OperatingSystem).MUILanguages

# Create directory structure
$ModulePath = New-Item -Path $RootDir.Path -ItemType directory -Name $ModuleName
Foreach ($Dir in $Tree) {
	New-Item -Path $ModulePath -ItemType directory -Name $Dir | Out-Null
}

# Module files
New-ModuleManifest -Path ("{0}\{0}.psd1" -f $ModuleName)
New-Item -Path $ModulePath -ItemType directory -Name ("{0}.psm1" -f $ModuleName) | Out-Null
