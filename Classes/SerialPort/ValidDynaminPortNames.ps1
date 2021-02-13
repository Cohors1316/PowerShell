Class ValidDynamicPortNames : System.Management.Automation.IValidateSetValuesGenerator {
    [System.String[]] GetValidValues() {Return [System.IO.Ports.SerialPort]::GetPortNames()}
}