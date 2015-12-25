#!/bin/bash
set -ue

# Basic Prereq
apt-get install vim curl apt-transport-https

# Custom sources list
cp sources.list /etc/apt/sources.list

# Keys in comments
cat sources.list | grep "#KEYURL" | cut -d' ' -f2 | xargs -n1 curl | apt-key add

cat sources.list | grep "^#KEYSRV" | cut -d' ' -f2,3

# Install Things
apt-get update
apt-get upgrade
cat lists/apt | grep "^[^#]\+" -o | xargs apt-get install
