" Vim plug

" ============================================================================
" Vim-plug initialization

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" This needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
set rtp +=~/.vim
call plug#begin('~/.vim/plugged')

"" PLUGINS --------------------------------------------------------------------

Plug 'morhetz/gruvbox' " Colors
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] } "Loads only when opening NERDTree - F2
Plug 'pseewald/vim-anyfold' " folding c+f
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fzf
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim' " statusbar
Plug 'ervandew/supertab' " tabbing
Plug 'davidhalter/jedi-vim' " completion
Plug 'scrooloose/syntastic' " syntax
Plug 'fatih/vim-go', { 'for' : ['go', 'markdown'] } "Loads only when editing golang files
Plug 'airblade/vim-gitgutter' " Git integration.
Plug 'tpope/vim-fugitive' " Git integration.
Plug 'mrk21/yaml-vim' " Yaml syntx/indent
" Plug 'Yggdroot/indentLine'
call plug#end()

" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif


" =============================================================================



" nerdtree
" autocmd vimenter * NERDTree

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %
set number

" Show whitespace, MUST be inserted BEFORE the colorscheme command
autocmd BufWritePre * :%s/\s\+$//e
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" folding
autocmd Filetype * AnyFoldActivate "activate for all filetypes

"" GENERAL CONFIGURATION ------------------------------------------------------
" add yaml stuffs  https://lornajane.net/posts/2018/vim-settings-for-working-with-yaml
au! BufNewFile,BufReadPost *.{yaml,yml,gotmpl} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" ruby, Vagrant
au BufRead,BufNewFile *.ru,Vagrantfile setfiletype ruby
" Jenkinsfile
au BufRead,BufNewFile Jenkinsfile* setfiletype groovy


" history
set history=7000 "history
set undolevels=7000 "undo history

" tabs and spaces
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab
set smarttab

" search
set hlsearch "highlight search
set incsearch "search as your type
set ignorecase "ignore case
set smartcase

" backup files
set nobackup "no backup file
set nowritebackup "no backup file on write
set noswapfile "no swap file

" wrap
set textwidth=79 " width of document
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing

" color column
set colorcolumn=80 "color column placement
highlight ColorColumn guibg=Black
let &colorcolumn="80,".join(range(120,120),",") "second color column

" escape key responsiveness for switching modes
set timeoutlen=1000 ttimeoutlen=0

" Update sign column every quarter second
set updatetime=250

"" PLUGIN CONFIGURATION -------------------------------------------------------

" color scheme
set t_Co=256 "256 terminal colors, hard requirement for color scheme
syntax on " required
colorscheme gruvbox "color scheme
set background=dark "color scheme dark more

" folding
filetype plugin indent on " required
syntax on " required
set foldlevel=99 " Open all folds by default, set to 0 to close by default

" lightline
set laststatus=2 " status bar fix

" syntactic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']
let g:go_version_warning = 0

"" REMAPPINGS -----------------------------------------------------------------

" fzf set location to ~/repos
noremap <C-P> :Files ~/work/<CR>
" nnoremap <silent> <C-p> :FZF ~/work/<CR>

" nerdtree toggle
nmap <F2> :NERDTreeToggle ~/work/<CR>
nmap <F3> :GitGutterSignsToggle<CR>


" folding toggle
noremap <C-F> :set foldlevel=0<CR>
noremap <C-G> :set foldlevel=99<CR>

" generic quick quit
noremap <C-Q> :quit<CR>

" generic toggle line numbers
noremap <C-L> :set number!<CR>

" generic quick save
" :nmap <c-s> :w<CR>
" :imap <c-s> <Esc>:w<CR>a

" generic quick save
:nmap <c-s> :SyntasticToggleMode<CR>
:imap <c-s> <Esc>:SyntasticToggleMode<CR>a

" generic disable ex mode
noremap Q <NOP>

" Togle line wrap
:map <Leader>w :set wrap!<CR>

" Toggle filetype = yaml
:map <Leader>y :set ft=yaml<CR>
