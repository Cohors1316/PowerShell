Function Get-Git {
    [CmdletBinding()]

    Param (

        [Parameter(Mandatory)]
        [System.String]$Org,

        [Parameter(Mandatory)]
        [System.String]$Repo,

        [Parameter()]
        [System.String]$Directory,

        [Parameter()]
        $Token,

        [Parameter()]
        [Switch]$Raw,

        [Parameter()]
        [System.String]$Branch = 'master'

    )

    Process {

        $Rest = @{

            Uri = "https://api.github.comm/repos/$Org/$Repo/contents/$Dir"
            Method = 'Get'
            Headers = If ($Token -NE '') { @{'Authorization' = "Basic $Token"} } Else { $Null }
            Body = $Null

        }
    
        $Content = (Invoke-RestMethod @Rest).content
        $Content = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($Content))
        Write-Output -InputObject $Content

    }

}
