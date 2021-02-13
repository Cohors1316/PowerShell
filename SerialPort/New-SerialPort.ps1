Function New-SerialPort {
    [CmdletBinding()]
    [OutputType([System.IO.Ports.SerialPort])]

    Param (

        # PortName
        [Parameter()]
        [ValidateSet([ValidPortNames])]
        $PortName,

        # BaudRate
        [Parameter()]
        [ValidateSet(
            9600
        )]
        $BaudRate = 9600,

        # Parity
        [Parameter()]
        [ValidateSet(
            [System.IO.Ports.Parity]::None,
            [System.IO.Ports.Parity]::Odd,
            [System.IO.Ports.Parity]::Even,
            [System.IO.Ports.Parity]::Mark,
            [System.IO.Ports.Parity]::Space
        )]
        $Parity = [System.IO.Ports.Parity]::None,

        # DataBits
        [Parameter()]
        [ValidateSet(5,6,7,8)]
        $DataBits = 8,

        # StopBits
        [Parameter()]
        [ValidateSet(
            [System.IO.Ports.StopBits]::None,
            [System.IO.Ports.StopBits]::One,
            [System.IO.Ports.StopBits]::OnePointFive,
            [System.IO.Ports.StopBits]::Two
        )]
        $StopBits = [System.IO.Ports.StopBits]::One,

        # NewLine
        [Parameter()]
        [ValidateSet("`r","`n","`r`n")]
        $NewLine = "`r`n",
        
        # DtrEnable
        [Parameter()]
        [Switch]$DtrEnable,

        [Parameter()]
        [Switch]$RtsEnable,

        # PnPDevice.FriendlyName
        [Parameter()]
        [ValidateSet([ValidFriendlyNames])]
        $FriendlyName,

        # PnPDevice.Service
        [Parameter()]
        [ValidateSet([ValidServices])]
        $Service

    )

    Process {

        If ($Null -Eq $PortName -And $Null -NE $FriendlyName) {
            $PortName = (Get-PnPDevice).Where({
                $_.Class -Eq 'Ports' -And `
                $_.Present -Eq $True -And `
                $_.FriendlyName -Match $FriendlyName
            })
            $PortName = ([RegEx]'\((COM\d+)\)').Match($FriendlyName).Groups[1].Value
        }
        ElseIf ($Null -Eq $PortName -And $Null -Eq $FriendlyName) {
            Throw('Must supply a PortName or FriendlyName')
        }

        $Port = [System.IO.Ports.SerialPort]::new($PortName,$BaudRate,$Parity,$DataBits,$StopBits)

        If ($DtrEnable.IsPresent) {$Port.DtrEnable = $True}
        
        If ($RtsEnable.IsPresent) {$Port.RtsEnable = $True}

        Write-Output -InputObject $Port
    }

}