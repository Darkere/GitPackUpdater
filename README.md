# GitPackUpdater
Little script that updates packs from git

Create an instance in your preferred launcher.
Open the instance folder (folder with the mods, logs, saves folders)
Close your launcher
Run "Run UpdateInstall.bat"
Restart launcher and launch the game!

Optional:
To Update to latest dev run the bat file again, and you are done.
The Script defaults to the master branch. You can change that in the ps1 file near the top. 
(You may need to change to -ep parameter in the other script to Bypass as changing the file invalidates the singing)

To Update to a specific commit, edit the updateInstall.ps1 and enter the sha in the $Commit variable.

*Windows only right now
