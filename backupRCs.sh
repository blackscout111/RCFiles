#!/bin/sh

# This script adds a copy of your .bashrc and .vimrc files to this folder
cp $HOME/.bashrc bashrc.txt
cp $HOME/.vimrc vimrc.txt

git add bashrc.txt
git add vimrc.txt
