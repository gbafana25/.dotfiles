#!/bin/bash

HOME_DIR=$2

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
	cp -r $HOME_DIR/$file .
	done < dfile_list.txt
	

}

restore_dotfiles() {
	cp dwm/config.h $HOME_DIR/dwm-6.1/
	cp st/config.h $HOME_DIR/st/
	cp larger-st/config.h $HOME_DIR/larger-st/
	while read -r file; do
	cp -r $file $HOME_DIR
	done < dfile_list.txt

}

if [ $1 == "save" ]
then
	save_dotfiles
elif [ $1 == "restore" ]
then
	restore_dotfiles
fi
