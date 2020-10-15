@{
	Severity	 = @('Error', 'Warning')

	IncludeRules = @(
		'PSPlaceOpenBrace',
		'PSPlaceCloseBrace',
		'PSUseConsistentWhitespace',
		'PSUseConsistentIndentation',
		'PSAlignAssignmentStatement',
		'PSAvoidTrailingWhitespace',
		'PSUseCorrectCasing',
		'PSProvideCommentHelp',
		'PSAvoidUsingWriteHost',
		'PSUseApprovedVerbs',
		'PSReservedCmdletChar',
		'PSReservedParams',
		'PSShouldProcess',
		'PSUseShouldProcessForStateChangingFunctions',
		'PSUseSingularNouns',
		'PSMissingModuleManifestField',
		'PSAvoidDefaultValueSwitchParameter',
		'PSAvoidUsingCmdletAliases',
		'PSAvoidUsingWMICmdlet',
		'PSAvoidUsingEmptyCatchBlock',
		'PSUseCmdletCorrectly',
		'PSUseShouldProcessForStateChangingFunctions',
		'PSAvoidUsingPositionalParameters',
		'PSAvoidGlobalVars',
		'PSUseDeclaredVarsMoreThanAssignments',
		'PSAvoidUsingInvokeExpression',
		'PSAvoidUsingPlainTextForPassword',
		'PSAvoidUsingComputerNameHardcoded',
		'PSUsePSCredentialType',
		'PSDSC*',
		'PSAvoidUsingPlainTextForPassword',
		'PSAvoidUsingComputerNameHardcoded',
		'PSAvoidUsingConvertToSecureStringWithPlainText',
		'PSUsePSCredentialType',
		'PSAvoidUsingUserNameAndPasswordParams'
	)

	Rules		= @{
		PSPlaceOpenBrace	= @{
			Enable				= $true
			OnSameLine			= $true
			NewLineAfter		= $true
			IgnoreOneLineBlock	= $true
		}

		PSPlaceCloseBrace	= @{
			Enable				= $true
			NewLineAfter		= $false
			IgnoreOneLineBlock	= $true
			NoEmptyLineBefore	= $false
		}

		PSUseConsistentIndentation = @{
			Enable				= $true
			Kind				= 'tab'
			PipelineIndentation	= 'IncreaseIndentationForFirstPipeline'
		}

		PSUseConsistentWhitespace  = @{
			Enable						 	= $true
			CheckInnerBrace					= $true
			CheckOpenBrace				 	= $false
			CheckOpenParen				 	= $true
			CheckOperator				  	= $false
			CheckPipe						= $true
			CheckPipeForRedundantWhitespace	= $false
			CheckSeparator				 	= $false
			CheckParameter				 	= $false
		}

		PSAlignAssignmentStatement = @{
			Enable			= $true
			CheckHashtable	= $false
		}

		PSUseCorrectCasing	= @{
			Enable	= $true
		}
	}
}