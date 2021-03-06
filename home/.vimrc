" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

"""""""""""""""""
" Color Schemes!
"""""""""""""""""
set t_Co=256
"colorscheme grb256
"colorscheme candycode
"colorscheme molokai
"colorscheme solarized
"colorscheme wombat256mod
"colorscheme xoria256
"colorscheme matrix
"colorscheme vividchalk
"colorscheme sorcerer
colorscheme jellybeans
"colorscheme lettuce
"colorscheme freya

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set nocompatible
set nobackup
set nowritebackup
set noswapfile
set autoindent
"set number
set ls=2			"Show filename at the bottom of the screen

" Highlight the line where the cursor is
set cursorline

filetype indent on
filetype on
filetype plugin on


highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

if exists('+colorcolumn')
	"execute "set colorcolumn=" . join(range(81,81), ',')
	set colorcolumn=80
	hi ColorColumn ctermbg=darkgrey guibg=lightgrey
else
	hi OverLength ctermbg=darkgrey guibg=lightgrey
	let w:m2=matchadd('Overlength', '\%>79v.\+', -1)
	au BufWinEnter * let w:m2=matchadd('Overlength', '\%>79v.\+', -1)
endif

" Source a global configuration file if available
"if filereadable("/etc/vim/vimrc.local")
"  source /etc/vim/vimrc.local
"endif

"Force spell checking depending on filetype
au FileType rst setlocal spell spelllang=en_us,el

" Only for GIT commits: Turn on spell-checking and enter insert mode at top
" lines
if has('autocmd')
	if has('spell')
		au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
	endif
	au BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggO', 't')
endif

set tags=./tags,tags,$HOME/archipelago/xseg/tags,$HOME/.vimtags
":let g:easytags_events = ['BufWritePost']

""""""""
" Tags
""""""""

" Option to disable easytags
":let g:easytags_auto_update = 0
":let g:easytags_auto_highlight = 0

""""""""""""
" Mappings
""""""""""""

" Bindings to switch between windows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Alternate bindings to switch between windows
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

nmap <F2> :TlistToggle<CR>
nmap <F3> <C-W>t
vmap <F4> d:set tw=79<ENTER>Pgq`]:set tw=0<ENTER>

" Alternate way to exit insert mode
imap jk <Esc><Right>

" Get cursor at the very end of line (i.e. at the right of the last line
" character) and enter insert mode
imap <F4> <END>
nmap <F4> i<END>


