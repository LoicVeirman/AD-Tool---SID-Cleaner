#region Set-ColorSchema
Function Set-ColorSchema {
    <#
        .SYNOPSIS
        A function to load the color scheme used on screen.

        .DESCRIPTION
        This allow to custom any output using ansi code. To use it, add to the display text with the colorname this way: 
        "Text to ${ColorVariable}Display${ANSI_End} on screen."

        The value ${ANSI_End} is mandatory to finalize the ANSI format, but you can call multiple color/style before closing.

        .NOTES
        Version 01.00.00 By l. Veirman MSSEC
        ANSI source: 
        https://jafrog.com/2013/11/23/colors-in-terminal.html
        https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters

        Read it carrefully, details are important!

        Hug thanks to JMD29, who learn me this nice feature in pShell :)
    #>
    # Using ANSI Escape code
    New-Variable -Name FG_Purple      -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[38;2;142;140;216;24m"                  -Description "38:Foreground, 2:RGB, Red:142, Green:140, Blue:216, 24: not underlined"
    New-Variable -Name BG_Purple      -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[48;2;142;140;216m"                     -Description "48:background, 2:RGB, Red:142, Green:140, Blue:216"
    New-Variable -Name FG_Purple_U    -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[38;2;142;140;216;4m"                   -Description "38:Foreground, 2:RGB, Red:142, Green:140, Blue:216, 4: underlined"
    New-Variable -Name FG_Blue        -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[38;2;94;153;255m"                      -Description "38:Foreground, 2:RGB, Red:94 , Green:153, Blue:255"
    New-Variable -Name FG_Turquoise   -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[38;2;0;175;204;24m"                    -Description "38:Foreground, 2:RGB, Red:0  , Green:175, Blue:204, 24: not underlined"
    New-Variable -Name FG_RedLight    -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[38;2;244;135;69m"                      -Description "38:Foreground, 2:RGB, Red:244, Green:135, Blue:69"
    New-Variable -Name FG_Orange      -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[38;2;255;171;21m"                      -Description "38:Foreground, 2:RGB, Red:255, Green:171, Blue:21"
    New-Variable -Name FG_GreenLight  -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[38;5;42;24m"                           -Description "38:Foreground, 5:Indexed Color, 42: Green, 24: not underlined"
    New-Variable -Name FG_PinkDark    -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[38;2;218;101;167m"                     -Description "38:Foreground, 2:RGB, Red:218, Green:101, Blue:167"
    New-Variable -Name FG_yellowLight -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[38;2;220;220;170;24m"                  -Description "38:Foreground, 2:RGB, Red:22°, Green:220, Blue:170, 24: not underlined"
    New-Variable -Name FG_Red         -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[38;2;255;0;0m"                         -Description "38:Foreground, 2:RGB, Red:255, Green:0  , Blue:0"
    New-Variable -Name FG_BrightCyan  -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[96;24m"                                -Description "96:24 bits color code from standard VGA, 24: not underlined"
    New-Variable -Name FG_brown       -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[38;2;206;145;120m"                     -Description "38:Foreground, 2:RGB, Red:206, Green:146, Blue:120"
    New-Variable -Name SelectedChoice -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[38;2;255;210;0;48;2;0;175;204;24m"     -Description "38:Foreground, 2:RGB, Red:255, Green:210, Blue:0  , 48:Background, 2:RGB, Red:0  ,Green:175, Blue:204, 24: not underlined"
    New-Variable -Name ANSI_End       -Option AllScope -Force -Scope Global -Value "$([char]0x1b)[0m"                                    -Description "0: end of ANSI, reset to default."
}
#endregion
#region Set-MessageType
Function Set-MessageType {
    <#
        .SYNOPSIS
        A function to load the customized message type shown on screen or into log.
        
        .DESCRIPTION
        This allow to custom and fix output message, formating in a common way text as you need. 
        From there, the scripts use variable and you don't have to remember whch text is used each time...

        .NOTES
        Version 01.00.00 By l. Veirman MSSEC
    #>
    # simple text
    New-Variable -Name isError    -Option AllScope -Force -Scope Global -Value "!error!"
    New-Variable -Name isWarning  -Option AllScope -Force -Scope Global -Value "warning"
    New-Variable -Name isFailed   -Option AllScope -Force -Scope Global -Value "failed!"
    New-Variable -Name isSuccess  -Option AllScope -Force -Scope Global -Value "success"
    New-Variable -Name isCanceled -Option AllScope -Force -Scope Global -Value "canceld"
    New-Variable -Name isSkipped  -Option AllScope -Force -Scope Global -Value "skipped"
    New-Variable -Name isRunning  -Option AllScope -Force -Scope Global -Value "running"
    New-Variable -Name isWaiting  -Option AllScope -Force -Scope Global -Value "waiting"

    # colorized text
    New-Variable -Name colError    -Option AllScope -Force -Scope Global -Value "$($FG_Red)!error!$($ANSI_End)"
    New-Variable -Name colWarning  -Option AllScope -Force -Scope Global -Value "$($FG_Orange)warning$($ANSI_End)"
    New-Variable -Name colFailed   -Option AllScope -Force -Scope Global -Value "$($FG_RedLight)failed!$($ANSI_End)"
    New-Variable -Name colSuccess  -Option AllScope -Force -Scope Global -Value "$($FG_GreenLight)success$($ANSI_End)"
    New-Variable -Name colCanceled -Option AllScope -Force -Scope Global -Value "$($FG_Purple)canceld$($ANSI_End)"
    New-Variable -Name colSkipped  -Option AllScope -Force -Scope Global -Value "$($FG_Turquoise)skipped$($ANSI_End)"
    New-Variable -Name colRunning  -Option AllScope -Force -Scope Global -Value "$($BG_Purple)running$($ANSI_End)"
    New-Variable -Name colWaiting  -Option AllScope -Force -Scope Global -Value "$($FG_BrightCyan)waiting$($ANSI_End)"
}
#endregion