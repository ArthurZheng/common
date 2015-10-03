#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
set -ue
fname=$1
extName=`basename $fname| cut -c2-`
echo Grabbing $extName
mv ~/.${extName} $DIR/dotfiles/${extName}
cd $HOME
ln -s "$DIR/dotfiles/${extName}" ".${extName}"
