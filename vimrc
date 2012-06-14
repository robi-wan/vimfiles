" vimrc of robi-wan

if v:progname =~? "evim"
  finish
endif

set nocompatible              " Use Vim settings, rather then Vi settings (much better!).
                              " This must be first, because it changes other options as a side effect.

" Scripts and Bundles " {{{
filetype off                  " Required

runtime macros/matchit.vim
" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Programming
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'
" syntastic syntax checking, enable with :SyntasticEnable
" for ruby: ruby must be reachable via shell
"Bundle 'scrooloose/syntastic'
"let g:syntastic_enable_signs=1          " tell syntastic to use the |:sign| interface to mark syntax errors
"let g:syntastic_quiet_warnings=1        " show just errors, not warnings

" adding this, because ruby.vim bundled with vim gives errors (Gem.all_load_paths is
" deprecated in current rubygems)
Bundle 'vim-ruby/vim-ruby'

Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'

" Colorscheme
Bundle 'robi-wan/vim-railscasts-theme'
Bundle 'altercation/vim-colors-solarized'
Bundle 'robi-wan/vim-github-theme'
Bundle 'tpope/vim-vividchalk'
colorscheme railscasts

" Snippets
Bundle 'msanders/snipmate.vim'
Bundle 'honza/snipmate-snippets'

" Syntax highlight
Bundle 'autoit.vim'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tmatilai/gitolite.vim'
Bundle 'kusnier/vim-mediawiki'

" Git integration
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'

" (HT|X)ml tool
Bundle 'ragtag.vim'

" Utility
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-abolish'
Bundle 'scrooloose/nerdtree'
map <F2> :NERDTreeToggle<CR>

Bundle 'sickill/vim-pasta'

" Conque-Shell, see https://github.com/gmarik/vundle/issues/153
Bundle 'rson/vim-conque'

" Graphical undo (relies on python 2.4+)
Bundle 'sjl/gundo.vim'

Bundle 'scrooloose/nerdcommenter'
Bundle 'tsaleh/vim-align'
Bundle 'ervandew/supertab'
Bundle 'ZoomWin'
map <Leader><Leader> :ZoomWin<CR>

Bundle 'michaeljsmith/vim-indent-object'
Bundle 'tpope/vim-unimpaired'
" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

"Bundle 'dahu/VimLint'

" resize windows according to golden ratio
" :GoldenRatioResize, :GoldenRatioToggle
Bundle 'roman/golden-ratio'

" automatic closing of quotes, parenthesis, brackets, etc.
Bundle 'Raimondi/delimitMate'

" visually displaying indent levels:
" activate with <Leader>ig :IndentGuideToggles
Bundle 'nathanaelkane/vim-indent-guides'

Bundle 'davidoc/taskpaper.vim'

" wrapper for cheat gem, requires 'gem install cheat'
" (beware: problems under windows)
"Bundle 'cheat.vim'

" Toggling first checkbox on a line
" <leader>tt :ToggleCB
Bundle 'jkramer/vim-checkbox'

if has("autocmd")
  filetype plugin indent on      " Automatically detect file types.
endif

" see https://github.com/gmarik/vundle/issues/146
if (has('win32') || has('win64'))
  set shellxquote=
end

" Spell files
set rtp+=~/.vim/bundle/spellfiles/
" "}}}


" General "{{{

set history=500               " Number of things to remember in history.

set autoread                  " automatically read the file again when it is changed outside of Vim

set hidden                    " The current buffer can be put to the background without writing to disk

set clipboard+=unnamed         " Yanks go on clipboard instead.
set clipboard+=unnamedplus     " Yanks go on clipboard instead.

set directory+=$TEMP           " set directory names for swap files

" Searching
set incsearch                 " do incremental searching
set hlsearch                  " switch on highlighting the last used search pattern
noremap <F7> :set hls!<cr>:set hls?<cr>
set ignorecase
set smartcase                 " case insensitive search unless a capital letter is used


set number                    " disable with set nonumber or short set nonu
if (has('win32') || has('win64'))
  source $VIMRUNTIME/mswin.vim
  behave mswin
end
" "}}}


" Formatting "{{{

"set nowrap
set linebreak                 " wrap long lines at words not characters

set tabstop=2                 " the number of space characters that will be inserted when the tab key is pressed
set softtabstop=2             " makes the spaces feel like real tabs
set shiftwidth=2              " the number of space characters inserted for indentation
set expandtab                 " insert space characters whenever the tab key is pressed

set backspace=indent          " allow backspacing over everything in insert mode
set backspace+=eol
set backspace+=start

set autoindent                " always set autoindenting on
" "}}}


" open and maximize the split above the current one
map <C-K> <C-W>k<C-W>_
" open and maximize the split below the current one
map <C-J> <C-W>j<C-W>_
" allow splits to reduce their size to a single line (which includes the
" filename and position)
set winminheight =0


" Visual "{{{
syntax on                     " Switch syntax highlighting on, when the terminal has colors

" fileformat (three characters only)
function! Statusline_fileformat()
  if &fileformat == ""
    return "--"
  else
    return &fileformat
  endif

endfunction

" fileencoding (three characters only)
function! Statusline_fileencoding()
  if &fileencoding == ""
    if &encoding != ""
      return &encoding
    else
      return "--"
    endif
  else
    return &fileencoding
  endif
endfunction

" file type
function! Statusline_filetype()
  if &filetype == ""
    return "--"
  else
    return &filetype
  endif
endfunction

function! Statusline_fileinfo()

  return Statusline_fileformat() . ":" .
    \  Statusline_fileencoding() . ":" .
    \  Statusline_filetype()

endfunction


set laststatus=2              " always show status line.
if has('cmdline_info')
  set ruler                   " Always show cursor position.
  set showcmd                 " display an incomplete command in statusline
endif

set statusline=%<%F%m%r%h%w\ \[%{Statusline_fileinfo()}\]\ %=[ascii=\%03.3b]\[hex=0x%B]\ \ %l,%v\ %p%%\ %LL

function! ToggleNumber()
  if &number
    set nonumber
    set relativenumber
  elseif &relativenumber
    set number
    set norelativenumber
  else
    set number
  endif
endfunction
noremap <silent> <F6>        :call ToggleNumber()<CR>
inoremap <silent> <F6> <C-o> :call ToggleNumber()<CR>

set foldenable                " Turn on folding
set foldmethod=marker         " Fold on the marker
set foldlevel=100             " Don't autofold anything (but I can still fold manually)

set foldopen=block,hor,tag    " what movements open folds
set foldopen+=percent,mark
set foldopen+=quickfix

if has('windows')
  set splitbelow
endif

if has('vertsplit')
  set splitright
endif


" display unprintable characters
set listchars=tab:\ ·,eol:¬
set listchars+=trail:·
set listchars+=extends:»,precedes:«

" "}}}

" AutoCommands " {{{
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  augroup FTCheck " {{{2
    autocmd!
    " Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
    autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

    " Set File type to 'text' for files ending in .txt
    autocmd BufNewFile,BufRead *.txt set ft=text

    " add json syntax highlighting
    autocmd BufNewFile,BufRead *.json set ft=javascript
  augroup END " }}}2

  augroup FTOptions " {{{ 2
    autocmd!
    " make uses real tabs
    autocmd FileType make set noexpandtab

    " make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
    autocmd FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif

    " Automatically load .vimrc source when saved
    autocmd BufWritePost .vimrc source $MYVIMRC
    autocmd BufWritePost _vimrc source $MYVIMRC
    "autocmd BufWritePost vimrc source $MYVIMRC

    "---------Autocompletion----------------------------
    autocmd FileType * if exists("+omnifunc") && &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
    autocmd FileType * if exists("+completefunc") && &completefunc == "" | setlocal completefunc=syntaxcomplete#Complete | endif
  augroup END " }}}2

endif " has("autocmd")
" }}}



" tip from http://vimcasts.org/episodes/tidying-whitespace/
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" strip trailing whitespaces
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
" auto-indent the whole file
nmap _= :call Preserve("normal gg=G")<CR>

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Include local vim config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" leftovers from vimrc_example.vim {{{

" Don't use Ex mode, use Q for formatting
"map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
"inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
  "set mouse=a
"endi
" }}}
