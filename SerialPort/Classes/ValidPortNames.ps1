Class ValidPortNames : System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {Return [System.IO.Ports.SerialPort]::GetPortNames()}
}