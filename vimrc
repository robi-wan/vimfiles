" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set history=256               " Number of things to remember in history.

set hidden                    " The current buffer can be put to the background without writing to disk
set number                    " disable with set nonumber or short set nonu
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Searching
set incsearch   " do incremental searching
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
"endif
noremap <F7> :set hls!<cr>:set hls?<cr>
" case insensitive search unless a capital letter is used
set ignorecase
set smartcase

" automatically read the file again when it is changed outside of Vim
set autoread

" open and maximize the split above the current one
map <C-K> <C-W>k<C-W>_
" open and maximize the split below the current one
map <C-J> <C-W>j<C-W>_
" allow splits to reduce their size to a single line (which includes the
" filename and position)
set wmh =0 


" Whitespace stuff
"set nowrap
set expandtab         " insert space characters whenever the tab key is pressed
set tabstop=2         " the number of space characters that will be inserted when the tab key is pressed
set shiftwidth=2      " the number of space characters inserted for indentation
" This makes the backspace key treat the four spaces like a tab (so one backspace goes back a full 4 spaces).  
set softtabstop=2   " makes the spaces feel like real tabs 


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " make uses real tabs
  au FileType make set noexpandtab
  
  " Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby
  
  " make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Set File type to 'text' for files ending in .txt
  au BufNewFile,BufRead *.txt setfiletype text


  " For all text files set 'textwidth' to 78 characters.
  "au FileType text setlocal tw=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif


  " Automatically load .vimrc source when saved
  au BufWritePost .vimrc source $MYVIMRC

  "augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd") 

"--------- statusline 
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


set laststatus=2             " always show status line.
set showcmd                   " display an incomplete command in statusline

":set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\[HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
":set statusline=%f%m%r%h%w\ \[%{Statusline_fileinfo()}\]\ [ascii=\%03.3b]\[hex=\%02.2B]\ \%05(%l%),%v\ %p%%\ %LL
set statusline=%<%F%m%r%h%w\ \[%{Statusline_fileinfo()}\]\ %=[ascii=\%03.3b]\[hex=0x%B]\ \ %l,%v\ %p%%\ %LL
":set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P
":set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ lin:%l\,%L\ col:%c%V\ pos:%o\ ascii:%b\ %P


"---------Autocompletion----------------------------

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
" ruby
" Place 'msvcrt-ruby18.dll' in c:\Program Files (x86)\vim\vim73\
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

" Vundle
set rtp+=~/.vim/vundle.git/ 
call vundle#rc()

" Programming
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'

" Colorscheme
Bundle 'robi-wan/vim-railscasts-theme'
colorscheme railscasts

" Snippets
Bundle 'msanders/snipmate.vim'

" Syntax highlight
Bundle 'autoit.vim'

" Git integration
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'

" Utility
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'scrooloose/nerdtree'
map <F2> :NERDTreeToggle<CR>

Bundle 'scrooloose/nerdcommenter'

" Spell files
set rtp+=~/.vim/bundle/spellfiles/

" Include local vim config
if filereadable(".vimrc.local")
  source .vimrc.local
endif
