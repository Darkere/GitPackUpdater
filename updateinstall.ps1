
### Feel free to change these Values
$GitURL = 'https://github.com/EnigmaticaModpacks/Enigmatica6'
$GitFolderName = 'EnimaticaGithub'
$InstanceName = "Enigmatica Dev"
$Commit = ""
$Branch = "master"
###

#Global Variables
$InstanceFolder = Get-Location
$GitFolder = Join-Path $InstanceFolder $GitFolderName
$Forge = $null

function Read-OldJson {
# Try read out the old instance name
    if(Test-Path -Path (Join-Path $InstanceFolder "minecraftinstance.json")) {
        $oldjson = Get-Content (Join-Path $InstanceFolder "minecraftinstance.json") -raw | ConvertFrom-Json
        $global:InstanceName = $oldjson.name
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
        git clone -b $Branch --progress $GitURL $GitFolderName 2>&1
       
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
# SIG # Begin signature block
# MIIFcAYJKoZIhvcNAQcCoIIFYTCCBV0CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUzAcSf/Vs7GMAp1lfhEJ68KYX
# +zWgggMKMIIDBjCCAe6gAwIBAgIQQLXPf+rVjblBreh/7T51xzANBgkqhkiG9w0B
# AQsFADAbMRkwFwYDVQQDDBBBVEEgQXV0aGVudGljb2RlMB4XDTIyMDcxOTE3Mzgw
# NVoXDTIzMDcxOTE3NTgwNVowGzEZMBcGA1UEAwwQQVRBIEF1dGhlbnRpY29kZTCC
# ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALRk2qIycWlTbuMNFuJvqCh0
# JLV2zaQBWgFcbMWt9/L7ZgKl+uJj9dLWDAiGMKFWkh1JgAh9NB5GEpeqNk/CF3U8
# rvC4dfAN8+tVpmPMZExAvA0Use4A0x4lS5Rawl/5U2UQtC0z8yoDT2CKcxNU6d3q
# yBADh2RmorPyfrGFN2EfzEa3mEnsbK768yQDJUOZ3N0YIlWGzQ7FFV1Nn8uHaHyj
# dEsaUMs1PxMYrkwIU/0eVEjxJS37BPhEeMCNXsjTJPtNaQsKM8G8/suITNT1Aowu
# G55kLX66hypAw7/Lfr4W0aNDXhfKGPlAonFPDGJ3SzumJaR/2/xt2aJGfCnBUz0C
# AwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMDMB0G
# A1UdDgQWBBRmUJGeBxQDp1u4kFFt8SVSiD7dzTANBgkqhkiG9w0BAQsFAAOCAQEA
# Pv1WNFiwhAvnlFXuaUhPPkhSKlxrRXaRwkeIPMumDFH4Y+7+x6O9UT8hQR809beG
# KJQzmBoOJ11wgiCiCeFGCcbpC3/quZiuuy9ckAaySiu6/JBxhwAidfausLglJVO0
# epM/Q4LiDs4b6Lgv5RXk/0oSymon9iKF4mm8SPBoeOyNigXx2AFpljNckyu8J3dJ
# PJrOtj7kRwBOBOgjMDGQEcimWU1+lYueKVDTl/pVaYtTLWEDhCi8pRXmk0EYp1qR
# RJ/u2E7dNePQ+rCGvvbwd7Q/KgAJGv06NUNXgYrycjGzBHG8G4tb/PFQxChimz+w
# iLrk4udOOvtPBNN1BWtbBTGCAdAwggHMAgEBMC8wGzEZMBcGA1UEAwwQQVRBIEF1
# dGhlbnRpY29kZQIQQLXPf+rVjblBreh/7T51xzAJBgUrDgMCGgUAoHgwGAYKKwYB
# BAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAc
# BgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUpOBX
# LMpJiyE+/IfEtbEQ6D6Qw9IwDQYJKoZIhvcNAQEBBQAEggEAmACpj9G+QkpfyapS
# BcKMfPCoV/Rg9lmCXStP/kajmxu4FIqPKTfV62iSPM5+2C58IZJDQkxBB6nN8I0f
# W8L69TxUAZxegoukkcLWLvv5Em5fAuRfkSne2Nf4EEpEkBNFxJuQFRLXu+NyZT1U
# ydnGjfZLdgpgCNCS0rGBAxtBWK+xGF3jki7E/qt1zjXBUD7mpRsIR1vLKiWad7wB
# HcZtyRksZauU98E4y65AbYbb7rXsFwsCnvfYMOJEo2kXMJ63Qpm4YJE9K1WNzy2c
# zMESciYVB8h9rZ7FvPpYJbcc+1GjxaLOJHDzooBd+2R9JcE2GMXBhckwo7vRp2wJ
# TGOrUw==
# SIG # End signature block
