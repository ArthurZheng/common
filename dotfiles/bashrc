#!/bin/bash

PATH+=:$HOME/.path
PATH+=:$HOME/go/bin
PATH+=:$HOME/gbx/guapi-can/path
PATH+=:$HOME/npm-global/bin
export PATH

export GOPATH=$HOME/go
export GOROOT=/opt/go

[ -z "$PS1" ] && return

export HISTCONTROL=ignoredups:erasedups
#shopt -s histappend
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
shopt -s expand_aliases

#if hash gvim 2>/dev/null; then
#	alias vi="gvim"
#	alias vim="gvim"
#fi

alias ls="ls --color=auto"
alias ll="ls -la"
alias grep="grep --color=auto"

stty -ixon # Disable ctrl+s freeze thing, use it for history search

function git_branch {
	local git_status="$(git status 2> /dev/null)"
	local on_branch="On branch ([^${IFS}]*)"
	local on_commit="HEAD detached at ([^${IFS}]*)"

	if [[ ! $git_status =~ "working directory clean" ]]; then
		COLOR="\033[30;41m"
	elif [[ $git_status =~ "Your branch is ahead of" ]]; then
		COLOR="\033[40;33m"
	elif [[ $git_status =~ "nothing to commit" ]]; then
		COLOR="\033[30;42m"
	else
		COLOR="\033[38;5;95m"
	fi

	if [[ $git_status =~ $on_branch ]]; then
		local branch=${BASH_REMATCH[1]}
		echo -e "$COLOR $branch "
	elif [[ $git_status =~ $on_commit ]]; then
		local commit=${BASH_REMATCH[1]}
		echo -e "$COLOR $commit "
	fi
}

COLOR_DIR="\[\033[0;32m\]" # GREEN
COLOR_USER="\[\033[0;36m\]" # CYAN
COLOR_PROMPT="\[\033[1;37m\]" # BOLD WHITE
COLOR_BRACKET="\[\033[0;37m\]" # WHITE
COLOR_RESET="\[\033[0m\]"

PS1="$COLOR_BRACKET[$COLOR_USER\u@\h$COLOR_BRACKET] "
PS1+="$COLOR_DIR\w "
PS1+="\$(git_branch)"
PS1+="$COLOR_RESET\n$COLOR_PROMPT\$ $COLOR_RESET"

export PS1

if [ -f $HOME/.bashrc-local ]; then
	source $HOME/.bashrc-local
fi
