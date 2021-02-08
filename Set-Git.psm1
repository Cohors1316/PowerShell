<#
 .Synopsis
  Pushes a file to GitHub.

 .Description
  This function will use GitHub API PUT to upload a file to the designated repository.

 .Parameter Org
  The user or organization that owns the repository.

 .Parameter Repo
  The name of the repository.

 .Parameter Dir
  The directory to the file.

 .Parameter Token
  The personal access token used to access the repository. Required for private repos.

 .Example
   # Show a default display of this month.
   Set-Git -Org PoeCoh -Repo PowerShell -Dir Set-Git.psm1 -Token $Token
#>

Function Get-Git {
    Param (
        $Org,
        $Repo,
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
