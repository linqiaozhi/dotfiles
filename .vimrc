" ln -sf dotfiles/.vimrc ~/.vimrc

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'gu-fan/simpleterm.vim'

" Initialize plugin system
call plug#end()

nmap \r *  :Sline<CR>
vmap  \r * :Sline<CR>     <Space>

" Blink cursor on error instead of beeping (grr)
set visualbell

" Move up/down editor lines
nnoremap j gj
nnoremap k gk


if empty(glob('~/.vim/autoload/pathogen.vim'))
	silent !mkdir -p  ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
endif

execute pathogen#infect()


if empty(glob('~/.vim/bundle/gundo'))
	silent !git clone http://github.com/sjl/gundo.vim.git ~/.vim/bundle/gundo
endif
" https://sjl.bitbucket.io/gundo.vim/#installation

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>



" :map to check maps
" Do : then <ctr-V> and then the keys you want to check it
" :Sline can be run using `\ls` which we remapped to `\r` or `Option+enter`
" `Snew` and then `Sbind`
"
" `:GundoList`
