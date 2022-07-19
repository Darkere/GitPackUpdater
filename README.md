# GitPackUpdater
Little script that updates packs from git

1. Create an instance in your preferred launcher.
2. Open the instance folder (folder with the mods, logs, saves folders)
3. Close your launcher
4. Run "Run UpdateInstall.bat"
5. Restart launcher and launch the game!

Optional:
- To Update to latest dev run the bat file again, and you are done.
- The Script defaults to the master branch. You can change that in the ps1 file near the top. 
(You may need to change to -ep parameter in the other script to Bypass as changing the file invalidates the singing)

- To Update to a specific commit, edit the updateInstall.ps1 and enter the sha in the $Commit variable.

*Windows only right now. Feel free to PR
