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


"mkdir -p ~/.vim/autoload ~/.vim/bundle && \
" curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
execute pathogen#infect()


" https://sjl.bitbucket.io/gundo.vim/#installation
" git clone http://github.com/sjl/gundo.vim.git ~/.vim/bundle/gundo
