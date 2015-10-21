#!/bin/bash

set -ue

check() {
	r=$1
	if [ -d $r/.git ]; then
	cd $r
	echo "=========================="
	pwd
	remote=$(git config --get remote.origin.url)
	echo $remote

    git_status=$(git status 2> /dev/null)
	#echo $git_status

	if [[ ! $git_status =~ "working directory clean" ]]; then
			echo "FIX $r"
			gitg
			git_status=$(git status 2> /dev/null)
	fi
	if [[ $git_status =~ "Your branch is ahead of" ]]; then
			git config --get remote.origin.url
			echo -e "PUSH $r \n [y/n]? "
			read resp < /dev/tty
			if [ "$resp" == "y" ]; then
					git push
			fi
	elif [[ $git_status =~ "nothing to commit" ]]; then
			echo "OK $r"
	fi
	fi
	
}

folderChildren() {
	parent=$1
	if [ -d $parent ]; then
	for folder in `ls $parent`; do
		if [ -d $parent/$folder ]; then
			check $parent/$folder
		fi
	done
	fi
}

search() {
	parent=$1
	if [ -d $parent ]; then
	for folder in `find $parent -name ".git"`; do
		check $(realpath $folder/../)
	done
	fi
}

folderChildren ~/go/src/github.com/daemonl
folderChildren ~/go/src/github.com/rmrf8
folderChildren ~/go/src/github.com/TabDigital
folderChildren ~/gbx
folderChildren ~/schkit
search ~/TabDigital
search ~/ops
check ~/common
check ~/calite
