Class ValidDynamicServices : System.Management.Automation.IValidateSetValuesGenerator {
    [System.String[]] GetValidValues() {Return (Get-CimInstance -ClassName Win32_PnPEntity -Filter "PnPClass = 'Ports'").Service}
}
