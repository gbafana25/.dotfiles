#!/bin/bash

HOME_DIR=$2
DFILES="other_dotfiles"
PD=`pwd`

install_wm() {
	echo "Downloading and installing DWM..."
	cd $HOME_DIR
	apt source dwm
	tar xvf dwm_6.*.orig.tar.gz
	cp $HOME_DIR/.dotfiles/dwm/config.h $HOME_DIR/dwm-*/
	cd $HOME_DIR/dwm-*/
	sudo make clean install

}


install_term() {
	echo "Downloading and installing st and scroll..."
	cd $HOME_DIR
	git clone https://git.suckless.org/st
	cp st/config.h $HOME_DIR/st/config.h
	cd $HOME_DIR/st/
	sudo make clean install

}

save_dotfiles() {
	# add dotfiles
	# other dotfiles are in list, dwm/st ones need to be renamed
	echo "Saving important dotfiles..."
	mkdir dwm	
	mkdir st 
	mkdir larger-st 
	cp $HOME_DIR/dwm-6.1/config.h ./dwm
	cp $HOME_DIR/st/config.h ./st
	cp $HOME_DIR/larger-st/config.h ./larger-st
	while read -r file; do
	cp -r $HOME_DIR/$file ./$DFILES
	done < dfile_list.txt
	

}

install_pkgs() {
	while read -r f; do
	sudo apt-get install -y $f
	done < short_pkg_list.txt


}


restore_dotfiles() {
	install_pkgs
	while read -r file; do
	cp -r $PD/$DFILES/$file $HOME_DIR/
	done < dfile_list.txt
	# save iptables rules
	sudo iptables-restore < $HOME/.iptables.rules
	sudo iptables-save > /etc/iptables/rules.v4
	read -p "Would you like to setup dwm? [y/n] " DFLAG
	case $DFLAG in
	Y|y) 
		install_wm
		;;
	N|n)
		echo "skipping..."
		;;
	esac

	read -p "Would you like to setup st? [y/n] " SFLAG
	case $SFLAG in
	Y|y)
		install_term
		;;
	N|n)
		echo "skipping..."
		;;
	esac

}


show_help_menu() {
	echo "--- Dotfile saver ---"
	echo "Usage: ./backup.sh [CMD] [/path/to/home]"
	echo "Leave final '/' off of home path"
	echo
	echo "Valid Commands:"
	echo
	echo "save - dotfiles listed in 'dfile_list.txt'"
	echo "restore - copy dotfiles into specified home directory"
	echo "pkgs - install packages listed in 'short_pkg_list.txt'"


}
if [ -z $1 ]
then
	show_help_menu
elif [ $1 == "save" ]
then
	save_dotfiles
elif [ $1 == "restore" ]
then
	restore_dotfiles
elif [ $1 == "pkgs" ]
then
	install_pkgs
else
	show_help_menu
fi
