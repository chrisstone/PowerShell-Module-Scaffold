Document README {
	Section $env:BHProjectName {
			Get-Metadata -Path $env:BHPSModuleManifest -PropertyName "Description" | BlockQuote
			
			"[![AppVeyor Build][appv-b-img]][appv-url]"
	}
	
	Section MoreGoesHere {
		"Test" | Write-Output
	}
}