# GitPackUpdater
This Script allows you to Update a Pack via Git

## Installation

Prerequisites: 
 - [Git](https://git-scm.com/downloads)
 - [Java](https://adoptium.net/)

Step 1: Download the Latest Release from the [releases section](https://github.com/Darkere/GitPackUpdater/releases/)

Step 2: Create a Forge Instance in your preferred launcher
  - [Curseforge](https://i.imgur.com/W2lKQul.png)
  - MultiMc/Prism: 
  - GDLauncher:


Step 3: Close your launcher (it may interfere with the install process)

Step 4: Open up the Instance folder
  - [Curseforge:](https://i.imgur.com/EoDqNCg.png)
  - MultiMc/Prism:
  - GDLauncher:


Step 5: Copy the Content of the Release zip file into the Instance Folder

![image](https://github.com/Darkere/GitPackUpdater/assets/4283717/d993ae0a-fafe-46b0-82f8-7bb2e319cde0)

Step 6: Run the "Run UpdateInstall.bat" file 

Step 7: Restart launcher and launch the game!

## Updating
To update the pack:

Step 1: Close Launcher

Step 6: Run the "Run UpdateInstall.bat" file 

Step 7: Restart launcher and launch the game!


## Options
- The Script defaults to the master branch. You can change that in the ps1 file near the top. 
(You may need to change to -ep parameter in the batch script to Bypass as changing the file invalidates the signing)

- To Update to a specific commit, edit the updateInstall.ps1 and enter the sha in the $Commit variable.

*Windows only right now. Feel free to PR
