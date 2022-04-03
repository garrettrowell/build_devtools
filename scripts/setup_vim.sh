#!/bin/bash

VIMRC='/root/.vimrc'

# install vundle plugin manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

pip3 install grip

REPO_ROOT=$(pip3 show powerline-status 2>/dev/null | grep Location | cut -d ' ' -f 2)

VIM_PLUGINS="
Plugin 'rodjek/vim-puppet'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'dense-analysis/ale'
Plugin 'mrk21/yaml-vim'
Plugin 'Yggdroot/indentLine'
Plugin 'fatih/vim-go'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'elzr/vim-json'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdtree'
Plugin 'xu-cheng/brew.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'vimwiki/vimwiki'
Plugin 'camspiers/animate.vim'
Plugin 'aserebryakov/vim-todo-lists'
Plugin 'fidian/hexmode'
Plugin 'tpope/vim-surround'
Plugin 'chrisbra/unicode.vim'
Plugin 'andymass/vim-matchup'
Plugin 'Valloric/MatchTagAlways'
Plugin 'junegunn/gv.vim'
Plugin 'christoomey/vim-conflicted'
Plugin 'tpope/vim-characterize'
Plugin 'junegunn/vim-emoji'
"

VIM_POWERLINE="
set rtp+=${REPO_ROOT}/powerline/bindings/vim/
set laststatus=2
set t_Co=256
set showtabline=2
"

read -r -d '' VIM_CONFIG <<'EOF'
" ###############################
" misc config
" ###############################

" syntax highlighting
:syntax on

" set colors
set termguicolors
colorscheme deus

" line numbers
set number

" highlight trailing whitespace in RED
" :highlight ExtraWhitespace ctermbg=red guibg=red
" autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" ###############################
" Tagbar config
" ###############################

nmap <F8> :TagbarToggle<CR>

" ###############################
" UltiSnip config
" ###############################

autocmd FileType pp UltiSnipsAddFiletypes puppet

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" ###############################
" Grip config
" ###############################

" use facter to get the ip of the eth1 interface
" run grip command on the current file
:command Grip !grip % $(facter -p networking.interfaces.eth1.ip)

" ###############################
" YAML config
" ###############################

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" ###############################
" Indent Line Config
" ###############################

" allow colorscheme to set indent line color
let g:indentLine_setColors = 0
" dont conceal markdown... thats annoying
let g:indentLine_concealcursor = "nv"

" ###############################
" JSON config
" ###############################

let g:vim_json_syntax_conceal = 0

" ###############################
" NERDTree
" ###############################

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" ###############################
" vim-markdown config
" ###############################

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" ###############################
" vim-wiki config
" ###############################

let g:vimwiki_list = [{'path': '~/Documents/wiki', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

" ###############################
" animate config
" ###############################

" Map Shift + Arrows to resize windows
nnoremap <silent> <S-Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent> <S-Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <S-Left>  :call animate#window_delta_width(10)<CR>
nnoremap <silent> <S-Right> :call animate#window_delta_width(-10)<CR>

" ###############################
" Hexmode config
" ###############################

let g:hexmode_patterns = '*.bin,*.exe,*.dat,*.o'

" ###############################
" vim-emoji
" ###############################
" Useage: in insert mode CTRL+X CTRL+U
set completefunc=emoji#complete

" ###############################
" File indent + spacing config
" ###############################

set bs=indent,eol,start               " allow backspacing over everything
set autoindent                        " enable auto-indentation
set tabstop=2                         " no. of spaces for tab in file
set shiftwidth=2                      " no. of spaces for step in autoindent
set softtabstop=2                     " no. of spaces for tab when editing
set expandtab                         " expand tabs into spaces
set smarttab                          " smart tabulation and backspace

" Then I use an additional block to set indentation for exceptions.

if has("autocmd")
  augroup styles
    autocmd!
    " Custom filetypes settings: Python, Shell, Go, JSON, Vagrant
    au FileType python,sh set tabstop=4 shiftwidth=4 softtabstop=4
    au FileType go set noexpandtab tabstop=8 shiftwidth=8 softtabstop=8
    au BufRead,BufNewFile *.json setfiletype javascript
    au BufRead,BufNewFile Vagrantfile setfiletype ruby
  augroup END
endif
EOF


cat <<EOT >> $VIMRC
" ###############################
" vundle config
" ###############################

set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Add plugins here
$VIM_PLUGINS

" All of your Plugins must be added before the following line
call vundle#end()
" Rest of vim config

" ###############################
" powerline config
" ###############################
$VIM_POWERLINE

$VIM_CONFIG
EOT

# need to figure out why this isn't working
#/usr/local/bin/vim +PluginInstall +qall
OUR_VIM=/usr/local/bin/vim
echo | $OUR_VIM +PluginInstall +qall &>/dev/null
