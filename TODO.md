# What's still missing

This is a work in progress and there's a lot of stuff that still
needs improvement or isn't included at all so far. 
This file is supposed to be a pool of ideas for what to include and what to improve.

I already know that I won't keep this file as regularly updated as I should,
but I'll probably revisit it from time to time to add new ideas and remove
stuff that has been either implemented or I'm no longer interested in.

Also this file itself of course is also incomplete.

# General stuff

Is it possible to sense if we're in dark mode
(or more general if we have a dark or light background) and adjust the colors
of bash an vim accordingly? E.g. what is light blue on a dark background should
become dark blue on a light background

Yes, there is:

> Don't think there's a cocoa way of detecting it yet, however you can use `defaults read` to check whether or not OSX is in dark mode.
>
>    defaults read -g AppleInterfaceStyle
>
> Either returns `Dark` (dark mode) or returns domain pair does not exist.

Now, I still need to figure out / decide, wether to check for dark mode
only when starting a new shell or if it's feasible to check every time a
prompt is displayed.

Also, a thought that I just had: When switching to dark mode, the standard
text color of black is automagically changed to white by the OS, even of
text, that has it specifically set to black. Maybe there's a way to use
that mechanism for other colors too?

# Deployment

- The deployment script is a joke at this point and whenever I need to,
I just copy and rename all the source files instead of using the script.

- In the future, I'd like to have a script running interactively and doing
everything that needs to be done when setting up a new machine from scratch

# Software installation

- Right now, this won't install any software whatsoever

- Heroku: brew tap heroku/brew && brew install heroku
    To use the Heroku CLI's autocomplete --
      Via homebrew's shell completion:
        1) Follow homebrew's install instructions https://docs.brew.sh/Shell-Completion
            NOTE: For zsh, as the instructions mention, be sure compinit is autoloaded
                  and called, either explicitly or via a framework like oh-my-zsh.
        2) Then run
          $ heroku autocomplete --refresh-cache
      OR
      Use our standalone setup:
        1) Run and follow the install steps:
          $ heroku autocomplete

    zsh completions have been installed to:
      /usr/local/share/zsh/site-functions

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

