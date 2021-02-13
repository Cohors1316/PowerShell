Class ValidDynamicFriendlyNames : System.Management.Automation.IValidateSetValuesGenerator {
    [System.String[]]GetValidValues() {
        $FriendlyNames =  (Get-PnPDevice).Where({$_.Class -Eq 'Ports'}).FriendlyName
        $Array = [System.Collections.Generic.List[String]]::New()
        ForEach ($FriendlyName In $FriendlyNames) {
            $Array.Add(([RegEx]'(.*)\(COM\d+\)').Match($FriendlyName).Groups[1].Value.TrimEnd(' '))
        }
        Return $Array
    }
}