#!/usr/bin/env bash

echo "installing fonts..."

cd
mkdir -p dev
cd dev

git clone git@github.com:powerline/fonts.git
cd fonts
./install.sh

cd ..
git clone git@github.com:monolar/vim-settings.git
cd vim-settings
cp "Monaco for Powerline.otf" ~/Library/Fonts

cd ..
git clone https://github.com/abertsch/Menlo-for-Powerline.git
cd Menlo-for-Powerline
cp *.ttf ~/Library/Fonts

echo "...done"
