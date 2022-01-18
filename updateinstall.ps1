
### Feel free to change these Values
$GitURL = 'https://github.com/EnigmaticaModpacks/Enigmatica6'
$GitFolderName = 'EnimaticaGithub'
$InstanceName = "Enigmatica Dev"
$Commit = "";
###

#Global Variables
$InstanceFolder = Get-Location
$GitFolder = Join-Path $InstanceFolder $GitFolderName
$Forge = $null
$Json = $null

function Read-OldJson {
# Try read out the old instance name
    if(Test-Path -Path (Join-Path $InstanceFolder "minecraftinstance.json")) {
        $oldjson = Get-Content (Join-Path $InstanceFolder "minecraftinstance.json") -raw | ConvertFrom-Json
        $InstanceName = $oldjson.name
    }
}

function Test-Prerequisites {
    # Check if git works
    try {
        git | Out-Null
        Write-Host "Git is installed"
    } catch [System.Management.Automation.CommandNotFoundException] {
        Write-Host "Git Commands not working" -ForegroundColor Red
        Write-Host "Install Git to use this script"
        pause
        exit
    }

    #Check if Java is Installed
    try {
        java -version | Out-Null
        Write-Host "Java is installed"
    } catch [System.Management.Automation.CommandNotFoundException] {
        Write-Host "Java Commands are not working." -ForegroundColor Red
        Write-Host "Install Java to use this script"
        pause
        exit
    }
}

function Update-Git {
    if(!(Test-Path -Path $GitFolder)) {
        git clone -b develop --progress $GitURL $GitFolderName
    }

    if($Commit.Equals("")) {
        git -C $GitFolderName pull
    } else {
         git -C $GitFolderName fetch
         git -C $GitFolderName merge $Commit
    }
}

function Copy-Files {
    #copy files over
    robocopy $GitFolder $InstanceFolder /mt /e /it /z /im
}

function Update-Mods {
    java -jar Instancesync.jar
}

function Repair-InstanceJson {
    # fix up instance.json
    $Json = Get-Content (Join-Path $InstanceFolder "minecraftinstance.json") -raw | ConvertFrom-Json
    $Json.name = $InstanceName

    $Json.installPath = $InstanceFolder.ToString().Replace('\', '\\')
    $global:Forge = $Json.baseModLoader.forgeVersion
}

function Write-ForgeUpdateInfo {
    Write-Host "################################################################################"
    Write-Host ""
    Write-Host "Keep in mind that this script does not update forge! Use your launcher to Update!"
    Write-Host ""
    Write-Host "Current Commit is on " -ForegroundColor Red -NoNewline
    Write-Host $Forge
    Write-Host ""
    Write-Host "################################################################################"
    Start-Sleep -Seconds 5
}

#keep old name
Read-OldJson

#check for git and java
Test-Prerequisites

#clone or pull from github
Update-Git

#move from git to instance
Copy-Files

#run instance sync
Update-Mods

#repair paths in minecraftinstance.json
Repair-InstanceJSon

#remind of forge updates
Write-ForgeUpdateInfo