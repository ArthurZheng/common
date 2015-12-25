#!/bin/bash

set -ue
username=`whoami`
ghUser=$username

DIR=$HOME/dotfiles


###########
# SSH Keys

if [ ! -f ~/.ssh/id_rsa ]; then
	eval $(ssh-agent)
	ssh-keygen
	key=`cat ~/.ssh/id_rsa.pub`
	curl -u "$ghUser" \
		--data "{\"title\": \"$HOSTNAME `date`\", \"key\": \"$key\"}" \
	https://api.github.com/user/keys
fi

if [ ! -d ~/dotfiles ]; then
	git clone ssh://git@github.com/daemonl/dotfiles ~/dotfiles


	cat ~/dotfiles/lists/apt | grep '^[^#]\+' -o | sudo apt-get install -y
fi

#########
# NPM

if [ ! -d ~/npm-global ]; then
	mkdir ~/npm-global
fi
npm config set prefix ~/npm-global
cat $DIR/lists/npm | xargs npm install -g

# ROFI
