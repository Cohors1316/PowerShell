Function Get-Git {
    Param (
        $Org,
        Repo,
        $Dir,
        $Token
    )
    $GitHub = "https://api.github.comm/repos/$Org/$Repo/contents/$Dir"
    $Rest = @{
        Uri = $GitHub
        Method = 'Get'
        Headers = @{'Authorization' = "Basic $Token"}
        Body = $Null
    }
    $Sha = (Invoke-RestMethod @Rest).sha
    
    
    $Content = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($Content))
}
