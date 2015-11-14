#!/bin/bash

# Set ps1 to include git branch and status

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

