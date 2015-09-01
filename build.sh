#!/bin/bash

set -ue
username=`whoami`
ghUser=$username

DIR=$HOME/dotfiles


#########
# NPM

if [ ! -d ~/npm-global ]; then
	mkdir ~/npm-global
	npm config set prefix ~/npm-global
fi
cat $DIR/lists/npm | xargs npm install -g


###########
# SSH Keys

if [ ! -f ~/.ssh/id_rsa ]; then
	key=`cat ~/.ssh/id_rsa.pub`
	curl -u "$ghUser" \
		--data "{\"title\": \"$HOSTNAME `date`\", \"key\": \"$key\"}" \
	https://api.github.com/user/keys

	eval $(ssh-agent)
	ssh-keygen
fi


# ROFI 
#sudo apt-get install libxinerama-dev libxft2-dev libpango1.0-dev libx11-6
