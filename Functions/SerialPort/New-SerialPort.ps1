$Prerequisites = @(
    'powershell.poecoh.com/GitApi.ps1'
    'powershell.poecoh.com/Classes/SerialPort/ValidDynamicNames.ps1',
    'powershell.poecoh.com/Classes/SerialPort/ValidDynamicPortNames.ps1',
    'powershell.poecoh.com/Classes/SerialPort/ValidDynamicServices.ps1'
)
ForEach ($Item In $Prerequisites) 
{Invoke-RestMethod -Uri $Item -Method Get | Invoke-Expression}

Function New-SerialPort {
    [CmdletBinding()]
    [OutputType([System.IO.Ports.SerialPort])]

    Param (

        # PortName. Uses a dynamic class to show all currenlty valid port names. Only what is currently plugged in will be shown.
        [Parameter()]
        [ValidateSet([ValidDynamicPortNames])]
        [System.String]$PortName,

        # BaudRate, I'll add the others when I know everything works
        [Parameter()]
        [ValidateSet(
            75, 110, 134, 150, 300, 600, 1200, 1800, 2400, 4800,
            7200, 9600, 14400, 19200, 38400, 57600, 115200, 128000
        )]
        [System.Int32]$BaudRate = 9600,

        # Parity
        [Parameter()]
        [ValidateSet(
            [System.IO.Ports.Parity]::None,
            [System.IO.Ports.Parity]::Odd,
            [System.IO.Ports.Parity]::Even,
            [System.IO.Ports.Parity]::Mark,
            [System.IO.Ports.Parity]::Space
        )]
        [System.IO.Ports.Parity]$Parity = [System.IO.Ports.Parity]::None,

        # DataBits
        [Parameter()]
        [ValidateSet(5,6,7,8)]
        [System.Int32]$DataBits = 8,

        # StopBits
        [Parameter()]
        [ValidateSet(
            [System.IO.Ports.StopBits]::None,
            [System.IO.Ports.StopBits]::One,
            [System.IO.Ports.StopBits]::OnePointFive,
            [System.IO.Ports.StopBits]::Two
        )]
        [System.IO.Ports.StopBits]$StopBits = [System.IO.Ports.StopBits]::One,

        # NewLine `r = CR, `n = LF/NL, `r`n = CRLF
        [Parameter()]
        [System.String]$NewLine = "`r`n",
        
        # DtrEnable
        [Parameter()]
        [Switch]$DtrEnable,

        # RtsEnable
        [Parameter()]
        [Switch]$RtsEnable,

        # ReadTimeout in milliseconds. Currently 1 to 100000.
        [Parameter()]
        [ValidateRange(1,100000)]
        [System.Int32]$ReadTimeout = 10000,

        # Filter by Name. This uses a dynamic class to fetch all currently valid names. If one is not plugged in it will not show.
        [Parameter()]
        [ValidateSet([ValidDynamicNames])]
        [System.String]$Name,

        # Filter by Service. This uses a dynamic class to fetch all currently valid services. If one is not plugged in it will not show.
        [Parameter()]
        [ValidateSet([ValidDynamicServices])]
        [System.String]$Service

    )

    Process {

        If ($PortName -Eq '') {

            $Ports = (Get-CimInstance -ClassName Win32_PnPEntity -Filter "PnPClass = 'Ports'")
            #$Ports = (Get-PnPDevice).Where({$_.Class -Eq 'Ports' -And $_.Present -Eq $True -And $_.Status -Eq 'OK'})
            If ($Service -NE '' -And $Ports.Length -GT 1) {$Ports = $Ports.Where({$_.Service -Eq $Service})}
            If ($Name -NE '' -And $Ports.Length -GT 1) {$Ports = $Ports.Where({$_.Name -Match $Name})}
            If ($Ports.Length -GT 1) {Throw 'More than one port has been caught by the selected filters'}
            $PortName = ([RegEx]'\((COM\d+)\)').Match($Ports.Name).Groups[1].Value

        }

        $Port = [System.IO.Ports.SerialPort]::New($PortName,$BaudRate,$Parity,$DataBits,$StopBits)
        $Port.NewLine = $NewLine
        $Port.ReadTimeout = $ReadTimeout
        If ($DtrEnable.IsPresent) {$Port.DtrEnable = $True}
        If ($RtsEnable.IsPresent) {$Port.RtsEnable = $True}

        Write-Output -InputObject $Port

    }

    <#
    .Synopsis
    To do

    .Example
    $Port = New-SerialPort -PortName COM3 -BaudRate 115200 -RtsEnable -DtrEnable

    .Example
    $Port = New-SerialPort COM3 9600 None 8 One "`r`n"


    .Example
    # Unknown PortName or moving target, this will take longer to run as it has to search Get-PnPDevice
    $Port = New-SerialPort -Name 'USB Serial Device' -Service usbser
    #>

}