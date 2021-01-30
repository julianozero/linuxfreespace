#!/bin/bash

clear
rm -rf /var/lib/apt/lists/lock
apt-get update
dpkg --configure -a
apt-get -f install
apt-get autoremove
apt-get autoclean
apt-get clean
rm -rf /tmp/*
journalctl --vacuum-time=3d
rm -rf ~/.cache/thumbnails/*
rm -rf ~/Library/Application\ Support/Code/Cache/*
rm -rf ~/Library/Application\ Support/Code/CachedData/*

# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done
