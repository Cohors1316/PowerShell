Function Get-Git.psm1 {
    Param (
        $Org,
        Repo,
        $Dir,
        $Token
    )
    $GitHub = "https://api.github.comm/repos/$Or/$Repo/contents/$Dir"
    $Rest = @{
        Uri = $GitHub
        Method = 'Get'
        Headers = @{'Authorization' = "Basic $Token"}
        Body = $Null
    }
    $Content = (Invoke-RestMethod @Rest).content
    $Content = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($Content))
    Write-Output -InputObject $Content
}