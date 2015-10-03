#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd $HOME
for file in `ls $DIR/dotfiles`; do
	echo ".$file"
	if [ -h ".$file" ]; then
		rm ".$file"
	elif [ -e ".$file" ]; then
		echo ".$file exists and is not a symlink" 
		exit 1
	fi
	ln -s "$DIR/dotfiles/$file" ".$file"
done
