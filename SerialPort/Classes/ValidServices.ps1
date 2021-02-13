Class ValidServices : System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {Return (Get-PnPDevice).Where({$_.Class -Eq 'Ports'}).Service}
}