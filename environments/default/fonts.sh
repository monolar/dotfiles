#!/usr/bin/env bash

echo "installing fonts..."

cd
mkdir dev
cd dev

git clone git@github.com:powerline/fonts.git
cd fonts
./install.sh

echo "...done"