" ln -sf ~/dotfiles/.vimrc ~/.vimrc
" To install Vim 8 on Ubuntu
" sudo add-apt-repository ppa:jonathonf/vim
" sudo apt update
" sudo apt-get install vim
"
"
" :map to check maps
" Do : then <ctr-V> and then the keys you want to check it
"
"
" :Sline can be run using `\ls` which we remapped to `\r` or `Option+enter`
" `Snew` and then `Sbind`
"
" `:GundoList`

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'linqiaozhi/simpleterm.vim'
Plug 'lervag/vimtex'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'


" Initialize plugin system
call plug#end()

nnor <Leader>c :Sline<CR>
vnor <Leader>c :Sline<CR>
imap <Leader>c <Esc>:Sline<CR>a
:imap jk <Esc>

" Blink cursor on error instead of beeping (grr)
set visualbell

" Move up/down editor lines
nnoremap j gj
nnoremap k gk


if empty(glob('~/.vim/autoload/pathogen.vim'))
	silent !mkdir -p  ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
endif


execute pathogen#infect()



let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" https://sjl.bitbucket.io/gundo.vim/#installation


set visualbell
set t_vp=
autocmd VimEnter * set vb t_vb=

set termwinscroll=40000
set backspace=2 "This was required on bd2k or you couldn't backspace up a line, apparently

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab "Did this so that when using matlab it won't think I'm trying to autocomplete by sending the tabs
hi clear texItalStyle
hi clear texBoldStyle

" Makes escape not have a delay
set timeoutlen=1000 ttimeoutlen=0

map <C-p> :w<CR>:!pdflatex %<CR>
map <C-t> :w<CR>1gt:!pdflatex %<CR>\tl
command! Bib !pdflatex %:r; bibtex %:r; pdflatex %:r; pdflatex %:r<CR>
nmap \v vip \c  `>
imap \v <Esc>vip \c `.


" map <C-m> :w<CR>:!./compile<CR>
map <C-n> :w<CR><C-w>l<Up><CR><C-w>w                  
set tabline=%!MyTabLine()  " custom tab pages line
function! MyTabLine()
        let s = '' " complete tabline goes here
        " loop through each tab page
        for t in range(tabpagenr('$'))
                " set highlight
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " set the tab page number (for mouse clicks)
                let s .= '%' . (t + 1) . 'T'
                let s .= ' '
                " set page number string
                let s .= t + 1 . ' '
                " get buffer names and statuses
                let n = ''      "temp string for buffer names while we loop and check buftype
                let m = 0       " &modified counter
                let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
                " loop through each buffer in a tab
                for b in tabpagebuflist(t + 1)
                        " buffer types: quickfix gets a [Q], help gets [H]{base fname}
                        " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
                        if getbufvar( b, "&buftype" ) == 'help'
                                let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
                        elseif getbufvar( b, "&buftype" ) == 'quickfix'
                                let n .= '[Q]'
                        else
                                let n .= pathshorten(bufname(b))
                        endif
                        " check and ++ tab's &modified count
                        if getbufvar( b, "&modified" )
                                let m += 1
                        endif
                        " no final ' ' added...formatting looks better done later
                        if bc > 1
                                let n .= ' '
                        endif
                        let bc -= 1
                endfor
                " add modified label [n+] where n pages in tab are modified
                if m > 0
                        let s .= '[' . m . '+]'
                endif
                " select the highlighting for the buffer names
                " my default highlighting only underlines the active tab
                " buffer names.
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " add buffer names
                if n == ''
                        let s.= '[New]'
                else
                        let s .= n
                endif
                " switch to no underlining and add final space to buffer list
                let s .= ' '
        endfor
        " after the last tab fill with TabLineFill and reset tab page nr
        let s .= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
                let s .= '%=%#TabLineFill#%999Xclose'
        endif
        return s
endfunction

" https://stackoverflow.com/questions/2119754/switch-to-last-active-tab-in-vim
if !exists('g:lasttab')
  let g:lasttab = 1
endif
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Vimtex
let g:vimtex_fold_enabled = 0
" let g:vimtex_view_method  = 'skim'
" let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
" let g:vimtex_view_general_options = '-r @line @pdf @tex'
" map ,s :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf<CR>
"



" Search for the ... arguments separated with whitespace (if no '!'),
" or with non-word characters (if '!' added to command).
function! SearchMultiLine(bang, ...)
  if a:0 > 0
    let sep = (a:bang) ? '\_W\+' : '\_s\+'
    let @/ = join(a:000, sep)
  endif
endfunction
command! -bang -nargs=* -complete=tag S call SearchMultiLine(<bang>0, <f-args>)|normal! /<C-R>/<CR>

" Disable the `run command' when in a tex file, otherwise typing \cite is
" really annoying
autocmd FileType tex iunmap  \c
autocmd FileType tex iunmap  \v
