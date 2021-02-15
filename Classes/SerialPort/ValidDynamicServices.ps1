Class ValidDynamicServices : System.Management.Automation.IValidateSetValuesGenerator {
    [System.String[]] GetValidValues() {Return (Get-PnPDevice -Class Ports -Status OK -PresentOnly).Service}
}
