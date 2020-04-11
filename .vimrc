" Automatically install the plugin manager if missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load plugins
call plug#begin('~/.vim/plugged')
" Productivity
""" Plug 'paulkass/jira-vim'

" Quake term
if v:version >= 801
  Plug 'bag-man/nuake'    " Quake term
endif

" CtrlP
Plug 'ctrlpvim/ctrlp.vim'

" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Git related
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'
" Plug 'mhinz/vim-signify'
Plug 'airblade/vim-gitgutter'

" Utilities
Plug 'brooth/far.vim'                   " Find and replace
Plug 'matze/vim-move'                   " Move lines up and down
Plug 'ConradIrwin/vim-bracketed-paste'  " Detect clipboard paste (auto :set paste!)
" Plug 'roxma/nvim-yarp'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'
" autocomplete window with escape
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'tpope/vim-sensible'
Plug 'sukima/xmledit'
Plug 'mboughaba/i3config.vim'
Plug 'SidOfc/mkdx'                      " Markdown plugin
Plug 'sulibo/vim-jekyll'                " Jekyll plugin
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'leafgarland/typescript-vim'
Plug 'bkad/CamelCaseMotion'
Plug 'joshdick/onedark.vim'

" Appearance
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
" Plug 'unblevable/quick-scope'         " Highlight jump characters - slows
" down vim considerably
Plug 'joshdick/onedark.vim'           " Color scheme onedark
Plug 'breuckelen/vim-resize'          " Use Ctrl+arrows to resize splits
Plug 'chrisbra/Colorizer'             " Show hex codes as colours
" Plug 'Townk/vim-autoclose' " perhaps is conflicting when closing
" Plug 'udalov/kotlin-vim'
" Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
" Plug 'Shougo/deoplete.nvim'
" Plug 'zchee/deoplete-go', { 'do': 'make' }
call plug#end()

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
set termguicolors
" supposed to fix slowness caused by vim-nerdtree-syntax-highlight
set lazyredraw
set wildignore=*/node_modules/*
" mapping for paste (so that overwriting visual selection doesn't pick up the
" overwritten text into the buffer, but just paste over it)
xnoremap p "_dP

"" Customize view
syntax on
" Sakura supports TRUECOLOR, so no need to revert to 256
" set t_Co=256
" set t_ut=
colorscheme onedark

""" lens.vim
" 120 + 4 for gutter
let g:lens#disabled = 1
let g:lens#width_resize_max = 124
" git commit, nerdtree
let g:lens#disabled_filetypes = ['nerdtree', 'fzf']

"""" Fix background (revert so that terminal's default is used)
hi! Normal ctermbg=NONE guibg=NONE
hi! Normal guifg=NONE ctermfg=NONE

"" Key remaps -----------------
nnoremap <silent> <expr> <C-S-E> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
nnoremap <silent> <expr> <F2> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
:nnoremap <F5> "=strftime("%FT%T%z")<CR>P
:inoremap <F5> <C-R>=strftime("%FT%T%z")<CR>

"" Movement and manipulation remaps
nnoremap Y y$
map H ^
map L $

:let mapleader = '\'
:nmap , \

""" Usability -----------------
"""" \s is for word substitute
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
"""" fugitive
nnoremap <C-S-A> :Git blame<CR>
let g:fugitive_summary_format = '%s (%cr) <%an>'
"""" coc.nvim
nnoremap <leader>c :CocAction<CR> 

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=250

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  :Format<CR>
nmap <leader>f  :Format<CR>
" nmap <leader>f <Plug>(coc-format-selected)
" xmap <leader>f <Plug>(coc-format-selected)
" vmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
" Disabled to make <leader>q (smart delete buffer) work faster
" nmap <leader>qf  <Plug>(coc-fix-current)

"""" Enter just selects the item in the autocomplete menu
"""" http://vim.wikia.com/wiki/VimTip1386
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
""" Map Ctrl+Space to autocomplete
""" https://coderwall.com/p/cl6cpq/vim-ctrl-space-omni-keyword-completion
" inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
"             \ "\<lt>C-n>" :
"             \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
"             \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
"             \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
" hm, what's this for: imap <C-@> <C-Space>

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Remove coc selection extension (coc-range-select) on Ctrl+I
" Because it overrides default vim C-O / C-I jump behavior
autocmd VimEnter * :unmap <C-I>

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" not enabled because it doesn't respect tsconfig ordering of imports
" autocmd BufWritePre typescript :OR

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


""" Set up :Prettier 
" command! -nargs=0 Prettier :CocCommand prettier.formatFile


"""" CamelCase motion
let g:camelcasemotion_key = '<leader>'

""" Navigation ----------------
"""" CtrlP - go to definition
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|coverage|researchtag|webBasedPortal)|(\.(swp|ico|git|svn))$'
noremap <leader>pp <ESC>:CtrlPRoot<CR>
noremap <leader>pb <ESC>:CtrlPBuffer<CR>
noremap <leader>pt <ESC>:CtrlPMRUFiles<CR>
noremap <leader>pm <ESC>:CtrlPMRUFiles<CR>
noremap <leader>m <ESC>:CtrlPMRUFiles<CR>
noremap <leader>po <ESC>:CtrlPChangeAll<CR>
noremap <leader>pgi <ESC>:CtrlPChangeAll<CR>
noremap <leader>pc <ESC>:CtrlPClearAllCaches<CR>

""" Refactoring ---------------
nmap <S-F6> <Plug>(coc-rename)

" nmap <silent> <A-7> :copen<CR><CR>
" :nnoremap <A-S-F> :vimgrep /<C-R>/g **<CR>

""" Buffers -------------------
nmap <F3> :TagbarToggle<CR>
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
"""" Delete current buffer with "\q"
nmap <leader>q <Plug>Kwbd

"" END Key remaps -------------

" Plugins ----------------------

"" Jira
let g:jiraVimDomainName = "https://gomimi.atlassian.net"
let g:jiraVimEmail = "nikola.maric@mimi.io"
let g:jiraVimToken = "vaFuZgHD0nRU22FIxIXH73A7"

"" Nuake
tnoremap <C-q> <C-w>N
tnoremap <C-\> <C-\><C-n>:Nuake<CR>
nnoremap + <C-w>3+
nnoremap _ <C-w>3-
nnoremap <C-\> :Nuake<CR>
inoremap <C-\> <C-\><C-n>:Nuake<CR>
let g:nuake_position = 'top'
let g:nuake_size = 0.2

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
" NERDTrees File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', 'black')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', 'black')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', 'black')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', 'black')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', 'black')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', 'black')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', 'black')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', 'black')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', 'black')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', 'black')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', 'black')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', 'black')
call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', 'black')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', 'black')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', 'black')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', 'black')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', 'black')
call NERDTreeHighlightFile('ts', 'green', 'none', 'green', 'black')
call NERDTreeHighlightFile('py', 'green', 'none', 'green', 'black')

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
set statusline+=%0*\ %<%f%m%r%h%w\                       " File path, modified, readonly, helpfile, preview
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %02l:%02v\ (%3p%%)\                 " Line number : column number ( percentage )
set statusline+=%=                                       " Right Side
set statusline+=%2*\ %Y\                                 " FileType
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
set statusline+=\ (%{&ff})                               " FileFormat (dos/unix..)
set statusline+=%3*│                                     " Separator
set statusline+=%0*\ %{fugitive#head()}\                 " Fugitive - git branch name
set statusline+=%3*│                                     " Separator
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}\  " The current mode

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.

" hi Directory guifg=#FF0000 ctermfg=red
" hi User1 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
" hi User2 ctermfg=007 ctermbg=236 guibg=#303030 guifg=#adadad
" hi User3 ctermfg=236 ctermbg=236 guibg=#303030 guifg=#303030
" hi User4 ctermfg=239 ctermbg=239 guibg=#4e4e4e guifg=#4e4e4e
hi PMenu guibg=#666666
hi PMenuSel guibg=#777777

" Markdown plugin
let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
                        \ 'enter': { 'shift': 1 },
                        \ 'links': { 'external': { 'enable': 1 } },
                        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                        \ 'fold': { 'enable': 1 } }
let g:polyglot_disabled = ['markdown'] " for vim-polyglot users, it loads Plasticboy's markdown
                                       " plugin which unfortunately interferes with mkdx list indentation.

" Jekyll plugin (notes)
let g:jekyll_post_extension = '.md'
let g:jekyll_draft_dirs = ['_drafts', '_source/_drafts', 'notes']

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
syntax match Comment /\%^---\_.\{-}---$/ contains=@Spell
au BufRead,BufNewFile *.http set syntax=json
au BufRead,BufNewFile *.http setlocal ts=2 sts=2 sw=2
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType json setlocal ts=2 sts=2 sw=2

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

if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif
