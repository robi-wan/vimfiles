## Pre-requisites

You need to have git installed. On Windows use [msysgit](http://code.google.com/p/msysgit). For installation instructions see https://github.com/gmarik/vundle/wiki/Vundle-for-Windows.

Before running the install script you also have to install ruby.

## Installation


### On Windows

0. `git clone [add repo url] ~/.vim`
1. `cd ~/.vim`
2. `rake`
3. `rake --silent curl_for_win > <path to msysgit>\cmd\curl.cmd`
4. `rake spell_files` for installing german spell files to ~/.vim/bundle/spellfiles
5. Launch `vim`, run `:BundleInstall`. 

## Customization

Create `~/.vimrc.local` and `~/.gvimrc.local` for any local
customizations.

For example, to override the default color schemes:

    echo color desert  > ~/.vimrc.local
    echo color molokai > ~/.gvimrc.local

## Updating to the latest version

To update to the latest version of vundle, just run `rake`
again inside your `~/.vim` directory.

To update to the latest version of this distribution, just run `rake upgrade` inside your `~/.vim` directory.

To update the installed plugins, run `:BundleInstall` inside `vim`.

# Intro to VIM

Here's some tips if you've never used VIM before:

## Tutorials

* Type `vimtutor` into a shell to go through a brief interactive
  tutorial inside VIM.
* Read the slides at [VIM: Walking Without Crutches](http://walking-without-crutches.heroku.com/#1).
* Watch the free screencasts at [Vimcasts.org](http://vimcasts.org/).

## Modes

* VIM has two modes:
  * insert mode- stuff you type is added to the buffer
  * normal mode- keys you hit are interpretted as commands
* To enter insert mode, hit `i`
* To exit insert mode, hit `<ESC>`

## Useful commands

* Use `:q` to exit vim
* Certain commands are prefixed with a `<Leader>` key, which maps to `\`
  by default. Use `let mapleader = ","` to change this.
* Keyboard [cheat sheet](http://walking-without-crutches.heroku.com/image/images/vi-vim-cheat-sheet.png).

