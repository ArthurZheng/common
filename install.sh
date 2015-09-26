#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd $HOME
for file in `ls $DIR/dotfiles`; do
	echo ".$file"
	if [ -e ".$file" ]; then
		if [ -h ".$file" ]; then
			rm ".$file"
		else
			echo ".$file exists and is not a symlink" 
			exit 1
		fi
	fi
	ln -s "$DIR/dotfiles/$file" ".$file"
done
