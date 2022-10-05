# What's still missing

This is a work in progress and there's a lot of stuff that still
needs improvement or isn't included at all so far. 
This file is supposed to be a pool of ideas for what to include and what to improve.

I already know that I won't keep this file as regularly updated as I should,
but I'll probably revisit it from time to time to add new ideas and remove
stuff that has been either implemented or I'm no longer interested in.

Also this file itself of course is also incomplete.

# General stuff

- Is it possible to sense if we're in dark mode
(or more general if we have a dark or light background) and adjust the colors
of bash an vim accordingly?

# Deployment

- The deployment script is a joke at this point and whenever I need to,
I just copy and rename all the source files instead of using the script.

- In the future, I'd like to have a script running interactively and doing
everything that needs to be done when setting up a new machine from scratch

# Software installation

- Right now, this won't install any software whatsoever

# Bash

# Vim

# Git

## Global Configuration

Some global configuration, here's the bare minimum on what's missing

    git config --global user.name "YOUR NAME"
    git config --global user.email "YOUR@EMAIL.com"
    git config --global color.ui true

## Github credentials

In order to authenticate with github, we'd need to generate an ssh key pair, add it to the ssh agent,
copy the public key to the clipboard, so that the user can paste it to github.
Here's a reminder on how to do that:

    git config --global credential.helper osxkeychain # This may or may not be necessary

    ssh-keygen -t ed25519 -C "mail@domain.com" # generate keypair
    eval "$(ssh-agent -s)" # This may or may not be necessary
    ssh-add -K ~/.ssh/id_github # For MacOS < 12.0
    ssh-add --apple-use-keychain ~/.ssh/id_github # MacOS >= 12.0
    pbcopy < ~/.ssh/id_github.pub # copy public key to clipboard

