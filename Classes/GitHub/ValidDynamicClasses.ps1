Class ValidDynamicClasses : System.Management.Automation.IValidateSetValuesGenerator {
    [System.String[]]GetValidValues() {
        $Folders = Invoke-RestMethod -Uri https://github.com/Cohors1316/PowerShell/tree/master/Classes/ -Method Get
    }
}