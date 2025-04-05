
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2014 Feb 05
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" TODO replace pathogen as plugin manager
" Enable runtimepath management using pathogen plugin.
" execute pathogen#infect()

" TODO replace ultisnips
" UltiSnips settings.
"let g:UltiSnipsSnippetDirectories=['UltiSnips', 'snippets']
" let g:UltiSnipsSnippetDirectories=['UltiSnips', '~/.vim/bundle/vim-snippets/snippets']

"let g:UltiSnipsJumpForwardTrigger='<c-tab>'
nmap <C-s> :wq<CR>

" DelimitMate settings.
" let delimitMate_expand_cr = 1


" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set laststatus=2 showmode " number
set ignorecase smartcase hlsearch
" scrolloff option: high value keeps cursor in middle of screen
set so=9999
set hidden

" Remaps 's' key to insert a single character without entering Insert Mode.
noremap s i <Esc>r
noremap ; A;<Esc>



" set tags var
set tags=./tags,tags;$HOME

" Does this work on Linux?
" allow `gx` to open the URL under the cursor
let g:netrw_browsex_viewer= "open"

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set nobackup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
"history=200
set history=10000		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
" map tab key to four spaces
set tabstop=4
set shiftwidth=4
set expandtab

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
" TODO find out how this works
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  "set mouse=a
  set mouse=
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set hlsearch
endif

syntax on

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " set .ftl files to highlight syntax html style
  au BufNewFile,BufRead *.ftl set ft=html

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  augroup myvimrc
      au!
      au BufWritePost ~/.vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
if !exists(":Dict")
    command Dict set dictionary=/usr/share/dict/words
endif

" All yank, delete, and paste operations work with clipboard.
set clipboard+=unnamedplus
