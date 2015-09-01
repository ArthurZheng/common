#!/bin/bash


while read src dst; do
	echo $src
	fullDst=`eval echo "$dst"`
	echo $fullDst
	if [ -d $fullDst ]; then
		cd $fullDst
		git pull
		git status
	else
		git clone $src $fullDst
	fi
done < ~/dotfiles/lists/git
