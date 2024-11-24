<#
    .SYNOPSIS
    This script hunt for unknown SID on accounts.

    .DESCRIPTION
    This script hunt for unknown SID on accounts within the domain.
    When unkown SID are found, the object is remediated with default ACL from the class definition.

    .PARAMETER UpdateKnownSID
    This parameter add a list of known domain SID to avoid their clearance.
    If no data is passed as argument, the script queries the domain for trust.

    .PARAMETER AutomaticRemediation
    IF used, the script remediate immediately any founds. If not, the script output its result to the .\Outputs folder.

    .PARAMETER RemediateOnly
    If specified, the script will fix accounts from the file specified in argument. the file must be present in .\Inputs. 

    .PARAMETER Scope
    The default value will hunt for group, computer and user objects. the scope can limit to only one set.

    .NOTES
    Script version 1.0 by Loic VEIRMAN @ MSSEC
#>

[CmdletBinding(DefaultParameterSetName = 'DFT')]
Param(
    [Parameter(ParameterSetName = 'SID', Position = 0)]
    [array[]]$UpdateKnownSID,

    [Parameter(ParameterSetName = 'DFT', Position = 0)]
    [ValidateSet("All","Computer","Group","User")]
    [String[]]$Scope,

    [Parameter(ParameterSetName = 'DFT', Position = 1)]
    [Switch]$AutomaticRemediation,

    [Parameter(ParameterSetName = 'FIX', Position = 0)]
    [ValidateScript({if(Test-Path .\Inputs\$_){return $true} else { throw "File does not exist" }})]
    [String[]]$RemediateOnly
)

# Loading static definition
Import-Module .\Modules\colorSchema, .\Modules\Logs
Set-ColorSchema
Set-MessageType
Set-logEnvironement

# Script start
Try {
    New-Variable -Name xmlCfg  -Option AllScope -Force -Scope Global -Value ([xml](Get-Content .\config\scriptSettings.xml -Encoding utf8 -ErrorAction Stop))
    New-Variable -Name LogFile -Option AllScope -Force -Scope Global -Value ($xmlCfg.Settings.Log.File)
    write-toLog -Start 
    write-toScreen -Start
    # information: show option used
    Switch ($PsCmdlet.ParameterSetName) {
        "DFT" {
            write-toLog inf @("Parameters:","> Scope...............: $($Scope)","> AutomaticRemediation: $($AutomaticRemediation)")
            if ($AutomaticRemediation) { $perform = @("Detect","Fix") } else { $perform = @("Detect") }
            
            write-toScreen inf $perform
            write-toScreen warn $perform
            write-toScreen err $perform
            write-toScreen success $perform
            write-toScreen skip $perform
            write-toScreen fail $perfor

        }
        "SID" {

        }
        "FIX" {

        }
    }


} Catch {
    write-host "$($colError)  Fatal Error!"
    write-host "$($colError)  $($_)"
    Exit 1
}

write-tolog -end
write-toscreen -end
Remove-Module colorSchema,Logs