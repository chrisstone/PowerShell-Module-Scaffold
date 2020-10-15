#### By Chris Stone <chris.stone@nuwavepartners.com> v0.0.35 2020-06-12T17:04:30.652Z

# Ideas https://www.red-gate.com/simple-talk/sysadmin/powershell/testing-powershell-modules-with-pester/
#       https://www.burkard.it/2019/08/pester-tests-for-powershell-functions/

$Module = Get-ChildItem -Filter "*.psm1" -Path (Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)) -Recurse -Depth 1

$Script:ModuleName = ($Module -split '\.')[0]
$Script:ModulePath = Split-Path -Path $Module.FullName -Parent


Describe "Module" {

	Context 'Setup' {

		It "File Exists" {
			"$ModulePath\$ModuleName.psm1" | Should -Exist
		}

		It "Parse" {
			$psFile = Get-Content -Path "$ModulePath\$ModuleName.psm1" -ErrorAction Stop
			$errors = $null
			$null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
			$errors.Count | Should -Be 0
		}

		It "Manifest" {
			"$ModulePath\$ModuleName.psd1" | Should -Exist
		}

		It "Loads" {
			$Import = Import-Module -Name "$ModulePath\$ModuleName.psm1" -Force -ErrorAction SilentlyContinue -PassThru 3>$null
			$Import.Count | Should -Be 1
		}
	}

	Import-Module -Name "$ModulePath\$ModuleName.psm1" -Force -ErrorAction SilentlyContinue
	$Functions = Get-Command -Module $ModuleName -CommandType Function

	Foreach ($Func in $Functions.Name) {
		Context "Function $Func" {

			It "File Exists" -TestCases @{ Path = "$ModulePath\Public\$Func.ps1" } {
				Param ( $Path )
				$Path | Should -Exist
			}

			It "Verb" -TestCases @{Name = ($Func -split '-')[0] } {
				Param ( $Name )
				(Get-Verb).Verb | Should -Contain $Name
			}

			It "Help" -TestCases @{ Path = "$ModulePath\Public\$Func.ps1" } -Pending {
				Param ( $Path )
				$Path | Should -FileContentMatch '<#'
				$Path | Should -FileContentMatch '#>'
			}


		}
	}
}
