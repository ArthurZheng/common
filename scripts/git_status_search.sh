#!/bin/bash

set -ue

check() {
	r=$1
	cd $r
	echo "=========================="
	pwd

    git_status=$(git status 2> /dev/null)
	echo git_status

	if [[ ! $git_status =~ "working directory clean" ]]; then
			echo "FIX $r"
			gitg
	elif [[ $git_status =~ "Your branch is ahead of" ]]; then
			git config --get remote.origin.url
			echo -e "PUSH $r \n [y/n]? "
			read resp < /dev/tty
			if [ "$resp" == "y" ]; then
					git push
			fi
	elif [[ $git_status =~ "nothing to commit" ]]; then
			echo "OK $r"
	fi
	
}

folderChildren() {
	parent=$1
	for folder in `ls $parent`; do
		check $parent/$folder
	done
}

search() {
	parent=$1
	for folder in `find $parent -name ".git"`; do
		check $folder/../
	done
}

folderChildren ~/go/src/github.com/daemonl
folderChildren ~/go/src/github.com/rmrf8
folderChildren ~/go/src/github.com/TabDigital
search ~/ops
check ~/common
check ~/calite


