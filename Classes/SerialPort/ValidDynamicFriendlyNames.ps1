Class ValidDynamicFriendlyNames : System.Management.Automation.IValidateSetValuesGenerator {
    [System.String[]]GetValidValues() {
        $FriendlyNames =  (Get-CimInstance -ClassName Win32_PnPEntity -Filter "PnPClass = 'Ports'").Name
        $Array = [System.Collections.Generic.List[String]]::New()
        ForEach ($FriendlyName In $FriendlyNames) {
            $Array.Add(([RegEx]'(.*)\(COM\d+\)').Match($FriendlyName).Groups[1].Value.TrimEnd(' '))
        }
        Return $Array
    }
}
