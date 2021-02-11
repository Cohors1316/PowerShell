Function Get-SerialPort {
    [CmdletBinding()]

    Param (

        # Filter by Name
        [Parameter()]
        [String]$Name,

        # Filter by service type
        [Parameter()]
        [ValidateSet('usbser')]
        [String]$Service

    )

    Process {

        $Port = (Get-PnPDevice).Where({$_.Present -Eq $True -And $_.Class -Eq 'Ports'})
        $Port = $Port.Where({$_.Name -Match $Name -And $_.Service -Eq $Service})

        $Port = New-Object -TypeName System.IO.Ports.SerialPort -Property @{
            PortName = ([RegEx]'COM\d+').Match($Port.FriendlyName).Value
        }

        Write-Output -InputObject $Port

    }

    <#
        .SYNOPSIS
        To do

        .DESCRIPTION
        To do

        .EXAMPLE
        To do

        .EXAMPLE
        To do

        .EXAMPLE
        To do

        .INPUTS
        To do

        .OUTPUTS
        To do
                
        .NOTES
        To do

        .FUNCTIONALITY
        To do
    
    #>
}
Function Send-Command {
    [CmdletBinding()]

    Param (

        # Command to send
        [Parameter(Mandatory)]
        [String]$Send,

        # Expected reply
        [Parameter(Mandatory)]
        [String]$Expect,

        # Port object, see Get-SerialPort
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [System.IO.Port.SerialPort]$Port,

        # Disable sending NewLine with command
        [Switch]$NoNewLine

    )

    Process {

        Write-Host -Object $Send -NoNewline -ForegroundColor Gray

        $Port.Open()

        If ($NoNewLine.IsPresent) {$Port.Write($Send)}
        Else {$Port.WriteLine($Send)}

        Start-Sleep -Milliseconds 10
        $Line = $Port.ReadExisting()

        $Port.Close()

        $Output = New-Object -TypeName PSObject -Property @{
            Port = $Port
            Line = $Receive
            Result = If ($Line -Match $Expect) {$True} Else {$False}
        }

        $Color = If ($Output.Result -Eq $False) {'Red'} Else {'White'}
        Write-Host -Object $Line -ForegroundColor $Color

        Write-Output -InputObject $Output

    }

    <#
        .SYNOPSIS
        To do

        .DESCRIPTION
        To do

        .EXAMPLE
        To do

        .EXAMPLE
        To do

        .EXAMPLE
        To do

        .INPUTS
        To do

        .OUTPUTS
        To do
                
        .NOTES
        To do

        .FUNCTIONALITY
        To do
    #>
}
