<h3 align="center">Configuration Manager Repo</h3>

<p align="center">
  Hello! 👋 Welcome to my repo of Configuration Manger tools. Enjoy your stay!
</p>

## Table of Contents

- [SUG Tool Box](#sug-tool-box)
- [Get Update Source Files](#get-update-source-files)
- [Create CM Collection Environment](#create-cm-collection-environment)
- [Functions](#functions)
  - [Sort-CMDrivers](#sort-cmdrivers)
  - [Write-Log](#write-log)

# Scripts

## SUG Tool Box <a name="sug-tool-box"></a>
[SUG-Toolbox.ps1](https://github.com/Sam-3-git/Configuration-Manager-PS-Scripts/blob/main/Scripts/SUG-Toolbox.ps1)

Script used to perform creation, modification, and removal of Software Update Groups. Contains a user-driven menu to allow a more user-friendly experience.

### Parameters

- **SiteCode**
  - ConfigMan Site Code
- **ProviderMachineName**
  - ConfigMan Site Server FQDN
- **Menu**
  - Whether to run in menu mode. Menu mode allows the user to make selections based on input versus parameter mode where desired configurations are passed. Menu can be called to start the SUG Toolbox menu with any other parameters defined.
- **CreateSUG**
  - Specify a SUG name to create an empty SUG. CreateSUG is also available in MENU mode. Only one SUG can be created at a time with this parameter.
- **TargetSUG**
  - Specify SUG name(s) to target update membership. Target SUG(s) will be populated with any updates found in the SourceSUG(s). TargetSUG will only work with SourceSUG also defined.
- **SourceSUG**
  - Specify SUG name(s) to get update membership from. The Source SUG(s) will have their update membership scanned. Any updates found will be populated into the Target SUG. SourceSUG will only work when TargetSUG is also defined.
- **RemoveAllUpdates**
  - Specify SUG name(s) to remove all update membership. The passed SUG(s) will have all current update membership removed.
- **DeleteSUG**
  - Specify SUG name(s) to delete. The passed SUG(s) will be removed.

### Examples

```powershell
# To start script in MENU mode
SUG-Toolbox.ps1 -SiteCode "ABC" -ProviderMachineName "HOSTNAME.domain" -Menu

# To create a new empty SUG
SUG-Toolbox.ps1 -SiteCode "ABC" -ProviderMachineName "HOSTNAME.domain" -CreateSUG "Example SUG01"

# To create a new empty SUG then start MENU mode
SUG-Toolbox.ps1 -SiteCode "ABC" -ProviderMachineName "HOSTNAME.domain" -CreateSUG "Example SUG01" -Menu

# To create update membership on a Target SUG that is defined in a Source SUG
SUG-Toolbox.ps1 -SiteCode "ABC" -ProviderMachineName "HOSTNAME.domain" -TargetSUG "No Membership SUG01" -SourceSUG "Many Update Membership SUG01"

# To create update membership on a newly created Target SUG that is defined in multiple Source SUG(s)
SUG-Toolbox.ps1 -SiteCode "ABC" -ProviderMachineName "HOSTNAME.domain" -CreateSUG "New SUG01" -TargetSUG "New SUG01" -SourceSUG "Many Update Membership SUG01","Many Update Membership SUG02"

# To remove all updates from SUG(s)
SUG-Toolbox.ps1 -SiteCode "ABC" -ProviderMachineName "HOSTNAME.domain" -RemoveAllUpdates "Many Update Membership SUG01","Many Update Membership SUG02"

# To delete SUG(s)
SUG-Toolbox.ps1 -SiteCode "ABC" -ProviderMachineName "HOSTNAME.domain" -DeleteSUG "Old SUG01","Old SUG02"

# To do all operations
SUG-Toolbox.ps1 -SiteCode "ABC" -ProviderMachineName "HOSTNAME.domain" -CreateSUG "New SUG01" -TargetSUG "New SUG01" -SourceSUG "Old SUG01","Old SUG02" -RemoveAllUpdates "Old SUG01" -DeleteSUG "OldSUG02" -Menu
```

The passed parameters are run in the following order: 
- CreateSUG
- TargetSUG
- SourceSUG
- RemoveAllUpdates
- DeleteSUG
- Menu

## Get Update Source Files <a name = "GetUpdateSourceFiles"></a>
[Get-UpdateSourceFile](https://github.com/Sam-3-git/Configuration-Manager-PS-Scripts/blob/main/Scripts/Get-UpdateSourceFile.ps1)

Script used to obtain software update source binaries. This script will query config man to pull microsoft download locations per target software update. There is the option to download to a source directory or create a download script which can be run on any internet connected system. Creates the following directory structure in the root of where script is run:
- \GetUpdateSourceFiles (contains log files and any generated scripts)
    - \SourcedFiles (contains sourced update binaries. point to this folder when downloading an update from within the config man console.)

Target updates must be present in Config Man. Not tested with 3rd Party Update Publishers. 

    .PARAMETER Articles
        Specify Article IDs to search for in ConfigMan. Article IDs or Article Titles can also be passed.

    .PARAMETER SiteCode
        ConfigMan Site Code

    .PARAMETER ProviderMachineName
        ConfigMan Site Server FQDN

    .PARAMETER GenerateScript
        Switch to Generate a download script to use from an internet connected system

    .EXAMPLE
        # To Download Files for one KB
        Get-UpdateSourceFiles.ps1  -SiteCode "ABC" -ProviderMachineName "HOSTNAME.domain" -Articles "5031539"
   
    .EXAMPLE
        # To Download Files for multiple KB
        Get-UpdateSourceFiles.ps1  -SiteCode "ABC" -ProviderMachineName "HOSTNAME.domain" -Articles "5031539","4484104"

    .EXAMPLE
        # To generate a script a download script to run later
        Get-UpdateSourceFiles.ps1  -SiteCode "ABC" -ProviderMachineName "HOSTNAME.domain" -Articles "5031539" -GenerateScript
   
    .EXAMPLE
        # To download based off Article Name
        Get-UpdateSourceFiles.ps1  -SiteCode "ABC" -ProviderMachineName "HOSTNAME.domain" -Articles "Microsoft Edge-Beta Channel Version 120 Update for ARM64 based Editions (Build 120.0.2210.22)"

    .EXAMPLE
        # To download based off Wildcard. NOTE: passed argument will be processed as 1 Article
        Get-UpdateSourceFiles.ps1  -SiteCode "ABC" -ProviderMachineName "HOSTNAME.domain" -Articles "*Windows 10*"

## Create CM Collection Enviorment <a name = "CreateCMCollectionEnviorment"></a>
[Create-CMCollectionEnviorment](https://github.com/Sam-3-git/Configuration-Manager-PS/tree/main/Scripts/Create-CMCollectionEnviorment)

Script used to create CM device collections for new or existing enviorments. Create-CMCollectionEnviorment.ps1 and Create-CMCollectionEnviorment.csv must be in the same directory when running Create-CMCollectionEnviorment.ps1. Simply add additional values to the csv if custom collections are wanted in addition to the exisiting Create-CMCollectionEnviorment.csv file. Some collections depend on additional hardware classes to be enabled in the Client Settings. 

    .PARAMETER SiteCode
        ConfigMan Site Code

    .PARAMETER ProviderMachineName
        ConfigMan Site Server FQDN

    .EXAMPLE
        Create-CMCollectionEnviorment.ps1 -SiteCode "ABC" -ProviderMachineName "HOSTNAME.domain"

# Functions <a name = "Functions"></a>
Various [Functions](https://github.com/Sam-3-git/Configuration-Manager-PS/tree/main/Functions) used for quick ConfigMan tasks.

[Sort-CMDrivers](https://github.com/Sam-3-git/Configuration-Manager-PS/blob/main/Functions/Sort-CMDrivers)

This PowerShell function organizes Configuration Manager (CM) drivers based on a specified criterion ($SortBy). It creates folders under the "Driver" parent folder using $SortBy as the folder name, then moves CM objects into these folders according to the sorting criteria. Finally, it prompts the user to reload the CM console to view the changes.
    
    .EXAMPLE
        # Sort a single driver
        Get-CMDriver -Name "Intel(R) Precise Touch Device" -Fast | Sort-CMDrivers -SortBy "Touch Drivers"
   
    .EXAMPLE
        # Sort by user citeria
        Get-CMDriver -Fast | Where-Object {$_.DriverProvider -eq "Microsoft"} | Sort-CMDrivers -SortBy "Microsoft"

    .EXAMPLE
        # Sort all drivers by class
        Get-CMDriver -Fast | Select-Object -ExpandProperty DriverClass -Unique | ForEach-Object -Process {Get-CMDriver -Fast | Where-Object -Property DriverClass -EQ $_ | Sort-CMDrivers -SortBy $_}

[Write-Log](https://github.com/Sam-3-git/Configuration-Manager-PS/blob/main/Functions/Write-Log)

This PowerShell function is designed to write logs that are easily interperted by CMTrace.exe.

    .EXAMPLE
    Write-Log -Message "Info: This is the start of the log" -Severity 1 -Component "BEGIN"

    .EXAMPLE
    Write-Log -Message "Warning: This is a warning in the middle of the log" -Severity 2 -Component "PROCESS"

    .EXAMPLE
    Write-Log -Message "Error: This is a terminiating error for some process... $SomeProcessPassedExitCode" -Severity 3 -Component "END"
