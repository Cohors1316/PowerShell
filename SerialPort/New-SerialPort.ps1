$Classes = @(
    'https://raw.githubusercontent.com/Cohors1316/PowerShell/master/SerialPort/Classes/ValidFriendlyNames.ps1',
    'https://raw.githubusercontent.com/Cohors1316/PowerShell/master/SerialPort/Classes/ValidPortNames.ps1',
    'https://raw.githubusercontent.com/Cohors1316/PowerShell/master/SerialPort/Classes/ValidServices.ps1'
)
ForEach ($Class In $Classes) {Invoke-RestMethod -Uri $Class -Method Get | Invoke-Expression}

Function New-SerialPort {
    [CmdletBinding()]
    [OutputType([System.IO.Ports.SerialPort])]

    Param (

        # PortName. Uses a dynamic class to show all currenlty valid port names. Only what is currently plugged in will be shown.
        [Parameter()]
        [ValidateSet([ValidPortNames])]
        [System.String]$PortName,

        # BaudRate, I'll add the others when I know everything works
        [Parameter()]
        [ValidateSet(
            9600,
            115200
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

        # Filter by FriendlyName. This uses a dynamic class to fetch all currently valid names. If one is not plugged in it will not show.
        [Parameter()]
        [ValidateSet([ValidFriendlyNames])]
        [System.String]$FriendlyName,

        # Filter by Service. This uses a dynamic class to fetch all currently valid services. If one is not plugged in it will not show.
        [Parameter()]
        [ValidateSet([ValidServices])]
        [System.String]$Service

    )

    Process {

        If ($PortName -Eq '') {

            $Ports = (Get-PnPDevice).Where({$_.Class -Eq 'Ports' -And $_.Present -Eq $True -And $_.Status -Eq 'OK'})
            If ($Service -NE '' -And $Ports.Length -GT 1) {$Ports = $Ports.Where({$_.Service -Eq $Service})}
            If ($FriendlyName -NE '' -And $Ports.Length -GT 1) {
                $Ports = $Ports.Where({$_.FriendlyName -Match $FriendlyName})
            }
            If ($Ports.Length -GT 1) {Throw 'More than one port has been caught by the selected filters'}
            $PortName = ([RegEx]'\((COM\d+)\)').Match($Ports.FriendlyName).Groups[1].Value

        }

        $Port = New-Object -TypeName System.IO.Ports.SerialPort -Property @{

            PortName = $PortName
            BaudRate = $BaudRate
            Parity = $Parity
            DataBits = $DataBits
            StopBits = $StopBits
            NewLine = $NewLine
            ReadTimeout = $ReadTimeout
            DtrEnable = If ($DtrEnable.IsPresent) {$True} Else {$False}
            RtsEnable = If ($RtsEnable.IsPresent) {$True} Else {$False}

        }

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
    $Port = New-SerialPort -FriendlyName 'USB Serial Device' -Service usbser
    #>

}