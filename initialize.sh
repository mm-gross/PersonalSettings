#! /usr/bin/env bash

# Install homebrew

# Install bash via homebrew

# Install .bashrc

# make new bash default shell
# maybe compare output of which before and after installing bash to 
# determine the location of the new executable of bash
# for the moment we just assume it is /usr/local/bin/bash

sudo sh -c "echo /usr/local/bin/bash >> /etc/shells"
chsh -s /usr/local/bin/bash

# Optionally install core-utils

# Optionally Install vim from brew

# Install vimrc

# Install gitconfig

# other (possible) sutff: composer, node, npm, unrar, vlc (cask), arduino (cask), brackets(cask), teamviewr(cask), rails?
