Class ValidDynamicClasses : System.Management.Automation.IValidateSetValuesGenerator {
    [System.String[]]GetValidValues() {
        $Folders = (Invoke-RestMethod -Uri "$GitApi/contents/Classes/" -Method Get).path
        $Classes = [System.Collections.Generic.List[System.Object]]
        ForEach ($Folder In $Folders) {
            $Classes.Add($(Invoke-RestMethod -Uri "api.powershell.poecoh.com/contents/$Folder/"))
        }
    }
}

$Test = [System.Collections.Generic.List[System.Object]]