" Vim plug

" ============================================================================
" Vim-plug initialization

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir  -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
set rtp +=~/.config/nvim
call plug#begin('~/.config/nvim/plugged')

"" PLUGINS -------------------------------------------------------------------

Plug 'morhetz/gruvbox' " Colors
Plug 'pseewald/vim-anyfold' " folding c+a | c+f/g | c+[j/]k
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " c+p | c+b
Plug 'itchyny/lightline.vim' " statusbar
Plug 'ervandew/supertab' " tabbing
Plug 'davidhalter/jedi-vim' " completion
Plug 'scrooloose/syntastic' " syntax
Plug 'fatih/vim-go', { 'for' : ['go', 'markdown'] } "Loads only when editing golang files
Plug 'airblade/vim-gitgutter' " Git integration.
Plug 'tpope/vim-fugitive' " Git integration. :0G
Plug 'mrk21/yaml-vim' " Yaml syntax/indent
Plug 'hashivim/vim-terraform' " Terraform syntax
Plug 'bling/vim-bufferline' " Show buffers
" Plug 'Yggdroot/indentLine'
call plug#end()

" Install plugins the first time nvim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" =============================================================================

" Remember last cursor position
au BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

" Automatic reloading of .vimrc
autocmd! bufwritepost .config/nvim/init.vim source %
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

" Spelling on
set spell
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
"set laststatus=2 " status bar fix

set mouse=
" Show relative file path
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" syntactic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']
let g:go_version_warning = 0

" Supertab will not add new line on completion
let g:SuperTabCrMapping=1

"" REMAPPINGS -----------------------------------------------------------------

" fzf set location to ~/flutter
noremap <C-P> :Files ~/flutter/<CR>
noremap <C-B> :Buffers <CR>
" let $FZF_DEFAULT_COMMAND = 'find "$PWD" -name ".*" -prune -o -print'
" nnoremap <silent> <C-p> :FZF ~/flutter/<CR>

" GitGutter toggle
nmap <F3> :GitGutterSignsToggle<CR>

" folding toggle
noremap <C-F> :set foldlevel=0<CR>
noremap <C-G> :set foldlevel=99<CR>

" generic toggle line numbers
noremap <C-L> :set number!<CR>

:nmap <c-s> :SyntasticToggleMode<CR>
:imap <c-s> <Esc>:SyntasticToggleMode<CR>a

" generic disable ex mode
noremap Q <NOP>

" Toggle line wrap
:map <Leader>w :set wrap!<CR>

" Toggle filetype = yaml
:map <Leader>y :set ft=yaml<CR>

