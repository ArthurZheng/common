#!/bin/bash

. /usr/share/bash-completion/completions/ssh

_complete_scp() {
	_scp
	_ssh_config_hosts $1
}

_complete_ssh() {
	_ssh
	_ssh_config_hosts $1
}

_ssh_config_hosts() {
	local cur opts config
	if [[ $1 == "ssh" || $1 == "scp" ]]; then
		config=$HOME/.ssh/config
	else
		config=`alias $1 | grep -o "\-F [^ ']\+" | cut -d' ' -f2`
	fi
	opts=$(grep '^Host ' $config \
		| cut -c6- \
		| tr " " "\n" \
		| sort | uniq \
		| grep '^[^*]\+$')

	cur="${COMP_WORDS[COMP_CWORD]}"
	COMPREPLY+=($(compgen -W "$opts" -- ${cur}))
	return 0
}

sshAlias(){
	local prefix=$1
	local config=$2
	alias ${prefix}ssh="ssh -F $config"
	alias ${prefix}scp="scp -F $config"
	complete -F _complete_ssh ${prefix}ssh
	complete -F _complete_scp ${prefix}scp
}


complete -F _complete_ssh ssh
complete -F _complete_scp scp

