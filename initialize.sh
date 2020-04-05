#! /usr/bin/env bash

# Install homebrew

# Install bash via homebrew

# Install .bashrc

# make new bash default shell
# maybe comprare output of which before and after installing bash to detemine the new bash
# for the moment we just assume it is /ust/local/bin/bash

sudo sh -c "echo /usr/local/bin/bash >> /etc/shells"
chsh -s /usr/local/bin/bash

# Optionally install core-utils

# Optionally Install vim from brew

# Install vimrc

# Install gitconfig

# other (possible) sutff: composer, node, npm, unrar, vlc (cask), arduino (cask), brackets(cask), teamviewr(cask), rails?
