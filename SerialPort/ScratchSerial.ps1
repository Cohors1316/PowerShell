<# New port stuff
    # Instantiate port
    $Port = [System.IO.Ports.SerialPort]::New('COM1',9600)

    # Register for data received event
    Register-ObjectEvent -InputObject $Port -EventName DataReceived



# Watch port stuff
    #Monitor events for new event
    Do {Start-Sleep -Milliseconds 10} Until ($Null -NE (Get-Event))
    
    # Read bytes
    $Bytes = $Port.BytesToRead
    $CharacterArray = [System.Array]::CreateInstance([Char],$Bytes)
    $Port.Read($CharacterArray,0,$Bytes)
    Get-Event | Remove-Event
    [String]::Join('',$CharacterArray)

#>

<#
Class PortProperties {
    [String]$PortName
    [Int]$BaudRate
    [System.IO.Ports.Parity]$Parity
    [Int]$DataBits
    [System.IO.Ports.StopBits]$StopBits
    [System.IO.Ports.Handshake]$Handshake
    [String]$NewLine
}

Class SerialPort {
    [System.IO.Ports.SerialPort]$Port = [System.IO.Ports.SerialPort]::New()

    [Byte[]]$ReadBuffer = [Byte[]]::New(21)

    $EventJob

    SerialPort ([PortProperties]$Props) {
        Try {
            $This.Port.PortName = [String]$Props.PortName
            $This.Port.BaudRate = [Int]$Props.BaudRate
            $This.Port.Parity = [System.IO.Ports.Parity]$Props.Parity
            $This.Port.DataBits = [Int]$Props.DataBits
            $This.Port.StopBits = [System.IO.Ports.StopBits]$Props.StopBits
            $This.Port.Handshake = [System.IO.Ports.Handshake]$Props.Handshake
            $This.Port.NewLine = [String]$Props.NewLine
            $This.Port.DtrEnable = $False
        }
        Catch {}
    }

    Start () {$This.OpenPort()}

    Stop () {
        $This.ClosePort()
        ForEach ($Event In Get-EventSubscriber) {
            Unregister-Event -SubscriptionId $Event.SubscriptionID
        }
    }

    OpenPort () {
        Try {
            Write-Debug "Opening port"
            $This.Port.Open()
            Start-Sleep -Milliseconds 1000
            $This.Port.DiscardInBuffer()
            $This.Port.DiscardOutBuffer()
        }
        Catch {
            Write-Debug "Could not open port SerialPort:OpenPort()"
            Write-Debug $_.ScriptStackTrace
        }
    }

    ClosePort () {
        Write-Debug "Closing port"
        $This.Port.Close()
        Start-Sleep -Milliseconds 1000
        $This.Port.Dispose()
    }

    [Bool]CheckOpen() {
        If ($This.Port.IsOpen) {
            Return $True
        }
        Else {
            Return $False
        }
    }

    SendData ([Byte[]]$Data) {
        If ($This.CheckOpen()) {
            If ($Null -Eq $Data) {

            }
        }
    }
}
#>