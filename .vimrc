" Automatically install the plugin manager if missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load plugins
call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'roxma/nvim-yarp'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'
" autocomplete window with escape
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'tpope/vim-sensible'
Plug 'mhinz/vim-signify'
Plug 'sukima/xmledit'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'mboughaba/i3config.vim'
Plug 'SidOfc/mkdx'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'bkad/CamelCaseMotion'

" Plug 'Townk/vim-autoclose' " perhaps is conflicting when closing
" Plug 'udalov/kotlin-vim'
" Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
" Plug 'Shougo/deoplete.nvim'
" Plug 'zchee/deoplete-go', { 'do': 'make' }
call plug#end()

" SirVer/ultisnips: Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Use :help <option> to see the docs
set encoding=utf-8
set expandtab
set shiftwidth=4
set softtabstop=4
set smartindent
set incsearch
set ignorecase
set smartcase
set mouse=a
set hidden
set wildmode=list:longest
set number
set title
set ruler
set nospell
set rnu
set updatetime=300

"" Customize view
sy on
set t_Co=256
colorscheme default
" nacx-maricn

"""" Fix background (revert so that terminal's default is used)
hi! Normal ctermbg=NONE guibg=NONE
hi! Normal guifg=NONE ctermfg=NONE

"" Key remaps -----------------
nnoremap <silent> <expr> <C-S-E> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
nnoremap <silent> <expr> <F2> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
:let mapleader = '\'

""" Usability -----------------
"""" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"""" CamelCase motion
let g:camelcasemotion_key = '<leader>'

""" Navigation ----------------
nmap <A-F7> :TsuReferences<CR>
nmap <C-S-P> :CtrlPBuffer<CR>
"""" CtrlP - go to definition
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

""" Refactoring ---------------
nmap <S-F6> :TsuRenameSymbol<CR>
" Replace strings in local or global scope
" https://stackoverflow.com/a/597932/3540564
:nnoremap gr gd[{V%:s/<C-R>///gc<Left><Left><Left>
:nnoremap gR gD:s/<C-R>///gc<Left><Left><Left>
" nmap <silent> <A-7> :copen<CR><CR>
" :nnoremap <A-S-F> :vimgrep /<C-R>/g **<CR>
set wildignore=*/node_modules/*

""" Buffers -------------------
nmap <F3> :TagbarToggle<CR>
nmap <silent> <F5> :!tmux splitw -v -l 5<CR><CR>
"""" Use fancy buffer closing that doesn't close the split
:nnoremap <silent> <S-Left> :bprevious<CR>
:nnoremap <silent> <S-Right> :bnext<CR>
:noremap <silent> <C-Left> b
:noremap <silent> <C-Right> w
"""" Move with Ctrl+hjkl (skip Ctrl+W step)
nnoremap <C-L> <C-W><C-L>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>
"" END Key remaps -------------

" Plugins ----------------------

"" Tsuquyomi
""" Disable popup menu
autocmd FileType typescript setlocal completeopt-=menu
""" Close the preview window after completion
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"" coc.nvim
""" Enter just selects the item in the autocomplete menu
""" http://vim.wikia.com/wiki/VimTip1386
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
""" Map Ctrl+Space to autocomplete
""" https://coderwall.com/p/cl6cpq/vim-ctrl-space-omni-keyword-completion
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
            \ "\<lt>C-n>" :
            \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
            \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" :w!! sudo saves the file
cmap w!! w !sudo tee % >/dev/null

" NERDTree options
let NERDTreeAutoCenter = 1
let NERDTreeCaseSensitiveSort = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeMouseMode = 1
let NERDTreeQuitOnOpen = 1
"let NERDTreeDirArrows = 1
let NERDTreeIgnore=['.*\.o$']
let NERDTreeIgnore+=['.*\~$']
let NERDTreeIgnore+=['.*\.out$']
let NERDTreeIgnore+=['.*\.so$', '.*\.a$']
let NERDTreeIgnore+=['.*\.pyc$']
let NERDTreeIgnore+=['.*\.class$']

" status bar colors
au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan

" Status line
" default: set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

" Status Line Custom
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

set laststatus=2
set noshowmode
set statusline=
set statusline+=%0*\ %n\                                 " Buffer number
set statusline+=%0*\ %<%F%m%r%h%w\                       " File path, modified, readonly, helpfile, preview
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %02l:%02v\ (%3p%%)\                 " Line number : column number ( percentage )
set statusline+=%=                                       " Right Side
set statusline+=%2*\ %Y\                                 " FileType
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
set statusline+=\ (%{&ff})                               " FileFormat (dos/unix..)
set statusline+=%3*│                                     " Separator
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}\  " The current mode

hi User1 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
hi User2 ctermfg=007 ctermbg=236 guibg=#303030 guifg=#adadad
hi User3 ctermfg=236 ctermbg=236 guibg=#303030 guifg=#303030
hi User4 ctermfg=239 ctermbg=239 guibg=#4e4e4e guifg=#4e4e4e

" Markdown plugin
let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
                        \ 'enter': { 'shift': 1 },
                        \ 'links': { 'external': { 'enable': 1 } },
                        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                        \ 'fold': { 'enable': 1 } }
let g:polyglot_disabled = ['markdown'] " for vim-polyglot users, it loads Plasticboy's markdown
                                       " plugin which unfortunately interferes with mkdx list indentation.

" Tmux integration
if &term =~ '^screen'
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
" Close tmux when exiting vim
autocmd VimLeave * silent !tmux kill-session -t $VIM_SESSION

""" Custom file types
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.http set syntax=json
au BufRead,BufNewFile *.http setlocal ts=2 sts=2 sw=2

""" Better help navigation
autocmd FileType help nnoremap <buffer> <CR> <C-]>
autocmd FileType help nnoremap <buffer> <BS> <C-T>
autocmd FileType help nnoremap <buffer> o /'\l\{2,\}'<CR>
autocmd FileType help nnoremap <buffer> O ?'\l\{2,\}'<CR>
autocmd FileType help nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
autocmd FileType help nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>

""" Automatic commands
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd FileType c,cpp,h,java,python,go,js,jsx,tsc,ts nested :TagbarOpen

""" QuickFix window always at the bottom
autocmd FileType qf wincmd J

""" Two space indents:
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2
autocmd Filetype js setlocal ts=2 sts=2 sw=2
autocmd Filetype jsx setlocal ts=2 sts=2 sw=2
autocmd Filetype tsc setlocal ts=2 sts=2 sw=2
autocmd Filetype ts setlocal ts=2 sts=2 sw=2
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2

""" Autoload changes in .vimrc
autocmd BufWritePost .vimrc source $MYVIMRC
cmap reloadvimrc source $MYVIMRC

" Fix editing crontab
autocmd filetype crontab setlocal nobackup nowritebackup

" Autosave folding on exit and load on open
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 

" run ncat
map <c-y>l :! eval $(cat ~/.netcat/localhost.env); envsubst < % \| sed '1,/Content-Length/d;/,0/,$d' \| tail -n+2 \| wc -c \| read NC_MM_CONTENT_LENGTH; export NC_MM_CONTENT_LENGTH; envsubst < % \| tee /dev/tty \| ~/.netcat/ncat-wrapper.sh localhost <CR>
map <c-y>s :! eval $(cat ~/.netcat/staging.env); expr `envsubst < % \| sed '1,/Content-Length/d;/,0/,$d' \| tail -n+2 \| wc -c` - 1 \| read NC_MM_CONTENT_LENGTH; export NC_MM_CONTENT_LENGTH; envsubst < % \| tee /dev/tty \| ~/.netcat/ncat-wrapper.sh staging \| tee -a ~/.netcat/logs/staging.log \| tee /dev/tty \| grep '^{.*}$' \| jq -r '.accessToken' > ~/.netcat/tokens/staging.token <CR>
map <c-y>p :! eval $(cat ~/.netcat/production.env); expr `envsubst < % \| sed '1,/Content-Length/d;/,0/,$d' \| tail -n+2 \| wc -c` - 1 \| read NC_MM_CONTENT_LENGTH; export NC_MM_CONTENT_LENGTH; envsubst < % \| tee /dev/tty \| ~/.netcat/ncat-wrapper.sh production \| tee -a ~/.netcat/logs/production.log \| tee /dev/tty \| grep '^{.*}$' \| jq -r '.accessToken' > ~/.netcat/tokens/production.token <CR>

