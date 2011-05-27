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

To update the installed plugins, run `:BundleInstall!` inside `vim`.

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

# Features

## Base Customizations

* Line numbers
* Show tailing whitespace as `.`
* Make searching highlighted, incremental, and case insensitive unless a
  capital letter is used
* Always show a status line
* Allow backspacing over everything (identations, eol, and start
  characters) in insert mode
* Automatic insertion of closing quotes, parenthesis, and braces

## NERDTree

NERDTree is a file explorer plugin that provides "project drawer"
functionality to your vim projects.  You can learn more about it with
:help NERDTree.

**Customizations**:

* Use `<F2>` to toggle NERDTree

## Align

Align lets you align statements on their equal signs, make comment
boxes, align comments, align declarations, etc.

* `:5,10Align =>` to align lines 5-10 on `=>`'s

## indent\_object

Indent object creates a "text object" that is relative to the current
ident. Text objects work inside of visual mode, and with `c` (change),
`d` (delete) and `y` (yank). For instance, try going into a method in
normal mode, and type `v ii`. Then repeat `ii`.

## surround

Surround allows you to modify "surroundings" around the current text.
For instance, if the cursor was inside `"foo bar"`, you could type
`cs"'` to convert the text to `'foo bar'`.

There's a lot more; check it out at `:help surround`

## NERDCommenter

NERDCommenter allows you to wrangle your code comments, regardless of
filetype. View `help :NERDCommenter` for all the details.

## SuperTab

In insert mode, start typing something and hit `<TAB>` to tab-complete
based on the current context. 
