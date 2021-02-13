Class ValidDynamicPortNames : System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {Return [System.IO.Ports.SerialPort]::GetPortNames()}
}