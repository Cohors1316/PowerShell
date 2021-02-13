Class ValidDynamicServices : System.Management.Automation.IValidateSetValuesGenerator {
    [System.String[]] GetValidValues() {Return (Get-PnPDevice).Where({$_.Class -Eq 'Ports'}).Service}
}