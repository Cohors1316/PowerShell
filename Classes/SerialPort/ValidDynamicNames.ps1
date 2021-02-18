Class ValidDynamicNames : System.Management.Automation.IValidateSetValuesGenerator {
    [System.String[]]GetValidValues() {
        $Names = [System.Collections.Generic.List[System.String]]::New()
        ForEach ($Name In (Get-CimInstance -ClassName Win32_PnPEntity -Filter "PnPClass = 'Ports'").Name) {
            $Names.Add(([RegEx]'(.*)\(COM\d+\)').Match($Name).Groups[1].Value.TrimEnd(' '))
        }
        Return $Names
    }
}