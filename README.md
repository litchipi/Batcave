# Batcave
Pentesting environment with eased backup &amp; project switch capabilities.

# Usage
The pentesting environment is inside the "env" folder
Execute the "env" symlink to create a new project (a CTF box for exemple) to setup a new pentesting environment

## Environment
### Loading / creating: env script
```
./env <name of the environment>
```
When creating the environment, the script will:
- Create a new git repository inside the env/ folder (if no repository already exists)
- Create a new branch in the repository
- Create a file "notes" and a folder "nobck"
- Hides the "env" script symlink, create the "quit_env" symlink
If you call "env RESET", it will erase the git repository and create a new one.
So please don't call your environment "RESET".

### Quitting: quit_env
```
./quit_env
```
Used to quit the environment, this script will:
- Add all files (except the files inside the "nobck" folder) as changes to the repository
- Commit changes to the git branch
- Hides the folder nobck and rename to nobck_<name of the env>
- Reveal the "env" script symlink and delete the "quit_env" symlink

### Backup
```
./backup_all.sh <additionnal files>
```
You can backup everything by simply execute the backup_all.sh script. It will:
- Go into each branch of the "env/" folders git repo, and create patches from the root of the branch
- Zip all the patches files, deflated
- Zip as well the additionnal files passed in parameters
- Use CantReadTh1s to encrypt the archive (and remove the original)
Store somewhere safe, and enjoy !

### Restore
```
./restore_env_bck.sh <bck file>
```
- Decrypt the file with CantReadTh1s
- Unzip all
- Re-create the git repository, add branches and apply changes to them using the patch files
- Delete zipfile (will keep the encrypted backup file)

## Prerequisites
* [Git](https://git-scm.com/) - Versionning tool
* [CantReadTh1s](https://github.com/litchipi/CantReadTh1s) - Simple one line encryption python3 tool

## Aimed to work with
* [HomeSweetHome](https://github.com/litchipi/homesweethome) - Tool to create tmux projects, restore templates, have multiple software configurations based on the project, automatic logging of windows (and backup of them), etc ...
