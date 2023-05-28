# .dotfiles

My personal dotfiles, with a script to backup/restore them.  Also includes can install a few essential packages (manually created)


## Usage


- backup: `./backup.sh save /path/to/home`
					 ^
	- leave `/` off the end
- restore: `./backup.sh restore /path/to/home`
	- includes an option to setup `dwm` and/or `st`
	- installs packages first
- install essential packages only: `./backup.sh pkgs /path/to/home`   
