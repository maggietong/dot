#!/bin/sh

mkdir -p ~/Applications/brew
cd ~/Applications/brew

for a in $(find /usr/local/ -type d -name '*.app') ; do ln -sf "$a" ./; done
