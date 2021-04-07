Function Open-FolderBrowserDialog {
    
    [CmdletBinding()]
    Param (

        #todo
        [Parameter()]
        [Switch]
        $AutoUpgradeEnabled,

        #todo
        [Parameter()]
        [System.String]
        $Description = $Null,

        #todo, This does not work with autoupgrade enabled, believe it is a windows issue.
        [Parameter()]
        [ValidateSet(

            [System.Environment+SpecialFolder]::AdminTools,
            [System.Environment+SpecialFolder]::ApplicationData,
            [System.Environment+SpecialFolder]::CDBurning,
            [System.Environment+SpecialFolder]::CommonAdminTools,
            [System.Environment+SpecialFolder]::CommonApplicationData,
            [System.Environment+SpecialFolder]::CommonDesktopDirectory,
            [System.Environment+SpecialFolder]::CommonDocuments,
            [System.Environment+SpecialFolder]::CommonMusic,
            [System.Environment+SpecialFolder]::CommonOemLinks,
            [System.Environment+SpecialFolder]::CommonPictures,
            [System.Environment+SpecialFolder]::CommonProgramFiles,
            [System.Environment+SpecialFolder]::CommonProgramFilesX86,
            [System.Environment+SpecialFolder]::CommonPrograms,
            [System.Environment+SpecialFolder]::CommonStartMenu,
            [System.Environment+SpecialFolder]::CommonStartup,
            [System.Environment+SpecialFolder]::CommonTemplates,
            [System.Environment+SpecialFolder]::CommonVideos,
            [System.Environment+SpecialFolder]::Cookies,
            [System.Environment+SpecialFolder]::Desktop,
            [System.Environment+SpecialFolder]::DesktopDirectory,
            [System.Environment+SpecialFolder]::Favorites,
            [System.Environment+SpecialFolder]::Fonts,
            [System.Environment+SpecialFolder]::History,
            [System.Environment+SpecialFolder]::InternetCache,
            [System.Environment+SpecialFolder]::LocalApplicationData,
            [System.Environment+SpecialFolder]::LocalizedResources,
            [System.Environment+SpecialFolder]::MyComputer,
            [System.Environment+SpecialFolder]::MyDocuments,
            [System.Environment+SpecialFolder]::MyMusic,
            [System.Environment+SpecialFolder]::MyPictures,
            [System.Environment+SpecialFolder]::MyVideos,
            [System.Environment+SpecialFolder]::NetworkShortcuts,
            [System.Environment+SpecialFolder]::Personal,
            [System.Environment+SpecialFolder]::PrinterShortcuts,
            [System.Environment+SpecialFolder]::ProgramFiles,
            [System.Environment+SpecialFolder]::ProgramFilesX86,
            [System.Environment+SpecialFolder]::Programs,
            [System.Environment+SpecialFolder]::Recent,
            [System.Environment+SpecialFolder]::Resources,
            [System.Environment+SpecialFolder]::SendTo,
            [System.Environment+SpecialFolder]::StartMenu,
            [System.Environment+SpecialFolder]::Startup,
            [System.Environment+SpecialFolder]::System,
            [System.Environment+SpecialFolder]::SystemX86,
            [System.Environment+SpecialFolder]::Templates,
            [System.Environment+SpecialFolder]::UserProfile,
            [System.Environment+SpecialFolder]::Windows

        )]
        $RootFolder = [System.Environment+SpecialFolder]::DesktopDirectory,

        #todo
        [Parameter()]
        [Switch]
        $ShowNewFolderButton,

        #todo
        [Parameter()]
        [Switch]
        $UseDescriptionForTitle

    )
    #I do intend on adding pipe at some point, thus why its split up
    Begin {

        Add-Type -AssemblyName System.Windows.Forms
        $FolderBrowserDialog = [System.Windows.Forms.FolderBrowserDialog]::New()
        $FolderBrowserDialog.AutoUpgradeEnabled = If ($AutoUpgradeEnabled.IsPresent) {$True} Else {$False}
        $FolderBrowserDialog.Description = $Description
        $FolderBrowserDialog.RootFolder = $RootFolder
        $FolderBrowserDialog.ShowNewFolderButton = If ($ShowNewFolderButton.IsPresent) {$True} Else {$False}
        $FolderBrowserDialog.UseDescriptionForTitle = If ($UseDescriptionForTitle.IsPresent) {$True} Else {$False}

    }
    Process {

        Write-Output -InputObject @{

            Result = $FolderBrowserDialog.ShowDialog()
            Path = $FolderBrowserDialog.SelectedPath

        }

    }
    End {

        $FolderBrowserDialog.Dispose()
    
    }

}
